Return-Path: <linux-kernel+bounces-376772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7919AB5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A3E282E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623081C9B86;
	Tue, 22 Oct 2024 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eutoivWs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8651C5790
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620389; cv=none; b=ITfyyj9KZz2Y0PGPF11ukwMBZaQGlYbpmXIjBQF8G5ZlMBzs42VPWd3RCx/f1EAUljvlDr+z1z/NCG5SN3W9plVRSoXFG5Y014/OY/8MVOGiTTjhID4MLVCZxV58yo0RatGpL2wlKZBTw+K8eOTZfOvjguc9D4Ss8k5+f6ujP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620389; c=relaxed/simple;
	bh=855TCoJSoM/fJizpKgsRbak674yEWLYzh8gSO7GT3VA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=KP+Ss9eKnnswEitJwCBIkkGX3z9YQ0DALiNA3MFb2WELHydt0TEeDcDRUUFIL2fjRetIDveHq3AJaZmNhv9ejjVFY5SNc8FhnKtEXiTvb3lmri56y1yDm2jE0waWDzIsqr5Ts/C5Olr4xElrsQTuZptsYYp/HzGqRcZKfj5/k84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eutoivWs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370139342so99043227b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729620387; x=1730225187; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJb1ZF426BBxvPrgfw4saW9tyK9NJ4Y/2rJKwEpdYcE=;
        b=eutoivWsqcQOzhfD+VgTxXqzIKVV9x1bz0NDoBTDlMEF78hd5LIzBSXphxNLGf3YXc
         ntDHH+yNCyZklK0cEst1lUsgzkae/mP1gtIRaM/r/rl7fSlPmEBarmj9QIC7n4wNong6
         S0kh5qn9XYaI42xud4Rr/qYLTZS4Vb8U+KBlBPj6R5BnoOvP7r16wUCQg16wjpX8gsiq
         fosUYGyxiaznxVdCSxUHqn4n/gSmyQABNrMk+mTKcLbKyxil8/0peYfX9eqtBxioiwt+
         tqcsUS8L8SytwhoT2BF5KIVRBjvm1PPyUMpco+2Es89BiuVeZqTv/mFpXpBO4lG9RbV9
         VndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620387; x=1730225187;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJb1ZF426BBxvPrgfw4saW9tyK9NJ4Y/2rJKwEpdYcE=;
        b=kOTQrAnP+rkfzoeZRrU/SPAtR5RIA2vroUdvwBdrki1J7YLOpVrXNGmTxo8UorTjU8
         jQ85xUiRonWAIH5V+d0cJ5n6WHMW2zwRPSvS4baNhrc/wu84VRWIv5ZZvrgUyUM85c4s
         yXuA/DKjSuqc0kZLyt12dwFa9CVr4NwkrYt49b73Uz7aOUyEJ3lvvGJiKM95ZOiNyY9+
         EVBvwfxrH5gp8DjaGxgHw2jMeUm0P54iGvygQLlRzjhxTIQ6NltlEeLAzmPqIj4vLQRC
         owFHxwe+NW1EBpzEtkLrSWSq4K8F3I5k/WIll6/VT3utDz3qHZ5qXb6ZDNMKgtdVszjY
         yqlA==
X-Forwarded-Encrypted: i=1; AJvYcCVMkhYdkm3JQVA3BU39Fs9UhT+7JS+RcmdMgPF2YSdVqqYnNuo1Op1lB2SzzDdfjun1ZhX24ZUQNBKVLsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypi7VM7jxdwhxPpTpPR3D+LfwjjP/b4gP/qzclvOSg+hF43v8Z
	QFY/bhyH6vcEyPcb82UKTYJH9mPB3sFEyQR6NAz5cLrfvUIR68Uk9/3WpQSetlFzivr7Dqwti4k
	Ulp+LMA==
X-Google-Smtp-Source: AGHT+IHoKC2XuF3im1RwS2g0i9/u9K1/YbVBvDeeGO8XmmOa7/rRhT96VzA1rMwRTTBpizlfmJRZ77evxQ9B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:4b05:b0:64a:e220:bfb5 with SMTP
 id 00721157ae682-6e5bfbe52c9mr3649427b3.1.1729620387126; Tue, 22 Oct 2024
 11:06:27 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:06:18 -0700
Message-Id: <20241022180623.463131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v6 0/5]  Hwmon PMUs
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

v6: Add string.h #include for issue reported by kernel test robot.
v5: Fix asan issue in parse_hwmon_filename caught by a TMA metric.
v4: Drop merged patches 1 to 10. Separate adding the hwmon_pmu from
    the update to perf_pmu to use it. Try to make source of literal
    strings clearer via named #defines. Fix a number of GCC warnings.
v3: Rebase, add Namhyung's acked-by to patches 1 to 10.
v2: Address Namhyung's review feedback. Rebase dropping 4 patches
    applied by Arnaldo, fix build breakage reported by Arnaldo.

Ian Rogers (5):
  tools api io: Ensure line_len_out is always initialized
  perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
  perf pmu: Add calls enabling the hwmon_pmu
  perf test: Add hwmon "PMU" test
  perf docs: Document tool and hwmon events

 tools/lib/api/io.h                     |   1 +
 tools/perf/Documentation/perf-list.txt |  15 +
 tools/perf/tests/Build                 |   1 +
 tools/perf/tests/builtin-test.c        |   1 +
 tools/perf/tests/hwmon_pmu.c           | 243 ++++++++
 tools/perf/tests/tests.h               |   1 +
 tools/perf/util/Build                  |   1 +
 tools/perf/util/evsel.c                |   9 +
 tools/perf/util/hwmon_pmu.c            | 821 +++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h            | 154 +++++
 tools/perf/util/pmu.c                  |  20 +
 tools/perf/util/pmu.h                  |   2 +
 tools/perf/util/pmus.c                 |   9 +
 tools/perf/util/pmus.h                 |   3 +
 14 files changed, 1281 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

-- 
2.47.0.163.g1226f6d8fa-goog


