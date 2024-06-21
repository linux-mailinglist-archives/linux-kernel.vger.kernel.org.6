Return-Path: <linux-kernel+bounces-224387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4379121B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC4EB20ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6E171084;
	Fri, 21 Jun 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YJTMtvnR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FE17166C;
	Fri, 21 Jun 2024 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964446; cv=none; b=OSyKXYSQlOAWCHqxnGhCBQbUx/rHGkNDp5Vh1/RoxiI5UbbFxAyMMHvR+tLJExJUKJ+CxZAYsv5k/yPFYbH5xYrlGq05+64C2D4MbfH8OeX5XIAw59DA3ZBHvNHI60bsQBsFB6QAVO1K8WjavoD9TZpRjem8nD/ZrSa6B9Ci6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964446; c=relaxed/simple;
	bh=9Mj5A9F9aX0M1Sv5c3xhao2Mzlr3mL7kZ+ELIe6yfU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crKLamoLJY4IEOwkzdr9dWhKa9RouFPXEFQPIUy8OlthEXzYLAwhzKWLn/eQ0jHuSoZwp+I0+CdXInQhLYBKq6R/FI+Px/DvXDo1lssG6ZTn6PI9PgrpVHUX2IiI4vdtGT19PZZZDpfzWOkYbNU2rtpLOlgQHMnL6XoYCvFeLPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YJTMtvnR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718964443; x=1750500443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Mj5A9F9aX0M1Sv5c3xhao2Mzlr3mL7kZ+ELIe6yfU4=;
  b=YJTMtvnRjpT4RBSzew5hEfCfjVUK9kR06hT1Z9QanFNQukYbXHxj44I1
   zpiKh8ILY5j/UA6w08nQURZg6oivau+uZULKBEGDfZPZv9XcKyEDcQg4Y
   bqxBGwSKMUU8b+oidMx1Ke/MjUkdc2HFXq2Pap9lZ19tiq/J8EJhoLa/I
   tjgnHofmAxPVfcymewUhtqZPLKXasTwHc48+JsKrCkEHiAqN3fsDEMI3J
   glcZ7jTirdyHkzbYGrlmBhjNBdhCS5SyaQPBrNM7KZD0tcPHtH4JUekd4
   KHy2ySUlDPG/2H1GR2mO5ERyiOf8ExBfDQFxrVMonY4YfSDgjJaV/K7KM
   g==;
X-CSE-ConnectionGUID: yH9lxABoTZGknLEBPBJV2w==
X-CSE-MsgGUID: 2yopCvb3SVSuE7sfObazNA==
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="asc'?scan'208";a="28314974"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jun 2024 03:07:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 21 Jun 2024 03:06:55 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 21 Jun 2024 03:06:50 -0700
Date: Fri, 21 Jun 2024 11:06:31 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Jesse Taube <jesse@rivosinc.com>, <linux-riscv@lists.infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Conor
 Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, Andrew Jones
	<ajones@ventanamicro.com>, Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu
	<andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>, Greentime Hu
	<greentime.hu@sifive.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin
	<costa.shul@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan
 He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>, Zong Li
	<zong.li@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, Ben Dooks
	<ben.dooks@codethink.co.uk>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Erick Archer
	<erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] RISC-V: Detect unaligned vector accesses
 supported.
Message-ID: <20240621-reveler-underfed-37600a9f16d5@wendy>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-5-jesse@rivosinc.com>
 <ZnDmRK0ZtKzmWN5S@ghost>
 <ZnDsdzv4o/Xz9kWm@ghost>
 <e6f7a061-50f0-4a6a-a09b-468502703c20@rivosinc.com>
 <ZnSptpobfqjik3RM@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+rvukaB0Gwx7tZ+V"
Content-Disposition: inline
In-Reply-To: <ZnSptpobfqjik3RM@ghost>

--+rvukaB0Gwx7tZ+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 03:14:14PM -0700, Charlie Jenkins wrote:
> On Thu, Jun 20, 2024 at 05:31:28PM -0400, Jesse Taube wrote:
> >=20
> >=20
> > On 6/17/24 22:09, Charlie Jenkins wrote:
> > > On Mon, Jun 17, 2024 at 06:43:32PM -0700, Charlie Jenkins wrote:
> > > > On Thu, Jun 13, 2024 at 03:16:13PM -0400, Jesse Taube wrote:
> > > > > Run a unaligned vector access to test if the system supports
> > > > > vector unaligned access. Add the result to a new key in hwprobe.
> > > > > This is useful for usermode to know if vector misaligned accesses=
 are
> > > > > supported and if they are faster or slower than equivalent byte a=
ccesses.
> > > > >=20
> > > > > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > > > > ---
> > > > > V1 -> V2:
> > > > >   - Add Kconfig options
> > > > >   - Add insn_is_vector
> > > > >   - Add handle_vector_misaligned_load
> > > > >   - Fix build
> > > > >   - Seperate vector from scalar misaligned access
> > > > >   - This patch was almost completely rewritten
> > > > > ---
> > > > >   arch/riscv/Kconfig                         |  41 +++++++
> > > > >   arch/riscv/include/asm/cpufeature.h        |   7 +-
> > > > >   arch/riscv/include/asm/entry-common.h      |  11 --
> > > > >   arch/riscv/include/asm/hwprobe.h           |   2 +-
> > > > >   arch/riscv/include/asm/vector.h            |   1 +
> > > > >   arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
> > > > >   arch/riscv/kernel/Makefile                 |   4 +-
> > > > >   arch/riscv/kernel/sys_hwprobe.c            |  41 +++++++
> > > > >   arch/riscv/kernel/traps_misaligned.c       | 119 ++++++++++++++=
++++++-
> > > > >   arch/riscv/kernel/unaligned_access_speed.c |   9 +-
> > > > >   arch/riscv/kernel/vector.c                 |   2 +-
> > > > >   11 files changed, 221 insertions(+), 21 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > index b94176e25be1..f12df0ca6c18 100644
> > > > > --- a/arch/riscv/Kconfig
> > > > > +++ b/arch/riscv/Kconfig
> > > > > @@ -723,6 +723,12 @@ config RISCV_MISALIGNED
> > > > >   	help
> > > > >   	  Embed support for emulating misaligned loads and stores.
> > > > > +config RISCV_VECTOR_MISALIGNED
> > > > > +	bool
> > > > > +	depends on RISCV_ISA_V
> > > > > +	help
> > > > > +	  Enable detecting support for vector misaligned loads and stor=
es.
> > > > > +
> > > > >   choice
> > > > >   	prompt "Unaligned Accesses Support"
> > > > >   	default RISCV_PROBE_UNALIGNED_ACCESS
> > > > > @@ -774,6 +780,41 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > > >   endchoice
> > > > > +choice
> > > > > +	prompt "Vector unaligned Accesses Support"
> > > > > +	depends on RISCV_ISA_V
> > > > > +	default RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > > > > +	help
> > > > > +	  This determines the level of support for vector unaligned acc=
esses. This
> > > > > +	  information is used by the kernel to perform optimizations.

I haven't actually checked the patchset, but is it actually used by the
kernel to perform optimisations?

> > > > > It is also
> > > > > +	  exposed to user space via the hwprobe syscall. The hardware w=
ill be
> > > > > +	  probed at boot by default.
> > > > > +
> > > > > +config RISCV_DETECT_VECTOR_UNALIGNED_ACCESS
> > > >=20
> > > > This is not used anywhere, what is the reason for including it?
> >=20
> > This is so that we can check if they are supported or not, but not chec=
k the
> > speed of them. Similar to RISCV_EMULATED_UNALIGNED_ACCESS.
>=20
> What do you mean? It isn't used anywhere so this "check if they are
> supported or not" is not guarded by this config.
>=20
> >=20
> > > >=20
> > > > > +	bool "Detect support for vector unaligned accesses"
> > > > > +	select RISCV_VECTOR_MISALIGNED
> > > > > +	help
> > > > > +	  During boot, the kernel will detect if the system supports ve=
ctor
> > > > > +	  unaligned accesses.
> > > > > +
> > > > > +config RISCV_PROBE_VECTOR_UNALIGNED_ACCESS
> > > > > +	bool "Probe speed of vector unaligned accesses"
> > > > > +	select RISCV_VECTOR_MISALIGNED
> > > > > +	help
> > > > > +	  During boot, the kernel will run a series of tests to determi=
ne the
> > > > > +	  speed of vector unaligned accesses if they are supported. Thi=
s probing
> > > > > +	  will dynamically determine the speed of vector unaligned acce=
sses on
> > > > > +	  the underlying system if they are supported.
> > > > > +
> > > > > +config CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED
> > > >=20
> > > > This should not be prefixed with CONFIG and does not include VECTOR=
 in
> > > > the name.
> >=20
> > Huh thought it would warn fixed though
>=20
> What do you mean by "warn fixed"?
>=20
> >=20
> > > I assume you meant to put
> > > > "RISCV_VEC_UNALIGNED_ACCESS_UNSUPPORTED" here?
> >=20
> > This is to leave a faster path like SLOW or FAST to say that unaligned
> > access arent suported.
>=20
> I am not sure what you are responding to. This comment seems to be
> responding to my correction of
> CONFIG_RISCV_UNALIGNED_ACCESS_UNSUPPORTED->RISCV_VEC_UNALIGNED_ACCESS_UNS=
UPPORTED
> so I don't see how that ties into SLOW/FAST.
>=20
> >=20
> > > >=20
> > > > This was also intentionally left out on the scalar side [1]. The
> > > > implication here is that having this config will cause people to co=
mpile
> > > > kernels without unaligned access support which really shouldn't be
> > > > something we are explicitly supporting.
> > > >=20
> > > > If somebody does want to support hardware that does not handle vect=
or
> > > > unaligned accesses, the solution should be to add emulation support=
 to
> > > > the kernel.
> >=20
> > Yes but we dont have emulation support yet so I do think its a good ide=
a.
>=20
> I am hesitant because it is very likely that somebody will add support
> for unaligned vector emulation. When there is emulation support, this
> config option should not exist to be consistent with scalar. However if
> we add this option in now, we must expect a user to enable this config,
> and then=20

I dunno, I think there could be value in having the option here. For
scalar, we couldn't have an option that would break the uABI, so the
unsupported option wasn't okay. That's not a constraint that we have for
vector.

For vector, if you have a system that doesn't support misaligned access,
you probably don't want to emulate the accesses either, since that's
likely remove any performance gains you get from using vector in the
first place, so I can see benefit in the option.
Enabling the probing is going to end up with same outcome for userspace
as having this option on such a system, so it comes down to whether you
want to allow people to skip the probing if they know their system has
this problem.

> we will have to get rid of it later. Users are not always happy
> when config options are removed.

I dunno, I don't think that adding emulation requires that we remove
this unsupported option.

Additionally, what are we doing in the kernel if we detect that
misaligned stuff isn't supported? Are we going to mandate that kernel
code is aligned only, disable in-kernel vector or some other mechanism
to make sure that things like crypto code don't have/introduce code
that'll not run on these systems?

Cheers,
Conor.

--+rvukaB0Gwx7tZ+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnVQpwAKCRB4tDGHoIJi
0pXZAQD9cjwE3+HhR1BPGTVexyDMeNXhGnxoQU2WPZIkQff5PAEAmEWvP/j3OqO3
Dh9OTffECs5ihlGfcsGsZqFA/aAANAQ=
=b750
-----END PGP SIGNATURE-----

--+rvukaB0Gwx7tZ+V--

