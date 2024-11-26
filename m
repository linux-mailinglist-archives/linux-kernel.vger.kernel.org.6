Return-Path: <linux-kernel+bounces-422206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B19D95D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DC8283023
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A01CCB40;
	Tue, 26 Nov 2024 10:53:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A3522F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618388; cv=none; b=L4EgHqlFmmfHa12nUW4kRKI0fPmNUpE9eGYSPvON3EKveu9DdTVlToqhOp5mrIEECcdNRC8kd9iJD7Hq+pIF92SFSk5lpNXFPrjAkAtbPN/orXFLdnHbtwjcCLfG/3LytZ4vPlZjATu/VW5xR8oCO95PNSPZrq2eybS0nn0e9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618388; c=relaxed/simple;
	bh=xFal8Zxi64lrl6DKcMidQQ0j/wlQLNpChiha5c0//dE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClBTTncfL+iYoQ/IuwUACS2LMDoLv6TVVvjcRgOTk2J9Tuvackjquvag/F3Tive9WMpsXF6upmZbK+W39aQVIWw5Cj0Y0PVidARnGWC6ZCqgnvnewY0jMs9t4nw02W2NkrX2haT09VxruqRKbcqv3R7SYV74NsPgvegMd82aluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XyKDJ2wVlz9sRy;
	Tue, 26 Nov 2024 11:53:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccCw1T0xF9VZ; Tue, 26 Nov 2024 11:53:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XyKDJ1mk5z9sRr;
	Tue, 26 Nov 2024 11:53:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 298B68B776;
	Tue, 26 Nov 2024 11:53:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id c1FcoxhNcuJA; Tue, 26 Nov 2024 11:53:04 +0100 (CET)
Received: from [192.168.232.206] (unknown [192.168.232.206])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A04338B763;
	Tue, 26 Nov 2024 11:53:03 +0100 (CET)
Message-ID: <97991c77-4d9c-4e33-a076-2dd79cd454fb@csgroup.eu>
Date: Tue, 26 Nov 2024 11:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc: Add preempt lazy support
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Luming Yu <luming.yu@shingroup.cn>
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org
References: <20241116192306.88217-1-sshegde@linux.ibm.com>
 <20241116192306.88217-2-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241116192306.88217-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/11/2024 à 20:23, Shrikanth Hegde a écrit :
> Define preempt lazy bit for Powerpc. Use bit 9 which is free and within
> 16 bit range of NEED_RESCHED, so compiler can issue single andi.
> 
> Since Powerpc doesn't use the generic entry/exit, add lazy check at exit
> to user. CONFIG_PREEMPTION is defined for lazy/full/rt so use it for
> return to kernel.

FWIW, there is work in progress on using generic entry/exit for powerpc, 
if you can help testing it that can help, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/F0AE0A4571CE3126+20241111031934.1579-2-luming.yu@shingroup.cn/

Christophe


> 
> Ran a few benchmarks and db workload on Power10. Performance is close to
> preempt=none/voluntary.
>   
> Since Powerpc systems can have large core count and large memory,
> preempt lazy is going to be helpful in avoiding soft lockup issues.
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/Kconfig                   | 1 +
>   arch/powerpc/include/asm/thread_info.h | 9 ++++++---
>   arch/powerpc/kernel/interrupt.c        | 4 ++--
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 8094a01974cc..2f625aecf94b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -145,6 +145,7 @@ config PPC
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_PHYS_TO_DMA
>   	select ARCH_HAS_PMEM_API
> +	select ARCH_HAS_PREEMPT_LAZY
>   	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 6ebca2996f18..2785c7462ebf 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -103,6 +103,7 @@ void arch_setup_new_exec(void);
>   #define TIF_PATCH_PENDING	6	/* pending live patching update */
>   #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>   #define TIF_SINGLESTEP		8	/* singlestepping active */
> +#define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
>   #define TIF_SECCOMP		10	/* secure computing */
>   #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
>   #define TIF_NOERROR		12	/* Force successful syscall return */
> @@ -122,6 +123,7 @@ void arch_setup_new_exec(void);
>   #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
>   #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
>   #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
> +#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
>   #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
>   #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
>   #define _TIF_32BIT		(1<<TIF_32BIT)
> @@ -142,9 +144,10 @@ void arch_setup_new_exec(void);
>   				 _TIF_SYSCALL_EMU)
>   
>   #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
> -				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> -				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
> -				 _TIF_NOTIFY_SIGNAL)
> +				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
> +				 _TIF_UPROBE | _TIF_RESTORE_TM | \
> +				 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL)
> +
>   #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
>   
>   /* Bits in local_flags */
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index af62ec974b97..8f4acc55407b 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>   	ti_flags = read_thread_flags();
>   	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
>   		local_irq_enable();
> -		if (ti_flags & _TIF_NEED_RESCHED) {
> +		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
>   			schedule();
>   		} else {
>   			/*
> @@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>   		/* Returning to a kernel context with local irqs enabled. */
>   		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>   again:
> -		if (IS_ENABLED(CONFIG_PREEMPT)) {
> +		if (IS_ENABLED(CONFIG_PREEMPTION)) {
>   			/* Return to preemptible kernel context */
>   			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>   				if (preempt_count() == 0)

