Return-Path: <linux-kernel+bounces-364870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4039299DA60
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A87B1F21E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C91D89FA;
	Mon, 14 Oct 2024 23:55:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A81E4A6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950128; cv=none; b=PPRfe91tUhGvt89fA1buiEhQtO8kCAQdSRubh0yUSn1bG8Se0Ec5Gh9edq0Jwj5NroTUmuGsYgbNt+LbxanMbmp1C90LLKHIUpAy6g2pkmOVc5YvKToGnvgWVSoxGnFaLtKn0xcC9o3bCdJL4T49KHyAmkL5qskwlz7PBQWTTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950128; c=relaxed/simple;
	bh=pKRJ/EDl+x+dnJVYQqperO92BTKyZnUyvFpXDQ/dTY0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mgK2p2HBOZr1o47lnEMPMsysIc6vstXGgxTAffAx7dO3FHJO31Y8upXJ7GdUOl1MuPnVpoXnOATWFu8RVPza7c/lOjEBqr3STQ4hn67na4Es74/a6jWaY2+rEBBmKPsJjdApTxkc5Bh39B+0QJOozBoYQK4sieY6jueqKAMUTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7129255so52961995ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950126; x=1729554926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfriBVJifWLXnmrq9aJLJK4bSSrJh0VAue7qVPePLUg=;
        b=MtclKKsjtzj+/nRPkBdxU3QZwVQOY+FqpQBQUmjBltfIl36+4Xg2cY99Jd8TFlNwz8
         G4PAVmnuu6qtD96ClNjO1WLUzCTLABtfoIH1fhfNf0IljFWoBO/dgqeyzcyP+vNp9cDV
         OW3wPrdhQnEFH+ENZUNvDgC7IF3Kb+jKB1sjeqxco4ptfu4aE3BA4wpbrCBs5X03JcGF
         pFpnBSH7UWyTYEQNfZNDPS/gBFLaKWUL0l/mKFtwtR5dWD8/oHF1AxxXL1vCoBXumCoi
         p1AlFXy10Isoalea+e6WhHcJ6viZdV4zuQnHHFgAcCVE36p/N2TYLpDs3fy/tZjHR2fC
         esyg==
X-Gm-Message-State: AOJu0YwNmMkXYapJSpo4QzJiZKZTrEmPAuNlpiopBJOETCbeH/XGTlRZ
	tzK1Z8IXEpVVns54Vsjjh3cz+7JisgvZv92Sj0X8yWRd1q8vbB8HJDd9k4ggiv6YdRMTGdlbx6Z
	/X/m4OFN43GNHGrTZOKio55qeVHwIfsZe2w6RlH2Af0ji6REfWHlHhRQ=
X-Google-Smtp-Source: AGHT+IEyfEEfNrjNAQ6+rSm+HkmJQRlEBUc7RiiljCS4NCmQUD31jMhyZfQYgRx9sEZH9ZTbakortt4KbqgNKHKK1ltD7aQRzN1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c01:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a3b603efb5mr103737115ab.18.1728950126302; Mon, 14 Oct 2024
 16:55:26 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:55:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670daf6e.050a0220.d9b66.014a.GAE@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in rto_push_irq_work_func
From: syzbot <syzbot+da051a9137a15fa8ecdf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb952c47d154 Merge tag 'for-6.12-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1286d040580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=da051a9137a15fa8ecdf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9fcce84b7ce/disk-eb952c47.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17fa3acabc90/vmlinux-eb952c47.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7486baaeb58/bzImage-eb952c47.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da051a9137a15fa8ecdf@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5475 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 0 PID: 5475 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4826 [inline]
WARNING: CPU: 0 PID: 5475 at kernel/locking/lockdep.c:232 __lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Modules linked in:
CPU: 0 UID: 0 PID: 5475 Comm: syz.4.27 Not tainted 6.12.0-rc2-syzkaller-00100-geb952c47d154 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4826 [inline]
RIP: 0010:__lock_acquire+0x58c/0x2050 kernel/locking/lockdep.c:5152
Code: 00 00 83 3d 65 be ac 0e 00 75 23 90 48 c7 c7 60 c9 0a 8c 48 c7 c6 00 cc 0a 8c e8 3f 7f e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90000007c10 EFLAGS: 00010046
RAX: fb0486e3ebc62c00 RBX: 0000000000001368 RCX: ffff88802a243c00
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: ffffffff8155e402 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: ffff88802a243c00
R13: 0000000000001368 R14: 1ffff110054488e5 R15: ffff88802a244728
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc4deaef98 CR3: 000000007f75e000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:601
 raw_spin_rq_lock kernel/sched/sched.h:1505 [inline]
 rto_push_irq_work_func+0x86/0x350 kernel/sched/rt.c:2259
 irq_work_single+0x136/0x240 kernel/irq_work.c:221
 __flush_smp_call_function_queue+0xa17/0x1690 kernel/smp.c:574
 __sysvec_call_function_single+0xb8/0x430 arch/x86/kernel/smp.c:271
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
 sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
 </IRQ>
 <TASK>
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:709
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5196
Code: c9 50 e8 c9 01 0c 00 48 83 c4 08 4c 89 f7 e8 4d 39 00 00 e9 de 04 00 00 4c 89 f7 e8 f0 ee 6a 0a e8 5b 57 38 00 fb 48 8b 5d c0 <48> 8d bb f8 15 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc900033ff6a8 EFLAGS: 00000286
RAX: fb0486e3ebc62c00 RBX: ffff88802a243c00 RCX: ffffffff9a3cc903
RDX: dffffc0000000000 RSI: ffffffff8c0acac0 RDI: ffffffff8c60fb20
RBP: ffffc900033ff6f0 R08: ffffffff901cee2f R09: 1ffffffff2039dc5
R10: dffffc0000000000 R11: fffffbfff2039dc6 R12: 1ffff110170c7f14
R13: dffffc0000000000 R14: ffff8880b863ea80 R15: ffff8880b863f8a0
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x189d/0x4b30 kernel/sched/core.c:6682
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7004
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:707
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:116 [inline]
RIP: 0010:lock_release+0xdb/0xa30 kernel/locking/lockdep.c:5838
Code: 0f a3 1d 60 70 ac 0e 73 16 e8 41 58 0a 00 84 c0 75 0d 80 3d 5c 2c 96 0e 00 0f 84 fc 05 00 00 48 c7 c0 7c 20 1d 90 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1f 06 00 00 83 3d 7d a2 ac 0e 00 4c 8b
RSP: 0018:ffffc900033ffa80 EFLAGS: 00000217
RAX: 1ffffffff203a40f RBX: 0000000000000000 RCX: ffffffff81707dc0
RDX: 0000000000000000 RSI: ffffffff8c60fb00 RDI: ffffffff8c60fac0
RBP: ffffc900033ffbb8 R08: ffffffff901cee2f R09: 1ffffffff2039dc5
R10: dffffc0000000000 R11: fffffbfff2039dc6 R12: 1ffff9200067ff5c
R13: ffffffff820878c9 R14: ffffffff820878c9 R15: dffffc0000000000
 rcu_lock_release include/linux/rcupdate.h:347 [inline]
 rcu_read_unlock include/linux/rcupdate.h:880 [inline]
 percpu_ref_put_many include/linux/percpu-refcount.h:337 [inline]
 percpu_ref_put+0xfa/0x180 include/linux/percpu-refcount.h:351
 css_put include/linux/cgroup_refcnt.h:79 [inline]
 obj_cgroup_uncharge_pages+0x18f/0x210 mm/memcontrol.c:2604
 __memcg_kmem_uncharge_page+0xe9/0x290 mm/memcontrol.c:2676
 memcg_kmem_uncharge_page include/linux/memcontrol.h:1749 [inline]
 exit_task_stack_account+0x1e3/0x340 kernel/fork.c:567
 do_exit+0x1d02/0x28e0 kernel/exit.c:980
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee4c77dff9
Code: Unable to access opcode bytes at 0x7fee4c77dfcf.
RSP: 002b:00007ffc9b801388 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fee4c77dff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffc9b8013dc R08: 00007ffc9b80146f R09: 0000555592145590
R10: 0000000000000000 R11: 0000000000000246 R12: 00005555921455eb
R13: 0000555592145590 R14: 0000000000014e78 R15: 00007ffc9b801430
 </TASK>
----------------
Code disassembly (best guess):
   0:	c9                   	leave
   1:	50                   	push   %rax
   2:	e8 c9 01 0c 00       	call   0xc01d0
   7:	48 83 c4 08          	add    $0x8,%rsp
   b:	4c 89 f7             	mov    %r14,%rdi
   e:	e8 4d 39 00 00       	call   0x3960
  13:	e9 de 04 00 00       	jmp    0x4f6
  18:	4c 89 f7             	mov    %r14,%rdi
  1b:	e8 f0 ee 6a 0a       	call   0xa6aef10
  20:	e8 5b 57 38 00       	call   0x385780
  25:	fb                   	sti
  26:	48 8b 5d c0          	mov    -0x40(%rbp),%rbx
* 2a:	48 8d bb f8 15 00 00 	lea    0x15f8(%rbx),%rdi <-- trapping instruction
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	49                   	rex.WB
  39:	be 00 00 00 00       	mov    $0x0,%esi
  3e:	00 fc                	add    %bh,%ah


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

