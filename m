Return-Path: <linux-kernel+bounces-231899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6791A00F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8848B22B82
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0F47A74;
	Thu, 27 Jun 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="iQfEbi8k"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF04317C;
	Thu, 27 Jun 2024 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472227; cv=none; b=j+fgF8EPzUGA0ich0RMp9RRrad0TrSxMUtleWt67X81VnusUeiFLBShGew2aNnrwssJol7PMJRF8Mh+sfmrxQnpqz1g0Zcd8mp8QuB01Stms2yVEcfasHNXLC17jdO1OP/m0+915jk1dsRXlByo473DZuxdwBNqf4BXhcHPsyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472227; c=relaxed/simple;
	bh=JkyTsbt0XpHbrywuNeYXvJrV2o5AkptgABGcKkNbjZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JisrNyYSPnRjjoJRzNxGWu3U9HTo31Ou3ZDYGIrZ5QREJMQ4fut+1mGujvWHGGwtC3b/97jaCHoKlYSc5SR8feej6mWTlSnA5MIPbkHQij/FyhRUhaufEoH9ABC1SiaBCs7XDbiSvMGXYhtpEvCRJIbhry/nsDDB1HL5ud/VrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=iQfEbi8k; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DE8A91FA3E;
	Thu, 27 Jun 2024 09:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1719472209;
	bh=aIZFoMXfj1PU3tfY2GaKFw28zmjn7K0QpfMx01nMzAU=;
	h=Received:From:To:Subject;
	b=iQfEbi8kTmTmCjrUZbZKsFhUbS5CpAnCL2BVQTvbcn3pD1l1atpGTdXHSL6+kAe0v
	 /Paq+AsjBSBBpRpoTqx7NtGnYTi66iNvb3TpkkI9zpTZSO6YqFExBOEbZYtIk+g/A2
	 0ncLIXJqPKUUOFcAejHWM4Np0Hz39EP8YDTqd5f7c1Ze/y06XxSbnHH+DroqtS7/Va
	 DqDUoRVNPIxfgw+jpjetathiUKKGcghD9YodMm9/eoDJcRNl1zYiXMmgz+2P6Zsevk
	 ebjEpxQMf2fbllOzqXet2YdD2YV/ebFySIZzVLPRrAhtUXFtqIFcc04iT61zgUFWSM
	 kD95Sf3uFci+Q==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 81CEF7F93B; Thu, 27 Jun 2024 09:10:08 +0200 (CEST)
Date: Thu, 27 Jun 2024 09:10:08 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Vitor Soares <ivitro@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vitor Soares <vitor.soares@toradex.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: add TPM device
Message-ID: <Zn0QUJ9wR1zzFGyC@gaggiata.pivistrello.it>
References: <20240613134150.318755-1-ivitro@gmail.com>
 <Zm+gjpsGhzjbEgP8@dragon>
 <20240617071842.GA4832@francesco-nb>
 <Zn0NbIvFdfpMPHAx@dragon>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn0NbIvFdfpMPHAx@dragon>

On Thu, Jun 27, 2024 at 02:57:48PM +0800, Shawn Guo wrote:
> On Mon, Jun 17, 2024 at 09:18:42AM +0200, Francesco Dolcini wrote:
> > Hello Shawn,
> > 
> > On Mon, Jun 17, 2024 at 10:33:50AM +0800, Shawn Guo wrote:
> > > On Thu, Jun 13, 2024 at 02:41:50PM +0100, Vitor Soares wrote:
> > > > From: Vitor Soares <vitor.soares@toradex.com>
> > > > 
> > > > Add TPM device found on Verdin iMX8M Mini PID4 0090 variant.
> > > > 
> > > > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 16 +++++++++++-----
> > > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > > index 4768b05fd765..c9ae5f0bb526 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > > > @@ -227,15 +227,16 @@ &ecspi2 {
> > > >  	pinctrl-0 = <&pinctrl_ecspi2>;
> > > >  };
> > > >  
> > > > -/* Verdin CAN_1 (On-module) */
> > > > +/* On-module SPI */
> > > >  &ecspi3 {
> > > >  	#address-cells = <1>;
> > > >  	#size-cells = <0>;
> > > > -	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
> > > > +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>, <&gpio4 19 GPIO_ACTIVE_LOW>;
> > > >  	pinctrl-names = "default";
> > > > -	pinctrl-0 = <&pinctrl_ecspi3>;
> > > > +	pinctrl-0 = <&pinctrl_ecspi3>, <&pinctrl_pmic_tpm_ena>;
> > > 
> > > Would it make more sense to have tpm pinctrl in node tpm@1 below?
> > It's the pinctrl of the SPI Chip Select pin, not something about the
> > TPM, I think it's correct to have it into the ecspi node.
> 
> The name pinctrl_pmic_tpm_ena seems confusing then.

I agree (this is coming from the schematics net name, let's blame the HW folks).

With that said, let's rename this to `pinctrl_tpm_spi_cs`. Vitor?

Francesco


