Return-Path: <linux-kernel+bounces-449721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7189F5539
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7D71888298
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7398E1FA177;
	Tue, 17 Dec 2024 17:47:24 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D4B1FA141
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457643; cv=none; b=ZBwOITrNRPNaWpdUOeZtvopMMu3hKc1IBxHcdOFTh7efIXsKm66AeElw8/LY7Uzf1UgJtc5tvdoGEfLc3i6QoLvUdZ98wWCI67UlXbUrZWZ7XxPlqV46jZxwUXc69k+mOWuiKcvTbPLJ6y63M1Z7fQ07wT7a3hhVU66NlG6Rzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457643; c=relaxed/simple;
	bh=b+TZkxmk2u8h8UaV2BNrIUoZivrxLkVTGBpvENiYWRs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k1hfhCjdgsCJsOqc9+DyUqkHsrHYcK8jibobQKjgCTJVSpUFip8nvvBsCMcYlrMPT3oOzAicJ2flkOFucnAYvlPXd3fbjB2JR5tGglnmpvZZQYgWPvIf2R4PIURiCsAQ3k6/LVjUQ7Kbnx7IkwoBwzY3VLvsu4hkxpvvFjClQOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9cefa1969so58296925ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:47:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457641; x=1735062441;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62kluWVjxzTb0DG/ZSMNAu0U9dC4LPkqPgPDYDaszA0=;
        b=XHt11cdDGxYLwsKm7DJ5wlbXYes8Q812b7TlEQiyap88EJRngNdr10x75rgDFrONMo
         Yp3fCgcZ48V2eOKDJE449IQultN61d50+P3v4MdV/vRPQ9Vx8J8OQiqOxSsaETKfR/Bs
         LSZVMVhxCZBvLFIunfIFxrfc9IK7QGxvg8oD9Tkiyhj9HBnmIigYjrsNcYhIoCl12QBC
         4VieylUnhV6nhI9br9nKTRYi+Bu8lguG+F+8TvlVeGNEe/LkZ15s8Ra+kyR+5SrSJsWE
         H31L/Qx9Iz7BiWvqIgLzQAW+la+qeaAFHhQ2fHrVhVlo7/Dza1OjaKqs8Nej1N1Lc62I
         PlVw==
X-Gm-Message-State: AOJu0Yw2MVfuMXNn3pekBKg57QKxA1nx9gI5ByUkgltc67sfW137Abwn
	qPSpjI/gMpsCQLm1o1H8Ealio1nFtASCUM+/GbxvWsBx4bdaR/K/sIPC2paGHIl+ez1w6n3Xnj1
	n8LghFwYuGdGE6TnOql4C9lh96JNAbdqTmd94fH5gBqfCZGlStW84p4UnWw==
X-Google-Smtp-Source: AGHT+IGK4oZH7YXr9+xMXSR7JLFocSDZSIscmqeZ5MNKwPO3li12MBDjVF+MLgnMhHEv3e3tqLQr4cig/oN0aaIUTrtoqXcoGEtM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cd:b0:3a7:d5a6:1f9d with SMTP id
 e9e14a558f8ab-3aff5397ba4mr155360915ab.9.1734457641349; Tue, 17 Dec 2024
 09:47:21 -0800 (PST)
Date: Tue, 17 Dec 2024 09:47:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761b929.050a0220.29fcd0.0070.GAE@google.com>
Subject: [syzbot] [kernel?] general protection fault in account_kernel_stack (3)
From: syzbot <syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f44d154d6e3d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105e27e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=ff4aab278fa7e27e0f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cb02df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cb02df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/129158790532/disk-f44d154d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4893f23f2c39/vmlinux-f44d154d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b12b565fb71e/bzImage-f44d154d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff4aab278fa7e27e0f9e@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 18226 Comm: syz-executor293 Not tainted 6.13.0-rc3-syzkaller-00017-gf44d154d6e3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
RIP: 0010:mod_lruvec_page_state include/linux/vmstat.h:563 [inline]
RIP: 0010:account_kernel_stack+0x100/0x2e0 kernel/fork.c:546
Code: 00 49 8b 47 20 48 8d 2c d8 48 89 e8 48 c1 e8 03 42 80 3c 20 00 0f 85 be 01 00 00 48 8b 6d 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 9a 01 00 00 4c 8b 6d 08 31 ff 4d 89 ee 41 83
RSP: 0018:ffffc9001103fd78 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888078768000 RSI: ffffffff815906c9 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed100f0ed138
R10: ffff8880787689c3 R11: 0000000000000000 R12: dffffc0000000000
R13: dffffc0000000000 R14: 1ffff11003e74fc4 R15: ffff88801f3a7e00
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f040152f190 CR3: 000000000db7e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exit_task_stack_account+0x23/0xf0 kernel/fork.c:559
 do_exit+0x1c8a/0x2d70 kernel/exit.c:979
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1096
 x64_sys_call+0x151f/0x1720 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04014b3d69
Code: Unable to access opcode bytes at 0x7f04014b3d3f.
RSP: 002b:00007fffbefe3918 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f04014b3d69
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f040152d2b0 R08: ffffffffffffffb8 R09: 00007fffbefe39a8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f040152d2b0
R13: 0000000000000000 R14: 00007f040152ed80 R15: 00007f040147d5d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:242 [inline]
RIP: 0010:mod_lruvec_page_state include/linux/vmstat.h:563 [inline]
RIP: 0010:account_kernel_stack+0x100/0x2e0 kernel/fork.c:546
Code: 00 49 8b 47 20 48 8d 2c d8 48 89 e8 48 c1 e8 03 42 80 3c 20 00 0f 85 be 01 00 00 48 8b 6d 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 9a 01 00 00 4c 8b 6d 08 31 ff 4d 89 ee 41 83
RSP: 0018:ffffc9001103fd78 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888078768000 RSI: ffffffff815906c9 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed100f0ed138
R10: ffff8880787689c3 R11: 0000000000000000 R12: dffffc0000000000
R13: dffffc0000000000 R14: 1ffff11003e74fc4 R15: ffff88801f3a7e00
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f040152f190 CR3: 000000007ecd0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 49 8b             	add    %cl,-0x75(%rcx)
   3:	47 20 48 8d          	rex.RXB and %r9b,-0x73(%r8)
   7:	2c d8                	sub    $0xd8,%al
   9:	48 89 e8             	mov    %rbp,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  15:	0f 85 be 01 00 00    	jne    0x1d9
  1b:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  1f:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	0f 85 9a 01 00 00    	jne    0x1cf
  35:	4c 8b 6d 08          	mov    0x8(%rbp),%r13
  39:	31 ff                	xor    %edi,%edi
  3b:	4d 89 ee             	mov    %r13,%r14
  3e:	41                   	rex.B
  3f:	83                   	.byte 0x83


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

