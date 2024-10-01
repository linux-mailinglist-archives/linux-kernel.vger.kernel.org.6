Return-Path: <linux-kernel+bounces-346822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAE998C964
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673011F215CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEC91CCECF;
	Tue,  1 Oct 2024 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOwvmStg"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740BB158218
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824673; cv=none; b=kUUQ3DjOthEC7l9TXTITmyvuQUvLLH1RhH+sqaQE05oeoOY13iWBW9j2DXxMux58UjJqGp6awtgt/DT94CAMzXW96ZISV9AaIXTgMJHyJtCB34LTDos1iIAPczUYqMkL+YnV80lkKzO/UuC/HJwwGl82DbowrwgcRUoR3NanvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824673; c=relaxed/simple;
	bh=MF3wDqfcasoCBjE6rB3qGrtU06d8dqXLzaFojnxRH2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eusGLcEVGNGcnsQj+4BnSwuQM3UKH6euEi8D8v6AqG2CKwGM1Tf5bw06s/DOqBNmepB07ZP3AxqD3iQ68Fj/F8+zXoAibXwCSPjZgQG+uTGDTiqbxrC+rUhJyqxVKkajVB8Rtf57vL8ZpbWvVJ3nxlzLKxBaHFqxhy0r2kQ67tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOwvmStg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b061b7299so41805ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727824671; x=1728429471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNOLU3VDj1YkezjrrheNRuAulfgIdYn4iaCyreRT3qc=;
        b=yOwvmStgGNL+Hj7YWpOBEN810ydcDnpBEM6WUxejvfZoSlTSL8DKFyC86PriF9qACc
         KAz95spBJLfbaLvnZR0t9M9l1z442f0qib0ayqh9bJUssGqNG51iGPXQ3IRqgzgL0NWg
         L+iUpXjsVgKk8Dlj9FxJQpCOyCyaX/Y6Ae4FSZkm42PXLsuUDGkqxrtjdByIQCQnxtrE
         0HV1pl4K8sCOs4k96GYuIO94YC3HDJkXEGosg+hGnRM3hNQMQdEez9MiArxu6bxz15RM
         IHAHZgC+/soEXHc06ZK8StON2F6K9krunE2Q3C/vxRbpIiLqddfvixnh5xDL/5jFivgi
         8Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727824671; x=1728429471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNOLU3VDj1YkezjrrheNRuAulfgIdYn4iaCyreRT3qc=;
        b=OiUh7HsU0dRehPfj4h6hKdGEh6VnAKAMDxcLHlF9UbtDq/wB8R3cPRAUlL66PsHBTR
         vEhbmZDmk5gWjXI0C78jimNqH0mQL08BPoJ7setgb4UY6112WvOnP1Z/aN7qqRVaj/BM
         hfwF2GZO/g19N/8Te2ZefzfQIB3tggRraRXJk3HMnHvaEHPKfiPSpmg37ERqPTvbYeh2
         a6LIbIXprtucxVFSWkZ3WigyqgfRtKzl6wtmR5DZ+ocZPuX2pibmdFCScvHAJcAboOG/
         /vpbwv1bkBA1kYwsN/rRqdJRbmPuNpJbsyLrLdcLjoXJtPTMjIcSAPIf/+VsreavQ1VL
         wwfw==
X-Forwarded-Encrypted: i=1; AJvYcCVR1i8mgx5Vdz1nKrRYdyQARj/aPJnBNo6pZxuBna6hvv32CpqL5BGveF7Y78q4F8CvFcubIYXuBOOBLeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvJv/r+zSBms8hahR3m+zX773EzQrOnMXlZHxsKrTXCIuxt1E
	q9NVQ5TmV/fbB5Lb/U2ued+pRhtK82jLY+1eax6tXNd2cKSFHsWTXhNJ2m/kBWXhBv5ZWSRPw/A
	c8WPhGPiyVfS3W6uz73afIjK5mv6oVPlJnK7Y
X-Google-Smtp-Source: AGHT+IEjwNxctrOrJnXgsMBwB+LCTDZRZ2kfFv7KGj5oagaGJA+tA/zEe2pKx8m6v/JytaZARxl4565z5nNbY0GtFp8=
X-Received: by 2002:a17:902:e887:b0:20b:9c9c:6f0c with SMTP id
 d9443c01a7336-20bca362066mr577415ad.11.1727824670621; Tue, 01 Oct 2024
 16:17:50 -0700 (PDT)
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
 <ZvyBQ6xgGE4gZdoo@google.com>
In-Reply-To: <ZvyBQ6xgGE4gZdoo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 1 Oct 2024 16:17:34 -0700
Message-ID: <CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS
To: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
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

On Tue, Oct 1, 2024 at 4:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Sep 30, 2024 at 09:02:36PM -0700, Ian Rogers wrote:
> > On Sat, Sep 28, 2024 at 7:35=E2=80=AFPM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Fri, 27 Sep 2024 11:15:21 -0700
> > > Ian Rogers <irogers@google.com> wrote:
> > >
> > > > On Fri, Sep 27, 2024 at 10:16=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > >
> > > > > On Thu, Sep 26, 2024 at 12:55:18PM -0700, Ian Rogers wrote:
> > > > > > On Thu, Sep 26, 2024 at 12:40=E2=80=AFPM Namhyung Kim <namhyung=
@kernel.org> wrote:
> > > > > > >
> > > > > > > On Thu, Sep 26, 2024 at 05:47:16AM -0700, Ian Rogers wrote:
> > > > > > > > On Wed, Sep 25, 2024 at 8:27=E2=80=AFPM Namhyung Kim <namhy=
ung@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Sep 24, 2024 at 09:04:18AM -0700, Ian Rogers wrot=
e:
> > > > > > > > > > The name dwarf can imply libunwind support, whereas
> > > > > > > > > > PERF_HAVE_DWARF_REGS is only enabled with libdw support=
. Rename to
> > > > > > > > > > make it clearer there is a libdw connection.
> > > > > > > > >
> > > > > > > > > While it only covers libdw, I think the idea of this macr=
o is whether
> > > > > > > > > the arch has register mappings defined in DWARF standard.=
  So I think
> > > > > > > > > it's better to keep the name for this case.
> > > > > > > >
> > > > > > > > How can the dwarf standard exist for an arch but not define=
 registers?
> > > > > > >
> > > > > > > I meant it's about the arch code in the perf tools to have th=
e mapping,
> > > > > > > not the DWARF standard itself.
> > > > > >
> > > > > > But we guard those definitions behind having libdw:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/perf/arch/x86/Makefile?h=3Dperf-tools-next#n3
> > > > > > So we only have the regs if libdw is present, not if dwarf is i=
n use
> > > > > > for libunwind/libdw. Hence wanting to be specific that they are=
 just a
> > > > > > libdw and not a dwarf thing. Trying to use the regs in libunwin=
d code
> > > > > > would be broken. That could change but I wanted to make the cod=
e clear
> > > > > > for the way things are at the moment.
> > > > >
> > > > > I understand your point but calling it LIBDW_REGS looks unnatural=
 to me.
> > > >
> > > > I don't follow. Wouldn't it be unnatural to see PERF_HAVE_DWARF_REG=
S
> > > > in libunwind code but you are to some how know that the code only h=
ad
> > > > meaning if libdw was present? I don't like the implication that DWA=
RF
> > > > means LIBDW as throughout the code it doesn't. I think the name
> > > > PERF_HAVE_LIBDW_REGS better captures how the code is, makes the cod=
e
> > > > more intention revealing and so readable, etc.
> > >
> > > I agree with Namhyung this point. dwarf-regs is defined only by the
> > > DWARF standard, not libdw only. The standard encode registers by a di=
git
> > > number and the dwarf-regs decode the number to actual register name.
> >
> > The code is not making a statement about the DWARF standard, take arch/=
csky:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/csky/Makefile?h=3Dperf-tools-next
> > ```
> > # SPDX-License-Identifier: GPL-2.0-only
> > ifndef NO_DWARF
> > PERF_HAVE_DWARF_REGS :=3D 1
> > endif
> > ```
> > in the patch series NO_DWARF becomes NO_LIBDW, so it is now:
> > ```
> > # SPDX-License-Identifier: GPL-2.0-only
> > ifndef NO_LIBDW
> > PERF_HAVE_DWARF_REGS :=3D 1
> > endif
> > ```
> > So the Makefile says that PERF_HAVE_DWARF_REGS is dependent on having
> > NO_LIBDW, that is having libdw implies PERF_HAVE_DWARF_REGS is defined
> > for csky.
>
> I think this is totally fine and we can change the condition later if
> needed.
>
> After all, I don't think it's a big deal.  Let's just call DWARF
> registers DWARF_REGS. :)

The define is called PERF_HAVE_DWARF_REGS, notice the HAVE, but we're
not setting it while supporting call-graph dwarf with libunwind. It is
actively confusing.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Dwarf in the code base implies libdw, libunwind and potentially other
> > dwarf capable things like llvm. If we don't have libdw then NO_LIBDW
> > will be set and PERF_HAVE_DWARF_REGS won't be set. That is the more
> > general dwarf thing will not be set because of missing libdw. This
> > goes contrary to wanting this to be true whenever a dwarf thing is
> > present - something that reflecting what the standard says would
> > achieve.
> >
> > In the code base right now PERF_HAVE_DWARF_REGS isn't a dwarf
> > dependent thing, it is a libdw dependent thing, this is why
> > PERF_HAVE_LIBDW_REGS is a more intention revealing name as it makes
> > the connection explicit.
> >
> > We could change the code so that in Makefile.config we set something li=
ke:
> > ```
> > ...
> > ifndef NO_LIBDW
> >   PERF_HAVE_DWARF :=3D 1
> > ...
> > ```
> > and in the arch/.../Makefiles change them to be:
> > ```
> > if PERF_HAVE_DWARF
> > PERF_HAVE_DWARF_REGS :=3D 1
> > endif
> > ```
> > but this is going beyond the clean up this patch series was trying to
> > achieve. I also don't know of an architecture where dwarf is present
> > but registers are not, so having a definition for this case feels
> > redundant.
> >
> > Thanks,
> > Ian
> >
> > > Actually, there is a histrical reason I had called it is DWARF. I use=
d to
> > > use "libdwarf", and switched to "libdw" for required features. So I k=
now
> > > there are more than 1 implementation of DWARF library, and the libdwa=
rf
> > > also uses the same operation number because it depends on the same st=
andard.
> > >
> > > https://github.com/davea42/libdwarf-code/blob/main/src/lib/libdwarf/d=
warf.h#L809
> > >
> > > So I think we'd better keep it call as DWARF_REGS.
> > >
> > > Thank you,
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>

