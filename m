Return-Path: <linux-kernel+bounces-414566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3E9D2A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE9B282317
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391E31D131F;
	Tue, 19 Nov 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnjbVoaa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441C1CC161;
	Tue, 19 Nov 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031032; cv=none; b=uZseiwTTCRmbCF5NHEXSsnThYwMO7Gi5VPPCnOwRBAYw/JpxYtCaXB/ElW4e3eJABYc/VPKIxX70PUTdhPbk29sTR9HIrAYjpW88QZapTZwteiWiik77dpJ4F5o+C6Xn23dMTM+QCX5QU/0aNIUpU1eRxEqhIrVPQzrAPN9YmfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031032; c=relaxed/simple;
	bh=CECoxezUYafx0d26HXgDwD1dl9DFkiisNtmVFn2OYyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqXWBs/9bgUePancUrM3o0WGjulZoOYb/CKJdTK6ZxCbw7PHfLWTff+3BXMveh0L4M2dcuat8xtCfF1O8Ptcfjqsl1xAhlVQ4CCHsktIgK5gElMelYBf/d8u1c0QJOnFZ1I28Cn3plGyaiofpM/gjxjgRS0s3Sw25isKO//yWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnjbVoaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B58C4CECF;
	Tue, 19 Nov 2024 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732031032;
	bh=CECoxezUYafx0d26HXgDwD1dl9DFkiisNtmVFn2OYyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnjbVoaawrVemEyB9fOP4Psg6A6NszoeHZLrAoptoUkIfNXmORulvI4A9US32oRjm
	 dYS9gco728411BliZWaAgswKvPhqvpook0Zapyz5pu2drbnxNI7f73bgSbccZph7cD
	 w11pN00D428g+SCnG4P0pNS8Q/hvPEkgd9RJHVhR3TW2MQafLvCndi1daU/YavsIZO
	 olXxj7OsYsr9bTaFpG0fzj7OuOmQSKwSIdLg4BPF1sYsHqBOjV9E5vq+RoWB2FrkjE
	 x4fn/aCHExEUOZojfxyRziZ/LVucAOhxmXYazUs7/2PL8wzVfFZf5yDtZgjj/0oQvO
	 f74O4+S4CHVvQ==
Date: Tue, 19 Nov 2024 16:43:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="l2xikqg7suvl7kdm"
Content-Disposition: inline
In-Reply-To: <ZzyoIABRArkGoZBn@collins>


--l2xikqg7suvl7kdm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
MIME-Version: 1.0

On Tue, Nov 19, 2024 at 04:00:48PM +0100, Paul Kocialkowski wrote:
> Hi Maxime,
>=20
> Le Tue 19 Nov 24, 15:43, Maxime Ripard a =E9crit :
> > On Tue, Nov 19, 2024 at 03:08:05PM +0100, Paul Kocialkowski wrote:
> > > From: Paul Kocialkowski <contact@paulk.fr>
> > >=20
> > > The sunxi external interrupts (available from GPIO pins) come with a
> > > built-in debouncing mechanism that cannot be disabled. It can be
> > > configured to use either the low-frequency oscillator (32 KHz) or the
> > > high-frequency oscillator (24 MHz), with a pre-scaler.
> > >=20
> > > The pinctrl code supports an input-debounce device-tree property to s=
et
> > > a specific debouncing period and choose which clock source is most
> > > relevant. However the property is specified in microseconds, which is
> > > longer than the minimal period achievable from the high-frequency
> > > oscillator without a pre-scaler.
> >=20
> > That can be fixed by introducing a new property with a ns resolution.
>=20
> Sure but my point here is rather about what should be default behavior.
>=20
> The issue I had will remain unsolved by default even with a new property,
> since people will still need to patch their device-tree to apply it.
>=20
> > > When the property is missing, the reset configuration is kept, which
> > > selects the low-frequency oscillator without pre-scaling. This severe=
ly
> > > limits the possible interrupt periods that can be detected.
> > >=20
> > > Instead of keeping this default, use the minimal debouncing period fr=
om
> > > the high-frequency oscillator without a pre-scaler to allow the large=
st
> > > possible range of interrupt periods.
> > >=20
> > > This issue was encountered with a peripheral that generates active-low
> > > interrupts for 1 us. No interrupt was detected with the default setup,
> > > while it is now correctly detected with this change.
> >=20
> > I don't think it's wise. If the debouncing is kept as is, the worst case
> > scenario is the one you had: a device doesn't work, you change it,
> > everything works.
>=20
> I think this worst-case scenario is very bad and not what people will
> expect. In addition it is difficult to debug the issue without specific
> knowledge about the SoC.
>
> My use-case here was hooking up a sparkfun sensor board by the way,
> not some very advanced corner-case.

Are you really arguing that a single sparkfun sensor not working is a
worse outcome than the system not booting?

> > If we set it up as fast as it can however, then our risk becomes
> > thousands of spurious interrupts, which is much more detrimental to the
> > system.
>=20
> Keep in mind that this only concerns external GPIO-based interrupts,
> which have to be explicitely hooked to a device. If a device or circuit
> does generate such spurious interrupts, I think it makes sense that it
> would be reflected by default.

I mean... debouncing is here for a reason. Any hardware button will
generate plenty of interrupts when you press it precisely because it
bounces.

> Also the notion of spurious interrupt is pretty vague. Having lots of
> interrupts happening may be the desired behavior in many cases.

Which cases?

> In any case I don't think it makes sense for the platform code to impose
> what a reasonable period for interrupts is (especially with such a large
> period as default).

So you don't think it makes sense for the platform code to impose a
reasonable period, so you want to impose a (more, obviously) reasonable
period?

If anything, the status quo doesn't impose anything, it just rolls with
the hardware default. Yours would impose one though.

> Some drivers also have mechanisms to detect spurious interrupts based
> on their specific use case.
>=20
> > And that's without accounting the fact that devices might have relied on
> > that default for years
>=20
> They definitely shouldn't have. This feels much closer to a bug, and rely=
ing
> on a bug not being fixed is not a reasonable expectation.

No, it's not a bug, really. It might be inconvenient to you, and that's
fine, but it's definitely not a bug.

Maxime

--l2xikqg7suvl7kdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZzyyNAAKCRAnX84Zoj2+
dmqPAYCz3OlaegQIjO8q5Z1cDBAWz7oPwfWFGo/q0gFfV22l/VsEDJ0mPduztKMZ
LA/MqcYBgNoS/NtqeAuvUfzbpwVfY3mU2cnb2T+WgMNeI6ZX1krA1GRWcKXbB75e
NaJriFIirA==
=C1nd
-----END PGP SIGNATURE-----

--l2xikqg7suvl7kdm--

