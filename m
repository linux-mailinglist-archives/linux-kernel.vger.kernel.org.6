Return-Path: <linux-kernel+bounces-403808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F7B9C3B16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7D51F211CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F51531C5;
	Mon, 11 Nov 2024 09:41:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA331474A7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318087; cv=none; b=AB0jcbfiTXmNeX8x4pBLPrCspjCQ5+fRdCw5V8LwZA7divphQg98EjGoZ1dXLC48JDy+SHBIBKUaiGtgpelXrdAqdmlou2NVEs129h0Qi0TIhqn9yLYq35oqmk9HB61lBxWm4QH3RRzemKgyejOiRz5WIK3tQjDxZpiVlLIHNB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318087; c=relaxed/simple;
	bh=iCYq+stv2BD67TJ7RenSfhaTbeDJ4o+WD1WIKJBhaxo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TkcQIACPhlI5K8QfpISa+VoOaX6mEiRmojYkl6W5iP8FTSeybDRfIo6d2L7RO4qOAu/ydJLqJUoRdOMziXI+g9GuhUs5ttqhhKniVBlapMgJTc+bzItc9ljACM8PoA7iQ1hnuZVY74gd3ukp+QFBcVGFsPjKFFAOCCcOv0U/EFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so50320425ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318085; x=1731922885;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1vzqyhd7x6WSl4cAKIcYko+erBUrknSnvDuoWLf1V8=;
        b=T73WqJMtXrjyMLZtCj0JjbPaGymfiTcZ22bkYUDmsuUji6RX9ixYvtZNj8M9T2uOQZ
         Mw2QYFOcl75uSvzXpzlenu2YpIrVyekeCLsNRatLhOdGYESlw7t1BCnm19cwm7+BJGg2
         5dnaI+6dQN4UDQR0KC5FzUm9DQ0scn63qvWfpQ3QQiz87Bynyrk12gcsOoIbdFNj+RnB
         1wE8zV5/nkd8WSBBzSaogvWU3r7yiFLYv+GlUpGe+ztB0ZX6uUhwv1VMYZybz73/wij1
         degHOTGEQZdwbmeubngmEPGzJQpXvatt8w869dZ9Ft2Ug4CmMUtxdjXRW/P4s+RVdPp5
         GQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSjS60DjFn/cFt8iXMF9l0S1cwx8c9t901AV3J7661AvAvU2JDIiujYCi9rWX5b+I9mFlX0bcHAJl4ZJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA98KxthYEJkrL/WoR1luwrNrSTNLE+B0XUqhkVQsjD8lXxwtt
	CHF0PJzRdhYAPGl6PMG+dV/8bopcpE7ySGDOkbkPETxiMCmEV2AxdveseYTI1QNT5YsD9Szs19y
	bV9TFEWbWCdEJV8DYeeKT58biVmwd2SB9KhMKGjZdvxDZqXfKKxhbpFc=
X-Google-Smtp-Source: AGHT+IFr4rtd+B9NbqUxRGfzWwJ2JbxB6nqRdTP9PvfF35coOhT1Bms7nwz0tc6euMXhEQIOPK/ZCfYvRh4wno5Vt4Ksa48SXkDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:3a6:b4b4:ae39 with SMTP id
 e9e14a558f8ab-3a6f1a58bccmr136177425ab.20.1731318084816; Mon, 11 Nov 2024
 01:41:24 -0800 (PST)
Date: Mon, 11 Nov 2024 01:41:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731d144.050a0220.138bd5.0065.GAE@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_glock_dq
From: syzbot <syzbot+48ae9388c13bf60ba2c9@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    42f7652d3eb5 Linux 6.12-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e81a40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=48ae9388c13bf60ba2c9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-42f7652d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/27fd6c638478/vmlinux-42f7652d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5f529516264/bzImage-42f7652d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48ae9388c13bf60ba2c9@syzkaller.appspotmail.com

UDPLite: UDP-Lite is deprecated and scheduled to be removed in 2025, please contact the netdev mailing list
loop0: detected capacity change from 0 to 32768
gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
loop0: detected capacity change from 32768 to 64
syz.0.0: attempt to access beyond end of device
loop0: rw=1, sector=2972, nr_sectors = 18 limit=64
gfs2: fsid=syz:syz.0: Error 10 writing to journal, jid=0
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 UID: 0 PID: 5104 Comm: syz.0.0 Not tainted 6.12.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_glock_dq+0x4d/0xa60 fs/gfs2/glock.c:1690
Code: fd 4d 8d 65 10 4c 89 e5 48 c1 ed 03 80 7c 1d 00 00 74 08 4c 89 e7 e8 e2 58 19 fe 49 8b 0c 24 4c 8d 79 10 4d 89 fe 49 c1 ee 03 <41> 80 3c 1e 00 74 0e 48 89 cb 4c 89 ff e8 c1 58 19 fe 48 89 d9 48
RSP: 0018:ffffc9000b53fc38 EFLAGS: 00010202
RAX: ffffffff83e553d4 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffc9000b5f1000 RSI: 000000000000002f RDI: 0000000000000030
RBP: 1ffff920016a7fa6 R08: ffffffff83e500de R09: 1ffff11009e0b0ad
R10: dffffc0000000000 R11: ffffed1009e0b0ae R12: ffffc9000b53fd30
R13: ffffc9000b53fd20 R14: 0000000000000002 R15: 0000000000000010
FS:  00007efc232b86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc179ff000 CR3: 000000003f0b0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_glock_dq_uninit+0x25/0xb0 fs/gfs2/glock.c:1748
 gfs2_seek_hole+0x16c/0x240 fs/gfs2/inode.c:2150
 gfs2_llseek+0x11e/0x280 fs/gfs2/file.c:79
 vfs_llseek fs/read_write.c:382 [inline]
 ksys_lseek fs/read_write.c:395 [inline]
 __do_sys_lseek fs/read_write.c:406 [inline]
 __se_sys_lseek fs/read_write.c:404 [inline]
 __x64_sys_lseek+0x150/0x1e0 fs/read_write.c:404
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc2257dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc232b8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000008
RAX: ffffffffffffffda RBX: 00007efc22735f80 RCX: 00007efc2257dff9
RDX: 0000000000000004 RSI: 000000000000054c RDI: 0000000000000009
RBP: 00007efc225f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007efc22735f80 R15: 00007ffd8046dd48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_glock_dq+0x4d/0xa60 fs/gfs2/glock.c:1690
Code: fd 4d 8d 65 10 4c 89 e5 48 c1 ed 03 80 7c 1d 00 00 74 08 4c 89 e7 e8 e2 58 19 fe 49 8b 0c 24 4c 8d 79 10 4d 89 fe 49 c1 ee 03 <41> 80 3c 1e 00 74 0e 48 89 cb 4c 89 ff e8 c1 58 19 fe 48 89 d9 48
RSP: 0018:ffffc9000b53fc38 EFLAGS: 00010202
RAX: ffffffff83e553d4 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffffc9000b5f1000 RSI: 000000000000002f RDI: 0000000000000030
RBP: 1ffff920016a7fa6 R08: ffffffff83e500de R09: 1ffff11009e0b0ad
R10: dffffc0000000000 R11: ffffed1009e0b0ae R12: ffffc9000b53fd30
R13: ffffc9000b53fd20 R14: 0000000000000002 R15: 0000000000000010
FS:  00007efc232b86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc179ff000 CR3: 000000003f0b0000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	fd                   	std
   1:	4d 8d 65 10          	lea    0x10(%r13),%r12
   5:	4c 89 e5             	mov    %r12,%rbp
   8:	48 c1 ed 03          	shr    $0x3,%rbp
   c:	80 7c 1d 00 00       	cmpb   $0x0,0x0(%rbp,%rbx,1)
  11:	74 08                	je     0x1b
  13:	4c 89 e7             	mov    %r12,%rdi
  16:	e8 e2 58 19 fe       	call   0xfe1958fd
  1b:	49 8b 0c 24          	mov    (%r12),%rcx
  1f:	4c 8d 79 10          	lea    0x10(%rcx),%r15
  23:	4d 89 fe             	mov    %r15,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	41 80 3c 1e 00       	cmpb   $0x0,(%r14,%rbx,1) <-- trapping instruction
  2f:	74 0e                	je     0x3f
  31:	48 89 cb             	mov    %rcx,%rbx
  34:	4c 89 ff             	mov    %r15,%rdi
  37:	e8 c1 58 19 fe       	call   0xfe1958fd
  3c:	48 89 d9             	mov    %rbx,%rcx
  3f:	48                   	rex.W


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

