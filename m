Return-Path: <linux-kernel+bounces-312888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D0969D2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6799B231A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B431C9858;
	Tue,  3 Sep 2024 12:14:41 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340A1A3AA0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365680; cv=none; b=k7fsQx+GIdJKp7Vqd+PyrH/J98S2OFFCB/RKM8rUH6fz+Uj/wY7p8yvJnzLa0NPAc1TwO4pzYSPBM7q1cvH1Z4cFcGJ3ijJx/Ub7ixdq3gHYE76a2RGyju0w3cVrDm+ULFzNFBf5itGnKdYGep3rZ6ki6d8Hnq89Om2XsH2BiqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365680; c=relaxed/simple;
	bh=NCvPOnEmcLwbQQtJP53jQNqHjD1ta4EvcIi4omOUNKM=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KqMog9zbB2Z8VPjuV0B/CmbTvE9S5Nu1eTPlCwyi+b5G4riaSweVqKLp6DwYNDWR+D/fXOZtRAyo9gzo+Mr90ZE2AGwzp51TlCUiSgiswJvgwUYuSq9lSGQY68xZxnbFe/5avF8JKswNdrOd0lqyc6Du0rzCXFK93UgTQVSiQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wyl0m2nP3z1S9mq;
	Tue,  3 Sep 2024 20:14:16 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FB151400D7;
	Tue,  3 Sep 2024 20:14:36 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 20:14:35 +0800
Subject: Re: [PATCH 4/5] debugobjects: Use hlist_splice_init() to reduce lock
 conflicts
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20240902140532.2028-1-thunder.leizhen@huawei.com>
 <20240902140532.2028-5-thunder.leizhen@huawei.com> <87le0982vo.ffs@tglx>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ca59d908-7779-8f84-57df-0298888a7340@huawei.com>
Date: Tue, 3 Sep 2024 20:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87le0982vo.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/9/3 18:09, Thomas Gleixner wrote:
> On Mon, Sep 02 2024 at 22:05, Zhen Lei wrote:
> 
>> The sub list can be prepared in advance outside the lock, so that the
>> operation time inside the lock can be reduced and the possibility of
>> lock conflict can be reduced.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  lib/debugobjects.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index fc8224f9f0eda8f..998724e9dee526b 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -167,23 +167,25 @@ static void fill_pool(void)
>>  		return;
>>  
>>  	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
>> -		struct debug_obj *new[ODEBUG_BATCH_SIZE];
>> +		HLIST_HEAD(batch_list);
>> +		struct debug_obj *new, *last;
> 
> Variable ordering please.

OK

> 
>>  		int cnt;
>>  
>>  		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
>> -			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
>> -			if (!new[cnt])
>> +			new = kmem_cache_zalloc(obj_cache, gfp);
>> +			if (!new)
>>  				break;
>> +			hlist_add_head(&new->node, &batch_list);
>> +			if (cnt == 0)
>                         
>                         if (!cnt)
> 
> but it would be more self explaining if you have:
> 
> 		struct debug_obj *new, *last = NULL;
> 
> and then
>                 if (!last)

OK, I will change it. I thought so, but I changed it to reduce
the null initialization. Ha ha, wrong choice.

> 
>> +				last = new;
>>  		}
> 
> Thanks,
> 
>         tglx
> .
> 

-- 
Regards,
  Zhen Lei

