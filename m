Return-Path: <linux-kernel+bounces-396267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF11B9BCA6D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC52D28226A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5D1D2F40;
	Tue,  5 Nov 2024 10:25:14 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B41D172E;
	Tue,  5 Nov 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802313; cv=none; b=bwUAPKYd2JRnI/E5guaKyMQByYAtDVZyusodCp7mgmi3YhDu6t/OSrAoxUyhu3snJ0QEpiz1ueH8u2Yi3xah0jLEz/gIli7GnIHPAsfx60Ax/r1Q3VAlUPV9OjNtXHj+FDVeT3qKncyMqq48FUbmM6WA4SKRLp4D9e2349ILrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802313; c=relaxed/simple;
	bh=QVUkwht/xWpq92kIukVXo0he5+GPnoOxldCinZkMzao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rrq/FmJhQvYuzj1AHz+to1zMi1UReE65vbqLDFNTbEpPZSS5sXy3+szRLm6sYZ4Sbwt79jKtkL0OgpxjYQVKV44FjJk1RMqYObhaaDKOHlqPNl1t/rApbMto7jnvNtRR8k1Hj4RqyfEVI3UnEEHE0FGWUAbVG2/qS6gvXi8YGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E22181C0003;
	Tue,  5 Nov 2024 10:25:01 +0000 (UTC)
Message-ID: <38936e70-e293-446a-8efc-208d52e42573@ghiti.fr>
Date: Tue, 5 Nov 2024 11:25:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] riscv: mm: Increment PFN in place when splitting
 mappings
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
 <20241102000843.1301099-3-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241102000843.1301099-3-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 02/11/2024 01:07, Samuel Holland wrote:
> The current code separates page table entry values into a PFN and a
> pgprot_t before incrementing the PFN and combining the two parts using
> pfn_pXX(). On some hardware with custom page table formats or memory
> aliases, the pfn_pXX() functions need to transform the PTE value, so
> these functions would need to apply the opposite transformation when
> breaking apart the PTE value.
>
> However, both transformations can be avoided by incrementing the PFN in
> place, as done by pte_advance_pfn() and set_ptes().
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/mm/pageattr.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 271d01a5ba4d..335060adc1a6 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -109,9 +109,8 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
>   			continue;
>   
>   		if (pmd_leaf(pmdp_get(pmdp))) {
> +			pte_t pte = pmd_pte(pmdp_get(pmdp));
>   			struct page *pte_page;
> -			unsigned long pfn = _pmd_pfn(pmdp_get(pmdp));
> -			pgprot_t prot = __pgprot(pmd_val(pmdp_get(pmdp)) & ~_PAGE_PFN_MASK);
>   			pte_t *ptep_new;
>   			int i;
>   
> @@ -121,7 +120,7 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
>   
>   			ptep_new = (pte_t *)page_address(pte_page);
>   			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
> -				set_pte(ptep_new, pfn_pte(pfn + i, prot));
> +				set_pte(ptep_new, pte_advance_pfn(pte, i));
>   
>   			smp_wmb();
>   
> @@ -149,9 +148,8 @@ static int __split_linear_mapping_pud(p4d_t *p4dp,
>   			continue;
>   
>   		if (pud_leaf(pudp_get(pudp))) {
> +			pmd_t pmd = __pmd(pud_val(pudp_get(pudp)));


Nit: You could use pud_pte() here.


>   			struct page *pmd_page;
> -			unsigned long pfn = _pud_pfn(pudp_get(pudp));
> -			pgprot_t prot = __pgprot(pud_val(pudp_get(pudp)) & ~_PAGE_PFN_MASK);
>   			pmd_t *pmdp_new;
>   			int i;
>   
> @@ -162,7 +160,8 @@ static int __split_linear_mapping_pud(p4d_t *p4dp,
>   			pmdp_new = (pmd_t *)page_address(pmd_page);
>   			for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new)
>   				set_pmd(pmdp_new,
> -					pfn_pmd(pfn + ((i * PMD_SIZE) >> PAGE_SHIFT), prot));
> +					__pmd(pmd_val(pmd) +
> +					      (i << (PMD_SHIFT - PAGE_SHIFT + PFN_PTE_SHIFT))));


Nit: Here you could use pte_advance_pfn(pmd, i << (PMD_SHIFT - PAGE_SHIFT))


>   
>   			smp_wmb();
>   
> @@ -198,9 +197,8 @@ static int __split_linear_mapping_p4d(pgd_t *pgdp,
>   			continue;
>   
>   		if (p4d_leaf(p4dp_get(p4dp))) {
> +			pud_t pud = __pud(p4d_val(p4dp_get(p4dp)));
>   			struct page *pud_page;
> -			unsigned long pfn = _p4d_pfn(p4dp_get(p4dp));
> -			pgprot_t prot = __pgprot(p4d_val(p4dp_get(p4dp)) & ~_PAGE_PFN_MASK);
>   			pud_t *pudp_new;
>   			int i;
>   
> @@ -215,7 +213,8 @@ static int __split_linear_mapping_p4d(pgd_t *pgdp,
>   			pudp_new = (pud_t *)page_address(pud_page);
>   			for (i = 0; i < PTRS_PER_PUD; ++i, ++pudp_new)
>   				set_pud(pudp_new,
> -					pfn_pud(pfn + ((i * PUD_SIZE) >> PAGE_SHIFT), prot));
> +					__pud(pud_val(pud) +
> +					      (i << (PUD_SHIFT - PAGE_SHIFT + PFN_PTE_SHIFT))));


Nit: Ditto


>   
>   			/*
>   			 * Make sure the pud filling is not reordered with the


Other than the nits (which are up to you), you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


