Return-Path: <linux-kernel+bounces-551162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF3A568DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BA7189763C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E59321ABA2;
	Fri,  7 Mar 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIyhPx3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47221A452;
	Fri,  7 Mar 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353962; cv=none; b=DKMflIh5+bRQxYvEaFzcEqnzx7SYN8LmZu89DM24hZr436npMbJuTJK/xIiA/kAYdPWUfjaFr103lT51cLRb4rhJ8X3LXFHuylYypMPU50R2DFXIZ/l5Vu4Ry/TPT/X1RBziVsXlq3zX1zJMFw6lWesMWDtMnK3UiaQpKtO90pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353962; c=relaxed/simple;
	bh=yqUeHKLUWqPb7pEaBgZimIff4G2SozbiDGDTN0fcW6g=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=nvJL2J216DQzKk6GXOkVDtXk1wjVzMLA4JkwGiFj5tmqh75dwMDy8/5e4jNqZYXioXlPFJG4xPjNPsPMhkRWBbnqqUakrHcAd3H+mcNod1xk/fSH8vZvLlW0ev9qTJSJApbUvAvcMsIuTX8ICXWLlghkv/b9Rjnen53WOJqg+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIyhPx3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F39C4CED1;
	Fri,  7 Mar 2025 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741353961;
	bh=yqUeHKLUWqPb7pEaBgZimIff4G2SozbiDGDTN0fcW6g=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YIyhPx3chIXecJfkgbuVJSesMmg0y88AL9CU3AVb3kgLB8x7qnouYLDtX54u62EfD
	 O+UmS68TXuoLvNk2tvZhxIzMF29IKTqE+bBr0GX0AWZi9tciN6S+ysRwsByGcPXj8U
	 oyN0Ib5DqRJN/U7GYajw0oclLaPYdHAwmn3gWicGZLc7puCRA7nPu7B764NOMyMoFv
	 dWkjajPbWh+/0+cEkmv4+l2K+DaRz6tXXLSPmT3Jb0qqBaFrCwXqF66YvzIaUlvcWS
	 0+oViuPe2CqTZydvYwUZ+66d0XDLYfYbY1S0GgtBJS0u5ZL0nT8PfFD7fCBAgA8aSO
	 vqop2U3hFAIbQ==
Date: Fri, 07 Mar 2025 07:25:59 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-kernel@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org
To: ernestvanhoecke@gmail.com
In-Reply-To: <20250307101758.27943-1-ernest.vanhoecke@toradex.com>
References: <20250307101758.27943-1-ernest.vanhoecke@toradex.com>
Message-Id: <174135385275.4031184.1416379470522159928.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] ARM: dts: apalis/colibri-imx6: Add support for
 v1.2


On Fri, 07 Mar 2025 11:17:47 +0100, ernestvanhoecke@gmail.com wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Apalis/Colibri iMX6 V1.2 replaced the STMPE811 ADC/touch controller,
> which is EOL, with the TLA2024 ADC and AD7879 touch controller.
> 
> Accurately describe the new hardware.
> 
> v1.1 of these SoMs is still described by the following DTSI files:
> imx6qdl-apalis.dtsi
> imx6qdl-colibri.dtsi
> 
> The STMPE811 touchscreen controller is no longer disabled by default.
> The STMPE811 is self contained within the SoM, therefore, disabling it
> is not the correct default behavior.
> 
> v1.2 is now supported by a DTSI that modifies v1.1:
> imx6qdl-apalis-v1.2.dtsi
> imx6qdl-colibri-v1.2.dtsi
> 
> For each carrier board using these modules, a new DTS file was added
> that includes the v1.1 DTS and modifies it with this v1.2 DTSI.
> 
> The original DTS can be used for modules up to and including v1.1.
> 
> v2: Fixed the "From" field
> v1: https://lore.kernel.org/all/20250227170556.589668-1-ernest.vanhoecke@toradex.com/
> 
> Ernest Van Hoecke (2):
>   ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
>   ARM: dts: apalis/colibri-imx6: Add support for v1.2
> 
>  arch/arm/boot/dts/nxp/imx/Makefile            |  9 +++
>  .../dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts | 11 ++++
>  .../nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts   | 11 ++++
>  .../nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts   | 11 ++++
>  .../dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts  | 11 ++++
>  .../nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts   | 11 ++++
>  .../dts/nxp/imx/imx6q-apalis-v1.2-eval.dts    | 11 ++++
>  .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts  | 11 ++++
>  .../nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts  | 11 ++++
>  .../dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts   | 11 ++++
>  .../boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi | 57 +++++++++++++++++++
>  arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi |  1 -
>  .../dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi     | 57 +++++++++++++++++++
>  .../arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi |  1 -
>  14 files changed, 222 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis-v1.2.dtsi
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri-v1.2.dtsi
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/nxp/' for 20250307101758.27943-1-ernest.vanhoecke@toradex.com:

arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /soc/bus@2100000/i2c@21a0000/pcie-switch@58: failed to match any schema with compatible: ['plx,pex8605']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu1_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: panel-lvds: compatible:0: 'panel-lvds' is not one of ['admatec,9904379', 'auo,b101ew05', 'auo,g084sn05', 'chunghwa,claa070wp03xg', 'edt,etml0700z9ndha', 'hannstar,hsd101pww2', 'hydis,hv070wx2-1e0', 'jenson,bl-jt60050-01a', 'tbs,a711-panel']
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval.dtb: panel-lvds: compatible: ['panel-lvds'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: panel-lvds: compatible:0: 'panel-lvds' is not one of ['admatec,9904379', 'auo,b101ew05', 'auo,g084sn05', 'chunghwa,claa070wp03xg', 'edt,etml0700z9ndha', 'hannstar,hsd101pww2', 'hydis,hv070wx2-1e0', 'jenson,bl-jt60050-01a', 'tbs,a711-panel']
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-eval-v1.2.dtb: panel-lvds: compatible: ['panel-lvds'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: panel-lvds: compatible:0: 'panel-lvds' is not one of ['admatec,9904379', 'auo,b101ew05', 'auo,g084sn05', 'chunghwa,claa070wp03xg', 'edt,etml0700z9ndha', 'hannstar,hsd101pww2', 'hydis,hv070wx2-1e0', 'jenson,bl-jt60050-01a', 'tbs,a711-panel']
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora.dtb: panel-lvds: compatible: ['panel-lvds'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: panel-lvds: compatible:0: 'panel-lvds' is not one of ['admatec,9904379', 'auo,b101ew05', 'auo,g084sn05', 'chunghwa,claa070wp03xg', 'edt,etml0700z9ndha', 'hannstar,hsd101pww2', 'hydis,hv070wx2-1e0', 'jenson,bl-jt60050-01a', 'tbs,a711-panel']
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.1.dtb: panel-lvds: compatible: ['panel-lvds'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /ldb: failed to match any schema with compatible: ['fsl,imx6q-ldb', 'fsl,imx53-ldb']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu2_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu1_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu1_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: iomuxc-gpr@20e0000: 'ipu1_csi0_mux', 'ipu1_csi1_mux' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-iomuxc-gpr.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-eval-v3.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /soc/ipu@2800000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: panel-lvds: compatible:0: 'panel-lvds' is not one of ['admatec,9904379', 'auo,b101ew05', 'auo,g084sn05', 'chunghwa,claa070wp03xg', 'edt,etml0700z9ndha', 'hannstar,hsd101pww2', 'hydis,hv070wx2-1e0', 'jenson,bl-jt60050-01a', 'tbs,a711-panel']
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6q-apalis-v1.2-ixora-v1.2.dtb: panel-lvds: compatible: ['panel-lvds'] is too short
	from schema $id: http://devicetree.org/schemas/display/panel/panel-lvds.yaml#
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /soc/bus@2100000/mipi@21dc000: failed to match any schema with compatible: ['fsl,imx6-mipi-csi2']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /soc/bus@2100000/vdoa@21e4000: failed to match any schema with compatible: ['fsl,imx6q-vdoa']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /soc/ipu@2400000: failed to match any schema with compatible: ['fsl,imx6q-ipu']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-aster.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /capture-subsystem: failed to match any schema with compatible: ['fsl,imx-capture-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /display-subsystem: failed to match any schema with compatible: ['fsl,imx-display-subsystem']
arch/arm/boot/dts/nxp/imx/imx6dl-colibri-v1.2-iris-v2.dtb: /disp0: failed to match any schema with compatible: ['fsl,imx-parallel-display']






