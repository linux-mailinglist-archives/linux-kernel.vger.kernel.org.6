Return-Path: <linux-kernel+bounces-404347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4AA9C42AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6138B21A37
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862561A0BD7;
	Mon, 11 Nov 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="V5PhpvXo"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806819C575;
	Mon, 11 Nov 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342657; cv=none; b=GTCExmJqgetgL9Yi7yMZSJlMyqbZFWQxFuzD8EHuFn/cPdUqWJdewVanwlrzWNX0+C/S+OHYOBsLyA4ciHTO577RYk77snyzK44R4EbRuGUmxbGyuqLjZ3iNbYtfv2OdYpfIKMV2NmU1M2AsarZdjo6DlzJvrEqGSV0MghqY8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342657; c=relaxed/simple;
	bh=+x8bnIxKFSLgLd0LiO4UJ5+z4gmDHKrgkS3pxB6CIcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9ruMw5zgzb3ZX1cSXC0M953PD+S7htW4KIzmqXFvPtAK7HoAHr6+Ld163/WFxeENU0ukCLkMyTf/S0KBQMBepsQRr/mdOrV4w6kke7dIh2lOzA5FvDGREz0WhVRi1PcOlurHZo3+bwYKxRRz6YeuzBybWfLZz7SENzL4fqIQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=V5PhpvXo; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731342651;
	bh=+x8bnIxKFSLgLd0LiO4UJ5+z4gmDHKrgkS3pxB6CIcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5PhpvXoJi6Mra+JvR4Eg+IKph3+MR9f/gberukS05wwjidHQUIK0FqSI/pZhmfuQ
	 JezkGkYvRViJxjXucl5DxB1pN/m/Aw/S4jnp0dro8nrt7adguYUogAw3Xv1K5X34LH
	 rpABCe6qEcZtOSG+HsWHepf8K1K29uEmxK+B5O2Q=
Date: Mon, 11 Nov 2024 17:30:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi <lschyi@chromium.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (cros_ec) register thermal sensors to thermal
 framework
Message-ID: <a469852b-4cbd-467c-89de-b1acf6de1402@t-8ch.de>
References: <20241111074904.1059268-1-lschyi@chromium.org>
 <20241111095045.1218986-1-lschyi@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111095045.1218986-1-lschyi@chromium.org>

On 2024-11-11 17:50:30+0800, Sung-Chi wrote:
> From: "Sung-Chi, Li" <lschyi@chromium.org>
> 
> cros_ec hwmon driver probes available thermal sensors when probing the
> driver.  Register these thermal sensors to the thermal framework, such
> that thermal framework can adopt these sensors as well.

The driver also supports fan readings. These could also be wired up as
cooling devices.

> To make cros_ec registrable to thermal framework, the cros_ec dts need
> the corresponding changes:
> 
> &cros_ec {
> 	#thermal-sensor-cells = <1>;
> };

If this is the only thing that is meant to be configured I'm wondering
why the OF variant is needed in the first place.
Why not register a non-OF thermal device?

Please send the next revision also to the maintainers of the THERMAL
subsystem so we can figure out the most correct way forward.

> Change-Id: I29b638427c715cb44391496881fc61ad53abccaf
> Signed-off-by: Sung-Chi, Li <lschyi@chromium.org>
> ---
>  Changes in v2:
>    - Rename `cros_ec_sensor_data` to `cros_ec_hwmon_thermal_zone_data`.
>    - Rename `addr` in struct `cros_ec_hwmon_thermal_zone_data` to `idx`.
>    - Use `cros_ec_hwmon_temp_to_millicelsius` to do value conversion in 
>      `cros_ec_thermal_get_temp` function.
>    - Rename `cros_ec_thermal_get_temp` to `cros_ec_hwmon_thermal_get_temp` to
>      make `cros_ec_hwmon` a prefix.
>    - Use `%pe` in `cros_ec_hwmon_probe_temp_sensors` when printing out
>      `data->tz_dev` if failed register thermal device.
>    - Remove `cros_ec_hwmon_remove`, and the `.remove` value in
>      `cros_ec_hwmon_driver` since there is no need to call
>      `devm_thermal_of_zone_unregister` for clean up.
>    - Revert function signature of `cros_ec_hwmon_probe_temp_sensors` since all
>      needed parameters are presented.
>    - Revert include of `linux/list.h` because no list data structure is used.
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 5514cf780b8b..81e563e0455f 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/thermal.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> @@ -23,6 +24,12 @@ struct cros_ec_hwmon_priv {
>  	u8 usable_fans;
>  };
>  
> +struct cros_ec_hwmon_thermal_zone_data {
> +	struct cros_ec_device *cros_ec;
> +	struct thermal_zone_device *tz_dev;
> +	int idx;
> +};
> +
>  static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
>  {
>  	int ret;
> @@ -185,11 +192,30 @@ static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {
>  	.info = cros_ec_hwmon_info,
>  };
>  
> +static int cros_ec_hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +	struct cros_ec_hwmon_thermal_zone_data *data =
> +		thermal_zone_device_priv(tz);
> +	int ret;
> +	u8 val;
> +
> +	ret = cros_ec_hwmon_read_temp(data->cros_ec, data->idx, &val);
> +	if (ret || cros_ec_hwmon_is_error_temp(temp))
> +		return -ENODATA;
> +	*temp = cros_ec_hwmon_temp_to_millicelsius(val);
> +	return 0;
> +}
> +
> +static const struct thermal_zone_device_ops thermal_ops = {

Symbol still needs namespacing.

> +	.get_temp = cros_ec_hwmon_thermal_get_temp,
> +};
> +
>  static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_hwmon_priv *priv,
>  					     u8 thermal_version)
>  {
>  	struct ec_params_temp_sensor_get_info req = {};
>  	struct ec_response_temp_sensor_get_info resp;
> +	struct cros_ec_hwmon_thermal_zone_data *data;
>  	size_t candidates, i, sensor_name_size;
>  	int ret;
>  	u8 temp;
> @@ -216,6 +242,21 @@ static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_
>  		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%.*s",
>  							    (int)sensor_name_size,
>  							    resp.sensor_name);
> +
> +		data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +		if (!data)
> +			continue;
> +
> +		data->idx = i;
> +		data->cros_ec = priv->cros_ec;
> +		data->tz_dev = devm_thermal_of_zone_register(
> +			priv->cros_ec->dev, i, data, &thermal_ops);

Doesn't this also automatically create new hwmon device off of the
thermal device? That shouldn't happen.

In general I'm not sure how the hwmon and thermal subsystems are meant
to interact. Is one recommended over the other?
Should the driver become a first-class thermal driver and use the
automatic hwmon functionality?

> +		if (IS_ERR_VALUE(data->tz_dev)) {
> +			dev_err(dev,
> +				"failed to register %zu thermal sensor, err = %pe",
> +				i, data->tz_dev);

If !CONFIG_OF || !CONFIG_THERMAL this will always log an error.
EOPNOTSUP should not trigger that logging.

> +			continue;
> +		}
>  	}
>  }
>  
> -- 
> 2.47.0.277.g8800431eea-goog
> 

