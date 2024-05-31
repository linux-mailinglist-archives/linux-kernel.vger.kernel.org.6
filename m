Return-Path: <linux-kernel+bounces-197108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAC08D664A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAABC1C23B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C544115884F;
	Fri, 31 May 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNn7ecS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62232C8C;
	Fri, 31 May 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171597; cv=none; b=s0l7n/q935QjI9Pu5Fv03+247kMsIaQD14f+gKMB16opIFZFkhIw3XESNJDDWHCR54RXbMB5Kq28yjyqTudRLWSCDwJAB97JDZUYno8PvoP0c0ynr/Yd41GRkID54mmDYaI3m2cj0lWh1TgNtNHJGeFnfieyDeTywfaqgMDFB/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171597; c=relaxed/simple;
	bh=xEdqlVv+yc6xxPC8F436pV7MA4qGjyS+19cc5fL/qdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP40/Gp94eTPs433eKhW9aPDIQybEPTj1en8F4PrXoRNda2yvOkGbGtq07K0RejYS0Y4DrETw/xora7HnzXxC3NjvgSZyRASBo6txzn9poKn2/DOFR9l+oAsIwRLU/y+L3+QnCYrgPnoVztkn9ecqlGyG2M0ZYhvj1IXvLEmHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNn7ecS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60699C116B1;
	Fri, 31 May 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717171596;
	bh=xEdqlVv+yc6xxPC8F436pV7MA4qGjyS+19cc5fL/qdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNn7ecS+B1fnRsmy8+fl1HimszXdSyd42J3hvvDH6VHJHwaci4o+Ez3/vR/y4flHT
	 8aUVVrsXUEvmDdPEU3VsuOQAI6pib0urxj+kBakXS48rdyvD121L3v4+MlurlMs8q/
	 wkWU6mJcQCzyHSjOteiZcxQrXIAZU/nkb4DxRUGwSq0hBuUUZH37mkrkgT7NKDkGT9
	 AfgSO6wzjvces+aADq3LHoZdBoVTd/yqSQI2pvLq2lHLyb2BuiFxO2Gvq/I10XY++m
	 JzSw1s/zlo+7ZCXH99HZfZkwnpPe7283pyOHoxgiKzxImKdYesyl0n9HteStQ6EIyV
	 xjGVLgjyF8uXw==
Date: Fri, 31 May 2024 17:06:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	shengjiu wang <shengjiu.wang@gmail.com>,
	Xiubo Lee <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound <linux-sound@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	alsa-devel <alsa-devel@alsa-project.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCHv4 9/9] ASoC: dt-bindings: fsl-asoc-card: add compatible
 for generic codec
Message-ID: <47a7a618-31d5-4dfc-9b6b-9426c6409e80@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com>
 <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk>
 <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com>
 <500db9de-6113-4e73-ba92-6e52ea292b32@sirena.org.uk>
 <1598202415.701258.1717159684103.JavaMail.zimbra@savoirfairelinux.com>
 <291daed8-a2e1-44d4-9a71-5bca2c585720@sirena.org.uk>
 <1220272166.706254.1717166894551.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yZnX6EMpaBNVB9zA"
Content-Disposition: inline
In-Reply-To: <1220272166.706254.1717166894551.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Serving suggestion.


--yZnX6EMpaBNVB9zA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 10:48:14AM -0400, Elinor Montmasson wrote:
> From: "Mark Brown" <broonie@kernel.org>

> > Why not just use the existing compatible - why would someone not want to
> > be able to use the ASRC if it's available in their system?

> That's true but it will be a problem if both `fsl-asoc-card.c` and
> `imx-spdif.c` drivers have the same compatible, and they don't
> have the same DT properties.

So merge the two then?

--yZnX6EMpaBNVB9zA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZ9YUACgkQJNaLcl1U
h9Ah0wf9F6py9uWrUIg1Rnm8ihwTDC9bWMpewQrTH27b7Ps5H2TxzLO6KV2GCTHH
bAcv+oyDym09iXKcPq3vvTrenJ0iPIaZWSOOwYS38JtGL5dAMnv07C3R6iWJJd98
z94n+vvDb3EL3UBU2+atXg0gUN5e4ekRdLRf7MmkjlGRszzVTuUafLdHUue4uPRw
gKDNcu2v2gC2e3OaZnA5jQh5ypP74fLrnWxyktzZg8acu482DkDBA7h13lSFCF7H
sZb+MsvHM7euPdKQ9nwfFk7bVErS0yb3PEPvNrd0ZJNvEE2aClUiFgNlKfNUY1hu
PvxfhbZEbZGiNyV8WXYwqtqGyzHB9w==
=o/G2
-----END PGP SIGNATURE-----

--yZnX6EMpaBNVB9zA--

