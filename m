Return-Path: <linux-kernel+bounces-404103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B89C3F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA2E1F22024
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD31AA78C;
	Mon, 11 Nov 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwjG9dy8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECF18A6C0;
	Mon, 11 Nov 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731330004; cv=none; b=fibg71tTn8d7X5zopEMqrzTXEAPufZxAZBqNH40lQjbyCG/Bxe9UV4B4z3Nqy+ehB+8A/wKu5zmb1mZrcQWRE7WWg6sJ72Dbvu5wwwaAoEUKAkWyB/Q3LfXzhpe0edM39h1Yes6sx0zR9o88p/1uGrMGcA+aHQFvPTVwBYkVHY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731330004; c=relaxed/simple;
	bh=cTfIcvaXtVOJ3RLpAfsIMnhBPDjlYHzkHn7hReN4Nxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DW+Od1xarJLw8NkZ7pzGl3X/0J0IS4GeHWxor27JiK0+vhpgfrpzezglGznMc+6Zjbxo3Ion7ojMJBMiherHGrZWixESEN4s1RSml3KlOL1498C1xDReFnJhgode7lbYdyPz2tWef7Bsoxszosw/fs3hBqxjkaioD9iW0W9YKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwjG9dy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4547AC4CECF;
	Mon, 11 Nov 2024 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731330003;
	bh=cTfIcvaXtVOJ3RLpAfsIMnhBPDjlYHzkHn7hReN4Nxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FwjG9dy8feOeUMgscat3wLAgttFcsxSX8CisOBSVWPZ76R/5Jw98YWorSR/QxRYqr
	 4kqy0OQo8ZzPhI8n0THBGE7X3UT/mXUCloYUhGKVheaVd159H+nOX1/liQBBX2TUpr
	 kW8Ci9ycOjRIGdksZRw8mOvO7/07rENEKv0Qxy+XQ764acvn1NZw45chbfIR1L8n6O
	 8vd+QG34B9RgmYpxE9iWhCFRKhD8+Y8VZquW1yqcRkARzQGAaOxYzs3rnEEymv0tpA
	 CNJAIaI17MkiOMFCPxqS3IE/rhjwt8cfAt7AO8yzzgRUm2xthPmwIM3lDONUkjvoJ0
	 OXEcAxemTtLmQ==
Date: Mon, 11 Nov 2024 12:59:52 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Tang Bin <tangbin@cmss.chinamobile.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8192-afe-pcm: Simplify probe() with
 local dev variable
Message-ID: <ZzH_yJWLJVfO3sux@finisterre.sirena.org.uk>
References: <20241025080026.2393-1-tangbin@cmss.chinamobile.com>
 <28f2bba7-40f0-4015-af84-d3c08c9a14c1@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3w1txq//RnEmfVad"
Content-Disposition: inline
In-Reply-To: <28f2bba7-40f0-4015-af84-d3c08c9a14c1@web.de>
X-Cookie: Editing is a rewording activity.


--3w1txq//RnEmfVad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 01:10:21PM +0100, Markus Elfring wrote:
> > Simplify the function mt8192_afe_pcm_dev_probe() by
> > using local 'dev' instead of '&pdev->dev'.
>=20
> You may occasionally put more than 51 characters into text lines
> for an improved change description.

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--3w1txq//RnEmfVad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcx/8QACgkQJNaLcl1U
h9Cppgf/V3FoC1TPeB/EU3FEu7W8G29WVYt95os1L7qazp9yLlFvUP4kmeYWblBW
woE1a/RmQ4zFeOaOve3EjrJnVtf8zs9xq7BP/QUc+DjwB1kTh8eHELeM8zFcE7bX
NwfMpeiZHWBLCwVsNugiDy87OQqgKYU1mIoc9SUi+SLmEcGiLsNgJuUuJvRGozQ+
URyh7lKaAsQCwQwzF7uXmzBCUhJ6yfKNzn9KkF3KpEAPNJadm+QJ970OnTHPPQNn
61g63h16VfeyXwgGVkLIyz/pOwegFLbUsIlE0xvq0rsq0roApY/BXNHfxqRoYM3r
EbmiWMr67Fez6QvJz48oYzdj1MS/Qg==
=p8XM
-----END PGP SIGNATURE-----

--3w1txq//RnEmfVad--

