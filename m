Return-Path: <linux-kernel+bounces-334717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C84297DAFF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1D31C21084
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FF8472;
	Sat, 21 Sep 2024 00:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5kOC7T8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7A257D;
	Sat, 21 Sep 2024 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726878304; cv=none; b=j+ElpIha8Ylw7oQ7n7fekOiB8/bBC3STT3cK3FcjHEw7XC5DTiDdA8ucrae3ShZUe0k3+Mu1cPwc48BJ8PtTTeXWYjncqph6OtIlI8dOoEuW00wGDmgx5KP8T/LQbxA+Mty4ulgOlJYPN0XKscyc0f9lTk7Yw7foCGLtgKDaTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726878304; c=relaxed/simple;
	bh=LDiupKMatztnfbrKBKYiIRKaIbOOzvDj36STPReByR0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=A0a3+JC49JfmUgU0hpqqYTZQgp/Zs6g4wX2Mr2mIpBpbnrpY48CQ4eafrEmYGpMCNWNnqpwB5Ry4czcTUpSenNtjlaAm9rXrlCrIu2dY6Gk407yNoZYiCpw+55+PSvG8OV/lvpy5U0AlTjlzhXkrAJexUEYbBCX+chlg02r7zGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5kOC7T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA32C4CEC3;
	Sat, 21 Sep 2024 00:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726878304;
	bh=LDiupKMatztnfbrKBKYiIRKaIbOOzvDj36STPReByR0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j5kOC7T8u+SEHynvGF7zJ32gTJYxhEkHhC9JDxDMbbD+6t7qIDxGxTAdv4fJSNygB
	 Z5ME2l/nH1gX8++NXKyRdxmDhffVSCBBjofuGnH7VpEii1hdfFiAqL0eBmtA5umuB+
	 AZ2yHGUdAzeGlNf0PU8WpkJF3OEkkTxU3j8c8wT+SgAXMu392pffNaZBWw7B0u1TvC
	 A8OvmMVSh+8Z6roaTA4a5xfs21V3K3UYKmVQLq17pSl9+RIfe6YLGyVt2P7OdXpNDm
	 MLwudJb90m6B+DEchGIe+amPMFN08jVRat/fgZoS2lCLTbY0ZSEGGW3fNT2soJqf3y
	 S+hOGzoC5rF2A==
Date: Fri, 20 Sep 2024 19:25:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Michal_Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Herburger <gregor.herburger@ew.tq-group.com>, imx@lists.linux.dev, 
 Petr Benes <petr.benes@ysoft.com>, linux-usb@vger.kernel.org, 
 Michael Walle <mwalle@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Shawn Guo <shawnguo@kernel.org>, 
 devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240920080154.1595808-1-michal.vokac@ysoft.com>
References: <20240920080154.1595808-1-michal.vokac@ysoft.com>
Message-Id: <172687817135.147604.5208248981438560257.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Add support for new IMX8MP based board


On Fri, 20 Sep 2024 10:01:50 +0200, Michal Vokáč wrote:
> Hi,
> 
> this series adds support for a new member in our IOTA platform.
> The board is based on the i.MX8MP SoC. The first two patches
> add support for most of the board functionality except USB Type-C
> port and some other minor things.
> 
> [PATCH 3] adds new device tree binding for a Diodes Incorporated
> PI5USB30213A Type-C Controller and [PATCH 4] enables that port on
> the IOTA2 Lumpy board.
> 
> We also wrote a driver for that Type-C port controller. I would like
> to get that driver upstream as well but I expect it will take much
> more iterations and effort to get it into mainline-ready shape so
> I intentionally excluded it from this series. AFAIK it should not
> be a problem to accept a device tree binding for a HW that does not
> have a driver in the kernel yet.
> 
> Michal Vokáč (2):
>   dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
>   arm64: dts: imx: Add imx8mp-iota2-lumpy board
> 
> Petr Benes (2):
>   dt-bindings: usb: Add Diodes Incorporated PI5USB30213A Type-C
>     Controller
>   arm64: dts: imx8mp-iota2: Enable the USB Type-C port
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  .../bindings/usb/diodes,pi5usb30213a.yaml     |  88 +++
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 518 ++++++++++++++++++
>  4 files changed, 608 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-iota2-lumpy.dtb' for 20240920080154.1595808-1-michal.vokac@ysoft.com:

arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: usb@38200000: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#






