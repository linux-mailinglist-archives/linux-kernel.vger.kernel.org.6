Return-Path: <linux-kernel+bounces-406087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9D9C5ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6611F229A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126B51FF03D;
	Tue, 12 Nov 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkQhs0Tn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47E1FC7F6;
	Tue, 12 Nov 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422805; cv=none; b=R04dUG8QuVzGC4Egq4FzmdHgWFxNl7jSQbYKmTBnbpwJ8oN3g136cC1UG4kzdIFOf3Z/nrxYuBcMwiFb+8LoR0tdAHu7c0MW9u/muz5w/o/2kYpLRKhSK0GYFdJdtlENoSjq/IsyLq7w3pwubft3E9nC8vDIF/kDwhVYNkzz8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422805; c=relaxed/simple;
	bh=Rni0sSv6wAqcLGvXDH0uudpz1zFl/4EOuSqc/zrd8g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlMQ7mEES3okQh9WMHz40fOhOy4n3cS6SNS1H1dLrxjp58esrPgxymkMjyfX97BLUQo+Rut5qkiIUqCwtUdi+5CaKj+ZDFv/tWB9tKJNoDo3Ap37+HTiY3UC3PRZS1/b9wR6vvKEow6Gm2iUHSLPgng2dNeeKyuI9WeKlm3N91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkQhs0Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958B7C4CECD;
	Tue, 12 Nov 2024 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422805;
	bh=Rni0sSv6wAqcLGvXDH0uudpz1zFl/4EOuSqc/zrd8g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkQhs0TnTTOolsfq3/0og5/0zmimIk/Jk1Z6/cPO32boExnuVOvLZ0mzpHnDWlnqa
	 CcrBOkb9e/cymwiAhurr+P/xWmMP8La9c+QU8qInB9PFafH9phnW/gGiu31E7YOtve
	 ugLass7ogFo5NS86Jjvc98oxnp8AHDVkep5SqGKPKSNpVDxrLbSDY2z3G7TGr+gWNh
	 mLOCKsU5oDTE9nxAbh2b7sPjWJ5a4+rVaQj9gsTiyiy49OcxBOHq/n5oew2lGEJhMC
	 dL6a6IYL4SxQnu/47DhbU2sHwSqYB1fOfwXxVOTabWf9o+5qt4VrhqUBUPEwexzXFJ
	 47MtVHClMSmyQ==
Date: Tue, 12 Nov 2024 14:46:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Marek =?utf-8?B?TWHFm2xhbmth?= <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Support Opensource <support.opensource@diasemi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219-aad: Fix detection of plugged jack after
 resume
Message-ID: <ZzNqUrlCjvusuDbn@finisterre.sirena.org.uk>
References: <20241112074048.1762371-1-mmaslanka@google.com>
 <ZzNVH65o0ue6jn6a@finisterre.sirena.org.uk>
 <CAGcaFA3SdBVtOiPJQG82YwBX01s5_mJszeM4LNSc5Pn74S2Cvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F2z0SX+Imc/Vbvmk"
Content-Disposition: inline
In-Reply-To: <CAGcaFA3SdBVtOiPJQG82YwBX01s5_mJszeM4LNSc5Pn74S2Cvw@mail.gmail.com>
X-Cookie: Editing is a rewording activity.


--F2z0SX+Imc/Vbvmk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 03:11:07PM +0100, Marek Ma=C5=9Blanka wrote:
> On Tue, Nov 12, 2024 at 2:16=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > This path is also (AFAICT only?) called when registering the jack by
> > da7219_set_jack(), I'm not immediately seeing the path for resume.  This
> > suggests that what's going on here is an issue with the machine driver
> > unregistering the jack over suspend?

> In my case the da7219_set_jack() is directly called from avs_card_resume_=
post()
> (sound/soc/intel/avs/boards/da7219.c) so that could be a problem too.

Right, that's the machine driver unregistering the jack over suspend
thing that I mentioned.  If there's some problem with the jack detection
being left enabled over suspend then that might need to be addressed in
the CODEC driver, but probably the machine driver shouldn't be doing
what it is. =20

--F2z0SX+Imc/Vbvmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmczalEACgkQJNaLcl1U
h9BjUQf6A1nLAwGKbuKH8YUNY+bs9sPFOJOKImKcC7FQs7S56A4Rw2uAFUy/1Oql
JjhgcrkrJUq2svHOyNfSKWD9sI1UUptzSibQIYERXb4fnZ6jK4qpZ+6vI4Y1ppzS
ukaZBdcrcRaOQIobYIj3/eLTja2pwoC8J4FlZble+cWJYzAPQF1iWRpA8DBtWdlC
03oI9HWZWMWkpDgbxXrGC2kXkIsL7OYsshjmAfx2vBSE8IILYmnQmjmg1L+o0X0h
TKt8CbDvDlGSUJcaB0qGxN77q4VOSlFGEaDjmc7UkFYFifVzXkmRF02M31W0cBQQ
OeoFYgxU2Dn4MEAfD3MeKFGCj8T/BQ==
=n3fy
-----END PGP SIGNATURE-----

--F2z0SX+Imc/Vbvmk--

