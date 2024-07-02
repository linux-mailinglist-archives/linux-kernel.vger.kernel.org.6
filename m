Return-Path: <linux-kernel+bounces-237659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251DA923C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E6A1C22090
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387115B10B;
	Tue,  2 Jul 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO1kqP6U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90876F17
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919384; cv=none; b=bZAycNwd6Zj+kMEQ5RgPPmaE0NQHsVLPYN9oamr3COq4Qou1ablWt6Tu/dLSmsTCC2D13malBDBm0WeOjjklxm4bnlFp9DVyDe4Wfd34RM37ox2Ql4SNoRTM6w77DX+B8+KJcDfjsdvAdNbPp324UgDObNxBrhu2cPF7lqTE/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919384; c=relaxed/simple;
	bh=3Bx7TYIy6JdJzIit6GnSS9BSXBeZtHtcv8Ks9Jm9XLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxXvfE/B7etJuZ+2b58t3fNloKrk+vikV5xGhe+AFB06DPkmpSAwpRXxhEp0BzwmTNpNtN+EERvc44SsJ9vWS7pOiNJPPbpYVzGA3HWjEFdn4FyXOv58Kczf1qa4diAJX1Vx4ipOkMc8G/jwpTcwKpvInPwWMVjdaUs6sp3y07U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DO1kqP6U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719919381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+l0pK7xXsB8VFbzjnM1aGwWkl3fmkuyzRxEiDauPo+g=;
	b=DO1kqP6UX7oomsSbIm9Op3A8p3v4MKoLX0PWdsCZltte9PklrLQ15ugI0iyIUP4wU/Yiwk
	l8P3qwj/bwM6KyqNy0RJ18avu79wUgfvqQKAcbeNTd+EmDBoJmFTmKFPpstL0TMW4YwpRp
	5x0fJVhGN3xNUlSAcigQa7ZqqAkgFpQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-JI86HG8vOHKgJQjhNWc35g-1; Tue, 02 Jul 2024 07:23:00 -0400
X-MC-Unique: JI86HG8vOHKgJQjhNWc35g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3630a676a07so2598284f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719919378; x=1720524178;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l0pK7xXsB8VFbzjnM1aGwWkl3fmkuyzRxEiDauPo+g=;
        b=tEXzzunuT65ka9V+VQujgpIASFLGOlK8T0Tdxhh26rWLdXJxQJOaJ8/4818N93CRQn
         4JY7TDGhUp2w5ha4URr6v5kOFVFz7StpPBUixS80IB0El2a9dqsnccm9d51DE5TH234h
         A4WDxzCmWR5I6PgVAm3pp/+xho9Y+i224Up6rMraTmPMu2qpAEf/BNloi3yu2zKCJiVl
         UHF4kYLlmp5khT97qDAxE+J8UhhEB3TgkzVHQky8e9lUI4nfYbOWHPaGMVfj12yUjprE
         9uX91I7b9Ug7qoXp1qoA9nVyXSVeH7wAP57G1a709IhplKvMSOFXka9RiJUZ9dlHJKrq
         Dzaw==
X-Forwarded-Encrypted: i=1; AJvYcCU4JykqYZ48EkLPMLNe7TwVAQVi8xOsqlqan0XL6h8oJ+z0LDLgWVB0NNAynHihvXvnnflQ2Bb+hl7ZjrPnHKu6GZFVt2XbQIV/0kt0
X-Gm-Message-State: AOJu0Yy+Ab7l7WirC2928lgkj1K9ggatISKWzYIvoQqT8t67qvS1yaFc
	6z9vGnIMyZoatK1xQLcvN6dk5rKedPfF4kq4tOfQlFKAa1vmlm6zZ3e1P+bBpH09rW7gB4lteUB
	LxlLE9BtUN1bgqMNvog8qcXncExopEvwBWRLoLaQQ5ocBgDl2gtU4c3AFoPBydMQbqdRGDg==
X-Received: by 2002:adf:e80b:0:b0:367:3ce0:6a63 with SMTP id ffacd0b85a97d-3677571c4ffmr5420862f8f.54.1719919378563;
        Tue, 02 Jul 2024 04:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSKp3542jPJJ9yjXTGjmizXfg8u7cxRXtGJwl2SMBeW+phjVqF+jweiRdVhln6jUHg9pQn+Q==
X-Received: by 2002:adf:e80b:0:b0:367:3ce0:6a63 with SMTP id ffacd0b85a97d-3677571c4ffmr5420849f8f.54.1719919378071;
        Tue, 02 Jul 2024 04:22:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c739:2400:78ac:64bb:a39e:2578? (p200300cbc739240078ac64bba39e2578.dip0.t-ipconnect.de. [2003:cb:c739:2400:78ac:64bb:a39e:2578])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b098b4dsm195732675e9.29.2024.07.02.04.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 04:22:57 -0700 (PDT)
Message-ID: <34f2d8c6-50fa-4a8a-82a8-d417eb30ea70@redhat.com>
Date: Tue, 2 Jul 2024 13:22:56 +0200
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
In-Reply-To: <3743d7e1-0b79-4eaf-82d5-d1ca29fe347d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.24 12:26, Ryan Roberts wrote:
> On 01/07/2024 20:43, Catalin Marinas wrote:
>> On Fri, Jun 28, 2024 at 11:20:43AM -0700, Yang Shi wrote:
>>> On 6/28/24 10:24 AM, Catalin Marinas wrote:
>>>> This patch does feel a bit like working around a non-optimal user choice
>>>> in kernel space. Who knows, madvise() may even be quicker if you do a
>>>> single call for a larger VA vs touching each page.
>>>
>>> IMHO, I don't think so. I viewed this patch to solve or workaround some ISA
>>> inefficiency in kernel. Two faults are not necessary if we know we are
>>> definitely going to write the memory very soon, right?
>>
>> I agree the Arm architecture behaviour is not ideal here and any
>> timelines for fixing it in hardware, if they do happen, are far into the
>> future. Purely from a kernel perspective, what I want though is make
>> sure that longer term (a) we don't create additional maintenance burden
>> and (b) we don't keep dead code around.
>>
>> Point (a) could be mitigated if the architecture is changed so that any
>> new atomic instructions added to this range would also come with
>> additional syndrome information so that we don't have to update the
>> decoding patterns.
>>
>> Point (b), however, depends on the OpenJDK and the kernel versions in
>> distros. Nick Gasson kindly provided some information on the OpenJDK
>> changes. The atomic_add(0) change happened in early 2022, about 5-6
>> months after MADV_POPULATE_WRITE support was added to the kernel. What's
>> interesting is Ampere already contributed MADV_POPULATE_WRITE support to
>> OpenJDK a few months ago:
>>
>> https://github.com/openjdk/jdk/commit/a65a89522d2f24b1767e1c74f6689a22ea32ca6a
>>
>> The OpenJDK commit lacks explanation but what I gathered from the diff
>> is that this option is the preferred one in the presence of THP (which
>> most/all distros enable by default). If we merge your proposed kernel
>> patch, it will take time before it makes its way into distros. I'm
>> hoping that by that time, distros would have picked a new OpenJDK
>> version already that doesn't need the atomic_add(0) pattern. If that's
>> the case, we end up with some dead code in the kernel that's almost
>> never exercised.
>>
>> I don't follow OpenJDK development but I heard that updates are dragging
>> quite a lot. I can't tell whether people have picked up the
>> atomic_add(0) feature and whether, by the time a kernel patch would make
>> it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.
>>
>> There's a point (c) as well on the overhead of reading the faulting
>> instruction. I hope that's negligible but I haven't measured it.
>>
> 
> Just to add to this, I note the existing kernel behaviour is that if a write
> fault happens in a region that has a (RO) huge zero page mapped at PMD level,
> then the PMD is shattered, the PTE of the fault address is populated with a
> writable page and the remaining PTEs are populated with order-0 zero pages
> (read-only).

That also recently popped up in [1]. CCing Jinjiang. Ever since I
replied there, I also thought some more about that handling in regard to the
huge zeropage.

> 
> This seems like odd behaviour to me. Surely it would be less effort and more
> aligned with the app's expectations to notice the huge zero page in the PMD,
> remove it, and install a THP, as would have been done if pmd_none() was true? I
> don't think there is a memory bloat argument here because, IIUC, with the
> current behaviour, khugepaged would eventually upgrade it to a THP anyway?

One detail: depending on the setting of khugepaged_max_ptes_none. zeropages
are treated like pte_none. But in the common case, that setting is left alone.

> 
> Changing to this new behaviour would only be a partial solution for your use
> case, since you would still have 2 faults. But it would remove the cost of the
> shattering and ensure you have a THP immediately after the write fault. But I
> can't think of a reason why this wouldn't be a generally useful change
> regardless? Any thoughts?

The "let's read before we write" as used by QEMU migration code is the desire
to not waste memory by populating the zeropages. Deferring consuming memory
until really required.

     /*
      * We read one byte of each page; this will preallocate page tables if
      * required and populate the shared zeropage on MAP_PRIVATE anonymous memory
      * where no page was populated yet. This might require adaption when
      * supporting other mappings, like shmem.
      */


Without THP this works as expected. With THP this currently also works as
expected, but of course with the price [1] of not getting anon THP
immediately, which usually we don't care about. As you note, khugepaged might
fix this up later.

If we disable the huge zeropage, we would get anon THPs when reading instead of
small zeropages.

As reply to [1], I suggested using preallcoation (using MADV_POPULATE_WRITE)
when we really care about that performance difference, which would also
avoid the huge zeropage completely, but it's also not quite optimal in some cases.


I don't really know what to do here: changing the handling for the huge zeropage
only unconditionally does not sound too wrong, but the change in behavior
might (or might not) be desired for some use cases.

Reading from unpopulated memory can be a clear sign that really the shared zeropage
is desired (as for QEMU), and concurrent memory preallcoation/population should
ideally use MADV_POPULATE_WRITE. Maybe there are some details buried in [2] regarding
the common use cases for the huge zeropage back than.

[1] https://lkml.kernel.org/r/740d7379-3e3d-4c8c-4350-6c496969db1f@huawei.com
[2] https://lwn.net/Articles/517465/

-- 
Cheers,

David / dhildenb


