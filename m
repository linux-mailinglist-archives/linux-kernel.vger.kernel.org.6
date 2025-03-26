Return-Path: <linux-kernel+bounces-576458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A556A70FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61A8189A856
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E324158DA3;
	Wed, 26 Mar 2025 03:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kP+WiVAL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0533AC17
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961067; cv=none; b=eOimkyHBS6vojf24KvBmgyEKhJ/l06xh2Ua0DkSK3XovI059LYZ5PQHQH6tMuwJmYGtxyPlGdyZ4Nh0CpeDHbf+ZOsiQ5LJe/qOxn9oq7RfBgm0brw2CubNOHaAqqnyqS6pIkTgj3RggAq05iK5jvIIdIq8pqacUw1SH1eK7RkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961067; c=relaxed/simple;
	bh=OrNdDDtLr7sWANp1hVQxXXdW61TAcKhwpU/lYJV6sUI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YwmGjdgYAqaNJj3uvpO6GEix/zpRcg/Lf1VHxtrwCpM/I+dXoQ2wooyQ4xz8hYTJpFf52eK7FAS/IuCtoNC77cGFH2LlIVHJbV/1rlZjYnyMhFxatXXZH6rAfKGRf0FjweHJPhSg6pYsMrv+wC8ARz+/2zRUFV47ehalsHvh4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kP+WiVAL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22403329f9eso91333185ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742961065; x=1743565865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q4SBEUeVaxUtokJPIUYjJGAnoRWPInWE392dc3Q7SjQ=;
        b=kP+WiVAL/hBksX9PeSCEeTC9pI+ufxHlTmST9OMttl2oawKvio/fsP6ASgBtkIJZNK
         6UUzIb42Pk7LtMaybxX+jXRmIBPdpIoLJrze1uEaxjRYHcyH8b/tXwN2SccqdJgY6QdR
         TE08jrUdbT2TLT72lk637xZ/5O5ta86T9UeRbEMvfnZnYYvG0jMX7fHnQs1wJHLOHTFB
         +hYxZ0xz7edWUx1V6NUpJ369sCttLG6AvgWiG+CRgo5V/Xqhnbsy2/PXayMaYORoHtvG
         MNWsj5fE+k2CDk2CYwwa7ByXriKXAAXFtrYKgLXG0TERRjfY5OFL8jzNC6F6x6i+IWX0
         /YZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742961065; x=1743565865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4SBEUeVaxUtokJPIUYjJGAnoRWPInWE392dc3Q7SjQ=;
        b=MD0flJxrLM/lix9pAm6RjnCKTB6D4PLAtYNSpQ6g5MZryrqtFJuJjYmDuynJQMMd65
         7WowulrVJFhPY5Ep+CHd5X+eK/EyTLymYw4Q/OnE5waejevxwQtZZjnhe3LmT5km8beY
         rrdkLrrvPiIjK9d/OYBH80mzM7/5P6FPKDxkEV3RtzDS40BBjvEVykD+lGdTpeMQGJLA
         6TCbt31B0Sq9KlckKnas0s+mMKOQcb3z1Tu3014C6a62ZoaKqnN+m1bW21elq3q51Zvj
         IxsAouYcHJ6WLhe8L2Dv8jCqsEChIdBp+Hlz8dI21qP4WYdcIhdQ23E88GpSo5B6wbPk
         07AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoHn34gQjk+M463YGKtzJ3bsKf0t0bBqZi3mBjKrnaYGeFTQqafSjZaWwTZ7d4w7jCy1yCHV2i1o+oMM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10OgPecP/XO4gnP6q9wc4SAPSs2SJbQ+QmVWmSyHCrfMvYYiN
	6p/XF7RQo0QK8qw04hi6fpc5omZHjqRjdWR68yYPMpMYjn+m90QrYfqmNC0wufwfCYMF6TAyQ4Y
	23h+bqA==
X-Google-Smtp-Source: AGHT+IFX6TAUq+5C9170e0/iEjt+LX7tYFuOYRqyp7uoH5Mv47EnjgV63qQG1LlVmvC8atTnWkrS5Orlfjl2
X-Received: from pffk14.prod.google.com ([2002:aa7:88ce:0:b0:730:8e17:ed13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4602:b0:739:56c2:b661
 with SMTP id d2e1a72fcca58-73956c2b9efmr534037b3a.12.1742961065431; Tue, 25
 Mar 2025 20:51:05 -0700 (PDT)
Date: Tue, 25 Mar 2025 20:50:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326035045.129440-1-irogers@google.com>
Subject: [PATCH v2 0/4] Add support for a DRM tool like PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

DRM clients expose information through usage stats as documented in
Documentation/gpu/drm-usage-stats.rst (available online at
https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
PMU, similar to the hwmon PMU, that exposes DRM information.

v2: Add support to only scan hwmon and drm PMUs if the event or PMU
wildcard can match. Add a test as requested by Namhyung. Add file
comments.

v1:
https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/

Ian Rogers (4):
  perf parse-events: Avoid scanning PMUs that can't contain events
  perf parse-events: Avoid scanning PMUs that can't match a wildcard
  perf drm_pmu: Add a tool like PMU to expose DRM information
  perf tests: Add a DRM PMU test

 tools/perf/tests/shell/drm_pmu.sh |  77 ++++
 tools/perf/util/Build             |   1 +
 tools/perf/util/drm_pmu.c         | 689 ++++++++++++++++++++++++++++++
 tools/perf/util/drm_pmu.h         |  39 ++
 tools/perf/util/evsel.c           |   9 +
 tools/perf/util/parse-events.c    |  30 +-
 tools/perf/util/pmu.c             |  15 +
 tools/perf/util/pmu.h             |   4 +-
 tools/perf/util/pmus.c            | 101 ++++-
 tools/perf/util/pmus.h            |   2 +
 10 files changed, 951 insertions(+), 16 deletions(-)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh
 create mode 100644 tools/perf/util/drm_pmu.c
 create mode 100644 tools/perf/util/drm_pmu.h

-- 
2.49.0.395.g12beb8f557-goog


