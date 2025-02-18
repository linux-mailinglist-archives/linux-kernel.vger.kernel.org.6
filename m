Return-Path: <linux-kernel+bounces-520278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2004A3A7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3243418954DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63551E8331;
	Tue, 18 Feb 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd5YEMk6"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290401E835D;
	Tue, 18 Feb 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907774; cv=none; b=rjeZtyepyXNQ1Sdx6K+sjvhQcDIpjr/wocL34pUPlUOuk2ng3LoZNr9yAmBGGmqP7Bs0aedPDudAcoJhqrWD8+cbpqfSUmG/MBXb4P+jSTEg5rfS94GTMsSCwQcTAxErrUGqUIwLw63cVhqo+kYujf+zB8vamqsqBbexpg13gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907774; c=relaxed/simple;
	bh=JVDAb2/wbhF3ydZ1Jo4lZCTcWIRQXA3iNvferXgyxx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXRzQeTAC9swoAxZVTMFt5a6YnaGwVgl0mL0QytubvqRcW/30jl3oeXb0IDfMsoC6HNsvxfcnYDcrQX4F9bxrJVmmdwXX54Gn9aA5FzYBh82GzvTeonVzHQjHWGhWjD74qCWohALleb5TDQ/mTDUoTwfS+isWk87s1KD/Tx7dS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd5YEMk6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso23490445e9.2;
        Tue, 18 Feb 2025 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739907770; x=1740512570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl7U1zRTmSliSaba3R9gS9qlysQX6pYP+zWE+Yu6Uvk=;
        b=Vd5YEMk6h3xcZuR6m585JR5fXrKw/8c7ziOnl18SjzX1gV9UpMMoASyHAzwED+5zIB
         QAMYRPzK8Ubrze8KWjuN9mMZFBm45Lwa/+YfRoXrSroyxNY4GQ1AUjXt7rJ84/u8PzDM
         xNmxGbik/C4zGljUXeCcuwZGmb81sNVoyR+6DLdTQOf5ZTUSEkn8v1rDllUAqS5HS2D6
         2VwjIsQtcKn1+dSg4DulH4E4/HnQK+UI9PyRZY6CXuKmuC90fBszER15LejXUm1lVM6T
         0XRAQ5BBKtRAuib6CXeG4cmGZP7AjZzveqxXmwVCALTzv7VqBtGsNglKhGLQAwxYOkKz
         hjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907770; x=1740512570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl7U1zRTmSliSaba3R9gS9qlysQX6pYP+zWE+Yu6Uvk=;
        b=EJcsTHTrPVPdJqP2FY57rptjT4jx6QTjNC34rv2OE45htRY2ZU8b4gze4d7EEzOPRG
         njsoRe+n/+OvPA9cHyiwUfm9R8oJIXuTJDfJgzHrIvMQsi/vDuh6zUzU1PSXOrZO/uaC
         KBigVxy8LGBalTgCYvgF7036bVP7imB1zYo6ptorh9mGa+KJFTHIoTtqMFHJlVoLG35W
         TlXwH65eFRTDcSZVWlH9nwQ63lX3bs2c6/LL3K1Ep5bgCuKEaxnMvSTptiol7Vsdx+VH
         2FlzT2Inehm1T4VfI7XyLLnAEoTSiDTwFIpZme0PTxTrTDzd/k/YEPk1j+YajcI9wnvY
         jehw==
X-Forwarded-Encrypted: i=1; AJvYcCUN7T5Hv4MvAQI0N3D5wdPGBfJd2ok+ygDCIUKU8gSrcaNjL7ElC0gecaF3ULCh/R1hzXDxpR8E8FijTnTa@vger.kernel.org, AJvYcCVFuYfphm1Kg9msWIS0VmrwBhNSxvcj/Kbz4yubhdxR8aph7xJp2EfmkkaiMjElUelTQcGBPjJH3jyP@vger.kernel.org, AJvYcCXmzqtRaMYhgRRRMYQDRIIvHIJ0fjzkfJoG3g84ite3o8opXyxHr5wW7V35j7j4ulsWrd+3wr6KSKGN@vger.kernel.org
X-Gm-Message-State: AOJu0YxPy8cgsqU2sFUx1qv3inaXu7m09cRAH73HU9ndtFlROYIvTBX/
	lZu2Jhrk6+LGWR9lyE/jjN7jPt9cFgxlpJ46/0K2j8t5JdE4obtN
X-Gm-Gg: ASbGncuGP+6wwLakjdI/blGrjJdlgs+lWFsP+9V3p4Xsl8oXb4hKvHMYUIyCa4AIHGA
	eFUHId2+fKmwKYuwQzm+CsOBJzCWR7LVQ4oFa1Cl6MsYY4WZMEo1Xm4x93fqiB3GOyvXnA9r+8O
	kTRGXe1h6g2WyvEX2ubPNdq2qpR23KTQ9cbkhpJ4BmWtXX08pXJoJKrHFEifGob5iy8JbPWK7V3
	Ll7Iu9NxdqSVTmgXVv/IPnJZ45Q8XCcRzMORRSz3z2GX9k79nZ6EM5rh7sUk5e4s0mifK27dtgI
	Spzx7B8bLIUlMDgEi0tdCo5W4kA3mAV0GhDhCn4f7PvheMpDDkZ+Nu1JxdXCY9MMszw=
X-Google-Smtp-Source: AGHT+IGUZTP9Mx+RmuM36MdYWx5EMbKHtaqxdPPdwHgNaovkF0uIkKf3zl23uWEwqGtbHZ3m2biocA==
X-Received: by 2002:a05:6000:1785:b0:38d:d6ef:f8 with SMTP id ffacd0b85a97d-38f33f38d23mr16417610f8f.30.1739907770231;
        Tue, 18 Feb 2025 11:42:50 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398937341csm54963525e9.24.2025.02.18.11.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:42:49 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] clk: sunxi-ng: a523: add interface mod clocks
Date: Tue, 18 Feb 2025 20:42:48 +0100
Message-ID: <2641802.Lt9SDvczpP@jernej-laptop>
In-Reply-To: <20250214125359.5204-10-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-10-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:53 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the clocks driving what the user manual summarises under "interface"
> devices: raw NAND flash, MMC, SPI, EMAC, "IR" infrared, and the "GPADC"
> general purpose analogue/digital converter.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 160 +++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.c
> index b68c44bce825f..14d13fb16dfbb 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -113,6 +113,9 @@ static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pl=
l-periph0-150M",
>  			    pll_periph0_2x_hws, 8, 1, 0);
>  static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
>  			    pll_periph0_480M_hws, 3, 1, 0);
> +static const struct clk_hw *pll_periph0_150M_hws[] =3D {
> +	&pll_periph0_150M_clk.hw
> +};
> =20
>  #define SUN55I_A523_PLL_PERIPH1_REG	0x028
>  static struct ccu_nm pll_periph1_4x_clk =3D {
> @@ -537,6 +540,133 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dram_clk, "dram=
", dram_parents, 0x800,
>  static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
>  			   &dram_clk.common.hw, 4, 1, 0);
> =20
> +static const struct clk_parent_data nand_mmc_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph0_400M_clk.hw },
> +	{ .hw =3D &pll_periph0_300M_clk.hw },
> +	{ .hw =3D &pll_periph1_400M_clk.hw },
> +	{ .hw =3D &pll_periph1_300M_clk.hw },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk, "nand0", nand_mmc_paren=
ts,
> +				    0x810,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand1_clk, "nand1", nand_mmc_paren=
ts,
> +				    0x814,
> +				    0, 5,	/* M */
> +				    24, 3,	/* mux */
> +				    BIT(31),	/* gate */
> +				    0);
> +
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc0_clk, "mmc0", nand_mmc_par=
ents,
> +					   0x830,
> +					   0, 5,	/* M */
> +					   8, 5,	/* P */
> +					   24, 3,	/* mux */
> +					   BIT(31),	/* gate */
> +					   2,		/* post div */
> +					   0, CCU_FEATURE_DUAL_DIV);
> +
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc1_clk, "mmc1", nand_mmc_par=
ents,
> +					   0x834,
> +					   0, 5,	/* M */
> +					   8, 5,	/* P */
> +					   24, 3,	/* mux */
> +					   BIT(31),	/* gate */
> +					   2,		/* post div */
> +					   0, CCU_FEATURE_DUAL_DIV);
> +
> +static const struct clk_parent_data mmc2_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph0_800M_clk.common.hw },
> +	{ .hw =3D &pll_periph0_600M_clk.hw },
> +	{ .hw =3D &pll_periph1_800M_clk.common.hw },
> +	{ .hw =3D &pll_periph1_600M_clk.hw },
> +};
> +
> +static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc2_clk, "mmc2", mmc2_parents,
> +					   0x838,
> +					   0, 5,	/* M */
> +					   8, 5,	/* P */
> +					   24, 3,	/* mux */
> +					   BIT(31),	/* gate */
> +					   2,		/* post div */
> +					   0, CCU_FEATURE_DUAL_DIV);
> +
> +static const struct clk_parent_data spi_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph0_300M_clk.hw },
> +	{ .hw =3D &pll_periph0_200M_clk.hw },
> +	{ .hw =3D &pll_periph1_300M_clk.hw },
> +	{ .hw =3D &pll_periph1_200M_clk.hw },
> +};
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi0_clk, "spi0", spi_parents, 0x=
940,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi1_clk, "spi1", spi_parents, 0x=
944,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi2_clk, "spi2", spi_parents, 0x=
948,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);
> +static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spifc_clk, "spifc", nand_mmc_pare=
nts,
> +				       0x950,
> +				       0, 5,	/* M */
> +				       8, 5,	/* P */
> +				       24, 3,	/* mux */
> +				       BIT(31),	/* gate */
> +				       0);

Missing CCU_FEATURE_DUAL_DIV flag.

Best regards,
Jernej

> +
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_clk, "emac0-25M",
> +				      pll_periph0_150M_hws,
> +				      0x970, BIT(31) | BIT(30), 6, 0);
> +static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac1_25M_clk, "emac1-25M",
> +				      pll_periph0_150M_hws,
> +				      0x974, BIT(31) | BIT(30), 6, 0);
> +
> +static const struct clk_parent_data ir_rx_parents[] =3D {
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "hosc" },
> +};
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_rx_clk, "ir-rx", ir_rx_parents,=
 0x990,
> +				      0, 5,	/* M */
> +				      24, 1,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +static const struct clk_parent_data ir_tx_ledc_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .hw =3D &pll_periph1_600M_clk.hw },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_tx_clk, "ir-tx", ir_tx_ledc_par=
ents,
> +				      0x9c0,
> +				      0, 5,	/* M */
> +				      24, 1,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +
> +static SUNXI_CCU_M_WITH_GATE(gpadc0_clk, "gpadc0", "hosc", 0x9e0,
> +				 0, 5,		/* M */
> +				 BIT(31),	/* gate */
> +				 0);
> +static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1", "hosc", 0x9e4,
> +				 0, 5,		/* M */
> +				 BIT(31),	/* gate */
> +				 0);
> +
>  static const struct clk_parent_data losc_hosc_parents[] =3D {
>  	{ .fw_name =3D "hosc" },
>  	{ .fw_name =3D "losc" },
> @@ -693,6 +823,21 @@ static struct ccu_common *sun55i_a523_ccu_clks[] =3D=
 {
>  	&hstimer5_clk.common,
>  	&iommu_clk.common,
>  	&dram_clk.common,
> +	&nand0_clk.common,
> +	&nand1_clk.common,
> +	&mmc0_clk.common,
> +	&mmc1_clk.common,
> +	&mmc2_clk.common,
> +	&spi0_clk.common,
> +	&spi1_clk.common,
> +	&spi2_clk.common,
> +	&spifc_clk.common,
> +	&emac0_25M_clk.common,
> +	&emac1_25M_clk.common,
> +	&ir_rx_clk.common,
> +	&ir_tx_clk.common,
> +	&gpadc0_clk.common,
> +	&gpadc1_clk.common,
>  	&pcie_aux_clk.common,
>  	&hdmi_24M_clk.common,
>  	&hdmi_cec_32k_clk.common,
> @@ -767,6 +912,21 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clk=
s =3D {
>  		[CLK_HSTIMER5]		=3D &hstimer5_clk.common.hw,
>  		[CLK_IOMMU]		=3D &iommu_clk.common.hw,
>  		[CLK_DRAM]		=3D &dram_clk.common.hw,
> +		[CLK_NAND0]		=3D &nand0_clk.common.hw,
> +		[CLK_NAND1]		=3D &nand1_clk.common.hw,
> +		[CLK_MMC0]		=3D &mmc0_clk.common.hw,
> +		[CLK_MMC1]		=3D &mmc1_clk.common.hw,
> +		[CLK_MMC2]		=3D &mmc2_clk.common.hw,
> +		[CLK_SPI0]		=3D &spi0_clk.common.hw,
> +		[CLK_SPI1]		=3D &spi1_clk.common.hw,
> +		[CLK_SPI2]		=3D &spi2_clk.common.hw,
> +		[CLK_SPIFC]		=3D &spifc_clk.common.hw,
> +		[CLK_EMAC0_25M]		=3D &emac0_25M_clk.common.hw,
> +		[CLK_EMAC1_25M]		=3D &emac1_25M_clk.common.hw,
> +		[CLK_IR_RX]		=3D &ir_rx_clk.common.hw,
> +		[CLK_IR_TX]		=3D &ir_tx_clk.common.hw,
> +		[CLK_GPADC0]		=3D &gpadc0_clk.common.hw,
> +		[CLK_GPADC1]		=3D &gpadc1_clk.common.hw,
>  		[CLK_PCIE_AUX]		=3D &pcie_aux_clk.common.hw,
>  		[CLK_HDMI_24M]		=3D &hdmi_24M_clk.common.hw,
>  		[CLK_HDMI_CEC_32K]	=3D &hdmi_cec_32k_clk.common.hw,
>=20





