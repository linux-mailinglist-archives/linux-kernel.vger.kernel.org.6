Return-Path: <linux-kernel+bounces-396430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F929BCCFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17DB1F22146
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E71D5AA1;
	Tue,  5 Nov 2024 12:45:52 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9151D0B82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810751; cv=none; b=V0h1KR1Dbtet1c2rFL5uCqjKN71A16gDkL2LutF+BTvG/qnzbuvR2PVloznvzBiao2sAyptyQlM8sF4zfUDHWVaK6B0SGe3y4NBlzeBhnSqS+Y0mYWauAU858wuKh0U4/X2OrtIvr7pxp2CzS24bSZ2dFYYQy0+Sctzts9YNmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810751; c=relaxed/simple;
	bh=K4M37bx0bCuCvwDIyvewH+1X5UbY++9WoXria3y7kCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFxvBQXdyBLJJ0bUboO5Dcwsdude+KzhZCcRS/wF36ddkSxN4HLOKPeKJc2JlbEzJKeObnzSVLy6O4BjsYGCvSIXJFQIHVQNsKzLSO918YJsWXK10R2Vf5a5kEEmVg/qchdiNukNFER9eyxRiAdA5I5AKoHhxmVuf1taGWCozC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BF05E000C;
	Tue,  5 Nov 2024 12:45:44 +0000 (UTC)
Message-ID: <bedac8d9-4ba4-427c-9323-edcdbd7876ee@ghiti.fr>
Date: Tue, 5 Nov 2024 13:45:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH V4 1/3] riscv: mm: Prepare for reusing PTE RSW
 bit(9)
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240830011101.3189522-1-zhangchunyan@iscas.ac.cn>
 <20240830011101.3189522-2-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240830011101.3189522-2-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 30/08/2024 03:10, Chunyan Zhang wrote:
> The PTE bit(9) on RISC-V is reserved for software, it is used by DEVMAP
> now which has to be disabled if we want to use bit(9) for other features,
> since there's no more free PTE bit on RISC-V now.
>
> So to make ARCH_HAS_PTE_DEVMAP selectable, this patch uses it as
> the build condition of devmap definitions.
>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   arch/riscv/include/asm/pgtable-64.h   | 2 +-
>   arch/riscv/include/asm/pgtable-bits.h | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 0897dd99ab8d..babb8d2b0f0b 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -398,7 +398,7 @@ static inline struct page *pgd_page(pgd_t pgd)
>   #define p4d_offset p4d_offset
>   p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
>   
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_ARCH_HAS_PTE_DEVMAP)
>   static inline int pte_devmap(pte_t pte);
>   static inline pte_t pmd_pte(pmd_t pmd);
>   
> diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
> index a8f5205cea54..5bcc73430829 100644
> --- a/arch/riscv/include/asm/pgtable-bits.h
> +++ b/arch/riscv/include/asm/pgtable-bits.h
> @@ -19,7 +19,13 @@
>   #define _PAGE_SOFT      (3 << 8)    /* Reserved for software */
>   
>   #define _PAGE_SPECIAL   (1 << 8)    /* RSW: 0x1 */
> +
> +#ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
>   #define _PAGE_DEVMAP    (1 << 9)    /* RSW, devmap */
> +#else
> +#define _PAGE_DEVMAP	0
> +#endif /* CONFIG_ARCH_HAS_PTE_DEVMAP */
> +
>   #define _PAGE_TABLE     _PAGE_PRESENT
>   
>   /*


There is a small inconsistency in our code: pte_devmap() is protected by 
a #ifdef but pte_mkdevmap() is not, I guess that's why you had to define 
_PAGE_DEVMAP if !CONFIG_ARCH_HAS_PTE_DEVMAP.

I'd be in favor of removing the #ifdef around pte_devmap() too.

Thanks,

Alex


