Return-Path: <linux-kernel+bounces-425685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711E9DE90E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4C1281C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87AF13C3D5;
	Fri, 29 Nov 2024 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPHb1el+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5952E3FE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732892647; cv=none; b=BRZTbJBs37rsY7uMvlq2EMV32X6eGXx8wk1A0SJs1rr8Yiyr98lwBSyoap9VPLVcFdab26FK+3h3FHZCt1UbCLwEilj/TMvasDS07plzf8dkWUBnpq6uTzQzRR4BCF7OUfxxLNwIaKOlV8Z2/7/9iEyxSNf+I3ISxwndB6dL1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732892647; c=relaxed/simple;
	bh=dEKbfxBAUBiwBoKeHLcoW9zDuULmL3cLkG55Wq4aKoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDVGY73v9Fz+HT8D2h2nk+PcOcjrkC4guNK4IRRWmbcRHvmDk9b4S8IVZd8et2XXP1bbQsozRsMWY4lP72f8aCTjqH1jHFCuYsZNk2HrN+KJlO01k1Qosahivnc6BhyzQSXjASm/b4IHPDWPcz4EYOlHWeGm04pgWwzjBvnhxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GPHb1el+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732892644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0RD/HJAo8yvtV76Wjt7zm8ei965tIPQdHJqRvu2Tkw=;
	b=GPHb1el+gNRGAnmtPbESynVz9+EX+qNEJtFvgndozJueeLxQ237E7/RlRx5RN8Et+quo+7
	7Rnf2YUdHLpMJ1CcniTCKuV7BsMiAYnbstGyCl8SY+oDc+selkbWPTRWh7s2k3xr4g6veh
	Ri3CO1AWcVrc5If3nW2VTyEyWT6+BNA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-CP024ILENkKOBt8aS90OzA-1; Fri, 29 Nov 2024 10:04:02 -0500
X-MC-Unique: CP024ILENkKOBt8aS90OzA-1
X-Mimecast-MFC-AGG-ID: CP024ILENkKOBt8aS90OzA
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b67aace1f5so315281685a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732892642; x=1733497442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0RD/HJAo8yvtV76Wjt7zm8ei965tIPQdHJqRvu2Tkw=;
        b=nk5ruMKeao0KuSkY+0XpnaTH19gnpQ+EuGTgMjKY613GHWi3sUcEmv2airwUEF2f+O
         rMdRHjn8izYkkHFlD+ndL9rCS/C+0MGJrPOghBJp6vIFCSUhBmihcVWtvr0faJg6ZVpK
         nZ679SN+KWT6O5ciQsz1guvDgnQcL9m7ktNvs/akFJ3JpoQHRisOlFBaZdBQfIw6ct+h
         nc4GIdQ9CNZsW7COZXGfA4MCFNH8WM+G+uWt+yWaEtEaAskTHOQjBxlYCmejt4ZmJwdo
         qlHQ7hsdfa928VUzoV1awXMwABPacy0E0iuEVKHvYuJS4YDdP/gLRVOqVH/nag+D3zuX
         lzCA==
X-Gm-Message-State: AOJu0YzX+n3fZHVwpvbSIvYs9mNy4vC7vRf0GMlEuot5qRumRc8AE4LK
	u8p1Wl066S42OtEYsrkGOOvZ/gDOXPonI7vkQ/5bJkrw0hF7sP8/dh3UwjqtgBpCFCL1jV243L+
	1cbspcWex7nu0E2wjBLz+kXsBZ2pa/JAjZEVV2fwNJLzaRljmsb0hQWkE2J5eEA==
X-Gm-Gg: ASbGncuK9YAnqOEJ3zyEKYpJ1wBdb/E3fSZC6NuKHnkz4p43SzP8835uO/5RkiIjy7o
	moO6DP66d8Q7G5WXmYmWmMnXW60D257oep74RMySwu+G+jiWAWckhO4r6XVMeS8z57DNyNJuIRD
	UKxfzDTjAzV5j5YBW0RVxyfDBE8bWWczQXvdttSGJpV4Cgw3ugnkCz2XOCAeLduP4/xFVCnJ0xW
	wdQNNVQ0o3C7oG9G900nzkCtRTNL8aL9iBen5phwNRfBB3uRjMnlk3WUSCjq6hzaMZHF3vm/B/s
	xoE=
X-Received: by 2002:a05:620a:4085:b0:7b1:4f1f:a194 with SMTP id af79cd13be357-7b67c25a538mr1508604185a.6.1732892641881;
        Fri, 29 Nov 2024 07:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAamC4LDoAKy7gsvUbYnhnJ33oi75fy+Pb+AH0XpjhWWRTq2HFJZblZd0IbpMEmDsGWtIoYw==
X-Received: by 2002:a05:620a:4085:b0:7b1:4f1f:a194 with SMTP id af79cd13be357-7b67c25a538mr1508594885a.6.1732892641072;
        Fri, 29 Nov 2024 07:04:01 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492ca0bsm146553685a.36.2024.11.29.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:03:59 -0800 (PST)
Date: Fri, 29 Nov 2024 16:03:54 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v3 0/9] futex: Add support task local hash maps.
Message-ID: <Z0nX2olCQtSciY7-@jlelli-thinkpadt14gen4.remote.csb>
References: <20241115172035.795842-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115172035.795842-1-bigeasy@linutronix.de>

Hi Sebastian,

On 15/11/24 17:58, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is a follow up on
> 	https://lore.kernel.org/ZwVOMgBMxrw7BU9A@jlelli-thinkpadt14gen4.remote.csb
> 
> and adds support for task local futex_hash_bucket. It can be created via
> prctl().
> 
> This version supports resize at runtime. This fun part is limited is to
> FUTEX_LOCK_PI which means any other waiter will break.
> 
> I posted performance numbers of "perf bench futex hash"
> 	https://lore.kernel.org/all/20241101110810.R3AnEqdu@linutronix.de/

Performance looks generally good on our side as well. However, while
testing the set manually with a debug enabled config (attached) I hit
the following BUG (decoded) while booting the machine.

---
BUG: unable to handle page fault for address: ffffad7a4e08f480
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: Oops: 0002 [#1] PREEMPT_RT SMP NOPTI
Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
RIP: 0010:futex_hash_priv_put (./arch/x86/include/asm/atomic.h:79 ./include/linux/atomic/atomic-arch-fallback.h:2378 ./include/linux/atomic/atomic-instrumented.h:1458 ./include/linux/rcuref.h:87 ./include/linux/rcuref.h:150 kernel/futex/core.c:164) 
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 fd bf 01 00 00 00 53 e8 cc 22 f1 ff e8 47 70 cb 00 85 c0 75 2a <f0> 83 45 00 ff 0f 98 c3 78 7e bf 01 00 00 00 e8 ff 00 f1 ff 65 8b
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  12:	55                   	push   %rbp
  13:	48 89 fd             	mov    %rdi,%rbp
  16:	bf 01 00 00 00       	mov    $0x1,%edi
  1b:	53                   	push   %rbx
  1c:	e8 cc 22 f1 ff       	callq  0xfffffffffff122ed
  21:	e8 47 70 cb 00       	callq  0xcb706d
  26:	85 c0                	test   %eax,%eax
  28:	75 2a                	jne    0x54
  2a:*	f0 83 45 00 ff       	lock addl $0xffffffff,0x0(%rbp)		<-- trapping instruction
  2f:	0f 98 c3             	sets   %bl
  32:	78 7e                	js     0xb2
  34:	bf 01 00 00 00       	mov    $0x1,%edi
  39:	e8 ff 00 f1 ff       	callq  0xfffffffffff1013d
  3e:	65                   	gs
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	f0 83 45 00 ff       	lock addl $0xffffffff,0x0(%rbp)
   5:	0f 98 c3             	sets   %bl
   8:	78 7e                	js     0x88
   a:	bf 01 00 00 00       	mov    $0x1,%edi
   f:	e8 ff 00 f1 ff       	callq  0xfffffffffff10113
  14:	65                   	gs
  15:	8b                   	.byte 0x8b
RSP: 0018:ffffae3a4fab3dc0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffffa181e4ca RDI: ffffffffa18b55f6
RBP: ffffad7a4e08f480 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffae3a4e08f340
R13: 0000000000000081 R14: 000000007fffffff R15: 0000000000000000
FS:  00007fde38938b40(0000) GS:ffff8f6e96e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffad7a4e08f480 CR3: 00000019e1c98004 CR4: 00000000007706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
? page_fault_oops (arch/x86/mm/fault.c:715) 
? exc_page_fault (arch/x86/mm/fault.c:1479 arch/x86/mm/fault.c:1539) 
? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623) 
? futex_hash_priv_put (./arch/x86/include/asm/atomic.h:79 ./include/linux/atomic/atomic-arch-fallback.h:2378 ./include/linux/atomic/atomic-instrumented.h:1458 ./include/linux/rcuref.h:87 ./include/linux/rcuref.h:150 kernel/futex/core.c:164) 
futex_wake (kernel/futex/waitwake.c:180) 
do_futex (kernel/futex/syscalls.c:131) 
__x64_sys_futex (kernel/futex/syscalls.c:179 kernel/futex/syscalls.c:160 kernel/futex/syscalls.c:160) 
? __lock_release.isra.0 (kernel/locking/lockdep.c:339 kernel/locking/lockdep.c:352 kernel/locking/lockdep.c:5507) 
do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
? exc_page_fault (arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539) 
? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
? clear_bhb_loop (arch/x86/entry/entry_64.S:1539) 
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
RIP: 0033:0x7fde39642fc0
Code: ff d3 31 f6 4c 89 e7 e8 ae 73 ff ff 45 31 d2 ba ff ff ff 7f be 81 00 00 00 c7 45 00 02 00 00 00 48 89 ef b8 ca 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 86 15 ff ff ff 83 c0 16 83 e0 f7 0f 85 66 ff
All code
========
   0:	ff d3                	callq  *%rbx
   2:	31 f6                	xor    %esi,%esi
   4:	4c 89 e7             	mov    %r12,%rdi
   7:	e8 ae 73 ff ff       	callq  0xffffffffffff73ba
   c:	45 31 d2             	xor    %r10d,%r10d
   f:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
  14:	be 81 00 00 00       	mov    $0x81,%esi
  19:	c7 45 00 02 00 00 00 	movl   $0x2,0x0(%rbp)
  20:	48 89 ef             	mov    %rbp,%rdi
  23:	b8 ca 00 00 00       	mov    $0xca,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	0f 86 15 ff ff ff    	jbe    0xffffffffffffff4b
  36:	83 c0 16             	add    $0x16,%eax
  39:	83 e0 f7             	and    $0xfffffff7,%eax
  3c:	0f                   	.byte 0xf
  3d:	85 66 ff             	test   %esp,-0x1(%rsi)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	0f 86 15 ff ff ff    	jbe    0xffffffffffffff21
   c:	83 c0 16             	add    $0x16,%eax
   f:	83 e0 f7             	and    $0xfffffff7,%eax
  12:	0f                   	.byte 0xf
  13:	85 66 ff             	test   %esp,-0x1(%rsi)
RSP: 002b:00007ffcbdf96830 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fde3892ce10 RCX: 00007fde39642fc0
RDX: 000000007fffffff RSI: 0000000000000081 RDI: 00007fde38937250
RBP: 00007fde38937250 R08: 00007fde397afae0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffcbdf96848
R13: 00007ffcbdf96910 R14: 00007fde38937250 R15: 00007fde3892ce10
</TASK>
Modules linked in: fuse
CR2: ffffad7a4e08f480
---[ end trace 0000000000000000 ]---

Cannot seems to be able to reproduce this with the non-debug/production
config though.

Best,
Juri


