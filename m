Return-Path: <linux-kernel+bounces-364009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5D99C9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6BC282A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234A919F436;
	Mon, 14 Oct 2024 12:12:33 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB719F421
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907952; cv=none; b=LX4WEiqpIpg57Dnc4BoG4Hf1qdiopmnAfTT90yawdgRAW/Z8bGJFGPfbIHWwQ1xkh9RQl2edATVt2qkuLF+7H6MMXR8ZMTH+Y9mxcPbCLrHsyRJe92hciM/yrk7T9ntB5IxTkc2EmZVCS4ImkAGyP8w8LXN0U0WYvwix6zLkGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907952; c=relaxed/simple;
	bh=cIQPLLPfrXCdF+cPGC1rmVdjvRswT/WXKja1n8pT6g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dUJWAd/b5e2ddD7IdPL9C6hT6nPJMrOtdCty06y8Bli82ztJ7kb1epsvjWIukBEJvK2itbfpcQyOctoUfo7q4hA7p1EykXpBtmySjVvWVccmfnpb1Wfu06WXu5fGXR+47rElx4ZJpModTEl4faJhcqfU6UJq0Muj3OXeB9xBVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF0F4E0007;
	Mon, 14 Oct 2024 12:12:25 +0000 (UTC)
Message-ID: <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr>
Date: Mon, 14 Oct 2024 14:12:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, punit.agrawal@bytedance.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 sunilvl@ventanamicro.com, ajones@ventanamicro.com, alexghiti@rivosinc.com,
 jeeheng.sia@starfivetech.com, haibo1.xu@intel.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241014094705.71775-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Yunhui,

On 14/10/2024 11:47, Yunhui Cui wrote:
> When SVPBMT is enabled, __acpi_map_table() will directly access the
> data in DDR through the IO attribute, rather than through hardware
> cache consistency, resulting in incorrect data in the obtained ACPI
> table.
>
> The log: ACPI: [ACPI:0x18] Invalid zero length.
>
> We do not assume whether the bootloader flushes or not. We should
> access in a cacheable way instead of maintaining cache consistency
> by software.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/kernel/acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 6e0d333f57e5..3177c9af8764 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
>   	if (!size)
>   		return NULL;
>   
> -	return early_ioremap(phys, size);
> +	return early_memremap(phys, size);
>   }
>   
>   void __init __acpi_unmap_table(void __iomem *map, unsigned long size)


It makes sense to me since with this, we don't have to care about how 
the firmware mapped the table. And it mimics all other architectures 
(arm64, loongarch and x86).

Here is the corresponding fixes tag:

Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in 
different address space")

With the corresponding fix in __acpi_unmap_table() as pointed by Sunil, 
you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And regarding the sparse error, I don't see any other architecture 
casting to __iomem, so maybe that's not necessary anymore?

Thanks,

Alex



