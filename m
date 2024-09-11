Return-Path: <linux-kernel+bounces-324578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C20A974E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6120A1C217E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D035155758;
	Wed, 11 Sep 2024 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXlqx++2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBD14EC46
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046961; cv=none; b=KWyThpoJTzb82hKPH1y95PqqhiJN6VdDJhyXa9fwubFPNMH1FTKj+uhMz3/MS8NjxTpnfHWlOhCCYgT4Pw3l5NHOHdYqcOkgtc1B8CAclch7hyA/em8eAwGOXebsIRoCA7vA68vntHd2HDq0J3zz4ZjbTXY5+W/tE2CkI5BiJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046961; c=relaxed/simple;
	bh=fQl1LLUHZigUda6LreV2FO8LTRmhgcKYyZ98CcgOxqA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F/UnuMUQXUDYZBHTkPTs3sfza2PH/fPNwLpM75d67sFIaJWyt2P8RZbUkfx9roinMsb2/fqqm5Zp2yubGWD36RmbFMWyFNVk+4OYQLxtP7ROmHX8U1JxlMSA0g2Tn5VibZ7tX33U8M1ew7HokHtCpWqSWLjMBJWPDLJgVw00Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXlqx++2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726046958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iLE3ZOfX5hUclPdAj++12iDMJYWSCcug4Rg11h4f0cU=;
	b=BXlqx++2VUhcy6LRCrtWA6s/8PBI0V6YswNmtghSKXqfAkhbK2kULSbcOsxOOHdiV8HUVQ
	FMQQoCO8V/NvKaZDLCvZMCuUIK7h5zKz0lUtQEqEOrhAFhPPYl2TwkmW47KwFDcqHz1DV4
	FFz4E6/zTyPaPl9hL3hla/SmJ8fuKDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-V_H9O0wtOmitugjj7nn8yQ-1; Wed, 11 Sep 2024 05:29:16 -0400
X-MC-Unique: V_H9O0wtOmitugjj7nn8yQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6f3c476so14709785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046955; x=1726651755;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iLE3ZOfX5hUclPdAj++12iDMJYWSCcug4Rg11h4f0cU=;
        b=M525KOWJI55U/tUowMMD10ZsNwaBwWWI5Jw5vh5zjk1/AQmk2dXVLIrTr1fGf7y7if
         I0kdR3/J9dIKQMIJ7PEu7bTs1FVcfntcO3JpLFL8g0Q1FnmkQMdtZLL87UKjlncP+RrM
         uKW6VewVEVuFqmjnfymGTGF1/L+isYC1kTIdKoByDfhf7lA/zi/3Ql5WA6QOgEQi0/hg
         TfgWqLJwwQyPaeDlo/9m1d0krp7CTd2YOTm3ubFikSYvgMTuM7JT5SU9D0eehUJRC0wB
         5dUXQv5ioTCDcz4DNanBtjV4RuK6/ycSYJicVDapc6esD3Xl/pCff2H6BI8FHgU8PoDj
         oAmA==
X-Forwarded-Encrypted: i=1; AJvYcCV7mYHfR/1Zc7gbsazdYGGEDgo0+miPxIvbSMvWJC1ouqwpbEeT0Jr1XzMF/LBx/M9XYgtsRAZ8ERMjr/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZbQT+4nEOEtW+7H2CiPWMscg5KKHomelCGnB2/5mNKKgoxvL
	rbjqTWaMbpfqtAlSkU8xxkqL5/5ZYAaSdDPvVNplX7OAY9mGlEmBnd5VyTCEYgD/sTaRHJdjbuI
	vlmkcPciv+MZfkznqpOb79uIaGANO7F7+Z7qas47ZUFT5Eykb2F1lDZ/Q2nOIng==
X-Received: by 2002:a05:600c:450e:b0:42c:ac9f:b528 with SMTP id 5b1f17b1804b1-42ccd361050mr16282945e9.35.1726046955156;
        Wed, 11 Sep 2024 02:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi7oWfnhsLpGief/bmvprTetI7erpY68pX2HEuSFPNXa0SNdbhjVVNUp2eH8EjgUlX7gIIRw==
X-Received: by 2002:a05:600c:450e:b0:42c:ac9f:b528 with SMTP id 5b1f17b1804b1-42ccd361050mr16282415e9.35.1726046954196;
        Wed, 11 Sep 2024 02:29:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:1e00:4443:eaa9:9f5d:1497? (p200300cbc70c1e004443eaa99f5d1497.dip0.t-ipconnect.de. [2003:cb:c70c:1e00:4443:eaa9:9f5d:1497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01cae3asm33647015e9.0.2024.09.11.02.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:29:13 -0700 (PDT)
Message-ID: <6eb09b5b-b23b-4bae-9629-b86df3570e06@redhat.com>
Date: Wed, 11 Sep 2024 11:29:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Abstract THP allocation
From: David Hildenbrand <david@redhat.com>
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
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f610e933-278e-4f95-a363-8f023a5e7aa9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.09.24 11:27, David Hildenbrand wrote:
> On 11.09.24 08:55, Dev Jain wrote:
>> In preparation for the second patch, abstract away the THP allocation
>> logic present in the create_huge_pmd() path, which corresponds to the
>> faulting case when no page is present.
>>
>> There should be no functional change as a result of applying
>> this patch.
>>
> 
> Hi,
> 
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>    mm/huge_memory.c | 110 +++++++++++++++++++++++++++++------------------
>>    1 file changed, 67 insertions(+), 43 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 67c86a5d64a6..b96a1ff2bf40 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -943,47 +943,88 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>>    }
>>    EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>    
>> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>> -			struct page *page, gfp_t gfp)
>> +static struct folio *pmd_thp_fault_alloc(gfp_t gfp, struct vm_area_struct *vma,
>> +					 unsigned long haddr, unsigned long addr)
> 
> I suggest calling this something like "vma_alloc_anon_folio_pmd()"? Then
> it's more consistent with vma_alloc_folio().
> 
> Also, likely we should just only pass in "addr" and calculate "haddr"
> ourselves, it's cheap and reduces the number of function parameters.
> 
>>    {
>> -	struct vm_area_struct *vma = vmf->vma;
>> -	struct folio *folio = page_folio(page);
>> -	pgtable_t pgtable;
>> -	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> -	vm_fault_t ret = 0;
>> +	const int order = HPAGE_PMD_ORDER;
>> +	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>>    
>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> +	if (unlikely(!folio)) {
>> +		count_vm_event(THP_FAULT_FALLBACK);
>> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>> +		goto out;
>> +	}
>>    
>> +	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>    	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>>    		folio_put(folio);
>>    		count_vm_event(THP_FAULT_FALLBACK);
>>    		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
>> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> -		return VM_FAULT_FALLBACK;
>> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> +		goto out;
>>    	}
>>    	folio_throttle_swaprate(folio, gfp);
>>    
>> -	pgtable = pte_alloc_one(vma->vm_mm);
>> -	if (unlikely(!pgtable)) {
>> -		ret = VM_FAULT_OOM;
>> -		goto release;
>> -	}
>> -
>> -	folio_zero_user(folio, vmf->address);
>> +	folio_zero_user(folio, addr);
>>    	/*
>>    	 * The memory barrier inside __folio_mark_uptodate makes sure that
>>    	 * folio_zero_user writes become visible before the set_pmd_at()
>>    	 * write.
>>    	 */
>>    	__folio_mark_uptodate(folio);
>> +out:
>> +	return folio;
>> +}
>> +
>> +static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
>> +{
>> +	count_vm_event(THP_FAULT_ALLOC);
>> +	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>> +}
> 
> Why isn't that moved into map_pmd_thp()
> 
> Note that in this patch you do:
> 
> map_pmd_thp(folio, vmf, vma, haddr);
> spin_unlock(vmf->ptl);
> __pmd_thp_fault_success_stats(vma);
> 
> But in patch #2
> 
> map_pmd_thp(folio, vmf, vma, haddr);
> __pmd_thp_fault_success_stats(vma);
> goto unlock;
> release:
> 	folio_put(folio);
> unlock:
> 	spin_unlock(vmf->ptl);
> 
> Please make that consistent, meaning:
> 
> 1) Inline __pmd_thp_fault_success_stats() into map_pmd_thp(). No need to
> have the separated out.
> 
> 2) Either do the PTL unlocking in __pmd_thp_fault_success_stats() or in
>      the caller. In the caller is likely easiest. Adjusting the counters
>      should be cheap, if not we could revisit this later with real data.
> 
>> +
>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>> +			struct vm_area_struct *vma, unsigned long haddr)
>> +{
>> +	pmd_t entry;
>> +
>> +	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>> +	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>> +	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>> +	folio_add_lru_vma(folio, vma);
>> +	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>> +	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> 
> It's quite weird to see a mixture of haddr and vmf->address, and likely
> this mixture is wrong or not not required.
> 
> Looking at arc's update_mmu_cache_pmd() implementation, I cannot see how
> passing in the unaligned address would do the right thing. But maybe arc
> also doesn't trigger that code path ... who knows :)
> 
> 
> Staring at some other update_mmu_cache_pmd() users, it's quite
> inconsistent. Primarily only do_huge_pmd_numa_page() and
> __do_huge_pmd_anonymous_page() use the unaligned address. The others
> seem to use the aligned address ... as one would expect when modifying a
> PMD.
> 
> 
> I suggest to change this function to *not* pass in the vmf, and rename
> it to something like:
> 
> static void folio_map_anon_pmd(struct folio *folio, struct
> vm_area_struct *vma, pmd_t *pmd, unsigned long haddr)

... or better "map_anon_folio_pmd" so it better matches 
vma_alloc_folio_pmd() suggested above.

Could also do

vma_map_anon_folio_pmd() :)

-- 
Cheers,

David / dhildenb


