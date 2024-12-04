Return-Path: <linux-kernel+bounces-431020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F69E383D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9432815C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E961B218D;
	Wed,  4 Dec 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gR7CpVYK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0F16F851
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310329; cv=none; b=KiAH2CpYTfpMmQp8s+bui2nzuZiBugWwE3TeqwZwsPehemwY1vvA3g5wHar+8VtjHlF/eQKTDlU3vYp3AcOAdwPHKhXYvlR2g75XSIcSBrnLGzXtB6iqkQ9T+PkkMAK8LrJdCtW1zsEG19/gDwDUeDTlW7jxtskSxYMkagl4b+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310329; c=relaxed/simple;
	bh=y11TP2H8ocz5DdpyvbVSLQ0LyZQR91KwuJu4wbfr7XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otsCaDW3RHEydS2y0T0PqNUSOw9O6Zk4ER/1eS6SE0rK//l9H3J+vBPjN8krgRa2J0Ju+sFArOq7VtFlwhWwOnOd8WjL82/BZR44QY179Bbsl+Cg6129PuY+Vce4lGSqCYHGR8sb577Cnbv7hBlIB/LT9/xFDgthavRBg+Av4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gR7CpVYK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733310326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EOYAqFvSg0/riiW9qfQjo+Q5mlwNkNDqgg5fTadNXFA=;
	b=gR7CpVYK0vt1nQtmRD1NV1NoVJTu5xcf3Beh2TaEhzNTT998APJFPcEBveqCEMaHlMo75C
	ttLZLGoVvRMWJeEEEguaWB0rfPvGQ5P3mNHevjrxxMO2mfIVy+j8DVurgdbER27JnekjKH
	llPKVKDOGaCB2Qm2a43lcaR56bkMCyw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-SGeuzKNDPhiM_eSyoSFAcg-1; Wed, 04 Dec 2024 06:05:25 -0500
X-MC-Unique: SGeuzKNDPhiM_eSyoSFAcg-1
X-Mimecast-MFC-AGG-ID: SGeuzKNDPhiM_eSyoSFAcg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a51e44d0so54350275e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 03:05:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310324; x=1733915124;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EOYAqFvSg0/riiW9qfQjo+Q5mlwNkNDqgg5fTadNXFA=;
        b=KLLHBsa0ZK0mEmcHDR3Bn+e0Lm9aEb/4Iz/Y6vKs8Zi364xp7qM1hZwgu4S7ax29PA
         ik5PKdDjPh8xs1HHCLFqv+BrJ+5sZ6zKYjhkjwMy5fD/Jsi3wiGZczncwGyd4RMktjoO
         GmWsONT/mImoMQPERyArnUIAHoYo5X21I9e5+JUUg47J1vAl4p+IIc0220cfmlvRvWas
         0shuuJG7jRK5ZC2/L8HfrUZEDDuhBEe5wp8VCtZ3KFoNtX9qZPRhnoPeckd/R9FDRwR5
         rhtFma60knqzY/U6b0YG/Z1qMAUI15wXihv3//LjhgSODgs62eKTKms2YMQIoSxR71oy
         yeNA==
X-Forwarded-Encrypted: i=1; AJvYcCUJYw81EyvqZafponoJNnOJI2kAsRI4MJ2qENUOrmA3km1rKgl0KEDzMuOMavOhUGSxzgMzFHgKMVVQv6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2gdKOKY/lW7TSu+R9wLWmPH+9Yt8dGIaeIliXUWhS7Du8WtwQ
	TditB49B2lsAaFqlOMIyi+Kk/IPWJrwiWtkNjkXnSLiXdyRZjvzRQGAe/OP/tKqocTPAlOb/4ZF
	6NVB7MoQ/e4jhDUQgUqrrtt8QSKTd+JNh/f4AZrrj3ED8+uaFog5mApXwhN4Ixw==
X-Gm-Gg: ASbGncvq3tz9hMWMduTt8Lu49CkhHRFOqJ1vl7NY0miU1jzH4u+23siY1DWa6ENkZA6
	t154fjO7C2E41aPX1OpBkwQ9Lm6LK0wynMrNGQxy3eySNqOhVEn12Pp8Rs0Plht54fb4spokKiU
	xjmejX6rj7n0D28jaMkLIrHQF2ZLlrrnLYa07XBXl5tHOPy5gLrxgiGwmUnwTbbtJRZAFOUAQO1
	slCNZu9mUp0V59lart5Qp7pvjeA7HOvyHTSoDpC9W76yrtS4zpKvneT9R9K1vOxk++w5lqivjxy
	M2kv67cM/qIT9k1jF3TpUkVO4Ph75CL80LLSZM3Ady0rFJg1ypoZ/SkNQBWhhbTsGKKagm7groq
	haQ==
X-Received: by 2002:a05:600c:3502:b0:434:a72a:ee71 with SMTP id 5b1f17b1804b1-434d09b6854mr53675445e9.14.1733310324590;
        Wed, 04 Dec 2024 03:05:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZe4H7arBQOrPQ4LM0nYD0hJzag1sfjVFLq8X4sHrPerQqEP8u2coHAaDWOWndN4BisypKYw==
X-Received: by 2002:a05:600c:3502:b0:434:a72a:ee71 with SMTP id 5b1f17b1804b1-434d09b6854mr53675205e9.14.1733310324206;
        Wed, 04 Dec 2024 03:05:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d04defb7sm41582415e9.0.2024.12.04.03.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:05:23 -0800 (PST)
Message-ID: <09e544d9-30b2-4422-bf19-7e0b2e436648@redhat.com>
Date: Wed, 4 Dec 2024 12:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the
 alloc_contig_range() gfp flags mess
To: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20241203094732.200195-1-david@redhat.com>
 <20241203094732.200195-5-david@redhat.com>
 <feffbbe8-4176-48e8-b503-ef53d7914197@suse.cz>
 <96c92857-4850-4f85-9474-ac193c5ea48c@redhat.com>
 <04c1d28e-bbea-4499-9a6d-770f9ca53ba9@suse.cz>
 <d736f1c0-343e-4031-88ba-3b33b73dbeba@redhat.com>
 <Z1AaC5Hj2RV_5FDD@localhost.localdomain>
 <15096b27-6f27-45fc-8a8b-de781a9c42a5@suse.cz>
 <Z1AdotZfAJG-zVZX@localhost.localdomain>
 <cee06baa-8561-4be3-8f5c-ca453f58950b@redhat.com>
 <Z1ApKEC-_OPPreun@localhost.localdomain>
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
In-Reply-To: <Z1ApKEC-_OPPreun@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.12.24 11:04, Oscar Salvador wrote:
> On Wed, Dec 04, 2024 at 10:28:39AM +0100, David Hildenbrand wrote:
>> On 04.12.24 10:15, Oscar Salvador wrote:
>>> On Wed, Dec 04, 2024 at 10:03:28AM +0100, Vlastimil Babka wrote:
>>>> On 12/4/24 09:59, Oscar Salvador wrote:
>>>>> On Tue, Dec 03, 2024 at 08:19:02PM +0100, David Hildenbrand wrote:
>>>>>> It was always set using "GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL",
>>>>>> and I removed the same flag combination in #2 from memory offline code, and
>>>>>> we do have the exact same thing in do_migrate_range() in
>>>>>> mm/memory_hotplug.c.
>>>>>>
>>>>>> We should investigate if__GFP_HARDWALL is the right thing to use here, and
>>>>>> if we can get rid of that by switching to GFP_KERNEL in all these places.
>>>>>
>>>>> Why would not we want __GFP_HARDWALL set?
>>>>> Without it, we could potentially migrate the page to a node which is not
>>>>> part of the cpuset of the task that originally allocated it, thus violating the
>>>>> policy? Is not that a problem?
>>>>
>>>> The task doing the alloc_contig_range() will likely not be the same task as
>>>> the one that originally allocated the page, so its policy would be
>>>> different, no? So even with __GFP_HARDWALL we might be already migrating
>>>> outside the original tasks's constraint? Am I missing something?
>>>
>>> Yes, that is right, I thought we derive the policy from the old page
>>> somehow when migrating it, but reading the code does not seem to be the
>>> case.
>>>
>>> Looking at prepare_alloc_pages(), if !ac->nodemask, which would be the
>>> case here, we would get the policy from the current task
>>> (alloc_contig_range()) when cpusets are enabled.
>>>
>>> So yes, I am a bit puzzled why __GFP_HARDWALL was chosen in the first
>>> place.
>>
>> I suspect because "GFP_USER" felt like the appropriate thing to do.
> 
> Looking back at when the whole contiguous allocator patchset was posted,
> it seems that it kinda copied what memory-offline code was doing, which
> was migrating pages with GFP_HIGHUSER_MOVABLE (hotremove_migrate_alloc()).
> 
> Then, the HIGHMEM modifier was dropped due to HIGHMEM restrictions on
> some systems, ending up with GFP_USER.

Looking at some other migration_target_control users, some of them also 
shouldn't be setting GFP_USER->HARDWALL either I think. Essentially, 
whenever we are migrating a page that is not guaranteed to be "ours" in 
the context of the caller.

mm/damon/paddr.c:__damon_pa_migrate_folio_list() for example, which 
obtained the addresses by scanning a chunk of physical address space.

For others it's less clear: soft_offline_in_use_page() may be called 
either using madvise() from process context, but also using sysfs using 
a PFN.


-- 
Cheers,

David / dhildenb


