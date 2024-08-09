Return-Path: <linux-kernel+bounces-281363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826B694D5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AFDB20DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC381145FE5;
	Fri,  9 Aug 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XujK5IcT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C5273501
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226809; cv=none; b=lmBYmntTzhd3WUm/Chzv/wYTdd/Febt2e9lmjLMGk/vyXj4Gc3SAgX3nWDURvf6omEij89So17dbWT9MYwA0y6LK0O/xKr9KlhrT3A3QPzZE0LxxD4cqlv4Tjwomv1Z+DiPsUFxv2z0oWl2LjcsyvvU0mfSVG58T8aXMTFMdiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226809; c=relaxed/simple;
	bh=2aIGGKzwksT3XWFDji/oQUNMW5NkFEeXTEyhx7VTGLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4laUIgO4y7973xLvVYGtlthfSuDb1nXPlTTyG6dbtS+1a3FuCZsNwwtHLwoTkfX3PXe59h6PFeKQ1Xazo9oDDE/o4u6u3AJBi5+G/aLM411Id0UU21oEar6B9Zy6moGS48jqsCI9xq9qWEkl/NQJ/UlwdTi2BC36rxlKR9fnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XujK5IcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723226807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ottb3/5hhoIcIh9XsbIo3cxS6G9yhKNk+IY5Yk/Wzbk=;
	b=XujK5IcT1JTEsOF34DgyIL+B7cmuC2qFiNd19bxsn/DGLW60Eeu7X4ZX89B/6y2Su1jbfp
	FtqxYfWf+HB4UEqaV82Aex/x1BPCbc4BQaKchyrnT8Muz4mOZokRQUR56Lgk1UZE8YxY1C
	OLcsrUBRbc496tomxO16Ir3ZJnBPNOI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-tEuIw9HFMkyZFT0evXfp-g-1; Fri, 09 Aug 2024 14:06:45 -0400
X-MC-Unique: tEuIw9HFMkyZFT0evXfp-g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42809eb7b99so12363135e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723226804; x=1723831604;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ottb3/5hhoIcIh9XsbIo3cxS6G9yhKNk+IY5Yk/Wzbk=;
        b=Y8h6YeWl386LiTBkoeb6ztuKR5XbuB2oHiCzFvmCfoJCcHBA9KO7LwyH/RbBX8s6HN
         NyDmRQq/0rj3qBT7v1SICviruN9k1G4s55vtXPhQ0rTGa23nyIfqq9ewPRBSUsxgdN6k
         HOtIkUE3hPGIij2Brh/lS3WLOLBOpp6KnaZz2+mvSpXe9BhZvSHcClnbaEM+pituJnqq
         /Qd1bAYS/CEvzgSGy79STZeTeakajmCk27YrVGha/mBlvMR1n9CcAoNhky5YLEKilrp+
         Ml1PJUYsST2bcn5+j3S/OVogg0Al4PLEyBD/SyBCtk+2+0ytMc9T4CmcRTt2QVxpcLbQ
         RWBg==
X-Forwarded-Encrypted: i=1; AJvYcCWLDfKDUVRHuQaEsCFCH8rwGXviOhebtPdoIDlLw+YGrWHxQW0ht0qELWrIK2+270FyhK+ywlAl7yLkJ8QJHAkViktiHlYep3fBJi2n
X-Gm-Message-State: AOJu0YwKh21C6B5MtGamNtFE2EPfcxZs0n8LNbpwSq/x5MX+z+r0+z86
	ws7QLgi80zBa1mCM83ejO/TVVvGHMytsF02f9VZpaVlzTtfzh5/KyXC7QvmvdF860qObFeud1aq
	EGXCKicdzLODZRZOKML/+VsGk4OVKc7crd9ZAlF+YEItN9rj97ic9WV9xtEQPrA==
X-Received: by 2002:a05:600c:1907:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-4290b7c5662mr53809185e9.0.1723226804566;
        Fri, 09 Aug 2024 11:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQKx6L1EQCWOB7RzBZmYVRt0F9P+j2Ro1H/EXqC88yiCad1Newf5OObVYXOxLEX+lEpoTrw==
X-Received: by 2002:a05:600c:1907:b0:426:6eb6:1374 with SMTP id 5b1f17b1804b1-4290b7c5662mr53808975e9.0.1723226803982;
        Fri, 09 Aug 2024 11:06:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738e01sm85236555e9.11.2024.08.09.11.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 11:06:43 -0700 (PDT)
Message-ID: <04d06717-4d44-4e09-a3cb-d8350e3466ad@redhat.com>
Date: Fri, 9 Aug 2024 20:06:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] mm: Introduce ARCH_SUPPORTS_HUGE_PFNMAP and special
 bits to pmd/pud
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Oscar Salvador <osalvador@suse.de>,
 Jason Gunthorpe <jgg@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
 <20240809160909.1023470-2-peterx@redhat.com>
 <def1dda5-a2e8-4f6b-85f6-1d6981ab0140@redhat.com> <ZrZPA_Enghb42xMq@x1n>
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
In-Reply-To: <ZrZPA_Enghb42xMq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 19:16, Peter Xu wrote:
> On Fri, Aug 09, 2024 at 06:34:15PM +0200, David Hildenbrand wrote:
>> On 09.08.24 18:08, Peter Xu wrote:
>>> This patch introduces the option to introduce special pte bit into
>>> pmd/puds.  Archs can start to define pmd_special / pud_special when
>>> supported by selecting the new option.  Per-arch support will be added
>>> later.
>>>
>>> Before that, create fallbacks for these helpers so that they are always
>>> available.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/linux/mm.h | 24 ++++++++++++++++++++++++
>>>    mm/Kconfig         | 13 +++++++++++++
>>>    2 files changed, 37 insertions(+)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 43b40334e9b2..90ca84200800 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -2644,6 +2644,30 @@ static inline pte_t pte_mkspecial(pte_t pte)
>>>    }
>>>    #endif
>>> +#ifndef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>>> +static inline bool pmd_special(pmd_t pmd)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>> +static inline pmd_t pmd_mkspecial(pmd_t pmd)
>>> +{
>>> +	return pmd;
>>> +}
>>> +#endif	/* CONFIG_ARCH_SUPPORTS_PMD_PFNMAP */
>>> +
>>> +#ifndef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
>>> +static inline bool pud_special(pud_t pud)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>> +static inline pud_t pud_mkspecial(pud_t pud)
>>> +{
>>> +	return pud;
>>> +}
>>> +#endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
>>> +
>>>    #ifndef CONFIG_ARCH_HAS_PTE_DEVMAP
>>>    static inline int pte_devmap(pte_t pte)
>>>    {
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 3936fe4d26d9..3db0eebb53e2 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -881,6 +881,19 @@ endif # TRANSPARENT_HUGEPAGE
>>>    config PGTABLE_HAS_HUGE_LEAVES
>>>    	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
>>> +# TODO: Allow to be enabled without THP
>>> +config ARCH_SUPPORTS_HUGE_PFNMAP
>>> +	def_bool n
>>> +	depends on TRANSPARENT_HUGEPAGE
>>> +
>>> +config ARCH_SUPPORTS_PMD_PFNMAP
>>> +	def_bool y
>>> +	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>> +
>>> +config ARCH_SUPPORTS_PUD_PFNMAP
>>> +	def_bool y
>>> +	depends on ARCH_SUPPORTS_HUGE_PFNMAP && HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>> +
>>>    #
>>>    # UP and nommu archs use km based percpu allocator
>>>    #
>>
>> As noted in reply to other patches, I think you have to take care of
>> vm_normal_page_pmd() [if not done in another patch I am missing] and likely
>> you want to introduce vm_normal_page_pud().
> 
> So far this patch may not have direct involvement with vm_normal_page_pud()
> yet?  Anyway, let's keep the discussion there, then we'll know how to move
> on.

vm_normal_page_pud() might make sense as of today already, primarily to 
wrap the pud_devmap() stuff (maybe that is gone soon, who knows). 
Anyhow, I can send a patch to add that as well.

-- 
Cheers,

David / dhildenb


