Return-Path: <linux-kernel+bounces-250197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 906B192F514
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED473B22681
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2161BC3C;
	Fri, 12 Jul 2024 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jsOCNPzx"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948961B95B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720761894; cv=none; b=B4dbYSsls285sTSk0OhaWp8+VVR1yjP6SSWPFasg0uJ/rkRF9E1YhnR3UbtqhRL11IGn0YNoyPY03ev6FZMIgnqx1Sd9+HpRU236CSiuqrfY8PEgyNqmZ1RMu0zl4Tt1kd8t5u5niJrv/K0sdz8xayT5L6Le7xfVhaKzhUbDBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720761894; c=relaxed/simple;
	bh=XHfigyBjT+CgXGMlCvld9DMNDHAk27FSPXgPpwiz43o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG+83GGtQxDJCNt3PP6D6vo537yv5N37iTKglgCySyvG6qMY4NEUCkWqMODX2eR4t1+KdO+mjylA+1OD3x5FffncFGciboAyp++Imebb6qXaMS33DkkdaKLd57aj2QyETuxwDCfdYJ3OUfsWp51P/FE4FvwgHcHnz3CYAMg7d0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jsOCNPzx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c349bb81so192219366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720761891; x=1721366691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FGo+hSrAlPy13Ul/ZVnWIL7u/LbXO49zCpNTXIfAOyw=;
        b=jsOCNPzxIwQ0wiDhaIMKvWpBOKmmhsl4JNTaEHZZffd6Y8NIZntn8sNefb1CS0H5El
         2IqliBJ6g/PauXR4ubVKI93Bk27I9GMzBybjUWRSKlrblHvVjRfQvXC3mdBhIYo8vNtg
         6tqzt3Hibqy+jlt1FAMXetj4O2dogURZhTLtrsOqqwKyyl60n59tL/gyjHMKJsxYs01+
         91EruymJ/u11f+PsAbTnE46qe9oSbiQNReHBthdtF+jUS00VAUson4SYgzsh+gdNp/ko
         GxbPLXW2Dm1wbu3lTmPJuCNUs/5tMnTqBQtxXzggHBjrCheKOwy6NQvQuCmWDTw/hP9Q
         s7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720761891; x=1721366691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGo+hSrAlPy13Ul/ZVnWIL7u/LbXO49zCpNTXIfAOyw=;
        b=CJGJymxSwjgMQTb/eroz/xZByRF8vuVANkAvIZTnjoRS0ioaB3RLnrp4yTLRM01XcK
         KkvY36z8thtiHUZ4OQEArIyJjmCSvC82xHmtOaJIzgkYR7QhYRgdrLWMcZpk9v/FCVoY
         W/MUx9Pwf8Xbb8QzXNIhknlb5921Wyna+HIGri/ympsIC9odgErB1zTbYJo/p42BKKv0
         yd4Mm0S9+CrdXFdmj0Xh8lniZIAxbbCCGrMOZ9ObE31sUUZEbfcFKqTbZxmpBJqZ0W6I
         an+X/QgRIATQifBO5KgQVKeZlgPTWv9kGNwg2pXYNCCSxx2oKFAZz3BVsBqaAK92Z3wb
         hFQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHs06OsUI3wifTnlDOiA6PWHYdjlXQgHmVkVWEPahKcySvW7wKmsAd9v3ac8N69QEPeC3R7vBbOZjbr1jAPTMIN5Hg90uDDqrPrKnX
X-Gm-Message-State: AOJu0Ywg/j/C/ex0f2YODUuusmKL/GhLL6acY3yB618AtGPIsWf6XMfy
	osT3PCLkUqkBG6EiiQRkaVeG9TslDs+bqLppy2KsyXel8xKzl4k1H4YAYsIS6yk=
X-Google-Smtp-Source: AGHT+IEd96HjaarzC2ykB4hyN1Fc9UhtgUOEzJTAlsfbZc1qt4dSfkTHdoOS6/uDl2YbmzC9DkaZsg==
X-Received: by 2002:a17:906:28cf:b0:a77:e0ed:8c2 with SMTP id a640c23a62f3a-a780b89f6b5mr559350666b.71.1720761890635;
        Thu, 11 Jul 2024 22:24:50 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:d576:ed0d:77d7:71c7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a797f300b05sm193858066b.134.2024.07.11.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 22:24:50 -0700 (PDT)
Date: Fri, 12 Jul 2024 07:24:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
Message-ID: <2oyfx2i7bsadqmlqtmqhc2ee6vn4r7knfyq5kizgdjx3zpov6c@isiflqgza2gc>
References: <20240711234614.3104839-1-chris.packham@alliedtelesis.co.nz>
 <20240711234614.3104839-4-chris.packham@alliedtelesis.co.nz>
 <bd2b256b-5149-491a-a482-6e4488467fa5@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fbml44lxa55gm2fp"
Content-Disposition: inline
In-Reply-To: <bd2b256b-5149-491a-a482-6e4488467fa5@roeck-us.net>


--fbml44lxa55gm2fp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 09:37:29PM -0700, Guenter Roeck wrote:
> On 7/11/24 16:46, Chris Packham wrote:
> > By default the PWM duty cycle in hardware is 100%. On some systems this
> > can cause unwanted fan noise. Add the ability to specify the fan
> > connections and initial state of the PWMs via device properties.
> >=20
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> ...
> > +static int adt7475_pwm_properties_parse_reference_args(struct fwnode_h=
andle *fwnode,
> > +						       struct adt7475_pwm_config *cfg)
> > +{
> > +	int ret;
> > +	struct fwnode_reference_args args =3D {};
> > +	int freq_hz;
> > +	int duty;
> > +
> > +	ret =3D fwnode_property_get_reference_args(fwnode, "pwms", "#pwm-cell=
s", 0, 0, &args);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (args.nargs !=3D 4) {
> > +		fwnode_handle_put(args.fwnode);
> > +		return -EINVAL;
> > +	}
> > +
> > +	freq_hz =3D 1000000000UL / args.args[1];
> > +	duty =3D 255 / (args.args[1] / args.args[3]);
> > +
> You'll need to validate args.args[1] and args.args[3] to ensure that ther=
e are no
> divide by 0 errors.
>=20
> On a side note,
> 	a =3D b / (c / d) =3D=3D b / c * d (at least for d !=3D 0)
> Since the result is defined for d =3D=3D 0, you'd only have to make sure
> that args.args[1] > 0 and that the result for the duty cycle is <=3D 255.

On a side side note: Depending on the actual values it might be
beneficial to use

	b * d / c

instead. b * d might overflow, but in other cases (e.g. b =3D 7, c =3D 8, d
=3D 8) the resulting precision is much better.

Best regards
Uwe

--fbml44lxa55gm2fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaQvhwACgkQj4D7WH0S
/k5O9gf/SRj0PUdgLMLU7/WvQKY+E2t8EHpYd7Ezpg7XKdpfVoFl8mOROFQuPS9M
AUghvoi+cNAapjf32YjAxAef+rAdcJTO9CANrvFYPcKsuLe9yy2OlJR5bP4tUfHp
gHmrNspPISVFl9BTiJfx+EPzcFfQbP6G6QYEV6D7AoRH97OjG/lG8qKFkdJkK774
Lhj107eoxG5FVpAU0hS+e6nNKgO4qUCS0UMJPVBM5mqdIPLkEasfyONZF126cOQd
uQHHFduf1JeEaC5hZlIWpKW8clyFnMzlNReCUfXE5K1m4jDul76Eh1Zb8AQL1TJu
9nA5zTUPZlrjGYIG+ZwgvQCiV1jy6A==
=YCbH
-----END PGP SIGNATURE-----

--fbml44lxa55gm2fp--

