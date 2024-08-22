Return-Path: <linux-kernel+bounces-296395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 262E895AA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF26B25900
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2124205;
	Thu, 22 Aug 2024 01:27:26 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC4F225D7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290046; cv=none; b=GwqODB1Z/lbIoPHWjBNGEUfmm1+MPgf/5cDaD/44FnxCxPH83CFummFsjlDMFAbbZax+aKD3NKKspHu4mD1St+fs2VwYZ5eY2veNGBgfOTyBvKYqbNh6FGBBAQDg9gvXhMclxidFc5mZwvOJ8DZAdhdp6JXEgM+ctjPf5CI1avs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290046; c=relaxed/simple;
	bh=lmk3dctO/cveX59+hDGnO8BXJgoMmj7Sk4jzFtRO/48=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TrY1XIGKuyk1J+x7/lgv+R9bQcQKPIROXAcXNBdNqRuc3brbFgj7oA60JqW0NBn+7rlD51oowRvg6HtVAEmcqNiP3FI27bI3itb/wutOfShUHgfTvFpMCF9cHNgYaUgg9wPZGCY1rxf1Ikif6kSh7sTO2J/PHAEQ0jrsjrTDJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wq56J2HZTz69LC;
	Thu, 22 Aug 2024 09:22:32 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B8E414037B;
	Thu, 22 Aug 2024 09:27:15 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 09:27:14 +0800
Subject: Re: [PATCH 1/1] mm/page_poison: slightly optimize check_poison_mem()
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240821075311.1953-1-thunder.leizhen@huawei.com>
 <8d40e74e-c68b-4f94-ae1e-42c4430d55e2@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a8f186c5-78fc-30b6-4019-80325db540c3@huawei.com>
Date: Thu, 22 Aug 2024 09:27:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8d40e74e-c68b-4f94-ae1e-42c4430d55e2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/8/21 19:28, David Hildenbrand wrote:
> On 21.08.24 09:53, Zhen Lei wrote:
>> When the debug information needs to be suppressed due to ratelimit,
>> it is unnecessary to determine the end of the corrupted memory.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   mm/page_poison.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/page_poison.c b/mm/page_poison.c
>> index 3e9037363cf9d85..23fa799214720f1 100644
>> --- a/mm/page_poison.c
>> +++ b/mm/page_poison.c
>> @@ -55,14 +55,15 @@ static void check_poison_mem(struct page *page, unsigned char *mem, size_t bytes
>>       if (!start)
>>           return;
>>   +    if (!__ratelimit(&ratelimit))
>> +        return;
>> +
>>       for (end = mem + bytes - 1; end > start; end--) {
>>           if (*end != PAGE_POISON)
>>               break;
>>       }
>>   -    if (!__ratelimit(&ratelimit))
>> -        return;
>> -    else if (start == end && single_bit_flip(*start, PAGE_POISON))
>> +    if (start == end && single_bit_flip(*start, PAGE_POISON))
>>           pr_err("pagealloc: single bit error\n");
>>       else
>>           pr_err("pagealloc: memory corruption\n");
> 
> This way, you will be ratelimiting on every function call, possibly skipping PAGE_POISON checks even if there was no prior corruption detected?
> 

No, the previous memchr_inv() does the PAGE_POISON check, determine the start of the corrupted memory. !start means no corruption.

	start = memchr_inv(mem, PAGE_POISON, bytes);
	if (!start)
		return;

+	if (!__ratelimit(&ratelimit))
+		return;

	for (end = mem + bytes - 1; end > start; end--) {
		if (*end != PAGE_POISON)
			break;
	}



-- 
Regards,
  Zhen Lei

