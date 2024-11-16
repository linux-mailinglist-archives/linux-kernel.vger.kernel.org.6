Return-Path: <linux-kernel+bounces-411600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7379CFCA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 05:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942F01F23200
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731018FDD2;
	Sat, 16 Nov 2024 04:03:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5169383
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731729812; cv=none; b=XFidKOdcsTSC+S9Kk19mhJzfeuUxvIErKbzb/ATF9JikLEyH+6zFcQiJ9YLUYb8T0Zj/mbL4b3gg0YnrQDbdReKr9alXNozeTirV8A2NJGNYaU3XIs1KfIPY3x0NnQcMvnxAXyczPl2+uUDdFO5Hvsc1PJdNnBQNkhuYUHcexBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731729812; c=relaxed/simple;
	bh=Xch8GfihzBFvr239EZp64JgKknhHnufeNl4rkqWy+yw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M6KHGIYR9kPlFDLPP2QBhoD0CIFv8IDYHMk4u8uiT/8x9jOTkbaRvKaBUVnezud9rJY3IdejSUcIxYlQ3jzXh+3HlU4gFMfIpuCA0YSZ0YLyUrmxRUe4ZhEDEJa3dxbIKo7wePbgOleVg7dXIbzjVCqm0ckKjC/DEYYTHNtdSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso3817445ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731729810; x=1732334610;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3opLCRcHjNdfFwjWccZxOIh1mLgc55rA1a1R118YCc=;
        b=Cj2kbhZfH+iss1nEZj+QT0rn7jzSvQcoosPCeC4q8YVmIYQPhLHCUvevOJOPkhSCL8
         AIpHF9pBJk7U2fkvfatBNGWpqvhThoR/rDHGpS2fr2D/4Dp9MrN67KgHdR4slIHJOr4d
         j85r4BR9xEyBM5K9f7NisUYMeT9Gyse877BqpADCo2y+9qGgrsAz9M0U+dadRjMHiBTm
         UgZb35DHd9W5hTk4WvsDwKVQDOugQ3cFYcRhkopQPtb00sJQfAK4MZeKe2Kii84MNy/X
         LDd1OaB7JZRzMOACRIsUjuyjwHjwpKCQCRtMx8DwYvfkGTBxAv7P+twGPshst4h+Ddgi
         FXOg==
X-Forwarded-Encrypted: i=1; AJvYcCWWix6oRb311ks/1zEQwp9KW59kvB/haoGHH9YzCxaQt6lggPjucPZwtHPcoOyEfxfOil9Fr6t1bChRE3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPq8KYdaT/YIEyBWmqirHNiy09TZle/bTf0xSSjeSfkZc7ATR3
	F0Um89QLG2BVTwOOmmzMZpnB/5IYPZWPvBPWvlMAwRuvLlfa4AuEspjWf5TZMM6Fv2T1WaX3l5K
	gYixK/2b0coAhACvoITeoKLBhlTxQVNqj2N7GNwI5zEiNTgFzm1cNm04=
X-Google-Smtp-Source: AGHT+IHxLGwN/LoGbR/vX6FJFdNKtj8W9Ui54RbvpNEm7SCsRP3kkrCwCFaEogYfGVnd8mymjrTOnMmcnjqGeGsFZE1Td3t7TOE7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a74800f3efmr63010405ab.3.1731729809839; Fri, 15 Nov 2024
 20:03:29 -0800 (PST)
Date: Fri, 15 Nov 2024 20:03:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67381991.050a0220.57553.0045.GAE@google.com>
Subject: [syzbot] [jfs?] general protection fault in jfs_error (2)
From: syzbot <syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1772fe30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=5f0d7af0e45fae10edd1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b2f4e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119f7ea7980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c68277f7b0f1/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/161b075483b1/bzImage-2d5404ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6b6a26f0435b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com

ERROR: (device loop0): remounting filesystem as read-only
ERROR: (device loop0): dbFindCtl: Corrupt dmapctl page
jfs_create: dtInsert returned -EIO
ERROR: (device (efault)): jfs_create: 
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
CPU: 0 UID: 0 PID: 5313 Comm: syz-executor116 Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:sb_rdonly include/linux/fs.h:2292 [inline]
RIP: 0010:jfs_handle_error fs/jfs/super.c:66 [inline]
RIP: 0010:jfs_error+0x159/0x2e0 fs/jfs/super.c:98
Code: 08 48 c7 c7 40 e9 42 8c 48 89 74 24 08 4c 89 f9 e8 4c 22 9c 08 4d 8d 65 50 4d 89 e7 49 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 07 00 74 08 4c 89 e7 e8 48 5e d6 fe 49 8b 1c 24 48 89 de
RSP: 0018:ffffc9000ce4fa20 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 1c32466592978100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000ce4fb30 R08: ffffffff8174a13c R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 0000000000000050
R13: 0000000000000000 R14: 1ffff920019c9f4c R15: 000000000000000a
FS:  0000555595511380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fdcfd20000 CR3: 0000000043170000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_create+0x81d/0xbb0 fs/jfs/namei.c:140
 vfs_create+0x23c/0x3d0 fs/namei.c:3294
 do_mknodat+0x447/0x5b0 fs/namei.c:4185
 __do_sys_mknod fs/namei.c:4218 [inline]
 __se_sys_mknod fs/namei.c:4216 [inline]
 __x64_sys_mknod+0x8c/0xa0 fs/namei.c:4216
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f17ac91d9f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff56943258 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
RAX: ffffffffffffffda RBX: 00007fff56943428 RCX: 00007f17ac91d9f9
RDX: 0000000000000701 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007f17ac996610 R08: 0000000020000000 R09: 00007fff56943428
R10: 00007fff56943120 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff56943418 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sb_rdonly include/linux/fs.h:2292 [inline]
RIP: 0010:jfs_handle_error fs/jfs/super.c:66 [inline]
RIP: 0010:jfs_error+0x159/0x2e0 fs/jfs/super.c:98
Code: 08 48 c7 c7 40 e9 42 8c 48 89 74 24 08 4c 89 f9 e8 4c 22 9c 08 4d 8d 65 50 4d 89 e7 49 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 07 00 74 08 4c 89 e7 e8 48 5e d6 fe 49 8b 1c 24 48 89 de
RSP: 0018:ffffc9000ce4fa20 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: dffffc0000000000 RCX: 1c32466592978100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000ce4fb30 R08: ffffffff8174a13c R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: 0000000000000050
R13: 0000000000000000 R14: 1ffff920019c9f4c R15: 000000000000000a
FS:  0000555595511380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055fdcfd20000 CR3: 0000000043170000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 48 c7             	or     %cl,-0x39(%rax)
   3:	c7 40 e9 42 8c 48 89 	movl   $0x89488c42,-0x17(%rax)
   a:	74 24                	je     0x30
   c:	08 4c 89 f9          	or     %cl,-0x7(%rcx,%rcx,4)
  10:	e8 4c 22 9c 08       	call   0x89c2261
  15:	4d 8d 65 50          	lea    0x50(%r13),%r12
  19:	4d 89 e7             	mov    %r12,%r15
  1c:	49 c1 ef 03          	shr    $0x3,%r15
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	41 80 3c 07 00       	cmpb   $0x0,(%r15,%rax,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 e7             	mov    %r12,%rdi
  34:	e8 48 5e d6 fe       	call   0xfed65e81
  39:	49 8b 1c 24          	mov    (%r12),%rbx
  3d:	48 89 de             	mov    %rbx,%rsi


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

