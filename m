Return-Path: <linux-kernel+bounces-402149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE889C246E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632681C212B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2821B45B;
	Fri,  8 Nov 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pihR1srr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882A1A9B28
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088190; cv=none; b=Kk+/NY9E4N63eYNwPxepJBRyfiQe0n3pC1SOTjDGxNmxfieof78mcZB3hwbXN5uKxa1Lca4Kge74LP7SFAG3bcb0b6F4Vb74eQfwJHtFlsEyaDDKlKffRriwtYdKIBMWhnH3LNKJmkDTt/n0bcDVKn9AVrDkdziXEDthE/VdgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088190; c=relaxed/simple;
	bh=lu6CKrCXD1q1K8deKD4v+moyahrKz4hb1ZTrx+jdgoA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=cCjyh7+yd8YP+tvRpcx/ubXF86eJ2XoAs0bb7ic19wIrZaiR0T08Dyg5J0ikkN4z75Pq78pbtbqkO57aqptVorGVKFMHNixKfRbzDpPyPPWzFrIPLtJvwTqxjPQ5lgSrizzJwR7o7JODldtInDyRuDUEQfa1DYoQs+iRDwgPufM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pihR1srr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e83a3so48121977b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731088186; x=1731692986; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J5zaM+7I2VOXEZppYsZBX+RsEVW5aWCg+ZL5nx5NRaE=;
        b=pihR1srr+PMqNeamG1y0iziA4XV7JGSJzD/dpvyHDW4U9QQB09p9rqWOu1tGRzR2eZ
         SalBe2mzgko0ZKeYczfJKrzQ2rocCLB4kEcF+pB3LglgM2kQ4QuMbrHt9dT65Mh3HaNn
         lIwllhU3MQeYwMCVfPgKQ3Shy0QIpjt7YocTi/7wE4DEKL2wyAs2SXw1bVpLKSjlbAn6
         umutga6z7sqiA5lYxMKd2TpKqyTpyXAXfy1f9K9Gl3egITc5IfhT/bKRg2/DhLkY0aa/
         KeNmEY6H9ryFmZkXQHjSilM3ksuH6ORGepqG1sxlnsSPiN2JXoQ3o4zNeMDg9cGq+m1i
         +IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088186; x=1731692986;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5zaM+7I2VOXEZppYsZBX+RsEVW5aWCg+ZL5nx5NRaE=;
        b=hSTWIX2X1GkNXvQNHWScauVeJsNcFPNyBjzlG52i4opm9BUAZBI5oGYT08ULQciWgn
         ejxiLyr2Cm6ABQy1SvoWhWT7q8bqJtQgdGgAyv/jxhPAgPiUKqMye39cjPP3LqnFrGyK
         5jzX6e5eBRdZyEdyENqpKXXngTa6fh1oo2ZyKhGH4C2/5isSqTAKmswdSaIvDhSFg9fs
         7IPv4aqdGTJHFyrP3O+VKqcmtLYMNxkYVW78kSJBRnHi96nqiUk/zxzoMU+xoILdjDcC
         3fhs8fQvv/vtH/XN9umLqtTWxc0WxcPd8lHI7Miti+jneRbmRxnkzivze3YFBRySSj+O
         KMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyshSwCeN5BnRG7A+t7S+xQhnyOiv5Iuh7xpuV6/oDFlbLAp2rgRH/L+ohSm5ZnOkkVDITc1XpPUdX2BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu9NvcLz2YRVTMkKmSEbTbMRV6QU6ldiRvJIvhJCrBHvFX8Wd0
	6xXm2B2A+fSvtTw+yq0+cb+57NKOi445zoMQjph+9rTLZxPPPaM+IAC5OLwI6iYE+yxN9Z+bQQ1
	96Yoemw==
X-Google-Smtp-Source: AGHT+IEG7FKWRM6HWSEVycWwAkgQtTm8ERI8RUqwxAi/VxkO9EpeG1G52k6GoQxAFtzphf9GbhW1A+D6RpDB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a05:690c:6408:b0:6e7:e3e4:9d83 with SMTP
 id 00721157ae682-6eaddff4454mr281797b3.8.1731088185821; Fri, 08 Nov 2024
 09:49:45 -0800 (PST)
Date: Fri,  8 Nov 2024 09:49:29 -0800
Message-Id: <20241108174936.262704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v7 0/7] Hwmon PMUs
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
 tools/perf/util/hwmon_pmu.c            | 825 +++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h            | 156 +++++
 tools/perf/util/pmu.c                  |  20 +
 tools/perf/util/pmu.h                  |   2 +
 tools/perf/util/pmus.c                 |   9 +
 tools/perf/util/pmus.h                 |   3 +
 14 files changed, 1384 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

-- 
2.47.0.277.g8800431eea-goog


