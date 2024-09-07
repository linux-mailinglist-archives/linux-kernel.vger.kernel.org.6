Return-Path: <linux-kernel+bounces-319637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6AA970015
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04AFCB238D8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0D4F5FB;
	Sat,  7 Sep 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEnNCLDP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0D18638
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685723; cv=none; b=r6fwrh+vLJiQelH2fsKA/5Ba1Dv6RJBsN4yzNpULsUYEc3qImqZnkapVR9eteb9Vl2s8v7t10ZlwDNJjROC7znRtrP9tlTwgzRKIheq0Hkyv2SLpVecRDL3Ax7w8Gchgsrnvg5e4fDeV0GKpxwA+4aYUL5ox2C+e8C6WZ/LPEdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685723; c=relaxed/simple;
	bh=b79+BprO4QGE5EqU0FpHXTwcGOEkBjsjG6OjEIAxY8U=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Cai9iOfan1jmKkE5UQgvQ1UaSQq/KxRpG4PbglZ+N0a4cIo2MQaUKL2Zryypq5lTT06iEgSjh7eEZFty6epP0+LMSaIhR31cfCCNqTTkki3reV6RYk5GLtRQEYsNq75NxUXXx6YPTylec1LAYx+2q1LoL8X5pMZBOZiGtliKsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEnNCLDP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d7124939beso86709637b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685720; x=1726290520; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LHcvOjafmqzQD8jBi1RccAQdk8Mr4rwIBj8z7AkCRow=;
        b=UEnNCLDPQY8pokbINCsbwPlqlA9EVIzeeEA6J4gJTRyfWZdUBPt+nbM3gXX5m/mtiH
         XiIQFWlBr7f28X2wO7GD4jmNiA4x46Y7K5q66VNIi6K/UfMffqeFitT41W2gbrGmbJiF
         +G7aZSsXbrC35jDtWvZPY1wSkQsIVozhPj4eKiuz7GaOaSUwcEobLSma1gpmu+vPilbz
         4w/BQveia0rBDpi2RYvmsS8mS9k/ZULBEp/gOU8XqbC0ql752Uc4pfQ5TEBTIUaTqjdM
         e8bf5aiwCr2eweUuShFJikDcdxVvf4GMJRyTaMKXJUo77Vh5kBU5NOFHMGOVDq2YPqIs
         Q8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685720; x=1726290520;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHcvOjafmqzQD8jBi1RccAQdk8Mr4rwIBj8z7AkCRow=;
        b=DPA8ZOlK8RGDVo/RUZanJF2Si/elnO2aBrURqwAL1sYAJ1S6+dVkBc98s82cpRn4GP
         4m7XNnXk2WRZp+XG7jcvwoUbr9sFFqmdPR7RWdLJDAOWxNAhwVuQqFV5LzvqXJgqN15E
         xGMPVaJrPMCLvLakmNnu0GgFPUQ9bXCq2OUObIKjKkbY3KoXkvvBy53mANVPqE9qEtxs
         nmFh7KGcWuzvGgk+Y5k2VQDasUrb4tKaVuPOcYpMqQr+jooFPXIRT/BrlQ7h0weYGMTr
         iAGbuFpIYpIlXrtQ259Mj6j53R+L5oOolteyydK5FiGstpHH9dZhaV7a776P1EPt379e
         N25g==
X-Forwarded-Encrypted: i=1; AJvYcCUiwausblw+72vogVUOI/0ADzHqZ0Zd7Bb6LoxCzVK9YVU6ErlicBy57u56QSlhToXxGacHskoM1EAdjtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7GtBTpSUDKp65jEwiaxXiQNqUym09FopXtj1/9Rx0LX5FMeu5
	T7oZ9H1joko5pGGOXiLeJgHR+lmNykpSv/hR6bwseq4dHjSb5kGZPiJ9c6Da7QqHBgZOYDv5nm7
	3Poqjng==
X-Google-Smtp-Source: AGHT+IEtgAgfvs12M62wi88Td4qZurVos4yaA4Bgge34jqEggk4Uvx3mHSsHiWJcAnGgvQwiFrblT6CG66LM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a25:268d:0:b0:e11:ade7:ba56 with SMTP id
 3f1490d57ef6-e1d34a38a43mr56558276.7.1725685720434; Fri, 06 Sep 2024 22:08:40
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:15 -0700
Message-Id: <20240907050830.6752-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 00/15] Tool and hwmon PMUs
From: Ian Rogers <irogers@google.com>
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
	Andi Kleen <ak@linux.intel.com>, 
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

Ian Rogers (15):
  perf list: Avoid potential out of bounds memory read
  perf pmus: Fake PMU clean up
  perf evsel: Add accessor for tool_event
  perf pmu: To info add event_type_desc
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
  perf docs: Document tool and hwmon events

 tools/perf/Documentation/perf-list.txt        |  15 +
 tools/perf/arch/arm64/util/pmu.c              |   5 +-
 tools/perf/arch/x86/util/intel-pt.c           |   3 +-
 tools/perf/arch/x86/util/tsc.c                |  16 +-
 tools/perf/builtin-list.c                     |  15 +-
 tools/perf/builtin-stat.c                     |   7 +-
 .../pmu-events/arch/common/common/tool.json   |  74 ++
 tools/perf/pmu-events/empty-pmu-events.c      | 208 +++--
 tools/perf/pmu-events/jevents.py              |  16 +-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/parse-events.c               |   4 +-
 tools/perf/tests/pmu-events.c                 |  12 +-
 tools/perf/tests/pmu.c                        |   3 +-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/tool_pmu.c                   | 111 +++
 tools/perf/util/Build                         |   2 +
 tools/perf/util/evsel.c                       | 287 +-----
 tools/perf/util/evsel.h                       |  23 +-
 tools/perf/util/expr.c                        |  93 +-
 tools/perf/util/hwmon_pmu.c                   | 879 ++++++++++++++++++
 tools/perf/util/hwmon_pmu.h                   |  30 +
 tools/perf/util/metricgroup.c                 |  45 +-
 tools/perf/util/parse-events.c                |  92 +-
 tools/perf/util/parse-events.h                |  13 +-
 tools/perf/util/parse-events.l                |  11 -
 tools/perf/util/parse-events.y                |  16 -
 tools/perf/util/pmu.c                         | 108 ++-
 tools/perf/util/pmu.h                         |  17 +-
 tools/perf/util/pmus.c                        |  25 +-
 tools/perf/util/pmus.h                        |   1 +
 tools/perf/util/print-events.c                |  36 +-
 tools/perf/util/print-events.h                |   1 -
 tools/perf/util/stat-display.c                |  14 +-
 tools/perf/util/stat-shadow.c                 |  24 +-
 tools/perf/util/tool_pmu.c                    | 508 ++++++++++
 tools/perf/util/tool_pmu.h                    |  56 ++
 tools/perf/util/tsc.h                         |   2 +-
 38 files changed, 2116 insertions(+), 659 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
 create mode 100644 tools/perf/tests/tool_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h
 create mode 100644 tools/perf/util/tool_pmu.c
 create mode 100644 tools/perf/util/tool_pmu.h

-- 
2.46.0.469.g59c65b2a67-goog


