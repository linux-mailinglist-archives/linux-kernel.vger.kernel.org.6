Return-Path: <linux-kernel+bounces-544931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF20A4E6DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F356617F805
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F79281525;
	Tue,  4 Mar 2025 16:21:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313AB281504
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105280; cv=none; b=LUGBN7PmO/CPpPSUehJriuE9+bt8aQNM/8BPjM3J1TgIq2Cj4h1sB4qvObn4jSgLD5ZEu07l1c9EGnILpHePj8lwxUeHub8PDvju3SRNIIDRsAmncULgIlGHPMETgb9DAFXpUb4UzPaDxxqyPNTpxKrM50qjQ7u3C9DivxkSk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105280; c=relaxed/simple;
	bh=HOB40YNB3movA1j5WqK+Y5VJgaJCzQ8fnZhdiCuUbf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeKKe48O06zSfPPWSxAPIKf2cp9GpfM9VghhvYVocPmICKKoaxtHFBGJeNgfZrukUfSOLET9E/2fLuWDwWppT/liueuWmvoP7yoi0McalXTVGNntLJzgc9uEvWXc2kK1qj5k4/SzwjYoGRcU4hL5u4waGqlB9vymlExB3kV2B5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A0A2F;
	Tue,  4 Mar 2025 08:21:32 -0800 (PST)
Received: from [10.57.83.152] (unknown [10.57.83.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA73C3F5A1;
	Tue,  4 Mar 2025 08:21:16 -0800 (PST)
Message-ID: <0fe6f3b2-1011-4418-bc19-612a3b98c78d@arm.com>
Date: Tue, 4 Mar 2025 16:21:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Create level specific section mappings in
 map_range()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20250303041834.2796751-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250303041834.2796751-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 04:18, Anshuman Khandual wrote:
> Currently PMD section mapping mask i.e PMD_TYPE_SECT is used while creating
> section mapping at all page table levels except the last level. This works
> fine as the section mapping masks are exactly the same (0x1UL) for all page
> table levels.
> 
> This will change in the future with D128 page tables that have unique skip
> level values (SKL) required for creating section mapping at different page
> table levels. Hence use page table level specific section mapping macros
> instead of the common PMD_TYPE_SECT.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on 6.14-rc5
> 
> PGD_TYPE_SECT for level -1 section map handling has been added for 4K
> base pages with 52 bit VA configuration that has 5 page table levels.
> In such cases (CONFIG_PGTABLE_LEVELS = 5) early_map_kernel() can call
> map_range() eventually with -1 (i.e 4 - CONFIG_PGTABLE_LEVELS) as the
> root_level.

Table Table D8-16 on page D8-6459 of ARM DDI 0487 L.a says that block mappings
at level -1 are not permitted for 4K pages; only levels 0-3 support leaf
mappings. Similarly for 16K, table D8-26 says only levels 1-3 permit leaf
mappings. And for 64K, table D8-35 says only levels 1-3 permit leaf mappings.

So I don't think PGD_TYPE_SECT is the right solution. Perhaps we need to
explicitly force the unsupported levels to be table entries even if the
alignment is correct?

Thanks,
Ryan

> 
>  arch/arm64/include/asm/pgtable-hwdef.h |  1 +
>  arch/arm64/kernel/pi/map_range.c       | 23 +++++++++++++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index a9136cc551cc..fd0a82e8878c 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -99,6 +99,7 @@
>  #define PGD_TYPE_TABLE		(_AT(pgdval_t, 3) << 0)
>  #define PGD_TABLE_BIT		(_AT(pgdval_t, 1) << 1)
>  #define PGD_TYPE_MASK		(_AT(pgdval_t, 3) << 0)
> +#define PGD_TYPE_SECT		(_AT(pgdval_t, 1) << 0)
>  #define PGD_TABLE_AF		(_AT(pgdval_t, 1) << 10)	/* Ignored if no FEAT_HAFT */
>  #define PGD_TABLE_PXN		(_AT(pgdval_t, 1) << 59)
>  #define PGD_TABLE_UXN		(_AT(pgdval_t, 1) << 60)
> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
> index 2b69e3beeef8..9ea869f5745f 100644
> --- a/arch/arm64/kernel/pi/map_range.c
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -44,8 +44,27 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>  	 * Set the right block/page bits for this level unless we are
>  	 * clearing the mapping
>  	 */
> -	if (protval)
> -		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
> +	if (protval) {
> +		switch (level) {
> +		case 3:
> +			protval |= PTE_TYPE_PAGE;
> +			break;
> +		case 2:
> +			protval |= PMD_TYPE_SECT;
> +			break;
> +		case 1:
> +			protval |= PUD_TYPE_SECT;
> +			break;
> +		case 0:
> +			protval |= P4D_TYPE_SECT;
> +			break;
> +		case -1:
> +			protval |= PGD_TYPE_SECT;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
>  
>  	while (start < end) {
>  		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));


