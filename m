Return-Path: <linux-kernel+bounces-515446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B65A364F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909AC1895993
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB59267710;
	Fri, 14 Feb 2025 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fnqyKzBj"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499E265CDE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555234; cv=none; b=unKBniomZoKlFhRJWEGExfUfiJzN+N8APXkU4h7vAESFUad8zeTQdIX/5455lk8aI/mXWp2rm1AMPbH/sALODqE3+/z78onENcssWOHoSJM2kblvwy/49qxsZIcZfe5oIy2NPOi7NoznXW+LZSQK1cqbXCSMJRHkBC4I2nbGKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555234; c=relaxed/simple;
	bh=t3oWETlabnmfVg8DbBC0SNH2igt6njm5VPlQ2ZhjXkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOJ/Ja4nRwrjawzE0x9V4lSEiEpch/2hBtmN3oStoO1elP6txaZpEYzqR182iScQB6x0sGwF3FL/dI0AfmikT7H8o4T5pErkDacKhnCdZyqOy+ikXvYV7IN0Ha47U1clngQFT7CkZE8IojpU06OTAXNBeQnwU8a6jtxgYjQZp3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fnqyKzBj; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-439685e14f1so6966715e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739555230; x=1740160030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lazeQVqM8HBrkNbfoBLsm78c+HYiZJZx2UTk1PYr3WQ=;
        b=fnqyKzBjYXAcTb1mxujW9fUw7a0Ro5torIBsLvlHHIR67I2sroceNalS/nsSX61XhG
         7MmESxY3z4h3ccG6uqWWmZZy4LQKhjaPKd7+/8k1WdeyQmt4nnN+1t3Y5SffOhL9IxXe
         o400LX0sdEQdjux2hrbQHnUKQPDTckKivkfcRp2OSmGtX0PCcKJcHzJYK0bCdHzmneUE
         LC06okbkJAyYi0LwWzwKlxhbURhM270/tVt8ZSVJdl2I4XmXV/zjVOXS8yaHKoBpxrsF
         DFkBAVAzBDPkICDEDuRGDMvlloLFviIzpza29FWZhugp3G1NvHJak92/dYMB1+alLQo+
         b0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555230; x=1740160030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lazeQVqM8HBrkNbfoBLsm78c+HYiZJZx2UTk1PYr3WQ=;
        b=l4NjjYpaT3cGe0KBeIEgReVW3XQ9kBluEHkwLuyDnxqJgDVltgDoZfW1nVBaqSLTpz
         Gt4pFC3gfQgRiFBssTpBd9UTv5VTNALJ4VBgSiM5qejDpxT1zybQb3vvax2/ooQOPjMV
         uGYyOd52FP/EMVDXOUJPuFi5p5/rQhfAiFxqV571PovUYuWkzfZqTi2zBCxmgYJjJOEG
         sN5c7elQBDoZOaS0qCMz8tKWM3+KzMisa4WfshnbjaQQaNlUvJwvChjZiXQGGs5w81zA
         AFPV9Me6fMnlACGjVyq7Hahj/6I1+mGX/F6uK03E0ylYmajlo2D6PNI9QWgh2f/+Lz2m
         ALNA==
X-Forwarded-Encrypted: i=1; AJvYcCVyr3Y5ofsM142PQrD4hvCfdZTs3sTaSUtaiDO3m58L8ZXvwoGKt4KW+zWmUwlqp1y90VbWeQN5WBeSyHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXrNoFpLcUih4J3AA0gxx9/94vLxGcnYTFOyrfbBtngplcS+NF
	Bb8lNNJzlWUWMLwR2Wgg+stscpCIY/yID9l0zpWwZqS4P/SepDKkWI+6aHLUI4+8m8du2fsRjGX
	UG/Dctw==
X-Gm-Gg: ASbGncsdHb/EBg47ofs8XZiuSffNopvZbgjjT1KQBS7qv0HwA9FsOI3+kQesMYhyQNf
	WqH40/RiSsABNbwlEis991FexWbYTCnCHJih+ri+nt/rPLXPAiUL8hIX1hVWzEVBqBVmP4y5cfQ
	kQrsfcz/tywEXMGQ5/cLr7kSJFMylpJYOMaG+w3tHnSxT5yYAyFNR8w4Zow4GyBYdHDsohU4X1x
	HYyuGf91H49qj4YtWswjq7tVLa8sYH2d+PELRut+OFUJqWxvhkYgbTIPhLIGk/6fyQWvKbYvn5y
	d2pLAjdEWAU7HmBvmIiumcTdLSF7FmI5QeMEJi0z9uDaT4kJDMwIwB0DVA==
X-Google-Smtp-Source: AGHT+IEs0d7y7ALPKarUJ4mTHnR3e/ikwhGCmRE/iYFLD7SdNQTwPJz+bIdLpQ+jOwOyuaxzGwSscQ==
X-Received: by 2002:a05:600c:4711:b0:439:608f:a37f with SMTP id 5b1f17b1804b1-4396e699e92mr2382245e9.5.1739555230357;
        Fri, 14 Feb 2025 09:47:10 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395afaf052sm77057895e9.13.2025.02.14.09.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:47:09 -0800 (PST)
Date: Fri, 14 Feb 2025 18:47:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <535ivi67jdmcuhns5q4r36fjpqde3clnqq7hr26gmg33jwoxyb@ahvuhhaewh3u>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
 <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
 <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="walgac2exdfodujc"
Content-Disposition: inline
In-Reply-To: <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>


--walgac2exdfodujc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

On Fri, Feb 14, 2025 at 05:55:41PM +0100, Amit Shah wrote:
> On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=F6nig wrote:
> > Hello Amit,
> >=20
> > On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > > I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
> > > VIRTIO_CONSOLE can be y or m.=A0 Say virtcons_probe() happens when
> > > the
> > > remoteproc module isn't yet loaded.=A0 Even after later loading
> > > remoteproc, virtio console won't do anything interesting with
> > > remoteproc.
> >=20
> > Where does the interesting thing happen if remoteproc is already
> > loaded
> > at that time? I'm not seeing anything interesting in that case either
> > ...
>=20
> The code I pointed to,
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/char/virtio_console.c#n1993
>=20
> either enables remoteproc if the module is present; or it enables
> multiport, but not both at the same time.  If remoteproc isn't present
> when this probe routine is executed, multiport might get enabled.  And
> then there's no chance for remoteproc to get enabled.

The only case where there is a difference between IS_REACHABLE and
IS_ENABLED is:

	CONFIG_REMOTEPROC=3Dm
	CONFIG_VIRTIO_CONSOLE=3Dy

Iff in this case you never want to test for MULTIPORT (even though the
remoteproc module might never get loaded), then my patch is wrong.

When creating the patch I thought there is a hard dependency on
remoteproc (like calling a function that is provided by
CONFIG_REMOTEPROC). I don't understand how the remoteproc stuff
interacts with the virtio_console driver, is this something in userspace
which then would also autoload the remoteproc module?

Best regards
Uwe

--walgac2exdfodujc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmevgZgACgkQj4D7WH0S
/k7HTQf/Qu3c/c+WXh9ZVNVbAWLGM595jWag8q5Fnrvl5a5haHcpx3WNtyTyVcW+
hz9ygSWroLlA3Mm4rvYjbsYTIwhqVSeXdhH3WvQ/ihfkJLLm2PizX/89foU/DfgT
uHfEUWlCi3VdZ+IWRw/1V9vdjzNrS+88tjYXGHIJ2oGzxIbczuYrwFwgk7ecHA/Z
0VcS1MbdvgNHoXN6y1kvvSiO0vPSXmBFos4bFfVGWxjxqt6ZHI2kHB8xt4E+wuFt
Hmce87lyhSguCtF/tsbf1MU6BRv5VvhwYtkHxxxlsjRxF2vWDZ9fpte8z+nVD4yD
sftqkZCLoiGOtr2PqZDxEiIvsJz55g==
=QIOV
-----END PGP SIGNATURE-----

--walgac2exdfodujc--

