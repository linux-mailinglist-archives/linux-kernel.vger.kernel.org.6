Return-Path: <linux-kernel+bounces-402462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04C9C27F6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606FC1F231E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D791F7549;
	Fri,  8 Nov 2024 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rkpve48N"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF41C1F2B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731107301; cv=none; b=NfC4YDaPGht/C60P/vDk9ohEn8OMmd6L0PVE4LJ/OY99WJ7KmdTAxxOkNHWaoIk8RKT3lyeP2VSq5+NASOGYGFhRwPHV64p4fbUCmhxIypxESe4txSzydUK4ca5hh4O7f2WeAaR7XyI7h1X25QS9/09hhjnfZ4SYOEebGjKDfag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731107301; c=relaxed/simple;
	bh=irsXnTZZxmygNupu1NXScKGAnNXMWo9lfsCc5kdbx9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm8Mpj47xmwv+JZrgCVxjCKGkzI+vQCHi6ZvUxzSnSonxXFyhm7moV2+a+9TZm6AUREdB4CIuVW12FnctGiPUdJPtAXqthSxdgWC9DBwuQzomfk5qnQL1V/a+JnYNYUmM02dPMnbKHVjIofSN4ncUR1dj5Cd6oFmlMuCwdegbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rkpve48N; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso35745ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731107299; x=1731712099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IiCqEW55XHvVf8qTba07pGSpYKmfdNiKgbJzhLD73iM=;
        b=Rkpve48NY0Rgd+nl2vXkSk9J3Te9p2r5JEaZRBEsr9/L1b35TTazoEKv6olDDk4/QM
         W4BKfqa4TqqyTSNM+qz5zA8aUJXrzIXGyYut1vtMK/vWICR8XHun4ao8cnxxn4EZgc5i
         4dzF0WFMjQEyryh20/87zIP7cDDR+sk8HFpBqWH1elOFnERynnM62SxHZ/NFYO7ga7vy
         3tRbop0awyKCx875UGYdf4UhgfV2xt2rAYTEbGyqAj3116G9vNUYXExQMJivhIdHFRXm
         KCw0aX77mjhJKdSxqJbGJw+dZhSrSeTINGml1Jj8A2pmrKHwejpFNY0Fk8nv7o5UQ9jx
         3t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731107299; x=1731712099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiCqEW55XHvVf8qTba07pGSpYKmfdNiKgbJzhLD73iM=;
        b=wjgKi4WTIzv2N7Ko+82Mgl6mb2/1HVIudF1uPLmnxQBYwc3/fgJsoAIK4FtdjtgYxn
         0MRNkbStd7pkSRCkPMOeJlmCBy7jHjRd7QyK7+pvJGuGM/+d9YDeuove9clAUF7gKk5X
         rnpFUZUZSZUMy43SDG2CtSDxD5XtgNT6zC1N2YemEaotWIRfzRmEk0z+Cos5WFWTqodi
         XpLXlCMl/j/obMKQp+LHgd+NPdaw8HrWLkkRGdlMJ0QH8V+y11YVHmiqVVi1rUgbAhXk
         aG5kAfb/FXOx8y46i+6qhNzgobdkfVGz+OjX2Yi46cGPwsBtYA3Bx+iSN2pXP7tjQMJo
         gL4g==
X-Forwarded-Encrypted: i=1; AJvYcCWJfXKdSUYIlHivMug2RiOMuM/D+z5lmd4zJJ7zZzChL+zNTcl3m+9HqgZW0eWmEZONu9BVWnf9ve5st2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgbbU9d8eMoNV+E8zzXWYa1P2Nst1g3sXhJeho5Oa8ePg21lf
	sVljXKJI9O49HD6c26bsJ23pv3J3nSCZJ29dCs3GT5ZIf8/hjRhxOpJaqsdNZ7KGDeyJfvaWLtS
	O92tyRD9nXeUfsUptn1U2jn8DjcXgplglM5T5
X-Gm-Gg: ASbGncvFR0DPWzmvhpEKKchPA7BEDJ8PIWAWIP+Bv4S3Yx1IUtMALuovf2npNx3YDx8
	R7m9wmhGsmGZCOF3op1NFcIwZBL5i2EIr
X-Google-Smtp-Source: AGHT+IEukeGFoyo6dh0VbQTAZvTWfrcspZTzt0yr9OYJp6P2e9ETJS0TnoGpuVFVzJTNq6FY+rr4thPlSIkzzSRgbw0=
X-Received: by 2002:a05:6e02:1946:b0:3a0:a224:eb2c with SMTP id
 e9e14a558f8ab-3a6f9564132mr264765ab.25.1731107299142; Fri, 08 Nov 2024
 15:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com> <20241017002520.59124-11-irogers@google.com>
 <Zy5udmX6gZAg0wkS@google.com>
In-Reply-To: <Zy5udmX6gZAg0wkS@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 15:08:07 -0800
Message-ID: <CAP-5=fWhiLJ97smNySGk+TmmQ=ELOdztqdb7h3hrxT+18wG_HA@mail.gmail.com>
Subject: Re: [PATCH v3 10/20] perf dwarf-regs: Move csky dwarf-regs out of arch
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 16, 2024 at 05:25:10PM -0700, Ian Rogers wrote:
> > Move arch/csky/util/dwarf-regs.c to util/dwarf-regs-csky.c and compile
> > in unconditionally. To avoid get_arch_regstr being duplicated, rename
> > to get_csky_regstr and add to get_dwarf_regstr switch.
> >
> > Update #ifdefs to allow ABI V1 and V2 tables at the same
> > time. Determine the table from the ELF flags.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/csky/util/Build               |  1 -
> >  tools/perf/util/Build                         |  1 +
> >  .../dwarf-regs.c =3D> util/dwarf-regs-csky.c}   | 19 ++++++++++-------=
--
> >  tools/perf/util/dwarf-regs.c                  | 11 +++++++----
> >  tools/perf/util/include/dwarf-regs.h          |  2 ++
> >  5 files changed, 20 insertions(+), 14 deletions(-)
> >  rename tools/perf/{arch/csky/util/dwarf-regs.c =3D> util/dwarf-regs-cs=
ky.c} (74%)
> >
> > diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/uti=
l/Build
> > index 1325310cab6a..5e6ea82c4202 100644
> > --- a/tools/perf/arch/csky/util/Build
> > +++ b/tools/perf/arch/csky/util/Build
> > @@ -1,4 +1,3 @@
> >  perf-util-y +=3D perf_regs.o
> >
> > -perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 4c615611b9d7..99ae4e2802b8 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -203,6 +203,7 @@ endif
> >  perf-util-$(CONFIG_LIBDW) +=3D probe-finder.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-aux.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> > +perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-csky.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >  perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> > diff --git a/tools/perf/arch/csky/util/dwarf-regs.c b/tools/perf/util/d=
warf-regs-csky.c
> > similarity index 74%
> > rename from tools/perf/arch/csky/util/dwarf-regs.c
> > rename to tools/perf/util/dwarf-regs-csky.c
> > index ca86ecaeacbb..d38ef1f07f3e 100644
> > --- a/tools/perf/arch/csky/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs-csky.c
> > @@ -5,9 +5,8 @@
> >  #include <stddef.h>
> >  #include <dwarf-regs.h>
> >
> > -#if defined(__CSKYABIV2__)
> > -#define CSKY_MAX_REGS 73
> > -const char *csky_dwarf_regs_table[CSKY_MAX_REGS] =3D {
> > +#define CSKY_ABIV2_MAX_REGS 73
> > +const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] =3D {
> >       /* r0 ~ r8 */
> >       "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3=
",
> >       /* r9 ~ r15 */
> > @@ -26,9 +25,9 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] =3D =
{
> >       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> >       "%epc",
> >  };
> > -#else
> > -#define CSKY_MAX_REGS 57
> > -const char *csky_dwarf_regs_table[CSKY_MAX_REGS] =3D {
> > +
> > +#define CSKY_ABIV1_MAX_REGS 57

Definition of CSKY_ABIV1_MAX_REGS.

> > +const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] =3D {
> >       /* r0 ~ r8 */
> >       "%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
> >       /* r9 ~ r15 */
> > @@ -41,9 +40,11 @@ const char *csky_dwarf_regs_table[CSKY_MAX_REGS] =3D=
 {
> >       NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
> >       "%epc",
> >  };
> > -#endif
> >
> > -const char *get_arch_regstr(unsigned int n)
> > +const char *get_csky_regstr(unsigned int n, unsigned int flags)
> >  {
> > -     return (n < CSKY_MAX_REGS) ? csky_dwarf_regs_table[n] : NULL;
> > +     if (flags & EF_CSKY_ABIV2)
>
> Hmm.. you need it here as well.

These constants are part of the dwarf-regs-csky.c file and not elf.h.

> > +             return (n < CSKY_ABIV2_MAX_REGS) ? csky_dwarf_regs_table_=
abiv2[n] : NULL;
> > +
> > +     return (n < CSKY_ABIV1_MAX_REGS) ? csky_dwarf_regs_table_abiv1[n]=
 : NULL;
> >  }
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.=
c
> > index fd21f9e90e40..9a76f83af62c 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -29,17 +29,18 @@
> >  #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n=
)] : NULL)
> >
> >  /* Return architecture dependent register string (for kprobe-tracer) *=
/
> > -const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
> > -                          unsigned int flags __maybe_unused)
> > +const char *get_dwarf_regstr(unsigned int n, unsigned int machine, uns=
igned int flags)
> >  {
> > -#if EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_386 || EM_HOST =3D=
=3D EM_AARCH64 || EM_HOST =3D=3D EM_ARM
> > +#if EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_386 || EM_HOST =3D=
=3D EM_AARCH64 || EM_HOST =3D=3D EM_ARM \
> > +    || EM_HOST =3D=3D EM_CSKY
>
> And here too.  It seems you also need a rebase.
>
> At this point, I'm giving up.  Can you please refresh the series with
> a fix?

Sure I'll rebase and add ifndef+defines to dwarf-regs.h, I see we have
these currently for EM_AARCH64 and EM_LOONGARCH there.

Thanks,
Ian

