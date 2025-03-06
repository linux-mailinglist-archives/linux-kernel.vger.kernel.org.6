Return-Path: <linux-kernel+bounces-549027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33FA54C4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D55B1894F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ED620D4E8;
	Thu,  6 Mar 2025 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+TL6TFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73CA20ADC9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268123; cv=none; b=j6Uow3qxHBYvfeLaGxB+ZjAMpECSaTiSL/IowsDb+KhTqqRg/M0rwiVEkHU3TXyncgQ3sVCTVaan36LNFtB3rwBoCkRbS5Gmk95UJ9tusp3nW9DgD2gTZpu3XKSn09mgZuD++hD0cnk0M65RNLfSIKBVqNB+VdbmXu8pHlF+aQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268123; c=relaxed/simple;
	bh=TEsU6Ht+78gm09L1SBIsP4bdIB/vCUld4RHRuN+JlCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeluwWNK0AJbJ/Vgz+4yWOy5cyjnMnFF+qR56tLCbBn+piUcyYZUgX9h8LkFS7MXZ5nLEafimJIuRsoPVk9kH9GXVuE2x5kHCFYw3kKdJUn8ZRHwGlFLNeOdblQKKpLc5VifybkHd2jTAww2SnKOorprlOoWvog7VGNhOrzlHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+TL6TFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9BAC4CEE5;
	Thu,  6 Mar 2025 13:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741268122;
	bh=TEsU6Ht+78gm09L1SBIsP4bdIB/vCUld4RHRuN+JlCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+TL6TFUsUtdn/wseDX/hYan08UFevaGvb3dKbl/pMQO1gxynYz1WPVc+GwbDdGSg
	 G6VVxvTMlQ151wtr2rH2dXaRev4a14umu7sY4Zpa2E8jjqn2gzTw/l+8SCDIEpXjkQ
	 SSvUXWrM+81mTvqh60ZrJFDki3uEYB6At22GMnkZYwODW1iKnJgtlGNQ18rpCVuwuZ
	 rA923hDM/3tLy0TqI8K+ZM49CkkiPZGP4b/ICuIOQNEH0aHIwSOuINFcFghhD2ubZW
	 qGqH8P7KYxHxv4Pt5qntnkp7sYPguNuZ0Rl6JwC+DQwcBKr6i/dsnUfA0pel585GA0
	 i0LNrLA0fM4/A==
Date: Thu, 6 Mar 2025 14:35:19 +0100
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
Message-ID: <20250306-masked-voracious-octopus-be05b8@houat>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
 <20250304-phy-sam-hdptx-bpc-v4-3-8657847c13f7@collabora.com>
 <20250304-small-mindful-mongrel-bd6f8b@houat>
 <155f609f-994f-4140-8453-7e38a5e6deef@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5o2wzlaqjbtp76c4"
Content-Disposition: inline
In-Reply-To: <155f609f-994f-4140-8453-7e38a5e6deef@collabora.com>


--5o2wzlaqjbtp76c4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio
 setup
MIME-Version: 1.0

On Tue, Mar 04, 2025 at 02:04:18PM +0200, Cristian Ciocaltea wrote:
> Hi Maxime,
>=20
> On 3/4/25 10:13 AM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Tue, Mar 04, 2025 at 03:44:02AM +0200, Cristian Ciocaltea wrote:
> >> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
> >> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
> >> and not before.
> >>
> >> While at it, introduce a define for this rate limit constant.
> >>
> >> Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY dr=
iver")
> >> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> >> ---
> >>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drive=
rs/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >> index f88369864c50e4563834ccbb26f1f9f440e99271..cf2c3a46604cb9d8c26fe5=
ec8346904e0b62848f 100644
> >> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> >> @@ -320,6 +320,7 @@
> >>  #define LN3_TX_SER_RATE_SEL_HBR2_MASK	BIT(3)
> >>  #define LN3_TX_SER_RATE_SEL_HBR3_MASK	BIT(2)
> >> =20
> >> +#define HDMI14_MAX_RATE			340000000
> >>  #define HDMI20_MAX_RATE			600000000
> >> =20
> >>  enum dp_link_rate {
> >> @@ -1072,7 +1073,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struc=
t rk_hdptx_phy *hdptx,
> >> =20
> >>  	regmap_write(hdptx->regmap, LNTOP_REG(0200), 0x06);
> >> =20
> >> -	if (rate >=3D 3400000) {
> >> +	if (rate > HDMI14_MAX_RATE / 100) {
> >=20
> > The rate seems to come from rk_hdptx_phy_power_on and eventually from
> > tmds_char_rate in the PHY config options, so its rate is in Hertz.
>=20
> The rate coming from rk_hdptx_phy_power_on() is in hHz, since it passed
> via dw_hdmi_qp_rockchip_encoder_enable() as
>=20
>   phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
>=20
> > HDMI14_MAX_RATE and HDMI20_MAX_RATE are both defined in Hertz as well.
> > It seems super odd to mee that you then convert HDMI14_MAX_RATE to hHz?
>=20
> This stems from the ropll_tmds_cfg table containing the configuration
> params for the supported rates which requires the search keys to be
> provided in hHz rather than Hz.
>=20
> I agree this is nothing but confusing, that's why I fixed this up in
> "phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit conversion overhead"

Yeah, sorry, I noticed it after sending the review. Still, I'd advise to
put that patch first, it's a bit weird to add more patch we're going to
rework later on.

Maxime

--5o2wzlaqjbtp76c4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8mklwAKCRAnX84Zoj2+
dqsKAX4nqDcG5Vb45Qfy+reElIgfRIEkKdypEs03k8+dDGrmbgN4qMjCkJ/EBkjn
HbmMAisBfRB4vWfpfcqsMV2LqZBvfAivr19nVh8LflLAH8Q/WFHnP5NlHsqmOcuv
WXoDH3DoGQ==
=ZIQ8
-----END PGP SIGNATURE-----

--5o2wzlaqjbtp76c4--

