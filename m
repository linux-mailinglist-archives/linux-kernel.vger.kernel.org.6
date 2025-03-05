Return-Path: <linux-kernel+bounces-546774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E95A4FE9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F299616727C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509124500E;
	Wed,  5 Mar 2025 12:28:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AC1EA7DB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177687; cv=none; b=GuKb4ApcWWcMtOZ9nuo9DHLOxtw0XQ6ds89yG3aLApR7svuVwLlMd/L6SrJDgee3iQUsf5Akq76BxL02H2msJ654zzjTZLbbfcb2WZFU53emkGaQsQKe2rpSzSQ8OkDQjzwIN8+6D27yyuKVUiVl7OAImgLEiy+csoQi7Yf0OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177687; c=relaxed/simple;
	bh=jZk8MGZBV9by22jDkCsWcFyLl/MK16Ld7W2ElhE4wi8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=boOC7PvUvFxWreIGcLgGYNP8JUb9AVuZfESXQw+zDH47z3DIbv6gF8ATMQnMNdUKn7YZRQZaBAowQO+hNgjEtUy9brEuKxPyyNbq9EX9yok/0By6i4UeRSk27FEQZA0hbSgmKyLpIzeErUg0PmC9oG18AbgG5ln4kyauWKmeHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so138120395ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741177685; x=1741782485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6koDBoW28PWNeZJuqfk38qPIg4pXsDkjQP2IfP4J+Nc=;
        b=q6LXvglHvkfJuyu4y1g/3+RcwyoCgqzBDfjXNR5SwCKY1zzCKkzEL6/R610MZBc/4w
         SvAyz0Uo/SqLpxPQSAOdvwN39Iw6qUs3lfGcJEOlQBpbCgD6CW9CdtRIvVkrRqZ4Vu3R
         CfNnXZDek+AbQYObCKYqO20+5+u3FmjmIXzazW20QVsmeBXJbGqUCVVUwlcWea333jhb
         mPXl5BIuR4ZeqUTcqi72W3ywzJemNQ8+1b3xSLA70Dkt9A1+GSkbenTO1+nIGJCXiElj
         uVzbJ/d1XsvznEnDV99zZ+AF+VGkSApp1ZWkXG/gQ/bDpM0P0kRD94kpY7AsbNRRGQ7K
         huEA==
X-Forwarded-Encrypted: i=1; AJvYcCWTXuUxBsdbzIc8Z7KqhXdPG4intHDtH+3sNT3m4xm0doDwpkwfGbY42HMJUkeUy8+gw4SYfhpK5mjTWXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELMD/E3oio+57gVyOwjIR13ml7B5OWC2lzGiDzOIRYEx0VzE8
	e1/VSYLYCI0/04HMXAKH6VKsyezeM97v6MaDq92SHF9LYKViDUg7gjenaONdtbxJNm8JvpT+0EG
	VPwS5vRdJAh0pCjR8S/p3+NBjb8vrLBMmVAtagKSSbDlGVcl2MfzdA6g=
X-Google-Smtp-Source: AGHT+IHNJ6SGl9e3gUse967a8nA8vNXYXdeyzO6rS+LbF7mOaYiJp7/dg64i804TXjahjpJriKBtR4ojHY3BJo8OtAa9tjAjK2iV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:118e:b0:3d4:28f7:3383 with SMTP id
 e9e14a558f8ab-3d42b95ff8amr27222005ab.16.1741177684752; Wed, 05 Mar 2025
 04:28:04 -0800 (PST)
Date: Wed, 05 Mar 2025 04:28:04 -0800
In-Reply-To: <tencent_7BFC4CBAA7D1C6F652C1C660898EEEF5EE06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c84354.050a0220.38b91b.037e.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in xlog_cksum

hlen: 64512, bufsize: 65536, xlog_valid_rec_header
hlen: 64512, bufsize: 65536, xlog_valid_rec_header
xheads: 2, size: 64512, xlog_cksum
==================================================================
BUG: KASAN: slab-out-of-bounds in crc32c_le_arch+0xc7/0x1b0 arch/x86/lib/crc32-glue.c:81
Read of size 8 at addr ffff88804899fa00 by task syz.0.16/5851

CPU: 0 UID: 0 PID: 5851 Comm: syz.0.16 Not tainted 6.14.0-rc5-syzkaller-g48a5eed9ad58-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 crc32c_le_arch+0xc7/0x1b0 arch/x86/lib/crc32-glue.c:81
 __crc32c_le include/linux/crc32.h:36 [inline]
 crc32c include/linux/crc32c.h:9 [inline]
 xlog_cksum+0xcb/0x130 fs/xfs/xfs_log.c:1589
 xlog_recover_process+0x78/0x1e0 fs/xfs/xfs_log_recover.c:2900
 xlog_do_recovery_pass+0xa01/0xdc0 fs/xfs/xfs_log_recover.c:3236
 xlog_verify_head+0x21f/0x5a0 fs/xfs/xfs_log_recover.c:1058
 xlog_find_tail+0xa04/0xdf0 fs/xfs/xfs_log_recover.c:1315
 xlog_recover+0xe1/0x540 fs/xfs/xfs_log_recover.c:3420
 xfs_log_mount+0x252/0x3e0 fs/xfs/xfs_log.c:666
 xfs_mountfs+0xfbb/0x2500 fs/xfs/xfs_mount.c:878
 xfs_fs_fill_super+0x1223/0x1550 fs/xfs/xfs_super.c:1817
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c0bb8e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c0ca1fe68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f5c0ca1fef0 RCX: 00007f5c0bb8e90a
RDX: 0000400000000500 RSI: 0000400000000200 RDI: 00007f5c0ca1feb0
RBP: 0000400000000500 R08: 00007f5c0ca1fef0 R09: 0000000002218a5d
R10: 0000000002218a5d R11: 0000000000000246 R12: 0000400000000200
R13: 00007f5c0ca1feb0 R14: 0000000000009706 R15: 0000400000000100
 </TASK>

Allocated by task 5851:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_noprof+0x290/0x4d0 mm/slub.c:4300
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:662
 xlog_do_recovery_pass+0x143/0xdc0 fs/xfs/xfs_log_recover.c:3017
 xlog_verify_head+0x21f/0x5a0 fs/xfs/xfs_log_recover.c:1058
 xlog_find_tail+0xa04/0xdf0 fs/xfs/xfs_log_recover.c:1315
 xlog_recover+0xe1/0x540 fs/xfs/xfs_log_recover.c:3420
 xfs_log_mount+0x252/0x3e0 fs/xfs/xfs_log.c:666
 xfs_mountfs+0xfbb/0x2500 fs/xfs/xfs_mount.c:878
 xfs_fs_fill_super+0x1223/0x1550 fs/xfs/xfs_super.c:1817
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88804899f800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes to the right of
 allocated 512-byte region [ffff88804899f800, ffff88804899fa00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4899e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffea0001226781 ffffffffffffffff 0000000000000000
head: 0000000700000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5614, tgid 5614 (syz-executor), ts 129766503794, free_ts 128754914187
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4739
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_noprof+0x2e6/0x4c0 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ops_init+0x76/0x5b0 net/core/net_namespace.c:128
 setup_net+0x287/0x9e0 net/core/net_namespace.c:362
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:516
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x57d/0xa70 kernel/fork.c:3342
 __do_sys_unshare kernel/fork.c:3413 [inline]
 __se_sys_unshare kernel/fork.c:3411 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3411
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
page last free pid 5603 tgid 5603 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xe40/0x18b0 mm/page_alloc.c:2707
 folios_put_refs+0x76c/0x860 mm/swap.c:994
 free_pages_and_swap_cache+0x2e5/0x690 mm/swap_state.c:331
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:389 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:396
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:488
 vms_clear_ptes+0x432/0x530 mm/vma.c:1144
 vms_complete_munmap_vmas+0x210/0x8f0 mm/vma.c:1186
 do_vmi_align_munmap+0x5ef/0x6f0 mm/vma.c:1445
 do_vmi_munmap+0x24e/0x2d0 mm/vma.c:1493
 __vm_munmap+0x372/0x510 mm/vma.c:2951
 __do_sys_munmap mm/mmap.c:1084 [inline]
 __se_sys_munmap mm/mmap.c:1081 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:1081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804899f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88804899f980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88804899fa00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88804899fa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804899fb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         48a5eed9 Merge tag 'devicetree-fixes-for-6.14-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d2fc64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2040405600e83619
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f938b7980000


