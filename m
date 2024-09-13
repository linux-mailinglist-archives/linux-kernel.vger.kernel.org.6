Return-Path: <linux-kernel+bounces-328375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20E5978295
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A671C220B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AF11187;
	Fri, 13 Sep 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12Mc0WLa"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC271EB21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238065; cv=none; b=rv/iK8v2rGjZ6kOqxjy7nfwwZRlFFv+kS0+ej5GrQohV4qcxCR758coaDw3YVvdgSvmlGBQkrLLKxj1X/nLX1nq/kGGTmngI07JOmbDPTZ5nQplFcKQTsQgLh5UGyn9qk+8tI8O7qMS8G6maGjbgVyxvI6rOPEemfTXNOjLzxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238065; c=relaxed/simple;
	bh=tXDYvsm5/pgCdoD4cEGOgtMnCHqcK7M7ztrs02Ixyiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib4212fZP+tq0j5+cVLK4iIoy9l+3vcM2FHIga/+BRJAcuGHnCUaC2w8KVAxkzwl36FIeYaERuLff4gqSksn2rhPqhXpN+VQg0PgeZRfCCbxlEBvUz2vFXiI53IWlFU389R4hNJIh0I+ABKT3+/O6/nNV9tI7SPeW/FrFoszG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12Mc0WLa; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d2a107aebso263445ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726238063; x=1726842863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbnVUXs2u9fVjgW0BH0D/Qh3ezG/C7c4+/OmWD8ndgc=;
        b=12Mc0WLaGfxeKNg6FeaK+TR5HJ01twa9N7RT+hMtdZKIUNKCnXP6M1mZV4wrX6ilXn
         C5hJ4so5XqkDkQPDyH3XOoOlBaJa9H2F9brpw9PWaMn601QvNmkc0IUOJGb/PkVAgfOg
         sz3e/by/iz3F1fJPCIC/DmBFicYdSwyLfR8n2nLG6J0bLXmqSZwpjR71YKcMKg84yp4C
         z5UMYem77aMBAdrovy48iPJfSrjMeT9mojRwkeSD9OghsEyGoaTluyPpevmJf3ywOSUN
         UUVjagnCU8KQj3500mvOq4awhP9julqJLyR4tKIe3mewzuBS3r7hNlUbh5UOpTJsDR0F
         feYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238063; x=1726842863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbnVUXs2u9fVjgW0BH0D/Qh3ezG/C7c4+/OmWD8ndgc=;
        b=GwU56/B9xWBiYWGnLsC1hTVLX870M8kKPJ9WHRKLijGi9vPYE59eVHXm6IDztZXx/Y
         iSfc8mxYorf5Q2t1Z5tO9JOB3w8ty/BPPqmTCvNcU1xEubHYu/TyWTmS+xtOICbPBoNm
         eoY3cG5T2qBOxTLFX4jeCoIfF7uCU+idiS1tYobEGpBbv0UBigj4xUKj47Ya6+nmShrm
         //ocZ0iAn/xp/vQZg1T9+ATBtim+rL5EQitUAdOwwNI0p90aoqSSO0YcaS0qA4yxTP8r
         JkwwSUAVXD7UhC9e2XL80qGwY2YVCbIpG0ljkLxdtOaSl9ok8raMZhTAXvewY8uyZ6ch
         w+PA==
X-Forwarded-Encrypted: i=1; AJvYcCVzPVFt9hMBy01ESJqSa88PU7wHFo1QF+aq0B4GKVqNox0XWHK2gWZoQJit2pQfhqRgcOJzwdPYWQ2WKQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNsA7vLDLmnTBAXOArNsgDddujx22ZZlQt3csTzG/GiKZwBqes
	rixL9dY8WkgTBJHJWSIDLYkdQV3vKwFnnCrlAkqY6D3T6k/qzqjaHZ3ZluYaodz4AAOBNfFjrBZ
	xkh5O3XebGM9TrTulFwSJS8pFY7Z66/MY57Zy
X-Google-Smtp-Source: AGHT+IGmqtoo5SXZTvDqb34i2Qn959kj2jw8I4N0SKJZ9b67tepWb0KauEEm+iS1nOVU/UPBG1v7cpK04RqBfQY+V3Q=
X-Received: by 2002:a05:6e02:1e02:b0:39f:4828:7d7d with SMTP id
 e9e14a558f8ab-3a0856c2fd4mr9742815ab.15.1726238063116; Fri, 13 Sep 2024
 07:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com> <ZuNwJ07GyMVIT0Qi@google.com>
In-Reply-To: <ZuNwJ07GyMVIT0Qi@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Sep 2024 07:34:10 -0700
Message-ID: <CAP-5=fW3MrfOJf=yQgxG-UkKJnoVavda5_4oMh5e4RdkLCJxgw@mail.gmail.com>
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

On Thu, Sep 12, 2024 at 3:50=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Sep 12, 2024 at 12:03:27PM -0700, Ian Rogers wrote:
> > Rather than have fake and tool PMUs being special flags in an evsel,
> > create special PMUs. This allows, for example, duration_time to also
> > be tool/duration_time/. Once adding events to the tools PMU is just
> > adding to an array, add events for nearly all the expr literals like
> > num_cpus_online. Rather than create custom logic for finding and
> > describing the tool events use json and add a notion of common json
> > for the tool events.
> >
> > Following the convention of the tool PMU, create a hwmon PMU that
> > exposes hwmon data for reading. For example, the following shows
> > reading the CPU temperature and 2 fan speeds alongside the uncore
> > frequency:
> > ```
> > $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/=
 -M UNCORE_FREQ -I 1000
> >      1.001153138              52.00 'C   temp_cpu
> >      1.001153138              2,588 rpm  fan1
> >      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
> >      1.001153138                  8      tool/num_cpus_online/
> >      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET              =
   #     1.08 UNCORE_FREQ
> >      1.001153138      1,012,773,595      duration_time
> > ...
> > ```
> >
> > Additional data on the hwmon events is in perf list:
> > ```
> > $ perf list
> > ...
> > hwmon:
> > ...
> >   temp_core_0 OR temp2
> >        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=3D1=
00'C crit_alarm=3D0'C. Unit:
> >         hwmon_coretemp]
> > ...
> > ```
> >
> > v2: Address Namhyung's review feedback. Rebase dropping 4 patches
> >     applied by Arnaldo, fix build breakage reported by Arnaldo.
> >
> > Ian Rogers (13):
> >   perf pmu: Simplify an asprintf error message
> >   perf pmu: Allow hardcoded terms to be applied to attributes
> >   perf parse-events: Expose/rename config_term_name
> >   perf tool_pmu: Factor tool events into their own PMU
> >   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
> >   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
> >   perf tool_pmu: Move expr literals to tool_pmu
> >   perf jevents: Add tool event json under a common architecture
> >   perf tool_pmu: Switch to standard pmu functions and json descriptions
> >   perf tests: Add tool PMU test
> >   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
> >   perf test: Add hwmon "PMU" test
> >   perf docs: Document tool and hwmon events
>
> For patch 1-10,
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> I'll take a look at hwmon patches later, but I think it'd be nice if you
> could split the change into pieces.

Sure, aren't patches pieces? My reason for combining the refactor of
tool events with the addition of hwmon was to motivate the refactor by
a new use-case. I could have done 2 series with the latter dependent
on the first. I'm not sure who wins by 2 patch-set series. There is
extra cognitive load from patches that wouldn't apply cleanly to
tip-of-tree as well as additional work for me.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >  tools/perf/Documentation/perf-list.txt        |  15 +
> >  tools/perf/arch/arm64/util/pmu.c              |   5 +-
> >  tools/perf/arch/x86/util/intel-pt.c           |   3 +-
> >  tools/perf/arch/x86/util/tsc.c                |  18 +-
> >  tools/perf/builtin-list.c                     |  13 +-
> >  tools/perf/builtin-stat.c                     |   7 +-
> >  .../pmu-events/arch/common/common/tool.json   |  74 ++
> >  tools/perf/pmu-events/empty-pmu-events.c      | 208 +++--
> >  tools/perf/pmu-events/jevents.py              |  16 +-
> >  tools/perf/tests/Build                        |   2 +
> >  tools/perf/tests/builtin-test.c               |   2 +
> >  tools/perf/tests/hwmon_pmu.c                  | 243 ++++++
> >  tools/perf/tests/pmu.c                        |   3 +-
> >  tools/perf/tests/tests.h                      |   2 +
> >  tools/perf/tests/tool_pmu.c                   | 111 +++
> >  tools/perf/util/Build                         |   2 +
> >  tools/perf/util/evsel.c                       | 287 +-----
> >  tools/perf/util/evsel.h                       |  28 +-
> >  tools/perf/util/expr.c                        |  93 +-
> >  tools/perf/util/hwmon_pmu.c                   | 818 ++++++++++++++++++
> >  tools/perf/util/hwmon_pmu.h                   | 154 ++++
> >  tools/perf/util/metricgroup.c                 |  35 +-
> >  tools/perf/util/parse-events.c                |  62 +-
> >  tools/perf/util/parse-events.h                |   5 +-
> >  tools/perf/util/parse-events.l                |  11 -
> >  tools/perf/util/parse-events.y                |  16 -
> >  tools/perf/util/pmu.c                         | 104 ++-
> >  tools/perf/util/pmu.h                         |   9 +-
> >  tools/perf/util/pmus.c                        |  16 +
> >  tools/perf/util/pmus.h                        |   3 +
> >  tools/perf/util/print-events.c                |  36 +-
> >  tools/perf/util/print-events.h                |   1 -
> >  tools/perf/util/stat-display.c                |  14 +-
> >  tools/perf/util/stat-shadow.c                 |  22 +-
> >  tools/perf/util/tool_pmu.c                    | 508 +++++++++++
> >  tools/perf/util/tool_pmu.h                    |  56 ++
> >  tools/perf/util/tsc.h                         |   2 +-
> >  37 files changed, 2376 insertions(+), 628 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
> >  create mode 100644 tools/perf/tests/hwmon_pmu.c
> >  create mode 100644 tools/perf/tests/tool_pmu.c
> >  create mode 100644 tools/perf/util/hwmon_pmu.c
> >  create mode 100644 tools/perf/util/hwmon_pmu.h
> >  create mode 100644 tools/perf/util/tool_pmu.c
> >  create mode 100644 tools/perf/util/tool_pmu.h
> >
> > --
> > 2.46.0.662.g92d0881bb0-goog
> >

