Return-Path: <linux-kernel+bounces-307413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D101B964D50
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BACE1F25A53
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD41B78FD;
	Thu, 29 Aug 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIqUHkZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F11494AF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954162; cv=none; b=fkuCcX9W4cBRk+ht2ElX98HYHrw2LA9RcR15jhf7gx/RHtU24Hre1JHQyMJlWaS4dDamr4YjD6rEMTgmykKDdIujeEsqHP/virhiNwrsEONw+suseuuPQ9EAxn4L4IKXbMbnsaKBBx/zutUH5x7ekNXKR7+mNQxYoC0MwTLDTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954162; c=relaxed/simple;
	bh=AdzfqrDZaOuc1QbK407DlhXv2urEHeKQSLxkuHSAl+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6n8bko5dDpSPgYMJ+I+VDWijC3CIDN+htpaoZ+ytKODLwARcx/GtjKTVn2c7V4amtG8vHsIBjLPrmfnc/ZtKX86hkcScek5X627t7riRIng953s2zELtEBCYMneo+mLf/2FO1sBMqVZOS6LjWt/aP7MTn4Q0+6G/AY9ZHS+5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIqUHkZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C607AC4CEC1;
	Thu, 29 Aug 2024 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724954162;
	bh=AdzfqrDZaOuc1QbK407DlhXv2urEHeKQSLxkuHSAl+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIqUHkZJPj1xXtu1VYJSvObjGnXZK1Diff7LMNqLJRkuL5Pu/JQUPXqeCN9w0li2O
	 krKyBzgqr4stFskXudyP1W+HzV8oSuPM7xrKjapqoIy/kl/xas1VcBRb4y0RoUoSLR
	 wj9b/F6QmTrqUB+HWj3jztGjchvQTip6FQzz3VLUOjxNdHtwIOGSmMNQgy63oisbZq
	 B0bn1vsEw0WXb0yONzBpk4rr5Tajn4oMivKWECfS37TLf8HDacGYSZJTP60ZxuwFcv
	 qrxrwI0d8YJtb9eOQz4aLrFwrO4Uw9FTrur43SQRH41i/5krPX6mLzjHMxwOsHcQzi
	 +EiLem7J77wQg==
Date: Thu, 29 Aug 2024 23:25:58 +0530
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
Message-ID: <ZtC2LhYAAdPdSRpz@vaman>
References: <20240829021256.787615-1-aford173@gmail.com>
 <20240829021256.787615-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829021256.787615-2-aford173@gmail.com>

On 28-08-24, 21:12, Adam Ford wrote:
> There is currently a look-up table for a variety of resolutions.
> Since the phy has the ability to dynamically calculate the values
> necessary to use the intger divider which should allow more
> resolutions without having to update the look-up-table.  If the
> integer calculator cannot get an exact frequency, it falls back
> to the look-up-table.  Because the LUT algorithm does some
> rounding, I did not remove integer entries from the LUT.

Any reason why this is RFC?

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index bc5d3625ece6..76e0899c6006 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -16,6 +16,8 @@
>  
>  #define PHY_REG(reg)		(reg * 4)
>  
> +#define REG01_PMS_P_MASK	GENMASK(3, 0)
> +#define REG03_PMS_S_MASK	GENMASK(7, 4)
>  #define REG12_CK_DIV_MASK	GENMASK(5, 4)
>  #define REG13_TG_CODE_LOW_MASK	GENMASK(7, 0)
>  #define REG14_TOL_MASK		GENMASK(7, 4)
> @@ -31,11 +33,17 @@
>  
>  #define PHY_PLL_DIV_REGS_NUM 6
>  
> +#ifndef MHZ
> +#define MHZ	(1000UL * 1000UL)
> +#endif
> +
>  struct phy_config {
>  	u32	pixclk;
>  	u8	pll_div_regs[PHY_PLL_DIV_REGS_NUM];
>  };
>  
> +static struct phy_config custom_phy_pll_cfg;
> +
>  static const struct phy_config phy_pll_cfg[] = {
>  	{
>  		.pixclk = 22250000,
> @@ -440,10 +448,83 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  	       phy->regs + PHY_REG(14));
>  }
>  
> +static unsigned long fsl_samsung_hdmi_phy_find_pms(unsigned long fout, u8 *p, u16 *m, u8 *s)
> +{
> +	unsigned long best_freq = 0;
> +	u32 min_delta = 0xffffffff;

> +	u8 _p, best_p;
> +	u16 _m, best_m;
> +	u8 _s, best_s;
> +
> +	for (_p = 1; _p <= 11; ++_p) {

starts with 1 to 11.. why?

> +		for (_s = 1; _s <= 16; ++_s) {
> +			u64 tmp;
> +			u32 delta;
> +
> +			/* s must be even */
> +			if (_s > 1 && (_s & 0x01) == 1)
> +				_s++;
> +
> +			/* _s cannot be 14 per the TRM */
> +			if (_s == 14)
> +				continue;
> +
> +			/*
> +			 * TODO: Ref Manual doesn't state the range of _m
> +			 * so this should be further refined if possible.
> +			 * This range was set based on the original values
> +			 * in the look-up table
> +			 */
> +			tmp = (u64)fout * (_p * _s);
> +			do_div(tmp, 24 * MHZ);
> +			_m = tmp;
> +			if (_m < 0x30 || _m > 0x7b)
> +				continue;
> +
> +			/*
> +			 * Rev 2 of the Ref Manual states the
> +			 * VCO can range between 750MHz and
> +			 * 3GHz.  The VCO is assumed to be _m x
> +			 * the reference frequency of 24MHz divided
> +			 * by the prescaler, _p
> +			 */
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p);
> +			if (tmp < 750 * MHZ ||
> +			    tmp > 3000 * MHZ)
> +				continue;
> +
> +			tmp = (u64)_m * 24 * MHZ;
> +			do_div(tmp, _p * _s);
> +
> +			delta = abs(fout - tmp);
> +			if (delta < min_delta) {
> +				best_p = _p;
> +				best_s = _s;
> +				best_m = _m;
> +				min_delta = delta;
> +				best_freq = tmp;
> +			}
> +		}
> +	}
> +
> +	if (best_freq) {
> +		*p = best_p;
> +		*m = best_m;
> +		*s = best_s;
> +	}
> +
> +	return best_freq;
> +}
> +
>  static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  					  const struct phy_config *cfg)
>  {
> +	u32 desired_clock = cfg->pixclk * 5;
> +	u32 close_freq;
>  	int i, ret;
> +	u16 m;
> +	u8 p, s;
>  	u8 val;
>  
>  	/* HDMI PHY init */
> @@ -453,11 +534,38 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	for (i = 0; i < ARRAY_SIZE(common_phy_cfg); i++)
>  		writeb(common_phy_cfg[i].val, phy->regs + common_phy_cfg[i].reg);
>  
> -	/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> -	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> -		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
> +	/* Using the PMS calculator alone, determine if can use integer divider */
> +	close_freq = fsl_samsung_hdmi_phy_find_pms(desired_clock, &p, &m, &s);
> +
> +	/* If the clock cannot be configured with integer divder, use the fractional divider */
> +	if (close_freq != desired_clock) {
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use fractional divider\n");
> +		/* set individual PLL registers PHY_REG2 ... PHY_REG7 */
> +		for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
> +			writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
> +		fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
> +	} else {
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: use integer divider\n");
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: P = %d\n", p);
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: M = %d\n", m);
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: S = %d\n", s);
> +		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: frequency = %u\n", close_freq);
> +
> +		/* Write integer divder values for PMS */
> +		writeb(FIELD_PREP(REG01_PMS_P_MASK, p), phy->regs + PHY_REG(1));
> +		writeb(m, phy->regs + PHY_REG(2));
> +		writeb(FIELD_PREP(REG03_PMS_S_MASK, s-1), phy->regs + PHY_REG(3));
> +
> +		/* Configure PHY to disable fractional divider */
> +		writeb(0x00, phy->regs + PHY_REG(4));
> +		writeb(0x00, phy->regs + PHY_REG(5));
> +		writeb(0x80, phy->regs + PHY_REG(6));
> +		writeb(0x00, phy->regs + PHY_REG(7));
> +
> +		writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, s-1),
> +		       phy->regs + PHY_REG(21));
> +	}
>  
> -	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
>  	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
> @@ -484,8 +592,17 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> +	u32 int_div_clk;
>  	int i;
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the integer divider works, just use it */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
> +	if (int_div_clk == rate)
> +		return int_div_clk;
>  
> +	/* Otherwise, fall back to the LUT */
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
>  			return phy_pll_cfg[i].pixclk;
> @@ -497,16 +614,28 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>  			    unsigned long rate, unsigned long parent_rate)
>  {
>  	struct fsl_samsung_hdmi_phy *phy = to_fsl_samsung_hdmi_phy(hw);
> +	u32 int_div_clk;
>  	int i;
> -
> -	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> -		if (phy_pll_cfg[i].pixclk <= rate)
> -			break;
> -
> -	if (i < 0)
> -		return -EINVAL;
> -
> -	phy->cur_cfg = &phy_pll_cfg[i];
> +	u16 m;
> +	u8 p, s;
> +
> +	/* If the integer divider works, just use it */
> +	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
> +	if (int_div_clk == rate) {
> +		/* Just set the pixclk rate, the rest will be calculated */
> +		custom_phy_pll_cfg.pixclk = int_div_clk;
> +		phy->cur_cfg  = &custom_phy_pll_cfg;
> +	} else {
> +		/* Otherwise, search the LUT */
> +		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> +			if (phy_pll_cfg[i].pixclk <= rate)
> +				break;
> +
> +		if (i < 0)
> +			return -EINVAL;
> +
> +		phy->cur_cfg = &phy_pll_cfg[i];
> +	}
>  
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }
> -- 
> 2.43.0

-- 
~Vinod

