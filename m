Return-Path: <linux-kernel+bounces-535928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0685A4795D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0674C3B3B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EAA2288FE;
	Thu, 27 Feb 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBdUalSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F861227EAC;
	Thu, 27 Feb 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648744; cv=none; b=THAM8yAN6xDoIsSbUKOAr7MY5qAgnkB3Gh/ohhgKt9vYnZq/oXglDXj+8H4SpS+/gYfFyrVnpt+11H7RMTGb3T3iXFXGriV/2em2LJ4lVpi0OzZefc1/DmQpch3tYUZUbC5A+5Gl2sueXzVrtffDnpB/Uu2Ipai/KRDhoXW+prE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648744; c=relaxed/simple;
	bh=5MNjAbAl4fq6g53JUWJsJzNozHy0lxgqYwA7jNUEmtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMRoerd1T5fsD4ZNQb4UPWM/uRjMM2h91VOVHkJK9/Eupxq/lMc7pblTSkxCBjR6ioimWwBIVb60jE0uFnGAmcZrpCU93OuJvTNWzQyBdU4hax0T7R300tTEc9b427NTjrMOjrfrQLT7YT4/meG9VcDkkpYhqh3fUB6KOG6y2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBdUalSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204F9C4CEDD;
	Thu, 27 Feb 2025 09:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740648743;
	bh=5MNjAbAl4fq6g53JUWJsJzNozHy0lxgqYwA7jNUEmtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBdUalSSz94olOqrDU0Rw3cVMKA5bNW+HF7LQQXNYIZlbVkXAURmoKovc3RQdDTpn
	 Sahs5l3xeGIJvcru9uX97A07H9+JfmChDZRwmFpoNUzhY/whhjiLCAg2nJoseqjL/r
	 m8tn7rfPSp/qjYWWX9kUZ0DPhOTeXWKRdvyOVB+JQIqyl2t+lH6/JLegCWrvnVQCHn
	 sKNW97Q+mNWXaNMs8uIMKUKLvXfR85loCdZIVwihoCUJAHzjoSkrWkWqy7L3XyPaUU
	 sBzBZQL93A8fTIGHNUras/ZHSOXQSyttEBHC9gnZTmsjNjMf2LT8lxTBgvZja5n6hZ
	 XY6qZ2lp2Gmuw==
Date: Thu, 27 Feb 2025 10:32:20 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Daniel Thompson <danielt@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Paul Kocialkowski <contact@paulk.fr>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
Message-ID: <20250227-savvy-monumental-toucan-edffe2@houat>
References: <20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com>
 <20250206-hotplug-drm-bridge-v6-14-9d6f2c9c3058@bootlin.com>
 <20250207-ingenious-daffodil-dugong-51be57@houat>
 <20250210181252.5ee028d4@booty>
 <20250211-merciful-nyala-of-justice-a4fabb@houat>
 <20250226152813.4a1ad218@booty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="dfdgpsludo7guwgc"
Content-Disposition: inline
In-Reply-To: <20250226152813.4a1ad218@booty>


--dfdgpsludo7guwgc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 14/26] drm/bridge: add support for refcounted DRM
 bridges
MIME-Version: 1.0

On Wed, Feb 26, 2025 at 03:28:13PM +0100, Luca Ceresoli wrote:
> On Tue, 11 Feb 2025 14:10:50 +0100
> Maxime Ripard <mripard@kernel.org> wrote:
> > On Mon, Feb 10, 2025 at 06:12:52PM +0100, Luca Ceresoli wrote:
> > > On Fri, 7 Feb 2025 12:47:51 +0100
> > > Maxime Ripard <mripard@kernel.org> wrote:
> > >  =20
> > > > > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > > > > index ad7ba444a13e5ecf16f996de3742e4ac67dc21f1..43cef0f6ccd36034f=
64ad2babfebea62db1d9e43 100644
> > > > > --- a/include/drm/drm_bridge.h
> > > > > +++ b/include/drm/drm_bridge.h
> > > > > @@ -31,6 +31,7 @@
> > > > >  #include <drm/drm_encoder.h>
> > > > >  #include <drm/drm_mode_object.h>
> > > > >  #include <drm/drm_modes.h>
> > > > > +#include <drm/drm_print.h>
> > > > > =20
> > > > >  struct device_node;
> > > > > =20
> > > > > @@ -863,6 +864,22 @@ struct drm_bridge {
> > > > >  	const struct drm_bridge_timings *timings;
> > > > >  	/** @funcs: control functions */
> > > > >  	const struct drm_bridge_funcs *funcs;
> > > > > +
> > > > > +	/**
> > > > > +	 * @container_offset: Offset of this struct within the container
> > > > > +	 * struct embedding it. Used for refcounted bridges to free the
> > > > > +	 * embeddeing struct when the refcount drops to zero. Unused on
> > > > > +	 * legacy bridges.
> > > > > +	 */
> > > > > +	size_t container_offset;   =20
> > > >=20
> > > > This shouldn't be in there. You can create an intermediate structur=
e and
> > > > store both pointers for the action to consume. =20
> > >=20
> > > You mean to store container_offset + refcount + is_refcounted? =20
> >=20
> > No, I meant for the private structure pointer and the drm_bridge
> > pointer. refcount should be in drm_bridge, and I think is_refcounted
> > should be dropped.
>=20
> Storing the container pointer instead of the offset is a good idea, it
> will allow to get rid of is_refcounted: drm_bridge_is_refcounted() can
> just return "container !=3D NULL" instead of "bridge->is_refcounted". So
> far so good.

Again, I don't think the whole is_refcounted thing is a good idea. Once
we have the right API, we should convert all bridges to the new
allocation and assume that they are refcounted.

> I'm not sure about the intermediate struct you have in mind though.
>=20
> Do you mean:
>=20
> struct drm_bridge_pointers {
>     struct drm_bridge *bridge;
>     void              *container;
> }
>=20
> ?

Yes

> If that's what you mean, should it be embedded in drm_struct or
> allocated separately?

Separately, but still as part of the bridge allocation function.

> If you mean to embed that struct in drm_bridge, then I the drm_bridge
> pointer inside the intermediate struct would be useless.
>=20
> If instead you mean to embed it in drm_struct: I'm not sure I see much
> benefit except maybe not exposing the container pointer to drm_bridge
> users, but I see a drawbacks: at the last put we need to find the
> container pointer to free from a struct kref pointer, which can work
> only if the container pointer is in the same struct as struct kref.

Yeah, that's true. Storing the container pointer in drm_bridge makes
sense to solve this.

I'm still not sure why we need the container offset though: if we have a
bridge and container pointer, then the offset is bridge - container, so
there's no point in storing it, right?

Maxime

--dfdgpsludo7guwgc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ8AxJAAKCRAnX84Zoj2+
dsUUAX0Xxg2iIgwuaxtZwjtxFd46vyTrOtN+YPw9iz5R3BpZftRillij5tLub5PD
xL/MSucBfA/oFAKN4+mbZfJTb26QK8zau3RtslBEbH3sp+gHU1I5Rcyle08ZtMS9
W2Wo0G3KCQ==
=6jsA
-----END PGP SIGNATURE-----

--dfdgpsludo7guwgc--

