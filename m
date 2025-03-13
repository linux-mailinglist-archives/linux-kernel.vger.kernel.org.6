Return-Path: <linux-kernel+bounces-560427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F6A603FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 23:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F633BF4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AA1F6699;
	Thu, 13 Mar 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gG3BYre5"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C721F4706
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903773; cv=none; b=F5aJBnkIi16w4hLKJNEbYncKfq47fnDkZzB/rHcfi9zBqB6afNpsK8JTjNwZGSIbqlD0ZdM4A1Z0bqd71BOJe+u+kRChxwUFAhpI9QjOVxtOJQMVaH6BzSlLG8SLYWkMSkZeu2lPEXgxGcVfdg3sIQZYT70b8n7SxTVM6Vt2mfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903773; c=relaxed/simple;
	bh=gAXO27EwGSW6fSEusyHnVTHWolGeLHlLrwlCvSny5gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTlyAbDEz6Zwu6A2z5v6V8l9qYgtrX7Y9eOWbVI81TJeId0+6DzvKAa+/5UgIbrxcmx+M7O5pkBXCoAittI5txwOwhL7jeaC++LPDicMT5NEURKBpmeLb48dQQVek5GouXpLzeNJUPotbvOXf4NLTZZIoSV8ouosi8RzAgquTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gG3BYre5; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Mar 2025 22:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741903769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qBTdqPoSu12tr2nwPV4fS9a5AhyEHy3PWKSx5nynuP4=;
	b=gG3BYre5CXeXwVtjnP98NCfeQAW4t3+UtIOii5OAdw77tDTPVXV5nZV50BADminjqDl/Fq
	R01mlCJbe5hRikV+DcZdpDtrpqcpKlXpjTp0oZkRPKyPDbSon+nD9kohRpfn7FjWfctv6n
	dbGl+j3ghGXWqfhaqp2b0sCmu4mj2GA=
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
Subject: Re: [PATCH RFC 03/11] x86/mm: Add lookup_pgtable_in_pgd()
Message-ID: <Z9NXkZ0_5dtqzaUB@google.com>
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
 <20250313-asi-page-alloc-v1-3-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-asi-page-alloc-v1-3-04972e046cea@google.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 13, 2025 at 06:11:22PM +0000, Brendan Jackman wrote:
> This is the same thing as lookup_address_in_pgd(), but it returns the
> pagetable unconditionally instead of returning NULL when the pagetable
> is none. This will be used for looking up and modifying pages that are
> *_none() in order to map memory into the ASI restricted address space.
> 
> For a [PATCH], if this logic is needed, the surrounding code should
> probably first be somewhat refactored. It now looks pretty repetitive,
> and it's confusing that lookup_address_in_pgd() returns NULL when
> pmd_none() but note when pte_none(). For now here's something that
> works.

My first instinct reading this is that lookup_address_in_pgd() should be
calling lookup_pgtable_in_pgd(), but I didn't look too closely.

> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/include/asm/pgtable_types.h |  2 ++
>  arch/x86/mm/pat/set_memory.c         | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 4b804531b03c3ce5cc48f0a75cb75d58b985777a..e09b509e525534f31c986d705e07b25dd9c04cb7 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -572,6 +572,8 @@ extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  				    unsigned int *level);
>  pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
>  				  unsigned int *level, bool *nx, bool *rw);
> +extern pte_t *lookup_pgtable_in_pgd(pgd_t *pgd, unsigned long address,
> +				    unsigned int *level);
>  extern pmd_t *lookup_pmd_address(unsigned long address);
>  extern phys_addr_t slow_virt_to_phys(void *__address);
>  extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index ef4514d64c0524e5854fa106e3f37ff1e1ba10a2..d066bf2c9e93e126757bd32a7a666db89b2488b6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -658,6 +658,40 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  	return new;
>  }
>  
> +/*
> + * Lookup the page table entry for a virtual address in a specific pgd. Return
> + * the pointer to the entry, without implying that any mapping actually exists
> + * (the returned value may be zero).
> + */
> +pte_t *lookup_pgtable_in_pgd(pgd_t *pgd, unsigned long address, unsigned int *level)
> +{
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	*level = PG_LEVEL_256T;
> +	if (pgd_none(*pgd))
> +		return (pte_t *)pgd;
> +
> +	*level = PG_LEVEL_512G;
> +	p4d = p4d_offset(pgd, address);
> +	if (p4d_none(*p4d) || p4d_leaf(*p4d) || !p4d_present(*p4d))
> +		return (pte_t *)p4d;
> +
> +	*level = PG_LEVEL_1G;
> +	pud = pud_offset(p4d, address);
> +	if (pud_none(*pud) || pud_leaf(*pud) || !pud_present(*pud))
> +		return (pte_t *)pud;
> +
> +	*level = PG_LEVEL_2M;
> +	pmd = pmd_offset(pud, address);
> +	if (pmd_none(*pmd) || pmd_leaf(*pmd) || !pmd_present(*pmd))
> +		return (pte_t *)pmd;
> +
> +	*level = PG_LEVEL_4K;
> +	return pte_offset_kernel(pmd, address);
> +}
> +
>  /*
>   * Lookup the page table entry for a virtual address in a specific pgd.
>   * Return a pointer to the entry (or NULL if the entry does not exist),
> 
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 

