Return-Path: <linux-kernel+bounces-239885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8159926667
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B89283335
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0936E1836EC;
	Wed,  3 Jul 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9xliZGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410117C9EE;
	Wed,  3 Jul 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025450; cv=none; b=LZPW0PRIehU6xMFjB+aedoOYRWGAcFCKT8FFbqaNm6hBMH31P4y6pQxa1v7fDmUIWsCj+8bDEW0rs2okOOdIxr6uNgU7Tjp+2IAV6BjdpiZ3M7oFEPlwTFg34PkS+ul/u2m5nYu6Ypq1oH+TR5YvApKzzsL1ma23+KDfk0cpfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025450; c=relaxed/simple;
	bh=D/MaZTHnLDeuOo/Iggcd3e4LByeXme4plxgenvbdE5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bx62Fkn1mDv9AqM28RMys5Ji9no6gCh9b1xV3dWjCHfmES/Wtbs9zoaR0DF7sGkC151rbKnEi9mOxnUTPlOVrN2h8neA/OfjmSqLtejfXW6MJM5XA6js6XaiTUrfxOZnBcPbzvco7XfGqCg8pZgw2ovtA64INUFRDOy849aNI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9xliZGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B36C2BD10;
	Wed,  3 Jul 2024 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025449;
	bh=D/MaZTHnLDeuOo/Iggcd3e4LByeXme4plxgenvbdE5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P9xliZGfnZOh1KHiKAGUQjCGSVRh7j6lDOinEAynp4N6ygspn7kzzXR8gGr+H07aL
	 nSC95r6adPBhM/CPm/6qczd7w/csGoVGLCRXSVZv+d5scF1DzO/xiQrxF0PoD0VZit
	 hvi14hvcNZTp81z/heeK4qAH/kxB+Ij7CrI2f3oqiDq0pZvGvLTs2VPkNq1mXvhjon
	 hdSf7MjPrx0DKGu8Xd8hxJRFjlTiNYUiMKnHH+ubtymuq1WjoP1YBIafqp28eqtrgB
	 iBjp88zDvsM+xf4jwvbTbm0/UhKXga/Ez1tvaH0fiifFnBGl+PHulFiTUqdhivuvln
	 io6j1gKuWyfdQ==
Date: Wed, 3 Jul 2024 17:50:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ASoC: amd: Adjust error handling in case of absent codec
 device
Message-ID: <2d37b9cb-f442-4925-a63f-e25dcfb388fe@sirena.org.uk>
References: <20240703164028.32806-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqkLKcxuY6/Fw1sD"
Content-Disposition: inline
In-Reply-To: <20240703164028.32806-1-amishin@t-argos.ru>
X-Cookie: There is a fly on your nose.


--tqkLKcxuY6/Fw1sD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 07:40:28PM +0300, Aleksandr Mishin wrote:
> acpi_get_first_physical_node() can return NULL in several cases (no such
> device, ACPI table error, reference count drop to 0, etc).
> Existing check just emit error message, but doesn't perform return.
>=20
> Adjust this error handling by adding error code return.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

I am not seeing any analysis here about the correctness of this new
error handling.

--tqkLKcxuY6/Fw1sD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaFgWMACgkQJNaLcl1U
h9B3/Qf/Y9sZdHWsOhEGVGLH+O1+YbyUWiBTeYWFnuMM9C9i4Cd9pmhW9AYhzm3w
E5GQaTAyD9vU49pEr3bohLZzqG5/jqstkf7K3o8jALyIvGlZA3p7mmG+84YkW+cD
kHW57a3qyT3ckdQ8LFkY1WLO43cLvfhRxBYUEV+JAvOtnKFt90G3+ZN1vL3EImqt
34QUTDURBOwRSpXGM6MMpNxhZc1ZEr35yv5UxvlvZPDBr6iYY5mL4blsyvBtH/LP
aPTrqoXA7Rs3llDz2pc2972rGyCVHlX+8rbesreBliOAlzXiZOhs+Zxz0zMmIJlO
LU0HkJDqdyZiK6gpdi+FLxxdbVPnBA==
=yCQ5
-----END PGP SIGNATURE-----

--tqkLKcxuY6/Fw1sD--

