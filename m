Return-Path: <linux-kernel+bounces-248744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0F192E168
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7531F21B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939414B955;
	Thu, 11 Jul 2024 07:57:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A55F4963F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684626; cv=none; b=NkG7Wj2LJnLc8G95Eonw/v3CMSqFbRhWRup4ko470Kr9utOAtZQyuxrfOoVAUk1D4jzC1FNwyEnra7BSuwsctI5lXouCuwQV9l8l7upuBUqhrc47Iw9PpRWNcGGs2uqoDeibIBkKrPqA0c3BKeDxlNs44CqbWqPsvhZVpKe7IG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684626; c=relaxed/simple;
	bh=lmShxM/64hherYa6LYBoyjARgfMMmc6X3kUymo9v7Rs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kVJd5LP5e7oeLvKkLeLdv/F5zJINlHQIGN7wa5osCz3+bHwuG+n+OwxS9dzOxFD1pJVTBD+lwYNcHgT/FsyfRkes9ppuQ7kyRF3PxrUfsujyAb1vP13EvWvrVbKjlnJQBm1Hlh7OUZajxnYFVyAHqbR0xvtc9xvl33k9Sg1mbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso63691239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720684624; x=1721289424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9398RJINYcC+tCW2A411cep3yNYukxMzqadN+n1VPgg=;
        b=Ts8Pwq7KISCA5+q/gFN3y+RsdOoEanIjKnulRtLFqDndJcuvutbMqUFDg4tfsDK59a
         KF03sOA4mMr/RxMJc3gL6yGcgnASYdkjupnHnl5msimWXSwTFRlB+29Anpghf419VkK7
         ZJXPm/nUK4gGU7ijYIIJIiQjKTHpMijIBPI3RcpYNw6yqYwSSJkKvySdboXi0opO2mBc
         lqDpvzyy6TVWlmU0guzVNh7at657xVtxz0oC9Qa+Jk/iFxgYMLHdEFQ8e0ndIH1LIn2X
         bKCn9x0OvtL3VbDGdhSnJPq4k0OO0+kxvotqCDIWMiUecoJxJQPlmLZNVq5iyBKZMU4x
         X2JA==
X-Forwarded-Encrypted: i=1; AJvYcCUkb5YPInZP/E4AYRG9WL6Gl5NILecBnai3S8njD4WK7yWRTtU3zIUD6DSQsrRmCbZ400vy10iWWAyh35jysU3W0Uf1lSVIU5ScrMBQ
X-Gm-Message-State: AOJu0YzXn4Vl2HeN7Qu7QK3xfHoYFr7yYEgCH1p5x/6O2JWMjspiLJ7e
	zGaIEN4wwIsqRFA/hP8FHpnLbCrzqlToqvRcWTjLEZyregmpLeWboNjcoF9LABzDubjE+E+4gF1
	bi+8p+jFWVAp/fLCOD8p0nT+/aO7djNLZT1NyafO+izT8abJ+5SVoH1U=
X-Google-Smtp-Source: AGHT+IGWAJQLHt9DsvgXErnHEjDPjdQ1njoJj2hzadAq1rp0rpVA3U2AAtxvFjarhNRqJ6BRfCs2P6+BAjUOM9C2NUJoKDJg776z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2582:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4c0b29715f7mr460854173.1.1720684623822; Thu, 11 Jul 2024
 00:57:03 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:57:03 -0700
In-Reply-To: <7bc3c0f4-d611-4328-b456-a7d2ac0ff4b9@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c617c3061cf41b01@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in mi_enum_attr

==================================================================
BUG: KASAN: slab-out-of-bounds in mi_enum_attr+0x84b/0x9e0 fs/ntfs3/record.c:246
Read of size 4 at addr ffff888068a97345 by task syz-executor.4/9900

CPU: 1 PID: 9900 Comm: syz-executor.4 Not tainted 6.10.0-rc1-syzkaller-00042-gbde63e8eae5d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 mi_enum_attr+0x84b/0x9e0 fs/ntfs3/record.c:246
 mi_find_attr+0x1c5/0x2b0 fs/ntfs3/record.c:353
 ni_find_attr+0x390/0x8d0 fs/ntfs3/frecord.c:202
 ntfs_readlink_hlp+0xa5/0xc70 fs/ntfs3/inode.c:1960
 ntfs_get_link+0x79/0x110 fs/ntfs3/inode.c:2106
 pick_link+0x631/0xd50
 step_into+0xca9/0x1080 fs/namei.c:1874
 open_last_lookups fs/namei.c:3597 [inline]
 path_openat+0x18ef/0x3280 fs/namei.c:3804
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_open fs/open.c:1428 [inline]
 __se_sys_open fs/open.c:1424 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1424
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e9bc7cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e9c9930c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f5e9bdac050 RCX: 00007f5e9bc7cda9
RDX: 0000000000000065 RSI: 0000000000000080 RDI: 0000000020000440
RBP: 00007f5e9bcc947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f5e9bdac050 R15: 00007fff3591b788
 </TASK>

Allocated by task 9815:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2c0 mm/slub.c:4152
 kmalloc_noprof include/linux/slab.h:660 [inline]
 ntfs_get_link+0x63/0x110 fs/ntfs3/inode.c:2102
 pick_link+0x631/0xd50
 step_into+0xca9/0x1080 fs/namei.c:1874
 open_last_lookups fs/namei.c:3597 [inline]
 path_openat+0x18ef/0x3280 fs/namei.c:3804
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_open fs/open.c:1428 [inline]
 __se_sys_open fs/open.c:1424 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1424
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9815:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2195 [inline]
 slab_free mm/slub.c:4436 [inline]
 kfree+0x149/0x360 mm/slub.c:4557
 do_delayed_call include/linux/delayed_call.h:28 [inline]
 put_link fs/namei.c:1025 [inline]
 open_last_lookups fs/namei.c:3596 [inline]
 path_openat+0x180d/0x3280 fs/namei.c:3804
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_open fs/open.c:1428 [inline]
 __se_sys_open fs/open.c:1424 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1424
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888068a96000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 837 bytes to the right of
 allocated 4096-byte region [ffff888068a96000, ffff888068a97000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x68a90
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000040 ffff888014c42140 ffffea000087be00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
head: 00fff00000000040 ffff888014c42140 ffffea000087be00 dead000000000002
head: 0000000000000000 0000000000040004 00000001ffffefff 0000000000000000
head: 00fff00000000003 ffffea0001a2a401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5079, tgid 5079 (kworker/0:3), ts 179614011412, free_ts 179293511077
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
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:597
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:666
 alloc_skb include/linux/skbuff.h:1308 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x254/0xaa0 drivers/net/netdevsim/dev.c:850
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 6810 tgid 6808 stack trace:
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
 kmalloc_trace_noprof+0x132/0x2c0 mm/slub.c:4147
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 fnd_get fs/ntfs3/ntfs_fs.h:672 [inline]
 dir_search_u+0x16a/0x3a0 fs/ntfs3/dir.c:246
 ntfs_extend_init+0x27a/0x530 fs/ntfs3/fsntfs.c:250
 ntfs_fill_super+0x4213/0x4830 fs/ntfs3/super.c:1523
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff888068a97200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888068a97280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888068a97300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                           ^
 ffff888068a97380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888068a97400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         bde63e8e fs/ntfs3: Fix formatting, change comments, re..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9e87e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4430a9c6b8c7af4
dashboard link: https://syzkaller.appspot.com/bug?extid=a426cde6dee8c2884b0b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

