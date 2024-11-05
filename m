Return-Path: <linux-kernel+bounces-396241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292989BC9D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B93B20F00
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AE31CF5C7;
	Tue,  5 Nov 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGePmVM2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047B81CDA3B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800855; cv=none; b=BAehx6549BUKDMcURgJy6ijJ0F10lTucyvI4LCfrn/ihW2tZN0uagcxWm+wp+uQSkx0xN/SLpvgYmrNXUHBrtNv/H+clm4zB8esiyIRK2NliWHCDP6uT7Zyfw+1ArOurnclNAel89ZdaTyQ++X1KPCzFr6ihxoHlzeP3T+c1uQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800855; c=relaxed/simple;
	bh=G51jhzQqKY+D8hwS2m/4yusGKIpJiOixdKXy7qb5+3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omLAob5OdVmA8mWAOZUnrF0H9xJPB6IIZuMcnl7wQf7Hi2qEqZ+C/ho2KziOasbM0Stv6/SgLcGr7dwXwCOJkCgJpHkjn7wcFK2WOE+2ADuXNkM/5+f0K2Rh13jlzyOGQD6vUmw2jt70s3y3bUcckCHiTdxxDnlwqW98FDZJ6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGePmVM2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431695fa98bso41415465e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730800852; x=1731405652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqjjzu00wo0rLZzR44vy7Mc+li1wHJBT4o2yabL2Nbg=;
        b=jGePmVM2e84dkSbXxcmOBAYW74kcJv05H4xJ0onu4KtIDntVGw4FQoV8GdPCm9kn/g
         QTTwRKQOxfl115hBL7M7+vRgZSpfcIXtpeCijBMg/yu6YaKOJv0xDAfUCbcG5R1w7ZIx
         YEgeQfb8Kdbuuq2RmmRcPIIfDx2lndcCndhF7EciAv+KZ9qeqipR6syOe1buGqIOpw4U
         6j0j1M77aCtJcz4pPXGxnM6pxxP2Y5i+YiqZFsNfvWv+xHkGoEKwyp5GhSvJjLVF3dkH
         SAa1vIlYqpzvx6ZDjAMFRek3WoqVkU0blic5iuJfclTNBPiJu3UCZCqONZCuxrNRJlrc
         3/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800852; x=1731405652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqjjzu00wo0rLZzR44vy7Mc+li1wHJBT4o2yabL2Nbg=;
        b=tlF1sgSBZZOIS3R7QUseay3U6s7hnAHgH2rBZH5Qwyogdx0F6fMohpJ43ZXrVtPoaN
         QSCMHyoDobGbm4ug50RgGjxjlWK5qEQuZohsWrOjtWOkrp+nsvLec3jZe0art4joLwaE
         aDN+27rJV5nP0LAnKN3hUN/AxTx5h4OYuqy/Qk+DvQrWHDMgg/c9gSUPlDHc2k0Nsr8Q
         NqHQ1ukYtyZNCRNaJ0S+seG5y9mW0nrtexalKh+t4TzC+8aXwZWHRQcH+MhX5GO3Pi2F
         utDqLPnfi6GJ560DM/rA0IrG1AZALCFY2tPd+ipcnVMeUMftqJqEpMXC9HIi1RlUih8i
         Bisg==
X-Forwarded-Encrypted: i=1; AJvYcCUVPBCwG4wac/jsDsW/Lb0Xp1+7rU1hiedlnSRuiNKzbQhkusJ2bW9EWlE5MpjZc8H/KDzhe60UEtax6bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIxTk2re/fblfKtth/r8o8xn/hGy828uPXeVCfTwD+DNir9T63
	3EpyAvGK5ddtn6Ph04Muk3q/0Hq9jx1wIH56ot2upSAYL64cPm0fUhaz5xXXt9s=
X-Google-Smtp-Source: AGHT+IFm4Qb4M3oCZgWdKRIgQrNjub2F52DYcxA3WJCF5Ri03R0Wl6j6IdT3Hz00MkG2UHWSG6u6kw==
X-Received: by 2002:a05:600c:458f:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-4319ad047a7mr311045735e9.24.1730800852400;
        Tue, 05 Nov 2024 02:00:52 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf4e7sm181024905e9.15.2024.11.05.02.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 02:00:51 -0800 (PST)
Date: Tue, 5 Nov 2024 12:00:50 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH v3 3/5] clk: imx: fracn-gppll: fix pll power up
Message-ID: <Zyns0qfYpO3mZ4fa@linaro.org>
References: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
 <20241027-imx-clk-v1-v3-3-89152574d1d7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027-imx-clk-v1-v3-3-89152574d1d7@nxp.com>

On 24-10-27 20:00:09, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> To i.MX93 which features dual Cortex-A55 cores and DSU, when using
> writel_relaxed to write value to PLL registers, the value might be
> buffered. To make sure the value has been written into the hardware,
> using readl to read back the register could achieve the goal.
> 
> current PLL power up flow can be simplified as below:
>   1. writel_relaxed to set the PLL POWERUP bit;
>   2. readl_poll_timeout to check the PLL lock bit:
>      a). timeout = ktime_add_us(ktime_get(), timeout_us);
>      b). readl the pll the lock reg;
>      c). check if the pll lock bit ready
>      d). check if timeout
> 
> But in some corner cases, both the write in step 1 and read in
> step 2 will be blocked by other bus transaction in the SoC for a
> long time, saying the value into real hardware is just before step b).
> That means the timeout counting has begins for quite sometime since
> step a), but value still not written into real hardware until bus
> released just at a point before step b).
> 
> Then there maybe chances that the pll lock bit is not ready
> when readl done but the timeout happens. readl_poll_timeout will
> err return due to timeout. To avoid such unexpected failure,
> read back the reg to make sure the write has been done in HW
> reg.
> 
> So use readl after writel_relaxed to fix the issue.
> 
> Since we are here, to avoid udelay to run before writel_relaxed, use
> readl before udelay.
> 
> Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
> Co-developed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-fracn-gppll.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
> index 4749c3e0b7051cf53876664808aa28742f6861f7..85771afd4698ae6a0d8a7e82193301e187049255 100644
> --- a/drivers/clk/imx/clk-fracn-gppll.c
> +++ b/drivers/clk/imx/clk-fracn-gppll.c
> @@ -254,9 +254,11 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
>  	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
>  		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
>  	writel_relaxed(pll_div, pll->base + PLL_DIV);
> +	readl(pll->base + PLL_DIV);
>  	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
>  		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
>  		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
> +		readl(pll->base + PLL_NUMERATOR);
>  	}
>  
>  	/* Wait for 5us according to fracn mode pll doc */
> @@ -265,6 +267,7 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
>  	/* Enable Powerup */
>  	tmp |= POWERUP_MASK;
>  	writel_relaxed(tmp, pll->base + PLL_CTRL);
> +	readl(pll->base + PLL_CTRL);
>  
>  	/* Wait Lock */
>  	ret = clk_fracn_gppll_wait_lock(pll);
> @@ -302,6 +305,7 @@ static int clk_fracn_gppll_prepare(struct clk_hw *hw)
>  
>  	val |= POWERUP_MASK;
>  	writel_relaxed(val, pll->base + PLL_CTRL);
> +	readl(pll->base + PLL_CTRL);
>  
>  	ret = clk_fracn_gppll_wait_lock(pll);
>  	if (ret)
> 
> -- 
> 2.37.1
> 

