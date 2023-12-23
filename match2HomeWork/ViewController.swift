//
//  ViewController.swift
//  match2HomeWork
//
//  Created by Madina Olzhabek on 21.12.2023.
//

import UIKit

class ViewController: UIViewController {
    var arrayOfPictures = [UIImage(named: "хз"), UIImage(named: "коала"),UIImage(named: "лошадь"),UIImage(named: "лошадь"), UIImage(named: "обезьяна"), UIImage(named: "жираф"), UIImage(named: "панда"), UIImage(named: "страус"), UIImage(named: "панда"), UIImage(named: "собака"), UIImage(named: "страус"), UIImage(named: "собака"), UIImage(named: "жираф"), UIImage(named: "коала"), UIImage(named: "обезьяна"), UIImage(named: "хз")]
    var lastOpenedImage = 0
    var isOpen = false
    var state = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var timer = Timer()
    var time = 0
    var senderTag = 0
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonImage(_ sender: UIButton) {
        print(sender.tag)
        senderTag = sender.tag
        
         isOpen = !isOpen
        if isOpen{
            lastOpenedImage = sender.tag
            sender.setBackgroundImage(arrayOfPictures[sender.tag - 1], for: .normal)
            return
        }
        
        if state[sender.tag - 1] == false{
            sender.setBackgroundImage(arrayOfPictures[sender.tag - 1], for: .normal)
            
            if arrayOfPictures[lastOpenedImage - 1] == arrayOfPictures[sender.tag - 1]{
                view.isUserInteractionEnabled = false
                state[lastOpenedImage - 1] = true
                state[sender.tag - 1] = true
                count += 2
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun2), userInfo: nil, repeats: true)
// создала два таймера,т.к когда тыкаешь на две одинаковые картинки, пользователь может паралельно открывать другие картинки
                
            }else{
                view.isUserInteractionEnabled = false
                
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
                
            }
            
            if count == 16{
                let alert = UIAlertController(title: "Поздравляю!", message: "Ты выиграл!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                    self.clear()
                }))
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    func clear(){
        for i in 1...16{
            let button = view.viewWithTag(i) as! UIButton
            button.setBackgroundImage(UIImage(named: "ромашка"), for: .normal)
            state[i-1] = false
            count = 0
        }
    }
    
    @objc func timerRun(){
        time += 1
        if time == 1{
            timer.invalidate()
            let button = view.viewWithTag(lastOpenedImage) as! UIButton
            let sender = view.viewWithTag(senderTag) as! UIButton
            button.setBackgroundImage(UIImage(named: "ромашка"), for: .normal)
            sender.setBackgroundImage(UIImage(named: "ромашка"), for: .normal)
            view.isUserInteractionEnabled = true
            time = 0
        }
        
    }
  @objc  func timerRun2(){
        time += 1
        if time == 1{
            timer.invalidate()
            view.isUserInteractionEnabled = true
            time = 0
        }
    }
    
}
