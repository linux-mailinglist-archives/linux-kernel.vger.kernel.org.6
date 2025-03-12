Return-Path: <linux-kernel+bounces-557851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D52A5DE99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D5D172073
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B919924CED6;
	Wed, 12 Mar 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW13RbkE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD723A996;
	Wed, 12 Mar 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741788297; cv=none; b=F0sQlbMIxOG20rCadR3BCeg1Yc6vgM66QNMy9oEjXPNCqw6BXsPGNXw/GB3YAkw2LRGfvCGXWr4TpBG2EPJ2CrQaRXTJrBre83Mmn6tzi3h1oWufj8d2aTnjD7UODHSrql5HtcPCP7wsyFZkdsMzGiUoyO61K6sKjm2VceVhbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741788297; c=relaxed/simple;
	bh=LupScz4CaJ9kGRzq8mkFgRBPCXt1vQNREcsiJZUoVuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0X7LCv23FyiCaor4+raU5MnkFSC5w+dOtvLdhO7/FoTt/+m0k5gogVu1iKmJv9YNE6JHkug1Zfm5ThwT2PsP1OMguwcNujvRgsT6YxjKT9ZkYDbZdU1AUypNl5NxPkX09w8oY1+jmTb28KXTdiAd/wvhsya+sqkQrxRKE2dEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW13RbkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B798C4CEDD;
	Wed, 12 Mar 2025 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741788296;
	bh=LupScz4CaJ9kGRzq8mkFgRBPCXt1vQNREcsiJZUoVuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mW13RbkElYKwMFLrD6fuz0i53FhQZBKWjleOARIpRFHLwGj1wc2NOPNc/ewieoxAv
	 V4aGQH6IyzKxHr8x/1sJNF0oU2AfXLWZpEnYTkzkqPqPw6gMXHuhRVXpO87/bvMwap
	 5+P9TEpSpdBOy3+62A7LN4f1CHTme1/6r5VwtRotQRlPXuiWfdBOfy7A1vgb3F97IQ
	 g8fHn0fLPAMPXqI6T2xbFr6o0dyfRvtnYevIp48bQ+emsAi6fAKVPAJrcqoncWQS9O
	 RnK7zkWVbo5vw4R9BwJIZqItNs7Lq+twvnYSAVd3aDra12b6GL/wiGMZUoVgf5c1Ln
	 Tv1ELCr+4tXJQ==
Date: Wed, 12 Mar 2025 14:04:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Weidong Wang <wangweidong.a@awinic.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	anish kumar <yesanishhere@gmail.com>,
	Ben Yi <yijiangtao@awinic.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Igor Prusov <ivprusov@salutedevices.com>,
	Jack Yu <jack.yu@realtek.com>, Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH V3 2/2] ASoC: codecs: Add aw88166 amplifier driver
Message-ID: <cb3df868-1131-4bf8-a976-66d376a87c88@sirena.org.uk>
References: <20250312120100.9730-3-wangweidong.a@awinic.com>
 <85859be0-95f7-48f2-bc51-488531529075@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/sb7EUmXh8ErV6ui"
Content-Disposition: inline
In-Reply-To: <85859be0-95f7-48f2-bc51-488531529075@web.de>
X-Cookie: You will outgrow your usefulness.


--/sb7EUmXh8ErV6ui
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 03:00:36PM +0100, Markus Elfring wrote:
> =E2=80=A6
> > The driver is for amplifiers aw88166 of Awinic Technology
> =E2=80=A6
>=20
> You may occasionally put more than 57 characters into text lines
> of such a change description.

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--/sb7EUmXh8ErV6ui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfRlIAACgkQJNaLcl1U
h9A8SAf/WseTvtO540IJYcvZPWjBX+2pMESToqUJmaj5zObc4R4Gbm4IFIVuiTOv
sV7v/9cuTNHn6rJ8Zd+dlWiCwCTC9imk4A3NdZFWhZRg8M8aaMmBm+RYEntnh0yt
Sq8Odm8N8w/MGI41/JEPPkOIJObPPVVJ4mXWvLZqxyp7hvkWJizsNac37b+LAWHQ
q/URQb8tgQCWd9g9xo0ghhNPDHKDhCu+YMTZuLfty6etjunhBGj3rGeZoSc01INM
BxcvFShEprcHPQ7FII1x8teoETdFNBOfZGkPA9L/y4LDKbFbAar0NclRCifh5W8l
0XsrR1SMjXBhq0NUezY+9dXsLY1z1w==
=eGPI
-----END PGP SIGNATURE-----

--/sb7EUmXh8ErV6ui--

