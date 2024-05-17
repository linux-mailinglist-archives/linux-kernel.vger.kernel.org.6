Return-Path: <linux-kernel+bounces-181664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D468C7F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06A81F22530
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B6817;
	Fri, 17 May 2024 01:05:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8B622
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907907; cv=none; b=og93S55ZdhwzoF1cYguXQIVdEbk0vKiTyod7X4aZHo6OtieixEtlmnYG1dpLg7PQBS39MuU5i1jvahwRVt/AUZzEYstnRcIIQDmXj+85DlBGlgPs8jJOnTIT60Xo5qcl13hyI/C1qIdcLvywP8CDgSDtF/0JoijQJErJCEXwYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907907; c=relaxed/simple;
	bh=Mk8fNxgTK1aM7Jkm8oOLXPkferkuaBg3DpLZgurFiss=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qCDUIiLsFySiL5RJKv7kkHFdKTsbhjVKE6AMOH6DkJPMWsL7o15DPMdsaWt0pchGse2NJ6VrNpVz2Hx9vwW76MhXwEu0QHHzlpg/dvig1COhmEOhuW44vmBR9W0BZnLivzFzc2XzQSH9fOYSPi1qvdv51PsH0ejXjKBaPHNpibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1c3c98401so559228139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715907905; x=1716512705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E2h0Zn+lWKEYZ63TWbMiCMVPhtD2+BUp7X/mQz3yjis=;
        b=PdH/tkro02jqycp49jm8OSPV1UN74nZkRRFIMmaT7s26EbWpKfmAZUHcfVELb7JmfD
         P6WSgEt2bbxOIOSG3HU/xVKjrls4zH0LTfkfUZ2pgWcV86u9phHCMaqz2kcWR3npM9Cz
         o4po3XTqzM3ltyZKRS4MDecl5ljBZMuhCaVkdsik/Mt8GUKqnoNlZNWjnjfZkThNj1Cx
         LFMbUdTVI9Wbsyu2QmFJVgMG4nHGRnoe+ZEPBx8C3qGELe5WduhjpLVOAHUl8Zaa/JBA
         gs5TNPfTPuH/WU12AJrbMaare2TCG68zpDWmvG7yTQomu04UCyQhAKdQ9J2PhWpUqHLr
         AtAg==
X-Gm-Message-State: AOJu0Yyuu56ycODyaY3M/1ydqB91KUtBiyxpVyCy/11UBO+xP0tofvXz
	iSroVQEsAFF/vXyR24ADKwQu2FVcMOXcZzyUFbM/MaenEoVo9Q4r+iT6RFU46JrX1/acL1hpMt8
	RrwLIWbE+1BI/oUOR0qz+9SKiqQdGXwjiDD3jFAttFK3crivVDn41eE0=
X-Google-Smtp-Source: AGHT+IE3tPMINEdmi8t5ZACKr5BdzwXj13/6e31qIT55IQxw6bzMss2QSKb5UAIQuz9TWM/raAbhs1uK+mkSqXL8e89qUum61N4+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8421:b0:488:59cc:eb4f with SMTP id
 8926c6da1cb9f-48958576c65mr1400698173.1.1715907903328; Thu, 16 May 2024
 18:05:03 -0700 (PDT)
Date: Thu, 16 May 2024 18:05:03 -0700
In-Reply-To: <20240517005259.3901078-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bae8106189bf1ff@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
From: syzbot <syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in jfs_readdir

loop0: detected capacity change from 0 to 32768
sp ms: 103, dp ms: 2, diWrite
==================================================================
BUG: KASAN: slab-out-of-bounds in jfs_readdir+0x1b79/0x4660 fs/jfs/jfs_dtree.c:2894
Read of size 1 at addr ffff8880112dfdd5 by task syz-executor.0/5535

CPU: 1 PID: 5535 Comm: syz-executor.0 Not tainted 6.9.0-rc5-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 jfs_readdir+0x1b79/0x4660 fs/jfs/jfs_dtree.c:2894
 wrap_directory_iterator+0x94/0xe0 fs/readdir.c:67
 iterate_dir+0x539/0x6f0 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:409 [inline]
 __se_sys_getdents64+0x20d/0x4f0 fs/readdir.c:394
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f447227dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4472f0a0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007f44723abf80 RCX: 00007f447227dea9
RDX: 000000000000005d RSI: 00000000200002c0 RDI: 0000000000000005
RBP: 00007f44722ca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f44723abf80 R15: 00007ffff75dcee8
 </TASK>

Allocated by task 5535:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_lru+0x178/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode fs/inode.c:261 [inline]
 iget_locked+0x1ad/0x850 fs/inode.c:1280
 jfs_iget+0x22/0x3b0 fs/jfs/inode.c:29
 jfs_fill_super+0x808/0xc50 fs/jfs/super.c:580
 mount_bdev+0x20a/0x2d0 fs/super.c:1658
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880112def00
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 1557 bytes to the right of
 allocated 2240-byte region [ffff8880112def00, ffff8880112df7c0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x112d8
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888015bb6d01
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015be6dc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000d000d 00000001ffffffff ffff888015bb6d01
head: 00fff80000000840 ffff888015be6dc0 dead000000000122 0000000000000000
head: 0000000000000000 00000000000d000d 00000001ffffffff ffff888015bb6d01
head: 00fff80000000003 ffffea000044b601 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5492, tgid 556946219 (syz-executor.0), ts 5494, free_ts 89804801893
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_lru+0x253/0x350 mm/slub.c:3864
 alloc_inode_sb include/linux/fs.h:3091 [inline]
 jfs_alloc_inode+0x28/0x70 fs/jfs/super.c:105
 alloc_inode fs/inode.c:261 [inline]
 new_inode_pseudo+0x69/0x1e0 fs/inode.c:1007
 new_inode+0x22/0x1d0 fs/inode.c:1033
 jfs_fill_super+0x408/0xc50 fs/jfs/super.c:544
 mount_bdev+0x20a/0x2d0 fs/super.c:1658
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
page last free pid 5473 tgid 5473 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1400
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880112dfc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880112dfd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880112dfd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                 ^
 ffff8880112dfe00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880112dfe80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         ed30a4a5 Linux 6.9-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15266ae0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=aa6df9d3b383bf5f047f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11605ed0980000


