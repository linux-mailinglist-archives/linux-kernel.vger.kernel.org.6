Return-Path: <linux-kernel+bounces-441773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1FD9ED403
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B71888AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373ED1FF5E3;
	Wed, 11 Dec 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG49E3Q+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B62246335;
	Wed, 11 Dec 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939278; cv=none; b=jPD+MvF2qS6BiYqAYjUApQOoAo1KF3YFKNyiiPVNPt8MyHysPUT8ec4sfOuuUrCUUnwMI0sPxJXe+jeSR6lJSj73RRYHH6JOn7VUCivQXU4//4XTVZqXNZ7sG42JQ0QvHy/vXubDMm8Arxm+uu45RGrB3yP+iFJQBVWmwE9neW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939278; c=relaxed/simple;
	bh=TOa90gglsAMWtT4I7yLrFSBUAjraBKJ6HPeTieiLqG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRX5sRze6a4K2k7tH5RDsawFe/LTsAXZpR7eoxlV479YWmENDVqcE6ZcGfO/UPdSMyZJ7MZz/VQmMI26Xp8Q5z+pSI03fGsstiPVho2yWB4m4JUIw4mpQ99KsqztrCDrU/QAC9WAW/bkzn6VghMvdDd8X3gyl+6cFf8iJ8It5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG49E3Q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F11EC4CED2;
	Wed, 11 Dec 2024 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733939278;
	bh=TOa90gglsAMWtT4I7yLrFSBUAjraBKJ6HPeTieiLqG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FG49E3Q+siZrzENpjbDA5cUgsmXhazVqIjDVHOf9bsfRStdHLCDI4TGKszxLN2qLX
	 Onlce2Ey9PKE1nO4Vc9b7KbXea6Scgvl7hM2ep1lwi5cQEnhSCfPYCNCZLVIOjkZuc
	 frmDm1MmUoHkzeaJvUim9z5DPDoRwl5Rt/rnXUc6vkgX2LdW0KwJ+FdBVvdjHcCJmw
	 uGcNSUdi0WeUziTsaZ+Og8pPJRWDxf9SqpGTNBVrSzj7r9Fb4V6HUsQ2d6+bmy16Xf
	 8KR6T5t/U/h7HhwdgZJ/aTTgOcPxWQBCBNaqsG/hDozq01Cc3Vl1kIH+GDhFbiNQ6f
	 xY4ajavOL0nyQ==
Date: Wed, 11 Dec 2024 18:47:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 3/5] drm/rockchip: vop2: Improve display modes
 handling on RK3588 HDMI0
Message-ID: <a4ex3s23r4k6wehyoaw3aylpcexfrclrxxykjpabhdfne2jgmu@ii6riiiga2zj>
References: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
 <20241211-vop2-hdmi0-disp-modes-v2-3-471cf5001e45@collabora.com>
 <64vc5pkj44w3qxf5wkcxgghpwhvoagzemcsfqmi7fhsxt7vlqd@yfcgloi45ygh>
 <1820767.5KxKD5qtyk@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="u3dawvlh3uphzrsa"
Content-Disposition: inline
In-Reply-To: <1820767.5KxKD5qtyk@diego>


--u3dawvlh3uphzrsa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/5] drm/rockchip: vop2: Improve display modes
 handling on RK3588 HDMI0
MIME-Version: 1.0

On Wed, Dec 11, 2024 at 06:23:03PM +0100, Heiko St=FCbner wrote:
> Am Mittwoch, 11. Dezember 2024, 18:07:57 CET schrieb Maxime Ripard:
> > On Wed, Dec 11, 2024 at 12:15:07PM +0200, Cristian Ciocaltea wrote:
> > > The RK3588 specific implementation is currently quite limited in terms
> > > of handling the full range of display modes supported by the connected
> > > screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are just a
> > > few of them.
> > >=20
> > > Additionally, it doesn't cope well with non-integer refresh rates like
> > > 59.94, 29.97, 23.98, etc.
> > >=20
> > > Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
> > > all display modes up to 4K@60Hz.
> > >=20
> > > Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > > ---
> > >  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 ++++++++++++++++++=
++++++++++
> > >  1 file changed, 34 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/g=
pu/drm/rockchip/rockchip_drm_vop2.c
> > > index 8b2f53ffefdbf1cc8737b3a86e630a03a7fd9348..393fe6aa170aaee9663c4=
a6d98c1cd6a5ef79392 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > > @@ -158,6 +158,7 @@ struct vop2_video_port {
> > >  	struct drm_crtc crtc;
> > >  	struct vop2 *vop2;
> > >  	struct clk *dclk;
> > > +	struct clk *dclk_src;
> > >  	unsigned int id;
> > >  	const struct vop2_video_port_data *data;
> > > =20
> > > @@ -212,6 +213,7 @@ struct vop2 {
> > >  	struct clk *hclk;
> > >  	struct clk *aclk;
> > >  	struct clk *pclk;
> > > +	struct clk *pll_hdmiphy0;
> > > =20
> > >  	/* optional internal rgb encoder */
> > >  	struct rockchip_rgb *rgb;
> > > @@ -220,6 +222,8 @@ struct vop2 {
> > >  	struct vop2_win win[];
> > >  };
> > > =20
> > > +#define VOP2_MAX_DCLK_RATE		600000 /* kHz */
> > > +
> > >  #define vop2_output_if_is_hdmi(x)	((x) =3D=3D ROCKCHIP_VOP2_EP_HDMI0=
 || \
> > >  					 (x) =3D=3D ROCKCHIP_VOP2_EP_HDMI1)
> > > =20
> > > @@ -1033,6 +1037,9 @@ static void vop2_crtc_atomic_disable(struct drm=
_crtc *crtc,
> > > =20
> > >  	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
> > > =20
> > > +	if (vp->dclk_src)
> > > +		clk_set_parent(vp->dclk, vp->dclk_src);
> > > +
> > >  	clk_disable_unprepare(vp->dclk);
> > > =20
> > >  	vop2->enable_count--;
> > > @@ -2049,6 +2056,27 @@ static void vop2_crtc_atomic_enable(struct drm=
_crtc *crtc,
> > > =20
> > >  	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
> > > =20
> > > +	/*
> > > +	 * Switch to HDMI PHY PLL as DCLK source for display modes up
> > > +	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
> > > +	 */
> > > +	if (vop2->pll_hdmiphy0 && mode->crtc_clock <=3D VOP2_MAX_DCLK_RATE)=
 {
> > > +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encoder_=
mask) {
> > > +			struct rockchip_encoder *rkencoder =3D to_rockchip_encoder(encode=
r);
> > > +
> > > +			if (rkencoder->crtc_endpoint_id =3D=3D ROCKCHIP_VOP2_EP_HDMI0) {
> > > +				if (!vp->dclk_src)
> > > +					vp->dclk_src =3D clk_get_parent(vp->dclk);
> > > +
> > > +				ret =3D clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
> > > +				if (ret < 0)
> > > +					drm_warn(vop2->drm,
> > > +						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
> > > +				break;
> > > +			}
> > > +		}
> > > +	}
> > > +
> >=20
> > It seems pretty fragile to do it at atomic_enable time, even more so
> > since you don't lock the parent either.
> >=20
> > Any reason not to do it in the DRM or clock driver probe, and make sure
> > you never change the parent somehow?
>=20
> On rk3588 we have 3 dclk_s and 2 hdmi controllers. Each video-port can
> use the clock generated from either the hdmi0phy or hdmi1phy, depending
> on which hdmi-controller it uses.
>=20
> So you actually need to know which vpX will output to which hdmiY to then
> reparent that dclk to the hdmiphy output.

The Rockchip nomenclature isn't super obvious to me, sorry. Is there a
datasheet for this somewhere? Also, does this vpX -> HDMI-Y mapping need
to be dynamic?

Maxime

--u3dawvlh3uphzrsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1nQOgAKCRAnX84Zoj2+
dpISAYCKW2fMrHXRE79PeBqD3AHvy8GHUKEwGGeX3BAas8xqO9fecnaVOhTd/jgF
aHFKnB0BfiU6mRKoWOuEJkaaWPp04WJJkVX8YXQRkPWfKNs3xRzzajcAb5TYSDLW
8BxwZc4ZsA==
=vWbG
-----END PGP SIGNATURE-----

--u3dawvlh3uphzrsa--

