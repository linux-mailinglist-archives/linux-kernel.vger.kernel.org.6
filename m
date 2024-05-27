Return-Path: <linux-kernel+bounces-190587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2BC8D0014
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AF31C21408
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368A15E5AB;
	Mon, 27 May 2024 12:33:03 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C0915DBCA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813183; cv=none; b=aDI1BvZeVgczYx7B1a4tA5f6DRiLVH6Qkwwfhsavd5ibusSpIi/NOJ1BtSj6XWLMqEUQzCDliYZ2PTjC4nmLawBKqEuYvZsYIchqOOkRBEncMe/DlE5MM1X/C/9h0s9BX9zY1nwTgM/A1U/0Pa7GxOB/5CWz+NrKciIh7rYV/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813183; c=relaxed/simple;
	bh=LRpj5HU3LzXsRP8Qxtk/FDjPas85eokoFiJYkWYVPAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=to9eFfWvkTzf1Xx+0guaL3l4FSW7yPptOEc3kYc0UiX+/V9T3dB5DSzQMUP8Pxa+i+7r98iYNPAFxoOGkVGDhgXr9TL7RFjYPYfSu7Qi+ZH2LVjyfPvg6iXgY/AtFIyIcTlrl4koBJFt3SppZyRPCyvw9C8H4lbaL4VYXeaKA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED0CE2000E;
	Mon, 27 May 2024 12:32:58 +0000 (UTC)
Message-ID: <335c8f7e-cef7-483c-bab7-6110e5d31071@ghiti.fr>
Date: Mon, 27 May 2024 14:32:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] riscv: replace va_kernel_pa_offset with
 va_kernel_data_pa_offset on XIP
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
 <133e7cd43a67abfed96bc246ae5f8a870edde684.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <133e7cd43a67abfed96bc246ae5f8a870edde684.1715286093.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 10/05/2024 08:28, Nam Cao wrote:
> On XIP kernel, the name "va_kernel_pa_offset" is misleading: unlike
> "normal" kernel, it is not the virtual-physical address offset of kernel
> mapping, it is the offset of kernel mapping's first virtual address to
> first physical address in DRAM, which is not meaningful because the
> kernel's first physical address is not in DRAM.
>
> For XIP kernel, there are 2 different offsets because the read-only part of
> the kernel resides in ROM while the rest is in RAM. The offset to ROM is in
> kernel_map.va_kernel_xip_pa_offset, while the offset to RAM is not stored
> anywhere: it is calculated on-the-fly.
>
> Remove this confusing "va_kernel_pa_offset" and add
> "va_kernel_data_pa_offset" as its replacement. This new variable is the
> offset of virtual mapping of the kernel's data portion to the corresponding
> physical addresses.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/include/asm/page.h | 25 +++++++++++++++++++------
>   arch/riscv/mm/init.c          |  4 +++-
>   2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 115ac98b8d72..14d0de928f9b 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -112,11 +112,13 @@ struct kernel_mapping {
>   	/* Offset between linear mapping virtual address and kernel load address */
>   	unsigned long va_pa_offset;
>   	/* Offset between kernel mapping virtual address and kernel load address */
> -	unsigned long va_kernel_pa_offset;
> -	unsigned long va_kernel_xip_pa_offset;
>   #ifdef CONFIG_XIP_KERNEL
> +	unsigned long va_kernel_xip_pa_offset;
> +	unsigned long va_kernel_data_pa_offset;


I would call that new field va_kernel_xip_data_pa_offset so that we know 
at first sight it only applies to XIP_KERNEL (and maybe rename 
va_kernel_xip_pa_offset into va_kernel_xip_text_pa_offset?).


>   	uintptr_t xiprom;
>   	uintptr_t xiprom_sz;
> +#else
> +	unsigned long va_kernel_pa_offset;
>   #endif
>   };
>   
> @@ -134,12 +136,18 @@ extern phys_addr_t phys_ram_base;
>   #else
>   void *linear_mapping_pa_to_va(unsigned long x);
>   #endif
> +
> +#ifdef CONFIG_XIP_KERNEL
>   #define kernel_mapping_pa_to_va(y)	({					\
>   	unsigned long _y = (unsigned long)(y);					\
> -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
> +	(_y < phys_ram_base) ?							\
>   		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
> -		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
> +		(void *)(_y + kernel_map.va_kernel_data_pa_offset);		\
>   	})
> +#else
> +#define kernel_mapping_pa_to_va(y) (void *)((unsigned long)(y) + kernel_map.va_kernel_pa_offset)
> +#endif
> +
>   #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>   
>   #ifndef CONFIG_DEBUG_VIRTUAL
> @@ -147,12 +155,17 @@ void *linear_mapping_pa_to_va(unsigned long x);
>   #else
>   phys_addr_t linear_mapping_va_to_pa(unsigned long x);
>   #endif
> +
> +#ifdef CONFIG_XIP_KERNEL
>   #define kernel_mapping_va_to_pa(y) ({						\
>   	unsigned long _y = (unsigned long)(y);					\
> -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
> +	(_y < kernel_map.virt_addr + XIP_OFFSET) ?				\
>   		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
> -		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
> +		(_y - kernel_map.va_kernel_data_pa_offset);			\
>   	})
> +#else
> +#define kernel_mapping_va_to_pa(y) ((unsigned long)(y) - kernel_map.va_kernel_pa_offset)
> +#endif
>   
>   #define __va_to_pa_nodebug(x)	({						\
>   	unsigned long _x = x;							\
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 5e3ec076ab95..9846c6924509 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1089,10 +1089,13 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
>   
>   	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
> +	kernel_map.va_kernel_data_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr
> +						+ (uintptr_t)&_sdata - (uintptr_t)&_start;
>   #else
>   	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
>   	kernel_map.phys_addr = (uintptr_t)(&_start);
>   	kernel_map.size = (uintptr_t)(&_end) - kernel_map.phys_addr;
> +	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>   #endif
>   
>   #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
> @@ -1114,7 +1117,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   	 */
>   	kernel_map.va_pa_offset = IS_ENABLED(CONFIG_64BIT) ?
>   				0UL : PAGE_OFFSET - kernel_map.phys_addr;
> -	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>   
>   	/*
>   	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit


I think you missed the occurence of va_kernel_pa_offset() in 
arch/riscv/kernel/vmcore_info.c.

Although some nits above, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


