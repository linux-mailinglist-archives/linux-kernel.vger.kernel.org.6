Return-Path: <linux-kernel+bounces-215672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F4E9095BC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99F61F21FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163FDCA6B;
	Sat, 15 Jun 2024 02:50:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248172907
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718419804; cv=none; b=jSn+mz0PYAaBU19zBN6b5KK4PKJyJYnyZJ3v03XahpOLweJ8LbunHrBplaIvURl6c+yUrE7qclnB6gMxHeq9m6kL3tYHUoNt1z2g5qjksWG1e3W5esRXmt3s47V8KbkrnzoW+wE7Pp8xjj463n7J03MZWOo+OLfklitHJiW3jJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718419804; c=relaxed/simple;
	bh=P2EQZuZdPWTdrWYHykKR4NfYCBDKQTxYY4+clcoYY2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JL8s8SZa1hdwnmOUOx+QV4exdNTLZn9xZCQJTUDWwdWdnkATagDwkK9fjlG2bNONWXVo0SoPxdw4Fbdtx15zqjm6C1thcj2gIT6vc0LqcnxX0njNittsHFocnT72jeiotWnC61rLmUIEyIhjFO9J9IjEN7NTgXXufl7l8MQGQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3759dc7d4f0so30395835ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718419802; x=1719024602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNw9wfQSptiDWAhn3Moo+ftk8PM2sS3g6P1Bgl6jRlY=;
        b=w/9pATFIwPgnNZvN8bBJVtbXvZrg4g8ur2jmL8RGcirUbUzRB4i+l0mhsFOEaGob3H
         o1E4oVr8Jt0SiCIQqMWocLCjvkXk4s6z+4Qc3G0lFn2w8FKmBdHfveCytUmzd3SRgtFG
         wvoJkmaT3qBMfAWbUoMGto6boz0o8JZhaDVQQtwjnVqpSPcN49tm/m64hhHdX8UyBaLE
         9qbQ1/5Lj8YbsnF/dL0tTZOKsb20rdjXySweRlIrJTGb3j0pl2mUkrWMNZCnAyKdAia7
         hI9RAwGKgAR5VxDD5A2sKNAKSiRshJgbelQI25J3lm6Oa+rBhOp0qF0CI+ppB25Iccwl
         QlVw==
X-Forwarded-Encrypted: i=1; AJvYcCWAlDbPHlGYHSponkuI0fjV07LfclquGd7pC2bUb3TFx4+Ej7VzQeKYVtKriY00CIzE9yD0Kp2LDC/oj4MCQpCyiiyWChJL1q/fuYQd
X-Gm-Message-State: AOJu0YxGQj2TxFQZDE/JF8SZ9LlX/sVrSX/eFUBcswGy5wlmiG2J+3wt
	mSkxcuV4IifA0Tu84EX3s/ibOtMgmyu75oKPECNffrvrVWH1LnjXQvIk2WKWfdFqJ08RHTHbjX0
	s3AThXsvQDV2jYqwW9QUI3QBZkp5S6gRc9u6DBdpOQJSpGlfgbN+JcNU=
X-Google-Smtp-Source: AGHT+IEoLiy+MvmtbGF+jtKy0xIKTVNAwA2uhIfwb5CwW6qREhU+eblMdC3BPnvR6g2aBIS5mA08FYKYT2I6CSDBZfhM1EQrn219
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:375:d682:bfe3 with SMTP id
 e9e14a558f8ab-375e1023db7mr2001225ab.6.1718419802105; Fri, 14 Jun 2024
 19:50:02 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:50:02 -0700
In-Reply-To: <tencent_8B769767163C3F3616964237F04BC074B109@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e13edb061ae4c956@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_read_write_early
From: syzbot <syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
turning off the locking correctness validator.
CPU: 2 PID: 5280 Comm: kworker/2:3 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: bcachefs_write_ref bch2_delete_dead_snapshots_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 add_chain_cache kernel/locking/lockdep.c:3735 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3816 [inline]
 validate_chain kernel/locking/lockdep.c:3837 [inline]
 __lock_acquire+0x2ea6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 do_write_seqcount_begin_nested include/linux/seqlock.h:469 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:495 [inline]
 psi_account_irqtime+0x2a3/0x510 kernel/sched/psi.c:1016
 update_rq_clock_task kernel/sched/core.c:726 [inline]
 update_rq_clock kernel/sched/core.c:770 [inline]
 update_rq_clock+0x250/0xb30 kernel/sched/core.c:751
 ttwu_queue kernel/sched/core.c:4056 [inline]
 try_to_wake_up+0x56a/0x13e0 kernel/sched/core.c:4378
 kick_pool+0x2a0/0x7a0 kernel/workqueue.c:1279
 __queue_work+0x94d/0x1020 kernel/workqueue.c:2360
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2410
 queue_work include/linux/workqueue.h:621 [inline]
 __bch2_btree_node_write+0x1fc1/0x2d60 fs/bcachefs/btree_io.c:2232
 bch2_btree_node_write+0x127/0x2f0 fs/bcachefs/btree_io.c:2307
 btree_split+0x1087/0x3010 fs/bcachefs/btree_update_interior.c:1706
 bch2_btree_split_leaf+0x108/0x770 fs/bcachefs/btree_update_interior.c:1857
 bch2_trans_commit_error+0x327/0xd00 fs/bcachefs/btree_trans_commit.c:918
 __bch2_trans_commit+0x4eb1/0x7ad0 fs/bcachefs/btree_trans_commit.c:1138
 bch2_trans_commit fs/bcachefs/btree_update.h:170 [inline]
 bch2_delete_dead_snapshots+0x1b22/0x4e70 fs/bcachefs/snapshot.c:1619
 bch2_delete_dead_snapshots_work+0x20/0x160 fs/bcachefs/snapshot.c:1692
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bcachefs (loop0): bch2_delete_dead_snapshots(): error deleting keys from dying snapshots erofs_trans_commit
bcachefs (loop0): bch2_delete_dead_snapshots(): error erofs_trans_commit
bcachefs (loop0): bch2_delete_dead_snapshots(): error deleting keys from dying snapshots erofs_trans_commit
bcachefs (loop0): bch2_delete_dead_snapshots(): error erofs_trans_commit
bcachefs (loop0): bch2_delete_dead_snapshots(): error deleting snapshot 4294967295 ENOENT_bkey_type_mismatch
bcachefs (loop0): bch2_delete_dead_snapshots(): error ENOENT_bkey_type_mismatch
bcachefs (loop0): bch2_delete_dead_snapshots(): error deleting snapshot 4294967295 ENOENT_bkey_type_mismatch
bcachefs (loop0): bch2_delete_dead_snapshots(): error ENOENT_bkey_type_mismatch


Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16e190b6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=4366624c0b5aac4906cf
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122fbb36980000


