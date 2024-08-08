Return-Path: <linux-kernel+bounces-279606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAE94BF83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CD7B282CE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A284B18E034;
	Thu,  8 Aug 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thz7SV2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1123148316
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126830; cv=none; b=GsJgwm88Pmv4MGzrj0R0o/q+JkcMXt+W2wVSer537AqlPlf/yf7gV7Is/NLZQ14dtbd9kyzJ2HBGA1i+F60Mxe1DJHDeH6RK9cMbBmpwkPXkby5gAmj10pgORC6DymYbNf+u706JyZX9U7zpRybKnb5bo8sZtLDqMmHRxL91rPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126830; c=relaxed/simple;
	bh=Cl2Be0WmADXNABm0yGYUOsrUQ5eOVUxKd3xvcddVCVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnyNJUht9AfJiduuumpsuWUSE3n1oE5DBSSR1ZCAgf37DJmb2IkKXpE1DxDI8hJ9bSIzUZx6cp19FnWtDUId17YhWLS/q8vomFEUC1Fzy8vhWasTsCE66azaNAzIxOEjwmlIC7xp0/Lx/XMxaBW37YFA5uOT9t2ANJGnVxj3FNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thz7SV2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F71CC32782;
	Thu,  8 Aug 2024 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723126829;
	bh=Cl2Be0WmADXNABm0yGYUOsrUQ5eOVUxKd3xvcddVCVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Thz7SV2fNRHPF56ymH4YfJ88nMZ23viAxC+w4eMkUEfwbhLte2XoSNa1LW2M/mXIV
	 jY1K5Qt7kSsyEp6TDPmnoIc/3Fb7oXWlc59Mj0ymVBUBMKG4DVAVamKJgxlqHMUaip
	 KZysAMR2+KKK/zB/UtAH4LaIab6ivl4s0qWtYK0Y7iKINOKKiUUHxRksF2t9W/mNX9
	 00zj9N4X7CCods6/ZzXIZ44uXE07ht4OEZNDoqzcxDpHaWBMSXSyp7elfQEVwsj+Um
	 MpNliaXF08x7r8kf8sGCqQGPmFdcFis+tP6U/1SunnNaNT1lsb4yFwdn+7tCTHwVGe
	 QWD0Yx408S5KQ==
Message-ID: <f12608ec-9c40-4977-a5a6-479f86b44e80@kernel.org>
Date: Thu, 8 Aug 2024 16:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> Equally use struct vma_merge_struct to abstract parameters for VMA
> expansion and shrinking.
> 
> This leads the way to further refactoring and de-duplication by
> standardising the interface.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c               | 30 +++++++++++--------
>  mm/vma.c                | 66 ++++++++++++++++++-----------------------
>  mm/vma.h                |  8 ++---
>  tools/testing/vma/vma.c | 18 +++++++++--
>  4 files changed, 65 insertions(+), 57 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 721ced6e37b0..04145347c245 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1367,7 +1367,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	pgoff_t pglen = len >> PAGE_SHIFT;
>  	unsigned long charged = 0;
>  	unsigned long end = addr + len;
> -	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	int error;
>  	VMA_ITERATOR(vmi, mm, addr);
> @@ -1423,28 +1422,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
>  	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> -		merge_end = next->vm_end;
> -		vma = next;
> +		/* We can adjust this as can_vma_merge_after() doesn't touch */
> +		vmg.end = next->vm_end;

Ugh, ok but wonder how fragile that is.

> +		vma = vmg.vma = next;
>  		vmg.pgoff = next->vm_pgoff - pglen;
> -	}
>  
> -	if (vma) {
> +		/* We may merge our NULL anon_vma with non-NULL in next. */

Hm now I realize the if (vma) block probably didn't need to be added in
patch 2 only to removed here, it could have been part of the if (next &&
...) block above already? Which is not that important, but...

>  		vmg.anon_vma = vma->anon_vma;
> -		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;

I don't see why it's now ok to remove this line? Was it intended? In patch 2
it made sense to me to add it so the can_vma_merge_after() still has the
right ctx for comparing, and this didn't change?

>  	}
>  
>  	/* Check prev */
>  	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> -		merge_start = prev->vm_start;
> -		vma = prev;
> +		vmg.start = prev->vm_start;
> +		vma = vmg.vma = prev;
>  		vmg.pgoff = prev->vm_pgoff;
>  	} else if (prev) {
>  		vma_iter_next_range(&vmi);
>  	}
>  
>  	/* Actually expand, if possible */
> -	if (vma &&
> -	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> +	if (vma && !vma_expand(&vmg)) {
>  		khugepaged_enter_vma(vma, vm_flags);
>  		goto expanded;
>  	}
> @@ -2359,6 +2356,13 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	VMA_ITERATOR(vmi, mm, new_start);
>  	struct vm_area_struct *next;
>  	struct mmu_gather tlb;
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.vma = vma,
> +		.start = new_start,
> +		.end = old_end,
> +		.pgoff = vma->vm_pgoff,
> +	};
>  
>  	BUG_ON(new_start > new_end);
>  
> @@ -2373,7 +2377,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	/*
>  	 * cover the whole range: [new_start, old_end)
>  	 */
> -	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
> +	if (vma_expand(&vmg))
>  		return -ENOMEM;
>  
>  	/*
> @@ -2406,6 +2410,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	tlb_finish_mmu(&tlb);
>  
>  	vma_prev(&vmi);
> +	vmg.end = new_end;
> +
>  	/* Shrink the vma to just the new range */
> -	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
> +	return vma_shrink(&vmg);

The vma_shrink() doesn't seem to benefit that much from vmg conversion but I
guess why not. Maybe this will further change anyway...


