Return-Path: <linux-kernel+bounces-381226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3489AFC34
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D0281DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857E1C82F4;
	Fri, 25 Oct 2024 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XdMLbG3U"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1D1B6D11
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843831; cv=none; b=ngc6zTAZryxCSTGbA2fFMrnfWnuYldpryUspCNMUuAEni37d6md3YNtfRO7oyYgFmWe53QHoC79UO6KyJescIqbuh4IthJbsD1gBtjnl4vxmRluJzzR1MDlhQSuiUvOJess+1R/GE4tsgzDzmRzKnMaqFAk1njGnS1QYexP42W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843831; c=relaxed/simple;
	bh=uIHAB8knA67LAdTZXj2iF5vul+ZTR391oAkKc1jLRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK+LW1vlJ7wceqdKwzbgSBf/BGp8rsM8SocIX8yUbXLtkCcsN8NRxAvWcCuBzmXZNMhPVcvql3KGsSoSYu/66X4p8kBlCGkNwgvrSjXMjzgbaYzwtg4eysLjeG+wlE6Elffm6N81vGAOtqFUXzV4naa2ARx1OFFEyl1wy53fInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XdMLbG3U; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb49510250so18600171fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729843826; x=1730448626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/fMOoodbMzbwIVhNycuTPYQFdigoQOM3R/xwLCJOkg=;
        b=XdMLbG3UijKzcGx4luJOSS3z2n3CHj91rWH1iVXDQy9rNjJIWR/xWrAKwKviZIPzUT
         VmrZOWQqWHQtLTvy2VcKUW6iaRkE4U9+ZBuXp3KleimePv+nJI6LpsVfVjYkx6NjLgpo
         y2IDxlbajJuXb+Kepjmb7pkwPFZtswJme4GYRwFSGgWhT4MeBqb5RQh3eu8vsweHXney
         OW6icrloM3j5a9wMH84epGG2WreROzBzTu1HqRpUF97HEAmjSXZTM2DQqPJppn9DHmR3
         5P/yDNsvOac5MfBaIAEJpWArOEo5T4JCQnDZ9mCTJ0kTBPrqj4Q8hbqE8AHCrPNm45wE
         sEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843826; x=1730448626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/fMOoodbMzbwIVhNycuTPYQFdigoQOM3R/xwLCJOkg=;
        b=DywjEfhDPppKR4QzUFbf1eYsRry4PrYtWzWQpTlxQPEBUhTdwumG/5X7nVMROs8szh
         AX/5YOLSzvxZ1SDh29Cqh0OxQL5D4QcpafZqp1BI8k59L5D5Iwg+IYqieCmcY/4riBMs
         b1gRJqNYKsQY8bwnMFObmHaw/gzt+TwBeOac+sjYHTmw0W9Xm7ChBM7uLjeGV0tIuZdI
         YqK5I01r8lgDPzvywEo19MPiOXFlAqt4Q5logKMasaibNVbWzK/uuTJjaYAOuKvhuS29
         c/vxreto6EwKroC64FHT3OAt51qWHFqiKOmye0u2/qYgPA/CSqkMG9SOY5C2kbx9uK4C
         BhyA==
X-Forwarded-Encrypted: i=1; AJvYcCVqu7ETP0MFerd3LmdIJ3AqEubzU/xBhwiBUNipMHgkwI9Vf5aIaboB9D9fFSAb6eBprTSC83P01azjWSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLeG2jdWLOkZJcD+AYzi4W4x8U9joRuBS0DtAl4Z0bp6zOavGN
	8wm13Gp9M8zrltzI//1T8HBdEc5NfOr3q0PC3uTr+fYZkfpcGZTq7i2nWnJwez0=
X-Google-Smtp-Source: AGHT+IFbMHt8LG7ynfMpwb1jF4aZ4NwAbHonDNawD4VDZMCWmBcTP0Lt3O+sjbBuFgQju/DrJheDFw==
X-Received: by 2002:a05:651c:198c:b0:2fc:97a8:48f9 with SMTP id 38308e7fff4ca-2fc9d35a491mr51172391fa.19.1729843826415;
        Fri, 25 Oct 2024 01:10:26 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6e47sm10446295e9.38.2024.10.25.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:10:25 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:10:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	"jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
Message-ID: <6hkiqbgqkpdlr5f27drs7vcee7pb2uahek4zz5pd5ndativk53@42otb625deil>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
 <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
 <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irgwyxo4ns45vjjz"
Content-Disposition: inline
In-Reply-To: <OSQPR06MB72529E67E67D0D07E59AF1C08B4F2@OSQPR06MB7252.apcprd06.prod.outlook.com>


--irgwyxo4ns45vjjz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
MIME-Version: 1.0

Hello Billy,

On Fri, Oct 25, 2024 at 02:00:39AM +0000, Billy Tsai wrote:
> > On 10/24/24 08:40, Uwe Kleine-K=C3=B6nig wrote:
> > > On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
> > >> Aspeed PWM controller has the WDT reload feature, which changes the =
duty
> > >> cycle to a preprogrammed value after a WDT/EXTRST#.
> > >>
> > >> Billy Tsai (2):
> > >>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
> > >>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload
> > >
> > > Huh, I'm not convinced that extending #pwm-cells for that feature is a
> > > good idea. Unless I'm missing something none of the other supported P=
WM
> > > chips can do that, so I hesitate to change a standard for it. I sugge=
st
> > > to make this a separate property instead.
>
> Using a separate property to enable this feature is a straightforward
> method, but I don=E2=80=99t understand why extending #pwm-cells isn=E2=80=
=99t a good
> idea in my situation. The feature =E2=80=98WDT reload=E2=80=99 can be set=
 for
> individual PWM channels, and the PWM subsystem has the of_xlate
> callback hook, which allows each driver to define its arguments for
> the PWM consumer. I=E2=80=99m unsure if I misunderstood this callback usa=
ge,
> as I couldn=E2=80=99t find examples. If my understanding is correct, this
> method is better for adding our specific feature, rather than using
> child nodes or separate properties to indicate which PWM channel
> should enable this feature with the corresponding duty cycle values. I
> think using separate properties to achieve this feature would be quite
> cumbersome.
> As I know the arguments for this usage are as follows:
> First: PWM channel index
> Second: PWM period in ns
> Third: PWM polarity
> Therefore, I extended our feature to a fourth argument to avoid any confu=
sion regarding usage and added the description in our yaml file.
>=20
> If my thinking is incorrect or doesn=E2=80=99t make sense, please let me =
know.

It might make sense if your bubble only contains that single PWM
hardware. However if you extend the pwm cells semantic for your PWM to
mean "period if the PWM watchdog triggers", i can hardly refuse the next
developer who wants to extend for "period of the secondary output pin of
the PWM" or a step counter or some property that defines how the duty
cycle is modulated over time. And should the next one also use the 4th
u32 for his purpose, or should we consider it reserved now for your
purpose such that the duty_cycle modulation goes into the 7th cell?

Today the bindings are (well nearly) used in the same way for all
hardwares and I want to keep it that way. If your PWM has a special
feature, give it a speaking name that the occasional dts reader has a
chance to understand without reading HW docs or dt bindings.

Best regards
Uwe

--irgwyxo4ns45vjjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcbUm0ACgkQj4D7WH0S
/k669AgAm/vnBOGdRCsvDuzdHkwBbJUkiJHDGNT3nBEs43lY8F0I4G3bDEdGMfgj
Z1EBM6cL0h4BPVxR4vaUd/R8xTuRMkgU5EZy5ic0U+j3KozA6bnYqXuBfUy1VCjL
emUvBEdX7dN2TS2lWnNh/yRpy2IDNYkOEU2ffBGjX1s9xQtVHhtY2yUt3/t7cJwG
HBaMhXhaZD2eUNuhuT5zxW8GA8yiF048vzqIfbBnh7bCqfY7i9XcLQKKcYpOdZ8E
BJ3DF5SRcAv56F0PfkA25qr15QRvzUOt64dNKSVL38Cn7LH4joP2/UtdvjqWlCQm
ytZRxFf+CRo6WHEyCrs0X3asdsChAQ==
=4H4I
-----END PGP SIGNATURE-----

--irgwyxo4ns45vjjz--

