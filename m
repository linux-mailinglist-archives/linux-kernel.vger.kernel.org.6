Return-Path: <linux-kernel+bounces-564587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330AA657DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CDD16596A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFD516F8F5;
	Mon, 17 Mar 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQcPL0co"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60119C553
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228567; cv=none; b=TuXRlgk9De3Ch/1iBUF7C0Wtsw6Eya/kDQ6sD6WU5dWmvMQPdg5fVS6eCpQKjsK72rmFv1GXxaBIfUr6mFmotHh4RpF7/wiJ106utw1yqONnXF48XGtZ9EDcQvlDmrT60dnBoja9BoBNbIhFOUO/TbHbD/cktNAdbthD4VIzzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228567; c=relaxed/simple;
	bh=s6qZaIWfbpuYHM9fDm/CBBB0GDfmSI/r+3DgSwSfXOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tyfm7FY8bx0nWG0cT2rm7p0TjEI1d7Rvu0wGM9yDSd3njk+qjLPJWxjWzWohBIUzvdVm1yBfKNRw91wUjZarPfQrP7OKpPLpKV9fYXPTS9KnW0LOWq/cirfROJIn9G3zgRnqjcgJDjqang3gS3+dXqoxVCeWz9+DmKp/PdgPgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQcPL0co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F25C4CEE3;
	Mon, 17 Mar 2025 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228566;
	bh=s6qZaIWfbpuYHM9fDm/CBBB0GDfmSI/r+3DgSwSfXOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQcPL0co2tM3Rr5IHRgOYccbK5u/jAnXuhIsYMtMeg4vY6FvitEfvV7oYdYy6MSOQ
	 cR0QrmxQR0NQMHklyPvW3QYYE8vZuDloyox2kOar+C3HY1t8TH83gdY+ieslRuE0qR
	 WpaMp4H1/IKq8RE//H0rUBXUt4zGVK9ro8zZSbV1Ilf0Emr7NQFDrkNy9kXyuSd2aC
	 dtobIvOQx6Nlbm7mz5fwP9jpzRFH+D2cf7MFxIwg9PY6zORuuq06mqBjn3TJ1UUQvB
	 APQT85T1CY5htD9nAmZ8c3CdYUEnYwH1CHbdfHhsJUsOfDcdS9JxiLJFGYdICVgp4b
	 YwX0cINymcGOQ==
Date: Mon, 17 Mar 2025 17:22:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: David Turner <david.turner@raspberrypi.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v3 1/2] drm/vc4: hdmi: Call HDMI hotplug helper on
 disconnect
Message-ID: <20250317-cornflower-tortoise-of-stamina-7aa54b@houat>
References: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
 <20250312-vc4_hotplug-v3-1-d75878677de8@raspberrypi.com>
 <20250314-armored-tourmaline-lizard-cee8d8@houat>
 <CACXvZi-3mkusGHkZTz=kDo8WcNQZR1A3bddajh+CFT6tQxJSCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="73vu6btskupebdod"
Content-Disposition: inline
In-Reply-To: <CACXvZi-3mkusGHkZTz=kDo8WcNQZR1A3bddajh+CFT6tQxJSCQ@mail.gmail.com>


--73vu6btskupebdod
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] drm/vc4: hdmi: Call HDMI hotplug helper on
 disconnect
MIME-Version: 1.0

On Mon, Mar 17, 2025 at 02:37:03PM +0000, David Turner wrote:
> Hi Maxime,
>=20
> Thanks for the reviews.
>=20
> On Fri, 14 Mar 2025 at 13:33, Maxime Ripard <mripard@kernel.org> wrote:
> > I also think that it's wrong, it's not just about audio. It just needs
> > to be called as part of detect no matter what the status is. Audio is
> > one thing that it will possibly handle depending on the driver, but
> > EDIDs, CEC, etc. might also be dealt with. So I don't think it's right
> > to focus on audio there.
>=20
> Does this wording sound ok?
>=20
>  * This function should be called as a part of the .detect() / .detect_ct=
x()
>  * callbacks for all status changes in order to update the HDMI-specific
>  * connector's data.

I'd drop everything after "in order to..." but yeah, it's much better, than=
ks!
Maxime

--73vu6btskupebdod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ9hMUwAKCRAnX84Zoj2+
djGqAX4/gUi98JP158YvaGceGCpedaNvz9KsGCn2H4aeEyaBMHrsZIM/Kjihdup4
dHAPX6wBfjUGBjXofkWZ86njUu2JdB90PJMzsemdXyNZbP0obeSZwQCtr4Qe/Cph
0IMwqPrINg==
=Xk0X
-----END PGP SIGNATURE-----

--73vu6btskupebdod--

