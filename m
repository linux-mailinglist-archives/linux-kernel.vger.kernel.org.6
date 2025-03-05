Return-Path: <linux-kernel+bounces-547362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3790AA50646
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE37171305
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B331C7011;
	Wed,  5 Mar 2025 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri8Ar6n5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625C2567D;
	Wed,  5 Mar 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195416; cv=none; b=Ng53FnzJibp2xRe9FRNtRR/l3cuRVXq+E6rrFv2rXZEbA7TS9ktKEtlfsyOu+1Nr7Utl4vUCCmB6JSILYwGsmoU8h+DTxXcraUku5L06RDfBKr+br7uRHx/h5qWBmbdg3anhYw4/kbfGNjm0/2vOGqLigtKIkrXoFKaahGekzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195416; c=relaxed/simple;
	bh=Uo3mWNGatWCN9U9NdsHgYs4FZPyOo5lVBCESSB/+w6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA/v5pmUTurT/dGLDe6WmV6k9Xziy64u/zANrme7ig1CJCTVzF9coe7KYXmyvF8DmbmQJKOHOIvK2Ey8S6NCBKjMY6pJwg6bBDfzFVZfirTBLp/4ryfBL0pERCKKyUIQL7t45YiRdnTbAPtLkJ142Iw1+dXDRXN/SYfHyescP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri8Ar6n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72558C4CED1;
	Wed,  5 Mar 2025 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195415;
	bh=Uo3mWNGatWCN9U9NdsHgYs4FZPyOo5lVBCESSB/+w6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri8Ar6n5p2xBm9RoUR7lfLv/IX2/ebTBuDpaaCIcqGbViU7c/W9BiAWxLFXRF1t8I
	 WzrFyqkvMHHNSXk48gJh8mxR2cSBXtaaNZMoWhdG6c0irXIjWomD+jTcJJG9OptBY6
	 tM12CgTHcUHN/D1DrarJbIaOe9D9fUGJtZrT2eu0tFX6Re47o4ujUEYkCLIzfV+KI5
	 3whidGPBut1xFRiGsqHXl6vpPDo6cKVvGtgbRMlaobOuq8xHNncI9ySvGBFasbZGPN
	 ZZbFpugpS+3MAtNF5RekqT95D7Tee8/rh1FoJleciexP88k3zTO5MYFWV1mT0XkoJp
	 1Mrl17smqux+A==
Date: Wed, 5 Mar 2025 17:23:29 +0000
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Trevor Wu <trevor.wu@mediatek.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	kernel@collabora.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Zoran Zhan <zoran.zhan@mediatek.com>
Subject: Re: [PATCH v2 3/3] ASoC: mediatek: mt8188-mt6359: Add accdet headset
 jack detect support
Message-ID: <7661b71a-9d5a-46c4-9639-0fba1b118b52@sirena.org.uk>
References: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
 <20250304-mt8188-accdet-v2-3-27f496c4aede@collabora.com>
 <59d0d382-1d15-46c4-b9e4-b66c32c188d3@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A3lZokx9nkSuQ7Eg"
Content-Disposition: inline
In-Reply-To: <59d0d382-1d15-46c4-b9e4-b66c32c188d3@collabora.com>
X-Cookie: Everybody gets free BORSCHT!


--A3lZokx9nkSuQ7Eg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 06:18:41PM +0100, AngeloGioacchino Del Regno wrote:

> Get to that mt6359-accdet.h header and:

> #if IS_ENABLED(CONFIG_SND_SOC_MT6359_ACCDET)

> function signatures

> #else

> static .... { return -EINVAL; (or whatever else) }

> #endif
>=20

It should probably be return 0 for the registration/unregistration
functions so the caller doesn't fail if it checks the return code when
the accessory detection is configured out.

--A3lZokx9nkSuQ7Eg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfIiJAACgkQJNaLcl1U
h9CMZQf+Ifm+gO7vy+HK8RUWgpgzNwyEaaG9mU1+cZEDRedSC6PkwGHGr6nahS9G
34+jdkZ/QUiRaiC9wFejUo6yDAxGAmn0vp4U1En2P1lzrjK/aa0mNneVXmN/p7bJ
hAoLZr4RQ3iKCSqrWdpUVf/uLZ97LMNi7q7Gu13BbWJl0VYdfpcWyMcXWpZr62Is
F5CSNUwZkvpcy6wzcj5P6Y1PSlR8c5SmygJ1ohNt9ujhNWNSxNqQoKajIgI+3oWK
6Uw59dXmeWtFsCpcuB6/w2fKw+UdwYpnAbnwtGwlJivbRqa0vgt4Cxzzgflz0V4I
AU2ee5PAEVtbq/r4fJ5EtqWBRE5yLg==
=n+jb
-----END PGP SIGNATURE-----

--A3lZokx9nkSuQ7Eg--

