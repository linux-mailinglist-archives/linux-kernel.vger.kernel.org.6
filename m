Return-Path: <linux-kernel+bounces-210466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641129043FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE20282FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611E17CF34;
	Tue, 11 Jun 2024 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhHgsjEt"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C057CAE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131817; cv=none; b=QthK61x9Fzwq1/RelaBzg7GX1K2cXBRpBSeIIwN1j9XS0pTZ+GlN68trbiddymnlnsgJWy5HOT7ciYV5l8i32Dxz89oJvInQK4yNJU4qodTMRV9pbtcJ4snkDojL7M75UwD1PstU3WADUHcg/+F3kLj7Q3ix5og/5O9oBlUl2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131817; c=relaxed/simple;
	bh=bvvfSUQSOvS++oMTg0GbnTARLncjJamXVC71St74WYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecA3/OmQd6Gd4xzYCmwgid3XTI3EBnLoT3u478lUCNByfvODnJLS8eMCRwZFYhQ+gt2elvarTm8LnIhKVeLqhcZD7nB1WgA+ZV2AG2eM3vS2S73ckgIUzniZ3yvjXrZAVknJNt/3U+Q3rrJYAcZwp2kugOq7ZNk68KI98yuq9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhHgsjEt; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c714a1e24so1697792a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718131814; x=1718736614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqmR2CwNzfC5dY9c/qTiO9vjLhQkJvchWeugaaFTjFI=;
        b=OhHgsjEt9jdwE01mABP/+8GV7uqS0WVYmxeMpkbiX1AXdcViR3k1OCSbt0QCWohiI1
         J4Uwl2Cc7tDRoP/t0y1YL6NpFtRcnzvJ4UF+oFPfmbd2TbHSgjWPQg4JogP8Z1vBIgHD
         6C/RU9Zh8ZNdA+Y9hrujxlcBh5iGQ/p6TNeuJ4pET/nUpoM7khTKzgs2SoDcvwBYrk4X
         z5LAsmsnelNUbUm5n5P55BJ/ROIab0LZyD4ilb7uNEAb9fV50dY1bz4MiI7pnRC5m+AC
         Vqd/3pf0l3y4ThYeQx+Q7Q2781xzVunKN9jUgypaSQX2W6NHW5C5M+lfHfYev+KFl/IM
         ybHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131814; x=1718736614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqmR2CwNzfC5dY9c/qTiO9vjLhQkJvchWeugaaFTjFI=;
        b=laNpjbYjU8IT3AXX3O3HXkM9044zOCQUmwcn/UACj0isYDQ9OXr4aPyBBnO2zc4Cgv
         +LWxo2+T2vI4Q0eWtinaDLQikqCOHuFCDnGekYBIH5PZkjb4q15PF+WtMnzjAeOPRIcO
         KlvUz2MbZhfITTAcGEDK6QaHqvNF/aehUO1orXjLad9c2Z4gELmUOnc0DKoy1oHlFOv8
         AMO7WIbmWqFXDWHaZS8wcWFDyck1s0yFLZhRDe0wGwKWWcTidO1e9wuV08yqI7fA5Njt
         zNng92RzXYuwZU5NG8K5K6PVwmynm6G01DnIZX1LFeui1UjQhL/3RsX9PfRSblbUPhqI
         jOlw==
X-Forwarded-Encrypted: i=1; AJvYcCXLb2+fQ8peTAR2NOtvyTHjoqsJystRS0eIzGSqpdMEhB/Mtf1z6ezcjEm16D+4wdWxj4RscQAWKbHSb+eHCw73mga1kKP1b6I6ieNI
X-Gm-Message-State: AOJu0YylNfKh3LV7iFXRvTZ1JnnIqzTaBj1R9+uU+kPZK885229zvoFs
	iGKjhW4E44DeRp5NuLQ5EKaTNVDy2vlNNRRG0evS4mwczYc7nCeJ
X-Google-Smtp-Source: AGHT+IEeooKv++9An6Cw6IMTAU8dmlKCFHrUWYtn1Wz5iEjaM8TvXLcJ2Toq5qJyX1d/4MC9+ATYCA==
X-Received: by 2002:a50:a685:0:b0:578:72d4:e3b0 with SMTP id 4fb4d7f45d1cf-57c509a6080mr8137283a12.36.1718131813239;
        Tue, 11 Jun 2024 11:50:13 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:57b4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c6c95bb33sm6522695a12.8.2024.06.11.11.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 11:50:12 -0700 (PDT)
Message-ID: <d6088fb2-58d8-4ed1-8d3b-83ea34657db7@gmail.com>
Date: Tue, 11 Jun 2024 19:50:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/06/2024 19:39, Nhat Pham wrote:
> On Mon, Jun 10, 2024 at 5:18 AM Usama Arif <usamaarif642@gmail.com> wrote:
>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>> Rather than reading/writing these pages to flash resulting
>> in increased I/O and flash wear, a bitmap can be used to mark these
>> pages as zero at write time, and the pages can be filled at
>> read time if the bit corresponding to the page is set.
>> With this patch, NVMe writes in Meta server fleet decreased
>> by almost 10% with conventional swap setup (zswap disabled).
>>
>> [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>   include/linux/swap.h |  1 +
>>   mm/page_io.c         | 92 +++++++++++++++++++++++++++++++++++++++++++-
>>   mm/swapfile.c        | 21 +++++++++-
>>   3 files changed, 111 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index a11c75e897ec..e88563978441 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -299,6 +299,7 @@ struct swap_info_struct {
>>          signed char     type;           /* strange name for an index */
>>          unsigned int    max;            /* extent of the swap_map */
>>          unsigned char *swap_map;        /* vmalloc'ed array of usage counts */
>> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zero pages */
>>          struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>>          struct swap_cluster_list free_clusters; /* free clusters list */
>>          unsigned int lowest_bit;        /* index of first free in swap_map */
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index a360857cf75d..2cac1e11fb85 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -172,6 +172,82 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>>          goto out;
>>   }
>>
>> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
>> +{
>> +       unsigned long *data;
>> +       unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
>> +       bool ret = false;
>> +
>> +       data = kmap_local_folio(folio, i * PAGE_SIZE);
>> +       if (data[last_pos])
>> +               goto out;
>> +       for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
>> +               if (data[pos])
>> +                       goto out;
>> +       }
>> +       ret = true;
>> +out:
>> +       kunmap_local(data);
>> +       return ret;
>> +}
>> +
>> +static bool is_folio_zero_filled(struct folio *folio)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               if (!is_folio_page_zero_filled(folio, i))
>> +                       return false;
>> +       }
>> +       return true;
>> +}
>> +
>> +static void folio_zero_fill(struct folio *folio)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++)
>> +               clear_highpage(folio_page(folio, i));
>> +}
>> +
>> +static void swap_zeromap_folio_set(struct folio *folio)
>> +{
>> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
>> +       swp_entry_t entry;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               entry = page_swap_entry(folio_page(folio, i));
>> +               set_bit(swp_offset(entry), sis->zeromap);
>> +       }
>> +}
>> +
>> +static void swap_zeromap_folio_clear(struct folio *folio)
>> +{
>> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
>> +       swp_entry_t entry;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               entry = page_swap_entry(folio_page(folio, i));
>> +               clear_bit(swp_offset(entry), sis->zeromap);
>> +       }
>> +}
>> +
>> +static bool swap_zeromap_folio_test(struct folio *folio)
>> +{
>> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
>> +       swp_entry_t entry;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               entry = page_swap_entry(folio_page(folio, i));
>> +               if (!test_bit(swp_offset(entry), sis->zeromap))
>> +                       return false;
>> +       }
>> +       return true;
>> +}
>> +
>>   /*
>>    * We may have stale swap cache pages in memory: notice
>>    * them here and get rid of the unnecessary final write.
>> @@ -195,6 +271,15 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>                  folio_unlock(folio);
>>                  return ret;
>>          }
>> +
>> +       if (is_folio_zero_filled(folio)) {
>> +               swap_zeromap_folio_set(folio);
>> +               folio_start_writeback(folio);
>> +               folio_unlock(folio);
>> +               folio_end_writeback(folio);
>> +               return 0;
>> +       }
>> +       swap_zeromap_folio_clear(folio);
>>          if (zswap_store(folio)) {
>>                  folio_start_writeback(folio);
>>                  folio_unlock(folio);
>> @@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool synchronous,
>>                  psi_memstall_enter(&pflags);
>>          }
>>          delayacct_swapin_start();
>> -
>> -       if (zswap_load(folio)) {
>> +       if (swap_zeromap_folio_test(folio)) {
>> +               folio_zero_fill(folio);
>> +               folio_mark_uptodate(folio);
>> +               folio_unlock(folio);
>> +       } else if (zswap_load(folio)) {
>>                  folio_mark_uptodate(folio);
>>                  folio_unlock(folio);
>>          } else if (data_race(sis->flags & SWP_FS_OPS)) {
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index f1e559e216bd..90451174fe34 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -453,6 +453,8 @@ static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
>>   static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>>                  unsigned int idx)
>>   {
>> +       unsigned int i;
>> +
>>          /*
>>           * If scan_swap_map_slots() can't find a free cluster, it will check
>>           * si->swap_map directly. To make sure the discarding cluster isn't
>> @@ -461,6 +463,13 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>>           */
>>          memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>                          SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>> +       /*
>> +        * zeromap can see updates from concurrent swap_writepage() and swap_read_folio()
>> +        * call on other slots, hence use atomic clear_bit for zeromap instead of the
>> +        * non-atomic bitmap_clear.
>> +        */
>> +       for (i = 0; i < SWAPFILE_CLUSTER; i++)
>> +               clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>>
>>          cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
>>
>> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
>>   static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>   {
>>          struct swap_cluster_info *info, *ci;
>> -       unsigned int idx;
>> +       unsigned int idx, i;
>>
>>          info = si->cluster_info;
>>
>> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
>>                  __free_cluster(si, idx);
>>                  memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>                                  0, SWAPFILE_CLUSTER);
>> +               for (i = 0; i < SWAPFILE_CLUSTER; i++)
>> +                       clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
>>                  unlock_cluster(ci);
>>          }
>>   }
>> @@ -1336,6 +1347,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>>          count = p->swap_map[offset];
>>          VM_BUG_ON(count != SWAP_HAS_CACHE);
>>          p->swap_map[offset] = 0;
>> +       clear_bit(offset, p->zeromap);
> Hmm so clear_bit() is done at the swap_entry_free() point. I wonder if
> we can have a problem, where:
>
> 1. The swap entry has its zeromap bit set, and is freed to the swap
> slot cache (free_swap_slot() in mm/swap_slots.c). For instance, it is
> reclaimed from the swap cache, and all the processes referring to it
> are terminated, which decrements the swap count to 0 (swap_free() ->
> __swap_entry_free() -> free_swap_slots())
>
> 2. The swap slot is then re-used in swap space allocation
> (add_to_swap()) - its zeromap bit is never cleared.
>
> 3. swap_writepage() writes that non-zero page to swap

In swap_writepage, with this patch you have:

     if (is_folio_zero_filled(folio)) {
         swap_zeromap_folio_set(folio);
         folio_unlock(folio);
         return 0;
     }
     swap_zeromap_folio_clear(folio);

i.e. if folio is not zero filled, swap_zeromap_folio_clear will be 
called and the bit is cleared, so I think it would take care of this 
scenario? swap_read_folio will see the bit cleared in step 4.

> 4. swap_read_folio() checks the bitmap, sees that the zeromap bit for
> the entry is set, so populates a zero page for it.
>
> zswap in the past has to carefully invalidate these leftover entries
> quite carefully. Chengming then move the invalidation point to
> free_swap_slot(), massively simplifying the logic.
>
> I wonder if we need to do the same here?

