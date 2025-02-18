Return-Path: <linux-kernel+bounces-519304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91D8A39B50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4D3B44A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B322E00E;
	Tue, 18 Feb 2025 11:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gvj0mSq/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90A22D4C3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879130; cv=none; b=WAoqJKmbTHyzoZ2BIDM9SWV2hBEWaa9V0TBzNFrQfxwtJxrSYHz536W10VKYYFcwwDYEkoo9VxhacO++/RiAbNveMmWzkM3tpViTIGBKvqCfPIpJ0HpkXzwHjIpdhiYcHe6sa9glWkEunK9AZapolDVkq+aIcDs3yF3+ISm8mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879130; c=relaxed/simple;
	bh=5wZBwJF3DURRLD3pbvA28Ji9opCVMP2md2RtY1Dj+Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD7eK198DqTQwRtPXqkkomGobEag1jlvwndEhgYO9+Is837h2cV0veygkgzkmSiBnfgONGlm2uYSXrGivuPaNOZxnHLhvj84EBJ7qjuofl5+cmiAOFw8Ozc6TCSPOmS/CYTwgm+4GWL8IGCbYR8yN8tJBd1+rGX2MVDnbOomZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gvj0mSq/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739879127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jHCRDL3N6ULifpYh9V9jXw9NcsVelDBQD1Fd1IVvKV4=;
	b=Gvj0mSq/p72aF0yzKJNIBBiVN9F4QFzoXL0zI3yD0RuseNvuuEQXjgtILosoyOrK/6gaOG
	evhBbSu7T9wPIO+o7130n3so0GuzpanE1b0saZ82IJaiC0PBkI9amfGId0z3LBXfvhGbBB
	tGl/PauoAGOVLyeaHV4OviZ/hJHC5vA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-O5BjbdgtMcitqmZOzZ0SVA-1; Tue, 18 Feb 2025 06:45:25 -0500
X-MC-Unique: O5BjbdgtMcitqmZOzZ0SVA-1
X-Mimecast-MFC-AGG-ID: O5BjbdgtMcitqmZOzZ0SVA_1739879125
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2726c0faso4985683f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739879125; x=1740483925;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jHCRDL3N6ULifpYh9V9jXw9NcsVelDBQD1Fd1IVvKV4=;
        b=ODjpSyxGk2UBQ3tEfPU9iXUpYmHluS4hddfiVLAZ+IwASbjty7eD/iMBWOgBwTZ9oX
         j+D8EUc4cTJiSFHCj7Yh/yzG3cn3yr739Q59Z+G6uxEAvqOGJpkEFhjpokBieSpceB30
         ZuQBuSyCFEu11+XzwWKCREdR7NDbZ6mAZn65reMIWhAuQVcO5hvj5SvQDo25cTqS9+hZ
         ++kmlR+utXLOo1q/su8zWMd1lZmBwsG9WVTfoU9BkYW+WpoG4XHWIWbs4kSmZ/x+5V2N
         BGAXapViz6Eh+9SKCDGUIe7LIyu7CYsHyn4TZXk1kqk0zMyAXdcM/erI6C4+OMJjqHLl
         A+xw==
X-Forwarded-Encrypted: i=1; AJvYcCWltugVjKp7mbErZNRsgYDcozA3XseawhresxjU8D9Hi3ORwKVxnXiV0BWSruyrDX6lbAaDtH3qJmkxNac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvMxmVj8qJ5IZapHugaevMlMHDaPkOg2lhaqoXrY5RR/iqUTc
	rTf/kce0O4du4qjPKPQiyMKczxqhda9HQWuYpzyolSkW7a2nv6vpKO6mfMzsw4mWwT+17DPS9SA
	x0gZcg6mylrVAbtXH3rq9H4F8Ilntt76CCHJtoxnTmDTMkC3dRM5DzUgwXCkc8Q==
X-Gm-Gg: ASbGncu15DRmAaLpBZQ2AZXGY3IgjsOdwAr0NFDBKzilQFUg4MRyZEW+YTN7cgdxTcd
	o5F6rNy1Ap7ej3L8Qfs4iW7ztWoYlsqkcnhtH6xwVKdVtf/RX0CHl+BxAV9fWcWsxrkSlymbkfZ
	SvXNovWT/cdeJw1qJHaw4lgq2o6tUatk8myaqpslk7nPZWiEiQvdOnXkLnBshqu3S14K9HEgw+f
	AQIlRqTveV+xj/eafGIygVEADIeGHk9kJ7g4S5AQ3flin6fKl5VJWPzyp0JLVrMpgo1JBC7DSM9
	Eg+hFM+nl6TjeIEQ+o8AQaaNYLr6BVZLt9UFToOmUq9yEzBfsx8O5/SbVBKZQqK1byM3UPjCgN9
	ElIWclpS+saDyG+a9Tg6RUxLZH/Z6wPCQ
X-Received: by 2002:a5d:64cc:0:b0:38f:4fcf:d295 with SMTP id ffacd0b85a97d-38f4fcfd742mr3662926f8f.29.1739879124702;
        Tue, 18 Feb 2025 03:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsFXXMwCROy1d+x8L7bQgHNOWiWB5gC6PdvAD/2PVCCKaRqrUGaEoHc5Js+VvCyBvaSCkafA==
X-Received: by 2002:a5d:64cc:0:b0:38f:4fcf:d295 with SMTP id ffacd0b85a97d-38f4fcfd742mr3662893f8f.29.1739879124157;
        Tue, 18 Feb 2025 03:45:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395cf084d5sm123622275e9.1.2025.02.18.03.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 03:45:23 -0800 (PST)
Message-ID: <f5c31616-41e8-464b-84ec-8aa0cedfa556@redhat.com>
Date: Tue, 18 Feb 2025 12:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mm/hugetlb: wait for hugetlb folios to be freed
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739878828-9960-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1739878828-9960-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 12:40, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing
> of huge pages if in non-task context"), which supports deferring the
> freeing of hugetlb pages, the allocation of contiguous memory through
> cma_alloc() may fail probabilistically.
> 
> In the CMA allocation process, if it is found that the CMA area is occupied
> by in-use hugetlb folios, these in-use hugetlb folios need to be migrated
> to another location. When there are no available hugetlb folios in the
> free hugetlb pool during the migration of in-use hugetlb folios, new folios
> are allocated from the buddy system. A temporary state is set on the newly
> allocated folio. Upon completion of the hugetlb folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it is
> directly released back to the buddy system. However, due to the deferred
> freeing of hugetlb pages, the PageBuddy() check fails, ultimately leading
> to the failure of cma_alloc().
> 
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>      ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>          ->unmap_and_move_huge_page()
>              ->folio_putback_hugetlb() // Free old folios
>      ->test_pages_isolated()
>          ->__test_page_isolated_in_pageblock()
>               ->PageBuddy(page) // Check if the page is in buddy
> 
> To resolve this issue, we have implemented a function named
> wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
> folios are properly released back to the buddy system after their migration
> is completed. By invoking wait_for_freed_hugetlb_folios() before calling
> PageBuddy(), we ensure that PageBuddy() will succeed.
> 
> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in non-task context")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>



Acked-by: David Hildenbrand <david@redhat.com>
>   
> +void wait_for_freed_hugetlb_folios(void)
> +{
> +	flush_work(&free_hpage_work);

BTW, I was wondering if we could optimize out some calls here by sensing 
if there is actually work.

In most cases, we'll never ever have to actually wait here, especially 
on systems without any configured hugetlb pages etc ...

It's rather a corner case that we have to wait here on most systems.

-- 
Cheers,

David / dhildenb


