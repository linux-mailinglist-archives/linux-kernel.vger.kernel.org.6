Return-Path: <linux-kernel+bounces-231214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102499187BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412021C21C63
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882F18FDA7;
	Wed, 26 Jun 2024 16:44:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587E18F2E1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420247; cv=none; b=WPkV73HF2ZeNfO2v1iB9oEaN5JqrX9A1T2m0hh72C2IWGPUFZHLqfCzQs02i/hnV+IzE8xAhT2Ab8A1kCNlJKhrc2g8PQfP9XUQn9v1AhpHNp+ggSM4g1/VEW5Sm2QiMvjEdurtZXosxvEs9bgLnIa7SfBhsYs8c/IPlc5sRZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420247; c=relaxed/simple;
	bh=i2HhrJu+f00NMOiApxp2TBALSE/2IGKOYZHtHhvVe9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kSZYoNCgL4kiRxnfq+sYlzdHgYPquchJFGRTLBNloh2wyHtbVHUOUPzeECrVtPvSkaS8v4/+t5gRXR8YSvXoIF+0a+g4z/ce0YwL9+MiadMYfHXi+BzEOhlXcNokzEJoHY3V4mHllNnw7wK+BfEmrevLWAYy2O7D5rl4sMQOuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb84511dbfso893452739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420245; x=1720025045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gpscJH4jSbJKWt3h1G8JLIQGkiNocoueoaYePHWuPs=;
        b=MLiobnis5CyK/iaOrFP6mX/XcfMWNtyBJeZeJFudhkaVIymTNgtmdcdok151jqx4Z7
         nLDphh7QQzllpAXo1suGXHVi7C1HpPnYQBwLJR8anUpjGvAu4n71Je2OrILhvvG6790e
         A8bmuBbM8zyr80sJxf82mQjseKy8EZC8Jveo5YK02scAMNopZnE5hM1feRVm/2AQCr0v
         VSkBo9iBMJFQQAl4tsGuGmASpvIE2C98v9+Q5urT+LMTycPRSXBPjoJjPMUyx8ywctVT
         /R9vWWrleTL2K4GjAeJr/m0wb0nCipWS22Fbxe+uYQVs0xhNim1/dAwJtVex+B2VekLP
         5WOg==
X-Forwarded-Encrypted: i=1; AJvYcCVqXiVzBDU9QKiT4JnSx6GH3MP+y/v8AJ2u7Djo2EMP0VInSvdQUsihZEhHWCRCiYDCqgNdgcO1tzcFMjJJlOr7G6nrqK3H5GB7MBnB
X-Gm-Message-State: AOJu0YzAbKuIJY2Kjq5PHkXz5EbSLB++F+e1OpIKTFp2n23X57InBtoA
	L168ez1w1mQrwBfDoroI23GGYpGOBGTQYrqdxlpYStz6gVwQx8tB51Rn6do5uYeemOnAlFj7Q9L
	Bue54nqF79nb+3RCpjlBraoZH2oe83iCdUMnptT1ZuLbaGYMHDE2oly4=
X-Google-Smtp-Source: AGHT+IGyfXq3VobGnQcA3fF0g9Hu3/ixTAGpM8s9AlCUJsAuBqvHBgf4zBFJ6jVp9GIlKvTZYQBbbsQymEiCEK+BuziYaL7S+PFZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1503:b0:7eb:d640:263 with SMTP id
 ca18e2360f4ac-7f3a4f758bfmr19109439f.3.1719420243586; Wed, 26 Jun 2024
 09:44:03 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:44:03 -0700
In-Reply-To: <a6eb3c4e-411f-4fbf-a85c-f3435170341d@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6c39d061bcdb82c@google.com>
Subject: Re: [syzbot] [usb?] [bluetooth?] WARNING in btusb_submit_intr_urb/usb_submit_urb
From: syzbot <syzbot+8693a0bb9c10b554272a@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in btusb_submit_intr_urb/usb_submit_urb

btusb 1-1:0.0: Pipe 404d8280 ep ffff8880234bee00
usb 1-1: Error pipe 404d8280 ep ffff8880234beea0 epaddr 8b
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 53 at drivers/usb/core/urb.c:507 usb_submit_urb+0xbfa/0x17e0 drivers/usb/core/urb.c:506
Modules linked in:
CPU: 1 PID: 53 Comm: kworker/u9:0 Not tainted 6.10.0-rc4-syzkaller-00164-g66cc544fd75c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_power_on
RIP: 0010:usb_submit_urb+0xbfa/0x17e0 drivers/usb/core/urb.c:506
Code: f0 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 8c 08 00 00 45 8b 06 48 c7 c7 c0 90 6d 8c 48 8b 34 24 4c 89 fa 89 e9 e8 a7 99 3c fa 90 <0f> 0b 90 90 45 89 e6 4c 89 f7 48 c7 c6 b0 4b f2 8e e8 10 6f 7a fa
RSP: 0018:ffffc90000bd77a0 EFLAGS: 00010246
RAX: 7b355395d6059e00 RBX: dffffc0000000000 RCX: ffff8880157d5a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff81585822 R09: 1ffff9200017ae94
R10: dffffc0000000000 R11: fffff5200017ae95 R12: 0000000000000002
R13: ffff888018acd300 R14: ffffffff8c6d8e68 R15: ffff888023a90c60
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055da0d81ae28 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btusb_submit_intr_urb+0x4a2/0x890 drivers/bluetooth/btusb.c:1410
 btusb_open+0x1a1/0x770 drivers/bluetooth/btusb.c:1866
 hci_dev_open_sync+0x2cc/0x2b40 net/bluetooth/hci_sync.c:4889
 hci_dev_do_open net/bluetooth/hci_core.c:485 [inline]
 hci_power_on+0x1c7/0x6b0 net/bluetooth/hci_core.c:1012
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         66cc544f Merge tag 'dmaengine-fix-6.10' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1503e301980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
dashboard link: https://syzkaller.appspot.com/bug?extid=8693a0bb9c10b554272a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ec9e82980000


