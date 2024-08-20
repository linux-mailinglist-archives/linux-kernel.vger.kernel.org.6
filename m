Return-Path: <linux-kernel+bounces-293873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 977D4958606
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1A1F2414C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7BA18E763;
	Tue, 20 Aug 2024 11:43:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129418E75D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154207; cv=none; b=gfBhglDfAMm07fuXl58wj1fwF2SlaGRwIntbSGheIEQdSpAiErFPbvZ/Zq4J0VHCJSWwd2xzA/u999CLaZVW8Sl/S2LEfrkipEqLTvKhgHRBOXVMNMpNlaWYNYsxFkyPBbWY3jFlMOie6tBh5UqQIQRf2r0i/2FMO2Nyp/4zfUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154207; c=relaxed/simple;
	bh=Wx6lujBeU5n79gjWz5jBOsse0M8jvbCXNxYkK/lvoTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=G7vrrqNAvTBbUTvhDXDToPhrNBgeMJxwHFR//OtKIieOH6UTi9cmtMYjKau9RtbaAs3puqy3eKIFCnf7L7cMfsnHtq9TeVWPNAdewNWyaHB/Yv1Qu5/rz7m0OSD/OjgJ3r5/LERkEShrF4r0RkaNdArXMU3S6c9npLEUg9+VkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 797EA1007;
	Tue, 20 Aug 2024 04:43:51 -0700 (PDT)
Received: from [10.57.70.240] (unknown [10.57.70.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B98A63F73B;
	Tue, 20 Aug 2024 04:43:16 -0700 (PDT)
Message-ID: <4f79f56a-4019-46eb-91dc-f137b714acb7@arm.com>
Date: Tue, 20 Aug 2024 13:43:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: entry: Convert to generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-4-ruanjinjie@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org, kees@kernel.org,
 wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
 broonie@kernel.org, mark.rutland@arm.com, rick.p.edgecombe@intel.com,
 leobras@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240629085601.470241-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/06/2024 10:56, Jinjie Ruan wrote:
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

This is looking good to me overall, moving to using the generic helpers
is a clear improvement. I've tried my best to check that the new
implementation is functionally equivalent to the old. Ignoring additions
in the generic code (such as additional instrumentation_{begin,end}()
pairs or assertions), this seems to be the case, with one exception. The
MTE operations are done in a slightly different order on entry:

* mte_disable_tco_entry() was called *after* the generic lockdep/CT
functions in __enter_from_user_mode(). It is now called before those
generic operations - arch_enter_from_user_mode() called at the beginning
of enter_from_user_mode().

* Similarly mte_disable_tco_entry() and mte_check_tfsr_entry() was
called after the generic operations in enter_from_kernel_mode(), and
they are now called after - arch_enter_from_kernel_mode() called at the
beginning of irqentry_enter().

I am not under the impression that these ordering changes are
problematic, but I may be missing something.

> [...]
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

exit_rcu in struct pt_regs is unused now that these functions are gone
so it can be removed.

> [...]
>  
> @@ -259,48 +74,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)

arm64_{enter,exit}_el1_dbg() have apparently no generic counterparts we
can replace them with, but maybe we could align them with the generic
functions some more? Specifically, I'm thinking about making them
return/take an irqentry_state_t just like irqentry_nmi_{enter,exit}().
This way we can get rid of struct pt_regs::lockdep_hardirqs, which is
now only used by those functions.

>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -#ifdef CONFIG_PREEMPT_DYNAMIC
> -DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);

The key is declared in asm/preempt.h, that declaration should also be
removed.

Kevin

> [...]


