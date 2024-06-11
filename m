Return-Path: <linux-kernel+bounces-209196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000B902E90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD56E1F22193
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7E15ADBD;
	Tue, 11 Jun 2024 02:47:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB42A2A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074025; cv=none; b=bo5QLFCh7uAKlBRARPxtwkmBkM3vSDAbvurS5HHzXClJkZXoj5Kx69Q3ITpR7Vk+uHSbnQy4q5DcQu6uercN2phjq9oU/8pKZ3So8uadIYw8DvoOKmAo3gCJKKsr7iBlrHj5A+MVMsBjzmL/+yvXnlwmGfbbpW9VTffVxaExCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074025; c=relaxed/simple;
	bh=n1WmffCJ8h7gNz0KDrL2JHjy+eyL65DdpHisrc4RQTE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AUMWpQz8Doxtft2h+ROaA6JuUaW4Bj2YJ46sMTnytixkCzTMNTGRbH+2TpvswvL4y/29b++nvQ38SLEBVUDdCEU6VflSEGaujKoMw/51wqufq4KiVaU3TAzMY8h+02OAT9c5NI/2oQbTrUZoGVnseMFy/2BQokEUhJAjlnTdbL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb50e42c6aso558893339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718074023; x=1718678823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQdfzUOtAcoZRF6JewFPmR++K7hgW6nFtNLU6yxHdhQ=;
        b=aqFDFKOl4q0c11ddrB7cn1e5VZUSPqsX9lFCfZD/PFfbZZyyDKD9PHn7Lk3eDdmE5k
         NWYmh48VNQZ2kMLwpap6V/aVmtx2DA5SY4GN9SnVovUlOQvfojHZOkJ2Zi7NMhHnWj0O
         FKxQrB2u7OuRCHfKHBzraethPc4dBNYkDEKZ5U9mMERxNQHifbBrZ1OjzcU+jJBco1t0
         EalWGet1Gq6LwJt/i0VpAArxjzJne/bdktFXSnSqznJGfR/6571eTN5E/zMxO0eQWMKm
         R6Nb62nfipEgxaQJOMW2P5y7Z2TQD2nNvCFWGvxc3irqUhml0qTyA/TMobeC72se1HMq
         fYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn95i5+YqUBuqQ2KXCDuW77m3zzphx0J9UHHx7vNgqq85l5vx4tsRnX5+eMMxVLGkCuHrrHyp3CYBGfBJH/Z/snpDYaKKLvTe6PNSr
X-Gm-Message-State: AOJu0YyUlTz/vMoufZF4UzgyfxMt2cMBV0bXwCdnzq/DPG32xBr5PsRv
	irkS8WtDDu6LNicjiNBUvASLMGJsLPqHMBIgGyKnlGR5MfD+6ax+pxdehPprSSlSnNM+dImu8Wy
	NSZmD1L1aFahDdrVWy8JYXWEmTwp7eloKiKzrCZU71V3+Nz9TL0Ydo8w=
X-Google-Smtp-Source: AGHT+IEQA68uOqS4lDZV6v2dxly2FLOu+xl0hvk/NxuIjeK6e7Hk5zL1iq8RMOg8wxgZ/yMpnWmG9uDFbsbuVHKged8MrVqDxR1t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8410:b0:488:d668:d201 with SMTP id
 8926c6da1cb9f-4b7b11d79edmr302258173.1.1718074023387; Mon, 10 Jun 2024
 19:47:03 -0700 (PDT)
Date: Mon, 10 Jun 2024 19:47:03 -0700
In-Reply-To: <tencent_DC337C9ECD1BAD4BFC1B4C25ACBAF1BB7E08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcb5bb061a9447ae@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in smack_socket_sock_rcv_skb

==================================================================
BUG: KASAN: slab-use-after-free in smack_socket_sock_rcv_skb+0xec/0x13a0 security/smack/smack_lsm.c:4142
Read of size 8 at addr ffff88807ae86498 by task kworker/u9:2/5148

CPU: 1 PID: 5148 Comm: kworker/u9:2 Not tainted 6.10.0-rc1-syzkaller-00267-gcc8ed4d0a848-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 smack_socket_sock_rcv_skb+0xec/0x13a0 security/smack/smack_lsm.c:4142
 security_sock_rcv_skb+0x6d/0xa0 security/security.c:4603
 sk_filter_trim_cap+0x184/0xa80 net/core/filter.c:150
 sk_filter include/linux/filter.h:945 [inline]
 l2cap_sock_recv_cb+0x176/0x580 net/bluetooth/l2cap_sock.c:1504
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

Allocated by task 5966:
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
 l2cap_sock_alloc net/bluetooth/l2cap_sock.c:1873 [inline]
 l2cap_sock_create+0x13f/0x2d0 net/bluetooth/l2cap_sock.c:1913
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

Freed by task 5965:
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

The buggy address belongs to the object at ffff88807ae86000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1176 bytes inside of
 freed 2048-byte region [ffff88807ae86000, ffff88807ae86800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ae80
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888015042000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888015042000 dead000000000122 0000000000000000
head: 0000000000000000 0000000080080008 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001eba001 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5658, tgid 5658 (syz-executor), ts 103136223027, free_ts 103057739028
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
 ip6table_mangle_table_init+0x1c/0x70 net/ipv6/netfilter/ip6table_mangle.c:82
 xt_find_table_lock+0x2d4/0x3b0 net/netfilter/x_tables.c:1260
 xt_request_find_table_lock+0x26/0x100 net/netfilter/x_tables.c:1285
 get_info net/ipv6/netfilter/ip6_tables.c:979 [inline]
 do_ip6t_get_ctl+0x89e/0x1820 net/ipv6/netfilter/ip6_tables.c:1668
 nf_getsockopt+0x299/0x2c0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x263/0x380 net/ipv6/ipv6_sockglue.c:1494
 tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4399
page last free pid 4534 tgid 4534 stack trace:
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
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4007
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1399
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807ae86380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ae86400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807ae86480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88807ae86500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807ae86580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=147f0d02980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e10922980000


