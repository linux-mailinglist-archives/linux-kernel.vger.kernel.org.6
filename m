Return-Path: <linux-kernel+bounces-289651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453109548C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F390B286CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57E1B3F0B;
	Fri, 16 Aug 2024 12:31:04 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4D1B32CD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811464; cv=none; b=mdJ5ZcLMfIn6LI0BLNdICE0uJ07VS6DY/l8i+rdXKNrFKjtC/2f5JvT5aK3+Uv4vdQDIPZRVGUj3tYsWX0cNVw3eUGuSlaaQBItQjW5/v4xioB52qOp4215XYgL2DVT8FyF7ECV7zNHlDtE2AJQbUU+oAbT2BtS6h849WNTCacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811464; c=relaxed/simple;
	bh=rziNCHOuvTbPwFQ7BEd56TuY7losLGX21xvhC1xbDkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibXiFTgLfy+1D4kDNb8CeUoymW97DZPRIUyqZSJE/CKWj5kyqN4xet5/Bebo3wPSaDfrN9MVYc4k2zCI/PgGMt5FQVbV5YvCvPCY3VtZqzb7X3JiilcS58wXvV81SvcYsRznnKPyGNP84GsP9qroyZGJpSzlWZ9kz2w73yaDYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63E441BF203;
	Fri, 16 Aug 2024 12:30:55 +0000 (UTC)
Message-ID: <665dee3c-1833-49c9-88d1-9f92475dbb59@ghiti.fr>
Date: Fri, 16 Aug 2024 14:30:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Remove unused GENERATING_ASM_OFFSETS
Content-Language: en-US
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240816101912.1049329-1-zhangchunyan@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240816101912.1049329-1-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Chunyan,

On 16/08/2024 12:19, Chunyan Zhang wrote:
> The macro is not used in the current version of kernel, it looks like
> can be removed to avoid a build warning:
>
> ../arch/riscv/kernel/asm-offsets.c: At top level:
> ../arch/riscv/kernel/asm-offsets.c:7: warning: macro "GENERATING_ASM_OFFSETS" is not used [-Wunused-macros]
>      7 | #define GENERATING_ASM_OFFSETS

So this warning never shows up in a "normal" kernel compilation, but it 
happens when using W=2 (with quite a lot of other warnings).

This unused define indeed seems completely useless, I guess not all 
unused defines fall into this category and we should be careful when 
removing them, but for this one it makes sense so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>
> Fixes: 9639a44394b9 ("RISC-V: Provide a cleaner raw_smp_processor_id()")
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>   arch/riscv/kernel/asm-offsets.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index b09ca5f944f7..cb09f0c4f62c 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -4,8 +4,6 @@
>    * Copyright (C) 2017 SiFive
>    */
>   
> -#define GENERATING_ASM_OFFSETS
> -
>   #include <linux/kbuild.h>
>   #include <linux/mm.h>
>   #include <linux/sched.h>

