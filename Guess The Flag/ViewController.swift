//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Yohannes Wijaya on 7/31/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        for (_, flag) in [self.flag1Button, self.flag2Button, self.flag3Button].enumerate() {
            flag.layer.borderWidth = 3.0
            flag.layer.borderColor = UIColor(hue: 0.92, saturation: 1.00, brightness: 0.91, alpha: 1.0).CGColor
        }
        self.countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        self.askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Stored properties
    
    var countries = [String]()
    var score = Int()
    let maxNumberOfAnswers = 3
    var correctAnswer = Int()

    // MARK: - IBOutlet properties
    
    @IBOutlet weak var flag1Button: UIButton!
    /*
    {
        didSet {
            self.flag1Button.layer.borderWidth = 1.0
            self.flag1Button.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
    }
    */
    @IBOutlet weak var flag2Button: UIButton!
    @IBOutlet weak var flag3Button: UIButton!
    
    // MARK: - IBOutlet actions
    
    @IBAction func flag1ButtonTouched(sender: UIButton) {
        var title: String?
        if sender.tag == self.correctAnswer {
            ++self.score
            title = "Correct"
        }
        else {
            --self.score
            title = "Incorrect"
        }
        let alertController = UIAlertController(title: title!, message: "Your score is \(self.score)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.Default, handler: askQuestion))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    

    // MARK: - Local methods
    
    func askQuestion(action: UIAlertAction! = nil) {
        self.countries.shuffle()
        let flags: [UIButton] = [self.flag1Button, self.flag2Button, self.flag3Button]
        for (index, flag) in flags.enumerate() {
            flag.setImage(UIImage(named: self.countries[index]), forState: UIControlState.Normal)
        }
        self.correctAnswer = Int(arc4random_uniform(UInt32(self.maxNumberOfAnswers)))
        self.title = self.countries[self.correctAnswer].uppercaseString
    }
}

