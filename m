Return-Path: <linux-kernel+bounces-362242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FBD99B295
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B7441F25651
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4D014B084;
	Sat, 12 Oct 2024 09:35:59 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FD13D29A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728725758; cv=none; b=EjTqjXazsC7i/yb2pottp14EihJwBE7a3bs72VFga73YIXNgjcLhRaGbJ5PP6G91L94I33ywoQlHn/Sw5r7gUBW6yDT1aLQUdjXFESY4rG0E7ZJqyR8445Klqplv3oU5JpLqoz7Rk7I2ZknD11WdLVUzgOiuAk4w+LEc3Klrvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728725758; c=relaxed/simple;
	bh=1AdBHNVDkRDEcb8JwVpeSQ4lse/L8CyQ27CueuURIV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ChQeSHwHkP3T8AEOmgrbuo0F2oxfgCCkd0MsR3ivsROXX80xgdqJDpVD4ZelTp6TYX0eGcrM0SlydB4SciZOjKaRbhr8Hgsxsq3x8oLGX3eNOuSZMPlNq0pedwOI744trV7SzoUrlb41KHPvRlD7Otqu/x8YSJllgjO3BoWL1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XQdf305Y5z9sPd;
	Sat, 12 Oct 2024 11:35:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r27Z1httjJ5w; Sat, 12 Oct 2024 11:35:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XQdf26HGhz9rvV;
	Sat, 12 Oct 2024 11:35:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C54EF8B765;
	Sat, 12 Oct 2024 11:35:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gZs3AGf8cAno; Sat, 12 Oct 2024 11:35:54 +0200 (CEST)
Received: from [192.168.232.206] (unknown [192.168.232.206])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B9DC8B764;
	Sat, 12 Oct 2024 11:35:54 +0200 (CEST)
Message-ID: <d2040f5b-008b-4c45-9cbc-9ea5c25c9149@csgroup.eu>
Date: Sat, 12 Oct 2024 11:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] powerpc/entry: add irqentry_state and generic entry
 support
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 jialong.yang@shingroup.cn, luming.yu@gmail.com
References: <20241012035621.1245-3-luming.yu@shingroup.cn>
 <5ADB50C5F6678977+20241012035621.1245-7-luming.yu@shingroup.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <5ADB50C5F6678977+20241012035621.1245-7-luming.yu@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/10/2024 à 05:56, Luming Yu a écrit :
> generic irq entry support via generic irqentry is added for powerpc.
> There may be duplciate calls and missing callbacks requires further
> work.
> 
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>

This patch doesn't apply.

Applying: powerpc/entry: add irqentry_state and generic entry support
error: patch failed: arch/powerpc/kernel/interrupt.c:3
error: arch/powerpc/kernel/interrupt.c: patch does not apply
Patch failed at 0005 powerpc/entry: add irqentry_state and generic entry 
support

I tried on v6.11, v6.12-rc2 and next-20241011

> ---
>   arch/powerpc/include/asm/entry-common.h | 32 ++++++++++++++++
>   arch/powerpc/kernel/interrupt.c         | 51 +++++--------------------
>   arch/powerpc/kernel/signal.c            |  7 ++++
>   arch/powerpc/kernel/syscall.c           |  2 -
>   4 files changed, 49 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index 51f1eb767696..faa829e15b5d 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -3,6 +3,7 @@
>   #define ARCH_POWERPC_ENTRY_COMMON_H
>   
>   #include <linux/user-return-notifier.h>
> +#include <asm/switch_to.h>
>   
>   static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   						  unsigned long ti_work)
> @@ -13,4 +14,35 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   
>   #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>   
> +static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
> +						unsigned long ti_work)
> +{
> +
> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
> +		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> +				unlikely((ti_work & _TIF_RESTORE_TM))) {
> +			restore_tm_state(regs);
> +		} else {
> +			unsigned long mathflags = MSR_FP;
> +
> +			if (cpu_has_feature(CPU_FTR_VSX))
> +				mathflags |= MSR_VEC | MSR_VSX;
> +			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
> +				mathflags |= MSR_VEC;
> +
> +			/*
> +			 * If userspace MSR has all available FP bits set,
> +			 * then they are live and no need to restore. If not,
> +			 * it means the regs were given up and restore_math
> +			 * may decide to restore them (to avoid taking an FP
> +			 * fault).
> +			 */
> +			if ((regs->msr & mathflags) != mathflags)
> +				restore_math(regs);
> +		}
> +	}
> +}
> +
> +#define arch_exit_to_user_mode_work arch_exit_to_user_mode_work
> +
>   #endif
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 609ba48034de..42af9217136d 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -3,6 +3,7 @@
>   #include <linux/context_tracking.h>
>   #include <linux/err.h>
>   #include <linux/compat.h>
> +#include <linux/entry-common.h>
>   #include <linux/sched/debug.h> /* for show_regs */
>   
>   #include <asm/kup.h>
> @@ -183,47 +184,11 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>   
>   again:
>   	ti_flags = read_thread_flags();
> -	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
> -		local_irq_enable();
> -		if (ti_flags & _TIF_NEED_RESCHED) {
> -			schedule();
> -		} else {
> -			/*
> -			 * SIGPENDING must restore signal handler function
> -			 * argument GPRs, and some non-volatiles (e.g., r1).
> -			 * Restore all for now. This could be made lighter.
> -			 */
> -			if (ti_flags & _TIF_SIGPENDING)
> -				ret |= _TIF_RESTOREALL;
> -			do_notify_resume(regs, ti_flags);
> -		}
> -		local_irq_disable();
> -		ti_flags = read_thread_flags();
> -	}
>   
> -	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
> -		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
> -				unlikely((ti_flags & _TIF_RESTORE_TM))) {
> -			restore_tm_state(regs);
> -		} else {
> -			unsigned long mathflags = MSR_FP;
> -
> -			if (cpu_has_feature(CPU_FTR_VSX))
> -				mathflags |= MSR_VEC | MSR_VSX;
> -			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
> -				mathflags |= MSR_VEC;
> -
> -			/*
> -			 * If userspace MSR has all available FP bits set,
> -			 * then they are live and no need to restore. If not,
> -			 * it means the regs were given up and restore_math
> -			 * may decide to restore them (to avoid taking an FP
> -			 * fault).
> -			 */
> -			if ((regs->msr & mathflags) != mathflags)
> -				restore_math(regs);
> -		}
> -	}
> +	if (ti_flags & _TIF_SIGPENDING)
> +		ret |= _TIF_RESTOREALL;
> +	if (unlikely(ti_flags & EXIT_TO_USER_MODE_WORK))
> +		ti_flags = exit_to_user_mode_loop(regs, ti_flags);
>   
>   	check_return_regs_valid(regs);
>   
> @@ -297,11 +262,15 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>   	}
>   
>   	local_irq_disable();
> -	ret = interrupt_exit_user_prepare_main(ret, regs);
> +	if (ti_flags & _TIF_RESTOREALL)
> +		ret |= _TIF_RESTOREALL;
>   
> +	if (ti_flags & _TIF_SIGPENDING)
> +		ret |= _TIF_RESTOREALL;
>   #ifdef CONFIG_PPC64
>   	regs->exit_result = ret;
>   #endif
> +	syscall_exit_to_user_mode(regs);
>   
>   	return ret;
>   }
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index aa17e62f3754..da21e7fef46a 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -11,6 +11,7 @@
>   #include <linux/uprobes.h>
>   #include <linux/key.h>
>   #include <linux/context_tracking.h>
> +#include <linux/entry-common.h>
>   #include <linux/livepatch.h>
>   #include <linux/syscalls.h>
>   #include <asm/hw_breakpoint.h>
> @@ -368,3 +369,9 @@ void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
>   		printk_ratelimited(regs->msr & MSR_64BIT ? fm64 : fm32, tsk->comm,
>   				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);
>   }
> +
> +void arch_do_signal_or_restart(struct pt_regs *regs)
> +{
> +	BUG_ON(regs != current->thread.regs);
> +	do_signal(current);
> +}
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index e0338bd8d383..97f158d13944 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -185,8 +185,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	 * So the resulting 6 or 7 bits of entropy is seen in SP[9:4] or SP[9:3].
>   	 */
>   	choose_random_kstack_offset(mftb());
> -	/*common entry*/
> -	syscall_exit_to_user_mode(regs);
>   
>   	return ret;
>   }

