Return-Path: <linux-kernel+bounces-171108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D208BDFD4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1436C2883D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A203B14E2DA;
	Tue,  7 May 2024 10:37:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B424F8A3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078249; cv=none; b=FhXleCVRd5vHZpBp96aYAlATN9ht98W87ktv9UdANKE/fmaW2n5DFb8JBW+qWK1YCQC01qt6GaXRVHsCdLel38bl5wAk+eg4Sihx/WhaiswqfJuPqN6E72SAekAAObVxVCp/RnPIo2hryfKC7+kY3+OpAlHV3HPQEQqbhUWTxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078249; c=relaxed/simple;
	bh=H11OrWspJH82fJaiwGzufedcdOut95d5EKp+psvEABA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCO06nx5xBouwneOdwi8W14MB8rgRDx0Iks29Y3SBwk5m/tLa4a5rKsGUYssGE2TEvAOko/1YQwK4sAXVfRXtyLKVGC2ZH1LKB47OQ42L+2YLDrCM4JI59Bx1tCGVK0ybZr3cCyhnup+7LbiJVR9BgDGivPU1l1ow6/TQ2KyXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6C981063;
	Tue,  7 May 2024 03:37:51 -0700 (PDT)
Received: from [10.1.34.181] (unknown [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6423F587;
	Tue,  7 May 2024 03:37:24 -0700 (PDT)
Message-ID: <13939ade-a99a-4075-8a26-9be7576b7e03@arm.com>
Date: Tue, 7 May 2024 11:37:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] mm: memory: extend finish_fault() to support large
 folio
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
 shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1714978902.git.baolin.wang@linux.alibaba.com>
 <e3f4ae78ef2d565a65fadaa843e53a24bf5b57e4.1714978902.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e3f4ae78ef2d565a65fadaa843e53a24bf5b57e4.1714978902.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 09:46, Baolin Wang wrote:
> Add large folio mapping establishment support for finish_fault() as a preparation,
> to support multi-size THP allocation of anonymous shmem pages in the following
> patches.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/memory.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index eea6e4984eae..936377220b77 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4747,9 +4747,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct page *page;
> +	struct folio *folio;
>  	vm_fault_t ret;
>  	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>  		      !(vma->vm_flags & VM_SHARED);
> +	int type, nr_pages, i;
> +	unsigned long addr = vmf->address;
>  
>  	/* Did we COW the page? */
>  	if (is_cow)
> @@ -4780,24 +4783,44 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  			return VM_FAULT_OOM;
>  	}
>  
> +	folio = page_folio(page);
> +	nr_pages = folio_nr_pages(folio);
> +
> +	if (unlikely(userfaultfd_armed(vma))) {
> +		nr_pages = 1;
> +	} else if (nr_pages > 1) {
> +		unsigned long start = ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> +		unsigned long end = start + nr_pages * PAGE_SIZE;
> +
> +		/* In case the folio size in page cache beyond the VMA limits. */
> +		addr = max(start, vma->vm_start);
> +		nr_pages = (min(end, vma->vm_end) - addr) >> PAGE_SHIFT;
> +
> +		page = folio_page(folio, (addr - start) >> PAGE_SHIFT);

I still don't really follow the logic in this else if block. Isn't it possible
that finish_fault() gets called with a page from a folio that isn't aligned with
vmf->address?

For example, let's say we have a file who's size is 64K and which is cached in a
single large folio in the page cache. But the file is mapped into a process at
VA 16K to 80K. Let's say we fault on the first page (VA=16K). You will calculate
start=0 and end=64K I think?

Additionally, I think this path will end up mapping the entire folio (as long as
it fits in the VMA). But this bypasses the fault-around configuration. As I
think I mentioned against the RFC, this will inflate the RSS of the process and
can cause behavioural changes as a result. I believe the current advice is to
disable fault-around to prevent this kind of bloat when needed.

It might be that you need a special variant of finish_fault() for shmem?


> +	}
>  	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> -				      vmf->address, &vmf->ptl);
> +				       addr, &vmf->ptl);
>  	if (!vmf->pte)
>  		return VM_FAULT_NOPAGE;
>  
>  	/* Re-check under ptl */
> -	if (likely(!vmf_pte_changed(vmf))) {
> -		struct folio *folio = page_folio(page);
> -		int type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
> -
> -		set_pte_range(vmf, folio, page, 1, vmf->address);
> -		add_mm_counter(vma->vm_mm, type, 1);
> -		ret = 0;
> -	} else {
> -		update_mmu_tlb(vma, vmf->address, vmf->pte);
> +	if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
> +		update_mmu_tlb(vma, addr, vmf->pte);
> +		ret = VM_FAULT_NOPAGE;
> +		goto unlock;
> +	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +		for (i = 0; i < nr_pages; i++)
> +			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
>  		ret = VM_FAULT_NOPAGE;
> +		goto unlock;
>  	}
>  
> +	set_pte_range(vmf, folio, page, nr_pages, addr);
> +	type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
> +	add_mm_counter(vma->vm_mm, type, nr_pages);
> +	ret = 0;
> +
> +unlock:
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	return ret;
>  }


