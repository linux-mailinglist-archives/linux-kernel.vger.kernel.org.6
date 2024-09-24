Return-Path: <linux-kernel+bounces-336863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92CC9841DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3D61C22E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648B415534D;
	Tue, 24 Sep 2024 09:17:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A646155CBF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169442; cv=none; b=TZQcdPEY+0iXSKNOuKht376ntxZmmBJUzNmbXLc2cL+8YCBb1WiAiQV1s2WqiW1gqAV6VhYKEAjDKnnrMLWNgQfeLVAhKlkmxQLsYZlts1zVV8nl0nKfggyxqXv15QTSDWXNsHlI83Am/yinRAL849o+UjNWyeFm3gQCn9k4yJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169442; c=relaxed/simple;
	bh=IRrap4JAHghTaLvcQT1wBv6zAzjOlETbnsSp0Qjg4KY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amGMRqJ1cqacMh7u2jJYApLPtvldx69spNPMhKu/c+xRHSi0x37kRUfx3M+VpxinvDrAzcq1SWRXQq32ypaMNC1xTod9h8UCh0l1FWwXvCJtljAjbc3DVBtXkUSyb0u5mvTv2udj0KjMQ+XxNeoUMWCHV2m3JYEx+jsawtLznvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1st1fS-0001Uj-WD; Tue, 24 Sep 2024 11:17:11 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1st1fS-001Ay4-H8; Tue, 24 Sep 2024 11:17:10 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1st1fS-0003vw-1b;
	Tue, 24 Sep 2024 11:17:10 +0200
Message-ID: <e0a8da323575ec46dff2df5f804513ea64f11ca8.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: canaan: Add reset driver for Kendryte K230
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Junhui Liu <liujh2818@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Junhui Liu
	 <liujh2818@outlook.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Date: Tue, 24 Sep 2024 11:17:10 +0200
In-Reply-To: <20240924-k230-reset-v1-2-d0cdc11989eb@outlook.com>
References: <20240924-k230-reset-v1-0-d0cdc11989eb@outlook.com>
	 <20240924-k230-reset-v1-2-d0cdc11989eb@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-09-24 at 14:00 +0800, Junhui Liu wrote:
> From: Junhui Liu <liujh2818@outlook.com>
>=20
> Add support for the resets on Canaan Kendryte K230 SoC.
>=20
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
> ---
>  drivers/reset/Kconfig      |   8 ++
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-k230.c | 321 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 330 insertions(+)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 5484a65f66b95374e25bac31f539a2dd92ae007e..716c676e9b934dd3d2b1ee28f=
2c43ef38daf7dba 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -133,6 +133,14 @@ config RESET_K210
>  	  Say Y if you want to control reset signals provided by this
>  	  controller.
> =20
> +config RESET_K230
> +	bool "Reset controller driver for Canaan Kendryte K230 SoC"
> +	depends on (ARCH_CANAAN || COMPILE_TEST) && OF
> +	help
> +	  Support for the Canaan Kendryte K230 RISC-V SoC reset controller.
> +	  Say Y if you want to control reset signals provided by this
> +	  controller.
> +
>  config RESET_LANTIQ
>  	bool "Lantiq XWAY Reset Driver" if COMPILE_TEST
>  	default SOC_TYPE_XWAY
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4411a2a124d7de29808fcf36d0829393fc79af72..f02c35607ba88947e868d33ea=
d70e9ec91a85636 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_IMX7) +=3D reset-imx7.o
>  obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) +=3D reset-imx8mp-audiomix.o
>  obj-$(CONFIG_RESET_INTEL_GW) +=3D reset-intel-gw.o
>  obj-$(CONFIG_RESET_K210) +=3D reset-k210.o
> +obj-$(CONFIG_RESET_K230) +=3D reset-k230.o
>  obj-$(CONFIG_RESET_LANTIQ) +=3D reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) +=3D reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MCHP_SPARX5) +=3D reset-microchip-sparx5.o
> diff --git a/drivers/reset/reset-k230.c b/drivers/reset/reset-k230.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9c693e1cee35dd725bebb6916=
002f846e8b4003b
> --- /dev/null
> +++ b/drivers/reset/reset-k230.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016-2017 Linaro Ltd.
> + * Copyright (C) 2022-2024 Canaan Bright Sight Co., Ltd
> + * Copyright (C) 2024 Junhui Liu <liujh2818@outlook.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/spinlock.h>
> +#include <linux/delay.h>
> +#include <dt-bindings/reset/canaan,k230-rst.h>
> +
> +/**
> + * enum k230_rst_type - K230 reset types
> + * @RST_TYPE_CPU0: Reset type for CPU0
> + *	Automatically clears, has write enable and done bit, active high
> + * @RST_TYPE_CPU1: Reset type for CPU1
> + *	Manually clears, has write enable and done bit, active high
> + * @RST_TYPE_FLUSH: Reset type for CPU L2 cache flush
> + *	Automatically clears, has write enable, no done bit, active high
> + * @RST_TYPE_HW_DONE: Reset type for hardware auto clear
> + *	Automatically clears, no write enable, has done bit, active high
> + * @RST_TYPE_SW_DONE: Reset type for software manual clear
> + *	Manually clears, no write enable and done bit,
> + *	active high if ID is RST_SPI2AXI, otherwise active low
> + */
> +enum k230_rst_type {
> +	RST_TYPE_CPU0 =3D 0,
> +	RST_TYPE_CPU1,
> +	RST_TYPE_FLUSH,
> +	RST_TYPE_HW_DONE,
> +	RST_TYPE_SW_DONE,
> +};
> +
> +struct k230_rst_map {
> +	u32			offset;
> +	enum k230_rst_type	type;
> +	u32			done;
> +	u32			reset;
> +};
> +
> +struct k230_rst {
> +	struct reset_controller_dev	rcdev;
> +	struct device			*dev;
> +	void __iomem			*base;
> +	spinlock_t			lock;
> +};
> +
> +static const struct k230_rst_map k230_resets[] =3D {
> +	[RST_CPU0]		=3D { 0x4,  RST_TYPE_CPU0,    BIT(12), BIT(0) },
> +	[RST_CPU1]		=3D { 0xc,  RST_TYPE_CPU1,    BIT(12), BIT(0) },
> +	[RST_CPU0_FLUSH]	=3D { 0x4,  RST_TYPE_FLUSH,   0,       BIT(4) },
> +	[RST_CPU1_FLUSH]	=3D { 0xc,  RST_TYPE_FLUSH,   0,       BIT(4) },
> +	[RST_AI]		=3D { 0x14, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_VPU]		=3D { 0x1c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_HS]		=3D { 0x2c, RST_TYPE_HW_DONE, BIT(4),  BIT(0) },
> +	[RST_HS_AHB]		=3D { 0x2c, RST_TYPE_HW_DONE, BIT(5),  BIT(1) },
> +	[RST_SDIO0]		=3D { 0x34, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
> +	[RST_SDIO1]		=3D { 0x34, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
> +	[RST_SDIO_AXI]		=3D { 0x34, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
> +	[RST_USB0]		=3D { 0x3c, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
> +	[RST_USB1]		=3D { 0x3c, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
> +	[RST_USB0_AHB]		=3D { 0x3c, RST_TYPE_HW_DONE, BIT(30), BIT(0) },
> +	[RST_USB1_AHB]		=3D { 0x3c, RST_TYPE_HW_DONE, BIT(31), BIT(1) },
> +	[RST_SPI0]		=3D { 0x44, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
> +	[RST_SPI1]		=3D { 0x44, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
> +	[RST_SPI2]		=3D { 0x44, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
> +	[RST_SEC]		=3D { 0x4c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_PDMA]		=3D { 0x54, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
> +	[RST_SDMA]		=3D { 0x54, RST_TYPE_HW_DONE, BIT(29), BIT(1) },
> +	[RST_DECOMPRESS]	=3D { 0x5c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_SRAM]		=3D { 0x64, RST_TYPE_HW_DONE, BIT(28), BIT(0) },
> +	[RST_SHRM_AXIM]		=3D { 0x64, RST_TYPE_HW_DONE, BIT(30), BIT(2) },
> +	[RST_SHRM_AXIS]		=3D { 0x64, RST_TYPE_HW_DONE, BIT(31), BIT(3) },
> +	[RST_NONAI2D]		=3D { 0x6c, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_MCTL]		=3D { 0x74, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_ISP]		=3D { 0x80, RST_TYPE_HW_DONE, BIT(29), BIT(6) },
> +	[RST_ISP_DW]		=3D { 0x80, RST_TYPE_HW_DONE, BIT(28), BIT(5) },
> +	[RST_DPU]		=3D { 0x88, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_DISP]		=3D { 0x90, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_GPU]		=3D { 0x98, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_AUDIO]		=3D { 0xa4, RST_TYPE_HW_DONE, BIT(31), BIT(0) },
> +	[RST_TIMER0]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(0) },
> +	[RST_TIMER1]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(1) },
> +	[RST_TIMER2]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(2) },
> +	[RST_TIMER3]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(3) },
> +	[RST_TIMER4]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(4) },
> +	[RST_TIMER5]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(5) },
> +	[RST_TIMER_APB]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(6) },
> +	[RST_HDI]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(7) },
> +	[RST_WDT0]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(12) },
> +	[RST_WDT1]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(13) },
> +	[RST_WDT0_APB]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(14) },
> +	[RST_WDT1_APB]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(15) },
> +	[RST_TS_APB]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(16) },
> +	[RST_MAILBOX]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(17) },
> +	[RST_STC]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(18) },
> +	[RST_PMU]		=3D { 0x20, RST_TYPE_SW_DONE, 0,       BIT(19) },
> +	[RST_LS_APB]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(0) },
> +	[RST_UART0]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(1) },
> +	[RST_UART1]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(2) },
> +	[RST_UART2]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(3) },
> +	[RST_UART3]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(4) },
> +	[RST_UART4]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(5) },
> +	[RST_I2C0]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(6) },
> +	[RST_I2C1]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(7) },
> +	[RST_I2C2]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(8) },
> +	[RST_I2C3]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(9) },
> +	[RST_I2C4]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(10) },
> +	[RST_JAMLINK0_APB]	=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(11) },
> +	[RST_JAMLINK1_APB]	=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(12) },
> +	[RST_JAMLINK2_APB]	=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(13) },
> +	[RST_JAMLINK3_APB]	=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(14) },
> +	[RST_CODEC_APB]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(17) },
> +	[RST_GPIO_DB]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(18) },
> +	[RST_GPIO_APB]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(19) },
> +	[RST_ADC]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(20) },
> +	[RST_ADC_APB]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(21) },
> +	[RST_PWM_APB]		=3D { 0x24, RST_TYPE_SW_DONE, 0,       BIT(22) },
> +	[RST_SHRM_APB]		=3D { 0x64, RST_TYPE_SW_DONE, 0,       BIT(1) },
> +	[RST_CSI0]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(0) },
> +	[RST_CSI1]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(1) },
> +	[RST_CSI2]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(2) },
> +	[RST_CSI_DPHY]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(3) },
> +	[RST_ISP_AHB]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(4) },
> +	[RST_M0]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(7) },
> +	[RST_M1]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(8) },
> +	[RST_M2]		=3D { 0x80, RST_TYPE_SW_DONE, 0,       BIT(9) },
> +	[RST_SPI2AXI]		=3D { 0xa8, RST_TYPE_SW_DONE, 0,       BIT(0) }
> +};
> +
> +#define to_k230_rst(p) container_of((p), struct k230_rst, rcdev)

Consider turning this into an inline function.

> +static void k230_rst_clear_done(struct k230_rst *rstc, unsigned long id,
> +				bool write_en)
> +{
> +	const struct k230_rst_map *rmap =3D &k230_resets[id];
> +	unsigned long flags;
> +	u32 reg;
> +
> +	spin_lock_irqsave(&rstc->lock, flags);

You could use guard(spinlock_irqsave)(&rstc->lock) to save a few lines.

> +	reg =3D readl(rstc->base + rmap->offset);
> +
> +	/* write 1 to clear */
> +	reg |=3D rmap->done;
> +	if (write_en)
> +		reg |=3D rmap->done << 16;
> +
> +	writel(reg, rstc->base + rmap->offset);
> +
> +	spin_unlock_irqrestore(&rstc->lock, flags);
> +}
> +
> +static int k230_rst_wait_and_clear_done(struct k230_rst *rstc, unsigned =
long id,
> +					bool write_en)
> +{
> +	const struct k230_rst_map *rmap =3D &k230_resets[id];
> +	u32 reg;
> +	int ret;
> +
> +	ret =3D readl_poll_timeout(rstc->base + rmap->offset, reg,
> +				 reg & rmap->done, 10, 1000);
> +	if (ret) {
> +		dev_err(rstc->dev, "Wait for reset done timeout\n");
> +		return ret;
> +	}
> +
> +	k230_rst_clear_done(rstc, id, write_en);
> +
> +	return 0;
> +}
> +
> +static void k230_rst_update(struct k230_rst *rstc, unsigned long id,
> +			    bool assert, bool write_en, bool active_low)
> +{
> +	const struct k230_rst_map *rmap =3D &k230_resets[id];
> +	unsigned long flags;
> +	u32 reg;
> +
> +	spin_lock_irqsave(&rstc->lock, flags);

Same as above, maybe use guard(spinlock_irqsave)(&rstc->lock).

> +
> +	reg =3D readl(rstc->base + rmap->offset);
> +
> +	if (assert ^ active_low)
> +		reg |=3D rmap->reset;
> +	else
> +		reg &=3D ~rmap->reset;
> +
> +	if (write_en)
> +		reg |=3D rmap->reset << 16;
> +
> +	writel(reg, rstc->base + rmap->offset);
> +
> +	spin_unlock_irqrestore(&rstc->lock, flags);
> +}
> +
> +static int k230_rst_assert(struct reset_controller_dev *rcdev, unsigned =
long id)
> +{
> +	struct k230_rst *rstc =3D to_k230_rst(rcdev);
> +	const struct k230_rst_map *rmap =3D &k230_resets[id];
> +	int ret;
> +
> +	switch (rmap->type) {
> +	case RST_TYPE_CPU0:

I'd expect this and the other self-clearing resets to return -ENOTSUPP,
as reset_control_assert() most likely won't return with the reset line
still asserted.

> +		k230_rst_clear_done(rstc, id, true);
> +		k230_rst_update(rstc, id, true, true, false);
> +		ret =3D k230_rst_wait_and_clear_done(rstc, id, true);
> +		break;

This should be implemented in k230_rst_reset().

> +	case RST_TYPE_CPU1:
> +	case RST_TYPE_FLUSH:
> +		k230_rst_update(rstc, id, true, true, false);
> +		break;
> +	case RST_TYPE_HW_DONE:
> +		k230_rst_clear_done(rstc, id, false);
> +		k230_rst_update(rstc, id, true, false, false);
> +		ret =3D k230_rst_wait_and_clear_done(rstc, id, false);

Same for RST_TYPE_FLUSH and RST_TYPE_HW_DONE.

> +		break;
> +	case RST_TYPE_SW_DONE:
> +		k230_rst_update(rstc, id, true, false,
> +				id =3D=3D RST_SPI2AXI ? false : true);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int k230_rst_deassert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	struct k230_rst *rstc =3D to_k230_rst(rcdev);
> +	int ret;

Here ret should be initialized to 0.

> +
> +	switch (k230_resets[id].type) {
> +	case RST_TYPE_CPU0:
> +		break;
> +	case RST_TYPE_CPU1:
> +		k230_rst_update(rstc, id, false, true, false);
> +		ret =3D k230_rst_wait_and_clear_done(rstc, id, true);

This looks odd, but maybe that's how the hardware works. To be sure,
you are waiting for the done bit *after* manually deasserting the
reset, on purpose?

> +		break;
> +	case RST_TYPE_FLUSH:
> +	case RST_TYPE_HW_DONE:
> +		break;
> +	case RST_TYPE_SW_DONE:
> +		k230_rst_update(rstc, id, false, false,
> +				id =3D=3D RST_SPI2AXI ? false : true);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;

Currently this returns an uninitialized value for the self-clearing
resets (RST_TYPE_CPU0, RST_TYPE_FLUSH, and RST_TYPE_HW_DONE).

> +}
> +
> +static int k230_rst_reset(struct reset_controller_dev *rcdev, unsigned l=
ong id)
> +{
> +	int ret;
> +
> +	ret =3D k230_rst_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	udelay(10);

Is this delay enough for all consumers?
Is this delay needed for the resets that wait for the done bit after
assertion (RST_TYPE_CPU0 and RST_TYPE_HW_DONE)?

> +
> +	return k230_rst_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops k230_rst_ops =3D {
> +	.reset		=3D k230_rst_reset,
> +	.assert		=3D k230_rst_assert,
> +	.deassert	=3D k230_rst_deassert,
> +};
> +
> +static int k230_rst_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct k230_rst *rstc;
> +
> +	rstc =3D devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
> +	if (!rstc)
> +		return -ENOMEM;
> +
> +	rstc->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rstc->base))
> +		return PTR_ERR(rstc->base);
> +
> +	spin_lock_init(&rstc->lock);
> +
> +	rstc->dev		=3D dev;
> +	rstc->rcdev.owner	=3D THIS_MODULE;
> +	rstc->rcdev.ops		=3D &k230_rst_ops;
> +	rstc->rcdev.nr_resets	=3D ARRAY_SIZE(k230_resets);
> +	rstc->rcdev.of_node	=3D dev->of_node;
> +
> +	return devm_reset_controller_register(dev, &rstc->rcdev);
> +}
> +
> +static const struct of_device_id k230_rst_match[] =3D {
> +	{ .compatible =3D "canaan,k230-rst", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, k230_rst_match);
> +
> +static struct platform_driver k230_rst_driver =3D {
> +	.probe =3D k230_rst_probe,
> +	.driver =3D {
> +		.name =3D "k230-rst",
> +		.of_match_table =3D k230_rst_match,
> +	}
> +};
> +module_platform_driver(k230_rst_driver);
> +
> +MODULE_AUTHOR("Junhui Liu <liujh2818@outlook.com>");
> +MODULE_DESCRIPTION("Canaan K230 reset driver");
> +MODULE_LICENSE("GPL v2");

regards
Philipp

