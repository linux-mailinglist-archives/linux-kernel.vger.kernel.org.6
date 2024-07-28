Return-Path: <linux-kernel+bounces-264492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B269693E419
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C40C1C20D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA21A28D;
	Sun, 28 Jul 2024 08:33:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293818622
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722155587; cv=none; b=nXRDU7TvilSrSi6UPqXwiaG1OIBO1kcG6DfCq83v6sBEo1EPB+iYvj6qlWpj1/5Xl/sJLbAiOXKQLx6LuJ6ZFhv2YWZj9BD8TRM5JMJazVdIPSt8fbiED5AC0gvmdzVfvHlz6k3j7nSzF3ZibVztUmXdwPOhMZUsJdXer1DEwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722155587; c=relaxed/simple;
	bh=4CTHj/ltEzEx/G1DUXNGmY57TmFAa4Qxzco+66bFLm4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U8W2Rn7ZhMshgK41VByXaRFM3cjbXpTZC7NCZuSns/W1C+hRNemR/0gekk0QfRbfNPrkHFClC8rpAyaI8RnSAVqFwLOslrHzo49qyZsq0QIy93Ism99Umtn5wYe79iZvbX+2Jr5dO5WACny5bkxZcRSo6j+ffVf1TzQdlMsrmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f959826ccso213438539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 01:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722155585; x=1722760385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9TE45LnIjsVoOEeQRDP3fbLk2hHT/aA254G2KfOfTM=;
        b=ObBkbs8S5C6GgyPjHi474FHacw5ID6+YN0h/jYqGOKLf1JdHxk9W+xRK3PI9PqmYcs
         C7coNip7wUsopY4jEE9gpqUx8KHfvS7kA763sWbWMh6LH6QyNwoSmjZ2f5pBbtHcvEHP
         NUnKsIDljhU3pR2GSu4GwMGZH9HkabuhqNop6XvGC5r52eoPklsyu9BxRp74IBdPsFD+
         lE2sDUafjBrgvXkb9MTPMLa9kDUFYlPKtsmyWyVTbWBhbXeqkALiLwqG4zvJ96LUZSLF
         BNwW7iWLKhnPXWjBwhXk4N6tIsdB3vNBMRpQqRPvZ0puK0p8/oI9Zc5QUBzw7hpvX6dr
         Cp2g==
X-Forwarded-Encrypted: i=1; AJvYcCWTbWRACWImTQjy3ijjbp621K99xdPdTB/e5SyOnJDU9usK3YH/FsCD0FOAXNHs7Wlg8Xdv0Dq1fPJr2A31PnjdDFV4JCnOCjp1K6Jg
X-Gm-Message-State: AOJu0Yxai2D1goH/L/n9nmADga0Uo2VDdu3Gv7E3xwhzcFEOIm90bUXJ
	CSxVnW7Eza5XOD9lPoYJiNojRsZIsS5RJIdhie9nkri/le+Ke873hRpsm/Lywj9FHtcE37xugbw
	ODr/xkVSXYuqxe5c6StWO/Cd3R1MdN0Ilh2LG095bV8zcY59CvAKTbwU=
X-Google-Smtp-Source: AGHT+IGDSum0NQ+Gfe44onVHUz/nVv5BUhZlbcafmJNwjtmm29sJP8Xcb5VW+WyEHChx4OEX1fHXv6hZJDpoZFFX4JFdruBdi4qx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130b:b0:4c2:7f96:6f2 with SMTP id
 8926c6da1cb9f-4c647aa56damr130646173.4.1722155585013; Sun, 28 Jul 2024
 01:33:05 -0700 (PDT)
Date: Sun, 28 Jul 2024 01:33:04 -0700
In-Reply-To: <tencent_44C3065D498F6EC66EC90CB967EA46FC5206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e49c2b061e4a97d8@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
From: syzbot <syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in lock_extent

INFO: task syz.0.15:5937 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:24672 pid:5937  tgid:5937  ppid:5725   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 wait_extent_bit fs/btrfs/extent-io-tree.c:823 [inline]
 lock_extent+0x69e/0x860 fs/btrfs/extent-io-tree.c:1872
 cow_file_range+0x2ea/0x1180 fs/btrfs/inode.c:1574
 btrfs_run_delalloc_range+0x334/0xf60 fs/btrfs/inode.c:2313
 writepage_delalloc+0x639/0xc10 fs/btrfs/extent_io.c:1278
 __extent_writepage fs/btrfs/extent_io.c:1572 [inline]
 extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
 btrfs_writepages+0x1215/0x2760 fs/btrfs/extent_io.c:2373
 do_writepages+0x359/0x870 mm/page-writeback.c:2656
 filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 __filemap_fdatawrite mm/filemap.c:436 [inline]
 filemap_flush+0xdf/0x130 mm/filemap.c:463
 btrfs_release_file+0x117/0x130 fs/btrfs/file.c:1547
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:222
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8541575b59
RSP: 002b:00007ffe3a3322c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f8541705a60 RCX: 00007f8541575b59
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f8541705a60 R08: 0000000000000006 R09: 0000000a3a3325ef
R10: 000000000003fd88 R11: 0000000000000246 R12: 000000000001d5e1
R13: 0000000000000032 R14: 00007f8541705a60 R15: 00007f8541704038
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/11:
 #0: ffff88801aec1148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801aec1148 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000107d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000107d00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff8880223320e0 (&type->s_umount_key#53){++++}-{3:3}, at: super_trylock_shared+0x22/0xf0 fs/super.c:562
1 lock held by khungtaskd/30:
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6613
2 locks held by getty/4836:
 #0: ffff88802af930a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by btrfs-transacti/5970:
 #0: ffff88807cc287c0 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: btrfs_cleanup_transaction+0xd9/0x1ca0 fs/btrfs/disk-io.c:4841
1 lock held by syz-executor/5986:
 #0: ffffffff8e33b3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:296 [inline]
 #0: ffffffff8e33b3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:958

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e-dirty #0
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
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 956 Comm: kworker/u8:5 Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_sta_get_rates+0x32c/0x660 net/mac80211/util.c:1552
Code: 89 f7 e8 87 36 f8 f6 49 63 c7 4d 8b 36 4c 8d 2c 40 4b 8d 1c ae 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 0f 85 f4 00 00 00 8b 1b 8b 6c 24 4c 21 eb 89 df 89 ee e8 4b
RSP: 0000:ffffc90003edf798 EFLAGS: 00000a07
RAX: 0000000000000000 RBX: ffff88802d8edc44 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 000000000000000a RDI: 000000000000003c
RBP: 000000000000003c R08: ffffffff8b0112ac R09: 1ffffffff1f5a8c5
R10: dffffc0000000000 R11: fffffbfff1f5a8c6 R12: dffffc0000000000
R13: 0000000000000003 R14: ffff88802d8edc38 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe4d6755000 CR3: 000000002c822000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 ieee80211_update_sta_info net/mac80211/ibss.c:989 [inline]
 ieee80211_rx_bss_info net/mac80211/ibss.c:1098 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1579 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x11e1/0x2d70 net/mac80211/ibss.c:1606
 ieee80211_iface_process_skb net/mac80211/iface.c:1588 [inline]
 ieee80211_iface_work+0x8a5/0xf20 net/mac80211/iface.c:1642
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         b1bc554e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f5d86d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65e004fdd6e65e46
dashboard link: https://syzkaller.appspot.com/bug?extid=a14d8ac9af3a2a4fd0c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108b35f1980000


