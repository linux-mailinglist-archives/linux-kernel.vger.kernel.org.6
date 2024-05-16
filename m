Return-Path: <linux-kernel+bounces-181429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685B8C7BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD8A282648
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51E156F20;
	Thu, 16 May 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28EGLpz6"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC71A2C07
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715882894; cv=none; b=b01D7MLrRYDgbkhRiCtFcxL0W0GlqpuNEL/H2shPYIcZ9t/TwF63XLBFiUr48fXfndXXRtvVlkjTUVW0+jV79zx3vk6TFDPzVEYXWTn42tMZs8Ed/L6uPb0tSY/2prJBLVWhoY0iBV1MpiCzCisa0jAXf1ySmIYeiIwCr3ELkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715882894; c=relaxed/simple;
	bh=1PYeOsOEm7vpaC1EVcf9o484WHJ4uE8YCtY91oEoRh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iETLDGkqTABAyd7RIYF5+56XRDTltHit4Kh+7V85kqRRc9ulSx5ALUnPJ3O7XA+jIyjPWFA+7IdyikYidB4w/adN2cDITdlkcBXqgoYefhCnV8qdLfJFN6eCLkXhooV8rWBnaRS6OVdQya5Smf5A+iS8/p0aIQZm8FidzQ+5MqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28EGLpz6; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso14355ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715882891; x=1716487691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=banjYwwSFjZLLyNlG79LTVlCiVU6mZgaJjWJacGYzYE=;
        b=28EGLpz6Zm8mGK3kKclRYRbM0SojphS0pBXjXPkp4R0LuShZLr1SZQIJavH9X8DTsU
         UiXPJIehG3IzP3LN/hsBPAAJIkKPB2ZNS23E8OihJO/yrjo18eSYXp3x0/x9VZL4t9Wd
         g4tCLVDVS6qNhWXvDh/CwXsyuk7fpibQUWEiYhsAVTM2pJFzzA1qx3OIWH6XQgbj3lXj
         AOc8+zqFqvocsRgCzPA0sIgkMu7ilEqS+Nyrnme3ugVOatipjLvc2obqDFZKdRchAyr5
         c/bxQqpQUfI7x0msI2ulekVy0R10zHJwqs3vtUDSvMb86O8Cgnxv/Fs+Il25g547XwWd
         ylRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715882891; x=1716487691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=banjYwwSFjZLLyNlG79LTVlCiVU6mZgaJjWJacGYzYE=;
        b=Fu66G8+anS9hd7WOfJxilrS+NKDGOlA5cH7eQZEbzoyf99aKDrB5qTuqwyFxUbds22
         4WTaM3ciIf+Ban5pbUVfsAsnTUyi9JeJashM0iHJPAKU6Qu9lfjUeve2qXyJTaeqr54D
         GdF4tIctgYNDPLbLgRyip2jxZJOJzK7RfIGNzX6V2Fm5LGutAX1I/pKBwQwB3a+UuMH7
         5nlouLVNrVy8wqi1/z/RHprP+eQ3ffzUJTybHNuR7mcAUGLTSZufuLvd2hBsio4k2qe8
         5t1Tkzg74hX1BwG2bI4QSoh54DsQwF5Y5/A9turO5C/piilYVAnqtNo9dXZApeDXsp5z
         idQw==
X-Forwarded-Encrypted: i=1; AJvYcCUS42Na0lE1NAJLhR+owl6ef68pw6s9aFzJuUGG/8q93wnQDbHsoz9oS28zPGOgIP6SZt3/d6Vbt9w7MveLEUCtuOoU6+yNy7MCdZ7F
X-Gm-Message-State: AOJu0YxzWckptq2MjQvA2XMXgZHeN7h8khLHchLig1SK8oj2LT7X+p++
	7Qn8SIQmPAnqcYo6mqaH8NzTXoB0fBkrFwQyWK8uYZGFGPDaNiqczItdxxa6KvFwfV0+dRHLVmK
	FVSytSNt9GMkjjfoK8tC6LT3Y5TmanxHTckc3
X-Google-Smtp-Source: AGHT+IFdvZ3jgOJZ7VBbTvmqeWETZkMMd3CoC8nAvDAggJiX6cBxB+u2qSMoe9sge52FgrlwMwWcmvt9llmJt40/zg0=
X-Received: by 2002:a05:6e02:1092:b0:36c:35c9:4b34 with SMTP id
 e9e14a558f8ab-36dc6d02131mr64695ab.25.1715882891095; Thu, 16 May 2024
 11:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com>
 <20240515054443.2824147-6-weilin.wang@intel.com> <CAP-5=fVjpGKbQjadD0Wz11fw3OvkdTkj+YVgkgzNojnR4EpHiQ@mail.gmail.com>
 <CO6PR11MB563541C3F37628965690DB57EEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB563541C3F37628965690DB57EEED2@CO6PR11MB5635.namprd11.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 11:08:00 -0700
Message-ID: <CAP-5=fUNW7UPikK-AfhSRKf3Pb0MiJ=G7qvZVDU0AYpqoKk15A@mail.gmail.com>
Subject: Re: [RFC PATCH v8 5/7] perf stat: Add retire latency print functions
 to print out at the very end of print out
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:52=E2=80=AFAM Wang, Weilin <weilin.wang@intel.co=
m> wrote:
>
>
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Thursday, May 16, 2024 9:47 AM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hun=
ter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>=
;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor,=
 Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Bigge=
rs,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v8 5/7] perf stat: Add retire latency print fun=
ctions to
> > print out at the very end of print out
> >
> > On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Add print out functions so that users could read retire latency value=
s.
> > >
> > > Example output:
> > >
> > >  Performance counter stats for 'system wide':
> > >
> > >             25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %
> > tma_split_stores
> > >         28,365,080      CPU_CLK_UNHALTED.THREAD
> > >              24.00      MEM_INST_RETIRED.SPLIT_STORES:R  #       96  =
      4
> > >
> > >        2.054365083 seconds time elapsed
> > >
> > > This output of retire latency data is in format:
> > >  <val> <event-name:R> # <sum> <count>.
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > My usual complaint that I hate the stat-display spaghetti code. We
> > keep putting more spaghetti on the plate and this change does this
> > too. In the evsel approach:
> > https://lore.kernel.org/lkml/20240428053616.1125891-1-
> > irogers@google.com/
> > retirement latency events just update the counts for the event and so
> > we don't need to special case tpebs events like this. I'd prefer we
> > went that route. My reviewed-by no longer stands.
> >
> Based on the current stat-display code and the original TPEBS counting
> code, I believe the code in this commit and last commit was the best way =
to
> do the metric calculation and printout.
>
> But I totally agree with you that if we could get evsel with retire laten=
cy work,
> this code is not necessary.
>
> I was thinking to plugin the retire latency value into evsel so that I co=
uld delete
> this and last commit. Do you think that would be a solution?

Yep, I think that'd be good.

Thanks,
Ian

> Thanks,
> Weilin
>
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/util/stat-display.c | 69
> > ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 69 insertions(+)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-di=
splay.c
> > > index bfc1d705f437..b9c3978cc99c 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -21,6 +21,7 @@
> > >  #include "iostat.h"
> > >  #include "pmu.h"
> > >  #include "pmus.h"
> > > +#include "intel-tpebs.h"
> > >
> > >  #define CNTR_NOT_SUPPORTED     "<not supported>"
> > >  #define CNTR_NOT_COUNTED       "<not counted>"
> > > @@ -34,6 +35,7 @@
> > >  #define COMM_LEN     16
> > >  #define PID_LEN       7
> > >  #define CPUS_LEN      4
> > > +#define RETIRE_LEN    8
> > >
> > >  static int aggr_header_lens[] =3D {
> > >         [AGGR_CORE]     =3D 18,
> > > @@ -426,6 +428,71 @@ static void print_metric_std(struct
> > perf_stat_config *config,
> > >         fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
> > >  }
> > >
> > > +static void print_retire_lat_std(struct perf_stat_config *config,
> > > +                                struct outstate *os)
> > > +{
> > > +       FILE *out =3D os->fh;
> > > +       bool newline =3D os->newline;
> > > +       struct tpebs_retire_lat *t;
> > > +       struct list_head *retire_lats =3D &config->tpebs_results;
> > > +
> > > +       list_for_each_entry(t, retire_lats, nd) {
> > > +               if (newline)
> > > +                       do_new_line_std(config, os);
> > > +               fprintf(out, "%'*.2f ", COUNTS_LEN, t->val);
> > > +               /* For print alignment */
> > > +               fprintf(out, "%-*s ", config->unit_width, "");
> > > +               fprintf(out, "%-*s", EVNAME_LEN, t->tpebs_name);
> > > +               fprintf(out, " # ");
> > > +               fprintf(out, "%*d %*ld\n", RETIRE_LEN, t->sum,
> > > +                        RETIRE_LEN, t->count);
> > > +       }
> > > +}
> > > +
> > > +static void print_retire_lat_csv(struct perf_stat_config *config,
> > > +                                struct outstate *os)
> > > +{
> > > +       FILE *out =3D os->fh;
> > > +       struct tpebs_retire_lat *t;
> > > +       struct list_head *retire_lats =3D &config->tpebs_results;
> > > +       const char *sep =3D config->csv_sep;
> > > +
> > > +       list_for_each_entry(t, retire_lats, nd) {
> > > +               fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep,=
 t-
> > >tpebs_name, sep,
> > > +                       t->count, sep, t->sum);
> > > +       }
> > > +}
> > > +
> > > +static void print_retire_lat_json(struct perf_stat_config *config,
> > > +                                 struct outstate *os)
> > > +{
> > > +       FILE *out =3D os->fh;
> > > +       struct tpebs_retire_lat *t;
> > > +       struct list_head *retire_lats =3D &config->tpebs_results;
> > > +
> > > +       fprintf(out, "{");
> > > +       list_for_each_entry(t, retire_lats, nd) {
> > > +               fprintf(out, "\"retire_latency-value\" : \"%f\", ", t=
->val);
> > > +               fprintf(out, "\"name\" : \"%s\"", t->tpebs_name);
> > > +               fprintf(out, "\"sample-counts\" : \"%ld\"", t->count)=
;
> > > +               fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->su=
m);
> > > +       }
> > > +       fprintf(out, "}");
> > > +}
> > > +
> > > +static void print_retire_lat(struct perf_stat_config *config,
> > > +                            struct outstate *os)
> > > +{
> > > +       if (!&config->tpebs_results)
> > > +               return;
> > > +       if (config->json_output)
> > > +               print_retire_lat_json(config, os);
> > > +       else if (config->csv_output)
> > > +               print_retire_lat_csv(config, os);
> > > +       else
> > > +               print_retire_lat_std(config, os);
> > > +}
> > > +
> > >  static void new_line_csv(struct perf_stat_config *config, void *ctx)
> > >  {
> > >         struct outstate *os =3D ctx;
> > > @@ -1609,6 +1676,8 @@ void evlist__print_counters(struct evlist *evli=
st,
> > struct perf_stat_config *conf
> > >                 break;
> > >         }
> > >
> > > +       print_retire_lat(config, &os);
> > > +
> > >         print_footer(config);
> > >
> > >         fflush(config->output);
> > > --
> > > 2.43.0
> > >

