Return-Path: <linux-kernel+bounces-420925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632179D8471
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72411641CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2BC199E9A;
	Mon, 25 Nov 2024 11:27:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A59199924
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534049; cv=none; b=I93qdF8ZUgeAPDgZ7tXdOfUcolp/XXEcBjlGMTNiHkm5Ysi00QnRZopBbIY8SBjYVI3O4R6VejSLkcTXDfAR+MX5FwURAoYkOIueiknMnK9qHC4dLdBr5NG3Rin91cl2/iCm8OrwvnWYEK+s8HaQFhsRtpSkeqYKLFJAT+CKdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534049; c=relaxed/simple;
	bh=A0jxxElq1VIPyp8/H7ELYFoNVxIc2DKqcvYgx3CeaB0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ve0P1WiBPl4AdlWz6JRU8AXMy3+JjSf0BvrJ++7mOgwZWazG5n+yYg2umh/UrpAhG9Gie5oiXWE9P56Be9puH1XEKCDzqS57r8vkuDu/3XZ42RQl0ymPekbXnrxLCf2Gq2/VvcR9y0N7ImCdc3XWeByLHjI874v9mY2J8QYS/ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a78c40fa96so44231735ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534045; x=1733138845;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOYx4bcTfS5I55qpkWkBm/KlHHH9B5MVZmhVuSvCBKs=;
        b=hmR5XzqcATPkZtKJc6PnjVWVOms90U0+hPEBcEj6ybDaT5yFSTuWa4xOfnUOGVFBwb
         a3gu/bIl0Nq6iUvbK1tk+r/KATQw4o2aMqHPASwKKMgzk4kh4Bd+HU+sirXzdLYgzrYt
         jpcf89L4EtiyiCpHvb9mLaG6gV81HvALQdQPzgP2pqazxXWHeu03xmlaKXL4UQJPTMav
         ZvYf9JD26fXZ/kwQgcE876hJooBk6lVgWJjyeDSDZqey3feOgULv5uTq/9Qyqynk1kBN
         YdRxIx+JIJRtvPkk7/eni446USALLlmk6wXkKySsMKVpNA7/Fl7iBi13uD6QRK0rVuwx
         Gqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVLn88ZDZUNiudnlbYoI1QCGOCzAJnKB8keMS3RwY9PoYPiYUK54YjtzPMLu8qMkMNMWvapI8ZvIsXHxbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoN5+UpEl3OwX47eZMoNFZSGypwi++vBw1JM/PZaD/oD4jpwUR
	yeNBC/mkJPO6UPliE4pKZ+eggd5q+5JbUhr2JtxfK6Z/MTlU7gZG/MZvrOn5f9sCLaDJNUM9Tg9
	3t8km7ETdqfEXJs5CjLWg11qOIvkiLPHgBK5ckLQ8okJukmZWhqXKoLQ=
X-Google-Smtp-Source: AGHT+IFezIN6xbqL+rw4RsiljB/FgKU4cxeXJhkmX9K8fvHe18MVoInO+sZ3Y0IVcnmN4/JDb5dttBEAjTj5DMJIKfIfrE3wdl8n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2141:b0:3a7:2194:fd3d with SMTP id
 e9e14a558f8ab-3a79aead6bemr97462325ab.14.1732534045237; Mon, 25 Nov 2024
 03:27:25 -0800 (PST)
Date: Mon, 25 Nov 2024 03:27:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67445f1d.050a0220.1cc393.0077.GAE@google.com>
Subject: [syzbot] [jfs?] kernel BUG in dbAdjCtl
From: syzbot <syzbot+c745704df615dc63086f@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7c8b88bda4 Merge tag 'sched_ext-for-6.13' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=118a0ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48190c1cdf985419
dashboard link: https://syzkaller.appspot.com/bug?extid=c745704df615dc63086f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-8f7c8b88.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5e6fdef85e9/vmlinux-8f7c8b88.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67596a080582/bzImage-8f7c8b88.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c745704df615dc63086f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BUG at fs/jfs/jfs_dmap.c:2591 assert(level == bmp->db_maxlevel)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:2591!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-01892-g8f7c8b88bda4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:dbAdjCtl+0x9be/0x9c0 fs/jfs/jfs_dmap.c:2591
Code: e9 d7 fc ff ff e8 a2 8a 67 fe 48 c7 c7 80 48 43 8c 48 c7 c6 c0 45 43 8c ba 1f 0a 00 00 48 c7 c1 a0 4e 43 8c e8 b3 84 99 08 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41
RSP: 0018:ffffc9000d16f018 EFLAGS: 00010246
RAX: 000000000000003f RBX: 000000000000000a RCX: 1cf809a453080c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000ff000000 R08: ffffffff8174ce2c R09: 1ffff92001a2dda0
R10: dffffc0000000000 R11: fffff52001a2dda1 R12: 0000000000000000
R13: ffff88803ae98166 R14: 0000000000000004 R15: 1ffff110084e2089
FS:  00007f48802f96c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2ee4f95ed8 CR3: 0000000043526000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dbAllocDmap fs/jfs/jfs_dmap.c:2044 [inline]
 dbAllocDmapLev+0x29c/0x4a0 fs/jfs/jfs_dmap.c:1988
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1825
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbAlloc+0x658/0xca0 fs/jfs/jfs_dmap.c:888
 diNewIAG fs/jfs/jfs_imap.c:2510 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 diAllocAG+0xa9d/0x1e50 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d2/0x1630 fs/jfs/jfs_imap.c:1590
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_create+0x1be/0xbb0 fs/jfs/namei.c:92
 lookup_open fs/namei.c:3649 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1398
 do_sys_open fs/open.c:1413 [inline]
 __do_sys_creat fs/open.c:1491 [inline]
 __se_sys_creat fs/open.c:1485 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1485
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f487f57e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f48802f9038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f487f735fa0 RCX: 00007f487f57e819
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000e00
RBP: 00007f487f5f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f487f735fa0 R15: 00007ffc9590be38
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbAdjCtl+0x9be/0x9c0 fs/jfs/jfs_dmap.c:2591
Code: e9 d7 fc ff ff e8 a2 8a 67 fe 48 c7 c7 80 48 43 8c 48 c7 c6 c0 45 43 8c ba 1f 0a 00 00 48 c7 c1 a0 4e 43 8c e8 b3 84 99 08 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41
RSP: 0018:ffffc9000d16f018 EFLAGS: 00010246
RAX: 000000000000003f RBX: 000000000000000a RCX: 1cf809a453080c00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 00000000ff000000 R08: ffffffff8174ce2c R09: 1ffff92001a2dda0
R10: dffffc0000000000 R11: fffff52001a2dda1 R12: 0000000000000000
R13: ffff88803ae98166 R14: 0000000000000004 R15: 1ffff110084e2089
FS:  00007f48802f96c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f48802b6fe0 CR3: 0000000043526000 CR4: 0000000000352ef0
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

