//
//  WCAViewController.m
//  WCAJudgeTImer
//
//  Created by Weston Mizumoto on 8/29/14.
//  Copyright (c) 2014 Weston Mizumoto. All rights reserved.
//

#import "WCAViewController.h"

@interface WCAViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopResetButton;
@property (strong, nonatomic) NSString *startButtonState;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property NSInteger counter;
@property (strong, nonatomic) NSTimer *timer;
@property BOOL timerIsCounting;
@end

@implementation WCAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.startButtonState = @"ready";
    self.counter = 0;
    self.timerIsCounting = NO;
}
- (IBAction)startButtonPressed:(id)sender {
    if(self.timerIsCounting == NO){
        self.startButton.backgroundColor = [UIColor grayColor];
    }
    if(self.timerIsCounting == YES){
        [self resetButtonHandler:nil];
    }

}
- (IBAction)buttonReleaseHandler:(id)sender {
    if([self.startButtonState isEqualToString:@"ready"]){
        self.startButton.backgroundColor = [UIColor greenColor];
        [self.startButton setTitle:[NSString stringWithFormat:@"%d",[self counter]] forState:UIControlStateNormal];
        [self startCountdown];
    }
}
- (IBAction)resetButtonHandler:(id)sender {
    if(self.timerIsCounting == YES){
        [self.startButton setUserInteractionEnabled:NO];
        self.timerIsCounting = NO;
        [self.timer invalidate];
       // [self.stopResetButton setTitle:@"Reset" forState:UIControlStateNormal];
    }else{
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        self.counter = 0;
        self.startButtonState = @"ready";
        self.startButton.backgroundColor = [UIColor lightGrayColor];
        self.messageLabel.text = @"";
        //[self.stopResetButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.startButton setUserInteractionEnabled:YES];

    }
    
}

-(void)startCountdown{
    self.timerIsCounting = YES;
    self.startButtonState = @"counting";
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateDisplay )userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer: self.timer forMode: NSDefaultRunLoopMode];
    
}
-(void)updateDisplay{
    self.counter++;
    [self.startButton setTitle:[NSString stringWithFormat:@"%d",[self counter]] forState:UIControlStateNormal];
    if(self.counter == 17){
        self.messageLabel.text = @"DNF";
        [self resetButtonHandler:nil];
    }if(self.counter == 15){
        self.startButton.backgroundColor = [UIColor yellowColor];
        self.messageLabel.text = @"+2";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
