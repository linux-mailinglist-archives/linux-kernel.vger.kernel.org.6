Return-Path: <linux-kernel+bounces-335258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88A97E32C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB491C20E35
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C5336124;
	Sun, 22 Sep 2024 20:17:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAB47A4C
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727036245; cv=none; b=PMpsjJiyEVVofNJEq36dsx9xSb8JxHp8nnf+2BRd01F9No8Dikx7ajk45H0G5XH4+ROrhhzcyP97qyWq1wgBDzNLM8kx2UzKUg0fZrIMNjWCnWXKfewWvzLRQ6GilnOqAAxGtg9BFAwBmT25ZjdpAdf32TUFrfX5WvnUXKz5JhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727036245; c=relaxed/simple;
	bh=6Gq6FMNGhVRJcJNdMGeiJ3QpZZI0unh9AtuOTe2I2ho=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ayqkdox7IYqmEAwXYbCOpDomsuxm6i+1rbNB/cCVaTZeMD2uAVv+KjW3Gm4qoow9/Mg5CEtDsV3ilnHX/G2nRNyoFUFqxBGBMS1YQTdrIfXX1C3nrYbP/flqVRkfoBg8Av94n6NlbszaNxXKrro5oz7ECLcOWZ+Rtuw85MmDMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so55846845ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727036243; x=1727641043;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdATAVa9J7s65RWPAZCyGvHjsAIJZ7X6vp43PLJ+GCk=;
        b=cmQ6PAQQYHkRasl30+XoFGui6MjrR4XB/jWkVmwh3VoV7lo8EXQ9y/DaWwlPy19PFK
         LeiPdmp2I5ejyFkatxI/q78V31XocmLmmqZeAsgTwbpw9FdR6en0D94J0BwUwCzmYeZu
         EHOyzUpS8hXmoUEDNYiiL/uL/+3gT+iY6IHub3OW7S2sTBNSAEr4U2eEe+fCGxbvWj06
         gRyZ5oqWRE7Wsh2pEufpObC4/kgLSL0U3ffSck4dGy5C37JyDN8IWVyfmIGAIWDFkFM0
         5l5pxVCzhQEXaE9hJdyuH9+FcDcXUrc0LaceA3ZP9az0sCJGzHUDMfHGni0lGrzx038G
         6/8g==
X-Forwarded-Encrypted: i=1; AJvYcCWTj6BW68F+BmdVE/lxROoFOLOkauAcEw87FvNyxEivTaRHb8R7Z3qws2ZhZN/+dcL0a74Ypq+xGHJpRXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpYq++IlL6JmMtVMjjlZc0UFlSsVcgCrxjHG4gXPteZqcOgPj
	Ag+d6uqSH9wkbYCSPCCmvjLN11WDK7/vpWlscG4DnX7+eR0EZKPHtus4KqBeWRTx5XlXpHjSzlQ
	NjyqE4W8Qdsw/HYaYn9XrpXcR8HFd+R/27oJkJMq1uIdbf6ytx+p88lQ=
X-Google-Smtp-Source: AGHT+IGobbhwA7YSZMa1YNCnJzhDrEnac3ZikdmMZoMGXthpDBjAzHsK2E/3sd/D2UBC+M0Xzm4Bgemvri5U9SttOpMEJ0Vlv6O2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b751:0:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a0c8d25d69mr59286805ab.20.1727036243160; Sun, 22 Sep 2024
 13:17:23 -0700 (PDT)
Date: Sun, 22 Sep 2024 13:17:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f07b53.050a0220.1b7b75.000b.GAE@google.com>
Subject: [syzbot] [usb?] INFO: task hung in yurex_write
From: syzbot <syzbot+374567c80a3d41c46ccd@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1691c19f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=374567c80a3d41c46ccd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c69290425359/disk-68d42091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/caf4f26a3e85/vmlinux-68d42091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3acdec4b62e6/bzImage-68d42091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+374567c80a3d41c46ccd@syzkaller.appspotmail.com

INFO: task syz.2.6783:32592 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.6783      state:D stack:28992 pid:32592 tgid:32564 ppid:28488  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 yurex_write+0x17f/0x940 drivers/usb/misc/yurex.c:447
 vfs_write+0x29a/0x1140 fs/read_write.c:588
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf0cf5def9
RSP: 002b:00007fdf0bb8f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdf0d116130 RCX: 00007fdf0cf5def9
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000005
RBP: 00007fdf0cfd0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fdf0d116130 R15: 00007ffe84cb2758
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_preempt/16:
 #0: ffff8881f593d718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:560 [inline]
 #0: ffff8881f593d718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
 #0: ffff8881f593d718 (&rq->__lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1714 [inline]
 #0: ffff8881f593d718 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x28e/0x2f80 kernel/sched/core.c:6436
1 lock held by khungtaskd/30:
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff88ebb660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6626
3 locks held by kworker/1:2/806:
 #0: ffff888105ebad48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90001bcfd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888109736190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888109736190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
2 locks held by getty/2605:
 #0: ffff888106bf70a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
5 locks held by kworker/1:3/13827:
 #0: ffff888105ebad48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000fa77d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8881097cd190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff8881097cd190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff88811b80a190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff88811b80a190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
 #4: ffff88811baf0160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88811baf0160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1004
5 locks held by kworker/1:0/22439:
 #0: ffff888105ebad48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc9000737fd80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff8881097b5190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff8881097b5190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f40 drivers/usb/core/hub.c:5849
 #3: ffff888132605190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888132605190 (&dev->mutex){....}-{3:3}, at: usb_disconnect+0x10a/0x920 drivers/usb/core/hub.c:2295
 #4: ffff8881196b0160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff8881196b0160 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1094 [inline]
 #4: ffff8881196b0160 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1292
6 locks held by kworker/0:0/26247:
1 lock held by syz.2.6783/32590:
1 lock held by syz.2.6783/32592:
 #0: ffff88812b40dcb0 (&dev->io_mutex){+.+.}-{3:3}, at: yurex_write+0x17f/0x940 drivers/usb/misc/yurex.c:447

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2536 Comm: klogd Not tainted 6.11.0-rc7-syzkaller-00152-g68d4209158f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:206 [inline]
RIP: 0010:unwind_next_frame+0x1d6/0x23a0 arch/x86/kernel/unwind_orc.c:494
Code: 0f 84 c9 02 00 00 e8 b9 33 3f 00 31 ff 4c 89 e6 e8 1f 36 3f 00 4d 85 e4 0f 84 ee 0a 00 00 e8 a1 33 3f 00 48 c7 c6 00 00 00 81 <4c> 89 e7 e8 42 35 3f 00 49 81 fc 00 00 00 81 0f 82 9e 02 00 00 e8
RSP: 0018:ffffc9000170f498 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffc9000170f518 RCX: ffffffff81155fe1
RDX: ffff8881157dba80 RSI: ffffffff81000000 RDI: 0000000000000007
RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
R10: ffffffff81aa9b72 R11: 0000000000000000 R12: ffffffff81aa9b72
R13: 0000000000000000 R14: ffffc9000170f5d8 R15: ffffc9000170f54d
FS:  00007f19fad5f380(0000) GS:ffff8881f5900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f92c07befe0 CR3: 00000001158ea000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4162 [inline]
 __kmalloc_node_track_caller_noprof+0x1ff/0x3e0 mm/slub.c:4181
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:605
 __alloc_skb+0x164/0x380 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2815
 unix_dgram_sendmsg+0x467/0x1920 net/unix/af_unix.c:2030
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f19faec19b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007fff90a2f958 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f19faec19b5
RDX: 000000000000004c RSI: 000055a2d3b7db40 RDI: 0000000000000003
RBP: 000055a2d3b702c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f19fb04f212 R14: 00007fff90a2fa58 R15: 0000000000000000
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

