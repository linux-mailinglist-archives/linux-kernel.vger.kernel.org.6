Return-Path: <linux-kernel+bounces-548446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6CA544F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1973A16D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D2207666;
	Thu,  6 Mar 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K1DXdl/j"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66B207E05
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249998; cv=none; b=bx+RP/KPOO7uqgiqNmQhvGoUUUMpV7Jo66Ra19bMMpiKNiZmjJo6n0NmyGQ7rSNlrc5/ezvG8iagTQqNCiAPcF3hvygEsuvQTB2GgXrvpX78CzEmANUw+B3n4isQgR1Dvn7Xv5OWncfeULQrk0YFa+d1HYitYj0HaFXRvUXHkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249998; c=relaxed/simple;
	bh=hOVOOStkW8jmkt+1hp/0Jr1VkM8lrszPOZ7dkECB3lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQwizawBvAS1VOXiyrQHYiQlrHM29NYwEi8PhWLfjyM0OjOb5J7OYY6Bxs1p0zNE6PJPc9o5a2vktbSMpVIHIhnei5V1l4S02Az3kz1bEeqsM66RfGzA3yxIAP4DelVb6zM/d+27oOl58wOi6ejwXv6tpgBdvUsBe0XX3JfVffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K1DXdl/j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so2864285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741249994; x=1741854794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2EUc1x5Of7vZCQZZ48kByIEQAeOmgrKgZ4g5Ou9HIs=;
        b=K1DXdl/jLd3lGnBeY+6K9KDo21yVRKd5LmQj11MBIpiigiwvfdb750QwYnfKRzJRGK
         qV9NWLSPf0KRZoWxkP8ZYFda/IqEYR5RmQGV/zOqxdRf+bAT7k7YkJlDEnwCnEijE93R
         wHZM9bjjVTrGaeIrUmltDSGLVO9wKSO5fOa/PGum2mWO6GISIr66RbniGALJFr5qjZk1
         0x2Qj1pvqTxbZz2scScNIEiSsX65GpCrLd3kh7fcClJkyRl+mtUC52t18A0HUGo6/MxU
         Ukr0Oeh1+5hb+u/0jg/vKSkmXsFuE4IDJt1rP9zg3KstOLMH73vb5OzcbHIv325nvV6A
         JDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249994; x=1741854794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2EUc1x5Of7vZCQZZ48kByIEQAeOmgrKgZ4g5Ou9HIs=;
        b=w/LNAEJNK3NyUwD2pe73SN2rX6+zZ8w1cKAuHy6RFJnMG8VTcj8HKzP3VL/OnnEU1C
         uIgE0GNn8Uec3M7dYe3BFyDZDaIz/Vue/AyEb/MhLvuIohjCP21GDdzNX3caxD0j91pu
         DMQmppFK03jcdxco+9x6oVeTpgbM6NkWRbooCF5tV4ffzzjIxGl2ofhtMG9J0c1GRUdI
         eDnaPGKgNbOgXWsomyEoW0xAJKeZCA60nfKtIR/4SuIdLwTIHppegjwiw7kbDFfLxnjL
         meYYlB4qOkIbIOtJp/reNKLFcD8120DYRzK9J/c+4g7huxkpTU2+3ST6TFge1Yvb9SPA
         0lzw==
X-Forwarded-Encrypted: i=1; AJvYcCVoH5hI3kWp3f/NNpzuPZH6zA4grheQRAD0XEct+66+QLJ2sPc2N7/ZX2/+U9vnmJghamULyv+fIxMhOts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kiySYWgVgW6CFApdhnt30i2UI3vhWS+iR/Q9JnasoUMf0FF4
	3DCukuV6nxg1P969zpqpHzWZlgcFaDENSmpKOCupuSo1BLJl6iJ64Df+Sjyfowo=
X-Gm-Gg: ASbGncvXJ4Bpc4kpOdRVCSzuuInHdiBUwLpjPH+2EAxQnSgYlLTg05CSWpZy4WJx1Rc
	2U8s67G9EpscD67B+I/uZo/eYCRNnHpfSe4SdD9Zlx48qVXWrT2K3rGa6NFihj8v/uOKjiAY2xl
	vh1c89y6WhPv8UkYaTCefLZtKy4OkJ97pROd9hsLrXUpb8WbLvoVutrJdzs4hsOxGxr/hxSr+4U
	YW5YW9ezaQgUI25yP5LLGOqrxqb0vwB+KtwC9sZ7ydgPcxD+V0kvO8WN0FHFv09FqgEVlxRNDAm
	8eoOVztZyPAYGoUxWgxrzfCck9+VTT5qm+eU3nOaPhFBbB3ZjeJg4AlRE/7Blga74yaoTjn9wfA
	Q6eDxR+bChtHXZ7lBoVs4CbmNzw==
X-Google-Smtp-Source: AGHT+IENVLytuFM3iADZunJAXBOhvQ3LIEDZZsGeB1MuN2juBTFSeQk4BfBlXS8v8nNpLXWbNWI+2g==
X-Received: by 2002:a05:600c:3544:b0:439:a1f2:50a3 with SMTP id 5b1f17b1804b1-43bd29462e3mr49071765e9.4.1741249993713;
        Thu, 06 Mar 2025 00:33:13 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm1282552f8f.93.2025.03.06.00.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:33:13 -0800 (PST)
Date: Thu, 6 Mar 2025 09:33:11 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Michael Walle <michael@walle.cc>, Nuno Sa <nuno.sa@analog.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
Message-ID: <53jwjqqspaow6npy76vyhkz7stt6abkkwfj7hv7rs4dspazilv@54uua2bpcpk3>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
 <20250303114659.1672695-18-u.kleine-koenig@baylibre.com>
 <20250306000718.330c99db@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="braso36kgpzqa6iv"
Content-Disposition: inline
In-Reply-To: <20250306000718.330c99db@jic23-huawei>


--braso36kgpzqa6iv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 12:07:18AM +0000, Jonathan Cameron wrote:
> On Mon,  3 Mar 2025 12:47:06 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > Allow triggering both zero-scale and full-scale calibration via sysfs in
> > the same way as it's done for ad7173.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> >  drivers/iio/adc/ad7124.c | 153 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 136 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 382f46ff2b51..5ab0d3e48c43 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright 2018 Analog Devices Inc.
> >   */
> > +
> Stray change.  I'm in that sort of mood so I'll tweak it whilst
> apply.  Rest looks good to me.

Ack, thanks for cleaning up behind me.

> Applied to the togreg branch of iio.git and pushed out as testing.
> As the fixes are theoretical(ish) I'll not rush them in.

Also Ack.

Thanks
Uwe

--braso36kgpzqa6iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfJXcUACgkQj4D7WH0S
/k7GMggAnd1NKiaoKhZmRgoFkNSYlKr3g05lRuBEs91JFvKNJxoV/UU0ZvqpGSOA
ecyBpb02lZ1gD8M95AciwtSSAtv8fRJLzvjtmN28A6W0w0ScR7TVvlCdf5HZZy4K
q8QQHWgLIBp508UFwdCqhLtsCD9UxjQROt7qM25CLj3u/x8qpNpIEpTEL9yHmaRA
NPssmTPPvd6Z/qSsxLel7QlDoYIyleuRwWT9CmD1FJ8SCKo7zcSLdnm9IAGBsn21
Jmv16gfyLeFrd7vwQs1G85Z4aPdwDhuojrjeEkSsy6LhEZl5quFCSb5rpmOT9xLV
w0hS+YekqIIB9SWL9wJweHM0xusgAw==
=C5a+
-----END PGP SIGNATURE-----

--braso36kgpzqa6iv--

