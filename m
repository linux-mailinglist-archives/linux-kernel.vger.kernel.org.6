Return-Path: <linux-kernel+bounces-543471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D672EA4D608
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB6C7A96FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745561FA165;
	Tue,  4 Mar 2025 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB9WrLFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED91F5829
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076306; cv=none; b=kPT4OG3OFIo+Y8+Cy7SzUIZ7xbDrf+lyjb3zA52YHW5KOZrCfoxjeJsu0fgnWKH4NDk5aI+K8a0xa4gtRMBYDpJY29Q0vzwMCVn3Kdq6wwvdi0dipArVj3zmVoe2kjBRRgrm/RRx0dXM30CX+5Ea4PYmYkdL+0d7xJOZQDpNgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076306; c=relaxed/simple;
	bh=K+EQRdXLdswE5q4qdxOmVemAWUmg9DNaKbmghLm+Syw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5kO7cqmrs5OpzGbwaUNSRwu/10028MHdiBaM6feiw+GmVwPQrLTN/MK6SZkKVFgE5Gm0N3TXpHueemwBOW9TFrqgjasI0tzU4C4vMGonWR5c7e4twX4iuK/KnlHMIHdGwrh4QnAZuZ1DyTKQwCCYw1x1jvqzSSyOoxGLS90yWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB9WrLFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DF5C4CEE5;
	Tue,  4 Mar 2025 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076306;
	bh=K+EQRdXLdswE5q4qdxOmVemAWUmg9DNaKbmghLm+Syw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rB9WrLFkQHDOWK9Ngi9JWbm/75eJ4vcchC1p5i4LSobT3xc0fwVkyJSs8aMzsmB87
	 a6ht+z5nFiSmLZbTEVphEZAIYgY1w0QZp+Qc0UR/4FYRDgVoo3C/8by3nlA6hJrDse
	 bCb3HjTpv5UvfoRVf7FjaqCFrqOfH/5TcA2WOee1u3iquYQRFuaZ8dAPRBim1NG90x
	 V1OuOHwHmFgq1NDJcnC6jFALtFH+EiqnOJVqRo1H7YB6uTFxGmGZTNTqjupOgRtxzj
	 SQVh3VTuajtEE4VOo4hgf1+pABdhaSmalOztKYwuyJ4Nlq2CBjoj6UZ51civohdh12
	 jBFC4tbyor9Fw==
Date: Tue, 4 Mar 2025 09:18:23 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 08/12] phy: rockchip: samsung-hdptx: Provide config
 params validation support
Message-ID: <20250304-romantic-truthful-sambar-deaab1@houat>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-8-8657847c13f7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="rn7v6jqgd3bpl5dn"
Content-Disposition: inline
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-8-8657847c13f7@collabora.com>


--rn7v6jqgd3bpl5dn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 08/12] phy: rockchip: samsung-hdptx: Provide config
 params validation support
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 03:44:07AM +0200, Cristian Ciocaltea wrote:
> Implement the phy_ops.validate() callback to allow checking the PHY
> configuration parameters without actually applying them.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 23 +++++++++++++++++=
++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/=
phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 7e1d1c10758249aa5bbddbdaae0108bba04f30df..47db1395051f5d90019787169=
4bab90ca4d6e38e 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -1482,6 +1482,17 @@ static int rk_hdptx_phy_verify_hdmi_config(struct =
rk_hdptx_phy *hdptx,
>  	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
>  		return -EINVAL;
> =20
> +	u32 bit_rate =3D hdmi->tmds_char_rate / 100;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
> +		if (bit_rate =3D=3D ropll_tmds_cfg[i].bit_rate)
> +			break;
> +
> +	if (i =3D=3D ARRAY_SIZE(ropll_tmds_cfg) &&
> +	    !rk_hdptx_phy_clk_pll_calc(bit_rate, NULL))
> +		return -EINVAL;

What are you calling bit_rate here? If anything, I'd expect the bit_rate
to be a multiple of the char rate, not a divisor.

Maxime

--rn7v6jqgd3bpl5dn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8a3TwAKCRAnX84Zoj2+
dvpGAX9bDdjDCQlX5ExGLNaf6qkQldDC7lWTbvEti8PUmg+VDUvIdSrkZpoAQS2+
3dO/nzUBgNk0Ta+qCJav/lhbrS3jWgRSx4xNWdbC5Z0LX4HAFh3UxYHwRpM7ZzOI
Pe8MOnuW4w==
=6k8M
-----END PGP SIGNATURE-----

--rn7v6jqgd3bpl5dn--

