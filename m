Return-Path: <linux-kernel+bounces-446301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBE9F224B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124E97A103B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474513AD0;
	Sun, 15 Dec 2024 05:35:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3707946C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734240904; cv=none; b=eSsqhZBZgUFsEivqB7ENeLGJ2lD5Qa87xe1yGEhe8mnwBfRJb7sWREPefS9ZdlQkVUoVf0puhSrQTcy7rC2NE7kFF3kxd5bO0igrvFeaoSn0w+AGtDfik0LYII91amz27VKXCBF2XMp/ER9ouKk42HjYakz/iePwXjkgNOlEWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734240904; c=relaxed/simple;
	bh=FBPCUZRXWXmvgV4loZVBfKENLl1/mPiu2cleQCe6N7E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cIBFkG8Ym353Y8mqryLqfTb8NUOxGrhCql19hVbJGl82eurw/mV6sulNh7KeDAWDjJha5hUDVWn8Qf9p/x5jD83y+Sz4AkTeNLlGMk+XboNjnX+Lox/9ub4wGWTINNxOQFU6Qnb17GkM93Yo+Av4LwRm1BYz6PkR9VIZYUstWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so40955125ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 21:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734240902; x=1734845702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRnfhVOi15bSJ8zNNGm6FW9IiQmu8QSljXQHZouKqNE=;
        b=AZjOcfZiFj2htna4mLCakHKBeXICXU+N4Uxw+SXh5YkUV1pbJ3Z7ObbqfHbUPghwn7
         R6UYBZWVrCBbBF2uayyiGdHIMRjw+BABYHQdE6k0jJttVYp9h02bRxWXnp6P9ZqSm95M
         xQaVwAK4tTg2IZGOvGXuxaw415cbqLaERGphVvoEDjpBUyUJ8qyHUfPc/AIXjNIwDNyD
         k456Jdbqd6JgDLdAhIqcOMWle2Q9jxG6rvOoK4Rq45lVRgMewHWfso3ufbDwPwb42rG0
         9HAWvwIsGtkyQatoeSyFejA5oWVeu9D9LfpaRWlMQAQnJdHOXp3r3rvGTBDMxfIjCfLa
         Sprw==
X-Forwarded-Encrypted: i=1; AJvYcCXp+qlp7/ymPSwjZprYlpt08ffBRGKMEGpYflad5hbUn3P+w+wCv1rJ5HXCZ4w/ZH488/27cHDs4g2bxxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQooZzsXUkcxNxsagX5Qu7Nta7pc67Q58T18k88Gz4LUZdeUvG
	vHZCOd2UngkTR6NyO0nDGVRFj+gFs7ZnYeVu/u0oLwqskFCXRVL8GsDvF7w8Ib6zqlsu3XED4Fv
	Lx+QPpZOJuje2/5IdoJBfVdFs0MpM1dLVqJvU+jlitP7F+pzriPp/Sno=
X-Google-Smtp-Source: AGHT+IEfkMcHQXLswuAss2bcLOp/orQAnm7KLQXiDP5soN78ZdDnnjdn1cvPG2EIl2dOmPnhzxFUe71lQTkdd1jyzVNThjHU82Ny
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160b:b0:3a9:cc7f:2bc5 with SMTP id
 e9e14a558f8ab-3ae61f23afamr99208235ab.3.1734240901875; Sat, 14 Dec 2024
 21:35:01 -0800 (PST)
Date: Sat, 14 Dec 2024 21:35:01 -0800
In-Reply-To: <tencent_8146EC92D7066E89802EFEEED48C8427DE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e6a85.050a0220.37aaf.00f0.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in folio_evictable

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:269 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable+0xe3/0x250 mm/internal.h:435
Read of size 8 at addr ffff88804fd613a0 by task syz.0.23/6094

CPU: 0 UID: 0 PID: 6094 Comm: syz.0.23 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:269 [inline]
 folio_evictable+0xe3/0x250 mm/internal.h:435
 sort_folio mm/vmscan.c:4299 [inline]
 scan_folios mm/vmscan.c:4424 [inline]
 isolate_folios mm/vmscan.c:4550 [inline]
 evict_folios+0xff2/0x5800 mm/vmscan.c:4581
 try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
 shrink_one+0x3b9/0x850 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 shrink_zones mm/vmscan.c:6215 [inline]
 do_try_to_free_pages+0x78c/0x1cf0 mm/vmscan.c:6277
 try_to_free_pages+0x47c/0x1050 mm/vmscan.c:6527
 __perform_reclaim mm/page_alloc.c:3927 [inline]
 __alloc_pages_direct_reclaim+0x178/0x3c0 mm/page_alloc.c:3949
 __alloc_pages_slowpath+0x764/0x1020 mm/page_alloc.c:4380
 __alloc_pages_noprof+0x49b/0x710 mm/page_alloc.c:4764
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 folio_alloc_mpol_noprof+0x36/0x50 mm/mempolicy.c:2287
 shmem_alloc_folio mm/shmem.c:1794 [inline]
 shmem_alloc_and_add_folio+0x4a0/0x1080 mm/shmem.c:1833
 shmem_get_folio_gfp+0x621/0x1840 mm/shmem.c:2355
 shmem_get_folio mm/shmem.c:2461 [inline]
 shmem_write_begin+0x165/0x350 mm/shmem.c:3117
 generic_perform_write+0x346/0x990 mm/filemap.c:4055
 shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3293
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee41f847cf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007fee42e47df0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00007fee41f847cf
RDX: 0000000001000000 RSI: 00007fee38c00000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000001274a
R10: 0000000020000142 R11: 0000000000000293 R12: 0000000000000003
R13: 00007fee42e47ef0 R14: 00007fee42e47eb0 R15: 00007fee38c00000
 </TASK>

Allocated by task 6026:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_noprof+0x1d9/0x380 mm/slub.c:4175
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1178
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_dir_search+0x229/0x2f0 fs/gfs2/dir.c:1667
 gfs2_lookupi+0x461/0x5e0 fs/gfs2/inode.c:340
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:587 [inline]
 init_journal+0x602/0x2470 fs/gfs2/ops_fstype.c:729
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:866
 gfs2_fill_super+0x1bd1/0x24d0 fs/gfs2/ops_fstype.c:1251
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6014:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4613 [inline]
 kmem_cache_free+0x195/0x410 mm/slub.c:4715
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 do_softirq+0x11b/0x1e0 kernel/softirq.c:462
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:389
 ipv6_get_lladdr+0x295/0x3d0 net/ipv6/addrconf.c:1936
 mld_newpack+0x337/0xaf0 net/ipv6/mcast.c:1755
 add_grhead net/ipv6/mcast.c:1850 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
 mld_send_cr net/ipv6/mcast.c:2114 [inline]
 mld_ifc_work+0x691/0xd90 net/ipv6/mcast.c:2651
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 __gfs2_glock_free+0xda0/0xef0 fs/gfs2/glock.c:172
 gfs2_glock_free+0x3c/0xb0 fs/gfs2/glock.c:178
 gfs2_glock_put_eventually fs/gfs2/super.c:1257 [inline]
 gfs2_evict_inode+0x6e2/0x13c0 fs/gfs2/super.c:1546
 evict+0x4e8/0x9a0 fs/inode.c:796
 gfs2_jindex_free+0x3f6/0x4b0 fs/gfs2/super.c:79
 init_journal+0xa46/0x2470 fs/gfs2/ops_fstype.c:848
 init_inodes+0xdc/0x320 fs/gfs2/ops_fstype.c:866
 gfs2_fill_super+0x1bd1/0x24d0 fs/gfs2/ops_fstype.c:1251
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:544
 insert_work+0x3e/0x330 kernel/workqueue.c:2183
 __queue_work+0xc8b/0xf50 kernel/workqueue.c:2339
 queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2552
 queue_delayed_work include/linux/workqueue.h:677 [inline]
 gfs2_glock_queue_work fs/gfs2/glock.c:250 [inline]
 do_xmote+0xaf8/0x1250 fs/gfs2/glock.c:832
 glock_work_func+0x343/0x5c0 fs/gfs2/glock.c:1090
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88804fd60fd8
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 968 bytes inside of
 freed 1224-byte region [ffff88804fd60fd8, ffff88804fd614a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4fd60
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801fa6cdc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000040 ffff88801fa6cdc0 dead000000000122 0000000000000000
head: 0000000000000000 00000000800c000c 00000001f5000000 0000000000000000
head: 04fff00000000002 ffffea00013f5801 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6026, tgid 6025 (syz.0.16), ts 112070887808, free_ts 112070839340
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2269
 alloc_slab_page+0x6a/0x110 mm/slub.c:2423
 allocate_slab+0x5a/0x2b0 mm/slub.c:2589
 new_slab mm/slub.c:2642 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
 __slab_alloc+0x58/0xa0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 kmem_cache_alloc_noprof+0x268/0x380 mm/slub.c:4175
 gfs2_glock_get+0x309/0x1010 fs/gfs2/glock.c:1178
 gfs2_inode_lookup+0x2a3/0xc90 fs/gfs2/inode.c:135
 gfs2_lookup_root fs/gfs2/ops_fstype.c:440 [inline]
 init_sb+0xa2a/0x1270 fs/gfs2/ops_fstype.c:507
 gfs2_fill_super+0x19b3/0x24d0 fs/gfs2/ops_fstype.c:1218
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
page last free pid 6026 tgid 6025 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2657
 stack_depot_save_flags+0x7c6/0x940 lib/stackdepot.c:674
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_save_track+0x51/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4119 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 kmem_cache_alloc_lru_noprof+0x1dd/0x390 mm/slub.c:4187
 gfs2_alloc_inode+0x58/0x170 fs/gfs2/super.c:1555
 alloc_inode+0x65/0x1a0 fs/inode.c:336
 iget5_locked+0x4a/0xa0 fs/inode.c:1404
 gfs2_inode_lookup+0xf3/0xc90 fs/gfs2/inode.c:124
 gfs2_lookup_root fs/gfs2/ops_fstype.c:440 [inline]
 init_sb+0xa2a/0x1270 fs/gfs2/ops_fstype.c:507
 gfs2_fill_super+0x19b3/0x24d0 fs/gfs2/ops_fstype.c:1218
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1332
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034

Memory state around the buggy address:
 ffff88804fd61280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804fd61300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804fd61380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88804fd61400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804fd61480: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12116730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fe6730580000


