Return-Path: <linux-kernel+bounces-520298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780EA3A82C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1651889399
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246851EFF87;
	Tue, 18 Feb 2025 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Bv2LRY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B11E51FF;
	Tue, 18 Feb 2025 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908540; cv=none; b=rjaGvIcfnZ5IO+gZHdGFYYQPwu6v3LZN+za0tdYadiqGD4jkXSLI6PBxSCK5C1Q58iyyKdF5KY9H6lxclI8vMlqVY08OHtIU+spSlcJNFdkI4NPzY/NXEYtaqALg6Gsq+48yT78G5Mo3cLl+YVAIWsUK4ai98HvhwcPNMzuVBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908540; c=relaxed/simple;
	bh=k/Rt6rfh9WwBwPJRxUAOtPloEhHSn81RZv1EwdOh1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgE580y2HZmXy388PNXaeBnrU5uGA4IlwO/kNwyJUDPhl4lX9pKbgQeDbpirVG8rjuikmWf6HdxbZoRVkofg9kS/+a2isG2YV8IVE55iaEkbqAkk7/BqD7Yy1yNBvHykzUecmlLPc9Mw5D060U6+uarisYdSqv209pfV0Qlyfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Bv2LRY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so854045e9.0;
        Tue, 18 Feb 2025 11:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739908537; x=1740513337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyFAvHnWoYMGsKstM+kT9VyU5glSveY29/SkjUzLsmk=;
        b=J6Bv2LRYTCqnLHM7unRn2DxY5JBpoMOvB+FZ2HbJ8tB+UK91/mckMV9W9rWxD2tqgz
         2NnerxQHJEvhRojisymAI6dhFrqjYzApgzVcCiBRKw/2uYV5M+/A5ng6RbDFVPIHXl4s
         EiVtEk96ORaxtj4n3CEJxkfF+qdC6oOLX0txXP0jtBV1jkqLh8aQM0kOwMSfw5IYepCQ
         SRHHpwUxOz6YjywmcHil+BYBUu49ZlJV/c1GjYesaF+anIwfUiv19qgcbsV0uqGXlR3t
         PWM7pi9gn8ECcHPmx+szQZBtldhgC0nc69Kk2IEiBh6N4+2LSThnWmC86i7XfWr1bldd
         1oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739908537; x=1740513337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyFAvHnWoYMGsKstM+kT9VyU5glSveY29/SkjUzLsmk=;
        b=T8LShrTb4EUuvSfcVaNbrNdoQiyUG6a+KBGKge76SgG+ooxYqcqgflFWrMloO3q+y2
         qKyyPOnZ36AnQWi0FuUHT1EdazJxncjVLxYGrFz5TaHMvkOoW28M0C67GtKyL+Ysc00e
         NgKIXtZzHIdiO4tyKfqNGY+boFPEUxXQ5PAcxrWqsJMymtY0NSTUm4Dnmg3ZJmiElqdF
         qzFep+IKAKgBRmIIGAx6RCRoqdSTC0kbS97c/FVj2kND0d2ziP0+MPWFmEZXt9Hd7D3C
         G0yFbfc5DYh16ER49RgjOAX8qGQMZN0MJYVnMz675TH4k4B9HAG4FeBffo+p8laFAbCm
         vtJw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwlNKJuLtoe1HWKOj8Ubqmh8avMd+MZbmVSKmiqzS680FxuibH0l0M7HCo01JmqhqpNLwM864ExAm@vger.kernel.org, AJvYcCWirl0nNpHREuRJE6pBGDyja7B6CEz4/PD7nza4trf8XeR6GbzJVMmINLrGXc9bGpMiVAJ+zckkLWDVuZSD@vger.kernel.org, AJvYcCX6CpghKZRtxACosQVybmJLfoACaeaMEBtQDxchxxecPSiuqsNOPd1oh8SN1Rj86/AU0yX91rHgbON3@vger.kernel.org
X-Gm-Message-State: AOJu0YxlF77tXBpeO1m3COl5h8dT0EjnPBPD0r24xyRyrnNOUB9l4mGj
	btvO4rnRchTzWOogzrPQRzKwczQjAfSx92fQ1FKk6atXoBUTexbi
X-Gm-Gg: ASbGncu37l2BRZT1e3kvO5DvOTEufGxjDg/oklplnu7eGjUpMYUYPpizRy193YYq1wT
	b7ohzrpqFljiRIWjA0r8E6YK629nbG5w99CQ7JA1XX3Q0G0Br56q6t+EiEvYwlznzavbMuYto6U
	VO2D2060XpXFU9ObZ0BptgXk+TfIVROmByHXGSG9L2EdVK1auveVerCF1DNy/1pcqW/LfrP5eYL
	bHhyW7Z7bUFnMVmuWmxCu06nJHjuzymW1xqxNLBSZJVvJBNJ2j8kCaF4pP4ySpRJYXgu5y2w7uy
	v3SPgr+P7kyWCk3DG6l5UfzYiOzUmElyV70GMUQsqzH6FdgnHxTe/YE6E5JjfFxpKoc=
X-Google-Smtp-Source: AGHT+IGGYoucYTPiZvi9obRT6/pb2zsR/EsexoK2OOZKBRfsRgBHInK++vwyne9vU9LtGD0j5Deg3g==
X-Received: by 2002:a05:600c:1c08:b0:439:98fd:a4b6 with SMTP id 5b1f17b1804b1-43999b70c96mr10501245e9.15.1739908536452;
        Tue, 18 Feb 2025 11:55:36 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm16019373f8f.99.2025.02.18.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:55:36 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/15] clk: sunxi-ng: a523: remaining mod clocks
Date: Tue, 18 Feb 2025 20:55:34 +0100
Message-ID: <47026132.fMDQidcC6G@jernej-laptop>
In-Reply-To: <20250214125359.5204-12-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-12-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:55 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the remaining mod clocks, driving various parts of the SoC: the "LEDC"
> LED controller, the "CSI" camera interface, the "ISP" image processor,
> the DSP clock, and the "fanout" clocks, which allow to put clock signals
> on external pins.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 190 +++++++++++++++++++++++++
>  1 file changed, 190 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.c
> index 59cc31f89ae77..6a4340f1fd041 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -354,6 +354,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ah=
b_apb0_parents, 0x520,
>  				 0, 5,		/* M */
>  				 24, 2,	/* mux */
>  				 0);
> +static const struct clk_hw *apb0_hws[] =3D { &apb0_clk.common.hw };
> =20
>  static const struct clk_parent_data apb1_parents[] =3D {
>  	{ .fw_name =3D "hosc" },
> @@ -832,6 +833,153 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp",=
 edp_parents, 0xbb0,
>  				    BIT(31),	/* gate */
>  				    0);
> =20
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ir_tx_ledc_paren=
ts,
> +				      0xbf0,
> +				      0, 4,	/* M */
> +				      24, 1,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static const struct clk_hw *csi_top_parents[] =3D {
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_video3_4x_clk.common.hw,
> +	&pll_video3_3x_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_top_clk, "csi-top", csi_top_pare=
nts,
> +				    0xc04,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_parent_data csi_mclk_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_video3_4x_clk.common.hw },
> +	{ .hw =3D &pll_video0_4x_clk.common.hw },
> +	{ .hw =3D &pll_video1_4x_clk.common.hw },
> +	{ .hw =3D &pll_video2_4x_clk.common.hw },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk0_clk, "csi-mclk0",
> +				       csi_mclk_parents, 0xc08,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);

Missing dual div flag for csi-mclk clocks.

> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk1_clk, "csi-mclk1",
> +				       csi_mclk_parents, 0xc0c,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk2_clk, "csi-mclk2",
> +				       csi_mclk_parents, 0xc10,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk3_clk, "csi-mclk3",
> +				       csi_mclk_parents, 0xc14,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
> +static const struct clk_hw *isp_parents[] =3D {
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_video3_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(isp_clk, "isp", isp_parents, 0xc20,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_parent_data dsp_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .hw =3D &pll_periph0_2x_clk.common.hw },
> +	{ .hw =3D &pll_periph0_400M_clk.hw, },

Last one should be pll_periph0_480M_clk.

> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "dsp", dsp_parents, 0xc70,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_GATE_DATA(fanout_24M_clk, "fanout-24M", osc24M,
> +			   0xf30, BIT(0), 0);
> +static SUNXI_CCU_GATE_DATA_WITH_PREDIV(fanout_12M_clk, "fanout-12M", osc=
24M,
> +				       0xf30, BIT(1), 2, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M",
> +				      pll_periph0_480M_hws,
> +				      0xf30, BIT(2), 30, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M",
> +				      pll_periph0_2x_hws,
> +				      0xf30, BIT(3), 48, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_50M_clk, "fanout-50M",
> +				      pll_periph0_2x_hws,
> +				      0xf30, BIT(4), 24, 0);
> +
> +/* These clocks have a second divider that is not modelled and forced to=
 0. */

Any specific reason for that?

Best regards,
Jernej

> +#define SUN55I_A523_FANOUT_27M_REG	0xf34
> +static const struct clk_hw *fanout_27M_parents[] =3D {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_video3_4x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(fanout_27M_clk, "fanout-27M",
> +				    fanout_27M_parents, 0xf34,
> +				    0, 5,	/* M */
> +				    24, 2,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +#define SUN55I_A523_FANOUT_PCLK_REG	0xf38
> +static SUNXI_CCU_M_HWS_WITH_GATE(fanout_pclk_clk, "fanout-pclk", apb0_hw=
s,
> +				 0xf38,
> +				 0, 5,		/* M */
> +				 BIT(31),	/* gate */
> +				 0);
> +
> +static const struct clk_parent_data fanout_parents[] =3D {
> +	{ .fw_name =3D "osc32k-out" },
> +	{ .hw =3D &fanout_12M_clk.common.hw, },
> +	{ .hw =3D &fanout_16M_clk.common.hw, },
> +	{ .hw =3D &fanout_24M_clk.common.hw, },
> +	{ .hw =3D &fanout_25M_clk.common.hw, },
> +	{ .hw =3D &fanout_27M_clk.common.hw, },
> +	{ .hw =3D &fanout_pclk_clk.common.hw, },
> +	{ .hw =3D &fanout_50M_clk.common.hw, },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout0_clk, "fanout0", fanout_paren=
ts,
> +				    0xf3c,
> +				    0, 3,	/* mux */
> +				    BIT(21),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout1_clk, "fanout1", fanout_paren=
ts,
> +				    0xf3c,
> +				    3, 3,	/* mux */
> +				    BIT(22),	/* gate */
> +				    0);
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout2_clk, "fanout2", fanout_paren=
ts,
> +				    0xf3c,
> +				    6, 3,	/* mux */
> +				    BIT(23),	/* gate */
> +				    0);
> +
>  /*
>   * Contains all clocks that are controlled by a hardware register. They
>   * have a (sunxi) .common member, which needs to be initialised by the c=
ommon
> @@ -904,6 +1052,23 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =
=3D {
>  	&tcon_tv0_clk.common,
>  	&tcon_tv1_clk.common,
>  	&edp_clk.common,
> +	&ledc_clk.common,
> +	&csi_top_clk.common,
> +	&csi_mclk0_clk.common,
> +	&csi_mclk1_clk.common,
> +	&csi_mclk2_clk.common,
> +	&csi_mclk3_clk.common,
> +	&isp_clk.common,
> +	&dsp_clk.common,
> +	&fanout_24M_clk.common,
> +	&fanout_12M_clk.common,
> +	&fanout_16M_clk.common,
> +	&fanout_25M_clk.common,
> +	&fanout_27M_clk.common,
> +	&fanout_pclk_clk.common,
> +	&fanout0_clk.common,
> +	&fanout1_clk.common,
> +	&fanout2_clk.common,
>  };
> =20
>  static struct clk_hw_onecell_data sun55i_a523_hw_clks =3D {
> @@ -997,6 +1162,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_cl=
ks =3D {
>  		[CLK_TCON_TV0]		=3D &tcon_tv0_clk.common.hw,
>  		[CLK_TCON_TV1]		=3D &tcon_tv1_clk.common.hw,
>  		[CLK_EDP]		=3D &edp_clk.common.hw,
> +		[CLK_LEDC]		=3D &ledc_clk.common.hw,
> +		[CLK_CSI_TOP]		=3D &csi_top_clk.common.hw,
> +		[CLK_CSI_MCLK0]		=3D &csi_mclk0_clk.common.hw,
> +		[CLK_CSI_MCLK1]		=3D &csi_mclk1_clk.common.hw,
> +		[CLK_CSI_MCLK2]		=3D &csi_mclk2_clk.common.hw,
> +		[CLK_CSI_MCLK3]		=3D &csi_mclk3_clk.common.hw,
> +		[CLK_ISP]		=3D &isp_clk.common.hw,
> +		[CLK_DSP]		=3D &dsp_clk.common.hw,
> +		[CLK_FANOUT_24M]	=3D &fanout_24M_clk.common.hw,
> +		[CLK_FANOUT_12M]	=3D &fanout_12M_clk.common.hw,
> +		[CLK_FANOUT_16M]	=3D &fanout_16M_clk.common.hw,
> +		[CLK_FANOUT_25M]	=3D &fanout_25M_clk.common.hw,
> +		[CLK_FANOUT_27M]	=3D &fanout_27M_clk.common.hw,
> +		[CLK_FANOUT_PCLK]	=3D &fanout_pclk_clk.common.hw,
> +		[CLK_FANOUT0]		=3D &fanout0_clk.common.hw,
> +		[CLK_FANOUT1]		=3D &fanout1_clk.common.hw,
> +		[CLK_FANOUT2]		=3D &fanout2_clk.common.hw,
>  	},
>  };
> =20
> @@ -1048,6 +1230,14 @@ static int sun55i_a523_ccu_probe(struct platform_d=
evice *pdev)
>  	val &=3D ~(BIT(1) | BIT(0));
>  	writel(val, reg + SUN55I_A523_PLL_AUDIO0_REG);
> =20
> +	/* Force fanout factors N to 0. */
> +	val =3D readl(reg + SUN55I_A523_FANOUT_27M_REG);
> +	val &=3D ~GENMASK(12, 8);
> +	writel(val, reg + SUN55I_A523_FANOUT_27M_REG);
> +	val =3D readl(reg + SUN55I_A523_FANOUT_PCLK_REG);
> +	val &=3D ~GENMASK(9, 5);
> +	writel(val, reg + SUN55I_A523_FANOUT_PCLK_REG);
> +
>  	ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_ccu_desc);
>  	if (ret)
>  		return ret;
>=20





