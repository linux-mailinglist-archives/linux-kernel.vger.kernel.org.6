Return-Path: <linux-kernel+bounces-376231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3139AA1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1BB283160
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC019E7EB;
	Tue, 22 Oct 2024 12:08:02 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD27199938
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598881; cv=none; b=ETDgAGh//ne6c44ZynwIqBQ8uN6svzdCyh9BYgzuWtBsqabTI9r5j7NV+TeAGuxRsoRlb90SnaZDrCc8+m2lT99UR3T6j5SMTdPVcINoA6zVgzK8auF7GsgEDYIStBSHjoy3g2kd6ZnzpMhl/o2LNhoYi+WLInI2t1cOhmyCWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598881; c=relaxed/simple;
	bh=su60vmc+u8hJulSAsiny0wMAAlibdpwxrlWj7/iF8s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mt7cg3ElLEFX3JK1huBAUt8H6GivqevAtOpVjB0U1+P34G8167k38Ie7+FvlMbxSynaaReyIiAn5TX9q7Vg7mxHr6neYhBl/+P8/FGfrd1XaHdBS/S81s5R09oqDcGQ7mBCIHL8prAqG8FEHvUfaolH9olPU2IjuZOmgihSqIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XXrXz01YXz1ynKk;
	Tue, 22 Oct 2024 20:08:02 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id DDC1014037D;
	Tue, 22 Oct 2024 20:07:55 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 20:07:55 +0800
Message-ID: <2cc049fe-8f1a-0829-d879-d89278027be6@huawei.com>
Date: Tue, 22 Oct 2024 20:07:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 0/3] arm64: entry: Convert to generic entry
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <rostedt@goodmis.org>,
	<arnd@arndb.de>, <ardb@kernel.org>, <broonie@kernel.org>,
	<rick.p.edgecombe@intel.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZxEsZBvsirXJz2dT@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/17 23:25, Mark Rutland wrote:
> Hi,
> 
> On Sat, Jun 29, 2024 at 04:55:58PM +0800, Jinjie Ruan wrote:
>> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
>> to use the generic entry infrastructure from kernel/entry/*. The generic
>> entry makes maintainers' work easier and codes more elegant, which aslo
>> removed a lot of duplicate code.
> 
>>  arch/arm64/Kconfig                    |   1 +
>>  arch/arm64/include/asm/entry-common.h | 172 ++++++++++++
>>  arch/arm64/include/asm/ptrace.h       |   5 +
>>  arch/arm64/include/asm/stacktrace.h   |   5 +-
>>  arch/arm64/include/asm/syscall.h      |   6 +-
>>  arch/arm64/include/asm/thread_info.h  |  23 +-
>>  arch/arm64/kernel/entry-common.c      | 368 +++++---------------------
>>  arch/arm64/kernel/ptrace.c            |  90 -------
>>  arch/arm64/kernel/signal.c            |   3 +-
>>  arch/arm64/kernel/syscall.c           |  18 +-
>>  include/linux/entry-common.h          |  90 +++++++
>>  include/linux/thread_info.h           |  13 +
>>  kernel/entry/common.c                 |  37 +--
>>  13 files changed, 395 insertions(+), 436 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/entry-common.h
> 
> Looking at this I have a few concerns, which I've tried to explain
> below.
> 
> Firstly, this is difficult to review (and will be difficult to test,
> queue. and debug in future) because lots of independent changes are made
> all at once. I think that needs to be split out more.
> 
> It would be good if preparatory rework/cleanup could be split into a few
> patches that we could consider queueing before the rest of the series,
> or even if we decide to not pick the rest of the series. For example,
> patch 2 should be split into:
> 
> * One patch that replaces arm64's interrupts_enabled() with
>   regs_irqs_disabled(), removing interrupts_enabled() entirely rather
>   than implementing regs_irqs_disabled() using interrupts_enabled().
> 
>   That'll require updating existing users, but the end result will be
>   more consistent and have fewer lines of code.
> 
> * One patch that changes on_thread_stack() from a macro to a function.
>   The commit message for patch 2 currently says:
> 
>   >  Make on_thread_stack() compatible with generic entry.   
>  
>   ... but it's not clear to me *what* that incompatibility is, and that
>   should be explained in the commit message.
> 
> * One patch that splits report_syscall() into report_syscall_enter() and
>   report_syscall_exit(). This should have no functional change.
> 
> Patch 3 in particular is very hard to follow because several unrelated
> complex systems are updated simultaneously. It would be really nice if
> we could move to the generic sycall code separately from moving the rest
> of the entry code, as the sycall handling code is a particularly
> important ABI concern, and it's difficult to see whether we're making
> ABI changes (accidentaly or knowingly).
> 
> Can we split that up (e.g. splitting the generic code first into
> separate entry and syscall files), or are those too tightly coupled for
> that to be possible?
> 
> At the end of the series, pt_regs::{lockdep_hardirqs,exit_rcu} still
> exist, though they're unused. It would be nicer if we could get rid of
> those in a preparatory patch, e.g. have enter_from_kernel_mode() and
> exit_to_kernel_mode() use an irqentry_state_t (or a temporary
> arm64-specific version). That would make the subsequent changes clearer
> since we'd already have the same structure.
> 
> In the end result, there's a lot of bouncing between noinstr functions
> where things are inlined today. For example, el0_da() calls
> irqentry_enter_from_user_mode(), which is an out-of-line noinstr wrapper
> for enter_from_user_mode(), which is an __always_inline function in a
> header. It would be nice to avoid unnecessary bouncing through
> out-of-line functions. I see s390 and x86 use enter_from_user_mode()
> directly.
> 
> There's also some indirection that I don't think is necessary *and*
> hides important ordering concerns and results in mistakes. In
> particular, note that before this series, enter_from_kernel_mode() calls
> the (instrumentable) MTE checks *after* all the necessary lockdep+RCU
> management is performed by __enter_from_kernel_mode():
> 
> 	static void noinstr enter_from_kernel_mode(struct pt_regs *regs)
> 	{
> 	        __enter_from_kernel_mode(regs);
> 		mte_check_tfsr_entry();
> 		mte_disable_tco_entry(current);
> 	}
> 
> ... whereas after this series is applied, those MTE checks are placed in
> arch_enter_from_kernel_mode(), which irqentry_enter() calls *before* the
> necessary lockdep+RCU management. That is broken.
> 
> It would be better to keep that explicit in the arm64 entry code with
> arm64-specific wrappers, e.g.
> 
> 	static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
> 	{
> 		irqentry_state_t state = irqentry_enter(regs);
> 		mte_check_tfsr_entry();
> 		mte_disable_tco_entry(current);
> 
> 		return state;
> 	}

Hi, Mark, It seems that there is a problem for
arm64_preempt_schedule_irq() when wrap irqentry_exit() with
exit_to_kernel_mode().

The arm64_preempt_schedule_irq() is about PREEMPT_DYNAMIC and preempt
irq which is the raw_irqentry_exit_cond_resched() in generic code called
by irqentry_exit().

Only __el1_irq() call arm64_preempt_schedule_irq(), but when we switch
all exit_to_kernel_mode() to arm64-specific one that wrap
irqentry_exit(), not only __el1_irq() but also el1_abort(), el1_pc(),
el1_undef() etc. will try to reschedule by calling
arm64_preempt_schedule_irq() similar logic.



> 
> ... which would avoid the need for arch_enter_from_kernel_mode(), make
> that ordering obvious, and would remove the need to modify all the
> callers.
> 
> Likewise for the user entry/exit paths, which would avoid the visual
> imbalance of:
> 	
> 	irqentry_enter_from_user_mode();
> 	...
> 	exit_to_user_mode_wrapper()
> 
> Thanks,
> Mark.
> 

