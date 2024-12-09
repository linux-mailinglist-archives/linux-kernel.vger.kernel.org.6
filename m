Return-Path: <linux-kernel+bounces-437615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8C19E95D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D84B281ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B022B5AF;
	Mon,  9 Dec 2024 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSVCwQV5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E0229B3B;
	Mon,  9 Dec 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749536; cv=none; b=rkW1pA3EgaWjAQaqBBMEU7a4Aauuzgp0+qIm/liQovbAMUQoCcccqHKNJW8P+ad01iGgcP4amy3ziS2XJPpPbXy/i6wYUaZnhMbK+DeOz2sueA3idJinJ/hBIQ8p+73Oa6DXwHRj/jsitAR6aiox8J6PXC9L0dcqa4bdD9vac4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749536; c=relaxed/simple;
	bh=yoleo6rS3JgthDKVyLuBTQzA1sydtqxgHZtQpaY8e2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh9Ms99nTed/2PifkpYEZPyLL/kj8+fTeqZuOAkEDwy0uVEPiE8cyNCAaAEb1+Kq5NSI8n3ZZOIn2B1lWTdo2fVgjiD3AfdlUfqPwwDLz1CHCnEWP/hqWTHGw7OE13GHoXYJKTBbMY0st2zESvBHC4m+bUJiiyP7Gg1orRYKaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSVCwQV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B5CC4CED1;
	Mon,  9 Dec 2024 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749536;
	bh=yoleo6rS3JgthDKVyLuBTQzA1sydtqxgHZtQpaY8e2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSVCwQV5moF4ysNMZUYYlPbx9Gde7+LPzlWi47CyHBd6jjpjn+OsisqdGbYdmMVae
	 l1JV4GJDA+8Uho/tUTdNP3kijLJejgxTOI0s7usI3TnHGJSsN2uJXP/ZMT/PB7d/S2
	 TpuMXSDlUDi2zobqMKjVX8GgrVEpLbdiOobLo2Z3zUCqr3eQp5gZjL1eY+P3wNpjYy
	 bW8CJfgo8sBL22yA19csLUtEKX+QO/iSXCIGDk5w2tegdkYdYPalMyo4VHLkUNL4Jy
	 27cPCM5Z9NFGGM0SdvYsxMJQBjm5asPLmWweU383iAgMkC5fmQXGZUDwjyYTpTI3hY
	 Yuwq+YzlhokZw==
Date: Mon, 9 Dec 2024 13:05:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Stephen Gordon <gordoste@iinet.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: audio-graph-card: Call of_node_put() on correct
 node
Message-ID: <17728d1f-3e0b-4fed-96c6-cd292e45c0e2@sirena.org.uk>
References: <20241207122257.165096-1-gordoste@iinet.net.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rDvExBjP9xjqpHKC"
Content-Disposition: inline
In-Reply-To: <20241207122257.165096-1-gordoste@iinet.net.au>
X-Cookie: Lensmen eat Jedi for breakfast.


--rDvExBjP9xjqpHKC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2024 at 11:22:56PM +1100, Stephen Gordon wrote:
> V2: Adjust commit message
>=20
> Signed-off-by: Stephen Gordon <gordoste@iinet.net.au>
> ---

Inter-version changelogs should come after --- so tools can handle them
automatically as covered in submitting-patches.rst.

--rDvExBjP9xjqpHKC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdW6xkACgkQJNaLcl1U
h9CsdAf9FeGGmGgMVAKXM415HGULMcglT0gs0yInyajGbo8cYmNgWbd64qj38Fr3
WM400F6UmQBUjtOEyHUc6Otu8Z1wNFUa6zJwm3cHFwH/UGCPiIg0pKDwZbxVafGo
pYyfuxyu2di5zdLv/m2DBGPDP8fs60Ps18YicPG3KsrX6d+f5z5KE3ZGnCwZoJyK
kYiHaVmoWKBhwh2xjF8dIZuDsJnMuPzTvrLFCyQo/JQK/RQcnyxJPMGhr65w7qYw
NcXDMURoh5BnazPZ+VUwX7NFYqaUIBsmyk+P5LWTPUSEx2cSnwVKovToAOB4ubRK
5k+OI9S0ewR+W0MqN81a4MmAbnJLCA==
=rA4p
-----END PGP SIGNATURE-----

--rDvExBjP9xjqpHKC--

