Return-Path: <linux-kernel+bounces-535891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D294A4789A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9830D170DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3101226885;
	Thu, 27 Feb 2025 09:04:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BF015DBB3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647083; cv=none; b=IX0/c+vDyiT8gmEqWxVyGNcgHAYxghcKZkK1ud3XBBiEAtC+ckUxWg1IiOrdPzKzmx75jNfMHK7QqADSqeB5qAHOHV6XK+LuJZSHZAvgvHBD+FfOwoPUMZmWXM/Xkpqc6+FUKIM4CwsWp343xbEZKVAonHh2ucPZHQbiIYXEbCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647083; c=relaxed/simple;
	bh=xvptOGtQKr9XXbqsvYeEB6uyYKobr6bLduc4E6bPfSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqL+dfb6GuTFwj+ShXpv8WKNV1wD3bUKxJ8C0U4qiw5ylwJow37Ut0tusa7zMTQIA4CkxrsLdhtu3laOdAXQpVqM2/64crwzaUDMl5slqRFi1+/WLfFbzzqn/0Z45I90y/TkCFAHpR3Jnq6p3Gay1C+nlI8jlERQcPzkJHNB9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BD812BCA;
	Thu, 27 Feb 2025 01:04:56 -0800 (PST)
Received: from [10.57.85.134] (unknown [10.57.85.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0733F6A8;
	Thu, 27 Feb 2025 01:04:39 -0800 (PST)
Message-ID: <668b7132-0acd-4c2d-9b33-10339d5b3dad@arm.com>
Date: Thu, 27 Feb 2025 09:04:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64/mm: Convert __pte_to_phys() and
 __phys_to_pte_val() as functions
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20250227022412.2015835-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250227022412.2015835-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2025 02:24, Anshuman Khandual wrote:
> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
> respectively as expected. But otherwise without this config being enabled,
> they are defined as macros and their return types are implicit.
> 
> Until now this has worked out correctly as both pte_t and phys_addr_t data
> types have been 64 bits. But with the introduction of 128 bit page tables,
> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
> conversions, which leads to compiler warnings.
> 
> Fix these warnings by converting __pte_to_phys() and __phys_to_pte_val()
> as functions instead where the return types are handled explicitly.
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
> Changes in V2:
> 
> - Changed the helper macros as functions instead per Mark
> - Dropped irrelevant (now) in-code comments per Mark
> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20250219035646.536707-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/include/asm/pgtable.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b2a2ad1b9e8..4ebfa60ea5c6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -68,10 +68,6 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define pte_ERROR(e)	\
>  	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
>  
> -/*
> - * Macros to convert between a physical address and its placement in a
> - * page table entry, taking care of 52-bit addresses.
> - */
>  #ifdef CONFIG_ARM64_PA_BITS_52
>  static inline phys_addr_t __pte_to_phys(pte_t pte)
>  {
> @@ -84,8 +80,15 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
>  }
>  #else
> -#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
> -#define __phys_to_pte_val(phys)	(phys)
> +static inline phys_addr_t __pte_to_phys(pte_t pte)
> +{
> +	return pte_val(pte) & PTE_ADDR_LOW;
> +}
> +
> +static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> +{
> +	return phys;
> +}
>  #endif
>  
>  #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)


