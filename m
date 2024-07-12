Return-Path: <linux-kernel+bounces-250992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04A592FF41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD79C1C2246C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9211717836D;
	Fri, 12 Jul 2024 17:11:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4F176ABA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804288; cv=none; b=FDNclhh3Au3cxu/eOBwxc5Is5BduqXK5v81Pdi1iXtw5CBUGBMXD2yUIXLs3Rpn0fGBXEHMOb5BxeTLSG66GMwEcPisIvn1ZIKrYoWw3TjnQFe7ExgixLj6h9MEGe4x8PYkfAkcQs4K/4h+sOYMCvE8x6ql/YBk9ks1bg3vTIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804288; c=relaxed/simple;
	bh=cUTmJsYWIyv2lWpS6iZ5v3r3f3dID01bTiMy4ErkVtk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UtV7DQW4hlqOXBl4gQG5cWQ8zzquxEzbIv+V1uoKNlu4/U4UhbUFzMpQ/V9FKOp2eLB5CUl7xFDYtfQ4gWJVmkAv2SBEzxj/NOwdZRLPm9N7CvGe3LC6BPJqOs+A16yfClEZtMcC3S2po+SmVOuuRJAQhPACxFDU2ytuEsZsClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f684ab3f9cso174260139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804285; x=1721409085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HYZrmlt2CJl1taAOj3XOxe1FP4RfDOgX8Y2vDOl42Y=;
        b=ntf+tF+z44/DSjzEq5WnzKBYMBKEWb7a5mCe61fvAkrvB1s5iMsqu6pR69O+QeZGuI
         Z+vz+H/W6tgILU340HJ8N09TB1HC80Ht+ybg/tKLF09YQnrZfvtqLwe7RWV8j3iZ7/Gt
         ION+2hXKeyMF3VHI0zooXWPthD2ONyy7U+ChP2UNLYgQBRvR6Ewv6rKYgaQG961IGMBT
         0Xc7wHb5FIlR1ARzjG7xAiu1/MlkcMJZDdbruRC+jPHfGoCqEOHC8EMHBEjSO6CuQl5/
         IyDiJieBSvWbo1AXJnECrNLXAL0mqeYd0glRoJe/jBa/blU6Dvdh6gHQWSY+/cAt7ojI
         WiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlfXQ0QtvUuM0/AH68BGOwV5faWLcui6WFLpXtO9EjdAa0VLiYHN9Ydp+Ccimkybz7wnSjnChnHceGkBw9SFJ2mnhIlaELhLUgr+lI
X-Gm-Message-State: AOJu0YyQJF9YKdajjALGUjKv+s0zqvkdiPOXrBXWvITMDvQREoqjDHM9
	zW7GCPsvxPHRCRliI64X0ofONlfl37mjOAe0UQN70FsAIdVlHTV/AhzZcv1laY4Pz3VOpe2+y79
	HItzW4V9iNmV6IKyxuwc8necuuQHgdRo3NQmClGOgZciHttfdlR2Njbg=
X-Google-Smtp-Source: AGHT+IGuVxch4O93wBkamMYLrat7LvTMr8d7ZoZ9bwpW9iv9UdhmRVYDcKEaLYtTbThGGCJxL66SX25jPLJPJSXBf2EQR0YIh8M5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9819:b0:4b9:ad94:2074 with SMTP id
 8926c6da1cb9f-4c1cb7669d7mr185444173.3.1720804285684; Fri, 12 Jul 2024
 10:11:25 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:11:25 -0700
In-Reply-To: <0000000000006d415806048a9aee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d320c061d0ff813@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
From: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    43db1e03c086 Merge tag 'for-6.10/dm-fixes-2' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f39ee1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141c864e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b1da7e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/709e8f085073/disk-43db1e03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ab1fd5e8c1c/vmlinux-43db1e03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc7484cb3765/bzImage-43db1e03.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/40d14eae864b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 5077 Comm: syz-executor294 Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:list_add_tail include/linux/list.h:183 [inline]
RIP: 0010:list_lru_add+0x1b1/0x390 mm/list_lru.c:97
Code: 89 ef e8 e2 06 1c 00 48 8b 45 00 48 8b 4c 24 30 48 8d 6c 08 40 4c 8d 6d 08 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 b0 06 1c 00 4c 8b 7d 08 4c 89 f7
RSP: 0018:ffffc90003bbfa78 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff1100fada037 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff8bcaccc0 RDI: ffffffff8c1f54c0
RBP: 0000000000000000 R08: ffffffff8fac686f R09: 1ffffffff1f58d0d
R10: dffffc0000000000 R11: fffffbfff1f58d0e R12: 0000000000000001
R13: 0000000000000008 R14: ffff88807d6d01b8 R15: 0000000000000000
FS:  000055557a070380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045bdd0 CR3: 0000000023864000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __inode_add_lru fs/inode.c:467 [inline]
 iput_final fs/inode.c:1718 [inline]
 iput+0x87a/0x930 fs/inode.c:1767
 __dentry_kill+0x20d/0x630 fs/dcache.c:607
 dput+0x19f/0x2b0 fs/dcache.c:849
 shrink_dcache_for_umount+0x7d/0x130 fs/dcache.c:1559
 generic_shutdown_super+0x6a/0x2d0 fs/super.c:620
 bch2_kill_sb+0x41/0x50 fs/bcachefs/fs.c:2052
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x273/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f232c4c5e77
Code: 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffde2e9f38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f232c4c5e77
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffde2e9ff0
RBP: 00007fffde2e9ff0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000202 R12: 00007fffde2eb060
R13: 000055557a0716c0 R14: 00007fffde2eb05c R15: 431bde82d7b634db
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_add_tail include/linux/list.h:183 [inline]
RIP: 0010:list_lru_add+0x1b1/0x390 mm/list_lru.c:97
Code: 89 ef e8 e2 06 1c 00 48 8b 45 00 48 8b 4c 24 30 48 8d 6c 08 40 4c 8d 6d 08 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 b0 06 1c 00 4c 8b 7d 08 4c 89 f7
RSP: 0018:ffffc90003bbfa78 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 1ffff1100fada037 RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff8bcaccc0 RDI: ffffffff8c1f54c0
RBP: 0000000000000000 R08: ffffffff8fac686f R09: 1ffffffff1f58d0d
R10: dffffc0000000000 R11: fffffbfff1f58d0e R12: 0000000000000001
R13: 0000000000000008 R14: ffff88807d6d01b8 R15: 0000000000000000
FS:  000055557a070380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045bdd0 CR3: 0000000023864000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 ef                	mov    %ebp,%edi
   2:	e8 e2 06 1c 00       	call   0x1c06e9
   7:	48 8b 45 00          	mov    0x0(%rbp),%rax
   b:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
  10:	48 8d 6c 08 40       	lea    0x40(%rax,%rcx,1),%rbp
  15:	4c 8d 6d 08          	lea    0x8(%rbp),%r13
  19:	4d 89 ec             	mov    %r13,%r12
  1c:	49 c1 ec 03          	shr    $0x3,%r12
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 b0 06 1c 00       	call   0x1c06e9
  39:	4c 8b 7d 08          	mov    0x8(%rbp),%r15
  3d:	4c 89 f7             	mov    %r14,%rdi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

