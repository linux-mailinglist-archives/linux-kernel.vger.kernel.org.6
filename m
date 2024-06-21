Return-Path: <linux-kernel+bounces-224081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B2F911CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C941C22269
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75016B750;
	Fri, 21 Jun 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IfvNIaIm"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6416B723
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955445; cv=none; b=mWwiP1NoQGtCJb61Z3HKQONji6xLwH+PQtVCDDJOIB/Dzob2jdsZ9+DQwPurvrqWwuC+PVfGqbyHV/0QwRMY/8vQTV0lJUpei8GsUdspLvkoSHL4b/7pTGJXFvGd6D47/MVIPOMHjUkTHLpAA97QeU+mTb3gysaZ/GmcdCpzy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955445; c=relaxed/simple;
	bh=snJ6bw1NKBHYzsNH2At0TbJgS94pJf1y1JuZFczJQ6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgKniiZTUdZfRwQiQO9wn1whOK+OLHeXgIamxz0vcAXoB5rl93QTcHLpHcAgc0dOL+P9HyUpkMsuBKoZ3sTgbEn33d69Bb9mDiGhuhRUW98G28ABQlOmDF6Ox5frrpc0bDqulHsG6dgG2lL7WkP35E7VEPZcmzVK+qa0uUG0Tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IfvNIaIm; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02a6d4bdbeso1616454276.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718955442; x=1719560242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVGKIGtbN1qOmtkGoWUSAn3mE0NAxe+5wRu1cePkLYA=;
        b=IfvNIaIm5IDQYCLC+0cgiysI6oGEx/Hdb4j6/ZwFi1ZjPb2sxWY1+vs3wXUVBmJu+W
         P7aXBezQ5E2hT4z+4G8P+9fnZX275qyBs8Ay5V8AC4C99J7TdT68pVi7pWP154o/W/9m
         KccHv6cOGs5FrEZeOr8uHIrOvnuWs0+T/Q04nPBTryHDwr71Or1LNRhOMyBlONsmAHuH
         znAUjiKtUylQDbo2Y0p/yeacysfrbP4hkn4zvtrMu815ctm46IQ8FkcYL9gAN4JF0zwE
         tlJPqSp8Ozs03/Ri93j3XRUTGeP+aHSTZJ/BZykMj2Pu4i/2DA9VS4v7HMMSW7krScDb
         i7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955442; x=1719560242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVGKIGtbN1qOmtkGoWUSAn3mE0NAxe+5wRu1cePkLYA=;
        b=mmV+m8jQE11t3HtiAL/oT33o3pP2HIBgJTbXpNaROZMujZSzzUMvZJAg3hPfz1LODi
         IaTwoXgD+IGok3IHykqlTRGSMgTbvoVkTh464qzqSTJxUQi5wMAUoEV0n4/IHcoaefEs
         t0YDtJlk9UGrqsDi9Bk5wlF/SubzGvvcCYxzpwdVbhXXELt8Phh6vaeagdJ2W4HZejW3
         JYeao+tayGtOYeRyMI6eoo0HBny2fQbLnToe3lsfIQzB6JLCLmgVw8WjXZEYN1e4I25a
         0AUx6IbzTsz2BQqBlckQM45XVC8p5UoInyffwpvjZvGe7v2x7Opt6ZcQT3Ce01OdCA7R
         R+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW+nSQXHlzmsDjfprvtDgx/pmZA5gOODSL1E8XIq4NCG7KHCY6JwHRL/nVPiwwHaUR9iBIwNWRxXVKfh85Pb+iXP+W8CykOuLAneovK
X-Gm-Message-State: AOJu0Yz4bocht/aorVbEAf6I1MNI+RDX2zT+r0U7ZryAFFaHWTK/vAUQ
	Abbt2GPIxWX3/zQc0BK/PGQjGlcpq/LBWnjqrl96XKN7CiIlf22N1/SAvD6oCpx4f1D70IVj5bx
	TfpSYt5VHQvt47FxAia5O/0Q6ozjEgQzM2PhuOA==
X-Google-Smtp-Source: AGHT+IGCUI/2RcG9U2KXGR/Gm7t5AAmQGzd5/hNjl0SlyJdnDxaiJ3v3Wd4AGss2kYY23D0mij5DmcCeuSYEjwYcMjM=
X-Received: by 2002:a05:6902:1885:b0:e02:65ad:9247 with SMTP id
 3f1490d57ef6-e02be1719cfmr9260104276.35.1718955442404; Fri, 21 Jun 2024
 00:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
 <20240609-support_vendor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com>
In-Reply-To: <20240609-support_vendor_extensions-v2-1-9a43f1fdcbb9@rivosinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 21 Jun 2024 15:37:11 +0800
Message-ID: <CABgGipVUswa++ww8oMVRciSz3o=SdrL83DtevNBNrTb-9TuzOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] riscv: Extend cpufeature.c to detect vendor extensions
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor.dooley@microchip.com>, 
	Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 12:34=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> Instead of grouping all vendor extensions into the same riscv_isa_ext
> that standard instructions use, create a struct
> "riscv_isa_vendor_ext_data_list" that allows each vendor to maintain
> their vendor extensions independently of the standard extensions.
> xandespmu is currently the only vendor extension so that is the only
> extension that is affected by this change.
>
> An additional benefit of this is that the extensions of each vendor can
> be conditionally enabled. A config RISCV_ISA_VENDOR_EXT_ANDES has been
> added to allow for that.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  arch/riscv/Kconfig                               |   2 +
>  arch/riscv/Kconfig.vendor                        |  19 ++++
>  arch/riscv/errata/andes/errata.c                 |   3 +
>  arch/riscv/errata/sifive/errata.c                |   3 +
>  arch/riscv/errata/thead/errata.c                 |   3 +
>  arch/riscv/include/asm/cpufeature.h              |  18 +++
>  arch/riscv/include/asm/hwcap.h                   |   1 -
>  arch/riscv/include/asm/vendor_extensions.h       |  49 ++++++++
>  arch/riscv/include/asm/vendor_extensions/andes.h |  19 ++++
>  arch/riscv/kernel/Makefile                       |   2 +
>  arch/riscv/kernel/cpufeature.c                   | 137 +++++++++++++++++=
------
>  arch/riscv/kernel/vendor_extensions.c            |  56 +++++++++
>  arch/riscv/kernel/vendor_extensions/Makefile     |   3 +
>  arch/riscv/kernel/vendor_extensions/andes.c      |  18 +++
>  drivers/perf/riscv_pmu_sbi.c                     |  10 +-
>  15 files changed, 306 insertions(+), 37 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0525ee2d63c7..4ae2bf4dd497 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -774,6 +774,8 @@ config RISCV_EFFICIENT_UNALIGNED_ACCESS
>
>  endchoice
>
> +source "arch/riscv/Kconfig.vendor"
> +
>  endmenu # "Platform type"
>
>  menu "Kernel features"
> diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> new file mode 100644
> index 000000000000..6f1cdd32ed29
> --- /dev/null
> +++ b/arch/riscv/Kconfig.vendor
> @@ -0,0 +1,19 @@
> +menu "Vendor extensions"
> +
> +config RISCV_ISA_VENDOR_EXT
> +       bool
> +
> +menu "Andes"
> +config RISCV_ISA_VENDOR_EXT_ANDES
> +       bool "Andes vendor extension support"
> +       select RISCV_ISA_VENDOR_EXT
> +       default y
> +       help
> +         Say N here if you want to disable all Andes vendor extension
> +         support. This will cause any Andes vendor extensions that are
> +         requested by hardware probing to be ignored.
> +
> +         If you don't know what to do here, say Y.
> +endmenu
> +
> +endmenu
> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/e=
rrata.c
> index f2708a9494a1..fc1a34faa5f3 100644
> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -17,6 +17,7 @@
>  #include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
>
>  #define ANDES_AX45MP_MARCHID           0x8000000000008a45UL
>  #define ANDES_AX45MP_MIMPID            0x500UL
> @@ -65,6 +66,8 @@ void __init_or_module andes_errata_patch_func(struct al=
t_entry *begin, struct al
>                                               unsigned long archid, unsig=
ned long impid,
>                                               unsigned int stage)
>  {
> +       BUILD_BUG_ON(ERRATA_ANDES_NUMBER >=3D RISCV_VENDOR_EXT_ALTERNATIV=
ES_BASE);
> +
>         if (stage =3D=3D RISCV_ALTERNATIVES_BOOT)
>                 errata_probe_iocp(stage, archid, impid);
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive=
/errata.c
> index 716cfedad3a2..cea3b96ade11 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -12,6 +12,7 @@
>  #include <asm/alternative.h>
>  #include <asm/vendorid_list.h>
>  #include <asm/errata_list.h>
> +#include <asm/vendor_extensions.h>
>
>  struct errata_info_t {
>         char name[32];
> @@ -96,6 +97,8 @@ void sifive_errata_patch_func(struct alt_entry *begin, =
struct alt_entry *end,
>         u32 cpu_apply_errata =3D 0;
>         u32 tmp;
>
> +       BUILD_BUG_ON(ERRATA_SIFIVE_NUMBER >=3D RISCV_VENDOR_EXT_ALTERNATI=
VES_BASE);
> +
>         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>                 return;
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/e=
rrata.c
> index bf6a0a6318ee..f5120e07c318 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -18,6 +18,7 @@
>  #include <asm/io.h>
>  #include <asm/patch.h>
>  #include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
>
>  #define CSR_TH_SXSTATUS                0x5c0
>  #define SXSTATUS_MAEE          _AC(0x200000, UL)
> @@ -166,6 +167,8 @@ void thead_errata_patch_func(struct alt_entry *begin,=
 struct alt_entry *end,
>         u32 tmp;
>         void *oldptr, *altptr;
>
> +       BUILD_BUG_ON(ERRATA_THEAD_NUMBER >=3D RISCV_VENDOR_EXT_ALTERNATIV=
ES_BASE);
> +
>         for (alt =3D begin; alt < end; alt++) {
>                 if (alt->vendor_id !=3D THEAD_VENDOR_ID)
>                         continue;
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm=
/cpufeature.h
> index 347805446151..550d661dc78d 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -33,6 +33,24 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
>
>  void riscv_user_isa_enable(void);
>
> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {     \
> +       .name =3D #_name,                                                =
         \
> +       .property =3D #_name,                                            =
         \
> +       .id =3D _id,                                                     =
         \
> +       .subset_ext_ids =3D _subset_exts,                                =
         \
> +       .subset_ext_size =3D _subset_exts_size                           =
         \
> +}
> +
> +#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> +
> +/* Used to declare pure "lasso" extension (Zk for instance) */
> +#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> +       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, =
ARRAY_SIZE(_bundled_exts))
> +
> +/* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
> +#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> +       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> +
>  #if defined(CONFIG_RISCV_MISALIGNED)
>  bool check_unaligned_access_emulated_all_cpus(void);
>  void unaligned_emulation_finish(void);
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e17d0078a651..1f2d2599c655 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -80,7 +80,6 @@
>  #define RISCV_ISA_EXT_ZFA              71
>  #define RISCV_ISA_EXT_ZTSO             72
>  #define RISCV_ISA_EXT_ZACAS            73
> -#define RISCV_ISA_EXT_XANDESPMU                74
>
>  #define RISCV_ISA_EXT_XLINUXENVCFG     127
>
> diff --git a/arch/riscv/include/asm/vendor_extensions.h b/arch/riscv/incl=
ude/asm/vendor_extensions.h
> new file mode 100644
> index 000000000000..5fca550fc1f6
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2024 Rivos, Inc
> + */
> +
> +#ifndef _ASM_VENDOR_EXTENSIONS_H
> +#define _ASM_VENDOR_EXTENSIONS_H
> +
> +#include <asm/cpufeature.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/types.h>
> +
> +/*
> + * The extension keys of each vendor must be strictly less than this val=
ue.
> + */
> +#define RISCV_ISA_VENDOR_EXT_MAX 32
> +
> +struct riscv_isavendorinfo {
> +       DECLARE_BITMAP(isa, RISCV_ISA_VENDOR_EXT_MAX);
> +};
> +
> +struct riscv_isa_vendor_ext_data_list {
> +       bool is_initialized;
> +       const size_t ext_data_count;
> +       const struct riscv_isa_ext_data *ext_data;
> +       struct riscv_isavendorinfo per_hart_isa_bitmap[NR_CPUS];
> +       struct riscv_isavendorinfo all_harts_isa_bitmap;
> +};
> +
> +extern struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[=
];
> +
> +extern const size_t riscv_isa_vendor_ext_list_size;
> +
> +/*
> + * The alternatives need some way of distinguishing between vendor exten=
sions
> + * and errata. Incrementing all of the vendor extension keys so they are=
 at
> + * least 0x8000 accomplishes that.
> + */
> +#define RISCV_VENDOR_EXT_ALTERNATIVES_BASE     0x8000
> +
> +#define VENDOR_EXT_ALL_CPUS                    -1
> +
> +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendo=
r, unsigned int bit);
> +#define riscv_isa_vendor_extension_available(vendor, ext)      \
> +       __riscv_isa_vendor_extension_available(VENDOR_EXT_ALL_CPUS, vendo=
r, \
> +                                              RISCV_ISA_VENDOR_EXT_##ext=
)
> +
> +#endif /* _ASM_VENDOR_EXTENSIONS_H */
> diff --git a/arch/riscv/include/asm/vendor_extensions/andes.h b/arch/risc=
v/include/asm/vendor_extensions/andes.h
> new file mode 100644
> index 000000000000..7bb2fc43438f
> --- /dev/null
> +++ b/arch/riscv/include/asm/vendor_extensions/andes.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RISCV_VENDOR_EXTENSIONS_ANDES_H
> +#define _ASM_RISCV_VENDOR_EXTENSIONS_ANDES_H
> +
> +#include <asm/vendor_extensions.h>
> +
> +#include <linux/types.h>
> +
> +#define RISCV_ISA_VENDOR_EXT_XANDESPMU         0
> +
> +/*
> + * Extension keys should be strictly less than max.
> + * It is safe to increment this when necessary.
> + */
> +#define RISCV_ISA_VENDOR_EXT_MAX_ANDES                 32
> +
> +extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_a=
ndes;
> +
> +#endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 5b243d46f4b1..b0aea202273d 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -58,6 +58,8 @@ obj-y +=3D riscv_ksyms.o
>  obj-y  +=3D stacktrace.o
>  obj-y  +=3D cacheinfo.o
>  obj-y  +=3D patch.o
> +obj-y  +=3D vendor_extensions.o
> +obj-y  +=3D vendor_extensions/
>  obj-y  +=3D probes/
>  obj-y  +=3D tests/
>  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 5ef48cb20ee1..f2c24820700b 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -24,6 +24,7 @@
>  #include <asm/processor.h>
>  #include <asm/sbi.h>
>  #include <asm/vector.h>
> +#include <asm/vendor_extensions.h>
>
>  #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
>
> @@ -100,24 +101,6 @@ static bool riscv_isa_extension_check(int id)
>         return true;
>  }
>
> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size)=
 {     \
> -       .name =3D #_name,                                                =
         \
> -       .property =3D #_name,                                            =
         \
> -       .id =3D _id,                                                     =
         \
> -       .subset_ext_ids =3D _subset_exts,                                =
         \
> -       .subset_ext_size =3D _subset_exts_size                           =
         \
> -}
> -
> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id,=
 NULL, 0)
> -
> -/* Used to declare pure "lasso" extension (Zk for instance) */
> -#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
> -       _RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, =
ARRAY_SIZE(_bundled_exts))
> -
> -/* Used to declare extensions that are a superset of other extensions (Z=
vbb for instance) */
> -#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
> -       _RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
> -
>  static const unsigned int riscv_zk_bundled_exts[] =3D {
>         RISCV_ISA_EXT_ZBKB,
>         RISCV_ISA_EXT_ZBKC,
> @@ -304,7 +287,6 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
>         __RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
>         __RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
> -       __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
>  };
>
>  const size_t riscv_isa_ext_count =3D ARRAY_SIZE(riscv_isa_ext);
> @@ -351,6 +333,21 @@ static void __init riscv_parse_isa_string(unsigned l=
ong *this_hwcap, struct risc
>                 bool ext_long =3D false, ext_err =3D false;
>
>                 switch (*ext) {
> +               case 'x':
> +               case 'X':
> +                       if (acpi_disabled)
> +                               pr_warn_once("Vendor extensions are ignor=
ed in riscv,isa. Use riscv,isa-extensions instead.");
> +                       /*
> +                        * To skip an extension, we find its end.
> +                        * As multi-letter extensions must be split from =
other multi-letter
> +                        * extensions with an "_", the end of a multi-let=
ter extension will
> +                        * either be the null character or the "_" at the=
 start of the next
> +                        * multi-letter extension.
> +                        */
> +                       for (; *isa && *isa !=3D '_'; ++isa)
> +                               ;
> +                       ext_err =3D true;
> +                       break;
>                 case 's':
>                         /*
>                          * Workaround for invalid single-letter 's' & 'u'=
 (QEMU).
> @@ -366,8 +363,6 @@ static void __init riscv_parse_isa_string(unsigned lo=
ng *this_hwcap, struct risc
>                         }
>                         fallthrough;
>                 case 'S':
> -               case 'x':
> -               case 'X':
>                 case 'z':
>                 case 'Z':
>                         /*
> @@ -574,6 +569,61 @@ static void __init riscv_fill_hwcap_from_isa_string(=
unsigned long *isa2hwcap)
>                 acpi_put_table((struct acpi_table_header *)rhct);
>  }
>
> +static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu_nod=
e, int cpu)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return;
> +
> +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +               struct riscv_isa_vendor_ext_data_list *ext_list =3D riscv=
_isa_vendor_ext_list[i];
> +
> +               for (int j =3D 0; j < ext_list->ext_data_count; j++) {
> +                       const struct riscv_isa_ext_data ext =3D ext_list-=
>ext_data[j];
> +                       struct riscv_isavendorinfo *isavendorinfo =3D &ex=
t_list->per_hart_isa_bitmap[cpu];
> +
> +                       if (of_property_match_string(cpu_node, "riscv,isa=
-extensions",
> +                                                    ext.property) < 0)
> +                               continue;
> +
> +                       /*
> +                        * Assume that subset extensions are all members =
of the
> +                        * same vendor.
> +                        */
> +                       if (ext.subset_ext_size)
> +                               for (int k =3D 0; k < ext.subset_ext_size=
; k++)
> +                                       set_bit(ext.subset_ext_ids[k], is=
avendorinfo->isa);
> +
> +                       set_bit(ext.id, isavendorinfo->isa);
> +               }
> +       }
> +}
> +
> +/*
> + * Populate all_harts_isa_bitmap for each vendor with all of the extensi=
ons that
> + * are shared across CPUs for that vendor.
> + */
> +static void __init riscv_fill_vendor_ext_list(int cpu)
> +{
> +       if (!IS_ENABLED(CONFIG_RISCV_ISA_VENDOR_EXT))
> +               return;
> +
> +       for (int i =3D 0; i < riscv_isa_vendor_ext_list_size; i++) {
> +               struct riscv_isa_vendor_ext_data_list *ext_list =3D riscv=
_isa_vendor_ext_list[i];
> +
> +               if (!ext_list->is_initialized) {
> +                       bitmap_copy(ext_list->all_harts_isa_bitmap.isa,
> +                                   ext_list->per_hart_isa_bitmap[cpu].is=
a,
> +                                   RISCV_ISA_VENDOR_EXT_MAX);
> +                       ext_list->is_initialized =3D true;
> +               } else {
> +                       bitmap_and(ext_list->all_harts_isa_bitmap.isa,
> +                                  ext_list->all_harts_isa_bitmap.isa,
> +                                  ext_list->per_hart_isa_bitmap[cpu].isa=
,
> +                                  RISCV_ISA_VENDOR_EXT_MAX);
> +               }
> +       }
> +}
> +
>  static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwca=
p)
>  {
>         unsigned int cpu;
> @@ -617,6 +667,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>                         }
>                 }
>
> +               riscv_fill_cpu_vendor_ext(cpu_node, cpu);
> +
>                 of_node_put(cpu_node);
>
>                 /*
> @@ -632,6 +684,8 @@ static int __init riscv_fill_hwcap_from_ext_list(unsi=
gned long *isa2hwcap)
>                         bitmap_copy(riscv_isa, isainfo->isa, RISCV_ISA_EX=
T_MAX);
>                 else
>                         bitmap_and(riscv_isa, riscv_isa, isainfo->isa, RI=
SCV_ISA_EXT_MAX);
> +
> +               riscv_fill_vendor_ext_list(cpu);
>         }
>
>         if (bitmap_empty(riscv_isa, RISCV_ISA_EXT_MAX))
> @@ -768,28 +822,45 @@ void __init_or_module riscv_cpufeature_patch_func(s=
truct alt_entry *begin,
>  {
>         struct alt_entry *alt;
>         void *oldptr, *altptr;
> -       u16 id, value;
> +       u16 id, value, vendor;
>
>         if (stage =3D=3D RISCV_ALTERNATIVES_EARLY_BOOT)
>                 return;
>
>         for (alt =3D begin; alt < end; alt++) {
> -               if (alt->vendor_id !=3D 0)
> -                       continue;
> -
>                 id =3D PATCH_ID_CPUFEATURE_ID(alt->patch_id);
> +               vendor =3D PATCH_ID_CPUFEATURE_ID(alt->vendor_id);
>
> -               if (id >=3D RISCV_ISA_EXT_MAX) {
> -                       WARN(1, "This extension id:%d is not in ISA exten=
sion list", id);
> -                       continue;
> -               }
> +               /*
> +                * Any alternative with a patch_id that is less than
> +                * RISCV_ISA_EXT_MAX is interpreted as a standard extensi=
on.
> +                *
> +                * Any alternative with patch_id that is greater than or =
equal
> +                * to RISCV_VENDOR_EXT_ALTERNATIVES_BASE is interpreted a=
s a
> +                * vendor extension.
> +                */
> +               if (id < RISCV_ISA_EXT_MAX) {
> +                       /*
> +                        * This patch should be treated as errata so skip
> +                        * processing here.
> +                        */
> +                       if (alt->vendor_id !=3D 0)
> +                               continue;
>
> -               if (!__riscv_isa_extension_available(NULL, id))
> -                       continue;
> +                       if (!__riscv_isa_extension_available(NULL, id))
> +                               continue;
>
> -               value =3D PATCH_ID_CPUFEATURE_VALUE(alt->patch_id);
> -               if (!riscv_cpufeature_patch_check(id, value))
> +                       value =3D PATCH_ID_CPUFEATURE_VALUE(alt->patch_id=
);
> +                       if (!riscv_cpufeature_patch_check(id, value))
> +                               continue;
> +               } else if (id >=3D RISCV_VENDOR_EXT_ALTERNATIVES_BASE) {
> +                       if (!__riscv_isa_vendor_extension_available(VENDO=
R_EXT_ALL_CPUS, vendor,
> +                                                                   id - =
RISCV_VENDOR_EXT_ALTERNATIVES_BASE))
> +                               continue;
> +               } else {
> +                       WARN(1, "This extension id:%d is not in ISA exten=
sion list", id);
>                         continue;
> +               }
>
>                 oldptr =3D ALT_OLD_PTR(alt);
>                 altptr =3D ALT_ALT_PTR(alt);
> diff --git a/arch/riscv/kernel/vendor_extensions.c b/arch/riscv/kernel/ve=
ndor_extensions.c
> new file mode 100644
> index 000000000000..b6c1e7b5d34b
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Rivos, Inc
> + */
> +
> +#include <asm/vendorid_list.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/andes.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/types.h>
> +
> +struct riscv_isa_vendor_ext_data_list *riscv_isa_vendor_ext_list[] =3D {
> +#ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
> +       &riscv_isa_vendor_ext_list_andes,
> +#endif
> +};
> +
> +const size_t riscv_isa_vendor_ext_list_size =3D ARRAY_SIZE(riscv_isa_ven=
dor_ext_list);
> +
> +/**
> + * __riscv_isa_vendor_extension_available() - Check whether given vendor
> + * extension is available or not.
> + *
> + * @cpu: check if extension is available on this cpu
> + * @vendor: vendor that the extension is a member of
> + * @bit: bit position of the desired extension
> + * Return: true or false
> + *
> + * NOTE: When cpu is -1, will check if extension is available on all cpu=
s
> + */
> +bool __riscv_isa_vendor_extension_available(int cpu, unsigned long vendo=
r, unsigned int bit)
> +{
> +       struct riscv_isavendorinfo *bmap;
> +       struct riscv_isavendorinfo *cpu_bmap;
> +
> +       switch (vendor) {
> +       #ifdef CONFIG_RISCV_ISA_VENDOR_EXT_ANDES
> +       case ANDES_VENDOR_ID:
> +               bmap =3D &riscv_isa_vendor_ext_list_andes.all_harts_isa_b=
itmap;
> +               cpu_bmap =3D &riscv_isa_vendor_ext_list_andes.per_hart_is=
a_bitmap[cpu];
> +               break;
> +       #endif
> +       default:
> +               return false;
> +       }
> +
> +       if (cpu !=3D -1)
> +               bmap =3D &cpu_bmap[cpu];
> +
> +       if (bit >=3D RISCV_ISA_VENDOR_EXT_MAX)
> +               return false;
> +
> +       return test_bit(bit, bmap->isa) ? true : false;
> +}
> +EXPORT_SYMBOL_GPL(__riscv_isa_vendor_extension_available);
> diff --git a/arch/riscv/kernel/vendor_extensions/Makefile b/arch/riscv/ke=
rnel/vendor_extensions/Makefile
> new file mode 100644
> index 000000000000..6a61aed944f1
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-$(CONFIG_RISCV_ISA_VENDOR_EXT_ANDES)       +=3D andes.o
> diff --git a/arch/riscv/kernel/vendor_extensions/andes.c b/arch/riscv/ker=
nel/vendor_extensions/andes.c
> new file mode 100644
> index 000000000000..ec688c88456a
> --- /dev/null
> +++ b/arch/riscv/kernel/vendor_extensions/andes.c
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <asm/cpufeature.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/andes.h>
> +
> +#include <linux/array_size.h>
> +#include <linux/types.h>
> +
> +/* All Andes vendor extensions supported in Linux */
> +const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] =3D {
> +       __RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
> +};
> +
> +struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_andes =
=3D {
> +       .ext_data_count =3D ARRAY_SIZE(riscv_isa_vendor_ext_andes),
> +       .ext_data =3D riscv_isa_vendor_ext_andes,
> +};
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a2e4005e1fd0..02719e0c6368 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -24,6 +24,8 @@
>  #include <asm/errata_list.h>
>  #include <asm/sbi.h>
>  #include <asm/cpufeature.h>
> +#include <asm/vendor_extensions.h>
> +#include <asm/vendor_extensions/andes.h>
>
>  #define ALT_SBI_PMU_OVERFLOW(__ovl)                                    \
>  asm volatile(ALTERNATIVE_2(                                            \
> @@ -32,7 +34,8 @@ asm volatile(ALTERNATIVE_2(                            =
               \
>                 THEAD_VENDOR_ID, ERRATA_THEAD_PMU,                      \
>                 CONFIG_ERRATA_THEAD_PMU,                                \
>         "csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),                  \
> -               0, RISCV_ISA_EXT_XANDESPMU,                             \
> +               ANDES_VENDOR_ID,                                        \
> +               RISCV_ISA_VENDOR_EXT_XANDESPMU + RISCV_VENDOR_EXT_ALTERNA=
TIVES_BASE, \
>                 CONFIG_ANDES_CUSTOM_PMU)                                \
>         : "=3Dr" (__ovl) :                                               =
 \
>         : "memory")
> @@ -41,7 +44,8 @@ asm volatile(ALTERNATIVE_2(                            =
               \
>  asm volatile(ALTERNATIVE(                                              \
>         "csrc " __stringify(CSR_IP) ", %0\n\t",                         \
>         "csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",                 \
> -               0, RISCV_ISA_EXT_XANDESPMU,                             \
> +               ANDES_VENDOR_ID,                                        \
> +               RISCV_ISA_VENDOR_EXT_XANDESPMU + RISCV_VENDOR_EXT_ALTERNA=
TIVES_BASE, \
>                 CONFIG_ANDES_CUSTOM_PMU)                                \
>         : : "r"(__irq_mask)                                             \
>         : "memory")
> @@ -1060,7 +1064,7 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu=
, struct platform_device *pde
>                    riscv_cached_mimpid(0) =3D=3D 0) {
>                 riscv_pmu_irq_num =3D THEAD_C9XX_RV_IRQ_PMU;
>                 riscv_pmu_use_irq =3D true;
> -       } else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
> +       } else if (riscv_isa_vendor_extension_available(ANDES_VENDOR_ID, =
XANDESPMU) &&
>                    IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
>                 riscv_pmu_irq_num =3D ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ=
_PMOVI;
>                 riscv_pmu_use_irq =3D true;
>
> --
> 2.44.0
>

