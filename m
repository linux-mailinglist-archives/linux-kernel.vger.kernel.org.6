Return-Path: <linux-kernel+bounces-184998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D998CAF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466591C21A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58726E5E8;
	Tue, 21 May 2024 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCM+jVT2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027641E4AD
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297309; cv=none; b=QgPqWivWuuo/uGBpZQ6iNtz8TJXaOWLiJVVRleo+Ihrtumosfm0WzA2bDH6uB7qkIZdkSPg/7cjUwJ1ZHbyoKwX0vlO/W0iayPLvI1MxdPbjnCi2s09Bhv3g6msODdvh93/C/7ZNgskNTJx/AQMmLn6KPULjY6uMbSq88Kmy1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297309; c=relaxed/simple;
	bh=QI3B4EYlEbIIwWwbPtpuremAcvQV29WJXPwBTfgIJY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7MidII9X6y1CRCm+cke5YCRRtOxPEUItUAPxcKtwythO9Fww5x8mW8Ivs1m4OPQ+tAVCERsSnYcUWvK5kCT2mXMVdI60GI8ZkY2R02B3JX9VI5JsbtXoo7G/i2zfWf8t/mCmOGcPL0Sbaka/ygk4ZJmt0OtOX7C54e1Adtnd+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCM+jVT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C68C2BD11;
	Tue, 21 May 2024 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716297308;
	bh=QI3B4EYlEbIIwWwbPtpuremAcvQV29WJXPwBTfgIJY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCM+jVT2fpS7ic5sXNUfre7XEVcgQcrmap8MIT2/lRVyOnGU078F/ftIGV1QFbL43
	 9kIgrxp1E3W++Y+GHNPRyOpzT1H+L86nvwUnsfYEMJjNM85PXTr1hgOnqcKEs6+fL7
	 whmVmSja6dv/Pk9tr0H/gVg8/CJpH3hAWRKghRCXRiGv8WiKChGdURIkmqB83Y+JAb
	 WTiDBNTrMDgvP9rvfiKL030y968lamnQ73C5Ke81jQUZNf14Ncfd7LO1iCTHBwGewZ
	 dftY6a7MTyEAjLiz4vjsPpLtGhOR0Lpg3TOfFpikHs0uMwUjldaiRzoEBDu2J0Ravx
	 a5mbxG3Cp7Q/Q==
Date: Tue, 21 May 2024 15:15:06 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, DRI Development List <dri-devel@lists.freedesktop.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Boris Brezillon <boris.brezillon@bootlin.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 6/7] drm/bridge: Introduce early_enable and late disable
Message-ID: <20240521-realistic-imposing-lemur-aac3ad@houat>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
 <20240511153051.1355825-7-a-bhatia1@ti.com>
 <20240516-bipedal-keen-taipan-eedbe7@penduick>
 <ba8d0b98-67d2-41e2-b568-a40543a9b0fa@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="yt2j545gywcn32mt"
Content-Disposition: inline
In-Reply-To: <ba8d0b98-67d2-41e2-b568-a40543a9b0fa@ti.com>


--yt2j545gywcn32mt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 03:10:15PM GMT, Aradhya Bhatia wrote:
> >>  	/**
> >>  	 * @pre_enable:
> >>  	 *
> >> @@ -285,6 +319,26 @@ struct drm_bridge_funcs {
> >>  	 */
> >>  	void (*enable)(struct drm_bridge *bridge);
> >> =20
> >> +	/**
> >> +	 * @atomic_early_enable:
> >> +	 *
> >> +	 * This callback should enable the bridge. It is called right before
> >> +	 * the preceding element in the display pipe is enabled. If the
> >> +	 * preceding element is a bridge this means it's called before that
> >> +	 * bridge's @atomic_early_enable. If the preceding element is a
> >> +	 * &drm_crtc it's called right before the crtc's
> >> +	 * &drm_crtc_helper_funcs.atomic_enable hook.
> >> +	 *
> >> +	 * The display pipe (i.e. clocks and timing signals) feeding this br=
idge
> >> +	 * will not yet be running when this callback is called. The bridge =
can
> >> +	 * enable the display link feeding the next bridge in the chain (if
> >> +	 * there is one) when this callback is called.
> >> +	 *
> >> +	 * The @early_enable callback is optional.
> >> +	 */
> >> +	void (*atomic_early_enable)(struct drm_bridge *bridge,
> >> +				    struct drm_bridge_state *old_bridge_state);
> >> +
> >>  	/**
> >>  	 * @atomic_pre_enable:
> >>  	 *
> >> @@ -361,6 +415,21 @@ struct drm_bridge_funcs {
> >>  	void (*atomic_post_disable)(struct drm_bridge *bridge,
> >>  				    struct drm_bridge_state *old_bridge_state);
> >> =20
> >> +	/**
> >> +	 * @atomic_late_disable:
> >> +	 *
> >> +	 * This callback should disable the bridge. It is called right after=
 the
> >> +	 * preceding element in the display pipe is disabled. If the precedi=
ng
> >> +	 * element is a bridge this means it's called after that bridge's
> >> +	 * @atomic_late_disable. If the preceding element is a &drm_crtc it's
> >> +	 * called right after the crtc's &drm_crtc_helper_funcs.atomic_disab=
le
> >> +	 * hook.
> >> +	 *
> >> +	 * The @atomic_late_disable callback is optional.
> >> +	 */
> >> +	void (*atomic_late_disable)(struct drm_bridge *bridge,
> >> +				    struct drm_bridge_state *old_bridge_state);
> >> +
> >=20
> > But more importantly, I don't quite get the use case you're trying to
> > solve here.
> >=20
> > If I got the rest of your series, the Cadence DSI bridge needs to be
> > powered up before its source is started. You can't use atomic_enable or
> > atomic_pre_enable because it would start the source before the DSI
> > bridge. Is that correct?
> >=20
>=20
> That's right. I cannot use bridge_atomic_pre_enable /
> bridge_atomic_enable here. But that's because my source is CRTC, which
> gets enabled via crtc_atomic_enable.
>=20
>=20
> > If it is, then how is it different from what
> > drm_atomic_bridge_chain_pre_enable is doing? The assumption there is
> > that it starts enabling bridges last to first, to it should be enabled
> > before anything starts.
> >=20
> > The whole bridge enabling order code starts to be a bit of a mess, so it
> > would be great if you could list all the order variations we have
> > currently, and why none work for cdns-dsi.
> >=20
>=20
> Of course! I can elaborate on the order.
>=20
> Without my patches (and given there isn't any bridge setting the
> "pre_enable_prev_first" flag) the order of enable for any single display
> chain, looks like this -
>=20
> 	crtc_enable
> =09
> 	bridge[n]_pre_enable
> 	---
> 	bridge[1]_pre_enable
>=20
> 	encoder_enable
>=20
> 	bridge[1]_enable
> 	---
> 	bridge[n]_enable
>=20
> The tidss enables at the crtc_enable level, and hence is the first
> entity with stream on. cdns-dsi doesn't stand a chance with
> bridge_atmoic_pre_enable / bridge_atmoic_enable hooks. And there is no
> bridge call happening before crtc currently.

Thanks for filling the blanks :)

I assume that since cdns-dsi is a bridge, and it only has a simple
encoder implementation, for it to receive some video signal we need to
enable the CRTC before the bridge.

If so, I think that's the original intent between the bridge pre_enable.
The original documentation had:

  pre_enable: this contains things needed to be done for the bridge
  before this contains things needed to be done for the bridge before
  this contains things needed to be done for the bridge before.

and the current one has:

  The display pipe (i.e. clocks and timing signals) feeding this bridge
  will not yet be running when this callback is called. The bridge must
  not enable the display link feeding the next bridge in the chain (if
  there is one) when this callback is called.

I would say the CRTC is such a source, even more so now that the encoder
is usually transparent, so I think we should instead move the crtc
enable call after the bridge pre_enable.

Would that work?

Maxime

--yt2j545gywcn32mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkyeVQAKCRAnX84Zoj2+
dmQTAYD+Ne1ZkY/AFqrz3EHZtn3MxFe0zkhuFwWhGF1cMmY6F1H9YKDjPnYMvc+/
KbA4a1sBfAiT5CVtjjb6RpsGYpaD8isYCkSaUl45XE9kVfLH8NxSyBtvVkQ9gRVl
SaJgX5LLXg==
=jlQ6
-----END PGP SIGNATURE-----

--yt2j545gywcn32mt--

