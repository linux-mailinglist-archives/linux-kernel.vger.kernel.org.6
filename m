Return-Path: <linux-kernel+bounces-275754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4C94896B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463F8B212AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 06:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34681BBBFE;
	Tue,  6 Aug 2024 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aIVOR8k3"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CD7710F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722925929; cv=none; b=LAF+p2urwD0bPhFAZj9dK+P9cGPtkeHCB5QsQYbx7fp55OpxyJ7LZWrpOH0zPxhrZff0NTCdQJHhany6puZHuGwTbs2YCq9Ehad/R/iZwF9JQQRPqa9l15X2Kv531UkCx1uYvvURP0/0/KFrCLroM7GFDyBl2K/lC+e9XpelScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722925929; c=relaxed/simple;
	bh=CcwNAS5t4PpUTArHaTOrI7Uce/v3706foKbFQ5FIvlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moGdJzVbEUX822CQwEtkdsVydrvDQnZmUvuiNdY2dQHjZ9ISVb5ACv2KJBJ5WdgVoby9fbwhEess1fgM06beMsKra2+kcTsY+oYHo8AsJJTN6BMmcEdsCjrCVAiItFRrvyxjEQPFvkmbMVLrTF7KXRVOCAnJkzOY4GjZKmjT5Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aIVOR8k3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428178fc07eso1649155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722925925; x=1723530725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28uc5KktWeMaHHoBOnWKpTdV+/G2B65GuLbD8msyplA=;
        b=aIVOR8k3LH17igjnK9/FqPERS1zzHxXOOGC2wZsDxRLxGhjLS2+NoGuargCJMmP5qv
         ZgUuNlCIbVD/Ix/Sqw0SYrs9IwTX7Aohdn1e4Skl98fp8b7d0aLO5H2y6qHBiZhzqpvs
         33oEn4gXTjRJtQiS9s0tfHFJoYketupqVmzCjbh3P0NKIETXclMdqF0l3eHAD27xWAY+
         tSacZif5ziknSI/2HogtHRCKnPSpGGr7HrydSzeaM+VSXqjcXpmENgprdEFAKhKIQXZX
         Qm9Iko7kh7+HXF5AtYQdNZjX5O3j+DiGSqhC7W/b/Oba5NPfKf+nStCC+HZpFrfHG4oL
         kcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722925925; x=1723530725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28uc5KktWeMaHHoBOnWKpTdV+/G2B65GuLbD8msyplA=;
        b=SF9ff6pf9EYNQsVaPCoMwCq1zBNJqprikBCTjouqOUPB1TVa8lrW14LUvygQPysMfj
         UJL5lLJbk5500KPt95H61EKo3+E7Dhk+2eEzxWgYx8EdGF/Ih0m3EAp25E12pncu/+ae
         6r4VCVsFISeCsfLTtsujvtTf88Ls/l75sjx1N9ztxHlWPBwdNHh1x10h9xEG3Kk0bzAT
         qrjMtS8NAU7SYVl6Xxae7RUakA7ZfdZE1x4HnsLoZnxFCs3SZZSd1cQc4iBWlj574gej
         QQ1osH1SVBh5mCYeTlv1KC7drexpU3R+EdWKn84I9ObU/PvpU20776D9antziYO97dVU
         tNjA==
X-Forwarded-Encrypted: i=1; AJvYcCXxzmJCkobpVrpm7aLkZa3/+QMrvYew1LJV3TH+zOm/0VTNGdigy2+oneeaVyc3DsrpGBQLKWLw/XfylhxICErWpJUr1ZugGw/lokW7
X-Gm-Message-State: AOJu0YxegLQvor1HM0yc0lQcR18ZEEJP+A+K315dqBj//oobEWYKso+M
	00/E8rZFQ0Smmzsld5URj5FUKYtDa2d704crtbNpxwlUuLCdaVzU+DZnuim2vu0=
X-Google-Smtp-Source: AGHT+IFoKYujpzDFkRmU2Q0wVctZckNCmUXBPGYDZ8dPp4n7Jan46n8eBSsiBjHQYbZrdBjdnYNRfQ==
X-Received: by 2002:a05:600c:4fcb:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-428e6b30cc7mr95848575e9.17.1722925924705;
        Mon, 05 Aug 2024 23:32:04 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6403bsm228309185e9.35.2024.08.05.23.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 23:32:04 -0700 (PDT)
Date: Tue, 6 Aug 2024 08:32:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [RFC PATCH v2] regulator: pwm-regulator: Make assumptions about
 disabled PWM consistent
Message-ID: <y7svv2jvcof3fnezvjbirkian5b7ajic7ajxgtyiejj3364ie7@uvmqlpjj6tv5>
References: <20240622191504.38374-1-martin.blumenstingl@googlemail.com>
 <s6lapsx6dukr4ebknbbalbhi7232ivxl2apaqtardfi6f2ybbf@zvlhxlngbgx3>
 <CAFBinCANKBcttSEhc_0-+D0G3fO0CV67R41y-C7xEwhAXtA+LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lwuvkzra6xmuxxcm"
Content-Disposition: inline
In-Reply-To: <CAFBinCANKBcttSEhc_0-+D0G3fO0CV67R41y-C7xEwhAXtA+LA@mail.gmail.com>


--lwuvkzra6xmuxxcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Sun, Jun 23, 2024 at 11:09:08PM +0200, Martin Blumenstingl wrote:
> On Sun, Jun 23, 2024 at 11:32=E2=80=AFAM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Sat, Jun 22, 2024 at 09:15:04PM +0200, Martin Blumenstingl wrote:
> > >       drvdata->state =3D selector;
> > >
> > > @@ -115,17 +129,26 @@ static int pwm_regulator_list_voltage(struct re=
gulator_dev *rdev,
> > >  static int pwm_regulator_enable(struct regulator_dev *dev)
> > >  {
> > >       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +     struct pwm_state pstate =3D drvdata->pwm_state;
> > >
> > >       gpiod_set_value_cansleep(drvdata->enb_gpio, 1);
> > >
> > > -     return pwm_enable(drvdata->pwm);
> > > +     pstate.enabled =3D true;
> > > +
> > > +     return pwm_regulator_apply_state(dev, &pstate);
> > >  }
> > >
> > >  static int pwm_regulator_disable(struct regulator_dev *dev)
> > >  {
> > >       struct pwm_regulator_data *drvdata =3D rdev_get_drvdata(dev);
> > > +     struct pwm_state pstate =3D drvdata->pwm_state;
> > > +     int ret;
> > > +
> > > +     pstate.enabled =3D false;
> > >
> > > -     pwm_disable(drvdata->pwm);
> > > +     ret =3D pwm_regulator_apply_state(dev, &pstate);
> > > +     if (ret)
> > > +             return ret;
> >
> > With that part I'm a bit unhappy. You don't know what the pwm does when
> > disabled (it might yield a 100% relative duty cycle). So the safe bet is
> > to use .enabled=3Dtrue, .duty_cycle=3D0 here.
> >
> > The only code that "knows" if it's safe to disable the PWM is the
> > lowlevel pwm driver.
> Here I don't know the regulator framework enough. Let's make two assumpti=
ons:
> 1. the optimization you suggest is implemented (I'm not against it,
> it's just different from what pwm_disable() does)

In general you cannot know how a disabled PWM behaves. The objective of
=2Eenabled =3D false is to save power and don't care about output. The
typical implementations yield the inactive level, but there are
exceptions that are hard to fix -- if at all. These include High-Z and
the active level. So if the pwm-regulator relies on the PWM emitting the
inactive level, .enabled =3D false is wrong. I guess in general you don't
know and .enabled =3D true + .duty_cycle =3D 0 is the right thing?

> 2. regulator core does not expect the set voltage to change in a
> .disable() callback
>=20
> In that case disabling the PWM output is fine. Since we're now
> updating the cached pwm_state with duty_cycle =3D 0 the next time the
> regulator core calls the .enable() callback (without calling
> .set_voltage() between disabling and enabling) we end up enabling the
> PWM output with duty_cycle =3D 0 (and thus likely changing the voltage
> output).
> I see three options here:
> - my assumption about the regulator core is incorrect, then your
> optimization works just fine
> - we only write enabled =3D false to the cached pwm_state but not duty_cy=
cle =3D 0
> - we drop the suggested optimization here (and maybe let PWM core handle =
this)
>=20
> What do you think?

I'm unsure. I can tell the effect of .enabled =3D false, but I don't know
if this effect is ok for the pwm-regulator. I also don't know if
disabling and reenabling the regulator is expected to keep the voltage.
Who can tell? I'd hope Mark?

Best regards
Uwe

--lwuvkzra6xmuxxcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaxw1MACgkQj4D7WH0S
/k5ZYAf+LJ7i7pO+FW4FK0Mfr5W6uWz25nIycCkrNh3GWfXgCh7WFayQ3yePgtci
Jzt0MSrOF2VMbdZs8u2dxC7G6f17VymcdZvqpgp4t30073rvj51HtJo3nz2k6G44
7CJgeeZ1phGs4QbgzymI+ishOB9rMc1ZmApqioclbvPgHLLQDcZMNQj2CVTSj08H
NkxyddIKmlnqL1YQrl9vUpAcMQUpfHvWz9afGv9EkFCpb9b9lOqehN0yZgff/N0t
ubJBMgE7SvqaKnRmTRsCfx8XeDACFR7fDUvJBSSe0vYe1yTMg8/XfgeypAwoIpsz
+Bx2SoeUxKIxrsyI6fBjYpIR9Y26Xg==
=ZSzP
-----END PGP SIGNATURE-----

--lwuvkzra6xmuxxcm--

