Return-Path: <linux-kernel+bounces-229482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4B691700B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1BC1C21001
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04F17A906;
	Tue, 25 Jun 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcuF7eJ+"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43516176AA9;
	Tue, 25 Jun 2024 18:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339578; cv=none; b=eS+35FjXB7PZdbpnPMgsTI4nwWjItxdhg6URG5qM4IjCetOjQoDGG+7kbGdfNqPPttzEID0vN5rXg0fGct0f6CUUe2XZDP1W5WvUBZZLST0IV1Z/SrMxOjhySfn/d2+coRB7j3VMXb8pD3J9w9obprMZrxNzUz8NTyuIwGRhkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339578; c=relaxed/simple;
	bh=G9nVLckVbalcz7AF96XduiW+NSFUOb7PWQGQ1T8xLys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jN8HqvbVTm4zeuwxCwQIG2qka6XWl+QMAANEWppGjvveayBHiIb7mdqDq/tgk8eDYFbi4MmB7N6rlIf4w1VbcvE5T7pIbU1rsoUsCzdGnPbowVBSaL8hf2VIswOnaAegZqr4FXD9yTcV91AutaZDz2BvLg1NuSiqeoOdw+z2yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcuF7eJ+; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff0712ede2so5718525276.2;
        Tue, 25 Jun 2024 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719339575; x=1719944375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fyBJioLXIpjF0sbjo/dg+Z+gxdmeIxxulfXpSERqaRM=;
        b=kcuF7eJ+W/TzHUoCqeU9DLFmDHHzkyyITVWXN42EeJkedSHgz1xuwM3Z3/lmWx/J3c
         1uB8mAKP9J4CFy0wmKmi2A1QMghI5GhnXRbQ2nvYrv61oFLuGRV9BOdGzu3aMBNktoI/
         A/9hDP4pjaTcpHWPPxeQfx/m6Jk9Rlmx4fP/wNnh7GFwF8ghsDEV8DvBK/SYQg4dEMN5
         iJbMIOmfGeMnPDTrIbgCSwgXXXmzKzRqYr7k7DgIXxdLR4uud0AI39d8pNSd9oQ/1ctq
         b09iS4rDJDzTu0U09zwcVz9kty5vv/erkKuvHrM9v16swh0f+gql56keJk7TCOFasxSr
         6DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339575; x=1719944375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyBJioLXIpjF0sbjo/dg+Z+gxdmeIxxulfXpSERqaRM=;
        b=DVhilXdtoDbGbO5f/QlQWh8l5qJp30KCqfx9d4XlrgXBeF1n+MhR13vKBvprh7gHLV
         Kssx7Ng6a+AMU1fqJ3Z273GdVqEpjXiVoFRtGY0rEDPLtZL7mgIESnpuDtNFkzHNVgFQ
         Ey/SB4QfMiw70uvTSp7WiOd1DhZMqFoTZNLAg0jwMOfpKaSfGBS+tHfAHiLjeVSTBuhf
         zoC94vfK/d7cWrAjT6aZsCovEwzTSB9aQSqAt/AaB3hD2o1i1BVV9/gA+tuwbr/Q240Z
         IH8TZyN+n5z2XMrZ7/RHCu17PvmBw8lxyUQcwxDe5lAMDSCt3s1FmrOzQ/JJ1V2EYRY8
         gtUw==
X-Forwarded-Encrypted: i=1; AJvYcCW0WGR6LPW/9ewC0/OQrcIGw9ySsdS08tu4dqksjPXBEMpNG5RpKPfzG7QDAfqpAp4TfTb3gguNIQUKeJCu9Y7Y8LZ5w9tkQu8gckjR5u9fO2X7xB1k6kRuye2Pnu4uMF/K2UHSqQkv
X-Gm-Message-State: AOJu0Yy4ypFHtIQ/KUCx5f81rLEOJeyF7Z4BVYmRV34MhUrzh5Af7BwV
	NliGF1NYOFd6m6djbYkGlSKTGtB8cZ/wTRuWsZLjWqJ9nJbeS9+ejmNzPKStoXXrqqZugrDeyi3
	MK8quXcFpkvIVslm0EXhL2Rcry4o=
X-Google-Smtp-Source: AGHT+IEpIRg19ikIBxXTLMQ9ae20y120mh0yFUf/O/AFIpMTaSyaHOySVzmAzjnnk0bICo7dP5EoDKamvcnE87+LUFo=
X-Received: by 2002:a25:bc89:0:b0:e02:b590:3e2c with SMTP id
 3f1490d57ef6-e0303f3f5ccmr7812206276.24.1719339574985; Tue, 25 Jun 2024
 11:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618185819.2155595-1-tmaimon77@gmail.com> <20240618185819.2155595-4-tmaimon77@gmail.com>
In-Reply-To: <20240618185819.2155595-4-tmaimon77@gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 25 Jun 2024 21:19:24 +0300
Message-ID: <CAP6Zq1hvFi1AAzGOZRQdo9dd1bEB6MM2fDT1TH8fLozjLjQnXA@mail.gmail.com>
Subject: Re: [PATCH v25 3/3] clk: npcm8xx: add clock controller
To: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, 
	joel@jms.id.au, venture@google.com, yuenn@google.com, benjaminfair@google.com
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stephan,

I would appreciate it if you could review the patch.

Thanks,

Tomer

On Tue, 18 Jun 2024 at 22:05, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add auxiliary driver to support Nuvoton Arbel BMC NPCM8XX contains an
> integrated clock controller which generates and supplies clocks to all
> modules within the BMC.
>
> The NPCM8xx clock controller is created using the auxiliary device framework
> and set up in the npcm reset driver since the NPCM8xx clock is using the
> same register region.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/clk/Kconfig       |   8 +
>  drivers/clk/Makefile      |   1 +
>  drivers/clk/clk-npcm8xx.c | 429 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 438 insertions(+)
>  create mode 100644 drivers/clk/clk-npcm8xx.c
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3e9099504fad..9abe32314ad5 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -334,6 +334,14 @@ config COMMON_CLK_LOCHNAGAR
>           This driver supports the clocking features of the Cirrus Logic
>           Lochnagar audio development board.
>
> +config COMMON_CLK_NPCM8XX
> +       tristate "Clock driver for the NPCM8XX SoC Family"
> +       depends on ARCH_NPCM || COMPILE_TEST
> +       help
> +         This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family,
> +         all the clocks are initialized by the bootloader, so this driver
> +         allows only reading of current settings directly from the hardware.
> +
>  config COMMON_CLK_LOONGSON2
>         bool "Clock driver for Loongson-2 SoC"
>         depends on LOONGARCH || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 4abe16c8ccdf..e63487274d87 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)      += clk-milbeaut.o
>  obj-$(CONFIG_ARCH_MOXART)              += clk-moxart.o
>  obj-$(CONFIG_ARCH_NOMADIK)             += clk-nomadik.o
>  obj-$(CONFIG_ARCH_NPCM7XX)             += clk-npcm7xx.o
> +obj-$(CONFIG_COMMON_CLK_NPCM8XX)       += clk-npcm8xx.o
>  obj-$(CONFIG_ARCH_NSPIRE)              += clk-nspire.o
>  obj-$(CONFIG_COMMON_CLK_PALMAS)                += clk-palmas.o
>  obj-$(CONFIG_CLK_LS1028A_PLLDIG)       += clk-plldig.o
> diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
> new file mode 100644
> index 000000000000..979877c6b14c
> --- /dev/null
> +++ b/drivers/clk/clk-npcm8xx.c
> @@ -0,0 +1,429 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nuvoton NPCM8xx Clock Generator
> + * All the clocks are initialized by the bootloader, so this driver allows only
> + * reading of current settings directly from the hardware.
> + *
> + * Copyright (C) 2020 Nuvoton Technologies
> + * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
> + */
> +
> +#define pr_fmt(fmt) "npcm8xx_clk: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
> +#include <soc/nuvoton/clock-npcm8xx.h>
> +
> +/* npcm8xx clock registers*/
> +#define NPCM8XX_CLKSEL         0x04
> +#define NPCM8XX_CLKDIV1                0x08
> +#define NPCM8XX_CLKDIV2                0x2C
> +#define NPCM8XX_CLKDIV3                0x58
> +#define NPCM8XX_CLKDIV4                0x7C
> +#define NPCM8XX_PLLCON0                0x0C
> +#define NPCM8XX_PLLCON1                0x10
> +#define NPCM8XX_PLLCON2                0x54
> +#define NPCM8XX_PLLCONG                0x60
> +#define NPCM8XX_THRTL_CNT      0xC0
> +
> +#define PLLCON_LOKI    BIT(31)
> +#define PLLCON_LOKS    BIT(30)
> +#define PLLCON_FBDV    GENMASK(27, 16)
> +#define PLLCON_OTDV2   GENMASK(15, 13)
> +#define PLLCON_PWDEN   BIT(12)
> +#define PLLCON_OTDV1   GENMASK(10, 8)
> +#define PLLCON_INDV    GENMASK(5, 0)
> +
> +static void __iomem *clk_base;
> +
> +struct npcm8xx_clk_pll {
> +       void __iomem    *pllcon;
> +       unsigned int    id;
> +       const char      *name;
> +       unsigned long   flags;
> +       struct clk_hw   hw;
> +};
> +
> +#define to_npcm8xx_clk_pll(_hw) container_of(_hw, struct npcm8xx_clk_pll, hw)
> +
> +struct npcm8xx_clk_pll_data {
> +       const char *name;
> +       struct clk_parent_data parent;
> +       unsigned int reg;
> +       unsigned long flags;
> +       struct clk_hw hw;
> +};
> +
> +struct npcm8xx_clk_div_data {
> +       u32 reg;
> +       u8 shift;
> +       u8 width;
> +       const char *name;
> +       const struct clk_hw *parent_hw;
> +       unsigned long clk_divider_flags;
> +       unsigned long flags;
> +       int onecell_idx;
> +       struct clk_hw hw;
> +};
> +
> +struct npcm8xx_clk_mux_data {
> +       u8 shift;
> +       u32 mask;
> +       const u32 *table;
> +       const char *name;
> +       const struct clk_parent_data *parent_data;
> +       u8 num_parents;
> +       unsigned long flags;
> +       struct clk_hw hw;
> +};
> +
> +static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
> +static struct npcm8xx_clk_pll_data npcm8xx_pll_clks[] = {
> +       { "pll0", { .index = 0 }, NPCM8XX_PLLCON0, 0 },
> +       { "pll1", { .index = 0 }, NPCM8XX_PLLCON1, 0 },
> +       { "pll2", { .index = 0 }, NPCM8XX_PLLCON2, 0 },
> +       { "pll_gfx", { .index = 0 }, NPCM8XX_PLLCONG, 0 },
> +};
> +
> +static const u32 cpuck_mux_table[] = { 0, 1, 2, 7 };
> +static const struct clk_parent_data cpuck_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 },
> +       { .hw = &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 pixcksel_mux_table[] = { 0, 2 };
> +static const struct clk_parent_data pixcksel_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[3].hw },
> +       { .index = 0 }
> +};
> +
> +static const u32 default_mux_table[] = { 0, 1, 2, 3 };
> +static const struct clk_parent_data default_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 },
> +       { .hw = &hw_pll2_div2 }
> +};
> +
> +static const u32 sucksel_mux_table[] = { 2, 3 };
> +static const struct clk_parent_data sucksel_mux_parents[] = {
> +       { .index = 0 },
> +       { .hw = &hw_pll2_div2 }
> +};
> +
> +static const u32 mccksel_mux_table[] = { 0, 2 };
> +static const struct clk_parent_data mccksel_mux_parents[] = {
> +       { .hw = &hw_pll1_div2 },
> +       { .index = 0 }
> +};
> +
> +static const u32 clkoutsel_mux_table[] = { 0, 1, 2, 3, 4 };
> +static const struct clk_parent_data clkoutsel_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 },
> +       { .hw = &hw_gfx_div2 },
> +       { .hw = &hw_pll2_div2 }
> +};
> +
> +static const u32 gfxmsel_mux_table[] = { 2, 3 };
> +static const struct clk_parent_data gfxmsel_mux_parents[] = {
> +       { .index = 0 },
> +       { .hw = &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 dvcssel_mux_table[] = { 2, 3 };
> +static const struct clk_parent_data dvcssel_mux_parents[] = {
> +       { .index = 0 },
> +       { .hw = &npcm8xx_pll_clks[2].hw }
> +};
> +
> +static const u32 default3_mux_table[] = { 0, 1, 2 };
> +static const struct clk_parent_data default3_mux_parents[] = {
> +       { .hw = &npcm8xx_pll_clks[0].hw },
> +       { .hw = &npcm8xx_pll_clks[1].hw },
> +       { .index = 0 }
> +};
> +
> +static struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
> +       { 0, 3, cpuck_mux_table, "cpu_mux", cpuck_mux_parents,
> +               ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL },
> +       { 4, 2, pixcksel_mux_table, "gfx_pixel_mux", pixcksel_mux_parents,
> +               ARRAY_SIZE(pixcksel_mux_parents), 0 },
> +       { 6, 2, default_mux_table, "sd_mux", default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 8, 2, default_mux_table, "uart_mux", default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 10, 2, sucksel_mux_table, "serial_usb_mux", sucksel_mux_parents,
> +               ARRAY_SIZE(sucksel_mux_parents), 0 },
> +       { 12, 2, mccksel_mux_table, "mc_mux", mccksel_mux_parents,
> +               ARRAY_SIZE(mccksel_mux_parents), 0 },
> +       { 14, 2, default_mux_table, "adc_mux", default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 16, 2, default_mux_table, "gfx_mux", default_mux_parents,
> +               ARRAY_SIZE(default_mux_parents), 0 },
> +       { 18, 3, clkoutsel_mux_table, "clkout_mux", clkoutsel_mux_parents,
> +               ARRAY_SIZE(clkoutsel_mux_parents), 0 },
> +       { 21, 2, gfxmsel_mux_table, "gfxm_mux", gfxmsel_mux_parents,
> +               ARRAY_SIZE(gfxmsel_mux_parents), 0 },
> +       { 23, 2, dvcssel_mux_table, "dvc_mux", dvcssel_mux_parents,
> +               ARRAY_SIZE(dvcssel_mux_parents), 0 },
> +       { 25, 2, default3_mux_table, "rg_mux", default3_mux_parents,
> +               ARRAY_SIZE(default3_mux_parents), 0 },
> +       { 27, 2, default3_mux_table, "rcp_mux", default3_mux_parents,
> +               ARRAY_SIZE(default3_mux_parents), 0 },
> +};
> +
> +/* configurable pre dividers: */
> +static struct npcm8xx_clk_div_data npcm8xx_pre_divs[] = {
> +       { NPCM8XX_CLKDIV1, 21, 5, "pre_adc", &npcm8xx_muxes[6].hw, CLK_DIVIDER_READ_ONLY, 0, -1 },
> +       { NPCM8XX_CLKDIV1, 26, 2, "ahb", &hw_pre_clk, CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
> +};
> +
> +/* configurable dividers: */
> +static struct npcm8xx_clk_div_data npcm8xx_divs[] = {
> +       { NPCM8XX_CLKDIV1, 28, 3, "adc", &npcm8xx_pre_divs[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
> +       { NPCM8XX_CLKDIV1, 16, 5, "uart", &npcm8xx_muxes[3].hw, 0, 0, NPCM8XX_CLK_UART },
> +       { NPCM8XX_CLKDIV1, 11, 5, "mmc", &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC },
> +       { NPCM8XX_CLKDIV1, 6, 5, "spi3", &npcm8xx_pre_divs[1].hw, 0, 0, NPCM8XX_CLK_SPI3 },
> +       { NPCM8XX_CLKDIV1, 2, 4, "pci", &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI },
> +
> +       { NPCM8XX_CLKDIV2, 30, 2, "apb4", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB4 },
> +       { NPCM8XX_CLKDIV2, 28, 2, "apb3", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB3 },
> +       { NPCM8XX_CLKDIV2, 26, 2, "apb2", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB2 },
> +       { NPCM8XX_CLKDIV2, 24, 2, "apb1", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB1 },
> +       { NPCM8XX_CLKDIV2, 22, 2, "apb5", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB5 },
> +       { NPCM8XX_CLKDIV2, 16, 5, "clkout", &npcm8xx_muxes[8].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT },
> +       { NPCM8XX_CLKDIV2, 13, 3, "gfx", &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX },
> +       { NPCM8XX_CLKDIV2, 8, 5, "usb_bridge", &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU },
> +       { NPCM8XX_CLKDIV2, 4, 4, "usb_host", &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48 },
> +       { NPCM8XX_CLKDIV2, 0, 4, "sdhc", &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC },
> +
> +       { NPCM8XX_CLKDIV3, 16, 8, "spi1", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
> +       { NPCM8XX_CLKDIV3, 11, 5, "uart2", &npcm8xx_muxes[3].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2 },
> +       { NPCM8XX_CLKDIV3, 6, 5, "spi0", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
> +       { NPCM8XX_CLKDIV3, 1, 5, "spix", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
> +
> +       { NPCM8XX_CLKDIV4, 28, 4, "rg", &npcm8xx_muxes[11].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG },
> +       { NPCM8XX_CLKDIV4, 12, 4, "rcp", &npcm8xx_muxes[12].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP },
> +
> +       { NPCM8XX_THRTL_CNT, 0, 2, "th", &npcm8xx_muxes[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
> +};
> +
> +static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                                unsigned long parent_rate)
> +{
> +       struct npcm8xx_clk_pll *pll = to_npcm8xx_clk_pll(hw);
> +       unsigned long fbdv, indv, otdv1, otdv2;
> +       unsigned int val;
> +       u64 ret;
> +
> +       if (parent_rate == 0) {
> +               pr_debug("%s: parent rate is zero\n", __func__);
> +               return 0;
> +       }
> +
> +       val = readl_relaxed(pll->pllcon);
> +
> +       indv = FIELD_GET(PLLCON_INDV, val);
> +       fbdv = FIELD_GET(PLLCON_FBDV, val);
> +       otdv1 = FIELD_GET(PLLCON_OTDV1, val);
> +       otdv2 = FIELD_GET(PLLCON_OTDV2, val);
> +
> +       ret = (u64)parent_rate * fbdv;
> +       do_div(ret, indv * otdv1 * otdv2);
> +
> +       return ret;
> +}
> +
> +static const struct clk_ops npcm8xx_clk_pll_ops = {
> +       .recalc_rate = npcm8xx_clk_pll_recalc_rate,
> +};
> +
> +static struct clk_hw *
> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> +                        const char *name, const struct clk_parent_data *parent,
> +                        unsigned long flags)
> +{
> +       struct npcm8xx_clk_pll *pll;
> +       struct clk_init_data init = {};
> +       int ret;
> +
> +       pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &npcm8xx_clk_pll_ops;
> +       init.parent_data = parent;
> +       init.num_parents = 1;
> +       init.flags = flags;
> +
> +       pll->pllcon = pllcon;
> +       pll->hw.init = &init;
> +
> +       ret = devm_clk_hw_register(dev, &pll->hw);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       return &pll->hw;
> +}
> +
> +static DEFINE_SPINLOCK(npcm8xx_clk_lock);
> +
> +static int npcm8xx_clk_probe(struct auxiliary_device *adev,
> +                            const struct auxiliary_device_id *id)
> +{
> +       struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
> +       struct clk_hw_onecell_data *npcm8xx_clk_data;
> +       struct device *dev = &adev->dev;
> +       struct clk_hw *hw;
> +       unsigned int i;
> +
> +       npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> +                                                        NPCM8XX_NUM_CLOCKS),
> +                                       GFP_KERNEL);
> +       if (!npcm8xx_clk_data)
> +               return -ENOMEM;
> +
> +       clk_base = rdev->base;
> +
> +       npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
> +
> +       for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
> +               npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +       /* Register plls */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
> +               struct npcm8xx_clk_pll_data *pll_clk = &npcm8xx_pll_clks[i];
> +
> +               hw = npcm8xx_clk_register_pll(dev, clk_base + pll_clk->reg,
> +                                             pll_clk->name, &pll_clk->parent,
> +                                             pll_clk->flags);
> +               if (IS_ERR(hw))
> +                       return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll\n");
> +               pll_clk->hw = *hw;
> +       }
> +
> +       /* Register fixed dividers */
> +       hw = devm_clk_hw_register_fixed_factor(dev, "pll1_div2", "pll1", 0, 1, 2);
> +       if (IS_ERR(hw))
> +               return dev_err_probe(dev, PTR_ERR(hw), "Can't register fixed div\n");
> +       hw_pll1_div2 = *hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, "pll2_div2", "pll2", 0, 1, 2);
> +       if (IS_ERR(hw))
> +               return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll2 div2\n");
> +       hw_pll2_div2 = *hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, "pll_gfx_div2", "pll_gfx", 0, 1, 2);
> +       if (IS_ERR(hw))
> +               return dev_err_probe(dev, PTR_ERR(hw), "Can't register gfx div2\n");
> +       hw_gfx_div2 = *hw;
> +
> +       /* Register muxes */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> +               struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
> +
> +               hw = devm_clk_hw_register_mux_parent_data_table(dev,
> +                                                               mux_data->name,
> +                                                               mux_data->parent_data,
> +                                                               mux_data->num_parents,
> +                                                               mux_data->flags,
> +                                                               clk_base + NPCM8XX_CLKSEL,
> +                                                               mux_data->shift,
> +                                                               mux_data->mask,
> +                                                               0,
> +                                                               mux_data->table,
> +                                                               &npcm8xx_clk_lock);
> +               if (IS_ERR(hw))
> +                       return dev_err_probe(dev, PTR_ERR(hw), "Can't register mux\n");
> +               mux_data->hw = *hw;
> +       }
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, "pre_clk", "cpu_mux", 0, 1, 2);
> +       if (IS_ERR(hw))
> +               return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre clk div2\n");
> +       hw_pre_clk = *hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, "axi", "th", 0, 1, 2);
> +       if (IS_ERR(hw))
> +               return dev_err_probe(dev, PTR_ERR(hw), "Can't register axi div2\n");
> +       npcm8xx_clk_data->hws[NPCM8XX_CLK_AXI] = hw;
> +
> +       hw = devm_clk_hw_register_fixed_factor(dev, "atb", "axi", 0, 1, 2);
> +       if (IS_ERR(hw))
> +               return dev_err_probe(dev, PTR_ERR(hw), "Can't register atb div2\n");
> +       npcm8xx_clk_data->hws[NPCM8XX_CLK_ATB] = hw;
> +
> +       /* Register pre dividers */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_pre_divs); i++) {
> +               struct npcm8xx_clk_div_data *div_data = &npcm8xx_pre_divs[i];
> +
> +               hw = devm_clk_hw_register_divider_parent_hw(dev, div_data->name,
> +                                                           div_data->parent_hw,
> +                                                           div_data->flags,
> +                                                           clk_base + div_data->reg,
> +                                                           div_data->shift,
> +                                                           div_data->width,
> +                                                           div_data->clk_divider_flags,
> +                                                           &npcm8xx_clk_lock);
> +               if (IS_ERR(hw))
> +                       return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre div\n");
> +               div_data->hw = *hw;
> +
> +               if (div_data->onecell_idx >= 0)
> +                       npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
> +       }
> +
> +       /* Register dividers */
> +       for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> +               struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
> +
> +               hw = devm_clk_hw_register_divider_parent_hw(dev, div_data->name,
> +                                                           div_data->parent_hw,
> +                                                           div_data->flags,
> +                                                           clk_base + div_data->reg,
> +                                                           div_data->shift,
> +                                                           div_data->width,
> +                                                           div_data->clk_divider_flags,
> +                                                           &npcm8xx_clk_lock);
> +               if (IS_ERR(hw))
> +                       return dev_err_probe(dev, PTR_ERR(hw), "Can't register div\n");
> +
> +               if (div_data->onecell_idx >= 0)
> +                       npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
> +       }
> +
> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +                                         npcm8xx_clk_data);
> +}
> +
> +static const struct auxiliary_device_id npcm8xx_clock_ids[] = {
> +       {
> +               .name = "reset_npcm.clk-npcm8xx",
> +       },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, npcm8xx_clock_ids);
> +
> +static struct auxiliary_driver npcm8xx_clock_driver = {
> +       .probe          = npcm8xx_clk_probe,
> +       .id_table       = npcm8xx_clock_ids,
> +};
> +module_auxiliary_driver(npcm8xx_clock_driver);
> +
> +MODULE_DESCRIPTION("Clock driver for Nuvoton NPCM8XX BMC SoC");
> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
> +MODULE_LICENSE("GPL v2");
> +
> --
> 2.34.1
>

