Return-Path: <linux-kernel+bounces-270838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F321D94460B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62437B210B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C73C3CF74;
	Thu,  1 Aug 2024 08:00:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C651EB490
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499227; cv=none; b=Yz9kJPctmzxgkwT1RJ4ii0qvdx+j8+4gGV/LVEi02Ce14HlvSly9BcSDER9UVC47Popy8LPSWD2lZEJobHHjEYLaDDJVDcXvWJDtUJy6b12sLE3MoW49RLdzFrjeHZjoBJNEalQmWlenj7xTUVvXHBdJ8KMH/4Z/SaacFL4twME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499227; c=relaxed/simple;
	bh=64iKqXM75gYGE43kjtUoHcvc8mtCN9A+M0czMJK0zNE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OrpVifmR8QI1SkKcYpXXiplhYVfOLB7s/rLxOwHk7VsRxGPJ/SgUMq3KQHArFmNpTa61W2J/8woTls4UPZUUSNTIMiRlDHsryIw5zJETrNlzyVgTFrKBfrDyqgUdN7nzceArjvnYg6HHP615YpA2GR2f8QKCWmfUs0YTReb0r7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f81da0972so1034347739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499225; x=1723104025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyjHsay8ROhwgYEY/QeRYJF0oiADIhn4jc5sMzILhoM=;
        b=YJp/Sq6yMUuEWJeqPXqBeNsmNomQnKwTStomiSVZZCI5JqJGzzH4yxZZHxUmQOH+53
         aHsVrf5kWdv8VI84YOqFP2Ul5la9XxufaQFEi25l4KoQGuEXJEhbTSonCkAaP/EbVwIk
         tZ7cueRvLfZ3jgY+luNyfVahFJe0FKWKXP660IT3HdatLEdAs6rxwRR8xU/O2vlUd3LC
         lZ4wXTD4LB5Tk+aD7qfYODTSsLxCUJEpvDRgCN8aNzUh/mgcftGmWi9h3GVFoLqhyAOt
         GEADcT9KI8QWBhLFwFF6Ow6qbq5EfXwSJUpKmqvbAnfMQR6exmzGEWg4lNyVr+ovuGRq
         uxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV06j0Xw03MgoUbzvQ5BcF2b1s8N2s80Ldq/wN12pPgRoy5CU1Z0z2QdyRC5yCY8z5JVqOPOEVO7CpNK5Ym4x9eEwaiwTIpZqQY5Z4s
X-Gm-Message-State: AOJu0Yy30i2rCzZcoMgRqj6zan2xeiLVCbxPIIjxK1EUcPwNtPD0bAqs
	khyVnT5p4DS3fTRFlJTsGYhAMOedn4G5ENaNrIeQrC5yOxbV5FLJTGHz0QrfgffDCrU9/Z1DhKb
	oyiuIJM7TV+UcMzf7TXGNMSWZxy7ACic05HxAhDc3SAmMKxXmC/2Frac=
X-Google-Smtp-Source: AGHT+IHPrqW+Wi60H+CQF7pbJ0wOaMpA0v8nw3E/bgYR8JIEUbn7ysExNxcU+HobysWQRYHU3bNt5gDb2yA2NfhTkWMrYVl95/k3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6418:b0:80c:5215:8a55 with SMTP id
 ca18e2360f4ac-81fcc1d86e9mr3458939f.2.1722499225027; Thu, 01 Aug 2024
 01:00:25 -0700 (PDT)
Date: Thu, 01 Aug 2024 01:00:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f16a0061e9a9aa7@google.com>
Subject: [syzbot] [jfs?] general protection fault in dbFree
From: syzbot <syzbot+ecafa838512962d7d7f6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, 
	jfs-discussion@lists.sourceforge.net, kristian@klausen.dk, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    910bfc26d16d Merge tag 'rust-6.11' of https://github.com/R..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ffeda1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=ecafa838512962d7d7f6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14af8cd9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a426f9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/863d9befadf0/disk-910bfc26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/431d0c4adec0/vmlinux-910bfc26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5be5e371ff13/bzImage-910bfc26.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/39d480966a2c/mount_0.gz

The issue was bisected to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11660f0d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13660f0d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15660f0d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecafa838512962d7d7f6@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

loop0: detected capacity change from 0 to 32768
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5215 Comm: syz-executor143 Not tainted 6.10.0-syzkaller-12857-g910bfc26d16d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:dbFree+0x10f/0x680 fs/jfs/jfs_dmap.c:368
Code: 17 4d 4e fe 31 ff 4c 89 e6 e8 6d dd 72 fe 4d 85 e4 0f 84 e2 04 00 00 4c 89 f1 4f 8d 74 25 00 48 8b 14 24 48 89 d0 48 c1 e8 03 <80> 3c 08 00 74 0d 48 8b 3c 24 e8 92 eb d6 fe 48 8b 14 24 48 8b 1a
RSP: 0018:ffffc90003bc7bb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88802a22a2a0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: ffff888025086000 R08: ffffffff8320a9f3 R09: 1ffff1100f474141
R10: dffffc0000000000 R11: ffffed100f474142 R12: 0000000000000100
R13: 0000000000000100 R14: 0000000000000200 R15: ffff88807a3a2000
FS:  00007f47de10c6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f47de0ebd58 CR3: 00000000799c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dbDiscardAG+0x8a9/0xa20 fs/jfs/jfs_dmap.c:1650
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47de156789
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47de10c218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f47de1e36c8 RCX: 00007f47de156789
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007f47de1e36c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f47de1b0084
R13: 00007f47de1aa07e R14: 0037656c69662f2e R15: 3333222211110000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbFree+0x10f/0x680 fs/jfs/jfs_dmap.c:368
Code: 17 4d 4e fe 31 ff 4c 89 e6 e8 6d dd 72 fe 4d 85 e4 0f 84 e2 04 00 00 4c 89 f1 4f 8d 74 25 00 48 8b 14 24 48 89 d0 48 c1 e8 03 <80> 3c 08 00 74 0d 48 8b 3c 24 e8 92 eb d6 fe 48 8b 14 24 48 8b 1a
RSP: 0018:ffffc90003bc7bb0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88802a22a2a0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
RBP: ffff888025086000 R08: ffffffff8320a9f3 R09: 1ffff1100f474141
R10: dffffc0000000000 R11: ffffed100f474142 R12: 0000000000000100
R13: 0000000000000100 R14: 0000000000000200 R15: ffff88807a3a2000
FS:  00007f47de10c6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f47de192190 CR3: 00000000799c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	4d                   	rex.WRB
   1:	4e fe                	rex.WRX (bad)
   3:	31 ff                	xor    %edi,%edi
   5:	4c 89 e6             	mov    %r12,%rsi
   8:	e8 6d dd 72 fe       	call   0xfe72dd7a
   d:	4d 85 e4             	test   %r12,%r12
  10:	0f 84 e2 04 00 00    	je     0x4f8
  16:	4c 89 f1             	mov    %r14,%rcx
  19:	4f 8d 74 25 00       	lea    0x0(%r13,%r12,1),%r14
  1e:	48 8b 14 24          	mov    (%rsp),%rdx
  22:	48 89 d0             	mov    %rdx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2d:	74 0d                	je     0x3c
  2f:	48 8b 3c 24          	mov    (%rsp),%rdi
  33:	e8 92 eb d6 fe       	call   0xfed6ebca
  38:	48 8b 14 24          	mov    (%rsp),%rdx
  3c:	48 8b 1a             	mov    (%rdx),%rbx


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

