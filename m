Return-Path: <linux-kernel+bounces-541260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A9A4BAA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959483AF70B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F51F0E2B;
	Mon,  3 Mar 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BHgGP/K4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AE1EF0BD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993554; cv=none; b=tffQEA24vHYyNnU2INpmjKQtQx1zHFnvl/jHoBShGdabO/rzlC3/jMzt5QqMzpiOyBwRSyb3Sc2IuzZjvxJIysUC4fR/R4vDn/aV5qMhF9B/aa7LVAE4tu841WJWuUolbbv9VCVzQ8SKhtWi7WX/tmUqIz6po3Kj2KsKzTxv+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993554; c=relaxed/simple;
	bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYKXA8Y65cBkXW6dHjVBAjmgQeENI9TPIzp7fgPBuyV5EO/NoDWb8UGMaxCeA3+XS3WxL9DMf9z37pheNazRBoOyRaQ2Y9rxWbbsTmkc4ggIITBy2NPDa70kT1SCWUlFSxxLrNWj83IW7pqDHR716mdlvmWrQfV1MAWJpj1nnQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BHgGP/K4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso4010035e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740993549; x=1741598349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
        b=BHgGP/K4nfJ/+0PZMEd7uq47PGl6fzMKFzRRPA/1V9tDi0suGuZEDNjahH74gfunp5
         ryMjFzwtwl89eNIXUsxnJUIQGK97jDbunaNAJP4Wx/XBPSgctO3vubEsDpXZhDbZbrzH
         XO+vmbI5liCz9gtRGr3OL9MMbZSN+tpuLzsTCUgB/98pzw1ruE9uVN26fYvzGrmPFNEA
         G+jc5IGla6jQgJWi/5hmXvVZy0USDaggJo14+1hn2wgX2JHjpj7PnTfRnpNgp29muADJ
         K0Z2kOB5ulLsn/Cj9J5/iSAhMXh9iXyWD7wAh646kqvfVYqq5EbviFU1rHtHo8GWETcQ
         gWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993549; x=1741598349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcNOncFZdUs+yNeq8pr7D0R7rzSHI/mcL2lr8MRssiE=;
        b=XDgVobUoPFBe4tcQ3tG5KcWLMSpSHiRGCZS7nTX5FyN+YbMopuIMBLhvW0D28BKL/1
         Kz68lotDCMLgmZiH3l13oeA7UePNhlxj3VZnOGdJ70R6z7TgMQdJMXbsilOsdXrVP9Ur
         QvTvbiDB+Oh2Nls4+4189evw2/3Os3onp5wq7IN3hqGSPfTtUT+TvaqBS7ohkfzoO01E
         PIr5wi7xdmQtcC6LWuAJkjBcPN0opZHu8aJamfUKX/9rM1EO+McVpT0Imms5WqaQHaco
         xFASHWpZWu31ZAPqMqrrCyRNxW2qmfg46+qBecgjj6LsfJVagPZOn+wI3qcntjRPzblg
         UPbw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ncymd6JU6JRCzOu8RSjNaBvs8fXl8zDphEjP0CA8Xi333Knuz8jU+p8++x3cl77LhEovqj5/V/zCuRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKm1tipY+snlmVHs8p6tV6YQcQ/3bmdzADv1HyZiHb46riElCu
	lJTln8Ye96lDk4XalhJpnpJBVi0dDSYps3EodpXFoBlUmAFDDejE+RTwRvPMw+8=
X-Gm-Gg: ASbGncuHIkkQB3SrzvZpdBkebCu+FWKAHwM9zUylZF7ikMQSRoPQEtitAWFHvhEp9Td
	u7v3+3ai3wfS/Zxcr4+dPfCu8bUzRd2Ck/A0nbkzCtHdPGMRsZr9sdEsWDwmLzWqIkx66viIz5Z
	jSnfeD8CVNGZ4m3PEyew3HIZ+dUKVmWtPI7XSI1IZvkC8CobwIToh1Ucilg881I1lMESHkL6juw
	Cj6Uu0KmYnFVSxOIs9TwRS/9yVXuJ4IffhnuYa6GlJP2kMz2dqI6WkVRYrYR6RyMpDq4EguoBqV
	MZJ6Xr6tnEn4TihI9I5LhEG7FdtRzAWVOKG1nx+tQQ0mov6Ywh6XACSfFV/haYwIPTScdiDJxmA
	i1PIV6SAFOFH5nzGPv/ak5gk9aA==
X-Google-Smtp-Source: AGHT+IEgqURih64QQq878LAlpoiWUHZ5SF6g+OaiNjsjRHNfpFnMktBq587o0TTR3FHczDy3N5hAQQ==
X-Received: by 2002:a5d:47c3:0:b0:38d:b610:190b with SMTP id ffacd0b85a97d-390eca377a4mr9441525f8f.46.1740993549456;
        Mon, 03 Mar 2025 01:19:09 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm14038348f8f.32.2025.03.03.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 01:19:08 -0800 (PST)
Date: Mon, 3 Mar 2025 10:19:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Antonino Daplas <adaplas@pol.net>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Yihao Han <hanyihao@vivo.com>, cocci@inria.fr, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
Message-ID: <ugymllbkcsg22ffgyofvkquh5afbvoyv2nna5udmy3xfhv2rjz@jhgghzldzm4u>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <86551e6f-d529-1ff6-6ce6-b9669d10e6cb@web.de>
 <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5ssf4zg6xgpebyg"
Content-Disposition: inline
In-Reply-To: <3f1e7aaa-501a-44f1-8122-28e9efa0a33c@web.de>


--b5ssf4zg6xgpebyg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] video: au1100fb: Move a variable assignment
 behind a null pointer check in au1100fb_setmode()
MIME-Version: 1.0

Hello,

On Sun, Mar 02, 2025 at 07:02:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 13 Apr 2023 21:35:36 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Cau1100fb_setmode=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cinfo=E2=80=9D behind the null pointer check.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Fixes: 3b495f2bb749 ("Au1100 FB driver uplift for 2.6.")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Should also get

Cc: stable@vger.kernel.org

to ensure this is backported to stable.

Best regards
Uwe

--b5ssf4zg6xgpebyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfFdAgACgkQj4D7WH0S
/k6Ubwf+PAWfTbo0e8l6pPMYDWTrIlWDVs6P8JwsxmPeNHmuw2L+6JmiXLUt4r8K
BVOnwleXuUC4G/EKeAKqCwELLweDzt6QsmUWLUCsc6MWiQ1O3QDCv13Fty9auThY
kk47fq5PjnBwjmIVoMGXAgkBlbRg7kL3mHisr4Znw6RGM/T4kW4GGSSRKBNUDTy3
3zTnFrB5Yu6Kzu4JeU34zrCMxKAvQQoBWC61PkTfjcagCj/XrRG86KI818e+6ZPr
P65IgsUOVTGAFKASeg4ZDgvdvaMnvoOH2w4RENMNeHuYWCe4wJaW/bn5brGZq1eP
MJFndsnaHk7DCh94RiyWcyZ7veHiLQ==
=VPpv
-----END PGP SIGNATURE-----

--b5ssf4zg6xgpebyg--

