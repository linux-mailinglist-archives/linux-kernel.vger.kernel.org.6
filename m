Return-Path: <linux-kernel+bounces-258132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD068938432
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCAF1C209D9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDED26D;
	Sun, 21 Jul 2024 09:26:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7C440C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721553965; cv=none; b=EzTfjpPVuV01+MsyTV9K0O0Xmmc2vN7MX6WJRAPoRlqYXkTJcPZ8MY/B65j5gsnIKEVnADACyVv9AvckObVymtPGSO9IrqQ5w8+Qs4t0t6Ap6qnWsGM73HIRaL0E3VlRExZ3px4P12DwrZ2TUuAVm8JJcsjSs1/VnEPkIHNWng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721553965; c=relaxed/simple;
	bh=yp3jrvrX9On9YBPFkrdY5yFG4jSHkjijcOa0D0stBt8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q4BqxvDQzsJqZ6H4TG8Q1+RJ3ZoGG7QHX2w48SjvdA9cP4AiTepIAYk/2LEkhOnOETDkcdpZ56WXMB9V1VlBsnAckH5Q0xSMhQVScHBTs06vlQAXYO/UGU5htkK3kRLalnB2HZIcK74BC217LPZnHufBWlQxE8OvShmalfmTPD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8041a66f2ebso507364439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 02:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721553963; x=1722158763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckQbhkkfZup3Qw9nPYdQVcqiKcT0FOlBRtELM5pES7Y=;
        b=HjSvK36GbozTih0pWgi2or8a8m/6HtzCrc6jko0/ALBmhxFeRNvKFE2pKeOoMuWYdv
         TQcU2VwJh+weN4oNiH0pLYK6/KuuK/XEKCLFd72t/C++Dlouf4se7TAct5JZuRvDxK+1
         mUVJm3n+UvK2VUKerL3KcG/IoQuORHxFBt2egBoVf6+iWvB34V+9YhWSJ3SiuGLQOeEr
         TUoOcUk6Yka8KKitBdWTDR5Ty/o89uCASrRlC3p9GsP/qEt8heRcbiCdmarBWjECKCQ3
         FOfZU6BbAsokA69F8rVMH1bjRg1mWIxjPCj73e+PH2NqW/kKONeRZbW9EcPITe97IB8H
         nEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEdaew21mBC8I5uP/qfJem+t4Ldh8HMk+TcfKWrdykMYsiF1DLdY4DqFj57xDgyGKcT2f03NugiIaXWC3CvFlISN9qCsUofYWE506r
X-Gm-Message-State: AOJu0YwrJWhYHwKiBZr82CByxxhs3WfHnmG92MbNAIt2wlnj6GQYUDUi
	T7XB4huSP9yj2tpVxfc6Zt3GJlwWTUQhw+5Ne+hvz2Uqia3BG7IiLIDHbTVOBLbwPyCyDJH3EXr
	XsqvuVSOp2tt8NclVib64wEzeNqNa5y7kGJGlYVT6m1qYxozb0s8DK3w=
X-Google-Smtp-Source: AGHT+IEdxoPw9Ix8HMe6DgpfePcRFI+sIQyO/ZLriMsU48ym4D+k9KhT+QfE0Z9wp7r8dquN81s1KIebcv558n5lZUlY3+jlDiup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8715:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4c23feb73f3mr319070173.5.1721553963417; Sun, 21 Jul 2024
 02:26:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 02:26:03 -0700
In-Reply-To: <20240721085206.230835-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007392c3061dbe8470@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __dev_flush

Oops: general protection fault, probably for non-canonical address 0xe3fffa2200be422b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0x1ffff11005f21158-0x1ffff11005f2115f]
CPU: 1 PID: 6413 Comm: syz.0.240 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__dev_flush+0x5b/0x160
Code: 48 89 ef e8 97 80 3a 00 48 8b 5d 00 48 39 eb 0f 84 ff 00 00 00 48 89 2c 24 49 89 dd 49 c1 ed 03 48 b8 00 00 00 00 00 fc ff df <41> 80 7c 05 00 00 74 08 48 89 df e8 65 80 3a 00 48 8b 03 48 89 44
RSP: 0018:ffffc90000a18af0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff11005f2115a RCX: ffff88802f908000
RDX: 0000000080000100 RSI: 0000000000000010 RDI: ffffc900039ff810
RBP: ffffc900039ff810 R08: ffffffff895fbdfa R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 0000000000000000
R13: 03fffe2200be422b R14: 0000000000000010 R15: ffffc900039ff810
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba6ef06030 CR3: 0000000077bb8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x129/0x240 net/core/filter.c:4300
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:memcg_account_kmem+0x0/0x1e0 mm/memcontrol.c:3371
Code: c1 0f 8c 4e ff ff ff 48 89 df e8 db 1c f7 ff e9 41 ff ff ff e8 81 d4 87 09 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48
RSP: 0018:ffffc900039ffa50 EFLAGS: 00000297
RAX: ffff888026bc4000 RBX: 0000000000000001 RCX: ffffc900039ff903
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff888026bc4000
RBP: ffff888026bc4000 R08: ffffffff8fae89af R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 1ffffd4000155f37
R13: ffff88802f460980 R14: dffffc0000000000 R15: ffffea0000aaf9b8
 obj_cgroup_uncharge_pages mm/memcontrol.c:3394 [inline]
 __memcg_kmem_uncharge_page+0x104/0x310 mm/memcontrol.c:3468
 memcg_kmem_uncharge_page include/linux/memcontrol.h:1818 [inline]
 exit_task_stack_account+0x94/0x340 kernel/fork.c:564
 do_exit+0x1d02/0x27f0 kernel/exit.c:918
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba6ed75b59
Code: Unable to access opcode bytes at 0x7fba6ed75b2f.
RSP: 002b:00007fba6e7ff0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fba6ef05f68 RCX: 00007fba6ed75b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fba6ef05f68
RBP: 00007fba6ef05f60 R08: 00007fba6e7ff6c0 R09: 00007fba6e7ff6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fba6ef05f6c
R13: 000000000000000b R14: 00007ffedc919aa0 R15: 00007ffedc919b88
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__dev_flush+0x5b/0x160
Code: 48 89 ef e8 97 80 3a 00 48 8b 5d 00 48 39 eb 0f 84 ff 00 00 00 48 89 2c 24 49 89 dd 49 c1 ed 03 48 b8 00 00 00 00 00 fc ff df <41> 80 7c 05 00 00 74 08 48 89 df e8 65 80 3a 00 48 8b 03 48 89 44
RSP: 0018:ffffc90000a18af0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 1ffff11005f2115a RCX: ffff88802f908000
RDX: 0000000080000100 RSI: 0000000000000010 RDI: ffffc900039ff810
RBP: ffffc900039ff810 R08: ffffffff895fbdfa R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 0000000000000000
R13: 03fffe2200be422b R14: 0000000000000010 R15: ffffc900039ff810
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fba6ef06030 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 ef             	mov    %rbp,%rdi
   3:	e8 97 80 3a 00       	call   0x3a809f
   8:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
   c:	48 39 eb             	cmp    %rbp,%rbx
   f:	0f 84 ff 00 00 00    	je     0x114
  15:	48 89 2c 24          	mov    %rbp,(%rsp)
  19:	49 89 dd             	mov    %rbx,%r13
  1c:	49 c1 ed 03          	shr    $0x3,%r13
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	41 80 7c 05 00 00    	cmpb   $0x0,0x0(%r13,%rax,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	48 89 df             	mov    %rbx,%rdi
  35:	e8 65 80 3a 00       	call   0x3a809f
  3a:	48 8b 03             	mov    (%rbx),%rax
  3d:	48                   	rex.W
  3e:	89                   	.byte 0x89
  3f:	44                   	rex.R


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1283bdfd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

