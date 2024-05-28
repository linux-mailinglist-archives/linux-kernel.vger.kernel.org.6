Return-Path: <linux-kernel+bounces-192160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA718D1944
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48C11F231C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C816C684;
	Tue, 28 May 2024 11:21:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E738F9C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716895266; cv=none; b=ljYXqQqZwKiXtw4UoNNJqxQWAuL4ek+5dZxVUYk0uyyrPSPZ/nWXWxYJ+XqaRN+Q3koR3D18eWMofCfrC0BMFzIt1X5VAoo5ao0tbW9JIyMco9aQKeuQOEZZ9y9QifHqSPF1Wd0rVv4PF5JlY2xHDc6e/kHBxSDXxSkAMCQRsew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716895266; c=relaxed/simple;
	bh=EF/125+BxoI8xIBItoOKAEz0u8NFwgGm6g7jdS5FT/Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OVtaQ2FiVPncALb3aRIiWBVCXG/DcasUL3p5+s5ZfQFJlfgOmcQGmHLy9FQeP+uzKPAy/zBu8ZkNWcyuDcY/y7yZOaJorSGNt/snwFffpNlmjqLWrILsyKsmNFyzSBgDDZhQQJGfVRH1OTbdMC4U/BiKTRnPnDx5Z84bxMVNhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3738836578aso7570575ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716895263; x=1717500063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeMn/Un8xV5LZGkdgqdV40YN/ylTRRo+VR7MtbXu7uo=;
        b=u8zatmrXysEheNUIebslevBDcSySeKwMxE9h3YMQj1tzPfTA0qeddIBpAKtBLr2ut5
         ND802RHFMRmcUrRmyoKqLZ238oAy0r2lg4lfYgorDJs7SUDwijw5Azlr16Y9kHgORYR7
         EEYZbQxsW5d4a74ZQkOc74gOsCjJw/sEDR/5JoiD5w9jyt1LPOMHYgVc1eEVbugyBYPk
         4F5z/4T94WJrZunwUioG16uVoFW0F3Bo9BPkTF6uQ/SYjujW+5ffcgDrN0TJYa8gjPa1
         SkYsSqFwlgoBHgCT8Idwa/f3tgFl0gMcJl9HCqAfG+zJ1nGec1hIi9wiJ5RiPYguX4l2
         +Ztg==
X-Forwarded-Encrypted: i=1; AJvYcCUHssxH/9QGq3uciuEM9HRChEbte0gbv6acsaEK4erj2DsjPP1x94QRDWJfW9hqQGa8m3j9ujUaXYmYqwdZZTZq3mPiQ4QUf82lZFwT
X-Gm-Message-State: AOJu0YwsfK/0ocnGh8RzNxLmTtBI7fdDhZ5QXVF1Nf+7AmWFHGnwVtBH
	aYvcPGtZbD84xC65RvxZxAPk3sVE71ZFpwjx0DbED2FrftxHwPXJ7a4lEV2Igc231EY7RbO6Rih
	b4S4+DiKLrN50oZ/ca8Y+hgqtpc/cJiaapp9zHMHdHmAHnlQ1mFcdAzI=
X-Google-Smtp-Source: AGHT+IGxGzM/7oZIslXUHEGpP1IBq8ikm6ri32FzkwIelkAgDYLxEoQR9aq3jBwoonDV3krGGW2rsp68qu5sSksxNFFUp5wjUxS+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1a:b0:36d:b5df:f478 with SMTP id
 e9e14a558f8ab-3737b3c808emr10620815ab.4.1716895263671; Tue, 28 May 2024
 04:21:03 -0700 (PDT)
Date: Tue, 28 May 2024 04:21:03 -0700
In-Reply-To: <20240528110830.2701-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004eda9e061981d4b4@google.com>
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
Read of size 8 at addr ffff8880113cfca8 by task syz-executor.0/5461

CPU: 1 PID: 5461 Comm: syz-executor.0 Not tainted 6.10.0-rc1-syzkaller-00013-g2bfcfd584ff5-dirty #0
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
RIP: 0033:0x7f01dec7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01df9c60c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f01dedabf80 RCX: 00007f01dec7dea9
RDX: 0000000000000000 RSI: 0000000020002140 RDI: ffffffffffffff9c
RBP: 00007f01decca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f01dedabf80 R15: 00007ffd90197338
 </TASK>

Allocated by task 5450:
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

Freed by task 24:
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
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
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
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 kill_block_super+0x44/0x90 fs/super.c:1676
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

The buggy address belongs to the object at ffff8880113cf600
 which belongs to the cache ntfs_inode_cache of size 1760
The buggy address is located 1704 bytes inside of
 freed 1760-byte region [ffff8880113cf600, ffff8880113cfce0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888017aa0101
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888017fd8500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffefff ffff888017aa0101
head: 00fff00000000040 ffff888017fd8500 dead000000000122 0000000000000000
head: 0000000000000000 0000000000110011 00000001ffffefff ffff888017aa0101
head: 00fff00000000003 ffffea000044f201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5450, tgid 5449 (syz-executor.0), ts 82132262701, free_ts 15999397112
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
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2565
 free_reserved_page include/linux/mm.h:3187 [inline]
 free_reserved_area+0x198/0x240 mm/page_alloc.c:5776
 free_init_pages arch/x86/mm/init.c:927 [inline]
 free_kernel_image_pages arch/x86/mm/init.c:943 [inline]
 free_initmem+0x9a/0x110 arch/x86/mm/init.c:970
 kernel_init+0x31/0x2b0 init/main.c:1476
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880113cfb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880113cfc00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880113cfc80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                  ^
 ffff8880113cfd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880113cfd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         2bfcfd58 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b82344980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bd39ec980000


