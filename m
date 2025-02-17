Return-Path: <linux-kernel+bounces-517827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA832A38614
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA617A12C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4A22540E;
	Mon, 17 Feb 2025 14:21:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A22253F0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802104; cv=none; b=jg3wfLGiRQnJRKGfwykPwTylmqDy7g3npyHqlBsELTfDup6o2QnAJOJ/ZPA/SKF/ifO8lNKfsVwybh22bZ/MiE4/51Q0ezmqYnaM4BhYu1cD2odvHug+gJJOoODTZRq1+ohGMWL2DnwJBWhY8u8zX7RHsrWcDw8ziD0ZRfqPEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802104; c=relaxed/simple;
	bh=E4zvNQWCavlUJV5y8SHPVS/vYYKox7gU6pj8X+vtYPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIUa08irHKnYMajw/1le6VKxA6QtOgQ7ij/WEuQxOlDDSeulrZ+jnVp65XE30g655IWmJjJTAhRGfvv2THPjZK6c4l3Q2vwv6xBRCpm22Ofcz482zpD5PYacbZarYSVdsfBGc/oJUYuOqS7Hhf9FsvbqyXYiuaBm9jQm2ogIxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9023F152B;
	Mon, 17 Feb 2025 06:22:01 -0800 (PST)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 937303F6A8;
	Mon, 17 Feb 2025 06:21:41 -0800 (PST)
Message-ID: <271c6277-baab-4b69-97ea-d6c80f873fe5@arm.com>
Date: Mon, 17 Feb 2025 14:21:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/hugetlb: Consistently use pud_sect_supported()
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250217065414.49489-1-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250217065414.49489-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/02/2025 06:54, Anshuman Khandual wrote:
> Let's be consistent in using pud_sect_supported() for PUD_SIZE sized pages.
> Hence change hugetlb_mask_last_page() and arch_make_huge_pte() as required.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.14-rc3
> 
>  arch/arm64/mm/hugetlbpage.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 98a2a0e64e25..5b7cfdba9c93 100644
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
> @@ -364,7 +366,8 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
>  	switch (pagesize) {
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	case PUD_SIZE:
> -		entry = pud_pte(pud_mkhuge(pte_pud(entry)));
> +		if (pud_sect_supported())
> +			entry = pud_pte(pud_mkhuge(pte_pud(entry)));

If this was to get called with PUD_SIZE for a config that doesn't fold the PMD
and which pud_sect_supported() returns false, we will now return the entry
unmodified and will not emit the warning that the default case emits. I think we
should at least either modify the entry (so that it is safe) or emit the
warning. Doing neither seems less defensive than the current situation.

>  		break;
>  #endif
>  	case CONT_PMD_SIZE:


