Return-Path: <linux-kernel+bounces-236225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D5E91DEF8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E76D281156
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239C14D283;
	Mon,  1 Jul 2024 12:21:18 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893214A0A0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836477; cv=none; b=upAqiZ5wzThXjSTPa+NgV8dxVoOr/MFukaGNAcA/lL9u/DACHmnHJKpXoGHHnhxQ1/r/nWIAMkuMFLCyE5KdQP/2Kq7M+8W+WLKUHSIn13eHDO9St8DFEUa9mm8S3eKEL6sRY7V1LygAeZkRg3uyxEjtpbxbTP1Mx6a8KVL08aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836477; c=relaxed/simple;
	bh=toC1qfgk/Wv5MhgzY6TgdrN+h4e/JEV4Y++upj3wbc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+oOVCfqv5Pqb8lX3VI8OGQJlsQQ/cXvgPgLaLQwF/b8mNsxQvSz+fIeJjHamktO/C5fUDyRY+pLj3S8d/WpLSDZNK5U91srZwudhud72axI/oFCm9DKxnajlMOVZu91c0uNMw4TSoDAhWYudCsWQ0uy2C9ELKxH/mKSlc5QHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 143CD6000F;
	Mon,  1 Jul 2024 12:21:11 +0000 (UTC)
Message-ID: <bc976095-9153-44f1-8996-5b3717f6f83d@ghiti.fr>
Date: Mon, 1 Jul 2024 14:21:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Remove redundant restriction on memory size
Content-Language: en-US
To: Stuart Menefy <stuart.menefy@codasip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240624121723.2186279-1-stuart.menefy@codasip.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240624121723.2186279-1-stuart.menefy@codasip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Stuart,

On 24/06/2024 14:17, Stuart Menefy wrote:
> The original reason for reserving the top 4GiB of the direct map
> (space for modules/BPF/kernel) hasn't applied since the address
> map was reworked for KASAN.
>
> Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
> ---
>   arch/riscv/mm/init.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 7e25606f858a..3998d1ca369c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1130,13 +1130,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   				0UL : PAGE_OFFSET - kernel_map.phys_addr;
>   	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>   
> -	/*
> -	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
> -	 * kernel, whereas for 64-bit kernel, the end of the virtual address
> -	 * space is occupied by the modules/BPF/kernel mappings which reduces
> -	 * the available size of the linear mapping.
> -	 */
> -	memory_limit = KERN_VIRT_SIZE - (IS_ENABLED(CONFIG_64BIT) ? SZ_4G : 0);
> +	memory_limit = KERN_VIRT_SIZE;
>   
>   	/* Sanity check alignment and size */
>   	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);


I somehow totally missed this one, I guess this is the third fix you 
mentioned earlier right?

This is correct so you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


