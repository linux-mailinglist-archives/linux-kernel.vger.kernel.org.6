Return-Path: <linux-kernel+bounces-360599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25806999D11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C351F24A11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA78E209688;
	Fri, 11 Oct 2024 06:50:02 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4C635
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629402; cv=none; b=TKRYEwcusUg/roBnn5fOfJxJ7tNWPaFQeTlsqraOx5CpWwwfpMOPQ0rjI80atdE7+3KPO0naaQK7Faax+JL74m7qzqeRlVKoukNDgRh96x/psfX0CPqEo5hPh9jWuoOYGOQ4FeYDhFSnWo9QRAehDBT2bIzLBPcIRiO4b2t6+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629402; c=relaxed/simple;
	bh=fkCNVi4beL7uAJpakgSpDqd74yYVTxL32a9gaLARANg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NoHHNr6osrpNsEcnzqNrXwQ9FEYM9SN1HW4yhn58JyP/TRNLkiyYtuCWU7/7NLPLdy1yrj5sJym+9UDKOztzADS9b4jBsewhvxuWQMNzrPViXEBxr0OJ/mKD6Lt1uFSLOX1U+SFcDCy6f/lXdiHvMOevEfACvpWlhOLai0Xqyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XPxzY6hF5z1SCS8;
	Fri, 11 Oct 2024 14:48:41 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FAB9140361;
	Fri, 11 Oct 2024 14:49:50 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 11 Oct
 2024 14:49:49 +0800
Message-ID: <62bd2564-76fa-4cb0-9c08-9eb2f96771b6@huawei.com>
Date: Fri, 11 Oct 2024 14:49:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been
 page_out
To: Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
CC: Chen Ridong <chenridong@huaweicloud.com>, <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao
	<yuzhao@google.com>, David Hildenbrand <david@redhat.com>, Matthew Wilcox
	<willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
 <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
 <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/10/11 0:17, Barry Song wrote:
> On Thu, Oct 10, 2024 at 4:59 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>> Hi Ridong,
>>
>> This should be the first version for upstream, and the issue only
>> occurred when large folio is spited.
>>
>> Adding more CCs to see if there's more feedback.
>>
>>
>> On 2024/10/10 16:18, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> An issue was found with the following testing step:
>>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y
>>> 2. Mount memcg v1, and create memcg named test_memcg and set
>>>      usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
>>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.
>>>
>>> It was found that:
>>>
>>> cat memory.usage_in_bytes
>>> 2144940032
>>> cat memory.memsw.usage_in_bytes
>>> 2255056896
>>>
>>> free -h
>>>                 total        used        free
>>> Mem:           31Gi       2.1Gi        27Gi
>>> Swap:         1.0Gi       618Mi       405Mi
>>>
>>> As shown above, the test_memcg used about 100M swap, but 600M+ swap memory
>>> was used, which means that 500M may be wasted because other memcgs can not
>>> use these swap memory.
>>>
>>> It can be explained as follows:
>>> 1. When entering shrink_inactive_list, it isolates folios from lru from
>>>      tail to head. If it just takes folioN from lru(make it simple).
>>>
>>>      inactive lru: folio1<->folio2<->folio3...<->folioN-1
>>>      isolated list: folioN
>>>
>>> 2. In shrink_page_list function, if folioN is THP, it may be splited and
>>>      added to swap cache folio by folio. After adding to swap cache, it will
>>>      submit io to writeback folio to swap, which is asynchronous.
>>>      When shrink_page_list is finished, the isolated folios list will be
>>>      moved back to the head of inactive lru. The inactive lru may just look
>>>      like this, with 512 filioes have been move to the head of inactive lru.
>>>
>>>      folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
>>>
>>> 3. When folio writeback io is completed, the folio may be rotated to tail
>>>      of lru. The following lru list is expected, with those filioes that have
>>>      been added to swap cache are rotated to tail of lru. So those folios
>>>      can be reclaimed as soon as possible.
>>>
>>>      folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>>
>>> 4. However, shrink_page_list and folio writeback are asynchronous. If THP
>>>      is splited, shrink_page_list loops at least 512 times, which means that
>>>      shrink_page_list is not completed but some folios writeback have been
>>>      completed, and this may lead to failure to rotate these folios to the
>>>      tail of lru. The lru may look likes as below:
> 
> I assume you’re referring to PMD-mapped THP, but your code also modifies
> mTHP, which might not be that large. For instance, it could be a 16KB mTHP.
> 
>>>
>>>      folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>>>      folioN51<->folioN52<->...folioN511<->folioN512
>>>
>>>      Although those folios (N1-N50) have been finished writing back, they
>>>      are still at the head of lru. When isolating folios from lru, it scans
>>>      from tail to head, so it is difficult to scan those folios again.
>>>
>>> What mentioned above may lead to a large number of folios have been added
>>> to swap cache but can not be reclaimed in time, which may reduce reclaim
>>> efficiency and prevent other memcgs from using this swap memory even if
>>> they trigger OOM.
>>>
>>> To fix this issue, it's better to stop looping if THP has been splited and
>>> nr_pageout is greater than nr_to_reclaim.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    mm/vmscan.c | 16 +++++++++++++++-
>>>    1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>> index 749cdc110c74..fd8ad251eda2 100644
>>> --- a/mm/vmscan.c
>>> +++ b/mm/vmscan.c
>>> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>        LIST_HEAD(demote_folios);
>>>        unsigned int nr_reclaimed = 0;
>>>        unsigned int pgactivate = 0;
>>> -     bool do_demote_pass;
>>> +     bool do_demote_pass, splited = false;
>>>        struct swap_iocb *plug = NULL;
>>>
>>>        folio_batch_init(&free_folios);
>>> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>
>>>                cond_resched();
>>>
>>> +             /*
>>> +              * If a large folio has been split, many folios are added
>>> +              * to folio_list. Looping through the entire list takes
>>> +              * too much time, which may prevent folios that have completed
>>> +              * writeback from rotateing to the tail of the lru. Just
>>> +              * stop looping if nr_pageout is greater than nr_to_reclaim.
>>> +              */
>>> +             if (unlikely(splited && stat->nr_pageout > sc->nr_to_reclaim))
>>> +                     break;
> 
> I’m not entirely sure about the theory behind comparing stat->nr_pageout
> with sc->nr_to_reclaim. However, the condition might still hold true even
> if you’ve split a relatively small “large folio,” such as 16kB?
> 

Why compare stat->nr_pageout with sc->nr_to_reclaim? It's because if all 
pages that have been pageout can be reclaimed, then enough pages can be 
reclaimed when all pages have finished writeback. Thus, it may not have 
to pageout more.

If a small large folio(16 kB) has been split, it may return early 
without the entire pages in the folio_list being pageout, but I think 
that is fine. It can pageout more pages the next time it enters 
shrink_folio_list if there are not enough pages to reclaimed.

However, if pages that have been pageout are still at the head of the 
LRU, it is difficult to scan these pages again. In this case, not only 
might it "waste" some swap memory but it also has to pageout more pages.

Considering the above, I sent this patch. It may not be a perfect 
solution, but i think it's a good option to consider. And I am wondering 
if anyone has a better solution.

Best regards,
Ridong

>>> +
>>>                folio = lru_to_folio(folio_list);
>>>                list_del(&folio->lru);
>>>
>>> @@ -1273,6 +1283,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>                if ((nr_pages > 1) && !folio_test_large(folio)) {
>>>                        sc->nr_scanned -= (nr_pages - 1);
>>>                        nr_pages = 1;
>>> +                     splited = true;
>>>                }
>>>
>>>                /*
>>> @@ -1375,12 +1386,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>                                if (nr_pages > 1 && !folio_test_large(folio)) {
>>>                                        sc->nr_scanned -= (nr_pages - 1);
>>>                                        nr_pages = 1;
>>> +                                     splited = true;
>>>                                }
>>>                                goto activate_locked;
>>>                        case PAGE_SUCCESS:
>>>                                if (nr_pages > 1 && !folio_test_large(folio)) {
>>>                                        sc->nr_scanned -= (nr_pages - 1);
>>>                                        nr_pages = 1;
>>> +                                     splited = true;
>>>                                }
>>>                                stat->nr_pageout += nr_pages;
>>>
>>> @@ -1491,6 +1504,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>                if (nr_pages > 1) {
>>>                        sc->nr_scanned -= (nr_pages - 1);
>>>                        nr_pages = 1;
>>> +                     splited = true;
>>>                }
>>>    activate_locked:
>>>                /* Not a candidate for swapping, so reclaim swap space. */
>>

