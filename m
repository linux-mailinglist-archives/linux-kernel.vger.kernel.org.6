Return-Path: <linux-kernel+bounces-312412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7276C969647
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA2A285B27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9E20010C;
	Tue,  3 Sep 2024 07:57:43 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946411DAC7D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350263; cv=none; b=h426ZutiaZeOUooXk2PuslTD+cWBWyRD/FM7uhUWFVmSXs4EDmPkhDn5KV5aJimW6Oyi5v5pBm7qmzTOuVwIS+8KSubGJ3BABbaTLZrSjT+kO5HvlaViZriI3vor5OCDqKEiyrZ+5qFwcMWcVAD+yYhIrVOj+cGa92OdCYCMHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350263; c=relaxed/simple;
	bh=mS89u6S+9MB6huaeT8Y+NqcQKExuTO5JOQzm6wkGMyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEiVIZ/xtH8JW5izUFj+iXktU6f0QJQE2Rt9w+Bjz/h4wOEl82ztyVCuBnia93GRFJL+ywug5yqleOos0ItgWBwj+KJCEXj6HiFLFJixiN2734Urs2uB22ZjXG2z235hG45stdHXd9nH8pc2yjdpihjzsigHU9cN6k4yGjfkDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1slOPq-0007ir-QS; Tue, 03 Sep 2024 09:57:30 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1slOPq-0058GW-4b; Tue, 03 Sep 2024 09:57:30 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1slOPq-004NHD-04;
	Tue, 03 Sep 2024 09:57:30 +0200
Date: Tue, 3 Sep 2024 09:57:30 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com, festevam@gmail.com, frieder.schrempf@kontron.de,
	aford@beaconembedded.com, Sandor.yu@nxp.com,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/5] phy: freescale: fsl-samsung-hdmi: Simplify
 REG21_PMS_S_MASK lookup
Message-ID: <20240903075730.3323moqlc37ykeas@pengutronix.de>
References: <20240903013113.139698-1-aford173@gmail.com>
 <20240903013113.139698-3-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903013113.139698-3-aford173@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Adam,

On 24-09-02, Adam Ford wrote:
> The value of 'S' is writen to two places, PHY_REG3[7:4] and
> PHY_REG21[3:0].  There is a lookup table which contains
> the value of PHY_REG3.  Rather than using a switch statement
> based on the pixel clock to search for the value of 'S' again,
> just shift the contents of PHY_REG3[7:4] >> 4 and place the value
> in PHY_REG21[3:0].  Doing this can eliminate an entire function.

Good catch!

> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 39 ++------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index bc5d3625ece6..a700a300dc6f 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -355,40 +355,6 @@ to_fsl_samsung_hdmi_phy(struct clk_hw *hw)
>  	return container_of(hw, struct fsl_samsung_hdmi_phy, hw);
>  }
>  
> -static void
> -fsl_samsung_hdmi_phy_configure_pixclk(struct fsl_samsung_hdmi_phy *phy,
> -				      const struct phy_config *cfg)
> -{
> -	u8 div = 0x1;
> -
> -	switch (cfg->pixclk) {
> -	case  22250000 ...  33750000:
> -		div = 0xf;
> -		break;
> -	case  35000000 ...  40000000:
> -		div = 0xb;
> -		break;
> -	case  43200000 ...  47500000:
> -		div = 0x9;
> -		break;
> -	case  50349650 ...  63500000:
> -		div = 0x7;
> -		break;
> -	case  67500000 ...  90000000:
> -		div = 0x5;
> -		break;
> -	case  94000000 ... 148500000:
> -		div = 0x3;
> -		break;
> -	case 154000000 ... 297000000:
> -		div = 0x1;
> -		break;
> -	}
> -
> -	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK, div),
> -	       phy->regs + PHY_REG(21));
> -}
> -
>  static void
>  fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fsl_samsung_hdmi_phy *phy,
>  					    const struct phy_config *cfg)
> @@ -457,7 +423,10 @@ static int fsl_samsung_hdmi_phy_configure(struct fsl_samsung_hdmi_phy *phy,
>  	for (i = 0; i < PHY_PLL_DIV_REGS_NUM; i++)
>  		writeb(cfg->pll_div_regs[i], phy->regs + PHY_REG(2) + i * 4);
>  
> -	fsl_samsung_hdmi_phy_configure_pixclk(phy, cfg);
> +	/* High nibble of pll_div_regs[1] contains S which also gets written to REG21 */
> +	writeb(REG21_SEL_TX_CK_INV | FIELD_PREP(REG21_PMS_S_MASK,
> +	       cfg->pll_div_regs[1] >> 4), phy->regs + PHY_REG(21));
> +
>  	fsl_samsung_hdmi_phy_configure_pll_lock_det(phy, cfg);
>  
>  	writeb(REG33_FIX_DA | REG33_MODE_SET_DONE, phy->regs + PHY_REG(33));
> -- 
> 2.43.0
> 
> 

