Return-Path: <linux-kernel+bounces-428877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC39E148B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAEDF2824CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D418A6A3;
	Tue,  3 Dec 2024 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r/HaOau2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34EB18BC0F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211870; cv=none; b=GxhbIPXNfjgc58kOaRGXA6Y0Wne02Qv0kXd1/7LNun491jqcQhO6HAs/KXhivqxgj+mx/OysoyAU81ivV463jdO6s7a65G0k5BkWhaGMOwDwbMW6oN84vQbJMC2xFSz3dSAdyyVi+gR2+/ObmoNOnvinKC+q18knlSj0jAakoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211870; c=relaxed/simple;
	bh=6dfObkhr3VCQH4PYYV/ugsWP6X3czEJKPWN3F6/TI+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4v5A6k2ihAIBwPbEcdENLhfGu2Dkrv1cZ6ZSwvfjZbjurtWtAKmxXr4EOqGFAqpGoKi7whKP6FuuKk5tE+QaIPQ+hM5eqfXVRGmwGFR61gZSGVrac/PRF6SQYpbCHiDD4pYFnJHeZtAGAJlL8aussUiid1/4xnxMVifsy7vrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r/HaOau2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a766b475so47664235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733211865; x=1733816665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JiegeBW3gvq50ONmLpN2+Gv0YFSUffnLfjliNvLwQhM=;
        b=r/HaOau2JSTWV+Q5yT2Zy60rAnM9vObgGPAdUSvU+hQz3pdVXbXsZQqdsSylldrMJy
         fQ2jdScUG6NntG1whE8LURR/2k/nerVT///klTDoULjn5xjf8qDibTQuIxAHdv21k88/
         GXz+VUWfHfLO/k4lPmV4bpgc1MCEB4qsptjyRXRsWwOdAJLPYnNJgr0dJIRrF2u0kzkU
         1OiHmjNrwF3gediwJd5IYLdOYLYwkSxXMGQ5GzXvMmJaC1GoymCYcnOMffe2n6/SZk48
         TBl0lt8rF7c65tKx96BUOJJ1IKOHxGz7brrnGg29z7kIb9p254lpNPS1EjZP8M8/RH6p
         5gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211865; x=1733816665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiegeBW3gvq50ONmLpN2+Gv0YFSUffnLfjliNvLwQhM=;
        b=sUrlzpQIAGvT1qkB3RFJz00hIC0GBmePI6TQYBYMCOliPOanCbPXKipdGL+uynupCN
         aAvcmOv4we71Z7jclNXQY4RR3EOV1G4cFzim5kMBxazIx9A+mwMwhopQXKF+t0IsottN
         6RCejec5Z3sP8RCTFmp1ui1njlIga18HMBN+QLEIvD8agqrGMyZPWJshXjoa7pn/+nHP
         BIDSpn19wJ6z9+uKqgfAR2zWDBSKXdGWJblEg0dIl1x+F3CnT7fuoyojRkFjrLlR5Kif
         l0ca/Vwb7Taj/9KJ2MT62sNrmpvfV1VuPcKcv299mEWu4MPGF+Rtqb0MjZYfbGzeS+Ak
         qBJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzpGdW3ZVaglA+FgSSVzCF56T4Kc3NOLkZssORNwQhiuqz7ZYwU25k5GQfrilaMJt/zlfJ2D44yEvMv7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuraa6ysmWFb+Bt+Yn8kC3ETbn+bOSoHjxrUPm5Ur/GbdY0eyW
	leqWo9CBA2xxN84MkxPWcTbQw99EEW81BXWPGkIdwdYu1VMesdLjFHRVduZiaWQ=
X-Gm-Gg: ASbGncteo6aN51j+buV2TIua08Vh6utgXcUPOol7ie9FqlNH4TSPnFCJKqBzxEb4MKJ
	s6PuRDi7wzhicRwbWKcb6AZATgemy+0YkLnZlrZSCbosQVRZ6RBrKPBWNJXm5F9+8rK7d86GFOw
	tEGIcRihV4+G+rqEASQ9+KNvTz9rqLy7E7qvR9Da//pl7hfqPwLQmTAhGJc2m8Lu1mijTJCSVsS
	LJUnlL08l7bpzv5M1wp6F3dNWV5LM0xUcgyZ+ZVohXosN2qyoF94Ig=
X-Google-Smtp-Source: AGHT+IH6YbOpv9kzPhAMqQrIJCITE+muE0XBmdA6LFY3FyAvHT0djm6Vn15wDM5GWfY0KDY8HYFuxw==
X-Received: by 2002:a5d:64e8:0:b0:385:f5c4:b318 with SMTP id ffacd0b85a97d-385fd3ed9e9mr1075933f8f.31.1733211864891;
        Mon, 02 Dec 2024 23:44:24 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:a762:9242:cbea:d7fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cb2sm178103165e9.37.2024.12.02.23.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:44:23 -0800 (PST)
Date: Tue, 3 Dec 2024 08:44:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH v4 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <xsad2ppunbogttgzenv6ilwdob2xcoaemzdk5ili7owczqo5uo@nhjjdkqedjtd>
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <20241202151228.32609-2-ansuelsmth@gmail.com>
 <ktzz2btcxjlt7l36k7pgv4widhw45p44ol4hr2kjrf6ui62fjk@2yfvkmvdyk73>
 <674e1d02.050a0220.8873f.0e43@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ttx5dxtxddxr52p"
Content-Disposition: inline
In-Reply-To: <674e1d02.050a0220.8873f.0e43@mx.google.com>


--4ttx5dxtxddxr52p
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
MIME-Version: 1.0

Hello,

On Mon, Dec 02, 2024 at 09:47:58PM +0100, Christian Marangi wrote:
> On Mon, Dec 02, 2024 at 09:38:10PM +0100, Uwe Kleine-K=F6nig wrote:
> > hello,
> >=20
> > On Mon, Dec 02, 2024 at 04:12:04PM +0100, Christian Marangi wrote:
> > > +static struct platform_driver airoha_cpufreq_driver =3D {
> > > +	.probe =3D airoha_cpufreq_probe,
> > > +	.remove_new =3D airoha_cpufreq_remove,
> >=20
> > That doesn't build on top of mainline since commit e70140ba0d2b ("Get r=
id of 'remove_new' relic from platform driver struct")
> >=20
> > Please use .remove.
>=20
> Hi Uwe,
> I rebased this on top of next and still compiled but yes sorry it's a
> leftover from testing this also on my OpenWrt buildroot. (seems the
> commit still needs to be merged)

The relevant commits are:

 - Since v6.3-rc1~106^2~108 ("platform: Provide a remove callback that
   returns no value") there is .remove_new()
 - Since v6.11-rc1~49^2~37^2 ("platform: Make platform_driver::remove()
   return void") the prototype of .remove() changed to return void
 - Since e70140ba0d2b ("Get rid of 'remove_new' relic from platform
   driver struct") (which is currently only in Linus Torvalds repo and
   probably in next starting today) .remove_new is gone.

Best regards
Uwe

--4ttx5dxtxddxr52p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdOttEACgkQj4D7WH0S
/k6b6ggAk04AtwVaTLcGdPZ3+skeNR8aiUCpzXR1DT9QfXv+s5mR9ut3YyrVhEkx
lXKU1m0UF0fhC77M0pnt1RufZvqWuL5xL1BaAKSt3M18GXfEIhraUR6e/BQvZ3Qu
NIZyln1+TDJmLmgBr1BxV5u8qXFCzDkmXJLlEtyhWSS0eg2lVyLZtLRGAvVkce9O
cfX68bjQGtS/ubDb0E3+HPAMKV46KZ1dABu9tHdkYLFwUDKwwtClENtnACUqvAwW
PWJtHD+VlSdy8yo+cd44/r5iDh+0xl8KrIMlEfIE5DW5zDzYsys59okWZSIq5pQ/
T3L61P5Juo8JQDTNW2G/5AjIbPFFuA==
=zDkl
-----END PGP SIGNATURE-----

--4ttx5dxtxddxr52p--

