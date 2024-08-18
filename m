Return-Path: <linux-kernel+bounces-291135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ECF955DC9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73FE9B21315
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4A1487FE;
	Sun, 18 Aug 2024 17:06:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B55224D7
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000788; cv=none; b=rCPwLu84pFit4nPRbEylrpbC1db4tCtlcEYm+4SDbORA5+Tivo0rY0bK4YERe6dZltjfNplxfO7BnsGnQPaJpR4Ye616Ye4gU1XRAyCHa35tHWFti7InoWXq8vIyyfSDvxv1YBHMWRtAFrE4r4yO2LbMFyQd7K4sZOZT3++bTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000788; c=relaxed/simple;
	bh=iJwakPphHPYHwzrkAzslGWS96UEBbdLTT8XCbzX0Bgg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eYGQweIAxRe5rokZjgK5ykyZ1dKBZqvbgKt+bQU/B3JLS/nT6HZMvzBlZGtGh+Cro3tdIsCD4k0czymDVdrdS24fYNDznQAUzI7bW1p7M5hXlxIkX/BfOvJCJg1AEAoowI4XiMPhxuw7C+pIg7Kk8Bwe9DCo9em908eSGQls0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d3999d0fdso10049535ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724000786; x=1724605586;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6k5L3RJUA8Atp69XBz/9SLJnWddH1C7Vqe9r/sNXeY=;
        b=c2IQtEyjg0xd7MgFSDvxxe2GH/+/6Aiu96TOnWZdqcSkbKIBqgzSL7sSnMFnA/deHU
         50d9GOITUWGj5m/Gtbe2iY5+G2F3zJEEMEVpL9Abh9WoTJJmjSFUHWy9GQsHPY1JFvF2
         kr1FB1ZoySSBlF9mh6QWttNtbHRT4rwc59dsuvbMzoYaZQJN2yqJU9EUyT3byaL7RUnG
         HT90PCFxPkJIExr4ouL29jUCU989DLFNmRVUtODUtN+w2WQk7robLnVR5bQYMSnc8VF7
         5ULas0sSMKFL2TXpWABhRvYA/+pOLz/JtLj7nJof3c38VJg05mAtdMrTRh9Mjn0zSE37
         lwMg==
X-Forwarded-Encrypted: i=1; AJvYcCVNZNEyO+WyHt7NB/YhtjX9IsPIUAuFP+Rf50Cj3v8dKWtOdalw3AsxLaS4l+t3OTPbl7ts41JF1a3+UIgByMULFIFcs97FTtk+8k+/
X-Gm-Message-State: AOJu0YxSgYkjxgG1nw5ALNyMH+I3EqTVzE23FfN+OIcLADt2oGgB1IWu
	EQeYnNDCyMwN8Voo/q9dUlM4FXF8PPvYa20vTrU0qfqKr9ywQ3ZKT8UxGa7hyBSVrS2rvYExAMS
	EjN56SqU4lyea6swaOoNfwXwCb99Q9u8XZkkVqWNlfCZD2tXPm9gd3Lc=
X-Google-Smtp-Source: AGHT+IFCVtinIXSFaARiQ+T5c4yR9LLMwgkMI3RSwgQyYOj9D8ixgrnxGtvtvx7V/VPBBt7kC2D/ojqEjvZLtRsHTUbWOXSmiKhe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:39d:1a4c:b853 with SMTP id
 e9e14a558f8ab-39d26d9bbe5mr7546375ab.6.1724000785777; Sun, 18 Aug 2024
 10:06:25 -0700 (PDT)
Date: Sun, 18 Aug 2024 10:06:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dd465061ff836c9@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate
From: syzbot <syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c3f2d783a459 Merge tag 'mm-hotfixes-stable-2024-08-17-19-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1530ec05980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=453873f1588c2d75b447
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158a2f5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11543be5980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c3f2d783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d927f7c3cfd/vmlinux-c3f2d783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea54bdfad24b/bzImage-c3f2d783.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/fe8fff7766d6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+453873f1588c2d75b447@syzkaller.appspotmail.com

(syz-executor245,5108,0):ocfs2_verify_group_and_input:428 ERROR: add a group which is in the current volume.
(syz-executor245,5108,0):ocfs2_group_add:511 ERROR: status = -22
------------[ cut here ]------------
kernel BUG at fs/ocfs2/uptodate.c:509!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5108 Comm: syz-executor245 Not tainted 6.11.0-rc3-syzkaller-00338-gc3f2d783a459 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_set_new_buffer_uptodate+0x145/0x160 fs/ocfs2/uptodate.c:509
Code: 03 42 80 3c 20 00 74 08 48 89 df e8 d5 8a 65 fe 4c 8b 1b 4c 89 ff 5b 41 5c 41 5d 41 5e 41 5f 41 ff e3 cc 90 e8 ec 48 fe fd 90 <0f> 0b e8 e4 48 fe fd 90 0f 0b e8 dc 48 fe fd 90 0f 0b e8 d4 48 fe
RSP: 0018:ffffc90002cefa50 EFLAGS: 00010293
RAX: ffffffff83954204 RBX: 0000000000000001 RCX: ffff88801c0d2440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cefcf0 R08: ffffffff839540ee R09: 1ffffffff202fdd5
R10: dffffc0000000000 R11: fffffbfff202fdd6 R12: dffffc0000000000
R13: 1ffff9200059df68 R14: ffff88803be1b0e8 R15: ffff88803be632f0
FS:  000055555a5c8480(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000d0 CR3: 00000000190b6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_group_add+0x39f/0x15a0 fs/ocfs2/resize.c:507
 ocfs2_ioctl+0x661/0x7e0 fs/ocfs2/ioctl.c:891
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b013a2259
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3e81d468 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8b013a2259
RDX: 00000000200000c0 RSI: 0000000040186f02 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffe3e81d4a0
R10: 00007ffe3e81d470 R11: 0000000000000246 R12: 00007ffe3e81d4a0
R13: 00007ffe3e81d728 R14: 431bde82d7b634db R15: 00007f8b013eb03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_set_new_buffer_uptodate+0x145/0x160 fs/ocfs2/uptodate.c:509
Code: 03 42 80 3c 20 00 74 08 48 89 df e8 d5 8a 65 fe 4c 8b 1b 4c 89 ff 5b 41 5c 41 5d 41 5e 41 5f 41 ff e3 cc 90 e8 ec 48 fe fd 90 <0f> 0b e8 e4 48 fe fd 90 0f 0b e8 dc 48 fe fd 90 0f 0b e8 d4 48 fe
RSP: 0018:ffffc90002cefa50 EFLAGS: 00010293
RAX: ffffffff83954204 RBX: 0000000000000001 RCX: ffff88801c0d2440
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cefcf0 R08: ffffffff839540ee R09: 1ffffffff202fdd5
R10: dffffc0000000000 R11: fffffbfff202fdd6 R12: dffffc0000000000
R13: 1ffff9200059df68 R14: ffff88803be1b0e8 R15: ffff88803be632f0
FS:  000055555a5c8480(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000d0 CR3: 00000000190b6000 CR4: 0000000000350ef0
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

