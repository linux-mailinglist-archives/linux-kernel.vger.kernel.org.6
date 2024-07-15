Return-Path: <linux-kernel+bounces-252610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 342729315E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587711C21A30
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960EE18D4D3;
	Mon, 15 Jul 2024 13:36:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAE018D4CC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050607; cv=none; b=Y8eecoUh1qTX50sIutAKOerQbUI3ozIi5qmNTQqhtGywf6mpRzT9/Vgw5QcUL2P6GT8V7fKVle0XVvgIQIR2oZfVjz7yyZViN1nYccVGaLx+1Qi9QgZ0ppsk37X8abDXG2B72cF5GCNxFtskgDMPVDV5ZghfZudEiRO7rqrA5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050607; c=relaxed/simple;
	bh=Ixoxj3dVlz1stZoY8yEN/yoVhfsbJLQgH1CdbjREfIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqztHBpmOsHBC1fj5KJCy8/5QeXrktVs4xfKodfSpTyuekzuyIdy4XeE1qpdDTzZsj63Jz2DsAPD6CAqwS8nDupAVi9NiRi1ndvQGjpSLxQdalN5Gn7izyO737k1QtlamGdgK6ahUt6vltUxCjURHK71/BGyye8Pv3dogu0Ej0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 243F5DA7;
	Mon, 15 Jul 2024 06:37:10 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4777E3F73F;
	Mon, 15 Jul 2024 06:36:43 -0700 (PDT)
Message-ID: <b670b981-bc79-4c8c-8b69-4879300066d4@arm.com>
Date: Mon, 15 Jul 2024 14:36:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: shmem: move shmem_huge_global_enabled() into
 shmem_allowable_huge_orders()
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <16dad33282617ecb90a3f466b35273b10be68d21.1720755678.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <16dad33282617ecb90a3f466b35273b10be68d21.1720755678.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2024 14:24, Baolin Wang wrote:
> Move shmem_huge_global_enabled() into the shmem_allowable_huge_orders() function,
> so that shmem_allowable_huge_orders() can also help to find the allowable huge
> orders for tmpfs. Moreover the shmem_huge_global_enabled() can become static.
> 
> No functional changes.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

one nit below, but either way:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/shmem_fs.h | 12 ++----------
>  mm/huge_memory.c         | 12 +++---------
>  mm/shmem.c               | 41 ++++++++++++++++++++++++++--------------
>  3 files changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 405ee8d3589a..1564d7d3ca61 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -111,21 +111,13 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>  int shmem_unuse(unsigned int type);
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -extern bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> -				      struct mm_struct *mm, unsigned long vm_flags);
>  unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
> -				bool global_huge);
> +				bool shmem_huge_force);
>  #else
> -static __always_inline bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> -						      bool shmem_huge_force, struct mm_struct *mm,
> -						      unsigned long vm_flags)
> -{
> -	return false;
> -}
>  static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
> -				bool global_huge)
> +				bool shmem_huge_force)
>  {
>  	return 0;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cc9bad12be75..f69980b5b5fc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -151,16 +151,10 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	 * Must be done before hugepage flags check since shmem has its
>  	 * own flags.
>  	 */
> -	if (!in_pf && shmem_file(vma->vm_file)) {
> -		bool global_huge = shmem_huge_global_enabled(file_inode(vma->vm_file),
> -							     vma->vm_pgoff, !enforce_sysfs,
> -							     vma->vm_mm, vm_flags);
> -
> -		if (!vma_is_anon_shmem(vma))
> -			return global_huge ? orders : 0;
> +	if (!in_pf && shmem_file(vma->vm_file))
>  		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
> -							vma, vma->vm_pgoff, global_huge);
> -	}
> +						   vma, vma->vm_pgoff,
> +						   !enforce_sysfs);
>  
>  	if (!vma_is_anonymous(vma)) {
>  		/*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 1445dcd39b6f..4d274f5a17d9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -581,7 +581,7 @@ static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>  	}
>  }
>  
> -bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> +static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>  		   bool shmem_huge_force, struct mm_struct *mm,
>  		   unsigned long vm_flags)
>  {
> @@ -772,6 +772,13 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>  {
>  	return 0;
>  }
> +
> +static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> +		bool shmem_huge_force, struct mm_struct *mm,
> +		unsigned long vm_flags)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
>  /*
> @@ -1625,27 +1632,39 @@ static gfp_t limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
> -				bool global_huge)
> +				bool shmem_huge_force)
>  {
>  	unsigned long mask = READ_ONCE(huge_shmem_orders_always);
>  	unsigned long within_size_orders = READ_ONCE(huge_shmem_orders_within_size);
> -	unsigned long vm_flags = vma->vm_flags;
> +	unsigned long vm_flags = vma ? vma->vm_flags : 0;
> +	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;

nit: rather than deriving the fault_mm here, I wonder if its cleaner to just
pass vma to shmem_huge_global_enabled()? shmem_huge_global_enabled() is just
using it as a guard to access vm_flags, which you can just as easily do by
testing the vma for non-NULL. And you can access mm flags with vma->vm_mm->flags
after testing the vma too.

>  	/*
>  	 * Check all the (large) orders below HPAGE_PMD_ORDER + 1 that
>  	 * are enabled for this vma.
>  	 */
>  	unsigned long orders = BIT(PMD_ORDER + 1) - 1;
> +	bool global_huge;
>  	loff_t i_size;
>  	int order;
>  
> -	if ((vm_flags & VM_NOHUGEPAGE) ||
> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
> +	if (vma && ((vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
>  		return 0;
>  
>  	/* If the hardware/firmware marked hugepage support disabled. */
>  	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>  		return 0;
>  
> +	global_huge = shmem_huge_global_enabled(inode, index, shmem_huge_force,
> +						fault_mm, vm_flags);
> +	if (!vma || !vma_is_anon_shmem(vma)) {
> +		/*
> +		 * For tmpfs, we now only support PMD sized THP if huge page
> +		 * is enabled, otherwise fallback to order 0.
> +		 */
> +		return global_huge ? BIT(HPAGE_PMD_ORDER) : 0;
> +	}
> +
>  	/*
>  	 * Following the 'deny' semantics of the top level, force the huge
>  	 * option off from all mounts.
> @@ -2081,7 +2100,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  	struct mm_struct *fault_mm;
>  	struct folio *folio;
>  	int error;
> -	bool alloced, huge;
> +	bool alloced;
>  	unsigned long orders = 0;
>  
>  	if (WARN_ON_ONCE(!shmem_mapping(inode->i_mapping)))
> @@ -2154,14 +2173,8 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  		return 0;
>  	}
>  
> -	huge = shmem_huge_global_enabled(inode, index, false, fault_mm,
> -			     vma ? vma->vm_flags : 0);
> -	/* Find hugepage orders that are allowed for anonymous shmem. */
> -	if (vma && vma_is_anon_shmem(vma))
> -		orders = shmem_allowable_huge_orders(inode, vma, index, huge);
> -	else if (huge)
> -		orders = BIT(HPAGE_PMD_ORDER);
> -
> +	/* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
> +	orders = shmem_allowable_huge_orders(inode, vma, index, false);
>  	if (orders > 0) {
>  		gfp_t huge_gfp;
>  


