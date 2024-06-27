Return-Path: <linux-kernel+bounces-232621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E6491ABF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BC9282BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67419922C;
	Thu, 27 Jun 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+Uut/Wt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D82198E69;
	Thu, 27 Jun 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503709; cv=none; b=rvm61Q9KdVzwf5hmo4+3Kjub6taJONwlEbm5kZ0cSqcnnIdcZRF89pTyOABMVnbJZKe+nGJgHKFTb8QexY6TxuqDn0bGido6pN7FvVnG2AByR5A8ajQ9SIMaawdrP8olK56BiBDf2z0cD1elq0AZMpniNFUnBKRAewipBawIdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503709; c=relaxed/simple;
	bh=9pMDF+LsTD/iBTbXNEpVt3s5aczAsdOLMMbKgkXR3BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyF1wYEkCxnQus16w8JWEmKBm9ljFDF3Lz+RFWTJVG4/Snfi7UfZOyjgWDIs5hEw8/gC0kMLCJiyGokfvAlT62CXfTpEpUYTBnEDT/MG5r9REtY+3UX4Y1z5cVUPUyG/NyAFdtaSHNm22NlkVHAOsC07hFImtz5CMrtKSeLwDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+Uut/Wt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25E5C2BBFC;
	Thu, 27 Jun 2024 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503709;
	bh=9pMDF+LsTD/iBTbXNEpVt3s5aczAsdOLMMbKgkXR3BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+Uut/Wt9ADdwIp7mwKF5gVeKXfcgyrdlzltjciB4aCsgjQYT4XjH95VEGKypJhPJ
	 CRhnXj58LqLZCHFmnqKqHHEr0kxuflHifqjzgziQ72TE2vtjtJdgrOXlxPgJ73Q961
	 XDuSekCpy1f+hoR2vwBK3hI+F/fJIc4+ccbBinorYMO4DQF9InBnJWcxIc62Y5hItR
	 p8TALs/nL+wqdXLLzNyd8yleq1fXwUqabmjVqEFrbGvjVZ6nwFP8Dt7ieZOhd1Pqoe
	 JZsgxtErgHl92YWYNGxBdcDEtl5d2NDn2EOJc+OCtSrh8phR256bsdFsSuYFl8VSVV
	 WYbfj0m4w0Qsw==
Date: Thu, 27 Jun 2024 16:55:03 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yassine Oudjana <yassine.oudjana@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add MediaTek MT6735 clock and
 reset bindings
Message-ID: <20240627-deranged-yard-c84283135fbc@spud>
References: <20240626202406.846961-1-y.oudjana@protonmail.com>
 <20240626202406.846961-2-y.oudjana@protonmail.com>
 <96b436c1-50c3-4091-9577-c00187518779@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8CP9nh8xoEAPoXZZ"
Content-Disposition: inline
In-Reply-To: <96b436c1-50c3-4091-9577-c00187518779@collabora.com>


--8CP9nh8xoEAPoXZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 10:37:03AM +0200, AngeloGioacchino Del Regno wrote:
> Il 26/06/24 22:24, Yassine Oudjana ha scritto:
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> >=20
> > Add DT bindings for for the main clock and reset controllers of MT6735
> > (apmixedsys, topckgen, infracfg and pericfg).
> >=20
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> This commit needs just one small nit to be fixed before being ready to be=
 picked,
> check below...

You say "one small nit" and follow it with "you *shall*", dunno if
that's really a nit! With the namings fixed up

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--8CP9nh8xoEAPoXZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2LVwAKCRB4tDGHoIJi
0nEKAP9yR5y++DNT8wYwjg3zQzQhwqljNZNTjvB5Hdghil7ztQEAlMDvABPPZ4jg
vkp0P5ZlpPE0zRVgChCAysGnRoyg+gU=
=Agy2
-----END PGP SIGNATURE-----

--8CP9nh8xoEAPoXZZ--

