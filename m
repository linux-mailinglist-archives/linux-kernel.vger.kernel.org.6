Return-Path: <linux-kernel+bounces-209635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3F9038B4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1691F272E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617601791FC;
	Tue, 11 Jun 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow67sxJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6214F109;
	Tue, 11 Jun 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101100; cv=none; b=qSjykhW6ulN5fkVFwMGRel8Jse4+hf5BFgYmGb35XuXJn4DoN+TJBA+zaOIuGHqcLkZzJF4uMhU4DVXBrNzuMaJ8v+MBx9hpgRQELlXT0itZ3Yf89ZaHeiEPCfiiS2BzaaNXfAtf1pDPsg23S5OlvrPyrQ5M5QPo1r4eiONNNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101100; c=relaxed/simple;
	bh=XtJLIL7jPMpbcm9Tef/+8eEhoO8iAr3puk5IcVpVt9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkli9VSWNmw3TuB4ZrPqewgAnLoS/OamGW43us1iFN3LCtyzwfJbkl9I5yCwmCsEXJX9yrABUj9K0QPDcxiDqhYnxEwM5BgPO5qsXCjytpgD2LVs378giqmI1lRHjw2h2NzEBod7IZKMyCmT9yf7ULtMqKT+nYxq0Bcrb1WOEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow67sxJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE600C2BD10;
	Tue, 11 Jun 2024 10:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718101100;
	bh=XtJLIL7jPMpbcm9Tef/+8eEhoO8iAr3puk5IcVpVt9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ow67sxJ5/f2z53fjdF8sbUz9aNzfy7r0V3x4F2IkNEA9FxfG2I6YOxddj0CrEWB8q
	 aIr8o7oPdXcMLmFf7l6LaYlnmWeD7C8MrGDLY4M0Aa/000N3VAX7c4KAXz792peW2C
	 TuFLr9Vz/5ZBT7Iy6mN1tACvSxp+hhJFU6utVjZKgeDupSOxaq0Bl5tNuHrloZjLKb
	 FnNuPnoHxQMLQusHz2HGgZWOmNyOYnczCtoJ6HNF4N8HBHLSHnwps1r9gBNle546Yl
	 NNfVvRQWx7JiUvJdTzoJxfSHONR/6RJGi1uNJWR+Ta79j37/+tzclYAUmNRaJXHVN5
	 N2+YF1B6acgjw==
Date: Tue, 11 Jun 2024 11:17:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alper Nebi Yasak <alpernebiyasak@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFT] ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol
 name collision
Message-ID: <ZmgkRWLmZpGnpv9A@finisterre.sirena.org.uk>
References: <20240531-da7219-v1-1-ac3343f3ae6a@chromium.org>
 <171762153256.557520.12011428649748199502.b4-ty@kernel.org>
 <CAHc4DNJ3q=a8Wts_q12=R34eMbMq+d4PSEFe7YR+DDs=C_Og9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkH1k6DCw9W/Nv6X"
Content-Disposition: inline
In-Reply-To: <CAHc4DNJ3q=a8Wts_q12=R34eMbMq+d4PSEFe7YR+DDs=C_Og9g@mail.gmail.com>
X-Cookie: Your love life will be... interesting.


--bkH1k6DCw9W/Nv6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2024 at 04:02:08PM +0800, Hsin-Te Yuan wrote:

> I accidentally added a Change-Id field in the commit message. Can you
> help remove it before sending it to Linus?

Sorry, there's other commits on top of it now - one commit ID won't do
any harm, it'll be fine.

--bkH1k6DCw9W/Nv6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoJEEACgkQJNaLcl1U
h9Ci4gf/d/71SbUXpDvPRJoSpeImEZWIPsiA8SA2T5BH5zAUcOop4zMzkVAS9auB
AU1R6pD56doyzyk70uaz9A2esxyo0UxEM806duF97+XI40l5cNBEVEYzKIzQNN2C
e8wgdlu0DhOG611zGRq9YKhd9b4E2DKMnXDvpnM6iL18J1w2sc8DxYFj0t8zWUwY
niVYdugY2ys8IyxX6mMEHVbp9m7OrtXjx7Jmzo62lWQUybJ/A6zKGoEzxclgLK5i
nKA3a2toztPt2a4jTNHL9KdVdkk1AZwc0/15MyR8gsRveGNlr9bEaSDtjhCZ3mDp
GNf8YUONs+MTlBtCtRyRrjXK/C8oPg==
=uH5n
-----END PGP SIGNATURE-----

--bkH1k6DCw9W/Nv6X--

