Return-Path: <linux-kernel+bounces-235774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED8391D97E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D3FB20D54
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69E778C63;
	Mon,  1 Jul 2024 07:55:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3D3032A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820524; cv=none; b=ZUzX4S98nmh8FKhwCa/01z1EwCuFVzMZM1a3Y9A2zi2bc2DFTeJJHp6fzLwZuATO79/7NVgQbSWLoeKlt6fJCNv11fMEcgslrIz8GY/l9zYUiOBKFjUGSbRXjuC6Irizrmqt//psSjL/ps0v8VFdQTBvcAyMlLXhr9Vxj85lLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820524; c=relaxed/simple;
	bh=gay1RgPq+0OMvJZCVvDOeD0M6k0/1vWr3ns0cLsv40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouYF6E3LdSgMKwdwpSYSykuQypEoiJIfWWXV2G+8Sn6go9Xu7Tmlf0Q3YxSf9mFG+BjGe80/3lCmRJ/DPMp92L8KQACaKD7HjRSzndk8/QMZwzhNMaQMmgNKDUuZ7N8C5pqCazydvCHHYlF4bYOx1++/HWYjD77u/7hoPG+1P4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08F61339;
	Mon,  1 Jul 2024 00:55:39 -0700 (PDT)
Received: from [10.57.72.41] (unknown [10.57.72.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0E473F766;
	Mon,  1 Jul 2024 00:55:12 -0700 (PDT)
Message-ID: <4b38db15-0716-4ffb-a38b-bd6250eb93da@arm.com>
Date: Mon, 1 Jul 2024 08:55:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] support "THPeligible" semantics for mTHP with anonymous
 shmem
Content-Language: en-GB
To: Bang Li <libang.li@antgroup.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ziy@nvidia.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240628104926.34209-1-libang.li@antgroup.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240628104926.34209-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 11:49, Bang Li wrote:
> After the commit 7fb1b252afb5 ("mm: shmem: add mTHP support for
> anonymous shmem"), we can configure different policies through
> the multi-size THP sysfs interface for anonymous shmem. But
> currently "THPeligible" indicates only whether the mapping is
> eligible for allocating THP-pages as well as the THP is PMD
> mappable or not for anonymous shmem, we need to support semantics
> for mTHP with anonymous shmem similar to those for mTHP with
> anonymous memory.
> 
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  fs/proc/task_mmu.c      | 10 +++++++---
>  include/linux/huge_mm.h | 11 +++++++++++
>  mm/shmem.c              |  9 +--------
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 93fb2c61b154..09b5db356886 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -870,6 +870,7 @@ static int show_smap(struct seq_file *m, void *v)
>  {
>  	struct vm_area_struct *vma = v;
>  	struct mem_size_stats mss = {};
> +	bool thp_eligible;
>  
>  	smap_gather_stats(vma, &mss, 0);
>  
> @@ -882,9 +883,12 @@ static int show_smap(struct seq_file *m, void *v)
>  
>  	__show_smap(m, &mss, false);
>  
> -	seq_printf(m, "THPeligible:    %8u\n",
> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
> +	thp_eligible = !!thp_vma_allowable_orders(vma, vma->vm_flags,
> +						TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL);
> +	if (vma_is_anon_shmem(vma))
> +		thp_eligible = !!shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +							vma, vma->vm_pgoff, thp_eligible);

Afraid I haven't been following the shmem mTHP support work as much as I would
have liked, but is there a reason why we need a separate function for shmem?
Couldn't (shouldn't) thp_vma_allowable_orders() be taught to handle shmem too?

> +	seq_printf(m, "THPeligible:    %8u\n", thp_eligible);
>  
>  	if (arch_pkeys_enabled())
>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 212cca384d7e..f87136f38aa1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -267,6 +267,10 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>  }
>  
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge);
> +
>  struct thpsize {
>  	struct kobject kobj;
>  	struct list_head node;
> @@ -460,6 +464,13 @@ static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	return 0;
>  }
>  
> +static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}
> +
>  #define transparent_hugepage_flags 0UL
>  
>  #define thp_get_unmapped_area	NULL
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d495c0701a83..aa85df9c662a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1622,7 +1622,7 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
>  				bool global_huge)
>  {
> @@ -1707,13 +1707,6 @@ static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault
>  	return orders;
>  }
>  #else
> -static unsigned long shmem_allowable_huge_orders(struct inode *inode,
> -				struct vm_area_struct *vma, pgoff_t index,
> -				bool global_huge)
> -{
> -	return 0;
> -}
> -
>  static unsigned long shmem_suitable_orders(struct inode *inode, struct vm_fault *vmf,
>  					   struct address_space *mapping, pgoff_t index,
>  					   unsigned long orders)


