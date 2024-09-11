Return-Path: <linux-kernel+bounces-324233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC79749C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB021C21959
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AA51C4A;
	Wed, 11 Sep 2024 05:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="JOKN0NyP"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDF6F2F3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726032453; cv=none; b=AiEpOTNoopLDnB2nXK2dO7lhsU0V2WGDTnLyW1GGj5zuxTimZyhoi8EaK+TGOks+kEF1L+JoA9hxhjx1+f2DYddMUfDNsZPZLl67ui6AKF7B6hXv4oJvyGuUFF1LU08/6eYkLwecBf7UY5DmJkpS2i5YMvP4MfSt50zR1LN8kSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726032453; c=relaxed/simple;
	bh=fFqmsRboEWRZwHkQtzKWfd655fCQNjGE32uImHwnfoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaBg8TZV20Z+kGJIZPen3kMKiPF4vKLzaU8O6U7rIoC3kfDE+6rJ6VlYUVR4IbKh2F++nZ5CgrpBhnc7WBxVlVDOj5RcaLYb87ix0iQY3usTN8erHfhK8MSJf9L6nOrX741bwxl8FK0tyra/g4Z4wbwhUTYAWcVmYLwgyir1KmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=JOKN0NyP; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=JOKN0NyP;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id F3040948
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:27:30 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2070daaf8f1so44425335ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 22:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726032450; x=1726637250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uj/IGL3QgYv6zsXXN0ddxeWgiJjwVJ25z60ECrnpg4=;
        b=JOKN0NyPDoq0FIY9nCPDrZJIvutYhyu/wyKPHgXboeseSFxCYDL0fIoJ4r4dY9m9SY
         Z/EJX2DOPhtwBSJhYjGIh/V8czetsI4VToeFUSAcxY6WzfTK6j3LmbFdGps0O3aqeg3L
         3js/Vx5uF+8qdhxZLZ5bmGuo6AqpY3I7OidE5Xs8aG+4YNDiBzlzQXuyOVIlaOiffWVo
         F7oMYxS6BOqJIz8qkMw2S/1lahTrsJrElYPUt37U35jmC1CkHzv94FSE2ZnNZ/CfX+mT
         iir1SXrZobtwnrbFTozaQHGUkHD4UCuMRIbXWpbGhAMxn4bID+/nqN8ZCMeXqV8DHtVL
         csCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726032450; x=1726637250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Uj/IGL3QgYv6zsXXN0ddxeWgiJjwVJ25z60ECrnpg4=;
        b=HEjDlSx2SrnZVfQRU0AVGt0BqARpoTEzGEH2ALSW5J3uq+alF0Gbx1C+y1T1j2orjI
         /gCNAPONPZRqHvssSJTaiqZ++7MbVl5wq6CafoQ4qoyhQdp33dzmqrXZtbpi+JtHtMoP
         W+k3XkEDl13WcubR7vyiuohA60ao7lOpOjlE5beI9OYRYV1p3+k2M0PcYQTHMUdclpoQ
         LwtWhDZhwmlg4ZE6vthYjh0tdD9sBMio2SvoaLjdG5rxfHEZVhchXiyZzeHPxHJ1CsDB
         cbMmy5luRgN54/r0CRkODTlNSj8O84BfwR794GqaBadPc0Ku4Ifld9B7Q1NjGMqbjYD2
         mQrg==
X-Forwarded-Encrypted: i=1; AJvYcCVDn6sYVk3aTAWg5+xKRIKccV/+idDMqoz3bQKoXcjGc3mMPKU13luNmZshUMtxF3OpzeJ+2xDOQugYIyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL5+HQOedLLI8x9LsOQy3f3VXylzqENwxmetyz58JLDYFlhnON
	oiaF2aHmbCwTxoWVNUK9ddgorTBHjO1QOVarHy98wQZ9NEq7nsLltYT8yxabXEYC58sMke96bdA
	n64DGBUS0kzU/+WFbC2Cvsqt5H+EBvOfoDa4oxLD3skA4vdsD5cKpfCILhqDIef4=
X-Received: by 2002:a17:902:d492:b0:206:9caf:1e00 with SMTP id d9443c01a7336-2074c5e11c5mr48674245ad.25.1726032449914;
        Tue, 10 Sep 2024 22:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPUGzThfUzlWxMeUHpc1OnJoW4HlHkAf+m5Cm7pn1mQaYlB/gP65X++hlSKjwtRilI1kNH4w==
X-Received: by 2002:a17:902:d492:b0:206:9caf:1e00 with SMTP id d9443c01a7336-2074c5e11c5mr48673895ad.25.1726032449486;
        Tue, 10 Sep 2024 22:27:29 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc014a58sm9511223a91.17.2024.09.10.22.27.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 22:27:29 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:27:17 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
Message-ID: <ZuEqNVWSPXXR1YHM@atmark-techno.com>
References: <20240911012838.944630-1-aford173@gmail.com>
 <20240911012838.944630-5-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240911012838.944630-5-aford173@gmail.com>

Adam Ford wrote on Tue, Sep 10, 2024 at 08:28:10PM -0500:
> Currently, if the clock values cannot be set to the exact rate,
> the round_rate and set_rate functions use the closest value found in
> the look-up-table.  In preparation of removing values from the LUT
> that can be calculated evenly with the integer calculator, it's
> necessary to ensure to check both the look-up-table and the integer
> divider clock values to get the closest values to the requested
> value.  It does this by measuring the difference between the
> requested clock value and the closest value in both integer divider
> calucator and the fractional clock look-up-table.
> 
> Which ever has the smallest difference between them is returned as
> the closest rate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Thank you for the rework,

Reviewed-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

> ---
> V7:  Because of the previous patch refactoring, the flow of this patch
>      changed quite a bit to use more help functions and goto statements
>      to hopefully make the code flow better and improve comment
>      readability.  Because of the change, I removed s-o-b and r-b,
>      and t-b tags.
> 
> V6:  Simplify the calculation of the closest rate and fix
>      a situation where the integer divider values may not be properly
>      setup before they are used.
>      Fixup some comments
> V5:  No Change
> V4:  New to series
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 40 ++++++++++++++------
>  1 file changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 49317a96f767..67a28aac9c45 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -577,6 +577,16 @@ static void fsl_samsung_hdmi_calculate_phy(struct phy_config *cal_phy, unsigned
>  	/* pll_div_regs 3-6 are fixed and pre-defined already */
>  }
>  
> +static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
> +						 u32 int_div_clk, u32 frac_div_clk)
> +{
> +	/* The int_div_clk may be greater than rate, so cast it and use ABS */
> +	if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))
> +		return int_div_clk;
> +
> +	return frac_div_clk;
> +}
> +
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> @@ -624,27 +634,33 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>  		goto use_fract_div;
>  
>  	/*
> -	 * If the rate from the fractional divder is not exact, check the integer divider,
> +	 * If the rate from the fractional divider is not exact, check the integer divider,
>  	 * and use it if that value is an exact match.
>  	 */
>  	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
> +	fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
>  	if (int_div_clk == rate) {
> -		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n",
> -				   int_div_clk);
> -
> -		fsl_samsung_hdmi_calculate_phy(&calculated_phy_pll_cfg, int_div_clk, p, m, s);
> -		phy->cur_cfg  = &calculated_phy_pll_cfg;
> -		return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
> +		goto use_int_div;
>  	}
>  
>  	/*
> -	 * If neither the fractional divder nor the integer divder can find an exact value
> -	 * fall back to using the fractional divider
> +	 * Compare the difference between the integer clock and the fractional clock against
> +	 * the desired clock and which whichever is closest,
>  	 */
> +	if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
> +						  fract_div_phy->pixclk) == fract_div_phy->pixclk)
> +		goto use_fract_div;
> +
> +use_int_div:
> +	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: integer divider rate = %u\n", int_div_clk);
> +	phy->cur_cfg  = &calculated_phy_pll_cfg;
> +	goto end;
> +
>  use_fract_div:
> -	phy->cur_cfg = fract_div_phy;
> -	dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
> -			   phy->cur_cfg->pixclk);
> +	 phy->cur_cfg = fract_div_phy;
> +	 dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider rate = %u\n",
> +		   phy->cur_cfg->pixclk);
> +end:
>  	return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
>  }
>  

