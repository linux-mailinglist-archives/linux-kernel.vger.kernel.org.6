Return-Path: <linux-kernel+bounces-191778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEAA8D13F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA241C21CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7903C4D112;
	Tue, 28 May 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIVps9VB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582C1C6B8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874619; cv=none; b=o2yPkfNevGPajYbVfQYGXL/l3/wP5asi9MidayuJFyGwjEZWdP/Wz3/W7HvSzjMjUk+gZoY+D0fUdid8FfyMhxPZoY84wvsffZ3zT3jUU7CkJejLfAVMJNaE94OUDOWbGmbZaMp61/zrATnbslmMTqX+YcQehnkdp+8vpvPw7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874619; c=relaxed/simple;
	bh=eQo7fpXSH2/VBl3tOIUEZ8+BdOR5XuNBrOxdR4BPeTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcqbKXNNOUmrtomlB2AkOjOjH79vV+6jfxCuwWFPXM3bVCs++TOPaaNH/L8q6bnuayiUmoa8nfj3wzKsaSG+s+EBeGWzDxnXOw0vTBWqXdc8lCVYMznoOwX4y7glBXm9GF6txVHk/1BYBsnv34vTDqO5TM/7EItsMjFywc7zYuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIVps9VB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee5f3123d8so316905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716874617; x=1717479417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75+rGi0emkeGBR6hYhmPEgxqM1gN8v0U5aBBRBUhk5g=;
        b=qIVps9VBLd/vduzdQ3RbOR9UPRKyBRscMCDwE8L5F9WVQsr8+pXFoRsRIBe39T1U4V
         JRDhvOI/KnDX7Sk8f/zBJOlLqB8E7451r2yeezpmcW+hhn3+Tj+WvQO7k4qrQwIKl/23
         SxuSBVXuy5xQKenN/mYlvoamkxtdi0NbXOIpL601foRN02bqsrbdn9ZmKO3r0n+QuFGx
         fFVxf38Mz+D3M0XriyxqJQv+hbzWhrfq6TfzGKCEbp7KhgN6fTVOW/lh+JwvLaR7LLlZ
         nXjrAOP/hG1tKyFwApDJ3ux4i63mt5nqcOlji6zLT5vt6araiJAWSe0cm7KYzC4+DgIs
         pE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874617; x=1717479417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75+rGi0emkeGBR6hYhmPEgxqM1gN8v0U5aBBRBUhk5g=;
        b=n1kGYgv/Ju60jCf80LFUwp0245YS7M/tdvt7QfH3rZs2O7jA7dNrxz9OpGhX5cixJV
         5ClzZ6aDhmdX5YT6qfF34ShEPhZ2/m5VHtKkHKzL1g0KPCoB/hwRcDYU7so8bDc5YOVt
         IBxD2XKu0HDbQ/Bu3liaUVULnzm+tkdfE/oYc+ucSv6X4PKiyLhY/0WKZAE04x9SWLH1
         SRqGQPsaCvySNKZrNSaPQgCKmcTCulxLAJCrQzn379cgGpt6nsvzy2+HsU5Mb3vy8arC
         FlxWCPmq+4ZLMRAMltabiyMX9pt/uygNvI/lnSSs1Lh1zgzSWVipHymY3qPKXprUPyBp
         edSw==
X-Forwarded-Encrypted: i=1; AJvYcCVKsbEB3OKIuUUdVOtgAhm1k1RTX/+bG2FDuD2rjYqiSjOcYgiYrOb71ElS9o/f8yTDcClf2kBedRztxsVTnvk2LJXoOKOGV1q5Jgci
X-Gm-Message-State: AOJu0YxKRWRM0IMtHZzHQxzYovrD7WZthMtO8miBFh2piPvau/EjK4mv
	yBachBx8PeprBGmEJM1S77PbWF0bpzOttooYAU8V+HEga2u5VS/M3GBGIHgTbXnzdjLWYpgUvKk
	3/UP2rZHQixj0+BumLMLvCXG82TUDpgpdj/WVxFWieisg+cu+gjssAyY=
X-Google-Smtp-Source: AGHT+IHX/t9arYlqMjK6W2gmxkPqPjC17Br5DPL8qK96kwXGF/dijCqCM6aAyNdW07u5PbUS/gLdVfk4lseV1plwUeQ=
X-Received: by 2002:a17:902:a515:b0:1f4:97f5:d9d6 with SMTP id
 d9443c01a7336-1f497f5db8dmr2472715ad.3.1716874617141; Mon, 27 May 2024
 22:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com> <20240527105842.GB33806@debian-dev>
In-Reply-To: <20240527105842.GB33806@debian-dev>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 May 2024 22:36:45 -0700
Message-ID: <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Leo Yan <leo.yan@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:58=E2=80=AFAM Leo Yan <leo.yan@linux.dev> wrote:
>
> On Sat, May 25, 2024 at 02:14:26PM -0700, Linus Torvalds wrote:
> > On Sat, 25 May 2024 at 09:43, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > This makes 'perf record' work for me again.
> >
> > Oh, wait, no it doesn't.
> >
> > It makes just the plain "perf record" without any arguments work,
> > which was what I was testing because I was lazy.
> >
> > So now
> >
> >     $ perf record sleep 1
> >
> > works fine. But
> >
> >     $ perf record -e cycles:pp sleep 1
> >
> > is still completely broken (with or without ":p" and ":pp").
>
> Seems to me that this patch fails to check if a PMU is a core-attached
> PMU that can support common hardware events. Therefore, we should
> consider adding the following check.
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 30f958069076..bc1822c2f3e3 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1594,6 +1594,9 @@ int parse_events_multi_pmu_add(struct parse_events_=
state *parse_state,
>         while ((pmu =3D perf_pmus__scan(pmu)) !=3D NULL) {
>                 bool auto_merge_stats;
>
> +               if (hw_config !=3D PERF_COUNT_HW_MAX && !pmu->is_core)
> +                       continue;
> +
>                 if (parse_events__filter_pmu(parse_state, pmu))
>                         continue;
>
> To be clear, I only compiled this change but I have no chance to test
> it. @Ian, could you confirm this?

Hi Leo,

so the code is working as intended. I believe it also agrees with what
Arnaldo thinks.

If you do:

$ perf stat -e cycles ...

and you have

/sys/devices/pmu1/events/cycles
/sys/devices/pmu2/events/cycles

The output of perf stat should contain counts for pmu1 and pmu2. Were
the event 'data_read' or 'inst_retired.any' we wouldn't be having the
question as this has always been perf's behavior - changing that
behavior would be a regression and why we can't just limit wildcard
searches to core PMUs.

The issue is about legacy events. There are more potential legacy
names than those in 'enum perf_hw_id' as there are all the hardware
cache events. So ignoring "hw_config !=3D PERF_COUNT_HW_MAX" when adding
an event to >1 PMU is only a partial solution, but I (and I think
others agree) don't think legacy names should be special in this way.
If you ask for an event and multiple PMUs advertise it then the
behavior should be to count the event.

Linus' trouble stems from cycles being used as a default value without
restricting it to core PMUs. This patch solves that. There is then the
issue that if an event that doesn't support sampling is wild card
matched by `perf record` then it should be ignored. I'm in less
agreement here, such events failing could be regarded as a feature.
The workaround is to add the PMU name when specifying the event. If we
do allow such events to be skipped, should the skipping be accompanied
by a warning? Presumably if no events can be opened then things should
terminate. Restricting everything to the core PMU I think is
short-sighted as knowing what's happening on accelerators is
increasingly important.

For the sake of fixing TMA metrics and things like default attributes
for ARM I added a notion that evsels in perf stat can be skippable.
The plumbing for this with perf record is more tricky as the logic has
half migrated into libperf - parsing and skippable are in perf, the
event opening and mmap logic is all in libperf, and we need to add
ignoring skipped evsels when adding the events to the mmap-ed ring
buffer. I have a patch that's WIP for this, but I also think we could
also agree that when >1 PMU advertises an event, perf's behavior when
matching should be to open all such events. You avoid this by
specifying a PMU name.

Thanks,
Ian

> Thanks,
> Leo
>
>
> > So no. That still needs to be fixed, or the whole "prefer sysfs/JSON
> > by default" needs to be reverted.
>
>

