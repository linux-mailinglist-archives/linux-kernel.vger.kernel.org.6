Return-Path: <linux-kernel+bounces-575818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14064A7078A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CB188C8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F2225EFAC;
	Tue, 25 Mar 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgosEb7T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B925C716
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922024; cv=none; b=QeGwTohfJwBAoB7Jl8oLbNVKudt1dBqkmcidH85J1jDxudMrsQw7LlGyftZOc4mEJ2orLa28weOyST43Vrtk6vLqjeVr8lb9uoDNrJc5MVv/dykhtKjHxpPqgda0dwV+on5R15csSRVY3zVicCVWBazSljdGZ+8lw8CdmDJqwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922024; c=relaxed/simple;
	bh=fMDCIrknMga52tByCYAzlgDLTGxj2rqO7TMXOqtzQTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl3jPzPXZzMEkQURFNdWhdB1haSFEo/JzhOnYPjdGtSW5hAXclJfAmSyZeGLQM7uEGyzwRC7EGdt9PqUGLwQLJWGyp5DvsnVF6k/c5kMnnCdFLizTFBOQEZahlgsd8008m00F5boDbXP8CmRq1RsyXg2BV6lWMT9rtr3pe/P2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgosEb7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C353EC4CEEA;
	Tue, 25 Mar 2025 17:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742922024;
	bh=fMDCIrknMga52tByCYAzlgDLTGxj2rqO7TMXOqtzQTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jgosEb7TUdFofoFDLjNEd3EDRk6cnWxqTccGPnhqNG6KThpdqe22/0ZCNvKHAqrZ6
	 +jMfoUUeKiqp1qdg2lE0wDlndMPhil5VDNBPCOw4823uTyGhCi2uGoh4y6KdRmasL+
	 +/+mZcenkT1sTWLI+inIZOcxaBKZCGEdgDHruP2WCqXeXIGlWu8f9bG/S8wWq2ugk6
	 Tr/NBzXEIBAZv6xg1GMAv0ajnO7xpQ80yR/r3lmaUG4MBMBc57rzm6RzucVWDD7LrV
	 I4DQ0wXi0oJx0eFM29sDvY4U7HAwFxo0sqmqHwxxY+R0+AwHG2LuWNLNtMJWrBtAOx
	 wQka+Hbk83u8Q==
Date: Tue, 25 Mar 2025 18:00:21 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: devbrones <jonas.cronholm@protonmail.com>, 
	maarten.lankhorst@linux.intel.com, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
Message-ID: <20250325-crouching-benevolent-serval-fd54b8@houat>
References: <20250322122048.28677-1-jonas.cronholm@protonmail.com>
 <875xjxa2rk.fsf@intel.com>
 <20250325-inquisitive-ebony-mouse-bdf185@houat>
 <87pli58jze.fsf@intel.com>
 <20250325-annoying-precise-uakari-6b6438@houat>
 <87h63h884t.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vutrervm6fjxn5pl"
Content-Disposition: inline
In-Reply-To: <87h63h884t.fsf@intel.com>


--vutrervm6fjxn5pl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR
 Headsets with Product ID 0xB403
MIME-Version: 1.0

On Tue, Mar 25, 2025 at 05:03:46PM +0200, Jani Nikula wrote:
> On Tue, 25 Mar 2025, Maxime Ripard <mripard@kernel.org> wrote:
> > On Tue, Mar 25, 2025 at 12:47:49PM +0200, Jani Nikula wrote:
> >> On Tue, 25 Mar 2025, Maxime Ripard <mripard@kernel.org> wrote:
> >> > On Tue, Mar 25, 2025 at 11:16:47AM +0200, Jani Nikula wrote:
> >> >> On Sat, 22 Mar 2025, devbrones <jonas.cronholm@protonmail.com> wrot=
e:
> >> >> > This fixes a bug where some Playstation VR Headsets would not be =
assigned
> >> >> > the EDID_QUIRK_NON_DESKTOP quirk, causing them to be inaccessible=
 by
> >> >> > certain software under Wayland.
> >> >>=20
> >> >> Please file a bug over at [1], and attach the EDID on that bug, so =
we
> >> >> have some clue what's going on.
> >> >>
> >> >> [1] https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/new
> >> >
> >> > I'd rather have them in the commit log. Nobody uses gitlab issues for
> >> > drm-misc, and those kind of issues are just lingering around and
> >> > becoming stale.
> >>=20
> >> For this one, it's fine as long as we preserve the raw EDID for
> >> posterity. Unless the EDID does indicate VR and we need to dig deeper,
> >> that is.
> >
> > What I was trying to say is if "posterity" means "a forever open issue
> > in drm-misc", then no, sorry, that doesn't work for me.
>=20
> I want to check the EDID before we merge the quirk.
>=20
> If the EDID does not indicate VR, we can merge. I want the EDID
> preserved so we can track them down later if we need to drop or modify
> the quirks.
>=20
> If the EDID does indicate VR, either the quirk is unnecessary or there's
> a bug somewhere. This requires further debugging, and we must not merge
> the quirk.

I understand that, but I don't see why putting it in the commit log, or
as a mail reply to the patch is not a good solution for that.

Or why using drm-misc issues for this is a good one.

Maxime

--vutrervm6fjxn5pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+LhJQAKCRDj7w1vZxhR
xf12AQCkpCIuaInNcgBVfxP39ielwCgnCH71pclDTaqRhvXwQgEAwjtHnvtxboWH
rnnPN9tQza5+KuVRKykQsWBpDDHivQk=
=Gr6x
-----END PGP SIGNATURE-----

--vutrervm6fjxn5pl--

