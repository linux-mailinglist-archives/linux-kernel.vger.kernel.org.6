Return-Path: <linux-kernel+bounces-180960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9738C757D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9358B22037
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5351145A14;
	Thu, 16 May 2024 11:52:30 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884DC2D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860350; cv=none; b=VCkxgK/TTE4W5HXo8IZ/7jUdjC8fcGCDJgFW2G4XqkPcRFLz3Gq9mnCos9DnqdfoaIcMfiwIqqx1JMmQxyy1Aji/hpURjEHkx7R4GVBA86yy3a4yKoPoGBU9Iqw8aVYnCHty0Iywba5V8SEoNKrvDadzkhoNyF9cGKxmfzKMjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860350; c=relaxed/simple;
	bh=jM3jr0Z1L7vwt/24+0FwjZlGUCuNNHkM9mVZucvfsac=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oRd1NDMmXqpG11bp6ZFAZxMlXS9mRbgbqIF833vx6d/jHbhklWgmGstVWGzyyugvJwo+qyrxTxGZ8Awtmy4rKoiXTUwcsPumbtmofq1ZFdSbKxPaeF9Bmka+vX2M6np9UouMN5OG/aeb55U7eDGZ3KbLrF1LVRRayr0s+T+8mFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-36c6b24fd6eso84778605ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715860347; x=1716465147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yBpbIdUj7Gxq9OVdxjBPQkFVCF7Zk4NQirYg1IwJfQ=;
        b=DnWV9fQp0H2chKzLtxn/S648CPrcXrny045OX4ISPVRQYl16dNOllKVdTTzQNBsBfp
         RARpPtISTdDnVd6evTVuIdKUiLOilclJ73QlhWqRagDBVEt2NF0spf39BCT/iwTwvIAE
         l1Le8UE109mRxHU0TZAvyjpSXa6MCCS+XGmFiI1f4179f5OhR4x4OV/MtQh9W95qk7+n
         gTg0ozy+1lMdnMtBA8OjHNjiGsEbVlzetKI3zwLTmHzCiBQBXy22nbdTDVUg8NvEP63M
         sXBN/pyrDMbQHrQT9ka7KDNYRtRYTxEB2ED1RqabRp/exUF3lQxuwaT0DyMNjm4oCx/0
         MtPg==
X-Forwarded-Encrypted: i=1; AJvYcCWVmmbKZ2YLR2XGY147xmwx/hRl+t44UAZdSbmLR0iP/SPeWnKJ3eKRFZ8XlPCFvI1gaV2zEiJXmtjzEVNL4GewFlskZBiCnVu6cxMm
X-Gm-Message-State: AOJu0YzF0wsvSqvkEra86u9J8rmzxZUZmzEoukryPA94X/1Ex4thwHCM
	4y3n5gKZ/0aLeO5Rn9EWmtdaxWe0b8o82krWKT9/WIkuAAHwJAStVNNh/sQDZDHx5Ze0M23em26
	/1xHZi+xUGVJtdIEUK17/1FrXW8lW6AOu0ON1UHILoC2DjNp6oq+OAic=
X-Google-Smtp-Source: AGHT+IEOZ6tybanfo9Ftys0j6BEKQYKdKgxyA0U1PdC8tdkNXM4OsnuW+dTTif9kmhXaOw8IALiOBqhlsRFwX76kJ7yE/543evgZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d1c6:0:b0:36c:4cc9:5923 with SMTP id
 e9e14a558f8ab-36cc1446f5emr2421765ab.2.1715860347783; Thu, 16 May 2024
 04:52:27 -0700 (PDT)
Date: Thu, 16 May 2024 04:52:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000839acb061890decc@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_btree_iter_verify_entry_exit
From: syzbot <syzbot+0dfe05235e38653e2aee@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82d92a9a1b9e Add linux-next specific files for 20240515
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=124ed478980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6e710494e484d15
dashboard link: https://syzkaller.appspot.com/bug?extid=0dfe05235e38653e2aee
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1401b4f0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179f895c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/80ea6f0ee7c5/disk-82d92a9a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/150de8c9fcb2/vmlinux-82d92a9a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f742e121e6bc/bzImage-82d92a9a.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c575d9960a84/mount_0.gz

The issue was bisected to:

commit f7643bc9749f270d487c32dc35b578575bf1adb0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Apr 17 05:26:02 2024 +0000

    bcachefs: make btree read errors silent during scan

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1536aa3f180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1736aa3f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1336aa3f180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0dfe05235e38653e2aee@syzkaller.appspotmail.com
Fixes: f7643bc9749f ("bcachefs: make btree read errors silent during scan")

bcachefs (loop0): journal_replay... done
bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_iter.c:273!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5094 Comm: syz-executor180 Not tainted 6.9.0-next-20240515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:bch2_btree_iter_verify_entry_exit+0x51b/0x550 fs/bcachefs/btree_iter.c:272
Code: c1 fd ff ff 44 89 e1 80 e1 07 38 c1 0f 8c c6 fd ff ff be 08 00 00 00 4c 89 e7 e8 60 fe e8 fd e9 b4 fd ff ff e8 66 43 83 fd 90 <0f> 0b e8 5e 43 83 fd 90 0f 0b e8 56 43 83 fd 90 0f 0b e8 4e 43 83
RSP: 0018:ffffc9000356f1b8 EFLAGS: 00010293
RAX: ffffffff8413091a RBX: 0000000000000820 RCX: ffff88807cda0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff84130480 R09: 0000000000000000
R10: ffffc9000356f000 R11: fffff520006ade05 R12: ffffc9000356f680
R13: ffffc9000356f680 R14: 1ffff1100ed4c808 R15: dffffc0000000000
FS:  0000555579c50380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdceb1cd94 CR3: 000000002d1d2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_btree_iter_peek_slot+0x169/0x26d0 fs/bcachefs/btree_iter.c:2584
 __bch2_bkey_get_iter fs/bcachefs/btree_iter.h:552 [inline]
 bch2_bkey_get_iter fs/bcachefs/btree_iter.h:566 [inline]
 bch2_inode_peek_nowarn+0x201/0x4d0 fs/bcachefs/inode.c:340
 bch2_inode_peek fs/bcachefs/inode.c:366 [inline]
 bch2_inode_find_by_inum_trans+0xc4/0x1d0 fs/bcachefs/inode.c:939
 bch2_vfs_inode_get+0x2a2/0x680 fs/bcachefs/fs.c:278
 bch2_mount+0xf32/0x1320 fs/bcachefs/fs.c:1999
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff67fcf1bfa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff14da13c8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff14da13e0 RCX: 00007ff67fcf1bfa
RDX: 0000000020005b00 RSI: 0000000020000000 RDI: 00007fff14da13e0
RBP: 0000000000000004 R08: 00007fff14da1420 R09: 0000000000005b22
R10: 0000000000000098 R11: 0000000000000282 R12: 0000000000000098
R13: 00007fff14da1420 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_btree_iter_verify_entry_exit+0x51b/0x550 fs/bcachefs/btree_iter.c:272
Code: c1 fd ff ff 44 89 e1 80 e1 07 38 c1 0f 8c c6 fd ff ff be 08 00 00 00 4c 89 e7 e8 60 fe e8 fd e9 b4 fd ff ff e8 66 43 83 fd 90 <0f> 0b e8 5e 43 83 fd 90 0f 0b e8 56 43 83 fd 90 0f 0b e8 4e 43 83
RSP: 0018:ffffc9000356f1b8 EFLAGS: 00010293
RAX: ffffffff8413091a RBX: 0000000000000820 RCX: ffff88807cda0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff84130480 R09: 0000000000000000
R10: ffffc9000356f000 R11: fffff520006ade05 R12: ffffc9000356f680
R13: ffffc9000356f680 R14: 1ffff1100ed4c808 R15: dffffc0000000000
FS:  0000555579c50380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdceb1bff0 CR3: 000000002d1d2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

