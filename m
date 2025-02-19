Return-Path: <linux-kernel+bounces-522631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B08A3CCA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6710217861E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A225B67A;
	Wed, 19 Feb 2025 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m+dF/oRw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759023C8CC;
	Wed, 19 Feb 2025 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005485; cv=none; b=CdfBwr5Op1rtsVpWLVqcolE+K94HiqKj4YhbUml/lTS/gaUVgzq7jglDeNJXQeUvOM+hiumZnSz5X0UkrK89PE/+JJDtrdlwSa7l8RoAE1rl+5lkQ/fS57UNbJHqHKSReMBpPc055u6vnWDtGdck13qFKudmrzIylWa7HasRULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005485; c=relaxed/simple;
	bh=YaqNAzVcaPa2EnpUmSOLCSRYurwsI9uT/T9+XNUlP+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsFSFOQVCKC8wqbOwhnYn9LgN0hgMFRRDbT2DEAsytUmFCkVluI9+AJjpzRAaJT8dDzTdiDk7E8faqt0HwEw0EUNRwkAQ5XRqY8BmCPeBVRSY1JH9eOQK5CQc8jEo3oJINYsxp+HvZO1Fk36ai8516zMUCr4d9yA0BM/hnGld0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m+dF/oRw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CBLCEogiLTx2PTS7BtILZh9Og4OzIj+0Y+joFEKIYq4=; b=m+dF/oRwCmIwDs9a3/gn0ZWjaG
	by0scE3rRECPq7eEcr+YBVFEDrA6UEl/oC/bfhGt3CleKhMf1SN/UlUKD2Fuc2ghd2CnLGJfe1Z5E
	ydDkHobvR4LfVUO/hIewM6/8tDwVk1XR6Rk2WmJ55DqxF7Q6faylgVknyfq8JgNnW8CqO6G4Ffo4Q
	K1MeesZWZHWGPV7eCQalek8p3TZ63+pWYhU+sN6t0TP9Q70VI44BXsMWyDGGVdni6IoJt4AIJ/hDe
	6Qj5pp+AQ0mY0aqckgZdFIUlP+7p89Bbpc2QuUz4l+l/SJYwjxzL5OOFFLAYyTo3psioRsukZNbBh
	o1dI0G5g==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tksuR-00067C-PW; Wed, 19 Feb 2025 23:51:15 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>
Cc: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quentin.schulz@cherry.de,
 sebastian.reichel@collabora.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 dse@thaumatec.com, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v6 2/2] phy: rockchip: Add Samsung MIPI D-/C-PHY driver
Date: Wed, 19 Feb 2025 23:51:14 +0100
Message-ID: <2030933.8hb0ThOEGa@diego>
In-Reply-To: <Z68zdiIl75k2Vv9i@vaman>
References:
 <20250213210554.1645755-1-heiko@sntech.de>
 <20250213210554.1645755-3-heiko@sntech.de> <Z68zdiIl75k2Vv9i@vaman>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Vinod,

thanks for the review.
I've dropped all the parts that would've just gotten a "ok, changed" ;-)

Am Freitag, 14. Februar 2025, 13:13:42 MEZ schrieb Vinod Koul:
> On 13-02-25, 22:05, Heiko Stuebner wrote:

> > +	{ 200,  7,   1,  0, 33,  9,  0, 26,  5,  0, 11},
> > +	{ 190,  7,   1,  0, 32,  9,  0, 25,  5,  0, 11},
> > +	{ 180,  6,   1,  0, 32,  8,  0, 25,  5,  0, 10},
> > +	{ 170,  6,   0,  0, 32,  8,  0, 25,  5,  0, 10},
> > +	{ 160,  5,   0,  0, 31,  8,  0, 24,  4,  0,  9},
> > +	{ 150,  5,   0,  0, 31,  8,  0, 24,  5,  0,  9},
> > +	{ 140,  5,   0,  0, 31,  8,  0, 24,  5,  0,  8},
> > +	{ 130,  4,   0,  0, 30,  6,  0, 23,  3,  0,  8},
> > +	{ 120,  4,   0,  0, 30,  6,  0, 23,  3,  0,  7},
> > +	{ 110,  3,   0,  0, 30,  6,  0, 23,  3,  0,  7},
> > +	{ 100,  3,   0,  0, 29,  5,  0, 22,  2,  0,  6},
> > +	{  90,  3,   0,  0, 29,  5,  0, 22,  2,  0,  6},
> > +	{  80,  2,   0,  0, 28,  5,  0, 22,  2,  0,  5},
> > +};
> 
> any word on where this table came from, maybe worth documenting that
> part

sadly not.

The table itself came from the vendor-kernel, and I would assume there
it came from some super-secret additional documentation Rockchip
got with the IP documentation.

It is sadly not part of the RK3588 manual.


> > +
> > +static void samsung_mipi_dcphy_bias_block_enable(struct samsung_mipi_dcphy *samsung)
> > +{
> > +	u32 bias_con2 = 0x3223;
> 
> magic value?

Converted over to some more meaningful constants.
Did the same to bias_con0+1 below that one too.


> > +static void samsung_mipi_dphy_lane_disable(struct samsung_mipi_dcphy *samsung)
> > +{
> > +	regmap_update_bits(samsung->regmap, DPHY_MC_GNR_CON0, PHY_ENABLE, 0);
> > +	regmap_update_bits(samsung->regmap, COMBO_MD0_GNR_CON0, PHY_ENABLE, 0);
> > +	regmap_update_bits(samsung->regmap, COMBO_MD1_GNR_CON0, PHY_ENABLE, 0);
> > +	regmap_update_bits(samsung->regmap, COMBO_MD2_GNR_CON0, PHY_ENABLE, 0);
> > +	regmap_update_bits(samsung->regmap, DPHY_MD3_GNR_CON0, PHY_ENABLE, 0);
> 
> Is writing to a register (mmio) faster than a switch case for checking
> lane count and disabling specific lanes?

It might make sense to mimic the lane_enable way of doing things, even if
just for things looking the same in both functions.

I guess disabling lanes does not really care about minimal speed differences
a switch/case would cause :-)

> 
> > +static void samsung_mipi_dcphy_pll_configure(struct samsung_mipi_dcphy *samsung)
> > +{
> > +	regmap_update_bits(samsung->regmap, PLL_CON0, S_MASK | P_MASK,
> > +			   S(samsung->pll.scaler) | P(samsung->pll.prediv));
> > +
> > +	if (samsung->pll.dsm < 0) {
> > +		u16 dsm_tmp;
> > +
> > +		/* Using opposite number subtraction to find complement */
> > +		dsm_tmp = abs(samsung->pll.dsm);
> > +		dsm_tmp = dsm_tmp - 1;
> > +		dsm_tmp ^= 0xffff;
> > +		regmap_write(samsung->regmap, PLL_CON1, dsm_tmp);
> > +	} else {
> > +		regmap_write(samsung->regmap, PLL_CON1, samsung->pll.dsm);
> > +	}
> > +
> > +	regmap_update_bits(samsung->regmap, PLL_CON2,
> > +			   M_MASK, M(samsung->pll.fbdiv));
> > +
> > +	if (samsung->pll.ssc_en) {
> > +		regmap_write(samsung->regmap, PLL_CON3,
> > +			     MRR(samsung->pll.mrr) | MFR(samsung->pll.mfr));
> > +		regmap_update_bits(samsung->regmap, PLL_CON4, SSCG_EN, SSCG_EN);
> > +	}
> > +
> > +	regmap_write(samsung->regmap, PLL_CON5, RESET_N_SEL | PLL_ENABLE_SEL);
> > +	regmap_write(samsung->regmap, PLL_CON7, PLL_LOCK_CNT(0xf000));
> > +	regmap_write(samsung->regmap, PLL_CON8, PLL_STB_CNT(0xf000));
> 
> I guess you are writing to upper nibble, maybe define that, if we can

Nope ... the value is defined as bits [15:0] and both being pll lock and
stabilization timing control registers. Sadly yet again, their usage detail
is not documented, the manual even does not supply a unit for the 
register value :-(


Heiko



