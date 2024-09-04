Return-Path: <linux-kernel+bounces-315156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A6596BEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB41C21960
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D2E1DB557;
	Wed,  4 Sep 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnnL/MUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47071DB53A;
	Wed,  4 Sep 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457003; cv=none; b=DFbUIwdl1TWN/x2JYKFLzYz7TbPVwMkPyq1FwTe3eBt9zwlOn+istHc9RCafQm5jm8W2pMMQiAjpnUjQ5AKBchuQWUiL6tguHx94CyKu1sOPkyyPdmbGErI+VzT/1L2Qst+Y/3+UyGZNj9G8UBim6a73GIY9jz41q2fYpinfmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457003; c=relaxed/simple;
	bh=cWwLSUHZYqYI8cgQZImqZs4zv+twj68xkBlqsgZhALY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WbnzDnYjLbiOr7FplZo6YBxRhQzCVkRf3ukilDhu1TIj2tiAMv/oycN+S1Oz4ofqSFaj0NlBOiQe7h4t4iGPLb3GixgU55ZJ83P602i4RQkqjUNFqTt9iwLQHF1bN6p8f3W1kA1jsm/X0llJluuimMr0oWsjkGG5Wv3VnfWe4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnnL/MUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEB2C4CEC9;
	Wed,  4 Sep 2024 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457003;
	bh=cWwLSUHZYqYI8cgQZImqZs4zv+twj68xkBlqsgZhALY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PnnL/MUdepyH8f7jACCE4b/4wv+fPngnIN2ZuQFXl2wlf5D8/rhD6wrMSWJxKZpDn
	 cXVv4JxqHJ16tmrJjJXedKffi1yuj3npoauXrQnXb2KPLm4CjEW0dVybdok8MFVMP7
	 /Q6ngzsyvPTTMwaPJL72D+9UTPS+34IAdoCDCPBTP+WUUWzuq3Anz/n5kcFHCNo8UW
	 qyaWPgWzOr5gYDr8sdlWc/INLC3H3TgUqmpCdhcjVK+syp+rcZO9Wi0FaOmMLAivxi
	 2HWXvCKNUmn5EWi89dYKY1xr+3M6hHr7tLmp7Bi4x5Ml14foXPRt6oyCF0mrbHn7pO
	 pzTDArPPdbbXA==
Date: Wed, 04 Sep 2024 08:36:42 -0500
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
Cc: Mathieu Othacehe <m.othacehe@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, imx@lists.linux.dev, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Michael Walle <mwalle@kernel.org>
In-Reply-To: <20240904085415.645031-1-frieder@fris.de>
References: <20240904085415.645031-1-frieder@fris.de>
Message-Id: <172545685881.2410492.11093447141073155714.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] Add support for Kontron OSM-S i.MX8MP SoM and
 carrier boards


On Wed, 04 Sep 2024 10:53:18 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Patch 1: board DT bindings
> Patch 2: OSM-S i.MX8MP SoM and BL carrier board devicetrees
> Patch 3: i.MX8MP SMARC module and eval carrier board devicetrees
> 
> Changes for v3:
> 
> * Address Shawn's review comments (thanks!)
> * Fix HDMI DDC interface
> * Fix gpio-hog pinctrl in DL devicetree
> * Fix DT check warnings in DL devicetree
> * Adjust LVDS panel node to match that of proposed DL i.MX8MM
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
>  .../dts/freescale/imx8mp-kontron-bl-osm-s.dts | 305 ++++++
>  .../boot/dts/freescale/imx8mp-kontron-dl.dtso | 110 +++
>  .../dts/freescale/imx8mp-kontron-osm-s.dtsi   | 908 ++++++++++++++++++
>  .../imx8mp-kontron-smarc-eval-carrier.dts     | 254 +++++
>  .../dts/freescale/imx8mp-kontron-smarc.dtsi   | 280 ++++++
>  7 files changed, 1876 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-dl.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-osm-s.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc.dtsi
> 
> --
> 2.46.0
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-kontron-bl-osm-s.dtb freescale/imx8mp-kontron-smarc-eval-carrier.dtb' for 20240904085415.645031-1-frieder@fris.de:

arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: clock-controller@30e20000: '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: clock-controller@30e20000: '#reset-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: pcie-ep@33800000: reg: [[864026624, 1048576], [402653184, 134217728], [865075200, 1048576], [867172352, 1048576]] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-bl-osm-s.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space', 'dbi2', 'atu'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: pcie-ep@33800000: reg: [[864026624, 1048576], [402653184, 134217728], [865075200, 1048576], [867172352, 1048576]] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space', 'dbi2', 'atu'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#






