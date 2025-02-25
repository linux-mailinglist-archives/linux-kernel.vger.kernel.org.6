Return-Path: <linux-kernel+bounces-531353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3305A43F71
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF18A1783CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E8B268C48;
	Tue, 25 Feb 2025 12:32:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D252264A62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486730; cv=none; b=SefQYPq7TV7xu0Z76Ic+oxqRnNaEZ2NIUEiBMyC5NaimGvREnOsCU6GveCJFiLbD2uoafpdD7HeDfuSQen3nrUvA+ciNiQWuW5n0VQ51oXDb04WnIcRef/BROJTaOY5WuS/Glii9zSRqmkaWr1J3rgyxtO5S04+jG9QiMEDe7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486730; c=relaxed/simple;
	bh=QpXoEDkYKpSmRt4xZzQ8pfU/exILKuqfy05zUgcayWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGTg0eeh9t1l+NOM1eSKchinx6INQEvUex8A7POzN2RF8Ouml4K5PQf72iRo5rSWue32mZocO3qzYuiFBz5AbR5L5AuTqy6uQvSFk9A8GFSQwBD7uX5yNxzbiR2I+CXAgw8UbzEyhSuza9xFdVhwMMOy/3D++iRzBEC/f8Ok23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA16152B;
	Tue, 25 Feb 2025 04:32:23 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32AEF3F6A8;
	Tue, 25 Feb 2025 04:32:06 -0800 (PST)
Date: Tue, 25 Feb 2025 12:32:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Explicit cast conversions to correct data type
Message-ID: <Z724Q1ofM1GvKquV@J2N7QTR9R3>
References: <20250219035646.536707-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219035646.536707-1-anshuman.khandual@arm.com>

On Wed, Feb 19, 2025 at 09:26:46AM +0530, Anshuman Khandual wrote:
> From: Ryan Roberts <ryan.roberts@arm.com>
> 
> When CONFIG_ARM64_PA_BITS_52 is enabled, page table helpers __pte_to_phys()
> and __phys_to_pte_val() are functions which return phys_addr_t and pteval_t
> respectively as expected. But otherwise without this config being enabled,
> they are defined as macros and their return types are implicit.
> 
> Until now this has worked out correctly as both pte_t and phys_addr_t data
> types have been 64 bits. But with the introduction of 128 bit page tables,
> pte_t becomes 128 bits. Hence this ends up with incorrect widths after the
> conversions, which leads to compiler warnings.

Does 128-bit page table not imply 52-bit PAs?

> Fix the warnings by explicitly casting to the correct type after doing the
> conversion.

I think it would be simpler and clearer if we replaced the macros with
functions, such that __pte_to_phys() and __phys_to_pte_val() are
*always* functions.

That way it's easier to compar the CONFIG_ARM64_PA_BITS_52=y and
CONFIG_ARM64_PA_BITS_52=n versions, and the types are always explciit
for inputs and outputs, so there'd be less room for error and the
compiler can warn us of type safety issues in any configuration.

That and we can delete the comment block immediately above at the same
time.

Mark.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.14-rc3
> 
>  arch/arm64/include/asm/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b2a2ad1b9e8..1da2421c9a15 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -84,8 +84,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  	return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PHYS_TO_PTE_ADDR_MASK;
>  }
>  #else
> -#define __pte_to_phys(pte)	(pte_val(pte) & PTE_ADDR_LOW)
> -#define __phys_to_pte_val(phys)	(phys)
> +#define __pte_to_phys(pte)	((phys_addr_t)(pte_val(pte) & PTE_ADDR_LOW))
> +#define __phys_to_pte_val(phys)	((pteval_t)(phys))
>  #endif
>  
>  #define pte_pfn(pte)		(__pte_to_phys(pte) >> PAGE_SHIFT)
> -- 
> 2.25.1
> 
> 

