Return-Path: <linux-kernel+bounces-569015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ABFA69D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639008A3FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86C1C2DB2;
	Thu, 20 Mar 2025 01:11:06 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4415042A87
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742433065; cv=none; b=eI0scWc41NObKvQ2AI2RN7kKHUzpxxcuFY1g3dEC+NgIP3B1CJJibT+xyoJs1WakesQquiRcJrHw7x/FlB9XgVfc1AnqhiEZuse1cCC9d3sdsuxGTKhlQ7ETl2H0ziZ7NYN1TO1CUz2FOKQou9KP+uikc1QLNw1A2R7QGS0kT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742433065; c=relaxed/simple;
	bh=65Kp05Vd5BJyZiZeqRsE2HC7BVjCXl+Bt/pIjX3HYAA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J66gk730/+0HkGcXilYDAAQsaetL9o9sWGFh2egnVEx5SCOOfpdnZcvjMXRHq7tBcThe8Xof2cysLyfrVKjYOyXPhMNhNL082u0PXw3udnTaexCTwqZwMR4aEkbrLoDNySkcB96x4GaLeREnaFNeJShp6xk5EPIBZ7rWZbiH1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZJ6vc5sbvz4f3mK0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:10:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7F4FA1A1948
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:10:59 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgC3CMMia9tndWifGw--.9018S2;
	Thu, 20 Mar 2025 09:10:59 +0800 (CST)
Subject: Re: [PATCH v2 2/8] mm: swap: remove unneeded VM_BUG_ON(*map !=
 SWAP_HAS_CACHE) in swap_entry_range_free()
To: Kairui Song <ryncsn@gmail.com>
Cc: akpm@linux-foundation.org, tim.c.chen@linux.intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250318150614.6415-1-shikemeng@huaweicloud.com>
 <20250318150614.6415-3-shikemeng@huaweicloud.com>
 <CAMgjq7BR5afYGvKqLXdp7kHB-n+JRxgcsmX-rn+Y9YKY1ZXtTA@mail.gmail.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <0d7af7aa-70e4-3757-ff13-9fc640fdae9b@huaweicloud.com>
Date: Thu, 20 Mar 2025 09:10:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMgjq7BR5afYGvKqLXdp7kHB-n+JRxgcsmX-rn+Y9YKY1ZXtTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3CMMia9tndWifGw--.9018S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15Kr13Xr4DCryfCFW5Awb_yoW7JF43pF
	9Igrn8KFs7XF17Gw47Xa1qq3ySv3yxWF18GFnrG3WfZ3ZxJryvqFyDArWjkryDAr1kuas0
	y3WUt3sxCa1YyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UtR6
	wUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/19/2025 1:18 PM, Kairui Song wrote:
> On Tue, Mar 18, 2025 at 2:10 PM Kemeng Shi <shikemeng@huaweicloud.com> wrote:
>>
>> As all callers of swap_entry_range_free() have already ensured slots to
>> be freed are marked as SWAP_HAS_CACHE while holding the cluster lock,
>> the BUG_ON check can be safely removed. After this, the function
>> swap_entry_range_free() could drop any kind of last flag, rename it to
>> swap_entries_free() and update it's comment accordingly.
>>
>> This is a preparation to use swap_entries_free() to drop last ref count
>> and SWAP_MAP_SHMEM flag.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>  mm/swapfile.c | 27 +++++++++++++--------------
>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 5a775456e26c..0aa7ce82c013 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -52,9 +52,9 @@
>>  static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
>>                                  unsigned char);
>>  static void free_swap_count_continuations(struct swap_info_struct *);
>> -static void swap_entry_range_free(struct swap_info_struct *si,
>> -                                 struct swap_cluster_info *ci,
>> -                                 swp_entry_t entry, unsigned int nr_pages);
>> +static void swap_entries_free(struct swap_info_struct *si,
>> +                             struct swap_cluster_info *ci,
>> +                             swp_entry_t entry, unsigned int nr_pages);
>>  static void swap_range_alloc(struct swap_info_struct *si,
>>                              unsigned int nr_entries);
>>  static bool folio_swapcache_freeable(struct folio *folio);
>> @@ -1463,7 +1463,7 @@ static unsigned char swap_entry_put(struct swap_info_struct *si,
>>         ci = lock_cluster(si, offset);
>>         usage = swap_entry_put_locked(si, offset, 1);
>>         if (!usage)
>> -               swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
>> +               swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
>>         unlock_cluster(ci);
>>
>>         return usage;
>> @@ -1493,7 +1493,7 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
>>         for (i = 0; i < nr; i++)
>>                 WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
>>         if (!has_cache)
>> -               swap_entry_range_free(si, ci, entry, nr);
>> +               swap_entries_free(si, ci, entry, nr);
>>         unlock_cluster(ci);
>>
>>         return has_cache;
>> @@ -1512,12 +1512,12 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
>>  }
>>
>>  /*
>> - * Drop the last HAS_CACHE flag of swap entries, caller have to
>> - * ensure all entries belong to the same cgroup.
>> + * Drop the last flag(1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM) of swap entries,
>> + * caller have to ensure all entries belong to the same cgroup and cluster.
>>   */
>> -static void swap_entry_range_free(struct swap_info_struct *si,
>> -                                 struct swap_cluster_info *ci,
>> -                                 swp_entry_t entry, unsigned int nr_pages)
>> +static void swap_entries_free(struct swap_info_struct *si,
>> +                             struct swap_cluster_info *ci,
>> +                             swp_entry_t entry, unsigned int nr_pages)
>>  {
>>         unsigned long offset = swp_offset(entry);
>>         unsigned char *map = si->swap_map + offset;
>> @@ -1530,7 +1530,6 @@ static void swap_entry_range_free(struct swap_info_struct *si,
>>
>>         ci->count -= nr_pages;
>>         do {
>> -               VM_BUG_ON(*map != SWAP_HAS_CACHE);
> 
> Hi Kemeng
> 
> Instead of just dropping this check, maybe it's better to change it to
> something like VM_BUG_ON(!*map); to catch potential SWAP double free?
> I've found this check very helpful for debugging, especially for
> catching concurrency problems.
Sure, will keep VM_BUG_ON as it's useful.
> 
> Or more strictly: VM_BUG_ON(*map !=  SWAP_HAS_CACHE && *map != 1 &&
> *map != SWAP_MAP_SHMEM);, you may introduce a helper to check if a
> entry is the "last map" like this and use it somewhere else too.
I'd add VM_BUG_ON in this way to catch unexpected freeing.

Thanks,
Kemeng
> 
> 
>>                 *map = 0;
>>         } while (++map < map_end);
>>
>> @@ -1553,7 +1552,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
>>         ci = lock_cluster(si, offset);
>>         do {
>>                 if (!swap_entry_put_locked(si, offset, usage))
>> -                       swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
>> +                       swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
>>         } while (++offset < end);
>>         unlock_cluster(ci);
>>  }
>> @@ -1596,11 +1595,11 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>>
>>         ci = lock_cluster(si, offset);
>>         if (swap_only_has_cache(si, offset, size))
>> -               swap_entry_range_free(si, ci, entry, size);
>> +               swap_entries_free(si, ci, entry, size);
>>         else {
>>                 for (int i = 0; i < size; i++, entry.val++) {
>>                         if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
>> -                               swap_entry_range_free(si, ci, entry, 1);
>> +                               swap_entries_free(si, ci, entry, 1);
>>                 }
>>         }
>>         unlock_cluster(ci);
>> --
>> 2.30.0
>>
> 


