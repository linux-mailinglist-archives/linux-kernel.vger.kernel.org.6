Return-Path: <linux-kernel+bounces-242114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448079283AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CB41F230CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E0142E83;
	Fri,  5 Jul 2024 08:30:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779B2BCF6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168215; cv=none; b=ffPIMT2a1ZVKc2Q3BwcgJuk81+QHhS+WUJibRrHLXnD5C8CQ0OYrDvTo6qYo8p4BpFUQOOj2Up8qztkwtlxaC19hMNkLP27naOCQ8/1exZvnHyxj/Y/0oEHy6VJ9Kmr/EB0awuQV8y7RJ/lC7LI4MTaGuZQ75STI+dVpwLixQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168215; c=relaxed/simple;
	bh=3v/0AjHO5ohMO8YoQ5Pe2hqTiZoVAPvKdEBksq6i9nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQiusJX8c5otWNOuNSdFbXUljPnCHpa3RPv+SgqzAzH3YS9BLFJiNOpblDLyyYgexYCbdE3GDjrgB2Ak3YilQAHOX3MFwGJQ3ZTgZVBMjb42PhM1n4KHy2GtTm5s2HAt59Mxwib8YdzzTeuPPJUOZxDxPLx/rEJBNUSbii4b2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4816F367;
	Fri,  5 Jul 2024 01:30:36 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 936E33F762;
	Fri,  5 Jul 2024 01:30:09 -0700 (PDT)
Message-ID: <8774be3b-10bd-43b2-8dfa-e18cea21f0f6@arm.com>
Date: Fri, 5 Jul 2024 09:30:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
Content-Language: en-GB
To: Bang Li <libang.li@antgroup.com>, hughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ioworker0@gmail.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240705032309.24933-1-libang.li@antgroup.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240705032309.24933-1-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 04:23, Bang Li wrote:
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

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> Changes since v2 [2]:
>  - Move shmem_allowable_huge_orders() to shmem_fs.h (per Baolin)
>  - clean up these coding style issues (per Ryan)
> 
> Changes since v1 [1]:
>  - Put anonymous shmem mthp related logic into
>    thp_vma_allowable_orders() (per David)
> 
> [1] https://lore.kernel.org/linux-mm/20240628104926.34209-1-libang.li@antgroup.com/
> [2] https://lore.kernel.org/linux-mm/20240702023401.41553-1-libang.li@antgroup.com/
> 
>  include/linux/shmem_fs.h |  9 +++++++++
>  mm/huge_memory.c         | 13 +++++++++----
>  mm/shmem.c               |  9 +--------
>  3 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 3fb18f7eb73e..1d06b1e5408a 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -113,12 +113,21 @@ int shmem_unuse(unsigned int type);
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>  			  struct mm_struct *mm, unsigned long vm_flags);
> +unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge);
>  #else
>  static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
>  					  struct mm_struct *mm, unsigned long vm_flags)
>  {
>  	return false;
>  }
> +static inline unsigned long shmem_allowable_huge_orders(struct inode *inode,
> +				struct vm_area_struct *vma, pgoff_t index,
> +				bool global_huge)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_SHMEM
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5cbd838e96e6..0985bd75a624 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -151,10 +151,15 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	 * Must be done before hugepage flags check since shmem has its
>  	 * own flags.
>  	 */
> -	if (!in_pf && shmem_file(vma->vm_file))
> -		return shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> -				     !enforce_sysfs, vma->vm_mm, vm_flags)
> -			? orders : 0;
> +	if (!in_pf && shmem_file(vma->vm_file)) {
> +		bool global_huge = shmem_is_huge(file_inode(vma->vm_file), vma->vm_pgoff,
> +							!enforce_sysfs, vma->vm_mm, vm_flags);
> +
> +		if (!vma_is_anon_shmem(vma))
> +			return global_huge ? orders : 0;
> +		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
> +							vma, vma->vm_pgoff, global_huge);
> +	}
>  
>  	if (!vma_is_anonymous(vma)) {
>  		/*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f24177e9d5cc..921d59c3d669 100644
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


