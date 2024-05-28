Return-Path: <linux-kernel+bounces-191838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44C8D14F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9540028382C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E271B47;
	Tue, 28 May 2024 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iz0AnPYN"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CD71739;
	Tue, 28 May 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880172; cv=none; b=Ndi2+09nnPzUk+TJZW62rwXqF153RkaWz0hv7zdWs2NpWErJjhN77mCRSh+w1ra2bvwQo6GiQ2mlAU/AZR0fd0N4xfVCAJq9J3HSL7YKGyGKmRXZ5fX4qNrsrDBI46GWHZYaD1667fV7PFJkshCEsnVC3SxghNJO1ewJeKeTE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880172; c=relaxed/simple;
	bh=q03TPGrKREgG3I77Fj4FxDGWhUDCTQ/o2lyTrAG5Q4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgTk+XNFs8xJC09NVK6jHAXSgCyngaWpfuv5Dc0p5nrk6Uk9OcwHs0HLCRRUwR+0cIuGZbPXZh1lo7SFo45Be41qFVGAjJmg2xJILfyh0EX98mAl1xfy62FaQDq5mnXiJZeOXFnPUooScjvnJPWhCaOs3VVv9PchR8yztnhwSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iz0AnPYN; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716880169;
	bh=q03TPGrKREgG3I77Fj4FxDGWhUDCTQ/o2lyTrAG5Q4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iz0AnPYNL2dWrD9rl7aogfeXOc/OglvopqIlnsvuBUTA91TiQNbpmsu79hQqRdbFS
	 QXNTHqIMAkgeLNUXmESZ7MwaMasnTX0MqKUtQTZFLiVyKh+rQOLAqQtuD0t9UVbF7C
	 zbkuQBFnnpo4xWkX+kPCxQoQ0CcUll67RoyI9TvE=
Date: Tue, 28 May 2024 09:09:28 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Subject: Re: [PATCH v3 2/3] hwmon: add ChromeOS EC driver
Message-ID: <3025747e-658a-47fa-8799-86e9e974b796@t-8ch.de>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
 <20240527-cros_ec-hwmon-v3-2-e5cd5ab5ba37@weissschuh.net>
 <ZlV8HWlsHfoz8QMc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZlV8HWlsHfoz8QMc@google.com>

On 2024-05-28 06:39:25+0000, Tzung-Bi Shih wrote:
> On Mon, May 27, 2024 at 10:58:32PM +0200, Thomas Weißschuh wrote:
> > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> [...]
> > + *  ChromesOS EC driver for hwmon
> 
> s/ChromesOS/ChromeOS/.

Ack. Copy-and-paste...

> > +struct cros_ec_hwmon_priv {
> > +	struct cros_ec_device *cros_ec;
> > +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> > +	u8 usable_fans;
> > +};
> > +
> > +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> > +{
> > +	u16 data;
> > +	int ret;
> > +
> > +	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data = le16_to_cpu(data);
> > +	*speed = data;
> > +
> > +	if (data == EC_FAN_SPEED_NOT_PRESENT || data == EC_FAN_SPEED_STALLED)
> > +		return -EIO;
> 
> `data` could be eliminated; use `*speed` instead.

Then the le16 value would need to be written directly to the out
parameter. The current usage relies on *speed (sometimes) being set even
if ret != 0.

(See next response block)

> 
> > +static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > +			      u32 attr, int channel, long *val)
> > +{
> [...]
> > +	u16 speed = 0;
> > +	u8 temp = 0;
> 
> They don't need to initialize.

They need to.

The logic

if (ret == -EIO && speed == EC_FAN_SPEED_STALLED)
	ret = 0;

relies on -EIO and a write to speed from cros_ec_hwmon_read_fan_speed().

But if cros_ec_cmd_readmem() already returns -EIO, then speed would be
uninitialized.

I'll see if I can make this clearer somehow.

> 
> > +	if (type == hwmon_fan && attr == hwmon_fan_input) {
> > +		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> > +		if (ret == 0)
> > +			*val = speed;
> > +	} else if (type == hwmon_fan && attr == hwmon_fan_fault) {
> > +		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> > +		if (ret == -EIO && speed == EC_FAN_SPEED_STALLED)
> > +			ret = 0;
> > +		if (ret == 0)
> > +			*val = speed == EC_FAN_SPEED_STALLED;
> > +	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
> > +		ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
> > +		if (ret == 0)
> > +			*val = kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
> > +	} else if (type == hwmon_temp && attr == hwmon_temp_fault) {
> > +		ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
> > +		if (ret == -EIO && speed == EC_TEMP_SENSOR_ERROR)
> > +			ret = 0;
> > +		if (ret == 0)
> > +			*val = temp == EC_TEMP_SENSOR_ERROR;
> > +	}
> 
> Refactoring them by switch .. case .. may improve the readability.

It would introduce another level of indentation, which I tried to avoid.
But some vertical whitespace would be useful indeed.

