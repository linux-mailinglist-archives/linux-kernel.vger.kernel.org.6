Return-Path: <linux-kernel+bounces-234138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C770591C2A9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91CB1C21E28
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5195A1C2325;
	Fri, 28 Jun 2024 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwEB0hb8"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4C1CD39
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719588650; cv=none; b=urdqoufEgeXKqqPB0mKrSJqpauXS51YQp6zmvrfWDhepg13LH9eGdsZWkRmvZkpWu5ntuGLFz3LIpHgEK0BsjA3gwEE+WaQgRxBNaw4AZI2iK0et0uboJx9LHwoacbWIh2S0LcRRcrdcmxLOzDQUzE1VWSnSFVd+2HwM7ETUNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719588650; c=relaxed/simple;
	bh=BNYeLN9d5DHXdHPee6hAgKqL89NV5MUkvj7zNmSaMPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9PydYe5PfIyrO38claYWLUyaOp9mZhdgS3Xrjc8P5/L6OCIkpw5or7h5+bnKlOr85459lyI8yaAUzBiZPohwlUkMdl0Q0cuAaZcEq4Ii8hXtDYRYW7AYTVWbQhKaaWgniPINoL1DAxhryV0FFmsyMMEWLHT81XlaDfOy9EngVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwEB0hb8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso8685231fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719588647; x=1720193447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIvAV+BPelCpPdeLvDnIF1t0ou2brUvQEeuXH5r7KiA=;
        b=jwEB0hb8aLxAoADGwgioFyqhle1OrkkaHgpvUOef9+eKUMzZeAOjnUVT83I8Dh2xcY
         poBe8hfpQGap1KNqnw1nsns5X0gL/m9GeR0ST3vxPdPFz60Lq8HcCfmcXiyR0GWBpHqT
         xbxPT3KFgyaC+SJbxRix7rUF8rOLolmXaOyoiwewzgtu+TxxrfFuWgzI0FZ0FgQYyhNk
         XFRP3q7TU+rUVY84tE16d2HWYFiTMihLs8lPuN1+3GDTVvMQv4t8d+8toypGjuJptB3G
         8U1uH0F/fO96hkPuuo/Zw+ozAFcLt1adU+k/eJjlQT5S96VQMZyMJl1hu6LK4GQMziMj
         xF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719588647; x=1720193447;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIvAV+BPelCpPdeLvDnIF1t0ou2brUvQEeuXH5r7KiA=;
        b=NicFBXjc1o736JWwcvGPoW4Pt+GrHm5/YbRjTLaSSkfVdQ8TZPUeYg1SUPFCSwt/cx
         YP1tt7fjkpbmU3dlIb/tNz1lOCpaxFXe06S8s0gmY/3ja/uGUieJwJpmZiNOYd9Pf2Yj
         uav9LfSNKIlRdpbcGWI3KcutF3DZH7Ezp9Gg85xn0yhlmYiBPKF8MW+jIAGi4KKccSgB
         UPuZkSfpqzgdfCw6FgTODbJN0vlDanBzH4ow0yquWRh3m/0w64GvldagLIyPAIJRjDFX
         BwMG5K6ZkzgDjk6c0wVF+/ucuKq40vVvwEsYaWTWnPO50W8sxLDbECYiar3nz/uzLhp1
         RBzw==
X-Forwarded-Encrypted: i=1; AJvYcCVRWyd7hykH/ytx3XAPNI9CflFoHmYRFihjFmRTLjq7wl0n3EXwiy20lMGmlXC238kXp2sPOj9Ia2y6BAMCCj6ri6ZvQoauU+sBgjcF
X-Gm-Message-State: AOJu0YwtWGpkbf+d1GHJfNDKED07m+2A1aaU4xPG+PYkKwyUdMS0u80l
	3x5Gxc25lgenG7cFe2X0NZ8UdimaSD+xxReGIRCHAGiYhWjyb1tIYLU1sjkNu01MvA==
X-Google-Smtp-Source: AGHT+IH1a9sunwrz6EojMfegKM4Pz2lbCMTC/UGVwnc4W4zu71pJOgaAXc+AX0CsIf/rIM2jiBqQzQ==
X-Received: by 2002:ac2:5f76:0:b0:52c:e0d3:c199 with SMTP id 2adb3069b0e04-52ce185d19emr11460785e87.51.1719588646548;
        Fri, 28 Jun 2024 08:30:46 -0700 (PDT)
Received: from ?IPV6:2001:16a2:df29:7e00:184b:b632:a7dc:1c99? ([2001:16a2:df29:7e00:184b:b632:a7dc:1c99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a103d18sm2617455f8f.106.2024.06.28.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 08:30:46 -0700 (PDT)
Message-ID: <44a57df4-e54c-47ee-96b8-e2361c549239@gmail.com>
Date: Fri, 28 Jun 2024 18:30:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] mm: store zero pages to be swapped out in a bitmap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, david@redhat.com,
 ying.huang@intel.com, hughd@google.com, willy@infradead.org,
 yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andi Kleen <ak@linux.intel.com>
References: <20240627105730.3110705-1-usamaarif642@gmail.com>
 <20240627105730.3110705-2-usamaarif642@gmail.com>
 <20240627161852.GA469122@cmpxchg.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240627161852.GA469122@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 27/06/2024 19:18, Johannes Weiner wrote:
> Hi Usama,
>
> On Thu, Jun 27, 2024 at 11:55:29AM +0100, Usama Arif wrote:
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
>> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>> Cc: Usama Arif <usamaarif642@gmail.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> This looks great to me, and the numbers speak for themselves. A few
> minor comments below:
>
>> ---
>>   include/linux/swap.h |   1 +
>>   mm/page_io.c         | 113 ++++++++++++++++++++++++++++++++++++++++++-
>>   mm/swapfile.c        |  20 ++++++++
>>   3 files changed, 133 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 3df75d62a835..ed03d421febd 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -299,6 +299,7 @@ struct swap_info_struct {
>>   	signed char	type;		/* strange name for an index */
>>   	unsigned int	max;		/* extent of the swap_map */
>>   	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
>> +	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
>>   	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>>   	struct swap_cluster_list free_clusters; /* free clusters list */
>>   	unsigned int lowest_bit;	/* index of first free in swap_map */
>> diff --git a/mm/page_io.c b/mm/page_io.c
>> index 6c1c1828bb88..480b8f221d90 100644
>> --- a/mm/page_io.c
>> +++ b/mm/page_io.c
>> @@ -172,6 +172,88 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
>>   	goto out;
>>   }
>>   
> It might be good to have a short comment that gives 1) an overview,
> that we're using a bitmap to avoid doing IO for zero-filled pages and
> 2) the locking, that the bits are protected by the locked swapcache
> folio and atomic updates are used to protect against RMW corruption
> due to other zero swap entries seeing concurrent updates.

Thanks! have addressed the comments and will include them in next 
revision. Just a couple of things.

Will add the overview in swap_writepage when the check is made if the 
folio is zero filled and zeromap bits are set, instead of at this point.

>> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
>> +{
>> +	unsigned long *data;
>> +	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
>> +	bool ret = false;
>> +
>> +	data = kmap_local_folio(folio, i * PAGE_SIZE);
>> +	if (data[last_pos])
>> +		goto out;
>> +static void folio_zero_fill(struct folio *folio)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < folio_nr_pages(folio); i++)
>> +		clear_highpage(folio_page(folio, i));
>> +}
> Should this be in highmem.h next to the other folio_zero_* functions?

Thanks for pointing to highmem.h. It already has folio_zero_range, which 
should do the same thing, so I think I can just do 
folio_zero_range(folio, 0, folio_size(folio)) and this function shouldnt 
be needed.


