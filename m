Return-Path: <linux-kernel+bounces-375840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38BB9A9B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2871B1F238C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350C154BEB;
	Tue, 22 Oct 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C1mrNMrk"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E680BF8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583696; cv=none; b=YrhhlMS+L/oDWjgAU4aJ7Fy8D0GfWHlxDRjd16OnxJOQFZwa8zvVs5qjcDcJz/eub/xoxo8kI/TM6K5oosCJUNQqUv3fOB7Db+KMomjaVj62OCRx2PzMuNW55JGEPBI9wVVOrUquT+sQlFkydTLNzPXIKhDHsL21/Rda9IzIYPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583696; c=relaxed/simple;
	bh=9WM21p+RnWLh+ZhR6oWvDbmm7VDB++54Q3hivBG1jhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiJZiC71NRp5n5/PKntr/At4v9b2CSlE2Rm01k+JNlXTPERj/Wsm4qNPUUYGzfcnC692eZYI5pty5r90f7pOLKvvVHymP4I1i+ibeytmaqxpg8AjXAwaDxrOsNi1IStvhC29Z4TRefhuA9AFf7Jur8kMBmWeSCcm5n7WMoCzTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C1mrNMrk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so3780766f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729583692; x=1730188492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VggQ4c0vf2QRmX8HQVFvhCWXUlqPrtmhOWfaTKfZQIY=;
        b=C1mrNMrk5oZZdJ+PamLlbASDZrIMMBsWb/2FyJudZc5bm78epCRQi+xquT1BfunLnM
         Zlw6d/+6d9ick/ml29ScTThYppxt/KjSNrJvX8DwSb7w4x5Ex1cnfPGxMS/Hq08ZY3Nj
         G8egmTqh8vjv1H3byGFtZIkFzn1s7W63INqMJbbSL74ztGbrTf7+j0cwPYL/c8e0/m6I
         q/rJOs5MZVrwgLHqbE8TkU6Wi8MpXILcyNiCXmUsvxTq386Nzk5pTK6FfE++VoWZpssE
         UfmLiGW63pn0iYeuulcpEZG/G70cT2gqumrPLVA0zRE5Echdbv75A+KguXFui3P8UVat
         RmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729583692; x=1730188492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VggQ4c0vf2QRmX8HQVFvhCWXUlqPrtmhOWfaTKfZQIY=;
        b=I5SJqPaiut+aAqAyON7SvL20DrHKuggwrcNUEorfD0kk09Q+MJ+8PtF6JrjQ3nNoGY
         XK9Hli681GmAdNX/J2xlsUmH+5zIw/rSVSZWqEVhT3kfwXmtruT2nthBQ3HNwAyWkUyL
         yL5c8H9Yr8vUxHjWakO5lzgDiDTSmkjHMyA4eGEJl//rwh+q779Sk3D1vm1VV5A/l5ac
         ZxO6YVAkNqE57G5J4sk4aZWaFvU1glrgmkdlasqifXBkBaEn7b4bmU6FNKUMnlzUebjS
         +3Dvn9xAV9nGX5KRiwO49UnqYowdXgn+LYvOPyogg3zENwUKvalFm8RBb1DR8MzHu1B/
         wCaA==
X-Forwarded-Encrypted: i=1; AJvYcCVyifcM07GnD2PjzdsVYc1AU4XJ6fRmQffWHmK36BAiZpLY+Ag0syTjAhfyYgWeZlrV/5vnleNQ7jWISM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycYj2SJRqEalr5RXyxmfDTNq5gRSm73Y49kgctCmpXQcWEILGw
	Fj8AufGohHQcbL3GU/Y8Qd8YmX3Xh8eCgZExYXn1E4beA1shXTuHsI+Tq/5tGoQ=
X-Google-Smtp-Source: AGHT+IF5yWE4byH0MOm2aiQ8Eb3N24HZXpvdm77fwNAUd11/pIvQzT4oe8sm5ZTPV4mEfFDcFAX27A==
X-Received: by 2002:a5d:458e:0:b0:37d:4706:f728 with SMTP id ffacd0b85a97d-37ef21bb0aamr1243999f8f.50.1729583692268;
        Tue, 22 Oct 2024 00:54:52 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a3805esm6076755f8f.9.2024.10.22.00.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 00:54:51 -0700 (PDT)
Date: Tue, 22 Oct 2024 09:54:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qsbe7bb5heigo3df"
Content-Disposition: inline
In-Reply-To: <20240927125745.38367-3-dima.fedrau@gmail.com>


--qsbe7bb5heigo3df
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

On Fri, Sep 27, 2024 at 02:57:45PM +0200, Dimitri Fedrau wrote:
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> new file mode 100644
> index 000000000000..f9a334a5e69b
> --- /dev/null
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -0,0 +1,422 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + *
> + * Reference Manual : https://www.nxp.com/docs/en/data-sheet/MC33XS2410.pdf
> + *
> + * Limitations:
> + * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
> + *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
> + *   - 2 Hz steps from 2 Hz to 128 Hz
> + *   - 8 Hz steps from 8 Hz to 512 Hz
> + *   - 32 Hz steps from 32 Hz to 2048 Hz
> + * - Cannot generate a 0 % duty cycle.
> + * - Always produces low output if disabled.
> + * - Configuration isn't atomic. When changing polarity, duty cycle or period
> + *   the data is taken immediately, counters not being affected, resulting in a
> + *   behavior of the output pin that is neither the old nor the new state,
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
> +#define MC33XS2410_GLB_CTRL_MODE	GENMASK(7, 6)
> +#define MC33XS2410_GLB_CTRL_MODE_NORMAL	FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
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
> +#define MC33XS2410_MIN_PERIOD		488282
> +#define MC33XS2410_MAX_PERIOD_STEP0	2000000000
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_MAX_PERIOD_STEP(x)	(MC33XS2410_MAX_PERIOD_STEP0 >> (2 * x))

Nitpick: These register definition become easier to parse for a human if
you indent the RHS of register fields one tab further and add an empty
line between the definitions for different registers.

MC33XS2410_PWM_DC1 is only used once, I'd hard-code it into the
definition of MC33XS2410_PWM_DC.

The register fields [7:4] in MC33XS2410_PWM_CTRL3 are called PWM_ON4 ..
PWM_ON1. So your x in { 0 ... 3 } is wrong. (Luckily, having some x
range over { 0 ... 3 } and others orver { 1 ... 4 } is prone to error
and confusion.)

Also I'd drop all _MASK suffixes.

For MC33XS2410_MAX_PERIOD_STEP maybe use a different variable name than
for the others. For the register definitions the range is over hwpwm
(which might be a good name there?), for MC33XS2410_MAX_PERIOD_STEP it's
about MC33XS2410_PWM_FREQ_STEP.

> +#define MC33XS2410_MAX_TRANSFERS	5
> +#define MC33XS2410_WORD_LEN		2
> +
> +struct mc33xs2410_pwm {
> +	struct spi_device *spi;
> +};
> +
> +static inline struct mc33xs2410_pwm *mc33xs2410_from_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u8 *reg,
> +				u16 *val, bool *ctrl, int len)

Should len better be unsigned?

Unless I missed something all ctrl[x] are always identical. If so
represent that by a single bool.

> +{
> +	struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] = { { 0 } };
> +	u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> +	u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> +	int i, ret, reg_i, val_i;
> +
> +	if (!len)
> +		return 0;
> +
> +	if (read)
> +		len++;
> +
> +	if (len > MC33XS2410_MAX_TRANSFERS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < len; i++) {
> +		reg_i = i * MC33XS2410_WORD_LEN;
> +		val_i = reg_i + 1;
> +		if (read) {
> +			if (i < len - 1) {
> +				tx[reg_i] = reg[i];
> +				tx[val_i] = ctrl[i] ? MC33XS2410_RD_CTRL : 0;
> +				t[i].tx_buf = &tx[reg_i];
> +			}
> +
> +			if (i > 0)
> +				t[i].rx_buf = &rx[reg_i - MC33XS2410_WORD_LEN];
> +		} else {
> +			tx[reg_i] = reg[i] | MC33XS2410_WR;
> +			tx[val_i] = val[i];
> +			t[i].tx_buf = &tx[reg_i];
> +		}
> +
> +		t[i].len = MC33XS2410_WORD_LEN;
> +		t[i].cs_change = 1;

Not sure if MC33XS2410_WORD_LEN really improves readability here.

Why is this done using $len transfers, wouldn't a single one do (and
maybe be more performant and not rely on a spi controller that supports
cs_change)?

> +	}
> +
> +	t[len - 1].cs_change = 0;
> +
> +	ret = spi_sync_transfer(spi, &t[0], len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (read) {
> +		for (i = 0; i < len - 1; i++) {
> +			reg_i = i * MC33XS2410_WORD_LEN;
> +			val[i] = FIELD_GET(MC33XS2410_RD_DATA_MASK,
> +					   get_unaligned_be16(&rx[reg_i]));
> +		}
> +	}
> +
> +	return 0;
> +}
> [...]
> +static
> +int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, bool ctrl)

My personal opinion: Better break the line in the argument list or not
at all. Having a "static" on its own line looks ugly.

> +{
> +	return mc33xs2410_read_regs(spi, &reg, &ctrl, val, 1);
> +}
> [...]
> +static u64 mc33xs2410_pwm_get_period(u8 reg)
> +{
> [...]
> +	/* Convert frequency to period, considering the doubled frequency. */
> +	return DIV_ROUND_UP((u32)(2 * NSEC_PER_SEC), freq);

That u32 cast isn't needed.

> +}
> [...]
> +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +				const struct pwm_state *state)
> +{
> [...]
> +	/* frequency */
> +	val[0] = mc33xs2410_pwm_get_freq(period);
> +	/* Continue calculations with the possibly truncated period */
> +	period = mc33xs2410_pwm_get_period(val[0]);
> +
> +	/* duty cycle */
> +	duty_cycle = min(period, state->duty_cycle);
> +	rel_dc = mc33xs2410_pwm_get_relative_duty_cycle(period, duty_cycle);
> +	val[1] = rel_dc < 0 ? 0 : rel_dc;

Handling of the duty cycle is correct here, but misleading. I already
added a comment here that using val[1] = 0 if rel_dc < 0 is wrong and
just deleted it again after I saw (rel_dc >= 0) being used determining
the value for MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm). An explicit if block
would make this more obvious.

mc33xs2410_pwm_get_relative_duty_cycle() is simple enough and only used
once that I'd unroll it here.

> +	/* polarity */
> +	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> +	val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
> +		 (val[2] | mask) : (val[2] & ~mask);
> +
> +	/* enable output */
> +	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> +	val[3] = (state->enabled && rel_dc >= 0) ? (val[3] | mask) :
> +						   (val[3] & ~mask);
> +
> +	return mc33xs2410_write_regs(spi, reg, val, 4);
> +}
> +
> +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    struct pwm_state *state)
> +{
> [...]
> +	state->period = mc33xs2410_pwm_get_period(val[0]);
> +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> +	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);

No need to set state->duty_cycle = 0 if state->enabled is false. This is
another function I suggest to unroll as it hides more than it abstracts.

> +	return 0;
> +}
> +
> [...]
> +static int mc33xs2410_probe(struct spi_device *spi)
> +{
> [...]
> +	/* Transition to normal mode */
> +	ret = mc33xs2410_modify_reg(spi, MC33XS2410_GLB_CTRL,
> +				    MC33XS2410_GLB_CTRL_MODE,
> +				    MC33XS2410_GLB_CTRL_MODE_NORMAL);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to transition to normal mode\n");

What is the effect of this register write if the PWM was already setup
by the bootloader?

> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
> +
> +	return 0;
> +}

Best regards
Uwe

--qsbe7bb5heigo3df
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcXWkcACgkQj4D7WH0S
/k4pggf+ITkiznKkAONwWvcQeARTGI61rBi4viBWne+BA1bVj6e5H0qoLShziOko
n2skUg+vq4KcG7ic9kBghHnBDNPIU5op8l8GA/EtudpHZMmXUmhP1Q79xWHq+pJB
hjVppWUo4P/vB2SfSCxpwK2qIInaum7BNkNCPRrcWYFaVBxKz5SwE0wHIhbPuBNX
UTvoS6D1hsUWWlje+b3ysobFFYErFijkAQgyGuYFheNnNxpBkEmjQZdmFMLNJbU5
ykgOf8MTUL/kDUce/yrDAexlpWMb4vQY3beT4guDlVvzdbs29+qIv5C1jxmcXBY7
hCiIc+I5Fs9vu2qhAAtE7Ts+Y8dyoA==
=Q9ho
-----END PGP SIGNATURE-----

--qsbe7bb5heigo3df--

