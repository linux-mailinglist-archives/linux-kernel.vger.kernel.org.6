Return-Path: <linux-kernel+bounces-553893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41AA5904B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF4188D2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B0D2253ED;
	Mon, 10 Mar 2025 09:51:56 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619017A2E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600316; cv=none; b=TXK387wJG7NdNkdb338PEaD35M9w+GAKh1/aS5YEoaD/IdKV6FZ08hu0hag0xpbBrEVqMRlP0sEuYWHl2updVhhgP+BMxdzO3rMil/8k3kGKUzeKAUacDdHsEbyDs2nU03Pqvuqfh31TQDkdN8ZDV2TXoRa1r3qtFSIDFq4euno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600316; c=relaxed/simple;
	bh=gmxFtjMteVui9x27eFqfr1NYcGv8Yb2TXHpW8smvi1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIfwUJzWRiApXqinF/Ll4/32Tw24Y2G3dEfhi+wdinTK/FfEyKsHxjnmbDnFpGAwiSAd6RxPN4eV5MHo8x3AnMtqdSWDomnvA0c8eh+O3sdSilmck+tgCrZf4vE7iUOl0F4lwQd6flDRsHH7sA4+RY5sILHfr0BEvxPBIQqn3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A04AC4330C;
	Mon, 10 Mar 2025 09:51:50 +0000 (UTC)
Message-ID: <5074e2d2-f458-4bbd-a9e1-7e8d9f7e32e9@ghiti.fr>
Date: Mon, 10 Mar 2025 10:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] riscv: entry: Split ret_from_fork() into user and
 kernel
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20250305-riscv_optimize_entry-v5-0-6507b5dff3ce@rivosinc.com>
 <20250305-riscv_optimize_entry-v5-2-6507b5dff3ce@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250305-riscv_optimize_entry-v5-2-6507b5dff3ce@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeltdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhlefhffeggfeftddvtdeukeelgfehkeehhfeuheehleefkeelgffglefghfffueenucffohhmrghinhepvghnthhrhidrshgsnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemhedvkeemudhfieejmeekudegudemkeegvgeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehvdekmedufheijeemkedugedumeekgegvkedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemhedvkeemudhfieejmeekudegudemkeegvgekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlm
 hgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehluhhtoheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 06/03/2025 01:43, Charlie Jenkins wrote:
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

As I had noted in v2, this won't bring any performance improvement on 
real hardware, so I'm not convinced we need this patch.

IMO, we should merge micro-optimizations like this if they really bring 
something.

Thanks,

Alex


