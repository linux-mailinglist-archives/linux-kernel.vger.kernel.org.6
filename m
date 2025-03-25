Return-Path: <linux-kernel+bounces-575182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946DA6EF85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DA53B5CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8F6255252;
	Tue, 25 Mar 2025 11:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+2sfBMf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EF33EC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900962; cv=none; b=kfvOw20osMKK148A1lHRCuV8qGkjFZ6aY1GmQOekYmanKTncfaUU3P46mcUSCcp+zUsxHWui6efy7HRy0bcpb6pt5LCP9wsyJCtQLRIY70t6lX6EWYJjuKB0raECpR0T7PWZGMee42g0R9SvIZs30eqpGMAFez8IGtMDW3KQDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900962; c=relaxed/simple;
	bh=CobmH/0tT3JWCF0SNaF4cBzmKPSqoD1qNh/T1HNEiOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2CGb9w9eKCWFMA2HbxnI3I6N+rn3IOohe7lZ68awajoXgDqnMZLdqLRp6nVHR1JH4CoTQM+G1ru0kt2irofwYEYnKbT6Zs9FH15SBtx6vL2ZRC9l8sJAOxbTAZK/VXuG0v/hwvdaZViQ3uuuFqg1ZctY2ry9zl8NkamnHcWeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+2sfBMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DF8C4CEE4;
	Tue, 25 Mar 2025 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742900962;
	bh=CobmH/0tT3JWCF0SNaF4cBzmKPSqoD1qNh/T1HNEiOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+2sfBMfnmR8JC0dpPXvhhWNDDavpjxM4l26E2TvzZEqPvR3E9bNTc3jJhflVQGrt
	 yxjctszY4G7Mt1u+nhj5FhbV/Ru4GUDCUBVp4XjByEoJq8DfDUaZMlBWBWFxfkzTUJ
	 UoPcW8MJU2+Es2tAxSkOXkeAVgaN5iAJXQvQKli3rTYJllPZT6dVasV6TXmE+Pt6o6
	 PMpHfCNY/cD4TwoP0KhEOERvp1Y5rIMVy2tK5Ubhm31WmbMs08BxjCTyE8jWr9GrxL
	 HZb69P3XabAA/LKlPDNTH37VP8dKzo56fWtJ2nFrDLOk5Jft7qUzWtGxvj2nRs80ST
	 99S73U2Hx+LMg==
Date: Tue, 25 Mar 2025 12:09:19 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: devbrones <jonas.cronholm@protonmail.com>, 
	maarten.lankhorst@linux.intel.com, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
Message-ID: <20250325-annoying-precise-uakari-6b6438@houat>
References: <20250322122048.28677-1-jonas.cronholm@protonmail.com>
 <875xjxa2rk.fsf@intel.com>
 <20250325-inquisitive-ebony-mouse-bdf185@houat>
 <87pli58jze.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pz5nibo4epaozvmu"
Content-Disposition: inline
In-Reply-To: <87pli58jze.fsf@intel.com>


--pz5nibo4epaozvmu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 12:47:49PM +0200, Jani Nikula wrote:
> On Tue, 25 Mar 2025, Maxime Ripard <mripard@kernel.org> wrote:
> > On Tue, Mar 25, 2025 at 11:16:47AM +0200, Jani Nikula wrote:
> >> On Sat, 22 Mar 2025, devbrones <jonas.cronholm@protonmail.com> wrote:
> >> > This fixes a bug where some Playstation VR Headsets would not be ass=
igned
> >> > the EDID_QUIRK_NON_DESKTOP quirk, causing them to be inaccessible by
> >> > certain software under Wayland.
> >>=20
> >> Please file a bug over at [1], and attach the EDID on that bug, so we
> >> have some clue what's going on.
> >>
> >> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/new
> >
> > I'd rather have them in the commit log. Nobody uses gitlab issues for
> > drm-misc, and those kind of issues are just lingering around and
> > becoming stale.
>=20
> For this one, it's fine as long as we preserve the raw EDID for
> posterity. Unless the EDID does indicate VR and we need to dig deeper,
> that is.

What I was trying to say is if "posterity" means "a forever open issue
in drm-misc", then no, sorry, that doesn't work for me.

Maxime

--pz5nibo4epaozvmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ+KO2gAKCRAnX84Zoj2+
dsU5AYCGaizukwDkQEQG1RR3QR9GHy/MuKJeY6AUltgq5hCHsaHXBRbBlbIqybM+
WZxBwqIBf3ZcvcQq+0aax2qhHJWpLBh64CC4/I06GVvaPqRNhkFT8Dk2BiUInaee
okpbQcELeQ==
=SVyr
-----END PGP SIGNATURE-----

--pz5nibo4epaozvmu--

