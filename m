Return-Path: <linux-kernel+bounces-435140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0E9E70AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04FF16A2D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CC2207DF8;
	Fri,  6 Dec 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U9pId0bi"
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC2E203710
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 14:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496359; cv=none; b=mhfSYPD4gjDLjkGwJUVE/xQx4nAgqWG0iWWrr45uu/gXHd3GjvMtbw8u1QXVdjCMEbc21D9cZOLnh4qOSjje0QdiaX7TSTy6knzsqmR7qPz59eA9C6poChYMHX01cstVZuyBQ63bMm235aAeoqK4K0MBK752XROJ3RE5BizLKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496359; c=relaxed/simple;
	bh=YGeEtCKq3iU0NBpubva75CGG0kEYAXe3ybNXoZyZmF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWm9A75o1iS87kbi+JlAG2bOvISXCo3CdwBUEWPfTHYAO9ulS758MAwGtMGsIDQSloYl1G5tHeBWcKIU8DKMdgLHcxgkYRmwRSe7guP9yMhiP2g7bYK+O+CWZFSJEncv7SCSkdynijEenlSY6HwUNcmq63JHKSnApNX7nRsS6J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U9pId0bi; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5d1265ba5a8so2393695a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 06:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733496355; x=1734101155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1naNItJmzQ5g6ZFSIYj9aFToXW2l3jmmypLl/wgICNc=;
        b=U9pId0bisip5BNSgk5d2bFED/wnQ1JJG/F96aGTD7lRYSgTOkUhheDBhWAtC8qzCIk
         pFWbRV9A92tN83Z4ZdNuHNmauywuG+Z7/rmcH2khtqegmemf+jSsblLGBRjG8umEih70
         b717R4TBGNtbECYxNxLtwwrRetRLOqFasYU2qAJtJPipHtIrFY/a0EWd+uV4I/9KnVi9
         HGmXjtTvDE8nc0VyhveDBBdeYlwxq754SlJNM+mnxfPV0kv6WUrFDUuTSA0lgjDOCKTQ
         Q895a+UTm4RftcHl+r8Mqn3XJ3BgZPJF/DN8iEcFtYfgxStmjHFKusUvh+yp3c+dd3bJ
         QRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733496355; x=1734101155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1naNItJmzQ5g6ZFSIYj9aFToXW2l3jmmypLl/wgICNc=;
        b=AWV5fxkSHxICyplU3m60GbSkbo7VP4nFhI7odtLEZISywmeP7gbCH2SqxAoy6I8zSg
         X2Gb4OyC9Bc3A+t0/+aWiZfSgcFE8wTLj50JcdU6m8bnVCF4T6/sz3bN3xnp3oz/Z+k+
         lRdqC1yq5cEG8mDPTcRIw6QgtGNFKZlWRAMHJfqnvVblEySej4M1yGIL3gFGV8VnYY3x
         kTFlFbF+vG2BkwRHxJUovwbPSI/XvW/fZM8NNU8upB9BhOOMk6yEnMi12BC301cHBueG
         P0rdg8hcB1rl93zktl2liGMpaYjM6OWoz+SJ2JNbv3vrHYK+nyxsvns3pqtZ5dIf1aMi
         Od9g==
X-Forwarded-Encrypted: i=1; AJvYcCWnwn8tKWwrvqP8Fq1JKAjYj48H5qZ6jYk5tHvZM48FtYRlEGmwAhUkYD1K2TTHtohYCw5BRzqF8EwC9E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12/dBv/oppNNLp3jCdS+aDiT4VbOZYzuAfKI5iUkcpL4TKZT+
	yLmMvc3/SUv6OHSoJRFprLURRBVIm/Tp/IsrVO0ybY3bl+ur16v3cVGCJR1zNak=
X-Gm-Gg: ASbGncuLDOIYLsQdIfbfBSX8I2LB49Cgp0T3qiEwHqhbOXLNVwpvzPMl+S8qDuLS66l
	IF/asV3G0643cFJgH3RCXRF9YPK/GzYe/zRv8WOgFSHGXyJqVSpJmN9taPsLZ68dd1BEaLvgqXK
	vCb8Eh1iKLJZdUhEst+34ar4TiZag8OGZn0DgxWFiLQU7mRRpRn8uY8WPj/z52RoHr8mQ68FwKE
	3K7drUBY3QeEPfPRSBvMYqA4vg3i1Gixu5VpS5K98ZxF/nz9OKEyg==
X-Google-Smtp-Source: AGHT+IGsLAMVU9kIz0u6ExvGFnLit3F2iF/fgasvZYu72DF3l9zd4X23NQjrrunUmVEzQ2ltjRgaFg==
X-Received: by 2002:a17:906:31d1:b0:aa5:4b7f:e70c with SMTP id a640c23a62f3a-aa639fa5f76mr225052466b.6.1733496353790;
        Fri, 06 Dec 2024 06:45:53 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:f267:d848:5e2:8699])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4da21sm248542966b.33.2024.12.06.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 06:45:53 -0800 (PST)
Date: Fri, 6 Dec 2024 15:45:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Maennich <maennich@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
Message-ID: <zsqtlottouotiklytvbqapexuopzxlasqod7ynohu4yhtnr7no@j2zqryrst7qc>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
 <Z1FbOrGjaVsGKIXa@smile.fi.intel.com>
 <mfgqf5xpjnyud3qm4hwycbnz23mfik4pzry3h7fi2k6khokbgd@facrmygrrqnh>
 <Z1H5UqN-egUs0GhJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="okrgf7btsuqvxlmf"
Content-Disposition: inline
In-Reply-To: <Z1H5UqN-egUs0GhJ@smile.fi.intel.com>


--okrgf7btsuqvxlmf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 09:04:50PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 05, 2024 at 11:55:54AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Dec 05, 2024 at 09:50:18AM +0200, Andy Shevchenko wrote:
> > > On Wed, Dec 04, 2024 at 11:01:10AM +0100, Uwe Kleine-K=F6nig wrote:
> > > > Since commit cdd30ebb1b9f ("module: Convert symbol namespace to str=
ing
> > > > literal") the namespace has to be a string. Fix accordingly.
> > >=20
> > > >  In addition to the macros EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(),=
 that allow
> > > >  exporting of kernel symbols to the kernel symbol table, variants o=
f these are
> > > >  available to export symbols into a certain namespace: EXPORT_SYMBO=
L_NS() and
> > > > -EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the nam=
espace.
> > > > -Please note that due to macro expansion that argument needs to be a
> > > > -preprocessor symbol. E.g. to export the symbol ``usb_stor_suspend`=
` into the
> > > > +EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the nam=
espace as a
> > > > +C-string. E.g. to export the symbol ``usb_stor_suspend`` into the
> > >=20
> > > But C-string is ambiguous. Is it now okay to use
> > >=20
> > > static const char *p =3D "my constant C-string";
> > >=20
> > > EXPORT_...(, p);
> >=20
> > I didn't test that, but I guess that won't work. While you could argue
> > that p isn't a C-string but a pointer, I agree that the wording isn't
> > optimal.
> >=20
> > So maybe make that:
> >=20
> > 	... the namespace as a string constant.
>=20
> ...a string literal.

Gcc calls it "string constant":
https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html#String-Constants

My C book (https://www.amazon.de/dp/013089592X) also calls it "string
constant".

So I tend to keep that name as it seems to be the official term.

Best regards
Uwe

--okrgf7btsuqvxlmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdTDhMACgkQj4D7WH0S
/k6XIggAr72APIuwK8Z2rnlUezHAca6BECUx010mnTEh+NlPfksbn0fmKK/GdH9s
wB5Wjb8tpYqvMoAZbX+629Fxj7HtyxtI6uyjLfuRrK52hrzl8WIpoNH7m1j6gYrg
UMPA7YsoacVB/PYn5Jq9crxACIUaWEDMMprg8GEJv0S6QQ/BSl4GTOWCuAW57fmf
ObSxONffTmNH2JXj06rJrFuecEWZJsDDwJq7M10tgRO2eXxRoVm1iq5J1RSMmSjl
UpUJWalNDz34O8WYAvhFw2/6I0flonRflRpXZUnw6aeh6tW9XGKw8acl8itwedmd
AYeanf/POnlI/oHyscN7NG+uVinaLw==
=To0M
-----END PGP SIGNATURE-----

--okrgf7btsuqvxlmf--

