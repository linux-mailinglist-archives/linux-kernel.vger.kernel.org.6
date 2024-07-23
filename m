Return-Path: <linux-kernel+bounces-260113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDDC93A334
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89531C222E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA6156C69;
	Tue, 23 Jul 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dn43e1zj"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E3156C49
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746217; cv=none; b=jRXYUBvn1kEVCRZ4cFrV3hjzHmNL6vwMED6SgJmcaXvT9AlQxlIrlqSFCDlIGRZ97CAnLHc1WP+Ap8oFaTAgMvztdFvYV82h1zCkdWYJZTsChqM8lDpErPDjUkl7tL+jHOJszZvODpi9rJ9yw+Yl2XGH3speLt8WW97TQQDt1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746217; c=relaxed/simple;
	bh=nb1ri7KrPqfR8xnOxzjbD27CR+ug1BhbJmpObD7CyKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVc+WEiPuVYcugP2/Avo06TBTr8EXF7JjsJu71K1oVgxyVqf4BSl6ZteBSSfZ8da61UPl7h1ajrCnMm8riDk3PwmzkNEswx2Z/yXTlOKthf2SjVK2lpGd6zPWRt73AfIErIhr6ofu+hN1UMuoyqZ9SIVe7ucqvEu115zGILVAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dn43e1zj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f01e9f53ebso12106741fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721746213; x=1722351013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAQKVtTByoBRS6j1licywyxM1Ykos6KOI6h9i1fVoF0=;
        b=dn43e1zj+/fKZFoxh4BgQcabHI965SmOssbmZMw1GE7YTEz2GGs7Y7zJ7+wRkNIH3o
         4Kt1qFnUpycQw51RrX23LGGOnFtQdOvXC61qwheJELtI6bokdwUFMQMcrp2K8whAO3ap
         RfGBkN2uCuFXwYPXKcvATi/iKE3mlRpv8xGHRSY8eazfFsDFIvxT69s2lafLPnrQC5vc
         sA7ubaep9k8eDjuRkNrIJk/PoqAcNCWx4wQDsq7dB2fsa2XTS9e5CW1MwCG6B2viAVZw
         b5blvdi34YIrzcPBIus/kgHJovD4lQFI9K9Jlpw7UtwYIt8h6yK+y/s2blAe4vdSaBGa
         Ss/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746213; x=1722351013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAQKVtTByoBRS6j1licywyxM1Ykos6KOI6h9i1fVoF0=;
        b=vswG6lriw6ODo0jwc+vaaijb407r4HjCyX2wWf0M5hXE1JNQtIiSJICQl9NSGabe4E
         8NBzk1BEjxFl9iGKQxX9NT8ZaqqL+dpz/CbzFKpanIeTbVV2+E4R0Z14TGrcdMfZAlKg
         MrE4GIErkJUmZHlTLEeXxF/5/FAxf8Nu8mEAXT2J90JQKbb5vJklpPwz5b8m80ugkahQ
         Pcvr28ezx1nD47dHs4HymJCwtvRs94ncFmifq6aS4pRBtiGTP89SLonlnzVDURXsE6eV
         Oxigpq3e+WokBwniGRR0VlLldV5dCgC3hWntkCL7uNz83z5fqWF/VO/bB8xYLKjyud7j
         8BfA==
X-Forwarded-Encrypted: i=1; AJvYcCXqpbttRHQUGptgb3jDNSnRXplMlUQ7pmo9hKFTI1n2dN0roP3WOCW/g5o/lH4dFmHNNY9ge88xUeT3EVxdBqfU5QNcJJ6qFQJfzue3
X-Gm-Message-State: AOJu0Yzvl53lWqBMwl+6bkWyY66tcGgWObaPDIK3SvFkNzv6S1HmsAHF
	1y/NMyFAJG82Ynr7eMTxNqh1hi8q8DIJ+z5l1UUnEUiaBaw+uw5F5qkNLGtYZ6zoxHcyVDu0jpC
	cDmBKWMXHLwW4MyGCWK/1kM2DmbYo9CZCX2aT7A==
X-Google-Smtp-Source: AGHT+IHwxfnXNf2MLZFxPOzbNUSu5l5yaSYC7+etjPBXXrmtOcuEMbNGrhBWBQKQBDYxi4BsfO4P1BJ6YXZ/YQSLVIk=
X-Received: by 2002:a2e:97c4:0:b0:2ef:2c27:6680 with SMTP id
 38308e7fff4ca-2ef2c27675bmr52001191fa.12.1721746212143; Tue, 23 Jul 2024
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <65dbad1fda08a32922c44886e4581e49b4a2fecc.1718268003.git.haibo1.xu@intel.com>
 <20240723-23811cc47f7863d12b6a78e8@orel> <CAJve8omO0DwQEO+KEjhJFn=uYNAyZNYsnQieETocRzwb0RTGiA@mail.gmail.com>
In-Reply-To: <CAJve8omO0DwQEO+KEjhJFn=uYNAyZNYsnQieETocRzwb0RTGiA@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 23 Jul 2024 20:20:00 +0530
Message-ID: <CAK9=C2Xt2JPaUOTfN9CyyeVQiS9KKYWaH4RUTwYQ6UGjq3VnHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, 
	sunilvl@ventanamicro.com, arnd@arndb.de, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anup Patel <anup@brainfault.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Baoquan He <bhe@redhat.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Zong Li <zong.li@sifive.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Chen Jiahao <chenjiahao16@huawei.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, James Morse <james.morse@arm.com>, 
	Evan Green <evan@rivosinc.com>, Zhao Ke <ke.zhao@shingroup.cn>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Robert Richter <rrichter@amd.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:51=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> wrot=
e:
>
> On Tue, Jul 23, 2024 at 9:30=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
> >
> > On Thu, Jun 13, 2024 at 04:54:33PM GMT, Haibo Xu wrote:
> > > Add acpi_numa.c file to enable parse NUMA information from
> > > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > > memory nodes to proximity domain mapping, while SLIT table
> > > provide the distance metrics between proximity domains.
> > >
> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  15 +++-
> > >  arch/riscv/kernel/Makefile    |   1 +
> > >  arch/riscv/kernel/acpi.c      |   5 --
> > >  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++=
++
> > >  arch/riscv/kernel/setup.c     |   4 +-
> > >  arch/riscv/kernel/smpboot.c   |   2 -
> > >  include/linux/acpi.h          |   6 ++
> > >  7 files changed, 154 insertions(+), 10 deletions(-)
> > >  create mode 100644 arch/riscv/kernel/acpi_numa.c
> > >
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/a=
cpi.h
> > > index 7dad0cf9d701..e0a1f84404f3 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int n=
um, u32 slot) { }
> > >
> > >  void acpi_init_rintc_map(void);
> > >  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > -u32 get_acpi_id_for_cpu(int cpu);
> > > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > > +{
> > > +     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > > +}
> > > +
> > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >                      unsigned int cpu, const char **isa);
> > >
> > > -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_=
NO_NODE; }
> > >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *c=
bom_size,
> > >                            u32 *cboz_size, u32 *cbop_size);
> > >  #else
> > > @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct =
acpi_table_header *table,
> > >
> > >  #endif /* CONFIG_ACPI */
> > >
> > > +#ifdef CONFIG_ACPI_NUMA
> > > +int acpi_numa_get_nid(unsigned int cpu);
> > > +void acpi_map_cpus_to_nodes(void);
> > > +#else
> > > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_=
NO_NODE; }
> > > +static inline void acpi_map_cpus_to_nodes(void) { }
> > > +#endif /* CONFIG_ACPI_NUMA */
> > > +
> > >  #endif /*_ASM_ACPI_H*/
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index 5b243d46f4b1..1e2afec141b5 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -110,3 +110,4 @@ obj-$(CONFIG_COMPAT)              +=3D compat_vds=
o/
> > >
> > >  obj-$(CONFIG_64BIT)          +=3D pi/
> > >  obj-$(CONFIG_ACPI)           +=3D acpi.o
> > > +obj-$(CONFIG_ACPI_NUMA)      +=3D acpi_numa.o
> > > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > index e619edc8b0cc..040bdbfea2b4 100644
> > > --- a/arch/riscv/kernel/acpi.c
> > > +++ b/arch/riscv/kernel/acpi.c
> > > @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(=
int cpu)
> > >       return &cpu_madt_rintc[cpu];
> > >  }
> > >
> > > -u32 get_acpi_id_for_cpu(int cpu)
> > > -{
> > > -     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > > -}
> > > -
> > >  /*
> > >   * __acpi_map_table() will be called before paging_init(), so early_=
ioremap()
> > >   * or early_memremap() should be called here to for ACPI table mappi=
ng.
> > > diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_n=
uma.c
> > > new file mode 100644
> > > index 000000000000..0231482d6946
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/acpi_numa.c
> > > @@ -0,0 +1,131 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ACPI 6.6 based NUMA setup for RISCV
> > > + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> > > + *
> > > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > > + * Copyright (C) 2013-2016, Linaro Ltd.
> > > + *           Author: Hanjun Guo <hanjun.guo@linaro.org>
> > > + * Copyright (C) 2024 Intel Corporation.
> > > + *
> > > + * Reads the ACPI SRAT table to figure out what memory belongs to wh=
ich CPUs.
> > > + *
> > > + * Called from acpi_numa_init while reading the SRAT and SLIT tables=
.
> > > + * Assumes all memory regions belonging to a single proximity domain
> > > + * are in one chunk. Holes between them will be included in the node=
.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> > > +
> > > +#include <linux/acpi.h>
> > > +#include <linux/bitmap.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/memblock.h>
> > > +#include <linux/mmzone.h>
> > > +#include <linux/module.h>
> > > +#include <linux/topology.h>
> > > +
> > > +#include <asm/numa.h>
> > > +
> > > +static int acpi_early_node_map[NR_CPUS] __initdata =3D { NUMA_NO_NOD=
E };
> >
> > This only sets acpi_early_node_map[0] to NUMA_NO_NODE. Assuming we want
> > to ensure all of them are initialized to NUMA_NO_NODE, then we need
> >
> > static int acpi_early_node_map[NR_CPUS] __initdata =3D { [0 ... NR_CPUS=
 - 1] =3D NUMA_NO_NODE };
> >
>
> Good catch! Thanks!
>
> @Palmer Dabbelt
> I noticed this series had been merged to riscv/linux.git (for-next),
> could you help include the above change from Drew?
> Or shall I send out a new series?

Since it's already in for-next, I suggest having a Fixes
patch and add that to for-next because for-next is supposed
to have a stable commit history.

Regards,
Anup

