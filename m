Return-Path: <linux-kernel+bounces-219719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24E90D6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C083282719
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F29152783;
	Tue, 18 Jun 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPOWYK6m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0228DC3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723543; cv=none; b=puE2MBcsHqq0EOD+sSblh2rZKXAViaeM1MGTOYy+vNPqiRa8sCy9dMSccKkUfQ3E2EEPkL+qhNG08jakRQSkCDUfqi0N6oufSkqfQ6Mkc0vQbpPGxkCrDisSQE6RxWbSSsj1T8nerqv0mVQ51V+f2wkITVyQNG7Wqd3Q7GcomwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723543; c=relaxed/simple;
	bh=7trYQVtVfDfgh31uDwek2t/HxT/pSeUZ7YfMoL5efRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBsi9XxgZUR9oH26hGKGWd+5KL4NEqqv3crMU2hW5USb6m5jr65elvmxAPrH4Xpoi3tM1IWuIQOJNiMVUl0fOjnG6A72YhLCyf30VZOMJwO0JRVVU8uMl0H3Z/du8jZRz1RmtmFtFM0KMoZ9k7LcgbkuSWOP+zGRLSE4cEdLEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPOWYK6m; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718723541; x=1750259541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7trYQVtVfDfgh31uDwek2t/HxT/pSeUZ7YfMoL5efRs=;
  b=OPOWYK6mC58WwR7430sYiecck02ZVLqcuowyHi9Zl/B/Rv8z2dhC+0L1
   w84a0d2mdXP7hpp6gDEEuwqiEMcuEI1RiZc6uZDCjREhm68u0qCQGTjWY
   LErH+TCX6juazbn6q7recogqci4Mmd4LIYabeRrjC8cKbIZy39uuYIwOm
   PFQ6kaOlFiWja69T8nSMSQ5BezjwZNG2bE6Pzt9sAagtc3l834m5n/+Na
   1a3EhnkPdDTbB+X7iWX1MiykPZIZF+5xkFmbkAm1M147DyJ2o81d779sw
   owF37D+seCMkeyhdSw410I+I7RCA6HWOTmgnRznzN02gyaUyyTglSDaIo
   w==;
X-CSE-ConnectionGUID: KaLqc1M/SEalCb7Z5/vRJA==
X-CSE-MsgGUID: IOpZlU0HSQ6Yz0TR9RzKmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15374233"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15374233"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:12:18 -0700
X-CSE-ConnectionGUID: iqhSWAYwSHexGWBECvv1wg==
X-CSE-MsgGUID: j+VTs509R0ut97Tcy36B9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="41426955"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Jun 2024 08:12:18 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 09/12] perf: Extend perf_output_read
Date: Tue, 18 Jun 2024 08:10:41 -0700
Message-Id: <20240618151044.1318612-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240618151044.1318612-1-kan.liang@linux.intel.com>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The event may have been updated in the PMU-specific implementation,
e.g., Intel PEBS counters snapshotting. The common code should not
read and overwrite the value.

The PERF_SAMPLE_READ in the data->sample_type can be used to detect
whether the PMU-specific value is available. If yes, avoid the
pmu->read() in the common code.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..733e507948e6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7243,7 +7243,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 
 static void perf_output_read_group(struct perf_output_handle *handle,
 			    struct perf_event *event,
-			    u64 enabled, u64 running)
+			    u64 enabled, u64 running, bool read)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
@@ -7265,7 +7265,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
+	if ((leader != event) && read &&
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
@@ -7280,7 +7280,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
+		if ((sub != event) && read &&
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
@@ -7307,7 +7307,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
  * on another CPU, from interrupt/NMI context.
  */
 static void perf_output_read(struct perf_output_handle *handle,
-			     struct perf_event *event)
+			     struct perf_event *event,
+			     bool read)
 {
 	u64 enabled = 0, running = 0, now;
 	u64 read_format = event->attr.read_format;
@@ -7325,7 +7326,7 @@ static void perf_output_read(struct perf_output_handle *handle,
 		calc_timer_values(event, &now, &enabled, &running);
 
 	if (event->attr.read_format & PERF_FORMAT_GROUP)
-		perf_output_read_group(handle, event, enabled, running);
+		perf_output_read_group(handle, event, enabled, running, read);
 	else
 		perf_output_read_one(handle, event, enabled, running);
 }
@@ -7367,7 +7368,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, data->period);
 
 	if (sample_type & PERF_SAMPLE_READ)
-		perf_output_read(handle, event);
+		perf_output_read(handle, event, !(data->sample_flags & PERF_SAMPLE_READ));
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -7968,7 +7969,7 @@ perf_event_read_event(struct perf_event *event,
 		return;
 
 	perf_output_put(&handle, read_event);
-	perf_output_read(&handle, event);
+	perf_output_read(&handle, event, true);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-- 
2.35.1


