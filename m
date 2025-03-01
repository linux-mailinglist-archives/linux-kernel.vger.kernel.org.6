Return-Path: <linux-kernel+bounces-539837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B58A4A99A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169C4189B04B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813BB1CDA0B;
	Sat,  1 Mar 2025 07:58:57 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8D1C4A24
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740815936; cv=none; b=eDJzDFulcKi1L0cL6qtMxlzE1YCBrq8XH+u7D9IxxYYJrrFnDaPho+YbUbCF6/IMgdXbBJTqC3JzNCGka7HS5EcJkJFJLPCzRGSkB43jKxoqC5FCGFJ5bmAgaGr9oovNI4YCcvVOLHO950KTX4ffxi5Dm78n7EPgjQVrkdxhEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740815936; c=relaxed/simple;
	bh=5q5kjvHw12t2/8R2f3pQeLsJO4DyhK/iTdUJEwwmqiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ0n0Sq2CpsmXMtzTE6vcgy4oKVpzHF5zZb0yWpXzdezCDPXQ/ZEYJGR9DndQDrNXhPD74KCdS1s66lBxXERyCeKXxm1lG9AsFWf2fo5MjUPhSWTj8K+FWUm91VHUcD93lFdLLZpFyvbQVRsUlzT+84+YoBtpJKzRCEaIXjukFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.41])
	by sina.com (10.185.250.22) with ESMTP
	id 67C2BCEC0000082E; Sat, 1 Mar 2025 15:53:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 902497602573
X-SMAIL-UIID: 927AF9EDC6FA4BB0BD82B597D48CF467-20250301-155322-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid context in snd_card_locked
Date: Sat,  1 Mar 2025 15:53:09 +0800
Message-ID: <20250301075310.2848-1-hdanton@sina.com>
In-Reply-To: <67c272e5.050a0220.dc10f.0159.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Feb 2025 18:37:25 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
> dashboard link: https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-d082ecbc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f7cfa9bd3468/vmlinux-d082ecbc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d47dd7c3fc5d/bzImage-d082ecbc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1167, name: kworker/0:1H
> preempt_count: 0, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by kworker/0:1H/1167:
>  #0: ffff88801b089148 ((wq_completion)events_highpri){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3211
>  #1: ffffc900061f7d18 ((work_completion)(&timer->task_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3212
> irq event stamp: 1044
> hardirqs last  enabled at (1043): [<ffffffff8b59c523>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
> hardirqs last  enabled at (1043): [<ffffffff8b59c523>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
> hardirqs last disabled at (1044): [<ffffffff8b59c2c2>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
> hardirqs last disabled at (1044): [<ffffffff8b59c2c2>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
> softirqs last  enabled at (204): [<ffffffff817c131b>] softirq_handle_end kernel/softirq.c:407 [inline]
> softirqs last  enabled at (204): [<ffffffff817c131b>] handle_softirqs+0x5bb/0x8f0 kernel/softirq.c:589
> softirqs last disabled at (183): [<ffffffff817c17e9>] __do_softirq kernel/softirq.c:595 [inline]
> softirqs last disabled at (183): [<ffffffff817c17e9>] invoke_softirq kernel/softirq.c:435 [inline]
> softirqs last disabled at (183): [<ffffffff817c17e9>] __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
> CPU: 0 UID: 0 PID: 1167 Comm: kworker/0:1H Not tainted 6.14.0-rc4-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: events_highpri snd_timer_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8767
>  __mutex_lock_common kernel/locking/mutex.c:562 [inline]
>  __mutex_lock+0x108/0xb10 kernel/locking/mutex.c:730
>  class_mutex_constructor include/linux/mutex.h:201 [inline]
>  snd_card_locked+0x1b/0x60 sound/core/init.c:399
>  snd_request_card+0x14/0x70 sound/core/sound.c:62
>  snd_seq_client_use_ptr+0x375/0x3c0 sound/core/seq/seq_clientmgr.c:152
>  get_event_dest_client sound/core/seq/seq_clientmgr.c:533 [inline]
>  snd_seq_deliver_single_event+0xdb/0x6e0 sound/core/seq/seq_clientmgr.c:663
>  snd_seq_deliver_event+0x291/0x4b0 sound/core/seq/seq_clientmgr.c:822
>  snd_seq_dispatch_event+0x117/0x580 sound/core/seq/seq_clientmgr.c:897
>  snd_seq_check_queue+0x248/0x510 sound/core/seq/seq_queue.c:256
>  snd_seq_timer_interrupt+0x2e3/0x390 sound/core/seq/seq_timer.c:153
>  snd_timer_process_callbacks+0x217/0x2e0 sound/core/timer.c:785
>  snd_timer_work+0xa9/0x100 sound/core/timer.c:815
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3317 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
>  kthread+0x3af/0x750 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> ================================
> WARNING: inconsistent lock state
> 6.14.0-rc4-syzkaller #0 Tainted: G        W         
> --------------------------------
> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> kworker/0:1H/1167 [HC0[0]:SC0[0]:HE1:SE1] takes:
> ffff8880236dc148 (&timer->lock){?.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
> ffff8880236dc148 (&timer->lock){?.-.}-{3:3}, at: snd_timer_process_callbacks+0x227/0x2e0 sound/core/timer.c:786
> {IN-HARDIRQ-W} state was registered at:
>   lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>   spin_lock include/linux/spinlock.h:351 [inline]
>   class_spinlock_constructor include/linux/spinlock.h:559 [inline]
>   snd_hrtimer_callback+0x53/0x400 sound/core/hrtimer.c:38
>   __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
>   __hrtimer_run_queues+0x20a/0xae0 kernel/time/hrtimer.c:1865
>   hrtimer_interrupt+0x392/0x8e0 kernel/time/hrtimer.c:1927

Given irq context, this deadlock is false positive because of irq disabled.

>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
>   __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
>   instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
>   sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
>   asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
>   __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
>   _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
>   class_raw_spinlock_irqsave_destructor include/linux/spinlock.h:551 [inline]
>   try_to_wake_up+0x949/0x1490 kernel/sched/core.c:4214
>   wake_up_process kernel/sched/core.c:4463 [inline]
>   wake_up_q+0x9c/0x160 kernel/sched/core.c:1075
>   raw_spin_unlock_irqrestore_wake include/linux/sched/wake_q.h:96 [inline]
>   __mutex_unlock_slowpath+0x231/0x6a0 kernel/locking/mutex.c:933
>   device_unlock include/linux/device.h:1045 [inline]
>   hub_event+0xc5f/0x4e10 drivers/usb/core/hub.c:5954
>   process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
>   process_scheduled_works kernel/workqueue.c:3317 [inline]
>   worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
>   kthread+0x3af/0x750 kernel/kthread.c:464
>   ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> irq event stamp: 1197
> hardirqs last  enabled at (1197): [<ffffffff8b59c5b2>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (1197): [<ffffffff8b59c5b2>] _raw_spin_unlock_irqrestore+0x52/0x80 kernel/locking/spinlock.c:194
> hardirqs last disabled at (1196): [<ffffffff8b59c2c2>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
> hardirqs last disabled at (1196): [<ffffffff8b59c2c2>] _raw_spin_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:162
> softirqs last  enabled at (1156): [<ffffffff817c131b>] softirq_handle_end kernel/softirq.c:407 [inline]
> softirqs last  enabled at (1156): [<ffffffff817c131b>] handle_softirqs+0x5bb/0x8f0 kernel/softirq.c:589
> softirqs last disabled at (1047): [<ffffffff817c17e9>] __do_softirq kernel/softirq.c:595 [inline]
> softirqs last disabled at (1047): [<ffffffff817c17e9>] invoke_softirq kernel/softirq.c:435 [inline]
> softirqs last disabled at (1047): [<ffffffff817c17e9>] __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&timer->lock);
>   <Interrupt>
>     lock(&timer->lock);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by kworker/0:1H/1167:
>  #0: ffff88801b089148 ((wq_completion)events_highpri){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3211
>  #1: ffffc900061f7d18 ((work_completion)(&timer->task_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3212
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 1167 Comm: kworker/0:1H Tainted: G        W          6.14.0-rc4-syzkaller #0
> Tainted: [W]=WARN
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: events_highpri snd_timer_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_usage_bug.part.0+0x3fb/0x680 kernel/locking/lockdep.c:4040
>  print_usage_bug kernel/locking/lockdep.c:4008 [inline]
>  valid_state kernel/locking/lockdep.c:4054 [inline]
>  mark_lock_irq kernel/locking/lockdep.c:4265 [inline]
>  mark_lock+0x92d/0xc60 kernel/locking/lockdep.c:4751
>  mark_usage kernel/locking/lockdep.c:4660 [inline]
>  __lock_acquire+0x98e/0x3c40 kernel/locking/lockdep.c:5182
>  lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  snd_timer_process_callbacks+0x227/0x2e0 sound/core/timer.c:786
>  snd_timer_work+0xa9/0x100 sound/core/timer.c:815
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3317 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
>  kthread+0x3af/0x750 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> ------------[ cut here ]------------
> raw_local_irq_restore() called with IRQs enabled
> WARNING: CPU: 0 PID: 1167 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
> Modules linked in:
> CPU: 0 UID: 0 PID: 1167 Comm: kworker/0:1H Tainted: G        W          6.14.0-rc4-syzkaller #0
> Tainted: [W]=WARN
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: events_highpri snd_timer_work
> RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
> Code: 90 f3 0f 1e fa 90 80 3d f9 a7 f3 04 00 74 06 90 c3 cc cc cc cc c6 05 ea a7 f3 04 01 90 48 c7 c7 c0 e6 6c 8b e8 58 df 22 f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900061f7c18 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8880236dc130 RCX: ffffffff817a1229
> RDX: ffff888028238000 RSI: ffffffff817a1236 RDI: 0000000000000001
> RBP: 0000000000000286 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 61636f6c5f776172 R12: ffff8880236dc000
> R13: ffff8880236dc1b0 R14: 0000000000000000 R15: ffff88801b09d800
> FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fecdd000218 CR3: 0000000031f9c000 CR4: 0000000000352ef0
> DR0: 0000000000000002 DR1: fffffffffffffffb DR2: 0000000000010001
> DR3: 0000000000000004 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
>  _raw_spin_unlock_irqrestore+0x74/0x80 kernel/locking/spinlock.c:194
>  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>  class_spinlock_irqsave_destructor include/linux/spinlock.h:572 [inline]
>  snd_timer_work+0xbe/0x100 sound/core/timer.c:814
>  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3317 [inline]
>  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
>  kthread+0x3af/0x750 kernel/kthread.c:464
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 

