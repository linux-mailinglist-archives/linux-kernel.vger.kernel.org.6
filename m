Return-Path: <linux-kernel+bounces-543475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7CA4D618
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5367716480D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC861F940A;
	Tue,  4 Mar 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPwJ8SBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2081F55FA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076506; cv=none; b=buTUQX93Z4dtn3HiJPkiTUgIQbZCyFw1ejlrouJMZLABa7p01VdIlftpsd1Z9CXqI9GyG4IBDN8AF8E/bH7KD16X+KrGTfXTJz5eidoqNOij/QbZRJHPm8OKsfRpRSBZEe2svSiWcH0WqMf7uHzKzsT89cZnLg93fKxol0sADG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076506; c=relaxed/simple;
	bh=r+QgXwspE9bOIsdXuaHX5Fy587ozsozyvyxqkM7KM7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGo9XxXF2j4jqHM+s9IIsW7TE+TPehSoSCKlUZ1RGHHMNPL2Bk9whkEp1EUN+ETtCtNPjI/o5/mdp8ES4PYsgNVGlW7XRESvCEUu/VwJs8frHnOoPUZYnwT0xeoxZNkfju+hj+c93Kg5rMZpPchNZ2ACR3Amk9MS0VW/YUd+UEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPwJ8SBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1451DC4CEE5;
	Tue,  4 Mar 2025 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076505;
	bh=r+QgXwspE9bOIsdXuaHX5Fy587ozsozyvyxqkM7KM7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPwJ8SBDBr610xdCSiteMZ0vQQMEoAeLjKlooTDCQ6AwAtKnyEtTms8rhh+NQk+2V
	 gnna6yYT/kZKR+jEI06+nYnt/NX5ajaJbppAJljDNvujnvQWIbyuFgqwcVs8L/SwlW
	 Rw4CAmiKricAvytqpNEIH4Q179xKeZS/9+d+WaUtlnDhJqbT9/Q767NTYzymYdwCiY
	 RLyR+NpMenpAYFEg2fK6n3cZnHP5fw7fkNGxr0+VQ3gWhk6n0VW5OaL2avNFU/mwIs
	 S0FLt3/ZnmaYsgvTXh50/jYuTMrQeqXizLXm4WNuJYUZ5evnULGBgFb1vYvLeOmVWg
	 vbaWroNd/HuQg==
Date: Tue, 4 Mar 2025 09:21:43 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 10/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
Message-ID: <20250304-delicate-crazy-tuatara-5ea4d3@houat>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-10-8657847c13f7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="i3vrrx3psrj2lhwm"
Content-Disposition: inline
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-10-8657847c13f7@collabora.com>


--i3vrrx3psrj2lhwm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 10/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 03:44:09AM +0200, Cristian Ciocaltea wrote:
> @@ -1480,12 +1484,12 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
>  static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
>  					   struct phy_configure_opts_hdmi *hdmi)
>  {
> -	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
> -		return -EINVAL;
> -
>  	u32 bit_rate =3D hdmi->tmds_char_rate / 100;
>  	int i;
> =20
> +	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
> +		return -EINVAL;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
>  		if (bit_rate =3D=3D ropll_tmds_cfg[i].bit_rate)
>  			break;

Why is that change needed?

Maxime

--i3vrrx3psrj2lhwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8a4FgAKCRAnX84Zoj2+
diuVAX4ozKl6gJOFIJUKtEjxOPipdOu9iB/HuKt1Vnl8PydF6Q+9rpNCmfTUHVLb
yeBXM+8BfitH+H7qMyogVHRVuaRdMoO5CdfQvz8UPrcFG/RFymk53sbJ9HgyBuDq
jqseFCQ4bg==
=aIsW
-----END PGP SIGNATURE-----

--i3vrrx3psrj2lhwm--

