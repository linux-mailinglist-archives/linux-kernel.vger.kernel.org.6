Return-Path: <linux-kernel+bounces-376398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF0F9AB0D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BAC1C21F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78D1A0AE1;
	Tue, 22 Oct 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDVxpWH9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271219EED0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607363; cv=none; b=tvTvmSEgcRe32Yw9yhwhiFYucIoehDdiw4Uu08wN1QtfUh4SMSY3ukI4JlYj2axKVDIuLdp4dms5VZOn3QB50WxaP1ilRYwViYDanW8td9e4oB6px0SvfkzD8G3V8agiY0XDLau5pJ1Jf79rjNuInGosgxQIQHR5vW2LPsYcOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607363; c=relaxed/simple;
	bh=U1vel9b4kuugM7u5sQxQV4OKtSAB7wEvpIwskiiHw/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6bPZkYh7MAkzh9h9KASK2YV9clkR2Ssu04xTK5RaCvS9qfvnY5L8TF2EhloETtY6D6agmrEWq215/bvIMrdwLrlIgChe7S7JuYEPE9KBVHdiK6LX79VK5bY1GGihc2zlpOWcQPr7ae1UwtB0eHiOivI39TNDBKF4cEOr25b/qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wDVxpWH9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso56608805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607360; x=1730212160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DkutHKlfF595sYSPoVn9FoUtRcuWewPbATznGxjSDTo=;
        b=wDVxpWH9oHF1ntsrQcReiHGhxryqrMkEeHwM4yosGoVPKOx/7HM1mcUm5ptWreEGiz
         MkN6UNb0LDEJ+ePS5MU2+qvfqSyZ20M+xMKkyRCbEDJfXer5BRMjfVSctHvBS9aOMdgL
         PuR1i4XYZWGPe48ZcNvADpjK+lmqWjk2+SpaNDnGXbSYKYc6p5W1yVyNymeNQ4inhlwV
         x2Hfx1bc7pjoWDRzr+XllZOVhKkYei0TQIzzE1w3yHbFy8n8yEl8mwCYdV9V8KAwz3is
         rjAiiYz6y0+EA886ZVAhJF50nYzgeQXxWXsXsBm+9Xgoqgd215elugRuqd7wEyDqBedk
         lRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607360; x=1730212160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkutHKlfF595sYSPoVn9FoUtRcuWewPbATznGxjSDTo=;
        b=o0y+2lxRSqCoBl28kOv9CEvv7YIRmXeBYgodbaHlKu3NpU0Ju1v7Nh/oH25trPQi4I
         5p8yUb+XObNthLseRqZczjWgAwbA1XgdkP0XtilLJ2oLJWnPPPYCFENftHXVJ7UL3mT/
         5a6GJZAq0aFwID8+VsA5QZRGsyvmUgARPygzLiQkiXlDwxFp+L8a9tcxWe0F51BsRgZG
         U7DZocODbpklaluCYBqYKA2/yxjdS1B/LbfK4F6wUV01GaH21/l/a3658REFeepqas17
         KDT/vu2kcvmn9885fRKLHUiWuZdvwFpWAK8O6yekZZ8hZ1iPQKMwgZxuLd/ru/szf7Vu
         OV1w==
X-Forwarded-Encrypted: i=1; AJvYcCW257TA46WS4AEw/QHHY+5nZ/r6KOqbwuQn15f8dSeZkvcRwmHqhRz6AYXI0hhn6lP/XPNNjzVFCTzmGLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs2818R4Lrq6B0lH9lrFzaZ4qfuq6wI6UMHL/6vwThPfjYpz/m
	AhHFf+SnF/+RvJX4DqpfMiz5ALWP0jYZqP8o+//VgRT57bYkIQb8ow+KArGXZUQ=
X-Google-Smtp-Source: AGHT+IHYxdT55nb92Bpp1rmrk81yk5eULeipYCC5+xOcm0icNZ2mIb7EGDVsgFsrblrkQv2bAtiBLA==
X-Received: by 2002:a05:600c:4ed4:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-43161669e34mr123005205e9.21.1729607360299;
        Tue, 22 Oct 2024 07:29:20 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c300csm90227375e9.30.2024.10.22.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:29:19 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:29:18 +0300
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
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Message-ID: <Zxe2vtwKP0hFrPKV@linaro.org>
References: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
 <20241018-imx-clk-v1-v2-1-92c0b66ca970@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-imx-clk-v1-v2-1-92c0b66ca970@nxp.com>

On 24-10-18 18:00:55, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Back-to-back LPCG writes can be ignored by the LPCG register due to
> a HW bug. The writes need to be separated by at least 4 cycles of
> the gated clock. See https://www.nxp.com.cn/docs/en/errata/IMX8_1N94W.pdf
> 
> The workaround is implemented as follows:
> 1. For clocks running greater than or equal to 24MHz, a read
> followed by the write will provide sufficient delay.
> 2. For clocks running below 24MHz, add a delay of 4 clock cylces
> after the write to the LPCG register.
> 
> Fixes: 2f77296d3df9 ("clk: imx: add lpcg clock support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-lpcg-scu.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> index dd5abd09f3e206a5073767561b517d5b3320b28c..cd42190233662c66f2c354f0a2eee3a2531eeb3a 100644
> --- a/drivers/clk/imx/clk-lpcg-scu.c
> +++ b/drivers/clk/imx/clk-lpcg-scu.c
> @@ -6,10 +6,12 @@
>  
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/units.h>
>  
>  #include "clk-scu.h"
>  
> @@ -41,6 +43,31 @@ struct clk_lpcg_scu {
>  
>  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
>  
> +/* e10858 -LPCG clock gating register synchronization errata */
> +static void lpcg_e10858_writel(unsigned long rate, void __iomem *reg, u32 val)
> +{
> +	u32 reg1;
> +
> +	writel(val, reg);
> +
> +	if (rate >= 24 * HZ_PER_MHZ || rate == 0) {
> +		/*
> +		 * The time taken to access the LPCG registers from the AP core
> +		 * through the interconnect is longer than the minimum delay
> +		 * of 4 clock cycles required by the errata.
> +		 * Adding a readl will provide sufficient delay to prevent
> +		 * back-to-back writes.
> +		 */
> +		reg1 = readl(reg);
> +	} else {
> +		/*
> +		 * For clocks running below 24MHz, wait a minimum of
> +		 * 4 clock cycles.
> +		 */
> +		ndelay(4 * (DIV_ROUND_UP(1000 * HZ_PER_MHZ, rate)));
> +	}
> +}
> +
>  static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  {
>  	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
> @@ -57,7 +84,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  		val |= CLK_GATE_SCU_LPCG_HW_SEL;
>  
>  	reg |= val << clk->bit_idx;
> -	writel(reg, clk->reg);
> +
> +	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  
> @@ -74,7 +102,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
>  
>  	reg = readl_relaxed(clk->reg);
>  	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> -	writel(reg, clk->reg);
> +	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  }
> @@ -149,9 +177,8 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
>  	 * FIXME: Sometimes writes don't work unless the CPU issues
>  	 * them twice
>  	 */
> -
> -	writel(clk->state, clk->reg);

Now that you removed one of the writes, doesn't the comment above has to
be removed as well ?

>  	writel(clk->state, clk->reg);
> +	lpcg_e10858_writel(0, clk->reg, clk->state);
>  	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
>  
>  	return 0;
> 
> -- 
> 2.37.1
> 

