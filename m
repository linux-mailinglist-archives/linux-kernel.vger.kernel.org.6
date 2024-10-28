Return-Path: <linux-kernel+bounces-385388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218889B368F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2E21F2236A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C91DF253;
	Mon, 28 Oct 2024 16:33:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA61DEFCF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133210; cv=none; b=GKhOn11t10Uu6UPCzz2crOUDvYc8QKwsHOJ1ZXw2sB5WMWdaMPYdMD0vNWSsXeghsXjIOQ2RIrg1Rqflr2xRXwz8THX+Dr6HyKM6k6OXrdb7Tf146pWqYgpFgnPcWMF0h65NmGFLZX/JSio6NFQ8odCnbMJsc3xkdt5nrpFK0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133210; c=relaxed/simple;
	bh=DH98BemRvfQHt11dAZl2fwhmOOiAkVRl2VMSQe1dl0E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A/bjeR0Qnrctj2fsNuTCWRX6gkHwGo0ruC4tqRsFO8poALCmnIZqsZAbUepMWjvW4QNLjEOtoIxrrrDEIb7wX4tlZc5bxdPm9dJN3w2zjmb74LxkoKrKVBfPAZ7iGZ3e5OchEIRSI/Zs08olMRhxtXAT/l8mVkd7SMJe+0OIXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83abad6594fso457637339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133207; x=1730738007;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TP72q2DYylwiU/k0rJQ0bZB7ok8cFQOxLvEIMOS1MYA=;
        b=lBI06leAELIxrQeYNq8Ov1HHYB9OOLlGZUtLExeDzk8M3rmw0g95YZ48NQHI4PAryT
         lGLDFzr3pAye0jDCqxETo1b+oDLUYvozLDh2o3h0gpWp364YVWX9NmNg6qfU10Hq3C9u
         wskcyvtoFYmPbqnWzCqSXjGDTZoJxkir91ncIqTGgtzXnImKR1Zqgey8JOnz2aGf+X1g
         HzU5qsquMCsNflOjfFpvYZZcQTuvtyCf7ZBl4GZwy3Db53ltBepMgh7QgtvT4KPDNwAx
         JKRDOhCuVj66dTgNBqITEK+HqqKIFJJ5W/RxYbhKdcScSNqemhPvU//t09RSjXpR6hp0
         NvrA==
X-Forwarded-Encrypted: i=1; AJvYcCXIYQq0Zc9w9ye79mJYUja2rG7LYFDAdGN/HaL6U3Xrqlz6Y8FItYkO+KLH3VyaqOozof1BTQrUC2Zlt50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTIej8hdeP38MuypM5QDV5HWsNvwQnv6XEzsbwlWHrrwp8I7m
	xAoc3IHh8OMVeFik0D7CNTaN7cnIDMOsIjf9Q73PGbu9E5NkebsnVtE1K/cYaC4vg3GF5P5oz9Z
	LfKWwonO1IBmz4GWpMKmadrpaFOyt0WLUpXBW/FMqXdVN5zMC+ijf4ao=
X-Google-Smtp-Source: AGHT+IHUdwIbMXAJ2kZFPR8oryBcuHJf3Is+8npdb3fvik7kBSIjHcwiMMbFnAXvo5GSzAJPUfXesBUOiahZIB3l4GluNngDUHUE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c83:b0:3a4:d94f:5b52 with SMTP id
 e9e14a558f8ab-3a4ed2e9702mr74152495ab.20.1730133206951; Mon, 28 Oct 2024
 09:33:26 -0700 (PDT)
Date: Mon, 28 Oct 2024 09:33:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671fbcd6.050a0220.21b2f.000a.GAE@google.com>
Subject: [syzbot] [jfs?] kernel BUG in clear_inode (2)
From: syzbot <syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d0b0e7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=ac2116e48989e84a2893
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a9ae40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1030b0e7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d5a3632f9dde/disk-4e467744.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6d73f937198/vmlinux-4e467744.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8cdecc78206/bzImage-4e467744.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/07de6ffca997/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b0b287980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b0b287980000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0b287980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:668!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 113 Comm: jfsCommit Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:clear_inode+0x168/0x190 fs/inode.c:668
Code: 4c 89 f7 e8 ba fe e5 ff e9 61 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c1 4c 89 f7 e8 90 ff e5 ff eb b7 e8 09 5d 7f ff 90 <0f> 0b e8 01 5d 7f ff 90 0f 0b e8 f9 5c 7f ff 90 0f 0b e8 f1 5c 7f
RSP: 0018:ffffc90002cffae8 EFLAGS: 00010093
RAX: ffffffff82157a87 RBX: 0000000000000001 RCX: ffff88801eb2bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cffc90 R08: ffffffff82157977 R09: fffff5200059ff38
R10: dffffc0000000000 R11: fffff5200059ff38 R12: dffffc0000000000
R13: ffff888071503c00 R14: ffff888071503da8 R15: ffff888071503b80
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b23f95ed8 CR3: 000000000e734000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_evict_inode+0xb5/0x440 fs/jfs/inode.c:166
 evict+0x4e8/0x9b0 fs/inode.c:725
 txUpdateMap+0x931/0xb10 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_inode+0x168/0x190 fs/inode.c:668
Code: 4c 89 f7 e8 ba fe e5 ff e9 61 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 7c c1 4c 89 f7 e8 90 ff e5 ff eb b7 e8 09 5d 7f ff 90 <0f> 0b e8 01 5d 7f ff 90 0f 0b e8 f9 5c 7f ff 90 0f 0b e8 f1 5c 7f
RSP: 0018:ffffc90002cffae8 EFLAGS: 00010093
RAX: ffffffff82157a87 RBX: 0000000000000001 RCX: ffff88801eb2bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cffc90 R08: ffffffff82157977 R09: fffff5200059ff38
R10: dffffc0000000000 R11: fffff5200059ff38 R12: dffffc0000000000
R13: ffff888071503c00 R14: ffff888071503da8 R15: ffff888071503b80
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b23f95ed8 CR3: 000000000e734000 CR4: 00000000003526f0
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

