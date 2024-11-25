Return-Path: <linux-kernel+bounces-421399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE139D8B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000A5B3208C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D81B6D01;
	Mon, 25 Nov 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Jjj1Ipj2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A61B413D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554153; cv=none; b=QuxOO3uw+H+EPjKSiOa51XRag79ia1pZGYKiyG9P3e+TcLuNDWJ1airOTXcytY63Xue+ca41C708Hl9UyURMaHPaL66wwNVhoEtJXEpIgJAx11TW2v1uA1wCD+gTk9CtOu5Dcvqoyft9aa/5EoRDwr9iZAG+b73Fcmtpijm+TOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554153; c=relaxed/simple;
	bh=N7eOSo7SnwpiwAcmhIHLP4xxFuUcbyOZtJk9PfyXoc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZgnIds9kMej3jm42hQIyK0K+gyV2Rx/Jtuw0UVcl9m6YO8UHGd8yRMgIxe/AtqLZzm5/5T6y0+k0z27Ezq/wWlhCs8KJjhqHB/oItFoVntmpEvuyuzSJFIzrZuzzULdU0e+C00xekH2KQMCH30IGGJrFTA0LuGSgFTe1ePzdbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Jjj1Ipj2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43158625112so43239095e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732554148; x=1733158948; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MNEVDMUrGSZd23rWmNzMw5RxDtmEkOrfFw60ZPSrzk=;
        b=Jjj1Ipj2DXwUxmUypII3Mi/TQngl/qtpXnytC6GRtpBArbkoQV/+vRlCTmWV0dc6ov
         oDTvSpqxWQwlyLv8xSC5zqPVYA6qq2q+ktjKjUxRKkgYKOPPqyjV3pYZk61Dr4OrmH+y
         l6XDY+BogowXa1xS9HNXKDsY2g1WvAIViU2JnbNSpOLSq/1AM/iUx71oJngUIZiWbekm
         fBUgBE1UKTQPQlWzDiEm/a5DCy7U0nXltq6u07PuCVFRkBeSbkPka7HW+itOm2By26GV
         wD6QTQfTvtY3o3aIzL9Pfeec9UtzuY8Cgb47hqwjih8QEbeNoW4Pi8Cr91+p696fUYVw
         oxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732554148; x=1733158948;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MNEVDMUrGSZd23rWmNzMw5RxDtmEkOrfFw60ZPSrzk=;
        b=frqxeNu77SaAG7T+hF9ylrCBRBND7MzjD8irj3wDNrzymheYWmW6rUUGhAaCBOl5eC
         PGUAGjFsnZXAXcxU9aWIrA7nGz0eu/1ZRLjf2cSg0NQYJk+gkzj3VOtQMUykB7easWLO
         lYZ9Qhf6qyUzLm6anSsliBucnwm5ye1VtLCC4WkPZ7QP8Gol7U2nFT0nY4XAzovatwZw
         yQF4IgeOHitm5v/BQ8l9ilqdhdhrwg2JVdd31SSsSBJJ4yg5AtusrhXnilSSa9X+t6ni
         tp9ili4nNOGX4E6bb43RSLTTeCc4+gep58kgEj13DsVdJyFQ/E9PV7GVHBjF/IKcXfe1
         dVIw==
X-Forwarded-Encrypted: i=1; AJvYcCVQoxG9SYfFm2lIT4E66o3bOHrxnWGVn6BTmIyWVrei66/oa82Pnslu5+8BtVLKeErrMOj17sANuJCzo8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs1CqlP3dmAYSynMbIJnqa1q2MTjex5UvoSRyrr2S0/6+4k4p8
	4yMarPz6MVyymunU6W8WMn9koKqliES/0yAtmt/ZtG6fqfOJT6crgOqQntzTerI=
X-Gm-Gg: ASbGnculOkRdEBgnO7YKkCbRVkwTcCmynR0JH947hPkrTQg3rlcTGLDjTVK7v5ASERK
	qpY9VL20Jv3z5SSvnXwua1QHarlg0BQPyTKsOYaKvaiqnU3Ca17qHPU1fnG1xbHf6bRji24QhGX
	jVLZnV5gEEqfEr+NgXJPErBeUz/YZLfo3PfLKDb3/h3YF3WRr1pAtQUjBhUYoy5kldu5ZUsLkUl
	Y+h/ZaQ4o0n+YNaI+4R/eiwQXPdWgE6rThjV7d5tvPKZB1l
X-Google-Smtp-Source: AGHT+IEYU0eGM+tLdHp8ozU6zSv0ymuz5isAMvK2Ge5Wqvk2CgZbvxGIHXWZBTNCIch36IZ9/giJhw==
X-Received: by 2002:a05:600c:b87:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-433ce414c70mr125754325e9.4.1732554147630;
        Mon, 25 Nov 2024 09:02:27 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:97f5:4cdc:1888:403])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349f2e1b3bsm47747585e9.25.2024.11.25.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:02:27 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Chuan Liu <chuan.liu@amlogic.com>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  xianwei.zhao@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] clk: meson: add A5 clock peripherals controller
 driver
In-Reply-To: <20241120-a5-clk-v2-5-1208621e961d@amlogic.com> (Xianwei Zhao
	via's message of "Wed, 20 Nov 2024 15:01:17 +0800")
References: <20241120-a5-clk-v2-0-1208621e961d@amlogic.com>
	<20241120-a5-clk-v2-5-1208621e961d@amlogic.com>
Date: Mon, 25 Nov 2024 18:02:26 +0100
Message-ID: <1jldx7tffh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 20 Nov 2024 at 15:01, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add the peripherals clock controller driver in the A5 SoC family.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig          |   13 +
>  drivers/clk/meson/Makefile         |    1 +
>  drivers/clk/meson/a5-peripherals.c | 1387 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/clk-regmap.h     |   17 +
>  4 files changed, 1418 insertions(+)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 3c97b3a1649d..79ec72156cee 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -146,6 +146,19 @@ config COMMON_CLK_A5_PLL
>  	  Say Y if you want the board to work, because PLLs are the parent
>  	  of most peripherals.
>  
> +config COMMON_CLK_A5_PERIPHERALS
> +	tristate "Amlogic A5 peripherals clock controller"
> +	depends on ARM64
> +	default y
> +	imply COMMON_CLK_SCMI
> +	imply COMMON_CLK_A5_PLL
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_DUALDIV
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the Peripherals clock controller on Amlogic AV40x device,

Same

> +	  AKA A5. Say Y if you want the peripherals clock to work.
> +
>  config COMMON_CLK_C3_PLL
>  	tristate "Amlogic C3 PLL clock controller"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index fc4b8a723145..58236c6e8377 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
> +obj-$(CONFIG_COMMON_CLK_A5_PERIPHERALS) += a5-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>  obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
> diff --git a/drivers/clk/meson/a5-peripherals.c b/drivers/clk/meson/a5-peripherals.c
> new file mode 100644
> index 000000000000..ed408f1c5b1f
> --- /dev/null
> +++ b/drivers/clk/meson/a5-peripherals.c
> @@ -0,0 +1,1387 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Amlogic A5 Peripherals Clock Controller Driver
> + *
> + * Copyright (c) 2024 Amlogic, inc.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include "clk-regmap.h"
> +#include "clk-dualdiv.h"
> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,a5-peripherals-clkc.h>
> +
> +#define CLKCTRL_RTC_BY_OSCIN_CTRL0		0x8
> +#define CLKCTRL_RTC_BY_OSCIN_CTRL1		0xc
> +#define CLKCTRL_RTC_CTRL			0x10
> +#define CLKCTRL_SYS_CLK_EN0_REG0		0x44
> +#define CLKCTRL_SYS_CLK_EN0_REG1		0x48
> +#define CLKCTRL_DSPA_CLK_CTRL0			0x9c
> +#define CLKCTRL_CLK12_24_CTRL			0xa8
> +#define CLKCTRL_AXI_CLK_EN0			0xac
> +#define CLKCTRL_TS_CLK_CTRL			0x158
> +#define CLKCTRL_ETH_CLK_CTRL			0x164
> +#define CLKCTRL_NAND_CLK_CTRL			0x168
> +#define CLKCTRL_SD_EMMC_CLK_CTRL		0x16c
> +#define CLKCTRL_SPICC_CLK_CTRL			0x174
> +#define CLKCTRL_GEN_CLK_CTRL			0x178
> +#define CLKCTRL_SAR_CLK_CTRL0			0x17c
> +#define CLKCTRL_PWM_CLK_AB_CTRL			0x180
> +#define CLKCTRL_PWM_CLK_CD_CTRL			0x184
> +#define CLKCTRL_PWM_CLK_EF_CTRL			0x188
> +#define CLKCTRL_PWM_CLK_GH_CTRL			0x18c
> +#define CLKCTRL_NNA_CLK_CNTL			0x220

Same comment as previous patches

> +
> +static struct clk_regmap rtc_xtal_clkin = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_xtal_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "oscin",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct meson_clk_dualdiv_param rtc_32k_div_table[] = {
> +	{ 733, 732, 8, 11, 1 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap rtc_32k_div = {
> +	.data = &(struct meson_clk_dualdiv_data) {
> +		.n1 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = rtc_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&rtc_xtal_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct clk_parent_data rtc_32k_mux_parent_data[] = {
> +	{ .hw = &rtc_32k_div.hw },
> +	{ .hw = &rtc_xtal_clkin.hw }
> +};
> +
> +static struct clk_regmap rtc_32k_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL1,
> +		.mask = 0x1,
> +		.shift = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = rtc_32k_mux_parent_data,
> +		.num_parents = ARRAY_SIZE(rtc_32k_mux_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap rtc_32k = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&rtc_32k_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data rtc_clk_mux_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .hw = &rtc_32k.hw },
> +	{ .fw_name = "pad_osc" }
> +};
> +
> +static struct clk_regmap rtc_clk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_RTC_CTRL,
> +		.mask = 0x3,
> +		.shift = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_clk",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = rtc_clk_mux_parent_data,
> +		.num_parents = ARRAY_SIZE(rtc_clk_mux_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +#define A5_SYS_GATE(_name, _reg, _bit, _flags)				\
> +	MESON_CLK_GATE_FW(_name, _reg, _bit, sysclk,			\
> +			&clk_regmap_gate_ops, _flags)
> +
> +static A5_SYS_GATE(sys_reset_ctrl,	CLKCTRL_SYS_CLK_EN0_REG0, 1, 0);
> +static A5_SYS_GATE(sys_pwr_ctrl,	CLKCTRL_SYS_CLK_EN0_REG0, 3, 0);
> +static A5_SYS_GATE(sys_pad_ctrl,	CLKCTRL_SYS_CLK_EN0_REG0, 4, 0);
> +static A5_SYS_GATE(sys_ctrl,		CLKCTRL_SYS_CLK_EN0_REG0, 5, 0);
> +static A5_SYS_GATE(sys_ts_pll,		CLKCTRL_SYS_CLK_EN0_REG0, 6, 0);
> +
> +/*
> + * NOTE: sys_dev_arb provides the clock to the ETH and SPICC arbiters that
> + * access the AXI bus.
> + */
> +static A5_SYS_GATE(sys_dev_arb,		CLKCTRL_SYS_CLK_EN0_REG0, 7, 0);
> +static A5_SYS_GATE(sys_mailbox,		CLKCTRL_SYS_CLK_EN0_REG0, 10, 0);
> +static A5_SYS_GATE(sys_jtag_ctrl,	CLKCTRL_SYS_CLK_EN0_REG0, 12, 0);
> +static A5_SYS_GATE(sys_ir_ctrl,		CLKCTRL_SYS_CLK_EN0_REG0, 13, 0);
> +static A5_SYS_GATE(sys_msr_clk,		CLKCTRL_SYS_CLK_EN0_REG0, 15, 0);
> +static A5_SYS_GATE(sys_rom,		CLKCTRL_SYS_CLK_EN0_REG0, 16, 0);
> +static A5_SYS_GATE(sys_cpu_apb,		CLKCTRL_SYS_CLK_EN0_REG0, 18, 0);
> +static A5_SYS_GATE(sys_rsa,		CLKCTRL_SYS_CLK_EN0_REG0, 19, 0);
> +static A5_SYS_GATE(sys_sar_adc,		CLKCTRL_SYS_CLK_EN0_REG0, 20, 0);
> +static A5_SYS_GATE(sys_startup,		CLKCTRL_SYS_CLK_EN0_REG0, 21, 0);
> +static A5_SYS_GATE(sys_secure,		CLKCTRL_SYS_CLK_EN0_REG0, 22, 0);
> +static A5_SYS_GATE(sys_spifc,		CLKCTRL_SYS_CLK_EN0_REG0, 23, 0);
> +static A5_SYS_GATE(sys_dspa,		CLKCTRL_SYS_CLK_EN0_REG0, 24, 0);
> +static A5_SYS_GATE(sys_nna,		CLKCTRL_SYS_CLK_EN0_REG0, 25, 0);
> +static A5_SYS_GATE(sys_eth_mac,		CLKCTRL_SYS_CLK_EN0_REG0, 26, 0);
> +static A5_SYS_GATE(sys_rama,		CLKCTRL_SYS_CLK_EN0_REG0, 28, 0);
> +static A5_SYS_GATE(sys_ramb,		CLKCTRL_SYS_CLK_EN0_REG0, 30, 0);
> +static A5_SYS_GATE(sys_audio_top,	CLKCTRL_SYS_CLK_EN0_REG1, 0, 0);
> +static A5_SYS_GATE(sys_audio_vad,	CLKCTRL_SYS_CLK_EN0_REG1, 1, 0);
> +static A5_SYS_GATE(sys_usb,		CLKCTRL_SYS_CLK_EN0_REG1, 2, 0);
> +static A5_SYS_GATE(sys_sd_emmc_a,	CLKCTRL_SYS_CLK_EN0_REG1, 3, 0);
> +static A5_SYS_GATE(sys_sd_emmc_c,	CLKCTRL_SYS_CLK_EN0_REG1, 4, 0);
> +static A5_SYS_GATE(sys_pwm_ab,		CLKCTRL_SYS_CLK_EN0_REG1, 5, 0);
> +static A5_SYS_GATE(sys_pwm_cd,		CLKCTRL_SYS_CLK_EN0_REG1, 6, 0);
> +static A5_SYS_GATE(sys_pwm_ef,		CLKCTRL_SYS_CLK_EN0_REG1, 7, 0);
> +static A5_SYS_GATE(sys_pwm_gh,		CLKCTRL_SYS_CLK_EN0_REG1, 8, 0);
> +static A5_SYS_GATE(sys_spicc_1,		CLKCTRL_SYS_CLK_EN0_REG1, 9, 0);
> +static A5_SYS_GATE(sys_spicc_0,		CLKCTRL_SYS_CLK_EN0_REG1, 10, 0);
> +static A5_SYS_GATE(sys_uart_a,		CLKCTRL_SYS_CLK_EN0_REG1, 11, 0);
> +static A5_SYS_GATE(sys_uart_b,		CLKCTRL_SYS_CLK_EN0_REG1, 12, 0);
> +static A5_SYS_GATE(sys_uart_c,		CLKCTRL_SYS_CLK_EN0_REG1, 13, 0);
> +static A5_SYS_GATE(sys_uart_d,		CLKCTRL_SYS_CLK_EN0_REG1, 14, 0);
> +static A5_SYS_GATE(sys_uart_e,		CLKCTRL_SYS_CLK_EN0_REG1, 15, 0);
> +static A5_SYS_GATE(sys_i2c_m_a,		CLKCTRL_SYS_CLK_EN0_REG1, 16, 0);
> +static A5_SYS_GATE(sys_i2c_m_b,		CLKCTRL_SYS_CLK_EN0_REG1, 17, 0);
> +static A5_SYS_GATE(sys_i2c_m_c,		CLKCTRL_SYS_CLK_EN0_REG1, 18, 0);
> +static A5_SYS_GATE(sys_i2c_m_d,		CLKCTRL_SYS_CLK_EN0_REG1, 19, 0);
> +static A5_SYS_GATE(sys_rtc,		CLKCTRL_SYS_CLK_EN0_REG1, 21, 0);
> +
> +#define A5_AXI_GATE(_name, _reg, _bit, _flags)				\
> +	MESON_CLK_GATE_FW(_name, _reg, _bit, axiclk,			\
> +			&clk_regmap_gate_ops, _flags)
> +
> +static A5_AXI_GATE(axi_audio_vad,	CLKCTRL_AXI_CLK_EN0, 0, 0);
> +static A5_AXI_GATE(axi_audio_top,	CLKCTRL_AXI_CLK_EN0, 1, 0);
> +static A5_AXI_GATE(axi_ramb,		CLKCTRL_AXI_CLK_EN0, 5, 0);
> +static A5_AXI_GATE(axi_rama,		CLKCTRL_AXI_CLK_EN0, 6, 0);
> +static A5_AXI_GATE(axi_nna,		CLKCTRL_AXI_CLK_EN0, 12, 0);
> +
> +/*
> + * NOTE: axi_dev1_dmc provides the clock for the peripherals(EMMC, SDIO,
> + * sec_top, USB, Audio) to access the AXI bus of the DDR.
> + */
> +static A5_AXI_GATE(axi_dev1_dmc,	CLKCTRL_AXI_CLK_EN0, 13, 0);
> +
> +/*
> + * NOTE: axi_dev0_dmc provides the clock for the peripherals(ETH and SPICC)
> + * to access the AXI bus of the DDR.
> + */
> +static A5_AXI_GATE(axi_dev0_dmc,	CLKCTRL_AXI_CLK_EN0, 14, 0);
> +static A5_AXI_GATE(axi_dsp_dmc,		CLKCTRL_AXI_CLK_EN0, 15, 0);
> +
> +static struct clk_regmap clk_12_24m_in = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_CLK12_24_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "clk_12_24m_in",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap clk_12_24m = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_CLK12_24_CTRL,
> +		.shift = 10,
> +		.width = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "clk_12_24m",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&clk_12_24m_in.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_25m_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_CLK12_24_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_25m_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_25m = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_CLK12_24_CTRL,
> +		.bit_idx = 12,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_25m",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_25m_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Channel 4 5 8 9 10 11 13 14 15 16 18 are not connected.
> + *
> + * gp1 is designed for DSU (DynamIQ Shared Unit) alone. It cannot be changed
> + * arbitrarily. gp1 is read-only in the kernel and is only open for debug
> + * purposes.
> + */
> +static u32 gen_parent_table[] = { 0, 1, 2, 3, 6, 7, 12, 17, 19, 20, 21, 22, 23,
> +				  24, 25, 26, 27, 28};
> +
> +static const struct clk_parent_data gen_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .hw = &rtc_clk.hw },
> +	{ .fw_name = "sysplldiv16" },
> +	{ .fw_name = "ddr" },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "clkmsr" },
> +	{ .fw_name = "cpudiv16" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" },
> +	{ .fw_name = "mpll0" },
> +	{ .fw_name = "mpll1" },
> +	{ .fw_name = "mpll2" },
> +	{ .fw_name = "mpll3" }
> +};
> +
> +static struct clk_regmap gen_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.mask = 0x1f,
> +		.shift = 12,
> +		.table = gen_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = gen_parent_data,
> +		.num_parents = ARRAY_SIZE(gen_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap gen_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.shift = 0,
> +		.width = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gen_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap gen = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_GEN_CLK_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gen_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data saradc_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .fw_name = "sysclk" }
> +};
> +
> +static struct clk_regmap saradc_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "saradc_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = saradc_parent_data,
> +		.num_parents = ARRAY_SIZE(saradc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap saradc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL0,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "saradc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&saradc_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap saradc = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_SAR_CLK_CTRL0,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "saradc",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&saradc_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data pwm_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .hw = &rtc_clk.hw },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" }
> +};
> +
> +#define AML_PWM_CLK_MUX(_name, _reg, _shift) {			\
> +	.data = &(struct clk_regmap_mux_data) {			\
> +		.offset = _reg,					\
> +		.mask = 0x3,					\
> +		.shift = _shift,				\
> +	},							\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.name = #_name "_sel",				\
> +		.ops = &clk_regmap_mux_ops,			\
> +		.parent_data = pwm_parent_data,			\
> +		.num_parents = ARRAY_SIZE(pwm_parent_data),	\
> +	},							\
> +}
> +
> +#define AML_PWM_CLK_DIV(_name, _reg, _shift) {			\
> +	.data = &(struct clk_regmap_div_data) {			\
> +		.offset = _reg,					\
> +		.shift = _shift,				\
> +		.width = 8,					\
> +	},							\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.name = #_name "_div",				\
> +		.ops = &clk_regmap_divider_ops,			\
> +		.parent_names = (const char *[]) { #_name "_sel" },\
> +		.num_parents = 1,				\
> +		.flags = CLK_SET_RATE_PARENT,			\
> +	},							\
> +}
> +
> +#define AML_PWM_CLK_GATE(_name, _reg, _bit) {			\
> +	.data = &(struct clk_regmap_gate_data) {		\
> +		.offset = _reg,					\
> +		.bit_idx = _bit,				\
> +	},							\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.name = #_name,					\
> +		.ops = &clk_regmap_gate_ops,			\
> +		.parent_names = (const char *[]) { #_name "_div" },\
> +		.num_parents = 1,				\
> +		.flags = CLK_SET_RATE_PARENT,			\
> +	},							\
> +}
> +
> +static struct clk_regmap pwm_a_sel =
> +	AML_PWM_CLK_MUX(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 9);
> +static struct clk_regmap pwm_a_div =
> +	AML_PWM_CLK_DIV(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 0);
> +static struct clk_regmap pwm_a =
> +	AML_PWM_CLK_GATE(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 8);
> +
> +static struct clk_regmap pwm_b_sel =
> +	AML_PWM_CLK_MUX(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 25);
> +static struct clk_regmap pwm_b_div =
> +	AML_PWM_CLK_DIV(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 16);
> +static struct clk_regmap pwm_b =
> +	AML_PWM_CLK_GATE(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 24);
> +
> +static struct clk_regmap pwm_c_sel =
> +	AML_PWM_CLK_MUX(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 9);
> +static struct clk_regmap pwm_c_div =
> +	AML_PWM_CLK_DIV(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 0);
> +static struct clk_regmap pwm_c =
> +	AML_PWM_CLK_GATE(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 8);
> +
> +static struct clk_regmap pwm_d_sel =
> +	AML_PWM_CLK_MUX(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 25);
> +static struct clk_regmap pwm_d_div =
> +	AML_PWM_CLK_DIV(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 16);
> +static struct clk_regmap pwm_d =
> +	AML_PWM_CLK_GATE(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 24);
> +
> +static struct clk_regmap pwm_e_sel =
> +	AML_PWM_CLK_MUX(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 9);
> +static struct clk_regmap pwm_e_div =
> +	AML_PWM_CLK_DIV(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 0);
> +static struct clk_regmap pwm_e =
> +	AML_PWM_CLK_GATE(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 8);
> +
> +static struct clk_regmap pwm_f_sel =
> +	AML_PWM_CLK_MUX(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 25);
> +static struct clk_regmap pwm_f_div =
> +	AML_PWM_CLK_DIV(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 16);
> +static struct clk_regmap pwm_f =
> +	AML_PWM_CLK_GATE(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 24);
> +
> +static struct clk_regmap pwm_g_sel =
> +	AML_PWM_CLK_MUX(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 9);
> +static struct clk_regmap pwm_g_div =
> +	AML_PWM_CLK_DIV(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 0);
> +static struct clk_regmap pwm_g =
> +	AML_PWM_CLK_GATE(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 8);
> +
> +static struct clk_regmap pwm_h_sel =
> +	AML_PWM_CLK_MUX(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 25);
> +static struct clk_regmap pwm_h_div =
> +	AML_PWM_CLK_DIV(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 16);
> +static struct clk_regmap pwm_h =
> +	AML_PWM_CLK_GATE(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 24);
> +
> +static const struct clk_parent_data spicc_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .fw_name = "sysclk" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap spicc_0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = spicc_parent_data,
> +		.num_parents = ARRAY_SIZE(spicc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap spicc_0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spicc_0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.bit_idx = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spicc_1_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 23,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = spicc_parent_data,
> +		.num_parents = ARRAY_SIZE(spicc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap spicc_1_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.shift = 16,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spicc_1 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data emmc_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "mpll2" },
> +	{ .fw_name = "mpll3" },
> +	{ .fw_name = "gp0" }
> +};
> +
> +static struct clk_regmap sd_emmc_a_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = emmc_parent_data,
> +		.num_parents = ARRAY_SIZE(emmc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_a_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_a_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_a = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_SD_EMMC_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_c_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = emmc_parent_data,
> +		.num_parents = ARRAY_SIZE(emmc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_c_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_c_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_c = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_NAND_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_c_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap ts_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_TS_CLK_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ts_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "oscin",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap ts = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_TS_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ts",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&ts_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_fixed_factor eth_125m_div = {
> +	.mult = 1,
> +	.div = 8,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_125m_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fdiv2",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap eth_125m = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_ETH_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_125m",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&eth_125m_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap eth_rmii_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_ETH_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_rmii_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fdiv2",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap eth_rmii = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_ETH_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_rmii",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&eth_rmii_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* Channel 6 is gp1. */
> +static u32 dspa_parent_table[] = { 0, 1, 2, 3, 4, 5, 7};
> +
> +static const struct clk_parent_data dspa_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "rtc" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv4" },
> +	{ .hw = &rtc_clk.hw }
> +};
> +
> +static struct clk_regmap dspa_0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 10,
> +		.table = dspa_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = dspa_parent_data,
> +		.num_parents = ARRAY_SIZE(dspa_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap dspa_0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.shift = 0,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dspa_0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap dspa_0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.bit_idx = 13,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dspa_0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap dspa_1_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 26,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = dspa_parent_data,
> +		.num_parents = ARRAY_SIZE(dspa_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap dspa_1_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.shift = 16,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dspa_1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap dspa_1 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.bit_idx = 29,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dspa_1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap dspa = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = CLKCTRL_DSPA_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 15,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dspa",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dspa_0.hw,
> +			&dspa_1.hw
> +		},
> +		.num_parents = 2,
> +		/*
> +		 * NOTE: This level of mux is "no glitch mux", and mux_0
> +		 * (here dspa_0) is not only the clock source for mux, but also
> +		 * provides a working clock for "no glitch mux". "no glitch mux"
> +		 * can be switched only when mux_0 has a clock input. Therefore,
> +		 * add flag CLK_OPS_PARENT_ENABLE to ensure that mux_0 has clock
> +		 * when "no glitch mux" works.
> +		 */
> +		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
> +	},
> +};
> +
> +/* Channel 6 is gp1. */
> +static u32 nna_parent_table[] = { 0, 1, 2, 3, 4, 5, 7};
> +
> +static const struct clk_parent_data nna_parent_data[] = {
> +	{ .fw_name = "oscin" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "hifi" }
> +};
> +
> +static struct clk_regmap nna_core_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_NNA_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 9,
> +		.table = nna_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_core_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = nna_parent_data,
> +		.num_parents = ARRAY_SIZE(nna_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap nna_core_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_NNA_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_core_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&nna_core_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap nna_core = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_NNA_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_core",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&nna_core_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap nna_axi_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CLKCTRL_NNA_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_axi_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = nna_parent_data,
> +		.num_parents = ARRAY_SIZE(nna_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap nna_axi_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLKCTRL_NNA_CLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_axi_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&nna_axi_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap nna_axi = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLKCTRL_NNA_CLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_axi",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&nna_axi_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_hw *a5_periphs_hw_clks[] = {
> +	[CLKID_RTC_XTAL_CLKIN]		= &rtc_xtal_clkin.hw,
> +	[CLKID_RTC_32K_DIV]		= &rtc_32k_div.hw,
> +	[CLKID_RTC_32K_MUX]		= &rtc_32k_mux.hw,
> +	[CLKID_RTC_32K]			= &rtc_32k.hw,
> +	[CLKID_RTC_CLK]			= &rtc_clk.hw,
> +	[CLKID_SYS_RESET_CTRL]		= &sys_reset_ctrl.hw,
> +	[CLKID_SYS_PWR_CTRL]		= &sys_pwr_ctrl.hw,
> +	[CLKID_SYS_PAD_CTRL]		= &sys_pad_ctrl.hw,
> +	[CLKID_SYS_CTRL]		= &sys_ctrl.hw,
> +	[CLKID_SYS_TS_PLL]		= &sys_ts_pll.hw,
> +	[CLKID_SYS_DEV_ARB]		= &sys_dev_arb.hw,
> +	[CLKID_SYS_MAILBOX]		= &sys_mailbox.hw,
> +	[CLKID_SYS_JTAG_CTRL]		= &sys_jtag_ctrl.hw,
> +	[CLKID_SYS_IR_CTRL]		= &sys_ir_ctrl.hw,
> +	[CLKID_SYS_MSR_CLK]		= &sys_msr_clk.hw,
> +	[CLKID_SYS_ROM]			= &sys_rom.hw,
> +	[CLKID_SYS_CPU_ARB]		= &sys_cpu_apb.hw,
> +	[CLKID_SYS_RSA]			= &sys_rsa.hw,
> +	[CLKID_SYS_SAR_ADC]		= &sys_sar_adc.hw,
> +	[CLKID_SYS_STARTUP]		= &sys_startup.hw,
> +	[CLKID_SYS_SECURE]		= &sys_secure.hw,
> +	[CLKID_SYS_SPIFC]		= &sys_spifc.hw,
> +	[CLKID_SYS_DSPA]		= &sys_dspa.hw,
> +	[CLKID_SYS_NNA]			= &sys_nna.hw,
> +	[CLKID_SYS_ETH_MAC]		= &sys_eth_mac.hw,
> +	[CLKID_SYS_RAMA]		= &sys_rama.hw,
> +	[CLKID_SYS_RAMB]		= &sys_ramb.hw,
> +	[CLKID_SYS_AUDIO_TOP]		= &sys_audio_top.hw,
> +	[CLKID_SYS_AUDIO_VAD]		= &sys_audio_vad.hw,
> +	[CLKID_SYS_USB]			= &sys_usb.hw,
> +	[CLKID_SYS_SD_EMMC_A]		= &sys_sd_emmc_a.hw,
> +	[CLKID_SYS_SD_EMMC_C]		= &sys_sd_emmc_c.hw,
> +	[CLKID_SYS_PWM_AB]		= &sys_pwm_ab.hw,
> +	[CLKID_SYS_PWM_CD]		= &sys_pwm_cd.hw,
> +	[CLKID_SYS_PWM_EF]		= &sys_pwm_ef.hw,
> +	[CLKID_SYS_PWM_GH]		= &sys_pwm_gh.hw,
> +	[CLKID_SYS_SPICC_1]		= &sys_spicc_1.hw,
> +	[CLKID_SYS_SPICC_0]		= &sys_spicc_0.hw,
> +	[CLKID_SYS_UART_A]		= &sys_uart_a.hw,
> +	[CLKID_SYS_UART_B]		= &sys_uart_b.hw,
> +	[CLKID_SYS_UART_C]		= &sys_uart_c.hw,
> +	[CLKID_SYS_UART_D]		= &sys_uart_d.hw,
> +	[CLKID_SYS_UART_E]		= &sys_uart_e.hw,
> +	[CLKID_SYS_I2C_M_A]		= &sys_i2c_m_a.hw,
> +	[CLKID_SYS_I2C_M_B]		= &sys_i2c_m_b.hw,
> +	[CLKID_SYS_I2C_M_C]		= &sys_i2c_m_c.hw,
> +	[CLKID_SYS_I2C_M_D]		= &sys_i2c_m_d.hw,
> +	[CLKID_SYS_RTC]			= &sys_rtc.hw,
> +	[CLKID_AXI_AUDIO_VAD]		= &axi_audio_vad.hw,
> +	[CLKID_AXI_AUDIO_TOP]		= &axi_audio_top.hw,
> +	[CLKID_AXI_RAMB]		= &axi_ramb.hw,
> +	[CLKID_AXI_RAMA]		= &axi_rama.hw,
> +	[CLKID_AXI_NNA]			= &axi_nna.hw,
> +	[CLKID_AXI_DEV1_DMC]		= &axi_dev1_dmc.hw,
> +	[CLKID_AXI_DEV0_DMC]		= &axi_dev0_dmc.hw,
> +	[CLKID_AXI_DSP_DMC]		= &axi_dsp_dmc.hw,
> +	[CLKID_12_24M_IN]		= &clk_12_24m_in.hw,
> +	[CLKID_12M_24M]			= &clk_12_24m.hw,
> +	[CLKID_FCLK_25M_DIV]		= &fclk_25m_div.hw,
> +	[CLKID_FCLK_25M]		= &fclk_25m.hw,
> +	[CLKID_GEN_SEL]			= &gen_sel.hw,
> +	[CLKID_GEN_DIV]			= &gen_div.hw,
> +	[CLKID_GEN]			= &gen.hw,
> +	[CLKID_SARADC_SEL]		= &saradc_sel.hw,
> +	[CLKID_SARADC_DIV]		= &saradc_div.hw,
> +	[CLKID_SARADC]			= &saradc.hw,
> +	[CLKID_PWM_A_SEL]		= &pwm_a_sel.hw,
> +	[CLKID_PWM_A_DIV]		= &pwm_a_div.hw,
> +	[CLKID_PWM_A]			= &pwm_a.hw,
> +	[CLKID_PWM_B_SEL]		= &pwm_b_sel.hw,
> +	[CLKID_PWM_B_DIV]		= &pwm_b_div.hw,
> +	[CLKID_PWM_B]			= &pwm_b.hw,
> +	[CLKID_PWM_C_SEL]		= &pwm_c_sel.hw,
> +	[CLKID_PWM_C_DIV]		= &pwm_c_div.hw,
> +	[CLKID_PWM_C]			= &pwm_c.hw,
> +	[CLKID_PWM_D_SEL]		= &pwm_d_sel.hw,
> +	[CLKID_PWM_D_DIV]		= &pwm_d_div.hw,
> +	[CLKID_PWM_D]			= &pwm_d.hw,
> +	[CLKID_PWM_E_SEL]		= &pwm_e_sel.hw,
> +	[CLKID_PWM_E_DIV]		= &pwm_e_div.hw,
> +	[CLKID_PWM_E]			= &pwm_e.hw,
> +	[CLKID_PWM_F_SEL]		= &pwm_f_sel.hw,
> +	[CLKID_PWM_F_DIV]		= &pwm_f_div.hw,
> +	[CLKID_PWM_F]			= &pwm_f.hw,
> +	[CLKID_PWM_G_SEL]		= &pwm_g_sel.hw,
> +	[CLKID_PWM_G_DIV]		= &pwm_g_div.hw,
> +	[CLKID_PWM_G]			= &pwm_g.hw,
> +	[CLKID_PWM_H_SEL]		= &pwm_h_sel.hw,
> +	[CLKID_PWM_H_DIV]		= &pwm_h_div.hw,
> +	[CLKID_PWM_H]			= &pwm_h.hw,
> +	[CLKID_SPICC_0_SEL]		= &spicc_0_sel.hw,
> +	[CLKID_SPICC_0_DIV]		= &spicc_0_div.hw,
> +	[CLKID_SPICC_0]			= &spicc_0.hw,
> +	[CLKID_SPICC_1_SEL]		= &spicc_1_sel.hw,
> +	[CLKID_SPICC_1_DIV]		= &spicc_1_div.hw,
> +	[CLKID_SPICC_1]			= &spicc_1.hw,
> +	[CLKID_SD_EMMC_A_SEL]		= &sd_emmc_a_sel.hw,
> +	[CLKID_SD_EMMC_A_DIV]		= &sd_emmc_a_div.hw,
> +	[CLKID_SD_EMMC_A]		= &sd_emmc_a.hw,
> +	[CLKID_SD_EMMC_C_SEL]		= &sd_emmc_c_sel.hw,
> +	[CLKID_SD_EMMC_C_DIV]		= &sd_emmc_c_div.hw,
> +	[CLKID_SD_EMMC_C]		= &sd_emmc_c.hw,
> +	[CLKID_TS_DIV]			= &ts_div.hw,
> +	[CLKID_TS]			= &ts.hw,
> +	[CLKID_ETH_125M_DIV]		= &eth_125m_div.hw,
> +	[CLKID_ETH_125M]		= &eth_125m.hw,
> +	[CLKID_ETH_RMII_DIV]		= &eth_rmii_div.hw,
> +	[CLKID_ETH_RMII]		= &eth_rmii.hw,
> +	[CLKID_DSPA_0_SEL]		= &dspa_0_sel.hw,
> +	[CLKID_DSPA_0_DIV]		= &dspa_0_div.hw,
> +	[CLKID_DSPA_0]			= &dspa_0.hw,
> +	[CLKID_DSPA_1_SEL]		= &dspa_1_sel.hw,
> +	[CLKID_DSPA_1_DIV]		= &dspa_1_div.hw,
> +	[CLKID_DSPA_1]			= &dspa_1.hw,
> +	[CLKID_DSPA]			= &dspa.hw,
> +	[CLKID_NNA_CORE_SEL]		= &nna_core_sel.hw,
> +	[CLKID_NNA_CORE_DIV]		= &nna_core_div.hw,
> +	[CLKID_NNA_CORE]		= &nna_core.hw,
> +	[CLKID_NNA_AXI_SEL]		= &nna_axi_sel.hw,
> +	[CLKID_NNA_AXI_DIV]		= &nna_axi_div.hw,
> +	[CLKID_NNA_AXI]			= &nna_axi.hw,
> +};
> +
> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const a5_periphs_clk_regmaps[] = {
> +	&rtc_xtal_clkin,
> +	&rtc_32k_div,
> +	&rtc_32k_mux,
> +	&rtc_32k,
> +	&rtc_clk,
> +	&sys_reset_ctrl,
> +	&sys_pwr_ctrl,
> +	&sys_pad_ctrl,
> +	&sys_ctrl,
> +	&sys_ts_pll,
> +	&sys_dev_arb,
> +	&sys_mailbox,
> +	&sys_jtag_ctrl,
> +	&sys_ir_ctrl,
> +	&sys_msr_clk,
> +	&sys_rom,
> +	&sys_cpu_apb,
> +	&sys_rsa,
> +	&sys_sar_adc,
> +	&sys_startup,
> +	&sys_secure,
> +	&sys_spifc,
> +	&sys_dspa,
> +	&sys_nna,
> +	&sys_eth_mac,
> +	&sys_rama,
> +	&sys_ramb,
> +	&sys_audio_top,
> +	&sys_audio_vad,
> +	&sys_usb,
> +	&sys_sd_emmc_a,
> +	&sys_sd_emmc_c,
> +	&sys_pwm_ab,
> +	&sys_pwm_cd,
> +	&sys_pwm_ef,
> +	&sys_pwm_gh,
> +	&sys_spicc_1,
> +	&sys_spicc_0,
> +	&sys_uart_a,
> +	&sys_uart_b,
> +	&sys_uart_c,
> +	&sys_uart_d,
> +	&sys_uart_e,
> +	&sys_i2c_m_a,
> +	&sys_i2c_m_b,
> +	&sys_i2c_m_c,
> +	&sys_i2c_m_d,
> +	&sys_rtc,
> +	&axi_audio_vad,
> +	&axi_audio_top,
> +	&axi_ramb,
> +	&axi_rama,
> +	&axi_nna,
> +	&axi_dev1_dmc,
> +	&axi_dev0_dmc,
> +	&axi_dsp_dmc,
> +	&clk_12_24m_in,
> +	&clk_12_24m,
> +	&fclk_25m_div,
> +	&fclk_25m,
> +	&gen_sel,
> +	&gen_div,
> +	&gen,
> +	&saradc_sel,
> +	&saradc_div,
> +	&saradc,
> +	&pwm_a_sel,
> +	&pwm_a_div,
> +	&pwm_a,
> +	&pwm_b_sel,
> +	&pwm_b_div,
> +	&pwm_b,
> +	&pwm_c_sel,
> +	&pwm_c_div,
> +	&pwm_c,
> +	&pwm_d_sel,
> +	&pwm_d_div,
> +	&pwm_d,
> +	&pwm_e_sel,
> +	&pwm_e_div,
> +	&pwm_e,
> +	&pwm_f_sel,
> +	&pwm_f_div,
> +	&pwm_f,
> +	&pwm_g_sel,
> +	&pwm_g_div,
> +	&pwm_g,
> +	&pwm_h_sel,
> +	&pwm_h_div,
> +	&pwm_h,
> +	&spicc_0_sel,
> +	&spicc_0_div,
> +	&spicc_0,
> +	&spicc_1_sel,
> +	&spicc_1_div,
> +	&spicc_1,
> +	&sd_emmc_a_sel,
> +	&sd_emmc_a_div,
> +	&sd_emmc_a,
> +	&sd_emmc_c_sel,
> +	&sd_emmc_c_div,
> +	&sd_emmc_c,
> +	&ts_div,
> +	&ts,
> +	&eth_125m,
> +	&eth_rmii_div,
> +	&eth_rmii,
> +	&dspa_0_sel,
> +	&dspa_0_div,
> +	&dspa_0,
> +	&dspa_1_sel,
> +	&dspa_1_div,
> +	&dspa_1,
> +	&dspa,
> +	&nna_core_sel,
> +	&nna_core_div,
> +	&nna_core,
> +	&nna_axi_sel,
> +	&nna_axi_div,
> +	&nna_axi
> +};
> +
> +static const struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +	.max_register   = CLKCTRL_NNA_CLK_CNTL,
> +};
> +
> +static struct meson_clk_hw_data a5_periphs_clks = {
> +	.hws = a5_periphs_hw_clks,
> +	.num = ARRAY_SIZE(a5_periphs_hw_clks),
> +};
> +
> +static int aml_a5_peripherals_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int clkid, ret, i;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(a5_periphs_clk_regmaps); i++)
> +		a5_periphs_clk_regmaps[i]->map = regmap;
> +
> +	for (clkid = 0; clkid < a5_periphs_clks.num; clkid++) {
> +		/* array might be sparse */
> +		if (!a5_periphs_clks.hws[clkid])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, a5_periphs_clks.hws[clkid]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
> +					   &a5_periphs_clks);
> +}
> +
> +static const struct of_device_id a5_peripherals_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,a5-peripherals-clkc",
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, a5_peripherals_clkc_match_table);
> +
> +static struct platform_driver a5_peripherals_driver = {
> +	.probe		= aml_a5_peripherals_probe,
> +	.driver		= {
> +		.name	= "a5-peripherals-clkc",
> +		.of_match_table = a5_peripherals_clkc_match_table,
> +	},
> +};
> +module_platform_driver(a5_peripherals_driver);
> +
> +MODULE_DESCRIPTION("Amlogic A5 Peripherals Clock Controller driver");
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
> index e365312da54e..1e592d809bfd 100644
> --- a/drivers/clk/meson/clk-regmap.h
> +++ b/drivers/clk/meson/clk-regmap.h
> @@ -134,4 +134,21 @@ struct clk_regmap _name = {						\
>  
>  #define MESON_PCLK_RO(_name, _reg, _bit, _pname)	\
>  	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname)
> +

No Amlogic specific clocks should be added to this header.
This was meant to be generic. 

> +#define MESON_CLK_GATE_FW(_name, _reg, _bit, _fw_name, _ops, _flags)	\
> +struct clk_regmap _name = {						\
> +	.data = &(struct clk_regmap_gate_data){				\
> +		.offset = (_reg),					\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = #_name,						\
> +		.ops = _ops,						\
> +		.parent_data = &(const struct clk_parent_data) {	\
> +			.fw_name = #_fw_name,				\

I think is making the macro difficult to read when used. Pass a string,
that will be a lot more clear and will not look like a weird identitier.

> +		},							\
> +		.num_parents = 1,					\
> +		.flags = (_flags),					\
> +	},								\
> +}

Given that this is used in A5 only for now, I don't think this needs to
be in a header just yet. You'll modify this when needed.

>  #endif /* __CLK_REGMAP_H */

-- 
Jerome

