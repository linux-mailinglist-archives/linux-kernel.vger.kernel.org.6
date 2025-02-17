Return-Path: <linux-kernel+bounces-517843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F373A38681
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F65A1738A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450F221DB5;
	Mon, 17 Feb 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYpqkRj7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C369223331
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802632; cv=none; b=Rw3aDBhYTqJrWku1Kkk/khcpXd9pCNU4PIjl6GHPln/mdqllI1nS3lrhCII2nIhMOezAkU4wCZZx5/6T+OzyceI8FJqLhFZ/UtzN1W9lvCwX+F6RSD/OpjINvn17Yqa670IqnSpgOlU6gLsMekbO4cUre2ZVedohPUpxyXma4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802632; c=relaxed/simple;
	bh=jpaKQCDdKqrCGqs5tcYeNWypUIvLvgmkvGlGr8cdj1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2mzwa2FNomfFv5rpZ9rq5aH1qcOH9u6h0gqluSCqDK1gXfRqU1pmHi0fkO6chp9qm4O/ugaMOTLi2CqYnqelxZQVxj6do2XPMAdvED6qzxiDT0h7Do6dQeRTtjOANcyB8i7bH1rxY1xOkqVxr8Z4dFLiqssGSzmF+XR7GRy7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYpqkRj7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739802629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TFLguTKriOEaEoNxtvT7MAJvdtieE227Ck7gm5fmJV0=;
	b=NYpqkRj7paELgjJIP8Yt7wWQrHtS63s8xltJKIwmPeB2NHiKjadsx5+OkxALVZYAN/kTUa
	ZkHuNENzE7CtAoiz3w9mR156x/uwzD8BLXDnjg7Q26h3UbVRchsQviPJ4D+BOWqSzsPafB
	nnew8HI9XYXILcHXzzBhAcB8X+aPTcc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-JW-WEVW5NKK_aOmQblUstg-1; Mon, 17 Feb 2025 09:30:28 -0500
X-MC-Unique: JW-WEVW5NKK_aOmQblUstg-1
X-Mimecast-MFC-AGG-ID: JW-WEVW5NKK_aOmQblUstg_1739802627
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4388eee7073so27548975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802627; x=1740407427;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TFLguTKriOEaEoNxtvT7MAJvdtieE227Ck7gm5fmJV0=;
        b=etHxVxVUcaoLcPQicB6sK6mWaqb0nwSXjXswVUzombJnOuXNJu90AzTpgvWAooW0FH
         WGoob4IxXvTtjMTcYrwkDyLMrIBbIRQXAyJwEOtCCrhEkcLTEEII7oUyviIJNp2RdD9J
         mC2x0p6km+ryvh05ORW8V4BQF0m7og/ohPbWVUehfITTSQMIJD4Sxfk2Pe+iuwRsKwbl
         GgWngth9sRXQPspxTNMzecrF/7jeZR+kbrqaedoMtyLvybeue0M7eFZw+VCP/CY62DFl
         IsTFOIAMykb4mpjaBnIJ88588LdBuTk+TzewUjk+6hBJylff3xGU5H6LhUSp6LZUlX0O
         8KXg==
X-Forwarded-Encrypted: i=1; AJvYcCXrG6YdVIDFJ/xv/w0ClD8vMJIp+LvlflJN/eKBJIcpoOKi6DjhkKiMRei0eb5OmZ4Wt+Bgm5VvQYYZCTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywth89kAUf9vSLmVtaoK8J8agqCStfz6PUOAN27L8O5gnNMXlLk
	Jua8WWUhrvva3Fj4oKo0M2PyAEtn0ieKsiSasrfoe6rnbAj8EKaknVcHmWF3eDsabPiXsLXlxl4
	vba0COIKOVlP72a/z8XVwEJUJhgVPAx94ORRNMkx7cuPQLarUsdwFd3Abwb4DwA==
X-Gm-Gg: ASbGncvU1gS8Ifd9IcUENgLKNXyj/ZMaaaW6gvq1H6XYddXXzkoXSS2eUVQUh9Rs+DY
	4s5kv+XVqctjsCOluiAWvcAFEh3GyWmCi/2IAQ0UaRk7HybCDUvCrjlESNR+2JbU1ERFSk8WKAV
	xzvX2ukz6y0cARxZm4o0Cc6M+3HwIXqgRr2vPl6lcgxT1J7/8D5t5mPtMj9XbCsifX8nHGBkadv
	d/ApMEaYbKNC3C1gktynEdqkbiEoCiN5VyBMQH7R1yAirNR15FM12m97oWLtyRP6mT+7PvMtw5u
	GUQ9PFuuSAi+8PJlyBWKlXDzCVQblf+15j/K0lddcKFva/ANiUbSKnS+Tm5teGha8xsqHTtIi1q
	l5Q0z5eU2FjUaOUhTTTl4f9Wa31KdAw==
X-Received: by 2002:a05:600c:5124:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-4396ec31d4amr87218165e9.7.1739802626798;
        Mon, 17 Feb 2025 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBuJdRX9HJWRT+6db3iV86k8EuFY+S3+GwbF5Y1fECsH+Mh1mHoyPVYo4RmvcbtrSvtMMq3Q==
X-Received: by 2002:a05:600c:5124:b0:434:f9ad:7222 with SMTP id 5b1f17b1804b1-4396ec31d4amr87217745e9.7.1739802626429;
        Mon, 17 Feb 2025 06:30:26 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:900:900f:3c9e:2f7b:5d0a? (p200300cbc7390900900f3c9e2f7b5d0a.dip0.t-ipconnect.de. [2003:cb:c739:900:900f:3c9e:2f7b:5d0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f208sm153583685e9.6.2025.02.17.06.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:30:25 -0800 (PST)
Message-ID: <871c0dae-c419-4ac2-9472-6901aab90dcf@redhat.com>
Date: Mon, 17 Feb 2025 15:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm64: mm: Populate vmemmap at the page level if not
 section aligned
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, anshuman.khandual@arm.com,
 catalin.marinas@arm.com
Cc: will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
 mark.rutland@arm.com, joey.gouly@arm.com, dave.hansen@linux.intel.com,
 akpm@linux-foundation.org, chenfeiyang@loongson.cn, chenhuacai@kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
References: <20250217092907.3474806-1-quic_zhenhuah@quicinc.com>
 <8c1578ed-cfef-4fba-a334-ebf5eac26d60@redhat.com>
 <ce2bd045-3e3a-42bf-9a48-9ad806ff3765@quicinc.com>
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
In-Reply-To: <ce2bd045-3e3a-42bf-9a48-9ad806ff3765@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.02.25 11:34, Zhenhua Huang wrote:
> 
> 
> On 2025/2/17 17:44, David Hildenbrand wrote:
>> On 17.02.25 10:29, Zhenhua Huang wrote:
>>> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
>>> to 27, making one section 128M. The related page struct which vmemmap
>>> points to is 2M then.
>>> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
>>> vmemmap to populate at the PMD section level which was suitable
>>> initially since hot plug granule is always one section(128M). However,
>>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
>>> existing arm64 assumptions.
>>>
>>> The first problem is that if start or end is not aligned to a section
>>> boundary, such as when a subsection is hot added, populating the entire
>>> section is wasteful.
>>>
>>> The Next problem is if we hotplug something that spans part of 128 MiB
>>> section (subsections, let's call it memblock1), and then hotplug
>>> something
>>> that spans another part of a 128 MiB section(subsections, let's call it
>>> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
>>> the entire PMD entry which also supports memblock2 even though memblock2
>>> is still active.
>>>
>>> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
>>> fix similar to x86-64: populate to pages levels if start/end is not
>>> aligned
>>> with section boundary.
>>>
>>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>>> ---
>>>    arch/arm64/mm/mmu.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index b4df5bc5b1b8..eec1666da368 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1178,7 +1178,8 @@ int __meminit vmemmap_populate(unsigned long
>>> start, unsigned long end, int node,
>>>    {
>>>        WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
>>> -    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
>>> +    if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
>>> +        (end - start < PAGES_PER_SECTION * sizeof(struct page)))
>>>            return vmemmap_populate_basepages(start, end, node, altmap);
>>>        else
>>>            return vmemmap_populate_hugepages(start, end, node, altmap);
>>
>> Yes, this does mimic what x86 does. That handling does look weird,
>> because it
>> doesn't care about any address alignments, only about the size, which is
>> odd.
>>
>> I wonder if we could do better and move this handling
>> into vmemmap_populate_hugepages(), where we already have a fallback
>> to vmemmap_populate_basepages().
> 
> Hi David,
> 
> I had the same doubt initially.
> After going through the codes, I noticed for vmemmap_populate(), the
> arguments "start" and "end" passed down should already be within one
> section.
> early path:
> for_each_present_section_nr
> 	__populate_section_memmap
> 		..
> 		vmemmap_populate()
> 
> hotplug path:
> __add_pages
> 	section_activate
> 		vmemmap_populate()
> 
> Therefore.. focusing only on the size seems OK to me, and fall back
> solution below appears unnecessary?

Ah, in that case it is fine. Might make sense to document/enforce that 
somehow for the time being ...


>> +/*
>> + * Try to populate PMDs, but fallback to populating base pages when ranges
>> + * would only partially cover a PMD.
>> + */
>>    int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned
>> long end,
>>                                            int node, struct vmem_altmap
>> *altmap)
>>    {
>> @@ -313,6 +317,9 @@ int __meminit vmemmap_populate_hugepages(unsigned
>> long start, unsigned long end,
>>           for (addr = start; addr < end; addr = next) {
> 
> This for loop appears to be redundant for arm64 as well, as above
> mentioned, a single call to pmd_addr_end() should suffice.

Right, that was what was confusing me in the first place.

> 
>>                   next = pmd_addr_end(addr, end);
>>
>> +               if (!IS_ALIGNED(addr, PMD_SIZE) || !IS_ALIGNED(next,
>> PMD_SIZE))
>> +                       goto fallback;
>> +
>>                   pgd = vmemmap_pgd_populate(addr, node);
>>                   if (!pgd)
>>                           return -ENOMEM;
>> @@ -346,6 +353,7 @@ int __meminit vmemmap_populate_hugepages(unsigned
>> long start, unsigned long end,
>>                           }
>>                   } else if (vmemmap_check_pmd(pmd, node, addr, next))
>>                           continue;
>> +fallback:
>>                   if (vmemmap_populate_basepages(addr, next, node, altmap))
>>                           return -ENOMEM;
> 
> It seems we have no chance to call populate_basepages here?


Can you elaborate?


-- 
Cheers,

David / dhildenb


