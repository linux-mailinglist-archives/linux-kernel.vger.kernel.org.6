Return-Path: <linux-kernel+bounces-424176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E339DB14B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56249281CED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946238FA6;
	Thu, 28 Nov 2024 01:57:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC298467
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759046; cv=none; b=AV5cCbp+rpdfKsOr6yFgCcNUElGXlzY1MrR/3ULhTkX3AVAsnEk4nzx9WccrxANYToCOacQIkoyR55Ey6PT24jDgXv8lkbAHk1Qe1zjjgGqkazMG4iOyUUmeVkZDXeLoL18zSmpuALmcabmB97JykVyGJD2i1jdejw+CI/aJU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759046; c=relaxed/simple;
	bh=iAVrcQgAlTOajMXaaIIxmLEDamZVUcxxpJuLvgCQUGE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OaqSMJQmGR99xc1qzQG1DyF8SKALOJbIHhnnJ88AhazJ8rwh5HE8It9HDD0zE+Aj4vN1PQoLj4RXMu/vpHD09gn3L6GpaQRD2VeYDwFloEOoMDwW+CSJi9a8W9oMupmieEW251XAqblcyqnlUlo7uYSBqNQJ3nfQXMmIsx57+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841843a9970so25112239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732759043; x=1733363843;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2tXCmLrmSCl0ksU+eJ38wLC5oY4F1eN4t+KpoR05IA=;
        b=QOSKydrWNuIWClUJqiOWCNjJ36pHNXGekPaP2FprsRfMmmGxLG9TtPcFxZbf6kvEEZ
         6u4bEVpaSwBV69zkBBHGz05yWg4efI11RG5nNmVmu78DifA2v+ytum7lZbV2IZQ2Pm0g
         +HOhLJum+HPq1KucbIkISSjvHMKQD13UG66aw/0Xvigm96eAT5P5jYdulzjzLTDyOM2N
         3rP3anW5JA1QvT8qQcp+ADJ9th+LQ6KJMLwXVl+togl0KNsAKIQwyHZh7adBzAhJVhD/
         LW57alCI4ci9/v5CvYtIublOMInZLydcY1w9f2NGCJ5OEXKeWykwYy5MVjzF2ZDvLgFB
         PR5w==
X-Forwarded-Encrypted: i=1; AJvYcCV1nlFZKuIShIoMAZCqAhfy4D3n+EI3JPgC+c8uh3Bb1MJUPoqS3SfUfwaXCJloN6y2dnV2iUWxFRDKjIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZpaosQT73L9O9wmsvK9ySUbKHKtp7BlHyzCk/Dg7wWpM7gb4
	IY6XAbcXiCcE7lXK+q44miL3+wXRFZbC7W+w2jEZm3ujly6+dqfZtIj50Nhe5PFPVONVVNQSdDh
	lC5OjA911YFI4YyMIEI+UR173a1xQ+9ZW3usf4mYN2YPre7/zc7uRq14=
X-Google-Smtp-Source: AGHT+IGDqw7WgnYdk5D6tAW7YT74xX5xbJYKqTnlenf9RIgpgPz/CivP9CUkLawfFX8nH2LkNar3hyAuMKdtYNOPZqaa0bKIXTGr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a7:9736:501e with SMTP id
 e9e14a558f8ab-3a7c557d3afmr44988425ab.14.1732759043538; Wed, 27 Nov 2024
 17:57:23 -0800 (PST)
Date: Wed, 27 Nov 2024 17:57:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747ce03.050a0220.253251.0066.GAE@google.com>
Subject: [syzbot] [udf?] WARNING in udf_rmdir (2)
From: syzbot <syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=122c0778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=5df2d3fa14f2d3e49305
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b476e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162c0778580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d32a8e8c5aae/disk-228a1157.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/28d5c070092e/vmlinux-228a1157.xz
kernel image: https://storage.googleapis.com/syzbot-assets/45af4bfd9e8e/bzImage-228a1157.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b7209c2fe94f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com

UDF-fs: warning (device loop0): udf_rmdir: empty directory has nlink != 2 (0)
UDF-fs: warning (device loop0): udf_rmdir: empty directory has nlink != 2 (0)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5834 at fs/inode.c:407 drop_nlink+0xc4/0x110 fs/inode.c:407
Modules linked in:
CPU: 1 UID: 0 PID: 5834 Comm: syz-executor338 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:drop_nlink+0xc4/0x110 fs/inode.c:407
Code: bb 70 07 00 00 be 08 00 00 00 e8 27 d8 e5 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 9d 40 7e ff 90 <0f> 0b 90 eb 83 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 5c ff ff ff
RSP: 0018:ffffc90003f47ad0 EFLAGS: 00010293
RAX: ffffffff82170c43 RBX: 1ffff1100ed1c100 RCX: ffff88802d9c0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82170bc3 R09: 1ffff920007e8ed8
R10: dffffc0000000000 R11: fffff520007e8ed9 R12: ffff8880768e0800
R13: ffff8880768e07b8 R14: ffff8880768e07b8 R15: dffffc0000000000
FS:  000055556e49b380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000066c7e0 CR3: 000000003468a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2521 [inline]
 udf_rmdir+0x3b8/0x6f0 fs/udf/namei.c:520
 vfs_rmdir+0x3a3/0x510 fs/namei.c:4394
 do_rmdir+0x3b5/0x580 fs/namei.c:4453
 __do_sys_rmdir fs/namei.c:4472 [inline]
 __se_sys_rmdir fs/namei.c:4470 [inline]
 __x64_sys_rmdir+0x47/0x50 fs/namei.c:4470
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6beb678a39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffba3588d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 000000000000003d RCX: 00007f6beb678a39
RDX: 00007f6beb678a39 RSI: 00007f6beb678a39 RDI: 0000000020000000
RBP: 00007f6beb6ec610 R08: 00007fffba358aa8 R09: 00007fffba358aa8
R10: 00007fffba358aa8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffba358a98 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

