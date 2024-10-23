Return-Path: <linux-kernel+bounces-378048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBB9ACAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DC01F21795
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1067A1AC458;
	Wed, 23 Oct 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KeJZTGrQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="slMKgFLs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y/sf5fk6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QCkUYC0Y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D764419F128
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688330; cv=none; b=fKCDIza37FL1Tn75BeSB/wQWajwmN4iwymbgR3RdIIcsx+p8zCKFnB4jI0na6CTDtrAuY/YCtrZl2o1A7jsXLfXJqbKChisNDQCjD6dPQLTwBiL0d6kEWEgKyKbe2bj3B9K5IkTfChoCmAAi3emRK/ELm/UX28eCdE9Hb9dTSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688330; c=relaxed/simple;
	bh=iZWEEMyh8jfIQ8b3QtbZpeM9GFGPbx3VOhOpTxAWyUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0+7WBkx3YgQlHTVjwnzRT3vIAemE/Y/dg95bOI26A1cW/oNnT577fIMZj47bZagLevaO5ZEhne5A6v7RUn2Dz/ElKPf6b/uTC5aQ9Os+TjCNF2r3upA+08J64UCJ4qOpkwayoOQPMoKsO2SIM7wBgke8wYRVbQUYd5iVvro7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KeJZTGrQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=slMKgFLs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y/sf5fk6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QCkUYC0Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6F8B21F05;
	Wed, 23 Oct 2024 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729688326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zoLfz/fjZfhokZzjollbHy6uKEWa9Wv7liSzK+L+N2s=;
	b=KeJZTGrQoGRd8MIy3b2bUxODm9K4Z1Qp8EeTcxrAE/qgOYIPMy8sfPspyxENyPL/w5QsX4
	n+SnetYe2Mocr4X5yc/vsHgUWHeUFpqFnmHFYiolDkf+ZhbxvzW+jARyLtDfBa+uefZtRI
	tcL539Slu/SQxcCErmXjdTBznQfJZ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729688326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zoLfz/fjZfhokZzjollbHy6uKEWa9Wv7liSzK+L+N2s=;
	b=slMKgFLsqPhzNdFQq1UliB7PDvl36BPVM0O7oAjk3r1X2CEUPtcQaKWG7rChP97uEnCrZU
	a1KkKYzkxyJXnKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729688325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zoLfz/fjZfhokZzjollbHy6uKEWa9Wv7liSzK+L+N2s=;
	b=y/sf5fk6OyvmEdSiquKsE9qehRV0Vx0T3nyi9Cmx5kPbbJbUiyRgfVkCe4vCbloiP7CSEn
	8m5LaprzuZfpEGCp5L9g4JGEuRVYMtUBk1s8pUg1YUiW1L17GKiYabBlRdMdYVZZ5BUh/z
	qi1b/B5o4ucGB/aAC3/o0XMrdJVj9PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729688325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zoLfz/fjZfhokZzjollbHy6uKEWa9Wv7liSzK+L+N2s=;
	b=QCkUYC0Y9RIzaK5JkVPdLGoN/iSlkNVEd4+Y1siso5Ts7vEirRMvtsN6G66hpf5ep6ULnf
	vEQ40IeOUDWYnfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C671513A63;
	Wed, 23 Oct 2024 12:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1VgAMAXzGGflcwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Oct 2024 12:58:45 +0000
Message-ID: <e2bca69d-5266-462c-b770-707ce987473e@suse.cz>
Date: Wed, 23 Oct 2024 14:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 4/8] mm: resolve faulty mmap_region() error
 path behaviour
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/22/24 22:40, Lorenzo Stoakes wrote:
> The mmap_region() function is somewhat terrifying, with spaghetti-like
> control flow and numerous means by which issues can arise and incomplete
> state, memory leaks and other unpleasantness can occur.
> 
> A large amount of the complexity arises from trying to handle errors late
> in the process of mapping a VMA, which forms the basis of recently observed
> issues with resource leaks and observable inconsistent state.
> 
> Taking advantage of previous patches in this series we move a number of
> checks earlier in the code, simplifying things by moving the core of the
> logic into a static internal function __mmap_region().
> 
> Doing this allows us to perform a number of checks up front before we do
> any real work, and allows us to unwind the writable unmap check
> unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> validation unconditionally also.
> 
> We move a number of things here:
> 
> 1. We preallocate memory for the iterator before we call the file-backed
>    memory hook, allowing us to exit early and avoid having to perform
>    complicated and error-prone close/free logic. We carefully free
>    iterator state on both success and error paths.
> 
> 2. The enclosing mmap_region() function handles the mapping_map_writable()
>    logic early. Previously the logic had the mapping_map_writable() at the
>    point of mapping a newly allocated file-backed VMA, and a matching
>    mapping_unmap_writable() on success and error paths.
> 
>    We now do this unconditionally if this is a file-backed, shared writable
>    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
>    doing so does not invalidate the seal check we just performed, and we in
>    any case always decrement the counter in the wrapper.
> 
>    We perform a debug assert to ensure a driver does not attempt to do the
>    opposite.
> 
> 3. We also move arch_validate_flags() up into the mmap_region()
>    function. This is only relevant on arm64 and sparc64, and the check is
>    only meaningful for SPARC with ADI enabled. We explicitly add a warning
>    for this arch if a driver invalidates this check, though the code ought
>    eventually to be fixed to eliminate the need for this.
> 
> With all of these measures in place, we no longer need to explicitly close
> the VMA on error paths, as we place all checks which might fail prior to a
> call to any driver mmap hook.
> 
> This eliminates an entire class of errors, makes the code easier to reason
> about and more robust.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

some nits below

> ---
>  mm/mmap.c | 120 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 66 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 66edf0ebba94..7d02b47a1895 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1361,20 +1361,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
>  }
> 
> -unsigned long mmap_region(struct file *file, unsigned long addr,
> +static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	pgoff_t pglen = PHYS_PFN(len);
> -	struct vm_area_struct *merge;
>  	unsigned long charged = 0;
>  	struct vma_munmap_struct vms;
>  	struct ma_state mas_detach;
>  	struct maple_tree mt_detach;
>  	unsigned long end = addr + len;
> -	bool writable_file_mapping = false;
>  	int error;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> @@ -1448,28 +1446,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vm_flags_init(vma, vm_flags);
>  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> 
> +	if (vma_iter_prealloc(&vmi, vma)) {
> +		error = -ENOMEM;
> +		goto free_vma;
> +	}
> +
>  	if (file) {
>  		vma->vm_file = get_file(file);
>  		error = mmap_file(file, vma);
>  		if (error)
> -			goto unmap_and_free_vma;
> -
> -		if (vma_is_shared_maywrite(vma)) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto close_and_free_vma;
> -
> -			writable_file_mapping = true;
> -		}
> +			goto unmap_and_free_file_vma;
> 
> +		/* Drivers cannot alter the address of the VMA. */
> +		WARN_ON_ONCE(addr != vma->vm_start);
>  		/*
> -		 * Expansion is handled above, merging is handled below.
> -		 * Drivers should not alter the address of the VMA.
> +		 * Drivers should not permit writability when previously it was
> +		 * disallowed.
>  		 */
> -		if (WARN_ON((addr != vma->vm_start))) {
> -			error = -EINVAL;
> -			goto close_and_free_vma;
> -		}
> +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> +				!(vm_flags & VM_MAYWRITE) &&
> +				(vma->vm_flags & VM_MAYWRITE));
> 
>  		vma_iter_config(&vmi, addr, end);

I wonder if this one could be removed, earlier above we did the same config
and neither parameters changed? But it was true before this patch as well,
and maybe it's further refactored away later in the series, just noting.

>  		/*
> @@ -1477,6 +1473,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> +			struct vm_area_struct *merge;
> +
>  			vmg.flags = vma->vm_flags;
>  			/* If this fails, state is reset ready for a reattempt. */
>  			merge = vma_merge_new_range(&vmg);
> @@ -1491,10 +1489,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  				 */
>  				fput(vma->vm_file);
>  				vm_area_free(vma);
> +				vma_iter_free(&vmi);

If we merged successfully, I think this is not necessary? But doesn't hurt?

>  				vma = merge;
>  				/* Update vm_flags to pick up the change. */
>  				vm_flags = vma->vm_flags;
> -				goto unmap_writable;
> +				goto file_expanded;
>  			}
>  			vma_iter_config(&vmi, addr, end);
>  		}
> @@ -1503,26 +1502,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	} else if (vm_flags & VM_SHARED) {
>  		error = shmem_zero_setup(vma);
>  		if (error)
> -			goto free_vma;
> +			goto free_iter_vma;
>  	} else {
>  		vma_set_anonymous(vma);
>  	}
> 
> -	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
> -		error = -EACCES;
> -		goto close_and_free_vma;
> -	}
> -
> -	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> -		error = -EINVAL;
> -		goto close_and_free_vma;
> -	}
> -
> -	if (vma_iter_prealloc(&vmi, vma)) {
> -		error = -ENOMEM;
> -		goto close_and_free_vma;
> -	}
> +#ifdef CONFIG_SPARC64
> +	/* TODO: Fix SPARC ADI! */
> +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +#endif
> 
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> @@ -1536,10 +1524,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	khugepaged_enter_vma(vma, vma->vm_flags);
> 
> -	/* Once vma denies write, undo our temporary denial count */
> -unmap_writable:
> -	if (writable_file_mapping)
> -		mapping_unmap_writable(file->f_mapping);
> +file_expanded:
>  	file = vma->vm_file;
>  	ksm_add_vma(vma);
>  expanded:
> @@ -1572,23 +1557,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> 
>  	vma_set_page_prot(vma);
> 
> -	validate_mm(mm);
>  	return addr;
> 
> -close_and_free_vma:
> -	vma_close(vma);
> -
> -	if (file || vma->vm_file) {
> -unmap_and_free_vma:
> -		fput(vma->vm_file);
> -		vma->vm_file = NULL;
> +unmap_and_free_file_vma:
> +	fput(vma->vm_file);
> +	vma->vm_file = NULL;
> 
> -		vma_iter_set(&vmi, vma->vm_end);
> -		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> -	}
> -	if (writable_file_mapping)
> -		mapping_unmap_writable(file->f_mapping);
> +	vma_iter_set(&vmi, vma->vm_end);
> +	/* Undo any partial mapping done by a device driver. */
> +	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> +free_iter_vma:
> +	vma_iter_free(&vmi);
>  free_vma:
>  	vm_area_free(vma);
>  unacct_error:
> @@ -1598,10 +1577,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  abort_munmap:
>  	vms_abort_munmap_vmas(&vms, &mas_detach);
>  gather_failed:
> -	validate_mm(mm);
>  	return error;
>  }
> 
> +unsigned long mmap_region(struct file *file, unsigned long addr,
> +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +			  struct list_head *uf)
> +{
> +	unsigned long ret;
> +	bool writable_file_mapping = false;
> +
> +	/* Allow architectures to sanity-check the vm_flags. */
> +	if (!arch_validate_flags(vm_flags))
> +		return -EINVAL;
> +
> +	/* Check to see if MDWE is applicable. */
> +	if (map_deny_write_exec(vm_flags, vm_flags))
> +		return -EACCES;

The two checks above used to be in the opposite order. Can we keep that just
to be sure we don't change user observable behavior unnecessarily?

> +	/* Map writable and ensure this isn't a sealed memfd. */
> +	if (file && is_shared_maywrite(vm_flags)) {
> +		int error = mapping_map_writable(file->f_mapping);
> +
> +		if (error)
> +			return error;
> +		writable_file_mapping = true;
> +	}
> +
> +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> +
> +	/* Clear our write mapping regardless of error. */
> +	if (writable_file_mapping)
> +		mapping_unmap_writable(file->f_mapping);
> +
> +	validate_mm(current->mm);
> +	return ret;
> +}
> +
>  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
>  {
>  	int ret;
> --
> 2.47.0


