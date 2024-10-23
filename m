Return-Path: <linux-kernel+bounces-378279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF449ACD81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A41C24B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF77B1CB50E;
	Wed, 23 Oct 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DJQYG74k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxJP2iS2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ylzwQ11u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3ylljO2A"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9361C3051
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694331; cv=none; b=lKWSfInfsI7Cl2PhQ+8F3hz3m3+ZjfMb0h2U7YwzRqY3dm4aLoRRRZtpTP4kIEKgw3sedGuuCA4RpwrXyW2iGKwNfrklOgqDV2U9bZQ6MGCG2nYH7Y10/X5HPMC4sg9BAJPCVuabzJSyrgXnx8E2yCMFsXwGqZEY2ei5ALriHZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694331; c=relaxed/simple;
	bh=Ury7XnfwU+tIJ73SCG+Dwdw6IyxpYIAd0+izgcZfSKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rc6PM7nH3LOqvp3PzSdsSVYmBTeLwROUPgB2PojJdZ8Zp4LGix0kHUgVYRdWuGDA9w4mNidYhnn7jI++HJuJm2tDuVcjHX8Y7D6WMMszdnL+pTcdKbwODVpS8meiWQMRqNqVBwUUzc7jeWballijew2SOfVuX8HbJFRhwCE26ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DJQYG74k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxJP2iS2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ylzwQ11u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3ylljO2A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB81321FBA;
	Wed, 23 Oct 2024 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729694327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nj8mBsr/YFnTpqzJISblVs7Y7ianEpE2/8SUlAI8Gwk=;
	b=DJQYG74kAS9R4UcKLiZ01PBYvSIlDuuFjSB8fTFD/6frb+eI/VF1ln+2JJao/tTBpzmHAP
	eyh9BfeQAVVHzJE9dMbxade9fuTCDWV3QjoqfrzueMGG/xxrpiYt5jBKboZfVnlopPOiqh
	dElWa4wSM5AE/8PASyVIVD/FgYhlSP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729694327;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nj8mBsr/YFnTpqzJISblVs7Y7ianEpE2/8SUlAI8Gwk=;
	b=IxJP2iS29+ZwoOSNNaTHbwMgtJocP5EF0vvrtQGzU/knsvXQZGhCdu+AipH7SyMDQvRexU
	pLU/oDKYLS/ZkMDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729694326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nj8mBsr/YFnTpqzJISblVs7Y7ianEpE2/8SUlAI8Gwk=;
	b=ylzwQ11uzikRVhS0nuvcIBH3m5tzRTEhET0vxzfOyFwOkeloiQOxjbP8P2jVuhd3iLYhR9
	zpSBKY82vNOuXdC9F3z4TLvtjiDiqNOmDqf5Ty4luC8XIfWJZQ18OPA3x4+XlYnvgNjKsp
	7KHMgPTY+2bkUJUFVczCqUwr361p/iY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729694326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nj8mBsr/YFnTpqzJISblVs7Y7ianEpE2/8SUlAI8Gwk=;
	b=3ylljO2AhjLIJ2VC4cp5wI2hlU2hI9foRPjMa9kVa13P1mfJk/QyTLVD+OQvyDDpAXVGwV
	9koq+bK0IhE07EAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D317913AD3;
	Wed, 23 Oct 2024 14:38:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KWUMM3YKGWeoGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Oct 2024 14:38:46 +0000
Message-ID: <81712eec-440d-421c-93b4-8b6d9c491693@suse.cz>
Date: Wed, 23 Oct 2024 16:38:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/22/24 22:40, Lorenzo Stoakes wrote:
> We have seen bugs and resource leaks arise from the complexity of the
> __mmap_region() function. This, and the generally deeply fragile error
> handling logic and complexity which makes understanding the function
> difficult make it highly desirable to refactor it into something readable.
> 
> Achieve this by separating the function into smaller logical parts which
> are easier to understand and follow, and which importantly very
> significantly simplify the error handling.
> 
> Note that we now call vms_abort_munmap_vmas() in more error paths than we
> used to, however in cases where no abort need occur, vms->nr_pages will be
> equal to zero and we simply exit this function without doing more than we
> would have done previously.
> 
> Importantly, the invocation of the driver mmap hook via mmap_file() now has
> very simple and obvious handling (this was previously the most problematic
> part of the mmap() operation).
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 240 insertions(+), 140 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index 7617f9d50d62..a271e2b406ab 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,6 +7,31 @@
>  #include "vma_internal.h"
>  #include "vma.h"
> 
> +struct mmap_state {
> +	struct mm_struct *mm;
> +	struct vma_iterator *vmi;
> +	struct vma_merge_struct *vmg;
> +	struct list_head *uf;
> +
> +	struct vma_munmap_struct vms;
> +	struct ma_state mas_detach;
> +	struct maple_tree mt_detach;
> +
> +	unsigned long flags;
> +	unsigned long pglen;
> +	unsigned long charged;
> +};
> +
> +#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
> +	struct mmap_state name = {				\
> +		.mm = mm_,					\
> +		.vmi = vmi_,					\
> +		.vmg = vmg_,					\
> +		.uf = uf_,					\
> +		.flags = flags_,				\
> +		.pglen = PHYS_PFN(len_),			\
> +	}
> +
>  static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
>  {
>  	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> @@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
>  	vms_complete_munmap_vmas(vms, mas_detach);
>  }
> 
> -unsigned long __mmap_region(struct file *file, unsigned long addr,
> -		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> -		struct list_head *uf)
> +/*
> + * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
> + *                    unmapped once the map operation is completed, check limits,
> + *                    account mapping and clean up any pre-existing VMAs.
> + *
> + * @map: Mapping state.
> + *
> + * Returns: 0 on success, error code otherwise.
> + */
> +static int __mmap_prepare(struct mmap_state *map)
>  {
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma = NULL;
> -	pgoff_t pglen = PHYS_PFN(len);
> -	unsigned long charged = 0;
> -	struct vma_munmap_struct vms;
> -	struct ma_state mas_detach;
> -	struct maple_tree mt_detach;
> -	unsigned long end = addr + len;
>  	int error;
> -	VMA_ITERATOR(vmi, mm, addr);
> -	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> -
> -	vmg.file = file;
> -	/* Find the first overlapping VMA */
> -	vma = vma_find(&vmi, end);
> -	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> -	if (vma) {
> -		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> -		mt_on_stack(mt_detach);
> -		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_merge_struct *vmg = map->vmg;
> +	struct vma_munmap_struct *vms = &map->vms;
> +
> +	/* Find the first overlapping VMA and initialise unmap state. */
> +	vms->vma = vma_find(vmi, vmg->end);
> +	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
> +			/* unlock = */ false);
> +
> +	/* OK, we have overlapping VMAs - prepare to unmap them. */
> +	if (vms->vma) {
> +		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> +		mt_on_stack(map->mt_detach);
> +		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
> -		error = vms_gather_munmap_vmas(&vms, &mas_detach);
> +		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
>  		if (error)
> -			goto gather_failed;
> +			return error;

So this assumes vms_abort_munmap_vmas() will rely on the "vms->nr_pages will
be equal to zero" mentioned in commit log. But AFAICS
vms_gather_munmap_vmas() can fail in Nth iteration of its
for_each_vma_range() after some iterations already increased nr_pages and it
will do a reattach_vmas() and return the error and we just return the error
here.
I think either here or maybe in vms_gather_munmap_vmas() itself a reset of
vms->nr_pages to zero on error should happen for the vms_abort_munmap_vmas()
to be a no-op?

> 
> -		vmg.next = vms.next;
> -		vmg.prev = vms.prev;
> -		vma = NULL;
> +		vmg->next = vms->next;
> +		vmg->prev = vms->prev;
>  	} else {
> -		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> +		vmg->next = vma_iter_next_rewind(vmi, &vmg->prev);
>  	}
> 
>  	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
> -		error = -ENOMEM;
> -		goto abort_munmap;
> -	}
> +	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
> +		return -ENOMEM;
> 
> -	/*
> -	 * Private writable mapping: check memory availability
> -	 */
> -	if (accountable_mapping(file, vm_flags)) {
> -		charged = pglen;
> -		charged -= vms.nr_accounted;
> -		if (charged) {
> -			error = security_vm_enough_memory_mm(mm, charged);
> +	/* Private writable mapping: check memory availability. */
> +	if (accountable_mapping(vmg->file, map->flags)) {
> +		map->charged = map->pglen;
> +		map->charged -= vms->nr_accounted;
> +		if (map->charged) {
> +			error = security_vm_enough_memory_mm(map->mm, map->charged);
>  			if (error)
> -				goto abort_munmap;
> +				return error;
>  		}
> 
> -		vms.nr_accounted = 0;
> -		vm_flags |= VM_ACCOUNT;
> -		vmg.flags = vm_flags;
> +		vms->nr_accounted = 0;
> +		map->flags |= VM_ACCOUNT;
>  	}
> 
>  	/*
> -	 * clear PTEs while the vma is still in the tree so that rmap
> +	 * Clear PTEs while the vma is still in the tree so that rmap
>  	 * cannot race with the freeing later in the truncate scenario.
>  	 * This is also needed for mmap_file(), which is why vm_ops
>  	 * close function is called.
>  	 */
> -	vms_clean_up_area(&vms, &mas_detach);
> -	vma = vma_merge_new_range(&vmg);
> -	if (vma)
> -		goto expanded;
> +	vms_clean_up_area(vms, &map->mas_detach);
> +
> +	return 0;
> +}
> +
> +static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
> +			       struct vm_area_struct **mergep)
> +{
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_merge_struct *vmg = map->vmg;
> +	int error;
> +
> +	vma->vm_file = get_file(vmg->file);
> +	error = mmap_file(vma->vm_file, vma);
> +	if (error) {
> +		fput(vma->vm_file);
> +		vma->vm_file = NULL;
> +
> +		vma_iter_set(vmi, vma->vm_end);
> +		/* Undo any partial mapping done by a device driver. */
> +		unmap_region(&vmi->mas, vma, vmg->prev, vmg->next);
> +
> +		return error;
> +	}
> +
> +	/* Drivers cannot alter the address of the VMA. */
> +	WARN_ON_ONCE(vmg->start != vma->vm_start);
> +	/*
> +	 * Drivers should not permit writability when previously it was
> +	 * disallowed.
> +	 */
> +	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
> +			!(map->flags & VM_MAYWRITE) &&
> +			(vma->vm_flags & VM_MAYWRITE));
> +
> +	vma_iter_config(vmi, vmg->start, vmg->end);
> +	/*
> +	 * If flags changed after mmap_file(), we should try merge
> +	 * vma again as we may succeed this time.
> +	 */
> +	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
> +		struct vm_area_struct *merge;
> +
> +		vmg->flags = vma->vm_flags;
> +		/* If this fails, state is reset ready for a reattempt. */
> +		merge = vma_merge_new_range(vmg);
> +
> +		if (merge) {
> +			/*
> +			 * ->mmap() can change vma->vm_file and fput
> +			 * the original file. So fput the vma->vm_file
> +			 * here or we would add an extra fput for file
> +			 * and cause general protection fault
> +			 * ultimately.
> +			 */
> +			fput(vma->vm_file);
> +			vm_area_free(vma);

This frees the vma.

> +			vma_iter_free(vmi);
> +			*mergep = merge;
> +		} else {
> +			vma_iter_config(vmi, vmg->start, vmg->end);
> +		}
> +	}
> +
> +	map->flags = vma->vm_flags;

So this is use-after-free.

Maybe pass only a single struct vm_area_struct **vmap parameter to this
function, and in case of merge, change both vma and *vmap to it?.

Although I can see it's all moot after 8/8. Still let's not introduce a
temporary UAF step.

> +	return 0;
> +}
> +
> +/*
> + * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
> + *                    possible.
> + *
> + *                    An exception to this is if the mapping is file-backed, and
> + *                    the underlying driver changes the VMA flags, permitting a
> + *                    subsequent merge of the VMA, in which case the returned
> + *                    VMA is one that was merged on a second attempt.
> + *
> + * @map:  Mapping state.
> + * @vmap: Output pointer for the new VMA.
> + *
> + * Returns: Zero on success, or an error.
> + */
> +static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> +{
> +	struct vma_iterator *vmi = map->vmi;
> +	struct vma_merge_struct *vmg = map->vmg;
> +	struct vm_area_struct *merge = NULL;
> +	int error = 0;
> +	struct vm_area_struct *vma;
> +
>  	/*
>  	 * Determine the object being mapped and call the appropriate
>  	 * specific mapper. the address has already been validated, but
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
> -	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> -		goto unacct_error;
> -	}
> +	vma = vm_area_alloc(map->mm);
> +	if (!vma)
> +		return -ENOMEM;
> 
> -	vma_iter_config(&vmi, addr, end);
> -	vma_set_range(vma, addr, end, pgoff);
> -	vm_flags_init(vma, vm_flags);
> -	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> +	vma_iter_config(vmi, vmg->start, vmg->end);
> +	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> +	vm_flags_init(vma, map->flags);
> +	vma->vm_page_prot = vm_get_page_prot(map->flags);
> 
> -	if (vma_iter_prealloc(&vmi, vma)) {
> +	if (vma_iter_prealloc(vmi, vma)) {
>  		error = -ENOMEM;
>  		goto free_vma;
>  	}
> 
> -	if (file) {
> -		vma->vm_file = get_file(file);
> -		error = mmap_file(file, vma);
> -		if (error)
> -			goto unmap_and_free_file_vma;
> -
> -		/* Drivers cannot alter the address of the VMA. */
> -		WARN_ON_ONCE(addr != vma->vm_start);
> -		/*
> -		 * Drivers should not permit writability when previously it was
> -		 * disallowed.
> -		 */
> -		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> -				!(vm_flags & VM_MAYWRITE) &&
> -				(vma->vm_flags & VM_MAYWRITE));
> -
> -		vma_iter_config(&vmi, addr, end);
> -		/*
> -		 * If vm_flags changed after mmap_file(), we should try merge
> -		 * vma again as we may succeed this time.
> -		 */
> -		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> -			struct vm_area_struct *merge;
> -
> -			vmg.flags = vma->vm_flags;
> -			/* If this fails, state is reset ready for a reattempt. */
> -			merge = vma_merge_new_range(&vmg);
> -
> -			if (merge) {
> -				/*
> -				 * ->mmap() can change vma->vm_file and fput
> -				 * the original file. So fput the vma->vm_file
> -				 * here or we would add an extra fput for file
> -				 * and cause general protection fault
> -				 * ultimately.
> -				 */
> -				fput(vma->vm_file);
> -				vm_area_free(vma);
> -				vma_iter_free(&vmi);
> -				vma = merge;
> -				/* Update vm_flags to pick up the change. */
> -				vm_flags = vma->vm_flags;
> -				goto file_expanded;
> -			}
> -			vma_iter_config(&vmi, addr, end);
> -		}
> -
> -		vm_flags = vma->vm_flags;
> -	} else if (vm_flags & VM_SHARED) {
> +	if (vmg->file)
> +		error = __mmap_new_file_vma(map, vma, &merge);
> +	else if (map->flags & VM_SHARED)
>  		error = shmem_zero_setup(vma);
> -		if (error)
> -			goto free_iter_vma;
> -	} else {
> +	else
>  		vma_set_anonymous(vma);
> -	}
> +
> +	if (error)
> +		goto free_iter_vma;
> +
> +	if (merge)
> +		goto file_expanded;
> 
>  #ifdef CONFIG_SPARC64
>  	/* TODO: Fix SPARC ADI! */
> -	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +	WARN_ON_ONCE(!arch_validate_flags(map->flags));
>  #endif
> 
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> -	vma_iter_store(&vmi, vma);
> -	mm->map_count++;
> +	vma_iter_store(vmi, vma);
> +	map->mm->map_count++;
>  	vma_link_file(vma);
> 
>  	/*
>  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>  	 * call covers the non-merge case.
>  	 */
> -	khugepaged_enter_vma(vma, vma->vm_flags);
> +	khugepaged_enter_vma(vma, map->flags);
> 
>  file_expanded:
> -	file = vma->vm_file;
>  	ksm_add_vma(vma);
> -expanded:
> +
> +	*vmap = vma;
> +	return 0;
> +
> +free_iter_vma:
> +	vma_iter_free(vmi);
> +free_vma:
> +	vm_area_free(vma);
> +	return error;
> +}
> +
> +/*
> + * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
> + *                     statistics, handle locking and finalise the VMA.
> + *
> + * @map: Mapping state.
> + * @vma: Merged or newly allocated VMA for the mmap()'d region.
> + */
> +static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
> +{
> +	struct mm_struct *mm = map->mm;
> +	unsigned long vm_flags = vma->vm_flags;
> +
>  	perf_event_mmap(vma);
> 
> -	/* Unmap any existing mapping in the area */
> -	vms_complete_munmap_vmas(&vms, &mas_detach);
> +	/* Unmap any existing mapping in the area. */
> +	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
> 
> -	vm_stat_account(mm, vm_flags, pglen);
> +	vm_stat_account(mm, vma->vm_flags, map->pglen);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
>  					is_vm_hugetlb_page(vma) ||
> -					vma == get_gate_vma(current->mm))
> +					vma == get_gate_vma(mm))
>  			vm_flags_clear(vma, VM_LOCKED_MASK);
>  		else
> -			mm->locked_vm += pglen;
> +			mm->locked_vm += map->pglen;
>  	}
> 
> -	if (file)
> +	if (vma->vm_file)
>  		uprobe_mmap(vma);
> 
>  	/*
> @@ -2364,26 +2447,43 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	vm_flags_set(vma, VM_SOFTDIRTY);
> 
>  	vma_set_page_prot(vma);
> +}
> 
> -	return addr;
> +unsigned long __mmap_region(struct file *file, unsigned long addr,
> +		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +		struct list_head *uf)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	int error;
> +	VMA_ITERATOR(vmi, mm, addr);
> +	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
> +	MMAP_STATE(map, mm, &vmi, &vmg, uf, vm_flags, len);
> 
> -unmap_and_free_file_vma:
> -	fput(vma->vm_file);
> -	vma->vm_file = NULL;
> +	vmg.file = file;
> 
> -	vma_iter_set(&vmi, vma->vm_end);
> -	/* Undo any partial mapping done by a device driver. */
> -	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> -free_iter_vma:
> -	vma_iter_free(&vmi);
> -free_vma:
> -	vm_area_free(vma);
> -unacct_error:
> -	if (charged)
> -		vm_unacct_memory(charged);
> +	error = __mmap_prepare(&map);
> +	if (error)
> +		goto abort_munmap;
> +
> +	/* Attempt to merge with adjacent VMAs... */
> +	vmg.flags = map.flags;
> +	vma = vma_merge_new_range(&vmg);
> +	if (!vma) {
> +		/* ...but if we can't, allocate a new VMA. */
> +		error = __mmap_new_vma(&map, &vma);
> +		if (error)
> +			goto unacct_error;
> +	}
> +
> +	__mmap_complete(&map, vma);
> 
> +	return addr;
> +
> +unacct_error:
> +	if (map.charged)
> +		vm_unacct_memory(map.charged);
>  abort_munmap:
> -	vms_abort_munmap_vmas(&vms, &mas_detach);
> -gather_failed:
> +	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
>  	return error;
>  }
> --
> 2.47.0


