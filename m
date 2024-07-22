Return-Path: <linux-kernel+bounces-259032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90866939039
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B92281E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDE916D9D5;
	Mon, 22 Jul 2024 13:57:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81716D9C1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656624; cv=none; b=L/JfNMqLSYC2uT4A3OzTjSEpKXiKJKlfj0t4hv8osU25R1y5m8bDzrotkq8YiB+mCz/ECjwUJUKKKy5K6EvIq7Lobb4PFItG4rDWHH7ZdsUZTK/5utwFjtCHF0FGvq9qwXCTmOPbseBcYCDoVkzCo5W6lT/inQSDCMtrqABxKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656624; c=relaxed/simple;
	bh=gSiD7t9P6VmcUl5TjB7buLhcHegbdcHrRBxeshn/ezo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vC848nRaqqMQnkPYERrWw1wDNoC1CMXLFrR5QxsJTgK4fOsHOOIu2mNNWiGTAreyOyIGThuzW9mcYwPNqKY8Qy65VPhHrxYg9PnFSOpdKAuC3lcz+SISfrbSBGLzbjSy7S0+9Bo2SLICO7Jq3uMcX3NSz2jsXcB00fPYpzwNnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-800e520a01dso712577939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721656622; x=1722261422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB0mBPOisapTkMOsp0F8up+nOJLtAguVgbWkrATQl0g=;
        b=Bfn1wxqwiSNoTp+PK6OVPwaINv3OvMk+NHaMfpvlLNaLnBZiYuhMP9BT2SOiSYIzi/
         VjDlJQOwEXNNOTy/xyaTtfTu87IbX/L6cGvForAmD4KmG4L/snjMJ8H0TXN5AObnvlRN
         wqvUrEh3K+lBcSpLu+vxZ4sJM/ZqRAfZHGtxqwc3ZD1QH/8cbfyegbx5AndCMLYM8qxW
         s3MowDbvpiODD830ceGPL/4msd2NfZERCZKG/J++3nat8wx7JGUppyp8EfN1ry9fp8ck
         acZgHDlVThTU4p3rlOp8U2b03DtUSikly6WdqRiCaKSR+YjvE9oQSoUltdjgMDDKe1hy
         Pq2A==
X-Forwarded-Encrypted: i=1; AJvYcCVeAN3Or6Rt2gxu35buqlngiqIrMzzqKLmjGAAasAwd/Mx24mpBck+/Yn9oOdIXRVO4/jd7W/ZDgoeGevSzmZIehj0QTdLMsTxg21Qn
X-Gm-Message-State: AOJu0YwrrLp7BBI4CmfoYsVK89Q/lXMh+SLBiEv/xQH/aa4QTxjeZwXN
	t9Yl4U0Q+30AxNksdBi7zfrqSpD+GFVty2y9QV/lYZzZ1OMTtvBfIdexPosUIhQOrqs9Udt8s7h
	9XClbjt0JwVFqhSJWrg2/BSrKs2H3Nw54LVErTnIV+rpPbbcNaZOx1ac=
X-Google-Smtp-Source: AGHT+IGfea4zlkYwI0y0fxiXgTTLYqZf9IFM+tnYoUYMjQBx10bcqQe8cKs6tdS6JaXdhjjwYnLuM7smP1LbIehphA7ELshn+smm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:842a:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4c240038c85mr535255173.6.1721656622446; Mon, 22 Jul 2024
 06:57:02 -0700 (PDT)
Date: Mon, 22 Jul 2024 06:57:02 -0700
In-Reply-To: <20240722094420.4136-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000680ce8061dd66bce@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __xsk_map_flush

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 PID: 7230 Comm: syz.0.654 Not tainted 6.10.0-rc6-syzkaller-01232-gfecef4cd42c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__xsk_map_flush+0x56/0x2b0
Code: 80 3c 28 00 74 08 48 89 df e8 96 68 92 f6 4c 8b 3b 49 39 df 0f 84 43 02 00 00 48 89 1c 24 4c 89 f8 48 c1 e8 03 48 89 44 24 08 <42> 80 3c 28 00 74 08 4c 89 ff e8 6b 68 92 f6 49 8b 07 48 89 44 24
RSP: 0018:ffffc90000007ae8 EFLAGS: 00010203
RAX: 0000000000000008 RBX: ffffc90004087820 RCX: ffff88807b148000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffffc90004087820
RBP: dffffc0000000000 R08: ffffffff8959f41a R09: 1ffffffff1f5941d
R10: dffffc0000000000 R11: fffffbfff1f5941e R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000010 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd8bf106030 CR3: 000000001e6d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x18e/0x240 net/core/filter.c:4308
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
RIP: 0010:__raw_write_unlock_irq include/linux/rwlock_api_smp.h:274 [inline]
RIP: 0010:_raw_write_unlock_irq+0x29/0x50 kernel/locking/spinlock.c:358
Code: 90 f3 0f 1e fa 53 48 89 fb 48 83 c7 18 48 8b 74 24 08 e8 7a de e6 f5 48 89 df e8 52 33 e8 f5 e8 cd d9 11 f6 fb bf 01 00 00 00 <e8> 22 ee d9 f5 65 8b 05 a3 26 78 74 85 c0 74 06 5b c3 cc cc cc cc
RSP: 0018:ffffc90004087ab0 EFLAGS: 00000282
RAX: 4c2770ac48549a00 RBX: ffffffff8e00a040 RCX: ffffffff9477c603
RDX: dffffc0000000000 RSI: ffffffff8bcabb40 RDI: 0000000000000001
RBP: ffffc90004087c20 R08: ffffffff8faca0ef R09: 1ffffffff1f5941d
R10: dffffc0000000000 R11: fffffbfff1f5941e R12: 1ffff1100f6290ad
R13: 1ffff1100f6290ac R14: ffff88801fc4bcc0 R15: dffffc0000000000
 exit_notify kernel/exit.c:768 [inline]
 do_exit+0x19c4/0x27e0 kernel/exit.c:896
 do_group_exit+0x207/0x2c0 kernel/exit.c:1025
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd8bef75b59
Code: Unable to access opcode bytes at 0x7fd8bef75b2f.
RSP: 002b:00007fd8bfe150f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fd8bf105f68 RCX: 00007fd8bef75b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fd8bf105f68
RBP: 00007fd8bf105f60 R08: 00007fd8bfe156c0 R09: 00007fd8bfe156c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd8bf105f6c
R13: 000000000000000b R14: 00007ffd2583fbe0 R15: 00007ffd2583fcc8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__xsk_map_flush+0x56/0x2b0
Code: 80 3c 28 00 74 08 48 89 df e8 96 68 92 f6 4c 8b 3b 49 39 df 0f 84 43 02 00 00 48 89 1c 24 4c 89 f8 48 c1 e8 03 48 89 44 24 08 <42> 80 3c 28 00 74 08 4c 89 ff e8 6b 68 92 f6 49 8b 07 48 89 44 24
RSP: 0018:ffffc90000007ae8 EFLAGS: 00010203
RAX: 0000000000000008 RBX: ffffc90004087820 RCX: ffff88807b148000
RDX: 0000000080000101 RSI: 0000000000000010 RDI: ffffc90004087820
RBP: dffffc0000000000 R08: ffffffff8959f41a R09: 1ffffffff1f5941d
R10: dffffc0000000000 R11: fffffbfff1f5941e R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000010 R15: 0000000000000046
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd8bf106030 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 96 68 92 f6       	call   0xf69268a4
   e:	4c 8b 3b             	mov    (%rbx),%r15
  11:	49 39 df             	cmp    %rbx,%r15
  14:	0f 84 43 02 00 00    	je     0x25d
  1a:	48 89 1c 24          	mov    %rbx,(%rsp)
  1e:	4c 89 f8             	mov    %r15,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 6b 68 92 f6       	call   0xf69268a4
  39:	49 8b 07             	mov    (%r15),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	44                   	rex.R
  3f:	24                   	.byte 0x24


Tested on:

commit:         fecef4cd tun: Assign missing bpf_net_context.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10ed355e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8defeae77515c9b1
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

