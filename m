Return-Path: <linux-kernel+bounces-554760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF70BA59C05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FE7188BF23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D1F231A2D;
	Mon, 10 Mar 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQxkgCAG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="85K6m8I7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQxkgCAG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="85K6m8I7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8E230BE3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626349; cv=none; b=BkC4jvU/k1A9GgCeH5FIeFSiQrgXhufKbugaM7twLTd0flF6BH28qjLLcRNOrz3pvpLQPMGthnzvuhO9xNaRiv0i6z87vy3JbBTf15+fviXKCfTRL6DRSLae4ALiskyIaXbF2dMqDcNlNgo601XXTSEp06xwS4xPE8Jzj1bI1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626349; c=relaxed/simple;
	bh=VE1nHuTBHfgVtHK7E18WfWiOI9lbOfkW2xsWEsSy868=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utXs6nyrXSdfTXVnKoIdAFGD4yo/A9Zax96okTxsqSoQ1hWU3XTgn+l+2IfLN0o3qncMOe6uqXr8aiwqsTUx1816q8FizAljw5uk6XMC5r+peOvHz8B68iIlH7C1I3LQkGbNvkHCPCtv6xPPYX+rYjGrrMGN4wdhlXa3qGQNTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQxkgCAG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=85K6m8I7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQxkgCAG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=85K6m8I7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 732281F393;
	Mon, 10 Mar 2025 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741626345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUVK4PSDtTInw4WLVNXH/6i877JQkwqlXDUK+gYjdrk=;
	b=HQxkgCAGhV49DLwHV4z4q5PF8gVF1B8X8XS99xYf32LpVM0ha0oFcI2wL1AYe70+wjSjaw
	iM7ra6ukxN4ToQ5VLevInxzeqx6mEno/ZqDutby82gnGkdlXKE6+A5/Re/t010rWLC7wRt
	fFL3o6VWG6zNfsUptdhU22sUGg0Ub/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741626345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUVK4PSDtTInw4WLVNXH/6i877JQkwqlXDUK+gYjdrk=;
	b=85K6m8I7vdlsTJl8+VX/qzQfNLmvzWS+MJ2Xsy2ww2zPEbmUkRC+F1HaAEKWbjMdshwfXj
	PELzHrHHzujcL0BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HQxkgCAG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=85K6m8I7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741626345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUVK4PSDtTInw4WLVNXH/6i877JQkwqlXDUK+gYjdrk=;
	b=HQxkgCAGhV49DLwHV4z4q5PF8gVF1B8X8XS99xYf32LpVM0ha0oFcI2wL1AYe70+wjSjaw
	iM7ra6ukxN4ToQ5VLevInxzeqx6mEno/ZqDutby82gnGkdlXKE6+A5/Re/t010rWLC7wRt
	fFL3o6VWG6zNfsUptdhU22sUGg0Ub/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741626345;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PUVK4PSDtTInw4WLVNXH/6i877JQkwqlXDUK+gYjdrk=;
	b=85K6m8I7vdlsTJl8+VX/qzQfNLmvzWS+MJ2Xsy2ww2zPEbmUkRC+F1HaAEKWbjMdshwfXj
	PELzHrHHzujcL0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D63E139E7;
	Mon, 10 Mar 2025 17:05:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tQl1Fukbz2enagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 17:05:45 +0000
Message-ID: <40d1c30b-f437-4cf5-a37f-2e3084f03086@suse.cz>
Date: Mon, 10 Mar 2025 18:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm/mremap: refactor move_page_tables(),
 abstracting state
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <89f2446f70acd41172dadbb3404db9d95415c78c.1741256580.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <89f2446f70acd41172dadbb3404db9d95415c78c.1741256580.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 732281F393
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 3/6/25 11:34, Lorenzo Stoakes wrote:
> A lot of state is threaded throughout the page table moving logic within
> the mremap code, including boolean values which control behaviour
> specifically in regard to whether rmap locks need be held over the
> operation and whether the VMA belongs to a temporary stack being moved by
> move_arg_pages() (and consequently, relocate_vma_down()).
> 
> As we already transmit state throughout this operation, it is neater and
> more readable to maintain a small state object.  We do so in the form of
> pagetable_move_control.
> 
> In addition, this allows us to update parameters within the state as we
> manipulate things, for instance with regard to the page table realignment
> logic.
> 
> In future I want to add additional functionality to the page table logic,
> so this is an additional motivation for making it easier to do so.
> 
> This patch changes move_page_tables() to accept a pointer to a
> pagetable_move_control struct, and performs changes at this level only.
> Further page table logic will be updated in a subsequent patch.
> 
> We additionally also take the opportunity to add significant comments
> describing the address realignment logic to make it abundantly clear what
> is going on in this code.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below.

> ---
>  mm/internal.h |  46 ++++++++++++--
>  mm/mmap.c     |   5 +-
>  mm/mremap.c   | 172 ++++++++++++++++++++++++++++++++++++--------------
>  3 files changed, 171 insertions(+), 52 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 7a4f81a6edd6..a4608c85a3ba 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -24,6 +24,47 @@
>  
>  struct folio_batch;
>  
> +/*
> + * Maintains state across a page table move. The operation assumes both source
> + * and destination VMAs already exist and are specified by the user.
> + *
> + * Partial moves are permitted, but:
> + *      from_vma->vm_start <= from_addr < from_vma->vm_end - len
> + *      to_vma->vm_start <= to_addr < to_vma->vm_end - len

Should this rather be expressed using the actual field names?

> + *
> + * Must be maintained.
> + *
> + * mmap lock must be held in write and VMA write locks must be held on any VMA
> + * that is visible.
> + *
> + * Use the PAGETABLE_MOVE() macro to initialise this struct.
> + *
> + * NOTE: The page table move is affected by reading from [old_addr, old_end),
> + * and old_addr may be updated for better page table alignment, so len_in
> + * represents the length of the range being copied as specified by the user.
> + */
> +struct pagetable_move_control {
> +	struct vm_area_struct *old; /* Source VMA. */
> +	struct vm_area_struct *new; /* Destination VMA. */
> +	unsigned long old_addr; /* Address from which the move begins. */
> +	unsigned long old_end; /* Exclusive address at which old range ends. */
> +	unsigned long new_addr; /* Address to move page tables to. */
> +	unsigned long len_in; /* Bytes to remap specified by user. */
> +
> +	bool need_rmap_locks; /* Do rmap locks need to be taken? */
> +	bool for_stack; /* Is this an early temp stack being moved? */
> +};
> +
> +#define PAGETABLE_MOVE(name, old_, new_, old_addr_, new_addr_, len_)	\
> +	struct pagetable_move_control name = {				\
> +		.old = old_,						\
> +		.new = new_,						\
> +		.old_addr = old_addr_,					\
> +		.old_end = (old_addr_) + (len_),			\
> +		.new_addr = new_addr_,					\
> +		.len_in = len_,						\
> +	}
> +
>  /*
>   * The set of flags that only affect watermark checking and reclaim
>   * behaviour. This is used by the MM to obey the caller constraints
> @@ -1537,10 +1578,7 @@ extern struct list_lru shadow_nodes;
>  } while (0)
>  
>  /* mremap.c */
> -unsigned long move_page_tables(struct vm_area_struct *vma,
> -	unsigned long old_addr, struct vm_area_struct *new_vma,
> -	unsigned long new_addr, unsigned long len,
> -	bool need_rmap_locks, bool for_stack);
> +unsigned long move_page_tables(struct pagetable_move_control *pmc);
>  
>  #ifdef CONFIG_UNACCEPTED_MEMORY
>  void accept_page(struct page *page);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 15d6cd7cc845..efcc4ca7500d 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1694,6 +1694,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
>  	struct vm_area_struct *next;
>  	struct mmu_gather tlb;
> +	PAGETABLE_MOVE(pmc, vma, vma, old_start, new_start, length);
>  
>  	BUG_ON(new_start > new_end);
>  
> @@ -1716,8 +1717,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	 * move the page tables downwards, on failure we rely on
>  	 * process cleanup to remove whatever mess we made.
>  	 */
> -	if (length != move_page_tables(vma, old_start,
> -				       vma, new_start, length, false, true))
> +	pmc.for_stack = true;
> +	if (length != move_page_tables(&pmc))
>  		return -ENOMEM;
>  
>  	tlb_gather_mmu(&tlb, mm);
> diff --git a/mm/mremap.c b/mm/mremap.c
> index df550780a450..a4b0124528fa 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -580,8 +580,9 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
>   * the VMA that is created to span the source and destination of the move,
>   * so we make an exception for it.
>   */
> -static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
> -			    unsigned long mask, bool for_stack)
> +static bool can_align_down(struct pagetable_move_control *pmc,
> +			   struct vm_area_struct *vma, unsigned long addr_to_align,
> +			   unsigned long mask)
>  {
>  	unsigned long addr_masked = addr_to_align & mask;
>  
> @@ -590,11 +591,11 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
>  	 * of the corresponding VMA, we can't align down or we will destroy part
>  	 * of the current mapping.
>  	 */
> -	if (!for_stack && vma->vm_start != addr_to_align)
> +	if (!pmc->for_stack && vma->vm_start != addr_to_align)
>  		return false;
>  
>  	/* In the stack case we explicitly permit in-VMA alignment. */
> -	if (for_stack && addr_masked >= vma->vm_start)
> +	if (pmc->for_stack && addr_masked >= vma->vm_start)
>  		return true;
>  
>  	/*
> @@ -604,54 +605,131 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
>  	return find_vma_intersection(vma->vm_mm, addr_masked, vma->vm_start) == NULL;
>  }
>  
> -/* Opportunistically realign to specified boundary for faster copy. */
> -static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
> -			     unsigned long *new_addr, struct vm_area_struct *new_vma,
> -			     unsigned long mask, bool for_stack)
> +/*
> + * Determine if are in fact able to realign for efficiency to a higher page
> + * table boundary.
> + */
> +static bool can_realign_addr(struct pagetable_move_control *pmc,
> +			     unsigned long pagetable_mask)
>  {
> +	unsigned long align_mask = ~pagetable_mask;
> +	unsigned long old_align = pmc->old_addr & align_mask;
> +	unsigned long new_align = pmc->new_addr & align_mask;
> +	unsigned long pagetable_size = align_mask + 1;
> +	unsigned long old_align_next = pagetable_size - old_align;
> +
> +	/*
> +	 * We don't want to have to go hunting for VMAs from the end of the old
> +	 * VMA to the next page table boundary, also we want to make sure the
> +	 * operation is wortwhile.
> +	 *
> +	 * So ensure that we only perform this realignment if the end of the
> +	 * range being copied from is at least page table aligned:

AFAIU we need to at least reach (or cross) one page table boundary? Might be
just me, but I'd understand that sentences that it has to be aligned with a
page table boundary, and "at least" just means it can be naturaly aligned
with a higher power-of-two value than the pagetable_size (but doesn't matter).

> +	 *
> +	 * boundary                        boundary
> +	 *    .<- old_align ->                .
> +	 *    .              |----------------.-----------|
> +	 *    .              |          vma   .           |
> +	 *    .              |----------------.-----------|
> +	 *    .              <----------------.----------->
> +	 *    .                          len_in
> +	 *    <------------------------------->
> +	 *    .         pagetable_size        .
> +	 *    .              <---------------->
> +	 *    .                old_align_next .
> +	 */
> +	if (pmc->len_in < old_align_next)
> +		return false;
> +
>  	/* Skip if the addresses are already aligned. */
> -	if ((*old_addr & ~mask) == 0)
> -		return;
> +	if (old_align == 0)
> +		return false;
>  
>  	/* Only realign if the new and old addresses are mutually aligned. */
> -	if ((*old_addr & ~mask) != (*new_addr & ~mask))
> -		return;
> +	if (old_align != new_align)
> +		return false;
>  
>  	/* Ensure realignment doesn't cause overlap with existing mappings. */
> -	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
> -	    !can_align_down(new_vma, *new_addr, mask, for_stack))
> +	if (!can_align_down(pmc, pmc->old, pmc->old_addr, pagetable_mask) ||
> +	    !can_align_down(pmc, pmc->new, pmc->new_addr, pagetable_mask))
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * Opportunistically realign to specified boundary for faster copy.
> + *
> + * Consider an mremap() of a VMA with page table boundaries as below, and no
> + * preceding VMAs from the lower page table boundary to the start of the VMA,
> + * with the end of the range being at least page table aligned:

Same.

> + *
> + *   boundary                        boundary
> + *      .              |----------------.-----------|
> + *      .              |          vma   .           |
> + *      .              |----------------.-----------|
> + *      .         pmc->old_addr         .      pmc->old_end
> + *      .              <---------------------------->
> + *      .                  move these page tables
> + *
> + * If we proceed with moving page tables in this scenario, we will have a lot of
> + * work to do traversing old page tables and establishing new ones in the
> + * destination across multiple lower level page tables.
> + *
> + * The idea here is simply to align pmc->old_addr, pmc->new_addr down to the
> + * page table boundary, so we can simply copy a single page table entry for the
> + * aligned portion of the VMA instead:
> + *
> + *   boundary                        boundary
> + *      .              |----------------.-----------|
> + *      .              |          vma   .           |
> + *      .              |----------------.-----------|
> + * pmc->old_addr                        .      pmc->old_end
> + *      <------------------------------------------->
> + *      .           move these page tables
> + */
> +static void try_realign_addr(struct pagetable_move_control *pmc,
> +			     unsigned long pagetable_mask)
> +{
> +
> +	if (!can_realign_addr(pmc, pagetable_mask))
>  		return;
>  
> -	*old_addr = *old_addr & mask;
> -	*new_addr = *new_addr & mask;
> +	/*
> +	 * Simply align to page table boundaries. Note that we do NOT update the
> +	 * pmc->old_end value, and since the move_page_tables() operation spans

As per this comment about not updating old_end...

> +	 * from [old_addr, old_end) (offsetting new_addr as it is performed),
> +	 * this simply changes the start of the copy, not the end.
> +	 */
> +	pmc->old_addr &= pagetable_mask;
> +	pmc->new_addr &= pagetable_mask;

... and we really don't touch it ...

>  }
>  
> -unsigned long move_page_tables(struct vm_area_struct *vma,
> -		unsigned long old_addr, struct vm_area_struct *new_vma,
> -		unsigned long new_addr, unsigned long len,
> -		bool need_rmap_locks, bool for_stack)
> +unsigned long move_page_tables(struct pagetable_move_control *pmc)
>  {
>  	unsigned long extent, old_end;
>  	struct mmu_notifier_range range;
>  	pmd_t *old_pmd, *new_pmd;
>  	pud_t *old_pud, *new_pud;
> +	unsigned long old_addr, new_addr;
> +	struct vm_area_struct *vma = pmc->old;
>  
> -	if (!len)
> +	if (!pmc->len_in)
>  		return 0;
>  
> -	old_end = old_addr + len;
> -
>  	if (is_vm_hugetlb_page(vma))
> -		return move_hugetlb_page_tables(vma, new_vma, old_addr,
> -						new_addr, len);
> +		return move_hugetlb_page_tables(pmc->old, pmc->new, pmc->old_addr,
> +						pmc->new_addr, pmc->len_in);
>  
>  	/*
>  	 * If possible, realign addresses to PMD boundary for faster copy.
>  	 * Only realign if the mremap copying hits a PMD boundary.
>  	 */
> -	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
> -		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
> -				 for_stack);
> +	try_realign_addr(pmc, PMD_MASK);
> +	/* These may have been changed. */
> +	old_addr = pmc->old_addr;
> +	new_addr = pmc->new_addr;
> +	old_end = pmc->old_end;

... this line seems unnecessary.

>  
>  	flush_cache_range(vma, old_addr, old_end);
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,

