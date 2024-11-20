Return-Path: <linux-kernel+bounces-415656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A799D3968
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0070F28338C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB69319E7E2;
	Wed, 20 Nov 2024 11:22:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCACB4C74
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101727; cv=none; b=g8FK7gGHcg5y2abBQs3qKNj+wurncu5F4W69zzrsg7iG4lJfu1Ac2HTSgPVTV0neAuUbfCJPbY6OwnDbZaPzcIabClSooZ5gYSD0EYjAv02jZVxeX8JR2i58EgvhIPnNi3GygUwrGM5O/WsWi41xLgUCcIKWk4C7hEBPsTTD6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101727; c=relaxed/simple;
	bh=VISTetJpXXqTHILSjRmTqozgbrqf5iFVDOgHgS+uLLE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rOKis3EBXzdUKrYCI1WEnGqQbf3UHYnfiMkPku4nqcpN2M6mHcKL2EJQGz29MHGKVB+KF+ntuC03KAHDKOU56Ns7sYCBwh7K3idw/Pi2iAOmz4JK2Bl/ek9YWe6bl2rldJ8jhw2ra8jmxRmPVxEFobCQWCwgQa78uoEuXdUeUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78353a0fbso9717175ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101723; x=1732706523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N4LKdB11NVbXhxuIHwVWKp7Tmg1zu0yvJtdQo7ebqw=;
        b=UIjRmWGJeDkprOYuSQwdSRSUMW9f5KOPrt0yU2F+iMSW4FBpmgIZfbFXdUbFc65IZ+
         tqkDzaGV/gDGPXd0Vr3sfWuBWIdGvgfFlfJAs1miKdlv1rUXhoL8VddKwULsZX8Qzxhl
         38Qv1fCzxO8nGod2+THHLu+aEYjkGyjOJ/UH4P5oUvEDPCjc8bm6UKhyHSaoQtcHfAAb
         OSHQqzO73B7Mi3xSRRKNV3Sav1SXGRxkz04NwiMr4QBe/gqgAHkkg4/zcsN3FHcO1NqU
         /n3Xecf1UypSiUoX4iN5A3tBtK5memIQb+YXjHPVH+VPEZarZXxJ3Qrz7TXbJ7LquCqu
         E9TA==
X-Forwarded-Encrypted: i=1; AJvYcCXp2CchGRLecXCNnRBomMZ5j3TlY/0QMDCcLwXxyNnSp9d6mId3JM0QlP0fn/2rzz4XLNzRVfOoaUhFVBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFW7A5SEAW2vo52n6HbDfU5JJeV68PVMteoI/d1RiQlmEekbLK
	DsEdLyaGWYZcjaxeTfaRkOEqkxWaEKFrjHcHtpe6xUecQSa8zdqevxw37lZHUY3pF368QQOz9lO
	XAmocW1fs0SDS84XaCVrUlO2p8pdAwUGph6E9ovytehw3UYbLfHEdRkc=
X-Google-Smtp-Source: AGHT+IGjpQGtFYzMxkRfmFGqZXdo+iJmPoMgt0nijs+ms3+D0TGeS4CBdByh4rfuHhRP9nlBfl0AXz6dv/5D97q9TmaylZakwu/C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:3a7:6dde:c78b with SMTP id
 e9e14a558f8ab-3a78642ead8mr26853935ab.8.1732101723064; Wed, 20 Nov 2024
 03:22:03 -0800 (PST)
Date: Wed, 20 Nov 2024 03:22:03 -0800
In-Reply-To: <20241120110635.1225-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673dc65b.050a0220.363a1b.000d.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page state in iomap_write_begin
From: syzbot <syzbot+c317c107c68f8bc257d9@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad page state in iomap_write_begin

BUG: Bad page state in process syz-executor  pfn:54c01
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x54c01
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001530001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001530001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5835, tgid 5834 (syz.0.15), ts 123151942771, free_ts 117023005490
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 79 tgid 79 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 shrink_folio_list+0x2d3d/0x8cc0 mm/vmscan.c:1483
 evict_folios+0x549b/0x7b50 mm/vmscan.c:4589
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4784
 shrink_one+0x3b9/0x850 mm/vmscan.c:4822
 shrink_many mm/vmscan.c:4885 [inline]
 lru_gen_shrink_node mm/vmscan.c:4963 [inline]
 shrink_node+0x3791/0x3e20 mm/vmscan.c:5943
 kswapd_shrink_node mm/vmscan.c:6771 [inline]
 balance_pgdat mm/vmscan.c:6963 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7232
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x277/0x4a0
 free_pages_prepare mm/page_alloc.c:1084 [inline]
 free_unref_page+0x7b2/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001df4b R15: 00007ffe39c14620
 </TASK>
BUG: Bad page state in process syz-executor  pfn:54c00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x54c00
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5835, tgid 5834 (syz.0.15), ts 123151942771, free_ts 117002020712
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 79 tgid 79 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 shrink_folio_list+0x2d3d/0x8cc0 mm/vmscan.c:1483
 evict_folios+0x549b/0x7b50 mm/vmscan.c:4589
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4784
 shrink_one+0x3b9/0x850 mm/vmscan.c:4822
 shrink_many mm/vmscan.c:4885 [inline]
 lru_gen_shrink_node mm/vmscan.c:4963 [inline]
 shrink_node+0x3791/0x3e20 mm/vmscan.c:5943
 kswapd_shrink_node mm/vmscan.c:6771 [inline]
 balance_pgdat mm/vmscan.c:6963 [inline]
 kswapd+0x1ca3/0x3700 mm/vmscan.c:7232
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001df4b R15: 00007ffe39c14620
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor  pfn:50201
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x50201
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001408001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001408001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5846, tgid 5845 (syz.0.16), ts 123994600994, free_ts 123747208525
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x277/0x4a0
 free_pages_prepare mm/page_alloc.c:1084 [inline]
 free_unref_page+0x7b2/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001e320 R15: 00007ffe39c14620
 </TASK>
BUG: Bad page state in process syz-executor  pfn:50200
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x50200
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5846, tgid 5845 (syz.0.16), ts 123994600994, free_ts 123747208525
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001e320 R15: 00007ffe39c14620
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor  pfn:4aa01
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x4aa01
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00012a8001 ffffffffffffffff ffffffff00000000
raw: 0000000700000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea00012a8001 ffffffffffffffff ffffffff00000000
head: 0000000700000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5856, tgid 5855 (syz.0.17), ts 124740804218, free_ts 124519993940
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x277/0x4a0
 free_pages_prepare mm/page_alloc.c:1084 [inline]
 free_unref_page+0x7b2/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001e612 R15: 00007ffe39c14620
 </TASK>
BUG: Bad page state in process syz-executor  pfn:4aa00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4aa00
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000700000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5856, tgid 5855 (syz.0.17), ts 124740804218, free_ts 124519993940
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001e612 R15: 00007ffe39c14620
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor  pfn:4a601
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x4a601
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001298001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001298001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5866, tgid 5865 (syz.0.18), ts 125496541014, free_ts 125257934266
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x277/0x4a0
 free_pages_prepare mm/page_alloc.c:1084 [inline]
 free_unref_page+0x7b2/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001e8fe R15: 00007ffe39c14620
 </TASK>
BUG: Bad page state in process syz-executor  pfn:4a600
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4a600
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5866, tgid 5865 (syz.0.18), ts 125496541014, free_ts 125257934266
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001e8fe R15: 00007ffe39c14620
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor  pfn:57a01
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x57a01
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea00015e8001 ffffffffffffffff ffffffff00000000
raw: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea00015e8001 ffffffffffffffff ffffffff00000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5876, tgid 5875 (syz.0.19), ts 126241083065, free_ts 126012308444
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x277/0x4a0
 free_pages_prepare mm/page_alloc.c:1084 [inline]
 free_unref_page+0x7b2/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001ebea R15: 00007ffe39c14620
 </TASK>
BUG: Bad page state in process syz-executor  pfn:57a00
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x57a00
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000000000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5876, tgid 5875 (syz.0.19), ts 126241083065, free_ts 126012308444
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001ebea R15: 00007ffe39c14620
 </TASK>
XFS (loop0): Unmounting Filesystem 9f1cad42-11bd-4e12-8f0b-f07876b81d9a
BUG: Bad page state in process syz-executor  pfn:58401
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x58401
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:-1
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 ffffea0001610001 ffffffffffffffff ffffffff00000000
raw: 0000000700000200 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 ffffea0001610001 ffffffffffffffff ffffffff00000000
head: 0000000700000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: nonzero pincount
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5886, tgid 5885 (syz.0.20), ts 127010154149, free_ts 126783942765
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_tail_page_prepare+0x277/0x4a0
 free_pages_prepare mm/page_alloc.c:1084 [inline]
 free_unref_page+0x7b2/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451fb7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe39c134a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f451fb7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe39c13560
RBP: 00007ffe39c13560 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe39c145e0
R13: 00007f451fbf15fc R14: 000000000001eee8 R15: 00007ffe39c14620
 </TASK>
BUG: Bad page state in process syz-executor  pfn:58400
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x58400
head: order:0 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff0000000004d(locked|referenced|uptodate|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff0000000004d dead000000000100 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
head: 04fff00000000000 0000000000000000 ffffffffffffffff 0000000000000000
head: 0000000700000200 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
page_owner tracks the page as allocated
page last allocated via order 9, migratetype Movable, gfp_mask 0x153c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_WRITE), pid 5886, tgid 5885 (syz.0.20), ts 127010154149, free_ts 126783942765
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x303f/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_pages_noprof mm/mempolicy.c:2345 [inline]
 folio_alloc_noprof+0x128/0x180 mm/mempolicy.c:2352
 filemap_alloc_folio_noprof+0xdf/0x500 mm/filemap.c:1010
 __filemap_get_folio+0x446/0xbd0 mm/filemap.c:1952
 iomap_get_folio fs/iomap/buffered-io.c:608 [inline]
 __iomap_get_folio fs/iomap/buffered-io.c:754 [inline]
 iomap_write_begin+0x52a/0x16f0 fs/iomap/buffered-io.c:797
 iomap_write_iter fs/iomap/buffered-io.c:955 [inline]
 iomap_file_buffered_write+0x68f/0xe50 fs/iomap/buffered-io.c:1039
 xfs_file_buffered_write+0x2de/0xac0 fs/xfs/xfs_file.c:792
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5793 tgid 5793 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_folios+0xf12/0x18d0 mm/page_alloc.c:2686
 folios_put_refs+0x76c/0x860 mm/swap.c:1007
 folio_batch_release include/linux/pagevec.h:101 [inline]
 truncate_inode_pages_range+0x47b/0xfc0 mm/truncate.c:346
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
Modules linked in:
CPU: 0 UID: 0 PID: 5793 Comm: syz-executor Tainted: G    B              6.12.0-rc6-syzkaller #0
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 bad_page+0x176/0x1d0 mm/page_alloc.c:501
 free_page_is_bad mm/page_alloc.c:918 [inline]
 free_pages_prepare mm/page_alloc.c:1100 [inline]
 free_unref_page+0xed0/0xf20 mm/page_alloc.c:2638
 __folio_put+0x2c7/0x440 mm/swap.c:126
 delete_from_page_cache_batch+0xaed/0xc70 mm/filemap.c:351
 truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:343
 evict+0x4fd/0x9b0 fs/inode.c:727
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 xfs_kill_sb+0x15/0x50 fs/xfs/xfs_super.c:2056
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit

Tested on:

commit:         59b723cd Linux 6.12-rc6
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.12-rc6
console output: https://syzkaller.appspot.com/x/log.txt?x=14234ae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11254d3590b16717
dashboard link: https://syzkaller.appspot.com/bug?extid=c317c107c68f8bc257d9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

