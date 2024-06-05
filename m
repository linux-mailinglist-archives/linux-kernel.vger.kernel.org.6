Return-Path: <linux-kernel+bounces-202911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5AE8FD2DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018EA1F21820
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF8188CDF;
	Wed,  5 Jun 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2d/hdaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC92188CC0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717604629; cv=none; b=nbT0OuB59HKcJdTMcBJKu9ba2cddk5xEQHG/ZXH2EneHdttt9IFUBCO4eQb2o0LnoGS06J3FirRU9GFuQiupSiEjCTecbi1vOri4FjdZqRdU+FGWtcCYedkThyWxMGdmZ2kR0IAWLqHOeOhLjnl5f+GVG18Q2CSQBb1Ou5bLim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717604629; c=relaxed/simple;
	bh=cswrUXpikOMwLXy4PmCqlsiI+n3k7j4vCHyy0Pgzbpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqQcmYhV8G8RoNbnJD9EAC1dL3hZcibjhMWVgbW1KxyaWcuyKTwSKQW9SHkfwkehkXZ97GZ3MU4NPQtFZGFa//o7R+HDZte16dZVVLcftdpjEibBuBJI3krxDik0sA29RTbIuPzzAUbiw2yi+y+5Yl42Fa1S1fFNYzh3BNwGpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2d/hdaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F55FC4AF0A;
	Wed,  5 Jun 2024 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717604629;
	bh=cswrUXpikOMwLXy4PmCqlsiI+n3k7j4vCHyy0Pgzbpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2d/hdaECrfAYIuDhjeaftW5MKS7D+ZVD33bMdjkAlVX8KK4rrnDcwa+ET7zN4bD8
	 H0e/yuFt+Er4j8EkSWGnDPWLYsO+eMFxnfBNQMU4XVJrJpioNoXObhJULGqQ+ynBNm
	 LscPpBlJ++euiYwYp/Yke1EPWbGovn+jtSATrxBp4UoZdmp1YKJCn9NwKCBZKhEBU4
	 fqyYFxB3Q5Uyu6ZhPpDzx8YOkuN/aG18V+EkNcyWlyyuZ4UTRYhqJ5m4t3S32PruwC
	 28iWqlO0YR2gvWZ6XeSib/sfZjRlQjrrDue6TJ4t/ZSGn/aGgP7ynwCJWYfC04BmuR
	 SC0eEnDtery4A==
Date: Wed, 5 Jun 2024 17:23:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Evan Green <evan@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Erick Archer <erick.archer@gmx.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v0] RISCV: Report vector unaligned accesses hwprobe
Message-ID: <20240605-bullfight-ivory-b0151ad2b987@spud>
References: <20240604162457.3757417-1-jesse@rivosinc.com>
 <CALs-Hsu5LakOVKvGRP0-sbq5ptH8FLPGhBAkupv3tRLKVAdnUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BJ5Lnf9kA5JE7RaD"
Content-Disposition: inline
In-Reply-To: <CALs-Hsu5LakOVKvGRP0-sbq5ptH8FLPGhBAkupv3tRLKVAdnUA@mail.gmail.com>


--BJ5Lnf9kA5JE7RaD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

Beat me to some things I wanted to saw, so I'll leave my comments on top
of yours.

On Wed, Jun 05, 2024 at 08:54:21AM -0700, Evan Green wrote:
> On Tue, Jun 4, 2024 at 9:25=E2=80=AFAM Jesse Taube <jesse@rivosinc.com> w=
rote:
> >
> > Detected if a system traps into the kernel on an vector unaligned acces=
s.
> > Add the result to a new key in hwprobe.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>=20
> For the scalar world, we wanted to know whether misaligned accesses
> were faster or slower than equivalent byte accesses, so usermode could
> know for something like memcpy which option had better bandwidth. Is
> the motivation here the same, where we're going to use vector
> registers for memcpy and we want to know which size load to use? Or
> will usermode be consuming this info for a different purpose as well?
> I know this is a basic question, but having the motivation helps me
> get the right lens for reviewing it. Perhaps that should be added to
> the commit message as well.

Motivation should always be in the commit message ;)

> >  arch/riscv/include/asm/cpufeature.h        |  3 ++
> >  arch/riscv/include/asm/hwprobe.h           |  2 +-
> >  arch/riscv/include/uapi/asm/hwprobe.h      |  6 +++
> >  arch/riscv/kernel/sys_hwprobe.c            | 34 ++++++++++++
> >  arch/riscv/kernel/traps_misaligned.c       | 60 ++++++++++++++++++++++
> >  arch/riscv/kernel/unaligned_access_speed.c |  4 ++
> >  6 files changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/a=
sm/cpufeature.h
> > index 347805446151..5ad69cf25b25 100644
> > --- a/arch/riscv/include/asm/cpufeature.h
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -35,9 +35,12 @@ void riscv_user_isa_enable(void);
> >
> >  #if defined(CONFIG_RISCV_MISALIGNED)
> >  bool check_unaligned_access_emulated_all_cpus(void);
> > +bool check_vector_unaligned_access_all_cpus(void);
> > +
> >  void unaligned_emulation_finish(void);
> >  bool unaligned_ctl_available(void);
> >  DECLARE_PER_CPU(long, misaligned_access_speed);
> > +DECLARE_PER_CPU(long, vector_misaligned_access);
> >  #else
> >  static inline bool unaligned_ctl_available(void)
> >  {
> > diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/=
hwprobe.h
> > index 630507dff5ea..150a9877b0af 100644
> > --- a/arch/riscv/include/asm/hwprobe.h
> > +++ b/arch/riscv/include/asm/hwprobe.h
> > @@ -8,7 +8,7 @@
> >
> >  #include <uapi/asm/hwprobe.h>
> >
> > -#define RISCV_HWPROBE_MAX_KEY 6
> > +#define RISCV_HWPROBE_MAX_KEY 7
> >
> >  static inline bool riscv_hwprobe_key_is_valid(__s64 key)
> >  {
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index 060212331a03..4474e98d17bd 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -68,6 +68,12 @@ struct riscv_hwprobe {
> >  #define                RISCV_HWPROBE_MISALIGNED_UNSUPPORTED    (4 << 0)
> >  #define                RISCV_HWPROBE_MISALIGNED_MASK           (7 << 0)
> >  #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE    6
> > +#define RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF  7
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN           =
 0
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_EMULATED          =
 1
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_SLOW              =
 2
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_FAST              =
 3
> > +#define                RISCV_HWPROBE_VEC_MISALIGNED_UNSUPPORTED       =
 4
>=20
> This needs to be added to the documentation as well.

+1

> What value should be returned when V is not enabled in the kernel, or
> V is not supported in the hardware? Currently in the code it would be
> UNKNOWN, right? Is that what we want, or is it worth differentiating
> "no support for V" from "I don't know the speed of misaligned loads"?
> Maybe UNKNOWN is the right value, as there are other values to tell
> you V is not enabled.

I think UNKNOWN is fine for !V, assuming identical definitions as scalar.
Realistically, we /should/ always know the value once we get as far as
userspace (ignoring the fact that this patch as implemented doesn't know),
either by probing for it or config options like those that the non-vector
stuff has.

What I am not a fan of in this patch is how it makes UNKNOWN a proxy
for "SUPPORTED", I think we should set SLOW as a minimum. Really we
should either add probing and Kconfig options, and maybe emulation if
there's a strong case for it.

> >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> >  /* Flags */
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index b286b73e763e..ce641cc6e47a 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -184,6 +184,36 @@ static u64 hwprobe_misaligned(const struct cpumask=
 *cpus)
> >  }
> >  #endif
> >
> > +#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
> > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > +{
> > +       int cpu;
> > +       u64 perf =3D -1ULL;
> > +
> > +       for_each_cpu(cpu, cpus) {
> > +               int this_perf =3D per_cpu(vector_misaligned_access, cpu=
);
> > +
> > +               if (perf =3D=3D -1ULL)
> > +                       perf =3D this_perf;
> > +
> > +               if (perf !=3D this_perf) {
> > +                       perf =3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (perf =3D=3D -1ULL)
> > +               return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +
> > +       return perf;
> > +}
> > +#else
> > +static u64 hwprobe_vec_misaligned(const struct cpumask *cpus)
> > +{
> > +       return RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN;
> > +}
> > +#endif
> > +
> >  static void hwprobe_one_pair(struct riscv_hwprobe *pair,
> >                              const struct cpumask *cpus)
> >  {
> > @@ -211,6 +241,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe =
*pair,
> >                 pair->value =3D hwprobe_misaligned(cpus);
> >                 break;
> >
> > +       case RISCV_HWPROBE_VEC_KEY_MISALIGNED_PERF:
> > +               pair->value =3D hwprobe_vec_misaligned(cpus);
> > +               break;
> > +
> >         case RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE:
> >                 pair->value =3D 0;
> >                 if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/t=
raps_misaligned.c
> > index 2adb7c3e4dd5..0c07e990e9c5 100644
> > --- a/arch/riscv/kernel/traps_misaligned.c
> > +++ b/arch/riscv/kernel/traps_misaligned.c
> > @@ -16,6 +16,7 @@
> >  #include <asm/entry-common.h>
> >  #include <asm/hwprobe.h>
> >  #include <asm/cpufeature.h>
> > +#include <asm/vector.h>
> >
> >  #define INSN_MATCH_LB                  0x3
> >  #define INSN_MASK_LB                   0x707f
> > @@ -426,6 +427,14 @@ int handle_misaligned_load(struct pt_regs *regs)
> >         if (get_insn(regs, epc, &insn))
> >                 return -1;
> >
> > +#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> > +       if (*this_cpu_ptr(&vector_misaligned_access) =3D=3D RISCV_HWPRO=
BE_VEC_MISALIGNED_UNKNOWN) {
> > +               *this_cpu_ptr(&vector_misaligned_access) =3D RISCV_HWPR=
OBE_VEC_MISALIGNED_UNSUPPORTED;
>=20
> Shouldn't this be EMULATED, given we were just delegated this trap? I
> guess it depends on whether you're going to add support for actually
> handling the misaligned vector trap, as Cl=C3=A9ment mentioned.

Also, we should not actually set EMULATED if we don't actually emulate
it - this patch just advances epc, right? Also, is it even correct to
arbitrarily set this value on a misaligned trap - how do we know if this
was a vector access at this point? Finally, with how handle_misaligned_load=
()
works, aren't we gonna set the scalar misaligned access speed to EMULATED
during this trap even if the trapping instruction is a vector one? That see=
ms
like it should be fixed in a patch of its own.

> Scalar misaligned loads had a history to lean on since the specs were
> always explicit that misaligned loads/store had to be supported one
> way or another. So UNSUPPORTED was a future theoretical value. I
> haven't dug through the specs yet, do you know what the story is for V
> and misaligned loads? My sub-question is what the rules are for
> detecting the difference between EMULATED and UNSUPPORTED.

I mean, if we emulate it, then it's EMULATED. If we don't EMULATE it and
nothing below us emulates it, then it is UNSUPPORTED. The one that has
questionmarks is EMULATED v SLOW, where firmware emulation is
communicated to userspace as SLOW, because we can't really tell that it
is in fact EMULATED.

Cheers,
Conor.

> > +               regs->epc =3D epc + INSN_LEN(insn);
> > +               return 0;
> > +       }
> > +#endif
> > +
> >         regs->epc =3D 0;
> >
> >         if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
> > @@ -625,6 +634,57 @@ static bool check_unaligned_access_emulated(int cp=
u)
> >         return misaligned_emu_detected;
> >  }
> >
> > +#ifdef CONFIG_RISCV_ISA_V
> > +static bool check_vector_unaligned_access(int cpu)
> > +{
> > +       long *mas_ptr =3D per_cpu_ptr(&vector_misaligned_access, cpu);
> > +       struct riscv_isainfo *isainfo =3D &hart_isa[cpu];
> > +       unsigned long tmp_var;
> > +       bool misaligned_vec_suported;
> > +
> > +       if (!riscv_isa_extension_available(isainfo->isa, v))
> > +               return false;
> > +
> > +       /* This case will only happen if a unaligned vector load
> > +        * was called by the kernel before this check
> > +        */
> > +       if (*mas_ptr !=3D RISCV_HWPROBE_VEC_MISALIGNED_UNKNOWN)
> > +               return false;
> > +
> > +       kernel_vector_begin();
> > +       __asm__ __volatile__ (
> > +               ".option push\n\t"
> > +               ".option arch, +v\n\t"
> > +               "       li t1, 0x1\n"                           //size
> > +               "       vsetvli t0, t1, e16, m2, ta, ma\n\t"    // Vect=
ors of 16b
> > +               "       addi t0, %[ptr], 1\n\t"                 // Misa=
lign address
> > +               "       vle16.v v0, (t0)\n\t"                   // Load=
 bytes
> > +               ".option pop\n\t"
> > +               : : [ptr] "r" (&tmp_var) : "v0", "t0", "t1", "memory");
> > +       kernel_vector_end();
> > +
> > +       misaligned_vec_suported =3D (*mas_ptr =3D=3D RISCV_HWPROBE_VEC_=
MISALIGNED_UNKNOWN);
> > +
> > +       return misaligned_vec_suported;
> > +}
> > +#else
> > +static bool check_vector_unaligned_access(int cpu)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> > +bool check_vector_unaligned_access_all_cpus(void)
> > +{
> > +       int cpu;
> > +
> > +       for_each_online_cpu(cpu)
> > +               if (!check_vector_unaligned_access(cpu))
> > +                       return false;
> > +
> > +       return true;
> > +}
>=20
> These functions return a bool, but the bool is never checked. I'm
> guessing that's because you're going to check it in a future patch
> where you decide whether or not to probe for fast/slow?
>=20
>=20
> > +
> >  bool check_unaligned_access_emulated_all_cpus(void)
> >  {
> >         int cpu;
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/ke=
rnel/unaligned_access_speed.c
> > index a9a6bcb02acf..92a84239beaa 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -20,6 +20,7 @@
> >  #define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
> >
> >  DEFINE_PER_CPU(long, misaligned_access_speed);
> > +DEFINE_PER_CPU(long, vector_misaligned_access) =3D RISCV_HWPROBE_VEC_M=
ISALIGNED_UNKNOWN;
> >
> >  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> >  static cpumask_t fast_misaligned_access;
> > @@ -264,6 +265,8 @@ static int check_unaligned_access_all_cpus(void)
> >  {
> >         bool all_cpus_emulated =3D check_unaligned_access_emulated_all_=
cpus();
> >
> > +       check_vector_unaligned_access_all_cpus();
> > +
> >         if (!all_cpus_emulated)
> >                 return check_unaligned_access_speed_all_cpus();
> >
> > @@ -273,6 +276,7 @@ static int check_unaligned_access_all_cpus(void)
> >  static int check_unaligned_access_all_cpus(void)
> >  {
> >         check_unaligned_access_emulated_all_cpus();
> > +       check_vector_unaligned_access_all_cpus();
> >
> >         return 0;
> >  }
> > --
> > 2.43.0
> >
>=20

--BJ5Lnf9kA5JE7RaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCRDwAKCRB4tDGHoIJi
0pnTAP9/S3PgwP0FzLW129s4yzQKlpv67Jvk+Dysq4FH5/KdEQD/aju5bg+cVeCJ
JeJGr51RAawZjRcbFmWAPIvfeZejpQA=
=KIEF
-----END PGP SIGNATURE-----

--BJ5Lnf9kA5JE7RaD--

