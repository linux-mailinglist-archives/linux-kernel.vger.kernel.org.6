Return-Path: <linux-kernel+bounces-252725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D493175C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00D9282310
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279018F2DC;
	Mon, 15 Jul 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iNFIgzxG"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB943A1A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056204; cv=none; b=CNgDJl2yfYmgxC9jUp7aJOIIH9aR5Wb7x0L9ujxV/Mk6867sWAaeq457IB71h9yIeKqOUxeqFjMln0+x6Ogxf5bRz95L97t/JmDcdQRLnwUB4M+GYPpO6joTx5XHYHioSl7nSTrlEFa98xzTTVE3jOjgyP1fhESFfyrov25NSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056204; c=relaxed/simple;
	bh=5m04BJF7q2LLRM88fx++maW87RKFuire28yNMM95G6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1zgRdXd0gZaCM2cJYXd0YWHy/e/92/1D3vXZvQvT0hqpF+BSY7KR9QNHhLB4WCZ/G5MIcE2Rc2f/agmBzZPN8mDU+AHg7pA8E5f/2usV3WaDE287i+ILevyhQ9XB/ruBlzuHxtD0caoSEVJYEqFC+IU5RDaHHwyxXCuGSweeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iNFIgzxG; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77abe5c709so545231066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721056201; x=1721661001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f3Cmwjo4+C8tOGQYXqfrgWl9Ct+rBShy7XPPD3iWCc=;
        b=iNFIgzxGQXjGYDVVwCCL/my180kbvlHZfq+Ja85TE+EadyNgWujWjvY8gen3WltJUu
         w3jaSv64Esw2d8+bxBnLV3crZdNQsggVoNKLHRmbzvdCjK9c+CiyVUW/cG1MGj1fjvC0
         LN+/zSDxsdg1rmk68ULBjnNJ5qyjvpru3DRwrAk0rpTtugyOnPzsocn3MUvGNSN8Jzqu
         uLcPEvIsiJlRwYXzWsSK812fOf2+Nc1VypHP3kvDdjtn7DAOUZkgBIVjOkT2zJTx3xzr
         9GmCjBllYJyUhNk1K+6YOIHxSO7NhDjb1H/khk40hU9L3q8Q38/TNdb7Jrgks5bnDeCV
         S9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721056201; x=1721661001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f3Cmwjo4+C8tOGQYXqfrgWl9Ct+rBShy7XPPD3iWCc=;
        b=KuGDU6ttPeogzJ6Fv0/IIN7DIk4U8VRdC4vBBK7gmhsnq9uSSIjI4E48cH+MhsVgXb
         d09W1OCqgOrG1K4PEKYAjlpvOww/2qQz+uxA7Q6IHkjS7p9lRrAArMl/3W5sUvME47g9
         zAno/qL13AVjeIdjAsY+Y3vlqfBFuS1k50k7gLbRQIHAwCQFmk/OhXq5+pqBdfPNBVrp
         xv4LPkwN4QRvxQD33E1dTFwpHMnLHjiWKUKTGEVGW0+DlJQ3n6NVFemN8dHX4/p6hre7
         K3Qy7e0tyJEPG0IOSBmAWZAXdxrvNDNoI6xtFArnE5AUPCrd3/BVCRSGDWTYXf6t5fmK
         09YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnz6nQbUrvjfwtjgi2uzuiBcdQLTpL9YAEiMXjO4E6MVLfwPxH0WhNCe2tX2t2nrz/i31cy54z4RYeO8bHsVn3RjrsGvS8ezlPU6OS
X-Gm-Message-State: AOJu0YzZUnkOxY0CD4HxygehgRQ49oWqswTESQ2OgAWFhor7jsCqYFTS
	e0gd5k0W/BN0lYuz+ihsKGFp8hdE448ppd008HktCS9tRTprdoLilnv1Tz/ApvY=
X-Google-Smtp-Source: AGHT+IEeZnfnZS7fhoaDyZlI+KobrOkLDMA4HhdGBKJDuPEj7OK4LoziT5drUXVzHyWTupraoQASsg==
X-Received: by 2002:a17:906:1786:b0:a6f:51d8:1963 with SMTP id a640c23a62f3a-a79e6a5c54emr3682066b.43.1721056200603;
        Mon, 15 Jul 2024 08:10:00 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3560sm218287366b.4.2024.07.15.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 08:10:00 -0700 (PDT)
Date: Mon, 15 Jul 2024 17:09:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Farouk Bouabid <farouk.bouabid@cherry.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/6] pwm: add mule pwm-over-i2c driver
Message-ID: <e7b3bfpvtrvt5g637yy7qxsbvfiylyzrjvwsro4hzp5t6cmeux@eqafx3k7oaks>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
 <20240529-buzzer_support-v1-2-fd3eb0a24442@cherry.de>
 <5hd7fndgivgusx76wq6mbvgefngd3tllqsfsk6pppbphchczte@ujagkep4miet>
 <25d71c19-6e94-477d-8d04-758015ca4b2c@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nnnntzeiyupavwi4"
Content-Disposition: inline
In-Reply-To: <25d71c19-6e94-477d-8d04-758015ca4b2c@cherry.de>


--nnnntzeiyupavwi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Quentin,

On Mon, Jul 15, 2024 at 02:16:15PM +0200, Quentin Schulz wrote:
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -425,6 +425,16 @@ config PWM_MICROCHIP_CORE
> > >   	  To compile this driver as a module, choose M here: the module
> > >   	  will be called pwm-microchip-core.
> > > +config PWM_MULE
> > > +	tristate "Mule PWM-over-I2C support"
> > > +	depends on I2C && OF
> >=20
> > It would be easy to drop the hard dependency on OF. Please do that.
> >=20
>=20
> Just being curious here, what would be the benefit?

Increasing easy compile coverage.

> [...]
>=20
> > > diff --git a/drivers/pwm/pwm-mule.c b/drivers/pwm/pwm-mule.c
> > > new file mode 100644
> > > index 000000000000..e8593a48b16e
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-mule.c
> > > @@ -0,0 +1,115 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Mule PWM-over-I2C controller driver
> > > + *
> > > + * Copyright (C) 2024 Theobroma Systems Design und Consulting GmbH
> >=20
> > Is there a publicly available datasheet? I guess not. (I ask because
> > adding a link there to such a document would be nice.)
> >=20
>=20
> Unfortunately no. It's also only part of our product line and there's no
> plan to start selling it standalone or selling the IP.
>=20
> > > + */
> > > +
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +struct mule_pwm {
> > > +	struct mutex lock;
> > > +	struct regmap *regmap;
> > > +};
> > > +
> > > +static const struct regmap_config pwm_mule_config =3D {
> > > +	.reg_bits =3D 8,
> > > +	.val_bits =3D 8,
> > > +};
> > > +
> > > +#define MULE_PWM_DCY_REG	0x0
> > > +#define MULE_PWM_FREQ_L_REG	0x1	/* LSB register */
> > > +#define MULE_PWM_FREQ_H_REG	0x2	/* MSB register */
> > > +
> > > +#define NANOSECONDS_TO_HZ(x) (1000000000UL/(x))
> >=20
> > Don't introduce such a macro if you only use it once. Having the
> > division in the function results in code that is easier to read (IMHO).
> >=20
> > > +static int pwm_mule_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > > +			      const struct pwm_state *state)
> > > +{
> > > +	struct mule_pwm *priv =3D pwmchip_get_drvdata(chip);
> > > +	u8 duty_cycle;
> > > +	u64 freq;
> > > +	int ret;
> > > +
> > > +	freq =3D NANOSECONDS_TO_HZ(state->period);
> > > +
> > > +	if (freq > U16_MAX) /* Frequency is 16-bit wide */ {
> > > +		dev_err(chip->dev,
> > > +			"Failed to set frequency: %llu Hz: out of 16-bit range\n", freq);
> > > +		return -EINVAL;
> > > +	}
> >=20
> > You're supposed to configure the biggest possible period not bigger than
> > the requested period. So this should be:
> >=20
> > 	/*
> > 	 * The period is configured using a 16 bit wide register holding
> > 	 * the frequency in Hz.
> > 	 */
> > 	unsigned int period =3D min_t(u64, state->period, NSEC_PER_SEC);
> > 	unsigned int freq =3D DIV_ROUND_UP(NSEC_PER_SEC, period);
> >=20
> > 	if (freq > U16_MAX)
> > 		return -EINVAL;
> >=20
> > > +	if (state->enabled)
> > > +		duty_cycle =3D pwm_get_relative_duty_cycle(state, 100);
> >=20
> > This is wrong for two reasons:
> >=20
> >   - It uses rounding to the nearest duty_cycle, however you're supposed
> >     to round down.
> >   - It uses the requested period instead of the real one.
> >=20
>=20
> I assume you want:
>=20
> unsigned int real_period =3D ((u64) NSEC_PER_SEC * 100) / freq;
>=20
> which rounds down?

Yes. And then to calculate the duty_cycle setting use real_period.

> > I wonder why the hardware doesn't use the whole 8 bits here.
> >=20
>=20
> It's even a 16b register that the HW uses. I guess we just went with the
> most human-friendly API :) I believe it's something we should be able to
> change in the FW before releasing if this is something that really makes
> sense. FYI, the register stores the number of clock ticks for the signal =
to
> be high, once reached, put it low (or the opposite). So it's necessarily a
> fraction of the clock frequency. 100% was easy because we know that every
> clock frequency we support is a multiple of 100 so there's no issue around
> rounding for example since we definitely do not want to do float maths in
> MCUs :)

Interesting perspective. I'd still go for using the register completely.

> > > +	else
> > > +		duty_cycle =3D 0;
> > > +
> > > +	mutex_lock(&priv->lock);
> >=20
> > If you use the guard helper, you don't need to resort to goto for error
> > handling.
> >=20
>=20
> I would have liked a link or more precise hint at what this "guard helper"
> was, but found something myself so here it is for anyone wondering:
>=20
> https://lwn.net/Articles/934679/
>=20
> Had never heard of that one before, neat!

Right. A conversion example is available at
https://lore.kernel.org/linux-pwm/2102fe8189bdf1f02ff3785b551a69be27a65af4.=
1719520143.git.u.kleine-koenig@baylibre.com/

> > > +	ret =3D regmap_bulk_write(priv->regmap, MULE_PWM_FREQ_L_REG, &freq,=
 2);
> > > +	if (ret) {
> > > +		dev_err(chip->dev,
> > > +			"Failed to set frequency: %llu Hz: %d\n", freq, ret);
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret =3D regmap_write(priv->regmap, MULE_PWM_DCY_REG, duty_cycle);
> > > +	if (ret)
> > > +		dev_err(chip->dev,
> > > +			"Failed to set duty cycle: %u: %d\n", duty_cycle, ret);
> >=20
> > Please document how the hardware behaves here in a "Limitations" section
> > as several other drivers do. Questions to answer include: Does it
> > complete a period when the parameters are updated? Can it happen that a
> > glitch is emitted while MULE_PWM_FREQ_[LH]_REG is updated but
> > MULE_PWM_DCY_REG isn't yet? Maybe updating MULE_PWM_FREQ_[LH]_REG isn't
> > even atomic? "Doesn't support disabling, configures duty_cycle=3D0 when
> > disabled is requested."
> >=20
>=20
> Updating MULE_PWM_FREQ_[LH]_REG is atomic (L is stored in SRAM until H reg
> is written, when LH are then written to the hardware IP).
>=20
> We use double-buffering (supported by the HW directly) for the period and
> comparator registers. I believe we still have a possible glitch during a
> small time-frame in the current version of the FW. Basically, trying to
> change the period AND duty cycle at the same time, the following could
> happen:
>=20
> - period A + duty-cycle AA
> - period B + duty-cycle AA
> - period B + duty-cycle BB
>=20
> Depending on what we consider a glitch, the second element in the list co=
uld
> be one. Even if we do a multibyte write to the actual HW, I'm not sure if
> this window can be eliminated.

I'd call that a glitch, yes.

> To give a bit more info on this, there are two possible flavors of the MC=
U,
> ATtiny 816 (datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/A=
Ttiny416-816-DataSheet-DS40001913B.pdf)
> and STM32F072CB (datasheet: https://www.st.com/content/ccc/resource/techn=
ical/document/reference_manual/c2/f8/8a/f2/18/e6/43/96/DM00031936.pdf/files=
/DM00031936.pdf/jcr:content/translations/en.DM00031936.pdf).
>=20
> FYI, on ATtiny, we use TCA in single-slope PWM generation mode and PERBUF
> and CMP2BUF as period and duty-cycle registers. On STM32, we use TIM15 in
> PWM mode and ARR and CCR1 as period and duty-cycle registers.

Wouldn't it be more natural with these to have duty in a base-2 register
for duty, in the assumption that your MCUs habe this, too?

> Re-reading both datasheets, and if I understand correctly, we could have
> glitch-free transitions by controlling the ARPE bit on STM32 and LUPD bit=
 on
> ATtiny816.
>=20
> @Farouk, please confirm but the above makes sense to me and I guess we co=
uld
> implement something in the FW. The question is how to detect if we want to
> change both the duty-cycle and period at the same time (we could decide to
> document this as a requirement for the API user though: "changes to
> MULE_PWM_FREQ_[LH]_REG are only applied when MULE_PWM_DCY_REG is written
> to").
>=20
> > Maybe write all three registers in a bulk write, then you might even be
> > able to drop the lock.
> >=20
>=20
> The bulk write wouldn't help with the glitch, but it's a good idea for
> getting rid of the lock.
>=20
> > Also please fail silently.
>=20
> Would dev_dbg() be fine here or would you rather see them gone entirely?

dev_dbg is silent by default, so that's fine for me.

Best regards
Uwe

--nnnntzeiyupavwi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaVO8EACgkQj4D7WH0S
/k5G8QgAo9i4tMthmPzEzcLp1iYlQD9EhlmLY3NS3iaEndMQdjs6Yn5g/X28jixs
S5EwD0OzoP2LziqgyOcsMqoQUZgtlZXcx7DyhzERsSPSAiGNUxRqTX4dIp4eqhaI
a5nL/kAEbSdl6cirkq97TUA6YSTjZlcFjYte9UkaARk6ZbWJpyAEcEg+4pjjs6OZ
cWrATM34nHeICcRxizIz6CakISP+g7H7fm1sUyoILDOlxS3mjbsrLOm4cbERuoKI
I+PvVIVwSJJ8ulWXXCeXJc6ilOYTH5NPJTkZG81AZT6PO4vs+6mMQMPX3Y+0d4cZ
E4TZB++66HrjjDhuL5mlJcammYkJng==
=wgn2
-----END PGP SIGNATURE-----

--nnnntzeiyupavwi4--

