Return-Path: <linux-kernel+bounces-381807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F49B04BC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711AF284692
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32D61B394C;
	Fri, 25 Oct 2024 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR1Fokh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158B1FB8B2;
	Fri, 25 Oct 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864521; cv=none; b=gpuXtCCQ5VaDk0JupTVLzHoPIdG4bTpeVr3mUQJYtnpl/sRrAlE2o3e1O8sa+peedgrtTI37Z/ZX0lcML+6XuC7xLuKPo58NkqxRukk9D8fnMmOF6xfHn1hpPP56A3WOTB3t5znqH0SJLOK7Z6Atzy4PvfxS0SDvLC9/AXWTCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864521; c=relaxed/simple;
	bh=FLGB+FcaSbexKSF1euem9Xjilkmzq5io2JyL0qcDAD0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nk+BZC0ULv20DOHjC+YWLb7wljjaggDTLaVR5QUHMpQOAx141eWxoIaQv9aPwDD5W3QZc/FSsdvGJFnNMG09K/hWnT4Cj5An4H5YM1M0ZMlnhRMpItttisHiFR/kARXi3o/NMub8k+f6wzko2uakAJ+Z6cW1ZNs9owWqUXCYFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR1Fokh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E75C4CEE9;
	Fri, 25 Oct 2024 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729864521;
	bh=FLGB+FcaSbexKSF1euem9Xjilkmzq5io2JyL0qcDAD0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QR1Fokh1sok6+ciCoB+vRyDBrFoeEZR6//TqQrRqqAdMfU8aEO8Oe1GvwHzGm9QKC
	 CIkC2NaR0ZuzdUEA7NNOR5hbDsZb4tCibFQCSlRUMQdPVf5tfWdOpX93cC562f9s3f
	 w5alda1H/4ELZqqj/8BppnvSXTle2LLnUSXFMdYoNcY5xhlmQYyjDi4jRiBx48fymA
	 SrA6T4nDigLkEWblYAdLbOSsR2JI9ebBY2zXWNevQ8X4FWg60IbdGRwm81XsAApZvu
	 qL/rSCOtq5eoIP2KOdd+VNz/D7tY9/bs+x9alLeINb7bp5jgNnf5V1EZ+G6+L/90W/
	 d7epq2NLB9irw==
Date: Fri, 25 Oct 2024 08:55:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Sean Wang <sean.wang@mediatek.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241025110111.1321704-1-fshao@chromium.org>
References: <20241025110111.1321704-1-fshao@chromium.org>
Message-Id: <172986441212.1908028.1793967441709561187.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add device tree for MT8188-based Chromebook "Ciri"


On Fri, 25 Oct 2024 18:59:34 +0800, Fei Shao wrote:
> Hi maintainers,
> 
> This series introduces the device trees for Ciri, a MT8188-based
> Chromebook, commercially known as the Lenovo Chromebook Duet (11", 9).
> 
> Ciri is a detachable device based on the ChromeOS Geralt reference
> design, where Geralt is the codename for the MT8188 platform. Ciri has 8
> SKUs to accommodate the combinations of second-source components,
> including audio codecs, speaker amplifiers, and MIPI-DSI panels.
> 
> The Geralt design is not used in any actual products, so its device tree
> is not included.
> 
> The device trees are taken from the ChromeOS downstream v6.1 kernel,
> ported to the mainline kernel and with cleanups. This series aims to
> provide a basic device tree with the enabled components and features.
> Additional support will be added in the future after validation with
> the mainline kernel.
> 
> This series has been tested on top of the next-20241018 branch.
> 
> Patch 1 adds entries for Ciri in the MediaTek DT binding.
> Patch 2 adds the dtsi files for Geralt and Ciri, followed by 8 dts files
> for all the available Ciri SKUs at this moment.
> 
> Note that there are some known dtbs_check warnings, depending on binding
> fix or driver support:
> - sound: Unevaluated 'xxx-dai-link' properties: sent patch[1]
> - amplifier '#sound-dai-cells' and other errors: sent patch[1]
> - dp-tx '#sound-dai-cells' error: sent patch[2]
> - failed to match 'himax,hx83102j': depend on HX83102J support[3]
> 
> [1]:
> https://lore.kernel.org/all/20241025104548.1220076-1-fshao@chromium.org/
> [2]:
> https://lore.kernel.org/all/20241025104310.1210946-1-fshao@chromium.org/
> [3]:
> https://lore.kernel.org/all/TY0PR06MB561105A3386E9D76F429110D9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/
> 
> Regards,
> Fei
> 
> 
> Fei Shao (2):
>   dt-bindings: arm: mediatek: Add MT8188 Lenovo Chromebook Duet (11", 9)
>   arm64: dts: mediatek: Introduce MT8188 Geralt platform based Ciri
> 
>  .../devicetree/bindings/arm/mediatek.yaml     |   13 +
>  arch/arm64/boot/dts/mediatek/Makefile         |    8 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   63 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   54 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   20 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   76 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   67 +
>  .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   52 +
>  .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  413 +++++
>  .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1497 +++++++++++++++++
>  12 files changed, 2317 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> 
> --
> 2.47.0.163.g1226f6d8fa-goog
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8188-geralt-ciri-sku0.dtb mediatek/mt8188-geralt-ciri-sku1.dtb mediatek/mt8188-geralt-ciri-sku2.dtb mediatek/mt8188-geralt-ciri-sku3.dtb mediatek/mt8188-geralt-ciri-sku4.dtb mediatek/mt8188-geralt-ciri-sku5.dtb mediatek/mt8188-geralt-ciri-sku6.dtb mediatek/mt8188-geralt-ciri-sku7.dtb' for 20241025110111.1321704-1-fshao@chromium.org:

arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: sound: Unevaluated properties are not allowed ('displayport-dai-link', 'hs-capture-dai-link', 'hs-playback-dai-link', 'mediatek,adsp', 'mediatek,dai-link', 'mm-dai-link', 'spk-playback-dai-link' were unexpected)
	from schema $id: http://devicetree.org/schemas/sound/mediatek,mt8188-mt6359.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: pmic: regulators: 'compatible' is a required property
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: syscon@10006000: power-controller:power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30: Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32' were unexpected)
	from schema $id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: pmic: regulators: 'compatible' is a required property
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: amplifier@38: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: amplifier@39: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: amplifier@38: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: amplifier@39: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: pmic: regulators: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: pmic: 'adc', 'mt6359codec', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: mailbox@10320000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: mailbox@10330000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: jpeg-decoder@1a040000: iommus: [[142, 685], [142, 686], [142, 690], [142, 691], [142, 692], [142, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: jpeg-decoder@1a040000: iommus: [[142, 685], [142, 686], [142, 690], [142, 691], [142, 692], [142, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: amplifier@38: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: amplifier@39: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[69, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[69, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: /soc/spi@11010000/touchscreen@0: failed to match any schema with compatible: ['himax,hx83102j']
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[69, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[69, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: amplifier@38: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: amplifier@39: '#sound-dai-cells', 'maxim,dsm_param_name', 'sound-name-prefix' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: jpeg-decoder@1a040000: iommus: [[140, 685], [140, 686], [140, 690], [140, 691], [140, 692], [140, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[68, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: jpeg-decoder@1a040000: iommus: [[140, 685], [140, 686], [140, 690], [140, 691], [140, 692], [140, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: audio-codec@19: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sound/everest,es8326.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: amplifier@4f: reg:0:0: 79 is greater than the maximum of 63
	from schema $id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: jpeg-decoder@1a040000: iommus: [[140, 685], [140, 686], [140, 690], [140, 691], [140, 692], [140, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[68, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[68, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: jpeg-decoder@1a040000: iommus: [[142, 685], [142, 686], [142, 690], [142, 691], [142, 692], [142, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[68, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: gpu@13000000: 'volt-bin-mapping' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/gpu/arm,mali-bifrost.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[69, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[68, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[68, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: jpeg-decoder@1a040000: iommus: [[142, 685], [142, 686], [142, 690], [142, 691], [142, 692], [142, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[69, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: jpeg-decoder@1a040000: iommus: [[140, 685], [140, 686], [140, 690], [140, 691], [140, 692], [140, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[69, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: dp-intf@1c015000: power-domains: False schema does not allow [[68, 16]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[69, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: dp-intf@1c113000: power-domains: False schema does not allow [[68, 17]]
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: dp-tx@1c600000: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml#






