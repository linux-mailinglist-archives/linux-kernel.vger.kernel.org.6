Return-Path: <linux-kernel+bounces-282984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378894EB83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EDE1C2148D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34A171E6E;
	Mon, 12 Aug 2024 10:55:20 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAE170A36
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723460120; cv=none; b=ky3xGgbRY1GaLNVOKxmm6TZ/E7NvIheLtPEZghYd+Z8aWxPiareL83JpAoDVucQKsP76QwiajLgf5nxRNKeBdRdUVAZIAZMO4BPNe0XwsCcvHtXZKtZayw8smywzbSvN8Kq03uDE41IKIFjBSpkr/UX2+f6msnLcGHeusfsVG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723460120; c=relaxed/simple;
	bh=BvRoVUevOJ0OomFSjHxA7nZlXZ4x1bOUrVJguG2py/4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l6zC/kRDboUf5FI5wOpnAmZsdb1PcfT5gPMS9liUqLOWzo1QB0J6gcSnAcOioY9OWOYzoVFtHi6EzSWIA/PFdk7skkDwyZhByA1jGTV5/NsStsymGHTAuewybqkHrsCx/v4vx8lWWRHaUpJMobq24c0I/lf2gp8QrVBgCzeUasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b0bee2173so58668235ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723460118; x=1724064918;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzDkKWzUnobSuJp/iYmviwdL5fFg/qGdMDxBdxPWPng=;
        b=Ia8bprlX3/zKBGwKEdscx6ibLoYGMNhRTIowp1oKCrwKMajnj8JQhqBXQFQgMOhKFA
         TpDwT+x/LL3ofYbl2Etcjoo0PzikXYc46COTXfTpwBFPz7dHwA7KBGNcDlCag6N3NDYV
         xeM2/NyjJ5E81m/NEoY4+kJ4HNQCv+GGTod3uVnOAxNv3v/IbOuJ+MfpP5+z9+8F0+6U
         7BvF9tx1NLi3Ly+Quc84wKgT2mxEAKxD8KKvyKIERjyRdk7Dc4hVxb1fzR3TGzWgcjp8
         A2+eTumOxW0vP5Gm36qYS+EDvUjeTlOD49YtH5pXD6j+cxSA81R970nsJR11f8v1exm/
         Zxtw==
X-Forwarded-Encrypted: i=1; AJvYcCWTNFNj3nQ7/cwrqCaDIRhbduqWE1zgZqM3NTt85Vb4sKKOdpaz9XxkMqfoSRzr9C4JkUp1fSbGlw07u/6g+ktsjwOpf4TShWY+fzPU
X-Gm-Message-State: AOJu0YziRwl5msdWBxKzxHFGe3+9qeUx1Vdh1zOSGXBAmCu72lA/si9C
	OkQ4eZ6EVvgowFywu9Qqa58UtrbYyWW+6n4Ve019TEcy+mX5cf8gNF1VbhtWKEBU2LIdHoIWDaO
	oyMm7zYFaDDAI+dMNfBgWj9FYWvyjEg29a9HzdhjaffS3UWlaOS8cBBQ=
X-Google-Smtp-Source: AGHT+IFZ7Lk90NH7SoIiOuNuMbuYBh1G0cFi7XybnsTbf0SQoPW5AP7WpPVTOkOGEtxIFhgwTc2YvwaTZbOQM8YefDZOVD/jquEE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39b870aa6f5mr8954425ab.5.1723460117934; Mon, 12 Aug 2024
 03:55:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 03:55:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d44a6061f7a54ee@google.com>
Subject: [syzbot] [kernel?] WARNING in try_queue_bulk_in/usb_submit_urb
From: syzbot <syzbot+eac39cba052f2e750dbe@syzkaller.appspotmail.com>
To: arnd@arndb.de, eli.billauer@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    25f51b76f90f xhci-pci: Make xhci-pci-renesas a proper modu..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10fe0005980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=10d86428d89226d6
dashboard link: https://syzkaller.appspot.com/bug?extid=eac39cba052f2e750dbe
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1824302a322/disk-25f51b76.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f387ec15c0a/vmlinux-25f51b76.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58ba53ce9979/bzImage-25f51b76.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+eac39cba052f2e750dbe@syzkaller.appspotmail.com

usb 3-1: New USB device found, idVendor=09fb, idProduct=ebbe, bcdDevice=ea.fe
usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1: config 0 descriptor??
------------[ cut here ]------------
usb 3-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 9 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.11.0-rc1-syzkaller-00033-g25f51b76f90f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: usb_hub_wq hub_event

RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 15 eb fe fc 4c 89 ef e8 2d 21 d7 fe 45 89 e0 89 e9 4c 89 f2 48 89 c6 48 c7 c7 40 17 a0 87 e8 b6 d1 c4 fc 90 <0f> 0b 90 90 e9 e9 f8 ff ff e8 e7 ea fe fc 49 81 c4 c0 05 00 00 e9
RSP: 0018:ffffc9000009f010 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888119f18800 RCX: ffffc9000d702000
RDX: 0000000000100000 RSI: ffffffff81194cf6 RDI: 0000000000000001
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88811c1200a8 R14: ffff88812cedae80 R15: ffff888119f1887c
FS:  0000000000000000(0000) GS:ffff8881f6200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3181fffc CR3: 000000012e70c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 try_queue_bulk_in+0x3d7/0x7f0 drivers/char/xillybus/xillyusb.c:741
 xillyusb_setup_base_eps drivers/char/xillybus/xillyusb.c:1924 [inline]
 xillyusb_probe+0x47b/0x830 drivers/char/xillybus/xillyusb.c:2161
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:657
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:799
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:829
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:957
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1029
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e66/0x4f50 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

