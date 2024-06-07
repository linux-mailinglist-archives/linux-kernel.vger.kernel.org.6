Return-Path: <linux-kernel+bounces-205469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BD78FFC81
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6111F26C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CF15442C;
	Fri,  7 Jun 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyhOF7hL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6015380D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743233; cv=none; b=kerH+22TmAX4GxIVnp1Jyrn7NxClOzC/VTGdz0Xkf//0o52gzOhbZ4nb82ftTYi/ulbwYkYia/ckHRxfHHCzsrdZ1Umjwa9O1jGdkMx643G/etz/GRuCTi40+3HpkqnUe8S1/GJB0cvrsvtl3a5HI86/weEOsgNsPh55a3rFPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743233; c=relaxed/simple;
	bh=k5Of17rlZ5YWpoLqnZnihufQm9m2MOHJaY1j7aQrJp0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=AwZRN7udp3GmrDziMcijLZvHdEdnWQYTerXmA4UyhdeJmvkMTvj+QymUAlUVEvKfryzecKoo4lmTVg/VmiWl6qOo9N3NZ+jPQJ/EnCJuSF7jo3plh9/MamrImr3azPEwYsifmru64jY05MRznDZsGJmnFQOq0wEFuIvPJ5fvH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyhOF7hL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa84f6a603so2838554276.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717743231; x=1718348031; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEpqaFglUIN4j0bNTTqG5LfCSH5lEYc3LxNNjSK4NrA=;
        b=VyhOF7hLTCf1Btx6ngwltDyGyklE2Kb1GBWO1J8aOTp8o1unEBZ7UXxLwGQdpBGIN7
         ymV9vn1Y/KscyDfumxX+5fldeHtQXnXz1nShIXGg5xoPIT0ogKw8fTMGTccgkb44sFEQ
         53yep982tq+ja8ZhrcKjDmxI0SqoqJIeanpG+6M9xiu6ZYQd4iW5onfSLUUUOmagdDJK
         jRVftfYaxgxFnXFkmSgtigP6yfXk2LLhjSZJk/NI/93cihWDJYvLSAbkadR5ODecW3k1
         MKgDc9ihZF2bmBHVLhnB5em/PMf36+PfL3ErLyiCr9zHA19DeahDyv3PogVpo6p6zbvw
         nLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717743231; x=1718348031;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEpqaFglUIN4j0bNTTqG5LfCSH5lEYc3LxNNjSK4NrA=;
        b=tHB0X3591N8DZ3+/YzBAXWa+5Y+7PqR1LBuABb959onB7mdWBSEnCMO1ns4zTySFES
         INF6S9zayp4HLy26nLbs5qjDWVknX3zGYhEwYKiGURhzpYWEj6ofH91ZKp19JbfZ6bNC
         12dtGPJc8yUu7DxVfOZ4+yKYJxFKVHnNt+G+0wx/sQHjB3vOKIaI2yeu3nJppgs9qKnu
         69pRlHZhAmjqyw4C1CjGlb5Mc/ncLdpILdEw1qDw85fMEIIu7pSn/8DqQivUkAECKTUM
         VesxWSje3YqzE4K4JyySktyidSFuqYLSC/qPq8wzsJYDNmnF9Iv2BefhBRgfpEvAJXr+
         otfA==
X-Forwarded-Encrypted: i=1; AJvYcCWXMe9pfRALuEII1dojkQjsIs9zDWgEr84zKky3373LztyUXrAzCjZmDsU8AicY747RqKFxmiTtJ9ALIFeSOUfqLbb7UypV65QCGsHd
X-Gm-Message-State: AOJu0YxPpZjW4oXrGr2hXvrE3yC3Rb8Y1YvNGcSQN1HQ7FHf8m3ptWcU
	RBOOiTp11HenYaIEzczfxnZa42TOZD66sYjb4Xrhhyu1355/SASDON28pH/naF/gTQ+lEWRJxQD
	yfhjvFg==
X-Google-Smtp-Source: AGHT+IHQkp+y5tUPrNdcf4gtzem9JG22JKiIol52nLVQjWonlofyDIP9B27YgyPI4hdcDiOYwNVskUX+GdH7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:da3f:3dce:f5a8:653b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1082:b0:dfa:febe:57c6 with SMTP
 id 3f1490d57ef6-dfafebe58f0mr33228276.13.1717743230815; Thu, 06 Jun 2024
 23:53:50 -0700 (PDT)
Date: Thu,  6 Jun 2024 23:53:43 -0700
Message-Id: <20240607065343.695369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="UTF-8"

When PMUs have a cpu map in the 'cpus' or 'cpumask' file, perf will
try to open events on those CPUs. ARM doesn't remove offline CPUs
meaning taking a CPU offline will cause perf commands to fail unless a
CPU map is passed on the command line.

More context in:
https://lore.kernel.org/lkml/20240603092812.46616-1-yangyicong@huawei.com/

Reported-by: Yicong Yang <yangyicong@huawei.com>
Closes: https://lore.kernel.org/lkml/20240603092812.46616-2-yangyicong@huawei.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 8b7cb68ba1a8..6b544edbd3f6 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -11,12 +11,15 @@
 
 #include "arm-spe.h"
 #include "hisi-ptt.h"
+#include "../../../util/cpumap.h"
 #include "../../../util/pmu.h"
 #include "../../../util/cs-etm.h"
 #include "../../arm64/util/mem-events.h"
 
-void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
+	struct perf_cpu_map *intersect;
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
@@ -33,6 +36,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->selectable = true;
 #endif
 	}
-
 #endif
+	/* Workaround some ARM PMU's failing to correctly set CPU maps for online processors. */
+	intersect = perf_cpu_map__intersect(cpu_map__online(), pmu->cpus);
+	perf_cpu_map__put(pmu->cpus);
+	pmu->cpus = intersect;
 }
-- 
2.45.2.505.gda0bf45e8d-goog


