Return-Path: <linux-kernel+bounces-340646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4098763D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7611F27C25
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFE114831C;
	Thu, 26 Sep 2024 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Loa6j8EH"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CB14D703
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363419; cv=none; b=XRUfB4Kvbi/j7Svc+hKkWDMIv6Mh5UwTsu7oz+BGfdjll4nCH5gN/CAY8KCokGq9BTujstw0bBuH97YwuKD+WT+hhCY2+jkLoA6ROLyivlT1kjMaO9o1+Aiejjazx7lj2XNTFXYJVGvJ9Eg3lhhwD13QWzbI9FIx6gG7s7KtWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363419; c=relaxed/simple;
	bh=hVE5ZilPLPNfrXuAXy2c+9nnJM7MfQr580xYHLvoS5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cu0IBmxCXC5PXaelHUMDKINNXRdsDbUe2DZ8llsEyo3qJ9Uc8wmUoAcy8a8VnBWnipCwP0/un1VtE54qGKeeV5xlEo7y23yGNKDM/U+VTaU34mk5SQMvYiVtqUuFtKiSBq1nYI9x/wqOUDyowdSgIzVNlVrpfhi0v1L9oXD8co4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Loa6j8EH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2056aa5cefcso244715ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727363417; x=1727968217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd5wd2EDy91T2PV08KE1FbhF8/gu2jxlRWd3WkzT05w=;
        b=Loa6j8EHZu4P4kGTCvSe4W9ZdLLykufzI2am6uezCHNPZjwBDmVvSfnH6sSGKw9DFU
         VYm/+SOFG+rVr/AfzZGP2+4RiKIvMKD6QM9Ih4CmVzSpoOGBLRLFCo9w6XDVf3sJljlb
         4lCD9Bo1TRR8HWL8/NaoIc1lOQ4jCJ+rbinlyyjHAO2BzN8jMDpF4ZQHGkioZuWzLAAo
         j6plwBWxwVZroOh+YZpcJ/Bq1gOewcz6pJxDeOXELcoiSACmG+1ypXW97g3SU3P4TymP
         xT/MXkWNl+mmKkkNga90+jzTN2cSvuPU9Wr4+/E0Jv1bkEzCdqSXghUUDzO3GO+Iug4Q
         Xqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727363417; x=1727968217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd5wd2EDy91T2PV08KE1FbhF8/gu2jxlRWd3WkzT05w=;
        b=lo4ic5o0rq6EA4No/DwQlUeP1Js/ZO45iit1f0V66zk1XvD6O/lbYOf7aJ/bxD2UPs
         Qry8JglkezXEiLSx9TeLttUR2HeT5qU3z5sWJYBP7CJi4pLw6mroq3SHvVadq5DjTiBb
         iecbXpcSs0TQLgxGr0g1jqoQZITV2OTZ4iihoHvkbk9yN4d7kWbSoCYULFWW+2nbAtRL
         dMCBXEYuY6i5xFNesGXMVe0n5qqGZdWeXjAmAmkmvJWwuoYkgovr9hmryjB0+MesfuGY
         Lz64vwHkJ9iqMi3Mf0EFLALXnHX4XdB9G1seeldqA8Qamj/vz3USmdGPKhs7nk66lHjE
         Rp/g==
X-Forwarded-Encrypted: i=1; AJvYcCXTRuYpmk/esmcUvUo5uU53VgX+19x9mwaw41R3Ttu7s/QNGdXj/amzL2GvlsAwp3gRs14AxFVlC0df/Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJRZyyHh1KA26BKaCSE3V9EM9YGK/9Dlly/PYsH+4OzS765tT
	V4MuLyhkxWtVhLI/8DMWZ8HFxvajsboJ1yl3SwY1bJTRrIDU+iz55t5UKGfBrabCDFwfVepnbfF
	JAjJ17uTxcZUehnlP//RXVSuGp21oibk9tjMe
X-Google-Smtp-Source: AGHT+IHqRahqJwKWGmO6jTznzohb0TucVdaEV7XZBmzejNts+U7KeuAbCH3+rT6TkZcAAe+lnGE5M4p+H4ijVdt+KEA=
X-Received: by 2002:a17:902:fa8e:b0:1fc:719c:5d9 with SMTP id
 d9443c01a7336-20b203cad58mr2787815ad.25.1727363416347; Thu, 26 Sep 2024
 08:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-10-irogers@google.com>
 <ZvSsB8bT3CTLT4B0@google.com>
In-Reply-To: <ZvSsB8bT3CTLT4B0@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 08:10:04 -0700
Message-ID: <CAP-5=fWe-CAgNb7ULNJc0e+Kr0zxSJZNUuF1iTrB7J=ANcUwUw@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
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

On Wed, Sep 25, 2024 at 5:34=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Sep 24, 2024 at 09:04:16AM -0700, Ian Rogers wrote:
> > In Makefile.config for unwinding the name dwarf implies either
> > libunwind or libdw. Make it clearer that HAVE_DWARF_SUPPORT is really
> > just defined when libdw is present by renaming to HAVE_LIBDW_SUPPORT.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-check.txt         |  6 +++---
> >  tools/perf/Makefile.config                      |  2 +-
> >  tools/perf/arch/powerpc/annotate/instructions.c |  4 ++--
> >  tools/perf/arch/x86/annotate/instructions.c     |  2 +-
> >  tools/perf/builtin-annotate.c                   |  2 +-
> >  tools/perf/builtin-check.c                      |  6 +++---
> >  tools/perf/builtin-probe.c                      | 12 ++++++------
> >  tools/perf/builtin-report.c                     |  4 ++--
> >  tools/perf/util/annotate-data.h                 |  8 ++++----
> >  tools/perf/util/debuginfo.h                     |  6 +++---
> >  tools/perf/util/disasm.c                        |  4 ++--
> >  tools/perf/util/disasm.h                        |  4 ++--
> >  tools/perf/util/genelf.c                        |  4 ++--
> >  tools/perf/util/genelf.h                        |  2 +-
> >  tools/perf/util/include/dwarf-regs.h            |  6 +++---
> >  tools/perf/util/probe-event.c                   |  4 ++--
> >  tools/perf/util/probe-finder.h                  |  4 ++--
> >  17 files changed, 40 insertions(+), 40 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Docum=
entation/perf-check.txt
> > index 45101a8e4154..31741499e786 100644
> > --- a/tools/perf/Documentation/perf-check.txt
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -47,15 +47,15 @@ feature::
> >                  bpf                     /  HAVE_LIBBPF_SUPPORT
> >                  bpf_skeletons           /  HAVE_BPF_SKEL
> >                  debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
> > -                dwarf                   /  HAVE_DWARF_SUPPORT
> > -                dwarf_getlocations      /  HAVE_DWARF_SUPPORT
> > +                dwarf                   /  HAVE_LIBDW_SUPPORT
> > +                dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
>
> I'm not sure if we really want to display dwarf_getlocatiosn as it's too
> implementation detail IMHO.  Maybe just 'dwarf' or 'libdw' is enough.

I think that's follow up work. I think we should rename dwarf to libdw
given the confusion using dwarf here can create.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
> >                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
> >                  libaudit                /  HAVE_LIBAUDIT_SUPPORT
> >                  libbfd                  /  HAVE_LIBBFD_SUPPORT
> >                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
> >                  libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> > -                libdw-dwarf-unwind      /  HAVE_DWARF_SUPPORT
> > +                libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
> >                  libelf                  /  HAVE_LIBELF_SUPPORT
> >                  libnuma                 /  HAVE_LIBNUMA_SUPPORT
> >                  libopencsd              /  HAVE_CSTRACE_SUPPORT

