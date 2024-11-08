Return-Path: <linux-kernel+bounces-402184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF059C24CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666541C27AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB8199385;
	Fri,  8 Nov 2024 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AClOlCTT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AC233D97
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090006; cv=none; b=ard5sQlV/Ygvyjd5kcbNqbMRn8Rpj97VYNbrGJcME21gR66ys/htD3qa/tJFjp3PVRiG8EIhJQ3hDhoPWnx93tj0kpPhs7ht/GWgEklkWvZld5vc4yoQRt2tIt4X7MRp3gOaD8yxzOaeWa6xSQpa6DtbReF9BJDKDl3pMWRHJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090006; c=relaxed/simple;
	bh=JUYHYugwKT/LOXZUS3wyLNIITd7vm4Hd7wMZQgV8EGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzBlxEdxHtT9HhAPiBFeduQ2o9S+SleTzF/bd3CEu9HXFa2OHebh6gJU0YSq9nN4+0GGdlIoIek6SumZEvg87BZm4rm5cBSijcBhTvXfRmtt2RFHwsXptpWWLeXrzttlg33GJFU+uzzw0RSSwCbIJSExgbA+uFDMHje+JYUTHhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AClOlCTT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8ac50b79so6265ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731090004; x=1731694804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf7MfvQHFHsMilMOcrRu8oE+bBUT3BnfeKEv0/Bnz2U=;
        b=AClOlCTTEviVvL3bAC0WTb6Kql8wnaZciP83XD3Oy/KLZ3Hwd4x2cQrAh9RGDOKvOv
         c9rCIWQ1Dro3Ta4YNj0DheDZ+oWiJIiYbtxGYdAOLadkt6Ko1RFOXBRjFNBNMkv4Po5H
         UZ4SOykj15ecYPYNUgMLxDmX87rJDQR3xbzLE3pSriULAXKSYexljQvPN1kBP+II/iUv
         mNStrKkYDo0XplZo7gJsn5YvxKY6aSVGa+ale5Pj5rzbINR9ucuNJ4MKrFFLTS7NQ/n+
         ecKMFA1nRwVju4vOlzVTHzvtrg7qKHlOq/XGjcYrxaMgbGNFTYU2W9n33noSd2c/6e3V
         SxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731090004; x=1731694804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf7MfvQHFHsMilMOcrRu8oE+bBUT3BnfeKEv0/Bnz2U=;
        b=rnZm8tXj+2bLo0E5EdebYfqs378xfzQIrpvNUJkBaLSBLozj7MGQZIUihM/0NAV8Rv
         MD+L6OqSc5KdRhN3lpdmSd7HHPqPj7LVJvFycjSbQo7sRxrkKXC3Z2SjfoOxsAf7Io8+
         CD8BEa1j91qYT/GWen7SqJDALz61XsZ0+KvwEvzXDaP5b4Fy07zp2W9lcA9yTf7YtOCA
         AuqgfOiKFpFs1ItFdpChMU3ITqeL3gR9ZrVcfn/pmK2Sr1n30hllUAS4USpgrGTb8MqC
         kz0q6EdAs9Fyas74Q9STLv+fHm5oF/C9FvcYDTZeAPli+mMfydakLW2PZ7Fq+sA8dPzh
         n7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2JYkp7Z5BktaBuWZJ5Vck9hAUNFHADiUZM/PdEfRmsNex4SEByAMz9OY3fK9GyH/pf4agNHy7ZnIzWqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wO9wc9CfGzihptVcmW2o915ySPRdmHJ+IfBwIBnKIkqLheaU
	q2JxYPaSOayliVEke1a1SggzCHoHVYrOVJwu6fbfgs5IK5lJTvPbOEhvZ8g8Dnrsq+ayWyw4iJk
	3LsBPHOqmnuVPE07i5s5mDnX3w/WqgncIjY8a
X-Gm-Gg: ASbGncu5QKYxdbsgx6jcYaMKwWXxGpusKTd+/l3Tsgs9M/e+iNUhFZIaUh9jp6JzVJ5
	ceAH4zGtyO3MSdlj/Swj61p0sk12bPvf3
X-Google-Smtp-Source: AGHT+IGAGxygO8zIMuBBzlLrISaHhzYu5CrxNemIriyDIaZe+XR//zXcE6s13MhITP3HJRDsgVoeguyaiFUqTkwRFOs=
X-Received: by 2002:a17:902:d4c7:b0:205:968b:31e9 with SMTP id
 d9443c01a7336-211748f482dmr6592465ad.1.1731090004012; Fri, 08 Nov 2024
 10:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com> <20241017002520.59124-5-irogers@google.com>
 <Zy5Le-xn4gzQ2WLo@google.com>
In-Reply-To: <Zy5Le-xn4gzQ2WLo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 8 Nov 2024 10:19:52 -0800
Message-ID: <CAP-5=fXe-gJ6pXwdTgGqScCR+mKS2FBfVDsbih7vL-1kPKAvaA@mail.gmail.com>
Subject: Re: [PATCH v3 04/20] perf disasm: Add e_machine/e_flags to struct arch
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

On Fri, Nov 8, 2024 at 9:33=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Oct 16, 2024 at 05:25:04PM -0700, Ian Rogers wrote:
> > Currently functions like get_dwarf_regnum only work with the host
> > architecture. Carry the elf machine and flags in struct arch so that
> > in disassembly these can be used to allow cross platform disassembly.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arc/annotate/instructions.c       | 2 ++
> >  tools/perf/arch/arm/annotate/instructions.c       | 2 ++
> >  tools/perf/arch/arm64/annotate/instructions.c     | 2 ++
> >  tools/perf/arch/csky/annotate/instructions.c      | 7 ++++++-
> >  tools/perf/arch/loongarch/annotate/instructions.c | 2 ++
> >  tools/perf/arch/mips/annotate/instructions.c      | 2 ++
> >  tools/perf/arch/powerpc/annotate/instructions.c   | 2 ++
> >  tools/perf/arch/riscv64/annotate/instructions.c   | 2 ++
> >  tools/perf/arch/s390/annotate/instructions.c      | 2 ++
> >  tools/perf/arch/sparc/annotate/instructions.c     | 2 ++
> >  tools/perf/arch/x86/annotate/instructions.c       | 3 ++-
> >  tools/perf/util/disasm.h                          | 4 ++++
> >  12 files changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/arch/arc/annotate/instructions.c b/tools/perf/a=
rch/arc/annotate/instructions.c
> > index 2f00e995c7e3..e5619770a1af 100644
> > --- a/tools/perf/arch/arc/annotate/instructions.c
> > +++ b/tools/perf/arch/arc/annotate/instructions.c
> > @@ -5,5 +5,7 @@ static int arc__annotate_init(struct arch *arch, char *=
cpuid __maybe_unused)
> >  {
> >       arch->initialized =3D true;
> >       arch->objdump.comment_char =3D ';';
> > +     arch->e_machine =3D EM_ARC;
> > +     arch->e_flags =3D 0;
> >       return 0;
> >  }
> > diff --git a/tools/perf/arch/arm/annotate/instructions.c b/tools/perf/a=
rch/arm/annotate/instructions.c
> > index 2ff6cedeb9c5..cf91a43362b0 100644
> > --- a/tools/perf/arch/arm/annotate/instructions.c
> > +++ b/tools/perf/arch/arm/annotate/instructions.c
> > @@ -53,6 +53,8 @@ static int arm__annotate_init(struct arch *arch, char=
 *cpuid __maybe_unused)
> >       arch->associate_instruction_ops   =3D arm__associate_instruction_=
ops;
> >       arch->objdump.comment_char        =3D ';';
> >       arch->objdump.skip_functions_char =3D '+';
> > +     arch->e_machine =3D EM_ARM;
> > +     arch->e_flags =3D 0;
> >       return 0;
> >
> >  out_free_call:
> > diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf=
/arch/arm64/annotate/instructions.c
> > index f86d9f4798bd..d465d093e7eb 100644
> > --- a/tools/perf/arch/arm64/annotate/instructions.c
> > +++ b/tools/perf/arch/arm64/annotate/instructions.c
> > @@ -113,6 +113,8 @@ static int arm64__annotate_init(struct arch *arch, =
char *cpuid __maybe_unused)
> >       arch->associate_instruction_ops   =3D arm64__associate_instructio=
n_ops;
> >       arch->objdump.comment_char        =3D '/';
> >       arch->objdump.skip_functions_char =3D '+';
> > +     arch->e_machine =3D EM_AARCH64;
> > +     arch->e_flags =3D 0;
> >       return 0;
> >
> >  out_free_call:
> > diff --git a/tools/perf/arch/csky/annotate/instructions.c b/tools/perf/=
arch/csky/annotate/instructions.c
> > index 5337bfb7d5fc..14270311d215 100644
> > --- a/tools/perf/arch/csky/annotate/instructions.c
> > +++ b/tools/perf/arch/csky/annotate/instructions.c
> > @@ -43,6 +43,11 @@ static int csky__annotate_init(struct arch *arch, ch=
ar *cpuid __maybe_unused)
> >       arch->initialized =3D true;
> >       arch->objdump.comment_char =3D '/';
> >       arch->associate_instruction_ops =3D csky__associate_ins_ops;
> > -
> > +     arch->e_machine =3D EM_CSKY;
> > +#if defined(__CSKYABIV2__)
> > +     arch->e_flags =3D EF_CSKY_ABIV2;
> > +#else
> > +     arch->e_flags =3D EF_CSKY_ABIV1;
> > +#endif
>
> By moving this into the general code, it should take care of old systems
> that doesn't have the macro.
>
>   In file included from util/disasm.c:109:
>   /linux/tools/perf/arch/csky/annotate/instructions.c: In function 'csky_=
_annotate_init':
>   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: error: 'EF_C=
SKY_ABIV1' undeclared (first use in this function)
>      50 |         arch->e_flags =3D EF_CSKY_ABIV1;
>         |                         ^~~~~~~~~~~~~
>   /linux/tools/perf/arch/csky/annotate/instructions.c:50:25: note: each u=
ndeclared identifier is reported only once for each function it appears in

EF_CSKY_ABIV1 is defined in elf.h and has been there at least 5 years in li=
belf:
https://sourceware.org/git/?p=3Delfutils.git;a=3Dcommit;f=3Dlibelf/elf.h;h=
=3D9c82942ae7355a3226c53a92c2c73b33193c5e33
I suspected the issue here is missing elf.h include, but the .c file
is included in tools/perf/util/disasm.c and that must have a
transitive dependency given other things are building. Do you want me
to send a patch making this conditional with extra #ifdefs or re-send
the series?

> Also, I think __CSKYABIV2__ is defined only when the host is csky.  So
> it'll use ABI v1 on cross env.  I'm not sure if it's a problem.  We may
> need to save the ABI somewhere in the metadata later.

Agreed. In general we should read e_machine and e_flags from the ELF
file, so I'm not sure new metadata is needed. This patch is trying to
lay groundwork for that.

Thanks,
Ian

