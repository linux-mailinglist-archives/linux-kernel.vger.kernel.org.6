Return-Path: <linux-kernel+bounces-427306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ABC9DFF9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A51DCB24016
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB051FC7E7;
	Mon,  2 Dec 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnao6/1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C161F9EA4;
	Mon,  2 Dec 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137423; cv=none; b=P8VdqQiUBKgj8yAQDQ2+91pL2D7jX3z9Pc8bY43mpBaIiNsF3qAaVDWQdyWOuzSX/7ZuDARkCEkSFFQWZ16VrpAjiOsq1aLc/tSNY23MF/zugMJNczZSpboAMsbdJ37h5tU5oEByWq9RtuwpwKzUS0IavatvuR2VYZRKck0reuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137423; c=relaxed/simple;
	bh=ASa3m08qUJJzx/CkZxXi2bS9QogDhirKkzyYhtJe3go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9S40qgfqH0vBmfFPBvKDXzhvSfpmp4IyWxwEZt1C3uqqdG58lLm0Fs3E+TBephk4YFBKEwDyShkRisnCAeetZ/sEvSeoE6aqOp78d7NJn8ft9EdDwlG4yuRU2bb3EuT6w82Bmfm+DNXvkfIjnE+0SpDNIhuGEajygIfERKwrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnao6/1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD8CC4CED1;
	Mon,  2 Dec 2024 11:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733137423;
	bh=ASa3m08qUJJzx/CkZxXi2bS9QogDhirKkzyYhtJe3go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lnao6/1VwaWZVmtG192hq1NdLwiouRyR5TQs9OkySAVRKuWa4HtPw2rk95QESRBd0
	 5RfMnqvUZwesvmkdqhX5ILou+eVdZlOoNWSqwl3+jSAe0i9XuP+3nYUbAXEnIGUInp
	 gLALbSYOYyhKeRuNtLtDo9h/7q28zEDO6RcxUGDxnkqKf9X16VJLQvI/hEJwgE4DhV
	 fCbzsYH2qZL9qytt3mT68yv6/cjtqIUr4Li2cdcSiFDuAM3qUNYidslXYxHbKEMuOA
	 IAQKu008kKVz3nUm1pV7Jw/HB/d1LGJmOERhvMcaHexhPr5NF+lwT+twMO6zdQpeWg
	 g+LEZRWJJgj5g==
Date: Mon, 2 Dec 2024 12:03:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Message-ID: <20241202-magnetic-curious-bear-1cc48e@houat>
References: <20241119140805.3345412-1-paulk@sys-base.io>
 <20241119-prudent-jasmine-lizard-195cef@houat>
 <ZzyoIABRArkGoZBn@collins>
 <20241119-vivacious-optimistic-squirrel-a2f3c5@houat>
 <ZzzdT0wr0u1ApVgV@collins>
 <20241120-wild-stimulating-prawn-ffefb7@houat>
 <Zz20dquzl5_2_3TQ@collins>
 <20241129-amazing-whale-of-proficiency-ee6fd2@houat>
 <Z0rqILFESdje9qUn@collins>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7vib2wfrmfkzpfdq"
Content-Disposition: inline
In-Reply-To: <Z0rqILFESdje9qUn@collins>


--7vib2wfrmfkzpfdq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
MIME-Version: 1.0

On Sat, Nov 30, 2024 at 11:34:08AM +0100, Paul Kocialkowski wrote:
> Hi Maxime,
>=20
> Le Fri 29 Nov 24, 16:37, Maxime Ripard a =E9crit :
> > On Wed, Nov 20, 2024 at 11:05:42AM +0100, Paul Kocialkowski wrote:
> > > Le Wed 20 Nov 24, 09:01, Maxime Ripard a =E9crit :
> > > > > > If anything, the status quo doesn't impose anything, it just ro=
lls with
> > > > > > the hardware default. Yours would impose one though.
> > > > >=20
> > > > > The result is that it puts a strong limitation and breaks many us=
e cases by
> > > > > default. I don't think we have to accept whatever register defaul=
t was chosen
> > > > > by hardware engineers as the most sensible default choice and pre=
tend that this
> > > > > is not a policy decision.
> > > >=20
> > > > You're making it much worse than it is. It doesn't "break many use
> > > > cases" it broke one, by default, with a supported way to unbreak it=
, in
> > > > 12 years.
> > >=20
> > > I think this is exaggerated. Like I mentioned previously there are *m=
any*
> > > situations that are not covered by the default.
> >=20
> > Note that this statement would be true for any default. The current, the
> > one you suggest, or any other really. The fact that we have a way to
> > override it is an acknowledgement that it's not a one size fits all
> > situation.
>=20
> Again the debate is about which option has the best advantages over
> disadvantages. I'm not saying the default I suggest has no issues, but
> rather that the benefits very clearly outweight the issues. Hence the many
> situations that would be supported with the shortest debouncing period (b=
oth
> short and frequent interrupts) versus the few broken-hardware use-cases
> (related to interrupt storms) support with the largest period.
>=20
> > > The fact that I'm the first person to bring it up in 12 years doesn't
> > > change that.
> >=20
> > Sure. It does however hint that it seems like it's a sane enough
> > default.
>=20
> Or maybe people didn't realize this mechanism existed, failed to understa=
nd
> why their device didn't work with Allwinner platforms and just moved on to
> use something else. Indeed it's all very subjective interpretation.
>=20
> > > Sofar the downside you brought up boils down to: badly-designed
> > > hardware may have relied on this mechanism to avoid interrupt storms
> > > that could prevent the system from booting.
> >=20
> > It's not about good or bad design. Buttons bounce, HPD signals bounce,
> > it's just the world we live in.
>=20
> Well I'm an electrical engineer and the first thing we were told about
> buttons and connectors is to include hardware debouncing. The second thing
> is that it can be done in software (which again is done in a number of dr=
ivers)
> by just disabling the interrupt for a while if it happens too often.
>=20
> So I'm quite affirmative that taking none of these into account is consti=
tutive
> of a broken hardware design. No electrical engineer is told that they sho=
uldn't
> care about this because the SoC will filter interrupts for them.

The SoC provides the hardware debouncing. There's no reason not to use
it, or to choose something redundant. Some might, but it's also
perfectly valid to just rely on the SoC there.

> Of course it's fine to use this mechanism when it exists, but it's not a
> reasonable expectation to just assume it will always be there. This is why
> I think it's not a legitimate reason to make it a default.

Nobody ever designed a board without considering the SoC features but
rather by adhering to a dogma. The SoC features, components chosen and
their price, etc. all play a role.

> > But let me rephrase if my main objection wasn't clear enough: you want
> > to introduce an ABI breaking change. With the possibility of breaking
> > devices that have worked fine so far. That's not ok.
>=20
> I believe it is highly questionable that this constitutes ABI breakage.
> To me there was no defined behavior in the first place, since the debounc=
ing
> configuration is inherited either from the reset value or the boot stage.
> There is also no formal indication of what the default is, anywhere.

Depending on the interpretation, it either means that you change the
default, or add a default, to a device-tree property. That constitutes
an ABI breakage on its own right. And then we can introduce regressions
for boards, which is another breakage.

> Changing the default configuration of hardware is commonplace. One might
> for example introduce a reset to a driver to get a clean state because it
> happened that some boot software would mess it up and it went unnoticed f=
or
> a while. Would you also call that ABI breakage?

No, because it doesn't require a change in the default state Linux
expects when it boots, or changing anything in the device tree. It's a
self-contained change, and thus there's no interface to break.

> I think there's a number of situations where it's much more sensible to c=
hange
> a default state to avoid very visible and practical issues. And it does h=
appen.
>=20
> Also my understanding of the "ABI breakage" rule in the kernel is that no
> userspace program should stop working when it was implemented to (correct=
ly)
> follow some kernel-related ABI. It doesn't mean that we cannot change any
> default state

If applications rely on that default one way or another, it's absolutely
what it means. The only criteria is whether this will create a
regression for any application.

Maxime

--7vib2wfrmfkzpfdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ02UDAAKCRAnX84Zoj2+
dlvaAX9//D/IPxxaf7TL1qH2t8T1ewaRAX1zfQ1E+ts3njBZQ2sTuC73YRfz+83a
s+gNMWIBgMlxRDKQexft0OGEGGccpjg0jtGrrlO7+akPBVqJLefEwCXcioRfL9It
vtX8zJ8dCg==
=U1WY
-----END PGP SIGNATURE-----

--7vib2wfrmfkzpfdq--

