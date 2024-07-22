Return-Path: <linux-kernel+bounces-258699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB89938BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94FB1C21174
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36C1684AC;
	Mon, 22 Jul 2024 09:12:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B801BC40
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639548; cv=none; b=neHMWR54iIDA2IU95yfOI49qqzw3/q01TlvI8KcC+7MPJ3ax/JXqSC2jnopBGmSJP1IIG3hHgcUBG+cv3KN6TAyXFY2eGfRRIhPLquouH0ZHt5gqFBVZKphJRjBtFqzZXQN5hJVG1VYA/ymorgM0V6IJTO0YioqXMyFWTqQQbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639548; c=relaxed/simple;
	bh=vuzsx8X3F947W+V5sldgEag5+Si6cgbAsYchtjG8Y+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=moVnxjxCxFoKTSRouH2/JhJier9aGa78AmWR20chjpjHJQlF4VvqGorcWRaFbJjy0LFN6eg+Lotfa6451PQfBo8tNopbbdYoQZUzP+FH0P3hqNCi4Y59Ps6KfPKycNyqwpDfKBLxYXd4Sellwj9onVant4uj7+azgLp5iejDFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso652658639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639545; x=1722244345;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ra2H9wEakjvGaNIr3yQeS3+qDA7QTFBfka2PY6Ll2Y=;
        b=bEZN+YAh06SVlGyYUPnbw3W7CnKFyoCUSBzprE5OJRFn9E0/MJWH6NGfb5bDpyXa2x
         mUqGkSG4QBvNu6LiVihXbujIwjrqBbJAtgDMeTGU17/lbjnsGVGjx4mMqvyw9au2756q
         q5rJGWEbTD/UG6KZ8Chx07l56KHBQKBs+EMUwBxmLX3fmBQi8qFw9pAjn3sI5v9myDmn
         s1Ri6nMrcm+M1Elb7EGR7KYiasov3B3gI22TqnmUrzEY9VimGO2URp0FBbwGMjxdMYTY
         xJlw0Z8zVpqBOaTGCgB/RytGWwyx7QXMYYbKsd/dRm/k6tzHUbPtbK4cR8u77Kt2ZEv0
         g7OA==
X-Forwarded-Encrypted: i=1; AJvYcCU05McKtEfJoetPL/7IAfu8erug+9ulkCUWt8lN1/E3lZwMiEUwg7qm077Vfd6fnU3rD0PdI4vAYEtLutaSlv7sQ3A6ZbEQz5m7+4bE
X-Gm-Message-State: AOJu0YwQfoCPvIOUT9W4JGN8ZtLdpKtY2FHG6N112ypZH6HsBdJf0bC8
	+efPO0L/1Ps3/Mqj+GNaIGkTOm0RMuEDOoSp9MZg94SmtoQ76GeOFYDLA2WaPMFpqqD6sr3H4Cm
	ZFrFtJKCYKp8Kl/nCj4xUdtyxgBfK8gbqgAIUc6BZAzwb3hL9CGKbP0E=
X-Google-Smtp-Source: AGHT+IG+qhJKC6l+qBpuPScYAvVQYCSi+ZdFmIKY4k9wwOpNUomPv/GuxBYKtP7cG6IWWJU63EXUx5xOC5NaSppEkwpuwImOLZEn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c97:b0:4c0:9380:a262 with SMTP id
 8926c6da1cb9f-4c23fcac62amr598211173.1.1721639545328; Mon, 22 Jul 2024
 02:12:25 -0700 (PDT)
Date: Mon, 22 Jul 2024 02:12:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087e83e061dd271bd@google.com>
Subject: [syzbot] [kernfs?] INFO: task hung in eventpoll_release_file (2)
From: syzbot <syzbot+63ab1a905aebbf410bb7@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107fc8ad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e322acd9c27a6b84
dashboard link: https://syzkaller.appspot.com/bug?extid=63ab1a905aebbf410bb7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8cec92a118c/disk-2c9b3512.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1c7f994c6794/vmlinux-2c9b3512.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb4ba0c8b106/bzImage-2c9b3512.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63ab1a905aebbf410bb7@syzkaller.appspotmail.com

INFO: task syz.1.3178:16374 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.3178      state:D stack:21488 pid:16374 tgid:16374 ppid:15688  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 eventpoll_release_file+0xcb/0x1c0 fs/eventpoll.c:1106
 eventpoll_release include/linux/eventpoll.h:53 [inline]
 __fput+0x6e0/0x8a0 fs/file_table.c:413
 task_work_run+0x251/0x310 kernel/task_work.c:222
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa457b75b59
RSP: 002b:00007fff0d9e3078 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fa457d07a60 RCX: 00007fa457b75b59
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fa457d07a60 R08: 0000000000000006 R09: 0000000b0d9e339f
R10: 00000000003ffc34 R11: 0000000000000246 R12: 00000000000e759f
R13: 0000000000000032 R14: 00007fa457d07a60 R15: 00007fa457d06038
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u8:0/11:
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015ed5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000107d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000107d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f5fb450 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
1 lock held by khungtaskd/30:
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8e336e60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
2 locks held by getty/4853:
 #0: ffff88802f9200a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031232f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by kworker/u8:14/9150:
 #0: ffff88802a2ba148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802a2ba148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000390fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000390fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
3 locks held by kworker/u9:2/15691:
 #0: ffff88807ee6f948 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807ee6f948 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009827d00 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009827d00 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888067460d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_open net/bluetooth/hci_core.c:417 [inline]
 #2: ffff888067460d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_error_reset+0x15e/0x3f0 net/bluetooth/hci_core.c:1024
1 lock held by syz.0.3037/15888:
1 lock held by syz.1.3178/16374:
 #0: ffff88807548fc68 (&ep->mtx){+.+.}-{3:3}, at: eventpoll_release_file+0xcb/0x1c0 fs/eventpoll.c:1106
3 locks held by syz.1.3178/16375:
1 lock held by syz.2.3216/16504:
 #0: ffff888022e4c468 (&ep->mtx){+.+.}-{3:3}, at: eventpoll_release_file+0xcb/0x1c0 fs/eventpoll.c:1106
2 locks held by syz.2.3216/16505:
1 lock held by syz.0.3239/16605:
 #0: ffff88801e471468 (&ep->mtx){+.+.}-{3:3}, at: eventpoll_release_file+0xcb/0x1c0 fs/eventpoll.c:1106
9 locks held by syz.0.3239/16607:
1 lock held by syz-executor/16970:
 #0: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/16999:
 #0: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
8 locks held by syz-executor/17126:
 #0: ffff88801e51c420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2876 [inline]
 #0: ffff88801e51c420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x227/0xc90 fs/read_write.c:586
 #1: ffff88801e517488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1eb/0x500 fs/kernfs/file.c:325
 #2: ffff888022649968 (kn->active#51){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20f/0x500 fs/kernfs/file.c:326
 #3: ffffffff8ef0a1e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88801514e0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #4: ffff88801514e0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
 #4: ffff88801514e0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1290
 #5: ffff888059ca7250 (&devlink->lock_key#55){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8e33c238 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #7: ffffffff8e33c238 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
1 lock held by syz-executor/17196:
 #0: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
2 locks held by syz-executor/17210:
 #0: ffffffff8f5fb450 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x4c6/0x7b0 net/core/net_namespace.c:504
 #1: ffffffff8f607fc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfde/0x1020 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 17126 Comm: syz-executor Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:visit_lock_entry kernel/locking/lockdep.c:1519 [inline]
RIP: 0010:__bfs kernel/locking/lockdep.c:1799 [inline]
RIP: 0010:__bfs_backwards kernel/locking/lockdep.c:1843 [inline]
RIP: 0010:check_irq_usage kernel/locking/lockdep.c:2803 [inline]
RIP: 0010:check_prev_add kernel/locking/lockdep.c:3137 [inline]
RIP: 0010:check_prevs_add kernel/locking/lockdep.c:3252 [inline]
RIP: 0010:validate_chain+0x1fd5/0x5900 kernel/locking/lockdep.c:3868
Code: 41 b4 01 eb 0c 4d 8b 3f 4d 39 f7 0f 84 5d fc ff ff 49 8d 5f 30 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 <74> 08 48 89 df e8 11 43 89 00 4c 89 2b 41 f6 c4 01 74 7f 8b 1d 86
RSP: 0018:ffffc9000b7a7020 EFLAGS: 00000046
RAX: 1ffffffff286c419 RBX: ffffffff943620c8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff92ce9628
RBP: ffffc9000b7a7320 R08: ffffffff93003607 R09: 1ffffffff26006c0
R10: dffffc0000000000 R11: fffffbfff26006c1 R12: 0000000000000000
R13: ffffc9000b7a71e0 R14: ffffffff92ce95f8 R15: ffffffff94362098
FS:  000055557b670500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020008040 CR3: 000000005c684000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 alloc_object+0x1ba/0x6d0 lib/debugobjects.c:234
 lookup_object_or_alloc lib/debugobjects.c:588 [inline]
 debug_object_activate+0x249/0x510 lib/debugobjects.c:711
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common kernel/rcu/tree.c:3091 [inline]
 call_rcu+0x97/0xa70 kernel/rcu/tree.c:3210
 __dentry_kill+0x497/0x630 fs/dcache.c:629
 dput+0x19f/0x2b0 fs/dcache.c:852
 debugfs_remove+0x49/0x70 fs/debugfs/inode.c:815
 nsim_dev_port_debugfs_exit drivers/net/netdevsim/dev.c:426 [inline]
 __nsim_dev_port_del+0x171/0x1b0 drivers/net/netdevsim/dev.c:1426
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1658
 nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1673
 device_remove drivers/base/dd.c:566 [inline]
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x4ab/0x7c0 drivers/base/dd.c:1293
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x57a/0x9b0 drivers/base/core.c:3868
 device_unregister+0x20/0xc0 drivers/base/core.c:3909
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
 del_device_store+0x363/0x480 drivers/net/netdevsim/bus.c:226
 kernfs_fop_write_iter+0x3a3/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa74/0xc90 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5594b746df
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 29 8c 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 7c 8c 02 00 48
RSP: 002b:00007ffda1abdcd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f5594b746df
RDX: 0000000000000001 RSI: 00007ffda1abdd20 RDI: 0000000000000005
RBP: 00007f5594be45b2 R08: 0000000000000000 R09: 00007ffda1abdb27
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffda1abdd20 R14: 00007f5595834620 R15: 0000000000000003
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

