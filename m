Return-Path: <linux-kernel+bounces-267810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243739415B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77C01F21E09
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D601B583E;
	Tue, 30 Jul 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yapr8ZdA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70806145A18
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354558; cv=none; b=WC5+Xt04AgZewog9P6uS4GX7WizqaBoKiPo7Csjcbe9c6Q4EzO+uAYsr9RJXUQ+m0WcXFmRF29MGd+iy2v/W6ns+z0Q9nd1iQh3FYl729ei0jpS9KA7VAB0i2ERdOL42zFSqAzTggmmsy7jLHFy54+HkMJIVTL9qIKIPVyxbqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354558; c=relaxed/simple;
	bh=3VNOrrTG7GfKdUncVfrkg1AqRAJShRz9sEI61Jm2lv0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ko083bxVbESP5FFNIzY5z7q/sfhwLzECw5YJ5H8Oh7Ni5Eaqx4CijWmyHRi1KWtkweNIoSzff7Lkegx+8MglWcbdDS2AnAPihtpzZXe52TTwUWQeg7Szibs75E4OPDodIEOhWmY0bakcZP2gE5QE3gLeO677vHUzchfCf+EwKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yapr8ZdA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722354555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xi8KbBbM4q6iVh9OwAGJirNn1W3JeV89B3/oDQFc+xU=;
	b=Yapr8ZdAryjIWy+uOM7sNgssVvmmSzNLjYAwHprEFU4ebrsqDkdPXLjfDqRwCe0t3zQHOq
	D2yHzk6lcEiwR894jsSEwqJzad0LN88Fc5dQkKZZlfgchJqY+ISXunALaYHz8gkfqpYcyv
	BE2JSLaqR2sBih1Vn2/BUDJ3dU+fQTU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-h10chnNbMTWkXhKbxY7FPw-1; Tue, 30 Jul 2024 11:49:13 -0400
X-MC-Unique: h10chnNbMTWkXhKbxY7FPw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281b7196bbso21057765e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354552; x=1722959352;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xi8KbBbM4q6iVh9OwAGJirNn1W3JeV89B3/oDQFc+xU=;
        b=wZUrjH+pgVCPyZYvQZgmx2A+LDbqCYjRhN6KTSNZmVMrJ9oqAo1e999ythoiY93hCP
         ttN4l9lhWaG1sIbnEKKWqsliZXqbO+MpO9EbPI76TTONtUUNuvbBO9J7Tx8m49SUvOtv
         dFButsiL90LP6Yuj4CdN+fXa52JMdKQxL23drQAmdlYjWi/L+AW62HxeXtbSWn7curAO
         j+ACq/hkGTUtq1jUrxkvcI8SVPFSnsFJcvi+kkv0fOOzl3kPeklY9q5vj6ytZzUdsa3z
         hIxl1dN/IQecxW9836TZIBcVRGTJwJ0QvQTgT6to1FSbO2W4Msnxl+w2rSLf26Ba6plU
         bO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVA+bRAhQq35LilOidG4hZM86JEjDy9m2gQ7te6m/vsy5SRhFpiEl8v+uYdaqImtiC23v/4m1cIDNbduHtX7yS6htgo5ttmUCyRJ0TB
X-Gm-Message-State: AOJu0YyPirGIuzNKoeH4zdhsdJ/MYAtDjnRBEuOtwr7naP30ohXOFrvp
	hzTHo0GPxxTtUaDorpZ2fMwFVKSerefMIh7KVu71gQV60ClDX7o9KgfFUTt9BWGo4eLEIvT1uqM
	rlWLQFPgywtNxKI9BsxXAnAnT7eWw3CYMuhz0g8JGL2FVZDang32mEzM65HlQsg==
X-Received: by 2002:a05:600c:3112:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-42811d82e26mr77457315e9.4.1722354552514;
        Tue, 30 Jul 2024 08:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr0B0yPEx0e3k4hDKqbbpw4/6BdLrwMzEeOuOS/C1/U1jdQ2i0XfyJ0Kx7vQD0jbmjhCp3Kw==
X-Received: by 2002:a05:600c:3112:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-42811d82e26mr77457225e9.4.1722354552068;
        Tue, 30 Jul 2024 08:49:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281c3cc71fsm88211015e9.39.2024.07.30.08.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:49:11 -0700 (PDT)
Message-ID: <82e77547-5116-4ef2-a232-f5ab1fca7e02@redhat.com>
Date: Tue, 30 Jul 2024 17:49:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm: let pte_lockptr() consume a pte_t pointer
From: David Hildenbrand <david@redhat.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-2-david@redhat.com>
 <CGME20240730153058eucas1p2319e4cc985dcdc6e98d08398c33fcfd3@eucas1p2.samsung.com>
 <97d87df8-6076-4df0-90a9-a8f5ddea42e9@samsung.com>
 <c3af0b48-f303-456b-bca3-537a61255ec5@redhat.com>
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
In-Reply-To: <c3af0b48-f303-456b-bca3-537a61255ec5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.07.24 17:45, David Hildenbrand wrote:
> On 30.07.24 17:30, Marek Szyprowski wrote:
>> On 25.07.2024 20:39, David Hildenbrand wrote:
>>> pte_lockptr() is the only *_lockptr() function that doesn't consume
>>> what would be expected: it consumes a pmd_t pointer instead of a pte_t
>>> pointer.
>>>
>>> Let's change that. The two callers in pgtable-generic.c are easily
>>> adjusted. Adjust khugepaged.c:retract_page_tables() to simply do a
>>> pte_offset_map_nolock() to obtain the lock, even though we won't actually
>>> be traversing the page table.
>>>
>>> This makes the code more similar to the other variants and avoids other
>>> hacks to make the new pte_lockptr() version happy. pte_lockptr() users
>>> reside now only in  pgtable-generic.c.
>>>
>>> Maybe, using pte_offset_map_nolock() is the right thing to do because
>>> the PTE table could have been removed in the meantime? At least it sounds
>>> more future proof if we ever have other means of page table reclaim.
>>>
>>> It's not quite clear if holding the PTE table lock is really required:
>>> what if someone else obtains the lock just after we unlock it? But we'll
>>> leave that as is for now, maybe there are good reasons.
>>>
>>> This is a preparation for adapting hugetlb page table locking logic to
>>> take the same locks as core-mm page table walkers would.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> This patch landed in today's linux-next as commit e98970a1d2d4 ("mm: let
>> pte_lockptr() consume a pte_t pointer"). Unfortunately it causes the
>> following issue on most of my ARM 32bit based test boards:
>>
> 
> That is ... rather surprising.
> 
> The issue below seems to point at __pte_offset_map_lock(), where we
> essentially convert from
> 
> ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
> 
> to
> 
> ptlock_ptr(virt_to_ptdesc(pte));

I'm wondering, is highmem involved here such that the PTE would be 
kmap'ed and virt_to_page() would not do what we would expect it to do?

-- 
Cheers,

David / dhildenb


