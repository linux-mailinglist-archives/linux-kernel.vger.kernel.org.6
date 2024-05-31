Return-Path: <linux-kernel+bounces-197518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE28D6BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230111C25E91
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F97B3FE;
	Fri, 31 May 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj+FH8bl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5178C9C;
	Fri, 31 May 2024 21:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191411; cv=none; b=DiK8Cyw5ctg4eLLX6IVwBY5ZYk5c6uAVEJi+eap9/V/Ta37fGHG3lL4nmZk8iyEuOCA2DR0+VG474StANOr7GVh/FwuCDyXhhDgt/Rb9nMuhXYA6I6Phbskb3qOz107aAx+CtZYg6qTyGFFHrlTwmSYhDG5y5ZfX+APjUJ5qK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191411; c=relaxed/simple;
	bh=FFToUnOuCn712quRqXbsVLVvTc5pX5hyAMtrzSFK0vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU+HfemuOprVSCKXxeTj3ZHox+xzF1Jkf9TrDKrvkqL9gb5zpGoRgS+GeOnRJpehauwsTIMLqYif/TppuV3tU7jYBENa5cRGyj2cgsA8KApB/tUD3ZMM4i28KnYIL9/FK2lUaDo2NazV43ZTQGBNGDOwLSSVUaaBU94Zox5pt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj+FH8bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F60C116B1;
	Fri, 31 May 2024 21:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717191411;
	bh=FFToUnOuCn712quRqXbsVLVvTc5pX5hyAMtrzSFK0vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj+FH8bl6Gl0YqzVdbTMoK7p2XxVcg2Nc2jhOf1pQOfFcNSVUq7G+tciKkEzbprPj
	 4O45kyEW5N16DwcyT9/WJs1he3jF6xUC4TdEJB3FoSIbZaCwRI6P8aB1R0UT8CISHp
	 ++BYzy0R1Qk/OJgUITnj2SLL2SNHDxSI5TFBhF22TE6HTIOPUuNW911AC6dOrF+Gme
	 /FAyvr+gO5DA82/g2yB1H4/DKoS73Tdgj9IrOXkOYkuQddmy2pKk7gpsWYfhrKHWY5
	 O39EbvaAzx61rgfStlBHnNvu7Wzf8rWdC8nu5NgI1kjOZkdYEbjnS5yYiVsn39/Hmt
	 kn8lcRTLh2NtA==
Date: Fri, 31 May 2024 22:36:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
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
Message-ID: <20240531-cough-yearling-bdfd49244885@spud>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <ZlowwohstpT0sJVl@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ggqLvOYAyQE9JuFh"
Content-Disposition: inline
In-Reply-To: <ZlowwohstpT0sJVl@ghost>


--ggqLvOYAyQE9JuFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 01:19:14PM -0700, Charlie Jenkins wrote:
> On Fri, May 31, 2024 at 06:31:09PM +0100, Conor Dooley wrote:
> > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> > > Dectect the Zkr extension and use it to seed the kernel base address.
> > >=20
> > > Detection of the extension can not be done in the typical fashion, as
> > > this is very early in the boot process. Instead, add a trap handler
> > > and run it to see if the extension is present.
> >=20
> > You can't rely on the lack of a trap meaning that Zkr is present unless
> > you know that the platform implements Ssstrict. The CSR with that number
> > could do anything if not Ssstrict compliant, so this approach gets a
> > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> > it, so you're stuck with getting that information from firmware.
>=20
> The Scalar Cryptography v1.0.1 spec says "If Zkr is not implemented, the
> [s,u]seed bits must be hardwired to zero". It also says "Without the
> corresponding access control bit set to 1, any attempted access to seed
> from U, S, or HS modes will raise an illegal instruction exception."
>=20
> There is a slight nuance here as the definition of Ssstrict is:
>=20
> "No non-conforming extensions are present. Attempts to execute
> unimplemented opcodes or access unimplemented CSRs in the standard or
> reserved encoding spaces raises an illegal instruction exception that
> results in a contained trap to the supervisor-mode trap handler."
>=20
> The trap that Jesse is relying on in the code here is related to access
> bits and not related to the CSR being unimplemented. Since the access
> bits are required to be 0 on an implementation without Zkr, it is
> required to trap if seed is accessed, regardless of Ssstrict.
>=20
> The situation here is slightly odd because the spec is defining behavior
> for what to do if the extension is not supported, and requires
> implementations to follow this aspect of the Scalar Cryptography spec
> even though they may not implement any of the instructions in the spec.

Firstly, you absolutely cannot rely on the behaviour defined by a new
extension by systems that implement a version of the ISA that predates
it. Secondly, we're talking about non-conforming implementations that
use a reserved CSR number for other purposes, you cannot rely on the
behaviour that the Scalar Crypto spec prescribes for access to the
register.

"Non-conforming" is also a moving target btw - the Andes PMU (I think
it's that) uses an interrupt number that was moved from "platform
specific use" to "reserved" by the AIA spec. If you only looked the
current specs, the Andes PMU is a "non-conforming extension" but at the
time that it was created it was compliant. I think we're gonna have a
fun conversation defining what "Ssstrict" actually means when someone
actually tries to document that.

> > For DT systems, you can actually parse the DT in the pi, we do it to get
> > the kaslr seed if present, so you can actually check for Zkr. With ACPI
> > I have no idea how you can get that information, I amn't an ACPI-ist.
>=20
> It is feasible to check if Zkr is present in the device tree at this
> stage in boot, but at first glance does not seem feasible to read the
> ACPI tables this early.
>=20
> The CSR being read is just for entropy so even if the seed CSR doesn't
> trap and provides an arbitrary value on an implementation that does not
> support Zkr, it can still be used as a source of entropy. If the
> implementation does trap, the entropy will be set to 0 which is just a
> different hard-coded arbitrary value.=20

Right. I can see value in doing something that may contain entropy, and
is at worst no better than the 0 we can currently get. But the patch
we're talking about here mentions nothing of the sort, it presents itself
as detection of Zkr and an actually random number - but all it actually
detects is whether or not the CSR at CSR_SEED traps.

To be acceptable, the patch would need to stop claiming that it is a valid
way to detect Zkr. The commit message, and a comment, must also explain
what may happen on systems that do not implement Zkr as you have done
here.
For example, `if (!riscv_has_zkr()) return 0` would have to be something
like `if (riscv_csr_seed_traps()) return 0`.

Thanks,
Conor.

--ggqLvOYAyQE9JuFh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlpC7gAKCRB4tDGHoIJi
0unPAP9+cMX5dlo+PBlNH2Xf52APZwRcdImVnnyQiYcK7srY9wD/Zg5Ccwcu5LmY
vm8TWShzC4ePfWVslctxqCd3Fr2d8Q0=
=hSYQ
-----END PGP SIGNATURE-----

--ggqLvOYAyQE9JuFh--

