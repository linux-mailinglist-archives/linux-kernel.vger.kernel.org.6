Return-Path: <linux-kernel+bounces-193225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868C8D28A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12EC288E14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9853513EFFB;
	Tue, 28 May 2024 23:18:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D47405F8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938285; cv=none; b=hPW5PI9jrIP98e1E2wsgf1Srl0Fy2R+v7wIlaXoTOoi+2ZwOc11d6eyrcKYWeULr189gNfT9grrfved57iSzlzBYKsRau4VZld/m6CRgirOvadJ40W2rpoA6d3CfKVdPQ5vzU4IUWxCNIZFI2Bxv5e7+1UlzOQh/tD+Dv0AIbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938285; c=relaxed/simple;
	bh=Aqmx7t7eJ61Ld29gZZuVG5ovtSWSDnuXvkqWTNeJpnI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kE3DYhhEyF9fBXp/OeWkc0QM4ydSLtDuqz21TwwdUzlFXE9YKcP5rK6qEwg3n6ODuSpHILM2JCKMfx9Ebs+KPjq7OOVPlar/LWB2MnCJQVqsV7TXScot0RYMRtKFrsrQZytOGY6e1nLx6FmdauV1a3bqbF4csSDazVHDC96E9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e5d55441so187402739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938283; x=1717543083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DHw0Hv5DFEiICw7Ywk5qSmCz18sTHQoFeblczRwxPI=;
        b=LdyAYjj2+lCH16oeQf1i6+uJSdWLcjQgvuW/SSKmQoOjS6sqmQT7MmLRW8UQexVyj8
         lcWQpdpAwehXY8gC4kEmuzMvFPJJhgZjxkHJkJP02so4gNCVmAHXgu6aLYoZ69DiCmdA
         RBHThOvPGng39r1hHi4AvcK20r47t2JkcCRBAU5Kk2D3TeP4Mxc5fV9RsnDd7MUh16ln
         s9j/5rDwzAkN3BINC1R4viUK5kFLer4tdsnuLVhOo5iCBUtd9Kzb4mfM9YZ+/hFqQf2R
         tA27mLDDOybU5zFiM5IYGqrV9qu1ymyEMVTEJ/RvkHLaOLQbZ7A4bdi1d0xazXgsJrg/
         LPaw==
X-Forwarded-Encrypted: i=1; AJvYcCXiPTJKzhq9cMlRpyZZBsVvO//R3svH6qX3IrnnQft5quz91MGgB8KeNkKYjcbguEC4MAtdRd+iiSqr8cII1mJ9AMmmeU5ItLR72mAg
X-Gm-Message-State: AOJu0YzTlAD4yvEUt+/GE2A08eD6CwHtSaAV0rKsh8LM8hBgO/zuhxqc
	Vxyg+Ha2e7fEu5/louRjnVbKfe8DGOuM3LJoFdFn49a+HeXRRzqsfnElm2lx28On6gGrMbeYBDE
	0FNy5PZXO7QoUcbG37zd1IoAt6+laNyLa+8addjJnIVVGkgmfAKV+AYw=
X-Google-Smtp-Source: AGHT+IGxUamHdKJom5cAFVtBZw33OTkWa9XqwA0ryKAoChhmhWhF+jgmmj/93QXNHoJzx3a26pi31j4Dh41c+iqX1nWUEGmvKPzm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c017:0:b0:4b1:8aa:af6b with SMTP id
 8926c6da1cb9f-4b108aab105mr90288173.1.1716938283390; Tue, 28 May 2024
 16:18:03 -0700 (PDT)
Date: Tue, 28 May 2024 16:18:03 -0700
In-Reply-To: <20240528225829.2818-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ba6d806198bd825@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in chrdev_open

loop0: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-use-after-free in __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
Read of size 8 at addr ffff888077a232e8 by task syz-executor.0/5460

CPU: 0 PID: 5460 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_add_valid_or_report+0x4c/0xf0 lib/list_debug.c:29
 __list_add_valid include/linux/list.h:88 [inline]
 __list_add include/linux/list.h:150 [inline]
 list_add include/linux/list.h:169 [inline]
 chrdev_open+0x2a9/0x630 fs/char_dev.c:396
 do_dentry_open+0x98b/0x1760 fs/open.c:960
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1411
 do_sys_open fs/open.c:1426 [inline]
 __do_sys_openat fs/open.c:1442 [inline]
 __se_sys_openat fs/open.c:1437 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1437
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc31de7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc31ec9f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc31dfabf80 RCX: 00007fc31de7dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007fc31deca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc31dfabf80 R15: 00007ffe9eccbdd8
 </TASK>

Allocated by task 5449:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4019
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:563
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 ntfs_new_inode+0x45/0x100 fs/ntfs3/fsntfs.c:1688
 ntfs_create_inode+0x5f1/0x3680 fs/ntfs3/inode.c:1347
 ntfs_mknod+0x3c/0x50 fs/ntfs3/namei.c:122
 vfs_mknod+0x36d/0x3b0 fs/namei.c:4009
 do_mknodat+0x3ec/0x5b0
 __do_sys_mknodat fs/namei.c:4087 [inline]
 __se_sys_mknodat fs/namei.c:4084 [inline]
 __x64_sys_mknodat+0xa9/0xc0 fs/namei.c:4084
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 8:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4511
 rcu_do_batch kernel/rcu/tree.c:2535 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2809
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 ipv6_get_lladdr+0x295/0x3d0 net/ipv6/addrconf.c:1935
 mld_newpack+0x338/0xa90 net/ipv6/mcast.c:1754
 add_grhead net/ipv6/mcast.c:1849 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
 mld_send_cr net/ipv6/mcast.c:2113 [inline]
 mld_ifc_work+0x68e/0xd90 net/ipv6/mcast.c:2650
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3072 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3176
 __dentry_kill+0x20d/0x630 fs/dcache.c:603
 shrink_kill+0xa9/0x2c0 fs/dcache.c:1048
 shrink_dentry_list+0x2c0/0x5b0 fs/dcache.c:1075
 shrink_dcache_parent+0xcb/0x3b0
 do_one_tree+0x23/0xe0 fs/dcache.c:1538
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1555
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:621
 kill_block_super+0x44/0x90 fs/super.c:1677
 ntfs3_kill_sb+0x44/0x1b0 fs/ntfs3/super.c:1798
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888077a22c40
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff888077a22c40, ffff888077a23320)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77a20
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888029d33a01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff88801a3928c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080110011 00000001ffffefff ffff888029d33a01
head: 00fff00000000040 ffff88801a3928c0 dead000000000122 0000000000000000
head: 0000000000000000 0000000080110011 00000001ffffefff ffff888029d33a01
head: 00fff00000000003 ffffea0001de8801 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5449, tgid 5448 (syz-executor.0), ts 81273391795, free_ts 81190252679
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
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4019
 ntfs_alloc_inode+0x28/0x80 fs/ntfs3/super.c:563
 alloc_inode fs/inode.c:261 [inline]
 iget5_locked+0xa4/0x280 fs/inode.c:1235
 ntfs_iget5+0xd5/0x3b10 fs/ntfs3/inode.c:532
 ntfs_fill_super+0x2619/0x4a20 fs/ntfs3/super.c:1212
 get_tree_bdev+0x3f7/0x570 fs/super.c:1616
 vfs_get_tree+0x90/0x2a0 fs/super.c:1781
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
page last free pid 45 tgid 45 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2565
 discard_slab mm/slub.c:2526 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2994
 put_cpu_partial+0x17c/0x250 mm/slub.c:3069
 __slab_free+0x2ea/0x3d0 mm/slub.c:4306
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3940 [inline]
 slab_alloc_node mm/slub.c:4000 [inline]
 __do_kmalloc_node mm/slub.c:4120 [inline]
 kmalloc_node_track_caller_noprof+0x1cd/0x440 mm/slub.c:4141
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
 sock_alloc_send_skb include/net/sock.h:1773 [inline]
 mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
 add_grhead net/ipv6/mcast.c:1849 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
 mld_send_cr net/ipv6/mcast.c:2113 [inline]
 mld_ifc_work+0x68e/0xd90 net/ipv6/mcast.c:2650
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312

Memory state around the buggy address:
 ffff888077a23180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888077a23200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888077a23280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888077a23300: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888077a23380: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         e0cce98f Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101ea864980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10cba53c980000


