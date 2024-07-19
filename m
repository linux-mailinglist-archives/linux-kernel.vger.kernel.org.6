Return-Path: <linux-kernel+bounces-257507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64D4937AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A691C21BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764C145FF8;
	Fri, 19 Jul 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1koL8bui"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D382AF12
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406433; cv=none; b=mIajmU1VCoHByeJpCOAdq2KozLjrA6SyW+6zV5MYSeZx4oDPo7EBSCkfsyfl4d2o4nd0lk3yWg1SBiTGEah0xhhXwnfq/gMO8+3jN4bksYH8NyKwiwDaFCOA2VhyISZm8pD7b558RS/Jqv/4ggJXzOOutZXP/I3y9voJjW5OHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406433; c=relaxed/simple;
	bh=m2aM53fm27lA32LwBy5iWSU1nF4LxUPw4rbtQFNM1L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7aZ/MxNGonLp152Mt5YP+Dr9BS/OKJrbljDMhRRaGDZMBRJ0sxDcn09jsDB1jHkrJu/PvYdB5CBu+3nsFJXb2ZKXZS+JfC5p+TvL3iAnnnhjyuLHG+cw2MPk3bQlbPLJlf4renSMKkJLYkRZyFfaqs5kwYc/f3r5Puonpf1rc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1koL8bui; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447df43324fso295821cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721406430; x=1722011230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiKuobD2rP+NXtg4SKM8b2LYl4bgynuBKbFXO+lpKMw=;
        b=1koL8buiNRH6wIbGSVR+9nZRDJoEuYdeOVjSs/Uhs++19NVLFwcj6AR+WUXp4Zm7Sx
         m7jf7B1Udqp3aZNy5cGoCjgFodL4/TU3KYzz+jqr56pymMM2btQ8nJA96jKYcUXCI1ve
         HmlkS0f/5OpMkBk31vK2X+T2OWXf6C8lR4F0ABRzJ7TltggBIo2lkJEvGStqgDdUaooJ
         xzY6VWfmqsU4KEEvmt62fG844skXWkJA4I6w3HZJvNMG3f7RDa+XvdLyQm4QKUNZMKpv
         LvNweyKNAhdDT4pOfG3QoGoIs8+ximZBzCJ3RMfgUFNLvKwinDcvxNoUnC9/QEjTTAv3
         Aewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721406430; x=1722011230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiKuobD2rP+NXtg4SKM8b2LYl4bgynuBKbFXO+lpKMw=;
        b=tNfBsNMWQuLFnZn+VkyYmz5DPEFDPeZWuMxEF0mUXZ5Zp6v6BGctiT201EFF0L2JpE
         AH4+g4QOQqpDke+3lpYV5UJTKZkXo4Fmtd5368+PWTmPCSZo0ujxvsWNOsgs8urdBg5X
         6kBnCR4Jd3B+z4J7/zy/TT4r6Y2wHQmh+8dOaRQIbeltHD4mDuqPli4AMaRaSLpXu8fz
         fb1DsWTx5BRZ8SW5s1S4tr7X9uOXJfOc7z2VjVoFUrKMJ9Q0KCbV5+ZJw38JoIq2GzQr
         yWeWNDC+TUbQl1SbQCZTHqoywCfDKSmDzxxNVm+ngJYWhp3IuLivN6hCg3RE6e6/4wxk
         oWbg==
X-Forwarded-Encrypted: i=1; AJvYcCWEINanU6JpKYBf7Pd3nHEvcGjcct2HMIGIys5JYephyMyMToPfdcor2YPY0rofh9FCmHgxERJCiSkq8zCVd8klyI58FlH2BsI+E4wZ
X-Gm-Message-State: AOJu0YwnsPE+lY9K16p0H2V/LUU7Dgh6ouJL3yT8u34nXTO5ln1FHA9U
	FbS1EJ10owLz+kq5ERTQldzii9p3izUdiMZBVnMi88v/QnRlKHuPkPdgx8bGwmokMSawEPz6x/u
	NLNKMiPFaZiFgFwwDaCsJQXwQ3E4qR0rKFBC9
X-Google-Smtp-Source: AGHT+IH9VcIgzBWJZPwNwwLxKQYf5hoY6mDn7bVCUkRI7OGMkaQskznabHXaUw6wExwYX+4Yjh2UAXQeRYipltEX7zY=
X-Received: by 2002:a05:622a:1388:b0:447:e5df:e1be with SMTP id
 d75a77b69052e-44f9ac82229mr3960411cf.8.1721406430075; Fri, 19 Jul 2024
 09:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com> <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
In-Reply-To: <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Jul 2024 09:26:57 -0700
Message-ID: <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] Constify tool pointers
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 1:51=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/07/24 03:59, Ian Rogers wrote:
> > struct perf_tool provides a set of function pointers that are called
> > through when processing perf data. To make filling the pointers less
> > cumbersome, if they are NULL perf_tools__fill_defaults will add
> > default do nothing implementations.
> >
> > This change refactors struct perf_tool to have an init function that
> > provides the default implementation. The special use of NULL and
> > perf_tools__fill_defaults are removed. As a consequence the tool
> > pointers can then all be made const, which better reflects the
> > behavior a particular perf command would expect of the tool and to
> > some extent can reduce the cognitive load on someone working on a
> > command.
> >
> > v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
>
> The tags were really meant only for patch 1, the email that was replied t=
o.
>
> But now for patches 2 and 3:
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Sorry for that, you'd mentioned that pt and bts testing which is
impacted by more than just patch 1.

> Looking at patches 4 to 25, they do not seem to offer any benefit.
>
> Instead of patch 26, presumably perf_tool__fill_defaults() could
> be moved to __perf_session__new(), which perhaps would allow
> patch 27 as it is.

What I'm trying to do in the series is make it so that the tool isn't
mutated during its use by session. Ideally we'd be passing a const
tool to session_new, that's not possible because there's a hack to fix
ordered events and pipe mode in session__new:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/session.c?h=3Dperf-tools-next#n275
Imo, it isn't great to pass a tool to session__new where you say you
want ordered events and then session just goes to change that for you.
Altering that behavior was beyond the scope of this clean up, so tool
is only const after session__new.

The reason for doing this is to make it so that when I have a tool I
can reason that nobody is doing things to change it under my feet. My
builtin_cmd is in charge of what the tool is rather than some code
buried in util that thought it was going to do me a favor. The code is
a refactor and so the benefit is intended to be for the developer and
how they reason about the use of tool. We generally use _init
functions rather than having _fill_defaults, so there is a consistency
argument. I don't expect any impact in terms of performance... Moving
perf_tool__fill_defaults to __perf_session__new had issues with the
existing code where NULL would be written over a function pointer
expecting the later fill_defaults to fix it up, doesn't address coding
consistency where _init is the norm, and adds another reason the tool
passed to session__new can't be const.

Thanks,
Ian

> > v5: Rebase dropping asan fix merged by Namhyung.
> > v4: Simplify perf_session__deliver_synth_attr_event following Adrian's
> >     suggestions.
> > v3: Just remove auxtrace dummy tools [Adrian] and make s390-cpumsf
> >     struct removal its own patch [Adrian].
> > v2: Remove dummy tool initialization [Adrian] and make zero sized. Add
> >     cs-etm fix for address sanitizer build, found necessary when
> >     testing dummy tool change.
> >
> > Ian Rogers (27):
> >   perf auxtrace: Remove dummy tools
> >   perf s390-cpumsf: Remove unused struct
> >   perf tool: Constify tool pointers
> >   perf tool: Move fill defaults into tool.c
> >   perf tool: Add perf_tool__init
> >   perf kmem: Use perf_tool__init
> >   perf buildid-list: Use perf_tool__init
> >   perf kvm: Use perf_tool__init
> >   perf lock: Use perf_tool__init
> >   perf evlist: Use perf_tool__init
> >   perf record: Use perf_tool__init
> >   perf c2c: Use perf_tool__init
> >   perf script: Use perf_tool__init
> >   perf inject: Use perf_tool__init
> >   perf report: Use perf_tool__init
> >   perf stat: Use perf_tool__init
> >   perf annotate: Use perf_tool__init
> >   perf sched: Use perf_tool__init
> >   perf mem: Use perf_tool__init
> >   perf timechart: Use perf_tool__init
> >   perf diff: Use perf_tool__init
> >   perf data convert json: Use perf_tool__init
> >   perf data convert ctf: Use perf_tool__init
> >   perf test event_update: Ensure tools is initialized
> >   perf kwork: Use perf_tool__init
> >   perf tool: Remove perf_tool__fill_defaults
> >   perf session: Constify tool
> >
> >  tools/perf/arch/x86/util/event.c    |   4 +-
> >  tools/perf/bench/synthesize.c       |   2 +-
> >  tools/perf/builtin-annotate.c       |  44 ++--
> >  tools/perf/builtin-buildid-list.c   |  10 +
> >  tools/perf/builtin-c2c.c            |  33 ++-
> >  tools/perf/builtin-diff.c           |  30 ++-
> >  tools/perf/builtin-evlist.c         |  10 +-
> >  tools/perf/builtin-inject.c         | 159 ++++++------
> >  tools/perf/builtin-kmem.c           |  20 +-
> >  tools/perf/builtin-kvm.c            |  19 +-
> >  tools/perf/builtin-kwork.c          |  33 ++-
> >  tools/perf/builtin-lock.c           |  41 ++--
> >  tools/perf/builtin-mem.c            |  37 +--
> >  tools/perf/builtin-record.c         |  47 ++--
> >  tools/perf/builtin-report.c         |  67 +++--
> >  tools/perf/builtin-sched.c          |  50 ++--
> >  tools/perf/builtin-script.c         | 106 ++++----
> >  tools/perf/builtin-stat.c           |  26 +-
> >  tools/perf/builtin-timechart.c      |  25 +-
> >  tools/perf/builtin-top.c            |   2 +-
> >  tools/perf/builtin-trace.c          |   4 +-
> >  tools/perf/tests/cpumap.c           |   6 +-
> >  tools/perf/tests/dlfilter-test.c    |   2 +-
> >  tools/perf/tests/dwarf-unwind.c     |   2 +-
> >  tools/perf/tests/event_update.c     |   9 +-
> >  tools/perf/tests/stat.c             |   6 +-
> >  tools/perf/tests/thread-map.c       |   2 +-
> >  tools/perf/util/Build               |   1 +
> >  tools/perf/util/arm-spe.c           |  55 +----
> >  tools/perf/util/auxtrace.c          |  12 +-
> >  tools/perf/util/auxtrace.h          |  20 +-
> >  tools/perf/util/bpf-event.c         |   4 +-
> >  tools/perf/util/build-id.c          |  34 +--
> >  tools/perf/util/build-id.h          |   8 +-
> >  tools/perf/util/cs-etm.c            |  39 +--
> >  tools/perf/util/data-convert-bt.c   |  34 ++-
> >  tools/perf/util/data-convert-json.c |  47 ++--
> >  tools/perf/util/event.c             |  54 ++--
> >  tools/perf/util/event.h             |  38 +--
> >  tools/perf/util/header.c            |   6 +-
> >  tools/perf/util/header.h            |   4 +-
> >  tools/perf/util/hisi-ptt.c          |   6 +-
> >  tools/perf/util/intel-bts.c         |  37 +--
> >  tools/perf/util/intel-pt.c          |  30 +--
> >  tools/perf/util/jitdump.c           |   4 +-
> >  tools/perf/util/s390-cpumsf.c       |  11 +-
> >  tools/perf/util/session.c           | 366 +++-------------------------
> >  tools/perf/util/session.h           |   9 +-
> >  tools/perf/util/synthetic-events.c  |  80 +++---
> >  tools/perf/util/synthetic-events.h  |  70 +++---
> >  tools/perf/util/tool.c              | 294 ++++++++++++++++++++++
> >  tools/perf/util/tool.h              |  18 +-
> >  tools/perf/util/tsc.c               |   2 +-
> >  53 files changed, 977 insertions(+), 1102 deletions(-)
> >  create mode 100644 tools/perf/util/tool.c
> >
>

