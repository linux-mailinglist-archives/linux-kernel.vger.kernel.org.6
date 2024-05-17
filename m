Return-Path: <linux-kernel+bounces-182670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACB38C8E49
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF91B21F42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC041411E2;
	Fri, 17 May 2024 22:28:32 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95E1A269
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715984911; cv=none; b=Zg2BiqEKOg37ZzkN0Ufl3FqdB1Fpd5G10z7ygdkrAaTOqqPF1WA/iiuW68bea7kSwexUyo1kf33wvaEj8nisUYh2y7SpY3yimmLX9nMGJfvk/dtIce7BsHqsaUL4KKu+tEkc9am620ZvrEk3AkFKCq05q7t3iHBG9tvFLlsg0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715984911; c=relaxed/simple;
	bh=PtWHAF3ZaO90XWe9xwBI/RGJRYpyc7ZLwYvZOqczXOI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=T7kowm8d695LUt8YixB2mzlxrz0AlrVzq/UezA/oNhz2ZQi+KSs8/tw4gtAKuxjjsfSKmNm/N8AT3gWf618SL1S8bT50eknHQDXWNMjB5fa4ZobG1LH+qFLjQmegIbL7QCKnhcjD8C+xbVHWzaQjhvRjkWbsUvHCLW/KBCkyWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1d807cfbaso798311239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715984908; x=1716589708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3GvFxx5xE7jKHrsy5XLlRP4R882veK0Rm7t/n0A4Fs=;
        b=K8jivcJuLbiY/fMyZVf1M3zlTxJbqMuPZaC57fnssXzl0IhxWfxC/37W2bd4ybvDz6
         Ztf5aOfuqoH4DQsWQ8XsnOYTKdDDOBLh5M5vqJ08JKeTTt9/KNLdvUyVgVtqTx+0jUtE
         JITD814SG8nLl1knfkswKkm+uTicJq5FOBqPxhs1lBdGR3k8xfxkK1E+lUvM1ilYwhNC
         Rancu8igJDRs8OfMcvEOb33hE3miWAq0lBT75+LeBpPStq0EVyXO3DNhA83rfEcEGESA
         yajoKE9rr+4UxiiM7iHZ8FFmM+c2nQiR7WTKAhTpcSABI0vhU9SaKRNfG8e8sB6Tu9n4
         Mi7A==
X-Forwarded-Encrypted: i=1; AJvYcCWxeiKFTJDen5QZDpvXgOJ8l8tiFGnsun6Po+UQuPlnnl0I6+h83BfB07sYkQ5K/HzfMvPGNmkna7rlj1yb2HmzdSunOFRGf4Tfo8qx
X-Gm-Message-State: AOJu0Yw9WOBMX6jveH2taLXQGWrk629xpNinvRDEyk2zGTuRT2zoTSty
	fJzE79xhSuNlGbbo5SCX6Bt7xCBzp84eDdvZ9aEAi9kLg3vagzzl048j57u/6KEQi8ivGRnJW06
	aPFwr4OQYUPmdNX97B7xICISa7oEyJYkI0a4Wtwx/ftUwan1yhsLyCOE=
X-Google-Smtp-Source: AGHT+IFGZwww7JLPQcQ0dana3Y0HXRsY1Wb6TGseYwXcChpvZRw4hCP2QjVmfUcfcON2PUxbhDCcAp8Xhqx7pjobjPe+gxZ3PeDP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890b:b0:488:c743:c19 with SMTP id
 8926c6da1cb9f-48958e1a9e5mr2040290173.4.1715984908615; Fri, 17 May 2024
 15:28:28 -0700 (PDT)
Date: Fri, 17 May 2024 15:28:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb11450618adde68@google.com>
Subject: [syzbot] [mm?] INFO: task hung in __lru_add_drain_all (2)
From: syzbot <syzbot+5294aa7d73bb0fa85bd0@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b10b390d945 Merge tag 'efi-next-for-v6.10' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e748cc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8fb75f90ccfdc0a8
dashboard link: https://syzkaller.appspot.com/bug?extid=5294aa7d73bb0fa85bd0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a830d644e7f8/disk-1b10b390.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/62c43f86b96f/vmlinux-1b10b390.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41286cbfd37d/bzImage-1b10b390.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5294aa7d73bb0fa85bd0@syzkaller.appspotmail.com

INFO: task syz-executor.4:5253 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-02713-g1b10b390d945 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.4  state:D stack:23840 pid:5253  tgid:5253  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 __lru_add_drain_all+0x69/0x740 mm/swap.c:867
 invalidate_bdev+0x9a/0xd0 block/bdev.c:95
 ext4_put_super+0x535/0xdd0 fs/ext4/super.c:1361
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_block_super+0x3b/0x90 fs/super.c:1675
 ext4_kill_sb+0x6a/0xb0 fs/ext4/super.c:7323
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6ccbc7f097
RSP: 002b:00007ffe3c43a6b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6ccbc7f097
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe3c43a770
RBP: 00007ffe3c43a770 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe3c43b830
R13: 00007f6ccbcc9336 R14: 0000000000093374 R15: 0000000000000001
 </TASK>
INFO: task syz-executor.1:12673 blocked for more than 143 seconds.
      Not tainted 6.9.0-syzkaller-02713-g1b10b390d945 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:23744 pid:12673 tgid:12673 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 jbd2_log_wait_commit+0x2ef/0x460 fs/jbd2/journal.c:697
 ext4_sync_fs+0x694/0x860 fs/ext4/super.c:6338
 sync_filesystem+0x1cc/0x290 fs/sync.c:66
 ovl_sync_fs+0x142/0x1d0 fs/overlayfs/super.c:232
 sync_filesystem+0x1cc/0x290 fs/sync.c:66
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
 kill_anon_super+0x3a/0x60 fs/super.c:1225
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f64cc67f097
RSP: 002b:00007fff31ddfad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f64cc67f097
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff31ddfb90
RBP: 00007fff31ddfb90 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff31de0c50
R13: 00007f64cc6c9336 R14: 0000000000092aa7 R15: 0000000000000009
 </TASK>
INFO: task syz-executor.2:13585 blocked for more than 144 seconds.
      Not tainted 6.9.0-syzkaller-02713-g1b10b390d945 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:26592 pid:13585 tgid:13584 ppid:10964  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2558
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __flush_work+0x5c4/0xb10 kernel/workqueue.c:4218
 __lru_add_drain_all+0x52c/0x740 mm/swap.c:912
 invalidate_bdev+0x9a/0xd0 block/bdev.c:95
 ntfs_loadlog_and_replay+0x239/0x5c0 fs/ntfs3/fsntfs.c:330
 ntfs_fill_super+0x1fc9/0x4490 fs/ntfs3/super.c:1284
 get_tree_bdev+0x36f/0x610 fs/super.c:1614
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f661167f46a
RSP: 002b:00007f66124c7ef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f66124c7f80 RCX: 00007f661167f46a
RDX: 0000000020000100 RSI: 00000000200000c0 RDI: 00007f66124c7f40
RBP: 0000000020000100 R08: 00007f66124c7f80 R09: 000000000080c018
R10: 000000000080c018 R11: 0000000000000202 R12: 00000000200000c0
R13: 00007f66124c7f40 R14: 000000000001f234 R15: 0000000020000140
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u8:0/11:
 #0: ffff8880162d3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: ffffc90000107d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: ffffffff8f71a950 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xbf0 net/core/net_namespace.c:594
 #3: ffffffff8f72f748 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1b/0x230 drivers/net/wireguard/device.c:414
1 lock held by khungtaskd/31:
 #0: ffffffff8dbb1ae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8dbb1ae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8dbb1ae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
3 locks held by kworker/u8:6/955:
 #0: ffff88802a04d148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: ffffc9000498fd80 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: ffffffff8f72f748 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4732
2 locks held by getty/4840:
 #0: ffff88802adac0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2201
3 locks held by kworker/0:6/5163:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1296/0x1ac0 kernel/workqueue.c:3242
 #1: ffffc90003dbfd80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x906/0x1ac0 kernel/workqueue.c:3243
 #2: ffffffff8f72f748 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
2 locks held by syz-executor.4/5253:
 #0: ffff88805d6480e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88805d6480e0 (&type->s_umount_key#52){++++}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88805d6480e0 (&type->s_umount_key#52){++++}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504
 #1: ffffffff8dccfb08 (lock#3){+.+.}-{3:3}, at: __lru_add_drain_all+0x69/0x740 mm/swap.c:867
2 locks held by syz-executor.3/5663:
 #0: ffff88802d0fa0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88802d0fa0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88802d0fa0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504
 #1: ffff88802f3220e0 (&type->s_umount_key#52){++++}-{3:3}, at: ovl_sync_fs+0x13a/0x1d0 fs/overlayfs/super.c:231
2 locks held by syz-executor.1/12673:
 #0: ffff88805ecbc0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88805ecbc0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88805ecbc0e0 (&type->s_umount_key#83){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504
 #1: ffff88802f3220e0 (&type->s_umount_key#52){++++}-{3:3}, at: ovl_sync_fs+0x13a/0x1d0 fs/overlayfs/super.c:231
2 locks held by syz-executor.2/13585:
 #0: ffff88805b7460e0 (&type->s_umount_key#95/1){+.+.}-{3:3}, at: alloc_super+0x23d/0xbd0 fs/super.c:343
 #1: ffffffff8dccfb08 (lock#3){+.+.}-{3:3}, at: __lru_add_drain_all+0x69/0x740 mm/swap.c:867
8 locks held by syz-executor.2/13644:
 #0: ffff88802faca420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #1: ffff8880604e9088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
 #2: ffff88801f502a58 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x500 fs/kernfs/file.c:326
 #3: ffffffff8ed76688 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: ffff88805f7150e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:990 [inline]
 #4: ffff88805f7150e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
 #4: ffff88805f7150e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1290
 #5: ffff88805e51c250 (&devlink->lock_key#14){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8f72f748 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x35/0x2f0 drivers/net/netdevsim/netdev.c:451
 #7: ffffffff8f8281a8 (flowtable_lock){+.+.}-{3:3}, at: nf_flow_table_cleanup+0x81/0x3d0 net/netfilter/nf_flow_table_core.c:597
1 lock held by syz-executor.2/13654:
 #0: ffffffff8f72f748 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f72f748 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe60 net/core/rtnetlink.c:6592

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 31 Comm: khungtaskd Not tainted 6.9.0-syzkaller-02713-g1b10b390d945 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf86/0x1240 kernel/hung_task.c:380
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 13554 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-02713-g1b10b390d945 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:3762 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3782 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3837 [inline]
RIP: 0010:__lock_acquire+0x1594/0x3b30 kernel/locking/lockdep.c:5137
Code: 48 c1 e8 03 80 3c 28 00 0f 85 bc 18 00 00 48 8b 43 18 49 39 c5 0f 84 a2 f7 ff ff 48 8d 7b 08 48 89 f8 48 c1 e8 03 80 3c 28 00 <0f> 85 90 18 00 00 48 8b 5b 08 48 85 db 75 b7 e8 f8 48 ff ff 48 c7
RSP: 0018:ffffc900034ffac8 EFLAGS: 00000046
RAX: 1ffffffff264bc71 RBX: ffffffff9325e380 RCX: ffffffff816b34fe
RDX: 1ffffffff28398a0 RSI: 0000000000000008 RDI: ffffffff9325e388
RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff2843652
R10: ffffffff9421b297 R11: 0000000000000000 R12: 0000000000019264
R13: e91b78abf4a04936 R14: ffff8880657128e0 R15: 0000000000000004
FS:  00007fa93e22d6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2d029000 CR3: 0000000065006000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:376 [inline]
 __set_current_blocked kernel/signal.c:3099 [inline]
 set_current_blocked kernel/signal.c:3085 [inline]
 signal_delivered kernel/signal.c:2947 [inline]
 signal_setup_done+0x27d/0x570 kernel/signal.c:2959
 handle_signal arch/x86/kernel/signal.c:285 [inline]
 arch_do_signal_or_restart+0x4bb/0x7e0 arch/x86/kernel/signal.c:312
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa93d4a54f0
Code: 83 c0 16 83 e0 f7 74 12 50 48 8d 3d da 9c 04 00 e8 15 78 fa ff 0f 1f 44 00 00 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 <83> ff 21 74 0b c3 66 2e 0f 1f 84 00 00 00 00 00 55 53 48 89 f3 48
RSP: 002b:00007fa93e22cb38 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00007fa93d5abf80 RCX: 00007fa93d47dd69
RDX: 00007fa93e22cb40 RSI: 00007fa93e22cc70 RDI: 0000000000000021
RBP: 00007fa93d4ca49e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa93d5abf80 R15: 00007ffd26f52418
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

