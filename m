Return-Path: <linux-kernel+bounces-427436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B129E00F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C9F161E22
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE31FE467;
	Mon,  2 Dec 2024 11:53:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6617E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140384; cv=none; b=dFDx2XL24aoSRPAlCYJGlZXFNCbcNJ7Nxhl4UOenX10fSP8KgmTx8UEyA78uv6ZSkLOnQi7HgRwsFQMZM01sTNwWwcJnPvIl6l7BPTh9G0ZxXOAwcZfKLoOhvuQw7JlWurKrcZUKW1y2Za2gK9OcDQ7dmxWEx0hSxqdbzePnWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140384; c=relaxed/simple;
	bh=Xt/0t58FKvJceXc3aqmmxvUoDg8V+abO/PMTjDaRVtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMN1aQGoVXt1AsWmANZHsA5+iwEr2QSjB+wP7VidAKb2AvueEx1quvJLFWJJZdbNPItwrbo76qA5QduWXIZ/JSsL3E9+a3MgmkP4dMyigGFqltP0QKOU5iFKwFYFSjJf5y4c66gQyYaZ8RsHKyIg1h7RRfEuo9QJjmcAGeFmOQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 992A4FEC;
	Mon,  2 Dec 2024 03:53:30 -0800 (PST)
Received: from [10.57.93.76] (unknown [10.57.93.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 295DE3F58B;
	Mon,  2 Dec 2024 03:53:01 -0800 (PST)
Message-ID: <7c49fa2c-b732-4b82-a853-22fdf241d361@arm.com>
Date: Mon, 2 Dec 2024 11:52:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Ensure adequate HUGE_MAX_HSTATE
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org
References: <20241202064407.53807-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241202064407.53807-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 06:44, Anshuman Khandual wrote:
> This asserts that HUGE_MAX_HSTATE is sufficient enough preventing potential
> hugetlb_max_hstate runtime overflow in hugetlb_add_hstate() thus triggering
> a BUG_ON() there after.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.13-rc1
> 
>  arch/arm64/mm/hugetlbpage.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 3215adf48a1b..98a2a0e64e25 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -519,6 +519,18 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>  
>  static int __init hugetlbpage_init(void)
>  {
> +	/*
> +	 * HugeTLB pages are supported on maximum four page table
> +	 * levels (PUD, CONT PMD, PMD, CONT PTE) for a given base
> +	 * page size, corresponding to hugetlb_add_hstate() calls
> +	 * here.
> +	 *
> +	 * HUGE_MAX_HSTATE should at least match maximum supported
> +	 * HugeTLB page sizes on the platform. Any new addition to
> +	 * supported HugeTLB page sizes will also require changing
> +	 * HUGE_MAX_HSTATE as well.
> +	 */
> +	BUILD_BUG_ON(HUGE_MAX_HSTATE < 4);

I guess we only technically need 3 if pud_sect_supported() == false ? Although
for simplicity (and to reduce my rebasing effort for boot-time page size :) ),
agree we should always just compare to 4.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

>  	if (pud_sect_supported())
>  		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>  


