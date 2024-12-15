Return-Path: <linux-kernel+bounces-446638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FF29F2763
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E10A41884726
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9901C07C1;
	Sun, 15 Dec 2024 23:15:25 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0F1EEF9
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304524; cv=none; b=si4qHOXQkR7BROmyPYiM7pCCVv1zBhTqhV0Yr3HLXM2HhngxI6EnZmKdZFzca7fCRmP+lTk3/oVeiwfROmTgDN1fGtQy5yYJ1/IBPFZaNVqMmXuTfakP6/UF1JDv92Mlv1wlOKarktstTIOqibNwu8siRsrkovhh6NCFifxHjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304524; c=relaxed/simple;
	bh=0hAGO9XlV6OltAEuSKaDGlVY5xO5wOwUPxjStk1rMC0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ifk69fLQChHr2cppm0VWzBxPzARdIOJygfSrfk0qC4yMh2tW/2E96gsHmyu9aF+n6hAaR/7wTDTjOqFGap+LrAhrmkdsgbwTNIpda1mcX0sdXhk9s7vJYAsHJydfrsljB1+PJIbgZYnxi0UGOECbeTxSr4JgrPknM0CpaT6smQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so35553825ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 15:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734304522; x=1734909322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOQLhOOGdsJYbMmuWHjEMu9VIr99Csg+H/X758JUv2k=;
        b=VzzYi1zcs+SN1mEryWvLMyhfmqGzAr65LVuNwxOIa1x8J8UAIQyZ+RnoHAehQGkJ16
         f2OIpwViQsn/SjaXVsKpuPpfrQAZPrQrRqYbg/vSN95sPw8xO9a480AlsSiEZyQF8HdL
         0kYvJdgqi4jZg6xLeQp79fdzHhLXXg3xVVuWcGYclZCYsUGgC0txSpHaFzz1409ORFHp
         PTRaV1Q3KGqtpavTp5VH4Yfv4FtjLQ4R1iqN1GEel7xLErdnGaTyH5WYk4gFlD0L5i3M
         OUE3/tqTFJImPQv8mddblERxQWyx1hEj1Nmjl8vi69TlGZptkhLXaZuQZVDqOpzhPUS7
         M1jg==
X-Forwarded-Encrypted: i=1; AJvYcCU10uu/oYR+B6z1j9se5ORXkgWGsqnxgbRrMBtu0FQYuWnB+AnOV8TPG6pABHOwvg+1Qkn2us7Oe/cXFQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy1hW2QCg8puR2jToPZ+S3Mg/JC1zruEpAckgFCFNRoijAHUhC
	Vit9i1urJfMRvVTp5R9y6RO6hohAakxts7/VwFhgLN4MMgu9/r9DWauXdk8PxE/4pgt4FIuo9Zd
	hBNIP8fVpMpCZGMHI5lkK3WjxZYDMnV3QvUA1G7svwOUDwQwwDo+VmoE=
X-Google-Smtp-Source: AGHT+IEnp+E3aByUZIVyNpLbFelOd08s9TfRmninnA1Hmuqsb8FHhosnYr5KUY95+HtmdQgJ4egnOJWX4LAVzv8QzeW6Kx7+kGzh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:3a7:e286:a56b with SMTP id
 e9e14a558f8ab-3aff6213bf9mr114578445ab.5.1734304521846; Sun, 15 Dec 2024
 15:15:21 -0800 (PST)
Date: Sun, 15 Dec 2024 15:15:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675f6309.050a0220.37aaf.0109.GAE@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Write in dtSplitPage
From: syzbot <syzbot+a939a1121380d3212940@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f87d0916ce0 Merge tag 'trace-ringbuffer-v6.12-rc3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb2c40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=a939a1121380d3212940
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f487443bc3bb/disk-2f87d091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5cebceae528/vmlinux-2f87d091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9c1ca67e7e7/bzImage-2f87d091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a939a1121380d3212940@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in dtMoveEntry fs/jfs/jfs_dtree.c:3906 [inline]
BUG: KASAN: slab-use-after-free in dtSplitPage+0x1f91/0x3ed0 fs/jfs/jfs_dtree.c:1560
Write of size 1 at addr ffff888028e40000 by task syz.3.88/6200

CPU: 1 UID: 0 PID: 6200 Comm: syz.3.88 Not tainted 6.12.0-rc3-syzkaller-00044-g2f87d0916ce0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 dtMoveEntry fs/jfs/jfs_dtree.c:3906 [inline]
 dtSplitPage+0x1f91/0x3ed0 fs/jfs/jfs_dtree.c:1560
 dtSplitUp fs/jfs/jfs_dtree.c:1091 [inline]
 dtInsert+0x14bd/0x6c10 fs/jfs/jfs_dtree.c:870
 jfs_rename+0xafe/0x1bf0 fs/jfs/namei.c:1225
 vfs_rename+0xbdb/0xf00 fs/namei.c:5013
 do_renameat2+0xd94/0x13f0 fs/namei.c:5170
 __do_sys_rename fs/namei.c:5217 [inline]
 __se_sys_rename fs/namei.c:5215 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5215
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1bb7d7dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1bb8b06038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f1bb7f36718 RCX: 00007f1bb7d7dff9
RDX: 0000000000000000 RSI: 0000000020000f40 RDI: 00000000200003c0
RBP: 00007f1bb7df0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f1bb7f36718 R15: 00007fff68bcba88
 </TASK>

Allocated by task 6145:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 mt_alloc_one lib/maple_tree.c:162 [inline]
 mas_alloc_nodes+0x26c/0x840 lib/maple_tree.c:1241
 mas_node_count_gfp lib/maple_tree.c:1321 [inline]
 mas_preallocate+0x554/0x8c0 lib/maple_tree.c:5546
 vma_iter_prealloc mm/vma.h:432 [inline]
 mmap_region+0x1ea1/0x2990 mm/mmap.c:1508
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 elf_map fs/binfmt_elf.c:385 [inline]
 elf_load+0x25d/0x6f0 fs/binfmt_elf.c:408
 load_elf_interp+0x440/0xac0 fs/binfmt_elf.c:675
 load_elf_binary+0x1a44/0x2710 fs/binfmt_elf.c:1235
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xaf8/0x1770 fs/exec.c:1845
 kernel_execve+0x931/0xa50 fs/exec.c:2012
 call_usermodehelper_exec_async+0x237/0x380 kernel/umh.c:110
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 12:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4681
 rcu_do_batch kernel/rcu/tree.c:2567 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 batadv_nc_purge_paths+0x312/0x3b0 net/batman-adv/network-coding.c:471
 batadv_nc_worker+0x365/0x610 net/batman-adv/network-coding.c:722
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3086 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3190
 mas_wr_node_store lib/maple_tree.c:3857 [inline]
 mas_wr_store_entry+0x151d/0x2380 lib/maple_tree.c:4078
 mas_store_prealloc+0xcbb/0x1390 lib/maple_tree.c:5520
 mmap_region+0x207d/0x2990 mm/mmap.c:1513
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 elf_map fs/binfmt_elf.c:385 [inline]
 elf_load+0x25d/0x6f0 fs/binfmt_elf.c:408
 load_elf_interp+0x440/0xac0 fs/binfmt_elf.c:675
 load_elf_binary+0x1a44/0x2710 fs/binfmt_elf.c:1235
 search_binary_handler fs/exec.c:1752 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xaf8/0x1770 fs/exec.c:1845
 kernel_execve+0x931/0xa50 fs/exec.c:2012
 call_usermodehelper_exec_async+0x237/0x380 kernel/umh.c:110
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888028e40000
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes inside of
 freed 256-byte region [ffff888028e40000, ffff888028e40100)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28e40
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac91000 ffffea0000c4a480 dead000000000005
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac91000 ffffea0000c4a480 dead000000000005
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000001 ffffea0000a39001 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4793, tgid 4793 (v4l_id), ts 23023016752, free_ts 22863733486
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3039/0x3180 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 mt_alloc_one lib/maple_tree.c:162 [inline]
 mas_alloc_nodes+0x26c/0x840 lib/maple_tree.c:1241
 mas_node_count_gfp lib/maple_tree.c:1321 [inline]
 mas_preallocate+0x554/0x8c0 lib/maple_tree.c:5546
 vma_iter_prealloc mm/vma.h:432 [inline]
 __split_vma+0x302/0xc50 mm/vma.c:397
 split_vma mm/vma.c:460 [inline]
 vma_modify+0x153a/0x1a80 mm/vma.c:1433
 vma_modify_flags+0x3a9/0x420 mm/vma.c:1451
 mprotect_fixup+0x45a/0xaa0 mm/mprotect.c:664
 do_mprotect_pkey+0x8e0/0xd80 mm/mprotect.c:838
page last free pid 4790 tgid 4790 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcd0/0xf00 mm/page_alloc.c:2638
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1409
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_openat fs/open.c:1446 [inline]
 __se_sys_openat fs/open.c:1441 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888028e3ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888028e3ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888028e40000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888028e40080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028e40100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

