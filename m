Return-Path: <linux-kernel+bounces-267768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5194153A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E60C1F24095
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474479E1;
	Tue, 30 Jul 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl21sMOZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457911A2C37
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352480; cv=none; b=D04+4AEmaOeXuxUtr7ts2WTIvXlSuNdP5ZJ7jemR08y8xFOJon788yCGhvvAZ/EQCR/gWe7QhGS5uazBUbkwrJVl9Otasp6pPnB7oWqzKn+COxyAP8mKjaXg2WxA349Zsjkn08smQigFyCZ+2/cP/BS6Bqg4Ft6rn+I0f97pXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352480; c=relaxed/simple;
	bh=WfZBATWUSpc1X7OXLQDWOHOV7ZM+E9jsGAUjni+l/M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ci3LlS25wvUTWNIupY5kZLs8osEyr96wfR/QbPKP32UDqWWFEpFXyfiZSLrwfEMG/Y8KsmwvcLPxZyNSKs4a3ZpX3KYhZs1/8VVe5GpHmJcSLTLSHcZSFqI8USFyFi+7rF4G2nDwK5eCJ3SbkxEYbM7RaLgcbvfLoKboq9x6ruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bl21sMOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722352478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=oT0ZG9iT3QuF9uRSAcBH+IDHAQS6HDTOjc2088YGvBk=;
	b=bl21sMOZUk066pmc5DX208sCKV61W2pktL8SG4G7jlNebNTdyvGb4AyHBe66olie6N+vvD
	hgyZR1u+eT7VeUWJ7hszcwA/492IlEUn8RWlXMoefr7HQuiVodxaxx973Y5ToLtWhRx+lh
	260zAwG3te58yWSIwtD98twtcPTUz4A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-BthGyUfGMOm8WWwTLcdylA-1; Tue, 30 Jul 2024 11:14:36 -0400
X-MC-Unique: BthGyUfGMOm8WWwTLcdylA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281e3b2f2dso18042525e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352475; x=1722957275;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oT0ZG9iT3QuF9uRSAcBH+IDHAQS6HDTOjc2088YGvBk=;
        b=eES7IoXrKSzhaNpXZaKvb9Vo4rY/YJO5pT2knAQaMS1NJ1oBKaWLyB6umg4QFHdAxA
         ryVPjZhECFMs+SdtYChpz2XDmXkKvito+M6lv0QSnH6AVkdzf2M6h5uD87I5RxvQRQq9
         nddqyt50bXdM3a1xVasy9rOAKUX/thy3e1SpPc8M+PS1FpvIFEURmKVb5qY/JNSezRWJ
         FHunk5MFeNx0sfrIX7ArJLNxYKoY716NTpuBmlIQijtGV0HF/ialOXWtuagt5SuX2RhU
         TrPY6y87tTtQQFxlwg4GzCFLj5zJRdUAgUu2PqcpbW+s5oZk/4MfbjlMl8TPoYHqtncz
         Z8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLIlZg8robwJ+ouWaDyduKetVie76sXIEJOxFygYX1oKhwbdXkIblV6nG5qIZhf7LNUMaY9Z7bbJGGshXJZOgu618KDgokt0OU003N
X-Gm-Message-State: AOJu0YxugMYjQYS/D2DxsY9R8rX1SnS4GCBPtF0irrAEAKus+y3sHGeL
	iWJHPb5ohADC9Pi70p7D6soU4+eKsA/ToyNOxWBpvIkLywt2pF2DDbW6u3hy03LKmt5xjAyxTiz
	jlgNo0kI+4csLwlphoR114RYhGFPWszkmOXFB9gfRPcSKRbDJZPpxHY2N5CLgxA==
X-Received: by 2002:a05:600c:4fc8:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42811a9e14dmr88033765e9.0.1722352475511;
        Tue, 30 Jul 2024 08:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsN1IpjWQK7tuH00C0fa4Id4qb9B3oorgnLJuJXa+AnXLIJdJJVLQ+wudRbwAtXDGBm97eFQ==
X-Received: by 2002:a05:600c:4fc8:b0:427:9a8f:9717 with SMTP id 5b1f17b1804b1-42811a9e14dmr88033535e9.0.1722352475014;
        Tue, 30 Jul 2024 08:14:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281d805323sm71607225e9.41.2024.07.30.08.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:14:34 -0700 (PDT)
Message-ID: <3be3dacd-1f45-468f-a363-b9d3a10aeb89@redhat.com>
Date: Tue, 30 Jul 2024 17:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mm: free zapped tail pages when splitting isolated
 thp
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com,
 Shuang Zhai <zhais@google.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <20240730125346.1580150-4-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240730125346.1580150-4-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.24 14:46, Usama Arif wrote:
> From: Yu Zhao <yuzhao@google.com>
> 
> If a tail page has only two references left, one inherited from the
> isolation of its head and the other from lru_add_page_tail() which we
> are about to drop, it means this tail page was concurrently zapped.
> Then we can safely free it and save page reclaim or migration the
> trouble of trying it.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Shuang Zhai <zhais@google.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>   mm/huge_memory.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0167dc27e365..76a3b6a2b796 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2923,6 +2923,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	unsigned int new_nr = 1 << new_order;
>   	int order = folio_order(folio);
>   	unsigned int nr = 1 << order;
> +	LIST_HEAD(pages_to_free);
> +	int nr_pages_to_free = 0;
>   
>   	/* complete memcg works before add pages to LRU */
>   	split_page_memcg(head, order, new_order);
> @@ -3007,6 +3009,24 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   		if (subpage == page)
>   			continue;
>   		folio_unlock(new_folio);
> +		/*
> +		 * If a tail page has only two references left, one inherited
> +		 * from the isolation of its head and the other from
> +		 * lru_add_page_tail() which we are about to drop, it means this
> +		 * tail page was concurrently zapped. Then we can safely free it
> +		 * and save page reclaim or migration the trouble of trying it.
> +		 */
> +		if (list && page_ref_freeze(subpage, 2)) {
> +			VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> +			VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> +			VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> +

No VM_BUG_*, VM_WARN is good enough.

> +			ClearPageActive(subpage);
> +			ClearPageUnevictable(subpage);
> +			list_move(&subpage->lru, &pages_to_free);

Most checks here should operate on new_folio instead of subpage.


-- 
Cheers,

David / dhildenb


