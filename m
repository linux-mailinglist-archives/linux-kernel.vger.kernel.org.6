Return-Path: <linux-kernel+bounces-253300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8B931F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 05:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF01E1F21D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07B612B72;
	Tue, 16 Jul 2024 03:25:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AAE101CA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721100324; cv=none; b=XpYaf+bsMMRVb7QUy4Ub4CzLrGrCv+k+PDGeC5IcudcKjPhnKCR6Sy376Hl06o05ArGEN1j7sMHk2ANxjdbzToljse2XiUIJJO2FLAuNprtDPDMar8GgIPFCFiUGBlZbqSfEpci5hVKGB3tjj51GxbA4gvTa7l2gF9TO7aqvnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721100324; c=relaxed/simple;
	bh=McTQGGvwmihi2Iz8fCq5AfY7xst6dkZrJJzfw7rzDW0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CjFm9efAxAhFCLMj07woxTpiaj6+LIerCcY7JUhlSsgy9F6MhPYhFLxEaaplJkXS6649gfet4XtLrqdYBVnB2fKk4QsTsONg6QsvZvJj8r1FZr1AtE1d/3bp+j+leeKA2rkAY/+mf1M/KX7Ju6jBvBwRch/fDUFF9TDl5UhlrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so641927739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721100321; x=1721705121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fz83GFOq5KzFlCswA7Bbze2t4hktP5KYwhx+++WwIVY=;
        b=Nb2gG3ZImSS2+4/l4MzIiE+XxmcTOi63IQ7do7s1mLzem+PiaJ6YhTLd57lapSK2Yr
         ISS+oZu8yMDk3yCf1WJUB2EwvrViH5w5fotm5HwZBYZBqftXgxNzst7PDxJgM7f5tqRX
         v3QDK9tL6/tnCMc6Hn5KgHXjUyFYRKtwEF8P/OKIaXnTRzr5OotH+ZSVxasoNrjeWNx+
         jUQsuJXHniLwEo0BBiFlDec0n3rHnRYWKQfv1bmAVQIMzYMOoC6agvQm7yN5jrbDhQ3a
         CFHYKiWqbmMLCOtuCcLHHJ3+S8LU7sgKiINZigCeTpiOD5rqq/YinR52KGNRjfHXJFgu
         icdA==
X-Forwarded-Encrypted: i=1; AJvYcCVlnOeeHPMRfvBb5RBJBAypjWcujv2s2fD7T+R1OsiPE6Fb13se2/iB+rXSZ7+/qHgILS8ogIBX10FA6Ze8G1TfeMMjbJT/Iitg/DdE
X-Gm-Message-State: AOJu0Yw3/pHQ6J1D9VA49b+l5X1m7hXF81/OxV0S5oVqOLe1rEJ+nerS
	CooA70DtyPVkgVm6fojIEPaLLJVECL5OkDm30+PHtSSS/324U4cwdgySWYdETq9GJWy7J5H//3D
	DFqCaz1Jo2HQZhQr6uAFldApv6NDbGDoOdgU9VlGFrxRQM092gGjz7f8=
X-Google-Smtp-Source: AGHT+IHceahWAYGa46JuyGj8INeCjgtiXahPf3RtU2b2/wJWQZ34rEUGRdqtiC0GIAMKWYwj1PU9kQ9v9DIkHCj9Xf7xZgac18WN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-393d3e3981cmr777885ab.6.1721100321564; Mon, 15 Jul 2024
 20:25:21 -0700 (PDT)
Date: Mon, 15 Jul 2024 20:25:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a3a2e061d54e592@google.com>
Subject: [syzbot] [bcachefs?] general protection fault in bch2_opts_apply
From: syzbot <syzbot+c55b814203b2ecab10bb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5e0497553643 Merge branch 'link_path_walk'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d2e3e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=283288d3d08ee56f
dashboard link: https://syzkaller.appspot.com/bug?extid=c55b814203b2ecab10bb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bd24b5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/261c3e7d5786/disk-5e049755.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8c2016ade71/vmlinux-5e049755.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a12469ba78b6/bzImage-5e049755.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/63c33ff217d1/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/6fd311b2dd60/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c55b814203b2ecab10bb@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc00000000ea: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000750-0x0000000000000757]
CPU: 0 PID: 5957 Comm: syz.0.90 Not tainted 6.10.0-syzkaller-00017-g5e0497553643 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:bch2_opts_apply+0x175/0x4710 fs/bcachefs/opts.c:179
Code: c0 0f 85 88 28 00 00 44 89 3b 48 8d 5c 24 40 41 f6 c6 04 0f 84 5d 19 00 00 e8 b7 23 5d fd 4d 8d 7c 24 08 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 75 28 00 00 4c 89 f8 48 c1 e8 03 42 0f
RSP: 0018:ffffc900032d7820 EFLAGS: 00010212
RAX: 00000000000000ea RBX: ffffc900032d7860 RCX: ffff88802046da00
RDX: 0000000000000000 RSI: ffffc900032d7a40 RDI: ffffc900032d7900
RBP: ffffc900032d7990 R08: ffffffff8427ea52 R09: 1ffffffff1f5b2ad
R10: dffffc0000000000 R11: fffffbfff1f5b2ae R12: 0000000000000751
R13: dffffc0000000000 R14: 0080000000000004 R15: 0000000000000759
FS:  000055557be6c500(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0c3ffff000 CR3: 000000002bf8e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 bch2_mount+0x774/0x13c0 fs/bcachefs/fs.c:1946
 legacy_get_tree+0xf0/0x190 fs/fs_context.c:662
 vfs_get_tree+0x92/0x2a0 fs/super.c:1789
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1cb79772da
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0b6bb668 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff0b6bb6f0 RCX: 00007f1cb79772da
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007fff0b6bb6b0
RBP: 0000000020000000 R08: 00007fff0b6bb6f0 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000000246 R12: 0000000020000040
R13: 00007fff0b6bb6b0 R14: 0000000000005ba5 R15: 00000000200000c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_opts_apply+0x175/0x4710 fs/bcachefs/opts.c:179
Code: c0 0f 85 88 28 00 00 44 89 3b 48 8d 5c 24 40 41 f6 c6 04 0f 84 5d 19 00 00 e8 b7 23 5d fd 4d 8d 7c 24 08 4c 89 e0 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 75 28 00 00 4c 89 f8 48 c1 e8 03 42 0f
RSP: 0018:ffffc900032d7820 EFLAGS: 00010212
RAX: 00000000000000ea RBX: ffffc900032d7860 RCX: ffff88802046da00
RDX: 0000000000000000 RSI: ffffc900032d7a40 RDI: ffffc900032d7900
RBP: ffffc900032d7990 R08: ffffffff8427ea52 R09: 1ffffffff1f5b2ad
R10: dffffc0000000000 R11: fffffbfff1f5b2ae R12: 0000000000000751
R13: dffffc0000000000 R14: 0080000000000004 R15: 0000000000000759
FS:  000055557be6c500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff710d25000 CR3: 000000002bf8e000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	c0 0f 85             	rorb   $0x85,(%rdi)
   3:	88 28                	mov    %ch,(%rax)
   5:	00 00                	add    %al,(%rax)
   7:	44 89 3b             	mov    %r15d,(%rbx)
   a:	48 8d 5c 24 40       	lea    0x40(%rsp),%rbx
   f:	41 f6 c6 04          	test   $0x4,%r14b
  13:	0f 84 5d 19 00 00    	je     0x1976
  19:	e8 b7 23 5d fd       	call   0xfd5d23d5
  1e:	4d 8d 7c 24 08       	lea    0x8(%r12),%r15
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 75 28 00 00    	jne    0x28ac
  37:	4c 89 f8             	mov    %r15,%rax
  3a:	48 c1 e8 03          	shr    $0x3,%rax
  3e:	42                   	rex.X
  3f:	0f                   	.byte 0xf


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

