Return-Path: <linux-kernel+bounces-515000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE55A35E83
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19475189811C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBC263F4D;
	Fri, 14 Feb 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kayZ6cfC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9816230D1E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538398; cv=none; b=cTv2UVXzIwJqRQGZ7UJzhLxMmfUMvEG6Ck0zKAs3f0aoZ0pzcCGdh2pWt0NGV0+1Fs0gdyJikOqgqPdmIHE32Xe9AdNuAYnuZzLljEn0qLpQLk4NahEQvvyXZZgBGXp+fIcObID0WLRdtBOFTWCWL4mcfBDSD73pzOHiUYPdXcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538398; c=relaxed/simple;
	bh=+HBCtDmxM3bsjsc+153z8rtLD8IR/a5aZsysqrirBFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdtFp3B7h+/p2PvxfFsN3ydWGpw1MMiM+dRAmrNao6OBKGl7D7FAJwbifW51Vf7vhANnqsBzYLJKNORAA6n1G32yO6B2p2UwgU1ltzyXLOzalOcqv/IeKqb3qKt2lm6WICF++gzcYKjdjbEmqqADsix4gbobgWF6/Qs952G2CTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kayZ6cfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EC1C4CED1;
	Fri, 14 Feb 2025 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739538397;
	bh=+HBCtDmxM3bsjsc+153z8rtLD8IR/a5aZsysqrirBFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kayZ6cfC0J4BlHHoh8NsJDt3mu/uhpqI9/8fAdyXNpOrNNZS4MNW8cHPqtjxw8ZFS
	 qhs3re03NJkB0xxJVzPXsu4NSFuPXlxS+qo+TMgQ0ygEAyEhJ4xxMP5ZjiPfozKH9t
	 Mefpa+Jj0uVtVtSKUX8q3WZRqnm+0UW6Wx9TRSLEpJ3Jwh4hktAKKMOUPBFLrGtqXr
	 K5xyraHpmfxJDFbjl/BxmXn3n35RVrNQYyuxRaLDtudFG6HA5fcZ4DJJCWsALMAJA1
	 ZjMai+oL3dtAZ7Dt72AeRoHVAMpWc3InY5QkNsHSrucWctti2TDFtutpje5ahpCh9b
	 XvDdp0mJ54Zyg==
Date: Fri, 14 Feb 2025 14:06:34 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
Message-ID: <20250214-evasive-eel-of-piety-d59e46@houat>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-31-e71598f49c8f@kernel.org>
 <gyfchljgrqamb26sot4c26gcwupbst2zuu5fw6el5wsl6gl5xp@ruqbpsn4lpvx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="l5vd547bh5zkj7n4"
Content-Disposition: inline
In-Reply-To: <gyfchljgrqamb26sot4c26gcwupbst2zuu5fw6el5wsl6gl5xp@ruqbpsn4lpvx>


--l5vd547bh5zkj7n4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 31/37] drm/bridge: Provide pointers to the connector
 and crtc in bridge state
MIME-Version: 1.0

On Thu, Feb 13, 2025 at 06:32:39PM +0200, Dmitry Baryshkov wrote:
> On Thu, Feb 13, 2025 at 03:43:50PM +0100, Maxime Ripard wrote:
> > Now that connectors are no longer necessarily created by the bridges
> > drivers themselves but might be created by drm_bridge_connector, it's
> > pretty hard for bridge drivers to retrieve pointers to the connector and
> > CRTC they are attached to.
> >=20
> > Indeed, the only way to retrieve the CRTC is to follow the drm_bridge
> > encoder field, and then the drm_encoder crtc field, both of them being
> > deprecated.
> >=20
> > And for the connector, since we can have multiple connectors attached to
> > a CRTC, we don't really have a reliable way to get it.
>=20
> The same comment as for v2:
>=20
> It's not very precise:
>=20
>  connector =3D drm_atomic_get_new_connector_for_encoder(state, bridge->en=
coder);
>=20
> Is that unreliable somehow?

Then I'm not sure what you want here (and in v2) either. Do you want me
to drop this patch because it's redundant, drop it, something else?

Maxime

--l5vd547bh5zkj7n4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ68/2gAKCRAnX84Zoj2+
dhpvAYDrzil8TfZOQ7NkCln+BWZOVEAG3Kg6TzXmORNQDdKVya1lkq55HF4gIxYI
koOGeVABf1ySnHSKltS3DOGWJ3R8DTtX2FesBCEpLAW+uUDsddcdWgZVreOzgmok
l4tr2GTj7w==
=8XRK
-----END PGP SIGNATURE-----

--l5vd547bh5zkj7n4--

