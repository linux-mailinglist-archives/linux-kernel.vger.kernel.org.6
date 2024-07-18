Return-Path: <linux-kernel+bounces-256548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D59935011
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F72628142E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187F1448E4;
	Thu, 18 Jul 2024 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzcpdwC0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7112C474
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317175; cv=none; b=G9v7hiiks7CSKj+npajc2YekUa0Pfd77rgs9Xx9CksENUvzHFf2Y2zVNU4sShOm7lOEgEnNRqZeYym6RUNs43akfYf3+7x/a0fHN/ogYnwtLfVXsXbFbISzj9IUbOXaxyUJNXAJ1WxWYZ1qWhwuWUQrGDDu6v7+HsKZFAAy1dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317175; c=relaxed/simple;
	bh=QwDQsw1Igqb7IEeMk767If/DS1y9TVTy0Y2qoJoxu5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quM3SRplRKEpVvQ6eUhrlbQkceAivrFYKXVmCSm+bgJTRQE0RIRMHNqH3s6axFpa5p9tbXqVjGwegQ0s4iprZphfUiMAoF0ZepiB9OKhnVQMMiodMk4NyrSraCxleuo1AFtlQBPwNoP30RTP8NABARYJjuKWhjGgMbyMtLfeI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TzcpdwC0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc4aff530dso235355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721317173; x=1721921973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt0I2KGkrKSNHkYee7uJVlW3OUILFcgKcyGzTxibNPU=;
        b=TzcpdwC0LFXeE7WTIXK+rcGiixonhkFbEBoM4EuinmNHmXnNhyD/U0YjDj31rrWluv
         VVyGK3c/KhSGBRhgTw4/mx5CnLuAWcNZp9y8Y9hxYBe7kIKEFaHJGg19ZNSEd81OmtIG
         bvFefkIgykLR/mrnvlvACqrye43vjy8mHteYdRHupK5It80K4ED9NTAMUdbzmNs3UIng
         1rzauoLO3pw1sv409dQ1tOatgblLIKx6cy8th7xc32o0fELbdVujGKRMBt0R5pzYZeJy
         8icwD6SLxYootYjMfMC02ZUg8RGnAeZS7c5KGZ0EonaTYpmwYxuu6rbP+iUd3B7JzMXY
         47bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317173; x=1721921973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt0I2KGkrKSNHkYee7uJVlW3OUILFcgKcyGzTxibNPU=;
        b=WALJDNK4Z/ye71WOay/q3o1Koc6O5TTcZbL0C1Ha+TYA7fVwHeoovJYo4IB0uonT3x
         JVP3feaFx4lJ5e3X9AYbHzBFXpU6pjwZTGdkWzn2hp6Awch7dgfskNYp2vYigzO/mp6Y
         1+OI1CAYiqcndCc25AlZKrrTn4b9fM5Hm0S+nj5p6APiEWFeo9zppuCRqNVb8DaSVMhQ
         5G1bFFySGjNgRx7FWX1JWBEy1Gho+bNIzYkFFsP16IwY5lW+txn1MJT3vypUsIr3dvih
         jw/o0KbtzxMpXlocRo4wtNtF7tSldaBdiriJxS50KL5J48Vq5y5tN7PTWhP/SzyA19Kw
         sVug==
X-Forwarded-Encrypted: i=1; AJvYcCXfYHyJtbcywu6Cq+ckyrgUcXgiTmo+0yH/bdjNk4M+YIYgvaNvWxKVmfn999TT8ZcLbRf70CcV6LiR2atF0ABagUZ/Vbho6RuDrzmy
X-Gm-Message-State: AOJu0YyKws6J4W+s6H0ABKrnoyXhKH8zebZkIHNpGlFhiDgaNUXJ/MCB
	YMSsQlh/BKu7M6+LKAfAllnPGRgJrKWLqZua/b3Qs/6ra2lMPmwJPfAgOx0JB/Pv5SxVZ61/03W
	J6yRu3IA4sXBTY5hBjHTXTUBKjCtWzh+r4PsP
X-Google-Smtp-Source: AGHT+IEqkM3JV0rVMiSXMzPvq8eeXAkUx1YpQZU7ZziqlnFKKdiNs0GUPa/x2ix7RLH/fMAJwFw1M6Q8WmmE3oMqLaQ=
X-Received: by 2002:a17:902:ea07:b0:1fb:c2c:63c8 with SMTP id
 d9443c01a7336-1fc5f91f58emr2890715ad.12.1721317172520; Thu, 18 Jul 2024
 08:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718003025.1486232-1-irogers@google.com> <20240718003025.1486232-4-irogers@google.com>
 <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
In-Reply-To: <92ceb8b5-240a-4715-98db-c73e8e9d3e50@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:39:21 -0700
Message-ID: <CAP-5=fUfoMZ0HjCNoJe6hgEMi5ciY+LqFjBbLzfiZgO6dioshA@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 7:33=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-07-17 8:30 p.m., Ian Rogers wrote:
> > If an event file exists in sysfs, check if a event.cpus file exists
> > and read a perf_cpu_map from it if it does. This allows particular
> > events to have a different set of CPUs compared to the PMU.
> >
> > One scenario where this could be useful is when a PMU is set up with a
> > cpumask/events per SMT thread but some events record for all SMT
> > threads. Programming an event on each SMT thread will cause
> > unnecessary counters to be programmed and the aggregate value to be
> > too large.
>
> If I understand the scenario correctly, I think the issue should have
> been addressed since ICX, with the introduction of  the "SMT-aware
> events". Is there a specific event which still has the issue on newer
> platforms?

Nothing comes to mind, but it is there on popular machines like Skylake.

> >
> > Another scenario where this could be useful if when a PMU has
> > historically had a cpumask at the package level, but now newer per
> > die, core or CPU information is available.
>
> The traditional way to support new counters with a different scope is to
> add a new PMU.
>
> >
> > Additional context for the motivation is in these patches and
> > conversation:
> > https://lore.kernel.org/lkml/20240711102436.4432-1-Dhananjay.Ugwekar@am=
d.com/
>
> I don't see the advantages of the new event.cpus way.
> The aggregation should be the same.

Agreed. My concern is that we may end up with a pattern of
<pmu>_per_pkg, <pmu>_per_core, <pmu>_per_cpu, <pmu>_per_l3, etc. just
for the sake of the cpumask.

> The RAPL counters are free-running counters. So there is no difference
> whether grouping or not grouping.

Should the RAPL counters return true for perf_pmu__is_software? In the
tool we currently return false and won't allow grouping, these events
with other hardware events. The intent in perf_pmu__is_software was to
emulate the way the kernel allows/disallows groups - software context
events can be in a hardware context but otherwise I don't believe the
grouping is allowed.

> But it makes the kernel driver complex, since it has to maintain at
> least two different cpumasks.

Two drivers each maintaining a cpumask or 1 driver maintaining 2
cpumasks, it seems like there is chance for code reuse in both cases.
I'm not seeing how it adds to complexity particularly.

> The tool becomes complex either, since it has to take care of the
> per-event CPU override case.

I'm not sure I agree with this. What we need for perf_event_open is a
perf_event_attr, we dress these up as evsels which also have the
ability to be for >1 CPU or thread. Longer term I think evsels can
also have >1 PMU, for the wildcard cases like uncore memory
controllers - this would remove the need for resorting evsels except
for topdown events which have thrown us a giant bundle of challenges.
Anyway, so an evsel is perf_event_attr information paired with CPU
information, it makes sense to me that the parser should do this
pairing. What's harder in the evsel/evlist setup is trying to fix CPU
maps up not in parsing, like with __perf_evlist__propagate_maps where
the parsing is trying to leave crumbs around (like system_wide,
has_user_cpus, is_pmu_core) so the map propagation works properly.

> The json file must also be updated to add a
> new field cpumask.

Yeah, I don't like this as it means we end up putting CPU information
into the json that isn't the same for every CPU variant of the same
architecture model. Maybe we can have some kind of "scope" enum value
in the json and then when the scope differs from the PMU's, core scope
vs the PMU's hyperthread scope, then in the tool we can figure out the
cpumask from the topology in sysfs. Maybe we should just always use
the topology and get rid of cpumask files in sysfs, replacing them
with "scope" files. Will Deacon pushed back on having ARM PMUs
supporting hot plugging
(https://lore.kernel.org/lkml/20240701142222.GA2691@willie-the-truck/)
where the main thing hot plugging handler needs to maintain is set the
cpumask.

Thanks,
Ian

