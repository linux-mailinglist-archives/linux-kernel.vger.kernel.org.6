Return-Path: <linux-kernel+bounces-255848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555089345AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8F8B21E88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821F849C;
	Thu, 18 Jul 2024 01:20:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49941B86CB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265627; cv=none; b=JQUyWf8EG/mgnllc45NlWr4BLhqHv2SP5HKjsiVLKgVnOthOWTjRfrA5NoBcFpPhIY1LlyM3sypcbR8mvfGz4YP+Q+vypS9SMhqxUymrsc4R0gL48zZQnxVzvhLsZPuNHLfPAte6tQvs2NwQo1YRb1bd91pzMmdK087SH+ZPVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265627; c=relaxed/simple;
	bh=xbyOXpcyZ/7pT8s2/UyGXvPdeLwgsn9/dfDJe+UFmP4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UcTecF+QxFg5PlfT9hM1tf+Jr1RgIr5ivziZR1OIDR2pOugNyhBSiz5eCTbd/ziSYwAp5RMtX7ttmul/4/MjevgtrAvjYUSORzqA9Okvnjhi8Atb3QCz11s+cTBfC8x2d4MDuuwhnDaGP3wY0AQke0LtNUqmGxDANe86HrmHzCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f682b4694aso38588039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721265625; x=1721870425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PxjsblxnH5iuA7NfAqwmspI+mx3z20tnA2XR1wlHmO8=;
        b=ZmR2RQoeyjJ1ePK8wDImMDTDYxoF7SIPjA5I61K/61LfOYnZ5N2XAkWMJDcpy3Rebj
         4+esfhbzl66pP4kNT5rJffeQgsQHS9d9AoAmLH98cxKwYezqyy4AGXpI5j8eWKF+HKvm
         wB68MPh+DgLdwaeDN9DBoRMokcRSdiUjthCy13iK0yblKbPejQRbiEYpMXv4o6oAp54o
         bAWfyKN/X9wdR8B4AnQSdwegrrZRpo7gzBKMpRmzVShoQGrMiUIAsLRJjRZWCjHkJAir
         mY/HC2wmQG8VOQGYp83Pawche2pmP0HLkWUTbsukAJj2MztJ9qlzkMtMxN9+XxY7Shcg
         SKgg==
X-Forwarded-Encrypted: i=1; AJvYcCWGMDB9xVuRYPecCha+YuOtIsJx6XIG1wHiNTA4pcVSz/K4gl50fWFA/3YPexNjZC0qVrK5rAMJjZHDodKt7TizpuSaP+5KnaoKAkUI
X-Gm-Message-State: AOJu0YxM9LGRvd2Y4gKc8e8Z9gO3KWGHY9HxyFz6FP2QzfNtTjhUDld4
	51R4JPjffDc1l2KVvgyuw4hH2ylNTaKwcpWpuh8mmt8crgLwwybv88CMyu42NE7hucfDa+e1Fe6
	UoQF8wk6myDXf7dnvm3uu4srHDgQus0hJoviRTzLMZ0rxoBrzTuoOUmA=
X-Google-Smtp-Source: AGHT+IHvzSWERrgqmpHFd9R48m18q44H+dXyjzOcKvjljWu3+t9iCua050UU8igmgPyN0Aw9P+7aH3B2dz42plKypis44oN/8Grk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3015:b0:4b9:2092:c7c9 with SMTP id
 8926c6da1cb9f-4c215ce0877mr171422173.5.1721265624823; Wed, 17 Jul 2024
 18:20:24 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:20:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021e299061d7b6219@google.com>
Subject: [syzbot] [io-uring?] general protection fault in __io_remove_buffers
From: syzbot <syzbot+2074b1a3d447915c6f1c@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d67978318827 Merge tag 'x86_cpu_for_v6.11_rc1' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1178e9e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e206d588252bd3ff
dashboard link: https://syzkaller.appspot.com/bug?extid=2074b1a3d447915c6f1c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e07d9e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16adf045980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f34b31760156/disk-d6797831.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a92e51d8d32e/vmlinux-d6797831.xz
kernel image: https://storage.googleapis.com/syzbot-assets/000a6a162550/bzImage-d6797831.xz

The issue was bisected to:

commit 87585b05757dc70545efb434669708d276125559
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 13 02:24:21 2024 +0000

    io_uring/kbuf: use vm_insert_pages() for mmap'ed pbuf ring

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16458ba5980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15458ba5980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11458ba5980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2074b1a3d447915c6f1c@syzkaller.appspotmail.com
Fixes: 87585b05757d ("io_uring/kbuf: use vm_insert_pages() for mmap'ed pbuf ring")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 35 Comm: kworker/u8:2 Not tainted 6.10.0-syzkaller-01155-gd67978318827 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: iou_exit io_ring_exit_work
RIP: 0010:__io_remove_buffers+0xac/0x700 io_uring/kbuf.c:341
Code: 42 80 3c 28 00 74 08 48 89 df e8 5f 02 5b fd 4d 89 fe 48 89 6c 24 40 48 89 5c 24 18 48 8b 1b 48 83 c3 0e 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 3b 05 00 00 44 0f b7 3b 49 8d 7c 24 16
RSP: 0018:ffffc90000ab7840 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff888017a8da00
RDX: ffff888017a8da00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff110052be8e4 R08: ffffffff849ddaa4 R09: 1ffff110052be8e3
R10: dffffc0000000000 R11: ffffed10052be8e4 R12: ffff8880295f4700
R13: dffffc0000000000 R14: ffff8880295f4720 R15: ffff8880295f4720
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555589c12650 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 io_put_bl io_uring/kbuf.c:378 [inline]
 io_destroy_buffers+0x14e/0x490 io_uring/kbuf.c:392
 io_ring_ctx_free+0xa00/0x1070 io_uring/io_uring.c:2613
 io_ring_exit_work+0x80f/0x8a0 io_uring/io_uring.c:2844
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__io_remove_buffers+0xac/0x700 io_uring/kbuf.c:341
Code: 42 80 3c 28 00 74 08 48 89 df e8 5f 02 5b fd 4d 89 fe 48 89 6c 24 40 48 89 5c 24 18 48 8b 1b 48 83 c3 0e 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 3b 05 00 00 44 0f b7 3b 49 8d 7c 24 16
RSP: 0018:ffffc90000ab7840 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff888017a8da00
RDX: ffff888017a8da00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 1ffff110052be8e4 R08: ffffffff849ddaa4 R09: 1ffff110052be8e3
R10: dffffc0000000000 R11: ffffed10052be8e4 R12: ffff8880295f4700
R13: dffffc0000000000 R14: ffff8880295f4720 R15: ffff8880295f4720
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555589c12650 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   5:	74 08                	je     0xf
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 5f 02 5b fd       	call   0xfd5b026e
   f:	4d 89 fe             	mov    %r15,%r14
  12:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
  17:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 0e          	add    $0xe,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 3b 05 00 00    	jne    0x572
  37:	44 0f b7 3b          	movzwl (%rbx),%r15d
  3b:	49 8d 7c 24 16       	lea    0x16(%r12),%rdi


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

