Return-Path: <linux-kernel+bounces-414604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1369D2B05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFDCB28F87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207C1CF5C7;
	Tue, 19 Nov 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrC36EdI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFF18A950
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033540; cv=none; b=fUzlCy2uOOZGmXcX7s00bJm4xD9fyFhEJdJbXISXJo6y+KRlsJWnVjkc1IJUp/QJAVDLEHDtvPBnn5cvp+VP51hcdIFiHubAZiX3Ffq9QVL6oUb1rSD51yqUVKUV1Laa9raylS2Ukr1pqWkC56HYh+BMOXzSWNWH1O4CzlBThBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033540; c=relaxed/simple;
	bh=8Z+tIvFXicXuzmTsLZAasMQYZnzX2mJ9WZ5bQS38liE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7ZIf8qsFmpqi3e1BFKvB47AQteXcJo7oGPPPDzMm85i9ELYmxo4tIXsHA39qFvTqYNzvx4eDiIvo6wwy7PneGjSpQx9kegokPVHc0oYVAKqKvG9CznGzz59y7ik61vSoIzLfucJ7Bjgvn5LnjOKd4P87AETV91CmM87CO4H31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrC36EdI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732033537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P+AkfYwNh3Vl39zkgnP+r7LIfANV0I766VFzfH39QZ0=;
	b=UrC36EdI4Au928KYOb/SYoVnledtl0OGZqTLqpqCLFBnRXSxl6t65YD/AuCN2ELa4iro+d
	1w+dm0o9/wf2J++T60tf8ZY5Vzri0jeos1jCLTDTq+JSlJs1oswgii8JJMaXIHuEf47W0+
	lzyqdi0hj/ojkAYBRIgaaLRPzRlP9/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-esgNNv21MkatbfOxPkZbeA-1; Tue, 19 Nov 2024 11:25:36 -0500
X-MC-Unique: esgNNv21MkatbfOxPkZbeA-1
X-Mimecast-MFC-AGG-ID: esgNNv21MkatbfOxPkZbeA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-381d07c377cso2475621f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033535; x=1732638335;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P+AkfYwNh3Vl39zkgnP+r7LIfANV0I766VFzfH39QZ0=;
        b=Q51Qama5/0fFqS+hin9sN83TNW30SgKYUm/K7LdVpy/uqu7ktDddR+vFB0/xtOUyRz
         6L0WvNg/KEdViESdg6G4vPFSKHAzU52OS7jnItZPUiRM2/iF+ieT4fRNt4iiEZIrI1OY
         NGCqXrc0ub29TSns8JqtRAuVn/DVMnW84fSf9hUMxgZtP49qK616qwQxJjzkyYoRvB8P
         BJ/lZsPeUcbVb2agnJ1VB3DimnXraeN1h2Ay+jiRkGSSZcuwZrZlWggmzTGl0AVuK+uG
         f64gw/tr2yzo7i6OogOmMn2XYun12K3gos7M/SgXQJC8hjUe4WP355jl2gH8jenCfBMo
         tkfA==
X-Forwarded-Encrypted: i=1; AJvYcCVpv6F8zX3q4xEuytUyD7VETSvUwN+brSjU+cEWjOqei8SJEdkq53vi67YFmHyOUYr21jOKg5CSOAjUGn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsJH/8SHyLhm/etxTfgXIR4GBrEXdySewaWI6XFaCAwDMXmbP
	jPJ4HiqyObNUtf01UtdigkPwv0ZRE4FKvtaNtvirdzuzlibpvF6w7sGKRPJEl95ZRUqUoVE3EFV
	wGYdBik2BDJXluHQv57mAN7eWwZWY2KfO1vlba8rOyhrwSFFDoQRj8PGLxcBbjA==
X-Received: by 2002:a5d:6dad:0:b0:382:4b9a:f506 with SMTP id ffacd0b85a97d-3824b9af736mr5282630f8f.36.1732033535258;
        Tue, 19 Nov 2024 08:25:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPE4jBqw/WUv0UEB08s5MCg97nejnEDkSvYi5mqV0YHsob1jqWZHauBQ9Y1+EhNRMs7128zA==
X-Received: by 2002:a5d:6dad:0:b0:382:4b9a:f506 with SMTP id ffacd0b85a97d-3824b9af736mr5282602f8f.36.1732033534894;
        Tue, 19 Nov 2024 08:25:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbeb88sm16227545f8f.62.2024.11.19.08.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:25:33 -0800 (PST)
Message-ID: <1cc67acb-8b29-44fa-9528-c9bde5fab9a9@redhat.com>
Date: Tue, 19 Nov 2024 17:25:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
To: Zi Yan <ziy@nvidia.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
 <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
 <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <00721702-78FF-4690-8EAA-31C367FA9FC0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.24 17:12, Zi Yan wrote:
> On 19 Nov 2024, at 10:29, David Hildenbrand wrote:
> 
>>> +/* Split a multi-block free page into its individual pageblocks. */
>>> +static void split_large_buddy(struct zone *zone, struct page *page,
>>> +			      unsigned long pfn, int order, fpi_t fpi)
>>> +{
>>> +	unsigned long end = pfn + (1 << order);
>>> +
>>> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
>>> +	/* Caller removed page from freelist, buddy info cleared! */
>>> +	VM_WARN_ON_ONCE(PageBuddy(page));
>>> +
>>> +	if (order > pageblock_order)
>>> +		order = pageblock_order;
>>> +
>>> +	while (pfn != end) {
>>> +		int mt = get_pfnblock_migratetype(page, pfn);
>>> +
>>> +		__free_one_page(page, pfn, zone, order, mt, fpi);
>>> +		pfn += 1 << order;
>>> +		page = pfn_to_page(pfn);
>>> +	}
>>> +}
>>
>> Hi,
>>
>> stumbling over this while digging through the code ....
>>
>>> +
>>>    static void free_one_page(struct zone *zone, struct page *page,
>>>    			  unsigned long pfn, unsigned int order,
>>>    			  fpi_t fpi_flags)
>>>    {
>>>    	unsigned long flags;
>>> -	int migratetype;
>>>     	spin_lock_irqsave(&zone->lock, flags);
>>> -	migratetype = get_pfnblock_migratetype(page, pfn);
>>> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>>
>> This change is rather undesired:
>>
>> via __free_pages_core()->__free_pages_ok() we can easily end up here with order=MAX_PAGE_ORDER.
> 
> Do you have a concrete example? PMD THP on x86_64 is pageblock_order.
> We do not have PMD level mTHP yet. Any other possible source?

Memory init during boot. See deferred_free_pages() and 
__free_pages_memory()->memblock_free_pages().

So this is used for exposing most memory during boot to the buddy in 
MAX_PAGE_ORDER granularity.

The other is memory hotplug via generic_online_pages().

-- 
Cheers,

David / dhildenb


