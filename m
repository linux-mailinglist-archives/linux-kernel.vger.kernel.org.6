Return-Path: <linux-kernel+bounces-389924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E42469B7316
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42E7286F86
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8913AA41;
	Thu, 31 Oct 2024 03:35:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FE13B280
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730345737; cv=none; b=VzE6GtVd1Gm8HUiaRj86n2a9qWPZ0ym3CVO+pOSYCHcviIF7gA9ximOS4xRUhgw+3wmIb18qx1tZRiOahAeyX4VlVBZkU2aowf6lp/Be7JPksn6/BZU3cMnA5oOUzkli+n9rvdHhyu7GUsYLK9wce7m7Cs8KNJfCgsvxRR7Ahes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730345737; c=relaxed/simple;
	bh=TL1HKRvMEBRYPAfY7vtJNmyeuZ5aFJd+US2uw0impWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Rl5uCqtGCf80Uk8lYGpcoxdxeLxslCU2nQuRTQeU+tuwIUXqrCLUhCJJ3xtdH7KzE3Gb6AUX59y5zGb2OqcDW9Jz5EevX2SzVQZDnCuPzHK/UPKbXWqjTBjmCLXqOMucZ/4UVimcjSRerONlwJ6MbThIEOsvY/EMth4ZY+C2C9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xf8kG6rGLz20qff;
	Thu, 31 Oct 2024 11:34:30 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C6891401F3;
	Thu, 31 Oct 2024 11:35:31 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 11:35:28 +0800
Message-ID: <69389d62-a520-fb1a-2c73-fecc9bc8a71f@huawei.com>
Date: Thu, 31 Oct 2024 11:35:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v4 02/19] arm64: entry: Refactor the entry and exit
 for exceptions from EL1
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
 <20241025100700.3714552-3-ruanjinjie@huawei.com>
 <ZyDyS4TT6xgRIN1w@J2N7QTR9R3.cambridge.arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZyDyS4TT6xgRIN1w@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 22:33, Mark Rutland wrote:
> On Fri, Oct 25, 2024 at 06:06:43PM +0800, Jinjie Ruan wrote:
>> These changes refactor the entry and exit routines for the exceptions
>> from EL1. They store the RCU and lockdep state in a struct
>> irqentry_state variable on the stack, rather than recording them
>> in the fields of pt_regs, since it is safe enough for these context.
> 
> In general, please descirbe *why* we want to make the change first, e.g.
> 
> | The generic entry code uses irqentry_state_t to track lockdep and RCU
> | state across exception entry and return. For historical reasons, arm64
> | embeds similar fields within its pt_regs structure.
> |
> | In preparation for moving arm64 over to the generic entry code, pull
> | these fields out of arm64's pt_regs, and use a seperate structure,
> | matching the style of the generic entry code.
> 
>> Before:
>> 	struct pt_regs {
>> 		...
>> 		u64 lockdep_hardirqs;
>> 		u64 exit_rcu;
>> 	}
>>
>> 	enter_from_kernel_mode(regs);
>> 	...
>> 	exit_to_kernel_mode(regs);
>>
>> After:
>> 	typedef struct irqentry_state {
>> 		union {
>> 			bool    exit_rcu;
>> 			bool    lockdep;
>> 		};
>> 	} irqentry_state_t;
>>
>> 	irqentry_state_t state = enter_from_kernel_mode(regs);
>> 	...
>> 	exit_to_kernel_mode(regs, state);
> 
> I don't think this part is necessary.

Thank you, will remove it and explain why.

> 
>>
>> No functional changes.
>>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/include/asm/ptrace.h  |  11 ++-
>>  arch/arm64/kernel/entry-common.c | 129 +++++++++++++++++++------------
>>  2 files changed, 85 insertions(+), 55 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
>> index 3e5372a98da4..5156c0d5fa20 100644
>> --- a/arch/arm64/include/asm/ptrace.h
>> +++ b/arch/arm64/include/asm/ptrace.h
>> @@ -149,6 +149,13 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
>>  	return psr;
>>  }
>>  
>> +typedef struct irqentry_state {
>> +	union {
>> +		bool	exit_rcu;
>> +		bool	lockdep;
>> +	};
>> +} irqentry_state_t;
> 
> AFAICT this can be moved directly into arch/arm64/kernel/entry-common.c.
> 
>> +
>>  /*
>>   * This struct defines the way the registers are stored on the stack during an
>>   * exception. struct user_pt_regs must form a prefix of struct pt_regs.
>> @@ -169,10 +176,6 @@ struct pt_regs {
>>  
>>  	u64 sdei_ttbr1;
>>  	struct frame_record_meta stackframe;
>> -
>> -	/* Only valid for some EL1 exceptions. */
>> -	u64 lockdep_hardirqs;
>> -	u64 exit_rcu;
>>  };
>>  
>>  /* For correct stack alignment, pt_regs has to be a multiple of 16 bytes. */
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index c547e70428d3..68a9aecacdb9 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -36,29 +36,36 @@
>>   * This is intended to match the logic in irqentry_enter(), handling the kernel
>>   * mode transitions only.
>>   */
>> -static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
>> +static __always_inline irqentry_state_t __enter_from_kernel_mode(struct pt_regs *regs)
>>  {
>> -	regs->exit_rcu = false;
>> +	irqentry_state_t ret = {
>> +		.exit_rcu = false,
>> +	};
> 
> I realise that the generic entry code calls this 'ret' in
> irqentry_enter() and similar, but could we please use 'state'
> consistently in the arm64 code?
> 
> [...]
> 
>>  /*
>> @@ -190,9 +199,11 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct pt_regs *regs)
>>   * mode. Before this function is called it is not safe to call regular kernel
>>   * code, instrumentable code, or any code which may trigger an exception.
>>   */
>> -static void noinstr arm64_enter_nmi(struct pt_regs *regs)
>> +static noinstr irqentry_state_t arm64_enter_nmi(struct pt_regs *regs)
>>  {
>> -	regs->lockdep_hardirqs = lockdep_hardirqs_enabled();
>> +	irqentry_state_t irq_state;
> 
> Likewise, please use 'state' rather than 'irq_state'.
> 
> In future we should probably have a separate structure for the NMI
> paths, and get rid of the union, which would avoid the possiblity of
> using mismatched helpers.
> 
> Mark.
> 
> 

