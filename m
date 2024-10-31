Return-Path: <linux-kernel+bounces-389938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF99B7362
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BD1C242E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702D12B176;
	Thu, 31 Oct 2024 04:02:19 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCC15D1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730347339; cv=none; b=DxF00CorFgthHj3oH62HFoBQlOdZQ3tBx+PDBcoAMHSoo+Et9SW9wO3PrJLd2treRG/XkPfPDjHOlXGC4Q6q1XiHLQEgfuqZ+W1kS9IhRQ/PF8eCIdPDICad7Q3xElLc9vkJ+/cf/9QyWIsT6MeEuUiJGGjiW2H6kTgrxctZYHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730347339; c=relaxed/simple;
	bh=cv6r/ncHcZWQNxdWz9BtpPKvKHrMu/f198GmU/OCunU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llezkqoT1A2iSe5KBwntAW4J0OctlgtIP/i7Mam83lGckgcxZ6Pt0pFfnxQ//xs6k16dE4k7TDss6Y3DzcTVErnbb3qAuzEWiuIQlb88GkbD2v0Ta2M06eU04ZWjCe7i+kj8cnDOhuj3jLlWhfuPySZKGZbcfHN7ngI79cX/W6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xf9Dy16cqz1HLs6;
	Thu, 31 Oct 2024 11:57:38 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EF5E1A016C;
	Thu, 31 Oct 2024 12:02:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 12:02:05 +0800
Message-ID: <dac18e2f-b40d-d02b-dad4-a849a6e6a764@huawei.com>
Date: Thu, 31 Oct 2024 12:02:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v4 06/19] arm64: entry: Move
 arm64_preempt_schedule_irq() into exit_to_kernel_mode()
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <oleg@redhat.com>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <sstabellini@kernel.org>, <maz@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <akpm@linux-foundation.org>,
	<samitolvanen@google.com>, <arnd@arndb.de>, <ojeda@kernel.org>,
	<rppt@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<samuel.holland@sifive.com>, <paulmck@kernel.org>, <aquini@redhat.com>,
	<petr.pavlu@suse.com>, <viro@zeniv.linux.org.uk>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<wangkefeng.wang@huawei.com>, <surenb@google.com>,
	<linus.walleij@linaro.org>, <yangyj.ee@gmail.com>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <pcc@google.com>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<Jonathan.Cameron@huawei.com>, <prarit@redhat.com>, <liuwei09@cestc.cn>,
	<dwmw@amazon.co.uk>, <oliver.upton@linux.dev>, <kristina.martsenko@arm.com>,
	<ptosi@google.com>, <frederic@kernel.org>, <vschneid@redhat.com>,
	<thiago.bauermann@linaro.org>, <joey.gouly@arm.com>,
	<liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-7-ruanjinjie@huawei.com>
 <ZyD2pk285YeVmZTm@J2N7QTR9R3.cambridge.arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZyD2pk285YeVmZTm@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 22:52, Mark Rutland wrote:
> On Fri, Oct 25, 2024 at 06:06:47PM +0800, Jinjie Ruan wrote:
>> Move arm64_preempt_schedule_irq() into exit_to_kernel_mode(), so not
>> only __el1_irq() but also every time when kernel mode irq return,
>> there is a chance to reschedule.
> 
> We use exit_to_kernel_mode() for every non-NMI exception return to the
> kernel, not just IRQ returns.

Yes, it it not only irq but other non-NMI exception, will update it.

> 
>> As Mark pointed out, this change will have the following key impact:
>>
>>     "We'll preempt even without taking a "real" interrupt. That
>>     shouldn't result in preemption that wasn't possible before,
>>     but it does change the probability of preempting at certain points,
>>     and might have a performance impact, so probably warrants a
>>     benchmark."
> 
> For anyone following along at home, I said that at:
> 
>   https://lore.kernel.org/linux-arm-kernel/ZxejvAmccYMTa4P1@J2N7QTR9R3/
> 
> ... and there I specifically said:

Thank you!

This one and the next patch will be merged as you suggested.

I would have thought it would have been clearer to put it in
__exit_to_kernel_mode() and move it to interrupt enabled block in two steps.

> 
>> I's suggest you first write a patch to align arm64's entry code with the
>> generic code, by removing the call to arm64_preempt_schedule_irq() from
>> __el1_irq(), and adding a call to arm64_preempt_schedule_irq() in
>> __exit_to_kernel_mode(), e.g.
>>
>> | static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
>> | {
>> | 	...
>> | 	if (interrupts_enabled(regs)) {
>> | 		...
>> | 		if (regs->exit_rcu) {
>> | 			...
>> | 		}
>> | 		...
>> | 		arm64_preempt_schedule_irq();
>> | 		...
>> | 	} else {
>> | 		...
>> | 	}
>> | }
> 
> [...]
> 
>> +#ifdef CONFIG_PREEMPT_DYNAMIC
>> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>> +#define need_irq_preemption() \
>> +	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
>> +#else
>> +#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
>> +#endif
>> +
>> +static void __sched arm64_preempt_schedule_irq(void)
>> +{
>> +	if (!need_irq_preemption())
>> +		return;
>> +
>> +	/*
>> +	 * Note: thread_info::preempt_count includes both thread_info::count
>> +	 * and thread_info::need_resched, and is not equivalent to
>> +	 * preempt_count().
>> +	 */
>> +	if (READ_ONCE(current_thread_info()->preempt_count) != 0)
>> +		return;
>> +
>> +	/*
>> +	 * DAIF.DA are cleared at the start of IRQ/FIQ handling, and when GIC
>> +	 * priority masking is used the GIC irqchip driver will clear DAIF.IF
>> +	 * using gic_arch_enable_irqs() for normal IRQs. If anything is set in
>> +	 * DAIF we must have handled an NMI, so skip preemption.
>> +	 */
>> +	if (system_uses_irq_prio_masking() && read_sysreg(daif))
>> +		return;
>> +
>> +	/*
>> +	 * Preempting a task from an IRQ means we leave copies of PSTATE
>> +	 * on the stack. cpufeature's enable calls may modify PSTATE, but
>> +	 * resuming one of these preempted tasks would undo those changes.
>> +	 *
>> +	 * Only allow a task to be preempted once cpufeatures have been
>> +	 * enabled.
>> +	 */
>> +	if (system_capabilities_finalized())
>> +		preempt_schedule_irq();
>> +}
>> +
>>  /*
>>   * Handle IRQ/context state management when exiting to kernel mode.
>>   * After this function returns it is not safe to call regular kernel code,
>> @@ -72,6 +114,8 @@ static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
>>  static void noinstr exit_to_kernel_mode(struct pt_regs *regs,
>>  					irqentry_state_t state)
>>  {
>> +	arm64_preempt_schedule_irq();
> 
> This is broken; exit_to_kernel_mode() is called for any non-NMI return
> excpetion return to the kernel, and this doesn't check that interrupts
> were enabled in the context the exception was taken from.
> 
> This will preempt in cases where we should not, e.g. if we WARN() in a section with
> IRQs disabled.
> 
> Mark.
> 

