Return-Path: <linux-kernel+bounces-559946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB54A5FB75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4243418844CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617ED269CE6;
	Thu, 13 Mar 2025 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l0B1d5pb"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B12690D1;
	Thu, 13 Mar 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882900; cv=none; b=RtTzUHdaht0OyJ996R1S4sAa+07pS1F14N3jx2uSHAU56NOJ+UC/tafgFI3/tp8MWTpV9rKZWmP1IO4d7EoPWlFml8xUfeKkqI/x2bHtkkC3+NtOUbq+JpsIycf0KhMnJqZlIcPouaNQBW/XJcCNVILCsTg7rJhquYGjmVgL+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882900; c=relaxed/simple;
	bh=pIdrKnu27Vmv3K9OVG1yp+XFNGqgzV025wRS26XTe74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XttMGtQMIzM0CjzuQnc3Uc65vyWjAT15pZUFybx6sCI9F7SUe8oCB9vT25eXKodR3wAKlDleJ4pMMUhTi7iHcOMLTMb7zYI7VSO831YGlH4KEdFsPeQ4NXmXt9X7qLU7WmktLNwS9+/F5UAwvr3w1mIvyMV13Nx6fUjntDYgAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l0B1d5pb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1741882896;
	bh=pIdrKnu27Vmv3K9OVG1yp+XFNGqgzV025wRS26XTe74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0B1d5pb1l+OsAxpemclLqzQUFCVvY9K5DfzM2sJ9LHR4MyeXpkSSmG/PfS09Jtr/
	 fVGku/hSIuWeiHaYNJFe4HdykYe2Xxbe08jjc0cIBAA1EUJUu4yayq+/KKiblwEznY
	 a/e51tDVYDbi/y5+rf1qyXHBEZG3xiergNshzBvo=
Date: Thu, 13 Mar 2025 17:21:35 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (cros_ec) Add setting target fan RPM function
Message-ID: <714be928-a655-4561-98fb-800bcb15cbfb@t-8ch.de>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-1-5c566776f2c4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-1-5c566776f2c4@chromium.org>

On 2025-03-13 12:47:42+0800, Sung-Chi Li wrote:
> Implement the functionality of setting the target fan RPM to ChromeOS
> embedded controller under hwmon framework.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> ---
>  drivers/hwmon/cros_ec_hwmon.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> index 9991c3fa020ac859cbbff29dfb669e53248df885..b2fec0768301f116f49c57b8dbfb042b98a573e1 100644
> --- a/drivers/hwmon/cros_ec_hwmon.c
> +++ b/drivers/hwmon/cros_ec_hwmon.c
> @@ -52,6 +52,26 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index, u16 val)
> +{
> +	struct ec_params_pwm_set_fan_target_rpm_v1 p_v1 = {

The v1 protocol was "only" introduces in 2014.
Could it be possible that devices without that command are still in use?
If so the presence of the command should be probed.

What is the name p_v1 supposed to mean? Call it "req", like other parts
of the driver.

> +		.rpm = val,
> +		.fan_idx = index,
> +	};
> +
> +	return cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_TARGET_RPM, &p_v1, sizeof(p_v1), NULL, 0);

cros_ec_cmd() signals success with an exitcode >= 0, while the hwmon
APIs only expect 0. In this specific case the success value will also
always be zero, as no response is sent by the EC, but for clarity I
prefer to have an explicit check.

> +}
> +
> +static int cros_ec_hwmon_write_fan(struct cros_ec_device *cros_ec, u32 attr, int channel, long rpm)
> +{
> +	switch (attr) {
> +	case hwmon_fan_target:
> +		return cros_ec_hwmon_set_fan_rpm(cros_ec, channel, rpm);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static bool cros_ec_hwmon_is_error_fan(u16 speed)
>  {
>  	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
> @@ -140,6 +160,19 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
>  	return 0;
>  }
>  
> +static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long val)
> +{
> +	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		return cros_ec_hwmon_write_fan(priv->cros_ec, attr, channel, val);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
>  	HWMON_CHANNEL_INFO(fan,
> @@ -179,6 +212,7 @@ static const struct hwmon_ops cros_ec_hwmon_ops = {
>  	.read = cros_ec_hwmon_read,
>  	.read_string = cros_ec_hwmon_read_string,
>  	.is_visible = cros_ec_hwmon_is_visible,
> +	.write = cros_ec_hwmon_write,

Move the .write directly after .read_string.

>  };
>  
>  static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {
> 
> -- 
> 2.49.0.rc0.332.g42c0ae87b1-goog
> 

