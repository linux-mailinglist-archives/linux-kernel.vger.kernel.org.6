Return-Path: <linux-kernel+bounces-218607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA290C281
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5C21C20F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9702481A3;
	Tue, 18 Jun 2024 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="iGKPY3bM"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE833C9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681554; cv=none; b=S28hgsLHkO3RZ5pFi2OTiCllmrkEflscieG1/uDKzklWj73sXn/tKBMZFC2oreNej+l69IF+jO9CVeLU6nkMNkRRj1pciBfDo5nwtYPHkBbjH9qG4lpweKLfgTkWzSzOP5xI/ryvo9weO37dtlLHgSBkIUyKq186h9Bg0PYowrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681554; c=relaxed/simple;
	bh=X+kk2nkWiou/MzfRQmjxR5XdgZhFzElYxCidLMKbxsw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HgiiRWkm1PkiEqkDFDKvH4wL7cDtaJvo1NtG4QC44VgKWohVFIvZ6v85jXvh94EuH01KXTlVhBAvE/Jrt0dBJGYQ1VPdSoWcPwDqcKABWl8RbYDLVLPOd0Vz9Y1VlfIn8ZLmspHi0llwgc61yO/p77w7LXtwaWZSKArgeNHL+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=iGKPY3bM; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=vHsJF5wp2r69V/iuhQZOR/0eg3076+0uu7SPU4sU6c4=;
	b=iGKPY3bMliEgNW804a7rkDA4zEeCLQHkdBMWnZ4fj/JkMtn08S8q1SSpFn4Dck
	PzDct0lsi53efO7/6cXe0Yiq7s8foqdLfDRrCRYIDRjq5tvD+Up6dy/RD4niYgOX
	lw74R3rLFE1xjRGgnVWzjh6QCgZ24BR7iaiQHPd8i5oBs=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnTxer_3BmGKLiBg--.18575S2;
	Tue, 18 Jun 2024 11:31:56 +0800 (CST)
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: Barry Song <21cnbao@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, liuzixing@hygon.cn,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
 <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
 <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
 <CAGsJ_4xgqDrTsQRYB_VKn+KC6rvYeJF6TQwhT5JnLi-b4nFTOQ@mail.gmail.com>
 <6dc8df31-eb01-4382-8467-c5510f75531e@linux.alibaba.com>
 <CAGsJ_4zOOK0-AiLsN0Sw_q3ikPNuk8ofZHsYfV1WkK_6-QsmVw@mail.gmail.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <163d69f4-3e66-f1b8-87c5-d58cd0c1b18f@126.com>
Date: Tue, 18 Jun 2024 11:31:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4zOOK0-AiLsN0Sw_q3ikPNuk8ofZHsYfV1WkK_6-QsmVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTxer_3BmGKLiBg--.18575S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtFWDWw45XrWDXF1xJFW3Awb_yoW7Xw18pF
	W8C3W2yF4UJ345Ary7twn0kr4akws7KF15Xr48XryUZrnIyrWxCFn7tr15uFy0vr9rAr10
	qrWqgryfZF4jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjSdkUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWR4CG2VLayWeQQAAsh



在 2024/6/17 下午7:55, Barry Song 写道:
> On Mon, Jun 17, 2024 at 7:36 PM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/6/17 18:43, Barry Song wrote:
>>> On Thu, Jun 6, 2024 at 3:07 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/6/4 20:36, yangge1116 wrote:
>>>>>
>>>>>
>>>>> 在 2024/6/4 下午8:01, Baolin Wang 写道:
>>>>>> Cc Johannes, Zi and Vlastimil.
>>>>>>
>>>>>> On 2024/6/4 17:14, yangge1116@126.com wrote:
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
>>>>>>>         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>>>>>         if (likely(pcp_allowed_order(order))) {
>>>>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>>>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
>>>>>>> +                        order != HPAGE_PMD_ORDER) {
>>>>>>
>>>>>> Seems you will also miss the non-CMA THP from the PCP, so I wonder if
>>>>>> we can add a migratetype comparison in __rmqueue_pcplist(), and if
>>>>>> it's not suitable, then fallback to buddy?
>>>>>
>>>>> Yes, we may miss some non-CMA THPs in the PCP. But, if add a migratetype
>>>>> comparison in __rmqueue_pcplist(), we may need to compare many times
>>>>> because of pcp batch.
>>>>
>>>> I mean we can only compare once, focusing on CMA pages.
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 3734fe7e67c0..960a3b5744d8 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -2973,6 +2973,11 @@ struct page *__rmqueue_pcplist(struct zone *zone,
>>>> unsigned int order,
>>>>                    }
>>>>
>>>>                    page = list_first_entry(list, struct page, pcp_list);
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +               if (order == HPAGE_PMD_ORDER &&
>>>> !is_migrate_movable(migratetype) &&
>>>> +                   is_migrate_cma(get_pageblock_migratetype(page)))
>>>> +                       return NULL;
>>>> +#endif
>>>
>>> This doesn't seem ideal either. It's possible that the PCP still has many
>>> non-CMA folios, but due to bad luck, the first entry is "always" CMA.
>>> In this case,
>>> allocations with is_migrate_movable(migratetype) == false will always lose the
>>> chance to use the PCP.   It also appears to incur a PCP spin lock/unlock.
>>
>> Yes, just some ideas to to mitigate the issue...
>>
>>>
>>> I don't see an ideal solution unless we bring back the CMA PCP :-)
>>
>> Tend to agree, and adding a CMA PCP seems the overhead can be acceptable?
> 
> yes. probably. Hi Ge,
> 
> Could we printk the size before and after adding 1 to NR_PCP_LISTS?
> Does it increase one cacheline?
> 
> struct per_cpu_pages {
> spinlock_t lock; /* Protects lists field */
> int count; /* number of pages in the list */
> int high; /* high watermark, emptying needed */
> int high_min; /* min high watermark */
> int high_max; /* max high watermark */
> int batch; /* chunk size for buddy add/remove */
> u8 flags; /* protected by pcp->lock */
> u8 alloc_factor; /* batch scaling factor during allocate */
> #ifdef CONFIG_NUMA
> u8 expire; /* When 0, remote pagesets are drained */
> #endif
> short free_count; /* consecutive free count */
> 
> /* Lists of pages, one per migrate type stored on the pcp-lists */
> struct list_head lists[NR_PCP_LISTS];
> } ____cacheline_aligned_in_smp;
> 

OK.

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


