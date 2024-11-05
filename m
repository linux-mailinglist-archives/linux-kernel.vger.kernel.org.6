Return-Path: <linux-kernel+bounces-396516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E5C9BCE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF101C21162
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794971D63CE;
	Tue,  5 Nov 2024 13:48:00 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6E91D1319
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814480; cv=none; b=gCusnkddqOdvS1QzS/AQrWimrqmCwTWmMCeiyst2KlOK9f4ZVHL10CRBBvSuyA4yJftOCEuDlLhx0C+JRzqKjC6uMa9Mcfrs+U5mZ5V3AeZGapVtjm9i0soRO3nVDGrQXyOdnHZYsO50w5izoymhCZ/LxiGm5qFzlelJKcShVQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814480; c=relaxed/simple;
	bh=VQH2vJWJ8DIr4TQhynWzEMSE4bedx48/VR1PADtXixE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZtfVubDeJTGVHege580o/SKPlrj4DKg7I6Je52+IYbfLvy3xBK9PDjtynk+whimWL5a4qZHH4Ayh3Wvk76IIxWNWWo6tRt9aVnz7Y0HS/RSNGZNnd5F7c08A7y2OLvu4luxYT1kk3SxXT3fEvLC7VAHaOshFn97DURLD4JaN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39DD160003;
	Tue,  5 Nov 2024 13:47:51 +0000 (UTC)
Message-ID: <717b3757-4f6f-49f3-9da1-82faaff57485@ghiti.fr>
Date: Tue, 5 Nov 2024 14:47:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] riscv: Do not rely on KASAN to define the memory
 layout
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>,
 Evgenii Stepanov <eugenis@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
 <20241022015913.3524425-7-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241022015913.3524425-7-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 22/10/2024 03:57, Samuel Holland wrote:
> Commit 66673099f734 ("riscv: mm: Pre-allocate vmemmap/direct map/kasan
> PGD entries") used the start of the KASAN shadow memory region to
> represent the end of the linear map, since the two memory regions were
> immediately adjacent. This is no longer the case for Sv39; commit
> 5c8405d763dc ("riscv: Extend sv39 linear mapping max size to 128G")
> introduced a 4 GiB hole between the regions. Introducing KASAN_SW_TAGS
> will cut the size of the shadow memory region in half, creating an even
> larger hole.
>
> Avoid wasting PGD entries on this hole by using the size of the linear
> map (KERN_VIRT_SIZE) to compute PAGE_END.
>
> Since KASAN_SHADOW_START/KASAN_SHADOW_END are used inside an IS_ENABLED
> block, it's not possible to completely hide the constants when KASAN is
> disabled, so provide dummy definitions for that case.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>   arch/riscv/include/asm/kasan.h | 11 +++++++++--
>   arch/riscv/mm/init.c           |  2 +-
>   2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
> index e6a0071bdb56..a4e92ce9fa31 100644
> --- a/arch/riscv/include/asm/kasan.h
> +++ b/arch/riscv/include/asm/kasan.h
> @@ -6,6 +6,8 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +#ifdef CONFIG_KASAN
> +
>   /*
>    * The following comment was copied from arm64:
>    * KASAN_SHADOW_START: beginning of the kernel virtual addresses.
> @@ -33,13 +35,18 @@
>   #define KASAN_SHADOW_START	((KASAN_SHADOW_END - KASAN_SHADOW_SIZE) & PGDIR_MASK)
>   #define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
>   
> -#ifdef CONFIG_KASAN
>   #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>   
>   void kasan_init(void);
>   asmlinkage void kasan_early_init(void);
>   void kasan_swapper_init(void);
>   
> -#endif
> +#else /* CONFIG_KASAN */
> +
> +#define KASAN_SHADOW_START	MODULES_LOWEST_VADDR
> +#define KASAN_SHADOW_END	MODULES_LOWEST_VADDR
> +
> +#endif /* CONFIG_KASAN */
> +
>   #endif
>   #endif /* __ASM_KASAN_H */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 0e8c20adcd98..1f9bb95c2169 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1494,7 +1494,7 @@ static void __init preallocate_pgd_pages_range(unsigned long start, unsigned lon
>   	panic("Failed to pre-allocate %s pages for %s area\n", lvl, area);
>   }
>   
> -#define PAGE_END KASAN_SHADOW_START
> +#define PAGE_END (PAGE_OFFSET + KERN_VIRT_SIZE)
>   
>   void __init pgtable_cache_init(void)
>   {


Looks good and cleaner, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


