Return-Path: <linux-kernel+bounces-395068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB69BB80C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871A31F24BCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082C1B392A;
	Mon,  4 Nov 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHXv0EiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2025776;
	Mon,  4 Nov 2024 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731161; cv=none; b=gpNmEwua5RbWWR7WLbxnyH9etrCp9KiSpIJeiI/B0A8Al/nQT8QFGJ+USGIbgH2Ya20ps7Rwb294gKejkReXt4HhRJ1eBgri+ZrHXoxoh0YOyZevLBnRWwQ/yAAB9SqtvWaSGxxI4TGqXYYwebWqZlvYUlZmBX3PeY2LH8emIoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731161; c=relaxed/simple;
	bh=IWJCgzjBH23P5Psxa93HOglaeX1YK0YOQlMjkv2M/x0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=dzLj+4IOHb3oHMc0CnisLqk/ICi/1ClaLCd4dxP0syDrUIS5qwzpw8X5gJNjn4p5623o6F8wNE+4EbUcul461uzw7LTbYq3XU3u8KSm8S4Xyuf6SqI/VKxZUCIcRxDwtEvhW9XQjS0lB/L4TJC+h4Ifopi0M4ieOPK8EvA/jnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHXv0EiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEC4C4CECE;
	Mon,  4 Nov 2024 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730731161;
	bh=IWJCgzjBH23P5Psxa93HOglaeX1YK0YOQlMjkv2M/x0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CHXv0EiGnNVlkuA/QqXxebK8auG+BqiB2WVRV94E/KAuhK1fvY5pvxZty20dG/Ami
	 5+N/Ygn0X316h3netU8vz1U/5d+aiufih8aIUoz7wy6RGhq3FTKzbkwZjICffL0m+z
	 SVCUGvj71Q4Jd2SPXvRAGfzn+cpIP+Pv5xsd2vdzyAtz4fqJLlY29bvWql6ltOqT+O
	 aucsI2zh6k37jRJFflSzJvuP/8XcJOAazUwG3IsjNMTDy46qfRlXdMr4ErJ9indNZL
	 qo4BUyuX0iulZutlx7K7XRvN/6uZmfdipjtkQ3Esw6SXYbwniiC+kokpgMMIIv17Nt
	 Zr5IZ0IGo2ABw==
Date: Mon, 04 Nov 2024 08:39:19 -0600
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
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, imx@lists.linux.dev, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20241103135201.25615-1-andreas@kemnade.info>
References: <20241103135201.25615-1-andreas@kemnade.info>
Message-Id: <173072771051.3690676.244560971344290580.robh@kernel.org>
Subject: Re: [PATCH v4 0/3] ARM: dts: add Kobo Clara 2E


On Sun, 03 Nov 2024 14:51:58 +0100, Andreas Kemnade wrote:
> Add a basic device tree for the Kobo Clara 2E Ebook reader.
> It is equipped with an i.MX6SLL SoC. EPDC PMIC drivers
> are not ready for mainline yet.
> 
> Changes in V4:
> - fix order of pinmux nodes
> - remove some blank lines
> 
> Changes in V3:
> - removed 30MegaOhm current sense resistor nonsense
> 
> Changes in V2:
> - improved commit message about devices without binding
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
>  .../nxp/imx/imx6sll-kobo-clara2e-common.dtsi  | 511 ++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig          |   2 +
>  6 files changed, 569 insertions(+)
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


New warnings running 'make CHECK_DTBS=y nxp/imx/imx6sll-kobo-clara2e-a.dtb nxp/imx/imx6sll-kobo-clara2e-b.dtb' for 20241103135201.25615-1-andreas@kemnade.info:

arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: spdif@2004000: compatible:0: 'fsl,imx6sl-spdif' is not one of ['fsl,imx35-spdif', 'fsl,vf610-spdif', 'fsl,imx6sx-spdif', 'fsl,imx8qm-spdif', 'fsl,imx8qxp-spdif', 'fsl,imx8mq-spdif', 'fsl,imx8mm-spdif', 'fsl,imx8mn-spdif', 'fsl,imx8ulp-spdif']
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: spdif@2004000: compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif'] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: spdif@2004000: compatible:0: 'fsl,imx6sl-spdif' is not one of ['fsl,imx35-spdif', 'fsl,vf610-spdif', 'fsl,imx6sx-spdif', 'fsl,imx8qm-spdif', 'fsl,imx8qxp-spdif', 'fsl,imx8mq-spdif', 'fsl,imx8mm-spdif', 'fsl,imx8mn-spdif', 'fsl,imx8ulp-spdif']
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: spdif@2004000: compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif'] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/spba-bus@2000000/spdif@2004000: failed to match any schema with compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/spba-bus@2000000/spdif@2004000: failed to match any schema with compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: serial@2034000: dma-name: b'rx\x00tx\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: serial@2034000: dma-name: b'rx\x00tx\x00' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: lcd-controller@20f8000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-lcdif', 'fsl,imx28-lcdif'] is too long
	'fsl,imx6sll-lcdif' is not one of ['fsl,imx23-lcdif', 'fsl,imx28-lcdif', 'fsl,imx6sx-lcdif', 'fsl,imx8mp-lcdif', 'fsl,imx93-lcdif']
	'fsl,imx6sx-lcdif' was expected
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: lcd-controller@20f8000: clocks: [[2, 129], [2, 123], [2, 0]] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-a.dtb: lcd-controller@20f8000: clock-names: ['pix', 'axi', 'disp_axi'] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: lcd-controller@20f8000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-lcdif', 'fsl,imx28-lcdif'] is too long
	'fsl,imx6sll-lcdif' is not one of ['fsl,imx23-lcdif', 'fsl,imx28-lcdif', 'fsl,imx6sx-lcdif', 'fsl,imx8mp-lcdif', 'fsl,imx93-lcdif']
	'fsl,imx6sx-lcdif' was expected
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: lcd-controller@20f8000: clocks: [[2, 129], [2, 123], [2, 0]] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clara2e-b.dtb: lcd-controller@20f8000: clock-names: ['pix', 'axi', 'disp_axi'] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#






