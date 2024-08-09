Return-Path: <linux-kernel+bounces-280970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEB94D17E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66734281F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41018C93F;
	Fri,  9 Aug 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCh02F4D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+F9ocQ1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCh02F4D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+F9ocQ1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7E1957F0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211045; cv=none; b=RwdVfdgvZCEgDfQdoef5zi2ey1tYGd3obNBcVd0HQQ9eBdzsmFvQK+DbLRfCrn/6AaMUf5APVLxZjyH+OCwGeeCe3kVGJktQHEWc5HN2QA5p/8zdqKahjt3tfIUz5fiu9c2OgMcZn7ltt9FVeXUrnKg+Ku8EHaCjzA2srpwFXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211045; c=relaxed/simple;
	bh=a/nhOyihMwO9/3B286+NLiQIsyMK/G4svTqWgoylCPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3FyN5c38EPqL68mb3TI6DiOsHtrK8xqUD2hcU8XspW4F2ucJfzLCDqTCl0DEumbXf8WluDuqk7WkHl84MpU+cCZ8dNJ9ccbZDEKibuwo73NEHIv2Z/plkwFmAaHh/01Ba7Kpei3otgqKV9b1yPYrtin0SdWQqMjy8YbVfzQQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCh02F4D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+F9ocQ1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCh02F4D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+F9ocQ1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1458C21F66;
	Fri,  9 Aug 2024 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723211041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XjZj351O0kZSXuSLDGcHMBd2ud9c4ljlcV3FkZD1KxI=;
	b=ZCh02F4DBr4kmHF8q/4wRb3KCmfpO2py99V7/x4VvQdOMNArL74rTgW8Clz2K3/rF77JaI
	4WL2Qmw3zXHRhlCP8K4fPquQqXuTMm2wxmthKscwadkyld2OgrdHqPFfOxH4ZToHmnWKVf
	wY0Zzdcnhn7dlAffYlswon0WWhXNdDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723211041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XjZj351O0kZSXuSLDGcHMBd2ud9c4ljlcV3FkZD1KxI=;
	b=f+F9ocQ15+CbIaTExtMjuOiPM5ewJSee9yH78AeJI7UHKXwOmP3Wyf/Kq1Cog8vOpJmfhv
	9W1hD+oK/mf73+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723211041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XjZj351O0kZSXuSLDGcHMBd2ud9c4ljlcV3FkZD1KxI=;
	b=ZCh02F4DBr4kmHF8q/4wRb3KCmfpO2py99V7/x4VvQdOMNArL74rTgW8Clz2K3/rF77JaI
	4WL2Qmw3zXHRhlCP8K4fPquQqXuTMm2wxmthKscwadkyld2OgrdHqPFfOxH4ZToHmnWKVf
	wY0Zzdcnhn7dlAffYlswon0WWhXNdDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723211041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XjZj351O0kZSXuSLDGcHMBd2ud9c4ljlcV3FkZD1KxI=;
	b=f+F9ocQ15+CbIaTExtMjuOiPM5ewJSee9yH78AeJI7UHKXwOmP3Wyf/Kq1Cog8vOpJmfhv
	9W1hD+oK/mf73+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04C3813A7D;
	Fri,  9 Aug 2024 13:44:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E6TTACEdtmZmBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Aug 2024 13:44:01 +0000
Message-ID: <8c490115-59fe-4e87-ac07-ec7dd6a3ccd3@suse.cz>
Date: Fri, 9 Aug 2024 15:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm: refactor vma_merge() into modify-only
 vma_merge_modified()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 8/5/24 14:13, Lorenzo Stoakes wrote:
> The existing vma_merge() function is no longer required to handle what were
> previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
> this is now handled by vma_merge_new_vma().
> 
> Additionally, we simplify the convoluted control flow of the original,
> maintaining identical logic only expressed more clearly and doing away with
> a complicated set of cases, rather logically examining each possible
> outcome - merging of both the previous and subsequent VMA, merging of the
> previous VMA and merging of the subsequent VMA alone.
> 
> We now utilise the previously implemented commit_merge() function to share
> logic with vma_expand() deduplicating code and providing less surface area
> for bugs and confusion.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c | 474 +++++++++++++++++++++++++++----------------------------
>  mm/vma.h |   6 -
>  2 files changed, 232 insertions(+), 248 deletions(-)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index b7e3c64d5d68..c55ae035f5d6 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -569,8 +569,7 @@ static int commit_merge(struct vma_merge_struct *vmg,
>  			struct vm_area_struct *adjust,
>  			struct vm_area_struct *remove,
>  			struct vm_area_struct *remove2,
> -			long adj_start,
> -			bool expanded)
> +			long adj_start, bool expanded)
>  {
>  	struct vma_prepare vp;
>  
> @@ -607,6 +606,236 @@ static int commit_merge(struct vma_merge_struct *vmg,
>  	return 0;
>  }
>  
> +/*
> + * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
> + * attributes modified.
> + *
> + * @vmg: Describes the modifications being made to a VMA and associated
> + *       metadata.
> + *
> + * When the attributes of a range within a VMA change, then it might be possible
> + * for immediately adjacent VMAs to be merged into that VMA due to having
> + * identical properties.
> + *
> + * This function checks for the existence of any such mergeable VMAs and updates
> + * the maple tree describing the @vmg->vma->vm_mm address space to account for
> + * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
> + *
> + * As part of this operation, if a merge occurs, the @vmg object will have its
> + * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
> + * calls to this function should reset these fields.
> + *
> + * Returns: The merged VMA if merge succeeds, or NULL otherwise.
> + *
> + * ASSUMPTIONS:
> + * - The caller must assign the VMA to be modifed to vmg->vma.
> + * - The caller must have set vmg->prev to the previous VMA, if there is one.
> + * - The caller does not need to set vmg->next, as we determine this.
> + * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.

Also there's again some assumption about vmi? :)

> + */
> +static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
> +{
> +	struct vm_area_struct *vma = vmg->vma;
> +	struct vm_area_struct *prev = vmg->prev;
> +	struct vm_area_struct *next, *res;
> +	struct vm_area_struct *anon_dup = NULL;
> +	struct vm_area_struct *adjust = NULL;
> +	unsigned long start = vmg->start;
> +	unsigned long end = vmg->end;
> +	bool left_side = vma && start == vma->vm_start;
> +	bool right_side = vma && end == vma->vm_end;
> +	bool merge_will_delete_vma, merge_will_delete_next;
> +	bool merge_left, merge_right;
> +	bool merge_both = false;
> +	int err = 0;
> +	long adj_start = 0;
> +
> +	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
> +	VM_WARN_ON(vmg->next); /* We set this. */
> +	VM_WARN_ON(prev && start <= prev->vm_start);
> +	VM_WARN_ON(start >= end);
> +	/*
> +	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
> +	 * not, we must span a portion of the VMA.
> +	 */
> +	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
> +			   vmg->end > vma->vm_end));
> +
> +	/*
> +	 * If a special mapping or neither at the furthermost left or right side
> +	 * of the VMA, then we have no chance of merging and should abort.
> +	 *
> +	 * We later require that vma->vm_flags == vm_flags, so this tests
> +	 * vma->vm_flags & VM_SPECIAL, too.
> +	 */
> +	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
> +		return NULL;
> +
> +	if (left_side && prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
> +		merge_left = true;
> +		vma_prev(vmg->vmi);
> +	} else {
> +		merge_left = false;
> +	}
> +
> +	if (right_side) {
> +		next = vmg->next = vma_lookup(vma->vm_mm, end);
> +
> +		/*
> +		 * We can merge right if there is a subsequent VMA, if it is
> +		 * immediately adjacent, and if it is compatible with vma.
> +		 */
> +		merge_right = next && end == next->vm_start &&
> +			can_vma_merge_before(vmg);
> +
> +		/*
> +		 * We can only merge both if the anonymous VMA of the previous
> +		 * VMA is compatible with the anonymous VMA of the subsequent
> +		 * VMA.
> +		 *
> +		 * Otherwise, we default to merging only the left.
> +		 */
> +		if (merge_left && merge_right)
> +			merge_right = merge_both =
> +				is_mergeable_anon_vma(prev->anon_vma,
> +						      next->anon_vma, NULL);
> +	} else {
> +		merge_right = false;
> +		next = NULL;
> +	}
> +
> +	/* If we have nothing to merge, abort. */
> +	if (!merge_left && !merge_right)
> +		return NULL;
> +
> +	/* If we span the entire VMA, a merge implies it will be deleted. */
> +	merge_will_delete_vma = left_side && right_side;
> +	/* If we merge both VMAs, then next is also deleted. */
> +	merge_will_delete_next = merge_both;
> +
> +	/* No matter what happens, we will be adjusting vma. */
> +	vma_start_write(vma);
> +
> +	if (merge_left)
> +		vma_start_write(prev);
> +
> +	if (merge_right)
> +		vma_start_write(next);
> +
> +	if (merge_both) {
> +		/*
> +		 *         |<----->|
> +		 * |-------*********-------|
> +		 *   prev     vma     next
> +		 *  extend   delete  delete
> +		 */
> +
> +		vmg->vma = prev;
> +		vmg->start = prev->vm_start;
> +		vmg->end = next->vm_end;
> +		vmg->pgoff = prev->vm_pgoff;
> +
> +		/*
> +		 * We already ensured anon_vma compatibility above, so now it's
> +		 * simply a case of, if prev has no anon_vma object, which of
> +		 * next or vma contains the anon_vma we must duplicate.
> +		 */
> +		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
> +	} else if (merge_left) {
> +		/*
> +		 *         |<----->| OR
> +		 *         |<--------->|
> +		 * |-------*************
> +		 *   prev       vma
> +		 *  extend shrink/delete
> +		 */
> +
> +		unsigned long end = vmg->end;

Nit: This is only used once below, thus could be used directly?

> +
> +		vmg->vma = prev;
> +		vmg->start = prev->vm_start;
> +		vmg->pgoff = prev->vm_pgoff;
> +
> +		if (merge_will_delete_vma) {
> +			/*
> +			 * can_vma_merge_after() assumed we would not be
> +			 * removing vma, so it skipped the check for
> +			 * vm_ops->close, but we are removing vma.
> +			 */
> +			if (vma->vm_ops && vma->vm_ops->close)
> +				err = -EINVAL;
> +		} else {
> +			adjust = vma;
> +			adj_start = end - vma->vm_start;
> +		}
> +
> +		if (!err)
> +			err = dup_anon_vma(prev, vma, &anon_dup);
> +	} else { /* merge_right */
> +		/*
> +		 *     |<----->| OR
> +		 * |<--------->|
> +		 * *************-------|
> +		 *      vma       next
> +		 * shrink/delete extend
> +		 */
> +
> +		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> +
> +		VM_WARN_ON(!merge_right);
> +		/* If we are offset into a VMA, then prev must be vma. */
> +		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
> +
> +		if (merge_will_delete_vma) {
> +			vmg->vma = next;
> +			vmg->end = next->vm_end;
> +			vmg->pgoff = next->vm_pgoff - pglen;
> +		} else {
> +			/*
> +			 * We shrink vma and expand next.
> +			 *
> +			 * IMPORTANT: This is the ONLY case where the final
> +			 * merged VMA is NOT vmg->vma, but rather vmg->next.
> +			 */
> +
> +			vmg->start = vma->vm_start;
> +			vmg->end = start;
> +			vmg->pgoff = vma->vm_pgoff;
> +
> +			adjust = next;
> +			adj_start = -(vma->vm_end - start);
> +		}
> +
> +		err = dup_anon_vma(next, vma, &anon_dup);
> +	}
> +
> +	if (err)
> +		goto abort;
> +
> +	if (commit_merge(vmg, adjust,
> +			 merge_will_delete_vma ? vma : NULL,
> +			 merge_will_delete_next ? next : NULL,
> +			 adj_start,
> +			 /*
> +			  * In nearly all cases, we expand vmg->vma. There is
> +			  * one exception - merge_right where we partially span
> +			  * the VMA. In this case we shrink the end of vmg->vma
> +			  * and adjust the start of vmg->next accordingly.
> +			  */
> +			 !merge_right || merge_will_delete_vma))
> +		return NULL;

If this fails, you need to unlink_anon_vma() ? The old code did.


> +	res = merge_left ? prev : next;
> +	khugepaged_enter_vma(res, vmg->flags);
> +
> +	return res;
> +
> +abort:
> +	vma_iter_set(vmg->vmi, start);
> +	vma_iter_load(vmg->vmi);
> +	return NULL;
> +}
> +
>  /*
>   * vma_merge_new_vma - Attempt to merge a new VMA into address space
>   *
> @@ -1022,245 +1251,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }
>  
> -/*
> - * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
> - * figure out whether that can be merged with its predecessor or its
> - * successor.  Or both (it neatly fills a hole).
> - *
> - * In most cases - when called for mmap, brk or mremap - [addr,end) is
> - * certain not to be mapped by the time vma_merge is called; but when
> - * called for mprotect, it is certain to be already mapped (either at
> - * an offset within prev, or at the start of next), and the flags of
> - * this area are about to be changed to vm_flags - and the no-change
> - * case has already been eliminated.
> - *
> - * The following mprotect cases have to be considered, where **** is
> - * the area passed down from mprotect_fixup, never extending beyond one
> - * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
> - * at the same address as **** and is of the same or larger span, and
> - * NNNN the next vma after ****:
> - *
> - *     ****             ****                   ****
> - *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
> - *    cannot merge    might become       might become
> - *                    PPNNNNNNNNNN       PPPPPPPPPPCC
> - *    mmap, brk or    case 4 below       case 5 below
> - *    mremap move:
> - *                        ****               ****
> - *                    PPPP    NNNN       PPPPCCCCNNNN
> - *                    might become       might become
> - *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
> - *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
> - *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
> - *
> - * It is important for case 8 that the vma CCCC overlapping the
> - * region **** is never going to extended over NNNN. Instead NNNN must
> - * be extended in region **** and CCCC must be removed. This way in
> - * all cases where vma_merge succeeds, the moment vma_merge drops the
> - * rmap_locks, the properties of the merged vma will be already
> - * correct for the whole merged range. Some of those properties like
> - * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
> - * be correct for the whole merged range immediately after the
> - * rmap_locks are released. Otherwise if NNNN would be removed and
> - * CCCC would be extended over the NNNN range, remove_migration_ptes
> - * or other rmap walkers (if working on addresses beyond the "end"
> - * parameter) may establish ptes with the wrong permissions of CCCC
> - * instead of the right permissions of NNNN.
> - *
> - * In the code below:
> - * PPPP is represented by *prev
> - * CCCC is represented by *curr or not represented at all (NULL)
> - * NNNN is represented by *next or not represented at all (NULL)
> - * **** is not represented - it will be merged and the vma containing the
> - *      area is returned, or the function will return NULL
> - */

RIP our precious diagrams.


