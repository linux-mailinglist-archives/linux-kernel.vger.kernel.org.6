Return-Path: <linux-kernel+bounces-445767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4156E9F1B52
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6B9188EAE7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2469763CB;
	Sat, 14 Dec 2024 00:31:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954C1FA4
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136265; cv=none; b=usKOLivENdENjI0mgi9qBR6W0cq5lstk5+dtb9cDGDXfzbihSb5uef5wfR8XErqRwHBST3S4Mbl+KA2jyh9n+Sl0y6kDtNrkl6Nd2cGRZYiGBAGmNzZD4RFlg7nzVYFXKLZwNsbkGVE0phF+E1nIah63ouWpeFFCJQteBEPulm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136265; c=relaxed/simple;
	bh=X5X3SECVMFe20fteTdc+RcLIGBHV/WXQ+Q0UrheHCGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ASix+wzLu07cZTbgT/n9lJX+/8J3Nqu9bMrBUkyQRVzweZm2dum1XsOsOrDPaNfpcxGMBlpOgrGbKlAys2xigEM80FMXVaiMZVv4MQPSShcN4RiigxxkrEwfCKajmCPq1zoWLKWj4lDfl2n9wyX4VH5v0FShFfMQvTWleVC9kBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a812f562bbso42714185ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734136263; x=1734741063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SB0CIoMJEsZNp0H79nYaDMtXZoDJtunsaNnlld5gzPM=;
        b=Jho4w3EmsYbVLhb53p1kTln60MV23hJpQpSz+FFqxy2UEcri6vmc02YbpA6QGfdApC
         ogeoLkaDj0B1c8dCr0MYmb9m7BqhbMTFSVQDI/0CtOH2ilFMnFqwu12xADICcGAYmD4I
         c1+orNMG9SW2IkPT70KW4KQCtXKd2EmYiUme+tu1MpOQpg9F24xScC1boshXfrTUHVri
         Le/NfhjuDujQE+CC/iWUUXpPaVB5cxC5IoWXAPGfFjYVylB9fPwtDhLmtGFNhQL0mtKW
         y4uIrzlFXullMsJMHdQcIYPY4iu+ErVxgCYMI7hskXBMC8m+csMOoTMQ+bjSELmaFZBW
         XHMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7xA6rfo5MZm5GNon4QJDFee2+R8t9UiNfasXCd84XmGELCAW3AXPrREdJYnV+ukoa3ijOhyXSNVhvN3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbwfXN+tz6rT8N+D4V4eU7w6TN1Ux/2F2jnW8e7jwBx5p1PLl
	RzXyZkHquH/oA5ibGzpNMK/Sa5+0XzH9Sk3+6HOsh/Sga3zdr3sn53a4XtEiB7FYP7lFhRdmobB
	ZJFvYpwJf07UuEpVBopagqEuqAfSq0XGktjeipm0X5UiLfQ/MoD5zkF8=
X-Google-Smtp-Source: AGHT+IHFNFAbzXkWfY1fsZr69FGbG17eacIOBHhEF5M8SUajLo7jnd1ys7cyEp+Q3gUYieh8coslA6VBQhkEtLnxRAFcP+DqgRMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:741:b0:3a7:e3e3:bd57 with SMTP id
 e9e14a558f8ab-3aff7f1646emr57276355ab.15.1734136262939; Fri, 13 Dec 2024
 16:31:02 -0800 (PST)
Date: Fri, 13 Dec 2024 16:31:02 -0800
In-Reply-To: <20241214001514.734-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675cd1c6.050a0220.37aaf.00ba.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __submit_bio

Adding 124996k swap on ./swap-file.  Priority:0 extents:1 across:124996k 
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00232-g4800575d8c0b-dirty #0 Not tainted
------------------------------------------------------
syz-executor/5695 is trying to acquire lock:
ffff888034c21438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_bio+0x2c6/0x560 block/blk-core.c:629

but task is already holding lock:
ffffffff8ea35ca0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3924 [inline]
ffffffff8ea35ca0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3949

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4070 [inline]
       slab_alloc_node mm/slub.c:4148 [inline]
       __do_kmalloc_node mm/slub.c:4297 [inline]
       __kmalloc_node_noprof+0xb2/0x4d0 mm/slub.c:4304
       __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
       sbitmap_init_node+0x2d4/0x670 lib/sbitmap.c:132
       scsi_realloc_sdev_budget_map+0x2a7/0x460 drivers/scsi/scsi_scan.c:246
       scsi_add_lun drivers/scsi/scsi_scan.c:1106 [inline]
       scsi_probe_and_add_lun+0x3173/0x4bd0 drivers/scsi/scsi_scan.c:1287
       __scsi_add_device+0x228/0x2f0 drivers/scsi/scsi_scan.c:1622
       ata_scsi_scan_host+0x236/0x740 drivers/ata/libata-scsi.c:4575
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->q_usage_counter(io)#37){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       swap_writepage_bdev_async mm/page_io.c:451 [inline]
       __swap_writepage+0x747/0x14d0 mm/page_io.c:474
       swap_writepage+0x6ee/0xce0 mm/page_io.c:289
       pageout mm/vmscan.c:689 [inline]
       shrink_folio_list+0x3b68/0x5ca0 mm/vmscan.c:1367
       evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
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
       folio_alloc_mpol_noprof mm/mempolicy.c:2287 [inline]
       vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2317
       folio_prealloc+0x2e/0x170
       alloc_anon_folio mm/memory.c:4752 [inline]
       do_anonymous_page mm/memory.c:4809 [inline]
       do_pte_missing mm/memory.c:3977 [inline]
       handle_pte_fault+0x2c98/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8b0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#37);
                               lock(fs_reclaim);
  rlock(&q->q_usage_counter(io)#37);

 *** DEADLOCK ***

2 locks held by syz-executor/5695:
 #0: ffff888011d6c8e0 (&vma->vm_lock->lock){++++}-{4:4}, at: vma_start_read include/linux/mm.h:716 [inline]
 #0: ffff888011d6c8e0 (&vma->vm_lock->lock){++++}-{4:4}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6278
 #1: ffffffff8ea35ca0 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3924 [inline]
 #1: ffffffff8ea35ca0 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3949

stack backtrace:
CPU: 0 UID: 0 PID: 5695 Comm: syz-executor Not tainted 6.13.0-rc2-syzkaller-00232-g4800575d8c0b-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 bio_queue_enter block/blk.h:75 [inline]
 blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3092
 __submit_bio+0x2c6/0x560 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
 swap_writepage_bdev_async mm/page_io.c:451 [inline]
 __swap_writepage+0x747/0x14d0 mm/page_io.c:474
 swap_writepage+0x6ee/0xce0 mm/page_io.c:289
 pageout mm/vmscan.c:689 [inline]
 shrink_folio_list+0x3b68/0x5ca0 mm/vmscan.c:1367
 evict_folios+0x3c86/0x5800 mm/vmscan.c:4593
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
 folio_alloc_mpol_noprof mm/mempolicy.c:2287 [inline]
 vma_alloc_folio_noprof+0x12e/0x230 mm/mempolicy.c:2317
 folio_prealloc+0x2e/0x170
 alloc_anon_folio mm/memory.c:4752 [inline]
 do_anonymous_page mm/memory.c:4809 [inline]
 do_pte_missing mm/memory.c:3977 [inline]
 handle_pte_fault+0x2c98/0x5ed0 mm/memory.c:5801
 __handle_mm_fault mm/memory.c:5944 [inline]
 handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8b0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fd75394f603
Code: 07 62 e1 7d 28 e7 4f 01 62 e1 7d 28 e7 57 02 62 e1 7d 28 e7 5f 03 62 e1 7d 28 e7 a7 00 10 00 00 62 e1 7d 28 e7 af 20 10 00 00 <62> e1 7d 28 e7 b7 40 10 00 00 62 e1 7d 28 e7 bf 60 10 00 00 48 83
RSP: 002b:00007fff07875f68 EFLAGS: 00010203
RAX: 00007fd74dca2aa8 RBX: 00007fff07876420 RCX: 0000000000000016
RDX: 00000000000014b0 RSI: 00007fd7520325c8 RDI: 00007fd74e170fc0
RBP: 0000000000000020 R08: ffffffffffffffe8 R09: 0000000000000000
R10: 0000000000000be6 R11: 000000000c000000 R12: 00007fd751b64010
R13: 0000000000000020 R14: 0000000000e4da98 R15: 0000000001c9b4c8
 </TASK>


Tested on:

commit:         4800575d Merge tag 'xfs-fixes-6.13-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13983be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1506a4f8580000


