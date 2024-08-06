Return-Path: <linux-kernel+bounces-276193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD4948FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D98228339C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48CA1C3F3C;
	Tue,  6 Aug 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXlzhkKm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28D1C3F32
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949004; cv=none; b=iQ6Non/vEL+yFZkmU9+0zVZSQmm7CxlAd1C7MPatJtats2s+4XrjoAB2tw/eTN/afvZoSpvCCi5F8LLTjh4eji7GOM2zcelK0w8hN/Ah0TyMleLuH64Y4w0Q6t2PhFwaV9vEtEly0C4KHCHBrAUoSivhr0Xl/laHQ6ehS45wJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949004; c=relaxed/simple;
	bh=fLc1MYOd7G4PJElgJ09kwQDa07bqOByrdxppNzdUfT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s07IDdIC9hIVKG0+ECHQLoHKYHqbSsKwm/cquDDBLX2utKpD22ereMkJMehHukUFchqWpnnjHBe8GYaQZr6O/gCYDJGx1MJd8Z+CMPQHe7ftzsA2Aw3o9EirVAguiByhhRbdW5ZJn1HbzBvGgUYOzSdsIw669gj3+8olALttA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXlzhkKm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722949001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BbVHeghCxcbavlpwPUmyKdqFJPLDIUOPTBi2eefPzmU=;
	b=dXlzhkKmjAEn3TCTmYHWPnYc2pqljveYLWLTlrdpyyYW1lRz+BjJvHlGrlMw2tb35kPrdp
	yZOEdwGmN9VPJ8KE5zFonx4/rxIhKiB/gRlvoeuhlK0SnLjGcaoyU/sTlfx93aCzdE7XpF
	vxIasItEcAQPOaXhFdVeP/LDRhmyvQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-JJocWgRuNbWZPOBq8NCLgA-1; Tue, 06 Aug 2024 08:56:40 -0400
X-MC-Unique: JJocWgRuNbWZPOBq8NCLgA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42807a05413so5203615e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948999; x=1723553799;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BbVHeghCxcbavlpwPUmyKdqFJPLDIUOPTBi2eefPzmU=;
        b=fyZ2Pht6Jpf/qJXduofTdxqjTos83IxViHY4zzYNjp1Yhj07EEfl6EHFfRIZwV9KTr
         E+1mxlqUCqOPeGcFaNYcu+C/aCNoMUM/zFlSYSMhSwJBNl20VwKTQcdPa6rtk1F2sUFc
         1iz5bGPREsi7vgKCI11dhun994LQYwFz5ICRdyopIxbgiJ5S8BE/fl9U8idEobgt/e7s
         gg7jDheBqJRTT70AxOLmG8LSh1bInBTpD1ViYn8ooDW9KAzkkmbsL+IZRRGS4qIAvAuc
         GTQ8GJRpcYObmbx6YbkheqCSiJA3ea0sDYa7SglFwwXGAckNfjZEwS8KHmF4cEA3Xw49
         3nnQ==
X-Gm-Message-State: AOJu0YxbIDcvEAC44ES1r3EFhAL1cD/hRcwhWBO0zC/WZky8ihkakAYw
	TQSq5KeOQVPVIzDVNeuhfwRZIIdxfOuR66VnhpIe6WpJ3pIusEUqtz15i6wRl4Q9+Wdu4E4dgNH
	/4ZHlC9sMPPVSJWP76MqE/4IVPhJEky11PbsKILxbAfEiycl/vunXaoh5emUNyA==
X-Received: by 2002:a05:600c:1910:b0:426:6f31:5f5c with SMTP id 5b1f17b1804b1-428e6b05c80mr103269825e9.17.1722948999332;
        Tue, 06 Aug 2024 05:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErghGnHAa8cyLzdPF1c+VPdsO4XjVa9+4FF2AWApKYF1zVoIVlBBFR4oazz8FbaqEwLOwzmw==
X-Received: by 2002:a05:600c:1910:b0:426:6f31:5f5c with SMTP id 5b1f17b1804b1-428e6b05c80mr103269615e9.17.1722948998828;
        Tue, 06 Aug 2024 05:56:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d887sm180338905e9.43.2024.08.06.05.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:56:38 -0700 (PDT)
Message-ID: <1e6bcaf2-7c48-4be0-b101-ec2ddc4098ce@redhat.com>
Date: Tue, 6 Aug 2024 14:56:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: attempt to batch free swap entries for
 zap_pte_range()
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240806012409.61962-1-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240806012409.61962-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 03:24, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Zhiguo reported that swap release could be a serious bottleneck
> during process exits[1]. With mTHP, we have the opportunity to
> batch free swaps.
> Thanks to the work of Chris and Kairui[2], I was able to achieve
> this optimization with minimal code changes by building on their
> efforts.
> If swap_count is 1, which is likely true as most anon memory are
> private, we can free all contiguous swap slots all together.
> 
> Ran the below test program for measuring the bandwidth of munmap
> using zRAM and 64KiB mTHP:
> 
>   #include <sys/mman.h>
>   #include <sys/time.h>
>   #include <stdlib.h>
> 
>   unsigned long long tv_to_ms(struct timeval tv)
>   {
>          return tv.tv_sec * 1000 + tv.tv_usec / 1000;
>   }
> 
>   main()
>   {
>          struct timeval tv_b, tv_e;
>          int i;
>   #define SIZE 1024*1024*1024
>          void *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>          if (!p) {
>                  perror("fail to get memory");
>                  exit(-1);
>          }
> 
>          madvise(p, SIZE, MADV_HUGEPAGE);
>          memset(p, 0x11, SIZE); /* write to get mem */
> 
>          madvise(p, SIZE, MADV_PAGEOUT);
> 
>          gettimeofday(&tv_b, NULL);
>          munmap(p, SIZE);
>          gettimeofday(&tv_e, NULL);
> 
>          printf("munmap in bandwidth: %ld bytes/ms\n",
>                          SIZE/(tv_to_ms(tv_e) - tv_to_ms(tv_b)));
>   }
> 
> The result is as below (munmap bandwidth):
>                  mm-unstable  mm-unstable-with-patch
>     round1       21053761      63161283
>     round2       21053761      63161283
>     round3       21053761      63161283
>     round4       20648881      67108864
>     round5       20648881      67108864
> 
> munmap bandwidth becomes 3X faster.
> 
> [1] https://lore.kernel.org/linux-mm/20240731133318.527-1-justinjiang@vivo.com/
> [2] https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org/
> 
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>   mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ea023fc25d08..ed872a186e81 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
>   	return true;
>   }
>   
> +static bool swap_is_last_map(struct swap_info_struct *si,
> +			      unsigned long offset, int nr_pages,
> +			      bool *has_cache)
> +{
> +	unsigned char *map = si->swap_map + offset;
> +	unsigned char *map_end = map + nr_pages;
> +	bool cached = false;
> +
> +	do {
> +		if ((*map & ~SWAP_HAS_CACHE) != 1)
> +			return false;
> +		if (*map & SWAP_HAS_CACHE)
> +			cached = true;
> +	} while (++map < map_end);
> +
> +	*has_cache = cached;
> +	return true;
> +}
> +
>   /*
>    * returns number of pages in the folio that backs the swap entry. If positive,
>    * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
> @@ -1469,6 +1488,39 @@ static unsigned char __swap_entry_free(struct swap_info_struct *p,
>   	return usage;
>   }
>   
> +static bool try_batch_swap_entries_free(struct swap_info_struct *p,

Why call it "p" here and not "si" like in the other code you are touching?

> +		swp_entry_t entry, int nr, bool *any_only_cache)
> +{
> +	unsigned long offset = swp_offset(entry);
> +	struct swap_cluster_info *ci;
> +	bool has_cache = false;
> +	bool can_batch;
> +	int i;
> +
> +	/* cross into another cluster */
> +	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> +		return false;
> +	ci = lock_cluster_or_swap_info(p, offset);
> +	can_batch = swap_is_last_map(p, offset, nr, &has_cache);
> +	if (can_batch) {
> +		for (i = 0; i < nr; i++)
> +			WRITE_ONCE(p->swap_map[offset + i], SWAP_HAS_CACHE);
> +	}
> +	unlock_cluster_or_swap_info(p, ci);
> +
> +	/* all swap_maps have count==1 and have no swapcache */
> +	if (!can_batch)
> +		goto out;
> +	if (!has_cache) {
> +		spin_lock(&p->lock);
> +		swap_entry_range_free(p, entry, nr);
> +		spin_unlock(&p->lock);
> +	}
> +	*any_only_cache = has_cache;
> +out:
> +	return can_batch;
> +}
> +
>   /*
>    * Drop the last HAS_CACHE flag of swap entries, caller have to
>    * ensure all entries belong to the same cgroup.
> @@ -1797,6 +1849,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>   	bool any_only_cache = false;
>   	unsigned long offset;
>   	unsigned char count;
> +	bool batched;
>   
>   	if (non_swap_entry(entry))
>   		return;
> @@ -1808,6 +1861,13 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>   	if (WARN_ON(end_offset > si->max))
>   		goto out;
>   
> +	if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) == 1)) {
> +		batched = try_batch_swap_entries_free(si, entry, nr,
> +						&any_only_cache);
> +		if (batched)
> +			goto reclaim;
> +	}
> +

I'm wondering if we could find a way to clean this up to achieve here:


if (WARN_ON(end_offset > si->max))
	goto out;

/*
  * First free all entries in the range.$
  */
any_only_cache = __free_swap_entries(si, entry, nr);

/*
  * Short-circuit the below loop if none of the entries had their
  * reference drop to zero.
  */
if (!any_only_cache)
	goto out;




Whereby move the fallback loop in that new function

static bool __free_swap_entries(struct swap_info_struct *si,
		swp_entry_t entry, int nr)
{
	const unsigned long start_offset = swp_offset(entry);
	const unsigned long end_offset = start_offset + nr;
	bool any_only_cache = false;

	if (nr > 1 && swap_count(data_race(si->swap_map[start_offset]) == 1)) {
		[... what try_batch_swap_entries_free() would do ...]
	}

fallback:
	for (offset = start_offset; offset < end_offset; offset++) {
		if (data_race(si->swap_map[offset])) {
		[... what the fallback code would do ...]
	}
	return any_only_cache;
}


>   	/*
>   	 * First free all entries in the range.
>   	 */
> @@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>   		}
>   	}
>   
> +reclaim:
>   	/*
>   	 * Short-circuit the below loop if none of the entries had their
>   	 * reference drop to zero.

-- 
Cheers,

David / dhildenb


