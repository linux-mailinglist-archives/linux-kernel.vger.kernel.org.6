Return-Path: <linux-kernel+bounces-340978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD7A9879BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D2A1F2353C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D479175D5D;
	Thu, 26 Sep 2024 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yh/IrXzu"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225515AD96
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380063; cv=none; b=Y8zshZ/m6tx/OOscvplJoBWJa5I7hJ27ZbWHkEXVBsma6O8H8kx2AmYPawjc+wCRGkIbfHo8UDVWkjcLiddAFN6Cf7v1UR0omGyRdjKsfltHbv537WduYKB3nb2+Qa/DB1if/wF2U3z5vCsEbbvGLQJvJj9i9UZoi7u0WR+iGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380063; c=relaxed/simple;
	bh=OpdobiaGJFsmzqwmWBmY8ufHrVW3++B4wWy6CDvPzaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/9MOHleFOwk+CqS74LS3q431SA/vY0tkEzE1a/4JSXIhY8VEjvnSB1bEdRyquVj/V3bUgbt6oD9sT1e/QFqzr1EUxHQHqUGMC4wssDqF4Z1HxbF4Rr9xdPfC83Xbk3kqimLvpkWgWNLXuMWr/ytAmT6GX1dUx/30FZbXikDJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yh/IrXzu; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4581cec6079so66141cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727380060; x=1727984860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l2ZmMYvrEcnOZf47Vq9a28fJ0BtZT2mBNCMtDWME2s=;
        b=Yh/IrXzuHcyJO9pbzCPuQEA5L1Fwf9vKoWM+fOvF2UE8q/0gCIK3stEzdCbV2KK7kc
         bhq69wcAP3eVQUpVaF4KJUomGMydvv9zbMOmAEyqa2aXoJbNlYW5fCdvvHedxf2lHa+8
         fGTjM5xMbfCuBSZN8Hhbix29aCGc4DzHqVaeeIxKzm7CZ6cp1QkfceZZjImOwjFv8H8g
         uD9Eo3B9x9b+mYPTE1ak1CVeaMYfs36M9iEwbSbYH1QdypjuXCrnVVmTthx4ohWyxeq7
         dnd+4uVJZkgCAcJZN71+2VhEJd+NCjYRBbykRN5KbuhS3ZU8oKv6ATataPGeLFUoG+aV
         ULmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727380060; x=1727984860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/l2ZmMYvrEcnOZf47Vq9a28fJ0BtZT2mBNCMtDWME2s=;
        b=K63MxjdERp9XpMiRJ/aFhBKdFhQWfvcyrIsNdCdo1AoWX/d9P1csFaC9ZhZ4ouqvb4
         nHFNtKm16b8eYTwwtxwBKng6+20jKl4gOvOQcUTvOrm3n+nMU39itMAgCpcPaFHVVb36
         f9t+PHWZdzdr+fQouPDi1n4Z9h2aoLjfmoZ3gYxGc0bNLCSjuhysMllI+GNodXi0ImEQ
         MgB6dcJdVF8uO+tKAxzyUm7EyvdQF/HDk8q0ejjW+LOqTYwa1pS9AMlwSEgU09sXMsYm
         0bYQUzrFxxKW3hps3Uj4p09DKMcuz66u406Dxut+AbU3jC+x5EiGOImpULPyLbuSnY4x
         tHgw==
X-Forwarded-Encrypted: i=1; AJvYcCV0sUBnw4q4LTRz4NqyBfdM9FHePIDZoDbv9OB2QhzJdHkL7ZpT6A06sZRL102G2eAGPphT6HWt0tdYVu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGHmu6jhQRt0A/3gWHe4+bX+QizMFIQANOpevoIVOx6BkhOrT
	HmqmMFE4xUAfneEvOebrSbZ1anjcir9gmmuwMD+hggNEUi/TCpDuo5mz8VFyyjXWR24Bu4iUZsi
	q2hy0bcG0hWR/N+sJSpmx/ViqO+ix3hXwmvea
X-Google-Smtp-Source: AGHT+IELdLdzrIUeQYOm8qqxy378MyWwf4r+N0EorvnRAGn6DI4pHLTLiIdWSk3uPqWIwIiVcpPhXMLr9+7aIqfcmo8=
X-Received: by 2002:a05:622a:a313:b0:453:5961:b880 with SMTP id
 d75a77b69052e-45ca018d829mr575351cf.10.1727380060084; Thu, 26 Sep 2024
 12:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com> <ZuNwJ07GyMVIT0Qi@google.com>
 <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
In-Reply-To: <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 26 Sep 2024 12:47:26 -0700
Message-ID: <CAP-5=fX3jXPiFhY+Neo8imz7V=86WDtjM42Gcq5phe6LoCLMkA@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Tool and hwmon PMUs
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, Andi Kleen <ak@linux.intel.com>, 
	=?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 7:34=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Sep 12, 2024 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > > Rather than have fake and tool PMUs being special flags in an evsel,
> > > create special PMUs. This allows, for example, duration_time to also
> > > be tool/duration_time/. Once adding events to the tools PMU is just
> > > adding to an array, add events for nearly all the expr literals like
> > > num_cpus_online. Rather than create custom logic for finding and
> > > describing the tool events use json and add a notion of common json
> > > for the tool events.
> > >
> > > Following the convention of the tool PMU, create a hwmon PMU that
> > > exposes hwmon data for reading. For example, the following shows
> > > reading the CPU temperature and 2 fan speeds alongside the uncore
> > > frequency:
> > > ```
> > > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_onlin=
e/ -M UNCORE_FREQ -I 1000
> > >      1.001153138              52.00 'C   temp_cpu
> > >      1.001153138              2,588 rpm  fan1
> > >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> > >      1.001153138                  8      tool/num_cpus_online/
> > >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET            =
     #     1.08 UNCORE_FREQ
> > >      1.001153138      1,012,773,595      duration_time
> > > ...
> > > ```
> > >
> > > Additional data on the hwmon events is in perf list:
> > > ```
> > > $ perf list
> > > ...
> > > hwmon:
> > > ...
> > >   temp_core_0 OR temp2
> > >        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=
=3D100'C crit_alarm=3D0'C. Unit:
> > >         hwmon_coretemp]
> > > ...
> > > ```
> > >
> > > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> > >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> > >
> > > Ian Rogers (13):
> > >   perf pmu: Simplify an asprintf error message
> > >   perf pmu: Allow hardcoded terms to be applied to attributes
> > >   perf parse-events: Expose/rename config_term_name
> > >   perf tool_pmu: Factor tool events into their own PMU
> > >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> > >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> > >   perf tool_pmu: Move expr literals to tool_pmu
> > >   perf jevents: Add tool event json under a common architecture
> > >   perf tool_pmu: Switch to standard pmu functions and json descriptio=
ns
> > >   perf tests: Add tool PMU test
> > >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> > >   perf test: Add hwmon "PMU" test
> > >   perf docs: Document tool and hwmon events
> >
> > For patch 1-10,
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>

I thought the plan was for 1 to 10 to be in v6.12 and the remaining 3
to be in perf-tools-next/v6.13. I'm not seeing any of the series in
perf-tools so should everything be going in perf-tools-next?

Thanks,
Ian

