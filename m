Return-Path: <linux-kernel+bounces-426371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784A9DF244
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A69D1629A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676D11A76DD;
	Sat, 30 Nov 2024 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KUAjtzF6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F718660C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988093; cv=none; b=UbhoxcqLmjKCJx0k6Ly3KMVOUW26ri8CbVzVoohakFY0xlWxT8KFoKfGjeReOpIACwBWgrvjR1xsW8gwxz7XPmAEOswoU8szw1zAW5LV/H2sqjMv/Ik+3Bs21TX1FU5yEfAKa7BqDnWPPL+CKpQ4uryaEJbLb75bv785Qbm5/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988093; c=relaxed/simple;
	bh=qsMmgc7VVqI1NYDbmYW2W7ETGnrlEy9cr4brY+cia+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFTNpvuFIHsGkv2Wovy/4PgVatK1VkwLC/C61jB2Ky+8hNGcmKFRTocbPmJORhLHx7Ctf9rUcPH9Z3gd2mINpV9B+o+xnPOINrYonRloWyKeWD8OOul/A1c+gBks/S5/XPfJzihBN4osy1WV9VxDqJ6AIhjLncJ+JGD8QD/WCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KUAjtzF6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso25988915e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732988090; x=1733592890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsMmgc7VVqI1NYDbmYW2W7ETGnrlEy9cr4brY+cia+Q=;
        b=KUAjtzF62CC7o1iJlddRXeDcS63AKrS6o2csdZiRkIpqPO9p4coW5DQylqGrbJOVfA
         BHFxhuX2htKAbrASiynNEi3pHXKxEpBULgs+cWe1nDz0uW6F5Kg90U8QHChAIoCAzo4S
         r5EZYTJE8ij1iKo4Q/Mm4aT1O4gvOCYYPgFr1hUXEcrfMOcwLUzIyTcbR5D7+tmeWZT+
         W3kJuu/FaIweKmmHUAU3uPwKcN0gLY46lzZeqjB+nFObHaN5M4+UkIyNk6mR0rgMKsxi
         /JmiZdDm4mdMCiS9NyYTQYWd7RN7AyBmA7rD/Zp/kAyRJFv1lF4BwznuVc5W2uIeH8sG
         czqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732988090; x=1733592890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsMmgc7VVqI1NYDbmYW2W7ETGnrlEy9cr4brY+cia+Q=;
        b=vPMC9Cf02DX9j52UmMPdCKFPjGGqfkCXtNbAI4xlNXZyGo4WJw6mtQdW8MoSlhMrB2
         DNCWIXsqPc02eNqqcgYkbC0URh+qDA/ygEdw6pHBh80tA3DQ8SJE6LfwTxkDro7k8GVg
         fLqJwFRUB5oWrzHfPpWJruFgonwabDNxnkaQv+fucMd2TASfol9v1/kK148qFj1s/Xu8
         cdgFWSzTPhGsTLAQ1eCGt3uPBcSfgGDr0/horeBmFF43L9jdPdK1C8aCz2ceBvrlk6WP
         M+T9wGYgT9sp+NnKhNKcHQWK0ft6zGr//BYK+PK6VAN5zTEVRYTSj39teSgYCHTIJ7Zf
         RF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoupc8RfcSdHiM5mA3s81VtkS1yD8Mujdy/m/IV0ZdqKaMLUKSeQkqEi7d8Se5XZgGE4I3YaKU52+Gv1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kufrlOG+Iu+K6+hmaTwDhNz26QRk8zYYOd+LQ1o4zotEICti
	Irl27ERAdJo1JEZQBq0TSeVcalSd0I3Z5aHiHIc9KWRR1yfJvnkWs+Ti92kVpjM=
X-Gm-Gg: ASbGncvha0PWJJ5jlPEYl5qUbXQTiLW8EQNMmyHydyh5FHAK12wRd6cy6xSuNbukBxL
	X7OCI9qKfeiE2wgOuF02mTo68FvepXyAVZyUPxPPLR7BrLKSWlnDNH7QmCn3XZVSr+bj7X2q9qv
	wustI8rnYfItj0SpKSnr5NyCcoTA7KzA4VYKqzrR+OG6i/o/oKU6nsvf2ua3JHTkCNPUWAwg111
	0pGF1gdKGF4LjUl1lNFem/zX8LL0ETyiLn4vD6cn7RnxlGtUMjoAQY=
X-Google-Smtp-Source: AGHT+IGmJsuwdTp1+qH1HtJJ99e3KU7FxpydrVf/Ldxo/bRDrFT0uNiq2Bppb5EsftEac2A5Pxf5UQ==
X-Received: by 2002:a05:600c:3aca:b0:42c:b5f1:44ff with SMTP id 5b1f17b1804b1-434a9df2678mr142033775e9.24.1732988089947;
        Sat, 30 Nov 2024 09:34:49 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74fec9sm121921895e9.6.2024.11.30.09.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 09:34:49 -0800 (PST)
Date: Sat, 30 Nov 2024 18:34:48 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, David Woodhouse <dwmw2@infradead.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
Message-ID: <lchtswwdxq7uwjfg2e46k2jyzpr43jk5hxvwoode7cc56wuthw@l2feh4c2yu7a>
References: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
 <Z0soVfzwOT2IHunn@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nyjincpz3vf4d7ns"
Content-Disposition: inline
In-Reply-To: <Z0soVfzwOT2IHunn@hoboy.vegasvil.org>


--nyjincpz3vf4d7ns
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
MIME-Version: 1.0

Hello Richard,

On Sat, Nov 30, 2024 at 06:59:33AM -0800, Richard Cochran wrote:
> On Sat, Nov 30, 2024 at 03:53:49PM +0100, Uwe Kleine-K=F6nig wrote:
> > After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> > return void") .remove() is (again) the right callback to implement for
> > platform drivers.
> >=20
> > Convert all platform drivers below drivers/ptp to use .remove(), with
> > the eventual goal to drop struct platform_driver::remove_new(). As
> > .remove() and .remove_new() have the same prototypes, conversion is done
> > by just changing the structure member name in the driver initializer.
> >=20
> > While touching these drivers, make the alignment of the touched
> > initializers consistent.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Acked-by: Richard Cochran <richardcochran@gmail.com>

I somehow expected that it's you who will pick up this patch? Does your
ack mean that someone from the netdev people will pick it up (and that I
should have added net-next to the subject prefix and should have waited
until -rc1)?

Best regards
Uwe

--nyjincpz3vf4d7ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdLTLUACgkQj4D7WH0S
/k6mMgf/ZcizuPc+YzaId9atZ3tr7Zf1rAMV+4X/2Ot8ER40etHWYFAm7vhF/L4t
8/2RYjvFxTjEhZ8DndSGbWNalkiq8MhkoVkpjNbqOBu3VR8NDQjLC9KxwhVEqGBM
1hTKyyBgXCQ5c1H1xZbA1jwlqK5pNzfxDWxnJzfeUjdlgcOapdjs0pTELWnV5K16
6I/m8P0fAQjYFbH00xOVtNF3q9cTzYnSGz9twYolybuAbrXTMWExNmacZqnv01P+
D6uqatHJbDxRJsiKV6JyzPl19cBpKoPOxdXNgUzr3oNoBAkZmnGbdhVUyyfS1PhJ
1VjLNfVsVVQAYm6jY3+b8Acbq2uTcQ==
=L2su
-----END PGP SIGNATURE-----

--nyjincpz3vf4d7ns--

