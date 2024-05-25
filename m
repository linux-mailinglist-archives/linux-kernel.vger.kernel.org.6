Return-Path: <linux-kernel+bounces-189568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC68CF211
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471C3B2129F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B385E12F59D;
	Sat, 25 May 2024 23:09:23 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313512F379
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678563; cv=none; b=GN7CwD5G3g7h6Z+sZ7MjASCrzLvvHj1p7zqGVYO72AEqzEbfPuXfDa0mmQeSJT0gipI1McakRPoOsKbwYyERYJ7FLCOjs3DdNVbDk+fxkixsgidIwpUmE43WFaMYTqtMgVECzbBZnC+UzwkEGDCSW4+y2l/FblrgJzc4NvxRJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678563; c=relaxed/simple;
	bh=P9Ju22vDo4ehK2fg74jr8wilBGvJpTWtCODrWF5yXbM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L1Dxzi6nNm+1YNeGlD/vJ2DORPKC0LoUnHPLXaKOaeqVByvb8GRwZG+LxUZMPWqZXVRJTZZKh+qNua0sfXv4Domaf0e1/dFYLwqFKYmJ5hU0q2m7taOoqvLHUiw444rccftvLDmtCPkWzkrdjswsLtaevhEETVJ9KQ/N0opBt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e25de500d2so436370439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 16:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716678561; x=1717283361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXvm1BRPoDDQ1PtVnmKGKMJFHmcEADNxdlulxvcnIsQ=;
        b=UnrpDNFhOKwgvSvrGxaFYz+rzo/9K2qTMJVl4E9Ms4Erblo60xkjGJk8cUUnCHPa9V
         6/Z1ZoUR35l4G7/p87hajEuBJt0NJcyy/kICyOG7nMmZCvBWsp0ptZ4tv2g1doSZS1UM
         Lz+1gU5w8B+TfcLnncRAlgITsbwn95I2txklPK3nZp05tQphDgrgsGfSyTUvqthKefSx
         3Cu5752x6gYa3Ty1YDwW4Mnop3SoKXbOQqxpJGIN0Z3eChSbcuR/2XVeQfFgkEGEiAII
         6BJqSTkwEjNfauq5EyaL4QLIW5l211YnzHjORLv9PSL80/6beXIX1sOd9mselQl0Wkt1
         CRYw==
X-Forwarded-Encrypted: i=1; AJvYcCW3UAxXZLTdWVTAc7OINbB7nR3nTAwqLOdSKCtEnEU3SKKZanppm1tQH3AEUYTBoj4s6q1bQr55GNAGLQQ72dmZa2mhyfTaL3krHX79
X-Gm-Message-State: AOJu0YyMoRwFWGeobzetcQgL6fYBBzgQrQS0uHDwdSVsdpIEizY0n0+H
	UgVTOS2+CW4TK+/mxcNOPuQ0vkBESO/IIJTeuifZVffy4gHHn19rFh7SdLFggXEX0/c6FNFVWUk
	V6xTQ5D6DnuYIem63tvWtzjDQ5Fi9rYSs2yiuyJEJieXSh4E4UTISz9A=
X-Google-Smtp-Source: AGHT+IE1QwqyM/Xe95598eJ4YD/14LIpTGT3SBzPrORWFCdO4v3X14qSGTQnRm0QVA6aPL6K+eb/V34QRlpY4NarMIRpXwdPHoB8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14cb:b0:7de:e175:fd2d with SMTP id
 ca18e2360f4ac-7e8c75d4c18mr26200539f.3.1716678560487; Sat, 25 May 2024
 16:09:20 -0700 (PDT)
Date: Sat, 25 May 2024 16:09:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cab78606194f5fcc@google.com>
Subject: [syzbot] [jfs?] kernel BUG in txUpdateMap
From: syzbot <syzbot+0a8a0b1abad0363db585@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e3042980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
dashboard link: https://syzkaller.appspot.com/bug?extid=0a8a0b1abad0363db585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a8a0b1abad0363db585@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_txnmgr.c:2340 assert(mp->nohomeok == 1)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:2340!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 PID: 133 Comm: jfsCommit Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:txUpdateMap+0xc8b/0xd20 fs/jfs/jfs_txnmgr.c:2340
Code: e9 5c f9 ff ff e8 d5 fd 82 fe 48 c7 c1 00 f4 6a 8b ba 24 09 00 00 48 c7 c6 80 e7 6a 8b 48 c7 c7 c0 e7 6a 8b e8 c6 9d 63 fe 90 <0f> 0b 48 89 df e8 7b 32 e0 fe e9 e1 f8 ff ff e8 31 33 e0 fe e9 a8
RSP: 0000:ffffc900020c7ce0 EFLAGS: 00010286
RAX: 0000000000000039 RBX: ffff88805f267580 RCX: ffffffff816f3519
RDX: 0000000000000000 RSI: ffffffff816fc096 RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffc900022ea120
R13: 0000000000000001 R14: ffffc900022ea124 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76f6e2f760 CR3: 00000000294c0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x5e6/0xb20 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txUpdateMap+0xc8b/0xd20 fs/jfs/jfs_txnmgr.c:2340
Code: e9 5c f9 ff ff e8 d5 fd 82 fe 48 c7 c1 00 f4 6a 8b ba 24 09 00 00 48 c7 c6 80 e7 6a 8b 48 c7 c7 c0 e7 6a 8b e8 c6 9d 63 fe 90 <0f> 0b 48 89 df e8 7b 32 e0 fe e9 e1 f8 ff ff e8 31 33 e0 fe e9 a8
RSP: 0000:ffffc900020c7ce0 EFLAGS: 00010286
RAX: 0000000000000039 RBX: ffff88805f267580 RCX: ffffffff816f3519
RDX: 0000000000000000 RSI: ffffffff816fc096 RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffc900022ea120
R13: 0000000000000001 R14: ffffc900022ea124 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88802c100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7a37f24488 CR3: 00000000294c0000 CR4: 0000000000350ef0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

