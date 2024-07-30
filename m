Return-Path: <linux-kernel+bounces-267765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8104941536
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6427E284732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBC1A2C25;
	Tue, 30 Jul 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GmYNc+ep"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81C1A2C1E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352446; cv=none; b=P52Zd0lykuZrwfTr01++cx+UJITehQxatQV0dvOwrLKQ5cBITjmQ/uCsC6LhJba22bRWyKVHmk2YKgGYk1j0jYO1CUb4aV31DMz5cUOIeCUjNB7uHeuo92VjlV7N45Ok10iAbXzx2GPxHaPTfVYA7QCfyC4AlzOMVsU1vUx8bs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352446; c=relaxed/simple;
	bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEqa9k4F3KQ+0ycNqj//p4yR6H9cjF4tb68aPkODmeOi67ObDnqtpBhnNBwFTbuE5vMXTL0LADbYRROhgPQuyitIeDOFKmS30qpmGQySk4fRReoIb7o7FGpWyp6MQnES+CdbklmJXhyYfxUjMzBkliL2kb1cyEIKxaqu/7WXnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GmYNc+ep; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efaae7edfso5204998e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722352441; x=1722957241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
        b=GmYNc+epkEPEL6F3gkJQVfz2nwQKkQyjVDnt1xU3BDsuQVq49zXldJzXvsZvSPedAl
         xJvrdaui8t8p6llOi4hfo29LXpEGCZQ3mqan+i+vO+kZv3sZR/Qsk2zr/HhmFpigS9nh
         4RqB1ocIrsXCGuM3gLW9jhTSiy6cNhVMxOtyDmkgmN+z8AwkRg8n2Q8jeQHViVy1W/1q
         mKxa4NKrcWz6CPB3ynux4pauNsPsHMD068WtrdHjFw1+aUZd57+0gm1mbGYzMDKUbCt1
         N8fx7bM9H2p/UeTuZD5IgjivGJ4EfsqQbyMm3Jmsq7QPhXSD0BDYYXTPIqBFQXuenU+H
         Aokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722352441; x=1722957241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdTHQeQ7kLyo3mfmwgSTm9XPXXY74L+sdG/PYhBWOtE=;
        b=AjWnASjxROm4SYB2jkxgKHRxtF5nqLbkWiMj14lgIiVrOEBrXvSXF/Gfm7lb7gq8oU
         ojH3b7Rm+yR6Sz7oS7C5vTwO0UAlhFuaGPIuzdv2ptfOBtCagcbK1kkJjYFijiY41EdV
         ZvF/uhhxZ7zW7QJNR1QkWeoTosIcDfDuoGlmGCaMmXfV+JNsFz18UV6AzxlADMu4+Rkz
         /1zuYcBvdG2r4Q/oK5nsoai9h0tQ7jsuE77CM7Kc8Gor8g2bY+9d6s+X7UgRQtTX8VpW
         R1rFKjIbXeKdKJDkmzBNi2qNdnQG+iKWZZ6Q1fbUvKMGmsM6onLaT9KMo2tGOZUgiA0B
         B+0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7n7AQXzMZGSDnBWk5Dq6e02WQYwDrURwD29kr4YoMqmYpy4YY/xYGRVflf8uvhqnVn0Bhc9JOQ0vPyGP4HYEjzHoAu1wTHs3czDs7
X-Gm-Message-State: AOJu0YzHFym/9hAdTRtD5C0cNyDkqxQ4YI86pxnd+ETGP9V3ZD84LgSG
	9o6u9AT5qQ2F9hn6piBvxEYhslSbZJtz+dMTeTmX5zkzmeiP0UhVAuMagbZk+jE=
X-Google-Smtp-Source: AGHT+IGLH7u6gNvmP31iep2dgQ8sNneBa4byGkknFmkyHaJGeb6F7VEVA6LUgnVJgSR4NXzXiXtiLw==
X-Received: by 2002:a05:6512:b8a:b0:530:ab86:1e with SMTP id 2adb3069b0e04-530ab8601femr1807985e87.6.1722352440709;
        Tue, 30 Jul 2024 08:14:00 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad91010sm658249966b.172.2024.07.30.08.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:14:00 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:13:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Make info in traces about affected pwm more useful
Message-ID: <pmz5sgzaroljhbyeulvh3mf6izhwna3d2mjueo3udosy45uza5@5dljnvmtpu5v>
References: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
 <qye5vuh5hzoemdciohq3x4oofjpvw6pwe777loqacqfmhf4grg@5gtprhv3g377>
 <20240730103910.6de49acf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ri2nz55ffg37fvyu"
Content-Disposition: inline
In-Reply-To: <20240730103910.6de49acf@gandalf.local.home>


--ri2nz55ffg37fvyu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:39:10AM -0400, Steven Rostedt wrote:
> On Tue, 30 Jul 2024 09:22:53 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > I think the patch is obvious enough to be ok even without the tracing
> > maintainer's blessing. I applied it to
> > https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/=
for-next
> > .
>=20
> No problem. Thanks for the Cc. I don't always reply if the patch is pretty
> straight forward. But I do look for things like holes in the TP_struct()
> portion, that would waste ring buffer space. As well as uses of
> dereferencing pointers.

Looking at
https://lore.kernel.org/linux-pwm/7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.=
1722261050.git.u.kleine-koenig@baylibre.com
is this also in the "straight forward" category? If not, some feedback
would be appreciated there.

Thanks
Uwe

--ri2nz55ffg37fvyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmapAzMACgkQj4D7WH0S
/k4QMwf/dmmEA3gl+PIcynIa/JtYamuZSqSBc7oJ9ffWZ8YdfNaMUlcQa16DmIl/
DA5Rg8eX6Y8/ZARJG6xgB8dqgyZFf2al2+oPTE/BOiL/a3qWLsKwlJlwrQ8/FYfc
R9WQtlOYxcRO7L57iGoPR4zQ89y+UiSy0IL57O02NxNSXE130TSB2Ue7gmDEXFn1
PL571J86vCnGNaX5odZsYU/d0ZtsFX2GkuU9sk4W2i+JfZz8s3geDJPGnC0/14SI
xVHneq/7Wgqy7xDM7O/glS1BmYTjbi1P9qYR3cLhaM/sx8xVRg9DbmIsAeZc+c6M
2mCsgAd8lCb8x0Xm8hetCjylkXs/1Q==
=dJbl
-----END PGP SIGNATURE-----

--ri2nz55ffg37fvyu--

