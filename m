Return-Path: <linux-kernel+bounces-534013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D5A4617C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122611888D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F9221704;
	Wed, 26 Feb 2025 13:58:26 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A0B221545
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578306; cv=none; b=dpMoVodCahfIGfMzuv5WMR3G0Lh+TZQprYUQe+22dqQ5TsVvnXgcaRJ07EZbgbhQZw9RvGsSCMkO5GrUIvLBMHDkU8/msyRIyjAVQS+ijN3dyAm3yLWQsFvJhXc5o+WGnu2LnhxuBTvNtwWXBIAMWeNZyk52cxyWc5sHtdHlzlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578306; c=relaxed/simple;
	bh=idZKW56RqDJAjx8luhEO2SkLJKSf8fJkf2uO+LILXy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M6M94ncXItvd4/rIjDqpSXI1aYGGyRIqRHc59BQYOLaZiui62yvsExHYtWV/jNb4W7Gv8GWa8kO/jHQ6gsx0K4Q46/Ykr4zPclKLLln0iYbkPyr397E3OPv1Am3rsDi5cJKGtcvsb4lR2FnFrudA+vwu3xINeHq3WstCaSKZU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54F43443E5;
	Wed, 26 Feb 2025 13:58:17 +0000 (UTC)
Message-ID: <1f19a967-d240-4587-98d6-dfae24c6830a@ghiti.fr>
Date: Wed, 26 Feb 2025 14:58:16 +0100
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
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Heiko Stuebner <heiko@sntech.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20250116172950.1989748-1-geomatsi@gmail.com>
 <199526de-4351-4fd7-8f6a-9e8dbf05c184@ghiti.fr> <Z7b6YGiUiUYp9lU-@curiosity>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Z7b6YGiUiUYp9lU-@curiosity>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepuddtvddvvdfhvdevgfeiieduvedvjeegfeegkeejgefgfeetiefftdeuiedtueehnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemrgektddumeegfhegfeemgeekudeimeeisggtfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepghgvohhmrghtshhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdri
 hhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehhvghikhhosehsnhhtvggthhdruggvpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomh
X-GND-Sasl: alex@ghiti.fr

+cc Marek

On 20/02/2025 10:48, Sergey Matyukevich wrote:
> Hi Alexandre,
>
> On Mon, Feb 17, 2025 at 01:23:28PM +0100, Alexandre Ghiti wrote:
>> Hi Sergey,
>>
>> On 16/01/2025 18:29, Sergey Matyukevich wrote:
>>> Select DMA_DIRECT_REMAP for the RISC-V extensions that allow to set
>>> page-based memory types in PTEs according to the requested DMA
>>> attributes. This is the purpose of Svpbmt or XTheadMae extensions.
>>> Zicbom or XTheadCmo serve a different purpose, providing instructions
>>> to flush/invalidate cache blocks.
>>>
>>> Fixes: 381cae169853 ("riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM and ERRATA_THEAD_PBMT")
>>>
>>> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
>>> ---
>>>    arch/riscv/Kconfig        | 2 +-
>>>    arch/riscv/Kconfig.errata | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index d4a7ca0388c0..a5dabb744009 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -603,6 +603,7 @@ config RISCV_ISA_SVPBMT
>>>    	depends on 64BIT && MMU
>>>    	depends on RISCV_ALTERNATIVE
>>>    	default y
>>> +	select DMA_DIRECT_REMAP
>>
>>  From what I read, DMA_DIRECT_MAP relies on the ability to map pages uncached
>> (pgprot_dmacoherent() here
>> https://elixir.bootlin.com/linux/v6.13.2/source/kernel/dma/pool.c#L104). But
>> CONFIG_RISCV_ISA_SVPBMT does not guarantee that the underlying platform
>> supports svpbmt so to me it is wrong to select DMA_DIRECT_MAP, we would need
>> some runtime check instead.
> IIUC this function highlights coherent dma allocation options and their
> requirements even more clearly:
> - https://elixir.bootlin.com/linux/v6.13.2/source/kernel/dma/direct.c#L222
>
>>>    	help
>>>    	   Adds support to dynamically detect the presence of the Svpbmt
>>>    	   ISA-extension (Supervisor-mode: page-based memory types) and
>>> @@ -787,7 +788,6 @@ config RISCV_ISA_ZICBOM
>>>    	depends on RISCV_ALTERNATIVE
>>>    	default y
>>>    	select RISCV_DMA_NONCOHERENT
>>
>> And in the same way, we should not enable RISCV_DMA_NONCOHERENT since
>> CONFIG_RISCV_ISA_ZICBOM does guarantee the presence of zicbom. Because then
>> in mm/dma-noncoherent.c, the cache flush operations are nops.
>>
>> Or am I missing something?
> This is my understanding as well. In fact this patch is almost useless.
> It would only allow to enable DMA_GLOBAL_POOL for platforms that support
> Zicbom, but do not support Svpbmt.
>
> The actual problem is that the RISC-V kernel image cannot have both
> DMA_DIRECT_REMAP and DMA_GLOBAL_POOL since they are now mutually
> exclusive in kernel/dma/Kconfig. This limitation is not convenient for
> RISC-V, where kernels can be built with support for multiple extensions
> and errata. But on boot only appropriate subset of them is enabled based
> on the chip's VENDOR_ID and selected dtb.
>
> Currently a portable RISC-V kernel is suitable only for platforms with
> support for both Zicbom and Svpbmt or their vendor-specific alternatives.
> So it doesn't really matter where DMA_DIRECT_REMAP is selected. Platforms
> without Svpbmt need to build their own non-portable kernels anyway,
> enabling support for DMA_GLOBAL_POOL. For instance, Starfive and Andes
> in arch/riscv/Kconfig.errata and drivers/soc/renesas/Kconfig respectively.
>
> Maybe one possible option would be to revert commit da323d464070
> ("dma-direct: add dependencies to CONFIG_DMA_GLOBAL_POOL") and add runtime
> checks in dma_direct_alloc for dma_alloc_from_global_coherent.


And dma_common_contiguous_remap(). Others? I guess the best would be to 
have a patch to propose, unless Christoph or Marek answer with ideas.

Can you prepare something Sergey?

Thanks,

Alex


>
> In that case RISC-V kernels could be built with support for both
> DMA_GLOBAL_POOL and DMA_DIRECT_REMAP. Global pool code path could be
> enabled only for platforms that explicitly specify it in their dtbs.
>
> Regards,
> Sergey
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

