Return-Path: <linux-kernel+bounces-297264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5495B51E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C461C22F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C25B1C9DDA;
	Thu, 22 Aug 2024 12:36:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C21E4B0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330198; cv=none; b=gA2LXKVHRNSWo/g33uXqh60jIYe1rbCL+UFtgMoPNcLazEgCX86GrHNJ/cVU+H0hb9zHBgmpHBRcxhvnTZSyIxN4KAiIUYnBakxj7Lksjq4xDRZsV/8TNX0ijMhiVRRnA4VfioWPIFTnRmFbeUAhHVQsR4gEPG+ilDedE7PURhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330198; c=relaxed/simple;
	bh=hoCilJreoZt/eVXqgEJWRg8nUXnlnJBdWFxRC3HjQj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X51xEIeEBcjS5h3cWGBYTbn2PSIjU1SkSbJ66jQoIOSuBH4Aufto8OfKrxO4BXwo4wQ5rGMamPRjdvmgakLkYtKtV0UeLE0/hNBK0tSRBV7uIQ1CuegMihz5RH6pK5oai9jL5WxVZQkpTkdbF3mGILBSkE8idXLW4l5UsHrJpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqN0F4pbnz1HGvm;
	Thu, 22 Aug 2024 20:33:17 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id DE2B314013B;
	Thu, 22 Aug 2024 20:36:30 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 20:36:29 +0800
Message-ID: <39117062-fa67-2154-3f3f-55c7a1a6a265@huawei.com>
Date: Thu, 22 Aug 2024 20:36:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/3] entry: Add some arch funcs to support arm64 to use
 generic entry
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <rostedt@goodmis.org>,
	<arnd@arndb.de>, <ardb@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-2-ruanjinjie@huawei.com>
 <1ce09739-14a4-42a2-b5c9-66fdc72ae999@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <1ce09739-14a4-42a2-b5c9-66fdc72ae999@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/20 19:41, Kevin Brodsky wrote:
> On 29/06/2024 10:55, Jinjie Ruan wrote:
>> Add some arch functions to support arm64 to use generic entry, which do not
>> affect existing architectures that use generic entry:
>>
>>  - arch_prepare/post_report_syscall_entry/exit().
>>
>>  - arch_enter_from_kernel_mode(), arch_exit_to_kernel_mode_prepare().
>>
>>  - arch_irqentry_exit_need_resched() to support architecture-related
>>    need_resched() check logic.
>>
>> Also make syscall_exit_work() not static and move report_single_step() to
>> thread_info.h, which can be used by arm64 later.
>>
>> x86 and Riscv compilation test ok after this patch.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>> v3:
>> - Make the arch funcs not use __weak as Thomas suggested.
>> - Make arch_forget_syscall() folded in arch_post_report_syscall_entry().
>> - __always_inline -> inline.
>> - Move report_single_step() to thread_info.h for arm64
>> - Add Suggested-by.
>> - Update the commit message.
>>
>> v2:
>> - Fix a bug that not call arch_post_report_syscall_entry() in
>>   syscall_trace_enter() if ptrace_report_syscall_entry() return not zero.
>> - Update the commit message.
>> ---
>>  include/linux/entry-common.h | 90 ++++++++++++++++++++++++++++++++++++
>>  include/linux/thread_info.h  | 13 ++++++
>>  kernel/entry/common.c        | 37 +++++++--------
>>  3 files changed, 122 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index b0fb775a600d..2aea23ca9d66 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -290,6 +290,94 @@ static __always_inline void arch_exit_to_user_mode(void);
>>  static __always_inline void arch_exit_to_user_mode(void) { }
>>  #endif
>>  
>> +/**
>> + * arch_enter_from_kernel_mode - Architecture specific check work.
> 
> Maybe those comments could be expanded to be closer to the existing
> ones, like arch_enter_from_user_mode()? It would help if they were more
> specific as to where they are called (especially the *report_syscall*
> ones) and how they are expected to be used.

You are right! It needed to be expanded.

> 
>> + */
>> +static inline void arch_enter_from_kernel_mode(struct pt_regs *regs);
>> +
>> +#ifndef arch_enter_from_kernel_mode
>> +static inline void arch_enter_from_kernel_mode(struct pt_regs *regs) { }
>> +#endif
>> +
>> +/**
>> + * arch_exit_to_kernel_mode_prepare - Architecture specific final work before
>> + *				      exit to kernel mode.
>> + */
>> +static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs);
> 
> Any reason to suffix this function with "prepare"? Just
> arch_exit_to_kernel_mode() seems appropriate (symmetric with
> arch_enter_from_kernel_mode()).

prepare means it is the first function before all other exit_to_kernel
operation in irqentry_exit(), but as the order problem, it can be
adjusted to the last to aligh with the older arm64 version.

> 
>> +
>> +#ifndef arch_exit_to_kernel_mode_prepare
>> +static inline void arch_exit_to_kernel_mode_prepare(struct pt_regs *regs) { }
>> +#endif
>> +
>> +/**
>> + * arch_prepare_report_syscall_entry - Architecture specific work before
>> + *			               report_syscall_entry().
>> + */
>> +static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs);
> 
> The most common naming patterns for such arch helper pairs seems to be
> pre/post, so maybe arch_pre_report_syscall_entry()?

Right!

> 
>> +
>> +#ifndef arch_prepare_report_syscall_entry
>> +static inline unsigned long arch_prepare_report_syscall_entry(struct pt_regs *regs)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>> +/**
>> + * arch_post_report_syscall_entry - Architecture specific work after
>> + *			            report_syscall_entry().
>> + */
>> +static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
>> +						  unsigned long saved_reg,
>> +						  long ret);
>> +
>> +#ifndef arch_post_report_syscall_entry
>> +static inline void arch_post_report_syscall_entry(struct pt_regs *regs,
>> +						  unsigned long saved_reg,
>> +						  long ret)
>> +{
>> +}
>> +#endif
>> +
>> +/**
>> + * arch_prepare_report_syscall_exit - Architecture specific work before
>> + *			              report_syscall_exit().
>> + */
>> +static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
>> +							     unsigned long work);
>> +
>> +#ifndef arch_prepare_report_syscall_exit
>> +static inline unsigned long arch_prepare_report_syscall_exit(struct pt_regs *regs,
>> +							     unsigned long work)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>> +/**
>> + * arch_post_report_syscall_exit - Architecture specific work after
>> + *			           report_syscall_exit().
>> + */
>> +static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
>> +						 unsigned long saved_reg,
>> +						 unsigned long work);
>> +
>> +#ifndef arch_post_report_syscall_exit
>> +static inline void arch_post_report_syscall_exit(struct pt_regs *regs,
>> +						 unsigned long saved_reg,
>> +						 unsigned long work)
>> +{
>> +}
>> +#endif
>> +
>> +/**
>> + * arch_irqentry_exit_need_resched - Architecture specific need resched function
>> + */
>> +static inline bool arch_irqentry_exit_need_resched(void);
>> +
>> +#ifndef arch_irqentry_exit_need_resched
>> +static inline bool arch_irqentry_exit_need_resched(void) { return true; }
>> +#endif
> 
> Nit: the existing arch_* hooks seem to be declared close to the function
> they are called from (e.g. arch_enter_from_user_mode() just before
> enter_from_user_mode()), maybe we could do the same with those new
> hooks, where possible.

Yes, do the same with those new hooks will be nice.

> 
>> +
>>  /**
>>   * arch_do_signal_or_restart -  Architecture specific signal delivery function
>>   * @regs:	Pointer to currents pt_regs
>> @@ -552,4 +640,6 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>>   */
>>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
>>  
>> +void syscall_exit_work(struct pt_regs *regs, unsigned long work);
>> +
>>  #endif
>> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
>> index 9ea0b28068f4..062de9666ef3 100644
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -55,6 +55,19 @@ enum syscall_work_bit {
>>  #define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
>>  #define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
>>  #define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
>> +
>> +/*
>> + * If SYSCALL_EMU is set, then the only reason to report is when
>> + * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
>> + * instruction has been already reported in syscall_enter_from_user_mode().
>> + */
>> +static inline bool report_single_step(unsigned long work)
>> +{
>> +	if (work & SYSCALL_WORK_SYSCALL_EMU)
>> +		return false;
>> +
>> +	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
>> +}
>>  #endif
>>  
>>  #include <asm/thread_info.h>
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index 90843cc38588..cd76391ffcb9 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -28,6 +28,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
>>  long syscall_trace_enter(struct pt_regs *regs, long syscall,
>>  				unsigned long work)
>>  {
>> +	unsigned long saved_reg;
> 
> Nit: could be declared inside the if block.

Right!

> 
> Kevin
> 
>>  	long ret = 0;
>>  
>>  	/*
>> @@ -42,8 +43,10 @@ long syscall_trace_enter(struct pt_regs *regs, long syscall,
>>  
>>  	/* Handle ptrace */
>>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
>> +		saved_reg = arch_prepare_report_syscall_entry(regs);
>>  		ret = ptrace_report_syscall_entry(regs);
>> -		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
>> +		arch_post_report_syscall_entry(regs, saved_reg, ret);
>> +		if (ret || work & SYSCALL_WORK_SYSCALL_EMU)
>>  			return -1L;
>>  	}
>>  
>> [...]
> 

