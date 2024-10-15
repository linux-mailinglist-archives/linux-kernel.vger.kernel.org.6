Return-Path: <linux-kernel+bounces-365136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61299DE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC8F28187C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AA318991B;
	Tue, 15 Oct 2024 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zQQGTXgI"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225A175562;
	Tue, 15 Oct 2024 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728972959; cv=none; b=cXk3xyrxar+IfBvBFAJuGHgFoo/6Q74QmMfR3jxt0vIeo96xNwdf8sCMncspSwNCvcZ2lpKsuJOasMMdXZyq8XiMmqLef1n04urf+dVcWHNAJFgB1mL99fcoVmcnbHqUnTv/93EmlacKWibn84+xACzhRGGUI1lzmjKUvW4oOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728972959; c=relaxed/simple;
	bh=ooVp+xiwzPx5CdJBmrDqJgfDxs/V4f3wFEWAJYkABko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLyFaOPkZsnor6ExzC+oPny+/M3hUHqaMGQnpeqSkFCyfFkgyFWXM4O7Jd477ubCMgPBA8W96HGyEWadamZYZrZaQxX3tCaFpmQ1D646IBcQMIoyC6o/KZo7Ao4m934dKT0+t5+09fwxiasEE7hyYWvMhQkbwMx/at9s3F48Mtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zQQGTXgI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EL6LxVKAABxO1KNYnS0+bzWx4sk+zoR4NNlkZV/B+Gw=; b=zQQGTXgIBJ61KEJTDmi9YhW+mi
	I6VVOJZDZXk2JbBM283fyxK35/AOuuF3nOzh4HGd7f0cn5L9Av60GXpwpow04Y7+OZQRXrYN+U+TI
	XwXILtWsMre1e3wfI1TukYQxKbLl5li5c6n3R3TQy+2No7O2od1CVNyQUFiA8eX/vL6UmVK17aYt1
	w7b3xLRJz7phFlknZp5aj4kwiYYnWXJoyDFsC+oTckoFQACCF50EPo491m1kpx3BXE+0QQegGVzOi
	JzgbZ2MFGJTx2K6oQBegJbr9u8kPTR9Yjihjyna2URbxu0WKnhmpU4mUL2a4q5PF/sRVim9dBdD2h
	W921Ahvg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t0aqY-000713-Hd; Tue, 15 Oct 2024 08:15:54 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Frank Wang <frawang.cn@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, Kever Yang <kever.yang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 2/2] phy: rockchip-naneng-combo: Support rk3576
Date: Tue, 15 Oct 2024 08:15:53 +0200
Message-ID: <1981070.PYKUYFuaPT@diego>
In-Reply-To: <20241015013351.4884-2-frawang.cn@gmail.com>
References:
 <20241015013351.4884-1-frawang.cn@gmail.com>
 <20241015013351.4884-2-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Frank,

Am Dienstag, 15. Oktober 2024, 03:33:51 CEST schrieb Frank Wang:
> From: Kever Yang <kever.yang@rock-chips.com>
> 
> phy0: pcie, sata
> phy1: pcie, sata, usb3
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 0a9989e41237..4c41317a8041 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -584,6 +585,203 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>  	.combphy_cfg	= rk3568_combphy_cfg,
>  };
>  
> +static int rk3576_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	unsigned long rate;
> +
> +	switch (priv->type) {
> +	case PHY_TYPE_PCIE:
> +		/* Set SSC downward spread spectrum */
> +		rockchip_combphy_updatel(priv, GENMASK(5, 4), BIT(4), 0x7c);

Can we get constants for those magic values please?

The combophys for rk3568 and rk3588 do use actual constants to at least
somewhat describe what happens, so it would be really nice for the rk3576
to do this as well.

Same for the rockchip_combphy_updatel and other writel calls below.


> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +	case PHY_TYPE_USB3:
> +		/* Set SSC downward spread spectrum */
> +		rockchip_combphy_updatel(priv, GENMASK(5, 4), BIT(4), 0x7c);
> +
> +		/* Enable adaptive CTLE for USB3.0 Rx */
> +		rockchip_combphy_updatel(priv, GENMASK(0, 0), BIT(0), 0x38);
> +
> +		/* Set PLL KVCO fine tuning signals */
> +		rockchip_combphy_updatel(priv, GENMASK(4, 2), BIT(3), 0x80);
> +
> +		/* Set PLL LPF R1 to su_trim[10:7]=1001 */
> +		writel(0x4, priv->mmio + (0xb << 2));
> +
> +		/* Set PLL input clock divider 1/2 */
> +		rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0x14);
> +
> +		/* Set PLL loop divider */
> +		writel(0x32, priv->mmio + (0x11 << 2));
> +
> +		/* Set PLL KVCO to min and set PLL charge pump current to max */
> +		writel(0xf0, priv->mmio + (0xa << 2));
> +
> +		/* Set Rx squelch input filler bandwidth */
> +		writel(0x0d, priv->mmio + (0x14 << 2));
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* Enable adaptive CTLE for SATA Rx */
> +		rockchip_combphy_updatel(priv, GENMASK(0, 0), BIT(0), 0x38);
> +
> +		/* Set tx_rterm = 50 ohm and rx_rterm = 43.5 ohm */
> +		writel(0x8F, priv->mmio + (0x06 << 2));
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(priv->refclk);
> +
> +	switch (rate) {
> +	case REF_CLOCK_24MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
> +		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
> +			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz */
> +			rockchip_combphy_updatel(priv, GENMASK(7, 6), BIT(6), 0xe << 2);
> +
> +			rockchip_combphy_updatel(priv, GENMASK(7, 0), 0x5f, 0xf << 2);
> +		} else if (priv->type == PHY_TYPE_PCIE) {
> +			/* PLL KVCO tuning fine */
> +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
> +
> +			/* Set up rx_trim */
> +			writel(0x0, priv->mmio + (0x1b << 2));
> +
> +			/* Set up su_trim: T0_1 */
> +			writel(0x90, priv->mmio + (0xa << 2));
> +			writel(0x02, priv->mmio + (0xb << 2));
> +			writel(0x57, priv->mmio + (0xd << 2));
> +
> +			writel(0x5f, priv->mmio + (0xf << 2));

This does includes both the value as well as the register addresses,
because a hex-value with a bit shift makes that even less readable.

Thanks a lot
Heiko


> +		}
> +		break;
> +	case REF_CLOCK_25MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
> +		break;
> +	case REF_CLOCK_100MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->type == PHY_TYPE_PCIE) {
> +			/* gate_tx_pck_sel length select work for L1SS */
> +			writel(0xc0, priv->mmio + 0x74);
> +
> +			/* PLL KVCO tuning fine */
> +			rockchip_combphy_updatel(priv, GENMASK(4, 2), 0x4 << 2, 0x20 << 2);
> +
> +			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
> +			writel(0x4c, priv->mmio + (0x1b << 2));
> +
> +			/* Set up su_trim: T3_P1 650mv */
> +			writel(0x90, priv->mmio + (0xa << 2));
> +			writel(0x43, priv->mmio + (0xb << 2));
> +			writel(0x88, priv->mmio + (0xc << 2));
> +			writel(0x56, priv->mmio + (0xd << 2));
> +		} else if (priv->type == PHY_TYPE_SATA) {
> +			/* downward spread spectrum +500ppm */
> +			rockchip_combphy_updatel(priv, GENMASK(7, 4), 0x50, 0x1f << 2);
> +
> +			/* ssc ppm adjust to 3500ppm */
> +			rockchip_combphy_updatel(priv, GENMASK(3, 0), 0x7, 0x9 << 2);
> +		}
> +		break;
> +	default:
> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (priv->ext_refclk) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			writel(0x10, priv->mmio + (0x20 << 2));
> +
> +			writel(0x0c, priv->mmio + (0x1b << 2));
> +
> +			/* Set up su_trim: T3_P1 650mv */
> +			writel(0x90, priv->mmio + (0xa << 2));
> +			writel(0x43, priv->mmio + (0xb << 2));
> +			writel(0x88, priv->mmio + (0xc << 2));
> +			writel(0x56, priv->mmio + (0xd << 2));
> +		}
> +	}
> +
> +	if (priv->enable_ssc) {
> +		rockchip_combphy_updatel(priv, GENMASK(4, 4), BIT(4), 0x7 << 2);
> +
> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_24MHz) {
> +			/* Xin24M T0_1 650mV */
> +			writel(0x00, priv->mmio + (0x10 << 2));
> +			writel(0x32, priv->mmio + (0x11 << 2));
> +			writel(0x00, priv->mmio + (0x1b << 2));
> +			writel(0x90, priv->mmio + (0x0a << 2));
> +			writel(0x02, priv->mmio + (0x0b << 2));
> +			writel(0x08, priv->mmio + (0x0c << 2));
> +			writel(0x57, priv->mmio + (0x0d << 2));
> +			writel(0x40, priv->mmio + (0x0e << 2));
> +			writel(0x5f, priv->mmio + (0x0f << 2));
> +			writel(0x10, priv->mmio + (0x20 << 2));
> +		}
> +	}
> +
> +	return 0;
> +}




