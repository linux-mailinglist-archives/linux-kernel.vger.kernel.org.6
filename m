Return-Path: <linux-kernel+bounces-396238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE89BC9CE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06288B21A03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6E1D1F54;
	Tue,  5 Nov 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQrRJVYW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD01D1745
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800741; cv=none; b=gAdAUqR354PYvf5YWgz9VNbCgPGlcgPfjBCMUEu9TORwax5m91U+ljyT2qp0A7n84TMAkyyUOPH9vYmCkQgPA0ehCG0u1IXlnNEa/C6KjkBVi4+mL9OzIRpz4wxLRXYM6CHbOc8W/kPGZGBR9DKGXEr8wBdMVvYJbuuY5zPrkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800741; c=relaxed/simple;
	bh=ukceNXo2pywTrMUB3iOKRDJfjIGMJ5DmLc6fZKJlndI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkYqzK2H53qAcnnQxS6aFcztSi8IKROMp/mbOwn8f/sZoRy/u6iXn80acZvxrVPTIEirGKmRXrfs+ezaO5t+oa5i9HDvci6TfT831U+CBZw8eUrZDRYFVKFnK+ZhdytAjHlQ3v3MWnWXzmbkkvhsPGgNAyY1Pr/w2tBok9Pyr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YQrRJVYW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso44765355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730800736; x=1731405536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6h/R7lfM4qCrCDmado2Rkx+M46kJFIDRE2I4JWaZEQ=;
        b=YQrRJVYWhQoHScNLIRWLWoz/Ed/beZkMV/R6MSPdywT5b8+2G3lDIlXl90ZBGy4r0T
         Vh+4dri15ZqXri1x7sk2+ZJO6JfnC7UmIc5KR9x8H7kozgxXvo9sZoraYCO47ST/pevd
         xfudI6sjOKEjnAtATLR2wJh66Q2EiaVGpDEagrhVTi8TEmBAw/DH+OK8/qxHljyUxfxF
         8cmVMsd3PKnBKKY2QAkARj/nmNXqEal8LAUCIZQ9R5I3V4nNMiyyXP7b8tYCj5fruSBZ
         I//jzlG8gGifUkjse/BO0gvAt3NVc7SnpvhylzeJ0yInFpeD8BGvzaLhd4xCvjJrMFbH
         Xqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800736; x=1731405536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6h/R7lfM4qCrCDmado2Rkx+M46kJFIDRE2I4JWaZEQ=;
        b=o5WX1t28v7OZr6C9g7zakT9gTPnoqKr6LcaJqMvB0+7akIn/dax/ga1dPFiU/mAyS/
         ns4iM2cWTk8+lkBAEFo02zEXEiktLdCOCCbdkIiUu0n0Si2hiSv5wGH5mR4hoT+aE3D7
         HVD3VflZ/ocIQBrLbzuHD15/oVzdUyfEJMS+EiS75Ulad9EGEo35v4M5tmtOkU+b8sHR
         4I2L4r4hJlsVoPyA7mh/D0nnz8DHwhKrxDqe16h+cRauyEm9JSghJwfj5x0XdE5Xom1b
         jsjFj++uQPAiDQOYp719apFnpftyJ7wttxCSS8ZxBUda+141LycEr53Vbn79Mimfgo/c
         LBog==
X-Forwarded-Encrypted: i=1; AJvYcCUE95ifaKxQ6rA4Of/0NyuC3Lp5a9S4UDSNGVnK8HL5QPF0hRWT7RnUxdBo99P+X4CGoseLoH0+ZjKOMmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZNeOcdiywONsZ0Lrkno7Ros5ICOIYmySUkiLBDQ66XK0iop0a
	+iwwXqrinhTi2ugSQt9+iYCrQf0PVY8n8HP43rwTCY6gJN9WDqp3D/ahPq04X9Q=
X-Google-Smtp-Source: AGHT+IENI/tO1m+wxDQs0DVE4GgW4Nt88abEszTQqX11x4d9wmMLAMDwYiShM/iz+S/e697/IpvpqA==
X-Received: by 2002:a05:600c:3112:b0:431:5d4c:5eff with SMTP id 5b1f17b1804b1-4327b6f46bdmr163702085e9.2.1730800736173;
        Tue, 05 Nov 2024 01:58:56 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d1fsm15533035f8f.38.2024.11.05.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:58:55 -0800 (PST)
Date: Tue, 5 Nov 2024 11:58:54 +0200
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
Subject: Re: [PATCH v3 1/5] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Message-ID: <ZynsXhzcoyfCzLwq@linaro.org>
References: <20241027-imx-clk-v1-v3-0-89152574d1d7@nxp.com>
 <20241027-imx-clk-v1-v3-1-89152574d1d7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027-imx-clk-v1-v3-1-89152574d1d7@nxp.com>

On 24-10-27 20:00:07, Peng Fan (OSS) wrote:
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

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-lpcg-scu.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
> index dd5abd09f3e206a5073767561b517d5b3320b28c..620afdf8dc03e9564bb074ca879cf778f7fc6419 100644
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
> @@ -41,6 +43,29 @@ struct clk_lpcg_scu {
>  
>  #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
>  
> +/* e10858 -LPCG clock gating register synchronization errata */
> +static void lpcg_e10858_writel(unsigned long rate, void __iomem *reg, u32 val)
> +{
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
> +		readl(reg);
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
> @@ -57,7 +82,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
>  		val |= CLK_GATE_SCU_LPCG_HW_SEL;
>  
>  	reg |= val << clk->bit_idx;
> -	writel(reg, clk->reg);
> +
> +	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  
> @@ -74,7 +100,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
>  
>  	reg = readl_relaxed(clk->reg);
>  	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
> -	writel(reg, clk->reg);
> +	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
>  
>  	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
>  }
> @@ -145,13 +171,8 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
>  {
>  	struct clk_lpcg_scu *clk = dev_get_drvdata(dev);
>  
> -	/*
> -	 * FIXME: Sometimes writes don't work unless the CPU issues
> -	 * them twice
> -	 */
> -
> -	writel(clk->state, clk->reg);
>  	writel(clk->state, clk->reg);
> +	lpcg_e10858_writel(0, clk->reg, clk->state);
>  	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
>  
>  	return 0;
> 
> -- 
> 2.37.1
> 

