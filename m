Return-Path: <linux-kernel+bounces-517595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44EA382E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33078188550D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D25219EB6;
	Mon, 17 Feb 2025 12:23:42 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16F16C850
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795022; cv=none; b=HAM8MZGySShpO6ffIkGdsBuX3s35VmQi9Zli/mc9iQx3bzCskWgVfB+7+YuWln25Wtdcqc8LAlZCVEzHtLYeIVaGx1mYe+sCtG4bRkk2Ds3IBuSehObFnrHQPiJLNOGbyvVn+o4OAAwvzdsxVsC+/8LrPxSB9HZ2Oqi7hwXXhWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795022; c=relaxed/simple;
	bh=U7SBjO10ecJ12NM0oWnQnrtXlYgDDEGT/pTV7YpPlqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZM5LqSWwV+28q/AActpZ1FkCx91mdxaAU9lV3vjJ/b7SZ+g4FT20TOrQPCPvvt6aG7xAGFh7AIHJ6jVbeg9QdJNufQ/oFIbmagdVsOZuYnhtoQRTvgL9c/FaLt9VuACiQhpRzAYqad2jeR7Fw5BRmwWXPVAFSgUz9OG97LOWj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5AA054419E;
	Mon, 17 Feb 2025 12:23:29 +0000 (UTC)
Message-ID: <199526de-4351-4fd7-8f6a-9e8dbf05c184@ghiti.fr>
Date: Mon, 17 Feb 2025 13:23:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: select DMA_DIRECT_REMAP by RISCV_ISA_SVPBMT and
 ERRATA_THEAD_MAE
Content-Language: en-US
To: Sergey Matyukevich <geomatsi@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Christoph Hellwig <hch@lst.de>
References: <20250116172950.1989748-1-geomatsi@gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250116172950.1989748-1-geomatsi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepvdeludfgleffteekgfelheetvdeugffgiedtueetgedtfeefleeileehieekvddunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemleelvgehmehfrgdtsgemjeeivdgumedusggsfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemleelvgehmehfrgdtsgemjeeivdgumedusggsfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemleelvgehmehfrgdtsgemjeeivdgumedusggsfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepghgvohhmrghtshhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdpr
 hgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehhvghikhhosehsnhhtvggthhdruggvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomh
X-GND-Sasl: alex@ghiti.fr

Hi Sergey,

On 16/01/2025 18:29, Sergey Matyukevich wrote:
> Select DMA_DIRECT_REMAP for the RISC-V extensions that allow to set
> page-based memory types in PTEs according to the requested DMA
> attributes. This is the purpose of Svpbmt or XTheadMae extensions.
> Zicbom or XTheadCmo serve a different purpose, providing instructions
> to flush/invalidate cache blocks.
>
> Fixes: 381cae169853 ("riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM and ERRATA_THEAD_PBMT")
>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>   arch/riscv/Kconfig        | 2 +-
>   arch/riscv/Kconfig.errata | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d4a7ca0388c0..a5dabb744009 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -603,6 +603,7 @@ config RISCV_ISA_SVPBMT
>   	depends on 64BIT && MMU
>   	depends on RISCV_ALTERNATIVE
>   	default y
> +	select DMA_DIRECT_REMAP


 From what I read, DMA_DIRECT_MAP relies on the ability to map pages 
uncached (pgprot_dmacoherent() here 
https://elixir.bootlin.com/linux/v6.13.2/source/kernel/dma/pool.c#L104). 
But CONFIG_RISCV_ISA_SVPBMT does not guarantee that the underlying 
platform supports svpbmt so to me it is wrong to select DMA_DIRECT_MAP, 
we would need some runtime check instead.


>   	help
>   	   Adds support to dynamically detect the presence of the Svpbmt
>   	   ISA-extension (Supervisor-mode: page-based memory types) and
> @@ -787,7 +788,6 @@ config RISCV_ISA_ZICBOM
>   	depends on RISCV_ALTERNATIVE
>   	default y
>   	select RISCV_DMA_NONCOHERENT


And in the same way, we should not enable RISCV_DMA_NONCOHERENT since 
CONFIG_RISCV_ISA_ZICBOM does guarantee the presence of zicbom. Because 
then in mm/dma-noncoherent.c, the cache flush operations are nops.

Or am I missing something?

Thanks,

Alex


> -	select DMA_DIRECT_REMAP
>   	help
>   	   Adds support to dynamically detect the presence of the ZICBOM
>   	   extension (Cache Block Management Operations) and enable its
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 2acc7d876e1f..3bcae5bd3231 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -86,6 +86,7 @@ config ERRATA_THEAD_MAE
>   	bool "Apply T-Head's memory attribute extension (XTheadMae) errata"
>   	depends on ERRATA_THEAD && 64BIT && MMU
>   	select RISCV_ALTERNATIVE_EARLY
> +	select DMA_DIRECT_REMAP
>   	default y
>   	help
>   	  This will apply the memory attribute extension errata to handle the
> @@ -96,7 +97,6 @@ config ERRATA_THEAD_MAE
>   config ERRATA_THEAD_CMO
>   	bool "Apply T-Head cache management errata"
>   	depends on ERRATA_THEAD && MMU
> -	select DMA_DIRECT_REMAP
>   	select RISCV_DMA_NONCOHERENT
>   	select RISCV_NONSTANDARD_CACHE_OPS
>   	default y

