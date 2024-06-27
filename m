Return-Path: <linux-kernel+bounces-231991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EC291A141
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A811C21A4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8710770F9;
	Thu, 27 Jun 2024 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q+HYppaU"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97754279
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476222; cv=none; b=gbqRdutUUX+stXVHkQdmKE6hw0+hKFlmneb0cKb1HlJnd6Avd2e4+ghU/GSXuhUMACLCVPI3F3wkPmFQImn4QBd9GQ5RUzC3wh/rZ2gVmJIPW1j5FU7EkfmhnBq+AVLPe+K5b7HpEU4ItQJOEChW2pbfsY82IF4i66soLzZ5Cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476222; c=relaxed/simple;
	bh=KEm0f3yMC1lTsMQP2mEqK6dYKNV66vYfR0qO4oI6gVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox/GyzaK0dGGC18VipdhYOqWbcW2MO12phHo1vbE+lwN4HTCO1AwyNZy0sCkCqzPbBu+H9H2l7Tob5q5zCAWsvaI3JfJMGcyPEW/F6276P+S8w+W8+770cSs1QkP/yX5te3CQyhZPwmH7BrzdjhrN/FiJQNd+DEb+ipCHV8LaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q+HYppaU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so62876841fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719476217; x=1720081017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEm0f3yMC1lTsMQP2mEqK6dYKNV66vYfR0qO4oI6gVE=;
        b=q+HYppaUKsH1WN7Za/nSVU7nH68GK1bwopSsO08cM3caaJllp/EAZErpIYevAYtH8F
         AoEUctTlEucWxIaBLUa7bWIlLcw3KPXJXq/02xkh3cSbPHy7v5ctGVz0uHIv3J0zq2/c
         B2hHibpcaB93quLFzlwBkxDNmzCSrd8VhxHW+JownhVpiumKq+XugW/fEd3xeO8NEo+4
         7AhWIygGvEEgfYCrnn2RsqzuFe/Q/WzFzMarxWzuYI+noSDVvtFrMXwdFOFsMstwrZuK
         ecSceisTl6oHUArgA+lCfDTKTPEwxJZnG1FojZGT+Ltsjn01oeQisDUOVcZ8vnESHiAP
         zDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719476217; x=1720081017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEm0f3yMC1lTsMQP2mEqK6dYKNV66vYfR0qO4oI6gVE=;
        b=O0Gc92unSjd8o6Tffp0lnJfuOg9+PpJHF9p0S9R+T3VoS8qfOpbqFbBMMHNElyw1Yb
         IF9CzBwXXSK2EXrtBB3RhOb/IYF0zVBeXLvLsQmXWQOcvOxxlPNsYY047GXZV/UJwGMU
         4dkuxnCXJgv5eGpIzzZastF1MGTR155G4XHAp1JdklYiwnvmbT4iagYru8pt8pQrl7Vo
         XStQ6DZj3IFZOs/+iiYtEgKK7tu3RA77TyfCRBGLxtmHx7HEwz/9mx+m3R4iIJyCc29o
         4eL5b9sDg/AFjJq1rY7U33t7AyxSFaBZc5+24ge2GpS2tsKt2VQErau5G8fGULhOT0AG
         JbVw==
X-Forwarded-Encrypted: i=1; AJvYcCUUIbAywXuRik53y3U39xoigb/vVpWCQYRgdrrZ1kP9bll8fN7lgcQNlS3vDGyU09CpXDXBmXs22OlcTxERPZODyNrwhwCAuCXG3Ga/
X-Gm-Message-State: AOJu0YwNiKjzwD5KQiTPogBMCRvhcrei4g+mNeX5fa8QmlaKDyEGNx1L
	bt+M7PPx9uY16fvOn/eRkJoEXQTJpjmVUIOfTS2Ys0gyAtnKIu0yLhEgi0+S2/E=
X-Google-Smtp-Source: AGHT+IG/lOE4K/dxtmNROMYE5tpBQ4PfaZZjQoprWIxtfxc9uup5H2fD6gZ79Ng0DJruLnzyAi0a+w==
X-Received: by 2002:a2e:9d88:0:b0:2e9:768a:12b0 with SMTP id 38308e7fff4ca-2ec5b36c1bamr95025771fa.50.1719476213391;
        Thu, 27 Jun 2024 01:16:53 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bc5176sm14283215e9.45.2024.06.27.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:16:52 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:16:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: kelvin.zhang@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <ayemo4ysl5qotj4pfmclxdtshoqgybl4xqmrmkmpbd3vsugf47@pgsezohr4vel>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rsedrqskqx5olerr"
Content-Disposition: inline
In-Reply-To: <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>


--rsedrqskqx5olerr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 13, 2024 at 07:46:35PM +0800, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
>=20
> Add support for Amlogic S4 PWM.
>=20
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>

Applied this patch with George Stark's Reviewed-by: to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

You signed your patch using gpg, that's fine. However I failed to find
your key to verify that signature. I suggest you to upload your key to
https://keys.openpgp.org/ (note you have to register your email
addresses there to make this useful) and read through
https://korg.docs.kernel.org/pgpkeys.html#submitting-keys-to-the-keyring
=2E

Best regards
Uwe

--rsedrqskqx5olerr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZ9H/AACgkQj4D7WH0S
/k4TGwf/Zq7fInk7zIeHl44mqXSTwaWdnCftKpYsQYNhI57+Pr2qmGnMZfWo9Z0g
qTQZtc9veyYI7od541wZ6cSYR878sstNK+GZzJe4lYeZpbIhYHaTjk2DzjCh5tjy
NqgBMCvSSK++TZpBTRPbsYgJwemdFsWlB1UdIAEHXe3wkKhy9Kt6nmw78TqnqwDo
EELQDqhCzF7qZSYXi5SlpvHQyTuKzPRDosvgoM5HDcyUcnTDQ7qsryPnVBV3OJKc
P9TwMOPaBCckz4MnXpHAw8SfRKYQ/INNLRd9Cng5l2npcVy7FBZ7ZHvfN40xZtlf
wXZAead9xYAyIMZ5LyDLhS0MjgXbxA==
=wNYU
-----END PGP SIGNATURE-----

--rsedrqskqx5olerr--

