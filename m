Return-Path: <linux-kernel+bounces-276099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B50948E56
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080772819A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AFB1C3F02;
	Tue,  6 Aug 2024 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGcsnBuH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8292E166F2F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945972; cv=none; b=gsfCU5Ua7TqGYlKJ4UMsmm30o914BhPWtImDzPlCMLdTJ6biTXbOSvS+ovxobcOVi5vFmqtsVVw3eeCpoArS+SRI1DKwuiIXScZ+I7DaPUz8miM/aFRGrPVgf40El273kupBsBFPNVJy0O1PbO+T68FtiHH3z7cutXlXAvpkn4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945972; c=relaxed/simple;
	bh=mZcq5beBIssVWimtksyuopUaPBxztHF66lndE2lN704=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tzc7Pudq+HyWi6DteHqkLa4CqPUMF/S87Vbl50QN3GVj80xTWNCu8bblrrHXiXZZjaJ/QE3BG5g9W7rHbJk6VkcRa/44LuzCtShbmpEQHlbf4vky+zMko+VD6nLxk7KJVuK1o0Ry1qWOoM59rCg1ZsFPT4iWMQHZDFjaLSJ2m3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGcsnBuH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722945969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XXjP/8sFGXwn/WKfJmwc1853FXZeH/QqyFf/fRlwTCo=;
	b=ZGcsnBuHCnZ8yhd4/saNB9LcrWPEUvcszBivHLanWggN1+boUheE4sy7ho8+eMGKzkiHa8
	IWovEcQi2R+trhaf19o/Q7yhs2Kdp+A3Lbyxp36Vb40F9a+0snR+zyySEfKQ1ZEfRKvidG
	j0Snhe4THBPmxvU3PJfwWAVH2eMI4sw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-x1jg8enYOk2ZKB3KK0nmcw-1; Tue, 06 Aug 2024 08:06:06 -0400
X-MC-Unique: x1jg8enYOk2ZKB3KK0nmcw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7aa7e86b5eso53085866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945965; x=1723550765;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXjP/8sFGXwn/WKfJmwc1853FXZeH/QqyFf/fRlwTCo=;
        b=pJa+1bjYafLZgz5O173H9vA3pHV83VHd05cY/yAugeyR/DV4SiEx5ehlhSs5JHy5Lf
         KOzWZFONBLoebaR38ayjwjMbzywJHLEZfVY6qlnNxCXaKc1gKK4QH+OF4ad7TbMExp7m
         yf0rKK4DGF6bVm1kShg2EGy1UI1CeLDYWqAwM1JmFM7UcgG98XwqnVGdbwlre8x1LLUM
         ivTxp7Dd5ZLYhug1GD/VYhIHAtiWvJTE8tCQFEM8dYzgwQdIo5cYXQUBB8xlfTW5mvJp
         +NOKxND/thaO0l3IWaoEXVqXYmlHz+eEG172nGLSascfaR55MV4FqMGy6WV4rliCXl0D
         X/nw==
X-Forwarded-Encrypted: i=1; AJvYcCUdzqoYa0XJWYgpuByl2g1EjQJPFD7YNrzeolXwaMXP7lsmdVN2Z/cgQr1MlPbffV4tz+Mhi8AcpduRAjWnTv24EEg0oBiLCIVjvudk
X-Gm-Message-State: AOJu0Yw0ygZL1qwTFKV/ODEZQ6o2euz/DRhkl5m7ZV+l6ozp8eukno1S
	1QwQjl6xsmUdwWq/Py7pYpgDQDMWX2v0MfMF4Kp8upESc7tJGCGlAYNiS4KDf4VXdPrlsys9oZd
	/mghskm/rUgyI9qJnW6t/Pw2QTo2UMfHip8U5HATsxGY18ouMifvBeiR5jmimsQ==
X-Received: by 2002:a17:907:7f11:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a7dc5106dfemr1124568166b.54.1722945964901;
        Tue, 06 Aug 2024 05:06:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkDYU2UgvrKGaQznl3n8Pfd2mbKXM72SmJNAO94B/l91wD5LFREG1boiddijoQR3kYfNHQrg==
X-Received: by 2002:a17:907:7f11:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a7dc5106dfemr1124565566b.54.1722945964357;
        Tue, 06 Aug 2024 05:06:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecb546sm541735866b.224.2024.08.06.05.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:06:04 -0700 (PDT)
Message-ID: <56be9c2c-6f44-409f-bb66-3bb488f0d546@redhat.com>
Date: Tue, 6 Aug 2024 14:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] mm: Introduce PageUnaccepted() page type
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-4-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805145940.2911011-4-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 16:59, Kirill A. Shutemov wrote:
> The new page type allows physical memory scanners to detect unaccepted
> memory and handle it accordingly.
> 
> The page type is serialized with zone lock.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   include/linux/page-flags.h | 3 +++
>   mm/page_alloc.c            | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 5769fe6e4950..e19eac9c2b5c 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -943,6 +943,7 @@ enum pagetype {
>   	PG_hugetlb	= 0x04000000,
>   	PG_slab		= 0x02000000,
>   	PG_zsmalloc	= 0x01000000,
> +	PG_unaccepted	= 0x00800000,
>   
>   	PAGE_TYPE_BASE	= 0x80000000,
>   
> @@ -1076,6 +1077,8 @@ FOLIO_TEST_FLAG_FALSE(hugetlb)
>   
>   PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>   
> +PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)

I'm sure you're able to come up with some documentation ;)

> +
>   /**
>    * PageHuge - Determine if the page belongs to hugetlbfs
>    * @page: The page to test.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 90a1f01d5996..a35efb114496 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6972,6 +6972,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
>   
>   	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
>   	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
> +	__ClearPageUnaccepted(page);
>   	spin_unlock_irqrestore(&zone->lock, flags);
>   
>   	accept_page(page, MAX_PAGE_ORDER);
> @@ -7030,6 +7031,7 @@ static bool __free_unaccepted(struct page *page)
>   	list_add_tail(&page->lru, &zone->unaccepted_pages);
>   	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
>   	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
> +	__SetPageUnaccepted(page);
>   	spin_unlock_irqrestore(&zone->lock, flags);
>   
>   	if (first)

At the point PG_unaccepted is set/cleared, we don't have another type 
set, right? (IOW, PG_buddy is only set after we cleared PG_unaccepted)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


