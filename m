Return-Path: <linux-kernel+bounces-515276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02CA362C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CC518876A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1462E2676CE;
	Fri, 14 Feb 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OmMh2I7g"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235570831
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549635; cv=none; b=RLxOFY6pmIHe4RVWcBjFHcJKCNVSiCfDNPtoSZCrcJAaEovkdmhnXF8++/MyvikACt+xY4olil8OakU5CWKfah8DbkSfb5DYLWQuuvecu/Y+ccXpinL44peSjOrO9CMqiVYKrOpy894rW3CLxjoyfI4vM1rjCJo1i06zW7PaG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549635; c=relaxed/simple;
	bh=5Cq2puqUbt7p8eb1Liza4srSylsA782g2EWTNazx6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GS3ZQjxa8EfXICluQ6YJzkNEhS9vcQY6QM/GA5rDV+PQMPA9BPJlRfoVAT+WLA7gt/q7yVMgVU48+ijncIvW/JFkab/3yfbHLR+JT+f1/X67nruOXtBv15IkGdZY9txZWHcmXaNY0fixvRvfSsFv7RNJoVu5J0CJluwp5SCWDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OmMh2I7g; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so14769725e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739549629; x=1740154429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7s4xKwHi3JWHK99GmqV/eaV3Tj0T6uUs6iJnb9Y/Wg=;
        b=OmMh2I7gjE+1z8SqrUoPUC0HJVEWtjK0wQ76T7ataQcE4WdHN5NYsn4Mb8qs57Pu68
         AroFMW+EuZAWl4VQYNqPehN5Vik+ALw0YLAubdywE/D+cs9EFZ4QhsjZdJkmY+Vrlgg/
         T0xflpCXIj/dvuJCjSN1x5lP0j9ukCKpJKd0UrzonV7bevfDHJxydZP2zIR1kiqJFsx8
         2ytXlIxn9pEGygJipgdQ7EyHSAy24UJl5OAVbwKBhSEtcCDBHqToKLzkrHrw9mRvqIwE
         ArrKNKp9eLHP7ZiSjoShtbmC6IYqaZoptIJ389ESYb9KuNxUVceO51PVG1Xk3M6M8EIm
         pK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739549629; x=1740154429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7s4xKwHi3JWHK99GmqV/eaV3Tj0T6uUs6iJnb9Y/Wg=;
        b=Klxtdtq9NAOebf4NuXGhJzxOr3jknPKJPElNezvf/q2Ou9JDBLFu2yrqknKu+d8UTN
         VUma3C/tcPgG0n7MrAI6ph4TT/BvAz9yHHKKT05MWHhbcmgAMN3NS3oTZNMoixknYpOE
         NjumZccuQ4pR1J8AcSf09L8G9QhfztRMQ8Nn0Xf/Eju2NmAEtzYlGm+rxzqUc5ai6c1I
         +e5RJpr+uX8GXt7PtgLbPOYhmfU9KPiyedT7wSWHp5mCjgatAAmTTyXu07YvUEKC+LTC
         r9kSjGDMruQxl2tuc090D15BmINFg01Sru7dDhPf6UzHkc3PubHYRHZAIqv9jkuUwIyv
         yoAw==
X-Forwarded-Encrypted: i=1; AJvYcCXS00bZpw0zMmJe3x1U/OcWuMO7pVvKWCoTwlGGbXQ1WXZf8ebcm28AQoync+lz3ZP+BVNT/LjUgWG7NfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKe5pXYTCSZEHrpMHCwSvaAerJm/7LOg2KHoa0C2FoV6AgKa57
	Kfxjrm/Ehnua2zqKJz/LpigKJgtC1RkBlFvya/5JsjOu35KEEztpOVzEKbiKZJg=
X-Gm-Gg: ASbGncv1p9D27ySx3QkhrRO5uo4JcwvnfFXprCN6ScmE+TZJrheTVX3O9SoLVHiN71p
	V8g/PQTeaGUlNxD1Pjcmf9rFsy4w1lKolDNQ5oGLlMlGK4FdCEBUyBnAVaHHaUaY/T82EsXIQU2
	LlosX0c2Su0HHt8GNh20rg4Q+se3MV//HG9HmJp4zzQ1eYO/bUP9f5huwuP2WteVvh7YPdisLRj
	KYb/vmeCw7U7nZp/uw1Xr2OKnimgFnHn9FiZ39Ig7EIxiQgVaz0hLshcwwTUXcNT+kDOcoRUXHN
	psed74k3lIWBmrIN61fzlHHJaHkfxcsJ6ZJJFkEvkIUJPyZO+NqyLs4mfA==
X-Google-Smtp-Source: AGHT+IHihWfHUqPQJ1KKE8UnWJbUvz30R0E+Y7ztpPEPIq4DHrLmg057hM7LfvgOZpQmTFyFOB4elg==
X-Received: by 2002:a05:600c:5110:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-43960185cf6mr114743125e9.12.1739549629117;
        Fri, 14 Feb 2025 08:13:49 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8602sm5117405f8f.94.2025.02.14.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:13:47 -0800 (PST)
Date: Fri, 14 Feb 2025 17:13:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfxyvzazdawba2s6"
Content-Disposition: inline
In-Reply-To: <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>


--lfxyvzazdawba2s6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

Hello Amit,

On Fri, Feb 14, 2025 at 02:32:16PM +0100, Amit Shah wrote:
> On Fri, 2025-02-14 at 12:14 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Feb 14, 2025 at 11:58:44AM +0100, Amit Shah wrote:
> > > On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=F6nig wrote:
> > > > virtio_console.c can make use of REMOTEPROC. Therefore it has
> > > > several
> > > > tests evaluating
> > > >=20
> > > > 	IS_ENABLED(CONFIG_REMOTEPROC)
> > > >=20
> > > > . This currently only does the right thing because
> > > > CONFIG_REMOTEPROC
> > > > cannot be modular. Otherwise the configuration
> > > >=20
> > > > 	CONFIG_REMOTEPROC=3Dm
> > > > 	CONFIG_VIRTIO_CONSOLE=3Dy
> > > >=20
> > > > would result in a build failure because then
> > > > IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the
> > > > built-
> > > > in
> > > > virtio_console.o must not use symbols from the remoteproc module.
> > > >=20
> > > > To prepare for making REMOTEPROC modular change the tests to use
> > > > IS_REACHABLE() instead of IS_ENABLED() which copes correctly for
> > > > the
> > > > above case as it evaluates to false then.
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > > ---
> > > > Hello,
> > > >=20
> > > > I didn't check what else needs to be done to make
> > > > CONFIG_REMOTEPROC
> > > > tristate but even if it stays a bool using IS_REACHABLE() is
> > > > still
> > > > the
> > > > better choice.
> > >=20
> > > It might lead to a false sense of "better" -- the value of
> > > IS_ENABLED
> > > is cached in a variable which is determined at compile-time.
> >=20
> > Either I don't understand what you mean, or this is wrong.
> >=20
> > 	$ make allmodconfig drivers/char/virtio_console.i
> > 	$ grep CONFIG_REMOTEPROC=3D .config
> > 	CONFIG_REMOTEPROC=3Dm
> > 	$ cat drivers/char/virtio_console.i
> > 	...
> > 	static bool is_rproc_serial(const struct virtio_device
> > *vdev)
> > 	{
> > 	 return 1 && vdev->id.device =3D=3D 11;
> > 	}
> > 	...
> >=20
> >=20
> > so is_rproc_enabled is still constant and known at compile time.
>=20
> Well - so I was replying to your comment about what else is required.=20
> And if remoteproc becomes a module, this check will not happen at
> compile-time?

The code I quoted is with both CONFIG_REMOTEPROC=3Dm and
CONFIG_VIRTIO_CONSOLE=3Dm.

> In any case, the next bit is the more important one:
>=20
> > > That
> > > caching, after this change, moves to driver init-time.=A0 If the
> > > rproc
> > > module is loaded after virtio-console is initialized, there's no
> > > way
> > > it's going to be used.
> >=20
> > If both are modular, modprobe should make sure that rproc is ready
> > before virtio-console. If virtio-console is builtin and rproc is
> > modular, IS_REACHABLE(CONFIG_REMOTEPROC) evaluates to false and so
> > rproc
> > won't be used. (As is the case already today with
> > CONFIG_REMOTEPROC=3Dn).
> >=20
> > > Only if the rproc module is loaded before
> > > virtio-console will the rproc functionality be used -- which means
> > > that
> > > nothing changed in reality..
> >=20
> > With that patch indeed nothing changed yet, because CONFIG_REMOTEPROC
> > cannot be =3Dm today. Until this changes IS_REACHABLE() and
> > IS_ENABLED()
> > are equivalent.
> > =A0
> > > To properly detect and use rproc if available would need the rproc
> > > initialization out of virtcons_probe() and into something that
> > > happens
> > > either via sysfs for existing ports, or when adding a new port to a
> > > device.=A0 However, the current spec doesn't allow for that, so some
> > > more
> > > changes will need to be made to ensure current backwards compat,
> > > and a
> > > new specification that allows for a late init of rproc.
> >=20
> > I didn't understand that and hope it's irrelevant with the things I
> > wrote above.
>=20
> See
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/char/virtio_console.c#n1993
>=20
> The device is configured at probe time on how it's going to be used -
> all that will have to be reworked for making the remoteproc driver
> tristate.
>
> So in essence, this patch isn't changing anything; but it's not helping
> the case you want to enable either.

I still don't understand. With both CONFIG_REMOTEPROC=3Dm and
CONFIG_VIRTIO_CONSOLE=3Dm the expression is_rproc_serial(vdev) will be
true iff vdev->id.device =3D=3D VIRTIO_ID_RPROC_SERIAL. (And with
CONFIG_REMOTEPROC=3Dm and CONFIG_VIRTIO_CONSOLE=3Dy it will be 0.)

Both IS_ENABLED(CONFIG_REMOTEPROC) and IS_REACHABLE(CONFIG_REMOTEPROC)
evaluate to constants known at compile time.

So the device is still configured at probe time on how it's going to be
used and I don't see what needs to be reworked.

If you're still convinced there is something broken, would you please
point out in which case (CONFIG_REMOTEPROC=3D?, CONFIG_VIRTIO_CONSOLE=3D?)
something broken happens, and what this is?

Best regards
Uwe

--lfxyvzazdawba2s6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeva64ACgkQj4D7WH0S
/k4Kfwf/aTGJ+S09I41QPe3OqC4OGbekR2zOy237C7qE424gBH7TEl2oJDjCSZ+n
nsRoEUfYOl6g7l4FfkA6/UB32LtXeayMKGg1SjmOSMXy1olGq+1cF8WOaK5u2+S/
7FBnnmkg8jthoT6MY4pI+maokvR9HmfPdcmv2knpcMMXRwwHXsvlqaWaKpQbqC66
c7ELz4kO5f09eMz/y5U7qbv3fyEJYfGy1+HpiFv/+e6PJJ1mgSLYYE/Kh8TonXFg
7LTE3yvWCWqdheKa01qWN76v1TV7E0k/tQ+keBEI5Ctypg6FB+GgImZnqNjQNf3z
jOw9Cx8qkE5xh9rabsFevrA9jiIfSQ==
=tY2l
-----END PGP SIGNATURE-----

--lfxyvzazdawba2s6--

