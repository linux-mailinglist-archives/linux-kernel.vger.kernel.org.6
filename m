Return-Path: <linux-kernel+bounces-415400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43379D358F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FF52831D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CB170A1A;
	Wed, 20 Nov 2024 08:35:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221214F9FF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091706; cv=none; b=MhARH/DVlcBXplG+IvcP8IBX/BxHvuTBIbG787pVQISY+advngnMS6e7JvV2hTkbpuC0Sqg1ETXHPPODpGwLJ/G9XpDfXXWU7zx7uWimWyqIsXVT+3a0PH1Jlkq/xDpuhY0cVZspVDoDuUAPFVfoQci/g3jBRsbI9YhH9l3Te0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091706; c=relaxed/simple;
	bh=3IGwuafPa6q8g/rVrT0KXoocKPdvMgIoDk3UU4FK3+U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HKDat8FVmSQjTxraEBD07M9cD5Gr1kZCKrKoHr8xgqn+hC6/EZPsBFYBvn8bb3NqFGFLgg9elQw+PiCzI9FiDVSRQB2nuTGr4l5TMJ2WuraeqnSEXLjXLs1EhBZ9I6W6KqD4Xk+FoPr0e9obc4yxYRre+g8oopTDpy8uwi27T48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a76ee0008cso26445745ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732091703; x=1732696503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyZ61evC9Ww1W/axh0vxf/AJCeqXK8/DCmJY8g6pFTc=;
        b=g2Q2liJLQYNMCip1JY433OIUxcy/lvg3Z9UqALUNIZHaFEvn7nQhdghJ97IxnPvQEp
         KvBxZ2l69tQCKa2UEPuxKd6giczzVoSY2c+bW8/9C0w8SrbOomwTybNiE97uWGpWGyaE
         4y6i7y+HSyTV92JQP7aZPEdDDiewK+A3WE9WcXRCxI52VSyYYo3fVHCTmYoQ1FiuIaZl
         WHrCAbwHPkop54mapMAFXcTMZkBuI3i/J37S/eL1JUW9xEzqX1f9BzPTAhQkRDjPD6WE
         HcVu0pWyJQUfPLqtSKDW05oWPb7kB+/wOhJzOWOWcw5Oy8cpRO145CZ3VbXfwunFs3Cz
         Wdyw==
X-Forwarded-Encrypted: i=1; AJvYcCViOXqIIWfLugkzvgMRFZZrO6Ou9dGgnKr1psbLDNsN2XgF/WHS3f7TUDskiq4qJOH3w7ZL5eKiF4Yv6+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSg6o6Kaau+vGdJAQ6suYYRaO4miD4+QAKm3qptDi+Ysd87G8
	ddgsvAsMF7Hg+DcOg47qwRUWqIOkBhjFLFHhre66TYpWc2qjfBVQrWkXIzLwD3vJVa9j/+NQB6D
	kex45ZEx5EC+SqCJz3im6BJV8FtM2v9WgAkB0CuBog8LSkZxMgT25xGI=
X-Google-Smtp-Source: AGHT+IEQcEsak4u3yNx1FiTf8FwimiuCkLgnnB/JxNJXY+yY0o9qoNMHmvLdbtkP5MIiCo+uEgft4tJolqafGTMEgWE2s7MElrSx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3a7:21ad:72a9 with SMTP id
 e9e14a558f8ab-3a7865a4b9emr18498395ab.17.1732091703780; Wed, 20 Nov 2024
 00:35:03 -0800 (PST)
Date: Wed, 20 Nov 2024 00:35:03 -0800
In-Reply-To: <20241120081457.R0Qrp%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673d9f37.050a0220.3c9d61.015e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_reserve_suballoc_bits
From: syzbot <syzbot+fd05de09d1267725aa95@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __submit_bio

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-01782-gbf9aa14fc523-dirty #0 Not tainted
------------------------------------------------------
kswapd0/74 is trying to acquire lock:
ffff888000cf9438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_bio+0x2c6/0x560 block/blk-core.c:629

but task is already holding lock:
ffffffff8ea3bfe0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6850 [inline]
ffffffff8ea3bfe0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7232

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4036 [inline]
       slab_alloc_node mm/slub.c:4114 [inline]
       __do_kmalloc_node mm/slub.c:4263 [inline]
       __kmalloc_node_noprof+0xb0/0x440 mm/slub.c:4270
       __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
       sbitmap_init_node+0x2d4/0x670 lib/sbitmap.c:132
       scsi_realloc_sdev_budget_map+0x2a7/0x460 drivers/scsi/scsi_scan.c:246
       scsi_add_lun drivers/scsi/scsi_scan.c:1106 [inline]
       scsi_probe_and_add_lun+0x3173/0x4bd0 drivers/scsi/scsi_scan.c:1287
       __scsi_add_device+0x228/0x2f0 drivers/scsi/scsi_scan.c:1622
       ata_scsi_scan_host+0x236/0x740 drivers/ata/libata-scsi.c:4575
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
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
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       swap_writepage_bdev_async mm/page_io.c:449 [inline]
       __swap_writepage+0x5fc/0x1400 mm/page_io.c:472
       swap_writepage+0x85d/0xfa0 mm/page_io.c:288
       pageout mm/vmscan.c:689 [inline]
       shrink_folio_list+0x3c0e/0x8cc0 mm/vmscan.c:1367
       evict_folios+0x549b/0x7b50 mm/vmscan.c:4589
       try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4784
       shrink_one+0x3b9/0x850 mm/vmscan.c:4822
       shrink_many mm/vmscan.c:4885 [inline]
       lru_gen_shrink_node mm/vmscan.c:4963 [inline]
       shrink_node+0x3789/0x3e10 mm/vmscan.c:5943
       kswapd_shrink_node mm/vmscan.c:6771 [inline]
       balance_pgdat mm/vmscan.c:6963 [inline]
       kswapd+0x1ca9/0x3700 mm/vmscan.c:7232
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

1 lock held by kswapd0/74:
 #0: ffffffff8ea3bfe0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6850 [inline]
 #0: ffffffff8ea3bfe0 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x3700 mm/vmscan.c:7232

stack backtrace:
CPU: 0 UID: 0 PID: 74 Comm: kswapd0 Not tainted 6.12.0-syzkaller-01782-gbf9aa14fc523-dirty #0
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
 blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
 __submit_bio+0x2c6/0x560 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
 swap_writepage_bdev_async mm/page_io.c:449 [inline]
 __swap_writepage+0x5fc/0x1400 mm/page_io.c:472
 swap_writepage+0x85d/0xfa0 mm/page_io.c:288
 pageout mm/vmscan.c:689 [inline]
 shrink_folio_list+0x3c0e/0x8cc0 mm/vmscan.c:1367
 evict_folios+0x549b/0x7b50 mm/vmscan.c:4589
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4784
 shrink_one+0x3b9/0x850 mm/vmscan.c:4822
 shrink_many mm/vmscan.c:4885 [inline]
 lru_gen_shrink_node mm/vmscan.c:4963 [inline]
 shrink_node+0x3789/0x3e10 mm/vmscan.c:5943
 kswapd_shrink_node mm/vmscan.c:6771 [inline]
 balance_pgdat mm/vmscan.c:6963 [inline]
 kswapd+0x1ca9/0x3700 mm/vmscan.c:7232
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         bf9aa14f Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17184b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48190c1cdf985419
dashboard link: https://syzkaller.appspot.com/bug?extid=fd05de09d1267725aa95
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153646c0580000


