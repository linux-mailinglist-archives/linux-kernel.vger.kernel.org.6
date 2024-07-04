Return-Path: <linux-kernel+bounces-241521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCAF927C34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201DA1F20FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18944C77;
	Thu,  4 Jul 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2jADrdz/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3003D97A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114011; cv=none; b=u9JLDXUZQzYtD317b9z3x+qLMCrQu8ZkSb9tjKh1AUU5MlZrpZs2GleZ9o9lyo/GH1wjUoVVQKTQjHA/X1PNr7JGphgIWY3hac9PTVk18vOX/cg1qcymEi3w83P2zLTFGpmW/Z7KkgFmItijNC9IbUJWGE1248gZsA5Asa9vbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114011; c=relaxed/simple;
	bh=r/7H6knognzRoNJVdbqnotvkPg/HAeWVJzBWuFQoAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0IMi+7nEzMYraXvyPNmplRSnBeLhxNK5REHNlT80fYP+naA2wfuUE/Dk5iS+RR3OU8BO0ZehoSJQByeVw8/EkCDF0qUbBCwQ/PSSaPdckYIaQzqUCx/+4sArtkeS+EQYCaH35YZEDEKpOjYIQevIB7FZQaLV+jWOS2ULteDvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2jADrdz/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so1200210a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720114007; x=1720718807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bYThr6Avi7Q5TPMMzpBsR6Tm3n/6P25nssjwKh8uqU0=;
        b=2jADrdz/VjYDPFTln9x4hMXLqH1wptOiQbWnODlbKb//ejrGCYSWZnu8QTlAw8tkxe
         3O0Y3t//CmTnlyzSXz5HdBI9mC1ege4sLsSX+mlvig9TxuVWff7hm0sEjxaJJXniGykM
         oY6y0Ca+85oe5CSkKKXY65uBnZYbDOvkSlkxMF48IaK7eF0vZqRj73N8pYHhzIrc3+Yf
         7+I2Xr3zLWnYVlJOtwVHc2OLfcxXaTBG1I7cZ27v3Y73fWAPindhOOOocwaxbU/RDPjX
         1OuNyl/janKJhvMpPoY0bk/UmeDI07fOBHNojq5GMClYUyTFk8pd1EEJbxR2VLyDMh5E
         YKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114007; x=1720718807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYThr6Avi7Q5TPMMzpBsR6Tm3n/6P25nssjwKh8uqU0=;
        b=viYvZ3p9r4gSeRDLd4Z5cDdU+sESztai+bx74UtN5T9LIF/6MxPMbW9IVIxOI/boyo
         1lpsUBuRP9wBocPynds6qcne15lPkZhYD6XOc03XS0Y3CwGN1WrsKG0D57OObdEezk3o
         xB1/o9eE8ipuh+ug3S71JHATEdGvfbeUAW73+T3c19Nu2KXrOt96DIyBcCbvFV1JyRip
         w4O5uabpWPNBg5SLRex3Yx9KY4h38sa3UtOdA6F2aU4UY2EwSJ/aLAXqEIq0bkvMxgfl
         cCEarBc4Yrp4d9uBzMJ+v/8EEgo2M0Y26+ZoHJvJVzCix26Dgt0QbVTz02IPA8CX76j+
         sNag==
X-Forwarded-Encrypted: i=1; AJvYcCVuApAlaQw1xPzuVxPbUyjcjW14F4q5L9xBbk052y+zmqR04jn/4BmJAfuUAJA+mN6Cd+qH+olVtFGqsFN0HapWCHM58vVcxjWhsvv/
X-Gm-Message-State: AOJu0YxpvR1tRi/vYrxXPj4JLOvhUH+OYQIVDcItqV2lCjT21D89g39p
	EU+yBWpHTdJiGye7aM/xV5BhHtNItFe46ju1gxDn6i+emppaZC678vFPUoYJs8bQbUgP3J7MSh2
	Z
X-Google-Smtp-Source: AGHT+IHClJ+E3sfShmJrg62qHIRNvWZXU9jh9xQpeZPQ1rmk2i9X1mqT4BrhvUzAzDBIom5DWWXj5w==
X-Received: by 2002:a05:6402:2108:b0:58d:410a:32a9 with SMTP id 4fb4d7f45d1cf-58e5add2bfemr1852338a12.15.1720114006999;
        Thu, 04 Jul 2024 10:26:46 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d10ef413esm2304742a12.66.2024.07.04.10.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:26:46 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:26:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mul_u64_u64_div_u64: make it precise always
Message-ID: <adjv6ypwuvlugbx3uqd6q4r5hyj3v3gx4bs6cwcvj6h7llbo6v@jr4p35pkkzyx>
References: <20240703033552.906852-1-nico@fluxnic.net>
 <20240703033552.906852-2-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jcdtauzfvs67hdaw"
Content-Disposition: inline
In-Reply-To: <20240703033552.906852-2-nico@fluxnic.net>


--jcdtauzfvs67hdaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nico,

On Tue, Jul 02, 2024 at 11:34:08PM -0400, Nicolas Pitre wrote:
> diff --git a/lib/math/div64.c b/lib/math/div64.c
> index 191761b1b6..dd461b3973 100644
> --- a/lib/math/div64.c
> +++ b/lib/math/div64.c
> @@ -186,55 +186,92 @@ EXPORT_SYMBOL(iter_div_u64_rem);
>  #ifndef mul_u64_u64_div_u64
>  u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
>  {
> -	u64 res =3D 0, div, rem;
> -	int shift;
> +	if (ilog2(a) + ilog2(b) <=3D 62)
> +		return div64_u64(a * b, c);
> =20
> -	/* can a * b overflow ? */
> -	if (ilog2(a) + ilog2(b) > 62) {
> -		/*
> -		 * Note that the algorithm after the if block below might lose
> -		 * some precision and the result is more exact for b > a. So
> -		 * exchange a and b if a is bigger than b.
> -		 *
> -		 * For example with a =3D 43980465100800, b =3D 100000000, c =3D 10000=
00000
> -		 * the below calculation doesn't modify b at all because div =3D=3D 0
> -		 * and then shift becomes 45 + 26 - 62 =3D 9 and so the result
> -		 * becomes 4398035251080. However with a and b swapped the exact
> -		 * result is calculated (i.e. 4398046510080).
> -		 */
> -		if (a > b)
> -			swap(a, b);
> +#if defined(__SIZEOF_INT128__)
> +
> +	/* native 64x64=3D128 bits multiplication */
> +	u128 prod =3D (u128)a * b;
> +	u64 n_lo =3D prod, n_hi =3D prod >> 64;
> +
> +#else
> +
> +	/* perform a 64x64=3D128 bits multiplication manually */
> +	union {
> +		u64 v;
> +		struct {
> +#if defined(CONFIG_CPU_LITTLE_ENDIAN)
> +			u32 l;
> +			u32 h;
> +#elif defined(CONFIG_CPU_BIG_ENDIAN)
> +			u32 h;
> +			u32 l;
> +#else
> +#error "unknown endianness"
> +#endif
> +		};
> +	} A, B, X, Y, Z;
> +
> +	A.v =3D a;
> +	B.v =3D b;
> +
> +	X.v =3D (u64)A.l * B.l;
> +	Y.v =3D (u64)A.l * B.h + X.h;
> +	Z.v =3D (u64)A.h * B.h + Y.h;
> +	Y.v =3D (u64)A.h * B.l + Y.l;
> +	X.h =3D Y.l;
> +	Z.v +=3D Y.h;
> +
> +	u64 n_lo =3D X.v, n_hi =3D Z.v;

I tried to understand your patch. This part could really benefit from
some comments. With pen and paper I worked out your idea:

	The goal is:

		A * B =3D=3D Z << 64 + X

	With A =3D A.h << 32 + A.l and similar identities for B, we have:

	A * B =3D (A.h << 32 + A.l) * (B.h << 32 + B.l)
	      =3D (A.h * B.h << 64 + (A.h * B.l + A.l * B.h) << 32 + A.l * B.l

	The operations done here are only 32 bit multiplications and
	additions, and with U32_MAX =3D 0xffffffff we have:
	U32_MAX * U32_MAX + U32_MAX =3D (U32_MAX + 1) * U32_MAX =3D
	0xffffffff00000000 which fits into an u64.  Even when adding
	another U32_MAX (which happens with Z.v +=3D Y.h) it still fits
	into u64, and so the operations won't overflow.

> +
> +#endif

So starting here we have

	n_hi << 64 + n_lo =3D=3D a * b

> +	int shift =3D __builtin_ctzll(c);
> +
> +	/* try reducing the fraction in case the dividend becomes <=3D 64 bits =
*/
> +	if ((n_hi >> shift) =3D=3D 0) {

The idea here is: c =3D c_ << shift, and so

	a * b / c =3D=3D (a * b) >> shift / c_

In this if-body we're handling (a * b) >> shift fitting into an u64.

> +		u64 n =3D (n_lo >> shift) | (n_hi << (64 - shift));
> +
> +		return div64_u64(n, c >> shift);
>  		/*
> -		 * (b * a) / c is equal to
> -		 *
> -		 *      (b / c) * a +
> -		 *      (b % c) * a / c
> -		 *
> -		 * if nothing overflows. Can the 1st multiplication
> -		 * overflow? Yes, but we do not care: this can only
> -		 * happen if the end result can't fit in u64 anyway.
> -		 *
> -		 * So the code below does
> -		 *
> -		 *      res =3D (b / c) * a;
> -		 *      b =3D b % c;
> +		 * The remainder value if needed would be:
> +		 *   res =3D div64_u64_rem(n, c >> shift, &rem);
> +		 *   rem =3D (rem << shift) + (n_lo - (n << shift));
>  		 */
> -		div =3D div64_u64_rem(b, c, &rem);
> -		res =3D div * a;
> -		b =3D rem;
> -
> -		shift =3D ilog2(a) + ilog2(b) - 62;
> -		if (shift > 0) {
> -			/* drop precision */
> -			b >>=3D shift;
> -			c >>=3D shift;
> -			if (!c)
> -				return res;
> -		}
>  	}
> =20
> -	return res + div64_u64(a * b, c);
> +	if (n_hi >=3D c) {
> +		/* overflow: result is unrepresentable in a u64 */
> +		return -1;
> +	}
> +
> +	/* Do the full 128 by 64 bits division */

Here is the code location where I stop understanding your code :-)

Maybe stating the loop invariant in a comment would be helpful?

> +	shift =3D __builtin_clzll(c);
> +	c <<=3D shift;
> +
> +	int p =3D 64 + shift;
> +	u64 res =3D 0;
> +	bool carry;
> +
> +	do {
> +		carry =3D n_hi >> 63;
> +		shift =3D carry ? 1 : __builtin_clzll(n_hi);
> +		if (p < shift)
> +			break;
> +		p -=3D shift;
> +		n_hi <<=3D shift;
> +		n_hi |=3D n_lo >> (64 - shift);
> +		n_lo <<=3D shift;
> +		if (carry || (n_hi >=3D c)) {
> +			n_hi -=3D c;
> +			res |=3D 1ULL << p;
> +		}
> +	} while (n_hi);
> +	/* The remainder value if needed would be n_hi << p */

I indeed need a variant of this function that rounds up. So maybe
creating a function

	u64 mul_u64_u64_div_u64_rem(u64 a, u64 b, u64 c, u64 *rem)

with the sophistication of your mul_u64_u64_div_u64 and then:

	u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
	{
		u64 rem, ret;

		ret =3D mul_u64_u64_div_u64_rem(a, b, c, &rem);
		return ret;
	}

(In the hope that the compiler optimizes out the calculation for the
remainder) and:

	u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
	{
		u64 rem, ret;

		ret =3D mul_u64_u64_div_u64_rem(a, b, c, &rem);

		if (rem)
			ret +=3D 1;

		return ret;
	}

would be nice. (This could be done in a follow up patch though.)

> +	return res;
>  }
>  EXPORT_SYMBOL(mul_u64_u64_div_u64);
>  #endif

Best regards
Uwe

--jcdtauzfvs67hdaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaG21IACgkQj4D7WH0S
/k6FxwgAq8JU501gA+YqItMH9m98N7VVGOGVr6fe27kNzmF3Iho1JMEmAAnuLIQC
f7U5TGGHrFkIdERS3ZQwloSXKGf2Blxk5TdOm9Leqlu/XgPriQuBcYfJbupXa0jy
oktiRJlJttRcoN1t7iFsHb1bMwzsnOz03w2nKAYAkKXAYGeWC871ejT5L4sVQqbm
2EtWEtrLcnWp4wKOTegw6/Bp9g+ohDfqMOcNQ+dZ1TMa7JCHMP2kIDLjd5QvzPNb
8kAfmN3FVLaOW+L0s3PIblPnXMuffaEvy1ZQtcOBrw2Re8mddAOSr1j3VwfM6XNc
zSpWkoOGMpTNqktEOhoD+nRHqAEMJg==
=hDv5
-----END PGP SIGNATURE-----

--jcdtauzfvs67hdaw--

