Return-Path: <linux-kernel+bounces-563833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803F4A64955
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C43ACB69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E162356BB;
	Mon, 17 Mar 2025 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKssg8TU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F2233727
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206594; cv=none; b=BXxK7shOZ8OTRLLMUTSNiGlOtZhOOhpOr4edJqAaEx+k6XupU4KZTOgHKKEyCfHSVBbuymSiKVVmBqNzh8RgEVCPthWWjMGHr9uF8Xon6s1JCvM7coV2hlQuwd55C43pwPUvNTa6/35gFsvYhPcp928ilINoD+CSK6ICIk1vnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206594; c=relaxed/simple;
	bh=sP4X9ex47Eoc3cg4rQs7gDQnP2lwOT6Ng96xEHp5bpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZpQEI8lvNYwvtkObQpzR9P/K0+MmNo1UTDTQrFq6RBN96XzjoCULwpoEPpyLbj8TWx1Bmtyx6W0xFsLJTe5kyqAy/8gUPwY+KzBOk0NPpaR+xqpP5OEhFhXWweDZYcYy7E9teZCfAsVXNlohD+L3Raz8VGvm74P9N1beS3t5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKssg8TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305E7C4CEE3;
	Mon, 17 Mar 2025 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742206594;
	bh=sP4X9ex47Eoc3cg4rQs7gDQnP2lwOT6Ng96xEHp5bpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKssg8TUZ5+m1VIovlpPgOH6cGDAjiCgJFKBg3GDqN0btvpR3dHJ6TyY+skOWvbtd
	 KnGPYnXyGykeNE29+ZWjQ09jMghib1rb/SVMTb9hMwzUR9LV1IKDzQvHyBd6JU5I/v
	 KO43YlLYEqMkP06G0M51sAHs/3wSuBZrb9oGAs0UkBZzS2+0ZUJ50//XqBD+Zoc9zF
	 cDuUfU9VrSuaoSGQCpl28iPpYEcsABMur2XKSq53tzn3GmdOH5a7MqaDZx5NueROex
	 AaOdj7CQypr0dewZ5r0T3o06v29t4MErGk4z48cjhGfP6XElp5Kf2LBPFPI6PF4F7Z
	 Zsc/MHyh70nYQ==
Received: by venus (Postfix, from userid 1000)
	id 00B9F18079B; Mon, 17 Mar 2025 11:16:31 +0100 (CET)
Date: Mon, 17 Mar 2025 11:16:31 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, cristian.ciocaltea@collabora.com, hjc@rock-chips.com, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] drm/rockchip: dw_hdmi_qp: Fix io init for
 dw_hdmi_qp_rockchip_resume
Message-ID: <p53hbl4vt7vy6srctswjpmlj2rsvnyop4zcszlwrwdd4nogsj3@utqc25oaccfb>
References: <20250317082047.564404-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hbprtcna6txu5faw"
Content-Disposition: inline
In-Reply-To: <20250317082047.564404-1-andyshrk@163.com>


--hbprtcna6txu5faw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/rockchip: dw_hdmi_qp: Fix io init for
 dw_hdmi_qp_rockchip_resume
MIME-Version: 1.0

Hi,

On Mon, Mar 17, 2025 at 04:20:39PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
>=20
> Use cfg->ctrl_ops->io_init callback make it work for all platform.
>=20
> Fixes: 3f60dbd40d3f ("drm/rockchip: dw_hdmi_qp: Add platform ctrl callbac=
k")
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---

It also gets rid of code duplication :)

>=20
>  .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    | 23 +++----------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu=
/drm/rockchip/dw_hdmi_qp-rockchip.c
> index 3d1dddb34603..631a7080862b 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> @@ -600,27 +600,10 @@ static void dw_hdmi_qp_rockchip_remove(struct platf=
orm_device *pdev)
>  static int __maybe_unused dw_hdmi_qp_rockchip_resume(struct device *dev)
>  {
>  	struct rockchip_hdmi_qp *hdmi =3D dev_get_drvdata(dev);
> -	u32 val;
> -
> -	val =3D HIWORD_UPDATE(RK3588_SCLIN_MASK, RK3588_SCLIN_MASK) |
> -	      HIWORD_UPDATE(RK3588_SDAIN_MASK, RK3588_SDAIN_MASK) |
> -	      HIWORD_UPDATE(RK3588_MODE_MASK, RK3588_MODE_MASK) |
> -	      HIWORD_UPDATE(RK3588_I2S_SEL_MASK, RK3588_I2S_SEL_MASK);
> -	regmap_write(hdmi->vo_regmap,
> -		     hdmi->port_id ? RK3588_GRF_VO1_CON6 : RK3588_GRF_VO1_CON3,
> -		     val);
> -
> -	val =3D HIWORD_UPDATE(RK3588_SET_HPD_PATH_MASK,
> -			    RK3588_SET_HPD_PATH_MASK);
> -	regmap_write(hdmi->regmap, RK3588_GRF_SOC_CON7, val);
> +	const struct rockchip_hdmi_qp_cfg *cfg;
> =20
> -	if (hdmi->port_id)
> -		val =3D HIWORD_UPDATE(RK3588_HDMI1_GRANT_SEL,
> -				    RK3588_HDMI1_GRANT_SEL);
> -	else
> -		val =3D HIWORD_UPDATE(RK3588_HDMI0_GRANT_SEL,
> -				    RK3588_HDMI0_GRANT_SEL);
> -	regmap_write(hdmi->vo_regmap, RK3588_GRF_VO1_CON9, val);
> +	cfg =3D of_device_get_match_data(dev);
> +	cfg->ctrl_ops->io_init(hdmi);

I think it would be better to store the ctrl_ops (or io_init)
callback in struct rockchip_hdmi_qp during driver probe and avoid
another lookup of the match_data, which involves string comparisons.

Otherwise:

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

--hbprtcna6txu5faw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfX9ngACgkQ2O7X88g7
+pqM3A/9EYnXD5oDYwTqakdXJIlFb5r0EhLAlJJCWtEYxOxa340HJlmcPAei3QlR
kV1q1zemGSOd+3SS5fwmb6kARERRKRZKz59f8uRXO9PEuVT9xm+3sR9UqwmTB8iH
TTaUHR08eYemlbhPVWgPf5AVstz77PN+WmJdAgqORI0URlqBnhIAN1hbYWk1HzMt
H+8WNlCfESWoVYSGzHsi4gLoL55K5RTkUSxEgpszQBQ4Cs5Tl/GPhNbmVDA29kxi
QDNMqksGoZ3A4lz9k0dOhO3Qe19FmCFHUjkCOLD/7Eq6TcbMpYVG2xE3Yzz+R11f
zPUfYxXe+QzM9nuFLUEQ/aV0MuT+gU1VltGg+VtinmoEw6incZI51QNmB24rHpS0
Wr1v9lsOmIhlB3Kn5N7/eZGhLboe1ukmiRS2kHMCOze/vYg9m4EUG+ZaBP4gt/L9
3c8ajXV0l+CGyc0SQeo2JDu5CtURVlt1X9LcUJSoM8urpw8lp6R68FJJDEgPgHRR
p+ruw3C+qrvWGOXeLV3e6xCYGcGCdToZ/r2T9Whq8HRY8RtAdskqFRTg6mqOnmVg
YSmAv8jbSlVuYfFoLoM4USx7BimM5PxzpqoOoQOFiBghtsquezBs0gscL56mAuqo
BC+WYm6BkFjM434NHE9x51tIA8UgUKbi01jjHXlHExcXpbtICys=
=mbY1
-----END PGP SIGNATURE-----

--hbprtcna6txu5faw--

