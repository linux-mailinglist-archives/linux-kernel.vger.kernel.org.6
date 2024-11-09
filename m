Return-Path: <linux-kernel+bounces-402533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA749C28DB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C27281519
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6985BD517;
	Sat,  9 Nov 2024 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kX1AoFgo"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1B8F5C
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731112444; cv=none; b=FIfpxsqjudkaPB/SGX1lyR0VPK+tLAy65zvB5aoefmuZql2PSdPxl+ezcvY7+X1BDKDUDb6x0oxNaxZHLiOzSa2WJ9UJlG2SF28oWh2x7wpBGU3X0/rOE5mC33pQA42XfqHe3c97v+RoUdafpHvvVCEPhcPHa3Ud7HAknriAkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731112444; c=relaxed/simple;
	bh=V47dQdQkQL22+HC7w9YeCiv6RI21vZ8y6uGJAjPcFqE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=WOCZGVIBhBiPYt8YgRYhH3bLpApAa6IZcViwEte6VvhlEOBcrgeWdxHnhnPzplDHAbKXFeb7qOF/R0hIYP3NsPgv8dPnir61H7vgq1d9OgBO6s/Md+tCqIPL/sFw/FhCncaBbI/wVC/ai6L8+FYCbOCRKQLtNSVwmeXpg+MjMus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kX1AoFgo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so4943749276.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731112442; x=1731717242; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2ZEDYkxzsG0qUhyE9JYNgXfUbc0ZpS2I+xfFPhpZ/t0=;
        b=kX1AoFgo7L1T40YeDmg428jpA0R0DJlMUBBGOLF5yWCw6eG7caYDPL7m5mzC6u+x1b
         x8gTidsn1lPIdw626uNs/iPwWjC8hZS+bsEUtMfQcPmcCvIFx+Jd5DqmCCWDEvwy2/BV
         EF0zXH0Tjb9+5Wo5Y5j70SRrNkEap9N3nNKADMWu4G6/3W/1jG++9erqgswiT94nWK/T
         8k4aXKWL0eeewwnL4U/6Czg06Uhh9qECHbo5aVCzA1bfrC4xDroYFkY7R6UohUzMktWO
         MaG6nO6T2ODObYpl56M2tvQSNqfWVUidGy6/q+qpu92UQG7Rfj+7eDyKKuIVLAl9Kann
         zSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731112442; x=1731717242;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ZEDYkxzsG0qUhyE9JYNgXfUbc0ZpS2I+xfFPhpZ/t0=;
        b=prx2EDYbp4l8i27vV8QsrswSRFHPIEJcecQMSNwY+ADUQ8yQAp8uBPGTiYg+LMv4Rp
         B3s46ZM5RE2VuczN7U09HWhDKtm+FAobziSwoPqDksDDcU4GIIhlDxfLd1eAOrt7oNnX
         EDWAIPwAPxD3aO8FQwDPoRqgzN84CkPZHaPkh/qn6VVDBZEpU2j8vpA3qi8hN8YUdmL9
         J9cq9eLMZYAq1QIDz2Bh3iC9jkVvYCPJyAf0oUOupVsj/KVi8GdThawYLC/MkHeAhxoQ
         hCi2BNxpu9OeRQQhiDhHGlxKgOVSndMujT2FhOc0sH4pjyB4pUAaKatluhKGMy629utQ
         aHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV74BjVYlGRYmbiynlgtPzG5fij6nlYbnczy3oHkBBHjRCj/asOqAOtp6MiKUN1vo65dXuQW7g87Lgn46o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaBsiyiZKW4lVPGYktYJHZCOeLaxxdjzeT7bylL/O7rSF0Bf7
	SWcpUTNzO1FCsk7sslXaxTEIre2b49xQsMIod8TSpt6IbpnAzrVRHiHakuL7/6R5c2Tk+SyuMgz
	pUvEICg==
X-Google-Smtp-Source: AGHT+IGqdbWcUfasjGel99/viEVPGvhC8W4vacrG9Ai+t4388gVHqj3i/Sz9pa2KAfoWC9PzJ/JUopGKrcH5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:d8d1:0:b0:e29:1893:f461 with SMTP id
 3f1490d57ef6-e337f78051fmr12617276.0.1731112442088; Fri, 08 Nov 2024 16:34:02
 -0800 (PST)
Date: Fri,  8 Nov 2024 16:33:51 -0800
Message-Id: <20241109003358.461437-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v8 0/7] Hwmon PMUs
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
 tools/perf/util/hwmon_pmu.h            | 156 +++++
 tools/perf/util/pmu.c                  |  20 +
 tools/perf/util/pmu.h                  |   2 +
 tools/perf/util/pmus.c                 |   9 +
 tools/perf/util/pmus.h                 |   3 +
 14 files changed, 1385 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

-- 
2.47.0.277.g8800431eea-goog


