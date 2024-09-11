Return-Path: <linux-kernel+bounces-324609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11413974EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8C4B26A22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10771714AC;
	Wed, 11 Sep 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpEW837D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33647183CBB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047402; cv=none; b=TM94rxnORDlqK3eyebekgO1AzHTi5BVPTErFqzFyJKOiEhCpIOPFEOJO7BsjteSwlIiLDJE0uDB2gvuVmAWyGPYIjr/1o9kAlzC8/pBqbLbaA6Gm+Z9MBhp7r3LUpW2kmgDMbKx8zpYhkT1ZtvNIM9M2WzANoGrbw5ueDWHqTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047402; c=relaxed/simple;
	bh=Cvos4lBljux01aFeW6CPCvGh3FIz/l7jhnR+kn6dyqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ho3sj40O6DjLCytIt5QN9vMWptP+l2scvDMlRmLt7JP09lcYfC2py7x8gWX/f/Wtt/DwSQKNuF3MK1jAH3gpeGkBoBGqVyyT75jGjD853I54mpNtDafyuKYKnca5O4Ten5aKwxhK3PDjLGYScOEFzKiZHleedYndzXiz8phQMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpEW837D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726047398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jA6hhgk3SEapvc64QIBRrgkyD3tYkjmKoNqISCzdZ3s=;
	b=hpEW837DHFyzClQK6+x2XcUaBW7TMRGUVnKomfQVTi/k7OUdly+jw1APw5rZv4kBiYhSQm
	r8SswWj4/NF6RTIPH435RrR303Zm/PP1kX3Ye6fXnKKERyu9Ci4PHMQCQe3WYBhMX3A54O
	rMDeGv+rgffhLr6PWAzr/q1362r70No=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-2vARE-ReMxywb0irqm2JFg-1; Wed, 11 Sep 2024 05:36:37 -0400
X-MC-Unique: 2vARE-ReMxywb0irqm2JFg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c960ee7aso4763351f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047396; x=1726652196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jA6hhgk3SEapvc64QIBRrgkyD3tYkjmKoNqISCzdZ3s=;
        b=mqW1fR2/DhKzrAf11TYNa5Swijf6zoCCgG3kr/scYn8nZPkx3v3Yy1L5Zga5BNy0Im
         85ZnckmizLsXt6V/KHmHpXfWi+1PSW+30nYy1k/Ft5ybzvhITBhhvn0G8Ad4NmXU3vB6
         JRPssEqFdh3S0NwbS04NV4gfTUszAzv1AwSeP/3mYf1vaVpjxFmu4AmCOZy6qTxesSis
         z4NW2ZpbXgtP+diEPnrYdsp+WmumpdvXAUnek/5p7bIVNdVRHZF3rjBM8vPubBI3FSCc
         iBF3PlbY8gsaSugoFVosAeR1/sV1gto9/fu8sNsY/I0yBJFra57QwjRbYgnIBom9cq7Q
         hgYA==
X-Forwarded-Encrypted: i=1; AJvYcCXNAAZz7fOovaRVW3UiQaOaojsbYlmVZYUM3iVVBNM8nlJD2txkYKGH4T15pW3Sy+6XO44JXCg71UDTC18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3SgPMVrzDA/ePpB7kKy163C/k3YNvREY+1p/eVkwQnvKIoqp
	/sKEtdzyuvmHYbG4DfIr2oJnTjH/O99IK270xnL94X2FQ5xHNhNheew9IuYGqZsLvZX0EbRr0Ax
	pbnNB8hdcNhleRK8yg7EQed/S6HBQB1GPOhBGNSiyp/ko8JIu6h/JvFTTHcS0Tw==
X-Received: by 2002:a5d:64ce:0:b0:374:c71c:3dc0 with SMTP id ffacd0b85a97d-37892466d5bmr12750064f8f.52.1726047396397;
        Wed, 11 Sep 2024 02:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElvtd0wDMd+dLM+BNfTHAYxzREvePnyAhFoLhawPAX7g6nOVhqtkRjyhcCW4LYj4qbb+xS2A==
X-Received: by 2002:a5d:64ce:0:b0:374:c71c:3dc0 with SMTP id ffacd0b85a97d-37892466d5bmr12750035f8f.52.1726047395832;
        Wed, 11 Sep 2024 02:36:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:1e00:4443:eaa9:9f5d:1497? (p200300cbc70c1e004443eaa99f5d1497.dip0.t-ipconnect.de. [2003:cb:c70c:1e00:4443:eaa9:9f5d:1497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956e8674sm11196928f8f.115.2024.09.11.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:36:35 -0700 (PDT)
Message-ID: <783a0d91-2910-4446-a979-c681dde402ec@redhat.com>
Date: Wed, 11 Sep 2024 11:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: Allocate THP on hugezeropage wp-fault
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
 <20240911065600.1002644-3-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240911065600.1002644-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.09.24 08:56, Dev Jain wrote:
> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
> replace it with a PMD-mapped THP. Change the helper introduced in the
> previous patch to flush TLB entry corresponding to the hugezeropage.
> In case of failure, fallback to splitting the PMD.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 52 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b96a1ff2bf40..3e28946a805f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -987,16 +987,20 @@ static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
>   static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>   			struct vm_area_struct *vma, unsigned long haddr)
>   {
> -	pmd_t entry;
> +	pmd_t entry, old_pmd;
> +	bool is_pmd_none = pmd_none(*vmf->pmd);
>   
>   	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>   	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>   	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>   	folio_add_lru_vma(folio, vma);
> +	if (!is_pmd_none)
> +		old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);

This should likely be done in the caller.

>   	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>   	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>   	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> -	mm_inc_nr_ptes(vma->vm_mm);
> +	if (is_pmd_none)
> +		mm_inc_nr_ptes(vma->vm_mm);

And this as well.

No need to make this function deal with this if the callers exactly know 
what they are doing.

>   }
>   
>   static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> @@ -1576,6 +1580,41 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>   	spin_unlock(vmf->ptl);
>   }
>   
> +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, unsigned long haddr)

Is there a need to pass in "haddr" if we have the vmf?

> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	struct mmu_notifier_range range;
> +	struct folio *folio;
> +	vm_fault_t ret = 0;
> +
> +	folio = pmd_thp_fault_alloc(gfp, vma, haddr, vmf->address);
> +	if (unlikely(!folio)) {
> +		ret = VM_FAULT_FALLBACK;
> +		goto out;
> +	}
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, haddr,
> +				haddr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
> +		goto release;
> +	ret = check_stable_address_space(vma->vm_mm);
> +	if (ret)
> +		goto release;

The clear+flush really belongs here.

> +	map_pmd_thp(folio, vmf, vma, haddr);
> +	__pmd_thp_fault_success_stats(vma);
> +	goto unlock;
> +release:
> +	folio_put(folio);
> +unlock:
> +	spin_unlock(vmf->ptl);
> +	mmu_notifier_invalidate_range_end(&range);
> +out:
> +	return ret;
> +}
> +

-- 
Cheers,

David / dhildenb


