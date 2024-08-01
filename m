Return-Path: <linux-kernel+bounces-271346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD0944D21
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A931F22668
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF6A1A0AFF;
	Thu,  1 Aug 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwI3ydQ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B277189B98
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518825; cv=none; b=POts8V27F04JndMNgFwIynC+ZY9pYRkRWVZRrcfW8tmA6F7Bl7sGmHmQHtTn/nHH6GrF+eU3i6S++Lq96+UcvuN451JqME1wWZaGg7HMNDBtPTcCCOcH9fmM3rmvOXOBfTpBdGGhqP0E6SxMfMdCb+wTCOGVxwdbJuExsXOhGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518825; c=relaxed/simple;
	bh=2iH+7Gck90dLdRDrENdY3Cos1k1jHu7KT8AJ0aEb6Cg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BsdkfasWgXtAMXIv7EGIUANILa8putitnL4wQnUtPMlRRlsb2Y6CC3rdIgxIzgBp9bhNoTe8IMFtW1b9tHfPi1rOYp8RwTUAc3sZZr1jPmaRCANZt+RIPZWsNkh999J+unAELpgOBv2I2JtULODq8EggccWWAHBBxy1IIvlI4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwI3ydQ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722518823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jq3vIxhF52hw2/n1rUUdx9o+QF0JAdnZka7hC01u3CY=;
	b=GwI3ydQ+z7Cf9ieq2J/AW8XqLbVep+1+d/Y8wkAuOZG0hpkT7eeOkxuPBmdl8G8v3W64Ed
	uo4kUMuv7LtW6O/uBAvgGBVDVmRoTILxx0ps69z/+IU/Fn5ljVeBypvR/JQmV7rHVpXZpc
	HH4bOvUaWK7hWWcolcWo4U96DZ+vYr4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-Z9h7u7_gOF6_4HcRztfSwQ-1; Thu, 01 Aug 2024 09:27:02 -0400
X-MC-Unique: Z9h7u7_gOF6_4HcRztfSwQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42671a6fb9dso41279755e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518821; x=1723123621;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jq3vIxhF52hw2/n1rUUdx9o+QF0JAdnZka7hC01u3CY=;
        b=Isxl/UwcY2ybqYmaTwl9zS4A3gSzIG/20ZJDvZBGkySVGJTy9bFhv6NQWZSED6uE38
         pTpHf1Fz6xCJ+lmG4gPYhrora1bw6WInDho62Cv7ZjT1IfI8e3svdgSuLj5J/hHB3kfz
         OaCXrXswFDck9ZLF4DiYCXSNudX2BFC79a7YUqMsyT0UU4UL7mbO6kuBALEhpLzfuAxL
         4zxRHLaZ+KGl/fGdJrPSuSK1Gea+3AzvterEwb+6hwlmplcLcTH9WjP1u0brojgBzhNF
         w17ociVYk0ezPuH9kvvDxKuab0FT7ikjT9RWiIzVl4n3ZO1noJR44SnpAa9tfZcBzn3M
         N44g==
X-Forwarded-Encrypted: i=1; AJvYcCVWmlsCQjYBSd+6soX9kNAXTTYaWs39X7I3YgJAbPGhm7gEp0hSyh4dUJm7gtasak0r2u3syuSZPMBDISL+qe9JTJfCWxYPkycMboiH
X-Gm-Message-State: AOJu0YzlekYAVT8IWqfaGRsJ7No6vW4jEk3pf9I+rqyYz0ayV8atyd7C
	VS99AcvN4cYDE0X8EOA3S8nvtNtYzezOwl+Q594h3WWZv6GioA5J0WJG8z05E5ChtuIl3nRVgsw
	QbIN8CQpQcPWaXtSfxZVzfgLcIIRPO1Ai0cSkNsSBHeDzW8LfHAMbK0VpkexJgA==
X-Received: by 2002:adf:eb91:0:b0:368:6337:4220 with SMTP id ffacd0b85a97d-36baacb5f31mr1695289f8f.9.1722518820811;
        Thu, 01 Aug 2024 06:27:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOn4GOe1+0Tg8+9zwdPaouG4gsK0WesyMmTYIGCB/LxE7DeaZ7lMKCpvEnpjaSjGqyMOJGsg==
X-Received: by 2002:adf:eb91:0:b0:368:6337:4220 with SMTP id ffacd0b85a97d-36baacb5f31mr1695243f8f.9.1722518820140;
        Thu, 01 Aug 2024 06:27:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c028bsm19386843f8f.24.2024.08.01.06.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 06:26:59 -0700 (PDT)
Message-ID: <6486a2b1-45ef-44b6-bd84-d402fc121373@redhat.com>
Date: Thu, 1 Aug 2024 15:26:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
From: David Hildenbrand <david@redhat.com>
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
 <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
 <bbe411f2-4c68-4f92-af8c-da184669dca8@arm.com>
 <a6a38ad5-c754-44ad-a64b-f9ea5b764291@redhat.com>
 <92df0ee1-d3c9-41e2-834c-284127ae2c4c@arm.com>
 <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
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
In-Reply-To: <19902a48-c59b-4e3b-afc5-e792506c2fd6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 15:13, David Hildenbrand wrote:
>>>> To dampen the tradeoff, we could do this in shmem_fault() instead? But
>>>> then, this would mean that we do this in all
>>>>
>>>> kinds of vma->vm_ops->fault, only when we discover another reference
>>>> count race condition :) Doing this in do_fault()
>>>>
>>>> should solve this once and for all. In fact, do_pte_missing() may call
>>>> do_anonymous_page() or do_fault(), and I just
>>>>
>>>> noticed that the former already checks this using vmf_pte_changed().
>>>
>>> What I am still missing is why this is (a) arm64 only; and (b) if this
>>> is something we should really worry about. There are other reasons
>>> (e.g., speculative references) why migration could temporarily fail,
>>> does it happen that often that it is really something we have to worry
>>> about?
>>
>>
>> (a) See discussion at [1]; I guess it passes on x86, which is quite
>> strange since the race is clearly arch-independent.
> 
> Yes, I think this is what we have to understand. Is the race simply less
> likely to trigger on x86?
> 
> I would assume that it would trigger on any arch.
> 
> I just ran it on a x86 VM with 2 NUMA nodes and it also seems to work here.
> 
> Is this maybe related to deferred flushing? Such that the other CPU will
> by accident just observe the !pte_none a little less likely?
> 
> But arm64 also usually defers flushes, right? At least unless
> ARM64_WORKAROUND_REPEAT_TLBI is around. With that we never do deferred
> flushes.

Bingo!

diff --git a/mm/rmap.c b/mm/rmap.c
index e51ed44f8b53..ce94b810586b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -718,10 +718,7 @@ static void set_tlb_ubc_flush_pending(struct 
mm_struct *mm, pte_t pteval,
   */
  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  {
-       if (!(flags & TTU_BATCH_FLUSH))
-               return false;
-
-       return arch_tlbbatch_should_defer(mm);
+       return false;
  }


On x86:

# ./migration
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           migration.shared_anon ...
Didn't migrate 1 pages
# migration.c:170:shared_anon:Expected migrate(ptr, self->n1, self->n2) 
(-2) == 0 (0)
# shared_anon: Test terminated by assertion
#          FAIL  migration.shared_anon
not ok 1 migration.shared_anon


It fails all of the time!

-- 
Cheers,

David / dhildenb


