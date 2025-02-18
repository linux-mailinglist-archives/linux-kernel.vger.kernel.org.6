Return-Path: <linux-kernel+bounces-520242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A4DA3A75D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7005F1885EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1C1A0730;
	Tue, 18 Feb 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc2ja61d"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A155617A308;
	Tue, 18 Feb 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906796; cv=none; b=V/bzC3Oenf/k+3VTybKkP8mZ/T57Rt1IJ/muxTXFurUX55keTto9jCvBGOnc3DgmXrVlN+z1g5/iQyvUEp+yB+F4klCeomLza9XEXPzQgpf8Ndzu7Sfbyh7oqVPHINgzSFM7ID+6MXFWJC8KYAYIkC4CSjWl8O2x8vYPy+Pngkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906796; c=relaxed/simple;
	bh=RiKcmJX/8GC/W/buBuIX0hQHB/5PQiCKDdjKHe168CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRCoYNbD+4r36h9hUZ7iGpTHPg/mqkVdrwXo47KvEyXYiU6IaZZQM0n0Z8FsaOupb1MIqvPAw1PqZcZelJbf/06LcXt23QTc8qOntvRZmPP7mPjUATGhSF3ZhQVEWsSniAwK8CwwS+aFO4O5rEnGOvpqNrZWd+Cc9JAke059ucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc2ja61d; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-438a39e659cso40899025e9.2;
        Tue, 18 Feb 2025 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739906793; x=1740511593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0O7shOkTYYhzpBdc0RT+E/zz0YqOfNDEdfZfpbbnbE=;
        b=jc2ja61dn+0iihPO9FTMRkA+xuc+qN01HuliVdsnuUxpINKI32nVSQMDOB7K4c/pXG
         S90iOUz1syAY91lZ1fDrcoTOFJleBUrmjiKBKEEjHsWTd6DlTKdxxzfbzdHomyUy9G2H
         VPxQ0OWen5RK5Fhxp8EcLINc6qZpS8zWiFIvyBSrd383Z/gQDkwLH1r7rLHU1XjSh/VV
         T9bwphgJ/fAL1UDh8xzKXWxjrq2TrmUWMxIzbPPbaDYjU7yogghmH+L5cYTxNOwALeIP
         pi3X8MDC8kNORw2bXZS0zXZVktvZ9+us9tTPJDgV71UjqTnS8UktoLttXa+hIQgj5KEv
         sXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739906793; x=1740511593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0O7shOkTYYhzpBdc0RT+E/zz0YqOfNDEdfZfpbbnbE=;
        b=PQVUsTj2I4EBcRmgnfbbqRZmHvLaDhdoFoWj880EaRMpB5uNOBcWhnjMYk0tXO9AT1
         xDnu8e7VqktgOkr/f5KrigZ9nPBnrmgjPMa25gjaTVxFQrKVR0W+Fn9vIM/ezl2hL0eW
         NZ2K/mou4UFppCVp3xXx5WX0yoYBNC5PH4dW05JqBTcItgQMnv9CcN2SYVCpkO6Qkv1x
         goNIneQpJeUtEtBOvQsYDeGkyX1TMkeaQmgOUjnOjOJD8heIjjWnpxTJkGhFG9DvKaCK
         oqS0H5FDFnqq8EqJitHjvlA6+xyUu3FW9F98dLGc2r798hK691ox3Tak6xk3ITEVUe1I
         /G3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC/RIzLONZpoF6B7ME0oVg2reZpbKIXqa7nVBpWG2OXnQQeRo56X8JWLYS5Yum2Vxl3BOewzSLkHqzh0RV@vger.kernel.org, AJvYcCUn0mk7/fliDPb6Qq5lL5qrQkAI5hHpICtSDgYDBdsWhbEG36zJ6FDZjzSuFOmRh/HfLjpLn8LFHnJp@vger.kernel.org, AJvYcCXFW6VQrkWSP8oZcK2Rqkn5dxNpFyYGoBzkWSGWyW/gf34gc7B7Ifs+J7x5EWifRCIcj3vwzET8BI8m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bjJbu5YaXackjU/Ve1cdGckxnKvakTxRz5CiE6DXC5Iouhhb
	YZrB6cAQIrrMFgfkeLsPQdHk97q2clRP3lT0duS7iy6UCqFEtdJU
X-Gm-Gg: ASbGncu3CNpGNuGMCXZfowhbbocSLVoI+EsKwLqwei+MwhpDKNAbayvtJ5O7gRxdwkT
	5mbP1+D3OMRppyyHCOZ4t9GKWYk3zq5yj4UggWGoDOl2RLdjZFsolHmZh13nsvFUlMapnqorAvU
	HLALS8w7cuWTlZbmKYy7WuO07ZFbFm+z9QJ0SMecCwrZ/mh2U3Ggz63elDCQSpB2ijW6voC6Icy
	c0XkQlipnqqOXGFbbuRoIHS0d3mToUkHIl950aLV9pCXpbvuVlajbOYojueFhG6SiGnAdNF1qvF
	ktgQr3P2H8aGu+ctPzKHWbmS7dnpeoyHcwkKk0cw5he7Koaid0h9YP72httwE/z8ZAc=
X-Google-Smtp-Source: AGHT+IE8P6Bf5j6JNMDNPPmdiyOQzARFL3KZEbRWk3stCaeMLQwc8p5C2vnHoL6JXmbjGbMJBisPYA==
X-Received: by 2002:a05:600c:511a:b0:439:643a:c8c4 with SMTP id 5b1f17b1804b1-4396e7527cfmr125859015e9.22.1739906792544;
        Tue, 18 Feb 2025 11:26:32 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439922141a5sm35844685e9.2.2025.02.18.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:26:32 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] clk: sunxi-ng: a523: add video mod clocks
Date: Tue, 18 Feb 2025 20:26:31 +0100
Message-ID: <9406479.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20250214125359.5204-8-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-8-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:51 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the clocks driving the various video subsystems of the SoC: the "DE"
> display engine, the "DI" deinterlacer, the "G2D" 2D graphics system, the
> Mali "GPU", the "VE" video engine, its associated IOMMU, as well as the
> clocks for the various video output drivers (HDMI, DP, LCDs).
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 219 +++++++++++++++++++++++++
>  1 file changed, 219 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.c
> index 59f45e7c0904b..0ef1fd71a1ca5 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -364,6 +364,192 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", =
apb1_parents, 0x524,
>  				 24, 3,		/* mux */
>  				 0);
> =20
> +
> +/***********************************************************************=
***
> + *                          mod clocks                                  =
  *
> + ***********************************************************************=
***/
> +
> +static const struct clk_hw *de_parents[] =3D {
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_video3_4x_clk.common.hw,
> +	&pll_video3_3x_clk.hw,
> +};
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *di_parents[] =3D {
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +};
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0x620,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *g2d_parents[] =3D {
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_300M_clk.hw,
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +};
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0x630,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_hw *gpu_parents[] =3D {
> +	&pll_gpu_clk.common.hw,
> +	&pll_periph0_800M_clk.common.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_300M_clk.hw,
> +	&pll_periph0_200M_clk.hw,
> +};
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
> +				    0, 4,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);

GPU clock should have CLK_SET_RATE_FLAG.

> +
> +static const struct clk_hw *ve_parents[] =3D {
> +	&pll_ve_clk.common.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_300M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static const struct clk_parent_data iommu_parents[] =3D {
> +	{ .hw =3D &pll_periph0_600M_clk.hw },
> +	{ .hw =3D &pll_ddr0_clk.common.hw },
> +	{ .hw =3D &pll_periph0_480M_clk.common.hw },
> +	{ .hw =3D &pll_periph0_400M_clk.hw },
> +	{ .hw =3D &pll_periph0_150M_clk.hw },
> +	{ .fw_name =3D "hosc" },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(iommu_clk, "iommu", iommu_parents,=
 0x7b0,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      CLK_SET_RATE_PARENT);

This won't work. IOMMU clock has also update bit, which must be set to actu=
ally
apply the new value, same as DDR clock.

> +
> +static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, BIT(=
31), 0);
> +
> +/* TODO: add mux between 32kOSC and PERIPH0/18750 */

Not sure what this TODO means.

> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k",
> +				      pll_periph0_2x_hws,
> +				      0xb10, BIT(30), 36621, 0);
> +
> +static const struct clk_parent_data hdmi_cec_parents[] =3D {
> +	{ .fw_name =3D "losc" },
> +	{ .hw =3D &hdmi_cec_32k_clk.common.hw },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec_p=
arents,
> +				    0xb10,
> +				    24, 1,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static const struct clk_parent_data mipi_dsi_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph0_200M_clk.hw },
> +	{ .hw =3D &pll_periph0_150M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi0_clk, "mipi-dsi0",
> +				      mipi_dsi_parents, 0xb24,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi1_clk, "mipi-dsi1",
> +				      mipi_dsi_parents, 0xb28,
> +				      0, 5,	/* M */
> +				      24, 3,	/* mux */
> +				      BIT(31),	/* gate */
> +				      CLK_SET_RATE_PARENT);
> +
> +static const struct clk_hw *tcon_parents[] =3D {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_video3_4x_clk.common.hw,
> +	&pll_periph0_2x_clk.common.hw,
> +	&pll_video0_3x_clk.hw,
> +	&pll_video1_3x_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_par=
ents,
> +				    0xb60,
> +				    0,  5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_par=
ents,
> +				    0xb64,
> +				    0,  5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);

Missing tcon-lcd2 - see T527 manual.

> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi0_clk, "combophy-dsi0",
> +				    tcon_parents, 0xb6c,
> +				    0,  5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi1_clk, "combophy-dsi1",
> +				    tcon_parents, 0xb70,
> +				    0,  5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", tcon_paren=
ts,
> +				    0xb80,
> +				    0, 4,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv1_clk, "tcon-tv1", tcon_paren=
ts,
> +				    0xb84,
> +				    0, 4,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_SET_RATE_PARENT);

TCON TV0-1 parents are subset of others, according to T527 manual.

> +
> +static const struct clk_hw *edp_parents[] =3D {
> +	&pll_video0_4x_clk.common.hw,
> +	&pll_video1_4x_clk.common.hw,
> +	&pll_video2_4x_clk.common.hw,
> +	&pll_video3_4x_clk.common.hw,
> +	&pll_periph0_2x_clk.common.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp", edp_parents, 0xbb0,
> +				    0, 4,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +

Missing CLK_SET_RATE_PARENT flag.

Best regards,
Jernej

>  /*
>   * Contains all clocks that are controlled by a hardware register. They
>   * have a (sunxi) .common member, which needs to be initialised by the c=
ommon
> @@ -394,6 +580,22 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =3D=
 {
>  	&ahb_clk.common,
>  	&apb0_clk.common,
>  	&apb1_clk.common,
> +	&de_clk.common,
> +	&di_clk.common,
> +	&g2d_clk.common,
> +	&gpu_clk.common,
> +	&ve_clk.common,
> +	&iommu_clk.common,
> +	&hdmi_24M_clk.common,
> +	&hdmi_cec_32k_clk.common,
> +	&hdmi_cec_clk.common,
> +	&mipi_dsi0_clk.common,
> +	&mipi_dsi1_clk.common,
> +	&tcon_lcd0_clk.common,
> +	&tcon_lcd1_clk.common,
> +	&tcon_tv0_clk.common,
> +	&tcon_tv1_clk.common,
> +	&edp_clk.common,
>  };
> =20
>  static struct clk_hw_onecell_data sun55i_a523_hw_clks =3D {
> @@ -442,6 +644,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clk=
s =3D {
>  		[CLK_AHB]		=3D &ahb_clk.common.hw,
>  		[CLK_APB0]		=3D &apb0_clk.common.hw,
>  		[CLK_APB1]		=3D &apb1_clk.common.hw,
> +		[CLK_DE]		=3D &de_clk.common.hw,
> +		[CLK_DI]		=3D &di_clk.common.hw,
> +		[CLK_G2D]		=3D &g2d_clk.common.hw,
> +		[CLK_GPU]		=3D &gpu_clk.common.hw,
> +		[CLK_VE]		=3D &ve_clk.common.hw,
> +		[CLK_HDMI_24M]		=3D &hdmi_24M_clk.common.hw,
> +		[CLK_HDMI_CEC_32K]	=3D &hdmi_cec_32k_clk.common.hw,
> +		[CLK_HDMI_CEC]		=3D &hdmi_cec_clk.common.hw,
> +		[CLK_MIPI_DSI0]		=3D &mipi_dsi0_clk.common.hw,
> +		[CLK_MIPI_DSI1]		=3D &mipi_dsi1_clk.common.hw,
> +		[CLK_TCON_LCD0]		=3D &tcon_lcd0_clk.common.hw,
> +		[CLK_TCON_LCD1]		=3D &tcon_lcd1_clk.common.hw,
> +		[CLK_COMBOPHY_DSI0]	=3D &combophy_dsi0_clk.common.hw,
> +		[CLK_COMBOPHY_DSI1]	=3D &combophy_dsi1_clk.common.hw,
> +		[CLK_TCON_TV0]		=3D &tcon_tv0_clk.common.hw,
> +		[CLK_TCON_TV1]		=3D &tcon_tv1_clk.common.hw,
> +		[CLK_EDP]		=3D &edp_clk.common.hw,
>  	},
>  };
> =20
>=20





