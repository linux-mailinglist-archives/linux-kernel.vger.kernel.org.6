Return-Path: <linux-kernel+bounces-212964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD59068FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9261F26AD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699D1140374;
	Thu, 13 Jun 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="duIeASb5"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6B14039E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271364; cv=none; b=Kl1I15VFjVdNGf9txpKa0ED+l9kcBUoy8QGQk6jD7xrd0p7QIiFwnO4zpcCqYJlhoN7VGqQq1iPgGDXgD/O8jP8KZbUkrUP0eAdCHGwumP6ZuglI75+KxB7LR2Zqfn7mRYPynbYJL3yKXoMWbnNL/6iOP0zKaltdujoXs2MSJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271364; c=relaxed/simple;
	bh=+RYxMDDuFz7TqnzbrcEthITR8Z4N/1usuiofS3gVaNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j36dpcp3zfP27BstJ8N7b3UEfUagA0gjcB93a4hqbLZe71GUaK7TjJWKAXRPUyvLsHPRq+UzQw2/VpGa7wFK9EUHVEm8ghLode1M02UUxZe8lQd8tkptrYhuJEKAUzrEw1VHNyRXgX2nlNkrxP8+l86POfMBAhFUwDfKYMTdDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=duIeASb5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-705c1220a52so793235b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1718271361; x=1718876161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eNpuyI/2HksD1FaTADuV7K6WUULVhB5NOnD2o32DTzE=;
        b=duIeASb5C2yG5W3UpHMlNkcqq8xjiNPSmBQrqacT1caOoyCahf1g4EgrlE5V2rrSw/
         nodGkrqsrgBTFDG+P421e6q6Mwg7i7y6cVDqlwPy0pu005f669+GBQtEmngRNKeSOw14
         qfX2RPmD45w6uTkcOYue8wX3IvMySLliagDTB6yuL2FhzRso5wvhYVSEkuwJ6fmo9bBY
         ty8rhOXnme8sPlqBKCDQeDd/dw5CK45vcm8U+6O1DT69XT8Nd26zXgTwSOhY6Ucdr0RI
         nhloigjYOAErgScQVXf+EE5rO72429+vats0JvWs2enPPxrCB/7Xq+lymVRu3yTYnfK9
         tHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271361; x=1718876161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNpuyI/2HksD1FaTADuV7K6WUULVhB5NOnD2o32DTzE=;
        b=DM9nZCgIzgT1DIvShdu+H086Cin15TIJu7HkaPeKqo5x73r4UNZM9NlHcwjsdfVGhC
         yniLsWVRqASf9ARhbXqiFLpjoW/5VEpv+eorgPwnUOgffkGOF1fUqjPaNObouljE1YNi
         /jNI8Xomt3F/skqVzz7Y5HzEFRpGdU0IL59yWwZYgKPzJseh8w7DvjurQm71nT7WKS3y
         m/Li9Li3HdzbbAbHtQwYXnVypQ56N+G7lqPvmzIVG4DsaxlCIQk5D+c/TIlnms+pNDqz
         RfcdEGtY5KTaRwCF5IqAEzeizfTr6qqTgO4zvtcWzBz9Mb0SEM3+N7phimtiStLntuK4
         Tejg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ib5fBMH4Gv9f1OpvpyERuAg2u4/9s+HV6MnCa2A8wPDfxo2bg5/Eogh8ABd4sLslBIE+DRmmKeY/ptJDnP6WKO5HI1Rq+vLGaiOH
X-Gm-Message-State: AOJu0YyCcH+EpxAXzPxjXIHzxCCvz8O3gOe76PBETYWuRzVJZAqFZ6WG
	EvKiH1HYCalEvTO+8u04dBY2pzWnrtmxddOTLLP9xjh90mIoa275oT+ObtTrcpE9j0awbuPHrDv
	ZZcVdw1ENd7puik3zm4/vyJ3sb66Wzul0G095LZotyv8qRMXSdqkdtlSs
X-Google-Smtp-Source: AGHT+IGdJdHpLfzegzGsVYcDeFyC4gyrUOh/9oFhQs7fqEAWtqtPTB5VNk8uRe/CnNJsNLpkqtKxRmKEUL2Jl5lDzAQ=
X-Received: by 2002:a05:6a21:1a3:b0:1b2:3998:404 with SMTP id
 adf61e73a8af0-1b8a9b64678mr5009421637.4.1718271361233; Thu, 13 Jun 2024
 02:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604124742.4093334-1-naresh.solanki@9elements.com> <86ed7651-818c-42fb-ae31-8f73f7e725a7@roeck-us.net>
In-Reply-To: <86ed7651-818c-42fb-ae31-8f73f7e725a7@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Thu, 13 Jun 2024 15:05:51 +0530
Message-ID: <CABqG17hC_h8ru6xmTZiQH4vEAY_+zcPk4=CMB2rn9u_j2jVx0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hwmon: (max6639) : Update hwmon init using info structure
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,


On Wed, 12 Jun 2024 at 20:04, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Naresh,
>
> On Tue, Jun 04, 2024 at 06:17:39PM +0530, Naresh Solanki wrote:
> > Update hwmon init with info instead of group. The hwmon info structure
> > in more flexible to describe sensor attribute & easy to maintian.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
>
> After applying your patch, I get the following errors in my module tests.
>
> Testing max6639 ...
> temp1_crit: Suspected underflow: [min=0, read 255000, written -2147483648]
> temp1_emergency: Suspected underflow: [min=0, read 255000, written -2147483648]
> temp1_max: Suspected underflow: [min=0, read 255000, written -2147483648]
> temp2_crit: Suspected underflow: [min=0, read 255000, written -2147483648]
> temp2_emergency: Suspected underflow: [min=0, read 255000, written -2147483648]
> temp2_max: Suspected underflow: [min=0, read 255000, written -2147483648]
>
> That was not seen before. Problem is that your set functions pass 'unsigned long'
> as parameter, converting negative values into large positive ones.
Agree. Will update v5 with below changes:
For set functions, I'll change 'unsigned long' to long.
For get functions, will do typecast as below:
        *crit = (long)val * 1000;

Please let me know if you have any other suggestions.

Thanks
Naresh.
>
> Guenter
>
>
> > Changes in v4:
> > - Change res type from unsigned to signed
> >
> > Changes in V3:
> > - return 0 when 'res' variable is known zero.
> > - Handle errors first before assigning results
> > - Use BIT to make it easier to read.
> > - Remove error message print on user input
> > - Return err value instead of printing error message & returing zero.
> > - Remove variable declaration in switch case statement
> > - Use find_closest instead of for loop
> > - Remove pointless assignment & check
> > - Seperate patch for adding additional attributes
> > ---
> >  drivers/hwmon/max6639.c | 469 +++++++++++++++++++++++++---------------
> >  1 file changed, 299 insertions(+), 170 deletions(-)
> >
> >
> > base-commit: 5124d9acf3af50bcc6d0958db4fecb3c2f13f8ed
> >
> > diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> > index cbb595fe47aa..e2a5210f9f95 100644
> > --- a/drivers/hwmon/max6639.c
> > +++ b/drivers/hwmon/max6639.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/platform_data/max6639.h>
> >  #include <linux/regmap.h>
> > +#include <linux/util_macros.h>
> >
> >  /* Addresses to scan */
> >  static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> > @@ -55,13 +56,17 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
> >  #define MAX6639_GCONFIG_PWM_FREQ_HI          0x08
> >
> >  #define MAX6639_FAN_CONFIG1_PWM                      0x80
> > -
> > +#define MAX6639_FAN_CONFIG3_FREQ_MASK                0x03
> >  #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED 0x40
> >
> >  #define MAX6639_NUM_CHANNELS                 2
> >
> >  static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
> >
> > +/* Supported PWM frequency */
> > +static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
> > +                                        25000 };
> > +
> >  #define FAN_FROM_REG(val, rpm_range) ((val) == 0 || (val) == 255 ? \
> >                               0 : (rpm_ranges[rpm_range] * 30) / (val))
> >  #define TEMP_LIMIT_TO_REG(val)       clamp_val((val) / 1000, 0, 255)
> > @@ -73,19 +78,16 @@ struct max6639_data {
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
> >  };
> >
> > -static ssize_t temp_input_show(struct device *dev,
> > -                            struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_input(struct device *dev, int channel, long *temp)
> >  {
> > -     long temp;
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       unsigned int val;
> >       int res;
> >
> > @@ -93,251 +95,378 @@ static ssize_t temp_input_show(struct device *dev,
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
> > +     return 0;
> >  }
> >
> > -static ssize_t temp_fault_show(struct device *dev,
> > -                            struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_fault(struct device *dev, int channel, long *fault)
> >  {
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
> > +     res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);
> >       if (res < 0)
> >               return res;
> >
> > -     return sprintf(buf, "%d\n", val & 1);
> > +     *fault = val & 1;
> > +
> > +     return 0;
> >  }
> >
> > -static ssize_t temp_max_show(struct device *dev,
> > -                          struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_max(struct device *dev, int channel, long *max)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
> > +     res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(channel), &val);
> >       if (res < 0)
> >               return res;
> >
> > -     return sprintf(buf, "%d\n", (val * 1000));
> > +     *max = val * 1000;
> > +
> > +     return 0;
> >  }
> >
> > -static ssize_t temp_max_store(struct device *dev,
> > -                           struct device_attribute *dev_attr,
> > -                           const char *buf, size_t count)
> > +static int max6639_temp_read_crit(struct device *dev, int channel, long *crit)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> > +     unsigned int val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > +     res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), &val);
> > +     if (res < 0)
> >               return res;
> >
> > -     regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
> > -                  TEMP_LIMIT_TO_REG(val));
> > -     return count;
> > +     *crit = val * 1000;
> > +
> > +     return 0;
> >  }
> >
> > -static ssize_t temp_crit_show(struct device *dev,
> > -                           struct device_attribute *dev_attr, char *buf)
> > +static int max6639_temp_read_emergency(struct device *dev, int channel, long *emerg)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
> > +     res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(channel), &val);
> >       if (res < 0)
> >               return res;
> >
> > -     return sprintf(buf, "%d\n", (val * 1000));
> > +     *emerg = val * 1000;
> > +
> > +     return 0;
> >  }
> >
> > -static ssize_t temp_crit_store(struct device *dev,
> > -                            struct device_attribute *dev_attr,
> > -                            const char *buf, size_t count)
> > +static int max6639_get_status(struct device *dev, unsigned int *status)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> > +     unsigned int val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > +     res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
> > +     if (res < 0)
> >               return res;
> >
> > -     regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
> > -                  TEMP_LIMIT_TO_REG(val));
> > -     return count;
> > +     *status = val;
> > +
> > +     return 0;
> >  }
> >
> > -static ssize_t temp_emergency_show(struct device *dev,
> > -                                struct device_attribute *dev_attr,
> > -                                char *buf)
> > +static int max6639_temp_set_max(struct max6639_data *data, int channel, unsigned long val)
> >  {
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
> >  }
> >
> > -static ssize_t temp_emergency_store(struct device *dev,
> > -                                 struct device_attribute *dev_attr,
> > -                                 const char *buf, size_t count)
> > +static int max6639_temp_set_crit(struct max6639_data *data, int channel, unsigned long val)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > -     struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > -             return res;
> > -
> > -     regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
> > +     res = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
> >
> > -     return count;
> > +     return res;
> >  }
> >
> > -static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
> > -                     char *buf)
> > +static int max6639_temp_set_emergency(struct max6639_data *data, int channel, unsigned long val)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> > -     struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), &val);
> > -     if (res < 0)
> > -             return res;
> > +     res = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
> >
> > -     return sprintf(buf, "%d\n", val * 255 / 120);
> > +     return res;
> >  }
> >
> > -static ssize_t pwm_store(struct device *dev,
> > -                      struct device_attribute *dev_attr, const char *buf,
> > -                      size_t count)
> > +static int max6639_read_fan(struct device *dev, u32 attr, int channel,
> > +                         long *fan_val)
> >  {
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     unsigned long val;
> > +     unsigned int val;
> >       int res;
> >
> > -     res = kstrtoul(buf, 10, &val);
> > -     if (res)
> > -             return res;
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(channel), &val);
> > +             if (res < 0)
> > +                     return res;
> > +             *fan_val = FAN_FROM_REG(val, data->rpm_range[channel]);
> > +             return 0;
> > +     case hwmon_fan_fault:
> > +             res = max6639_get_status(dev, &val);
> > +             if (res < 0)
> > +                     return res;
> > +             *fan_val = !!(val & BIT(1 - channel));
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
> > +{
> > +     /* Decrement the PPR value and shift left by 6 to match the register format */
> > +     return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
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
> >  }
> >
> > -static ssize_t fan_input_show(struct device *dev,
> > -                           struct device_attribute *dev_attr, char *buf)
> > +static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
> > +                         long *pwm_val)
> >  {
> >       struct max6639_data *data = dev_get_drvdata(dev);
> > -     struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
> >       unsigned int val;
> >       int res;
> >
> > -     res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
> > -     if (res < 0)
> > -             return res;
> > +     if (IS_ERR(data))
> > +             return PTR_ERR(data);
> >
> > -     return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(channel), &val);
> > +             if (res < 0)
> > +                     return res;
> > +             *pwm_val = val * 255 / 120;
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> >  }
> >
> > -static ssize_t alarm_show(struct device *dev,
> > -                       struct device_attribute *dev_attr, char *buf)
> > +static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
> > +                          long val)
> >  {
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
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
> > +{
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
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
> > +             return res;
> > +     case hwmon_temp_max:
> > +             res = max6639_temp_read_max(dev, channel, val);
> > +             return res;
> > +     case hwmon_temp_crit:
> > +             res = max6639_temp_read_crit(dev, channel, val);
> > +             return res;
> > +     case hwmon_temp_emergency:
> > +             res = max6639_temp_read_emergency(dev, channel, val);
> >               return res;
> > +     case hwmon_temp_max_alarm:
> > +             res = max6639_get_status(dev, &status);
> > +             if (res < 0)
> > +                     return res;
> > +             *val = !!(status & BIT(3 - channel));
> > +             return 0;
> > +     case hwmon_temp_crit_alarm:
> > +             res = max6639_get_status(dev, &status);
> > +             if (res < 0)
> > +                     return res;
> > +             *val = !!(status & BIT(7 - channel));
> > +             return 0;
> > +     case hwmon_temp_emergency_alarm:
> > +             res = max6639_get_status(dev, &status);
> > +             if (res < 0)
> > +                     return res;
> > +             *val = !!(status & BIT(5 - channel));
> > +             return 0;
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
> > +     case hwmon_pwm:
> > +             return max6639_write_pwm(dev, attr, channel, val);
> > +     case hwmon_temp:
> > +             return max6639_write_temp(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
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
> >  }
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
> > +static const struct hwmon_channel_info * const max6639_info[] = {
> > +     HWMON_CHANNEL_INFO(fan,
> > +                        HWMON_F_INPUT | HWMON_F_FAULT,
> > +                        HWMON_F_INPUT | HWMON_F_FAULT),
> > +     HWMON_CHANNEL_INFO(pwm,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT),
> > +     HWMON_CHANNEL_INFO(temp,
> > +                        HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
> > +                        HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
> > +                        HWMON_T_EMERGENCY_ALARM,
> > +                        HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
> > +                        HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
> > +                        HWMON_T_EMERGENCY_ALARM),
> >       NULL
> >  };
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
> >  /*
> >   *  returns respective index in rpm_ranges table
> > @@ -355,11 +484,6 @@ static int rpm_range_to_reg(int range)
> >       return 1; /* default: 4000 RPM */
> >  }
> >
> > -static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
> > -{
> > -     return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
> > -}
> > -
> >  static int max6639_init_client(struct i2c_client *client,
> >                              struct max6639_data *data)
> >  {
> > @@ -380,30 +504,34 @@ static int max6639_init_client(struct i2c_client *client,
> >               ppr = max6639_info->ppr;
> >       else
> >               ppr = 2;
> > -     ppr -= 1;
> > +
> > +     data->ppr[0] = ppr;
> > +     data->ppr[1] = ppr;
> >
> >       if (max6639_info)
> >               rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
> > -     data->rpm_range = rpm_range;
> > +     data->rpm_range[0] = rpm_range;
> > +     data->rpm_range[1] = rpm_range;
> >
> >       for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
> > -
> >               /* Set Fan pulse per revolution */
> > -             err = max6639_set_ppr(data, i, ppr);
> > +             err = max6639_set_ppr(data, i, data->ppr[i]);
> >               if (err)
> >                       return err;
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
> > @@ -534,9 +662,10 @@ static int max6639_probe(struct i2c_client *client)
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
> >       return PTR_ERR_OR_ZERO(hwmon_dev);
> >  }
> >

