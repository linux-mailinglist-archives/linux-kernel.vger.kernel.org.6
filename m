Return-Path: <linux-kernel+bounces-570788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CECA6B481
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378BC189ABF1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1381EB19D;
	Fri, 21 Mar 2025 06:37:00 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BC1DF248
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742539020; cv=none; b=tP2NvgUmJafDEGzmCX2bdsXLP81nrelcK0RXVMl6uzxkiM/nQCCT2gOfvT3WPCX5MqgfaV6TH7Jrii+vVOPK6eQqyCLHveQDOL89Olg01DbLtp9llvo7me6Wes08HN1qDf+/OWWc59vHFuu4LWcWpaVQ8SLvoyR63kNMJiTxjng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742539020; c=relaxed/simple;
	bh=y8fZQXJC5hgTKkheB5VelzVO10FdRYFnOoE9Iq65Dyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYGyCEsS6IJ0VdiVVft2pLXinS29118/z+N0jKw/Y542GPDLwYBgiIRL0Aa0B3/VYvM43fSsudQYcV1UwTaHJ03YFgPovIzTxpGYpVMLOYO7crfJkFKEUJyUCX91iaMj+s68Prq5ND1ADq5xGYB7+ewZf6byIzTu2SLa8gHj4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2296E4432E;
	Fri, 21 Mar 2025 06:36:50 +0000 (UTC)
Message-ID: <da40da36-097a-4b67-a67b-f00148474423@ghiti.fr>
Date: Fri, 21 Mar 2025 07:36:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] riscv: entry: Split ret_from_fork() into user and
 kernel
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20250320-riscv_optimize_entry-v6-0-63e187e26041@rivosinc.com>
 <20250320-riscv_optimize_entry-v6-2-63e187e26041@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250320-riscv_optimize_entry-v6-2-63e187e26041@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhlefhffeggfeftddvtdeukeelgfehkeehhfeuheehleefkeelgffglefghfffueenucffohhmrghinhepvghnthhrhidrshgsnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemleekgeekmeeksgdvudemheefudejmedugeehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemleekgeekmeeksgdvudemheefudejmedugeehuddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemleekgeekmeeksgdvudemheefudejmedugeehudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheptghhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepp
 hgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 20/03/2025 18:29, Charlie Jenkins wrote:
> This function was unified into a single function in commit ab9164dae273
> ("riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork").
> However that imposed a performance degradation. Partially reverting this
> commit to have ret_from_fork() split again results in a 1% increase on
> the number of times fork is able to be called per second.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/riscv/include/asm/asm-prototypes.h |  3 ++-
>   arch/riscv/kernel/entry.S               | 13 ++++++++++---
>   arch/riscv/kernel/process.c             | 17 +++++++++++------
>   3 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm-prototypes.h b/arch/riscv/include/asm/asm-prototypes.h
> index 733ff609778797001006c33bba9e3cc5b1f15387..bfc8ea5f9319b19449ec59493b45b926df888832 100644
> --- a/arch/riscv/include/asm/asm-prototypes.h
> +++ b/arch/riscv/include/asm/asm-prototypes.h
> @@ -52,7 +52,8 @@ DECLARE_DO_ERROR_INFO(do_trap_ecall_s);
>   DECLARE_DO_ERROR_INFO(do_trap_ecall_m);
>   DECLARE_DO_ERROR_INFO(do_trap_break);
>   
> -asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
> +asmlinkage void ret_from_fork_kernel(void *fn_arg, int (*fn)(void *), struct pt_regs *regs);
> +asmlinkage void ret_from_fork_user(struct pt_regs *regs);
>   asmlinkage void handle_bad_stack(struct pt_regs *regs);
>   asmlinkage void do_page_fault(struct pt_regs *regs);
>   asmlinkage void do_irq(struct pt_regs *regs);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b2dc5e7c7b3a843fa4aa02eba2a911eb3ce31d1f..0fb338000c6dc0358742cd03497fa54b9e9d1aec 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -319,14 +319,21 @@ SYM_CODE_END(handle_kernel_stack_overflow)
>   ASM_NOKPROBE(handle_kernel_stack_overflow)
>   #endif
>   
> -SYM_CODE_START(ret_from_fork_asm)
> +SYM_CODE_START(ret_from_fork_kernel_asm)
>   	call schedule_tail
>   	move a0, s1 /* fn_arg */
>   	move a1, s0 /* fn */
>   	move a2, sp /* pt_regs */
> -	call ret_from_fork
> +	call ret_from_fork_kernel
>   	j ret_from_exception
> -SYM_CODE_END(ret_from_fork_asm)
> +SYM_CODE_END(ret_from_fork_kernel_asm)
> +
> +SYM_CODE_START(ret_from_fork_user_asm)
> +	call schedule_tail
> +	move a0, sp /* pt_regs */
> +	call ret_from_fork_user
> +	j ret_from_exception
> +SYM_CODE_END(ret_from_fork_user_asm)
>   
>   #ifdef CONFIG_IRQ_STACKS
>   /*
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 7b0a0bfe29aec896c2bdd8976d855dd390de88d7..485ec7a80a56097e8905cd6395af29633846b5c8 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -38,7 +38,8 @@ unsigned long __stack_chk_guard __read_mostly;
>   EXPORT_SYMBOL(__stack_chk_guard);
>   #endif
>   
> -extern asmlinkage void ret_from_fork_asm(void);
> +extern asmlinkage void ret_from_fork_kernel_asm(void);
> +extern asmlinkage void ret_from_fork_user_asm(void);
>   
>   void noinstr arch_cpu_idle(void)
>   {
> @@ -208,14 +209,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>   	return 0;
>   }
>   
> -asmlinkage void ret_from_fork(void *fn_arg, int (*fn)(void *), struct pt_regs *regs)
> +asmlinkage void ret_from_fork_kernel(void *fn_arg, int (*fn)(void *), struct pt_regs *regs)
>   {
> -	if (unlikely(fn))
> -		fn(fn_arg);
> +	fn(fn_arg);
>   
>   	syscall_exit_to_user_mode(regs);
>   }
>   
> +asmlinkage void ret_from_fork_user(struct pt_regs *regs)
> +{
> +	syscall_exit_to_user_mode(regs);
> +}
> +
>   int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   {
>   	unsigned long clone_flags = args->flags;
> @@ -238,6 +243,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   
>   		p->thread.s[0] = (unsigned long)args->fn;
>   		p->thread.s[1] = (unsigned long)args->fn_arg;
> +		p->thread.ra = (unsigned long)ret_from_fork_kernel_asm;
>   	} else {
>   		*childregs = *(current_pt_regs());
>   		/* Turn off status.VS */
> @@ -247,12 +253,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>   		if (clone_flags & CLONE_SETTLS)
>   			childregs->tp = tls;
>   		childregs->a0 = 0; /* Return value of fork() */
> -		p->thread.s[0] = 0;
> +		p->thread.ra = (unsigned long)ret_from_fork_user_asm;
>   	}
>   	p->thread.riscv_v_flags = 0;
>   	if (has_vector() || has_xtheadvector())
>   		riscv_v_thread_alloc(p);
> -	p->thread.ra = (unsigned long)ret_from_fork_asm;
>   	p->thread.sp = (unsigned long)childregs; /* kernel sp */
>   	return 0;
>   }
>

Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


