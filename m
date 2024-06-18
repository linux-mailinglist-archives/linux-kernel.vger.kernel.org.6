Return-Path: <linux-kernel+bounces-218789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5A90C60E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFAEB227C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19761386D1;
	Tue, 18 Jun 2024 07:40:27 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0B47A5D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696426; cv=none; b=jW+u0P/klWYbf9EcgrrG+5nTRT4M5d9urgUAIQrSyfJAWW269zC9SUAzBDj302uxfwlGpXMlXmhv1jPKOZec/rLIJgji1InXShCyXizgkNMRdqEw5EohANCBWGdZA0F10xu8b1okgTiYfs8KbXdH2IW1gMbTo0AXACevUkyb+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696426; c=relaxed/simple;
	bh=I+d1hOuJ3zhMEcdshqn6uknGL3gTS8MHT4ZneKeG11E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=msYKgZyHMxgrvPYEDsASVOlwVshP0jSYLAdst+T0gxkwRxrhD6TsfxiOnRV27bFJOkEWekDBAgJcf0a9c7B2fPKlCn5FXgjTyy6Q9+Ftti6H3V08EFv9iVX6GPOOd7/vRbe6FCZ+DZi95A9IXbk60URB4dlhS0CVxLF3r+6ksq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-375e4d55457so43525315ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696424; x=1719301224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAHV63uLwT+Dc+wilaVRo5Oinh2QdYLt8WN04nHgbG4=;
        b=CvP9yidBg7LjER9kAq3cj1k/w3PqlCWsmkj4HxU959SLh+ufffDZgddtjyrwKbNAXk
         JKHXPnQSQ9vfxb8rnzW4k1gs/cznmQ41TaJPzfMLOJduB1zyveMBHmufm9Et3KtHhAtq
         eFPxFEwHmtt9Ml4mKyw7IyHlXUh+PnHCugBj1KR+KIMMueEkxiRLAollvwQSksMwWm0g
         lN0vk9Z5q9sNiNF6yhNoIaRf2+u1p+aw/djUT5ogjEgYP87/8rpDwai5gr1O70qTov2n
         vm4Skr62yfml+LWuUMduxCB1OsAg0soJK+zRBbH6lT53PzNoRp1PQQPhckFSbGQNgByZ
         Y32Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBeE+cifZFMhR0iMgVtG0rh+ePQL+PTaf/oCbjBLSYQoK9nZLhLwH7mpbNNpISTif1N5IiUVgIbNhl821ZimvujN31xM9msAhluF6m
X-Gm-Message-State: AOJu0YyXcbFJ3ycttdbOpQ7VTdzA6fzyoM+VokiUQFrTmuwQvwJYg+LE
	kLBmQ1NBjKgNhM7i/gh/f05iBYfV/M87/ykrmdaUNPxxgxoVU0LIYwAmYVqV+Cg6BIr0cKzG8VB
	+Wkebs9B3xn3jFo681UmYO9kDaXG8SXMSW9ebkETzIJk7on1S6KgFUY0=
X-Google-Smtp-Source: AGHT+IEnD7H25eaC5Y37mDFGbZiMTj5x6vSK3mI7VvHOsdoWsphQP74lEEheDLfg/CC/EnygIV+Hn9gkBUzEFzQPBjZtJ2g3ytPd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:375:9deb:ceb8 with SMTP id
 e9e14a558f8ab-375e1014718mr6893305ab.3.1718696424166; Tue, 18 Jun 2024
 00:40:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 00:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6e3cf061b2531ea@google.com>
Subject: [syzbot] [kernel?] possible deadlock in hrtimer_try_to_cancel
From: syzbot <syzbot+e620313b27e2be807d3b@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102534a2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
dashboard link: https://syzkaller.appspot.com/bug?extid=e620313b27e2be807d3b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e620313b27e2be807d3b@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0 Not tainted
------------------------------------------------------
kworker/u32:10/1146 is trying to acquire lock:
ffffffff8dba3118 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x12/0x70 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff88802c32c9d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
ffff88802c32c9d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_try_to_cancel+0xa9/0x500 kernel/time/hrtimer.c:1333

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (hrtimer_bases.lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
       hrtimer_start_range_ns+0xe7/0xe10 kernel/time/hrtimer.c:1298
       hrtimer_start_expires include/linux/hrtimer.h:289 [inline]
       do_start_rt_bandwidth kernel/sched/rt.c:119 [inline]
       start_rt_bandwidth kernel/sched/rt.c:130 [inline]
       inc_rt_group kernel/sched/rt.c:1187 [inline]
       inc_rt_tasks kernel/sched/rt.c:1230 [inline]
       __enqueue_rt_entity kernel/sched/rt.c:1405 [inline]
       enqueue_rt_entity kernel/sched/rt.c:1454 [inline]
       enqueue_task_rt+0x854/0xcb0 kernel/sched/rt.c:1489
       enqueue_task+0xaf/0x350 kernel/sched/core.c:2116
       __sched_setscheduler.constprop.0+0x12e2/0x2a80 kernel/sched/core.c:7903
       _sched_setscheduler kernel/sched/core.c:7950 [inline]
       sched_setscheduler_nocheck kernel/sched/core.c:7997 [inline]
       sched_set_fifo+0xb1/0x110 kernel/sched/core.c:8021
       irq_thread+0xf9/0x670 kernel/irq/manage.c:1313
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&rt_b->rt_runtime_lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __enable_runtime kernel/sched/rt.c:831 [inline]
       rq_online_rt+0xb0/0x3b0 kernel/sched/rt.c:2433
       set_rq_online.part.0+0xf9/0x140 kernel/sched/core.c:9586
       set_rq_online kernel/sched/core.c:9578 [inline]
       sched_cpu_activate+0x20f/0x450 kernel/sched/core.c:9695
       cpuhp_invoke_callback+0x435/0xbe0 kernel/cpu.c:194
       cpuhp_thread_fun+0x480/0x6f0 kernel/cpu.c:1092
       smpboot_thread_fn+0x661/0xa10 kernel/smpboot.c:164
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
       rq_lock kernel/sched/sched.h:1702 [inline]
       task_fork_fair+0x73/0x250 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x3cf/0x510 kernel/sched/core.c:4844
       copy_process+0x4710/0x6f50 kernel/fork.c:2499
       kernel_clone+0xfd/0x980 kernel/fork.c:2797
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2875
       rest_init+0x23/0x2b0 init/main.c:712
       start_kernel+0x3df/0x4c0 init/main.c:1103
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x148

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0x9a/0x13e0 kernel/sched/core.c:4262
       up+0x79/0xb0 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:340 [inline]
       __console_unlock kernel/printk/printk.c:2746 [inline]
       console_unlock+0x23e/0x290 kernel/printk/printk.c:3065
       vga_remove_vgacon drivers/pci/vgaarb.c:186 [inline]
       vga_remove_vgacon+0x90/0xd0 drivers/pci/vgaarb.c:167
       __aperture_remove_legacy_vga_devices drivers/video/aperture.c:331 [inline]
       aperture_remove_conflicting_pci_devices+0x17f/0x210 drivers/video/aperture.c:374
       bochs_pci_probe+0x101/0x1150 drivers/gpu/drm/tiny/bochs.c:651
       local_pci_probe+0xde/0x1b0 drivers/pci/pci-driver.c:324
       pci_call_probe drivers/pci/pci-driver.c:392 [inline]
       __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
       pci_device_probe+0x29d/0x7b0 drivers/pci/pci-driver.c:451
       call_driver_probe drivers/base/dd.c:578 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:656
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
       __driver_attach+0x283/0x580 drivers/base/dd.c:1214
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2e9/0x690 drivers/base/bus.c:673
       driver_register+0x15c/0x4b0 drivers/base/driver.c:246
       drm_pci_register_driver_if_modeset include/drm/drm_module.h:69 [inline]
       bochs_pci_driver_init+0x67/0x80 drivers/gpu/drm/tiny/bochs.c:735
       do_one_initcall+0x128/0x630 init/main.c:1267
       do_initcall_level init/main.c:1329 [inline]
       do_initcalls init/main.c:1345 [inline]
       do_basic_setup init/main.c:1364 [inline]
       kernel_init_freeable+0x660/0xc50 init/main.c:1578
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:323
       console_trylock kernel/printk/printk.c:2699 [inline]
       console_trylock_spinning kernel/printk/printk.c:1955 [inline]
       vprintk_emit kernel/printk/printk.c:2344 [inline]
       vprintk_emit+0xe4/0x5a0 kernel/printk/printk.c:2300
       vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2370
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x4ac/0x580 lib/bug.c:219
       handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       timerqueue_del+0xfe/0x150 lib/timerqueue.c:55
       __remove_hrtimer+0x99/0x290 kernel/time/hrtimer.c:1118
       remove_hrtimer kernel/time/hrtimer.c:1167 [inline]
       hrtimer_try_to_cancel+0x2a5/0x500 kernel/time/hrtimer.c:1336
       hrtimer_cancel+0x16/0x40 kernel/time/hrtimer.c:1445
       napi_disable+0x13a/0x1e0 net/core/dev.c:6648
       gro_cells_destroy net/core/gro_cells.c:116 [inline]
       gro_cells_destroy+0x102/0x4d0 net/core/gro_cells.c:106
       netdev_run_todo+0x775/0x1250 net/core/dev.c:10693
       cleanup_net+0x591/0xbf0 net/core/net_namespace.c:636
       process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&rt_b->rt_runtime_lock);
                               lock(hrtimer_bases.lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

4 locks held by kworker/u32:10/1146:
 #0: ffff8880162e7148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x11f0/0x1ad0 kernel/workqueue.c:3206
 #1: ffffc90007267d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1ad0 kernel/workqueue.c:3207
 #2: ffffffff8f722910 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xbf0 net/core/net_namespace.c:594
 #3: ffff88802c32c9d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
 #3: ffff88802c32c9d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_try_to_cancel+0xa9/0x500 kernel/time/hrtimer.c:1333

stack backtrace:
CPU: 3 PID: 1146 Comm: kworker/u32:10 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 down_trylock+0x12/0x70 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x40/0x140 kernel/printk/printk.c:323
 console_trylock kernel/printk/printk.c:2699 [inline]
 console_trylock_spinning kernel/printk/printk.c:1955 [inline]
 vprintk_emit kernel/printk/printk.c:2344 [inline]
 vprintk_emit+0xe4/0x5a0 kernel/printk/printk.c:2300
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2370
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x4ac/0x580 lib/bug.c:219
 handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:timerqueue_del+0xfe/0x150 lib/timerqueue.c:55
Code: 28 9e ff ff 4c 89 e1 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75 45 48 89 45 08 e9 7b ff ff ff e8 f3 90 c0 f6 90 <0f> 0b 90 e9 43 ff ff ff 48 89 df e8 a2 c4 1d f7 eb 8a 4c 89 e7 e8
RSP: 0018:ffffc90007267918 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffe8ffad04d080 RCX: ffffffff8acdfe20
RDX: ffff88802045a440 RSI: ffffffff8acdfedd RDI: 0000000000000006
RBP: ffff88802c32ca90 R08: 0000000000000006 R09: ffffe8ffad04d080
R10: ffffe8ffad04d080 R11: 0000000000000001 R12: ffffe8ffad04d080
R13: 0000000000000001 R14: ffff88802c32c9c0 R15: 0000000000000000
 __remove_hrtimer+0x99/0x290 kernel/time/hrtimer.c:1118
 remove_hrtimer kernel/time/hrtimer.c:1167 [inline]
 hrtimer_try_to_cancel+0x2a5/0x500 kernel/time/hrtimer.c:1336
 hrtimer_cancel+0x16/0x40 kernel/time/hrtimer.c:1445
 napi_disable+0x13a/0x1e0 net/core/dev.c:6648
 gro_cells_destroy net/core/gro_cells.c:116 [inline]
 gro_cells_destroy+0x102/0x4d0 net/core/gro_cells.c:106
 netdev_run_todo+0x775/0x1250 net/core/dev.c:10693
 cleanup_net+0x591/0xbf0 net/core/net_namespace.c:636
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
WARNING: CPU: 3 PID: 1146 at lib/timerqueue.c:55 timerqueue_del+0xfe/0x150 lib/timerqueue.c:55
Modules linked in:
CPU: 3 PID: 1146 Comm: kworker/u32:10 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:timerqueue_del+0xfe/0x150 lib/timerqueue.c:55
Code: 28 9e ff ff 4c 89 e1 48 ba 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 11 00 75 45 48 89 45 08 e9 7b ff ff ff e8 f3 90 c0 f6 90 <0f> 0b 90 e9 43 ff ff ff 48 89 df e8 a2 c4 1d f7 eb 8a 4c 89 e7 e8
RSP: 0018:ffffc90007267918 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffe8ffad04d080 RCX: ffffffff8acdfe20
RDX: ffff88802045a440 RSI: ffffffff8acdfedd RDI: 0000000000000006
RBP: ffff88802c32ca90 R08: 0000000000000006 R09: ffffe8ffad04d080
R10: ffffe8ffad04d080 R11: 0000000000000001 R12: ffffe8ffad04d080
R13: 0000000000000001 R14: ffff88802c32c9c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000ffeb8c2c CR3: 000000005beb8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __remove_hrtimer+0x99/0x290 kernel/time/hrtimer.c:1118
 remove_hrtimer kernel/time/hrtimer.c:1167 [inline]
 hrtimer_try_to_cancel+0x2a5/0x500 kernel/time/hrtimer.c:1336
 hrtimer_cancel+0x16/0x40 kernel/time/hrtimer.c:1445
 napi_disable+0x13a/0x1e0 net/core/dev.c:6648
 gro_cells_destroy net/core/gro_cells.c:116 [inline]
 gro_cells_destroy+0x102/0x4d0 net/core/gro_cells.c:106
 netdev_run_todo+0x775/0x1250 net/core/dev.c:10693
 cleanup_net+0x591/0xbf0 net/core/net_namespace.c:636
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
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

