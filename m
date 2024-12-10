Return-Path: <linux-kernel+bounces-438966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECD69EA8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE970163158
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8F22B8DF;
	Tue, 10 Dec 2024 06:41:34 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC4A22617C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733812893; cv=none; b=LDsUEn4yVJr4/EpsAiQt68AuoRaPUeFfPQBB8BnAYCRZ8KpFMcrmNsf/GR+WOfc+r23TIN9iW9N5+tk9pHtUyS5P/UJFxgC9ecUZYlla8+/u00bJb2t+Vv93oGP87FEDJEseR9yEshqjUMEogy6pkn0vmI6UVXgRMF/vNpfxMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733812893; c=relaxed/simple;
	bh=DfoUGsWnxSbUN2hqVLVZgC4RoSduhOARzat7Qx2b7MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AUSVf8Y6RsjJtknSJRWFmJbJgl++5Dm0CzM/2TsL5xR9XIWmbqiXBeheuP2TAoTDPGLd8AvoHw1ATxEx27V+oo3DokX8cRiPRwFMHsBpP39fzoWpeEAF9GC9igRN7D+xt5wxx5ZLjPu1NL41D4khqfjV9jzjNd/Vj8PI93mNTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y6pz641Y5z1JCk8;
	Tue, 10 Dec 2024 14:41:06 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B82C140136;
	Tue, 10 Dec 2024 14:41:20 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 10 Dec
 2024 14:41:19 +0800
Message-ID: <13223d50-6218-49db-8356-700a1907e224@huawei.com>
Date: Tue, 10 Dec 2024 14:41:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] mm: vmascan: retry folios written back while
 isolated for traditional LRU
To: Barry Song <21cnbao@gmail.com>, Chen Ridong <chenridong@huaweicloud.com>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <hannes@cmpxchg.org>,
	<yosryahmed@google.com>, <yuzhao@google.com>, <david@redhat.com>,
	<willy@infradead.org>, <ryan.roberts@arm.com>, <wangkefeng.wang@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangweiyang2@huawei.com>, <xieym_ict@hotmail.com>
References: <20241209083618.2889145-1-chenridong@huaweicloud.com>
 <20241209083618.2889145-2-chenridong@huaweicloud.com>
 <CAGsJ_4wuy5Nhn0pdoz7YvzTXs9LCUrpxT5c4+Hd7-DGH3yBsog@mail.gmail.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <CAGsJ_4wuy5Nhn0pdoz7YvzTXs9LCUrpxT5c4+Hd7-DGH3yBsog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/12/10 12:54, Barry Song wrote:
> On Mon, Dec 9, 2024 at 4:46 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back
>> while isolated") only fixed the issue for mglru. However, this issue
>> also exists in the traditional active/inactive LRU. This issue will be
>> worse if THP is split, which makes the list longer and needs longer time
>> to finish a batch of folios reclaim.
>>
>> This issue should be fixed in the same way for the traditional LRU.
>> Therefore, the common logic was extracted to the 'find_folios_written_back'
>> function firstly, which is then reused in the 'shrink_inactive_list'
>> function. Finally, retry reclaiming those folios that may have missed the
>> rotation for traditional LRU.
> 
> let's drop the cover-letter and refine the changelog.
> 
Will update.

>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  include/linux/mmzone.h |   3 +-
>>  mm/vmscan.c            | 108 +++++++++++++++++++++++++++++------------
>>  2 files changed, 77 insertions(+), 34 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index b36124145a16..47c6e8c43dcd 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -391,6 +391,7 @@ struct page_vma_mapped_walk;
>>
>>  #define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
>>  #define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
>> +#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_workingset))
>>
>>  #ifdef CONFIG_LRU_GEN
>>
>> @@ -406,8 +407,6 @@ enum {
>>         NR_LRU_GEN_CAPS
>>  };
>>
>> -#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_workingset))
>> -
>>  #define MIN_LRU_BATCH          BITS_PER_LONG
>>  #define MAX_LRU_BATCH          (MIN_LRU_BATCH * 64)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 76378bc257e3..1f0d194f8b2f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -283,6 +283,48 @@ static void set_task_reclaim_state(struct task_struct *task,
>>         task->reclaim_state = rs;
>>  }
>>
>> +/**
>> + * find_folios_written_back - Find and move the written back folios to a new list.
>> + * @list: filios list
>> + * @clean: the written back folios list
>> + * @skip: whether skip to move the written back folios to clean list.
>> + */
>> +static inline void find_folios_written_back(struct list_head *list,
>> +               struct list_head *clean, bool skip)
>> +{
>> +       struct folio *folio;
>> +       struct folio *next;
>> +
>> +       list_for_each_entry_safe_reverse(folio, next, list, lru) {
>> +               if (!folio_evictable(folio)) {
>> +                       list_del(&folio->lru);
>> +                       folio_putback_lru(folio);
>> +                       continue;
>> +               }
>> +
>> +               if (folio_test_reclaim(folio) &&
>> +                   (folio_test_dirty(folio) || folio_test_writeback(folio))) {
>> +                       /* restore LRU_REFS_FLAGS cleared by isolate_folio() */
>> +                       if (lru_gen_enabled() && folio_test_workingset(folio))
>> +                               folio_set_referenced(folio);
>> +                       continue;
>> +               }
>> +
>> +               if (skip || folio_test_active(folio) || folio_test_referenced(folio) ||
>> +                   folio_mapped(folio) || folio_test_locked(folio) ||
>> +                   folio_test_dirty(folio) || folio_test_writeback(folio)) {
>> +                       /* don't add rejected folios to the oldest generation */
>> +                       if (lru_gen_enabled())
>> +                               set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS,
>> +                                             BIT(PG_active));
>> +                       continue;
>> +               }
>> +
>> +               /* retry folios that may have missed folio_rotate_reclaimable() */
>> +               list_move(&folio->lru, clean);
>> +       }
>> +}
>> +
>>  /*
>>   * flush_reclaim_state(): add pages reclaimed outside of LRU-based reclaim to
>>   * scan_control->nr_reclaimed.
>> @@ -1907,6 +1949,25 @@ static int current_may_throttle(void)
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
> 
> you had no this before, what's the purpose of this？
> 

We may call shrink_folio_list twice, and the 'stat curr' will reset in
the shrink_folio_list function. We should accumulate the stats as a
whole, which will then be used to calculate the cost and return it to
the caller.

Thanks,
Ridong

>> +
>>  /*
>>   * shrink_inactive_list() is a helper for shrink_node().  It returns the number
>>   * of reclaimed pages
>> @@ -1916,14 +1977,16 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
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
>> @@ -1957,10 +2020,20 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
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
>> @@ -4567,8 +4640,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>         int reclaimed;
>>         LIST_HEAD(list);
>>         LIST_HEAD(clean);
>> -       struct folio *folio;
>> -       struct folio *next;
>>         enum vm_event_item item;
>>         struct reclaim_stat stat;
>>         struct lru_gen_mm_walk *walk;
>> @@ -4597,34 +4668,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>                         scanned, reclaimed, &stat, sc->priority,
>>                         type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>>
>> -       list_for_each_entry_safe_reverse(folio, next, &list, lru) {
>> -               if (!folio_evictable(folio)) {
>> -                       list_del(&folio->lru);
>> -                       folio_putback_lru(folio);
>> -                       continue;
>> -               }
>> -
>> -               if (folio_test_reclaim(folio) &&
>> -                   (folio_test_dirty(folio) || folio_test_writeback(folio))) {
>> -                       /* restore LRU_REFS_FLAGS cleared by isolate_folio() */
>> -                       if (folio_test_workingset(folio))
>> -                               folio_set_referenced(folio);
>> -                       continue;
>> -               }
>> -
>> -               if (skip_retry || folio_test_active(folio) || folio_test_referenced(folio) ||
>> -                   folio_mapped(folio) || folio_test_locked(folio) ||
>> -                   folio_test_dirty(folio) || folio_test_writeback(folio)) {
>> -                       /* don't add rejected folios to the oldest generation */
>> -                       set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_REFS_FLAGS,
>> -                                     BIT(PG_active));
>> -                       continue;
>> -               }
>> -
>> -               /* retry folios that may have missed folio_rotate_reclaimable() */
>> -               list_move(&folio->lru, &clean);
>> -       }
>> -
>> +       find_folios_written_back(&list, &clean, skip_retry);
>>         spin_lock_irq(&lruvec->lru_lock);
>>
>>         move_folios_to_lru(lruvec, &list);
>> --
>> 2.34.1
>>
> 
> Thanks
> Barry
> 
>>

