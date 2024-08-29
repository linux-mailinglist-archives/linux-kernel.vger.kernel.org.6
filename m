Return-Path: <linux-kernel+bounces-306075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC6C9638CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5C1F24331
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CD46B91;
	Thu, 29 Aug 2024 03:29:57 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9834CE5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902196; cv=none; b=qG2fvZQ3eFWIsWU6yvbbGWehQWgqtRiWNz3rJYHhrQALT0TOcRdnoeOhA3fBmGLyTbGYPnXDA+v+zXBZuYGZphkBm9nt5IM52ywnlrcyl5eVBl1yx1DaTjnIUMZOTCGC62yXKE5v4+GVJrk9Bf4sTYBkz0U2Hr8Lh1FVMYxraMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902196; c=relaxed/simple;
	bh=LKBXD8I/xC9fO0yhc+A2BDIa5uqy9/D5Ld7R6OMJazQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=czxR3+uPHa8CPlLQaxKhQbRTkHRHbA4gWhISAvbWCOIOMwn3qXOpSyzMUaNnNYKufaCVwy26PW9PvDvJRjY0LR1EgKhSkQlxb9CHk0/sj55H64xQ0K5oo3LLM4fO3HUfn71NIowfxf6xxvgBk6AW+omd/RsJjkjsrRuptlC/D8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WvRbd5dqyz1S9Mq;
	Thu, 29 Aug 2024 11:29:33 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C8F2180044;
	Thu, 29 Aug 2024 11:29:46 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 29 Aug 2024 11:29:45 +0800
Message-ID: <6f2975a1-a614-78da-21e7-1d99d5749488@huawei.com>
Date: Thu, 29 Aug 2024 11:29:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: Return early when break handler is found on
 linked-list
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <ptosi@google.com>,
	<oliver.upton@linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
 <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/27 20:50, Mark Rutland 写道:
> On Tue, Aug 27, 2024 at 11:00:46AM +0000, Liao Chang wrote:
>> The search for breakpoint handlers iterate through the entire
>> linked list. Given that all registered hook has a valid fn field, and no
>> registered hooks share the same mask and imm. This commit optimize the
>> efficiency slightly by returning early as a matching handler is found.
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> 
> This looks fine, though I'd love if we could clean this up to remove the
> linked list entirely by separating the user/kernel entrypoints and using
> a switch statement to decide the handler based on the immediate. That'd
> also remove the need for RCU protection.

Perhaps I could consider a similar approach to the bad addressing exception
in the file arch/arm64/mm/fault.c. It involves defining an array of break
hooks, including some default placeholder hooks. Kprobe, uprobe and KGDB could
then reuse existing register API to replace atomically these placeholder with
specific break hooks.

While most break hooks use the default mask for immediate checking in ESR,
with exception like KASAN and UBSAN. Then some hard-coded checks will be
used in the default base of switch statement for KASAN and UBSAN. That might
be a question.

> 
> Last I looked that would require some largely mechanical restructuring,
> and the only painful bit was the hooks that KGDB uses, since those are
> the only ones that actually get unregistered.

Unregistered hooks are repalced automically with the default placeholder hook
that returns DGB_HOOK_ERROR.

Chang.

> 
> Mark.
> 
>> ---
>>  arch/arm64/kernel/debug-monitors.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index 024a7b245056..fc998956f44c 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -281,6 +281,7 @@ static LIST_HEAD(kernel_break_hook);
>>  
>>  void register_user_break_hook(struct break_hook *hook)
>>  {
>> +	WARN_ON(!hook->fn);
>>  	register_debug_hook(&hook->node, &user_break_hook);
>>  }
>>  
>> @@ -291,6 +292,7 @@ void unregister_user_break_hook(struct break_hook *hook)
>>  
>>  void register_kernel_break_hook(struct break_hook *hook)
>>  {
>> +	WARN_ON(!hook->fn);
>>  	register_debug_hook(&hook->node, &kernel_break_hook);
>>  }
>>  
>> @@ -303,7 +305,6 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>>  {
>>  	struct break_hook *hook;
>>  	struct list_head *list;
>> -	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
>>  
>>  	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
>>  
>> @@ -313,10 +314,10 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>>  	 */
>>  	list_for_each_entry_rcu(hook, list, node) {
>>  		if ((esr_brk_comment(esr) & ~hook->mask) == hook->imm)
>> -			fn = hook->fn;
>> +			return hook->fn(regs, esr);
>>  	}
>>  
>> -	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
>> +	return DBG_HOOK_ERROR;
>>  }
>>  NOKPROBE_SYMBOL(call_break_hook);
>>  
>> -- 
>> 2.34.1
>>
>>
> 

-- 
BR
Liao, Chang

