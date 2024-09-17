Return-Path: <linux-kernel+bounces-331670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098997AFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27D01F24D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F362166310;
	Tue, 17 Sep 2024 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCab1bau"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE777641E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573674; cv=none; b=EHlojQXIkgSjHyFBSwCP/TsiqZbOY3/wZxLTb5TNtOkyKQDVdUgVa/Bw5FLQYU4HoYuaPWTc3gTKLxnfy+q1W6TkeDmHWLgsvCYHNo5dEouO8/kUSQ/mhQHt3hCuqumq2Wg4KEDJVfVReryomL5OsGCzeEBBMSsKmXnRUIyhVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573674; c=relaxed/simple;
	bh=jquDD3bIAvvQWSV+w1Q9+HdjkgGUJyYFVi6gOArMTO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mf8UXcyYoikBL1+xW5EZpcjwQVHV9HDWLpQ+EQCjo8AxuegzREJ+ZCLRBNhTZq2y8jmOReD8jj+UDohT/Sho06Sd4gdWW+hv4AMEFyX6Wr1rFLx2dG0FQk9ibNxIN392UbdIQKqvDw/0FiiomSXP7T20EPsr048KJUMzOYZIz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCab1bau; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726573671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0voOPPx/5XPPnL9EK0z5QPAdZEMz/Eh8zDdtdjd3yHs=;
	b=DCab1bauNeANKsAsiiSqCPK9LUYZTJSVZAr4E8C9ZmiS6/O4h/6SRHMDywiQmqIKox7caw
	/bkYKgnsSUF25geOkJrss5bd4NiSHPDvbUtrfelcv0c4Y2KoPFMKMa9siLqMY7CyOc66pd
	e7Xgp91oXNLD2YaGR113gTOUsVRrM5I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Gw5spoqnOgGRyP9JNJyCJw-1; Tue, 17 Sep 2024 07:47:50 -0400
X-MC-Unique: Gw5spoqnOgGRyP9JNJyCJw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8b6ed71659so354502966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726573669; x=1727178469;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0voOPPx/5XPPnL9EK0z5QPAdZEMz/Eh8zDdtdjd3yHs=;
        b=Sm4R7CXBMoOA53kddE4fzuCcDVPo53/NcolQVMVRZwmeh0MbV5XogY/uScNSs6UD2A
         eK281KLHB4ukS5hDUsYxdmDzVdbRcsjImWK045VOpplJZJnkKXyKfkqqZnO8IRHbFH4N
         SfXMuDkAL/d6qrmpp3CVshHgO+2eQeX3XYheYtrJ7oSoDj4YzHGEIirWv2R4/7xuC2Un
         9Fiu5kWqcshWh3e5SpOn9Uv0Tz98dMdcwzfzoScU52Y8CjeLMbvlDcjuvEQMIV99vDAY
         BpwZ8mtxhOWLiKY4YBAV57N5Ke/oljS/2plB1BxMZLKBWa8HOkLO/y6WDkIPEi+Y2pwG
         Vf/w==
X-Forwarded-Encrypted: i=1; AJvYcCVyZNG0DPcYBBjUkcRvMWWv32vDUCAq6+koKll2tN2e5263Q6IvpfHngDEM8gIpPvimNxvw9sCbFL2e+1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDJOevfZbZyUxj9EGxLPfIC1+mYZ1XMSVm+EC568zA43m9QSs
	ZRdJ4q9rG7Yu/8ZtvhmvFHSJol9NQMy3ahzMbnWBe/hUD8byZLamsL2nvEPT0D2aDbjS8UQgJFh
	c/hKaG4jRGD8PJxVsqy9wwAvISOlRuXniktMfIEPkS1C3e3g/lhy7P+ymMVZzAQ==
X-Received: by 2002:a17:907:26c3:b0:a72:50f7:3c6f with SMTP id a640c23a62f3a-a9029432757mr1914672466b.14.1726573668790;
        Tue, 17 Sep 2024 04:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUz+p7Ui4P9Uzycvm8Qemze+0O2m23qKR3vLHjnKJhUSKgeKkezTyoqyIcgI8FKIZ0Rz73Vw==
X-Received: by 2002:a17:907:26c3:b0:a72:50f7:3c6f with SMTP id a640c23a62f3a-a9029432757mr1914668766b.14.1726573668133;
        Tue, 17 Sep 2024 04:47:48 -0700 (PDT)
Received: from [192.168.55.136] (tmo-067-108.customers.d1-online.com. [80.187.67.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061320b9asm435124566b.189.2024.09.17.04.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 04:47:47 -0700 (PDT)
Message-ID: <74089a2f-8918-4c01-8374-494bb8da906a@redhat.com>
Date: Tue, 17 Sep 2024 13:47:45 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240916094309.1226908-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.09.24 11:43, Dev Jain wrote:
> In preparation for the second patch, abstract away the THP allocation
> logic present in the create_huge_pmd() path, which corresponds to the
> faulting case when no page is present.
> 
> There should be no functional change as a result of applying this patch,
> except that, as David notes at [1], a PMD-aligned address should
> be passed to update_mmu_cache_pmd().
> 
> [1]: https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 108 +++++++++++++++++++++++++++++------------------
>   1 file changed, 66 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a73efea02d7..cdc632b8dc9c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1146,47 +1146,88 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>   }
>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>   
> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> -			struct page *page, gfp_t gfp)
> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
> +					      unsigned long addr)
>   {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct folio *folio = page_folio(page);
> -	pgtable_t pgtable;
> -	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -	vm_fault_t ret = 0;
> +	unsigned long haddr = addr & HPAGE_PMD_MASK;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	const int order = HPAGE_PMD_ORDER;
> +	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>   
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	if (unlikely(!folio)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		goto out;
> +	}
>   
> +	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>   	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>   		folio_put(folio);
>   		count_vm_event(THP_FAULT_FALLBACK);
>   		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> -		return VM_FAULT_FALLBACK;
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +		return NULL;
>   	}
>   	folio_throttle_swaprate(folio, gfp);
>   
> -	pgtable = pte_alloc_one(vma->vm_mm);
> -	if (unlikely(!pgtable)) {
> -		ret = VM_FAULT_OOM;
> -		goto release;
> -	}
> -
> -	folio_zero_user(folio, vmf->address);
> +	folio_zero_user(folio, addr);
>   	/*
>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
>   	 * folio_zero_user writes become visible before the set_pmd_at()
>   	 * write.
>   	 */
>   	__folio_mark_uptodate(folio);
> +out:
> +	return folio;
> +}
> +
> +static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
> +{
> +	count_vm_event(THP_FAULT_ALLOC);
> +	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +}

just inline that into map_anon_folio_pmd(), please. map_anon_folio_pmd 
is perfectly readable ;)

> +
> +static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
> +			       struct vm_area_struct *vma, unsigned long haddr)


> +{
> +	pmd_t entry;
> +
> +	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
> +	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> +	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
> +	folio_add_lru_vma(folio, vma);
> +	set_pmd_at(vma->vm_mm, haddr, pmd, entry);
> +	update_mmu_cache_pmd(vma, haddr, pmd);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +	__pmd_thp_fault_success_stats(vma);
> +}
> +
> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> +{
> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	struct vm_area_struct *vma = vmf->vma;
> +	pgtable_t pgtable = NULL;
> +	struct folio *folio;
> +	vm_fault_t ret = 0;
> +
> +	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
> +	if (unlikely(!folio)) {
> +		ret = VM_FAULT_FALLBACK;
> +		goto release;

Why not simply "return VM_FAULT_FALLBACK;" ? There is nothing to 
release. Then you can avoid the

"if (folio)" below and even stop initializing pgtable to NULL.


With these things take care of

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


