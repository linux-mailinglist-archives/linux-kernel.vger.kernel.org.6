Return-Path: <linux-kernel+bounces-422203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB59D95CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85784282722
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A541CB51B;
	Tue, 26 Nov 2024 10:49:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B44B674
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618148; cv=none; b=LY7+f07S95SUEXSLC5gAkWPpQ3sTNpTfHsI9sVKJKVQZkpt8JS4i+2deZ+zQV03rDKY+cGUVcEqY1Ey/6EOZ1vDZeesUb+F8WZN15DMGpaCsmhzQktac1W4i0OgHuuLcScPyfXwqgyCG0Iu2QmRIwMGOOQFFiNMUgr5gYqbtcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618148; c=relaxed/simple;
	bh=MAff9xNsiFySIn0pvbqoHulAhGwTL4Xzk6pBxBv7gM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGxxt36n96ZTWm297gAhq0I86o7JkUVcuP8tS0esAzdesFYvIQ+/X0m9z6POCKR/rTF9AFW8iQmfwaROy6reDgUfMQfYH6DWsoTrwfUvnN7tnTNoO4NkSw4f9YA+aImtJfjrngtQk9OWO1B9HsiNiASb7vM79mxJgGBRaonidvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XyK7Y4qw4z9sPd;
	Tue, 26 Nov 2024 11:48:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YOztfx2qWO3B; Tue, 26 Nov 2024 11:48:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XyK7Y3tcbz9rvV;
	Tue, 26 Nov 2024 11:48:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E7D58B776;
	Tue, 26 Nov 2024 11:48:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id qDRZvgTGw4rj; Tue, 26 Nov 2024 11:48:57 +0100 (CET)
Received: from [192.168.232.206] (unknown [192.168.232.206])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 888E28B763;
	Tue, 26 Nov 2024 11:48:55 +0100 (CET)
Message-ID: <d169e57d-d0a8-4fe8-a44e-2f7a967b5121@csgroup.eu>
Date: Tue, 26 Nov 2024 11:48:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc: support dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-3-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241125042212.1522315-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
> Once the lazy preemption is supported, it would be desirable to change
> the preemption models at runtime. So this change adds support for dynamic
> preemption using DYNAMIC_KEY.
> 
> In irq-exit to kernel path, use preempt_model_preemptible for decision.
> Other way would be using static key based decision. Keeping it
> simpler since key based change didn't show performance improvement.
> 
> Tested lightly on Power10 LPAR. Performance numbers indicate that,
> preempt=none(no dynamic) and preempt=none(dynamic) are similar.
> Only hackbench pipe shows a regression. There is slight overhead of code
> check if it is preemptible kernel. hackbench pipe is prone to such
> patterns[1]
> 
> cat /sys/kernel/debug/sched/preempt
> (none) voluntary full lazy
> perf stat -e probe:__cond_resched -a sleep 1
>   Performance counter stats for 'system wide':
>               1,253      probe:__cond_resched
> 
> echo full > /sys/kernel/debug/sched/preempt
> cat /sys/kernel/debug/sched/preempt
> none voluntary (full) lazy
> perf stat -e probe:__cond_resched -a sleep 1
>   Performance counter stats for 'system wide':
>                   0      probe:__cond_resched
> 
> echo lazy > /sys/kernel/debug/sched/preempt
> cat /sys/kernel/debug/sched/preempt
> none voluntary full (lazy)
> perf stat -e probe:__cond_resched -a sleep 1
>   Performance counter stats for 'system wide':
>                   0      probe:__cond_resched
> 
> [1]: https://lore.kernel.org/all/1a973dda-c79e-4d95-935b-e4b93eb077b8@linux.ibm.com/
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/Kconfig               | 1 +
>   arch/powerpc/include/asm/preempt.h | 1 +
>   arch/powerpc/kernel/interrupt.c    | 6 +++++-
>   arch/powerpc/lib/vmx-helper.c      | 2 +-
>   4 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6d6bbd93abab..01c58f5258c9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -270,6 +270,7 @@ config PPC
>   	select HAVE_PERF_EVENTS_NMI		if PPC64
>   	select HAVE_PERF_REGS
>   	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_PREEMPT_DYNAMIC_KEY
>   	select HAVE_RETHOOK			if KPROBES
>   	select HAVE_REGS_AND_STACK_ACCESS_API
>   	select HAVE_RELIABLE_STACKTRACE
> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
> index 51f8f3881523..c0a19ff3f78c 100644
> --- a/arch/powerpc/include/asm/preempt.h
> +++ b/arch/powerpc/include/asm/preempt.h
> @@ -84,6 +84,7 @@ extern asmlinkage void preempt_schedule_notrace(void);
>   
>   #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>   
> +DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>   void dynamic_preempt_schedule(void);
>   void dynamic_preempt_schedule_notrace(void);
>   #define __preempt_schedule()		dynamic_preempt_schedule()
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 8f4acc55407b..0fb01019d7e0 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -38,6 +38,10 @@ static inline bool exit_must_hard_disable(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +#endif

Why is that needed at all ? It isn't used.

> +
>   /*
>    * local irqs must be disabled. Returns false if the caller must re-enable
>    * them, check for new work, and try again.
> @@ -396,7 +400,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>   		/* Returning to a kernel context with local irqs enabled. */
>   		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>   again:
> -		if (IS_ENABLED(CONFIG_PREEMPTION)) {
> +		if (preempt_model_preemptible()) {
>   			/* Return to preemptible kernel context */
>   			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>   				if (preempt_count() == 0)
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
> index 58ed6bd613a6..7b069c832ce2 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
>   	 * set and we are preemptible. The hack here is to schedule a
>   	 * decrementer to fire here and reschedule for us if necessary.
>   	 */
> -	if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
> +	if (preempt_model_preemptible() && need_resched())
>   		set_dec(1);
>   	return 0;
>   }

