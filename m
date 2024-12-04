Return-Path: <linux-kernel+bounces-432229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804C19E47F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C24016486C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F91F541D;
	Wed,  4 Dec 2024 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CVnzOQgP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377918DF6D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351789; cv=none; b=Fv3pCWYKqUHlKFihAMEXENLwdHYieoRCg8Q9zKgAeFHfCy+pJPdJp+AGcK+VPP4IjsvlwUVBi6FpqyvsnL5elypwtTIW3ReE9jQkUri5tEmsw61j8LT6aJ0leGNOQKlEibTGRvGfgOk0yO+IQWEEnOtsIYGTJacHvDc/PUF6c/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351789; c=relaxed/simple;
	bh=/eLmxoMarIRFWShqykMYsWfAXvN/KtokE6TigjvmROo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y8d/ZIJRrNj+nUqVW41DmSYjDx8u0HlxEmbKpBMpiI8jD6C+Bcz3vKM+uwPxQeR2oBBSruYfuWA2YQ6BNCXV1WhmJQKPZydyUTELq3MghwY8cW42dVmD5EP5hZZChG/ox3XJgcvtKjAp23BP/aVKFmQ2JFpy07GCat7PQ6cma+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CVnzOQgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB6C4CEDF;
	Wed,  4 Dec 2024 22:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733351786;
	bh=/eLmxoMarIRFWShqykMYsWfAXvN/KtokE6TigjvmROo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVnzOQgPJiM8ugGXq90SXymx4VXl9O3R3bsUDWFSmuIeY+gmbfbdcOc1lsUrtVZA7
	 4dFL6NFsE7oQ5eWlDu4Gex/CG5uQI6D8KZJg9ypY9ihdR45fG9dWdiBNKGkSQroCcq
	 E+HRGP8768hyb/WlY7miKuHKULbEjL05M5DsaGuc=
Date: Wed, 4 Dec 2024 14:36:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, jannh@google.com, hughd@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 peterx@redhat.com, mgorman@suse.de, catalin.marinas@arm.com,
 will@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, x86@kernel.org, lorenzo.stoakes@oracle.com,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] mm: pgtable: reclaim empty PTE page in
 madvise(MADV_DONTNEED)
Message-Id: <20241204143625.a09c2b8376b2415b985cf50a@linux-foundation.org>
In-Reply-To: <92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
References: <cover.1733305182.git.zhengqi.arch@bytedance.com>
	<92aba2b319a734913f18ba41e7d86a265f0b84e2.1733305182.git.zhengqi.arch@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 19:09:49 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> Now in order to pursue high performance, applications mostly use some
> high-performance user-mode memory allocators, such as jemalloc or
> tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
> to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
> release page table memory, which may cause huge page table memory usage.
> 
> The following are a memory usage snapshot of one process which actually
> happened on our server:
> 
>         VIRT:  55t
>         RES:   590g
>         VmPTE: 110g
> 
> In this case, most of the page table entries are empty. For such a PTE
> page where all entries are empty, we can actually free it back to the
> system for others to use.
> 
> As a first step, this commit aims to synchronously free the empty PTE
> pages in madvise(MADV_DONTNEED) case. We will detect and free empty PTE
> pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclude
> cases other than madvise(MADV_DONTNEED).
> 
> Once an empty PTE is detected, we first try to hold the pmd lock within
> the pte lock. If successful, we clear the pmd entry directly (fast path).
> Otherwise, we wait until the pte lock is released, then re-hold the pmd
> and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-detect
> whether the PTE page is empty and free it (slow path).

"wait until the pte lock is released" sounds nasty.  I'm not
immediately seeing the code which does this.  PLease provide more
description?

> For other cases such as madvise(MADV_FREE), consider scanning and freeing
> empty PTE pages asynchronously in the future.
> 
> The following code snippet can show the effect of optimization:
> 
>         mmap 50G
>         while (1) {
>                 for (; i < 1024 * 25; i++) {
>                         touch 2M memory
>                         madvise MADV_DONTNEED 2M
>                 }
>         }
> 
> As we can see, the memory usage of VmPTE is reduced:
> 
>                         before                          after
> VIRT                   50.0 GB                        50.0 GB
> RES                     3.1 MB                         3.1 MB
> VmPTE                102640 KB                         240 KB
> 
> ...
>
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1301,6 +1301,21 @@ config ARCH_HAS_USER_SHADOW_STACK
>  	  The architecture has hardware support for userspace shadow call
>            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>  
> +config ARCH_SUPPORTS_PT_RECLAIM
> +	def_bool n
> +
> +config PT_RECLAIM
> +	bool "reclaim empty user page table pages"
> +	default y
> +	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> +	select MMU_GATHER_RCU_TABLE_FREE
> +	help
> +	  Try to reclaim empty user page table pages in paths other than munmap
> +	  and exit_mmap path.
> +
> +	  Note: now only empty user PTE page table pages will be reclaimed.
> +

Why is this optional?  What is the case for permitting PT_RECLAIM to e
disabled?

>  source "mm/damon/Kconfig"
>  
>  endmenu
>
> ...
>
> +void try_to_free_pte(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
> +		     struct mmu_gather *tlb)
> +{
> +	pmd_t pmdval;
> +	spinlock_t *pml, *ptl;
> +	pte_t *start_pte, *pte;
> +	int i;
> +
> +	pml = pmd_lock(mm, pmd);
> +	start_pte = pte_offset_map_rw_nolock(mm, pmd, addr, &pmdval, &ptl);
> +	if (!start_pte)
> +		goto out_ptl;
> +	if (ptl != pml)
> +		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +
> +	/* Check if it is empty PTE page */
> +	for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
> +		if (!pte_none(ptep_get(pte)))
> +			goto out_ptl;
> +	}

Are there any worst-case situations in which we'll spend uncceptable
mounts of time running this loop?

> +	pte_unmap(start_pte);
> +
> +	pmd_clear(pmd);
> +
> +	if (ptl != pml)
> +		spin_unlock(ptl);
> +	spin_unlock(pml);
> +
> +	free_pte(mm, addr, tlb, pmdval);
> +
> +	return;
> +out_ptl:
> +	if (start_pte)
> +		pte_unmap_unlock(start_pte, ptl);
> +	if (ptl != pml)
> +		spin_unlock(pml);
> +}
> -- 
> 2.20.1

