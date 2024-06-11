Return-Path: <linux-kernel+bounces-209225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E480902F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97391F225F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2A16F90C;
	Tue, 11 Jun 2024 03:43:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BCD5FEE4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718077385; cv=none; b=n8NCsH/nwPOl33UWLIYmCUojXV+2npmHtNy9xa2nJXlOriRN5cxVl0bIJwNBmUvog3DLkpGE2HTdpz86uGc6LzGQUaUM5VtQqwzg+Ief/744U+xk7VIyH/mTvi+Kw16WQRtDssAme1Kw2gA+DxAzZz3S5W2kyoVkMdJxhxLBpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718077385; c=relaxed/simple;
	bh=b4RPjw/rMBhSFqjVXJPXt2Wkhk2E4kD8dL96Mu8xaPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jyRhP29/ffseEZYsiPw0nVZan5HIShyMPHScT/d8IBox9cpudeJ8D0v/b5RKWBvKqzMN5/m+sLvH6g37Tu7Jm09K246LM0SA+slqd8PQ6aFA+aC5f5dOf8pXxhABhEFVWsXXOE8bEFu62JqDtuTMETXEWAyvTF8in/KMZ0j7Ecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375a1820034so19240255ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718077382; x=1718682182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nsRmSoLzPi1EBYEFyR4fUp4tgfkcB6Hzy4OjsUtiU4=;
        b=jwRHi9uKzeMudlSAYQ2QBh9gRYTebLT7FwPWwYTFqVE2JRPs2HH4E/qAkgk/tST8z7
         KsAlIrjwRQoaFJUn8p4RwubJlqTMQsd0VKjWUx1McYJk4rTaP0DZhbGYlVU/KtEnjoNW
         FfmC6rL6nmbSpX19UvHBTKztqw6Ic8KsFQSW1B5wAl0hTvtPO+ynuIh9hyDPELTdlBGZ
         li4Zp2v8KGbW3ErI8CFaJSU0p5hzR5UMmHXCKUFaxPaPGdkEm5aemIIvrEJsdcHE4re8
         7Oq6BGxlenE/0MPCRgK0oM1vhWj9SE7NVV5hnv9z3f/zpiqXA0doxozG1x/uu/FKuD5G
         tr0w==
X-Forwarded-Encrypted: i=1; AJvYcCWFDDj6zNqX8IwZU0pGNgfp5CRba2xHqcSZcHhaULaBn+ynaPnJQfJTeYwQPQAKn1UezfLjZ7ZwXygZLhhtGW60PjT1nPZL2x3+CnVn
X-Gm-Message-State: AOJu0YyJntS7oov11vJXBl3i93TLcSag+FkoWvnVi9GZUFjDbeDQvHik
	kIMp1RcLE95AYFH/mmb47IHidCVwmpxGmjw4pjJFD1ba191z7XOcZLxYEbfnqiriL3hfTF4xesl
	twvtzxyi2TzAsfbM897k7L8IfhmReKB4hMM8abJgLQ/BfHwkSsPTnN3c=
X-Google-Smtp-Source: AGHT+IHlbpmm1vHOUIYbd6MFFF07VDO131BJwbgi7Xp7zyoHZyB+o2kkfdg5u240cZgmH9L9vrllXaUqayzp2Huoyq9vzbM1RjiI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:374:acd0:def1 with SMTP id
 e9e14a558f8ab-375803c6586mr5653985ab.5.1718077382496; Mon, 10 Jun 2024
 20:43:02 -0700 (PDT)
Date: Mon, 10 Jun 2024 20:43:02 -0700
In-Reply-To: <tencent_3E3CF53628970C36A64ACA75A3771B663C09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014a6c4061a9510c1@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: held lock freed in l2cap_sock_recv_cb

=========================
WARNING: held lock freed!
6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0 Not tainted
-------------------------
kworker/u9:3/6296 is freeing memory ffff88807b68b000-ffff88807b68b7ff, with a lock still held there!
ffff88807b68b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff88807b68b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_recv_cb+0x53/0x6d0 net/bluetooth/l2cap_sock.c:1488
4 locks held by kworker/u9:3/6296:
 #0: ffff88807c089948 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88807c089948 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900032b7d00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900032b7d00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88807b68b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
 #2: ffff88807b68b258 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_recv_cb+0x53/0x6d0 net/bluetooth/l2cap_sock.c:1488
 #3: ffff88807b68c518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #3: ffff88807b68c518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_sock_recv_cb+0xf3/0x6d0 net/bluetooth/l2cap_sock.c:1491

stack backtrace:
CPU: 1 PID: 6296 Comm: kworker/u9:3 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_freed_lock_bug kernel/locking/lockdep.c:6538 [inline]
 debug_check_no_locks_freed+0x3c5/0x4a0 kernel/locking/lockdep.c:6571
 slab_free_hook mm/slub.c:2159 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0xfa/0x360 mm/slub.c:4557
 sk_prot_free net/core/sock.c:2116 [inline]
 __sk_destruct+0x476/0x5f0 net/core/sock.c:2208
 sock_put include/net/sock.h:1879 [inline]
 l2cap_sock_recv_cb+0x59c/0x6d0 net/bluetooth/l2cap_sock.c:1545
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x8b6d/0x10670 net/bluetooth/l2cap_core.c:6833
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_lock+0x299/0x370 kernel/locking/spinlock_debug.c:115
Read of size 4 at addr ffff88807b68b1c4 by task kworker/u9:3/6296

CPU: 1 PID: 6296 Comm: kworker/u9:3 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 debug_spin_lock_before kernel/locking/spinlock_debug.c:86 [inline]
 do_raw_spin_lock+0x299/0x370 kernel/locking/spinlock_debug.c:115
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 release_sock+0x30/0x1f0 net/core/sock.c:3547
 l2cap_sock_recv_cb+0x5c8/0x6d0 net/bluetooth/l2cap_sock.c:1548
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x8b6d/0x10670 net/bluetooth/l2cap_core.c:6833
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6310:
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
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1880 [inline]
 l2cap_sock_create+0x13f/0x2d0 net/bluetooth/l2cap_sock.c:1920
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

Freed by task 6296:
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
 sock_put include/net/sock.h:1879 [inline]
 l2cap_sock_recv_cb+0x59c/0x6d0 net/bluetooth/l2cap_sock.c:1545
 l2cap_conless_channel net/bluetooth/l2cap_core.c:6780 [inline]
 l2cap_recv_frame+0x8b6d/0x10670 net/bluetooth/l2cap_core.c:6833
 hci_acldata_packet net/bluetooth/hci_core.c:3842 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4079
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88807b68b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 452 bytes inside of
 freed 2048-byte region [ffff88807b68b000, ffff88807b68b800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b688
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015042000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015042000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001eda201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6294, tgid 6294 (syz-executor), ts 136748851035, free_ts 136662215287
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
 __kmalloc_noprof+0x257/0x400 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ip6t_alloc_initial_table+0x71/0x640 net/ipv6/netfilter/ip6_tables.c:40
 ip6table_nat_table_init+0x23/0x2d0 net/ipv6/netfilter/ip6table_nat.c:113
 xt_find_table_lock+0x2d4/0x3b0 net/netfilter/x_tables.c:1260
 xt_request_find_table_lock+0x26/0x100 net/netfilter/x_tables.c:1285
 get_info net/ipv6/netfilter/ip6_tables.c:979 [inline]
 do_ip6t_get_ctl+0x89e/0x1820 net/ipv6/netfilter/ip6_tables.c:1668
 nf_getsockopt+0x299/0x2c0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x263/0x380 net/ipv6/ipv6_sockglue.c:1494
 tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4399
page last free pid 6294 tgid 6294 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2565
 __slab_free+0x31b/0x3d0 mm/slub.c:4347
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 __kmalloc_noprof+0x1a3/0x400 mm/slub.c:4134
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 ieee80211_register_hw+0x1bb2/0x3d80 net/mac80211/main.c:1328
 mac80211_hwsim_new_radio+0x2597/0x44c0 drivers/net/wireless/virtual/mac80211_hwsim.c:5470
 hwsim_new_radio_nl+0xe4c/0x21d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6151
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8db/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2192

Memory state around the buggy address:
 ffff88807b68b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b68b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807b68b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88807b68b200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807b68b280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=105ae75e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1098dcca980000


