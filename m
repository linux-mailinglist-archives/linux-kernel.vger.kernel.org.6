Return-Path: <linux-kernel+bounces-322769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3BC972D90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD551F2618C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB142188CBB;
	Tue, 10 Sep 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JIqypaoK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE018C021
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960289; cv=none; b=HI5bwr6F86ft0sbUy5ZOm/ocqjibAObkVLvG0rZ8Fivj2FZ3aM0cN9IWyiXth0j3qmgC5dnhS9Y/gBtSbS50vw+5bhSBYaBBiox/7LjE4OF6C8L0Zygbex3exORI8BIXYnuHPPcRCejNqTDQkSPhXSPLZoQlqFVX25E2HtTGG+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960289; c=relaxed/simple;
	bh=GtCH3fMWibSCKLfoQjedVjdONcR2SIY5mPN835ZqlOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEvBwytfbRoRBUIQ2LQQn/CoDsuxVIGA0rn1YNiwSTTPXLpQRusoTM0nsGgQTKkn7aSb1Qsvuo6snxG7JgbJtyVp43QCaqythklF3zVk4x7C8YTKVQj2LP2ul7X/58pyl0BT6sQlKLngUeIrNjFKOqD03fCExEd7sx3Yic46XmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JIqypaoK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so12915395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725960285; x=1726565085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2EZDy+hMC59lroXIhAbsWa5ogn7U/Sr5yQwHmuIwEE=;
        b=JIqypaoKVuntZ0EHoo+Ls/WOrTz0qTA587EBBY0IJvLL3zv1Jva8kCg57ZLiEvnVgI
         MrFSZd/0uvpsJiARiXCb3BCZ9Dueo6rO7PyJ9vOhCbw8FuylQ+ScRT9fp2qCvDOd/tPc
         KlHIGFy4JuuwdyAxxr/9m8S6li+f/2VXus1OYYQ7K3sPU71HQGDTMsrBNL1l8G7Qc1j+
         0wpPnwU0LfjvQyjjMbwlqcG7MAWp86Tp94xOY09VT0SgZdjo8bPfnUhvoumuD5rWN5id
         cTRJgx3OfhulAxAnJRioOjN/IjLSLxOE6iS37V8PFgOPJrkaHgKZ+in2jKH7XW27cfnk
         QvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725960285; x=1726565085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2EZDy+hMC59lroXIhAbsWa5ogn7U/Sr5yQwHmuIwEE=;
        b=M5XNLlM/NFU3uaGQlhOsZK8Ck9fVOwlAn5QDyvTMgBCwI7eVuSDmU64pmiFJojsloA
         s/dcouXgI59okl+nr/L1g0XvhkhJLxoFtjUZlkniQ917V6rDWBRwKx4GLXmxjDmtcEAO
         nHFh+ZKv2Crw6Z6gHIjkE4HkfFJjRFHnfx3+7IOqJfctich+aiGAyehhYbsGHBeAGaXa
         E+EAk5Y291wTKCp/qzbxL+EJUt6Ql1pedProEzdI7DyaYvitQ3tnS5PZVZL3a48RcoPA
         N3ZkYfpqHQP9Et+8pEnDvfgSzSt3X8U5sEMLY4YpkYQjA0YxRYbR9b/YEPOjG2PAb1N8
         /8yA==
X-Forwarded-Encrypted: i=1; AJvYcCUBh7mVFKU9FooY+hf9fh+MWYHPQH3r+Dg9M5GOCYYoz+FeFinwMluA9fYHTKgjtFt7l2V6YKHLqvpdObw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXfSj7OBNWe/uMangGjM7htBZd/i8n1pGmGjcEUxgAfz+lmoY
	wkpc9tGU+Orko4xm6B/22GyUqM5l57J+zW1WlP/H5YuLW4vdzRbTpO1HYRHJ9rQ=
X-Google-Smtp-Source: AGHT+IFgEVvxo6V0XlA1XZ1lF7peo1gnN7qU5esmA0e2wHEU2FubptQyog3D1XIvs1KfOm6ubVEQvA==
X-Received: by 2002:a05:600c:5cc:b0:42c:a89e:b0e6 with SMTP id 5b1f17b1804b1-42ca89eb69cmr83285775e9.11.1725960284787;
        Tue, 10 Sep 2024 02:24:44 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de0e2sm8294157f8f.105.2024.09.10.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:24:44 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:24:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <ygrnedi3bzyoqb74k34lkk6ddkpxdlck3hyppkg2mcli6c5qlg@i4kc766x2eak>
References: <20240802154408.135632-1-dima.fedrau@gmail.com>
 <20240802154408.135632-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pyc5ssbuitvdkuuv"
Content-Disposition: inline
In-Reply-To: <20240802154408.135632-3-dima.fedrau@gmail.com>


--pyc5ssbuitvdkuuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 02, 2024 at 05:44:08PM +0200, Dimitri Fedrau wrote:
> The MC33XS2410 is a four channel high-side switch. Featuring advanced
> monitoring and control function, the device is operational from 3.0 V to
> 60 V. The device is controlled by SPI port for configuration.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/pwm/Kconfig          |  12 +
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-mc33xs2410.c | 419 +++++++++++++++++++++++++++++++++++
>  3 files changed, 432 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mc33xs2410.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 1dd7921194f5..1e873a19a1cf 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -380,6 +380,18 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
> =20
> +config PWM_MC33XS2410
> +	tristate "MC33XS2410 PWM support"
> +	depends on OF
> +	depends on SPI
> +	help
> +	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
> +	  channel high-side switch. The device is operational from 3.0 V
> +	  to 60 V. The device is controlled by SPI port for configuration.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-mc33xs2410.
> +
>  config PWM_MESON
>  	tristate "Amlogic Meson PWM driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 90913519f11a..b9b202f7fe7e 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MC33XS2410)	+=3D pwm-mc33xs2410.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> new file mode 100644
> index 000000000000..63e6a48b0d02
> --- /dev/null
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -0,0 +1,419 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + *
Please add a link to the manual here. I found
https://www.nxp.com/docs/en/data-sheet/MC33XS2410.pdf.

> + * Limitations:
> + * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
> + *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
> + *   - 2 Hz steps from 2 Hz to 128 Hz
> + *   - 8 Hz steps from 8 Hz to 512 Hz
> + *   - 32 Hz steps from 32 Hz to 2048 Hz
> + * - Cannot generate a 0 % duty cycle.
> + * - Always produces low output if disabled.
> + * - Configuration isn't atomic. When changing polarity, duty cycle or p=
eriod
> + *   the data is taken immediately, counters not being affected, resulti=
ng in a
> + *   behavior of the output pin that is neither the old nor the new stat=
e,
> + *   rather something in between.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#define MC33XS2410_GLB_CTRL		0x00
> +#define MC33XS2410_GLB_CTRL_MODE_MASK	GENMASK(7, 6)
> +#define MC33XS2410_GLB_CTRL_NORMAL_MODE	BIT(6)

I would have defined these as:

#define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
#define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MOD=
E, 1)

> +#define MC33XS2410_PWM_CTRL1		0x05
> +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT(x)
> +#define MC33XS2410_PWM_CTRL3		0x07
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x))
> +#define MC33XS2410_PWM_FREQ1		0x08
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_FREQ(x)		(MC33XS2410_PWM_FREQ1 + (x - 1))
> +#define MC33XS2410_PWM_FREQ_STEP_MASK	GENMASK(7, 6)
> +#define MC33XS2410_PWM_FREQ_COUNT_MASK	GENMASK(5, 0)
> +#define MC33XS2410_PWM_DC1		0x0c
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_DC(x)		(MC33XS2410_PWM_DC1 + (x - 1))
> +#define MC33XS2410_WDT			0x14
> +
> +#define MC33XS2410_WR			BIT(7)
> +#define MC33XS2410_RD_CTRL		BIT(7)
> +#define MC33XS2410_RD_DATA_MASK		GENMASK(13, 0)
> +
> +#define MC33XS2410_MIN_PERIOD_STEP0	31250000
> +#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_MIN_PERIOD_STEP(x)	(MC33XS2410_MIN_PERIOD_STEP0 >> (2=
 * x))
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >> (2=
 * x))

So=20
MC33XS2410_MIN_PERIOD_STEP(3) =3D 31250000 >> 6 which is mathematically
488281.25. I haven't thought deeply about it, but I wonder if that .25
is relevant in the calculation of the step to select.

> +
> +#define MC33XS2410_MAX_TRANSFERS	5
> +#define MC33XS2410_WORD_LEN		2
> +
> +struct mc33xs2410_pwm {
> +	struct spi_device *spi;
> +};
> +
> +static
> +inline struct mc33xs2410_pwm *to_pwm_mc33xs2410_chip(struct pwm_chip *ch=
ip)

personally I'd prefer to call this mc33xs2410_from_chip() or something
similar to have it use the same prefix as the other functions. But given
there is some inconsistency and other people feel strong here and
(rightly) claim this type of function is often called "to_*", I won't
insist.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> [...]
> +static u8 mc33xs2410_pwm_get_freq(u64 period)
> +{
> +	u8 step, count;
> +
> +	/*
> +	 * Check which step is appropriate for the given period, starting with
> +	 * the highest frequency(lowest period). Higher frequencies are
> +	 * represented with better resolution by the device. Therefore favor
> +	 * frequency range with the better resolution to minimize error
> +	 * introduced by the frequency steps.
> +	 */
> +
> +	switch (period) {
> +	case MC33XS2410_MIN_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(3=
):
> +		step =3D 3;
> +		break;
> +	case MC33XS2410_MAX_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(2=
):
> +		step =3D 2;
> +		break;
> +	case MC33XS2410_MAX_PERIOD_STEP(2) + 1 ... MC33XS2410_MAX_PERIOD_STEP(1=
):
> +		step =3D 1;
> +		break;
> +	case MC33XS2410_MAX_PERIOD_STEP(1) + 1 ... MC33XS2410_MAX_PERIOD_STEP(0=
):
> +		step =3D 0;
> +		break;
> +	}
> +
> +	count =3D DIV_ROUND_UP((u32)MC33XS2410_MAX_PERIOD_STEP(step), (u32)peri=
od);

It took me a while to verify that DIV_ROUND_UP is right here. The
reasoning is that a higher count results in a higher frequency and so a
smaller period.

> +	return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
> +	       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count - 1);
> +}
> +
> +static u64 mc33xs2410_pwm_get_period(u8 reg)
> +{
> +	u32 freq, code, steps;
> +
> +	/*
> +	 * steps:
> +	 *   - 0 =3D 0.5Hz
> +	 *   - 1 =3D 2Hz
> +	 *   - 2 =3D 8Hz
> +	 *   - 3 =3D 32Hz
> +	 * frequency =3D (code + 1) x steps.
> +	 *
> +	 * To avoid division in case steps value is zero we scale the steps

Technically you don't avoid a division, but "only" avoid loosing
precision in case you have to do (integer) division by 0.5.

> +	 * value for now by two and keep it in mind when calculating the period
> +	 * that we have doubled the frequency.

Maybe reflect that doubling in the variable naming? "doubled_steps"?

> +	 */
> +	steps =3D 1 << (FIELD_GET(MC33XS2410_PWM_FREQ_STEP_MASK, reg) * 2);
> +	code =3D FIELD_GET(MC33XS2410_PWM_FREQ_COUNT_MASK, reg);
> +	freq =3D (code + 1) * steps;
> +
> +	/* Convert frequency to period, considering the doubled frequency. */
> +	return DIV_ROUND_UP((u32)(2 * NSEC_PER_SEC), freq);
> +}
> +
> +static int mc33xs2410_pwm_get_relative_duty_cycle(u64 period, u64 duty_c=
ycle)
> +{
> +	/*
> +	 * duty_cycle cannot overflow and period is not zero, since this is
> +	 * guaranteed by the caller.
> +	 */
> +	duty_cycle *=3D 256;
> +	duty_cycle =3D div64_u64(duty_cycle, period);
> +
> +	return duty_cycle - 1;
> +}
> +
> +static void mc33xs2410_pwm_set_relative_duty_cycle(struct pwm_state *sta=
te,
> +						   u16 duty_cycle)
> +{
> +	if (!duty_cycle && !state->enabled)
> +		state->duty_cycle =3D 0;
> +	else
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)(duty_cycle + 1) * state->=
period, 256);

Why does !duty_cycle matter in the if condition. I would have expected

	if (!state->enabled)
		state->duty_cycle =3D 0;
	else
		state->duty_cycle =3D DIV_ROUND_UP_ULL....)

That cast to (u64) in the last line can be dropped.

> +}
> +
> +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410 =3D to_pwm_mc33xs2410_chip(chip);
> +	struct spi_device *spi =3D mc33xs2410->spi;
> +	u8 reg[4] =3D {
> +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_CTRL1,
> +			MC33XS2410_PWM_CTRL3
> +		    };
> +	bool ctrl[2] =3D { true, true };
> +	u64 period, duty_cycle;
> +	int ret, rel_dc;
> +	u16 val[4];
> +	u8 mask;
> +
> +	period =3D min(state->period, MC33XS2410_MAX_PERIOD_STEP(0));
> +	if (period < MC33XS2410_MIN_PERIOD_STEP(3) + 1)
> +		return -EINVAL;

That is only right because in the expression for
MC33XS2410_MIN_PERIOD_STEP(3) the shift results in a one being shifted
out. If there were only zeros, the right check would be

	if (period < MC33XS2410_MIN_PERIOD_STEP(3))

=2E That's a bit unfortunate because it's unintuitive and at first sight
I'd expect that MC33XS2410_MIN_PERIOD_STEP(3) is a possible period.

Hmm, you could only fix that by doing scaled math or a good code
comment.

> +	ret =3D mc33xs2410_read_regs(spi, &reg[2], &ctrl[0], &val[2], 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* frequency */
> +	val[0] =3D mc33xs2410_pwm_get_freq(period);
> +	/* Continue calculations with the possibly truncated period */
> +	period =3D mc33xs2410_pwm_get_period(val[0]);
> +
> +	/* duty cycle */
> +	duty_cycle =3D min(period, state->duty_cycle);
> +	rel_dc =3D mc33xs2410_pwm_get_relative_duty_cycle(period, duty_cycle);
> +	val[1] =3D rel_dc < 0 ? 0 : rel_dc;
> +
> +	/* polarity */
> +	mask =3D MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> +	val[2] =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> +		 (val[2] | mask) : (val[2] & ~mask);
> +
> +	/* enable output */
> +	mask =3D MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> +	val[3] =3D (state->enabled && rel_dc >=3D 0) ? (val[3] | mask) :
> +						   (val[3] & ~mask);
> +
> +	return mc33xs2410_write_regs(spi, reg, val, 4);
> +}

Best regards
Uwe

--pyc5ssbuitvdkuuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbgEFcACgkQj4D7WH0S
/k4lUgf/UQgWqYiXk1gBzM7WsrdJ2g+C7c9u7PNeJ7Qqhjh54bk+wRiQYzTKOc1I
5qik7LSphPl5qMNb5/rYpaUxrVd/+w4ufKVAVf4w4Sxs/vxVUtd8IkSWWoNNcbi0
8xHgYCdQzH53lsC1KJO4X9vWLii+g+TfDq+hjzxqXbTJ+74TC7CFfv5/SG/U2Q+u
OIh6SNDeVDepKiJgW44M+ouzGDAz/MFSP7lr85mRFyv0g2KvD/sMLtFfQb0cjtLm
1kObGY68EMOxhAMqkT1rUO4kZl44rihpEzFhCbgq7VAx1s/qUM5ezXD2nYnpyTk+
IzjRlJx9hXBuWr0PCxky34ks5yQXPg==
=ZP+r
-----END PGP SIGNATURE-----

--pyc5ssbuitvdkuuv--

