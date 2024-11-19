Return-Path: <linux-kernel+bounces-414538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC399D299D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C63C281277
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9D1CDA0E;
	Tue, 19 Nov 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgYlpBun"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB91CDFDB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030155; cv=none; b=dltbQ+TCFrDnHZoGrA2093s7Yjwy63O5FL5pDeu2Py7l0hTXGMetp74GdjZ2Adu1UUYluUBiDXlQJbT7EDpgI0cCXihmfdpXNd//rpnqAxkon8chSaxOajLyfxG6jM7P58H6XF+ulrGEV27YWCv1pkIvzoddOjiwWWhdWjTw0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030155; c=relaxed/simple;
	bh=s3CwtpZ9TFpmu2o25ML2cNFBZLrCYBBnGd/NOFJmksM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gr9xtU590S/hfyCvkGAmmrxyN6kh4AupvLLhrFOmltinJX8pSTQ/6zIHfNUsAwmJ5GdndHDto0FwFALjaNrDS1FkSQyGe0fCyRP5PyOIOGgJ8irc85Qn3TytWqqn2NT7m1yWnYDXmJtTTD0lMBdBVgobZuVdbuy0RwoUK0hmsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgYlpBun; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vc5vvzTPcrv6TN+NrDbFJ4TRG1yk/ozBlawitHkFcNE=;
	b=YgYlpBunIUgTla86+9Bd1zxxMF+nYKstDT+C+P4uDJ7PYb2yoJ1/v4xSH1GiY9grOF7yMy
	cZkZTYJZINAaGg96wFIUZqhxazHi6loC0mTElvNTCtPceGqi3EDTe7nDIjU93B7mQUsY4t
	e/gN9DcG9uRvIhSkjXTYU0CzpZDRVc4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-aoNbV-f9OjeuBF5tKuendw-1; Tue, 19 Nov 2024 10:29:10 -0500
X-MC-Unique: aoNbV-f9OjeuBF5tKuendw-1
X-Mimecast-MFC-AGG-ID: aoNbV-f9OjeuBF5tKuendw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43152cd2843so35300205e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030149; x=1732634949;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vc5vvzTPcrv6TN+NrDbFJ4TRG1yk/ozBlawitHkFcNE=;
        b=nsGgGIdPCqVOB8304ulBx5X8rFCH6cMuDRF6MPSPWlYS8CprSwkWhKjcfImLf29CRV
         mrH5EDOduODBo9OR/Swbp5xYLYj6xAwMaZ7l3XP2JEKWwQ9F1vH77jKyPyrXL2SymfvK
         Em0/GsE1g0HQcm9iPRHx6J8Yo436E0JKD9M4zCQYCJaD8kpLwHDNGvqWa4xxz71LO0ne
         hr7TPbJ+h5k2XxGEgUrmAKPsB+sYvvNpE3zcCPtGgjLXRQmRQCQrrrMJzEXWXkhtq3Uo
         tqYAGY3KtVVn/sdHrl2EyE26aDPCJp1HFJEVCFnU5q6dnxTBCfg1a7agqEWnmXfmzhpj
         D5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+qB9u80SOZtt7oKLDJ00X0V0jKi4Sa8kB8w/KD36UgJASw8w7RFDCFOMYJiqk21O2pkQ2fAbkUKXgojM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VlyFOPi285v6TuYcM/0fS4WwEHOoxty1op4mqAfqJ/6O/Inz
	rLMnAWq3O1gJqHBOge5oZYOS/BDP2MzhNFVM7LjXg8BcJ2x3ZSInYLwsaCVzDkrZJ3nMgPj5nK7
	bq6CQHAY2YiI5V+ai/Xxq9ZY2pEQcW7LZWBIwnm2gcSDLH0OS8TIjV9mP98AqVg==
X-Received: by 2002:a05:600c:3b2a:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-432df72c076mr163241365e9.10.1732030149499;
        Tue, 19 Nov 2024 07:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGub6vsuebwWJa+pkt/6fqcrb3uCEp4oj5TyUg2/2lFaCYHSUxogpmeMc8ScPB1EVv7ys2TKQ==
X-Received: by 2002:a05:600c:3b2a:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-432df72c076mr163241255e9.10.1732030149201;
        Tue, 19 Nov 2024 07:29:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244924sm199390395e9.7.2024.11.19.07.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:29:08 -0800 (PST)
Message-ID: <402ff3e5-4fca-4452-97ba-5b1ec4a6eeb1@redhat.com>
Date: Tue, 19 Nov 2024 16:29:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-2-yuzhao@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240814035451.773331-2-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +/* Split a multi-block free page into its individual pageblocks. */
> +static void split_large_buddy(struct zone *zone, struct page *page,
> +			      unsigned long pfn, int order, fpi_t fpi)
> +{
> +	unsigned long end = pfn + (1 << order);
> +
> +	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn, 1 << order));
> +	/* Caller removed page from freelist, buddy info cleared! */
> +	VM_WARN_ON_ONCE(PageBuddy(page));
> +
> +	if (order > pageblock_order)
> +		order = pageblock_order;
> +
> +	while (pfn != end) {
> +		int mt = get_pfnblock_migratetype(page, pfn);
> +
> +		__free_one_page(page, pfn, zone, order, mt, fpi);
> +		pfn += 1 << order;
> +		page = pfn_to_page(pfn);
> +	}
> +}

Hi,

stumbling over this while digging through the code ....

> +
>   static void free_one_page(struct zone *zone, struct page *page,
>   			  unsigned long pfn, unsigned int order,
>   			  fpi_t fpi_flags)
>   {
>   	unsigned long flags;
> -	int migratetype;
>   
>   	spin_lock_irqsave(&zone->lock, flags);
> -	migratetype = get_pfnblock_migratetype(page, pfn);
> -	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);

This change is rather undesired:

via __free_pages_core()->__free_pages_ok() we can easily end up here 
with order=MAX_PAGE_ORDER.

What your new code will do is split this perfectly reasonable 
MAX_PAGE_ORDER chunk via split_large_buddy() into pageblock-sized 
chunks, and let the buddy merging logic undo our unnecessary splitting.

Is there a way to avoid this and just process the whole MAX_PAGE_ORDER 
chunk like we used to?

-- 
Cheers,

David / dhildenb


