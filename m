Return-Path: <linux-kernel+bounces-386219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A32C9B4097
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2383CB21FE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD51E1325;
	Tue, 29 Oct 2024 02:43:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0098193071
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169780; cv=none; b=Fgv1fl4D6yY8e/ZcgZYtflBZ3J5c7yUtUnj6RN+Noby4sfMibqORSToN37CwHmnms/DE+12efTKqh7OGN3ur3sTECpXirBXFv98TR6IQJRCz3HcbdAwdfDhyGmxXNHTGIJwtqhuR9sNsWL7DC+BD2TQ2QeFNqI6+D0+936KnR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169780; c=relaxed/simple;
	bh=vEy5d3WKNYS5RLpIpkjoSTwzIuUMOnh5j9y79NVVCds=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O9J6J+qSTCe1miSvMAYIwjwIdLlQATfkp/MfDOJceU2h2CNTXL9KwipVEBKkEPY3A/QCpFuFAhJZYCcfHZusA+StaHWTbJmMEwbQm9gFnHsgoCpK0FBEFpUG+1oxKf/rBFZfkjZwtauvXLVNp1TKj9+j7BUbS/8VpsTb6/BPAI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XcvfY30GPz20r5l;
	Tue, 29 Oct 2024 10:41:57 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D88414013B;
	Tue, 29 Oct 2024 10:42:55 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 29 Oct 2024 10:42:54 +0800
Message-ID: <ac6b0f63-69f4-4f7f-87d6-319c3027ffff@huawei.com>
Date: Tue, 29 Oct 2024 10:42:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Return early when break handler is found on
 linked-list
To: Will Deacon <will@kernel.org>
CC: <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<oliver.upton@linux.dev>, <kristina.martsenko@arm.com>, <ptosi@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241024034120.3814224-1-liaochang1@huawei.com>
 <20241024145028.GA31224@willie-the-truck>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20241024145028.GA31224@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/10/24 22:50, Will Deacon 写道:
> On Thu, Oct 24, 2024 at 03:41:20AM +0000, Liao Chang wrote:
>> The search for breakpoint handlers iterate through the entire
>> linked list. Given that all registered hook has a valid fn field, and no
>> registered hooks share the same mask and imm. This commit optimize the
>> efficiency slightly by returning early as a matching handler is found.
>>
>> v2->v1:
>> Remove all WARN_ON(!hook->fn) in v1 as Will suggested.
> 
> nit: Changelogs like ^^^ should go after the '---' line, otherwise they
> end up in the git history.

Will

Thanks for pointing out.

> 
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/arm64/kernel/debug-monitors.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index c60a4a90c6a5..58f047de3e1c 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -303,7 +303,6 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
>>  {
>>  	struct break_hook *hook;
>>  	struct list_head *list;
>> -	int (*fn)(struct pt_regs *regs, unsigned long esr) = NULL;
>>  
>>  	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
>>  
>> @@ -313,10 +312,10 @@ static int call_break_hook(struct pt_regs *regs, unsigned long esr)
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
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I assume Catalin will pick this one up (but he'll need to tweak the
> commit message as per my comment above).
> 
> Will

-- 
BR
Liao, Chang


