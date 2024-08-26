Return-Path: <linux-kernel+bounces-302334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E32B95FCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06771C21A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265E419D88D;
	Mon, 26 Aug 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TUGAKwSK"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A819D075;
	Mon, 26 Aug 2024 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711291; cv=none; b=JN6CmhWorUIG8oR0HtS9zdlwrgfJgKS1bqMDkZrU7XjBMyG4PhXNgKHtcYfEYPbghi8UJTXEsuB3a15lkgbfyzXqhHIHmBAa9jECxxpx2v+Dpcsxttzoso5kDi9ioUQ2SZumi+mVE8yaSvaBVovjk6ZrVPimzrUEwQ8xlLOc2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711291; c=relaxed/simple;
	bh=xdiURQBnexqTHdHtZQZrJk+9VQJz+AyCfG2A5WB6oh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKIMjgKSsc1XyyP3VfBslYarIHi3OdUq56kRjHelUs4Q/NhIoGPVrNMpjgzeC/y67R5/SO6YNzDKKJL15HvKBclZ/73e0K4zWRY5r5k8wnKBvQnYa2ld0/7fX2LfJRHhglfqa0qlrZf6LSqYQ0Jtf96R9rWq0QIbeBhf6iK8nNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TUGAKwSK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 40B3020AB8;
	Tue, 27 Aug 2024 00:28:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1724711287;
	bh=xUm9tBZ+haGiL/pcLT1XqSLOUSAW+7lu0+BByLpTz38=;
	h=Received:From:To:Subject;
	b=TUGAKwSKAWozeXzQWLAP7/QHSN5U98LhQ2pCIjlIfNAK330tts/gBuSXGmtb+ZGhJ
	 rI8To4a/Lsv1ej5kjzqY/2wwG1sCUbkSD8GKZ6qmNV86GQYuFTsCU/32NWQc/qt7JB
	 0WdR5OXi7My1DUC5XH4XLmLtOppT29kzELAZNK9GCYha9byoWU1mVXB12fUx7OCIfP
	 qnL1cwMfCh9CngeJpCtY+hnrc/bJREzhl78lkY4orM+L/q2WJwkV705utP89tL5JXN
	 kVQ2MCalvDD+Kntri8SOu799SQNmtzsI0ItC1rVU+Jy6SEGb7BWon0/5RSMZxOaDK7
	 M11JEAh4gjU1w==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id D627C7F9A5; Tue, 27 Aug 2024 00:28:06 +0200 (CEST)
Date: Tue, 27 Aug 2024 00:28:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 01/10] arm64: dts: colibri-imx8x: Add usb support
Message-ID: <Zs0BdnJM536YQd-B@gaggiata.pivistrello.it>
References: <20240826215922.13225-1-francesco@dolcini.it>
 <20240826215922.13225-2-francesco@dolcini.it>
 <Zsz+YjOyGoReEqUm@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsz+YjOyGoReEqUm@lizhi-Precision-Tower-5810>

On Mon, Aug 26, 2024 at 06:14:58PM -0400, Frank Li wrote:
> On Mon, Aug 26, 2024 at 11:59:13PM +0200, Francesco Dolcini wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >
> > Add USB HOST and OTG support to Colibri-iMX8X carrier boards.
> >
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  .../dts/freescale/imx8x-colibri-aster.dtsi    | 26 +++++++++++++
> >  .../dts/freescale/imx8x-colibri-eval-v3.dtsi  | 26 +++++++++++++
> >  .../dts/freescale/imx8x-colibri-iris.dtsi     | 26 +++++++++++++
> >  .../boot/dts/freescale/imx8x-colibri.dtsi     | 37 +++++++++++++++++--
> >  4 files changed, 111 insertions(+), 4 deletions(-)

...

> > diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> > index 49d105eb4769..1199e311d6f9 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> > @@ -23,12 +23,31 @@ key-wakeup {
> >  		};
> >  	};
> >
> > +	extcon_usbc_det: usbc-det {
> > +		compatible = "linux,extcon-usb-gpio";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_usbc_det>;
> > +		id-gpio = <&lsio_gpio5 9 GPIO_ACTIVE_HIGH>;
> 
> Not sure if I missed something, CHECK_DTBS report below warning.
> 
> arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dtb: usbc-det: 'id-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/extcon/linux,extcon-usb-gpio.yaml

This should be `id-gpios`. The binding for "linux,extcon-usb-gpio" was recently
added, and this was not tested on the latest next (my fault), but on shawn imx branch and
the old txt doc documented just `id-gpio`.

We'll fix it. And thanks for catching it.


> > +	reg_usbh_vbus: regulator-usbh-vbus {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_usbh1_reg>;
> > +		gpio = <&lsio_gpio4 3 GPIO_ACTIVE_LOW>;
> > +		regulator-always-on;
> 
> Needn't regulator-always-on, because reg_usbh_vbus referece by other node.

Is this an issue? we expect this regulator to be always on, therefore this is
described this way in the DT.

Francesco


