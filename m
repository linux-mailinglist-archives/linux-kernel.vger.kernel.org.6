Return-Path: <linux-kernel+bounces-199129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC68D82B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0508BB20D39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69812C522;
	Mon,  3 Jun 2024 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jx9j+DBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79A126F1A;
	Mon,  3 Jun 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418865; cv=none; b=VTRrejY6uyjGlb5U0LtAukQFvyU98xWbHt3HID/zywfTHiG47dKWFr+WaQFwtERsgGeu4ab5XizJKpe7nkjTmpLxCc3j9U2zyVdm9QSh0dj9j+Ktyzd6BUN/c/9hcxn1f/DK9bak48tR/0uGXFVsbyYZS9snkzXeCGxaEaRK68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418865; c=relaxed/simple;
	bh=xjvuuOdnqOIhK5ZBtlN6ndKEQrQUjVsyjGmdjk8KDM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuP3WjoChYwmVRPvDD0PjTsOyzDb4B/duvsX7dgCJ+vaPuo0P+GyRLu2oAx4TWyHKxuNrTv00Leq0X5qPHpuZynA69MYDfsNeJ0AtmssrHtRZINFl3l4XVlhCnlC7UZCihhqXHWry53mGwhfnUU6WXq2on3LQJHwIIM03hhiYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jx9j+DBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AA1C4AF07;
	Mon,  3 Jun 2024 12:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717418864;
	bh=xjvuuOdnqOIhK5ZBtlN6ndKEQrQUjVsyjGmdjk8KDM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jx9j+DBzZp16t8GUoTabwdp9sySO5qFu4XyiaobyhE0bWZwGYAOot9E1RKFHAGYn1
	 RFsK6myrrIx2X2exvfkwD06gQ3WHr6ZYP0rC6kRpLfp+Yw6+qyPFIJ3wNt2Do8lDRw
	 XlKSVa+zhpiYpdo4ATR6iTBlhCqmlI3pK90eRLAdF6y3vgSkOu2HfFxLuH0vBaSdb0
	 8Nb4ZCCxOVH8GQ/30htNKhSoPm2sqqExt91urxrj4zWKfMiSKE7BtkWjaZBi3V02Dl
	 cvSBUIfXhsLmcP4umDOyuEW90vH3ruTPyFgiFAQYhyREH7WHaicWHcBssMiWSzb+HU
	 BrCqREjhNes9g==
Date: Mon, 3 Jun 2024 13:47:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240603-stinking-roster-cfad46696ae5@spud>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iJdrl4qDKkXrEMBS"
Content-Disposition: inline
In-Reply-To: <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr>


--iJdrl4qDKkXrEMBS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 31/05/2024 19:31, Conor Dooley wrote:
> > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> > > Dectect the Zkr extension and use it to seed the kernel base address.
> > >=20
> > > Detection of the extension can not be done in the typical fashion, as
> > > this is very early in the boot process. Instead, add a trap handler
> > > and run it to see if the extension is present.
> > You can't rely on the lack of a trap meaning that Zkr is present unless
> > you know that the platform implements Ssstrict. The CSR with that number
> > could do anything if not Ssstrict compliant, so this approach gets a
> > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> > it, so you're stuck with getting that information from firmware.
>=20
>=20
> FYI, this patch is my idea, so I'm the one to blame here :)
>=20
>=20
> >=20
> > For DT systems, you can actually parse the DT in the pi, we do it to get
> > the kaslr seed if present, so you can actually check for Zkr. With ACPI
> > I have no idea how you can get that information, I amn't an ACPI-ist.
>=20
>=20
> I took a look at how to access ACPI tables this early when implementing t=
he
> Zabha/Zacas patches, but it seems not possible.
>=20
> But I'll look into this more, this is not the first time we need the
> extensions list very early and since we have no way to detect the presence
> of an extension at runtime, something needs to be done.

Aye, having remembered that reading CSR_SEED could have side-effects on a
system with non-conforming extensions, it'd be good to see if we can
actually do this via detection on ACPI - especially for some other
extensions that we may need to turn on very early (I forget which ones we
talked about this before for). I didn't arm64 do anything with ACPI in the
pi code, is the code arch/x86/boot/compressed run at an equivilent-ish point
in boot?

--iJdrl4qDKkXrEMBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl27awAKCRB4tDGHoIJi
0qGGAP0dROI2kQOiSz/LUNHcEMeZPOeCAtT2w2ieJ5CnnqdxFAEA0+On5DOHDyHW
ScDD2IjkJxreOi0zn1lj8uq2WccodwI=
=fWLb
-----END PGP SIGNATURE-----

--iJdrl4qDKkXrEMBS--

