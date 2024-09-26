Return-Path: <linux-kernel+bounces-340836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AE6987869
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877D1B25E12
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191B915C137;
	Thu, 26 Sep 2024 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zk2Zw7fU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68D156665
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372168; cv=none; b=gRVgIz+z+A1kwSy68qOSUy0i+574IXfpqQjR6omLB17P9TM4wQF31OM/z4005B2OjvshauqR8e2HryAOSBZ5EHu9q0QE8BSX+1iqYujwGYdniT2KI0vmOgapLGwYH5IOOJCaN9pXhzQvh/V0ddak/GEbvBrIA7eTDIMPhVlvVb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372168; c=relaxed/simple;
	bh=qcy+RpV2vbrVmrGURYFWlXNt7s+hWt135vi8pUWprCc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=EUkl88GykS8v4mj81FZtRVyj5IeSytpUufv/TEenBnglQxidrU3k9VmAX+pt2KhOdoSKjyoViCkBRJnigrJrBitSq+T1UgISSKHMul9ES5LpSEOwUxF1yxwiuhQFH1vxdf86fMKB2jjowuAimwMADw85ACfQN/LCUDeyCxJnyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zk2Zw7fU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso30796287b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372166; x=1727976966; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yxYcIYohZlas4VM7SOhVCX8bDWL8M8YuZQaG8xAXc/s=;
        b=zk2Zw7fUqK6nxD3PizqVwqTjXfDqWOQuktQJh3XZLGZYmvK5cljlT+G5RMy+EeKc0s
         eTPxEkPDx7F5pdf/tDbt2AptkmrFcfa25g/+x7xVMI1cL6WLAgTjYM5cpZURbgPp5S4O
         gB8CUjdvEUk3EF5qahUtOD1COPxbvwUofqVlAKtcj6VM5FfINIMX0DpXvVf+qNsyU8/N
         QRl99BxvkhFEOQ1JqzI5FM743n+gtZ69Ehvpoix38r84oe0W7sGUIbKt6wULFcKLBKyZ
         SETAlZUnzZ96HYWMFhEhlh7XATYVkibcol7v7xzVWH2i2KqEXI5cTyKk9ySH9fVRAwVQ
         YDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372166; x=1727976966;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxYcIYohZlas4VM7SOhVCX8bDWL8M8YuZQaG8xAXc/s=;
        b=C6kD/dj5MNkaSVI/77vJZIInrxI2g1y+XphOIphdP5FQJW+903tcp2FyWd/k9DL1tW
         AdGAFleLtyCLfS2dHRAlmiP5kiztZTQE7AX3o1neGsqvoVY6FWN4/N3pFuHBTh2aAyOD
         bxKIUj5MpyrvVaMuN32XHISv//Q/3bm/UADNpAj0Jve6m6DhJfOLKiheESSIoZScKJZY
         h+OFCZw3KOyYWBq+LHPu/HfisHQjNWwL5ahPrHPd3Mtn26kwDHeKBZOhJ9+w433C7ey8
         qXiQwB8NGk2MHO4Z3pj5Yp/8cP137p2t7DAivOUDHa2SP3EY6bzFivt98gnjig8hBESl
         pBvw==
X-Forwarded-Encrypted: i=1; AJvYcCWJJFmaiyiou7tcI45RVQ2HOC0SOp3K6W5sKsBW0DjsFfV7Hf57pnT2HLhvHPZk0BTzEij8pjtG1U+etrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybwJmbyS9K3yJ0TT2O9proZpChs0tgUKC2UTptLQlXzIqLm4j/
	wMHZinn6u2ul/doELczQZfDVPzdYfnyQ6ZPd7CIXfMc/D8ncRFVp2HoiCC7m9+EAJpouHoSOb8T
	rSBB7dQ==
X-Google-Smtp-Source: AGHT+IEyd4n02CVR6nEreiqxHqV8a9sHCLgR24twhhVBcHmDoVskxT38W8/3BBhxdfBHRwZ891T8PiGhoHBg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:ce85:0:b0:e1d:2043:da46 with SMTP id
 3f1490d57ef6-e2604b2b428mr147276.3.1727372165851; Thu, 26 Sep 2024 10:36:05
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:42 -0700
Message-Id: <20240926173554.404411-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 00/12] Foundations for metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

v4. Rebase and small Build/Makefile tweak
v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
v2. Fixes two type issues in the python code but no functional or
    output changes.

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   2 +
 tools/perf/Makefile.perf               |  23 +++-
 tools/perf/pmu-events/Build            |  62 +++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  42 +++++++
 tools/perf/pmu-events/arm64_metrics.py |  43 +++++++
 tools/perf/pmu-events/intel_metrics.py |  42 +++++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 162 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 348 insertions(+), 38 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.46.1.824.gd892dcdcdd-goog


