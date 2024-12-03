Return-Path: <linux-kernel+bounces-429676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF49E1FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CB116760B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278BD1F7063;
	Tue,  3 Dec 2024 14:40:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C641F6692
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236830; cv=none; b=VRcukIA56B3f6hDMoSqaK2t4MXR2gIa5+b5FZadiVZ8ZMs7lq8j5eL9pbxFftZtrSUR5LEmuenzGGoPCFQTOPFSCE2qal7odRk45lqPRNYCKLGEqoY42A4Yjai+96QSypuo5fp8rlVEabc5vwZ2yiO/la6sPOcO/srga0uPAO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236830; c=relaxed/simple;
	bh=xnZIPtFgulb7ZmC7MRw/l7zrErAuPTxpjo7bVnr+NIE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pD9usMgD6+vg4v2M4R+cSaPcWNp0a/pZD1cmslWUBMPXj/SopNCwgqORjRzWcIWlYSJ0JWgdFuYGKwMBFqag9xCVOO6Uu+173535NCEni2trMy8wpja4rf3ehy2MYWMDECZ27Swweu5GwbIWZycZ/XPkQCx3/kuPTp3q8MuIET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8418f68672eso475707239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236828; x=1733841628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+UJUOlZeSFS4ejT0gYOMuHI+JYM5aJ8as82cOBhLZU=;
        b=gq0YZAh+yY9g7KL0txKrw8JWfIVl5Qx4H/RJ4D51BU9fKy4Yr47aU2CHXloNIFj+yu
         jif3cLghtbZhViRZBbJIvg4cphXHAoMGDTO9YooxxFTkiPYdIEQIILIJtpu5ni6K+mU9
         JMAotQE/aqwW6JAxgPO93lZZh4fsKAyG2iliBzNdcpH1HXlcDD3sT7qKNpUFsuwh/1JT
         Gx0xAZZNtLXijkX9nV1VUN4qJ4uyfYaU5RQhl1WCljoMTS/i+jtr4jkZ95WjnF1NF2Jp
         cDER8BkdcG1oQ/Zww+TiOr3CTGQg/p98FSuIcKyl5jxkWSOoYNDy46Am14EnR1cUvr0I
         fdug==
X-Forwarded-Encrypted: i=1; AJvYcCWzUvR+GkptXXPmz68jLb+lukbGtPeRLWEuD2CFwpUzp3r61w/BFsowcXLgUJ+HSVQQ0JrWonNdyI16iNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQlCwNuNiTwZlUCMEtVD6ul0QH0ha8KkmOG2ZxXrwTe9dDMkq
	n1IP+rfFt35KQ5nKwOhppYeYykRODHDg5AP/hPkahMwHpkL6OR0j1bNZpFkCMo131K9Viijo8K5
	yIKEt90mHnzwqSJZnHO5ONc3cTYHHEfx8cMZtEDqwjZ9rBx1yLDikM1U=
X-Google-Smtp-Source: AGHT+IGHriJz0yQmo8UxkNOK8Bqz1kYnubFeO4Y2UzLjzRLRPoLoMVIHX+vHkOi6PTYXcazovDy0TONbi+mVQD/Z0TIPPH9D31Nl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3a7:e103:3c43 with SMTP id
 e9e14a558f8ab-3a7f9a9fce0mr34758215ab.19.1733236828101; Tue, 03 Dec 2024
 06:40:28 -0800 (PST)
Date: Tue, 03 Dec 2024 06:40:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f185c.050a0220.48a03.003a.GAE@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in closure_put_after_sub
 (2)
From: syzbot <syzbot+92b863cc48ee12775386@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121770df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91c852e3d1d7c1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=92b863cc48ee12775386
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7e1e116ea6e/disk-cdd30ebb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76410fd02a13/vmlinux-cdd30ebb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60bcdb55dd9c/bzImage-cdd30ebb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+92b863cc48ee12775386@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xf26afc1ffff11006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x935800ffff888030-0x935800ffff888037]
CPU: 0 UID: 0 PID: 40 Comm: kworker/0:1H Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: bcachefs_btree_io btree_node_write_work
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5089
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d fb 9b 9d 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 a8 7b 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90000b07510 EFLAGS: 00010806
RAX: 126b001ffff11006 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 935800ffff888032
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203036f R12: ffff888020ad5a00
R13: 0000000000000000 R14: 0000000000000000 R15: 935800ffff888032
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c24a819 CR3: 0000000032630000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x759/0xf50
 queue_work_on+0x1c2/0x380 kernel/workqueue.c:2390
 queue_work include/linux/workqueue.h:662 [inline]
 closure_queue include/linux/closure.h:268 [inline]
 closure_put_after_sub+0x2b1/0x330 lib/closure.c:42
 bch2_btree_complete_write fs/bcachefs/btree_io.c:1789 [inline]
 __btree_node_write_done+0x268/0x440 fs/bcachefs/btree_io.c:1800
 btree_node_write_done fs/bcachefs/btree_io.c:1840 [inline]
 btree_node_write_work+0x9d3/0xba0 fs/bcachefs/btree_io.c:1882
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x6a/0x2100 kernel/locking/lockdep.c:5089
Code: b6 04 30 84 c0 0f 85 f8 16 00 00 45 31 f6 83 3d fb 9b 9d 0e 00 0f 84 c8 13 00 00 89 54 24 60 89 5c 24 38 4c 89 f8 48 c1 e8 03 <80> 3c 30 00 74 12 4c 89 ff e8 a8 7b 8c 00 48 be 00 00 00 00 00 fc
RSP: 0018:ffffc90000b07510 EFLAGS: 00010806
RAX: 126b001ffff11006 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 935800ffff888032
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: dffffc0000000000 R11: fffffbfff203036f R12: ffff888020ad5a00
R13: 0000000000000000 R14: 0000000000000000 R15: 935800ffff888032
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c24a819 CR3: 0000000032630000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b6 04                	mov    $0x4,%dh
   2:	30 84 c0 0f 85 f8 16 	xor    %al,0x16f8850f(%rax,%rax,8)
   9:	00 00                	add    %al,(%rax)
   b:	45 31 f6             	xor    %r14d,%r14d
   e:	83 3d fb 9b 9d 0e 00 	cmpl   $0x0,0xe9d9bfb(%rip)        # 0xe9d9c10
  15:	0f 84 c8 13 00 00    	je     0x13e3
  1b:	89 54 24 60          	mov    %edx,0x60(%rsp)
  1f:	89 5c 24 38          	mov    %ebx,0x38(%rsp)
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 a8 7b 8c 00       	call   0x8c7be0
  38:	48                   	rex.W
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

