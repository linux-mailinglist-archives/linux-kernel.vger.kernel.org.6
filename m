Return-Path: <linux-kernel+bounces-217227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B594A90AD13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E201F22F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952BF194AD4;
	Mon, 17 Jun 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q3sCW/uB"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507617FAA4
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624180; cv=none; b=r2weRtYIkZBNt0R5e6Gu5UcNhOXDTBPV5Wg2JqHPrA6CU7Z1Rm3+rsUpbu9GxsBpYbmYAKuvtws1vTPQqNekbcOjGUnuKmEov3NKsd+POTUq7c6jd0triJM9xnfJ/cDhdenQs/hSKX8Yrd5MOAH3yIkUE27NIWvVHzlbez0kMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624180; c=relaxed/simple;
	bh=HgbbKIN59xMOMkOM35Lr6tD1Zl3TR+Kx7kF0gqw4zGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMuYVl61KMTzIMJ5gwVnt9x/fNPL6PQtvPD8Cb2WsMaTzOeTaGRczfHSyhLECwDYb4hBf2NPnjunCFV++exnxFdbhJsBnv3r3+FaX9u2smr81u2yx8Rn4OpuqyRk3rNHLg9E18eSBYfxUGxHKJZ/oKqFqz31GKLTmW0xQOBqOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q3sCW/uB; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718624175; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=E2MMVK6CmD4r8j4aKlkyVgyeeNax6qRDpJMHibAguZM=;
	b=q3sCW/uB8Gx910AaJjwDEDIYpYFX4lYCnJprPy2srP0FWVf9J+EBxZGf5y9yrVbiNr48d700Q+S9XeB7B+tYhvk8GIRB4KCB2SYjvplT0VDk4Y6cYHOgsgZOhl06SsRvJ6QzxZf+75jXOctXusVTwQHv6OfYtYvMDQV7fyO1lmw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W8d3SmY_1718624173;
Received: from 30.97.56.79(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8d3SmY_1718624173)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 19:36:14 +0800
Message-ID: <6dc8df31-eb01-4382-8467-c5510f75531e@linux.alibaba.com>
Date: Mon, 17 Jun 2024 19:36:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Barry Song <21cnbao@gmail.com>
Cc: yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
 <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
 <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
 <CAGsJ_4xgqDrTsQRYB_VKn+KC6rvYeJF6TQwhT5JnLi-b4nFTOQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xgqDrTsQRYB_VKn+KC6rvYeJF6TQwhT5JnLi-b4nFTOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/17 18:43, Barry Song wrote:
> On Thu, Jun 6, 2024 at 3:07 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/6/4 20:36, yangge1116 wrote:
>>>
>>>
>>> 在 2024/6/4 下午8:01, Baolin Wang 写道:
>>>> Cc Johannes, Zi and Vlastimil.
>>>>
>>>> On 2024/6/4 17:14, yangge1116@126.com wrote:
>>>>> From: yangge <yangge1116@126.com>
>>>>>
>>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>>> THP-sized allocations") no longer differentiates the migration type
>>>>> of pages in THP-sized PCP list, it's possible to get a CMA page from
>>>>> the list, in some cases, it's not acceptable, for example, allocating
>>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>>>>>
>>>>> The patch forbids allocating non-CMA THP-sized page from THP-sized
>>>>> PCP list to avoid the issue above.
>>>>>
>>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>>> THP-sized allocations")
>>>>> Signed-off-by: yangge <yangge1116@126.com>
>>>>> ---
>>>>>    mm/page_alloc.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index 2e22ce5..0bdf471 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
>>>>> *preferred_zone,
>>>>>        WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>>>        if (likely(pcp_allowed_order(order))) {
>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
>>>>> +                        order != HPAGE_PMD_ORDER) {
>>>>
>>>> Seems you will also miss the non-CMA THP from the PCP, so I wonder if
>>>> we can add a migratetype comparison in __rmqueue_pcplist(), and if
>>>> it's not suitable, then fallback to buddy?
>>>
>>> Yes, we may miss some non-CMA THPs in the PCP. But, if add a migratetype
>>> comparison in __rmqueue_pcplist(), we may need to compare many times
>>> because of pcp batch.
>>
>> I mean we can only compare once, focusing on CMA pages.
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3734fe7e67c0..960a3b5744d8 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2973,6 +2973,11 @@ struct page *__rmqueue_pcplist(struct zone *zone,
>> unsigned int order,
>>                   }
>>
>>                   page = list_first_entry(list, struct page, pcp_list);
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +               if (order == HPAGE_PMD_ORDER &&
>> !is_migrate_movable(migratetype) &&
>> +                   is_migrate_cma(get_pageblock_migratetype(page)))
>> +                       return NULL;
>> +#endif
> 
> This doesn't seem ideal either. It's possible that the PCP still has many
> non-CMA folios, but due to bad luck, the first entry is "always" CMA.
> In this case,
> allocations with is_migrate_movable(migratetype) == false will always lose the
> chance to use the PCP.   It also appears to incur a PCP spin lock/unlock.

Yes, just some ideas to to mitigate the issue...

> 
> I don't see an ideal solution unless we bring back the CMA PCP :-)

Tend to agree, and adding a CMA PCP seems the overhead can be acceptable?

