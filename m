Return-Path: <linux-kernel+bounces-342619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845379890FE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E641C20A1F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4914F135;
	Sat, 28 Sep 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNixr7Xf"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560E3C0C;
	Sat, 28 Sep 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727546710; cv=none; b=EJ8uKCUY+OKFZ/pHh/M8zCujyDTyU+z3UhLcJ2FNu2ZEJ2LnrB2Owk97iqtqQIgMJztkn62KrJiYa0tlUDmzhxwmP2dRzA2ECFwxDHcPtHktKRYz38CqY+G0slBwX9p5HleY0mwdJuAypPoC7mPbQ54XkTsXlXOkmZG6Hze+Zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727546710; c=relaxed/simple;
	bh=yvkeI1Lrp1XfVt9qUvRiksR9i6gQx9z60t0ui+jgy0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpZxLX7+jG741vEwoTxhC3D4DDWW0JaL8MTgw42CjeXcE1pO3NKt6UH2P/2fWLCMg8e6uzKPWlesL4l1KPMXD2V5stkzS9jOu4vhcOn3wU9Es4/GvziwWFOjTvNtG2TeIhQChzOt729cvmWU79xB2OUrAjvKFDvwjtEUXXMG4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNixr7Xf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so4112758a12.2;
        Sat, 28 Sep 2024 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727546706; x=1728151506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBd1EdC6KnvZObHS9/JtjvKZht/tzJLxuXszVZyBpSg=;
        b=hNixr7Xf5AntKcbWdMXF40E1EAWcJJXpPk05tSaB2nWnbIPhR4Z/hhAps3Q28Vo95D
         ZHkzp7F1ei9TT8t2oDFE0bRRdx0Of6C2j5SMIuUZ6WIZnXapJsQpyPkmqAiIwqJokY6k
         +8Hh2kYPPbnfR40WVcuiY3B62c02NaLonZVHrqt46tjTuiU8/ssyBrWWQk73MU3kNIeO
         8Sue/JU2Ff8SpCfeO5V3MqWAPXh0J7dLnH3wmJJSgFsTnH8wXzzNQH8qGJDZdYB0Pl27
         aaA86BBLn89KBm+NGRmDXCIi+pH/evNogmfwiX5EEOAyoAzWTv5dJ1pZ+c6xkMav5zyS
         zZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727546706; x=1728151506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBd1EdC6KnvZObHS9/JtjvKZht/tzJLxuXszVZyBpSg=;
        b=HxoA7A8b4ORI+yKTw2Xs6ZcEdCCh/OvHJdP2wgZ3s1Tay6aI/MQzuuNI9N0mlJHYKE
         CGjVjiqDFqbiUHiknXf3NwhllPHMKqJbkarBi0XqEnenUZYvjKQpfG3uxioGXiAyXMtu
         JKxNCuYAm5A6T10evJfeWzD0J60duvg5NM/qQZ8Xk7UQvXfZgx0GhKtTuI45l/qNtUnD
         KrJeqBBGHc2pT3JiFfSPXHBbSAAmZn9xCUSGB+Oapu9e6zIYXXtfuCAMOX7BLnqGgS3Y
         Q/xf4jvfqXAPxODS0kAjAkQHkjdq1/G3KGwi5rOerWYh2JMuShkB/sydiKs+YixltMFM
         Urow==
X-Forwarded-Encrypted: i=1; AJvYcCUKc1JU6p/MGjhVJU/vhqgM+Mu4Mk2GPwzE2Jm+H20ONgLAh+avENXUIRiieh1b68lUnTFdFY9zIUXmkSM=@vger.kernel.org, AJvYcCUrXwsMPzhFQn5ERCKFppneUA8TlDGn3UUjmEi3xEhJhSNL1WnTtvDCYO8XLzFktfAx3fuKJ2n7UNVfv9Evgpz1uc4QIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQR6kj5IJpRGoPV6kj/kWyihLoJNqXG5K8gaUEsV8dqrE5ufz
	vB1CL1vBDNXzNZqmIRv54FMk0oWne2z8ecHG1CaMjbgyHFdCOw+pUPEAfdXeE403PAgmXCDhLLK
	HnEZANSpLdxCQP+FBOU5toxGa2Bc=
X-Google-Smtp-Source: AGHT+IEn5x/YlvLzo3Jw3iTX+sO39V8v9oRKjH7bbkGnNeIe2Ufv2TD1uZD6KfcX0OuDVlca2is0wubYPeI1wL1RC0Y=
X-Received: by 2002:a05:6402:40c5:b0:5c5:b7fd:16fa with SMTP id
 4fb4d7f45d1cf-5c8824d3c6cmr6783113a12.14.1727546706119; Sat, 28 Sep 2024
 11:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185345.3680-1-maccraft123mc@gmail.com>
 <20240927185345.3680-2-maccraft123mc@gmail.com> <4365cae6-33e2-4b86-aab9-0b9ad112e6b0@redhat.com>
In-Reply-To: <4365cae6-33e2-4b86-aab9-0b9ad112e6b0@redhat.com>
From: Maya Matuszczyk <maccraft123mc@gmail.com>
Date: Sat, 28 Sep 2024 20:04:29 +0200
Message-ID: <CAO_MupJTdo8+cpx2DHtC47WDQsFRVnB7xQFOmHiEQQzVmkFywg@mail.gmail.com>
Subject: Re: [PATCH 2/3] platform: arm64: Add driver for Lenovo Yoga Slim 7x's EC
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for taking a look at this driver.

sob., 28 wrz 2024 o 17:53 Hans de Goede <hdegoede@redhat.com> napisa=C5=82(=
a):
>
> Hi Maya,
>
> Thank you for your patch. It is great to so people working on supporting
> more ARM64 based laptop ECs.
>
> Note not a full review just one remark from a quick scan of the driver.
>
> On 27-Sep-24 8:53 PM, Maya Matuszczyk wrote:
> > This patch adds a basic driver for the EC in Qualcomm Snapdragon X1
> > Elite-based Lenovo Yoga Slim 7x.
> >
> > For now it supports only reporting that the AP is going to suspend and
> > the microphone mute button, however the EC seems to also support readin=
g
> > fan information, other key combinations and thermal data.
> >
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > ---
> >  MAINTAINERS                                 |   1 +
> >  drivers/platform/arm64/Kconfig              |  12 ++
> >  drivers/platform/arm64/Makefile             |   1 +
> >  drivers/platform/arm64/lenovo-yoga-slim7x.c | 202 ++++++++++++++++++++
> >  4 files changed, 216 insertions(+)
> >  create mode 100644 drivers/platform/arm64/lenovo-yoga-slim7x.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0d4bfdde166d..f689cba80fa3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12906,6 +12906,7 @@ LENOVO YOGA SLIM 7X EC DRIVER
> >  M:   Maya Matuszczyk <maccraft123mc@gmail.com>
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/platform/lenovo,yoga-slim7x-ec.=
yaml
> > +F:   drivers/platform/arm64/lenovo-yoga-slim7x.c
> >
> >  LETSKETCH HID TABLET DRIVER
> >  M:   Hans de Goede <hdegoede@redhat.com>
> > diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kc=
onfig
> > index f88395ea3376..9ceae50f8b4e 100644
> > --- a/drivers/platform/arm64/Kconfig
> > +++ b/drivers/platform/arm64/Kconfig
> > @@ -49,4 +49,16 @@ config EC_LENOVO_YOGA_C630
> >
> >         Say M or Y here to include this support.
> >
> > +config EC_LENOVO_YOGA_SLIM7X
> > +     tristate "Lenovo Yoga Slim 7x Embedded Controller driver"
> > +     depends on ARCH_QCOM || COMPILE_TEST
> > +     depends on I2C
> > +     help
> > +       Select this option to enable driver for the EC found in the Len=
ovo
> > +       Yoga Slim 7x.
> > +
> > +       This driver currently supports reporting input event for microp=
hone
> > +       mute button, and reporting device suspend to the EC so it can t=
ake
> > +       appropriate actions.
> > +
> >  endif # ARM64_PLATFORM_DEVICES
> > diff --git a/drivers/platform/arm64/Makefile b/drivers/platform/arm64/M=
akefile
> > index b2ae9114fdd8..70dfc1fb979d 100644
> > --- a/drivers/platform/arm64/Makefile
> > +++ b/drivers/platform/arm64/Makefile
> > @@ -7,3 +7,4 @@
> >
> >  obj-$(CONFIG_EC_ACER_ASPIRE1)        +=3D acer-aspire1-ec.o
> >  obj-$(CONFIG_EC_LENOVO_YOGA_C630) +=3D lenovo-yoga-c630.o
> > +obj-$(CONFIG_EC_LENOVO_YOGA_SLIM7X) +=3D lenovo-yoga-slim7x.o
> > diff --git a/drivers/platform/arm64/lenovo-yoga-slim7x.c b/drivers/plat=
form/arm64/lenovo-yoga-slim7x.c
> > new file mode 100644
> > index 000000000000..8f6d523395bc
> > --- /dev/null
> > +++ b/drivers/platform/arm64/lenovo-yoga-slim7x.c
> > @@ -0,0 +1,202 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 Maya Matuszczyk <maya.matuszczyk@gmail.com>
> > + */
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/lockdep.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/notifier.h>
> > +#include <linux/slab.h>
> > +#include <linux/input.h>
> > +//#include <linux/platform_data/lenovo-yoga-slim7x.h>
> > +
> > +// These are the registers that i know about available from SMBUS
> > +#define EC_IRQ_REASON_REG 0x05
> > +#define EC_SUSPEND_RESUME_REG 0x23
> > +#define EC_IRQ_ENABLE_REG 0x35
> > +#define EC_BACKLIGHT_STATUS_REG 0x83
> > +#define EC_MIC_MUTE_LED_REG 0x84
> > +#define EC_AC_STATUS_REG 0x90
> > +
> > +// Valid values for EC_SUSPEND_RESUME_REG
> > +#define EC_NOTIFY_SUSPEND_ENTER 0x01
> > +#define EC_NOTIFY_SUSPEND_EXIT 0x00
> > +#define EC_NOTIFY_SCREEN_OFF 0x03
> > +#define EC_NOTIFY_SCREEN_ON 0x04
> > +
> > +// These are the values in EC_IRQ_REASON_REG that i could find in DSDT
> > +#define EC_IRQ_MICMUTE_BUTTON 0x04
> > +#define EC_IRQ_FAN1_STATUS_CHANGE 0x30
> > +#define EC_IRQ_FAN2_STATUS_CHANGE 0x31
> > +#define EC_IRQ_FAN1_SPEED_CHANGE 0x32
> > +#define EC_IRQ_FAN2_SPEED_CHANGE 0x33
> > +#define EC_IRQ_COMPLETED_LUT_UPDATE 0x34
> > +#define EC_IRQ_COMPLETED_FAN_PROFILE_SWITCH 0x35
> > +#define EC_IRQ_THERMISTOR_1_TEMP_THRESHOLD_CROSS 0x36
> > +#define EC_IRQ_THERMISTOR_2_TEMP_THRESHOLD_CROSS 0x37
> > +#define EC_IRQ_THERMISTOR_3_TEMP_THRESHOLD_CROSS 0x38
> > +#define EC_IRQ_THERMISTOR_4_TEMP_THRESHOLD_CROSS 0x39
> > +#define EC_IRQ_THERMISTOR_5_TEMP_THRESHOLD_CROSS 0x3a
> > +#define EC_IRQ_THERMISTOR_6_TEMP_THRESHOLD_CROSS 0x3b
> > +#define EC_IRQ_THERMISTOR_7_TEMP_THRESHOLD_CROSS 0x3c
> > +#define EC_IRQ_RECOVERED_FROM_RESET 0x3d
> > +#define EC_IRQ_LENOVO_SUPPORT_KEY 0x90
> > +#define EC_IRQ_FN_Q 0x91
> > +#define EC_IRQ_FN_M 0x92
> > +#define EC_IRQ_FN_SPACE 0x93
> > +#define EC_IRQ_FN_R 0x94
> > +#define EC_IRQ_FNLOCK_ON 0x95
> > +#define EC_IRQ_FNLOCK_OFF 0x96
> > +#define EC_IRQ_FN_N 0x97
> > +#define EC_IRQ_AI 0x9a
> > +#define EC_IRQ_NPU 0x9b
> > +
> > +struct yoga_slim7x_ec {
> > +     struct i2c_client *client;
> > +     struct input_dev *idev;
> > +     struct mutex lock;
> > +};
> > +
> > +static irqreturn_t yoga_slim7x_ec_irq(int irq, void *data)
> > +{
> > +     struct yoga_slim7x_ec *ec =3D data;
> > +     struct device *dev =3D &ec->client->dev;
> > +     int val;
> > +
> > +     guard(mutex)(&ec->lock);
> > +
> > +     val =3D i2c_smbus_read_byte_data(ec->client, EC_IRQ_REASON_REG);
> > +     if (val < 0) {
> > +             dev_err(dev, "Failed to get EC IRQ reason: %d\n", val);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     switch (val) {
> > +     case EC_IRQ_MICMUTE_BUTTON:
> > +             input_report_key(ec->idev, KEY_MICMUTE, 1);
> > +             input_sync(ec->idev);
> > +             input_report_key(ec->idev, KEY_MICMUTE, 0);
> > +             input_sync(ec->idev);
> > +             break;
> > +     default:
> > +             dev_info(dev, "Unhandled EC IRQ reason: %d\n", val);
> > +     }
>
> I strongly suggest to use include/linux/input/sparse-keymap.h functionali=
ty
> here. This will make adding new keys a lot easier and will allow re-mappi=
ng
> codes from userspace.
>
> E.g. replace the whole switch-case with:
>
>         if (!sparse_keymap_report_event(ec->idev, val, 1, true))
>                 dev_info(dev, "Unhandled EC IRQ reason: %d\n", val);
>
> This takes care of mapping val -> KEY_MICMUTE, and doing all
> the reporting (after calling sparse_keymap_setup() with an appropriate
> keymap from probe())

Thank you for the suggestion. I'm not sure how to handle the non-key
related IRQs, like fan status changes.
Do you think they should be filtered out like this:
if (val =3D=3D 0x04 || (val >=3D 0x90 && val <=3D 0x97))

Best Regards,
Maya Matuszczyk.

>
>
>
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int yoga_slim7x_ec_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct yoga_slim7x_ec *ec;
> > +     int ret;
> > +
> > +     ec =3D devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
> > +     if (!ec)
> > +             return -ENOMEM;
> > +
> > +     mutex_init(&ec->lock);
> > +     ec->client =3D client;
> > +
> > +     ec->idev =3D devm_input_allocate_device(dev);
> > +     if (!ec->idev)
> > +             return -ENOMEM;
> > +     ec->idev->name =3D "yoga-slim7x-ec";
> > +     ec->idev->phys =3D "yoga-slim7x-ec/input0";
> > +     input_set_capability(ec->idev, EV_KEY, KEY_MICMUTE);
>
> Same here, please use sparse_keymap_setup() here to have it
> setup capabilities for all keys in your (to be defined)
>
> const struct key_entry yoga_slim7x_ec_keymap[]
>
> This way you only need to add new mappings in the keymap
> and then both the capability setting as well as the reporting
> in the irq-handler will be taken care of by the sparse-keymap
> helpers.
>
> Other then that the overall structure of the driver looks good
> (again this is not a full review, just a quick scan).
>
> Regards,
>
> Hans
>
>
>
>
>
> > +
> > +     ret =3D input_register_device(ec->idev);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to register input =
device\n");
> > +
> > +     ret =3D devm_request_threaded_irq(dev, client->irq,
> > +                                     NULL, yoga_slim7x_ec_irq,
> > +                                     IRQF_ONESHOT, "yoga_slim7x_ec", e=
c);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Unable to request irq\n")=
;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, EC_IRQ_ENABLE_REG, 0x01=
);
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "Failed to enable interrup=
ts\n");
> > +
> > +     return 0;
> > +}
> > +
> > +static void yoga_slim7x_ec_remove(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, EC_IRQ_ENABLE_REG, 0x00=
);
> > +     if (ret < 0)
> > +             dev_err(dev, "Failed to disable interrupts: %d\n", ret);
> > +}
> > +
> > +static int yoga_slim7x_ec_suspend(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, =
EC_NOTIFY_SCREEN_OFF);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, =
EC_NOTIFY_SUSPEND_ENTER);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static int yoga_slim7x_ec_resume(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     int ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, =
EC_NOTIFY_SUSPEND_EXIT);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, EC_SUSPEND_RESUME_REG, =
EC_NOTIFY_SCREEN_ON);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id yoga_slim7x_ec_of_match[] =3D {
> > +     { .compatible =3D "lenovo,yoga-slim7x-ec" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(of, yoga_slim7x_ec_of_match);
> > +
> > +static const struct i2c_device_id yoga_slim7x_ec_i2c_id_table[] =3D {
> > +     { "yoga-slim7x-ec", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, yoga_slim7x_ec_i2c_id_table);
> > +
> > +static DEFINE_SIMPLE_DEV_PM_OPS(yoga_slim7x_ec_pm_ops,
> > +             yoga_slim7x_ec_suspend,
> > +             yoga_slim7x_ec_resume);
> > +
> > +static struct i2c_driver yoga_slim7x_ec_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "yoga-slim7x-ec",
> > +             .of_match_table =3D yoga_slim7x_ec_of_match,
> > +             .pm =3D &yoga_slim7x_ec_pm_ops
> > +     },
> > +     .probe =3D yoga_slim7x_ec_probe,
> > +     .remove =3D yoga_slim7x_ec_remove,
> > +     .id_table =3D yoga_slim7x_ec_i2c_id_table,
> > +};
> > +module_i2c_driver(yoga_slim7x_ec_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("Lenovo Yoga Slim 7x Embedded Controller");
> > +MODULE_LICENSE("GPL");
>

