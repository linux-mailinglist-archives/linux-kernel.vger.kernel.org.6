Return-Path: <linux-kernel+bounces-239635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A1792635F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3E01F216B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7E17B51B;
	Wed,  3 Jul 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPb2tkXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2CA1DFD1;
	Wed,  3 Jul 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016828; cv=none; b=Fb1wjClvJ0GtG0kR3ispL1WLQ/J32PAfILG0+qsr4L8+jaTl+r1vTC0j/8PDL0QAKKfbBtbGb6aj4teA8OjiIlCiyy8qLTPnHbl/9rkajsh4c7r2xvoqtffSotf+ZlXwFsQwANOv1TNyFTv50a2qRTkae+gxZhQm4e3Io+YwdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016828; c=relaxed/simple;
	bh=TJURJXGngOL9PD0ltgboq2lLewTI1qesdsitguvVPjY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=e1NUwBFaGvtSXRB4m5e8ZT7lRlmp1lXzWsxYw525ilJFlYIwCNi196LrhHuU0dDcjw1LSZVioyuCu+emtj1MTAMnBtCIGu5KfxL3OBZm8MtnoNEBUQz08G4AQECUQTiYQmST5g9wb7s4Fd5k3qoTBvC8Wcq5z1d5KkHJGLn586w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPb2tkXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805BDC2BD10;
	Wed,  3 Jul 2024 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720016827;
	bh=TJURJXGngOL9PD0ltgboq2lLewTI1qesdsitguvVPjY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gPb2tkXFosgJNzWvm8+eCQE0v+kbdPIHsPkNWasGxDAW7q6BuSvOUoGcGlln/JyNr
	 JvEcJpL0ROtGDZk0Q4UBFyoK3dA/83mY+0VHYnjJ3NCbcWemYtotWM6YKhnI96yg/b
	 Zhk6Z9/7UEB5IJerMiPvUjqSeA/c0xsNZEkouMrrwr71x6SzxXqbvaFOAeE3WHTbcB
	 nvFHLSbJlP+rWBDm9vfeNA6z3t7Ijc52Xcce4LyU0hZOpma+71oJk5ps2iC56hiKNo
	 qxaUHpEgrY6R3wTfRj03VOXIoKbHjf3w4fUR2sXmineiZGSxVaJjpMmJw+iD/1Uy7K
	 ZuAn/MXF7lQ3g==
Date: Wed, 03 Jul 2024 08:27:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: imx@lists.linux.dev, Hiago De Franco <hiago.franco@toradex.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Marco Felsch <m.felsch@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Li Yang <leoyang.li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>
In-Reply-To: <20240702154413.968044-1-frieder@fris.de>
References: <20240702154413.968044-1-frieder@fris.de>
Message-Id: <172001675704.274653.3614631597140557643.robh@kernel.org>
Subject: Re: [PATCH 0/3] Add support for Kontron OSM-S i.MX8MP SoM and
 carrier boards


On Tue, 02 Jul 2024 17:43:18 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Patch 1: board DT bindings
> Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
> Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees
> 
> Frieder Schrempf (3):
>   dt-bindings: arm: fsl: Add Kontron i.MX8MP OSM-S based boards
>   arm64: dts: Add support for Kontron OSM-S i.MX8MP SoM and BL carrier
>     board
>   arm64: dts: Add support for Kontron i.MX8MP SMARC module and eval
>     carrier
> 
>  .../devicetree/bindings/arm/fsl.yaml          |  13 +
>  arch/arm64/boot/dts/freescale/Makefile        |   6 +
>  .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 307 ++++++
>  .../boot/dts/freescale/imx8mp-kontron-dl.dtso | 112 +++
>  .../dts/freescale/imx8mp-kontron-osm-s.dtsi   | 908 ++++++++++++++++++
>  .../imx8mp-kontron-smarc-eval-carrier.dts     | 224 +++++
>  .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 271 ++++++
>  7 files changed, 1841 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi
> 
> --
> 2.45.2
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-kontron-bl-osm-s.dtb freescale/imx8mp-kontron-smarc-eval-carrier.dtb' for 20240702154413.968044-1-frieder@fris.de:

arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: eeprom@50: compatible: 'oneOf' conditional failed, one must be fixed:
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: eeprom@50: compatible: 'oneOf' conditional failed, one must be fixed:
		'onnn,n24s64b' does not match 'c00$'
		'onnn,n24s64b' does not match 'c01$'
		'onnn,n24s64b' does not match 'cs01$'
		'onnn,n24s64b' does not match 'c02$'
		'onnn,n24s64b' does not match 'cs02$'
		'onnn,n24s64b' does not match 'mac402$'
		'onnn,n24s64b' does not match 'mac602$'
		'onnn,n24s64b' does not match 'c04$'
		'onnn,n24s64b' does not match 'cs04$'
		'onnn,n24s64b' does not match 'c08$'
		'onnn,n24s64b' does not match 'cs08$'
		'onnn,n24s64b' does not match 'c16$'
		'onnn,n24s64b' does not match 'cs16$'
		'onnn,n24s64b' does not match 'c32$'
		'onnn,n24s64b' does not match 'cs32$'
		'onnn,n24s64b' does not match 'c64$'
		'onnn,n24s64b' does not match 'cs64$'
		'onnn,n24s64b' does not match 'c128$'
		'onnn,n24s64b' does not match 'cs128$'
		'onnn,n24s64b' does not match 'c256$'
		'onnn,n24s64b' does not match 'cs256$'
		'onnn,n24s64b' does not match 'c512$'
		'onnn,n24s64b' does not match 'cs512$'
		'onnn,n24s64b' does not match 'c1024$'
		'onnn,n24s64b' does not match 'cs1024$'
		'onnn,n24s64b' does not match 'c1025$'
		'onnn,n24s64b' does not match 'cs1025$'
		'onnn,n24s64b' does not match 'c2048$'
		'onnn,n24s64b' does not match 'cs2048$'
		'onnn,n24s64b' does not match 'spd$'
		'atmel,24c64' does not match 'c00$'
		'atmel,24c64' does not match 'c01$'
		'atmel,24c64' does not match 'cs01$'
		'atmel,24c64' does not match 'c02$'
		'atmel,24c64' does not match 'cs02$'
		'atmel,24c64' does not match 'mac402$'
		'atmel,24c64' does not match 'mac602$'
		'atmel,24c64' does not match 'c04$'
		'atmel,24c64' does not match 'cs04$'
		'atmel,24c64' does not match 'c08$'
		'atmel,24c64' does not match 'cs08$'
		'atmel,24c64' does not match 'c16$'
		'atmel,24c64' does not match 'cs16$'
		'atmel,24c64' does not match 'c32$'
		'atmel,24c64' does not match 'cs32$'
		'atmel,24c64' does not match 'cs64$'
		'atmel,24c64' does not match 'c128$'
		'atmel,24c64' does not match 'cs128$'
		'atmel,24c64' does not match 'c256$'
		'atmel,24c64' does not match 'cs256$'
		'atmel,24c64' does not match 'c512$'
		'atmel,24c64' does not match 'cs512$'
		'atmel,24c64' does not match 'c1024$'
		'atmel,24c64' does not match 'cs1024$'
		'atmel,24c64' does not match 'c1025$'
		'atmel,24c64' does not match 'cs1025$'
		'atmel,24c64' does not match 'c2048$'
		'atmel,24c64' does not match 'cs2048$'
		'atmel,24c64' does not match 'spd$'
	['onnn,n24s64b', 'atmel,24c64'] is too long
	'onnn,n24s64b' does not match '^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|lc|mac)[0-9]+|spd)$'
	'belling,bl24c16a' was expected
	'onnn,n24s64b' is not one of ['rohm,br24g01', 'rohm,br24t01']
	'onnn,n24s64b' is not one of ['nxp,se97b', 'renesas,r1ex24002']
	'onnn,n24s64b' is not one of ['onnn,cat24c04', 'onnn,cat24c05', 'rohm,br24g04']
	'renesas,r1ex24016' was expected
	'giantec,gt24c32a' was expected
	'onnn,n24s64b' is not one of ['renesas,r1ex24128', 'samsung,s524ad0xd1']
	'onnn,n24s64b' does not match '^atmel,24c(32|64)d-wl$'
	'atmel,24c16' was expected
	'atmel,24c01' was expected
	'atmel,24c02' was expected
	'atmel,24c04' was expected
	'atmel,24c32' was expected
	'atmel,24c128' was expected
	from schema $id: http://devicetree.org/schemas/eeprom/at24.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: eeprom@50: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/eeprom/at24.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: /soc@0/bus@30800000/i2c@30ad0000/eeprom@50: failed to match any schema with compatible: ['onnn,n24s64b', 'atmel,24c64']
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: eeprom@50: compatible: 'oneOf' conditional failed, one must be fixed:
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: eeprom@50: compatible: 'oneOf' conditional failed, one must be fixed:
		'onnn,n24s64b' does not match 'c00$'
		'onnn,n24s64b' does not match 'c01$'
		'onnn,n24s64b' does not match 'cs01$'
		'onnn,n24s64b' does not match 'c02$'
		'onnn,n24s64b' does not match 'cs02$'
		'onnn,n24s64b' does not match 'mac402$'
		'onnn,n24s64b' does not match 'mac602$'
		'onnn,n24s64b' does not match 'c04$'
		'onnn,n24s64b' does not match 'cs04$'
		'onnn,n24s64b' does not match 'c08$'
		'onnn,n24s64b' does not match 'cs08$'
		'onnn,n24s64b' does not match 'c16$'
		'onnn,n24s64b' does not match 'cs16$'
		'onnn,n24s64b' does not match 'c32$'
		'onnn,n24s64b' does not match 'cs32$'
		'onnn,n24s64b' does not match 'c64$'
		'onnn,n24s64b' does not match 'cs64$'
		'onnn,n24s64b' does not match 'c128$'
		'onnn,n24s64b' does not match 'cs128$'
		'onnn,n24s64b' does not match 'c256$'
		'onnn,n24s64b' does not match 'cs256$'
		'onnn,n24s64b' does not match 'c512$'
		'onnn,n24s64b' does not match 'cs512$'
		'onnn,n24s64b' does not match 'c1024$'
		'onnn,n24s64b' does not match 'cs1024$'
		'onnn,n24s64b' does not match 'c1025$'
		'onnn,n24s64b' does not match 'cs1025$'
		'onnn,n24s64b' does not match 'c2048$'
		'onnn,n24s64b' does not match 'cs2048$'
		'onnn,n24s64b' does not match 'spd$'
		'atmel,24c64' does not match 'c00$'
		'atmel,24c64' does not match 'c01$'
		'atmel,24c64' does not match 'cs01$'
		'atmel,24c64' does not match 'c02$'
		'atmel,24c64' does not match 'cs02$'
		'atmel,24c64' does not match 'mac402$'
		'atmel,24c64' does not match 'mac602$'
		'atmel,24c64' does not match 'c04$'
		'atmel,24c64' does not match 'cs04$'
		'atmel,24c64' does not match 'c08$'
		'atmel,24c64' does not match 'cs08$'
		'atmel,24c64' does not match 'c16$'
		'atmel,24c64' does not match 'cs16$'
		'atmel,24c64' does not match 'c32$'
		'atmel,24c64' does not match 'cs32$'
		'atmel,24c64' does not match 'cs64$'
		'atmel,24c64' does not match 'c128$'
		'atmel,24c64' does not match 'cs128$'
		'atmel,24c64' does not match 'c256$'
		'atmel,24c64' does not match 'cs256$'
		'atmel,24c64' does not match 'c512$'
		'atmel,24c64' does not match 'cs512$'
		'atmel,24c64' does not match 'c1024$'
		'atmel,24c64' does not match 'cs1024$'
		'atmel,24c64' does not match 'c1025$'
		'atmel,24c64' does not match 'cs1025$'
		'atmel,24c64' does not match 'c2048$'
		'atmel,24c64' does not match 'cs2048$'
		'atmel,24c64' does not match 'spd$'
	['onnn,n24s64b', 'atmel,24c64'] is too long
	'onnn,n24s64b' does not match '^(atmel|catalyst|microchip|nxp|ramtron|renesas|rohm|st),(24(c|cs|lc|mac)[0-9]+|spd)$'
	'belling,bl24c16a' was expected
	'onnn,n24s64b' is not one of ['rohm,br24g01', 'rohm,br24t01']
	'onnn,n24s64b' is not one of ['nxp,se97b', 'renesas,r1ex24002']
	'onnn,n24s64b' is not one of ['onnn,cat24c04', 'onnn,cat24c05', 'rohm,br24g04']
	'renesas,r1ex24016' was expected
	'giantec,gt24c32a' was expected
	'onnn,n24s64b' is not one of ['renesas,r1ex24128', 'samsung,s524ad0xd1']
	'onnn,n24s64b' does not match '^atmel,24c(32|64)d-wl$'
	'atmel,24c16' was expected
	'atmel,24c01' was expected
	'atmel,24c02' was expected
	'atmel,24c04' was expected
	'atmel,24c32' was expected
	'atmel,24c128' was expected
	from schema $id: http://devicetree.org/schemas/eeprom/at24.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: eeprom@50: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/eeprom/at24.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: /soc@0/bus@30800000/i2c@30ad0000/eeprom@50: failed to match any schema with compatible: ['onnn,n24s64b', 'atmel,24c64']
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: /usbc: failed to match any schema with compatible: ['linux,extcon-usb-gpio']
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: /usbc: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






