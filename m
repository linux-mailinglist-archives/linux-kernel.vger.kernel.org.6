Return-Path: <linux-kernel+bounces-196863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060D08D62AB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9780A1F27AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB117622D;
	Fri, 31 May 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/p5/BYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F1158DB3;
	Fri, 31 May 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161260; cv=none; b=qdbGDZIPbNuoeCM/r/07uF9SsvUACX5VnklyhKEk/QoDq+FbwM5LVeBdzW3JUpv9zdSYBCIAq9BDnoDTl6GL4Mym52c2iz0F9l9i2eVF6PJBPt33caxidd0noLFYlAQY9lZA5F4/6Oo3XRdFe7rfAchpT584cl30PLvHTPaxlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161260; c=relaxed/simple;
	bh=gbORHtwfINA/7XdxHmGEDfKRg0KInm4NPfWu2fzeZAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb9ldaMSIIwdL+4TBJwasViWDNIUfGLqsDjUsXlktatJ0pOGrpNy5VeX+I7Bf0OQF9sfwXfy9RQVgKRpJeuoK3ic1F9tJO72Lh5WhyesB37Htp+7Z7nqQV0r9oroNa8tVlO8YaxUkI0UrqjgnE1XkGUmAAxxI9WgUUwGMYsGCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/p5/BYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C100C4AF0B;
	Fri, 31 May 2024 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161259;
	bh=gbORHtwfINA/7XdxHmGEDfKRg0KInm4NPfWu2fzeZAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/p5/BYH+7SLVMMU5PV73oOe1faDyRKMjLR5ONU3OakdDGYY9jCufxQxC+5+R2R0l
	 u+UIe1VqdRF55y5E2DzojmYPOQLv97xTZ6akCM+kKof8vK4+q0zblr4F3moIc4M8Z1
	 hpyhVpLawfs1r9rtV3LP6cmzqBGTgciX7nTub2eopXQg8ZxMMH6T/mVWMTj1rAHWD9
	 WgpXwL/IX+7/8lUz20VvcKfGUKc8ZuiH0iYYKxxobrOGkIe6EkrbueKlazOR/Pp2Rt
	 hvN1d/fyOeFobUEZbOXT8gGTw09MrI1tdEAXc6ptHsERFuniGPiqhKvdWX89DfT7lA
	 P6jzA6VExq+4w==
Date: Fri, 31 May 2024 14:14:13 +0100
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
Message-ID: <291daed8-a2e1-44d4-9a71-5bca2c585720@sirena.org.uk>
References: <20240515135411.343333-1-elinor.montmasson@savoirfairelinux.com>
 <20240515135411.343333-10-elinor.montmasson@savoirfairelinux.com>
 <ce9a87c6-4a5c-4f0a-a8df-1fdce8c1f5df@sirena.org.uk>
 <599489232.349333.1715936741672.JavaMail.zimbra@savoirfairelinux.com>
 <500db9de-6113-4e73-ba92-6e52ea292b32@sirena.org.uk>
 <1598202415.701258.1717159684103.JavaMail.zimbra@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KygPM2XsMX13VSvX"
Content-Disposition: inline
In-Reply-To: <1598202415.701258.1717159684103.JavaMail.zimbra@savoirfairelinux.com>
X-Cookie: Serving suggestion.


--KygPM2XsMX13VSvX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 08:48:04AM -0400, Elinor Montmasson wrote:

> Then maybe it's not be a good idea to make this compatible generic
> for this contribution.
> The original intention is to bring support for the S/PDIF,
> so maybe the contribution should focus on this use case?
> In that case, would changing the compatible for "fsl,imx-audio-spdif-card"
> be acceptable?
> "fsl,imx-audio-spdif" is already used for the `imx-spdif.c`
> which does not use the ASRC.

Why not just use the existing compatible - why would someone not want to
be able to use the ASRC if it's available in their system?

--KygPM2XsMX13VSvX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZzSUACgkQJNaLcl1U
h9CI/gf/Xn2/xlVXYFjqqRcmEeA+Mmby4XlBih17KdiGdDQeHIPD9tnY3ub27oEm
Uz2RM669ae1CKI/GTYYiZ1bB97E80YvV7vH92KowbeYrNnMK/un2WfCc4nofGAMj
ETU4lvrazJEj8xLQMM5XT+9zGSrd24cyJIwATqPD3NwNFOgZ0TncrCx7f7j2Hswd
WojlP7VZdmX0Ru2XpvjmnVCmDbaxZ543qbRFSp4+rIrWKGTUHowxahzaDbhziSla
BmX1BjJK0AW0+WnOS/ZaCApM8hQHxq6s/aFreHlth67DHmUtfsQtdIBUnEJJbRn7
UvwuEy+mXzr6YIXOjhrobfvp1XF/HQ==
=dJiZ
-----END PGP SIGNATURE-----

--KygPM2XsMX13VSvX--

