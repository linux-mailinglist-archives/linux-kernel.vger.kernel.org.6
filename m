Return-Path: <linux-kernel+bounces-276135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13F948EF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94524283A69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAE1C0DE7;
	Tue,  6 Aug 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyhXNQ7t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E3166F03
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946711; cv=none; b=qkqMXfpEp2xix60rNC4r55kN+7FaLNGCQIDAzilLpSDifAq7QHZDCg5PuvUErQ2cUUsoseGPWUVyS9E0iD1KCy2I4s6bckgZNgYotbaQkSDDsREaqvuCikFMkdVNkf+dgD/vBoZOkZ3TYOgBj5gLSq9et1rhiOxLLcOrQcQbAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946711; c=relaxed/simple;
	bh=3b4qJYAJ7EvBsPYd455o6b6mI+QjxnaxBDvI6QsOcp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKixZTvVItNOxbgHJOaQfhcvEycgHC7qAOfDvmlOjl35T3PN4FrghOe29r5FROM8RmMA13ltnDuuOk2am1gFwwWinJT8PmM9PzYsf1HW/kWvst8bWEoWD2qQtVbvRl259FQueinQliTAQw8cj/QditG5wkx/5oOJcqfwC/g/UlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyhXNQ7t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722946709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XTQ3Sm3GBhzdyX/jjoxrBMSZXzyZ+mWBG0VUwn89YM4=;
	b=iyhXNQ7ttcRLgVL7PMEr5sSfQHJTllFRQ+d6OvsAXjaDBie82UQ68hAL1a/QkIgCWNU/f4
	QqHVfzwG7JnY8J/1ZGjY1wsXiYAgQ5MIqXHE41wdHAswhhHYmAezNQDlFrRyrJPsp7lryq
	wYCipSJyjUB1JgHqJ2INg08Ge3wRlEI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-DHB151wPMwuelddL_PLWDw-1; Tue, 06 Aug 2024 08:18:27 -0400
X-MC-Unique: DHB151wPMwuelddL_PLWDw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36873a449dfso3315241f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946707; x=1723551507;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTQ3Sm3GBhzdyX/jjoxrBMSZXzyZ+mWBG0VUwn89YM4=;
        b=FNGpKfjt4Z5XCmtuP6vxuXbDa7k7b9GgSDY7dxgsYcrwUEz2x1oL9yFBhOTvZiUCzc
         k9nZG4+A+EZJBjqUlymNjZZVvyHtAjB94OzE6rdYO7sKMYkMC3nRUC21GNJQLT0d05VQ
         xd2DrCIOB3KxqVLgq4MkS7IL2S2/eN10hTD5k9B+OvW1a8mPgwL9O6qdgeYz9pzEP+7O
         WFiAfXtau+zvZ04hX/XAwP38/3Bbtg7+RSCmUqeZYKzv9Heuv4QoUmcVL0W8ygOs6jGB
         dJD4g6KaFmDzudkMsIhi2L+X9MrpHlHKcJIyw5DRfnZhL/xhb3xffYrT4mrBgJIElIdz
         MH2w==
X-Forwarded-Encrypted: i=1; AJvYcCWjtHRcTdeCC8R0Zbs4/f/ry4s3BVktCf4w8EQJWsfLF6wtjGD5nsGb/5ifpHTCMQGQZ3Bs7gltKJycYHBvH/e5EzzRBjnihuNjuSy5
X-Gm-Message-State: AOJu0Ywj5vrkE+CHY/TXbQB/K+ydkKzych4FNqAI49YfhMoHkO1BGh/g
	/KhwYxyX9xcWdlGfdIJ9kwC1tpjeosQJA7L+OD5AWtGOo+UQZlNlsv049pdp/3SpUJQyOVyPtPr
	LptEMu9QaFMOwC2JkmK+N4gCk8k7ZWpb3B0GzdeEKt+i4hCCANyKmQjmhN8IU7w==
X-Received: by 2002:a5d:484b:0:b0:366:e9fa:17b with SMTP id ffacd0b85a97d-36bbbe1a4a8mr11107203f8f.1.1722946706732;
        Tue, 06 Aug 2024 05:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVV1hklLNf/6gvzRzkk3kTfRY69rs7uxT52S0nGS0j2zvqjz+RySHSrJBnDOiuAlxsvDenTQ==
X-Received: by 2002:a5d:484b:0:b0:366:e9fa:17b with SMTP id ffacd0b85a97d-36bbbe1a4a8mr11107178f8f.1.1722946706230;
        Tue, 06 Aug 2024 05:18:26 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01402csm12843805f8f.39.2024.08.06.05.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:18:25 -0700 (PDT)
Message-ID: <4220779f-1037-444b-b835-1732d497b9a2@redhat.com>
Date: Tue, 6 Aug 2024 14:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] mm: Rename accept_page() to accept_page_memory()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-5-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805145940.2911011-5-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 16:59, Kirill A. Shutemov wrote:
> Rename the helper. The accept_page() name is going to be used for
> different function.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/page_alloc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a35efb114496..34718852d576 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -286,7 +286,7 @@ EXPORT_SYMBOL(nr_online_nodes);
>   #endif
>   
>   static bool page_contains_unaccepted(struct page *page, unsigned int order);
> -static void accept_page(struct page *page, unsigned int order);
> +static void accept_page_memory(struct page *page, unsigned int order);
>   static bool cond_accept_memory(struct zone *zone, unsigned int order);
>   static inline bool has_unaccepted_memory(void);
>   static bool __free_unaccepted(struct page *page);
> @@ -1263,7 +1263,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
>   		if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
>   			return;
>   
> -		accept_page(page, order);
> +		accept_page_memory(page, order);

I wonder if we can do better at naming.

Naming them accept_page1 and accept_page2 might be just as confusing as what you use here.

And I think we better just don't have this "page" wrapper here at all and just move to
memory ranges.

After all, the page contains no information we need here besides the PFN.


What about:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a8bdfa742e1..5dc4066f35b3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -286,7 +286,6 @@ EXPORT_SYMBOL(nr_online_nodes);
  #endif
  
  static bool page_contains_unaccepted(struct page *page, unsigned int order);
-static void accept_page(struct page *page, unsigned int order);
  static inline bool has_unaccepted_memory(void);
  static bool __free_unaccepted(struct page *page);
  
@@ -1262,7 +1261,7 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
                 if (order == MAX_PAGE_ORDER && __free_unaccepted(page))
                         return;
  
-               accept_page(page, order);
+               __accept_memory(page_to_phys(page), PAGE_SIZE << order);
         }
  
         /*
@@ -6975,11 +6974,9 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
         return range_contains_unaccepted_memory(start, end);
  }
  
-static void accept_page(struct page *page, unsigned int order)
+static void __accept_memory(phys_addr_t start, phys_addr_t size)
  {
-       phys_addr_t start = page_to_phys(page);
-
-       accept_memory(start, start + (PAGE_SIZE << order));
+       accept_memory(start, start + size);
  }
  
  static bool try_to_accept_memory_one(struct zone *zone)
@@ -7006,7 +7003,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
         __mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
         spin_unlock_irqrestore(&zone->lock, flags);
  
-       accept_page(page, MAX_PAGE_ORDER);
+       __accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
  
         __free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
  
@@ -7071,7 +7068,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
         return false;
  }
  
-static void accept_page(struct page *page, unsigned int order)
+static void __accept_memory(phys_addr_t start, phys_addr_t size)
  {
  }
  

It would be even easier if accept_memory() would just accept start+size.

-- 
Cheers,

David / dhildenb


