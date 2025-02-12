Return-Path: <linux-kernel+bounces-510888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05310A3233F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C001A3A4A97
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021822080E3;
	Wed, 12 Feb 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVr9syjr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB22063C7;
	Wed, 12 Feb 2025 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354898; cv=none; b=E5ghCeSvqL+DSUPYQyjMZac67ZgfALff/AY876nWSM3+CifwQLAau/TjyAbHbrox9bcuepbNF9jtf5ilgiAxvdP2BrzkKvtTGONH8WkQ5bvVRkxmins9tk8C9NIvVvx3DL6bu5wTl8aVE8gspEUc8YG31bluEJtHkwOgGrbt1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354898; c=relaxed/simple;
	bh=SZIYgUNCCnIL5V0seV/NEEb2Rim4jnuOX/CWoopZRZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fof96XvqUbqNxp9YyUhGZiZjMGhtPMgVSC75oMhoWVBOiKUXr520vw2Tt0Fa/uOO+DzqPyYFRE2TDu1V+SORxVbrFfhTtV/+i/bOVncNsobNmgyXC5uVD8HAEorhcBlAIcUkAH0cH8zlFN5W7qiyU6Cqm+j/USuRV5vBe3RsuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVr9syjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAACC4CEDF;
	Wed, 12 Feb 2025 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739354896;
	bh=SZIYgUNCCnIL5V0seV/NEEb2Rim4jnuOX/CWoopZRZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVr9syjrufyTLY9xamchuxaxhtBwatQn4E5nLYGo3FDTekqf1z2gkJHayWmn9KZaJ
	 bNmP+QFDQx2oinhW1Bj8Zj+b3YdHej+ggMUb99OkAqJ08Cn0ZnMEiP6iW06TKEJA7k
	 HutHsQ865WyPlyj253gDAw15bF0gKSH/wal3TwAhWjNPV2Hm3BDwBeNpRHvvk/6isx
	 IpAoIPlguCWJeEc7sJKvTz3WzPGkRV8tk5fZJD2h8DBGZFpfQp1qNbsZNRmZjIVSQ0
	 SyZuGYTItv+KchRHitB/qEwzMHf8LMQ/7DlPxayOqcbKZ3+Oas2iu2Jhda2oPHr+y0
	 agQ0hJJV4eLlw==
Date: Wed, 12 Feb 2025 11:08:14 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Paul Kocialkowski <contact@paulk.fr>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
Message-ID: <20250212-petite-persimmon-termite-c0bce2@houat>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
 <20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
 <20250207-ingenious-daffodil-dugong-51be57@houat>
 <ucttjaf3trkgtpvhnsj7xfsybhnoi4qqow5ucwghlggivbagy7@gngjhbtu73lb>
 <20250210181244.0e3e9189@booty>
 <qnuskv4mln32nqgbgvwi2qcdwfma6tqfbq7e6sqb3za6pmms2j@ir7pt5634dsh>
 <20250211-venomous-dragon-of-competition-d76bf9@houat>
 <i5q5zuymhn6sy4nou22zxbolztqbq6soef2cwrdq3ey63vfugj@z3rv7zh7xhle>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="c2fwd2zsskly2q4c"
Content-Disposition: inline
In-Reply-To: <i5q5zuymhn6sy4nou22zxbolztqbq6soef2cwrdq3ey63vfugj@z3rv7zh7xhle>


--c2fwd2zsskly2q4c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 02:55:10AM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 11, 2025 at 09:48:31AM +0100, Maxime Ripard wrote:
> > On Tue, Feb 11, 2025 at 01:14:28AM +0200, Dmitry Baryshkov wrote:
> > > On Mon, Feb 10, 2025 at 06:12:44PM +0100, Luca Ceresoli wrote:
> > > > Hi Maxime, Dmitry
> > > >=20
> > > > On Fri, 7 Feb 2025 21:54:06 +0200
> > > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > > >=20
> > > > > > > +/* Internal function (for refcounted bridges) */
> > > > > > > +void __drm_bridge_free(struct kref *kref)
> > > > > > > +{
> > > > > > > +	struct drm_bridge *bridge =3D container_of(kref, struct drm=
_bridge, refcount);
> > > > > > > +	void *container =3D ((void *)bridge) - bridge->container_of=
fset;
> > > > > > > +
> > > > > > > +	DRM_DEBUG("bridge=3D%p, container=3D%p FREE\n", bridge, con=
tainer); =20
> > > > > >=20
> > > > > > Pointers are not really useful to track here, since they are ob=
fuscated
> > > > > > most of the time. Using the bridge device name would probably b=
e better
> > > > > > (or removing the SHOUTING DEBUG entirely :)) =20
> > > > >=20
> > > > > bridge device name or bridge funcs (I opted for the latter for the
> > > > > debugfs file)
> > > >=20
> > > > These DRM_DEBUG()s proved extremely useful exactly because of the
> > > > pointer. This is because when using hotplug one normally has the sa=
me
> > > > device added and removed multiple times, and so the device name or
> > > > bridge funcs is always the same, preventing from understanding which
> > > > instance is leaking, or being freed, get, put, etc.
> > > >=20
> > > > Do you think this is a sufficient motivation to keep it?
> > >=20
> > > Then it should be something like %px. I found that %p is mangled.
> > > What about having both device name _and_ a pointer?
> >=20
> > No, %px must not be used there. %p is mangled but should be consistent
> > across calls. But yeah, it's kind of the reason I suggested to use the
> > bridge device name instead.
>=20
> Then we need to extend struct drm_bridge with struct device *dev (which
> I would appreciate, it will solve whole hdmi_audio_dev / CEC device /
> etc story).

Let's not get carried away and start yet another side discussion here.
Most of these log messages need to be reworked anyway, so I'm sure we
can find something that wouldn't require yet another rework to argue
about.

Maxime

--c2fwd2zsskly2q4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ6xzDQAKCRAnX84Zoj2+
dkT0AYCkUL7FAvh7cyVAWf35anla6gaIPKKt7fnIaZU+CIoMLp/xlH2vfqItsVOF
V6M0p+4BgJd7VNGXdmw73nQmuc5U6UM6/Rn1xP94EajbmmZyjqxzR+xwsOjC0P2J
qhJjJSwQoQ==
=IEWS
-----END PGP SIGNATURE-----

--c2fwd2zsskly2q4c--

