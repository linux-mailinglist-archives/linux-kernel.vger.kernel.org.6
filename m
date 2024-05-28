Return-Path: <linux-kernel+bounces-192733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB93C8D2168
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA191F2517D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795A417279C;
	Tue, 28 May 2024 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="D4wORzPO"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF816D9D2;
	Tue, 28 May 2024 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912964; cv=none; b=NbbRW/M/jOaD/e04SHT6uIsOkgdqgKihfb2pyfWhW7wo8qYWCQhL3WemdGJZpqXLFSfHecxOA5KQ428P/K+FdVco0IKeZjTKZl7yuL6q0cuRTIK02POcOMYYZRfaVHsZZyVyq1ynT6nrq5t8z4D3/8E1JBVMfB6K9fQDA4w6jBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912964; c=relaxed/simple;
	bh=l6x4ez58HU9UJM5Ps7D89/4CNRdh7IYjsMDwe693JlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2e8La/7t8uxHYT6Uh0RupVDHOqNgE6i4wl4mobqmFJ/kiGA3mL09d20xdW+kDuJEKsg8lXO3+u0YX1H5Tc1WYmpHbqy5nMpf6LOCvChbwXch0JEcPdlEQ2kXPXyCqOMjfxWLGL0vre97WSdZak8y2bXCKUZfQJjzm4Lwj9QJec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=D4wORzPO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716912956;
	bh=l6x4ez58HU9UJM5Ps7D89/4CNRdh7IYjsMDwe693JlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4wORzPO/dcNOsesBD/hol+eQeSr63q3p1WKENypCodZkC7huLrBXL1LwoSLZFbP8
	 X13x5+BT2jwmBPLL8hPhRZhJKBf047O02c5z46EaZ8tmZDjHkQj+wVLFS2Fm6QW+m3
	 w1k2KYckDr2N4+gVVZbDhHrTAdCA1o89KA4vF/2k=
Date: Tue, 28 May 2024 18:15:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Horvath <s.horvath@outlook.com.au>, 
	Jean Delvare <jdelvare@suse.com>, Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Dustin Howett <dustin@howett.net>, 
	Mario Limonciello <mario.limonciello@amd.com>, Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
Message-ID: <b8072b36-688f-41b8-8b32-40fc4fa4d148@t-8ch.de>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
 <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
 <SY4P282MB30635BA1D4087113E79921B5C5F52@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <9cf224dd-51eb-4608-abcf-06f337d08178@t-8ch.de>
 <SY4P282MB306325BB023A95198F25A21DC5F12@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <c9b110eb-ff0e-41f2-9492-8a5d8c3c01d0@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9b110eb-ff0e-41f2-9492-8a5d8c3c01d0@roeck-us.net>

On 2024-05-28 08:50:49+0000, Guenter Roeck wrote:
> On 5/27/24 17:15, Stephen Horvath wrote:
> > On 28/5/24 05:24, Thomas Weißschuh wrote:
> > > On 2024-05-25 09:13:09+0000, Stephen Horvath wrote:
> > > > I was the one to implement fan monitoring/control into Dustin's driver, and
> > > > just had a quick comment for your driver:
> > > > 
> > > > On 8/5/24 02:29, Thomas Weißschuh wrote:
> > > > > The ChromeOS Embedded Controller exposes fan speed and temperature
> > > > > readings.
> > > > > Expose this data through the hwmon subsystem.
> > > > > 
> > > > > The driver is designed to be probed via the cros_ec mfd device.
> > > > > 
> > > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > > ---
> > > > >    Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
> > > > >    Documentation/hwmon/index.rst         |   1 +
> > > > >    MAINTAINERS                           |   8 +
> > > > >    drivers/hwmon/Kconfig                 |  11 ++
> > > > >    drivers/hwmon/Makefile                |   1 +
> > > > >    drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
> > > > >    6 files changed, 316 insertions(+)
> > > > > 
> > > 
> > > <snip>
> > > 
> > > > > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> > > > > new file mode 100644
> > > > > index 000000000000..d59d39df2ac4
> > > > > --- /dev/null
> > > > > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > > > > @@ -0,0 +1,269 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + *  ChromesOS EC driver for hwmon
> > > > > + *
> > > > > + *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
> > > > > + */
> > > > > +
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/hwmon.h>
> > > > > +#include <linux/kernel.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/platform_data/cros_ec_commands.h>
> > > > > +#include <linux/platform_data/cros_ec_proto.h>
> > > > > +#include <linux/units.h>
> > > > > +
> > > > > +#define DRV_NAME    "cros-ec-hwmon"
> > > > > +
> > > > > +struct cros_ec_hwmon_priv {
> > > > > +    struct cros_ec_device *cros_ec;
> > > > > +    u8 thermal_version;
> > > > > +    const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
> > > > > +};
> > > > > +
> > > > > +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
> > > > > +{
> > > > > +    u16 data;
> > > > > +    int ret;
> > > > > +
> > > > > +    ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
> > > > > +    if (ret < 0)
> > > > > +        return ret;
> > > > > +
> > > > > +    data = le16_to_cpu(data);
> > > > > +
> > > > > +    if (data == EC_FAN_SPEED_NOT_PRESENT)
> > > > > +        return -ENODEV;
> > > > > +
> > > > 
> > > > Don't forget it can also return `EC_FAN_SPEED_STALLED`.
> > > 
> > > Thanks for the hint. I'll need to think about how to handle this better.
> > > 
> > > > Like Guenter, I also don't like returning `-ENODEV`, but I don't have a
> > > > problem with checking for `EC_FAN_SPEED_NOT_PRESENT` in case it was removed
> > > > since init or something.
> > > 
> 
> That won't happen. Chromebooks are not servers, where one might be able to
> replace a fan tray while the system is running.

In one of my testruns this actually happened.
When running on battery, one specific of the CPU sensors sporadically
returned EC_FAN_SPEED_NOT_PRESENT.

> > > Ok.
> > > 
> > > > My approach was to return the speed as `0`, since the fan probably isn't
> > > > spinning, but set HWMON_F_FAULT for `EC_FAN_SPEED_NOT_PRESENT` and
> > > > HWMON_F_ALARM for `EC_FAN_SPEED_STALLED`.
> > > > No idea if this is correct though.
> > > 
> > > I'm not a fan of returning a speed of 0 in case of errors.
> > > Rather -EIO which can't be mistaken.
> > > Maybe -EIO for both EC_FAN_SPEED_NOT_PRESENT (which should never happen)
> > > and also for EC_FAN_SPEED_STALLED.
> > 
> > Yeah, that's pretty reasonable.
> > 
> 
> -EIO is an i/o error. I have trouble reconciling that with
> EC_FAN_SPEED_NOT_PRESENT or EC_FAN_SPEED_STALLED.
> 
> Looking into the EC source code [1], I see:
> 
> EC_FAN_SPEED_NOT_PRESENT means that the fan is not present.
> That should return -ENODEV in the above code, but only for
> the purpose of making the attribute invisible.
> 
> EC_FAN_SPEED_STALLED means exactly that, i.e., that the fan
> is present but not turning. The EC code does not expect that
> to happen and generates a thermal event in case it does.
> Given that, it does make sense to set the fault flag.
> The actual fan speed value should then be reported as 0 or
> possibly -ENODATA. It should _not_ generate any other error
> because that would trip up the "sensors" command for no
> good reason.

Ack.

Currently I have the following logic (for both fans and temp):

if NOT_PRESENT during probing:
  make the attribute invisible.

if any error during runtime (including NOT_PRESENT):
  return -ENODATA and a FAULT

This should also handle the sporadic NOT_PRESENT failures.

What do you think?

Is there any other feedback to this revision or should I send the next?


Thanks,
Thomas

