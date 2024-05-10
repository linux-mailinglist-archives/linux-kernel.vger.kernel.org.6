Return-Path: <linux-kernel+bounces-175476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E58C2032
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C328221E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F61915FA9E;
	Fri, 10 May 2024 09:05:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0915F31F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715331943; cv=none; b=JoBB21FfDCF3pIHV5ZXq80pXSBH4papopJfQ0dEFe0lcNaMu3+55P8gLrYOhoohx4ekafO5uYPS/o8hGESAlfNPLwDB1JXODTPuUFN8QgBoKO39bSQrjZVOubprqtjzq5tuF3C4fhnuxkdUsYeMJBgYUprW+TZAed2ARnIPZyzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715331943; c=relaxed/simple;
	bh=i/NcnzjW+6NOTL/D83aSrla/ItONUS0hG37UNHK/HsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW9T6+dI51qlozcbqHTezNLhFIVA5jhlAEyte058eYfCyWR73xFcX2rT7rTCWgdcQ6fb/sF0yQ2WwDwEJjXupbrbWlXsHVjVpm0/QuTDsTgSU00S8Xb9yCDh6eH4jLGO3rCMEPEAEFkOPc5HZpOEPONsxlNt/8m9l4ymf7atzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B2B106F;
	Fri, 10 May 2024 02:06:02 -0700 (PDT)
Received: from [10.57.65.1] (unknown [10.57.65.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E08003F762;
	Fri, 10 May 2024 02:05:34 -0700 (PDT)
Message-ID: <eb41fcb3-7207-40a8-9b49-0825a2e74e86@arm.com>
Date: Fri, 10 May 2024 10:05:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm: Add update_mmu_tlb_range()
Content-Language: en-GB
To: Bang Li <libang.li@antgroup.com>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 david@redhat.com, ioworker0@gmail.com, libang.linux@gmail.com
References: <20240506155120.83105-1-libang.li@antgroup.com>
 <20240506155120.83105-6-libang.li@antgroup.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240506155120.83105-6-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 16:51, Bang Li wrote:
> After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
> multi-size THP"), it may need to batch update tlb of an address range
> through the update_mmu_tlb function. We can simplify this operation by
> adding the update_mmu_tlb_range function, which may also reduce the
> execution of some unnecessary code in some architectures.
> 
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  include/linux/pgtable.h | 8 ++++++++
>  mm/memory.c             | 4 +---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 18019f037bae..869bfe6054f1 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -737,6 +737,14 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
>  #define __HAVE_ARCH_UPDATE_MMU_TLB
>  #endif

Given you are implementing update_mmu_tlb_range() in all the arches that
currently override update_mmu_tlb() I wonder if it would be cleaner to remove
update_mmu_tlb() from all those arches, and define generically, removing the
ability for arches to override it:

static inline void update_mmu_tlb(struct vm_area_struct *vma,
				unsigned long address, pte_t *ptep)
{
	update_mmu_tlb_range(vma, address, ptep, 1);
}

>  
> +#ifndef __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
> +				unsigned long address, pte_t *ptep, unsigned int nr)
> +{
> +}
> +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> +#endif

Then you could use the modern override scheme as Lance suggested and you won't
have any confusion with __HAVE_ARCH_UPDATE_MMU_TLB because it won't exist anymore.

> +
>  /*
>   * Some architectures may be able to avoid expensive synchronization
>   * primitives when modifications are made to PTE's which are already
> diff --git a/mm/memory.c b/mm/memory.c
> index eea6e4984eae..2d53e29cf76e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	vm_fault_t ret = 0;
>  	int nr_pages = 1;
>  	pte_t entry;
> -	int i;
>  
>  	/* File mapping without ->vm_ops ? */
>  	if (vma->vm_flags & VM_SHARED)
> @@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  		update_mmu_tlb(vma, addr, vmf->pte);
>  		goto release;
>  	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> -		for (i = 0; i < nr_pages; i++)
> -			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
> +		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);

I certainly agree that this will be a useful helper to have. I expect there will
be more users in future.

>  		goto release;
>  	}
>  


