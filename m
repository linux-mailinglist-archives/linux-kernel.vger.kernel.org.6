Return-Path: <linux-kernel+bounces-318962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D974496F5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E97284A18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6241CF2B8;
	Fri,  6 Sep 2024 13:45:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B61E4BE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630344; cv=none; b=jw03U8sF5ZByN1G5QCzZhgysWF7jOmbMzIAIOp7+5oLeuVpVD7urhQ2ONtU/AfL65NN04JAOW7ybpG7d/VcwIoJE2OGosVgHxr3mTdNAz7DhVw+V5vxUenAqUpxC2+gz9OVTEy6YrUXZvZyOoNbx75VbiC2x2yIj333Bop/eoag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630344; c=relaxed/simple;
	bh=TNW5lGfhfsP+beCT0CRW7oI5YJ5qb3u0F8ZVwYMrM2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEOPwX/vZkngs8nUIKsbCM/BdTQmUayFJPmDv6Wi0b7Q2h8FXbAN9IlW/LGnFkgP8iIBA7eI1ZtzM9mUbeY0phQWE9rKSB2zeh5gfiIY+I2eXzN1x3U4O/vQQ2+yXXeyOX70PGQmbDriYDWIwpDcTjrALgdNI5q3OY9dROoPEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47E21FEC;
	Fri,  6 Sep 2024 06:46:08 -0700 (PDT)
Received: from [10.57.86.132] (unknown [10.57.86.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DFA53F73B;
	Fri,  6 Sep 2024 06:45:39 -0700 (PDT)
Message-ID: <16b02b7e-7877-4965-b15a-bf3b600134f7@arm.com>
Date: Fri, 6 Sep 2024 14:45:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc:arm64 support cont-pte huge vmalloc mapping
Content-Language: en-GB
To: Haiwang Fu <fuhaiwang@bytedance.com>, akpm@linux-foundation.org,
 mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240906130919.3765401-1-fuhaiwang@bytedance.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240906130919.3765401-1-fuhaiwang@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2024 14:09, Haiwang Fu wrote:
> From: fuhaiwang <fuhaiwang@bytedance.com>
> 
> Arm64 support contiguous bit which is used to increase the mapping size
> at the pmd and pte level.
> 
> Now huge vmalloc support PMD and PTE level mapping, and support
> multi size at pte level.
> 
> arm64: implement the fllowing interface on arm64 to support
> cont-pte huge vmalloc mapping.
> arch_vmap_pte_supported_shift(*)
> arch_vmap_pte_range_map_size(*)

I believe that riscv tried to do the same thing and had to revert it because its
possible to unmap a portion of what was allocated and there was no easy way to
fix up the mapping safely. See [1].

I believe arm64 might suffer from a similar problem; I'm guessing the contpte
code would attempt to repaint the ptes with/out the PTE_CONT bit, as needed. But
that isn't safe on kernel mappings because there is no way to recover if another
thread tries to access the mapping concurrently. The code is only safe for user
mappings where the racing fault will get serialized behind the PTL.

[1] https://lore.kernel.org/linux-riscv/20240227205016.121901-2-
alexghiti@rivosinc.com/

Thanks,
Ryan


> 
> Signed-off-by: fuhaiwang <fuhaiwang@bytedance.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index c329ea061dc9..3f32e3150680 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1814,6 +1814,34 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
>  
>  #endif /* CONFIG_ARM64_CONTPTE */
>  
> +static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, unsigned long end,
> +					u64 pfn, unsigned int max_page_shift)
> +{
> +	if (end - addr < CONT_PTE_SIZE)
> +		return PAGE_SIZE;
> +
> +	if ((1UL << max_page_shift) < CONT_PTE_SIZE)
> +		return PAGE_SIZE;
> +
> +	if (!IS_ALIGNED(addr, CONT_PTE_SIZE))
> +		return PAGE_SIZE;
> +
> +	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
> +		return PAGE_SIZE;
> +
> +	return CONT_PTE_SIZE;
> +}
> +#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
> +
> +static inline int arch_vmap_pte_supported_shift(unsigned long size)
> +{
> +	if (size >= CONT_PTE_SIZE)
> +		return CONT_PTE_SHIFT;
> +	else
> +		return PAGE_SHIFT;
> +}
> +#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* __ASM_PGTABLE_H */


