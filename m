Return-Path: <linux-kernel+bounces-203958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A868E8FE24C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12541C221E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F313B5B9;
	Thu,  6 Jun 2024 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nCO5UMrP"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2F13D880
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665102; cv=none; b=oIzVCr8UbWjrX5cWQs56OkqELWTqDkW9EB2BaaoFtcYHGUSk2sZ5O8xyOMk+iDuxRtz5DMwUE8KvyTztqtO3YQRfFDHwRw/sSnKTQ2VKHpwunSVexJPFHnAAZuKV1xUw+t9Bbwj1rK0nvKHm8xVipYjS+tn7SM+8gynLiYCKVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665102; c=relaxed/simple;
	bh=B78sJA4u7GQ6oTEA8lz721ZrFNIE3REAE/bNe5WcHvI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lMbY4Xb9/XxNN+4cror3TYj2xdCeb2OAbT/VWRzlui3xTWRTyYENX67yjKYEwrhs0mY6r04d/E0oSREK6mKECYaTWjvq2F2lc8G6ow3Zfu+foUwtw7R3tHumzPxn15vPfeC0FXG9aGR7KO6J/PiSvBMMG1aX2PrGT4lTVpCuLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nCO5UMrP; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=fc/bMpgE3KzMCFW55h1T50uds9erffHp9ylfNmlmvJA=;
	b=nCO5UMrPVZ4GZhVXWNh6TcsxFF6bQCYDyq8ujEvhxpoyhawcHFDUWp9uMHURnI
	CRsWRO+b8EZQfwCukuYnPrxRJtZe+guW73AVlSR7FVCmRZXa5pSgnZT4D4EvpP9Q
	CaKMhBNL7+uDTrV6L1XCP4qwLKDD10zW4vkCIy/92rR0c=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wC330AifWFmmhe2AQ--.40121S2;
	Thu, 06 Jun 2024 17:11:00 +0800 (CST)
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
 <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
 <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <1250569c-c428-5a0c-f1b7-fe5013eace3f@126.com>
Date: Thu, 6 Jun 2024 17:10:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC330AifWFmmhe2AQ--.40121S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFy7KFWUGFy5KrWfWF47XFb_yoW5Xr45pF
	WrC3WjyF4UX345A3s7tFn0krnI9ws7KF48Wr4rZr1UZwnIkr4xGr97tF129F1rZrZrAF40
	vr4vgFyfZF4qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bofH8UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBb1G2VLbn5CgAAAsc



在 2024/6/6 上午11:06, Baolin Wang 写道:
> 
> 
> On 2024/6/4 20:36, yangge1116 wrote:
>>
>>
>> 在 2024/6/4 下午8:01, Baolin Wang 写道:
>>> Cc Johannes, Zi and Vlastimil.
>>>
>>> On 2024/6/4 17:14, yangge1116@126.com wrote:
>>>> From: yangge <yangge1116@126.com>
>>>>
>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>> THP-sized allocations") no longer differentiates the migration type
>>>> of pages in THP-sized PCP list, it's possible to get a CMA page from
>>>> the list, in some cases, it's not acceptable, for example, allocating
>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>>>>
>>>> The patch forbids allocating non-CMA THP-sized page from THP-sized
>>>> PCP list to avoid the issue above.
>>>>
>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for 
>>>> THP-sized allocations")
>>>> Signed-off-by: yangge <yangge1116@126.com>
>>>> ---
>>>>   mm/page_alloc.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 2e22ce5..0bdf471 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone 
>>>> *preferred_zone,
>>>>       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>>       if (likely(pcp_allowed_order(order))) {
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
>>>> +                        order != HPAGE_PMD_ORDER) {
>>>
>>> Seems you will also miss the non-CMA THP from the PCP, so I wonder if 
>>> we can add a migratetype comparison in __rmqueue_pcplist(), and if 
>>> it's not suitable, then fallback to buddy?
>>
>> Yes, we may miss some non-CMA THPs in the PCP. But, if add a 
>> migratetype comparison in __rmqueue_pcplist(), we may need to compare 
>> many times because of pcp batch.
> 
> I mean we can only compare once, focusing on CMA pages.

pcp_list may contains CMA and no-CMA pages, why only compare once, just 
increase one chance of using the pcp_list?


> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3734fe7e67c0..960a3b5744d8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2973,6 +2973,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, 
> unsigned int order,
>                  }
> 
>                  page = list_first_entry(list, struct page, pcp_list);
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +               if (order == HPAGE_PMD_ORDER && 
> !is_migrate_movable(migratetype) &&
> +                   is_migrate_cma(get_pageblock_migratetype(page)))
> +                       return NULL;
> +#endif
>                  list_del(&page->pcp_list);
>                  pcp->count -= 1 << order;
>          } while (check_new_pages(page, order));


