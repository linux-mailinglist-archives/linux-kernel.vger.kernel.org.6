Return-Path: <linux-kernel+bounces-362557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B61D99B652
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F072829FF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67691824AD;
	Sat, 12 Oct 2024 17:33:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDD1EA65
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754419; cv=none; b=YwXgGJuzu6NHuPNTTN4vd0l8zgB8Qk7pmKvU5q4Pee6LFGXj4XsCJfVELkGm+EuxDlmMVH0JYrKhVBQBnw/SMx70g6dvFXBlsEQAx4KWXxSCoyHPdHKoVDLlNtPAHNq1r4wA4LRFFLjTsYiSurwxnhzpzFjMMAfrBjt6UeYyOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754419; c=relaxed/simple;
	bh=BdPpEz1+LwShG01S9jRy6D3vnbX97mwYCqPb827qrGo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZZeW4MnWGIgoH/Adg8itwqjfXoQ0AH40TI5WmTd9+L7mFyefPjgXffTMTO+Q7uOOBsjAm79os1QAD70gpTGwSc6tSFJjmRJxMVneNgv6ztVV5xycG3Kk/FAiAjtzEk6UIC4WuNf21veFZsbLfmCh/5dE/IZHURzO5govni6o8lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so13840445ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 10:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754416; x=1729359216;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nKc66xB1p/lu4gxwQnfJAp3Uc72VEJNNG3sevaO4A8=;
        b=vmXlcMpm5xBUA4sHkzxC6GM8PeN9WQsAQFE18JGXFkVdRvNAoY5QZl3gEnAbrgQq4a
         /ZUcREa61bCznmWZLIPB9bpLN0ryl20hJWCGy6l18i11SIWUrVb5PjBkUD1pvxbA28lC
         /BNdFjjI5QDiGgdjzEpM60DYDtEXhttxEXP7yI0Ih9NOAvC1IG29booxWCOy9Yx6WtP8
         TTfFstNo+aNpIT6+yENy3TH2Ip9lbwS/9JIW2aUP7BizPIniKFABcvWIfE/L2IXAfJpR
         gKhTtbs3+KjdpF4+aUXbfYIr4QT+3SZJ90f0OFrIt8v5wNfAMkNXU2Xpn5/p6TZjA9Hj
         RQjg==
X-Forwarded-Encrypted: i=1; AJvYcCUXcQJ5QqMGStgXdwcp/2mtDcWpIYFcPN/6pVWp98CqblFhEs/8gfVOd7aAKGgAQQ24osCaiu+ukZPKtIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBprUhHp6BwIFMRuL4VwX+FFdxFraIiDsHY7B/o2LGwPhgSWQe
	il28z27cYiNcAeP9/gN3DIRV+NeUuCoy8oppTMJ0OhesEEHstyn36DnBM6RpbhxV2Jeocb+N/qu
	NoaDhT8D7H51HM1vpI8QXNAhYfbe9X3IPERZM8euNR9ujkKCLcQVbbk8=
X-Google-Smtp-Source: AGHT+IEgM47antoQ2MP+/lacEC6Rid4V4WacHqt2Rs5KOmCpuhJ1Ut7JiVFD5EJZdCQTMw1450b3FTjq0rDXsFJLU2krmq2IrHcO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a3b5f86635mr50464865ab.7.1728754416482; Sat, 12 Oct 2024
 10:33:36 -0700 (PDT)
Date: Sat, 12 Oct 2024 10:33:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ab2f0.050a0220.4cbc0.0025.GAE@google.com>
Subject: [syzbot] [usb?] WARNING in thrustmaster_probe/usb_submit_urb
From: syzbot <syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13fe4f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=040e8b3db6a96908d470
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c87707980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cf6327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/883c5319cb52/disk-4a9fe2a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4421ed2ef/vmlinux-4a9fe2a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8e3beb01d49/bzImage-4a9fe2a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=044f, idProduct=b65d, bcdDevice= 0.00
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
hid-thrustmaster 0003:044F:B65D.0001: hidraw0: USB HID v0.00 Device [HID 044f:b65d] on usb-dummy_hcd.0-1/input0
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 9 at drivers/usb/core/urb.c:503 usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc1-syzkaller-00027-g4a9fe2a8ac53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0xe4b/0x1730 drivers/usb/core/urb.c:503
Code: 84 3c 02 00 00 e8 05 9f f6 fc 4c 89 ef e8 0d 51 d6 fe 45 89 e0 89 e9 4c 89 f2 48 89 c6 48 c7 c7 60 1d a1 87 e8 86 69 bb fc 90 <0f> 0b 90 90 e9 e9 f8 ff ff e8 d7 9e f6 fc 49 81 c4 b8 05 00 00 e9
RSP: 0018:ffffc9000009e9d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888111862400 RCX: ffffffff811ab159
RDX: ffff888101698000 RSI: ffffffff811ab166 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
R13: ffff888100fef0a8 R14: ffff88811033bda0 R15: ffff88811186247c
FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558fc0629bd8 CR3: 0000000112ada000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x103/0x4c0 drivers/usb/core/message.c:59
 usb_bulk_msg+0x22c/0x550 drivers/usb/core/message.c:388
 thrustmaster_interrupts drivers/hid/hid-thrustmaster.c:176 [inline]
 thrustmaster_probe drivers/hid/hid-thrustmaster.c:339 [inline]
 thrustmaster_probe+0x713/0xd50 drivers/hid/hid-thrustmaster.c:281
 __hid_device_probe drivers/hid/hid-core.c:2699 [inline]
 hid_device_probe+0x2eb/0x490 drivers/hid/hid-core.c:2736
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 hid_add_device+0x37f/0xa70 drivers/hid/hid-core.c:2882
 usbhid_probe+0xd3b/0x1410 drivers/hid/usbhid/hid-core.c:1431
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:459
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:534
 device_add+0x114b/0x1a70 drivers/base/core.c:3675
 usb_new_device+0xd90/0x1a10 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2e58/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

