Return-Path: <linux-kernel+bounces-237884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73015923F7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026BE1F24375
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200A71B5811;
	Tue,  2 Jul 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnR+UJTN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9C1B5805
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928244; cv=none; b=QP9Hm/iUuLbD2xJf8p5iAAYSoDSE63BBdc4W6dLJJpsXtChQzOE26Tic8MP8LNQ//n7YUNxShvns222v1UFRsFz0hde5z05fAkk7kqzRscf/i14PWCAxKYcmzFDxeLEqOEl1o7velJzmZJte1m/qKRU3933719Wgw8kt11svOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928244; c=relaxed/simple;
	bh=1A/q726w8j9RoZNpYQDl/C0Z2QDzDKsb0QtR0sbr3ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otgdzfqx8whJQr1YV6AhoAcMNMu+I2sfpGCklL2LWccBwFWkGl+l4BAdEz8TgcyRH1rkDxsE88nFZrEtYLOk3nnTmBCGQJRmeSa1TzOvaxL46AqKqc333Yv6M1oZq0cFlZBseiCC6r3DnyaTCVf4Ck7tBcrNP1MjbHpVYShDuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnR+UJTN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719928241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tTKDBwxWZ4tURdnzVUB78+C/Ls28msJkJkSY3ZvgpLs=;
	b=BnR+UJTNpGu6Ut/W0Yivk7rRL65ztQiAY8AUUHsR5/scFZe0a5l0ToE4gBlYTGPyOsvEL6
	+M/jSSyquyK3ZLbzRovfk2UGlb6ITERKMesLNR4tSuJD0cDeJBtXM4Nc7VX+A+2w2gvhay
	W0cgXocxdawpPRgOWaLIWv0VyHJLMos=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Gt0UTzmXM-C9MDN7r6jarg-1; Tue, 02 Jul 2024 09:50:40 -0400
X-MC-Unique: Gt0UTzmXM-C9MDN7r6jarg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3625bef4461so2093867f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 06:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928238; x=1720533038;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTKDBwxWZ4tURdnzVUB78+C/Ls28msJkJkSY3ZvgpLs=;
        b=dXq2cOcoS+oHO65Afbl9FJTjIXQ6hTZUZ+cHrM+AubBCW0YafRAmrowGU3f45657oD
         uT3cnQxYsTp3a4LlmD4wkD7dYcIkabqsZyREUbzND/TnkQ6h1ew62Pov0X5D5PxUyD6i
         JVXqLHEtFiNcZHg+ggN1kLuPQLyGD+2rRTVt1JpM3aFl99llmh+gCNwkDqQeozYZl+sA
         e3SwZxyEq9AaGM5QnsLA9yL7rxgmyJi1UJNcpNzDtoWj5O8HomCaWwESktc9mfZyNUsg
         sJFGn1ontvZI3Z6i9o+9LrwKqpWnAKbM6lhzMl/nZglHeVYpWWWbTEYRknm1YO6bMt3c
         KTaA==
X-Forwarded-Encrypted: i=1; AJvYcCWSR4o6Pvw6l2AWs7TxIoGetP4Yk9/SxySz42deI3M4M7zOmV7N20hI4s9Z5b/y17LYQvvFXg1ehMcb42af+UhwdcF3e3GAf5c09IS4
X-Gm-Message-State: AOJu0YwlqhMLRZnEiN6mfAfPG3wMa13R2whDmY2XQHHCSRgUfLW5/6CF
	hKwCliDyFfEcVwWToWp1Y3xGoDykZelLWWn0fxPr6fS6gJvCd/ZhT4QjlRj7vWk44dHX/lWqW36
	7YmBNr5gvTDdS3LjDWppk8G7Z7wdw2FKYho1oz5H+DFOGXKo0n3Xb6BIwFYd/PA==
X-Received: by 2002:a5d:5987:0:b0:363:776:821b with SMTP id ffacd0b85a97d-3676045b4a0mr12273655f8f.0.1719928237941;
        Tue, 02 Jul 2024 06:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcCpbzrLR989YOaTGBpSD0jjipyIo03w+1m82EKoUEd+QPpxkfucAXqG5zdd4Ayz4vqdGwow==
X-Received: by 2002:a5d:5987:0:b0:363:776:821b with SMTP id ffacd0b85a97d-3676045b4a0mr12273633f8f.0.1719928237497;
        Tue, 02 Jul 2024 06:50:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09890dsm199525095e9.36.2024.07.02.06.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 06:50:36 -0700 (PDT)
Message-ID: <7be46fdd-f73b-4edd-9bed-b631e80d305b@redhat.com>
Date: Tue, 2 Jul 2024 15:50:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jinjiang Tu <tujinjiang@huawei.com>
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com> <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
 <34f2d8c6-50fa-4a8a-82a8-d417eb30ea70@redhat.com>
 <905e1319-7b20-4812-b052-8031a3c4dcf3@arm.com>
 <168f9fd4-527d-4b74-86b0-029ef474f9b6@redhat.com>
 <9a9e0a83-59a8-46ac-ae7a-8f2a65b48e1e@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <9a9e0a83-59a8-46ac-ae7a-8f2a65b48e1e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>>>> Changing to this new behaviour would only be a partial solution for your use
>>>>> case, since you would still have 2 faults. But it would remove the cost of the
>>>>> shattering and ensure you have a THP immediately after the write fault. But I
>>>>> can't think of a reason why this wouldn't be a generally useful change
>>>>> regardless? Any thoughts?
>>>>
>>>> The "let's read before we write" as used by QEMU migration code is the desire
>>>> to not waste memory by populating the zeropages. Deferring consuming memory
>>>> until really required.
>>>>
>>>>       /*
>>>>        * We read one byte of each page; this will preallocate page tables if
>>>>        * required and populate the shared zeropage on MAP_PRIVATE anonymous
>>>> memory
>>>>        * where no page was populated yet. This might require adaption when
>>>>        * supporting other mappings, like shmem.
>>>>        */
>>>
>>> So QEMU is concerned with preallocatiing page tables? I would have thought you
>>> could make that a lot more efficient with an explicit MADV_POPULATE_PGTABLE
>>> call? (i.e. 1 kernel call vs 1 call per 2M, allocate all the pages in one trip
>>> through the allocator, fewer pud/pmd lock/unlocks, etc).
>>
>> I think we are only concerned about the "shared zeropage" part. Everything else
>> is just unnecessary detail that adds confusion here :) One requires the other.
> 

BTW, I was quoting the wrong QEMU code. The relevant QEMU commit that first added
that handling is:

commit 211ea74022f51164a7729030b28eec90b6c99a08
Author: Peter Lieven <pl@kamp.de>
Date:   Mon Jun 10 12:14:20 2013 +0200

     migration: do not overwrite zero pages
     
     on incoming migration do not memset pages to zero if they already read as zero.
     this will allocate a new zero page and consume memory unnecessarily. even
     if we madvise a MADV_DONTNEED later this will only deallocate the memory
     asynchronously.

(note that the MADV_DONTNEED handling in that form does not really apply
anymore AFAIK)


> Sorry I don't quite follow your comment. As I understand it, the zeropage
> concept is intended as a memory-saving mechanism for applications that read
> memory but never write it.

"never written" -- then we wouldn't support COW faults on it, right? :P

> I don't think that really applies in your migration
> case, because you are definitely going to write all the memory eventually, I
> think?

Especially with memory ballooning and things like free-page-reporting we might
be migrating a whole bunch of zero-memory and only have to make sure that the
destination is actually zero. We don't want to consume memory.

I recently fixed that handling for s390x where customers were running into
precisely that issue (and zeropages in s390x VMs were disabled for historical
reasons).

> So I guess you are not interested in the "memory-saving" property, but in
> the side-effect, which is the pre-allocation of pagetables? (if you just wanted
> the memory-saving property, why not just skip the "read one byte of each page"
> op? It's not important though, so let's not go down the rabbit hole.

There are cases where, during an incoming migration, some memory pages might
already have been populated and might not be zero. And IIRC there are some cases
(postcopy -> uffd) where I think it is important that we actually do have a page
in place. But I forgot some of the details around userfaultfd handling in QEMU.

> 
>>
>> Note that this is from migration code where we're supposed to write a single
>> page we received from the migration source right now (not more). And we want to
>> avoid allcoating memory if it can be avoided (usually for overcommit).
>>
>>
>>
>>>
>>> TBH I always assumed in the past the that huge zero page is only useful because
>>> its a placeholder for a real THP that would be populated on write. But that's
>>> obviously not the case at the moment. So other than a hack to preallocate the
>>> pgtables with only 1 fault per 2M, what other benefits does it have?
>>
>> I don't quite udnerstand that question. [2] has some details why the huge
>> zeropage was added -- because we would have never otherwise received huge
>> zeropages with THP enabled but always anon THP directly on read.
>>
>>>
>>>>
>>>>
>>>> Without THP this works as expected. With THP this currently also works as
>>>> expected, but of course with the price [1] of not getting anon THP
>>>> immediately, which usually we don't care about. As you note, khugepaged might
>>>> fix this up later.
>>>>
>>>> If we disable the huge zeropage, we would get anon THPs when reading instead of
>>>> small zeropages.
>>>
>>> I wasn't aware of that behaviour either. Although that sounds like another
>>> reason why allocating a THP over the huge zero page on write fault should be the
>>> "more consistent" behaviour.
>>
>> Reading [2] I think the huge zeropage was added to avoid the allocation of THP
>> on read. Maybe for really only large readable regions, not sure why exactly.
> 
> I might raise this on the THP call tomorrow, if Kyril joins and get his view.

Makes sense.

-- 
Cheers,

David / dhildenb


