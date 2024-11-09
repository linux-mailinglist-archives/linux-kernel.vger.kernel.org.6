Return-Path: <linux-kernel+bounces-402543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A097C9C28E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F3628199C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643264689;
	Sat,  9 Nov 2024 00:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0WEzDUT"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668B610D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112686; cv=none; b=MJt+B34m5eqEcmgu1Jz7LSRAmGddCnbTaNC42sepVHIOB0XH7Qzo2vh1UiQVa0NTuD+XgYYf3dDvsoQCK2CZ29Tj+MQjCdUG6M8kCSreKLXc/fCZpNBGoykmSFZa6h+mmVlMqKKwsr4A8sXhywdf/aK+hBbpc+yiNdaj+rlLQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112686; c=relaxed/simple;
	bh=B4kA+7GUwjAG4R8+53+QWlaoUwuf9lQWaPAr36cJj/4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=uJsKJoVBwtJt8ZQ9AajCup5u7evOAqKLQclHQQbab0ios4nxQ7En2C0yJTvSVlI0pILrcfAJEqCFa9KC7/3i9XyJ2OeUezwSy6QIJrug/H3rHD7gl9S6S9IheA6cGqt2WHx4SrnTo7sr5HSEwx3kRpEa9D9cKSuAI3v4z4eTOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0WEzDUT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3705b2883so51263227b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112684; x=1731717484; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pe6eRz+3fgdgh5bLi058upJvXtI0NKQM817+wLnFuFU=;
        b=f0WEzDUTXktHsKn3EtePI0jvHm6hRdtTtHY7A35grlzSiArWOw0KhMR72xA71HZ+Ch
         b4joVz3541/dpKF+MjafZIVubIiMFQmdrf+tJFAMVo90984twnmAu+qJdwO3izzugRkr
         3tlZjc1JFK8Jbp7LOXpwfN1cFpEoIeieNZn1N2KY9cMpDC1z14xuCRL5SNcj7EhLMA0I
         aD+gOQ9fvliMbO96Yu4WtdB+qt6mVhjhSrsHrqM6/s17I8mjVXF6OFcNeCsTWPW+oM3A
         SvlYTyp03Ao56CHabqC6v/sE66r2X2GcMJ9P5m71+vZSpJ4RWHMlS+vRurAfAHE73yee
         uAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112684; x=1731717484;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pe6eRz+3fgdgh5bLi058upJvXtI0NKQM817+wLnFuFU=;
        b=EYTngZrDNxZcHeE3krz9dvhPIaW2MwiBqBnGIYwFwAyphHXGegewYk6U5n1pEfMA87
         8N8jBRFwWPoE2XhFHmZFrb4qt3TgytGbAku+PvVaGmz/ph6gEUXkHOQ2fyNMFrIWouKU
         HybgMWXBsUxq3iF0h3xSn191SNgTgbgB83zrSAg4zMBxxoY511xeAkLYDnOM0BMIeSgG
         0JNk0SJMt2VjzT/q4dDTBVDL8pqezF7+t6UytBA6VMdMWAZ+s6OSn9BcxPNn7ZyJZScj
         /b4bWOGqPQ/bDgAYcgNDorct84eh8XCaiOri61JLGvS6xdpWwuOk95grVxxPzFxuQU/Q
         bfEw==
X-Forwarded-Encrypted: i=1; AJvYcCWu4+S/bYdGniHf2DWBTlntjKBsitiRU36aTgJqIoQf2qDRLhe5GNf3Lx7DiZKs9zYquK9NncthRm3eRRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbjsogoXPFN5ujKsCwQCJrggWGeWtsLbyf2drM/3oLJnzxidy1
	fyFtkX75lN0+GtY3+qt1lVpOqMbPfxp1KSoLTjJ5fxfLaTVtZWI3pUDv2yKnx/IZeJBdMzO7jLa
	yMYmkSQ==
X-Google-Smtp-Source: AGHT+IELhMnb61ZKjZrUmSDxAHeNKINx9zqlsQVXecD3xsIB+MM/Uy9K/Atalv/Dc7nuNvKnJbL8hr8m9pXq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:338e:b0:6dd:fda3:6568 with SMTP
 id 00721157ae682-6eaddf7e61emr380247b3.3.1731112684208; Fri, 08 Nov 2024
 16:38:04 -0800 (PST)
Date: Fri,  8 Nov 2024 16:37:52 -0800
Message-Id: <20241109003759.473460-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v9 0/7] Hwmon PMUs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Weilin Wang <weilin.wang@intel.com>, Yoshihiro Furudera <fj5100bi@fujitsu.com>, 
	James Clark <james.clark@linaro.org>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

v9: Missed saving a file.
v8: Fix formatting issues and reduce scope of 2 strings reported by
    Namhyung.
v7: Try to address feedback from Namhyung wrt size/comprehensibility
    of the hwmon PMU patch. To better explain the config encoding put
    the parser into a patch ahead of the PMU patch and add a unit
    test. This shows how a hwmon filename can be moved back-and-forth
    with a config value as a single patch (two with the test). The
    hwmon PMU patch is then putting the wrapping around that for the
    pmus', parse_event's and evsel reading's benefit.
    
    The alternate approach of not caring about the mapping, name to
    config value, and using the evsel->name wasn't followed. In the
    tool PMU it was made so we can go back-and-forth between event
    names and a type+config, this removed the tool enum value from the
    evsel as now tool events were more 1st class and evsel should
    really just be a wrapper on a perf_event_attr. Using the
    evsel->name wasn't doing that and so the approach of mapping
    filenames and configs, as better highlighted in this series was
    pursued.

    It is expected future PMUs won't be able to cleanly map fixed
    strings to config values, in those cases tables would be
    necessary. Making a hwmon PMU do this and then removing it to
    follow the parsing/mapping done in patch 2 here, would have been a
    lot of additional work which then would be removed.

v6: Add string.h #include for issue reported by kernel test robot.
v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
    the update to perf_pmu to use it. Try to make source of literal
    strings clearer via named #defines. Fix a number of GCC warnings.
v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
v2: Address Namhyung's review feedback. Rebase dropping 4 patches
    applied by Arnaldo, fix build breakage reported by Arnaldo.

Ian Rogers (7):
  tools api io: Ensure line_len_out is always initialized
  perf hwmon_pmu: Add hwmon filename parser
  perf test: Add hwmon filename parser test
  perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
  perf pmu: Add calls enabling the hwmon_pmu
  perf test: Add hwmon "PMU" test
  perf docs: Document tool and hwmon events

 tools/lib/api/io.h                     |   1 +
 tools/perf/Documentation/perf-list.txt |  15 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/hwmon_pmu.c           | 340 ++++++++++
 tools/perf/tests/tests.h               |   1 +
 tools/perf/util/Build                  |   1 +
 tools/perf/util/evsel.c                |   9 +
 tools/perf/util/hwmon_pmu.c            | 826 +++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h            | 151 +++++
 tools/perf/util/pmu.c                  |  20 +
 tools/perf/util/pmu.h                  |   2 +
 tools/perf/util/pmus.c                 |   9 +
 tools/perf/util/pmus.h                 |   3 +
 14 files changed, 1380 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

-- 
2.47.0.277.g8800431eea-goog


