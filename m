Return-Path: <linux-kernel+bounces-340806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D4987817
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854A7287462
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575115B963;
	Thu, 26 Sep 2024 17:02:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875915C133
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370150; cv=none; b=NuFA14UQQMs4khFzbGszkCt1o5YISTYOYUmYy1CfBPEJG8kvoWOCGp8ZTauNS6mwC9D3JzpiR5ujao0XYzKr6aLhaoEwi7cJEMCtSnYVUagCNSSbpRI0gnOwK3YUN6xucjceFVWMu90QjpTVMiquT/J3eD71qKNsyWOXymdyJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370150; c=relaxed/simple;
	bh=amLeIUzDg6N5z6TPUjRHXlC09XUEc8rBprxd8yz95nw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jTIOCfMAEH7eeKbyKxr3GIEAORDWOBzyFkeoJcY11pksS9/20VaaVd0mgQaEl7HUXMpnY5gqizNLrkRHrJeay5fNec0B9E3VoJE7eum/hh6Pg8995gqqbhTS9yTSenI/E9AlJ+sdI9BsY8+fkRzZVsLcoYm4/2KDnO2IpuO4eSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso12272375ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727370148; x=1727974948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7JKBVvQkVjew4Fq/HTsPxuf4+ylReuYaw+UJwkB/x3E=;
        b=RY/HFUtAQRAI/xatRAwC96d/p+tNt2evcjbBdMEVnXk7Spjg+XaOhPwEvD3bOsVC9G
         8RDh1pG6LexMknzwncbB3ntlo9KOtF5FyFFNbuclJ+oJtC+p6tabtMLoafLm8ikOV88T
         NpRtXaGhQmrfLO64QTltdGy7u6BijHK2qJfquhLHR+O5X0BYMVcaPP2K/qH7CKUYm67q
         h/IC3nT2xyw7U9WBYFrRV8mkqzV/7qV7kn+ar4D0DySJ6r6GVLmzN/EwUbFWES2OgU+2
         IdcW7cpiYX486iMcuahozIqHowTZG09cG+wiIhcvL3oA2kenV+8qr3SNlPXmifVNQ/R4
         TmjA==
X-Forwarded-Encrypted: i=1; AJvYcCVmibnzG9bXnVTOjJC/1QF6mT32tEylKgxHhPu266Wk7Oflm/qasjEuE6YfT3tFHMM9guiTR75MICWAkj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzZ4+TucLSktJcYcScsURE8Hpsc9WOEgcRjppqyBdweeXF//Y
	zm5oIqail/O/j9gAu0eC/LlpxnMHuaiMBe31+M7VK5VAbY/cdVMksa9ksy6P3g8bDjWDCgA4B8X
	IWaOlS8p8wviDGQTYfD2WhQGKg6j2SUVLxo0/k41B8p4seQEPqH0u1SY=
X-Google-Smtp-Source: AGHT+IEfChCIvJD17g0HNjWVF24uw4Z/2wNdAl7dth1DT/ECx0gJENK2vMZYi0Y59xa7ozb2Jgm5O+aJJG7L2OxI9TTB9H0DS08s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c29:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a3452bdca2mr657025ab.23.1727370147773; Thu, 26 Sep 2024
 10:02:27 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:02:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f593a3.050a0220.211276.0079.GAE@google.com>
Subject: [syzbot] [overlayfs?] general protection fault in ovl_llseek
From: syzbot <syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11a299a7933e Merge tag 'for-6.12/block-20240925' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1549da80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25e41eb82fab6c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=d9efec94dcbfa0de1c07
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1349da80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15870507980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-11a299a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b59f47d0c0da/vmlinux-11a299a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf395abcfb64/bzImage-11a299a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com

RBP: 0000000000000001 R08: 00007fff0dcc56f7 R09: 00000000000000a0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000022: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000110-0x0000000000000117]
CPU: 0 UID: 0 PID: 5106 Comm: syz-executor776 Not tainted 6.11.0-syzkaller-10669-g11a299a7933e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ovl_llseek+0x2a4/0x3f0 fs/overlayfs/file.c:214
Code: 8d 7c 24 60 e8 ad db e0 fe 48 8b 44 24 60 48 89 44 24 30 48 83 e0 fc 48 89 44 24 20 4c 8d b0 20 01 00 00 4d 89 f7 49 c1 ef 03 <43> 80 3c 27 00 74 08 4c 89 f7 e8 6d dc e0 fe 49 89 1e 48 8b 1c 24
RSP: 0018:ffffc90002d6fe00 EFLAGS: 00010207
RAX: fffffffffffffff4 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8c610080 RDI: 0000000000000001
RBP: ffffc90002d6fec8 R08: ffffffff901ce56f R09: 1ffffffff2039cad
R10: dffffc0000000000 R11: fffffbfff2039cae R12: dffffc0000000000
R13: 1ffff11007b2e7ac R14: 0000000000000114 R15: 0000000000000022
FS:  0000555590dd5380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcababb3226 CR3: 000000004186a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_llseek fs/read_write.c:382 [inline]
 ksys_lseek fs/read_write.c:395 [inline]
 __do_sys_lseek fs/read_write.c:406 [inline]
 __se_sys_lseek fs/read_write.c:404 [inline]
 __x64_sys_lseek+0x150/0x1e0 fs/read_write.c:404
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcabab5d8e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0dcc5958 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 00007fff0dcc5970 RCX: 00007fcabab5d8e9
RDX: 0000000000000000 RSI: 0000000000010000 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00007fff0dcc56f7 R09: 00000000000000a0
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ovl_llseek+0x2a4/0x3f0 fs/overlayfs/file.c:214
Code: 8d 7c 24 60 e8 ad db e0 fe 48 8b 44 24 60 48 89 44 24 30 48 83 e0 fc 48 89 44 24 20 4c 8d b0 20 01 00 00 4d 89 f7 49 c1 ef 03 <43> 80 3c 27 00 74 08 4c 89 f7 e8 6d dc e0 fe 49 89 1e 48 8b 1c 24
RSP: 0018:ffffc90002d6fe00 EFLAGS: 00010207
RAX: fffffffffffffff4 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8c610080 RDI: 0000000000000001
RBP: ffffc90002d6fec8 R08: ffffffff901ce56f R09: 1ffffffff2039cad
R10: dffffc0000000000 R11: fffffbfff2039cae R12: dffffc0000000000
R13: 1ffff11007b2e7ac R14: 0000000000000114 R15: 0000000000000022
FS:  0000555590dd5380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcababb3226 CR3: 000000004186a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 7c 24 60          	lea    0x60(%rsp),%edi
   4:	e8 ad db e0 fe       	call   0xfee0dbb6
   9:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
   e:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  13:	48 83 e0 fc          	and    $0xfffffffffffffffc,%rax
  17:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  1c:	4c 8d b0 20 01 00 00 	lea    0x120(%rax),%r14
  23:	4d 89 f7             	mov    %r14,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	43 80 3c 27 00       	cmpb   $0x0,(%r15,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 6d dc e0 fe       	call   0xfee0dca6
  39:	49 89 1e             	mov    %rbx,(%r14)
  3c:	48 8b 1c 24          	mov    (%rsp),%rbx


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

