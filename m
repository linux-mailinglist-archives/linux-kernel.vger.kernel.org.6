Return-Path: <linux-kernel+bounces-553911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A0A59080
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCABC3A740F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8012253E4;
	Mon, 10 Mar 2025 09:58:28 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603241624C3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600708; cv=none; b=N0dkmHPGH7dmBviWSmfWNjtR37bOush+DAmMW0vMOBWFHlgW3fxJdqdaFNUs93fubaVJEnhRi5q1HLj5t4hL6gCDIGqjkVd7xaHc/M+BRZI8ZIW3qFuX2drwy3txvt6gxD20wafaaBNzEN1a4/4x5QxWFVBwntVUQlLK+ZyLMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600708; c=relaxed/simple;
	bh=ZwaLaXDoVEdopEWx6MLjOmW1+Aiu31WDeG+F2281xdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0tnUrRNwQdydC8ArVRn1my25GdW+xLNoblk55WSIGgYUn1yCi6lH0n4/Ci0ip9uegriKrhgh2eQElAQ/zdX7q6PCdwkY+89DxPehGf8NQEkYd9AFmyiNgFQ5azYTDYo1kn+yWITeWKujFzdzuQNj7SOOAWbd2fLeHPrv031w14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB5DC44201;
	Mon, 10 Mar 2025 09:58:15 +0000 (UTC)
Message-ID: <346ecf28-807f-4ae9-be5d-08ebd649d241@ghiti.fr>
Date: Mon, 10 Mar 2025 10:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] entry: Inline syscall_exit_to_user_mode()
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
 <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250305-riscv_optimize_entry-v5-4-6507b5dff3ce@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeltdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehvdekmedufheijeemkedugedumeekgegvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemhedvkeemudhfieejmeekudegudemkeegvgekpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehvdekmedufheijeemkedugedumeekgegvkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheptghhrghrlhhivgesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrt
 ghpthhtoheptghhvghnhhhurggtrghisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhesgigvnhdtnhdrnhgrmhgvpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Charlie,

On 06/03/2025 01:43, Charlie Jenkins wrote:
> Architectures using the generic entry code can be optimized by having
> syscall_exit_to_user_mode inlined.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   include/linux/entry-common.h | 43 ++++++++++++++++++++++++++++++++++++--
>   kernel/entry/common.c        | 49 +-------------------------------------------
>   2 files changed, 42 insertions(+), 50 deletions(-)
>
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index fc61d0205c97084acc89c8e45e088946f5e6d9b2..f94f3fdf15fc0091223cc9f7b823970302e67312 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -14,6 +14,7 @@
>   #include <linux/kmsan.h>
>   
>   #include <asm/entry-common.h>
> +#include <asm/syscall.h>
>   
>   /*
>    * Define dummy _TIF work flags if not defined by the architecture or for
> @@ -366,6 +367,15 @@ static __always_inline void exit_to_user_mode(void)
>   	lockdep_hardirqs_on(CALLER_ADDR0);
>   }
>   
> +/**
> + * syscall_exit_work - Handle work before returning to user mode
> + * @regs:	Pointer to current pt_regs
> + * @work:	Current thread syscall work
> + *
> + * Do one-time syscall specific work.
> + */
> +void syscall_exit_work(struct pt_regs *regs, unsigned long work);
> +
>   /**
>    * syscall_exit_to_user_mode_work - Handle work before returning to user mode
>    * @regs:	Pointer to currents pt_regs
> @@ -379,7 +389,30 @@ static __always_inline void exit_to_user_mode(void)
>    * make the final state transitions. Interrupts must stay disabled between
>    * return from this function and the invocation of exit_to_user_mode().
>    */
> -void syscall_exit_to_user_mode_work(struct pt_regs *regs);
> +static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
> +{
> +	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
> +	unsigned long nr = syscall_get_nr(current, regs);
> +
> +	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
> +
> +	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> +		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
> +			local_irq_enable();
> +	}
> +
> +	rseq_syscall(regs);
> +
> +	/*
> +	 * Do one-time syscall specific work. If these work items are
> +	 * enabled, we want to run them exactly once per syscall exit with
> +	 * interrupts enabled.
> +	 */
> +	if (unlikely(work & SYSCALL_WORK_EXIT))
> +		syscall_exit_work(regs, work);
> +	local_irq_disable_exit_to_user();
> +	exit_to_user_mode_prepare(regs);
> +}
>   
>   /**
>    * syscall_exit_to_user_mode - Handle work before returning to user mode
> @@ -410,7 +443,13 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs);
>    * exit_to_user_mode(). This function is preferred unless there is a
>    * compelling architectural reason to use the separate functions.
>    */
> -void syscall_exit_to_user_mode(struct pt_regs *regs);
> +static __always_inline void syscall_exit_to_user_mode(struct pt_regs *regs)
> +{
> +	instrumentation_begin();
> +	syscall_exit_to_user_mode_work(regs);
> +	instrumentation_end();
> +	exit_to_user_mode();
> +}
>   
>   /**
>    * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index e33691d5adf7aab4af54cf2bf8e5ef5bd6ad1424..f55e421fb196dd5f9d4e34dd85ae096c774cf879 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -146,7 +146,7 @@ static inline bool report_single_step(unsigned long work)
>   	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
>   }
>   
> -static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
> +void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>   {
>   	bool step;
>   
> @@ -173,53 +173,6 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
>   		ptrace_report_syscall_exit(regs, step);
>   }
>   
> -/*
> - * Syscall specific exit to user mode preparation. Runs with interrupts
> - * enabled.
> - */
> -static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
> -{
> -	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
> -	unsigned long nr = syscall_get_nr(current, regs);
> -
> -	CT_WARN_ON(ct_state() != CT_STATE_KERNEL);
> -
> -	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> -		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
> -			local_irq_enable();
> -	}
> -
> -	rseq_syscall(regs);
> -
> -	/*
> -	 * Do one-time syscall specific work. If these work items are
> -	 * enabled, we want to run them exactly once per syscall exit with
> -	 * interrupts enabled.
> -	 */
> -	if (unlikely(work & SYSCALL_WORK_EXIT))
> -		syscall_exit_work(regs, work);
> -}
> -
> -static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
> -{
> -	syscall_exit_to_user_mode_prepare(regs);
> -	local_irq_disable_exit_to_user();
> -	exit_to_user_mode_prepare(regs);
> -}
> -
> -void syscall_exit_to_user_mode_work(struct pt_regs *regs)
> -{
> -	__syscall_exit_to_user_mode_work(regs);
> -}
> -
> -__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
> -{
> -	instrumentation_begin();
> -	__syscall_exit_to_user_mode_work(regs);
> -	instrumentation_end();
> -	exit_to_user_mode();
> -}
> -
>   noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
>   {
>   	enter_from_user_mode(regs);
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


