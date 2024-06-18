Return-Path: <linux-kernel+bounces-218522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA290C152
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC0B21A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8E2FC19;
	Tue, 18 Jun 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WapzdiPV"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDF175AE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674568; cv=none; b=KC5MwOsgku4hOPON2m2BnWaOTpFCb7XQGLEiU7xR/KQuEDPiHS7Qax5MVk5BqPJUJDSnRVM/aY8NdKItRdfBZKpdn0MygpSlt9BT8qC+05tSycZv1gv4hSas+GRR033/yK4MfRTQn4sOCQOX968hDnY/DwWJjtH/Au9b3eqrDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674568; c=relaxed/simple;
	bh=iIEiqIFQgeYCNMQ+Wl/2nLXn0IzTC1Tmy2zBREYYlI0=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rYqBkaqP1K76heLyVROZfTsIftsEyAVmwOdltHiF7g4Uu6Mq4pGWcqF9empuTn0aD1FBcCOvpt4PAoEJE9Qwvw+hZlBwacScRNZxKzNH6Pf/yApjAZnwYi8TN3L6mqlrtkPnazQ/kEqikovJ7mqRK7Y8l/J5YSc9c6VWLJI6wmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WapzdiPV; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=5NzfkA5q9C0jLzrw16tR1I+KxBDvfdkzSwgICYcYmlE=;
	b=WapzdiPVaI2ywexmNqHPjVULouNLRhvk/6ckRcgCL9eIjPlChBoUKHl/IZzYUK
	XJXYSM72bTX0/MWSf8nlmlozj3dHzKbH8+D3AW1g4IbhbwGNhxO2QhnCfJbqLZr4
	1l5FnOIYBPrDNS/mv4ePabxihIM+bN5L0aucI28Bfe9rw=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDnL08O5HBm7o4SAA--.10734S2;
	Tue, 18 Jun 2024 09:34:08 +0800 (CST)
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
From: yangge1116 <yangge1116@126.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
 <2e3a3a3f-737c-ed01-f820-87efee0adc93@126.com>
Message-ID: <9b227c9d-f59b-a8b0-b353-7876a56c0bde@126.com>
Date: Tue, 18 Jun 2024 09:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2e3a3a3f-737c-ed01-f820-87efee0adc93@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL08O5HBm7o4SAA--.10734S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy8Gry7CrWrCFyrJFW7CFg_yoWrArW5pF
	WfG3Wa9a1UXry7A3ZFy3Z0kry0kw1rKr48Xr1rXr18uwnIyFyIy3y7tF1ruFyrAryUJF40
	qFWUt3ZxZF4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjR67UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRACG2VLayL9AgAAsI



在 2024/6/17 下午8:47, yangge1116 写道:
> 
> 
> 在 2024/6/17 下午6:26, Barry Song 写道:
>> On Tue, Jun 4, 2024 at 9:15 PM <yangge1116@126.com> wrote:
>>>
>>> From: yangge <yangge1116@126.com>
>>>
>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>> THP-sized allocations") no longer differentiates the migration type
>>> of pages in THP-sized PCP list, it's possible to get a CMA page from
>>> the list, in some cases, it's not acceptable, for example, allocating
>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>>>
>>> The patch forbids allocating non-CMA THP-sized page from THP-sized
>>> PCP list to avoid the issue above.
>>
>> Could you please describe the impact on users in the commit log?
> 
> If a large number of CMA memory are configured in the system (for 
> example, the CMA memory accounts for 50% of the system memory), starting 
> virtual machine with device passthrough will get stuck.
> 
> During starting virtual machine, it will call pin_user_pages_remote(..., 
> FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area, 
> pin_user_pages_remote() will migrate the page from CMA area to non-CMA 
> area because of FOLL_LONGTERM flag. If non-movable allocation requests 
> return CMA memory, pin_user_pages_remote() will enter endless loops.
> 
> backtrace:
> pin_user_pages_remote
> ----__gup_longterm_locked //cause endless loops in this function
> --------__get_user_pages_locked
> --------check_and_migrate_movable_pages //always check fail and continue 
> to migrate
> ------------migrate_longterm_unpinnable_pages
> ----------------alloc_migration_target // non-movable allocation
> 
>> Is it possible that some CMA memory might be used by non-movable
>> allocation requests? 
> 
> Yes.
> 
> 
>> If so, will CMA somehow become unable to migrate, causing cma_alloc() 
>> to fail?
> 
> 
> No, it will cause endless loops in __gup_longterm_locked(). If 
> non-movable allocation requests return CMA memory, 
> migrate_longterm_unpinnable_pages() will migrate a CMA page to another 
> CMA page, which is useless and cause endless loops in 
> __gup_longterm_locked().
> 
> backtrace:
> pin_user_pages_remote
> ----__gup_longterm_locked //cause endless loops in this function
> --------__get_user_pages_locked
> --------check_and_migrate_movable_pages //always check fail and continue 
> to migrate
> ------------migrate_longterm_unpinnable_pages
> 
> 
> 
> 
> 
>>>
>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for 
>>> THP-sized allocations")
>>> Signed-off-by: yangge <yangge1116@126.com>
>>> ---
>>>   mm/page_alloc.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 2e22ce5..0bdf471 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone 
>>> *preferred_zone,
>>>          WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>
>>>          if (likely(pcp_allowed_order(order))) {
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & 
>>> ALLOC_CMA ||
>>> +                                               order != 
>>> HPAGE_PMD_ORDER) {
>>> +                       page = rmqueue_pcplist(preferred_zone, zone, 
>>> order,
>>> +                                               migratetype, 
>>> alloc_flags);
>>> +                       if (likely(page))
>>> +                               goto out;
>>> +               }
>>
>> This seems not ideal, because non-CMA THP gets no chance to use PCP. 
>> But it
>> still seems better than causing the failure of CMA allocation.
>>
>> Is there a possible approach to avoiding adding CMA THP into pcp from 
>> the first
>> beginning? Otherwise, we might need a separate PCP for CMA.
>>

The vast majority of THP-sized allocations are GFP_MOVABLE, avoiding 
adding CMA THP into pcp may incur a slight performance penalty.

Commit 1d91df85f399 takes a similar approach to filter, and I mainly 
refer to it.


>>> +#else
>>>                  page = rmqueue_pcplist(preferred_zone, zone, order,
>>>                                         migratetype, alloc_flags);
>>>                  if (likely(page))
>>>                          goto out;
>>> +#endif
>>>          }
>>>
>>>          page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>>> -- 
>>> 2.7.4
>>
>> Thanks
>> Barry
>>


