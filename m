Return-Path: <linux-kernel+bounces-369279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791C9A1B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26EA1F28537
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DECD1BA285;
	Thu, 17 Oct 2024 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zh1wdYFZ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AF1C1AA5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148307; cv=none; b=TzlA9PHeLOVTaABLbeNKgTFg7uII2kN9z3S6K2J7Uf2XVgqbwAGdsZz/IJJhCP8QKskdReo2uyHhnfIuTkOBrpGKWlJ232Rx/PzzaykrK70uiUDPtLfMfTdayRSUARgcgJjG77MFXTCW/DuyY3o9rNpLbqpsqE7S4iDX0GhiiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148307; c=relaxed/simple;
	bh=eikXMQQTQFtDuJEmxx594Z1tR3sjWpjfu06Fxs5TST8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWvlikJR83aVY88H6SGxkzxo0wwiLouyZeNNn4ohLKGCu+B/3jvjWw1bnIqJvKssESIR+6vWcnKqN25QvNN4mYObbMlMP2+yQSQ81R5LK6ELE+36JhT8jDFO+NKF9lRuemvxrvVuhrhVMbe6+aIbGKyDnbfS7f3tv5+Prqj/FTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zh1wdYFZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d5aedd177so440711f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729148303; x=1729753103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeLvVHAahzMmmigQ0rhyHbTviJd4gJG97Yv+5p31+60=;
        b=zh1wdYFZBQPJ6pjSSBS08fGuYjlZ3C5VjGuCU+FGXvuZYeevQPS0bZ1KnZV7xn0L07
         bnc8HsfRQjG1mp/GfF1HwROVduZK7KwfBwB6dXWRGTp8Oicq/NxKRys56CEqIarfz6Cz
         fFJUdIBA9q6CylIKWTFdrt0IX0cHeOWyKDFlxF0xndrvyXZfwBFeoABl6+Z4PzKW+8Tl
         7Zr0Th+PA9ya2y1/icJHlgHy2ySdaAgpWELHw7MIaxwZlTtTjsTNxBluhBSDr0KUyBKI
         rJVZv5QI9OlTokTBNA6FOtwlAOeeJi/LFOGUQ+DAcc0ypz9dx5+VzXKmwpYnUcMFpJUT
         v5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148303; x=1729753103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeLvVHAahzMmmigQ0rhyHbTviJd4gJG97Yv+5p31+60=;
        b=b3JcHaWm2t7eoisS4oDW3bD1nToaS2b4xeeR5nkapX27DgvfDXqd0Q3VKohFM3F1vA
         YCjnkS2CrQcWgInVXDxptmcwUF2AMNh8RJT6BIhbtwH3Te2mpcSaRaFm4EeHuU3kI1un
         5mfa6c+dTOMmN9V2gQ1cTivVu3XYa3W/QBeXUvGNJUrBULho8hONEdYm5EK4oyFyAFzU
         y3RxYvYTGap3Byq5mj7tZCy0LnCuYDBZq0Iz0eLke2hes6hUwn+IrTat9rMqMlXifHcm
         tqvQeOjoXCSL1jP1juBPZFOmY5k9OnuuDyz3SXUeyg2RnMKY6336gig4Kyfg7R5wOcgZ
         3g7g==
X-Forwarded-Encrypted: i=1; AJvYcCVz6O0FJ5SVuWe4u7fWa2c/wOfnTZzP20Te9poUsE/sxN4QVkOUMxwBz77WCqoIKCYM7o8yylPiFGOrgGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1Y06zauCdvNCKBwAqZH5c0aKjaAIYGAH6009+Hv6r3crzX2D
	SDVKJ7T9r3K5vZL+OebgsUSzUMembGfQKIV+vbZKs6gYbkIbZOyyjNBaqCAnFWc=
X-Google-Smtp-Source: AGHT+IE3taqIWL9QmJ5JHNSmCD5QX4JIPb6rHSNX0e4A6iWAkyFY2s5keuSgw/xpQbIvUxwI/i+2GA==
X-Received: by 2002:adf:fe89:0:b0:37d:5129:f454 with SMTP id ffacd0b85a97d-37d551d4fd9mr13656287f8f.15.1729148303407;
        Wed, 16 Oct 2024 23:58:23 -0700 (PDT)
Received: from localhost (p509151f9.dip0.t-ipconnect.de. [80.145.81.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87bbesm6283069f8f.41.2024.10.16.23.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:58:22 -0700 (PDT)
Date: Thu, 17 Oct 2024 08:58:21 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, 
	francesco@dolcini.it, imx@lists.linux.dev, jun.li@nxp.com, kernel@pengutronix.de, 
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, marex@denx.de, p.zabel@pengutronix.de, 
	pratikmanvar09@gmail.com, robh@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org, 
	xiaoning.wang@nxp.com
Subject: Re: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <pz267mfsmohgthip52s7qeeo6xvw6w65eug23jw2qoghfnudzo@kjbp3brumgy3>
References: <20241008194123.1943141-1-Frank.Li@nxp.com>
 <Zw/maOfa12uoJlO6@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtagf2jnmwccljol"
Content-Disposition: inline
In-Reply-To: <Zw/maOfa12uoJlO6@lizhi-Precision-Tower-5810>


--vtagf2jnmwccljol
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v8 1/1] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
MIME-Version: 1.0

Hello Frank,

On Wed, Oct 16, 2024 at 12:14:32PM -0400, Frank Li wrote:
> 	Do you satisfy for what my merged comments's results and do you
> have other comments about this workaround?

I think it's good enough even without the comment that Marek requested
and applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
as-is.

(Although the mathematical pedant inside me shivers when reading things like

	2us = 500 kHz

:-) .)

Best regards
Uwe

--vtagf2jnmwccljol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcQtYoACgkQj4D7WH0S
/k4bBwf/ZEIHwRC7YoX/I8XH4VxCiCkGMwD9TeUVYDdhckzALnmiXnP+2zqBHwk4
9Z0G/bDToAY9yy/hDPxvjcZAmlZFKesEJhX+yUQC9O2xxmmTsDO9iq23brROR3ce
yzmVt/HMVPdZmXLkZHAOeGN5R7OkC2cSLcCeQ7sHuKS2X+K5fSPahweUGmw/OT+Q
a0OxO/bBIkCA8H5JdG5E0zg7e10WCFqbP+HtqQxF0mcJNcKmlGNjr2LkxB/2PXUD
GxuhwRr8Yl5bYjEq+dmUQN2v26jCyizjDLXMaRyPJKfSF3OArfz/17QLPtKy0Rk3
OdYSAeOz0ag/O42mOaDPegULR4B7Yw==
=KwPb
-----END PGP SIGNATURE-----

--vtagf2jnmwccljol--

