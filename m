Return-Path: <linux-kernel+bounces-242478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46E92889D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AB31C22166
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7F145348;
	Fri,  5 Jul 2024 12:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IYwUdSOO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="VwK2H9hD"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6212E5B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182127; cv=none; b=dvi8l1utLhvJMMDp0WVmoRk6FC6V63RPNFquA5aseI2e4du4r9IHoRB8CbfjEBXlgx+j5I47zKUS5nWkOHaC7zr6fEYmhRwdTW582gPK0E1+15NnJZlk9/yCnaod8PQnkgfgt1vtIt8hmrnD33pgPl9GYld2ldPMfzDHB8IqQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182127; c=relaxed/simple;
	bh=9Hs1zFDJHsnXKMqbEA2waIR6YaMTMzH0G9WZSnYl3KM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lKcj0eknVYNJ75j+x9Oj+ztI9e+6dTgRBhetQFqF+jdec4rMf4B+Aa/wxFzv2BD4Kuf79N6IWauIf6Ts8hLwKqOvfAp0UyIFUovAo/BOaxfBDFtDxyoTFyd5Tovojowam0rojtznP2UbW/TcRfIGj3J2fnL5nXIxQzyPkp6Awas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IYwUdSOO; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=VwK2H9hD reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8AE3F1CCBE;
	Fri,  5 Jul 2024 08:21:59 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=9Hs1zFDJHsnXKMqbEA2waIR6YaMTMzH0G9WZSn
	Yl3KM=; b=IYwUdSOOLxZZyywgoQDmoCkfy97Ja14gFZizarsY6QttI+33RBKOZ2
	tKTlJi68daCSFWB20CJ9jnXERNqphhHALqk3lQySfYmUJCeYaWZIKglKc90mEW54
	ItDFVnqWxsurXK2zzIvhDYvWhf8neNJjeRgM/4mxq94Fv8C1b89sU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 83D751CCBD;
	Fri,  5 Jul 2024 08:21:59 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=yZnuD6mMPbfRiPiOb1ZD/0/r+1W9YUHmDSssemYt2bQ=; b=VwK2H9hDin8mybeaG/gXJ7Falt6TTULn9kysC+SUe9RpPm/MzmATv8LSLVVKrJu9v1Wof9R/nJ1zThwwdUYCdVidyi0b67FmV77h4Si4P6Uei6x6yCRxrVGXP/WeA7qGVJbZBMl0GLrwsgIjbcpZfw+9MuEzYV1BUFhxhyFlYqA=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A51D1CCBB;
	Fri,  5 Jul 2024 08:21:55 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 41208D366F8;
	Fri,  5 Jul 2024 08:21:53 -0400 (EDT)
Date: Fri, 5 Jul 2024 08:21:53 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mul_u64_u64_div_u64: make it precise always
In-Reply-To: <3yh26lm4kiig6oyy7st3q2wge2idbzblues5q6jf7xld2mlgba@jsfny35ucs5k>
Message-ID: <5078q5p1-84p2-3p40-p739-r26rs40sss1q@syhkavp.arg>
References: <20240703033552.906852-1-nico@fluxnic.net> <20240703033552.906852-2-nico@fluxnic.net> <adjv6ypwuvlugbx3uqd6q4r5hyj3v3gx4bs6cwcvj6h7llbo6v@jr4p35pkkzyx> <6496p439-p76r-oq72-n716-9q6757071609@syhkavp.arg>
 <3yh26lm4kiig6oyy7st3q2wge2idbzblues5q6jf7xld2mlgba@jsfny35ucs5k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-1822059010-1720182113=:826828"
X-Pobox-Relay-ID:
 2AFC8A86-3AC9-11EF-AC5D-C38742FD603B-78420484!pb-smtp20.pobox.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-1822059010-1720182113=:826828
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jul 2024, Uwe Kleine-K=F6nig wrote:

> On Thu, Jul 04, 2024 at 05:16:37PM -0400, Nicolas Pitre wrote:
> > Then enter the loop:
> >=20
> >                 carry =3D n_hi >> 63;
> >=20
> > Top bit of n_hi is unset so no carry.
> >=20
> >                 shift =3D carry ? 1 : __builtin_clzll(n_hi);
> >=20
> > If n'hi's top bit was set we'd have a shift of 1 with a carry. But he=
re=20
> > there is no carry and aligning n_hi to the top left bit requires a sh=
ift=20
> > of 12.
> >=20
> >                 n_hi <<=3D shift;
> >                 n_hi |=3D n_lo >> (64 - shift);
> >                 n_lo <<=3D shift;
> >=20
> > So n_hi is now 0xffffffff00000000
> >=20
> >                 p -=3D shift;
> >=20
> > Shifting left the dividend reduces the divisor's power.
> > So p is now 64 + 8 - 12 =3D 60
> >=20
> > Then, the crux of the operation:
> >=20
> >                 if (carry || (n_hi >=3D c)) {
> >                         n_hi -=3D c;
> >                         res |=3D 1ULL << p;
> >                 }
> >=20
> > So... if the divisor fits then we add a 1 to the result and subtract =
it.
> > n_hi =3D 0xffffffff00000000 - 0xffffff0000000000 =3D 0x000000ff000000=
00
> > res |=3D 1 << 60
> >=20
> > Let's loop again:
> >=20
> >                 carry =3D n_hi >> 63;
> >                 shift =3D carry ? 1 : __builtin_clzll(n_hi);
> >                 ...
> >=20
> > No carry, shift becomes 24, p becomes 60 - 24 =3D 36 and
> > n_hi becomes 0xff00000000000000.
> >=20
> >                 if (carry || (n_hi >=3D c)) { ...
> >=20
> > No carry and n_hi is smaller than c so loop again.
> >=20
> >                 carry =3D n_hi >> 63;
> >                 shift =3D carry ? 1 : __builtin_clzll(n_hi);
> >=20
> > This time we have a carry as the top bit of n_hi is set and we're abo=
ut=20
> > to shift it by 1. p becomes 35 and n_hi becomes 0xfe00000000000000. I=
n=20
> > reality it is like having 0x1fe00000000000000 (a 65-bits value) which=
 is=20
> > obviously bigger than 0xffffff0000000000. So we can augment the resul=
t=20
> > and subtract. Thanks to two's complement, we have:
> >=20
> > n_hi =3D 0xfe00000000000000 - 0xffffff0000000000 =3D 0xfe000100000000=
00
> >=20
> > and=20
> >=20
> > res =3D 1 << 60 | 1 << 35
>=20
> Oh wow, that part is clever. Before your mail I wondered for a while wh=
y
> the right thing happens if carry=3D1 but n_hi < c.
>=20
> > And so on until either n_hi becomes 0 or p would go negative, which=20
> > might happen quite quickly in some cases.
>=20
> OK, so the loop invariant at the end of each iteration is:
>=20
> 	final result =3D res + (n_hi#n_lo << p) / c
>=20
> (with n_hi#n_lo =3D n_hi << 64 | n_lo), right?

Hmmm maybe. I hardly think in such terms so I can't say for sure if this=20
is right.


Nicolas
---1463781375-1822059010-1720182113=:826828--

