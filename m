Return-Path: <linux-kernel+bounces-347699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5398DB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BC2282E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE61CF5FB;
	Wed,  2 Oct 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UnmrJads"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9658B1D0953
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879254; cv=none; b=u2AQknUQgNjSx6scRIpLVaxrV5Sge/hoaBn1Z9qTkCW88WjzIm9PQmhm/pOD4hrJRuu0ivGePeJQo8ZUZ8KyuSAYm2S9USghKuqnVDS1lJe3INqkjYvKmKUBWGaZ554YO0ZzwiGqVuvZPJRlkx6hhhZ1LbrSztb6EmEsL13P/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879254; c=relaxed/simple;
	bh=Z8/PJhwXgEGOeB2jCC05PlaXl30s2XpSMTxV8Y4qurQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3gYpHJvIxlaEDCL/ZIEuXjgqqN3M9ggQryGhsCKKRWEvw4LxXXUyUGwmYxsHfoQa+RAiAwDixkrbkoNuFmAhwI057HLippCLukEXgchvEMhnDzhRZQZjA7VPnnW42TBcTSAtoLeIHn99BfdUFR71iokusEwtnpKXx7z8GmSylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UnmrJads; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b40c7fd8eso184625ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 07:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727879251; x=1728484051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MrS1Baz5l+Alln8NkKAnz5ukcpucXesU5laz9WqZaw=;
        b=UnmrJads+NPCPnzzSq0yRYGeFKYLl/TSvDLi073qov0a8Vnplbk/hm133FvyWBcqWB
         5vrUtNxjnYNGhhqtmAM8HS2YpuLHYrXi+LBPFa4VnVAv2/RBqIi4oKkr6szeIHI4H9n2
         f858MbjR+xcNg1cmOaDLsmGs+JJXb7Gf046Q791odikauZUH1qTYIDr8ujsPM7+gzRYC
         ERoEPhKyOo2U0eoc4tCeb1x4Q364T2okV5hOyT/PlS5BCYQ5vzbdRUowU+FtujC4USVA
         UrlT/Jhgj6Ha/oFvQOjb0x+FnNn3sEKcbkerCnZiJOikIUp+DCpUFtWIrBBW+n0XTaOi
         +kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727879251; x=1728484051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MrS1Baz5l+Alln8NkKAnz5ukcpucXesU5laz9WqZaw=;
        b=Kh4ioUaHBl/ueuzX46jIRaY/zF+xXz7Ukahk7nihSbFkvzLky5a17cAx71T5zMdwVU
         jqVaWpRS0tbUOoqn8/W95GKVspTHn6pAgo69NQSyMar/09DHRHzrOijmJUpU1aiD8xJP
         +5GAU+g3VIXM2In2GcHouzmHXxPmhlkGvcH0jFQUW9cVbk/RieY7ehcHXUPSI7ByU6Gq
         oFsnWLqecjQfn2BiZ/ujlQnjzbdYZ2sJxMN9vtKGOPy5N0XeGzfIHXUfpzqN8qQH+9X6
         tUAV/W6/oUKBI+OXYq/0A+aYCqgd8H2HXwfYv3qrHGl4+hptdPvpwrd+8nLZ/dT4gfaX
         JJXg==
X-Forwarded-Encrypted: i=1; AJvYcCWICiEgQ3XvBa1JwCgGNfaAD9HhsUryIdqNr1IGTYRIT307KZ2mM9tjo1MCygIL8zktV+xDdTL5H7bhhpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/byYShEfDsmHd0/Qu6fzQyHjIdEfFPKgB/uL8Q9G+FsjTdOe
	4Fq1KaSKAaqQHPkDqtPm9ZXUxXuCRWgrMuvQ2bv3HbJvoCndH7G7A2gaSdrZDi5XdsFQGE9Z5/q
	SqmxZVliXhbTuBn4GVf5d0YGY5Xj0t18GWEpk
X-Google-Smtp-Source: AGHT+IFLCSxqa3T5ZMqD/Srvi9eWFD5Msg2v9ejwitPMwUtQ6DvMuZIIM1J9yRZEISwCilzz7UpUHjTXh0ZLV1cY6zI=
X-Received: by 2002:a17:902:dac6:b0:1fd:6c5b:afcd with SMTP id
 d9443c01a7336-20bc6ba405dmr2511205ad.22.1727879250552; Wed, 02 Oct 2024
 07:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com> <20240924160418.1391100-12-irogers@google.com>
 <ZvTUo_nbr_gKaJrs@google.com> <CAP-5=fVQVEgSK55Y_38KXyp3CJ1ssPOcqkA2JKwMDVYJe8iztA@mail.gmail.com>
 <ZvW4iZpTinJKWIFD@google.com> <CAP-5=fUcV6rXiTSpGPCGou6h9Gy-MYcYtrvdFJKCz28gQAf-LA@mail.gmail.com>
 <ZvbocHwtPkwJwDOA@google.com> <CAP-5=fWn6ejdozTt8GHvDkv-QW_GF5+b4C3kTO_544H-fXZ+0w@mail.gmail.com>
 <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org> <CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
 <ZvyBQ6xgGE4gZdoo@google.com> <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
 <20241002082859.8821e441024fe873a4301afc@kernel.org> <CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
 <20241002225614.774bdd0742a826557f142d0e@kernel.org>
In-Reply-To: <20241002225614.774bdd0742a826557f142d0e@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Oct 2024 07:27:16 -0700
Message-ID: <CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>, 
	Dima Kogan <dima@secretsauce.net>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 6:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Tue, 1 Oct 2024 18:31:43 -0700
> Ian Rogers <irogers@google.com> wrote:
>
> > On Tue, Oct 1, 2024 at 4:29=E2=80=AFPM Masami Hiramatsu <mhiramat@kerne=
l.org> wrote:
> > >
> > > On Tue, 1 Oct 2024 16:17:34 -0700
> > > Ian Rogers <irogers@google.com> wrote:
> > >
> > > > On Tue, Oct 1, 2024 at 4:10=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > >
> > > > > On Mon, Sep 30, 2024 at 09:02:36PM -0700, Ian Rogers wrote:
> > > > > > On Sat, Sep 28, 2024 at 7:35=E2=80=AFPM Masami Hiramatsu <mhira=
mat@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, 27 Sep 2024 11:15:21 -0700
> > > > > > > Ian Rogers <irogers@google.com> wrote:
> > > > > > >
> > > > > > > > On Fri, Sep 27, 2024 at 10:16=E2=80=AFAM Namhyung Kim <namh=
yung@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrot=
e:
> > > > > > > > > > On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <=
namhyung@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers =
wrote:
> > > > > > > > > > > > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Ki=
m <namhyung@kernel.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rog=
ers wrote:
> > > > > > > > > > > > > > The name dwarf can imply libunwind support, whe=
reas
> > > > > > > > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw=
 support. Rename to
> > > > > > > > > > > > > > make it clearer there is a libdw connection.
> > > > > > > > > > > > >
> > > > > > > > > > > > > While it only covers libdw, I think the idea of t=
his macro is whether
> > > > > > > > > > > > > the arch has register mappings defined in DWARF s=
tandard.  So I think
> > > > > > > > > > > > > it's better to keep the name for this case.
> > > > > > > > > > > >
> > > > > > > > > > > > How can the dwarf standard exist for an arch but no=
t define registers?
> > > > > > > > > > >
> > > > > > > > > > > I meant it's about the arch code in the perf tools to=
 have the mapping,
> > > > > > > > > > > not the DWARF standard itself.
> > > > > > > > > >
> > > > > > > > > > But we guard those definitions behind having libdw:
> > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/pe=
rf-tools-next.git/tree/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
> > > > > > > > > > So we only have the regs if libdw is present, not if dw=
arf is in use
> > > > > > > > > > for libunwind/libdw. Hence wanting to be specific that =
they are just a
> > > > > > > > > > libdw and not a dwarf thing. Trying to use the regs in =
libunwind code
> > > > > > > > > > would be broken. That could change but I wanted to make=
 the code clear
> > > > > > > > > > for the way things are at the moment.
> > > > > > > > >
> > > > > > > > > I understand your point but calling it LIBDW_REGS looks u=
nnatural to me.
> > > > > > > >
> > > > > > > > I don't follow. Wouldn't it be unnatural to see PERF_HAVE_D=
WARF_REGS
> > > > > > > > in libunwind code but you are to some how know that the cod=
e only had
> > > > > > > > meaning if libdw was present? I don't like the implication =
that DWARF
> > > > > > > > means LIBDW as throughout the code it doesn't. I think the =
name
> > > > > > > > PERF_HAVE_LIBDW_REGS better captures how the code is, makes=
 the code
> > > > > > > > more intention revealing and so readable, etc.
> > > > > > >
> > > > > > > I agree with Namhyung this point. dwarf-regs is defined only =
by the
> > > > > > > DWARF standard, not libdw only. The standard encode registers=
 by a digit
> > > > > > > number and the dwarf-regs decode the number to actual registe=
r name.
> > > > > >
> > > > > > The code is not making a statement about the DWARF standard, ta=
ke arch/csky:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/perf/arch/csky/Makefile?h=3Dperf-tools-next
> > > > > > ```
> > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > > ifndef NO_DWARF
> > > > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > > > endif
> > > > > > ```
> > > > > > in the patch series NO_DWARF becomes NO_LIBDW, so it is now:
> > > > > > ```
> > > > > > # SPDX-License-Identifier: GPL-2.0-only
> > > > > > ifndef NO_LIBDW
> > > > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > > > endif
> > > > > > ```
> > > > > > So the Makefile says that PERF_HAVE_DWARF_REGS is dependent on =
having
> > > > > > NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS is =
defined
> > > > > > for csky.
> > > > >
> > > > > I think this is totally fine and we can change the condition late=
r if
> > > > > needed.
> > > > >
> > > > > After all, I don't think it's a big deal.  Let's just call DWARF
> > > > > registers DWARF_REGS. :)
> > > >
> > > > The define is called PERF_HAVE_DWARF_REGS, notice the HAVE, but we'=
re
> > > > not setting it while supporting call-graph dwarf with libunwind. It=
 is
> > > > actively confusing.
> > >
> > > Does libunwind requires the dwarf regs? I think the dwarf regs inform=
ation
> > > is only needed for analyzing dwarf register assignment, not stack unw=
inding.
> >
> > So you are saying the #define is guarding a libdw feature?
> > perf record/report --call-graph=3Ddwarf is supported with either libdw
> > or libunwind. The dwarf support in the tool may come from more sources
> > hence wanting in this patch set to be clear what variable is guarding
> > what. PERF_HAVE_DWARF_REGS is set to 1 for a specific set of
> > architectures and only when libdw is present. The variable is saying
> > that libdw supports the notion of registers needed for the #define
> > HAVE_DWARF_SUPPORT that patch 9 in the series renamed to
> > HAVE_LIBDW_SUPPORT. So I want the makefile variable
> > PERF_HAVE_LIBDW_REGS to guard the #define HAVE_LIBDW_SUPPORT, rather
> > than what is being argued by yourself and Namhyung that the #define
> > HAVE_LIBDW_SUPPORT be guarded by a variable called
> > PERF_HAVE_DWARF_REGS and that is only set when NO_LIBDW isn't set.
>
> It will be only used with the libdw, but I don't care.
> "HAVE_DWARF_REG" (internal config, just indicates the arch implemented
> feature) simply means there is `arch/XXX/util/dwarf-regs.c`.
> Also the APIs provided by the dwarf-regs.c are still based on DWARF
> standard, which defines registers by number like DW_OP_reg[0-31].
> So the mapping of these suffix number and actual register must be
> defined for each architecture.
>
> That is why I had introduced dwarf-regs.c and call it "dwarf"-regs.
> Even if the implementation depends on libdw, this dwarf-regs.c is
> still based on DWARF standard.

You seem to be missing the point of the series which is to clean up
inconsistencies where dwarf is used to mean libdw. Here we have libdw
guarding a #define with DWARF in the name, it should have libdw in the
name as the patch cleans up. This is a coding thing and not a dwarf
specificatin thing.

> > We've made a digression into the name dwarf for a reason I can't
> > fathom, at best it is inconsistent. Having dwarf registers is like
> > having a bright sun or numeric numbers, it is a truism (playing devils
> > advocate maybe if there were an ELF file format for postscript we
> > could have a dwarf specification without registers). Anyway, I'm
> > trying to connect the dots that libdw support controls the libdw type
> > variables and defines hence not wanting 10 out of 11 patches applied.
>
> Oh, wait, I think we can apply other patches. I just don't like this
> patch. I think the other patches are good. But this is

Then we are intentionally aiming to be inconsistent, with libdw
meaning dwarf with a #define that just states a truism. Arguably the
code is better with none of the series applied.

Thanks,
Ian

> Thank you,
>
> >
> > Thanks,
> > Ian
> >
> > > Thank you,
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > Thanks,
> > > > > Namhyung
> > > > >
> > > > > >
> > > > > > Dwarf in the code base implies libdw, libunwind and potentially=
 other
> > > > > > dwarf capable things like llvm. If we don't have libdw then NO_=
LIBDW
> > > > > > will be set and PERF_HAVE_DWARF_REGS won't be set. That is the =
more
> > > > > > general dwarf thing will not be set because of missing libdw. T=
his
> > > > > > goes contrary to wanting this to be true whenever a dwarf thing=
 is
> > > > > > present - something that reflecting what the standard says woul=
d
> > > > > > achieve.
> > > > > >
> > > > > > In the code base right now PERF_HAVE_DWARF_REGS isn't a dwarf
> > > > > > dependent thing, it is a libdw dependent thing, this is why
> > > > > > PERF_HAVE_LIBDW_REGS is a more intention revealing name as it m=
akes
> > > > > > the connection explicit.
> > > > > >
> > > > > > We could change the code so that in Makefile.config we set some=
thing like:
> > > > > > ```
> > > > > > ...
> > > > > > ifndef NO_LIBDW
> > > > > >   PERF_HAVE_DWARF :=3D 1
> > > > > > ...
> > > > > > ```
> > > > > > and in the arch/.../Makefiles change them to be:
> > > > > > ```
> > > > > > if PERF_HAVE_DWARF
> > > > > > PERF_HAVE_DWARF_REGS :=3D 1
> > > > > > endif
> > > > > > ```
> > > > > > but this is going beyond the clean up this patch series was try=
ing to
> > > > > > achieve. I also don't know of an architecture where dwarf is pr=
esent
> > > > > > but registers are not, so having a definition for this case fee=
ls
> > > > > > redundant.
> > > > > >
> > > > > > Thanks,
> > > > > > Ian
> > > > > >
> > > > > > > Actually, there is a histrical reason I had called it is DWAR=
F. I used to
> > > > > > > use "libdwarf", and switched to "libdw" for required features=
. So I know
> > > > > > > there are more than 1 implementation of DWARF library, and th=
e libdwarf
> > > > > > > also uses the same operation number because it depends on the=
 same standard.
> > > > > > >
> > > > > > > https://github.com/davea42/libdwarf-code/blob/main/src/lib/li=
bdwarf/dwarf.h#L809
> > > > > > >
> > > > > > > So I think we'd better keep it call as DWARF_REGS.
> > > > > > >
> > > > > > > Thank you,
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Ian
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

