Return-Path: <linux-kernel+bounces-218605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E390C27F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF891F22526
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFB13A265;
	Tue, 18 Jun 2024 03:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hekzG3fr"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA471078B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681491; cv=none; b=RaoIaXbiny29qfC+Adyk65yuIwZNATLo2+/gKMRtQOgC9S9bnQasJHxz+7CVFHKE/5EJqjMx5Jp+EW9kWT4R8NOtp7lKTiI+hFPq8p59HrqILEbew9IyALmCo986ju82QotT4Ru2iBFIkw5ibqUnFuTB1jBaJ91jUhG4aCVjNEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681491; c=relaxed/simple;
	bh=SpBt0hbpPezUvX7Dfy11W/uXWq3AonpwV160WsE6UfY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lBzsNMTd8lH9y+uD6o372BYWOMYXRDd8vcH/Fc1om4lfPFNN0Q/1C2xDsr5TYDJpRBZJC131TBZ6AWe5DG5v2fuf8/UcJbrZob3V5Uj8MzRAE/nwGNBfOxRjLnJR/NNRQODRR/ev73+CFRrJcX46lf5e65QNXrRB/TJ0SPl4JuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hekzG3fr; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=FMGSPpXZUiFkhSCU0e4bsz7g6v295g4MMcsy6x3vwJM=;
	b=hekzG3frY+gSaAFGZg0o8uk4sVJmZ5RAA780VseFoddNY8XMXdmXR5IYYeOaM2
	TUTj7SYdmmnH9VzWz//drb+YjNs2oicI4LSrZ+n5Z58FDvhOyZnWuumLUk779uZ+
	wcq/nBHwy4OYEc3IDSwC2ui412QUdTH5akfoI2SV3YKB0=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wD3X0x0_3Bm47oVAA--.12793S2;
	Tue, 18 Jun 2024 11:31:02 +0800 (CST)
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
From: yangge1116 <yangge1116@126.com>
Message-ID: <4482bf69-eb07-0ec9-f777-28ce40f96589@126.com>
Date: Tue, 18 Jun 2024 11:31:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4ynfvjXsr6QFBA_7Gzk3PaO1pk+6ErKZaNCt4H+nuwiJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X0x0_3Bm47oVAA--.12793S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw17Gr4kuFyxZr4fWFyfJFb_yoWxXr1DpF
	WfG3W7Ka1UX345Awnrt3Z0kr1Yk343Kr18Wr1rXry8urnIyr1IkF4xJr1UuFyrAry7JF40
	qrWUt3ZxZF4UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjiSLUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhkCG2VEw2HQMwAAsa



在 2024/6/18 上午9:55, Barry Song 写道:
> On Tue, Jun 18, 2024 at 9:36 AM yangge1116 <yangge1116@126.com> wrote:
>>
>>
>>
>> 在 2024/6/17 下午8:47, yangge1116 写道:
>>>
>>>
>>> 在 2024/6/17 下午6:26, Barry Song 写道:
>>>> On Tue, Jun 4, 2024 at 9:15 PM <yangge1116@126.com> wrote:
>>>>>
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
>>>>
>>>> Could you please describe the impact on users in the commit log?
>>>
>>> If a large number of CMA memory are configured in the system (for
>>> example, the CMA memory accounts for 50% of the system memory), starting
>>> virtual machine with device passthrough will get stuck.
>>>
>>> During starting virtual machine, it will call pin_user_pages_remote(...,
>>> FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area,
>>> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
>>> area because of FOLL_LONGTERM flag. If non-movable allocation requests
>>> return CMA memory, pin_user_pages_remote() will enter endless loops.
>>>
>>> backtrace:
>>> pin_user_pages_remote
>>> ----__gup_longterm_locked //cause endless loops in this function
>>> --------__get_user_pages_locked
>>> --------check_and_migrate_movable_pages //always check fail and continue
>>> to migrate
>>> ------------migrate_longterm_unpinnable_pages
>>> ----------------alloc_migration_target // non-movable allocation
>>>
>>>> Is it possible that some CMA memory might be used by non-movable
>>>> allocation requests?
>>>
>>> Yes.
>>>
>>>
>>>> If so, will CMA somehow become unable to migrate, causing cma_alloc()
>>>> to fail?
>>>
>>>
>>> No, it will cause endless loops in __gup_longterm_locked(). If
>>> non-movable allocation requests return CMA memory,
>>> migrate_longterm_unpinnable_pages() will migrate a CMA page to another
>>> CMA page, which is useless and cause endless loops in
>>> __gup_longterm_locked().
> 
> This is only one perspective. We also need to consider the impact on
> CMA itself. For example,
> when CMA is borrowed by THP, and we need to reclaim it through
> cma_alloc() or dma_alloc_coherent(),
> we must move those pages out to ensure CMA's users can retrieve that
> contiguous memory.
> 
> Currently, CMA's memory is occupied by non-movable pages, meaning we
> can't relocate them.
> As a result, cma_alloc() is more likely to fail.
> 
>>>
>>> backtrace:
>>> pin_user_pages_remote
>>> ----__gup_longterm_locked //cause endless loops in this function
>>> --------__get_user_pages_locked
>>> --------check_and_migrate_movable_pages //always check fail and continue
>>> to migrate
>>> ------------migrate_longterm_unpinnable_pages
>>>
>>>
>>>
>>>
>>>
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
>>>>>           WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>>>
>>>>>           if (likely(pcp_allowed_order(order))) {
>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags &
>>>>> ALLOC_CMA ||
>>>>> +                                               order !=
>>>>> HPAGE_PMD_ORDER) {
>>>>> +                       page = rmqueue_pcplist(preferred_zone, zone,
>>>>> order,
>>>>> +                                               migratetype,
>>>>> alloc_flags);
>>>>> +                       if (likely(page))
>>>>> +                               goto out;
>>>>> +               }
>>>>
>>>> This seems not ideal, because non-CMA THP gets no chance to use PCP.
>>>> But it
>>>> still seems better than causing the failure of CMA allocation.
>>>>
>>>> Is there a possible approach to avoiding adding CMA THP into pcp from
>>>> the first
>>>> beginning? Otherwise, we might need a separate PCP for CMA.
>>>>
>>
>> The vast majority of THP-sized allocations are GFP_MOVABLE, avoiding
>> adding CMA THP into pcp may incur a slight performance penalty.
>>
> 
> But the majority of movable pages aren't CMA, right?

> Do we have an estimate for
> adding back a CMA THP PCP? Will per_cpu_pages introduce a new cacheline, which
> the original intention for THP was to avoid by having only one PCP[1]?
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20220624125423.6126-3-mgorman@techsingularity.net/
> 

The size of struct per_cpu_pages is 256 bytes in current code containing 
commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized 
allocations").
crash> struct per_cpu_pages
struct per_cpu_pages {
     spinlock_t lock;
     int count;
     int high;
     int high_min;
     int high_max;
     int batch;
     u8 flags;
     u8 alloc_factor;
     u8 expire;
     short free_count;
     struct list_head lists[13];
}
SIZE: 256

After revert commit 5d0a661d808f ("mm/page_alloc: use only one PCP list 
for THP-sized allocations"), the size of struct per_cpu_pages is 272 bytes.
crash> struct per_cpu_pages
struct per_cpu_pages {
     spinlock_t lock;
     int count;
     int high;
     int high_min;
     int high_max;
     int batch;
     u8 flags;
     u8 alloc_factor;
     u8 expire;
     short free_count;
     struct list_head lists[15];
}
SIZE: 272

Seems commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for 
THP-sized allocations") decrease one cacheline.

> 
>> Commit 1d91df85f399 takes a similar approach to filter, and I mainly
>> refer to it.
>>
>>
>>>>> +#else
>>>>>                   page = rmqueue_pcplist(preferred_zone, zone, order,
>>>>>                                          migratetype, alloc_flags);
>>>>>                   if (likely(page))
>>>>>                           goto out;
>>>>> +#endif
>>>>>           }
>>>>>
>>>>>           page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
>>>>> --
>>>>> 2.7.4
>>>>
>>>> Thanks
>>>> Barry
>>>>
>>
>>


