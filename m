Return-Path: <linux-kernel+bounces-554445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE4A597D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F516DA87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B624422F16C;
	Mon, 10 Mar 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFQ+7R+a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E037122DF8C;
	Mon, 10 Mar 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617382; cv=none; b=qGyNBWGrC9sFjTxJ1jvGrgQfh6X25g9EZ7Jr9buFKOEbkhn9hJDC5J2+I0dDXINOms7LXVoPxHXel9fwlpvrrSAHi/ekUo9XXmCoSdZfjAF+w/cT4gItU6RjI+gedP4rtS8zpXx1h6mkKoGFvNUt7CDkna0FZqGqBBprNXRHvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617382; c=relaxed/simple;
	bh=7EEMVaFexgLc6pVJL7mrzAPNCcixahyfiK4unhrdXiw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=sCM9Dxhgv/CDxKys2ClwPxbFP8rDT6EpqgBd9W2eQWCcgfhxkQG0RkWan4h7vy+BcFgG0bmCPTENEQz9bI0ASjWROWFkupA015SZLDRy/DppJbOG31waVjXCjd1Y5WN3Qr9DpL+53UhaVnCDnHI3s5uWFHS8ChaZN/lVnglChVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFQ+7R+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD09C4CEED;
	Mon, 10 Mar 2025 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741617381;
	bh=7EEMVaFexgLc6pVJL7mrzAPNCcixahyfiK4unhrdXiw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=AFQ+7R+aRontN6fPv0/HgRdTHM+2jCP8gLb3fFNBIIqBjJgaSNZTzlJCpJtDit3DX
	 /k7CpIG8MNvyoClOmWfI+0zuclf7yQvycIW8C7dCSVE75gQbDGVXqUYFk6G6pnF3Fv
	 5ttun5Y6xWEc0030EoS7Cryb86LEPT61w+DREAfr0zc8NtCYArA7opqJPX3zZejakD
	 y7lymlPh1tiGqaRt2rlgq3lbTbJZNgSCfbFvAoBdqj23xJ8aEtQ2yAWxmfYgybRN/j
	 aY+SDuFXh1C5SKGHOmd56vXuuGxCtD+0MwvNpdeO3bVdearATPNJLwGPKz0vpjUM1a
	 ZnNR0JNtov2pw==
Date: Mon, 10 Mar 2025 09:36:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>, 
 Ben Hutchings <ben@decadent.org.uk>, Conor Dooley <conor+dt@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 upstream@airoha.com, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Lee Jones <lee@kernel.org>, 
 devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Danzberger <dd@embedd.com>, Yangyu Chen <cyy@cyyself.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-usb@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Message-Id: <174161712595.4185316.12073621496624773779.robh@kernel.org>
Subject: Re: [PATCH 00/13] airoha: en7581: clk cleanup + USB support


On Sun, 09 Mar 2025 14:29:31 +0100, Christian Marangi wrote:
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
> To correctly handle this, the SCU is changed to a simple-mfd
> implemenetation and the clock controller updated to follow this new
> node structure. Both implementation are supported to handle old
> binding.
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
> Christian Marangi (13):
>   clk: en7523: convert driver to regmap API
>   clk: en7523: generalize register clocks function
>   dt-bindings: soc: airoha: add SCU SSR Serdes port binding
>   dt-bindings: soc: airoha: add Documentation for Airoha AN7581 SCU SSR
>   dt-bindings: mfd: add Documentation for Airoha EN7581 SCU
>   dt-bindings: clock: airoha: make reg optional for Airoha EN7581
>   clk: en7523: support getting regmap from parent node for EN7581
>   soc: airoha: add support for configuring SCU SSR Serdes port
>   dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
>   phy: airoha: Add support for Airoha AN7581 USB PHY
>   usb: host: add ARCH_AIROHA in XHCI MTK dependency
>   arm64: dts: airoha: en7581: convert SCU clock node to MFD
>     implementation
>   arm64: dts: airoha: en7581: add USB and SCU SSR nodes
> 
>  .../bindings/clock/airoha,en7523-scu.yaml     |  13 +-
>  .../mfd/airoha,en7581-scu-sysctl.yaml         |  68 +++
>  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 106 ++++
>  .../soc/airoha/airoha,an7581-scu-ssr.yaml     | 106 ++++
>  MAINTAINERS                                   |  15 +
>  arch/arm64/boot/dts/airoha/en7581.dtsi        |  74 ++-
>  drivers/clk/clk-en7523.c                      | 258 ++++----
>  drivers/phy/Kconfig                           |   1 +
>  drivers/phy/Makefile                          |   3 +-
>  drivers/phy/airoha/Kconfig                    |  13 +
>  drivers/phy/airoha/Makefile                   |   3 +
>  drivers/phy/airoha/phy-airoha-usb.c           | 554 ++++++++++++++++++
>  drivers/soc/Kconfig                           |   1 +
>  drivers/soc/Makefile                          |   1 +
>  drivers/soc/airoha/Kconfig                    |  18 +
>  drivers/soc/airoha/Makefile                   |   3 +
>  drivers/soc/airoha/airoha-scu-ssr.c           | 195 ++++++
>  drivers/usb/host/Kconfig                      |   2 +-
>  include/dt-bindings/soc/airoha,scu-ssr.h      |  24 +
>  include/linux/soc/airoha/airoha-scu-ssr.h     |  17 +
>  include/linux/soc/soc/airoha-scu-ssr.h        |  17 +
>  21 files changed, 1355 insertions(+), 137 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/airoha/airoha,an7581-scu-ssr.yaml
>  create mode 100644 drivers/phy/airoha/Kconfig
>  create mode 100644 drivers/phy/airoha/Makefile
>  create mode 100644 drivers/phy/airoha/phy-airoha-usb.c
>  create mode 100644 drivers/soc/airoha/Kconfig
>  create mode 100644 drivers/soc/airoha/Makefile
>  create mode 100644 drivers/soc/airoha/airoha-scu-ssr.c
>  create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h
>  create mode 100644 include/linux/soc/airoha/airoha-scu-ssr.h
>  create mode 100644 include/linux/soc/soc/airoha-scu-ssr.h
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/airoha/' for 20250309132959.19045-1-ansuelsmth@gmail.com:

arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fab0000: compatible:0: 'mediatek,mtk-xhci' is not one of ['mediatek,mt2701-xhci', 'mediatek,mt2712-xhci', 'mediatek,mt7622-xhci', 'mediatek,mt7623-xhci', 'mediatek,mt7629-xhci', 'mediatek,mt7986-xhci', 'mediatek,mt7988-xhci', 'mediatek,mt8173-xhci', 'mediatek,mt8183-xhci', 'mediatek,mt8186-xhci', 'mediatek,mt8188-xhci', 'mediatek,mt8192-xhci', 'mediatek,mt8195-xhci', 'mediatek,mt8365-xhci']
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fab0000: compatible: ['mediatek,mtk-xhci'] is too short
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fad0000: compatible:0: 'mediatek,mtk-xhci' is not one of ['mediatek,mt2701-xhci', 'mediatek,mt2712-xhci', 'mediatek,mt7622-xhci', 'mediatek,mt7623-xhci', 'mediatek,mt7629-xhci', 'mediatek,mt7986-xhci', 'mediatek,mt7988-xhci', 'mediatek,mt8173-xhci', 'mediatek,mt8183-xhci', 'mediatek,mt8186-xhci', 'mediatek,mt8188-xhci', 'mediatek,mt8192-xhci', 'mediatek,mt8195-xhci', 'mediatek,mt8365-xhci']
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#
arch/arm64/boot/dts/airoha/en7581-evb.dtb: usb@1fad0000: compatible: ['mediatek,mtk-xhci'] is too short
	from schema $id: http://devicetree.org/schemas/usb/mediatek,mtk-xhci.yaml#






