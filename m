Return-Path: <linux-kernel+bounces-218610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C24D690C28A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0DB1F2361F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9416133B;
	Tue, 18 Jun 2024 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="qeOybXQo"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC84655F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682152; cv=none; b=pGOIhChCLkODKwl6rLhfSR6GDFcvdliiRWB1f6RJKj2BGknEOg5ivq7avWHIERn538m3dM8YUdojGRaxzu1kqReGG8FetlTVaEOJLZ3b4KUWSCkmxi8DYRCJk95IIFB6iPstn8EVA2+78nerIOiQONWT4NOXJclOYJw/domZaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682152; c=relaxed/simple;
	bh=XUxcd2xrP6BgK+ZWZVncZJUYuhpwuWh+/+DD8Rtq9ho=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZGDyHGHIlwSJ+DvrbBPBAN5XOKXLSyFEmuh2TF1iNakv/jIlO05dYoA7JurfU7zG7jnp0D16e9UnnAdrgVHx6jU6rBdfgQexvQqPSgns5sGIQJL0wUCWAGy6Qyq2ZGY6mH4OaKQUPm1n8mztHI0j2FhTxUPIY7XcAGoZWQmNyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=qeOybXQo; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=QIrPTMY/YwesLH3jlvYihiQmQO6QVdAPAQ9OqtJ8dyI=;
	b=qeOybXQoOix/iVFnwtrjm4DDH+/kahKuTK4JTccj6G/TIPYgb7BovTfx3e6wzu
	PXwwFzXbJPKos/hwaVWzJN79kzFZt9Hlx6Rf5fPh1y91qIaQDA9gP48lhc/CD4Y0
	/hdeqiS8O4wU4GlRYq1+a1K1J6uRuFFGAIKeEYxsppArg=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wD3_12hAXFmHcQhDQ--.15301S2;
	Tue, 18 Jun 2024 11:40:19 +0800 (CST)
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
Message-ID: <ad2fc08b-9b25-d8de-0790-a7eab9bef907@126.com>
Date: Tue, 18 Jun 2024 11:40:17 +0800
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
X-CM-TRANSID:_____wD3_12hAXFmHcQhDQ--.15301S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw17Gr4kuFyxZr4fWFyfJFb_yoW7AFy8pF
	WfG3Waka1UXryUAwnrt3Z0kr10k34rKr48Wr1rXr18urnIyF1Iyr4xJr18uFyrAryUJF40
	qr4UtasxZF4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjEfrUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQsCG2VLayXP7QAAsJ



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

Yes.

> Do we have an estimate for
> adding back a CMA THP PCP? Will per_cpu_pages introduce a new cacheline, which
> the original intention for THP was to avoid by having only one PCP[1]?
> 
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20220624125423.6126-3-mgorman@techsingularity.net/
> 
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


