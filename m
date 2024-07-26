Return-Path: <linux-kernel+bounces-263288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C38093D3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B99283BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3717BB08;
	Fri, 26 Jul 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwuOjQTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25123A8;
	Fri, 26 Jul 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999385; cv=none; b=pTFzD1gHEz0DBGyOWJup4ENVsRuMrnceA1hm0B+eYm2BLFUd7Iw8SI0HxzAzPN6y0P+xPQ7UDBoYDRuSuLAqBrXf53yHrWEOL660ByecHSx88hfT5QKdhXpKbpDypCS44CBbOgSW+F4Gp5egEyx3I2TjZQhRnyWhu6xvPFr6Z00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999385; c=relaxed/simple;
	bh=iAGrV52cHbMBboTdMq+gQQiOugUcN8ulkje4eUWYYyA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=moqiNkEXlrnajUL93vkisCO0tt+JVAVKpYNz5W3byLqZ5oyg/EY9YFZZWObkfmufVK6GbU9AtFaNcSY6ym2OuzCQMJj1hgWJLJWZs7O5MRBqAMnOsavqHJ9quCYY2IJveTNmkHbdaX9YJG+Ryic2QCtPFWGGrnZVUouTtFrHJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwuOjQTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1CEC32782;
	Fri, 26 Jul 2024 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721999385;
	bh=iAGrV52cHbMBboTdMq+gQQiOugUcN8ulkje4eUWYYyA=;
	h=Date:From:To:List-Id:Cc:In-Reply-To:References:Subject:From;
	b=jwuOjQTfOTALWQKlNPyD+08Hxfy0tgwRB+EgBd3M3sinbPmynriEgYq5+4ElVcZgk
	 Thk51IQCg9IsD7xNwbAljuKoxIqGoo+OF5TbXF1nEcyod/IQrIJ7ryCAEy3XmNmukv
	 Y6t3J2FFTF/qFNWqgr5KcMhlakDydgU/YiX81uHfDlvkg3ydt1WCxh/CqPXEZ6Y/rR
	 cOGZyWS8I4owxuAHLIPJKZ1JGptEAmRCVmXzUjLP6fiHQTPi0lbinTVonh3mj9dG/E
	 tkfMaCTAmDS1AwrU/MJI/2SvopiOkDWkG7MqqMIXtixC9zSTgqY1nR3XtoDqnHxkNj
	 zA0UB/ogwaD/Q==
Date: Fri, 26 Jul 2024 08:09:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: soc@kernel.org, m.szyprowski@samsung.com, nfraprado@collabora.com, 
 olof@lixom.net, will@kernel.org, mturquette@baylibre.com, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, 
 andrew@codeconstruct.com.au, catalin.marinas@arm.com, sboyd@kernel.org, 
 p.zabel@pengutronix.de, u-kumar1@ti.com, arnd@arndb.de, joel@jms.id.au, 
 quic_bjorande@quicinc.com, lee@kernel.org, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, neil.armstrong@linaro.org, 
 linux-aspeed@lists.ozlabs.org, dmitry.baryshkov@linaro.org, 
 shawnguo@kernel.org, geert+renesas@glider.be
In-Reply-To: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
References: <20240726110355.2181563-1-kevin_chen@aspeedtech.com>
Message-Id: <172199921352.1507193.4411331020670815695.robh@kernel.org>
Subject: Re: [PATCH v1 00/10] Introduce ASPEED AST27XX BMC SoC


On Fri, 26 Jul 2024 19:03:45 +0800, Kevin Chen wrote:
> This patchset adds initial support for the ASPEED.
> AST27XX Board Management controller (BMC) SoC family.
> 
> AST2700 is ASPEED's 8th-generation server management processor.
> Featuring a quad-core ARM Cortex A35 64-bit processor and two
> independent ARM Cortex M4 processors
> 
> This patchset adds minimal architecture and drivers such as:
> Clocksource, Clock and Reset
> 
> This patchset was tested on the ASPEED AST2700 evaluation board.
> 
> Kevin Chen (10):
>   dt-binding: mfd: aspeed,ast2x00-scu: Add binding for ASPEED AST2700
>     SCU
>   dt-binding: clk: ast2700: Add binding for Aspeed AST27xx Clock
>   clk: ast2700: add clock controller
>   dt-bindings: reset: ast2700: Add binding for ASPEED AST2700 Reset
>   dt-bindings: arm: aspeed: Add maintainer
>   dt-bindings: arm: aspeed: Add aspeed,ast2700-evb compatible string
>   arm64: aspeed: Add support for ASPEED AST2700 BMC SoC
>   arm64: dts: aspeed: Add initial AST27XX device tree
>   arm64: dts: aspeed: Add initial AST2700 EVB device tree
>   arm64: defconfig: Add ASPEED AST2700 family support
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    6 +
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml      |    3 +
>  MAINTAINERS                                   |    3 +
>  arch/arm64/Kconfig.platforms                  |   14 +
>  arch/arm64/boot/dts/Makefile                  |    1 +
>  arch/arm64/boot/dts/aspeed/Makefile           |    4 +
>  arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi     |  217 +++
>  arch/arm64/boot/dts/aspeed/ast2700-evb.dts    |   50 +
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/clk/Makefile                          |    1 +
>  drivers/clk/clk-ast2700.c                     | 1166 +++++++++++++++++
>  .../dt-bindings/clock/aspeed,ast2700-clk.h    |  180 +++
>  .../dt-bindings/reset/aspeed,ast2700-reset.h  |  126 ++
>  13 files changed, 1772 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
>  create mode 100644 arch/arm64/boot/dts/aspeed/aspeed-g7.dtsi
>  create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts
>  create mode 100644 drivers/clk/clk-ast2700.c
>  create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
>  create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y aspeed/ast2700-evb.dtb' for 20240726110355.2181563-1-kevin_chen@aspeedtech.com:

arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: /: failed to match any schema with compatible: ['aspeed,ast2700a1-evb', 'aspeed,ast2700']
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: /: failed to match any schema with compatible: ['aspeed,ast2700a1-evb', 'aspeed,ast2700']
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: l2-cache0: 'cache-unified' is a dependency of 'cache-size'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: l2-cache0: 'cache-unified' is a dependency of 'cache-sets'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: l2-cache0: 'cache-unified' is a dependency of 'cache-line-size'
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: l2-cache0: 'cache-unified' is a required property
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: l2-cache0: Unevaluated properties are not allowed ('cache-level', 'cache-line-size', 'cache-sets', 'cache-size' were unexpected)
	from schema $id: http://devicetree.org/schemas/cache.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: sram@10000000: #address-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: sram@10000000: #size-cells: 1 was expected
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: sram@10000000: 'exported@0' does not match any of the regexes: '^([a-z0-9]*-)?sram(-section)?@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: /soc@10000000/syscon@12c02000: failed to match any schema with compatible: ['aspeed,ast2700-scu0', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: /soc@10000000/syscon@12c02000/interrupt-controller@1D0: failed to match any schema with compatible: ['aspeed,ast2700-scu-ic0']
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: /soc@10000000/syscon@12c02000/interrupt-controller@1E0: failed to match any schema with compatible: ['aspeed,ast2700-scu-ic1']
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: /soc@14000000/syscon@14c02000: failed to match any schema with compatible: ['aspeed,ast2700-scu1', 'syscon', 'simple-mfd']
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: serial@14c33b00: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
arch/arm64/boot/dts/aspeed/ast2700-evb.dtb: serial@14c33b00: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#






