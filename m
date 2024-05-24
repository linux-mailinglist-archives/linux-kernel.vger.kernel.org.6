Return-Path: <linux-kernel+bounces-189194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EBF8CED04
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268B81F21A24
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398188626D;
	Fri, 24 May 2024 23:40:28 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A22A433DC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594027; cv=none; b=XNDPlf1ZDNhIHCr2EV/BTA5ZUP8mtt80nJqJpAyWCpOSnRs6vca0+pXzAyQuH8InozwZyD67s/HhTbjoaDOKjW8cSVo5ObocNqIJP9/u9NpVLfd8VYN2XowGgwN07nSFnzKij0mYQZDZIpSOAV0gGHg/kmvbI8vPwXOFGJ6nI9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594027; c=relaxed/simple;
	bh=P2mwHfBctTpYhyELDi+SrlgJlYMW4sRxyF3orZnhXbM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cF4euQ5L/zf2C1kq/cRC/ZtagbE5sMSxYDMj4ttLmfcmqgB5BN5HD1p6dQmcde+8H8bkJ3TQPKvKhQNRQ9zkZvKf30JtspUUX4jAsSi/IZ1kVMBSWflq2FHt8wo8+wUqyZFnhnOeWh3ph7SWIOJqN28AMQJ2mKMAlgN8767Z3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e20341b122so349935239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716594025; x=1717198825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruxx6hwMdw6tiLdFJ4ff3AzTG69ua+FbzBlLLO0xTSo=;
        b=PvCES9LyMbgarJ2ofkvCVxey4I6XZZR4z+YhNGrPxIz/v4vaGo3imsmyTJThqipoKi
         DSoNgO98xOzeTCJ1kizJtUaDJ9eE1KILYpcAjcho5NOZxDmH6mIzyb6JkMKil616ZhCF
         nk2PK7fupMjPcpi+V/uO573IJe2AsyLzPW0Z5dDfqTfpi9hdDyOARgxTDxVSGlfW75bp
         V+NPyCNTj6WOAE6GNx+Mc6wOsGOFUP+dSMJ/+3DK2UtJFs5n7v51mC4qgsB64ZBqY8oz
         tNHNOwkeqDHTybfJ5XyhRVjYcigkbjGY6gspbG0+FmDsP8f8ffmfsyGwnK92PHNHXoBp
         w3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXWaaJznf9RNdOodoSMq3P9NTBcwKtMXbZu/MvyykCM73+Ta2r2Pn0hJFCpBnBfUqTv7NVFeDwLluJA1RdOyvbctBNuSdWB+I6DAXmB
X-Gm-Message-State: AOJu0Yy4ZLdjDFMITABMJpGJn3qpMji3aVOO6hOJQfzG7i6ut1xNTB1S
	nE9i721kakjpy9e4yi9fvctetYx++tl/wAEe3Buk1l+i97qR/9m+a3jKhqF0Sc2T7FE7OzdbX3x
	dpSiInWX2dMZx6m4h0WxF2+3Mzz/N+2LIpSMvqGczQQJTi4JYWpf5zwI=
X-Google-Smtp-Source: AGHT+IHJzk98scv98HkVGaJRtnoFci0DZCMJIHN814kkIGAQdqDKnVi7f8v6V+hKmBVHe3HWGMsEVlKadT81La5Q1xCZY3xq4hX4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd2c:0:b0:48a:37e1:a545 with SMTP id
 8926c6da1cb9f-4b03fccefbamr69604173.6.1716594025483; Fri, 24 May 2024
 16:40:25 -0700 (PDT)
Date: Fri, 24 May 2024 16:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ce51806193bb19c@google.com>
Subject: [syzbot] [mm?] WARNING in shmem_evict_inode (3)
From: syzbot <syzbot+d159dee03e75571264d4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, hughd@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e51b4b5bbc0 Merge tag 'mips_6.10' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12425392980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d5d254b2919253a
dashboard link: https://syzkaller.appspot.com/bug?extid=d159dee03e75571264d4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6e51b4b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4a78abf5bef3/vmlinux-6e51b4b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/283fe971fc00/bzImage-6e51b4b5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d159dee03e75571264d4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7029 at mm/shmem.c:1265 shmem_evict_inode+0x8a1/0xbb0 mm/shmem.c:1265
Modules linked in:
CPU: 1 PID: 7029 Comm: syz-executor.1 Not tainted 6.9.0-syzkaller-09868-g6e51b4b5bbc0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:shmem_evict_inode+0x8a1/0xbb0 mm/shmem.c:1265
Code: e6 e8 a3 cc c1 ff 45 85 e4 75 aa e8 99 d1 c1 ff 48 8b 74 24 28 48 8b 7c 24 30 e8 fa 4a 9c ff e9 1a fe ff ff e8 80 d1 c1 ff 90 <0f> 0b 90 e9 9f f9 ff ff e8 72 d1 c1 ff 4c 89 e2 48 b8 00 00 00 00
RSP: 0018:ffffc90006edfb48 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801be8b600 RCX: ffffffff81cca8ef
RDX: ffff88801955c880 RSI: ffffffff81ccaf50 RDI: 0000000000000007
RBP: ffffc90006edfc78 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000000 R14: ffff88801be8b630 R15: 0000000000200000
FS:  0000000000000000(0000) GS:ffff88802c100000(0063) knlGS:0000000057f3e400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000c0009b58b4 CR3: 0000000059eb4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 dentry_unlink_inode+0x295/0x440 fs/dcache.c:400
 __dentry_kill+0x1d0/0x600 fs/dcache.c:603
 dput.part.0+0x4b1/0x9b0 fs/dcache.c:845
 dput+0x1f/0x30 fs/dcache.c:835
 __fput+0x3bc/0xb80 fs/file_table.c:430
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x82/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7267579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ff8d90e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000006
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000057f3e400
RDX: 0000000000000000 RSI: 00000000f73bdff4 RDI: 000000000001bc8b
RBP: 00000000f73e50c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

