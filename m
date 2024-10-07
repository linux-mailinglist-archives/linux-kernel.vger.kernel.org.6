Return-Path: <linux-kernel+bounces-353698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90239993145
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050E4B23E40
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10421DA0FE;
	Mon,  7 Oct 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHxsOzyr"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E871D95A3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315145; cv=none; b=azX/L14vMwYYbuVL9x/BV7JbIajExSg+xcwSUi9AfeqNaHXqkXIV2nWrnOF995Dz7Lu+K1XN353Nca7Y7TrF5FBERZa3pa0fx8ciqyyEb0wpBZbKyYRO1wpo4p3v26D5mEap4Myv8gLKWQswXOuJeu7xfaKmsj3pd3fQuJqAAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315145; c=relaxed/simple;
	bh=sATp4bnQZOdPhjlk7F/9DfVJ1rQ8KktY9Eh1owaoPUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0w4yPJorW2sCazNTJGLk28aImX6PBYuFKv5Xqrepqyd7JFlBhactkqo1XtGkmDVhW3u7/tOS3fdns2Wai2l50x/wJiLxmYTVmE0YTuJU5yC2NYlYjRpXQAuju8XdCiX4rJH1VpdDhz6ZKRxdiYIjDyBF36Ldxc3O91FccHCADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHxsOzyr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b4a090f3eso259985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728315142; x=1728919942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gMzLm6GeDyitzticM5hzWB6E5aII3zloFuT3pmuk5o=;
        b=tHxsOzyrVNcoXpPiRE7r+SZlEuH75uF7pnlFsXAvZJCZNCWI5+Js6yglBHEQda5zbO
         uQAvWXjBlJks5hNBqKJBv+9N2mdlsEffeWQ65q+qwpb/rbxc+rGiAuqTSpl7H6EagENN
         WIWYb4UpE49COe/vzPh10iB9xw9clqaHx/0fJeloYeXjqcuXyPw/P9b39nR5TAIZoMyA
         GFPyA8XK8I/SAFHUM1p/Xcbb1oAWomHrcorau5U5BEh7K0GoBX3IAKQBwa4iy62cRDWi
         adLD5hozzsbyF6C2JYURzJmCTXAVVX5HYhIinLabR757TqBZx7rTlgpdaGGN3HyYG9Lj
         0cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315142; x=1728919942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gMzLm6GeDyitzticM5hzWB6E5aII3zloFuT3pmuk5o=;
        b=ZV7UQmMaR6GkFQC0MQK+GiEyw9MKB3GMVb33iUmOcuBgvKn9LSDg/pwRYlBs1uWy4s
         JNIJ47ordOrQOo4R6YcNRVYvvzMryKEP4IW8GNYR4kjtFYQevKmRYHGat7mRLBwgQa8m
         tSk0/DqF/81+6+37EVczr84oX7t3ql1NDKPZF0UKq9feQoXLVU2SQIdA72gFPAQxw62F
         gF7KlXQbAdSz5Yn5RVWNKSiJRsGi16xraZlHbs3HOyO54PENJOGy5hSUrQGxUxRz7mDN
         H2UJ4jIOIv/UsGZpaYbH1Ck93Y76+NFKf7bi5wp6H9sk4GuAwVPYat6mbcxCatwIFmvv
         yzSg==
X-Forwarded-Encrypted: i=1; AJvYcCV4cj2mE3L+Nvi1T7zMGxoLcVVVXMD+00xhaVKWuXTqBdHxf6vPL6TRfVuCOG+uqvIpSMWHyNxWtySjZ7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzV4E/K2a8uBfd3NdNg+BcVeZsF/HWJla/amxMAS62Vv7dnCCR
	I65Aas9iwomNSkob+tqSAY1kVhT/TmkSYPBiT5v4bdGoCTl2zxxU4RB3uWQKI85bodbl82HG9cA
	M+iRBmRGnfuhW/4NTWi4wRQJkROrgQpzmrUwQ
X-Google-Smtp-Source: AGHT+IE8EjFttm1Va0WqG8l2f0/amiuCoYKfQShIturGToYPzv43NL3LOmdB4U0J5gpFN+f+JaXzkWQhd+QZ2gG/RJM=
X-Received: by 2002:a17:903:24f:b0:1fc:60f2:a089 with SMTP id
 d9443c01a7336-20c192b9989mr2909975ad.17.1728315141788; Mon, 07 Oct 2024
 08:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com> <20241005195541.380070-19-irogers@google.com>
 <20241007173453.288ec1580855c29af0863d89@kernel.org>
In-Reply-To: <20241007173453.288ec1580855c29af0863d89@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Oct 2024 08:32:09 -0700
Message-ID: <CAP-5=fV29jLxFUDwMFvnaV6R4ZkQg=KZ_FwU+ueQQLof1R3tRw@mail.gmail.com>
Subject: Re: [PATCH v2 18/31] perf dwarf-regs: Move x86 dwarf-regs out of arch
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

On Mon, Oct 7, 2024 at 1:35=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Sat,  5 Oct 2024 12:55:28 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > Move arch/x86/util/dwarf-regs.c to util/dwarf-regs-x86.c and compile
> > in unconditionally. To avoid get_arch_regnum being duplicated, rename
> > to get_x86_regnum and add to get_dwarf_regnum switch.
> >
> > For get_arch_regstr, this was unused on x86 unless the machine type
> > was EM_NONE. Map that case to EM_HOST and remove get_arch_regstr from
> > dwarf-regs-x86.c.
> >
>
> Hmm, I'm not sure this change. I feel like to keep the arch dependent
> part under arch/ directory

Code in the arch directory is built with this condition:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/Build?h=3Dperf-tools-next
perf-util-y +=3D $(SRCARCH)/
That is we only enter an arch directory if it matches the architecture
we're building for.
I think what you are saying is that it'd be nice if x86 related code
were in the arch directory, but with things as they are that means the
x86 related code wouldn't be built on say ARM.

To workaround this there is plenty of architecture specific code in
tools/perf/util:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util?h=3Dperf-tools-next
amd-sample-raw.c
arm64-frame-pointer-unwind-support.c
arm64-frame-pointer-unwind-support.h
arm-spe.c
arm-spe-decoder
arm-spe.h
intel-bts.c
intel-bts.h
intel-pt.c
intel-pt-decoder
intel-pt.h
intel-tpebs.c
intel-tpebs.h
s390-cpumcf-kernel.h
s390-cpumsf.c
s390-cpumsf.h
s390-cpumsf-kernel.h
s390-sample-raw.c

With this change added are:
dwarf-regs-csky.c
dwarf-regs-powerpc.c
dwarf-regs-x86.c

So I feel this way of doing things is most consistent and achieves the
best result.

In general I think the arch directory in perf is a mistake:
1) it breaks the profile on one platform, analyze on another model -
in this series it is shown that using the ELF machine is just better
than hard coding to the host architecture;
2) it is used as something of an ifdef __<arch>__ replacement but in a
way that makes understanding behavior in the code harder to fathom as
you need to understand weak functions (not a C feature) and the build
logic;
3) much of the code is really PMU driver dependent rather than
architecture dependent, moving such code out of arch would enable
things like user space emulation of the perf tool.

> But if this is just for reverse mapping of
> regname -> regnum, since we already have regnum -> regname maps in the
> header file, we can reimplement get_dwarf_regnum() as a generic function.
> And that is what you does in this series, correct?

That work could be done for get_dwarf_regnum but isn't done in this
series. Most architectures are missing get_arch_regnum.
For get_dwarf_regstr and get_arch_regstr there was the redundancy as
get_dwarf_regstr would compute a regstr if the machine wasn't E_NONE
in most cases. get_arch_regstr was only used for E_NONE. This code
changes E_NONE to E_HOST and then the get_arch_regstr code isn't
needed. There are #ifdefs adding complexity as I didn't do a single
monolithic patch - the maintainers usually complain if you do big
monolithic patches. Patches at the end of the series remove all the
#ifdefs, it is just without them the series will break cross
compilation if you bisect into the middle of it.

> If so, can you make a generic get_dwarf_regnum() at first, and remove
> the architecture dependent part which is not needed anymore.
> That should be more simpler to review.

I think this is out of scope for this series, not least because of the
testing challenge, but could be follow up work.

Thanks,
Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/Build                |  3 ---
> >  tools/perf/util/Build                         |  1 +
> >  .../dwarf-regs.c =3D> util/dwarf-regs-x86.c}    | 24 +----------------=
--
> >  tools/perf/util/dwarf-regs.c                  | 17 +++++++++++++
> >  tools/perf/util/include/dwarf-regs.h          |  8 +++++++
> >  5 files changed, 27 insertions(+), 26 deletions(-)
> >  rename tools/perf/{arch/x86/util/dwarf-regs.c =3D> util/dwarf-regs-x86=
.c} (77%)
> >
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/=
Build
> > index 9705cda4f240..70af491a6dd7 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -12,9 +12,6 @@ perf-util-y +=3D evsel.o
> >  perf-util-y +=3D iostat.o
> >  perf-util-y +=3D env.o
> >
> > -perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> > -perf-util-$(CONFIG_BPF_PROLOGUE) +=3D dwarf-regs.o
> > -
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> >  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 1d08608b7e1b..c2221ef431f3 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -202,6 +202,7 @@ endif
> >  perf-util-$(CONFIG_LIBDW) +=3D probe-finder.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-aux.o
> >  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs.o
> > +perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> >  perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
> >  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
> >
> > diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/util/dw=
arf-regs-x86.c
> > similarity index 77%
> > rename from tools/perf/arch/x86/util/dwarf-regs.c
> > rename to tools/perf/util/dwarf-regs-x86.c
> > index 530905118cd4..7a55c65e8da6 100644
> > --- a/tools/perf/arch/x86/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs-x86.c
> > @@ -11,28 +11,6 @@
> >  #include <linux/kernel.h> /* for ARRAY_SIZE */
> >  #include <dwarf-regs.h>
> >
> > -#define DEFINE_DWARF_REGSTR_TABLE 1
> > -#include "dwarf-regs-table.h"
> > -
> > -/* Return architecture dependent register string (for kprobe-tracer) *=
/
> > -const char *get_arch_regstr(unsigned int n)
> > -{
> > -#if defined(__i386__)
> > -     size_t len =3D ARRAY_SIZE(x86_32_regstr_tbl);
> > -#else
> > -     size_t len =3D ARRAY_SIZE(x86_64_regstr_tbl);
> > -#endif
> > -
> > -     if (n >=3D len)
> > -             return NULL;
> > -
> > -#if defined(__i386__)
> > -     return x86_32_regstr_tbl[n];
> > -#else
> > -     return x86_64_regstr_tbl[n];
> > -#endif
> > -}
> > -
> >  struct dwarf_regs_idx {
> >       const char *name;
> >       int idx;
> > @@ -58,7 +36,7 @@ static const struct dwarf_regs_idx x86_regidx_table[]=
 =3D {
> >       { "rip", DWARF_REG_PC },
> >  };
> >
> > -int get_arch_regnum(const char *name)
> > +int get_x86_regnum(const char *name)
> >  {
> >       unsigned int i;
> >
> > diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.=
c
> > index 86b3ef638fbb..eac99a246737 100644
> > --- a/tools/perf/util/dwarf-regs.c
> > +++ b/tools/perf/util/dwarf-regs.c
> > @@ -32,9 +32,17 @@
> >  const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
> >                            unsigned int flags __maybe_unused)
> >  {
> > +#if EM_HOST =3D=3D EM_X86_64 || EM_HOST =3D=3D EM_386
> > +     if (machine =3D=3D EM_NONE) {
> > +             /* Generic arch - use host arch */
> > +             machine =3D EM_HOST;
> > +     }
> > +#endif
> >       switch (machine) {
> > +#if EM_HOST !=3D EM_X86_64 && EM_HOST !=3D EM_386
> >       case EM_NONE:   /* Generic arch - use host arch */
> >               return get_arch_regstr(n);
> > +#endif
> >       case EM_386:
> >               return __get_dwarf_regstr(x86_32_regstr_tbl, n);
> >       case EM_X86_64:
> > @@ -65,10 +73,12 @@ const char *get_dwarf_regstr(unsigned int n, unsign=
ed int machine,
> >       return NULL;
> >  }
> >
> > +#if EM_HOST !=3D EM_X86_64 && EM_HOST !=3D EM_386
> >  __weak int get_arch_regnum(const char *name __maybe_unused)
> >  {
> >       return -ENOTSUP;
> >  }
> > +#endif
> >
> >  /* Return DWARF register number from architecture register name */
> >  int get_dwarf_regnum(const char *name, unsigned int machine, unsigned =
int flags __maybe_unused)
> > @@ -90,9 +100,16 @@ int get_dwarf_regnum(const char *name, unsigned int=
 machine, unsigned int flags
> >               machine =3D EM_HOST;
> >       }
> >       switch (machine) {
> > +#if EM_HOST !=3D EM_X86_64 && EM_HOST !=3D EM_386
> >       case EM_HOST:
> >               reg =3D get_arch_regnum(regname);
> >               break;
> > +#endif
> > +     case EM_X86_64:
> > +             fallthrough;
> > +     case EM_386:
> > +             reg =3D get_x86_regnum(regname);
> > +             break;
> >       default:
> >               pr_err("ELF MACHINE %x is not supported.\n", machine);
> >       }
> > diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inc=
lude/dwarf-regs.h
> > index 925525405e2d..062623aefd5a 100644
> > --- a/tools/perf/util/include/dwarf-regs.h
> > +++ b/tools/perf/util/include/dwarf-regs.h
> > @@ -79,7 +79,10 @@
> >  #define DWARF_REG_FB  0xd3affb /* random number */
> >
> >  #ifdef HAVE_LIBDW_SUPPORT
> > +#if !defined(__x86_64__) && !defined(__i386__)
> >  const char *get_arch_regstr(unsigned int n);
> > +#endif
> > +
> >  /**
> >   * get_dwarf_regstr() - Returns ftrace register string from DWARF regn=
um.
> >   * @n: DWARF register number.
> > @@ -88,7 +91,12 @@ const char *get_arch_regstr(unsigned int n);
> >   */
> >  const char *get_dwarf_regstr(unsigned int n, unsigned int machine, uns=
igned int flags);
> >
> > +int get_x86_regnum(const char *name);
> > +
> > +#if !defined(__x86_64__) && !defined(__i386__)
> >  int get_arch_regnum(const char *name);
> > +#endif
> > +
> >  /*
> >   * get_dwarf_regnum - Returns DWARF regnum from register name
> >   * name: architecture register name
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

