Return-Path: <linux-kernel+bounces-373627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB799A598D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614E12815AE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E698193432;
	Mon, 21 Oct 2024 04:31:36 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7475286A8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485095; cv=none; b=bm9bRpL8n0c8dcw3M8RX5yX2TUCvaZyOGrl5kv/26PIbT8euBRPvwjPxiuxVNoHskuKyTwyWtXRyO4mR6HoptdaFVzueZK8cdFD/tUOo0zx1sFh0uglbEELNb7lhu0qdzrQ48sJyYTzOactvT+A7MmhsxjBTxm4jM5avvL33tQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485095; c=relaxed/simple;
	bh=84gzpIFyB5+3DljQK5nHfmTdEO9qvUXCbMKNqVGJq7c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sj34PwhdDZb91hRjt/AVcu5DUkWFaZhUhbCHwzXqIAtu4xNSTWNpzmez4iVgJYFcClBydyGI2hJ05wW5dpAzVo+op7Tk7xGzLtImLg/8xjI2y1NjsZYvwRyXMOxrOcy4dS5TKOl4DXKrH01hitNiqYilVav61Tjv3EdQ6MNTlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab3d46472so359660739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729485093; x=1730089893;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLYiM8y/B2Cv75nG0jidFAm4gU309fO5gyqPvxjsbGE=;
        b=cFt+5I+J6Jx30VPScIHw6lSouRTNhwIEO5WyMuDSYdZNbAcHuJWJuOSNMXCIJRCCjN
         jVUoTWKxpLRuibAL2PHCrASEMXYjpkfY1kFs3k8Pjqy96ehaAtMiZCTUFzguBjckyAfW
         5gt7dT9y6Cc7RdBzfAtpRCOLZtiLvQjK/SiQkWXuzOojyHE1Z83ibd/MZSbVeZSslrJ5
         aDY4bXatZbvNCiRKH07oa17Ic1J8Dq5IOIe+bSzATA5H4Sb6u4TBlNhyIVikPWJkOn+H
         krMxFvU4E++Gz8f+bqLu/Q0A3s1YxndH8TYT0K38vxqUlmbUU+MhHgyFGNTMwWnmXc4T
         GNLg==
X-Forwarded-Encrypted: i=1; AJvYcCUt9mJh/q8QjI+ZvUdLWVz3wZTXCJlixPraCfzOr5lv5uZmp2uGPykQ1Q5Awv7fdAy1Vv+jA7c8mzFc/IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3f3hPryezX3idqNn8PmrG+0RMmWfCRLktQVQs3j1bg+H5dio
	LO4XkTZm0mUoLr7xIl98vZ62TBCdSKK44dRcD9D6qsamTuvevx4i1iv7wGfwjw6vgYHiUULz4JG
	13DsA+J5z+5YrNYhLRyBI4xNTN17rqMJbhMGKaixZe64lOqga1cm+JhU=
X-Google-Smtp-Source: AGHT+IGxDY3JsK9gI8O8uovCqeuQZyosLW9LRfuErtayDUgvr9A0FSMsrRndI2Us+3vujGo/gpTbFEWuddnNZy1CrO1aFI/Xf6ZD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190e:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a3f4073e06mr79264655ab.15.1729485092771; Sun, 20 Oct 2024
 21:31:32 -0700 (PDT)
Date: Sun, 20 Oct 2024 21:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6715d924.050a0220.10f4f4.003d.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in __bch2_trans_commit
From: syzbot <syzbot+f074d2e31d8d35a6a38c@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    715ca9dd687f Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=113e6430580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f074d2e31d8d35a6a38c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110560a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdc25f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf3787869b5a/disk-715ca9dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b938d885bc17/vmlinux-715ca9dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c039de0dde2/bzImage-715ca9dd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b049575f12e2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f074d2e31d8d35a6a38c@syzkaller.appspotmail.com

bcachefs (loop1): fatal error - emergency read only
------------[ cut here ]------------
kernel BUG at fs/bcachefs/journal.h:375!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc3-syzkaller-00420-g715ca9dd687f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: btree_update btree_interior_update_work
RIP: 0010:bch2_journal_res_get fs/bcachefs/journal.h:375 [inline]
RIP: 0010:bch2_trans_journal_res_get fs/bcachefs/btree_trans_commit.c:350 [inline]
RIP: 0010:bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:668 [inline]
RIP: 0010:do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:900 [inline]
RIP: 0010:__bch2_trans_commit+0x9232/0x93c0 fs/bcachefs/btree_trans_commit.c:1121
Code: fd 90 0f 0b e8 3f bb 78 fd 90 0f 0b e8 37 bb 78 fd 90 0f 0b e8 2f bb 78 fd 90 0f 0b e8 27 bb 78 fd 90 0f 0b e8 1f bb 78 fd 90 <0f> 0b e8 17 bb 78 fd 90 0f 0b e8 0f bb 78 fd 90 0f 0b e8 07 bb 78
RSP: 0018:ffffc900001076c0 EFLAGS: 00010293
RAX: ffffffff841c2c91 RBX: 0000000000000000 RCX: ffff88801cebbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000107890 R08: ffffffff841bcfc8 R09: 1ffff1100cd494a8
R10: dffffc0000000000 R11: ffffed100cd494a9 R12: ffff888066a00000
R13: ffff888066a4a500 R14: 0000000000000044 R15: ffff88803060c0d0
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff942fe8000 CR3: 000000007bcb8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_trans_commit fs/bcachefs/btree_update.h:184 [inline]
 btree_update_nodes_written fs/bcachefs/btree_update_interior.c:728 [inline]
 btree_interior_update_work+0x1492/0x2b10 fs/bcachefs/btree_update_interior.c:866
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_journal_res_get fs/bcachefs/journal.h:375 [inline]
RIP: 0010:bch2_trans_journal_res_get fs/bcachefs/btree_trans_commit.c:350 [inline]
RIP: 0010:bch2_trans_commit_write_locked fs/bcachefs/btree_trans_commit.c:668 [inline]
RIP: 0010:do_bch2_trans_commit fs/bcachefs/btree_trans_commit.c:900 [inline]
RIP: 0010:__bch2_trans_commit+0x9232/0x93c0 fs/bcachefs/btree_trans_commit.c:1121
Code: fd 90 0f 0b e8 3f bb 78 fd 90 0f 0b e8 37 bb 78 fd 90 0f 0b e8 2f bb 78 fd 90 0f 0b e8 27 bb 78 fd 90 0f 0b e8 1f bb 78 fd 90 <0f> 0b e8 17 bb 78 fd 90 0f 0b e8 0f bb 78 fd 90 0f 0b e8 07 bb 78
RSP: 0018:ffffc900001076c0 EFLAGS: 00010293
RAX: ffffffff841c2c91 RBX: 0000000000000000 RCX: ffff88801cebbc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000107890 R08: ffffffff841bcfc8 R09: 1ffff1100cd494a8
R10: dffffc0000000000 R11: ffffed100cd494a9 R12: ffff888066a00000
R13: ffff888066a4a500 R14: 0000000000000044 R15: ffff88803060c0d0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff942fff000 CR3: 000000002ce04000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

