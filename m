Return-Path: <linux-kernel+bounces-337891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0C9850BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5282284073
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14851474BF;
	Wed, 25 Sep 2024 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HDZHC3UA"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324122E83F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229240; cv=none; b=fPLFAdS9Evz5KP2KNNb6GxkMEA3cBl3a37DwM14kUQHp359RZmcQD9SWGfRDEHwYuLCtx5n8pAv281C6Ul9fTCJvoSuv2nI7jPYuQCK/pZvP/4ouSi4XYK/CE6QdgqZkHPcd3O9wIu/Ioy1Tc2Mqtns1Hy+SkBMsWNHRCos5qGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229240; c=relaxed/simple;
	bh=svUnDHKYmNktfEWopQ4HP1v4AzmL+OXvjaWS2o219yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfuOV5ZLiiQS8s6XaVuajE8vSe6t43sLfYxDHnKkr3jkr/bAH8HIC81TaBSDSFi5xm0PHvxmIcdppVCel2qNooC9XKgis83e4wph3qVz7CW44H1RYt89nGNXYEdUaBmcKF1IIhqe7MqVdtegR181S+E2Pu3zyr/3aVoCiQHvc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HDZHC3UA; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727229229; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4v+88U4FOuGKfl4tx2izcT7w2SDLhnoDATDvDZFe/6o=;
	b=HDZHC3UA+eETTyw/IS5L9i2uwX9liAJUnCLOS4mUZphK7Cbdk10UfQQZSsJtyfNKXUjNV7kjVTtYdKR7/s7TTvRiQpW1A6e8F2Ni9Ni2gGzvf6FhVc120XMJadHPjAPoUWaPvRtamkoqbwyBQ1yEEDybLWaYwp7zI/5uLsMsJWQ=
Received: from 30.74.144.126(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WFhl-hc_1727229227)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 09:53:48 +0800
Message-ID: <85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com>
Date: Wed, 25 Sep 2024 09:53:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
 shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com,
 chrisl@kernel.org, david@redhat.com, kasong@tencent.com,
 willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org,
 chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org
References: <20240923231142.4155415-1-nphamcs@gmail.com>
 <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com>
 <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/9/24 23:48, Nhat Pham wrote:
> On Tue, Sep 24, 2024 at 8:08 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>>
>> On Tue, Sep 24, 2024 at 7:32 AM Nhat Pham <nphamcs@gmail.com> wrote:
>>>
>>> On Mon, Sep 23, 2024 at 8:25 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>
>>>> On 2024/9/24 10:15, Yosry Ahmed wrote:
>>>>> On Mon, Sep 23, 2024 at 6:55 PM Baolin Wang
>>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024/9/24 07:11, Nhat Pham wrote:
>>>>>>> The SWAP_MAP_SHMEM state was originally introduced in the commit
>>>>>>> aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine if a
>>>>>>> swap entry belongs to shmem during swapoff.
>>>>>>>
>>>>>>> However, swapoff has since been rewritten drastically in the commit
>>>>>>> b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
>>>>>>> having swap count == SWAP_MAP_SHMEM value is basically the same as having
>>>>>>> swap count == 1, and swap_shmem_alloc() behaves analogously to
>>>>>>> swap_duplicate()
>>>>>>>
>>>>>>> This RFC proposes the removal of this state and the associated helper to
>>>>>>> simplify the state machine (both mentally and code-wise). We will also
>>>>>>> have an extra state/special value that can be repurposed (for swap entries
>>>>>>> that never gets re-duplicated).
>>>>>>>
>>>>>>> Another motivation (albeit a bit premature at the moment) is the new swap
>>>>>>> abstraction I am currently working on, that would allow for swap/zswap
>>>>>>> decoupling, swapoff optimization, etc. The fewer states and swap API
>>>>>>> functions there are, the simpler the conversion will be.
>>>>>>>
>>>>>>> I am sending this series first as an RFC, just in case I missed something
>>>>>>> or misunderstood this state, or if someone has a swap optimization in mind
>>>>>>> for shmem that would require this special state.
>>>>>>
>>>>>> The idea makes sense to me. I did a quick test with shmem mTHP, and
>>>>>> encountered the following warning which is triggered by
>>>>>> 'VM_WARN_ON(usage == 1 && nr > 1)' in __swap_duplicate().
>>>>>
>>>>> Apparently __swap_duplicate() does not currently handle increasing the
>>>>> swap count for multiple swap entries by 1 (i.e. usage == 1) because it
>>>>> does not handle rolling back count increases when
>>>>> swap_count_continued() fails.
>>>>>
>>>>> I guess this voids my Reviewed-by until we sort this out. Technically
>>>>> swap_count_continued() won't ever be called for shmem because we only
>>>>> ever increment the count by 1, but there is no way to know this in
>>>>> __swap_duplicate() without SWAP_HAS_SHMEM.
>>>
>>> Ah this is my bad. I compiled with CONFIG_THP_SWAP, but forgot to
>>> remove the swapfile check (that's another can of worms, but I need
>>> data before submitting the patch to remove it...)
>>>
>>> One thing we can do is instead of warning here, we can handle it in
>>> the for loop check, where we have access to count - that's the point
>>> of having that for-loop check anyway? :)
>>>
>>> There's a couple of ways to go about it:
>>>
>>> 1. VM_WARN_ON(usage == 1 && nr > 1 && count != 0 );
>>
>> Hmm that should work, although it's a bit complicated tbh.
>>
>>> (or more accurately, (count & ~COUNT_CONTINUED) >= SWAP_MAP_MAX))
>>
>> I think this will make the warning very hard to hit if there's a
>> misuse of __swap_duplicate(). It will only be hit when an entry needs
>> count continuation, which I am not sure is very common. If there's a
>> bug, the warning will potentially catch it too late, if ever.
>>
>> The side effect here is failing to decrement the swap count of some
>> swap entries which will lead to them never being freed, essentially
>> leaking swap capacity slowly over time. I am not sure if there are
>> more detrimental effects.
>>
>>>
>>> 2. Alternatively, instead of warning here, we can simply return
>>> -ENOMEM. Then, at shmem callsite, have a VM_WARN_ON/VM_BUG_ON(), since
>>> this MUST succeed.
>>
>> We still fail to rollback incremented counts though when we return
>> -ENOMEM, right? Maybe I didn't get what you mean.
> 
> My understanding now is that there are two for loops. One for loop
> that checks the entry's states, and one for loop that does the actual
> incrementing work (or state modification).
> 
> We can check in the first for loop, if it is safe to proceed:
> 
> if (!count && !has_cache) {
>      err = -ENOENT;
> } else if (usage == SWAP_HAS_CACHE) {
> if (has_cache)
>      err = -EEXIST;
> } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
>      err = -EINVAL;
> } else if (usage == 1 && nr > 1 && (count & ~COUNT_CONTINUED) >=
> SWAP_MAP_MAX)) {
>      /* the batched variants currently do not support rollback */
>      err = -ENOMEM;
> }
> 
> At this point, IIUC, we have not done any incrementing, so no rollback
> needed? :)

Right, looks good (although need some cleanup pointed by Yosry).

>>>
>>> Either solutions should follow with careful documentation to make it
>>> clear the expectation/guarantee of the new API.
>>>
>>> Yosry, Baolin, how do you two feel about this? Would something like
>>> this work? I need to test it first, but let me know if I'm missing
>>> something.
>>>
>>> If this does not work, we can do what Baolin is suggesting, and
>>> perhaps maintain the swap_shmem_alloc() helper. It's less than ideal,
>>> but at least we still lose a state...
>>
>> Depending on the complexity tbh, right now removing SWAP_MAP_SHMEM is
>> just a cleanup with small wins, so if it's too complicated to remove
>> it it may not be worth it. I am assuming with your ongoing work, it
>> becomes much more valuable, so maybe if it's too complicated we can
>> defer it until the benefits are realizable?
> 
> I agree :)

One benefit I can mention is that removing 'SWAP_MAP_SHMEM' can help to 
batch free shmem swap entries in __swap_entries_free(), similar to the 
commit bea67dcc5eea ("mm: attempt to batch free swap entries for 
zap_pte_range()") did, which can improve the performance of shmem mTHP 
munmap() function based on my testing.

Without this patch set, I need do following changes to batch free shmem 
swap entries:
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0cded32414a1..94e28cd60c52 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -163,7 +163,7 @@ static bool swap_is_last_map(struct swap_info_struct 
*si,
         unsigned char *map_end = map + nr_pages;
         unsigned char count = *map;

-       if (swap_count(count) != 1)
+       if (swap_count(count) != 1 && swap_count(count) != SWAP_MAP_SHMEM)
                 return false;

         while (++map < map_end) {
@@ -1503,10 +1503,10 @@ static bool __swap_entries_free(struct 
swap_info_struct *si,
         unsigned int type = swp_type(entry);
         struct swap_cluster_info *ci;
         bool has_cache = false;
-       unsigned char count;
+       unsigned char count = swap_count(data_race(si->swap_map[offset]));
         int i;

-       if (nr <= 1 || swap_count(data_race(si->swap_map[offset])) != 1)
+       if (nr <= 1 || (count != 1 && count != SWAP_MAP_SHMEM))
                 goto fallback;
         /* cross into another cluster */
         if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)

