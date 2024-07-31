Return-Path: <linux-kernel+bounces-269966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDBD943967
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1B8281DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6016D4E5;
	Wed, 31 Jul 2024 23:30:34 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462D1BC4E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468633; cv=none; b=lYNZJWRhEKkI8hTZshxqWfajp9Zr02WHyAcJvN+pVLkJs7ZPsDhvLUECtBndRzP8f2+58dEp2qgR/TCeKy0WwXv04SlA8L6p9ann7ws/2CnNrJcmMy4N/uPne1uJXpx58jbedh23iHZdJLYrcZEGHxF46yCpWJS6mEGRrOphrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468633; c=relaxed/simple;
	bh=XUpF4DvOXkpfDAntmP6p1+gNtvbT+XAWTlGeu7erC9I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ht44RQDy7SU977tPj8bol7pIokEMG8XBXAAL7IfhXOhwzCv4W6JSvcTNeTbrZs29zkP0V8ip2BWx/k+rPIiyCwTIHlWrXtXRByWLmpPF/PJwvjqsFWJXUX4lv7MDf9Uez5o6pguiMX+ZlrCp9wudsoSR4fzSm5KP3YMbV4DshYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-397e0efded3so117513425ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722468631; x=1723073431;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWWmCPtOr50uaaU/V+ju7X8r7O818J2RLtGEzj/fVE8=;
        b=R6HqOxS6KF7Vbm9J6yhVQvO0vfMICrMQy8+xrPaB47qDRgfoXBoVqzxT5SSf0XVeoq
         8NiKSpVH6F+B7bSpUfqpaDvm3KtAFJsxmmOsdB+PCaqwjlV9/WIl2EcmptjkVOstxTgc
         96ZE6OqPdJZ2qY7FSFwF5FMDTZ4pNewJmy23YfywBua4JFUQ5lwutcn1gfV63O/jAyL5
         6HlnJP8bjwy+pASt2ClrBkelKUHwI+U2fXuWGQMVbhzLlTfh9Rj3c9XcVTY1Rs8nQYEl
         gZiDhdOh2GttEMJr1LxBt6bLdI9Gap7FxUTZq25zEc/kZCHNMFr1g5F4MFLG6MwFlsjY
         LJyg==
X-Gm-Message-State: AOJu0YyjS8M7qFGEwtpPMKzxlQvZN1DbaB1VvsCNQDSNlhD6DYcZ1l72
	8vDKYVZFt30v9UdUvBl8CbGOOMxo8h9YJOba7zDprUZ9qK+EaAy8vjs1gxiaC1JFviQ4IeRGt2v
	kP3vrSdiRAuOIZAREYuYUvuQ0JU661exPao9UgO9Q1QcgHsnBcRUUPTE=
X-Google-Smtp-Source: AGHT+IFeulVcdeC2coLustktPxXJOur9DfKF/sSzOhaMghTScyHhGZLCGokCIVysneIpnt7CHPGMBsXWkwakG/4Ay3oCuhDOgEcg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39b183c0666mr646365ab.4.1722468626073; Wed, 31 Jul 2024
 16:30:26 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:30:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000982020061e937a49@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel paging request in find_lock_lowest_rq
From: syzbot <syzbot+54ac85e4189aac460540@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f546873149 minmax: improve macro expansion and type chec..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17688f9d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=54ac85e4189aac460540
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e475c4ebb27/disk-22f54687.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/333e92710b31/vmlinux-22f54687.xz
kernel image: https://storage.googleapis.com/syzbot-assets/830d57b60fec/bzImage-22f54687.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+54ac85e4189aac460540@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbfff459d822
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 23ffe3067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 15194 Comm: syz.4.1359 Not tainted 6.11.0-rc1-syzkaller-00044-g22f546873149 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0018:ffffc9000396f820 EFLAGS: 00010086
RAX: 0000000001eb8501 RBX: 1ffffffff459d822 RCX: ffffffff816fbdab
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa2cec110
RBP: ffffffffffffffff R08: ffffffffa2cec117 R09: 1ffffffff459d822
R10: dffffc0000000000 R11: fffffbfff459d822 R12: ffff88802fa8bc00
R13: ffff88802fa8c6d8 R14: dffffc0000000001 R15: fffffbfff459d823
FS:  000055556b4f9500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff459d822 CR3: 000000007857a000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xc8b/0x2040 kernel/locking/lockdep.c:5112
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
 _double_lock_balance kernel/sched/sched.h:2760 [inline]
 double_lock_balance kernel/sched/sched.h:2805 [inline]
 find_lock_lowest_rq+0x1e1/0x670 kernel/sched/rt.c:1941
 push_rt_task+0x13f/0x7e0 kernel/sched/rt.c:2074
 push_rt_tasks kernel/sched/rt.c:2124 [inline]
 task_woken_rt+0x14c/0x220 kernel/sched/rt.c:2424
 ttwu_do_activate+0x338/0x7e0 kernel/sched/core.c:3594
 ttwu_queue kernel/sched/core.c:3846 [inline]
 try_to_wake_up+0x884/0x1470 kernel/sched/core.c:4167
 signal_wake_up_state+0xb4/0x120 kernel/signal.c:773
 signal_wake_up include/linux/sched/signal.h:448 [inline]
 zap_other_threads+0x2fd/0x3e0 kernel/signal.c:1384
 do_group_exit+0x18a/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f422eb773b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe323e3558 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f422eb773b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffe323e35ac R08: 0000000000000006 R09: 0000000000133833
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000133833 R14: 0000000000133449 R15: 00007ffe323e3600
 </TASK>
Modules linked in:
CR2: fffffbfff459d822
---[ end trace 0000000000000000 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0018:ffffc9000396f820 EFLAGS: 00010086
RAX: 0000000001eb8501 RBX: 1ffffffff459d822 RCX: ffffffff816fbdab
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffffa2cec110
RBP: ffffffffffffffff R08: ffffffffa2cec117 R09: 1ffffffff459d822
R10: dffffc0000000000 R11: fffffbfff459d822 R12: ffff88802fa8bc00
R13: ffff88802fa8c6d8 R14: dffffc0000000001 R15: fffffbfff459d823
FS:  000055556b4f9500(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff459d822 CR3: 000000007857a000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 4f 8d             	fisttps -0x73(%rdi)
   3:	3c 31                	cmp    $0x31,%al
   5:	4c 89 fd             	mov    %r15,%rbp
   8:	4c 29 dd             	sub    %r11,%rbp
   b:	48 83 fd 10          	cmp    $0x10,%rbp
   f:	7f 29                	jg     0x3a
  11:	48 85 ed             	test   %rbp,%rbp
  14:	0f 84 3e 01 00 00    	je     0x158
  1a:	4c 89 cd             	mov    %r9,%rbp
  1d:	48 f7 d5             	not    %rbp
  20:	48 01 dd             	add    %rbx,%rbp
* 23:	41 80 3b 00          	cmpb   $0x0,(%r11) <-- trapping instruction
  27:	0f 85 c9 01 00 00    	jne    0x1f6
  2d:	49 ff c3             	inc    %r11
  30:	48 ff c5             	inc    %rbp
  33:	75 ee                	jne    0x23
  35:	e9                   	.byte 0xe9
  36:	1e                   	(bad)
  37:	01 00                	add    %eax,(%rax)


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

