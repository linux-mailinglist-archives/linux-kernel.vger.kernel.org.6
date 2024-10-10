Return-Path: <linux-kernel+bounces-359424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B0998B48
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3766B38D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DF1CCB54;
	Thu, 10 Oct 2024 15:19:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FD1CC147
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573571; cv=none; b=l+NlDkmLUhCp61a0U488nVu+PXmjb8f6ih/OwQF25Uw80+KoiHPGW1RZck+gYZvtSmHGqwzE0a7SglTj2MZqkDr3a133+ej681pdkrO/iIK2qOhTJZVgndQ0/BF6dD5CkkW9ZXqhyXJwf0yMsV0ggGsbTrtkdbtkWb9+qAH3MX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573571; c=relaxed/simple;
	bh=9CV+0Kf6M0ddl7vkP+tQFnazNRgEI9wRak8bsplaT5M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s9xfA/v3KOxL/pxa3duyQrru4j6ee2wvHX1clzgv72kOf/mXycUKFLxZ5Vp1glsrbSubxmF0FwYLBjQXouB7zRpES+rm+GmttAQHikZzvPL/XBbz+FkVAqhP9mSsaFeY6W5m5Yr7jjTobjpxO1XmkBEb9D4rNahjYU1opFlfOQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a19665ed40so6579005ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573568; x=1729178368;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cjQiQK7nE78xUqILL1tAmI6YNCYGVzss9R+s3qwO2Y=;
        b=qj7yiux5ulr485vheuCgiphsrY5z+E7P0ig51aa6ZEyB+7vN7o8nP4xyWAtu1CKM2A
         Co3X9aFlF2Gx1W06NY4aHYNur8htPIDQVyfhPkKVCTWwzsc1Q92KA97crPQMbb+o4Fen
         Edfwj/4OTak6OxsFi/J0MMLVP5F8K82hgRFU+83rlU5jvfYf2/0sb8xJn7psqDdh+CfL
         JWQF3Hk1nYwzKmPh3O68zUEjR/C5fFNKC5DA/uR/2Z6SM1SUpVPCTCe3UsrfU11iYKYu
         I4Ne+fh3txNnrIinudB0TMGLvMiuuDvZILyTWnn25uaIFnZ5G6txB6ys3WFQYiNBNMkX
         YgEw==
X-Forwarded-Encrypted: i=1; AJvYcCVpBM+9tNA/2NUP+WEeb7oBjTE8wdAMCYD6qK6j6Pi6d5UVEagzqMoQa8wmILy3dVOrGbuQYLKeG/Lkr7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsgJFMPkRDT2RpRrBzLCHCVtRYIIETc9axh62grcT1AhbGyTt
	nh5P4Xj6PRNWKalWdxQz3KSSGgWxaa3hlVzpKHkWZTC4DOJ0q0SVQ3BnYb59LFu1YvsMQ1OduSS
	8r/ZqhretS7D/5QeYRrLeUcKUB9AGsPBgeSdjb1ZAvVglqlKjtjv2tz0=
X-Google-Smtp-Source: AGHT+IHAa3H6wW63bp9W/bpmf25TE8UApuulSHN4TurJpSTXuQalXXBw5tzM00V8RupHzE4lrz86aFLblkhJ34gEratfdo6D6p1I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b09:b0:3a0:8e7c:b4ae with SMTP id
 e9e14a558f8ab-3a3a70a3d43mr24647545ab.2.1728573568156; Thu, 10 Oct 2024
 08:19:28 -0700 (PDT)
Date: Thu, 10 Oct 2024 08:19:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707f080.050a0220.64b99.001c.GAE@google.com>
Subject: [syzbot] [mm?] INFO: task hung in exit_mmap
From: syzbot <syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d3d1556696c1 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10416fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=39bc767144c55c8db0ea
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0600b551e610/disk-d3d15566.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d59d43ed3976/vmlinux-d3d15566.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e686a3e7e0d6/bzImage-d3d15566.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39bc767144c55c8db0ea@syzkaller.appspotmail.com

INFO: task syz.3.917:7739 blocked for more than 146 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.917       state:D stack:23808 pid:7739  tgid:7739  ppid:5232   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 mmap_write_lock include/linux/mmap_lock.h:106 [inline]
 exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
 __mmput+0x115/0x380 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4688f7dff9
RSP: 002b:00007ffea64ebf18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4688f7dff9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffea64ebf6c R08: 00007ffea64ebfff R09: 0000000000028eb6
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000028eb6 R14: 0000000000028d0c R15: 00007ffea64ebfc0
 </TASK>
INFO: task syz.0.828:7756 blocked for more than 152 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.828       state:D stack:22384 pid:7756  tgid:7755  ppid:7346   flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1843/0x4ae0 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 mmap_write_lock include/linux/mmap_lock.h:106 [inline]
 exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
 __mmput+0x115/0x380 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x28e0 kernel/exit.c:926
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x16a3/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff5c377dff9
RSP: 002b:00007ff5c45800e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007ff5c3935f88 RCX: 00007ff5c377dff9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ff5c3935f88
RBP: 00007ff5c3935f80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff5c3935f8c
R13: 0000000000000000 R14: 00007ffe0400b7d0 R15: 00007ffe0400b8b8
 </TASK>

Showing all locks held in the system:
1 lock held by pool_workqueue_/3:
 #0: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #0: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
1 lock held by klogd/4662:
 #0: ffff888072fda798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:106 [inline]
 #0: ffff888072fda798 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
1 lock held by dhcpcd/4887:
 #0: ffff888032585718 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff888032585718 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x17c/0x3d0 mm/util.c:586
2 locks held by getty/4982:
 #0: ffff88814b9860a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:5/5270:
3 locks held by kworker/0:5/5300:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004037d00 (xfrm_state_gc_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004037d00 (xfrm_state_gc_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #2: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
1 lock held by syz.3.917/7739:
 #0: ffff888020fc5718 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:106 [inline]
 #0: ffff888020fc5718 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
1 lock held by syz.0.828/7756:
 #0: ffff888062c33a98 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock include/linux/mmap_lock.h:106 [inline]
 #0: ffff888062c33a98 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x2bd/0xc40 mm/mmap.c:1872
3 locks held by kworker/u8:21/7787:
 #0: ffff88801b367148 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801b367148 ((wq_completion)cfg80211){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900015b7d00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900015b7d00 ((work_completion)(&(&rdev->dfs_update_channels_wk)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: cfg80211_dfs_channels_update_work+0xbf/0x610 net/wireless/mlme.c:1021
3 locks held by kworker/u8:30/7796:
 #0: ffff88814b6a6948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814b6a6948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90002e9fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90002e9fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
3 locks held by kworker/u8:32/7798:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003ad7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003ad7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
5 locks held by kworker/u8:50/9743:
 #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003f57d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003f57d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcb2dd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcbf8c8 (rtnl_mutex){+.+.}-{3:3}, at: ieee80211_unregister_hw+0x55/0x2c0 net/mac80211/main.c:1662
 #4: ffff888059fc8768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
 #4: ffff888059fc8768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: ieee80211_stop+0x3e9/0x4a0 net/mac80211/iface.c:777
1 lock held by syz.1.2163/11123:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 11132 Comm: syz-executor Not tainted 6.12.0-rc2-syzkaller-00074-gd3d1556696c1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:preempt_count_sub+0x66/0x170 kernel/sched/core.c:5829
Code: c1 81 e1 ff ff ff 7f 39 d9 7c 27 81 fb fe 00 00 00 77 07 0f b6 c0 85 c0 74 5f 65 8b 05 cb 99 a0 7e f7 db 65 01 1d c2 99 a0 7e <5b> 41 5e c3 cc cc cc cc 90 e8 ec af 4c 03 85 c0 74 3a 48 c7 c0 30
RSP: 0018:ffffc9000335f8c8 EFLAGS: 00000093
RAX: 0000000080000002 RBX: 00000000ffffffff RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc9000335f970 R08: ffffffff9a5fe1f3 R09: 1ffffffff34bfc3e
R10: dffffc0000000000 R11: fffffbfff34bfc3f R12: dffffc0000000000
R13: 1ffff9200066bf1c R14: dffffc0000000000 R15: 0000000000000046
FS:  0000555588e89500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c310254 CR3: 00000000581ae000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0xdd/0x140 kernel/locking/spinlock.c:194
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
 slab_free_hook mm/slub.c:2273 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x11f/0x420 mm/slub.c:4681
 __sigqueue_free kernel/signal.c:451 [inline]
 collect_signal kernel/signal.c:594 [inline]
 __dequeue_signal+0x4ac/0x5c0 kernel/signal.c:616
 dequeue_signal+0x1e0/0x680 kernel/signal.c:637
 get_signal+0x604/0x1740 kernel/signal.c:2797
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae9a37c911
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 3a fc 18 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffcb450afb0 EFLAGS: 00000202
RAX: 0000000000000003 RBX: 0000000000000002 RCX: 00007fae9a37c911
RDX: 0000000000000002 RSI: 00007fae9a3f033b RDI: 00000000ffffff9c
RBP: 00007fae9a3f033b R08: 00000000000000da R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
IPVS: wlc: UDP 224.0.0.2:0 - no destination available


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

