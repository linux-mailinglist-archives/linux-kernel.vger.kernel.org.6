Return-Path: <linux-kernel+bounces-299277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520D95D243
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E04283819
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DF189BB2;
	Fri, 23 Aug 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjr83euP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BE188A3E;
	Fri, 23 Aug 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428789; cv=none; b=TTzj0/BSxrCb2qi/818+F9AOqYCaHe1Q6gZgPJ33ffwNy/hMnaefRM5RNm+D6RHEk6Dlipa2VwbUhkEdFjMQWBNwdfPlsRZAtiGtKooVu/fMA0nZYvwgv6uR3kBp3i8KkSvLXhtEnKB11HITcN2jMDrALa1GfqttGJAtCTm+KXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428789; c=relaxed/simple;
	bh=O2lMKlPvm5xBpbj9dv2BdmqyLIQ1zrOWY1a1YXHnZ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRLIOjZ89oL1X6Mee4gxQlpNUXcX+qzNxHgOpMsKvjnwdZd8C9Jek04dY+onWyEKnvxaS07FIzJhFOr6uGHOFgC/JCxTdHOEIzZtPe4xXcBYYmsP6l9N9BJaXqnwd7rpp0mP/dNojMUpyy32DRAoD8ZrscrUNwkFHt5PptjyaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjr83euP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB49C32786;
	Fri, 23 Aug 2024 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428789;
	bh=O2lMKlPvm5xBpbj9dv2BdmqyLIQ1zrOWY1a1YXHnZ4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hjr83euPg8IQyUwMQjvhJt/F2p/Xm//W9sjhrdpUOO1ypRA/Q3y9ykqKAyQSM0mt0
	 gFLYHGWSDx977PfXdpwWFoclJKsI3jzvnCumGBzR7YneezFvQZhpfX7HaWTyhO5Zzu
	 FJsJVPS7yEq1ZCRSe2l/VIDRhjYsyIpWGkDncX22DhmbV3pZ/49v5Z0F15o7HkQ45p
	 bQF3L/W2u1sKpSXxwPlTX/zaU8t5ixzuGpw358NOsyt3pYyeuZzFqgainiMRUd1saX
	 hgf6N7FDQMvGVorz5WKf7Y8gH0gAhMkcF+EqGTYTFgYqT0Y7yZVuYFOx5KhBEFX3WB
	 /SOcJpfarUVLQ==
Date: Fri, 23 Aug 2024 16:59:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
Subject: Re: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema for
 RK3588 HDMI TX Controller
Message-ID: <20240823-lunar-esteemed-a727b6de8cbe@spud>
References: <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <4167579.6PsWsQAL7t@diego>
 <20240822-pushchair-premises-f4055779216a@spud>
 <3137870.U3zVgo479M@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hV0DDwkOk4FQlrs4"
Content-Disposition: inline
In-Reply-To: <3137870.U3zVgo479M@diego>


--hV0DDwkOk4FQlrs4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 12:47:50PM +0200, Heiko St=FCbner wrote:
> Am Donnerstag, 22. August 2024, 10:41:10 CEST schrieb Conor Dooley:
> > On Thu, Aug 22, 2024 at 09:01:34AM +0200, Heiko St=FCbner wrote:
> > > @Conor: just for me, did some shift happen in our understanding of dt-
> > > best-practices in terms of syscon via phandle vs. syscon via compatib=
le?
> > >=20
> > > Because Rockchip boards are referencing their GRFs via phandes forever
> > > but similar to the soc vs non-soc node thing, I'd like to stay on top=
 of
> > > best-practices ;-)
> >=20
> > If IP blocks, and thus drivers, are going to be reused between devices,
> > using the phandles makes sense given that it is unlikely that syscon
> > nodes can make use of fallback compatibles due to bits within that "glu=
e"
> > changing between devices. It also makes sense when there are multiple
> > instances of an IP on the device, which need to use different syscons.
> > My goal is to ask people why they are using these type of syscons
> > phandle properties, cos often they are not required at all - for example
> > with clocks where you effectively need a whole new driver for every
> > single soc and having a phandle property buys you nothing.
>=20
> I guess I'm of two minds here.
>=20
> For me at least it makes sense to spell out the dependency to the
> syscon in the devicetree and not just have that hidden away inside the
> driver.
>=20
> But on the other hand, we already have the per-soc configuration [0]
> defining which grf bits needs to be accessed, so adding a
>=20
> 	.lanecfg1_grf_compat =3D "rockchip,rk3568-vo"
>=20
> would not create overhad, as the grf regs and bits and rearranged
> all the time anyway.

Right, that's the other side of it. Raw phandles aren't that great if
the bits are gonna move around the register and you have to use the
match data to figure out where they are. phandle + offset is the other
option for that kind of scenario, particularly in cases where there are
multiple copies of a block on an SoC and each uses either a different
syscon or a different set of registers within one.

>=20
>=20
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c#n1652
> taking DSI as an example, where this is even more obvious
>=20
>=20

--hV0DDwkOk4FQlrs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsix7QAKCRB4tDGHoIJi
0iOnAQCzjBObBEXW5gvG2K3RPILn8u+nPpQFIaHghl7RlSPXRgD8CMDqOYKns/Dy
oZZF/fVLrYmrSuw4spyzAIfbrGlg/QA=
=ONcF
-----END PGP SIGNATURE-----

--hV0DDwkOk4FQlrs4--

