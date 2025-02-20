Return-Path: <linux-kernel+bounces-523075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E271A3D1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBAD23B92DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B61E47A8;
	Thu, 20 Feb 2025 07:02:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA3C442C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034977; cv=none; b=gQJfS4i41FNFknVr9TvmGqAg8Uj/mGLiy3sCWeZ+z4bV87Sox8LXldMa0k8waGwJEfFOwc9ggu431reLHAAfiWnhArtVIRKQ0U52Xpa0gJeWQqEJ6Q0VxB1vcO2VQdGCKKuiePCe+xVANgjv02yBPKNHAVUXsEymB2/JAgnLqd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034977; c=relaxed/simple;
	bh=RU4xImw6sHXhlKPtzwbk1nk+CQyGhsA53NZ7lHc8T0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Xh5eE6JNHtDxXtf/qohUb/n5CrqvVccuFeLFg4PjN6QZ+Am3gC7Z90we9PCIcF8+pHnr+ubRcLR8kam4/TxwJs0fGjiznqlRkvu14ecWPCzZ7V8T3Jvxm+2JqGPYr9+e5YB/qAdc8clhQRj80oz7Gg/9YIWdHUYX6EJy1lw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7BDC2008;
	Wed, 19 Feb 2025 23:03:12 -0800 (PST)
Received: from [10.163.38.27] (unknown [10.163.38.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFBFD3F5A1;
	Wed, 19 Feb 2025 23:02:46 -0800 (PST)
Message-ID: <dd60e3d2-62ad-4295-8963-35bb1a94b006@arm.com>
Date: Thu, 20 Feb 2025 12:32:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] mm/vmalloc: Warn on improper use of
 vunmap_range()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250217140809.1702789-1-ryan.roberts@arm.com>
 <20250217140809.1702789-9-ryan.roberts@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250217140809.1702789-9-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 19:38, Ryan Roberts wrote:
> A call to vmalloc_huge() may cause memory blocks to be mapped at pmd or
> pud level. But it is possible to subsequently call vunmap_range() on a
> sub-range of the mapped memory, which partially overlaps a pmd or pud.
> In this case, vmalloc unmaps the entire pmd or pud so that the
> no-overlapping portion is also unmapped. Clearly that would have a bad
> outcome, but it's not something that any callers do today as far as I
> can tell. So I guess it's just expected that callers will not do this.
> 
> However, it would be useful to know if this happened in future; let's
> add a warning to cover the eventuality.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM and stands on its own independent of the series here.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/vmalloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 61981ee1c9d2..a7e34e6936d2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -374,8 +374,10 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  		if (cleared || pmd_bad(*pmd))
>  			*mask |= PGTBL_PMD_MODIFIED;
>  
> -		if (cleared)
> +		if (cleared) {
> +			WARN_ON(next - addr < PMD_SIZE);
>  			continue;
> +		}
>  		if (pmd_none_or_clear_bad(pmd))
>  			continue;
>  		vunmap_pte_range(pmd, addr, next, mask);
> @@ -399,8 +401,10 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  		if (cleared || pud_bad(*pud))
>  			*mask |= PGTBL_PUD_MODIFIED;
>  
> -		if (cleared)
> +		if (cleared) {
> +			WARN_ON(next - addr < PUD_SIZE);
>  			continue;
> +		}
>  		if (pud_none_or_clear_bad(pud))
>  			continue;
>  		vunmap_pmd_range(pud, addr, next, mask);

