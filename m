Return-Path: <linux-kernel+bounces-446284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07E9F222A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBEC16615D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A559450;
	Sun, 15 Dec 2024 04:22:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFA8F5C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734236526; cv=none; b=Sv5ghPzi8YWWfru8MDj3pKh2StG3Mn3LTOEtslDXPvv9iCtM2vs1BnAJM59zd7y3s6iA9U3V7KpNArFzPtzT5e/qv/RO2phqI/Ubti0WYDzFdoJnVJD8jlSp9JWXDPuw00CzuTxsJt4vb+ob2JeXIYyG7OvD0VZAyEbFrec7GYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734236526; c=relaxed/simple;
	bh=qUbz/Ds8/G11NkoUN32WJYUFN251ZjG9S4c2go+o8NY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rmS4vB/8vNvMCtYHhRZCuvGVnMFvmP3xgg+PlRy9kQJ4rz9Mtb28EvkS5gkNe1Q33co56PiyUs86hdKY+CNT+0KxPH/Eq3h3lF0tQmIdjbuJcWFodTfQDjucBlw1Pu9rZbWgvLL4SU4JHr4MPUKgNXFeZeIM6HhI5GZnfIUVJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ac005db65eso30278355ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734236524; x=1734841324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWM8oV9NDnZxrtLK63/p+7WnKLuiFjy0nJtUMuVcqVQ=;
        b=tZ4b0ls4a09GiZpXsgSJtp5WyEL3jO+FwT/ftQrQkl5JIadvULoI56r5J2KiDr7Bsl
         qBg857VF7Se2+gqQ45GXnkpI8RflINotvHWAuQqR42VN88HVlEk3cU2OfZTLPBpN5aFP
         7FVIbbwiHnmBh23DZONfvY8AXShLiQkG8hqSqOd6rmMFzg17EiPNMca188bhEVVW4QDI
         fq33LiX2SvOXn7QX9Oa53N3hu4v3vbOXJSv7MRFVbz/BsTxP1IJnDP7Rb2YCNIadxCmg
         L15rqdpNnDE5Zk+Nd39Pn9opfT9ER9HJgJqMDxpi0Q5vF8d6v47LSUIgSy8hu5mnGeS0
         bCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNOuK6cLoTc8Es3t92VBcAVdQZyE2kum0pUH5lpeXzOaevrHH0t589Uun/vEzVN2ErVHb6X4IQHlr4x7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQfFMSxRoFI+ndzqIJ+bDUIwUZvh+NjY9dFXCWj4g5zeloQDif
	pA1ZRu04Fy9zxelvzS/ZTJKK3MJN5VjC15i1zH8Ho/KN5algjNt7k3T3+7uLJAIFReeC1buPBTG
	hlhf6tLplOov9mDSvKeWWDNMQtAXiWAM2v5HSufdPf3JnTL9oAnBom6U=
X-Google-Smtp-Source: AGHT+IFpH/FZr4MofNyWUaA5DfxIvOyEvqCMVOvQCg3zklFBveV8jqfZmVbaNQ+zB/YTo3SDAdV+TMypLac6bf5DTafUxoU5P7Fn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:3a8:1195:f216 with SMTP id
 e9e14a558f8ab-3aff7668d77mr83703795ab.10.1734236524159; Sat, 14 Dec 2024
 20:22:04 -0800 (PST)
Date: Sat, 14 Dec 2024 20:22:04 -0800
In-Reply-To: <tencent_F64B7A746D776B66F63C05363E97BE378809@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e596c.050a0220.37aaf.00ea.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
From: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __submit_bio

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00362-g2d8308bf5b67-dirty #0 Not tainted
------------------------------------------------------
kswapd0/77 is trying to acquire lock:
ffff88801a8a9438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_bio+0x2c6/0x560 block/blk-core.c:629

but task is already holding lock:
ffffffff8ea36de0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
ffffffff8ea36de0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vmscan.c:7246

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
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
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
       kswapd_shrink_node mm/vmscan.c:6785 [inline]
       balance_pgdat mm/vmscan.c:6977 [inline]
       kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#37);
                               lock(fs_reclaim);
  rlock(&q->q_usage_counter(io)#37);

 *** DEADLOCK ***

1 lock held by kswapd0/77:
 #0: ffffffff8ea36de0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
 #0: ffffffff8ea36de0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vmscan.c:7246

stack backtrace:
CPU: 0 UID: 0 PID: 77 Comm: kswapd0 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67-dirty #0
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
 blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
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
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         2d8308bf Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13173cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c73cdf980000


