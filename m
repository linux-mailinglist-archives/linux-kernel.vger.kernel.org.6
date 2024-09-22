Return-Path: <linux-kernel+bounces-335304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8697E3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 00:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93931F214B8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB378C93;
	Sun, 22 Sep 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xP4JnxgT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56461E885
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727042776; cv=none; b=CWm9GTRGjSxtoWdjq+QgS6+MGKaGLoIiUqQOGsI2ey346zy71UWMj2a50DHkAr/SZg5pPExVD82dIeo9+Wt/Rc3eHJ0u6jxG7wpe5z76h2YrePhT1uC0N6Vn4Bj5UnItlrIpNhmkxHLeYEM+ibDShsg5ecnPIeK0aX0OWChg3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727042776; c=relaxed/simple;
	bh=hcNq7bjFvbvpdj0qA7YBfamGaYA4jHsTYXCJx/ynmns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d032KGnyohiCx48LFwh+378U2xD4BoC2yOZ63vosBu8FXISl11+z1zsoEBzlxNRE+o1lHH4MbDts9lN+PnqI4gpSWE9DtA7OJzQI5crXIyglls2p+fGzUzRs9ARqv24D7gBVWBVQFplvSxhEoYL6h7bXvaOIA5/htm0a2qSM4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xP4JnxgT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so35099525e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727042772; x=1727647572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcNq7bjFvbvpdj0qA7YBfamGaYA4jHsTYXCJx/ynmns=;
        b=xP4JnxgT+teuzI29MnpVSPX6/XGoMTWpY2I5xQZfbH57FFLEBTa1Ok/F8DivYfOv8E
         qsq7FtXLem9lHp/FC96he1jYSDYxHMkWp10L1rcJXC1aep5thBAt7lx5ikFszAlF4Z+m
         oWrm6Q/05YyevyqiMKdQniGs3aGbidqT/oz+uKA0x0f5NVZAMCHyltNz+tAz3RCeYbcS
         agzUW49LcbaxI+KUBsmx/MnOSkofnDONKgMvLEjQ7FpSu3/p02PcOdmPxOdFmq2+uwDu
         +GfMicJlAdSgssNkFhYPpJIOb4zf1FJC/jbYIuMqScjGVdK/bdDscmcHiPSaDRmhGgI0
         5rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727042772; x=1727647572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcNq7bjFvbvpdj0qA7YBfamGaYA4jHsTYXCJx/ynmns=;
        b=alNJKTRNnqeYgcVF3VWLJLPe7PZcPHQjthuGBsdXjBh1CXyCaJEElKZHUB9qskxr5V
         8cQsPu2+wD0I5LXmN9DE7S3hfVjZzMp79w23H8CnCZqCqsEXOTg3Z99KpfJXZelPL0my
         SGuDEtzyCEa2REy/My88V5EzqagqdaksSmEtcQsShxOMEv3OsfkAGKoLOr9hmY77dkG6
         TISIRhzhxbNkS5kDz5wjYMf17z4WgCcAok4sniGah14ylXnqB09ukgzQThrXDTDjAXR1
         lUvVYym6iPDJorWZSFsfBrmFYJfY5w/V+6LnkcmowQLCHGfT8GrIsEVmVh6PLXtgtPzz
         evQg==
X-Forwarded-Encrypted: i=1; AJvYcCVEmGQJST2IYIBQXfq+vAEzZjHy8hJpwn4fDZk1KKx0eJr7YAFJ0NJ6QNzmo6Gpu4R+kG8y/AK7fouxDOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFYghu3l95KOVM8U88Lb2qxT2TfBIeocznp/x3e/e5V6DeoHV
	Hs4WKDDtJyvN6/X9PWShzvfjKmHNmborC8odKsB+P9/lNpOVZEPmGRQ85jfI8uI=
X-Google-Smtp-Source: AGHT+IFAKBeMqzPEszgXWfY2q+crMa2r6AzcOK87gchBPbHJqZfcWB75VcqYM4PCILxWwRlTRsW8lQ==
X-Received: by 2002:a05:600c:c89:b0:42c:b037:5fce with SMTP id 5b1f17b1804b1-42e89fa08dfmr12521005e9.3.1727042771439;
        Sun, 22 Sep 2024 15:06:11 -0700 (PDT)
Received: from localhost (lfbn-nic-1-357-249.w90-116.abo.wanadoo.fr. [90.116.189.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f99ebsm23010824f8f.63.2024.09.22.15.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:06:09 -0700 (PDT)
Date: Mon, 23 Sep 2024 00:06:07 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, Arnd Bergmann <arnd@arndb.de>, Sean Young <sean@mess.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: ts-nbus: Fix an error handling path in
 ts_nbus_probe()
Message-ID: <jquslj55xt7febemfgu4dinvok77dgpi4h3pqcxgraepioog3e@h2xfsnypdzku>
References: <6c887c85434edb17d2217c5198c48018dfa97923.1710606677.git.christophe.jaillet@wanadoo.fr>
 <053af1f0-546e-416b-b8bc-22837e908ae0@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwqbhu3hcdysiyxz"
Content-Disposition: inline
In-Reply-To: <053af1f0-546e-416b-b8bc-22837e908ae0@wanadoo.fr>


--zwqbhu3hcdysiyxz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 03:32:44PM +0200, Christophe JAILLET wrote:
> Le 16/03/2024 =E0 17:31, Christophe JAILLET a =E9crit=A0:
> > If of_platform_populate() fails, we must shutdown the FPGA, as already =
done
> > in the remove function.
> >=20
> > Fixes: 5b143d2a6ede ("bus: add driver for the Technologic Systems NBUS")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Compile tested only.
> >=20
> > This patch is speculative and based on the output of one of my scripts =
that
> > tries to spot calls in .remove function that are not also in the error
> > handling path of the probe. I'm not familiar with the pwm_ API.
> >=20
> > I don't think that the locking in the remove function is needed here.
> >=20
> > Review with care.
> > ---
>=20
> I sent this patch a few months ago, but it never got any feed-back.

The patch looks right. I don't know how the ts_nbus works, but I'd hope
that at the moment ts_nbus_remove() is called, there are no more devices
on that bus that rely on the PWM being on. In that case the locking in
ts_nbus_remove() could be dropped, too.

Best regards
Uwe

--zwqbhu3hcdysiyxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbwlMsACgkQj4D7WH0S
/k4kAwf8DI7GZkk4aA1vR7EG8Qw1mcFHaJAzT7tVeKlZO+L0hfn/xgJy6f94sEu2
wWEdrBjUUi6TXtP0WbByLd9JHH9Yef7dm0oZ5ePHYG5eTxYa3YIwNBqtvvTNjczp
KE0rRZdzJCFV6pUYM/f2xfytfABwrWaVfhkUqzCGTuxG7II+znohT2KyrRihn00h
P0zNUEocyU05h3kCbzp2NMGL+GzkLZwqTpSNQwswWJfvcNn545fXqrrxQPPe1CXe
W3rQesTKgv5FZ26uurVu5NdOeDL1lHPKn+NuWLJvQ4si6z722ZrYRXIxLW2UHZ55
ydsD1yuCDVL6ZvULVY+UgqPB2e3VZQ==
=44gJ
-----END PGP SIGNATURE-----

--zwqbhu3hcdysiyxz--

