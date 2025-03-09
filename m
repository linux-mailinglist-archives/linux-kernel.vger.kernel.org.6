Return-Path: <linux-kernel+bounces-553074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1EA58334
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4071890055
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B31BD017;
	Sun,  9 Mar 2025 10:40:32 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1791A4AAA
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516831; cv=none; b=l8zdDIK87FkMeQ63L4iPp3VEEr5gc3JsxpHL6FgKjTYusIm93mwAodcxbf7YeIGH3+aGk1SQezYc9S2abWoIWaje51XxrXU422MZ0ZDgWEz49LKumfxQwAiq6wB5pzpk1q2of/27lrFHJP0JtvKkwpHAFeLmVjrMnOVmUME9uLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516831; c=relaxed/simple;
	bh=I0ImRQ2puyT+8ti1YJvxCDrW15zqgXu3WsGN9CnZ2dU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y7RY52RdUl2Pb4741oTgG11R5L/h/jJlRIzoUPy96+lMXJ9HdT0J6TafO0A8BaeyRubABp2ogpAA0tc7sw9V+w7uPZt+O4Uqb8jrAJvk0MhDr+SD2sVEVEZo7Oq5EGqNJ8vaM8gQY6R60eVuEmPnXSE2RLsVHya3I+pI8PjAf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-851a991cf8bso345329439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741516829; x=1742121629;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ju74uZRz3v4TsYZ14S1ZmmUHMZtF5vPoE1ud+p9tBKk=;
        b=gMy/ocgQ/PLxyWnQu+U+37ohK9bO/cLRs3YdQ5Zhpzzw/V4HSKpqrvGvki7peNnlmp
         4I2iH852kj1vmWZLXIlhSeLOXHQVZHYhyLI/d7RPuj+wJ7UGhASnNUfF7ZnIul5ZSKg9
         0Q6pK3cUMreCCbdIDv/qbL2lINx3+Jj8e8QK/fiU8UNjR4jrOMRGCl96n9jmJzGcbY1c
         tsB6HOZ1ySk+Xi6SaSVfbZNqYwrz/gUZRWuxmWbV43Ol1+yMOG7YAiMzwuruYo+OvI2B
         4HQY6uxr8vylQMPrwJ0XdDARU8NQo/xLJkYKq/0SEy5tmi55qamwJ+DrOe6LISixyUlV
         Qgig==
X-Forwarded-Encrypted: i=1; AJvYcCWvPT2SutCa/Lw6B7yCMdcNqTsnCQiE1dS+d3KiZr0TAmHGrIGXmLIAuDZs9X4JEGV2N6qXFB8o10QNko4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZV87Rv/Z74wBFA6NK/6JHqXgOsD/F7UaKd70Lzb/uy5gLng2p
	tHV5c2m8Qzn4kZLxQP8iOby6r96og2A9OHHM9tuMVhMr4PQka8pNZu9VM7PoONbbWq47EVTh4mk
	l+4zK4OGsAgmGQRp0iJJ86L6OGrWv2yA56LZcCrVvq2tLXRXZTOw6d0Q=
X-Google-Smtp-Source: AGHT+IE1lofDqRXgVynNi7+UQFOqTTbe9sU60w6K3abbAi6A8l9OUZptDRFgYiADOhbfUWeNLEchLgNBPLtpi3g6VsFKVx+sj6rM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:3d3:d1a8:8e82 with SMTP id
 e9e14a558f8ab-3d44af25575mr66940415ab.9.1741516828928; Sun, 09 Mar 2025
 03:40:28 -0700 (PDT)
Date: Sun, 09 Mar 2025 03:40:28 -0700
In-Reply-To: <67b1f949.050a0220.173698.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd701c.050a0220.2eb24d.0000.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in get_partial_node (2)
From: syzbot <syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b7c90e3e717a Merge tag 'x86-urgent-2025-03-08' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10898664580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=725322cc4ff5c53abfac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137c1fa0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0fa54580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/efe746eddadf/disk-b7c90e3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8dcac591074f/vmlinux-b7c90e3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9ac7aeb49a3/bzImage-b7c90e3e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b499053db8a0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com

=============================================================================
======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc5-syzkaller-00234-gb7c90e3e717a #0 Not tainted
------------------------------------------------------
syz-executor131/5940 is trying to acquire lock:
ffffffff8ea14fb8 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff88802a42da98 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
ffff88802a42da98 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:5609 [inline]
ffff88802a42da98 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x9c/0x430 mm/slub.c:5647

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&n->list_lock){-.-.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       get_partial_node+0x37/0x3f0 mm/slub.c:2834
       get_partial mm/slub.c:2948 [inline]
       ___slab_alloc+0xb75/0x14a0 mm/slub.c:3806
       __slab_alloc+0x58/0xa0 mm/slub.c:3916
       __slab_alloc_node mm/slub.c:3991 [inline]
       slab_alloc_node mm/slub.c:4152 [inline]
       kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4171
       kmem_alloc_batch lib/debugobjects.c:371 [inline]
       fill_pool+0x260/0x680 lib/debugobjects.c:403
       debug_objects_fill_pool lib/debugobjects.c:725 [inline]
       debug_object_activate+0x493/0x580 lib/debugobjects.c:814
       debug_hrtimer_activate kernel/time/hrtimer.c:455 [inline]
       debug_activate kernel/time/hrtimer.c:496 [inline]
       enqueue_hrtimer+0x30/0x3c0 kernel/time/hrtimer.c:1100
       __hrtimer_start_range_ns kernel/time/hrtimer.c:1282 [inline]
       hrtimer_start_range_ns+0xcc3/0xfa0 kernel/time/hrtimer.c:1343
       hrtimer_start include/linux/hrtimer.h:260 [inline]
       start_dl_timer+0x36a/0x4e0 kernel/sched/deadline.c:1190
       update_curr_dl_se+0x348/0x860 kernel/sched/deadline.c:1539
       update_curr+0x568/0xda0 kernel/sched/fair.c:1246
       entity_tick kernel/sched/fair.c:5628 [inline]
       task_tick_fair+0x69/0x4e0 kernel/sched/fair.c:13091
       sched_tick+0x21e/0x660 kernel/sched/core.c:5661
       update_process_times+0x276/0x2f0 kernel/time/timer.c:2520
       tick_sched_handle kernel/time/tick-sched.c:276 [inline]
       tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
       __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
       __hrtimer_run_queues+0x551/0xd30 kernel/time/hrtimer.c:1865
       hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1927
       local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
       __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
       sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       native_save_fl arch/x86/include/asm/irqflags.h:26 [inline]
       arch_local_save_flags arch/x86/include/asm/irqflags.h:87 [inline]
       arch_local_irq_save arch/x86/include/asm/irqflags.h:123 [inline]
       lock_is_held_type+0x67/0x190 kernel/locking/lockdep.c:5919
       lock_is_held include/linux/lockdep.h:249 [inline]
       __might_resched+0xa5/0x780 kernel/sched/core.c:8729
       down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
       anon_vma_lock_read include/linux/rmap.h:136 [inline]
       validate_mm+0x2c8/0x590 mm/vma.c:612
       __split_vma+0xa60/0xbf0 mm/vma.c:513
       split_vma mm/vma.c:542 [inline]
       vma_modify+0x244/0x330 mm/vma.c:1529
       vma_modify_flags+0x3a5/0x430 mm/vma.c:1547
       mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:666
       do_mprotect_pkey+0x99d/0xdd0 mm/mprotect.c:840
       __do_sys_mprotect mm/mprotect.c:861 [inline]
       __se_sys_mprotect mm/mprotect.c:858 [inline]
       __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:858
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:181 [inline]
       hrtimer_start_range_ns+0xf9/0xfa0 kernel/time/hrtimer.c:1341
       hrtimer_start include/linux/hrtimer.h:260 [inline]
       start_dl_timer+0x36a/0x4e0 kernel/sched/deadline.c:1190
       enqueue_dl_entity+0x1056/0x1db0 kernel/sched/deadline.c:2076
       dl_server_start+0xe2/0x2a0 kernel/sched/deadline.c:1671
       enqueue_task_fair+0x9d7/0xd40 kernel/sched/fair.c:7012
       enqueue_task+0x73/0x3d0 kernel/sched/core.c:2070
       activate_task kernel/sched/core.c:2117 [inline]
       wake_up_new_task+0x576/0xc70 kernel/sched/core.c:4879
       kernel_clone+0x480/0x870 kernel/fork.c:2846
       user_mode_thread+0x144/0x1c0 kernel/fork.c:2893
       rest_init+0x23/0x300 init/main.c:708
       start_kernel+0x484/0x510 init/main.c:1099
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x66/0x70 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
       raw_spin_rq_lock kernel/sched/sched.h:1521 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:700
       cgroup_move_task+0x9b/0x5a0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x284/0x8b0 kernel/cgroup/cgroup.c:6695
       copy_process+0x398a/0x3cf0 kernel/fork.c:2629
       kernel_clone+0x223/0x870 kernel/fork.c:2815
       user_mode_thread+0x144/0x1c0 kernel/fork.c:2893
       rest_init+0x23/0x300 init/main.c:708
       start_kernel+0x484/0x510 init/main.c:1099
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:515
       x86_64_start_kernel+0x66/0x70 arch/x86/kernel/head64.c:496
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xc2/0x1470 kernel/sched/core.c:4214
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x123/0x1f0 kernel/printk/printk.c:2869
       __console_flush_and_unlock kernel/printk/printk.c:3271 [inline]
       console_unlock+0x18f/0x3b0 kernel/printk/printk.c:3309
       vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       bt_err+0x127/0x180 net/bluetooth/lib.c:296
       hci_cmd_timeout+0x104/0x1e0 net/bluetooth/hci_core.c:1456
       process_one_work kernel/workqueue.c:3238 [inline]
       process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3319
       worker_thread+0x870/0xd30 kernel/workqueue.c:3400
       kthread+0x7a9/0x920 kernel/kthread.c:464
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
       console_trylock kernel/printk/printk.c:2852 [inline]
       console_trylock_spinning kernel/printk/printk.c:2009 [inline]
       vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2431
       _printk+0xd5/0x120 kernel/printk/printk.c:2457
       slab_bug+0x6d/0xc0 mm/slub.c:1028
       slab_err+0x130/0x190 mm/slub.c:1129
       list_slab_objects mm/slub.c:5580 [inline]
       free_partial mm/slub.c:5615 [inline]
       __kmem_cache_shutdown+0x134/0x430 mm/slub.c:5647
       kmem_cache_destroy+0x76/0x160 mm/slab_common.c:530
       bio_put_slab block/bio.c:155 [inline]
       bioset_exit+0x54e/0x650 block/bio.c:1662
       bch2_fs_fs_io_direct_exit+0x19/0x30 fs/bcachefs/fs-io-direct.c:676
       __bch2_fs_free fs/bcachefs/super.c:558 [inline]
       bch2_fs_release+0x1a9/0x7b0 fs/bcachefs/super.c:624
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x22f/0x480 lib/kobject.c:737
       bch2_fs_get_tree+0xdee/0x17a0 fs/bcachefs/fs.c:2299
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3560
       do_mount fs/namespace.c:3900 [inline]
       __do_sys_mount fs/namespace.c:4111 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> hrtimer_bases.lock --> &n->list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&n->list_lock);
                               lock(hrtimer_bases.lock);
                               lock(&n->list_lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

4 locks held by syz-executor131/5940:
 #0: ffffffff8f2578c8 (bio_slab_lock){+.+.}-{4:4}, at: bio_put_slab block/bio.c:140 [inline]
 #0: ffffffff8f2578c8 (bio_slab_lock){+.+.}-{4:4}, at: bioset_exit+0x42f/0x650 block/bio.c:1662
 #1: ffffffff8e9d5210 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x3e/0x160 mm/slab_common.c:517
 #2: ffffffff8ec221b0 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy+0x4c/0x160 mm/slab_common.c:518
 #3: ffff88802a42da98 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:376 [inline]
 #3: ffff88802a42da98 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:5609 [inline]
 #3: ffff88802a42da98 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x9c/0x430 mm/slub.c:5647

stack backtrace:
CPU: 1 UID: 0 PID: 5940 Comm: syz-executor131 Not tainted 6.14.0-rc5-syzkaller-00234-gb7c90e3e717a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2076
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3906
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
 console_trylock kernel/printk/printk.c:2852 [inline]
 console_trylock_spinning kernel/printk/printk.c:2009 [inline]
 vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2431
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 slab_bug+0x6d/0xc0 mm/slub.c:1028
 slab_err+0x130/0x190 mm/slub.c:1129
 list_slab_objects mm/slub.c:5580 [inline]
 free_partial mm/slub.c:5615 [inline]
 __kmem_cache_shutdown+0x134/0x430 mm/slub.c:5647
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:530
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 bch2_fs_fs_io_direct_exit+0x19/0x30 fs/bcachefs/fs-io-direct.c:676
 __bch2_fs_free fs/bcachefs/super.c:558 [inline]
 bch2_fs_release+0x1a9/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 bch2_fs_get_tree+0xdee/0x17a0 fs/bcachefs/fs.c:2299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04451d5c6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 1e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff28174678 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff28174710 RCX: 00007f04451d5c6a
RDX: 00004000000000c0 RSI: 0000400000000000 RDI: 00007fff281746d0
RBP: 0000000000000000 R08: 00007fff28174710 R09: 0000000000005979
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000004
R13: 0000000001000000 R14: 00004000000000c0 R15: 0000000000000003
 </TASK>
BUG bio-1200 (Not tainted): Objects remaining in bio-1200 on __kmem_cache_shutdown()
-----------------------------------------------------------------------------

Slab 0xffffea0001938500 objects=12 used=4 fp=0xffff888064e16a00 flags=0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
CPU: 1 UID: 0 PID: 5940 Comm: syz-executor131 Not tainted 6.14.0-rc5-syzkaller-00234-gb7c90e3e717a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 slab_err+0x15a/0x190 mm/slub.c:1131
 list_slab_objects mm/slub.c:5580 [inline]
 free_partial mm/slub.c:5615 [inline]
 __kmem_cache_shutdown+0x134/0x430 mm/slub.c:5647
 kmem_cache_destroy+0x76/0x160 mm/slab_common.c:530
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 bch2_fs_fs_io_direct_exit+0x19/0x30 fs/bcachefs/fs-io-direct.c:676
 __bch2_fs_free fs/bcachefs/super.c:558 [inline]
 bch2_fs_release+0x1a9/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 bch2_fs_get_tree+0xdee/0x17a0 fs/bcachefs/fs.c:2299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04451d5c6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 1e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff28174678 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff28174710 RCX: 00007f04451d5c6a
RDX: 00004000000000c0 RSI: 0000400000000000 RDI: 00007fff281746d0
RBP: 0000000000000000 R08: 00007fff28174710 R09: 0000000000005979
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000004
R13: 0000000001000000 R14: 00004000000000c0 R15: 0000000000000003
 </TASK>
Object 0xffff888064e15500 @offset=5376
Object 0xffff888064e15a40 @offset=6720
Object 0xffff888064e15f80 @offset=8064
Object 0xffff888064e164c0 @offset=9408
------------[ cut here ]------------
kmem_cache_destroy bio-1200: Slab cache still has objects when called from bio_put_slab block/bio.c:155 [inline]
kmem_cache_destroy bio-1200: Slab cache still has objects when called from bioset_exit+0x54e/0x650 block/bio.c:1662
WARNING: CPU: 0 PID: 5940 at mm/slab_common.c:533 kmem_cache_destroy+0x153/0x160 mm/slab_common.c:532
Modules linked in:
CPU: 0 UID: 0 PID: 5940 Comm: syz-executor131 Tainted: G    B              6.14.0-rc5-syzkaller-00234-gb7c90e3e717a #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:kmem_cache_destroy+0x153/0x160 mm/slab_common.c:532
Code: 5f 18 48 89 de 5b 41 5e 5d e9 e9 e7 13 00 90 48 8b 53 60 48 c7 c7 43 3c 2c 8e 48 c7 c6 7c 3c 2c 8e 48 89 e9 e8 2e 45 7a ff 90 <0f> 0b 90 90 e9 25 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000422f860 EFLAGS: 00010246
RAX: 56da6a4a7fb35b00 RBX: ffff8880664ea000 RCX: ffff888030589e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff84cabf9e R08: ffffffff81819d62 R09: fffffbfff1d3a68c
R10: dffffc0000000000 R11: fffffbfff1d3a68c R12: 00000000000004b0
R13: 1ffff1100c489283 R14: 0000000000000001 R15: ffff88802758d748
FS:  000055557a2773c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f043d3ff000 CR3: 0000000030908000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bio_put_slab block/bio.c:155 [inline]
 bioset_exit+0x54e/0x650 block/bio.c:1662
 bch2_fs_fs_io_direct_exit+0x19/0x30 fs/bcachefs/fs-io-direct.c:676
 __bch2_fs_free fs/bcachefs/super.c:558 [inline]
 bch2_fs_release+0x1a9/0x7b0 fs/bcachefs/super.c:624
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 bch2_fs_get_tree+0xdee/0x17a0 fs/bcachefs/fs.c:2299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04451d5c6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 1e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff28174678 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff28174710 RCX: 00007f04451d5c6a
RDX: 00004000000000c0 RSI: 0000400000000000 RDI: 00007fff281746d0
RBP: 0000000000000000 R08: 00007fff28174710 R09: 0000000000005979
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000004
R13: 0000000001000000 R14: 00004000000000c0 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

