Return-Path: <linux-kernel+bounces-220508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782E90E2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBFD2842D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453D558B6;
	Wed, 19 Jun 2024 05:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XVWu4wKo"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796EC4C635
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775340; cv=none; b=iFvUhsz+u5wsz8xDpGPG8LVtnuyPuRSqdp/VBofyR1yym9ggLU1RN2Qvco4B03faa+Am7iBQMyP5TbL0YOPK+ZmGpfZJ4pGziPMEkZ+XzCiSzahEVnNBh0+9VhSQeE0tq8FMwOMsU/d4Ex6IT6e3hdsyp/TcInd6Pb3DQmItPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775340; c=relaxed/simple;
	bh=qO3hCH9gVFVxTpl9FShLpJv+QDjdnRAmoTaykDBOx24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y6Nt5uBa6qn4bvf1e2R8vSP2qB5Ok0UbweCA/tl+P7lc5U0QGL6blHbThbNoUtG16w/8nIh3tQX7EaKWMjrvvAL8OMKxOMLa/JffB436CKodsLb2cQpyEtO7FZ7JZsbljBy9sZnyofhBINBf8f4gBnkPmj4wFkxrgT1ge8Ni/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XVWu4wKo; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=gp31lDppN9BRxvc/ab3djSle0PEgTybfzF86txTaLA8=;
	b=XVWu4wKo/UwEi0VzCXPufkDbGegz5N/AqbyU0mWlXJEDDojfRPafex8kTT6pci
	u8PJ0xMGT/Jd3vzMgtcmbyHOw8pYKy0X+jbpa/1r+xtg3IgSrKYVcXNh3ZuLEkjO
	Qkdj0Fzl2r8zKFsNlH+cpw2cRj68tOL9/BbO5h6tELpXk=
Received: from [172.21.22.210] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3nzLXbXJmHY0JBw--.30716S2;
	Wed, 19 Jun 2024 13:34:17 +0800 (CST)
Message-ID: <b1b108d5-0008-4681-97cc-253992e18c3b@126.com>
Date: Wed, 19 Jun 2024 13:34:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
From: Ge Yang <yangge1116@126.com>
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
 <69414410-4e2d-c04c-6fc3-9779f9377cf2@126.com>
 <CAGsJ_4xHpHVKwqcSFqRQ_DxsehNh0Wp=P-MTGA2b_iy=KUW1Bw@mail.gmail.com>
 <d082f7e0-cbb9-f21a-e08d-47b5abd9e91d@126.com>
In-Reply-To: <d082f7e0-cbb9-f21a-e08d-47b5abd9e91d@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nzLXbXJmHY0JBw--.30716S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw43AFyUuF4rJr4kJF4kXrb_yoWDWr1rpr
	y8JF17tr4UJryUAw17trn8Ar1jyw17Jr1UXr15Jr18ArnFyr17Ar18tr1UuFy8JryUJF18
	Xr1Utry3Zr1UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jGxRDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRYDG2VLa0hdHwAAsY



在 2024/6/18 15:51, yangge1116 写道:
> 
> 
> 在 2024/6/18 下午2:58, Barry Song 写道:
>> On Tue, Jun 18, 2024 at 6:56 PM yangge1116 <yangge1116@126.com> wrote:
>>>
>>>
>>>
>>> 在 2024/6/18 下午12:10, Barry Song 写道:
>>>> On Tue, Jun 18, 2024 at 3:32 PM yangge1116 <yangge1116@126.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> 在 2024/6/18 上午9:55, Barry Song 写道:
>>>>>> On Tue, Jun 18, 2024 at 9:36 AM yangge1116 <yangge1116@126.com> 
>>>>>> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> 在 2024/6/17 下午8:47, yangge1116 写道:
>>>>>>>>
>>>>>>>>
>>>>>>>> 在 2024/6/17 下午6:26, Barry Song 写道:
>>>>>>>>> On Tue, Jun 4, 2024 at 9:15 PM <yangge1116@126.com> wrote:
>>>>>>>>>>
>>>>>>>>>> From: yangge <yangge1116@126.com>
>>>>>>>>>>
>>>>>>>>>> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP 
>>>>>>>>>> list for
>>>>>>>>>> THP-sized allocations") no longer differentiates the migration 
>>>>>>>>>> type
>>>>>>>>>> of pages in THP-sized PCP list, it's possible to get a CMA 
>>>>>>>>>> page from
>>>>>>>>>> the list, in some cases, it's not acceptable, for example, 
>>>>>>>>>> allocating
>>>>>>>>>> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>>>>>>>>>>
>>>>>>>>>> The patch forbids allocating non-CMA THP-sized page from 
>>>>>>>>>> THP-sized
>>>>>>>>>> PCP list to avoid the issue above.
>>>>>>>>>
>>>>>>>>> Could you please describe the impact on users in the commit log?
>>>>>>>>
>>>>>>>> If a large number of CMA memory are configured in the system (for
>>>>>>>> example, the CMA memory accounts for 50% of the system memory), 
>>>>>>>> starting
>>>>>>>> virtual machine with device passthrough will get stuck.
>>>>>>>>
>>>>>>>> During starting virtual machine, it will call 
>>>>>>>> pin_user_pages_remote(...,
>>>>>>>> FOLL_LONGTERM, ...) to pin memory. If a page is in CMA area,
>>>>>>>> pin_user_pages_remote() will migrate the page from CMA area to 
>>>>>>>> non-CMA
>>>>>>>> area because of FOLL_LONGTERM flag. If non-movable allocation 
>>>>>>>> requests
>>>>>>>> return CMA memory, pin_user_pages_remote() will enter endless 
>>>>>>>> loops.
>>>>>>>>
>>>>>>>> backtrace:
>>>>>>>> pin_user_pages_remote
>>>>>>>> ----__gup_longterm_locked //cause endless loops in this function
>>>>>>>> --------__get_user_pages_locked
>>>>>>>> --------check_and_migrate_movable_pages //always check fail and 
>>>>>>>> continue
>>>>>>>> to migrate
>>>>>>>> ------------migrate_longterm_unpinnable_pages
>>>>>>>> ----------------alloc_migration_target // non-movable allocation
>>>>>>>>
>>>>>>>>> Is it possible that some CMA memory might be used by non-movable
>>>>>>>>> allocation requests?
>>>>>>>>
>>>>>>>> Yes.
>>>>>>>>
>>>>>>>>
>>>>>>>>> If so, will CMA somehow become unable to migrate, causing 
>>>>>>>>> cma_alloc()
>>>>>>>>> to fail?
>>>>>>>>
>>>>>>>>
>>>>>>>> No, it will cause endless loops in __gup_longterm_locked(). If
>>>>>>>> non-movable allocation requests return CMA memory,
>>>>>>>> migrate_longterm_unpinnable_pages() will migrate a CMA page to 
>>>>>>>> another
>>>>>>>> CMA page, which is useless and cause endless loops in
>>>>>>>> __gup_longterm_locked().
>>>>>>
>>>>>> This is only one perspective. We also need to consider the impact on
>>>>>> CMA itself. For example,
>>>>>> when CMA is borrowed by THP, and we need to reclaim it through
>>>>>> cma_alloc() or dma_alloc_coherent(),
>>>>>> we must move those pages out to ensure CMA's users can retrieve that
>>>>>> contiguous memory.
>>>>>>
>>>>>> Currently, CMA's memory is occupied by non-movable pages, meaning we
>>>>>> can't relocate them.
>>>>>> As a result, cma_alloc() is more likely to fail.
>>>>>>
>>>>>>>>
>>>>>>>> backtrace:
>>>>>>>> pin_user_pages_remote
>>>>>>>> ----__gup_longterm_locked //cause endless loops in this function
>>>>>>>> --------__get_user_pages_locked
>>>>>>>> --------check_and_migrate_movable_pages //always check fail and 
>>>>>>>> continue
>>>>>>>> to migrate
>>>>>>>> ------------migrate_longterm_unpinnable_pages
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>>>>>>>> THP-sized allocations")
>>>>>>>>>> Signed-off-by: yangge <yangge1116@126.com>
>>>>>>>>>> ---
>>>>>>>>>>      mm/page_alloc.c | 10 ++++++++++
>>>>>>>>>>      1 file changed, 10 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>>>> index 2e22ce5..0bdf471 100644
>>>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>>>> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone
>>>>>>>>>> *preferred_zone,
>>>>>>>>>>             WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order 
>>>>>>>>>> > 1));
>>>>>>>>>>
>>>>>>>>>>             if (likely(pcp_allowed_order(order))) {
>>>>>>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>>>>>> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags &
>>>>>>>>>> ALLOC_CMA ||
>>>>>>>>>> +                                               order !=
>>>>>>>>>> HPAGE_PMD_ORDER) {
>>>>>>>>>> +                       page = rmqueue_pcplist(preferred_zone, 
>>>>>>>>>> zone,
>>>>>>>>>> order,
>>>>>>>>>> +                                               migratetype,
>>>>>>>>>> alloc_flags);
>>>>>>>>>> +                       if (likely(page))
>>>>>>>>>> +                               goto out;
>>>>>>>>>> +               }
>>>>>>>>>
>>>>>>>>> This seems not ideal, because non-CMA THP gets no chance to use 
>>>>>>>>> PCP.
>>>>>>>>> But it
>>>>>>>>> still seems better than causing the failure of CMA allocation.
>>>>>>>>>
>>>>>>>>> Is there a possible approach to avoiding adding CMA THP into 
>>>>>>>>> pcp from
>>>>>>>>> the first
>>>>>>>>> beginning? Otherwise, we might need a separate PCP for CMA.
>>>>>>>>>
>>>>>>>
>>>>>>> The vast majority of THP-sized allocations are GFP_MOVABLE, avoiding
>>>>>>> adding CMA THP into pcp may incur a slight performance penalty.
>>>>>>>
>>>>>>
>>>>>> But the majority of movable pages aren't CMA, right?
>>>>>
>>>>>> Do we have an estimate for
>>>>>> adding back a CMA THP PCP? Will per_cpu_pages introduce a new 
>>>>>> cacheline, which
>>>>>> the original intention for THP was to avoid by having only one 
>>>>>> PCP[1]?
>>>>>>
>>>>>> [1] 
>>>>>> https://patchwork.kernel.org/project/linux-mm/patch/20220624125423.6126-3-mgorman@techsingularity.net/
>>>>>>
>>>>>
>>>>> The size of struct per_cpu_pages is 256 bytes in current code 
>>>>> containing
>>>>> commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for 
>>>>> THP-sized
>>>>> allocations").
>>>>> crash> struct per_cpu_pages
>>>>> struct per_cpu_pages {
>>>>>        spinlock_t lock;
>>>>>        int count;
>>>>>        int high;
>>>>>        int high_min;
>>>>>        int high_max;
>>>>>        int batch;
>>>>>        u8 flags;
>>>>>        u8 alloc_factor;
>>>>>        u8 expire;
>>>>>        short free_count;
>>>>>        struct list_head lists[13];
>>>>> }
>>>>> SIZE: 256
>>>>>
>>>>> After revert commit 5d0a661d808f ("mm/page_alloc: use only one PCP 
>>>>> list
>>>>> for THP-sized allocations"), the size of struct per_cpu_pages is 
>>>>> 272 bytes.
>>>>> crash> struct per_cpu_pages
>>>>> struct per_cpu_pages {
>>>>>        spinlock_t lock;
>>>>>        int count;
>>>>>        int high;
>>>>>        int high_min;
>>>>>        int high_max;
>>>>>        int batch;
>>>>>        u8 flags;
>>>>>        u8 alloc_factor;
>>>>>        u8 expire;
>>>>>        short free_count;
>>>>>        struct list_head lists[15];
>>>>> }
>>>>> SIZE: 272
>>>>>
>>>>> Seems commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
>>>>> THP-sized allocations") decrease one cacheline.
>>>>
>>>> the proposal is not reverting the patch but adding one CMA pcp.
>>>> so it is "struct list_head lists[14]"; in this case, the size is still
>>>> 256?
>>>>
>>>
>>> Yes, the size is still 256. If add one PCP list, we will have 2 PCP
>>> lists for THP. One PCP list is used by MIGRATE_UNMOVABLE, and the other
>>> PCP list is used by MIGRATE_MOVABLE and MIGRATE_RECLAIMABLE. Is that 
>>> right?
>>
>> i am not quite sure about MIGRATE_RECLAIMABLE as we want to
>> CMA is only used by movable.
>> So it might be:
>> MOVABLE and NON-MOVABLE.
> 
> One PCP list is used by UNMOVABLE pages, and the other PCP list is used 
> by MOVABLE pages, seems it is feasible. UNMOVABLE PCP list contains 
> MIGRATE_UNMOVABLE pages and MIGRATE_RECLAIMABLE pages, and MOVABLE PCP 
> list contains MIGRATE_MOVABLE pages.
> 

Is the following modification feasiable?

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_PCP_THP 1
+#define NR_PCP_THP 2
+#define PCP_THP_MOVABLE 0
+#define PCP_THP_UNMOVABLE 1
  #else
  #define NR_PCP_THP 0
  #endif

  static inline unsigned int order_to_pindex(int migratetype, int order)
  {
+       int pcp_type = migratetype;
+
  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
         if (order > PAGE_ALLOC_COSTLY_ORDER) {
                 VM_BUG_ON(order != HPAGE_PMD_ORDER);
-               return NR_LOWORDER_PCP_LISTS;
+
+               if (migratetype != MIGRATE_MOVABLE)
+                       pcp_type = PCP_THP_UNMOVABLE;
+               else
+                       pcp_type = PCP_THP_MOVABLE;
+
+               return NR_LOWORDER_PCP_LISTS + pcp_type;
         }
  #else
         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
  #endif

-       return (MIGRATE_PCPTYPES * order) + migratetype;
+       return (MIGRATE_PCPTYPES * order) + pcp_type;
  }



@@ -521,7 +529,7 @@ static inline int pindex_to_order(unsigned int pindex)
         int order = pindex / MIGRATE_PCPTYPES;

  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-       if (pindex == NR_LOWORDER_PCP_LISTS)
+       if (order > PAGE_ALLOC_COSTLY_ORDER)
                 order = HPAGE_PMD_ORDER;
  #else
         VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);



>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> Commit 1d91df85f399 takes a similar approach to filter, and I mainly
>>>>>>> refer to it.
>>>>>>>
>>>>>>>
>>>>>>>>>> +#else
>>>>>>>>>>                     page = rmqueue_pcplist(preferred_zone, 
>>>>>>>>>> zone, order,
>>>>>>>>>>                                            migratetype, 
>>>>>>>>>> alloc_flags);
>>>>>>>>>>                     if (likely(page))
>>>>>>>>>>                             goto out;
>>>>>>>>>> +#endif
>>>>>>>>>>             }
>>>>>>>>>>
>>>>>>>>>>             page = rmqueue_buddy(preferred_zone, zone, order, 
>>>>>>>>>> alloc_flags,
>>>>>>>>>> -- 
>>>>>>>>>> 2.7.4
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> Barry
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>
>>>


