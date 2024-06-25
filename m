Return-Path: <linux-kernel+bounces-229833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C3E9174DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD691F22E28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A04A17F500;
	Tue, 25 Jun 2024 23:42:22 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9A17D36F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358941; cv=none; b=QytzLK6cTCCPOQ15Hd0FdXlWx0ggY7mnWreoJPJybd1KLOKBFtPp/WK4Bc0+DTqjk7ZMs53Mm/upOD/4RF1nzafYHxK9OuKABI/og/PV/HN2x38MayJ7kdjEpLPlZ52yxzk+w3DCXFuvk+WHxA9hZJ7v2wUT4/GEwRfzK+Wp5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358941; c=relaxed/simple;
	bh=AdFn6OkXulDOBMBfMECWAYnD3YPL56hyXi6+6UTutPU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q4XirbCB50VvCEU5w9c/elzzTPZX07I6006DxE0b04yZHp2ps8sZxtpXXd6xvCRIc2wUUBdEj1NhRY37MCxcB4p56Y4nB4lzPZlCe95ojM6we/p3fQyk4iQIAGOyE16J1TPIwrAddeHHvycAb0OkZKCp4PP9nT57uK5vue1x4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so854595339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719358939; x=1719963739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqKAcSQwI2SIsRhrE5t/+yvyhKPqaBXQS6h9y4xNZPc=;
        b=tW0NcDlhWCqMgw97jwkuhd7pJAwTyVJmsghm05An9gBoO7DtXMpZplDbUw1ygQ4yNf
         u53WYKUpDJd9KoWEQBGNjpMQKlo7G2AGB88MW1hKrHgvE3medr7pXIRLhVC+Bf6qF3SM
         eGhqNxfSLk0aE0CCXto7JjkNiY8gCTHkGQN4m+TQ8ZWBUCd0pxJjPl/iJwTXxx0ftOb+
         RkuiL+75/GgFFXvzZ5SMCuoy4+sSTt+g/otWXT2qub07Z4SCGeEmiBs9PEem7X6ZVxsw
         QdB4hwxEJ+LpbBADPL14pNjUvRsYWxKrTycOuZuAmNinufW+2Ma/kIN8rHtg2MP5rFD8
         fygA==
X-Forwarded-Encrypted: i=1; AJvYcCUiVWp/EzV0ov3kQZQkbuFQkuHajd3GeWoIXQ1usgInBlQdGeRKKS1sBmq4gDgrb8De2exQHVcObSFWUcl80ort5ihtVX1J9LBaqIoU
X-Gm-Message-State: AOJu0YzCEb4ABxhmjJq4dURGAOOKkApu4+KuQgNyIrqiHyWTYa+DGPTR
	0bx+klJymGOy0V1ykJyCPXEQi5KYjlu3IBRUm6E32wX7ZS4i/i8/1v6gb8RGVzNoPSbJx7R8MW2
	40T1IjcmbCBySSl5LuYhTJ9xAwZGLfIWOhdDj/km+LiY/0gMd01Abv2I=
X-Google-Smtp-Source: AGHT+IHoWe0Mz/X+64f1dBQTkLjueC86b6lbnNpJElaNpk9cRk338w72phhfRZ0CVPT0Y7NI9rMDmh1iPeIJ1PWYMmdHP/gJQY+A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c1:b0:7eb:99c1:372d with SMTP id
 ca18e2360f4ac-7f3a4d677f6mr30012139f.0.1719358939506; Tue, 25 Jun 2024
 16:42:19 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:42:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4be14061bbf7229@google.com>
Subject: [syzbot] [udf?] BUG: unable to handle kernel paging request in __brelse
From: syzbot <syzbot+8c750412421a6826fb6f@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f76698bd9a8c Add linux-next specific files for 20240621
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a690d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca79e3c3b9118bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=8c750412421a6826fb6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dbf741980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dc4151980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f204c5d02251/disk-f76698bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50289c7e8999/vmlinux-f76698bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c360e133a94f/bzImage-f76698bd.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9c9f9d6ff90f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c750412421a6826fb6f@syzkaller.appspotmail.com

UDF-fs: Scanning with blocksize 2048 failed
UDF-fs: error (device loop0): udf_read_tagged: read failed, block=256, location=256
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
BUG: unable to handle page fault for address: ffffffffffffffeb
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD e136067 P4D e136067 PUD e138067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5094 Comm: syz-executor927 Not tainted 6.10.0-rc4-next-20240621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:__brelse+0x38/0xa0 fs/buffer.c:1235
Code: 48 83 c3 60 48 89 df be 04 00 00 00 e8 21 e9 dc ff 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 44 <8b> 2b 31 ff 89 ee e8 ad 83 76 ff 85 ed 74 17 e8 64 7f 76 ff 48 89
RSP: 0018:ffffc90003447ac8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffeb RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffffffffeb
RBP: 0000000000000008 R08: ffffffffffffffee R09: 1ffffffffffffffd
R10: dffffc0000000000 R11: fffffbfffffffffe R12: 0000000000000008
R13: ffff888028efb440 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffeb CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 brelse include/linux/buffer_head.h:325 [inline]
 udf_sb_free_bitmap fs/udf/super.c:339 [inline]
 udf_free_partition fs/udf/super.c:352 [inline]
 udf_sb_free_partitions+0x1d5/0x540 fs/udf/super.c:377
 udf_put_super+0x113/0x160 fs/udf/super.c:2367
 generic_shutdown_super+0x136/0x2d0 fs/super.c:642
 kill_block_super+0x44/0x90 fs/super.c:1685
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x28e0 kernel/exit.c:876
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e47397789
Code: Unable to access opcode bytes at 0x7f5e4739775f.
RSP: 002b:00007ffd91c73db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5e47397789
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007f5e474132b0 R08: ffffffffffffffb8 R09: 00007ffd91c73e90
R10: 00007ffd91c73ce0 R11: 0000000000000246 R12: 00007f5e474132b0
R13: 0000000000000000 R14: 00007f5e47414020 R15: 00007f5e47365cd0
 </TASK>
Modules linked in:
CR2: ffffffffffffffeb
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:__brelse+0x38/0xa0 fs/buffer.c:1235
Code: 48 83 c3 60 48 89 df be 04 00 00 00 e8 21 e9 dc ff 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 44 <8b> 2b 31 ff 89 ee e8 ad 83 76 ff 85 ed 74 17 e8 64 7f 76 ff 48 89
RSP: 0018:ffffc90003447ac8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffeb RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffffffffeb
RBP: 0000000000000008 R08: ffffffffffffffee R09: 1ffffffffffffffd
R10: dffffc0000000000 R11: fffffbfffffffffe R12: 0000000000000008
R13: ffff888028efb440 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffeb CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 83 c3 60          	add    $0x60,%rbx
   4:	48 89 df             	mov    %rbx,%rdi
   7:	be 04 00 00 00       	mov    $0x4,%esi
   c:	e8 21 e9 dc ff       	call   0xffdce932
  11:	48 89 d8             	mov    %rbx,%rax
  14:	48 c1 e8 03          	shr    $0x3,%rax
  18:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  1f:	fc ff df
  22:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
  26:	84 c0                	test   %al,%al
  28:	75 44                	jne    0x6e
* 2a:	8b 2b                	mov    (%rbx),%ebp <-- trapping instruction
  2c:	31 ff                	xor    %edi,%edi
  2e:	89 ee                	mov    %ebp,%esi
  30:	e8 ad 83 76 ff       	call   0xff7683e2
  35:	85 ed                	test   %ebp,%ebp
  37:	74 17                	je     0x50
  39:	e8 64 7f 76 ff       	call   0xff767fa2
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


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

