Return-Path: <linux-kernel+bounces-230977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B95918485
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A381A1C20CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8718FDB2;
	Wed, 26 Jun 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFLJiCU0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579AF18FC64
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412513; cv=none; b=RE+wgA72Q9zpQhzcAmqIz60mlxaQxdFIbj7QWC+4159Sj2wr495aP3dbV0FY74Jtz351WDl1/qdZ4DVIIxb1P0egzJ1S5+WsQ/px3JycOfFGYkHx5TQCiPViIe2vARGo1GnN1+U7zFxRkTSraOpOE1EhxdYe4Mw32aafC3n4m30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412513; c=relaxed/simple;
	bh=ZzbzUKgmJ61REAZSX6FW8fCqG6lxjdeXPMQT33O/UQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGNOnxYg+xWCo1Sy38bguRvnM1XolRF+L+dcWKEJ/OHKe9m4Ho1as7RcKTxsEEOX5fKjcwmpcs+3kn5PwwnpGX4I0DkKgdz1GpbUhjQ1QzsFFncrjMNlidqDf9iSNVxmDRx/RmmKB0H6mdPWzpTGwOJHp5L8vYD2EVuKWOQ+2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFLJiCU0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719412512; x=1750948512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZzbzUKgmJ61REAZSX6FW8fCqG6lxjdeXPMQT33O/UQ4=;
  b=cFLJiCU0Z+zG1xluEqD/E9HO3uHXEQktEwK/d+dL1xG+AHFtPW+wfljO
   LNEYXPuHbiWgoUlcyDH3SElFJoIH4hOFrYYG3t1/JgKd+Epm2u2XWHGyF
   cUYghAZdM8P4qPyHBrvI1uPLcJM2btlpT5lSV+HHQkaSwwxD/5rBLvPfG
   VNNcMQ0DCGNqpJYS5MtC7B2OODZK/05y/o4/2yesEbLkHUUNpGyjq00j+
   1xn3m6i6Q64j6hHQLHVLTwonanOH34hhtWMi5Y9VHZK+JjaGg7cp0zQO8
   lKeUy3cajekIb54hvG0UYzlOY9vUlnp4v7hHa9JwDy3k0HNN3nMrSDvpE
   w==;
X-CSE-ConnectionGUID: B03i/Ul/QHa7ya+payt9QA==
X-CSE-MsgGUID: jXuTCdSWQZyiVEUEGK5wVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="19375564"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="19375564"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:34:46 -0700
X-CSE-ConnectionGUID: flj7B/YxQf64IndG722Gfw==
X-CSE-MsgGUID: Ib46YsQWSBKYD+7jceEf2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="43911980"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 26 Jun 2024 07:34:46 -0700
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
Subject: [PATCH V3 10/13] perf: Extend perf_output_read
Date: Wed, 26 Jun 2024 07:35:42 -0700
Message-Id: <20240626143545.480761-11-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240626143545.480761-1-kan.liang@linux.intel.com>
References: <20240626143545.480761-1-kan.liang@linux.intel.com>
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
2.38.1


