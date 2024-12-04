Return-Path: <linux-kernel+bounces-430976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E148C9E37B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D61B285D2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A51B21A2;
	Wed,  4 Dec 2024 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a8FLKd2f"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7C19049A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308681; cv=none; b=KhZZfw5ajkdesguIsbPfYOrWm8yhvbAaKfN4PaktMELGuDpUk8g9miPJMrAhIcpQ5DVCSignVvuMDyHIQJDWmApps9HdFu+LiJT0I2CqBVltP6SBusDr0tl1Etei+MMd+u+m+TRAuPuEzw6YuHwkQXV5ioDgCupa9bsaeMrNEtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308681; c=relaxed/simple;
	bh=VSmJSJgMqwwWb/iOmYw3ra4is8beAdDcsOPtIDoPjhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paav5iTXejF77Dp+BF6EjEdnHehPshZB2W4402hAC0VYjJ9Q+wFjV0BDtY/gAO+M8NdkZNnrgB/ru64vNIJ/nnEN6+LPLg0AirptHnD72y3uKxq1dGsNpE/4epVnEmWzc6PioXkQoUkECpwWJ2eW+OEeTQ4PRZQpkznHrbSs4P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a8FLKd2f; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so59723025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733308677; x=1733913477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSmJSJgMqwwWb/iOmYw3ra4is8beAdDcsOPtIDoPjhU=;
        b=a8FLKd2fRquQMU6znzcGyTBF5FhG5qc2WykpXpF0HA8NqoNGA569E2jOdaYi6TTTfI
         Tn5i7yUhLH049du0K7PV/tO17XpdtUEzoqv8nmkUoHKcubJpxrttsjkz0ge97XOIsK9y
         iFRJY8UTy03FQoyTru8pwIZviVmuoyAo03Fdb5hjscjmMkBLBQUPlBeTp4IxD2aTcehT
         0ck5eAt6knyKTqzKuQq63sCSt4hKJI5/sxp4LL2WFKb6jMr7CTuslIinyyUxtq8qFJMc
         STolNZCRAUSTjgFKdOWZp6/n/YooGW6AGnt7xBClhQADgektd3+9huAETXGUnjHDc0Lb
         NpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308677; x=1733913477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSmJSJgMqwwWb/iOmYw3ra4is8beAdDcsOPtIDoPjhU=;
        b=LAIeaAHKywELo22h/MZwKtmhTz9+7ANld88JdpQEDc0lW2yC0Da5ipDsMK014KXjl7
         9kRzdANxKVPMH51iiz12/j4c5QNoZ2lHPamKh3lTufn2lLW/UP2oEpoyc6JGdTSAjkiA
         vTKTPXZSvOpKt8Q2j9sNeBcTUall/65gGM0qwIJBoLOpHWQWtO00IQGx0mjc3optBct1
         RIYvhpnV3EJ+wAnyEeOLbciJWo79NnsluyQtMDhc0KPEVEaoJhM0Hd3ps2kxMUvUMATq
         3gCrLKpspibtEtOgQ+f8IVDMyxgnBBxulNETelr9Fg+tggvp6Hw7t2B42tgzP81V5roy
         uhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVFC0i1TjPCXQzaPNoUfbBH5aEF0OhVsz/gkDjqR1XEMUag7AQI9KGBvvttKfFrob7iC+DCHBRm6DNK1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlZoYwuOyAJb6o3RG/CK/uyBwYDDV5bPWbOMc6SCxkDvLvA6P
	EvpWpBT0PkAu7ovgiWEq1hOOO2t5v+9JL4rfcnAu08YKPkOFa4j/haP8ro/n1ow=
X-Gm-Gg: ASbGncv3m6KXT9Xcnnwo/q0WV28cFwHa/YIVBrnrf0KcEWD2aRscyoOs0Gw3Ee2B9X5
	M7g/ZiQqshfT8uTyAIlLpi5LRvXPPgVBMwUlPyms9GgesaTJ4rsDRGaQtjNh0qIKgUI3aD3zHoP
	HvF/GgZQehoxr818VBNXoOaLlA6JMIgkJJJjGjdmpZI91ySwLyWq3thfUA3l25LERxWivOHinI5
	vGuLC8fe1zHa4GcWA0jxfMI4PPuJI9Yr/ID0XCGH2NiE2PYjwHWt5JsAF+YDpo/agX3ylfEcLVl
	Gzy5
X-Google-Smtp-Source: AGHT+IEO89Vlo6zqJVq3m65C5RtcKMUa6CPBV+WVf1skvm6+7EpYz7TG8/syovz/E+WzZEo34AtYwQ==
X-Received: by 2002:a05:600c:4452:b0:432:a36b:d896 with SMTP id 5b1f17b1804b1-434d0a030b7mr46098955e9.26.1733308676836;
        Wed, 04 Dec 2024 02:37:56 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm19757705e9.35.2024.12.04.02.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:37:56 -0800 (PST)
Date: Wed, 4 Dec 2024 11:37:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <la6csftzuntp3w2etea5s2u63yjxvxcgicg7tbehnild4d736g@uqod6luq4bth>
References: <20240918123150.1540161-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zlvf4jdcfkkshrql"
Content-Disposition: inline
In-Reply-To: <20240918123150.1540161-6-u.kleine-koenig@baylibre.com>


--zlvf4jdcfkkshrql
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] extcon: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
MIME-Version: 1.0

Hello,

On Wed, Sep 18, 2024 at 02:31:48PM +0200, Uwe Kleine-K=F6nig wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>=20
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

That patch got some positive feedback by Krzysztof but wasn't applied.
Is this still on someone's radar for application?

Best regards
Uwe

--zlvf4jdcfkkshrql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdQMQAACgkQj4D7WH0S
/k5Mnwf6A4HpvVzphlte3vo254+4s8jyamJo4jvUclabkK8Pt8lJ72+cJgjGDe4m
AMxS9D1pUSdDWVYrHpgulg+6WTHRqhbi642UKjuzu5crMJ+j6Rzs9FKJHBvHUzE2
lZdhClZ5o9rlp3erNceF53rbwjmmT+IXGrW3dMsCukz8/4YxuzeRYmsxEr6MEWfN
ELZs7gYIvqbXSVtkV+xWqYKuzRJcINhQwOW+RaNgpsdV7uoU/Jm72lFNW87JKQnL
o9PPAxRXH3/kYPSh21MJ+GnPVD5N2seXcJDqPx0PKzOCSMd5iyXfGFI19Gt6H4eE
bdYT3BLaGTV662ONlAfXNDLk7pK3rA==
=/XKL
-----END PGP SIGNATURE-----

--zlvf4jdcfkkshrql--

