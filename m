Return-Path: <linux-kernel+bounces-276095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC4948E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B59281B84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E11C3780;
	Tue,  6 Aug 2024 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0w/Z9Dv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10683165EFA
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945762; cv=none; b=S0XyAPcJCWINYdurVFpg+faEa3yc5wKEUzjqOpFX6VlBV+GHmiS/wD9amBKJpuSHX7C+Z8pkQ6R9AdGVK0OKAdfTRj9/dHU1Sx40YYYdOCFBwDbEGOV6xdL66OIR/HUz4Yt8IlMXBVATj9SvN4BpvdAq1hbcMbOHkv7ENvfma5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945762; c=relaxed/simple;
	bh=Z5h1Jsi57J8sln7ZgWt6/obaq6kyMeAW44PiB75lQxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gsewgBfLwYpn+Bbhv6M0CrbGe28iBJLlKJD6mONjKdVLgjH9eKZSzlTwhF0/Y17EKGGHj+SweJo3mctdCbUU0MbdSKxVyRKGgq8ycYbUoCs0OsNeqMQfgYKDWZJoqQfJaRGGdNUHwed4ep2luKW9BZvgtKQDj7VAtqTSkk+OyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0w/Z9Dv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722945759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rfRkYxe/SPAMiYh4vQI2fbfDI6Yat+EMEMpDOx9VDW4=;
	b=L0w/Z9DvY5II9maRqmged7WDe8LYGdCvSohH3MA5GtwQAUbRQ6wpbIu7IOU3zhK/Gqgvy1
	PXLs51SNAP0E+/sop52EhPHvUB8E3lVbJbs+fKiqzRtaBNmMxQ9kfrCTOCr4rIGrTWgtFO
	HB+jl6q0ny0GqJseZ5GPGY1qleFGNDs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-PEIUjbY2MoypGTPSlGI1SA-1; Tue, 06 Aug 2024 08:02:38 -0400
X-MC-Unique: PEIUjbY2MoypGTPSlGI1SA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36bbcecebb4so443901f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 05:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722945757; x=1723550557;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rfRkYxe/SPAMiYh4vQI2fbfDI6Yat+EMEMpDOx9VDW4=;
        b=f0FbiKNp3XONlH77kMebmTv+IIlE45ZgvxhagRUwvqASsxVrAKvmYmziYUGgmG8CJz
         ztenxe6TY9qpveMkBJBGuYGXY2SBmKHoA5u1FCIxuCpLigOj4LBJXjW9JvGNezj4akY+
         rHd+YP0hd4u/HqqxljEr8PDqtNiqrB3NKuLA6cJaXPbSor90tCN9NnaNQPfSYwOXLcHW
         ZUy8gzBS1vy1nSB0X5OfLJ6tYtV6vS6ThbTjP+cdGKYgMDHkUVyifPkzAYx+TAw+IBNh
         vVmdXQeg5VmRbZHIzDXoS9a/RpyttrKTyVqMBEfStJdM4otkLuTC7O6I263mBH4es3QY
         e8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUBw7gADtRUeoID9+DOaFnMjrzjhR7WxQkJAR1wPalBRNyhcV7juG9MdxTa7dl9wWQsFbo4X0zmqwryt8OVvUnq/mDJ9motHB4ODwUN
X-Gm-Message-State: AOJu0YwzMHQsMSK8gFhy0b0ZUh9uPcDgQDlJ6LkRm9qz0hDzP54HoRKH
	6Q9D0Iv7QHPYH+ZlfmAP9lqXit4i+gn/TSmFTOpOYklQRNqb22Z2vUFGvVawp3HNkGzhrEnK2xx
	B8tvzkkBAw8LORordEytK7LYi838n/yhVsCja+wC9df4zllFJv+JCm1iMGmaUDQ==
X-Received: by 2002:a5d:568f:0:b0:368:6b56:641b with SMTP id ffacd0b85a97d-36bbc1a6754mr13444198f8f.47.1722945757391;
        Tue, 06 Aug 2024 05:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwjm93au6XMoF3owRpkCyFW+Prx88RdvN7jmkNLtTQhqujQ1NAs/T2s3CwdeRT2LuWx5QtGQ==
X-Received: by 2002:a5d:568f:0:b0:368:6b56:641b with SMTP id ffacd0b85a97d-36bbc1a6754mr13444165f8f.47.1722945756917;
        Tue, 06 Aug 2024 05:02:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d1fcsm175829175e9.42.2024.08.06.05.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 05:02:36 -0700 (PDT)
Message-ID: <2276d983-cb01-4a28-9f12-13ac924a7248@redhat.com>
Date: Tue, 6 Aug 2024 14:02:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: Accept memory in __alloc_pages_bulk().
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
 <20240805145940.2911011-3-kirill.shutemov@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240805145940.2911011-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.24 16:59, Kirill A. Shutemov wrote:
> Currently, the kernel only accepts memory in get_page_from_freelist(),
> but there is another path that directly takes pages from free lists -
> __alloc_page_bulk(). This function can consume all accepted memory and
> will resort to __alloc_pages_noprof() if necessary.
> 
> Conditionally accepted in __alloc_pages_bulk().
> 
> The same issue may arise due to deferred page initialization. Kick the
> deferred initialization machinery before abandoning the zone, as the
> kernel does in get_page_from_freelist().
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   mm/page_alloc.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aa9b1eaa638c..90a1f01d5996 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4576,12 +4576,25 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
>   			goto failed;
>   		}
>   
> +		cond_accept_memory(zone, 0);
> +retry_this_zone:
>   		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
>   		if (zone_watermark_fast(zone, 0,  mark,
>   				zonelist_zone_idx(ac.preferred_zoneref),
>   				alloc_flags, gfp)) {
>   			break;
>   		}
> +
> +		if (cond_accept_memory(zone, 0))
> +			goto retry_this_zone;
> +
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		/* Try again if zone has deferred pages */
> +		if (deferred_pages_enabled()) {
> +			if (_deferred_grow_zone(zone, 0))
> +				goto retry_this_zone;
> +		}
> +#endif

We could probably avoid the #ifdef if we add a dummy function for 
_deferred_grow_zone().

Same applies to the other similar users in this file.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


