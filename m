Return-Path: <linux-kernel+bounces-196965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254008D6460
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D6CB2D872
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03321CD26;
	Fri, 31 May 2024 14:19:42 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9AA5223
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165182; cv=none; b=uQhCGva23UEJBrMNX3YvMl2P5GdcmVAjQwNVAof0H+PQTT+naq1sJvAFd53nv2REjNY5g4DBRnukwg0u6Ovf+jcZB/I9SUJb9n2yt6htn8XSe1ECG0xeUciaXOcsnxIQoxNZA+CBa0aMVXb3EeSV/DW0Z/cRNL+z/GcEu7qlKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165182; c=relaxed/simple;
	bh=d0lqwuMmnvoycozfOc4O/PNMzwaVe2DPlVTCU1B/ZlE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=vDRU0YlMUxoz5+tA0ZWpIaWc3/Rpy5Pr3SZQylI2WAZ9OBv+xEmoF+dYmAvM5RpTcyx5RsI0ofAuj3+7qyiVx8E3V+wOLE0fvANd5z9e/q/gvw6HM3RhBuesqclrZxC4nXu/4nls5qNXQIqa6hskzH5zgfnSCdjqg332NwTbew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eafdb25dbbso160398039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717165180; x=1717769980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yb7XUNpfrq0Yb/ulfO/du1Gq7Pjr6h5I06Xeddne7Uo=;
        b=ZNUcGXvqV3ePXK5cTxgExkh134Z0nVic4l7j8EEWHeLuuSha9aaRngJTBrZp8a1XLv
         l8y0NoGzcGRszRKMMmuS7xhUX+pYGfROhw9GyzKQ5Be8aaVw8Cq9SecpQGsa1tAG0B0E
         QrKq1InjxvhHeq95Al4wkK1tzmCCqvpsppOOYz1kPNoGyNmRP9LyIqBuVWh3vTXEyMoT
         EXWJr24f6Rd3F6VgcCgQVeVUlDDV3zBZbTDkmh/mXLixCCiPIRItAu+7KDcDtlihjpqs
         Nujx8M6M3nxNu0/Bg00yWZ2VAFmrRfASTEce61MbAhRuf+6KUMyVuT4xutCCRYqrHnYO
         6+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWHGUaxlYAPkw+8R8exuW94MNc0RZPqMAIlFu+wSVB9dPN3+jMP/NmHzMMTxfRmzVQPW5LcMnfwO+RNzoDRomTriEN1726QGi6HNLg8
X-Gm-Message-State: AOJu0YxaOYkuYv6Ow06d+Kz70KCInKgJxFFrFIISFLtbK7TrHi85pwRw
	JEfGFDlAJZ9fsb2F05VObyY9d1fgWoO5apqVhulXi2vV/Gci0OjkusqrlEVd4a999UWGU0fYqWa
	EQBq1bXVg2NBBkdpERaAFMdmbPCxz2DDwBlLLS80wtPsACG8vVUcxsLw=
X-Google-Smtp-Source: AGHT+IGZLBPCpmE94111hFaaksBT+LGBpnXbs/qv/xXPfIaxB+nH9J/tzR4SgNcKW6Cg3feTwhos+CgRGtcZzOC3OPVavqZpEtC2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:374:5315:95de with SMTP id
 e9e14a558f8ab-3748ba1fedbmr1480845ab.6.1717165179807; Fri, 31 May 2024
 07:19:39 -0700 (PDT)
Date: Fri, 31 May 2024 07:19:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000903a6d0619c0ac91@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_sock_ready_cb
From: syzbot <syzbot+542cd57c45c01d9c33f8@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149350d8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=542cd57c45c01d9c33f8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32f7723d467f/disk-66ad4829.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2cb82a76d362/vmlinux-66ad4829.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07340808386b/bzImage-66ad4829.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+542cd57c45c01d9c33f8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_sock_ready_cb+0xd7/0x140 net/bluetooth/l2cap_sock.c:1662
Read of size 8 at addr ffff88806c4de188 by task kworker/1:1/17633

CPU: 1 PID: 17633 Comm: kworker/1:1 Not tainted 6.9.0-syzkaller-12071-g66ad4829ddd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events l2cap_info_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 l2cap_sock_ready_cb+0xd7/0x140 net/bluetooth/l2cap_sock.c:1662
 l2cap_chan_ready net/bluetooth/l2cap_core.c:1256 [inline]
 l2cap_conn_start+0x8db/0x1140 net/bluetooth/l2cap_core.c:1506
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 27936:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:4121 [inline]
 __kmalloc_noprof+0x1f9/0x400 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2080
 sk_alloc+0x38/0x370 net/core/sock.c:2133
 bt_sock_alloc+0x3c/0x340 net/bluetooth/af_bluetooth.c:148
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1869 [inline]
 l2cap_sock_create+0x13f/0x2d0 net/bluetooth/l2cap_sock.c:1909
 bt_sock_create+0x161/0x230 net/bluetooth/af_bluetooth.c:132
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socket_create net/socket.c:1659 [inline]
 __sys_socket+0x150/0x3c0 net/socket.c:1706
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1718
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 27935:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x149/0x360 mm/slub.c:4557
 sk_prot_free net/core/sock.c:2116 [inline]
 __sk_destruct+0x476/0x5f0 net/core/sock.c:2208
 l2cap_sock_release+0x15b/0x1d0 net/bluetooth/l2cap_sock.c:1417
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88806c4de000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 392 bytes inside of
 freed 2048-byte region [ffff88806c4de000, ffff88806c4de800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6c4d8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015042000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015042000 0000000000000000 dead000000000001
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001b13601 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 26413, tgid 26413 (syz-executor.2), ts 1938838512727, free_ts 1929373430793
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e2d/0x2ee0 mm/page_alloc.c:3402
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4660
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2264
 allocate_slab+0x5a/0x2e0 mm/slub.c:2427
 new_slab mm/slub.c:2480 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3666
 __slab_alloc+0x58/0xa0 mm/slub.c:3756
 __slab_alloc_node mm/slub.c:3809 [inline]
 slab_alloc_node mm/slub.c:3988 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 kmalloc_node_track_caller_noprof+0x281/0x440 mm/slub.c:4141
 kmemdup_noprof+0x2a/0x60 mm/util.c:131
 ip_vs_control_net_init_sysctl net/netfilter/ipvs/ip_vs_ctl.c:4284 [inline]
 ip_vs_control_net_init+0x7da/0x17f0 net/netfilter/ipvs/ip_vs_ctl.c:4463
 __ip_vs_init+0x2d2/0x460 net/netfilter/ipvs/ip_vs_core.c:2308
 ops_init+0x359/0x610 net/core/net_namespace.c:139
 setup_net+0x515/0xca0 net/core/net_namespace.c:343
 copy_net_ns+0x4e2/0x7b0 net/core/net_namespace.c:508
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
page last free pid 26200 tgid 26200 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2565
 vfree+0x186/0x2e0 mm/vmalloc.c:3346
 kcov_put kernel/kcov.c:429 [inline]
 kcov_close+0x2b/0x50 kernel/kcov.c:525
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:874
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88806c4de080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806c4de100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806c4de180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88806c4de200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806c4de280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

