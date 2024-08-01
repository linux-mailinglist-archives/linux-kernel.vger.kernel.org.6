Return-Path: <linux-kernel+bounces-270497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCAD9440B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E05281007
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770114C581;
	Thu,  1 Aug 2024 01:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1BkOFn9"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C114BF8B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476154; cv=none; b=gEFwvH4VucOi6AzXeFRcGK+z5WeVQXjOST1rP6f35d378cwieXxA/uIz/R0NmFuXRmaWSKTwu83ydkLjjqRX46TKDJTk79+cbLq+N5Yz8jJeIfz+QnAcE5WMrr81JTfam/M52GfjDNY1GDPIOijbIl7vexJtcyLZZdVfd93b6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476154; c=relaxed/simple;
	bh=D4jQ3hDsPrOEZnB+4u9pnJvTxR87PrXn94gydb83TLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcdmynFIZk4HVnrRAeKmzvvSjFc3/UZLZporg8vgAb9mAn86KFewYqKXoWqWZdi6QWbpy/8oaF41aKe+bgEDi4ogmp+cKIFxRNPPwHLuvI+KpoHSnjEKSFfzlUl5q8eNfit75lbzguuMpr74HHQJE62nzFpmMJaHQCP/r4RsN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1BkOFn9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4aff530dso351465ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722476151; x=1723080951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plqL2dIvuw7F4PehvmHEAIZYJJhHz3IF52CvuaEwxgA=;
        b=A1BkOFn91CiJHSOjbuqr957L+Kj2BrFN608vVJvhWzgcPLWUcKkQi0ycEP8Jsgt8N+
         /j1+KIvrwrhU9Gws7tFu8kt+EHy83M5d2up0y8khZnqQyYyT6v6F/5C3oek4nfXGknnA
         uGLr/HYwsYW9x4CDp/O5KakIqzl8HsFwrktKC4yhMr/IFlLXGTdfpUy1+5ElAH9gfu/n
         6DgQT+lLlEemdHkCYKBYyKue2D43cMG0eg8k+Qb0QB5Je+HIAYP4x+xiD+aKDwxMBZn3
         KwflB/gC4w0W5l21hk3x1G6NZPE4VCTbBaKgOb3ZIWwj/BRpyQkZ9m37W++ZPSdgicr/
         1vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722476151; x=1723080951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plqL2dIvuw7F4PehvmHEAIZYJJhHz3IF52CvuaEwxgA=;
        b=iuYpeZ9ANb0CdcfpCgICk9/dU4rTchi+nNjyt4VPglRuQobRNSw4ApaGD2Z10X+Lgc
         u3bLJX4CStbIew2HdkA9Gt+iostkI8UaJyAaIUFTbAARWby5IhktJQ62Xer1AiDAANB0
         agUjBSiqzWiXejr1bzA+QkMQmOWsDf2LmdK8ipambNySU477fySkxERNi9JZKOuhMbEP
         XY49sEYvUvlXsZET8Zv8Sejr7uUkVBORfJVntPcUV1GL47aJcQkoh+3BuTRAmWs2xMUp
         8O5qc6xv8QOLUPRUVuJ7SoAiWRdGeTBZpDKUfJVjmrlwoVBmQd0EBXivcGhD+qx9xcVA
         +H0w==
X-Forwarded-Encrypted: i=1; AJvYcCULAqsGozbvWI9IOiKA7KxlHQJV8q0OSbI0qGho6ajvZgb//TIBePXsNyHa3S8CskMwxoQGkuDWE+fFznXPBeadYHCWA8QfDwIi9n2Y
X-Gm-Message-State: AOJu0YzncIi5zMRs7NYafiKj9qL3d0KuZ9oGfMpory2J6KZdIU7EjJGp
	S5U80Ewpe6XOf5l8AcnLkNjVD0DYXCaPmOhDMlt7MynQWoCdChl80kMGu8lQE9I1YQn6qB7iaJz
	QnovZqBcPpVdkpC6/ky3Vv3YJztizviCx7QKo
X-Google-Smtp-Source: AGHT+IEecAbhodWaECwF1tFkoM0qqJAxepCeosOn1jrWDomaRpij7jppTG47HHjOvrCgW7/w6XugtAT/loHkkZQloJk=
X-Received: by 2002:a17:903:2283:b0:1fd:67c2:f967 with SMTP id
 d9443c01a7336-1ff4ec9341bmr804255ad.14.1722476151226; Wed, 31 Jul 2024
 18:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com> <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1> <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1> <ZqpcRIzzBb5KC6Zb@x1> <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>
 <ZqqIEckIXQEAd9xr@x1> <CAP-5=fV8S0z=Fn+aoq4SxatBeeJ5MEUL02km_6+enqWaaW2qQA@mail.gmail.com>
 <ZqqhhsJtBJgfXWV4@x1>
In-Reply-To: <ZqqhhsJtBJgfXWV4@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 18:35:38 -0700
Message-ID: <CAP-5=fXvgicd9FjHobQWNmouYHv87FUbtAQqaQfCE_i4bjzFVQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 01:20:06PM -0700, Ian Rogers wrote:
> > On Wed, Jul 31, 2024 at 11:53=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 08:58:43AM -0700, Ian Rogers wrote:
> > > > On Wed, Jul 31, 2024 at 8:46=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > > > > > > On Wed, Jul 31, 2024 at 6:18=E2=80=AFAM Arnaldo Carvalho de M=
elo
> > > > > > > <acme@kernel.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > > > > > > empty-pmu-events.c exists so that builds may occur withou=
t python
> > > > > > > > > being installed on a system. Manually updating empty-pmu-=
events.c to
> > > > > > > > > be in sync with jevents.py is a pain, let's use jevents.p=
y to generate
> > > > > > > > > empty-pmu-events.c.
> > > > > > > >
> > > > > > > > What am I missing here?
> > > > > > > >
> > > > > > > > If it exists so that we can build on a system without pytho=
n how can we
> > > > > > > > use python to generate it?
> > > > > > > >
> > > > > > > > Now having python in the system is a requirement and thus w=
e don't need
> > > > > > > > empty-pmu-events.c anymore?
> > > > > > > >
> > > > > > > > Can you guys please clarify that?
> > > > > > >
> > > > > > > The requirement for python hasn't changed.
> > > > > > >
> > > > > > > Case 1: no python or NO_JEVENTS=3D1
> > > > > > > Build happens using empty-pmu-events.c that is checked in, no=
 python
> > > > > > > is required.
> > > > > > >
> > > > > > > Case 2: python
> > > > > > > pmu-events.c is created by jevents.py (requiring python) and =
then built.
> > > > > > > This change adds a step where the empty-pmu-events.c is creat=
ed using
> > > > > > > jevents.py and that file is diffed against the checked in ver=
sion.
> > > > > > > This stops the checked in empty-pmu-events.c diverging if cha=
nges are
> > > > > > > made to jevents.py. If the diff causes the build to fail then=
 you just
> > > > > > > copy the diff empty-pmu-events.c over the checked in one.
> > > > > >
> > > > > > I'll try and add your explanation to the log message, thanks fo=
r
> > > > > > clarifying it!
> > > > >
> > > > > So, with it in place I'm now noticing:
> > > > >
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(base=
name $PWD)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m=3D'rm -rf ~/libe=
xec/perf-core/ ; make -k CORESIGHT=3D1 O=3D/tmp/build/$(basename $PWD)/ -C =
tools/perf install-bin && perf test python'
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> > > > > <SNIP>
> > > > >   GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-ev=
ents.c
> > > > >   MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
> > > > >   CC      /tmp/build/perf-tools-next/util/annotate.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
> > > > >   CC      /tmp/build/perf-tools-next/util/block-info.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test=
.o
> > > > >   CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
> > > > >   MKDIR   /tmp/build/perf-tools-next/ui/browsers/
> > > > >   CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
> > > > >   CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
> > > > >   CC      /tmp/build/perf-tools-next/util/block-range.o
> > > > >   TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.=
log
> > > > > --- pmu-events/empty-pmu-events.c       2024-07-31 12:44:14.35504=
2296 -0300
> > > > > +++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c=
       2024-07-31 12:45:35.048682785 -0300
> > > > > @@ -380,7 +380,7 @@
> > > > >                          continue;
> > > > >
> > > > >                  ret =3D pmu_events_table__for_each_event_pmu(tab=
le, table_pmu, fn, data);
> > > > > -                if (pmu || ret)
> > > > > +                if (ret)
> > > >
> > > > Right, you need to copy:
> > > >  /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
> > > > to
> > > > tools/perf/pmu-events/empty-pmu-events.c
> > > > to fix this.
> > > >
> > > > This change has happened as you are testing with:
> > > > https://lore.kernel.org/lkml/20240716132951.1748662-1-kan.liang@lin=
ux.intel.com/
> > > > which isn't in the git repo yet (therefore, I can't make a patch se=
t
> > > > on it). The change is WAI as it is telling you empty-pmu-events.c h=
as
> > > > become stale and needs Kan's fix applying to it.
> > >
> > > ok, I'll remove Kan's patch, publish perf-tools-next and wait for the
> > > now normal flow of patches.
> >
> > I can resend Kan's patch with the empty-pmu-events.c fix applied. I
> > don't see the changes in tmp.perf-tools-next so I can do it with
> > cherry picks.
>
> Just force pushed one more time. After a while should be there, there
> are still some issues here and there, notably:
>
>
> root@x1:~# perf test 105 106 118
> 105: perf all metricgroups test                                      : FA=
ILED!
> 106: perf all metrics test                                           : FA=
ILED!

These tests can be sensitive to the NMI watchdog being enabled.
> 118: Miscellaneous Intel PT testing                                  : FA=
ILED!

I bisected this failure to:

```
Author: Leo Yan <leo.yan@arm.com>
Date:   Thu Jul 25 07:46:17 2024 +0100

   perf auxtrace: Iterate all AUX events when finish reading

   When finished to read AUX trace data from mmaped buffer, based on the
   AUX buffer index the core layer needs to search the corresponding PMU
   event and re-enable it to continue tracing.

   However, current code only searches the first AUX event. It misses to
   search other enabled AUX events, thus, it returns failure if the buffer
   index does not belong to the first AUX event.

   This patch extends the auxtrace_record__read_finish() function to
   search for every enabled AUX events, so all the mmaped buffer indexes
   can be covered.

   Signed-off-by: Leo Yan <leo.yan@arm.com>
   Cc: Mark Rutland <mark.rutland@arm.com>
   Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
   Cc: Ian Rogers <irogers@google.com>
   Cc: Adrian Hunter <adrian.hunter@intel.com>
   Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
   Cc: Jiri Olsa <jolsa@kernel.org>
   Cc: Namhyung Kim <namhyung@kernel.org>
   Cc: James Clark <james.clark@linaro.org>
   Cc: Mike Leach <mike.leach@linaro.org>
   Cc:  <coresight@lists.linaro.org>
   Cc: John Garry <john.g.garry@oracle.com>
   Cc:  <linux-perf-users@vger.kernel.org>
   Link: https://lore.kernel.org/lkml/
   Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

tools/perf/util/auxtrace.c | 25 ++++++++++++++++++++-----
1 file changed, 20 insertions(+), 5 deletions(-)
```

> root@x1:~# perf test 110
> 110: perf stat --bpf-counters --for-each-cgroup test                 : FA=
ILED!

This one flakes if the test machine has load on it.

> root@x1:~#
>
> I'm running out of time today, so I'll probably just push what I have to
> perf-tools-next so that we can start getting testing from linux-next and
> we can then go on fixing up stuff from there.

Thanks,
Ian

