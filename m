Return-Path: <linux-kernel+bounces-242328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF69286BF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBAB281E27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361B147C9B;
	Fri,  5 Jul 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sR9iynqY"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32FE576
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175182; cv=none; b=lrN+m6qKQfG0uIg2OJJGmK6JWJkLWC+UTEDDtdF2UD0i6RHgJNvjUsrr64xVwSPwkYQkpoGEnYAssxdikEuOwL+//pJrCcb6E5jfedTUWN45pe5U24jwuVQZ7cly3JCEtAyH7BQs2D7LsNLI38I7lhkHMSQbvZt2MUtr/Pu/FbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175182; c=relaxed/simple;
	bh=5wMgpOoPG/Z9o7DqiwctIEc89tEiKPxFg3+6+rlzbbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+thDc6OipFPuOnKMN5b3tOUFm1jR+OkqMZaYYH6ry6OCFxNAbhn1ohgXrPPZVfA/yqPj05oRWllLBfboxHIwWvFpfCBJe9THdL5OqmXLcb1eLKuAVUM9h9XyQL6YNNQpSFgtvP/cJb+umz59n/YZ31tIG2S3rzqX8NCgqgzC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sR9iynqY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77abe5c709so184958966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720175178; x=1720779978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UB9Y+D7M7MC5sAEpF53a1ZM3Tuy55EmwCVG25vNiTSM=;
        b=sR9iynqYBCgiu9g9K/khk5JvQSeMWv7+C/pGPg41P9fJK+07ke0B6C6PP/IK4zFEPf
         /XQrIEoie9ZXmZRTjzsH4/CkX+QcEkynDHytZKxXPF7/FZaphBUxL9ai+2YDX4OphjHn
         JJyuPqF0UlgoUzXwgNOUMhPHFw6zfk3ekmgNJDlyh+vW8R207JTGqG4hA4lx2ydy9D/7
         dtRPw5b6xUagy9o9+vE+00sxl2kYF2gTNIJ1dJGbqq0uhVOIUQKvICF7JItR1QOwWZXt
         ddkB+uCy8+j+c5ZxmqRyzE8Iizb5fWi83NNX0WjopYPo6M2zhet8YVgiqbY03mWy6QaN
         avaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175178; x=1720779978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB9Y+D7M7MC5sAEpF53a1ZM3Tuy55EmwCVG25vNiTSM=;
        b=tMDE1dyl0iHvZeISmiiObjBq67M06TCeTnB2VeLfs39+KyvQ75Q9Z7LcfHxnpSMcCj
         /uypxQfndKG/iAH3ieBgGPe7xbm0RdoYPhXOaEuT4yLsj+YClmOcwK3X6YYWLjmFeIJN
         V0jlo2pITxokfGTb4i9zIy3wI2JbsqlmiS4TAiX77P5LEhz6Yq9BB8L1PJt/oitP0eDN
         olHmQs/WwcGW8A32ERHANa22XUx3ohauEX9ym4xx87UCf7KlJB0l+iNixFOsFAwmhqn+
         a4SPmkCo1fe9jtVFD6zEz9ImMc3GHz2dT1wKqmaSh89NoI0432js5rXxvh0s9goj69/a
         syoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM56A5coZugkdbrPbFZe/6hIGTcaMvg9JNdao0eIkxbM9/+69y4yuWF62BcTwpG9DV91lwEtqIhPLODXjIFjDdtGLpfxFUdd3gwvKO
X-Gm-Message-State: AOJu0Yx0Zty+t/feHuOW/Eub1xvp8Om/oGFANd0YM/oW2GrruX1xH1Pp
	ogGYTAfLbtpxCULHq9418fsAcLl5AIJREaL74QL6pYbIuwT8wgKb0rqchNPsw32f1VSYqVR4LLG
	0
X-Google-Smtp-Source: AGHT+IFfo1Nb3BX2k70fmVGVRTNEwvNAbLsLGGVcLhfQb3/F3OvXz+sgwB1A3qwotiuKcwPh2LDk+w==
X-Received: by 2002:a17:907:684:b0:a77:c3b5:9e5d with SMTP id a640c23a62f3a-a77c3b59f8cmr214818766b.47.1720174742638;
        Fri, 05 Jul 2024 03:19:02 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1babesm670429666b.17.2024.07.05.03.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:19:02 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:19:01 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mul_u64_u64_div_u64: make it precise always
Message-ID: <3yh26lm4kiig6oyy7st3q2wge2idbzblues5q6jf7xld2mlgba@jsfny35ucs5k>
References: <20240703033552.906852-1-nico@fluxnic.net>
 <20240703033552.906852-2-nico@fluxnic.net>
 <adjv6ypwuvlugbx3uqd6q4r5hyj3v3gx4bs6cwcvj6h7llbo6v@jr4p35pkkzyx>
 <6496p439-p76r-oq72-n716-9q6757071609@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4h2dsmvvdor2ip3c"
Content-Disposition: inline
In-Reply-To: <6496p439-p76r-oq72-n716-9q6757071609@syhkavp.arg>


--4h2dsmvvdor2ip3c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 05:16:37PM -0400, Nicolas Pitre wrote:
> On Thu, 4 Jul 2024, Uwe Kleine-K=F6nig wrote:
>=20
> > Hello Nico,
> >=20
> > On Tue, Jul 02, 2024 at 11:34:08PM -0400, Nicolas Pitre wrote:
> > > +	A.v =3D a;
> > > +	B.v =3D b;
> > > +
> > > +	X.v =3D (u64)A.l * B.l;
> > > +	Y.v =3D (u64)A.l * B.h + X.h;
> > > +	Z.v =3D (u64)A.h * B.h + Y.h;
> > > +	Y.v =3D (u64)A.h * B.l + Y.l;
> > > +	X.h =3D Y.l;
> > > +	Z.v +=3D Y.h;
> > > +
> > > +	u64 n_lo =3D X.v, n_hi =3D Z.v;
> >=20
> > I tried to understand your patch. This part could really benefit from
> > some comments. With pen and paper I worked out your idea:
> >=20
> > 	The goal is:
> >=20
> > 		A * B =3D=3D Z << 64 + X
> >=20
> > 	With A =3D A.h << 32 + A.l and similar identities for B, we have:
> >=20
> > 	A * B =3D (A.h << 32 + A.l) * (B.h << 32 + B.l)
> > 	      =3D (A.h * B.h << 64 + (A.h * B.l + A.l * B.h) << 32 + A.l * B.l
>                           ^ missing )

Ack, alternatively the opening ( can be dropped.

> > 	The operations done here are only 32 bit multiplications and
> > 	additions, and with U32_MAX =3D 0xffffffff we have:
> > 	U32_MAX * U32_MAX + U32_MAX =3D (U32_MAX + 1) * U32_MAX =3D
> > 	0xffffffff00000000 which fits into an u64.  Even when adding
> > 	another U32_MAX (which happens with Z.v +=3D Y.h) it still fits
> > 	into u64, and so the operations won't overflow.
>=20
> Exact, that's the idea.
>=20
> I was about to reproduce the code I wrote for a similar purpose about 18=
=20
> years ago that currently lives in __arch_xprod_64()=20
> (include/asm-generic/div64.h). when I realized that, with some=20
> reordering, all the overflow handling could be avoided entirely.
>=20
> So I'm about to submit some nice simplification for my old optimized=20
> __div64_const32() based on this realisation.
>=20
> > > +	/* Do the full 128 by 64 bits division */
> >=20
> > Here is the code location where I stop understanding your code :-)
>=20
> Here's how it goes:
>=20
> To do a binary division, you have to align the numbers, find how many=20
> times the=20
> divisor fits and subtract, just like we learned in primary school.=20
> Except that we have binary numbers instead of base 10 numbers, making=20
> the "how many times" either 0 or 1.
>=20
> To align numbers, let's simply move set bits to the top left bit.
>=20
> Let's suppose a divisor c of 0x00ffffff00000000
>=20
>         shift =3D __builtin_clzll(c);
>         c <<=3D shift;
>=20
> so shift =3D 8 and c becomes 0xffffff0000000000
>=20
> Also need to track the actual divisor power. Given that we start working=
=20
> on n_hi not n_lo, this means the power is initially 64. But we just=20
> shifted c which increased its power:
>=20
>         p =3D 64 + shift;
>=20
> Then, remember that n_hi < original c. That's ensured by the overflow=20
> test earlier. So shifting n_hi leftwards will require a greater shift=20
> than the one we applied to c, meaning that p will become 63 or less=20
> during the first loop.
>=20
> Let's suppose n_hi =3D 0x000ffffffff00000 and n_lo =3D 0
>=20
> Then enter the loop:
>=20
>                 carry =3D n_hi >> 63;
>=20
> Top bit of n_hi is unset so no carry.
>=20
>                 shift =3D carry ? 1 : __builtin_clzll(n_hi);
>=20
> If n'hi's top bit was set we'd have a shift of 1 with a carry. But here=
=20
> there is no carry and aligning n_hi to the top left bit requires a shift=
=20
> of 12.
>=20
>                 n_hi <<=3D shift;
>                 n_hi |=3D n_lo >> (64 - shift);
>                 n_lo <<=3D shift;
>=20
> So n_hi is now 0xffffffff00000000
>=20
>                 p -=3D shift;
>=20
> Shifting left the dividend reduces the divisor's power.
> So p is now 64 + 8 - 12 =3D 60
>=20
> Then, the crux of the operation:
>=20
>                 if (carry || (n_hi >=3D c)) {
>                         n_hi -=3D c;
>                         res |=3D 1ULL << p;
>                 }
>=20
> So... if the divisor fits then we add a 1 to the result and subtract it.
> n_hi =3D 0xffffffff00000000 - 0xffffff0000000000 =3D 0x000000ff00000000
> res |=3D 1 << 60
>=20
> Let's loop again:
>=20
>                 carry =3D n_hi >> 63;
>                 shift =3D carry ? 1 : __builtin_clzll(n_hi);
>                 ...
>=20
> No carry, shift becomes 24, p becomes 60 - 24 =3D 36 and
> n_hi becomes 0xff00000000000000.
>=20
>                 if (carry || (n_hi >=3D c)) { ...
>=20
> No carry and n_hi is smaller than c so loop again.
>=20
>                 carry =3D n_hi >> 63;
>                 shift =3D carry ? 1 : __builtin_clzll(n_hi);
>=20
> This time we have a carry as the top bit of n_hi is set and we're about=
=20
> to shift it by 1. p becomes 35 and n_hi becomes 0xfe00000000000000. In=20
> reality it is like having 0x1fe00000000000000 (a 65-bits value) which is=
=20
> obviously bigger than 0xffffff0000000000. So we can augment the result=20
> and subtract. Thanks to two's complement, we have:
>=20
> n_hi =3D 0xfe00000000000000 - 0xffffff0000000000 =3D 0xfe00010000000000
>=20
> and=20
>=20
> res =3D 1 << 60 | 1 << 35

Oh wow, that part is clever. Before your mail I wondered for a while why
the right thing happens if carry=3D1 but n_hi < c.

> And so on until either n_hi becomes 0 or p would go negative, which=20
> might happen quite quickly in some cases.

OK, so the loop invariant at the end of each iteration is:

	final result =3D res + (n_hi#n_lo << p) / c

(with n_hi#n_lo =3D n_hi << 64 | n_lo), right?

> > > +	/* The remainder value if needed would be n_hi << p */
> >=20
> > I indeed need a variant of this function that rounds up. So maybe
> > creating a function
> >=20
> > 	u64 mul_u64_u64_div_u64_rem(u64 a, u64 b, u64 c, u64 *rem)
> >=20
> > with the sophistication of your mul_u64_u64_div_u64 and then:
> >=20
> > 	u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> > 	{
> > 		u64 rem, ret;
> >=20
> > 		ret =3D mul_u64_u64_div_u64_rem(a, b, c, &rem);
> > 		return ret;
> > 	}
> >=20
> > (In the hope that the compiler optimizes out the calculation for the
> > remainder)=20
>=20
> It probably won't unless the core function is a static inline.
>=20
> It might be more efficient to do this:
>=20
> u64 mul_u64_u64_div_u64_rem(u64 a, u64 b, u64 c, u64 *rem)
> {
> 	u64 res =3D u64 mul_u64_u64_div_u64(a, b, c);
>=20
> 	/* those multiplications will overflow but it doesn't matter */
> 	*rem =3D a * b - c * res;
>=20
> 	return res;
> }
>=20
> This way the core code doesn't get duplicated.

Good idea. I'll check that after the discussion about this patch.

Best regards
Uwe

--4h2dsmvvdor2ip3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHyJIACgkQj4D7WH0S
/k73iQgApn4ty2+HweeDs4tOLwjbHiUYBUDhdadONzP3mMlFE1ArO5ay+nrCoQYk
kWUD4Te/Ypz4wAF7IDjIGmVyFWSJMbhHXrKZCnXCJXllar5gP3yNcGsY9GHK8Kvs
rRqVv468TbvbXrRuGR8n13jAylAzXtE2w1i+63YK9m3cEznr7BImXfI0O4athWpX
Q4bTCrv/FyCFupPn6L5XjlYL9Mtdl4VqDZWcNO/TszgK0BQuIOY7A2f0aj0jNoz7
stL5vTDEbL1R2Z7b85231C66KBx0IGb+fHs0LfBexcJ5OuGuUsPURQkEoAwMegOT
51y7p+X5UHLRJvSPfBL3CHCj7it35A==
=Y7mF
-----END PGP SIGNATURE-----

--4h2dsmvvdor2ip3c--

