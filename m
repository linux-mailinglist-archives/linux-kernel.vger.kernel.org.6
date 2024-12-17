Return-Path: <linux-kernel+bounces-449608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABC9F516C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016D0162903
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC31F7564;
	Tue, 17 Dec 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlS7YtpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3E14A609;
	Tue, 17 Dec 2024 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454412; cv=none; b=Sn3iSfk3ZL0vCqYvQC1vzB/W4HCPpECJqdpPY2bYgJ17+4QEyl8gGKiOX8akoMR24L2g+CY59s/TKP9Rey/oJbmGnyR4I9SteO0wuO/cEd4UYjmAVBaG2XKdopuGsCUR7aeDX9AI87dSVNT3ZVmIkn7/7UsoiX7vsDVwM0J1Ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454412; c=relaxed/simple;
	bh=EOJspbm7MP7wG0IjvVUNU+l636arDNGqBCyTzRfpfbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY69xQ0Ypu5fpECCTlEDKQh7EEx9yWn002ORAD18Fy9drb6W2iAPWCGzFCXrczAmmMduXWLssyjp2+tWvkkydEG5Ypt1UwYVFu9GXO9o8PDL1fWrZJqcyarGczKn7pml8hFOc2s8W3Dky/x3XyDoy+uBKt+VyIjhh68NkfHYB+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlS7YtpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E537C4CED3;
	Tue, 17 Dec 2024 16:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734454412;
	bh=EOJspbm7MP7wG0IjvVUNU+l636arDNGqBCyTzRfpfbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlS7YtpFsL/gTqOzHFp9lpkcIkTrozL//Q/lMLNXbPW3Y6m2sgkt5CGABkkAjo0u2
	 es6xqBqUBVJ+EEjVk4ljZzWGXLhxrWbnql7aU1x/Gq+smMLm85OG8Q4XnOdNUdbKuJ
	 B9Kal/JswAvNPqnL3Fh80lNcUqkppz8sIqWUxhfVxzXvG+lxc+eHJf9YZXGWncIn1y
	 sB07MUtRE4rm4aIbIuWtq+9lB3CpP9P1A4+LvzRvIMVMluirSZAJ8DNP7m56yyYOgw
	 uesQmgEIrWcTGXVvI0gUxJdSoTfKoyJjYajgaslXGUBGUXTsPak061NnMfyBj6yWs1
	 CoVcBpdw3jrCw==
Date: Tue, 17 Dec 2024 17:53:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 3/5] drm/rockchip: vop2: Improve display modes
 handling on RK3588 HDMI0
Message-ID: <20241217-zealous-boisterous-llama-52bfcc@houat>
References: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
 <1820767.5KxKD5qtyk@diego>
 <a4ex3s23r4k6wehyoaw3aylpcexfrclrxxykjpabhdfne2jgmu@ii6riiiga2zj>
 <1756448.izSxrag8PF@diego>
 <20241217-ubiquitous-refreshing-finch-aceade@houat>
 <c45ff74a-c9a4-4cf1-8530-04087e06b07a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="j4mpk3mpmbzuirpe"
Content-Disposition: inline
In-Reply-To: <c45ff74a-c9a4-4cf1-8530-04087e06b07a@collabora.com>


--j4mpk3mpmbzuirpe
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/5] drm/rockchip: vop2: Improve display modes
 handling on RK3588 HDMI0
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 06:36:41PM +0200, Cristian Ciocaltea wrote:
> On 12/17/24 5:00 PM, Maxime Ripard wrote:
> > On Wed, Dec 11, 2024 at 07:01:15PM +0100, Heiko St=FCbner wrote:
> >> Am Mittwoch, 11. Dezember 2024, 18:47:44 CET schrieb Maxime Ripard:
> >>> On Wed, Dec 11, 2024 at 06:23:03PM +0100, Heiko St=FCbner wrote:
> >>>> Am Mittwoch, 11. Dezember 2024, 18:07:57 CET schrieb Maxime Ripard:
> >>>>> On Wed, Dec 11, 2024 at 12:15:07PM +0200, Cristian Ciocaltea wrote:
> >>>>>> The RK3588 specific implementation is currently quite limited in t=
erms
> >>>>>> of handling the full range of display modes supported by the conne=
cted
> >>>>>> screens, e.g. 2560x1440@75Hz, 2048x1152@60Hz, 1024x768@60Hz are ju=
st a
> >>>>>> few of them.
> >>>>>>
> >>>>>> Additionally, it doesn't cope well with non-integer refresh rates =
like
> >>>>>> 59.94, 29.97, 23.98, etc.
> >>>>>>
> >>>>>> Make use of HDMI0 PHY PLL as a more accurate DCLK source to handle
> >>>>>> all display modes up to 4K@60Hz.
> >>>>>>
> >>>>>> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> >>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.co=
m>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 34 +++++++++++++++=
+++++++++++++
> >>>>>>  1 file changed, 34 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/driver=
s/gpu/drm/rockchip/rockchip_drm_vop2.c
> >>>>>> index 8b2f53ffefdbf1cc8737b3a86e630a03a7fd9348..393fe6aa170aaee966=
3c4a6d98c1cd6a5ef79392 100644
> >>>>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >>>>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> >>>>>> @@ -158,6 +158,7 @@ struct vop2_video_port {
> >>>>>>  	struct drm_crtc crtc;
> >>>>>>  	struct vop2 *vop2;
> >>>>>>  	struct clk *dclk;
> >>>>>> +	struct clk *dclk_src;
> >>>>>>  	unsigned int id;
> >>>>>>  	const struct vop2_video_port_data *data;
> >>>>>> =20
> >>>>>> @@ -212,6 +213,7 @@ struct vop2 {
> >>>>>>  	struct clk *hclk;
> >>>>>>  	struct clk *aclk;
> >>>>>>  	struct clk *pclk;
> >>>>>> +	struct clk *pll_hdmiphy0;
> >>>>>> =20
> >>>>>>  	/* optional internal rgb encoder */
> >>>>>>  	struct rockchip_rgb *rgb;
> >>>>>> @@ -220,6 +222,8 @@ struct vop2 {
> >>>>>>  	struct vop2_win win[];
> >>>>>>  };
> >>>>>> =20
> >>>>>> +#define VOP2_MAX_DCLK_RATE		600000 /* kHz */
> >>>>>> +
> >>>>>>  #define vop2_output_if_is_hdmi(x)	((x) =3D=3D ROCKCHIP_VOP2_EP_HD=
MI0 || \
> >>>>>>  					 (x) =3D=3D ROCKCHIP_VOP2_EP_HDMI1)
> >>>>>> =20
> >>>>>> @@ -1033,6 +1037,9 @@ static void vop2_crtc_atomic_disable(struct =
drm_crtc *crtc,
> >>>>>> =20
> >>>>>>  	vop2_crtc_disable_irq(vp, VP_INT_DSP_HOLD_VALID);
> >>>>>> =20
> >>>>>> +	if (vp->dclk_src)
> >>>>>> +		clk_set_parent(vp->dclk, vp->dclk_src);
> >>>>>> +
> >>>>>>  	clk_disable_unprepare(vp->dclk);
> >>>>>> =20
> >>>>>>  	vop2->enable_count--;
> >>>>>> @@ -2049,6 +2056,27 @@ static void vop2_crtc_atomic_enable(struct =
drm_crtc *crtc,
> >>>>>> =20
> >>>>>>  	vop2_vp_write(vp, RK3568_VP_MIPI_CTRL, 0);
> >>>>>> =20
> >>>>>> +	/*
> >>>>>> +	 * Switch to HDMI PHY PLL as DCLK source for display modes up
> >>>>>> +	 * to 4K@60Hz, if available, otherwise keep using the system CRU.
> >>>>>> +	 */
> >>>>>> +	if (vop2->pll_hdmiphy0 && mode->crtc_clock <=3D VOP2_MAX_DCLK_RA=
TE) {
> >>>>>> +		drm_for_each_encoder_mask(encoder, crtc->dev, crtc_state->encod=
er_mask) {
> >>>>>> +			struct rockchip_encoder *rkencoder =3D to_rockchip_encoder(enc=
oder);
> >>>>>> +
> >>>>>> +			if (rkencoder->crtc_endpoint_id =3D=3D ROCKCHIP_VOP2_EP_HDMI0)=
 {
> >>>>>> +				if (!vp->dclk_src)
> >>>>>> +					vp->dclk_src =3D clk_get_parent(vp->dclk);
> >>>>>> +
> >>>>>> +				ret =3D clk_set_parent(vp->dclk, vop2->pll_hdmiphy0);
> >>>>>> +				if (ret < 0)
> >>>>>> +					drm_warn(vop2->drm,
> >>>>>> +						 "Could not switch to HDMI0 PHY PLL: %d\n", ret);
> >>>>>> +				break;
> >>>>>> +			}
> >>>>>> +		}
> >>>>>> +	}
> >>>>>> +
> >>>>>
> >>>>> It seems pretty fragile to do it at atomic_enable time, even more so
> >>>>> since you don't lock the parent either.
> >>>>>
> >>>>> Any reason not to do it in the DRM or clock driver probe, and make =
sure
> >>>>> you never change the parent somehow?
> >>>>
> >>>> On rk3588 we have 3 dclk_s and 2 hdmi controllers. Each video-port c=
an
> >>>> use the clock generated from either the hdmi0phy or hdmi1phy, depend=
ing
> >>>> on which hdmi-controller it uses.
> >>>>
> >>>> So you actually need to know which vpX will output to which hdmiY to=
 then
> >>>> reparent that dclk to the hdmiphy output.
> >>>
> >>> The Rockchip nomenclature isn't super obvious to me, sorry. Is there a
> >>> datasheet for this somewhere? Also, does this vpX -> HDMI-Y mapping n=
eed
> >>> to be dynamic?
> >>
> >> VPs are CRTCs in drm-language and each of them can drive a differing
> >> number of output encoders. Those video-ports also have differing output
> >> characteristics in terms of supported resolution and other properties.
> >>
> >> The rk3588 TRM has leaked in a number of places, and if you find a
> >> TRM-part2, there is a section labeled "Display Output Interface Descri=
ption"
> >> that has a nice graphic for that.
> >>
> >> Or in short:
> >> - CRTC(VP)0 supports 8K resolution and can drive DP0+1, HDMI0+1, eDP0+1
> >>   [if I'm reading things correctly, 8K together with CRTC1 somehow)
> >> - CRTC(VP)1 supports 4K resolution and can drive DP0+1, HDMI0+1, eDP0+1
> >> - CRTC(VP)2 supports 4K resolution and can drive DP0+1, HDMI0+1, eDP01=
, DSI0+1
> >> - CRTC(VP)3 supports 2K resolution and can drive DSI0+1 and some BT112=
0,BT656
> >>
> >> so for the 3 higher resolution CRTCs there are essentially 6 or 8 outp=
ut options
> >> depending on the board design
> >=20
> > That's much clearer, thanks. I'm not entirely sure how that links to the
> > need for the PLL to change its parent depending on the ouput. Do you
> > need to always have all the outputs on the same PLL?
>=20
> One of the problems is that the PHY PLLs cannot be used as clock sources
> for resolutions above 4K@60Hz, while VOP2 on RK3588 supports up to 8K@60H=
z,
> which is supposed to be handled by the system CRU.

But can that system CRU drive resolutions lower than 4k@60? If so, why
do we bother with PHYs?

> Moreover, the 2 PLLs are shared between 3 out of the 4 video ports already
> mentioned by Heiko.  There is quite a bit of complexity in downstream
> driver to handle all possible usecases - see [1] for a brief description =
on
> how was that designed to work.

That's a generic allocation issue. Multiple drivers (vc4 for example)
has this issue for other components. It can be fairly easily dealt with
at atomic_check time.

Maxime

--j4mpk3mpmbzuirpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2GsgQAKCRAnX84Zoj2+
dujIAX96ph7wCOEKhEVEvFE7nIYDouKQ48JPrJAUDi5plPwo1A/2ruUYjui/h6aO
6e/R4ugBgM2dKMjhL2GPa78I2aqbjLCG/FGj4quQcjpkH3nmXDPHdkz5FaZJO0ee
9vQJK4Wzqw==
=+Pvw
-----END PGP SIGNATURE-----

--j4mpk3mpmbzuirpe--

