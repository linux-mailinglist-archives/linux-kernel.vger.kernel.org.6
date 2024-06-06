Return-Path: <linux-kernel+bounces-203560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B08FDD29
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD872B2101C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC621DA4C;
	Thu,  6 Jun 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GuhBrcCU"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA91BDD5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643196; cv=none; b=QVClmUNDgcfYHW/0ExEg78nxWcqCP0L7Q7/lUI53HsBP1IGWiHRY2t/m8n+cn0QTfJWdNKWVho1M2YJ0bQeoCNTA6yK6sRW+8LxKun23bLlqohTY91ceyMpL9OebFgArn84DUUiOGQEnrQH9Nm1y68uwswkyYIC3fRIUHB1oApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643196; c=relaxed/simple;
	bh=ADcWD5s3SbBgke1vgRZ9Zm3ZPHyg+dBTYX/gcGpNJO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnONEtpZ4YPSmLcjl9Gz/p/E5LB4u5r5c486KHKfwTdhalXc0RRmtv1jaVJD3GOA9hRjvvYtpPBtm/O6djIJSFiAZzoZqhAn/zjAHDZ6/lJaNsueLD6jvRAX0/0bPI/JIMpsvroJ89A/0CBos8d2eOOxZdjdzAeWxe3GdEErDQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GuhBrcCU; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717643185; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5YZZSmIQT3EnCQ697u4wLeqAC6O9xFWtLOr4ccPxfkw=;
	b=GuhBrcCU4E8fBT5QnGjEpOt26tglym485wzQa/M1usmV2cxBrdrhofu3tCuV4Ogz74Fd9Ke7Pe15EbeK+vuYclxhPmpuTTTxViBuNtcf6GWYOjTd77LBz3oHeyViDEyknMzxnmJNqvLMxhPdT1q2gqDww0QY1bPGvi5OV8aFEU4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W7wm0mE_1717643184;
Received: from 30.97.56.72(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7wm0mE_1717643184)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 11:06:25 +0800
Message-ID: <7087d0af-93d8-4d49-94f4-dc846a4e2b98@linux.alibaba.com>
Date: Thu, 6 Jun 2024 11:06:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Zi Yan <ziy@nvidia.com>
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
 <c180d2a0-1e34-41f0-bae8-1205d04a5f6b@linux.alibaba.com>
 <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <82d31425-86d7-16fa-d09b-fcb203de0986@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/4 20:36, yangge1116 wrote:
> 
> 
> 在 2024/6/4 下午8:01, Baolin Wang 写道:
>> Cc Johannes, Zi and Vlastimil.
>>
>> On 2024/6/4 17:14, yangge1116@126.com wrote:
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
>>>       WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>>>       if (likely(pcp_allowed_order(order))) {
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +        if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
>>> +                        order != HPAGE_PMD_ORDER) {
>>
>> Seems you will also miss the non-CMA THP from the PCP, so I wonder if 
>> we can add a migratetype comparison in __rmqueue_pcplist(), and if 
>> it's not suitable, then fallback to buddy?
> 
> Yes, we may miss some non-CMA THPs in the PCP. But, if add a migratetype 
> comparison in __rmqueue_pcplist(), we may need to compare many times 
> because of pcp batch.

I mean we can only compare once, focusing on CMA pages.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3734fe7e67c0..960a3b5744d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2973,6 +2973,11 @@ struct page *__rmqueue_pcplist(struct zone *zone, 
unsigned int order,
                 }

                 page = list_first_entry(list, struct page, pcp_list);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+               if (order == HPAGE_PMD_ORDER && 
!is_migrate_movable(migratetype) &&
+                   is_migrate_cma(get_pageblock_migratetype(page)))
+                       return NULL;
+#endif
                 list_del(&page->pcp_list);
                 pcp->count -= 1 << order;
         } while (check_new_pages(page, order));

