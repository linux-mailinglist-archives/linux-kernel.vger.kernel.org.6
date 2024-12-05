Return-Path: <linux-kernel+bounces-433029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED259E5313
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582A018811FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBA11D9A48;
	Thu,  5 Dec 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SMBrpOtL"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE881D5AD4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396160; cv=none; b=h19UkT04+/WLr9+DOL1cNWTsP+4Hoxs3gj4UreeRAWxUyF5h68Ntx9HYD7nktx6fP3Gr+JUcfelyLim+KaHiMOMAUdYNQEpzoScr2couy7i2DALLVy4HG14Ii9gKtcUQExh0Ty6bn0314e+kzOpsa/3VIxBFCLtLUeLocTu6p6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396160; c=relaxed/simple;
	bh=AF4l6aeuX2fLoxZvJW1W+KRCKSLALJ38XhIN7Qx/qOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJFD4Sya7cg3N0T8DnBrUgXqw75vhguVRYFsB1BolUfyrs+CAW5dIXuesVB4V8X1iYusl0y0u2bZqtj2r8iHSuPRjRtYVxCUw7t5tURlSmBbt+fD2h815G51vM97XAa5PPwuxHe9pWNL8pGhm0S0PA3JYCdA7AhdXjj5EFg6lX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SMBrpOtL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e5db74d3so426342f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733396156; x=1734000956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39akCOMWUeaE+QsrfG7LB1+JbU+2qpioUetBg6wQUDU=;
        b=SMBrpOtLFsFLYabWu8Zv2sacjyVDD8f/JHaxnY2y9jY/Y5tC8d4mZZ6BLlx+DxulrE
         w4t95llKqUItdOEHrbfQvhXiHC2Gs85PltrJDyy/rTHCIqfgfXtMw4qeP3nkZViL22Sc
         39QQrSD8r8MK7U7VDnpqJepO1yOHqF5TduxpWS7T50x8GEcd24TXw9J1yIccVVk42WHb
         HfMdHTvsJnSxWMGcEm/AZmm6V2U7P+eh3z2tGgVMlAyQusH3B4V51HPrHRktPjb4nN18
         CPa+YqKccTGjhGD90+aDYYcPPBh7rwha1HpVQgzlY8iP/owSXLm8DpgtdAlekNR0qKc5
         YkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733396156; x=1734000956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39akCOMWUeaE+QsrfG7LB1+JbU+2qpioUetBg6wQUDU=;
        b=DRln6DQBLdonbmb6mQJQ7k5DdbKPIqCitFzKHHIFiFgDGHVqaxZHOpBg5U1h7K0Qjz
         IyKUxZwYb7TT2H9QwXvfNZgOCQET0w5vHfUuwO8gBD6bTtsoQ4BTBNPLspPgq4iRY3bY
         LAwv5BlaR5PyKiw5HmFMOYd+wafsqS1XK+9r7qxElEsXqE+T9BhLCPFIRkY/8zxOIU1V
         7r45BD3aNe+e9vnwAB/m3rxwilNxm/yIJulZWhN/SGL7Yez57oUR10vni6LEjh5hT3cD
         iEpa2dJXTBCjOsJuvzqj9BAGDP7orj9xCDcpNzugC/c1Aw3t3TrgPY0nyFweD2LQYI4m
         sfFA==
X-Forwarded-Encrypted: i=1; AJvYcCWmFZpR5m3GZSKFuskAUt6Hc1Wj98RhN0/OUGgcL6WtXSvLMWKbI6f+vJNfSkBiH59aSvscRDfEKAtKbF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5vXfmCWtyWVkZCsGKS9IWFd9denstLoDKsQ2UAtqTAZldBm4g
	n2eJVRAt8sYnlXB6K1g4j03m6hMGOla8dt3LiyAwAGtqNYXKjLoaSRJzm6XR0Us=
X-Gm-Gg: ASbGncssdWIewtghshX7lbqrhZAUNgMQ84XeNdtAC7XMmVtXbn6OQcRCwPbNBY59/Bd
	vlkwHdSSOqVJx+xRFO6uGmJkvm/iqmLFafVveFhgqEsuBZb58sF5a9kwn/8ieL0wStEGs4B7Uzb
	j7NNz+mCwcMvllLnDjZETcsHKPdm6H2caDIaGN3IbabQHiJp+Ovn/HwMMJzQJP8EEh5IiXcRjlv
	dPezUyjr3LStHZiJKj0XHUzMkIV7oqEUcBcNw/8rTp4gjIieOxmGMFzHi8JSJU6qB9R6VVasZ4G
	usdu
X-Google-Smtp-Source: AGHT+IGoxjZo6bYwAfvD7E5XX5REfxfUUf5BngBNE8pXoqpmil0EuvXVzWoDcm4jX8QY3WMIzJJ3Ew==
X-Received: by 2002:a05:6000:4601:b0:385:fb40:e57b with SMTP id ffacd0b85a97d-385fd3cd413mr8375393f8f.15.1733396156499;
        Thu, 05 Dec 2024 02:55:56 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59ce34sm1626705f8f.25.2024.12.05.02.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 02:55:55 -0800 (PST)
Date: Thu, 5 Dec 2024 11:55:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthias Maennich <maennich@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
Message-ID: <mfgqf5xpjnyud3qm4hwycbnz23mfik4pzry3h7fi2k6khokbgd@facrmygrrqnh>
References: <cover.1733305665.git.ukleinek@kernel.org>
 <6fe15069c01b31aaa68c6224bec2df9f4a449858.1733305665.git.ukleinek@kernel.org>
 <Z1FbOrGjaVsGKIXa@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s4byhypekrqelq3e"
Content-Disposition: inline
In-Reply-To: <Z1FbOrGjaVsGKIXa@smile.fi.intel.com>


--s4byhypekrqelq3e
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] doc: module: Fix documented type of namespace
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 09:50:18AM +0200, Andy Shevchenko wrote:
> On Wed, Dec 04, 2024 at 11:01:10AM +0100, Uwe Kleine-K=F6nig wrote:
> > Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
> > literal") the namespace has to be a string. Fix accordingly.
>=20
> >  In addition to the macros EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(), tha=
t allow
> >  exporting of kernel symbols to the kernel symbol table, variants of th=
ese are
> >  available to export symbols into a certain namespace: EXPORT_SYMBOL_NS=
() and
> > -EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespa=
ce.
> > -Please note that due to macro expansion that argument needs to be a
> > -preprocessor symbol. E.g. to export the symbol ``usb_stor_suspend`` in=
to the
> > +EXPORT_SYMBOL_NS_GPL(). They take one additional argument: the namespa=
ce as a
> > +C-string. E.g. to export the symbol ``usb_stor_suspend`` into the
>=20
> But C-string is ambiguous. Is it now okay to use
>=20
> static const char *p =3D "my constant C-string";
>=20
> EXPORT_...(, p);

I didn't test that, but I guess that won't work. While you could argue
that p isn't a C-string but a pointer, I agree that the wording isn't
optimal.

So maybe make that:

	... the namespace as a string constant.

?

Best regards
Uwe

--s4byhypekrqelq3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRhrgACgkQj4D7WH0S
/k6ScAgAiq1T96IbXljeMhp7b9YEjRrmFkHTKaVWu4HRW3yp9BpvdoiYTyhgZT1X
OhqZY2I08zkWjVz4cEjc9A8QN68/TdWjx44YBrpQvOwFg5hCIvbSKoQpVekPqObN
drj4yRYugMhF/ZDQgvD6e1dsewoziKP9XaZ9EoueAOzgT9WzqDjGzyxb1OWxY0CP
Hd6iob3658ku+8iGz3poKVCkvRdg9Rj2C7BXrrW68xmo3Azm97J4iAcwp2pwdIgn
Hoc/8FVTOc5E3Ui2oFToXRC7kS5YlaW4kU52q6c9x6p40SkHcieslUT5Rfhvj+hs
mhixOW7BEAxbCvYv9uNb+Yptv+YaaQ==
=PJT8
-----END PGP SIGNATURE-----

--s4byhypekrqelq3e--

