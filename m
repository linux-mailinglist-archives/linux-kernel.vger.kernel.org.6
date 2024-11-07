Return-Path: <linux-kernel+bounces-400292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA0B9C0B7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BD7282A27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9C21731B;
	Thu,  7 Nov 2024 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvA92Rxh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C2217307
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996443; cv=none; b=RznB12CZkmAicLJsH9tk7/hMNcjBn5qZA4lihuKgFPXV3dOA2QLq/vYhyz/WqPWO6JPJ2lw6CYqptKxOQQg62ujQx7v4DQ9lvXPBcF0+10hLv+Mm2MnBl+aeO6b9rMfCWukZ0sfAcXna1yYrllIZvqE3D9uxIa3wl4jCXkyEhTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996443; c=relaxed/simple;
	bh=eP0G66ZHvZ6p8aDLP+KykiyCIg5mjIhYHWfKRwxuzaA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ANOR+glZJO+BdVbY+K7iTlFIgZgDjwhCUDvwMPVQCS6yMOo7UOvP0EXvmFrCgtKzpgMfZ0tEY49kPygumGXXpCXvJQ5Z+R8Yc4smhp2afM+dpxNnGfyF6SWW4UZIT/HoqCUIip5uRZeShaf2SXBZ6tsIbXGzPpq0DLQFwfBJ3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvA92Rxh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7fb84f999so16986277b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996441; x=1731601241; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v57hY9ptVyUkWxpU5CBHz4hqYdCeNDSYBzpW7YMhHII=;
        b=IvA92RxhUS4ZveIbX33wiVL0JsrN/35a77Yl8BxX7Eybsqu3gAYbzKF2fHbZMg//zo
         SdCHqWefFwQf4dmiYyqL+BGiw0rdjTE2LUh1mPrQMGvINqx68I+MF2rr6PoMUQjXonsl
         wXvxdW+vvCMfKZGOrTHeO2RMibbGnkV5yzmSjZAWc6P+AM+aBKtCL0Or9i8DKkb3E7gv
         R8Hf1BhbDVfpMo0O10R/rKRsQrl5h2wW2JRuDp+SvRyZk8npny9EJ3p4YFnDOMZ2yaCR
         V6D3PtZzn/pHanS3BxPIlXa8LbvRwwKCydTlfNuLV+HpazJdJoxfZmYtO08tcRR1gjlz
         /hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996441; x=1731601241;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v57hY9ptVyUkWxpU5CBHz4hqYdCeNDSYBzpW7YMhHII=;
        b=eCGYBM6qevRCVCL9iqiPNoc+O1c94g0Fl6Foq5NaHqLsTe4xFFJqDAUphVsUThktYT
         tIdaOtNiByd9CV44Hk+Kc2iL/kyOv8usN0SrvT1MhfFA76bGO93ZFnYYaMu5SAX/jh6D
         aAkpzT9jqfeaRAmX5poeXzVtU/ZjuHjkhengur3gJzd53G0yxQ0kcIxJ9WLMMb24+5FC
         ani5eljMLcj4Pd9HM3pyuaqhbwy5vX4e/V3UfK8lgZwE2A4X61u89mkgDHPtKXN2Digo
         ONZqCZIpUKmWg39DGXUPX7Ucexn2qsVQ/CblwBPxcrI/MJ3Ynmq1jhCqYKr0H8kl9Vki
         O9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXbF+8iHRV8d5M1KiGhR6WNthMT6sicc8iejVBUzAOcAgkKb/aS+2tKPMy4kRs4xQQBDdQevb0IZXd8wok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1k2Cn9ecRtgU/61GNow8wt8YaGfnK91Fj0SuZHTeuBiaNxjuL
	2jqKbIt6mfIM2WOPK3GREZlPmRE8n1oxBMdn8Sro6Y466ug730TYNsZa/j9ooIG6KU+XkD3yGtG
	/kFwAzQ==
X-Google-Smtp-Source: AGHT+IHC0X+WZsmRaD10ygx7XOVdKB/UZb7/tV2Np4btpUBS2SgGAemSgZHBuWrvuUd2DVUs75+KuuMxxrqo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a05:690c:13:b0:6ea:8651:4b27 with SMTP id
 00721157ae682-6eadc1065acmr1207b3.5.1730996440734; Thu, 07 Nov 2024 08:20:40
 -0800 (PST)
Date: Thu,  7 Nov 2024 08:20:27 -0800
Message-Id: <20241107162035.52206-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 0/8] Refactor cpuid and metric table lookup code
From: Ian Rogers <irogers@google.com>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Xu Yang <xu.yang_2@nxp.com> reported issues with the system metric
lookup:
https://lore.kernel.org/linux-perf-users/20241106085441.3945502-1-xu.yang_2@nxp.com/
These patches remove a lot of the logic relating CPUIDs to PMUs so
that the PMU isn't part of the question when finding a metric table.
For time reasons, it doesn't go as far as allowing system metrics
without a metric table as a metric table is needed for metrics to
refer to other metrics, and the refactoring of that resolution is a
hassle.

Ian Rogers (7):
  perf header: Move is_cpu_online to numa bench
  perf header: Refactor get_cpuid to take a CPU for ARM
  perf arm64 header: Use cpu argument in get_cpuid
  perf header: Avoid transitive PMU includes
  perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
  perf jevents: Add map_for_cpu
  perf pmu: Move pmu_metrics_table__find and remove ARM override

Xu Yang (1):
  perf jevents: fix breakage when do perf stat on system metric

 tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
 tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
 tools/perf/arch/arm64/util/pmu.c         | 20 ------
 tools/perf/arch/loongarch/util/header.c  |  4 +-
 tools/perf/arch/powerpc/util/header.c    |  4 +-
 tools/perf/arch/riscv/util/header.c      |  4 +-
 tools/perf/arch/s390/util/header.c       |  6 +-
 tools/perf/arch/x86/util/auxtrace.c      |  3 +-
 tools/perf/arch/x86/util/header.c        |  5 +-
 tools/perf/bench/numa.c                  | 53 +++++++++++++++
 tools/perf/builtin-kvm.c                 |  4 +-
 tools/perf/pmu-events/empty-pmu-events.c | 39 ++++++-----
 tools/perf/pmu-events/jevents.py         | 39 ++++++-----
 tools/perf/pmu-events/pmu-events.h       |  2 +-
 tools/perf/tests/expr.c                  |  5 +-
 tools/perf/util/env.c                    |  4 +-
 tools/perf/util/expr.c                   |  6 +-
 tools/perf/util/header.c                 | 82 ++++++++----------------
 tools/perf/util/header.h                 | 23 +++----
 tools/perf/util/pmu.c                    | 25 --------
 tools/perf/util/pmu.h                    |  2 -
 tools/perf/util/probe-event.c            |  1 +
 22 files changed, 189 insertions(+), 229 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


