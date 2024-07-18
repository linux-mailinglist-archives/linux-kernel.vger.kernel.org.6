Return-Path: <linux-kernel+bounces-256722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B8935284
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79BA9B21784
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E414389A;
	Thu, 18 Jul 2024 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xVaKwoaw"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89C1EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335823; cv=none; b=kO2rV7wDKWEs9bov4rSEqPxrcXU9l9iS3G6b+vVH6/cmzFJUPJ/OCYLWBgd+/5LX1tYT30FJFt+RwWgFniJ7sRfD0mo2jrhI5Ni+YawdvAA9jECtKY6F7VLEpBQ2JtS8SgwGkI8vCDimxi8YTk8sYX6U/77Jf2DN/awQiOZH0eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335823; c=relaxed/simple;
	bh=e6PqTtu3rr9V/8nv48Dj+sjpyD85saz3uYZtrFTgfwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ez60Yc2onSW14WfKRlXITyJrAI3omRb+PfYYa0K0LoEzHaewKlw63YB/wNyIH1z/JknvDfYwP+bqh4wY4TO4qTxCXK+TYJH5ZnzsgK3ryh4Z5yJzz9iluMzqahO8moNwf7/H6m0eXHk7oOhLdutEjlVC52mYpHQdvywp1ZpJpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xVaKwoaw; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-38b3543541dso40755ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721335820; x=1721940620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz/mod9fMJfSjeVQu/iuesJBhQWoQQDJHWVa2NbAKHA=;
        b=xVaKwoawrd7oG2AEIiU7nyA9P1lPGVuwwBASqIwF8gyJ4PiPuAp5UuvPFcKBVvaSl+
         EABFcsf3eUdJDCUv8JCcc57dwgJaBQonSH6PH82c37L8aJiQnzlquz86jh9hj0m53Z+o
         syXgREmrCjiDd49C/e0g3KhEnvZQVwEXYDN3mFb8RPtbbrqSdoe3rpBoACEiiQMUAWYW
         0zDTKQbfVwLVmhEmo6rASupwcbNPUkYArN9O8HeCHIptUhsqXb5WENJP0NUJBTuqxZMe
         ShssQLXbXIBEeUfIFFQzqZYihm+TLpkQiIRlb69oNd8ccgU3bUpztkmYzMvzVK52lM9J
         owFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721335820; x=1721940620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz/mod9fMJfSjeVQu/iuesJBhQWoQQDJHWVa2NbAKHA=;
        b=ueYzS5IoffmWgKYPybSjcq9m7jkRjS97eVH68kIXfENjYcePq7mjhs49EWgs7rvwgi
         tL4TpabFQxmFdiKYiTL+KyBYIfTuknswhgprtle59UCoRG2bc3PUdl1o177U9CEm4UXE
         WjovPB/h+A2K1u8kKMyIH/GmMEAKY8if+xLKRWUn5pGQ1NITsk2HSQ+w82AvSx8AUkI1
         ByF65Z+v6Yx0gy+59aRm3nWteNBuiBUIqaM+jcUWuWXRxtQlhFSB3h3hEbIkoz2n91/v
         8WyLjRGbwPSC7hzZaBlPMInCsGS37nmcIFQL1vQJffu6U0fwy+RUsHz62DYelz90GV2V
         X1xw==
X-Forwarded-Encrypted: i=1; AJvYcCVkhBvEL2oKDg5X7ZlFpzyJ8grEMtPTOzmHBwDdsBJuqhKFm1IkaTSacZQKas+UL9Woiy5WDYNCf6EEFTTPB2nRLk2SuTfzN7qA0Fve
X-Gm-Message-State: AOJu0YwFSqXX2/g5yyWKQGSW1v3qu1MJ+1e5ROQS1KnCT5NVU0LsDM06
	Cc/H97mxVkME32lDUYK3cfh40ENJPk6UWM5mn+Iw48p3tz0m5Vf4FVDz/ZQAGThdT/32xTJWSrR
	dIhPDE33wFCps25gtbRwDUt7553x+5R2YIo1f
X-Google-Smtp-Source: AGHT+IH2CtpfHfcmZXuSnIMbLk0AhcQwjdmVCbZ/pLecFOb5wDHdwQ43ffSvDTZSn/VneNJ3Sy39hhhYNenMo5S+Lg4=
X-Received: by 2002:a05:6e02:1c03:b0:397:98d7:5175 with SMTP id
 e9e14a558f8ab-397b611bf14mr784305ab.12.1721335820410; Thu, 18 Jul 2024
 13:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com> <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
 <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
In-Reply-To: <64030eab-6e95-494a-ab72-bc33792ef723@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 13:50:09 -0700
Message-ID: <CAP-5=fVMV4ZmGk4-XguqV=LAuif-MgAL+BK=mMAE1tC3f3tbhQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] perf pmu: Add support for event.cpus files in sysfs
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, ananth.narayan@amd.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 10:48=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2024-07-18 11:39 a.m., Ian Rogers wrote:
> > On Thu, Jul 18, 2024 at 7:33=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >>
> >> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> >>> If an event file exists in sysfs, check if a event.cpus file exists
> >>> and read a perf_cpu_map from it if it does. This allows particular
> >>> events to have a different set of CPUs compared to the PMU.
> >>>
> >>> One scenario where this could be useful is when a PMU is set up with =
a
> >>> cpumask/events per SMT thread but some events record for all SMT
> >>> threads. Programming an event on each SMT thread will cause
> >>> unnecessary counters to be programmed and the aggregate value to be
> >>> too large.
> >>
> >> If I understand the scenario correctly, I think the issue should have
> >> been addressed since ICX, with the introduction of  the "SMT-aware
> >> events". Is there a specific event which still has the issue on newer
> >> platforms?
> >
> > Nothing comes to mind, but it is there on popular machines like Skylake=
.
> >
> >>>
> >>> Another scenario where this could be useful if when a PMU has
> >>> historically had a cpumask at the package level, but now newer per
> >>> die, core or CPU information is available.
> >>
> >> The traditional way to support new counters with a different scope is =
to
> >> add a new PMU.
> >>
> >>>
> >>> Additional context for the motivation is in these patches and
> >>> conversation:
> >>> https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@=
amd.com/
> >>
> >> I don't see the advantages of the new event.cpus way.
> >> The aggregation should be the same.
> >
> > Agreed. My concern is that we may end up with a pattern of
> > <pmu>_per_pkg, <pmu>_per_core, <pmu>_per_cpu, <pmu>_per_l3, etc. just
> > for the sake of the cpumask.
>
> The cstate PMUs already do so, e.g., cstate_core, cstate_pkg.
>
> From another perspective, it discloses the scope information in a PMU
> name. If a user only cares about the information of a package, they just
> need to focus on everything under <pmu>_pkg. Otherwise, they have to go
> through all the events.
>
> >
> >> The RAPL counters are free-running counters. So there is no difference
> >> whether grouping or not grouping.
> >
> > Should the RAPL counters return true for perf_pmu__is_software? In the
> > tool we currently return false and won't allow grouping, these events
> > with other hardware events. The intent in perf_pmu__is_software was to
> > emulate the way the kernel allows/disallows groups - software context
> > events can be in a hardware context but otherwise I don't believe the
> > grouping is allowed.
>
> No, it's not allowed for the RAPL counters.
>
> If the motivation is to find another way to group counters with
> different scope, it may not work.
>
> We once tried to mix the perf_invalid_context PMUs in a group. But it's
> denied.
> https://yhbt.net/lore/all/20150415172856.GA5029@twins.programming.kicks-a=
ss.net/
>
> The event.cpus still faces the same issues.

Why so? The events would share the same perf_event_context, I thought
the perf_event_open would succeed.

> >
> >> But it makes the kernel driver complex, since it has to maintain at
> >> least two different cpumasks.
> >
> > Two drivers each maintaining a cpumask or 1 driver maintaining 2
> > cpumasks, it seems like there is chance for code reuse in both cases.
> > I'm not seeing how it adds to complexity particularly.
>
> Yes, there are some cleanup opportunities for the cpumask/hotplug codes.
>
> We may even abstracts some generic interfaces for pkg or core level PMUs.
>
> Eventually, the complexity/duplication should be able to be reduced.
>
> >
> >> The tool becomes complex either, since it has to take care of the
> >> per-event CPU override case.
> >
> > I'm not sure I agree with this. What we need for perf_event_open is a
> > perf_event_attr, we dress these up as evsels which also have the
> > ability to be for >1 CPU or thread. Longer term I think evsels can
> > also have >1 PMU, for the wildcard cases like uncore memory
> > controllers - this would remove the need for resorting evsels except
> > for topdown events which have thrown us a giant bundle of challenges.
> > Anyway, so an evsel is perf_event_attr information paired with CPU
> > information, it makes sense to me that the parser should do this
> > pairing. What's harder in the evsel/evlist setup is trying to fix CPU
> > maps up not in parsing, like with __perf_evlist__propagate_maps where
> > the parsing is trying to leave crumbs around (like system_wide,
> > has_user_cpus, is_pmu_core) so the map propagation works properly.
> >
> >> The json file must also be updated to add a
> >> new field cpumask.
> >
> > Yeah, I don't like this as it means we end up putting CPU information
> > into the json that isn't the same for every CPU variant of the same
> > architecture model. Maybe we can have some kind of "scope" enum value
> > in the json and then when the scope differs from the PMU's, core scope
> > vs the PMU's hyperthread scope, then in the tool we can figure out the
> > cpumask from the topology in sysfs. Maybe we should just always use
> > the topology and get rid of cpumask files in sysfs, replacing them
> > with "scope" files. Will Deacon pushed back on having ARM PMUs
> > supporting hot plugging
> > (https://lore.kernel.org/lkml/20240701142222.GA2691@willie-the-truck/)
> > where the main thing hot plugging handler needs to maintain is set the
> > cpumask.
>
> Not just the cpumask but also migrate the context for some PMUs, see
> perf_pmu_migrate_context().

Will do, thanks.

> It seems we really need a shared cpumask in the generic code, so the
> drivers don't need to handle the hotplug everywhere. I will think about i=
t.

Thanks. There are other problems on ARM PMUs like having no or empty
cpumasks, which the tool take to mean open the event on every online
CPU (there is no cpus or cpumask file on core PMUs historically, so we
adopt this behavior when the cpumask is empty or not present). I've
been thinking to expand `tools/perf/tests/pmu.c` with basic PMU sanity
tests. Some ideas:

1) some kind of cpumask sanity check - we could open an event with the
cpumask and see if it yields multiplexing.. which would highlight the
ARM no cpumask bug
2) do the /sys/devices/<pmu>/events/event.(unit|scale|per-pkg|snapshot)
files parse correctly and have a corresponding event.
3) keep adding opening events on the PMU to a group to make sure that
when counters are exhausted the perf_event_open fails (I've seen this
bug on AMD)
4) are the values in the type file unique

Thanks,
Ian

