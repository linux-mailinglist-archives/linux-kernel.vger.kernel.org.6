Return-Path: <linux-kernel+bounces-432494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388F29E4C20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A64F16A5B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F92169397;
	Thu,  5 Dec 2024 02:06:32 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE387E105
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733364392; cv=none; b=aeMsZQoUEm5P9aleI82KHve9ll9CejdXAO1cAdHMtGv9Zic14/v6kk3BgYjvvcXFojRHBGr0hBBmqvkq1KW0x9fHXD93j6INDA1/kwkJnnDRwekIAqXJg+OG6uV2irZWNs/cdJ9P3HZHzLAYjWUeijX07cAUHZlPqIhziUpaYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733364392; c=relaxed/simple;
	bh=DWC0ysj+/71aiqHgzVfbzfyZDn2mwRRPppKm4vjDWXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MHXWi4jl+UXPglds/ox420br31sT3bA+wefY2gr/SrLaeQZ6lUVXMXNiZIvJPru78ATV7nyO60QvPNCCmgfYWAdfK56XiIzoE2fa350FVsTA/DXDphcsihR5HaQGBqGwYWbz757VqbpEPFZNxjw8TxDykm1kF1pKyNROwfxHR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Y3d6p2hXMz1yrS9;
	Thu,  5 Dec 2024 10:06:42 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 947081402E1;
	Thu,  5 Dec 2024 10:06:26 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 5 Dec
 2024 10:06:25 +0800
Message-ID: <953e88cb-4c80-43d2-9afb-26150fea2da9@huawei.com>
Date: Thu, 5 Dec 2024 10:06:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] mm: vmscan: retry folios written back while
 isolated
To: Barry Song <21cnbao@gmail.com>, Chen Ridong <chenridong@huaweicloud.com>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <hannes@cmpxchg.org>,
	<yosryahmed@google.com>, <yuzhao@google.com>, <david@redhat.com>,
	<willy@infradead.org>, <ryan.roberts@arm.com>, <wangkefeng.wang@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, <xieym_ict@hotmail.com>
References: <20241204040158.2768519-1-chenridong@huaweicloud.com>
 <20241204040158.2768519-3-chenridong@huaweicloud.com>
 <CAGsJ_4w83823wbqDHta6RGE_3VzHYpLTBDDbzX6sVEN=YSPEKw@mail.gmail.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <CAGsJ_4w83823wbqDHta6RGE_3VzHYpLTBDDbzX6sVEN=YSPEKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/12/4 18:45, Barry Song wrote:
> On Wed, Dec 4, 2024 at 5:11 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> An issue was found with the following testing step:
>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_LRU_GEN_ENABLED=n.
>> 2. Mount memcg v1, and create memcg named test_memcg and set
>>    usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
>> 3. Use file as swap, and create a 1G swap.
>> 4. Allocate 2.2G anon memory in test_memcg.
>>
>> It was found that:
>>
>> cat memory.usage_in_bytes
>> 2144940032
>> cat memory.memsw.usage_in_bytes
>> 2255056896
>>
>> free -h
>>               total        used        free
>> Mem:           31Gi       2.1Gi        27Gi
>> Swap:         1.0Gi       618Mi       405Mi
>>
>> As shown above, the test_memcg used about 100M swap, but 600M+ swap memory
>> was used, which means that 500M may be wasted because other memcgs can not
>> use these swap memory.
>>
>> It can be explained as follows:
>> 1. When entering shrink_inactive_list, it isolates folios from lru from
>>    tail to head. If it just takes folioN from lru(make it simple).
>>
>>    inactive lru: folio1<->folio2<->folio3...<->folioN-1
>>    isolated list: folioN
>>
>> 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
>>    and added to swap cache folio by folio. After adding to swap cache,
>>    it will submit io to writeback folio to swap, which is asynchronous.
>>    When shrink_page_list is finished, the isolated folios list will be
>>    moved back to the head of inactive lru. The inactive lru may just look
>>    like this, with 512 filioes have been move to the head of inactive lru.
>>
>>    folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
>>
>>    It committed io from folioN1 to folioN512, the later folios committed
>>    was added to head of the 'ret_folios' in the shrink_page_list function.
>>    As a result, the order was shown as folioN512->folioN511->...->folioN1.
>>
>> 3. When folio writeback io is completed, the folio may be rotated to tail
>>    of the lru one by one. It's assumed that filioN1,filioN2, ...,filioN512
>>    are completed in order(commit io in this order), and they are rotated to
>>    the tail of the LRU in order (filioN1<->...folioN511<->folioN512).
>>    Therefore, those folios that are tail of the lru will be reclaimed as
>>    soon as possible.
>>
>>    folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>>
>> 4. However, shrink_page_list and folio writeback are asynchronous. If THP
>>    is splited, shrink_page_list loops at least 512 times, which means that
>>    shrink_page_list is not completed but some folios writeback have been
>>    completed, and this may lead to failure to rotate these folios to the
>>    tail of lru. The lru may look likes as below:
>>
>>    folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>>    folioN51<->folioN52<->...folioN511<->folioN512
>>
>>    Although those folios (N1-N50) have been finished writing back, they
>>    are still at the head of the lru. This is because their writeback_end
>>    occurred while it were still looping in shrink_folio_list(), causing
>>    folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
>>    these folios, which are not in the LRU but still in the 'folio_list',
>>    to the tail of the LRU.
>>    When isolating folios from lru, it scans from tail to head, so it is
>>    difficult to scan those folios again.
> 
> I don’t think it’s necessary to focus so much on large folios. This
> issue affects both small and large folios alike. Splitting large
> folios simply lengthens the list, which increases the chances of
> missing rotation. It’s enough to note that commit 359a5e1416ca
> fixed this issue in mglru, but the same problem exists in the
> active/inactive LRU. As a result, we’re extracting the function in
> patch 1 to make it usable for both LRUs and applying the same fix
> to the active/inactive LRU. Mentioning that THP splitting can
> worsen the issue (since it makes the list longer) is sufficient;
> it’s not the main point.
> 
> It’s better to have a single patch and refine the changelog to focus on
> the core and essential problem, avoiding too many unrelated details.
> 

Thank you, will update.

Best regards,
Ridong

>>
>> This issue is fixed when CONFIG_LRU_GEN_ENABLED is enabled with the
>> commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back while
>> isolated"). This issue should be fixed for active/inactive lru in the
>> same way.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  mm/vmscan.c | 35 +++++++++++++++++++++++++++++++++--
>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index af1ff76f83e7..1f0d194f8b2f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1949,6 +1949,25 @@ static int current_may_throttle(void)
>>         return !(current->flags & PF_LOCAL_THROTTLE);
>>  }
>>
>> +static inline void acc_reclaimed_stat(struct reclaim_stat *stat,
>> +               struct reclaim_stat *curr)
>> +{
>> +       int i;
>> +
>> +       stat->nr_dirty += curr->nr_dirty;
>> +       stat->nr_unqueued_dirty += curr->nr_unqueued_dirty;
>> +       stat->nr_congested += curr->nr_congested;
>> +       stat->nr_writeback += curr->nr_writeback;
>> +       stat->nr_immediate += curr->nr_immediate;
>> +       stat->nr_pageout += curr->nr_pageout;
>> +       stat->nr_ref_keep += curr->nr_ref_keep;
>> +       stat->nr_unmap_fail += curr->nr_unmap_fail;
>> +       stat->nr_lazyfree_fail += curr->nr_lazyfree_fail;
>> +       stat->nr_demoted += curr->nr_demoted;
>> +       for (i = 0; i < ANON_AND_FILE; i++)
>> +               stat->nr_activate[i] = curr->nr_activate[i];
>> +}
>> +
>>  /*
>>   * shrink_inactive_list() is a helper for shrink_node().  It returns the number
>>   * of reclaimed pages
>> @@ -1958,14 +1977,16 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>>                 enum lru_list lru)
>>  {
>>         LIST_HEAD(folio_list);
>> +       LIST_HEAD(clean_list);
>>         unsigned long nr_scanned;
>>         unsigned int nr_reclaimed = 0;
>>         unsigned long nr_taken;
>> -       struct reclaim_stat stat;
>> +       struct reclaim_stat stat, curr;
>>         bool file = is_file_lru(lru);
>>         enum vm_event_item item;
>>         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>         bool stalled = false;
>> +       bool skip_retry = false;
>>
>>         while (unlikely(too_many_isolated(pgdat, file, sc))) {
>>                 if (stalled)
>> @@ -1999,10 +2020,20 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>>         if (nr_taken == 0)
>>                 return 0;
>>
>> -       nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
>> +       memset(&stat, 0, sizeof(stat));
>> +retry:
>> +       nr_reclaimed += shrink_folio_list(&folio_list, pgdat, sc, &curr, false);
>> +       find_folios_written_back(&folio_list, &clean_list, skip_retry);
>> +       acc_reclaimed_stat(&stat, &curr);
>>
>>         spin_lock_irq(&lruvec->lru_lock);
>>         move_folios_to_lru(lruvec, &folio_list);
>> +       if (!list_empty(&clean_list)) {
>> +               list_splice_init(&clean_list, &folio_list);
>> +               skip_retry = true;
>> +               spin_unlock_irq(&lruvec->lru_lock);
>> +               goto retry;
>> +       }
>>
>>         __mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
>>                                         stat.nr_demoted);
>> --
>> 2.34.1
>>
> 
> Thanks
> Barry

