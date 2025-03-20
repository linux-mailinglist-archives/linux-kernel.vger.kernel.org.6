Return-Path: <linux-kernel+bounces-570169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDCA6AD14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A03468181
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F311B227BA9;
	Thu, 20 Mar 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYloGAYR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF41F5F6;
	Thu, 20 Mar 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495176; cv=none; b=BMGePlvlwFAsY8a89k8Px2G7RPY4D8OiaEuq36Gznx6LU7LBczxA4yfbtBIN307eFHN04aXMzwGPmQZE87YjrqMKGyH9xv/kdCsOwi6sxS5XHrI++NGfFe+O/CVjQ2uluAW5FaEk9sQE7p8vL1z87z/BbUr3164QEl9X8B4d0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495176; c=relaxed/simple;
	bh=WqjD83gS59KXnxcWN0xrv2Qy66XqwIZlhcsvnHNzlD0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WF6TKdFX9CryfeLy1CMFVUYBYwPpsvSxHSRBX0s3yDcptrL7cw+HCw+d0r7iS7mDHCXg/d95EM44Y/oQDIU84zlI3Sps8rfjXmnJp+V3oDDBOfsUM5fedii6frWLxJ8f7AcTcc2dC8BK57xPdFPOx/saOOCgzf1/V1GYNY1qdEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYloGAYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691C4C4CEDD;
	Thu, 20 Mar 2025 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742495174;
	bh=WqjD83gS59KXnxcWN0xrv2Qy66XqwIZlhcsvnHNzlD0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=JYloGAYRUHZ9s4ndZMNiZ/YXTnxxxYiyDHj0Hp2VzGq3o+btOYbamd9ZiuFhWFMet
	 ie3338Y/XRLdUCpjJyC3jborHQ/CXIIcVuOUVVK9U/rgIm5/VFx7Y1YS4wkFLVCDtw
	 NxtFT5PZepI7IN/DrIOQSmiiHzyZN6y4L/goZn/FeHhICSNh+acqedzYpPcX+zCvRz
	 zhiyJ8Z6cpsyttti+B/CqOcRvhgWw3QnIpYjK0Go3Z+AU3KMHdGzRyH2j6HzO8MXH/
	 AjBZ8JDhSha0K3F92CqtjR4pU4dQ8OkZTVExZRrdd4MLrd7BZtl3cpcRusyzQ7ISi7
	 Mu66NbJSYYULA==
Date: Thu, 20 Mar 2025 13:26:13 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Felix Fietkau <nbd@nbd.name>, devicetree@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Turquette <mturquette@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-arm-kernel@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 linux-clk@vger.kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>, 
 upstream@airoha.com, linux-mediatek@lists.infradead.org, 
 Ben Hutchings <ben@decadent.org.uk>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Daniel Danzberger <dd@embedd.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-usb@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-phy@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>, 
 linux-kernel@vger.kernel.org
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
Message-Id: <174249492019.658064.14719387276656076364.robh@kernel.org>
Subject: Re: [PATCH v2 00/11] airoha: en7581: clk cleanup + USB support


On Thu, 20 Mar 2025 14:00:23 +0100, Christian Marangi wrote:
> This series implement all the changes required to correctly handle
> USB support for the Airoha EN7581 SoC.
> 
> The first few patch are cleanup for the clock driver and the
> introduction of the SCU SSR SoC driver.
> 
> The SoC always support USB 2.0 but for USB 3.0 it needs additional
> configuration for the Serdes port. Such port can be either configured
> for USB usage or for PCIe lines or HSGMII and these are configured
> in the SCU space.
> 
> The xHCI USB is based on the Mediatek implementation but the PHY
> handling although conceptually similar, is indded different compared
> to Mediatek due to SSR checks and different port power up.
> 
> The SSR driver expose an API to poll the current status of the Serdes
> port and the USB PHY driver validates it. Refer to the specific commit
> for additional info.
> 
> Consider that there is currently an inconsistency as AN7581 and
> EN7581 refer to the same thing. This is due to the fact that
> the SoC born under EcoNet but then was acquired by Airoha.
> 
> Changes v2:
> - Drop changes for simple-mfd
> - Rework PHY node structure to single node
> - Drop port-id property in favor of serdes-port and
>   usb2-monitor-clock-sel
> - Make the SSR driver probe from the clock driver
> 
> Christian Marangi (11):
>   clk: en7523: convert driver to regmap API
>   clk: en7523: generalize register clocks function
>   dt-bindings: clock: en7523: add Documentation for Airoha AN7581 SCU
>     SSR
>   soc: airoha: add support for configuring SCU SSR Serdes port
>   clk: en7523: define and register SoC SCU SSR driver for EN7581
>   soc: airoha: scu-ssr: expose API to read current Serdes Port mode
>   dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
>   phy: move Airoha PCIe PHY driver to dedicated directory
>   phy: airoha: Add support for Airoha AN7581 USB PHY
>   usb: host: add ARCH_AIROHA in XHCI MTK dependency
>   arm64: dts: airoha: en7581: add USB nodes
> 
>  .../bindings/clock/airoha,en7523-scu.yaml     |  101 +-
>  .../bindings/phy/airoha,an7581-usb-phy.yaml   |   83 ++
>  MAINTAINERS                                   |   21 +-
>  arch/arm64/boot/dts/airoha/en7581.dtsi        |   49 +
>  drivers/clk/clk-en7523.c                      |  340 +++--
>  drivers/phy/Kconfig                           |   11 +-
>  drivers/phy/Makefile                          |    5 +-
>  drivers/phy/airoha/Kconfig                    |   23 +
>  drivers/phy/airoha/Makefile                   |    4 +
>  drivers/phy/airoha/phy-airoha-pcie-regs.h     |  494 +++++++
>  drivers/phy/airoha/phy-airoha-pcie.c          | 1290 +++++++++++++++++
>  drivers/phy/airoha/phy-airoha-usb.c           |  571 ++++++++
>  drivers/soc/Kconfig                           |    1 +
>  drivers/soc/Makefile                          |    1 +
>  drivers/soc/airoha/Kconfig                    |   18 +
>  drivers/soc/airoha/Makefile                   |    3 +
>  drivers/soc/airoha/airoha-scu-ssr.c           |  271 ++++
>  drivers/usb/host/Kconfig                      |    2 +-
>  .../dt-bindings/phy/airoha,an7581-usb-phy.h   |   11 +
>  include/dt-bindings/soc/airoha,scu-ssr.h      |   11 +
>  include/linux/clk/clk-en7523.h                |   10 +
>  include/linux/soc/airoha/airoha-scu-ssr.h     |   34 +
>  22 files changed, 3202 insertions(+), 152 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
>  create mode 100644 drivers/phy/airoha/Kconfig
>  create mode 100644 drivers/phy/airoha/Makefile
>  create mode 100644 drivers/phy/airoha/phy-airoha-pcie-regs.h
>  create mode 100644 drivers/phy/airoha/phy-airoha-pcie.c
>  create mode 100644 drivers/phy/airoha/phy-airoha-usb.c
>  create mode 100644 drivers/soc/airoha/Kconfig
>  create mode 100644 drivers/soc/airoha/Makefile
>  create mode 100644 drivers/soc/airoha/airoha-scu-ssr.c
>  create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h
>  create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h
>  create mode 100644 include/linux/clk/clk-en7523.h
>  create mode 100644 include/linux/soc/airoha/airoha-scu-ssr.h
> 
> --
> 2.48.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/airoha/' for 20250320130054.4804-1-ansuelsmth@gmail.com:

arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fab0000: compatible:0: 'mediatek,mtk-xhci' is not one of ['mediatek,mt2701-xhci', 'mediatek,mt2712-xhci', 'mediatek,mt7622-xhci', 'mediatek,mt7623-xhci', 'mediatek,mt7629-xhci', 'mediatek,mt7986-xhci', 'mediatek,mt7988-xhci', 'mediatek,mt8173-xhci', 'mediatek,mt8183-xhci', 'mediatek,mt8186-xhci', 'mediatek,mt8188-xhci', 'mediatek,mt8192-xhci', 'mediatek,mt8195-xhci', 'mediatek,mt8365-xhci']
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fab0000: compatible: ['mediatek,mtk-xhci'] is too short
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fad0000: compatible:0: 'mediatek,mtk-xhci' is not one of ['mediatek,mt2701-xhci', 'mediatek,mt2712-xhci', 'mediatek,mt7622-xhci', 'mediatek,mt7623-xhci', 'mediatek,mt7629-xhci', 'mediatek,mt7986-xhci', 'mediatek,mt7988-xhci', 'mediatek,mt8173-xhci', 'mediatek,mt8183-xhci', 'mediatek,mt8186-xhci', 'mediatek,mt8188-xhci', 'mediatek,mt8192-xhci', 'mediatek,mt8195-xhci', 'mediatek,mt8365-xhci']
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fad0000: compatible: ['mediatek,mtk-xhci'] is too short
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#






