Return-Path: <linux-kernel+bounces-317993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ABF96E6D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6520B1C21A64
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B217579;
	Fri,  6 Sep 2024 00:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="IDWFoFce"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA4D531
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582418; cv=none; b=DBnXkwjGmn2mUmgNAK/nyrmT7DEQGajyaLFc+A7sLHzGNBGpleKhxaNXF2eX7H+2iCfGhzXENyMufiEVgWcU4GdrddGpxFU0FdbfZ8XmcBkDa355hXZRmrB8wpHY8yuo0jYMKjQVFjHEvQegHn4y3vhmCF01Sz+k2htVr2k6OVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582418; c=relaxed/simple;
	bh=CT3NVRWc+M60qFnZhXV9s32dBdnmeq2G7C8xXw3YEfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnsNhjuqqzTeEGzBTXZzX2vI/4Zd1FxO+wv652lc5GVVP6kovvn323YlM6YoVz0vJf6UXlycL0Rrq02PSHoYO8C4Ktwh48VM2e0APU+2+DpWb6PUiDc93KyvOOM6NGLyUbhdzW3rmVEomXFKCZmyTVDb9p2JJxoXN92scMw89SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=IDWFoFce; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=IDWFoFce;
	dkim-atps=neutral
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 1DC2C684
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:26:50 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d877d7f9b4so1956096a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1725582409; x=1726187209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGTM8z3drlabx5saFMxcrZbEE2LPwIqPrjtUbOYE5m8=;
        b=IDWFoFceJBE/NemvnCaieLcEDF+8DTRmNvFTcKgn9JK5dabQB1i8f8FB9OXrpIWXZC
         fB8cCVytKipS57OkonlgGIa3rr+dBNekNIFxrKDd8CYHQPqxyeX30rWEg/TmsnBHn/Ex
         NkWYTBu33UFjImhXHv6RhzPEMvgg/wRO/I0/bA6AXjfPkBaecWfGf6gYNT0ZvZsgvjH/
         5lTm1HmXj3iDCokvS7cPApypnpce/5jm6Sn+eXzO++VXL8fb6RIeA6iGojxeuWawviNR
         ItbFeaoYUlt8uRCCvMboVKNlP+7iYzO6ZoqooZpv4zG2eVvCVnUCddvNpoRlplh6d54q
         tfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582409; x=1726187209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGTM8z3drlabx5saFMxcrZbEE2LPwIqPrjtUbOYE5m8=;
        b=UtKf5flMeO5VozvdaJF8O70cMY1qb+8qwjqaBBUnf6TbZ6JgdeXRQ539UIZWWaWxT6
         l5+oTnM/hMcSsDyFphQg8K14ddvOwdJYtkdMyl0UU4s3oK7DL55xkAnIgiLau30T7eT9
         jIcUxQR/ueKf6eZX1imS9oATXCU29mxajT5PnEkFJGKFkujhqSKF4YR6HKBjf3QDaGCV
         QakNhanl7dLNUuLhhe4AEsnC7xsClnQIdC9exb6sk6Sm1tHG5xxEq9AzR1jXz1kwpYTZ
         9fQ4EXLTf5cygNjKzvo6dm4aqHLAC5uXYkDIGZi1sMDF5zigEwD7WF4DONfAIhamkNtG
         UJDw==
X-Forwarded-Encrypted: i=1; AJvYcCUEp/whEbeOHcky8XFBQLCN1vp9AvhhXHL+uxlLPnViQru6pFGHEg5sPMSg74QNqoeGIVZOaVJfj9aoRto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY3frnGBsgVepzY4fzlweTx5/lECU+GLcyR9JJzcK3Oqr1V+Jv
	EjzOE+dMgjvG5BxeNtzCoaYtlRzPmG0GKeLAjEWNpdddTzOkVPrTbuZgenwMtlVCuHFGiPGySmP
	MaRN428NpPbKVhG/zYyiEEzDnSeN3A63ro0BELXh0CFosLrv5tV26PXiwnBmHoCE=
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2dad513a8d5mr993638a91.40.1725582408955;
        Thu, 05 Sep 2024 17:26:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGssYkvho2wuTiIV5XqLvj+xnJwXtMw7FK+bKNnXv5/kW4P3Qtr4XZhgQnImulOf/HrOPuE7A==
X-Received: by 2002:a17:90b:2248:b0:2d3:db91:ee82 with SMTP id 98e67ed59e1d1-2dad513a8d5mr993625a91.40.1725582408574;
        Thu, 05 Sep 2024 17:26:48 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc091116sm150733a91.46.2024.09.05.17.26.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2024 17:26:48 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:26:36 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-imx@nxp.com, festevam@gmail.com,
	frieder.schrempf@kontron.de, aford@beaconembedded.com,
	Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/5] phy: freescale: fsl-samsung-hdmi: Use closest
 divider
Message-ID: <ZtpMPCHBnEgtkBWp@atmark-techno.com>
References: <20240904233100.114611-1-aford173@gmail.com>
 <20240904233100.114611-5-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904233100.114611-5-aford173@gmail.com>


(sorry I meant to send this yesterday but I'm being forced to adjust my
mail pipeline with work and gmail and it didn't go out -- trying
again. Sorry if it actually did go through. Hopefully I didn't misfire
anything else yesterday...)

Adam Ford wrote on Wed, Sep 04, 2024 at 06:30:32PM -0500:
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
> the cloesest rate.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

b4 (or whatever you're using) probably picked that up from the patch I
included in my reply to this patch, this sob should go away.



> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> index 4b13e386e5ba..9a21dbbf1a82 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -547,6 +547,16 @@ static unsigned long phy_clk_recalc_rate(struct clk_hw *hw,
>  	return phy->cur_cfg->pixclk;
>  }
>  
> +static u32 fsl_samsung_hdmi_phy_get_closest_rate(unsigned long rate,
> +						 u32 int_div_clk, u32 frac_div_clk)
> +{
> +	/* The int_div_clk may be greater than rate, so cast it and use ABS */
> +	if (abs((long)rate - (long)int_div_clk) < (rate - frac_div_clk))

I still think `rate - frac_div_clk` might not always hold in the future
(because there is no intrinsic reason we'd pick the smaller end in case
of inexact match and a future improvement might change this to the
closest value as well), so I'll argue again for having both use abs(),
but at least there's only one place to update if that changes in the
future now so hopefully whoever does this will notice...

> +		return int_div_clk;
> +
> +	return frac_div_clk;
> +}
> +
>  static long phy_clk_round_rate(struct clk_hw *hw,
>  			       unsigned long rate, unsigned long *parent_rate)
>  {
> @@ -563,6 +573,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>  	for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
>  		if (phy_pll_cfg[i].pixclk <= rate)
>  			break;
> +

(unrelated)

>  	/* If the rate is an exact match, return it now */
>  	if (rate == phy_pll_cfg[i].pixclk)
>  		return phy_pll_cfg[i].pixclk;
> @@ -579,8 +590,7 @@ static long phy_clk_round_rate(struct clk_hw *hw,
>  	if (int_div_clk == rate)
>  		return int_div_clk;
>  
> -	/* Fall back to the closest value in the LUT */
> -	return phy_pll_cfg[i].pixclk;
> +	return fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk, phy_pll_cfg[i].pixclk);
>  }
>  
>  static int phy_clk_set_rate(struct clk_hw *hw,
> @@ -594,27 +604,37 @@ static int phy_clk_set_rate(struct clk_hw *hw,
>  
>  	/* If the integer divider works, just use it */

I found this comment a bit confusing given the current flow as of this
patch. Might make more sense immediately before the if?


>  	int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate * 5, &p, &m, &s) / 5;
> +	calculated_phy_pll_cfg.pixclk = int_div_clk;
> +	calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
> +	calculated_phy_pll_cfg.pll_div_regs[1] = m;
> +	calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
> +	phy->cur_cfg = &calculated_phy_pll_cfg;
>  	if (int_div_clk == rate) {
>  		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
> -		calculated_phy_pll_cfg.pixclk = int_div_clk;
> -		calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
> -		calculated_phy_pll_cfg.pll_div_regs[1] = m;
> -		calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
> -		/* pll_div_regs 3-6 are fixed and pre-defined already */

nitpick: might want to keep the above comment?

> -		phy->cur_cfg  = &calculated_phy_pll_cfg;
> +		goto done;
>  	} else {
>  		/* Otherwise, search the LUT */
> -		dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
> -		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--)
> -			if (phy_pll_cfg[i].pixclk <= rate)
> +		for (i = ARRAY_SIZE(phy_pll_cfg) - 1; i >= 0; i--) {
> +			if (phy_pll_cfg[i].pixclk == rate) {
> +				dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");

nitpick: might make sense to print what was picked in case of inexact
match as well, but these are dbg warning so probably fine either way.


overall I find the flow of this function hard to read; it's a bit ugly
flow-wise but jumping in the clock comparison 'if' might help trim this?
(and if we're going out of our way to factor out the diff, maybe the lut
lookup could be as well)

But I'm probably just being overcritical here, it's fine as is if you
pefer your version, just writing down this as an illustration of what I
meant with the above sentence as I'm not sure I was clear -- I'll be
just as happy to consider this series done so we can do more interesting
things :P

{
    u32 int_div_clk, frac_div_clk;
    int i;
    u16 m;
    u8 p, s;
    
    // (I haven't given up on that *5 to move inside this function...)
    int_div_clk = fsl_samsung_hdmi_phy_find_pms(rate, &p, &m, &s);
    if (int_div_clk == rate)
        goto use_int_clk;

    frac_div_clk = fsl_samsung_hdmi_phy_find_lut(rate, &i);
    // (not convinced that check actually brings much, but it's not like
    // it hurts either)
    if (frac_div_clk == rate)
        goto use_frac_clk;
    
    if (fsl_samsung_hdmi_phy_get_closest_rate(rate, int_div_clk,
                                              frac_div_clk) == int_div_clk) {
use_int_clk:
        dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using integer divider\n");
        calculated_phy_pll_cfg.pixclk = int_div_clk;
        calculated_phy_pll_cfg.pll_div_regs[0] = FIELD_PREP(REG01_PMS_P_MASK, p);
        calculated_phy_pll_cfg.pll_div_regs[1] = m;
        calculated_phy_pll_cfg.pll_div_regs[2] = FIELD_PREP(REG03_PMS_S_MASK, s-1);
        /* pll_div_regs 3-6 are fixed and pre-defined already */
        phy->cur_cfg  = &calculated_phy_pll_cfg;
    } else {
use_frac_clk:
        dev_dbg(phy->dev, "fsl_samsung_hdmi_phy: using fractional divider\n");
        phy->cur_cfg = &phy_pll_cfg[i];
    }
    return fsl_samsung_hdmi_phy_configure(phy, phy->cur_cfg);
}

-- 
Dominique

