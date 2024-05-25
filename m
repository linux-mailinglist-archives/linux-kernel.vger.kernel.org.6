Return-Path: <linux-kernel+bounces-189535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1D18CF15F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC071C2090C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C338127E34;
	Sat, 25 May 2024 20:46:27 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83939FFD
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716669986; cv=none; b=QINs/EzZJUSOmNHWuqd09MfZxttYTwUuOXYwChXDpbYu0qZvX07sc2zrSzl08IHPpWLBVmfcDfOJvhEsDUomMP4n28OVZGnFnEGlLI4rs6J2+gtMwYenWVa1U9zPuw4qgAsvaU7mLdHj8I54BFFgDVKQuX35Gzw6DWvYQH2H97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716669986; c=relaxed/simple;
	bh=fJrlzDvgiNF/6odLX0D9uVLrv40IGUpnV8UtJpC3ZAU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SL7x4V4utr0GeNrfs40l6Ir4euwcRto8EULi1C3OkVDaThZMa59IigyZPI6IjoyNfO8iLFfWwdwWFk0BUPnXgeMk7LYkLPk5CELIEOs8XIrGazzsM/KSsKiH3Z9OCURq3xKHbu1/8uNOmoC6wuYYNpdeXR6oedMg75MHUeuQP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3742c0af134so2607185ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 13:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716669983; x=1717274783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6zhFfuvcA/1vgecgQCUvcxarpy/YgFipg6QCqmwnok=;
        b=rwjKf7heaBUqaB3tFN5QtTr1Iavb+5EGYAO3XokNBgAwa2p4Wx8pbKJEqq8KGghqij
         6S8gTN1V/jmCbz3n2JXUYdc+pZ8uNLiR6kyNpIlifZAPOmcXz3Zdcec0t0SfCO57dMHS
         x5z2CwiPSLatTUERI7aFYe79nAxzv5Uf6lfaj+3+A4NKIj4wjE+tW/iDR8fBeHQUKM6p
         ffzb3Q1bSwNeS0H3cNuIo7Oh/OFqFtK7yaIkJ1adF5Lkuwi6U71Ze5wmPvzR4YbO/6YS
         vWZS3/akgod0wma/tCVj2NlGTDhdQCTxZ8U4QhA9U82B7a8pAR92PSTt2Yi+Jkfuc5bu
         nVBw==
X-Gm-Message-State: AOJu0Yy4+NIYS9hwDuP3REg2WIo6xM7LjYG61SMCTbD1gB7/+G6s40my
	E3P6keO8kvp1Bn8LNLbdayg80BQMLXHGt6LGgMi2ZbyyUzdKRHfZx1pcbSiiz9JF37YpttC9Tyf
	kxks9uxAJ69GXAxMkUl3a0Q7bwQGAlnLEivV6lhIraFfN5g8nfApvSK/YOw==
X-Google-Smtp-Source: AGHT+IGZ4z9mX7iBs5yGTHhV0t2tbvADjKhPbKvOF5aPVfH0iSA6dd3+KiPcz7usku2/uEOz2Feu8XXY+Gw43f3ab7QUDVb0JiLk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c07:b0:36c:11a0:7878 with SMTP id
 e9e14a558f8ab-3737b2c2bb8mr4667305ab.2.1716669983561; Sat, 25 May 2024
 13:46:23 -0700 (PDT)
Date: Sat, 25 May 2024 13:46:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091286106194d6076@google.com>
Subject: [syzbot] [kernel?] possible deadlock in run_timer_base
From: syzbot <syzbot+9a474438d0c960487fcf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1107d9cc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
dashboard link: https://syzkaller.appspot.com/bug?extid=9a474438d0c960487fcf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a474438d0c960487fcf@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-10713-g2a8120d7b482 #0 Not tainted
------------------------------------------------------
swapper/0/0 is trying to acquire lock:
ffffffff8dba2e98 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x12/0x70 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff88802c02a858 (&base->lock){-.-.}-{2:2}, at: __run_timer_base kernel/time/timer.c:2427 [inline]
ffff88802c02a858 (&base->lock){-.-.}-{2:2}, at: __run_timer_base kernel/time/timer.c:2421 [inline]
ffff88802c02a858 (&base->lock){-.-.}-{2:2}, at: run_timer_base+0x109/0x190 kernel/time/timer.c:2437

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&base->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
       lock_timer_base+0x5d/0x220 kernel/time/timer.c:1051
       __mod_timer+0x426/0xdc0 kernel/time/timer.c:1132
       add_timer_global+0x8a/0xc0 kernel/time/timer.c:1330
       __queue_delayed_work+0x1ba/0x2e0 kernel/workqueue.c:2543
       queue_delayed_work_on+0x12a/0x150 kernel/workqueue.c:2572
       psi_task_change+0x1b4/0x2e0 kernel/sched/psi.c:912
       psi_enqueue kernel/sched/stats.h:139 [inline]
       enqueue_task kernel/sched/core.c:2112 [inline]
       activate_task+0x213/0x400 kernel/sched/core.c:2146
       wake_up_new_task+0x574/0xc90 kernel/sched/core.c:4900
       kernel_clone+0x236/0x980 kernel/fork.c:2828
       user_mode_thread+0xb4/0xf0 kernel/fork.c:2875
       rest_init+0x23/0x2b0 init/main.c:712
       start_kernel+0x3df/0x4c0 init/main.c:1103
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x148

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
       __console_unlock kernel/printk/printk.c:2731 [inline]
       console_unlock+0x23e/0x290 kernel/printk/printk.c:3050
       vga_remove_vgacon drivers/pci/vgaarb.c:186 [inline]
       vga_remove_vgacon+0x90/0xd0 drivers/pci/vgaarb.c:167
       __aperture_remove_legacy_vga_devices drivers/video/aperture.c:331 [inline]
       aperture_remove_conflicting_pci_devices+0x17f/0x210 drivers/video/aperture.c:374
       bochs_pci_probe+0x101/0x1150 drivers/gpu/drm/tiny/bochs.c:651
       local_pci_probe+0xde/0x1b0 drivers/pci/pci-driver.c:324
       pci_call_probe drivers/pci/pci-driver.c:392 [inline]
       __pci_device_probe drivers/pci/pci-driver.c:417 [inline]
       pci_device_probe+0x294/0x7a0 drivers/pci/pci-driver.c:451
       call_driver_probe drivers/base/dd.c:578 [inline]
       really_probe+0x23e/0xa90 drivers/base/dd.c:656
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
       __driver_attach+0x283/0x580 drivers/base/dd.c:1214
       bus_for_each_dev+0x13c/0x1d0 drivers/base/bus.c:368
       bus_add_driver+0x2ed/0x640 drivers/base/bus.c:673
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
       console_trylock kernel/printk/printk.c:2684 [inline]
       console_trylock_spinning kernel/printk/printk.c:1958 [inline]
       vprintk_emit kernel/printk/printk.c:2347 [inline]
       vprintk_emit+0xe4/0x5a0 kernel/printk/printk.c:2303
       vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
       _printk+0xc8/0x100 kernel/printk/printk.c:2373
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x4ac/0x580 lib/bug.c:219
       handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       expire_timers kernel/time/timer.c:1830 [inline]
       __run_timers+0x8ec/0xaf0 kernel/time/timer.c:2417
       __run_timer_base kernel/time/timer.c:2428 [inline]
       __run_timer_base kernel/time/timer.c:2421 [inline]
       run_timer_base+0x111/0x190 kernel/time/timer.c:2437
       run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
       handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
       __do_softirq kernel/softirq.c:588 [inline]
       invoke_softirq kernel/softirq.c:428 [inline]
       __irq_exit_rcu kernel/softirq.c:637 [inline]
       irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
       sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       default_idle+0xf/0x20 arch/x86/kernel/process.c:742
       default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
       cpuidle_idle_call kernel/sched/idle.c:191 [inline]
       do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
       cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
       rest_init+0x16b/0x2b0 init/main.c:747
       start_kernel+0x3df/0x4c0 init/main.c:1103
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x148

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rq->__lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&rq->__lock);
                               lock(&base->lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

1 lock held by swapper/0/0:
 #0: ffff88802c02a858 (&base->lock){-.-.}-{2:2}, at: __run_timer_base kernel/time/timer.c:2427 [inline]
 #0: ffff88802c02a858 (&base->lock){-.-.}-{2:2}, at: __run_timer_base kernel/time/timer.c:2421 [inline]
 #0: ffff88802c02a858 (&base->lock){-.-.}-{2:2}, at: run_timer_base+0x109/0x190 kernel/time/timer.c:2437

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <IRQ>
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
 console_trylock kernel/printk/printk.c:2684 [inline]
 console_trylock_spinning kernel/printk/printk.c:1958 [inline]
 vprintk_emit kernel/printk/printk.c:2347 [inline]
 vprintk_emit+0xe4/0x5a0 kernel/printk/printk.c:2303
 vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
 _printk+0xc8/0x100 kernel/printk/printk.c:2373
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x4ac/0x580 lib/bug.c:219
 handle_bug+0x3d/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:expire_timers kernel/time/timer.c:1830 [inline]
RIP: 0010:__run_timers+0x8ec/0xaf0 kernel/time/timer.c:2417
Code: 6e 48 e8 77 34 13 00 89 de 31 ff 83 eb 01 e8 6b 2f 13 00 8b 44 24 18 85 c0 0f 85 18 fc ff ff e9 91 fb ff ff e8 55 34 13 00 90 <0f> 0b 90 e9 7b fc ff ff e8 47 34 13 00 90 0f 0b 90 e9 04 fd ff ff
RSP: 0018:ffffc90000007d58 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffe8ffad07be10 RCX: ffffffff817b4d49
RDX: ffffffff8d8957c0 RSI: ffffffff817b4ddb RDI: ffffe8ffad07be28
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc90000007e10
R13: ffffc90000007e10 R14: ffff88802c02a840 R15: dffffc0000000000
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xf/0x20 arch/x86/kernel/process.c:743
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d c3 36 48 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffffff8d807e20 EFLAGS: 00000246
RAX: 0000000000140011 RBX: 0000000000000000 RCX: ffffffff8ade3e29
RDX: 0000000000000000 RSI: ffffffff8b2cb6c0 RDI: ffffffff8b8fae60
RBP: fffffbfff1b12af8 R08: 0000000000000001 R09: ffffed1005806fe5
R10: ffff88802c037f2b R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8d8957c0 R14: ffffffff8fe29810 R15: 0000000000000000
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x16b/0x2b0 init/main.c:747
 start_kernel+0x3df/0x4c0 init/main.c:1103
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x148
 </TASK>
WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1830 expire_timers kernel/time/timer.c:1830 [inline]
WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1830 __run_timers+0x8ec/0xaf0 kernel/time/timer.c:2417
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:expire_timers kernel/time/timer.c:1830 [inline]
RIP: 0010:__run_timers+0x8ec/0xaf0 kernel/time/timer.c:2417
Code: 6e 48 e8 77 34 13 00 89 de 31 ff 83 eb 01 e8 6b 2f 13 00 8b 44 24 18 85 c0 0f 85 18 fc ff ff e9 91 fb ff ff e8 55 34 13 00 90 <0f> 0b 90 e9 7b fc ff ff e8 47 34 13 00 90 0f 0b 90 e9 04 fd ff ff
RSP: 0018:ffffc90000007d58 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffe8ffad07be10 RCX: ffffffff817b4d49
RDX: ffffffff8d8957c0 RSI: ffffffff817b4ddb RDI: ffffe8ffad07be28
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffc90000007e10
R13: ffffc90000007e10 R14: ffff88802c02a840 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f7493f1c CR3: 0000000054c9e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xf/0x20 arch/x86/kernel/process.c:743
Code: 4c 01 c7 4c 29 c2 e9 72 ff ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d c3 36 48 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90
RSP: 0018:ffffffff8d807e20 EFLAGS: 00000246
RAX: 0000000000140011 RBX: 0000000000000000 RCX: ffffffff8ade3e29
RDX: 0000000000000000 RSI: ffffffff8b2cb6c0 RDI: ffffffff8b8fae60
RBP: fffffbfff1b12af8 R08: 0000000000000001 R09: ffffed1005806fe5
R10: ffff88802c037f2b R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff8d8957c0 R14: ffffffff8fe29810 R15: 0000000000000000
 default_idle_call+0x6d/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x32c/0x3f0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x16b/0x2b0 init/main.c:747
 start_kernel+0x3df/0x4c0 init/main.c:1103
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x148
 </TASK>
----------------
Code disassembly (best guess):
   0:	4c 01 c7             	add    %r8,%rdi
   3:	4c 29 c2             	sub    %r8,%rdx
   6:	e9 72 ff ff ff       	jmp    0xffffff7d
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	f3 0f 1e fa          	endbr64
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d c3 36 48 00 	verw   0x4836c3(%rip)        # 0x4836eb
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
  37:	00 00 00 00
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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

