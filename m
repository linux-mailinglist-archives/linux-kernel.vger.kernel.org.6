Return-Path: <linux-kernel+bounces-269374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9430B943228
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E221F223B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71461BC07D;
	Wed, 31 Jul 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6r9mk5I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD11BBBD6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436678; cv=none; b=LDZvc/l0c1JkYBSn7kh0eTdqIJOSGyGuy0Uy8CaTO5ThNyYJ7AdTVpGQduRyzbqUL5W8X9f3umA0rcvwwUnALihZ3e4jXXJImJnBql1n2Btj1E1qN67xhq4q1zyp1xsTm6I3vQfgu9OoC34Cmd8haFW+SAyjsy0hIbFo3tH3VVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436678; c=relaxed/simple;
	bh=jVDOCi1KfLth6h1o0JvRNsiOY34GdfN01cPp1eF3UZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WdbmmEfPwpWyXEHdD/VK0EsD4GAWBazDUcCUhyMsemx+8r/LS0s8CnYIRB4BuubwGbp+xYsEMqG3PVCFtiaoz2VeamuHsl7JbBsScWj75275ppkLSVlRzG68MZIvsroh2pdsayt6CdV6f10BCRDyYm+ri8Za7Ih3vhx1brBjuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6r9mk5I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722436676; x=1753972676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jVDOCi1KfLth6h1o0JvRNsiOY34GdfN01cPp1eF3UZ0=;
  b=j6r9mk5IN97qMtO2E1M7s1IdVJkTziETKIqshKFZ+FsNQ7AYD7wS+4Te
   FVyGaZ0LG7g3iVpaGzcY5rgDYSOw+eTzjsbNIUu4Jy+CUZJHg7tLwStmw
   jZcNXnSQkMC4+/PdYgHMc9RzNXPRQO7zdg9zAYww+f0CiVK9XRsvP9mAe
   9R+qcTO7CFFB1LLUIFHCLMCjXMVtzvr+hPpeTn7wU0zK6MdF/XEKqQQzy
   I3rIrFXnMA4ej+J6d0QZNwnkkmbFJrt38+t+xuvI2CyaBd63IW6WaDt80
   QoLW7lczKW50z8TOzZnFKi79v+Xvv+Jib9Eag/mnUxJuGwNP4NFJ4zCbq
   w==;
X-CSE-ConnectionGUID: uqjcBORaRYaSzdosYV9Kbg==
X-CSE-MsgGUID: JSaj+6UaQxqDsUF7tHDUSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="37835856"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="37835856"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 07:37:53 -0700
X-CSE-ConnectionGUID: CIXD4V/iSfarPv2GZZb4aw==
X-CSE-MsgGUID: 9mZITuMtQyu0ecBSiYYIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54698387"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2024 07:37:53 -0700
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
Subject: [PATCH V4 2/5] perf: Extend perf_output_read
Date: Wed, 31 Jul 2024 07:38:32 -0700
Message-Id: <20240731143835.771618-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240731143835.771618-1-kan.liang@linux.intel.com>
References: <20240731143835.771618-1-kan.liang@linux.intel.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..fcc55d0b5848 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7269,7 +7269,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 
 static void perf_output_read_group(struct perf_output_handle *handle,
 			    struct perf_event *event,
-			    u64 enabled, u64 running)
+			    u64 enabled, u64 running, bool read)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
@@ -7291,7 +7291,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
+	if ((leader != event) && read &&
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
@@ -7306,7 +7306,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
+		if ((sub != event) && read &&
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
@@ -7333,7 +7333,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
  * on another CPU, from interrupt/NMI context.
  */
 static void perf_output_read(struct perf_output_handle *handle,
-			     struct perf_event *event)
+			     struct perf_event *event,
+			     bool read)
 {
 	u64 enabled = 0, running = 0, now;
 	u64 read_format = event->attr.read_format;
@@ -7351,7 +7352,7 @@ static void perf_output_read(struct perf_output_handle *handle,
 		calc_timer_values(event, &now, &enabled, &running);
 
 	if (event->attr.read_format & PERF_FORMAT_GROUP)
-		perf_output_read_group(handle, event, enabled, running);
+		perf_output_read_group(handle, event, enabled, running, read);
 	else
 		perf_output_read_one(handle, event, enabled, running);
 }
@@ -7393,7 +7394,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, data->period);
 
 	if (sample_type & PERF_SAMPLE_READ)
-		perf_output_read(handle, event);
+		perf_output_read(handle, event, !(data->sample_flags & PERF_SAMPLE_READ));
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -7994,7 +7995,7 @@ perf_event_read_event(struct perf_event *event,
 		return;
 
 	perf_output_put(&handle, read_event);
-	perf_output_read(&handle, event);
+	perf_output_read(&handle, event, true);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
-- 
2.38.1


