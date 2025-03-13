Return-Path: <linux-kernel+bounces-559968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C7A5FBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240723B44DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0D6269CFA;
	Thu, 13 Mar 2025 16:29:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EC26982E;
	Thu, 13 Mar 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883343; cv=none; b=APPLmG7VW1JpydiMZY/97TuesQa7R8U0My7GMsvFyKBUFOAnNDKe/qDz8fOrvcSZekWIuOnJBsFjtbT43vnVJLUFI8qy/gXhvoLDhgmkRdVyr3/3PHpSslovO5DtkYDcrYKtfK71XueeEj9HIhknfPf1bVawumZzWJ55uy//l4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883343; c=relaxed/simple;
	bh=NT4jGTTmiz6wkbXW+MpDmX8tCpRmVutU/KZBtD+OnKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BzmuPpv/xdNwmXxXB9nUZeS5BVhSiwOPfVpJUcP0LQXYLSyL922mtd5LnPEu1QbnYE6/zBzF48Sbpvd9mOtKy1b/htevW4mX57anj3xh38S9yyGn78JMTRZHQfDnWAr53uWo+pQJVsuvOxLKqvNMpZr3kyZf7AzPS83MD9akssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D877150C;
	Thu, 13 Mar 2025 09:29:11 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B746E3F673;
	Thu, 13 Mar 2025 09:28:56 -0700 (PDT)
Message-ID: <548e5f51-a622-4117-a2b0-07947e5887db@arm.com>
Date: Thu, 13 Mar 2025 16:28:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
 oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, shameerali.kolothum.thodi@huawei.com,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-5-miko.lenczewski@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250313104111.24196-5-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2025 10:41, Mikołaj Lenczewski wrote:
> When converting a region via contpte_convert() to use mTHP, we have two
> different goals. We have to mark each entry as contiguous, and we would
> like to smear the dirty and young (access) bits across all entries in
> the contiguous block. Currently, we do this by first accumulating the
> dirty and young bits in the block, using an atomic
> __ptep_get_and_clear() and the relevant pte_{dirty,young}() calls,
> performing a tlbi, and finally smearing the correct bits across the
> block using __set_ptes().
> 
> This approach works fine for BBM level 0, but with support for BBM level
> 2 we are allowed to reorder the tlbi to after setting the pagetable
> entries. This reordering reduces the likelyhood of a concurrent page
> walk finding an invalid (not present) PTE. This reduces the likelyhood
> of a fault in other threads, and improves performance marginally
> (more so when there are more threads).

Just to add some extra clarity for the sake of the review; we expect that the
cost of the tlbi(s) is much greater than the cost of clearing and re-setting the
ptes. So by moving the tlbi(s) outside of the window where the ptes are invalid
(as bbml2 permits us to do) we greatly reduce the duration where the ptes are
invalid and therefore greatly reduce the chances of another thread taking a
fault on the temporarily invalid address...

> 
> If we support bbml2 without conflict aborts however, we can avoid the
> final flush altogether and have hardware manage the tlb entries for us.
> Avoiding flushes is a win.

...But because we are only allow-listing bbml2 implementations that don't raise
a conflict abort and instead automatically invalidate the conflicting entries in
HW, we can avoid that tlbi altogether.

> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/mm/contpte.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 55107d27d3f8..77ed03b30b72 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -68,7 +68,8 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>  			pte = pte_mkyoung(pte);
>  	}
>  
> -	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
> +	if (!system_supports_bbml2_noabort())
> +		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>  
>  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>  }


