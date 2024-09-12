Return-Path: <linux-kernel+bounces-326232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC89976544
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4086C1F21162
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB411925A2;
	Thu, 12 Sep 2024 09:11:49 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A676A19048D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132308; cv=none; b=XgIvMp9LNP5YtZAaYyQY6uxlIccQna39qsyWkt7EXQFPRn8WhlhKnK+rIwdF9uv4teiubNamqrNV0tZC5i+vdHecQF72EIikoihoxYUnjmb9K+j7Y/lZ1IgrUs2xgtzBYC0gOtk3vi3i9OnWPKx+1kpa6aswrJT21mBkIO5e7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132308; c=relaxed/simple;
	bh=btqwBh/I54X465puJFmpHsMRLjt/34KSToZzmePcqv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aTyQRRuzWVeC4AZZbtu6sXOUHqPqlpvobMS527ghsdqW48IHXvVT79eprsSVhBCTLKElQLX+56hyui5GymzYbFGinblmoYPhcdRdcBsQAI/k5/+IBkxGHZL30+94014+DzwY8kYrFCoNSh6dxI57sQIWDokb4t5PAjnaIvD3kU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X4BWs6DrHz9sqq;
	Thu, 12 Sep 2024 11:11:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oc1i_cREXwgh; Thu, 12 Sep 2024 11:11:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X4BWs58VYz9sqp;
	Thu, 12 Sep 2024 11:11:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DFC68B773;
	Thu, 12 Sep 2024 11:11:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oS8yMn6JT5s4; Thu, 12 Sep 2024 11:11:37 +0200 (CEST)
Received: from [192.168.233.25] (unknown [192.168.233.25])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3206F8B766;
	Thu, 12 Sep 2024 11:11:37 +0200 (CEST)
Message-ID: <ce53d3db-518d-49e0-95b0-16df1432f14a@csgroup.eu>
Date: Thu, 12 Sep 2024 11:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc/entry: convert to common and generic entry
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 jialong.yang@shingroup.cn, luming.yu@gmail.com
References: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/09/2024 à 10:24, Luming Yu a écrit :
> From: Yu Luming <luming.yu@gmail.com>
> 
> convert powerpc entry code in syscall and fault to use syscall_work
> and irqentry_state as well as common calls from generic entry infrastructure.

Could you add more description about the change ?

When I look at x86, riscv or s390 commits for the same thing, they tell 
a lot more:

	Commit 27d6b4d14f5c ("x86/entry: Use generic syscall entry function")
	Commit f0bddf50586d ("riscv: entry: Convert to generic entry")
	Commit 56e62a737028 ("s390: convert to generic entry")

Can you elso provide some benchmark comparisons, at least using the 
null_syscall selftest

	tools/testing/selftests/powerpc/benchmarks/null_syscall.c

> 
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>   arch/powerpc/Kconfig                   | 1 +
>   arch/powerpc/include/asm/hw_irq.h      | 5 +++++
>   arch/powerpc/include/asm/processor.h   | 6 ++++++
>   arch/powerpc/include/asm/syscall.h     | 5 +++++
>   arch/powerpc/include/asm/thread_info.h | 1 +
>   arch/powerpc/kernel/syscall.c          | 6 +++++-
>   arch/powerpc/mm/fault.c                | 5 +++++
>   7 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e21f72bcb61f..e94e7e4bfd40 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -202,6 +202,7 @@ config PPC
>   	select GENERIC_IRQ_SHOW_LEVEL
>   	select GENERIC_PCI_IOMAP		if PCI
>   	select GENERIC_PTDUMP
> +        select GENERIC_ENTRY
>   	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_TIME_VSYSCALL
>   	select GENERIC_VDSO_TIME_NS
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 317659fdeacf..a3d591784c95 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -216,6 +216,11 @@ static inline bool arch_irqs_disabled(void)
>   	return arch_irqs_disabled_flags(arch_local_save_flags());
>   }
>   
> +/*common entry*/
> +static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
> +{
> +	return arch_irqs_disabled();
> +}
>   static inline void set_pmi_irq_pending(void)
>   {
>   	/*
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index b2c51d337e60..1292282f8b0e 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -383,6 +383,12 @@ int validate_sp(unsigned long sp, struct task_struct *p);
>   int validate_sp_size(unsigned long sp, struct task_struct *p,
>   		     unsigned long nbytes);
>   
> +/*for common entry*/
> +static __always_inline bool on_thread_stack(void)
> +{
> +	return validate_sp(current_stack_pointer, current);

I don't understand. Other architectures have something more simple for 
on_thread_stack().

Also, validate_sp() will also return true when on irq_stack or emergency 
stack.

> +}
> +
>   /*
>    * Prefetch macros.
>    */
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 3dd36c5e334a..0e94806c7bfe 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -119,4 +119,9 @@ static inline int syscall_get_arch(struct task_struct *task)
>   	else
>   		return AUDIT_ARCH_PPC64;
>   }
> +
> +static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> +{
> +	return false;
> +}
>   #endif	/* _ASM_SYSCALL_H */
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 47e226032f9c..c52ca3aaebb5 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -58,6 +58,7 @@ struct thread_info {
>   	unsigned int	cpu;
>   #endif
>   	unsigned long	local_flags;		/* private flags for thread */
> +	unsigned long	syscall_work;
>   #ifdef CONFIG_LIVEPATCH_64
>   	unsigned long *livepatch_sp;
>   #endif
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index 77fedb190c93..cbf0510ed10e 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -3,6 +3,7 @@
>   #include <linux/compat.h>
>   #include <linux/context_tracking.h>
>   #include <linux/randomize_kstack.h>
> +#include <linux/entry-common.h>
>   
>   #include <asm/interrupt.h>
>   #include <asm/kup.h>
> @@ -131,7 +132,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   		 * and the test against NR_syscalls will fail and the return
>   		 * value to be used is in regs->gpr[3].
>   		 */
> -		r0 = do_syscall_trace_enter(regs);
> +		syscall_enter_from_user_mode(regs, r0);

shouldn't this be:

	r0 = syscall_enter_from_user_mode(regs, r0);

>   		if (unlikely(r0 >= NR_syscalls))
>   			return regs->gpr[3];
>   
> @@ -185,5 +186,8 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	 */
>   	choose_random_kstack_offset(mftb());
>   
> +	/*common entry*/
> +	syscall_exit_to_user_mode(regs);
> +

This seems to do a lot. Isn't there stuff that was previously done by 
powerpc and needs to be removed now ?

>   	return ret;
>   }
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 9e49ede2bc1c..64c6eb06ebe8 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -23,6 +23,7 @@
>   #include <linux/mman.h>
>   #include <linux/mm.h>
>   #include <linux/interrupt.h>
> +#include <linux/entry-common.h>
>   #include <linux/highmem.h>
>   #include <linux/extable.h>
>   #include <linux/kprobes.h>
> @@ -569,15 +570,19 @@ NOKPROBE_SYMBOL(___do_page_fault);
>   static __always_inline void __do_page_fault(struct pt_regs *regs)
>   {
>   	long err;
> +	irqentry_state_t state = irqentry_enter(regs);

It is already called below in do_page_fault(), is it normal to do it twice ?

>   
>   	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
>   	if (unlikely(err))
>   		bad_page_fault(regs, err);
> +	irqentry_exit(regs, state);
>   }
>   
>   DEFINE_INTERRUPT_HANDLER(do_page_fault)
>   {
> +	irqentry_state_t state = irqentry_enter(regs);
>   	__do_page_fault(regs);
> +	irqentry_exit(regs, state);

No need to do the same in hash__do_page_fault() ?

>   }
>   
>   #ifdef CONFIG_PPC_BOOK3S_64

