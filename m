Return-Path: <linux-kernel+bounces-565100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CBA660DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48C73A52A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C693120468E;
	Mon, 17 Mar 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RIM8uLs/"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05591FFC44
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247860; cv=none; b=cpQrGMQEzFl9ztSKlHq6o2RJO8r5tB/EVuFRCUqYuI35hq9jG5lY0WZDJEnrqvMd0ZpYWlI2YM2gMbUfBjyaNWxL7ybYvubSxhI3mCgZ8bb9uz0cwZx/JtfqFB8kj+n+OPDq+ektY+38QkhwwsgSMi2T0bvV2dbeRknezvmIhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247860; c=relaxed/simple;
	bh=kjFMmMJneInhZkEqfeFTWZ2lT3byx21zcfOU1fur+Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9CqLN36NarMHprPomNjYZt1NM6Ik78MVuwYpCdJ/ARpROq7P0Vo8+gZPn6rc0j/nSmjVkmww1aysXQNDO1z1L3qeOTLc5CEVquxLewQD6tUmfp1PIiHJJTMA1gfCUTeQsdgUbS/ZIqJXFTKojQfxGxL6JNd+0sdobhdMBklXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=RIM8uLs/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1742247853;
	bh=kjFMmMJneInhZkEqfeFTWZ2lT3byx21zcfOU1fur+Rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RIM8uLs/Rx++lH/IkmuW39PTnLkmwdfZsnJUnWeQIwcJuEeXvXGkNpxsYkWwJUi/d
	 HptH29XqeJBm6uEKBoemTA06VTgsoo35ydB0AC0Xuy2zLYcKwMXPToRfivQpOxT9+d
	 VyQai7k/XkPADke5bxAC6HR94A0g55MB243ByzXOJF/t0JGGNtD6lwFCAeiABpDhdG
	 isUYIhKbXeBE32biyWffVk34bqObZw9qweRI4mUvBUlsYKt56VHEgigI6CUuOfQYvc
	 1/Bo/a0Sk4uz2bjyQ1GXkphFv1AOzGeEQnQaYuc1XkET7DoqCqmViRh+FLGsXHOzwV
	 DE+BrCeDYr/iQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZGpQL5MMjz4xCW;
	Tue, 18 Mar 2025 08:44:10 +1100 (AEDT)
Date: Tue, 18 Mar 2025 08:44:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, Bruno
 Sobreira =?UTF-8?B?RnJhbsOnYQ==?= <brunofrancadevsec@gmail.com>, Danilo
 Pereira <dpereira@lkcamp.dev>, David Gow <davidgow@google.com>, Diego
 Vieira <diego.daniel.professional@gmail.com>, Gabriela Bittencourt
 <gbittencourt@lkcamp.dev>, Gabriel Krisman Bertazi <krisman@suse.de>, Jakub
 Kicinski <kuba@kernel.org>, kernel test robot <oliver.sang@intel.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Luis Felipe Hernandez
 <luis.hernandez093@gmail.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Pitre <npitre@baylibre.com>, Pedro Orlando
 <porlando@lkcamp.dev>, Petr Mladek <pmladek@suse.com>, Rae Moar
 <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Tamir Duberstein <tamird@gmail.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>, Vlastimil Babka
 <vbabka@suse.cz>, Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [GIT PULL] move-lib-kunit for v6.15-rc1
Message-ID: <20250318084326.7ede18e2@canb.auug.org.au>
In-Reply-To: <202503170842.FFEE75351@keescook>
References: <202503170842.FFEE75351@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/veluDy7n/6Q5eiqrUmaphew";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/veluDy7n/6Q5eiqrUmaphew
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Mar 2025 08:47:13 -0700 Kees Cook <kees@kernel.org> wrote:
>
> Please pull the move-lib-kunit tree for v6.15-rc1. This is a one-off tree
> to coordinate the move of selftests out of lib/ and into lib/tests/. A
> separate tree was used for this to keep the paths sane with all the
> work in the same place. Doing this across multiple trees was going to
> be very difficult, so any on-going updates were collected here to try to
> avoid merge conflicts. I think only one small conflict remains, just
> today, detailed here:
> https://lore.kernel.org/linux-next/20250317213953.01ca90e9@canb.auug.org.=
au/
> sfr's resolution looks correct.

There was also

https://lore.kernel.org/linux-next/20250213151927.1674562e@canb.auug.org.au/

--=20
Cheers,
Stephen Rothwell

--Sig_/veluDy7n/6Q5eiqrUmaphew
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfYl6oACgkQAVBC80lX
0GxJyQf/QCWQeZxFohQZc00vwUBme6P9fYQo2rzu0PfrXqyIccYR7zzT1ZHDzES6
BwHOuz6m0ssr8FAYORcvTHTa8QpzCImzWhpaNyWjeWy4bhy71sY/UHbwu9ly2wpn
t1D/IbYiQbdvleeESWubcgplsJX0NDKbpbeGTw9CcZbi1NXIZHoaQYrw0DpTCx/h
zhGHNfBsjxYge/XBSyoXkQg/uj7QpR97Q20B5fIV7gEHHoKeg2VmdP1MgLT26o1m
L4XpvLPKo5hjqcauVf6B4oh2Vmx8NtUEjpWbe5+kQBPFFTl4t7wMWJjyuWVUFxO+
Sp+KNCHnaPsZ1W+qF+KlN4cv58atYw==
=2dE2
-----END PGP SIGNATURE-----

--Sig_/veluDy7n/6Q5eiqrUmaphew--

