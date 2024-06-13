Return-Path: <linux-kernel+bounces-213913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48794907C83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCB1C23BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32714D2B7;
	Thu, 13 Jun 2024 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PluAx5Ik"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9092D14D29B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306467; cv=none; b=ip/KN3jRoTh9YADFO/DdmsaOWNQ03zvHQKzD5Ktta9kWjBxVCjMvwnwOl0Ljz00zOxGHj4bvBFYQm1FUIVZOD4mTDYjatLZW+y7nm8Q7S4+TE23raWEoslwctRrQgeu5JICTDxIbgtRzJ6MHdxyT633PuBq7yEHIxVaAt02hYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306467; c=relaxed/simple;
	bh=XqCavfRTkEX7HKxRuwJM8gwyM06lxMlDf2qn2yxz93k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rO3YwqRaKJDybiRw9oVTVtvGJfAG6PkYOYgfAqsWsXeaFJvgUN8Jsd5iUlVN+kB1fRZAquCTZZfLgKvmiLKGupfHF6tk+ApkWRKCY1VZqifKTMIIFTB9xLC2Oe4p8koCRG0hsPVtW+nrWYVAKXhf4nk5WWR+ZixznqGWjCQ+Z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PluAx5Ik; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421757d217aso15551705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718306464; x=1718911264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1UH4DZYDKD0QmUQIdEQDsEgA4q9hMP7Ue0M6+5VHF/o=;
        b=PluAx5Ik+2/VARgPzakD5GlyZ5nR/3M4ZAEea2hiaO+gzEsBcG/hi7QCZbvPjRels9
         uAgmTvTbNqJJWg59oifPRJtf0CuinfJ4B7NzysC7aA9DsUAD/Uo/LnzGDJwmVlkEAaIw
         J6FQzFcAHBDfvqDwTJ2+drHg29FMnjsvJ3iKZk+wZ+yVzb18SwP5PFqjQvuuI2amjuX8
         z2nwd2OY5R0NI6EUHXmJS8nxZtltxSZrBWh1Avqr+Xb1lFG8PKLstMK5Aqxe0xgd9r/m
         BR1snthT0JY0hbaB80Du9vNMc2x2KjfT94tJ91rOPsPZopVL0mZ+drF5+y8re4hA8CfB
         mQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306464; x=1718911264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UH4DZYDKD0QmUQIdEQDsEgA4q9hMP7Ue0M6+5VHF/o=;
        b=VPX9KkHqjInW80iRie37m+vS4tnVekRnj8o7wj0OlHU3w7W6jkpym16Hq2ywJVUHlS
         YGaR2zdolAlwZy4V3WfvcPZUKslGH3totdez37KbRx62gdLODWyEMdtrhcb5PdDl2acx
         OSKQxJJIxqCUbgJ/7M9D/IqzLQFNFv+gyUf9HYirGEcE4QbERvUgSqURDSkLds9oj81/
         lrayZOYXGWHdrDWDWWFyeX+uK8H9eKzlpwVh8LygO5B34YiY2cBvNSzHzd1+gXK7P2ge
         Ezduj72rV/B4WiBzkFtV60PqcySzefFNtyVX0woEXuWO49eMQhDWZK2dP6+Avkfg7iJ3
         QtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSKnI7+ljqJBLek3s1ck0tyfbPR2ye/Gl2g52GvbrSVg1QAoKmGutQrUEJlUriM4ZBFqKU3GLV+jxL1zLhaKBj/C7VT/vm4X5/u60
X-Gm-Message-State: AOJu0YwXRlFWv+jeoz1YGP6PUFXm9IJ3IX33kFqSoNHuB+s+kGyE44wy
	MTIlIiuo+5+qPS1Za6iP8FFyn46Q+gI5hlzt9Io1HImHe/3gyzaPZkxUIOHC
X-Google-Smtp-Source: AGHT+IFGB2fcqqSxYH0BeMxq92MYvGFm82w9yP2bjMzUaNJBhxgTTXjvdvNThNo2EJQP/zZyxIuvUg==
X-Received: by 2002:a05:600c:4448:b0:421:81b7:785e with SMTP id 5b1f17b1804b1-4230481a0a5mr7936065e9.2.1718306463635;
        Thu, 13 Jun 2024 12:21:03 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e95eesm72049015e9.25.2024.06.13.12.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 12:21:03 -0700 (PDT)
Message-ID: <0572d8b1-3b17-45a8-bf75-f66e19216d38@gmail.com>
Date: Thu, 13 Jun 2024 20:21:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 david@redhat.com, ying.huang@intel.com, hughd@google.com,
 willy@infradead.org, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
 <20240612124750.2220726-2-usamaarif642@gmail.com>
 <ZmoBf6RPJzC2RaqM@google.com>
 <85804484-9973-41a1-a05d-000833285f39@gmail.com>
 <CAJD7tkYBxN4uAHLacAx=m2+B9zPidz0V5pGP030yvNYLTnk=VQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkYBxN4uAHLacAx=m2+B9zPidz0V5pGP030yvNYLTnk=VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 13/06/2024 17:38, Yosry Ahmed wrote:
> [..]
>>>> +    for (i = 0; i < SWAPFILE_CLUSTER; i++)
>>>> +            clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>>> Could you explain why we need to clear the zeromap here?
>>>
>>> swap_cluster_schedule_discard() is called from:
>>> - swap_free_cluster() -> free_cluster()
>>>
>>> This is already covered below.
>>>
>>> - swap_entry_free() -> dec_cluster_info_page() -> free_cluster()
>>>
>>> Each entry in the cluster should have its zeromap bit cleared in
>>> swap_entry_free() before the entire cluster is free and we call
>>> free_cluster().
>>>
>>> Am I missing something?
>> Yes, it looks like this one is not needed as swap_entry_free and
>> swap_free_cluster would already have cleared the bit. Will remove it.
>>
>> I had initially started checking what codepaths zeromap would need to be
>> cleared. But then thought I could do it wherever si->swap_map is cleared
>> or set to SWAP_MAP_BAD, which is why I added it here.
>>
>>>>       cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
>>>>
>>>> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>>    static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>>>    {
>>>>       struct swap_cluster_info *info, *ci;
>>>> -    unsigned int idx;
>>>> +    unsigned int idx, i;
>>>>
>>>>       info = si->cluster_info;
>>>>
>>>> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>>>               __free_cluster(si, idx);
>>>>               memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>>>                               0, SWAPFILE_CLUSTER);
>>>> +            for (i = 0; i < SWAPFILE_CLUSTER; i++)
>>>> +                    clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>>> Same here. I didn't look into the specific code paths, but shouldn't the
>>> cluster be unused (and hence its zeromap bits already cleared?).
>>>
>> I think this one is needed (or atleast very good to have). There are 2
>> paths:
>>
>> 1) swap_cluster_schedule_discard (clears zeromap) -> swap_discard_work
>> -> swap_do_scheduled_discard (clears zeromap)
>>
>> Path 1 doesnt need it as swap_cluster_schedule_discard already clears it.
>>
>> 2) scan_swap_map_slots -> scan_swap_map_try_ssd_cluster ->
>> swap_do_scheduled_discard (clears zeromap)
>>
>> Path 2 might need it as zeromap isnt cleared earlier I believe
>> (eventhough I think it might already be 0).
> Aren't the clusters in the discard list free by definition? It seems
> like we add a cluster there from swap_cluster_schedule_discard(),
> which we establish above that it gets called on a free cluster, right?

You mean for path 2? Its not from swap_cluster_schedule_discard. The 
whole call path is

get_swap_pages -> scan_swap_map_slots -> scan_swap_map_try_ssd_cluster 
-> swap_do_scheduled_discard. Nowhere up until swap_do_scheduled_discard 
was the zeromap cleared, which is why I think we should add it here.


>> Even if its cleared in path 2, I think its good to keep this one, as the
>> function is swap_do_scheduled_discard, i.e. incase it gets directly
>> called or si->discard_work gets scheduled anywhere else in the future,
>> it should do as the function name suggests, i.e. swap discard(clear
>> zeromap).
> I think we just set the swap map to SWAP_MAP_BAD in
> swap_cluster_schedule_discard() and then clear it in
> swap_do_scheduled_discard(), and the clusters are already freed at
> that point. Ying could set me straight if I am wrong here.
I think you might be mixing up path 1 and path 2 above? 
swap_cluster_schedule_discard is not called in Path 2 where 
swap_do_scheduled_discard ends up being called, which is why I think we 
would need to clear the zeromap here.
> It is confusing to me to keep an unnecessary call tbh, it makes sense
> to clear zeromap bits once, when the swap entry/cluster is not being
> used anymore and before it's reallocated.
>
>>>>               unlock_cluster(ci);
>>>>       }
>>>>    }
>>>> @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>>    {
>>>>       unsigned long offset = idx * SWAPFILE_CLUSTER;
>>>>       struct swap_cluster_info *ci;
>>>> +    unsigned int i;
>>>>
>>>>       ci = lock_cluster(si, offset);
>>>>       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>>>> +    for (i = 0; i < SWAPFILE_CLUSTER; i++)
>>>> +            clear_bit(offset + i, si->zeromap);
>>>>       cluster_set_count_flag(ci, 0, 0);
>>>>       free_cluster(si, idx);
>>>>       unlock_cluster(ci);
>>>> @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>>>>       count = p->swap_map[offset];
>>>>       VM_BUG_ON(count != SWAP_HAS_CACHE);
>>>>       p->swap_map[offset] = 0;
>>>> +    clear_bit(offset, p->zeromap);
>>> I think instead of clearing the zeromap in swap_free_cluster() and here
>>> separately, we can just do it in swap_range_free(). I suspect this may
>>> be the only place we really need to clear the zero in the swapfile code.
>> Sure, we could move it to swap_range_free, but then also move the
>> clearing of swap_map.
>>
>> When it comes to clearing zeromap, I think its just generally a good
>> idea to clear it wherever swap_map is cleared.
> I am not convinced about this argument. The swap_map is used for
> multiple reasons beyond just keeping track of whether a swap entry is
> in-use. The zeromap on the other hand is simpler and just needs to be
> cleared once when an entry is being freed.
>
> Unless others disagree, I prefer to only clear the zeromap once in
> swap_range_free() and keep the swap_map code as-is for now. If we
> think there is value in moving clearing the swap_map to
> swap_range_free(), it should at least be in a separate patch to be
> evaluated separately.
>
> Just my 2c.

Sure, I am indifferent to this. I dont think it makes a difference if 
the zeromap is cleared in swap_free_cluster + swap_entry_free or later 
on in a common swap_range_free function, so will just move it in the 
next revision. Wont move swap_map clearing code.


