Return-Path: <linux-kernel+bounces-258202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414649384ED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9491C20899
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A41649BF;
	Sun, 21 Jul 2024 13:59:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484B4414
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721570346; cv=none; b=TJ1jXqI1/H+hYYVqYkC0yzbpmwfYJGDCiMzvAnmtM/oysogSAsU3vNlyzDx2yfFxEdiVJiceOGx80caEpRA/aQ4DHFKCwhxx47cCxbFYqesQ7OI8Gx5Bc7DRXQYvc78nAIgfCTkr/URGu+jr25bTBqK9d/rYgjiQEADPTkGADgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721570346; c=relaxed/simple;
	bh=TOeIfMDGODdhyJjd+HKfN+Lt0byZKykb15Lt3mK0ZpM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D8ECBT1oW8pG5s3lKiksPepYaqDoocd2d6MfBRJ2s5RuMnrFL0SlxwzSSExI8WcAW+EuWWLO4TYd04BMOiG9bNH/xgLRdHRx5B9ouHmSkAL2siOz2CwPTGjtkd9otvO5ZJ7Rmf6hEs2Pm37DpiyPyjP1FXePh+Svo1AOds1QPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-80502b81995so553070539f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 06:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721570343; x=1722175143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxIp/eCdBWz+Nar232vH8IiVB7eMWNbmwIvb7O4deS0=;
        b=jUwEhAJmgFLXB0EK8VxxJRvOmMQ9QNp8BWspGsMK2xq1LNPqQQr430nlazN2HTanrQ
         XUFnGA3vbbbhscasm1/6AwJlrgNhWtBRlXDV0iF2bIxEMSAOlDbXmaXWx2VzuUY9DqGa
         FhUNzja2e8/+bViG2oEkYBOKiYJ+cB5TXZEuzWWcD1iEMbnvFFMxyc71b36eFygwfmsS
         AXf9lviu0fBYSu4vOx2FMfh+6CdaOAONPGge9H+9ja5do2WWVAhgvuxnuowOPBnsuHBe
         a8GAgnJmmSuhQ+m+OEGC3EXGpXjTx6n/dlYUPXiOvWIn/SUCcbq61+q66GIu09wlyg7Q
         zV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSb5CwU6tIUSDm3s/0L851P3Le4oqcRj4sUUe1sJsEn2E9Zgl+BBtCyzqmQlSgxcge0nZdJxTz/5yoFp7zghPsyJL3cSPKs2QEXMu+
X-Gm-Message-State: AOJu0Yx7t5lq5lMyGZLLgxfEgHfaEDBbzdXwXTxDqUkwztEJwv7LUZnw
	yR0UPEld5dMeTV4Q2n8TuCuNOOCEsvp1b28MVAjq0PnoDppjM+CUwYGThuM9/9NBjhIB9TInl6Z
	zbN9ullu/2C4UAIqFNrqMCrgFYKNvgUeFigVS0E4URGEGQQLRjCAzgE4=
X-Google-Smtp-Source: AGHT+IHJGosgJeVoIAN3YMyjxR9IffNlafDkXnPpz08U3DTTDrOJRtzANIJLDqf1mSJefFDyb9OG4GAE6pLK/Uhik8oO4LMbewlM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8403:b0:4c0:a90d:4a7c with SMTP id
 8926c6da1cb9f-4c23ffc473fmr337348173.6.1721570343494; Sun, 21 Jul 2024
 06:59:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:59:03 -0700
In-Reply-To: <20240721132859.268170-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7b8a5061dc25477@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __cpu_map_flush

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 6414 Comm: syz.0.248 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 93 d9 d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 bd ce 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 9f ce 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000a18b10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88806b371e00
RDX: 0000000080000100 RSI: 0000000000000010 RDI: ffffc9000319f800
RBP: dffffc0000000000 R08: ffffffff895fbdfa R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: ffffc9000319f800
R13: ffffc9000319f820 R14: ffffc9000319f800 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b96706030 CR3: 0000000025528000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
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
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5763
Code: 2b 00 74 08 4c 89 f7 e8 1a cb 86 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000319f8c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000633f24 RCX: a82dc8c22c65f400
RDX: dffffc0000000000 RSI: ffffffff8bcadea0 RDI: ffffffff8c1f9a00
RBP: ffffc9000319fa08 R08: ffffffff92fd0607 R09: 1ffffffff25fa0c0
R10: dffffc0000000000 R11: fffffbfff25fa0c1 R12: 1ffff92000633f20
R13: dffffc0000000000 R14: ffffc9000319f920 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 rcu_read_lock include/linux/rcupdate.h:839 [inline]
 get_mem_cgroup_from_objcg+0x36/0x150 include/linux/memcontrol.h:533
 obj_cgroup_uncharge_pages mm/memcontrol.c:3392 [inline]
 __memcg_kmem_uncharge_page+0xf5/0x310 mm/memcontrol.c:3468
 memcg_kmem_uncharge_page include/linux/memcontrol.h:1818 [inline]
 exit_task_stack_account+0xd7/0x340 kernel/fork.c:564
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
RIP: 0033:0x7f3b96575b59
Code: Unable to access opcode bytes at 0x7f3b96575b2f.
RSP: 002b:00007f3b973cb0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f3b96705f68 RCX: 00007f3b96575b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f3b96705f68
RBP: 00007f3b96705f60 R08: 00007f3b973cb6c0 R09: 00007f3b973cb6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3b96705f6c
R13: 000000000000000b R14: 00007ffd55a3d740 R15: 00007ffd55a3d828
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__cpu_map_flush+0x42/0xd0
Code: e8 93 d9 d6 ff 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 bd ce 39 00 49 8b 1e 4c 39 f3 74 77 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 9f ce 39 00 4c 8b 23 48 8d 7b c0
RSP: 0018:ffffc90000a18b10 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88806b371e00
RDX: 0000000080000100 RSI: 0000000000000010 RDI: ffffc9000319f800
RBP: dffffc0000000000 R08: ffffffff895fbdfa R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: ffffc9000319f800
R13: ffffc9000319f820 R14: ffffc9000319f800 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b96706030 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 93 d9 d6 ff       	call   0xffd6d998
   5:	4c 89 f0             	mov    %r14,%rax
   8:	48 c1 e8 03          	shr    $0x3,%rax
   c:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  11:	74 08                	je     0x1b
  13:	4c 89 f7             	mov    %r14,%rdi
  16:	e8 bd ce 39 00       	call   0x39ced8
  1b:	49 8b 1e             	mov    (%r14),%rbx
  1e:	4c 39 f3             	cmp    %r14,%rbx
  21:	74 77                	je     0x9a
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 9f ce 39 00       	call   0x39ced8
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	48 8d 7b c0          	lea    -0x40(%rbx),%rdi


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103762e6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123c8cad980000


