Return-Path: <linux-kernel+bounces-262806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF6B93CCF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410552827D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971722616;
	Fri, 26 Jul 2024 03:22:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB01CAB9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964128; cv=none; b=FHlC93547xcHpaYHFf971aBiJOyzjrq7cDgauRbg1pQJeJLEiWKoTYSOeGMsd5ZNpSlnDQFSJXG6x9pa4SCHnM/MUBkVXiOi70ILNjclDXJe7JgxeHsuJ4pxlLzrCG4xJixqqsgu2x1UABkxUXmfT5KPZX5gLAZMzqxhT/8dl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964128; c=relaxed/simple;
	bh=ro3iKnbMQtqYowb45ufgUYfDxQ7IZiVOnH8ZYarGiv8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U4M1AlMcL7kQ8hjyjF7zEGoQa2M/zJHX9YkYy/SmHhk4W1t+iyXJpN9fFR+8gfOinXZ9TCSsgh1XY3rRevkmEQpIuhdVsHI151vh+01WtJnQDEcoo0Cv3RRs8Th0YbnpSM9yjqYguqwKhRGCM/nbPQSjXkXV1HuomhcCoyLUbbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8edd7370so16114139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721964126; x=1722568926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMWe3VGOMpM4BuWS3K1N2slmlhAKbh3v9xBMwhnsn0A=;
        b=g7lmb4F1+cUyaQubisA8SxFBh0AilPZZ++t1UmYAvsUCJbw290m2ylJx5+PcA+9x6l
         xj4Hb6jYOVmzuHP7KPLf3Lskc4R629lTlE3RT6sqZKJSSiUj11aoovAERIi+M3Bfq4kA
         QG/jnHtxHmUqFJ+XnTD2uL9q7WidSofp8+n9kZr20y3jwH6kHxzlu7arh6s8Msl1k0Ex
         OznXUhgXW0mt4J3Ly7ymJKa427Da/cSAxN70JSXfNasR6AlCWcmMMUnLRflMViDENLMy
         38Qu4Xy+h+0s+1JVI4QgTnf0PSQ6Sola62qXz0jUPOPh3i8iVkHiC6HhXrzoN9v60UCy
         4SPw==
X-Gm-Message-State: AOJu0YyCMbZpuRKr41QT2Fnnr0P4TT0dSeY9F5Q9gXAft3CN/9q8eSxc
	Md1OWt/zt5PvXJUBQ75cTlo+aLq6maQdCCJr2UDt48lfuRm4Rr2i0PSYMSIRIYtpbLW9XoXGJBX
	5ZrKfUXnV1iQdCdgcoWx7uzbBRoEZFkAC7qjAPpJtVR/u625B6vqCIuM=
X-Google-Smtp-Source: AGHT+IFHm2uMgMmZacxSLIRvNJYyP/ZIPG2vbUw1s6ybeYoEOF3z6krXEP20h1WoOOg6PPbjhhIv7Ht3Sn8wHjGInNFlgYNliDcv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:851d:b0:4c0:ac4e:3295 with SMTP id
 8926c6da1cb9f-4c2a11f718emr199500173.6.1721964125623; Thu, 25 Jul 2024
 20:22:05 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:22:05 -0700
In-Reply-To: <20240726031006.1638065-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000062c52061e1e04d7@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] KASAN: use-after-free Read in rtw_load_firmware_cb
From: syzbot <syzbot+6c6c08700f9480c41fe3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in rtw_core_deinit

INFO: task kworker/1:2:43 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:24656 pid:43    tgid:43    ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 rtw_wait_firmware_completion drivers/net/wireless/realtek/rtw88/main.c:1318 [inline]
 rtw_core_deinit+0x54/0x470 drivers/net/wireless/realtek/rtw88/main.c:2177
 rtw_usb_probe+0x722/0x1d80 drivers/net/wireless/realtek/rtw88/usb.c:919
 usb_probe_interface+0x309/0x9d0 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:532
 device_add+0x114b/0x1a70 drivers/base/core.c:3679
 usb_set_configuration+0x10cb/0x1c50 drivers/usb/core/message.c:2210
 usb_generic_driver_probe+0xb1/0x110 drivers/usb/core/generic.c:254
 usb_probe_device+0xec/0x3e0 drivers/usb/core/driver.c:294
 call_driver_probe drivers/base/dd.c:578 [inline]
 really_probe+0x23e/0xa90 drivers/base/dd.c:656
 __driver_probe_device+0x1de/0x440 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:828
 __device_attach_driver+0x1df/0x310 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1e0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
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
INFO: task udevd:4693 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:28192 pid:4693  tgid:4693  ppid:2542   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xcda/0x2f80 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2743
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4fa/0x12c0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x41a/0x590 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x869/0xbd0 fs/read_write.c:476
 ksys_read+0x12f/0x260 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc09dbe6b6a
RSP: 002b:00007ffeeeede0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055be06becc90 RCX: 00007fc09dbe6b6a
RDX: 0000000000001000 RSI: 000055be06bc49f0 RDI: 0000000000000008
RBP: 000055be06becc90 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffeeeede598 R15: 000000000000000a
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff88cb67a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff88cb67a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff88cb67a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6620
5 locks held by kworker/1:2/43:
 #0: ffff8881052d7548 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900004e7d80 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffff888109b65190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888109b65190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1be/0x4f50 drivers/usb/core/hub.c:5849
 #3: ffff888115c04190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888115c04190 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
 #4: ffff88810cb94160 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88810cb94160 (&dev->mutex){....}-{3:3}, at: __device_attach+0x7f/0x4b0 drivers/base/dd.c:1003
2 locks held by getty/2600:
 #0: ffff888100ea60a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
4 locks held by udevd/4693:
 #0: ffff8881073590a0 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: ffff8881158cac88 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888122e35788 (kn->active#5){.+.+}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888115c04190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888115c04190 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2743

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf4e/0x1280 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:111


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14fba1f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f828342678294017
dashboard link: https://syzkaller.appspot.com/bug?extid=6c6c08700f9480c41fe3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15585a03980000


