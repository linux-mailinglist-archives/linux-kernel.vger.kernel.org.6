Return-Path: <linux-kernel+bounces-211579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D89053F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481FD1C21877
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E0017C215;
	Wed, 12 Jun 2024 13:40:27 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2317083D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199627; cv=none; b=keX/AJTYDqXrelgxDeNLcvMYYmsl6pfhLPRgsnsgfWqrw+ZNdKMm6dLGtUyDYxc1jZ1thbJfC6plFBnEbb13R+q//y43B9sT265ArrQPfU7SJRbhXTCn0EMw+xk53A2W03m6KY0LfGS2zOuDXMuoEa8/deRybqDmVFO6azkeOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199627; c=relaxed/simple;
	bh=AoQHdQRSR1q86nRBCmXyFEYA70ONFEKUBtXHBIB74MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lzFfyY29HJUK4vrofuAnk/BIXHIN65V1AaGvejopzH2x66GsxHMJ25Klmh0TvtOWtAwk5iGvChsUN2BtQMEFfqJOx7R7tKqGvMqAhQeTfW9HlCQGGxmbVPecj3LW63y60SIqupoIWNS/dw//FpgsFjfzPtaCfAtzTlOUHTE/q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vzmlf3M0sz1SBkY;
	Wed, 12 Jun 2024 21:36:14 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C69818007B;
	Wed, 12 Jun 2024 21:40:20 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 12 Jun 2024 21:40:19 +0800
Message-ID: <bab26abd-9364-4a6b-9bed-5bcf2cb46952@huawei.com>
Date: Wed, 12 Jun 2024 21:40:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] mm: memory: extend finish_fault() to support large
 folio
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, <akpm@linux-foundation.org>,
	<hughd@google.com>
CC: <willy@infradead.org>, <david@redhat.com>, <ying.huang@intel.com>,
	<21cnbao@gmail.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
	<ziy@nvidia.com>, <ioworker0@gmail.com>, <da.gomez@samsung.com>,
	<p.raghav@samsung.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <cover.1718090413.git.baolin.wang@linux.alibaba.com>
 <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <3a190892355989d42f59cf9f2f98b94694b0d24d.1718090413.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/6/11 18:11, Baolin Wang wrote:
> Add large folio mapping establishment support for finish_fault() as a
> preparation, to support multi-size THP allocation of anonymous shmem pages
> in the following patches.
> 
> Keep the same behavior (per-page fault) for non-anon shmem to avoid inflating
> the RSS unintentionally, and we can discuss what size of mapping to build
> when extending mTHP to control non-anon shmem in the future.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/memory.c | 57 +++++++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index eef4e482c0c2..72775ee99ff3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4831,9 +4831,12 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct page *page;
> +	struct folio *folio;
>   	vm_fault_t ret;
>   	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
>   		      !(vma->vm_flags & VM_SHARED);
> +	int type, nr_pages;
> +	unsigned long addr = vmf->address;
>   
>   	/* Did we COW the page? */
>   	if (is_cow)
> @@ -4864,24 +4867,58 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>   			return VM_FAULT_OOM;
>   	}
>   
> +	folio = page_folio(page);
> +	nr_pages = folio_nr_pages(folio);
> +
> +	/*
> +	 * Using per-page fault to maintain the uffd semantics, and same
> +	 * approach also applies to non-anonymous-shmem faults to avoid
> +	 * inflating the RSS of the process.
> +	 */
> +	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
> +		nr_pages = 1;
> +	} else if (nr_pages > 1) {
> +		pgoff_t idx = folio_page_idx(folio, page);
> +		/* The page offset of vmf->address within the VMA. */
> +		pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
> +
						vma->vm_pgoff

> +		/*
> +		 * Fallback to per-page fault in case the folio size in page
> +		 * cache beyond the VMA limits.
> +		 */
> +		if (unlikely(vma_off < idx ||
> +			     vma_off + (nr_pages - idx) > vma_pages(vma))) {
> +			nr_pages = 1;
> +		} else {
> +			/* Now we can set mappings for the whole large folio. */
> +			addr = vmf->address - idx * PAGE_SIZE;

			addr -= idx * PAGE_SIZE;

> +			page = &folio->page;
> +		}
> +	}
> +
>   	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> -				      vmf->address, &vmf->ptl);
> +				       addr, &vmf->ptl);

no newline now,

>   	if (!vmf->pte)
>   		return VM_FAULT_NOPAGE;
>   
>   	/* Re-check under ptl */
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
> +		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>   		ret = VM_FAULT_NOPAGE;
> +		goto unlock;
>   	}

We may add a vmf_pte_range_changed(), but separate it.

Some very small nits, up to you,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>   
> +	folio_ref_add(folio, nr_pages - 1);
> +	set_pte_range(vmf, folio, page, nr_pages, addr);
> +	type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
> +	add_mm_counter(vma->vm_mm, type, nr_pages);
> +	ret = 0;
> +
> +unlock:
>   	pte_unmap_unlock(vmf->pte, vmf->ptl);
>   	return ret;
>   }

