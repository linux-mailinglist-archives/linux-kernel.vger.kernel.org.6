Return-Path: <linux-kernel+bounces-556161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EE8A5C1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9B53AB775
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CE250C11;
	Tue, 11 Mar 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="w6IeK/gp"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994E2222D0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697282; cv=none; b=YBEoNP4qcu85/I6Haug+G5niSPFwkaPoRyKzaQN3KYLQ4BIM3YoKXJCBxfe8XDBYZh16LbFwwVIqWKLzaFB+xPsMp5yGrFC1p//n7LUJHSn9PWDUM6h1tL9QxZGO45LpLv0cZALUC4+wTQSoXJZrzeUEjug0ujMw8qJjHWJqJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697282; c=relaxed/simple;
	bh=dKkrGLfsNWmwZpgLMtMYGU1kT8M07YSZYhTzAqh3Mdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI/92x4I8PGJUKjP3QZsrwkJzhkszkV5aZf6ALbiTyJTq4FQ1naw2v/bAxla4B6BJfIDJbI2eKz6k57njx1liSNoAoVeFztQBBvfC8fnlYdyczexX4pf2IpJvQjnUvQMCeFcn30OaPULK7xBtzrkg4XqbT7/BH77QMng5frLDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=w6IeK/gp; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Tue, 11 Mar 2025 08:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741697278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSDhGE/I73wVs8EWJhkzU0BZPvm+bkT9p0rnjhxFEjo=;
	b=w6IeK/gpWjLIDUIay8CMOgyHu+3P8hX4rvUDV5+Lxo/iSNYjOn97H4Rl/odWkN97lNcHU9
	yRtydCjmo3JedwXmgO11G2+psK1xry7xtLZjfQElXfVW+bIvZ7JzjrOgaJZx9HiwtiC92N
	h/bp3j+1aIKeAmelrPxfvjGCHvEQpxm/ujGXd2mGzA8fcBwZp69Jquf5KRiV61FteGCF4F
	Q9yoBJdwW9QNetgjsPXeFZLzU/CiZpO9Wrsz6xpBTWsHw9ttwr7RnDP8yWr/p2SCpGbrWX
	XJSat2TQ/wBwRHTWU4PkP+6x0GjdULCcIycy+s+vqTxN6lo2m3MZoEW3Fla8xA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Jean-Francois Bortolotti <jeff@borto.fr>
Subject: Re: [PATCH v3 2/3] spmi: add a spmi driver for Apple SoC
Message-ID: <Z9Aw-MTUdldYRrP5@blossom>
References: <20250310-spmi-v3-0-92a82e7d9f0d@gmail.com>
 <20250310-spmi-v3-2-92a82e7d9f0d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310-spmi-v3-2-92a82e7d9f0d@gmail.com>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Mon , Mar 10, 2025 at 11:07:59PM +0100, Sasha Finkelstein via B4 Relay a écrit :
> From: Jean-Francois Bortolotti <jeff@borto.fr>
> 
> The connected PMU contains several useful nvmem cells such as RTC offset,
> boot failure counters, reboot/shutdown selector, and a few others.
> In addition M3+ machines have their USB-PD controller connected via SPMI.
> 
> Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/spmi/Kconfig                 |   8 ++
>  drivers/spmi/Makefile                |   1 +
>  drivers/spmi/spmi-apple-controller.c | 168 +++++++++++++++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 271ff8110df83c2d4fe7fbbfffc0a72259460bc5..9006695261d29fbc1e15659c2b43d7afeee0b656 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2254,6 +2254,7 @@ F:	drivers/nvmem/apple-efuses.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
>  F:	drivers/pwm/pwm-apple.c
>  F:	drivers/soc/apple/*
> +F:	drivers/spmi/spmi-apple-controller.c
>  F:	drivers/watchdog/apple_wdt.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  F:	include/dt-bindings/pinctrl/apple.h
> diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
> index 73780204631463631cabcbad5bf83e8dbbee94ce..9005fa91d9f4e541403ccc7bf84e0592402ac41e 100644
> --- a/drivers/spmi/Kconfig
> +++ b/drivers/spmi/Kconfig
> @@ -11,6 +11,14 @@ menuconfig SPMI
>  
>  if SPMI
>  
> +config SPMI_APPLE
> +	tristate "Apple SoC SPMI Controller platform driver"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  SPMI controller present on many Apple SoCs, including the
> +	  t8103 (M1) and t600x (M1 Pro/Max).
> +
>  config SPMI_HISI3670
>  	tristate "Hisilicon 3670 SPMI Controller"
>  	select IRQ_DOMAIN_HIERARCHY
> diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
> index 7f152167bb05b2c24a0f9669f60278152898eebb..38ac635645ba65aa46cb5e8a50072ed9771e229b 100644
> --- a/drivers/spmi/Makefile
> +++ b/drivers/spmi/Makefile
> @@ -4,6 +4,7 @@
>  #
>  obj-$(CONFIG_SPMI)	+= spmi.o spmi-devres.o
>  
> +obj-$(CONFIG_SPMI_APPLE)	+= spmi-apple-controller.o
>  obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
>  obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
>  obj-$(CONFIG_SPMI_MTK_PMIF)	+= spmi-mtk-pmif.o
> diff --git a/drivers/spmi/spmi-apple-controller.c b/drivers/spmi/spmi-apple-controller.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..697b3e8bb023566f17911fc222666d84f5e14c91
> --- /dev/null
> +++ b/drivers/spmi/spmi-apple-controller.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple SoC SPMI device driver
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * Inspired by:
> + *		OpenBSD support Copyright (c) 2021 Mark Kettenis <kettenis@openbsd.org>
> + *		Correllium support Copyright (C) 2021 Corellium LLC
> + *		hisi-spmi-controller.c
> + *		spmi-pmic-arb.c Copyright (c) 2021, The Linux Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/spmi.h>
> +
> +/* SPMI Controller Registers */
> +#define SPMI_STATUS_REG 0
> +#define SPMI_CMD_REG 0x4
> +#define SPMI_RSP_REG 0x8
> +
> +#define SPMI_RX_FIFO_EMPTY BIT(24)
> +
> +#define REG_POLL_INTERVAL_US 10000
> +#define REG_POLL_TIMEOUT_US (REG_POLL_INTERVAL_US * 5)
> +
> +struct apple_spmi {
> +	void __iomem *regs;
> +};
> +
> +#define poll_reg(spmi, reg, val, cond) \
> +	readl_poll_timeout((spmi)->regs + (reg), (val), (cond), \
> +			   REG_POLL_INTERVAL_US, REG_POLL_TIMEOUT_US)
> +
> +static inline u32 apple_spmi_pack_cmd(u8 opc, u8 sid, u16 saddr, size_t len)
> +{
> +	return opc | sid << 8 | saddr << 16 | (len - 1) | (1 << 15);
> +}
> +
> +/* Wait for Rx FIFO to have something */
> +static int apple_spmi_wait_rx_not_empty(struct spmi_controller *ctrl)
> +{
> +	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
> +	int ret;
> +	u32 status;
> +
> +	ret = poll_reg(spmi, SPMI_STATUS_REG, status, !(status & SPMI_RX_FIFO_EMPTY));
> +	if (ret) {
> +		dev_err(&ctrl->dev,
> +			"failed to wait for RX FIFO not empty\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
> +			 u16 saddr, u8 *buf, size_t len)
> +{
> +	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
> +	u32 spmi_cmd = apple_spmi_pack_cmd(opc, sid, saddr, len);
> +	u32 rsp;
> +	size_t len_read = 0;
> +	u8 i;
> +	int ret;
> +
> +	writel(spmi_cmd, spmi->regs + SPMI_CMD_REG);
> +
> +	ret = apple_spmi_wait_rx_not_empty(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard SPMI reply status */
> +	readl(spmi->regs + SPMI_RSP_REG);
> +
> +	/* Read SPMI data reply */
> +	while (len_read < len) {
> +		rsp = readl(spmi->regs + SPMI_RSP_REG);
> +		i = 0;
> +		while ((len_read < len) && (i < 4)) {
> +			buf[len_read++] = ((0xff << (8 * i)) & rsp) >> (8 * i);
> +			i += 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
> +			  u16 saddr, const u8 *buf, size_t len)
> +{
> +	struct apple_spmi *spmi = spmi_controller_get_drvdata(ctrl);
> +	u32 spmi_cmd = apple_spmi_pack_cmd(opc, sid, saddr, len);
> +	size_t i = 0, j;
> +	int ret;
> +
> +	writel(spmi_cmd, spmi->regs + SPMI_CMD_REG);
> +
> +	while (i < len) {
> +		j = 0;
> +		spmi_cmd = 0;
> +		while ((j < 4) & (i < len))
> +			spmi_cmd |= buf[i++] << (j++ * 8);
> +
> +		writel(spmi_cmd, spmi->regs + SPMI_CMD_REG);
> +	}
> +
> +	ret = apple_spmi_wait_rx_not_empty(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard */
> +	readl(spmi->regs + SPMI_RSP_REG);
> +
> +	return 0;
> +}
> +
> +static int apple_spmi_probe(struct platform_device *pdev)
> +{
> +	struct apple_spmi *spmi;
> +	struct spmi_controller *ctrl;
> +	int ret;
> +
> +	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*spmi));
> +	if (IS_ERR(ctrl))
> +		return -ENOMEM;
> +
> +	spmi = spmi_controller_get_drvdata(ctrl);
> +
> +	spmi->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(spmi->regs))
> +		return PTR_ERR(spmi->regs);
> +
> +	ctrl->dev.of_node = pdev->dev.of_node;
> +
> +	ctrl->read_cmd = spmi_read_cmd;
> +	ctrl->write_cmd = spmi_write_cmd;
> +
> +	ret = devm_spmi_controller_add(&pdev->dev, ctrl);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "spmi_controller_add failed\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id apple_spmi_match_table[] = {
> +	{ .compatible = "apple,spmi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apple_spmi_match_table);
> +
> +static struct platform_driver apple_spmi_driver = {
> +	.probe		= apple_spmi_probe,
> +	.driver		= {
> +		.name	= "apple-spmi",
> +		.of_match_table = apple_spmi_match_table,
> +	},
> +};
> +module_platform_driver(apple_spmi_driver);
> +
> +MODULE_AUTHOR("Jean-Francois Bortolotti <jeff@borto.fr>");
> +MODULE_DESCRIPTION("Apple SoC SPMI driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.48.1
> 
> 

