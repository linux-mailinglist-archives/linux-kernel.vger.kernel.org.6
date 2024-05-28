Return-Path: <linux-kernel+bounces-191816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FC8D1494
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D4B22973
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A36A33B;
	Tue, 28 May 2024 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwCiDq4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD461FE0;
	Tue, 28 May 2024 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878370; cv=none; b=ppwdbxHlrYIgmPuj6aTAUhQxW/9puy9/HINhsq9HB3ORQB1jM76ei4h781p8HXW8BpfQR6agie8e7SFLZXZF2/G/OJRrLvMGglZd/OkG4s7zHei4be2NpjQRIQtTFdNPsP13p3zvRIZa/hntBXL/8gCaT0VST0ZBdITCB6NM/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878370; c=relaxed/simple;
	bh=nm/GpAhN0oO9Uj7klikih6fTBlHQd89v/Qhoj4sgPko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA5cRN3OFHN68C8ysoSgj9IAy0643EcVc+EqTEmEJ369VNMCWXj/dl9SEFntloPSqcS/sfO1wfw2RQoGQX+xxy9fh+fuKWML0uyF3mdAVu1gdkdSPHUrwbSiuGBBh/nmH6PWERp9JtXuwbIdymzP9sxjdnU079aph7bbVGgut58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwCiDq4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00E3C3277B;
	Tue, 28 May 2024 06:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716878369;
	bh=nm/GpAhN0oO9Uj7klikih6fTBlHQd89v/Qhoj4sgPko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwCiDq4OvzbHujit1i654mMLK11g3PNupDsrG9ue4/ghLgwsINk/OToz8gtoOV5LN
	 XmCtR0yuBSI2zfl6ISn0CNC/L+QMStuUMJKzYb+y5jKaaV5g2ryKFdvP7o7fYSlN3a
	 dvrG+PYo/XguhOFRSJOx+FxDJdGES9imtIFZGJqKhmhFsWxW/HFQBLd72e5I4qQcJb
	 pWTwTMQ2mE0UralUQs2lsCgQZtH+C/T0gTJa47r7wRXY0AREXpl7chd9GVyM9C0Dee
	 y9yNRuHKZ2xoo3t/aewJczGpOXiKmeSYBCU6rbVFcNTo/7EpbpchNelojr1P8lQUkb
	 MNDZCOimYdA7A==
Date: Tue, 28 May 2024 06:39:25 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev,
	Dustin Howett <dustin@howett.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Moritz Fischer <mdf@kernel.org>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v3 2/3] hwmon: add ChromeOS EC driver
Message-ID: <ZlV8HWlsHfoz8QMc@google.com>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
 <20240527-cros_ec-hwmon-v3-2-e5cd5ab5ba37@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527-cros_ec-hwmon-v3-2-e5cd5ab5ba37@weissschuh.net>

On Mon, May 27, 2024 at 10:58:32PM +0200, Thomas Weißschuh wrote:
> diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
[...]
> + *  ChromesOS EC driver for hwmon

s/ChromesOS/ChromeOS/.

> +struct cros_ec_hwmon_priv {
> +	struct cros_ec_device *cros_ec;
> +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> +	u8 usable_fans;
> +};
> +
> +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> +{
> +	u16 data;
> +	int ret;
> +
> +	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data = le16_to_cpu(data);
> +	*speed = data;
> +
> +	if (data == EC_FAN_SPEED_NOT_PRESENT || data == EC_FAN_SPEED_STALLED)
> +		return -EIO;

`data` could be eliminated; use `*speed` instead.

> +static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *val)
> +{
[...]
> +	u16 speed = 0;
> +	u8 temp = 0;

They don't need to initialize.

> +	if (type == hwmon_fan && attr == hwmon_fan_input) {
> +		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> +		if (ret == 0)
> +			*val = speed;
> +	} else if (type == hwmon_fan && attr == hwmon_fan_fault) {
> +		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> +		if (ret == -EIO && speed == EC_FAN_SPEED_STALLED)
> +			ret = 0;
> +		if (ret == 0)
> +			*val = speed == EC_FAN_SPEED_STALLED;
> +	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
> +		ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
> +		if (ret == 0)
> +			*val = kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
> +	} else if (type == hwmon_temp && attr == hwmon_temp_fault) {
> +		ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
> +		if (ret == -EIO && speed == EC_TEMP_SENSOR_ERROR)
> +			ret = 0;
> +		if (ret == 0)
> +			*val = temp == EC_TEMP_SENSOR_ERROR;
> +	}

Refactoring them by switch .. case .. may improve the readability.

