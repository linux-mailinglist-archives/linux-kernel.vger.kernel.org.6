Return-Path: <linux-kernel+bounces-193706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DB28D30EC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593FE1C21206
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD616D9D9;
	Wed, 29 May 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="W9qTdkjE"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A612168C2F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716970457; cv=none; b=oUtXWqOnoCbQUEvbAkZ61H+Hui/NjTPcgeWaYIO/gItQLdDQsOzGPu0e5DmgfvvWp5o6VCi3nGlPfyNwnk2y9/FqhAg8Kk5WlPGSGZ8vWcNVI7j574GGompYFNwvGw1XIRWx8yDxEN8TAfCXE0Hz0z27a/5y7r1U5+LBib+DLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716970457; c=relaxed/simple;
	bh=taHQSmmDXNFY6nJbwdn2t25HBag5U344k6khQnFMUys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBYqeZYK4XzIASetYovz22yQTp8D3TFpk6o0c8tJBhEmgCnrs1XUmbBUDL5Bvorw/Z6Sbg9QtZCqejROXgXwfQoMT/POHMcqS9lxeXifNzO2JrsmQw7Hu6U0wPcDHd91HTFymuaSRXmK1wI3TC/hT5e20ha+1a71Lza5bE144P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=W9qTdkjE; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1716970452;
	bh=VLyOIVHLU95mQ240RHuf6Ii/24aWHKil9L7bk/lJvVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W9qTdkjE50eVY4m38Xna9RRypsO9BtrskqY6vWcjxSrgVi39Z93csviy5xBM/UNMr
	 ICfG1KTNxzfBD4X3x2uVCllEt+4f/FgdJnx06ZEYrCOu2fotVGk6X4r4rDufY4QLCF
	 QvRN+Ox7uPNwTiyPiOopyQrTGyqQjoexx4p7oe65iXBQ6luGAX4rIXjZ3jylG9s7CI
	 MBlmwPrfB0FfKh45fiG8FNWDLGxl7oZDjA4vQrA89Pbrvfz2QJKWAJpc1asSxcZT8H
	 xI1dHj9McpQeLHMkGUip+8jxjs8rAg5MwNQFSUfWuMC+hVWVv6mUFKDFY8eQXG3nl/
	 zNpm84X9VKX5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Vq2GT6cdtz4x2w;
	Wed, 29 May 2024 18:14:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Esben Haabendal <esben@geanix.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe
 Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
In-Reply-To: <87le3ukqnj.fsf@geanix.com>
References: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
 <20240528-fsl-ifc-config-v2-2-5fd7be76650d@geanix.com>
 <096662e8-03cf-4c13-baa0-11918cab7511@kernel.org>
 <87le3ukqnj.fsf@geanix.com>
Date: Wed, 29 May 2024 18:14:07 +1000
Message-ID: <87ed9l3ui8.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Esben Haabendal <esben@geanix.com> writes:
> Krzysztof Kozlowski <krzk@kernel.org> writes:
>
>> On 28/05/2024 14:28, Esben Haabendal wrote:
>>> With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
>>> to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
>>> selected in config snippets.
>>> 
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>>  arch/powerpc/configs/85xx-hw.config | 2 ++
>>>  1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
>>> index 524db76f47b7..8aff83217397 100644
>>> --- a/arch/powerpc/configs/85xx-hw.config
>>> +++ b/arch/powerpc/configs/85xx-hw.config
>>> @@ -24,6 +24,7 @@ CONFIG_FS_ENET=y
>>>  CONFIG_FSL_CORENET_CF=y
>>>  CONFIG_FSL_DMA=y
>>>  CONFIG_FSL_HV_MANAGER=y
>>> +CONFIG_FSL_IFC=y
>>
>> Does not look like placed according to config order.
>
> Correct.
>
>> This is not alphabetically sorted, but as Kconfig creates it (make
>> savedefconfig).
>
> Are you sure about this?
>
> It looks very much alphabetically sorted, with only two "errors"
>
> $ diff -u 85xx-hw.config 85xx-hw.config.sorted 
> --- 85xx-hw.config      2024-05-28 15:05:44.665354428 +0200
> +++ 85xx-hw.config.sorted       2024-05-28 15:05:56.102019081 +0200
> @@ -15,8 +15,8 @@
>  CONFIG_DMADEVICES=y
>  CONFIG_E1000E=y
>  CONFIG_E1000=y
> -CONFIG_EDAC=y
>  CONFIG_EDAC_MPC85XX=y
> +CONFIG_EDAC=y
>  CONFIG_EEPROM_AT24=y
>  CONFIG_EEPROM_LEGACY=y
>  CONFIG_FB_FSL_DIU=y
> @@ -71,10 +71,10 @@
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_NAND_FSL_ELBC=y
>  CONFIG_MTD_NAND_FSL_IFC=y
> -CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_PHYSMAP_OF=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PLATRAM=y
> +CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_NETDEVICES=y
>  CONFIG_NVRAM=y
>
> I don't think that this file has ever been Kconfig sorted since it was
> created back in ancient times.
>
> And as it is merged with other config snippets using merge_into_defconfig
> function. I have no idea how to use savedefconfig to maintain such a snippet.
> It would require doing the reverse of the merge_into_defconfig.

Right. This is a config fragment, not a full config, so it's not managed
with savedefconfig.

Alphabetical order is preferable when adding new symbols.

cheers

