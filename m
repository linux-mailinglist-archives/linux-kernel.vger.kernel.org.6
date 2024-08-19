Return-Path: <linux-kernel+bounces-292697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020B957327
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC58282A44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C580A1891CF;
	Mon, 19 Aug 2024 18:26:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8283B1A4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091994; cv=none; b=rGju2ZudJLzHcRVjgrxofKFWuLMvjokx2NiPwLywr8zqho/gC5tGWIJzfbNmrok2S67KiRuJ86gm+pVJM1+9NXakS/soDEUkynKlgcImkuXkxL/WW+HK3eO0265+AShl85hKrtGI4fzOVSBqAyQdjEvCE3ealsF6wqL6IB9dINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091994; c=relaxed/simple;
	bh=k05gVbLV48+n4MZ3FwDOLoVZMuARVczPh8inxca9e2Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BJWcLnZ2NRhqDvq17+AYZdT2pDWkP3QfAFno7DWa0Z48UlkNdWjreDYPA8Pe41GCiyXyp2tz8SjqRl66ncT3hO9qKMdY8YD0G45qzOQkF6NOWeHvicoZ38LqtDeRIXhoDAWYVK0Vg3bolyNSrT4tbFTzQJgZk5uD4ztL0Og6P+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37642e69d7eso41351315ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091991; x=1724696791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzuWOoK7U5eCLaCqJOf+yOYWMA4sjC86uW21bxVlKcI=;
        b=fw8YB8VlBK9vqt2tj6Iwnox9AhQqsFC18XoJPxtqzZI/YSKNt7e8/22hteV7YD3PF7
         qhiusTtpiVg8ShgdMhPLRFlXEdZ6jJzZRJUdare3pkVrg1x+1ZWJz1nZaE8xw+CORcnC
         YRdJOxB8qTE+poGI0bGYQnRolq9UpfRjlMXgpNBOuZfcdj28l5IFpTJa8PWiU+ZGvRf0
         U0tILR32rMGVUfSpZj2PZ+YJFndW30kuENQizzyHAVSfTTVhfPI9BYE7Is/TL9tsMPuw
         7XHq4eKlWl5ACA2tXabeD7SAGhBjaaiLXbogMlsYyW1QisABQtnovo6PFrMYLICNfvrM
         0/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZBCvwMN2SyAjZy6qB/CGAqVmrwajb1j4rxAI4iFB7DT6q8XYYJzqDVnIv4S+ol91InpddJi0OsKTM7h/DqLn0S2av3GHzSbWKKr7T
X-Gm-Message-State: AOJu0YxI8GXrOJf7LF1Ixb3hBItHyF/BCnWZ0MUt7MhhqBegXBUIED6z
	hcArXwvHX5r9rHp/jcvQDRO86x3PJOpqoASbT7vfLx+4wqudYCwWg1WgBEEVrSCdNb4fxaIUzxz
	k8NZLShfxPKX5IBUzmpxyOXvZnRbie+TPKoj/zPQoWeMS61MCHsKAQPY=
X-Google-Smtp-Source: AGHT+IE0W3bMrdlF7HCKmudx+ktIOg5AR0S/NJiRJpbqSoEYv411xh46VAH1DzcSY84YGH6iYJpsmYzPWjR2k+xLL2AG4N3nmjNo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39d26ce6d8emr6386415ab.2.1724091990956; Mon, 19 Aug 2024
 11:26:30 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:26:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae6c0606200d72b2@google.com>
Subject: [syzbot] [kernfs?] WARNING in kernfs_new_node (3)
From: syzbot <syzbot+306212936b13e520679d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ccfde5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=306212936b13e520679d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08587d4fbe1d/disk-1fb91896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6dd5154c5ac3/vmlinux-1fb91896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed7b9753cd9c/bzImage-1fb91896.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+306212936b13e520679d@syzkaller.appspotmail.com

usb 5-1: Direct firmware load for ueagle-atm/eagleII.fw failed with error -2
usb 5-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9066 at fs/kernfs/dir.c:526 kernfs_get fs/kernfs/dir.c:526 [inline]
WARNING: CPU: 0 PID: 9066 at fs/kernfs/dir.c:526 kernfs_new_node+0x1d8/0x240 fs/kernfs/dir.c:703
Modules linked in:
CPU: 0 UID: 0 PID: 9066 Comm: kworker/0:7 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events request_firmware_work_func
RIP: 0010:kernfs_get fs/kernfs/dir.c:526 [inline]
RIP: 0010:kernfs_new_node+0x1d8/0x240 fs/kernfs/dir.c:703
Code: 74 08 48 89 ef e8 68 34 c4 ff 48 89 5d 00 4c 89 f0 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d e9 a9 a5 b9 09 e8 09 ee 5c ff 90 <0f> 0b 90 eb a0 89 e9 80 e1 07 fe c1 38 c1 0f 8c 62 fe ff ff 48 89
RSP: 0018:ffffc90004447578 EFLAGS: 00010293
RAX: ffffffff82369b67 RBX: ffff88806b7c1870 RCX: ffff888029df5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82369b04 R09: 1ffff1100d6f830e
R10: dffffc0000000000 R11: ffffed100d6f830f R12: 00000000000041ed
R13: 0000000000000000 R14: ffff888067d74780 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffedb7a2d4c CR3: 000000005a9c8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kernfs_create_dir_ns+0x43/0x120 fs/kernfs/dir.c:1061
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 class_dir_create_and_add drivers/base/core.c:3225 [inline]
 get_device_parent+0x391/0x410 drivers/base/core.c:3276
 device_add+0x325/0xbf0 drivers/base/core.c:3606
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

