Return-Path: <linux-kernel+bounces-320352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0130970936
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366A51F21AEA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D9176AC2;
	Sun,  8 Sep 2024 18:23:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C354C8D7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725819807; cv=none; b=eEfcbrrSFXS/MFby7u0cuuFIY6wC7bFrM7QOo7D6nqrrpW6mKCEZCQWiCB/IG1j3g+Lu30awbnPPwSZfKOKmj0xzBBBr9xxBDoFeY9fVvHDhJvppToarszFhRgalV4dwzIlZvnYuPMmymsgOUX/fBC7rPMwAC6ILjfAjQQY+Sd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725819807; c=relaxed/simple;
	bh=euHH7VsYxjU/vcS5M7JzUqCedgMz0fCZ0uGPB9lHHio=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tbUbo7ef8Ea4An0ynEZrCJrlchFEPvB0Zzp4XLwRUfTGFMv2LJdkt/zINKC6kac5UJ06C8x2SlhPvCkrUL8B5hhFEXtAOh8HU1RoIG31YBsyLJZTSdm5qcIZRDcVg6uSJWNAQxOnLv7E7QDxlgO3+6LZ/u701yjzMb9X4v/W0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04eef8ed2so39255395ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 11:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725819805; x=1726424605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZPw7tIWwf0H3OYgiP5TFsicJ2KuzAYNHAjYiOWso3Q=;
        b=c46T2Y/odRc0P4rrO4geXg/6QjfZRS4Sgns8Lg4u1uvfTH8ovAWkHPqNfSp6xZHp9x
         mvHP7gUydMiPqMTi7422anUReF5syr9VcfKzTLkiajhodRxQpof0NCiKTR5lf6hrMWVH
         F2T8ouqJyqzkgwsb0RsuzoPOX6MH73tVYv+lL/SXRMLdZ/G89DlDaIQH2pR42FwTJvNQ
         PDH61gTkLE9Uy5YhO/+3bqD1hmQPwryltV0pD+C98gjyYXjj+qh5RVj7VouuQQZl3PQA
         WhEmoSFw7KivC0ELn5CEEbUPoyx5UVsfT53/QGd+jlH4B34vKQj0MPdl+UuO67PzKy9D
         N55A==
X-Forwarded-Encrypted: i=1; AJvYcCV9wzedjvIgT23Cxp39IdcS71XWom1vps+TO4FeCJBpjDfPTxIbVEWfAZQc5x05501UfGS4rElTLtU+IQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4n2T9aZqr2zFInzJY2RI98R/9ZuMwE5BxIlTRqEE1r3I0wt3
	h6d3idSbtqCJNARQFoKOoFaNXigeLMtGlh3nJD47yZ3n1T8O2LvhO7mOcMEgAyTmZK01GTByS3t
	rM2cTZKJ5/vvBNf7SR8AutVDPRHJ6a+ckdbc6IZ7mIsmQa+JmeZs6FLU=
X-Google-Smtp-Source: AGHT+IG68HYtwotNN5yQI/UfEYj3F2nmtt9BMCIlGgXsqKPj9lwrg7Hzv6VK5RDWrCTJyOtJ1CISSFt5+Ub19ok3HSHI6wBbiMIh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:39d:2939:3076 with SMTP id
 e9e14a558f8ab-3a04f0ec140mr106608065ab.25.1725819804692; Sun, 08 Sep 2024
 11:23:24 -0700 (PDT)
Date: Sun, 08 Sep 2024 11:23:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067c20b06219fbc26@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault (2)
From: syzbot <syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88fac17500f4 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13291d97980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=2dab93857ee95f2eeb08
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6dfa1c637f53/disk-88fac175.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a322b491698/vmlinux-88fac175.xz
kernel image: https://storage.googleapis.com/syzbot-assets/edc9184a3a97/bzImage-88fac175.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2dab93857ee95f2eeb08@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __vma_shareable_lock include/linux/hugetlb.h:1278 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_no_page mm/hugetlb.c:6380 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_fault+0xfaf/0x3770 mm/hugetlb.c:6485
Read of size 8 at addr ffff88807c17f9d0 by task syz.0.4558/26998

CPU: 1 UID: 0 PID: 26998 Comm: syz.0.4558 Not tainted 6.11.0-rc6-syzkaller-00026-g88fac17500f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __vma_shareable_lock include/linux/hugetlb.h:1278 [inline]
 hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
 hugetlb_no_page mm/hugetlb.c:6380 [inline]
 hugetlb_fault+0xfaf/0x3770 mm/hugetlb.c:6485
 handle_mm_fault+0x1901/0x1bc0 mm/memory.c:5830
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f2b63744998
Code: fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5 fa 7f 4c 17 f0 c3 66 0f 1f 84 00 00 00 00 00 48 8b 4c 16 f8 48 8b 36 <48> 89 37 48 89 4c 17 f8 c3 c5 fe 6f 54 16 e0 c5 fe 6f 5c 16 c0 c5
RSP: 002b:00007f2b63a5fb88 EFLAGS: 00010206
RAX: 00000000200002c0 RBX: 0000000000000004 RCX: 00676e7277682f76
RDX: 000000000000000b RSI: 7277682f7665642f RDI: 00000000200002c0
RBP: 00007f2b63937a80 R08: 00007f2b63600000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000009 R12: 000000000014aa5e
R13: 00007f2b63a5fc90 R14: 0000000000000032 R15: fffffffffffffffe
 </TASK>

Allocated by task 27000:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:471
 mmap_region+0xc3d/0x2090 mm/mmap.c:2944
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 26255:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __fib6_clean_all+0x327/0x4b0 net/ipv6/ip6_fib.c:2277
 rt6_sync_down_dev net/ipv6/route.c:4908 [inline]
 rt6_disable_ip+0x164/0x7e0 net/ipv6/route.c:4913
 addrconf_ifdown+0x15d/0x1bd0 net/ipv6/addrconf.c:3856
 addrconf_notify+0x3cb/0x1020
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_close_many+0x33c/0x4c0 net/core/dev.c:1587
 unregister_netdevice_many_notify+0x50b/0x1c40 net/core/dev.c:11327
 unregister_netdevice_many net/core/dev.c:11414 [inline]
 default_device_exit_batch+0xa0f/0xa90 net/core/dev.c:11897
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 remove_vma mm/mmap.c:189 [inline]
 remove_mt mm/mmap.c:2415 [inline]
 do_vmi_align_munmap+0x155c/0x18c0 mm/mmap.c:2758
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2830
 mmap_region+0x72f/0x2090 mm/mmap.c:2881
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807c17f9b0
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff88807c17f9b0, ffff88807c17fa68)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7c17f
memcg:ffff888028997401
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801bafdb40 ffffea0001f89e00 000000000000000d
raw: 0000000000000000 0000000000100010 00000001fdffffff ffff888028997401
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 26741, tgid 26741 (dhcpcd-run-hook), ts 1341391347767, free_ts 1341166373745
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
 vm_area_dup+0x27/0x290 kernel/fork.c:486
 dup_mmap kernel/fork.c:695 [inline]
 dup_mm kernel/fork.c:1672 [inline]
 copy_mm+0xc7b/0x1f30 kernel/fork.c:1721
 copy_process+0x187a/0x3dc0 kernel/fork.c:2374
 kernel_clone+0x226/0x8f0 kernel/fork.c:2781
 __do_sys_clone kernel/fork.c:2924 [inline]
 __se_sys_clone kernel/fork.c:2908 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 26730 tgid 26718 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 __folio_put+0x2c8/0x440 mm/swap.c:128
 migrate_folio_move mm/migrate.c:1330 [inline]
 migrate_pages_batch+0x2a76/0x3560 mm/migrate.c:1818
 migrate_pages_sync mm/migrate.c:1884 [inline]
 migrate_pages+0x1f59/0x3460 mm/migrate.c:1993
 do_mbind mm/mempolicy.c:1388 [inline]
 kernel_mbind mm/mempolicy.c:1531 [inline]
 __do_sys_mbind mm/mempolicy.c:1605 [inline]
 __se_sys_mbind+0x1490/0x19f0 mm/mempolicy.c:1601
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807c17f880: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
 ffff88807c17f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>ffff88807c17f980: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff88807c17fa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff88807c17fa80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
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

