Return-Path: <linux-kernel+bounces-347239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E398CFD9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8777AB24242
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4719752C;
	Wed,  2 Oct 2024 09:13:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8712DD90
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860430; cv=none; b=oCapL13bDXLsvJCwPwoPe9LdTZsBwIpBDwlNQjt8rNp68W6y08NmLlRF45XgDYd8Q46s8JdBIavCjzjzd5yY3vfw9UV7zULlrPvGfsOCXTpLRWs3mmsQF7ONFH6DvoEczkzbGsQ5QoNoDniUqXHgTkYn/znS62PRRNMgzPViM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860430; c=relaxed/simple;
	bh=2rwen1jwKCCp1M1dxSFuK26FZBWHtKzNP2x8T326z14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJDvh4jqwK5NXWDCIjT4N+DQU/CBs0oJ+xUX6EKo/0a/pwKCZRVMF3bacme2RpqDovc/cEUMJM72USZt9r90e4BEJd4WGHSiY4kdjA3AqaotdK2zbYoFxqqJMDNHq4Kc+PQ/MKsiwMOi6st2d9UM3fDJDxDtkjuuuSC/7szN8C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE57339;
	Wed,  2 Oct 2024 02:14:17 -0700 (PDT)
Received: from [10.57.85.161] (unknown [10.57.85.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B84E3F64C;
	Wed,  2 Oct 2024 02:13:46 -0700 (PDT)
Message-ID: <91fa29e9-0659-4837-8261-d8b2865e6132@arm.com>
Date: Wed, 2 Oct 2024 10:13:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Change pgattr_change_is_safe() arguments as
 pteval_t
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20241001045804.1119881-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241001045804.1119881-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2024 05:58, Anshuman Khandual wrote:
> pgattr_change_is_safe() processes two distinct page table entries that just
> happen to be 64 bits for all levels. This changes both arguments to reflect
> the actual data type being processed in the function.
> 
> This change is important when moving to FEAT_D128 based 128 bit page tables
> because it makes it simple to change the entry size in one place.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
> This applies on v6.12-rc1
> 
>  arch/arm64/include/asm/pgtable.h | 2 +-
>  arch/arm64/mm/mmu.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index c329ea061dc9..d56dbe5742d6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -338,7 +338,7 @@ static inline pte_t __ptep_get(pte_t *ptep)
>  }
>  
>  extern void __sync_icache_dcache(pte_t pteval);
> -bool pgattr_change_is_safe(u64 old, u64 new);
> +bool pgattr_change_is_safe(pteval_t old, pteval_t new);
>  
>  /*
>   * PTE bits configuration in the presence of hardware Dirty Bit Management
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e55b02fbddc8..c1b2d0dc3078 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -119,7 +119,7 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
>  	return phys;
>  }
>  
> -bool pgattr_change_is_safe(u64 old, u64 new)
> +bool pgattr_change_is_safe(pteval_t old, pteval_t new)
>  {
>  	/*
>  	 * The following mapping attributes may be updated in live


