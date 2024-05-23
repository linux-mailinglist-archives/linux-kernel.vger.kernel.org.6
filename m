Return-Path: <linux-kernel+bounces-187312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467018CD001
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1102281E52
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CC140394;
	Thu, 23 May 2024 10:09:29 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68513D509
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458969; cv=none; b=ML0yFL6zJSo0b8w8zYj51DJoRnRXC7dWw8O1tvSXqh7ksRxLlz6ilT+yjSudmh92qzHpQclMb1mQSpsWNEcBd2JvBZwRDcmfH/6IwROFHCSLCmc/aCGjvPSsssYLevTnaTXE02EwWg6dnGMze782qjGncJZw4HsLmDjLby4yxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458969; c=relaxed/simple;
	bh=EH+6eVd2Gf7Sx35lSKudWpxQMOLMJyswS6IMwYsUsHw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nzQveg6H1ZwTF3b6ZGzzyImDY14PBy+rGwO2T9vO7BwtTXcvqJZwwAchcjEl+T74yhvo3x1BHy4TTMU9uAO8Ao/3yJfMiJWy+/b5tyG5zJsDIQRctNm/+ZEk4U2lUVZtzHHtUcBoMnP5aZMGVg2ZWZrTNxdy5sUFUu20O/sYzL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so161488139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458966; x=1717063766;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5V54uJoaI01GoSxTJqNHgxT4KIYMcv13EsDgDaZwqA=;
        b=RRxZ8LXIlysyIHt0uBzR+PGbSQBLqIivUqkJKs7EmD1NKuE72Wng/CngFgD0+5VuiO
         84nPiD9R0NZe27TxMvvtKWN33FM1HKma1Rv8eanRJ0OFHPEJrtiJVfdFo4VkpZic2tdg
         1EhJWS6vy8SA5EZSUinb4yZ4ve2n8TveRJu9uFLBWyAZJ6IdDDVdpu7xUEb8tydSklSe
         zKEjVWlotW6AuR2e3lIpLkKS80eGGy0NK8+PCKNMnn3VFPyIIf5yMTZJ9LVfEZBWSopO
         zH+9g6q1X6iS36xxv3LHhmpnKKOiXUzr+nRqSdTkWsDyTbm7AYVYtfGLXGziAFvCEVCh
         KKUA==
X-Forwarded-Encrypted: i=1; AJvYcCWQwCWtrSVI1DRfP1mut5KxPnF8vyqTV2S6ry44lfl1mOHlEOUu9BotSrxID9eS6YLJmxusLHuGkMhou1koPoyeJlWxBL0gejgau4R8
X-Gm-Message-State: AOJu0YxOdIHhemkaOjnTcHpPcDlFIVyDiuvnuDCKTbm05oW1FOeyq4GV
	ImQSHKt0XO9/kkoQMqXeWoe90Pi4sAPvJuGMf+rvZ85jvcwgT8Ld0rywthScF73i9PirRq1V4R6
	BGtcKGifpFjjjg4MrRR7diTHJ3Y6ujwikvNeo8nAZIfSH++X50bp7j1U=
X-Google-Smtp-Source: AGHT+IHsPtYlI4SiZZsRRh4QcUstvSKp3c/RkiIuQnbq7FD5UBW8Ai50q9CBtCbkVzQJ94Y21y0FHhUx2mrG7pBhbBrDZREZIKlq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1f06:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4afe36da4f9mr166056173.1.1716458966612; Thu, 23 May 2024
 03:09:26 -0700 (PDT)
Date: Thu, 23 May 2024 03:09:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa09d906191c3ee5@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __put_partials
From: syzbot <syzbot+691e9fcaee2c9ae3d900@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f16eb0549ab Merge tag 'char-misc-6.10-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1491703c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f4625418c9ed5c8
dashboard link: https://syzkaller.appspot.com/bug?extid=691e9fcaee2c9ae3d900
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-5f16eb05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20ac83ea5f8c/vmlinux-5f16eb05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31519c4f23c8/bzImage-5f16eb05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+691e9fcaee2c9ae3d900@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000013
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 30 Comm: kworker/1:0 Not tainted 6.9.0-syzkaller-11919-g5f16eb0549ab #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: slub_flushwq flush_cpu_slab
RIP: 0010:__put_partials+0x84/0x170 mm/slub.c:2966
Code: 7b 50 4c 89 6d 18 48 89 55 10 4d 89 7d 00 48 89 ef e8 90 b4 ff ff f0 80 48 01 02 4d 85 e4 0f 84 aa 00 00 00 48 89 df 4c 89 e5 <4d> 8b 64 24 10 48 8b 45 00 48 83 f8 ff 74 69 48 8b 45 00 48 8b 0c
RSP: 0018:ffffc9000057fc80 EFLAGS: 00010246
RAX: 0000000000000002 RBX: ffff888015f81500 RCX: 1ffffffff28425f0
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000001 R09: fffffbfff283fe56
R10: ffffffff941ff2b7 R11: 0000000000000002 R12: 0000000000000003
R13: ffff88802c13db40 R14: 0000000000000000 R15: ffffc9000057fd80
FS:  0000000000000000(0000) GS:ffff88802c100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000013 CR3: 000000001e558000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: 0000000000000013
---[ end trace 0000000000000000 ]---
RIP: 0010:__put_partials+0x84/0x170 mm/slub.c:2966
Code: 7b 50 4c 89 6d 18 48 89 55 10 4d 89 7d 00 48 89 ef e8 90 b4 ff ff f0 80 48 01 02 4d 85 e4 0f 84 aa 00 00 00 48 89 df 4c 89 e5 <4d> 8b 64 24 10 48 8b 45 00 48 83 f8 ff 74 69 48 8b 45 00 48 8b 0c
RSP: 0018:ffffc9000057fc80 EFLAGS: 00010246
RAX: 0000000000000002 RBX: ffff888015f81500 RCX: 1ffffffff28425f0
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 0000000000000003 R08: 0000000000000001 R09: fffffbfff283fe56
R10: ffffffff941ff2b7 R11: 0000000000000002 R12: 0000000000000003
R13: ffff88802c13db40 R14: 0000000000000000 R15: ffffc9000057fd80
FS:  0000000000000000(0000) GS:ffff88802c100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000013 CR3: 000000001e558000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	7b 50                	jnp    0x52
   2:	4c 89 6d 18          	mov    %r13,0x18(%rbp)
   6:	48 89 55 10          	mov    %rdx,0x10(%rbp)
   a:	4d 89 7d 00          	mov    %r15,0x0(%r13)
   e:	48 89 ef             	mov    %rbp,%rdi
  11:	e8 90 b4 ff ff       	call   0xffffb4a6
  16:	f0 80 48 01 02       	lock orb $0x2,0x1(%rax)
  1b:	4d 85 e4             	test   %r12,%r12
  1e:	0f 84 aa 00 00 00    	je     0xce
  24:	48 89 df             	mov    %rbx,%rdi
  27:	4c 89 e5             	mov    %r12,%rbp
* 2a:	4d 8b 64 24 10       	mov    0x10(%r12),%r12 <-- trapping instruction
  2f:	48 8b 45 00          	mov    0x0(%rbp),%rax
  33:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  37:	74 69                	je     0xa2
  39:	48 8b 45 00          	mov    0x0(%rbp),%rax
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b
  3f:	0c                   	.byte 0xc


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

