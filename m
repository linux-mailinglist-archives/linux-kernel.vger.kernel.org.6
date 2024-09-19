Return-Path: <linux-kernel+bounces-333660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28097CBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F23B20B54
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29F19FA8C;
	Thu, 19 Sep 2024 16:04:21 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143012E4A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726761860; cv=none; b=twEUAyq5sGf0cRUfaKi1h4Tbyr34CzF7GAM2qTCbNVS56+m9H5hyiCSUFJWvxQvEtV3Hi70lOhaVXaqbntsZXG1zwmLgu3u7CrgfDSsCHW15X7EYdJocO6YApEzbLyksHOhAI0O3cVrKigfjjeqlTkcJauyuSdcKYKmZKJQQu1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726761860; c=relaxed/simple;
	bh=oghDEmJMbkUFMDsV5uzXHkBcrTmkIAOK51Mr1BzLENQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GPE8QBmZ2U850Td8NN9EL/QPqaYTQN0p6UJenSH9mo6F/Oq5ulJtxXLcDxBLx4zgToInqBfo9CR9Xd9Vaa+9L+ReoPdXebbtEoFBym2hJYYMi9HW5Um9OYWBAf4KkDi6wjdxs+tmzgZBL8z6jeacqSvVkfkb6qlAGvtozkWNWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so14038955ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726761858; x=1727366658;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moODkLfxeH3Ela0pL2+4wISEbEj0GOPL//CoQYpM8l8=;
        b=iUDI0PZGTnYEUabNCMitXW02vUSkOFoPULT3OC3Jztx61un1LmooYLqlZuzyBqzPkl
         iQM72OwUvLl9AuVtIsW375Jo5HgyxIeqPoAFo9P0JSgLTMKrk9UcA8LRv5gxVZHeXVK+
         Cre9QIhYeIolm1V/j/5EA4wKDvT/JzmXNoTxcfNGlvyeFapHKgetU7Vh2JDJb611Hx2j
         YF1U7lzln732z+fA7AaNU3SPG629z+pm5DyZ/WeUim6WqVpEq2R+8yNzOXa4hvP5YY1o
         CffElrA3nQHM0J9V7V12lxSygWzDFfWgcmXgTf8jDAfC2B/ysErNLwYxBTVO+WU22VFQ
         r2fw==
X-Forwarded-Encrypted: i=1; AJvYcCWdW4jESe9ZpoHBRLAhUqwWx0OgN5sVp0pXrSD3OQWKlNne5JdUtP4B0LrLQilbG3WvJsfBcL4s4gkgc7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjdd0uGaIuIkiHaTFIdZJfZHTEpSnTpo1F0QPKgK7gAPD/JFl
	lEblDLCylwKU5wnHMfKmd3EcZFYCXDFgNXIvTt4rUcRCdFrj3E2ruOam/ne3wbYK9XeVRzJvYYY
	8WapcIaPh2Hj51rwDQGqqPnEZ5O8OQ4orjaCjOaw24IMc8ljDSVldDN0=
X-Google-Smtp-Source: AGHT+IGhROLuZJ976Wkfgl8lJFrhg7WGf4ViJpyFipCXPxLTDic6YrvvsMKE238+B1POXv3+2Aa6v/qVH1znyGp543cXOVm1UnH6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:3a0:a3cd:f239 with SMTP id
 e9e14a558f8ab-3a0a3cdf40emr159322295ab.8.1726761858013; Thu, 19 Sep 2024
 09:04:18 -0700 (PDT)
Date: Thu, 19 Sep 2024 09:04:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ec4b81.050a0220.29194.0034.GAE@google.com>
Subject: [syzbot] [jfs?] kernel BUG in txCommit
From: syzbot <syzbot+49e4cb6cf207d61b5afc@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ff9900580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=49e4cb6cf207d61b5afc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b879ea3b7dd4/disk-d42f7708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/812a7fb7bfcc/vmlinux-d42f7708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/806a22d4adbf/bzImage-d42f7708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49e4cb6cf207d61b5afc@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BUG at fs/jfs/jfs_txnmgr.c:2209 assert(mp->xflag & COMMIT_PAGE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:2209!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 6866 Comm: syz.0.200 Not tainted 6.11.0-rc7-syzkaller-00151-gd42f7708e27c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:txForce fs/jfs/jfs_txnmgr.c:2209 [inline]
RIP: 0010:txCommit+0x6b29/0x6b80 fs/jfs/jfs_txnmgr.c:1315
Code: 86 08 90 0f 0b e8 27 f7 6b fe 48 c7 c7 a0 05 23 8c 48 c7 c6 99 01 23 8c ba a1 08 00 00 48 c7 c1 a0 11 23 8c e8 68 84 86 08 90 <0f> 0b e8 10 84 89 08 e8 fb f6 6b fe 48 8b 7c 24 10 48 c7 c6 00 13
RSP: 0018:ffffc90002fbf560 EFLAGS: 00010246
RAX: 000000000000003f RBX: 0000000000000000 RCX: 0a4c9e0a19d3dd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90002fbf7d0 R08: ffffffff8174016c R09: 1ffff920005f7e4c
R10: dffffc0000000000 R11: fffff520005f7e4d R12: ffff888057cddc98
R13: 00000000000000bd R14: 0000000000000000 R15: ffffc90002852000
FS:  00007f0b40edb6c0(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000644ba000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 duplicateIXtree+0x33f/0x550 fs/jfs/jfs_imap.c:3019
 diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 diAllocAG+0x17dc/0x1e50 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d3/0x1760 fs/jfs/jfs_imap.c:1590
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xba0 fs/jfs/namei.c:225
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4210
 do_mkdirat+0x264/0x3a0 fs/namei.c:4233
 __do_sys_mkdir fs/namei.c:4253 [inline]
 __se_sys_mkdir fs/namei.c:4251 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4251
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b4017def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0b40edb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f0b40335f80 RCX: 00007f0b4017def9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000640
RBP: 00007f0b401f0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0b40335f80 R15: 00007ffd5b250568
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txForce fs/jfs/jfs_txnmgr.c:2209 [inline]
RIP: 0010:txCommit+0x6b29/0x6b80 fs/jfs/jfs_txnmgr.c:1315
Code: 86 08 90 0f 0b e8 27 f7 6b fe 48 c7 c7 a0 05 23 8c 48 c7 c6 99 01 23 8c ba a1 08 00 00 48 c7 c1 a0 11 23 8c e8 68 84 86 08 90 <0f> 0b e8 10 84 89 08 e8 fb f6 6b fe 48 8b 7c 24 10 48 c7 c6 00 13
RSP: 0018:ffffc90002fbf560 EFLAGS: 00010246
RAX: 000000000000003f RBX: 0000000000000000 RCX: 0a4c9e0a19d3dd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90002fbf7d0 R08: ffffffff8174016c R09: 1ffff920005f7e4c
R10: dffffc0000000000 R11: fffff520005f7e4d R12: ffff888057cddc98
R13: 00000000000000bd R14: 0000000000000000 R15: ffffc90002852000
FS:  00007f0b40edb6c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d4714cc080 CR3: 00000000644ba000 CR4: 00000000003506f0
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

