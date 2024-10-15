Return-Path: <linux-kernel+bounces-366687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C221B99F8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DDFB21845
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCA41FBF62;
	Tue, 15 Oct 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTpM1KAD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402F1FAF1F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026394; cv=none; b=U1+BhN80QFDpIvaDguAbo3I+LM1OEEEZKFO8hsMXLSlplVyO2TIH/XI/4tFZfiThBls5j1zl8leOmKQT3MtLPK/MMarPoOWw6jtpFGdtv0kMV864doBTA6lFMUet0NJXXIVsd7YWThYFTgKZlpgh9JL8RBnC+DAW4AOOKoo2agY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026394; c=relaxed/simple;
	bh=usrc87swuiIEZtF6d3XncI94QYmPNZzDpOf7pgjoktg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=aO+GXaxYC6nr+rxdb9A4ouqRl19GUyGxfPOTcjd3z8i8P21j6fMcxsm9MYPkLIgtUjNH+IGTTw9kj8IftjMotQoaop/odl0oplyEAte782SMwEedoVbkEmtsuTd60c1xxgzayYOkJ2o/fT6JESNlNszZlYh03gTaxq7evdb1PpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTpM1KAD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so9448935276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729026392; x=1729631192; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V3V7UdMfheJVSkt+63c8FaFurZG67J77B0wKxX03R3U=;
        b=XTpM1KADwjXaBl0R/PLxol+qyRsrTnTWNGdpo9VygKW/kZ2jpWhc+neYxa9Mz01IA/
         csxQy63Rwd4euwfXJ3wNv5MEhSBxxm72hm1ecbo1X9WB1L06ScIIax4bco17Th8cclko
         GOT5opzRVAAh9Dgj+Cz75satN3jEGbBGAcySKJZd87QPCQmEfOJ1+9OHdIdLR/asQ2B5
         tQyShZTzI0betViK1f/8Bvd03Mekx2pqjJJqPKdznUf6y625L93acZOsL7yloqM6XswE
         /lIenm23vuh7yrWDmmsDOkmkinfACND+gRYiJaBT0gPgMEySfPZiYIv+/YaluxarxMps
         BleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026392; x=1729631192;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3V7UdMfheJVSkt+63c8FaFurZG67J77B0wKxX03R3U=;
        b=xBtnc2PYeRHKgM23Szt15CT754FFJONGXlnJanbXsn5qrz8cAdL6fFykQisrH5QsVC
         ueUgPw11QmWj9m9T7FpQ3ZDH2oHRTPswPsdrO0Q2GYyo3L6T977rIiAnlCtJllno2Amf
         vx0Sygpxz+Xj5SHyA1xOJoTBMnw5p810HALzwkqsx+qzCzQRPeKWaAEnrMfKui1Hp+d5
         sFXhcWL41/4UEaGu58u/iHlvIFLPJGDnfR2Sp7DkTgEDkapDb4rxqw0F57Ks4dlQiGqr
         bAmYIvdDdmSlPiXycCc1UhcCgBjw61Vhh/hLy2LQLqoM+b3CKdpI/xYCikR9Tam/A6AJ
         Ukaw==
X-Forwarded-Encrypted: i=1; AJvYcCWrkXcnbEeM9bnVnR0wgOgMWwa/42TNSLhLfAhdPGC3vE/JoBKPHtNRJdkSdAYTJaAK7KZc5KVMls1wPFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8v/u3zcV3A2faECArw4ArEQ8qY5nCqVzzE/MvnW4+2bHd7M+0
	htVdVVV3itre2kuru6ytgwShzDq7/BrWZ/7JK/HXE7+BjX1TjalPdJrwYEPxT4/KYDHjvWldek5
	tUP0WPg==
X-Google-Smtp-Source: AGHT+IFLQsMwt3RmY52ZnYdbWUmPSehl8+s1WJ6zwIO/r6G9EmOdNoktGWTpz27Avayxp+cRjctmzTvF362C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:61a1:4d9d:aca1:ada])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e28:f6b3:3666 with SMTP
 id 3f1490d57ef6-e2978567367mr1383276.7.1729026391842; Tue, 15 Oct 2024
 14:06:31 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:06:23 -0700
Message-Id: <20241015210629.1150428-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v4 0/5] Hwmon PMUs
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
	Yang Jihong <yangjihong1@huawei.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
 tools/perf/util/hwmon_pmu.c            | 820 +++++++++++++++++++++++++
 tools/perf/util/hwmon_pmu.h            | 154 +++++
 tools/perf/util/pmu.c                  |  20 +
 tools/perf/util/pmu.h                  |   2 +
 tools/perf/util/pmus.c                 |   9 +
 tools/perf/util/pmus.h                 |   3 +
 14 files changed, 1280 insertions(+)
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h

-- 
2.47.0.rc1.288.g06298d1525-goog


