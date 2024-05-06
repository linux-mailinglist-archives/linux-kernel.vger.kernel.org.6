Return-Path: <linux-kernel+bounces-169540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491388BCA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430F81C21A52
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B851420D1;
	Mon,  6 May 2024 08:57:24 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680E14198A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985844; cv=none; b=NIfg/JxF07TeUadm7w5TLVNVomQJIbyZ3si+JvbkR4NKIO8nTeBx4PQ4rQEuI2TWeAUeu3iQ6KnRG4Knh5PqTIZ7Kqq0PdNDkH5RQGPT7RNyvZ17ZhbNXA+n0fzg+2W+VLSvpZBt9c4An7tyhVGX3GwXOOrz9jWSqhskdZwxR74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985844; c=relaxed/simple;
	bh=wDYhJyu2DVxLmHrRXJESXTddnatnN2akvy8zf2u9AME=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qKS1H3LmPJEi0LoMKoEr5wTmGuGNn4GegijhBP5ow1//rD6E0FbN4BBzeyumb2U9LjMhHusw5AROKDGYc+IlEgy8TVG55Glw5rJKN1c9RZ9lpfbkzJtHgry/QKTqlCY4uY9N7hDwFDbrKne0k97/YClENKfw6sVoRsQFVzj/OgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7de9c6b7a36so229849039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 01:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714985842; x=1715590642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJ7LBMixCFeboKki0Y34uj/Ll/YaXkE0DJ03Yg0CbbE=;
        b=S3AXtkDAke9GFEp906vb8wJ3guBKDrdBLl0rRoAkGpJzcSKMYgwHykR/DP2kSWrPhB
         WcY+Va6bQZGKylNLwJlQoF5ZJnBBCVaPBTI+p8xnOrbA0mQD9YLSgNbsSCC2zmPvnZ23
         qoWPTLDe0tv2124OF3rz7hh15iAvnF9CpruQDr1QPzLD1Ymj+r11YaqQ6q3ZG1/M4LZt
         pdU9luN+GiJoM13KX0L6s6ujYqCAxQ2XLIitgn+UIRXiP4T6+cnq2Y744JYsx8tXMrsk
         AHjoSKXQE0Zl9Ze21AZF9NtvT0nfFSq3kDIB2Enek5jK4QAQL3nP433qC4haDYUyxMpD
         h9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7r1FmClzXllkRpyEA0brKSL+yiyBWEkAtwpvEK4/+QtqVmUM2TMsdYQu/zee/c6IAeRuebEV+Z7BjwwzPrQSK9iARcWjyPrsaJiS0
X-Gm-Message-State: AOJu0YxbDftyb9ooDgbs00OvexTSa/MXBCOhAUkrO+zmJflu3rbtcaMn
	731F3Da5OXOmtFJiZ/IYVnRDOKl3kymckmF5zKazoz6Jy2DqjUI98S06U35uGXBKO6iXuKsdFVJ
	JiGTheNkreZa6D+Dro36OsAChP3EfVaPMhFBzYUQtLEHZHiqVO9+P7oo=
X-Google-Smtp-Source: AGHT+IH6ZlXJA8vUkAqi9Klt4GLOcdOiirWu9okTaM2zeEOMPNxXDVi+Uzwpht4Vvnov4FLPec2iw5S04KzF3fCrk4FF5EqcJxxH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:36c:d2b:d7d with SMTP id
 j28-20020a056e02219c00b0036c0d2b0d7dmr473381ila.2.1714985841848; Mon, 06 May
 2024 01:57:21 -0700 (PDT)
Date: Mon, 06 May 2024 01:57:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6078a0617c5419c@google.com>
Subject: [syzbot] [lsm?] general protection fault in smack_inode_permission
From: syzbot <syzbot+4ac565a7081cc43bb185@syzkaller.appspotmail.com>
To: casey@schaufler-ca.com, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e98250980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=4ac565a7081cc43bb185
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03bd77f8af70/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb03a61f9582/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c5c654b571/bzImage-7367539a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ac565a7081cc43bb185@syzkaller.appspotmail.com

ERROR: (device loop0): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 6
ERROR: (device loop0): jfs_readdir: JFS:Dtree error: ino = 2, bn=0, index = 7
general protection fault, probably for non-canonical address 0xdffffc01839e4cf3: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000c1cf26798-0x0000000c1cf2679f]
CPU: 0 PID: 12996 Comm: syz-executor.0 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:smk_of_inode security/smack/smack.h:373 [inline]
RIP: 0010:smack_inode_permission+0x2bf/0x380 security/smack/smack_lsm.c:1234
Code: 49 83 c7 38 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 52 3c 97 fd 4c 63 35 d3 94 73 09 4d 03 37 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 f7 e8 33 3c 97 fd 49 8b 3e 8b 74 24 14 4c
RSP: 0018:ffffc90004ca7900 EFLAGS: 00010206
RAX: 00000001839e4cf3 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90004ca7948
RBP: ffffc90004ca7a18 R08: ffffc90004ca7987 R09: 0000000000000000
R10: ffffc90004ca7968 R11: fffff52000994f31 R12: 1ffff92000994f24
R13: ffffc90004ca7940 R14: 0000000c1cf26798 R15: ffff88804b800468
FS:  000055555808c480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3112c000 CR3: 0000000011652000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 security_inode_permission+0xa5/0x100 security/security.c:2216
 may_lookup fs/namei.c:1726 [inline]
 link_path_walk+0x2ef/0xea0 fs/namei.c:2273
 path_lookupat+0xa9/0x450 fs/namei.c:2484
 filename_lookup+0x256/0x610 fs/namei.c:2514
 user_path_at_empty+0x42/0x60 fs/namei.c:2921
 user_path_at include/linux/namei.h:57 [inline]
 ksys_umount fs/namespace.c:1916 [inline]
 __do_sys_umount fs/namespace.c:1924 [inline]
 __se_sys_umount fs/namespace.c:1922 [inline]
 __x64_sys_umount+0xf4/0x170 fs/namespace.c:1922
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f95e027efd7
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffed42b0998 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 00007f95e02c83b9 RCX: 00007f95e027efd7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffed42b0a50
RBP: 00007ffed42b0a50 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffed42b1b40
R13: 00007f95e02c83b9 R14: 00000000000ade1b R15: 0000000000000019
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:smk_of_inode security/smack/smack.h:373 [inline]
RIP: 0010:smack_inode_permission+0x2bf/0x380 security/smack/smack_lsm.c:1234
Code: 49 83 c7 38 4c 89 f8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 52 3c 97 fd 4c 63 35 d3 94 73 09 4d 03 37 4c 89 f0 48 c1 e8 03 <80> 3c 18 00 74 08 4c 89 f7 e8 33 3c 97 fd 49 8b 3e 8b 74 24 14 4c
RSP: 0018:ffffc90004ca7900 EFLAGS: 00010206
RAX: 00000001839e4cf3 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90004ca7948
RBP: ffffc90004ca7a18 R08: ffffc90004ca7987 R09: 0000000000000000
R10: ffffc90004ca7968 R11: fffff52000994f31 R12: 1ffff92000994f24
R13: ffffc90004ca7940 R14: 0000000c1cf26798 R15: ffff88804b800468
FS:  000055555808c480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000b9177c CR3: 0000000011652000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 83 c7 38          	add    $0x38,%r15
   4:	4c 89 f8             	mov    %r15,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   f:	74 08                	je     0x19
  11:	4c 89 ff             	mov    %r15,%rdi
  14:	e8 52 3c 97 fd       	call   0xfd973c6b
  19:	4c 63 35 d3 94 73 09 	movslq 0x97394d3(%rip),%r14        # 0x97394f3
  20:	4d 03 37             	add    (%r15),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 33 3c 97 fd       	call   0xfd973c6b
  38:	49 8b 3e             	mov    (%r14),%rdi
  3b:	8b 74 24 14          	mov    0x14(%rsp),%esi
  3f:	4c                   	rex.WR


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

