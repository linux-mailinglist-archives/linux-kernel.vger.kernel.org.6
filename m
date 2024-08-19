Return-Path: <linux-kernel+bounces-292836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0F3957507
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1941F21E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA71DC481;
	Mon, 19 Aug 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0a9m/yq"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272728F3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097293; cv=none; b=DR0YP34qdRKbpomKU5vbsIzPt6xWWjIURCLBT3+2Wr0Kv2dl2Olk69vTxVngLfORnXCXcpzG3PPKxFAtGvL9jBNT0Poo47C2vKLR0C2osJZj41epjPf5FyDNBcfWNSSTYfU1NR4zaWnNaJkfDhXO8GjDQJTG0/hv8cmUUv6iogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097293; c=relaxed/simple;
	bh=zhq+X5nYUyV/snoIifxNqCxkLkFIdp1UBRJAhcG/yQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnhBFnN5j3mBQZlesjXJvGdufVL5efggEs0y07Twx8RH2uWkexov9lpZ6Df/ip7Bmap4CRL+LytWzudVtE1Nt9XserUZ2x4LYVelhp+eEGhV+6pvZsGVv1+zbiLrSWm5Pfanx6KZlNtJZnIrNqFkDXxTEh+3WYs2uORkgIvnxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0a9m/yq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20260346ca1so21475ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724097291; x=1724702091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/yVYC0utA/vYt9qNIg0AivU+NsHVvLSKr6Q9Om+ziI=;
        b=M0a9m/yqQI82FMla1MMtQcJrnPAADcpR0jT5k6aiVL4UEGsFNdAGCeYfyNOoPiO7yI
         SdF0aBjvJ+enGzNNAvKAIfDEe1W4/CmSn62tU5pkMjTZvkS7C68InXZ82pU1NA+Yc0VQ
         kys3cPQdH2JyfKJC6ueFCUSKbxAv7ba2T55Hmnz8wlrU2E3ApbeJBYKlkB5wAULBGMAn
         HaZjoi8egOMELzo6DvO0xzG5T7Y5jGJaaK6gZwnFfq+pIHSPhcMZYdXrvHKwHc/o4KTz
         ud3zOcAddCRRq/VF52OxI4/Hr1sf6Q3CE8YGLim0tYctRqz+vFkllsVcjCj8jSCCfUHH
         Ad2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097291; x=1724702091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/yVYC0utA/vYt9qNIg0AivU+NsHVvLSKr6Q9Om+ziI=;
        b=PN40sjD1mFXl/zhWpyqVuIOVh2LchiDT7pu2LGtTivcAJxonBT2YZpcKhOD8w20q/J
         z64B9OtVl41CkeKcBmLDhxG/tN524Vh7cXf66CqM4JN9Azli3X950kOwT+p+LIMKPDvP
         bGy/+Fn+Jq0GW/vT7YwvrDYbgAXzhtD1mCUbo/soMgL/gFwZGUaJUR7gCj7/zgAaColB
         dmMGohLzaBKTISU47VCD43vxhC302lI7cc38xI42E7ruDhFKzmzw46KZowgo41rcG8TR
         uPEU0CURwSA5XrNZbmYrv/U4x3D+JgCSbrgq9Vg/SCZ9/OUgrPFFCrBF8OZoMS6LrO1A
         bCVA==
X-Forwarded-Encrypted: i=1; AJvYcCXnmJ8+anDMyNZQl9fhDo6oa4roQ81f+gzW48e9gLE6OBnfHuOebYjefIxgOILv1rS+UWn7og3TzTEGdInRR57yAtqtUCCMG9y/6uPa
X-Gm-Message-State: AOJu0Yw+ZrPZm3trWrreXDErAz3mo52IkjIUKKHnVR/nB6E+GslA9c3K
	sViuE2ZtPtVZ/7NznX34vh1Y5yQTrvqvk6SBj6vh68qVx40k15CJvt1W6IrnSsrwyVun/K7wTzG
	Q1SNr0NYFXn9alPLXOJ/RjZ+rRZgiBJUmURnf
X-Google-Smtp-Source: AGHT+IFr19SZonNRVwBCd6KWpb2/u2UwPSMnXmQA5BM9ud5zm4lX8KfyT5wYeNj6qI/Jz6XItdBUelnSCgjeV1q7uGM=
X-Received: by 2002:a17:902:e745:b0:1fb:172a:f3d4 with SMTP id
 d9443c01a7336-202d5b54f75mr197825ad.8.1724097289982; Mon, 19 Aug 2024
 12:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com> <20240817064442.2152089-11-irogers@google.com>
 <ZsOIkMEf3l6e-mdX@x1>
In-Reply-To: <ZsOIkMEf3l6e-mdX@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Aug 2024 12:54:36 -0700
Message-ID: <CAP-5=fVqkR7Xd8GXw31MPNSsfvkiPVavQjQSieWUpKasHcLVQQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/13] perf inject: Fix build ID injection
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 11:01=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Aug 16, 2024 at 11:44:39PM -0700, Ian Rogers wrote:
> > Build ID injection wasn't inserting a sample ID and aligning events to
> > 64 bytes rather than 8. No sample ID means events are unordered and
> > two different build_id events for the same path, as happens when a
> > file is replaced, can't be differentiated.
> >
> > Add in sample ID insertion for the build_id events alongside some
> > refactoring. The refactoring better aligns the function arguments for
> > different use cases, such as synthesizing build_id events without
> > needing to have a dso. The misc bits are explicitly passed as with
> > callchains the maps/dsos may span user and kernel land, so using
> > sample->cpumode isn't good enough.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-inject.c        | 170 ++++++++++++++++++++++-------
> >  tools/perf/util/build-id.c         |   6 +-
> >  tools/perf/util/synthetic-events.c |  44 ++++++--
> >  tools/perf/util/synthetic-events.h |  10 +-
> >  4 files changed, 175 insertions(+), 55 deletions(-)
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index a7c859db2e15..84a4bdb5cb0a 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -131,6 +131,7 @@ struct perf_inject {
> >       struct perf_file_section secs[HEADER_FEAT_BITS];
> >       struct guest_session    guest_session;
> >       struct strlist          *known_build_ids;
> > +     const struct evsel      *mmap_evsel;
> >  };
> >
> >  struct event_entry {
> > @@ -139,8 +140,13 @@ struct event_entry {
> >       union perf_event event[];
> >  };
> >
> > -static int dso__inject_build_id(struct dso *dso, const struct perf_too=
l *tool,
> > -                             struct machine *machine, u8 cpumode, u32 =
flags);
> > +static int dso__inject_build_id(const struct perf_tool *tool,
> > +                             struct perf_sample *sample,
> > +                             struct machine *machine,
> > +                             const struct evsel *evsel,
> > +                             __u16 misc,
> > +                             const char *filename,
> > +                             struct dso *dso, u32 flags);
>
> So in the end the dso was needed, the name of the function remains
> dso__something(), so first arg would be a 'struct dso *'
>
> I processed the patches up to 9/13, so that they can get tested now.

Maybe we should rename the function? We can get the build ID from
mmap2 events now, not just stored away in the dso by build_id events.
Reordering the arguments isn't a problem, I was just aiming for
consistency between the caller, perf_event__synthesize_build_id and
eventually the call to process that all take the arguments in this
order.

Thanks,
Ian

> - Arnaldo
>
> >
> >  static int output_bytes(struct perf_inject *inject, void *buf, size_t =
sz)
> >  {
> > @@ -422,6 +428,28 @@ static struct dso *findnew_dso(int pid, int tid, c=
onst char *filename,
> >       return dso;
> >  }
> >
> > +/*
> > + * The evsel used for the sample ID for mmap events. Typically stashed=
 when
> > + * processing mmap events. If not stashed, search the evlist for the f=
irst mmap
> > + * gathering event.
> > + */
> > +static const struct evsel *inject__mmap_evsel(struct perf_inject *inje=
ct)
> > +{
> > +     struct evsel *pos;
> > +
> > +     if (inject->mmap_evsel)
> > +             return inject->mmap_evsel;
> > +
> > +     evlist__for_each_entry(inject->session->evlist, pos) {
> > +             if (pos->core.attr.mmap) {
> > +                     inject->mmap_evsel =3D pos;
> > +                     return pos;
> > +             }
> > +     }
> > +     pr_err("No mmap events found\n");
> > +     return NULL;
> > +}
> > +
> >  static int perf_event__repipe_common_mmap(const struct perf_tool *tool=
,
> >                                         union perf_event *event,
> >                                         struct perf_sample *sample,
> > @@ -469,12 +497,28 @@ static int perf_event__repipe_common_mmap(const s=
truct perf_tool *tool,
> >               }
> >
> >               if (dso && !dso__hit(dso)) {
> > -                     dso__set_hit(dso);
> > -                     dso__inject_build_id(dso, tool, machine, sample->=
cpumode, flags);
> > +                     struct evsel *evsel =3D evlist__event2evsel(injec=
t->session->evlist, event);
> > +
> > +                     if (evsel) {
> > +                             dso__set_hit(dso);
> > +                             dso__inject_build_id(tool, sample, machin=
e, evsel,
> > +                                                  /*misc=3D*/sample->c=
pumode,
> > +                                                  filename, dso, flags=
);
> > +                     }
> >               }
> >       } else {
> > +             int err;
> > +
> > +             /*
> > +              * Remember the evsel for lazy build id generation. It is=
 used
> > +              * for the sample id header type.
> > +              */
> > +             if (inject->build_id_style =3D=3D BID_RWS__INJECT_HEADER_=
LAZY &&
> > +                 !inject->mmap_evsel)
> > +                     inject->mmap_evsel =3D evlist__event2evsel(inject=
->session->evlist, event);
> > +
> >               /* Create the thread, map, etc. Not done for the unordere=
d inject all case. */
> > -             int err =3D perf_event_process(tool, event, sample, machi=
ne);
> > +             err =3D perf_event_process(tool, event, sample, machine);
> >
> >               if (err) {
> >                       dso__put(dso);
> > @@ -667,16 +711,20 @@ static bool perf_inject__lookup_known_build_id(st=
ruct perf_inject *inject,
> >       return false;
> >  }
> >
> > -static int dso__inject_build_id(struct dso *dso, const struct perf_too=
l *tool,
> > -                             struct machine *machine, u8 cpumode, u32 =
flags)
> > +static int dso__inject_build_id(const struct perf_tool *tool,
> > +                             struct perf_sample *sample,
> > +                             struct machine *machine,
> > +                             const struct evsel *evsel,
> > +                             __u16 misc,
> > +                             const char *filename,
> > +                             struct dso *dso, u32 flags)
> >  {
> > -     struct perf_inject *inject =3D container_of(tool, struct perf_inj=
ect,
> > -                                               tool);
> > +     struct perf_inject *inject =3D container_of(tool, struct perf_inj=
ect, tool);
> >       int err;
> >
> > -     if (is_anon_memory(dso__long_name(dso)) || flags & MAP_HUGETLB)
> > +     if (is_anon_memory(filename) || flags & MAP_HUGETLB)
> >               return 0;
> > -     if (is_no_dso_memory(dso__long_name(dso)))
> > +     if (is_no_dso_memory(filename))
> >               return 0;
> >
> >       if (inject->known_build_ids !=3D NULL &&
> > @@ -684,24 +732,65 @@ static int dso__inject_build_id(struct dso *dso, =
const struct perf_tool *tool,
> >               return 1;
> >
> >       if (dso__read_build_id(dso) < 0) {
> > -             pr_debug("no build_id found for %s\n", dso__long_name(dso=
));
> > +             pr_debug("no build_id found for %s\n", filename);
> >               return -1;
> >       }
> >
> > -     err =3D perf_event__synthesize_build_id(tool, dso, cpumode,
> > -                                           perf_event__repipe, machine=
);
> > +     err =3D perf_event__synthesize_build_id(tool, sample, machine,
> > +                                           perf_event__repipe,
> > +                                           evsel, misc, dso__bid(dso),
> > +                                           filename);
> >       if (err) {
> > -             pr_err("Can't synthesize build_id event for %s\n", dso__l=
ong_name(dso));
> > +             pr_err("Can't synthesize build_id event for %s\n", filena=
me);
> >               return -1;
> >       }
> >
> >       return 0;
> >  }
> >
> > +static int mark_dso_hit(const struct perf_tool *tool,
> > +                     struct perf_sample *sample,
> > +                     struct machine *machine,
> > +                     const struct evsel *mmap_evsel,
> > +                     struct map *map, bool sample_in_dso)
> > +{
> > +     struct dso *dso;
> > +     u16 misc =3D sample->cpumode;
> > +
> > +     if (!map)
> > +             return 0;
> > +
> > +     if (!sample_in_dso) {
> > +             u16 guest_mask =3D PERF_RECORD_MISC_GUEST_KERNEL |
> > +                     PERF_RECORD_MISC_GUEST_USER;
> > +
> > +             if ((misc & guest_mask) !=3D 0) {
> > +                     misc &=3D PERF_RECORD_MISC_HYPERVISOR;
> > +                     misc |=3D __map__is_kernel(map)
> > +                             ? PERF_RECORD_MISC_GUEST_KERNEL
> > +                             : PERF_RECORD_MISC_GUEST_USER;
> > +             } else {
> > +                     misc &=3D PERF_RECORD_MISC_HYPERVISOR;
> > +                     misc |=3D __map__is_kernel(map)
> > +                             ? PERF_RECORD_MISC_KERNEL
> > +                             : PERF_RECORD_MISC_USER;
> > +             }
> > +     }
> > +     dso =3D map__dso(map);
> > +     if (dso && !dso__hit(dso)) {
> > +             dso__set_hit(dso);
> > +             dso__inject_build_id(tool, sample, machine,
> > +                             mmap_evsel, misc, dso__long_name(dso), ds=
o,
> > +                             map__flags(map));
> > +     }
> > +     return 0;
> > +}
> > +
> >  struct mark_dso_hit_args {
> >       const struct perf_tool *tool;
> > +     struct perf_sample *sample;
> >       struct machine *machine;
> > -     u8 cpumode;
> > +     const struct evsel *mmap_evsel;
> >  };
> >
> >  static int mark_dso_hit_callback(struct callchain_cursor_node *node, v=
oid *data)
> > @@ -709,16 +798,8 @@ static int mark_dso_hit_callback(struct callchain_=
cursor_node *node, void *data)
> >       struct mark_dso_hit_args *args =3D data;
> >       struct map *map =3D node->ms.map;
> >
> > -     if (map) {
> > -             struct dso *dso =3D map__dso(map);
> > -
> > -             if (dso && !dso__hit(dso)) {
> > -                     dso__set_hit(dso);
> > -                     dso__inject_build_id(dso, args->tool, args->machi=
ne,
> > -                                          args->cpumode, map__flags(ma=
p));
> > -             }
> > -     }
> > -     return 0;
> > +     return mark_dso_hit(args->tool, args->sample, args->machine,
> > +                         args->mmap_evsel, map, /*sample_in_dso=3D*/fa=
lse);
> >  }
> >
> >  int perf_event__inject_buildid(const struct perf_tool *tool, union per=
f_event *event,
> > @@ -728,10 +809,16 @@ int perf_event__inject_buildid(const struct perf_=
tool *tool, union perf_event *e
> >  {
> >       struct addr_location al;
> >       struct thread *thread;
> > +     struct perf_inject *inject =3D container_of(tool, struct perf_inj=
ect, tool);
> >       struct mark_dso_hit_args args =3D {
> >               .tool =3D tool,
> > +             /*
> > +              * Use the parsed sample data of the sample event, which =
will
> > +              * have a later timestamp than the mmap event.
> > +              */
> > +             .sample =3D sample,
> >               .machine =3D machine,
> > -             .cpumode =3D sample->cpumode,
> > +             .mmap_evsel =3D inject__mmap_evsel(inject),
> >       };
> >
> >       addr_location__init(&al);
> > @@ -743,13 +830,8 @@ int perf_event__inject_buildid(const struct perf_t=
ool *tool, union perf_event *e
> >       }
> >
> >       if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
> > -             struct dso *dso =3D map__dso(al.map);
> > -
> > -             if (!dso__hit(dso)) {
> > -                     dso__set_hit(dso);
> > -                     dso__inject_build_id(dso, tool, machine,
> > -                                          sample->cpumode, map__flags(=
al.map));
> > -             }
> > +             mark_dso_hit(tool, sample, machine, args.mmap_evsel, al.m=
ap,
> > +                          /*sample_in_dso=3D*/true);
> >       }
> >
> >       sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_S=
TACK_DEPTH,
> > @@ -1159,17 +1241,27 @@ static int process_build_id(const struct perf_t=
ool *tool,
> >  static int synthesize_build_id(struct perf_inject *inject, struct dso =
*dso, pid_t machine_pid)
> >  {
> >       struct machine *machine =3D perf_session__findnew_machine(inject-=
>session, machine_pid);
> > -     u8 cpumode =3D dso__is_in_kernel_space(dso) ?
> > -                     PERF_RECORD_MISC_GUEST_KERNEL :
> > -                     PERF_RECORD_MISC_GUEST_USER;
> > +     struct perf_sample synth_sample =3D {
> > +             .pid       =3D -1,
> > +             .tid       =3D -1,
> > +             .time      =3D -1,
> > +             .stream_id =3D -1,
> > +             .cpu       =3D -1,
> > +             .period    =3D 1,
> > +             .cpumode   =3D dso__is_in_kernel_space(dso)
> > +             ? PERF_RECORD_MISC_GUEST_KERNEL
> > +             : PERF_RECORD_MISC_GUEST_USER,
> > +     };
> >
> >       if (!machine)
> >               return -ENOMEM;
> >
> >       dso__set_hit(dso);
> >
> > -     return perf_event__synthesize_build_id(&inject->tool, dso, cpumod=
e,
> > -                                            process_build_id, machine)=
;
> > +     return perf_event__synthesize_build_id(&inject->tool, &synth_samp=
le, machine,
> > +                                            process_build_id, inject__=
mmap_evsel(inject),
> > +                                            /*misc=3D*/synth_sample.cp=
umode,
> > +                                            dso__bid(dso), dso__long_n=
ame(dso));
> >  }
> >
> >  static int guest_session__add_build_ids_cb(struct dso *dso, void *data=
)
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 451d145fa4ed..8982f68e7230 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -277,8 +277,8 @@ static int write_buildid(const char *name, size_t n=
ame_len, struct build_id *bid
> >       struct perf_record_header_build_id b;
> >       size_t len;
> >
> > -     len =3D name_len + 1;
> > -     len =3D PERF_ALIGN(len, NAME_ALIGN);
> > +     len =3D sizeof(b) + name_len + 1;
> > +     len =3D PERF_ALIGN(len, sizeof(u64));
> >
> >       memset(&b, 0, sizeof(b));
> >       memcpy(&b.data, bid->data, bid->size);
> > @@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t n=
ame_len, struct build_id *bid
> >       misc |=3D PERF_RECORD_MISC_BUILD_ID_SIZE;
> >       b.pid =3D pid;
> >       b.header.misc =3D misc;
> > -     b.header.size =3D sizeof(b) + len;
> > +     b.header.size =3D len;
> >
> >       err =3D do_write(fd, &b, sizeof(b));
> >       if (err < 0)
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index 0a7f93ae76fb..6bb62e4e2d5d 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -2225,28 +2225,48 @@ int perf_event__synthesize_tracing_data(const s=
truct perf_tool *tool, int fd, st
> >  }
> >  #endif
> >
> > -int perf_event__synthesize_build_id(const struct perf_tool *tool, stru=
ct dso *pos, u16 misc,
> > -                                 perf_event__handler_t process, struct=
 machine *machine)
> > +int perf_event__synthesize_build_id(const struct perf_tool *tool,
> > +                                 struct perf_sample *sample,
> > +                                 struct machine *machine,
> > +                                 perf_event__handler_t process,
> > +                                 const struct evsel *evsel,
> > +                                 __u16 misc,
> > +                                 const struct build_id *bid,
> > +                                 const char *filename)
> >  {
> >       union perf_event ev;
> >       size_t len;
> >
> > -     if (!dso__hit(pos))
> > -             return 0;
> > +     len =3D sizeof(ev.build_id) + strlen(filename) + 1;
> > +     len =3D PERF_ALIGN(len, sizeof(u64));
> >
> > -     memset(&ev, 0, sizeof(ev));
> > +     memset(&ev, 0, len);
> >
> > -     len =3D dso__long_name_len(pos) + 1;
> > -     len =3D PERF_ALIGN(len, NAME_ALIGN);
> > -     ev.build_id.size =3D min(dso__bid(pos)->size, sizeof(dso__bid(pos=
)->data));
> > -     memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.si=
ze);
> > +     ev.build_id.size =3D min(bid->size, sizeof(ev.build_id.build_id))=
;
> > +     memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
> >       ev.build_id.header.type =3D PERF_RECORD_HEADER_BUILD_ID;
> >       ev.build_id.header.misc =3D misc | PERF_RECORD_MISC_BUILD_ID_SIZE=
;
> >       ev.build_id.pid =3D machine->pid;
> > -     ev.build_id.header.size =3D sizeof(ev.build_id) + len;
> > -     memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_name=
_len(pos));
> > +     ev.build_id.header.size =3D len;
> > +     strcpy(ev.build_id.filename, filename);
> > +
> > +     if (evsel) {
> > +             void *array =3D &ev;
> > +             int ret;
> >
> > -     return process(tool, &ev, NULL, machine);
> > +             array +=3D ev.header.size;
> > +             ret =3D perf_event__synthesize_id_sample(array, evsel->co=
re.attr.sample_type, sample);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             if (ret & 7) {
> > +                     pr_err("Bad id sample size %d\n", ret);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ev.header.size +=3D ret;
> > +     }
> > +     return process(tool, &ev, sample, machine);
> >  }
> >
> >  int perf_event__synthesize_stat_events(struct perf_stat_config *config=
, const struct perf_tool *tool,
> > diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synth=
etic-events.h
> > index 31df7653677f..795bf3e18396 100644
> > --- a/tools/perf/util/synthetic-events.h
> > +++ b/tools/perf/util/synthetic-events.h
> > @@ -9,6 +9,7 @@
> >  #include <perf/cpumap.h>
> >
> >  struct auxtrace_record;
> > +struct build_id;
> >  struct dso;
> >  struct evlist;
> >  struct evsel;
> > @@ -45,7 +46,14 @@ typedef int (*perf_event__handler_t)(const struct pe=
rf_tool *tool, union perf_ev
> >
> >  int perf_event__synthesize_attrs(const struct perf_tool *tool, struct =
evlist *evlist, perf_event__handler_t process);
> >  int perf_event__synthesize_attr(const struct perf_tool *tool, struct p=
erf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
> > -int perf_event__synthesize_build_id(const struct perf_tool *tool, stru=
ct dso *pos, u16 misc, perf_event__handler_t process, struct machine *machi=
ne);
> > +int perf_event__synthesize_build_id(const struct perf_tool *tool,
> > +                                 struct perf_sample *sample,
> > +                                 struct machine *machine,
> > +                                 perf_event__handler_t process,
> > +                                 const struct evsel *evsel,
> > +                                 __u16 misc,
> > +                                 const struct build_id *bid,
> > +                                 const char *filename);
> >  int perf_event__synthesize_cpu_map(const struct perf_tool *tool, const=
 struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine *=
machine);
> >  int perf_event__synthesize_event_update_cpus(const struct perf_tool *t=
ool, struct evsel *evsel, perf_event__handler_t process);
> >  int perf_event__synthesize_event_update_name(const struct perf_tool *t=
ool, struct evsel *evsel, perf_event__handler_t process);
> > --
> > 2.46.0.184.g6999bdac58-goog

