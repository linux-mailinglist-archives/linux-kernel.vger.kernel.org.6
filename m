Return-Path: <linux-kernel+bounces-174718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D778C1399
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994A61F21CD9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CA210A0D;
	Thu,  9 May 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNltURwB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B94DDBE;
	Thu,  9 May 2024 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715274878; cv=none; b=ehiqA8xysjaRKQ/fgF+ZggYQrwwSjkkMR4FJXEB9CMbkOEiQBnw6e1xG2B0RUo/X/w73IYbumXDdK+bM5O1ZaZIdXRnOGpy2ZyLMTmWKyT4fXTYvIdcYYYU2e2pU1j3ii6ETGKER0hNGJiOdhQyKdqP2WyZmuDY3/06kj+bt6As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715274878; c=relaxed/simple;
	bh=YwUKTYOpoxA/NOjHV7A/q7cg5e41+QOvCr4wGh3um4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXEor1R62bhk6ZZ8f5fRRYZO7t2n1g2zvFHZYYKK7xlLw0FI3APf/pcbgVKMTOqKK/zd9fYSOrGGsiIgkVZBVUEu1T4/mkAVBxhwvEB0VW3q+lr46beQD9b7he2roco/G8FaCOhbLYNph6HyTrzwmP3yFFPvp5oXN2zzFQKK6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNltURwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D799FC116B1;
	Thu,  9 May 2024 17:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715274878;
	bh=YwUKTYOpoxA/NOjHV7A/q7cg5e41+QOvCr4wGh3um4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNltURwBHZ0ugcWbLrUYJc6RkDUcNQgiYSfZKjEwL9+mHhuhW146bkl+HHiyqOY7D
	 wNNuItMLZg9XcI1JEb6/M6vYSge5p3d/Jqj/OmYtbmVYnvKDIu/qETs5sRmCps6IOQ
	 4LZSSh8xcEqDzkYGMQlizUe3dBHJGeJ27fyMc2GPvTmQUB2fR1FDljGOCifTUgm44z
	 tODVfJsI9WuQ5oCQ1S/mdwWcfvfMNNaHEiYnNaps8KLZaGtfuR9Xjg2wUSON1ihOC1
	 qDjHDw8Jt0BWhP/UqDK3LVzv0+Cy99DGUte0fmFAja8ZXPpS+oNlfndpyWeqf3uBUo
	 7ppc6G/TeWG3A==
Date: Thu, 9 May 2024 18:14:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shengjiu.wang@gmail.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: fsl,xcvr: Add two PLL clock
 sources
Message-ID: <20240509-repurpose-dumping-156b57c25960@spud>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
 <1715223460-32662-3-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9OB7iJL8uyGYmSbm"
Content-Disposition: inline
In-Reply-To: <1715223460-32662-3-git-send-email-shengjiu.wang@nxp.com>


--9OB7iJL8uyGYmSbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 10:57:38AM +0800, Shengjiu Wang wrote:
> Add two PLL clock sources, they are the parent clocks of the root clock
> one is for 8kHz series rates, named as 'pll8k', another one is for
> 11kHz series rates, named as 'pll11k'. They are optional clocks,
> if there are such clocks, then the driver can switch between them to
> support more accurate sample rates.
>=20
> As 'pll8k' and 'pll11k' are optional, then add 'minItems: 4' for
> clocks and clock-names properties.

Despite the detail given here in the commit message, the series this is
appearing in and one of the driver patches makes me a bit "suspicious"
of this patch. Are these newly added clocks available on all devices, or
just on the imx95, or?

Thanks,
Conor.

>=20
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,xcvr.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml b/Docu=
mentation/devicetree/bindings/sound/fsl,xcvr.yaml
> index 1c74a32def09..c4660faed404 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> @@ -50,6 +50,9 @@ properties:
>        - description: PHY clock
>        - description: SPBA clock
>        - description: PLL clock
> +      - description: PLL clock source for 8kHz series
> +      - description: PLL clock source for 11kHz series
> +    minItems: 4
> =20
>    clock-names:
>      items:
> @@ -57,6 +60,9 @@ properties:
>        - const: phy
>        - const: spba
>        - const: pll_ipg
> +      - const: pll8k
> +      - const: pll11k
> +    minItems: 4
> =20
>    dmas:
>      items:
> --=20
> 2.34.1
>=20

--9OB7iJL8uyGYmSbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZj0EeAAKCRB4tDGHoIJi
0kPzAP43Zn5AesCX1kKOSIjtrW5Vpt8hIHrIlOUZhE9kMqS8CgD+MljoXShCv6Tw
G/iLAeB3RppsSsV+7vuOr03Tr0FXKAw=
=oPv2
-----END PGP SIGNATURE-----

--9OB7iJL8uyGYmSbm--

