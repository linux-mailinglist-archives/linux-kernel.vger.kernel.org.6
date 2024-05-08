Return-Path: <linux-kernel+bounces-173775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE878C053C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76532B25890
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA7128829;
	Wed,  8 May 2024 19:43:18 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52BB39AD6
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197397; cv=none; b=F2CHc5nMyiQF66JaTpKCIIGabXwT5vO88dh/75Di4dXlnmNShnVFzaqopcHjTkFtRUFuFWz2EmS2x67c2Syji1klKISRFMW8OwgRfXP5yXO7t7fqVoywcbme3v8f6XiJ48jBeXzyoRkOBNAbPRr6a0WmgeSSviU2lckQbPgmecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197397; c=relaxed/simple;
	bh=ghYZ1xj0MjCSVqlIaq8fQKUVO36T7/5GUKecLsvIyvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EL9NdcKKTxbrEZQhlSzX5U1MuaawrWbKYhTCGsw902noMKyyJbo3FfWPm2QmKcvk2aegHUzgHmAhpBPR/go6yuxE9o3iGbjg7XtCbwx7lWgu1K9czR0IpwcQKBg8GiGl+AaOaMvt0i80EGHa0tgesLL1Cf+9CUvjiHysad6ud+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30CAC40002;
	Wed,  8 May 2024 19:43:11 +0000 (UTC)
Message-ID: <f582aedc-603c-4c2f-9013-ae8e6cde767f@ghiti.fr>
Date: Wed, 8 May 2024 21:43:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: change XIP's kernel_map.size to be size of the
 entire kernel
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240508191917.2892064-1-namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240508191917.2892064-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 08/05/2024 21:19, Nam Cao wrote:
> With XIP kernel, kernel_map.size is set to be only the size of data part of
> the kernel. This is inconsistent with "normal" kernel, who sets it to be
> the size of the entire kernel.
>
> More importantly, XIP kernel fails to boot if CONFIG_DEBUG_VIRTUAL is
> enabled, because there are checks on virtual addresses with the assumption
> that kernel_map.size is the size of the entire kernel (these checks are in
> arch/riscv/mm/physaddr.c).
>
> Change XIP's kernel_map.size to be the size of the entire kernel.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org> # v6.1+
> ---
> I wouldn't consider this inconsistency to be a bug. It only became a
> a problem after kernel_map.size is used to check virtual addresses in
> 5f763b3b5960 ("riscv: Fix DEBUG_VIRTUAL false warnings"). So I will only
> backport this to stable versions that contain this commit: v6.1+
>
>   arch/riscv/mm/init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index c081e7d349b1..0c0562839899 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -903,7 +903,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
>   				   PMD_SIZE, PAGE_KERNEL_EXEC);
>   
>   	/* Map the data in RAM */
> -	end_va = kernel_map.virt_addr + XIP_OFFSET + kernel_map.size;
> +	end_va = kernel_map.virt_addr + kernel_map.size;
>   	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
>   		create_pgd_mapping(pgdir, va,
>   				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
> @@ -1072,7 +1072,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   
>   	phys_ram_base = CONFIG_PHYS_RAM_BASE;
>   	kernel_map.phys_addr = (uintptr_t)CONFIG_PHYS_RAM_BASE;
> -	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_sdata);
> +	kernel_map.size = (uintptr_t)(&_end) - (uintptr_t)(&_start);
>   
>   	kernel_map.va_kernel_xip_pa_offset = kernel_map.virt_addr - kernel_map.xiprom;
>   #else


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


