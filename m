Return-Path: <linux-kernel+bounces-240115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1047926940
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955EA1F24274
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A9191F9D;
	Wed,  3 Jul 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xc7DtAZF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5218FC7F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037008; cv=none; b=WAVH+BLL163tZwZwR4vm2JeMdzRPEcRSRJ16A/aNsXlzCS49M+9ii+HSzchxkRfOnMzgM5ElhyK9mgEhcb1aZRvQ6GhPB//+avkmP573wSCv4XYL1KUNc9PlS2GwrWeiNMPNAOsBW8YIVqVcMFYtovqy31JDq2bNsWazCoaHMLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037008; c=relaxed/simple;
	bh=1GaNK1PymifhZFxq0NBZ6fvfnfWs7uS6/JsGWQPLcdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXKaWMIFS3twDw20Gzf2ZtkT1JE6Hh7psUj4IoI3ipy9+VmXlHOz0vyFiQYNSrgyQaqEqPjqa/ipI9bF/P16Qj+v1otogv11pTzDGTMRiwg13CWDxX5mbf7QHQpeApFbejNSAXFK6yi7bp4biNqRWzo/T17ehjuw5GbYf9ZQhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xc7DtAZF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720037007; x=1751573007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1GaNK1PymifhZFxq0NBZ6fvfnfWs7uS6/JsGWQPLcdM=;
  b=Xc7DtAZFHhnR58vzL2XfznSMYYQPA+Izw10r4tMVs9v/wP/GI2/IXuq9
   5j4JqOr9hAowWMeGBWLgsJMFW7FiRgspalOUtaf5he+zE9uSJFxw3GJk2
   x5l5bD4ztnrV0uHMFIr6xD3dnz5l5WyuqiVb/X3mqAWDsdVQ+xX0YK44m
   Jf6htWVIBunTzbPCB20JRFtKK/ISwlpds5ICAWd4VqnspVtkehUzbBUVf
   DroDq5TS7pJkNYeCXL+P17kp0kc+2T6NadydTYfXeyc9lU5tVbJ8hkk6Q
   Z4ONfw1u5H83MFlmU2XaVIG5nOsxXUWdLqq8ALrYzyBPvAh+K8BRK0F5M
   A==;
X-CSE-ConnectionGUID: 2li2xUGOR2G51zZtQypj5g==
X-CSE-MsgGUID: BZC5kg9HTNuKy0OcCqsegg==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39807595"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39807595"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:03:26 -0700
X-CSE-ConnectionGUID: W4B8xxzOSku+WmCq2xwBQA==
X-CSE-MsgGUID: /1AW7v56Q2aaSvYVN10Y/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442580"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 13:03:25 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/9] perf evsel: Assign abbr name for the branch counter events
Date: Wed,  3 Jul 2024 13:03:52 -0700
Message-Id: <20240703200356.852727-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703200356.852727-1-kan.liang@linux.intel.com>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

There could be several branch counter events. If perf tool output the
result via the format "event name + a number", the line could be very
long and hard to read.

An abbreviation is introduced to replace the full event name in the
display. The abbreviation starts from 'A' to 'Z9', which can support
up to 286 events. The same abbreviation will be assigned if the same
events are found in the evlist. The next patch will utilize the
abbreviation name to show the branch counter events in the output.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.c | 53 +++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h  |  4 +++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6f5311d01a14..028169dcb53d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -33,6 +33,7 @@
 #include "util/bpf-filter.h"
 #include "util/stat.h"
 #include "util/util.h"
+#include "util/env.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
@@ -1262,15 +1263,65 @@ u64 evlist__combined_branch_type(struct evlist *evlist)
 	return branch_type;
 }
 
+static struct evsel *
+evlist__find_dup_event_from_prev(struct evlist *evlist, struct evsel *event)
+{
+	struct evsel *pos;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (event == pos)
+			break;
+		if ((pos->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) &&
+		    !strcmp(pos->name, event->name))
+			return pos;
+	}
+	return NULL;
+}
+
+#define MAX_NR_ABBR_NAME	(26 * 11)
+
+/*
+ * The abbr name is from A to Z9. If the number of event
+ * which requires the branch counter > MAX_NR_ABBR_NAME,
+ * return NA.
+ */
+static char *evlist__new_abbr_name(void)
+{
+	static int idx;
+	char str[3];
+	int i = idx / 26;
+
+	if (idx >= MAX_NR_ABBR_NAME)
+		return strdup("NA");
+
+	str[0] = 'A' + (idx % 26);
+
+	if (!i)
+		str[1] = '\0';
+	else {
+		str[1] = '0' + i - 1;
+		str[2] = '\0';
+	}
+
+	idx++;
+	return strdup(str);
+}
+
 void evlist__update_br_cntr(struct evlist *evlist)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *dup;
 	int i = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS) {
 			evsel->br_cntr_idx = i++;
 			evsel__leader(evsel)->br_cntr_nr++;
+
+			dup = evlist__find_dup_event_from_prev(evlist, evsel);
+			if (dup)
+				evsel->abbr_name = strdup(dup->abbr_name);
+			else
+				evsel->abbr_name = evlist__new_abbr_name();
 		}
 	}
 	evlist->nr_br_cntr = i;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a733d3407b35..bf37442002aa 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -152,9 +152,13 @@ struct evsel {
 	 * br_cntr_idx: The idx of the branch counter event in the evlist
 	 * br_cntr_nr:  The number of the branch counter event in the group
 	 *	        (Only available for the leader event)
+	 * abbr_name:   The abbreviation name assigned to an event which is
+	 *		logged by the branch counter.
 	 */
 	int			br_cntr_idx;
 	int			br_cntr_nr;
+	char			*abbr_name;
+
 	/*
 	 * bpf_counter_ops serves two use cases:
 	 *   1. perf-stat -b          counting events used byBPF programs
-- 
2.38.1


