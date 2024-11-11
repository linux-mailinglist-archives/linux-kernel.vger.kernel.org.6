Return-Path: <linux-kernel+bounces-403717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522F59C398E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D848C1F2127B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D7159565;
	Mon, 11 Nov 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qITuv7Z3"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCF14885D;
	Mon, 11 Nov 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313014; cv=none; b=TMnhXxBsz1BZ0u9CdU+JPB7s1IPxbEWk0lfTIUl4FpRs/3lv9bkNbvrFQgzx7ns8luom83cMmUQ6Rj9HNWWrDLy4waB6USv+L9hDi1+Omgx8cBcSau76fdFFJTcsTTwVgwmA5vmUKLkg1w88TZwjUzco7A+wdo9dTXkUdbRVaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313014; c=relaxed/simple;
	bh=VQZwEOVPHd1umSAmuNBGweXntUbY7S80zDGI2rUq5hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4nCtGMY85IZWph0L7mf55AHhUK/RrQVRRz61f920Xhz+xgJGMb/8WsOoI9dZBrnbOVc3lTqK7+TbqCDpz2vVPba/2w5hIfS42vnopJ8bl0p0YMyyG+wIGYdvsKgFIhGAyP1gkBOLYbUvseFSiyyicLO4ZkID5jgF/JCY2aTkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qITuv7Z3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731313000;
	bh=VQZwEOVPHd1umSAmuNBGweXntUbY7S80zDGI2rUq5hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qITuv7Z3Z+2AGeFFdBwGhIITdYYrghAQOP1NLbOU1s1XlV4cOPg7FKXyItb1sgl7y
	 j7A2KtEXcBhjwOkQjFh5zPGrgSi7SETFdMadTac2zNl4G9uus1cung9GWovM9D6SaB
	 mp7xrz4yy9JxzSCRSINOH/jn2j7AkQDswDmhZRiA=
Date: Mon, 11 Nov 2024 09:16:40 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: "Sung-Chi, Li" <lschyi@chromium.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, bleung@chromium.org, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (cros_ec) register thermal sensors to thermal
 framework
Message-ID: <88c75cba-d8a3-42a4-92fb-d041c9709f47@t-8ch.de>
References: <20241111074904.1059268-1-lschyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111074904.1059268-1-lschyi@chromium.org>

Hi!

On 2024-11-11 15:49:04+0800, Sung-Chi, Li wrote:
> cros_ec hwmon driver probes available thermal sensors when probing the
> driver.  Register these thermal sensors to the thermal framework, such
> that thermal framework can adopt these sensors as well.
> 
> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 69 +++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 5514cf780b8b..4b1ea431e3d2 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -7,20 +7,31 @@
>  
>  #include <linux/device.h>
>  #include <linux/hwmon.h>
> +#include <linux/list.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/thermal.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> -#define DRV_NAME	"cros-ec-hwmon"
> +#define DRV_NAME		"cros-ec-hwmon"
> +#define THERMAL_VAL_OFFSET	200
>  
>  struct cros_ec_hwmon_priv {
>  	struct cros_ec_device *cros_ec;
>  	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
>  	u8 usable_fans;
> +	struct list_head sensors;
> +};
> +
> +struct cros_ec_sensor_data {

cros_ec_hwmon_thermal_zone_data.

> +	struct cros_ec_device *cros_ec;
> +	struct thermal_zone_device *tz_dev;
> +	int addr;

This is not an address, but an index.

> +	struct list_head node;
>  };
>  
>  static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> @@ -185,11 +196,32 @@ static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {
>  	.info = cros_ec_hwmon_info,
>  };
>  
> -static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_hwmon_priv *priv,
> +static int cros_ec_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct cros_ec_sensor_data *data = thermal_zone_device_priv(tz);
> +	int ret;
> +	u8 val;
> +
> +	ret = cros_ec_hwmon_read_temp(data->cros_ec, data->addr, &val);
> +	if (ret)
> +		return -ENODATA;
> +	*temp = (val + THERMAL_VAL_OFFSET - 273) * 1000;

Use cros_ec_hwmon_temp_to_millicelsius() and cros_ec_hwmon_is_error_temp().

> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops thermal_ops = {
> +	.get_temp = cros_ec_thermal_get_temp,
> +};

Use the cros_ec_hwmon symbol prefix.

> +
> +static void cros_ec_hwmon_probe_temp_sensors(struct cros_ec_device *cros_ec,
> +					     struct device *dev,
> +					     struct cros_ec_hwmon_priv *priv,
> +					     struct list_head *head,
>  					     u8 thermal_version)
>  {
>  	struct ec_params_temp_sensor_get_info req = {};
>  	struct ec_response_temp_sensor_get_info resp;
> +	struct cros_ec_sensor_data *data;
>  	size_t candidates, i, sensor_name_size;
>  	int ret;
>  	u8 temp;
> @@ -216,6 +248,23 @@ static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_
>  		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%.*s",
>  							    (int)sensor_name_size,
>  							    resp.sensor_name);
> +
> +		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			continue;
> +
> +		data->addr = i;
> +		data->cros_ec = cros_ec;
> +		data->tz_dev = devm_thermal_of_zone_register(
> +			cros_ec->dev, i, data, &thermal_ops);

I'm a bit confused. The uses thermal configuration from OF,
but this driver has no specific OF support.
Can you provide a usage example in the commit message?

Does it not need a binding documentation update?

> +		if (IS_ERR_VALUE(data->tz_dev)) {
> +			dev_err(dev,
> +				"failed to register %zu thermal sensor, err = %ld",
> +				i, PTR_ERR(data->tz_dev));

Use %pe.

> +			continue;
> +		}
> +
> +		list_add(&data->node, head);
>  	}
>  }
>  
> @@ -255,8 +304,10 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	priv->cros_ec = cros_ec;
> +	INIT_LIST_HEAD(&priv->sensors);
>  
> -	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
> +	cros_ec_hwmon_probe_temp_sensors(cros_ec, dev, priv, &priv->sensors,
> +					 thermal_version);

cros_ec is already passed as priv->cros_ec.

>  	cros_ec_hwmon_probe_fans(priv);
>  
>  	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
> @@ -265,6 +316,17 @@ static int cros_ec_hwmon_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(hwmon_dev);
>  }
>  
> +static void cros_ec_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +	struct cros_ec_sensor_data *iter;
> +
> +	list_for_each_entry(iter, &priv->sensors, node) {
> +		devm_thermal_of_zone_unregister(dev, iter->tz_dev);

This shouldn't be needed, the zone will be unregistered automatically by
the devm framework.
This also means that .remove and priv->sensors can go away.

> +	}
> +}
> +
>  static const struct platform_device_id cros_ec_hwmon_id[] = {
>  	{ DRV_NAME, 0 },
>  	{}
> @@ -273,6 +335,7 @@ static const struct platform_device_id cros_ec_hwmon_id[] = {
>  static struct platform_driver cros_ec_hwmon_driver = {
>  	.driver.name	= DRV_NAME,
>  	.probe		= cros_ec_hwmon_probe,
> +	.remove		= cros_ec_hwmon_remove,
>  	.id_table	= cros_ec_hwmon_id,
>  };
>  module_platform_driver(cros_ec_hwmon_driver);
> -- 
> 2.47.0.277.g8800431eea-goog
> 

