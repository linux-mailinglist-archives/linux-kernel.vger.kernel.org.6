Return-Path: <linux-kernel+bounces-314012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F194096ADAB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE342840D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D5D2FB;
	Wed,  4 Sep 2024 01:15:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203ABA2E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412524; cv=none; b=s5rHqlLrHH7hB1vBJOgff4R6uWWXEQ9kQOfy+/2BHvBmlV7poxY2GdhZYYXGljXTLQEXHYRJ0T5P2jbdBSteNr0RqwitgIb44XtZpeMpY2Gzlf+15tqsdYDrQwzEla1EGAwIYyLN3SfNi8NSisWc8hshnhF3EhRbPD70rafqFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412524; c=relaxed/simple;
	bh=abZBfaJTUen9CeHugLJfdJoi3qcrPTTlRp4YHgo24gg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lDbLz7zzoFf39drlbSPH3fEktz6KRRz7JBm+OC7uYYoRDRRjPelgq+OsP6FlRH9GcaTxCuPYrBxuqqf06xDOaeW1PeXVo15gUkUC78WdTEJGpuAkJ75pKTD3IFTmhPhGHPJvVODe7e0jo/DcT9DJfhb6vuDyYB/KHnwmFmt0StE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a3754a02bso511596939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 18:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725412522; x=1726017322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+uIqYknVr2mdJU6dZAKpbhKWysCpthaYDRLFQPVNV0=;
        b=iObnxePVb6Q7FOlwRxh3faVblfJ6f2WnTmZ2o+Lrmhg2AD7cwlPwcBi3t3qgVm5aut
         stRyEeVS5Ze2GtZfYzjF8kmcZhB3eri/67pLjmlotFT1Nk1mVtLm8eChGZvEZk/lu2SL
         AnbfhB4+WoHBCudODL3RjnrXys+y6BPmR+897P8zOrPv4KDOGjnuoW+Tn2Wx0FGOiDaO
         u1gexTl/fTBcx42Ch4akVvJi9l1Bi29bqL07zZ1D4MJqKEXbrJF0kDVyxggxcWlZuVuw
         3capRXzGt/ysBnOFydUh8XhtH0NITbPg8SMc4xh0mkZ6u/3Sxz8cuXf4iG7Ommg2i0Gs
         7zUA==
X-Forwarded-Encrypted: i=1; AJvYcCW1FCBDq9l/6eCFn9zsGoy5O0rTnx2tt63pxMW3kXuyd/Hy8DOqfxSn/g1ZGrJrZdYYaITVvBzwT4pJt9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfT5FOUM8Z5v9T1KzvJOLkhaBhqdyaJQMzxQwBf770KJ/p9sb
	DHF0fHe5ibjSOwYcmRfDFU1nU0EP+Jku846Q6G6wxwzh/A0PJxXmA4Xy2mHBGNoX3wFpsYbf+D1
	e9X7IhRPR4QkzgvgKgORDwCyL6f9hqLWktYyV95QSbO741g+YNXb9Tcw=
X-Google-Smtp-Source: AGHT+IGJ4U9ac0R2msnuKQkkA0N7UNzu/vuWu+6O02h7j6g2ECQ6sKnKYNp0NFf/13DZEErmsn8pQ8ng2/VGHZtIKJUZhkadnBQ2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8611:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4d017e91f4bmr843201173.4.1725412522217; Tue, 03 Sep 2024
 18:15:22 -0700 (PDT)
Date: Tue, 03 Sep 2024 18:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a66c5062140e8f9@google.com>
Subject: [syzbot] [ntfs3?] INFO: trying to register non-static key in mark_as_free_ex
From: syzbot <syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    431c1646e1f8 Linux 6.11-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f3370b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=3bfd2cc059ab93efcdb4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b809eb980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1495c40d980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8f73ff24e19d/disk-431c1646.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a9cc8629dafc/vmlinux-431c1646.xz
kernel image: https://storage.googleapis.com/syzbot-assets/01c91ce5203b/bzImage-431c1646.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9687e33b346d/mount_0.gz

The issue was bisected to:

commit 110b24eb1a749bea3440f3ca2ff890a26179050a
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Wed Apr 17 07:33:06 2024 +0000

    fs/ntfs3: Taking DOS names into account during link counting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13aefeb7980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=106efeb7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17aefeb7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Fixes: 110b24eb1a74 ("fs/ntfs3: Taking DOS names into account during link counting")

loop0: detected capacity change from 0 to 8192
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 UID: 0 PID: 5231 Comm: syz-executor253 Not tainted 6.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:975
 register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1288
 __lock_acquire+0xf0/0x2040 kernel/locking/lockdep.c:5019
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1695
 mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484
 run_unpack+0x7f3/0xda0 fs/ntfs3/run.c:1019
 run_unpack_ex+0x14b/0x7f0 fs/ntfs3/run.c:1060
 ni_delete_all+0x2d9/0x9a0 fs/ntfs3/frecord.c:1610
 ni_clear+0x28e/0x4b0 fs/ntfs3/frecord.c:106
 evict+0x534/0x950 fs/inode.c:704
 ntfs_loadlog_and_replay+0x2e8/0x4f0 fs/ntfs3/fsntfs.c:326
 ntfs_fill_super+0x2c38/0x4730 fs/ntfs3/super.c:1280
 get_tree_bdev+0x3f9/0x570 fs/super.c:1635
 vfs_get_tree+0x92/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f008c4daa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda8f23918 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffda8f23930 RCX: 00007f3f008c4daa
RDX: 0000000020020b80 RSI: 0000000020020bc0 RDI: 00007ffda8f23930
RBP: 0000000000000004 R08: 00007ffda8f23970 R09: 0000000000020b83
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
R13: 00007ffda8f23970 R14: 0000000000000003 R15: 0000000000400000
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 5231 Comm: syz-executor253 Not tainted 6.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:wnd_is_used+0x58/0x520 fs/ntfs3/bitmap.c:928
Code: 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 a0 11 13 ff 49 8b 1f 48 8d 6b 14 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 7b 04 00 00 0f b6 6d 00 4c 8d 75 03 bf 3d
RSP: 0018:ffffc90009257288 EFLAGS: 00010213
RAX: 0000000000000002 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88802ebf41f8
RBP: 0000000000000014 R08: ffff88802ebf420f R09: 1ffff11005d7e841
R10: dffffc0000000000 R11: ffffed1005d7e842 R12: 0000000000000003
R13: 0000000000000002 R14: 0000000000000002 R15: ffff88802ebf41f8
FS:  000055556c297380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20b8995ed8 CR3: 000000007757a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mark_as_free_ex+0x53/0x390 fs/ntfs3/fsntfs.c:2485
 run_unpack+0x7f3/0xda0 fs/ntfs3/run.c:1019
 run_unpack_ex+0x14b/0x7f0 fs/ntfs3/run.c:1060
 ni_delete_all+0x2d9/0x9a0 fs/ntfs3/frecord.c:1610
 ni_clear+0x28e/0x4b0 fs/ntfs3/frecord.c:106
 evict+0x534/0x950 fs/inode.c:704
 ntfs_loadlog_and_replay+0x2e8/0x4f0 fs/ntfs3/fsntfs.c:326
 ntfs_fill_super+0x2c38/0x4730 fs/ntfs3/super.c:1280
 get_tree_bdev+0x3f9/0x570 fs/super.c:1635
 vfs_get_tree+0x92/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f008c4daa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda8f23918 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffda8f23930 RCX: 00007f3f008c4daa
RDX: 0000000020020b80 RSI: 0000000020020bc0 RDI: 00007ffda8f23930
RBP: 0000000000000004 R08: 00007ffda8f23970 R09: 0000000000020b83
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
R13: 00007ffda8f23970 R14: 0000000000000003 R15: 0000000000400000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:wnd_is_used+0x58/0x520 fs/ntfs3/bitmap.c:928
Code: 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 a0 11 13 ff 49 8b 1f 48 8d 6b 14 48 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 7b 04 00 00 0f b6 6d 00 4c 8d 75 03 bf 3d
RSP: 0018:ffffc90009257288 EFLAGS: 00010213
RAX: 0000000000000002 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88802ebf41f8
RBP: 0000000000000014 R08: ffff88802ebf420f R09: 1ffff11005d7e841
R10: dffffc0000000000 R11: ffffed1005d7e842 R12: 0000000000000003
R13: 0000000000000002 R14: 0000000000000002 R15: ffff88802ebf41f8
FS:  000055556c297380(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f20b8995ed8 CR3: 000000007757a000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	48 c1 e8 03          	shr    $0x3,%rax
   4:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
   8:	74 08                	je     0x12
   a:	4c 89 ff             	mov    %r15,%rdi
   d:	e8 a0 11 13 ff       	call   0xff1311b2
  12:	49 8b 1f             	mov    (%r15),%rbx
  15:	48 8d 6b 14          	lea    0x14(%rbx),%rbp
  19:	48 89 e8             	mov    %rbp,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 7b 04 00 00    	jne    0x4b1
  36:	0f b6 6d 00          	movzbl 0x0(%rbp),%ebp
  3a:	4c 8d 75 03          	lea    0x3(%rbp),%r14
  3e:	bf                   	.byte 0xbf
  3f:	3d                   	.byte 0x3d


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

