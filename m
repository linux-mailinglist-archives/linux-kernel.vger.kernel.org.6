Return-Path: <linux-kernel+bounces-197867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA68D702D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B591F21C3B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0F1509B1;
	Sat,  1 Jun 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOEoxg1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90F1D52D;
	Sat,  1 Jun 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248181; cv=none; b=n4lQxF0IPzMegpNAUGsEVnfq6jg5USZ1Zuu+T4EbkEZ7aSWx/laiKbinr09NC9zE92WuHNqv/2+kDlCWxjoI3lzwk+9Og9Vynbp0HshrjlFecnpyBlyH3TrevtJmZdHrsdv/yH710uoOS/86mMd97BYsAl6aRe0YVG30pq5TVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248181; c=relaxed/simple;
	bh=uemKakUr8vZOqaAGlWk2WVIUnDQWBAtUrKhYYseMLMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC7/FkDcLmZIdQu9J4FT4WBcPn8YRqH13d2Q6EhY5Mf7BuVw42k0m/mJM75IPGzpTx4KHgNwKABd8WEKoe/GQC1tu1wb7lKh/BSqxLb10+C0iCZk+49r3WcuEznYUnGQgW54Vw2PyE1ZaTj08QoKvNYircJPkIAbk2ORUPoaBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOEoxg1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEB2C116B1;
	Sat,  1 Jun 2024 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717248180;
	bh=uemKakUr8vZOqaAGlWk2WVIUnDQWBAtUrKhYYseMLMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOEoxg1chOjfRE/E4b5As7oYDoY3J10V3tBaL6M6PTfqJ4e0WTYhrkav8NfTfTBrN
	 dD/ap9/w0VHqNGtdFeyWoQR2OIl5UAf0EnnywWch8I4HNnhbfBDTNMAYOK/JnEZkIn
	 il6ie2YmaAmz82jNyBD7f2efX5+0IVGHCFxT6blV/DNNcuW9ZAdtlxiH9IOEkEFjls
	 x8nebtFOi4fOfBg9Xc1wNk9XGR9z/sSbJQAcZc79jfD7Ut+pK2wpVQN1hNs/063sW3
	 JjQ3yF6RQA9om3uqpKdjdoJ+OA7nl1wdwkf/wkSA54OFaf/IPuzpAh9cctwAncNrPc
	 uHUxB4z559Tsg==
Date: Sat, 1 Jun 2024 14:22:56 +0100
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
Message-ID: <20240601-powdering-herbicide-7bfe85717536@spud>
References: <20240531162327.2436962-1-jesse@rivosinc.com>
 <20240531-uselessly-spied-262ecf44e694@spud>
 <ZlowwohstpT0sJVl@ghost>
 <20240531-cough-yearling-bdfd49244885@spud>
 <ZlpDtR7ch+nE08lm@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qb94X1QeeBV02Dig"
Content-Disposition: inline
In-Reply-To: <ZlpDtR7ch+nE08lm@ghost>


--qb94X1QeeBV02Dig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 02:40:05PM -0700, Charlie Jenkins wrote:
> On Fri, May 31, 2024 at 10:36:46PM +0100, Conor Dooley wrote:
> > On Fri, May 31, 2024 at 01:19:14PM -0700, Charlie Jenkins wrote:
> > > On Fri, May 31, 2024 at 06:31:09PM +0100, Conor Dooley wrote:
> > > > On Fri, May 31, 2024 at 12:23:27PM -0400, Jesse Taube wrote:
> > > > > Dectect the Zkr extension and use it to seed the kernel base addr=
ess.
> > > > >=20
> > > > > Detection of the extension can not be done in the typical fashion=
, as
> > > > > this is very early in the boot process. Instead, add a trap handl=
er
> > > > > and run it to see if the extension is present.
> > > >=20
> > > > You can't rely on the lack of a trap meaning that Zkr is present un=
less
> > > > you know that the platform implements Ssstrict. The CSR with that n=
umber
> > > > could do anything if not Ssstrict compliant, so this approach gets a
> > > > nak from me. Unfortunately, Ssstrict doesn't provide a way to detect
> > > > it, so you're stuck with getting that information from firmware.
> > >=20
> > > The Scalar Cryptography v1.0.1 spec says "If Zkr is not implemented, =
the
> > > [s,u]seed bits must be hardwired to zero". It also says "Without the
> > > corresponding access control bit set to 1, any attempted access to se=
ed
> > > from U, S, or HS modes will raise an illegal instruction exception."
> > >=20
> > > There is a slight nuance here as the definition of Ssstrict is:
> > >=20
> > > "No non-conforming extensions are present. Attempts to execute
> > > unimplemented opcodes or access unimplemented CSRs in the standard or
> > > reserved encoding spaces raises an illegal instruction exception that
> > > results in a contained trap to the supervisor-mode trap handler."
> > >=20
> > > The trap that Jesse is relying on in the code here is related to acce=
ss
> > > bits and not related to the CSR being unimplemented. Since the access
> > > bits are required to be 0 on an implementation without Zkr, it is
> > > required to trap if seed is accessed, regardless of Ssstrict.
> > >=20
> > > The situation here is slightly odd because the spec is defining behav=
ior
> > > for what to do if the extension is not supported, and requires
> > > implementations to follow this aspect of the Scalar Cryptography spec
> > > even though they may not implement any of the instructions in the spe=
c.
> >=20
> > Firstly, you absolutely cannot rely on the behaviour defined by a new
> > extension by systems that implement a version of the ISA that predates
> > it. Secondly, we're talking about non-conforming implementations that
> > use a reserved CSR number for other purposes, you cannot rely on the
> > behaviour that the Scalar Crypto spec prescribes for access to the
> > register.
>=20
> Yes that is definitely a slippery slope.
>=20
> >=20
> > "Non-conforming" is also a moving target btw - the Andes PMU (I think
> > it's that) uses an interrupt number that was moved from "platform
> > specific use" to "reserved" by the AIA spec. If you only looked the
> > current specs, the Andes PMU is a "non-conforming extension" but at the
> > time that it was created it was compliant. I think we're gonna have a
> > fun conversation defining what "Ssstrict" actually means when someone
> > actually tries to document that.
>=20
> Sounds fun ;)
>=20
> >=20
> > > > For DT systems, you can actually parse the DT in the pi, we do it t=
o get
> > > > the kaslr seed if present, so you can actually check for Zkr. With =
ACPI
> > > > I have no idea how you can get that information, I amn't an ACPI-is=
t.
> > >=20
> > > It is feasible to check if Zkr is present in the device tree at this
> > > stage in boot, but at first glance does not seem feasible to read the
> > > ACPI tables this early.
> > >=20
> > > The CSR being read is just for entropy so even if the seed CSR doesn't
> > > trap and provides an arbitrary value on an implementation that does n=
ot
> > > support Zkr, it can still be used as a source of entropy. If the
> > > implementation does trap, the entropy will be set to 0 which is just a
> > > different hard-coded arbitrary value.=20
> >=20
> > Right. I can see value in doing something that may contain entropy, and
> > is at worst no better than the 0 we can currently get. But the patch
> > we're talking about here mentions nothing of the sort, it presents itse=
lf
> > as detection of Zkr and an actually random number - but all it actually
> > detects is whether or not the CSR at CSR_SEED traps.
> >=20
> > To be acceptable, the patch would need to stop claiming that it is a va=
lid
> > way to detect Zkr. The commit message, and a comment, must also explain
> > what may happen on systems that do not implement Zkr as you have done
> > here.
> > For example, `if (!riscv_has_zkr()) return 0` would have to be something
> > like `if (riscv_csr_seed_traps()) return 0`.
>=20
> That is reasonable, thank you for your input!

Another thing to consider is that writing a zero to CSR_SEED may have
side effects on a non-conforming implementation.

--qb94X1QeeBV02Dig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlsgsAAKCRB4tDGHoIJi
0mpAAP9Wf2UEJYEbxtEQlARVw3uO6tK/Rw99oZhzzH6rx7bt5gD7BLLU4j5MVT6g
xpvg+3vpip6nI973bF8fq8d0T537UQM=
=RU7v
-----END PGP SIGNATURE-----

--qb94X1QeeBV02Dig--

