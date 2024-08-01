Return-Path: <linux-kernel+bounces-271447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC7944E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832FC1C21861
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A48170858;
	Thu,  1 Aug 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmLkxTzN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7AA13791C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523609; cv=none; b=EEJCTmeLpNqVAN7wZBDeXLKzg3USVwC5JmW1AM17S3PcyVJ7ta3I+rGcqbBCls4HWa6nYLqXFOHtoKBtWIgUQMoNldzNgjLAcGyMtDw+R2NxH3ENhypY1+US5DyWkHt6jNzck7tDDOmYj+1Pcr4wEzMKMRaE2/u7O9yIOGWGFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523609; c=relaxed/simple;
	bh=bPcFST2ekcj/0v3/PDTDbdq3NIbOxwJ+hdiAsR0MKy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gErnKE1pi+pemW77jQhWxHwJrytWV+iCAd+xE9qk0ZCJJ41KUGv2bHnbCnYTSbvIpa0mY9Kl482QFYEE9dN9IyO8U9zkG6QNeE6FG4cQavoX90xXPNquIPKo3FPUnMIQD9sR2gOjG/PJGnhf2QnBn+pyiykgrEHP5+9nTIOjKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmLkxTzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C21DC32786;
	Thu,  1 Aug 2024 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523608;
	bh=bPcFST2ekcj/0v3/PDTDbdq3NIbOxwJ+hdiAsR0MKy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmLkxTzNBqt4gBpX3zxyLTxZ/eVW2SKiUcxfyw0NRd92KVj52HjXCK8hQnFTf1tpw
	 ejmB78g3/8lQoXF9/YiL7GTQmrs2uzMbEMgrJlOE4OWpDz/xjNxTFcDkkNZisPm5Ja
	 sRbUaaKXnTLpqUtY7plE1maySZxJwybt54lo9eVLwwTevUD+U/br2sJWiVXCfP2DXQ
	 Tt16/z2hsLJWwoH9uXP+uN37naXI96+YhqBc+cwsR2PpQVYS8BCa4AYDpg/laxdPcm
	 nr/RU1dkIk+CYWwQVbzJmfxn5RRKfbTFlD87EbKDOzVeFutlXTMSAu7UP0IdDA8O9F
	 B9/w7SrcZ/FOw==
Date: Thu, 1 Aug 2024 15:46:43 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
Message-ID: <20240801144643.GA4980@willie-the-truck>
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
 <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
 <20240801113440.GB4476@willie-the-truck>
 <c65c0bcc-149e-4f30-9bab-e5377230d2cd@arm.com>
 <20240801132326.GA4794@willie-the-truck>
 <b0a34ffa-5a5e-4048-8b44-ff2c9510ec9a@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a34ffa-5a5e-4048-8b44-ff2c9510ec9a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 01, 2024 at 03:07:31PM +0100, Ryan Roberts wrote:
> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
> index 5410b2cac5907..3f6c5717ff782 100644
> --- a/arch/arm64/kernel/pi/map_range.c
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -55,13 +55,14 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>                          * This chunk needs a finer grained mapping. Create a
>                          * table mapping if necessary and recurse.
>                          */
> -                       if (pte_none(*tbl)) {
> -                               *tbl = __pte(__phys_to_pte_val(*pte) |
> -                                            PMD_TYPE_TABLE | PMD_TABLE_UXN);
> +                       if (pte_none(__ptep_get(tbl))) {
> +                               __set_pte_nosync(tbl,
> +                                            __pte(__phys_to_pte_val(*pte) |
> +                                            PMD_TYPE_TABLE | PMD_TABLE_UXN));
>                                 *pte += PTRS_PER_PTE * sizeof(pte_t);
>                         }
>                         map_range(pte, start, next, pa, prot, level + 1,
> -                                 (pte_t *)(__pte_to_phys(*tbl) + va_offset),
> +                                 (pte_t *)(__pte_to_phys(__ptep_get(tbl)) + va_offset),
>                                   may_use_cont, va_offset);
>                 } else {
>                         /*
> @@ -79,7 +80,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>                                 protval &= ~PTE_CONT;
>  
>                         /* Put down a block or page mapping */
> -                       *tbl = __pte(__phys_to_pte_val(pa) | protval);
> +                       __set_pte_nosync(tbl, __pte(__phys_to_pte_val(pa) | protval));
>                 }
>                 pa += next - start;
>                 start = next;

That looks good to me!

Will

