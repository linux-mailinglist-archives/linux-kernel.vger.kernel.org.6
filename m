Return-Path: <linux-kernel+bounces-225663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F289491336C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220301C21192
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317615382E;
	Sat, 22 Jun 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUVxcXej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091133F6;
	Sat, 22 Jun 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056575; cv=none; b=YzVWTPXZbU/W19WhWu7GEygJ1k6/LpULbmYiT0p4LWHmDXNK0mtUxGMqoZy1TM1MP2wVRKZyk/PdR/YVLh4KZVHo+owmhOePdJG8DeSbjgYD49NCUnwKDs4RLJhAw2clVhkP0/wRB4ZMkvlr0f2L54UqFP7I3qInn9rV1jxTMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056575; c=relaxed/simple;
	bh=wtD7YQHf6v45fm83+oZI4kB76Tx4G3C24dObBlRzMzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMsSGuawkzs+NtYFJFYYZvs9g0jxSg0HrPVfGeo7ofeAFaYv17ZF/Dg5edgcyhZKWoO5SYIJCj8myK/dq2MQaAL3S2mDc0VPCzF//hD9YvAJBYRLoLHOkjZ6wz/Gp+fgDUM4Dn37fr7PL8azSqx7fKpIwE2ngcFMNRdXpS1fhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUVxcXej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0862C3277B;
	Sat, 22 Jun 2024 11:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719056575;
	bh=wtD7YQHf6v45fm83+oZI4kB76Tx4G3C24dObBlRzMzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUVxcXejodpVzG/FdxAyfzQdpCNVQIZlHGr37P+ATQa/ICY53lLXl3n53MN2imj5v
	 2Tl9yht+LYVQxzsaz9ob2q5EYO0FQSNNZE0MXEZ9qLO9q3bhtWC0vv9Zlg+qX2X/3E
	 gya0QxRravCSfkgmDuZxBGcGtZsOYiAY92AgSnt/HsweyCWBOxGr8I4waPZCC5Ru6o
	 IHMk1IJAzS7tMa8/nLRKtgqApxW+I6jsnrjJzYFh4aQeou6K+PhGNLaEIESJcQFcIg
	 Ub/vCTPGShKt0HOkhrQML+D5DwlnjUljcEjN4v5X1+mZTx3fJ/7YXzgnl41QaHir60
	 COehGNCY54Hbw==
Date: Sat, 22 Jun 2024 12:42:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesse Taube <jesse@rivosinc.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
Message-ID: <20240622-matcher-greeting-9574fd23c340@spud>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
 <ZnDmRK0ZtKzmWN5S@ghost>
 <ZnDsdzv4o/Xz9kWm@ghost>
 <e6f7a061-50f0-4a6a-a09b-468502703c20@rivosinc.com>
 <ZnSptpobfqjik3RM@ghost>
 <20240621-reveler-underfed-37600a9f16d5@wendy>
 <ZnW130PqW56CnZT8@ghost>
 <8c1167fb-9580-45bd-a798-f7d32477f1bd@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gsQdC7EXKheATd8R"
Content-Disposition: inline
In-Reply-To: <8c1167fb-9580-45bd-a798-f7d32477f1bd@rivosinc.com>


--gsQdC7EXKheATd8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 02:07:58PM -0400, Jesse Taube wrote:
>=20
>=20
> On 6/21/24 13:18, Charlie Jenkins wrote:
> > On Fri, Jun 21, 2024 at 11:06:31AM +0100, Conor Dooley wrote:
> > > On Thu, Jun 20, 2024 at 03:14:14PM -0700, Charlie Jenkins wrote:
> > > > On Thu, Jun 20, 2024 at 05:31:28PM -0400, Jesse Taube wrote:
> > > > >=20
> > > > >=20
> > > > > On 6/17/24 22:09, Charlie Jenkins wrote:
> > > > > > On Mon, Jun 17, 2024 at 06:43:32PM -0700, Charlie Jenkins wrote:
> > > > > > > On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
> > > > > > > > Run a unaligned vector access to test if the system supports
> > > > > > > > vector unaligned access. Add the result to a new key in hwp=
robe.
> > > > > > > > This is useful for usermode to know if vector misaligned ac=
cesses are
> > > > > > > > supported and if they are faster or slower than equivalent =
byte accesses.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > > > > > > ---
> > > > > > > > V1 -> V2:
> > > > > > > >    - Add Kconfig options
> > > > > > > >    - Add insn_is_vector
> > > > > > > >    - Add handle_vector_misaligned_load
> > > > > > > >    - Fix build
> > > > > > > >    - Seperate vector from scalar misaligned access
> > > > > > > >    - This patch was almost completely rewritten
> > > > > > > > ---
> > > > > > > >    arch/riscv/Kconfig                         |  41 +++++++
> > > > > > > >    arch/riscv/include/asm/cpufeature.h        |   7 +-
> > > > > > > >    arch/riscv/include/asm/entry-common.h      |  11 --
> > > > > > > >    arch/riscv/include/asm/hwprobe.h           |   2 +-
> > > > > > > >    arch/riscv/include/asm/vector.h            |   1 +
> > > > > > > >    arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
> > > > > > > >    arch/riscv/kernel/Makefile                 |   4 +-
> > > > > > > >    arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
> > > > > > > >    arch/riscv/kernel/traps_misaligned.c       | 119 +++++++=
+++++++++++++-
> > > > > > > >    arch/riscv/kernel/unaligned_access_speed.c |   9 +-
> > > > > > > >    arch/riscv/kernel/vector.c                 |   2 +-
> > > > > > > >    11 files changed, 221 insertions(+), 21 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > > > > index b94176e25be1..f12df0ca6c18 100644
> > > > > > > > --- a/arch/riscv/Kconfig
> > > > > > > > +++ b/arch/riscv/Kconfig
> > > > > > > > @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
> > > > > > > >    	help
> > > > > > > >    	  Embed support for emulating misaligned loads and stor=
es.
> > > > > > > > +config RISCV_VECTOR_MISALIGNED
> > > > > > > > +	bool
> > > > > > > > +	depends on RISCV_ISA_V
> > > > > > > > +	help
> > > > > > > > +	  Enable detecting support for vector misaligned loads an=
d stores.
> > > > > > > > +
> > > > > > > >    choice
> > > > > > > >    	prompt "Unaligned Accesses Support"
> > > > > > > >    	default RISCV_PROBE_UNALIGNED_ACCESS
> > > > > > > > @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > > > > > >    endchoice
> > > > > > > > +choice
> > > > > > > > +	prompt "Vector unaligned Accesses Support"
> > > > > > > > +	depends on RISCV_ISA_V
> > > > > > > > +	default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > > > > > > > +	help
> > > > > > > > +	  This determines the level of support for vector unalign=
ed accesses. This
> > > > > > > > +	  information is used by the kernel to perform optimizati=
ons.
> > >=20
> > > I haven't actually checked the patchset, but is it actually used by t=
he
> > > kernel to perform optimisations?
> >=20
> > No ;)
> >=20
> > Right now this patch is just providing the information to userspace
> > through hwprobe and doesn't optimize anything in the kernel.
> >=20
> > >=20
> > > > > > > > It is also
> > > > > > > > +	  exposed to user space via the hwprobe syscall. The hard=
ware will be
> > > > > > > > +	  probed at boot by default.
> > > > > > > > +
> > > > > > > > +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> > > > > > >=20
> > > > > > > This is not used anywhere, what is the reason for including i=
t?
> > > > >=20
> > > > > This is so that we can check if they are supported or not, but no=
t check the
> > > > > speed of them. Similar to RISCV_EMULATED_UNALIGNED_ACCESS.
> > > >=20
> > > > What do you mean? It isn't used anywhere so this "check if they are
> > > > supported or not" is not guarded by this config.
> > > >=20
> > > > >=20
> > > > > > >=20
> > > > > > > > +	bool "Detect support for vector unaligned accesses"
> > > > > > > > +	select RISCV_VECTOR_MISALIGNED
> > > > > > > > +	help
> > > > > > > > +	  During boot, the kernel will detect if the system suppo=
rts vector
> > > > > > > > +	  unaligned accesses.
> > > > > > > > +
> > > > > > > > +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > > > > > > > +	bool "Probe speed of vector unaligned accesses"
> > > > > > > > +	select RISCV_VECTOR_MISALIGNED
> > > > > > > > +	help
> > > > > > > > +	  During boot, the kernel will run a series of tests to d=
etermine the
> > > > > > > > +	  speed of vector unaligned accesses if they are supporte=
d. This probing
> > > > > > > > +	  will dynamically determine the speed of vector unaligne=
d accesses on
> > > > > > > > +	  the underlying system if they are supported.
> > > > > > > > +
> > > > > > > > +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
> > > > > > >=20
> > > > > > > This should not be prefixed with CONFIG and does not include =
VECTOR in
> > > > > > > the name.
> > > > >=20
> > > > > Huh thought it would warn fixed though
> > > >=20
> > > > What do you mean by "warn fixed"?
> > > >=20
> > > > >=20
> > > > > > I assume you meant to put
> > > > > > > "RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED" here?
> > > > >=20
> > > > > This is to leave a faster path like SLOW or FAST to say that unal=
igned
> > > > > access arent suported.
> > > >=20
> > > > I am not sure what you are responding to. This comment seems to be
> > > > responding to my correction of
> > > > CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED->RISCV_VEC_UNALIGNED_ACCE=
SS_UNSUPPORTED
> > > > so I don't see how that ties into SLOW/FAST.
> > > >=20
> > > > >=20
> > > > > > >=20
> > > > > > > This was also intentionally left out on the scalar side [1]. =
The
> > > > > > > implication here is that having this config will cause people=
 to compile
> > > > > > > kernels without unaligned access support which really shouldn=
't be
> > > > > > > something we are explicitly supporting.
> > > > > > >=20
> > > > > > > If somebody does want to support hardware that does not handl=
e vector
> > > > > > > unaligned accesses, the solution should be to add emulation s=
upport to
> > > > > > > the kernel.
> > > > >=20
> > > > > Yes but we dont have emulation support yet so I do think its a go=
od idea.
> > > >=20
> > > > I am hesitant because it is very likely that somebody will add supp=
ort
> > > > for unaligned vector emulation. When there is emulation support, th=
is
> > > > config option should not exist to be consistent with scalar. Howeve=
r if
> > > > we add this option in now, we must expect a user to enable this con=
fig,
> > > > and then
> > >=20
> > > I dunno, I think there could be value in having the option here. For
> > > scalar, we couldn't have an option that would break the uABI, so the
> > > unsupported option wasn't okay. That's not a constraint that we have =
for
> > > vector.
> > >=20
> > > For vector, if you have a system that doesn't support misaligned acce=
ss,
> > > you probably don't want to emulate the accesses either, since that's
> > > likely remove any performance gains you get from using vector in the
> > > first place, so I can see benefit in the option.
> >=20
> > We have the RISCV_MISALIGNED option that disables the scalar emulation,
> > but doesn't break the UABI because it's not saying that misaligned
> > scalar is not supported, but just that the kernel doesn't emulate.
> > Having an UNSUPPORTED option explicitly breaks the UABI which doesn't
> > seem like something that the kernel should support. If we are okay with
> > having options that break the UABI then this is fine, but I was under
> > the impression that we did our best to avoid that.
> >=20
> > There definitely is value in having an option like this for hardware
> > that never wants to run misaligned code, but since we decided with the
> > scalar accesses that we should not break the UABI I think vector should
> > do the same.
>=20
> The rational for scalar accesses was slightly different as
> The base ISA spec said/says: ". The base ISA supports misaligned accesses,
> but these might run extremely slowly depending on the implementation."
>=20
> Section: 2.6 Load and Store Instructions. Available:
> https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf

Right, the rationale for the Scalar stuff is that the uABI requires them,
cos when the port was merged the ISA required them to be supported.
The same constraint doesn't exist for vector, so there is no uABI
concern.

For scalar, the options must end up with a system that supports
misaligned access - hence anything without in-kernel emulation is marked
NONPORTABLE, since we cannot be sure that all systems will have
emulation in their firmware and/or support in the hardware.

For vector, emulation might be nice to have (or not given extra code and
complexity for shit performance that makes using vector not worthwhile,
but that's another argument), but it is not required for uABI reasons.
None of the options in this series make any different to the uABI
anyway, no matter what you choose, if the hardware doesn't support
misaligned accesses, you're gonna have problems.

> > > Enabling the probing is going to end up with same outcome for userspa=
ce
> > > as having this option on such a system, so it comes down to whether y=
ou
> > > want to allow people to skip the probing if they know their system has
> > > this problem.
> > >=20
> > > > we will have to get rid of it later. Users are not always happy
> > > > when config options are removed.
> > >=20
> > > I dunno, I don't think that adding emulation requires that we remove
> > > this unsupported option.
> >=20
> > I am probably being too paranoid about this but I am hesistant to cause
> > vector and scalar misaligned access implemenations to diverge. It is
> > inconsistent to allow an unsupported option for vector but not for
> > scalar when both support emulation.

> > The probing is very fast as it just
> > checks if a misaligned access causes a trap and then sets the access
> > speed to unsupported if it does trap.
>=20
> Charlie is right about probing for support being fast. There is
> RISCV_DETECT_VECTOR_UNALIGNED_ACCESS to only detect support not the speed.
> I
> thought it might be a good idea to add this config option, but
> I'll just drop it to shorten this thread.

I actually agree with Charlie that the option really isn't needed, I was
just arguing against the justifications he gave. It being fairly fast
and not really much code to just check for a trap I think is enough to
not have much cause for the option.

I really think that we should be added checks for how well it
performs though. Unless it is supported by the hardware (which we cannot
know just by checking for traps, since the firmware could be emulating),
the performance is unlikely to make it perform better than using the same
instructions but aligned or sticking to using scalars.

IMO the options should be (provided we don't have emulation):
- RISCV_VECTOR_PROBE_UNALIGNED_ACCESS: Check for a trap and then bail
  early if not supported. If supported, check the speed.
- RISCV_VECTOR_SLOW_UNALIGNED_ACCESS: Don't check for traps or the
  speed, report slow. NONPORTABLE.
- RISCV_VECTOR_EFFICIENT_UNALIGNED_ACCESS: Don't check for traps or the
  speed, report fast. NONPORTABLE.

Having two different options for "detection" and "probing" is just
confusing and RISCV_DETECT_VECTOR_UNALIGNED_ACCESS' two possible results
both effectively mean the same thing to me if I was writing a userspace
program that wanted to make use of vector optimisations.

> > > Additionally, what are we doing in the kernel if we detect that
> > > misaligned stuff isn't supported? Are we going to mandate that kernel
> > > code is aligned only
>=20
> As of now yes.

Seems like we already have in-kernel vector code that assumes misaligned
accesses are supported :)

> > > disable in-kernel vector or some other mechanism
> > > to make sure that things like crypto code don't have/introduce code
> > > that'll not run on these systems?
>=20
> I'm not too familiar with the uses of unaligned vector accesses, but if
> it significantly improves performance then I think there should be a fast=
er
> unaligned access pathway, and a aligned access pathway, so both are
> supported. This also ties into your first question.

I dunno, I think we'll have enough bits of optional code for different
extensions, I don't want to have different codepaths for these kinds of
systems. As I said to Eric, I think the vector crypto stuff should just
get disabled once we detect that misaligned accesses are unsupported.
He seems unwilling to support systems that didn't implement misaligned
accesses in the crypto code anyway.

I'm tempted to say that we should force enable Zicclsm if we detect both
support for vector and scalar crypto, but it happens too late to fix
that up I think.

> > UNSUPPORTED will still be set by the quick probe so it would be possible
> > for the kernel/userspace to avoid running misaligned vector when it's
> > unsupported. Any kernel methods would probably want to always run
> > aligned vector unless misaligned support was determined to be FAST
> > anyway, I am doubtful that code will have different optimizations for
> > FAST, SLOW, and UNSUPPORTED but it is possible.
> >=20
> > I would prefer consistency between scalar and vector misaligned support,
> > but this is not a deal breaker for this patch. I am not convinced it is
> > the best choice, but I am okay with leaving this option in the kernel.

I would like consistency too :)

Thanks,
Conor.

--gsQdC7EXKheATd8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna4tgAKCRB4tDGHoIJi
0vbwAP9U+ksbtTwQDjY79nW5zMMc0FUVpQC4auVBOVHMQVonNgEAkAD68Q7FkBId
JZzWQ0HQ2C6TWNwwmoJ9KFyQS6PLlQ8=
=VeIP
-----END PGP SIGNATURE-----

--gsQdC7EXKheATd8R--

