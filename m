Return-Path: <linux-kernel+bounces-518030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CDDA388E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A82918859B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664D224B0D;
	Mon, 17 Feb 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MSrMeMHl"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1C15575C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808394; cv=none; b=g6bPyKwUHN25VBXpGErYhlJ0g0k6t08JFN4knw/TVjdYIrxnOCX1uyHPPnpIsq1Fn5EBKBdJA1zrFWjMJGLYP7xMMzPfWPFFQcKc6Qt92wJu8pUB2flcnY/8/oedsOlPiCU1QLN95QusagzkMcsaZaRy8NfFn8lIaZWN+ksHdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808394; c=relaxed/simple;
	bh=t6fzYE9Z8ryLoZJ+7vGATWDozTDsrr74gCrb47HT/tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2Xo+wf4n50Xcev4kfKcAG+J+AUTG4XitBhQglER8fg+VKqLscrSqSS3wG4TFlbdL6EKJbO0sFqMyekHgPTnC6J1NwsHXseP7ZDGSLOGLf6uoiHH8hUTO3LQ62Ckg3VTHJ7cw7bCXhSv6+1KwsgYQwouir5vTnOo9Is2TMNTax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MSrMeMHl; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso2424132f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739808390; x=1740413190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5zZLpKhpoL4pFz7vzigrvRBLC5VxoaVKvfWnN7a/3I=;
        b=MSrMeMHlOSN4OKvUwuoUgUI2Lso++r10b3Ioo0SaypcDXgsAp84T0Tjk9UN5ahmG4J
         ExxiHflazypACk/G1xD8dNgtPhZVa3Q9aZDS2xAPB885z6Dlnt4BfgOfdMsHPErnJF6r
         d5tou2qVeaP2TgDCq7WeS4bwpHaNeFr93O3202pBS4pz5H4UTrByDElAvk+L/Z1kkztO
         TuitQPGNx+OB1/rDrMJ4ypvOOm/87KjhR9ARav1Jb3MJcJCZ44QH8zn7eWjAySnK8101
         j5b9tPiL4Je+awi4WN9SfHIaU0gMj564fEOYSIJ0cVqB4NV3qHFQFzt/oyCImbGiHtuJ
         jsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739808390; x=1740413190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5zZLpKhpoL4pFz7vzigrvRBLC5VxoaVKvfWnN7a/3I=;
        b=FjzdBEBHEaZ75S3b7em0KpLc2hX/+Op/jTmwlRZJDziU75o0Y9xG/tyzs801oQtJSr
         u+Q/ST/9ySC3ZO/eS4SkvilwdoxyS270PBFYak6OI0pMo/agZGW4JxuJGcZcT9bjnUM5
         Dfy1kaGag/FadEalDYENft3dKyGDJadyTo9SyNK6wVXvI/S4QQiUQqLlj16zzCiCUtEU
         I1p0A1hhwphzmf8fH6pGr80vxr1oLTtTWRJSLw+HVBgnxwKkAH1AQbWeQL5Xt235567g
         2E4eiWSVR1j2eESqumZYo2DJDb7aZvPAsrulTpGablqWcsJEhnUgO4qfNH+EGYa6kSOk
         w+ng==
X-Forwarded-Encrypted: i=1; AJvYcCV54APADWAKqoz/ZzlTHGbchpT7pZHaWqCyPfVQSG7g4YLmtb0AlxP/LmPEEjmwKP0+C/WB3FKstrdUsTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7of5nSyslq9zME/TkDqOve7HJMwGcigceSfxTfQqRgrrT0MLV
	0kqVAPbWAN4PsZuJOJgx+ASkGdyWy8DQVEf4Qpsz2GxT4PCFaV5XUnrVEXgThtXfsRwMf8VR30e
	gA58UcQ==
X-Gm-Gg: ASbGncvFEuyzQxP7ePZvN5jraPIfUwKb0JdxNtq2hy7p29Xfn3zI+JBTqa1nj8EuU0X
	0Cidgd1vgZwBlbHZKj5SHUL6/CFR2T7EFrcs9/0lDi6RdaS1X6Rgd3LzIUskDTT5qgdc6eTk1YY
	ywzm0Nqw82Qaungl0kkFsJw9IEPpgnE9KwL6obBwjs+EfcnhKOCmrdugmCBOkt9S/tJ6tsc9rfa
	iFg82R8wwbXIzIhmjPI/IyUxmprGtl8KbWiWBMuJJvJ8jIAATDVdcbXHu2HHM04vCuOe+0BOa3Q
	VSeaPBC8c25ztDzlhtUBeVi+JDuWU/AcjyBSyg5dMeekZaYdF/GOycbUuA==
X-Google-Smtp-Source: AGHT+IEa/epQxR37BEhyFDusO4FdLZ4NM5IKYGmbhJVL1W+AN0lFXYuZ9wSXrzhqqXI4vFYGVQqTcQ==
X-Received: by 2002:a5d:47a7:0:b0:38f:4b2c:2448 with SMTP id ffacd0b85a97d-38f4b2c2531mr2416224f8f.32.1739808390129;
        Mon, 17 Feb 2025 08:06:30 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7df2sm12632945f8f.84.2025.02.17.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:06:29 -0800 (PST)
Date: Mon, 17 Feb 2025 17:06:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Amit Shah <amit@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
Message-ID: <o5dabgse26d5vn4lzf6hllslfr4h4wdzep7jonkmhtq6njenjy@vmnsshcve6dm>
References: <20250213115517.82975-2-u.kleine-koenig@baylibre.com>
 <34cb36503dae7a2d0ba94d1c367004a2d901e13b.camel@kernel.org>
 <uo3h33wijb7mhjwgugpkjhqg7wusz6tpkh5u5fxbsxp3kzpq75@ggsdroemmdmj>
 <558f3faa22e5717872bf53acfe6007dc3118f17d.camel@kernel.org>
 <k72vfex6qy53xrunz5ohe24c2upfjcdwofozszi4l3k3rm6dou@bd6swzi3v5ng>
 <606b16787920ff5e1807e4f8450add5889fdd1cb.camel@kernel.org>
 <dard24qyuwm6plnswtz4to36w3fynb553aohf5i7u4ln37nhbk@pgrvhqwvwuzp>
 <6d48bcfd0c6030c92f6a5a4a91c9b62f926b3b16.camel@kernel.org>
 <535ivi67jdmcuhns5q4r36fjpqde3clnqq7hr26gmg33jwoxyb@ahvuhhaewh3u>
 <2c676a9910c2d5b1332bb9baa999cdd16763a730.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yawypp2wpqlzvds"
Content-Disposition: inline
In-Reply-To: <2c676a9910c2d5b1332bb9baa999cdd16763a730.camel@kernel.org>


--5yawypp2wpqlzvds
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] virtio: console: Prepare for making REMOTEPROC modular
MIME-Version: 1.0

On Mon, Feb 17, 2025 at 11:53:01AM +0100, Amit Shah wrote:
> On Fri, 2025-02-14 at 18:47 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Feb 14, 2025 at 05:55:41PM +0100, Amit Shah wrote:
> > > On Fri, 2025-02-14 at 17:52 +0100, Uwe Kleine-K=F6nig wrote:
> > > > Hello Amit,
> > > >=20
> > > > On Fri, Feb 14, 2025 at 05:37:52PM +0100, Amit Shah wrote:
> > > > > I'm thinking of the two combinations of interest: REMOTEPROC=3Dm,
> > > > > VIRTIO_CONSOLE can be y or m.=A0 Say virtcons_probe() happens
> > > > > when
> > > > > the
> > > > > remoteproc module isn't yet loaded.=A0 Even after later loading
> > > > > remoteproc, virtio console won't do anything interesting with
> > > > > remoteproc.
> > > >=20
> > > > Where does the interesting thing happen if remoteproc is already
> > > > loaded
> > > > at that time? I'm not seeing anything interesting in that case
> > > > either
> > > > ...
> > >=20
> > > The code I pointed to,
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/char/virtio_console.c#n1993
> > >=20
> > > either enables remoteproc if the module is present; or it enables
> > > multiport, but not both at the same time.=A0 If remoteproc isn't
> > > present
> > > when this probe routine is executed, multiport might get enabled.=A0
> > > And
> > > then there's no chance for remoteproc to get enabled.
> >=20
> > The only case where there is a difference between IS_REACHABLE and
> > IS_ENABLED is:
> >=20
> > 	CONFIG_REMOTEPROC=3Dm
> > 	CONFIG_VIRTIO_CONSOLE=3Dy
>=20
> Well, also if CONFIG_VIRTIO_CONSOLE=3Dm; and virtio_console.ko is loaded
> before remoteproc.ko.

There is nothing about module load ordering in my patch. What
virtio_console does or does not doesn't depend on the remoteproc module
being loaded or not. It only depends on .config.

This is true for both IS_ENABLED() and IS_REACHABLE() which both
evaluate to a constant known at compile time.

And already now it can happen that the virtio_console init code runs
before remoteproc is properly loaded.

Having said that your mail just confuses me more than it helps.

The problem I thought there is and that made me propose my patch doesn't
exist. So I suggest we just drop the patch and the discussion.

Best regards
Uwe

--5yawypp2wpqlzvds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmezXoEACgkQj4D7WH0S
/k6dhAgAg6ULV4QetXhbVDz/LC/H+OPXIxD2pxT2t34iejoU0E46UekQwbAPoAEW
nhsq5aG7Nv+J0dYult1rN39eEDWo05NXonBQKgV5jDy0n8B0iV7CqZVpZk9Oyp6+
YyDGzI8u2emU4pMyNx9lbNj9AvI8bi4FlzeBKYZe+GCI3r551RUT1OYe4JjGvwDW
JgqtMTA451OWGbdZzkzzap7IfTVO0ErdibdPPAMaybMnx6y/LpuaDUNQAXtjWLA0
CLAQBGNJlXuz33gDNn50Fv/4XhP/CsuwBwuUeFzvaubWAz/yKvehZRLxOhP+6bxX
b02pmHiG4xdM3VHcVyCf+RGRXI3vxA==
=xm/J
-----END PGP SIGNATURE-----

--5yawypp2wpqlzvds--

