Return-Path: <linux-kernel+bounces-185327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50A8CB386
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACC82832D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8FA148FF1;
	Tue, 21 May 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWsp6MCx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C57C0A3;
	Tue, 21 May 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316317; cv=none; b=OKIVX4+Wa3n44sfIrMki+lC9z2L41UV5dRK1I9sugl7f1rTi+5EiBfiXB66skLcCcMxL9adrQrcFJYcEOyrfpzG2AsOj7hOf/U1JZ6wgVngq2cs2JFnWsEdKYz8rMTzMmQC+lhapMLMOV0MDhwcLiPXBVZANVV4uwK7C7Dzlk4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316317; c=relaxed/simple;
	bh=73vaEc2+Ila3l2dDk9+94NR4FaAuj1CJocbODWzqAFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3mKLRGfY3P79ScxyaQSvlmJfNVvcSeBbosLBGbNV2/WUSPQCpf2RFQJQRy4mkOiHFJ+Sstal6LuHhHtAQhmHUjf8w9Ko36F5qgT/C9xWAnFiqir95m4BIx9QCzxD2gQ2W9YfuEkK3K9K1C08jn97x5Xjd4TsnTGi5bROjARLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWsp6MCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C90C2BD11;
	Tue, 21 May 2024 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316317;
	bh=73vaEc2+Ila3l2dDk9+94NR4FaAuj1CJocbODWzqAFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWsp6MCxzQpqz5SpHf3xVk0D/9iv7MMU9rMvhEOxMl8R74bdHXIcV+reNkhyrWM6c
	 Z+aKJdfkvC1tS1A5kHVg6Yc0FjFl2SFERlC8So7+BWuBo//ANiyD6mZW5jkDHvjxiw
	 EY0mTzmtEVh/3/7h+O7tNPpwgkgvOh5vYmMLbHm3dEz6DOaloLqtmq4uNT2Pr6PrMY
	 EH06i/oI6jaZP8XLtEuRrDXB6Bpuu3waTR630XnR6ozYIV0ngU9xfgIJrT9u0vnsBt
	 3530qbHyqCQ0vS193WSOHgHQtCdDHqp2qhMBe5A8Uj0JqyM1eP9YGUJDWF2oY99oK4
	 iLyTMBabjaydQ==
Date: Tue, 21 May 2024 19:31:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Message-ID: <20240521-silver-exciting-bb3725dc495d@spud>
References: <20240514152328.21415-1-detlev.casanova@collabora.com>
 <20240515-risk-exes-13db315da6bb@spud>
 <2182693.irdbgypaU6@diego>
 <13628421.uLZWGnKmhe@arisu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r8AEGgMh3QAZNC29"
Content-Disposition: inline
In-Reply-To: <13628421.uLZWGnKmhe@arisu>


--r8AEGgMh3QAZNC29
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 01:15:46PM -0400, Detlev Casanova wrote:
> On Wednesday, May 15, 2024 12:33:22 P.M. EDT Heiko St=FCbner wrote:
> > Am Mittwoch, 15. Mai 2024, 18:19:29 CEST schrieb Conor Dooley:
> > > On Tue, May 14, 2024 at 11:19:47AM -0400, Detlev Casanova wrote:
> > > > Add the documentation for VOP2 video ports reset clocks.
> > > > One reset can be set per video port.
> > > >=20
> > > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > >=20
> > > Are these resets valid for all VOPs or just the one on 3588?
> >=20
> > Not in that form.
> > I.e. rk3588 has 4 video-ports (0-3), while rk3568 has 3 (0-2).
> >=20
> > So the binding should take into account that rk3568 also has the
> > SRST_VOP0 ... SRST_VOP2.
>=20
> That is what is set in the example and the reason why I set minItems to 3=
 in=20
> the main bindings.
> Then, the rk3588 specific part sets it to 4.
>=20
> Isn't that enough ?

Not quite - you need to restrict maxItems to 3 for the other devices if
the clocks are not valid. What you've got says that 4 clocks are
possible but not needed on !rk3588.

Cheers,
Conor.

--r8AEGgMh3QAZNC29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkzolwAKCRB4tDGHoIJi
0n6OAP4wwXEM/mpcp22FOi2YHaUbxut8mO+9Vbudzw42lFwLEAD+LZI8reFtSZ0L
4FVV8PWuTYl0PJwEL+Xc2KHa7boG/AE=
=rTte
-----END PGP SIGNATURE-----

--r8AEGgMh3QAZNC29--

