Return-Path: <linux-kernel+bounces-172236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FE38BEF46
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD08281E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4F14B969;
	Tue,  7 May 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="X2XtwB6V"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2F71B5C;
	Tue,  7 May 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715119153; cv=none; b=re5aWz6E6u0pLsu1GaAwjguAJ3YeUSg7dletwOvMc1b1Yj/gVZo5DmYd5YXojjhqH/ARnUwG0IOYH+uMKh5aOZ7BKXl5nSIuzdS/SUoVN+O7qPxiwNXm39ZyrRZ/1vBC+nwBYKWGN3dt+P1M8CAtTnqajT+ISrQ1JPFrul/FD40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715119153; c=relaxed/simple;
	bh=Hndse8TIgtj0SVyXhNB2unXaLH6iIj1I+ZHKI79dvh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+5GfxE/cgSAuGNPIMyyUTdUxfTlWiz6qrqQQtrt9pcuc2ZIn+GVwCw98YZznpSR34dWEB0HPTxziXXHTBAe1mTwQo1hSkQaTPPg70HKY2gQjO/5ABcMFr6TbFKwETNCBVNyT11S5rls6KLYJa/GClnfKfzE9PA0Wq2W2hC3JSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=X2XtwB6V; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715119140;
	bh=Hndse8TIgtj0SVyXhNB2unXaLH6iIj1I+ZHKI79dvh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2XtwB6Vz/8WQ3wIpjcPEwz6rr+w6sf1E57nCbEnVX8QdQGE6VLNOY7ekbhaVKx60
	 tPcFxrJZno2i+VxoT8qqd3qnAPh05WVMmRviUh80+j9ijcAyPpohgDGAiEzdUUBDE1
	 vZBN0ELoaUFRfEGgHM/P/q7EC5rbymkuZUtX+M+g=
Date: Tue, 7 May 2024 23:59:00 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <groeck@google.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
Message-ID: <572e968e-f1dc-4243-a895-9bc01b292a01@t-8ch.de>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
 <CABXOdTcabi6ab9FnfvR+3-q0sKQuk_sewD8ZT=80j5Ou+bHeKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTcabi6ab9FnfvR+3-q0sKQuk_sewD8ZT=80j5Ou+bHeKQ@mail.gmail.com>

Hi Guenter,

thanks for your quick responses!

On 2024-05-07 14:55:44+0000, Guenter Roeck wrote:
> On Tue, May 7, 2024 at 10:29 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> >
> > The ChromeOS Embedded Controller exposes fan speed and temperature
> > readings.
> > Expose this data through the hwmon subsystem.
> >
> > The driver is designed to be probed via the cros_ec mfd device.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
> >  Documentation/hwmon/index.rst         |   1 +
> >  MAINTAINERS                           |   8 +
> >  drivers/hwmon/Kconfig                 |  11 ++
> >  drivers/hwmon/Makefile                |   1 +
> >  drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
> >  6 files changed, 316 insertions(+)
> >

[..]

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
> > +#define DRV_NAME       "cros-ec-hwmon"
> > +
> > +struct cros_ec_hwmon_priv {
> > +       struct cros_ec_device *cros_ec;
> > +       u8 thermal_version;
> > +       const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> > +};
> > +
> > +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> > +{
> > +       u16 data;
> > +       int ret;
> > +
> > +       ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       data = le16_to_cpu(data);
> > +
> > +       if (data == EC_FAN_SPEED_NOT_PRESENT)
> > +               return -ENODEV;
> > +
> I don't have time for a full review right now, but this looks wrong:
> If a fan is not present, its sysfs attribute should not be instantiated.
> Returning -ENODEV here is most definitely wrong.

This is also called from cros_ec_hwmon_is_visible(),

I think the special value should be handled in the read function
anyways, although it should never happen after probing.

Otherwise the magic, nonsensical value will be shown to the user as
sensor reading.

The sysfs hiding works.
Out of 4 fans and 24 temp sensors known by the driver,
on my device only 1 fan and 4 temp sensors exist and are probed.

If you prefer another error code please let me know.

Please let me know if I got something wrong.

> > +       *speed = data;
> > +       return 0;
> > +}
> > +
> > +static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 thermal_version,
> > +                                  u8 index, u8 *data)
> > +{
> > +       unsigned int offset;
> > +       int ret;
> > +
> > +       if (index < EC_TEMP_SENSOR_ENTRIES)
> > +               offset = EC_MEMMAP_TEMP_SENSOR + index;
> > +       else
> > +               offset = EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENSOR_ENTRIES;
> > +
> > +       ret = cros_ec->cmd_readmem(cros_ec, offset, 1, data);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (*data == EC_TEMP_SENSOR_NOT_PRESENT ||
> > +           *data == EC_TEMP_SENSOR_ERROR ||
> > +           *data == EC_TEMP_SENSOR_NOT_POWERED ||
> > +           *data == EC_TEMP_SENSOR_NOT_CALIBRATED)
> > +               return -ENODEV;
> > +
> Same as above.

cros_ec_hwmon_probe()
  cros_ec_hwmon_probe_temp_sensors()
    cros_ec_hwmon_read_temp()

if _read_temp() fails here, the sensor name remains NULL and
is_visible() will hide that sensor.
      
As for the general reasoning, see above.

[..]


Thanks,
Thomas

