Return-Path: <linux-kernel+bounces-242112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 427959283AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5591F22E21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15253145B2E;
	Fri,  5 Jul 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="klS2DgMQ"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C491459E1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168141; cv=none; b=AcKmfYbekTpNHupLt/qd6o1hW+9aNXOUofZm99pG+uaYuR8MkEtJPMwMr7Ov8C0FmJi/pJQk6jJxuvJnTIqcrq45qsFmSC5rwH8OitrvMBhbFDvs+9qyMY5/ROLBFXOXxgopZKSPwvBHYgnvy940YPeZU1k3ROlwJ53Qp9oLL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168141; c=relaxed/simple;
	bh=y59QFerQOA4J7eakTJ8I2CwxfMKKybPD/sxftq5PJxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW/59R0CG9WFvK0Ra/zErUHp+Jdg63ary+xlVPZPmieNjH1vFWZymvBu1hgpEOxD0xN0Qr8COrqBDqMYU5rirO1nmdmvUKgbBHuWMbCu8BGci/v/nHBksz7ASo2zgiK6UPtpfhGwkbZ09MsE98HuEd0LCMNbwUKZGlXg8ysBSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=klS2DgMQ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7523f0870cso153464966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720168137; x=1720772937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y59QFerQOA4J7eakTJ8I2CwxfMKKybPD/sxftq5PJxg=;
        b=klS2DgMQyONmuLC6Yw5JfbANj/k7vBvTvecY36wI70FH0l10tbvlZjrEvQbp1sLE79
         Y9XXrdG68f4m8VnSilamWRxKkoaD3fjsiZnQC/re+xqrvgwwVUVAwZu1q6/SHSJGw+Mo
         GrZ74IDdKQ3oj3J/MD//J1An3+DgqDCHAj2GadZCn0av3pXbZO7s8k919ro2LnOdQCLM
         xgasySdzJ+HsMQMM0BNJ1DGxohkrFpwiZmdL7zx81QkWnYhg1MwSCMF4mADFjDlZUfHo
         EJQkz3/0AsnJelKcKG8jeE28k6n1FhzRExkTVLtQOybANBBTTWPycs+ijtGOJ0g0wnvz
         usLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168137; x=1720772937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y59QFerQOA4J7eakTJ8I2CwxfMKKybPD/sxftq5PJxg=;
        b=EO4NDXQl3/JrFsfPSrDqRXooOHuicunsXNqLL5axbwcCg7BYs3+LxZ43uBqkZyAL42
         nfzOZbljvfxvH8DGtabCZJLMSckKQ8n/WKORaDvWZCXs29AAvCD3KL+6zGjjNKnaJA8X
         PlAdoykWcUK63gJW513YkWmH4MHlKfOHlrgvMoYp61lgs+xNRdceREz8Bt2RAr42qq+T
         5jC39VjrtoEuPVzjuNffhG9ZjUHu6z8YsB6ozva2JvcXF3S1w17KN5/z1ktFKe+NWZre
         NuWiUnHfVoxVxqqF4/ZL0y9D9F0T/K32SGxF2MLa4GdDmd2Y/g5a/MCLu2ioRV3xtsPm
         3vMg==
X-Forwarded-Encrypted: i=1; AJvYcCVtlx6JhJg0AyDB6mTB338xwbTluUgYmP5aRItjX//9U59KIMNHfTuxdmwC/se2jZvHnz6Vt9tHms3iOZMDDWU5NDYKenlbZvpUyMRc
X-Gm-Message-State: AOJu0YwAgOxshFN0NBN6xGEUaTVa1FqAPg0TXSnd+b2S2tBPwgzfAxJ0
	3S59T0saRyLeshWOSVtHrxND0ajxnkOq46JCMvYkOfBHv7TfytEAXO9fhch4NXA=
X-Google-Smtp-Source: AGHT+IE/m6e1THvR0uTL574dUHDFIDoIS8PPofd44vUY22r/XbhdInPKcgTPOtGXSj/oi0o9bswxuw==
X-Received: by 2002:a17:907:94d0:b0:a77:a9c1:7c63 with SMTP id a640c23a62f3a-a77ba4687a2mr316044866b.19.1720168137448;
        Fri, 05 Jul 2024 01:28:57 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065213sm665082166b.132.2024.07.05.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 01:28:56 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:28:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] LPSS PWM cleanups
Message-ID: <y5r5dtuvkvoigk5nidn3vywwh4tlvx3oij3crpt243jamvajok@imghdifonrwd>
References: <20240605131533.20037-1-raag.jadav@intel.com>
 <ZodsUkFQ4BJDU1JY@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ra7dyglbafwxgltx"
Content-Disposition: inline
In-Reply-To: <ZodsUkFQ4BJDU1JY@black.fi.intel.com>


--ra7dyglbafwxgltx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Raag,

On Fri, Jul 05, 2024 at 06:45:22AM +0300, Raag Jadav wrote:
> On Wed, Jun 05, 2024 at 06:45:31PM +0530, Raag Jadav wrote:
> > This series implements minor cleanups for LPSS PWM driver.
> >=20
> > Changes since v1:
> > - Update commit message
>=20
> Bump.
>=20
> Anything I can do to move this forward?

Sorry for being a strain on your patience, I'm way behind my patch
review duties. I applied your patch now, just swapping your S-o-b and
Andy's R-b in the commit log to have your tag last.

Best regards
Uwe

--ra7dyglbafwxgltx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHrsQACgkQj4D7WH0S
/k5H7wgAtIM7BH7CuTXpmUM68B2cCKjh/tKHNhdw4zxNG2SQBs4791dwGPybxPX/
aov0GA2D4ZJhk31ny4pR9NtOWfkXd3wSuXyf9X5/9o+uPavJ21vTFowFrkFWRmby
Yk8s71Jw4ijVGgGXPyQQ0Da5BlxOLYU4ryr3I6QPsOar/0Py68A9Dzrey4IQ4dgt
pCX4OgtyBPRhsHKtEOzWTZSKiCGjw4OhR1UXm9U5+lJaOcc3I/WdP6/q7Slrj9Qk
NYE+Sfwy68YdxkY+eZ1Uy5zaRf2A5k769NtVkY1g8nV29/mP0qBvxkFmuQpuRyO9
u8Bb8afSwpEQ6eq17eGK7zGsD7X8cA==
=LpxE
-----END PGP SIGNATURE-----

--ra7dyglbafwxgltx--

