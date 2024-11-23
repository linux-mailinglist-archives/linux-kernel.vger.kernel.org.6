Return-Path: <linux-kernel+bounces-419088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C99D694A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D10E281FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A018EAD;
	Sat, 23 Nov 2024 13:32:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1D566A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732368743; cv=none; b=nFUqBpDZhY025o2GYAtskLcGm4XcqDm9yoKEt54z3oHvL+cgP1952Sh0SxY9j9iBjj9vscxorDeInskKeimnaecKpZOTp7VAhdd8Olw0ItAvCse8nKyPBi8wMEmRnG+wPkcw6/tiYl3TlJsY+ogRESJVAKCLmleXqd/dhk3sVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732368743; c=relaxed/simple;
	bh=DrQ02F6Oc9kWIa5ZM/r6XAWq4LffNMH0KuL8IXBvwO4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eB/BsNQaoPO+4tW1gTmR/+U64t4wD6XF7d6HZoZ6W0sPnNkhbCFnwmWo95FCR+c7uNWF61RQmOK0BqH6VyVqsJg6GrnlYM9kK1+14tvKRy15Ak+FMIx9237mILi6fCk7shhm3hAxQQp3/5mtUi4EU248PT/0Z9xMnPLdkHlnjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso23557295ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732368741; x=1732973541;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngOiJmSODl1cgj0OCWiF6AgMIiy0Uf26+JCx/Q7klXo=;
        b=Jrq9ORtp1M0nW04WX1xuOgM1QSRX7bcVF5ITZDeAlWjLGJ4V7CEUzpx91mujz1Ebnm
         Wl8ZNfKOPMsohWNmdSbHC8YaO2hXMRT2B1mmdRiMADEV28UIz8JHqg54CyxUHOQU6kTr
         EuTp2b1TrTXgi22FP/P3jNlEy5dwIYqk15FkzdHE56sNDjcZqWju2b/v/j9TRm03ggpy
         Ih1ir4FOsL8Un9ShCmURnQDz8oSzkJ04VS55GrdYL/fUW27bmR88aNSpOCjAm2SQ5KKV
         Hv+1gARq0Qpr9piRt9ZWKSNEGtGi5ck4GT1R+aYUkaSG4ZCVQhQhA4f9o7wU9/reONl9
         1ytw==
X-Forwarded-Encrypted: i=1; AJvYcCX9MGbbRGa4cJNotagTMjUww+bEJcAv5x+inhNsHPm0siSz0BKUdJ0fRxNAlj1GOF0eNZW+J6Yz/E8gtXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4tIOjNJUFJ4fxCZL/aZ4bx0V1keB8Kil4IuruDn2G0XvaDgb
	xFOxuQe9ENbb728U0J4h6JeqRTGGvP5BZuJRgXg/TTLqgFa+DlnjY4v8qyYk3dEABfZ/jsVXz/E
	2VrydKLAgELCcFB1VSN9ADdKNM56n7IvNwmmp/eFJIoN5PmzLHUcbMvw=
X-Google-Smtp-Source: AGHT+IF7OSYVM3EG270cwD21Z0pQZoM/KfrNKC/LTzmwNy8i3A0x/S64QUgnjC9SFBEaUN5GJoEH5vTH8WLkpQC5KF15L1QPgjGg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:3a7:70a4:6872 with SMTP id
 e9e14a558f8ab-3a79ad203ebmr63739685ab.9.1732368741417; Sat, 23 Nov 2024
 05:32:21 -0800 (PST)
Date: Sat, 23 Nov 2024 05:32:21 -0800
In-Reply-To: <67399883.050a0220.e1c64.0010.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741d965.050a0220.1cc393.0012.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: locking bug in try_to_wake_up (2)
From: syzbot <syzbot+6ac735cc9f9ce6ec2f74@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16017b78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
dashboard link: https://syzkaller.appspot.com/bug?extid=6ac735cc9f9ce6ec2f74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1098b6e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/112cedff0255/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f65020d28328/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fb4cb7df5b1/bzImage-06afb0f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ac735cc9f9ce6ec2f74@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 19 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 19 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4850 [inline]
WARNING: CPU: 1 PID: 19 at kernel/locking/lockdep.c:232 __lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Modules linked in:
CPU: 1 UID: 0 PID: 19 Comm: rcu_exp_gp_kthr Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4850 [inline]
RIP: 0010:__lock_acquire+0x564/0x2100 kernel/locking/lockdep.c:5176
Code: 00 00 83 3d 11 c9 ac 0e 00 75 23 90 48 c7 c7 80 d1 0a 8c 48 c7 c6 80 d4 0a 8c e8 77 64 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90000a18930 EFLAGS: 00010046
RAX: 9a7c2efbb9bd3e00 RBX: 00000000000010d8 RCX: ffff88801ced3c00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000c50d8 R08: ffffffff8155fe42 R09: 1ffff110170e519a
R10: dffffc0000000000 R11: ffffed10170e519b R12: ffff88801ced46c4
R13: 0000000000000005 R14: 1ffff110039da8e5 R15: ffff88801ced4728
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557b35c588 CR3: 0000000025380000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:606
 raw_spin_rq_lock kernel/sched/sched.h:1514 [inline]
 rq_lock kernel/sched/sched.h:1813 [inline]
 ttwu_queue kernel/sched/core.c:3991 [inline]
 try_to_wake_up+0x7e2/0x1470 kernel/sched/core.c:4321
 hrtimer_wakeup+0x62/0x80 kernel/time/hrtimer.c:1975
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59d/0xd50 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5243
Code: c9 50 e8 79 07 0c 00 48 83 c4 08 4c 89 f7 e8 9d 39 00 00 e9 de 04 00 00 4c 89 f7 e8 50 26 6c 0a e8 6b 91 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900001878e8 EFLAGS: 00000282
RAX: 9a7c2efbb9bd3e00 RBX: ffff88801ced3c00 RCX: ffffffff9a3ec903
RDX: dffffc0000000000 RSI: ffffffff8c0ad2e0 RDI: ffffffff8c6072a0
RBP: ffffc90000187930 R08: ffffffff901d2db7 R09: 1ffffffff203a5b6
R10: dffffc0000000000 R11: fffffbfff203a5b7 R12: 1ffff110170e7e9c
R13: dffffc0000000000 R14: ffff8880b863e6c0 R15: ffff8880b873f4e0
 context_switch kernel/sched/core.c:5372 [inline]
 __schedule+0x1858/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:536 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:649 [inline]
 rcu_exp_wait_wake kernel/rcu/tree_exp.h:678 [inline]
 rcu_exp_sel_wait_wake+0x77e/0x1dc0 kernel/rcu/tree_exp.h:712
 kthread_worker_fn+0x502/0xb70 kernel/kthread.c:844
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	c9                   	leave
   1:	50                   	push   %rax
   2:	e8 79 07 0c 00       	call   0xc0780
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 9d 39 00 00       	call   0x39b0
  13:	e9 de 04 00 00       	jmp    0x4f6
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 50 26 6c 0a       	call   0xa6c2670
  20:	e8 6b 91 38 00       	call   0x389190
  25:	fb                   	sti
  26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	49                   	rex.WB
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

