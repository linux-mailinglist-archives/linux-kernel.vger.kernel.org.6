Return-Path: <linux-kernel+bounces-308241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E02965927
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8001F24A59
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6BB16190B;
	Fri, 30 Aug 2024 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsaF7WdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40B615C129
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004536; cv=none; b=q72ah39+2ysQE+pUK6fA21hgsax2CncKvvVoMbBepygjzrimXchhl1SIXn+gsQUDXewycu5TdPsZdCgAaKUx2Y00sqo0EtfuYLDX3pUkY8KB5jcymWDFRAJ1HFcYtc87bsHW9hOITDNjiRH7dyH4uuDKxmsQXOxNtB2aGS2Vkeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004536; c=relaxed/simple;
	bh=a6GgthwpQdP+3MyNf7hJ+X0yUzvhEYWRQZqJ5m0AGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc0h+I+H15z3ZAMrkghGr3uVyB5jFgDJtO0rXUb+eqHQunieGgTYyEY5hV38ywZK4Dl8Wmi+S+WL/jxVzivfwiQr+fDQJCrR8OwIBp165NzrXEFj180dZwoP9kJWt31Tk8j9+FIqiyWCino7qKC7VbjKzTsuZXn9Q7WZoDhGauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsaF7WdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFE3C4CEC2;
	Fri, 30 Aug 2024 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725004536;
	bh=a6GgthwpQdP+3MyNf7hJ+X0yUzvhEYWRQZqJ5m0AGNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsaF7WdG755TNKq/3PWm9sS0/Bd+hFVVXie4y2g6fUjg1JbbGBwcnjpTzvPWLPXGe
	 f2YSn5lJ7AOZ4TsZfkiaLyQ6ECWP/62lfyHmIujIbH9GcGIH9rG902kTYHNRUgtj5U
	 9kBbqkZHXedvl3+9hdTqz5ml/0kXrLn+ar3TgiO2eA5620kdXplSABOn6t9gvyfVsf
	 2ksOaIdzQ0h2E7jpM/1anpXTZ275HnwBaYFEzNyE7PZQmq1R9ntAXV8l0QuIeWqKYj
	 53FbgzbXv0mdWjuVlYro2QTSz7cX2GeNZgd9bvoovfauj/RVUFy8WtpZgw8j0wYNE4
	 J6CH+qla9AHaQ==
Date: Fri, 30 Aug 2024 13:25:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com, festevam@gmail.com, frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 2/2] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer divider
Message-ID: <ZtF69NSHFtAwDupq@vaman>
References: <20240829021256.787615-1-aford173@gmail.com>
 <20240829021256.787615-2-aford173@gmail.com>
 <ZtC2LhYAAdPdSRpz@vaman>
 <CAHCN7xKW=zxips+J73913eEfS+p_e3dN9BWU08=poj599JbUxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xKW=zxips+J73913eEfS+p_e3dN9BWU08=poj599JbUxA@mail.gmail.com>

On 29-08-24, 13:30, Adam Ford wrote:
> On Thu, Aug 29, 2024 at 12:56 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 28-08-24, 21:12, Adam Ford wrote:
> > > There is currently a look-up table for a variety of resolutions.
> > > Since the phy has the ability to dynamically calculate the values
> > > necessary to use the intger divider which should allow more
> > > resolutions without having to update the look-up-table.  If the
> > > integer calculator cannot get an exact frequency, it falls back
> > > to the look-up-table.  Because the LUT algorithm does some
> > > rounding, I did not remove integer entries from the LUT.
> >
> > Any reason why this is RFC?
> 
> Someone was asking for functionality, but I'm not 100% sure this is
> the right approach or it would even work.  I am waiting for feedback
> from Dominique to determine if this helps solve the display for that
> particular display.
> 
> >
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > index bc5d3625ece6..76e0899c6006 100644
> > > --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> > > @@ -16,6 +16,8 @@
> > >
> > >  #define PHY_REG(reg)         (reg * 4)
> > >
> > > +#define REG01_PMS_P_MASK     GENMASK(3, 0)
> > > +#define REG03_PMS_S_MASK     GENMASK(7, 4)
> > >  #define REG12_CK_DIV_MASK    GENMASK(5, 4)
> > >  #define REG13_TG_CODE_LOW_MASK       GENMASK(7, 0)
> > >  #define REG14_TOL_MASK               GENMASK(7, 4)
> > > @@ -31,11 +33,17 @@
> > >
> > >  #define PHY_PLL_DIV_REGS_NUM 6
> > >
> > > +#ifndef MHZ
> > > +#define MHZ  (1000UL * 1000UL)
> > > +#endif
> > > +
> > >  struct phy_config {
> > >       u32     pixclk;
> > >       u8      pll_div_regs[PHY_PLL_DIV_REGS_NUM];
> > >  };
> > >
> > > +static struct phy_config custom_phy_pll_cfg;
> > > +
> > >  static const struct phy_config phy_pll_cfg[] = {
> > >       {
> > >               .pixclk = 22250000,
> > > @@ -440,10 +448,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
> > >              phy->regs + PHY_REG(14));
> > >  }
> > >
> > > +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
> > > +{
> > > +     unsigned long best_freq = 0;
> > > +     u32 min_delta = 0xffffffff;
> >
> > > +     u8 _p, best_p;
> > > +     u16 _m, best_m;
> > > +     u8 _s, best_s;
> > > +
> > > +     for (_p = 1; _p <= 11; ++_p) {
> >
> > starts with 1 to 11.. why?
> 
> According to Rev 2 of the 8MP Reference Manual, the Previder range is
> between 1 and 11.

Would be better to document these assumptions, am sure if someone asks
you this next year, it would be hard to recall :-)

-- 
~Vinod

