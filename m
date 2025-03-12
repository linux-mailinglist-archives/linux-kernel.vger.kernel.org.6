Return-Path: <linux-kernel+bounces-558060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE23A5E119
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781B61885F31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A972571A4;
	Wed, 12 Mar 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwQIkEMS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F33423ED60;
	Wed, 12 Mar 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794714; cv=none; b=lHdgpqLiiIXrZ7vGMYTFtehw+R7iktcLmATNra8kbuLgn0wRFulxrWdGrW17dSsdMpoaOAyC7qW7OWX7tPJKMIEIOfmaJ6sDoWZIzWHlhQx7oTlk+0OGVAwAj1yYIzArC1yPwXf2OogeJTzI3bneSa3EeKg0HQf0IQs+aNvklgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794714; c=relaxed/simple;
	bh=3rzunnVX6hlrPNBilZi0C8BivrdvDP3q03Wwh9Wyt7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cw3jZAu2C9w+FX03/Ake8tRJqGT6KB0GGOh37xR+CxEfGg+mtx1AelO/2kSHSpFRXgo55c5t6JcnJD7X4lBJdteogidzIwF05Spy3GZOH8Ax3V7Y/1YMGAGY4Ec6SdMCIhc34EBxeQZbGCPceTnZH2oFDmnCzgbrIcIgUFhDzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwQIkEMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4DFC4CEDD;
	Wed, 12 Mar 2025 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741794713;
	bh=3rzunnVX6hlrPNBilZi0C8BivrdvDP3q03Wwh9Wyt7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwQIkEMSlYC8zaL+gV01SAJnS+lHGlbW96iDEHbJUB/4qygwLl2axB/WxqVgnEX5D
	 7AsNbJit+fpLMBpCf/vC5y+Z6R26OMKSTXd1vGrKr8DCpRfcZ611T8gbDCZG7NKiRv
	 A8E9HC1Sm9GKWlT5WCcIlbTzIsnjAOtqnIoqxx4iiaz9FKNeGP3W4vF3LCx8Z4GfVf
	 /E+CKw0f9ezIED3ffRUPab6p7WzTbiaHI+/9KrE/dxRlb4kCWgR4M/Al+/SkZsWR4Z
	 1KWLRV2T9SyNd9yVceJPt7v+M2/hPj6kf/st8D/ZNkFy0wZOqz0MNg3JQG4Wm/ZFb1
	 Cpe1iIKsqgXWQ==
Date: Wed, 12 Mar 2025 16:51:50 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, quentin.schulz@cherry.de,
	sebastian.reichel@collabora.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/2] phy: rockchip: Add Samsung MIPI D-/C-PHY driver
Message-ID: <Z9GtlvHwd8/blVKl@vaman>
References: <20250213210554.1645755-1-heiko@sntech.de>
 <20250213210554.1645755-3-heiko@sntech.de>
 <Z68zdiIl75k2Vv9i@vaman>
 <2030933.8hb0ThOEGa@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2030933.8hb0ThOEGa@diego>


Sorry this slipped thru...

On 19-02-25, 23:51, Heiko Stübner wrote:
> Hi Vinod,
> 
> thanks for the review.
> I've dropped all the parts that would've just gotten a "ok, changed" ;-)
> 
> Am Freitag, 14. Februar 2025, 13:13:42 MEZ schrieb Vinod Koul:
> > On 13-02-25, 22:05, Heiko Stuebner wrote:
> 
> > > +	{ 200,  7,   1,  0, 33,  9,  0, 26,  5,  0, 11},
> > > +	{ 190,  7,   1,  0, 32,  9,  0, 25,  5,  0, 11},
> > > +	{ 180,  6,   1,  0, 32,  8,  0, 25,  5,  0, 10},
> > > +	{ 170,  6,   0,  0, 32,  8,  0, 25,  5,  0, 10},
> > > +	{ 160,  5,   0,  0, 31,  8,  0, 24,  4,  0,  9},
> > > +	{ 150,  5,   0,  0, 31,  8,  0, 24,  5,  0,  9},
> > > +	{ 140,  5,   0,  0, 31,  8,  0, 24,  5,  0,  8},
> > > +	{ 130,  4,   0,  0, 30,  6,  0, 23,  3,  0,  8},
> > > +	{ 120,  4,   0,  0, 30,  6,  0, 23,  3,  0,  7},
> > > +	{ 110,  3,   0,  0, 30,  6,  0, 23,  3,  0,  7},
> > > +	{ 100,  3,   0,  0, 29,  5,  0, 22,  2,  0,  6},
> > > +	{  90,  3,   0,  0, 29,  5,  0, 22,  2,  0,  6},
> > > +	{  80,  2,   0,  0, 28,  5,  0, 22,  2,  0,  5},
> > > +};
> > 
> > any word on where this table came from, maybe worth documenting that
> > part
> 
> sadly not.
> 
> The table itself came from the vendor-kernel, and I would assume there

Maybe make a note that this is from vendor kernel

> it came from some super-secret additional documentation Rockchip
> got with the IP documentation.
> 
> It is sadly not part of the RK3588 manual.
> 
> 
> > > +
> > > +static void samsung_mipi_dcphy_bias_block_enable(struct samsung_mipi_dcphy *samsung)
> > > +{
> > > +	u32 bias_con2 = 0x3223;
> > 
> > magic value?
> 
> Converted over to some more meaningful constants.
> Did the same to bias_con0+1 below that one too.
> 
> 
> > > +static void samsung_mipi_dphy_lane_disable(struct samsung_mipi_dcphy *samsung)
> > > +{
> > > +	regmap_update_bits(samsung->regmap, DPHY_MC_GNR_CON0, PHY_ENABLE, 0);
> > > +	regmap_update_bits(samsung->regmap, COMBO_MD0_GNR_CON0, PHY_ENABLE, 0);
> > > +	regmap_update_bits(samsung->regmap, COMBO_MD1_GNR_CON0, PHY_ENABLE, 0);
> > > +	regmap_update_bits(samsung->regmap, COMBO_MD2_GNR_CON0, PHY_ENABLE, 0);
> > > +	regmap_update_bits(samsung->regmap, DPHY_MD3_GNR_CON0, PHY_ENABLE, 0);
> > 
> > Is writing to a register (mmio) faster than a switch case for checking
> > lane count and disabling specific lanes?
> 
> It might make sense to mimic the lane_enable way of doing things, even if
> just for things looking the same in both functions.
> 
> I guess disabling lanes does not really care about minimal speed differences
> a switch/case would cause :-)

ok

> 
> > 
> > > +static void samsung_mipi_dcphy_pll_configure(struct samsung_mipi_dcphy *samsung)
> > > +{
> > > +	regmap_update_bits(samsung->regmap, PLL_CON0, S_MASK | P_MASK,
> > > +			   S(samsung->pll.scaler) | P(samsung->pll.prediv));
> > > +
> > > +	if (samsung->pll.dsm < 0) {
> > > +		u16 dsm_tmp;
> > > +
> > > +		/* Using opposite number subtraction to find complement */
> > > +		dsm_tmp = abs(samsung->pll.dsm);
> > > +		dsm_tmp = dsm_tmp - 1;
> > > +		dsm_tmp ^= 0xffff;
> > > +		regmap_write(samsung->regmap, PLL_CON1, dsm_tmp);
> > > +	} else {
> > > +		regmap_write(samsung->regmap, PLL_CON1, samsung->pll.dsm);
> > > +	}
> > > +
> > > +	regmap_update_bits(samsung->regmap, PLL_CON2,
> > > +			   M_MASK, M(samsung->pll.fbdiv));
> > > +
> > > +	if (samsung->pll.ssc_en) {
> > > +		regmap_write(samsung->regmap, PLL_CON3,
> > > +			     MRR(samsung->pll.mrr) | MFR(samsung->pll.mfr));
> > > +		regmap_update_bits(samsung->regmap, PLL_CON4, SSCG_EN, SSCG_EN);
> > > +	}
> > > +
> > > +	regmap_write(samsung->regmap, PLL_CON5, RESET_N_SEL | PLL_ENABLE_SEL);
> > > +	regmap_write(samsung->regmap, PLL_CON7, PLL_LOCK_CNT(0xf000));
> > > +	regmap_write(samsung->regmap, PLL_CON8, PLL_STB_CNT(0xf000));
> > 
> > I guess you are writing to upper nibble, maybe define that, if we can
> 
> Nope ... the value is defined as bits [15:0] and both being pll lock and
> stabilization timing control registers. Sadly yet again, their usage detail
> is not documented, the manual even does not supply a unit for the 
> register value :-(

:-(


-- 
~Vinod

