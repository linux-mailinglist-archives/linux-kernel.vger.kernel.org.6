Return-Path: <linux-kernel+bounces-276195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E8948FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2111F22F20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF561C461D;
	Tue,  6 Aug 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="NdivBKuf"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9D1BF32A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949069; cv=none; b=Ut29joUr3NYkyzceIDH/bXhADt5SB9qRkO7KdqX3z/VZd0w+tFMH/d2r15ZX7V2KCZOVL5qfC0uVzqH0cMCekNMxwtWi6BzqZyXCAScuAyY2HbSnExRH+XZePwBFTrGjuW3TXQqJP+ATEOdQQkEQcwBvW1BmM1rjNlONXqIy8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949069; c=relaxed/simple;
	bh=7WVS1PsIGATj9NKYLpZc6EDjDDT+q62HeO576YB1ccc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOgBO02IEFoKZW7ogVv6rpBzJc8f4lHT2HzXPWd9vCEXKfVdnGeG4YdQTnqmn7CsJbUA+t6GSU0LJqrJTcnrQddbvG+BkWw1YxeaD2rhiy6o+hGxQ3SKQrwspBfouws6uKNmh3mCc5D7LhjvVorT/oI3HkMW1vMJBY3IRSgIycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=NdivBKuf; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [213.235.133.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 328221D0722;
	Tue,  6 Aug 2024 14:48:02 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722948482; bh=qm7Vtt2gxeg3e420x4xjBt0KIlJtRvV07tLamTfvpbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NdivBKufs9qb0DieryC2aGyU2KL9BxWuRzy7iXqhMfeGs6LhOjbZR8fkP1F95uw+W
	 zYWPujNSecOvGkoio0nbXwx2ld9qUfZEMzJxXGSafHbCPaqqAvEdtK6J/PLaokzyD/
	 8nGnWeRqAdILQotgS0ZLmLkkLcecHLpE40aYrkst19tTptNd5yIzndMl589kcROl6t
	 D/IYuxQqa4iLL9ygoSNbEEXK/XnfZeTqkBemIP2JenyzwXCpxd1rLVCH/dXIYEyzGd
	 SERM74Vzx61/GMdvIRVTOoTCpF1bY0NcNafqctC5LXVJP1TabHoUu9JSclQcIhNxrz
	 BoDlUlPQQbNTg==
Date: Tue, 6 Aug 2024 14:47:54 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <20240806144754.447001bc@mordecai.tesarici.cz>
In-Reply-To: <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Lorenzo!

On Mon,  5 Aug 2024 13:13:49 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Rather than passing around huge numbers of parameters to numerous helper
> functions, abstract them into a single struct that we thread through the
> operation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c |  76 ++++++++------
>  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------------
>  mm/vma.h  |  92 ++++++++---------
>  3 files changed, 294 insertions(+), 171 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4a9c2329b09a..f931000c561f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long end = addr + len;
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
> -	pgoff_t vm_pgoff;
>  	int error;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.start = addr,
> +		.end = end,
> +		.flags = vm_flags,
> +		.pgoff = pgoff,
> +		.file = file,
> +	};
>  
>  	/* Check against address space limit. */
>  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	next = vma_next(&vmi);
> -	prev = vma_prev(&vmi);
> +	next = vmg.next = vma_next(&vmi);
> +	prev = vmg.prev = vma_prev(&vmi);

So, next is now a shortcut for vmg.next, and prev is a shortcut for
vmg.prev. ATM there is only one assignment, so no big deal, but I
wonder if next and prev could be removed instead, same as you replaced
vm_pgoff with vmg.pgoff.

Is the resulting code _too_ ugly?

>  	if (vm_flags & VM_SPECIAL) {
>  		if (prev)
>  			vma_iter_next_range(&vmi);
> @@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
>  	if (next && next->vm_start == end && !vma_policy(next) &&
> -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> -				 NULL_VM_UFFD_CTX, NULL)) {
> +	    can_vma_merge_before(&vmg)) {
>  		merge_end = next->vm_end;
>  		vma = next;
> -		vm_pgoff = next->vm_pgoff - pglen;
> +		vmg.pgoff = next->vm_pgoff - pglen;
> +	}
> +
> +	if (vma) {
> +		vmg.anon_vma = vma->anon_vma;
> +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
>  	}
>  
>  	/* Check prev */
>  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> -				       NULL_VM_UFFD_CTX, NULL))) {
> +	    can_vma_merge_after(&vmg)) {
>  		merge_start = prev->vm_start;
>  		vma = prev;
> -		vm_pgoff = prev->vm_pgoff;
> +		vmg.pgoff = prev->vm_pgoff;
>  	} else if (prev) {
>  		vma_iter_next_range(&vmi);
>  	}
>  
>  	/* Actually expand, if possible */
>  	if (vma &&
> -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> +	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
>  		khugepaged_enter_vma(vma, vm_flags);
>  		goto expanded;
>  	}
> @@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Expand the existing vma if possible; Note that singular lists do not
>  	 * occur after forking, so the expand will only happen on new VMAs.
>  	 */
> -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> -	    can_vma_merge_after(vma, flags, NULL, NULL,
> -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> -		vma_iter_config(vmi, vma->vm_start, addr + len);
> -		if (vma_iter_prealloc(vmi, vma))
> -			goto unacct_fail;
> -
> -		vma_start_write(vma);
> -
> -		init_vma_prep(&vp, vma);
> -		vma_prepare(&vp);
> -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -		vma->vm_end = addr + len;
> -		vm_flags_set(vma, VM_SOFTDIRTY);
> -		vma_iter_store(vmi, vma);
> -
> -		vma_complete(&vp, vmi, mm);
> -		khugepaged_enter_vma(vma, flags);
> -		goto out;
> +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> +		struct vma_merge_struct vmg = {
> +			.prev = vma,
> +			.flags = flags,
> +			.pgoff = addr >> PAGE_SHIFT,
> +		};
> +
> +		if (can_vma_merge_after(&vmg)) {
> +			vma_iter_config(vmi, vma->vm_start, addr + len);
> +			if (vma_iter_prealloc(vmi, vma))
> +				goto unacct_fail;
> +
> +			vma_start_write(vma);
> +
> +			init_vma_prep(&vp, vma);
> +			vma_prepare(&vp);
> +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> +			vma->vm_end = addr + len;
> +			vm_flags_set(vma, VM_SOFTDIRTY);
> +			vma_iter_store(vmi, vma);
> +
> +			vma_complete(&vp, vmi, mm);
> +			khugepaged_enter_vma(vma, flags);
> +			goto out;
> +		}
>  	}
>  
>  	if (vma)
> diff --git a/mm/vma.c b/mm/vma.c
> index bf0546fe6eab..20c4ce7712c0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,16 +7,18 @@
>  #include "vma_internal.h"
>  #include "vma.h"
>  
> -/*
> - * If the vma has a ->close operation then the driver probably needs to release
> - * per-vma resources, so we don't attempt to merge those if the caller indicates
> - * the current vma may be removed as part of the merge.
> - */
> -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> -		struct file *file, unsigned long vm_flags,
> -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name, bool may_remove_vma)
> +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
>  {
> +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> +	/*
> +	 * If the vma has a ->close operation then the driver probably needs to
> +	 * release per-vma resources, so we don't attempt to merge those if the
> +	 * caller indicates the current vma may be removed as part of the merge,
> +	 * which is the case if we are attempting to merge the next VMA into
> +	 * this one.
> +	 */
> +	bool may_remove_vma = merge_next;
> +

This variable is used only once. If you want to clarify the double
meaning of the merge_next parameter, consider moving this comment
further down to the conditional and merely renaming the parameter.

>  	/*
>  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
>  	 * match the flags but dirty bit -- the caller should mark
> @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
>  	 * the kernel to generate new VMAs when old one could be
>  	 * extended instead.
>  	 */
> -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
>  		return false;
> -	if (vma->vm_file != file)
> +	if (vma->vm_file != vmg->file)
>  		return false;
>  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)

AFAICS this is the only place where may_remove_vma is used.

>  		return false;
> -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
>  		return false;
> -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
>  		return false;
>  	return true;
>  }
> @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
>   * We assume the vma may be removed as part of the merge.
>   */
>  bool
> -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +can_vma_merge_before(struct vma_merge_struct *vmg)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> -		if (vma->vm_pgoff == vm_pgoff)
> +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> +
> +	if (is_mergeable_vma(vmg, true) &&
> +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
>  			return true;
>  	}
> +
>  	return false;
>  }
>  
> @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
>   *
>   * We assume that vma is not removed as part of the merge.
>   */
> -bool
> -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> -		pgoff_t vm_pglen;
> -
> -		vm_pglen = vma_pages(vma);
> -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> +	if (is_mergeable_vma(vmg, false) &&
> +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
>  			return true;
>  	}
>  	return false;
> @@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>   * VMA Iterator will point to the end VMA.
>   */
>  static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		       unsigned long addr, int new_below)
> +		       unsigned long addr, bool new_below)
>  {
>  	struct vma_prepare vp;
>  	struct vm_area_struct *new;
> @@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   * Split a vma into two pieces at address 'addr', a new vma is allocated
>   * either for the first part or the tail.
>   */
> -static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		     unsigned long addr, int new_below)
> +static int split_vma(struct vma_merge_struct *vmg, bool new_below)

IMHO this patch is already long enough. Maybe the type change from int
to bool could be split out to a separate patch to reduce churn here?

>  {
> -	if (vma->vm_mm->map_count >= sysctl_max_map_count)
> +	if (vmg->vma->vm_mm->map_count >= sysctl_max_map_count)
>  		return -ENOMEM;
>  
> -	return __split_vma(vmi, vma, addr, new_below);
> +	return __split_vma(vmg->vmi, vmg->vma,
> +			   new_below ? vmg->start : vmg->end,
> +			   new_below);
>  }
>  
>  /*
> @@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>  
> -		error = __split_vma(vmi, vma, start, 1);
> +		error = __split_vma(vmi, vma, start, true);
>  		if (error)
>  			goto start_split_failed;
>  	}
> @@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	do {
>  		/* Does it split the end? */
>  		if (next->vm_end > end) {
> -			error = __split_vma(vmi, next, end, 0);
> +			error = __split_vma(vmi, next, end, false);
>  			if (error)
>  				goto end_split_failed;
>  		}
> @@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>   * **** is not represented - it will be merged and the vma containing the
>   *      area is returned, or the function will return NULL
>   */
> -static struct vm_area_struct
> -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -	   struct anon_vma_name *anon_name)
> +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  {
> -	struct mm_struct *mm = src->vm_mm;
> -	struct anon_vma *anon_vma = src->anon_vma;
> -	struct file *file = src->vm_file;
> +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
> +	struct vm_area_struct *prev = vmg->prev;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
> @@ -953,16 +943,18 @@ static struct vm_area_struct
>  	bool merge_prev = false;
>  	bool merge_next = false;
>  	bool vma_expanded = false;
> +	unsigned long addr = vmg->start;
> +	unsigned long end = vmg->end;
>  	unsigned long vma_start = addr;
>  	unsigned long vma_end = end;
> -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> +	pgoff_t pglen = PHYS_PFN(end - addr);
>  	long adj_start = 0;
>  
>  	/*
>  	 * We later require that vma->vm_flags == vm_flags,
>  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
>  	 */
> -	if (vm_flags & VM_SPECIAL)
> +	if (vmg->flags & VM_SPECIAL)
>  		return NULL;
>  
>  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> @@ -970,27 +962,26 @@ static struct vm_area_struct
>  
>  	if (!curr ||			/* cases 1 - 4 */
>  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> -		next = vma_lookup(mm, end);
> +		next = vmg->next = vma_lookup(mm, end);
>  	else
> -		next = NULL;		/* case 5 */
> +		next = vmg->next = NULL;	/* case 5 */

Again, is it worth keeping the "next" variable, or could we replace it
with "vmg->next" everywhere?

No other comments to the rest of this patch.

Petr T

>  
>  	if (prev) {
>  		vma_start = prev->vm_start;
>  		vma_pgoff = prev->vm_pgoff;
>  
>  		/* Can we merge the predecessor? */
> -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> -					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> +		    && can_vma_merge_after(vmg)) {
> +
>  			merge_prev = true;
> -			vma_prev(vmi);
> +			vma_prev(vmg->vmi);
>  		}
>  	}
>  
>  	/* Can we merge the successor? */
> -	if (next && mpol_equal(policy, vma_policy(next)) &&
> -	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
> -				 vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> +	    can_vma_merge_before(vmg)) {
>  		merge_next = true;
>  	}
>  
> @@ -1041,7 +1032,7 @@ static struct vm_area_struct
>  				remove = curr;
>  			} else {			/* case 5 */
>  				adjust = curr;
> -				adj_start = (end - curr->vm_start);
> +				adj_start = end - curr->vm_start;
>  			}
>  			if (!err)
>  				err = dup_anon_vma(prev, curr, &anon_dup);
> @@ -1081,13 +1072,13 @@ static struct vm_area_struct
>  		vma_expanded = true;
>  
>  	if (vma_expanded) {
> -		vma_iter_config(vmi, vma_start, vma_end);
> +		vma_iter_config(vmg->vmi, vma_start, vma_end);
>  	} else {
> -		vma_iter_config(vmi, adjust->vm_start + adj_start,
> +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
>  				adjust->vm_end);
>  	}
>  
> -	if (vma_iter_prealloc(vmi, vma))
> +	if (vma_iter_prealloc(vmg->vmi, vma))
>  		goto prealloc_fail;
>  
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> @@ -1099,19 +1090,19 @@ static struct vm_area_struct
>  	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
>  
>  	if (vma_expanded)
> -		vma_iter_store(vmi, vma);
> +		vma_iter_store(vmg->vmi, vma);
>  
>  	if (adj_start) {
>  		adjust->vm_start += adj_start;
>  		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
>  		if (adj_start < 0) {
>  			WARN_ON(vma_expanded);
> -			vma_iter_store(vmi, next);
> +			vma_iter_store(vmg->vmi, next);
>  		}
>  	}
>  
> -	vma_complete(&vp, vmi, mm);
> -	khugepaged_enter_vma(res, vm_flags);
> +	vma_complete(&vp, vmg->vmi, mm);
> +	khugepaged_enter_vma(res, vmg->flags);
>  	return res;
>  
>  prealloc_fail:
> @@ -1119,8 +1110,8 @@ static struct vm_area_struct
>  		unlink_anon_vmas(anon_dup);
>  
>  anon_vma_fail:
> -	vma_iter_set(vmi, addr);
> -	vma_iter_load(vmi);
> +	vma_iter_set(vmg->vmi, addr);
> +	vma_iter_load(vmg->vmi);
>  	return NULL;
>  }
>  
> @@ -1137,38 +1128,141 @@ static struct vm_area_struct
>   * The function returns either the merged VMA, the original VMA if a split was
>   * required instead, or an error if the split failed.
>   */
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name)
> +static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> +	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *merged;
>  
> -	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> -			   pgoff, policy, uffd_ctx, anon_name);
> +	/* First, try to merge. */
> +	merged = vma_merge(vmg);
>  	if (merged)
>  		return merged;
>  
> -	if (vma->vm_start < start) {
> -		int err = split_vma(vmi, vma, start, 1);
> +	/* Split any preceding portion of the VMA. */
> +	if (vma->vm_start < vmg->start) {
> +		int err = split_vma(vmg, true);
>  
>  		if (err)
>  			return ERR_PTR(err);
>  	}
>  
> -	if (vma->vm_end > end) {
> -		int err = split_vma(vmi, vma, end, 0);
> +	/* Split any trailing portion of the VMA. */
> +	if (vma->vm_end > vmg->end) {
> +		int err = split_vma(vmg, false);
>  
>  		if (err)
>  			return ERR_PTR(err);
>  	}
>  
> -	return vma;
> +	return vmg->vma;
> +}
> +
> +/* Assumes addr >= vma->vm_start. */
> +static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> +}
> +
> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_name(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       unsigned long new_flags,
> +		       struct anon_vma_name *new_name)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = new_name,
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_policy(struct vma_iterator *vmi,
> +		   struct vm_area_struct *prev,
> +		   struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   struct mempolicy *new_pol)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = vma->vm_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = new_pol,
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end,
> +		       unsigned long new_flags,
> +		       struct vm_userfaultfd_ctx new_ctx)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = new_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
>  }
>  
>  /*
> @@ -1180,8 +1274,22 @@ struct vm_area_struct
>  		   struct vm_area_struct *vma, unsigned long start,
>  		   unsigned long end, pgoff_t pgoff)
>  {
> -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = vma->vm_flags,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.pgoff = pgoff,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_merge(&vmg);
>  }
>  
>  /*
> @@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					unsigned long delta)
>  {
>  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = vma,
> +		.vma = vma,
> +		.start = vma->vm_end,
> +		.end = vma->vm_end + delta,
> +		.flags = vma->vm_flags,
> +		.file = vma->vm_file,
> +		.pgoff = pgoff,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
>  
>  	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> -			 vma->vm_flags, pgoff, vma_policy(vma),
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	return vma_merge(&vmg);
>  }
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> diff --git a/mm/vma.h b/mm/vma.h
> index 6efdf1768a0a..c31684cc1da6 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -26,6 +26,23 @@ struct unlink_vma_file_batch {
>  	struct vm_area_struct *vmas[8];
>  };
>  
> +/* Represents a VMA merge operation. */
> +struct vma_merge_struct {
> +	struct vma_iterator *vmi;
> +	struct vm_area_struct *prev;
> +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> +	unsigned long start;
> +	unsigned long end;
> +	unsigned long flags;
> +	pgoff_t pgoff;
> +	struct file *file;
> +	struct anon_vma *anon_vma;
> +	struct mempolicy *policy;
> +	struct vm_userfaultfd_ctx uffd_ctx;
> +	struct anon_vma_name *anon_name;
> +};
> +
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
>  void validate_mm(struct mm_struct *mm);
>  #else
> @@ -72,80 +89,53 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  		struct vm_area_struct *next, unsigned long start,
>  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
>  
> -/* Required by mmap_region(). */
> -bool
> -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name);
> -
> -/* Required by mmap_region() and do_brk_flags(). */
> -bool
> -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name);
> -
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name);
> +/*
> + * Can we merge the VMA described by vmg into the following VMA vmg->next?
> + *
> + * Required by mmap_region().
> + */
> +bool can_vma_merge_before(struct vma_merge_struct *vmg);
> +
> +/*
> + * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> + *
> + * Required by mmap_region() and do_brk_flags().
> + */
> +bool can_vma_merge_after(struct vma_merge_struct *vmg);
>  
>  /* We are about to modify the VMA's flags. */
> -static inline struct vm_area_struct
> -*vma_modify_flags(struct vma_iterator *vmi,
> -		  struct vm_area_struct *prev,
> -		  struct vm_area_struct *vma,
> -		  unsigned long start, unsigned long end,
> -		  unsigned long new_flags)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> -			  anon_vma_name(vma));
> -}
> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags);
>  
>  /* We are about to modify the VMA's flags and/or anon_name. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_flags_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start,
>  		       unsigned long end,
>  		       unsigned long new_flags,
> -		       struct anon_vma_name *new_name)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> -}
> +		       struct anon_vma_name *new_name);
>  
>  /* We are about to modify the VMA's memory policy. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_policy(struct vma_iterator *vmi,
>  		   struct vm_area_struct *prev,
>  		   struct vm_area_struct *vma,
>  		   unsigned long start, unsigned long end,
> -		   struct mempolicy *new_pol)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -}
> +		   struct mempolicy *new_pol);
>  
>  /* We are about to modify the VMA's flags and/or uffd context. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_flags_uffd(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start, unsigned long end,
>  		       unsigned long new_flags,
> -		       struct vm_userfaultfd_ctx new_ctx)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> -}
> +		       struct vm_userfaultfd_ctx new_ctx);
>  
>  struct vm_area_struct
>  *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,


