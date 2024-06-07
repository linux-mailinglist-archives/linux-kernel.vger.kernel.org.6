Return-Path: <linux-kernel+bounces-206751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBC900D51
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33531F222DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D041814F9E9;
	Fri,  7 Jun 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4Q3c4je"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D017BB7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717794301; cv=none; b=ZOIiLFTyGmgA3XNlP3XLO9wnKGUqWkpqv4GkJ2WoDUUqCUP0EvhCPeyMpNaVAGShMfKKIG+q59snpSMG/t2viHigiRoT2VUepr9DJHqN5O3eeKbekpyNKlwCqOkKn/G9I7xZ0rVjHDBdJFzN5h6H7L6WZ64Pfix+Q0EjbUj/Q7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717794301; c=relaxed/simple;
	bh=v0SCZRGswqqufu3SD/B24SiMi5Q22g/RPU3XHE/kTek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUfvgl9TMN5XeRsD5Hg6l/8XNB+NAACAkYalTpVZcUUKKnDrn2lBOqjSQRQc4w0JVmph5M70fgMEvmvGw5SFF8eJW1KJtB/q76yqThl5k2Mn/OHuTRZygqyFZ0smytnpGVTNXiatYOkvk0pLBVuskzz301ZwKQ0SN1BzvBHbuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4Q3c4je; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717794299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4k/2cnNZRUolwt/lBM935Pae8AnvtNVdbu551xqR0uk=;
	b=J4Q3c4jerxPhIuHPF4pQDYW2e4gm7ncrmlLQXBZrsl/Ev5DUXS3Ka9Vyx+L5+7FPa8bKPn
	D2veTBj66KyIgImyrsBtm1eEi5HJzrZuQFmjmzgcTsRRMUk3YbE0sjGyJkfi/aPDYQ1Xc+
	7ugQEUxrylJirQq4ilzro2MY0VcWj7o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-eVFKl8pxPnGAx06sYDFHnA-1; Fri, 07 Jun 2024 17:04:57 -0400
X-MC-Unique: eVFKl8pxPnGAx06sYDFHnA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43ffe780607so35294191cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 14:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717794297; x=1718399097;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4k/2cnNZRUolwt/lBM935Pae8AnvtNVdbu551xqR0uk=;
        b=mF/KdzadzSuS9sedt/qwhRKteyi4t17If4Qrgg2BuVnUnBkhk+fNwklA9XkHjo3rug
         vrdDUobjoZBxpbIGCkMplbnpGCFQDVzo7TehZz+FNkKgWzRQCXcPkVEds39ZvwOF7B4n
         2kWDXnP6yuPi3Nrck/mDNFVtLHYNyEaZGzZ23c6qpnr6YR30AM/0wy4CjRwDh02OoXxf
         nEaphxeQYwfNQWako0DF4qNCa9oF/Q2ziT7b/yO+KTS6QUqM8L4tqJK+OSWqFxlnLln+
         0YiFKHmRPw/ACPLlXlaO23g4JLX8fsSLYnbT1mr2UmyE7UJ3TtZCfeAhlsos2IZX6HCw
         5pMg==
X-Gm-Message-State: AOJu0YwFDkzZpgSrpDx0Emb/13pJxP2TxvbppZgPO6vHIqo+gzF0Fzgz
	rO2wi+jL9Vq56Sq9v+SYXq6shddMMj9+9xYYfE4AMlD/v36FpC9dVju/qSgSbBKVusGs9YmZg2i
	7j65sGaHd5gB5F7bF55F2v+85gFryThJswFYG8TzregBdAbGheg1WNVKu398DMio9pBEvb0mm8Q
	2N2Fm5ZWAi6FgIa6kPZL4KdW2fRw6G2/WFnHRdK2f2rQ==
X-Received: by 2002:ac8:53c5:0:b0:440:47d9:d304 with SMTP id d75a77b69052e-44047d9d5edmr22083521cf.5.1717794297237;
        Fri, 07 Jun 2024 14:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGbd8C2EL6F0Gk0X2kvOAPhOPgtt5iZhlZ+7KXelm+uGcjIpJU4skNgPv7U2R5d8hDGaTX4A==
X-Received: by 2002:ac8:53c5:0:b0:440:47d9:d304 with SMTP id d75a77b69052e-44047d9d5edmr22083151cf.5.1717794296543;
        Fri, 07 Jun 2024 14:04:56 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a? (p200300cbc71a220031c44d181bddfb7a.dip0.t-ipconnect.de. [2003:cb:c71a:2200:31c4:4d18:1bdd:fb7a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4403895d7f4sm15361921cf.19.2024.06.07.14.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 14:04:56 -0700 (PDT)
Message-ID: <b57e5bc4-eb72-40e3-add4-57dfa6e03df6@redhat.com>
Date: Fri, 7 Jun 2024 23:04:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/highmem: reimplement totalhigh_pages() by
 walking zones
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240607083711.62833-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.06.24 10:37, David Hildenbrand wrote:
> Can we get rid of the highmem ifdef in adjust_managed_page_count()?
> Likely yes: we don't have that many totalhigh_pages() users, and they
> all don't seem to be very performance critical.
> 
> So let's implement totalhigh_pages() like nr_free_highpages(),
> collecting information from all zones. This is now similar to what we do
> in si_meminfo_node() to collect the per-node highmem page count.
> 
> In the common case (single node, 3-4 zones), we really shouldn't care.
> We could optimize a bit further (only walk ZONE_HIGHMEM and ZONE_MOVABLE
> if required), but there doesn't seem a real need for that.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/linux/highmem-internal.h |  9 ++-------
>   mm/highmem.c                     | 16 +++++++++++++---
>   mm/page_alloc.c                  |  4 ----
>   3 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index a3028e400a9c6..65f865fbbac04 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -132,7 +132,7 @@ static inline void __kunmap_atomic(const void *addr)
>   }
>   
>   unsigned int __nr_free_highpages(void);
> -extern atomic_long_t _totalhigh_pages;
> +unsigned long __totalhigh_pages(void);
>   
>   static inline unsigned int nr_free_highpages(void)
>   {
> @@ -141,12 +141,7 @@ static inline unsigned int nr_free_highpages(void)
>   
>   static inline unsigned long totalhigh_pages(void)
>   {
> -	return (unsigned long)atomic_long_read(&_totalhigh_pages);
> -}
> -
> -static inline void totalhigh_pages_add(long count)
> -{
> -	atomic_long_add(count, &_totalhigh_pages);
> +	return __totalhigh_pages();
>   }
>   
>   static inline bool is_kmap_addr(const void *x)
> diff --git a/mm/highmem.c b/mm/highmem.c
> index bd48ba445dd41..3c4e9f8c26dcd 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -111,9 +111,6 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
>   }
>   #endif
>   
> -atomic_long_t _totalhigh_pages __read_mostly;
> -EXPORT_SYMBOL(_totalhigh_pages);
> -
>   unsigned int __nr_free_highpages(void)
>   {
>   	struct zone *zone;
> @@ -127,6 +124,19 @@ unsigned int __nr_free_highpages(void)
>   	return pages;
>   }
>   
> +unsigned long __totalhigh_pages(void)
> +{
> +	unsigned long pages = 0;
> +	struct zone *zone;
> +
> +	for_each_populated_zone(zone) {
> +		if (is_highmem(zone))
> +			pages += zone_managed_pages(zone);
> +	}
> +
> +	return pages;
> +}
> +

Another (later than usual, but better late than never) build bot complaint:

diff --git a/mm/highmem.c b/mm/highmem.c
index 3c4e9f8c26dcd..b14771fb05ed1 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -136,6 +136,7 @@ unsigned long __totalhigh_pages(void)
  
         return pages;
  }
+EXPORT_SYMBOL(__totalhigh_pages);
  
  static int pkmap_count[LAST_PKMAP];
  static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);

-- 
Cheers,

David / dhildenb


