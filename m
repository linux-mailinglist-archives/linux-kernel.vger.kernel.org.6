Return-Path: <linux-kernel+bounces-371937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CF9A4253
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A5928105C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B0201254;
	Fri, 18 Oct 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byWgYVJi"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7011FF60E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265285; cv=none; b=AnU9/VX/BQj3uYjNiaTkWA90sBVaLIaR/HK09SZ6RSYiWJFC/m3/lCBdrWaIMNU6X9hmVrFletaQqHRTs8zP/jQQWw/O9s6fbyaRNHnrY0E2Bsg0VuAofNacbq8+g7HB0C0duG+rn4IszeLJmPNWHZRwFibsMo2Nk8zNiYe7Snc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265285; c=relaxed/simple;
	bh=C3Ec4ZywUcLyl7Ti+mO1A9lNTZgcdltNTaZhreoAULM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niC+xFS3ubpfqe0zLEQIWSMYSG2PYWt+bCFL5otTye+TezxjJi25vQoPxJS3DgM6wRAqA3M5zKw8F1gnVkNy5TorE0RDt0nF5JC+lZLM6BSHp6OpAWKDeOr2eVoVIizkLn5ht0oIPJoVgzDKBZLaWzQV5JedAQ76Nu9R8NapH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=byWgYVJi; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2280616e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729265281; x=1729870081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J9igagZbTZpOqBkc1gSwcBtmtCoyin8WrPAiBEamjxE=;
        b=byWgYVJirVA78jLxelInPwy0RFFF5I44WvQACJMR7+9fgjRtoXWmzR87McQimFljfJ
         vXoYOb/1BCCO59hUgvSuGpMvvo54C1940GvGU7yzKe6vO4zEcaL9CcuOeCWfrLW8/BJz
         YTz5sNLnfPNVEWWS0F0lBX4MfDu1j2rxO3j7MRqc1zjvBRZB/PtvMNM3G+rvfVdWwbw8
         +uTQ9rM3H1h+do+zhZ5zzSHWVoD7s9O0jlqw19N3a+AlLTyICalZlPaNVCJzVD3AjpNz
         FEuzNCtcPqUZ+a74eDVxxtBmx38X/GqwMyc9XCqvQnOp9brK6DqBPYqHAoeYzpJN3XDk
         C+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265281; x=1729870081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9igagZbTZpOqBkc1gSwcBtmtCoyin8WrPAiBEamjxE=;
        b=c2zKO1mShz0aMU4vWJYafuko14ijVw2N9qi9veJSAU6OLg709HYU1X5dE+XqkguOl0
         g2cKnnVNlCL7MVwSx0F7bwRCv9oDyXpY9SiRrpsW1DbnMtvFUpvZAYXAg8Ue6jm6+Vii
         110vyfUecMxdWtP3NIpo6zLD0h/OnvVEZ1CciiMCp5BYYTN6n7WW2gkyK9jnoHh85JDR
         O2sJ7eUUz3jhVKA0GJ59LQSeeuDDgqlValKcBtm+LOkmglliilt6v+xb1WmcOkVk9hag
         CjdmUbJGzwpUfzOYKaeY3PLWempn/vkAoFOIDBWL5bZsN1HxDlS6b6qvHbCE7GTNR95/
         GRFA==
X-Forwarded-Encrypted: i=1; AJvYcCU8cfKgyUdylHfQ0bGVWxE3U0cYAFWBUWiBDgXax1WwmS4p2gQZpipVPWk/ncXqjPK6CGdCFKuK/rUQ9ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDNApNjs6dkURHch1yJCrVimUiKRB1J+0+tuYQoIbr1MuTWFl
	zkvYldlXWhyTxckKtEfUvAlR3yW8b/4fcJaESUfvl03aRFT2JLNzeZXwfcACGKE=
X-Google-Smtp-Source: AGHT+IGDVIqQv+Tpup9SNBWVuFswxN7imPsyI0MtXA1lYFXP+bneTPZNYGhJPSJ0LOIALSlKt5IQvg==
X-Received: by 2002:a05:6512:2813:b0:539:f6b1:2d05 with SMTP id 2adb3069b0e04-53a0c6ad3a5mr2462432e87.9.1729265280579;
        Fri, 18 Oct 2024 08:28:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211b27sm245443e87.256.2024.10.18.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:28:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:27:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: mux: Add support for the TUSB1046
 crosspoint switch
Message-ID: <4y5zvdauy4wg6gjkd2pnenamnc4rkoo4ilrm5lftopwbc2kifk@4lwtyo72ewaa>
References: <20241018-tusb1046-v1-0-a38312f18691@bootlin.com>
 <20241018-tusb1046-v1-2-a38312f18691@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-tusb1046-v1-2-a38312f18691@bootlin.com>

On Fri, Oct 18, 2024 at 03:30:49PM +0200, Romain Gantois wrote:
> The TUSB1046-DCI is a USB-C linear redriver crosspoint switch, which can
> mux SuperSpeed lanes from a Type-C connector to a USB3.0 data lane or up to
> 4 display port lanes.
> 
> Add support for driving the TUSB1046 as a Type-C orientation switch and
> DisplayPort altmode multiplexer.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  MAINTAINERS                      |   7 ++
>  drivers/usb/typec/mux/Kconfig    |   9 +++
>  drivers/usb/typec/mux/Makefile   |   1 +
>  drivers/usb/typec/mux/tusb1046.c | 161 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 178 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c27f3190737f8b85779bde5489639c8b899f4fd8..c880588b63f27d628edeec09fa7d904eeabbde92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24142,6 +24142,13 @@ L:	linux-usb@vger.kernel.org
>  S:	Orphan
>  F:	drivers/usb/typec/tcpm/
>  
> +USB TYPEC TUSB1046 MUX DRIVER
> +M:	Romain Gantois <romain.gantois@bootlin.com>
> +L:	linux-usb@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/usb/ti,tusb1046.yaml
> +F:	drivers/usb/typec/mux/tusb1046.c
> +
>  USB UHCI DRIVER
>  M:	Alan Stern <stern@rowland.harvard.edu>
>  L:	linux-usb@vger.kernel.org
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index ce7db6ad30572a0a74890f5f11944fb3ff07f635..67381b4ef4f68f4a6e73f157365ee24d0ab7109a 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -66,6 +66,15 @@ config TYPEC_MUX_PTN36502
>  	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
>  	  found on some devices with a Type-C port.
>  
> +config TYPEC_MUX_TUSB1046
> +	tristate "TI TUSB1046 Type-C crosspoint switch driver"
> +	depends on I2C
> +	help
> +	  Driver for the Texas Instruments TUSB1046-DCI crosspoint switch.
> +	  Supports flipping USB-C SuperSpeed lanes to adapt to orientation
> +	  changes, as well as muxing DisplayPort and sideband signals to a
> +	  common Type-C connector.
> +
>  config TYPEC_MUX_WCD939X_USBSS
>  	tristate "Qualcomm WCD939x USBSS Analog Audio Switch driver"
>  	depends on I2C
> diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
> index bb96f30267af05b33b9277dcf1cc0e1527d2dcdd..60879446da9365183567d3374a2fb7b5171fb3d7 100644
> --- a/drivers/usb/typec/mux/Makefile
> +++ b/drivers/usb/typec/mux/Makefile
> @@ -7,4 +7,5 @@ obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
>  obj-$(CONFIG_TYPEC_MUX_IT5205)		+= it5205.o
>  obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
>  obj-$(CONFIG_TYPEC_MUX_PTN36502)	+= ptn36502.o
> +obj-$(CONFIG_TYPEC_MUX_TUSB1046)	+= tusb1046.o
>  obj-$(CONFIG_TYPEC_MUX_WCD939X_USBSS)	+= wcd939x-usbss.o
> diff --git a/drivers/usb/typec/mux/tusb1046.c b/drivers/usb/typec/mux/tusb1046.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..76edb83c057a764ccee7d717852c3eaaf02d808f
> --- /dev/null
> +++ b/drivers/usb/typec/mux/tusb1046.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for the TUSB1046-DCI USB Type-C crosspoint switch
> + *
> + * Copyright (C) 2024 Bootlin
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/i2c.h>
> +#include <linux/usb/typec_mux.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/err.h>
> +#include <linux/of_device.h>
> +#include <linux/device.h>
> +
> +#define TUSB1046_REG_GENERAL 0xa
> +
> +/* General register bits */
> +#define TUSB1046_GENERAL_FLIPSEL BIT(2)
> +#define TUSB1046_GENERAL_CTLSEL  GENMASK(1, 0)
> +
> +/* Mux modes */
> +#define TUSB1046_CTLSEL_DISABLED          0x0
> +#define TUSB1046_CTLSEL_USB3              0x1
> +#define TUSB1046_CTLSEL_4LANE_DP          0x2
> +#define TUSB1046_CTLSEL_USB3_AND_2LANE_DP 0x3
> +
> +struct tusb1046_priv {
> +	struct i2c_client *client;
> +	struct typec_switch_dev *sw;
> +	struct typec_mux_dev *mux;
> +};
> +
> +static int tusb1046_mux_set(struct typec_mux_dev *mux,
> +			    struct typec_mux_state *state)
> +{
> +	struct tusb1046_priv *priv = typec_mux_get_drvdata(mux);
> +	struct i2c_client *client = priv->client;
> +	struct device *dev = &client->dev;
> +	int mode, val;
> +
> +	dev_dbg(dev, "mux mode requested: %lu\n", state->mode);
> +

RMW cycles should be protected by a mutex, so that mux and switch
operations don't rewrite the register concurrently.

> +	val = i2c_smbus_read_byte_data(client, TUSB1046_REG_GENERAL);
> +	if (val < 0) {
> +		dev_err(dev, "failed to read ctlsel status, err %d\n", val);
> +		return val;
> +	}
> +
> +	switch (state->mode) {
> +	case TYPEC_STATE_USB:
> +		mode = TUSB1046_CTLSEL_USB3;
> +		break;
> +	case TYPEC_DP_STATE_C:

The TYPEC_DP_STATE_n states are valid only after checking altmode's
SVID. Otherwise it might be that some other altmode has been selected.

> +	case TYPEC_DP_STATE_E:
> +		mode = TUSB1046_CTLSEL_4LANE_DP;
> +		break;
> +	case TYPEC_DP_STATE_D:
> +		mode = TUSB1046_CTLSEL_USB3_AND_2LANE_DP;
> +		break;
> +	case TYPEC_STATE_SAFE:
> +	default:
> +		mode = TUSB1046_CTLSEL_DISABLED;
> +		break;
> +	}
> +
> +	val &= ~TUSB1046_GENERAL_CTLSEL;
> +	val |= mode;
> +
> +	return i2c_smbus_write_byte_data(client, TUSB1046_REG_GENERAL, val);
> +}
> +
> +static int tusb1046_switch_set(struct typec_switch_dev *sw,
> +			       enum typec_orientation orientation)
> +{
> +	struct tusb1046_priv *priv = typec_switch_get_drvdata(sw);
> +	struct i2c_client *client = priv->client;
> +	struct device *dev = &client->dev;
> +	int val;
> +
> +	dev_dbg(dev, "setting USB3.0 lane flip for orientation %d\n", orientation);
> +
> +	val = i2c_smbus_read_byte_data(client, TUSB1046_REG_GENERAL);
> +	if (val < 0) {
> +		dev_err(dev, "failed to read flipsel status, err %d\n", val);
> +		return val;
> +	}
> +
> +	if (orientation == TYPEC_ORIENTATION_REVERSE)
> +		val |= TUSB1046_GENERAL_FLIPSEL;
> +	else
> +		val &= ~TUSB1046_GENERAL_FLIPSEL;
> +
> +	return i2c_smbus_write_byte_data(client, TUSB1046_REG_GENERAL, val);
> +}
> +
> +static int tusb1046_i2c_probe(struct i2c_client *client)
> +{
> +	struct typec_switch_desc sw_desc = { };
> +	struct typec_mux_desc mux_desc = { };
> +	struct device *dev = &client->dev;
> +	struct tusb1046_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver data\n");
> +
> +	priv->client = client;
> +
> +	sw_desc.drvdata = priv;
> +	sw_desc.fwnode = dev_fwnode(dev);
> +	sw_desc.set = tusb1046_switch_set;
> +
> +	priv->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(priv->sw))
> +		return dev_err_probe(dev, PTR_ERR(priv->sw), "failed to register type-c switch\n");
> +
> +	mux_desc.drvdata = priv;
> +	mux_desc.fwnode = dev_fwnode(dev);
> +	mux_desc.set = tusb1046_mux_set;
> +
> +	priv->mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(priv->mux)) {
> +		typec_switch_unregister(priv->sw);
> +		return dev_err_probe(dev, PTR_ERR(priv->mux), "failed to register type-c mux\n");
> +	}
> +
> +	i2c_set_clientdata(client, priv);
> +
> +	return 0;
> +}
> +
> +static void tusb1046_i2c_remove(struct i2c_client *client)
> +{
> +	struct tusb1046_priv *priv = i2c_get_clientdata(client);
> +
> +	typec_switch_unregister(priv->sw);
> +	typec_mux_unregister(priv->mux);
> +}
> +
> +static const struct of_device_id tusb1046_match_table[] = {
> +	{.compatible = "ti,tusb1046"},
> +	{},
> +};
> +
> +static struct i2c_driver tusb1046_driver = {
> +	.driver = {
> +		.name = "tusb1046",
> +		.of_match_table = tusb1046_match_table,
> +	},
> +	.probe = tusb1046_i2c_probe,
> +	.remove = tusb1046_i2c_remove,
> +};
> +
> +module_i2c_driver(tusb1046_driver);
> +
> +MODULE_DESCRIPTION("TUSB1046 USB Type-C switch driver");
> +MODULE_AUTHOR("Romain Gantois <romain.gantois@bootlin.com>");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

