Return-Path: <linux-kernel+bounces-521953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8336BA3C43A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9576218882EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF171FC7F7;
	Wed, 19 Feb 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mISS3099"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504C1FAC31
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980577; cv=none; b=u+T7JqZrNGwaFneDbMH/Njl+rcxAlSKOqCJb4D0ztPVnMZLyHF/mJcQoRLlJYnQFJyNl8crV8ziU8Sn9JdiYWUdTuUkpFCdPU565RNTg8RViZWU1fWh7ubHUSxg0ckPTgE5Nn3A4bOzyQQxAjMGGBdbMs/Ej20abCaXkh74vqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980577; c=relaxed/simple;
	bh=ApwXho0m68u1DhlJYChvZUPmHHp6eWt+LncX53zYIXI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf3ur5D97OsozBsZjSMMhenj9QRnCHdChLAD1Z3QYvjRQN+n3q4k3r4hKI+WxSOZnvf1YgAqvY81P+UyvBFC8BZWW2OV8+XC8aHQCdivilXEuPV6b5Tzcx6uMSqNUdyNpG60hBP0CEYiXegPER4HeTeIv8DzzTpqm2zGUqvX3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mISS3099; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC1FC4CEDD;
	Wed, 19 Feb 2025 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739980574;
	bh=ApwXho0m68u1DhlJYChvZUPmHHp6eWt+LncX53zYIXI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=mISS30994wcIvAuOdwpjHKaL+UA+kom7ml3E5EIh5kJeQz8nu+02ClvRYzhpwDwl+
	 KdgB1zcrJXLxY15k7AzzQnEmoHySG8ZaOCuwzuf31dNESdhZ3dD1ERA8D8HH6QJnl5
	 ON/zcdKXc2B9Bhy48gfqW2jfYRvlIB1SEQbu08peTk5vMG1VWctqAqWgoU2Dif5/tK
	 wFfuh1r8Dbpb+6Jx1QCmBJjx1SBTxcnjySww9B+YsGMvseQtms/6uTOWgU999xzH4L
	 ITr9hoJm5/g5Y7bOTlDJsTng5Ojxmz5Q+cgfTrzk1kYPt+FRr8tYEGARUmfKFqYZNc
	 fgmhQ/l594oHg==
Date: Wed, 19 Feb 2025 16:56:11 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <20250219-gregarious-condor-of-prestige-a6ce0c@houat>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
 <Z7NmtF83adILfasi@phenom.ffwll.local>
 <20250218-adamant-translucent-civet-aebcc5@houat>
 <Z7XeHaTmtS8ClOV-@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jbvhtr2ze3m7ltrg"
Content-Disposition: inline
In-Reply-To: <Z7XeHaTmtS8ClOV-@phenom.ffwll.local>


--jbvhtr2ze3m7ltrg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
MIME-Version: 1.0

On Wed, Feb 19, 2025 at 02:35:25PM +0100, Simona Vetter wrote:
> On Tue, Feb 18, 2025 at 11:23:00AM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > Thanks for your answer
> >=20
> > On Mon, Feb 17, 2025 at 05:41:24PM +0100, Simona Vetter wrote:
> > > On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > > > Now that connectors are no longer necessarily created by the bridges
> > > > drivers themselves but might be created by drm_bridge_connector, it=
's
> > > > pretty hard for bridge drivers to retrieve pointers to the connecto=
r and
> > > > CRTC they are attached to.
> > > >=20
> > > > Indeed, the only way to retrieve the CRTC is to follow the drm_brid=
ge
> > > > encoder field, and then the drm_encoder crtc field, both of them be=
ing
> > > > deprecated.
> > >=20
> > > Eh, this isn't quite how this works. So unless bridges have become ve=
ry
> > > dynamic and gained flexible routing the bridge(->bridge->...)->encoder
> > > chain is static. And the crtc for an encoder you find by walking the
> > > connector states in a drm_atomic_state, finding the right one that po=
ints
> > > at your encoder, and then return the ->crtc pointer from that connect=
or
> > > state.
> > >=20
> > > It's a bit bonkers, but I think it's better to compute this than addi=
ng
> > > more pointers that potentially diverge. Unless there's a grand plan h=
ere,
> > > but then I think we want some safety checks that all the pointers nev=
er
> > > get out of sync here.
> >=20
> > That work stemed from this series
> > https://lore.kernel.org/all/20250210132620.42263-1-herve.codina@bootlin=
=2Ecom/
> >=20
> > and in particular:
> > https://lore.kernel.org/all/20250210132620.42263-5-herve.codina@bootlin=
=2Ecom/
> >=20
> > Bridges, outside of the modesetting code path, don't have a way to
> > access the drm_atomic_state since drm_bridge_state->state is typically
> > cleared after swap_state. So accessing the connectors and CRTCs don't
> > work anymore.
> >=20
> > In this particular case, we needed to access those from the bridge
> > interrupt handler.
>=20
> Uh for interrupt handler you can't use anything stored in state objects
> anyway. So I'm even more confused.

Why not? As long as we're in a threaded handler, and take the proper
locks, what's wrong with it, and how is it fundamentally different than,
idk, cec or audio hooks?

Maxime

--jbvhtr2ze3m7ltrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7X/GwAKCRAnX84Zoj2+
dovgAYDaLy95Szw0goSs4A8B0L9N2C1APQgenh1IO8cpT0qH1iB7t3rUUehtTnSu
bpGAf58BfjylaF6OuSKoohRCcH5tlLojZeEqCylL3wLusZkZsJQRDyC59YdttQHr
ABJcNZA+1w==
=RX+0
-----END PGP SIGNATURE-----

--jbvhtr2ze3m7ltrg--

