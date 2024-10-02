Return-Path: <linux-kernel+bounces-347325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADD998D119
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C61280FFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CB11E631A;
	Wed,  2 Oct 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="s9kqMYvg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AD19CD1E;
	Wed,  2 Oct 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864502; cv=none; b=gtgYrgFfEM4N764PcAlCnbZV/KB9nEXAhc8u1CqUm2PZo2QX2i8vzWtWCnTTxDP2RxH8cYPI72EjDu16yfPabJBsIP0bp/FQw4L5zluHvqTq5+lfSb5zUS6TC/Jqv0ABPBNGhtdEnyP8GpucXEyGU8atlbODP++OAV3WW/W1ViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864502; c=relaxed/simple;
	bh=VrViroLOfqFJSFtiDohHwgzl+iWZg0tA71VDTdc6pys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEKLp60LD+13UaEcIC+IQr3mWUbHafh9xP+3t7etdg5URsr3Ji1lPFXYPjkYZR8Y2PZmZsTSo9KbnfjDH0ED5D9X1k9HLMm2RC9GgR2rE0T38OTnrD1JKLwolJYq/gaqWBOmYluEn1Rr1fQ+bZm6SK9Yzm2634M4/PWSLcfkCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=s9kqMYvg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qx7UuxsjZ+GGwfajZkd5assNTnVL++J+/iRL6jQhBoA=; b=s9kqMYvgu35sXrUEjWRBFYUVrJ
	k4txb72cuxPxEfIMJaYeNsu9BCbx1t/K7+bzz3RCgEGwDLGwzq6gP+8uMjHyUcHiiK491azAMlswC
	DSUH9LSx8R87umgStFwXQWipKNXxEEbaLFv5XdHh9c5pEYNQUoIunYYb84zFYXSaUrsCW9whZxya0
	5KEv0683rOiwioU3AjMspVQICjdRa36bx9vY4cqhQgbbUXyYyK+BlrsCofjEOpNyrprQl/8OLzM3V
	cXIouIzJF7kT9DgA5TAWVPE98w/KOgcQbCQwzoPxckPI4Z3WE7yf6fpVycyyhvFAQ0eMoGVQFd8Qe
	GPE10JgQ==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svwU6-00050f-PV; Wed, 02 Oct 2024 12:21:30 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Yao Zi <ziyao@disroot.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>
Subject:
 Re: [PATCH 6/8] clk: rockchip: Add clock controller driver for RK3528 SoC
Date: Wed, 02 Oct 2024 12:21:29 +0200
Message-ID: <115216996.nniJfEyVGO@diego>
In-Reply-To: <20241001042401.31903-8-ziyao@disroot.org>
References:
 <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-8-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 1. Oktober 2024, 06:24:00 CEST schrieb Yao Zi:
> Add clock tree definition for RK3528. Similar to previous Rockchip
> SoCs, clock controller shares MMIO region with reset controller and
> they are probed together.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

[...]

> +	GATE(ACLK_DDR_UPCTL, "aclk_ddr_upctl", "clk_ddrc_src", CLK_IS_CRITICAL,
> +	     RK3528_CLKGATE_CON(45), 11, GFLAGS),
> +	GATE(CLK_DDR_UPCTL, "clk_ddr_upctl", "clk_ddrc_src", CLK_IS_CRITICAL,
> +	     RK3528_CLKGATE_CON(45), 12, GFLAGS),
> +	GATE(CLK_DDRMON, "clk_ddrmon", "clk_ddrc_src", CLK_IS_CRITICAL,
> +	     RK3528_CLKGATE_CON(45), 13, GFLAGS),
> +	GATE(ACLK_DDR_SCRAMBLE, "aclk_ddr_scramble", "clk_ddrc_src",
> +	     CLK_IS_CRITICAL, RK3528_CLKGATE_CON(45), 14, GFLAGS),
> +	GATE(ACLK_SPLIT, "aclk_split", "clk_ddrc_src", CLK_IS_CRITICAL,
> +	     RK3528_CLKGATE_CON(45), 15, GFLAGS),
> +
> +	/* gpu */
> +	COMPOSITE_NODIV(ACLK_GPU_ROOT, "aclk_gpu_root",
> +			mux_500m_300m_100m_24m_p, CLK_IS_CRITICAL,
> +			RK3528_CLKSEL_CON(76), 0, 2, MFLAGS,
> +			RK3528_CLKGATE_CON(34), 0, GFLAGS),

Please keep the styling intact for all branch definitions.
(this one taken as an example, but applies to all)

I.e. if you look at the rk3588/rk3576/and everything else, you'll see
subsequent lines getting indented by 3 tabs all the time. For a large
set of definitions this makes it way easier to parse for the eye, than
having ever shifting offsets, when things get aligned to opening
parentheses.

Similarly, please also keep elements in their position, i.e. for the
aclk_gpu_root above, this would mean moving parents and CLK_IS_CRITICAL
up to the parent line.

(lines according to coding style are allowed up to 100 chars, and Rockchip
clock drivers sometimes exceed even that, because it makes handling the
clock drivers a lot easier)

> +};
> +
> +static int __init clk_rk3528_probe(struct platform_device *pdev)
> +{
> +	struct rockchip_clk_provider *ctx;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	unsigned long nr_branches = ARRAY_SIZE(rk3528_clk_branches);
> +	unsigned long nr_clks;
> +	void __iomem *reg_base;
> +
> +	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> +					       nr_branches) + 1;
> +
> +	pr_warn("%s: nr_clks = %lu\n", __func__, nr_clks);
> +
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return dev_err_probe(dev, PTR_ERR(reg_base),
> +				     "could not map cru region");
> +
> +	ctx = rockchip_clk_init(np, reg_base, nr_clks);
> +	if (IS_ERR(ctx))
> +		return dev_err_probe(dev, PTR_ERR(ctx),
> +				     "rockchip clk init failed");
> +
> +	rockchip_clk_register_plls(ctx, rk3528_pll_clks,
> +				   ARRAY_SIZE(rk3528_pll_clks),
> +				   RK3528_GRF_SOC_STATUS0);
> +	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
> +				     mux_armclk, ARRAY_SIZE(mux_armclk),
> +				     &rk3528_cpuclk_data, rk3528_cpuclk_rates,
> +				     ARRAY_SIZE(rk3528_cpuclk_rates));
> +	rockchip_clk_register_branches(ctx, rk3528_clk_branches, nr_branches);
> +
> +	rockchip_register_softrst(np, 47, reg_base + RK3528_SOFTRST_CON(0),
> +				  ROCKCHIP_SOFTRST_HIWORD_MASK);

here you'll like also want to check how rk3576 + rk3588 handle how the reset-ids
are not matched to the register offsets anymore.
(see rst-rk3588.c for example)


Thanks a lot
Heiko



