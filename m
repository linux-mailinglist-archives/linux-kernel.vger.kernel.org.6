Return-Path: <linux-kernel+bounces-276185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3FB948FA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF05C1C20CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9615B1C461A;
	Tue,  6 Aug 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="NTDtzml0"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAD1FA5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948897; cv=none; b=p4DLFSZbnM7ojsgBF8Ax8TMSPYZQCmZg8nPNh021OQc5wOPlKmt2FydmZ93MA3ZA7hUKwwRZSK/1i6rqrPQuMuZ4MJIXXacQ3yq7fqQX1FlGdQ9q9Tm39fzC+YKnU8AUAsuwQ67sD1PUAbjJBb97f2M28EhlkBbil8f8xE91ifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948897; c=relaxed/simple;
	bh=smSrY9+rQauFZcZXF8acNSkpo+JBcorP9LeYjkgv/gs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gD9E5p7RZPvM6XT4lYAc0gzYQQLQGtY8sTFTCaemYSAKcpxq23W8yG5dnlIG5mOJFx6yUCpXekO3R7deSHrKzBwnGS/DpeoGEpQUnTriDIgvwp3b895HxIryFDOm7WRQxKKxgdMl0i7S/huvGGtYY5/ME6QgOIP2UyV4x7Mn2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=NTDtzml0; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [213.235.133.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id D45851D34A3;
	Tue,  6 Aug 2024 14:54:50 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722948891; bh=MWl049Bn4PnMNumCLOW2ZCWIPPF66Ed0gVhTgNbDoUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTDtzml0m6Oi8xF5v1/GV2FmnqiY1X19WsqteXOAoPj/pQ9c2O6R67RqSrZQdRUF0
	 +UIQzbDhjLijPevD1Zo5BLMo8dWn/fg9Wy8z1CKSgS+uKJWDOr/eaualydOXHIUfVE
	 n/wpGC3Gnt8jZLWFIZMDDV75ar80w2IdaAUuIJScmHkzBxh7zpHYhwRQftLrTH+/b8
	 7KLtzAFY+C4WziUvKHdbDrznTCd26HR2hbaVGMtdBmkG1ru24mMkHMDoQSKpWpgiyu
	 t3DKTsPi8sacGluqN4dQ+wdLri8CRBfqINXD5BWZsadMdFgBFHEmi++aQss7PzSEs/
	 8UTeG4pCzVzHw==
Date: Tue, 6 Aug 2024 14:54:44 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Message-ID: <20240806145444.4e1b00da@mordecai.tesarici.cz>
In-Reply-To: <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:51 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

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
> +		vma = vmg.vma = next;
>  		vmg.pgoff = next->vm_pgoff - pglen;
> -	}
>  
> -	if (vma) {
> +		/* We may merge our NULL anon_vma with non-NULL in next. */
>  		vmg.anon_vma = vma->anon_vma;
> -		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
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

See? One more use of "next" that has gone away in the end...

Petr T

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
>  }
> diff --git a/mm/vma.c b/mm/vma.c
> index b452b472a085..3d6ce04f1b9c 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -489,30 +489,25 @@ void validate_mm(struct mm_struct *mm)
>  /*
>   * vma_expand - Expand an existing VMA
>   *
> - * @vmi: The vma iterator
> - * @vma: The vma to expand
> - * @start: The start of the vma
> - * @end: The exclusive end of the vma
> - * @pgoff: The page offset of vma
> - * @next: The current of next vma.
> + * @vmg: Describes a VMA expansion operation.
>   *
> - * Expand @vma to @start and @end.  Can expand off the start and end.  Will
> - * expand over @next if it's different from @vma and @end == @next->vm_end.
> - * Checking if the @vma can expand and merge with @next needs to be handled by
> - * the caller.
> + * Expand @vma to vmg->start and vmg->end.  Can expand off the start and end.
> + * Will expand over vmg->next if it's different from vmg->vma and vmg->end ==
> + * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
> + * vmg->next needs to be handled by the caller.
>   *
>   * Returns: 0 on success
>   */
> -int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff,
> -	       struct vm_area_struct *next)
> +int vma_expand(struct vma_merge_struct *vmg)
>  {
>  	struct vm_area_struct *anon_dup = NULL;
>  	bool remove_next = false;
> +	struct vm_area_struct *vma = vmg->vma;
> +	struct vm_area_struct *next = vmg->next;
>  	struct vma_prepare vp;
>  
>  	vma_start_write(vma);
> -	if (next && (vma != next) && (end == next->vm_end)) {
> +	if (next && (vma != next) && (vmg->end == next->vm_end)) {
>  		int ret;
>  
>  		remove_next = true;
> @@ -525,21 +520,21 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
>  	/* Not merging but overwriting any part of next is not handled. */
>  	VM_WARN_ON(next && !vp.remove &&
> -		  next != vma && end > next->vm_start);
> +		  next != vma && vmg->end > next->vm_start);
>  	/* Only handles expanding */
> -	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
> +	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
>  
>  	/* Note: vma iterator must be pointing to 'start' */
> -	vma_iter_config(vmi, start, end);
> -	if (vma_iter_prealloc(vmi, vma))
> +	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> +	if (vma_iter_prealloc(vmg->vmi, vma))
>  		goto nomem;
>  
>  	vma_prepare(&vp);
> -	vma_adjust_trans_huge(vma, start, end, 0);
> -	vma_set_range(vma, start, end, pgoff);
> -	vma_iter_store(vmi, vma);
> +	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
> +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> +	vma_iter_store(vmg->vmi, vma);
>  
> -	vma_complete(&vp, vmi, vma->vm_mm);
> +	vma_complete(&vp, vmg->vmi, vma->vm_mm);
>  	return 0;
>  
>  nomem:
> @@ -550,37 +545,34 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  /*
>   * vma_shrink() - Reduce an existing VMAs memory area
> - * @vmi: The vma iterator
> - * @vma: The VMA to modify
> - * @start: The new start
> - * @end: The new end
> + * @vmg: Describes a VMA shrink operation.
>   *
>   * Returns: 0 on success, -ENOMEM otherwise
>   */
> -int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff)
> +int vma_shrink(struct vma_merge_struct *vmg)
>  {
> +	struct vm_area_struct *vma = vmg->vma;
>  	struct vma_prepare vp;
>  
> -	WARN_ON((vma->vm_start != start) && (vma->vm_end != end));
> +	WARN_ON((vma->vm_start != vmg->start) && (vma->vm_end != vmg->end));
>  
> -	if (vma->vm_start < start)
> -		vma_iter_config(vmi, vma->vm_start, start);
> +	if (vma->vm_start < vmg->start)
> +		vma_iter_config(vmg->vmi, vma->vm_start, vmg->start);
>  	else
> -		vma_iter_config(vmi, end, vma->vm_end);
> +		vma_iter_config(vmg->vmi, vmg->end, vma->vm_end);
>  
> -	if (vma_iter_prealloc(vmi, NULL))
> +	if (vma_iter_prealloc(vmg->vmi, NULL))
>  		return -ENOMEM;
>  
>  	vma_start_write(vma);
>  
>  	init_vma_prep(&vp, vma);
>  	vma_prepare(&vp);
> -	vma_adjust_trans_huge(vma, start, end, 0);
> +	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
>  
> -	vma_iter_clear(vmi);
> -	vma_set_range(vma, start, end, pgoff);
> -	vma_complete(&vp, vmi, vma->vm_mm);
> +	vma_iter_clear(vmg->vmi);
> +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> +	vma_complete(&vp, vmg->vmi, vma->vm_mm);
>  	return 0;
>  }
>  
> diff --git a/mm/vma.h b/mm/vma.h
> index c31684cc1da6..c464d25da120 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -66,12 +66,8 @@ void init_vma_prep(struct vma_prepare *vp,
>  void vma_complete(struct vma_prepare *vp,
>  		  struct vma_iterator *vmi, struct mm_struct *mm);
>  
> -int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff,
> -	       struct vm_area_struct *next);
> -
> -int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff);
> +int vma_expand(struct vma_merge_struct *vmg);
> +int vma_shrink(struct vma_merge_struct *vmg);
>  
>  int
>  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 48e033c60d87..d216e51206c1 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -142,10 +142,17 @@ static bool test_simple_expand(void)
>  	struct mm_struct mm = {};
>  	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
>  	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.vma = vma,
> +		.start = 0,
> +		.end = 0x3000,
> +		.pgoff = 0,
> +	};
>  
>  	ASSERT_FALSE(vma_link(&mm, vma));
>  
> -	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
> +	ASSERT_FALSE(vma_expand(&vmg));
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x3000);
> @@ -163,10 +170,17 @@ static bool test_simple_shrink(void)
>  	struct mm_struct mm = {};
>  	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
>  	VMA_ITERATOR(vmi, &mm, 0);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.vma = vma,
> +		.start = 0,
> +		.end = 0x1000,
> +		.pgoff = 0,
> +	};
>  
>  	ASSERT_FALSE(vma_link(&mm, vma));
>  
> -	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
> +	ASSERT_FALSE(vma_shrink(&vmg));
>  
>  	ASSERT_EQ(vma->vm_start, 0);
>  	ASSERT_EQ(vma->vm_end, 0x1000);

