Return-Path: <linux-kernel+bounces-336886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4001098421C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A3C1C22C20
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77C15666D;
	Tue, 24 Sep 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="K3ByFcJD"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9371A155743
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170202; cv=none; b=K5FAVAL8NaiqsQILFv3exjaI3FKWHiwYnhk4bfN1Q1aqIrQFgoPMbu+dMkJHUoajsAcbtBmCZkzZcrFg7qgBeL2lyQDNw8QMHFlM6nbIs/T0OkyvuBScqeo3fqx8uW9ZDfA2kqSPEJkI+nxmVb+XkX3J/w+p+9xjyg1wuhCFwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170202; c=relaxed/simple;
	bh=wpNjdKQaKx8tNenN2uCAMN9pAjRg9DgHMqGVAJsCkaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJhsM469/cQvxjJEd5oK15OUMBZZJRptUW04nmgBUuw9GRzE5jvUQ+rxeD+QCxUgb40/a98Xfy9baoYOBUKcPPyJ4s27wxZw8QQLJc7Xa7WJOvvJM+70ztXrZqyZNc5lL/2Hh2hGSKo7VuMQAByFA9nz+Jq9jEiMLjFisBaFyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=K3ByFcJD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso4296560a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727170200; x=1727775000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tkJvvTW+sDB+jA/+zeuc8QYof4EepbYZ4z6pWcmkal0=;
        b=K3ByFcJDhSryO25DbdSRYE715T7lFTjuZ5wqFT8Pl/WcRBmv/PfIoZRC/fWCSqoPXt
         cYdPcxth+KO4NqvP3+pojTAQatQ0OQGsYosDxWlBsPfTqSEWEFWvks3eIkhpC2s/KuLK
         Hovjr7cUkEgQnnyLRLeBl9W8/eAwMIl71LZj8VNeHGqyFGUub48SZMi2qqZYWsOg27Ds
         gfpis/YgR5s8kORU3kLgwEZpbOXn99z2YTsilxYe+OkhdkO5OmOz3W3vw7CsDeF5+OYP
         d+QcDZJV0YJRqm2D9zNI4gU+0eFm4nVStp4VB3ekhYtGjqEHWSP1yqabUGoOv/qOz6+P
         n8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170200; x=1727775000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkJvvTW+sDB+jA/+zeuc8QYof4EepbYZ4z6pWcmkal0=;
        b=fn/FKrwMM4aPjEZblSf9e6gcJSRLc2JA+wXE8ZOzYnDb7dGP/pWz6gFfv8cMnOuTE9
         /sF7JHhlPjJntQvst3e2eazSQqZP7vaYSY9TX708HEbyl4Ol3XyPJrbqX9RmBl34meAH
         CafN6ZpGFlyeCskrRDqjev4/rWgquotuN6OmIv4MwwqPHoyy6uY1/XRLfyieYyNXa1Pm
         6lYuKZWGya6D5K+G603y7uKI4b2ASEcTZ16Bfek4lqjZJYHhru0Qmf7rHRcCRbRDbRK8
         sEXeoB6hUzo9Iu6Xrb9XEA6/oyyZQtAYyQcYrDNtAMPmRQE7UTJl1wrxh31O1EUHjowU
         ucOg==
X-Forwarded-Encrypted: i=1; AJvYcCX2FcCZYh9+YHteU2rWj4maia4t9O735kEHNsVGt4TozIg+ETbE46QcVoOLnuv/s/tLurOfgSxO5NWtX2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqodQ83dYmbmnGe8GLkN9HGwAKjF6O5DO4Jdr8upSGuajQUJv
	CRhUOxjHMQ43brjNoIdBHMmLGdkmRzrHjxgiZJUr47sPrGLp8HSKwcCs/aoXjKb8KwkyqyjiUYS
	QgWrb9SIN1tzqXpqJJxMRUF5YJ65a1a1F5z60Ks6BcU8zzPkxVBbrmQ==
X-Google-Smtp-Source: AGHT+IEc1cYYLo7/FgIuLzY7ekLVjl8PL6R1iVUBBYv/Is+9e1Bu+QZWKpmVNc+VCqggPvmguFvOax/gl0r3beUp+Xs=
X-Received: by 2002:a17:90a:fa8f:b0:2d8:53f8:77c0 with SMTP id
 98e67ed59e1d1-2dd80c05452mr19791103a91.7.1727170199590; Tue, 24 Sep 2024
 02:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628115451.4169902-1-naresh.solanki@9elements.com> <349543e5-21b2-4725-9b33-1fcb4ae124f6@roeck-us.net>
In-Reply-To: <349543e5-21b2-4725-9b33-1fcb4ae124f6@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 24 Sep 2024 14:59:49 +0530
Message-ID: <CABqG17hpqFG-PeyENXnGn9k7V2goBP+k6BtSURoMM7DgXtxWmA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max6639) : Add DT support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Sorry for the late reply,

On Fri, 28 Jun 2024 at 20:30, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 6/28/24 04:54, Naresh Solanki wrote:
> > Remove platform data & add devicetree support.
> >
>
> Unless I am missing something, this doesn't just add devicetree support,
> it actually _mandates_ devicetree support. There are no defaults.
> That is not acceptable.
I agree with you. It is best to have some defaults & then overwrite
based on DT properties.
But in that case we would have to assume that all fans are enabled
irrespective of their hardware connections in the schematics(example
fan_enable).

I'm not sure if that is fine. But if you feel that is alright then
I'll rewrite the driver to assume
everything is enabled with default values.
Later based on DT properties, we just overwrite defaults to align with hardware.


For commit message I'll update it as :
hwmon: (max6639) : Configure based on DT property
Remove platform data & initialize driver with defaults & overwrite based on
DT properties.
>
> More comments inline.
>
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >   drivers/hwmon/max6639.c               | 99 ++++++++++++++++++++-------
> >   include/linux/platform_data/max6639.h | 15 ----
> >   2 files changed, 73 insertions(+), 41 deletions(-)
> >   delete mode 100644 include/linux/platform_data/max6639.h
> >
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index f54720d3d2ce..9ae7aecb0737 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -19,7 +19,6 @@
> >   #include <linux/hwmon-sysfs.h>
> >   #include <linux/err.h>
> >   #include <linux/mutex.h>
> > -#include <linux/platform_data/max6639.h>
> >   #include <linux/regmap.h>
> >   #include <linux/util_macros.h>
> >
> > @@ -81,6 +80,7 @@ struct max6639_data {
> >       /* Register values initialized only once */
> >       u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
> >       u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> > +     bool fan_enable[MAX6639_NUM_CHANNELS];
> >
> >       /* Optional regulator for FAN supply */
> >       struct regulator *reg;
> > @@ -276,6 +276,11 @@ static int max6639_write_fan(struct device *dev, u32 attr, int channel,
> >
> >   static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
> >   {
> > +     struct max6639_data *data = (struct max6639_data *)_data;
> > +
> > +     if (!data->fan_enable[channel])
> > +             return 0;
> > +
> >       switch (attr) {
> >       case hwmon_fan_input:
> >       case hwmon_fan_fault:
> > @@ -372,6 +377,11 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
> >
> >   static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
> >   {
> > +     struct max6639_data *data = (struct max6639_data *)_data;
> > +
> > +     if (!data->fan_enable[channel])
> > +             return 0;
> > +
> >       switch (attr) {
> >       case hwmon_pwm_input:
> >       case hwmon_pwm_freq:
> > @@ -544,43 +554,85 @@ static int rpm_range_to_reg(int range)
> >       int i;
> >
> >       for (i = 0; i < ARRAY_SIZE(rpm_ranges); i++) {
> > -             if (rpm_ranges[i] == range)
> > +             if (range <= rpm_ranges[i])
>
> What does this change have to do with adding devicetree support,
> why is it done, and what is its impact ?
>
> So far the assumption was that only valid values would be accepted by
> the function, returning a default if there was no match. The incoming
> data is from devicetree, where the range should be well defined and
> accurate. With that in mind, I don't see the point of accepting values
> outside the supported ranges.
>
> Flexible data makes sense for sysfs attributes, where we can not
> expect users to know acceptable values. For those, it is acceptable
> and even desirable to find a closest match. However, that does not apply
> to data obtained from devicetree.
Agree. Will remove this change.
>
> >                       return i;
> >       }
> >
> >       return 1; /* default: 4000 RPM */
> >   }
> >
> > +static int max6639_probe_child_from_dt(struct i2c_client *client,
> > +                                    struct device_node *child,
> > +                                    struct max6639_data *data)
> > +
> > +{
> > +     struct device *dev = &client->dev;
> > +     u32 i, val;
> > +     int err;
> > +
> > +     err = of_property_read_u32(child, "reg", &i);
> > +     if (err) {
> > +             dev_err(dev, "missing reg property of %pOFn\n", child);
> > +             return err;
> > +     }
> > +
> > +     if (i > 1) {
> > +             dev_err(dev, "Invalid fan index reg %d\n", i);
> > +             return -EINVAL;
> > +     }
> > +
> > +     data->fan_enable[i] = true;
> > +
> > +     err = of_property_read_u32(child, "pulses-per-revolution", &val);
> > +
> > +     if (!err) {
> > +             if (val < 0 || val > 5) {
>
> Accepting 0 seems wrong. Also, val is u32 and will never be < 0.
Ack.
Will make variable 'i' as int.
Also will update if check with:
if (val < 1 || val > 5) {
>
> > +                     dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
> > +                     return -EINVAL;
> > +             }
> > +             data->ppr[i] = val;
> > +     }
> > +
> > +     err = of_property_read_u32(child, "max-rpm", &val);
> > +
> > +     if (!err)
> > +             data->rpm_range[i] = rpm_range_to_reg(val);
> > +
> > +     return 0;
> > +}
> > +
> >   static int max6639_init_client(struct i2c_client *client,
> >                              struct max6639_data *data)
> >   {
> > -     struct max6639_platform_data *max6639_info =
> > -             dev_get_platdata(&client->dev);
> > -     int i;
> > -     int rpm_range = 1; /* default: 4000 RPM */
> > -     int err, ppr;
> > +     struct device *dev = &client->dev;
> > +     const struct device_node *np = dev->of_node;
> > +     struct device_node *child;
> > +     int i, err;
> >
> >       /* Reset chip to default values, see below for GCONFIG setup */
> >       err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> >       if (err)
> >               return err;
> >
> > -     /* Fans pulse per revolution is 2 by default */
> > -     if (max6639_info && max6639_info->ppr > 0 &&
> > -                     max6639_info->ppr < 5)
> > -             ppr = max6639_info->ppr;
> > -     else
> > -             ppr = 2;
> > -
> > -     data->ppr[0] = ppr;
> > -     data->ppr[1] = ppr;
>
> As mentioned above, this may work for your use case, but it won't work
> for existing users of this driver.
Somewhere I was with the assumption that there is no active use of the driver
as there is no reference to this driver.
That is why I felt these changes will be good.
i.e., DT property would indicate if Fan0 or Fan1 should be enabled or not
instead of assuming that they are always enabled.

I would need your input here to proceed further.

Regards,
Naresh

>
> > +     for_each_child_of_node(np, child) {
> > +             if (strcmp(child->name, "fan"))
> > +                     continue;
> >
> > -     if (max6639_info)
> > -             rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> > -     data->rpm_range[0] = rpm_range;
> > -     data->rpm_range[1] = rpm_range;
> > +             err = max6639_probe_child_from_dt(client, child, data);
> > +             if (err) {
> > +                     of_node_put(child);
> > +                     return err;
> > +             }
> > +     }
> >
> >       for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
> > +             if (!data->fan_enable[i])
> > +                     err = regmap_set_bits(data->regmap, MAX6639_REG_OUTPUT_MASK, BIT(1 - i));
> > +             else
> > +                     err = regmap_clear_bits(data->regmap, MAX6639_REG_OUTPUT_MASK, BIT(1 - i));
> > +             if (err)
> > +                     return err;
> > +
> >               /* Set Fan pulse per revolution */
> >               err = max6639_set_ppr(data, i, data->ppr[i]);
> >               if (err)
> > @@ -593,12 +645,7 @@ static int max6639_init_client(struct i2c_client *client,
> >                       return err;
> >
> >               /* Fans PWM polarity high by default */
> > -             if (max6639_info) {
> > -                     if (max6639_info->pwm_polarity == 0)
> > -                             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> > -                     else
> > -                             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> > -             }
> > +             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> >               if (err)
> >                       return err;
> >
> > diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
> > deleted file mode 100644
> > index 65bfdb4fdc15..000000000000
> > --- a/include/linux/platform_data/max6639.h
> > +++ /dev/null
> > @@ -1,15 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _LINUX_MAX6639_H
> > -#define _LINUX_MAX6639_H
> > -
> > -#include <linux/types.h>
> > -
> > -/* platform data for the MAX6639 temperature sensor and fan control */
> > -
> > -struct max6639_platform_data {
> > -     bool pwm_polarity;      /* Polarity low (0) or high (1, default) */
> > -     int ppr;                /* Pulses per rotation 1..4 (default == 2) */
> > -     int rpm_range;          /* 2000, 4000 (default), 8000 or 16000 */
> > -};
> > -
> > -#endif /* _LINUX_MAX6639_H */
> >
> > base-commit: 52c1e818d66bfed276bd371f9e7947be4055af87
>

