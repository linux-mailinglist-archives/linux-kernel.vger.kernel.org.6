Return-Path: <linux-kernel+bounces-365029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDD499DC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCDFB216C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836216D9BF;
	Tue, 15 Oct 2024 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVVhrIcl"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79822AF09;
	Tue, 15 Oct 2024 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960580; cv=none; b=X966l4XKNiG4f9GG41hiIbjRm7IOlGHyPlPv7m/y0UxlC68tEK0DRLRXNqjLHgE8OKhWw4UWPwZbJJ4SYqGZ2+51evBlxQ5axm5nuxKTre1gD+78vxsmLKKJwch2YlDQZx/xADM4TngCdexMJfHH8zcYH02RPwVPcwKEXAREr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960580; c=relaxed/simple;
	bh=rT+agBNaC3OQqEhOmvLKHKAH7l9/vaz5975FtIxD/vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRUPLsvKVldX50CDBAw6hSrUExDD0zUSLqU2xBWSkCeQ+JwbtvjGeZhBmisNJ3t7J5CwGPXCuwGAhqEyNs3GCAbyDbCJKWj1y54vTBTnb/o78Sy33LT4NI+HdxuDmY5dwgq2+fAx4ggnuuhFtVM/zG3YPOs9wTH993ZaHKaiEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVVhrIcl; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbd57cc35bso45105676d6.1;
        Mon, 14 Oct 2024 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728960578; x=1729565378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6QpddloaBSUmjobzza4mWr5JMsand8nw+B+0gMZgz4=;
        b=LVVhrIclrHqT/JU2Z1mh993tM/i+Ax+pklmESB4O1vKmOTyo8VsnFZVjEqoYGMZbgq
         0nDYK7gXL9lPPZpYnUKpaML7ZHUsrj513mUtr56XGFYLBJv1g5VmwB8x6mZOX6yr8Mw7
         7NCf81v4Afj12Bimq5CWLbhFub+08ROpCMfuSkYvju5FFhlRZR3DZTu+EsixW2bAZt2k
         7O7XyY7pYWfBjV6FWZT5BxuqvPRShpYqR1wyd7EQO5yT55v4cqKSHGsVAOwMmYiZ19jx
         /xSn2CKNgk5Zbr4FM/2eR1PF7axHI9sfihyPwI23Cc0JBDiPc0F3ZnqtteewiDw3VOC9
         HkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728960578; x=1729565378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6QpddloaBSUmjobzza4mWr5JMsand8nw+B+0gMZgz4=;
        b=BSDB5mluJmdbxhsJkGYAw7YThP0q6BmEicPbrFUPCbXiVRVdBW8R/u47sFR+PwRyYM
         M83qYoWJv4BxjU2eCk9zrFSgtiOTW/JkALkROs/lh6EClb85ss9K+fo4Rj+pJI7jCBrm
         uGK9WAJXowCO8wwMOjPd2QiA13Ubpse5cy/2OqUUX+zHixfUfSgZAXmB19HR7KLo65hU
         7btje+g/7Al5cAJJbekRU01ssUsSBq9dYvydp36hLHpKh5jAjTF72LeEVganGJ8EISOP
         D+oePGyB7b1uJb0QMe1tsTr5a9Ty7fzfevTpD1nhiRmUJX365jioWScG1OOMp9MbTr8u
         00Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUBJGukz73PhoiEqD8e2tg3S8vGrKfS1aYClNG99bqz4ITl0MZXFJNwtZ9GGtEkDWEcZSRDK8bFkkrnQXc=@vger.kernel.org, AJvYcCUnexKSr9oxKafsS5Yox0qODk/rNeoXH/BIFIzMoxRNLgcepGH+GqS2WOYf74OCSHAZdB4VFF3IJ2wL@vger.kernel.org, AJvYcCVMlV6mlqpK8Q3xvM5bxYEIEdkGh/gbKp8SVkq8zA/UwibruH49jAu+fTTWusvqjgJJVc2M0XPlLnT5@vger.kernel.org, AJvYcCXHgsgRlRxMKka7axgP6JK18Qrkmwls1LsQpZzX4wrUEOp2E7SMrhCDoZ9EDchDKjQPMQQczjcncAl0/vWZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/FdGkyHGvWRKHSq54unxaeXmJPKMMU/eF0haYfyuDEnyCn5ki
	QvkEnz/rOmOZdkx7/pNzV3J/HcTf0tVC4w+kJJQvNh7S5Dt/Jn0MSPDsTX4NDG6Ix4fm5LoiAuz
	sIpdvTpX3aqOLtycDPl+F+AYx2kE=
X-Google-Smtp-Source: AGHT+IEcKBHtofFY3sXmSdV/IfeR4HDDhH6DC0cwnILrlnbfKKHc2mXD8uyRieb2RIlyqcgM6Q4ecFlNbayoe0kXSrM=
X-Received: by 2002:ad4:4ea7:0:b0:6cb:c9cf:cd40 with SMTP id
 6a1803df08f44-6cbe522c325mr313981486d6.8.1728960577579; Mon, 14 Oct 2024
 19:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322081158.4106326-1-kcfeng0@nuvoton.com> <20240322081158.4106326-3-kcfeng0@nuvoton.com>
 <dee8d81d-590e-4ae5-9771-9e1848b8ffe9@roeck-us.net>
In-Reply-To: <dee8d81d-590e-4ae5-9771-9e1848b8ffe9@roeck-us.net>
From: Ban Feng <baneric926@gmail.com>
Date: Tue, 15 Oct 2024 10:49:26 +0800
Message-ID: <CALz278YCpDYd6Lyj0qdAS9xv0_HYfz7y3a3L7WW4+9A65nS7zQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] hwmon: Add driver for I2C chip Nuvoton NCT7363Y
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org, kwliu@nuvoton.com, 
	kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Thu, Jun 20, 2024 at 10:23=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
>
> On Fri, Mar 22, 2024 at 04:11:58PM +0800, baneric926@gmail.com wrote:
> > From: Ban Feng <kcfeng0@nuvoton.com>
> >
> > The NCT7363Y is a fan controller which provides up to 16
> > independent FAN input monitors. It can report each FAN input count
> > values. The NCT7363Y also provides up to 16 independent PWM
> > outputs. Each PWM can output specific PWM signal by manual mode to
> > control the FAN duty outside.
> >
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>
> Sorry for the late reply. This got somehow lost in my queue.
>
> > ---
> >  Documentation/hwmon/index.rst   |   1 +
> >  Documentation/hwmon/nct7363.rst |  33 +++
> >  MAINTAINERS                     |   2 +
> >  drivers/hwmon/Kconfig           |  11 +
> >  drivers/hwmon/Makefile          |   1 +
> >  drivers/hwmon/nct7363.c         | 396 ++++++++++++++++++++++++++++++++
> >  6 files changed, 444 insertions(+)
> >  create mode 100644 Documentation/hwmon/nct7363.rst
> >  create mode 100644 drivers/hwmon/nct7363.c
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 1ca7a4fe1f8f..0874f2f754f4 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -170,6 +170,7 @@ Hardware Monitoring Kernel Drivers
> >     mpq8785
> >     nct6683
> >     nct6775
> > +   nct7363
> >     nct7802
> >     nct7904
> >     npcm750-pwm-fan
> > diff --git a/Documentation/hwmon/nct7363.rst b/Documentation/hwmon/nct7=
363.rst
> > new file mode 100644
> > index 000000000000..1a6abce3a433
> > --- /dev/null
> > +++ b/Documentation/hwmon/nct7363.rst
> > @@ -0,0 +1,33 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver nct7363
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Supported chip:
> > +
> > +  * Nuvoton NCT7363Y
> > +
> > +    Prefix: nct7363
> > +
> > +    Addresses: I2C 0x20, 0x21, 0x22, 0x23
> > +
> > +Author: Ban Feng <kcfeng0@nuvoton.com>
> > +
> > +
> > +Description
> > +-----------
> > +
> > +The NCT7363Y is a fan controller which provides up to 16 independent
> > +FAN input monitors, and up to 16 independent PWM outputs with SMBus in=
terface.
> > +
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +Currently, the driver supports the following features:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +fanX_input  provide current fan rotation value in RPM
> > +
> > +pwmX        get or set PWM fan control value.
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2705e44ffc0c..c016a0bed476 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15221,6 +15221,8 @@ M:    Ban Feng <kcfeng0@nuvoton.com>
> >  L:   linux-hwmon@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> > +F:   Documentation/hwmon/nct7363.rst
> > +F:   drivers/hwmon/nct7363.c
> >
> >  NETDEVSIM
> >  M:   Jakub Kicinski <kuba@kernel.org>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 83945397b6eb..4ff19ea11001 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1658,6 +1658,17 @@ config SENSORS_NCT6775_I2C
> >         This driver can also be built as a module. If so, the module
> >         will be called nct6775-i2c.
> >
> > +config SENSORS_NCT7363
> > +     tristate "Nuvoton NCT7363Y"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     help
> > +       If you say yes here you get support for the Nuvoton NCT7363Y
> > +       hardware monitoring chip.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called nct7363.
> > +
> >  config SENSORS_NCT7802
> >       tristate "Nuvoton NCT7802Y"
> >       depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 5c31808f6378..cf7be22b916a 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -171,6 +171,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) +=3D nct6775-cor=
e.o
> >  nct6775-objs                 :=3D nct6775-platform.o
> >  obj-$(CONFIG_SENSORS_NCT6775)        +=3D nct6775.o
> >  obj-$(CONFIG_SENSORS_NCT6775_I2C) +=3D nct6775-i2c.o
> > +obj-$(CONFIG_SENSORS_NCT7363)        +=3D nct7363.o
> >  obj-$(CONFIG_SENSORS_NCT7802)        +=3D nct7802.o
> >  obj-$(CONFIG_SENSORS_NCT7904)        +=3D nct7904.o
> >  obj-$(CONFIG_SENSORS_NPCM7XX)        +=3D npcm750-pwm-fan.o
> > diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
> > new file mode 100644
> > index 000000000000..858296f5d5b3
> > --- /dev/null
> > +++ b/drivers/hwmon/nct7363.c
> > @@ -0,0 +1,396 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2023 Nuvoton Technology corporation.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/err.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define NCT7363_REG_FUNC_CFG_BASE(x) (0x20 + (x))
> > +#define NCT7363_REG_PWMEN_BASE(x)    (0x38 + (x))
> > +#define NCT7363_REG_FANINEN_BASE(x)  (0x41 + (x))
> > +#define NCT7363_REG_FANINX_HVAL(x)   (0x48 + ((x) * 2))
> > +#define NCT7363_REG_FANINX_LVAL(x)   (0x49 + ((x) * 2))
> > +#define NCT7363_REG_FSCPXDUTY(x)     (0x90 + ((x) * 2))
> > +
> > +#define PWM_SEL(x)                   (BIT(0) << ((x) * 2))
> > +#define FANIN_SEL(x)                 (BIT(1) << ((x < 8) ? \
> > +                                      (((x) + 8) * 2) : \
> > +                                      (((x) % 8) * 2)))
> > +#define VALUE_TO_REG(x, y)           (((x) >> ((y) * 8)) & 0xFF)
> > +
> > +#define NCT7363_FANINX_LVAL_MASK     GENMASK(4, 0)
> > +#define NCT7363_FANIN_MASK           GENMASK(12, 0)
> > +
> > +#define NCT7363_PWM_COUNT            16
> > +
> > +static inline unsigned int FAN_FROM_REG(u16 val)
>
> Please use lower case for functions, even if inline.

ok, I'll fix it in v6.

>
> > +{
> > +     if (val =3D=3D NCT7363_FANIN_MASK || val =3D=3D 0)
> > +             return 0;
> > +
> > +     return (1350000UL / val);
> > +}
> > +
> > +enum chips { nct7363, nct7362 };
> > +
>
> Those enums are not actually used. Are they needed ?

This added is for nct7362, in case we need to add the difference between th=
em.

>
> > +static const struct i2c_device_id nct7363_id[] =3D {
> > +     { "nct7363", nct7363 },
> > +     { "nct7362", nct7362 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, nct7363_id);
> > +
> > +static const struct of_device_id nct7363_of_match[] =3D {
> > +     { .compatible =3D "nuvoton,nct7363", .data =3D (void *)nct7363 },
> > +     { .compatible =3D "nuvoton,nct7362", .data =3D (void *)nct7362 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, nct7363_of_match);
> > +
> > +struct nct7363_data {
> > +     struct regmap           *regmap;
> > +     struct mutex            lock;           /* protect register acces=
s */
> > +
> > +     u16                     fanin_mask;
> > +     u16                     pwm_mask;
> > +};
> > +
> > +static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
> > +                         long *val)
> > +{
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int hi, lo, rpm;
> > +     int ret =3D 0;
> > +     u16 cnt;
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             /*
> > +              * High-byte register should be read first to latch
> > +              * synchronous low-byte value
> > +              */
> > +             mutex_lock(&data->lock);
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FANINX_HVAL(channel), &hi);
> > +             if (ret)
> > +                     goto out;
> > +
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FANINX_LVAL(channel), &lo);
>
> Please consider using regmap_read_bulk() to avoid the locks.

ok, I'll fix it in v6.

>
> > +             if (ret)
> > +                     goto out;
> > +             mutex_unlock(&data->lock);
> > +
> > +             cnt =3D (hi << 5) | (lo & NCT7363_FANINX_LVAL_MASK);
> > +             rpm =3D FAN_FROM_REG(cnt);
> > +             *val =3D (long)rpm;
>
> rpm and the typecast are unnecessary. Just use
>                 *val =3D fan_from_reg(cnt);

ok, I'll fix it in v6.

>
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +
> > +out:
> > +     mutex_unlock(&data->lock);
> > +     return ret;
> > +}
> > +
> > +static umode_t nct7363_fan_is_visible(const void *_data, u32 attr, int=
 channel)
> > +{
> > +     const struct nct7363_data *data =3D _data;
> > +
> > +     switch (attr) {
> > +     case hwmon_fan_input:
> > +             if (data->fanin_mask & BIT(channel))
> > +                     return 0444;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7363_read_pwm(struct device *dev, u32 attr, int channel,
> > +                         long *val)
> > +{
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             ret =3D regmap_read(data->regmap,
> > +                               NCT7363_REG_FSCPXDUTY(channel), &regval=
);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             *val =3D (long)regval;
> > +             return 0;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int nct7363_write_pwm(struct device *dev, u32 attr, int channel=
,
> > +                          long val)
> > +{
> > +     struct nct7363_data *data =3D dev_get_drvdata(dev);
> > +     int ret;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             if (val < 0 || val > 255)
> > +                     return -EINVAL;
> > +
> > +             ret =3D regmap_write(data->regmap,
> > +                                NCT7363_REG_FSCPXDUTY(channel), val);
> > +
> > +             return ret;
> > +
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t nct7363_pwm_is_visible(const void *_data, u32 attr, int=
 channel)
> > +{
> > +     const struct nct7363_data *data =3D _data;
> > +
> > +     switch (attr) {
> > +     case hwmon_pwm_input:
> > +             if (data->pwm_mask & BIT(channel))
> > +                     return 0644;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7363_read(struct device *dev, enum hwmon_sensor_types ty=
pe,
> > +                     u32 attr, int channel, long *val)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return nct7363_read_fan(dev, attr, channel, val);
> > +     case hwmon_pwm:
> > +             return nct7363_read_pwm(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static int nct7363_write(struct device *dev, enum hwmon_sensor_types t=
ype,
> > +                      u32 attr, int channel, long val)
> > +{
> > +     switch (type) {
> > +     case hwmon_pwm:
> > +             return nct7363_write_pwm(dev, attr, channel, val);
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static umode_t nct7363_is_visible(const void *data,
> > +                               enum hwmon_sensor_types type,
> > +                               u32 attr, int channel)
> > +{
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             return nct7363_fan_is_visible(data, attr, channel);
> > +     case hwmon_pwm:
> > +             return nct7363_pwm_is_visible(data, attr, channel);
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static const struct hwmon_channel_info *nct7363_info[] =3D {
> > +     HWMON_CHANNEL_INFO(fan,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT),
>
> Other potential attributes:
>
> - enable (register 0x41, 0x42, and possibly 0x40)
> - alarm (register 0x34, 0x35)
> - min (register 0x6c, 0x6d)

ok, I'll consider min and alarm in v6.

>
> > +     HWMON_CHANNEL_INFO(pwm,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT,
> > +                        HWMON_PWM_INPUT),
>
> Other potential attributes:
>
> - enable (register 0x38)
> - freq (register 0x91, ...)
>
> All those could be added later, of course, but I would suggest to at leas=
t
> add the fan speed low limit and alarm attributes.

ok, I'll consider min and alarm in v6.

>
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops nct7363_hwmon_ops =3D {
> > +     .is_visible =3D nct7363_is_visible,
> > +     .read =3D nct7363_read,
> > +     .write =3D nct7363_write,
> > +};
> > +
> > +static const struct hwmon_chip_info nct7363_chip_info =3D {
> > +     .ops =3D &nct7363_hwmon_ops,
> > +     .info =3D nct7363_info,
> > +};
> > +
> > +static int nct7363_init_chip(struct nct7363_data *data)
> > +{
> > +     u32 func_config =3D 0;
> > +     int i, ret;
> > +
> > +     /* Pin Function Configuration */
> > +     for (i =3D 0; i < NCT7363_PWM_COUNT; i++) {
> > +             if (data->pwm_mask & BIT(i))
> > +                     func_config |=3D PWM_SEL(i);
> > +             if (data->fanin_mask & BIT(i))
> > +                     func_config |=3D FANIN_SEL(i);
> > +     }
> > +
> > +     for (i =3D 0; i < 4; i++) {
> > +             ret =3D regmap_write(data->regmap, NCT7363_REG_FUNC_CFG_B=
ASE(i),
> > +                                VALUE_TO_REG(func_config, i));
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     /* PWM and FANIN Monitoring Enable */
> > +     for (i =3D 0; i < 2; i++) {
> > +             ret =3D regmap_write(data->regmap, NCT7363_REG_PWMEN_BASE=
(i),
> > +                                VALUE_TO_REG(data->pwm_mask, i));
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             ret =3D regmap_write(data->regmap, NCT7363_REG_FANINEN_BA=
SE(i),
> > +                                VALUE_TO_REG(data->fanin_mask, i));
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int nct7363_present_pwm_fanin(struct device *dev,
> > +                                  struct device_node *child,
> > +                                  struct nct7363_data *data)
> > +{
> > +     u8 fanin_ch[NCT7363_PWM_COUNT];
> > +     struct of_phandle_args args;
> > +     int ret, fanin_cnt;
> > +     u8 ch, index;
> > +
> > +     ret =3D of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
> > +                                      0, &args);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (args.args[0] >=3D NCT7363_PWM_COUNT)
> > +             return -EINVAL;
> > +     data->pwm_mask |=3D BIT(args.args[0]);
> > +
> > +     fanin_cnt =3D of_property_count_u8_elems(child, "tach-ch");
> > +     if (fanin_cnt < 1 || fanin_cnt > NCT7363_PWM_COUNT)
> > +             return -EINVAL;
> > +
> > +     ret =3D of_property_read_u8_array(child, "tach-ch", fanin_ch, fan=
in_cnt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (ch =3D 0; ch < fanin_cnt; ch++) {
> > +             index =3D fanin_ch[ch];
> > +             if (index >=3D NCT7363_PWM_COUNT)
> > +                     return -EINVAL;
> > +             data->fanin_mask |=3D BIT(index);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct regmap_config nct7363_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
>
> Your call to make, but this doesn't use regmap caching capabilities which
> might be really useful here. Most of the registers (all but the count and
> status registers, plus the gpio input registers if/when gpio support is
> added) are not volatile and could be cached.

ok, I'll add it in v6.

>
> > +};
> > +
> > +static int nct7363_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct device_node *child;
> > +     struct nct7363_data *data;
> > +     struct device *hwmon_dev;
> > +     int ret;
> > +
> > +     data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
> > +
> > +     data->regmap =3D devm_regmap_init_i2c(client, &nct7363_regmap_con=
fig);
> > +     if (IS_ERR(data->regmap))
> > +             return PTR_ERR(data->regmap);
> > +
> > +     mutex_init(&data->lock);
> > +
> > +     for_each_child_of_node(dev->of_node, child) {
> > +             ret =3D nct7363_present_pwm_fanin(dev, child, data);
> > +             if (ret) {
> > +                     of_node_put(child);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     /* Initialize the chip */
> > +     ret =3D nct7363_init_chip(data);
> > +     if (ret)
> > +             return ret;
> > +
> > +     hwmon_dev =3D
> > +             devm_hwmon_device_register_with_info(dev, client->name, d=
ata,
> > +                                                  &nct7363_chip_info, =
NULL);
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static struct i2c_driver nct7363_driver =3D {
> > +     .class =3D I2C_CLASS_HWMON,
> > +     .driver =3D {
> > +             .name =3D "nct7363",
> > +             .of_match_table =3D nct7363_of_match,
> > +     },
> > +     .probe =3D nct7363_probe,
> > +     .id_table =3D nct7363_id,
> > +};
> > +
> > +module_i2c_driver(nct7363_driver);
> > +
> > +MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
> > +MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
> > +MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
> > +MODULE_LICENSE("GPL");

