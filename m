Return-Path: <linux-kernel+bounces-298783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5487395CB77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8508D1C24091
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D3188A12;
	Fri, 23 Aug 2024 11:33:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0DF188A14;
	Fri, 23 Aug 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412829; cv=none; b=sMTtqe5WxxuCI+gzNDVoK4Kql01bYLNAqPpTZny7WquV5ob6hO5H41Q5YHp+aeI/oQ5x6lYDvyO09vHCYcBF/nS2Wrgyv+Cyigvcr1TpypHj7pUOPie5Jg2xz1uJV5PIV053WENLNhD0ZCBHdLtLTyc9PkZu3Uh2fvGFupCefV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412829; c=relaxed/simple;
	bh=Gp4VwjnMboKK/ZjgCFtsQFxNA2MCi84eMCBEeV59tGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M3vBkej6zbo2m3gF2z3tTO77NOjcyvDl5bfNtKKT5Q/d0dAbvXfhrRuc+qoXbBq6zJTxTcdsRcyWVXeEP4oiuvnUPJzx0AfJPBKjMzSj2Yltl2d9RU9ZIDfaMTXLvqACzPnvJcRgwoGFkFuviXuCTBljG2iWMdYrCY7Uetyq7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98315DA7;
	Fri, 23 Aug 2024 04:34:12 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E23E3F58B;
	Fri, 23 Aug 2024 04:33:44 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 7/8] perf auxtrace: Iterate all AUX events when finish reading
Date: Fri, 23 Aug 2024 12:33:05 +0100
Message-Id: <20240823113306.2310957-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113306.2310957-1-leo.yan@arm.com>
References: <20240823113306.2310957-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When finished to read AUX trace data from mmaped buffer, based on the
AUX buffer index the core layer needs to search the corresponding PMU
event and re-enable it to continue tracing.

However, current code only searches the first AUX event. It misses to
search other enabled AUX events, thus, it returns failure if the buffer
index does not belong to the first AUX event.

This patch changes to continue searching every enabled AUX events for
covering the mmaped buffer indexes.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 2acf63efab1d..864ed20794ab 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -690,9 +690,13 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 
 			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
 							       evsel, idx);
-			/* No map is found in per CPU mmap */
+			/*
+			 * No map is found in per CPU mmap. Multiple AUX events
+			 * might be opened in a session, continue to check if
+			 * the next AUX event can cover the mmaped buffer 'idx'.
+			 */
 			if (cpu_map_idx == -ENOENT)
-				return cpu_map_idx;
+				continue;
 
 			if (evsel->disabled)
 				return 0;
-- 
2.34.1


