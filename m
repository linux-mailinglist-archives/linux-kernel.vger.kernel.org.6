Return-Path: <linux-kernel+bounces-251493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B723A930588
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C61B282437
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D1130A73;
	Sat, 13 Jul 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y4toi481"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068321304AA
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720872900; cv=none; b=K9QRa7FrQuhSwAos8RZcIfQk0PyqOYW/BnnN21/DtpJdPrZXn1XCXui2Jl9bd/VgIo7H95QOAjJteJyS09UM/f8Hg1+QfCJaFN+ICETq20dgLwhrbgUIYn9rH2HSO0u6OxOo3XW0EyjhvCY1jNh/eueJzC39RT3pE4+iQyCTybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720872900; c=relaxed/simple;
	bh=Y+rfRUfoBJhLxCxnjm+aFFyX3BgPBXaRGjm/VD6qSj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYTWqT8AScy4q1c9Cj7IZE9j8sTiOtb0K+vJz/qYwjargMHCrRSTEyb8YsuT+jlzI3/8iwLfc9ms5qphzdF2It2sBfK5nPjudR+zvZTFHCl0ciSVSAATYI1JZFPXJaFK/NXDOb9WxcmLHfe1sxRjD7hbkalyNsOOJjcscqm21Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y4toi481; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so3515017a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720872894; x=1721477694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFVv/L7bL8mV8GIBZrgZbPTf0m0va8B62p5TSxRgz5w=;
        b=Y4toi481BWwoEoF2uNTcSNZAGensd8ZznOCrdsESqw+BxWDLC5BWZgyVwbWTk7XIrc
         Kwry+FqFoOwTeOmaHMbOlJUweFcCkmE6qVkV9Rc87oroEFtPOEeZORS92ppxJ1Eu1h+P
         Ek0EYQHTReM7n7XcVPjlpfYt3PZdXN7ohug7UPkteTRcMmCwAboA/5nubaeXYyErC55q
         hP5UOOVCm19ZqdZHejOCAUvqtD7uMpO6O6xRfRMBH+kqblqHL7DA6nAd/cFCKQ7cpI3t
         FcyCu5+KFmPfQ3XuUIUjhl5GagZXxvecMCdLE+tGPWgD7qQJFJ/czUMCGaCcZ01yt7bo
         M3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720872894; x=1721477694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFVv/L7bL8mV8GIBZrgZbPTf0m0va8B62p5TSxRgz5w=;
        b=SBsaqRFefDx6LFZ4Wr72sAe9e3Uq1wVur/tI8D0TvmR10b3kSwIY5XjsGay5UlDSXc
         Huz+M6KAqiFLGGvAW4QMMclyiW6TF5hwQDJD9pvB6NfDCXEXR5MggkF5QfxxlR8bw9Dq
         2goMHbm0ThMUeplG89sMufeHAuT4jYsQal6vAi7/JhD64KIpLUg1VeoVh9r+eqeWzRAs
         QcVpGjDGS01iaavcarJ0ol58mXeaOgko7/FuYGEG9xuQQBxizutbiMVek1MPU4stbAua
         ncY5vg3gcxC21v9jTiF31hhMGE2rqBygRatlZLPCqiM/50MVQl6Pn1oz6FE+1SwlJa/w
         B5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYckdqPXvjWWnK0wKmZcZUAEFWdA6LNWA1FGtXHbbX6TdzVphZV6HAQVvFShHWsrh5YilnS4aEb4pcmY4FI4hgBZ6iS3inufQgMvTx
X-Gm-Message-State: AOJu0YwBUKXOxAEy/iyFVSsjKfE3gUw7gQQVJOqJOWrNBO1Whuz2d+lu
	2r/8U4+0k1ahed1uNvleIcxSL5WZlifd49/N+1xLl+qo2nQa4eFX2pNbEEPhnAI=
X-Google-Smtp-Source: AGHT+IHRLvi4VTJwHJXOcf1UYY35QEkAqVTjPFAEAPHKY3qYOn2w0Q6yCR9dBETpCb+tkTP0HaUakQ==
X-Received: by 2002:a17:907:94d2:b0:a68:bae4:d66f with SMTP id a640c23a62f3a-a780b6b2fd4mr1114275266b.30.1720872893272;
        Sat, 13 Jul 2024 05:14:53 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:3c82:4e3d:25d1:b685])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff707sm46728966b.146.2024.07.13.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 05:14:52 -0700 (PDT)
Date: Sat, 13 Jul 2024 14:14:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mul_u64_u64_div_u64: avoid undefined shift value
Message-ID: <cel6yaebrspena42tv7mewvd7vvnnzycr2pgg4zkh737uwokro@kzxoxatbdodv>
References: <7rrs9pn1-n266-3013-9q6n-1osp8r8s0rrn@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rom4gndzyvmfuzf"
Content-Disposition: inline
In-Reply-To: <7rrs9pn1-n266-3013-9q6n-1osp8r8s0rrn@syhkavp.arg>


--3rom4gndzyvmfuzf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicolas,

On Fri, Jul 12, 2024 at 01:41:46PM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
>=20
> Shifting a value to its type's size or beyond is undefined. This may=20
> happen if the product of a * b is not more than 64 bits despite
> ilog2(a) + ilog2(b) being 63 and c having no trailing 0 bits.
> We end up with shift=3D0 and n_lo >> shift | (n_hi << (64 - shift).
> Take care of that case and add such case to the test module.
>=20
> Using __builtin_ctzll() with 0 is also undefined so take care of that
> case too.
>=20
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202407121652.69e657c5-oliver.sang@=
intel.com
> ---
>=20
> Andrew: up to you to fold this in the original or queue it as is.
>=20
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index b7fc752463..5faa29208b 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -212,11 +212,18 @@ u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> =20
>  #endif
> =20
> +	/* make sure c is not zero, trigger exception otherwise */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdiv-by-zero"
> +	if (unlikely(c =3D=3D 0))
> +		return 1/0;
> +#pragma GCC diagnostic pop
> +

I wonder if that does the right thing for clang, too.

>  	int shift =3D __builtin_ctzll(c);
> =20
>  	/* try reducing the fraction in case the dividend becomes <=3D 64 bits =
*/
>  	if ((n_hi >> shift) =3D=3D 0) {
> -		u64 n =3D (n_lo >> shift) | (n_hi << (64 - shift));
> +		u64 n =3D shift ? (n_lo >> shift) | (n_hi << (64 - shift)) : n_lo;

Maybe it's just me, but I'd better understand the following equivalent
assignment:

	u64 n =3D (n_lo >> shift) | (shift ? n_hi << (64 - shift) : 0)

or maybe even a bit more verbose:

	u64 n =3D n_lo >> shift;
	/* Shifting by 64 bit is undefined, so only do this operation for shift > =
0 */
	if (shift)
		n |=3D n_hi << (64 - shift);

With or without these suggestions incorporated:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--3rom4gndzyvmfuzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaSb7gACgkQj4D7WH0S
/k4I3gf/UGqA1XAQagbbMuYAg6pjg/telqzlQMF92XwjK6bjCufjdWuz5zemGZ+y
vFzsuyKzE3quEqK4DwfvWC1Ag7FQbHL9cK9AgiyNc0JSzx2Ei3r9hVGnt3gTiQZ7
qf/o77Hy37IRnpjTZroyTSIXGZB7fXmAamYKGfBrTRIovXKSlKYrAfKJrFa7lik/
5Aga6SthbOcYpucrFSaNFpJ4KsexQ27jnw7/t9L0QeHyyfQDo3xqUmNhooxEVSkn
PczSV9J7ZXlwLpLCuwYWOCRRm6jDXSk6b2zyInq/QJgSIYSuBqBmnW9DdoKBUQI4
6eWk7dwBacT5yl3L554aDMBcp+mtbw==
=tB3/
-----END PGP SIGNATURE-----

--3rom4gndzyvmfuzf--

