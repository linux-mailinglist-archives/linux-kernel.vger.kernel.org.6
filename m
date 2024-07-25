Return-Path: <linux-kernel+bounces-262050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA57393BFFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5106AB20A71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B5A198E79;
	Thu, 25 Jul 2024 10:37:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531EA16A95E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903821; cv=none; b=AA7e/Uo96UNKoGRUWGADSk5C+Kw7KObdegIzDNRBEDcgAygsCyH/Y6GrkBp1S2bApbBTEJ6ccmZebIyLSNVzh/PCRMPgOkiydDNGMHFPNQnmARMUkRoDa9SGPf8Hm06McxiH/Ftm15YaOXLBlQWW/3c4K+SvfuDWASb0onlJuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903821; c=relaxed/simple;
	bh=H0I/yiSy9stYV0gliOGZ+tl7BrjqtDL9q14N/wtYX48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkHiwjkVrDTqBypSkPLOa3QcT6clSRz3xJQjcsXFrdjtQWlvJzGsPPc7OjI4G9zqrm46Ltqgu/nQRotVE+u70xEPzNKYIzhZtZFzI3vTEr9jkItf1KjfxUmzW5HfEkVC0Wrw+E1/0j0Gz74cGVopnmcXIsgSCkJoQK0OAzFn35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AEF81007;
	Thu, 25 Jul 2024 03:37:24 -0700 (PDT)
Received: from [10.1.25.164] (XHFQ2J9959.cambridge.arm.com [10.1.25.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B533F73F;
	Thu, 25 Jul 2024 03:36:57 -0700 (PDT)
Message-ID: <3e82687a-0183-42f3-b32c-6d99dbd4fe49@arm.com>
Date: Thu, 25 Jul 2024 11:36:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Avoid direct referencing page table enties in
 map_range()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240725091052.314750-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240725091052.314750-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2024 10:10, Anshuman Khandual wrote:
> Like else where in arm64 platform, use WRITE_ONCE() in map_range() while
> creating page table entries. This avoids referencing page table entries
> directly.

I could be wrong, but I don't think this code is ever operating on live
pgtables? So there is never a potential to race with the HW walker and therefore
no need to guarrantee copy atomicity? As long as the correct barriers are placed
at the point where you load the pgdir into the TTBRx there should be no problem?

If my assertion is correct, I don't think there is any need for this change.

Thanks,
Ryan

> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kernel/pi/map_range.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_range.c
> index 5410b2cac590..b93b70cdfb62 100644
> --- a/arch/arm64/kernel/pi/map_range.c
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -56,8 +56,8 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>  			 * table mapping if necessary and recurse.
>  			 */
>  			if (pte_none(*tbl)) {
> -				*tbl = __pte(__phys_to_pte_val(*pte) |
> -					     PMD_TYPE_TABLE | PMD_TABLE_UXN);
> +				WRITE_ONCE(*tbl, __pte(__phys_to_pte_val(*pte) |
> +					   PMD_TYPE_TABLE | PMD_TABLE_UXN));
>  				*pte += PTRS_PER_PTE * sizeof(pte_t);
>  			}
>  			map_range(pte, start, next, pa, prot, level + 1,
> @@ -79,7 +79,7 @@ void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t prot,
>  				protval &= ~PTE_CONT;
>  
>  			/* Put down a block or page mapping */
> -			*tbl = __pte(__phys_to_pte_val(pa) | protval);
> +			WRITE_ONCE(*tbl, __pte(__phys_to_pte_val(pa) | protval));
>  		}
>  		pa += next - start;
>  		start = next;


