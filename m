Return-Path: <linux-kernel+bounces-532609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D10A44FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0FD3B42CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2150221516D;
	Tue, 25 Feb 2025 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="dif+GXen"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E720214A62
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522162; cv=none; b=le1IIVWXZVIO40uleJP0s2xQDJb6RR3gjTwKQzk4JfNtcqN6ndi+7T0+qovUvIlTj2xCkCZga9c+Z+JAWk2BmAwltB9S/76fD3nLT+E+UUXGrShw3Xh95fYcY2I2sIuQBwZL/2evl7RMp6trrwtRzBPS7hk5EqzeVnX4HtTa0fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522162; c=relaxed/simple;
	bh=1g+Ixifiu4z1UsJlTOqiv/+YhqCNX5Lq3nlZrBs8vFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCvtGEdeTtONU6hGcdOp5B4NjdrfHtEkr3DFgSDSRgrrWpeZSCZHCacIPwGX68bEivvO4JJX362Mze0qqVBbG8/MrrQY/LTfEATkiVr2SpDNRAKczBOhvRcHHwNmcz+kY2/csqGat3aHotmmIq69US+nR5m7keWNoUJv2bU/TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=dif+GXen; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/7Qfm5r1jq12hZzcqmc0YcQyVun0DCNgd0NuHzqRQtU=; b=dif+GXen+YI/pNv93D8+O4d/sP
	YhVNcSTPfA1XF6pfaUTw1mbIGNLCHceicWknYH/ZCz1BotOsmJGvPHo1IV+v7rKResE//FAck9HlW
	+zljZjB0SBtg18MFbSa7+iPosNiL0RbMjX3JOBHc9Sjt/ouXttEIxGXzUjFMBqlD6USUCAgALP9eY
	cnt97DhfPaXAfGmJLTSTXB8O51MnM2O4+zp9+Nc25s7nlf9It7tga6dG1TWcPen6WGNivDKorJBDP
	xJkPrEFrZBF7fjZTQxO0nFWXH4ovmroKsfz7dtDfygxPCiaebcK0DZitP01KHB10cRU8E+XgIOdoE
	vpZOMJNg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tn3Jy-0008Ll-D7; Tue, 25 Feb 2025 23:22:34 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, sebastian.reichel@collabora.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 1/2] phy: rockchip: usbdp: move type-orientation-switch further
 down
Date: Tue, 25 Feb 2025 23:22:33 +0100
Message-ID: <2868016.XrmoMso0CX@diego>
In-Reply-To: <7a8e6b9f-2fa2-4794-bb4f-3abdb784fbc3@wanadoo.fr>
References:
 <20250225184519.3586926-1-heiko@sntech.de>
 <20250225184519.3586926-2-heiko@sntech.de>
 <7a8e6b9f-2fa2-4794-bb4f-3abdb784fbc3@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 25. Februar 2025, 23:16:21 MEZ schrieb Christophe JAILLET:
> Le 25/02/2025 =C3=A0 19:45, Heiko Stuebner a =C3=A9crit :
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >=20
> > Move the typec-orientation-switch functionality further down, next to
> > the typec-mux code. Not only brings this the typec-related functionality
> > closer together, but also the following change needs access to other
> > driver functions, that are below the current position.
> >=20
> > No functional change.
> >=20
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> > ---
> >   drivers/phy/rockchip/phy-rockchip-usbdp.c | 166 +++++++++++-----------
> >   1 file changed, 83 insertions(+), 83 deletions(-)
> >=20
> > diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/ro=
ckchip/phy-rockchip-usbdp.c
> > index 5b1e8a3806ed..7b17c82ebcfc 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> > @@ -616,89 +616,6 @@ static void rk_udphy_dp_hpd_event_trigger(struct r=
k_udphy *udphy, bool hpd)
> >   	rk_udphy_grfreg_write(udphy->vogrf, &cfg->vogrfcfg[udphy->id].hpd_tr=
igger, hpd);
> >   }
> >  =20
> > -static void rk_udphy_set_typec_default_mapping(struct rk_udphy *udphy)
> > -{
> > -	if (udphy->flip) {
> > -		udphy->dp_lane_sel[0] =3D 0;
> > -		udphy->dp_lane_sel[1] =3D 1;
> > -		udphy->dp_lane_sel[2] =3D 3;
> > -		udphy->dp_lane_sel[3] =3D 2;
> > -		udphy->lane_mux_sel[0] =3D PHY_LANE_MUX_DP;
> > -		udphy->lane_mux_sel[1] =3D PHY_LANE_MUX_DP;
> > -		udphy->lane_mux_sel[2] =3D PHY_LANE_MUX_USB;
> > -		udphy->lane_mux_sel[3] =3D PHY_LANE_MUX_USB;
> > -		udphy->dp_aux_dout_sel =3D PHY_AUX_DP_DATA_POL_INVERT;
> > -		udphy->dp_aux_din_sel =3D PHY_AUX_DP_DATA_POL_INVERT;
> > -		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 1);
> > -		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> > -	} else {
> > -		udphy->dp_lane_sel[0] =3D 2;
> > -		udphy->dp_lane_sel[1] =3D 3;
> > -		udphy->dp_lane_sel[2] =3D 1;
> > -		udphy->dp_lane_sel[3] =3D 0;
> > -		udphy->lane_mux_sel[0] =3D PHY_LANE_MUX_USB;
> > -		udphy->lane_mux_sel[1] =3D PHY_LANE_MUX_USB;
> > -		udphy->lane_mux_sel[2] =3D PHY_LANE_MUX_DP;
> > -		udphy->lane_mux_sel[3] =3D PHY_LANE_MUX_DP;
> > -		udphy->dp_aux_dout_sel =3D PHY_AUX_DP_DATA_POL_NORMAL;
> > -		udphy->dp_aux_din_sel =3D PHY_AUX_DP_DATA_POL_NORMAL;
> > -		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> > -		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 1);
> > -	}
> > -
> > -	udphy->mode =3D UDPHY_MODE_DP_USB;
> > -}
> > -
> > -static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
> > -				 enum typec_orientation orien)
> > -{
> > -	struct rk_udphy *udphy =3D typec_switch_get_drvdata(sw);
> > -
> > -	mutex_lock(&udphy->mutex);
> > -
> > -	if (orien =3D=3D TYPEC_ORIENTATION_NONE) {
> > -		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> > -		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> > -		/* unattached */
> > -		rk_udphy_usb_bvalid_enable(udphy, false);
> > -		goto unlock_ret;
> > -	}
> > -
> > -	udphy->flip =3D (orien =3D=3D TYPEC_ORIENTATION_REVERSE) ? true : fal=
se;
> > -	rk_udphy_set_typec_default_mapping(udphy);
> > -	rk_udphy_usb_bvalid_enable(udphy, true);
> > -
> > -unlock_ret:
> > -	mutex_unlock(&udphy->mutex);
> > -	return 0;
> > -}
> > -
> > -static void rk_udphy_orien_switch_unregister(void *data)
> > -{
> > -	struct rk_udphy *udphy =3D data;
> > -
> > -	typec_switch_unregister(udphy->sw);
> > -}
> > -
> > -static int rk_udphy_setup_orien_switch(struct rk_udphy *udphy)
> > -{
> > -	struct typec_switch_desc sw_desc =3D { };
> > -
> > -	sw_desc.drvdata =3D udphy;
> > -	sw_desc.fwnode =3D dev_fwnode(udphy->dev);
> > -	sw_desc.set =3D rk_udphy_orien_sw_set;
> > -
> > -	udphy->sw =3D typec_switch_register(udphy->dev, &sw_desc);
> > -	if (IS_ERR(udphy->sw)) {
> > -		dev_err(udphy->dev, "Error register typec orientation switch: %ld\n",
> > -			PTR_ERR(udphy->sw));
> > -		return PTR_ERR(udphy->sw);
> > -	}
> > -
> > -	return devm_add_action_or_reset(udphy->dev,
> > -					rk_udphy_orien_switch_unregister, udphy);
> > -}
> > -
> >   static int rk_udphy_refclk_set(struct rk_udphy *udphy)
> >   {
> >   	unsigned long rate;
> > @@ -1323,6 +1240,89 @@ static const struct phy_ops rk_udphy_usb3_phy_op=
s =3D {
> >   	.owner		=3D THIS_MODULE,
> >   };
> >  =20
> > +static void rk_udphy_set_typec_default_mapping(struct rk_udphy *udphy)
> > +{
> > +	if (udphy->flip) {
> > +		udphy->dp_lane_sel[0] =3D 0;
> > +		udphy->dp_lane_sel[1] =3D 1;
> > +		udphy->dp_lane_sel[2] =3D 3;
> > +		udphy->dp_lane_sel[3] =3D 2;
> > +		udphy->lane_mux_sel[0] =3D PHY_LANE_MUX_DP;
> > +		udphy->lane_mux_sel[1] =3D PHY_LANE_MUX_DP;
> > +		udphy->lane_mux_sel[2] =3D PHY_LANE_MUX_USB;
> > +		udphy->lane_mux_sel[3] =3D PHY_LANE_MUX_USB;
> > +		udphy->dp_aux_dout_sel =3D PHY_AUX_DP_DATA_POL_INVERT;
> > +		udphy->dp_aux_din_sel =3D PHY_AUX_DP_DATA_POL_INVERT;
> > +		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 1);
> > +		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> > +	} else {
> > +		udphy->dp_lane_sel[0] =3D 2;
> > +		udphy->dp_lane_sel[1] =3D 3;
> > +		udphy->dp_lane_sel[2] =3D 1;
> > +		udphy->dp_lane_sel[3] =3D 0;
> > +		udphy->lane_mux_sel[0] =3D PHY_LANE_MUX_USB;
> > +		udphy->lane_mux_sel[1] =3D PHY_LANE_MUX_USB;
> > +		udphy->lane_mux_sel[2] =3D PHY_LANE_MUX_DP;
> > +		udphy->lane_mux_sel[3] =3D PHY_LANE_MUX_DP;
> > +		udphy->dp_aux_dout_sel =3D PHY_AUX_DP_DATA_POL_NORMAL;
> > +		udphy->dp_aux_din_sel =3D PHY_AUX_DP_DATA_POL_NORMAL;
> > +		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> > +		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 1);
> > +	}
> > +
> > +	udphy->mode =3D UDPHY_MODE_DP_USB;
> > +}
> > +
> > +static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
> > +				 enum typec_orientation orien)
> > +{
> > +	struct rk_udphy *udphy =3D typec_switch_get_drvdata(sw);
> > +
> > +	mutex_lock(&udphy->mutex);
> > +
> > +	if (orien =3D=3D TYPEC_ORIENTATION_NONE) {
> > +		gpiod_set_value_cansleep(udphy->sbu1_dc_gpio, 0);
> > +		gpiod_set_value_cansleep(udphy->sbu2_dc_gpio, 0);
> > +		/* unattached */
> > +		rk_udphy_usb_bvalid_enable(udphy, false);
> > +		goto unlock_ret;
> > +	}
> > +
> > +	udphy->flip =3D (orien =3D=3D TYPEC_ORIENTATION_REVERSE) ? true : fal=
se;
> > +	rk_udphy_set_typec_default_mapping(udphy);
> > +	rk_udphy_usb_bvalid_enable(udphy, true);
> > +
> > +unlock_ret:
> > +	mutex_unlock(&udphy->mutex);
> > +	return ret;
>=20
> This will break built.
>=20
> It was return 0 preivously.
> This change should be aprt of 2/2 where "int ret;" is introduced.

Thanks for noticing that mishap, will fix that in v2.

Heiko



