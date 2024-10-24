Return-Path: <linux-kernel+bounces-380310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055C29AEC30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B0F283038
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C101F81A8;
	Thu, 24 Oct 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1qnisCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA5C1F80C0;
	Thu, 24 Oct 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787591; cv=none; b=ddIqZ+IOqLjAsBrV54Vy8yl7kDUTfTUPnW2y9TkHOCSo/4TaZURG7tc/1HxDV3HFa7RwsxYc61hBeSxCwMvv3BiAmZ7aMDxYvLZmG8gkR5OrV2dHmDq0xnORCdrNgmoFkHgJCM2olXDazb/so0JLMR3kxU/xo6Uu1df4NLgk9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787591; c=relaxed/simple;
	bh=dFE27spZWGGO3O/FjVqS8Zieq3e6deQvtK3NGGzcags=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TFB8FIrCSHWY54EMQa3vC0PdmS8AZkdHfW2lBnn03+taBbVKgTgqbd6ndHCMRkfF79Ib3HW/CYIuPCbD42G7rEEJjiXyZ4EoWREnKwJ9NaddmXFmNzEqzIkA9VoAWUUBBHo18jwP+Y/3ZHe1pCTTub4wERyW9B7k5bPdQpc4KQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1qnisCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2152EC4CEE4;
	Thu, 24 Oct 2024 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787591;
	bh=dFE27spZWGGO3O/FjVqS8Zieq3e6deQvtK3NGGzcags=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=W1qnisCaCBgHhfVH21VLCugCbkPveN/I0dehMFziAHUowWUsZDx16ngMW5Amei5Bp
	 gvXAFX/S3ji45hm47hlr7zYS2a6LZejXBdpm7MJp1GcVw3feM6nvEb6R4XVcp4peAz
	 hatgELAu/NhN3pIz+JkxolnpI3al5NvVJpN4LY49DRNCjhtordl64rqNWBqPNQp3fj
	 oL4iibNLimakT06gzoADnll2Q6HdNJL9pPkblz7F7sMgw9nFojoghNIDeunSCiOk5N
	 Xun3AzhsHHG0xOoRtt2P3XCjkpkM/+KA6ftpITm/mVE540H/U3b37hm+KhNY0JyOLz
	 fnU5AahcFoCVA==
Date: Thu, 24 Oct 2024 11:33:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev
In-Reply-To: <20241021173631.299143-1-andreas@kemnade.info>
References: <20241021173631.299143-1-andreas@kemnade.info>
Message-Id: <172978739415.623377.16255873190403430164.robh@kernel.org>
Subject: Re: [PATCH 0/3] ARM: dts: add Kobo Clara 2E


On Mon, 21 Oct 2024 19:36:28 +0200, Andreas Kemnade wrote:
> Add a basic device tree for the Kobo Clara 2E Ebook reader.
> It is equipped with an i.MX6SLL SoC. EPDC PMIC drivers
> are not ready for mainline yet.
> 
> Andreas Kemnade (3):
>   dt-bindings: arm: fsl: add compatible strings for Kobo Clara 2E
>   ARM: dts: imx: Add devicetree for Kobo Clara 2E
>   ARM: imx_v6_v7_defconfig: Enable drivers for Kobo Clara 2E
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   8 +
>  arch/arm/boot/dts/nxp/imx/Makefile            |   2 +
>  .../dts/nxp/imx/imx6sll-kobo-clara2e-a.dts    |  23 +
>  .../dts/nxp/imx/imx6sll-kobo-clara2e-b.dts    |  23 +
>  .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 514 ++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig          |   2 +
>  6 files changed, 572 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dts
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-common.dtsi
> 
> --
> 2.39.5
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


New warnings running 'make CHECK_DTBS=y nxp/imx/imx6sll-kobo-clara2e-a.dtb nxp/imx/imx6sll-kobo-clara2e-b.dtb' for 20241021173631.299143-1-andreas@kemnade.info:

arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: spdif@2004000: compatible:0: 'fsl,imx6sl-spdif' is not one of ['fsl,imx35-spdif', 'fsl,vf610-spdif', 'fsl,imx6sx-spdif', 'fsl,imx8qm-spdif', 'fsl,imx8qxp-spdif', 'fsl,imx8mq-spdif', 'fsl,imx8mm-spdif', 'fsl,imx8mn-spdif', 'fsl,imx8ulp-spdif']
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: spdif@2004000: compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif'] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: spdif@2004000: clock-names:9: 'spba' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/spba-bus@2000000/spdif@2004000: failed to match any schema with compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: spdif@2004000: compatible:0: 'fsl,imx6sl-spdif' is not one of ['fsl,imx35-spdif', 'fsl,vf610-spdif', 'fsl,imx6sx-spdif', 'fsl,imx8qm-spdif', 'fsl,imx8qxp-spdif', 'fsl,imx8mq-spdif', 'fsl,imx8mm-spdif', 'fsl,imx8mn-spdif', 'fsl,imx8ulp-spdif']
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: spdif@2004000: compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif'] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: spdif@2004000: clock-names:9: 'spba' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/spba-bus@2000000/spdif@2004000: failed to match any schema with compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: serial@2034000: dma-name: b'rx\x00tx\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: timer@2098000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sl-gpt'] is too short
	'fsl,imx1-gpt' was expected
	'fsl,imx21-gpt' was expected
	'fsl,imx27-gpt' was expected
	'fsl,imx31-gpt' was expected
	'fsl,imx6sl-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
	'fsl,imx6dl-gpt' was expected
	'fsl,imx6sl-gpt' is not one of ['fsl,imx6ul-gpt', 'fsl,imx7d-gpt']
	from schema $id: http://devicetree.org/schemas/timer/fsl,imxgpt.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: serial@2034000: dma-name: b'rx\x00tx\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: timer@2098000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sl-gpt'] is too short
	'fsl,imx1-gpt' was expected
	'fsl,imx21-gpt' was expected
	'fsl,imx27-gpt' was expected
	'fsl,imx31-gpt' was expected
	'fsl,imx6sl-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
	'fsl,imx6dl-gpt' was expected
	'fsl,imx6sl-gpt' is not one of ['fsl,imx6ul-gpt', 'fsl,imx7d-gpt']
	from schema $id: http://devicetree.org/schemas/timer/fsl,imxgpt.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: anatop@20c8000: '#address-cells', '#size-cells', 'regulator-3p0@20c8120' do not match any of the regexes: 'pinctrl-[0-9]+', 'regulator-((1p1)|(2p5)|(3p0)|(vddcore)|(vddpu)|(vddsoc))$'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-anatop.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: regulator-3p0@20c8120: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/anatop-regulator.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: anatop@20c8000: '#address-cells', '#size-cells', 'regulator-3p0@20c8120' do not match any of the regexes: 'pinctrl-[0-9]+', 'regulator-((1p1)|(2p5)|(3p0)|(vddcore)|(vddpu)|(vddsoc))$'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-anatop.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: regulator-3p0@20c8120: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/anatop-regulator.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: interrupt-controller@20dc000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-gpc', 'fsl,imx6q-gpc'] is too long
	'fsl,imx6sll-gpc' is not one of ['fsl,imx6q-gpc']
	'fsl,imx6sll-gpc' is not one of ['fsl,imx6qp-gpc', 'fsl,imx6sl-gpc', 'fsl,imx6sx-gpc', 'fsl,imx6ul-gpc']
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: interrupt-controller@20dc000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: interrupt-controller@20dc000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: interrupt-controller@20dc000: 'pgc' is a required property
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/interrupt-controller@20dc000: failed to match any schema with compatible: ['fsl,imx6sll-gpc', 'fsl,imx6q-gpc']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6sll-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: interrupt-controller@20dc000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-gpc', 'fsl,imx6q-gpc'] is too long
	'fsl,imx6sll-gpc' is not one of ['fsl,imx6q-gpc']
	'fsl,imx6sll-gpc' is not one of ['fsl,imx6qp-gpc', 'fsl,imx6sl-gpc', 'fsl,imx6sx-gpc', 'fsl,imx6ul-gpc']
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: interrupt-controller@20dc000: 'clocks' is a required property
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: interrupt-controller@20dc000: 'clock-names' is a required property
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: interrupt-controller@20dc000: 'pgc' is a required property
	from schema $id: http://devicetree.org/schemas/power/fsl,imx-gpc.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/interrupt-controller@20dc000: failed to match any schema with compatible: ['fsl,imx6sll-gpc', 'fsl,imx6q-gpc']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6sll-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: lcd-controller@20f8000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-lcdif', 'fsl,imx28-lcdif'] is too long
	'fsl,imx6sll-lcdif' is not one of ['fsl,imx23-lcdif', 'fsl,imx28-lcdif', 'fsl,imx6sx-lcdif', 'fsl,imx8mp-lcdif', 'fsl,imx93-lcdif']
	'fsl,imx6sx-lcdif' was expected
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: lcd-controller@20f8000: clocks: [[2, 129], [2, 123], [2, 0]] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: lcd-controller@20f8000: clock-names: ['pix', 'axi', 'disp_axi'] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: lcd-controller@20f8000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-lcdif', 'fsl,imx28-lcdif'] is too long
	'fsl,imx6sll-lcdif' is not one of ['fsl,imx23-lcdif', 'fsl,imx28-lcdif', 'fsl,imx6sx-lcdif', 'fsl,imx8mp-lcdif', 'fsl,imx93-lcdif']
	'fsl,imx6sx-lcdif' was expected
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: lcd-controller@20f8000: clocks: [[2, 129], [2, 123], [2, 0]] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: lcd-controller@20f8000: clock-names: ['pix', 'axi', 'disp_axi'] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#






