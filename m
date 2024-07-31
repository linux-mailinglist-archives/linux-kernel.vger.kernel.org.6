Return-Path: <linux-kernel+bounces-268852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C173942A3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E13285FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BB41AC45D;
	Wed, 31 Jul 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFIJ9sPe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EA1A8BE5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417544; cv=none; b=p5RcwoJxcB9GQ0wDHWTI8OaspRuqtC5Ip46NeVSdPGc6h9QTjNFis4s7+YDZqGJcxaChW9O7qtt8MkJFecG4phEdQT5IP86i5jmrgu/uPhhHQzSQHdXqdyuEqI6MKkA5hp8NOEIeMuKn6uvtuNb3uX4B//ZpVBrWE+lvQ0vtObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417544; c=relaxed/simple;
	bh=D4wbK7HiVwxwY67Ovg/fofchc3T0xZI+fNtRGE5loww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdRqr7x/c3ZJXKFRgjDaYDNyJBRldwqkJtmVqsWpQpgCp8RxJ2/+J9ud+72OtJAjAfWg53s2DfetqHb7LibSlr+yAUf7w3k2Gfc3kymeVSQkjrg+Tkt0TVc+67IOUhfiSnXYU2jBuyGclWi9CiKJgXbf1dPX6HRVFIeEccIO68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFIJ9sPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722417541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LjamSx4ZX3PuSrG5CO1N2re3DGJdSybENS1tb0+2zW8=;
	b=eFIJ9sPeZheLiTc524AGLjSNClSHDAm9gqAJ//Yfvv7eLEXZwU7erzJKFLzXYPjZLfqprF
	G2mn/hZWFGpmY3FmzRz7x4/gBzEXUrLcbkdU5oB/VP8BcDM1dNvShnEIWVRY6hH2UPP82B
	kjSI22OURFvk/nrMr18Z6zaEn4oskXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-QqKtcoiDPM-IImwQ-OQMrw-1; Wed, 31 Jul 2024 05:18:56 -0400
X-MC-Unique: QqKtcoiDPM-IImwQ-OQMrw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42671a6fb9dso32309175e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722417535; x=1723022335;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LjamSx4ZX3PuSrG5CO1N2re3DGJdSybENS1tb0+2zW8=;
        b=OKnkb2LzT2ponvG4FN6l2UFFBqooNZy8N0Tyi1us0iC43mGWoU1na7u1mtpGCe/WUr
         A1ri79sFPwFPKHkfXUNNrdzAMU7Y2X6urWKCLH5aMbYZHWCWhrY4d5qXzD2Or7ogYj7u
         mOzIjgg6lpNAmOdcXd/hg6n0g/Hr+VySB4xyE/kKtLNcjemLeZnr9vt42jp8S0xsDxPf
         M4lFozhRXe5EJ2zbyzmjfx1jU6d6Jqcf0FNohtK2UW47gBsbqH92dwHUK4yDkoyD2Blg
         HJJ75RjxiH95VpsEUf4i5sK8oLgDL7EwQdKC4pNWgwDDApOEkHUovhVjbg0Ketf3oiSx
         fGFw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwbGkVvQcnqG5YBC0cn7Ibet77VDldROsQct1Kn21kh9qVp6ggArOunH0f7VtYBWXWozxeNhANiqR7eOCR114yFB4bmfnwVFUxRTl
X-Gm-Message-State: AOJu0YwNWCYegQZBawdBb5zgK+0XMchrzzK0Q8HpOprjc0xoi/IxOMuU
	xJDs43/U8O7UwvZk6qy8FVQn9Vtjpsy9AsH0sEi2JzrQsNvVTogkWIwDiJ6Hu4KNP9qUvhFa3xt
	XHWU8BKpprwT539aIwZGU3bp3VdTFCjLA4JnVbh9UuOhfEn+dTfcLiNXj+S5O6g==
X-Received: by 2002:a05:600c:1c02:b0:428:387:79ac with SMTP id 5b1f17b1804b1-42811d8642bmr107803345e9.6.1722417535561;
        Wed, 31 Jul 2024 02:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaHAAYmy1uNdZVjw7UnpaC5Dr4qggZvhNmfYCfT3m5sa/tj/c9j1psXJck+GUyMQ2hE7BR/w==
X-Received: by 2002:a05:600c:1c02:b0:428:387:79ac with SMTP id 5b1f17b1804b1-42811d8642bmr107803125e9.6.1722417535136;
        Wed, 31 Jul 2024 02:18:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49? (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de. [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6405csm14451185e9.34.2024.07.31.02.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:18:54 -0700 (PDT)
Message-ID: <db464483-5aa1-499d-9e66-ac30541499f9@redhat.com>
Date: Wed, 31 Jul 2024 11:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: shmem: fix incorrect aligned index when checking
 conflicts
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, 21cnbao@gmail.com, ryan.roberts@arm.com,
 ziy@nvidia.com, gshan@redhat.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
 <07433b0f16a152bffb8cee34934a5c040e8e2ad6.1722404078.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <07433b0f16a152bffb8cee34934a5c040e8e2ad6.1722404078.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.24 07:46, Baolin Wang wrote:
> In the shmem_suitable_orders() function, xa_find() is used to check for
> conflicts in the pagecache to select suitable huge orders. However, when
> checking each huge order in every loop, the aligned index is calculated
> from the previous iteration, which may cause suitable huge orders to be
> missed.
> 
> We should use the original index each time in the loop to calculate a
> new aligned index for checking conflicts to avoid this issue.
> 
> Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index a4332a97558c..6e9836b1bd1d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1686,6 +1686,7 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>   					   unsigned long orders)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> +	pgoff_t aligned_index;
>   	unsigned long pages;
>   	int order;
>   
> @@ -1697,9 +1698,9 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>   	order = highest_order(orders);
>   	while (orders) {
>   		pages = 1UL << order;
> -		index = round_down(index, pages);
> -		if (!xa_find(&mapping->i_pages, &index,
> -			     index + pages - 1, XA_PRESENT))
> +		aligned_index = round_down(index, pages);
> +		if (!xa_find(&mapping->i_pages, &aligned_index,
> +			     aligned_index + pages - 1, XA_PRESENT))
>   			break;
>   		order = next_order(&orders, order);
>   	}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


