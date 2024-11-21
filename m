Return-Path: <linux-kernel+bounces-417033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC199D4E10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB53B2155F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CB21D6DB6;
	Thu, 21 Nov 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="IahvPf2G"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392A17BD3;
	Thu, 21 Nov 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196865; cv=none; b=SS8sS1lkFFGI8240wE///gFl4/OuQ4+2MYimCFZ1QzKIuP/MyaOFhtZjmOzWlr9ZbfgRJ18ZS2eUc6VSXEyZxgDLzAnFdNXLluO4QtKHY1KDtQbOp6jIeRn9LwQke5n7DESoTrJLWdg5X3LeWM7agNsON8Egvm0RdFhEde7sE+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196865; c=relaxed/simple;
	bh=EY0YjTtKFXnef9mF9s2fMNuqjKya2i2ClO/4BN1jClA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrJK/bFHHKMpgc+QI9zWofyb/53LbyNHcjhJM2/92CrZYdaWs7DPXbcQGG7cxEP8PZgYOxTC1onLeuq+hMYp5f1m2fi/WMivJFThcNy9JvgKA+FJAZR3HWYHs7R+g0GADTNCvdWpTd425eQ0CsLnYsxSIFHCh24mTNyZMmt2GHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=IahvPf2G; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1732196852; bh=EY0YjTtKFXnef9mF9s2fMNuqjKya2i2ClO/4BN1jClA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IahvPf2GzfWn2L4FGwff36/r6quxMBmGb0vJ6c7BM3A3ytYow7FAPcqEczpAVtzUh
	 6eocAMN/JTjen/VwKViuxTeiN+N2at5p4bZ7KoNFUotmnhx4Bvt8O3vAwG09J5HJ0x
	 VciwNRvs+8zEbLPA2fowLgIoBL0bMH2wjkVdrzlU=
Date: Thu, 21 Nov 2024 14:47:32 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/chrome: cros_ec_charge_state: add new
 driver to control charge
Message-ID: <8fcf9154-6c0d-42eb-901b-0cc9e731e757@t-8ch.de>
References: <20241118-add_charger_state-v1-0-94997079f35a@chromium.org>
 <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-add_charger_state-v1-1-94997079f35a@chromium.org>

On 2024-11-18 17:33:46+0800, Sung-Chi, Li wrote:
> Implement the new platform driver cros_ec_charge_state to have low finer
> control over the charge current flow through the charge chip connected
> on ChromeOS Embedded Controller (EC).
> 
> The driver reads configured charge chip configurations from the device
> tree, and register these chip controls as thermal zone devices, so they
> are controllable from the thermal subsystem.
> 
> As such, corresponding DTS changes are needed, and here is a sample DTS
> configuration:
> 
> ```
> &cros_ec {
> 	charge-chip-battery {
> 		compatible = "google,cros-ec-charge-state";
> 		type = "charge";
> 		min-milliamp = <150>;
> 		max-milliamp = <5000>;
> 	};
> };
> ```
> 
> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
> ---
>  drivers/platform/chrome/Kconfig                |  11 ++
>  drivers/platform/chrome/Makefile               |   1 +
>  drivers/platform/chrome/cros_ec_charge_state.c | 215 +++++++++++++++++++++++++
>  3 files changed, 227 insertions(+)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 7dbeb786352a..34d00d8823cb 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -297,6 +297,17 @@ config CROS_TYPEC_SWITCH
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called cros_typec_switch.
>  
> +config CROS_CHARGE_STATE
> +	tristate "ChromeOS EC Charger Chip  Control"
> +	depends on MFD_CROS_EC_DEV

Should depend on THERMAL_OF.
Otherwise the driver will be built and loaded on non-OF platforms but
probing can never succeed.

> +	default MFD_CROS_EC_DEV
> +	help
> +	  If you say Y here, you get support for configuring the battery
> +	  charging and system input current.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called cros-ec-charge-state.
> +
>  source "drivers/platform/chrome/wilco_ec/Kconfig"
>  
>  # Kunit test cases
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index 2dcc6ccc2302..01c7154ae119 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_HPS_I2C)		+= cros_hps_i2c.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
>  obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
> +obj-$(CONFIG_CROS_CHARGE_STATE)		+= cros_ec_charge_state.o
>  
>  obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
>  
> diff --git a/drivers/platform/chrome/cros_ec_charge_state.c b/drivers/platform/chrome/cros_ec_charge_state.c
> new file mode 100644
> index 000000000000..3fed5b48bc92
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_charge_state.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Charge state driver for ChromeOS Embedded Controller
> + *
> + * Copyright 2024 Google LLC
> + *
> + * This driver exports the low level control over charge chip connected to EC
> + * which allows to manipulate the current used to charge the battery, and also
> + * manipulate the current input to the whole system.
> + * This driver also registers that charge chip as a thermal cooling device.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +
> +#define DRV_NAME "cros-ec-charge-state"
> +#define CHARGE_TYPE_CHARGE "charge"
> +#define CHARGE_TYPE_INPUT "input"
> +
> +struct cros_ec_charge_state_data {
> +	struct cros_ec_device *ec_dev;
> +	struct device *dev;
> +	enum charge_state_params charge_type;
> +	uint32_t min_milliamp;
> +	uint32_t max_milliamp;
> +};
> +
> +static int
> +cros_ec_charge_state_get_current_limit(struct cros_ec_device *ec_dev,
> +				       enum charge_state_params charge_type,
> +				       uint32_t *limit)
> +{
> +	struct ec_params_charge_state param;
> +	struct ec_response_charge_state state;
> +	int ret;
> +
> +	param.cmd = CHARGE_STATE_CMD_GET_PARAM;
> +	param.get_param.param = charge_type;
> +	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_CHARGE_STATE, &param, sizeof(param),
> +			  &state, sizeof(state));
> +	if (ret < 0)
> +		return ret;
> +
> +	*limit = cpu_to_le32(state.get_param.value);

The cros_ec core itself does not handle BE systems.
So I'm not sure if it's worth trying to handle it in the driver.

> +	return 0;
> +}
> +
> +static int
> +cros_ec_charge_state_set_current_limit(struct cros_ec_device *ec_dev,
> +				       enum charge_state_params charge_type,
> +				       uint32_t limit)
> +{
> +	struct ec_params_charge_state param;
> +	int ret;
> +
> +	param.cmd = CHARGE_STATE_CMD_SET_PARAM;
> +	param.set_param.param = charge_type;
> +	param.set_param.value = cpu_to_le32(limit);
> +	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_CHARGE_STATE, &param, sizeof(param),
> +			  NULL, 0);
> +	return (ret < 0) ? ret : 0;
> +}
> +
> +static int
> +cros_ec_charge_state_get_max_state(struct thermal_cooling_device *cdev,
> +				   unsigned long *state)
> +{
> +	struct cros_ec_charge_state_data *data = cdev->devdata;
> +	*state = data->max_milliamp;
> +	return 0;
> +}
> +
> +static int
> +cros_ec_charge_state_get_cur_state(struct thermal_cooling_device *cdev,
> +				   unsigned long *state)
> +{
> +	struct cros_ec_charge_state_data *data = cdev->devdata;
> +	uint32_t limit;
> +	int ret;
> +
> +	ret = cros_ec_charge_state_get_current_limit(data->ec_dev,
> +						     data->charge_type, &limit);
> +	if (ret) {
> +		dev_err(data->dev, "failed to get current state: %d", ret);
> +		return ret;
> +	}
> +
> +	*state = data->max_milliamp - limit;
> +	return 0;
> +}
> +
> +static int
> +cros_ec_charge_state_set_cur_state(struct thermal_cooling_device *cdev,
> +				   unsigned long state)
> +{
> +	struct cros_ec_charge_state_data *data = cdev->devdata;
> +	uint32_t limit = data->max_milliamp - state;
> +
> +	if (limit < data->min_milliamp) {
> +		dev_warn(
> +			data->dev,
> +			"failed to set current %u lower than minimum %d; set to minimum",
> +			limit, data->min_milliamp);
> +		limit = data->min_milliamp;
> +	}
> +
> +	state = data->max_milliamp - limit;
> +	return cros_ec_charge_state_set_current_limit(
> +		data->ec_dev, data->charge_type, (uint32_t)state);
> +}
> +
> +static const struct thermal_cooling_device_ops
> +	cros_ec_charge_state_cooling_device_ops = {
> +		.get_max_state = cros_ec_charge_state_get_max_state,
> +		.get_cur_state = cros_ec_charge_state_get_cur_state,
> +		.set_cur_state = cros_ec_charge_state_set_cur_state,
> +	};
> +
> +static int
> +cros_ec_charge_state_register_charge_chip(struct device *dev,
> +					  struct device_node *node,
> +					  struct cros_ec_device *cros_ec)
> +{
> +	struct cros_ec_charge_state_data *data;
> +	struct thermal_cooling_device *cdev;
> +	const char *type_val = NULL;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = of_property_read_string(node, "type", &type_val);
> +	if (ret) {
> +		dev_err(dev, "failed to get charge type: %d", ret);
> +		return ret;

return dev_err_probe(dev, ...)

> +	}
> +
> +	if (!strcmp(type_val, CHARGE_TYPE_CHARGE)) {
> +		data->charge_type = CS_PARAM_CHG_CURRENT;
> +	} else if (!strcmp(type_val, CHARGE_TYPE_INPUT)) {
> +		data->charge_type = CS_PARAM_CHG_INPUT_CURRENT;
> +	} else {
> +		dev_err(dev, "unknown charge type: %s", type_val);
> +		return -1;
> +	}
> +
> +	ret = of_property_read_u32(node, "min-milliamp", &data->min_milliamp);
> +	if (ret) {
> +		dev_err(dev, "failed to get min-milliamp data: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(node, "max-milliamp", &data->max_milliamp);
> +	if (ret) {
> +		dev_err(dev, "failed to get max-milliamp data: %d", ret);
> +		return ret;
> +	}
> +
> +	data->ec_dev = cros_ec;
> +	data->dev = dev;
> +
> +	cdev = devm_thermal_of_cooling_device_register(
> +		dev, node, node->name, data,
> +		&cros_ec_charge_state_cooling_device_ops);
> +	if (IS_ERR_VALUE(cdev)) {
> +		dev_err(dev,
> +			"failed to register charge chip %s as cooling device: %pe",
> +			node->name, cdev);
> +		return PTR_ERR(cdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cros_ec_charge_state_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
> +	struct device_node *child;
> +
> +	for_each_available_child_of_node(cros_ec->dev->of_node, child) {
> +		if (!of_device_is_compatible(child,
> +					     "google,cros-ec-charge-state"))
> +			continue;
> +		if (cros_ec_charge_state_register_charge_chip(dev, child,
> +							      cros_ec))
> +			continue;
> +	}

If no chips are matched -ENODEV would be better.
And errors should be reported from probe().

Given that this is only useable with OF configuration, would it make
more sense to probe it via OF instead of MFD?

> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id cros_ec_charge_state_id[] = {
> +	{ DRV_NAME,  0 },
> +	{}
> +};

Reference this in the platform_driver below.

> +static struct platform_driver cros_ec_chargedev_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +	.probe = cros_ec_charge_state_probe,
> +};
> +
> +module_platform_driver(cros_ec_chargedev_driver);
> +
> +MODULE_DEVICE_TABLE(platform, cros_ec_charge_state_id);
> +MODULE_DESCRIPTION("ChromeOS EC Charge State Driver");
> +MODULE_AUTHOR("Sung-Chi, Li <lschyi@chromium.org>");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.47.0.338.g60cca15819-goog
> 

