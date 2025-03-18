Return-Path: <linux-kernel+bounces-565692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F1A66D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3334C3B78C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF11EF387;
	Tue, 18 Mar 2025 08:10:32 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749C1F585C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285431; cv=none; b=qMUxjrhPBr6nH3bTefHBARXgMsKM66y/KiBNCi8s+DyYsw1MIsLgZ/J4wwK1tPCQkpp+chJkiue3Y+AtKupEtiuSCy7SmTjg0ry0/kxSZ0CS8U0OUPJyMQj2NI0hTisCqqEnb5DZXVACGFkG/zsaj7CFRCAgNKEKXiaVbR3Iz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285431; c=relaxed/simple;
	bh=2lH93i0OnE5loWC8JaYEVeBGSueKiv9yVZLLVkDqWoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WJaiTFGxIE6HZEihxlQ6tPl97lXNZfilBaP9StcOlgqkULWQmBmoi7NHOURrn4aTw49I3ZPcGzZG5a+CLo7Q3w6ZF4pmmwqofo8UtiklTOSDjVpOjaMEGLZuiw+jEgD/RMVNsGLz0rK0RwLzV1znr5XSZbS4LVdqg5dWB0LhWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-851a991cf8bso549826939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742285428; x=1742890228;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3MXCD0gRYS0eF05DMCdPmZIQ2i1zYj9BKRH8uqdc9A=;
        b=SE96n+xz0xdZcuL6YEFxQ3RvT2uaph/fiJ+S6ZPd4SR0oSPY4eTu5hZHtcxEuhwotW
         RXX3gfB2Som4rofzxFiDMrhAJMI9q5QfqJNWaEfRJOq7zxfJh0WFdjBFCU82/wR0Bi6e
         uPy7y3iSPxvQwER8vOX+MyjjZFNpiuMJu6G56EJeh1tAvUrPAkggGrN1ndalJYynDwj1
         EbDi9RF7BRo4U8siCYLv+0Evu3OuxTHkHDCDyA7Mn7MxT5CXBPVlZXmHd7os9dKEHZ/h
         VfuY3uOokcTCh2hW2znm/sEMUh7yDfeIFH37UiB8Nrak3iHq5hp++5VKxwBBdZYdvVKW
         PV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0Wzx3XTI8hvdmb5Bf7Py06o/ZLGxmxulmirwSUizLeTKL48aCpgccWtuqewRZl05Xev8anAxXQ7Udp0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKyyM0I0vdIHYHwTHHG7AdY/eVI37VeBCnlJbOlgWIGsa4Etb
	UZwln051u5UDqb7HyFojgIRhNHg1lKGT7GBmBNrCzFDxlMbVvL5NT71MLmqICELfWI7vxZTcJu+
	cAjcfmUTUjyJMaGnxDlYEogW0T2UCuYXFChdUdYGeeDcX7lYcsjbsmv0=
X-Google-Smtp-Source: AGHT+IF1WHyxMDQSGvgL4RIW6lr9+EfKQrVgPKmzMfS+l0fPZyZUUQoy4PsXU6MKeiWMM6TNq/vRt4FqUhodV0GBI+RrYXRcdmOi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:3d3:fa69:6755 with SMTP id
 e9e14a558f8ab-3d57c1e03d2mr20732975ab.5.1742285428745; Tue, 18 Mar 2025
 01:10:28 -0700 (PDT)
Date: Tue, 18 Mar 2025 01:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d92a74.050a0220.2ca2c6.014f.GAE@google.com>
Subject: [syzbot] [afs?] general protection fault in afs_atcell_get_link
From: syzbot <syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b35233e7bfa0 Merge tag 'for-6.14/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1232704c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=317038cbd53153e8
dashboard link: https://syzkaller.appspot.com/bug?extid=76a6f18e3af82e84f264
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3fc78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169fb874580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b35233e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b21b01e0ec9/vmlinux-b35233e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d08ea80ce857/bzImage-b35233e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000056: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000002b0-0x00000000000002b7]
CPU: 2 UID: 0 PID: 5932 Comm: syz-executor998 Not tainted 6.14.0-rc6-syzkaller-00189-gb35233e7bfa0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:afs_atcell_get_link+0x33e/0x480 fs/afs/dynroot.c:321
Code: 89 c3 89 c6 e8 53 af 3b fe 85 db 75 64 e8 4a b4 3b fe 48 8d bd b0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 89 f6 bf 03 00 00 00 4c 8b a5 b0
RSP: 0018:ffffc90004c3f988 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff837e3e8a
RDX: 0000000000000056 RSI: ffffffff837e3e16 RDI: 00000000000002b0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8881082b6000 R14: 0000000000000003 R15: ffff8880345a1480
FS:  000055559399f380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555939b0738 CR3: 000000002712e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pick_link fs/namei.c:1914 [inline]
 step_into+0x1982/0x2220 fs/namei.c:1984
 open_last_lookups fs/namei.c:3777 [inline]
 path_openat+0x74c/0x2d80 fs/namei.c:3986
 do_filp_open+0x20c/0x470 fs/namei.c:4016
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2317244161
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 0a 8f 07 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffd89f6cc50 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2317244161
RDX: 0000000000000000 RSI: 00007ffd89f6cd80 RDI: 00000000ffffff9c
RBP: 00007ffd89f6cd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffd89f6de70
R13: 00005555939a8700 R14: 000055559399f338 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:afs_atcell_get_link+0x33e/0x480 fs/afs/dynroot.c:321
Code: 89 c3 89 c6 e8 53 af 3b fe 85 db 75 64 e8 4a b4 3b fe 48 8d bd b0 02 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 01 00 00 4c 89 f6 bf 03 00 00 00 4c 8b a5 b0
RSP: 0018:ffffc90004c3f988 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff837e3e8a
RDX: 0000000000000056 RSI: ffffffff837e3e16 RDI: 00000000000002b0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8881082b6000 R14: 0000000000000003 R15: ffff8880345a1480
FS:  000055559399f380(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555939b0738 CR3: 000000002712e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 c3                	mov    %eax,%ebx
   2:	89 c6                	mov    %eax,%esi
   4:	e8 53 af 3b fe       	call   0xfe3baf5c
   9:	85 db                	test   %ebx,%ebx
   b:	75 64                	jne    0x71
   d:	e8 4a b4 3b fe       	call   0xfe3bb45c
  12:	48 8d bd b0 02 00 00 	lea    0x2b0(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 1f 01 00 00    	jne    0x153
  34:	4c 89 f6             	mov    %r14,%rsi
  37:	bf 03 00 00 00       	mov    $0x3,%edi
  3c:	4c                   	rex.WR
  3d:	8b                   	.byte 0x8b
  3e:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
  3f:	b0                   	.byte 0xb0


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

