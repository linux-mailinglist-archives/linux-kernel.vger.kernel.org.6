Return-Path: <linux-kernel+bounces-519573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E0A39E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B93A2962
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8967269AEC;
	Tue, 18 Feb 2025 14:02:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7712E5B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887323; cv=none; b=WpENm4/upt+itsr6q/E3kIQgDFCxGU+NcGmopFZvxn57k01WPmMjpBOxNjPn/nFk8k7lZ63nrv1UexSvt5gzWQqTZSuoGt3ETpbhw9hZnSxwS5trPDBEXqzoKMkXoxNljt/BFhmHRLS/JnKzcgZu2D2Jf3/9YYYFHKehK3aTtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887323; c=relaxed/simple;
	bh=t4yvbProIBa4JikwnFX0aydQLrsW23WO4MfvXtRpRzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbaKLAI5WC3UrnK1qhUwRL8cnDWQpd4HpfbztjXd0MTV+pE5Xwt0vuXrJMNF+JG7tnZBSyb0AX/N6fYXm33QtU+oRh6ljxqRvGgLa4/82kJTNK7YIpJdJ/XnY62r/EHNJ00JsbaDkX3JbgeegmKOqj7ncLuRNRsfZjbw/JG/djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D16152B;
	Tue, 18 Feb 2025 06:02:20 -0800 (PST)
Received: from [10.1.27.186] (XHFQ2J9959.cambridge.arm.com [10.1.27.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 623173F6A8;
	Tue, 18 Feb 2025 06:02:00 -0800 (PST)
Message-ID: <0ad8b31e-f1f1-426d-89e8-a21cf72814d1@arm.com>
Date: Tue, 18 Feb 2025 14:01:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64/hugetlb: Consistently use pud_sect_supported()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250218113639.475947-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250218113639.475947-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 11:36, Anshuman Khandual wrote:
> Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
> Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.14-rc3
> 
> Changes in V2:
> 
> - Added an warning when PUD_SIZE is requested but not supported per Ryan
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20250217065414.49489-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/mm/hugetlbpage.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 98a2a0e64e25..1d89599a20d7 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -342,7 +342,9 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
>  	switch (hp_size) {
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	case PUD_SIZE:
> -		return PGDIR_SIZE - PUD_SIZE;
> +		if (pud_sect_supported())
> +			return PGDIR_SIZE - PUD_SIZE;
> +		break;
>  #endif
>  	case CONT_PMD_SIZE:
>  		return PUD_SIZE - CONT_PMD_SIZE;
> @@ -364,7 +366,10 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
>  	switch (pagesize) {
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	case PUD_SIZE:
> -		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
> +		if (pud_sect_supported())
> +			entry = pud_pte(pud_mkhuge(pte_pud(entry)));
> +		else
> +			pr_warn("%s: pud huge page not supported\n", __func__);
>  		break;
>  #endif
>  	case CONT_PMD_SIZE:

Personally, I think something like this is cleaner than having 2 warnings:

pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
{
	size_t pagesize = 1UL << shift;

	switch (pagesize) {
#ifndef __PAGETABLE_PMD_FOLDED
	case PUD_SIZE:
		if (pud_sect_supported())
			return pud_pte(pud_mkhuge(pte_pud(entry)));
		break;
#endif
	case CONT_PMD_SIZE:
		return pmd_pte(pmd_mkhuge(pmd_mkcont(pte_pmd(entry))));
	case PMD_SIZE:
		return pmd_pte(pmd_mkhuge(pte_pmd(entry)));
	case CONT_PTE_SIZE:
		return pte_mkcont(entry);
	}

	pr_warn("%s: unrecognized huge page size 0x%lx\n",
		__func__, pagesize);
	return entry;
}

Thanks,
Ryan




