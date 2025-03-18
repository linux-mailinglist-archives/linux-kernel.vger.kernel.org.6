Return-Path: <linux-kernel+bounces-565811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB0DA66F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD019A342F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369A20765E;
	Tue, 18 Mar 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x5ElA/cs"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF991EF362
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289812; cv=none; b=ETm34grG/dVk7h2D+yo5U4NHK6/UFci0g66fAovS9a39RKaIGwlrqjmNHa1m+QCLzXv+MG8aoeOFmeatLQN99r/Gq7fralFsb08TKZdwnYxfUagoXWo18hDorrf1AdKxDdCyJBkjLKtm11gerjNloduCHIquwqhbyVJFcr5T7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289812; c=relaxed/simple;
	bh=mqJkX5QPsnI/Jodj+L1e6td28KWmnJsJKJ83SXtVVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnVzXjP3Khrrub+DHz++lG3uHYoKclSKl8ihxGi369V7oy9jbSaLvSa+TTR1cgC2LlMKUL8xYSP/GnCsf8amhSg+mY1oIJ3kHxGlGazpJFRimBfJpNjeQ9N8rEHnhkDWe1GGCvBvFhtWlr2ItHKsKMP+56lSyjFiqYKBgerfAlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=x5ElA/cs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso7871788a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742289804; x=1742894604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU/vvHDuGhTduZB0clQayUgjj8LXd6feyCcIDz4QkME=;
        b=x5ElA/cseQPOwCsRNCy4SPJXC1U2rvpbmpPPsoZin9CQOZ+NbUzNVAHIwqcNePvAE/
         pGxhEUbYZ3PdKKLle1qUfsdhWv4iwPLX/Nx7XYY3DdrveEVGNDdcqJV9fS9ZFbMXhYgP
         Lhj5sJ43J9RYsVrHW7Pw/6sGUZEt+ucIkHjxRo5r9JNqA20v8eFhy6xsNfyRzSnYeC/6
         BdBYa5cfjG8wiAn1hWIPzNCC0/gauJU8eXm8tbRl5oZgeZunf7dMVFSqUgoPMyl61Kco
         dBHYc+QCQngnQ3yJ2BahX5vqSPuwY1E0wEhZiWnDdqV796QTIpIc6XsW8ipAodb0DGHL
         UoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742289804; x=1742894604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU/vvHDuGhTduZB0clQayUgjj8LXd6feyCcIDz4QkME=;
        b=vvvgYl9SkRJj/jmwutQ5XSGBfVMeSdcc0p2qx2Xh2au6EDW7AVNo0YfaFT1V5O8cPx
         IH1+OqiAXqTN4Roeg8lLkxcBTKDGAeH4ud1c298rILn65GhekO7nJE4XXMqXXD94gg6F
         tANfSo+BuLR1ofpx+zKRPPH07gae6mo3Tl2NF4BbWiTQut5jReQ4Lo9980v+9VxeQpFz
         Abl9y4Yf+7Z3QQqPPQCTc5CFKl+z1YcpMKLIdkQnXXlmAcfnxSSs+c4xRDG99GtZV/PH
         +2gMdE54Bl6fcCk0BVV724Kye98e9wuU2juAkOjRlLkDYtydLgbQV81Je3YbHF+9Fh8u
         B1dg==
X-Gm-Message-State: AOJu0Yw5rat03DRsc223BB7/cxxC1m/d0J/YyNO0Wqe+OZsNn5/B/0RV
	tPt/owrHjISlV7fMRrDFGG5jpRefl04ZDjJlMMZErGl/vRvR6pW2LyqPpcwJmgE=
X-Gm-Gg: ASbGncuK61oi2bnFCTzu1vx+JjkB9KnHxAHTP/zwrzw84B1v2RoUl/A4s6cmBAz/hbh
	72M+L6zK4xRAcBWUl7t9ET5Bal6z+AxGYRKHp5ZDEeywfQ0abeCZBVr4SE3Pw+tBgfDgoXRGkHp
	G7IP0dgXNlfWtbdQwxgDh3UcRtC5C6z4i2ZGpG9gfL+Wbqtmt6nERizoY8IXZTNDSX0AqWwfcbK
	rHfijaB+Yg5ck+5S/NeoD6+IhyJkWoXMfhsK/D9KHo3BtpIJRmiBxAN3FtaDnd7EJ7IKX/70YGJ
	E2kdj7OplLhXJQ3sduMHNWic298SWeR5zRaQ2qb3WE/op6sBh87gyxS6whiCEiroVTsFjBEtn8q
	jS/2yzLo//C4=
X-Google-Smtp-Source: AGHT+IFwtT4t5BJ31fMOagUfAPcPJQ9nOWEjcwUgulSB82NQzjLhdlaZFO+fufBv9ePXiB8ie77s9g==
X-Received: by 2002:a05:6402:354a:b0:5e7:b00f:9fe6 with SMTP id 4fb4d7f45d1cf-5eb1df95a3dmr2487075a12.26.1742289803650;
        Tue, 18 Mar 2025 02:23:23 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b021bsm7635128a12.33.2025.03.18.02.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 02:23:22 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:23:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <ghdqkv33owyqngxlwuwjogqgaasilnakcqq3znv7ae5hsdi763@dpqzqtypgtkq>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
 <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
 <CAHh=Yk-_0rKB=FG6Voif2MDjtRxzUA5vXDP2J-o5=8ru1ewt0w@mail.gmail.com>
 <CAHh=Yk-TosOmwEughfK9mMx-=DgzWK5H_bf6H641SGh1ue8BrA@mail.gmail.com>
 <zneb3qwgf52zitcbq4wz76shnmhwfkabbsts3sussjpc5s5tsz@uneaxdfp4m2f>
 <CAHh=Yk_oTdURhkna_saF6mrA9gDY=+v_j5NoY_7jTDLuZ=EXtg@mail.gmail.com>
 <7bcnckef23w6g47ll5l3bktygedrcfvr7fk3qjuq2swtoffhec@zs4w4tuh6qvm>
 <5robb7ipl346daf3lqaqnsi3fcgj3wzmch5dqit2dczdyeknmv@dqft77bhwryg>
 <CAHh=Yk-p69ppWWspEzzznhDnuk3i6dRGKzUaqZCwg_uAxB3FVA@mail.gmail.com>
 <CAHh=Yk8kC1+D4dPQ7iAtn1WSPSk+OU6vwEyGF9VZAS5o5gPHmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zj2eh5wo3yw56vr"
Content-Disposition: inline
In-Reply-To: <CAHh=Yk8kC1+D4dPQ7iAtn1WSPSk+OU6vwEyGF9VZAS5o5gPHmA@mail.gmail.com>


--7zj2eh5wo3yw56vr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

Hello Nylon,

On Tue, Mar 04, 2025 at 05:02:13PM +0800, Nylon Chen wrote:
> Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2025=E5=B9=B41=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:20=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2025=E5=
=B9=B41=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=887:44=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > >
> > > Hello Nylon,
> > >
> > > I took another look in the driver and found another problem:
> > Hi Uwe, Thank you for the information.
> >
> > I'll need some time to verify and understand these details, as well as
> > conduct the relevant tests
> > >
> > > On Tue, Jan 21, 2025 at 07:12:10PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Tue, Jan 21, 2025 at 04:47:46PM +0800, Nylon Chen wrote:
> > > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 20=
25=E5=B9=B41=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:47=
=E5=AF=AB=E9=81=93=EF=BC=9A
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On Sun, Jan 19, 2025 at 03:03:16PM +0800, Nylon Chen wrote:
> > > > > > > I ran some basic tests by changing the period and duty cycle =
in both
> > > > > > > decreasing and increasing sequences (see the script below).
> > > > > >
> > > > > > What is clk_get_rate(ddata->clk) for you?
> > > > > 130 MHz
> > > >
> > > > OK, so the possible period lengths are
> > > >
> > > >       (1 << (16 + scale)) / (130 MHz)
> > > >
> > > > for scale in [0, .. 15], right? That's
> > > >
> > > >       2^scale * 504123.07692307694 ns
> > > >
> > > > So testing period in the range between 5000 ns and 15000 ns isn't
> > > > sensible? Did I get something wrong? If the above is right, switchi=
ng
> > > > between period=3D1008246 ns and 1008247 ns is likely to trigger a
> > > > warning.
> > >
> > > The possible periods are of the form
> > >
> > >         2^scale * A
> > >
> > > where A is constant and only depends on the input clock rate. scale
> > > ranges over [0, ... 15]. (If I got it right in my last mail, we have =
A =3D
> > > 504123.07692307694 ns.)
> > >
> > > If you request say:
> > >
> > >         .period =3D 3.9 * A
> > >         .duty_cycle =3D 1.9 * A
> > >
> > > the period actually emitted by the PWM will be 2 * A. But to calculate
> > > frac the originally requested period (i.e. 3.9 * A) is used. So frac
> > > becomes 31927 resulting in .duty_cycle being ~0.974 A. A better value
> > > would be frac =3D 62259 which results in .duty_cycle =E2=89=85 1.9 * =
A.
> > > (Depending on A the values for frac might be off by one due to roundi=
ng
> > > differences.)
> > >
> > > So I would expect that PWM_DEBUG is angry with you if you go from
> > >
> > >         .period =3D 2 * A
> > >         .duty_cycle =3D 1.9 * A
> > >
> > > to
> > >
> > >         .period =3D 3.9 * A
> > >         .duty_cycle =3D 1.9 * A
> > >
> > > .
> > >
> > > Best regards
> > > Uwe
>=20
> Hi Uwe, Based on your suggestions, I conducted relevant tests and
> corrected algorithm errors.
>=20
> According to this test program, I can make the system generate related
> error messages on v10's patchset.
>=20
> e.g.
> [ 75.043652] pwm-sifive 10021000.pwm: .apply is supposed to round down
> duty_cycle (requested: 360/504000, applied: 361/504124)
> [ 75.055042] pwm-sifive 10021000.pwm: .apply is supposed to round down
> period (requested: 504000, applied: 504124)
>=20
> PWMCHIP=3D1
> PWMCHANNEL=3D0
> PERIOD=3D504000
> STEP=3D1
> MAX_DUTY=3D504000
>=20
> echo 0 > /sys/class/pwm/pwmchip${PWMCHIP}/export
>=20
> echo $PERIOD > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/period
> echo "Set period to $PERIOD ns (scale=3D0 region)"
>=20
> COUNT=3D$((MAX_DUTY / STEP))
> echo "Testing duty-cycle from 0 to $MAX_DUTY in step of $STEP..."
> echo "Total steps (forward): $((COUNT+1))"
>=20
>=20
> CURRENT=3D0
> while [ $CURRENT -le $MAX_DUTY ]; do
>     echo $CURRENT > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/dut=
y_cycle
>     CURRENT=3D$((CURRENT + STEP))
> done
>=20
> echo "Now do a backward test from $MAX_DUTY down to 0 in step of $STEP..."
> echo "Total steps (backward): $((COUNT+1))"
>=20
>=20
> CURRENT=3D$MAX_DUTY
> while [ $CURRENT -ge 0 ]; do
>     echo $CURRENT > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/dut=
y_cycle
>     CURRENT=3D$((CURRENT - STEP))
> done
>=20
>=20
> echo 0 > /sys/class/pwm/pwmchip${PWMCHIP}/pwm${PWMCHANNEL}/enable
> echo ${PWMCHANNEL} > /sys/class/pwm/pwmchip${PWMCHIP}/unexport
>=20
> echo "Done!"
>=20
> Based on your previous suggestions, I have made the following related
> modifications, and now I'm able to fix the relevant errors.
>=20
> But I want to make sure my understanding aligns with your suggestions,
> so I'd like to discuss with you first before sending the patch.
>=20
> - In .apply, use "round down" for calculations to ensure the value
> doesn't exceed what the user requested. (Never set a duty cycle higher
> than what the user requested.)
> pwm_sifive_apply() {
>     - frac =3D DIV64_U64_ROUND_CLOSEST(num, state->period);
>     +frac =3D num / state->period;
> }
> - When converting hardware values back to duty_cycle in .get_state,
> use "round up" to compensate for the errors introduced by .apply.()
> pwm_sifive_get_state() {
>     - state->duty_cycle =3D (u64)duty * ddata->real_period >> PWM_SIFIVE_=
CMPWIDTH;
>     + state->duty_cycle =3D DIV_ROUND_UP_ULL((u64)duty *
> ddata->real_period, (1U << PWM_SIFIVE_CMPWIDTH));
> }

That sounds right.

Best regards
Uwe

--7zj2eh5wo3yw56vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfZO4cACgkQj4D7WH0S
/k5aSgf/S+7QjofA+CHDa6zV1OUJbLv3VBQS1gX1YK4Mps+QnOK2hlrMQQOVDVk3
t28rjpcMJD8m70ZClOt+kfHM3O6DqlWJd2tl/AX/Wq0rETMNq2F3YFRecGs91xku
OF4rZwQVaSl5wr2VZP6j0k/8AilXmIHg6kHfvnMQrIqJwA4W/aVFbnt0sNlo+eGf
nB2Ju3+GNzUw6AiEUEgCHvIiD71aagqD90G772pT+OpGaiZmj8GIX0MxpaRiQ2V0
ZkdcM8lWic/7IbMkYoyHz4g6edbTJ+yhn9/RIAKeRNw+N6aK3VjZkOT/6WgggzZo
QzJe/nGspANnzvsW8QcLUPvEe+eVuQ==
=Mvcc
-----END PGP SIGNATURE-----

--7zj2eh5wo3yw56vr--

