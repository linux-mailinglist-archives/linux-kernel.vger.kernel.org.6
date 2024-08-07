Return-Path: <linux-kernel+bounces-277839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA69294A734
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A351F23D13
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71281E485D;
	Wed,  7 Aug 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apUq1mKD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F51E2880
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031410; cv=none; b=Q083Se0PNaWP6HMEcp1Pt1vov1K1a6Zm3y6xvRw9XxhrBwf8WO7nK4k7l4dWBSkNrWFgUIF2xRloAHHfnU8DoXCSgw6XZiNFohxSku1DuTG6IivQYDwfgsxDRvdliHBDfohyO9OZSE3pp2uHl1VmUuVIViPfou4zwHfYNyAKQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031410; c=relaxed/simple;
	bh=3w7Q/rI9DUDvG1e2nR8emCsrkrhv1WCZyXyFdQ9rIio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=c2yP1l6qx4uBr7hQhFs28s2cP/G31p2bbTz2gv156Wy4s9s78mNpYcbh7+xl5J3szd4s3tXovFyZ2XUoSObGJiR2VPYNhdbNGrHsNIZ5np48beIf7DDTSwfw4Sqgca9Dh+DhHNvr4Uwaq7O7LK4oRAU7JuNQ0cnUfr1gnxYE3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=apUq1mKD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723031408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHsQOsrdR14A6Xed8ME9CfHFPFoPxd9qtlZZMGa+ivk=;
	b=apUq1mKDBNijEb/+jvqTD+UUT973zm2abEz5KsHNSo9ZHDHiqbfjnzs/1sPGyOK5d7rVgs
	CaJcOVRHUBw0UtF0OnSb/w1ghM7SkyeVnB3ztbchvWDG/RJPisRi0NjCSfe2286/K9BhnN
	XkrhAijrJTsvE1w1hV2+zzKXG/jR2l0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-6F4LQ7riM1CtJDUeEJfIBQ-1; Wed, 07 Aug 2024 07:50:05 -0400
X-MC-Unique: 6F4LQ7riM1CtJDUeEJfIBQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef23b417bcso16894711fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 04:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031404; x=1723636204;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHsQOsrdR14A6Xed8ME9CfHFPFoPxd9qtlZZMGa+ivk=;
        b=TUA3jErHr0vkz4EshdPvnWBiFvEHkCQB4GgrAJskI5bSNz34oa/IUZJxH2pPm6RBgf
         0TahUe0qoXZt84NjkW+IQ+kuA5VRMM5mRQAGVd1gG1FmF2YFcJH3rN/An32gEJHZFtDD
         qz7NRmBD0yPXGEV7Zcmhh/6VaXuy52hYn6UZdWO9aNKLbPS/+c3eeDm4Mj8gcE/EPnzc
         DfRuaHNg4ywKARxuoqZp6tQGlsOZshfvrqyoqoSiOztv/Pg0w18LPiI8fCVa9T+N5i1g
         u7jQNlBDRt/fmYDr+lJYCebQ9pwgfsvtKv22ZHHmW3prRKU9DAT+wYs2neUS0Wn7mJey
         hTNA==
X-Forwarded-Encrypted: i=1; AJvYcCU5MKtx5VSpm6SM87pmbfRI++Z57N6RODNxw1p3XDd3juA5GZndoNby4AlximJNK9/1TizGVtTPR696XkRGzFVBk8nIG6BAmETwX2oS
X-Gm-Message-State: AOJu0YxVLPW4jx5Jt9S+/Mz2iGHsGlzqMIObOJBa/N8b9IRVZf0tjWZQ
	+PNiC85EXDLDv/6FvsePIiaOizS4Yk5YZwe0evgSOkoLusbfTk4XOZ4wf0x3tRiskntXj1w67qd
	60/sUR48hbHjv9gyStfvpl6eI3yLVxdIYpKmXMbkompH20m8sniYBFKpRayYHAg==
X-Received: by 2002:a2e:9e97:0:b0:2f0:25dc:1886 with SMTP id 38308e7fff4ca-2f15aa8348bmr112004021fa.10.1723031404109;
        Wed, 07 Aug 2024 04:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWb3FF4xJe7fGHSjGXrwD26crNAvQoaDWoI/JHuX05IhJvtOyXbYnIXdUTK6IRAFf3q6L56A==
X-Received: by 2002:a2e:9e97:0:b0:2f0:25dc:1886 with SMTP id 38308e7fff4ca-2f15aa8348bmr112003491fa.10.1723031403469;
        Wed, 07 Aug 2024 04:50:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580c720sm25918655e9.41.2024.08.07.04.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:50:03 -0700 (PDT)
Message-ID: <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
Date: Wed, 7 Aug 2024 13:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: keep nid around during hot-remove
From: David Hildenbrand <david@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
 ardb@kernel.org, arnd@arndb.de, bhe@redhat.com, bjorn@rivosinc.com,
 borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, chenjiahao16@huawei.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, dawei.li@shingroup.cn,
 gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
 hpa@zytor.com, kent.overstreet@linux.dev, kernel@xen0n.name,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev, luto@kernel.org, maobibo@loongson.cn,
 mark.rutland@arm.com, mcgrof@kernel.org, mingo@redhat.com,
 mpe@ellerman.id.au, muchun.song@linux.dev, namcao@linutronix.de,
 naveen@kernel.org, npiggin@gmail.com, osalvador@suse.de, palmer@dabbelt.com,
 paul.walmsley@sifive.com, peterz@infradead.org, philmd@linaro.org,
 rdunlap@infradead.org, rientjes@google.com, rppt@kernel.org,
 ryan.roberts@arm.com, souravpanda@google.com, svens@linux.ibm.com,
 tglx@linutronix.de, tzimmermann@suse.de, will@kernel.org, x86@kernel.org
References: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
 <20240806221454.1971755-2-pasha.tatashin@soleen.com>
 <345ba221-e094-47e8-9481-562faf4acd85@redhat.com>
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
In-Reply-To: <345ba221-e094-47e8-9481-562faf4acd85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 13:32, David Hildenbrand wrote:
> On 07.08.24 00:14, Pasha Tatashin wrote:
>> nid is needed during memory hot-remove in order to account the
>> information about the memmap overhead that is being removed.
>>
>> In addition, we cannot use page_pgdat(pfn_to_page(pfn)) during
>> hotremove after remove_pfn_range_from_zone().
>>
>> We also cannot determine nid from walking through memblocks after
>> remove_memory_block_devices() is called.
>>
>> Therefore, pass nid down from the beginning of hotremove to where
>> it is used for the accounting purposes.
> 
> I was happy to finally remove that nid parameter for good in:
> 
> commit 65a2aa5f482ed0c1b5afb9e6b0b9e0b16bb8b616
> Author: David Hildenbrand <david@redhat.com>
> Date:   Tue Sep 7 19:55:04 2021 -0700
> 
>       mm/memory_hotplug: remove nid parameter from arch_remove_memory()
> 
> To ask the real question: Do we really need this counter per-nid at all?
> 
> Seems to over-complicate things.

Case in point: I think the handling is wrong?

Just because some memory belongs to a nid doesn't mean that the vmemmap 
was allocated from that nid?

Wouldn't we want to look at the actual nid the vmemmap page belongs to 
that we are removing?

-- 
Cheers,

David / dhildenb


