Return-Path: <linux-kernel+bounces-386256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0339B4108
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DC11C220FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A819596F;
	Tue, 29 Oct 2024 03:31:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676EB4400
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172683; cv=none; b=cEys75lJdxFBlCBF4ORlpeTzsQNML2YafdMHpppoJZCyq54JiOcysQlPqKQIQWO7n0A5u/QTCHQ5b4q2K7dnnaYvnekFSmP4g2rmrRQEIXmc0h/3kxmwc788oYELxev7knI4p9024CAaMBzo7APBfvo3MzzM8rWRziwIfc4oqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172683; c=relaxed/simple;
	bh=qTh3TJGjDisf+V8zPoYlc8UR524O2Is9wDgz0Sivj14=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=A2AyjJmWZMFrY1nicgYnDKtXr/WfaP1e/hkgwBZXKXM8ZSjDacvrgJX1e5Xo9MQV0z9gr6LNEfzBKU7cY/t98WQIAFp8UlfFA/pedv3ycCfCqqJFrFd0EiWhU0fX+GLHnbeHkOEpaVEuQTEp7nC967oidy7pzNFT6wBtMkP49PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so33264415ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730172680; x=1730777480;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZE3hyQFUkAcdihpPY+ypx7X3R/oZ84jSCqjpg2p/Nk=;
        b=ZkgAfBJ0OBJ8jc93UC+xLghDisv8WrO3BswHs04Uv+Us7+bW9ic2ievVvVTPTZvej+
         pXiYE6upp2QUMTubfkr8Hx/HHjDGHsi9NrgDhv4/7L8/qVSXdxQGOo478sujHJql0znh
         jHnFoWWMAQ4RqdPAWZmKLbYOMastJUwHag44rXok1Wx5o5dp5qaMS6lCWpvDjTHEP4Xb
         DjVSP7ZOF1Grv84pL57nBU6Z04b3iLmFB/i8uoycU9l8PtrNNEUnh33vP6ZwMhmeExp3
         iPU+5FpreD1zBpyc+feun370Zn9wkurH3/Cvt/xVZWkXOPcSSNM1ncbIJMnOAw8zAetX
         VA2A==
X-Forwarded-Encrypted: i=1; AJvYcCXI+iXz6oNFZAreLYbIH6/Ewl8jErOVPmvG+BqIUg48HK+BTYTt4MRVmoRVHrBWgj8c+CyIOFoMlkmAw4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/0Z+rCvHsd0NeoETlRxIN23hJ4kwwjXZt2IkUM6D/WYbyyMw
	Uc+wywDiStFAo77FDj87Vssg/qVb6tg9mTwAp8lmMSKVYjuHTdC6R+jcdWP7JrGTJFjLjXseCjQ
	gCFmRfIAzlYvnf3bmBHBJJtzm8ynOsQbIPaH3/n/LNwNmf1Rz8UUEDDo=
X-Google-Smtp-Source: AGHT+IG3uQkjG0J2R+v2GRCheC/NSj6vCCb5O4HNLHdEjcbab58yGipW7XHrUlyYvf6xRkEj0Oi2Z2q2OqQBNm9A1+iXrgI5LLh7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c8:b0:3a3:35f0:4c19 with SMTP id
 e9e14a558f8ab-3a4ed305301mr90438845ab.21.1730172680501; Mon, 28 Oct 2024
 20:31:20 -0700 (PDT)
Date: Mon, 28 Oct 2024 20:31:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67205708.050a0220.11b624.04bc.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in zap_huge_pmd
From: syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fb2ebb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f730e7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177eae40580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com

R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/huge_memory.c:2085!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5095 Comm: syz-executor380 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
Code: fe ff ff f3 0f 1e fa e8 ab 16 92 ff 48 89 df 4c 89 fe e8 50 ba 08 00 e9 2c f8 ff ff e8 96 16 92 ff 90 0f 0b e8 8e 16 92 ff 90 <0f> 0b e8 86 16 92 ff 4c 89 ef 48 c7 c6 20 65 17 8c e8 37 a2 dd ff
RSP: 0018:ffffc9000aeef1e0 EFLAGS: 00010293
RAX: ffffffff8202c152 RBX: 000000000000001e RCX: ffff888000b70000
RDX: 0000000000000000 RSI: 000000000000001f RDI: 000000000000001a
RBP: 000000000000001f R08: ffffffff8202bca6 R09: 1ffff11008416106
R10: dffffc0000000000 R11: ffffed1008416107 R12: 0000000000000000
R13: ffffc9000aeef750 R14: 0000000020e00000 R15: fffffffffffffa00
FS:  000055555711b380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e22940b470 CR3: 000000003daee000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 zap_pmd_range mm/memory.c:1719 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x762/0x40e0 mm/memory.c:1810
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1900
 unmap_region+0x214/0x380 mm/vma.c:354
 mmap_region+0x23fa/0x2a30 mm/mmap.c:1583
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f33ed6f19e9
Code: 48 83 c4 28 c3 e8 c7 1b 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc77c44b78 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffc77c44be0 RCX: 00007f33ed6f19e9
RDX: 0000000002000007 RSI: 0000000000c00000 RDI: 0000000020400000
RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000000
R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
Code: fe ff ff f3 0f 1e fa e8 ab 16 92 ff 48 89 df 4c 89 fe e8 50 ba 08 00 e9 2c f8 ff ff e8 96 16 92 ff 90 0f 0b e8 8e 16 92 ff 90 <0f> 0b e8 86 16 92 ff 4c 89 ef 48 c7 c6 20 65 17 8c e8 37 a2 dd ff
RSP: 0018:ffffc9000aeef1e0 EFLAGS: 00010293
RAX: ffffffff8202c152 RBX: 000000000000001e RCX: ffff888000b70000
RDX: 0000000000000000 RSI: 000000000000001f RDI: 000000000000001a
RBP: 000000000000001f R08: ffffffff8202bca6 R09: 1ffff11008416106
R10: dffffc0000000000 R11: ffffed1008416107 R12: 0000000000000000
R13: ffffc9000aeef750 R14: 0000000020e00000 R15: fffffffffffffa00
FS:  000055555711b380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e22940b470 CR3: 000000003daee000 CR4: 0000000000352ef0
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

