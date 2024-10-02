Return-Path: <linux-kernel+bounces-347341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7EA98D16B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFEC1F22F8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F91E7652;
	Wed,  2 Oct 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Asfn2mkS"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CFD1E7646;
	Wed,  2 Oct 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865510; cv=none; b=m9KxPaxMl+0ZKSdQxXmDqF44Sc/QYireeGbG+C22qIYtzT3FMqIidQ0dKQJSdgk+evlvM7iMS5H77o5YYYKx9PRqnzq7lDWsI6vnZe5FfLsM1NQWDRtBaX85ZCKELO+MVMhyMrhtzR451YnyaYJx4xMqsYQWwg0t9ptnFD92FHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865510; c=relaxed/simple;
	bh=fJj7aRspLL8JY9ux4R5Q7WOeD6Y4JxxZWhSZzmD9p04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7GwgzndLO06iZUlNHPbd8gmGjcov5EKO2VuDCc2aO1KGIH9Y8ER9rLt3OPi5aDPCUcDXZq3BCS/Czw5OujkZ7c4YqACcql+CNWlUUGRQZ6CR+p2llJmM3tr1YmB2vQHE1w6A62QgxM/Jq+kSMob8lqJa1EDLJ9zLtSoFoE0748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Asfn2mkS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 8CB9023CE1;
	Wed,  2 Oct 2024 12:38:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGSuJFRni2Wp; Wed,  2 Oct 2024 12:38:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727865505; bh=fJj7aRspLL8JY9ux4R5Q7WOeD6Y4JxxZWhSZzmD9p04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Asfn2mkS4NC56d0DdKrCewv1WVSdM8WEUkTHnYdn/uTtWP8lwF20X2+EE5MDN4H92
	 BUVFZTDHfrrYwqcHZkp7UkusNwER7yf5+gZoMo9EH3I+ha/Gei23ORG6NNYTuhAVU4
	 lbro09eeXywtTRSGYFAikB7ZfDDvNJqojob9UGdDLhu/YptfP6UiBIHl2+C5/VqLql
	 9WfG34VBQQXI7pdRUOVfVoYUY+KkSbpZetuXbrYjXpZ06nX9w0ZN7wQxvu0rzC7HKQ
	 C2iiFlCB9/x0D5L21iHix+cPf9+y6cWPG2Th7igxXPLMQJ/NmOALnAkLELPQlmp8S5
	 lClL7cvvuAUiA==
Date: Wed, 2 Oct 2024 10:38:04 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 6/8] clk: rockchip: Add clock controller driver for
 RK3528 SoC
Message-ID: <Zv0ijCB6GfJEEJID@pineapple>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-8-ziyao@disroot.org>
 <115216996.nniJfEyVGO@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <115216996.nniJfEyVGO@diego>

On Wed, Oct 02, 2024 at 12:21:29PM +0200, Heiko Stübner wrote:
> Am Dienstag, 1. Oktober 2024, 06:24:00 CEST schrieb Yao Zi:
> > Add clock tree definition for RK3528. Similar to previous Rockchip
> > SoCs, clock controller shares MMIO region with reset controller and
> > they are probed together.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> 
> [...]
> 
> > +	GATE(ACLK_DDR_UPCTL, "aclk_ddr_upctl", "clk_ddrc_src", CLK_IS_CRITICAL,
> > +	     RK3528_CLKGATE_CON(45), 11, GFLAGS),
> > +	GATE(CLK_DDR_UPCTL, "clk_ddr_upctl", "clk_ddrc_src", CLK_IS_CRITICAL,
> > +	     RK3528_CLKGATE_CON(45), 12, GFLAGS),
> > +	GATE(CLK_DDRMON, "clk_ddrmon", "clk_ddrc_src", CLK_IS_CRITICAL,
> > +	     RK3528_CLKGATE_CON(45), 13, GFLAGS),
> > +	GATE(ACLK_DDR_SCRAMBLE, "aclk_ddr_scramble", "clk_ddrc_src",
> > +	     CLK_IS_CRITICAL, RK3528_CLKGATE_CON(45), 14, GFLAGS),
> > +	GATE(ACLK_SPLIT, "aclk_split", "clk_ddrc_src", CLK_IS_CRITICAL,
> > +	     RK3528_CLKGATE_CON(45), 15, GFLAGS),
> > +
> > +	/* gpu */
> > +	COMPOSITE_NODIV(ACLK_GPU_ROOT, "aclk_gpu_root",
> > +			mux_500m_300m_100m_24m_p, CLK_IS_CRITICAL,
> > +			RK3528_CLKSEL_CON(76), 0, 2, MFLAGS,
> > +			RK3528_CLKGATE_CON(34), 0, GFLAGS),
> 
> Please keep the styling intact for all branch definitions.
> (this one taken as an example, but applies to all)
> 
> I.e. if you look at the rk3588/rk3576/and everything else, you'll see
> subsequent lines getting indented by 3 tabs all the time. For a large
> set of definitions this makes it way easier to parse for the eye, than
> having ever shifting offsets, when things get aligned to opening
> parentheses.
> 
> Similarly, please also keep elements in their position, i.e. for the
> aclk_gpu_root above, this would mean moving parents and CLK_IS_CRITICAL
> up to the parent line.
> 
> (lines according to coding style are allowed up to 100 chars, and Rockchip
> clock drivers sometimes exceed even that, because it makes handling the
> clock drivers a lot easier)

I'm not sure whether it is okay so wrapped these lines. Thanks for
clarification.

> > +};
> > +
> > +static int __init clk_rk3528_probe(struct platform_device *pdev)
> > +{
> > +	struct rockchip_clk_provider *ctx;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *np = dev->of_node;
> > +	unsigned long nr_branches = ARRAY_SIZE(rk3528_clk_branches);
> > +	unsigned long nr_clks;
> > +	void __iomem *reg_base;
> > +
> > +	nr_clks = rockchip_clk_find_max_clk_id(rk3528_clk_branches,
> > +					       nr_branches) + 1;
> > +
> > +	pr_warn("%s: nr_clks = %lu\n", __func__, nr_clks);
> > +
> > +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(reg_base))
> > +		return dev_err_probe(dev, PTR_ERR(reg_base),
> > +				     "could not map cru region");
> > +
> > +	ctx = rockchip_clk_init(np, reg_base, nr_clks);
> > +	if (IS_ERR(ctx))
> > +		return dev_err_probe(dev, PTR_ERR(ctx),
> > +				     "rockchip clk init failed");
> > +
> > +	rockchip_clk_register_plls(ctx, rk3528_pll_clks,
> > +				   ARRAY_SIZE(rk3528_pll_clks),
> > +				   RK3528_GRF_SOC_STATUS0);
> > +	rockchip_clk_register_armclk(ctx, ARMCLK, "armclk",
> > +				     mux_armclk, ARRAY_SIZE(mux_armclk),
> > +				     &rk3528_cpuclk_data, rk3528_cpuclk_rates,
> > +				     ARRAY_SIZE(rk3528_cpuclk_rates));
> > +	rockchip_clk_register_branches(ctx, rk3528_clk_branches, nr_branches);
> > +
> > +	rockchip_register_softrst(np, 47, reg_base + RK3528_SOFTRST_CON(0),
> > +				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> 
> here you'll like also want to check how rk3576 + rk3588 handle how the reset-ids
> are not matched to the register offsets anymore.
> (see rst-rk3588.c for example)

Have checked them when replying to the former mails. Reset code will be
largely refacted according to the recommended style in next revision.

Best regards,
Yao Zi

