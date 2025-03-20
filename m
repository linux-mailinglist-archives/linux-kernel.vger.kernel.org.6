Return-Path: <linux-kernel+bounces-569245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F58A6A080
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79B13BC9E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0AC1EE7A9;
	Thu, 20 Mar 2025 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TD3VhciY"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A06C1E231D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456182; cv=none; b=dqGT8wJe4p4SFVeznA3wbWQF5mQIWVxQ5/NCnpM4Q6hby2ukPlPuoISHLavVX2CCCy+MOQsEB9NnoQ47RIPaXcZRgACTWZNXbPxkIsMJHgsvh8xF1XSynTSmUCiES1i6a87+2o6zIS+llRxz7kEjeyXWLkeKBVkcmqJ4aY3L+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456182; c=relaxed/simple;
	bh=bdB66tAWuasDBvRCM1SHSNfiZat+aBN+1vu6+30XVE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxlg26f7M+a88d7DNm6I/zfZx0WdxW6AvvELxWxz+zCEHAjtGWdnM4iyKEoOWP9zFCTmDPPOCU4BsNFTgqPY4IRXyDMdRbJ2r2KYINXp2bn2lr+7yItZ49Qi0ODIp4g//GX7GB8XFVbY/BMJ3Omt2pxTwfgpdgWRwdWt11TSey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TD3VhciY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso896344a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742456176; x=1743060976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WtoW5rZZbHQHZ7OVpedCSXnwfsSJDuIABkK5VZMsEM=;
        b=TD3VhciYvhT4tVWUgJmRti39q1LyGATz4mPfR5FyqJge2CcLHMcRC+JMTDCLcRybo9
         1mEfUosj8ywKu8JsLrSE2vniB6Jilx8h4YBjSHYmf1cr88n0+Uz/US1YJ9fvdX2raKqp
         mjEfg94WO8zDLaNlJ3RPWwnSEy9Xv0cnVahVB4mM3S8O/QK5LRTH/EJzn2JSoSS3QLL1
         W1p/n11d9QpM9CntHu089D1u+T6tDcRXCSWWgHwXkr8XURd9Y6xXk2EYGf+O9JLFP8Qq
         TTWwXoNLXSezQ6K64LQGpRvjdYndwF80MgiX0Kelk66yG1oZFeQhYp3asG53jhqtE6E3
         pGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456176; x=1743060976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WtoW5rZZbHQHZ7OVpedCSXnwfsSJDuIABkK5VZMsEM=;
        b=eEsjKnzbi6SZOa++3Zl3CpC/bmKrdzhtKKwiPMay9hdZDh18+KXM8KmWzHEwaDXhtS
         913gCMvURFnASoUfBUq5DJBg/nilIqXvVzCLfAlE2OVqnh4oibNHWGJHLgvvIya65IDZ
         RGdB3yFRQpkyEN6glFbhnFA2a2WzLtI7brbXite+ofBIwaqA6zd4YoIbqFZHg4CJINvK
         M0TBU8jWuJ+goQKWxzaM1/MDr9Jzb+BFiXBTlJR9nKTNUn5DQgykRT7mmOLuQ4utdOt0
         km06aNlhB6NbdWB1ZRFEjHyX18un6OzL6cZJdhGbtIc8JfHhLrH3y3SgfVQTtDL40GFx
         Lp3A==
X-Forwarded-Encrypted: i=1; AJvYcCXTF8Kzv6DHHLNXyu2Q0WPscjEPCQGq9HVyRCCtVVyEnewMe8d/4U9Evh5b0K8wAubByfnHhpqWlhLE0V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ApIBqByVR9UauayU54FBSRzi6PL71pWZyQwhMKs+tIizH6tM
	sVVo7WochG3zsUJ+w5Ed4DimQ9j70h0eMjGoKd/orM6rQrFmsyxHI88K86QH1njhgD7mU0MpMqZ
	I
X-Gm-Gg: ASbGncud/zqIOtW83J5uQoC4MPdLwWzMycWom44mAT0giYWqZ0sY9FOe8/kJlKhEYcL
	oIIiaXMIlDMaB2ibGtkXtZUEPdnGwuV+KBvI2PhwMnJAc1aePWD9w7d8qoeUn3KRpDbXnK42mtu
	Djrw8fRE+2N5HvH3s4eeJbA/AFZQ2AYtYqeePW4/lhYkgKVFJPYAkqZuGyNSz8n8+3cTvV8iSrn
	YBNDNtGxbHr3uGLf+IN7lZPHFvmG/UwTdLUerBenJCrVd3KlW6OUmNNXBKGdRw8avyLtJHdaWKC
	qSR6AYlbUD/jiOopqe1Xv6SjfiIbczRrSoHaf6uBKD8yx5KSWw==
X-Google-Smtp-Source: AGHT+IGFdGHNNy7oLj6mDkR8lMQDEyx3BUL4UCz7al1rY+BddtklfsP4Dp29HzFVAHkf5oGhVMThrA==
X-Received: by 2002:a05:6402:3481:b0:5e0:9056:33f7 with SMTP id 4fb4d7f45d1cf-5eb80f7042bmr6513104a12.24.1742456176250;
        Thu, 20 Mar 2025 00:36:16 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afc851sm10020223a12.66.2025.03.20.00.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 00:36:15 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:36:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] math64: Provide an uprounding variant of
 mul_u64_u64_div_u64()
Message-ID: <sga4nmj2jsvglpazvzbwtuvarvciu7phumgye3m2tocfdyjjoj@o4fygeq3jbg3>
References: <20250319171426.175460-2-u.kleine-koenig@baylibre.com>
 <66rr3q6p-2449-6722-0716-s5245pq4on9r@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mpyunmnau6l4iyma"
Content-Disposition: inline
In-Reply-To: <66rr3q6p-2449-6722-0716-s5245pq4on9r@onlyvoer.pbz>


--mpyunmnau6l4iyma
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] math64: Provide an uprounding variant of
 mul_u64_u64_div_u64()
MIME-Version: 1.0

Hello Nico,

On Wed, Mar 19, 2025 at 03:38:03PM -0400, Nicolas Pitre wrote:
> On Wed, 19 Mar 2025, Uwe Kleine-K=F6nig wrote:
> [...]
> > +#ifndef mul_u64_u64_div_u64_roundup
> > +u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
> > +{
> > +	u64 res =3D mul_u64_u64_div_u64(a, b, c);
> > +	/* Those multiplications might overflow but it doesn't matter */
> > +	u64 rem =3D a * b - c * res;
> > +
> > +	if (rem)
> > +		res +=3D 1;
> > +
> > +	return res;
> > +}
> > +EXPORT_SYMBOL(mul_u64_u64_div_u64_roundup);
> > +#endif
>=20
> Might there ever be a need for a _rem variant similar to=20
> div64_u64_rem()? If so the _roundup could then be a simple wrapper.

If such a need pops up I hope this synergy is taken care of. I wouldn't
proactively create a _rem variant now though.

> Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

Thanks!

Best regards
Uwe

--mpyunmnau6l4iyma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfbxWsACgkQj4D7WH0S
/k4CLwgAmvyuwMd/a3ashzyH6lTDikiQ6HgnuQydinHSGg22Dwsnykb0l0bUDil6
g1ZYfsum79mxeYdfzPUdvtYO1W7ldyHAMq8pTKTfCBxyPOzh62td2GXXG33dcU4X
YnIZnLaJfjNqQX526Ux/928Tihaq+UuwZKci1GZXnKM8Xx+sNcgWvnX7xV33a9e/
He+LNNuy8MQKh2AG1DfLO+8/VXDecYSwk5PkBmC79MfZ3haKc945yq3Rh0eLyNzr
69gHqdvO9sGjPkVJfJWw4HPdp9ZSxsfbd2tut8v2Iy3ySfRLIDU3uK3CUAP29qA7
s3rZqlwYqEX+2YUiaTwT4PKAOzBZJA==
=y1Z0
-----END PGP SIGNATURE-----

--mpyunmnau6l4iyma--

