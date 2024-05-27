Return-Path: <linux-kernel+bounces-191368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7798D0CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7C01C21077
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 19:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354251607A5;
	Mon, 27 May 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="erhcU8xc"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632C3168C4;
	Mon, 27 May 2024 19:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837854; cv=none; b=GNqhckEQAOYkemCSPPssoEsvrQCpoTsu35DEB2N9uEtl6RRGLNU/oPPxQ/AB1X3jK5vJOd9bWu9IexexkRdlpvoyexiEiHldwwZPmujgZib1sPwhE/+WG2p7I3AvgTX/S94bX5UnK4+xtnOF9kGWEOTXl6hT2SSmMGbhqfzKYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837854; c=relaxed/simple;
	bh=1AYlBAqGh7pyXd2PfPvcQ+zPsx8akvGVdpbKbEb3WhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9kyW8S0LckUSpxYaEEtntYXQt5Nb8szOFWsnI0pJoD8PTTugHkbOxCMmNkko1osWcmx4dkRr7fi+HUFgAR50DJF4kQlBmyT3JbsSBmykS5J20HPGJHdXG1c0BMgCFt2wBQStYHzqAhR0mr8eXx8LH/MSfXAdpASIO6SRAIGSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=erhcU8xc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716837844;
	bh=1AYlBAqGh7pyXd2PfPvcQ+zPsx8akvGVdpbKbEb3WhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erhcU8xcTXBvLNHDveHYYQeXF3gXskdNyLRM8056BO0fY8Pqc64b1OofeHwV2Ua21
	 J1sDiOvO1TELsFkRLxEUZCt1tvBcrEXFcK9Tc+oy+bTFIBu+s/9Fd6Ipuz5Ml6dJlf
	 FNCCGr8twKdmSWywWiIbakE0EBsXqSICvlMfOgD8=
Date: Mon, 27 May 2024 21:24:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
Message-ID: <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
 <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>

Hi Stephen,

On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
> I was the one to implement fan monitoring/control into Dustin's driver, and
> just had a quick comment for your driver:
> 
> On 8/5/24 02:29, Thomas Weißschuh wrote:
> > The ChromeOS Embedded Controller exposes fan speed and temperature
> > readings.
> > Expose this data through the hwmon subsystem.
> > 
> > The driver is designed to be probed via the cros_ec mfd device.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
> >   Documentation/hwmon/index.rst         |   1 +
> >   MAINTAINERS                           |   8 +
> >   drivers/hwmon/Kconfig                 |  11 ++
> >   drivers/hwmon/Makefile                |   1 +
> >   drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
> >   6 files changed, 316 insertions(+)
> > 

<snip>

> > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> > new file mode 100644
> > index 000000000000..d59d39df2ac4
> > --- /dev/null
> > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > @@ -0,0 +1,269 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  ChromesOS EC driver for hwmon
> > + *
> > + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/units.h>
> > +
> > +#define DRV_NAME	"cros-ec-hwmon"
> > +
> > +struct cros_ec_hwmon_priv {
> > +	struct cros_ec_device *cros_ec;
> > +	u8 thermal_version;
> > +	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> > +};
> > +
> > +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> > +{
> > +	u16 data;
> > +	int ret;
> > +
> > +	ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	data = le16_to_cpu(data);
> > +
> > +	if (data == EC_FAN_SPEED_NOT_PRESENT)
> > +		return -ENODEV;
> > +
> 
> Don't forget it can also return `EC_FAN_SPEED_STALLED`.

Thanks for the hint. I'll need to think about how to handle this better.

> Like Guenter, I also don't like returning `-ENODEV`, but I don't have a
> problem with checking for `EC_FAN_SPEED_NOT_PRESENT` in case it was removed
> since init or something.

Ok.

> My approach was to return the speed as `0`, since the fan probably isn't
> spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and
> HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
> No idea if this is correct though.

I'm not a fan of returning a speed of 0 in case of errors.
Rather -EIO which can't be mistaken.
Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which should never happen)
and also for EC_FAN_SPEED_STALLED.
And EC_FAN_SPEED_STALLED also sets HWMON_F_FAULT.
HWMON_F_ALARM doesn't seem right to me.

But if Guenter has a preference, that will do, too.

> 
> > +	*speed = data;
> > +	return 0;
> > +}
> > +

<snip>

> But feel free to ignore me if I'm completly wrong about this, since I really
> don't have much experience with kernel dev.

Thanks for your feedback!

Would you mind if I Cc you on further revisions?


Thomas

