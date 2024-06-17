Return-Path: <linux-kernel+bounces-217572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219490B1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F76284C02
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D747F1A255D;
	Mon, 17 Jun 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhTGVFmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A76194A43;
	Mon, 17 Jun 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631041; cv=none; b=bhHHcEQ+jJdygTH2Z1f+jvhDtzxznKM8WewYDbVLdxfxmc0xB1iwRt4oPv6e17Pj0XDieFAho36udRb/YxMz7Rka0iMC+jPqLsqHUY5Nka5LPHRgwfe/LZsJ0MorJ9HsQeZ3FkU212SMAVQfyWgOXJecMMZZPjlk1x5hVrfIp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631041; c=relaxed/simple;
	bh=K1d1FkkEzlQ/UT9ihqbOKIjtW36wnnFLcT/ZvMOVYFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfGxZMQspP33BvPE5w313y1e6g4HUDaD2qoDqOxwGttC4PGQZvDWWvV/xckiaqFY9ac4er+RORU/oclwGlQfNkQ28BSrG1UCpfiGi866ucXg44x8oM9zoKRjI5Y3R/Wo27ORlieOIqSZC60CsZfNH+4dfeE+4AcDMGaEtpTn+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhTGVFmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D209EC2BD10;
	Mon, 17 Jun 2024 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718631040;
	bh=K1d1FkkEzlQ/UT9ihqbOKIjtW36wnnFLcT/ZvMOVYFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhTGVFmwyz+fliyEfsQwaIqR+ib5wkuWod8Xw3Xd/q/GBJP141ALpYUx3SINa51Sj
	 fogpyLoW6Mi5ApaXiy6PxD5l4ilE7gQ46/LwMOO/4sxJnrAsOnBRcZF6xEYFNr5mVi
	 DIVXZkX8BYLy8ikwhnkKsXFH8VteP+w/QZlyFN6XjzktWaT29cfOUoPewHiSfHgdlX
	 w+N29UD7JhPaXjW8lmBpIRsYlzfyeQV85MizgwCneZIgUtURBMmUYPW5JUdBnBpDUi
	 wnzapWZrPwOUszAFMV4zm8tL3FUcPJBCljoHV5+me/19eQw+vLWS7SjwREOgYujxaY
	 sWoEv1U4NZp9A==
Date: Mon, 17 Jun 2024 21:16:43 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Yixun Lan <dlan@gentoo.org>, Inochi Amaoto <inochiama@outlook.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Message-ID: <ZnA3O14HOiV1SBPV@xhacker>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240616235829.GA4000183@ofsar>
 <c75601a1-1389-400e-90b9-99c1e775a866@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c75601a1-1389-400e-90b9-99c1e775a866@bootlin.com>

On Mon, Jun 17, 2024 at 11:16:32AM +0200, Thomas Bonnefille wrote:
> 
> 
> On 6/17/24 1:58 AM, Yixun Lan wrote:
> > Hi
> > 
> > On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:
> > > On Wed, Jun 12, 2024 at 10:02:31AM GMT, Thomas Bonnefille wrote:
> > > > Remove SDHCI compatible for CV1800b from common dtsi file to put it in
> > > > the specific dtsi file of the CV1800b.
> > > > This commits aims at following the same guidelines as in the other nodes
> > > > of the CV18XX family.
> > is there any URL of guideline? or did I miss anything
> > couldn't find any discussion about this in v1
> > 
> 
> Not explicitly, the fact is that I had to use a specific compatible on
> SG2002 for the sdhci (it is already defined mainline), I had to choose
> between :
> 
> 1. cv18xx.dtsi : compatible cv1800b-dwcmshc
>    cv1800b.dtsi : no redefined compatible
>    sg2002.dtsi : overwrite the previous compatible to use sg2002-dwcmshc
> 
> 2. cv18xx.dtsi : no compatible
>    cv1800b.dtsi : compatible for cv1800b-dwcmshc
>    sg2002.dtsi : compatible for sg2002-dwcmshc
> 
> As in the plic and clint controllers, the second option was chosen I
> consider this as a "guideline" and reformat the dtsis accordingly.
> 
> > > > 
> > > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > > ---
> > > >   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
> > > >   arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 1 -
> > > >   2 files changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > > index ec9530972ae2..b9cd51457b4c 100644
> > > > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > > > @@ -25,3 +25,7 @@ &clint {
> > > >   &clk {
> > > >   	compatible = "sophgo,cv1800-clk";
> > > >   };
> > > > +
> > > > +&sdhci0 {
> > > > +	compatible = "sophgo,cv1800b-dwcmshc";
> > > > +};
> > > > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > > index 891932ae470f..7247c7c3013c 100644
> > > > --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > > > @@ -288,7 +288,6 @@ uart4: serial@41c0000 {
> > > >   		};
> > > >   		sdhci0: mmc@4310000 {
> > > > -			compatible = "sophgo,cv1800b-dwcmshc";
> > > >   			reg = <0x4310000 0x1000>;
> > > >   			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
> > > >   			clocks = <&clk CLK_AXI4_SD0>,
> > > > 
> > > > -- 
> > > > 2.45.2
> > > > 
> > > 
> > > Hi, Jisheng,
> > > 
> > > Is this change necessary? IIRC, the sdhci is the same across
> > > the whole series.

Hi,

sorry for being late, I was busy in the past 2.5 month. Per my
understanding, the sdhci in cv1800b is the same as the one in
sg200x. Maybe I'm wrong, but this was my impression when I cooked
the sdhci driver patch for these SoCs.

> > I tend to agree with Inochi here, if it's same across all SoC, then no bother to
> > split, it will cause more trouble to maintain..
> > 
> 
> To be honest, I agree with this to, but as a specific compatible for the
> SG2002 was created in commit 849e81817b9b, I thought that the best practice
> was to use it.

I'd like to take this chance to query DT maintainers: FWICT, in the past
even if the PLIC is the same between SoCs, adding a new compatible for
them seems a must. So when time goes on, the compatbile list would be
longer and longer, is it really necessary? Can we just use the existing
compatible string?
DT maintainers may answered the query in the past, if so, sorry for
querying again.

> 
> > > 
> > > Regards,
> > > Inochi
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

