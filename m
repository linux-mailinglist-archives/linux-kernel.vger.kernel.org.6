Return-Path: <linux-kernel+bounces-218711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69A90C43C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E7D282C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD913AD1C;
	Tue, 18 Jun 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iRgaq55s"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B157D13AD04
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693774; cv=none; b=psSZx/IsNhW1zxwHy7TrLx4odaNjsuPytdfcC+ehyUbDZEyXTBk0378SRGA6UYn/rVyLG5tsLFxwI2C2CVeC95CyEE/YSwGSx0qyFrS1hPm+KDPOb4hHqNqIwqoD/FVgl4ISNZw6WC3gJ92YCP8SCcSOs2Qyg3wvYthrYb5iDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693774; c=relaxed/simple;
	bh=fsFfNrBkePsMnxiJSSW88AoIOsQv3yU4kVdxLJKyeGk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dOuIxA4c5D/1Mv1nqQBjjXXwHSqyySWc3pJWUhpngG4DQVj+WJVFKo6NtrE0S4EUAlnyyYoBFysOVGdSa8LlRWPE9YO3GrztGrtwF0DSay/UfhtnhpN4o2vKPGVQ8BAyvtbT2erL7oQ+QCpwjsZ/JLqwud60/+5aeLrdVaDrCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iRgaq55s; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=vvxOdGUqhDUSauHPn9IS8ZFXOKSW+Rv9renG2SFu+0w=;
	b=iRgaq55sYvXvtznNn8qmwsls2qIoCGr0uOgCxQD8pP8kdTUFaMqf6ZEib9hYtc
	X6zkt8F+p9lpmzW0cR9wodqY/b1ml1EqIx9+Sjmnudjz+jOiw6UXx1KMzbJmv8V6
	hfS+yXPSHL0tVqz/XBpgE727jc4pavv33OI27lS9J5Wls=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3_xR0L3FmNui5Bg--.13587S2;
	Tue, 18 Jun 2024 14:55:50 +0800 (CST)
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
 <2e3a3a3f-737c-ed01-f820-87efee0adc93@126.com>
 <9b227c9d-f59b-a8b0-b353-7876a56c0bde@126.com>
 <CAGsJ_4ynfvjXsr6QFBA_7Gzk3PaO1pk+6ErKZaNCt4H+nuwiJw@mail.gmail.com>
 <4482bf69-eb07-0ec9-f777-28ce40f96589@126.com>
 <CAGsJ_4ytYTpvRVgR1EoazsH=QxZCDE2e8H0BeXrY-6zWFD0kCg@mail.gmail.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <69414410-4e2d-c04c-6fc3-9779f9377cf2@126.com>
Date: Tue, 18 Jun 2024 14:55:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4ytYTpvRVgR1EoazsH=QxZCDE2e8H0BeXrY-6zWFD0kCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_xR0L3FmNui5Bg--.13587S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFykXFy3XryfKw15GFykZrb_yoW3Jr15pF
	WfJ3W7Kr4UXryUAw17twn0kr1jkw13Kr18Xr15Jry8urnFyr1IyF4xJr1UuFyrAryUJF40
	qryUtF9xZF4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jW_MfUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhwCG2VEw2ZqDAAAsd



在 2024/6/18 下午12:10, Barry Song 写道:
> On Tue, Jun 18, 2024 at 3:32 PM yangge1116 <yangge1116@126.com> wrote:
>>
>>
>>
>> 在 2024/6/18 上午9:55, Barry Song 写道:
>>> On Tue, Jun 18, 2024 at 9:36 AM yangge1116 <yangge1116@126.com> wrote:
>>>>
>>>>
>>>>
>>>> 在 2024/6/17 下午8:47, yangge1116 写道:
>>>>>
>>>>>
>>>>> 在 2024/6/17 下午6:26, Barry Song 写道:
>>>>>> On Tue, Jun 4, 2024 at 9:15 PM <yangge1116@126.com> wrote:
>>>>>>>
>>>>>>> From: yangge <yangge1116@126.com>
>>>>>>>
>>>>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>>>>> THP-sized allocations") no longer differentiates the migration type
>>>>>>> of pages in THP-sized PCP list, it's possible to get a CMA page from
>>>>>>> the list, in some cases, it's not acceptable, for example, allocating
>>>>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>>>>>>>
>>>>>>> The patch forbids allocating non-CMA THP-sized page from THP-sized
>>>>>>> PCP list to avoid the issue above.
>>>>>>
>>>>>> Could you please describe the impact on users in the commit log?
>>>>>
>>>>> If a large number of CMA memory are configured in the system (for
>>>>> example, the CMA memory accounts for 50% of the system memory), starting
>>>>> virtual machine with device passthrough will get stuck.
>>>>>
>>>>> During starting virtual machine, it will call pin_user_pages_remote(...,
>>>>> FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area,
>>>>> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
>>>>> area because of FOLL_LONGTERM flag. If non-movable allocation requests
>>>>> return CMA memory, pin_user_pages_remote() will enter endless loops.
>>>>>
>>>>> backtrace:
>>>>> pin_user_pages_remote
>>>>> ----__gup_longterm_locked //cause endless loops in this function
>>>>> --------__get_user_pages_locked
>>>>> --------check_and_migrate_movable_pages //always check fail and continue
>>>>> to migrate
>>>>> ------------migrate_longterm_unpinnable_pages
>>>>> ----------------alloc_migration_target // non-movable allocation
>>>>>
>>>>>> Is it possible that some CMA memory might be used by non-movable
>>>>>> allocation requests?
>>>>>
>>>>> Yes.
>>>>>
>>>>>
>>>>>> If so, will CMA somehow become unable to migrate, causing cma_alloc()
>>>>>> to fail?
>>>>>
>>>>>
>>>>> No, it will cause endless loops in __gup_longterm_locked(). If
>>>>> non-movable allocation requests return CMA memory,
>>>>> migrate_longterm_unpinnable_pages() will migrate a CMA page to another
>>>>> CMA page, which is useless and cause endless loops in
>>>>> __gup_longterm_locked().
>>>
>>> This is only one perspective. We also need to consider the impact on
>>> CMA itself. For example,
>>> when CMA is borrowed by THP, and we need to reclaim it through
>>> cma_alloc() or dma_alloc_coherent(),
>>> we must move those pages out to ensure CMA's users can retrieve that
>>> contiguous memory.
>>>
>>> Currently, CMA's memory is occupied by non-movable pages, meaning we
>>> can't relocate them.
>>> As a result, cma_alloc() is more likely to fail.
>>>
>>>>>
>>>>> backtrace:
>>>>> pin_user_pages_remote
>>>>> ----__gup_longterm_locked //cause endless loops in this function
>>>>> --------__get_user_pages_locked
>>>>> --------check_and_migrate_movable_pages //always check fail and continue
>>>>> to migrate
>>>>> ------------migrate_longterm_unpinnable_pages
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>>>>> THP-sized allocations")
>>>>>>> Signed-off-by: yangge <yangge1116@126.com>
>>>>>>> ---
>>>>>>>     mm/page_alloc.c | 10 ++++++++++
>>>>>>>     1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>> index 2e22ce5..0bdf471 100644
>>>>>>> --- a/mm/page_alloc.c
>>>>>>> +++ b/mm/page_alloc.c
>>>>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
>>>>>>> *preferred_zone,
>>>>>>>            WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>>>>>
>>>>>>>            if (likely(pcp_allowed_order(order))) {
>>>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags &
>>>>>>> ALLOC_CMA ||
>>>>>>> +                                               order !=
>>>>>>> HPAGE_PMD_ORDER) {
>>>>>>> +                       page = rmqueue_pcplist(preferred_zone, zone,
>>>>>>> order,
>>>>>>> +                                               migratetype,
>>>>>>> alloc_flags);
>>>>>>> +                       if (likely(page))
>>>>>>> +                               goto out;
>>>>>>> +               }
>>>>>>
>>>>>> This seems not ideal, because non-CMA THP gets no chance to use PCP.
>>>>>> But it
>>>>>> still seems better than causing the failure of CMA allocation.
>>>>>>
>>>>>> Is there a possible approach to avoiding adding CMA THP into pcp from
>>>>>> the first
>>>>>> beginning? Otherwise, we might need a separate PCP for CMA.
>>>>>>
>>>>
>>>> The vast majority of THP-sized allocations are GFP_MOVABLE, avoiding
>>>> adding CMA THP into pcp may incur a slight performance penalty.
>>>>
>>>
>>> But the majority of movable pages aren't CMA, right?
>>
>>> Do we have an estimate for
>>> adding back a CMA THP PCP? Will per_cpu_pages introduce a new cacheline, which
>>> the original intention for THP was to avoid by having only one PCP[1]?
>>>
>>> [1] https://patchwork.kernel.org/project/linux-mm/patch/20220624125423.6126-3-mgorman@techsingularity.net/
>>>
>>
>> The size of struct per_cpu_pages is 256 bytes in current code containing
>> commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized
>> allocations").
>> crash> struct per_cpu_pages
>> struct per_cpu_pages {
>>       spinlock_t lock;
>>       int count;
>>       int high;
>>       int high_min;
>>       int high_max;
>>       int batch;
>>       u8 flags;
>>       u8 alloc_factor;
>>       u8 expire;
>>       short free_count;
>>       struct list_head lists[13];
>> }
>> SIZE: 256
>>
>> After revert commit 5d0a661d808f ("mm/page_alloc: use only one PCP list
>> for THP-sized allocations"), the size of struct per_cpu_pages is 272 bytes.
>> crash> struct per_cpu_pages
>> struct per_cpu_pages {
>>       spinlock_t lock;
>>       int count;
>>       int high;
>>       int high_min;
>>       int high_max;
>>       int batch;
>>       u8 flags;
>>       u8 alloc_factor;
>>       u8 expire;
>>       short free_count;
>>       struct list_head lists[15];
>> }
>> SIZE: 272
>>
>> Seems commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>> THP-sized allocations") decrease one cacheline.
> 
> the proposal is not reverting the patch but adding one CMA pcp.
> so it is "struct list_head lists[14]"; in this case, the size is still
> 256?
> 

Yes, the size is still 256. If add one PCP list, we will have 2 PCP 
lists for THP. One PCP list is used by MIGRATE_UNMOVABLE, and the other 
PCP list is used by MIGRATE_MOVABLE and MIGRATE_RECLAIMABLE. Is that right?

> 
>>
>>>
>>>> Commit 1d91df85f399 takes a similar approach to filter, and I mainly
>>>> refer to it.
>>>>
>>>>
>>>>>>> +#else
>>>>>>>                    page = rmqueue_pcplist(preferred_zone, zone, order,
>>>>>>>                                           migratetype, alloc_flags);
>>>>>>>                    if (likely(page))
>>>>>>>                            goto out;
>>>>>>> +#endif
>>>>>>>            }
>>>>>>>
>>>>>>>            page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>>>>>>> --
>>>>>>> 2.7.4
>>>>>>
>>>>>> Thanks
>>>>>> Barry
>>>>>>
>>>>
>>>>
>>


