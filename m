Return-Path: <linux-kernel+bounces-285310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3F950BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D5EB2645C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF019DF82;
	Tue, 13 Aug 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULQH0JVO"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142737E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572243; cv=none; b=hxLpAfDuGcLnqFofqd27rEjsIGnoHtyrxgMTblNYhXBM9W97E7VRco7b3rEQqR1kD2pXhkGPzEBK7AzBMLEK6Br6aXjwNEjCtt3fiupbJk2YpywM6d7jooc7qCChb2MRDL8riKLqaGYft0RViT4pozReqipxRPtI+9TFUQBrJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572243; c=relaxed/simple;
	bh=SpbhB0trvBFFFt1fBeXN/iMY0NereoPjfDzycj7ycCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCM60PqIkk1O0UF617eSJergpzYyxMBPUvEZRK6DrkqAwXU9jhcnonUXS7VtLPluV759Y4TtiMT7ViC2G7yINeEIL5upbGx7nXftNWfRv1EOzbWm87EyWxh/53+pW10BNpo5NHr6Ae+wimHKQlcW+JZs4SfGBWZ6tWSu1q487l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULQH0JVO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc587361b6so47787575ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723572241; x=1724177041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLjtE3l7AgLQThiCG63S0Jrlx/yQVAU6YNwQV5AOsWk=;
        b=ULQH0JVOx+deuMMQBSH/RR+o8pVgb8NV+yrmOH4vLOoDVAyyRgIuwxdCv0x67cfVl0
         wfxTyIpSLlejSIydm4d9EVJD1IO+GPsplRF8GA2TKcegw4vc13WHEhr+CRBDzKJ7fS54
         WyQkZTWocwKXdITmE0eYHM9oo0BY2XLCynpSudlaJyRVeY8JhvJQK/bfU+YfdRUZt0io
         NF0HuZ4Uu95Kr5hSrpjkg3bwivRpvmkZHvYNTcyULVj+eGmug/qksbN+xaUwN9I71Jos
         NRAXxUaRebf4T1cgvZtFoXspeivD15axNRlpVqnqM2SDlUFkiM0vgHP59lHVJABB2LKp
         BapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723572241; x=1724177041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLjtE3l7AgLQThiCG63S0Jrlx/yQVAU6YNwQV5AOsWk=;
        b=IDgl4zCj/KC6srTF4VrfoJZmBHaO125NJs/9QeyJLOk5f4eepkxP8Z5YhVmw4EHUOX
         gQb0U5qIt9X9cVeCGltCyTilaU64qauuhjyvlryKahqWXqz24mr866t14x2SKl3LhGbM
         Z5EkY0DUn6/XLYxn39T264P5AIgO6B2GLxbp8+goPbFXcMRrgRidXXfqaSStspgB6Bw3
         RkpMR/IXPshpodnUVqK0sYvmT575FaEmKD4uC1DvY1A8dVQ+ioj4O4w35/oMqaGeOd93
         C7cNMhPzdTlHYwecXUgg0sl51pHk1cHcBJgGi0f8aDdY0+opmxqZvevy1TTMiMrliGFb
         9xGg==
X-Forwarded-Encrypted: i=1; AJvYcCUOiQw8LSyQ1CSLmt4RHrBN2ba2KSr3jGN73DfPcdMU0NVOCY1wQix0xGnhtyphiy/OzG/LvbZqn12Kyd1ywaEGGV+nGRPspL/gshW5
X-Gm-Message-State: AOJu0YzI3nONc40u0m+6hNg/OOLMzXpNkGOavmPEssBQJn9HOXDOindI
	GSIxCD2BoGmMEcE9EYq544q336qa0JHOR5FTWjPBJ66yA4azrX84Sap5iGNsASfYiccF1eSJN4S
	k7Sh8zhIiCGTdme6LKbXr8ga3dmsE0bORLQIO
X-Google-Smtp-Source: AGHT+IH24e480wGtYW6ur8whmKXZ7jgeEsuASXfyI21xzQfEEznIpFTpc990kUqG1+LrVeYqGg3h2TgZDoh3slnaR0I=
X-Received: by 2002:a17:902:ec90:b0:1fd:93d2:fba4 with SMTP id
 d9443c01a7336-201d64a5bd9mr3956585ad.48.1723572240687; Tue, 13 Aug 2024
 11:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809214444.3257596-1-evan@rivosinc.com> <20240809214444.3257596-3-evan@rivosinc.com>
 <ZraQ3PWOY23G2zZH@ghost>
In-Reply-To: <ZraQ3PWOY23G2zZH@ghost>
From: enh <enh@google.com>
Date: Tue, 13 Aug 2024 14:03:44 -0400
Message-ID: <CAJgzZopz0SpWn7tEBctG+qEcgF829Zes8-6U=ZEAriZagaB80w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: hwprobe: Add SCALAR to misaligned perf defines
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Evan Green <evan@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Yangyu Chen <cyy@cyyself.name>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Andy Chiu <andy.chiu@sifive.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Erick Archer <erick.archer@gmx.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:57=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Fri, Aug 09, 2024 at 02:44:44PM -0700, Evan Green wrote:
> > In preparation for misaligned vector performance hwprobe keys, rename
> > the hwprobe key values associated with misaligned scalar accesses to
> > include the term SCALAR. Leave the old defines in place to maintain
> > source compatibility.
> >
> > This change is intended to be a functional no-op.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > ---
> >
> > Changes in v4:
> >  - Add the word scalar (Charlie)
> >
> > Changes in v3:
> >  - Leave the old defines in place (Conor, Palmer)
> >
> > Changes in v2:
> >  - Added patch to rename misaligned perf key values (Palmer)
> >
> >  Documentation/arch/riscv/hwprobe.rst       | 28 ++++++++++++----------
> >  arch/riscv/include/uapi/asm/hwprobe.h      |  5 ++++
> >  arch/riscv/kernel/sys_hwprobe.c            | 10 ++++----
> >  arch/riscv/kernel/traps_misaligned.c       |  6 ++---
> >  arch/riscv/kernel/unaligned_access_speed.c | 12 +++++-----
> >  5 files changed, 34 insertions(+), 27 deletions(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/=
riscv/hwprobe.rst
> > index a994eed75bde..85b709257918 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -247,23 +247,25 @@ The following keys are defined:
> >    the performance of misaligned scalar native word accesses on the sel=
ected set
> >    of processors.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of mi=
saligned
> > -    accesses is unknown.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN`: The performanc=
e of
> > +    misaligned scalar accesses is unknown.
>
> + enh <enh@google.com>
>
> Thanks for respinning this Evan! With this wording change the patch that
> changes the wording but not the macro [1] is no longer needed.

yeah, this is much better. thanks!

> - Charlie
>
> Link:
> https://lore.kernel.org/linux-riscv/CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=
=3DFH-ZAcdXFnNe8Eg@mail.gmail.com/
> [1]
>
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses =
are
> > -    emulated via software, either in or below the kernel.  These acces=
ses are
> > -    always extremely slow.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED`: Misaligned sc=
alar
> > +    accesses are emulated via software, either in or below the kernel.=
  These
> > +    accesses are always extremely slow.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned native word
> > -    sized accesses are slower than the equivalent quantity of byte acc=
esses.
> > -    Misaligned accesses may be supported directly in hardware, or trap=
ped and
> > -    emulated by software.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW`: Misaligned scalar=
 native
> > +    word sized accesses are slower than the equivalent quantity of byt=
e
> > +    accesses. Misaligned accesses may be supported directly in hardwar=
e, or
> > +    trapped and emulated by software.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned native word
> > -    sized accesses are faster than the equivalent quantity of byte acc=
esses.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_FAST`: Misaligned scalar=
 native
> > +    word sized accesses are faster than the equivalent quantity of byt=
e
> > +    accesses.
> >
> > -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned access=
es are
> > -    not supported at all and will generate a misaligned address fault.
> > +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED`: Misaligned=
 scalar
> > +    accesses are not supported at all and will generate a misaligned a=
ddress
> > +    fault.
> >
> >  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int whic=
h
> >    represents the size of the Zicboz block in bytes.
> > diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include=
/uapi/asm/hwprobe.h
> > index 635753084275..1e153cda57db 100644
> > --- a/arch/riscv/include/uapi/asm/hwprobe.h
> > +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> > @@ -83,6 +83,11 @@ struct riscv_hwprobe {
> >  #define RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS       7
> >  #define RISCV_HWPROBE_KEY_TIME_CSR_FREQ      8
> >  #define RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF     9
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN         0
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED        1
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW            2
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_FAST            3
> > +#define              RISCV_HWPROBE_MISALIGNED_SCALAR_UNSUPPORTED     4
> >  /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> >  /* Flags */
> > diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hw=
probe.c
> > index 2d0f4f6a32c3..cea0ca2bf2a2 100644
> > --- a/arch/riscv/kernel/sys_hwprobe.c
> > +++ b/arch/riscv/kernel/sys_hwprobe.c
> > @@ -178,13 +178,13 @@ static u64 hwprobe_misaligned(const struct cpumas=
k *cpus)
> >                       perf =3D this_perf;
> >
> >               if (perf !=3D this_perf) {
> > -                     perf =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > +                     perf =3D RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
> >                       break;
> >               }
> >       }
> >
> >       if (perf =3D=3D -1ULL)
> > -             return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > +             return RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
> >
> >       return perf;
> >  }
> > @@ -192,12 +192,12 @@ static u64 hwprobe_misaligned(const struct cpumas=
k *cpus)
> >  static u64 hwprobe_misaligned(const struct cpumask *cpus)
> >  {
> >       if (IS_ENABLED(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS))
> > -             return RISCV_HWPROBE_MISALIGNED_FAST;
> > +             return RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
> >
> >       if (IS_ENABLED(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS) && unalign=
ed_ctl_available())
> > -             return RISCV_HWPROBE_MISALIGNED_EMULATED;
> > +             return RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
> >
> > -     return RISCV_HWPROBE_MISALIGNED_SLOW;
> > +     return RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
> >  }
> >  #endif
> >
> > diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/t=
raps_misaligned.c
> > index b62d5a2f4541..192cd5603e95 100644
> > --- a/arch/riscv/kernel/traps_misaligned.c
> > +++ b/arch/riscv/kernel/traps_misaligned.c
> > @@ -338,7 +338,7 @@ int handle_misaligned_load(struct pt_regs *regs)
> >       perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
> >
> >  #ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
> > -     *this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MISALIG=
NED_EMULATED;
> > +     *this_cpu_ptr(&misaligned_access_speed) =3D RISCV_HWPROBE_MISALIG=
NED_SCALAR_EMULATED;
> >  #endif
> >
> >       if (!unaligned_enabled)
> > @@ -532,13 +532,13 @@ static bool check_unaligned_access_emulated(int c=
pu)
> >       unsigned long tmp_var, tmp_val;
> >       bool misaligned_emu_detected;
> >
> > -     *mas_ptr =3D RISCV_HWPROBE_MISALIGNED_UNKNOWN;
> > +     *mas_ptr =3D RISCV_HWPROBE_MISALIGNED_SCALAR_UNKNOWN;
> >
> >       __asm__ __volatile__ (
> >               "       "REG_L" %[tmp], 1(%[ptr])\n"
> >               : [tmp] "=3Dr" (tmp_val) : [ptr] "r" (&tmp_var) : "memory=
");
> >
> > -     misaligned_emu_detected =3D (*mas_ptr =3D=3D RISCV_HWPROBE_MISALI=
GNED_EMULATED);
> > +     misaligned_emu_detected =3D (*mas_ptr =3D=3D RISCV_HWPROBE_MISALI=
GNED_SCALAR_EMULATED);
> >       /*
> >        * If unaligned_ctl is already set, this means that we detected t=
hat all
> >        * CPUS uses emulated misaligned access at boot time. If that cha=
nged
> > diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/ke=
rnel/unaligned_access_speed.c
> > index a9a6bcb02acf..160628a2116d 100644
> > --- a/arch/riscv/kernel/unaligned_access_speed.c
> > +++ b/arch/riscv/kernel/unaligned_access_speed.c
> > @@ -34,9 +34,9 @@ static int check_unaligned_access(void *param)
> >       struct page *page =3D param;
> >       void *dst;
> >       void *src;
> > -     long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> > +     long speed =3D RISCV_HWPROBE_MISALIGNED_SCALAR_SLOW;
> >
> > -     if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
> > +     if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_SCALAR_UNKNOWN)
> >               return 0;
> >
> >       /* Make an unaligned destination buffer. */
> > @@ -95,14 +95,14 @@ static int check_unaligned_access(void *param)
> >       }
> >
> >       if (word_cycles < byte_cycles)
> > -             speed =3D RISCV_HWPROBE_MISALIGNED_FAST;
> > +             speed =3D RISCV_HWPROBE_MISALIGNED_SCALAR_FAST;
> >
> >       ratio =3D div_u64((byte_cycles * 100), word_cycles);
> >       pr_info("cpu%d: Ratio of byte access time to unaligned word acces=
s is %d.%02d, unaligned accesses are %s\n",
> >               cpu,
> >               ratio / 100,
> >               ratio % 100,
> > -             (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "=
slow");
> > +             (speed =3D=3D RISCV_HWPROBE_MISALIGNED_SCALAR_FAST) ? "fa=
st" : "slow");
> >
> >       per_cpu(misaligned_access_speed, cpu) =3D speed;
> >
> > @@ -110,7 +110,7 @@ static int check_unaligned_access(void *param)
> >        * Set the value of fast_misaligned_access of a CPU. These operat=
ions
> >        * are atomic to avoid race conditions.
> >        */
> > -     if (speed =3D=3D RISCV_HWPROBE_MISALIGNED_FAST)
> > +     if (speed =3D=3D RISCV_HWPROBE_MISALIGNED_SCALAR_FAST)
> >               cpumask_set_cpu(cpu, &fast_misaligned_access);
> >       else
> >               cpumask_clear_cpu(cpu, &fast_misaligned_access);
> > @@ -188,7 +188,7 @@ static int riscv_online_cpu(unsigned int cpu)
> >       static struct page *buf;
> >
> >       /* We are already set since the last check */
> > -     if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_UNKNOWN)
> > +     if (per_cpu(misaligned_access_speed, cpu) !=3D RISCV_HWPROBE_MISA=
LIGNED_SCALAR_UNKNOWN)
> >               goto exit;
> >
> >       buf =3D alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
> > --
> > 2.34.1
> >

