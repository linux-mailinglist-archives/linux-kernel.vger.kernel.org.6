Return-Path: <linux-kernel+bounces-176364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8824A8C2EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 03:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3F0B2307D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE412E6D;
	Sat, 11 May 2024 01:52:27 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB211CAB
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715392346; cv=none; b=puL12NkNuaf/8Nr+cD+/QEen1psi0qLQk2ZN8mBIk71V7rxRD7PHmVezas2uPw5K+y3wvmBTOaUe8ToWft/b4UJ8V6M8RuKLwfWWv/jnG/zJ5XVYvtL4t/U15XisjUXt5m1lCAf4g6/C2rhmm7oca4lIUL7belHYOBXRwsasuY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715392346; c=relaxed/simple;
	bh=lky441gRqnab9ceyulYBWvBXQDv3c4QCkH0Jp8RFi5o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e423mZvWBi9Be/l7KXiQmb0pU/mFG5E+ra5/N0lLf97U68+0uteV/kp/P9CqF08f2RApg6/rdTh9dp5RSYRQ591ip7qsjtE90vy1icXCm8adnEESR21pgqmOpxseJvRRIcPiZwsrJQ3cMmKwT1+Hw8paHjSnAzlbIitNbDuZ88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1bfe84f60so98946239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715392344; x=1715997144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQPND+OIiMCHluCJPwYEZvItQCo4uSR/8VsuyGgRsTI=;
        b=xAZ1/9UU/rracsCy0BpzT9lJF0MYK0gD51886G8twvXFDR+LlFKbUv1grWFJyNYTMV
         Q4Gg/PzRv5dzn0Y8YBqFKsWvagrpIWg23BfOIsFzgkTSStjd50vgO+Euig/1+eeSGptD
         Jfjz7Au0kYryDWrXm15DiF/08UcfXEYJQ9/02KaR4c52fmDU7ZWH8sgDSFVUfvQAl5+d
         b68hGweDB+SD/zApVGATJ68ahthlfbERwHH0UL/vViBpdqBcoBC8AkI3t+wwp9pa1ykq
         Th4pSIzdAIqZ5XAQCxpT7Kk1t/1i0REUgTkan+nsmqozCltnpKmRW4R76fgcwTgqgncd
         E37A==
X-Forwarded-Encrypted: i=1; AJvYcCUtuHcMblyjX1VGANLsd/tkq29E08ChDywrFzNz+wgElohXdJxiklB8OrVz+vHg2j6dyOxHw2H8zHG3aArGDDjFWiX7fe6EKg0waCPJ
X-Gm-Message-State: AOJu0YxJCXlGnqjZTQwv+zm9ymDInnbK0W/1kIxrgU1gqfyaXyIvjoYf
	HaRxE63grcjiVxEQCJwDmorggX4MyMxocfNE8s1mcwN7ZREwr7smjIeuaSkLBmstQhQDeXPF8nR
	BK04b8tDwaTQbwbIzxxVI6oS3o9Y3fLJJH990249JuFEmO3xw3kHwvSY=
X-Google-Smtp-Source: AGHT+IEgNZyRonW5lUamE23LltRK9KIHSbhDOgGGtfglxhPfvpOZoxC96FxhoiX9bZ9dPoMwkHXmbzCeT/IzRQZEIXTrIjcfn9Mn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29cd:b0:7de:e10b:859f with SMTP id
 ca18e2360f4ac-7e1b519d499mr18413939f.1.1715392344263; Fri, 10 May 2024
 18:52:24 -0700 (PDT)
Date: Fri, 10 May 2024 18:52:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054a3d3061823e781@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __bch2_increment_clock
From: syzbot <syzbot+e2edd0ba80d9b4a3ae8b@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ee5b455b0ada Merge tag 'slab-for-6.9-rc7-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=177a6698980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=e2edd0ba80d9b4a3ae8b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-ee5b455b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96e27f6a83fe/vmlinux-ee5b455b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49d89ce985f7/bzImage-ee5b455b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2edd0ba80d9b4a3ae8b@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 3 PID: 10086 at kernel/locking/lockdep.c:4643 mark_lock+0x590/0xc60 kernel/locking/lockdep.c:4643
Modules linked in:
CPU: 3 PID: 10086 Comm: kworker/3:2H Not tainted 6.9.0-rc7-syzkaller-00008-gee5b455b0ada #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: bcachefs_copygc bch2_write_point_do_index_updates
RIP: 0010:mark_lock+0x590/0xc60 kernel/locking/lockdep.c:4643
Code: 4c 89 ea 48 89 d9 4c 89 e7 e8 4c d5 ff ff 31 d2 e9 6b fb ff ff 90 48 c7 c6 40 b2 0c 8b 48 c7 c7 e0 ac 0c 8b e8 91 93 e4 ff 90 <0f> 0b 90 90 e9 5f fc ff ff e8 b2 67 ff ff ba 01 00 00 00 e9 3e fb
RSP: 0018:ffffc90003f56e00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81503039
RDX: ffff88804dc72440 RSI: ffffffff81503046 RDI: 0000000000000001
RBP: ffffc90003f56f40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff88804de28000
R13: ffffc90003d378b0 R14: 000000004dc72440 R15: 1ffff920007eadc6
FS:  0000000000000000(0000) GS:ffff88806b500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2df66000 CR3: 00000000427cc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __bch2_increment_clock+0x3b8/0x4a0 fs/bcachefs/clock.c:152
 bch2_increment_clock fs/bcachefs/clock.h:19 [inline]
 bch2_btree_node_alloc+0xce3/0xed0 fs/bcachefs/btree_update_interior.c:426
 bch2_btree_node_alloc_replacement+0xbb/0xd20 fs/bcachefs/btree_update_interior.c:447
 btree_split+0x1459/0x2b00 fs/bcachefs/btree_update_interior.c:1661
 bch2_btree_split_leaf+0x10c/0x6b0 fs/bcachefs/btree_update_interior.c:1856
 bch2_trans_commit_error+0x327/0xd00 fs/bcachefs/btree_trans_commit.c:896
 __bch2_trans_commit+0x3055/0x7880 fs/bcachefs/btree_trans_commit.c:1112
 bch2_trans_commit fs/bcachefs/btree_update.h:168 [inline]
 __bch2_data_update_index_update+0x3405/0x3cf0 fs/bcachefs/data_update.c:292
 bch2_data_update_index_update+0x5a/0x90 fs/bcachefs/data_update.c:338
 __bch2_write_index+0x17d/0xa60 fs/bcachefs/io_write.c:521
 bch2_write_point_do_index_updates+0x250/0x630 fs/bcachefs/io_write.c:629
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
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

