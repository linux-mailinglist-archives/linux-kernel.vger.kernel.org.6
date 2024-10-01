Return-Path: <linux-kernel+bounces-345648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340598B8A4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3CE1F23F84
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498719EEC5;
	Tue,  1 Oct 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="f8As2uip"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973AC19E7E5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776109; cv=none; b=WbjijVg/CJH6Pn+HdUMzOC6YOamvjRMahD7wVNiw6vs/fftqXc8cQe8XFpqHcfX/HDESWIN87dnJNz45TDTdhSYeUj7noYAbY+lfQkDmV7adleElNBcfDet6Fi0+conDSPbPKvoM1beXhzD/RHje4MQ1jRzi6RBFJft5vhnLheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776109; c=relaxed/simple;
	bh=aBbqjlh/5evU88fCUo0Tvz8+mwxru3011ldMs/ZBfOs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icb5ZMB0/GpngU801/PtV3iitMYujrR+nucDd5JuxK7a3x3f1J9ohs+aA/n/WVQyLisiGX6W1/HxIoJsR0vdXjJUOI2vml1CgKNP8ggv2sqxb00CQT/kt3V7oQSzIbHRXNklL5IfBZpsQzMsyDFi4dFQ9vdZgvLFwoFB8Y0aQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=f8As2uip; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 13576402F1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727776097;
	bh=osTvtKpGwAlLFzEF8tB9y1dyMDT5cC+kYvp/pLMwhcU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=f8As2uipObMsYgZft1FOBiakUaq3K3lmKc0Gy1MixPabkvaSetdh4jQj0/T3tPb9m
	 l2dPwihHYGAi2oqjoEVCbkxTwxdraTdH9pZaoh5Dow4G+/7hErDs49FuzrnM3IUjlS
	 DWl/2Oe26CqfbyL2KmOUPRRgGuuMyiWlAz9DewOCZRH3dlaA2QFfuSNmbNEZtHPjsN
	 Qqo0kk3ZkObkiOzIkiLaVJLsXWdnmtw1uQDOVVnY37X8F1ySZiBx605bRHRf094X7V
	 Ub7VbB2on4lLQ954JnsOLtH8+FcXnfnQk7ZOGbu9RXD5amwt6k/lqkQ6bF9IO/5ZA/
	 lI+ztZ1s/C11A==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2874478f8beso3597768fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727776095; x=1728380895;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osTvtKpGwAlLFzEF8tB9y1dyMDT5cC+kYvp/pLMwhcU=;
        b=T6Vg5Qc5E/IP/R5o3oM/IAyEwlNCQIPE2QnyVpUSbysJDzqOnKjFL39z7d6+UnuBPl
         Yxb6wX1x+n6A+uigaSMvVOv/2OVmaheW9nEG7P5jOVLrx67mF2AaCqaCUYPbJj4UEcEp
         p7iEf6lIXnAkiy3iCeFEAZ8iZTNkueqHIHzNGtg/fPf3OqdsRbyUJsxcp0GMWajo17oW
         YUUzQzTj1B1Nxizh3zV9mbNV5SkgiqXTJ5/PGhBf6Ic6ebQgSqXCV22zI2VuY81Z7+7I
         SlCs17HPTuRPA4Dwnj0TxOaKzdgJx5dJEH9j+hKBktdKzKZG9uLmrQOwOUPvVfB5i1eQ
         C6rg==
X-Forwarded-Encrypted: i=1; AJvYcCVcT8t2JwG9Y8ajmbGF8aWFZl4sYAvAtkc8QvCI8H2i7Aa7kMtIuxsnQxM0EpQhkEn2ruuuBBbPiylh+S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzAnl4fnKflKjVNAqWY6Y+vLGdebS7AHCLx4kqrdzzm7ZcuPb
	EZdBb8w4iBDu6j2vgLteFyrS/R8lnyQRqGA2OHtuCUz+npVAbLQSbTWew/a/egsC6cmKPXbkP7k
	NP66gl+Jd7FIAAM8iD6ecvndAN69TE877YgZXmZ0gkeJNi1Uy4XmC2YR3MNEWiPY99914gGUr4K
	HRE+zmBzdV9OovA5CgNjjB8wQNdZ3UPcQS5l0+WZT8iC0HWiw03Qfg
X-Received: by 2002:a05:6870:808c:b0:287:ef4:6695 with SMTP id 586e51a60fabf-28710bccd55mr12074838fac.31.1727776094516;
        Tue, 01 Oct 2024 02:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp6/9r3W7qqQb8DhujSjcEBlXChBMK6q7Y6dkSefhHq4ePSAKcVgpl1bmG6eAEXTMoJSFxLUQSVmSTjRejP+8=
X-Received: by 2002:a05:6870:808c:b0:287:ef4:6695 with SMTP id
 586e51a60fabf-28710bccd55mr12074803fac.31.1727776094118; Tue, 01 Oct 2024
 02:48:14 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Oct 2024 02:48:13 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240930-th1520-dwmac-v3-2-ae3e03c225ab@tenstorrent.com>
References: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com> <20240930-th1520-dwmac-v3-2-ae3e03c225ab@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 1 Oct 2024 02:48:13 -0700
Message-ID: <CAJM55Z-+-Ca3kNuNkTpfea8jYEDTdojhx=gM__MScVyT3Yomog@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] net: stmmac: Add glue layer for T-HEAD TH1520 SoC
To: Drew Fustini <dfustini@tenstorrent.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Add dwmac glue driver to support the DesignWare-based GMAC controllers
> on the T-HEAD TH1520 SoC.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> [esmil: rename plat->interface -> plat->mac_interface,
>         use devm_stmmac_probe_config_dt()]
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> [drew: convert from stmmac_dvr_probe() to devm_stmmac_pltfr_probe()]
> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> ---
>  MAINTAINERS                                       |   1 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig       |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile      |   1 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 291 ++++++++++++++++++++++
>  4 files changed, 304 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9e50107efb37..1d24863c01df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19946,6 +19946,7 @@ F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
>  F:	arch/riscv/boot/dts/thead/
>  F:	drivers/clk/thead/clk-th1520-ap.c
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
>  F:	drivers/pinctrl/pinctrl-th1520.c
>  F:	include/dt-bindings/clock/thead,th1520-clk-ap.h
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 05cc07b8f48c..82030adaf16e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -228,6 +228,17 @@ config DWMAC_SUN8I
>  	  stmmac device driver. This driver is used for H3/A83T/A64
>  	  EMAC ethernet controller.
>
> +config DWMAC_THEAD
> +	tristate "T-HEAD dwmac support"
> +	depends on OF && (ARCH_THEAD || COMPILE_TEST)
> +	select MFD_SYSCON
> +	help
> +	  Support for ethernet controllers on T-HEAD RISC-V SoCs
> +
> +	  This selects the T-HEAD platform specific glue layer support for
> +	  the stmmac device driver. This driver is used for T-HEAD TH1520
> +	  ethernet controller.
> +
>  config DWMAC_IMX8
>  	tristate "NXP IMX8 DWMAC support"
>  	default ARCH_MXC
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index c2f0e91f6bf8..d065634c6223 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_DWMAC_STI)		+= dwmac-sti.o
>  obj-$(CONFIG_DWMAC_STM32)	+= dwmac-stm32.o
>  obj-$(CONFIG_DWMAC_SUNXI)	+= dwmac-sunxi.o
>  obj-$(CONFIG_DWMAC_SUN8I)	+= dwmac-sun8i.o
> +obj-$(CONFIG_DWMAC_THEAD)	+= dwmac-thead.o
>  obj-$(CONFIG_DWMAC_DWC_QOS_ETH)	+= dwmac-dwc-qos-eth.o
>  obj-$(CONFIG_DWMAC_INTEL_PLAT)	+= dwmac-intel-plat.o
>  obj-$(CONFIG_DWMAC_LOONGSON1)	+= dwmac-loongson1.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> new file mode 100644
> index 000000000000..f2f94539c0d2
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * T-HEAD DWMAC platform driver
> + *
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "stmmac_platform.h"
> +
> +#define GMAC_CLK_EN			0x00
> +#define  GMAC_TX_CLK_EN			BIT(1)
> +#define  GMAC_TX_CLK_N_EN		BIT(2)
> +#define  GMAC_TX_CLK_OUT_EN		BIT(3)
> +#define  GMAC_RX_CLK_EN			BIT(4)
> +#define  GMAC_RX_CLK_N_EN		BIT(5)
> +#define  GMAC_EPHY_REF_CLK_EN		BIT(6)
> +#define GMAC_RXCLK_DELAY_CTRL		0x04
> +#define  GMAC_RXCLK_BYPASS		BIT(15)
> +#define  GMAC_RXCLK_INVERT		BIT(14)
> +#define  GMAC_RXCLK_DELAY_MASK		GENMASK(4, 0)
> +#define  GMAC_RXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> +#define GMAC_TXCLK_DELAY_CTRL		0x08
> +#define  GMAC_TXCLK_BYPASS		BIT(15)
> +#define  GMAC_TXCLK_INVERT		BIT(14)
> +#define  GMAC_TXCLK_DELAY_MASK		GENMASK(4, 0)
> +#define  GMAC_TXCLK_DELAY_VAL(x)	FIELD_PREP(GMAC_RXCLK_DELAY_MASK, (x))
> +#define GMAC_PLLCLK_DIV			0x0c
> +#define  GMAC_PLLCLK_DIV_EN		BIT(31)
> +#define  GMAC_PLLCLK_DIV_MASK		GENMASK(7, 0)
> +#define  GMAC_PLLCLK_DIV_NUM(x)		FIELD_PREP(GMAC_PLLCLK_DIV_MASK, (x))
> +#define GMAC_GTXCLK_SEL			0x18
> +#define  GMAC_GTXCLK_SEL_PLL		BIT(0)
> +#define GMAC_INTF_CTRL			0x1c
> +#define  PHY_INTF_MASK			BIT(0)
> +#define  PHY_INTF_RGMII			FIELD_PREP(PHY_INTF_MASK, 1)
> +#define  PHY_INTF_MII_GMII		FIELD_PREP(PHY_INTF_MASK, 0)
> +#define GMAC_TXCLK_OEN			0x20
> +#define  TXCLK_DIR_MASK			BIT(0)
> +#define  TXCLK_DIR_OUTPUT		FIELD_PREP(TXCLK_DIR_MASK, 0)
> +#define  TXCLK_DIR_INPUT		FIELD_PREP(TXCLK_DIR_MASK, 1)
> +
> +#define GMAC_GMII_RGMII_RATE	125000000
> +#define GMAC_MII_RATE		25000000
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +struct thead_dwmac {
> +	struct plat_stmmacenet_data *plat;
> +	struct regmap *apb_regmap;
> +	struct device *dev;
> +};
> +
> +static int thead_dwmac_set_phy_if(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 phyif;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		phyif = PHY_INTF_MII_GMII;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		phyif = PHY_INTF_RGMII;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	};
> +
> +	return regmap_write(dwmac->apb_regmap, GMAC_INTF_CTRL, phyif);
> +}
> +
> +static int thead_dwmac_set_txclk_dir(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	u32 txclk_dir;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		txclk_dir = TXCLK_DIR_INPUT;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		txclk_dir = TXCLK_DIR_OUTPUT;
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	};
> +
> +	return regmap_write(dwmac->apb_regmap, GMAC_TXCLK_OEN, txclk_dir);
> +}
> +
> +static void thead_dwmac_fix_speed(void *priv, unsigned int speed, unsigned int mode)
> +{
> +	struct plat_stmmacenet_data *plat;
> +	struct thead_dwmac *dwmac = priv;
> +	unsigned long rate;
> +	u32 div;
> +
> +	plat = dwmac->plat;
> +
> +	switch (plat->mac_interface) {
> +	/* For MII, rxc/txc is provided by phy */
> +	case PHY_INTERFACE_MODE_MII:
> +		return;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		rate = clk_get_rate(plat->stmmac_clk);
> +		if (!rate || rate % GMAC_GMII_RGMII_RATE != 0 ||
> +		    rate % GMAC_MII_RATE != 0) {
> +			dev_err(dwmac->dev, "invalid gmac rate %ld\n", rate);
> +			return;
> +		}
> +
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV, GMAC_PLLCLK_DIV_EN, 0);
> +
> +		switch (speed) {
> +		case SPEED_1000:
> +			div = rate / GMAC_GMII_RGMII_RATE;
> +			break;
> +		case SPEED_100:
> +			div = rate / GMAC_MII_RATE;
> +			break;
> +		case SPEED_10:
> +			div = rate * 10 / GMAC_MII_RATE;
> +			break;
> +		default:
> +			dev_err(dwmac->dev, "invalid speed %u\n", speed);
> +			return;
> +		}
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> +				   GMAC_PLLCLK_DIV_MASK, GMAC_PLLCLK_DIV_NUM(div));
> +
> +		regmap_update_bits(dwmac->apb_regmap, GMAC_PLLCLK_DIV,
> +				   GMAC_PLLCLK_DIV_EN, GMAC_PLLCLK_DIV_EN);
> +		break;
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return;
> +	}
> +}
> +
> +static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> +{
> +	struct thead_dwmac *dwmac = plat->bsp_priv;
> +	int err;
> +	u32 reg;
> +
> +	switch (plat->mac_interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		reg = GMAC_RX_CLK_EN | GMAC_TX_CLK_EN;
> +		break;
> +
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		/* use pll */
> +		err = regmap_write(dwmac->apb_regmap, GMAC_GTXCLK_SEL, GMAC_GTXCLK_SEL_PLL);
> +		if (err)
> +			return dev_err_probe(dwmac->dev, err,
> +					     "failed to set phy interface\n");
> +
> +		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> +		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
> +		break;
> +
> +	default:
> +		dev_err(dwmac->dev, "unsupported phy interface %d\n",
> +			plat->mac_interface);
> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(dwmac->apb_regmap, GMAC_CLK_EN, reg);
> +}
> +
> +static int thead_dwmac_init(struct platform_device *pdev, void *priv)
> +{
> +	struct thead_dwmac *dwmac = priv;
> +	int ret;
> +
> +	ret = thead_dwmac_set_phy_if(dwmac->plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = thead_dwmac_set_txclk_dir(dwmac->plat);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(dwmac->apb_regmap, GMAC_RXCLK_DELAY_CTRL,
> +			   GMAC_RXCLK_DELAY_VAL(0));
> +	if (ret)
> +		return dev_err_probe(dwmac->dev, ret,
> +				     "failed to set GMAC RX clock delay\n");
> +
> +	ret = regmap_write(dwmac->apb_regmap, GMAC_TXCLK_DELAY_CTRL,
> +			   GMAC_TXCLK_DELAY_VAL(0));
> +	if (ret)
> +		return dev_err_probe(dwmac->dev, ret,
> +				     "failed to set GMAC TX clock delay\n");
> +
> +	return thead_dwmac_enable_clk(dwmac->plat);
> +}
> +
> +static int thead_dwmac_probe(struct platform_device *pdev)
> +{
> +	struct stmmac_resources stmmac_res;
> +	struct plat_stmmacenet_data *plat;
> +	struct thead_dwmac *dwmac;
> +	void __iomem *apb;
> +	int ret;
> +
> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to get resources\n");
> +
> +	plat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
> +	if (IS_ERR(plat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(plat),
> +				     "dt configuration failed\n");
> +
> +	dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac), GFP_KERNEL);
> +	if (!dwmac)
> +		return -ENOMEM;
> +
> +	apb = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(apb))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(apb),
> +				     "Failed to remap gmac apb registers\n");
> +
> +	dwmac->apb_regmap = devm_regmap_init_mmio(&pdev->dev, apb, &regmap_config);
> +	if (IS_ERR(dwmac->apb_regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->apb_regmap),
> +				     "Failed to access gmac apb registers\n");

Why do you need to convert the APB range to a regmap? As far as I can tell it's
just regular 32bit memory mapped registers, so should work fine with just
readl()/writel()

/Emil

> +
> +	dwmac->dev = &pdev->dev;
> +	dwmac->plat = plat;
> +	plat->bsp_priv = dwmac;
> +	plat->fix_mac_speed = thead_dwmac_fix_speed;
> +	plat->init = thead_dwmac_init;
> +
> +	return devm_stmmac_pltfr_probe(pdev, plat, &stmmac_res);
> +}
> +
> +static const struct of_device_id thead_dwmac_match[] = {
> +	{ .compatible = "thead,th1520-gmac" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, thead_dwmac_match);
> +
> +static struct platform_driver thead_dwmac_driver = {
> +	.probe = thead_dwmac_probe,
> +	.driver = {
> +		.name = "thead-dwmac",
> +		.pm = &stmmac_pltfr_pm_ops,
> +		.of_match_table = thead_dwmac_match,
> +	},
> +};
> +module_platform_driver(thead_dwmac_driver);
> +
> +MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
> +MODULE_AUTHOR("Drew Fustini <drew@pdp7.com>");
> +MODULE_DESCRIPTION("T-HEAD DWMAC platform driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

