Return-Path: <linux-kernel+bounces-422290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328289D9723
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA15283002
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E431D1F6B;
	Tue, 26 Nov 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6cIRI+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A51CEE88;
	Tue, 26 Nov 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732623508; cv=none; b=hLk2iQJvplot7O5oCaJOZAplT02ofAy8uG8DffauAxDGoUNVe3mkP4UeQNg61eZcRFARmvjg471iDmePrAGH8wPakOrA1fBeiPk98tVAWTgxOw99IrHYPzQjQFjwf+Jrg5u10RI8Po6EYhwio77KI4qeiHKf12Le46W+mIkxsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732623508; c=relaxed/simple;
	bh=E6+ESngCCGWCONAl/VNCJxoWIFWe7ya9c2lwaJJxp8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmWS5sZRcW0yau2z0yEy9umIp0lrng6i7wMWtW6+ScS0B/HXvtNhgwb85V6MFdLtgU4NIHSpyIZaey2hI8bWfywlGmRFwPmvtf8rDC5XOEdt4PCHqKwfUZDBxWN68PQKKQd53peY04W9LoNJM1x5YmBIUt4sweUOn904pwNt7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6cIRI+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766B1C4CECF;
	Tue, 26 Nov 2024 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732623505;
	bh=E6+ESngCCGWCONAl/VNCJxoWIFWe7ya9c2lwaJJxp8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6cIRI+BsrSkzWhedXjh2mFUQkZcKA7/hrur+g+on/yQaTqhEggPBms2PUyy08zxK
	 H1NIr8ZGuZmNMYC6cnUvARILOAtPd7auWWQk1Zcos9M/IqKRmKv9sVZ+BaC13ANcsZ
	 C3Z3oRdg6DKjZHhie57JtcIlffZ7IKs0BG+K7OvlLfB1loubF0Jpo6ECng5XXVo4iV
	 4zNGlhxRhEl+B2jjvtTxLL3/Bgbv3qyYKE0SOhf57wHEe1qLHJTZBlfpzQ4S6AdJIx
	 Ecyl7oVijucnuGEogACVWETCEUyYcLSki4ZDDd/fcs7sWKA01b9ba38xxEQZivE+FF
	 7Pd1mjxRS5jpQ==
Date: Tue, 26 Nov 2024 12:18:20 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mesih Kilinc <mesihkilinc@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 3/5] ASoC: sun4i-codec: Add support for Allwinner
 suniv F1C100s
Message-ID: <d0ecce33-25e2-4711-8311-7788c77b7d2d@sirena.org.uk>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
 <20241123123900.2656837-4-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jW1jmUiXAYnnAPXC"
Content-Disposition: inline
In-Reply-To: <20241123123900.2656837-4-csokas.bence@prolan.hu>
X-Cookie: Have a taco.


--jW1jmUiXAYnnAPXC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 01:39:02PM +0100, Cs=F3k=E1s, Bence wrote:

> Signed-off-by: Cs=F3k=E1s, Bence <csokas.bence@prolan.hu>

When you write your signoffs like this with the , but no "" (like in
your From:) it confuses software and causes everything after the , to
get deleted.  Probably just including the quotes is the best option to
match the email header.

--jW1jmUiXAYnnAPXC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdFvIsACgkQJNaLcl1U
h9BFcwf+Pao3veWU7hgKuh2HXg/Tp8C3fBdnErq8VNlcf6LqbMaDYP4mO1gLXkbd
iDNeeZWWJ2gsuUPR9NlTuwdw81I7voAZo+YqHQW3MtpPGBTu8/ErMCtwjqSSzzEf
dT8uslNOWI50ckudS9e8rpXIqfH2fJyOTO0FRLv5A4M1/TWCfdpOoxtwANZ/CBhs
ULa4QnnmEHTrNNd3t8+4RblG82YqE554iSJKQHB9+CNklf7I+DZUbSkt4arIUvOs
nDXNCw3SrS9SDY+e3HuQsqkVjwsFDxFJez2Z03EcNvq6HaowwH/sZt7So62feVfO
jv72jcflDLRnbOfObnV48Qg6Xn0+QQ==
=/q8J
-----END PGP SIGNATURE-----

--jW1jmUiXAYnnAPXC--

