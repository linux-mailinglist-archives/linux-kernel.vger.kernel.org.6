Return-Path: <linux-kernel+bounces-377200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4E9ABB28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B19284E35
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D9B335D3;
	Wed, 23 Oct 2024 01:52:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2712B73
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648354; cv=none; b=Bchb6XIQ8JPiI+W2+A5I2rl7oPB/5F2GqbepIJhdJr7ZKjkE1Nm2M8u0xZ8+MqvhbJtM6CP0FSs7AYH3HKhVyzBPqirAVi6BdoWTNV035g2YuuxRgRI2OiPhIcDiFOK2YvcSP388C2c99+B+z2z/LQDKDBIRtfUHer54h8BKV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648354; c=relaxed/simple;
	bh=/TBq11UmBlTtoHfO0VMvSxgvrNNC+5R4S8pMRLVVmNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QwYgXcLQN+U6I9N/WHMyDjp0lJhThyov648zhVrQNR4uMxxx9b5Tk6nifTMPiyVO0dndgNgJFMczQAhRXIC9BZXlN9vlVMtKW6VBOwVxeiAtteBt6ht9omMw8Qjr9wF//guKS1pzsUz0ILmcjwLxfYru9HmqYkZ/laP/Jcm5jC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYBnv378Vz10N3R;
	Wed, 23 Oct 2024 09:50:27 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id D849B14010D;
	Wed, 23 Oct 2024 09:52:28 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 23 Oct 2024 09:52:28 +0800
Message-ID: <f9357dff-1f08-42ce-b6c2-93b3a2d9336f@huawei.com>
Date: Wed, 23 Oct 2024 09:52:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Return early when break handler is found on
 linked-list
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <ptosi@google.com>, <oliver.upton@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
 <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <Zs3LnYkXL5sg2yBH@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Hi, Mark and Will

Kindly ping.

I'd like to get your input on the next step. Should I send a v2 patch
that only removes the WARN_ON() as Will suggested? Or should I push
forward the refactoring of calling BRK hook [1].

Thanks.

[1] https://lore.kernel.org/all/20240906031930.746118-1-liaochang1@huawei.com/

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
> 
> Last I looked that would require some largely mechanical restructuring,
> and the only painful bit was the hooks that KGDB uses, since those are
> the only ones that actually get unregistered.
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


