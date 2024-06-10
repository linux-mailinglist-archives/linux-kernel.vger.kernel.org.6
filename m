Return-Path: <linux-kernel+bounces-208760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7FC9028D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601D21F22788
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D5314EC58;
	Mon, 10 Jun 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhDHH56M"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F214E2ED
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044591; cv=none; b=MSD7EbY+uD7qSYQIFcHDct/pWxGkkZ6/tdjxZvm/3Et2f1l5rCGJobNXATolQjJGY3wxm7+DeHKvV0UckIU4719UOLmaGgjs52fAXp2GzVQJ858awLFhXr9C7jA6Md8qiHCIiIXOe5SX5BDs4k39KfREOYzzDGKYrLsZ0gnEyK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044591; c=relaxed/simple;
	bh=HTZ5YLg1agJpTo8gjKXsHlt4lQ3vVBOWBr53KcV7FAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6oFtOxR5UriWReS8VG5apwUntBdpazwxH99xAV3j3/+8oKLfRY0pEEFHEzIUSJb2ribsh7rjPByDxB/mWEljp70Xn/OHJ7dAcGjwThr6PPyMAcSk7O7rZDlX1IJcIS1x/Iz6/8hpTVklb03sHDqIYkqAOHFnoyHt9SHKq65Rtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhDHH56M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso481526066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718044587; x=1718649387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1IvVlgOmmYIMKKD/vlpvl6SApIUUrJQmJ1vq7fEcBk=;
        b=IhDHH56MQDU6hzZf7CIgmuS3y5Re3BjHz9biN+GfGdzTl2corc8PgUtWvuK0yhVoYh
         FCUnOBGaa+2+wJVJKRWvCdSLg0DgRwT6YBpY2u8attYY521OFYmU0fab2+qAKSchAij4
         DOVzd4LEbzO1D3KTxXrdL5rNfiqc53Nre1DxVaMrXydfxfB36aNR5FrU3EBfki5AXc1N
         8QlY90Fo+l8h+n0+wP0lOPdyBZXYr2PW3WFWIeEgwGzKSkdtQsF1LIxTvJAw2e4sGdgL
         4KZCjtUPiwh7f04zi22ZhVG7AufI4IqmBDMXB2BRJSVycD9UkxM6W68KzaBwbJX+783z
         QHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044587; x=1718649387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1IvVlgOmmYIMKKD/vlpvl6SApIUUrJQmJ1vq7fEcBk=;
        b=nsaA9RxD8iYnamiCX1teRak1jQ1GII2LKlVG+pptW0OLEJap6UvALznO4TVfmRwtdW
         pPzRp7ZL1394Q0H7QrHI34WPFjpQtKI8V8AWk5fochYv1fuleolZt91moWqUPDbl2tBm
         0MC/htnZFAbgSW09CriZLeYzWtoAqF95mhemZWPnYOrG0l04wJBtnCTpmQa69bImnzsi
         dCEgnpPV7drhavxnO+CewoKtkg7mPljL/x6+US8OJiRGfbJe0E0G2TeNnfOoErZre5Ba
         a7ijSxBTpERD/DdI+eS9YfyjPORxv5fy5u8T0nKonV4Qf+aPAiqqbq8C+eESwSsSZuBd
         OLNg==
X-Forwarded-Encrypted: i=1; AJvYcCU5qdudRRw/B3tbgrpFBpDJA5RWLy5TlcNerhfs2ZKN7DXLOKv1Gwoo97yISRoUON45qDN86QN5cATn40cvwQIDEh1XUZGmws7Df6UD
X-Gm-Message-State: AOJu0YwNamCcozOEUzD1fXP/z/LAoWLKdji/DwLrhm8UW+eE4RHr2zI8
	/qZA15FzlMhxF/zJEVCTF2yatb7vSRJ0x2sLNEnjTzskUgrqVk/bz0XD0LLrfTo=
X-Google-Smtp-Source: AGHT+IGcadJSdVKqCwum8WSNxSBkYV9jXj9BaZDZiJ4pZh7Y8BFEMwxsQwH9Ex+5Q591ypVYYwRc0A==
X-Received: by 2002:a17:906:4690:b0:a6e:fb27:8cde with SMTP id a640c23a62f3a-a6efb27aaa0mr417202366b.19.1718044586690;
        Mon, 10 Jun 2024 11:36:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::7:493])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f2195a2a3sm132335066b.99.2024.06.10.11.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:36:26 -0700 (PDT)
Message-ID: <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com>
Date: Mon, 10 Jun 2024 19:36:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com>
 <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/06/2024 18:57, Yosry Ahmed wrote:
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
> Is there any benefit to iterating on the folio in pages (i.e. have
> both is_folio_zero_filled() and is_folio_page_zero_filled())? Why
> don't we just kmap the entire folio and check it all at once?

Is there an API to kmap an entire folio?

I could just do data = page_address(&folio->page) in above and iterate 
through folio_nr_pages(folio) * PAGE_SIZE, and do it all in one 
function, but this just looks much nicer and much more readable?

In other places in the kernel, the folio iteration is through pages as well:

https://elixir.bootlin.com/linux/latest/source/arch/csky/abiv2/cacheflush.c#L29

https://elixir.bootlin.com/linux/latest/source/arch/mips/mm/cache.c#L162

and others as well.


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
> We don't currently support swapping in large folios, but it is a work
> in progress, and this will break once we have it.
> swap_zeromap_folio_test() will return false even if parts of the folio
> are in fact zero-filled. Then, we will go read those from disk swap,
> essentially corrupting data.

So yes, with this patch I tested swap out of large zero folio, but when 
swapping in it was page by page. My assumption was that swap_read_folio 
(when support is added) would only pass a large folio that was earlier 
swapped out as a large folio. So if a zero filled large folio was 
swapped out, the zeromap will be set for all the pages in that folio, 
and at large folio swap in (when it is supported), it will see that all 
the bits in the zeromap for that folio are set,  and will just 
folio_zero_fill.

If even a single page in large folio has non-zero data then zeromap will 
not store it and it will go to either zswap or disk, and at read time as 
all the bits in zeromap are not set, it will still goto either zswap or 
disk, so I think this works?

Is my assumption wrong that only large folios can be swapped in only if 
they were swapped out as large? I think this code works in that case.

>
> The same problem can happen for zswap, if a large folio being swapped
> is only partially in zswap. In both cases, it's really easy to miss
> the problem if we're testing with zswap disabled, with incompressible
> data, or with non-zero data. Silent data corruption is not very
> debuggable.
>
> I proposed adding handling for this case in zswap here:
> https://lore.kernel.org/lkml/20240608023654.3513385-1-yosryahmed@google.com/
>
> The discussions there hadn't settled yet, but depending on how it pans
> out I suspect we will want something similar for the zeromap case as
> well.
>
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
>>          dec_cluster_info_page(p, p->cluster_info, offset);
>>          unlock_cluster(ci);
>>
>> @@ -2597,6 +2609,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>>          free_percpu(p->cluster_next_cpu);
>>          p->cluster_next_cpu = NULL;
>>          vfree(swap_map);
>> +       bitmap_free(p->zeromap);
>>          kvfree(cluster_info);
>>          /* Destroy swap account information */
>>          swap_cgroup_swapoff(p->type);
>> @@ -3123,6 +3136,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>                  goto bad_swap_unlock_inode;
>>          }
>>
>> +       p->zeromap = bitmap_zalloc(maxpages, GFP_KERNEL);
>> +       if (!p->zeromap) {
>> +               error = -ENOMEM;
>> +               goto bad_swap_unlock_inode;
>> +       }
>> +
>>          if (p->bdev && bdev_stable_writes(p->bdev))
>>                  p->flags |= SWP_STABLE_WRITES;
>>
>> --
>> 2.43.0
>>

