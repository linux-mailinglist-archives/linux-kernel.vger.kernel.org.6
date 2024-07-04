Return-Path: <linux-kernel+bounces-241431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347D927B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B828396D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBB1B29C2;
	Thu,  4 Jul 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QCCROBjH"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AB01AE859
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111337; cv=none; b=rroPUMOYjL5Ld8SOksust+ViRSvefxBkEaXqgp800OR29Vw7rnB2j3xjffR3I0luxgKUZn1dcP6eWjZ15m87OZW3I+83kLba7HMbwXNlKNO9OksN9hSv0mntyzA+kJ3upy3GMC5S3+65rEpLD82IChv9R1l0LSyT+Pgem1bqlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111337; c=relaxed/simple;
	bh=XFhbqcN68+AahDrhng2QmTwtFshdRqAObHVsdsgtEzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJemgunPePEVj2FovcXOiBpx4FvyBL2LC1/Kc+/Z1RVNHLZ/pfUTa0sLlwEtSYV1adzGvMGNSjgyjh/Wf1p8HAQJfgl/yu1jW1uk/mLJ9Ve0LdTZxCMtcKNUCQ8bL82Lg3FFO1jSgMa6+xuvuu1O9F2R2mqgg3l0Dqb7y2onZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QCCROBjH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so849840e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720111332; x=1720716132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gFLG4zFJrlBn/FucAJjUHcsOOk9BGIvCk9SlAfApN0=;
        b=QCCROBjH+ZKnr24rlZpkoPu/p9GR3CoqrjAsGYxs/rdkWd1/ISnv9DO6264Jzun6eK
         zTTbc1re8IhAiISKFNQ4BN4o9KLeZwYlm8+Gse2i2vkwexDtcQen2JvU4RvTEoEu49Qr
         yZ4oH7km+BHtRW3FaLsRzG6sVLwSsWB380ccEQRQT2vGt2qaM929tZcnG0i+VnZbTbZD
         UwLx3/RD/6kwiD8z+BKK4bFfct+/HqNQr1oWQ9oOLz6pZdOPUmFgkExaTSa3F0R6tIdC
         sMmJ+6YGYjeIGDikE7tLz4pS3hb7+CxaG930RndzaTMMzC+slpw+VNei1GP52lJ5axES
         cKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720111332; x=1720716132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gFLG4zFJrlBn/FucAJjUHcsOOk9BGIvCk9SlAfApN0=;
        b=L8Z4ZgY/RtefEe0C5TBsElww8RkxP/EqkwXhQHkh8zy+Qpt9V7+uSvyWvTksT/uzyT
         TL8arWGQ1ppKrqVGVNb8W1g0BRy9FZ3dnKypnoA3/VLQwgk9x3pYiyuQJZJxVeu9Cm5J
         9hY6uLZdJDSQHYAJGLcx1XA4J34mE3ugO5wT5t1LpxzX1uEh7F0dTkgaDV/IvCr3tMtO
         IHJqNYtC3vH5JnhZMmVoZJ+THPJjGUxJdlBRS/CTVf8Bih1I8lZk7wWzOAZthOKfhfA2
         KMxWOv08OvlDySS25w/eWfv59oJxKprGGjrdCnmgpo649WkMGGR8PCG6Z01QUpYklZLq
         VtSA==
X-Forwarded-Encrypted: i=1; AJvYcCWaWotdRI0hQGqJiHxYIjmf+sv57mTyhBINyypPBKZZsW8L/Eu5Q24n+OWe0z4300xFEoONwgMfmo5lHzkvHTHmQRBfeWBE1iYKSLwk
X-Gm-Message-State: AOJu0YxdPNlznPgLEsH0aHdmvYWk2us6d8yLQo2p0yANcxUvR6OcrDNU
	s6OAEM3t5wkm78HqAuLQNzJFHMrTbHFRDw+05reogU6RrN6684BEFLj4v8AFzYLY79/V71pcybl
	5
X-Google-Smtp-Source: AGHT+IFC1ulsDzAaYtwquqmpFaZ7DKrK4XfJR11aoCDLZKCz5IXteN+R9iMGU1eCFxFrabO9BRI4Kw==
X-Received: by 2002:ac2:5dcb:0:b0:52c:dda1:5db1 with SMTP id 2adb3069b0e04-52ea0719788mr1331900e87.67.1720111331551;
        Thu, 04 Jul 2024 09:42:11 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58e2f7c0e00sm1135205a12.6.2024.07.04.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 09:42:11 -0700 (PDT)
Date: Thu, 4 Jul 2024 18:42:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] mul_u64_u64_div_u64: basic sanity test
Message-ID: <dzohdvfrh3jivw5mt7aepxezzrvq422xptx5zyz4mouxypnt5v@hj75gj622i6x>
References: <20240703033552.906852-1-nico@fluxnic.net>
 <20240703033552.906852-3-nico@fluxnic.net>
 <20240703103529.2283c3c4683c60f1ae50a152@linux-foundation.org>
 <n92q9p5r-9o9r-prp3-s256-110322s5n233@syhkavp.arg>
 <yforvmqwgvkuulicbkbzf4htlcssvo5pz4s6ieksa57whj4smi@lgdnfo2svceq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="63murhn3aseofrxq"
Content-Disposition: inline
In-Reply-To: <yforvmqwgvkuulicbkbzf4htlcssvo5pz4s6ieksa57whj4smi@lgdnfo2svceq>


--63murhn3aseofrxq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 03, 2024 at 11:36:31PM +0200, Uwe Kleine-K=F6nig wrote:
> I intend to do a performance test of Nico's code. I hope I get to that
> tomorrow.

I'm really surprised, I expected a penalty for being more correct, but
there doesn't seem to be one.

I tested on an stm32mp135f SoC (i.e. armv7) with:

	time pwmtestperf -p 3 -P 1000000000 -S 1000

which configures the PWM 1000001 times, each configuration calls
mul_u64_u64_div_u64() three times. And I got

	real    0m 37.17s
	user    0m 0.69s
	sys     0m 36.40s

on 6.10.0-rc1 (+ various pwm related patches) and

	real	0m 36.93s
	user	0m 0.58s
	sys	0m 36.26s

with Nico's patch applied on top.

Looking at the patch in detail, I always hit ilog2(a) + ilog2(b) <=3D 62,
so on 2nd thought it's not surprising that the performance is similar.

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Thanks!
Uwe

--63murhn3aseofrxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaG0N8ACgkQj4D7WH0S
/k6KAwf/WGS+5hC3mc1/01otA76mBir6kc1Xe6Na9burR/+Y52eehM0kbImCSEcg
KnkUgI8HgdyanAbaK890MSfx/LpN/QSUBteQ37ST5NJO7dX6VQlplFJYY1XMBs3h
UKRBVk32auuMxhe7+zZfxUIFAbY/uClhh/FU4edg804pxWcTtG7nh91x+O1el0kO
9RZL7HqW8TkFBkrAHR80z8qQ95kySwE3w2tu5hNiqOLb+G48XojfqGZYqRMdZiri
06m24NLIK8+aj/he0bI+TfUDhdsuSXOVt+lpNYezOTomLaaKqv9LxQZd5Zz0DUBm
Yivq2vUm7nrB7nCX8F31EsmxCVeNUA==
=lsTy
-----END PGP SIGNATURE-----

--63murhn3aseofrxq--

