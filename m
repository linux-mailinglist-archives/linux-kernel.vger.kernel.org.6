Return-Path: <linux-kernel+bounces-184465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BC8CA714
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304CE282909
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E781BC46;
	Tue, 21 May 2024 03:32:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F817C6D
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716262355; cv=none; b=gi51y3C4yrpD25TR60Bw1scIrJH/+kdvtxIcDRMyCrQ8GLriCC51ixJ60FwMDW+Eh8Xw7++ks748wKbYre4zBe3oN7L2m5efJ0jTCRGl9NzS7cHOGqaA6GT3KRfl5zv6QPDbUNZ8aek3Anpq07xgyBD9R3/RKX4ayxQWTDXiX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716262355; c=relaxed/simple;
	bh=bPnVvZw/n8Jy59WyHjpYngGUKtsEOFpba/PrN2EhEoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iKV6vZSw9hYjGRH/1tOjHlDkJRyA4MnUwe+2brO8GrDxrIficHnqRaSstjYoJJ+LsN7LIyTwpaf0JISQXi52MWuVBKpXezyny/2j0KS2jSOSd7BjROT4M3GQ4fvL0jiOxEAkaHu/GSdOtfSlVi2/fbUUUt1zXmxU0ZAU0w86UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e255f62e6cso33718039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716262353; x=1716867153;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/vinNNp8jUbubjtFGLvk7MGWde7WYxEn7T8IibDPPU=;
        b=r9uqhjgqSF41dXSQdaTxYRdVaxDG9s5AEaeETuyTzcw33Jcow7nUNFYXyhkDjan7Lk
         ACe/6gGOk3wxoezrwRAWhnWas9MWye+iQ0zohSVyPnPwWDhIlaWld+3mYF4b+tnWOfXB
         dfMpU1MzH7okO1EGkf2tZFtoPCsytwRlH/PGDc3bMHEvTX1TK6t71QMHSCmbbef6lLCR
         IvrL6lb+P8CeCWDW0OHfbgKH/QNqT5iRDEr5PiKSRQxtr/SBZpidCMR1D281H6fHV0ux
         6jPVzPHyowyokXxYagYRTccSd+0Ok7ydmzfUP2Dv7P/7N+LpkgGoQafIZGC9o3XmAhdF
         6vDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM+p0wMMAI81HB2rYZpRPH9Y/7b9pmwKOrm1oWJ4TJrOJo1EzdXh8DYj1LdaZ7tH+Z658023bhL8iiIf73dA4suppXeySGkmEETBw7
X-Gm-Message-State: AOJu0YyP+DHmQEHGZMUNx4PGDD1onjDprT6wVLbT+KTN1gkOZaiMKUEk
	b5Hn6AH4C2WdnYQb1WEB77SHfDO33HNHeoLHO8oF4zWDo6C9xtpTKT8dO+zbcCfTJUCYcUBjB3+
	R59bFqJz8FJtd1K9GyK1Nb5EaxRUZe1Vvygdszi9qSvtnBUAP0Ae6G1E=
X-Google-Smtp-Source: AGHT+IFGQ8jmJXCFtxOCP2ibgVU85X4VsfAr7UD7Lo0/Ki0fHx0PGatnReeblaRzn0qP/71Cjj0nCGivNvm8WSUYchGzADkOLpJb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:75e3:f3c1 with SMTP id
 8926c6da1cb9f-489589d7ba6mr2230243173.0.1716262353453; Mon, 20 May 2024
 20:32:33 -0700 (PDT)
Date: Mon, 20 May 2024 20:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb54450618ee7792@google.com>
Subject: [syzbot] [ntfs3?] WARNING: held lock freed in alloc_super
From: syzbot <syzbot+6b2e22a2beb29d5b5a50@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e51b4b5bbc0 Merge tag 'mips_6.10' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15848f0a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4381d48cde9bcb26
dashboard link: https://syzkaller.appspot.com/bug?extid=6b2e22a2beb29d5b5a50
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-6e51b4b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ded6f5d7f90/vmlinux-6e51b4b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1e9274bab03b/bzImage-6e51b4b5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6b2e22a2beb29d5b5a50@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 4096
ntfs3: loop3: Different NTFS sector size (1024) and media sector size (512).
=========================
WARNING: held lock freed!
6.9.0-syzkaller-09868-g6e51b4b5bbc0 #0 Not tainted
-------------------------
syz-executor.3/16347 is freeing memory ffff88802a8a4098-ffff88802a8a4127, with a lock still held there!
ffff88802a8a40e0 (&type->s_umount_key#74/1){+.+.}-{3:3}, at: alloc_super+0x23d/0xbd0 fs/super.c:343
1 lock held by syz-executor.3/16347:
 #0: ffff88802a8a40e0 (&type->s_umount_key#74/1){+.+.}-{3:3}, at: alloc_super+0x23d/0xbd0 fs/super.c:343

stack backtrace:
CPU: 2 PID: 16347 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-09868-g6e51b4b5bbc0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_freed_lock_bug kernel/locking/lockdep.c:6538 [inline]
 debug_check_no_locks_freed+0x203/0x2a0 kernel/locking/lockdep.c:6571
 debug_mutex_init+0x1b/0x70 kernel/locking/mutex-debug.c:86
 ntfs_alloc_inode+0x5b/0x70 fs/ntfs3/super.c:569
 alloc_inode+0x5d/0x230 fs/inode.c:261
 iget5_locked fs/inode.c:1235 [inline]
 iget5_locked+0x1c9/0x2c0 fs/inode.c:1228
 ntfs_iget5+0xd1/0x3950 fs/ntfs3/inode.c:531
 ntfs_fill_super+0x3738/0x4490 fs/ntfs3/super.c:1485
 get_tree_bdev+0x36f/0x610 fs/super.c:1614
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a8e07e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a8edf2ef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1a8edf2f80 RCX: 00007f1a8e07e5ea
RDX: 0000000020000040 RSI: 000000002001f840 RDI: 00007f1a8edf2f40
RBP: 0000000020000040 R08: 00007f1a8edf2f80 R09: 0000000000800000
R10: 0000000000800000 R11: 0000000000000202 R12: 000000002001f840
R13: 00007f1a8edf2f40 R14: 000000000001f81b R15: 00000000200003c0
 </TASK>
ntfs3: loop3: try to read out of volume at offset 0x22800
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 2 PID: 16347 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-09868-g6e51b4b5bbc0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:iput_final fs/inode.c:1710 [inline]
RIP: 0010:iput.part.0+0x38c/0x7f0 fs/inode.c:1767
Code: 8c ff 48 8b 44 24 10 48 85 c0 0f 85 f5 02 00 00 e8 99 4f 8c ff 49 8d 7e 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 03 00 00 49 8b 46 28 48 85 c0 48 89 44 24 10
RSP: 0000:ffffc9000382f8b8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88802a8a4250 RCX: ffffc90005a91000
RDX: 0000000000000005 RSI: ffffffff820198e7 RDI: 0000000000000028
RBP: ffff88802a8a4458 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 6c203a337366746e R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88802a8a4328
FS:  00007f1a8edf36c0(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6a99d14440 CR3: 000000005af5a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iput+0x5c/0x80 fs/inode.c:1757
 ntfs_read_mft fs/ntfs3/inode.c:502 [inline]
 ntfs_iget5+0x6b9/0x3950 fs/ntfs3/inode.c:538
 ntfs_fill_super+0x3738/0x4490 fs/ntfs3/super.c:1485
 get_tree_bdev+0x36f/0x610 fs/super.c:1614
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1a8e07e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a8edf2ef8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f1a8edf2f80 RCX: 00007f1a8e07e5ea
RDX: 0000000020000040 RSI: 000000002001f840 RDI: 00007f1a8edf2f40
RBP: 0000000020000040 R08: 00007f1a8edf2f80 R09: 0000000000800000
R10: 0000000000800000 R11: 0000000000000202 R12: 000000002001f840
R13: 00007f1a8edf2f40 R14: 000000000001f81b R15: 00000000200003c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput_final fs/inode.c:1710 [inline]
RIP: 0010:iput.part.0+0x38c/0x7f0 fs/inode.c:1767
Code: 8c ff 48 8b 44 24 10 48 85 c0 0f 85 f5 02 00 00 e8 99 4f 8c ff 49 8d 7e 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d4 03 00 00 49 8b 46 28 48 85 c0 48 89 44 24 10
RSP: 0000:ffffc9000382f8b8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88802a8a4250 RCX: ffffc90005a91000
RDX: 0000000000000005 RSI: ffffffff820198e7 RDI: 0000000000000028
RBP: ffff88802a8a4458 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 6c203a337366746e R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88802a8a4328
FS:  00007f1a8edf36c0(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6a99d14440 CR3: 000000005af5a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8c ff                	mov    %?,%edi
   2:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
   7:	48 85 c0             	test   %rax,%rax
   a:	0f 85 f5 02 00 00    	jne    0x305
  10:	e8 99 4f 8c ff       	call   0xff8c4fae
  15:	49 8d 7e 28          	lea    0x28(%r14),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 d4 03 00 00    	jne    0x408
  34:	49 8b 46 28          	mov    0x28(%r14),%rax
  38:	48 85 c0             	test   %rax,%rax
  3b:	48 89 44 24 10       	mov    %rax,0x10(%rsp)


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

