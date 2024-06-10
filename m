Return-Path: <linux-kernel+bounces-208963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A92902B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2651C20C16
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA61494B9;
	Mon, 10 Jun 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILZonLi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053612F5B6;
	Mon, 10 Jun 2024 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056602; cv=none; b=EoQHNGAHr7XKY3TeF9cvb884npOUufYvj+CxvU0ZaPUN101L1ZnFTanxJmnfP0FIpA0yQK5a+8y3KKKyXauaFNAa62KRfV2YmCwoBSBP0+iBFj2lFutedtMC3D1N7cGfFTtbU7PoqDjw+e5CUKHSXGQjyZU+A7yx8tV2p3KIYug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056602; c=relaxed/simple;
	bh=KoFsY2QSqRbBiXfDzmXBOyy6f22jp0uRonBy4MZFEPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6Fgb64T5kCb06EKgmZDHWnFYy+0giAjmEsPxhiz6lk2xvf3hBmJ+3bCujffpnd7GRRUv6OpXU7EVtgAJBvatVe2dMe/YQUQ65ioJTaXFdNaO6hho7XIT6tJm3AFKdv6yevfGxDq8auVy1Ra67aF54LBdPG0kJ2dynrczXUsFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILZonLi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E41C2BBFC;
	Mon, 10 Jun 2024 21:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718056601;
	bh=KoFsY2QSqRbBiXfDzmXBOyy6f22jp0uRonBy4MZFEPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILZonLi4KYvvONkwpufTrioY+XFWyVKpzIZHgquP+P20woB+3RxuhH9AkzOkzEyPc
	 uTW/hkuY+AzkUu06YGBpDZbJGiglOn3VeOfqIKQ8FyVIUXyERAOPc3n+9DidVLTO9s
	 2aqx4PxwMGnnSdBd2RvJhEjPXahAigoBZior1fuhL2L7ppPcnz/iy3gs0cuc6Cfhcb
	 gB3ngKFf3TCnVsnbUMTtItPYlTjieGCXMSo59GMdJX/KTLv9Wj8ETcQjSc6ITifhWx
	 ACDwjW8WMqAdfrbVwvAk0RuHbv+/oPVaaCpygkbgkipXus/BtmPumlmZVGQb6k5y9b
	 pyycPHtwSIiHg==
Date: Mon, 10 Jun 2024 22:56:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Jesse Taube <jesse@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240610-earplugs-anybody-ebd04a5fa777@spud>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
 <20240603-stinking-roster-cfad46696ae5@spud>
 <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com>
 <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>
 <20240610-qualm-chalice-72d0cc743658@wendy>
 <01547275-8c8c-43cf-9da0-64825c234707@rivosinc.com>
 <Zmdq6kszPBxAvLdD@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mWdS1ikOOxMEfGUM"
Content-Disposition: inline
In-Reply-To: <Zmdq6kszPBxAvLdD@debug.ba.rivosinc.com>


--mWdS1ikOOxMEfGUM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 02:06:50PM -0700, Deepak Gupta wrote:
> On Mon, Jun 10, 2024 at 11:16:42AM +0200, Cl=E9ment L=E9ger wrote:
> > On 10/06/2024 11:02, Conor Dooley wrote:
> > > On Mon, Jun 10, 2024 at 10:33:34AM +0200, Cl=E9ment L=E9ger wrote:
> > > > On 07/06/2024 20:51, Deepak Gupta wrote:
> > > > > On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
> > > > > > On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
> > > > > I don't know all the details but on first glance it seems like in=
stead
> > > > > of ACPI,
> > > > > may be FWFT is a better place for discovery ?
> > > > > https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/1=
06479571
> > > >=20
> > > > IMHO, doing discovery in FWFT is not the goal of this extension. I =
think
> > > > the "real" solution would be to wait for the unified discovery task
> > > > group to come up with something for that (which is their goal I thi=
nk) [1]
>=20
> Yeah I understand the conundrum here.
>=20
> > >=20
> > > I'm curious to see how that works out. The proposal documents an m-mo=
de
> > > csr, so we'd have to smuggle the information to s-mode somehow...
> >=20
> > Ahem, yeah, I spoke a bit too fast. Looked at the proposal and the
> > mconfigptr CSR will be accessible by M-mode only so I guess we will have
> > to find another way...
>=20
> That's not the only problem. Even if you get mconfigptr access, parsing t=
he format
> is another thing that has to be done. This is early in boot. Although its=
 strictly (pun
> intended) not a firmware feature extension, I think it's much easier to a=
sk underlying
> firmware if platform is `Sstrict`. or may be expose something like below
>=20
> `ENABLE_SSTRICT`.
> Platforms which support `Sstrict` can return success for this while platf=
orms which don't
> have `Sstrict` can return error code (not supported or not implemented).
> This way its not feature discovery.

I mean, it's feature discovery in all but name. You're calling it
enable, but the behaviour you describe is feature discovery - not that I
am against this being feature discovery since it gets us out of an
annoying bind.

I forget which extension Alex and I discussed previously, but there's
some mm-related things that you're gonna have to probe super early and=20
we need to figure out if we can get that info from ACPI or not. I know
we discussed it w.r.t. one of the T-Head vendor extensions, but I think
another standard one got mentioned too.

> It seems like arm64 parses fdt and it reads certain CSRs too
> (`arch/arm64/kernel/pi/kaslr_early.c`). Although it doesn't look like it =
has to do any
> discovery for them.

A decree from the Palmer that we don't support things that do not conform
in this manner would allow us to do what arm64 does. I brought this up
originally because it's been discussed before that we cannot rely on
conformance because we want to support people's platforms, whether they
comply or not. I'd be wary of making this an exception now, and then
later on someone makes a platform we want to support that doesn't
conform and hey presto, we regress KASLR support - even if I think it is
pretty unlikely that someone is going to repurpose the Zkr CSRs.

One of the problems with only supporting conforming platforms is that
the definition of conforming changes over time! This has happened with
the Andes PMU for example, which I believe uses an interrupt number that
was later co-opted by AIA spec. That conformed at the time, but doesn't
anymore - do they get to mark themselves as Sstrict?

Maybe we can do this on a case-by-case basis, but it's up to Palmer
whether or not we can do that.

--mWdS1ikOOxMEfGUM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmd2kwAKCRB4tDGHoIJi
0jiYAQCTudtf2cIt7L8o1XdE+wFCII3X2/gtf2RZ78X2JJF0SQD9H3PFBbLUuQ+e
xhlLbZGztObPUHowGMnO5LqjIaJCbwc=
=Dq40
-----END PGP SIGNATURE-----

--mWdS1ikOOxMEfGUM--

