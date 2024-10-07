Return-Path: <linux-kernel+bounces-353636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE2993096
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668F51C2302B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490DD1D86C7;
	Mon,  7 Oct 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/Vlp4W1"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8179D1D86F4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313544; cv=none; b=gro1w0RdZcDg0Jgf1jbKuxEtrOpMPx0YhLSQi1wc0f3o/xeebu3sl2vZFA64wOjtCT0DGl3nwaJMuALSjpmzcfeg09jCGBtoyhHSnaM3qg4VSRINanMQXguKdc684uKNWuQFPTuYd6DTeSWNOX6xwEDj4vbBbbUfCIX60OdtabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313544; c=relaxed/simple;
	bh=YZA/FsPTJ/0SXCAHzVooq80Clnf9L8yh6nb1QxzQybw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw2IVk428APzOURJUrr2xfsDRgKg2/zLXX7p68ehyLDfUm4w+v9Ghalk4jBhhF+89tou+eHjni7Y6LOfLRjRVqeGwCDPTXNmeewRWVsgLOLYbg9HRfBrziFcV9w7P6b4rIjsBan0kRTPQHXYLcC02F8l2VNyktQnXQRi5LjauTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/Vlp4W1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a1a662a633so792235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728313540; x=1728918340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Ifz9XWfcAsuRFxDqc9o17TugXceR60fizX3mKXtiA=;
        b=r/Vlp4W1mhmkMjHOAnWXFDNCrvZpBJ3UenOh1PwQXMkX1LVE97iC1tIlISDusbmVuz
         kWd07H/7Snmhqltq+kgzggGHlDDNb7Y6RXZMlT9q1BECrddLujt7LFg38rt5R0HgCICZ
         mtv6N8Oo7f1FAbtIspc0rABoBZ9oqb3miKQ1YPOAOolRa5YjzcyCSwXxD/9/7BC6YjFb
         //+6z9jyAgrqIULhlGsqe9cffkD1Mo3w1bJwA4O7l7E9Vxacne+yuquVBEchGEBPC03l
         SMtqyj0n4WFHvWU9eFTOLk8I+ZDQg24sNW4hiQ0bGx6WXE7O1pmc44yuH6UKpy4ZF9NG
         8Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313540; x=1728918340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4Ifz9XWfcAsuRFxDqc9o17TugXceR60fizX3mKXtiA=;
        b=vBsas+ODYKFwyi8FvWg13ZwocC/hjlL+FUPLK6NWFqAMusq/fZqXTxhmw2eyGDHGGn
         B0U1KyXmhqf4uzczZmm5o1YX9OavP2RobYrDsjziyLQjoX8T1Gt/Jf33s4ICYpsuP0r8
         ncytnsbTSDOjW5FAccIw1M+DtO96+oCRIhEZa2hOLmqr4p5aKkhW7Mx9yGxZaJAXd++t
         p4nSkHr2rUcsj2+/BR+Xvk4WaMDJifiPV1z1FTVzsamza6lEDMHREc/JlSdEqRGCJCUF
         ft/zHCa4JWa1Q7wdrlfpN4t9syn/dSG5jB4UUj4DYHURG4QaLbft83uxXrxb1gbxnX/U
         C1/A==
X-Forwarded-Encrypted: i=1; AJvYcCUlBY+o3qkxiZ2IU2tRc0CDBgVtj8WpRpL7W7ZFFeUHPquuLDSsiFpBmHAHJT+KP0NZSkMF6u4rrTGBdHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24LDCjuTlOC+eCWJHaEN4vDTdJ+eptPedjtRd3rSa/yEAAL2A
	9QN6k2fWFjat/aVySBSqh3VadFDgPVs9TrC2l70GX98c9QcjYYtSq34cF7M0hGa6pIF7ZYiR6vc
	1SwqUj9SMMYM4PJhsq6isgAG1JLbpNFB147Q+
X-Google-Smtp-Source: AGHT+IGnVEtAO00vCITXCPwm0s3FUKY4msYOxpuQ04Ol0pYaHnJTKEoTr54hveiZ6TGX6FxH3wcrfJ/ceNrrrrwICog=
X-Received: by 2002:a05:6e02:b29:b0:3a0:a2c9:5c0b with SMTP id
 e9e14a558f8ab-3a37b879639mr7306245ab.18.1728313540246; Mon, 07 Oct 2024
 08:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com> <20241005195541.380070-18-irogers@google.com>
 <20241007170927.f30fced63c5e777628bea311@kernel.org>
In-Reply-To: <20241007170927.f30fced63c5e777628bea311@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Oct 2024 08:05:23 -0700
Message-ID: <CAP-5=fVmD-M-ZOinkWZ7AOtfRHqo89gFtDeeatwufq0TcBiZUA@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	Daniel Wagner <dwagner@suse.de>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Chen Pei <cp0613@linux.alibaba.com>, 
	Dima Kogan <dima@secretsauce.net>, Yury Norov <yury.norov@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 1:09=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat,  5 Oct 2024 12:55:27 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > Pass a flags value as architectures like csky need the flags to
> > determine the ABI variant.
> >
>
> Same here. I need some examples of this chaneg.

The code here was already using the ELF machine, so dwarf-regs.c
functions would already support cross building. There is the addition
of ELF flags as on csky the registers change depending on the ABI
version in the ELF flags.

Thanks,
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/dwarf-regs.c         |  3 ++-
> >  tools/perf/util/include/dwarf-regs.h | 11 ++++++-----
> >  tools/perf/util/probe-finder.c       | 13 +++++++------
> >  tools/perf/util/probe-finder.h       |  3 ++-
> >  4 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.=
c
> > index 1321387f6948..86b3ef638fbb 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -29,7 +29,8 @@
> >  #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n=
)] : NULL)
> >
> >  /* Return architecture dependent register string (for kprobe-tracer) *=
/
> > -const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
> > +const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
> > +                          unsigned int flags __maybe_unused)
> >  {
> >       switch (machine) {
> >       case EM_NONE:   /* Generic arch - use host arch */
> > diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inc=
lude/dwarf-regs.h
> > index ee0a734564c7..925525405e2d 100644
> > --- a/tools/perf/util/include/dwarf-regs.h
> > +++ b/tools/perf/util/include/dwarf-regs.h
> > @@ -80,12 +80,13 @@
> >
> >  #ifdef HAVE_LIBDW_SUPPORT
> >  const char *get_arch_regstr(unsigned int n);
> > -/*
> > - * get_dwarf_regstr - Returns ftrace register string from DWARF regnum
> > - * n: DWARF register number
> > - * machine: ELF machine signature (EM_*)
> > +/**
> > + * get_dwarf_regstr() - Returns ftrace register string from DWARF regn=
um.
> > + * @n: DWARF register number.
> > + * @machine: ELF machine signature (EM_*).
> > + * @flags: ELF flags for things like ABI differences.
> >   */
> > -const char *get_dwarf_regstr(unsigned int n, unsigned int machine);
> > +const char *get_dwarf_regstr(unsigned int n, unsigned int machine, uns=
igned int flags);
> >
> >  int get_arch_regnum(const char *name);
> >  /*
> > diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-fin=
der.c
> > index 8019d232f515..29eaa9beca86 100644
> > --- a/tools/perf/util/probe-finder.c
> > +++ b/tools/perf/util/probe-finder.c
> > @@ -56,7 +56,7 @@ static struct probe_trace_arg_ref *alloc_trace_arg_re=
f(long offs)
> >   */
> >  static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr add=
r,
> >                                    Dwarf_Op *fb_ops, Dwarf_Die *sp_die,
> > -                                  unsigned int machine,
> > +                                  const struct probe_finder *pf,
> >                                    struct probe_trace_arg *tvar)
> >  {
> >       Dwarf_Attribute attr;
> > @@ -166,7 +166,7 @@ static int convert_variable_location(Dwarf_Die *vr_=
die, Dwarf_Addr addr,
> >       if (!tvar)
> >               return ret2;
> >
> > -     regs =3D get_dwarf_regstr(regn, machine);
> > +     regs =3D get_dwarf_regstr(regn, pf->e_machine, pf->e_flags);
> >       if (!regs) {
> >               /* This should be a bug in DWARF or this tool */
> >               pr_warning("Mapping for the register number %u "
> > @@ -451,7 +451,7 @@ static int convert_variable(Dwarf_Die *vr_die, stru=
ct probe_finder *pf)
> >                dwarf_diename(vr_die));
> >
> >       ret =3D convert_variable_location(vr_die, pf->addr, pf->fb_ops,
> > -                                     &pf->sp_die, pf->machine, pf->tva=
r);
> > +                                     &pf->sp_die, pf, pf->tvar);
> >       if (ret =3D=3D -ENOENT && pf->skip_empty_arg)
> >               /* This can be found in other place. skip it */
> >               return 0;
> > @@ -1134,7 +1134,8 @@ static int debuginfo__find_probes(struct debuginf=
o *dbg,
> >       if (gelf_getehdr(elf, &ehdr) =3D=3D NULL)
> >               return -EINVAL;
> >
> > -     pf->machine =3D ehdr.e_machine;
> > +     pf->e_machine =3D ehdr.e_machine;
> > +     pf->e_flags =3D ehdr.e_flags;
> >
> >       do {
> >               GElf_Shdr shdr;
> > @@ -1171,7 +1172,7 @@ static int copy_variables_cb(Dwarf_Die *die_mem, =
void *data)
> >           (tag =3D=3D DW_TAG_variable && vf->vars)) {
> >               if (convert_variable_location(die_mem, vf->pf->addr,
> >                                             vf->pf->fb_ops, &pf->sp_die=
,
> > -                                           pf->machine, NULL) =3D=3D 0=
) {
> > +                                           pf, /*tvar=3D*/NULL) =3D=3D=
 0) {
> >                       vf->args[vf->nargs].var =3D (char *)dwarf_diename=
(die_mem);
> >                       if (vf->args[vf->nargs].var =3D=3D NULL) {
> >                               vf->ret =3D -ENOMEM;
> > @@ -1403,7 +1404,7 @@ static int collect_variables_cb(Dwarf_Die *die_me=
m, void *data)
> >           tag =3D=3D DW_TAG_variable) {
> >               ret =3D convert_variable_location(die_mem, af->pf.addr,
> >                                               af->pf.fb_ops, &af->pf.sp=
_die,
> > -                                             af->pf.machine, NULL);
> > +                                             &af->pf, /*tvar=3D*/NULL)=
;
> >               if (ret =3D=3D 0 || ret =3D=3D -ERANGE) {
> >                       int ret2;
> >                       bool externs =3D !af->child;
> > diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-fin=
der.h
> > index b9a5afca4cc1..71e21cb4492a 100644
> > --- a/tools/perf/util/probe-finder.h
> > +++ b/tools/perf/util/probe-finder.h
> > @@ -68,7 +68,8 @@ struct probe_finder {
> >       /* Call Frame Information from .debug_frame */
> >       Dwarf_CFI               *cfi_dbg;
> >       Dwarf_Op                *fb_ops;        /* Frame base attribute *=
/
> > -     unsigned int            machine;        /* Target machine arch */
> > +     unsigned int            e_machine;      /* ELF target machine arc=
h */
> > +     unsigned int            e_flags;        /* ELF target machine fla=
gs */
> >       struct perf_probe_arg   *pvar;          /* Current target variabl=
e */
> >       struct probe_trace_arg  *tvar;          /* Current result variabl=
e */
> >       bool                    skip_empty_arg; /* Skip non-exist args */
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

