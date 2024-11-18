Return-Path: <linux-kernel+bounces-412341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1BD9D07D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B07A1F218EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF428373;
	Mon, 18 Nov 2024 02:18:22 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B2EAE7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731896301; cv=none; b=LJ+8mDMDZovlAn0UD4z28CWZPo8pgbQi4xotjhgEToJy7iKABzkOs8WKpNAI5ugjKtRz0Ob4HYWNdg9oZHh2lyJcy/gLH84P45f2WiCIwrQXcJ98cLmvCHRG1+0lXnYExsxENGSrYIJ+LGcvtJ2PgC1gt1Acnd1ouhBQ0nTbCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731896301; c=relaxed/simple;
	bh=JCKFyUCbNVn/oJilIMpC17dRb5Md7aq7XF/E4hy0BuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFReiwNiYJM4MZ+h6kOvOuNYdVjj4/Aym2oiNGi/X4acAuN5LiIkg3/T6lnvZn6heAztOqAUBdD74zMg1PirFtS/udxh/c3ie/V6xWx7SMt9lGVZfssOl5KpA4ZOBhS5b5Tsq5ORDeWVeBB68u2JxOdS89DNNGhr0mPtgunAzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XsB9X4R3qz4f3kFQ
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:17:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0EACF1A0197
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:18:11 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCXvoLhozpnYgplCA--.33780S2;
	Mon, 18 Nov 2024 10:18:10 +0800 (CST)
Message-ID: <87a2cbce-bbb4-4ff4-a156-c519b91130d0@huaweicloud.com>
Date: Mon, 18 Nov 2024 10:18:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org,
 yosryahmed@google.com, yuzhao@google.com, david@redhat.com,
 willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chenridong@huawei.com,
 wangweiyang2@huawei.com, xieym_ict@hotmail.com
References: <20241116091658.1983491-1-chenridong@huaweicloud.com>
 <20241116091658.1983491-2-chenridong@huaweicloud.com>
 <CAGsJ_4zdVyxh4ka7q8PA2Wi_ZPpjY_sv_bGS9E9NP_vpAFLOHg@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAGsJ_4zdVyxh4ka7q8PA2Wi_ZPpjY_sv_bGS9E9NP_vpAFLOHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXvoLhozpnYgplCA--.33780S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Cw48KFW7CF15JrWxWr17KFg_yoWktw15pF
	Z8GanFkFWkJr13tr13JFs0gryFkrW8Xr1UAF43ur12yF13uw1kKFW7G3y0vFW5Ar1kAF4x
	ZF4DJr95uan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/11/17 11:26, Barry Song wrote:
> On Sat, Nov 16, 2024 at 10:26 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
>>
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> An issue was found with the following testing step:
>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y
>> 2. Mount memcg v1, and create memcg named test_memcg and set
>>    usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.
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
>>
>> What mentioned above may lead to a large number of folios have been added
>> to swap cache but can not be reclaimed in time, which may reduce reclaim
>> efficiency and prevent other memcgs from using this swap memory even if
>> they trigger OOM.
>>
>> To fix this issue, the folios whose writeback has been completed should be
>> move to the tail of the LRU instead of always placing them at the head of
>> the LRU when the shrink_page_list is finished. It can be realized by
>> following steps.
>> 1. In the shrink_page_list function, the folios whose are committed to
> 
> It seems like there's a grammatical error here—whose something？
> 
>>    are added to the head of 'folio_list', which will be return to the
>>    caller.
>> 2. When shrink_page_list finishes, it is known that how many folios have
>>    been pageout, and they are all at the head of 'folio_list', which is
>>    ready be moved back to LRU. So, in the 'move_folios_to_lru function'
>>    function, if the first 'nr_io' folios (which have been pageout) have
>>    been written back completely, move them to the tail of LRU. Otherwise,
>>    move them to the head of the LRU.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>  mm/vmscan.c | 37 +++++++++++++++++++++++++++++--------
>>  1 file changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 76378bc257e3..04f7eab9d818 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1046,6 +1046,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>         struct folio_batch free_folios;
>>         LIST_HEAD(ret_folios);
>>         LIST_HEAD(demote_folios);
>> +       LIST_HEAD(pageout_folios);
>>         unsigned int nr_reclaimed = 0;
>>         unsigned int pgactivate = 0;
>>         bool do_demote_pass;
>> @@ -1061,7 +1062,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                 struct address_space *mapping;
>>                 struct folio *folio;
>>                 enum folio_references references = FOLIOREF_RECLAIM;
>> -               bool dirty, writeback;
>> +               bool dirty, writeback, is_pageout = false;
>>                 unsigned int nr_pages;
>>
>>                 cond_resched();
>> @@ -1384,6 +1385,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>                                         nr_pages = 1;
>>                                 }
>>                                 stat->nr_pageout += nr_pages;
>> +                               is_pageout = true;
>>
>>                                 if (folio_test_writeback(folio))
>>                                         goto keep;
>> @@ -1508,7 +1510,10 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>  keep_locked:
>>                 folio_unlock(folio);
>>  keep:
>> -               list_add(&folio->lru, &ret_folios);
>> +               if (is_pageout)
>> +                       list_add(&folio->lru, &pageout_folios);
>> +               else
>> +                       list_add(&folio->lru, &ret_folios);
>>                 VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
>>                                 folio_test_unevictable(folio), folio);
>>         }
>> @@ -1551,6 +1556,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>         free_unref_folios(&free_folios);
>>
>>         list_splice(&ret_folios, folio_list);
>> +       list_splice(&pageout_folios, folio_list);
> 
> Do we really need this pageout_folios list? is the below not sufficient?
> 
>  +               if (nr_io > 0 &&
>  +                   !folio_test_reclaim(folio) &&
>  +                   !folio_test_writeback(folio))
>  +                       lruvec_add_folio_tail(lruvec, folio);
>  +               else
>  +                       lruvec_add_folio(lruvec, folio);
> 

Thank you for your reply.
I think this is indeed. We want move the written-back folios to the tail
of the LRU so that them can be scanned as soon as possible to be reclaimed.

How can we know the folios have been paged out and written-back in the
move_folios_to_lru function?

It was set to 'folio_set_reclaim(folio)' when the folios were paged-out,
and it was set to 'folio_test_set_writeback(folio)' before committing
io. The 'pageout_folios' can inform the caller those folios have been
paged-out and '!folio_test_reclaim(folio) &&
!folio_test_writeback(folio)' can determine whether those folios have
been written-back.

If we don't add 'pageout_folios' here, we can only use
'!folio_test_reclaim(folio) && !folio_test_writeback(folio)' to
determine move the folios to the tail or not. This could result in
mistakenly moving those folios—which have not been paged out, but for
which the 'PG_writeback' and 'PG_reclaim' flags are not set—to the tail
of the LRU. This may lead to repeatedly scanning the same folios.


>>         count_vm_events(PGACTIVATE, pgactivate);
>>
>>         if (plug)
>> @@ -1826,11 +1832,14 @@ static bool too_many_isolated(struct pglist_data *pgdat, int file,
>>
>>  /*
>>   * move_folios_to_lru() moves folios from private @list to appropriate LRU list.
>> + * @lruvec: The LRU vector the list is moved to.
>> + * @list: The folio list are moved to lruvec
>> + * @nr_io: The first nr folios of the list that have been committed io.
>>   *
>>   * Returns the number of pages moved to the given lruvec.
>>   */
>>  static unsigned int move_folios_to_lru(struct lruvec *lruvec,
>> -               struct list_head *list)
>> +               struct list_head *list, unsigned int nr_io)
>>  {
>>         int nr_pages, nr_moved = 0;
>>         struct folio_batch free_folios;
>> @@ -1880,9 +1889,21 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
>>                  * inhibits memcg migration).
>>                  */
>>                 VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), folio);
>> -               lruvec_add_folio(lruvec, folio);
>> +               /*
>> +                * If the folio have been committed io and writed back completely,
>> +                * it should be added to the tailed to the lru, so it can
>> +                * be relaimed as soon as possible.
>> +                */
>> +               if (nr_io > 0 &&
>> +                   !folio_test_reclaim(folio) &&
>> +                   !folio_test_writeback(folio))
>> +                       lruvec_add_folio_tail(lruvec, folio);
>> +               else
>> +                       lruvec_add_folio(lruvec, folio);
>> +
>>                 nr_pages = folio_nr_pages(folio);
>>                 nr_moved += nr_pages;
>> +               nr_io = nr_io > nr_pages ? (nr_io - nr_pages) : 0;
>>                 if (folio_test_active(folio))
>>                         workingset_age_nonresident(lruvec, nr_pages);
>>         }
>> @@ -1960,7 +1981,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
>>         nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
>>
>>         spin_lock_irq(&lruvec->lru_lock);
>> -       move_folios_to_lru(lruvec, &folio_list);
>> +       move_folios_to_lru(lruvec, &folio_list, stat.nr_pageout);
>>
>>         __mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
>>                                         stat.nr_demoted);
>> @@ -2111,8 +2132,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
>>          */
>>         spin_lock_irq(&lruvec->lru_lock);
>>
>> -       nr_activate = move_folios_to_lru(lruvec, &l_active);
>> -       nr_deactivate = move_folios_to_lru(lruvec, &l_inactive);
>> +       nr_activate = move_folios_to_lru(lruvec, &l_active, 0);
>> +       nr_deactivate = move_folios_to_lru(lruvec, &l_inactive, 0);
>>
>>         __count_vm_events(PGDEACTIVATE, nr_deactivate);
>>         __count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
>> @@ -4627,7 +4648,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>>
>>         spin_lock_irq(&lruvec->lru_lock);
>>
>> -       move_folios_to_lru(lruvec, &list);
>> +       move_folios_to_lru(lruvec, &list, 0);
> 
> I'm not entirely convinced about using the 'nr' argument here.
> Is the goal to differentiate between two cases?
> 1. we need to take care of written-back folios
> 2. we don't need to take care of written-back folios?
> 

The 'isolate_lru_folios' scans the LRU from the tail to the head. If the
folios have been scanned for shrinking, they are moved to the head of
the LRU to prevent repeated scanning. Only folios that have been paged
out and written back should be moved to the tail of the LRU, so they can
be reclaimed the next time they are scanned.

However, if these folios have been paged out but not yet written back,
they should be moved to the head of the LRU. They will then be moved to
the tail of the LRU 'when folio_end_writeback()'s
folio_rotate_reclaimable()' is invoked.

For those folios that have not been paged out, if they cannot be
reclaimed, they should be moved to the head of the LRU to avoid repeated
scanning. That is why we need 'nr_io', which indicates that these folios
have been paged out."

> Would it be a bool or better to provide separate helpers?
> 

+		if (nr_io > 0 &&
+		    !folio_test_writeback(folio))
+			lruvec_add_folio_tail(lruvec, folio);
+		else
+			lruvec_add_folio(lruvec, folio);
+

I think this may be sufficient. Only using 'PG_writeback' to determine
whether the folios have been written-back.

Thank you again.

Best regards,
Ridong
>>
>>         walk = current->reclaim_state->mm_walk;
>>         if (walk && walk->batched) {
>> --
>> 2.34.1
>>
> 
> Thanks
> Barry


