Return-Path: <linux-kernel+bounces-207918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E8901DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C155B26361
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F673502;
	Mon, 10 Jun 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLOBC9CW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729E47A58;
	Mon, 10 Jun 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718010433; cv=none; b=PUA1+92hx7VtzSU0259TKFLsCDUNMgeY4kNicw6h91Hu/9uKZTUcsMQrQbtoUugWcVY1MQdaF+O4rNf/Kjri4jRl0VxIb2j0iU2fhJ7H2tpYDdf8waPGOyQ6dWs6iGcvjLftOrLbrc+uljL1pxruGh+CmwFB/FREaALvRQ6oUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718010433; c=relaxed/simple;
	bh=Oe6aa/Sv/6QnbJTu+1EUV0CktmjLNuWgf1Yer3fRT78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7TnYsS4Ana+BD5J3QFT1fClgBAdEBl+GyJH9dzing3EBSMKLn1yJuFSOJOyAEDOU+ear2VNG8e9CLwP1ncD9CGvEA9/xgN1jMk5lWduiajQRGcCJA9Fhbg3yE/SsKlduS+nn2qQc0ZUr1rPlmA0zTxWgBdaJBwlptLpJ2GZzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLOBC9CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41491C2BBFC;
	Mon, 10 Jun 2024 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718010432;
	bh=Oe6aa/Sv/6QnbJTu+1EUV0CktmjLNuWgf1Yer3fRT78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PLOBC9CWZDed5NAwDsecmUULpmL68wKjoyo1E55ywQ4Z71xtN5Fb7w+XVqmrXY+vA
	 ob8iDnr19X/bSzBgyw125RwvMvmsmMqRlkVL+SMKPy76qcXQlas+/DAKiQTXoSi0W/
	 Ct2iaPHzPq520RSM2y7Lk89JFIWhIWWNJbNzeMOmnRJ72OPe6y8Y+6Tb4RFEC0je32
	 M9a/w77RxwgkSk3YhAcZuleevO84TCYp/Q+51Mm+cEKc4GYjxB+PEGqYIdtuOPJ6H6
	 QdqlGJj9/NRzWJfDvvA1LNLQMPe+6F3V9PDb7AsWjxiEDf2Og0+9fj9qR4VmmB5/V4
	 ztqUUk8yQkiGg==
Message-ID: <e3f4190b-f641-4df7-8b86-98a8be40a852@kernel.org>
Date: Mon, 10 Jun 2024 11:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] reset: add driver for imx8ulp SIM reset controller
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: laurentiu.mihalcea@nxp.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240609125901.76274-1-laurentiumihalcea111@gmail.com>
 <20240609125901.76274-3-laurentiumihalcea111@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240609125901.76274-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 14:59, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Certain components can be reset via the SIM module.
> Add reset controller driver for the SIM module to
> allow drivers for said components to control the
> reset signal(s).
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/Kconfig                         |   7 ++
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-imx8ulp-sim.c             | 103 ++++++++++++++++++
>  include/dt-bindings/reset/imx8ulp-sim-reset.h |  16 +++

That's a binding, not driver. Keep it *always* with binding.

>  4 files changed, 127 insertions(+)
>  create mode 100644 drivers/reset/reset-imx8ulp-sim.c
>  create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h
> 


> +static int imx8ulp_sim_reset_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx8ulp_sim_reset *simr;
> +	int ret;
> +
> +	simr = devm_kzalloc(dev, sizeof(*simr), GFP_KERNEL);
> +	if (!simr)
> +		return -ENOMEM;
> +
> +	simr->regmap = syscon_node_to_regmap(dev->of_node);
> +	if (IS_ERR(simr->regmap)) {
> +		ret = PTR_ERR(simr->regmap);
> +		dev_err(dev, "failed to get regmap: %d\n", ret);
> +		return ret;

syntax is return dev_err_probe()

> +	}


> +
> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> +MODULE_DESCRIPTION("NXP i.MX8ULP System Integration Module Reset driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
> new file mode 100644
> index 000000000000..9f8fb8680a5e
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> +
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_H
> +#define DT_BINDINGS_RESET_IMX8ULP_SIM_H
> +
> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
> +
> +#define IMX8ULP_SIM_RESET_NUM                   3

Drop, not suitable for bindings.

> +
> +#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_H */

Best regards,
Krzysztof


