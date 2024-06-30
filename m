Return-Path: <linux-kernel+bounces-235217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4791D1B4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3C2B21802
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAB513C819;
	Sun, 30 Jun 2024 13:03:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51C38DC0
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719752584; cv=none; b=Mr5OejyluLoMPg6GFTIdmtNH7w00oAEQIXKqJ73/OgqHkmS7xcZQ458GujmUlEOtz4+yI19ijwo94bwWNByWEBOymeZN+fKzDTZoyjE1zlBbvqPD9nAcsNjzZOMzPaP26c5Dlt6puis/MbfcNk7QusGg21oGdJO9zJMpwCwKZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719752584; c=relaxed/simple;
	bh=V5s8hhtu5pXmIlobg4E+rrkvrNNkmIHQAD5ro5hHMi4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iVkhLdI6D/Rm4+gkSLSxxrARwtVqZyaRiNqtxeQOBmv9N5xqCCmyD0jzISeXY7S2Q1zBKqxAyTva6zjnmwVYeDZ0uc9TwwdgWL+cHW9MzZdqLMG/xgG4kqyEmZVT/Xswu/g0p1z7tgU4uBhMGVwSjQ2pdjVqKJJ/RJvI9kJZsnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3ce244c92so236208339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 06:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719752582; x=1720357382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y568o1uciOktbORNl6/Fi8KzmVwazNZPKIA1hSX+k0o=;
        b=D/DKgtZQqHzEA1kwEVn95hUbjDtb299WribPdWmtFhGvjG+jmNuaTsMxPoSpWkkqvn
         vDRfoATIGbfFNuM1h2dHOi1Gko4K6ils1mgMBJ9eyNlrpnE+lBNRIYNDsGniufndXvv3
         RlIW6L4xfKEZNv/8ApjseH8kTSckYtDyUvRbfuF7HU+fU1WMCfLZjS22XUO4rIxRpQaS
         OSh2Cm4tG5SEGbNHZw6XMJomcSV6WG36Ur51Mq0ED5BSs0Subk3vyUp+NnBIl7k8+DFB
         /moVKSR4IWXzkQkpeEKxgQ2HQ7snGS2mQney3VFD+WL1ZzxSLVwR1VJ126qXdycusIDo
         IloA==
X-Forwarded-Encrypted: i=1; AJvYcCXm88vJwpTz2kjvYBO0yB65XTo2q3PqswNAlB1enRvtXjgs+hxd9cn51CFgAnhOG4AngsGGMzJipeaHVgCj7oEPW4SaVa1k1PuulBuu
X-Gm-Message-State: AOJu0YwCGjbOqJl59wHQYFx4UVRuvwblijYRN37V4rQsq6hDO20Xjjfn
	s12A/FE9zrNMkcu4oGk3HBSfZ1GLd6q82UxadDYQAHwOlM/MZG3dXp5SJ5sxLYNy6gpOJp/8+UY
	8DAwVUOjR+scAEm48Ezzyby4/hDrR6ns/s4AFr1Hj3wZMqhtFZt1s7y4=
X-Google-Smtp-Source: AGHT+IGrjztedZQaKue7DEwhjHUyrptZaYWrQ4GqYizAtfBHUSzBg9mmms+8S2tmfuBUxVisml6WBKP4FOqCeizLhlyTGboB98QZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc9:b0:7f3:d89c:6030 with SMTP id
 ca18e2360f4ac-7f62ee88d1dmr16556539f.4.1719752582496; Sun, 30 Jun 2024
 06:03:02 -0700 (PDT)
Date: Sun, 30 Jun 2024 06:03:02 -0700
In-Reply-To: <20240630123941.2689-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8214d061c1b195c@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in journal_quiesce
From: syzbot <syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __bch2_btree_path_make_mut

bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
============================================
WARNING: possible recursive locking detected
6.10.0-rc5-syzkaller-00282-g8282d5af7be8-dirty #0 Not tainted
--------------------------------------------
syz-executor/6090 is trying to acquire lock:
ffff88806719b070
 (b->c.lock){++++}-{0:0}, at: btree_path_copy fs/bcachefs/btree_iter.c:1228 [inline]
 (b->c.lock){++++}-{0:0}, at: btree_path_clone fs/bcachefs/btree_iter.c:1236 [inline]
 (b->c.lock){++++}-{0:0}, at: __bch2_btree_path_make_mut+0x1ec/0x570 fs/bcachefs/btree_iter.c:1249

but task is already holding lock:
ffff88806719d070 (b->c.lock){++++}-{0:0}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
ffff88806719d070 (b->c.lock){++++}-{0:0}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(b->c.lock);
  lock(b->c.lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor/6090:
 #0: ffff888065f80278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_start+0x45/0x5b0 fs/bcachefs/super.c:1005
 #1: ffff888065f842d8 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #1: ffff888065f842d8 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #1: ffff888065f842d8 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x840/0xce0 fs/bcachefs/btree_iter.c:3193
 #2: ffff88806719d070 (b->c.lock){++++}-{0:0}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #2: ffff88806719d070 (b->c.lock){++++}-{0:0}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #3: ffff88806a354c88 (b->c.lock){++++}-{0:0}, at: six_relock_type fs/bcachefs/six.h:289 [inline]
 #3: ffff88806a354c88 (b->c.lock){++++}-{0:0}, at: __bch2_btree_node_relock+0x142/0x9c0 fs/bcachefs/btree_locking.c:506
 #4: ffff88806719b070 (b->c.lock){++++}-{0:0}, at: six_trylock_type fs/bcachefs/six.h:207 [inline]
 #4: ffff88806719b070 (b->c.lock){++++}-{0:0}, at: btree_node_lock fs/bcachefs/btree_locking.h:266 [inline]
 #4: ffff88806719b070 (b->c.lock){++++}-{0:0}, at: btree_path_lock_root fs/bcachefs/btree_iter.c:757 [inline]
 #4: ffff88806719b070 (b->c.lock){++++}-{0:0}, at: bch2_btree_path_traverse_one+0xa44/0x2930 fs/bcachefs/btree_iter.c:1177

stack backtrace:
CPU: 1 PID: 6090 Comm: syz-executor Not tainted 6.10.0-rc5-syzkaller-00282-g8282d5af7be8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 six_lock_increment+0x3f/0x110 fs/bcachefs/six.c:717
 btree_path_copy fs/bcachefs/btree_iter.c:1228 [inline]
 btree_path_clone fs/bcachefs/btree_iter.c:1236 [inline]
 __bch2_btree_path_make_mut+0x1ec/0x570 fs/bcachefs/btree_iter.c:1249
 bch2_btree_path_make_mut fs/bcachefs/btree_iter.h:196 [inline]
 __bch2_btree_path_set_pos+0x382/0x1750 fs/bcachefs/btree_iter.c:1264
 bch2_btree_path_set_pos fs/bcachefs/btree_iter.h:211 [inline]
 bch2_btree_iter_peek_upto+0x5471/0x7090 fs/bcachefs/btree_iter.c:2377
 bch2_btree_iter_peek_slot+0xf01/0x26d0 fs/bcachefs/btree_iter.c:2643
 __bch2_bkey_get_iter fs/bcachefs/btree_iter.h:552 [inline]
 bch2_bkey_get_iter fs/bcachefs/btree_iter.h:566 [inline]
 bch2_bucket_do_index+0x685/0x10d0 fs/bcachefs/alloc_background.c:680
 bch2_trigger_alloc+0x206d/0x3e10 fs/bcachefs/alloc_background.c:785
 bch2_key_trigger fs/bcachefs/bkey_methods.h:88 [inline]
 bch2_key_trigger_new fs/bcachefs/bkey_methods.h:116 [inline]
 run_one_trans_trigger fs/bcachefs/btree_trans_commit.c:517 [inline]
 run_btree_triggers+0x86e/0x11d0 fs/bcachefs/btree_trans_commit.c:544
 bch2_trans_commit_run_triggers fs/bcachefs/btree_trans_commit.c:587 [inline]
 __bch2_trans_commit+0x574/0x88e0 fs/bcachefs/btree_trans_commit.c:1022
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_trans_mark_metadata_bucket+0x46f/0x1350 fs/bcachefs/buckets.c:1413
 bch2_trans_mark_metadata_sectors fs/bcachefs/buckets.c:1430 [inline]
 __bch2_trans_mark_dev_sb fs/bcachefs/buckets.c:1465 [inline]
 bch2_trans_mark_dev_sb+0x323/0x720 fs/bcachefs/buckets.c:1493
 bch2_trans_mark_dev_sbs_flags+0x6be/0x720 fs/bcachefs/buckets.c:1503
 bch2_run_recovery_pass+0xf2/0x1e0 fs/bcachefs/recovery_passes.c:182
 bch2_run_recovery_passes+0x19e/0x820 fs/bcachefs/recovery_passes.c:225
 bch2_fs_recovery+0x2386/0x3730 fs/bcachefs/recovery.c:813
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1035
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2132
 bch2_mount+0x6b0/0x13a0 fs/bcachefs/fs.c:1926
 legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
 vfs_get_tree+0x92/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3538a7e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f353978def8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f353978df80 RCX: 00007f3538a7e5ea
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007f353978df40
RBP: 0000000020005d80 R08: 00007f353978df80 R09: 0000000000000400
R10: 0000000000000400 R11: 0000000000000246 R12: 0000000020005dc0
R13: 00007f353978df40 R14: 0000000000005e05 R15: 0000000020005e00
 </TASK>
bcachefs (loop0): going read-write
bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): delete_dead_inodes... done
bcachefs (loop0): done starting filesystem
syz-executor (6090) used greatest stack depth: 16752 bytes left


Tested on:

commit:         8282d5af Merge tag 'nfs-for-6.10-3' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=152c24b9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e40800950091403a
dashboard link: https://syzkaller.appspot.com/bug?extid=1e1b380ef8d95b36f789
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cc24b9980000


