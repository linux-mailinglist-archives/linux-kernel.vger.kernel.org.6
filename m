Return-Path: <linux-kernel+bounces-189277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F78CEDDB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0281C20D01
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE57F5CB8;
	Sat, 25 May 2024 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l1u02PQ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/P4sqCWy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l1u02PQ7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/P4sqCWy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09A6F9C1
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716611394; cv=none; b=FGseYRFlBS0G5IbVWE/9p8nkWYwH2g4MF8BJpVJrkMhik16+scVyW2cK6nbFllFKIXWOVRcS9Ul8VO0a+DWnVUjr6c005HEQuSm9fC6fOIOrKaOpfOynGqnuhQVvsEfZCgTP2qVPQGAkciCc8FZEWmCsbwaLzCu9z1sQM4pfd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716611394; c=relaxed/simple;
	bh=bH985PCkjrHThWH40dgoTwSqL8js44GHRYc/HN2XcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg1qHeB9PhUNkJw9AMaYH2B6wdNbeki216dQInQVIDCfyOce21R/jBBZGQ85AkCRkkPZgjXenkqIUs7lN8CiQAY5yASNzc0a8/cFYrjCVw2kCyJgSUl23Fs7Bg9ypuqImKc9tNp1WQJSX6KEt2fZ+JJM87l4uCjQOux+ekdmvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l1u02PQ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/P4sqCWy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l1u02PQ7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/P4sqCWy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B90FE210B7;
	Sat, 25 May 2024 04:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716611390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jMHt0Q/JR84IkdUwzp1Rd4JSoh8dVTU4aWoOj2QTcg=;
	b=l1u02PQ7mUeizPUtziKZMSjLfSDrBiAuCREz31HsHEIKq6Y05wZ/ksZDnm96yJCEyTPp89
	s+woPlXhybRjXGtzwwPgGx4OyhUH2WiS/97dN6hchsbJ593I1ri2VE0E9y1EHydxnEf6Jq
	zRIaWjIMf0LqWRyNkCQmi3MLLt8gtr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716611390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jMHt0Q/JR84IkdUwzp1Rd4JSoh8dVTU4aWoOj2QTcg=;
	b=/P4sqCWykN268llQRDZDNDK/3U5kd/JdBzk4bO/RCBrUwi8Yi3n/+zg7ms3JYCFIumrcNw
	wnHCd3Mdif0hhBDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716611390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jMHt0Q/JR84IkdUwzp1Rd4JSoh8dVTU4aWoOj2QTcg=;
	b=l1u02PQ7mUeizPUtziKZMSjLfSDrBiAuCREz31HsHEIKq6Y05wZ/ksZDnm96yJCEyTPp89
	s+woPlXhybRjXGtzwwPgGx4OyhUH2WiS/97dN6hchsbJ593I1ri2VE0E9y1EHydxnEf6Jq
	zRIaWjIMf0LqWRyNkCQmi3MLLt8gtr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716611390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0jMHt0Q/JR84IkdUwzp1Rd4JSoh8dVTU4aWoOj2QTcg=;
	b=/P4sqCWykN268llQRDZDNDK/3U5kd/JdBzk4bO/RCBrUwi8Yi3n/+zg7ms3JYCFIumrcNw
	wnHCd3Mdif0hhBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F5F513A6B;
	Sat, 25 May 2024 04:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vwuLDD5pUWaVPAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Sat, 25 May 2024 04:29:50 +0000
Date: Sat, 25 May 2024 06:29:48 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 11/20] powerpc/mm: Complement huge_pte_alloc() for
 all non HUGEPD setups
Message-ID: <ZlFpPBlLoBZNjd73@localhost.localdomain>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <59a1390923c40b0b83ae062e3041873292186577.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a1390923c40b0b83ae062e3041873292186577.1715971869.git.christophe.leroy@csgroup.eu>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,nvidia.com,redhat.com,ellerman.id.au,gmail.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]

On Fri, May 17, 2024 at 09:00:05PM +0200, Christophe Leroy wrote:
> huge_pte_alloc() for non-HUGEPD targets is reserved for 8xx at the
> moment. In order to convert other targets for non-HUGEPD, complement
> huge_pte_alloc() to support any standard cont-PxD setup.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 42b12e1ec851..f8aefa1e7363 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -195,11 +195,34 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>  		      unsigned long addr, unsigned long sz)
>  {
> -	pmd_t *pmd = pmd_off(mm, addr);
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	addr &= ~(sz - 1);
> +	pgd = pgd_offset(mm, addr);
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (sz >= PGDIR_SIZE)
> +		return (pte_t *)p4d;
> +
> +	pud = pud_alloc(mm, p4d, addr);
> +	if (!pud)
> +		return NULL;
> +	if (sz >= PUD_SIZE)
> +		return (pte_t *)pud;
> +
> +	pmd = pmd_alloc(mm, pud, addr);
> +	if (!pmd)
> +		return NULL;
>  
>  	if (sz < PMD_SIZE)
>  		return pte_alloc_huge(mm, pmd, addr, sz);
>  
> +	if (!IS_ENABLED(CONFIG_PPC_8xx))
> +		return (pte_t *)pmd;

So only 8xx has cont-PMD for hugepages?

> +
>  	if (sz != SZ_8M)
>  		return NULL;

Since this function is the core for allocation huge pages, I think it would
benefit from a comment at the top explaining the possible layouts.
e.g: Who can have cont-{P4d,PUD,PMD} etc.
A brief explanation of the possible scheme for all powerpc platforms.

That would help people looking into this in a future.

 

-- 
Oscar Salvador
SUSE Labs

