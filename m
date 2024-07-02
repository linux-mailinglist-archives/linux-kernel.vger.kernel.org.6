Return-Path: <linux-kernel+bounces-237330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9578191EF51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FC51F2276D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C568184DF1;
	Tue,  2 Jul 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ieoEgrqd"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299453A8D0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719902760; cv=none; b=Hg6VxfVHp8+UQ2J1rt/t6zQ0iWPlW1qZPUIRd/EwXuNnFodPXaJDplcTCc5UVBhsGYniPbENObWK2qQ//B9qhgJWzZiEJEWt78JDfh0A9rabuNwQTNUoe/k+b5fz+cpTIEpMbV6gwAodQ3FurkeB+HHwYJrqu2HtiLfaTqNwmu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719902760; c=relaxed/simple;
	bh=39HLs3FCH+j2lnFwr4xO6xOde6qEy6tdKiIkMc74iIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqW7TFHbWjy5X0lzh+drr6brY9SgSltjyp/CRgNWl7BpENeVA3UYwrr43OftJPxg7UC/8mGLSn8OigFvdYMrmAyRrcFBmn0n5e/jC3MGg2MCZMUFD6EfVX+v67X0h6z1mEkA8xy3Dt9ctTDRX2yDBKke6jNMl2NX6ItlF8ymEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ieoEgrqd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72477a60fbso447577366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 23:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719902756; x=1720507556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKewnqnxY7aoOaplH+nWasS/+enKSoZGeGRwd3eNINU=;
        b=ieoEgrqdYShzvfMnIT8JM/8OKUcAiEEgymyyZ8a2DJuJweaN4gC2lKUe9mE7PUjPun
         Kv+qoBPkKWAFCXmYymBOJEkZ8Di8MRajFsEP/Kiiwe8wNoGh05u+vtfpm427RYWPIb8E
         cNvFxC8qMp6nVJMwxsPH5/dKEKmA6+RuLifonukyqZjGomtZs3EgHZFKH+zkK6ejCH3O
         MymsRWRyCtZD4K2eW0mkBhvIputkHmvBohZWp7CWs8N/j2dNDIXM+LS7p2AAF9jYO5wK
         DI/Cw5j/dFk2DC5k8Yxwh85BLSgcy36X+D1AboCo4L4P+xiUL/bkII2pwT538O0TNoBa
         M9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719902756; x=1720507556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKewnqnxY7aoOaplH+nWasS/+enKSoZGeGRwd3eNINU=;
        b=j3jk1mJqUPsHIv/0pYf4nxrzFVsskyQz0aZFVOM2Y1D4BhlSWs14Sxeu2gMgad1vrs
         VH5jtL31v80JV/HKZkK0c95DreZKBneU1Bhz5NeDqTB5O8NGBNvAK0w23Fi+JJWllfVD
         6poiIbyHm5ZBUdADhz9I/JUw/9Qu/H0vmzwYk41l7pRYD6dfyoewBOeW/FakyaaNEBLM
         WmVE5t9KfsONlsnLuTQ688PQEB4GUAuRlMPC5Z0rbu2V/3xi9lHkEqE0pWxfqdoUYm/u
         8c/4gsjr/wmMmrbNgn75qiVezzIis37izvELQVhSf/SRjJcaoBcJyEb+gNmEN3HMSjbN
         LvpA==
X-Forwarded-Encrypted: i=1; AJvYcCV87Q9fV+BAk9BDNGwlqZprN8mMZUx1vFBjx2elZL75B42jFeOPQmJ//iW7bJWDn6FccoTEEHAW7VICln+vY6Qf5tJKxchEw8P30amm
X-Gm-Message-State: AOJu0YyCnWU67fu3VyeZcBTb9PU1yn4mOxvhN2BsuOZdHTFR3FRTlHUF
	G2ygWapRgWhPR1Asze/wXc/wOkTThXABK/Cedc8EDTJP8xHQPgVgFNsV49++7tkVZY1l+c+6xSh
	A/6AhuN1nH11q4B0XesKJn9sDXRooS560h4F0TQ==
X-Google-Smtp-Source: AGHT+IEascvF38kAc4A+0pgwsaI6bdj7gAzwlhgZ0bZsErX4s5vHfwB6qWm2BdLiPXiqmgERgyG68icI94K30vY6Hxg=
X-Received: by 2002:a17:906:2dcf:b0:a72:995d:d09e with SMTP id
 a640c23a62f3a-a75144a9179mr453646366b.57.1719902756328; Mon, 01 Jul 2024
 23:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701185132.319995-1-jesse@rivosinc.com> <20240701185132.319995-5-jesse@rivosinc.com>
 <ZoOCeMUTIgnA72xj@ghost>
In-Reply-To: <ZoOCeMUTIgnA72xj@ghost>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 2 Jul 2024 08:45:44 +0200
Message-ID: <CAHVXubiikxy6r2On_+zUfcqyXcBUG6rfHCUZoAVxDk6S2VG5vg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] RISC-V: Use Zkr to seed KASLR base address
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Wende Tan <twd2.me@gmail.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Sami Tolvanen <samitolvanen@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On Tue, Jul 2, 2024 at 6:30=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Mon, Jul 01, 2024 at 02:51:32PM -0400, Jesse Taube wrote:
> > Parse the device tree for Zkr in the isa string.
> > If Zkr is present, use it to seed the kernel base address.
> >
> > On an ACPI system, as of this commit, there is no easy way to check if
> > Zkr is present. Blindly running the instruction isn't an option as;
> > we have to be able to trust the firmware.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > V1 -> V2:
> >  - Almost entire rewrite
> > V2 -> V3:
> >  - Dont parse iscv,isa-base
> >  - Move fdt_early_match_extension_isa in pi.h under comment
> >  - Only check enabled cpus
> >  - Rename early_isa_str to fdt_early_match_extension_isa
> >  - Rename get_ext_named to early_cpu_isa_ext_available
> >  - Rewrite isa_string_contains
> >  - Update commit description
> >  - Use fdt_stringlist_contains for riscv,isa-extensions
> > ---
> >  arch/riscv/kernel/pi/Makefile           |   2 +-
> >  arch/riscv/kernel/pi/archrandom_early.c |  30 +++++
> >  arch/riscv/kernel/pi/fdt_early.c        | 160 ++++++++++++++++++++++++
> >  arch/riscv/kernel/pi/pi.h               |   3 +
> >  arch/riscv/mm/init.c                    |   5 +-
> >  5 files changed, 198 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
> >
> > diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makef=
ile
> > index 1ef7584be0c3..dba902f2a538 100644
> > --- a/arch/riscv/kernel/pi/Makefile
> > +++ b/arch/riscv/kernel/pi/Makefile
> > @@ -33,5 +33,5 @@ $(obj)/string.o: $(srctree)/lib/string.c FORCE
> >  $(obj)/ctype.o: $(srctree)/lib/ctype.c FORCE
> >       $(call if_changed_rule,cc_o_c)
> >
> > -obj-y                :=3D cmdline_early.pi.o fdt_early.pi.o string.pi.=
o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o
> > +obj-y                :=3D cmdline_early.pi.o fdt_early.pi.o string.pi.=
o ctype.pi.o lib-fdt.pi.o lib-fdt_ro.pi.o archrandom_early.pi.o
>
> When CONFIG_FORTIFY_SOURCE is enabled, the string functions try to
> reference `__fortify_panic` which gets aliased to `__pi___fortify_panic`
> and causes lld to fail:
>
> ld.lld: error: undefined hidden symbol: __pi___fortify_panic
> >>> referenced by fdt_early.c:24 (arch/riscv/kernel/pi/fdt_early.c:24)
> >>>               arch/riscv/kernel/pi/fdt_early.pi.o:(__pi_fdt_early_mat=
ch_extension_isa) in archive vmlinux.a
>
> This early in boot __fortify_panic isn't supported. Can you add
> `CFLAGS_fdt_early.o +=3D -D__NO_FORTIFY` next to the same addition for
> cmdline_early and fdt_early?

With this ^ fixed, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

>
> The rest of this looks go to me (just send a new version with this simple=
 fix).
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>
> >  extra-y              :=3D $(patsubst %.pi.o,%.o,$(obj-y))
> > diff --git a/arch/riscv/kernel/pi/archrandom_early.c b/arch/riscv/kerne=
l/pi/archrandom_early.c
> > new file mode 100644
> > index 000000000000..3f05d3cf3b7b
> > --- /dev/null
> > +++ b/arch/riscv/kernel/pi/archrandom_early.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <asm/csr.h>
> > +#include <linux/processor.h>
> > +
> > +#include "pi.h"
> > +
> > +/*
> > + * To avoid rewriting code include asm/archrandom.h and create macros
> > + * for the functions that won't be included.
> > + */
> > +#undef riscv_has_extension_unlikely
> > +#define riscv_has_extension_likely(...) false
> > +#undef pr_err_once
> > +#define pr_err_once(...)
> > +
> > +#include <asm/archrandom.h>
> > +
> > +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa)
> > +{
> > +     unsigned long seed =3D 0;
> > +
> > +     if (!fdt_early_match_extension_isa((const void *)dtb_pa, "zkr"))
> > +             return 0;
> > +
> > +     if (!csr_seed_long(&seed))
> > +             return 0;
> > +
> > +     return seed;
> > +}
> > diff --git a/arch/riscv/kernel/pi/fdt_early.c b/arch/riscv/kernel/pi/fd=
t_early.c
> > index 40ee299702bf..49ff5360bf87 100644
> > --- a/arch/riscv/kernel/pi/fdt_early.c
> > +++ b/arch/riscv/kernel/pi/fdt_early.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/types.h>
> >  #include <linux/init.h>
> >  #include <linux/libfdt.h>
> > +#include <linux/ctype.h>
> >
> >  #include "pi.h"
> >
> > @@ -23,3 +24,162 @@ u64 get_kaslr_seed(uintptr_t dtb_pa)
> >       *prop =3D 0;
> >       return ret;
> >  }
> > +
> > +/**
> > + *  fdt_device_is_available - check if a device is available for use
> > + *
> > + * @fdt: pointer to the device tree blob
> > + * @node: offset of the node whose property to find
> > + *
> > + *  Returns true if the status property is absent or set to "okay" or =
"ok",
> > + *  false otherwise
> > + */
> > +static bool fdt_device_is_available(const void *fdt, int node)
> > +{
> > +     const char *status;
> > +     int statlen;
> > +
> > +     status =3D fdt_getprop(fdt, node, "status", &statlen);
> > +     if (!status)
> > +             return true;
> > +
> > +     if (statlen > 0) {
> > +             if (!strcmp(status, "okay") || !strcmp(status, "ok"))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/* Copy of fdt_nodename_eq_ */
> > +static int fdt_node_name_eq(const void *fdt, int offset,
> > +                         const char *s)
> > +{
> > +     int olen;
> > +     int len =3D strlen(s);
> > +     const char *p =3D fdt_get_name(fdt, offset, &olen);
> > +
> > +     if (!p || olen < len)
> > +             /* short match */
> > +             return 0;
> > +
> > +     if (memcmp(p, s, len) !=3D 0)
> > +             return 0;
> > +
> > +     if (p[len] =3D=3D '\0')
> > +             return 1;
> > +     else if (!memchr(s, '@', len) && (p[len] =3D=3D '@'))
> > +             return 1;
> > +     else
> > +             return 0;
> > +}
> > +
> > +/**
> > + *  isa_string_contains - check if isa string contains an extension
> > + *
> > + * @isa_str: isa string to search
> > + * @ext_name: the extension to search for
> > + *
> > + *  Returns true if the extension is in the given isa string,
> > + *  false otherwise
> > + */
> > +static bool isa_string_contains(const char *isa_str, const char *ext_n=
ame)
> > +{
> > +     size_t i, single_end, len =3D strlen(ext_name);
> > +     char ext_end;
> > +
> > +     /* Error must contain rv32/64 */
> > +     if (strlen(isa_str) < 4)
> > +             return false;
> > +
> > +     if (len =3D=3D 1) {
> > +             single_end =3D strcspn(isa_str, "sSxXzZ");
> > +             /* Search for single chars between rv32/64 and multi-lett=
er extensions */
> > +             for (i =3D 4; i < single_end; i++) {
> > +                     if (tolower(isa_str[i]) =3D=3D ext_name[0])
> > +                             return true;
> > +             }
> > +             return false;
> > +     }
> > +
> > +     /* Skip to start of multi-letter extensions */
> > +     isa_str =3D strpbrk(isa_str, "sSxXzZ");
> > +     while (isa_str) {
> > +             if (strncasecmp(isa_str, ext_name, len) =3D=3D 0) {
> > +                     ext_end =3D isa_str[len];
> > +                     /* Check if matches the whole extension excluding=
 version. */
> > +                     if (ext_end =3D=3D '\0' || ext_end =3D=3D '_' || =
isdigit(ext_end))
> > +                             return true;
> > +             }
> > +             /* Multi-letter extensions must be split from other multi=
-letter
> > +              * extensions with an "_", the end of a multi-letter exte=
nsion will
> > +              * either be the null character or the "_" at the start o=
f the next
> > +              * multi-letter extension.
> > +              */
> > +             isa_str =3D strchr(isa_str, '_');
> > +             if (isa_str)
> > +                     isa_str++;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +/**
> > + *  early_cpu_isa_ext_available - check if cpu node has an extension
> > + *
> > + * @fdt: pointer to the device tree blob
> > + * @node: offset of the cpu node
> > + * @ext_name: the extension to search for
> > + *
> > + *  Returns true if the cpu node has the extension,
> > + *  false otherwise
> > + */
> > +static bool early_cpu_isa_ext_available(const void *fdt, int node, con=
st char *ext_name)
> > +{
> > +     const void *prop;
> > +     int len;
> > +
> > +     prop =3D fdt_getprop(fdt, node, "riscv,isa-extensions", &len);
> > +     if (prop && fdt_stringlist_contains(prop, len, ext_name))
> > +             return true;
> > +
> > +     prop =3D fdt_getprop(fdt, node, "riscv,isa", &len);
> > +     if (prop && isa_string_contains(prop, ext_name))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +/**
> > + *  fdt_early_match_extension_isa - check if all cpu nodes have an ext=
ension
> > + *
> > + * @fdt: pointer to the device tree blob
> > + * @ext_name: the extension to search for
> > + *
> > + *  Returns true if the all available the cpu nodes have the extension=
,
> > + *  false otherwise
> > + */
> > +bool fdt_early_match_extension_isa(const void *fdt, const char *ext_na=
me)
> > +{
> > +     int node, parent;
> > +     bool ret =3D false;
> > +
> > +     parent =3D fdt_path_offset(fdt, "/cpus");
> > +     if (parent < 0)
> > +             return false;
> > +
> > +     fdt_for_each_subnode(node, fdt, parent) {
> > +             if (!fdt_node_name_eq(fdt, node, "cpu"))
> > +                     continue;
> > +
> > +             if (!fdt_device_is_available(fdt, node))
> > +                     continue;
> > +
> > +             if (!early_cpu_isa_ext_available(fdt, node, ext_name))
> > +                     return false;
> > +
> > +             ret =3D true;
> > +     }
> > +
> > +     return ret;
> > +}
> > diff --git a/arch/riscv/kernel/pi/pi.h b/arch/riscv/kernel/pi/pi.h
> > index 493c8cb7c0e6..21141d84fea6 100644
> > --- a/arch/riscv/kernel/pi/pi.h
> > +++ b/arch/riscv/kernel/pi/pi.h
> > @@ -11,7 +11,10 @@
> >   */
> >
> >  u64 get_kaslr_seed(uintptr_t dtb_pa);
> > +u64 get_kaslr_seed_zkr(const uintptr_t dtb_pa);
> >  bool set_nokaslr_from_cmdline(uintptr_t dtb_pa);
> >  u64 set_satp_mode_from_cmdline(uintptr_t dtb_pa);
> >
> > +bool fdt_early_match_extension_isa(const void *fdt, const char *ext_na=
me);
> > +
> >  #endif /* _RISCV_PI_H_ */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 9940171c79f0..bfb068dc4a64 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -1025,6 +1025,7 @@ static void __init pt_ops_set_late(void)
> >  #ifdef CONFIG_RANDOMIZE_BASE
> >  extern bool __init __pi_set_nokaslr_from_cmdline(uintptr_t dtb_pa);
> >  extern u64 __init __pi_get_kaslr_seed(uintptr_t dtb_pa);
> > +extern u64 __init __pi_get_kaslr_seed_zkr(const uintptr_t dtb_pa);
> >
> >  static int __init print_nokaslr(char *p)
> >  {
> > @@ -1045,10 +1046,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_p=
a)
> >
> >  #ifdef CONFIG_RANDOMIZE_BASE
> >       if (!__pi_set_nokaslr_from_cmdline(dtb_pa)) {
> > -             u64 kaslr_seed =3D __pi_get_kaslr_seed(dtb_pa);
> > +             u64 kaslr_seed =3D __pi_get_kaslr_seed_zkr(dtb_pa);
> >               u32 kernel_size =3D (uintptr_t)(&_end) - (uintptr_t)(&_st=
art);
> >               u32 nr_pos;
> >
> > +             if (kaslr_seed =3D=3D 0)
> > +                     kaslr_seed =3D __pi_get_kaslr_seed(dtb_pa);
> >               /*
> >                * Compute the number of positions available: we are limi=
ted
> >                * by the early page table that only has one PUD and we m=
ust
> > --
> > 2.45.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

