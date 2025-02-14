Return-Path: <linux-kernel+bounces-515241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995D6A3623E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DBF3B0EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5426738A;
	Fri, 14 Feb 2025 15:48:30 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E66266EED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548110; cv=none; b=e7UzE3NOFe4DRrZJLAQlZH29oyJZ/vFT79v3/DiFEhjuZnlgdvXcDKn7UrtFiiNytq1F/syS5XmVITYg6RNa0K1s0CYRM0DNjlR3M3tr2gT8URntkQyIgxhJ8WmxGdVEdo+ToTmHJBnwBEKwrM11oly3ge4wzZhO9xpnJQW6R10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548110; c=relaxed/simple;
	bh=yp9wPBaU1N06poe1xhUYQvjom+4wbS3szMAxbLBPDf0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LB8fxDBG+g/bnUyOkxcEgGTS31AZNc/JgRGEiGarY21DcjkzIWKviCOUo0yn9zgplPvtHXB3dG4C4+2kYuB04jX+rHqsos0b9l1ktKiCW8TBpQF+TrqG9Q6zrdWl9aJvF+qxlH+l9GM9jIBfSgocwaBXTYl7nQhAA6p5HoeDmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d13fb2256fso16418655ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548107; x=1740152907;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlqVTorQdR1g1vdavog3FvC23diu/Dzzn7ZtESeDmfs=;
        b=ryynb6vk1wDgTBvpYj5nolyQmu3LAsEkuaAUNeqDhesYRYwMG8XRN9+0BxgszM+Qzy
         Cj1N5xS+Fi1DBQyc7AHyefMzkHaPRTXHNQ8JOnsNy0+CnOxZ1B1X++01RsI5SqsGZlpz
         aU7B58FhoObCfUr5Hi3b7qARrwL39O3SuLq9Xmqzyj4uXOQ/KBmFl6Dml2sS35vmQAzp
         VEOMx4gwCD52xAH1Q/eD7FRZF/jv+s1bbZHRJnaoUfEiUGQmAC84sUp7IsH5ylv1/e2y
         eCZSFBq9utWnl8Wkwo3H2/HgKYbiHs4Z4EBrsmKF0ocrzF6zh6hv5A1ABUCuLIOWpICW
         MC3w==
X-Forwarded-Encrypted: i=1; AJvYcCWkkzOLn82l9tQgOGI06wDtW07TNiRPZIpD7TDJPB5ycZjmyD0AWeOJ3MMD4PMr4vtsv+OiCUBvlABfvLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0XgGcvL8E3AK6VNx6loUNtPmZ/dT4CQD7z+6O+lEdjdk6ba1
	1w9/uyLBAVLjpWY4m0LXNe4zW58TpglgiMLzJuUxIsou6s0A5wSep9VskqSwrF0xNu0QVtJ7NPJ
	2PH51vXRm5FEx5iupgmtGrotULaUT9qGelGlVIGwU5JcHluvyybQ8Weo=
X-Google-Smtp-Source: AGHT+IGRrG1IGNRBsiTFDgVnix7ZvLMZH7bax/SHXx9/QRP92ieeVR93vVsXXeSLr1gayDAby1MyV7jYBF0uif26YWb0epNxcybP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470e:b0:3d1:8d64:97fa with SMTP id
 e9e14a558f8ab-3d18d649a93mr46711895ab.10.1739548107266; Fri, 14 Feb 2025
 07:48:27 -0800 (PST)
Date: Fri, 14 Feb 2025 07:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67af65cb.050a0220.21dd3.004a.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in shmem_mapping
From: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    df5d6180169a Add linux-next specific files for 20250210
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16d343f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=012c6245eaea0e23f7f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138972a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11737b18580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92495cf20271/disk-df5d6180.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4b3656161842/vmlinux-df5d6180.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fbc4e7a0f5d/bzImage-df5d6180.xz

The issue was bisected to:

commit 19c067c8a0f18b62d4a4235b0b327624c86f2e40
Author: Zi Yan <ziy@nvidia.com>
Date:   Wed Feb 5 03:14:13 2025 +0000

    mm/huge_memory: add buddy allocator like folio_split()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102f9bdf980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=122f9bdf980000
console output: https://syzkaller.appspot.com/x/log.txt?x=142f9bdf980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com
Fixes: 19c067c8a0f1 ("mm/huge_memory: add buddy allocator like folio_split()")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000024: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
CPU: 1 UID: 0 PID: 5949 Comm: syz-executor163 Not tainted 6.14.0-rc2-next-20250210-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
RIP: 0010:shmem_mapping+0x25/0x50 mm/shmem.c:281
Code: 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 c3 3a bd ff 48 81 c3 20 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 dd 35 24 00 48 c7 c0 80 6c 14 8c 48
RSP: 0018:ffffc90004036dd8 EFLAGS: 00010006
RAX: 0000000000000024 RBX: 0000000000000120 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000600 RDI: 0000000000000000
RBP: 0000000000000600 R08: ffffffff822bcf18 R09: 1ffffd4000331008
R10: dffffc0000000000 R11: fffff94000331009 R12: ffffea0001988018
R13: ffffea0001988080 R14: ffffea0001988018 R15: ffffea0001988000
FS:  00007f5e045316c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e0458dae0 CR3: 0000000023c78000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_unmapped_folio+0x238a/0x3e50 mm/huge_memory.c:3587
 __folio_split+0x1267/0x16d0 mm/huge_memory.c:3871
 try_folio_split include/linux/huge_mm.h:374 [inline]
 truncate_inode_partial_folio+0x55d/0xdc0 mm/truncate.c:230
 shmem_undo_range+0xab7/0x1820 mm/shmem.c:1144
 shmem_truncate_range mm/shmem.c:1224 [inline]
 shmem_fallocate+0x431/0xf20 mm/shmem.c:3674
 vfs_fallocate+0x623/0x7a0 fs/open.c:338
 madvise_remove mm/madvise.c:1034 [inline]
 madvise_vma_behavior mm/madvise.c:1269 [inline]
 madvise_walk_vmas mm/madvise.c:1511 [inline]
 madvise_do_behavior+0x1f29/0x3c00 mm/madvise.c:1646
 do_madvise mm/madvise.c:1744 [inline]
 __do_sys_madvise mm/madvise.c:1752 [inline]
 __se_sys_madvise mm/madvise.c:1750 [inline]
 __x64_sys_madvise+0x11b/0x140 mm/madvise.c:1750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e04576519
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5e04531218 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f5e04600308 RCX: 00007f5e04576519
RDX: 0000000000000009 RSI: 0000000000600003 RDI: 0000400000000000
RBP: 00007f5e04600300 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5e045cd074
R13: 0000400000000000 R14: 0000400000000140 R15: 0000400000000040
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:shmem_mapping+0x25/0x50 mm/shmem.c:281
Code: 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 c3 3a bd ff 48 81 c3 20 01 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 dd 35 24 00 48 c7 c0 80 6c 14 8c 48
RSP: 0018:ffffc90004036dd8 EFLAGS: 00010006
RAX: 0000000000000024 RBX: 0000000000000120 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000600 RDI: 0000000000000000
RBP: 0000000000000600 R08: ffffffff822bcf18 R09: 1ffffd4000331008
R10: dffffc0000000000 R11: fffff94000331009 R12: ffffea0001988018
R13: ffffea0001988080 R14: ffffea0001988018 R15: ffffea0001988000
FS:  00007f5e045316c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5e0458dae0 CR3: 0000000023c78000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	f3 0f 1e fa          	endbr64
   9:	53                   	push   %rbx
   a:	48 89 fb             	mov    %rdi,%rbx
   d:	e8 c3 3a bd ff       	call   0xffbd3ad5
  12:	48 81 c3 20 01 00 00 	add    $0x120,%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 dd 35 24 00       	call   0x243615
  38:	48 c7 c0 80 6c 14 8c 	mov    $0xffffffff8c146c80,%rax
  3f:	48                   	rex.W


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

