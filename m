Return-Path: <linux-kernel+bounces-173189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3448BFCC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7171F23AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ABA82D93;
	Wed,  8 May 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QAe8C61S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C414823C3
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715169506; cv=none; b=ODuRnPb6wyTOHIcyOX8YXCV44qEEe70b8M2tMaR+v7dn8hShlVMpAvKU88ahuYkJT9t0YLi3e0Op0u9IwXTOuRZrcJ5Gcb9L7q/3m7ygIsHLs4Xx8tw1EajYyubrrYUZjT8HYM3zoRzFX9O2UqmBw+tVHJ3/pRR/ZpaaEPv9FvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715169506; c=relaxed/simple;
	bh=F/tb57gMfsGr3IDr/vXp05mebfI7weh/sTP0bdQCYU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkcxN21Oc6X4KocS82ON2mN6cjVV2shUBVRsmOH74mX8uGIKHB4EpK4Z2fD1+++O6bg45v6X0ky24UPRw+OHPqU/J8SfxxSMjFTBO98ALKW6mFaF/GsVDMZ2C3/y0C8iA12+ckXpRewgEqnsXMStu7Roo7O3O6iHhkxDPHwrjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QAe8C61S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715169503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zlMp/gqiPBMf7crP3QEcWU4N+kU8MLKVgpmCU7e8GEQ=;
	b=QAe8C61SU466LMRh1MI6zp+l7gsfFAyer8F1AsC6ri/gkGbxbpgIeHIMWEEM6/1mtWxkve
	A6tPkvNQ3NUnjM7umOhxnYjYYKC1UUv69qDY02LiMzCMDs2VK4TUA0YLi/FYzS8fWpP+Kg
	F+jbXYanW+ZlwQ/WEz/ZZZ7lADAGTYE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-RXBNotgWOzKz3h9XzBCCwg-1; Wed, 08 May 2024 07:58:22 -0400
X-MC-Unique: RXBNotgWOzKz3h9XzBCCwg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34c85b29a7fso3067427f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715169501; x=1715774301;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zlMp/gqiPBMf7crP3QEcWU4N+kU8MLKVgpmCU7e8GEQ=;
        b=efApyI//QR+XEspNt7L3QTrqlWTX/AAH/7GzvGXjBiqmzzLU24CJPD0MoQO2KyDQ39
         2GJCSXZNOj3ek5FqZo7BT4rFyvynMWmDXtDnkbWWkOCLxRYMes59lRhlBGEe3hKfSnzV
         M/dpAHouJcf2Fp6AC5XqXelAY9OJ1RS1IUyIQGn7Sze68arcPs7jpQrsHGccyLoycO/p
         bULLC7ZSMULE3KvPueEgkByUueD1/UHKg9B2DBeAyT0r029R3ZxNTKk+bat4i3DCZXqS
         Zm51yg46qcwL0cN+zUHjWzm85lUIH3l3tYq21dEqn8VYQ8cA/C1d1U1Nvtqbj/jpv5bc
         FISw==
X-Forwarded-Encrypted: i=1; AJvYcCXkinsfo9Z67VoM4D2CiZtt85DcQmwwsOQ/oaysnhS8Y7rhrtsQgfNWVD1kNNelGXAGEnXN+/1F8Af3PG89NDBfiu8tZCodoWRzSe2W
X-Gm-Message-State: AOJu0YzYvq7dHLOJ3CAdaI9OVLXcjSsO0s0bD+xdS7VcO+SuClh7xzGA
	zut3Qk4a3M8BUjatDZShCP6X+STRGjrtg+b8sMOy40siroUKqeJWzg8Oz8XqvDuhQwNrsDG3G+S
	t7JJdPzJPKKI0QWdqueirYHmJ+UwOIwd1Ua/eCSCmWC5FWbL1HMmO4t426rf/MA==
X-Received: by 2002:a05:600c:46ca:b0:41c:7bd:5a84 with SMTP id 5b1f17b1804b1-41f71bc9fa4mr21630555e9.17.1715169501071;
        Wed, 08 May 2024 04:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9FthXz7eoL6Knu9LIh2o/Xrfrx6AYZ9VDy5KNYF62fcq0d3iwbylQhZ4or/NYE7xbx/cUWQ==
X-Received: by 2002:a05:600c:46ca:b0:41c:7bd:5a84 with SMTP id 5b1f17b1804b1-41f71bc9fa4mr21630365e9.17.1715169500611;
        Wed, 08 May 2024 04:58:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b0034dd56189e8sm15180159wrp.22.2024.05.08.04.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 04:58:20 -0700 (PDT)
Message-ID: <f44dc19a-e117-4418-9114-b723c5dc1178@redhat.com>
Date: Wed, 8 May 2024 13:58:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] add mTHP support for anonymous shmem
To: Daniel Gomez <da.gomez@samsung.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "hughd@google.com" <hughd@google.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "ioworker0@gmail.com" <ioworker0@gmail.com>,
 "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
 "ying.huang@intel.com" <ying.huang@intel.com>,
 "21cnbao@gmail.com" <21cnbao@gmail.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shy828301@gmail.com" <shy828301@gmail.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <CGME20240508113934eucas1p13a3972f3f9955365f40155e084a7c7d5@eucas1p1.samsung.com>
 <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
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
In-Reply-To: <fqtaxc5pgu3zmvbdad4w6xty5iozye7v5z2b5ckqcjv273nz7b@hhdrjwf6rai3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.05.24 13:39, Daniel Gomez wrote:
> On Mon, May 06, 2024 at 04:46:24PM +0800, Baolin Wang wrote:
>> Anonymous pages have already been supported for multi-size (mTHP) allocation
>> through commit 19eaf44954df, that can allow THP to be configured through the
>> sysfs interface located at '/sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled'.
>>
>> However, the anonymous shared pages will ignore the anonymous mTHP rule
>> configured through the sysfs interface, and can only use the PMD-mapped
>> THP, that is not reasonable. Many implement anonymous page sharing through
>> mmap(MAP_SHARED | MAP_ANONYMOUS), especially in database usage scenarios,
>> therefore, users expect to apply an unified mTHP strategy for anonymous pages,
>> also including the anonymous shared pages, in order to enjoy the benefits of
>> mTHP. For example, lower latency than PMD-mapped THP, smaller memory bloat
>> than PMD-mapped THP, contiguous PTEs on ARM architecture to reduce TLB miss etc.
>>
>> The primary strategy is similar to supporting anonymous mTHP. Introduce
>> a new interface '/mm/transparent_hugepage/hugepage-XXkb/shmem_enabled',
>> which can have all the same values as the top-level
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', with adding a new
>> additional "inherit" option. By default all sizes will be set to "never"
>> except PMD size, which is set to "inherit". This ensures backward compatibility
>> with the shmem enabled of the top level, meanwhile also allows independent
>> control of shmem enabled for each mTHP.
> 
> I'm trying to understand the adoption of mTHP and how it fits into the adoption
> of (large) folios that the kernel is moving towards. Can you, or anyone involved
> here, explain this? How much do they overlap, and can we benefit from having
> both? Is there any argument against the adoption of large folios here that I
> might have missed?

mTHP are implemented using large folios, just like traditional PMD-sized 
THP are. (you really should explore the history of mTHP and how it all 
works internally)

The biggest challenge with memory that cannot be evicted on memory 
pressure to be reclaimed (in contrast to your ordinary files in the 
pagecache) is memory waste, well, and placement of large chunks of 
memory in general, during page faults.

In the worst case (no swap), you allocate a large chunk of memory once 
and it will stick around until freed: no reclaim of that memory.

That's the reason why THP for anonymous memory and SHMEM have toggles to 
manually enable and configure them, in contrast to the pagecache. The 
same was done for mTHP for anonymous memory, and now (anon) shmem follows.

There are plans to have, at some point, have it all working 
automatically, but a lot for that for anonymous memory (and shmem 
similarly) is still missing and unclear.

-- 
Cheers,

David / dhildenb


