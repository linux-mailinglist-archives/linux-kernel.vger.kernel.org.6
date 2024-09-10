Return-Path: <linux-kernel+bounces-322309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67ED972714
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2451C23156
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE0143875;
	Tue, 10 Sep 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1nOSnKR"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F91420A8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725934920; cv=none; b=Nawjbo1SJy3OJw8N2Osg7kTV7+ikbesStMCOs8Ms6QeUFzEr14hDidIhhOC97Dm7aFqYGy8/vu7l1nw/x71ozxJ+A+IHnmYAhvnEzE5HSpCQ0muSVy3Cls47fn35owMjLK+CCttbiVojgim9+57Kn7SkgOiB/FVyL1x3KyXWgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725934920; c=relaxed/simple;
	bh=wMv/5mkSpSB8nny/LLg6Vv3YXpQBvQ1wfYGfTWtG4ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=sCoyr5WdfiCJmfwFANPsRGRA1cXwl3muReoOWtgjpCZ4EkaJOgBRHjTlG5IoQmJD+mqysrwC6RDx1hS9/YJPnz/luYeNx3iQPz/YHQEKjSJPjZzMkH1JGMX51KXHVs2r2jQHtzSwsLI4d/tWonLSf/OBswvMePUKBCj0dvFYVsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1nOSnKR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206fee0a3d7so90555ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 19:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725934918; x=1726539718; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNKqm1Gou4dxqPlWF393GfU9Nyen2m4ocGQhCKlYTaA=;
        b=c1nOSnKRS6xaCoWkSMg6jbQd5/JDhrRAFzC9m1e/tx5ov++rFr898sPPRlpp/YBCcv
         l4n/Jt5ENpl+Tf2jch05EfcXdzkabAPg5ZhKcyu0t+/sjyN95mJ0gMz09lUInCMZWlkg
         p/FzARw4QBuKQ57ALI7ZLBV/p5S9DQeiwvBdQm18D4HQhV+L9daLtoj5+8yi47/FJi83
         l//hpmebHpiEiw7YGXO0/fgOkhCFlts1SLQGPg9F19t5QRAhqzN0LSEYolejGbIExQek
         9EF2xf7Nx+88trfJQqxesa1aZ8iPSkYcX7l3m9XxlWSUDaakcj4rMUN3adVA0OHY00gu
         eSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725934918; x=1726539718;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNKqm1Gou4dxqPlWF393GfU9Nyen2m4ocGQhCKlYTaA=;
        b=dSTm/iPnVh38G+prOTsN5H6gc6Licr+lKrvIzdy3YUeyPT6PERM8+xZ3jgs3kwBSV6
         MrhB25/jg8gUUjoBUMLdE3CX1nVZRsWqXLe1cfiByXF1TSKx3jHZRMX/8ErD6Vvlxjgn
         UnRiGN+Zo4oJBJYx2ysgnRHdoxcDsfDZPrf6kSrps1wDnI5S9VyPdOT6xoI1Wi/bQvv4
         VA5uEI8YzGXaNeqFsrrE6YIn0kMm3YY8HNpjd3AfBigqyazLeaKxZJ1iJgIJB91OrthG
         oMCPAzpYpI7+B9qU/wBkdT9GuWQBlGdgFPW1UvBxSxcA0U4oF0r+2Z1qwuYwQNzL24Uu
         L1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWksIre7VqkTk3yqf+0xhORtZ1l04J3zEaoPsoVFf1idNOgQYQSy0RImjAQkkGchI3DBub1hQYbmf98rpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7/23A8/A1fHofJARDV8Xh7Gd6//vOfUrO3BZHPywrMo6jvYN
	0Oyzw+KAtJCx0mKf0Zm+XxnUaMCqp1q0EsxXsvIJ2e3cxjwJ7yo5Ut0/CwlSpC1T3j0kOXehVmD
	HVz347Kr04AkTFGkoBl9WeoH2oCPeSbjUp32n
X-Google-Smtp-Source: AGHT+IHRCrtegyhxPtfWTbGZtTaDy4cnaHw17KvJmkcetjyy+cs48cAi0j6Wr0XZKTiZR11YdECEtiIqBtNdOKQR3So=
X-Received: by 2002:a17:902:e84f:b0:205:753e:b49d with SMTP id
 d9443c01a7336-2074499a58fmr1488945ad.0.1725934917371; Mon, 09 Sep 2024
 19:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Sep 2024 19:21:36 -0700
Message-ID: <CAP-5=fXihU0VH5T=59dZAUo4Qe=c5UAURUnFTuvfai+qs4XSCg@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] Tool and hwmon PMUs
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Junhao He <hejunhao3@huawei.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 10:08=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Rather than have fake and tool PMUs being special flags in an evsel,
> create special PMUs. This allows, for example, duration_time to also
> be tool/duration_time/. Once adding events to the tools PMU is just
> adding to an array, add events for nearly all the expr literals like
> num_cpus_online. Rather than create custom logic for finding and
> describing the tool events use json and add a notion of common json
> for the tool events.
>
> Following the convention of the tool PMU, create a hwmon PMU that
> exposes hwmon data for reading. For example, the following shows
> reading the CPU temperature and 2 fan speeds alongside the uncore
> frequency:
> ```
> $ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -=
M UNCORE_FREQ -I 1000
>      1.001153138              52.00 'C   temp_cpu
>      1.001153138              2,588 rpm  fan1
>      1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
>      1.001153138                  8      tool/num_cpus_online/
>      1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                =
 #     1.08 UNCORE_FREQ
>      1.001153138      1,012,773,595      duration_time
> ...
> ```

+linux-hwmon@vger.kernel.org as a heads up.

Thanks,
Ian

> Additional data on the hwmon events is in perf list:
> ```
> $ perf list
> ...
> hwmon:
> ...
>   temp_core_0 OR temp2
>        [Temperature in unit coretemp named Core 0. crit=3D100'C,max=3D100=
'C crit_alarm=3D0'C. Unit:
>         hwmon_coretemp]
> ...
> ```
>
> Ian Rogers (15):
>   perf list: Avoid potential out of bounds memory read
>   perf pmus: Fake PMU clean up
>   perf evsel: Add accessor for tool_event
>   perf pmu: To info add event_type_desc
>   perf pmu: Allow hardcoded terms to be applied to attributes
>   perf parse-events: Expose/rename config_term_name
>   perf tool_pmu: Factor tool events into their own PMU
>   perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
>   perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
>   perf tool_pmu: Move expr literals to tool_pmu
>   perf jevents: Add tool event json under a common architecture
>   perf tool_pmu: Switch to standard pmu functions and json descriptions
>   perf tests: Add tool PMU test
>   perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
>   perf docs: Document tool and hwmon events
>
>  tools/perf/Documentation/perf-list.txt        |  15 +
>  tools/perf/arch/arm64/util/pmu.c              |   5 +-
>  tools/perf/arch/x86/util/intel-pt.c           |   3 +-
>  tools/perf/arch/x86/util/tsc.c                |  16 +-
>  tools/perf/builtin-list.c                     |  15 +-
>  tools/perf/builtin-stat.c                     |   7 +-
>  .../pmu-events/arch/common/common/tool.json   |  74 ++
>  tools/perf/pmu-events/empty-pmu-events.c      | 208 +++--
>  tools/perf/pmu-events/jevents.py              |  16 +-
>  tools/perf/tests/Build                        |   1 +
>  tools/perf/tests/builtin-test.c               |   1 +
>  tools/perf/tests/parse-events.c               |   4 +-
>  tools/perf/tests/pmu-events.c                 |  12 +-
>  tools/perf/tests/pmu.c                        |   3 +-
>  tools/perf/tests/tests.h                      |   1 +
>  tools/perf/tests/tool_pmu.c                   | 111 +++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/evsel.c                       | 287 +-----
>  tools/perf/util/evsel.h                       |  23 +-
>  tools/perf/util/expr.c                        |  93 +-
>  tools/perf/util/hwmon_pmu.c                   | 879 ++++++++++++++++++
>  tools/perf/util/hwmon_pmu.h                   |  30 +
>  tools/perf/util/metricgroup.c                 |  45 +-
>  tools/perf/util/parse-events.c                |  92 +-
>  tools/perf/util/parse-events.h                |  13 +-
>  tools/perf/util/parse-events.l                |  11 -
>  tools/perf/util/parse-events.y                |  16 -
>  tools/perf/util/pmu.c                         | 108 ++-
>  tools/perf/util/pmu.h                         |  17 +-
>  tools/perf/util/pmus.c                        |  25 +-
>  tools/perf/util/pmus.h                        |   1 +
>  tools/perf/util/print-events.c                |  36 +-
>  tools/perf/util/print-events.h                |   1 -
>  tools/perf/util/stat-display.c                |  14 +-
>  tools/perf/util/stat-shadow.c                 |  24 +-
>  tools/perf/util/tool_pmu.c                    | 508 ++++++++++
>  tools/perf/util/tool_pmu.h                    |  56 ++
>  tools/perf/util/tsc.h                         |   2 +-
>  38 files changed, 2116 insertions(+), 659 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
>  create mode 100644 tools/perf/tests/tool_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.c
>  create mode 100644 tools/perf/util/hwmon_pmu.h
>  create mode 100644 tools/perf/util/tool_pmu.c
>  create mode 100644 tools/perf/util/tool_pmu.h
>
> --
> 2.46.0.469.g59c65b2a67-goog
>

