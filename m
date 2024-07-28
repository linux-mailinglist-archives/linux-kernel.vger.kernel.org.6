Return-Path: <linux-kernel+bounces-264475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 926E993E3DF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980F11F21753
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274741CFA9;
	Sun, 28 Jul 2024 07:05:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A71A269
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722150304; cv=none; b=blfXPBMQNkShC0VGGVTSj33+p6YDuOAWTtp7C071JEiUCELJMctgvHiV2GhqcXzMXgqrCmXO8omOpntP+VB/pNTkLalspzm5wt6CLb2iKKmlEaevhE5ziQBn+/gYl0j9rzccQO4OCxA435P7NCKWySJMeYQzcprNS15xrazOPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722150304; c=relaxed/simple;
	bh=Gl6wodyiHxsqr0pEyIrNIg7BtVWk2ht9N1m78M0sjts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GiKcjwu2h/yIEmT2+dczRfo8XYu6xE3HxY3OM68umswKbAu0mqjXP0LVFkJwR7EnSAWJ6XBjX/2JKMs7p6aAu5uMz3oJqzpX/do9ikkAtDUD1qMYM8j8biNyhtz35XtT88wTXH2N+2Y2IYIk9uTuckgsRVLR0hV5DctHkCCt1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-397810ad718so41201385ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 00:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722150301; x=1722755101;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4f8iSvsMKe5FO63VwVQwYnJTE4IdeMPpU98+Q8RnSHw=;
        b=kkVCIrjmY6gJZ3PG0R5d7CaQ1bT+2ezL4gCj8Lc0g0OjQCvMqXJXMXWVf+tNHntdo0
         yOCMNa0f2JpG6s3vPEuJ2qAhKZsCB9c3JDDKh2vFTodBVnBdZHfXFRpbBqlb4eYUE30q
         sKbv85MGERZwsUYV0cmFME6cMhrahpzSkx90VZ2ZZg+Ytc8SszfL4LGbsr1wsfMlxLXv
         AfGaUXan2aDti6YCsEbHxlkzcfogOeX0NAGYeX+M3a+WcdfinwDcUD4m+yO4csO5b2wo
         45oQvg8bZH14H2uUSU8QDcO+gbEpS0zWEN+poTQyrSmc+Sg80/JhO55X14/Jl6YzcXEg
         Q6Og==
X-Forwarded-Encrypted: i=1; AJvYcCXoxxQ+CVZxn0OwcUhanvuP65JGcEjOcSZWEXq2EQlACuiIdYNmbZivHb2+JS0LkRjunKah0BxDTQizuO1y6dlzml5zXSgjSAIWDv5X
X-Gm-Message-State: AOJu0YzW6nINDW3SGsu0hPFVf+ZOePW8tLSca8YUu+tyljaHk7Ehgw5O
	b9C+XZXGS2QWoHCqHWdHIXD/oKJo60u9UwU/1EHgFeTW5bCYzpLYqqA9SjJXF8Tbzj+zBbvPhqp
	uCeE0t5fF0ACr62s85G5tM370SPJ9jc/lIdUZFv7/qswLtsI0Jxh5SPI=
X-Google-Smtp-Source: AGHT+IFV9Yyu59+JH/EFoHaRRaxkxlNGnjKZK0KOew4QdSeslYvkc1EfeAensAv7/gSbdAqY2vMH3Z4x4GCq5bEOzMMOFcHIf0KC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39aec45be5amr3896075ab.6.1722150301540; Sun, 28 Jul 2024
 00:05:01 -0700 (PDT)
Date: Sun, 28 Jul 2024 00:05:01 -0700
In-Reply-To: <tencent_31BC2C256D0C94CCEAB2EEA6CC8478066D0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f93164061e495c83@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
From: syzbot <syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in lock_extent

INFO: task syz.0.15:5960 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D stack:24672 pid:5960  tgid:5960  ppid:5771   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 wait_extent_bit fs/btrfs/extent-io-tree.c:823 [inline]
 lock_extent+0x69e/0x860 fs/btrfs/extent-io-tree.c:1872
 cow_file_range+0x850/0x1150 fs/btrfs/inode.c:1449
 btrfs_run_delalloc_range+0x334/0xf60 fs/btrfs/inode.c:2312
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
RIP: 0033:0x7ff354175b59
RSP: 002b:00007ffdcffae2d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ff354305a60 RCX: 00007ff354175b59
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007ff354305a60 R08: 0000000000000006 R09: 0000000acffae5ff
R10: 000000000003fd84 R11: 0000000000000246 R12: 000000000001d40e
R13: 0000000000000032 R14: 00007ff354305a60 R15: 00007ff354303f60
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6613
3 locks held by kworker/u8:9/2882:
 #0: ffff888019e8a948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888019e8a948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009f2fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009f2fd00 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88802ae700e0 (&type->s_umount_key#53){++++}-{3:3}, at: super_trylock_shared+0x22/0xf0 fs/super.c:562
2 locks held by getty/4844:
 #0: ffff88802aa6c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002efe2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by btrfs-transacti/6005:
 #0: ffff88801138c7c0 (&fs_info->transaction_kthread_mutex){+.+.}-{3:3}, at: btrfs_cleanup_transaction+0xd9/0x1ca0 fs/btrfs/disk-io.c:4841
1 lock held by syz-executor/6008:
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
CPU: 1 PID: 5191 Comm: kworker/1:3 Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:stack_trace_consume_entry+0x2f/0x280 kernel/stacktrace.c:86
Code: 41 57 41 56 41 55 41 54 53 48 83 ec 18 48 89 fb 48 ba 00 00 00 00 00 fc ff df 4c 8d 4f 10 4d 89 cf 49 c1 ef 03 41 0f b6 04 17 <84> c0 0f 85 06 01 00 00 44 8b 43 10 48 8d 6b 08 49 89 ec 49 c1 ec
RSP: 0018:ffffc90003657630 EFLAGS: 00000a06
RAX: 0000000000000000 RBX: ffffc90003657760 RCX: ffff88802729da00
RDX: dffffc0000000000 RSI: ffffffff81820118 RDI: ffffc90003657760
RBP: ffffc90003657710 R08: ffffffff813780f2 R09: ffffc90003657770
R10: 0000000000000003 R11: ffffffff818201e0 R12: ffff88802729da00
R13: ffffffff818201e0 R14: ffffc90003657760 R15: 1ffff920006caeee
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555592589808 CR3: 000000001efae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x143/0x1b0 arch/x86/kernel/stacktrace.c:27
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4438 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4513
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:821 [inline]
 nsim_dev_trap_report_work+0x765/0xaa0 drivers/net/netdevsim/dev.c:850
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10306753980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=65e004fdd6e65e46
dashboard link: https://syzkaller.appspot.com/bug?extid=a14d8ac9af3a2a4fd0c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=159add9d980000


