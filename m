Return-Path: <linux-kernel+bounces-354440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140C0993D7B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460FD1C22EBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AE376E0;
	Tue,  8 Oct 2024 03:29:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9868C208AD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358178; cv=none; b=UMJVFIU3h1Rb08kELsM1MMeh487R4mawuLFQzZmwmWVHBzSZPNE3nA3QN9u2AN/zqPz/LijWHNc1I5ZkUX4ze08zzWEpJIFrXWK3FFocmxAwYdpz/OO/9n7d6Jl8Z48n6sEfXQEB7pVNH89Qpk6jSRfV+uNPdl5XKBipF5Q6RmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358178; c=relaxed/simple;
	bh=rQh5D4cvfD0Lz5J6edT7BjZvwf0Z1jMdp1q+7X0ctQE=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g0iJg7zRiuvvhaSZymfO3OB2Ojt7sjNSghG6XlPD4XfYRnbtqXyd+9BoLmn9cL+32OmueTFeYeC+TzqPIPaZ7OiCLBLpn3pJlLpyFZ6BOdbp4DNZpNxHpiVl9waivE72OAxRothisjER643ZDYPR8fqQZ7iB3/K7mJA620HNA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XN1hT0QmXzCt74;
	Tue,  8 Oct 2024 11:28:57 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 6724818009B;
	Tue,  8 Oct 2024 11:29:32 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Oct 2024 11:29:31 +0800
Subject: Re: [PATCH 1/1] mm/slab: remove duplicate check in create_cache()
To: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka
 Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo
 Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo
	<42.hyeyoo@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20240821032637.1930-1-thunder.leizhen@huawei.com>
 <4dadf9be-a349-4a19-ae9c-652ade9e2198@suse.cz>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bce65264-40f2-4b38-839f-e0d58eda03a8@huawei.com>
Date: Tue, 8 Oct 2024 11:29:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4dadf9be-a349-4a19-ae9c-652ade9e2198@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/2 20:09, Vlastimil Babka wrote:
> On 8/21/24 05:26, Zhen Lei wrote:
>> The WARN_ON() check in static function create_cache() is done by its only
>> parent kmem_cache_create_usercopy() before calling it.
>> 	if (...
>> 	    WARN_ON(size < usersize || size - usersize < useroffset))
>> 		usersize = useroffset = 0;
>> 	...
>> 	s = create_cache(..., size, ..., useroffset, usersize, ...);
>>
>> Therefore, the WARN_ON() check in create_cache() can be safely removed.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Hi, sorry for the late reply.
It doesn't matter, because the compiler will optimize it. It just saves
the reader a little time.

> This code was heavily refactored as of 6.12-rc1. Can you check if it's still
> the case and send updated patch?

It is still there. I'll post v2 later.

> Thanks,
> Vlastimil
> 
>> ---
>>  mm/slab_common.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 40b582a014b8f2f..3069c9095523484 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -210,9 +210,6 @@ static struct kmem_cache *create_cache(const char *name,
>>  	struct kmem_cache *s;
>>  	int err;
>>  
>> -	if (WARN_ON(useroffset + usersize > object_size))
>> -		useroffset = usersize = 0;
>> -
>>  	err = -ENOMEM;
>>  	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
>>  	if (!s)
> 
> .
> 

-- 
Regards,
  Zhen Lei

