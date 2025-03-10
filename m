Return-Path: <linux-kernel+bounces-554036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B78A59214
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762143B05EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B6228CB5;
	Mon, 10 Mar 2025 10:55:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCCE226D01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604124; cv=none; b=ma/VM81zK8ZkRo+N2zMb+TKjs0qPyVr+WxNayAvxvvM/J3PYsPd5ofFGKYWiccuqaofpsxje8UpHZTF9e3+XcSg5iwKkAGUqdZUKs9XSA+OoxytOetH7fbMqvOoLJYQCtMiYq/xCKuqX+grbf1HKbSgB8Oz5Ib+AkpQfT2qgTbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604124; c=relaxed/simple;
	bh=nVETkI4hsbHPO6L/vVLLdSvKCZk8H9YIi7LVwjeCefA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8PLeQLqSaWsr2om89/b5PrEz4b1aoW2SIvU/chSpJdIkzVGyvosJMgN+GYgh2RgckSQdvGL9aXWmJ0cGW5WUrADmuPkU4V9cdHLHQUUBQZo7fUvhoHIkW8WV4EkNQPrxV5ISJL0IUpfWu5vSD1u41O07jdKV/z7KH4QwqASEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51490153B;
	Mon, 10 Mar 2025 03:55:33 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 930B93F5A1;
	Mon, 10 Mar 2025 03:55:20 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:55:18 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/mm: Create level specific section mappings in
 map_range()
Message-ID: <Z87FFqV03Pd0-NXl@J2N7QTR9R3.cambridge.arm.com>
References: <20250310062812.216031-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310062812.216031-1-anshuman.khandual@arm.com>

On Mon, Mar 10, 2025 at 11:58:12AM +0530, Anshuman Khandual wrote:
> Currently PMD section mapping mask i.e PMD_TYPE_SECT is used while creating
> section mapping at all page table levels except the last level. This works
> fine as the section mapping masks are exactly the same (0x1UL) for all page
> table levels.
> 
> This will change in the future with D128 page tables that have unique skip
> level values (SKL) required for creating section mapping at different page
> table levels. Hence use page table level specific section mapping macros
> instead of the common PMD_TYPE_SECT. While here also ensure that a section
> mapping is only created on page table levels which could support that on a
> given page size configuration otherwise fall back to create table entries.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.14-rc6
> 
> Changes in V2:
> 
> - Dropped PGD_TYPE_SECT macro and its instance from map_range()
> - Create table entries on levels where section mapping is not possible

On the last version, there was talk of an extant bug:

  https://lore.kernel.org/all/5f1b36e2-6455-44d9-97b0-253aefd5024f@arm.com/

... did that turn out to not be the case?

> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20250303041834.2796751-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/kernel/pi/map_range.c | 38 +++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
> index 2b69e3beeef8..25a70c675c4d 100644
> --- a/arch/arm64/kernel/pi/map_range.c
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -11,6 +11,22 @@
>  
>  #include "pi.h"
>  
> +static bool sect_supported(int level)

What exactly is this function supposed to indicate?

Due to the 'default' case, it'll return true for level-3 tables where
sections/blocks aren't possible, but pages are. So maybe this is just
misnamed, and wants to be something like "leaf_supported()" ?

> +{
> +	switch (level) {
> +	case -1:
> +		return false;
> +	case 0:
> +		if (IS_ENABLED(CONFIG_ARM64_16K_PAGES) ||
> +		    IS_ENABLED(CONFIG_ARM64_64K_PAGES))
> +			return false;
> +		else
> +			return true;

Surely:

	case 0:
		return IS_ENABLED(CONFIG_ARM64_4K_PAGES);

... though that's only the case when LPA2 is supported and TCR_ELx.DS is
set.

> +	default:
> +		return true;

As above, what is this supposed to return for level-3 tables where
sections/blocks aren't possible?

Can we BUILD_BUG() for bogus levels?

> +	}
> +}
> +
>  /**
>   * map_range - Map a contiguous range of physical pages into virtual memory
>   *
> @@ -44,13 +60,29 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>  	 * Set the right block/page bits for this level unless we are
>  	 * clearing the mapping
>  	 */
> -	if (protval)
> -		protval |= (level < 3) ? PMD_TYPE_SECT : PTE_TYPE_PAGE;
> +	if (protval && sect_supported(level)) {

The existing code is trying to find the leaf prot for a given level of
table, so as-is checking sect_supported() is at best misleading.

If we're going to do something different below based on
sect_supported(), I reckon this should be moved into the path where
sect_supported() returned true, maybe factored out into a helper for
clarity.

Mark.

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
> +		default:
> +			break;
> +		}
> +	}
>  
>  	while (start < end) {
>  		u64 next = min((start | lmask) + 1, PAGE_ALIGN(end));
>  
> -		if (level < 3 && (start | next | pa) & lmask) {
> +		if ((level < 3 && (start | next | pa) & lmask) || !sect_supported(level)) {
>  			/*
>  			 * This chunk needs a finer grained mapping. Create a
>  			 * table mapping if necessary and recurse.
> -- 
> 2.25.1
> 
> 

