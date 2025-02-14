Return-Path: <linux-kernel+bounces-514828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46722A35C45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963261893A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155E26138B;
	Fri, 14 Feb 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V1wMBGiU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362B25EFAA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531669; cv=none; b=cFFhpl58NIDrTzL6Tbpe1H1TmjHnsBoDMyTfO0fLYCoeAnAi5m3sWoU9bpKQPs2KTWCu7+oUrckhjYwH1K9AKQxXd4YtOm+kceg9iyF0tRmof5C4b1vxaPBsmy7GYsIb+B4ZNOlWkXt+Ym9S/PwSH3/x6Ks6iyexcyNRiyWm3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531669; c=relaxed/simple;
	bh=/+a0dDBN3Dzf9HiKDiSAuhwulCLdTInLVhDdp3sMloU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+dREPWSYxHwawLEr3dJsMSfRpjcXa6HFxxxYn/g0QbfSBb90+/HDfCRwXrHC+dC8sLQJ4yMAYUkGDmaWMl9tpFvfAT5VK+l6WUFd/sUHnULtpDfhYqnLZK1dk09XFplq/Z2PNazltVvhyjqhliasrEqPAh/4qQdRvihMGk0yjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V1wMBGiU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so12248195e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739531665; x=1740136465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5HZRptVwo1kZfc37SaJTjO4C2pKRjpW6kvADFRJRxY=;
        b=V1wMBGiUxA4bcGpvfJSnZCjndu37ZctYwlSJNAC5+EptZfM/B2nKA3Y6DmsC/OzUQX
         FKLbIa9JSOZDyiv5RnaXvbwQ3b2lmKzCfxtMJAIxUNWaTR9KkSPVb8bmMqCbiqWWM47T
         cOfLL2e1+Bs9ODCcVGVUzJ7d4WgYhPXEFo6zko4tT0taeDqw+u69DETB9k8+UjIqIJYM
         2+GRpy76k7vwm5MTUEd+SSNCU3QX3DbQLWzVmMInVe3ZnNWreMOEf91KT1AhKpR1nJ5r
         3CTPU9/Q+xU+FdC+bqAviy32mDzCBrkdnqxE7upT5hA07OVQ69U4JCuAL2dkP7LcZq+c
         lvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739531665; x=1740136465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5HZRptVwo1kZfc37SaJTjO4C2pKRjpW6kvADFRJRxY=;
        b=FOFMRFP7w+ndDDuA1LPofsXJs36eVqJpnX9SQciEdX2mP50Rdv5CVr2khloK771pxM
         wDNSVJlkd/GAf27ZBIxqbkK+tdVxdYQG+pmMb0Y5KJfcH162GG94t3Vrg1LnIkHAo+6i
         gUPtxUyteQ+lmkz7rPu6mugcd879uXXIEMNYKwVwqpJK4XNDeTW9dCzrD6MyxrFxGhmW
         tJkQDcri0NByvgC1NVdFfrZYk+OP2EqUqBHkhk/7AaPE1HSQ7clj2ZuRd/3luoJY10A3
         SH1uPpc/9/GfBqDE1P9/hPGCJakUlauue60UeiT7Sh0buhZewauRN/sOCKzm80Frn+ez
         UWww==
X-Forwarded-Encrypted: i=1; AJvYcCXZCOe8O6xIQT9Lsy2JmLPmHCvamj/XeNRQk1IJVmSSuvHHlE6itSYPsNnRb1+jhxAglOt7yQNlm9/BQJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJXRIyuS1VxMijm/2O2BAH8YCaGDgNT8/lXJqwstfHvtZ0E5AU
	NWs6ZUyM3cXq1h67PJHOQPyTwEaoP2mhsyK84Z3BbPZI/w7nM9QWueV1h/d6LSE=
X-Gm-Gg: ASbGncvc9EMqdKqJjpHgoijHk0TbJcGQytq/NigiYEjyfInFqku54q7v3dlz1Vfe4y0
	/RmRxnSeyjhUXpsBfWvz4bPeQOjGie4gnHS+O5VuHwTm2kOwAmQld/yoFAz9ViRXxl5fqsf+D9/
	6OCMVzpZtaHw2KYP1t9auY9ZUdQfbRNmDAeZ7ZKFg2gXpxAwcGO/mMZYxt18ePV2+2OVb53+ppL
	V4anD23jdZvE/vKPJ5s3AFJgG653jDnucyFF51mXyDCPcNvya0y2JEUSK/pJJiNLvBAs49lv0dM
	E90dQHBlE/T1MGZ3ag2W71gVjMUq/vkRv3uhp3U5C165LTPwXsqgXeFEBg==
X-Google-Smtp-Source: AGHT+IGhliTXVNeRfrHTSy6hBKPYnfviLsTWydLXmYdaqLmpgylUt5q4O9xtV5B7+Y1DWpO0kchKsw==
X-Received: by 2002:a5d:5f82:0:b0:38f:3009:61c1 with SMTP id ffacd0b85a97d-38f30096290mr1498623f8f.26.1739531663571;
        Fri, 14 Feb 2025 03:14:23 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c36sm4396579f8f.67.2025.02.14.03.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:14:22 -0800 (PST)
Date: Fri, 14 Feb 2025 12:14:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzgr4aiedgk6nxy7"
Content-Disposition: inline
In-Reply-To: <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>


--hzgr4aiedgk6nxy7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

Hello Amit,

On Fri, Feb 14, 2025 at 11:58:44AM +0100, Amit Shah wrote:
> On Thu, 2025-02-13 at 12:55 +0100, Uwe Kleine-K=F6nig wrote:
> > virtio_console.c can make use of REMOTEPROC. Therefore it has several
> > tests evaluating
> >=20
> > 	IS_ENABLED(CONFIG_REMOTEPROC)
> >=20
> > . This currently only does the right thing because CONFIG_REMOTEPROC
> > cannot be modular. Otherwise the configuration
> >=20
> > 	CONFIG_REMOTEPROC=3Dm
> > 	CONFIG_VIRTIO_CONSOLE=3Dy
> >=20
> > would result in a build failure because then
> > IS_ENABLED(CONFIG_REMOTEPROC) evaluates to true but still the built-
> > in
> > virtio_console.o must not use symbols from the remoteproc module.
> >=20
> > To prepare for making REMOTEPROC modular change the tests to use
> > IS_REACHABLE() instead of IS_ENABLED() which copes correctly for the
> > above case as it evaluates to false then.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> > Hello,
> >=20
> > I didn't check what else needs to be done to make CONFIG_REMOTEPROC
> > tristate but even if it stays a bool using IS_REACHABLE() is still
> > the
> > better choice.
>=20
> It might lead to a false sense of "better" -- the value of IS_ENABLED
> is cached in a variable which is determined at compile-time.

Either I don't understand what you mean, or this is wrong.

	$ make allmodconfig drivers/char/virtio_console.i
	$ grep CONFIG_REMOTEPROC=3D .config
	CONFIG_REMOTEPROC=3Dm
	$ cat drivers/char/virtio_console.i
	...
	static bool is_rproc_serial(const struct virtio_device *vdev)
	{
	 return 1 && vdev->id.device =3D=3D 11;
	}
	...

so is_rproc_enabled is still constant and known at compile time.

> That
> caching, after this change, moves to driver init-time.  If the rproc
> module is loaded after virtio-console is initialized, there's no way
> it's going to be used.

If both are modular, modprobe should make sure that rproc is ready
before virtio-console. If virtio-console is builtin and rproc is
modular, IS_REACHABLE(CONFIG_REMOTEPROC) evaluates to false and so rproc
won't be used. (As is the case already today with CONFIG_REMOTEPROC=3Dn).

> Only if the rproc module is loaded before
> virtio-console will the rproc functionality be used -- which means that
> nothing changed in reality..

With that patch indeed nothing changed yet, because CONFIG_REMOTEPROC
cannot be =3Dm today. Until this changes IS_REACHABLE() and IS_ENABLED()
are equivalent.
=20
> To properly detect and use rproc if available would need the rproc
> initialization out of virtcons_probe() and into something that happens
> either via sysfs for existing ports, or when adding a new port to a
> device.  However, the current spec doesn't allow for that, so some more
> changes will need to be made to ensure current backwards compat, and a
> new specification that allows for a late init of rproc.

I didn't understand that and hope it's irrelevant with the things I
wrote above.

Best regards
Uwe

--hzgr4aiedgk6nxy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmevJYsACgkQj4D7WH0S
/k6KUQf/aA9uO96t2pGocJZnHU//2K0WSVxG4nFOMYKCKjAZdGghi/epov61HPSE
a8HbMZohKmePEKsEcdXh6fXq/6hkoYTxBSgmEl7SdHHNCOhMv6Qk2rogifehfB0d
M2vPFvtDUK+vKVEADfSTcEafuZYqNgwonVEL4ljvs25esvLg+fHzXfN79tJXDI8b
VxBZQwI6sqmlSBE3FRzCw+pkSXmvm4QffPBiraBVI/bJqso13JsTjZYahpJMuNjM
/foOvmwioAehcpaDksZhfNw2llNVbI/aEv75wdWkJc4SHYwcToQkhSIBGZuAHJQY
43jU7Wbn96BE5dJS1zWn6wZsKq5vCg==
=FmCn
-----END PGP SIGNATURE-----

--hzgr4aiedgk6nxy7--

