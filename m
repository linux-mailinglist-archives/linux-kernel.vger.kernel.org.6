Return-Path: <linux-kernel+bounces-297257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C932395B504
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80604288F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF671E517;
	Thu, 22 Aug 2024 12:30:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D31DFD1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329857; cv=none; b=f+hvayupOQH011+ZIs5oPlbafzGUvTJc16CM/nwhScAHfwpP+fJhJSL9d2TiYI2sknNux7Zmuk1ldBjNuladMK00gFS4dn45ytnzwzfdL0iR8mhzQe6w8CB/QbdbJsXEAeaPGkChsGvH9Ghrr98psdxxob03VU7P8MRQg073BTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329857; c=relaxed/simple;
	bh=3O9Lw9isNkkWUpVIFaMK13XyCuMgxxw42KjQ6Sl5FjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJJKpXqKDm9m54dFov3vb35v8XdJsBW6s7aonzBSULmit/pLax9bn/55miHU1cQerV/OE+ikrbshtDIEAKCv6NEDD1JKIC+3NTLCgNuXHHxRnzpXQ4bZ7Byo0MJxZdKs5L4Wi2vCiKlou2D6ZTpvePhgftAdlQuMKyVLvEQDmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqMv62mDlzhY9B;
	Thu, 22 Aug 2024 20:28:50 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6849C18009B;
	Thu, 22 Aug 2024 20:30:51 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 20:30:50 +0800
Message-ID: <f1883449-9bab-0896-6cc9-4340d2ca72aa@huawei.com>
Date: Thu, 22 Aug 2024 20:30:49 +0800
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
To: Kevin Brodsky <kevin.brodsky@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <rostedt@goodmis.org>,
	<arnd@arndb.de>, <ardb@kernel.org>, <broonie@kernel.org>,
	<mark.rutland@arm.com>, <rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-4-ruanjinjie@huawei.com>
 <4f79f56a-4019-46eb-91dc-f137b714acb7@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <4f79f56a-4019-46eb-91dc-f137b714acb7@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/20 19:43, Kevin Brodsky wrote:
> On 29/06/2024 10:56, Jinjie Ruan wrote:
>> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
>> to use the generic entry infrastructure from kernel/entry/*. The generic
>> entry makes maintainers' work easier and codes more elegant, which also
>> removed duplicate 150+ LOC. The changes are below:
>>
>>  - Remove TIF_SYSCALL_* flag, _TIF_WORK_MASK, _TIF_SYSCALL_WORK
>>
>>  - Remove syscall_trace_enter/exit() and use generic one.
>>
>>  - Remove *enter_from/exit_to_kernel_mode(), and wrap with generic
>>    irqentry_enter/exit().
>>
>>  - Remove *enter_from/exit_to_user_mode(), and wrap with generic
>>    irqentry_enter_from/exit_to_user_mode().
>>
>>  - Remove arm64_enter/exit_nmi() and use generic irqentry_nmi_enter/exit().
>>
>>  - Remove PREEMPT_DYNAMIC code, as generic entry will do it ok by
>>    implementing arch_irqentry_exit_need_resched().
> 
> This is looking good to me overall, moving to using the generic helpers
> is a clear improvement. I've tried my best to check that the new

Thank you very much for the review, It does make the code more clear.

> implementation is functionally equivalent to the old. Ignoring additions
> in the generic code (such as additional instrumentation_{begin,end}()
> pairs or assertions), this seems to be the case, with one exception. The
> MTE operations are done in a slightly different order on entry:
> 
> * mte_disable_tco_entry() was called *after* the generic lockdep/CT
> functions in __enter_from_user_mode(). It is now called before those
> generic operations - arch_enter_from_user_mode() called at the beginning
> of enter_from_user_mode().

The most special for arm64 are these MTE operations, the comment for
__enter_from_kernel_mode() and __enter_from_user_mode() said:

   " Handle IRQ/context state management when entering from user/kernel
mode. Before this function is called it is not safe to call regular
kernel code "

I guess it is the reason why mte_disable_tco_entry() was called *after*
the generic lockdep/CT functions, but the first version of commit
38ddf7dafaeaf ("arm64: mte: avoid clearing PSTATE.TCO on entry unless
necessary") call it in arch/arm64/kernel/entry.S, so I think the order
is not so important.

> 
> * Similarly mte_disable_tco_entry() and mte_check_tfsr_entry() was
> called after the generic operations in enter_from_kernel_mode(), and
> they are now called after - arch_enter_from_kernel_mode() called at the
> beginning of irqentry_enter().

This can be adjusted to be consistent.

> 
> I am not under the impression that these ordering changes are
> problematic, but I may be missing something.>
>> [...]
>>  
>> -/*
>> - * Handle IRQ/context state management when entering from kernel mode.
>> - * Before this function is called it is not safe to call regular kernel code,
>> - * instrumentable code, or any code which may trigger an exception.
>> - *
>> - * This is intended to match the logic in irqentry_enter(), handling the kernel
>> - * mode transitions only.
>> - */
>> -static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
>> -{
>> -	regs->exit_rcu = false;
> 
> exit_rcu in struct pt_regs is unused now that these functions are gone
> so it can be removed.

It is also consistent with ARM64.

> 
>> [...]
>>  
>> @@ -259,48 +74,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
> 
> arm64_{enter,exit}_el1_dbg() have apparently no generic counterparts we
> can replace them with, but maybe we could align them with the generic
> functions some more? Specifically, I'm thinking about making them
> return/take an irqentry_state_t just like irqentry_nmi_{enter,exit}().
> This way we can get rid of struct pt_regs::lockdep_hardirqs, which is
> now only used by those functions.
> 
>>  		lockdep_hardirqs_on(CALLER_ADDR0);
>>  }
>>  
>> -#ifdef CONFIG_PREEMPT_DYNAMIC
>> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> 
> The key is declared in asm/preempt.h, that declaration should also be
> removed.

Yes, you are right! commit 1b2d3451ee50 ("arm64: Support
PREEMPT_DYNAMIC") mentioned it:

    "Since arm64 does not yet use the generic entry code, we must define
our own `sk_dynamic_irqentry_exit_cond_resched`, which will be
enabled/disabled by the common code in kernel/sched/core.c. All other
preemption functions and associated static keys are defined there."

So if arm64 switched to generic entry, the code can be removed.

> 
> Kevin
> 
>> [...]
> 
> 

