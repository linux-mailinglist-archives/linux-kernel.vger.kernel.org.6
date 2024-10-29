Return-Path: <linux-kernel+bounces-386851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158369B48A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8957283DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE17205AA9;
	Tue, 29 Oct 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A57r+U97"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCB1EE014;
	Tue, 29 Oct 2024 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202696; cv=none; b=hAq0Cjsje0ycvHVBYx8FuHJwL020i8rSYEixC7IsrdkW7o09Dp0adJUzhnbN476JIL15o5QLsONhjDZMJTc/RfVA62zCgE6ZAIzhsR8EUuWqWQs6y5vEc5RA/lTSXLnWLOTZk1L5Yx/PeoVAtTM9QXAQmPd06SYqQt5SBMBA1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202696; c=relaxed/simple;
	bh=ZdJy52MnUdhJfZAcmw04NmRcdVEdN6eNPLma7jJt14o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMB89CWCjeaeW/sM9gc22mVMQUwdOnT01vsy2yBt9lzKMFS8iWFRU00NAihCdWOyfXjweqwhoQkyAiHDNLzEeo2Jh8Zb5ByVxQ6nKeFjprpqwQ15kv45Anr4IF4RwucGleGXIjcBqYbRM9ohO6KO40bVr6DqFamhr6B3RaupMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A57r+U97; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730202694; x=1761738694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZdJy52MnUdhJfZAcmw04NmRcdVEdN6eNPLma7jJt14o=;
  b=A57r+U97Wss7MHkmwZVV0Hh8r9fhBocknbRi9Eg5D3/bxg/TgxeFrwVH
   lJfg4qThiIZR+PErw88zGq6/6Zb8ZznGwR/MwSr8D2LFJF4vJAU+ukSmi
   Ezv8WkORoAmPnJVIQZrVeasRRtNVi4eVGwjxr2G568+nulMndUslXg/JX
   /+PCqTLZhJnVduQq+P8hh9vp2asq2XqxKphzow2+au6/nEkEVauk6CR4g
   D9pURfZh6X24THMracUNT9fFPuEHas8OIYZIkngiJYsol2HBw4d3aQQGw
   J83/uOdkhWqAvtPfcrnoRM+JsR/l9s0LIU7suqykfGx2gBz8v8ZcN4loE
   w==;
X-CSE-ConnectionGUID: QG/lqiuiSDKzF7x2HubMZA==
X-CSE-MsgGUID: MYi2ijIMSZyzpKnLKeU5vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="30048077"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="30048077"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 04:51:33 -0700
X-CSE-ConnectionGUID: FyglJZeSQ+WvpJ36bONx4w==
X-CSE-MsgGUID: 6twB9LDkSR+266OudRqIRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86496977"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa005.fm.intel.com with SMTP; 29 Oct 2024 04:51:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 29 Oct 2024 13:51:28 +0200
Date: Tue, 29 Oct 2024 13:51:28 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: mux: Add support for the TUSB1046
 crosspoint switch
Message-ID: <ZyDMQPmQHaurR15e@kuha.fi.intel.com>
References: <20241024-tusb1046-v2-0-d031b1a43e6d@bootlin.com>
 <20241024-tusb1046-v2-2-d031b1a43e6d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-tusb1046-v2-2-d031b1a43e6d@bootlin.com>

On Thu, Oct 24, 2024 at 10:54:17AM +0200, Romain Gantois wrote:
> The TUSB1046-DCI is a USB-C linear redriver crosspoint switch, which can
> mux SuperSpeed lanes from a Type-C connector to a USB3.0 data lane or up to
> 4 display port lanes.
> 
> Add support for driving the TUSB1046 as a Type-C orientation switch and
> DisplayPort altmode multiplexer.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  MAINTAINERS                      |   7 ++
>  drivers/usb/typec/mux/Kconfig    |   9 ++
>  drivers/usb/typec/mux/Makefile   |   1 +
>  drivers/usb/typec/mux/tusb1046.c | 196 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 213 insertions(+)
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
> index 0000000000000000000000000000000000000000..b4f45c217b59fe033551e8e6379ad2d33ebedbcb
> --- /dev/null
> +++ b/drivers/usb/typec/mux/tusb1046.c
> @@ -0,0 +1,196 @@
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
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/err.h>
> +#include <linux/of_device.h>
> +#include <linux/device.h>
> +#include <linux/mutex.h>
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
> +
> +	/* Lock General register during accesses */
> +	struct mutex general_reg_lock;
> +};
> +
> +static int tusb1046_mux_set(struct typec_mux_dev *mux,
> +			    struct typec_mux_state *state)
> +{
> +	struct tusb1046_priv *priv = typec_mux_get_drvdata(mux);
> +	struct i2c_client *client = priv->client;
> +	struct device *dev = &client->dev;
> +	int mode, val, ret = 0;
> +
> +	if (state->mode >= TYPEC_STATE_MODAL &&
> +	    state->alt->svid != USB_TYPEC_DP_SID)
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "mux mode requested: %lu\n", state->mode);
> +
> +	mutex_lock(&priv->general_reg_lock);
> +
> +	val = i2c_smbus_read_byte_data(client, TUSB1046_REG_GENERAL);
> +	if (val < 0) {
> +		dev_err(dev, "failed to read ctlsel status, err %d\n", val);
> +		ret = val;
> +		goto out_unlock;
> +	}
> +
> +	switch (state->mode) {
> +	case TYPEC_STATE_USB:
> +		mode = TUSB1046_CTLSEL_USB3;
> +		break;
> +	case TYPEC_DP_STATE_C:
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
> +	ret = i2c_smbus_write_byte_data(client, TUSB1046_REG_GENERAL, val);
> +
> +out_unlock:
> +	mutex_unlock(&priv->general_reg_lock);
> +	return ret;
> +}
> +
> +static int tusb1046_switch_set(struct typec_switch_dev *sw,
> +			       enum typec_orientation orientation)
> +{
> +	struct tusb1046_priv *priv = typec_switch_get_drvdata(sw);
> +	struct i2c_client *client = priv->client;
> +	struct device *dev = &client->dev;
> +	int val, ret = 0;
> +
> +	dev_dbg(dev, "setting USB3.0 lane flip for orientation %d\n", orientation);
> +
> +	mutex_lock(&priv->general_reg_lock);
> +
> +	val = i2c_smbus_read_byte_data(client, TUSB1046_REG_GENERAL);
> +	if (val < 0) {
> +		dev_err(dev, "failed to read flipsel status, err %d\n", val);
> +		ret = val;
> +		goto out_unlock;
> +	}
> +
> +	if (orientation == TYPEC_ORIENTATION_REVERSE)
> +		val |= TUSB1046_GENERAL_FLIPSEL;
> +	else
> +		val &= ~TUSB1046_GENERAL_FLIPSEL;
> +
> +	ret = i2c_smbus_write_byte_data(client, TUSB1046_REG_GENERAL, val);
> +
> +out_unlock:
> +	mutex_unlock(&priv->general_reg_lock);
> +	return ret;
> +}
> +
> +static int tusb1046_i2c_probe(struct i2c_client *client)
> +{
> +	struct typec_switch_desc sw_desc = { };
> +	struct typec_mux_desc mux_desc = { };
> +	struct device *dev = &client->dev;
> +	struct tusb1046_priv *priv;
> +	int ret = 0;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver data\n");
> +
> +	priv->client = client;
> +
> +	mutex_init(&priv->general_reg_lock);
> +
> +	sw_desc.drvdata = priv;
> +	sw_desc.fwnode = dev_fwnode(dev);
> +	sw_desc.set = tusb1046_switch_set;
> +
> +	priv->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(priv->sw)) {
> +		ret = dev_err_probe(dev, PTR_ERR(priv->sw), "failed to register type-c switch\n");
> +		goto err_destroy_mutex;
> +	}
> +
> +	mux_desc.drvdata = priv;
> +	mux_desc.fwnode = dev_fwnode(dev);
> +	mux_desc.set = tusb1046_mux_set;
> +
> +	priv->mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(priv->mux)) {
> +		ret = dev_err_probe(dev, PTR_ERR(priv->mux), "failed to register type-c mux\n");
> +		goto err_unregister_switch;
> +	}
> +
> +	i2c_set_clientdata(client, priv);
> +
> +	return 0;
> +
> +err_unregister_switch:
> +	typec_switch_unregister(priv->sw);
> +err_destroy_mutex:
> +	mutex_destroy(&priv->general_reg_lock);
> +	return ret;
> +}
> +
> +static void tusb1046_i2c_remove(struct i2c_client *client)
> +{
> +	struct tusb1046_priv *priv = i2c_get_clientdata(client);
> +
> +	typec_switch_unregister(priv->sw);
> +	typec_mux_unregister(priv->mux);
> +	mutex_destroy(&priv->general_reg_lock);
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

-- 
heikki

