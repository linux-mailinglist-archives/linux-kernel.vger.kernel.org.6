Return-Path: <linux-kernel+bounces-370354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EAE9A2B75
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FFC1C2620C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08D1DFE18;
	Thu, 17 Oct 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJUF7H/R"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935E1DFD99
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187647; cv=none; b=bFMWC210Ge5PPFESQfne/oFdgG2zLgbW3HrkMVX4BmIVls7+j+w3UzFCVro0cuUaKQY9RiINz6ZsY93xuUpZKIe5Gtc0JrrqgwphMz7g6pRfMqGS4Av20CbotiiI8LIC09sXBAN+4ypQEnPqP99xhEpkCukT7lehGl4NNT2eTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187647; c=relaxed/simple;
	bh=kPguH/PiaSmjemQkDLtAr4Sd5dUG1i9Ovu2OSFHi93Y=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=JQZ6jJPpscCjflUh8Zeia62kKrSEyGBKjGE+dfWJVPnoau05AtF08WaKbHdedhAtchSzz1WTADM4toJvtkeSWBJb8q+WsO5ujc480cgkmL+n+Xu37DqqDj8dQDY0RFlYEFnNIdx2eovk1SBWj3fM523XiGjfxyor4mNfCi0VK08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJUF7H/R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so20649947b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729187641; x=1729792441; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tgSCV8aNz2YfjZPfKysuQB9Bz04ABsxXUUx1RTdITWc=;
        b=eJUF7H/RijwxR4dqT1wXAAa6PtrEOMNnn6oyTBhCU953SGcd4o79/7U3vYCW1xGWa2
         ZF9xBaOCcdllrEBzGBMRSc+XCUdhEjqHjIWYqu+YogjRlW9MK2U+52pQCvAPnpMyKvAw
         yIcoLQrnSxH2OAKDCwtX3qBCA2r7nId0uaEeziIAMaDP4tNyYJ7Nee0dmF731Xoz8bVo
         Ezhnk8E6rMdfG2IdGNCl0gT/+SsI9hbXFOLudAFAL2jjLk3WdhHK4DGbpYed5258QCUV
         m/AbN0XwsBwzFtcsxsAMxshSPrxmeJR1pGMqC0PQ1gHu93hmexSDn+WZYx7aujL9dAtN
         KTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729187641; x=1729792441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tgSCV8aNz2YfjZPfKysuQB9Bz04ABsxXUUx1RTdITWc=;
        b=pVwyF2y3A7jN/eubHFxPzvuTYFGMUmcHAbMVxchBbw9+aBwVREdTOOEtfoZ/P+gg2a
         jUmGF1v3IlNLCptbmWK1Z+GwKYJoxiFX8l6cKg7UVPa/GZwJp6fm4gQRK9vlaf6jY41v
         WRP9Z3WhiIxybL+ra6+lEhhYie/RkppWlBS0jdf5VOfpG1n9G+khIvuBlrg5A6a/lBMn
         kkievwred6VBt/bnB/BDHTSY4W6P8A6fCQ6UXyJIIQB84d1I6r+ULw32IM317KWIw72F
         IT/RrHPqulUPsrbgVLsQuxWc/xK1fC/Hh1+aw8nO3zU6mLs0QYXYeISPWoPP5tercR0A
         DmTA==
X-Forwarded-Encrypted: i=1; AJvYcCU1mNaUfl+Q2gn2sR6CbRxQqIFwKxk7wjlxpRiUFMWUv5X+7Tuv3MSJIpcQLP9iVcZ7qALE9zHWG4PBDmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLeCcMNKIeszcnLHi65YWSig20fedGN9oyH/sIgOzKJPPaeIG
	ZS3/cQAtzPeW/dFK4cZDnYG9o4iljAcSy0Nku8JmOcqvqOsLZMCj63sdMqbN9fM2aImY+WBrOFn
	UGRb+YA==
X-Google-Smtp-Source: AGHT+IHsAPMo+2mDgpT6mwWtaIgH/co9MMJFDhhG4V/GVuYrhlly/7CrOKCeJQPys15hveYgmB6kOrY076PT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:4447:b0:6e3:189a:ad66 with SMTP
 id 00721157ae682-6e3d41c59camr1931517b3.5.1729187641581; Thu, 17 Oct 2024
 10:54:01 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:53:49 -0700
Message-Id: <20241017175356.783793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v5 0/7] CSV/JSON metric thresholds, fix printf modifiers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants for a json dictionary
value. Disable metric thresholds with CSV output.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

v5. Switch some u64 printf flags to PRIx64 rather than llx (kernel
    convention) to resolve 32-bit build issues.
v4. Drop CSV metric thresholds due to formatting variation on
    hypervisors (broken counters) and not as detected by
    tests/shell/stat+csv_output.sh.
v3. Rebase.
v2. Don't display metric-value for json output if there is no unit.

Ian Rogers (7):
  perf color: Add printf format checking and resolve issues
  perf stat: Fix/add parameter names for print_metric
  perf stat: Display "none" for NaN with metric only json
  perf stat: Drop metric-unit if unit is NULL
  perf stat: Change color to threshold in print_metric
  perf stat: Add metric-threshold to json output
  perf stat: Disable metric thresholds for CSV and JSON metric-only mode

 tools/perf/arch/x86/util/iostat.c             |   2 +-
 tools/perf/builtin-sched.c                    |   2 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/builtin-stat.c                     |   8 ++
 tools/perf/builtin-trace.c                    |   2 +-
 .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/color.h                       |   9 +-
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/s390-sample-raw.c             |   8 +-
 tools/perf/util/stat-display.c                |  73 +++++++---
 tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
 tools/perf/util/stat.h                        |  16 ++-
 15 files changed, 170 insertions(+), 97 deletions(-)

-- 
2.47.0.105.g07ac214952-goog


