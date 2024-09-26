Return-Path: <linux-kernel+bounces-340642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BE6987631
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07A41F2364B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4B913632B;
	Thu, 26 Sep 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcCXN79s"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA9EAD5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362984; cv=none; b=ayOZ27wjbuqfOy3BC2yYUE1/qnsKQL62cvKUClovtkCe5cks0UgOgdjUKJsgTxfnoLwPgMW6sdq//ur5fUVGzWQenk88PzPDD0VpbleOATJkj9xgR/AZ0t/Kf3dfVSMd230bTDvu9LhTXLK7bXaeO2/cLVJp3CfBQ1c1kjV8ZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362984; c=relaxed/simple;
	bh=Z3Snl4GD1t4iX0xDYCwueOatBmZDz1vF9JkS84az3B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np6iHLH8VnDjStg3yEOgZpOeJRGFvEwVPiXmQI9/25RgOsW3FYXo03OxeNVEwyctdnnWSWNKbZBji30vbJCOylqWNNSlPTVxjzpYmmVpvGE9zSkrETfxaYb7KVOj6+2fhz2mQH5JvDU5DxGNc/n785vJ9WG+fQHrc5dBnfa3tlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcCXN79s; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a0cb892c6aso338025ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727362981; x=1727967781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1iuArS0fJ5ed7bL2Q/y6AR+G7q/Ve2bNJs8fOXjACA=;
        b=TcCXN79s2TLoGevxNCE3QCwhs1TItDSPfJRCxK62F8NoVuaCz4yej6Fk2vSe6scwzT
         c+PpIw7/aJP3uTIgpQ5wta20G3Wrh4tVwUoRB3BrjCeDm1ZsHNXTC6nzksSfaHl/pru0
         OdkrbKFd9S1GRlkvHlfQwN90+Hsm4kNKzqPJ45+/AqTsp152nks5icqJT9KB1ska3LmR
         dzOArD0wEBWgsLQ9BnJzuiJhRyw5h1s9/Ttnmcqw9DPRn4WK/xXPhprYEyQjFh7VY9uQ
         3QHMrvIgjscoX4okwjhB9oR9jEZAb8DNgEwczcHVVe9+pJueMVhwm+zZxQq7kzchqhxk
         nJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362981; x=1727967781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1iuArS0fJ5ed7bL2Q/y6AR+G7q/Ve2bNJs8fOXjACA=;
        b=N5R0rAO49Mwo/bhW4fnjF+xu8IzWG6iSrxjvGOG9BSTgYBKRwqJOgtr0/exFkZCq5f
         wefmWCZCxT0k2Wtmbhj9MNlgtZ9KQe3cr2cL8k0SlKj6ExvfENEz9UXPS2sPkmuqcT0k
         wBEdv1IgolA20oEei5Xh92iRWTrOzAhtgMIhRVYYQieFyi404LKHKUrDys7XFxNoAlcL
         XjEvmCngVk5bQqtcMvW907621TMWBdJ/4KMa7AADsE0hNCKrtbZktbWmTlkFn1bLJ1iG
         kZML+jLOBIXn4uEaBQLusCoK8dM+WHV+udXEJMDD9chcZDft4F1CP5tVwBziASZEifDB
         q34Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZbc1ThACJD/aesD9XlYQpiuZcRZYY2BaU565A8W4jeBluG3mokIruKVs/7A9rNhyIkmHyOq9Hv37H6UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxow40VXJ3CLZwvABEGq+tiLjeOLCUgnLE3sVlJFx15gBbW1k0u
	hC6uV722Cs2hKKxGOVjlRE1fKubuPNFDUwHEFwOpeoHYjn+6UcVSfSZh2rb1jJ3hSP+tmvWe86J
	elrB5JrLCgl/cqr1WX9tPVzjY21zPw1+hgvO+
X-Google-Smtp-Source: AGHT+IHTEszqnllacXBiZHatVwXos50uX+bhFpvnKlIv+kiNEtZznyVTwxZX5IJ+ZGi1BAndOJ7480rTwDkDYsyErT8=
X-Received: by 2002:a05:6e02:b21:b0:3a0:8cb6:3ad1 with SMTP id
 e9e14a558f8ab-3a29c60196amr3833165ab.20.1727362980208; Thu, 26 Sep 2024
 08:03:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-2-irogers@google.com>
 <ZvSqNqNKKysw_309@google.com>
In-Reply-To: <ZvSqNqNKKysw_309@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:02:45 -0700
Message-ID: <CAP-5=fUf40_4LbsYOavy45L=153bAVuwK_km8UKNQ3imSQ-_2w@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] perf build: Rename NO_DWARF to NO_LIBDW
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:08AM -0700, Ian Rogers wrote:
> > NO_DWARF could mean more than NO_LIBDW support, in particular no
> > libunwind support. Rename to be more intention revealing.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.config         | 16 ++++++++--------
> >  tools/perf/Makefile.perf           |  2 +-
> >  tools/perf/arch/arm/Makefile       |  2 +-
> >  tools/perf/arch/arm64/Makefile     |  2 +-
> >  tools/perf/arch/csky/Makefile      |  2 +-
> >  tools/perf/arch/loongarch/Makefile |  2 +-
> >  tools/perf/arch/mips/Makefile      |  2 +-
> >  tools/perf/arch/powerpc/Makefile   |  2 +-
> >  tools/perf/arch/riscv/Makefile     |  2 +-
> >  tools/perf/arch/s390/Makefile      |  2 +-
> >  tools/perf/arch/sh/Makefile        |  2 +-
> >  tools/perf/arch/sparc/Makefile     |  2 +-
> >  tools/perf/arch/x86/Makefile       |  2 +-
> >  tools/perf/arch/xtensa/Makefile    |  2 +-
> >  tools/perf/builtin-probe.c         |  2 +-
> >  15 files changed, 22 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 5e26d3a91b36..55a39211496d 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -429,7 +429,7 @@ ifeq ($(feature-file-handle), 1)
> >  endif
> >
> >  ifdef NO_LIBELF
> > -  NO_DWARF :=3D 1
> > +  NO_LIBDW :=3D 1
> >    NO_LIBUNWIND :=3D 1
> >    NO_LIBDW_DWARF_UNWIND :=3D 1
> >    NO_LIBBPF :=3D 1
> > @@ -471,9 +471,9 @@ else
> >        endif
> >      endif
> >      ifneq ($(feature-dwarf), 1)
> > -      ifndef NO_DWARF
> > +      ifndef NO_LIBDW
> >          $(warning No libdw.h found or old libdw.h found or elfutils is=
 older than 0.138, disables dwarf support. Please install new elfutils-deve=
l/libdw-dev)
> > -        NO_DWARF :=3D 1
> > +        NO_LIBDW :=3D 1
> >        endif
> >      else
> >        ifneq ($(feature-dwarf_getlocations), 1)
> > @@ -496,7 +496,7 @@ ifeq ($(feature-libaio), 1)
> >    endif
> >  endif
> >
> > -ifdef NO_DWARF
> > +ifdef NO_LIBDW
> >    NO_LIBDW_DWARF_UNWIND :=3D 1
> >  endif
> >
> > @@ -574,17 +574,17 @@ ifndef NO_LIBELF
> >      endif
> >    endif
> >
> > -  ifndef NO_DWARF
> > +  ifndef NO_LIBDW
> >      ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
> >        $(warning DWARF register mappings have not been defined for arch=
itecture $(SRCARCH), DWARF support disabled)
> > -      NO_DWARF :=3D 1
> > +      NO_LIBDW :=3D 1
> >      else
> >        CFLAGS +=3D -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
> >        LDFLAGS +=3D $(LIBDW_LDFLAGS)
> >        EXTLIBS +=3D ${DWARFLIBS}
> >        $(call detected,CONFIG_DWARF)
> >      endif # PERF_HAVE_DWARF_REGS
> > -  endif # NO_DWARF
> > +  endif # NO_LIBDW
> >
> >    ifndef NO_LIBBPF
> >      ifeq ($(feature-bpf), 1)
> > @@ -633,7 +633,7 @@ ifdef PERF_HAVE_JITDUMP
> >  endif
> >
> >  ifeq ($(SRCARCH),powerpc)
> > -  ifndef NO_DWARF
> > +  ifndef NO_LIBDW
> >      CFLAGS +=3D -DHAVE_SKIP_CALLCHAIN_IDX
> >    endif
> >  endif
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 9dd2e8d3f3c9..a144bfaf8aeb 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -40,7 +40,7 @@ include ../scripts/utilities.mak
> >  #
> >  # Define EXTRA_PERFLIBS to pass extra libraries to PERFLIBS.
> >  #
> > -# Define NO_DWARF if you do not want debug-info analysis feature at al=
l.
> > +# Define NO_LIBDW if you do not want debug-info analysis feature at al=
l.
>
> Can we keep NO_DWARF for compatibility and set NO_LIBDW=3D1 internally?
> I think it's fine to change it here to advertise NO_LIBDW over NO_DWARF
> but still want to support NO_DWARF as well.

This would be actively confusing. NO_DWARF should really imply
NO_LIBUNWIND, it is like removing the ability for "perf record
--call-graph dwarf" to work - dwarf meaning libdw or libunwind in the
tool. Having NO_DWARF control NO_LIBDW, I'm not sure what I'm being
asked to do. The point of this clean up is to make the names mean what
they should mean and not something potentially confusingly broader,
but you're asking for the confusingly broader case to mean just libdw.
I don't follow and I don't see how it serves the purpose of the
cleanup.

> Also it seem we don't have an entry in the tests/make for no-dwarf
> build.  Can you please add one too?

Sure.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  #
> >  # Define WERROR=3D0 to disable treating any warnings as errors.
> >  #
> > diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefil=
e
> > index 1d88fdab13bf..9b164d379548 100644
> > --- a/tools/perf/arch/arm/Makefile
> > +++ b/tools/perf/arch/arm/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >  PERF_HAVE_JITDUMP :=3D 1
> > diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Mak=
efile
> > index 5735ed4479bb..8a5ffbfe809f 100644
> > --- a/tools/perf/arch/arm64/Makefile
> > +++ b/tools/perf/arch/arm64/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >  PERF_HAVE_JITDUMP :=3D 1
> > diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makef=
ile
> > index 88c08eed9c7b..119b06a64bed 100644
> > --- a/tools/perf/arch/csky/Makefile
> > +++ b/tools/perf/arch/csky/Makefile
> > @@ -1,4 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> > diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loong=
arch/Makefile
> > index c89d6bb6b184..1cc5eb01f32b 100644
> > --- a/tools/perf/arch/loongarch/Makefile
> > +++ b/tools/perf/arch/loongarch/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> > diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makef=
ile
> > index cd0b011b3be5..733f7b76f52d 100644
> > --- a/tools/perf/arch/mips/Makefile
> > +++ b/tools/perf/arch/mips/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >
> > diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc=
/Makefile
> > index bf6d323574f6..7672d555f6cd 100644
> > --- a/tools/perf/arch/powerpc/Makefile
> > +++ b/tools/perf/arch/powerpc/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >
> > diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Mak=
efile
> > index 90c3c476a242..4664a78a1afd 100644
> > --- a/tools/perf/arch/riscv/Makefile
> > +++ b/tools/perf/arch/riscv/Makefile
> > @@ -1,4 +1,4 @@
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET :=3D 1
> > diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makef=
ile
> > index 56994e63b43a..3f66e2ede3f7 100644
> > --- a/tools/perf/arch/s390/Makefile
> > +++ b/tools/perf/arch/s390/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >  HAVE_KVM_STAT_SUPPORT :=3D 1
> > diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
> > index 88c08eed9c7b..119b06a64bed 100644
> > --- a/tools/perf/arch/sh/Makefile
> > +++ b/tools/perf/arch/sh/Makefile
> > @@ -1,4 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> > diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Mak=
efile
> > index 4031db72ba71..7741184894c8 100644
> > --- a/tools/perf/arch/sparc/Makefile
> > +++ b/tools/perf/arch/sparc/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >
> > diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefil=
e
> > index 67b4969a6738..9aa58acb5564 100644
> > --- a/tools/perf/arch/x86/Makefile
> > +++ b/tools/perf/arch/x86/Makefile
> > @@ -1,5 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> >  HAVE_KVM_STAT_SUPPORT :=3D 1
> > diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/M=
akefile
> > index 88c08eed9c7b..119b06a64bed 100644
> > --- a/tools/perf/arch/xtensa/Makefile
> > +++ b/tools/perf/arch/xtensa/Makefile
> > @@ -1,4 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -ifndef NO_DWARF
> > +ifndef NO_LIBDW
> >  PERF_HAVE_DWARF_REGS :=3D 1
> >  endif
> > diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> > index 003a3bcebfdf..91672bb3047c 100644
> > --- a/tools/perf/builtin-probe.c
> > +++ b/tools/perf/builtin-probe.c
> > @@ -616,7 +616,7 @@ __cmd_probe(int argc, const char **argv)
> >       set_option_flag(options, 'L', "line", PARSE_OPT_EXCLUSIVE);
> >       set_option_flag(options, 'V', "vars", PARSE_OPT_EXCLUSIVE);
> >  #else
> > -# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_DW=
ARF=3D1", c)
> > +# define set_nobuild(s, l, c) set_option_nobuild(options, s, l, "NO_LI=
BDW=3D1", c)
> >       set_nobuild('L', "line", false);
> >       set_nobuild('V', "vars", false);
> >       set_nobuild('\0', "externs", false);
> > --
> > 2.46.0.792.g87dc391469-goog
> >

