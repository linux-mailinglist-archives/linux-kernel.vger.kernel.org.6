Return-Path: <linux-kernel+bounces-328752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AF397884B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C39A1F27A47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791513C690;
	Fri, 13 Sep 2024 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DRsXWfhJ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7A83CD6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253903; cv=none; b=ClD2aErktIwcPA9m6vcw3/9qZdv6IzjV9qKeffaS6xHg2NkbuPzqWw9x0oWdyIn29VB1PrNCWm77hxS07kpL2ob99rpbceQPbcf6hfNOYiLo/uTAlYcelS1tShEjaG7BFyiE0qjhUqbtdSCZMo7ZjgdgYPYDTnTSFCeIx1DTSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253903; c=relaxed/simple;
	bh=fOQe/MFa6wz9Dv/6AV8Uxi9LSglbhZWH8boe0/4m5vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDal0vhIkvlPipJ4cTuKFq+uCkfsChFl75QaHq1N88Fluss8ijxbkShH2fa5u8sbYqfFDD5V0FuXYWmRtGTk+2UEtDRqhLc8Dr7OngIdCVjtlsWrt6eCxhi9kOBKVDkEaqVUsI1JlNI6zBnJrOhdcJFvf+n5M2VyiD0uXXkrC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DRsXWfhJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-535dc4ec181so2247216e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726253900; x=1726858700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3J4NFIOs0+/FX7PgSd9/Ty6QD31sDeKjmeTpTdP0F8=;
        b=DRsXWfhJ+Vm4AbjlmFP3Qta3Me8nKSlLAwhO3TQuW5GK4HX4WQWd5eqytUg/V0Us0o
         Els3eaW9iGHyphOZG4biHXQzSZOVweMdFWxvfxMTuOFnKJ7W5UAT480iOz/cnGi9w7T4
         b6wyNcsF3zbUuM85ltyr94IBuUJ0QUKcA9ufabnc2SQ0GePqck4ttG26n7an9uQUEm99
         MI8taczgeXfmsLU2BJoGd13pVvqYS8v4HLrkOPjSqJTswQ5jwIzntj+SLwyIXSY5AUk3
         1hPJM5oE64L8sD1X3aUh1MzwPqCgc4cPiUAfwL4Qa79Orl7qSBgZZXdic266nrCXDPQH
         SMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253900; x=1726858700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3J4NFIOs0+/FX7PgSd9/Ty6QD31sDeKjmeTpTdP0F8=;
        b=Y7c5pYC1JUKtMpifs+PX1Ci534Avgp7yaxjO0Zr8miJYtUeYD2YACy2en9vkhEjVcB
         ituv7hgdlF/ZQ52ZyYFz4Y3M36ilK7TquGodtAa2JQC68i0698MC1Tp0ATw9sR30voTf
         GHfeu2Ep9wKEPqIRTbMIKC7+aFjcz+TdygGKhXeVqot19oFr5jG7VYJci63anXaXsSpt
         Wwgq+3qYLMv5GSgu4heGvymBZHO2tx7lz5hPpLbkZI0E1f17vd7tUzsEDa1m41uvh3ai
         rN9M/9cSEkYhn4CbJ1swcG/QaRRjnyljWRiCIunPj84x9TjfszBs5tOJ6q388HFQhCzK
         DWMA==
X-Forwarded-Encrypted: i=1; AJvYcCUmwurpyhTFRA801LLI/NaElaoBlorEfkMmyIsmsOA6QmMZvEwXhCWxrsedg/rAvCoNlXSw+pSHkqtHGgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTsSGcKSI+cS9MVE5dy3/lu8aEnabKjEDsdWgoOFNOjLL0Pz0
	gYBZG6h/xM6Kv+6wfeasdtD5hm0LOF1NFcXF0ecYhUHXbuxdW17HkYzzghVXyQ==
X-Google-Smtp-Source: AGHT+IF5N3upnOExA4ETmw6SPMAW1YtxHaD4AcLqU3pOspc/IzZqS/Fny+Rg32WkLJRydanP7pzleQ==
X-Received: by 2002:a05:6512:220c:b0:52f:df:db40 with SMTP id 2adb3069b0e04-53678fec496mr4582246e87.56.1726253899415;
        Fri, 13 Sep 2024 11:58:19 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835abbsm899355366b.9.2024.09.13.11.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 11:58:19 -0700 (PDT)
Message-ID: <a0b0dec5-03c1-4b69-aa0e-65771251d859@suse.com>
Date: Fri, 13 Sep 2024 20:58:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240913145655.10076-1-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20240913145655.10076-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.09.2024 16:56, Juergen Gross wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  {
>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	unsigned int order = get_order(size);
>  
>  	next_bfn = pfn_to_bfn(xen_pfn);
>  
> +	/* If buffer is physically aligned, ensure DMA alignment. */
> +	if (IS_ALIGNED(p, 1UL << (order + PAGE_SHIFT)) &&

Why this check? xen_swiotlb_alloc_coherent() guarantees it, while
xen_swiotlb_free_coherent() only checks properties of the original
allocation. And for xen_swiotlb_map_page() this looks actively
wrong to me, in case that function was called with offset non-zero.

Unrelated to this, but in related code: xen_swiotlb_alloc_coherent()
can't validly use XEN_PAGE_SHIFT, can it (in the way it does at
least)? If XEN_PAGE_SHIFT < PAGE_SHIFT, and with order calculated
from the latter, the used size will be too small afaict.

Jan

