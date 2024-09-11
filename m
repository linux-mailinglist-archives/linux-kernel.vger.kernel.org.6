Return-Path: <linux-kernel+bounces-324973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCE97535D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9B1F24A00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C441199958;
	Wed, 11 Sep 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOufYMOl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78711917E5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060477; cv=none; b=KgqH73TDP8of0fI3eZt14O1UPZ7MHw6lOPwG+J9F3ZI7mr98P5E1BtQbACgph2fAQpHxRHwDcHk249sk6u9hwGvgAEBbaqBGXwNP+zJeAPkjMUyBsen5tpgYKCspKbuO7qnM0xQRotKLqAYiIrM7UMtjiK0AYLaVi35QyTbAXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060477; c=relaxed/simple;
	bh=HD2Xef+3B5xmTgyCS23VyEbQoQ2KyvCXcBqp2vz3Nrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8K8bW5P8QWSlnt2B2V23C4pd6NRxtzuChC53GLBTsVHF2MAHzQppQSPXgcr175igoBf/jcL5Inc+3V5PdLlahhpKbIEkgihT55BuA5qfKe5riqlqQVnzFIUs/3NCYzsKGvztggaa0UZYdsjl4EFx7lM83gmwuRDYXxCj6E7hDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOufYMOl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726060474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bkCOG6izXsnlZnjNQ3l2VZQ+6FIky3ox9qKNwZv98vM=;
	b=aOufYMOlq9o3LfZ5RKxJ9x/eILa7Shoo0Y8Syg1hv9CKJwR2EV2ALXNGJV9ACWnzPPM1gg
	kdo+coZiNpiQmtJbvRWCyWryeZw0sdttKWWm5QZMTRn+HUovvHPcnm4a9Au7Mbvu3oXw0L
	y1/N+S+QBsJpCGKxTKIMLNoE2Kfk51c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-08S8zG24Ox2MYPUOIuza5w-1; Wed, 11 Sep 2024 09:14:33 -0400
X-MC-Unique: 08S8zG24Ox2MYPUOIuza5w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb635b108so15574815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726060472; x=1726665272;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkCOG6izXsnlZnjNQ3l2VZQ+6FIky3ox9qKNwZv98vM=;
        b=Xcf6DtVkZ2h6Q+s8XnZNeSEy1rMNCC6f9+S1fr1vSK7v+5MnGDdvotRa8GpZYr0onp
         MO1toaYuHKqFSFhejE+2k341JfmFrPEUj7YvsW5jqACMdkmUcmHhg4C4yX14vhccUNNe
         LNvj236A4tKqeF0v1EUNT9PbxeTALrTFrd3zOCG4r4JpxW7xlvAnmePYqSOdRVzvtZxU
         eJNqOI4THRem3ulJQy11X7UKTKC8nXdVoVppr+/pNDfXoGHeC3ZMtW5VnzVbRvUvlZjm
         uoFkDnqSrCk3kQ9oVQ+q4TCeTTEnpWsM+jD1zyZ521irptPezXYzXOuM/rwpB4ZN+0pV
         bt7g==
X-Forwarded-Encrypted: i=1; AJvYcCWE+/BbUjs9xxw4MVZakXWbUepR0pelgdQuUkb7qIyHYFk90QLv1UHlaRN+OdB7CrVgvGgLod6fD3LVRak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNgv618o3hHPcg9i+l2mAJsKl8P4+gb/LnR8nAgrPW3QzyBj8
	14A30pxuAYOV2zFhDn34KV2NSsXyr3weXvOdLLhhHwdr5eBrPL/1UjSfW5ETT1NZDgCEkI+9VzW
	yRmuW+xADZFmWK5uAb0eaP0UfAfaK/p1rOsobKa/7d6b1cjnGsIef8RECHGKuUQ==
X-Received: by 2002:a5d:6712:0:b0:374:c0c9:d178 with SMTP id ffacd0b85a97d-378b0796583mr1906607f8f.9.1726060472177;
        Wed, 11 Sep 2024 06:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFADlyM7i81oTh6MMg5f4MdFZhfMAlSWiXsWWTdqomexRMLEC3vWgtq+M3/jWLI+l6a1OsmGQ==
X-Received: by 2002:a5d:6712:0:b0:374:c0c9:d178 with SMTP id ffacd0b85a97d-378b0796583mr1906580f8f.9.1726060471435;
        Wed, 11 Sep 2024 06:14:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:7e00:c672:608:5b3e:df8c? (p200300cbc7007e00c67206085b3edf8c.dip0.t-ipconnect.de. [2003:cb:c700:7e00:c672:608:5b3e:df8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8b7f1sm143705455e9.48.2024.09.11.06.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:14:30 -0700 (PDT)
Message-ID: <1e722a8f-0d07-40d0-aa30-4ee43dff7951@redhat.com>
Date: Wed, 11 Sep 2024 15:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Abstract THP allocation
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240911065600.1002644-1-dev.jain@arm.com>
 <20240911065600.1002644-2-dev.jain@arm.com>
 <f610e933-278e-4f95-a363-8f023a5e7aa9@redhat.com>
 <8bc0e51b-0e9b-4eeb-997f-e2a0b1a0c0f8@arm.com>
 <ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com>
 <62df853c-98fb-4900-9cc6-04208e9611c6@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <62df853c-98fb-4900-9cc6-04208e9611c6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11.09.24 15:05, Dev Jain wrote:
> 
> On 9/11/24 18:30, David Hildenbrand wrote:
>> On 11.09.24 14:53, Dev Jain wrote:
>>>
>>> On 9/11/24 14:57, David Hildenbrand wrote:
>>>> On 11.09.24 08:55, Dev Jain wrote:
>>>>> In preparation for the second patch, abstract away the THP allocation
>>>>> logic present in the create_huge_pmd() path, which corresponds to the
>>>>> faulting case when no page is present.
>>>>>
>>>>> There should be no functional change as a result of applying
>>>>> this patch.
>>>>>
>>>>
>>>> [...]
>>>>
>>>>> +
>>>>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>>>> +            struct vm_area_struct *vma, unsigned long haddr)
>>>>> +{
>>>>> +    pmd_t entry;
>>>>> +
>>>>> +    entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>>>> +    entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>>>> +    folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>>>> +    folio_add_lru_vma(folio, vma);
>>>>> +    set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>>>> +    update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>>>
>>>> It's quite weird to see a mixture of haddr and vmf->address, and
>>>> likely this mixture is wrong or not not required.
>>>>
>>>> Looking at arc's update_mmu_cache_pmd() implementation, I cannot see
>>>> how passing in the unaligned address would do the right thing. But
>>>> maybe arc also doesn't trigger that code path ... who knows :)
>>>
>>> If I am reading correctly, arch/arc/mm/tlb.c: update_mmu_cache_pmd()
>>> calls update_mmu_cache_range() which is already expecting an unaligned
>>> address? But...
>>
>> So update_mmu_cache_pmd() calls
>>
>>      update_mmu_cache_range(NULL, vma, addr, &pte, HPAGE_PMD_NR);
>>
>> But update_mmu_cache_range() only aligns it *to page boundary*:
>>
>>      unsigned long vaddr = vaddr_unaligned & PAGE_MASK;
> 
> Ah, totally missed that it was PAGE_MASK. Thanks.
>>
>> We obtain the correct hugepage-aligned physical address from the PTE
>>
>>      phys_addr_t paddr = pte_val(*ptep) & PAGE_MASK_PHYS;
>>
>> Then, we look at the offset in our folio
>>
>>      unsigned long offset = offset_in_folio(folio, paddr);
>>
>> And adjust both vaddr and paddr
>>
>>      paddr -= offset;
>>      vaddr -= offset;
>>
>> To then use that combination with
>>
>>      __inv_icache_pages(paddr, vaddr, nr);
>>
>> If I am not wrong, getting a non-hugepage aligned vaddr messes up
>> things here. But only regarding the icache I think.
> 
> Looks like it...

As we are adding a fresh page where there previously wasn't anything 
mapped (no icache invaldiation required?), and because most anon 
mappings are not executable, maybe that's why nobody notices so far.

-- 
Cheers,

David / dhildenb


