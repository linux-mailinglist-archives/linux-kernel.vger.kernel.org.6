Return-Path: <linux-kernel+bounces-202679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F58FCF81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C07E28C061
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26D1991D6;
	Wed,  5 Jun 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goC4xG1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E751991BD;
	Wed,  5 Jun 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593107; cv=none; b=dsODV1eLm9JSFRenhJKfEFhs9uoJ727c37gy5vZaPP/rrMY4/jOa405OTH0B70XIA6yUpHtA0rBwJgLg2bv9ifAjB+63t9EznbL4RPIVlaVasrplQ2ArGoTqloJHO5Bf1pS9zLGF2PCYYh7WHHQyJxhgi6JpE7+Qi8KnbRmncuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593107; c=relaxed/simple;
	bh=z3AyDz/cSs7NcIi7IsLYg5zkRvDfugi4f76S7UFbDnA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=D+Bd2mAFUCiAv+KG4PRXKridzEBQysuZ6GBv3ZQw2jVRboyE+YN0kRWCZd8r63YojUq2S55nEpgtv39uA8e0DK2DIP93xeSHBGAdj/+m0ZfGVtYXgaodmF1mj22CleZxHV0QfIDeEMLNKnw0sB5qylfGr7m+l5Efatf3oVSJhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goC4xG1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00227C4AF13;
	Wed,  5 Jun 2024 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717593107;
	bh=z3AyDz/cSs7NcIi7IsLYg5zkRvDfugi4f76S7UFbDnA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=goC4xG1GK/8GuNy8O7WozvGlBYVktW4cpTOWHFSTwGBj46kPUHDD4MMGJ1QiShpU7
	 HkSn1NjB4G9CsAnKd9BMlkjvbYg8Zd8phLOnFY6X8ZWBv13Ko7Q0AhkhCrCwck3QZk
	 r0wNw2tcEY58xKL8mhBDTlqYZqBfoR7sdikmOA+jI/0xVkkNlhGToVDDb2QPdEzncB
	 jYIz+TpxPndJ81QHvQ11fde5VN/4tdOH2a6fKEyb7qf9Ul1p+cqzSv+p8VWMOUZO5b
	 3l2o2p2xZX5eFPfLX+VYp3FTIYGEuVKGL7x0yoJbL+YMNUnw1fYVCadJb5zS1LsrbZ
	 2WFPmQUIKEzEw==
Date: Wed, 05 Jun 2024 07:11:45 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org
In-Reply-To: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
References: <20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com>
Message-Id: <171759285255.2201583.2972532239106295355.robh@kernel.org>
Subject: Re: [PATCH v6 0/3] arm64: dts: add i.MX95 and EVK board


On Wed, 05 Jun 2024 09:22:47 +0800, Peng Fan (OSS) wrote:
> Add a minimal i.MX95 dtsi and EVK board dts.
> i.MX95 has a M33 running SCMI firmware that supports
> pinctrl/power/perf/clock and etc.
> 
> imx95-pinfunc.h will trigger checkpatch error, that is expected and same
> as other i.MX platforms.
> 
> In v6, I added back a dependency on pinctrl, because [1] has got A-b/R-b
> from Maintainers, so it would be soon got merged.
> 
> There will be dtbs_check error before [1] got landed. With [1] merged,
> there will be no dtbs_check error.
> 
> [1] https://lore.kernel.org/all/20240521-pinctrl-scmi-imx95-v1-0-9a1175d735fd@nxp.com/
> 
> This patchset is just a minimal support for i.MX95. After this patchset
> is accepted, a following patchset will include more nodes and features.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v6:
> - Add pinctrl nodes and pin settings
> - Add imx95-pinfunc.h
> - Drop fsl,cd-gpio-disable-wakeup which is downstream property
> - Per i.MX M33 SCMI firmware, drop unused PERF entries in imx95-power.h
> - Rebased to next-20240604
> - Link to v5: https://lore.kernel.org/r/20240506-imx95-dts-v3-v5-0-5ec9b99cfb2f@nxp.com
> 
> Changes in v5:
> - Drop unused regulator and alias for now.
> - Fix CHECK_DTB warning.
> - Link to v4: https://lore.kernel.org/r/20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com
> 
> Changes in v4:
> - Sort nodes by address
> - Drop coresight nodes
> - Align clock rates for SDHC1-3
> - Drop wdog3 board specific property
> - Link to v3: https://lore.kernel.org/r/20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com
> 
> Changes in v3:
> - Drop irqsteer node because binding not accepted
> - Pass dtbs_check
> - Link to v2: https://lore.kernel.org/r/20240226-imx95-dts-v2-0-00e36637b07e@nxp.com
> 
> Changes in v2:
> - Addressed Rob and Krzysztof's comments, and fix dts_check issue
>   To pass the dtbs_check, need apply:
>   https://lore.kernel.org/all/20240226070910.3379108-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240226130243.3820915-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240226130516.3821803-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240226130826.3824251-1-peng.fan@oss.nxp.com/
>   https://lore.kernel.org/all/20240219-imx-mailbox-v8-1-75535a87794e@nxp.com/
> 
> - Link to v1: https://lore.kernel.org/r/20240218-imx95-dts-v1-0-2959f89f2018@nxp.com
> 
> ---
> Peng Fan (3):
>       dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
>       arm64: dts: freescale: add i.MX95 basic dtsi
>       arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml    |    6 +
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  200 ++++
>  arch/arm64/boot/dts/freescale/imx95-clock.h       |  187 ++++
>  arch/arm64/boot/dts/freescale/imx95-pinfunc.h     |  865 +++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx95-power.h       |   47 +
>  arch/arm64/boot/dts/freescale/imx95.dtsi          | 1063 +++++++++++++++++++++
>  7 files changed, 2369 insertions(+)
> ---
> base-commit: a1bede4830147a5a29ea6443724837ee0b126fd9
> change-id: 20240428-imx95-dts-v3-bee59f0e559b
> 
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
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


New warnings running 'make CHECK_DTBS=y freescale/imx95-19x19-evk.dtb' for 20240605-imx95-dts-v3-v6-0-2ce275ed0e80@nxp.com:

arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: scmi: protocol@19: Unevaluated properties are not allowed ('regusdhc2vmmcgrp', 'uart1grp', 'usdhc1-100mhzgrp', 'usdhc1-200mhzgrp', 'usdhc1grp', 'usdhc2-100mhzgrp', 'usdhc2-200mhzgrp', 'usdhc2gpiogrp', 'usdhc2grp' were unexpected)
	from schema $id: http://devicetree.org/schemas/firmware/arm,scmi.yaml#






