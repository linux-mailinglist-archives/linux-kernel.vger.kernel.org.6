Return-Path: <linux-kernel+bounces-276206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F270948FFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09885281DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C831C9EB3;
	Tue,  6 Aug 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="rcVCH79T"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1F1C579A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949473; cv=none; b=qzlehrdwCHrMGESlaryaNmRMs+Xa0LX7TtAYzFgzH0sFMPAWhP1T9Ggtrpiy34b3Zja9s9iOr9aZLYS+9BzWiEz7W9q+BikN0y9KlheqopawnbEwj3VtracdRMAojM4BdTk2JcsOGWm01qbEYPokKgUpnv/6R6yTgy8j1geHltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949473; c=relaxed/simple;
	bh=pZTV7VqO5Uckm6GDDms1hdmx8Gssk8q8xygAnf9R8pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/rx8olk1gx3RhQwm18HqvOxr++ZoLWcLNcTDVgglJvudoz8cKPyLxnDafWc/OK8hc3dKoq0/wPzB6Tj+9P6lumFPHoTgQyYlvSZlXVSb1x8vusUB8ZWqPuYZUM/jqe+gOPHaKUJSd7G7sE4ud9NH1iU+7+uc15pdNx7iu08TxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=rcVCH79T; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [213.235.133.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id CF2AC1D1FC5;
	Tue,  6 Aug 2024 15:04:28 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722949469; bh=1Oboi0+fbtzKASyq6ID1JoRmhP53ZKAHQsrtHiM5nKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rcVCH79TpT6VNo8p1gG3jBs3dO/+vBpOtvHkXFEYzH1MfFnqjKNUOR1ufK49efYtr
	 j5kn5DENm+JE7CIfuFziRYFEgieA3QHmJj/hpgpf/74w/NXa4vAI7TWo9cQDdDykqN
	 IqjqEG1VPcqed4H9ktJNGNFvEo/Z/4E+GL5yGouHwQvw8gHUIh3wLrooa1M7cf6oB0
	 YpYZKMn/RqD+1LryNMI0tuzjt72MyC3D0SMUEOxx1T1bfk8s8tzj6YrVoihumTOS0U
	 eBKD9+fuBf5kp5w/jkWwtCuZhfS+oE0SJmXDynV4pE2aSf4vkenCOAReYzX1Ul/vk3
	 EumGf6T7K8w3g==
Date: Tue, 6 Aug 2024 15:04:22 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <20240806150422.2aa2354e@mordecai.tesarici.cz>
In-Reply-To: <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Aug 2024 13:13:54 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> In mmap_region() and do_brk_flags() we open code scenarios where we prefer
> to use vma_expand() rather than invoke a full vma_merge() operation.
> 
> Abstract this logic and eliminate all of the open-coding, and also use the
> same logic for all cases where we add new VMAs to, rather than ultimately
> use vma_merge(), rather use vma_expand().
> 
> We implement this by replacing vma_merge_new_vma() with this newly
> abstracted logic.
> 
> Doing so removes duplication and simplifies VMA merging in all such cases,
> laying the ground for us to eliminate the merging of new VMAs in
> vma_merge() altogether.
> 
> This makes it far easier to understand what is happening in these cases
> avoiding confusion, bugs and allowing for future optimisation.
> 
> As a result of this change we are also able to make vma_prepare(),
> init_vma_prep(), vma_complete(), can_vma_merge_before() and
> can_vma_merge_after() static and internal to vma.c.

This patch truly rocks. Let me just say: Wow!

Petr T

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c                        |  79 ++---
>  mm/vma.c                         | 482 +++++++++++++++++++------------
>  mm/vma.h                         |  51 +---
>  tools/testing/vma/vma_internal.h |   6 +
>  4 files changed, 324 insertions(+), 294 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f6593a81f73d..c03f50f46396 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1363,8 +1363,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
> -	struct vm_area_struct *next, *prev, *merge;
> -	pgoff_t pglen = len >> PAGE_SHIFT;
> +	struct vm_area_struct *merge;
>  	unsigned long charged = 0;
>  	unsigned long end = addr + len;
>  	bool writable_file_mapping = false;
> @@ -1411,44 +1410,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	next = vmg.next = vma_next(&vmi);
> -	prev = vmg.prev = vma_prev(&vmi);
> -	if (vm_flags & VM_SPECIAL) {
> -		if (prev)
> -			vma_iter_next_range(&vmi);
> -		goto cannot_expand;
> -	}
> -
> -	/* Attempt to expand an old mapping */
> -	/* Check next */
> -	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> -		/* We can adjust this as can_vma_merge_after() doesn't touch */
> -		vmg.end = next->vm_end;
> -		vma = vmg.vma = next;
> -		vmg.pgoff = next->vm_pgoff - pglen;
> -
> -		/* We may merge our NULL anon_vma with non-NULL in next. */
> -		vmg.anon_vma = vma->anon_vma;
> -	}
> -
> -	/* Check prev */
> -	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
> -		vmg.start = prev->vm_start;
> -		vma = vmg.vma = prev;
> -		vmg.pgoff = prev->vm_pgoff;
> -	} else if (prev) {
> -		vma_iter_next_range(&vmi);
> -	}
> -
> -	/* Actually expand, if possible */
> -	if (vma && !vma_expand(&vmg)) {
> -		khugepaged_enter_vma(vma, vm_flags);
> +	vma = vma_merge_new_vma(&vmg);
> +	if (vma)
>  		goto expanded;
> -	}
> -
> -	if (vma == prev)
> -		vma_iter_set(&vmi, addr);
> -cannot_expand:
>  
>  	/*
>  	 * Determine the object being mapped and call the appropriate
> @@ -1493,10 +1457,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * If vm_flags changed after call_mmap(), we should try merge
>  		 * vma again as we may succeed this time.
>  		 */
> -		if (unlikely(vm_flags != vma->vm_flags && prev)) {
> -			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
> -							  vma->vm_start, vma->vm_end,
> -							  vma->vm_pgoff);
> +		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> +			merge = vma_merge_new_vma(&vmg);
> +
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> @@ -1596,7 +1559,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  		vma_iter_set(&vmi, vma->vm_end);
>  		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
> +		unmap_region(mm, &vmi.mas, vma, vmg.prev, vmg.next, vma->vm_start,
>  			     vma->vm_end, vma->vm_end, true);
>  	}
>  	if (writable_file_mapping)
> @@ -1773,7 +1736,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		unsigned long addr, unsigned long len, unsigned long flags)
>  {
>  	struct mm_struct *mm = current->mm;
> -	struct vma_prepare vp;
>  
>  	/*
>  	 * Check against address space limits by the changed size
> @@ -1795,29 +1757,22 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 */
>  	if (vma && vma->vm_end == addr) {
>  		struct vma_merge_struct vmg = {
> +			.vmi = vmi,
>  			.prev = vma,
> +			.next = NULL,
> +			.start = addr,
> +			.end = addr + len,
>  			.flags = flags,
>  			.pgoff = addr >> PAGE_SHIFT,
> +			.file = vma->vm_file,
> +			.anon_vma = vma->anon_vma,
> +			.policy = vma_policy(vma),
> +			.uffd_ctx = vma->vm_userfaultfd_ctx,
> +			.anon_name = anon_vma_name(vma),
>  		};
>  
> -		if (can_vma_merge_after(&vmg)) {
> -			vma_iter_config(vmi, vma->vm_start, addr + len);
> -			if (vma_iter_prealloc(vmi, vma))
> -				goto unacct_fail;
> -
> -			vma_start_write(vma);
> -
> -			init_vma_prep(&vp, vma);
> -			vma_prepare(&vp);
> -			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -			vma->vm_end = addr + len;
> -			vm_flags_set(vma, VM_SOFTDIRTY);
> -			vma_iter_store(vmi, vma);
> -
> -			vma_complete(&vp, vmi, mm);
> -			khugepaged_enter_vma(vma, flags);
> +		if (vma_merge_new_vma(&vmg))
>  			goto out;
> -		}
>  	}
>  
>  	if (vma)
> diff --git a/mm/vma.c b/mm/vma.c
> index 55615392e8d2..a404cf718f9e 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -97,8 +97,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
>   *
>   * We assume the vma may be removed as part of the merge.
>   */
> -bool
> -can_vma_merge_before(struct vma_merge_struct *vmg)
> +static bool can_vma_merge_before(struct vma_merge_struct *vmg)
>  {
>  	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
>  
> @@ -120,7 +119,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
>   *
>   * We assume that vma is not removed as part of the merge.
>   */
> -bool can_vma_merge_after(struct vma_merge_struct *vmg)
> +static bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  {
>  	if (is_mergeable_vma(vmg, false) &&
>  	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> @@ -130,6 +129,164 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  	return false;
>  }
>  
> +static void __vma_link_file(struct vm_area_struct *vma,
> +			    struct address_space *mapping)
> +{
> +	if (vma_is_shared_maywrite(vma))
> +		mapping_allow_writable(mapping);
> +
> +	flush_dcache_mmap_lock(mapping);
> +	vma_interval_tree_insert(vma, &mapping->i_mmap);
> +	flush_dcache_mmap_unlock(mapping);
> +}
> +
> +/*
> + * Requires inode->i_mapping->i_mmap_rwsem
> + */
> +static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> +				      struct address_space *mapping)
> +{
> +	if (vma_is_shared_maywrite(vma))
> +		mapping_unmap_writable(mapping);
> +
> +	flush_dcache_mmap_lock(mapping);
> +	vma_interval_tree_remove(vma, &mapping->i_mmap);
> +	flush_dcache_mmap_unlock(mapping);
> +}
> +
> +/*
> + * vma_prepare() - Helper function for handling locking VMAs prior to altering
> + * @vp: The initialized vma_prepare struct
> + */
> +static void vma_prepare(struct vma_prepare *vp)
> +{
> +	if (vp->file) {
> +		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> +
> +		if (vp->adj_next)
> +			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> +				      vp->adj_next->vm_end);
> +
> +		i_mmap_lock_write(vp->mapping);
> +		if (vp->insert && vp->insert->vm_file) {
> +			/*
> +			 * Put into interval tree now, so instantiated pages
> +			 * are visible to arm/parisc __flush_dcache_page
> +			 * throughout; but we cannot insert into address
> +			 * space until vma start or end is updated.
> +			 */
> +			__vma_link_file(vp->insert,
> +					vp->insert->vm_file->f_mapping);
> +		}
> +	}
> +
> +	if (vp->anon_vma) {
> +		anon_vma_lock_write(vp->anon_vma);
> +		anon_vma_interval_tree_pre_update_vma(vp->vma);
> +		if (vp->adj_next)
> +			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> +	}
> +
> +	if (vp->file) {
> +		flush_dcache_mmap_lock(vp->mapping);
> +		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> +		if (vp->adj_next)
> +			vma_interval_tree_remove(vp->adj_next,
> +						 &vp->mapping->i_mmap);
> +	}
> +
> +}
> +
> +/*
> + * vma_complete- Helper function for handling the unlocking after altering VMAs,
> + * or for inserting a VMA.
> + *
> + * @vp: The vma_prepare struct
> + * @vmi: The vma iterator
> + * @mm: The mm_struct
> + */
> +static void vma_complete(struct vma_prepare *vp,
> +			 struct vma_iterator *vmi, struct mm_struct *mm)
> +{
> +	if (vp->file) {
> +		if (vp->adj_next)
> +			vma_interval_tree_insert(vp->adj_next,
> +						 &vp->mapping->i_mmap);
> +		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> +		flush_dcache_mmap_unlock(vp->mapping);
> +	}
> +
> +	if (vp->remove && vp->file) {
> +		__remove_shared_vm_struct(vp->remove, vp->mapping);
> +		if (vp->remove2)
> +			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> +	} else if (vp->insert) {
> +		/*
> +		 * split_vma has split insert from vma, and needs
> +		 * us to insert it before dropping the locks
> +		 * (it may either follow vma or precede it).
> +		 */
> +		vma_iter_store(vmi, vp->insert);
> +		mm->map_count++;
> +	}
> +
> +	if (vp->anon_vma) {
> +		anon_vma_interval_tree_post_update_vma(vp->vma);
> +		if (vp->adj_next)
> +			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> +		anon_vma_unlock_write(vp->anon_vma);
> +	}
> +
> +	if (vp->file) {
> +		i_mmap_unlock_write(vp->mapping);
> +		uprobe_mmap(vp->vma);
> +
> +		if (vp->adj_next)
> +			uprobe_mmap(vp->adj_next);
> +	}
> +
> +	if (vp->remove) {
> +again:
> +		vma_mark_detached(vp->remove, true);
> +		if (vp->file) {
> +			uprobe_munmap(vp->remove, vp->remove->vm_start,
> +				      vp->remove->vm_end);
> +			fput(vp->file);
> +		}
> +		if (vp->remove->anon_vma)
> +			anon_vma_merge(vp->vma, vp->remove);
> +		mm->map_count--;
> +		mpol_put(vma_policy(vp->remove));
> +		if (!vp->remove2)
> +			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> +		vm_area_free(vp->remove);
> +
> +		/*
> +		 * In mprotect's case 6 (see comments on vma_merge),
> +		 * we are removing both mid and next vmas
> +		 */
> +		if (vp->remove2) {
> +			vp->remove = vp->remove2;
> +			vp->remove2 = NULL;
> +			goto again;
> +		}
> +	}
> +	if (vp->insert && vp->file)
> +		uprobe_mmap(vp->insert);
> +	validate_mm(mm);
> +}
> +
> +/*
> + * init_vma_prep() - Initializer wrapper for vma_prepare struct
> + * @vp: The vma_prepare struct
> + * @vma: The vma that will be altered once locked
> + */
> +static void init_vma_prep(struct vma_prepare *vp,
> +			  struct vm_area_struct *vma)
> +{
> +	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> +}
> +
>  /*
>   * Close a vm structure and free it.
>   */
> @@ -292,31 +449,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
>  	vm_unacct_memory(nr_accounted);
>  }
>  
> -/*
> - * init_vma_prep() - Initializer wrapper for vma_prepare struct
> - * @vp: The vma_prepare struct
> - * @vma: The vma that will be altered once locked
> - */
> -void init_vma_prep(struct vma_prepare *vp,
> -		   struct vm_area_struct *vma)
> -{
> -	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> -}
> -
> -/*
> - * Requires inode->i_mapping->i_mmap_rwsem
> - */
> -static void __remove_shared_vm_struct(struct vm_area_struct *vma,
> -				      struct address_space *mapping)
> -{
> -	if (vma_is_shared_maywrite(vma))
> -		mapping_unmap_writable(mapping);
> -
> -	flush_dcache_mmap_lock(mapping);
> -	vma_interval_tree_remove(vma, &mapping->i_mmap);
> -	flush_dcache_mmap_unlock(mapping);
> -}
> -
>  /*
>   * vma has some anon_vma assigned, and is already inserted on that
>   * anon_vma's interval trees.
> @@ -349,60 +481,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
>  }
>  
> -static void __vma_link_file(struct vm_area_struct *vma,
> -			    struct address_space *mapping)
> -{
> -	if (vma_is_shared_maywrite(vma))
> -		mapping_allow_writable(mapping);
> -
> -	flush_dcache_mmap_lock(mapping);
> -	vma_interval_tree_insert(vma, &mapping->i_mmap);
> -	flush_dcache_mmap_unlock(mapping);
> -}
> -
> -/*
> - * vma_prepare() - Helper function for handling locking VMAs prior to altering
> - * @vp: The initialized vma_prepare struct
> - */
> -void vma_prepare(struct vma_prepare *vp)
> -{
> -	if (vp->file) {
> -		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
> -
> -		if (vp->adj_next)
> -			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
> -				      vp->adj_next->vm_end);
> -
> -		i_mmap_lock_write(vp->mapping);
> -		if (vp->insert && vp->insert->vm_file) {
> -			/*
> -			 * Put into interval tree now, so instantiated pages
> -			 * are visible to arm/parisc __flush_dcache_page
> -			 * throughout; but we cannot insert into address
> -			 * space until vma start or end is updated.
> -			 */
> -			__vma_link_file(vp->insert,
> -					vp->insert->vm_file->f_mapping);
> -		}
> -	}
> -
> -	if (vp->anon_vma) {
> -		anon_vma_lock_write(vp->anon_vma);
> -		anon_vma_interval_tree_pre_update_vma(vp->vma);
> -		if (vp->adj_next)
> -			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
> -	}
> -
> -	if (vp->file) {
> -		flush_dcache_mmap_lock(vp->mapping);
> -		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
> -		if (vp->adj_next)
> -			vma_interval_tree_remove(vp->adj_next,
> -						 &vp->mapping->i_mmap);
> -	}
> -
> -}
> -
>  /*
>   * dup_anon_vma() - Helper function to duplicate anon_vma
>   * @dst: The destination VMA
> @@ -486,6 +564,120 @@ void validate_mm(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
>  
> +/*
> + * vma_merge_new_vma - Attempt to merge a new VMA into address space
> + *
> + * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
> + *       (exclusive), which we try to merge with any adjacent VMAs if possible.
> + *
> + * We are about to add a VMA to the address space starting at @vmg->start and
> + * ending at @vmg->end. There are three different possible scenarios:
> + *
> + * 1. There is a VMA with identical properties immediately adjacent to the
> + *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
> + *    EXPAND that VMA:
> + *
> + * Proposed:       |-----|  or  |-----|
> + * Existing:  |----|                  |----|
> + *
> + * 2. There are VMAs with identical properties immediately adjacent to the
> + *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
> + *    EXPAND the former and REMOVE the latter:
> + *
> + * Proposed:       |-----|
> + * Existing:  |----|     |----|
> + *
> + * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
> + *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
> + *
> + * In instances where we can merge, this function returns the expanded VMA which
> + * will have its range adjusted accordingly and the underlying maple tree also
> + * adjusted.
> + *
> + * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
> + *          to the VMA we expanded.
> + *
> + * This function also adjusts @vmg to provide @vmg->prev and @vmg->next if
> + * neither already specified, and adjusts [@vmg->start, @vmg->end) to span the
> + * expanded range.
> + *
> + * ASSUMPTIONS:
> + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
> + * - The caller must have determined that [@vmg->start, @vmg->end) is empty.
> + */
> +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> +{
> +	bool is_special = vmg->flags & VM_SPECIAL;
> +	struct vm_area_struct *prev = vmg->prev;
> +	struct vm_area_struct *next = vmg->next;
> +	unsigned long start = vmg->start;
> +	unsigned long end = vmg->end;
> +	pgoff_t pgoff = vmg->pgoff;
> +	pgoff_t pglen = PHYS_PFN(end - start);
> +
> +	VM_WARN_ON(vmg->vma);
> +
> +	if (!prev && !next) {
> +		/*
> +		 * Since the caller must have determined that the requested
> +		 * range is empty, vmg->vmi will be left pointing at the VMA
> +		 * immediately prior.
> +		 */
> +		next = vmg->next = vma_next(vmg->vmi);
> +		prev = vmg->prev = vma_prev(vmg->vmi);
> +
> +		/* Avoid maple tree re-walk. */
> +		if (is_special && prev)
> +			vma_iter_next_range(vmg->vmi);
> +	}
> +
> +	/* If special mapping or no adjacent VMAs, nothing to merge. */
> +	if (is_special || (!prev && !next))
> +		return NULL;
> +
> +	/* If we can merge with the following VMA, adjust vmg accordingly. */
> +	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
> +		/*
> +		 * We can adjust this here as can_vma_merge_after() doesn't
> +		 * touch vmg->end.
> +		 */
> +		vmg->end = next->vm_end;
> +		vmg->vma = next;
> +		vmg->pgoff = next->vm_pgoff - pglen;
> +
> +		vmg->anon_vma = next->anon_vma;
> +	}
> +
> +	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> +	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> +		vmg->start = prev->vm_start;
> +		vmg->vma = prev;
> +		vmg->pgoff = prev->vm_pgoff;
> +	} else if (prev) {
> +		vma_iter_next_range(vmg->vmi);
> +	}
> +
> +	/*
> +	 * Now try to expand adjacent VMA(s). This takes care of removing the
> +	 * following VMA if we have VMAs on both sides.
> +	 */
> +	if (vmg->vma && !vma_expand(vmg)) {
> +		khugepaged_enter_vma(vmg->vma, vmg->flags);
> +		return vmg->vma;
> +	}
> +
> +	/* If expansion failed, reset state. Allows us to retry merge later. */
> +	vmg->vma = NULL;
> +	vmg->anon_vma = NULL;
> +	vmg->start = start;
> +	vmg->end = end;
> +	vmg->pgoff = pgoff;
> +	if (vmg->vma == prev)
> +		vma_iter_set(vmg->vmi, start);
> +
> +	return NULL;
> +}
> +
>  /*
>   * vma_expand - Expand an existing VMA
>   *
> @@ -496,7 +688,11 @@ void validate_mm(struct mm_struct *mm)
>   * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
>   * vmg->next needs to be handled by the caller.
>   *
> - * Returns: 0 on success
> + * Returns: 0 on success.
> + *
> + * ASSUMPTIONS:
> + * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
> + * - The caller must have set @vmg->prev and @vmg->next.
>   */
>  int vma_expand(struct vma_merge_struct *vmg)
>  {
> @@ -576,85 +772,6 @@ int vma_shrink(struct vma_merge_struct *vmg)
>  	return 0;
>  }
>  
> -/*
> - * vma_complete- Helper function for handling the unlocking after altering VMAs,
> - * or for inserting a VMA.
> - *
> - * @vp: The vma_prepare struct
> - * @vmi: The vma iterator
> - * @mm: The mm_struct
> - */
> -void vma_complete(struct vma_prepare *vp,
> -		  struct vma_iterator *vmi, struct mm_struct *mm)
> -{
> -	if (vp->file) {
> -		if (vp->adj_next)
> -			vma_interval_tree_insert(vp->adj_next,
> -						 &vp->mapping->i_mmap);
> -		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
> -		flush_dcache_mmap_unlock(vp->mapping);
> -	}
> -
> -	if (vp->remove && vp->file) {
> -		__remove_shared_vm_struct(vp->remove, vp->mapping);
> -		if (vp->remove2)
> -			__remove_shared_vm_struct(vp->remove2, vp->mapping);
> -	} else if (vp->insert) {
> -		/*
> -		 * split_vma has split insert from vma, and needs
> -		 * us to insert it before dropping the locks
> -		 * (it may either follow vma or precede it).
> -		 */
> -		vma_iter_store(vmi, vp->insert);
> -		mm->map_count++;
> -	}
> -
> -	if (vp->anon_vma) {
> -		anon_vma_interval_tree_post_update_vma(vp->vma);
> -		if (vp->adj_next)
> -			anon_vma_interval_tree_post_update_vma(vp->adj_next);
> -		anon_vma_unlock_write(vp->anon_vma);
> -	}
> -
> -	if (vp->file) {
> -		i_mmap_unlock_write(vp->mapping);
> -		uprobe_mmap(vp->vma);
> -
> -		if (vp->adj_next)
> -			uprobe_mmap(vp->adj_next);
> -	}
> -
> -	if (vp->remove) {
> -again:
> -		vma_mark_detached(vp->remove, true);
> -		if (vp->file) {
> -			uprobe_munmap(vp->remove, vp->remove->vm_start,
> -				      vp->remove->vm_end);
> -			fput(vp->file);
> -		}
> -		if (vp->remove->anon_vma)
> -			anon_vma_merge(vp->vma, vp->remove);
> -		mm->map_count--;
> -		mpol_put(vma_policy(vp->remove));
> -		if (!vp->remove2)
> -			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> -		vm_area_free(vp->remove);
> -
> -		/*
> -		 * In mprotect's case 6 (see comments on vma_merge),
> -		 * we are removing both mid and next vmas
> -		 */
> -		if (vp->remove2) {
> -			vp->remove = vp->remove2;
> -			vp->remove2 = NULL;
> -			goto again;
> -		}
> -	}
> -	if (vp->insert && vp->file)
> -		uprobe_mmap(vp->insert);
> -	validate_mm(mm);
> -}
> -
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
>   * @vmi: The vma iterator
> @@ -1261,20 +1378,6 @@ struct vm_area_struct
>  	return vma_modify(&vmg);
>  }
>  
> -/*
> - * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
> - * must ensure that [start, end) does not overlap any existing VMA.
> - */
> -struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> -{
> -	if (!vmg->prev) {
> -		vmg->prev = vma_prev(vmg->vmi);
> -		vma_iter_set(vmg->vmi, vmg->start);
> -	}
> -
> -	return vma_merge(vmg);
> -}
> -
>  /*
>   * Expand vma by delta bytes, potentially merging with an immediately adjacent
>   * VMA with identical properties.
> @@ -1297,8 +1400,7 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  		.anon_name = anon_vma_name(vma),
>  	};
>  
> -	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(&vmg);
> +	return vma_merge_new_vma(&vmg);
>  }
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> @@ -1399,24 +1501,40 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	struct vm_area_struct *vma = *vmap;
>  	unsigned long vma_start = vma->vm_start;
>  	struct mm_struct *mm = vma->vm_mm;
> -	struct vm_area_struct *new_vma, *prev;
> +	struct vm_area_struct *new_vma;
>  	bool faulted_in_anon_vma = true;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.start = addr,
> +		.end = addr + len,
> +		.flags = vma->vm_flags,
> +		.pgoff = pgoff,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
>  
>  	/*
>  	 * If anonymous vma has not yet been faulted, update new pgoff
>  	 * to match new location, to increase its chance of merging.
>  	 */
>  	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
> -		pgoff = addr >> PAGE_SHIFT;
> +		pgoff = vmg.pgoff = addr >> PAGE_SHIFT;
>  		faulted_in_anon_vma = false;
>  	}
>  
> -	new_vma = find_vma_prev(mm, addr, &prev);
> +	new_vma = find_vma_prev(mm, addr, &vmg.prev);
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
>  
> -	new_vma = vma_merge_new_vma_wrapper(&vmi, prev, vma, addr, addr + len, pgoff);
> +	vmg.next = vma_next(&vmi);
> +	vma_prev(&vmi);
> +
> +	new_vma = vma_merge_new_vma(&vmg);
> +
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma
> diff --git a/mm/vma.h b/mm/vma.h
> index 50459f9e4c7f..bbb173053f34 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -55,17 +55,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
>  /* Required for expand_downwards(). */
>  void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
>  
> -/* Required for do_brk_flags(). */
> -void vma_prepare(struct vma_prepare *vp);
> -
> -/* Required for do_brk_flags(). */
> -void init_vma_prep(struct vma_prepare *vp,
> -		   struct vm_area_struct *vma);
> -
> -/* Required for do_brk_flags(). */
> -void vma_complete(struct vma_prepare *vp,
> -		  struct vma_iterator *vmi, struct mm_struct *mm);
> -
>  int vma_expand(struct vma_merge_struct *vmg);
>  int vma_shrink(struct vma_merge_struct *vmg);
>  
> @@ -85,20 +74,6 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  		struct vm_area_struct *next, unsigned long start,
>  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
>  
> -/*
> - * Can we merge the VMA described by vmg into the following VMA vmg->next?
> - *
> - * Required by mmap_region().
> - */
> -bool can_vma_merge_before(struct vma_merge_struct *vmg);
> -
> -/*
> - * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> - *
> - * Required by mmap_region() and do_brk_flags().
> - */
> -bool can_vma_merge_after(struct vma_merge_struct *vmg);
> -
>  /* We are about to modify the VMA's flags. */
>  struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
>  					struct vm_area_struct *prev,
> @@ -133,31 +108,7 @@ struct vm_area_struct
>  		       unsigned long new_flags,
>  		       struct vm_userfaultfd_ctx new_ctx);
>  
> -struct vm_area_struct
> -*vma_merge_new_vma(struct vma_merge_struct *vmg);
> -
> -/* Temporary convenience wrapper. */
> -static inline struct vm_area_struct
> -*vma_merge_new_vma_wrapper(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -			   struct vm_area_struct *vma, unsigned long start,
> -			   unsigned long end, pgoff_t pgoff)
> -{
> -	struct vma_merge_struct vmg = {
> -		.vmi = vmi,
> -		.prev = prev,
> -		.start = start,
> -		.end = end,
> -		.flags = vma->vm_flags,
> -		.file = vma->vm_file,
> -		.anon_vma = vma->anon_vma,
> -		.pgoff = pgoff,
> -		.policy = vma_policy(vma),
> -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> -		.anon_name = anon_vma_name(vma),
> -	};
> -
> -	return vma_merge_new_vma(&vmg);
> -}
> +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
>  
>  /*
>   * Temporary wrapper around vma_merge() so we can have a common interface for
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 40797a819d3d..a39a734282d0 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -709,6 +709,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
>  	mas_destroy(&vmi->mas);
>  }
>  
> +static inline
> +struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
> +{
> +	return mas_next_range(&vmi->mas, ULONG_MAX);
> +}
> +
>  static inline void vm_acct_memory(long pages)
>  {
>  }


