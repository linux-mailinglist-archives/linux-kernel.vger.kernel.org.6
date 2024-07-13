Return-Path: <linux-kernel+bounces-251362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD093040D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 08:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEA31C22B65
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A091CD37;
	Sat, 13 Jul 2024 06:10:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71518C05
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720851036; cv=none; b=GQ00GIpWtlhLkkdoGaztBcFBU/GG6x+xWVi33chlIOtk7s6O/vcwLzFkUjzkDviMnBsINuySqod7gBgD4F+qvJdcYFO4UIbuepr758g+Fvay7fMyAvkyw3x8GHNkIXwNxHzQN9jDCpMsv37Lpi2VLG6+UKgvD0c0XroBJr6AC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720851036; c=relaxed/simple;
	bh=//Gx0eRTHfbsYOIcOX5iTIihCHS53wGkIxDuxMWeR64=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X8/wfQhuPlfOcfnUSubhWn9Ap7aZgxHAY1ppGjLiv0GrqeIzLd8JC1ztWbiB2epptydDEC1Z8xwEpLSypyMG7EVnVfiLLpBtN7sEWVw99fAz88A6B4FFfnUvwEbtyeV+wGuZY06F3+jrqUPzssojj4y+kO+ZjYwh59HxgyZnrTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8045e14c387so383874439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720851034; x=1721455834;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/xcOxLv9h5YFu28epzWTRp9SdPn0Fy/RZPAlzEmD/8=;
        b=RLMljaOZXk8Bj95dSseem/xihRs8R5Y4/Phkx1PC5MvdGoDKzrmZgh1SU02+8Ll+28
         zJZM325IUl6NJ3V6ndR59IUKdsB+y1xqhMSKxa9HMNgXCNuxYyY/CJnX05FCUVY6MmAl
         z40frNz7o0au54QBS+ERaKeQjKsB+RPAJwyl3eSofG5+Tm6x7EquEJ/qPv0ZFCXh3qF3
         3zg3m22DRXL0ec6yrQ+mQFEdVPGPmRhrJ4h56X+QErjXPAc4xQ28d3/zv5fC3EwMEDyz
         bVcXfB7qA3OeUnewzEijxTkWPChCnj9O5gz0tmx1xWTAC/B82RNJ+SyzlWO5gR8W8uXJ
         zLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyxYP5Eny2cRIYJJo3hOdAB+LMjshe4iOU6wVzL8Z04ZEC/pzPlO4RkIf2u4M6zBJG4KcH+W4DSdY/VjzbLJdI8XCs9MI5qxOoaJAI
X-Gm-Message-State: AOJu0Yw7S/ZJ1nKdZRDYq+wzt3wlT3hpPb4P7Aq30jN/cQyV/ofWBNDB
	J4v6EtZwTZQ8T8LGw0248NnkdpU4EXtsuvtvBxyPugdvPXw5NAINYiHcyOt9Ysc5trPrdyjNMJA
	7K2K7tz6M7R/FBF2iSbCkfBQqrnRb/Lnk/EPnmpcQFZGxijqYmTg2hCo=
X-Google-Smtp-Source: AGHT+IHLgTmJs0cp2rWDr7sR5vOnNhHlV9IvrJlpgxwGl77BztMLIwNnH/heVLjFMhK29QtCZBac0iQJhEjvt9U5XnW0DoTtbwya
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de7:b0:381:fb2:70ad with SMTP id
 e9e14a558f8ab-38a596ca51fmr1898795ab.3.1720851034160; Fri, 12 Jul 2024
 23:10:34 -0700 (PDT)
Date: Fri, 12 Jul 2024 23:10:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a502f061d1ada4d@google.com>
Subject: [syzbot] [ntfs3?] general protection fault in run_is_mapped_full
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=164b99dd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=9af29acd8f27fbce94bc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15edf095980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d611a5980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/926acae7ce07/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS sector size (1024) and media sector size (512).
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 5100 Comm: syz-executor136 Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:run_lookup fs/ntfs3/run.c:39 [inline]
RIP: 0010:run_is_mapped_full+0x35/0x480 fs/ntfs3/run.c:173
Code: 41 54 53 48 83 ec 30 41 89 d4 41 89 f6 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 d6 85 a5 fe 49 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 fc 0b 0d ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc90003f37758 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff888022738000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f37b18 R08: ffffffff82e4c29a R09: ffffffff82ee1f39
R10: 0000000000000002 R11: ffff888022738000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555587274380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe5d9a1000 CR3: 000000001e682000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_load_runs fs/ntfs3/attrib.c:69 [inline]
 attr_set_size+0xfdf/0x4300 fs/ntfs3/attrib.c:502
 ntfs_create_inode+0x2604/0x3880 fs/ntfs3/inode.c:1716
 ntfs_symlink+0xde/0x110 fs/ntfs3/namei.c:197
 vfs_symlink+0x137/0x2e0 fs/namei.c:4525
 do_symlinkat+0x222/0x3a0 fs/namei.c:4551
 __do_sys_symlinkat fs/namei.c:4567 [inline]
 __se_sys_symlinkat fs/namei.c:4564 [inline]
 __x64_sys_symlinkat+0x95/0xb0 fs/namei.c:4564
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f861218a879
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5d9a0638 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f861218a879
RDX: 0000000020000440 RSI: 0000000000000006 RDI: 0000000020000340
RBP: 00007f861221d610 R08: 00007ffe5d9a0808 R09: 00007ffe5d9a0808
R10: 00007ffe5d9a0808 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe5d9a07f8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:run_lookup fs/ntfs3/run.c:39 [inline]
RIP: 0010:run_is_mapped_full+0x35/0x480 fs/ntfs3/run.c:173
Code: 41 54 53 48 83 ec 30 41 89 d4 41 89 f6 49 89 fd 49 bf 00 00 00 00 00 fc ff df e8 d6 85 a5 fe 49 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 fc 0b 0d ff 48 8b 1b 31 ff 48 89
RSP: 0018:ffffc90003f37758 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: ffff888022738000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003f37b18 R08: ffffffff82e4c29a R09: ffffffff82ee1f39
R10: 0000000000000002 R11: ffff888022738000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555587274380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe5d9a1000 CR3: 000000001e682000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 54                	push   %r12
   2:	53                   	push   %rbx
   3:	48 83 ec 30          	sub    $0x30,%rsp
   7:	41 89 d4             	mov    %edx,%r12d
   a:	41 89 f6             	mov    %esi,%r14d
   d:	49 89 fd             	mov    %rdi,%r13
  10:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  17:	fc ff df
  1a:	e8 d6 85 a5 fe       	call   0xfea585f5
  1f:	49 8d 5d 08          	lea    0x8(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 fc 0b 0d ff       	call   0xff0d0c35
  39:	48 8b 1b             	mov    (%rbx),%rbx
  3c:	31 ff                	xor    %edi,%edi
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


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

