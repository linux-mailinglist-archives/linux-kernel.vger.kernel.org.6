Return-Path: <linux-kernel+bounces-236727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4BC91E661
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B1E1F24780
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DDB16E864;
	Mon,  1 Jul 2024 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTSOBs5S"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188F1EB2B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854154; cv=none; b=nU0bhSn27t1fOAX2tUsd4HvVvZ6eUGcls6IRD7YXxrkXaRUEabFJuvvR/koJQRUBuqTVRy97rFDv7RX2aJBW6NNFBCaM8KCeOlbsxcl6zPm4mk/qEfAsQ0Hb8cbNnd7RMOTcJQ2ni06hU7FEJxpdPyGRk6455XYQrsn2UXTFbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854154; c=relaxed/simple;
	bh=jWUXSSZ1cwXVbjz+qtCBEWegACN5kZYXl7+mxgQVapk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dk+cqak9R3pL4FAUbPGa2VApymRxE3dr/RnqM2yXrdGBOWbH4F8qkakH0ABFbRsmfd+ijIohF9VX/gK5X6ne2/sD2gOLqxirazYQHnOQ+vsf5yfrqx5gAWSIKtWIT8KERTpx70W0UZMsAAggIY/UC5mX6akx5laob2q6X2cQPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTSOBs5S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3629c517da9so2650028f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719854150; x=1720458950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=udEDtypAj+ZPUGqPzgdGsSTfzcgkaIOxqbIXvndywcs=;
        b=XTSOBs5S7X3UTZ1IzvyyLz14ZBw0jFQ4iK0r8BUz4MZberoVAsGQK3m1utnMhnY5cU
         PtecVtd67Ank+q38+hx4p9s+AAH5GSwVCfPS5Nhvk3X0fDneoFqpyyUa8HJvX6yE5C1g
         uZz6CdzOwDNel2vU2vtG9qg3R3viJ5DGNJEi9gU3xRIey/WFKS54i6pdo2ZHbunDpVfu
         wIYd4OATdBQy/M4vhbnhImGsVHVRXAfh6n31u3pTgAh1+1wxDJbgFLJ/HcJJ3hYsqL+E
         oDV6D8Yw0aRNDJhSLWVdj7p6KOSXAzLstfLV9IwJxkt49wUVby99JXpVzf9hGQxuzXM2
         xmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719854150; x=1720458950;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=udEDtypAj+ZPUGqPzgdGsSTfzcgkaIOxqbIXvndywcs=;
        b=CWAWUmp4mQ8IuppqEWEyCb/rPHXQwddJkKnV6nxbIccUxzWhRvGkaaRw357xK63PKM
         U8Wsg0MmiJpFF4BiLXx3uMs68ELjpfo2v9qvVOCrHtLnXu/bFQj4E6jZLCcCE9g1K8Pk
         W3jKXhv6K47z2V+mNAPGVbFRbJ/gH8S6eT6Zr8O4hXQtVunhfszASLDFc+T4Bbybb1y6
         XhYNHyobqc2tM4bVmzXBV/dMMLa6+Ww2c0zYL8sTq5KgQT94Syeh1WTrkp5W0DSqwy1F
         Orf9RZd2ccMRCcN1rlyI7K9UJl0a+iu8fs3hNMmkGHiRQCuKFepzxMFNpcpwjc11FVzA
         6FZA==
X-Forwarded-Encrypted: i=1; AJvYcCVHMkWOdiqQiC3f8VQw2/KP+dS9CzMakNU21SlOuKsWb6avBsaWkD7c3Xeq98Iddo7d6MKUshYfIMdaIJqtifMgcPBO3uRFIXSFzHqX
X-Gm-Message-State: AOJu0YwNkw1mQQ/PcD+VMEG+Mv3pHaUiNmGE0r+pX3ZJNstiCFnfQpfX
	5jkt8kNH4nr9IaORg/i77o40YTco8y+3lyoKDQ0pq/8y6XF+raiH
X-Google-Smtp-Source: AGHT+IEossGDSRxnaV4E5nry7TTgTxzSqxPf2Pj0/uqxzzhKIZYkn1SdzhEbKQsIzJ7BLT9+PIazlQ==
X-Received: by 2002:a5d:47c6:0:b0:367:2d2f:e634 with SMTP id ffacd0b85a97d-367757249a4mr7559662f8f.55.1719854150041;
        Mon, 01 Jul 2024 10:15:50 -0700 (PDT)
Received: from ?IPV6:2001:16a2:dfed:e700:8f2:d143:dc90:1038? ([2001:16a2:dfed:e700:8f2:d143:dc90:1038])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e12fcsm10567482f8f.48.2024.07.01.10.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 10:15:49 -0700 (PDT)
Message-ID: <6f8b64f8-b7b0-42f4-a1d4-bf79624cff1e@gmail.com>
Date: Mon, 1 Jul 2024 20:15:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] mm: store zero pages to be swapped out in a bitmap
From: Usama Arif <usamaarif642@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org
Cc: shakeel.butt@linux.dev, david@redhat.com, ying.huang@intel.com,
 hughd@google.com, willy@infradead.org, yosryahmed@google.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andi Kleen <ak@linux.intel.com>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
 <20240627105730.3110705-2-usamaarif642@gmail.com>
 <20240627161852.GA469122@cmpxchg.org>
 <44a57df4-e54c-47ee-96b8-e2361c549239@gmail.com>
 <aa573e39-8d27-475d-a3a1-27fdcfdcef56@gmail.com>
 <5743d4e4-3e34-4ac1-b4a9-0ddc4f0e624d@gmail.com>
Content-Language: en-US
In-Reply-To: <5743d4e4-3e34-4ac1-b4a9-0ddc4f0e624d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/07/2024 18:37, Usama Arif wrote:
> 
> On 01/07/2024 18:01, Usama Arif wrote:
>>
>> On 28/06/2024 18:30, Usama Arif wrote:
>>>
>>> On 27/06/2024 19:18, Johannes Weiner wrote:
>>>> Hi Usama,
>>>>
>>>> On Thu, Jun 27, 2024 at 11:55:29AM +0100, Usama Arif wrote:
>>>>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>>>>> Rather than reading/writing these pages to flash resulting
>>>>> in increased I/O and flash wear, a bitmap can be used to mark these
>>>>> pages as zero at write time, and the pages can be filled at
>>>>> read time if the bit corresponding to the page is set.
>>>>> With this patch, NVMe writes in Meta server fleet decreased
>>>>> by almost 10% with conventional swap setup (zswap disabled).
>>>>>
>>>>> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>>>>
>>>>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>>>>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>>>>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>>>>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: "Huang, Ying" <ying.huang@intel.com>
>>>>> Cc: Hugh Dickins <hughd@google.com>
>>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>>>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>>>>> Cc: Usama Arif <usamaarif642@gmail.com>
>>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>>> This looks great to me, and the numbers speak for themselves. A few
>>>> minor comments below:
>>>>
>>>>> ---
>>>>>   include/linux/swap.h |   1 +
>>>>>   mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
>>>>>   mm/swapfile.c        |  20 ++++++++
>>>>>   3 files changed, 133 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>> index 3df75d62a835..ed03d421febd 100644
>>>>> --- a/include/linux/swap.h
>>>>> +++ b/include/linux/swap.h
>>>>> @@ -299,6 +299,7 @@ struct swap_info_struct {
>>>>>       signed char    type;        /* strange name for an index */
>>>>>       unsigned int    max;        /* extent of the swap_map */
>>>>>       unsigned char *swap_map;    /* vmalloc'ed array of usage counts */
>>>>> +    unsigned long *zeromap;        /* vmalloc'ed bitmap to track zero pages */
>>>>>       struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>>>>>       struct swap_cluster_list free_clusters; /* free clusters list */
>>>>>       unsigned int lowest_bit;    /* index of first free in swap_map */
>>>>> diff --git a/mm/page_io.c b/mm/page_io.c
>>>>> index 6c1c1828bb88..480b8f221d90 100644
>>>>> --- a/mm/page_io.c
>>>>> +++ b/mm/page_io.c
>>>>> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>>>>>       goto out;
>>>>>   }
>>>> It might be good to have a short comment that gives 1) an overview,
>>>> that we're using a bitmap to avoid doing IO for zero-filled pages and
>>>> 2) the locking, that the bits are protected by the locked swapcache
>>>> folio and atomic updates are used to protect against RMW corruption
>>>> due to other zero swap entries seeing concurrent updates.
>>>
>>> Thanks! have addressed the comments and will include them in next revision. Just a couple of things.
>>>
>>> Will add the overview in swap_writepage when the check is made if the folio is zero filled and zeromap bits are set, instead of at this point.
>>>
>>>>> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
>>>>> +{
>>>>> +    unsigned long *data;
>>>>> +    unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
>>>>> +    bool ret = false;
>>>>> +
>>>>> +    data = kmap_local_folio(folio, i * PAGE_SIZE);
>>>>> +    if (data[last_pos])
>>>>> +        goto out;
>>>>> +static void folio_zero_fill(struct folio *folio)
>>>>> +{
>>>>> +    unsigned int i;
>>>>> +
>>>>> +    for (i = 0; i < folio_nr_pages(folio); i++)
>>>>> +        clear_highpage(folio_page(folio, i));
>>>>> +}
>>>> Should this be in highmem.h next to the other folio_zero_* functions?
>>>
>>> Thanks for pointing to highmem.h. It already has folio_zero_range, which should do the same thing, so I think I can just do folio_zero_range(folio, 0, folio_size(folio)) and this function shouldnt be needed.
>>
>>
>> How about this? Patch 2 to remove zswap code doesn't change.
>>
>>
> My mail client had messed up the spacing in my previous reply, so it might not apply cleanly. Hoping it comes out correct this time
> 

Sorry for the repeated emails, this one should definitely work.

Changes from v7 (Johannes):
- Give overview and explain how locking works in zeromap in comments
- Add comment for why last word is checked first when checking if
  folio is zero-filled
- Merge is_folio_zero_filled and is_folio_page_zero_filled into
  1 function.
- Use folio_zero_range to fill a folio with zero at readtime.
- Put swap_zeromap_folio_clear in an else branch (even if checkpatch
  gives warning) and add comment to make it explicitly clear that it
  needs to happen if folio is not zero filled.
- add missing kvfree for zeromap incase swapon fails.

From 100983ea94cedf6a342352f91d60a83cf4fa27a5 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Fri, 24 May 2024 14:52:55 +0100
Subject: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap

Approximately 10-20% of pages to be swapped out are zero pages [1].
Rather than reading/writing these pages to flash resulting
in increased I/O and flash wear, a bitmap can be used to mark these
pages as zero at write time, and the pages can be filled at
read time if the bit corresponding to the page is set.
With this patch, NVMe writes in Meta server fleet decreased
by almost 10% with conventional swap setup (zswap disabled).

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h |   1 +
 mm/page_io.c         | 117 ++++++++++++++++++++++++++++++++++++++++++-
 mm/swapfile.c        |  21 ++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3df75d62a835..8c38a18320b8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -299,6 +299,7 @@ struct swap_info_struct {
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* extent of the swap_map */
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
+	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct swap_cluster_list free_clusters; /* free clusters list */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
diff --git a/mm/page_io.c b/mm/page_io.c
index 6c1c1828bb88..6cbfb277d020 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -172,6 +172,80 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
 	goto out;
 }
 
+static bool is_folio_zero_filled(struct folio *folio)
+{
+	unsigned int pos, last_pos;
+	unsigned long *data;
+	unsigned int i;
+
+	last_pos = PAGE_SIZE / sizeof(*data) - 1;
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		data = kmap_local_folio(folio, i * PAGE_SIZE);
+		/*
+		 * Check last word first, incase the page is zero-filled at
+		 * the start and has non-zero data at the end, which is common
+		 * in real-world workloads.
+		 */
+		if (data[last_pos]) {
+			kunmap_local(data);
+			return false;
+		}
+		for (pos = 0; pos < last_pos; pos++) {
+			if (data[pos]) {
+				kunmap_local(data);
+				return false;
+			}
+		}
+		kunmap_local(data);
+	}
+
+	return true;
+}
+
+static void swap_zeromap_folio_set(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		set_bit(swp_offset(entry), sis->zeromap);
+	}
+}
+
+static void swap_zeromap_folio_clear(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		clear_bit(swp_offset(entry), sis->zeromap);
+	}
+}
+
+/*
+ * Return the index of the first subpage which is not zero-filled
+ * according to swap_info_struct->zeromap.
+ * If all pages are zero-filled according to zeromap, it will return
+ * folio_nr_pages(folio).
+ */
+static unsigned int swap_zeromap_folio_test(struct folio *folio)
+{
+	struct swap_info_struct *sis = swp_swap_info(folio->swap);
+	swp_entry_t entry;
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		entry = page_swap_entry(folio_page(folio, i));
+		if (!test_bit(swp_offset(entry), sis->zeromap))
+			return i;
+	}
+	return i;
+}
+
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -195,6 +269,25 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 		folio_unlock(folio);
 		return ret;
 	}
+
+	/*
+	 * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages.
+	 * The bits in zeromap are protected by the locked swapcache folio
+	 * and atomic updates are used to protect against read-modify-write
+	 * corruption due to other zero swap entries seeing concurrent updates.
+	 */
+	if (is_folio_zero_filled(folio)) {
+		swap_zeromap_folio_set(folio);
+		folio_unlock(folio);
+		return 0;
+	} else {
+		/*
+		 * Clear bits this folio occupies in the zeromap to prevent
+		 * zero data being read in from any previous zero writes that
+		 * occupied the same swap entries.
+		 */
+		swap_zeromap_folio_clear(folio);
+	}
 	if (zswap_store(folio)) {
 		folio_unlock(folio);
 		return 0;
@@ -424,6 +517,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
+static bool swap_read_folio_zeromap(struct folio *folio)
+{
+	unsigned int idx = swap_zeromap_folio_test(folio);
+
+	if (idx == 0)
+		return false;
+
+	/*
+	 * Swapping in a large folio that is partially in the zeromap is not
+	 * currently handled. Return true without marking the folio uptodate so
+	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
+	 */
+	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
+		return true;
+
+	folio_zero_range(folio, 0, folio_size(folio));
+	folio_mark_uptodate(folio);
+	return true;
+}
+
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
 	struct swap_info_struct *sis = swp_swap_info(folio->swap);
@@ -514,7 +627,9 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	}
 	delayacct_swapin_start();
 
-	if (zswap_load(folio)) {
+	if (swap_read_folio_zeromap(folio)) {
+		folio_unlock(folio);
+	} else if (zswap_load(folio)) {
 		folio_unlock(folio);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 9c6d8e557c0f..111ca98a5944 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -747,6 +747,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
+	unsigned int i;
+
+	/*
+	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
+	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
+	 */
+	for (i = 0; i < nr_entries; i++)
+		clear_bit(offset + i, si->zeromap);
 
 	if (offset < si->lowest_bit)
 		si->lowest_bit = offset;
@@ -2635,6 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	free_percpu(p->cluster_next_cpu);
 	p->cluster_next_cpu = NULL;
 	vfree(swap_map);
+	kvfree(p->zeromap);
 	kvfree(cluster_info);
 	/* Destroy swap account information */
 	swap_cgroup_swapoff(p->type);
@@ -3161,6 +3170,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	/*
+	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
+	 * be above MAX_PAGE_ORDER incase of a large swap file.
+	 */
+	p->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
+				    GFP_KERNEL | __GFP_ZERO);
+	if (!p->zeromap) {
+		error = -ENOMEM;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
@@ -3315,6 +3335,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	p->flags = 0;
 	spin_unlock(&swap_lock);
 	vfree(swap_map);
+	kvfree(p->zeromap);
 	kvfree(cluster_info);
 	if (inced_nr_rotate_swap)
 		atomic_dec(&nr_rotate_swap);
-- 
2.43.0



