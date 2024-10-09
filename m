Return-Path: <linux-kernel+bounces-357125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53534996BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E26E1C22692
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59358198833;
	Wed,  9 Oct 2024 13:29:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5766C1946C8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480546; cv=none; b=hOmm72CrLuKiEIIbbTGtzbjYniUQPjPO6OMwpKilP/KFOZXuk0Zkqde0kPEJJ6FL7Ppx5VACrT9d2ECDawB2n/1UtiKp/NrduDue0jXh0v2oe8ed3r488mkW63j3cxXtxZ25ff6JY2sL1mOBX/f9bmc6xDlr38034HQyzQVh4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480546; c=relaxed/simple;
	bh=kI/2lUP6V098Gjqk2OdjqkFXKZ3ZoNxj1KHuBGHUCZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F56es6/Bzvv7gSMBURV0G458NaqGFYW9RLAFC8/nPc9GIkAY6pu2sCsZ/l9Rac2wCrT6r3CADcBHYnqUAq9E9YZ4HtPZmFLIv5Xo4+lvKwdKgvm3TSu8XNVdljUqV/+jO7Nyxl6JM9XnuT7Oo1ts0KxJSoufc3zKOEjXZOVh3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61EB7FEC;
	Wed,  9 Oct 2024 06:29:32 -0700 (PDT)
Received: from [10.57.85.216] (unknown [10.57.85.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5273B3F58B;
	Wed,  9 Oct 2024 06:29:01 -0700 (PDT)
Message-ID: <bb1dcfcf-302a-4932-a0d5-3abf5ed958c5@arm.com>
Date: Wed, 9 Oct 2024 14:28:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64/mm: Replace PXD_TABLE_BIT with
 PXD_TYPE_[MASK|SECT]
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241005123824.1366397-1-anshuman.khandual@arm.com>
 <20241005123824.1366397-3-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241005123824.1366397-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2024 13:38, Anshuman Khandual wrote:
> This modifies existing block mapping related helpers e.g [pmd|pud]_mkhuge()
> , mk_[pmd|pud]_sect_prot() and pmd_trans_huge() to use PXD_TYPE_[MASK|SECT]
> instead of corresponding PXD_TABLE_BIT. This also moves pmd_sect() earlier
> for the symbol's availability preventing a build warning.
> 
> While here this also drops pmd_val() check from pmd_trans_huge() helper, as
> pmd_present() returning true already ensures that pmd_val() cannot be false
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index fa4c32a9f572..45c49c5ace80 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -484,12 +484,12 @@ static inline pmd_t pte_pmd(pte_t pte)
>  
>  static inline pgprot_t mk_pud_sect_prot(pgprot_t prot)
>  {
> -	return __pgprot((pgprot_val(prot) & ~PUD_TABLE_BIT) | PUD_TYPE_SECT);
> +	return __pgprot((pgprot_val(prot) & ~PUD_TYPE_MASK) | PUD_TYPE_SECT);
>  }
>  
>  static inline pgprot_t mk_pmd_sect_prot(pgprot_t prot)
>  {
> -	return __pgprot((pgprot_val(prot) & ~PMD_TABLE_BIT) | PMD_TYPE_SECT);
> +	return __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
>  }
>  
>  static inline pte_t pte_swp_mkexclusive(pte_t pte)
> @@ -554,10 +554,13 @@ static inline int pmd_protnone(pmd_t pmd)
>   * THP definitions.
>   */
>  
> +#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> +				 PMD_TYPE_SECT)
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline int pmd_trans_huge(pmd_t pmd)
>  {
> -	return pmd_val(pmd) && pmd_present(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
> +	return pmd_present(pmd) && pmd_sect(pmd);

Bug? Prevously we would have returned true for a "present-invalid" PMD block
mapping - that's one which is formatted as a PMD block mapping except the
PTE_VALID bit is clear and PTE_PRESENT_INVALID is set. But now, due to
pmd_sect() testing VALID is set (via PMD_TYPE_SECT), we no longer return true in
this case.

>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> @@ -586,7 +589,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
>  
>  #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
>  
> -#define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
> +#define pmd_mkhuge(pmd)		(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))

I'm not sure if this also suffers from a similar problem? Is it possible that a
present-invalid pmd would be passed to pmd_mkhuge()? If so, then we are now
incorrectly setting the PTE_VALID bit.

>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
> @@ -614,7 +617,7 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
>  #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
>  #define pud_write(pud)		pte_write(pud_pte(pud))
>  
> -#define pud_mkhuge(pud)		(__pud(pud_val(pud) & ~PUD_TABLE_BIT))
> +#define pud_mkhuge(pud)		(__pud((pud_val(pud) & ~PUD_TYPE_MASK) | PUD_TYPE_SECT))
>  
>  #define __pud_to_phys(pud)	__pte_to_phys(pud_pte(pud))
>  #define __phys_to_pud_val(phys)	__phys_to_pte_val(phys)
> @@ -712,8 +715,6 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  
>  #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
>  				 PMD_TYPE_TABLE)
> -#define pmd_sect(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
> -				 PMD_TYPE_SECT)
>  #define pmd_leaf(pmd)		(pmd_present(pmd) && !pmd_table(pmd))
>  #define pmd_bad(pmd)		(!pmd_table(pmd))
>  


