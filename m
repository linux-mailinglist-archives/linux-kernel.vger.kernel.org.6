Return-Path: <linux-kernel+bounces-185886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A069F8CBC77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538E21F222AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25261381BD;
	Wed, 22 May 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lVeRo1cm"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBF7BB15
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364448; cv=none; b=TrxAzF2pHzxBQ7euT/pfnnsyLHEboyOUtZFB+UTuV5Yvj05sxZRVN17hXUSRWc/P8Ngn2/qvLyY0dlM5Zz9qKepZ+2NouJfj/Z7CiQxyuqHsiwFVzwZu6M2runoNayiMgecdEsGqB3OhaJq9EGtvmx6qsqgoM7ZuTm8tIa+nJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364448; c=relaxed/simple;
	bh=ncjhNJZ5HiljIy8Iu5tPcstWmopFvUfAszYL+ZrJ7Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdK66DN+g9scowQRwKZiXgs8OTfKU3c+QgBgDEttYUyE8NCET5XJI+zeMgMxxVY3QqaMageZ3iO8TsgBOQ93On1YK1mEtScqS9kPxLBMb2dEkcOLY67S3Vov7bSWern8Tj/DYSRQ1O+kEE/ET5C9d1XcgnFfaGB+UdVUV3I9Yj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lVeRo1cm; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716364443; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BTRCthf3MwxjqRJvuhMBtVbgzw2jNBN2hGAw2Hd/zn4=;
	b=lVeRo1cm+0abmkBrNMgdQ3cFO4IdCHbVFGndyGt9e1QgKYXKr36CKUB3SYK+CG3ma02kHZsikygoHZTX8TFUp1YBdlk1hpWla6oJiuRFO6ySWV5BK2/drJHVxZ/PnXa+ZPlJj/wyJ2vZAjNZkg9eepogZoARdMGSzPrHCpUNIE4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7-a1va_1716364440;
Received: from 30.97.56.54(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7-a1va_1716364440)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 15:54:01 +0800
Message-ID: <a859c435-9190-465d-ac88-82d47f06cccd@linux.alibaba.com>
Date: Wed, 22 May 2024 15:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] mm: fix shmem swapout statistic
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, ioworker0@gmail.com, hrisl@kernel.org,
 p.raghav@samsung.com, da.gomez@samsung.com, wangkefeng.wang@huawei.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
 <f467d0e9a021f4bd95588b9d888f1740fab3e3bc.1716285099.git.baolin.wang@linux.alibaba.com>
 <87le42b9l6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87le42b9l6.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/5/22 15:16, Huang, Ying wrote:
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> As we know, shmem not only supports the sharing of anonymous pages, but also
>> the RAM-based temporary filesystem. Therefore, shmem swapouts should not be
>> marked as anonymous swapout statistics. Fix it by adding folio_test_anon().
>>
>> Fixes: d0f048ac39f6 ("mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/page_io.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index 46c603dddf04..b181b81f39e3 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -217,7 +217,9 @@ static inline void count_swpout_vm_event(struct folio *folio)
>>   		count_memcg_folio_events(folio, THP_SWPOUT, 1);
>>   		count_vm_event(THP_SWPOUT);
>>   	}
>> -	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
>> +
>> +	if (folio_test_anon(folio))
>> +		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
> 
> Do we need to distinguish anonymous swapout and non-anonymous swapout?
> IMHO, we don't.  Just like we have done for small folio and THP.

Yes, old counters did not add 'anon_' prefix.

> If so, how about fix this in another direction?  That is, remove "ANON"
> from mTHP swapout statistics?

This sounds good to me. And I will separate out an individual patch with 
your suggestion. Thanks.

