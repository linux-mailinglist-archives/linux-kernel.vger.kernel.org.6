Return-Path: <linux-kernel+bounces-339235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB2498618F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891CD1C25AED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4DC18B48F;
	Wed, 25 Sep 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ualRqY9i"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46A176FCF
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274349; cv=none; b=Nm84dJUo9ySNRR7e1vA+SQEv9Yw6/LjVLO/ApsdUsTuaKhdDvH+f/dhWTzqLF+iM4uNiqfxEsVPlQJju1EbmS0M92IH25X95V19CFkfmrZmxnLY2QrfqwXz1FQZJDn0U/v4gqyeacKsqsG2yIhdo37rXZ8CTqqnStjoppaefqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274349; c=relaxed/simple;
	bh=KDL3fc/DVip+zTmILQsQ5mUA8yEqMCDYmgwpg2UvFbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwwfdheCH68xRLYKViQJGMbQdFeaJNYKXkYdskNNaA2+0PALKR7tE7BwIFpkHy5OOZ2+HIHZT/wpCskUBVrvrN8idU60Rc+eHhJHJ7S4jq1gHsuydUjB6DJC0ugDzRKOVokbC6ePs12DquugHG/ojdTuTsrcrQj9nCKaDW2L7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ualRqY9i; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so67513665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727274344; x=1727879144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMdC++qY7rk3rrQR8aIH59PV+MLb5lGwhmfmrbYGFD4=;
        b=ualRqY9izl+F6QW1GiybyxwnogFG5Tyg3ca3OgTh6Eqzyk/cgu3Vi2SG233jKpBqKh
         9MV4xsTn4r9f8UQO8romc3Nwc3lhSJGIS4HUBo+hENl0jGoQ1TK/BlAlqdIiPH5Jvz99
         9Z0eG41jdEb8sUwAHikx5L+TYs6ntT0jIuezWuRlX1XUeo6BD+VKkUWhRBVp060B31r0
         Ep87Y41lRG1iIb1jRN2FK1GJCuokcxdZ7leBGHzHTzCE9oUAgRVrsxcOQdl9it1cz2Qa
         qsBQcBz3s53X7bpkSOrPzoghtKAVaz4+BWFb23XOKsQGGF2PDhKSG/N5/04bDF2iOvNg
         78+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274344; x=1727879144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMdC++qY7rk3rrQR8aIH59PV+MLb5lGwhmfmrbYGFD4=;
        b=DfVJHkD33sc+n9Agp55W2FUZJM+dwY8yBaLnWFQkR27uqcrtrTXr/lmJutLcZaC0br
         wcv8yAlFp05n0iFQUeBo+rMrQ6inOcj/nfgI6W0uhZjsPibQpzLFSsVSsQRLEwpi+GZY
         SW7/8wYkpF7h0+QgSYow7bpzDgBCLJAGDGVrqUDIDBv4gJihnaHdBxu4R54ymv+fpnPz
         8vvaR6typjn0L+s1htJhQDb9kU32gu7+3g88/NtuAWykXWLYOLA/82zPL59bg9Ny7GD7
         ibc37IM4TrmguSKqr30Zq5nIO1WkusCsI2sRwYz+fJEJZR0KgxqSWdkz05Y+d+dszXgr
         KyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1jGf6UbVBUYyyPff7jNBRu0kvZ9pYGQdTVkaH8QE+R+EaSk7faAULnGza1GS9VehjgHeR8ZWOIdFyM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx05siRH6RJhLo938CqrE8t4mQZPF6DANtWn318RjUsbpJeQ/QQ
	ng7DquDxvj5iCghgfi6mBNB5QnVV5uzibtogzk+/cjn9HUH5QB5fULkYU5lBAQU=
X-Google-Smtp-Source: AGHT+IHWaX6a+qAUgSVMeUS2Xb61NSPYXDbaOrPtpkPHR1ppdbx4xlkOU3UXyFtL1lddiwwLa0+A6g==
X-Received: by 2002:a05:600c:3c94:b0:42c:bfb1:766e with SMTP id 5b1f17b1804b1-42e9611df1amr22258915e9.21.1727274344021;
        Wed, 25 Sep 2024 07:25:44 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a56fddsm20442595e9.46.2024.09.25.07.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 07:25:43 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:25:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH RFC 1/3] reset: replace boolean parameters with flags
 parameter
Message-ID: <hdw5pdty3kwvaxh2hluvx7ia7cygmglcgiee3j6nxcyywtmkcx@dqebckl4h3rz>
References: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
 <20240621-reset-get-deasserted-v1-1-94ee76fb7b7d@pengutronix.de>
 <o3rf7gprs7mrldglqg7e4scibumdno36iuvtlr3c43sofjcb2t@w3d7jsjyddxe>
 <5500e3d44be69f5bc843e5b2159f6d0aead24ff9.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vocizteivbkv5i6w"
Content-Disposition: inline
In-Reply-To: <5500e3d44be69f5bc843e5b2159f6d0aead24ff9.camel@pengutronix.de>


--vocizteivbkv5i6w
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Philipp,

On Wed, Jun 26, 2024 at 06:17:11PM +0200, Philipp Zabel wrote:
> On Sa, 2024-06-22 at 09:47 +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jun 21, 2024 at 04:45:02PM +0200, Philipp Zabel wrote:
> > > @@ -999,8 +1001,9 @@ static struct reset_controller_dev *__reset_find=
_rcdev(const struct of_phandle_a
> > > =20
> > >  struct reset_control *
> > >  __of_reset_control_get(struct device_node *node, const char *id, int=
 index,
> > > -		       bool shared, bool optional, bool acquired)
> > > +		       enum reset_control_flags flags)
> > >  {
> > > +	bool optional =3D flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
> > >  	bool gpio_fallback =3D false;
> > >  	struct reset_control *rstc;
> > >  	struct reset_controller_dev *rcdev;
> > > @@ -1065,7 +1068,7 @@ __of_reset_control_get(struct device_node *node=
, const char *id, int index,
> > >  	}
> > > =20
> > >  	/* reset_list_mutex also protects the rcdev's reset_control list */
> > > -	rstc =3D __reset_control_get_internal(rcdev, rstc_id, shared, acqui=
red);
> > > +	rstc =3D __reset_control_get_internal(rcdev, rstc_id, flags);
> >=20
> > If RESET_CONTROL_FLAGS_BIT_OPTIONAL was passed to
> > __of_reset_control_get(), you're forwarding it to
> > __reset_control_get_internal(). But the latter doesn't do anything with
> > that flag. I wonder if the API would be still less prone to error if
> > you'd filter out RESET_CONTROL_FLAGS_BIT_OPTIONAL before passing to
> > __reset_control_get_internal() and in __reset_control_get_internal() add
> > a check for unsupported flags.
>=20
> Yes, I'll do that. For every enum value with the optional bit set,
> there is a corresponding value without it.

Do you have this still on your todo list? I just review a pwm driver
that would benefit from devm_reset_control_get_exclusive_deasserted().

Best regards
Uwe

--vocizteivbkv5i6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb0HVkACgkQj4D7WH0S
/k6dIgf+MAeEkas4X5vl8yDIQ5QW6XmIHiAnGGra54GS1hBkgD+3LUdnSED36zdW
ad8EpLF4tMlG/cctGyTgLgpHzO2D6dxuCFRL9HyDLOUogQCIA0/i4rF/xs8M+etA
yoPB6TIe/RiPk/RWLqnJ4LSoctHq+dLcz9sNHOe5LsySjTyzJP+Dv6hdA7CQntMr
P36s6uEKshDaOkpchywjfPzqobbRBDOIiOkTElXcJVdfWlv28MG38xn4xorrxxDX
z6/2M/wCsY2fQJ3mPoZHcok36L9xdDQRs7bDATWASDuWFbOLzgKDKKJni3JNF4KQ
kZqY53mHuyhbYx09G2NoCm+9xLsJmw==
=Bqe5
-----END PGP SIGNATURE-----

--vocizteivbkv5i6w--

