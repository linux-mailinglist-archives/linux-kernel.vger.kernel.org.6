Return-Path: <linux-kernel+bounces-193799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE98D324B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323121C2102B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607717DE3E;
	Wed, 29 May 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dMCs+LZL"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A417DE35
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972567; cv=none; b=aGCfUmaqTzJn85yHsPhwUM7dLteu2qOzD1GrM1krkVq4FNMJra5j3+aVAWFnWZhoJbJiqXuK/DT5Y2C9QzDS9vWWKgpOY7Z1rwIvjbs2fNwB/OwiPcWQu0T2F0LfdBT9oAwx7Kim2cjgrgd2gOZp3T4IOh7c6IZk2xelClk/ykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972567; c=relaxed/simple;
	bh=k7a95+P/NbOROPAvPPuhIB2E9FBcq3UKkzYM6RI0xlY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY2oHxytbBTfmLDiX1cFoV0maVTYyhZXGD5wzVy42I/vfCtzpoHXfxBWkUlw1vucFAiUbiQgr8Rjw1wfrRL5xiMcSyP1bItE7KWyQVT3J7KB3rkQQBH6hUQNU/BxIJRYs0LFR9lteVfAmSdvs37+ux77JFYjES2VuvNnpjljxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dMCs+LZL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4202ca70318so15682045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716972563; x=1717577363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FqWscTuoS7Z7zXndqslsCK2s/b+E7GOJQ0fFCGFa0k=;
        b=dMCs+LZLPuRdel3OoFTpYsxNIuPu2OvG3TzIbvwFdRu12ot6SDH2zuleRmBC7UbX/i
         YnAkZZleTVDi/wYSBPFq08ldADZU0lXDPLb/6TmccsCRYl56FRmnIvnT24mknDs4zrsB
         h4yw5J8YhYKYUReM2POGVyEcgS2VgnJNNR8bx7VrXQDWhqVjLciAqV/XKmbS2kShMj8u
         bxE1rnMTboMfeCePFuLMmUlPiKohOx61A+ildvxeeDYRPaJjVskPdvct96eJOFwHUnw7
         yNA1OOeONjj3GbaWM2isMjhHXVSinRsl0V+bLpBxICtLvOmXOyKwOlYjMkYK1LwFzLE4
         VNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716972563; x=1717577363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FqWscTuoS7Z7zXndqslsCK2s/b+E7GOJQ0fFCGFa0k=;
        b=RcgqSRper2RPJZ6rG5EBvc9lHqHPO00NsyAMpMNC3UNbfNEeG9rPuwq4hHfJzbNOc1
         8VB+7r4/PdSAbwzBRpAZIw7jaj+rpF/f7BZUHyKLsXjWC2jNoAkhh3qEyiMg6OOi50di
         Y4KpMHM1niemueTV3+EWdFfazopSoEBQ3BbWcGkp1Y5ztqr35mvbpUSqS1qN8oW1u1CL
         776/G7qLR0AvMfCmwDt7OCIxYLfeFoLqLOdSV1jiVBaCHwet7Mt53epADEy5It8ItSwt
         MzbDVJuciGxoOQCgzxGPoqnQM6L1/M1Gt52jOFLaykr7ST+JQVw8a+Vx849xnkuO0+5X
         iRQg==
X-Forwarded-Encrypted: i=1; AJvYcCUhxMzx8QeOXch6VmRh+nDnWsyCzwDReMqLsve2JT58kHQQiyBZ6gr496IvGQGrerWiov0yuhAy+AWLBONq6aZ5FqYqg9eLBBiNoM0j
X-Gm-Message-State: AOJu0YxDdDK2vU+xJIaEK06HPOUXusjumYc/CYD8lK1wiXflvEeHoXok
	k7w0yOe86iLTRDJEjTnZiWZoqxfZw9VGyiJB3QQ/JjkQq+JwsH+LnRU/N+a6At0=
X-Google-Smtp-Source: AGHT+IFirCm930ok6c0waccClyLojOOhDizCBj1LVv0U/qJp1ipt5v04MsZ7oUfrdlcX266KE3FIUw==
X-Received: by 2002:a05:600c:224e:b0:420:fb99:ed02 with SMTP id 5b1f17b1804b1-421089b2283mr134252545e9.6.1716972563537;
        Wed, 29 May 2024 01:49:23 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee806esm204152935e9.3.2024.05.29.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:49:23 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 10:49:21 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 13/16] powerpc/e500: Use contiguous PMD instead of
 hugepd
Message-ID: <ZlbsEb_T2eQYO-g4@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <56cf925576285e2b97550f4f7317183d98d596c5.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cf925576285e2b97550f4f7317183d98d596c5.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:11PM +0200, Christophe Leroy wrote:
> e500 supports many page sizes among which the following size are
> implemented in the kernel at the time being: 4M, 16M, 64M, 256M, 1G.
> 
> On e500, TLB miss for hugepages is exclusively handled by SW even
> on e6500 which has HW assistance for 4k pages, so there are no
> constraints like on the 8xx.
> 
> On e500/32, all are at PGD/PMD level and can be handled as
> cont-PMD.
> 
> On e500/64, smaller ones are on PMD while bigger ones are on PUD.
> Again, they can easily be handled as cont-PMD and cont-PUD instead
> of hugepd.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

..

> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index 90d6a0943b35..f7421d1a1693 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -52,11 +52,36 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>  {
>  	pte_basic_t old = pte_val(*p);
>  	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
> +	unsigned long sz;
> +	unsigned long pdsize;
> +	int i;
>  
>  	if (new == old)
>  		return old;
>  
> -	*p = __pte(new);
> +#ifdef CONFIG_PPC_E500
> +	if (huge)
> +		sz = 1UL << (((old & _PAGE_HSIZE_MSK) >> _PAGE_HSIZE_SHIFT) + 20);
> +	else

I think this will not compile when CONFIG_PPC_85xx && !CONFIG_PTE_64BIT.

You have declared _PAGE_HSIZE_MSK and _PAGE_HSIZE_SHIFT in
arch/powerpc/include/asm/nohash/hugetlb-e500.h.

But hugetlb-e500.h is only included if CONFIG_PPC_85xx && CONFIG_PTE_64BIT
(see arch/powerpc/include/asm/nohash/32/pgtable.h).



> +#endif
> +		sz = PAGE_SIZE;
> +
> +	if (!huge || sz < PMD_SIZE)
> +		pdsize = PAGE_SIZE;
> +	else if (sz < PUD_SIZE)
> +		pdsize = PMD_SIZE;
> +	else if (sz < P4D_SIZE)
> +		pdsize = PUD_SIZE;
> +	else if (sz < PGDIR_SIZE)
> +		pdsize = P4D_SIZE;
> +	else
> +		pdsize = PGDIR_SIZE;
> +
> +	for (i = 0; i < sz / pdsize; i++, p++) {
> +		*p = __pte(new);
> +		if (new)
> +			new += (unsigned long long)(pdsize / PAGE_SIZE) << PTE_RPN_SHIFT;

I guess 'new' can be 0 if pte_update() is called on behave of clearing the pte?

> +static inline unsigned long pmd_leaf_size(pmd_t pmd)
> +{
> +	return 1UL << (((pmd_val(pmd) & _PAGE_HSIZE_MSK) >> _PAGE_HSIZE_SHIFT) + 20);

Can we have the '20' somewhere defined with a comment on top explaining
what is so it is not a magic number?
Otherwise people might come look at this and wonder why 20.

> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -331,6 +331,37 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
>  		__set_huge_pte_at(pmdp, ptep, pte_val(pte));
>  	}
>  }
> +#elif defined(CONFIG_PPC_E500)
> +void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
> +		     pte_t pte, unsigned long sz)
> +{
> +	unsigned long pdsize;
> +	int i;
> +
> +	pte = set_pte_filter(pte, addr);
> +
> +	/*
> +	 * Make sure hardware valid bit is not set. We don't do
> +	 * tlb flush for this update.
> +	 */
> +	VM_WARN_ON(pte_hw_valid(*ptep) && !pte_protnone(*ptep));
> +
> +	if (sz < PMD_SIZE)
> +		pdsize = PAGE_SIZE;
> +	else if (sz < PUD_SIZE)
> +		pdsize = PMD_SIZE;
> +	else if (sz < P4D_SIZE)
> +		pdsize = PUD_SIZE;
> +	else if (sz < PGDIR_SIZE)
> +		pdsize = P4D_SIZE;
> +	else
> +		pdsize = PGDIR_SIZE;
> +
> +	for (i = 0; i < sz / pdsize; i++, ptep++, addr += pdsize) {
> +		__set_pte_at(mm, addr, ptep, pte, 0);
> +		pte = __pte(pte_val(pte) + ((unsigned long long)pdsize / PAGE_SIZE << PFN_PTE_SHIFT));

You can use pte_advance_pfn() here? Just give have

 nr = (unsigned long long)pdsize / PAGE_SIZE << PFN_PTE_SHIFT)
 pte_advance_pfn(pte, nr)

Which 'sz's can we have here? You mentioned that e500 support:

4M, 16M, 64M, 256M, 1G.

which of these ones can be huge?


-- 
Oscar Salvador
SUSE Labs

