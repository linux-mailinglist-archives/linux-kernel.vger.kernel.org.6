Return-Path: <linux-kernel+bounces-190614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 626568D007A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F043F1F21B71
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4815E5D0;
	Mon, 27 May 2024 12:53:35 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07211DDC9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814414; cv=none; b=Nrloo0PsInPcSlIZfE7Cg2SvQk/mncrjz9jbFJ68h2xii5PFHYsyd+FblncGdzDHejybi5pI5u8TfocaM7DyriYCAXf57L16fvnPeJXDeMVv64djY2RFImkBsOv4XXh+z4KgHEZrGEAPCeq32vUse9EUBlTd3zGKBU7PLj087JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814414; c=relaxed/simple;
	bh=5Bybq8cKJlG0qEa1Ub7/CJsdd3PAgncbujsxxqAVJvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iTO4279iUiFx9+w0tKnhaYZmROXzt0xbKtYbLN0t6mM0gmpuphHS7kh3ARuwlsrTtRCrR6SGcfjOf3JRLuw5qJNbKBu3AROaX8TXEb/Vyw/aJGee8p0X5X9HkT07yc/RwNQrBGiVI2PACx4pL9M+01zfrWO8XYcez1qs+lc8oJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21968FF808;
	Mon, 27 May 2024 12:53:29 +0000 (UTC)
Message-ID: <19a87876-70f3-40d3-996e-ea8b1862de0d@ghiti.fr>
Date: Mon, 27 May 2024 14:53:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] riscv: drop the use of XIP_OFFSET in
 create_kernel_page_table()
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
 <8748eab99d76e466a44a0bb81d836ff1c9ad9879.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <8748eab99d76e466a44a0bb81d836ff1c9ad9879.1715286093.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 10/05/2024 08:28, Nam Cao wrote:
> XIP_OFFSET is the hard-coded offset of writable data section within the
> kernel.
>
> By hard-coding this value, the read-only section of the kernel (which is
> placed before the writable data section) is restricted in size.
>
> As a preparation to remove this hard-coded value entirely, stop using
> XIP_OFFSET in create_kernel_page_table(). Instead use _sdata and _start to
> do the same thing.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/mm/init.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9846c6924509..62ff4aa2be96 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -907,7 +907,7 @@ static void __init relocate_kernel(void)
>   static void __init create_kernel_page_table(pgd_t *pgdir,
>   					    __always_unused bool early)
>   {
> -	uintptr_t va, end_va;
> +	uintptr_t va, start_va, end_va;
>   
>   	/* Map the flash resident part */
>   	end_va = kernel_map.virt_addr + kernel_map.xiprom_sz;
> @@ -917,10 +917,11 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
>   				   PMD_SIZE, PAGE_KERNEL_EXEC);
>   
>   	/* Map the data in RAM */
> +	start_va = kernel_map.virt_addr + (uintptr_t)&_sdata - (uintptr_t)&_start;
>   	end_va = kernel_map.virt_addr + kernel_map.size;
> -	for (va = kernel_map.virt_addr + XIP_OFFSET; va < end_va; va += PMD_SIZE)
> +	for (va = start_va; va < end_va; va += PMD_SIZE)
>   		create_pgd_mapping(pgdir, va,
> -				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
> +				   kernel_map.phys_addr + (va - start_va),
>   				   PMD_SIZE, PAGE_KERNEL);
>   }
>   #else


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


