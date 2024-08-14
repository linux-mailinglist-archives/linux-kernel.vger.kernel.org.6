Return-Path: <linux-kernel+bounces-286208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC2951805
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D1CB2114C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0117C7A2;
	Wed, 14 Aug 2024 09:47:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE913634A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628825; cv=none; b=EOW01a2rxMmglwtILiiirjzaQ0ZdxWdPgMoTMGC0CmyJ8BgufhBY6t4j5cd2nCoXaN2+4fFYzGDiwWVKne8KrEeGZ1H0RJp/t2MiyXvmTuG1GDO4qH8Azo1cMzMUEnUbT7Azl/DAIQPlhVtPew6S1MiA7KJLxl+BZwp6LEfzXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628825; c=relaxed/simple;
	bh=PKG/24fViY5eV92qMAIdv4u70Qxi/H77tF4ikLrwBoI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EZlQtRT7l0+99gnWp65LXLvMYXdxvU1gHhPtRbhbbehaQ3wawNRUiVmi2SRovsACqAEeE+fk9Ex5D/j7mt4XqiXlpGgPmhyjifjv0pC9B9E2LhsU9AnImVf+mZshZwmoz0MfmtG7F/0U+g7yLq9e9uqQQGJlB4zoH0R0QvfEsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1f627b3dso81599085ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723628822; x=1724233622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdEPRtWqCxLFLxYxhaZTr3N/uBPFxezMkP1jwzZjR64=;
        b=QRShm+oUtHX/8Ty8F8pPP4g5Un/cpMDCf0bTZfM7GDXVKUz7WdsmqcYx12zzc+8EgQ
         WQzCm+U95zcRCqtsNORpVbzIqg9xBPKiJXnIEX9gcgmhb63IatreFhRx3XuEyy8oP+nq
         tK22dBY4sxWLab7FhuOfOMxEX6HCpKapEECkn4iHrYmD0AgYxgaHNEdIAqChIti5ICmh
         XL2Wryiuf/qX//1xMXN3SBo2QCL/TYch/bjruoSwagDSARsytI+zfqyOxySscM7NCpIz
         AG5HKuOnxvJx5YYxi+KMtFuzR/ADB7bAbnzxpcyjJ1qe+st9IPXXhqa/+1lGJH33qxpG
         1bpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuubZCspP41BfoEA9YhC2Ev5PyNneMoFokmD9naCLq3yCJOCPrPV4y5hJKFWqG9Yj+ITJaj2i+4gOYLuol3druB4NJGl/p4V2LHwDJ
X-Gm-Message-State: AOJu0Yx1XRhby21No7+dwFzXwXTD99MYgZrmwQtUfZPeE8xjRk30dEz+
	lwn9fIA3F3DqocRqOygu2ibXLatO81zr48vsYylCnbjcYvvJ7g2gIykc6pIEVKsSKN8ickcZtyX
	T7wxOWtsEp863rfFBfdz2E2N5zhLK/E0t8yvvwPAdMPsLLviXsZeRtTw=
X-Google-Smtp-Source: AGHT+IGCoe1hJdCyZXngs/G38LfkMNupu2+gFMaRiTRhQzB1UoUPvZuMCh1+mpD1LHvKAzDgPEySK9baHVuAqjh8VrOGkRb3QzfL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56d:0:b0:39d:1236:a9b4 with SMTP id
 e9e14a558f8ab-39d124582c9mr1918925ab.2.1723628822464; Wed, 14 Aug 2024
 02:47:02 -0700 (PDT)
Date: Wed, 14 Aug 2024 02:47:02 -0700
In-Reply-To: <tencent_5D5C3C9B368696CC37D64A8A755F77196609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b01eee061fa19bdb@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in v9fs_fid_find_inode

==================================================================
BUG: KASAN: slab-use-after-free in v9fs_fid_find_inode+0x2e9/0x320 fs/9p/fid.c:72
Read of size 4 at addr ffff88801ef88810 by task kworker/u32:10/1215

CPU: 1 UID: 0 PID: 1215 Comm: kworker/u32:10 Not tainted 6.11.0-rc1-syzkaller-00154-gc0ecd6388360-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: writeback wb_workfn (flush-9p-31)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 v9fs_fid_find_inode+0x2e9/0x320 fs/9p/fid.c:72
 v9fs_begin_writeback+0x49/0x280 fs/9p/vfs_addr.c:37
 netfs_writepages+0x656/0xde0 fs/netfs/write_issue.c:534
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 __writeback_single_inode+0x163/0xf90 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x611/0x1150 fs/fs-writeback.c:1947
 wb_writeback+0x199/0xb50 fs/fs-writeback.c:2127
 wb_do_writeback fs/fs-writeback.c:2274 [inline]
 wb_workfn+0x28d/0xf40 fs/fs-writeback.c:2314
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5955:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 p9_fid_create+0x45/0x470 net/9p/client.c:856
 p9_client_walk+0xc6/0x550 net/9p/client.c:1157
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_clone fs/9p/fid.h:33 [inline]
 v9fs_file_open+0x63d/0xbb0 fs/9p/vfs_file.c:57
 do_dentry_open+0x91f/0x15f0 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1215:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4594
 p9_client_clunk+0x12a/0x170 net/9p/client.c:1459
 p9_fid_put include/net/9p/client.h:280 [inline]
 v9fs_free_request+0xdc/0x110 fs/9p/vfs_addr.c:138
 netfs_free_request+0x257/0x720 fs/netfs/objects.c:135
 netfs_put_request+0x19b/0x1f0 fs/netfs/objects.c:170
 netfs_write_collection_worker+0x1a1d/0x5a10 fs/netfs/write_collect.c:702
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88801ef88800
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 16 bytes inside of
 freed 96-byte region [ffff88801ef88800, ffff88801ef88860)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ef88
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888015842280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4829, tgid 4829 (udevd), ts 32699297341, free_ts 30639630227
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2321
 allocate_slab mm/slub.c:2484 [inline]
 new_slab+0x84/0x260 mm/slub.c:2537
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3723
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x367/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x19d/0x720 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x273/0x450 security/tomoyo/file.c:822
 security_inode_getattr+0xf4/0x160 security/security.c:2269
 vfs_getattr fs/stat.c:204 [inline]
 vfs_fstat+0x53/0xd0 fs/stat.c:229
 vfs_fstatat+0x146/0x160 fs/stat.c:338
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:505
page last free pid 4837 tgid 4837 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2612
 __put_partials+0x14c/0x170 mm/slub.c:3051
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x199/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 tomoyo_realpath_from_path+0xb9/0x720 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2a7/0x3b0 security/tomoyo/file.c:771
 tomoyo_file_open+0x71/0x90 security/tomoyo/tomoyo.c:334
 security_file_open+0x78/0x8b0 security/security.c:2988
 do_dentry_open+0x5c7/0x15f0 fs/open.c:946
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442

Memory state around the buggy address:
 ffff88801ef88700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88801ef88780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88801ef88800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                         ^
 ffff88801ef88880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88801ef88900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1219db5d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f5adcb980000


