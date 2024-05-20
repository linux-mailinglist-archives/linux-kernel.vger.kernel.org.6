Return-Path: <linux-kernel+bounces-183511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAEA8C9A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6753D1F21AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047A1BC57;
	Mon, 20 May 2024 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yfeK3xZa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="beHJCAka";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yfeK3xZa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="beHJCAka"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B898BEA
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716195724; cv=none; b=EYsbJH+xcl6RZEzGJ2y3kNCYIA/0YvxBlcEhSqTCTVIQK0jIWRmomXmGDZZtBGN+dSpdZoDkvsjKWQdJ63+hPz+xOhOjJsyXJkoZ8VgaOKFQCGIB/iVaZgRWQQLuB0cc3xmTeFfJLxW+AD5kvk/FtjicLp6DTdaQn271p+jz1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716195724; c=relaxed/simple;
	bh=nd6Sdw6Wzv+mLck86yc6fY/aMzoLMrIbLOj5jr69ayY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyJp+DhKcpXRpvCH1yqx68wm2xr+6V9zvGQ9YCLYPCoz5kYBZTfPpaR6ZztYRbifnBA5Wj2vz2qZTQhJrXunPGfVNOQTsrtz2o9WxAnpOIywn0ucWqhV7RnBIk1rBcY/E9dNrSS4CHI79TNY0OlW7J/8IoKkpPDXaqmUiSuaVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yfeK3xZa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=beHJCAka; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yfeK3xZa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=beHJCAka; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7EE0933F80;
	Mon, 20 May 2024 09:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716195718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RznT9pQBd9Fh0iNcVSH6bgyJ4u73qu4dxVBlDspeyYU=;
	b=yfeK3xZalU3PM3CfqEQfZ7PScH4IJQm8Ff1zLpThZrOt0B49GKlrz1Cu26Z+Z161WWc1cJ
	T1EmVYv2HtIMUQK1FWf1T7A1V6EJ7t5FBCLa66aGUKqcDQp3gbkl4M6RSfAcSx7hjPp1Yi
	rts+3XZn9Ev3zZox+HBZWE+D6ut+DEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716195718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RznT9pQBd9Fh0iNcVSH6bgyJ4u73qu4dxVBlDspeyYU=;
	b=beHJCAkaif03iXODHYNjL+wPJS7vvO9Cc73xdWp3VtZKqoKRVVjYeyXqGC5OkTGNFsNlrm
	zshuXi1q/F0XleCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yfeK3xZa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=beHJCAka
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716195718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RznT9pQBd9Fh0iNcVSH6bgyJ4u73qu4dxVBlDspeyYU=;
	b=yfeK3xZalU3PM3CfqEQfZ7PScH4IJQm8Ff1zLpThZrOt0B49GKlrz1Cu26Z+Z161WWc1cJ
	T1EmVYv2HtIMUQK1FWf1T7A1V6EJ7t5FBCLa66aGUKqcDQp3gbkl4M6RSfAcSx7hjPp1Yi
	rts+3XZn9Ev3zZox+HBZWE+D6ut+DEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716195718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RznT9pQBd9Fh0iNcVSH6bgyJ4u73qu4dxVBlDspeyYU=;
	b=beHJCAkaif03iXODHYNjL+wPJS7vvO9Cc73xdWp3VtZKqoKRVVjYeyXqGC5OkTGNFsNlrm
	zshuXi1q/F0XleCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F10FE13A21;
	Mon, 20 May 2024 09:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5k5GOIURS2ZUcAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 20 May 2024 09:01:57 +0000
Date: Mon, 20 May 2024 11:01:48 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 01/20] mm: Provide pagesize to pmd_populate()
Message-ID: <ZksRfAXja0fhNePD@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <91159d49bcbee0526ca6235ff7ef1ee7d378d013.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91159d49bcbee0526ca6235ff7ef1ee7d378d013.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7EE0933F80
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Fri, May 17, 2024 at 08:59:55PM +0200, Christophe Leroy wrote:
> Unlike many architectures, powerpc 8xx hardware tablewalk requires
> a two level process for all page sizes, allthough second level only
> has one entry when pagesize is 8M.

So, I went on a quick reading on

https://www.nxp.com/docs/en/application-note-software/AN3066.pdf

to get more insight, and I realized that some of the questions I made
in v1 were quite dump.

> 
> To fit with Linux page table topology and without requiring special
> page directory layout like hugepd, the page entry will be replicated
> 1024 times in the standard page table. However for large pages it is

You only have to replicate 1024 times in case the page size is 4KB, and you
will have to replicate that twice and have 2 PMDs pointing to it, right?

For 16KB, you will have the PMD containing 512 entries of 16KB.

> necessary to set bits in the level-1 (PMD) entry. At the time being,
> for 512k pages the flag is kept in the PTE and inserted in the PMD
> entry at TLB miss exception, that is necessary because we can have

 rlwimi  r11, r10, 32 - 9, _PMD_PAGE_512K
 mtspr   SPRN_MI_TWC, r11

So we shift the value and compare it to _PMD_PAGE_512K to see if the PTE
is a 512K page, and then we set it to SPRN_MI_TWC which I guess is some
CPU special register?

> pages of different sizes in a page table. However the 12 PTE bits are
> fully used and there is no room for an additional bit for page size.

You are referring to the bits in
arch/powerpc/include/asm/nohash/32/pte-8xx.h ?

> For 8M pages, there will be only one page per PMD entry, it is
> therefore possible to flag the pagesize in the PMD entry, with the

I am confused, and it might be just terminology, or I am getting wrong
the design.
You say that for 8MB pages, there will one page per PMD entry, but
based on the above, you will have 1024 entries (replicated)?
So, maybe this wanted to be read as "there will be only one page size per PMD
entry".

> advantage that the information will already be at the right place for
> the hardware.
> 
> To do so, add a new helper called pmd_populate_size() which takes the
> page size as an additional argument, and modify __pte_alloc() to also

"page size" makes me thing of the standart page size the kernel is
operating on (aka PAGE_SIZE), but it is actually the size of the huge
page, so I think we should clarify it.

> take that argument. pte_alloc() is left unmodified in order to
> reduce churn on callers, and a pte_alloc_size() is added for use by
> pte_alloc_huge().
> 
> When an architecture doesn't provide pmd_populate_size(),
> pmd_populate() is used as a fallback.

It is a bit unfortunate that we have to touch the code for other
architectures (in patch#2)

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

So far I only looked at this patch and patch#2, and code-wise looks good and
makes sense,  but I find it a bit unfortunate that we have to touch general
definitons and arch code (done in patch#2 and patch#3), and I hoped we could
somehow isolate this, but I could not think of a way.

I will give it some more though.

> ---
>  include/linux/mm.h | 12 +++++++-----
>  mm/filemap.c       |  2 +-
>  mm/internal.h      |  2 +-
>  mm/memory.c        | 19 ++++++++++++-------
>  mm/pgalloc-track.h |  2 +-
>  mm/userfaultfd.c   |  4 ++--
>  6 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b6bdaa18b9e9..158cb87bc604 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2803,8 +2803,8 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
>  static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
>  #endif
>  
> -int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
> -int __pte_alloc_kernel(pmd_t *pmd);
> +int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long sz);
> +int __pte_alloc_kernel(pmd_t *pmd, unsigned long sz);
>  
>  #if defined(CONFIG_MMU)
>  
> @@ -2989,7 +2989,8 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>  	pte_unmap(pte);					\
>  } while (0)
>  
> -#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
> +#define pte_alloc_size(mm, pmd, sz) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, sz))
> +#define pte_alloc(mm, pmd) pte_alloc_size(mm, pmd, PAGE_SIZE)
>  
>  #define pte_alloc_map(mm, pmd, address)			\
>  	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
> @@ -2998,9 +2999,10 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
>  	(pte_alloc(mm, pmd) ?			\
>  		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
>  
> -#define pte_alloc_kernel(pmd, address)			\
> -	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
> +#define pte_alloc_kernel_size(pmd, address, sz)			\
> +	((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd, sz))? \
>  		NULL: pte_offset_kernel(pmd, address))
> +#define pte_alloc_kernel(pmd, address)	pte_alloc_kernel_size(pmd, address, PAGE_SIZE)
>  
>  #if USE_SPLIT_PMD_PTLOCKS
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 30de18c4fd28..5a783063d1f6 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3428,7 +3428,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
>  	}
>  
>  	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
> -		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
> +		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte, PAGE_SIZE);
>  
>  	return false;
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 07ad2675a88b..4a01bbf55264 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -206,7 +206,7 @@ void folio_activate(struct folio *folio);
>  void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		   struct vm_area_struct *start_vma, unsigned long floor,
>  		   unsigned long ceiling, bool mm_wr_locked);
> -void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
> +void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte, unsigned long sz);
>  
>  struct zap_details;
>  void unmap_page_range(struct mmu_gather *tlb,
> diff --git a/mm/memory.c b/mm/memory.c
> index d2155ced45f8..2a9eba13a95f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -409,7 +409,12 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  	} while (vma);
>  }
>  
> -void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
> +#ifndef pmd_populate_size
> +#define pmd_populate_size(mm, pmdp, pte, sz) pmd_populate(mm, pmdp, pte)
> +#define pmd_populate_kernel_size(mm, pmdp, pte, sz) pmd_populate_kernel(mm, pmdp, pte)
> +#endif
> +
> +void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte, unsigned long sz)
>  {
>  	spinlock_t *ptl = pmd_lock(mm, pmd);
>  
> @@ -429,25 +434,25 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
>  		 * smp_rmb() barriers in page table walking code.
>  		 */
>  		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
> -		pmd_populate(mm, pmd, *pte);
> +		pmd_populate_size(mm, pmd, *pte, sz);
>  		*pte = NULL;
>  	}
>  	spin_unlock(ptl);
>  }
>  
> -int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
> +int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long sz)
>  {
>  	pgtable_t new = pte_alloc_one(mm);
>  	if (!new)
>  		return -ENOMEM;
>  
> -	pmd_install(mm, pmd, &new);
> +	pmd_install(mm, pmd, &new, sz);
>  	if (new)
>  		pte_free(mm, new);
>  	return 0;
>  }
>  
> -int __pte_alloc_kernel(pmd_t *pmd)
> +int __pte_alloc_kernel(pmd_t *pmd, unsigned long sz)
>  {
>  	pte_t *new = pte_alloc_one_kernel(&init_mm);
>  	if (!new)
> @@ -456,7 +461,7 @@ int __pte_alloc_kernel(pmd_t *pmd)
>  	spin_lock(&init_mm.page_table_lock);
>  	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
>  		smp_wmb(); /* See comment in pmd_install() */
> -		pmd_populate_kernel(&init_mm, pmd, new);
> +		pmd_populate_kernel_size(&init_mm, pmd, new, sz);
>  		new = NULL;
>  	}
>  	spin_unlock(&init_mm.page_table_lock);
> @@ -4740,7 +4745,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>  		}
>  
>  		if (vmf->prealloc_pte)
> -			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
> +			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte, PAGE_SIZE);
>  		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
>  			return VM_FAULT_OOM;
>  	}
> diff --git a/mm/pgalloc-track.h b/mm/pgalloc-track.h
> index e9e879de8649..90e37de7ab77 100644
> --- a/mm/pgalloc-track.h
> +++ b/mm/pgalloc-track.h
> @@ -45,7 +45,7 @@ static inline pmd_t *pmd_alloc_track(struct mm_struct *mm, pud_t *pud,
>  
>  #define pte_alloc_kernel_track(pmd, address, mask)			\
>  	((unlikely(pmd_none(*(pmd))) &&					\
> -	  (__pte_alloc_kernel(pmd) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
> +	  (__pte_alloc_kernel(pmd, PAGE_SIZE) || ({*(mask)|=PGTBL_PMD_MODIFIED;0;})))?\
>  		NULL: pte_offset_kernel(pmd, address))
>  
>  #endif /* _LINUX_PGALLOC_TRACK_H */
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 3c3539c573e7..0f129d5c5aa2 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -764,7 +764,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  			break;
>  		}
>  		if (unlikely(pmd_none(dst_pmdval)) &&
> -		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
> +		    unlikely(__pte_alloc(dst_mm, dst_pmd, PAGE_SIZE))) {
>  			err = -ENOMEM;
>  			break;
>  		}
> @@ -1687,7 +1687,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  					err = -ENOENT;
>  					break;
>  				}
> -				if (unlikely(__pte_alloc(mm, src_pmd))) {
> +				if (unlikely(__pte_alloc(mm, src_pmd, PAGE_SIZE))) {
>  					err = -ENOMEM;
>  					break;
>  				}
> -- 
> 2.44.0
> 

-- 
Oscar Salvador
SUSE Labs

