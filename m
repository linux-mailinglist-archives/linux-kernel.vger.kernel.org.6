Return-Path: <linux-kernel+bounces-263966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2901C93DD45
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D195628472D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D423517C66;
	Sat, 27 Jul 2024 04:44:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5645217577
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722055466; cv=none; b=OyebTHgHV1GthdIyN2aJwm9AZ7RfSlWHUQMTALVl1ifodc1MB8SDiWI9V5Mnn5JOekWTUbAyqOSHCjhPjGn00kObxu5hKTjsALdTzIC1v7doDSD2OY8RNLwWp5cI6gxeZaYJCtdksU49J8aUvzF+MmJCAxJg79aiUWfMJjh17Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722055466; c=relaxed/simple;
	bh=R6CqX1RjvbfppaU8D0sg4yPK6djNc7kCG/B6RiovlNk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rj96iPlw/O5e2HUDAowTmF7T1fs1Q+KE+f73fRP7QV+iPOeGEWZgk+WTFJI3riOSMFF8kTUN0gW05Gi9TWS49jDzqhYyfm7KT/CLs5KUE1YZVDMt/FYhprtuGA5441Se54Bn9R9crar+gVaVUTGxoN5nyLk3CyeD44UotwS9K+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-398ae4327f1so30857755ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722055463; x=1722660263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Oqi27XOY4Pg/pSy24EoTMF3Q4/sWKLZFSqoYwiD62I=;
        b=Uu6r91b+j8iY7ULSyo2OXVlYA4c+8UWnWqYPUHQ3mB8vOSGCEa81aO2xFO/15MZJLB
         PhGI7skL8Y0kcFRWzcLQ82ks7St9129HYpyV+wc3pQ0BiArDsHwmxKj4a1aIkEXBmARw
         ak61YFDQrea5w/VCL9leckzDMFqmzzQ4DbRJ7qXFMVi9/FrS1haq6L23s6NtP1z7VtNH
         H2JIl5LDZyH1JmJSVlA+oQkJQTebDON018yjyblnYC7lTSaatLBN48CnhGhDAK25udup
         wL9kqadAlJZzEUAFGWwKor8n1r6122TW9HHJxdUHz4kmDQhOPrNsN26F+Vlb7u9c1B/E
         lxIA==
X-Forwarded-Encrypted: i=1; AJvYcCUGLjIHlG07kt6KParj5VL/oSOFgN4bMp6/Po9yYXPoYJQrjfWjsd9KGOUdURgAcM/a1IIYGEjmoq+F1rC0QH1xkQI+0W9AOagLOWwq
X-Gm-Message-State: AOJu0YxIi7lZpy7RKUbwfQ7DDLoTpZS0fujWeZKRtVvHwFeRaoMf5nLk
	jEpAW9rC9kyN/EPtZh9HEiuGgVgKoXhiu2stym/tCvp1q6NwUbk5tszZX/bTSjP2O8BwKPof38a
	cJ5AytaaemRhODNpapj/KNx603JPeOBGDzniIPRUhk1eYjophmBersPs=
X-Google-Smtp-Source: AGHT+IF5DEMeI+yLO8PMpOTLq3pKbKRsiV2C3baJb1TMZkWu+u/JEWxsy97hymOmV0HQCP0Z4BCMn9bjMNE5XPcpx754n8vv+G4A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39aebd5c887mr1242685ab.2.1722055463518; Fri, 26 Jul 2024
 21:44:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 21:44:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fda01061e334873@google.com>
Subject: [syzbot] [erofs?] INFO: task hung in z_erofs_runqueue
From: syzbot <syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, huyue2@coolpad.com, 
	jefflexu@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f8c4f506285 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107c2903980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=4fc98ed414ae63d1ada2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beafa5a4d4f9/disk-2f8c4f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e58aee7103bd/vmlinux-2f8c4f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92d87af85377/bzImage-2f8c4f50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4fc98ed414ae63d1ada2@syzkaller.appspotmail.com

INFO: task syz.0.1705:11501 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1705      state:D stack:24064 pid:11501 tgid:11500 ppid:11214  flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 io_schedule+0x8d/0x110 kernel/sched/core.c:7401
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 folio_lock include/linux/pagemap.h:1050 [inline]
 z_erofs_fill_bio_vec fs/erofs/zdata.c:1470 [inline]
 z_erofs_submit_queue fs/erofs/zdata.c:1650 [inline]
 z_erofs_runqueue+0xa8c/0x2010 fs/erofs/zdata.c:1732
 z_erofs_readahead+0xbae/0xf00 fs/erofs/zdata.c:1863
 read_pages+0x180/0x840 mm/readahead.c:160
 page_cache_ra_unbounded+0x6ce/0x7f0 mm/readahead.c:273
 do_page_cache_ra mm/readahead.c:303 [inline]
 force_page_cache_ra+0x280/0x2f0 mm/readahead.c:332
 force_page_cache_readahead mm/internal.h:338 [inline]
 generic_fadvise+0x528/0x840 mm/fadvise.c:106
 vfs_fadvise mm/fadvise.c:185 [inline]
 ksys_fadvise64_64 mm/fadvise.c:199 [inline]
 __do_sys_fadvise64 mm/fadvise.c:214 [inline]
 __se_sys_fadvise64 mm/fadvise.c:212 [inline]
 __x64_sys_fadvise64+0x145/0x190 mm/fadvise.c:212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0148f77299
RSP: 002b:00007f0149d48048 EFLAGS: 00000246 ORIG_RAX: 00000000000000dd
RAX: ffffffffffffffda RBX: 00007f0149105f80 RCX: 00007f0148f77299
RDX: 0000000000000000 RSI: 0000000000e0ffff RDI: 0000000000000004
RBP: 00007f0148fe48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f0149105f80 R15: 00007fffc733a208
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e937660 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
3 locks held by kworker/u8:6/1106:
 #0: ffff88802a670948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802a670948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900042bfd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900042bfd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
4 locks held by kworker/u8:9/2557:
 #0: ffff8880166e5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880166e5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900094efd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900094efd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc72ed0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8e93ca38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:296 [inline]
 #3: ffffffff8e93ca38 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:958
1 lock held by syslogd/4657:
 #0: ffff8880b933ea18 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
2 locks held by dhcpcd/4889:
 #0: ffff88806adb9678 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: netlink_dump+0xcb/0xd80 net/netlink/af_netlink.c:2271
 #1: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x99/0x200 net/core/rtnetlink.c:6506
2 locks held by getty/4977:
 #0: ffff88802f6520a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000312b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
1 lock held by syz.0.1705/11501:
 #0: ffff88801de44880 (mapping.invalidate_lock#9){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:854 [inline]
 #0: ffff88801de44880 (mapping.invalidate_lock#9){.+.+}-{3:3}, at: page_cache_ra_unbounded+0xf7/0x7f0 mm/readahead.c:225
2 locks held by kworker/u9:3/12128:
1 lock held by syz-executor/12808:
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/12935:
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/12997:
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/13018:
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz.0.1882/13025:
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48f/0x2400 drivers/net/tun.c:3120
1 lock held by syz-executor/13026:
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc7fa48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 4664 Comm: klogd Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:unwind_next_frame+0x6c5/0x2a00 arch/x86/kernel/unwind_orc.c:505
Code: 48 c1 e8 03 42 0f b6 04 28 84 c0 0f 85 93 1b 00 00 0f b6 5d 01 83 e3 07 48 89 df 48 c7 c6 80 32 7a 8e e8 ce 7a 52 00 48 85 db <74> 16 83 fb 01 75 1e e8 3f 75 52 00 4d 89 f7 48 8b 2c 24 e9 8c 14
RSP: 0018:ffffc9000931f228 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffff8880604fbc00
RDX: 0000000000000002 RSI: ffffffff8e7a3280 RDI: 0000000000000003
RBP: ffffffff9140d5f0 R08: 0000000000000003 R09: ffffffff81410e12
R10: 0000000000000002 R11: ffff8880604fbc00 R12: ffffffff90957014
R13: dffffc0000000000 R14: 1ffff92001263e60 R15: ffffffff9140d5ec
FS:  00007f3530fce380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe45b7c2270 CR3: 000000002dd0a000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4158 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4177
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:605
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2030
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35311309b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffeb7c54b88 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f35311309b5
RDX: 0000000000000053 RSI: 0000555babb61eb0 RDI: 0000000000000003
RBP: 0000555babb5a910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f35312be212 R14: 00007ffeb7c54c88 R15: 0000000000000000
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

