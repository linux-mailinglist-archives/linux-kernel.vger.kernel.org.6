Return-Path: <linux-kernel+bounces-306074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C966C9638CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F97E1F23BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3E45C14;
	Thu, 29 Aug 2024 03:29:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2ADDA6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902168; cv=none; b=fqhVmNRDjpo/CG1cCIRVy5pABoCYbuPaxlNsKuTOOEKP9qrfII7kxonJieSOMxLKLg3tBX4dGy9ujCLILuCxYMYZ0Xhu9WWdfQ+2QJKaKld2gYcrHt+eJ008IneKmK7bp2eDnwU0yaNmG9nA5A3uOSPzdMzeZW9LBUZ9PgShSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902168; c=relaxed/simple;
	bh=P4onTy/g8jbmY85Z3sRGp9r4RonDXdQa9N0plUrdiD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kFUVXGlbHxPS+EGnikmyl2NSNtXK7TzD5w6b6bOW4UBOfDp5FtzuG5aLcqGy/t6hXKE+s0lfh9pALaGW6poB11HDcV6Y78Tmcxsu+iuGS0Oa8cZ0+KPilXF9FP328GtQHvuebX8kkwDGZj5r/fYNF0N55fOtvQghshPg6k049vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WvRZk3XsMzyR17;
	Thu, 29 Aug 2024 11:28:46 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 94D8E1401F2;
	Thu, 29 Aug 2024 11:29:17 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 29 Aug 2024 11:29:17 +0800
Message-ID: <d5f964b4-f59d-d16a-3278-9fd374df554a@huawei.com>
Date: Thu, 29 Aug 2024 11:29:16 +0800
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
To: Will Deacon <will@kernel.org>
CC: <catalin.marinas@arm.com>, <ptosi@google.com>, <oliver.upton@linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240827110046.3209679-1-liaochang1@huawei.com>
 <20240827123044.GB4679@willie-the-truck>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240827123044.GB4679@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/27 20:30, Will Deacon 写道:
> On Tue, Aug 27, 2024 at 11:00:46AM +0000, Liao Chang wrote:
>> The search for breakpoint handlers iterate through the entire
>> linked list. Given that all registered hook has a valid fn field, and no
>> registered hooks share the same mask and imm. This commit optimize the
>> efficiency slightly by returning early as a matching handler is found.
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
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
> 
> I don't think we need these WARN_ON()s. This API is pretty limited and
> passing a NULL callback doesn't make sense.

Them will be removed in next revision.

> 
> Rest of the patch looks fine.
> 
> Will
> 
> 

-- 
BR
Liao, Chang

