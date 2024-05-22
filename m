Return-Path: <linux-kernel+bounces-186702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B48CC7DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E51282C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1287914198A;
	Wed, 22 May 2024 20:56:42 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A955C3E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411401; cv=none; b=DvpK32mN24bBzE3ljmTBB0/aYfRyikVJgL/LohUwRH/v35CUlMHe/TWHi7yQiPp2nz5k1F92Wdw2bKNoqLjaZrg1n7xHKC7B4klaSXquLNKcL8cpElBE1nbQR9SGR4BwISntPW43JgN+nMBH1zTjNgOpLiqJDZm46j1r45aZk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411401; c=relaxed/simple;
	bh=xG/iRuQRmc0R8hKO4LOqujjQwBZx+XoxZ9SKOYnTJqY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oN3X/iioie26UYWUvURScxe49pAGuQL1bf/kqMYbPkkDsdJvpAeGmTNyWR06lkHzsnibWbTiF2742zJFO1QrX1QluGIZ+kORIeODpEa5kS5y0vxUEjwxCRmdgm1GhXrY2kK3+PGveaIbsAxZfSSLVpFpmAychjzzK7l9C2YCf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e1e409d1f4so87897139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716411399; x=1717016199;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+i+1+h80lc9TXHE9aed5YYpSck4hnJYPhtvgyEQolQ=;
        b=A3SxAhPfLKEDL7glqtRUzdDfq3f+jyfd+XFKB6603zjL12xcctHnP2HKpyMZV+L6ub
         KOTpBnKL1C7ONmxLKXlv4p7GxB4kQSfYkxqFiSo5b+rFfwkGrUWnluTvGss7WQ41L83h
         l/Oq0fmnjJjpM+H1qBmj14mcbMEkoTwRmlNUGj9B9+C9uECBXbnjmAvQtMi3GJwyv65H
         nOyfiZO8AsqxLj0UgowuW43iHxLu8UJxLhJRsY8fESEB2fAL5XAMdBqdYpXWTwvxv09y
         dDnOkaNUHudYA2FNNAQwKh4aloUjjPOp1kJ6ZudZloFnQYMEFMa7guFMpRyhPvsHuI6i
         jGtA==
X-Forwarded-Encrypted: i=1; AJvYcCWpfcRBT/tMp01LE56phS/q642Pv4om+8svpD4mxdE1Hi7vknOAMx2GKBDpb7y8+LoexYh1vQehugwCRxBVJwgB8rLc2xlJDSlnuZA3
X-Gm-Message-State: AOJu0Yx73+FfZvjw/wHXrOvivIkPb57hCTbG/YPJgfaDBwL6RXh7dPIp
	jQVW5Pl+SZZU12ofNuJC4UhAPSV/DY2j6Ikbfdwbh4v0Sbbd3RMxP1f98WOUlWNz0HENYGJuIfw
	XLOG9ZK44PlCzQShKV1Jp4Y0DqMuuT+uPVUkAE1DjxgzOOz/smOymdz0=
X-Google-Smtp-Source: AGHT+IEUtggJJAso4Y5jVSqudE8MyI4pMbD4AMrPqOixYJr0f3uLgqSEMajw9S4MV/pd2nUejqW+OXF6CRhmOc9zA4nzl7P6aQBq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:aa8f:0:b0:488:96c4:9caf with SMTP id
 8926c6da1cb9f-4afe3dba236mr91796173.6.1716411399389; Wed, 22 May 2024
 13:56:39 -0700 (PDT)
Date: Wed, 22 May 2024 13:56:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfd7970619112bec@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __bch2_truncate_folio
From: syzbot <syzbot+3d11e35eeafe176a6c5b@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14953df4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c2ef84980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a1592980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/disk-b6394d6f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinux-b6394d6f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/bzImage-b6394d6f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cff7ebd31dbf/mount_0.gz

The issue was bisected to:

commit f7643bc9749f270d487c32dc35b578575bf1adb0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Apr 17 05:26:02 2024 +0000

    bcachefs: make btree read errors silent during scan

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f1b784980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13f1b784980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f1b784980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d11e35eeafe176a6c5b@syzkaller.appspotmail.com
Fixes: f7643bc9749f ("bcachefs: make btree read errors silent during scan")

bcachefs (loop0): resume_logged_ops... done
bcachefs (loop0): going read-write
bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5083 at fs/bcachefs/fs-io.c:327 __bch2_truncate_folio+0x1a33/0x1d80 fs/bcachefs/fs-io.c:327
Modules linked in:
CPU: 0 PID: 5083 Comm: syz-executor322 Not tainted 6.9.0-syzkaller-10729-gb6394d6f7159 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__bch2_truncate_folio+0x1a33/0x1d80 fs/bcachefs/fs-io.c:327
Code: 41 5f 5d c3 cc cc cc cc e8 3a 00 6f fd 48 c7 c7 fa 04 c0 8d e8 4e 1c ea ff 89 05 18 02 6a 10 e9 ed ea ff ff e8 1e 00 6f fd 90 <0f> 0b 90 e9 0a fa ff ff 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c f0
RSP: 0018:ffffc900033df6c0 EFLAGS: 00010293
RAX: ffffffff84273a52 RBX: 0000000000000000 RCX: ffff888078fb8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900033df950 R08: ffffffff84273457 R09: 1ffffd400014f498
R10: dffffc0000000000 R11: fffff9400014f499 R12: 1ffff1100ecd900a
R13: ffff88807420075a R14: 0000000000000000 R15: ffff8880766c8050
FS:  000055555b7d5380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f47f45440f8 CR3: 0000000077134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_truncate_folios fs/bcachefs/fs-io.c:366 [inline]
 bchfs_fpunch fs/bcachefs/fs-io.c:520 [inline]
 bch2_fallocate_dispatch+0x6fb/0x3810 fs/bcachefs/fs-io.c:785
 vfs_fallocate+0x564/0x6c0 fs/open.c:330
 ksys_fallocate fs/open.c:353 [inline]
 __do_sys_fallocate fs/open.c:361 [inline]
 __se_sys_fallocate fs/open.c:359 [inline]
 __x64_sys_fallocate+0xbd/0x110 fs/open.c:359
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47f44c7a99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec1ed9828 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f47f44c7a99
RDX: 0000000000000002 RSI: 0000000000000003 RDI: 0000000000000004
RBP: 00007f47f45405f0 R08: 000055555b7d64c0 R09: 000055555b7d64c0
R10: 0000000000010000 R11: 0000000000000246 R12: 00007ffec1ed9850
R13: 00007ffec1ed9a78 R14: 431bde82d7b634db R15: 00007f47f451003b
 </TASK>


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

