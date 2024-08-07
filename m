Return-Path: <linux-kernel+bounces-278146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3946F94ACB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882072802BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B012BF25;
	Wed,  7 Aug 2024 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7J4rpa8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1E84A22;
	Wed,  7 Aug 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044031; cv=none; b=pxJjQLKu/34cznMn9PGxdwCaOQje1YoX9ybKWbuCzw1gcWZqC4xSoes78g1dymVsHAMS2gAi8pHNv01Ym3C4G/tjDDI+FT/abN/A2CBk2DAU9ZEWloEFH+1+geDhMxfIn2cvm24urs6CxMq+9ahwJL67DwFYOD9/oVNKXDQAkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044031; c=relaxed/simple;
	bh=JxBWdZG47Tqqae9MVZdBLLmCto0I5YOx82vyGjZCLzQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gFQLlTMuwjId2r9xau8h54q3ERIz/3AoXmYsOVK89NOYfYVo5HnCeKcDQ2PETZPZ31htMnmWy3Igjo4XR9CJPdGa6TarzQRBGMxwduKlJwvCMBHgRFufH0CT9aeKPIZDykFqAdBbgmY+Lbt7NsYESCockLj+Y2vPFfgFpUKriIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7J4rpa8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F4FC4AF0D;
	Wed,  7 Aug 2024 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723044031;
	bh=JxBWdZG47Tqqae9MVZdBLLmCto0I5YOx82vyGjZCLzQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B7J4rpa8+EdoC2MJqgw7hncTeHgs7C6fj0KiwrUG8pJo8xBzFsg7QxRDwaqfeWXmp
	 v9cYTWPx4uFBxZcNV3Bm32f8ZgOEmF0h9QWP63miQMIC0HIq7NQGqYjOOb2BQ8HMNT
	 EoazbxNgU3GCrkWQGCuNWELdyjUiwXnMfuUG+9YE2gK7R7VoDo0OBzhk6tUttGE5iZ
	 noGi87C3DawR9bPS2sZrMvRNrDHdomULs6Bz2yVxK2LZB5uYbmAVDFjLHaHQrCrGU2
	 t/+xum7qDdKyC1tjUatdTupoAABjL1VZk/iCte8NkFigjwrUk+1y4UiaQRZ1UGW9g1
	 WPZEj74+qhhlQ==
Date: Wed, 07 Aug 2024 09:20:30 -0600
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
Cc: Parthiban Nallathambi <parthiban@linumiz.com>, 
 devicetree@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, 
 Shawn Guo <shawnguo@kernel.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Hiago De Franco <hiago.franco@toradex.com>
In-Reply-To: <20240807104137.558741-1-frieder@fris.de>
References: <20240807104137.558741-1-frieder@fris.de>
Message-Id: <172304386093.2508296.15187561674368738035.robh@kernel.org>
Subject: Re: [PATCH v2 0/3] Add support for Kontron OSM-S i.MX8MP SoM and
 carrier boards


On Wed, 07 Aug 2024 12:38:45 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Patch 1: board DT bindings
> Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
> Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees
> 
> Changes for v2:
> 
> DT bindings (patch1):
> * Add tags from Krzysztof and Conor (thanks!)
> 
> SMARC DTs (patch 3):
> * Fix GPIO labels
> * Add support for TPM chip on SMARC module
> * Disable PWM in favor of GPIO5 on SMARC carrier
> * Enable LCDIF node to make HDMI work
> * Add support for GPIO expanders on SMARC carrier
> * Remove SPI flash as its removable and should be in an overlay
> * Add CAN regulators to fix transceiver enable
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
>  .../imx8mp-kontron-smarc-eval-carrier.dts     | 258 +++++
>  .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 281 ++++++
>  7 files changed, 1885 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-kontron-bl-osm-s.dtb freescale/imx8mp-kontron-smarc-eval-carrier.dtb' for 20240807104137.558741-1-frieder@fris.de:

arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: /usbc: failed to match any schema with compatible: ['linux,extcon-usb-gpio']
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: /usbc: failed to match any schema with compatible: ['linux,extcon-usb-gpio']






