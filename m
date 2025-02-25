Return-Path: <linux-kernel+bounces-531693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A404FA443A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2FEF179BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CC260A54;
	Tue, 25 Feb 2025 14:54:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A72C21ABDE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495281; cv=none; b=slhjagVoMHNg5FECJI95rMNUaVpDx5wZyGdm7k3xJtsd7UoUDPy+uulWOp5fCQJQ0ulhAkzTQ4uTVtW0WII7ZepbSr2+m4JjXaaRAGWP4yJHjgRDMIDrIVdCQ57OC0r/7QdFS1f1mcy7s/0s48hiThWmx/08yok0t7sAuw/okUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495281; c=relaxed/simple;
	bh=kwTo9338g4qpp97NasrZXAc4mVGqCi372qG39LHHeU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKVR2CTib0lw0mkNwFxoH7EnlsV+FhgEfJMJrxNelHausFwCJ5gyLf8bT4IYqMVegfopUmQ1qOhCPhaV9dX8OU8l6LqMiTr9d62/+0PJMi3gW21Yy0TiDUX3N73IneYXnoaFs2NzVqA/1klpSBsP7X/oBd8mlIPp+B5SOcfh1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC1CB1BCB;
	Tue, 25 Feb 2025 06:54:54 -0800 (PST)
Received: from [10.1.27.154] (XHFQ2J9959.cambridge.arm.com [10.1.27.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABFED3F5A1;
	Tue, 25 Feb 2025 06:54:37 -0800 (PST)
Message-ID: <5edf6a80-1fbd-4be2-912b-497c044ba0f8@arm.com>
Date: Tue, 25 Feb 2025 14:54:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm64/hugetlb: Consistently use pud_sect_supported()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250220050534.799645-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250220050534.799645-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2025 05:05, Anshuman Khandual wrote:
> Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
> Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.
> Also re-arranged the switch statement for a common warning message.

Thanks, Anshuman, this looks much cleaner now, to my eye at least.

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> This patch applies on v6.14-rc3
> 
> Changes in V3:
> 
> - Re-arranged the switch statement for a common warning message per Ryan
> 
> Changes in V2:
> 
> https://lore.kernel.org/linux-arm-kernel/20250218113639.475947-1-anshuman.khandual@arm.com/
> 
> - Added an warning when PUD_SIZE is requested but not supported per Ryan
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-arm-kernel/20250217065414.49489-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/mm/hugetlbpage.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 98a2a0e64e25..fd7448bb8c80 100644
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
> @@ -364,23 +366,21 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
>  	switch (pagesize) {
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	case PUD_SIZE:
> -		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
> +		if (pud_sect_supported())
> +			return pud_pte(pud_mkhuge(pte_pud(entry)));
>  		break;
>  #endif
>  	case CONT_PMD_SIZE:
> -		entry = pmd_pte(pmd_mkcont(pte_pmd(entry)));
> -		fallthrough;
> +		return pmd_pte(pmd_mkhuge(pmd_mkcont(pte_pmd(entry))));
>  	case PMD_SIZE:
> -		entry = pmd_pte(pmd_mkhuge(pte_pmd(entry)));
> -		break;
> +		return pmd_pte(pmd_mkhuge(pte_pmd(entry)));
>  	case CONT_PTE_SIZE:
> -		entry = pte_mkcont(entry);
> -		break;
> +		return pte_mkcont(entry);
>  	default:
> -		pr_warn("%s: unrecognized huge page size 0x%lx\n",
> -			__func__, pagesize);
>  		break;
>  	}
> +	pr_warn("%s: unrecognized huge page size 0x%lx\n",
> +		__func__, pagesize);
>  	return entry;
>  }
>  


