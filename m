Return-Path: <linux-kernel+bounces-332196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4BB97B6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740C41C224FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FC210EC;
	Wed, 18 Sep 2024 01:59:37 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD62AEE1
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624775; cv=none; b=G7zE5Ip6v1E5f0OHE1nh/Ymp3qrrrThjVRR7WxqEDQttHiAEl6kN+OqrGCMdnH1wD28f5mCb9zrv3RYYInKHNEIg6Y+AbxaRwhrZ6XOnqFaddilefn/W+Y6bVwoajkA5GYo4G0lRgjMyqTb1EkDHsy/7AK/FCj5FT5qhlSXcjYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624775; c=relaxed/simple;
	bh=AiLfIWpgSohB6ltCwyreVb8GkHrjbhOM8N5/CKXcWRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZcoKsBFV45DpSPmauAMeyTzCA+bktEEnheBUQoDrb8r9AOeJhaXRf29Jb5UJo/RnpDZDJeuid6Mo1wmaZzS19H9IQDRifFwlRNvcX6FmGR/QmhcddG6WEgEzTq6k0FErgSLteJfOwbUym5Rufm+Gqa0P1JOr0SJqbx909YEB9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X7hcs5wJrz1T7bc;
	Wed, 18 Sep 2024 09:58:05 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E6DC1402E0;
	Wed, 18 Sep 2024 09:59:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 18 Sep 2024 09:59:20 +0800
Message-ID: <8ebbbb8f-cc83-9bb6-4c90-f5c36cf76538@huawei.com>
Date: Wed, 18 Sep 2024 09:59:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/3] arm64: entry: Convert to generic entry
Content-Language: en-US
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <rostedt@goodmis.org>,
	<arnd@arndb.de>, <ardb@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-4-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240629085601.470241-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Hi, Catalin, Will and Mark, do you have any good suggestions and ideas?

On 2024/6/29 16:56, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> to use the generic entry infrastructure from kernel/entry/*. The generic
> entry makes maintainers' work easier and codes more elegant, which also
> removed duplicate 150+ LOC. The changes are below:
> 
>  - Remove TIF_SYSCALL_* flag, _TIF_WORK_MASK, _TIF_SYSCALL_WORK
> 
>  - Remove syscall_trace_enter/exit() and use generic one.
> 
>  - Remove *enter_from/exit_to_kernel_mode(), and wrap with generic
>    irqentry_enter/exit().
> 
>  - Remove *enter_from/exit_to_user_mode(), and wrap with generic
>    irqentry_enter_from/exit_to_user_mode().
> 
>  - Remove arm64_enter/exit_nmi() and use generic irqentry_nmi_enter/exit().
> 
>  - Remove PREEMPT_DYNAMIC code, as generic entry will do it ok by
>    implementing arch_irqentry_exit_need_resched().
> 
> Tested ok with following test cases on Qemu cortex-a53 and HiSilicon
> Kunpeng-920:
> 
>  - Run `perf top` command
> 
>  - Switch between different `dynamic preempt` mode
> 
>  - Use `pseudo nmi`
> 
>  - stress-ng CPU stress test.
> 
>  - MTE test case in Documentation/arch/arm64/memory-tagging-extension.rst
>    and all test cases in tools/testing/selftests/arm64/mte/* (Only Qemu).
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Tested-by: Kees Cook <kees@kernel.org>
> ---
> v3:
> - Test the MTE test cases.
> - Handle forget_syscall() in arch_post_report_syscall_entry()
> - Rebased on the previous patch, so move the arch funcs to entry-common.h.
> - Change __always_inline() to inline for arch_enter_from_kernel_mode() and
>   arch_exit_to_kernel_mode_prepare(), add inline for the other arch funcs.
> - Remove unused signal.h for entry-common.h.
> 
> v2:
> - Add Tested-by.
> - Rebased on the refactored report_syscall() code.
> - Add comment for arch_prepare_report_syscall_exit().
> - Update the commit message.
> - Adjust entry-common.h header file inclusion to alphabetical order.
> ---
>  arch/arm64/Kconfig                    |   1 +
>  arch/arm64/include/asm/entry-common.h | 172 ++++++++++++
>  arch/arm64/include/asm/syscall.h      |   6 +-
>  arch/arm64/include/asm/thread_info.h  |  23 +-
>  arch/arm64/kernel/entry-common.c      | 368 +++++---------------------
>  arch/arm64/kernel/ptrace.c            | 101 -------
>  arch/arm64/kernel/signal.c            |   3 +-
>  arch/arm64/kernel/syscall.c           |  18 +-
>  8 files changed, 264 insertions(+), 428 deletions(-)
>  create mode 100644 arch/arm64/include/asm/entry-common.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d91259ee7b5..e6ccc5ea06fe 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -138,6 +138,7 @@ config ARM64
>  	select GENERIC_CPU_DEVICES
>  	select GENERIC_CPU_VULNERABILITIES
>  	select GENERIC_EARLY_IOREMAP
> +	select GENERIC_ENTRY
>  	select GENERIC_IDLE_POLL_SETUP
>  	select GENERIC_IOREMAP
>  	select GENERIC_IRQ_IPI
> diff --git a/arch/arm64/include/asm/entry-common.h b/arch/arm64/include/asm/entry-common.h
> new file mode 100644
> index 000000000000..a14d62b2eb69
> --- /dev/null
> +++ b/arch/arm64/include/asm/entry-common.h
> @@ -0,0 +1,172 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_ARM64_ENTRY_COMMON_H
> +#define _ASM_ARM64_ENTRY_COMMON_H
> +
> +#include <linux/thread_info.h>
> +
> +#include <asm/daifflags.h>
> +#include <asm/fpsimd.h>
> +#include <asm/mte.h>
> +#include <asm/stacktrace.h>
> +
> +enum ptrace_syscall_dir {
> +	PTRACE_SYSCALL_ENTER = 0,
> +	PTRACE_SYSCALL_EXIT,
> +};
> +
> +#define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_MTE_ASYNC_FAULT | _TIF_FOREIGN_FPSTATE)
> +
> +static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
> +{
> +	mte_disable_tco_entry(current);
> +}
> +
> +#define arch_enter_from_user_mode arch_enter_from_user_mode
> +
> +static __always_inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
> +							unsigned long ti_work)
> +{
> +	if (ti_work & _TIF_MTE_ASYNC_FAULT) {
> +		clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> +		send_sig_fault(SIGSEGV, SEGV_MTEAERR, (void __user *)NULL, current);
> +	}
> +
> +	if (ti_work & _TIF_FOREIGN_FPSTATE)
> +		fpsimd_restore_current_state();
> +}
> +
> +#define arch_exit_to_user_mode_work arch_exit_to_user_mode_work
> +
> +static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
> +						  unsigned long ti_work)
> +{
> +	local_daif_mask();
> +	mte_check_tfsr_exit();
> +}
> +
> +#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> +
> +static inline void arch_enter_from_kernel_mode(struct pt_regs *regs)
> +{
> +	mte_check_tfsr_entry();
> +	mte_disable_tco_entry(current);
> +}
> +
> +#define arch_enter_from_kernel_mode arch_enter_from_kernel_mode
> +
> +static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs)
> +{
> +	mte_check_tfsr_exit();
> +}
> +
> +#define arch_exit_to_kernel_mode_prepare arch_exit_to_kernel_mode_prepare
> +
> +static inline bool arch_irqentry_exit_need_resched(void)
> +{
> +	/*
> +	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
> +	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
> +	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
> +	 * DAIF we must have handled an NMI, so skip preemption.
> +	 */
> +	if (system_uses_irq_prio_masking() && read_sysreg(daif))
> +		return false;
> +
> +	/*
> +	 * Preempting a task from an IRQ means we leave copies of PSTATE
> +	 * on the stack. cpufeature's enable calls may modify PSTATE, but
> +	 * resuming one of these preempted tasks would undo those changes.
> +	 *
> +	 * Only allow a task to be preempted once cpufeatures have been
> +	 * enabled.
> +	 */
> +	if (!system_capabilities_finalized())
> +		return false;
> +
> +	return true;
> +}
> +
> +#define arch_irqentry_exit_need_resched arch_irqentry_exit_need_resched
> +
> +static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs)
> +{
> +	unsigned long saved_reg;
> +	int regno;
> +
> +	/*
> +	 * We have some ABI weirdness here in the way that we handle syscall
> +	 * exit stops because we indicate whether or not the stop has been
> +	 * signalled from syscall entry or syscall exit by clobbering a general
> +	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> +	 * and restoring its old value after the stop. This means that:
> +	 *
> +	 * - Any writes by the tracer to this register during the stop are
> +	 *   ignored/discarded.
> +	 *
> +	 * - The actual value of the register is not available during the stop,
> +	 *   so the tracer cannot save it and restore it later.
> +	 *
> +	 * - Syscall stops behave differently to seccomp and pseudo-step traps
> +	 *   (the latter do not nobble any registers).
> +	 */
> +	regno = (is_compat_task() ? 12 : 7);
> +	saved_reg = regs->regs[regno];
> +	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
> +
> +	return saved_reg;
> +}
> +
> +#define arch_prepare_report_syscall_entry arch_prepare_report_syscall_entry
> +
> +static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
> +						  unsigned long saved_reg, long ret)
> +{
> +	int regno = (is_compat_task() ? 12 : 7);
> +
> +	if (ret)
> +		forget_syscall(regs);
> +
> +	regs->regs[regno] = saved_reg;
> +}
> +
> +#define arch_post_report_syscall_entry arch_post_report_syscall_entry
> +
> +static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
> +							     unsigned long work)
> +{
> +	unsigned long saved_reg;
> +	int regno;
> +
> +	/* See comment for arch_prepare_report_syscall_entry() */
> +	regno = (is_compat_task() ? 12 : 7);
> +	saved_reg = regs->regs[regno];
> +	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
> +
> +	if (report_single_step(work)) {
> +		/*
> +		 * Signal a pseudo-step exception since we are stepping but
> +		 * tracer modifications to the registers may have rewound the
> +		 * state machine.
> +		 */
> +		regs->regs[regno] = saved_reg;
> +	}
> +
> +	return saved_reg;
> +}
> +
> +#define arch_prepare_report_syscall_exit arch_prepare_report_syscall_exit
> +
> +static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
> +						 unsigned long saved_reg,
> +						 unsigned long work)
> +{
> +	int regno = (is_compat_task() ? 12 : 7);
> +
> +	if (!report_single_step(work))
> +		regs->regs[regno] = saved_reg;
> +}
> +
> +#define arch_post_report_syscall_exit arch_post_report_syscall_exit
> +
> +#endif /* _ASM_ARM64_ENTRY_COMMON_H */
> diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
> index ab8e14b96f68..9891b15da4c3 100644
> --- a/arch/arm64/include/asm/syscall.h
> +++ b/arch/arm64/include/asm/syscall.h
> @@ -85,7 +85,9 @@ static inline int syscall_get_arch(struct task_struct *task)
>  	return AUDIT_ARCH_AARCH64;
>  }
>  
> -int syscall_trace_enter(struct pt_regs *regs);
> -void syscall_trace_exit(struct pt_regs *regs);
> +static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> +{
> +	return false;
> +}
>  
>  #endif	/* __ASM_SYSCALL_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index e72a3bf9e563..ec5d74c53bf9 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -43,6 +43,7 @@ struct thread_info {
>  	void			*scs_sp;
>  #endif
>  	u32			cpu;
> +	unsigned long		syscall_work;   /* SYSCALL_WORK_ flags */
>  };
>  
>  #define thread_saved_pc(tsk)	\
> @@ -64,11 +65,6 @@ void arch_setup_new_exec(void);
>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>  #define TIF_MTE_ASYNC_FAULT	5	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	6	/* signal notifications exist */
> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> -#define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
> -#define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
> -#define TIF_SECCOMP		11	/* syscall secure computing */
> -#define TIF_SYSCALL_EMU		12	/* syscall emulation active */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20
> @@ -86,27 +82,12 @@ void arch_setup_new_exec(void);
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
> -#define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
> -#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
> -#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
> -#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> -#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
> -#define _TIF_UPROBE		(1 << TIF_UPROBE)
> -#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
> +#define _TIF_UPROBE            (1 << TIF_UPROBE)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
>  #define _TIF_SVE		(1 << TIF_SVE)
>  #define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
>  #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  
> -#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> -				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -				 _TIF_UPROBE | _TIF_MTE_ASYNC_FAULT | \
> -				 _TIF_NOTIFY_SIGNAL)
> -
> -#define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
> -				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> -				 _TIF_SYSCALL_EMU)
> -
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  #define INIT_SCS							\
>  	.scs_base	= init_shadow_call_stack,			\
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index b77a15955f28..ac61aeb93933 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
>  #include <linux/thread_info.h>
> +#include <linux/entry-common.h>
>  
>  #include <asm/cpufeature.h>
>  #include <asm/daifflags.h>
> @@ -28,201 +29,15 @@
>  #include <asm/sysreg.h>
>  #include <asm/system_misc.h>
>  
> -/*
> - * Handle IRQ/context state management when entering from kernel mode.
> - * Before this function is called it is not safe to call regular kernel code,
> - * instrumentable code, or any code which may trigger an exception.
> - *
> - * This is intended to match the logic in irqentry_enter(), handling the kernel
> - * mode transitions only.
> - */
> -static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
> -{
> -	regs->exit_rcu = false;
> -
> -	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
> -		lockdep_hardirqs_off(CALLER_ADDR0);
> -		ct_irq_enter();
> -		trace_hardirqs_off_finish();
> -
> -		regs->exit_rcu = true;
> -		return;
> -	}
> -
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> -	rcu_irq_enter_check_tick();
> -	trace_hardirqs_off_finish();
> -}
> -
> -static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
> -{
> -	__enter_from_kernel_mode(regs);
> -	mte_check_tfsr_entry();
> -	mte_disable_tco_entry(current);
> -}
> -
> -/*
> - * Handle IRQ/context state management when exiting to kernel mode.
> - * After this function returns it is not safe to call regular kernel code,
> - * instrumentable code, or any code which may trigger an exception.
> - *
> - * This is intended to match the logic in irqentry_exit(), handling the kernel
> - * mode transitions only, and with preemption handled elsewhere.
> - */
> -static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
> -{
> -	lockdep_assert_irqs_disabled();
> -
> -	if (interrupts_enabled(regs)) {
> -		if (regs->exit_rcu) {
> -			trace_hardirqs_on_prepare();
> -			lockdep_hardirqs_on_prepare();
> -			ct_irq_exit();
> -			lockdep_hardirqs_on(CALLER_ADDR0);
> -			return;
> -		}
> -
> -		trace_hardirqs_on();
> -	} else {
> -		if (regs->exit_rcu)
> -			ct_irq_exit();
> -	}
> -}
> -
> -static void noinstr exit_to_kernel_mode(struct pt_regs *regs)
> -{
> -	mte_check_tfsr_exit();
> -	__exit_to_kernel_mode(regs);
> -}
> -
> -/*
> - * Handle IRQ/context state management when entering from user mode.
> - * Before this function is called it is not safe to call regular kernel code,
> - * instrumentable code, or any code which may trigger an exception.
> - */
> -static __always_inline void __enter_from_user_mode(void)
> +static __always_inline void exit_to_user_mode_wrapper(struct pt_regs *regs)
>  {
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> -	CT_WARN_ON(ct_state() != CONTEXT_USER);
> -	user_exit_irqoff();
> -	trace_hardirqs_off_finish();
> -	mte_disable_tco_entry(current);
> -}
> -
> -static __always_inline void enter_from_user_mode(struct pt_regs *regs)
> -{
> -	__enter_from_user_mode();
> -}
> -
> -/*
> - * Handle IRQ/context state management when exiting to user mode.
> - * After this function returns it is not safe to call regular kernel code,
> - * instrumentable code, or any code which may trigger an exception.
> - */
> -static __always_inline void __exit_to_user_mode(void)
> -{
> -	trace_hardirqs_on_prepare();
> -	lockdep_hardirqs_on_prepare();
> -	user_enter_irqoff();
> -	lockdep_hardirqs_on(CALLER_ADDR0);
> -}
> -
> -static void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
> -{
> -	do {
> -		local_irq_enable();
> -
> -		if (thread_flags & _TIF_NEED_RESCHED)
> -			schedule();
> -
> -		if (thread_flags & _TIF_UPROBE)
> -			uprobe_notify_resume(regs);
> -
> -		if (thread_flags & _TIF_MTE_ASYNC_FAULT) {
> -			clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> -			send_sig_fault(SIGSEGV, SEGV_MTEAERR,
> -				       (void __user *)NULL, current);
> -		}
> -
> -		if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> -			do_signal(regs);
> -
> -		if (thread_flags & _TIF_NOTIFY_RESUME)
> -			resume_user_mode_work(regs);
> -
> -		if (thread_flags & _TIF_FOREIGN_FPSTATE)
> -			fpsimd_restore_current_state();
> -
> -		local_irq_disable();
> -		thread_flags = read_thread_flags();
> -	} while (thread_flags & _TIF_WORK_MASK);
> -}
> -
> -static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
> -{
> -	unsigned long flags;
> -
>  	local_irq_disable();
> -
> -	flags = read_thread_flags();
> -	if (unlikely(flags & _TIF_WORK_MASK))
> -		do_notify_resume(regs, flags);
> -
> -	local_daif_mask();
> -
> -	lockdep_sys_exit();
> -}
> -
> -static __always_inline void exit_to_user_mode(struct pt_regs *regs)
> -{
> -	exit_to_user_mode_prepare(regs);
> -	mte_check_tfsr_exit();
> -	__exit_to_user_mode();
> +	irqentry_exit_to_user_mode(regs);
>  }
>  
>  asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
>  {
> -	exit_to_user_mode(regs);
> -}
> -
> -/*
> - * Handle IRQ/context state management when entering an NMI from user/kernel
> - * mode. Before this function is called it is not safe to call regular kernel
> - * code, instrumentable code, or any code which may trigger an exception.
> - */
> -static void noinstr arm64_enter_nmi(struct pt_regs *regs)
> -{
> -	regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
> -
> -	__nmi_enter();
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> -	lockdep_hardirq_enter();
> -	ct_nmi_enter();
> -
> -	trace_hardirqs_off_finish();
> -	ftrace_nmi_enter();
> -}
> -
> -/*
> - * Handle IRQ/context state management when exiting an NMI from user/kernel
> - * mode. After this function returns it is not safe to call regular kernel
> - * code, instrumentable code, or any code which may trigger an exception.
> - */
> -static void noinstr arm64_exit_nmi(struct pt_regs *regs)
> -{
> -	bool restore = regs->lockdep_hardirqs;
> -
> -	ftrace_nmi_exit();
> -	if (restore) {
> -		trace_hardirqs_on_prepare();
> -		lockdep_hardirqs_on_prepare();
> -	}
> -
> -	ct_nmi_exit();
> -	lockdep_hardirq_exit();
> -	if (restore)
> -		lockdep_hardirqs_on(CALLER_ADDR0);
> -	__nmi_exit();
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  /*
> @@ -259,48 +74,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#define need_irq_preemption() \
> -	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
> -static void __sched arm64_preempt_schedule_irq(void)
> -{
> -	if (!need_irq_preemption())
> -		return;
> -
> -	/*
> -	 * Note: thread_info::preempt_count includes both thread_info::count
> -	 * and thread_info::need_resched, and is not equivalent to
> -	 * preempt_count().
> -	 */
> -	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
> -		return;
> -
> -	/*
> -	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
> -	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
> -	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
> -	 * DAIF we must have handled an NMI, so skip preemption.
> -	 */
> -	if (system_uses_irq_prio_masking() && read_sysreg(daif))
> -		return;
> -
> -	/*
> -	 * Preempting a task from an IRQ means we leave copies of PSTATE
> -	 * on the stack. cpufeature's enable calls may modify PSTATE, but
> -	 * resuming one of these preempted tasks would undo those changes.
> -	 *
> -	 * Only allow a task to be preempted once cpufeatures have been
> -	 * enabled.
> -	 */
> -	if (system_capabilities_finalized())
> -		preempt_schedule_irq();
> -}
> -
>  static void do_interrupt_handler(struct pt_regs *regs,
>  				 void (*handler)(struct pt_regs *))
>  {
> @@ -320,7 +93,7 @@ extern void (*handle_arch_fiq)(struct pt_regs *);
>  static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
>  				      unsigned long esr)
>  {
> -	arm64_enter_nmi(regs);
> +	irqentry_nmi_enter(regs);
>  
>  	console_verbose();
>  
> @@ -426,41 +199,43 @@ UNHANDLED(el1t, 64, error)
>  static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
>  {
>  	unsigned long far = read_sysreg(far_el1);
> +	irqentry_state_t state = irqentry_enter(regs);
>  
> -	enter_from_kernel_mode(regs);
>  	local_daif_inherit(regs);
>  	do_mem_abort(far, esr, regs);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	irqentry_exit(regs, state);
>  }
>  
>  static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
>  {
>  	unsigned long far = read_sysreg(far_el1);
> +	irqentry_state_t state = irqentry_enter(regs);
>  
> -	enter_from_kernel_mode(regs);
>  	local_daif_inherit(regs);
>  	do_sp_pc_abort(far, esr, regs);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	irqentry_exit(regs, state);
>  }
>  
>  static void noinstr el1_undef(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	irqentry_state_t state = irqentry_enter(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_undef(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	irqentry_exit(regs, state);
>  }
>  
>  static void noinstr el1_bti(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	irqentry_state_t state = irqentry_enter(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_bti(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	irqentry_exit(regs, state);
>  }
>  
>  static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
> @@ -475,11 +250,12 @@ static void noinstr el1_dbg(struct pt_regs *regs, unsigned long esr)
>  
>  static void noinstr el1_fpac(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_kernel_mode(regs);
> +	irqentry_state_t state = irqentry_enter(regs);
> +
>  	local_daif_inherit(regs);
>  	do_el1_fpac(regs, esr);
>  	local_daif_mask();
> -	exit_to_kernel_mode(regs);
> +	irqentry_exit(regs, state);
>  }
>  
>  asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
> @@ -522,23 +298,22 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>  static __always_inline void __el1_pnmi(struct pt_regs *regs,
>  				       void (*handler)(struct pt_regs *))
>  {
> -	arm64_enter_nmi(regs);
> +	irqentry_state_t state = irqentry_nmi_enter(regs);
> +
>  	do_interrupt_handler(regs, handler);
> -	arm64_exit_nmi(regs);
> +	irqentry_nmi_exit(regs, state);
>  }
>  
>  static __always_inline void __el1_irq(struct pt_regs *regs,
>  				      void (*handler)(struct pt_regs *))
>  {
> -	enter_from_kernel_mode(regs);
> +	irqentry_state_t state = irqentry_enter(regs);
>  
>  	irq_enter_rcu();
>  	do_interrupt_handler(regs, handler);
>  	irq_exit_rcu();
>  
> -	arm64_preempt_schedule_irq();
> -
> -	exit_to_kernel_mode(regs);
> +	irqentry_exit(regs, state);
>  }
>  static void noinstr el1_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
> @@ -564,21 +339,22 @@ asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
>  asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	irqentry_state_t state;
>  
>  	local_daif_restore(DAIF_ERRCTX);
> -	arm64_enter_nmi(regs);
> +	state = irqentry_nmi_enter(regs);
>  	do_serror(regs, esr);
> -	arm64_exit_nmi(regs);
> +	irqentry_nmi_exit(regs, state);
>  }
>  
>  static void noinstr el0_da(struct pt_regs *regs, unsigned long esr)
>  {
>  	unsigned long far = read_sysreg(far_el1);
>  
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_mem_abort(far, esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_ia(struct pt_regs *regs, unsigned long esr)
> @@ -593,50 +369,50 @@ static void noinstr el0_ia(struct pt_regs *regs, unsigned long esr)
>  	if (!is_ttbr0_addr(far))
>  		arm64_apply_bp_hardening();
>  
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_mem_abort(far, esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_fpsimd_acc(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_fpsimd_acc(esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_sve_acc(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_sve_acc(esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_sme_acc(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_sme_acc(esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_fpsimd_exc(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_fpsimd_exc(esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_sys(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_sys(esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_pc(struct pt_regs *regs, unsigned long esr)
> @@ -646,50 +422,50 @@ static void noinstr el0_pc(struct pt_regs *regs, unsigned long esr)
>  	if (!is_ttbr0_addr(instruction_pointer(regs)))
>  		arm64_apply_bp_hardening();
>  
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_sp_pc_abort(far, esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_sp(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_sp_pc_abort(regs->sp, esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_undef(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_undef(regs, esr);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_bti(struct pt_regs *regs)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_bti(regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_mops(regs, esr);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	bad_el0_sync(regs, 0, esr);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
> @@ -697,28 +473,28 @@ static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
>  	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
>  	unsigned long far = read_sysreg(far_el1);
>  
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	do_debug_exception(far, esr, regs);
>  	local_daif_restore(DAIF_PROCCTX);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_svc(struct pt_regs *regs)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	cortex_a76_erratum_1463225_svc_handler();
>  	fp_user_discard();
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_svc(regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_fpac(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_fpac(regs, esr);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
> @@ -783,7 +559,7 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>  static void noinstr el0_interrupt(struct pt_regs *regs,
>  				  void (*handler)(struct pt_regs *))
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  
>  	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
>  
> @@ -794,7 +570,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>  	do_interrupt_handler(regs, handler);
>  	irq_exit_rcu();
>  
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr __el0_irq_handler_common(struct pt_regs *regs)
> @@ -820,14 +596,15 @@ asmlinkage void noinstr el0t_64_fiq_handler(struct pt_regs *regs)
>  static void noinstr __el0_error_handler_common(struct pt_regs *regs)
>  {
>  	unsigned long esr = read_sysreg(esr_el1);
> +	irqentry_state_t state_nmi;
>  
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_ERRCTX);
> -	arm64_enter_nmi(regs);
> +	state_nmi = irqentry_nmi_enter(regs);
>  	do_serror(regs, esr);
> -	arm64_exit_nmi(regs);
> +	irqentry_nmi_exit(regs, state_nmi);
>  	local_daif_restore(DAIF_PROCCTX);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  asmlinkage void noinstr el0t_64_error_handler(struct pt_regs *regs)
> @@ -838,19 +615,19 @@ asmlinkage void noinstr el0t_64_error_handler(struct pt_regs *regs)
>  #ifdef CONFIG_COMPAT
>  static void noinstr el0_cp15(struct pt_regs *regs, unsigned long esr)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_cp15(esr, regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  static void noinstr el0_svc_compat(struct pt_regs *regs)
>  {
> -	enter_from_user_mode(regs);
> +	irqentry_enter_from_user_mode(regs);
>  	cortex_a76_erratum_1463225_svc_handler();
>  	local_daif_restore(DAIF_PROCCTX);
>  	do_el0_svc_compat(regs);
> -	exit_to_user_mode(regs);
> +	exit_to_user_mode_wrapper(regs);
>  }
>  
>  asmlinkage void noinstr el0t_32_sync_handler(struct pt_regs *regs)
> @@ -924,7 +701,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
>  	unsigned long esr = read_sysreg(esr_el1);
>  	unsigned long far = read_sysreg(far_el1);
>  
> -	arm64_enter_nmi(regs);
> +	irqentry_nmi_enter(regs);
>  	panic_bad_stack(regs, esr, far);
>  }
>  #endif /* CONFIG_VMAP_STACK */
> @@ -933,6 +710,7 @@ asmlinkage void noinstr __noreturn handle_bad_stack(struct pt_regs *regs)
>  asmlinkage noinstr unsigned long
>  __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  {
> +	irqentry_state_t state;
>  	unsigned long ret;
>  
>  	/*
> @@ -957,9 +735,9 @@ __sdei_handler(struct pt_regs *regs, struct sdei_registered_event *arg)
>  	else if (cpu_has_pan())
>  		set_pstate_pan(0);
>  
> -	arm64_enter_nmi(regs);
> +	state = irqentry_nmi_enter(regs);
>  	ret = do_sdei_event(regs, arg);
> -	arm64_exit_nmi(regs);
> +	irqentry_nmi_exit(regs, state);
>  
>  	return ret;
>  }
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 60fd85d5119d..9cc0f450fa76 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -41,9 +41,6 @@
>  #include <asm/traps.h>
>  #include <asm/system_misc.h>
>  
> -#define CREATE_TRACE_POINTS
> -#include <trace/events/syscalls.h>
> -
>  struct pt_regs_offset {
>  	const char *name;
>  	int offset;
> @@ -2179,104 +2176,6 @@ long arch_ptrace(struct task_struct *child, long request,
>  	return ptrace_request(child, request, addr, data);
>  }
>  
> -enum ptrace_syscall_dir {
> -	PTRACE_SYSCALL_ENTER = 0,
> -	PTRACE_SYSCALL_EXIT,
> -};
> -
> -static void report_syscall_enter(struct pt_regs *regs)
> -{
> -	int regno;
> -	unsigned long saved_reg;
> -
> -	/*
> -	 * We have some ABI weirdness here in the way that we handle syscall
> -	 * exit stops because we indicate whether or not the stop has been
> -	 * signalled from syscall entry or syscall exit by clobbering a general
> -	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> -	 * and restoring its old value after the stop. This means that:
> -	 *
> -	 * - Any writes by the tracer to this register during the stop are
> -	 *   ignored/discarded.
> -	 *
> -	 * - The actual value of the register is not available during the stop,
> -	 *   so the tracer cannot save it and restore it later.
> -	 *
> -	 * - Syscall stops behave differently to seccomp and pseudo-step traps
> -	 *   (the latter do not nobble any registers).
> -	 */
> -	regno = (is_compat_task() ? 12 : 7);
> -	saved_reg = regs->regs[regno];
> -	regs->regs[regno] = PTRACE_SYSCALL_ENTER;
> -
> -	if (ptrace_report_syscall_entry(regs))
> -		forget_syscall(regs);
> -	regs->regs[regno] = saved_reg;
> -}
> -
> -static void report_syscall_exit(struct pt_regs *regs)
> -{
> -	int regno;
> -	unsigned long saved_reg;
> -
> -	/* See comment for report_syscall_enter() */
> -	regno = (is_compat_task() ? 12 : 7);
> -	saved_reg = regs->regs[regno];
> -	regs->regs[regno] = PTRACE_SYSCALL_EXIT;
> -
> -	if (!test_thread_flag(TIF_SINGLESTEP)) {
> -		ptrace_report_syscall_exit(regs, 0);
> -		regs->regs[regno] = saved_reg;
> -	} else {
> -		regs->regs[regno] = saved_reg;
> -
> -		/*
> -		 * Signal a pseudo-step exception since we are stepping but
> -		 * tracer modifications to the registers may have rewound the
> -		 * state machine.
> -		 */
> -		ptrace_report_syscall_exit(regs, 1);
> -	}
> -}
> -
> -int syscall_trace_enter(struct pt_regs *regs)
> -{
> -	unsigned long flags = read_thread_flags();
> -
> -	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> -		report_syscall_enter(regs);
> -		if (flags & _TIF_SYSCALL_EMU)
> -			return NO_SYSCALL;
> -	}
> -
> -	/* Do the secure computing after ptrace; failures should be fast. */
> -	if (secure_computing() == -1)
> -		return NO_SYSCALL;
> -
> -	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> -		trace_sys_enter(regs, regs->syscallno);
> -
> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> -			    regs->regs[2], regs->regs[3]);
> -
> -	return regs->syscallno;
> -}
> -
> -void syscall_trace_exit(struct pt_regs *regs)
> -{
> -	unsigned long flags = read_thread_flags();
> -
> -	audit_syscall_exit(regs);
> -
> -	if (flags & _TIF_SYSCALL_TRACEPOINT)
> -		trace_sys_exit(regs, syscall_get_return_value(current, regs));
> -
> -	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
> -		report_syscall_exit(regs);
> -
> -	rseq_syscall(regs);
> -}
> -
>  /*
>   * SPSR_ELx bits which are always architecturally RES0 per ARM DDI 0487D.a.
>   * We permit userspace to set SSBS (AArch64 bit 12, AArch32 bit 23) which is
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 4a77f4976e11..2982f6db6d96 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -19,6 +19,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/rseq.h>
>  #include <linux/syscalls.h>
> +#include <linux/entry-common.h>
>  
>  #include <asm/daifflags.h>
>  #include <asm/debug-monitors.h>
> @@ -1266,7 +1267,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>   * the kernel can handle, and then we build all the user-level signal handling
>   * stack-frames in one go after that.
>   */
> -void do_signal(struct pt_regs *regs)
> +void arch_do_signal_or_restart(struct pt_regs *regs)
>  {
>  	unsigned long continue_addr = 0, restart_addr = 0;
>  	int retval = 0;
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index ad198262b981..160ac9d15c27 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -7,6 +7,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/randomize_kstack.h>
>  #include <linux/syscalls.h>
> +#include <linux/entry-common.h>
>  
>  #include <asm/debug-monitors.h>
>  #include <asm/exception.h>
> @@ -66,14 +67,15 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	choose_random_kstack_offset(get_random_u16() & 0x1FF);
>  }
>  
> -static inline bool has_syscall_work(unsigned long flags)
> +static inline bool has_syscall_work(unsigned long work)
>  {
> -	return unlikely(flags & _TIF_SYSCALL_WORK);
> +	return unlikely(work & SYSCALL_WORK_ENTER);
>  }
>  
>  static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  			   const syscall_fn_t syscall_table[])
>  {
> +	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  	unsigned long flags = read_thread_flags();
>  
>  	regs->orig_x0 = regs->regs[0];
> @@ -107,7 +109,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  		return;
>  	}
>  
> -	if (has_syscall_work(flags)) {
> +	if (has_syscall_work(work)) {
>  		/*
>  		 * The de-facto standard way to skip a system call using ptrace
>  		 * is to set the system call to -1 (NO_SYSCALL) and set x0 to a
> @@ -125,7 +127,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  		 */
>  		if (scno == NO_SYSCALL)
>  			syscall_set_return_value(current, regs, -ENOSYS, 0);
> -		scno = syscall_trace_enter(regs);
> +		scno = syscall_trace_enter(regs, regs->syscallno, work);
>  		if (scno == NO_SYSCALL)
>  			goto trace_exit;
>  	}
> @@ -137,14 +139,14 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	 * check again. However, if we were tracing entry, then we always trace
>  	 * exit regardless, as the old entry assembly did.
>  	 */
> -	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		flags = read_thread_flags();
> -		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
> +	if (!has_syscall_work(work) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> +		work = READ_ONCE(current_thread_info()->syscall_work);
> +		if (!has_syscall_work(work) && !report_single_step(work))
>  			return;
>  	}
>  
>  trace_exit:
> -	syscall_trace_exit(regs);
> +	syscall_exit_work(regs, work);
>  }
>  
>  void do_el0_svc(struct pt_regs *regs)

