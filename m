Return-Path: <linux-kernel+bounces-346959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368098CB73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EA8B21E59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687710A1F;
	Wed,  2 Oct 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGU4x91L"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F87C13D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839226; cv=none; b=WXrONS6Jir0aqFhY6h9CFVnWip4A73KbTIjQUnts4dXef5l3DyySq0zozbIY9hKlpE1CYmMpWxwvMsppqERhnLhKyd8wEmAYAx/mr+/crHH6cz/z3rxFtOiZDt6jd/+SSElwk5BdybE5DVASrFCRNQEAxWN5Bvt4LLmvqick60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839226; c=relaxed/simple;
	bh=V8y3LZnpjY3VZKYRV2DBf4Kr3sFE8XrhghZCvXrSxJs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=jYHgE8UZ39yupre4fGAQgIpow4Px6S+v3u6hqKOsZ9ezJ82yBR3x49zSxc44e0lvcIlA0Fpj8v0WQllAr6cIF6/hEdWXixl5+xGFkFeCjnUA7Be7qobwprKsRDxrpwlrTxl6JkBDufaGYctz3qNyRkyXor4io0dJ06vkVsAwMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGU4x91L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fea193a4so112055437b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839222; x=1728444022; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDGs1fNDiXDZH+tZf7c6rF0ubwmNF5v2taHWT742YpI=;
        b=HGU4x91LY7wy2L3g1DsWXHDpNjnbg7VtL3mcfZfNfllHSgkD5X9an6bjHWlJTGSYaM
         zbWpEd/xzyOGEI8T6uORLpDfFzsiOnp8LENKrfjxLZl0FwOd/972FPCJ41njkw8hEUHi
         tkfxzHEenivtzidMMXuOFeWd2tnjfCNKYI231u66V/xqtmkzHTrQT6Gu7q/j5eCWmhx7
         sNdQymupezBM7f4KKoldu7VIyfy3+CD1m/shiew73kqFl8wtydApLFRUYO2eOXXqODoA
         qrirYZsO14tuFO4qcTVirSQRYaXn2x4oEyJQHL7N5F6QjWDQRUg7n+K0rRtMVXpftOn6
         g3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839222; x=1728444022;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDGs1fNDiXDZH+tZf7c6rF0ubwmNF5v2taHWT742YpI=;
        b=Dpm+6eV6oSkzGs+oY3Hczhl0xll7WjZ8YhmMPJkgFP4rAD4ikTVP/w15AFkNlvo5dN
         otdpI5l4xsr0G7dbxogIEVzhrPLLUilo0DdMHfEx56Kf6mfxjIA04+8rquhrw+wyFVPJ
         hNWNDF9Crip/AeE5AaC5MCF829OMfEqc71HweeYUFU8G57QjpJPPzlel+5UDX+ATd9F7
         b/2A9FYgAYExFsDMpOL7//rNqO6xbHNxRrmHHMcIWHNGsp09fBF7h9Q5f6m4MAvNRWop
         xcdae8Ho4TeON6LyIhL/mx0v1xd0ACxPZ5pbjYBYKytJtxHC5pJ5fGi2kArPlb/ZLNm1
         oNOA==
X-Forwarded-Encrypted: i=1; AJvYcCViJ+l+sHnuXojjijzmHI2RKnrCVptTICo+CmsrR3jdo0hYWpD/dIM+atUudUxgy7/RtZxwNxd86PMZFXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNwcR5j5f2QeP/dNak/7bB0zhPO3xArxxHNvBg3yx65zfiSoBj
	vHZseD47Rh6+gRdlX4sU6f7D8WLwc/NeIIJoxamwuVR9DS5MTY14dxHvcfBvSLOnI8vhVIQlBjm
	U39UASw==
X-Google-Smtp-Source: AGHT+IH3DbT0p7Xh6/P8J/+/LYMvMAjnetdrFpdAAb3YJcYjCY7mKmq3zV723z1HE1Al+i4JU+lO91AJpKan
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4988:b0:6dd:bc07:2850 with SMTP
 id 00721157ae682-6e2a3048277mr362907b3.6.1727839222136; Tue, 01 Oct 2024
 20:20:22 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:03 -0700
Message-Id: <20241002032016.333748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 00/13] Tool and hwmon PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Rather than have fake and tool PMUs being special flags in an evsel,
create special PMUs. This allows, for example, duration_time to also
be tool/duration_time/. Once adding events to the tools PMU is just
adding to an array, add events for nearly all the expr literals like
num_cpus_online. Rather than create custom logic for finding and
describing the tool events use json and add a notion of common json
for the tool events.

Following the convention of the tool PMU, create a hwmon PMU that
exposes hwmon data for reading. For example, the following shows
reading the CPU temperature and 2 fan speeds alongside the uncore
frequency:
```
$ perf stat -e temp_cpu,fan1,hwmon_thinkpad/fan2/,tool/num_cpus_online/ -M UNCORE_FREQ -I 1000
     1.001153138              52.00 'C   temp_cpu
     1.001153138              2,588 rpm  fan1
     1.001153138              2,482 rpm  hwmon_thinkpad/fan2/
     1.001153138                  8      tool/num_cpus_online/
     1.001153138      1,077,101,397      UNC_CLOCK.SOCKET                 #     1.08 UNCORE_FREQ
     1.001153138      1,012,773,595      duration_time
...
```

Additional data on the hwmon events is in perf list:
```
$ perf list
...
hwmon:
...
  temp_core_0 OR temp2
       [Temperature in unit coretemp named Core 0. crit=100'C,max=100'C crit_alarm=0'C. Unit:
        hwmon_coretemp]
...
```

v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
v2: Address Namhyung's review feedback. Rebase dropping 4 patches
    applied by Arnaldo, fix build breakage reported by Arnaldo.

Ian Rogers (13):
  perf pmu: Simplify an asprintf error message
  perf pmu: Allow hardcoded terms to be applied to attributes
  perf parse-events: Expose/rename config_term_name
  perf tool_pmu: Factor tool events into their own PMU
  perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
  perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
  perf tool_pmu: Move expr literals to tool_pmu
  perf jevents: Add tool event json under a common architecture
  perf tool_pmu: Switch to standard pmu functions and json descriptions
  perf tests: Add tool PMU test
  perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
  perf test: Add hwmon "PMU" test
  perf docs: Document tool and hwmon events

 tools/perf/Documentation/perf-list.txt        |  15 +
 tools/perf/arch/arm64/util/pmu.c              |   5 +-
 tools/perf/arch/x86/util/intel-pt.c           |   3 +-
 tools/perf/arch/x86/util/tsc.c                |  18 +-
 tools/perf/builtin-list.c                     |  13 +-
 tools/perf/builtin-stat.c                     |   7 +-
 .../pmu-events/arch/common/common/tool.json   |  74 ++
 tools/perf/pmu-events/empty-pmu-events.c      | 208 +++--
 tools/perf/pmu-events/jevents.py              |  16 +-
 tools/perf/tests/Build                        |   2 +
 tools/perf/tests/builtin-test.c               |   2 +
 tools/perf/tests/hwmon_pmu.c                  | 243 ++++++
 tools/perf/tests/pmu.c                        |   3 +-
 tools/perf/tests/tests.h                      |   2 +
 tools/perf/tests/tool_pmu.c                   | 111 +++
 tools/perf/util/Build                         |   2 +
 tools/perf/util/evsel.c                       | 287 +-----
 tools/perf/util/evsel.h                       |  28 +-
 tools/perf/util/expr.c                        |  93 +-
 tools/perf/util/hwmon_pmu.c                   | 818 ++++++++++++++++++
 tools/perf/util/hwmon_pmu.h                   | 154 ++++
 tools/perf/util/metricgroup.c                 |  35 +-
 tools/perf/util/parse-events.c                |  63 +-
 tools/perf/util/parse-events.h                |   5 +-
 tools/perf/util/parse-events.l                |  11 -
 tools/perf/util/parse-events.y                |  16 -
 tools/perf/util/pmu.c                         | 104 ++-
 tools/perf/util/pmu.h                         |   9 +-
 tools/perf/util/pmus.c                        |  16 +
 tools/perf/util/pmus.h                        |   3 +
 tools/perf/util/print-events.c                |  36 +-
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/stat-display.c                |  14 +-
 tools/perf/util/stat-shadow.c                 |  22 +-
 tools/perf/util/tool_pmu.c                    | 506 +++++++++++
 tools/perf/util/tool_pmu.h                    |  56 ++
 tools/perf/util/tsc.h                         |   2 +-
 37 files changed, 2374 insertions(+), 629 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/tests/tool_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h
 create mode 100644 tools/perf/util/tool_pmu.c
 create mode 100644 tools/perf/util/tool_pmu.h

-- 
2.46.1.824.gd892dcdcdd-goog


