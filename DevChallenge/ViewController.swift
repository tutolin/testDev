//
//  ViewController.swift
//  DevChallenge
//
//  Created by OZE-Shadrach on 12/8/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  

    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    var users:[ResponseModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.frame
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.dataSource = self
        tableView.delegate = self
        
        if let vcUrl = URL(string:"https://jsonplaceholder.typicode.com/users") {
            
            let request = URLRequest(url: vcUrl)
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request) { (data, response, error) in
            
            
            if let data = try? JSONDecoder().decode([ResponseModel].self, from: data!){
                     
                self.users = data
                     
            } else {
                return
                 }
                DispatchQueue.main.async {
            self.tableView.reloadData()
                }

             }
            task.resume()

            
        }

        }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = users[indexPath.row].website
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

}

