Return-Path: <linux-kernel+bounces-249315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D8A92E9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5CF1F23C98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA64D15FA9E;
	Thu, 11 Jul 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mLk9bE7v"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA215ECF9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705747; cv=none; b=ubahRKDnDwBq/wqHZ0/rXIsgYloWbypagCzlK/aqnRoR4zO+CPo0XaZH40TcUdF4g/3E9ZxHRSeYirpEnIWAca1qf1ICroyoraQesoxeSdC1/C3jhp8zJjqBGu496HGarEhWlGjlehbgyBxk/gr9lcguSY3kzRdTzVxc5Xo6J2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705747; c=relaxed/simple;
	bh=W54KqAxBeEcjgM+33L4oqZYLuZPu56t4BE6U2Z5/TX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0IcBH0UnNdBVand00Jw/DgXLxSNIaGo4/wQHimnn14E3Vm3EaP6F3vScoptUkoI+AgvWmkRvB8rrI3tXOv3MbUnjwevQUZmFJ8UTBfTd/I2ysYPN1hasuocs522CFIGJvIzgHijwqsMcuX3bjgpmRLyTfKzRv2jwgKWJK4MpGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mLk9bE7v; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so1153507a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720705743; x=1721310543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W54KqAxBeEcjgM+33L4oqZYLuZPu56t4BE6U2Z5/TX4=;
        b=mLk9bE7vzqBqckQOpUm5Etyj4rl0Umgamuq1eoQokobZ6bU+eBBbs0eX0ocx9F03WI
         0tQLTeDeRFEUI2LdJ1/p4BmE6XYYQxZnmSfz4p/hSj8r48RkfkvA9nPtwKHPoSur4ErK
         ypPPcwPz+ltAqPsp8VVeDE8TUCIZ23D+6+mcAKzXJEA8xcB8elIvBs+YKDErTp+8nAlg
         amlbgTOCXV0q/EB+DpagG0+x50htFSqvv61rggaoBw4gVfuXm6nVT25dg3JKNdfxEfSs
         XqtFA2IYdXidVbNYt/b4UzBkjTG91nJ+LnpyOFoMLxYenNJbcD+gakqbcfPwMKFoqTuy
         Va0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720705743; x=1721310543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W54KqAxBeEcjgM+33L4oqZYLuZPu56t4BE6U2Z5/TX4=;
        b=dkoR29cuiyL+5qQ3VMi5/xsbmPBuTtVMgek900BnXcca7eR7J2vY6Jz3zXpu9dTRZA
         IX4ePDovXA/NCsVwT6cOopliOtcpuPnUezToKYA6fvyD2vY7GTG2XYi06wGPYsroHwct
         xSaTH2p5oOUTNa/tdgZZCkVsDIyC+iojhbsckL3G5pDGZc5Oy/WhZj39sw6QJ/XyGv+o
         maBnUmOQoIBhn3zyZ331dFs17gKt0LeEYPKJNYDgpvebBBx0jycxBI8VRC9kKvW4N7Pz
         316/3ugyD92Jnft9Tm6HFvWHhwPMW+Qb3DGXKGSyfzLMacyNDtaDxAswrPueEgm+2Esd
         E6vA==
X-Forwarded-Encrypted: i=1; AJvYcCVnnlskYa8zOQ9HNrLlznA/NdWrMJ49tvPfT4hMhVRAySbWDGV/ippoG1woOD6rI9ijm6G1STu3B2/OSkrdrIuqoQg6FyiwRZXKezSl
X-Gm-Message-State: AOJu0Yyx0Bg/yUYzZGPM279oqrQnyZub3JYDc0IBy31TxFuk5ZRvA97p
	tp0DbQHWj5Fpdirh5WRlrV0sJx5fYdshl9k7ivko3gwbdN3IHXCS+WPGo7Ez3jRsYU0q3O2lVDP
	o
X-Google-Smtp-Source: AGHT+IGfZtfMRXh9eucxPcMyGgSKnlhrHCt5178yGG2pvQUfh4KnB/rp6xhNMhfb/jt99oV6gpBEgA==
X-Received: by 2002:a17:906:7d1:b0:a6f:e47d:a965 with SMTP id a640c23a62f3a-a780b6ff0ecmr556134066b.41.1720705742926;
        Thu, 11 Jul 2024 06:49:02 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcd09sm259787466b.19.2024.07.11.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:49:02 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:49:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: axi-pwmgen: add .max_register to regmap
Message-ID: <4hbaesqrfjrqs2chu7b3kpg3lnaqoezf7ymo2yj4jwtdzs3exz@tah2c3ht5gow>
References: <20240711125743.3956935-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x7ayujcswi4gl5ge"
Content-Disposition: inline
In-Reply-To: <20240711125743.3956935-1-tgamblin@baylibre.com>


--x7ayujcswi4gl5ge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Trevor,

On Thu, Jul 11, 2024 at 08:57:42AM -0400, Trevor Gamblin wrote:
> This was missed in the basic driver and is useful for debug, so add it.
>=20
> Example regmap output before the patch:
>=20
> |root@zed-tg:~# cat /sys/kernel/debug/regmap/44a60000.pwm/registers
> |0: 00020100
>=20
> And with it:
>=20
> |root@zed-tg:~# cat /sys/kernel/debug/regmap/44a60000.pwm/registers
> |00: 00020100
> |04: 00000000
> |08: 00000000
> |0c: 601a3471
> |10: 00000000
> |14: 00000002
> |18: 00000001
> |1c: 00000000
> |...
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> v2 just adds an example of the effect to the commit log.
> ---

Makes sense. I applied it to pwm/for-next.

Thanks
Uwe

--x7ayujcswi4gl5ge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaP4soACgkQj4D7WH0S
/k6pdAf+NCsft6eAjUSGESUighMEydt+KWlcrmnm3GiFAA01qfzWscHxGhnMU3jP
NlTt/Ksz7YlqDWRIk4DBwKbYQmg/MqF+c0K3HLUMq2w+rZBf1gNUQLDnbfUAXUKe
WlxjgEudclGn+Qmix/02JkBb93EGN9JLN04vs5lWXiCBM0ZFh4dm1xsD5VJkUtwi
jp2RON5UlfRHuZNWXmf0di4ziTY2l75GPzc/qeQdMimAeFhLBtHiRxz/gO4NST5I
nOlHAs6wTgpe8FRDnJkCFDITV+r/ak9o6iKrJsIagFZtgr0b3W91HaeGTzT1KB34
m1GOnvuloxFe7KmP/vvaEo59u81i0w==
=L73+
-----END PGP SIGNATURE-----

--x7ayujcswi4gl5ge--

