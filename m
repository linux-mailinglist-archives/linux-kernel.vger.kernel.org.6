Return-Path: <linux-kernel+bounces-337421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39749849E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A971C20B65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330551AC42E;
	Tue, 24 Sep 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qW09/JmN"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B71A4F30
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727196204; cv=none; b=hAw7o99oYqstKHRJ0jNqnvpiwjhHTEggC0V9CZOAdDzQ8sGNT4VgedJNTLqIHFUdXmRwf+5e1a346YvgRSjKW8WYeL98grFGFMgQgXDPtY5XJekOOS/+bd85sl5JA5cT/ptkxPP2iW46kmBvCGxizCcuWyetbREZ7sEjxRet57g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727196204; c=relaxed/simple;
	bh=zT4k+0TxX97y+c3I5eO7EHj/LUItIHnBYBJW7QZhE+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVhx6ab6BILqXPrvOk7o61igjXvyvwIMtdmvU37SsodSkxIvbARurj8qukS/hHrcLd7DzJW8ue9lP1cHxFOZBpfOsSmhltnXR1Xm7xi59RaMQjjbH/OwG8L8RN2BDhlLppr14ceYgMGtMrz5ZAiOxf+mhnIXom+xjtZeSNiBX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qW09/JmN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f759b87f83so61292561fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727196199; x=1727800999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLmWupQuIxURteGxaOu17nS4Aw/Rss6V3alddoHTmYQ=;
        b=qW09/JmNyEhkxklbk2TP1irQN9eB3yDkfm5eX8sjC9QoY5vq1Lf9VBv6wOON8RZZOj
         5wCCrikwehefEIu4AMd2hiD6L8jFWNVjIbs47/XAqOdv074lE/bRd/GhQaL6EJRNcsZq
         JYHOPvi1SI5gjSXnC3KxQoKsFoR4Y7k1t5l5t3QYLQyPEfBPeb4SloBfI8oTGzq+loWB
         z4W2a5gfEjJE+ga9Hbnm7Ztns2FwgRWsNanjZDaHV6N4brEkE0PoK0M1CICdUq8Mp4N2
         KV5Lx++qtJXhUWW547p9dydrLNSKdoBA7PfZosvvKDSzXcFF2VlLDF2Qv9gg4Ds/cojo
         63Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727196199; x=1727800999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLmWupQuIxURteGxaOu17nS4Aw/Rss6V3alddoHTmYQ=;
        b=VpZtZJbVWwVce7F50GMGKlpG25K8MLGFSGc5U7jNUBvo8iidRW8AabmKUMvWaz66iv
         QwPeSwUmRIEL/YcnaBV0Z7ddBmWwNOaNzs5ZOQecYhqcAAae/erroVummYPOCVVFMIBt
         QlKtbdq0K6sASc5+JFgK3YWYD/UR51HjpEIPYNRXhr7HBwsOHNjFPas/Iw5v6pOGRdgc
         Uzo6ms9B58sKnfxaeyGpXQvrddVQCRUzu1lZqwNJ0M+6GHF6YOKv1JzKkbMbWBwGy9/z
         r/SMypK9MO8aDfVSaqG+n25VeXLlAoNZX3HpkbGHQH/FF5HB2Hta4tzsML5V1HQR4cZk
         m3yw==
X-Forwarded-Encrypted: i=1; AJvYcCUMatVaa2q7KC/3pRbXTLk2Lvz3Raa063/94236mtUgQHFtV/Hm0xKdsmZ6VVyLHdudMBSakl3qOz5KBXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLkfOzbOd7uP4x2xxS0TFvPOnGpFc5/dKEyP88ZA+cliNJUi/
	Sf56YOu9uGlZ11EynkAyJDhw/Mwv8YhPhT+nI3T6CqLp/yc+bKrw/He9VoJxYLk=
X-Google-Smtp-Source: AGHT+IEezobaIL04e3lPxMDU2Y+PPIoCnCTJI3N3CWxUIHXwcFH+J92I5mDokhkQOYy3JFhcIgkX5A==
X-Received: by 2002:a2e:bc26:0:b0:2f5:2e2:eafb with SMTP id 38308e7fff4ca-2f915fc1487mr256741fa.7.1727196199064;
        Tue, 24 Sep 2024 09:43:19 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:4518:32:3b61:babd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4d7461sm916227a12.79.2024.09.24.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 09:43:18 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:16 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] phy: add NXP PTN3222 eUSB2 to USB2 redriver
Message-ID: <ZvLsJEa2PhIxFRDC@linaro.org>
References: <20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org>
 <20240830-nxp-ptn3222-v2-2-4c6d8535cf6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-nxp-ptn3222-v2-2-4c6d8535cf6c@linaro.org>

On Fri, Aug 30, 2024 at 11:20:46AM +0300, Dmitry Baryshkov wrote:
> The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
> translation between eUSB2 and USB2 signalling schemes. It supports all
> three data rates: Low Speed, Full Speed and High Speed.
> 
> The reset state enables autonegotiation of the PHY role and of the data
> rate, so no additional programming is required.
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This works well for the USB fingerprint reader on the Qualcomm X1E80100
CRD. Thanks a lot for the clean driver :-)

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>

> ---
>  drivers/phy/Kconfig           |  11 ++++
>  drivers/phy/Makefile          |   1 +
>  drivers/phy/phy-nxp-ptn3222.c | 123 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 135 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index dfab1c66b3e5..cb06a7f79740 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -82,6 +82,17 @@ config PHY_AIROHA_PCIE
>  	  This driver create the basic PHY instance and provides initialize
>  	  callback for PCIe GEN3 port.
>  
> +config PHY_NXP_PTN3222
> +	tristate "NXP PTN3222 1-port eUSB2 to USB2 redriver"
> +	depends on I2C
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Enable this to support NXP PTN3222 1-port eUSB2 to USB2 Redriver.
> +	  This redriver performs translation between eUSB2 and USB2 signalling
> +	  schemes. It supports all three USB 2.0 data rates: Low Speed, Full
> +	  Speed and High Speed.
> +
>  source "drivers/phy/allwinner/Kconfig"
>  source "drivers/phy/amlogic/Kconfig"
>  source "drivers/phy/broadcom/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 5fcbce5f9ab1..b64247046575 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
>  obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
>  obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
> +obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
>  obj-y					+= allwinner/	\
>  					   amlogic/	\
>  					   broadcom/	\
> diff --git a/drivers/phy/phy-nxp-ptn3222.c b/drivers/phy/phy-nxp-ptn3222.c
> new file mode 100644
> index 000000000000..c6179d8701e6
> --- /dev/null
> +++ b/drivers/phy/phy-nxp-ptn3222.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024, Linaro Limited
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define NUM_SUPPLIES 2
> +
> +struct ptn3222 {
> +	struct i2c_client *client;
> +	struct phy *phy;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data *supplies;
> +};
> +
> +static int ptn3222_init(struct phy *phy)
> +{
> +	struct ptn3222 *ptn3222 = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(NUM_SUPPLIES, ptn3222->supplies);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(ptn3222->reset_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int ptn3222_exit(struct phy *phy)
> +{
> +	struct ptn3222 *ptn3222 = phy_get_drvdata(phy);
> +
> +	gpiod_set_value_cansleep(ptn3222->reset_gpio, 1);
> +
> +	return regulator_bulk_disable(NUM_SUPPLIES, ptn3222->supplies);
> +}
> +
> +static const struct phy_ops ptn3222_ops = {
> +	.init		= ptn3222_init,
> +	.exit		= ptn3222_exit,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct regulator_bulk_data ptn3222_supplies[NUM_SUPPLIES] = {
> +	{
> +		.supply = "vdd3v3",
> +		.init_load_uA = 11000,
> +	}, {
> +		.supply = "vdd1v8",
> +		.init_load_uA = 55000,
> +	}
> +};
> +
> +static int ptn3222_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct phy_provider *phy_provider;
> +	struct ptn3222 *ptn3222;
> +	int ret;
> +
> +	ptn3222 = devm_kzalloc(dev, sizeof(*ptn3222), GFP_KERNEL);
> +	if (!ptn3222)
> +		return -ENOMEM;
> +
> +	ptn3222->client = client;
> +
> +	ptn3222->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						      GPIOD_OUT_HIGH);
> +	if (IS_ERR(ptn3222->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ptn3222->reset_gpio),
> +				     "unable to acquire reset gpio\n");
> +
> +	ret = devm_regulator_bulk_get_const(dev, NUM_SUPPLIES, ptn3222_supplies,
> +					    &ptn3222->supplies);
> +	if (ret)
> +		return ret;
> +
> +	ptn3222->phy = devm_phy_create(dev, dev->of_node, &ptn3222_ops);
> +	if (IS_ERR(ptn3222->phy)) {
> +		dev_err(dev, "failed to create PHY: %d\n", ret);
> +		return PTR_ERR(ptn3222->phy);
> +	}
> +
> +	phy_set_drvdata(ptn3222->phy, ptn3222);
> +
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static const struct i2c_device_id ptn3222_table[] = {
> +	{ "ptn3222" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ptn3222_table);
> +
> +static const struct of_device_id ptn3222_of_table[] = {
> +	{ .compatible = "nxp,ptn3222" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ptn3222_of_table);
> +
> +static struct i2c_driver ptn3222_driver = {
> +	.driver = {
> +		.name = "ptn3222",
> +		.of_match_table = ptn3222_of_table,
> +	},
> +	.probe = ptn3222_probe,
> +	.id_table = ptn3222_table,
> +};
> +
> +module_i2c_driver(ptn3222_driver);
> +
> +MODULE_DESCRIPTION("NXP PTN3222 eUSB2 Redriver driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.39.2
> 

