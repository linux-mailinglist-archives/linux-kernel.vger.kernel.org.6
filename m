Return-Path: <linux-kernel+bounces-446318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FE9F2291
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 09:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68FB16582F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 08:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1232152F9B;
	Sun, 15 Dec 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VQwcq5hc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D61CFB6;
	Sun, 15 Dec 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734250137; cv=none; b=K9N9xJaZ+rjk3yNSTFw2vuOXI3nPue6rIRk4QO/lp2dD+BOnpbIgf/s+bfJMq3piF9QiGKm/hEkaxf/mmZQoF+j3UNfaATMyh8EKyDVo6k+lf1Rgby67J439RM8vjKwyVFgquvCee8rFDa+YJY+61Ujd1Y034MxFCxpD7/qv6vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734250137; c=relaxed/simple;
	bh=mTx/SUo/2cPYukaVP0N9YGA5hwppTVdVXECxTHdD1f8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MHSeqNhv7kk39MvwfNWLCXVK31EU8JFua2BSd+FeBpqioKiAq9kH2WG0pQ1p4ZccuaYe4rDHNR3uFTlbY56ZSsRk1gR6FeP4IfmoGk+CkQQgUqYmwCOAlvhUzbHYhFhLACh1udxjUAzBE5k1I1dAwuGr0Hgf3pTuiJreNxXdJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VQwcq5hc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1734250133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QUb5xuTuYQHpC3cVU3eh5B+19cq4zd2piW0HbbFtwAo=;
	b=VQwcq5hcvGxLAtm/bOe0r7v+VbxFmms5LcWlEqTd4qYYmdRx0yNVCaJa4xxsOAo2ifn/l6
	Hk2Gd3kOpurSjjfzK46Zo1w/VnGvJdOLFEXY5l/+Gx+gkxVA4LKghcC/31KfVj75eQlh0i
	YjZWUX/HiE9ASnjgmXMU4MRqgFbgrtAmMJlSyHmvJ8urrPeZo3ocZewkvTlbmSnibz5WE1
	gKqyBzBvzKcfD8gBSyI3gqn+/LCLcZO5RA79RtbCazdp6n5aenuZYtzpDoqeyW0QQRvkvZ
	ikQ9ClfZUYibbStlY+Yxi31i1iYHs39Ksp3RiNBLfpl3U/W9Yo3AuSACe9BcFg==
Date: Sun, 15 Dec 2024 09:08:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, Roman Beranek
 <me@crly.cz>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/3] clk: sunxi-ng: a64: stop force-selecting PLL-MIPI as
 TCON0 parent
In-Reply-To: <20241215053639.738890-4-anarsoul@gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
 <20241215053639.738890-4-anarsoul@gmail.com>
Message-ID: <32683972639853c626d46fa4374d1558@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Vasily,

On 2024-12-15 06:34, Vasily Khoruzhick wrote:
> Force selecting PLL-MIPI as TCON0 parent breaks video output on 
> Pinebook
> that uses RGB to eDP bridge.
> 
> TCON0 clock parent will be selected in the device tree instead.
> 
> Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in 
> TCON0 mux")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Looking good to me, as a patch that completes the panel bugfix.
Thanks once again for the patches!

I'd suggest that the patch description is improved further a bit,
by incorporating some parts of the good description of the issue
that's already in the cover letter.  In particular, I'd suggest
that you describe that the patch partially reverts an earlier
commit, etc.

Additionally, I'd suggest that the comment block deleted below is
actually adjusted and copied to the addition to the A64 SoC dtsi,
which is performed in the first patch in your series.  That might
be of high value later.

With that addressed, please feel free to include

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 3a7d61c81667..cc8de0bfbc67 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -534,12 +534,6 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", 
> de_parents,
>  				 0x104, 0, 4, 24, 3, BIT(31),
>  				 CLK_SET_RATE_PARENT);
> 
> -/*
> - * DSI output seems to work only when PLL_MIPI selected. Set it and 
> prevent
> - * the mux from reparenting.
> - */
> -#define SUN50I_A64_TCON0_CLK_REG	0x118
> -
>  static const char * const tcon0_parents[] = { "pll-mipi", 
> "pll-video0-2x" };
>  static const u8 tcon0_table[] = { 0, 2, };
>  static SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(tcon0_clk, "tcon0", 
> tcon0_parents,
> @@ -959,11 +953,6 @@ static int sun50i_a64_ccu_probe(struct
> platform_device *pdev)
> 
>  	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
> 
> -	/* Set PLL MIPI as parent for TCON0 */
> -	val = readl(reg + SUN50I_A64_TCON0_CLK_REG);
> -	val &= ~GENMASK(26, 24);
> -	writel(val | (0 << 24), reg + SUN50I_A64_TCON0_CLK_REG);
> -
>  	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_desc);
>  	if (ret)
>  		return ret;

