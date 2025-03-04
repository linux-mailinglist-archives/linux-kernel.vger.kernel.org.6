Return-Path: <linux-kernel+bounces-543465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D27CDA4D5FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014193ADEE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D361F76BD;
	Tue,  4 Mar 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeL+6AeY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8D1F2BA1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076124; cv=none; b=ntnfBRmX1n6/CTOJaIQefSb3EqBr0Be70s735K8jHF9nIEoaF35apsfg+9+42fOB24XgAqhhs5bzssbDdZqSczsx/Im/Vs1jhKfc8JdfxLYDA3ADm7/UfzQrMoA0ntG6+PdeUz4E+XT3blPXXoauB1klTNX85MS8zDaliCCiIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076124; c=relaxed/simple;
	bh=ROr73SuXPD7t0E018Wl3IA3cdu0dJBkX02y9QuFH4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5mppfh/1IBmuGjwUPtywdTCHv3cGLZYUuspvZBsP+MUp9/ed6WETPD0WYo5Mr6l+8HdW2Bwygul/4MWxnvFf+SUuCMbjSkcvIEDeF+rUB2uewUnjmSD3r5N/d6HU3Pxy4AbL30tge6kR0j04QMumuJC8lL7Obp0I+/T0wzVEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeL+6AeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69211C4CEE5;
	Tue,  4 Mar 2025 08:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076123;
	bh=ROr73SuXPD7t0E018Wl3IA3cdu0dJBkX02y9QuFH4LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XeL+6AeYsJEJT5Q4dBoeCG4RWDoZPd2OkGpIABG6LjSXAhf3dz3nAU71u50aQ7Yvl
	 +w/lHl5yrfoLuAwkUTim7UX4n9RKtyDdc3UC+NxCHFUP38UJEova69tZuKX5riffi2
	 a0R+h+xNA5rD3cnzzymwFv+fZVBzCNWxl7WLrCx0kwSSWETPJ70kH0cUcP0zznuOEe
	 dIpE97J48JFwhXq9wG1JuC2oXL2aNxQ++hUiDglWi7QpaYx4gI01ZE5fT/F5EFNUWN
	 USCRmtp7XpMPwr/0GE+ybLbcTjOttl03bdzUUrTB9k5zvusa8ysMyY8CI4wMQBHK/h
	 n9z0SNrR+3Sag==
Date: Tue, 4 Mar 2025 09:15:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 07/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
Message-ID: <20250304-turtle-of-serious-aurora-2b0bae@houat>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-7-8657847c13f7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="533yzwzphi6h55mu"
Content-Disposition: inline
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-7-8657847c13f7@collabora.com>


--533yzwzphi6h55mu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 07/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 03:44:06AM +0200, Cristian Ciocaltea wrote:
> The current workaround to setup the TMDS character rate relies on the
> unconventional usage of phy_set_bus_width().
>=20
> Make use of the recently introduced HDMI PHY configuration API to
> properly handle the setup.  The workaround will be dropped as soon as
> the switch has been completed on both ends.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 54 ++++++++++++++++-=
------
>  1 file changed, 38 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/=
phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 2bf525514c1991a1299265d12e1e85f66333c604..7e1d1c10758249aa5bbddbdaa=
e0108bba04f30df 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -394,6 +394,7 @@ struct rk_hdptx_phy {
> =20
>  	int phy_id;
>  	struct phy *phy;
> +	struct phy_configure_opts_hdmi hdmi_cfg;
>  	struct clk_bulk_data *clks;
>  	int nr_clks;
>  	struct reset_control_bulk_data rsts[RST_MAX];
> @@ -1409,19 +1410,25 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_p=
hy *hdptx)
>  static int rk_hdptx_phy_power_on(struct phy *phy)
>  {
>  	struct rk_hdptx_phy *hdptx =3D phy_get_drvdata(phy);
> -	int bus_width =3D phy_get_bus_width(hdptx->phy);
>  	enum phy_mode mode =3D phy_get_mode(phy);
> +	unsigned int rate =3D 0;
>  	int ret, lane;
> =20
> -	/*
> -	 * FIXME: Temporary workaround to pass pixel_clk_rate
> -	 * from the HDMI bridge driver until phy_configure_opts_hdmi
> -	 * becomes available in the PHY API.
> -	 */
> -	unsigned int rate =3D bus_width & 0xfffffff;
> -
> -	dev_dbg(hdptx->dev, "%s bus_width=3D%x rate=3D%u\n",
> -		__func__, bus_width, rate);
> +	if (mode !=3D PHY_MODE_DP) {
> +		if (!hdptx->hdmi_cfg.tmds_char_rate) {
> +			/*
> +			 * FIXME: Temporary workaround to setup TMDS char rate
> +			 * from the RK DW HDMI QP bridge driver.
> +			 * Will be removed as soon the switch to the HDMI PHY
> +			 * configuration API has been completed on both ends.
> +			 */
> +			rate =3D phy_get_bus_width(hdptx->phy) & 0xfffffff;
> +			hdptx->hdmi_cfg.tmds_char_rate =3D rate * 100;
> +		} else {
> +			rate =3D hdptx->hdmi_cfg.tmds_char_rate / 100;
> +		}
> +		dev_dbg(hdptx->dev, "%s rate=3D%u\n", __func__, rate);
> +	}

Some story here, I can't make sense of a variable in hHz. If it's
actually needed and not a bug, this should be very explictly documented.

Maxime

--533yzwzphi6h55mu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8a2mAAKCRAnX84Zoj2+
ds5qAYDpYVQTakrNhdGZ31K2GrtIRiMUrxHtJV1CVxnsJ3BRW0eXDADFpRFQQZm0
Zaz4nXQBfiEBJBCeYXsv8v88Z/vOFFs1XoYBQs/YzCyGz3n+L9hjusKYEPel9EMs
agEDj+TQcA==
=TaF+
-----END PGP SIGNATURE-----

--533yzwzphi6h55mu--

