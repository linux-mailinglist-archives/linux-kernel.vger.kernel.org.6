Return-Path: <linux-kernel+bounces-552405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C30A57992
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A99B172A0D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F3C1ACECE;
	Sat,  8 Mar 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ENJuE97S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8clret3k"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42C1ADC7B;
	Sat,  8 Mar 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741427042; cv=none; b=MLVFKp/B35kRPxiWeZ3ySFDxp0Gfdn3pqoQcLxwRY1hz5ug+NlSScn3ZRNNuGEP/JLeLe+YbAcn4l5G79q8xDys7KL1sjoonYqV6x0Sj66FME/wf4qYBlV9R14F3H3VxyJzVd0eZl9+kTOBVDqIdHlTdKEMrOGzAVEar0hpfw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741427042; c=relaxed/simple;
	bh=KBIAhi7B5erMXgMZAQNAey6my8U72qBo/WzWDKJRB9A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kredCPx0DL2LCfxUGYVo4hVWvl8w6caPrlXEoYebt78T/8Gk09YDetpCSJos5ofocZntSb9nN23nE0stYAynUgCXLsMj9MMRnHZbi7YxG/3siq/3f+zuiZSZ4u59giL20sNmaN7/esQbNAp03rfdd8D1AXiBjLv76kGxGmNYVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ENJuE97S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8clret3k; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41A3311400AF;
	Sat,  8 Mar 2025 04:43:58 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Sat, 08 Mar 2025 04:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741427038; x=1741513438; bh=zcRCu9cljfojnQwbHTplnCHNzk11OMga
	1QqlxrIFC1w=; b=ENJuE97SZshtFAc/aTMow2tBBM4BqQIh/glXyPx0LpeLSZ8O
	GHeyKXFRPa/vVsQXvAMeqk/AAqdYqnTcINtdwmr4jwbUUC7SUOTGxoCFi92+DdU1
	t6AXvMLMDs9GPi4uR1SsOx8rWfQ3JZrjeUh53/stsm2Zqp3TaCOcHrpE+EvsBPqo
	volvcyCOjJ9n5TyaWGAuYQZ5ZRvGoR46tm4OaVf/Zgq/0omV37UYKsfXOq0L5NDE
	PLZ6vpgE+MuD/jlH8wjD/RhFG8bmxn1yWQ4uEVTo2pDcXXjmIf1uS7ZHEasRasE7
	gFeXBrRF9sVtPY7TfAwOP3nmZ/3Bl08TEg2y4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741427038; x=
	1741513438; bh=zcRCu9cljfojnQwbHTplnCHNzk11OMga1QqlxrIFC1w=; b=8
	clret3kOs7DrwcVB6OJWZxrP+wNnQgMfrsGeTR5Brs0j+4tctizIZCTxMWFhNNv3
	QHuBvfilI7c2r6ee4gzklEepTLgBd4LlMnS7LO0KZAiNRHpk6w07WorL47nedBar
	aG1FuJtDiIZdOGBBQvEvPlcJUku+6dzBVZQYi38Khx8YLle+aVToT02G6fAoI42+
	ssm/sY03z3Adrg2v07+KiOa0duZzRPyV57VRwV6Og2vxp4vDyfsh8TtvtghV7q++
	B0SroxSiIhIcXxVEo7e5G4IdE1vekXDZnnKAyrCWNChhK82GYJ2Ye4QOVuevgSkx
	He2oU5b7cmdvudCB2Ll2w==
X-ME-Sender: <xms:XRHMZ-3fbqWOOQkmpN4_eeUz2fWyOnHI2bcPeVR7K3EgkTapozwqRA>
    <xme:XRHMZxFi1kmKATuCz2iBofeC3nphww3BTbhCqafL4CquuBVLK9e8qCQl8686nsU9h
    LyynFQaZbBCA9Y5qFY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveek
    ueefffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgvfhhfse
    gsohhrthhordhfrhdprhgtphhtthhopehfnhhklhdrkhgvrhhnvghlsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheptghonhhorh
    doughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdq
    khgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprg
    hsrghhiheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:XRHMZ25fbynEjNBIGfeF3weUUUX-LaPSZskpiwc1qnyIGSFuFtRxLg>
    <xmx:XRHMZ_3hc1YDPGmwOzj_Q5FNCTSXs65Cxp2ucFxwtav957v8ir1AGw>
    <xmx:XRHMZxFL4ONWcWVHjbjTWrdWDopAoxWzSpxjUfRqHBGvNhDVooMUAw>
    <xmx:XRHMZ4_Yg_zmOfsCzWkIavJJkRa-4v0Yj5OaHEXMYAEJuT_1RHb7Cw>
    <xmx:XhHMZw8tjSTPEeuXgVjYZQIbBw0qvzbMYR4X2-kO02idkstCNkDXdTHP>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1178FBA0072; Sat,  8 Mar 2025 04:43:56 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Mar 2025 10:43:23 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
 "Janne Grunau" <j@jannau.net>, "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 "Jean-Francois Bortolotti" <jeff@borto.fr>
Message-Id: <b0a29727-6569-4213-a679-21116b39b95b@app.fastmail.com>
In-Reply-To: <20250307-spmi-v2-2-eccdb06afb99@gmail.com>
References: <20250307-spmi-v2-0-eccdb06afb99@gmail.com>
 <20250307-spmi-v2-2-eccdb06afb99@gmail.com>
Subject: Re: [PATCH v2 2/3] spmi: add a spmi driver for Apple SoC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Fri, Mar 7, 2025, at 21:09, Sasha Finkelstein via B4 Relay wrote:
> From: Jean-Francois Bortolotti <jeff@borto.fr>
>
> The connected PMU contains several useful nvmem cells such as RTC offset,
> boot failure counters, reboot/shutdown selector, and a few others.
> In addition M3+ machines have their USB-PD controller connected via SPMI.
>
> Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
> Co-developed-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  MAINTAINERS                          |   1 +
>  drivers/spmi/Kconfig                 |   8 ++
>  drivers/spmi/Makefile                |   1 +
>  drivers/spmi/spmi-apple-controller.c | 178 +++++++++++++++++++++++++++++++++++
>  4 files changed, 188 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 
> 271ff8110df83c2d4fe7fbbfffc0a72259460bc5..9006695261d29fbc1e15659c2b43d7afeee0b656 
> 100644
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
> index 
> 73780204631463631cabcbad5bf83e8dbbee94ce..9005fa91d9f4e541403ccc7bf84e0592402ac41e 
> 100644
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
> index 
> 7f152167bb05b2c24a0f9669f60278152898eebb..38ac635645ba65aa46cb5e8a50072ed9771e229b 
> 100644
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
> diff --git a/drivers/spmi/spmi-apple-controller.c 
> b/drivers/spmi/spmi-apple-controller.c
> new file mode 100644
> index 
> 0000000000000000000000000000000000000000..2d4a677aaff6b10fce80f7eacc330605674ea495
> --- /dev/null
> +++ b/drivers/spmi/spmi-apple-controller.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Apple SoC SPMI device driver
> + *
> + * Copyright The Asahi Linux Contributors
> + *
> + * Inspired by:
> + *		OpenBSD support Copyright (c) 2021 Mark Kettenis 
> <kettenis@openbsd.org>
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
> +#define REG_POLL_INTERVAL 10000
> +#define REG_POLL_TIMEOUT (REG_POLL_INTERVAL * 5)

I'd either add a comment that these are in us or add a _US suffix

> +
> +struct apple_spmi {
> +	void __iomem *regs;
> +};
> +
> +#define poll_reg(spmi, reg, val, cond) \
> +	readl_poll_timeout((spmi)->regs + (reg), (val), (cond), \
> +			   REG_POLL_INTERVAL, REG_POLL_TIMEOUT)
> +
> +static inline u32 read_reg(struct apple_spmi *spmi, int offset)
> +{
> +	return readl(spmi->regs + offset);
> +}
> +
> +static inline void write_reg(u32 value, struct apple_spmi *spmi, int 
> offset)
> +{
> +	writel(value, spmi->regs + offset);
> +}
> +
> +static inline u32 apple_spmi_pack_cmd(u8 opc, u8 sid, u16 saddr, 
> size_t len)
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
> +	ret = poll_reg(spmi, SPMI_STATUS_REG, status, !(status & 
> SPMI_RX_FIFO_EMPTY));
> +	if (ret) {
> +		dev_err(&ctrl->dev,
> +			"%s: Failed to wait for RX FIFO not empty\n", __func__);

__func__ is always the same here now. I'd just drop that prefix.

With that and Alyssa's remark addressed: 

Reviewed-by: Sven Peter <sven@svenpeter.dev>

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
> +	write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
> +
> +	ret = apple_spmi_wait_rx_not_empty(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard SPMI reply status */
> +	read_reg(spmi, SPMI_RSP_REG);
> +
> +	/* Read SPMI data reply */
> +	while (len_read < len) {
> +		rsp = read_reg(spmi, SPMI_RSP_REG);
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
> +	write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
> +
> +	while (i < len) {
> +		j = 0;
> +		spmi_cmd = 0;
> +		while ((j < 4) & (i < len))
> +			spmi_cmd |= buf[i++] << (j++ * 8);
> +
> +		write_reg(spmi_cmd, spmi, SPMI_CMD_REG);
> +	}
> +
> +	ret = apple_spmi_wait_rx_not_empty(ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* Discard */
> +	read_reg(spmi, SPMI_RSP_REG);
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


Sven

