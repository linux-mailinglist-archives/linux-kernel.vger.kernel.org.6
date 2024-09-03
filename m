Return-Path: <linux-kernel+bounces-313032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A06969F41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1ADBB23498
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5F7462;
	Tue,  3 Sep 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FJ6KDKmI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C53846D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370864; cv=none; b=br3+k59nJmI9GtxSeeaoFGot+6H1MjFOS30sw7ES5iF1q96eq6SOEQCUcL9dQdft5u0jetwigo+RSAFqTcIQPjKeDppqypbPhAXP4+cnVaDnkBTkRcdAGmZyDJLMhrREp4w2dmIWccYvy4SojQTjP551tt36KfArwXERtLd6+YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370864; c=relaxed/simple;
	bh=Hm8uaTTnhsmMJ/kyk7EAYPeRsqRxY3Pm0+eWDG0FHmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN/OtANRUh9jM29TTEgNWO46TP9sOByPXjzYOqjNZdRR6I4mMOT96pCe+22cBDZuLAE4mo8G/FSsG8LSVKsqMQa1UliysdX0NyJCqAtkNzFvmcG5yb/8R16OLxcYDmUR9FotZV7IQk8Z6q4R2oDY6krUbWiio0YW5jNIe1F9eQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FJ6KDKmI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-375e5c12042so528872f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725370859; x=1725975659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZPiLwRoBJssyDrESoc8JeuTReUrFQgHukWf8yT2sn0=;
        b=FJ6KDKmIDEalrWDCNqCVMmXPL4Uqw9ZlFptKO1QIhw5L5NsLF/PDREBmN1KmM6whEp
         diKVP9qhSqJ3Y22X1mVO6eUvfkb24ny2MoJmB54l6tKjvPNQbP+0nOINGgLZn5M9r7u5
         wZCbAVa7XOeEgYdg8+tIsyA5vfAvHas0y+MITwXRVjQeQ3HE3O4UITr8NqVfYxe2J9FV
         PrQkN3TzZJMfpZIhiEGikgQh2sM/4zSKw1Rsi/3EFHS5n2iY5lYhvEaMTtWpMONaLjX/
         PKsFlUgALJ8YYd53L+1dJ+E2xHlwe/hWm0HEiympLLocAZEZXWAflm57zR38e+o2xzye
         H8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725370859; x=1725975659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZPiLwRoBJssyDrESoc8JeuTReUrFQgHukWf8yT2sn0=;
        b=u2Kg9PeqcdF50CjMPi9vhHivvCbQ96n3mWNww+RFIIyruk5lDjGILQThpyYzbGrIj0
         61KhSXLVaU6FnbZUD86ykYIQQY7X/+HsC/pcyFWfG4BXT92VujB9cpVq+Ml6tNzhhc1K
         D1ZBq/9z0ONb7aVVPg4HcecFZq03Za5nSM8otPxiIZIhrq80m+U1bDrN5B8xFd8iA0Rf
         pYUUinqlkzSX+FVXhfj/vzT3flq9kahF1RySpgmcm3pSlBf2KbF+C+VXdjl9RuOhwkI2
         A8y/J4b3OQPwQgk/RMUp+hTZzi0n6j3BvnyYb4q5tIzZHKmqU4uyf8ADF9uFNrgAAWhf
         Uomw==
X-Forwarded-Encrypted: i=1; AJvYcCW2R6f7cjjyUIB0yjnzh7nlnzNN3o1qIN1PwUbk+UlmntX4JU2q2Fe2vTHb5d+qH6OJp57gr0pqV4mh03s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Z0EPVysmZNLBMjlyQoTAVWoS3A/pGYs3QxHvTyr3kA7ZmSxX
	0Zm2EAaMmU81/wusaF8rSnEA3Bha/HXukTn2BMCGZabTAdo4fZ+QAkSsk8biOQDjTgCZ9kYEdYR
	4
X-Google-Smtp-Source: AGHT+IGEnIii2CwULP0MNV6LucnH2tFdwivllv5dXZAfIObPe4f2nwv60Zk8bBT+ybFmOQ1uiRLW9g==
X-Received: by 2002:a05:6000:4025:b0:374:c847:85d with SMTP id ffacd0b85a97d-374eccc2436mr3060014f8f.29.1725370859112;
        Tue, 03 Sep 2024 06:40:59 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:ce9e:ba67:4faa:67ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9e7b7f87sm179383895e9.1.2024.09.03.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:40:58 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:40:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Nishanth Menon <nm@ti.com>, ssantosh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, krzk@kernel.org, 
	jic23@kernel.org
Subject: Re: [PATCH -next v2 2/4] soc: ti: knav_dma: Use dev_err_probe() to
 simplfy code
Message-ID: <ruphb2pue6tylszwekw7lwzgoyrtdru56vhcwqpnr63wrh37pu@mzpgfi62tyik>
References: <20240830063228.3519385-1-ruanjinjie@huawei.com>
 <20240830063228.3519385-3-ruanjinjie@huawei.com>
 <20240830103155.5vs2hdokw6yysq47@finance>
 <29edea69-92ce-2ac9-2aa8-bb9a4674ca01@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="az4ay56eqiq25z24"
Content-Disposition: inline
In-Reply-To: <29edea69-92ce-2ac9-2aa8-bb9a4674ca01@huawei.com>


--az4ay56eqiq25z24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Aug 31, 2024 at 09:59:33AM +0800, Jinjie Ruan wrote:
> On 2024/8/30 18:31, Nishanth Menon wrote:
> > On 14:32-20240830, Jinjie Ruan wrote:
> >> Use the dev_err_probe() helper to simplify error handling
> >> during probe.
> >>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >> v2:
> >> - Split into 2 patches.
> >> ---
> >>  drivers/soc/ti/knav_dma.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> >> index 15e41d3a5e22..eeec422a46f0 100644
> >> --- a/drivers/soc/ti/knav_dma.c
> >> +++ b/drivers/soc/ti/knav_dma.c
> >> @@ -708,17 +708,13 @@ static int knav_dma_probe(struct platform_device=
 *pdev)
> >>  	struct device_node *node =3D pdev->dev.of_node;
> >>  	int ret =3D 0;
> >> =20
> >> -	if (!node) {
> >> -		dev_err(&pdev->dev, "could not find device info\n");
> >> -		return -EINVAL;
> >> -	}
> >> +	if (!node)
> >> +		return dev_err_probe(&pdev->dev, -EINVAL, "could not find device in=
fo\n");
> >> =20
> >>  	kdev =3D devm_kzalloc(dev,
> >>  			sizeof(struct knav_dma_pool_device), GFP_KERNEL);
> >> -	if (!kdev) {
> >> -		dev_err(dev, "could not allocate driver mem\n");
> >> -		return -ENOMEM;
> >> -	}
> >> +	if (!kdev)
> >> +		return dev_err_probe(dev, -ENOMEM, "could not allocate driver mem\n=
");
> >=20
> > These make no sense to me :( -> just using dev_err_probe when there is
> > no chance of -EPROBE_DEFER ?
>=20
> I noticed a change in dev_err_probe() this year, which is described in
> this patch:
>=20
> For an out-of-memory error there should be no additional output. Adapt
> dev_err_probe() to not emit the error message when err is -ENOMEM.
> This simplifies handling errors that might among others be -ENOMEM.

Notice this was carefully worded. Calling dev_err_probe() if you know
that the error is ENOMEM isn't helpful. The change was introduced to
simplify

	ret =3D some_function_that_might_return_ENOMEM_and_other_errors()
	if (ret =3D=3D -ENOMEM)
		return ret;
	else if (ret)
		return dev_err_probe(dev, ret, "....");

to

	ret =3D some_function_that_might_return_ENOMEM_and_other_errors()
	if (ret)
		return dev_err_probe(dev, ret, "....");

But adding a dev_err_probe() if you know in the ret !=3D 0 branch that ret
must be -ENOMEM, actively adding a dev_err_probe() gives very little
improvement. The main effect is to increase the size of the resulting
kernel image (or module).

Back when I made dev_err_probe() silent for -ENOMEM, it was suggested to
even make it fail to compile if ret is ENOMEM.

I wouldn't necessarily object to new code using dev_err_probe() to check
the return value of a function that can only return (success or)
-ENOMEM, but I agree to Krzysztof that changing existing code is little
helpful.

Best regards
Uwe

--az4ay56eqiq25z24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbXEd4ACgkQj4D7WH0S
/k7w2Qf/YOrnEJu0mpFQNpf7L0HEd3MMqBoN4msV2nLlptFTxJEIk0o3FMeFvfs9
ESODHMVvhH8PXA7XoPY+bJSWKhyf6mNnb0BT5sD538yGqH6WqyxMG3bDv6d1Jmof
B/3QJ99VrTPqm72+ZpM0UpxV+otMu4ELpNLfjgCU37SQDYKTc04HUtr1MiJ6DTKm
wK9GuNLLOugM2zZTo+/8LVxOSqa0XHfRhxwnFDP07EESvhfROQq/0SJcm5WYtBI2
aZAKoikhJM9/Y1eUiy9jjHDRFfe6bPpHsut7hwinnG02WJZEK977MK+Dy4ZUQE1q
Ol6IN5Y5Ti4/obiA+DS/uJMbUwz3JQ==
=+Cpn
-----END PGP SIGNATURE-----

--az4ay56eqiq25z24--

