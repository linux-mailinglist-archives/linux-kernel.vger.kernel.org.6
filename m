Return-Path: <linux-kernel+bounces-523007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AADA3D0F0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA1DD1884CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A91F130B;
	Thu, 20 Feb 2025 05:36:27 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5801F1513
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029786; cv=none; b=eCtz39jM7LO1ot5UwIt6hVbMj3Uu0uIXPXrjTImXXtCblQxoHefCc+OzqJETrVCJcdnDQ32rUALI8j+/W8CH6e2+/bEPt+bBxms4WHolc/ZoPQxXYfqDftKtuHD/edXHS1kYLaYj6rdtI1fTldExNX5EV4of8Th7WOUhxdQRIBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029786; c=relaxed/simple;
	bh=86RSQWT0uVYy4scXIZ9dM43r6v/ZNArLrqQm7EBIK1U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p5m5XoWR//Xwg6kpxQkZkqW1omuIcKoMuCI2psW/MOk6e5kMmaBnRzQNqX0I/tqc0D4qGQQxmYJQYmA/J0afvF8iTxLH3obYMcpqhDeD3l4+2638GK5B1kX0lUkfXRyibC/2LtscO0br2igbWO2GZoKZ5jkx+YJw3irR5m68MdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-85592464231so42976739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740029784; x=1740634584;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYhZ/2V7h65SbZlesbaNdyANplft1cKNDYa6w4+fdR8=;
        b=KdQSVNJvUgOlCd0Px1leMfKuNAO/2u60OuxwwWvsOOcQDJwd8dcDfswqh+tUu3PjQ1
         E9IeNfY21wQ3YQqLFf41YWgbzLTigDCkYw6eaPtZDFTEp38jcuYAeF98MPTTZPuZFDuW
         vcnH2awwJnUGHn7vJ810rqIcqYc5ozoJRiDCDHkKx3FRWHyrQeEHEe3PRCkttgJRTWkd
         zQNlyVp07TIhczf6JmEitgLP5x/tZaHV0HIWnvNPsizbtxprWadiNldBvxWlTJ92ve+O
         T0z/84czTzSr9wwvfXZFwpvKpQq3iZip6TaZa+zl1AMNo1GoymdUh/lLj+k0dbfoY661
         cBAg==
X-Forwarded-Encrypted: i=1; AJvYcCXsCEnoJN9AC/kKHKNAuFGfFm1NnfMAx7LMODYvYe55xtGG+Z6WlvIBIO0dRfhilOgp+d2ta/vjV3bc2Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrPfm5MGKDgkEn7Nc/7RvaaoJ2RL+K6hJTqO2qkJ5XiWstxZ1
	hXfWsRAVuCbVZh1puB9GAHbFiNJf+gHkBvP79hU08vPCXXZj2x5TCUuCAO3pscGfELHPybfudkC
	uZDC8utG0FgQtGQgQ2tll6Ko6cDT2azUHXWF6pC8MhdXeOXr2ozCSciA=
X-Google-Smtp-Source: AGHT+IF4SSsRXK5FDcjsQWUM747QTtBlCp47gNgaJCN2Yefw0KribdmuVD8q4lBmQ5pjuT3IFtzI3ScPnrrZpwKJa5/M6oPVpgKC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d2bac3b647mr39160245ab.4.1740029783936; Wed, 19 Feb 2025
 21:36:23 -0800 (PST)
Date: Wed, 19 Feb 2025 21:36:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b6bf57.050a0220.14d86d.015b.GAE@google.com>
Subject: [syzbot] [usb?] BUG: corrupted list in usb_hcd_link_urb_to_ep (4)
From: syzbot <syzbot+a2e67807a84a561c08fb@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    87a132e73910 Merge tag 'mm-hotfixes-stable-2025-02-19-17-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169c2ba4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4f6914bcba459be
dashboard link: https://syzkaller.appspot.com/bug?extid=a2e67807a84a561c08fb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c59498580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-87a132e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5894cc33e97/vmlinux-87a132e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1830194f2698/bzImage-87a132e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2e67807a84a561c08fb@syzkaller.appspotmail.com

list_add double add: new=ffff8880333c4718, prev=ffff8880333c4718, next=ffff88804b2fe070.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:35!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 68 Comm: kworker/u32:3 Not tainted 6.14.0-rc3-syzkaller-00079-g87a132e73910 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__list_add_valid_or_report+0x143/0x190 lib/list_debug.c:35
Code: 89 f1 48 c7 c7 80 56 d3 8b 48 89 ee e8 66 8a cf fc 90 0f 0b 48 89 f2 48 89 e9 4c 89 e6 48 c7 c7 00 57 d3 8b e8 4e 8a cf fc 90 <0f> 0b 48 89 f7 48 89 34 24 e8 ef 51 53 fd 48 8b 34 24 e9 07 ff ff
RSP: 0018:ffffc90000658910 EFLAGS: 00010086
RAX: 0000000000000058 RBX: ffff8880333c4700 RCX: ffffffff819943d9
RDX: 0000000000000000 RSI: ffffffff8199a74e RDI: 0000000000000005
RBP: ffff88804b2fe070 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000104 R11: ffffffff96261ff8 R12: ffff8880333c4718
R13: ffff88804b2fe078 R14: ffff8880333c4718 R15: ffff88804b2fe078
FS:  0000000000000000(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c8f0f403d8 CR3: 000000002c20a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add_tail include/linux/list.h:183 [inline]
 usb_hcd_link_urb_to_ep+0x21d/0x390 drivers/usb/core/hcd.c:1158
 dummy_urb_enqueue+0x291/0x8e0 drivers/usb/gadget/udc/dummy_hcd.c:1288
 usb_hcd_submit_urb+0x258/0x1c60 drivers/usb/core/hcd.c:1533
 usb_submit_urb+0x87c/0x1730 drivers/usb/core/urb.c:581
 cm109_submit_buzz_toggle+0xd8/0x180 drivers/input/misc/cm109.c:351
 cm109_toggle_buzzer_async+0x90/0xa0 drivers/input/misc/cm109.c:484
 cm109_input_ev+0x171/0x1b0 drivers/input/misc/cm109.c:615
 input_event_dispose drivers/input/input.c:321 [inline]
 input_handle_event+0x14e/0x14d0 drivers/input/input.c:369
 input_inject_event+0x1c8/0x380 drivers/input/input.c:423
 kd_sound_helper+0x17a/0x280 drivers/tty/vt/keyboard.c:256
 input_handler_for_each_handle+0xd4/0x250 drivers/input/input.c:2554
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers+0x6e8/0x930 kernel/time/timer.c:2414
 __run_timer_base kernel/time/timer.c:2426 [inline]
 __run_timer_base kernel/time/timer.c:2418 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2435
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2445
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lockdep_unregister_key+0x1b2/0x2b0 kernel/locking/lockdep.c:6595
Code: 54 fd ff ff 48 89 df e8 9c c3 ff ff 89 c3 e8 05 d9 ff ff 9c 58 f6 c4 02 0f 85 92 00 00 00 41 f7 c5 00 02 00 00 74 01 fb 84 db <75> 4f 5b 5d 41 5c 41 5d 41 5e 41 5f e9 cd 99 0a 00 48 c7 c0 34 82
RSP: 0018:ffffc90000d5f7c0 EFLAGS: 00000246
RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8b6cef60 RDI: ffffffff8bd35480
RBP: ffff888030eb7a98 R08: ffffffff9386d86e R09: 000000000001d777
R10: ffffffff96e83eaf R11: 0000000000002ba2 R12: 0000000000000000
R13: 0000000000000246 R14: ffffffff97056128 R15: ffff888030eb7aa0
 __qdisc_destroy+0x11a/0x4b0 net/sched/sch_generic.c:1080
 qdisc_put+0xab/0xe0 net/sched/sch_generic.c:1106
 shutdown_scheduler_queue+0xa5/0x160 net/sched/sch_generic.c:1159
 netdev_for_each_tx_queue include/linux/netdevice.h:2590 [inline]
 dev_shutdown+0xad/0x430 net/sched/sch_generic.c:1491
 unregister_netdevice_many_notify+0x9fb/0x1f30 net/core/dev.c:11791
 unregister_netdevice_many net/core/dev.c:11866 [inline]
 default_device_exit_batch+0x867/0xae0 net/core/dev.c:12351
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
 cleanup_net+0x5c6/0xbf0 net/core/net_namespace.c:652
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid_or_report+0x143/0x190 lib/list_debug.c:35
Code: 89 f1 48 c7 c7 80 56 d3 8b 48 89 ee e8 66 8a cf fc 90 0f 0b 48 89 f2 48 89 e9 4c 89 e6 48 c7 c7 00 57 d3 8b e8 4e 8a cf fc 90 <0f> 0b 48 89 f7 48 89 34 24 e8 ef 51 53 fd 48 8b 34 24 e9 07 ff ff
RSP: 0018:ffffc90000658910 EFLAGS: 00010086
RAX: 0000000000000058 RBX: ffff8880333c4700 RCX: ffffffff819943d9
RDX: 0000000000000000 RSI: ffffffff8199a74e RDI: 0000000000000005
RBP: ffff88804b2fe070 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000104 R11: ffffffff96261ff8 R12: ffff8880333c4718
R13: ffff88804b2fe078 R14: ffff8880333c4718 R15: ffff88804b2fe078
FS:  0000000000000000(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c8f0f403d8 CR3: 000000002c20a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	48 89 df             	mov    %rbx,%rdi
   3:	e8 9c c3 ff ff       	call   0xffffc3a4
   8:	89 c3                	mov    %eax,%ebx
   a:	e8 05 d9 ff ff       	call   0xffffd914
   f:	9c                   	pushf
  10:	58                   	pop    %rax
  11:	f6 c4 02             	test   $0x2,%ah
  14:	0f 85 92 00 00 00    	jne    0xac
  1a:	41 f7 c5 00 02 00 00 	test   $0x200,%r13d
  21:	74 01                	je     0x24
  23:	fb                   	sti
  24:	84 db                	test   %bl,%bl
* 26:	75 4f                	jne    0x77 <-- trapping instruction
  28:	5b                   	pop    %rbx
  29:	5d                   	pop    %rbp
  2a:	41 5c                	pop    %r12
  2c:	41 5d                	pop    %r13
  2e:	41 5e                	pop    %r14
  30:	41 5f                	pop    %r15
  32:	e9 cd 99 0a 00       	jmp    0xa9a04
  37:	48                   	rex.W
  38:	c7                   	.byte 0xc7
  39:	c0                   	.byte 0xc0
  3a:	34 82                	xor    $0x82,%al


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

