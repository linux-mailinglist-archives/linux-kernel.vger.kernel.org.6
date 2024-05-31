Return-Path: <linux-kernel+bounces-196617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6F8D5EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11921F21D52
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D05138485;
	Fri, 31 May 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="YfuD/Re/"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA11422A5
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148738; cv=none; b=euFaMWhyvC+9BBBQTaWlOkYTd5y1aD686UtQWaEs8ODBlzCIaonmtiJJ8w+qWgbMttaseAOgvmnjhTMJdsPDtNclbEDxCqzrAKBTOPdWkRuOLtB0ahPN7IfP6eaoA1/ly0CaHWTo1oI8JX79sed+/h79lGrt8Vx4hT5UVvbMnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148738; c=relaxed/simple;
	bh=gglhP0KUp/hrtR41q4+JznBE+O1+Dne2Im1JUdwQOuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nf3cnDFFeBDcfZz0HpHfcdoWipJrtDgg84twjUtCgIiWmPFpDlnLb8R0togv49yEH3N8P4m6f7iM4CCD9dFwv6SijAZxHNdWtcEgZVSO5DKMO9Fl21lfgrxHxyK5/YBfogq8+mBUQs987O4L63gpigtKDEXrJeCGR3zMtNN1o4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=YfuD/Re/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c1b9152848so989570a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1717148735; x=1717753535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P4q3wXKgGlVFYx8UeYRvyW+EbjNqReq1AkP1xmel5MY=;
        b=YfuD/Re//okTJvYzmw+8vepdOf7vh9XF6vCWyZLEHBULadOhXSYYkPrzLDJ26Kquly
         LAp1xtWATr+EIEFn2h0GYjLuLrqbSkBNK3Ma/l+FKOshjIWRda+W0vYB0y9NwlXcKD1O
         9gBmJWip1bIVL7ZWhmS7yxsUiCRfpH6kNhAaHNPe/nEtYAq2FF4tPWVEgXzBdP2g3K9k
         VC2P+8YjBjlaH63e6NCaAbiYfcFTbfWRIl6VTnb35kcQdO/f2Qpd18zMCgFgcZ798f/5
         DirD+H75TA0veK1nWCg5ICFpCmpvIvbsAhnbz4qRW4s3mMYOi5i4njiCVgARyO81MEOg
         bHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717148735; x=1717753535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4q3wXKgGlVFYx8UeYRvyW+EbjNqReq1AkP1xmel5MY=;
        b=p7gRgMConLdtvR643Pf541hgs8T6j1vqJNYAx9CWIMvpzh6kgM7ictxQB8rOGL/Xjz
         xTiPEQ04hi/BE2Lx7yAjDTi/ZwM5fjd6Su42WaXsTXeLjsS6wSu2DacIgL511viZrBVx
         dsDE61xoKo3dNWYsji4jCd8beoMhURbvxMkfdKT4mFUQDC5Chw8skHmHHuO3mLyq+gGf
         i5wLIKggLwPPQnS+TG+7VXpvhYNlConj1RyOSvyDMDqkeUanQVY+6kaE5iN/EOEPhtu4
         7psrGkY0XO1YQbgAGm9c3OdOSEkPKhOfmFZ21sWlGFdLRJiIIMLrTvTt9jPPc87TXY/n
         hc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWG8bydLydVFQbXmsaDdoGd/5AlAmBr7Njl8JDE9dzJkb+B52dbNGIkU36I/2AD7HIcowUzq4n6YaCXu/9sAKTkJuODEZQFWNlNPLTX
X-Gm-Message-State: AOJu0YwKx9MLz6qLmZjirBUftxEEinvr4St5o86At6a2yfVP3yzTuiHo
	5q8esJKaOY3fD3oFQC1PyDa2K8AJ7pH3p1sMiPzAB3L8itj5kCs/s24BKkhcDc3KtvKvBqz1FYU
	jRx3j+X8yC93KrX0AscbgzNQ8xgchsb1xZu4+rQ==
X-Google-Smtp-Source: AGHT+IG2BxXgJVOwLbNTGL/2lu0xJUpGJkEV7mBYqdT3Lf+sicVEgDMwmN4fyWwSEU9e7ZSLAyn1PX1NUKNPoKkALjE=
X-Received: by 2002:a17:90b:4b51:b0:2c1:b92f:a15d with SMTP id
 98e67ed59e1d1-2c1dc56fdacmr1221451a91.12.1717148734331; Fri, 31 May 2024
 02:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528091808.863702-1-naresh.solanki@9elements.com> <4d4946d6-58f9-4f64-b860-a60dd08a2d62@roeck-us.net>
In-Reply-To: <4d4946d6-58f9-4f64-b860-a60dd08a2d62@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 31 May 2024 15:15:23 +0530
Message-ID: <CABqG17h_1QfmmYW8idiTMfFFX_90S78SVnw=BqtieYmwdSU4bw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (max6639) : Update hwmon init using info
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Tue, 28 May 2024 at 20:05, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/28/24 02:18, Naresh Solanki wrote:
> > Update hwmon init with info instead of group.
>
> A more detailed description which doesn't require insider knowledge
> would be helpful.
Sure. Will update as:
hwmon: (max6639) : Update hwmon init using info structure

Update hwmon init with info instead of group. The hwmon info structure
is more flexible to describe sensor attributes & easy to maintain.


>
> > Also added additional attribute for fan i.e.,
> > fanY_pulse
> > pwmY_freq
>
> Separate patches for additional attributes, please.
Ack.
>
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >   drivers/hwmon/max6639.c | 536 ++++++++++++++++++++++++++--------------
> >   1 file changed, 357 insertions(+), 179 deletions(-)
> >
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index cbb595fe47aa..b757a85837e8 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -55,13 +55,17 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> >   #define MAX6639_GCONFIG_PWM_FREQ_HI         0x08
> >
> >   #define MAX6639_FAN_CONFIG1_PWM                     0x80
> > -
> > +#define MAX6639_FAN_CONFIG3_FREQ_MASK                0x03
> >   #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED        0x40
> >
> >   #define MAX6639_NUM_CHANNELS                        2
> >
> >   static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> >
> > +/* Supported PWM frequency */
> > +static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
> > +                                        25000 };
> > +
> >   #define FAN_FROM_REG(val, rpm_range)        ((val) == 0 || (val) == 255 ? \
> >                               0 : (rpm_ranges[rpm_range] * 30) / (val))
> >   #define TEMP_LIMIT_TO_REG(val)      clamp_val((val) / 1000, 0, 255)
> > @@ -73,19 +77,16 @@ struct max6639_data {
> >       struct regmap *regmap;
> >
> >       /* Register values initialized only once */
> > -     u8 ppr;                 /* Pulses per rotation 0..3 for 1..4 ppr */
> > -     u8 rpm_range;           /* Index in above rpm_ranges table */
> > +     u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
> > +     u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> >
> >       /* Optional regulator for FAN supply */
> >       struct regulator *reg;
> >   };
> >
> > -static ssize_t temp_input_show(struct device *dev,
> > -                            struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_input(struct device *dev, int channel, long *temp)
> >   {
> > -     long temp;
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       unsigned int val;
> >       int res;
> >
> > @@ -93,251 +94,425 @@ static ssize_t temp_input_show(struct device *dev,
> >        * Lock isn't needed as MAX6639_REG_TEMP wpnt change for at least 250ms after reading
> >        * MAX6639_REG_TEMP_EXT
> >        */
> > -     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);
> >       if (res < 0)
> >               return res;
> >
> > -     temp = val >> 5;
> > -     res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
> > +     *temp = val >> 5;
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP(channel), &val);
> >       if (res < 0)
> >               return res;
> >
> > -     temp |= val << 3;
> > -     temp *= 125;
> > +     *temp |= val << 3;
> > +     *temp *= 125;
> >
> > -     return sprintf(buf, "%ld\n", temp);
> > +     return res;
>
>         return 0;
>
> because res is known to be 0 here.
Sure.
>
> >   }
> >
> > -static ssize_t temp_fault_show(struct device *dev,
> > -                            struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_fault(struct device *dev, int channel, long *fault)
> >   {
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> > -     if (res < 0)
> > -             return res;
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);
>
> Please always handle errors first before assigning results, as implemented in
> max6639_temp_read_input().
>
>         if (res < 0)
>                 return res;
>
>         *fault = val & 1;
>
>         return 0;
>
Ack
> > +     *fault = val & 1;
> >
> > -     return sprintf(buf, "%d\n", val & 1);
> > +     return res;
> >   }
> >
> > -static ssize_t temp_max_show(struct device *dev,
> > -                          struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_max(struct device *dev, int channel, long *max)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
> > -     if (res < 0)
> > -             return res;
> > +     res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(channel), &val);
> > +     *max = val * 1000;
> >
> > -     return sprintf(buf, "%d\n", (val * 1000));
> > +     return res;
> >   }
> >
> > -static ssize_t temp_max_store(struct device *dev,
> > -                           struct device_attribute *dev_attr,
> > -                           const char *buf, size_t count)
> > +static int max6639_temp_read_crit(struct device *dev, int channel, long *crit)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> > +     unsigned int val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > -             return res;
> > +     res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), &val);
> > +     *crit = val * 1000;
> >
> > -     regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
> > -                  TEMP_LIMIT_TO_REG(val));
> > -     return count;
> > +     return res;
> >   }
> >
> > -static ssize_t temp_crit_show(struct device *dev,
> > -                           struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_emergency(struct device *dev, int channel, long *emerg)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
> > -     if (res < 0)
> > -             return res;
> > +     res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(channel), &val);
> > +     *emerg = val * 1000;
> >
> > -     return sprintf(buf, "%d\n", (val * 1000));
> > +     return res;
> >   }
> >
> > -static ssize_t temp_crit_store(struct device *dev,
> > -                            struct device_attribute *dev_attr,
> > -                            const char *buf, size_t count)
> > +static int max6639_get_status(struct device *dev, unsigned int *status)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> > +     unsigned int val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > -             return res;
> > +     res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> > +     *status = val;
> >
> > -     regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
> > -                  TEMP_LIMIT_TO_REG(val));
> > -     return count;
> > +     return res;
> >   }
> >
> > -static ssize_t temp_emergency_show(struct device *dev,
> > -                                struct device_attribute *dev_attr,
> > -                                char *buf)
> > +static int max6639_temp_set_max(struct max6639_data *data, int channel, unsigned long val)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > -     struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
> > -     if (res < 0)
> > -             return res;
> > -
> > -     return sprintf(buf, "%d\n", (val * 1000));
> > +     res = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(channel),
> > +                        TEMP_LIMIT_TO_REG(val));
> > +     return res;
> >   }
> >
> > -static ssize_t temp_emergency_store(struct device *dev,
> > -                                 struct device_attribute *dev_attr,
> > -                                 const char *buf, size_t count)
> > +static int max6639_temp_set_crit(struct max6639_data *data, int channel, unsigned long val)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > -     struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > -             return res;
> > +     res = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
> > +
> > +     return res;
> > +}
> > +
> > +static int max6639_temp_set_emergency(struct max6639_data *data, int channel, unsigned long val)
> > +{
> > +     int res;
> >
> > -     regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
> > +     res = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
> >
> > -     return count;
> > +     return res;
> >   }
> >
> > -static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
> > -                     char *buf)
> > +static int max6639_read_fan(struct device *dev, u32 attr, int channel,
> > +                         long *fan_val)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned int val;
> > -     int res;
> > +     unsigned int val, res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), &val);
> > -     if (res < 0)
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(channel), &val);
> > +             *fan_val = FAN_FROM_REG(val, data->rpm_range[channel]);
> > +             return res;
> > +     case hwmon_fan_fault:
> > +             res = max6639_get_status(dev, &val);
> > +             *fan_val = !!(val & (2 >> channel));
>
>                                 !!BIT(1 - channel)
>
> in these cases might be easier to read than the shifts.
>
Ack. Will update all such instance accordingly.
> >               return res;
> > +     case hwmon_fan_pulses:
> > +             *fan_val = data->ppr[channel];
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> >
> > -     return sprintf(buf, "%d\n", val * 255 / 120);
> > +static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
> > +{
> > +     return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
>
> The -- here is confusing. I thoink it would be better to handle it in the calling code.
>
I want to avoid caller adjusting value based on hw as far as possible.
Is it ok to add a comment here instead like:

/* Decrement the PPR value and shift left by 6 to match the register format */

Please let me know what you feel.
> >   }
> >
> > -static ssize_t pwm_store(struct device *dev,
> > -                      struct device_attribute *dev_attr, const char *buf,
> > -                      size_t count)
> > +static int max6639_write_fan(struct device *dev, u32 attr, int channel,
> > +                          long val)
> >   {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> > -     int res;
> > +     int err;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > -             return res;
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_pulses:
> > +             if (val <= 0 || val > 5) {
> > +                     dev_err(dev, "invalid pulses-per-revolution %ld. Valid range id 1 - 4.",
> > +                             val);
>
> No such error messages as result to user input, please.
>
Ack
> > +                     return -EINVAL;
> > +             }
> > +             /* Set Fan pulse per revolution */
> > +             err = max6639_set_ppr(data, channel, val);
> > +             if (err)
> > +                     dev_err(dev, "Failed to set pulses-per-revolution");
>
> If this is an error, return it.
>
Ack
> > +             else
> > +                     data->ppr[channel] = val;
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> >
> > -     val = clamp_val(val, 0, 255);
> > +static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
> > +{
> > +     struct max6639_data *data = (struct max6639_data *)_data;
> >
> > -     regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), val * 120 / 255);
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> >
> > -     return count;
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +     case hwmon_fan_fault:
> > +             return 0444;
> > +     case hwmon_fan_pulses:
> > +             return 0644;
> > +     default:
> > +             return 0;
> > +     }
> >   }
> >
> > -static ssize_t fan_input_show(struct device *dev,
> > -                           struct device_attribute *dev_attr, char *buf)
> > +static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
> > +                         long *pwm_val)
> >   {
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > -     unsigned int val;
> > -     int res;
> > -
> > -     res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
> > -     if (res < 0)
> > +     unsigned int val, res;
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(channel), &val);
> > +             *pwm_val = val * 255 / 120;
> > +             return 0;
> > +     case hwmon_pwm_freq:
> > +             u8 x;
> > +
>
> Please avoid.
>
Ack
> > +             res = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(channel), &val);
> > +             if (res < 0)
> > +                     return res;
> > +             x = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
> > +
> > +             res = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &val);
> > +             if (res < 0)
> > +                     return res;
> > +
> > +             if (val & MAX6639_GCONFIG_PWM_FREQ_HI)
> > +                     x |= 0x4;
> > +             x &= 0x7;
> > +             *pwm_val = freq_table[x];
> >               return res;
> > -
> > -     return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> >   }
> >
> > -static ssize_t alarm_show(struct device *dev,
> > -                       struct device_attribute *dev_attr, char *buf)
> > +static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
> > +                          long val)
> >   {
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > -     unsigned int val;
> > +     int err;
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             val = clamp_val(val, 0, 255);
> > +             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(channel),
> > +                                val * 120 / 255);
> > +             return err;
> > +     case hwmon_pwm_freq:
> > +             u8 x;
> > +
> > +             val = clamp_val(val, 0, 25000);
> > +             /* Chip supports limited number of frequency */
>
> frequencies, but the comment is really not necessary.
>
> > +             for (x = 0; x < sizeof(freq_table); x++)
> > +                     if (val <= freq_table[x])
> > +                             break;
> > +
>
> Use find_closest()
>
Ack. Will update as:
                i = find_closest(val, freq_table, ARRAY_SIZE(freq_table));


> > +             err = regmap_update_bits(data->regmap, MAX6639_REG_FAN_CONFIG3(channel),
> > +                                      MAX6639_FAN_CONFIG3_FREQ_MASK, x);
> > +             if (err < 0)
> > +                     return err;
> > +
> > +             if (x >> 2)
> > +                     err = regmap_set_bits(data->regmap, MAX6639_REG_GCONFIG,
> > +                                           MAX6639_GCONFIG_PWM_FREQ_HI);
> > +             else
> > +                     err = regmap_clear_bits(data->regmap, MAX6639_REG_GCONFIG,
> > +                                             MAX6639_GCONFIG_PWM_FREQ_HI);
> > +             return err;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
> > +{
> > +     struct max6639_data *data = (struct max6639_data *)_data;
> > +
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
>
> Pointless assignment and check. The parameter isn't used.
>
Ack. Will be removed.
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +     case hwmon_pwm_freq:
> > +             return 0644;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static int max6639_read_temp(struct device *dev, u32 attr, int channel,
> > +                          long *val)
> > +{
> > +     unsigned int status;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> > -     if (res < 0)
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +             res = max6639_temp_read_input(dev, channel, val);
> > +             return res;
> > +     case hwmon_temp_fault:
> > +             res = max6639_temp_read_fault(dev, channel, val);
> >               return res;
> > +     case hwmon_temp_max:
> > +             res = max6639_temp_read_max(dev, channel, val);
> > +             return res;
> > +     case hwmon_temp_crit:
> > +             res = max6639_temp_read_crit(dev, channel, val);
> > +             return res;
> > +     case hwmon_temp_emergency:
> > +             res = max6639_temp_read_emergency(dev, channel, val);
> > +             return res;
> > +     case hwmon_temp_max_alarm:
> > +             res = max6639_get_status(dev, &status);
> > +             *val = !!(status & (0x08 >> channel));
>
>                                         BIT(3 - channel) ?
>
Ack
> > +             return res;
> > +     case hwmon_temp_crit_alarm:
> > +             res = max6639_get_status(dev, &status);
> > +             *val = !!(status & (0x80 >> channel));
> > +             return res;
> > +     case hwmon_temp_emergency_alarm:
> > +             res = max6639_get_status(dev, &status);
> > +             *val = !!(status & (0x20 >> channel));
> > +             return res;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int max6639_write_temp(struct device *dev, u32 attr, int channel,
> > +                           long val)
> > +{
> > +     struct max6639_data *data = dev_get_drvdata(dev);
> > +
> > +     switch (attr) {
> > +     case hwmon_temp_max:
> > +             return max6639_temp_set_max(data, channel, val);
> > +     case hwmon_temp_crit:
> > +             return max6639_temp_set_crit(data, channel, val);
> > +     case hwmon_temp_emergency:
> > +             return max6639_temp_set_emergency(data, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t max6639_temp_is_visible(const void *_data, u32 attr, int channel)
> > +{
> > +     switch (attr) {
> > +     case hwmon_temp_input:
> > +     case hwmon_temp_fault:
> > +     case hwmon_temp_max_alarm:
> > +     case hwmon_temp_crit_alarm:
> > +     case hwmon_temp_emergency_alarm:
> > +             return 0444;
> > +     case hwmon_temp_max:
> > +     case hwmon_temp_crit:
> > +     case hwmon_temp_emergency:
> > +             return 0644;
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static int max6639_read(struct device *dev, enum hwmon_sensor_types type,
> > +                     u32 attr, int channel, long *val)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return max6639_read_fan(dev, attr, channel, val);
> > +     case hwmon_pwm:
> > +             return max6639_read_pwm(dev, attr, channel, val);
> > +     case hwmon_temp:
> > +             return max6639_read_temp(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> >
> > -     return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
> > +static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
> > +                      u32 attr, int channel, long val)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return max6639_write_fan(dev, attr, channel, val);
> > +     case hwmon_pwm:
> > +             return max6639_write_pwm(dev, attr, channel, val);
> > +     case hwmon_temp:
> > +             return max6639_write_temp(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> >   }
> >
> > -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
> > -static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
> > -static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
> > -static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
> > -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
> > -static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
> > -static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp_crit, 0);
> > -static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp_crit, 1);
> > -static SENSOR_DEVICE_ATTR_RW(temp1_emergency, temp_emergency, 0);
> > -static SENSOR_DEVICE_ATTR_RW(temp2_emergency, temp_emergency, 1);
> > -static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
> > -static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
> > -static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
> > -static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
> > -static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, 1);
> > -static SENSOR_DEVICE_ATTR_RO(fan2_fault, alarm, 0);
> > -static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 3);
> > -static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 2);
> > -static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 7);
> > -static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 6);
> > -static SENSOR_DEVICE_ATTR_RO(temp1_emergency_alarm, alarm, 5);
> > -static SENSOR_DEVICE_ATTR_RO(temp2_emergency_alarm, alarm, 4);
> > -
> > -
> > -static struct attribute *max6639_attrs[] = {
> > -     &sensor_dev_attr_temp1_input.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_input.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_fault.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_fault.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_max.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_max.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_crit.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_crit.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_emergency.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_emergency.dev_attr.attr,
> > -     &sensor_dev_attr_pwm1.dev_attr.attr,
> > -     &sensor_dev_attr_pwm2.dev_attr.attr,
> > -     &sensor_dev_attr_fan1_input.dev_attr.attr,
> > -     &sensor_dev_attr_fan2_input.dev_attr.attr,
> > -     &sensor_dev_attr_fan1_fault.dev_attr.attr,
> > -     &sensor_dev_attr_fan2_fault.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
> > -     &sensor_dev_attr_temp1_emergency_alarm.dev_attr.attr,
> > -     &sensor_dev_attr_temp2_emergency_alarm.dev_attr.attr,
> > +static umode_t max6639_is_visible(const void *data,
> > +                               enum hwmon_sensor_types type,
> > +                               u32 attr, int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return max6639_fan_is_visible(data, attr, channel);
> > +     case hwmon_pwm:
> > +             return max6639_pwm_is_visible(data, attr, channel);
> > +     case hwmon_temp:
> > +             return max6639_temp_is_visible(data, attr, channel);
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static const struct hwmon_channel_info * const max6639_info[] = {
> > +     HWMON_CHANNEL_INFO(fan,
> > +                        HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES,
> > +                        HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES),
> > +     HWMON_CHANNEL_INFO(pwm,
> > +                        HWMON_PWM_INPUT | HWMON_PWM_FREQ,
> > +                        HWMON_PWM_INPUT | HWMON_PWM_FREQ),
> > +     HWMON_CHANNEL_INFO(temp,
> > +                        HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
> > +                        HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
> > +                        HWMON_T_EMERGENCY_ALARM,
> > +                        HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
> > +                        HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
> > +                        HWMON_T_EMERGENCY_ALARM),
> >       NULL
> >   };
> > -ATTRIBUTE_GROUPS(max6639);
> > +
> > +static const struct hwmon_ops max6639_hwmon_ops = {
> > +     .is_visible = max6639_is_visible,
> > +     .read = max6639_read,
> > +     .write = max6639_write,
> > +};
> > +
> > +static const struct hwmon_chip_info max6639_chip_info = {
> > +     .ops = &max6639_hwmon_ops,
> > +     .info = max6639_info,
> > +};
> >
> >   /*
> >    *  returns respective index in rpm_ranges table
> > @@ -355,11 +530,6 @@ static int rpm_range_to_reg(int range)
> >       return 1; /* default: 4000 RPM */
> >   }
> >
> > -static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
> > -{
> > -     return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
> > -}
> > -
> >   static int max6639_init_client(struct i2c_client *client,
> >                              struct max6639_data *data)
> >   {
> > @@ -380,14 +550,16 @@ static int max6639_init_client(struct i2c_client *client,
> >               ppr = max6639_info->ppr;
> >       else
> >               ppr = 2;
> > -     ppr -= 1;
> > +
> > +     data->ppr[0] = ppr;
> > +     data->ppr[1] = ppr;
> >
>
> I think we should drop support for max6639_platform_data entirely.
> It isn't used anywhere in the kernel and obviously incomplete.
>
Ack. I'll work on it and submit patch next week after testing.
> >       if (max6639_info)
> >               rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> > -     data->rpm_range = rpm_range;
> > +     data->rpm_range[0] = rpm_range;
> > +     data->rpm_range[1] = rpm_range;
> >
> >       for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
> > -
> >               /* Set Fan pulse per revolution */
> >               err = max6639_set_ppr(data, i, ppr);
> >               if (err)
> > @@ -395,15 +567,17 @@ static int max6639_init_client(struct i2c_client *client,
> >
> >               /* Fans config PWM, RPM */
> >               err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
> > -                                MAX6639_FAN_CONFIG1_PWM | rpm_range);
> > +                                MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
> >               if (err)
> >                       return err;
> >
> >               /* Fans PWM polarity high by default */
> > -             if (max6639_info && max6639_info->pwm_polarity == 0)
> > -                     err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> > -             else
> > -                     err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> > +             if (max6639_info) {
> > +                     if (max6639_info->pwm_polarity == 0)
> > +                             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
> > +                     else
> > +                             err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
> > +             }
> >               if (err)
> >                       return err;
> >
> > @@ -534,9 +708,13 @@ static int max6639_probe(struct i2c_client *client)
> >       if (err < 0)
> >               return err;
> >
> > -     hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> > -                                                        data,
> > -                                                        max6639_groups);
> > +     hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> > +                                                      data, &max6639_chip_info,
> > +                                                      NULL);
> > +
> > +     if (IS_ERR(hwmon_dev))
> > +             return dev_err_probe(dev, PTR_ERR(hwmon_dev),
> > +                                  "unable to register hwmon device\n");
>
> This is a functional change unrelated to the conversion, and I am not
> in favor of it. Please refrain from making such changes.
Ack.

Regards,
Naresh
>
> Thanks,
> Guenter
>

