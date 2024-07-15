Return-Path: <linux-kernel+bounces-252601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C69315D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4462824B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EB718D4C8;
	Mon, 15 Jul 2024 13:32:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B401B1836D4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050344; cv=none; b=IdcYr1mWWBqUAvDPQIR6CFdgmTr93O84OHiH9S5mhn3+mntt7+zuS+8VQRg1szaeFYEjbYUvvp/hoA76hFMewiEGD7Zvys1igLc6xnGe3HzoyK4ZUyyyGqLjc3aZ1hbDVm6jXWSTHavT7dQhMnitIVuDYd643KhmV+tDbUJ2cZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050344; c=relaxed/simple;
	bh=3tYjXRaAKPKGv73xdHIp1UZJ/tTnFTPsWh1U5uDUUNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rv0JdvJauQPDUiI4j763lok98jMR2hhFrbUq7it1KTh8KcTikfefzqgfjnZK7VdmRjuxFL1jIKjCn8DZKMire6SKdH1iCA+MJQFvclHcgSP8IWUVIxvd8bjVvEclNhny4O3qWO8mAEAJzjGkRGhn4rlYs+qP2UwAewwI+FJ0Nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9A5DA7;
	Mon, 15 Jul 2024 06:32:47 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1CF33F73F;
	Mon, 15 Jul 2024 06:32:19 -0700 (PDT)
Message-ID: <aaacd8b2-1e85-4260-bc89-c01d5f8d91ef@arm.com>
Date: Mon, 15 Jul 2024 14:32:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mm: shmem: rename shmem_is_huge() to
 shmem_huge_global_enabled()
Content-Language: en-GB
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, david@redhat.com, 21cnbao@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
 <26dfca33f394b5cfa68e4dbda60bf5f54e41c534.1720755678.git.baolin.wang@linux.alibaba.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <26dfca33f394b5cfa68e4dbda60bf5f54e41c534.1720755678.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/07/2024 14:24, Baolin Wang wrote:
> The shmem_is_huge() is now used to check if the top-level huge page is enabled,
> thus rename it to reflect its usage.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/shmem_fs.h |  9 +++++----
>  mm/huge_memory.c         |  5 +++--
>  mm/shmem.c               | 15 ++++++++-------
>  3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 1d06b1e5408a..405ee8d3589a 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -111,14 +111,15 @@ extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>  int shmem_unuse(unsigned int type);
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> -			  struct mm_struct *mm, unsigned long vm_flags);
> +extern bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> +				      struct mm_struct *mm, unsigned long vm_flags);
>  unsigned long shmem_allowable_huge_orders(struct inode *inode,
>  				struct vm_area_struct *vma, pgoff_t index,
>  				bool global_huge);
>  #else
> -static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
> -					  struct mm_struct *mm, unsigned long vm_flags)
> +static __always_inline bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> +						      bool shmem_huge_force, struct mm_struct *mm,
> +						      unsigned long vm_flags)
>  {
>  	return false;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f9696c94e211..cc9bad12be75 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -152,8 +152,9 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	 * own flags.
>  	 */
>  	if (!in_pf && shmem_file(vma->vm_file)) {
> -		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> -							!enforce_sysfs, vma->vm_mm, vm_flags);
> +		bool global_huge = shmem_huge_global_enabled(file_inode(vma->vm_file),
> +							     vma->vm_pgoff, !enforce_sysfs,
> +							     vma->vm_mm, vm_flags);
>  
>  		if (!vma_is_anon_shmem(vma))
>  			return global_huge ? orders : 0;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index db7e9808830f..1445dcd39b6f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -548,9 +548,9 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>  
>  static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>  
> -static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
> -			    bool shmem_huge_force, struct mm_struct *mm,
> -			    unsigned long vm_flags)
> +static bool __shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
> +					bool shmem_huge_force, struct mm_struct *mm,
> +					unsigned long vm_flags)
>  {
>  	loff_t i_size;
>  
> @@ -581,14 +581,15 @@ static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
>  	}
>  }
>  
> -bool shmem_is_huge(struct inode *inode, pgoff_t index,
> +bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>  		   bool shmem_huge_force, struct mm_struct *mm,
>  		   unsigned long vm_flags)
>  {
>  	if (HPAGE_PMD_ORDER > MAX_PAGECACHE_ORDER)
>  		return false;
>  
> -	return __shmem_is_huge(inode, index, shmem_huge_force, mm, vm_flags);
> +	return __shmem_huge_global_enabled(inode, index, shmem_huge_force,
> +					   mm, vm_flags);
>  }
>  
>  #if defined(CONFIG_SYSFS)
> @@ -1156,7 +1157,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>  			STATX_ATTR_NODUMP);
>  	generic_fillattr(idmap, request_mask, inode, stat);
>  
> -	if (shmem_is_huge(inode, 0, false, NULL, 0))
> +	if (shmem_huge_global_enabled(inode, 0, false, NULL, 0))
>  		stat->blksize = HPAGE_PMD_SIZE;
>  
>  	if (request_mask & STATX_BTIME) {
> @@ -2153,7 +2154,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>  		return 0;
>  	}
>  
> -	huge = shmem_is_huge(inode, index, false, fault_mm,
> +	huge = shmem_huge_global_enabled(inode, index, false, fault_mm,
>  			     vma ? vma->vm_flags : 0);
>  	/* Find hugepage orders that are allowed for anonymous shmem. */
>  	if (vma && vma_is_anon_shmem(vma))


