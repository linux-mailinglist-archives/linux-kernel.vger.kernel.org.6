Return-Path: <linux-kernel+bounces-262810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5079B93CD03
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D731C212D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6524205;
	Fri, 26 Jul 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3GT0hoY"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134F2B9BB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964741; cv=none; b=qGYaq+9Ez/1mtZozVopbQb5g4upmTGWpjWGALQ4LZMbyzK7Kt65HSvpEVqzobiBXvBfiFRX0X+KaQ7Jk/fR8Mn1knFVhWeYwnPmGH7XV7v2Yte4R0ihZfYQe2rnExJTVj9P1n/egUuYiE4MpR/UoRZ0U8HLVkOO7VFan/b5DQEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964741; c=relaxed/simple;
	bh=0x8tCL663Ar5mCUNsCZ1b7F085Q9qbGwie+8kV3y+9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrdsQ9YuyMOtr0Hsty7j3FXCJCwlfWda2aBSFVjKx8kw7yjXrmtuZsh8n4MhZYKcPQHY4G8cNltWisC6A6h4RqaL/v81VmUMX5B9K9MANCZStCO8thZUjgvlKQ1Da6RHiY5EuJsn9/e+ltN30r8/qFxT+0Muo79S5YTq1MZRv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H3GT0hoY; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39a16fab332so71725ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721964739; x=1722569539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5AYzr5FQ2RGEorLl0P2oV0jHsPQmy6VocOaP+XCGBo=;
        b=H3GT0hoYQzFOrAQ9Jz8zfZrGVUMON8TTEIFkKg5Yy6BSRwjuuPmTz9ghh3yu30f3Ms
         T2BrjgsZtaZQMMBBuBms87PZqGGU6jGZXvLftMfGZ/MGhLeqqWU2W6FzUaoZQuZMFupH
         Mymzsepbya1pkuvL0HduAEAsY3QS0nBxOvJMq+h0Q+2vXTdaNM/vo0ogFOVKiD44wZWc
         /3vVn9RGayJAeOHS1uM3hs6wBzTzww3sdXL2CYZvNV+hgRkrUvHnu9oCZPAvRrzsVN4g
         m6I1oax52E4qbdO87tje/Dlp5AlQ6R29AvonzHMIKScPtoKXL532kecQO2zJfQTMzx5f
         G0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721964739; x=1722569539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5AYzr5FQ2RGEorLl0P2oV0jHsPQmy6VocOaP+XCGBo=;
        b=oRJAlzyZhT6XIcfOuq2TXCXEEcI5KG3LFt5Nmomr6sKVpmROEcsChlxlreJshqTNkW
         dzwTyiMPdYTcdk19RsDzMbDfLTQ/02TrKq17bDhGCmMOyMaa2X5ap0YOYplb35NbGNWI
         Npx9jGFdSzMtq8QH+y01ICdfTGLdnGUuD7gt5nL8y6NNiq0TymkUlGCRiybwMGrhZhh9
         pZDyKEkDwFhXeRIs2onbDxxsEiIM4SFR7wZMmY4ZztTX+o71/KFHOkKWXCtmSX7lXFkW
         k/+H0op0b1ixZlgFi0lrMbqnbPBnQJ4hZ8O3JC5E38Oo39mypLRLi+UE6mXYtBS/shBO
         fMWA==
X-Forwarded-Encrypted: i=1; AJvYcCWBcTjC7bCtStOmkUZi1y+zdNi2y8aaijuJEfU5oh3snfBtUXUekt32h0KlbKCqOiWXMWzkKHTTdTxRuZK+5uTQ7okvjRH2tqMsGio1
X-Gm-Message-State: AOJu0Yw0FUjqbYtvrBQKTsqWRheiXFjGpZqJBRFuUYhOoFxvwKGh9XdX
	BVkBVwHUC4K0UqZFcOczRoHiWxEjaaz9B5Y5uzBUZQufwSMmTjh+EBX1hC/3xqv6K8QjxeDdt4w
	uzczw20ZnIrIRun+yZLWlUtfLVnAYtatjrC+s
X-Google-Smtp-Source: AGHT+IFj7vOyqnulxbIaYVfAwp9eBqyRi+d1HDhkDWN38qAycZrW7ndP+GqEiXTNZvY7wAUacvgBg+mX0zel2vRof6w=
X-Received: by 2002:a05:6e02:12e8:b0:375:edce:baf0 with SMTP id
 e9e14a558f8ab-39a2b4b38d9mr1534935ab.9.1721964738242; Thu, 25 Jul 2024
 20:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720074552.1915993-1-irogers@google.com> <20240720074552.1915993-2-irogers@google.com>
 <ZqLoYL-kAVO-tCbo@google.com>
In-Reply-To: <ZqLoYL-kAVO-tCbo@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 25 Jul 2024 20:32:06 -0700
Message-ID: <CAP-5=fW94VQKRn2OdtmjXRTpeUqW9b-+Hx2SLEf887skUYqZ3g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Sat, Jul 20, 2024 at 12:45:52AM -0700, Ian Rogers wrote:
> > Andi Kleen reported a regression where `perf script +F metric` would
> > crash. With this change the output is:
> >
> > ```
> > $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
> >
> >       21.229620 GB/sec
> >
> >       15.751008 GB/sec
> >
> >       16.009221 GB/sec
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
> > $ perf --no-pager script -F +metric
> >             perf 1912464 [000] 814503.473101:       6325       cycles: =
 ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
> >             perf 1912464 [000] 814503.473101:   metric:    0.06  insn p=
er cycle
> >             perf 1912464 [000] 814503.473101:        351 instructions: =
 ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
> >             perf 1912464 [000] 814503.473101:   metric:    0.03  insn p=
er cycle
> > ...
> > ```
> >
> > The change fixes perf script to update counts and thereby aggregate
> > values which then get consumed by unchanged metric logic in the shadow
> > stat output. Note, it would be preferential to switch to json metrics.
> >
> > Reported-by: Andi Kleen <ak@linux.intel.com>
> > Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378=
-1-ak@linux.intel.com/
> > Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than save=
d_value")'
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > The code isn't well tested nor does it support non-leader sampling
> > reading of counts based on periods that seemed to present in the
> > previous code. Sending out for the sake of discussion. Andi's changes
> > added a test and that should certainly be added.
>
> You don't need to handle leader sampling specially since it's already
> done by evlist__deliver_sample().  It will call tool->sample() for each
> event (with sample->period is set) when leader sampling is enabled.

Right, but you need to synthesize a count value then rather than just
use the count from the group. Counts always increase while periods may
decrease. If you add a period to a count, what about overflow? Sounds
ripe for ubsan failures.

> > ---
> >  tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
> >  1 file changed, 93 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index c16224b1fef3..752d6219fb08 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -63,6 +63,7 @@
> >  #include "util/util.h"
> >  #include "util/cgroup.h"
> >  #include "perf.h"
> > +#include <internal/threadmap.h>
> >
> >  #include <linux/ctype.h>
> >  #ifdef HAVE_LIBTRACEEVENT
> > @@ -334,16 +335,8 @@ struct evsel_script {
> >         char *filename;
> >         FILE *fp;
> >         u64  samples;
> > -       /* For metric output */
> > -       u64  val;
> > -       int  gnum;
> >  };
> >
> > -static inline struct evsel_script *evsel_script(struct evsel *evsel)
> > -{
> > -     return (struct evsel_script *)evsel->priv;
> > -}
> > -
> >  static struct evsel_script *evsel_script__new(struct evsel *evsel, str=
uct perf_data *data)
> >  {
> >       struct evsel_script *es =3D zalloc(sizeof(*es));
> > @@ -2107,6 +2100,12 @@ static void script_new_line(struct perf_stat_con=
fig *config __maybe_unused,
> >       fputs("\tmetric: ", mctx->fp);
> >  }
> >
> > +static struct aggr_cpu_id perf_script__get_cpu(struct perf_stat_config=
 *config __maybe_unused,
> > +                                     struct perf_cpu cpu)
> > +{
> > +     return aggr_cpu_id__cpu(cpu, /*data=3D*/NULL);
> > +}
> > +
> >  static void perf_sample__fprint_metric(struct perf_script *script,
> >                                      struct thread *thread,
> >                                      struct evsel *evsel,
> > @@ -2126,23 +2125,96 @@ static void perf_sample__fprint_metric(struct p=
erf_script *script,
> >               .force_header =3D false,
> >       };
> >       struct evsel *ev2;
> > -     u64 val;
> > +     struct perf_cpu sample_cpu =3D { .cpu =3D sample->cpu, };
> > +     int thread_idx, cpu_map_idx;
> > +     u64 read_format =3D evsel->core.attr.read_format;
> > +     int aggr_idx;
> >
> > +     /* Only support leader sampling with a group of read events. */
> > +     if ((read_format & PERF_FORMAT_GROUP) =3D=3D 0)
> > +             return;
> > +
> > +     /* Lazy initialization of stats values. */
> >       if (!evsel->stats)
> >               evlist__alloc_stats(&stat_config, script->session->evlist=
, /*alloc_raw=3D*/false);
> > -     if (evsel_script(leader)->gnum++ =3D=3D 0)
> > -             perf_stat__reset_shadow_stats();
> > -     val =3D sample->period * evsel->scale;
> > -     evsel_script(evsel)->val =3D val;
> > -     if (evsel_script(leader)->gnum =3D=3D leader->core.nr_members) {
> > -             for_each_group_member (ev2, leader) {
> > -                     perf_stat__print_shadow_stats(&stat_config, ev2,
> > -                                                   evsel_script(ev2)->=
val,
> > -                                                   sample->cpu,
> > -                                                   &ctx,
> > -                                                   NULL);
> > +     if (!stat_config.aggr_map) {
> > +             int nr_aggr;
> > +
> > +             stat_config.aggr_get_id =3D perf_script__get_cpu;
>
> To support per-thread mode, I think we should check thread_map of the
> evlist if it has actual PID.  And use the thread map index as an aggr
> idx.

Right, I wanted to send something out that was somewhat sensibly using
the aggregation and using perf_stat_process_counter that updates it.
The blamed patch was part of a series of cleaning up aggregation (by
me and Namhyung) that got rid of in stat shadow the duplicate
saved_value aggregation and switched to use the common aggregation
code. Andi's code brute forces the aggregation code making seemingly
questionable assumptions all over the place. I wanted to show that
needn't be the case.

Fwiw, I don't intend to send a v2 of this patch series. I'm perfectly
happy with the idea of "-F metric" just being deleted from perf
script.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +             stat_config.aggr_map =3D
> > +                     cpu_aggr_map__new(evsel->evlist->core.user_reques=
ted_cpus,
> > +                                     aggr_cpu_id__cpu,
> > +                                     /*data=3D*/NULL,
> > +                                     /*needs_sort=3D*/false);
> > +             if (!stat_config.aggr_map) {
> > +                     pr_err("cannot allocate aggr map\n");
> > +                     return;
> > +             }
> > +             nr_aggr =3D stat_config.aggr_map->nrd;
> > +             if (evlist__alloc_aggr_stats(evsel->evlist, nr_aggr) < 0)=
 {
> > +                     pr_err("cannot allocate aggr counts\n");
> > +                     return;
> >               }
> > -             evsel_script(leader)->gnum =3D 0;
> > +     }
> > +
> > +     /* Add group counts from sample into appropriate evsel counts by =
id. */
> > +     for_each_group_evsel(ev2, leader) {
> > +             struct perf_thread_map *threads =3D perf_evsel__threads(&=
ev2->core);
> > +             struct perf_cpu_map *cpus =3D evsel__cpus(ev2);
> > +             int id_num =3D 0;
> > +             bool match =3D false;
> > +
> > +             perf_cpu_map__for_each_idx(cpu_map_idx, cpus) {
> > +                     for (thread_idx =3D 0; thread_idx < threads->nr; =
thread_idx++) {
> > +                             struct sample_read_value *value =3D sampl=
e->read.group.values;
> > +                             u64 id =3D ev2->core.id[id_num++];
> > +
> > +                             sample_read_group__for_each(value, sample=
->read.group.nr,
> > +                                                         read_format) =
{
> > +                                     struct perf_counts_values *counts=
;
> > +
> > +                                     if (value->id !=3D id)
> > +                                             continue;
> > +
> > +                                     counts =3D perf_counts(ev2->count=
s, cpu_map_idx, thread_idx);
> > +                                     counts->val +=3D value->value;
> > +                                     /*
> > +                                      * Ensure the enabled/running tim=
e isn't
> > +                                      * 0, which implies an error.
> > +                                      */
> > +                                     counts->ena +=3D sample->read.tim=
e_enabled ?: sample->period;
> > +                                     counts->run +=3D sample->read.tim=
e_running ?: sample->period;
> > +                                     match =3D true;
> > +                             }
> > +                     }
> > +             }
> > +             if (match) {
> > +                     /* Update the aggreate count in ev2. */
> > +                     perf_stat_process_counter(&stat_config, ev2);
> > +             }
> > +     }
> > +
> > +     /* Find the appropriate indices for dumping of this sample. */
> > +     thread_idx =3D perf_thread_map__idx(perf_evsel__threads(&evsel->c=
ore),
> > +                                     thread__pid(thread));
> > +     cpu_map_idx =3D perf_cpu_map__idx(evsel__cpus(evsel), sample_cpu)=
;
> > +     if (thread_idx =3D=3D -1 || cpu_map_idx =3D=3D -1)
> > +             return;
> > +
> > +     cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
> > +             if (stat_config.aggr_map->map[aggr_idx].cpu.cpu =3D=3D sa=
mple_cpu.cpu)
> > +                     break;
> > +     }
> > +     /* Iterate all events and the leader of the group, trying to prin=
t stats. */
> > +     for_each_group_evsel(ev2, leader) {
> > +             struct perf_counts_values *counts =3D
> > +                     perf_counts(ev2->counts, cpu_map_idx, thread_idx)=
;
> > +
> > +             if (!counts)
> > +                     continue;
> > +
> > +             perf_stat__print_shadow_stats(&stat_config, ev2, counts->=
val * ev2->scale,
> > +                                           aggr_idx, &ctx, NULL);
> >       }
> >  }
> >
> > --
> > 2.45.2.1089.g2a221341d9-goog
> >

