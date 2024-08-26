Return-Path: <linux-kernel+bounces-301795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B924595F5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD43B21D53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF71940BE;
	Mon, 26 Aug 2024 15:56:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1849631
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687799; cv=none; b=Z8KZYd3yyDB07DXdKpoqpWNOOGI9suBlHBII6yEIiJ+fYRFasxQqRlMzSNoGQakLHm8mm59+36K4yCa1ZAa2Tc1O/N6n/ZRVmH8bpHVkQSeypJEQO2HoKlQ/euo3UtPBhXgb0rUdVV9oM7KsQh0Dc3ik4caw7/X1pXXAfa9KBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687799; c=relaxed/simple;
	bh=61tSOjhC76YDiau4uKfcYIgfgJAiKsHeRT+fpFfD2Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMSDITuy+HNqpSBIX+sLwvt0JHO0MVgn5LQxkzT/EU5lJi6HA675UJBedtaclhTr3lYrHXa5OzJY4sG8GvXKjbsGqGBlS79girrUKY+NUM71RRoRmCFNmWjVmjTrgUAGKFvrcpZ2mcEJ7d6RUoiDRKTqSqHnEOGyNvVu7BNuhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C3E111FB;
	Mon, 26 Aug 2024 08:57:03 -0700 (PDT)
Received: from [10.57.71.136] (unknown [10.57.71.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB4023F762;
	Mon, 26 Aug 2024 08:56:33 -0700 (PDT)
Message-ID: <a03d7530-2f47-41a6-b79b-cc7eac8ffd84@arm.com>
Date: Mon, 26 Aug 2024 17:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: entry: Convert to generic entry
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 tglx@linutronix.de, peterz@infradead.org, luto@kernel.org, kees@kernel.org,
 wad@chromium.org, rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
 broonie@kernel.org, mark.rutland@arm.com, rick.p.edgecombe@intel.com,
 leobras@redhat.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240629085601.470241-1-ruanjinjie@huawei.com>
 <20240629085601.470241-4-ruanjinjie@huawei.com>
 <4f79f56a-4019-46eb-91dc-f137b714acb7@arm.com>
 <f1883449-9bab-0896-6cc9-4340d2ca72aa@huawei.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <f1883449-9bab-0896-6cc9-4340d2ca72aa@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/08/2024 14:30, Jinjie Ruan wrote:
> On 2024/8/20 19:43, Kevin Brodsky wrote:
>> On 29/06/2024 10:56, Jinjie Ruan wrote:
>>> Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
>>> to use the generic entry infrastructure from kernel/entry/*. The generic
>>> entry makes maintainers' work easier and codes more elegant, which also
>>> removed duplicate 150+ LOC. The changes are below:
>>>
>>>  - Remove TIF_SYSCALL_* flag, _TIF_WORK_MASK, _TIF_SYSCALL_WORK
>>>
>>>  - Remove syscall_trace_enter/exit() and use generic one.
>>>
>>>  - Remove *enter_from/exit_to_kernel_mode(), and wrap with generic
>>>    irqentry_enter/exit().
>>>
>>>  - Remove *enter_from/exit_to_user_mode(), and wrap with generic
>>>    irqentry_enter_from/exit_to_user_mode().
>>>
>>>  - Remove arm64_enter/exit_nmi() and use generic irqentry_nmi_enter/exit().
>>>
>>>  - Remove PREEMPT_DYNAMIC code, as generic entry will do it ok by
>>>    implementing arch_irqentry_exit_need_resched().
>> This is looking good to me overall, moving to using the generic helpers
>> is a clear improvement. I've tried my best to check that the new
> Thank you very much for the review, It does make the code more clear.
>
>> implementation is functionally equivalent to the old. Ignoring additions
>> in the generic code (such as additional instrumentation_{begin,end}()
>> pairs or assertions), this seems to be the case, with one exception. The
>> MTE operations are done in a slightly different order on entry:
>>
>> * mte_disable_tco_entry() was called *after* the generic lockdep/CT
>> functions in __enter_from_user_mode(). It is now called before those
>> generic operations - arch_enter_from_user_mode() called at the beginning
>> of enter_from_user_mode().
> The most special for arm64 are these MTE operations, the comment for
> __enter_from_kernel_mode() and __enter_from_user_mode() said:
>
>    " Handle IRQ/context state management when entering from user/kernel
> mode. Before this function is called it is not safe to call regular
> kernel code "
>
> I guess it is the reason why mte_disable_tco_entry() was called *after*
> the generic lockdep/CT functions, but the first version of commit
> 38ddf7dafaeaf ("arm64: mte: avoid clearing PSTATE.TCO on entry unless
> necessary") call it in arch/arm64/kernel/entry.S, so I think the order
> is not so important.

Good point, before that commit TCO was disabled before any generic
exception code was run so changing the ordering of
mte_disable_tco_entry() is unlikely to be a problem (the current
implementation doesn't do anything complex).

>
>> * Similarly mte_disable_tco_entry() and mte_check_tfsr_entry() was
>> called after the generic operations in enter_from_kernel_mode(), and
>> they are now called after - arch_enter_from_kernel_mode() called at the
>> beginning of irqentry_enter().
> This can be adjusted to be consistent.

I wonder if moving mte_check_tfsr_entry() is as harmless as
mte_disable_tco_entry(), because the former can cause a stack dump. Is
that safe to do before the lockdep/RCU handling? I would guess so but
would be good for someone to confirm.

Kevin

