Return-Path: <linux-kernel+bounces-304986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370D49627C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556A51C20371
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D317C992;
	Wed, 28 Aug 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUW0x9Pb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608C9149C7A;
	Wed, 28 Aug 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849478; cv=none; b=C7ma6DEMulVah33JE1QPn8PfOoLpr4d1BSrSf4YhdDpvRqBg4copcEsUXU/vVD7nSSZWF3sZkwD/U0d6xmmhhALHe1MvcTbEeEAOATfWHHZZeOVycse6BeU303vgWF6g/gVURhMICSTLIbN+eE7li9ihZsU5UrYEKgGjoUYm5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849478; c=relaxed/simple;
	bh=TSbxJkBH805/VqkXTXpPL73x/9GZAvFJvnqNtqHAuA4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dWkvlBUDZSDR/B9dsgt5xg75ASb4HoWTZUcqMCCIOP6a8RGAUgOkxKphnK5kC976lU7Wf8l/HHTfaVagUwLKQgzALY88MUcMcnLHz4Ju/YJvRBHvt4AijzRBk+WDpB5kk8q4biIQjuDP7FNvEeMn9HbxqD3cWitOw85Zs/LXtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUW0x9Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39ECC4FF1D;
	Wed, 28 Aug 2024 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724849477;
	bh=TSbxJkBH805/VqkXTXpPL73x/9GZAvFJvnqNtqHAuA4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jUW0x9PbFTtb8Bihj1gzPs9QgpnpFDocnEoGrLM2aIwsdEhIYZ0lxc7NwI9AIoww8
	 OeGZXRAV8Nuwt8Nj5/5/x63cgiDx6WWJ53XDRYq59WMQif/9JLxnUC00E1bltqkzdJ
	 IqO+bQBET9IshPXUnZteazT5/kvz9B95ECph60dAfFyVN8dyA8bpfrheKicto2c12D
	 svTu3Ckpmg522KQ5ZN2e49LtoweMUN9sSBbMG3CtdPiaGQqRSmiCFmo7dF/DCVMZpL
	 cU7Q19Boat78iQNn58A6ucFcjYa5oKP8FMgR3chtFT5ypuCrn2VkfFY9b0xfGrcUej
	 1QaoYXR8FvfmQ==
Date: Wed, 28 Aug 2024 07:51:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev, 
 Muhammed Efe Cetin <efectn@protonmail.com>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
 Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240828-dts-v13-0-6bff9896d649@wesion.com>
References: <20240828-dts-v13-0-6bff9896d649@wesion.com>
Message-Id: <172484936695.3462781.6421342148961590287.robh@kernel.org>
Subject: Re: [PATCH v13 0/2] Add Wi-Fi support for Khadas Edge2 and
 fallback compatible for Apple


On Wed, 28 Aug 2024 16:45:39 +0800, Jacobe Zang wrote:
> Add basic Wi-Fi support on Khadas Edge2. Wireless driver need to check "brcm,bcm4329-fmac"
> compatible so add it to Apple's devices.
> 
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> Changes in v13:
>  - Change patch 2/2 argument from driver to bindings.
> 
>  - Link to v12: https://lore.kernel.org/all/20240828033953.967649-1-jacobe.zang@wesion.com/
> 
> Changes in v12:
>  - Add fallback compatible for Apple's devices
> 
>  - Link to v11: https://lore.kernel.org/all/20240816015214.1271162-1-jacobe.zang@wesion.com/
> 
> Changes in v11:
>  - Split DTS and submit separately
> 
>  - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/
> 
> Changes in v10:
>  - Use ret instead unused probe_attach_result in sdio.c
> 
>  - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/
> 
> Changes in v9:
>  - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
>  - Add if statement for brcmf_of_probe in common.c
>  - Retain modifications to of.c other than the return values
> 
>  - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/
> 
> Changes in v8:
>  - Add appropriate errno's for return values that will be
>     send to bus when error occurred.
> 
>  - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/
> 
> Changes in v7:
>  - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
>     value, move clock check to the end of brcmf_of_probe
>  - Add "brcm,bcm4329-fmac" compatible for wifi node
> 
>  - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/
> 
> Changes in v6:
>  - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
>  - Add return if clk didn't set in DTS
> 
>  -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/
> 
> Changes in v5:
>  - Add more commit message to the clock in bindings
>  - Use IS_ERR_OR_NULL as a judgment condition of clk
> 
>  - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/
> 
> Changes in v4:
>  - Change clock description in dt-bindings
>  - Move enable clk from pcie.c to of.c
>  - Add compatible for wifi node in DTS
>  - Add random seed flag for firmware download
> 
>  - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/
> 
> Changes in v3:
>  - Dropped redundant parts in dt-bindings.
>  - Change driver patch title prefix as 'wifi: brcmfmac:'.
>  - Change DTS Wi-Fi node clock-name as 'lpo'.
> 
>  - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/
> 
> Changes in v2:
>  - Add SoB tags for original developer.
>  - Add dt-bindings for pci14e4,449d and clocks.
>  - Replace dev_info to brcmf_dbg in pcie.c
> 
>  - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/
> 
> ---
> Jacobe Zang (2):
>       arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
>       arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible
> 
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi             |  2 +-
>  arch/arm64/boot/dts/apple/t8112-j413.dts              |  2 +-
>  arch/arm64/boot/dts/apple/t8112-j493.dts              |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
>  4 files changed, 19 insertions(+), 3 deletions(-)
> ---
> base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
> change-id: 20240828-dts-1b163375c49c
> 
> Best regards,
> --
> Jacobe Zang <jacobe.zang@wesion.com>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y apple/t8112-j413.dtb apple/t8112-j493.dtb rockchip/rk3588s-khadas-edge2.dtb' for 20240828-dts-v13-0-6bff9896d649@wesion.com:

arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dtb: wifi@0,0: compatible: 'oneOf' conditional failed, one must be fixed:
	['pci14e4,449d', 'brcm,bcm4329-fmac'] is too long
	'pci14e4,449d' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac', 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac', 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac', 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac', 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac', 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac', 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac', 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
	'pci14e4,449d' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dtb: wifi@0,0: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
arch/arm64/boot/dts/apple/t8112-j493.dtb: wifi@0,0: compatible: 'oneOf' conditional failed, one must be fixed:
	['pci14e4,4425', 'brcm,bcm4329-fmac'] is too long
	'pci14e4,4425' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac', 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac', 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac', 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac', 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac', 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac', 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac', 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
arch/arm64/boot/dts/apple/t8112-j493.dtb: wifi@0,0: Unevaluated properties are not allowed ('compatible', 'local-mac-address' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
arch/arm64/boot/dts/apple/t8112-j413.dtb: wifi@0,0: compatible: 'oneOf' conditional failed, one must be fixed:
	['pci14e4,4433', 'brcm,bcm4329-fmac'] is too long
	'pci14e4,4433' is not one of ['brcm,bcm43143-fmac', 'brcm,bcm4341b0-fmac', 'brcm,bcm4341b4-fmac', 'brcm,bcm4341b5-fmac', 'brcm,bcm4329-fmac', 'brcm,bcm4330-fmac', 'brcm,bcm4334-fmac', 'brcm,bcm43340-fmac', 'brcm,bcm4335-fmac', 'brcm,bcm43362-fmac', 'brcm,bcm4339-fmac', 'brcm,bcm43430a0-fmac', 'brcm,bcm43430a1-fmac', 'brcm,bcm43455-fmac', 'brcm,bcm43456-fmac', 'brcm,bcm4354-fmac', 'brcm,bcm4356-fmac', 'brcm,bcm4359-fmac', 'brcm,bcm4366-fmac', 'cypress,cyw4373-fmac', 'cypress,cyw43012-fmac', 'infineon,cyw43439-fmac']
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
arch/arm64/boot/dts/apple/t8112-j413.dtb: wifi@0,0: Unevaluated properties are not allowed ('compatible', 'local-mac-address' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#






