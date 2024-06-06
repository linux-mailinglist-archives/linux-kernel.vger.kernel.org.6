Return-Path: <linux-kernel+bounces-204982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF18FF5CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6695B1F23701
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1CB76033;
	Thu,  6 Jun 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnS9aOos"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115E7346D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705367; cv=none; b=RZ3ISdNa9YR/XyQCgD31HnOekE0yE3r33XNwlg3g+C3LJY6yAQdIvWws43738o/TuI/SEFI/KQXQ9oEspLZMXn0NT2ulj/z4Km9qglojRHukUuzljVzzLS3JPON98vhQtl53NBQGzvqpkpJpR5NIpYcBCtechs5VBvdAXzn8lK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705367; c=relaxed/simple;
	bh=JeBUDnMKVfpJr0TkZJcp1wl/7X4cDkMaDDX0xVYHZWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDP7qQg4LW5rjRps/evD32yXUKzPffMd2oGUplDhJc/kC7K/VHj1Hweh3kh8H7XpSbp+b6xBfiqNPC09CDmviTPgExuyLHYGXiZxiFdI9RUlkEbfCRtL9H6cxSGLfuVNlKpXHae/NxVlsMyg8ePKP1STcIJ0YCMsXz2Z2tLVMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnS9aOos; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717705365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UJYConuOmjxkpxSYYb3zweMZ2ZL8lD/f7tr+L1VdyrA=;
	b=BnS9aOosdi9484w0BOzMU6oEqYcGnfklxC/iqaHwfYWgewdO+LUGBGS0VnlvM0F4FRfIKe
	cHf5BO4kf55umjP8/jGRZKLvjF3Bz0SaCkhZEA3s8Vo3ZB4BdGktG+Wt7ad/jj/ZZNAf8L
	8C3y9Roy+LMKNJin6gxLQtkJ6M76eeY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ORU42ZwWMUOvPv7FMWsfpQ-1; Thu, 06 Jun 2024 16:22:43 -0400
X-MC-Unique: ORU42ZwWMUOvPv7FMWsfpQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35e7cce4c32so946074f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 13:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717705362; x=1718310162;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJYConuOmjxkpxSYYb3zweMZ2ZL8lD/f7tr+L1VdyrA=;
        b=EnRNnyc0eDz5YGeohGPAIqQv4812+nZllOTIv44t1LLtwDRLwflTda3UvSO9IDscEo
         SV9Sbuf0kUaQ6VlmxEnV/N7bmbTX9XgPQK/0p7pU3HFLsyOKZRj3qA+bSxUOSL1ADrU/
         Zk2wkM4FvqsEJ8hLu+416BWnDCED5lCwNw5ty4IKBCP+yXUvfPyV5wGBR+jsRgxa/oBY
         6VLuj8SdsgtBEOLfOOZ4i3pyqj45VLBI9Plb/NTvnAWp838f5yrwXP+ffYccqA1EHG0r
         z08cWXmmzawPeoc0yYuOa6qYwWsPUclaFI9ylu8xqnZJUZU2eSoqB43DSPZnhN1iF/W4
         iJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXhc7ts1VkrqBw2yk9Oztk+0kOyiD/M/DohnP1gT14HrVtYc4bfeOmMc6OK3SYZQuhb0jI/MSnazvql7B3TTL/Hjjw+xFECHCWgD75
X-Gm-Message-State: AOJu0Yx1s7UVVMxOCnXFkrad9uOgbL/CCR2XEeyj3vluwdVfK3DTUk0/
	p3YbRNnnAyxncm//yrkad4kmNE897RxGkFj/WVSY6oGfY7zSF/Z1/0aaoe9hjRqj5al+OvHkGrF
	0L1fWO/RYRDjkF03aq8xQNBLS5EUcCzLasXHPiNpSEa/92JqA6qORSegi4d2FOg==
X-Received: by 2002:a05:600c:3b9f:b0:41b:97c5:ccc7 with SMTP id 5b1f17b1804b1-421649eb530mr5963205e9.8.1717705362565;
        Thu, 06 Jun 2024 13:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeYyehxptnmcB69vL9Row5RFnohDXbcJmbkKt5kqshziMO7lhLav48rNll5703KmaiZ9WnzQ==
X-Received: by 2002:a05:600c:3b9f:b0:41b:97c5:ccc7 with SMTP id 5b1f17b1804b1-421649eb530mr5963045e9.8.1717705362080;
        Thu, 06 Jun 2024 13:22:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42161147811sm17904025e9.18.2024.06.06.13.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 13:22:41 -0700 (PDT)
Message-ID: <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com>
Date: Thu, 6 Jun 2024 22:22:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is
 attempted
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240606184818.1566920-1-yosryahmed@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240606184818.1566920-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 20:48, Yosry Ahmed wrote:
> With ongoing work to support large folio swapin, it is important to make
> sure we do not pass large folios to zswap_load() without implementing
> proper support.
> 
> For example, if a swapin fault observes that contiguous PTEs are
> pointing to contiguous swap entries and tries to swap them in as a large
> folio, swap_read_folio() will pass in a large folio to zswap_load(), but
> zswap_load() will only effectively load the first page in the folio. If
> the first page is not in zswap, the folio will be read from disk, even
> though other pages may be in zswap.
> 
> In both cases, this will lead to silent data corruption.
> 
> Proper large folio swapin support needs to go into zswap before zswap
> can be enabled in a system that supports large folio swapin.
> 
> Looking at callers of swap_read_folio(), it seems like they are either
> allocated from __read_swap_cache_async() or do_swap_page() in the
> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so we
> are fine for now.
> 
> Add a VM_BUG_ON() in zswap_load() to make sure that we detect changes in
> the order of those allocations without proper handling of zswap.
> 
> Alternatively, swap_read_folio() (or its callers) can be updated to have
> a fallback mechanism that splits large folios or reads subpages
> separately. Similar logic may be needed anyway in case part of a large
> folio is already in the swapcache and the rest of it is swapped out.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> 
> Sorry for the long CC list, I just found myself repeatedly looking at
> new series that add swap support for mTHPs / large folios, making sure
> they do not break with zswap or make incorrect assumptions. This debug
> check should give us some peace of mind. Hopefully this patch will also
> raise awareness among people who are working on this.
> 
> ---
>   mm/zswap.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b9b35ef86d9be..6007252429bb2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
>   	if (!entry)
>   		return false;
>   
> +	/* Zswap loads do not handle large folio swapins correctly yet */
> +	VM_BUG_ON(folio_test_large(folio));
> +

There is no way we could have a WARN_ON_ONCE() and recover, right?

-- 
Cheers,

David / dhildenb


