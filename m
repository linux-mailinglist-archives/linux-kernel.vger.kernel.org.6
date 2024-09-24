Return-Path: <linux-kernel+bounces-337275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3254C9847F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E761F21BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798451AAE1A;
	Tue, 24 Sep 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FrY9Udx8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1050519F13A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189144; cv=none; b=nFWAT0SbrZo18766Y+w+x3zkG4fq4RwvgZRHz5o8bAfMo1VP5uoOmeylS4MsiNaje3h+1tT+77C9suDBFdcaFgmNlJuOmlA3iXEd96b1I7AnS09Nh6kidAxVYx3FjfflmVepZVsrh2ktmDO637/F9QnKDCkco5Lt9QFX+laeh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189144; c=relaxed/simple;
	bh=8fJ1xVgDM38wnQzePT334R11xflYMbZ9NvMk3uALwpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UnNotuJTZYLkLun93PunXajsd6zfMc+MZuM03/lRYQAjJb+qtUNDJLgsSTmmI18embCoA4WiJPsS+V6dEyhyStQlpeikn0F8TQC1RXfDu6sUwJrxx2rskuX6rVVVHXbBd73ZbHD+ywFGpXuqVD8eExjVS9YuJfzK0ZlEY2MbsWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FrY9Udx8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so72352425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727189140; x=1727793940; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eagbcf49QwIVxdJDLPSGMzMNC9Pcuf/EG2UvHVQ/FqM=;
        b=FrY9Udx8Lpe8J0AEMc/j3Pe2qQmCAUgleV60GoCyoUrIA+OZHpmErjD8lnY5sX1etk
         Aunu/oplUCj1xodcg/ydTxNloZN6UF3nJjhh88XdFS8SJ5d7IhqYnKOjw1zil9nGfCA3
         oSzQ5dQXjYhjOS/jVatYUJm35ZE0N/S7ybJDzo3oD+r5+ZMFQgQvq7hrqjVnGr7GDtld
         SaAwpXtd8db46SXQUdkIp8DXVCdZBkP9Nu7/PJjtq5hVV0IhGrCbgcp2M9/5X/bE17q0
         VMGcOPrF1cwzAbwnrvFHEjgDONi2CxSm1dW1KHQI0fK2cW6WIlqu7i6Ss1IQKfyjK3Qg
         M3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727189140; x=1727793940;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eagbcf49QwIVxdJDLPSGMzMNC9Pcuf/EG2UvHVQ/FqM=;
        b=VBR9f7KKvU1qF+BWroMkN3jyoWM7artiPui6RDvP0gC4jr8EwuAk86D9YXg24TmFv0
         cpsb9tIN0kZGqPbG3yZ5uifGadLbCH84iVOROWXTumjCsM7gGYPHZgPw9m1x5BzhTZv6
         PzltAlbJW84/DYafd7j3fswU3TVRPTs6Nzu+BLINipPTflc4vBolEQuL3ZZV468bWyXl
         2wrNIj7wJsotaPEF5cu3Kh23gQ2cy0SnnWsZqdUFlR1p/Br6CdxwmqhY7d/DlKtiR739
         4e3J9GCZLNsGjdD9ppcxZeXkS7Bg6CcT2MMh0PSfpZayH6l4ubU0ScKNMG9o+HwdC3V0
         fZCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnglvolnFcfwq1d0EOvwiQ853hVUMOefyrhM3NZ44LyR8lHKD4XFDyDld+nzaVqTyHNCQrGHMsYbGiYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDwmysIfpxlbpipV13zGTBmLkOwk7kDubFSsots1plwwVpukB
	wxRw6TVP0Zy67jn0qtSl9WsURLuihxKROg9q3hekH1W8Dkacc2UVe4SeBBNrpnc=
X-Google-Smtp-Source: AGHT+IFu15CuZ6N50yhEMtqiJrUBUKg6wYBq1hIpHy7prWSVUCUaf5R0kOjGgpSxD/LbnqEGD5hSVg==
X-Received: by 2002:adf:f292:0:b0:374:d254:61b3 with SMTP id ffacd0b85a97d-37a42277de5mr13733204f8f.14.1727189140264;
        Tue, 24 Sep 2024 07:45:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e1a:2f3f:4335:573b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f9828sm1800496f8f.73.2024.09.24.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:45:39 -0700 (PDT)
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
Subject: Re: [PATCH 4/5] clk: meson: add support for the A5 SoC PLL clock
In-Reply-To: <20240914-a5-clk-v1-4-5ee2c4f1b08c@amlogic.com> (Xianwei Zhao
	via's message of "Sat, 14 Sep 2024 13:25:26 +0800")
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
	<20240914-a5-clk-v1-4-5ee2c4f1b08c@amlogic.com>
Date: Tue, 24 Sep 2024 16:45:37 +0200
Message-ID: <1jplotxg8e.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat 14 Sep 2024 at 13:25, Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Add the PLL clock controller driver for the Amlogic A5 SoC family.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |  14 ++
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/a5-pll.c | 553 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 568 insertions(+)
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 78f648c9c97d..2a713276e46c 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -132,6 +132,20 @@ config COMMON_CLK_A1_PERIPHERALS
>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>  	  controller to work.
>  
> +config COMMON_CLK_A5_PLL
> +	tristate "Amlogic A5 PLL clock controller"
> +	depends on ARM64
> +	default y
> +	imply ARM_SCMI_PROTOCOL

don't think this is needed, same as c3

> +	imply COMMON_CLK_SCMI
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the PLL clock controller on Amlogic AV40x device, AKA A5.
> +	  Say Y if you want the board to work, because PLLs are the parent
> +	  of most peripherals.
> +
>  config COMMON_CLK_C3_PLL
>  	tristate "Amlogic C3 PLL clock controller"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index bc56a47931c1..fc4b8a723145 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> +obj-$(CONFIG_COMMON_CLK_A5_PLL) += a5-pll.o
>  obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>  obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
> diff --git a/drivers/clk/meson/a5-pll.c b/drivers/clk/meson/a5-pll.c
> new file mode 100644
> index 000000000000..d96ed72ef8d4
> --- /dev/null
> +++ b/drivers/clk/meson/a5-pll.c
> @@ -0,0 +1,553 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Amlogic A5 PLL Controller Driver
> + *
> + * Copyright (c) 2024 Amlogic, inc.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "clk-mpll.h"

Kconfig does not select support for this, so something is odd.

> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
> +
> +#define ANACTRL_FIXPLL_CTRL1			0x44
> +#define ANACTRL_GP0PLL_CTRL0			0x80
> +#define ANACTRL_GP0PLL_CTRL1			0x84
> +#define ANACTRL_GP0PLL_CTRL2			0x88
> +#define ANACTRL_GP0PLL_CTRL3			0x8c
> +#define ANACTRL_GP0PLL_CTRL4			0x90
> +#define ANACTRL_GP0PLL_CTRL5			0x94
> +#define ANACTRL_GP0PLL_CTRL6			0x98
> +#define ANACTRL_HIFIPLL_CTRL0			0x100
> +#define ANACTRL_HIFIPLL_CTRL1			0x104
> +#define ANACTRL_HIFIPLL_CTRL2			0x108
> +#define ANACTRL_HIFIPLL_CTRL3			0x10c
> +#define ANACTRL_HIFIPLL_CTRL4			0x110
> +#define ANACTRL_HIFIPLL_CTRL5			0x114
> +#define ANACTRL_HIFIPLL_CTRL6			0x118
> +#define ANACTRL_MPLL_CTRL0			0x180
> +#define ANACTRL_MPLL_CTRL1			0x184
> +#define ANACTRL_MPLL_CTRL2			0x188
> +#define ANACTRL_MPLL_CTRL3			0x18c
> +#define ANACTRL_MPLL_CTRL4			0x190
> +#define ANACTRL_MPLL_CTRL5			0x194
> +#define ANACTRL_MPLL_CTRL6			0x198
> +#define ANACTRL_MPLL_CTRL7			0x19c
> +#define ANACTRL_MPLL_CTRL8			0x1a0
> +
> +static DEFINE_SPINLOCK(aml_clk_lock);

Re-submit you lock patch first and adjust please.

> +
> +static struct clk_fixed_factor mpll_prediv = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll_prediv",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix_dco"
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct reg_sequence mpll0_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x40000033 },
> +};
> +
> +static struct clk_regmap mpll0_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL1,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &aml_clk_lock,
> +		.init_regs = mpll0_init_regs,
> +		.init_count = ARRAY_SIZE(mpll0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap mpll0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL1,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &mpll0_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence mpll1_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL4,	.def = 0x40000033 },
> +};
> +
> +static struct clk_regmap mpll1_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL3,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &aml_clk_lock,
> +		.init_regs = mpll1_init_regs,
> +		.init_count = ARRAY_SIZE(mpll1_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll1_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap mpll1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL3,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &mpll1_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence mpll2_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL6,	.def = 0x40000033 },
> +};
> +
> +static struct clk_regmap mpll2_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL5,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &aml_clk_lock,
> +		.init_regs = mpll2_init_regs,
> +		.init_count = ARRAY_SIZE(mpll2_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll2_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap mpll2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL5,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &mpll2_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence mpll3_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL8,	.def = 0x40000033 },
> +};
> +
> +static struct clk_regmap mpll3_div = {
> +	.data = &(struct meson_clk_mpll_data){
> +		.sdm = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 0,
> +			.width   = 14,
> +		},
> +		.sdm_en = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 30,
> +			.width	 = 1,
> +		},
> +		.n2 = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 20,
> +			.width   = 9,
> +		},
> +		.ssen = {
> +			.reg_off = ANACTRL_MPLL_CTRL7,
> +			.shift   = 29,
> +			.width	 = 1,
> +		},
> +		.lock = &aml_clk_lock,
> +		.init_regs = mpll3_init_regs,
> +		.init_count = ARRAY_SIZE(mpll3_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll3_div",
> +		.ops = &meson_clk_mpll_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mpll_prediv.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap mpll3 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = ANACTRL_MPLL_CTRL7,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "mpll3",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &mpll3_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence gp0_init_regs[] = {
> +	{ .reg = ANACTRL_GP0PLL_CTRL0, .def = 0X08000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL1, .def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL2, .def = 0x00000000 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL3, .def = 0x6a295c00 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL4, .def = 0x65771290 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL5, .def = 0x3927200a },
> +	{ .reg = ANACTRL_GP0PLL_CTRL6, .def = 0x54540000 }
> +};
> +
> +static const struct pll_mult_range gp0_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +static struct clk_regmap gp0_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &gp0_pll_mult_range,
> +		.init_regs = gp0_init_regs,
> +		.init_count = ARRAY_SIZE(gp0_init_regs),
> +		.frac_max = 100000,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp0_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/* The maximum frequency divider supports is 16, not 128(2^7) */
> +static const struct clk_div_table gp0_pll_od_table[] = {
> +	{ 0,  1 },
> +	{ 1,  2 },
> +	{ 2,  4 },
> +	{ 3,  8 },
> +	{ 4, 16 },
> +	{ 5, 32 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap gp0_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_GP0PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.table = gp0_pll_od_table,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gp0_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL0, .def = 0X08000000 },

What is bit you are flipping in CTRL0 ? it is suspicious

> +	{ .reg = ANACTRL_HIFIPLL_CTRL1, .def = 0x00000000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2, .def = 0x00000000 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3, .def = 0x6a295c00 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL6, .def = 0x54540000 }
> +};
> +
> +static const struct pll_mult_range hifi_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +static struct clk_regmap hifi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 17,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &hifi_pll_mult_range,
> +		.init_regs = hifi_init_regs,
> +		.init_count = ARRAY_SIZE(hifi_init_regs),
> +		.frac_max = 100000,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hifi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/* The maximum frequency divider supports is 16, not 128(2^7) */
> +static const struct clk_div_table hifi_pll_od_table[] = {
> +	{ 0,  1 },
> +	{ 1,  2 },
> +	{ 2,  4 },
> +	{ 3,  8 },

Why don't you ajust the mask then ? Looks like a POW_OF_2 basic
dividider to me.

> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap hifi_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_HIFIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.table = hifi_pll_od_table,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hifi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_hw *a5_pll_hw_clks[] = {
> +	[CLKID_MPLL_PREDIV]	= &mpll_prediv.hw,
> +	[CLKID_MPLL0_DIV]	= &mpll0_div.hw,
> +	[CLKID_MPLL0]		= &mpll0.hw,
> +	[CLKID_MPLL1_DIV]	= &mpll1_div.hw,
> +	[CLKID_MPLL1]		= &mpll1.hw,
> +	[CLKID_MPLL2_DIV]	= &mpll2_div.hw,
> +	[CLKID_MPLL2]		= &mpll2.hw,
> +	[CLKID_MPLL3_DIV]	= &mpll3_div.hw,
> +	[CLKID_MPLL3]		= &mpll3.hw,
> +	[CLKID_GP0_PLL_DCO]	= &gp0_pll_dco.hw,
> +	[CLKID_GP0_PLL]		= &gp0_pll.hw,
> +	[CLKID_HIFI_PLL_DCO]	= &hifi_pll_dco.hw,
> +	[CLKID_HIFI_PLL]	= &hifi_pll.hw
> +};
> +
> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const a5_pll_clk_regmaps[] = {
> +	&mpll0_div,
> +	&mpll0,
> +	&mpll1_div,
> +	&mpll1,
> +	&mpll2_div,
> +	&mpll2,
> +	&mpll3_div,
> +	&mpll3,
> +	&gp0_pll_dco,
> +	&gp0_pll,
> +	&hifi_pll_dco,
> +	&hifi_pll
> +};
> +
> +static const struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +	.max_register   = ANACTRL_MPLL_CTRL8,
> +};
> +
> +static struct meson_clk_hw_data a5_pll_clks = {
> +	.hws = a5_pll_hw_clks,
> +	.num = ARRAY_SIZE(a5_pll_hw_clks),
> +};
> +
> +static int aml_a5_pll_probe(struct platform_device *pdev)
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
> +	for (i = 0; i < ARRAY_SIZE(a5_pll_clk_regmaps); i++)
> +		a5_pll_clk_regmaps[i]->map = regmap;
> +
> +	for (clkid = 0; clkid < a5_pll_clks.num; clkid++) {
> +		/* array might be sparse */
> +		if (!a5_pll_clks.hws[clkid])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, a5_pll_clks.hws[clkid]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
> +					   &a5_pll_clks);
> +}
> +
> +static const struct of_device_id a5_pll_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,a5-pll-clkc",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, a5_pll_clkc_match_table);
> +
> +static struct platform_driver a5_pll_driver = {
> +	.probe		= aml_a5_pll_probe,
> +	.driver		= {
> +		.name	= "a5-pll-clkc",
> +		.of_match_table = a5_pll_clkc_match_table,
> +	},
> +};
> +module_platform_driver(a5_pll_driver);
> +
> +MODULE_DESCRIPTION("Amlogic A5 PLL Clock Controller driver");
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");

-- 
Jerome

