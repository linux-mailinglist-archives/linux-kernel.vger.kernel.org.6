Return-Path: <linux-kernel+bounces-543460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4FA4D5E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA3B1719A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22461F8EEC;
	Tue,  4 Mar 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7XLZFu5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199B1EF0B7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076004; cv=none; b=uNOeJTa91qId7f3eb+eBpIgmDDAaxelInNRgSo/PfLdHCymohlQet70AAykjOi9J1cl1R7T6KCS+m5Ov7h6QBB9xaOiPgS/98fsyInGijLo8VWS+7Jfk3585pCap5UiBrrLztt8RYaWhVujxKxG+J2eo5fPJr+brulYqhA+1MvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076004; c=relaxed/simple;
	bh=GHy5E/3mPv773kIwD9J1pCgLnjD33qEGYhJtCdEIpPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OP4d1O99n/J7Qe7uQqqOkgVC9Z8KqKDnPPiMSdf6XPWBurkDo5pSNSuBQpc6vd5h/zzxJF0+M2aFosAJTO92l+56BjJcgj3QmaUUSQ0haaS0sujPCyklu/PUJxVJBx3cImr32uBcBn7OnTmUrQpYfh3rlzlgnl7zSfs4Y7D2Hgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7XLZFu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC73C4CEE5;
	Tue,  4 Mar 2025 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741076003;
	bh=GHy5E/3mPv773kIwD9J1pCgLnjD33qEGYhJtCdEIpPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7XLZFu5KdnMZWgJ4CPWxZm/klB4jrV+EVKtDi70MwYPiycz2O6teOvZstbbB5uKn
	 4HwoUxIxuHHnuCypMFixeYlVN5fDlopFAfbhSRyw/rsIDOvcnARxv3U89fQHCLT1rT
	 YH+0V+isLot4BXjTul7TmgUBvCuRmJW/mLMIc6bNu/Gy11mEgx/W4ucWePaZT1wAtB
	 5UhwuaBMPU1q2xQ4PqU2BBOzTKgpz0LFcHjnjV3cktNatF7Rw/Adbd1BdbARmK/Q81
	 EsrI3k9YzFvgdiu9I57NpQbQWc3S7kvI4IhjCmipKXE+OF5Qji9blkKlCrkHH2vf3s
	 +TcVyR1GsGUGw==
Date: Tue, 4 Mar 2025 09:13:20 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio
 setup
Message-ID: <20250304-small-mindful-mongrel-bd6f8b@houat>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-3-8657847c13f7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="sg64fqm2xqk74cdt"
Content-Disposition: inline
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-3-8657847c13f7@collabora.com>


--sg64fqm2xqk74cdt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio
 setup
MIME-Version: 1.0

Hi,

On Tue, Mar 04, 2025 at 03:44:02AM +0200, Cristian Ciocaltea wrote:
> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
> and not before.
>=20
> While at it, introduce a define for this rate limit constant.
>=20
> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY drive=
r")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/=
phy/rockchip/phy-rockchip-samsung-hdptx.c
> index f88369864c50e4563834ccbb26f1f9f440e99271..cf2c3a46604cb9d8c26fe5ec8=
346904e0b62848f 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -320,6 +320,7 @@
>  #define LN3_TX_SER_RATE_SEL_HBR2_MASK	BIT(3)
>  #define LN3_TX_SER_RATE_SEL_HBR3_MASK	BIT(2)
> =20
> +#define HDMI14_MAX_RATE			340000000
>  #define HDMI20_MAX_RATE			600000000
> =20
>  enum dp_link_rate {
> @@ -1072,7 +1073,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struct r=
k_hdptx_phy *hdptx,
> =20
>  	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
> =20
> -	if (rate >=3D 3400000) {
> +	if (rate > HDMI14_MAX_RATE / 100) {

The rate seems to come from rk_hdptx_phy_power_on and eventually from
tmds_char_rate in the PHY config options, so its rate is in Hertz.
HDMI14_MAX_RATE and HDMI20_MAX_RATE are both defined in Hertz as well.
It seems super odd to mee that you then convert HDMI14_MAX_RATE to hHz?

Maxime

--sg64fqm2xqk74cdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8a2IAAKCRAnX84Zoj2+
dhWwAXsGrPqoPNFcfL6UhsGPHfIbxb05Q1NH5HI480bGuviWiVrea7qwGAeT8u2M
KeEzcAsBfj2fxEy07AOeK8CNxPHb+7WdQQNZaTTvJ0v33gEjKuOtX/vTQGE2pL5b
8uPw/l2Bkg==
=cCWQ
-----END PGP SIGNATURE-----

--sg64fqm2xqk74cdt--

