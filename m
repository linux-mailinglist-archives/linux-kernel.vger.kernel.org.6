Return-Path: <linux-kernel+bounces-560978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE028A60BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010B118944EA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70371C5D59;
	Fri, 14 Mar 2025 08:39:20 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2A1A8401
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941560; cv=none; b=S9zBiWKJZoV+zBxH3jy2pJE7uPNTCgWh04n/rWwh5zG1TNdnN314xzqbKKTYrmPpUGPopNzgrED1dPA4Ge2DKSFUIcBDJU0Qy3FJ0XTcS0gA64XabxDOhxrz8hc5TZj0tlUEB+jDYPKTCrQU8mLHDPjvZd57b0XwQFtutfaJvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941560; c=relaxed/simple;
	bh=tqxIyxkh/01IEJsmW07TuEbIcZj1KQF+/28b44wJGqw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lEvHhULePuQvWddd342Z8IUStgZ23aOjAgU/JFwAD50eVRjsWrNkH71genMvq5nDKo0fmwePzryi5BOOIaDbU0NrpHRmYCbqeftrVa2rYG5KCc3WKTueyE237qu+EWbcadlRI5xhJFuPnes3X4T0u6z0zVIMhviNH5b0+rsLrZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZDd7X423hz4f3m6r
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:38:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 78D331A01A1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:39:12 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgBnyl4v69NnV4_UGQ--.7807S2;
	Fri, 14 Mar 2025 16:39:12 +0800 (CST)
Subject: Re: [PATCH 2/9] mm: swap: factor out the actual swap entry freeing
 logic to new helper
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
 <20250313210515.9920-3-shikemeng@huaweicloud.com>
 <CAMgjq7Ct8b25zuCEqJ4byU8gmrvz50pUqvyjYN=_RjTk_5U8cA@mail.gmail.com>
 <a04c8908-a12a-dab8-f4e4-61f7b85443bf@huaweicloud.com>
 <CAMgjq7Cq30Kb-Wysq+GkV4ZAj-PKQQaEg_YQzwJ=6COtS6k_Yw@mail.gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <2ca0c9be-765a-4fa1-c74b-62499cab7ce4@huaweicloud.com>
Date: Fri, 14 Mar 2025 16:39:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMgjq7Cq30Kb-Wysq+GkV4ZAj-PKQQaEg_YQzwJ=6COtS6k_Yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnyl4v69NnV4_UGQ--.7807S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyrZw1rGFyDKFWrKw1ftFb_yoWrWr48pF
	9IqFn0kF4kJryxJr4aqw1qqrZIvw4fKF18XFnrKw1fAasIyr97tFyDArWY9rykAwn7C34F
	v3WDK3sxuF4YyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/14/2025 3:47 PM, Kairui Song wrote:
> On Fri, Mar 14, 2025 at 3:32 PM Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> on 3/14/2025 1:42 AM, Kairui Song wrote:
>>> On Thu, Mar 13, 2025 at 8:09 PM Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>>>
>>>> Factor out the actual swap entry freeing logic to new helper
>>>> __swap_entries_free().
>>>> This allow us to futher simplify other swap entry freeing code by
>>>> leveraging __swap_entries_free() helper function.
>>>>
>>>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>>>> ---
>>>>  mm/swapfile.c | 30 ++++++++++++++++++++----------
>>>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index 5a775456e26c..7c886f9dd6f9 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -1347,6 +1347,25 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
>>>>         return NULL;
>>>>  }
>>>>
>>>> +static inline void __swap_entries_free(struct swap_info_struct *si,
>>>> +                                      struct swap_cluster_info *ci,
>>>> +                                      swp_entry_t entry, unsigned int nr_pages)
>>>> +{
>>>> +       unsigned long offset = swp_offset(entry);
>>>> +
>>>> +       VM_BUG_ON(cluster_is_empty(ci));
>>>> +       VM_BUG_ON(ci->count < nr_pages);
>>>> +
>>>> +       ci->count -= nr_pages;
>>>> +       mem_cgroup_uncharge_swap(entry, nr_pages);
>>>> +       swap_range_free(si, offset, nr_pages);
>>>> +
>>>> +       if (!ci->count)
>>>> +               free_cluster(si, ci);
>>>> +       else
>>>> +               partial_free_cluster(si, ci);
>>>> +}
>>>> +
>>>>  static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
>>>>                                            unsigned long offset,
>>>>                                            unsigned char usage)
>>>> @@ -1525,22 +1544,13 @@ static void swap_entry_range_free(struct swap_info_struct *si,
>>>>
>>>>         /* It should never free entries across different clusters */
>>>>         VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
>>>> -       VM_BUG_ON(cluster_is_empty(ci));
>>>> -       VM_BUG_ON(ci->count < nr_pages);
>>>>
>>>> -       ci->count -= nr_pages;
>>>>         do {
>>>>                 VM_BUG_ON(*map != SWAP_HAS_CACHE);
>>>>                 *map = 0;
>>>>         } while (++map < map_end);
>>>>
>>>> -       mem_cgroup_uncharge_swap(entry, nr_pages);
>>>> -       swap_range_free(si, offset, nr_pages);
>>>> -
>>>> -       if (!ci->count)
>>>> -               free_cluster(si, ci);
>>>> -       else
>>>> -               partial_free_cluster(si, ci);
>>>> +       __swap_entries_free(si, ci, entry, nr_pages);
>>>>  }
>>>>
>>>>  static void cluster_swap_free_nr(struct swap_info_struct *si,
>>>> --
>>>> 2.30.0
>>>>
>>>>
>>>
>>> Hi Kemeng,
>> Hello Kairui,
>>
>> Thanks for feedback.
>>>
>>> This patch is a bit too trivial to be a standalone one, you can fold
>>> it with the later one easily. Also you may want to carry the
>>> VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1)); check
>>> as well.
>> Sure, I will do this in next version.
>>>
>>> But, that is basically just renaming swap_entry_range_free, you may
>>> just remove the HAS_CACHE check as you rename it, that way the changes
>>> should be cleaner.
>>>
>> Sorry, I don't quite follow. Are you suggesting that should fold this
>> patch to later one which removes the HAS_CACHE check and renmae the
>> swap_entry_range_free.
> 
> Hi,
> 
> Just some of my nitpicks :)
> 
> After you move these parts out of swap_entry_put_locked, there is
> almost nothing left in swap_entry_put_locked except an "open coded
> memset". And in your next patch (also after the whole series), all
> callers of __swap_entries_free will have to call an "open coded
> memset" anyway, so these changes seem redundant and could be improved.
Right, we can simply use swap_entries_free() instead of __swap_entries_free()
int swap_entry_put_locked() after the whole series and this change seems not
necessary. Will improve this in next version.
> 
> BTW your next patch has a typo in the commit message:
> s/__swap_entriy_free/__swap_entries_free/g.
Will fix this in next version.

Thanks,
Kemeng
> 
>>
>> Thanks,
>> Kemeng
>>
> 


