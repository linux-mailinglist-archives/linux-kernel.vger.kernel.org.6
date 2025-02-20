Return-Path: <linux-kernel+bounces-523431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE67A3D6B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E321797F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F391F0E31;
	Thu, 20 Feb 2025 10:27:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A51F151C;
	Thu, 20 Feb 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047253; cv=none; b=afXUTkUPKb1hdlx0ENut/3kXsHrqVUCaLzAJBdxnu1ujZ9cmB9xoNKb2mpsucsXL6EXUR7uNxxizeGm74Pui647I6gdux7lkKI9ba4OMaW/bhQBmWlvViq65Ap8GqaSUsBYn8VADjQ2Radkevf0PJTAZaeIOb4SGxmc2TlQXn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047253; c=relaxed/simple;
	bh=bcwa917uSCDvAy+84TrBG0xWxaCDnkNMyh9OPj9kqng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYriYf6qUhKty6k3uW+ZpFOEj9UI7Mvy8UncFeLr6m7c86Q4DwsmwEdv/4rj5tygPo85sfmJrqSzJNWpp9I2mulaEqogVC3rO7jkZbEr8KhGkM9q839EYAw+m6+VriH8Dgwe/bxraL/ns2tIhjsXIxjyQ+XkjY+Er4OQ57ujd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F741BB0;
	Thu, 20 Feb 2025 02:27:48 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5183F59E;
	Thu, 20 Feb 2025 02:27:29 -0800 (PST)
Date: Thu, 20 Feb 2025 10:25:15 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi
 SoC support), linux-sunxi@lists.linux.dev (open list:ARM/Allwinner sunXi
 SoC support), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] clk: sunxi-ng: h616: Reparent GPU clock during
 frequency changes
Message-ID: <20250220102515.05991e9d@minigeek.lan>
In-Reply-To: <20250212173640.396404-1-simons.philippe@gmail.com>
References: <20250212173640.396404-1-simons.philippe@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:36:39 +0100
Philippe Simons <simons.philippe@gmail.com> wrote:

Hi,

> The H616 manual does not state that the GPU PLL supports
> dynamic frequency configuration, so we must take extra care when changing
> the frequency. Currently any attempt to do device DVFS on the GPU lead
> to panfrost various ooops, and GPU hangs.
> 
> The manual describes the algorithm for changing the PLL
> frequency, which the CPU PLL notifier code already support, so we reuse
> that to reparent the GPU clock to GPU1 clock during frequency
> changes.
> 
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 38 ++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> index 190816c35..884f9a6b5 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> @@ -328,10 +328,16 @@ static SUNXI_CCU_M_WITH_MUX_GATE(gpu0_clk, "gpu0", gpu0_parents, 0x670,
>  				       24, 1,	/* mux */
>  				       BIT(31),	/* gate */
>  				       CLK_SET_RATE_PARENT);
> -static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,
> +
> +/*
> + * This clk is needed as a temporary fall back during GPU PLL freq changes.
> + * Set CLK_IS_CRITICAL flag to prevent from being disabled.
> + */
> + #define SUN50I_H616_GPU_CLK1_REG        0x674
> + static SUNXI_CCU_M_WITH_GATE(gpu1_clk, "gpu1", "pll-periph0-2x", 0x674,

There seems to be a stray space there at the beginning of those two
lines.

>  					0, 2,	/* M */
>  					BIT(31),/* gate */
> -					0);
> +					CLK_IS_CRITICAL);
>  
>  static SUNXI_CCU_GATE(bus_gpu_clk, "bus-gpu", "psi-ahb1-ahb2",
>  		      0x67c, BIT(0), 0);
> @@ -1120,6 +1126,19 @@ static struct ccu_pll_nb sun50i_h616_pll_cpu_nb = {
>  	.lock		= BIT(28),
>  };
>  
> +static struct ccu_mux_nb sun50i_h616_gpu_nb = {
> +	.common			= &gpu0_clk.common,
> +	.cm				= &gpu0_clk.mux,
> +	.delay_us		= 1, /* manual doesn't really say */

Indentation is off here. Please align to the last line here below.

> +	.bypass_index	= 1, /* GPU_CLK1@400MHz */
> +};
> +
> +static struct ccu_pll_nb sun50i_h616_pll_gpu_nb = {
> +	.common		= &pll_gpu_clk.common,
> +	.enable		= BIT(29),	/* LOCK_ENABLE */
> +	.lock		= BIT(28),
> +};
> +
>  static int sun50i_h616_ccu_probe(struct platform_device *pdev)
>  {
>  	void __iomem *reg;
> @@ -1170,6 +1189,14 @@ static int sun50i_h616_ccu_probe(struct platform_device *pdev)
>  	val |= BIT(0);
>  	writel(val, reg + SUN50I_H616_PLL_AUDIO_REG);
>  
> +	/*
> +	 * Set the input-divider for the gpu1 clock to 3.

Can you extend the comment, like:
 ... clock to 3, to reach a safe 400 MHz.

> +	 */
> +	val = readl(reg + SUN50I_H616_GPU_CLK1_REG);
> +	val &= ~GENMASK(1, 0);
> +	val |= BIT(1);

Can you replace the BIT(1) with a "2" here? At the moment it looks like
it's a single flag to be set, whereas we really just want to write the
value 2 (3 - 1) into that field.

The rest looks alright, so with those smaller things fixed:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> +	writel(val, reg + SUN50I_H616_GPU_CLK1_REG);
> +
>  	/*
>  	 * First clock parent (osc32K) is unusable for CEC. But since there
>  	 * is no good way to force parent switch (both run with same frequency),
> @@ -1190,6 +1217,13 @@ static int sun50i_h616_ccu_probe(struct platform_device *pdev)
>  	/* Re-lock the CPU PLL after any rate changes */
>  	ccu_pll_notifier_register(&sun50i_h616_pll_cpu_nb);
>  
> +	/* Reparent GPU during GPU PLL rate changes */
> +	ccu_mux_notifier_register(pll_gpu_clk.common.hw.clk,
> +				  &sun50i_h616_gpu_nb);
> +
> +	/* Re-lock the GPU PLL after any rate changes */
> +	ccu_pll_notifier_register(&sun50i_h616_pll_gpu_nb);
> +
>  	return 0;
>  }
>  


