Return-Path: <linux-kernel+bounces-429300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF7E9E1C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0864BB2DD09
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1385F1E32C8;
	Tue,  3 Dec 2024 10:59:07 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E301E32BD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223546; cv=none; b=BDHaH2sAPwk+3MoEq5zPXGLID2QKWclUjPBcUyVG+nVa+fpJKW4+7OcTmBUGX7h3jbrWPBXvRcF6V89PaqrNhFjc2+q6TkaNUU8X0zMO1F1EVs4IDNx+6SBxGJjrvhEqHN18rhd9fKLLxJ31AagCkhx34cDMNLMoeAZhDS+F58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223546; c=relaxed/simple;
	bh=TrK7uZHP64ILuJuDvtktXX5sjSsNufOK42wokACcQmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKZsY91qg15AqEZzY6PqnVe4DT+NcpktzQFCrozSyG7jNiE0wQ+bFlobqTNi4sKr2vwrIFkq6JDYYa5+KqMlPkka/6En6Mz6cQFDdkEaKEdzHCc02v9ioH5XKlTH78Q/4PIs0MmndD+bzYjsxc+q1Jbat4fl4IKWrq/TVRfzVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 995A11F00053
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:58:43 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 95B97A6702A; Tue,  3 Dec 2024 10:58:41 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 7392EA6701F;
	Tue,  3 Dec 2024 10:58:39 +0000 (UTC)
Date: Tue, 3 Dec 2024 11:58:37 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <Z07kXSstqc2eJ_Y9@collins>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
 <ZzzdT0wr0u1ApVgV@collins>
 <20241120-wild-stimulating-prawn-ffefb7@houat>
 <Zz20dquzl5_2_3TQ@collins>
 <20241129-amazing-whale-of-proficiency-ee6fd2@houat>
 <Z0rqILFESdje9qUn@collins>
 <20241202-magnetic-curious-bear-1cc48e@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ztuv53CEuwU4pnus"
Content-Disposition: inline
In-Reply-To: <20241202-magnetic-curious-bear-1cc48e@houat>


--Ztuv53CEuwU4pnus
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Mon 02 Dec 24, 12:03, Maxime Ripard a =C3=A9crit :
> On Sat, Nov 30, 2024 at 11:34:08AM +0100, Paul Kocialkowski wrote:
> > Well I'm an electrical engineer and the first thing we were told about
> > buttons and connectors is to include hardware debouncing. The second th=
ing
> > is that it can be done in software (which again is done in a number of =
drivers)
> > by just disabling the interrupt for a while if it happens too often.
> >=20
> > So I'm quite affirmative that taking none of these into account is cons=
titutive
> > of a broken hardware design. No electrical engineer is told that they s=
houldn't
> > care about this because the SoC will filter interrupts for them.
>=20
> The SoC provides the hardware debouncing. There's no reason not to use
> it, or to choose something redundant. Some might, but it's also
> perfectly valid to just rely on the SoC there.
>=20
> > Of course it's fine to use this mechanism when it exists, but it's not a
> > reasonable expectation to just assume it will always be there. This is =
why
> > I think it's not a legitimate reason to make it a default.
>=20
> Nobody ever designed a board without considering the SoC features but
> rather by adhering to a dogma. The SoC features, components chosen and
> their price, etc. all play a role.

Okay that's fair enough. I guess what I had in mind was that it would be
unusual and unlikely. I don't think it disqualifies the fact that it would
be sensible to enable this behavior with the property and not the other way
round though.

> > > But let me rephrase if my main objection wasn't clear enough: you want
> > > to introduce an ABI breaking change. With the possibility of breaking
> > > devices that have worked fine so far. That's not ok.
> >=20
> > I believe it is highly questionable that this constitutes ABI breakage.
> > To me there was no defined behavior in the first place, since the debou=
ncing
> > configuration is inherited either from the reset value or the boot stag=
e.
> > There is also no formal indication of what the default is, anywhere.
>=20
> Depending on the interpretation, it either means that you change the
> default, or add a default, to a device-tree property. That constitutes
> an ABI breakage on its own right. And then we can introduce regressions
> for boards, which is another breakage.

It feels very questionable that adding a default over undefined behavior
constitutes an ABI breakage.

> > Changing the default configuration of hardware is commonplace. One might
> > for example introduce a reset to a driver to get a clean state because =
it
> > happened that some boot software would mess it up and it went unnoticed=
 for
> > a while. Would you also call that ABI breakage?
>=20
> No, because it doesn't require a change in the default state Linux
> expects when it boots, or changing anything in the device tree. It's a
> self-contained change, and thus there's no interface to break.

It could definitely result in changes in behavior though. One could imagine
the case of a sensor that was configured with 4x gain by the boot software,
which wasn't reset by the driver. Now when the driver is updated to include=
 a
reset the sensor will fall back to 1x gain, with a direct result on the val=
ues
that are read with default configuration.

This would however be perfectly fine since it wasn't specified anywhere tha=
t the
sensor should report values with 4x gain in its default state. It's a behav=
ior
change that has direct effect, but doesn't break any ABI at all.

> > I think there's a number of situations where it's much more sensible to=
 change
> > a default state to avoid very visible and practical issues. And it does=
 happen.
> >=20
> > Also my understanding of the "ABI breakage" rule in the kernel is that =
no
> > userspace program should stop working when it was implemented to (corre=
ctly)
> > follow some kernel-related ABI. It doesn't mean that we cannot change a=
ny
> > default state
>=20
> If applications rely on that default one way or another, it's absolutely
> what it means. The only criteria is whether this will create a
> regression for any application.

For any application *that uses the ABI correctly*. Any example of defaults =
that
are inherited from the boot phase clearly shows that it is not a reasonable
expectation to rely on them and doing so is not correct use of the ABI.
It is rather very clearly relying on undefined behavior.

Cheers,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--Ztuv53CEuwU4pnus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmdO5F0ACgkQhP3B6o/u
lQyUwg/+Nml2dRtQHolbNr+qDMaG5j23m3wnyJzAs7oAVbOiozJpGTW9obXHhBnI
NODHxTaaXmzBce+aNqQUwGWX1W5kl9LQ1od/mOQ81k2tSwOj+DpB7sus+NXGCUCs
xszVBDQMLM2ejXsyQauTdjFUsnfq6Q91Qo0aLoWpKJI5y7vdds2Vri6eJCm2I2bW
An0ztEcJpMAPs2Bf2ubzBriStkFhPQ31qb4A5XdNKLjkwwJAAaNZ7EfvlcYDWKS0
D/2DAtIwDkmYt5wdxObQc+qP+eyv/mxdvHsybOGX2bWkjA28LiHlO+7eP65ruLbB
/9DRLMXH1fn4AqeodQGKRHVXml3EtI1kwLiRQ70IA8Ma7oFFc6KMuqwT9iS3s8sU
RK9Z85u8jUeF+8CA6o9rmJdhkjmj5wzz0ScdUMQf0lU5Agib8O1RoWdtcBIfAUjh
qNv+kbQtst87YRiy6jGX6orQjdpL8jNHzL87zNffxPXc/zZ6UTABERdExMpQira5
QtNV41U0bdT9dMfoIFoCeREGVUSziS2aXE6UZlxQIfl0I60FEBbu3uOILzpe0fLa
ErnVXnTTzmGXCK0v6alU/KxSJ96CSd8/86cLbVfuBBeUAyDztfWmsk1dTeaa2ulv
YN9witZEvaqwqV2t7LLtDYvUMtRXq6IWUI8KJMzu6y0ElGh1+Sc=
=bvwb
-----END PGP SIGNATURE-----

--Ztuv53CEuwU4pnus--

