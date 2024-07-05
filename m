Return-Path: <linux-kernel+bounces-242578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDE1928A13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCB81F2169F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FCF14D2B5;
	Fri,  5 Jul 2024 13:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vw02SvY2"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA108149DE4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187198; cv=none; b=dkIl/tWkDotiTgiF5NUr+8fZ1UMTqBTejaQkfWoK3jRefzexX+6IUIhrUp7uvgl4wDgWh//XmRaCfJKAUrrXyW/Sm14ptiQTcwMzL1T8q+jCSP9kZ+vzWGYAC1I2PtBd5+8TVuOkdTPU8liwoWGuWUl6Lopls4+ArWXQ59ICpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187198; c=relaxed/simple;
	bh=H41/QVobDRUt3UCZd9bYxapvX64v+UpmpxENiWV6leU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpIg0AN7KeFpjCnCfODsldm6nGn5jfss8z3ru6P5STg1qnSU8nP9k1kuzwJd4XCiLc4qp3uVd1CQoP6BdsCswoN1KgqgKO0kQ70DeCJauyqvMFG6m8OYccNH8LA3CAIoohp0nXTH0EuuEV9NNJ037o6Xp+0Pd3DicPSMlzuGdC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Vw02SvY2; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso1704580e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720187195; x=1720791995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rosnYyYrEz/8I1grVSmaLMftXU+a2KtyJAYICqi7Yx0=;
        b=Vw02SvY2GJry3LOvXQUvaVu+zdEsiWvrbwhkG7LsU04/uyOj8PIneTOVKt5/gohsuM
         pC8Scm4vu3jtTheNRgoacJ8qeskHhSUg3iDUND7bzUeQH+SShef4Uga4k7bwj6yTpcWS
         8mxBMUbbx/4wT5NJlNTX5xVgov+wfdc7X/EB6nwbr2po81emKshrlutX+gxuVvga2UAe
         xgv32Xyqb56Dbblzd6PzWYQ7HzpWC83oWCB7uM2AIhiJJuYNcwWUrm/Ja1TxMTsKSzXK
         LPlnyt3jYvbjGuWZN7tQszX9jYfNzhVTv5WC5N0R7pDGlP3DiKhBimkmfKT89w0pHT3S
         5CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720187195; x=1720791995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rosnYyYrEz/8I1grVSmaLMftXU+a2KtyJAYICqi7Yx0=;
        b=q3/zhrqZ6LPpD7dOb6DXIytT56CA0GSfN9Wl3P+zxT3KMfebjkF7m4schH4bd6fViD
         R1h27Qb5gcbX6nAjNAOnbwHynKv3WlIQQiQo7Fwxn1uqB+jlmpTOfL10isHQMDcf4J2j
         K4eOqDWAXmRFJZckeZm4eBpLFA9vTbDueYQf99S9J+aDpYR+D1bkFodPZMISBZbpIZwQ
         dgvhLjQDGDBsNXePmXK2+rtZnOEO2zWrvJmOG6rikj0r71lWYgf1TZ2G1pApwMt18V2l
         FMBMNUgXxIBbztCCsbaQNicijmbW+/OBxw9Gz2CplVnkLWbZ/g3KmetnUhQOXUnZnz33
         fhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmXZ5C1TEwG8TpqJXJCT8hqdILeF77SECqHnHIKcmQQcHbSykFT1u9kWNLEoYFSs9sVy1Uqfbyi7dRsxXqwS7fgrYdiKzDxtgTZSjb
X-Gm-Message-State: AOJu0Yx3CCy0OhJky7UW7WHsENyiHpVHVB/XkJn00znib52QuOlOWC29
	ipc07gkj9u5BFA9KSk/5K0Su00Oep4imyJNeysC3On+YOnlQuR3CJ3KNdWI4jEeYt+JSu3PiSks
	1tyKLBhmc6kob/zAIeio+bCTPEec12CN24sD7kw==
X-Google-Smtp-Source: AGHT+IGFtaZLcKpk9WnyWUbqrexO6LMGZ7oxIvyiXRjOv1dtSZqOgTzlknrAacjU7SDBMuCr2tIXZMV4hVpg3lYpG6E=
X-Received: by 2002:a19:434c:0:b0:52e:7f18:176b with SMTP id
 2adb3069b0e04-52ea061a90dmr3411655e87.11.1720187194997; Fri, 05 Jul 2024
 06:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705-pwrseq-v1-0-31829b47fc72@amlogic.com> <20240705-pwrseq-v1-2-31829b47fc72@amlogic.com>
In-Reply-To: <20240705-pwrseq-v1-2-31829b47fc72@amlogic.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 5 Jul 2024 15:46:24 +0200
Message-ID: <CAMRc=MeZvHV-iOSTcaki=+8_j2Uqm_qpY3b1V15o9K0zefy+hw@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: sequenceing: Add power sequence for Amlogic
 WCN chips
To: yang.li@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:13=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Add power sequence for Bluetooth and Wi-Fi respectively, including chip_e=
n
> pull-up and bt_en pull-up, and generation of the 32.768 clock.
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  drivers/power/sequencing/Kconfig          |   7 +
>  drivers/power/sequencing/Makefile         |   1 +
>  drivers/power/sequencing/pwrseq-aml-wcn.c | 209 ++++++++++++++++++++++++=
++++++
>  3 files changed, 217 insertions(+)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index c9f1cdb66524..65d3b2c20bfb 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -26,4 +26,11 @@ config POWER_SEQUENCING_QCOM_WCN
>           this driver is needed for correct power control or else we'd ri=
sk not
>           respecting the required delays between enabling Bluetooth and W=
LAN.
>
> +config POWER_SEQUENCING_AML_WCN
> +       tristate "Amlogic WCN family PMU driver"
> +       default m if ARCH_MESON
> +       help
> +         Say Y here to enable the power sequencing driver for Amlogic
> +         WCN Bluetooth/WLAN chipsets.
> +
>  endif
> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing=
/Makefile
> index 2eec2df7912d..32706daf8f0f 100644
> --- a/drivers/power/sequencing/Makefile
> +++ b/drivers/power/sequencing/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_POWER_SEQUENCING)          +=3D pwrseq-core.=
o
>  pwrseq-core-y                          :=3D core.o
>
>  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)        +=3D pwrseq-qcom-wcn.o
> +obj-$(CONFIG_POWER_SEQUENCING_AML_WCN) +=3D pwrseq-aml-wcn.o
> diff --git a/drivers/power/sequencing/pwrseq-aml-wcn.c b/drivers/power/se=
quencing/pwrseq-aml-wcn.c
> new file mode 100644
> index 000000000000..6f5bfcf60b9c
> --- /dev/null
> +++ b/drivers/power/sequencing/pwrseq-aml-wcn.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
> +/*
> + * Copyright (C) 2024 Amlogic, Inc. All rights reserved
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/gpio.h>

Please see line 5 in this file.

> +#include <linux/of_gpio.h>

You don't need this either.

> +#include <linux/platform_device.h>
> +#include <linux/pwrseq/provider.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +struct pwrseq_aml_wcn_ctx {
> +       struct pwrseq_device *pwrseq;
> +       int bt_enable_gpio;
> +       int chip_enable_gpio;
> +       struct clk *lpo_clk;
> +       unsigned int pwr_count;
> +};
> +
> +static DEFINE_MUTEX(pwrseq_lock);
> +

Why is this global?

> +static int pwrseq_aml_wcn_chip_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_aml_wcn_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +       int err;
> +
> +       mutex_lock(&pwrseq_lock);

Please use guard() from linux/cleanup.h.

> +       if (ctx->pwr_count =3D=3D 0) {
> +               gpio_request(ctx->chip_enable_gpio, "chip-enable-gpios");
> +               gpio_direction_output(ctx->chip_enable_gpio, 1);
> +               gpio_free(ctx->chip_enable_gpio);

Not only are these legacy APIs but they are also used wrong. You
almost never want to release the GPIO after setting the direction as
someone else may grab it and use it.

> +
> +               if (!IS_ERR(ctx->lpo_clk)) {
> +                       err =3D clk_prepare_enable(ctx->lpo_clk);
> +                       if (err) {
> +                               mutex_unlock(&pwrseq_lock);
> +                               return err;
> +                       }
> +               }
> +       }
> +
> +       ctx->pwr_count++;
> +       mutex_unlock(&pwrseq_lock);
> +       return 0;
> +}
> +
> +static int pwrseq_aml_wcn_chip_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_aml_wcn_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       mutex_lock(&pwrseq_lock);
> +       if (--ctx->pwr_count =3D=3D 0) {
> +               gpio_request(ctx->chip_enable_gpio, "chip-enable-gpios");
> +               gpio_direction_output(ctx->chip_enable_gpio, 0);
> +               gpio_free(ctx->chip_enable_gpio);
> +
> +               if (!IS_ERR(ctx->lpo_clk))
> +                       clk_disable_unprepare(ctx->lpo_clk);
> +       }
> +
> +       mutex_unlock(&pwrseq_lock);
> +       return 0;
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_aml_wcn_chip_power_unit_data=
 =3D {
> +       .name =3D "chip-enable",
> +       .enable =3D pwrseq_aml_wcn_chip_enable,
> +       .disable =3D pwrseq_aml_wcn_chip_disable,
> +};
> +
> +static const struct pwrseq_unit_data *pwrseq_aml_wcn_unit_deps[] =3D {
> +       &pwrseq_aml_wcn_chip_power_unit_data,
> +       NULL
> +};
> +
> +static int pwrseq_aml_wcn_bt_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_aml_wcn_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       gpio_request(ctx->bt_enable_gpio, "bt-enable-gpios");
> +       gpio_direction_output(ctx->bt_enable_gpio, 1);
> +       gpio_free(ctx->bt_enable_gpio);
> +
> +       /* wait 100ms for bluetooth controller power on  */
> +       msleep(100);
> +
> +       return 0;
> +}
> +
> +static int pwrseq_aml_wcn_bt_disable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_aml_wcn_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +
> +       gpio_request(ctx->bt_enable_gpio, "bt-enable-gpios");
> +       gpio_direction_output(ctx->bt_enable_gpio, 0);
> +       gpio_free(ctx->bt_enable_gpio);
> +
> +       return 0;
> +}
> +
> +static const struct pwrseq_unit_data pwrseq_aml_wcn_bt_unit_data =3D {
> +       .name =3D "bluetooth-enable",
> +       .deps =3D pwrseq_aml_wcn_unit_deps,
> +       .enable =3D pwrseq_aml_wcn_bt_enable,
> +       .disable =3D pwrseq_aml_wcn_bt_disable,
> +};
> +
> +static const struct pwrseq_unit_data pwrseq_aml_wcn_wlan_unit_data =3D {
> +       .name =3D "wlan-enable",
> +       .deps =3D pwrseq_aml_wcn_unit_deps,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_aml_wcn_bt_target_data =3D=
 {
> +       .name =3D "bluetooth",
> +       .unit =3D &pwrseq_aml_wcn_bt_unit_data,
> +};
> +
> +static const struct pwrseq_target_data pwrseq_aml_wcn_wlan_target_data =
=3D {
> +       .name =3D "wlan",
> +       .unit =3D &pwrseq_aml_wcn_wlan_unit_data,
> +};
> +
> +static const struct pwrseq_target_data *pwrseq_aml_wcn_targets[] =3D {
> +       &pwrseq_aml_wcn_bt_target_data,
> +       &pwrseq_aml_wcn_wlan_target_data,
> +       NULL
> +};
> +
> +static int pwrseq_aml_wcn_match(struct pwrseq_device *pwrseq,
> +                                struct device *dev)
> +{
> +       struct device_node *dev_node =3D dev->of_node;
> +
> +       if (!of_property_present(dev_node, "amlogic,wcn-pwrseq"))
> +               return 0;
> +

You must never reference the notion of power sequencing in the DT.
Please take a look at the pwrseq-qcom-wcn driver where we model the
PMU with its regulators and then parse them in match() to figure out
if we have the right thing or not.

> +       return 1;
> +}
> +
> +static int pwrseq_aml_wcn_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct pwrseq_aml_wcn_ctx *ctx;
> +       struct pwrseq_config config;
> +
> +       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->bt_enable_gpio =3D of_get_named_gpio(dev->of_node,
> +                                              "amlogic,bt-enable-gpios",=
 0);
> +       if (!gpio_is_valid(ctx->bt_enable_gpio))
> +               return dev_err_probe(dev, ctx->bt_enable_gpio,
> +                               "Failed to get the bt enable GPIO");
> +
> +       ctx->chip_enable_gpio =3D of_get_named_gpio(dev->of_node,
> +                                              "amlogic,chip-enable-gpios=
", 0);

You don't need the OF variant. Use the regular devm_gpiod_get(). You
also forgot to release it but the devres variant will take care of it.

> +       if (!gpio_is_valid(ctx->chip_enable_gpio))
> +               return dev_err_probe(dev, ctx->bt_enable_gpio,
> +                                       "Failed to get the chip enable GP=
IO");

Wat

> +
> +       ctx->lpo_clk =3D devm_clk_get_optional(dev, NULL);
> +       if (IS_ERR(ctx->lpo_clk))
> +               return dev_err_probe(dev, PTR_ERR(ctx->lpo_clk),
> +                               "Failed to get the clock source");
> +
> +       memset(&config, 0, sizeof(config));
> +
> +       config.parent =3D dev;
> +       config.owner =3D THIS_MODULE;
> +       config.drvdata =3D ctx;
> +       config.match =3D pwrseq_aml_wcn_match;
> +       config.targets =3D pwrseq_aml_wcn_targets;
> +
> +       ctx->pwr_count =3D 0;
> +       ctx->pwrseq =3D devm_pwrseq_device_register(dev, &config);
> +       if (IS_ERR(ctx->pwrseq))
> +               return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> +                                    "Failed to register the power sequen=
cer\n");
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id pwrseq_aml_wcn_of_match[] =3D {
> +       { .compatible =3D "amlogic,w155s2-pwrseq" },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, pwrseq_aml_wcn_of_match);
> +
> +static struct platform_driver pwrseq_aml_wcn_driver =3D {
> +       .driver =3D {
> +               .name =3D "pwrseq-aml_wcn",
> +               .of_match_table =3D pwrseq_aml_wcn_of_match,
> +       },
> +       .probe =3D pwrseq_aml_wcn_probe,
> +};
> +module_platform_driver(pwrseq_aml_wcn_driver);
> +
> +MODULE_AUTHOR("Yang Li <yang.li@amlogic.com>");
> +MODULE_DESCRIPTION("Amlogic WCN PMU power sequencing driver");
> +MODULE_LICENSE("GPL");
>
> --
> 2.42.0
>
>

Bart

