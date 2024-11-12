Return-Path: <linux-kernel+bounces-406299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1369C5D02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0DF282D59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7EB20494F;
	Tue, 12 Nov 2024 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/utayod"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41E202649
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428380; cv=none; b=e+pBAH3I5iEz553MSe7JsDRuqkRFIFu/+bscOTjJXehtjimqpD4wZoAnjLanJjsNI7hkHjTxGJ5AN8yGWeWQKO0biVGviQUhO6qXUkOyt4uwvJVmk9K1llapYDmaJlPYAmqoLA8tHqO1/9UlR0sWuRguME01RvNzWWndfa3rHPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428380; c=relaxed/simple;
	bh=ldH2X/lqNLkbQu1MQ/ojrKOF6spfTbU6Z9FdL3DF6/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ge7CCZuxqC4owygwgGC+ZyZqw11uDBxaIvUAwb9XNjn4KGuS6OSVjGrdwcy6LIAOeEwXIw40AZjQjKdLFP0kSALXxfmT+A4raQK931Yq31x42RfEy2HCZfYarHQA6pCow9teQ/iNwP3unxW8kDznulbtt4Eo2rjwmHWUw/lHwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/utayod; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731428377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TAg6mxWnF/rANdfdY+YKntZiK5rrIUaXnBNmA5NMRpA=;
	b=A/utayodtyn5V165RvcFijJWt71M0VczPnpjOXgMU+Bbl64hiK9euj8xaNWZXtWqcvCPuY
	/0KsbvRMXHlXh6Ae8R++NPrBUDGCKih/nycxp+CqnJMcFnidZNAmXaxIWDA039WrAQwmHH
	GlqsurplvA8j343mfbIg24Lnw8l1+GA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-glquFFaDOTWbTAOeVjhzxA-1; Tue, 12 Nov 2024 11:19:36 -0500
X-MC-Unique: glquFFaDOTWbTAOeVjhzxA-1
X-Mimecast-MFC-AGG-ID: glquFFaDOTWbTAOeVjhzxA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4327bd6bd60so44072725e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731428375; x=1732033175;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TAg6mxWnF/rANdfdY+YKntZiK5rrIUaXnBNmA5NMRpA=;
        b=a6uNWWsD9YqZZ1YhGk/C71fTm1rF7fETwK16TuuUCTKBlocsdpjnUwlrqlTfEjAiAD
         kP5CohVOuwmpqNAgGV7JMN5E2uG5Fgz2RfHZ9fllIo/83xpwGI+B34nv1ZhB8KPapAyA
         uCTO8CuwGHsK+00kxyVS9mVkHwrPOIjXXGTd19ZP7n4eVFSGyfoXLUS4JaAuS7bywiyO
         Ivx0Jp1k9IOpbezGjzw/jkLHMqQff1MN2msV5f0FgZa3tq9T7ZOxbOyRH9/0jGr/3MeW
         zQb4lOVGw4vgf9HxwMif9BSlqEmXPupopEo6dDK1i1K3kBbLi8ovyEgkjLJ+rwq9IWST
         fCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdEq+HWgaFz78o/87SH25/mj8WT4/ulNPERB90xkn1BZ8QV7nuJkjZ0sorRyM2pNT8iHN/3x+xospJ1I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpwTnBCDZsDu+U56B7NYwzbFB1oY+2i7YZTfvoYFlSL8mGQ/l
	zQBvXhdKKOL2fN64wKF1WkZS8WGUnA4i+8ni1C6wKW81xpxkUWqtfBafWUhHPNcBXzRNigrT9cj
	Pq9ABedtRSjQGDMKh35f3ReJ4iUPFPKTfsNX+5cp8CEOjqoUrPXfKz7/MH2CJlw==
X-Received: by 2002:a05:600c:4e8b:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-432b7501d2bmr149455595e9.13.1731428374672;
        Tue, 12 Nov 2024 08:19:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEicVwnPHoVYbFbmbCrjTy21vf/mZhYzbGSrVTaOwMXb7YHZA26gxb8YCnptPyCYQvJ/tz7zw==
X-Received: by 2002:a05:600c:4e8b:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-432b7501d2bmr149455385e9.13.1731428374307;
        Tue, 12 Nov 2024 08:19:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c202asm220556165e9.30.2024.11.12.08.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:19:33 -0800 (PST)
Message-ID: <c7c3f529-4cd0-4209-b3b9-48a29dfcb08d@redhat.com>
Date: Tue, 12 Nov 2024 17:19:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: shmem: add large folio support for tmpfs
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <eabd8c89fc1b4807eaf28750e04c44b718ae6487.1731397290.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.24 08:45, Baolin Wang wrote:
> Add large folio support for tmpfs write and fallocate paths matching the
> same high order preference mechanism used in the iomap buffered IO path
> as used in __filemap_get_folio().
> 
> Add shmem_mapping_size_orders() to get a hint for the orders of the folio
> based on the file size which takes care of the mapping requirements.
> 
> Traditionally, tmpfs only supported PMD-sized huge folios. However nowadays
> with other file systems supporting any sized large folios, and extending
> anonymous to support mTHP, we should not restrict tmpfs to allocating only
> PMD-sized huge folios, making it more special. Instead, we should allow
> tmpfs can allocate any sized large folios.
> 
> Considering that tmpfs already has the 'huge=' option to control the huge
> folios allocation, we can extend the 'huge=' option to allow any sized huge
> folios. The semantics of the 'huge=' mount option are:
> 
> huge=never: no any sized huge folios
> huge=always: any sized huge folios
> huge=within_size: like 'always' but respect the i_size
> huge=advise: like 'always' if requested with fadvise()/madvise()
> 
> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
> allocate the PMD-sized huge folios if huge=always/within_size/advise is set.
> 
> Moreover, the 'deny' and 'force' testing options controlled by
> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
> semantics. The 'deny' can disable any sized large folios for tmpfs, while
> the 'force' can enable PMD sized large folios for tmpfs.
> 
> Co-developed-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/shmem.c | 91 +++++++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 77 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 86b2e417dc6f..a3203cf8860f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -549,10 +549,50 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>   
>   static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>   
> +/**
> + * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
> + * @mapping: Target address_space.
> + * @index: The page index.
> + * @write_end: end of a write, could extend inode size.
> + *
> + * This returns huge orders for folios (when supported) based on the file size
> + * which the mapping currently allows at the given index. The index is relevant
> + * due to alignment considerations the mapping might have. The returned order
> + * may be less than the size passed.
> + *
> + * Return: The orders.
> + */
> +static inline unsigned int
> +shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
> +{
> +	unsigned int order;
> +	size_t size;
> +
> +	if (!mapping_large_folio_support(mapping) || !write_end)
> +		return 0;
> +
> +	/* Calculate the write size based on the write_end */
> +	size = write_end - (index << PAGE_SHIFT);
> +	order = filemap_get_order(size);
> +	if (!order)
> +		return 0;
> +
> +	/* If we're not aligned, allocate a smaller folio */
> +	if (index & ((1UL << order) - 1))
> +		order = __ffs(index);
> +
> +	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
> +	return order > 0 ? BIT(order + 1) - 1 : 0;
> +}
> +
>   static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>   					      loff_t write_end, bool shmem_huge_force,
> +					      struct vm_area_struct *vma,
>   					      unsigned long vm_flags)
>   {
> +	unsigned long within_size_orders;
> +	unsigned int order;
> +	pgoff_t aligned_index;
>   	loff_t i_size;
>   
>   	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)

We can allow all orders up to MAX_PAGECACHE_ORDER, 
shmem_mapping_size_orders() handles it properly.

So maybe we should drop this condition and use instead below where we have

return BIT(HPAGE_PMD_ORDER);

instead something like.

return HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ? 0 : BIT(HPAGE_PMD_ORDER);

Ideally, factoring it out somehow


int maybe_pmd_order = HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER ? 0 : 
BIT(HPAGE_PMD_ORDER);

...

return maybe_pmd_order;

> @@ -564,15 +604,41 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
>   	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
>   		return BIT(HPAGE_PMD_ORDER);

Why not force-enable all orders (of course, respecting 
MAX_PAGECACHE_ORDER and possibly VMA)?

>   
> +	/*
> +	 * The huge order allocation for anon shmem is controlled through
> +	 * the mTHP interface, so we still use PMD-sized huge order to
> +	 * check whether global control is enabled.
> +	 *
> +	 * For tmpfs mmap()'s huge order, we still use PMD-sized order to
> +	 * allocate huge pages due to lack of a write size hint.
> +	 *
> +	 * Otherwise, tmpfs will allow getting a highest order hint based on
> +	 * the size of write and fallocate paths, then will try each allowable
> +	 * huge orders.
> +	 */
>   	switch (SHMEM_SB(inode->i_sb)->huge) {
>   	case SHMEM_HUGE_ALWAYS:
> -		return BIT(HPAGE_PMD_ORDER);
> -	case SHMEM_HUGE_WITHIN_SIZE:
> -		index = round_up(index + 1, HPAGE_PMD_NR);
> -		i_size = max(write_end, i_size_read(inode));
> -		i_size = round_up(i_size, PAGE_SIZE);
> -		if (i_size >> PAGE_SHIFT >= index)
> +		if (vma)
>   			return BIT(HPAGE_PMD_ORDER);
> +
> +		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
> +	case SHMEM_HUGE_WITHIN_SIZE:
> +		if (vma)
> +			within_size_orders = BIT(HPAGE_PMD_ORDER);
> +		else
> +			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
> +								       index, write_end);
> +
> +		order = highest_order(within_size_orders);
> +		while (within_size_orders) {
> +			aligned_index = round_up(index + 1, 1 << order);
> +			i_size = max(write_end, i_size_read(inode));
> +			i_size = round_up(i_size, PAGE_SIZE);
> +			if (i_size >> PAGE_SHIFT >= aligned_index)
> +				return within_size_orders;
> +
> +			order = next_order(&within_size_orders, order);
> +		}
>   		fallthrough;
>   	case SHMEM_HUGE_ADVISE:
>   		if (vm_flags & VM_HUGEPAGE)

I think the point here is that "write" -> no VMA -> vm_flags == 0 -> no 
code changes needed :)

-- 
Cheers,

David / dhildenb


