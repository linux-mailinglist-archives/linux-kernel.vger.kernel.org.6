Return-Path: <linux-kernel+bounces-560434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A43A60417
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2907A6628
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE61F78E4;
	Thu, 13 Mar 2025 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xFmDbVvP"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F721F755E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904083; cv=none; b=qSCjPDU+oN11rVVZZT3bovzc5WKqys338ABpMyb3I3dQ7XrwRbZQohaOZUKe1Hy1cucOVCiEOn9uXQSAaU+B8A65Fi6ZArK/75PngDh8SnlszGsK1XWEU9N3Db3ZSjAZGVcaSodcUrd1suxG2ik01I/WZPoTA8SzZyq4zg54Qi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904083; c=relaxed/simple;
	bh=ku1ly/TmO2rEjXkIldgzqpfcKqAO/upWyLE8A4ObjCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+rfUYLBANeIiFtLDkf0lj5aJHYahLtDK8OBBCpTZzDU2oPbY6TPGiDeL8OwFp/+2VDbQpAOrXcte7fgC2JPZ3z9vhMbtYD13AKdORpKwNn2AnjOgfJcp4Fl56TjFs6s7GEdDBqHDUAx76PyKj7r+PqEuZABGvgYiVYPJgJfT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xFmDbVvP; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 22:14:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741904078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Npr/cUIIYWR/85K080G5nKt+OjIIIOTfx94wcR18LVc=;
	b=xFmDbVvPphctBosBzvM979mTso0RgFOaEA3DyTg65gQd1tE4NIULTMn8RFTdqlaY2eWCkB
	BPQg0g7SeQR/KxY4IAb5EW6pfpG0G7ccdbtR0GCTbLbvo+WfU70moz+3Brg7xUZNTnLMl8
	z/u3gTifoalhWTJ/rLHfOycqaLv4XU8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Junaid Shahid <junaids@google.com>,
	Reiji Watanabe <reijiw@google.com>,
	Patrick Bellasi <derkling@google.com>
Subject: Re: [PATCH RFC 02/11] x86/mm: Factor out phys_pgd_init()
Message-ID: <Z9NYyW_CMoL008cK@google.com>
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
 <20250313-asi-page-alloc-v1-2-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-asi-page-alloc-v1-2-04972e046cea@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 13, 2025 at 06:11:21PM +0000, Brendan Jackman wrote:
> __kernel_physical_mapping_init() will soon need to work on multiple
> PGDs, so factor out something similar to phys_p4d_init() and friends,
> which takes the base of the PGD as an argument.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/mm/init_64.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 01ea7c6df3036bd185cdb3f54ddf244b79cbce8c..8f75274fddd96b8285aff48493ebad93e30daebe 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -731,21 +731,20 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
>  }
>  
>  static unsigned long __meminit
> -__kernel_physical_mapping_init(unsigned long paddr_start,
> -			       unsigned long paddr_end,
> -			       unsigned long page_size_mask,
> -			       pgprot_t prot, bool init)
> +phys_pgd_init(pgd_t *pgd_page, unsigned long paddr_start, unsigned long paddr_end,
> +	      unsigned long page_size_mask, pgprot_t prot, bool init, bool *pgd_changed)
>  {
> -	bool pgd_changed = false;
>  	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
>  
> +	*pgd_changed = false;
> +
>  	paddr_last = paddr_end;
>  	vaddr = (unsigned long)__va(paddr_start);
>  	vaddr_end = (unsigned long)__va(paddr_end);
>  	vaddr_start = vaddr;
>  
>  	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
> -		pgd_t *pgd = pgd_offset_k(vaddr);
> +		pgd_t *pgd = pgd_offset_pgd(pgd_page, vaddr);
>  		p4d_t *p4d;
>  
>  		vaddr_next = (vaddr & PGDIR_MASK) + PGDIR_SIZE;
> @@ -771,15 +770,29 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
>  					  (pud_t *) p4d, init);
>  
>  		spin_unlock(&init_mm.page_table_lock);
> -		pgd_changed = true;
> +		*pgd_changed = true;
>  	}
>  
> -	if (pgd_changed)
> -		sync_global_pgds(vaddr_start, vaddr_end - 1);
> -
>  	return paddr_last;
>  }
>  
> +static unsigned long __meminit
> +__kernel_physical_mapping_init(unsigned long paddr_start,
> +			       unsigned long paddr_end,
> +			       unsigned long page_size_mask,
> +			       pgprot_t prot, bool init)
> +{
> +	bool pgd_changed;
> +	unsigned long paddr_last;
> +
> +	paddr_last = phys_pgd_init(init_mm.pgd, paddr_start, paddr_end, page_size_mask,
> +				   prot, init, &pgd_changed);
> +	if (pgd_changed)
> +		sync_global_pgds((unsigned long)__va(paddr_start),
> +				 (unsigned long)__va(paddr_end) - 1);

This patch keeps the sync_global_pgds() in
__kernel_physical_mapping_init(), then a following patch adds it back in
phys_pgd_init() (but still leaves it here).

Should we just leave sync_global_pgds() in phys_pgd_init() and eliminate
the pgd_changed argument?

> +
> +	return paddr_last;
> +}
>  
>  /*
>   * Create page table mapping for the physical memory for specific physical
> 
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

