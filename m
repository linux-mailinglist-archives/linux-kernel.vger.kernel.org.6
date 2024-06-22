Return-Path: <linux-kernel+bounces-225838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE529135F8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3151F2249C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021865A0F5;
	Sat, 22 Jun 2024 20:12:28 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53B208CA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719087147; cv=none; b=WAzUin1w90ifjHLr9lFkIEjJzzsB0YJXEHTel0e+4Ce12/ZWjCUytLf7C0tej3hA7J5fHUIAIEj5sMj2PeThOwHn915GFfASNtoceOrclQrZrhI+MlIJ5CXNNtQ2LxzPjSl7loIEDqUbVTGXeZZiu0xQZqhpEdpXoim0R98K4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719087147; c=relaxed/simple;
	bh=7EdRjx130+gWIF+7a8J9AGILbNslW8cK3HQjfqGQ6q8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CxIuaYLe8gMr2LUcfci18bN8QV+JI5HgGa9upiEYleBxZfTJrtIhH15blmWkLjRgrzHX1LdPOLKaRIGl2DSQdWSFN2j/xy1m4ZxNqbBWOhMX0OoLd3mXkJAjNCmrzVRa/DsuEYeVBZ5KIVpn3HG4MYR1TRHaBF7zKpX3wIP9WZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ec00e71ab9so375589539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 13:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719087145; x=1719691945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhEFR6Y5uX0WyAPwpEKkBDn8hBSfrB8GV9Qlbvltez0=;
        b=xBqD6SL8xuRpVYLk88mQZ1Gj9eEyXn7qoQAH+H3RFVC1fOzUsssZzbsiQdMrP4A78z
         +RUsMSnK3nyThaTFODjwKwuEaSPAB8Hzv/gzWsg9mIeOmFsKInsbgRVkmCh9tGWSLJT5
         qduR3CIkxKjH0AHIsgMoUIBrrBqNP7ov9h6yCM8coiGPOGCmz4LgjOn5FGPuNYLUUQy+
         b2sRBZy2e7jne8GWslc/IEutd0n67k028c+yqKuAhryytQpJsjgogIa5dXEB4XpQM/1L
         SXV93deoHG7UgacV11PBGAJ3RPdbuDRDQVJB/s0C+LOI26F0UdP5RGsbhMkdfXuWTxfT
         hAHw==
X-Forwarded-Encrypted: i=1; AJvYcCVo6ZAAsvbw9Tx23zWgtcUnSiIPTuxeuQuYsjGR+pzMptMOnJx2Y6G4ssPzbV67Z24ZM//mfuMPqydvdfMUtTcYYhRiOfS01ouBMtwl
X-Gm-Message-State: AOJu0YyS9kg1MvAUwn/71nly7OYWT69MSxkYLqf5PTLju1MRoiBx722S
	X/0e6pPtBsVpW5Wyx8lDc8fVZ3/zorxa75XwRqkCf6qLz9OjI1ebs5R0BkZOZNUp5/qg87nagdO
	FCd7oprGI+opQF7RlQ5c83p0WmWAg8z6xB/IyFRHEPZnjOcHsDhEIa9E=
X-Google-Smtp-Source: AGHT+IHUdgt8I2Bhq97+bkh64DhY78T0/jlQGqFB9qpGX7m2dYwMR0QRdTBQDO+i0MMEwn5GAm+viKULCGbzVmDIdQXHJGBsXtte
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54b:0:b0:375:a50d:7f2d with SMTP id
 e9e14a558f8ab-3763f5c9fc5mr972025ab.1.1719087145132; Sat, 22 Jun 2024
 13:12:25 -0700 (PDT)
Date: Sat, 22 Jun 2024 13:12:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fb1e2061b802aea@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_ioctl_fsck_online
From: syzbot <syzbot+ad60312dc46671a69480@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ce7012980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=ad60312dc46671a69480
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd6851980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bac41e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35e32e9073a7/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6e34658d16/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4417e7ef76ed/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/86181a5e154a/mount_0.gz

The issue was bisected to:

commit f7643bc9749f270d487c32dc35b578575bf1adb0
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Apr 17 05:26:02 2024 +0000

    bcachefs: make btree read errors silent during scan

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144ad446980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164ad446980000
console output: https://syzkaller.appspot.com/x/log.txt?x=124ad446980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad60312dc46671a69480@syzkaller.appspotmail.com
Fixes: f7643bc9749f ("bcachefs: make btree read errors silent during scan")

bcachefs (loop0): done starting filesystem
------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:23!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5078 Comm: syz-executor269 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__phys_addr+0x16a/0x170 arch/x86/mm/physaddr.c:23
Code: a0 59 1a 8e 4c 89 f6 4c 89 fa e8 31 3d 9e 03 e9 45 ff ff ff e8 b7 d9 53 00 90 0f 0b e8 af d9 53 00 90 0f 0b e8 a7 d9 53 00 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900032bef38 EFLAGS: 00010293
RAX: ffffffff81424c69 RBX: 000000007ffffff2 RCX: ffff888023c99e00
RDX: 0000000000000000 RSI: 000000007ffffff2 RDI: 000000001fffffff
RBP: ffffc900032bf050 R08: ffffffff81424c05 R09: 0000000000000000
R10: ffff888023817220 R11: ffffed1004702e58 R12: ffff888023817000
R13: fffffffffffffff2 R14: 000000007ffffff2 R15: ffff888023817220
FS:  000055557cb96380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb44fbf78 CR3: 0000000022c2c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:1313 [inline]
 kfree+0x71/0x360 mm/slub.c:4550
 bch2_ioctl_fsck_online+0x404/0x660 fs/bcachefs/chardev.c:853
 bch2_fs_ioctl+0x1c3c/0x37d0 fs/bcachefs/chardev.c:927
 bch2_fs_file_ioctl+0x870/0x26e0 fs/bcachefs/fs-ioctl.c:532
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f375bb1b979
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd0a34128 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffcd0a342f8 RCX: 00007f375bb1b979
RDX: 0000000020000000 RSI: 000000004010bc14 RDI: 0000000000000004
RBP: 00007f375bba0610 R08: 0000000000000000 R09: 00007ffcd0a342f8
R10: 00000000000119f4 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffcd0a342e8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0x16a/0x170 arch/x86/mm/physaddr.c:23
Code: a0 59 1a 8e 4c 89 f6 4c 89 fa e8 31 3d 9e 03 e9 45 ff ff ff e8 b7 d9 53 00 90 0f 0b e8 af d9 53 00 90 0f 0b e8 a7 d9 53 00 90 <0f> 0b 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900032bef38 EFLAGS: 00010293
RAX: ffffffff81424c69 RBX: 000000007ffffff2 RCX: ffff888023c99e00
RDX: 0000000000000000 RSI: 000000007ffffff2 RDI: 000000001fffffff
RBP: ffffc900032bf050 R08: ffffffff81424c05 R09: 0000000000000000
R10: ffff888023817220 R11: ffffed1004702e58 R12: ffff888023817000
R13: fffffffffffffff2 R14: 000000007ffffff2 R15: ffff888023817220
FS:  000055557cb96380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdb44fbf78 CR3: 0000000022c2c000 CR4: 00000000003506f0
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

