Return-Path: <linux-kernel+bounces-405130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595A49C4D46
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1552814EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69F208215;
	Tue, 12 Nov 2024 03:25:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6210206042
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381930; cv=none; b=lC1SYJXDF6YaAV/RSloknqYSpoDUxkDawGdueHXYcXDQnN+kwkLrxt67KknaCgfwodmpBI6odjxoYcPEm1KWvk08aobWxT3uQRnMJlU1Q/3kLv3zX5hw1LAI2w8x4Y0BQE5tTGMR/LRkrLJFe70aTvv3mgF3uXCgbLBxHO3bwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381930; c=relaxed/simple;
	bh=lUkdJpp5TH6A6i1Ulg3KpkXUL4O/IfMqX4lBtDFEBJE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZIF8bojVIdHoMXXbEAfP6c8ktK1BGa2foGiirr5GvtVtoeKihwrAJOH+hQnkxTzMEcLwTDhTB9nmo/ZFJoKic85O+/FGKv+6YAUtlM14cg8kCzSZrlF0aF1XuqmaTGWn6KKKcPq0l9GExTQ6ckL50tSVSe7BYVDi3y54TXp1KF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83e07db6451so412914939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731381928; x=1731986728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMd5sY2yfqDqwl6OHpm1Jbmr82qlOSSEBc7Jmb+HQzc=;
        b=NLBJy0Az/iuI0qvjJzFwe3/nDjD6JB5n5UM8IwEDV0b3q8E4A0XJC4wsYKD//OqslM
         X2pnYiNLKptjaG4SjGo650hGjOdXqmz+Xt6ERH92jbxTH24MIuevJS4VGO0G7FF7u0JB
         3HUmeyxZxwdnphDmf37z2pA8dHFyag0Pm1fU8WcdcZgHe0OXwiM2C5jM2uJxEC8kHnRY
         NtqKWtfjizhVxO+Xkl7mkotqOip7s2v7XOY5PS38zHAV6oeqoyHjqwOgkrsKnjA+I2XI
         tICxepMPLlM8WJsLgf5a3HPJcd7GFQGp1pOGgGFmQsDJ+Gt206ziUYp6kNFHtP3BRbVR
         +9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVA/8wdITiqWhZ4tyUh9SRSXXddrFOA9IPZ8J4pK+1a2IV+JTQS9hsxyBU9Hpn6y6zZYGfC+mD6gqXBdlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeJUQhNJ1ITArZlquAcT5WMs6WePuCMMWVIGbcUZ9nzj5LE/9
	1xXdY5NdL3bLaRnffccE4brIobS7WAC0yAp5kVQGpbPDWNS1mfW5K7yVzPBIddhUHaG7Sd4SeuK
	W6WfTLyCU6VvB9yGBilvZ0Px9Xab/HBZYPVkufL7AWPdMIY5JX+5MxYA=
X-Google-Smtp-Source: AGHT+IGijlIE8JMPbIvSr9JvUrlKFW21Wcm6P2os2XA2/+zVDS7gCpamb6W+rOpeH2WZNiUBCX+ud8ffgz3fvPy4pWAOCscLufjk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a6f19b1847mr167857175ab.7.1731381927942; Mon, 11 Nov 2024
 19:25:27 -0800 (PST)
Date: Mon, 11 Nov 2024 19:25:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732caa7.050a0220.138bd5.00ce.GAE@google.com>
Subject: [syzbot] [bcachefs?] possible deadlock in bch2_alloc_sectors_start_trans
From: syzbot <syzbot+d4b38c802ea425ccf857@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    74741a050b79 Add linux-next specific files for 20241107
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fd5d87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3ef0574c9dc8b00
dashboard link: https://syzkaller.appspot.com/bug?extid=d4b38c802ea425ccf857
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fd5d87980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bbbf40580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8993ea1d09da/disk-74741a05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dab7bc3c6e88/vmlinux-74741a05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fda543ad532f/bzImage-74741a05.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8f1af4532ebc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4b38c802ea425ccf857@syzkaller.appspotmail.com

  io_time[WRITE]    256
  fragmentation     0
  bp_start          8
  incorrectly set at freespace:0:27:0 (free 0, genbits 0 should be 0), fixing
============================================
WARNING: possible recursive locking detected
6.12.0-rc6-next-20241107-syzkaller #0 Not tainted
--------------------------------------------
kworker/1:2/58 is trying to acquire lock:
ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: bch2_trans_mutex_lock_norelock fs/bcachefs/alloc_foreground.c:43 [inline]
ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: writepoint_find fs/bcachefs/alloc_foreground.c:1249 [inline]
ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: bch2_alloc_sectors_start_trans+0x956/0x2030 fs/bcachefs/alloc_foreground.c:1355

but task is already holding lock:
ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: bch2_trans_mutex_lock_norelock fs/bcachefs/alloc_foreground.c:41 [inline]
ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: writepoint_find fs/bcachefs/alloc_foreground.c:1249 [inline]
ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: bch2_alloc_sectors_start_trans+0x2e8/0x2030 fs/bcachefs/alloc_foreground.c:1355

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&wp->lock);
  lock(&wp->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

7 locks held by kworker/1:2/58:
 #0: ffff88802070fd48 ((wq_completion)bcachefs_write_ref){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802070fd48 ((wq_completion)bcachefs_write_ref){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000133fd00 ((work_completion)(&ca->invalidate_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000133fd00 ((work_completion)(&ca->invalidate_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888078704750 (&wb->flushing.lock){+.+.}-{4:4}, at: bch2_btree_write_buffer_flush_nocheck_rw fs/bcachefs/btree_write_buffer.c:543 [inline]
 #2: ffff888078704750 (&wb->flushing.lock){+.+.}-{4:4}, at: bch2_btree_write_buffer_tryflush+0x14b/0x1c0 fs/bcachefs/btree_write_buffer.c:558
 #3: ffff8880787043a8 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:158 [inline]
 #3: ffff8880787043a8 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:255 [inline]
 #3: ffff8880787043a8 (&c->btree_trans_barrier){.+.+}-{0:0}, at: bch2_trans_srcu_lock+0x9a/0x1a0 fs/bcachefs/btree_iter.c:3195
 #4: ffff888078726710 (&c->gc_lock){++++}-{4:4}, at: bch2_btree_update_start+0x682/0x14e0 fs/bcachefs/btree_update_interior.c:1191
 #5: ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: bch2_trans_mutex_lock_norelock fs/bcachefs/alloc_foreground.c:41 [inline]
 #5: ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: writepoint_find fs/bcachefs/alloc_foreground.c:1249 [inline]
 #5: ffff88807871dc38 (&wp->lock){+.+.}-{4:4}, at: bch2_alloc_sectors_start_trans+0x2e8/0x2030 fs/bcachefs/alloc_foreground.c:1355
 #6: ffff888078726710 (&c->gc_lock){++++}-{4:4}, at: bch2_btree_update_start+0x682/0x14e0 fs/bcachefs/btree_update_interior.c:1191

stack backtrace:
CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.12.0-rc6-next-20241107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: bcachefs_write_ref bch2_do_invalidates_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 bch2_trans_mutex_lock_norelock fs/bcachefs/alloc_foreground.c:43 [inline]
 writepoint_find fs/bcachefs/alloc_foreground.c:1249 [inline]
 bch2_alloc_sectors_start_trans+0x956/0x2030 fs/bcachefs/alloc_foreground.c:1355
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:333 [inline]
 bch2_btree_reserve_get+0x612/0x1890 fs/bcachefs/btree_update_interior.c:543
 bch2_btree_update_start+0xe56/0x14e0 fs/bcachefs/btree_update_interior.c:1241
 bch2_btree_split_leaf+0x121/0x880 fs/bcachefs/btree_update_interior.c:1857
 bch2_trans_commit_error+0x212/0x1390 fs/bcachefs/btree_trans_commit.c:918
 __bch2_trans_commit+0x8069/0x9610 fs/bcachefs/btree_trans_commit.c:1099
 bch2_trans_commit fs/bcachefs/btree_update.h:182 [inline]
 bch2_check_discard_freespace_key+0xba7/0x1120 fs/bcachefs/alloc_background.c:1393
 try_alloc_bucket fs/bcachefs/alloc_foreground.c:287 [inline]
 bch2_bucket_alloc_freelist fs/bcachefs/alloc_foreground.c:463 [inline]
 bch2_bucket_alloc_trans+0x1526/0x31a0 fs/bcachefs/alloc_foreground.c:590
 bch2_bucket_alloc_set_trans+0x517/0xd30 fs/bcachefs/alloc_foreground.c:750
 __open_bucket_add_buckets+0x13d0/0x1ec0 fs/bcachefs/alloc_foreground.c:999
 open_bucket_add_buckets+0x33a/0x410 fs/bcachefs/alloc_foreground.c:1043
 bch2_alloc_sectors_start_trans+0xce9/0x2030
 __bch2_btree_node_alloc fs/bcachefs/btree_update_interior.c:333 [inline]
 bch2_btree_reserve_get+0x612/0x1890 fs/bcachefs/btree_update_interior.c:543
 bch2_btree_update_start+0xe56/0x14e0 fs/bcachefs/btree_update_interior.c:1241
 bch2_btree_split_leaf+0x121/0x880 fs/bcachefs/btree_update_interior.c:1857
 bch2_trans_commit_error+0x212/0x1390 fs/bcachefs/btree_trans_commit.c:918
 __bch2_trans_commit+0x8069/0x9610 fs/bcachefs/btree_trans_commit.c:1099
 wb_flush_one fs/bcachefs/btree_write_buffer.c:183 [inline]
 bch2_btree_write_buffer_flush_locked+0x2b23/0x5a40 fs/bcachefs/btree_write_buffer.c:375
 bch2_btree_write_buffer_flush_nocheck_rw fs/bcachefs/btree_write_buffer.c:544 [inline]
 bch2_btree_write_buffer_tryflush+0x16a/0x1c0 fs/bcachefs/btree_write_buffer.c:558
 bch2_do_invalidates_work+0x131/0x2400 fs/bcachefs/alloc_background.c:2078
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

