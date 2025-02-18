Return-Path: <linux-kernel+bounces-520264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD82A3A7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D10C1893C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F27E1E832F;
	Tue, 18 Feb 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYE+2+/M"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49121B9FF;
	Tue, 18 Feb 2025 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907272; cv=none; b=u+egnL/CQ0YmGv0dnZWpMsY7GdHyasWmOU2Bblapmj747CW1ITpmBp127ROVGDS7NKNx/2bh2GPxobSfFQyosu9atujTOF/b3DSy7RzC4ts1e92I5yMyFlFiq1vKhfFjU/qi3PwgLuzO8Ho6HztdP1yrN+CGGg0blwQ5QzwO0dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907272; c=relaxed/simple;
	bh=XpdxWtbPVdttjjFUzx7iWumLAQqfWDFPCPVSBttJSkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1vJQ42Gu/YhBw+8atcby5aImWgxaDbTIi8C8/wnDeT8jOeTaO+KTrllZYOnvpEKL611G8CJ8+883u9V4vFLu+caMIUXHnaTal26HtMhKgkiot7FfCqB6w4NwXS6ArzWy+kWp2OAxCykeVZKWR2pP84z1hUU6ZT8ZKhgHXHUIGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYE+2+/M; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2c4382d1so83548f8f.0;
        Tue, 18 Feb 2025 11:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907269; x=1740512069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gRRVw/AYria41MhrePKHErpkPl6lNG66+LegsVr3z4=;
        b=EYE+2+/M8DaZ7dWRg6VqW1n7DQQI1RhEfDrlAs6yoCWVZXkjpJaHwYRLhMlAMJarLb
         BZ6uQ0i1sn3Lyz2S91OY7eVxqazt08XvvAZNlBEX2k9GWqRoPb2DcqvWoWsqQcC/xyR3
         ygjtrwdiXXyZxukOFDoYt7C3q5n9/Km7B8Bux+1XOdpb7ROkb0r1CB3ocuZ4Gqr6Q8Tc
         FVlPVvMF+icMCeQLDWbWE9C5FSOKfpkeXumN1gE7tFkGwq+c/qi9eaB1eC8yTB2lpjFm
         1+WiH9ATCw9zNBVe3n3xlDUQblNjCF6wqJk9lPTdiPDJiHfOwH46OU8835NXMz+iyD0D
         GWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907269; x=1740512069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gRRVw/AYria41MhrePKHErpkPl6lNG66+LegsVr3z4=;
        b=SNrelq6NTFihwnKRSheXqtxrOZS1OqxQlJTkTUMZBatYiUv7pIIQoChny20nUSvul2
         Dix1+nLtiO0H3W1LBnUXQADJt8p/HBtHmcgprPvIvvAhVL6jQZ3uLHUGydbKHE4eVAb1
         MvyZrX+ozW3Yh/uPleDoiZuvWCqp4lnaQXDcWeh7fYZ3Ik25zPU/TMKtoa/l+V7GMi2h
         FmxGZnA+O7ZqaO8a9jJFPBjwSGKXtpphBO8aGFRPfIdFoOZFXgLKlhfwZIE6dbFq41Uu
         dpcAeBqvxq9x468GTvTxPN3/S3S7+mkLdyCqthKCwHKpoSJawLbi+IdSoJbd9ZSj6Iyo
         g6aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhb6gwcguXP4dPUbQhvq8JAsGAkt4FHS04ULnYaEydY4HvHghxPi0bxsTXA1uLNpHPUgGaVyccmPpM@vger.kernel.org, AJvYcCWKsFAu0Tk8PQTG5B4NC6FHVlidUOmuslRjdWxNDrMouZdU0KrO8zv9Pj+C9vStKjy/bsmHLUwvLQ29@vger.kernel.org, AJvYcCXiEmwzgDEScwXPdCb53rDGib4hZ0x35f4og8u00f7saCf6pYgmvOB+OZpiGtVJsh6/349xAfLLgpGSlH8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwteR9fuB9Xf06/Vl/gogVuS744eAmDD8zvToa3+wzO7H4uQIYm
	/fh6rEemfDyJIEHhoDpNN9e2W/n1AexwedvQAEJ+BtCjR2eqj+gZ
X-Gm-Gg: ASbGnctHZv435Qwznn516/1A8iiaA5YPhsVAOuJbijo4L5sKYG9WCE4beAK+Eg/ee9e
	yge3Fx5wc0Jjgyx9u1Wyj8PmgmVckTuySlOEqNrkSwIJKzc5sk8mhWP5xlUV0k3lTJS2sV6eDcH
	Ip2caPrdAYMZHt8k8PPeCgXhaxllcN+uG89stH8nlrujLjVuxCQxxkQ0i8iN+vgtxAxod1nisN/
	0RxYapGJkN/2TWiShXZFpvzG/J3tFf+N6kb9L3o1u1dNCeAnIL4t8pxVc5Smx8xmzuRVOBQZwFO
	PywZRrwmlyWCs0DeNo8tkBCilAc3/mV/fB6jYzvzsAEed4e02ymTLQLY+6X/5OjyFHU=
X-Google-Smtp-Source: AGHT+IGHKwaqjonh642GsOxeyKxdsH5z+YsnUDWLjShcZ4A8R92dFADuYUyWrKyixAcIuk0C7ZZGNw==
X-Received: by 2002:a05:6000:1fa7:b0:38f:3ec3:4801 with SMTP id ffacd0b85a97d-38f57d94f86mr1020714f8f.25.1739907268627;
        Tue, 18 Feb 2025 11:34:28 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f85c2sm16339601f8f.91.2025.02.18.11.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:34:28 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/15] clk: sunxi-ng: a523: add system mod clocks
Date: Tue, 18 Feb 2025 20:34:27 +0100
Message-ID: <2013031.usQuhbGJ8B@jernej-laptop>
In-Reply-To: <20250214125359.5204-9-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-9-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:52 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the clocks driving some core system related subsystems of the SoC:
> the "CE" crypto engine, the high speed timers, the DRAM and the associated
> MBUS clock, and the PCIe clock.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 119 +++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.c
> index 0ef1fd71a1ca5..b68c44bce825f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -423,6 +423,18 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu", =
gpu_parents, 0x670,
>  				    BIT(31),	/* gate */
>  				    0);
> =20
> +static const struct clk_parent_data ce_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph0_480M_clk.common.hw },
> +	{ .hw =3D &pll_periph0_400M_clk.hw },
> +	{ .hw =3D &pll_periph0_300M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
> +				       0, 5,	/* M */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +
>  static const struct clk_hw *ve_parents[] =3D {
>  	&pll_ve_clk.common.hw,
>  	&pll_periph0_480M_clk.common.hw,
> @@ -435,6 +447,65 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve=
_parents, 0x690,
>  				    BIT(31),	/* gate */
>  				    CLK_SET_RATE_PARENT);
> =20
> +static const struct clk_parent_data hstimer_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .hw =3D &pll_periph0_200M_clk.hw },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer0_clk, "hstimer0",
> +				       hstimer_parents, 0x730,
> +				       0, 0,	/* M */
> +				       0, 3,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_SET_RATE_PARENT);

CLK_SET_RATE_PARENT doesn't make much sense for fixed clocks.

> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer1_clk, "hstimer1",
> +				       hstimer_parents,
> +				       0x734,
> +				       0, 0,	/* M */
> +				       0, 3,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer2_clk, "hstimer2",
> +				       hstimer_parents,
> +				       0x738,
> +				       0, 0,	/* M */
> +				       0, 3,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer3_clk, "hstimer3",
> +				       hstimer_parents,
> +				       0x73c,
> +				       0, 0,	/* M */
> +				       0, 3,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer4_clk, "hstimer4",
> +				       hstimer_parents,
> +				       0x740,
> +				       0, 0,	/* M */
> +				       0, 3,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_SET_RATE_PARENT);
> +
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer5_clk, "hstimer5",
> +				       hstimer_parents,
> +				       0x744,
> +				       0, 0,	/* M */
> +				       0, 3,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       CLK_SET_RATE_PARENT);
> +
>  static const struct clk_parent_data iommu_parents[] =3D {
>  	{ .hw =3D &pll_periph0_600M_clk.hw },
>  	{ .hw =3D &pll_ddr0_clk.common.hw },
> @@ -450,6 +521,34 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(iommu_clk, "io=
mmu", iommu_parents, 0x7b0,
>  				      BIT(31),	/* gate */
>  				      CLK_SET_RATE_PARENT);
> =20
> +static const struct clk_hw *dram_parents[] =3D {
> +	&pll_ddr0_clk.common.hw,
> +	&pll_periph0_600M_clk.hw,
> +	&pll_periph0_480M_clk.common.hw,
> +	&pll_periph0_400M_clk.hw,
> +	&pll_periph0_150M_clk.hw,
> +};
> +static SUNXI_CCU_M_HW_WITH_MUX_GATE(dram_clk, "dram", dram_parents, 0x80=
0,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    CLK_IS_CRITICAL);

Same comment as for IOMMU clock. Update bit is needed to actually apply con=
figuration.

Best regards,
Jernej

> +
> +static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
> +			   &dram_clk.common.hw, 4, 1, 0);
> +
> +static const struct clk_parent_data losc_hosc_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(pcie_aux_clk, "pcie-aux",
> +				      losc_hosc_parents, 0xaa0,
> +				      0, 5,	/* M */
> +				      24, 1,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
>  static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, BIT(=
31), 0);
> =20
>  /* TODO: add mux between 32kOSC and PERIPH0/18750 */
> @@ -584,8 +683,17 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =3D=
 {
>  	&di_clk.common,
>  	&g2d_clk.common,
>  	&gpu_clk.common,
> +	&ce_clk.common,
>  	&ve_clk.common,
> +	&hstimer0_clk.common,
> +	&hstimer1_clk.common,
> +	&hstimer2_clk.common,
> +	&hstimer3_clk.common,
> +	&hstimer4_clk.common,
> +	&hstimer5_clk.common,
>  	&iommu_clk.common,
> +	&dram_clk.common,
> +	&pcie_aux_clk.common,
>  	&hdmi_24M_clk.common,
>  	&hdmi_cec_32k_clk.common,
>  	&hdmi_cec_clk.common,
> @@ -644,11 +752,22 @@ static struct clk_hw_onecell_data sun55i_a523_hw_cl=
ks =3D {
>  		[CLK_AHB]		=3D &ahb_clk.common.hw,
>  		[CLK_APB0]		=3D &apb0_clk.common.hw,
>  		[CLK_APB1]		=3D &apb1_clk.common.hw,
> +		[CLK_MBUS]		=3D &mbus_clk.hw,
>  		[CLK_DE]		=3D &de_clk.common.hw,
>  		[CLK_DI]		=3D &di_clk.common.hw,
>  		[CLK_G2D]		=3D &g2d_clk.common.hw,
>  		[CLK_GPU]		=3D &gpu_clk.common.hw,
> +		[CLK_CE]		=3D &ce_clk.common.hw,
>  		[CLK_VE]		=3D &ve_clk.common.hw,
> +		[CLK_HSTIMER0]		=3D &hstimer0_clk.common.hw,
> +		[CLK_HSTIMER1]		=3D &hstimer1_clk.common.hw,
> +		[CLK_HSTIMER2]		=3D &hstimer2_clk.common.hw,
> +		[CLK_HSTIMER3]		=3D &hstimer3_clk.common.hw,
> +		[CLK_HSTIMER4]		=3D &hstimer4_clk.common.hw,
> +		[CLK_HSTIMER5]		=3D &hstimer5_clk.common.hw,
> +		[CLK_IOMMU]		=3D &iommu_clk.common.hw,
> +		[CLK_DRAM]		=3D &dram_clk.common.hw,
> +		[CLK_PCIE_AUX]		=3D &pcie_aux_clk.common.hw,
>  		[CLK_HDMI_24M]		=3D &hdmi_24M_clk.common.hw,
>  		[CLK_HDMI_CEC_32K]	=3D &hdmi_cec_32k_clk.common.hw,
>  		[CLK_HDMI_CEC]		=3D &hdmi_cec_clk.common.hw,
>=20





