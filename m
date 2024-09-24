Return-Path: <linux-kernel+bounces-336697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A277F983F69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580191F21837
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4101487FE;
	Tue, 24 Sep 2024 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6QqOK5Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3C148316
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163644; cv=none; b=XwA7E/Ozurel7gi4rBd1AAKs19UnhCwhiy1gNlIIUDaBRGJmZ0MK5sub610bqJyOsFY9zLVuAVx208Dypdl6lt+yPcJXIpwTjxUI9n5gzVA92fXd8Fket2tCL4gbSNGK4tybBJbEephtAUeCG78+MORpaa1TTyUEf7EBFHMJ1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163644; c=relaxed/simple;
	bh=O/a7fs1MHJTvhLAdtkuH2esw5RjrRz5G7ZPtwnSt7tE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDW85PeKFGSiLJVXtrlDAwqt65JS3e8UoxvKY7mfMUWmSLJ1qKWoDIjuk/yG/4K1s07o+V70ibFJYFexqZq95P2qjj39JRJOR/CbqmmUXS9Nt+3oBqh7rLQd+s+QEzr55S1nUFwPzNAJlKO0CHbvw7QwkG9hlFEBkSrJ2I/zzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6QqOK5Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y1NiZHKeiwxlKvR6yeExus7KHIJAVNjuURk05z+5r/o=;
	b=N6QqOK5Q49fw3624HX6gKzo087+3ubo39xqOZ/8ufajISghTskC36aifNJ/ozOx18V4Ydi
	enGRzfweuwGfa0zV/WHh8ldcfXvy/Fv0jAxFUgprR52E3uBWX4DitN/Oyux/+3B4BdfaMy
	QcOh6gGKy2JQgsZ5SC4iMtzJpbi+7J4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-2aKhEQApMTCdQsWkK2glvw-1; Tue, 24 Sep 2024 03:40:41 -0400
X-MC-Unique: 2aKhEQApMTCdQsWkK2glvw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb471a230so40709465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163640; x=1727768440;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1NiZHKeiwxlKvR6yeExus7KHIJAVNjuURk05z+5r/o=;
        b=DT5bYFqNbVtBRPGtT+xE+OOkAdSV2OsjFEnXmLqnNMZL7ZaFz0froBBQkIUNu27UW7
         /SBoZyC/yXtzFYLWY8lVsOHE1D1N43JxcYT9oDdxFuSRiAGHiLYPqrwKQhEiOSDw1HVG
         oqaTNIbS+e/H9Yq2uJ0tdUQCj/0pTJMfJlJ545YikOUvAHzdYb7sz3TwjpI0+MEsGytp
         sOVxLhJGBHlvoQqalnc1vVzjuU2/4LN6xfOU/wi1lyIECq2sT9rtDo0aYwEQ3MX/X8ir
         P1AJjU91nA5Vf6Roj+CitHSLXAHoKyAaCeRia03jM691I/Mwd4UZa7UuWazAzg99hIl0
         jnGA==
X-Forwarded-Encrypted: i=1; AJvYcCXEOeunuebiB7vug1REnMw0JX201ppJhoEN2cmy4MOPEBqMY3q5ny7QzFLf2rJp5/a7SfZrYX1b7hkUgOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAx+IvYJ1dBOTJkoSb1orAIE+HEDBizUPZr5aLPpwow+ok+dzz
	V+Zuss1pKRI/c++SzfXVoRi/ipiSSRDeUBzlJgbbaet6V1DntLTGug77+HSQ8+O/E3+KU/Ji/sa
	s6emMgWwjPNSJE/O58+JE6ClV4dBeIEU/Ax+WjPTwEbh+OZgtsJArHOw8Vd3Sgg==
X-Received: by 2002:a05:600c:35d2:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-42e7ada4c71mr97634025e9.24.1727163639773;
        Tue, 24 Sep 2024 00:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgb67HaIZIclsRykM639M1FbYsTLo0mDA+mPPuYbE793qdKQyblprRd1qFJL5Dl2kAJ8Xg9Q==
X-Received: by 2002:a05:600c:35d2:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-42e7ada4c71mr97633765e9.24.1727163639377;
        Tue, 24 Sep 2024 00:40:39 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7540e490sm149071445e9.8.2024.09.24.00.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 00:40:38 -0700 (PDT)
Message-ID: <225de100-6164-47f9-85b3-b191003a8e44@redhat.com>
Date: Tue, 24 Sep 2024 09:40:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: Abstract THP allocation
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240916094309.1226908-1-dev.jain@arm.com>
 <20240916094309.1226908-2-dev.jain@arm.com>
 <74089a2f-8918-4c01-8374-494bb8da906a@redhat.com>
 <2200396e-9f70-41ac-b8cb-c207501a7770@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2200396e-9f70-41ac-b8cb-c207501a7770@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.09.24 06:25, Dev Jain wrote:
> 
> On 9/17/24 17:17, David Hildenbrand wrote:
>> On 16.09.24 11:43, Dev Jain wrote:
>>> In preparation for the second patch, abstract away the THP allocation
>>> logic present in the create_huge_pmd() path, which corresponds to the
>>> faulting case when no page is present.
>>>
>>> There should be no functional change as a result of applying this patch,
>>> except that, as David notes at [1], a PMD-aligned address should
>>> be passed to update_mmu_cache_pmd().
>>>
>>> [1]:
>>> https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>    mm/huge_memory.c | 108 +++++++++++++++++++++++++++++------------------
>>>    1 file changed, 66 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 2a73efea02d7..cdc632b8dc9c 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1146,47 +1146,88 @@ unsigned long thp_get_unmapped_area(struct
>>> file *filp, unsigned long addr,
>>>    }
>>>    EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>>    -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>>> -            struct page *page, gfp_t gfp)
>>> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct
>>> *vma,
>>> +                          unsigned long addr)
>>>    {
>>> -    struct vm_area_struct *vma = vmf->vma;
>>> -    struct folio *folio = page_folio(page);
>>> -    pgtable_t pgtable;
>>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> -    vm_fault_t ret = 0;
>>> +    unsigned long haddr = addr & HPAGE_PMD_MASK;
>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>> +    const int order = HPAGE_PMD_ORDER;
>>> +    struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr,
>>> true);
>>>    -    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>> +    if (unlikely(!folio)) {
>>> +        count_vm_event(THP_FAULT_FALLBACK);
>>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>>> +        goto out;
>>> +    }
>>>    +    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>        if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>>>            folio_put(folio);
>>>            count_vm_event(THP_FAULT_FALLBACK);
>>>            count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>>> -        count_mthp_stat(HPAGE_PMD_ORDER,
>>> MTHP_STAT_ANON_FAULT_FALLBACK);
>>> -        count_mthp_stat(HPAGE_PMD_ORDER,
>>> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>> -        return VM_FAULT_FALLBACK;
>>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>> +        return NULL;
>>>        }
>>>        folio_throttle_swaprate(folio, gfp);
>>>    -    pgtable = pte_alloc_one(vma->vm_mm);
>>> -    if (unlikely(!pgtable)) {
>>> -        ret = VM_FAULT_OOM;
>>> -        goto release;
>>> -    }
>>> -
>>> -    folio_zero_user(folio, vmf->address);
>>> +    folio_zero_user(folio, addr);
>>>        /*
>>>         * The memory barrier inside __folio_mark_uptodate makes sure that
>>>         * folio_zero_user writes become visible before the set_pmd_at()
>>>         * write.
>>>         */
>>>        __folio_mark_uptodate(folio);
>>> +out:
>>> +    return folio;
>>> +}
>>> +
>>> +static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
>>> +{
>>> +    count_vm_event(THP_FAULT_ALLOC);
>>> +    count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>> +    count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>> +}
>>
>> just inline that into map_anon_folio_pmd(), please. map_anon_folio_pmd
>> is perfectly readable ;)
> 
> If you are asking me to open code it in map_anon_folio_pmd(), I'll do that.

Yes, there will be a single user, so just keep it in the caller.

-- 
Cheers,

David / dhildenb


