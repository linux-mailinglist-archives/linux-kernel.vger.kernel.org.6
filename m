Return-Path: <linux-kernel+bounces-177210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C48C3B78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C9E1F21266
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B724145B19;
	Mon, 13 May 2024 06:39:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C618468
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582394; cv=none; b=e83xGCtAJwlKlhEUMsd4YI2PZpwsgs+SgRCzPpaD+CPOMItFPeHuuvuc0/G1icPldwN28OQdav1fw/5/n0CmTY+8zcPlvr3JJID2ISjIaTyvz91E5dN5dEC6qWWUeYbFjxJZChHTPuU+D2Xeb7djsok1jklUYoTclK3SglLICEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582394; c=relaxed/simple;
	bh=qWUVcFOckM2mzHpQ2EXaxk0W1FsPXBRLNnFXKDxYnZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDsgRADpdSKOheApxRJIyS/iPn/K/35R8Z+Ui5yr5x6LN0aQQKW83xZmaMed704MKNRcM0BDqyGL0OembdGGOdytHCyYn7b9c6lXk0AjevpoEFMlexb+O77oGPYstaaknM7n17Lmj03INMedZTblFqsQqiN9gfPPFaTfZVM3ab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s6PLT-0004Yo-2g; Mon, 13 May 2024 08:39:35 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s6PLS-0017Sf-4l; Mon, 13 May 2024 08:39:34 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s6PLS-009O2c-07;
	Mon, 13 May 2024 08:39:34 +0200
Date: Mon, 13 May 2024 08:39:34 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
	Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 01/17] clk: imx: composite-8m: Enable gate clk with
 mcore_booted
Message-ID: <ZkG1put2k33K4c_b@pengutronix.de>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-1-c998f315d29c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510-imx-clk-v2-1-c998f315d29c@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, May 10, 2024 at 05:18:56PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Bootloader might disable some CCM ROOT Slices. So if mcore_booted set with
> display CCM ROOT disabled by Bootloader, kernel display BLK CTRL driver
> imx8m_blk_ctrl_driver_init may hang the system because the BUS clk is
> disabled.
> 
> Add back gate ops, but with disable doing nothing, then the CCM ROOT
> will be enabled when used.
> 
> Fixes: 489bbee0c983 ("clk: imx: composite-8m: Enable gate clk with mcore_booted")

I can't find this commitish anywhere, also the subject looks like this
patch fixes itself.

> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-composite-8m.c | 53 ++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
> index 8cc07d056a83..f187582ba491 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -204,6 +204,34 @@ static const struct clk_ops imx8m_clk_composite_mux_ops = {
>  	.determine_rate = imx8m_clk_composite_mux_determine_rate,
>  };
>  
> +static int imx8m_clk_composite_gate_enable(struct clk_hw *hw)
> +{
> +	struct clk_gate *gate = to_clk_gate(hw);
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(gate->lock, flags);
> +
> +	val = readl(gate->reg);
> +	val |= BIT(gate->bit_idx);
> +	writel(val, gate->reg);
> +
> +	spin_unlock_irqrestore(gate->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void imx8m_clk_composite_gate_disable(struct clk_hw *hw)
> +{
> +	/* composite clk requires the disable hook */
> +}
> +
> +static const struct clk_ops imx8m_clk_composite_gate_ops = {
> +	.enable = imx8m_clk_composite_gate_enable,
> +	.disable = imx8m_clk_composite_gate_disable,
> +	.is_enabled = clk_gate_is_enabled,
> +};
> +
>  struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  					const char * const *parent_names,
>  					int num_parents, void __iomem *reg,
> @@ -217,6 +245,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  	struct clk_mux *mux;
>  	const struct clk_ops *divider_ops;
>  	const struct clk_ops *mux_ops;
> +	const struct clk_ops *gate_ops;
>  
>  	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>  	if (!mux)
> @@ -257,20 +286,22 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>  	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
>  
>  	/* skip registering the gate ops if M4 is enabled */

This comment doesn't seems to become inaccurate with this patch.

> -	if (!mcore_booted) {
> -		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> -		if (!gate)
> -			goto free_div;
> -
> -		gate_hw = &gate->hw;
> -		gate->reg = reg;
> -		gate->bit_idx = PCG_CGC_SHIFT;
> -		gate->lock = &imx_ccm_lock;
> -	}
> +	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		goto free_div;
> +
> +	gate_hw = &gate->hw;
> +	gate->reg = reg;
> +	gate->bit_idx = PCG_CGC_SHIFT;
> +	gate->lock = &imx_ccm_lock;
> +	if (!mcore_booted)
> +		gate_ops = &clk_gate_ops;
> +	else
> +		gate_ops = &imx8m_clk_composite_gate_ops;

Please use positive logic. It's easier to read.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

