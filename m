Return-Path: <linux-kernel+bounces-236786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8048D91E708
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F62281457
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDB14BF8F;
	Mon,  1 Jul 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CvCLh9nA"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10248F9DF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856914; cv=none; b=ufEJLxjYwMjuGWMz2sJbgFnTaVH/OjmfbjeyCLJd8Dgz7y0PwKGa6PmriOEgJo02F6g5yMrGizhm0K2umKKIlLNutTrV6gREKlorbFzszZcagP3ubaYStQcbW54Gn7LW1rVpA1vhSHmbbPM7KISpOJu9kOW/7LR2BcDm4fM5iOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856914; c=relaxed/simple;
	bh=P8YG2LyxevjiJ7vKNtBwNMx6fC14gxOjGhQOFwy3PnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8QA+aUaMf6JlocpjF51XzcYBIz8cu2C8UekOqhePo8lBeR0uAZZ5D6otrAGE70VzRi+Eao6lNk9bBhhLagtUZAAShPeKR9SdA73D1HezBH2oCAJLS7sg/SbZz7shB5h/AwKa7YaK/8VVEE/MPMJbCIHUacNC3KNd/ZdkMed8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CvCLh9nA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d1012e52fso717994a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719856908; x=1720461708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=INqZmZ/BbGR0eouXTG+y0zxvAOWCJwOuHsTjqM/v/d4=;
        b=CvCLh9nA+iPm9LBrmceHUbijfnLPB/F1HIyUv5qWhAlU5/zXPI6aohMEu0bzXfIsFN
         9umQHqZKGKZXEFE6ekQKdLECyFiNkEhV6U0Hj7FcUdB3+ykbYPyRTomV1wTcJ2Wtrp7T
         g9SKgRD/bcw+yBDGnyTkds4Mm60gkwT3Pq+tAHPagKcAP/HJTm8t2gxEAjLe97egcaMa
         k9zzFZjFGpqpeN+uFKXSH4d6+w6UnzfpX7aaPym5lTGa+7bi7zEqoMujvFBLgFApYQ6/
         N/GDwzqquTKW7aqx8Ru9WfCl0TNzO44mSh+/q1dbgE2iXTXKcP3znx0qU41IaiZXbQQi
         dpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856908; x=1720461708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INqZmZ/BbGR0eouXTG+y0zxvAOWCJwOuHsTjqM/v/d4=;
        b=F3obKdQ0QWJs3A84gAF4gmGHQRlsmyN2TzD9iNwHAViKKXlqdbG8JUbOlfm/55I3tc
         FPfIDzGkpKv5ApcDwb2DYi7LmKs1M4SS4MrJVKQugqf2noy/zY/3jozEihaz3GvFzwhq
         7bIjRH9pos70PkXOqH8LOXtO4RQubAexM7W72snsGwjITK+zms3Y3gVUwAyGfgbb8VYe
         Nyx8/i9Jo8kUoFQpGSCVk7mi0yrvqhvtGtVmugyzsISMnGxgSlPa1h+rA1kR++PBAFNO
         2liQp8Lz6GhfwBXw6Ku2pVxxi7Dj9Oil8lRczWfVALoLsWgBCOJs/etoh5B3eff7wk1R
         /1HA==
X-Forwarded-Encrypted: i=1; AJvYcCUErgDjmzFuKtRksrX8R99NuDscws+BBow15uR/m5xjYkYMtq12ghmoxOpsHvWRnt7rOFTfwEhBmmuxVnYQkcKbCxpxCQi6R74pfCjy
X-Gm-Message-State: AOJu0YwL+MdGmTYRgl+6gVXvZ9ccSVda34vh947zv/TAP2H1oeaLhLYA
	toeQLWxYgBDrNXq8NOLWOiwOEZrImKfrpqgjXEA+OHKUkG/IdWl79lTWWSjr7/4=
X-Google-Smtp-Source: AGHT+IFS0IKG4SAvkQ872CcDn2q1pa+4nXgdaSgRnCwPe+UQcIA9gA5eQvrWiX4yZWT0Jl8kNs6JJw==
X-Received: by 2002:a05:6402:1d4b:b0:57d:15ee:3d18 with SMTP id 4fb4d7f45d1cf-5879f984d05mr4338882a12.20.1719856908042;
        Mon, 01 Jul 2024 11:01:48 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-586138185ebsm4680218a12.52.2024.07.01.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:01:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 20:01:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Ahmad Fatoum <a.fatoum@pengutronix.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, kernel@pengutronix.de, it+linux-kconfig@molgen.mpg.de, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/build_OID_registry: Avoid non-destructive
 substitution for Perl < 5.13.2 compat
Message-ID: <rroqnszmdjpue4q5celbqbo43hij7lqlzpdtm7odmkfwb6vc2b@qp6lgyzlxwt6>
References: <20240701155802.75152-1-pmenzel@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="45ulsa4igztdzz5v"
Content-Disposition: inline
In-Reply-To: <20240701155802.75152-1-pmenzel@molgen.mpg.de>


--45ulsa4igztdzz5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

On Mon, Jul 01, 2024 at 05:58:01PM +0200, Paul Menzel wrote:
> On a system with Perl 5.12.1, commit 5ef6dc08cfde
> ("lib/build_OID_registry: don't mention the full path of the script in
> output") causes the build to fail with the error below.
>=20
>      Bareword found where operator expected at ./lib/build_OID_registry l=
ine 41, near "s#^\Q$abs_srctree/\E##r"
>      syntax error at ./lib/build_OID_registry line 41, near "s#^\Q$abs_sr=
ctree/\E##r"
>      Execution of ./lib/build_OID_registry aborted due to compilation err=
ors.
>      make[3]: *** [lib/Makefile:352: lib/oid_registry_data.c] Error 255
>=20
> Ahmad Fatoum analyzed that non-destructive substitution is only supported=
 since
> Perl 5.13.2. Instead of dropping `r` and having the side effect of modify=
ing
> `$0`, introduce a dedicated variable to support older Perl versions.
>=20
> Fixes: 5ef6dc08cfde ("lib/build_OID_registry: don't mention the full path=
 of
> the script in output")

No real objection from my side. But if this is an issue for you, I
recommend to upgrade your build system. Looking at Debian releases
(because they are known for their up-to-date software) and their
included versions of Perl, we have:

	release  | releaseno | Perl version | release date
	---------+-----------+--------------+-------------------
	squeeze  |     6     |    5.10.1    | February 6th, 2011
	wheezy   |     7     |    5.14.2    | May 4th, 2013
	jessie   |     8     |    5.20.2    | April 26th, 2015
	stretch  |     9     |    5.24.1    | June 17th, 2017
	buster   |    10     |    5.28.1    | July 6th, 2019
	bullseye |    11     |    5.32.1    | August 14th, 2021
	bookworm |    12     |    5.36.0    | June 10th, 2023

So wheezy is new enough, and that's 11 years old.
Perl 5.13.2 was released June 22, 2010---that's 14 years ago.

I don't know about your build environment, but I wonder if a system that
old can really build a recent kernel (if the patch under discussion is
applied).

Best regards
Uwe

--45ulsa4igztdzz5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaC7wcACgkQj4D7WH0S
/k4VpAf+JeZLxCrS0r1yfAdVFivttdmpWI9bVU2Apq24G6PAS0fH7m14oZEHNFdu
giBVi7XCQGZLGlZHFUJfpXq+D3FrRt/J4zHiPeh3DIXMdMd0TNqcH9jUrwf+Z6Bm
hQZQWGl4vbUotZMcaoEGrkXbsIEJMEtF6vIT8uFqQ7C7JyEF97/V/G/JLPEzkaOy
cArfdMiXdb4A6mkbwTJ3KWNtpZQYrE63cOKyaQyFmdnGMeTYyL08pLI7bKyTere5
zpmGESHqZmZH4XrIT33MUBJN8+C7moL3id62Lfw60o+BzkKK70Dz6DL0trseLrJ1
0sUGsF0FxbdzxjfZsT95LzxtrBp2GQ==
=VZs2
-----END PGP SIGNATURE-----

--45ulsa4igztdzz5v--

