Return-Path: <linux-kernel+bounces-419120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CEF9D69B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ED0281AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA72770B;
	Sat, 23 Nov 2024 15:37:25 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212029CEB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376244; cv=none; b=h2S6c0m7KiUsJwQc7uEeWMSGXyiENZzw8ijVtl11XUjkscwvbXBmr4VtFHe9L6ETGoWEh2cYSlyPGPP++8blAWkuEh1Jhkre98E5RAdy6e186bynq+bpdU1y+/qFzKJlkgCQz1VLKRPScSYhMt93UxQbO0qCszPcoJHaF3SxiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376244; c=relaxed/simple;
	bh=SonEz2EwJYShaEWTHmNnqLpnU6KHKFRNwXGqBVN4Sso=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CmxKqMU2W4Ay5J3gt1NM6lG5q3iN5rMN48qRfMLWHTCKSqbdJ+Nv9AxXjYGV0Hce4S5y1/gGhZsvK1H+/rvhcaZ9GBXTKFOeuJX7igRzyRiE2A3q9Zfu5VD+9IrO8V2kl6q7OkwyzFpPZbL+0LyrtuEjKm61fby7KH5N+VMUzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so15486485ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 07:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732376242; x=1732981042;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obSpwyDm8AwoD2XphakRPwpULohLPo5Uwi0ZYLcZVlY=;
        b=WkujTwTmpokXyc06lKHTFoQ0hbAkmRiaAoHPsQHxRsFS8U5aK4pugirTe+693nw6BV
         ALIc14eQobOHhLhccqghC+8wW4aqLQoUSlJIJELaW7N9vXqc5Lb4ASU4feGFyTmgqV5M
         mPGxsHsI+1tBgp2Kvm7WNyRFS1+lk4GsgY8q/rJx9wyL5xJRqOX6KDx9aKFojQv/frRp
         SA6dWCjBvhByyZVdu9bzrnuoRbEX+g4WA0svrTunREQX+pL6DScN2gpxNn7sygnTCEpI
         zhnAyexq384moatjbAsRVKbsw5UzRQtvOzJLH0dRgxdT/Xt8BDBLScphbnk0s7pCT20b
         v/ng==
X-Forwarded-Encrypted: i=1; AJvYcCXn9vPd9XIOElt/DHhKZLf6X6HVEUnWks0697OwwwA1yDTGZN3KHhm5NG6JcpJ00XovFbtMBLeYpo6nVl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbs7nRBAiRZdwb2eEM3JHmCUvLy3afTeAkasoYypFAmtaJUBG
	wkHOehCMTJxE5d3oEHg/HJOHFUhmquYcalZpYoLZ79F0DMIdZ9xfRwtU8sTsqAElvhfUHR/mDHX
	XMGk13dgy9zCHqIVuiogDyFwJawkCDGxwuMwkG9ii2je5Ik7I0QqrjCE=
X-Google-Smtp-Source: AGHT+IFZbivOpCGggSOwqKsIeJ53K64XhfKjv8rhLQSrlUSNlj6JheaIeosqSo1Vvzv8R2ivQKj4k2iVmf+RvsB8KRfTo9oODMte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3a79ae1cdbcmr67925115ab.12.1732376242027; Sat, 23 Nov 2024
 07:37:22 -0800 (PST)
Date: Sat, 23 Nov 2024 07:37:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
From: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148bfec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b011a14ee4cb9480
dashboard link: https://syzkaller.appspot.com/bug?extid=5218c85078236fc46227
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aae0561fd279/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/faa3af3fa7ce/bzImage-06afb0f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5218c85078236fc46227@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-07834-g06afb0f36106 #0 Not tainted
------------------------------------------------------
kswapd0/112 is trying to acquire lock:
ffff88801f3f1438 (&q->q_usage_counter(io)#68){++++}-{0:0}, at: bio_queue_enter block/blk.h:79 [inline]
ffff88801f3f1438 (&q->q_usage_counter(io)#68){++++}-{0:0}, at: blk_mq_submit_bio+0x7ca/0x24c0 block/blk-mq.c:3092

but task is already holding lock:
ffffffff8df4de60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xcd9/0x18f0 mm/vmscan.c:6976

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4036 [inline]
       slab_alloc_node mm/slub.c:4114 [inline]
       __do_kmalloc_node mm/slub.c:4263 [inline]
       __kmalloc_node_noprof+0xb7/0x440 mm/slub.c:4270
       __kvmalloc_node_noprof+0xad/0x1a0 mm/util.c:658
       sbitmap_init_node+0x1ca/0x770 lib/sbitmap.c:132
       scsi_realloc_sdev_budget_map+0x2c7/0x610 drivers/scsi/scsi_scan.c:246
       scsi_add_lun+0x11b4/0x1fd0 drivers/scsi/scsi_scan.c:1106
       scsi_probe_and_add_lun+0x4fa/0xda0 drivers/scsi/scsi_scan.c:1287
       __scsi_add_device+0x24b/0x290 drivers/scsi/scsi_scan.c:1622
       ata_scsi_scan_host+0x215/0x780 drivers/ata/libata-scsi.c:4575
       async_run_entry_fn+0x9c/0x530 kernel/async.c:129
       process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->q_usage_counter(io)#68){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __bio_queue_enter+0x4c6/0x740 block/blk-core.c:361
       bio_queue_enter block/blk.h:79 [inline]
       blk_mq_submit_bio+0x7ca/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       swap_writepage_bdev_async mm/page_io.c:449 [inline]
       __swap_writepage+0x3a3/0xf50 mm/page_io.c:472
       swap_writepage+0x403/0x1040 mm/page_io.c:288
       pageout+0x3b2/0xaa0 mm/vmscan.c:689
       shrink_folio_list+0x3025/0x42d0 mm/vmscan.c:1367
       evict_folios+0x6d6/0x1970 mm/vmscan.c:4589
       try_to_shrink_lruvec+0x612/0x9b0 mm/vmscan.c:4784
       shrink_one+0x3e3/0x7b0 mm/vmscan.c:4822
       shrink_many mm/vmscan.c:4885 [inline]
       lru_gen_shrink_node mm/vmscan.c:4963 [inline]
       shrink_node+0xbbc/0x3ed0 mm/vmscan.c:5943
       kswapd_shrink_node mm/vmscan.c:6771 [inline]
       balance_pgdat+0xc1f/0x18f0 mm/vmscan.c:6963
       kswapd+0x5f8/0xc30 mm/vmscan.c:7232
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#68);
                               lock(fs_reclaim);
  rlock(&q->q_usage_counter(io)#68);

 *** DEADLOCK ***

1 lock held by kswapd0/112:
 #0: ffffffff8df4de60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xcd9/0x18f0 mm/vmscan.c:6976

stack backtrace:
CPU: 3 UID: 0 PID: 112 Comm: kswapd0 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x41c/0x610 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __bio_queue_enter+0x4c6/0x740 block/blk-core.c:361
 bio_queue_enter block/blk.h:79 [inline]
 blk_mq_submit_bio+0x7ca/0x24c0 block/blk-mq.c:3092
 __submit_bio+0x384/0x540 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
 submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
 swap_writepage_bdev_async mm/page_io.c:449 [inline]
 __swap_writepage+0x3a3/0xf50 mm/page_io.c:472
 swap_writepage+0x403/0x1040 mm/page_io.c:288
 pageout+0x3b2/0xaa0 mm/vmscan.c:689
 shrink_folio_list+0x3025/0x42d0 mm/vmscan.c:1367
 evict_folios+0x6d6/0x1970 mm/vmscan.c:4589
 try_to_shrink_lruvec+0x612/0x9b0 mm/vmscan.c:4784
 shrink_one+0x3e3/0x7b0 mm/vmscan.c:4822
 shrink_many mm/vmscan.c:4885 [inline]
 lru_gen_shrink_node mm/vmscan.c:4963 [inline]
 shrink_node+0xbbc/0x3ed0 mm/vmscan.c:5943
 kswapd_shrink_node mm/vmscan.c:6771 [inline]
 balance_pgdat+0xc1f/0x18f0 mm/vmscan.c:6963
 kswapd+0x5f8/0xc30 mm/vmscan.c:7232
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

