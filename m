Return-Path: <linux-kernel+bounces-299281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F995D24E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1792D1F26883
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE2189539;
	Fri, 23 Aug 2024 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSm0hgM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3E1DA4C;
	Fri, 23 Aug 2024 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428969; cv=none; b=RnsEnSO+Ywko+KLhGFNM356pVUc2VC8COi9QwZPuIVg8/tbhD8I47V6AyYaYRhLG2ERWPP8BPWWR7/5Jsd3rRLGlD7AFDbl0+LlICsw8Lsgyu9Hh0DCaXIfmD1gTiHaltoDWM5OYNOxyyeyDbQFVUCZfoVhAKo+iFKGoY6E4Ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428969; c=relaxed/simple;
	bh=+J5v2a1KYipoTMfE/Qk79+k0+U/RnOiCO1QF6+MROOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRieTcnjo0/XegGjxT4FGz2YQ5lTasyB0B8KBH6VgsQg+6PpBmt0frsPGuJtmd/gjRNaVtT5LSTyuco6mvT+jCiBkvQKKzhpug/I72Bl0fVfc9hMc8cCIUsLJiUvPrUTDQN47UoxT6X344GqnZEj556IH9NJYaHOPYc5H4aJ1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSm0hgM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62512C4AF09;
	Fri, 23 Aug 2024 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428968;
	bh=+J5v2a1KYipoTMfE/Qk79+k0+U/RnOiCO1QF6+MROOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSm0hgM6IJekKLoVVE4ON58EmoKIOJoNWoxufF4+bNJCT+g/pUd3wbRhW9P+J3VsW
	 fnGGRjDaXr/tZL+228+l2+0IFrz6qcMxcLs8//zybPvjRTkyK7Bz2vgcR72ZDAV50u
	 CQuV1ZVGFQ6p/rQ4SV7TuntA62tP3i88VsDCslQiBM+5gQRgN/9KUPWVFsbZVRGSLN
	 GsJkCgGYKV4Vrb7i/FIs7cs0Ob2isoRA+fO8AdHDroZTA9YahiaIY5Mdmp73ywISI/
	 L2UykFD9Yrr1rToETOdzTrEDkUP6B1fGBCMu+N1/L7uhVvLFj6UXpW9t9Iaz8T7Vpl
	 wi50RmyyR6eOw==
Date: Fri, 23 Aug 2024 17:02:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>
Subject: Re: Re: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema
 for RK3588 HDMI TX Controller
Message-ID: <20240823-swifter-smugly-c51447514f96@spud>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <7E8109D4-A353-4FE3-9152-3C3C6CB7D634@sntech.de>
 <2085e998-a453-4893-9e80-3be68b0fb13d@collabora.com>
 <4167579.6PsWsQAL7t@diego>
 <20240822-pushchair-premises-f4055779216a@spud>
 <7fc8cbc3-43d0-43d2-9272-350ac556e2b2@collabora.com>
 <4140b55c.a48.1917cc1095f.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tX5i8q7vWJU61EV6"
Content-Disposition: inline
In-Reply-To: <4140b55c.a48.1917cc1095f.Coremail.andyshrk@163.com>


--tX5i8q7vWJU61EV6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 09:01:51AM +0800, Andy Yan wrote:
>=20
> Hi=EF=BC=8C
>=20
> =E5=9C=A8 2024-08-22 19:59:43=EF=BC=8C"Cristian Ciocaltea" <cristian.cioc=
altea@collabora.com> =E5=86=99=E9=81=93=EF=BC=9A
> >On 8/22/24 11:41 AM, Conor Dooley wrote:
> >> On Thu, Aug 22, 2024 at 09:01:34AM +0200, Heiko St=C3=BCbner wrote:
> >>> @Conor: just for me, did some shift happen in our understanding of dt-
> >>> best-practices in terms of syscon via phandle vs. syscon via compatib=
le?
> >>>
> >>> Because Rockchip boards are referencing their GRFs via phandes forever
> >>> but similar to the soc vs non-soc node thing, I'd like to stay on top=
 of
> >>> best-practices ;-)
> >>=20
> >> If IP blocks, and thus drivers, are going to be reused between devices,
> >> using the phandles makes sense given that it is unlikely that syscon
> >> nodes can make use of fallback compatibles due to bits within that "gl=
ue"
> >> changing between devices. It also makes sense when there are multiple
> >> instances of an IP on the device, which need to use different syscons.
> >> My goal is to ask people why they are using these type of syscons
> >> phandle properties, cos often they are not required at all - for examp=
le
> >> with clocks where you effectively need a whole new driver for every
> >> single soc and having a phandle property buys you nothing.
> >
> >That would be also the case for this HDMI controller - need to check the
> >specs for the newer RK3576 SoC, but I expect the syscons would be quite
> >different when compared to RK3588, hence we should keep making use of
> >the phandles.
>=20
>=20
> Yes=EF=BC=8Cfor rk3576=EF=BC=8Cit shares the same HDMI IP block=EF=BC=88h=
dmi controller and PHY=EF=BC=89=EF=BC=8C
> of course reuse the driver of rk3588=EF=BC=8C but it has different GRF to=
 depends on[0]:
> which calls ioc_grf and vo0_grf:
>=20
> I also believe that makeing use of phandle beneficial for different devic=
es to reuse the same code.
>=20
> hdmi: hdmi@27da0000 {
>                 compatible =3D "rockchip,rk3576-dw-hdmi";
>                 reg =3D <0x0 0x27da0000 0x0 0x10000>, <0x0 0x27db0000 0x0=
 0x10000>;
>                 interrupts =3D <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
>                              <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>;
> ,            rockchip,grf =3D <&ioc_grf>;
>              rockchip,vo0_grf =3D <&vo0_grf>;

btw, I don't particularly like this naming - on another soc in the
future "vo0_grf" could be "vo1_grf". It is better to name them after
what they are providing to the hdmi controller, rather than what the grf
itself is called.

That said, if the grf is changing between socs, the offset within the
grf and what it provides to the hdmi controller may vary completely,
which makes having generic grf reference properties redundant.

>              phys =3D <&hdptxphy_hdmi>;
>              phy-names =3D "hdmi";
>=20
>=20
> [0]https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr3/arch/arm64/=
boot/dts/rockchip/rk3576.dtsi#L3122C2-L3123C33
>=20
> >
> >_______________________________________________
> >Linux-rockchip mailing list
> >Linux-rockchip@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-rockchip

--tX5i8q7vWJU61EV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsiyoQAKCRB4tDGHoIJi
0oGzAP41PotnHGP7pOq28w8lA6nlhNpPPnf7XLGOSlUCEoZ4HwEAp3PJGursxfJy
RIkB52Ug7Xev2iSA98QEF4jPYJGtKw4=
=eT1G
-----END PGP SIGNATURE-----

--tX5i8q7vWJU61EV6--

