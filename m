Return-Path: <linux-kernel+bounces-213100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3726906B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CBF1C20DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52314386B;
	Thu, 13 Jun 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvP9NqKH"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066C41422B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278668; cv=none; b=LyaMEbMmierHuTcYWtRIZCMchazmQNm5qBC6CUyzQ8EeZRfANovSNbyPRshPmKuG/99UGdcixqU0dKtMWWO4O9TwgX53Lb2pSvORYKdnBUhVINhHZoix+WewO8Uk2gZAPB9klZA/AHJVstqG5WkCBYp2yF57oIK/cUdlJqNJxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278668; c=relaxed/simple;
	bh=yovbsmIAk1gW+Z1NFtuqrvyZj+iqNKdFAt3kNwFNBTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c88PJmgvulP+AS4I5h8BcLvPsDdZdgcQgof6O5pnJOS/lPPuOamJM3pFyG64zicHY9oFM3jxJhGrKFkb4XhAVu2b7+ARkwpNx88FSa6AlUskwbBo1EJtA2NbTigYvECY0KQmwl5lvwP3PHTyiocu0qB2AIjxsJLTDlV/XBbGx/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvP9NqKH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217d808034so9192065e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718278665; x=1718883465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyS05mccHMGgaTY1tNQhECHHkXFY13iQYzyqO2gCGAY=;
        b=NvP9NqKHr2piWsTouJbecn+YrPSbZWRS70AVERqiJnZft/eYs9wZj+gqmy9fH7+ug0
         xzSjadGykWhkVIKuyDDYu8N5TA97+7V823S1ZSUZkbg2H218fBdBEWPQwmNfhG0LQWYZ
         LO4ZwFuUoNs4kCnwozzAarm0hoqPQ4vF4YkqDdmttm9lxfoo5zeq+I5Qm6p+Ca/K8ixj
         vuuxuDjCy6j2Kze6r9HzqKVkSRrvdojyPagu5rxrOUtDUOxKde4KILGtJzRogt5Z+DGB
         FZU7B0c58zAk0RAJusUi6YZ/v/wNbJrpBibqk1mFoUQpzjnrG+cZLPSEhhvtvlsGdozV
         YXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718278665; x=1718883465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyS05mccHMGgaTY1tNQhECHHkXFY13iQYzyqO2gCGAY=;
        b=uO4dzNQjCx2hkwsuzcme/cWS+dLz/3W1qA09ev+h0+SBBosRVGywhQXc5owG7caw0c
         2YYPDb4ZYZqZMoeJbvqQuK3E2L9nPJWVoocllvrmCRcSGuQPqzLKy3FFgkMoHWmd8qwo
         OXWoTqDylSgbYYBv4cwhpN5bMBgxr5h3nlt/RXi9X7I+jwcPUq8uQ3h7uilQUFK+9nf+
         DYEJEWSybR9N1jVfKu5PyEmM5kRdNPt1LfGsKR9zE3d2orbBxbgo5CmpZ9KiSOptwxYp
         NdkzlablrMCxjdnDmPjZbmyS//VBpKYhSbsC/uLPe2K4LcroKTrxNHSW49AGakN4l8Um
         R3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5u68qI1c0RiEX4VQZvqS7954JSBRTm892kZgBfGzgzF14l54alRpn5AEBGE0Ju0zxI2wov0m4YzXLn4Xu/2Uu9tAVH57vM+rRbXLw
X-Gm-Message-State: AOJu0Yx0iSglVasMzoLYQ+DvM5ZYoyON2k5gifLXFqHjygWUTtmI55Jb
	mu/+kBDWGPOHpkJ7It3OCH0YG/a2v9d5yS5Q9k1FnN6tfJxtcg3W
X-Google-Smtp-Source: AGHT+IHMLNWiJWlbAhzsaJzf+jFKWYXoQ3r+a3XOon9IWDIK7S2hN+vh79fEG0yTidg+tn3guusMhg==
X-Received: by 2002:a05:600c:2192:b0:41b:e0e5:a525 with SMTP id 5b1f17b1804b1-422864ae1cfmr42865595e9.17.1718278665010;
        Thu, 13 Jun 2024 04:37:45 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e802sm21157395e9.11.2024.06.13.04.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 04:37:44 -0700 (PDT)
Message-ID: <85804484-9973-41a1-a05d-000833285f39@gmail.com>
Date: Thu, 13 Jun 2024 12:37:44 +0100
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
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZmoBf6RPJzC2RaqM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/06/2024 21:13, Yosry Ahmed wrote:
> On Wed, Jun 12, 2024 at 01:43:35PM +0100, Usama Arif wrote:
> [..]
>
> Hi Usama,
>
> A few more comments/questions, sorry for not looking closely earlier.
No worries, Thanks for the reviews!
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index f1e559e216bd..48d8dca0b94b 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
>>   static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>>   		unsigned int idx)
>>   {
>> +	unsigned int i;
>> +
>>   	/*
>>   	 * If scan_swap_map_slots() can't find a free cluster, it will check
>>   	 * si->swap_map directly. To make sure the discarding cluster isn't
>> @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>>   	 */
>>   	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>   			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>> +	/*
>> +	 * zeromap can see updates from concurrent swap_writepage() and swap_read_folio()
>> +	 * call on other slots, hence use atomic clear_bit for zeromap instead of the
>> +	 * non-atomic bitmap_clear.
>> +	 */
> I don't think this is accurate. swap_read_folio() does not update the
> zeromap. I think the need for an atomic operation here is because we may
> be updating adjacent bits simulatenously, so we may cause lost updates
> otherwise (i.e. corrupting adjacent bits).


Thanks, will change to "Use atomic clear_bit instead of non-atomic 
bitmap_clear to prevent adjacent bits corruption due to simultaneous 
writes." in the next revision

>
>> +	for (i = 0; i < SWAPFILE_CLUSTER; i++)
>> +		clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> Could you explain why we need to clear the zeromap here?
>
> swap_cluster_schedule_discard() is called from:
> - swap_free_cluster() -> free_cluster()
>
> This is already covered below.
>
> - swap_entry_free() -> dec_cluster_info_page() -> free_cluster()
>
> Each entry in the cluster should have its zeromap bit cleared in
> swap_entry_free() before the entire cluster is free and we call
> free_cluster().
>
> Am I missing something?

Yes, it looks like this one is not needed as swap_entry_free and 
swap_free_cluster would already have cleared the bit. Will remove it.

I had initially started checking what codepaths zeromap would need to be 
cleared. But then thought I could do it wherever si->swap_map is cleared 
or set to SWAP_MAP_BAD, which is why I added it here.

>>   
>>   	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
>>   
>> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
>>   static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>   {
>>   	struct swap_cluster_info *info, *ci;
>> -	unsigned int idx;
>> +	unsigned int idx, i;
>>   
>>   	info = si->cluster_info;
>>   
>> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>   		__free_cluster(si, idx);
>>   		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>   				0, SWAPFILE_CLUSTER);
>> +		for (i = 0; i < SWAPFILE_CLUSTER; i++)
>> +			clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> Same here. I didn't look into the specific code paths, but shouldn't the
> cluster be unused (and hence its zeromap bits already cleared?).
>
I think this one is needed (or atleast very good to have). There are 2 
paths:

1) swap_cluster_schedule_discard (clears zeromap) -> swap_discard_work 
-> swap_do_scheduled_discard (clears zeromap)

Path 1 doesnt need it as swap_cluster_schedule_discard already clears it.

2) scan_swap_map_slots -> scan_swap_map_try_ssd_cluster -> 
swap_do_scheduled_discard (clears zeromap)

Path 2 might need it as zeromap isnt cleared earlier I believe 
(eventhough I think it might already be 0).

Even if its cleared in path 2, I think its good to keep this one, as the 
function is swap_do_scheduled_discard, i.e. incase it gets directly 
called or si->discard_work gets scheduled anywhere else in the future, 
it should do as the function name suggests, i.e. swap discard(clear 
zeromap).

>>   		unlock_cluster(ci);
>>   	}
>>   }
>> @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>   {
>>   	unsigned long offset = idx * SWAPFILE_CLUSTER;
>>   	struct swap_cluster_info *ci;
>> +	unsigned int i;
>>   
>>   	ci = lock_cluster(si, offset);
>>   	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>> +	for (i = 0; i < SWAPFILE_CLUSTER; i++)
>> +		clear_bit(offset + i, si->zeromap);
>>   	cluster_set_count_flag(ci, 0, 0);
>>   	free_cluster(si, idx);
>>   	unlock_cluster(ci);
>> @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>>   	count = p->swap_map[offset];
>>   	VM_BUG_ON(count != SWAP_HAS_CACHE);
>>   	p->swap_map[offset] = 0;
>> +	clear_bit(offset, p->zeromap);
> I think instead of clearing the zeromap in swap_free_cluster() and here
> separately, we can just do it in swap_range_free(). I suspect this may
> be the only place we really need to clear the zero in the swapfile code.

Sure, we could move it to swap_range_free, but then also move the 
clearing of swap_map.

When it comes to clearing zeromap, I think its just generally a good 
idea to clear it wherever swap_map is cleared.

So the diff over v4 looks like below (should address all comments but 
not remove it from swap_do_scheduled_discard, and 
move si->swap_map/zeromap clearing from 
swap_free_cluster/swap_entry_free to swap_range_free):



diff --git a/mm/swapfile.c b/mm/swapfile.c
index 48d8dca0b94b..39cad0d09525 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -463,13 +463,6 @@ static void swap_cluster_schedule_discard(struct 
swap_info_struct *si,
          */
         memset(si->swap_map + idx * SWAPFILE_CLUSTER,
                         SWAP_MAP_BAD, SWAPFILE_CLUSTER);
-       /*
-        * zeromap can see updates from concurrent swap_writepage() and 
swap_read_folio()
-        * call on other slots, hence use atomic clear_bit for zeromap 
instead of the
-        * non-atomic bitmap_clear.
-        */
-       for (i = 0; i < SWAPFILE_CLUSTER; i++)
-               clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);

         cluster_list_add_tail(&si->discard_clusters, si->cluster_info, 
idx);

@@ -758,6 +751,15 @@ static void swap_range_free(struct swap_info_struct 
*si, unsigned long offset,
         unsigned long begin = offset;
         unsigned long end = offset + nr_entries - 1;
         void (*swap_slot_free_notify)(struct block_device *, unsigned 
long);
+       unsigned int i;
+
+       memset(si->swap_map + offset, 0, nr_entries);
+       /*
+        * Use atomic clear_bit operations only on zeromap instead of 
non-atomic
+        * bitmap_clear to prevent adjacent bits corruption due to 
simultaneous writes.
+        */
+       for (i = 0; i < nr_entries; i++)
+               clear_bit(offset + i, si->zeromap);

         if (offset < si->lowest_bit)
                 si->lowest_bit = offset;
@@ -1070,12 +1072,8 @@ static void swap_free_cluster(struct 
swap_info_struct *si, unsigned long idx)
  {
         unsigned long offset = idx * SWAPFILE_CLUSTER;
         struct swap_cluster_info *ci;
-       unsigned int i;

         ci = lock_cluster(si, offset);
-       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
-       for (i = 0; i < SWAPFILE_CLUSTER; i++)
-               clear_bit(offset + i, si->zeromap);
         cluster_set_count_flag(ci, 0, 0);
         free_cluster(si, idx);
         unlock_cluster(ci);
@@ -1349,8 +1347,6 @@ static void swap_entry_free(struct 
swap_info_struct *p, swp_entry_t entry)
         ci = lock_cluster(p, offset);
         count = p->swap_map[offset];
         VM_BUG_ON(count != SWAP_HAS_CACHE);
-       p->swap_map[offset] = 0;
-       clear_bit(offset, p->zeromap);
         dec_cluster_info_page(p, p->cluster_info, offset);
         unlock_cluster(ci);




