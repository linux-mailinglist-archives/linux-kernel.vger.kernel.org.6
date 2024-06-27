Return-Path: <linux-kernel+bounces-232239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B891A59C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F7D1F263AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0901514D28B;
	Thu, 27 Jun 2024 11:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nfhQuxTC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98D4500C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488803; cv=none; b=EsyHCQxP+Zzn2f++rAkXMqICf4KLNOB2ig/5mWl6Z4CX9rhQ3qEPhd65n2cOCcJLf2SHtdrVmlpet+2mBPm3RfZFJxwnv+96UpGci9S4yF2Mm6yQ2z/21W88Xo5MwUELO3ZHU2+omnn7KQpYpMakuMWBN/KHOqm6OGp+ZWd0O6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488803; c=relaxed/simple;
	bh=SzFrq0TILRDjzQBuO6AJ7xTCKlWy20Ur3k+v2OyMFhY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7ReCTWzkLAPGAYgDSzNc+ucOYLSWDfCp++hM8+fh3Q1QnOK+a6djdFrQFpKA/2vIpsZZKre24jScOe3oIS6Oy8X6hhe34l+5OhZflZ5F6nD45CxNwBTyyOw+y9wqE6LxQQNds7M7Woxhc0bUbNkwpjJuo0UydAvujQxcrNXEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nfhQuxTC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719488799; x=1751024799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzFrq0TILRDjzQBuO6AJ7xTCKlWy20Ur3k+v2OyMFhY=;
  b=nfhQuxTCBlh20eXluX9zx/EobYnmVBnFwqSR3jkT4HBDc3/TWOsLviL3
   WvmMXhBuEYJp0HYQf37+gq5UrSEBC8g7At0nCQR9Bcf9ViZjEV8VUPItp
   N07R/o104WrP93SIWp+qQn3zK9LWMCQyz5G0uBS3WR88psHsr9qSBWrz+
   5sCgLhN9roer4SIg3jJNr8iKB4PmgM1a6fWGa7reXrgjG0wUjlbDqoPbK
   Roo2s9XzM49kM1daZIlsBxRyt+v4jy8j3Hxdx9+FV7XOUGhzQvwnLRInb
   ncyofjkEthZ6rXkmHBheS1x1qx+tLUMdoCRU1TZVyxhDEvdwT5s+h50R6
   Q==;
X-CSE-ConnectionGUID: 7WmYFEtPTdmoTmTpDnD+YQ==
X-CSE-MsgGUID: 64FhoZUlSbe1YgKQdzsXqQ==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="asc'?scan'208";a="259450703"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2024 04:46:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Jun 2024 04:46:02 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 27 Jun 2024 04:45:58 -0700
Date: Thu, 27 Jun 2024 12:45:42 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jesse Taube <jesse@rivosinc.com>
CC: <linux-riscv@lists.infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Alexandre Ghiti
	<alexghiti@rivosinc.com>, Masahiro Yamada <masahiroy@kernel.org>, Wende Tan
	<twd2.me@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Sami
 Tolvanen <samitolvanen@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chen Jiahao
	<chenjiahao16@huawei.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, "Vishal
 Moola (Oracle)" <vishal.moola@gmail.com>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
Subject: Re: [PATCH v2 3/3] RISC-V: Use Zkr to seed KASLR base address
Message-ID: <20240627-proven-irritably-33594282739f@wendy>
References: <20240626171652.366415-1-jesse@rivosinc.com>
 <20240626171652.366415-3-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qEqL5X6qBo6BAuYb"
Content-Disposition: inline
In-Reply-To: <20240626171652.366415-3-jesse@rivosinc.com>

--qEqL5X6qBo6BAuYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jesse,

On Wed, Jun 26, 2024 at 01:16:52PM -0400, Jesse Taube wrote:
> Parse the device tree for Zkr in isa string.
> If Zkr is present, use it to seed the kernel base address.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/kernel/pi/Makefile           |  2 +-
>  arch/riscv/kernel/pi/archrandom_early.c | 30 ++++++++
>  arch/riscv/kernel/pi/fdt_early.c        | 94 +++++++++++++++++++++++++
>  arch/riscv/kernel/pi/pi.h               |  3 +
>  arch/riscv/mm/init.c                    |  5 +-
>  5 files changed, 132 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
>=20
> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
> index 1ef7584be0c3..dba902f2a538 100644
> --- a/arch/riscv/kernel/pi/Makefile
> +++ b/arch/riscv/kernel/pi/Makefile
> @@ -33,5 +33,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
>  $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
>  	$(call if_changed_rule,cc_o_c)
> =20
> -obj-y		:=3D cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib=
-fdt.pi.o lib-fdt_ro.pi.o
> +obj-y		:=3D cmdline_early.pi.o fdt_early.pi.o string.pi.o ctype.pi.o lib=
-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
>  extra-y		:=3D $(patsubst %.pi.o,%.o,$(obj-y))
> diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kernel/=
pi/archrandom_early.c
> new file mode 100644
> index 000000000000..c6261165e8a6
> --- /dev/null
> +++ b/arch/riscv/kernel/pi/archrandom_early.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/csr.h>
> +#include <linux/processor.h>
> +
> +#include "pi.h"
> +
> +/*
> + * To avoid rewriting code include asm/archrandom.h and create macros
> + * for the functions that won't be included.
> + */
> +#undef riscv_has_extension_unlikely
> +#define riscv_has_extension_likely(...) false
> +#undef pr_err_once
> +#define pr_err_once(...)
> +
> +#include <asm/archrandom.h>
> +
> +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa)
> +{
> +	unsigned long seed =3D 0;
> +
> +	if (!early_isa_str((const void *)dtb_pa, "zkr"))
> +		return 0;
> +
> +	if (!csr_seed_long(&seed))
> +		return 0;
> +
> +	return seed;
> +}
> diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fdt_=
early.c
> index 40ee299702bf..ba76197b44d1 100644
> --- a/arch/riscv/kernel/pi/fdt_early.c
> +++ b/arch/riscv/kernel/pi/fdt_early.c
> @@ -23,3 +23,97 @@ u64 get_kaslr_seed(uintptr_t dtb_pa)
>  	*prop =3D 0;
>  	return ret;
>  }
> +
> +/* Based off of fdt_stringlist_contains */
> +static int isa_string_contains(const char *strlist, int listlen, const c=
har *str)

The variable names here are needlessly confusing IMO. The function also
returns a bool, not an int.

> +{
> +	int len =3D strlen(str);
> +	const char *p;
> +
> +	while (listlen >=3D len) {
> +		if (strncasecmp(str, strlist, len) =3D=3D 0)
> +			return 1;

How does this handle searching a devicetree containing "rv64ima_zksed_zkr"
for the extension zks? Hint: https://godbolt.org/z/YfhTqe54e
I think this works for fdt_stringlist_contains() because it also
compares the null chars - which you're not doing so I think this also
brakes for something like riscv,isa-extensions =3D "rv64ima\0zksed\0zkr"
while searching for zks.

> +		p =3D memchr(strlist, '_', listlen);

Or how does this handle searching "rv64imafdczkr" for zkr? It's gonna
run right off the end of the string without finding anything, right?

Handling "riscv,isa" is not trivial, but at least the search for extension
approach here skips dealing with some of what has to be done in the "real"
parser with the version numbers...

Maybe we just say screw "riscv,isa", as it's deprecated anyway, and only
add this new feature for "riscv,isa-extensions" which is far simpler to
parse and can be done using off-the-shelf fdt functions?

If not, then I think we should use fdt_stringlist_contains verbatim for
"riscv,isa-extensions" and introduce a custom function for "riscv,isa"
only.

> +		if (!p)
> +			p =3D memchr(strlist, '\0', listlen);
> +		if (!p)
> +			return 0; /* malformed strlist.. */
> +		listlen -=3D (p - strlist) + 1;
> +		strlist =3D p + 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Based off of fdt_nodename_eq_ */

Why can't we just use fdt_nodename_eq?

> +static int fdt_node_name_eq(const void *fdt, int offset,
> +			    const char *s)
> +{
> +	int olen;
> +	int len =3D strlen(s);
> +	const char *p =3D fdt_get_name(fdt, offset, &olen);
> +
> +	if (!p || olen < len)
> +		/* short match */
> +		return 0;
> +
> +	if (memcmp(p, s, len) !=3D 0)
> +		return 0;
> +
> +	if (p[len] =3D=3D '\0')
> +		return 1;
> +	else if (!memchr(s, '@', len) && (p[len] =3D=3D '@'))
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +/*
> + * Returns true if the extension is in the isa string
> + * Returns false if the extension is not found
> + */
> +static bool get_ext_named(const void *fdt, int node, const char *name)

Could you rename this function please? Having something named "get" that
returns a bool, and not an "ext_named" is odd - and it'd be self
explanatory in that case. Maybe it can just be moved into the sole caller
and isn't needed?

> +{
> +	const void *prop;
> +	int len;
> +
> +	prop =3D fdt_getprop(fdt, node, "riscv,isa-base", &len);
> +	if (prop && isa_string_contains(prop, len, name))
> +		return true;

This shouldn't be here, there'll not be an extension in this property.

> +	prop =3D fdt_getprop(fdt, node, "riscv,isa-extensions", &len);
> +	if (prop && isa_string_contains(prop, len, name))
> +		return true;
> +
> +	prop =3D fdt_getprop(fdt, node, "riscv,isa", &len);
> +	if (prop && isa_string_contains(prop, len, name))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Returns true if the extension is in the isa string on all cpus

Shouldn't we only be checking CPUs that are not disabled or reserved,
rather than all CPUs? To use Zkr for KASLR this is kinda irrelevant
since really we only care about whether or not the boot CPU has Zkr,
but in general we only want to consider CPUs that we can actually use.
For example, if you did this for FPU support with mpfs.dtsi, you'd get
told that the F/D extensions were not present cos hart 0 doesn't have
them, even though it's disabled and will not be used by Linux.

> + * Returns false if the extension is not found
> + */
> +bool early_isa_str(const void *fdt, const char *ext_name)

Could you try to match the naming of the stuff used outside of pi?
Maybe early_isa_ext_available()?

Thanks for the update,
Conor.

> +{
> +	int node, parent;
> +	bool ret =3D false;
> +
> +	parent =3D fdt_path_offset(fdt, "/cpus");
> +	if (parent < 0)
> +		return false;
> +
> +	fdt_for_each_subnode(node, fdt, parent) {
> +		if (!fdt_node_name_eq(fdt, node, "cpu"))
> +			continue;
> +
> +		if (!get_ext_named(fdt, node, ext_name))
> +			return false;
> +
> +		ret =3D true;
> +	}
> +
> +	return ret;
> +}
> diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
> index 65da99466baf..26e7e5f84a30 100644
> --- a/arch/riscv/kernel/pi/pi.h
> +++ b/arch/riscv/kernel/pi/pi.h
> @@ -4,6 +4,8 @@
> =20
>  #include <linux/types.h>
> =20
> +bool early_isa_str(const void *fdt, const char *ext_name);
> +
>  /*
>   * The folowing functions are exported (but prefixed) declare them here =
so
>   * that LLVM does not complain it lacks the 'static' keyword (which, if
> @@ -11,6 +13,7 @@
>   */
> =20
>  u64 get_kaslr_seed(uintptr_t dtb_pa);
> +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
>  bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>  u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
> =20
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 9940171c79f0..bfb068dc4a64 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
>  #ifdef CONFIG_RANDOMIZE_BASE
>  extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
>  extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
> +extern u64 __init __pi_get_kaslr_seed_zkr(const uintptr_t dtb_pa);
> =20
>  static int __init print_nokaslr(char *p)
>  {
> @@ -1045,10 +1046,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> =20
>  #ifdef CONFIG_RANDOMIZE_BASE
>  	if (!__pi_set_nokaslr_from_cmdline(dtb_pa)) {
> -		u64 kaslr_seed =3D __pi_get_kaslr_seed(dtb_pa);
> +		u64 kaslr_seed =3D __pi_get_kaslr_seed_zkr(dtb_pa);
>  		u32 kernel_size =3D (uintptr_t)(&_end) - (uintptr_t)(&_start);
>  		u32 nr_pos;
> =20
> +		if (kaslr_seed =3D=3D 0)
> +			kaslr_seed =3D __pi_get_kaslr_seed(dtb_pa);
>  		/*
>  		 * Compute the number of positions available: we are limited
>  		 * by the early page table that only has one PUD and we must
> --=20
> 2.45.2
>=20

--qEqL5X6qBo6BAuYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn1Q5gAKCRB4tDGHoIJi
0iBVAP0TyL9i1EkBYAZn7jPR7ReYfKTLUdUezvtjJ2hrWWLyNgD8D4R2MvTObyUL
wirRhv4Tb2aN8Ty7B3OXIijP09EVRAo=
=oHGR
-----END PGP SIGNATURE-----

--qEqL5X6qBo6BAuYb--

