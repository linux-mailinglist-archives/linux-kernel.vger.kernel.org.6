Return-Path: <linux-kernel+bounces-314856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284D196BA08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7401C2243E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071971D04B9;
	Wed,  4 Sep 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAYeaajf"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C11D04AB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448487; cv=none; b=M+xiXvhhOS0Qqf0ZmvCu+XCkU3loG2wQ/CqLCFU0x7uhegWKLJ6DKdY1TJhw3TOctcU/MbrbqErH7/kIrg8chXj1pOjpzDO0wrFgMMiq8RdGqE1kdS+cI9UTJR9twG4tZb4TNA7IDUOBj8aUWhHFNSdSMVMTvlEADHLOw7sGWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448487; c=relaxed/simple;
	bh=mgh4hoGG5fIAyFNDfqUr+TXz32mbxPPDkKnzrcdJFjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXFFaEB02zrk1z4WjYsUp9xs7me5CquwMtCyvrN4lOkxMbhoysc5xmUfa/hGIBmIpvLKKyCEx3rpmXXaToUXF7tmWwPEy3XXDnK6mH/m1xCtLMmMr2fjtstgsD+66tcYYY35K8aLu7mv4358NDdipU5HZ64h+XBgf/6rxqkU9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAYeaajf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so753399a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725448483; x=1726053283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Me3O/kZ+odhMmOaQ3WjDbn57wTW+RVJQ6ZiktI6MK90=;
        b=kAYeaajfll0yAKkmpYtreMt1EArq6yQRLGdjpxUZodkJmgyMtJbekRKLQtbDe7nxR4
         DJOsCxsLf2c0Cia0LaQt91NQgT00wxo6i+QY+lC2PQD5S2kL4VaOZRAsPcnEc0zOdImF
         lJk7HEaEdHIZ7uM6jKQE1tg0OEmEHUzNDJqEDUHntQOIqWu54p4gYlxcwh8H8/mRz90y
         exiuZBrapoMSpgwtropKQQfA71eYv68YYOt9Ufn+OyiPrlmoRlTo9BJT/c+fRCxJumjv
         ZetPjg6Qgsk9GimJ2Q/t8NHm0bZi5rUL5BEzddQS9TwKKC2KKOA4oCkqygfdrqjztayV
         8TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448483; x=1726053283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Me3O/kZ+odhMmOaQ3WjDbn57wTW+RVJQ6ZiktI6MK90=;
        b=miUD1TP9UpWqiOrcARiAxdioOvk7d3Q9FUCgT4So0BqPT6v75lC2WowzvOlqKKb2wY
         cmjvZFQo/Jy4oBKDP4CR7rtRNXLN8LStI1cwjSKXSpUX9jVp0HyBBIRPQah+MJWX72TY
         xDJdINrIQFx6ay8S7TVuqb2DY3krCB/bqTLiKDHDCE7iKzUpymaPZz0TQQSToIA+6v7R
         a4EUoUcMuu2myO3lJcpluxr48rdYvvmkA8WgfbR60cmxRFlxtRpcRFnjotahqR8UpHqf
         fChC5Npo28qV8+MpGFsCS2PnjM1/Lr1D24yuxaQyhPMrVc3eq8JGiy+ZFeq5QzheuwgB
         rBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCepiM4ncoz2n1uaZxVUO9FZyNx+pnLlU0uQn8QY2flCfSPqbSlG1aZ3jJx5XTFZy+9vGucJyNB1dkJw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9h/tQ8XJfuxJmjAzz7WqvHV143JXvlTwH7RdkTWZwdbDclWm
	Ts8U6xXTv6h2EtTQNPGXt8+aogMsDLiUk/JJkWbhsMZAN/hLwMwZ
X-Google-Smtp-Source: AGHT+IH+yCLKOd1Vd8GUN8WoEMx3Yl/2nFAfnlE3qR4hFA+lOVGZsr8xBSsCs7s9IdWnooVlk6MyHw==
X-Received: by 2002:a17:907:7d93:b0:a77:b3c4:cd28 with SMTP id a640c23a62f3a-a8a3f0ef33amr167341866b.9.1725448482461;
        Wed, 04 Sep 2024 04:14:42 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::6:4d49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feacd7sm797121266b.34.2024.09.04.04.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 04:14:42 -0700 (PDT)
Message-ID: <7a91ff31-1f56-4d0c-a4a7-a305331ba97a@gmail.com>
Date: Wed, 4 Sep 2024 12:14:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
 shakeel.butt@linux.dev, willy@infradead.org, ying.huang@intel.com,
 yosryahmed@google.com, hanchuanhua@oppo.com
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240904055522.2376-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 06:55, Barry Song wrote:
> On Thu, Jun 13, 2024 at 12:48 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>> Approximately 10-20% of pages to be swapped out are zero pages [1].
>> Rather than reading/writing these pages to flash resulting
>> in increased I/O and flash wear, a bitmap can be used to mark these
>> pages as zero at write time, and the pages can be filled at
>> read time if the bit corresponding to the page is set.
>> With this patch, NVMe writes in Meta server fleet decreased
>> by almost 10% with conventional swap setup (zswap disabled).
>>
>> [1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/
>>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> ---
>>  include/linux/swap.h |   1 +
>>  mm/page_io.c         | 114 ++++++++++++++++++++++++++++++++++++++++++-
>>  mm/swapfile.c        |  24 ++++++++-
>>  3 files changed, 136 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index a11c75e897ec..e88563978441 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -299,6 +299,7 @@ struct swap_info_struct {
>>         signed char     type;           /* strange name for an index */
>>         unsigned int    max;            /* extent of the swap_map */
>>         unsigned char *swap_map;        /* vmalloc'ed array of usage counts */
>> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zero pages */
>>         struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>>         struct swap_cluster_list free_clusters; /* free clusters list */
>>         unsigned int lowest_bit;        /* index of first free in swap_map */
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index a360857cf75d..39fc3919ce15 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>>         goto out;
>>  }
>>
>> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
>> +{
>> +       unsigned long *data;
>> +       unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
>> +       bool ret = false;
>> +
>> +       data = kmap_local_folio(folio, i * PAGE_SIZE);
>> +       if (data[last_pos])
>> +               goto out;
>> +       for (pos = 0; pos < PAGE_SIZE / sizeof(*data); pos++) {
>> +               if (data[pos])
>> +                       goto out;
>> +       }
>> +       ret = true;
>> +out:
>> +       kunmap_local(data);
>> +       return ret;
>> +}
>> +
>> +static bool is_folio_zero_filled(struct folio *folio)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               if (!is_folio_page_zero_filled(folio, i))
>> +                       return false;
>> +       }
>> +       return true;
>> +}
>> +
>> +static void folio_zero_fill(struct folio *folio)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++)
>> +               clear_highpage(folio_page(folio, i));
>> +}
>> +
>> +static void swap_zeromap_folio_set(struct folio *folio)
>> +{
>> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
>> +       swp_entry_t entry;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               entry = page_swap_entry(folio_page(folio, i));
>> +               set_bit(swp_offset(entry), sis->zeromap);
>> +       }
>> +}
>> +
>> +static void swap_zeromap_folio_clear(struct folio *folio)
>> +{
>> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
>> +       swp_entry_t entry;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               entry = page_swap_entry(folio_page(folio, i));
>> +               clear_bit(swp_offset(entry), sis->zeromap);
>> +       }
>> +}
>> +
>> +/*
>> + * Return the index of the first subpage which is not zero-filled
>> + * according to swap_info_struct->zeromap.
>> + * If all pages are zero-filled according to zeromap, it will return
>> + * folio_nr_pages(folio).
>> + */
>> +static unsigned int swap_zeromap_folio_test(struct folio *folio)
>> +{
>> +       struct swap_info_struct *sis = swp_swap_info(folio->swap);
>> +       swp_entry_t entry;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < folio_nr_pages(folio); i++) {
>> +               entry = page_swap_entry(folio_page(folio, i));
>> +               if (!test_bit(swp_offset(entry), sis->zeromap))
>> +                       return i;
>> +       }
>> +       return i;
>> +}
>> +
>>  /*
>>   * We may have stale swap cache pages in memory: notice
>>   * them here and get rid of the unnecessary final write.
>> @@ -195,6 +277,13 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>>                 folio_unlock(folio);
>>                 return ret;
>>         }
>> +
>> +       if (is_folio_zero_filled(folio)) {
>> +               swap_zeromap_folio_set(folio);
>> +               folio_unlock(folio);
>> +               return 0;
>> +       }
>> +       swap_zeromap_folio_clear(folio);
>>         if (zswap_store(folio)) {
>>                 folio_start_writeback(folio);
>>                 folio_unlock(folio);
>> @@ -426,6 +515,26 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>>         mempool_free(sio, sio_pool);
>>  }
>>
>> +static bool swap_read_folio_zeromap(struct folio *folio)
>> +{
>> +       unsigned int idx = swap_zeromap_folio_test(folio);
>> +
>> +       if (idx == 0)
>> +               return false;
>> +
>> +       /*
>> +        * Swapping in a large folio that is partially in the zeromap is not
>> +        * currently handled. Return true without marking the folio uptodate so
>> +        * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>> +        */
>> +       if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
>> +               return true;
> 
> Hi Usama, Yosry,
> 
> I feel the warning is wrong as we could have the case where idx==0
> is not zeromap but idx=1 is zeromap. idx == 0 doesn't necessarily
> mean we should return false.
> 
> What about the below change which both fixes the warning and unblocks
> large folios swap-in?
> 
Hi Barry,

I remembered when resending the zeromap series about the comment Yosry had made earlier, but checked that the mTHP swap-in was not in mm-unstable.
I should have checked the mailing list and commented!

I have not tested the below diff yet (will do in a few hours). But there might be a small issue with it. Have commented inline.

> diff --git a/mm/page_io.c b/mm/page_io.c
> index 4bc77d1c6bfa..7d7ff7064e2b 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -226,26 +226,6 @@ static void swap_zeromap_folio_clear(struct folio *folio)
>  	}
>  }
>  
> -/*
> - * Return the index of the first subpage which is not zero-filled
> - * according to swap_info_struct->zeromap.
> - * If all pages are zero-filled according to zeromap, it will return
> - * folio_nr_pages(folio).
> - */
> -static unsigned int swap_zeromap_folio_test(struct folio *folio)
> -{
> -	struct swap_info_struct *sis = swp_swap_info(folio->swap);
> -	swp_entry_t entry;
> -	unsigned int i;
> -
> -	for (i = 0; i < folio_nr_pages(folio); i++) {
> -		entry = page_swap_entry(folio_page(folio, i));
> -		if (!test_bit(swp_offset(entry), sis->zeromap))
> -			return i;
> -	}
> -	return i;
> -}
> -
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -524,9 +504,10 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
> -	unsigned int idx = swap_zeromap_folio_test(folio);
> +	unsigned int nr_pages = folio_nr_pages(folio);
> +	unsigned int nr = swap_zeromap_entries_count(folio->swap, nr_pages);
>  
> -	if (idx == 0)
> +	if (nr == 0)
>  		return false;
>  
>  	/*
> @@ -534,7 +515,7 @@ static bool swap_read_folio_zeromap(struct folio *folio)
>  	 * currently handled. Return true without marking the folio uptodate so
>  	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
>  	 */
> -	if (WARN_ON_ONCE(idx < folio_nr_pages(folio)))
> +	if (WARN_ON_ONCE(nr < nr_pages))
>  		return true;
>  
>  	folio_zero_range(folio, 0, folio_size(folio));
> diff --git a/mm/swap.h b/mm/swap.h
> index f8711ff82f84..2d59e9d89e95 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -80,6 +80,32 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>  	return swp_swap_info(folio->swap)->flags;
>  }
> +
> +/*
> + * Return the number of entries which are zero-filled according to
> + * swap_info_struct->zeromap. It isn't precise if the return value
> + * is larger than 0 and smaller than nr to avoid extra iterations,
> + * In this case, it means entries haven't consistent zeromap.
> + */
> +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
> +{
> +	struct swap_info_struct *sis = swp_swap_info(entry);
> +	unsigned long offset = swp_offset(entry);
> +	unsigned int type = swp_type(entry);
> +	unsigned int n = 0;
> +
> +	for (int i = 0; i < nr; i++) {
> +		entry = swp_entry(type, offset + i);
> +		if (test_bit(offset + i, sis->zeromap)) {

Should this be if (test_bit(swp_offset(entry), sis->zeromap))


Also, are you going to use this in alloc_swap_folio?
You mentioned above that this unblocks large folios swap-in, but I don't see
it in the diff here. I am guessing there is some change in alloc_swap_info that
uses swap_zeromap_entries_count?

Thanks
Usama

> +			if (i != n)
> +				return i;
> +			n++;
> +		}
> +	}
> +
> +	return n;
> +}
> +
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
> @@ -171,6 +197,11 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>  	return 0;
>  }
> +
> +static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry, int nr)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_SWAP */
>  
>  #endif /* _MM_SWAP_H */
> 

