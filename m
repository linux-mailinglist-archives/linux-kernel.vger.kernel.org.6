Return-Path: <linux-kernel+bounces-520186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250CA3A6C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E6916DADE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84421E5202;
	Tue, 18 Feb 2025 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4r8PxaF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85A21E51EB;
	Tue, 18 Feb 2025 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905425; cv=none; b=nwU5tvjznVns+J79pYxcrZQX49UoXfMIrHA6NEARnxeMnlgccvndUOz++UhzbDzJh6GyJ8ePaYKmId0rZem3hwfTsIJqGYgTZ5K0zePahQhPVk3lj6/PEj86UO213pJdghAZjfuhTTXBC6u++DuZejBm8jKcCjLq8+RemjhyQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905425; c=relaxed/simple;
	bh=oBYQOEdZSopDkyC0eH0MUxrHnbquEHRnvWMJi240CaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py22IwmrZDmGtIzGVJYXnp+IEX1S4KIR0cqsSpZVNWDxDqTRvFzfA3CNz28C6mLw4vzfSKqEAzNJ5KIPNWDzozXULGLfH4d/pGiFpooIT3BUR+MDN/baNxSTFenaaOX/LB1RCrkBXWbmOsSVFZSkwEvTOTSyBl5BtIakYGIe8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4r8PxaF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f403edb4eso1425059f8f.3;
        Tue, 18 Feb 2025 11:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905421; x=1740510221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xX3kq5JvtA7OeDpyDSylJ4c5w3/7hfTbTKchcblIZk=;
        b=O4r8PxaFsVQftQpUcTgxpllaUc2eODNN2HkekmO1bdSKtXIXPYtsBI/9VET2NRRmly
         n1/K48pGD5rEdQV4RkpD/4eZURbBpJPS+GIyGMA8IiY5LzAFBLz9mJgY2hyw/+RczmID
         Gf1DaGWXrwbrj8QM1SaH9VRNqx/RBFSzNTVRHDVc5orVd2xH7ZSAJpBQ6wOwHDRyC9SC
         xLu8T2G1D49aV4bvZFznMYcVur9v3Y5dEuKCbSF8UyV6pic9Ux3kjukWm8F7+TwkXPpm
         j9ZL5TVZlBj+LgFHJiLMLUZKnCkWD2luKEQKa4kyrygIxZPf+YbWwogYO58HT8fMK3gy
         j3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905421; x=1740510221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xX3kq5JvtA7OeDpyDSylJ4c5w3/7hfTbTKchcblIZk=;
        b=ErMpH2eyV47itkQkSkSbW9vtCgfoKdj3qjlO+1S2eWqGvWAlLirBo93RFSuoAPmJKZ
         U4H4suK6eNq2SZfDpUDpjhZgZqG+XbhX2/g/WOm3mP5Qd4OagcupmDxBGmtOklIUE0Dv
         kQzuTXZS5G8ANXUcncjnztRAGIHinv6Ycb8ZKNimnA2c7KT9CJkFF8TVcos5Ml1Cuoku
         WhGMW2T1qJSYp5bwQtGmyi+pOyFuTWkNhwQHEcETrC441SYRNg/Us8b+Fauhy+8nMrNq
         wMbwHhweCfyDNdJX68Y1G//i+srXLyKZVUGhkdXgylzfxQ6otOaWPUEpbPpKkAZNVFnS
         DylQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfdl5T41GrFG3W3S1OMykxzGuxAjCypvX3445ZoDBss9hSo84RZHen8Yi/9CbwUcGxU9WLN6h7gt7UzB7h@vger.kernel.org, AJvYcCV4xFHplUfElmTEG5rAMMHalT2Cy4tCMLM3R+XagfgXSEs2k/yXqxOvYRjkE1kf/j9mOoKt0bu/N6nm@vger.kernel.org, AJvYcCWK8BrtoupkS73r+jlw7aV+4SybsunBgweu1vg9iRqwCjn7Yyazu/nMaVS5w9K/Qw0TKgJt/OjIGDAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMqlvPWSPEhVyxp3Ypqi4UBaM8hD1PtSMfiJrV8ySZc2M+VxS
	+CQA/EC7Hf6K0dl6901/p/gJz8vMOzkh2dqVWGJDj4ilc64kCPAl
X-Gm-Gg: ASbGncul4iXE1t43DPqB4HRP2+DqdrPkQFwGXx8DcyXWT+ukTLCN7zp2bQBpn7miKOb
	Y0Pk5GC1TUIrcPJZpT1SH+LacVMSZTFwJpZQrAjXbBdqELxI18j0JEU6vtIEEMsurD1Kk6/QDai
	B5fwwc7kKg4vmwxUTI4VCorL2q8wh/swtv62cMxgoN3VV6SXq43N8d7wcKf/HKxbBxH5yeo8AXK
	pHY0HvnVddbt16NvWqmzWAZO69Z4RBs0ZFWfx1KPAWaY5kZMOYWPBUrnbT11thsFmcHvUN+jLmJ
	06k+N7q8hmPxs0KAlWtrIzp2BcVG7Y1L0a0TZ14A6qYAuuadhXLnXlgZHZykteoYXWc=
X-Google-Smtp-Source: AGHT+IF3HT55ekDkhr32GRf+62rUW7oCIzdAfVXnR6+5oIboF7j4xk2JD2Jn2rS7V1hPPEm1Kdvy5w==
X-Received: by 2002:a5d:64e8:0:b0:38f:4308:e552 with SMTP id ffacd0b85a97d-38f4308ea65mr9293257f8f.14.1739905420661;
        Tue, 18 Feb 2025 11:03:40 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm16008425f8f.64.2025.02.18.11.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:03:40 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 05/15] clk: sunxi-ng: Add support for the A523/T527 CCU PLLs
Date: Tue, 18 Feb 2025 20:03:38 +0100
Message-ID: <3341127.44csPzL39Z@jernej-laptop>
In-Reply-To: <20250214125359.5204-6-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:49 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the PLL clocks of the main CCU of the Allwinner A523 and T527 SoCs.
> The clocks were modelled after the A523 and T527 manual, and double
> checked by writing all 1's into the respective register, to spot all
> implemented bits.
>=20
> The PLL and mod clocks for the two CPU clusters and the DSU are part of
> a separate CCU, also most audio clocks are collected in a DSP CCU, so
> both of these clock groups are missing from this driver.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig           |   5 +
>  drivers/clk/sunxi-ng/Makefile          |   2 +
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 481 +++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun55i-a523.h |  14 +
>  drivers/clk/sunxi-ng/ccu_mp.h          |  14 +-
>  5 files changed, 510 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h
>=20
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index b547198a2c654..04efbda847cf9 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -52,6 +52,11 @@ config SUN50I_H6_R_CCU
>  	default y
>  	depends on ARM64 || COMPILE_TEST
> =20
> +config SUN55I_A523_CCU
> +	tristate "Support for the Allwinner A523/T527 CCU"
> +	default y
> +	depends on ARM64 || COMPILE_TEST
> +
>  config SUN4I_A10_CCU
>  	tristate "Support for the Allwinner A10/A20 CCU"
>  	default y
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 6b3ae2b620db6..01a887f7824bb 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+=3D sun50i-a100-r-ccu.o
>  obj-$(CONFIG_SUN50I_H6_CCU)	+=3D sun50i-h6-ccu.o
>  obj-$(CONFIG_SUN50I_H6_R_CCU)	+=3D sun50i-h6-r-ccu.o
>  obj-$(CONFIG_SUN50I_H616_CCU)	+=3D sun50i-h616-ccu.o
> +obj-$(CONFIG_SUN55I_A523_CCU)	+=3D sun55i-a523-ccu.o
>  obj-$(CONFIG_SUN4I_A10_CCU)	+=3D sun4i-a10-ccu.o
>  obj-$(CONFIG_SUN5I_CCU)		+=3D sun5i-ccu.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+=3D sun6i-a31-ccu.o
> @@ -58,6 +59,7 @@ sun50i-a100-r-ccu-y		+=3D ccu-sun50i-a100-r.o
>  sun50i-h6-ccu-y			+=3D ccu-sun50i-h6.o
>  sun50i-h6-r-ccu-y		+=3D ccu-sun50i-h6-r.o
>  sun50i-h616-ccu-y		+=3D ccu-sun50i-h616.o
> +sun55i-a523-ccu-y		+=3D ccu-sun55i-a523.o
>  sun4i-a10-ccu-y			+=3D ccu-sun4i-a10.o
>  sun5i-ccu-y			+=3D ccu-sun5i.o
>  sun6i-a31-ccu-y			+=3D ccu-sun6i-a31.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.c
> new file mode 100644
> index 0000000000000..8374e841e9d82
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
> @@ -0,0 +1,481 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Arm Ltd.
> + * Based on the D1 CCU driver:
> + *   Copyright (c) 2020 huangzhenwei@allwinnertech.com
> + *   Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "../clk.h"
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +
> +#include "ccu-sun55i-a523.h"
> +
> +/*
> + * The 24 MHz oscillator, the root of most of the clock tree.
> + * .fw_name is the string used in the DT "clock-names" property, used to
> + * identify the corresponding clock in the "clocks" property.
> + */
> +static const struct clk_parent_data osc24M[] =3D {
> +	{ .fw_name =3D "hosc" }
> +};
> +
> +/***********************************************************************=
***
> + *                              PLLs                                    =
  *
> + ***********************************************************************=
***/
> +
> +/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
> +#define SUN55I_A523_PLL_DDR0_REG		0x010
> +static struct ccu_nkmp pll_ddr0_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */

Newer manuals, for example A523 manual v1.4, don't mention input dividers a=
nymore.
Newer BSP driver doesn't have them either. Should we drop them (for all PLL=
s)?

> +	.p		=3D _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		=3D {
> +		.reg		=3D 0x010,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-ddr0", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_GATE |
> +							   CLK_IS_CRITICAL),
> +	},
> +};
> +
> +/*
> + * There is no actual clock output with that frequency (2.4 GHz), instea=
d it
> + * has multiple outputs with adjustable dividers from that base frequenc=
y.
> + * Model them separately as divider clocks based on that parent here.
> + */
> +#define SUN55I_A523_PLL_PERIPH0_REG	0x020
> +static struct ccu_nm pll_periph0_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x020,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-periph0-4x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +/*
> + * Most clock-defining macros expect an *array* of parent clocks, even if
> + * they do not contain a muxer to select between different parents.
> + * The macros ending in just _HW take a simple clock pointer, but then c=
reate
> + * a single-entry array out of that. The macros using _HWS take such an
> + * array (even when it is a single entry one), this avoids having those
> + * helper arrays created inside *every* clock definition.
> + * This means for every clock that is referenced more than once it is
> + * useful to create such a dummy array and use _HWS.
> + */
> +static const struct clk_hw *pll_periph0_4x_hws[] =3D {
> +	&pll_periph0_4x_clk.common.hw
> +};
> +
> +static SUNXI_CCU_M_HWS(pll_periph0_2x_clk, "pll-periph0-2x",
> +		       pll_periph0_4x_hws, 0x020, 16, 3, 0);
> +static const struct clk_hw *pll_periph0_2x_hws[] =3D {
> +	&pll_periph0_2x_clk.common.hw
> +};
> +static SUNXI_CCU_M_HWS(pll_periph0_800M_clk, "pll-periph0-800M",
> +		       pll_periph0_4x_hws, 0x020, 20, 3, 0);
> +static SUNXI_CCU_M_HWS(pll_periph0_480M_clk, "pll-periph0-480M",
> +		       pll_periph0_4x_hws, 0x020, 2, 3, 0);
> +static const struct clk_hw *pll_periph0_480M_hws[] =3D {
> +	&pll_periph0_480M_clk.common.hw
> +};
> +static CLK_FIXED_FACTOR_HWS(pll_periph0_600M_clk, "pll-periph0-600M",
> +			    pll_periph0_2x_hws, 2, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph0_400M_clk, "pll-periph0-400M",
> +			    pll_periph0_2x_hws, 3, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph0_300M_clk, "pll-periph0-300M",
> +			    pll_periph0_2x_hws, 4, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph0_200M_clk, "pll-periph0-200M",
> +			    pll_periph0_2x_hws, 6, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
> +			    pll_periph0_2x_hws, 8, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
> +			    pll_periph0_480M_hws, 3, 1, 0);
> +
> +#define SUN55I_A523_PLL_PERIPH1_REG	0x028
> +static struct ccu_nm pll_periph1_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x028,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-periph1-4x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_periph1_4x_hws[] =3D {
> +	&pll_periph1_4x_clk.common.hw
> +};
> +static SUNXI_CCU_M_HWS(pll_periph1_2x_clk, "pll-periph1-2x",
> +		       pll_periph1_4x_hws, 0x028, 16, 3, 0);
> +static SUNXI_CCU_M_HWS(pll_periph1_800M_clk, "pll-periph1-800M",
> +		       pll_periph1_4x_hws, 0x028, 20, 3, 0);
> +static SUNXI_CCU_M_HWS(pll_periph1_480M_clk, "pll-periph1-480M",
> +		       pll_periph1_4x_hws, 0x028, 2, 3, 0);
> +
> +static const struct clk_hw *pll_periph1_2x_hws[] =3D {
> +	&pll_periph1_2x_clk.common.hw
> +};
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_600M_clk, "pll-periph1-600M",
> +			    pll_periph1_2x_hws, 2, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_400M_clk, "pll-periph1-400M",
> +			    pll_periph1_2x_hws, 3, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_300M_clk, "pll-periph1-300M",
> +			    pll_periph1_2x_hws, 4, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_200M_clk, "pll-periph1-200M",
> +			    pll_periph1_2x_hws, 6, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_150M_clk, "pll-periph1-150M",
> +			    pll_periph1_2x_hws, 8, 1, 0);
> +static const struct clk_hw *pll_periph1_480M_hws[] =3D {
> +	&pll_periph1_480M_clk.common.hw
> +};
> +static CLK_FIXED_FACTOR_HWS(pll_periph1_160M_clk, "pll-periph1-160M",
> +			    pll_periph1_480M_hws, 3, 1, 0);
> +
> +#define SUN55I_A523_PLL_GPU_REG		0x030
> +static struct ccu_nkmp pll_gpu_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		=3D _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		=3D {
> +		.reg		=3D 0x030,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-gpu", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +#define SUN55I_A523_PLL_VIDEO0_REG	0x040
> +static struct ccu_nm pll_video0_8x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x040,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-video0-8x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_video0_8x_hws[] =3D {
> +	&pll_video0_8x_clk.common.hw
> +};
> +static SUNXI_CCU_M_HWS(pll_video0_4x_clk, "pll-video0-4x",
> +		       pll_video0_8x_hws, 0x040, 0, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_video0_3x_clk, "pll-video0-3x",
> +			    pll_video0_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
> +
> +#define SUN55I_A523_PLL_VIDEO1_REG	0x048
> +static struct ccu_nm pll_video1_8x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x048,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-video1-8x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_video1_8x_hws[] =3D {
> +	&pll_video1_8x_clk.common.hw
> +};
> +static SUNXI_CCU_M_HWS(pll_video1_4x_clk, "pll-video1-4x",
> +		       pll_video1_8x_hws, 0x048, 0, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_video1_3x_clk, "pll-video1-3x",
> +			    pll_video1_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
> +
> +#define SUN55I_A523_PLL_VIDEO2_REG	0x050
> +static struct ccu_nm pll_video2_8x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x050,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-video2-8x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_video2_8x_hws[] =3D {
> +	&pll_video2_8x_clk.common.hw
> +};
> +static SUNXI_CCU_M_HWS(pll_video2_4x_clk, "pll-video2-4x",
> +		       pll_video2_8x_hws, 0x050, 0, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_video2_3x_clk, "pll-video2-3x",
> +			    pll_video2_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
> +
> +#define SUN55I_A523_PLL_VE_REG		0x058
> +static struct ccu_nkmp pll_ve_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.p		=3D _SUNXI_CCU_DIV(0, 1), /* output divider */
> +	.common		=3D {
> +		.reg		=3D 0x058,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-ve", osc24M,
> +							   &ccu_nkmp_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +#define SUN55I_A523_PLL_VIDEO3_REG	0x068
> +static struct ccu_nm pll_video3_8x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1), /* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x068,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-video3-8x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static const struct clk_hw *pll_video3_8x_hws[] =3D {
> +	&pll_video3_8x_clk.common.hw
> +};
> +static SUNXI_CCU_M_HWS(pll_video3_4x_clk, "pll-video3-4x",
> +		       pll_video3_8x_hws, 0x068, 0, 1, 0);
> +static CLK_FIXED_FACTOR_HWS(pll_video3_3x_clk, "pll-video3-3x",
> +			    pll_video3_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
> +
> +/*
> + * PLL_AUDIO0 has m0, m1 dividers in addition to the usual N, M factors.
> + * Since we only need some fixed frequency from this PLL (22.5792MHz x 4=
 and
> + * 24.576MHz x 4), ignore those dividers and force both of them to 1 (en=
coded
> + * as 0), in the probe function below.
> + * The M factor must be an even number to produce a 50% duty cycle outpu=
t.
> + */
> +#define SUN55I_A523_PLL_AUDIO0_REG		0x078
> +static struct ccu_sdm_setting pll_audio0_sdm_table[] =3D {
> +	{ .rate =3D 90316800, .pattern =3D 0xc000872b, .m =3D 20, .n =3D 75 },
> +	{ .rate =3D 98304000, .pattern =3D 0xc0004dd3, .m =3D 12, .n =3D 49 },
> +
> +};
> +
> +static struct ccu_nm pll_audio0_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(16, 6),
> +	.sdm		=3D _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24),
> +					 0x178, BIT(31)),
> +	.min_rate	=3D 180000000U,
> +	.max_rate	=3D 3000000000U,
> +	.common		=3D {
> +		.reg		=3D 0x078,
> +		.features	=3D CCU_FEATURE_SIGMA_DELTA_MOD,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-audio0-4x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +
> +static CLK_FIXED_FACTOR_HW(pll_audio0_2x_clk, "pll-audio0-2x",
> +			   &pll_audio0_4x_clk.common.hw, 2, 1, 0);
> +static CLK_FIXED_FACTOR_HW(pll_audio0_clk, "pll-audio0",
> +			   &pll_audio0_4x_clk.common.hw, 4, 1, 0);
> +
> +#define SUN55I_A523_PLL_NPU_REG			0x080
> +static struct ccu_nm pll_npu_4x_clk =3D {
> +	.enable		=3D BIT(27),
> +	.lock		=3D BIT(28),
> +	.n		=3D _SUNXI_CCU_MULT_MIN(8, 8, 11),
> +	.m		=3D _SUNXI_CCU_DIV(1, 1),	/* input divider */
> +	.common		=3D {
> +		.reg		=3D 0x0080,
> +		.hw.init	=3D CLK_HW_INIT_PARENTS_DATA("pll-npu-4x",
> +							   osc24M, &ccu_nm_ops,
> +							   CLK_SET_RATE_GATE),
> +	},
> +};
> +static CLK_FIXED_FACTOR_HW(pll_npu_2x_clk, "pll-npu-2x",
> +			   &pll_npu_4x_clk.common.hw, 2, 1, CLK_SET_RATE_PARENT);
> +
> +static CLK_FIXED_FACTOR_HW(pll_npu_1x_clk, "pll-npu-1x",
> +			   &pll_npu_4x_clk.common.hw, 4, 1, 0);
> +
> +/*
> + * Contains all clocks that are controlled by a hardware register. They
> + * have a (sunxi) .common member, which needs to be initialised by the c=
ommon
> + * sunxi CCU code, to be filled with the MMIO base address and the share=
d lock.
> + */
> +static struct ccu_common *sun55i_a523_ccu_clks[] =3D {
> +	&pll_ddr0_clk.common,
> +	&pll_periph0_4x_clk.common,
> +	&pll_periph0_2x_clk.common,
> +	&pll_periph0_800M_clk.common,
> +	&pll_periph0_480M_clk.common,
> +	&pll_periph1_4x_clk.common,
> +	&pll_periph1_2x_clk.common,
> +	&pll_periph1_800M_clk.common,
> +	&pll_periph1_480M_clk.common,
> +	&pll_gpu_clk.common,
> +	&pll_video0_8x_clk.common,
> +	&pll_video0_4x_clk.common,
> +	&pll_video1_8x_clk.common,
> +	&pll_video1_4x_clk.common,
> +	&pll_video2_8x_clk.common,
> +	&pll_video2_4x_clk.common,
> +	&pll_video3_8x_clk.common,
> +	&pll_video3_4x_clk.common,
> +	&pll_ve_clk.common,
> +	&pll_audio0_4x_clk.common,
> +	&pll_npu_4x_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sun55i_a523_hw_clks =3D {
> +	.num	=3D CLK_NUMBER,
> +	.hws	=3D {
> +		[CLK_PLL_DDR0]		=3D &pll_ddr0_clk.common.hw,
> +		[CLK_PLL_PERIPH0_4X]	=3D &pll_periph0_4x_clk.common.hw,
> +		[CLK_PLL_PERIPH0_2X]	=3D &pll_periph0_2x_clk.common.hw,
> +		[CLK_PLL_PERIPH0_800M]	=3D &pll_periph0_800M_clk.common.hw,
> +		[CLK_PLL_PERIPH0_480M]	=3D &pll_periph0_480M_clk.common.hw,
> +		[CLK_PLL_PERIPH0_600M]	=3D &pll_periph0_600M_clk.hw,
> +		[CLK_PLL_PERIPH0_400M]	=3D &pll_periph0_400M_clk.hw,
> +		[CLK_PLL_PERIPH0_300M]	=3D &pll_periph0_300M_clk.hw,
> +		[CLK_PLL_PERIPH0_200M]	=3D &pll_periph0_200M_clk.hw,
> +		[CLK_PLL_PERIPH0_160M]	=3D &pll_periph0_160M_clk.hw,
> +		[CLK_PLL_PERIPH0_150M]	=3D &pll_periph0_150M_clk.hw,
> +		[CLK_PLL_PERIPH1_4X]	=3D &pll_periph1_4x_clk.common.hw,
> +		[CLK_PLL_PERIPH1_2X]	=3D &pll_periph1_2x_clk.common.hw,
> +		[CLK_PLL_PERIPH1_800M]	=3D &pll_periph1_800M_clk.common.hw,
> +		[CLK_PLL_PERIPH1_480M]	=3D &pll_periph1_480M_clk.common.hw,
> +		[CLK_PLL_PERIPH1_600M]	=3D &pll_periph1_600M_clk.hw,
> +		[CLK_PLL_PERIPH1_400M]	=3D &pll_periph1_400M_clk.hw,
> +		[CLK_PLL_PERIPH1_300M]	=3D &pll_periph1_300M_clk.hw,
> +		[CLK_PLL_PERIPH1_200M]	=3D &pll_periph1_200M_clk.hw,
> +		[CLK_PLL_PERIPH1_160M]	=3D &pll_periph1_160M_clk.hw,
> +		[CLK_PLL_PERIPH1_150M]	=3D &pll_periph1_150M_clk.hw,
> +		[CLK_PLL_VIDEO0_8X]	=3D &pll_video0_8x_clk.common.hw,
> +		[CLK_PLL_VIDEO0_4X]	=3D &pll_video0_4x_clk.common.hw,
> +		[CLK_PLL_VIDEO0_3X]	=3D &pll_video0_3x_clk.hw,
> +		[CLK_PLL_VIDEO1_8X]	=3D &pll_video1_8x_clk.common.hw,
> +		[CLK_PLL_VIDEO1_4X]	=3D &pll_video1_4x_clk.common.hw,
> +		[CLK_PLL_VIDEO1_3X]	=3D &pll_video1_3x_clk.hw,
> +		[CLK_PLL_VIDEO2_8X]	=3D &pll_video2_8x_clk.common.hw,
> +		[CLK_PLL_VIDEO2_4X]	=3D &pll_video2_4x_clk.common.hw,
> +		[CLK_PLL_VIDEO2_3X]	=3D &pll_video2_3x_clk.hw,
> +		[CLK_PLL_VIDEO3_8X]	=3D &pll_video3_8x_clk.common.hw,
> +		[CLK_PLL_VIDEO3_4X]	=3D &pll_video3_4x_clk.common.hw,
> +		[CLK_PLL_VIDEO3_3X]	=3D &pll_video3_3x_clk.hw,
> +		[CLK_PLL_VE]		=3D &pll_ve_clk.common.hw,
> +		[CLK_PLL_AUDIO0_4X]	=3D &pll_audio0_4x_clk.common.hw,
> +		[CLK_PLL_AUDIO0_2X]	=3D &pll_audio0_2x_clk.hw,
> +		[CLK_PLL_AUDIO0]	=3D &pll_audio0_clk.hw,
> +		[CLK_PLL_NPU_4X]	=3D &pll_npu_4x_clk.common.hw,
> +		[CLK_PLL_NPU_2X]	=3D &pll_npu_2x_clk.hw,
> +		[CLK_PLL_NPU]		=3D &pll_npu_1x_clk.hw,
> +	},
> +};
> +
> +static const struct sunxi_ccu_desc sun55i_a523_ccu_desc =3D {
> +	.ccu_clks	=3D sun55i_a523_ccu_clks,
> +	.num_ccu_clks	=3D ARRAY_SIZE(sun55i_a523_ccu_clks),
> +
> +	.hw_clks	=3D &sun55i_a523_hw_clks,
> +};
> +
> +static const u32 pll_regs[] =3D {
> +	SUN55I_A523_PLL_DDR0_REG,
> +	SUN55I_A523_PLL_PERIPH0_REG,
> +	SUN55I_A523_PLL_PERIPH1_REG,
> +	SUN55I_A523_PLL_GPU_REG,
> +	SUN55I_A523_PLL_VIDEO0_REG,
> +	SUN55I_A523_PLL_VIDEO1_REG,
> +	SUN55I_A523_PLL_VIDEO2_REG,
> +	SUN55I_A523_PLL_VE_REG,
> +	SUN55I_A523_PLL_VIDEO3_REG,
> +	SUN55I_A523_PLL_AUDIO0_REG,
> +	SUN55I_A523_PLL_NPU_REG,
> +};
> +
> +static int sun55i_a523_ccu_probe(struct platform_device *pdev)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +	int i, ret;
> +
> +	reg =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	/*
> +	 * The PLL clock code does not model all bits, for instance it does
> +	 * not support a separate enable and gate bit. We present the
> +	 * gate bit(27) as the enable bit, but then have to set the
> +	 * PLL Enable, LDO Enable, and Lock Enable bits on all PLLs here.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(pll_regs); i++) {
> +		val =3D readl(reg + pll_regs[i]);
> +		val |=3D BIT(31) | BIT(30) | BIT(29);
> +		writel(val, reg + pll_regs[i]);
> +	}
> +
> +	/* Enforce m1 =3D 0, m0 =3D 0 for PLL_AUDIO0 */
> +	val =3D readl(reg + SUN55I_A523_PLL_AUDIO0_REG);
> +	val &=3D ~(BIT(1) | BIT(0));
> +	writel(val, reg + SUN55I_A523_PLL_AUDIO0_REG);
> +
> +	ret =3D devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_ccu_desc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sun55i_a523_ccu_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun55i-a523-ccu" },
> +	{ }
> +};
> +
> +static struct platform_driver sun55i_a523_ccu_driver =3D {
> +	.probe	=3D sun55i_a523_ccu_probe,
> +	.driver	=3D {
> +		.name			=3D "sun55i-a523-ccu",
> +		.suppress_bind_attrs	=3D true,
> +		.of_match_table		=3D sun55i_a523_ccu_ids,
> +	},
> +};
> +module_platform_driver(sun55i_a523_ccu_driver);
> +
> +MODULE_IMPORT_NS("SUNXI_CCU");
> +MODULE_DESCRIPTION("Support for the Allwinner A523 CCU");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h b/drivers/clk/sunxi-n=
g/ccu-sun55i-a523.h
> new file mode 100644
> index 0000000000000..fc8dd42f1b47b
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2024 Arm Ltd.
> + */
> +
> +#ifndef _CCU_SUN55I_A523_H
> +#define _CCU_SUN55I_A523_H
> +
> +#include <dt-bindings/clock/sun55i-a523-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-ccu.h>
> +
> +#define CLK_NUMBER	(CLK_FANOUT2 + 1)
> +
> +#endif /* _CCU_SUN55I_A523_H */
> diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
> index 687bd2ec798e2..5311835a4db60 100644
> --- a/drivers/clk/sunxi-ng/ccu_mp.h
> +++ b/drivers/clk/sunxi-ng/ccu_mp.h
> @@ -100,20 +100,22 @@ struct ccu_mp {

These changes doesn't belong in this commit.

Other than that, this looks like a good start. Thanks!

Best regards,
Jernej

>  				   _muxshift, _muxwidth,		\
>  				   0, _flags)
> =20
> -#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents, _=
reg, \
> +#define SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(_struct, _name, _parents, _re=
g, \
>  					_mshift, _mwidth,		\
>  					_pshift, _pwidth,		\
>  					_muxshift, _muxwidth,		\
> -					_gate, _flags,			\
> -					_features)			\
> +					_gate, _postdiv,		\
> +					_flags, _features)		\
>  	struct ccu_mp _struct =3D {					\
>  		.enable	=3D _gate,					\
>  		.m	=3D _SUNXI_CCU_DIV(_mshift, _mwidth),		\
>  		.p	=3D _SUNXI_CCU_DIV(_pshift, _pwidth),		\
>  		.mux	=3D _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
> +		.fixed_post_div =3D _postdiv,				\
>  		.common	=3D {						\
>  			.reg		=3D _reg,				\
> -			.features	=3D _features,			\
> +			.features	=3D CCU_FEATURE_FIXED_POSTDIV |	\
> +						_features,		\
>  			.hw.init	=3D CLK_HW_INIT_PARENTS_DATA(_name, \
>  								   _parents, \
>  								   &ccu_mp_ops,\
> @@ -126,11 +128,11 @@ struct ccu_mp {
>  					_pshift, _pwidth,		\
>  					_muxshift, _muxwidth,		\
>  					_gate, _flags)			\
> -	SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents,	\
> +	SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(_struct, _name, _parents,	\
>  					     _reg, _mshift, _mwidth,	\
>  					     _pshift, _pwidth,		\
>  					     _muxshift, _muxwidth,	\
> -					     _gate, _flags, 0)
> +					     _gate, 1, _flags, 0)
> =20
>  #define SUNXI_CCU_MP_DATA_WITH_MUX(_struct, _name, _parents, _reg,	\
>  				   _mshift, _mwidth,			\
>=20





