Return-Path: <linux-kernel+bounces-310112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEC4967522
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8211C20A97
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC033A1DC;
	Sun,  1 Sep 2024 05:41:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2479C2
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725169297; cv=none; b=c7GqbCOL1nSkPoVXVPx5EFZhdgbau4aD727bW7YK2R+t3lLKa4rLWHnzQt5nhM4uov/6XWuCnDJR5pWoLeHg9aIK1oTZpYxxLU2LEXClZcgzEmJj9+bMVTk8CHy3M5gyPzNvwlzXV6Z7ZS43w3+DyEJpzvDWBzEE/JhlzEAaws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725169297; c=relaxed/simple;
	bh=S+5z/5MnZDs/bOroiW/8lMV+1Y0bMKBaThcG/fD+2D4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QTl+xaTaiAd5sirNh4XBvecfEmN4kcc4u1+qm18li1H899ur973lPE2J4InfHPvuarrxOLjTYqe1SvJvhbhyWl5R0OvfpoZejZmhWqSTIE03L+4Iefx+uh95AcaFOeOyuuOC4gpXi2o3dNCnmkSljbbFnnJe+2q1u6L1fpmXF7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d52097234so39002485ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 22:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725169294; x=1725774094;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIZDz1MNPEF8S0Ql9BWs3MfJckFnAhuvNdTm/nxggoc=;
        b=UX4b1Nvn/jHkm5YAezqA+BEBgwuxqkar+U0vCRcwg//+LAhbcq1xsb/6ye4MkPQIQH
         Em30ORQnAqlQjV8AhJ1zU0lPXg3rdHQFAURyZd7wCs8uYbLYlDBbdmlBxFy4Fg3pMJI9
         5uTjyG7u2zBaRhAvHvHDHaxLKPZcoBs4rlJQMBZ5KfJo2xoG4rHyO17C+q1qEk+u2gmx
         SzHzpp8ChGgoJZ7GK7LFyNgeHzVSFrhU/UxzRT0i4HdhfP6wvrjx6BrTVByk11Z22sEG
         ZfcEDv8KJ/nDu+nv+WjE1KIKJtN1cQzPbPWLSO2Mr1eAremRtMzQomfAc768Nn/KKTQr
         jDwA==
X-Gm-Message-State: AOJu0Yw9lXFTy5L/hUOoHmxHzkVJx41nUCt0YNfbhI5i/eInVoL3EnX4
	h86eAbjDPpYIudw9IlMCyLmtQM451D8eG+1HYfGekxm5jVc7G6C7y1MO0z3D/7R1ILz3jjBBDV2
	nTwiNJ17qhDwsb1xoXd/qYPEMqXnJ5K5T/0qzFjoz01pU96lH0BD4YQw=
X-Google-Smtp-Source: AGHT+IH8GQvksz1PY2ch8s2Aes/0gUSKNsrpyQrmXockWKvQGf4lapNJ/dAO27j1pixOKXqXNwwqtBOBqbeJGDuD6mr23tYqKlHc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:39f:5407:a61f with SMTP id
 e9e14a558f8ab-39f5407a8e4mr1390775ab.5.1725169294446; Sat, 31 Aug 2024
 22:41:34 -0700 (PDT)
Date: Sat, 31 Aug 2024 22:41:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f92273062108460b@google.com>
Subject: [syzbot] [kernel?] possible deadlock in try_to_wake_up (6)
From: syzbot <syzbot+353ce01560bf76a2c560@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6f923748057a Add linux-next specific files for 20240827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=133d797b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65c4a779aad2633f
dashboard link: https://syzkaller.appspot.com/bug?extid=353ce01560bf76a2c560
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4398d0ec73ed/disk-6f923748.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f7e004ef90a/vmlinux-6f923748.xz
kernel image: https://storage.googleapis.com/syzbot-assets/333e975a3aac/bzImage-6f923748.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+353ce01560bf76a2c560@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.11.0-rc5-next-20240827-syzkaller #0 Not tainted
-----------------------------------------------------
syz.0.48/5524 [HC1[1]:SC0[0]:HE0:SE1] is trying to acquire:
ffffffff8e8151e0 (console_lock){+.+.}-{0:0}, at: _printk+0xd5/0x120 kernel/printk/printk.c:2424

and this task is already holding:
ffff8880119ec618 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
ffff8880119ec618 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4150
which would create a new lock dependency:
 (&p->pi_lock){-.-.}-{2:2} -> (console_lock){+.+.}-{0:0}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&p->pi_lock){-.-.}-{2:2}

... which became HARDIRQ-irq-safe at:
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
  try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4150
  autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
  __wake_up_common kernel/sched/wait.c:89 [inline]
  __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
  irq_work_single+0xe2/0x240 kernel/irq_work.c:221
  irq_work_run_list kernel/irq_work.c:252 [inline]
  irq_work_run+0x18b/0x350 kernel/irq_work.c:261
  __sysvec_irq_work+0xb8/0x430 arch/x86/kernel/irq_work.c:22
  instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
  sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
  asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
  __wrmsr arch/x86/include/asm/msr.h:96 [inline]
  native_write_msr arch/x86/include/asm/msr.h:147 [inline]
  wrmsr arch/x86/include/asm/msr.h:256 [inline]
  native_apic_msr_write+0x39/0x50 arch/x86/include/asm/apic.h:212
  __apic_send_IPI_self arch/x86/include/asm/apic.h:455 [inline]
  arch_irq_work_raise+0x6f/0x80 arch/x86/kernel/irq_work.c:31
  irq_work_queue+0xa7/0x150 kernel/irq_work.c:124
  __kfence_alloc+0x241/0x370 mm/kfence/core.c:1112
  kfence_alloc include/linux/kfence.h:129 [inline]
  slab_alloc_node mm/slub.c:4073 [inline]
  __do_kmalloc_node mm/slub.c:4209 [inline]
  __kmalloc_noprof+0x374/0x400 mm/slub.c:4222
  kmalloc_noprof include/linux/slab.h:685 [inline]
  kzalloc_noprof include/linux/slab.h:817 [inline]
  __alloc_workqueue+0x10a/0x1f20 kernel/workqueue.c:5654
  alloc_workqueue+0xd6/0x210 kernel/workqueue.c:5757
  init_mm_internals+0x17/0x120 mm/vmstat.c:2183
  kernel_init_freeable+0x403/0x5d0 init/main.c:1566
  kernel_init+0x1d/0x2b0 init/main.c:1469
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

to a HARDIRQ-irq-unsafe lock:
 (console_lock){+.+.}-{0:0}

... which became HARDIRQ-irq-unsafe at:
...
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
  console_lock+0x164/0x1b0 kernel/printk/printk.c:2792
  con_init+0x1c/0x9c0 drivers/tty/vt/vt.c:3627
  console_init+0x1b8/0x6f0 kernel/printk/printk.c:3919
  start_kernel+0x2d8/0x500 init/main.c:1040
  x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
  x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
  common_startup_64+0x13e/0x147

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               local_irq_disable();
                               lock(&p->pi_lock);
                               lock(console_lock);
  <Interrupt>
    lock(&p->pi_lock);

 *** DEADLOCK ***

6 locks held by syz.0.48/5524:
 #0: ffff8881427e3d58 (&x->wait#13){-.-.}-{2:2}, at: complete_with_flags kernel/sched/completion.c:20 [inline]
 #0: ffff8881427e3d58 (&x->wait#13){-.-.}-{2:2}, at: complete+0x28/0x1c0 kernel/sched/completion.c:47
 #1: ffff8880119ec618 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
 #1: ffff8880119ec618 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4150
 #2: ffffffff8e8151e0 (console_lock){+.+.}-{0:0}, at: _printk+0xd5/0x120 kernel/printk/printk.c:2424
 #3: ffffffff8e814df0 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:342 [inline]
 #3: ffffffff8e814df0 (console_srcu){....}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:267 [inline]
 #3: ffffffff8e814df0 (console_srcu){....}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:287 [inline]
 #3: ffffffff8e814df0 (console_srcu){....}-{0:0}, at: console_flush_all+0x147/0xf50 kernel/printk/printk.c:3068
 #4: ffffffff8e815180 (console_owner){-...}-{0:0}, at: rcu_try_lock_acquire include/linux/rcupdate.h:342 [inline]
 #4: ffffffff8e815180 (console_owner){-...}-{0:0}, at: srcu_read_lock_nmisafe include/linux/srcu.h:267 [inline]
 #4: ffffffff8e815180 (console_owner){-...}-{0:0}, at: console_srcu_read_lock kernel/printk/printk.c:287 [inline]
 #4: ffffffff8e815180 (console_owner){-...}-{0:0}, at: console_flush_all+0x147/0xf50 kernel/printk/printk.c:3068
 #5: ffffffff952e0eb8 (&port_lock_key){-.-.}-{2:2}, at: uart_port_lock_irqsave include/linux/serial_core.h:711 [inline]
 #5: ffffffff952e0eb8 (&port_lock_key){-.-.}-{2:2}, at: serial8250_console_write+0x1a7/0x1ed0 drivers/tty/serial/8250/8250_port.c:3352

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&p->pi_lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
                    try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4150
                    autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
                    __wake_up_common kernel/sched/wait.c:89 [inline]
                    __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
                    irq_work_single+0xe2/0x240 kernel/irq_work.c:221
                    irq_work_run_list kernel/irq_work.c:252 [inline]
                    irq_work_run+0x18b/0x350 kernel/irq_work.c:261
                    __sysvec_irq_work+0xb8/0x430 arch/x86/kernel/irq_work.c:22
                    instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
                    sysvec_irq_work+0x9e/0xc0 arch/x86/kernel/irq_work.c:17
                    asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
                    __wrmsr arch/x86/include/asm/msr.h:96 [inline]
                    native_write_msr arch/x86/include/asm/msr.h:147 [inline]
                    wrmsr arch/x86/include/asm/msr.h:256 [inline]
                    native_apic_msr_write+0x39/0x50 arch/x86/include/asm/apic.h:212
                    __apic_send_IPI_self arch/x86/include/asm/apic.h:455 [inline]
                    arch_irq_work_raise+0x6f/0x80 arch/x86/kernel/irq_work.c:31
                    irq_work_queue+0xa7/0x150 kernel/irq_work.c:124
                    __kfence_alloc+0x241/0x370 mm/kfence/core.c:1112
                    kfence_alloc include/linux/kfence.h:129 [inline]
                    slab_alloc_node mm/slub.c:4073 [inline]
                    __do_kmalloc_node mm/slub.c:4209 [inline]
                    __kmalloc_noprof+0x374/0x400 mm/slub.c:4222
                    kmalloc_noprof include/linux/slab.h:685 [inline]
                    kzalloc_noprof include/linux/slab.h:817 [inline]
                    __alloc_workqueue+0x10a/0x1f20 kernel/workqueue.c:5654
                    alloc_workqueue+0xd6/0x210 kernel/workqueue.c:5757
                    init_mm_internals+0x17/0x120 mm/vmstat.c:2183
                    kernel_init_freeable+0x403/0x5d0 init/main.c:1566
                    kernel_init+0x1d/0x2b0 init/main.c:1469
                    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
   IN-SOFTIRQ-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                    class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
                    try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4150
                    call_timer_fn+0x18e/0x650 kernel/time/timer.c:1794
                    expire_timers kernel/time/timer.c:1845 [inline]
                    __run_timers kernel/time/timer.c:2419 [inline]
                    __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2430
                    run_timer_base kernel/time/timer.c:2439 [inline]
                    run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2449
                    handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
                    __do_softirq kernel/softirq.c:588 [inline]
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
                    irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1037 [inline]
                    sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1037
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
                    default_idle+0x13/0x20 arch/x86/kernel/process.c:742
                    default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
                    cpuidle_idle_call kernel/sched/idle.c:185 [inline]
                    do_idle+0x22f/0x5d0 kernel/sched/idle.c:326
                    cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
                    rest_init+0x2dc/0x300 init/main.c:747
                    start_kernel+0x47f/0x500 init/main.c:1105
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                    x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
                   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
                   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
                   sched_cgroup_fork+0x33/0x420 kernel/sched/core.c:4731
                   copy_process+0x21c1/0x3d50 kernel/fork.c:2481
                   kernel_clone+0x226/0x8f0 kernel/fork.c:2784
                   user_mode_thread+0x132/0x1a0 kernel/fork.c:2862
                   rest_init+0x23/0x300 init/main.c:712
                   start_kernel+0x47f/0x500 init/main.c:1105
                   x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                   x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
                   common_startup_64+0x13e/0x147
 }
 ... key      at: [<ffffffff9319b980>] rt_mutex_init_task.__key+0x0/0x20

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (console_lock){+.+.}-{0:0} {
   HARDIRQ-ON-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
                    console_lock+0x164/0x1b0 kernel/printk/printk.c:2792
                    con_init+0x1c/0x9c0 drivers/tty/vt/vt.c:3627
                    console_init+0x1b8/0x6f0 kernel/printk/printk.c:3919
                    start_kernel+0x2d8/0x500 init/main.c:1040
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                    x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
                    common_startup_64+0x13e/0x147
   SOFTIRQ-ON-W at:
                    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
                    console_lock+0x164/0x1b0 kernel/printk/printk.c:2792
                    con_init+0x1c/0x9c0 drivers/tty/vt/vt.c:3627
                    console_init+0x1b8/0x6f0 kernel/printk/printk.c:3919
                    start_kernel+0x2d8/0x500 init/main.c:1040
                    x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
                    x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
                    common_startup_64+0x13e/0x147
   INITIAL USE at:
 }
 ... key      at: [<ffffffff8e8151e0>] console_lock_dep_map+0x0/0x60
 ... acquired at:
   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
   _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
   raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:595
   raw_spin_rq_lock kernel/sched/sched.h:1488 [inline]
   __task_rq_lock+0xdf/0x3e0 kernel/sched/core.c:665
   ttwu_runnable kernel/sched/core.c:3728 [inline]
   try_to_wake_up+0x182/0x1480 kernel/sched/core.c:4180
   swake_up_locked kernel/sched/swait.c:29 [inline]
   complete_with_flags kernel/sched/completion.c:24 [inline]
   complete+0xac/0x1c0 kernel/sched/completion.c:47
   random_recv_done+0x138/0x1e0 drivers/char/hw_random/virtio-rng.c:48
   vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
   __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
   handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
   handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
   handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
   generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
   handle_irq arch/x86/kernel/irq.c:247 [inline]
   call_irq_handler arch/x86/kernel/irq.c:259 [inline]
   __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
   common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278


stack backtrace:
CPU: 1 UID: 0 PID: 5524 Comm: syz.0.48 Not tainted 6.11.0-rc5-next-20240827-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_bad_irq_dependency kernel/locking/lockdep.c:2647 [inline]
 check_irq_usage kernel/locking/lockdep.c:2888 [inline]
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x4ebd/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:595
 raw_spin_rq_lock kernel/sched/sched.h:1488 [inline]
 __task_rq_lock+0xdf/0x3e0 kernel/sched/core.c:665
 ttwu_runnable kernel/sched/core.c:3728 [inline]
 try_to_wake_up+0x182/0x1480 kernel/sched/core.c:4180
 swake_up_locked kernel/sched/swait.c:29 [inline]
 complete_with_flags kernel/sched/completion.c:24 [inline]
 complete+0xac/0x1c0 kernel/sched/completion.c:47
 random_recv_done+0x138/0x1e0 drivers/char/hw_random/virtio-rng.c:48
 vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
 __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
 handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
 common_interrupt+0xb4/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
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

