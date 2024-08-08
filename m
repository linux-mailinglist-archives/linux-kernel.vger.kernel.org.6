Return-Path: <linux-kernel+bounces-279881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB4494C2F7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F0D2820E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F318FC79;
	Thu,  8 Aug 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AS1mIAWO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjOLPzme";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AS1mIAWO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjOLPzme"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AC1474B5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135548; cv=none; b=G81RooTG1nW+d3OaDKaVYoVkKSEQApgAgCxOJXYvnFpMeWY208fhI8lPFZmmBn7+m6Z/xlCPG/OGdvalRk649Ym34ICQT27/0kyY4Z3/mlfoE8MrMtVHo5pa492TdibAa31DlS0GoRrjY3mdFrtvDPmTic3JfdkPHlnNNUvj5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135548; c=relaxed/simple;
	bh=f55bI/kqwYGzVVlawZWcfCVIfm3K03qERb2SLGF7+/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nY36O5GZfNXvYicHB8qgmqmsAor23hd6lhr1V78Tepzh0WEW1f9ymGnWmGdHmmxf+hwYYe/JGQDIWEylEZvrrTM/Ea8ZOQ8gkNhUF9IZiMd5sxmOCioBsrR5Jb3eIp8TYC259gfNCHSHyfXKQfDNHY9KuBAmZr+QqIqG75XyWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AS1mIAWO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mjOLPzme; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AS1mIAWO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mjOLPzme; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BFD01FDDE;
	Thu,  8 Aug 2024 16:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723135544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=POKu9ZF71zcsnFMH56yxbe2fQdWo2yDk2azcKAelAls=;
	b=AS1mIAWOymaXHgbUKc23qZWTqjfpDJHNah3AUZrKsj8gnhCvT4ggy8YqWiCSFNY1e2EOKf
	mSge1pP+GGM4cGseofditO/w3M7Gf1Xnzdbr0ptheO3Z1A6UYORIQsvp598MFPsKczmwAe
	DamiSFxLDEnf3m7GqK9abwBdBNyxAC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723135544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=POKu9ZF71zcsnFMH56yxbe2fQdWo2yDk2azcKAelAls=;
	b=mjOLPzmebbF+6ZjsZCKNjkfXMsaPgbRebBtJkC4eCoRBzQ4giLD0AEtto5meMWO4FEjRBS
	a5o1xqNkCLvltfAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AS1mIAWO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mjOLPzme
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723135544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=POKu9ZF71zcsnFMH56yxbe2fQdWo2yDk2azcKAelAls=;
	b=AS1mIAWOymaXHgbUKc23qZWTqjfpDJHNah3AUZrKsj8gnhCvT4ggy8YqWiCSFNY1e2EOKf
	mSge1pP+GGM4cGseofditO/w3M7Gf1Xnzdbr0ptheO3Z1A6UYORIQsvp598MFPsKczmwAe
	DamiSFxLDEnf3m7GqK9abwBdBNyxAC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723135544;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=POKu9ZF71zcsnFMH56yxbe2fQdWo2yDk2azcKAelAls=;
	b=mjOLPzmebbF+6ZjsZCKNjkfXMsaPgbRebBtJkC4eCoRBzQ4giLD0AEtto5meMWO4FEjRBS
	a5o1xqNkCLvltfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BB4E13876;
	Thu,  8 Aug 2024 16:45:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G05kBjj2tGZ1MgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 08 Aug 2024 16:45:44 +0000
Message-ID: <28774b9d-b74e-4028-acef-5d4f09a5d36a@suse.cz>
Date: Thu, 8 Aug 2024 18:45:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 2BFD01FDDE
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,oracle.com:email];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On 8/5/24 14:13, Lorenzo Stoakes wrote:
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

That's really great, but it would be even better if these code moves could
be a separate patch as it would make reviewing so much easier. But with git
diff's --color-moved to the rescue, let me try...

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

Can this even succeed if we don't update vmg->vm_flags? Previously the
wrapper would take them from vma.

> +
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput

<snip>

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

Should we be paranoid and assert something?

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

OK that's perhaps not that obvious, as it seems copy_vma() is doing some
special dance to ensure this. Should we add it to the ASSUMPTIONS and assert
it, or is there a maple tree operation we can do to ensure it, ideally if
it's very cheap if the iterator is already set the way we want it to be?

> +		next = vmg->next = vma_next(vmg->vmi);
> +		prev = vmg->prev = vma_prev(vmg->vmi);
> +
> +		/* Avoid maple tree re-walk. */
> +		if (is_special && prev)
> +			vma_iter_next_range(vmg->vmi);

I wish I knew what this did but seems it's the same as the old code did so
hopefully that's fine.

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

Sigh... ditto.


