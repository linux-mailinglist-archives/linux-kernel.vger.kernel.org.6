Return-Path: <linux-kernel+bounces-570695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21158A6B3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105433B6AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802A91E5B66;
	Fri, 21 Mar 2025 04:22:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419BB664
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742530922; cv=none; b=amZq1Gm1vsLGuvEvcGF4By6CNZ2lVp4lUSIEBnNlXXXtyYuJ5HB954IlS/fPZebDsSWo9EmAcrN4wXoYGSWRnOVYHl9hGr0WgCvPOWxM/KL7OUP/4otEp7csLe03vtC7WjStEYNWMihPfBrNhd6sNwMydJkzALU6hLLZxUn8M94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742530922; c=relaxed/simple;
	bh=2+btny2MzHlBk/WLxrebfCC8c5LLyxPS+kp5sPwlIHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1zP6baMWc0nBYpDIyRX0P3QOoQPtxRMxcpTBX6EaZkL3pUm7kv+ePxfea99frKb6zMrez2o5MSXepysGWRCXvMwsGaJ3CLfCK1df3x8JPZdOIWXmVPwo1+xyFvHNdtJJMTcpIZm+BavAL/TmQsk41/GIwy4jhwZZOywHh1Vcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D27A106F;
	Thu, 20 Mar 2025 21:22:06 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3A893F673;
	Thu, 20 Mar 2025 21:21:55 -0700 (PDT)
Message-ID: <f3868f40-961d-4db5-af2a-7b4b32b3d86e@arm.com>
Date: Fri, 21 Mar 2025 09:51:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/arm64: Drop dead code for pud special bit handling
To: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Keith Busch <kbusch@kernel.org>
References: <20250320183405.12659-1-peterx@redhat.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250320183405.12659-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 00:04, Peter Xu wrote:
> Keith Busch observed some incorrect macros defined in arm64 code [1].
> 
> It turns out the two lines should never be needed and won't be exposed to
> anyone, because aarch64 doesn't select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD,
> hence ARCH_SUPPORTS_PUD_PFNMAP is always N.  The only archs that support
> THP PUDs so far are x86 and powerpc.

Correct.

> 
> Instead of fixing the lines (with no way to test it..), remove the two
> lines that are in reality dead code, to avoid confusing readers.

Agreed. Because ARCH_SUPPORTS_PUD_PFNMAP is always N and hence these lines
are never reachable. So removing these lines will be preferred than fixing.

> 
> Fixes tag is attached to reflect where the wrong macros were introduced,
> but explicitly not copying stable, because there's no real issue to be
> fixed.  So it's only about removing the dead code so far.

Makes sense.

> 
> [1] https://lore.kernel.org/all/Z9tDjOk-JdV_fCY4@kbusch-mbp.dhcp.thefacebook.com/#t
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Donald Dutile <ddutile@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Fixes: 3e509c9b03f9 ("mm/arm64: support large pfn mappings")

The commit ID checks out.

> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0b2a2ad1b9e8..15211f74b035 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -620,11 +620,6 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
>  #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
>  #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  
> -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
> -#define pud_special(pte)	pte_special(pud_pte(pud))
> -#define pud_mkspecial(pte)	pte_pud(pte_mkspecial(pud_pte(pud)))
> -#endif
> -
>  #define pmd_pgprot pmd_pgprot
>  static inline pgprot_t pmd_pgprot(pmd_t pmd)
>  {

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

