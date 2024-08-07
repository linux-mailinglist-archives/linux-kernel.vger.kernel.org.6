Return-Path: <linux-kernel+bounces-277650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B994A447
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D5D1C20CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5B1CCB22;
	Wed,  7 Aug 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEQnS9og"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0F1C9ED0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022947; cv=none; b=fRRYg22bpuGVcgttHDjMCT3sRLTatgEmLPduwNW9SRHAbyG8rodwvsmVRTZqocl6SJEtzP7e011iGBKDltJ2fUdd+3QTLpv2pRYoa+10s4zb28EpYtok7l9tV9YTR6pQGQnhqm9DBnyp3lPZKd/a0ocZZSsqZ/pJ+iNamL2Pu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022947; c=relaxed/simple;
	bh=10KF9Tlo0c7yn9uofXxd1jT+pR6ZyfTRzE7SyIL9dXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRgorT4TMYuSr8wQX/z+0bka4oBCRiJOHy+1PllPlwbNDlJLZcuSyf2Hc6z1/sQLRzFxXV1pGXtMaXKy5jI1KLOBH7uKTcA/MGhHCUFEGt9hp3Gd04gZ4d+p+KLc73AlILEAn3ubIW60n47Ks9J6/zCRu6zs93BHE4Bq0rVSFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEQnS9og; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723022944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6bKut2vi7yGvkerReTdoOVACGdYtAT5Iy9qhku7T0K8=;
	b=FEQnS9oga1OCvQarAKSjVoEZ8k8sYy8Pj1ZObSVI0nwdD6AHqMoeoIE2TdbMX0lt+J2C3J
	fS9SrKpvn3NjY1bh0RwFkutDfFHOjVjiQ8fpTiGLeRknsq5SfB8y0N+gDvPXe+eWNYlVy3
	97ht62J6TqFF/SKF1yRefsB4IhH+lRo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608--84Os8VzPouc8XeW_ZFwRw-1; Wed, 07 Aug 2024 05:29:03 -0400
X-MC-Unique: -84Os8VzPouc8XeW_ZFwRw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3684ea1537fso871042f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022942; x=1723627742;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bKut2vi7yGvkerReTdoOVACGdYtAT5Iy9qhku7T0K8=;
        b=FxuvPSlRkN+6fJW3Z5jsAj4dyd1c47jroEDI1jDO3Yo4vzeVyuT9VNNNo9cOWNXKbh
         4QQJdbXJK/uIX02hCRDbuRU9D+Xto0WyDWWtrmZ6S22AtHFscjXYhoFGxjlLfZNQuZVy
         jTi2nhn9/qyU3bHVzW61UfRh0Twod2YBa9zcuBW2GdVnPAB9yglWIjY5jYeSz5nCU19M
         svk+xgoKPKMxpBGkXgjZTAcwiwup2kAIc/V8Bb74hsodz6fQ8Ea3vMSR9v2MIQD336mX
         cQ/ce8mtY94hI1oWl3JMqFaPirK2AdoOw143pGvVh2CISvuVDKB+t8qEXdi6sPkDmrjt
         gl1w==
X-Forwarded-Encrypted: i=1; AJvYcCXssyo7D1xE9dGBUC263toj1o1+X6qpaUY26p6dfEGPVGYTFdUNqAyXOBegR4m2MZn2XsU2j2bPaVq6fvw0X4A4IqngFoKdD5CWYzeO
X-Gm-Message-State: AOJu0YzKjGtmvrKsUHN02L3CvW3P9ISq97xmg5DHYyLNCut5igPw/9I6
	TOytE/6WSkmy3RsewdYRk1h6Id++Qzqs+/O1CTNm8f4uoRuzSMLVQ+enR1agICggGyykrIIm1Go
	Crvh3gaBoVTGTYzT8OgnkV8b6vAvspWxsnnvH4yNRyIum+iABrmUl9gYyGFEx0Q==
X-Received: by 2002:adf:eacd:0:b0:367:9d2c:9602 with SMTP id ffacd0b85a97d-36bbc194267mr13056258f8f.49.1723022941759;
        Wed, 07 Aug 2024 02:29:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDRZjnR4VLFn8wKWU8dTdG1bfEEa0kCKBi4zSKVXWZMhpg3ZJtAmVFC17GzCeuz5kk/imaBg==
X-Received: by 2002:adf:eacd:0:b0:367:9d2c:9602 with SMTP id ffacd0b85a97d-36bbc194267mr13056233f8f.49.1723022941186;
        Wed, 07 Aug 2024 02:29:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf0cc83sm15510002f8f.1.2024.08.07.02.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 02:29:00 -0700 (PDT)
Message-ID: <e50abade-c44e-41d4-b7bf-b9d54920e2a4@redhat.com>
Date: Wed, 7 Aug 2024 11:28:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: attempt to batch free swap entries for
 zap_pte_range()
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: justinjiang@vivo.com, chrisl@kernel.org, hughd@google.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, ying.huang@intel.com
References: <20240807082508.358322-1-21cnbao@gmail.com>
 <20240807082508.358322-3-21cnbao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807082508.358322-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   mm/swapfile.c | 78 +++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 35cb58373493..25c3f98fa8d5 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -156,6 +156,25 @@ static bool swap_is_has_cache(struct swap_info_struct *si,
>   	return true;
>   }
>   
> +static bool swap_is_last_map(struct swap_info_struct *si,
> +			      unsigned long offset, int nr_pages,
> +			      bool *has_cache)

Please use double tabs for indenting parameters on 2nd line on 
new/changed code:

		unsigned long offset, int nr_pages, bool *has_cache)

Results in less churn when renaming functions and we can frequently 
avoid some lines.

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
> @@ -1469,6 +1488,53 @@ static unsigned char __swap_entry_free(struct swap_info_struct *si,
>   	return usage;
>   }
>   
> +static bool __swap_entries_free(struct swap_info_struct *si,
> +				swp_entry_t entry, int nr)

Dito.

> +{
> +	unsigned long offset = swp_offset(entry);
> +	unsigned int type = swp_type(entry);
> +	struct swap_cluster_info *ci;
> +	bool has_cache = false;
> +	unsigned char count;
> +	bool can_batch;
> +	int i;
> +
> +	if (nr <= 1 || swap_count(data_race(si->swap_map[offset])) != 1)
> +		goto fallback;
> +	/* cross into another cluster */
> +	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
> +		goto fallback;
> +
> +	ci = lock_cluster_or_swap_info(si, offset);
> +	can_batch = swap_is_last_map(si, offset, nr, &has_cache);
> +	if (can_batch) {
> +		for (i = 0; i < nr; i++)
> +			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
> +	}
> +	unlock_cluster_or_swap_info(si, ci);
> +
> +	if (!can_batch)
> +		goto fallback;

I'd avoid "can_batch" and just do:

ci = lock_cluster_or_swap_info(si, offset);
if (!swap_is_last_map(si, offset, nr, &has_cache)) {
	unlock_cluster_or_swap_info(si, ci);
	goto fallback;
}
for (i = 0; i < nr; i++)
	WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
unlock_cluster_or_swap_info(si, ci);

> +	if (!has_cache) {
> +		spin_lock(&si->lock);

I'm no expert on that code, but we might drop the cluster lock the take 
the swap_info lock and then retake the cluster lock. I assume there are 
no races we are worrying about here, right?

> +		swap_entry_range_free(si, entry, nr);
> +		spin_unlock(&si->lock);
> +	}
> +	return has_cache;
> +
> +fallback:
> +	for (i = 0; i  < nr; i++) {

One space too much before the "<".

> +		if (data_race(si->swap_map[offset + i])) {
> +			count = __swap_entry_free(si, swp_entry(type, offset + i));
> +			if (count == SWAP_HAS_CACHE)
> +				has_cache = true;
> +		} else {
> +			WARN_ON_ONCE(1);
> +		}
> +	}
> +	return has_cache;
> +}
> +

-- 
Cheers,

David / dhildenb


