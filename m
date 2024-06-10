Return-Path: <linux-kernel+bounces-207987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAEF901EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6D41C20E25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD7579DDB;
	Mon, 10 Jun 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W9UB3Gs4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FDE770FC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013996; cv=none; b=VhURPXzcTt6yJHwFohJYrUWsPzUCMKdc50KgldLp0HcYP5kpv9vtrLKjWV0/baDPN31S5OLkv5YK5OjdEaoLam/e9Q68SErU6XpfJWvNQyaBg+LL1DgCifwNtHUcwKixIorcrnyfXdhw018P+rh6YoU2zGhZO1+5o7OIRYYnCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013996; c=relaxed/simple;
	bh=eyeEB0pVNy6ax2DqMra9iWUi+pmQyyHWFRFUBHoxNLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOcY9N5HYMCt2nnBK3zXhF31r3bwZTvj2B/HGmuX6y6opZKI92Oah3VDhPBT5O1IBxuM78BIU1DmaY6C2b8+BKVNp3ladJaSn8WJFDB2MlzX3UzUmWyPhZzJIMMjXepmvDfa4hauAKhIDDrx3LKGZowRERFu+brOjq6RjE+VxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W9UB3Gs4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42165f6645fso22567455e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718013992; x=1718618792; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=96tzMSkuz+y95qWSYHzxOV02rm0Ak7IbtGV/Yp7YxpM=;
        b=W9UB3Gs4Cs3X7PczPZkMd44sP/Fk55I3+GJwPqlETLPVviyGuRsdJh2KBaRWrinEHN
         npqytH2lHTq4QK6OwYdWUQRZbRKVXRkLkWlugVHt5pK75VU98OIubUpTnssuaaKfTg7d
         5AMfQPLgeO2WhE2eqJbhIW5IwpJbGFYQDvq+U3fVubZ1CRdK3RJGH2LgXF3Yn5bpZIT1
         oaApWQGNhWaHUMj/Egk9rsG9wFF/omLGcdSBbDF8+kgBoMH+jGV5ppqVLAgEzy3RlOnS
         rxkur5osnwS1DmoCXNYiap+0uI2XgpR1jXV1RaW8oxk65NS0A+Qz8BzShqY85P3tDI3l
         Z5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013992; x=1718618792;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96tzMSkuz+y95qWSYHzxOV02rm0Ak7IbtGV/Yp7YxpM=;
        b=HnzY4ud7cPDUOij/SC7n/MfU9LPPE8K/nW0aKgV1b6GUww/FPW6zrbsHfeIlV0ijsU
         grL4DaBIhMLs8ZEvye8Xao+pe+e6obzh5CZGxt9Bpd9o82nhjr9lz+s1QAdiyS53TuEb
         28klbP8njFkZJSbq5LWLUY2H4NbosGn7W8fXxBGrEkQdlw/xpk0kp9rI6STdJPwFF0L7
         w/naqbgD3L2HKCUG0nJNv5SNRQSezdhZWimSK8SjBrXrP4m8kGuqFOQNaArc8znYRHal
         /QnFEgjDi3HoLCZ4CucyBNuMnj1NBBH8ynuzUp0VRPOXC1h6E1QbfN8r28bEmgksLoSf
         ilQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFT4sgyjFHQkU+AgYGjcccSuCGn96rBmiy4WJzIOz88wGPTcZDQ/CYrshHAqMUjLhQFbk9ckmBNeKJdyij+tr1vB1CMKSe6+xu9Fus
X-Gm-Message-State: AOJu0Yx0j0sqhvX2VCI+hvt5Xyj4cAe+kN1okqBSmcaeX6oXO4z/YpAi
	1M86vSAv0j/0hrOf5k0RYxFLOGJMTPGKY/C3LTfVpireInmp3ZPauxu/I0M6qWA=
X-Google-Smtp-Source: AGHT+IEWWaqtWYvSO7vjsGdzF40QlEAxvsvaMQCUTWG+hvuKYP2BagrynMgxjjPCdhX1Y/aip4ag8g==
X-Received: by 2002:a05:600c:1e0f:b0:421:82ed:28eb with SMTP id 5b1f17b1804b1-42182ed2b70mr25245405e9.21.1718013992095;
        Mon, 10 Jun 2024 03:06:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:afd3:66ee:5486:4249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4216b398fd8sm102768185e9.23.2024.06.10.03.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:06:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: <neil.armstrong@linaro.org>,  <mturquette@baylibre.com>,
  <sboyd@kernel.org>,  <robh+dt@kernel.org>,
  <krzysztof.kozlowski+dt@linaro.org>,  <khilman@baylibre.com>,
  <martin.blumenstingl@googlemail.com>,  <jian.hu@amlogic.com>,
  <kernel@sberdevices.ru>,  <rockosov@gmail.com>,
  <linux-amlogic@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 7/7] clk: meson: a1: add Amlogic A1 CPU clock
 controller driver
In-Reply-To: <20240515185103.20256-8-ddrokosov@salutedevices.com> (Dmitry
	Rokosov's message of "Wed, 15 May 2024 21:47:30 +0300")
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
	<20240515185103.20256-8-ddrokosov@salutedevices.com>
Date: Mon, 10 Jun 2024 12:06:31 +0200
Message-ID: <1jmsntp0wo.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> The CPU clock controller plays a general role in the Amlogic A1 SoC
> family by generating CPU clocks. As an APB slave module, it offers the
> capability to inherit the CPU clock from two sources: the internal fixed
> clock known as 'cpu fixed clock' and the external input provided by the
> A1 PLL clock controller, referred to as 'syspll'.
>
> It is important for the driver to handle cpu_clk rate switching
> effectively by transitioning to the CPU fixed clock to avoid any
> potential execution freezes.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  drivers/clk/meson/Kconfig  |  10 ++
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/a1-cpu.c | 331 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 342 insertions(+)
>  create mode 100644 drivers/clk/meson/a1-cpu.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 80c4a18c83d2..148d4495eee3 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -111,6 +111,16 @@ config COMMON_CLK_AXG_AUDIO
>  	  Support for the audio clock controller on AmLogic A113D devices,
>  	  aka axg, Say Y if you want audio subsystem to work.
>  
> +config COMMON_CLK_A1_CPU
> +	tristate "Amlogic A1 SoC CPU controller support"
> +	depends on ARM64
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the CPU clock controller on Amlogic A113L based
> +	  device, A1 SoC Family. Say Y if you want A1 CPU clock controller
> +	  to work.
> +
>  config COMMON_CLK_A1_PLL
>  	tristate "Amlogic A1 SoC PLL controller support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 4968fc7ad555..2a06eb0303d6 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_COMMON_CLK_MESON_AUDIO_RSTC) += meson-audio-rstc.o
>  
>  obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
> +obj-$(CONFIG_COMMON_CLK_A1_CPU) += a1-cpu.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
> diff --git a/drivers/clk/meson/a1-cpu.c b/drivers/clk/meson/a1-cpu.c
> new file mode 100644
> index 000000000000..a9edabeafea9
> --- /dev/null
> +++ b/drivers/clk/meson/a1-cpu.c
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Amlogic A1 SoC family CPU Clock Controller driver.
> + *
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + * Author: Dmitry Rokosov <ddrokosov@salutedevices.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include "clk-regmap.h"
> +#include "meson-clkc-utils.h"
> +
> +#include <dt-bindings/clock/amlogic,a1-cpu-clkc.h>
> +
> +/* CPU Clock Controller register offset */
> +#define CPUCTRL_CLK_CTRL0	0x0
> +#define CPUCTRL_CLK_CTRL1	0x4
> +
> +static u32 cpu_fsource_sel_table[] = { 0, 1, 2 };
> +static const struct clk_parent_data cpu_fsource_sel_parents[] = {
> +	{ .fw_name = "xtal" },
> +	{ .fw_name = "fclk_div2" },
> +	{ .fw_name = "fclk_div3" },
> +};
> +
> +static struct clk_regmap cpu_fsource_sel0 = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.mask = 0x3,
> +		.shift = 0,
> +		.table = cpu_fsource_sel_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fsource_sel0",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = cpu_fsource_sel_parents,
> +		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
> +		.flags = CLK_SET_RATE_PARENT,

I don't think setting the rates of controller parents is appropriate

> +	},
> +};
> +
> +static struct clk_regmap cpu_fsource_div0 = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.shift = 4,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fsource_div0",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&cpu_fsource_sel0.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap cpu_fsel0 = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fsel0",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&cpu_fsource_sel0.hw,
> +			&cpu_fsource_div0.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap cpu_fsource_sel1 = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.mask = 0x3,
> +		.shift = 16,
> +		.table = cpu_fsource_sel_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fsource_sel1",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = cpu_fsource_sel_parents,
> +		.num_parents = ARRAY_SIZE(cpu_fsource_sel_parents),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap cpu_fsource_div1 = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.shift = 20,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fsource_div1",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&cpu_fsource_sel1.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap cpu_fsel1 = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 18,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fsel1",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&cpu_fsource_sel1.hw,
> +			&cpu_fsource_div1.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap cpu_fclk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_fclk",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&cpu_fsel0.hw,
> +			&cpu_fsel1.hw,
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap cpu_clk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = CPUCTRL_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cpu_clk",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = (const struct clk_parent_data []) {
> +			{ .hw = &cpu_fclk.hw },
> +			{ .fw_name = "sys_pll", },
> +		},

You've put CLK_SET_RATE_GATE on fixed clock path but not the SYS_PLL
... that is odd. IMO there should be a bypass input clock to the sys_pll
with that flag.

> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +	},
> +};
> +
> +/* Array of all clocks registered by this provider */
> +static struct clk_hw *a1_cpu_hw_clks[] = {
> +	[CLKID_CPU_FSOURCE_SEL0]	= &cpu_fsource_sel0.hw,
> +	[CLKID_CPU_FSOURCE_DIV0]	= &cpu_fsource_div0.hw,
> +	[CLKID_CPU_FSEL0]		= &cpu_fsel0.hw,
> +	[CLKID_CPU_FSOURCE_SEL1]	= &cpu_fsource_sel1.hw,
> +	[CLKID_CPU_FSOURCE_DIV1]	= &cpu_fsource_div1.hw,
> +	[CLKID_CPU_FSEL1]		= &cpu_fsel1.hw,
> +	[CLKID_CPU_FCLK]		= &cpu_fclk.hw,
> +	[CLKID_CPU_CLK]			= &cpu_clk.hw,
> +};
> +
> +static struct clk_regmap *const a1_cpu_regmaps[] = {
> +	&cpu_fsource_sel0,
> +	&cpu_fsource_div0,
> +	&cpu_fsel0,
> +	&cpu_fsource_sel1,
> +	&cpu_fsource_div1,
> +	&cpu_fsel1,
> +	&cpu_fclk,
> +	&cpu_clk,
> +};
> +
> +static struct regmap_config a1_cpu_regmap_cfg = {
> +	.reg_bits   = 32,
> +	.val_bits   = 32,
> +	.reg_stride = 4,
> +	.max_register = CPUCTRL_CLK_CTRL1,
> +};
> +
> +static struct meson_clk_hw_data a1_cpu_clks = {
> +	.hws = a1_cpu_hw_clks,
> +	.num = ARRAY_SIZE(a1_cpu_hw_clks),
> +};
> +
> +struct a1_sys_pll_nb_data {
> +	struct notifier_block nb;
> +	struct clk_hw *cpu_clk;
> +	struct clk_hw *cpu_fclk;
> +	struct clk *sys_pll;
> +};

There are number of things which are wrong with this notifier.

First, and foremost, this is a clock controller driver ... it should not
handle cpufreq policy. There is subsystem for that

> +
> +static int meson_a1_sys_pll_notifier_cb(struct notifier_block *nb,
> +					unsigned long event, void *data)
> +{
> +	struct a1_sys_pll_nb_data *nbd;
> +	int ret = 0;
> +
> +	nbd = container_of(nb, struct a1_sys_pll_nb_data, nb);
> +
> +	switch (event) {
> +	case PRE_RATE_CHANGE:
> +		/*
> +		 * Clock sys_pll will be changed to feed cpu_clk,
> +		 * configure cpu_clk to use cpu_fclk fixed clock.
> +		 */
> +		ret = clk_hw_set_parent(nbd->cpu_clk, nbd->cpu_fclk);


This jumps to whatever was the last frequency below 768MHz ... that does
not seems deterministic or safe.
> +
> +		/* Wait for clock propagation */
> +		if (!ret)
> +			udelay(100);
> +
> +		break;
> +
> +	case POST_RATE_CHANGE:
> +		 /*
> +		  * Clock sys_pll rate has ben calculated,
> +		  * switch back cpu_clk to sys_pll
> +		  */
> +		ret = clk_set_parent(nbd->cpu_clk->clk, nbd->sys_pll);

So whenever sys_pll changes, even if was not used by the CPU at that
time, this will change back to the sys_pll. Again, that seems fragile

> +
> +		/* Wait for clock propagation */
> +		if (!ret)
> +			udelay(100);
> +		break;
> +
> +	default:
> +		pr_warn("Unknown event %lu for sys_pll notifier\n", event);
> +		break;
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
> +static struct a1_sys_pll_nb_data a1_sys_pll_nb_data = {
> +	.nb.notifier_call = meson_a1_sys_pll_notifier_cb,
> +	.cpu_clk = &cpu_clk.hw,
> +	.cpu_fclk = &cpu_fclk.hw,
> +};
> +
> +static int meson_a1_dvfs_setup(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk *sys_pll;
> +	int ret;
> +
> +	/* Setup clock notifier for sys_pll clk */
> +	sys_pll = devm_clk_get(dev, "sys_pll");
> +	if (IS_ERR(sys_pll))
> +		return dev_err_probe(dev, PTR_ERR(sys_pll),
> +				     "can't get sys_pll as notifier clock\n");
> +
> +	a1_sys_pll_nb_data.sys_pll = sys_pll;
> +	ret = devm_clk_notifier_register(dev, sys_pll,
> +					 &a1_sys_pll_nb_data.nb);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "can't register sys_pll notifier\n");
> +
> +	return ret;
> +}

I don't think these notifiers are appropriate to handle CPU frequency
change. Cpufreq has a .target_intermediate() callback that seems more
appropriate to switch the CPU to a safe clock while relocking a PLL.

You should have a look at it and probably at the imx-cpufreq-dt.c which
improves on cpufreq-dt.c to handle platform quirks

> +
> +static int meson_a1_cpu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	struct regmap *map;
> +	int clkid, i, err;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "can't ioremap resource\n");
> +
> +	map = devm_regmap_init_mmio(dev, base, &a1_cpu_regmap_cfg);
> +	if (IS_ERR(map))
> +		return dev_err_probe(dev, PTR_ERR(map),
> +				     "can't init regmap mmio region\n");
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(a1_cpu_regmaps); i++)
> +		a1_cpu_regmaps[i]->map = map;
> +
> +	for (clkid = 0; clkid < a1_cpu_clks.num; clkid++) {
> +		err = devm_clk_hw_register(dev, a1_cpu_clks.hws[clkid]);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "clock[%d] registration failed\n",
> +					     clkid);
> +	}
> +
> +	err = devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, &a1_cpu_clks);
> +	if (err)
> +		return dev_err_probe(dev, err, "can't add clk hw provider\n");
> +
> +	return meson_a1_dvfs_setup(pdev);
> +}
> +
> +static const struct of_device_id a1_cpu_clkc_match_table[] = {
> +	{ .compatible = "amlogic,a1-cpu-clkc", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, a1_cpu_clkc_match_table);
> +
> +static struct platform_driver a1_cpu_clkc_driver = {
> +	.probe = meson_a1_cpu_probe,
> +	.driver = {
> +		.name = "a1-cpu-clkc",
> +		.of_match_table = a1_cpu_clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(a1_cpu_clkc_driver);
> +MODULE_AUTHOR("Dmitry Rokosov <ddrokosov@salutedevices.com>");
> +MODULE_LICENSE("GPL");

-- 
Jerome

