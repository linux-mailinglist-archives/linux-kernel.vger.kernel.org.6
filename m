Return-Path: <linux-kernel+bounces-191789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A48D141C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA361F22BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9254F881;
	Tue, 28 May 2024 06:00:31 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1212DF6B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876030; cv=none; b=Ll6GWZ7hW3Q6l3JaPl1CGe6zvWVD40HL4Wf64fTcaibpMNM1Zg3zSRD/qvlfcSIOH6Do26iOV1OD4RTW08h5Euy4xIyLpcgJnxtl/zV/GQmjKYqY+5n8E6Q0kclufr0f+WUqinRtuz97XjmK7LDfhXx35redJ3DeY/19Xj7WJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876030; c=relaxed/simple;
	bh=jUfnTCIBhYSCGU/0EY0MfWVpPhdKwITIwg6eQqdM3QI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WlnMvQM6pE+WTXVpSI4Oa+dwxVUyuInwFEyF4J0QH9DIg+MRAxhG4Lz9vEDUr9TJjfGlOjsGpSmWeIZ08I+sMwLAINPoDs8nzuYwmigjPv3JvbsbhocpOMc6RT1L4LnI8aQaYzZ2h/aWGqLxx30o7Gfu8Bjl3y7Ls72WrOsciQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eac412397cso48141539f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716876028; x=1717480828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2crGo9i66M1InS6Gjyvhueqv5w4GPlrmPx/+6ovFhtk=;
        b=DwtMA5th6h4AAC2tQCYzimJiWfjcw4e4zG3EbkXExodB/qsdCX8MPIpTnWHUiGCRb/
         0cEBJrkRQePgLC1oISL/fanlOxgSpmPtcH4V+uOpPhw6jM2MUvrtW5Y7gPqRrOZE/jvD
         NP/xqqkAvZnKcIa0iQOrRIuBSRksW1+n8UICgfvTnXOndYCuhKGVXK6VaSdkQx925NLN
         4Z3z5yB9XEpQLinhxBHCwROfJJ9rBeBRIVIiyD+2UOUpTM3wJGertPCrNAVMkQ6NicIG
         oFO8CMDpvDtmOY0xOEnvd2aDIvDIhcnojotREx2tI7qpOkLexAoBYTMZr6ek19+vnp7m
         T1gA==
X-Forwarded-Encrypted: i=1; AJvYcCXXbmhHeWnJUVA3IqVwHKmEOgBJ/DkC6uTnoSzdoV/FZHdWR0C6eRcJCLsZOf94JwblsDRQWtiLPVFTK2RwDuDagvXkLfHuYMY6QQ5K
X-Gm-Message-State: AOJu0Yy37pGxo0d9ZtkcWoTL+ibpXWk5NVNnFffpcpiguwoCUb3llhja
	KfU2IRwdsD4JfZ3V6s886V8nDW2wAKm6x4cQbBCeGiZtmlF63sBpMqVWCVil+dNw4Ewquj9Y2bL
	Iignaj29M6Sskz/GXOKMacbZUPL5C28IybDvmu4OrN0jAHHEpUluUxig=
X-Google-Smtp-Source: AGHT+IFdA7YF1hw5t6TgwgpG9+cw3kWRwjzB7DyHE+Eqgcq8InR1EJDqYsK8yR+3IrdFy6eaV2P5quZlJJiRk3KVVQvzkeYEC45j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd4:b0:7e2:2c72:c60f with SMTP id
 ca18e2360f4ac-7e8c6f10033mr65104639f.3.1716876027782; Mon, 27 May 2024
 23:00:27 -0700 (PDT)
Date: Mon, 27 May 2024 23:00:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c27c9e06197d59c3@google.com>
Subject: [syzbot] [kernfs?] [usb?] INFO: task hung in kernfs_add_one
From: syzbot <syzbot+e4804edf2708e8b7d2a5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    124cfbcd6d18 Add linux-next specific files for 20240521
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1504223c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c3a67a38201bdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15083952980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dee7dc980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff8e45d8b821/disk-124cfbcd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6aeeec759cde/vmlinux-124cfbcd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e7d931d0a4b/bzImage-124cfbcd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4804edf2708e8b7d2a5@syzkaller.appspotmail.com

INFO: task kworker/0:1:9 blocked for more than 142 seconds.
      Not tainted 6.9.0-next-20240521-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D
 stack:20248 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_write_slowpath+0xeeb/0x13b0 kernel/locking/rwsem.c:1178
 __down_write_common+0x1af/0x200 kernel/locking/rwsem.c:1306
 kernfs_add_one+0x9a/0x8b0 fs/kernfs/dir.c:778
 kernfs_create_dir_ns+0xd9/0x120 fs/kernfs/dir.c:1071
 sysfs_create_dir_ns+0x189/0x3a0 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:73 [inline]
 kobject_add_internal+0x435/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 device_add+0x4e5/0xbf0 drivers/base/core.c:3659
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2651
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task udevd:4548 blocked for more than 143 seconds.
      Not tainted 6.9.0-next-20240521-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:23504 pid:4548  tgid:4548  ppid:1      flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a50 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 rwsem_down_read_slowpath kernel/locking/rwsem.c:1086 [inline]
 __down_read_common kernel/locking/rwsem.c:1250 [inline]
 __down_read kernel/locking/rwsem.c:1263 [inline]
 down_read+0x705/0xa40 kernel/locking/rwsem.c:1528
 kernfs_dop_revalidate+0xd4/0x560 fs/kernfs/dir.c:1159
 lookup_fast+0x1f4/0x4a0
 walk_component fs/namei.c:2000 [inline]
 link_path_walk+0x60b/0xea0 fs/namei.c:2331
 path_openat+0x24a/0x3280 fs/namei.c:3803
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f70465169a4
RSP: 002b:00007fffc17353f0 EFLAGS: 00000246
 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f70465169a4
RDX: 0000000000080000 RSI: 00007fffc1735528 RDI: 00000000ffffff9c
RBP: 00007fffc1735528 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000055e1b688db42 R14: 0000000000000001 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/0:1/9:
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900000e7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900000e7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023c1b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023c1b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff8880b943e7d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
3 locks held by kworker/1:0/25:
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900001f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900001f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023d13190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023d13190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
1 lock held by khungtaskd/30:
 #0: ffffffff8e333e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333e20 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/1:1/45:
6 locks held by kworker/0:2/931:
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900043bfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900043bfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023d2b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023d2b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888023d2e518 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #3: ffff888023d2e518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5418 [inline]
 #3: ffff888023d2e518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 #3: ffff888023d2e518 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5821 [inline]
 #3: ffff888023d2e518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x25b6/0x5150 drivers/usb/core/hub.c:5903
 #4: ffff888022092b68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5419 [inline]
 #4: ffff888022092b68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 #4: ffff888022092b68 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5821 [inline]
 #4: ffff888022092b68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x25f4/0x5150 drivers/usb/core/hub.c:5903
 #5: ffffffff8ef1eb10 (ehci_cf_port_reset_rwsem){.+.+}-{3:3}, at: hub_port_reset+0x1f8/0x1b30 drivers/usb/core/hub.c:3021
2 locks held by getty/4852:
 #0: ffff88802aadd0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
6 locks held by kworker/0:6/5120:
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900036dfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900036dfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023c8b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023c8b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888023c8e518 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #3: ffff888023c8e518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5418 [inline]
 #3: ffff888023c8e518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 #3: ffff888023c8e518 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5821 [inline]
 #3: ffff888023c8e518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x25b6/0x5150 drivers/usb/core/hub.c:5903
 #4: ffff8880226ed968 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5419 [inline]
 #4: ffff8880226ed968 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 #4: ffff8880226ed968 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5821 [inline]
 #4: ffff8880226ed968 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x25f4/0x5150 drivers/usb/core/hub.c:5903
 #5: ffffffff8ef1eb10 (ehci_cf_port_reset_rwsem){.+.+}-{3:3}, at: hub_port_reset+0x1f8/0x1b30 drivers/usb/core/hub.c:3021
6 locks held by kworker/1:5/5161:
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff888017eb3d48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc900037bfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc900037bfd00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff888023dbb190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023dbb190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
 #3: ffff888023dbe518 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3206 [inline]
 #3: ffff888023dbe518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5418 [inline]
 #3: ffff888023dbe518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 #3: ffff888023dbe518 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5821 [inline]
 #3: ffff888023dbe518 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x25b6/0x5150 drivers/usb/core/hub.c:5903
 #4: ffff8880228d4468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5419 [inline]
 #4: ffff8880228d4468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 #4: ffff8880228d4468 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5821 [inline]
 #4: ffff8880228d4468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x25f4/0x5150 drivers/usb/core/hub.c:5903
 #5: ffff8880b953e7d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.9.0-next-20240521-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5120 Comm: kworker/0:6 Not tainted 6.9.0-next-20240521-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:__this_cpu_preempt_check+0xe/0x20 lib/smp_processor_id.c:66
Code: ff 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 c7 c7 00 e3 1f 8c <e9> bd fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90
RSP: 0018:ffffc90000007a98 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 000000000000002f RCX: dffffc0000000000
RDX: 1ffff92000000f6c RSI: ffffffff8bca7a40 RDI: ffffffff8c1fe300
RBP: ffffc90000007bf0 R08: ffffffff8fad4c6f R09: 1ffffffff1f5a98d
R10: dffffc0000000000 R11: ffffffff816a72c0 R12: ffff888020189e00
R13: 0000000000000008 R14: ffff888020189e48 R15: 000000000000001d
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff2c5e1bc0 CR3: 000000002faa8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 wake_wide kernel/sched/fair.c:7033 [inline]
 select_task_rq_fair+0x32a/0x3b70 kernel/sched/fair.c:8216
 select_task_rq kernel/sched/core.c:3637 [inline]
 try_to_wake_up+0x648/0x1470 kernel/sched/core.c:4363
 hrtimer_wakeup+0x62/0x80 kernel/time/hrtimer.c:1923
 __run_hrtimer kernel/time/hrtimer.c:1687 [inline]
 __hrtimer_run_queues+0x5a5/0xd50 kernel/time/hrtimer.c:1751
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1813
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2007 [inline]
RIP: 0010:vprintk_emit+0x576/0x770 kernel/printk/printk.c:2344
Code: 11 20 00 4c 21 e3 0f 85 3a 01 00 00 e8 93 0c 20 00 4d 89 ec 4d 85 ff 75 07 e8 86 0c 20 00 eb 06 e8 7f 0c 20 00 fb 44 8b 3c 24 <48> c7 c7 e0 f8 20 8e 31 f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00
RSP: 0018:ffffc900036df020 EFLAGS: 00000293
RAX: ffffffff81765931 RBX: 0000000000000000 RCX: ffff888022b18000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900036df110 R08: ffffffff8176590f R09: 1ffffffff25f70be
R10: dffffc0000000000 R11: fffffbfff25f70bf R12: dffffc0000000000
R13: dffffc0000000000 R14: ffffffff8176578f R15: 0000000000000048
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4951
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4962
 _dev_notice+0x122/0x170 drivers/base/core.c:5019
 usb_parse_configuration drivers/usb/core/config.c:639 [inline]
 usb_get_configuration+0x4829/0x4e10 drivers/usb/core/config.c:944
 usb_enumerate_device drivers/usb/core/hub.c:2483 [inline]
 usb_new_device+0x14a/0x19a0 drivers/usb/core/hub.c:2621
 hub_port_connect drivers/usb/core/hub.c:5521 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x2d6a/0x5150 drivers/usb/core/hub.c:5903
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.234 msecs


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

