Return-Path: <linux-kernel+bounces-295466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E44959B58
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335BDB22EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8931531C1;
	Wed, 21 Aug 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nrxtjlz5"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE3166F26
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242256; cv=none; b=DwercM7bJceVunqmucsk5pdXzj7Ptrd4rQUZCoGOMIGiIJwUQ7cGgXZtNnHQYfkK9DpZWftsBbkYM4DOG0kU3Y2t5OIAUhM2cXZb2RYVznl6Eh/iTgSCpidTvt5mfY3OBAySYBixyanfoOqGUCfbR5AY4xq+GczgRv1hamEuIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242256; c=relaxed/simple;
	bh=90DV7vgQsFK8FZHaJgLFyNcHPdkwkkCxQakcq6qLXDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGZJ7pqVogiZZjU4DdqobAJFRlkkzl1aLYYdcEIYI0SoXD4PZM0hW1mkzwv3Lm/oaYxW+R+gma2mw/k0l7rZMMtTjzg73xi1i/g8UyZ920KVMXDLsBasmSn5ubEKNxF8YKpScyS0B9AGlegHYAGlN/6KNkBAtEYNopZKiZXCc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nrxtjlz5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3ce5bc7b4so43216021fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724242252; x=1724847052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yHzWp1sOOLJBG2rpaye/UjJHu6nz813TXVunEn05r4=;
        b=nrxtjlz5oNPQB1B1H+5VVmZ4uyLSzy4uE5m+ibtlHg/gfDoW3s6skvzD3fTcSeXcSN
         sPcEwK14YAtbFY5qUYzl8twl8dqBD0k8v+QTlLNXVHrnpEWZM91ll3qto0Hxk/JAAdy+
         F4WvVwcEdgcmPb6C1IdxUDUDPY7EoYnWtzDaptfXQKDUlmATeEjMjilApmG8ff50pL5c
         Y7BN60GeHSYOA/e+QofLY8ZIuhLCTb9gff6czgRVbUTaOiiG9JXHrafwv5XF1xgXezOX
         LUu4fbyngBD+JXNOLPE9YWWS7aRKg6lXW3M71FpmYdGTJPcq12uuzRrbNjHudZuL9Ri3
         4B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242252; x=1724847052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yHzWp1sOOLJBG2rpaye/UjJHu6nz813TXVunEn05r4=;
        b=jGca2FQYAFSsdcCRj3mw/6ojkeaWsiIGmf+dQnqDe6pz0NAK5+YaZBiq8euM492IXp
         95XtmZPKt5iRii14+l629nw2YznMpe9GzXlziNuD9l5GYhiMBZGKoVc3cqAg3ypcHCpM
         7SGd5fEevaS98GLnIbYGVnT5LnnrS5YjydehzLp5gO9NkDXpXwbe0PadaDK4iTCQoWgN
         wYPorod2gjCh8N9CjFq1iHWrFcKOOg6wcSrTKz4CVSQPLlnhPk1ndL4X2mPFQRYtMvFp
         YOt+c7Q4EbgpCew/pvmldYQk61TQtuv+WPtb2pS5r6vNZ2Q4dy7ac/Gg7kNCLWVVvXsl
         HuWg==
X-Forwarded-Encrypted: i=1; AJvYcCWk16eQfkhgEFJWZ7RG5/WM4i9HLJFUKcrCErwT59dEyacbnxM6p7aBqfZVt0FrLw9aeR1PLwtPfmVNbbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziWK8Q2z/G4ERPzv//eyv/yAZCvXtH/inNva+HIKO5yVgYSmqL
	oc7M1nz2/UgWRnefFhIMdZ4oIjGdXuidwg1CCHDawLFxZUNFDOh5G+Df6KhAvu/QQCAmNqQhqbg
	XmszCfkrW/w78gL1XHkNne/li5Orf7FulDX7ArQ==
X-Google-Smtp-Source: AGHT+IFQd2kjruvhC3lctBFn4rvBzxjgmNWpIa5DvTIX53/WjJS0NjpL2jBqsl2pP8QHAGLT03BX4igUOcRtL0XGp3o=
X-Received: by 2002:a05:651c:19ab:b0:2ef:2e6b:410e with SMTP id
 38308e7fff4ca-2f3f87e766bmr14423111fa.4.1724242251074; Wed, 21 Aug 2024
 05:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821070740.2378602-1-billy_tsai@aspeedtech.com> <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
In-Reply-To: <20240821070740.2378602-3-billy_tsai@aspeedtech.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 21 Aug 2024 14:10:38 +0200
Message-ID: <CAMRc=McaNo5hxEwJJhZSE8PWno5r7+9XLn-1iZoJkRfNHN8U0Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: Add G7 Aspeed gpio controller driver
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:07=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:
>
> In the 7th generation of the SoC from Aspeed, the control logic of the
> GPIO controller has been updated to support per-pin control. Each pin now
> has its own 32-bit register, allowing for individual control of the pin=
=E2=80=99s
> value, direction, interrupt type, and other settings.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/gpio/Kconfig          |   7 +
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpio-aspeed-g7.c | 831 ++++++++++++++++++++++++++++++++++
>  3 files changed, 839 insertions(+)
>  create mode 100644 drivers/gpio/gpio-aspeed-g7.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 58f43bcced7c..93f237429b92 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -172,6 +172,13 @@ config GPIO_ASPEED
>         help
>           Say Y here to support Aspeed AST2400 and AST2500 GPIO controlle=
rs.
>
> +config GPIO_ASPEED_G7
> +       tristate "Aspeed G7 GPIO support"
> +       depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say Y here to support Aspeed AST2700 GPIO controllers.
> +
>  config GPIO_ASPEED_SGPIO
>         bool "Aspeed SGPIO support"
>         depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 64dd6d9d730d..e830291761ee 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_GPIO_AMD_FCH)            +=3D gpio-amd-fch=
.o
>  obj-$(CONFIG_GPIO_AMDPT)               +=3D gpio-amdpt.o
>  obj-$(CONFIG_GPIO_ARIZONA)             +=3D gpio-arizona.o
>  obj-$(CONFIG_GPIO_ASPEED)              +=3D gpio-aspeed.o
> +obj-$(CONFIG_GPIO_ASPEED_G7)           +=3D gpio-aspeed-g7.o
>  obj-$(CONFIG_GPIO_ASPEED_SGPIO)                +=3D gpio-aspeed-sgpio.o
>  obj-$(CONFIG_GPIO_ATH79)               +=3D gpio-ath79.o
>  obj-$(CONFIG_GPIO_BCM_KONA)            +=3D gpio-bcm-kona.o
> diff --git a/drivers/gpio/gpio-aspeed-g7.c b/drivers/gpio/gpio-aspeed-g7.=
c
> new file mode 100644
> index 000000000000..dbca097de6ea
> --- /dev/null
> +++ b/drivers/gpio/gpio-aspeed-g7.c
> @@ -0,0 +1,831 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 Aspeed Technology Inc.
> + *
> + * Billy Tsai <billy_tsai@aspeedtech.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio/aspeed.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/hashtable.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +
> +#include <asm/div64.h>
> +
> +#define GPIO_G7_IRQ_STS_BASE 0x100
> +#define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
> +#define GPIO_G7_CTRL_REG_BASE 0x180
> +#define GPIO_G7_CTRL_REG_OFFSET(x) (GPIO_G7_CTRL_REG_BASE + (x) * 0x4)
> +#define GPIO_G7_OUT_DATA BIT(0)
> +#define GPIO_G7_DIR BIT(1)
> +#define GPIO_G7_IRQ_EN BIT(2)
> +#define GPIO_G7_IRQ_TYPE0 BIT(3)
> +#define GPIO_G7_IRQ_TYPE1 BIT(4)
> +#define GPIO_G7_IRQ_TYPE2 BIT(5)
> +#define GPIO_G7_RST_TOLERANCE BIT(6)
> +#define GPIO_G7_DEBOUNCE_SEL GENMASK(8, 7)
> +#define GPIO_G7_INPUT_MASK BIT(9)
> +#define GPIO_G7_IRQ_STS BIT(12)
> +#define GPIO_G7_IN_DATA BIT(13)
> +/*
> + * The configuration of the following registers should be determined
> + * outside of the GPIO driver.
> + */
> +#define GPIO_G7_PRIVILEGE_W_REG_BASE 0x810
> +#define GPIO_G7_PRIVILEGE_W_REG_OFFSET(x) (GPIO_G7_PRIVILEGE_W_REG_BASE =
+ ((x) >> 2) * 0x4)
> +#define GPIO_G7_PRIVILEGE_R_REG_BASE 0x910
> +#define GPIO_G7_PRIVILEGE_R_REG_OFFSET(x) (GPIO_G7_PRIVILEGE_R_REG_BASE =
+ ((x) >> 2) * 0x4)
> +#define GPIO_G7_IRQ_TARGET_REG_BASE 0xA10
> +#define GPIO_G7_IRQ_TARGET_REG_OFFSET(x) (GPIO_G7_IRQ_TARGET_REG_BASE + =
((x) >> 2) * 0x4)
> +#define GPIO_G7_IRQ_TO_INTC2_18 BIT(0)
> +#define GPIO_G7_IRQ_TO_INTC2_19 BIT(1)
> +#define GPIO_G7_IRQ_TO_INTC2_20 BIT(2)
> +#define GPIO_G7_IRQ_TO_SIO BIT(3)
> +#define GPIO_G7_IRQ_TARGET_RESET_TOLERANCE BIT(6)
> +#define GPIO_G7_IRQ_TARGET_W_PROTECT BIT(7)
> +
> +static inline u32 field_get(u32 _mask, u32 _val)
> +{
> +       return (((_val) & (_mask)) >> (ffs(_mask) - 1));
> +}
> +
> +static inline u32 field_prep(u32 _mask, u32 _val)
> +{
> +       return (((_val) << (ffs(_mask) - 1)) & (_mask));
> +}
> +
> +static inline void ast_write_bits(void __iomem *addr, u32 mask, u32 val)
> +{
> +       iowrite32((ioread32(addr) & ~(mask)) | field_prep(mask, val), add=
r);
> +}
> +
> +static inline void ast_clr_bits(void __iomem *addr, u32 mask)
> +{
> +       iowrite32((ioread32(addr) & ~(mask)), addr);
> +}

For all of the above and similar instances below - can you add the
aspeed prefix to symbols?

[snip]

> +
> +/*
> + * Note: The "value" register returns the input value sampled on the
> + *       line even when the GPIO is configured as an output. Since
> + *       that input goes through synchronizers, writing, then reading

Drop the leading tabs indentations from the comment.

[snip]

> +
> +       register_allocated_timer(gpio, offset, i);
> +       configure_timer(gpio, offset, i);
> +
> +out:
> +       raw_spin_unlock_irqrestore(&gpio->lock, flags);
> +

How about using scoped guards across the driver? You'll avoid such labels.

[snip]

> +
> +static int aspeed_gpio_g7_set_config(struct gpio_chip *chip, unsigned in=
t offset,
> +                                    unsigned long config)
> +{
> +       unsigned long param =3D pinconf_to_config_param(config);
> +       u32 arg =3D pinconf_to_config_argument(config);
> +
> +       if (param =3D=3D PIN_CONFIG_INPUT_DEBOUNCE)
> +               return set_debounce(chip, offset, arg);
> +       else if (param =3D=3D PIN_CONFIG_BIAS_DISABLE || param =3D=3D PIN=
_CONFIG_BIAS_PULL_DOWN ||
> +                param =3D=3D PIN_CONFIG_DRIVE_STRENGTH)
> +               return pinctrl_gpio_set_config(offset, config);
> +       else if (param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN || param =3D=3D=
 PIN_CONFIG_DRIVE_OPEN_SOURCE)
> +               /* Return -EOPNOTSUPP to trigger emulation, as per datash=
eet */
> +               return -EOPNOTSUPP;
> +       else if (param =3D=3D PIN_CONFIG_PERSIST_STATE)
> +               return aspeed_gpio_g7_reset_tolerance(chip, offset, arg);
> +

Please use a switch here like everyone else.

> +       return -EOPNOTSUPP;
> +}
> +
> +static void aspeed_gpio_g7_irq_print_chip(struct irq_data *d, struct seq=
_file *p)
> +{
> +       struct aspeed_gpio_g7 *gpio;
> +       int rc, offset;
> +
> +       rc =3D irqd_to_aspeed_gpio_g7_data(d, &gpio, &offset);
> +       if (rc)
> +               return;
> +
> +       seq_printf(p, dev_name(gpio->dev));
> +}
> +
> +static const struct irq_chip aspeed_gpio_g7_irq_chip =3D {
> +       .irq_ack =3D aspeed_gpio_g7_irq_ack,
> +       .irq_mask =3D aspeed_gpio_g7_irq_mask,
> +       .irq_unmask =3D aspeed_gpio_g7_irq_unmask,
> +       .irq_set_type =3D aspeed_gpio_g7_set_type,
> +       .irq_print_chip =3D aspeed_gpio_g7_irq_print_chip,
> +       .flags =3D IRQCHIP_IMMUTABLE,
> +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> +};
> +
> +static const struct aspeed_bank_props ast2700_bank_props[] =3D {
> +       /*     input      output   */
> +       { 1, 0x0fffffff, 0x0fffffff }, /* E/F/G/H, 4-GPIO hole */
> +       { 6, 0x00ffffff, 0x00ffffff }, /* Y/Z/AA */
> +       {},
> +};
> +
> +static const struct aspeed_gpio_g7_config ast2700_config =3D
> +       /*
> +        * ast2700 has two controllers one with 212 GPIOs and one with 16=
 GPIOs.
> +        * 216 for simplicity, actual number is 212 (4-GPIO hole in GPIOH=
)
> +        * We expect ngpio being set in the device tree and this is a fal=
lback
> +        * option.
> +        */
> +       {
> +               .nr_gpios =3D 216,
> +               .props =3D ast2700_bank_props,
> +       };
> +
> +static const struct of_device_id aspeed_gpio_g7_of_table[] =3D {
> +       {
> +               .compatible =3D "aspeed,ast2700-gpio",
> +               .data =3D &ast2700_config,
> +       },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_gpio_g7_of_table);
> +
> +static int __init aspeed_gpio_g7_probe(struct platform_device *pdev)
> +{
> +       const struct of_device_id *gpio_id;
> +       struct aspeed_gpio_g7 *gpio;
> +       int rc, banks, err;
> +       u32 ngpio;
> +
> +       gpio =3D devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +
> +       gpio->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(gpio->base))
> +               return PTR_ERR(gpio->base);
> +
> +       gpio->dev =3D &pdev->dev;
> +
> +       raw_spin_lock_init(&gpio->lock);
> +
> +       gpio_id =3D of_match_node(aspeed_gpio_g7_of_table, pdev->dev.of_n=
ode);

Please use device_get_match_data() and elsewhere use generic device
property getters instead of the specialized OF variants.

> +       if (!gpio_id)
> +               return -EINVAL;
> +
> +       gpio->clk =3D of_clk_get(pdev->dev.of_node, 0);
> +       if (IS_ERR(gpio->clk)) {
> +               dev_warn(&pdev->dev, "Failed to get clock from devicetree=
, debouncing disabled\n");
> +               gpio->clk =3D NULL;
> +       }
> +
> +       gpio->config =3D gpio_id->data;
> +
> +       gpio->chip.parent =3D &pdev->dev;
> +       err =3D of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpio)=
;
> +       gpio->chip.ngpio =3D (u16)ngpio;
> +       if (err)
> +               gpio->chip.ngpio =3D gpio->config->nr_gpios;
> +       gpio->chip.direction_input =3D aspeed_gpio_g7_dir_in;
> +       gpio->chip.direction_output =3D aspeed_gpio_g7_dir_out;
> +       gpio->chip.get_direction =3D aspeed_gpio_g7_get_direction;
> +       gpio->chip.request =3D aspeed_gpio_g7_request;
> +       gpio->chip.free =3D aspeed_gpio_g7_free;
> +       gpio->chip.get =3D aspeed_gpio_g7_get;
> +       gpio->chip.set =3D aspeed_gpio_g7_set;
> +       gpio->chip.set_config =3D aspeed_gpio_g7_set_config;
> +       gpio->chip.label =3D dev_name(&pdev->dev);
> +       gpio->chip.base =3D -1;
> +
> +       /* Allocate a cache of the output registers */
> +       banks =3D DIV_ROUND_UP(gpio->chip.ngpio, 32);
> +       gpio->dcache =3D devm_kcalloc(&pdev->dev, banks, sizeof(u32), GFP=
_KERNEL);
> +       if (!gpio->dcache)
> +               return -ENOMEM;
> +
> +       /* Optionally set up an irqchip if there is an IRQ */
> +       rc =3D platform_get_irq(pdev, 0);
> +       if (rc > 0) {
> +               struct gpio_irq_chip *girq;
> +
> +               gpio->irq =3D rc;
> +               girq =3D &gpio->chip.irq;
> +               gpio_irq_chip_set_chip(girq, &aspeed_gpio_g7_irq_chip);
> +               girq->chip->name =3D dev_name(&pdev->dev);
> +
> +               girq->parent_handler =3D aspeed_gpio_g7_irq_handler;
> +               girq->num_parents =3D 1;
> +               girq->parents =3D devm_kcalloc(&pdev->dev, 1, sizeof(*gir=
q->parents), GFP_KERNEL);
> +               if (!girq->parents)
> +                       return -ENOMEM;
> +               girq->parents[0] =3D gpio->irq;
> +               girq->default_type =3D IRQ_TYPE_NONE;
> +               girq->handler =3D handle_bad_irq;
> +               girq->init_valid_mask =3D aspeed_init_irq_valid_mask;
> +       }
> +
> +       gpio->offset_timer =3D devm_kzalloc(&pdev->dev, gpio->chip.ngpio,=
 GFP_KERNEL);
> +       if (!gpio->offset_timer)
> +               return -ENOMEM;
> +
> +       rc =3D devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);

Just return devm_gpiochip_add_data().

> +       if (rc < 0)
> +               return rc;
> +
> +       return 0;
> +}
> +
> +static struct platform_driver aspeed_gpio_g7_driver =3D {
> +       .driver =3D {
> +               .name =3D KBUILD_MODNAME,
> +               .of_match_table =3D aspeed_gpio_g7_of_table,
> +       },
> +};
> +
> +module_platform_driver_probe(aspeed_gpio_g7_driver, aspeed_gpio_g7_probe=
);

I see that it was done like this in other aspeed drivers but I would
need some explanation as to why you think it's needed here. You do get
some resources in probe() that may defer the probing of this driver
and this macro doesn't allow it. Unless you have a very good reason, I
suspect you want to use module_platform_driver() here instead.

> +
> +MODULE_DESCRIPTION("Aspeed G7 GPIO Driver");
> +MODULE_LICENSE("GPL");

MODULE_AUTHOR()?

Bart

> --
> 2.25.1
>

