Return-Path: <linux-kernel+bounces-257807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBB937F20
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15141C21181
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F03F8E2;
	Sat, 20 Jul 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rv1EzPt2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D051758E;
	Sat, 20 Jul 2024 06:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721456474; cv=none; b=F4HfoBWYPWkXAqhRRTQXvVj5uUfStmqUp/CEdVxVMsORuIM/KOGDIJVn0re+oBSIxc7mIqEWVZD95weIIuhS3fF7y5sglRu9RloF+ai7Pfixl842/l/Onav8KqmEMbb/Z/ypMYDys8vGh2ZdFfjMUQJmrI03cHQpYmzcVl8iaqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721456474; c=relaxed/simple;
	bh=UYxp0J5BBqmL4B6bO1B1wJ23uuONJPHgBsA/OrY61bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcmSV7DdDYN3UIccR8funJ0K+zAd+1UaTrqWCcqSUDREkhiwIPdvNKpj1ByUteYbKnh06ayplRLWTzVnGp3PZrbY7DMXa7Iml10SwwIgFk2PdCRKmtedvDW0lztEzMKMnR84eCex0m83MEcpySGdkHAsMdHRAdsCquZmH3ZLZ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rv1EzPt2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721456473; x=1752992473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UYxp0J5BBqmL4B6bO1B1wJ23uuONJPHgBsA/OrY61bc=;
  b=Rv1EzPt2WWNlMIXEyqrX14Npswq7Jw1puIAXQWQm0sLP15WO57RvbVxT
   RM+jJ33hJ0pIce334iDRKyzbRN8qxSs6WKcnVRRAZpz60zMzJT9HuWmoE
   pI4ESB9sh51B6u9lGjDTYuhVos0IX50RPOY6kcT3PB2cDULB76zI0TPka
   6yEt3S7KSpeWA6vQEQdJNWHEqcm3taMbR8rY0PR2hSGZIlLAPgzSfbhaI
   smyHZYQwn8wsw4JFKP67bgOcvHz3iRfex0vJqTeiBq2+lcLcCjfiiezIX
   NMmdARhOt4wvIleZ0NQO+crZ0ndS5WGR/lMVYMgtA/CK0jQUxD/2/Ewrz
   A==;
X-CSE-ConnectionGUID: xsSHfzRlTqKWEb0f6Pfp+Q==
X-CSE-MsgGUID: 3WmAvwMvRqyVX7b3tvdVSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11138"; a="12630489"
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="12630489"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 23:21:11 -0700
X-CSE-ConnectionGUID: ls2pgrbJRHir3KjKmDRiAw==
X-CSE-MsgGUID: eDQzjqraRYKMaKLhTubkig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,222,1716274800"; 
   d="scan'208";a="51403589"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 19 Jul 2024 23:21:10 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v18 4/8] perf stat: Plugin retire_lat value from sampled data to evsel
Date: Sat, 20 Jul 2024 02:20:57 -0400
Message-ID: <20240720062102.444578-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720062102.444578-1-weilin.wang@intel.com>
References: <20240720062102.444578-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

In current :R parsing implementation, the parser would recognize events with
retire_latency modifier and insert them into the evlist like a normal event.
Ideally, we need to avoid counting these events.

In this commit, at the time when a retire_latency evsel is read, set the retire
latency value processed from the sampled data to count value. This sampled
retire latency value will be used for metric calculation and final event count
print out. No special metric calculation and event print out code required for
retire_latency events.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/arch/x86/util/evlist.c |  6 ++++++
 tools/perf/util/evsel.c           | 15 +++++++++++++++
 tools/perf/util/evsel.h           |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index b1ce0c52d88d..cebdd483149e 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -89,6 +89,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 			return 1;
 	}
 
+	/* Retire latency event should not be group leader*/
+	if (lhs->retire_lat && !rhs->retire_lat)
+		return 1;
+	if (!lhs->retire_lat && rhs->retire_lat)
+		return -1;
+
 	/* Default ordering by insertion index. */
 	return lhs->core.idx - rhs->core.idx;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1d000fa2c6cf..d607056b73c9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -59,6 +59,7 @@
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
+#include "util/intel-tpebs.h"
 
 #include <linux/ctype.h>
 
@@ -1539,6 +1540,11 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
 	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
 }
 
+static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	return tpebs_set_evsel(evsel, cpu_map_idx, thread);
+}
+
 static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 			     u64 val, u64 ena, u64 run, u64 lost)
 {
@@ -1546,6 +1552,12 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
 
 	count = perf_counts(counter->counts, cpu_map_idx, thread);
 
+	if (counter->retire_lat) {
+		evsel__read_retire_lat(counter, cpu_map_idx, thread);
+		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
+		return;
+	}
+
 	count->val    = val;
 	count->ena    = ena;
 	count->run    = run;
@@ -1838,6 +1850,9 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (evsel__is_tool(evsel))
 		return evsel__read_tool(evsel, cpu_map_idx, thread);
 
+	if (evsel__is_retire_lat(evsel))
+		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
+
 	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
 		return evsel__read_group(evsel, cpu_map_idx, thread);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 14f777b9e03e..a5da4b03bb1c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -311,6 +311,11 @@ static inline bool evsel__is_tool(const struct evsel *evsel)
 	return evsel->tool_event != PERF_TOOL_NONE;
 }
 
+static inline bool evsel__is_retire_lat(const struct evsel *evsel)
+{
+	return evsel->retire_lat;
+}
+
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
-- 
2.43.0


