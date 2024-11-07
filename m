Return-Path: <linux-kernel+bounces-399440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519139BFEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2DCBB22A54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F92198E76;
	Thu,  7 Nov 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTHKaYYQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473F1DE2D5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963766; cv=none; b=UVvW+19HwB0cHQVwcowqnYrJwfFpbbARZt9hIA6Cub+puDkcECQsXsbbr4tCGOK4D407NTnTjyUhhCxQKxXzid2OmaCmGZD9k+F0iSFWt4Rn5bDr6eqqcsV8mA83uoyjERu1PuJgSu7NkOODZMP2p26EIanITxCfNIMQymqBMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963766; c=relaxed/simple;
	bh=BwcnXHvWKb+RT9sUijfODMh+FsJEE5mPxKIUSQOlBdo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iOSHzJEcl3ONsKHtiO96B/xDJ+NVuzx0T38c0VImKPRdS6hPM2IWOcQGuF/mTqBAvtJNy1/Fa2xZfyTbNcTHGBT5SrMoQajQwm7B+bd0B3bg0ggXd/OA586rBdxYKKlJXeMPcULkRmhtaNrWG9ek/BFoKBOFN/RYGxm4vSnZpFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTHKaYYQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33aad097so20159207b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730963763; x=1731568563; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wIF/aFyjH0swzXh//3pYKGTGeXLDfUk5PCZEh9QeTEg=;
        b=vTHKaYYQrAd/7C1usGa3g0C3H2f4NR4oEFfCyRBVa9t9ZYMTEHsqJmvfEVPLR9pBPp
         3aTfXxUmqc8n3bwoc5vfV8Cspa2iF1cpAaSwKp3AzYPhJSWkJ8ra4o8K69NaGsHoyK+9
         7+7LcaVCeZ97dbNkxvd8Re7NKaJXqyfKh/oQAhLC4wRnWoMRgf5IjEY121ynPEqN/YEB
         bDO1LU04NnP4EwG8necxZ1QVh5ttnLiw8ET/mDI7Yht+/dIlDuye1AwdOl6MqdvrTVoA
         DnCQDFSwpLdKYh1YgMcXCF6nGOUq7zBYJxMicjYks/bfZp5SgtR8dLTcWqUXVgkY4F3H
         VPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730963763; x=1731568563;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIF/aFyjH0swzXh//3pYKGTGeXLDfUk5PCZEh9QeTEg=;
        b=li3l645baYnEQD+5hde3MKteQYAAPoTp4YXJ4emjKH/Z038slGoi7WfT50Yk5F4TzG
         VF/LWdv54wSifXaVTSGbCF2OAlK4prtwVe5mUjH10u+2p/K8IjKytLNAu3UxU6SRCzG1
         anjmp/CrZxwhMInvjz6FPHpkOfQCSVq9+81pgK0s75+P7EtM0ONXaSFqQkbfXctRS0a3
         rFehqXU6eLwU4DO5AoF+mSVi+ONYx0UC7JO7KLeXCQoF5IVEW0LKSiBHxnRLpTXb1nbW
         tMPje90sucsn6c8hD0Cl/S/E+FOXNYOndEY9oPSscYFGWHcElmuyf5RwrWI6WaNiwF9S
         v6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsxO6OANWRf+3NTl0dtQEoKmekl42hQZ6ZQj3opyy1fAYCOw+OuJmuGE502MPaxfT2bs5wFWPY3B0M3+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUKFm8KjSY2Oz+8g7Man3YqvWfonGosaSvkDsN17zF5+4Hmgo
	vi0hm0R7MIR5OlSf3QPdz9kl97UYBrSTxg0xEdUuorm1pvqHup8F+uyjUQbypN3DRivAdtK9xbC
	eJ+L0IQ==
X-Google-Smtp-Source: AGHT+IHvCILyN5DpJxEsgBeXCmm3giFiBD6WLezeO39x4rZhcquIeovnhv7BJuOVaBOHsKZJ7wG2BPFJsN4k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc7:bda:7167:18d8])
 (user=irogers job=sendgmr) by 2002:a25:600b:0:b0:e30:cbcf:181c with SMTP id
 3f1490d57ef6-e3368e1f4femr4836276.2.1730963763338; Wed, 06 Nov 2024 23:16:03
 -0800 (PST)
Date: Wed,  6 Nov 2024 23:15:53 -0800
Message-Id: <20241107071600.9082-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 0/7] Refactor cpuid and metric table lookup code
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

 tools/perf/arch/arm64/util/arm-spe.c     | 14 +---
 tools/perf/arch/arm64/util/header.c      | 73 ++++++++++-----------
 tools/perf/arch/arm64/util/pmu.c         | 20 ------
 tools/perf/arch/loongarch/util/header.c  |  4 +-
 tools/perf/arch/powerpc/util/header.c    |  4 +-
 tools/perf/arch/riscv/util/header.c      |  4 +-
 tools/perf/arch/s390/util/header.c       |  6 +-
 tools/perf/arch/x86/util/auxtrace.c      |  3 +-
 tools/perf/arch/x86/util/header.c        |  5 +-
 tools/perf/bench/numa.c                  | 51 +++++++++++++++
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
 22 files changed, 187 insertions(+), 229 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


