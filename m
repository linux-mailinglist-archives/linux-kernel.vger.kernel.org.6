Return-Path: <linux-kernel+bounces-272699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BDD94600C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E462843BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A3B21C18D;
	Fri,  2 Aug 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nakr+78l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF682101A4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611763; cv=none; b=R9mkkus3ojCh2uzRTOU3vl4qOnd2xq5rt7s+fbKaaXXXnINgGxOjWYT710+BF9UVRP/rrM6zD6JRxXFEzVngsWtcvlpRT6MDrEGZzuQZbpPXJCYOy9BJQKA2WYG8tJ+qOeq/UKpod7U0AUr1VKkIOjB+1IPNa6Nk6bHMO1PmCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611763; c=relaxed/simple;
	bh=onkK7eGKtLJBosXsYvUv4xlTMHPEHaRONgXoxX6LRTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfGZufXHSOy1tmAJbFV+0pvfUQ/N4RQ2MddWNokHx6D7A5Kn7jDMnUOZC7bdmyVGL67RhqmcDc5OQ/28b8vrfyCSXja6HD6r+BsTObSUajbFPBzP6smg7uLEzxAxuaNFhk5BmnPdSQ/ATHJeLhiEQEyEzThv3iagOjEiZTvb3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nakr+78l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722611762; x=1754147762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onkK7eGKtLJBosXsYvUv4xlTMHPEHaRONgXoxX6LRTw=;
  b=nakr+78lwJCHM0cOWvGolr3Jrkppi3C0Z9lrL6f8fDaEY+kaDCNsvDCE
   Zy8hkxNttp+zUpExBSZTK+AkP9AJ4Q6syUTlcrWFDO8A9EYijAfH4xTD+
   uMoOWvEceG9RCdiL976JOOl6lqW+QLh67ldfZDdl3SgMtAYUi7bl2SoqQ
   M2kaFddAZlz5zXObqrUTA+4n5v7Virozzs/D3sjFWqswYPZ5ALep0wB1t
   V6AlvJZ3C7Tv7eJX12IY+BuYUB9VzeKjD434Wb6bhtFcq+E7L/F7pSHWi
   t0aIGbJ/I4m81pOtOqZZPKtNFADf0AVmsOoPEUr+cBzBASSaAn0yYMhRv
   A==;
X-CSE-ConnectionGUID: XLwjHKXpSwGvGc4Abu1y6A==
X-CSE-MsgGUID: K3mjAHv1RV22kwyfg5iuOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20473762"
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="20473762"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 08:15:59 -0700
X-CSE-ConnectionGUID: tV7qxRiOQIixsbqeXItJxw==
X-CSE-MsgGUID: uIEbc+T/TFqLPNLW/K05Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="55516931"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 02 Aug 2024 08:15:58 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/7] perf: Add PERF_EV_CAP_READ_SCOPE
Date: Fri,  2 Aug 2024 08:16:38 -0700
Message-Id: <20240802151643.1691631-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240802151643.1691631-1-kan.liang@linux.intel.com>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Usually, an event can be read from any CPU of the scope. It doesn't need
to be read from the advertised CPU.

Add a new event cap, PERF_EV_CAP_READ_SCOPE. An event of a PMU with
scope can be read from any active CPU in the scope.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 14 +++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1102d5c2be70..1206bc86eb4f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -633,10 +633,13 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  * PERF_EV_CAP_SIBLING: An event with this flag must be a group sibling and
  * cannot be a group leader. If an event with this flag is detached from the
  * group it is scheduled out and moved into an unrecoverable ERROR state.
+ * PERF_EV_CAP_READ_SCOPE: A CPU event that can be read from any CPU of the
+ * PMU scope where it is active.
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
 #define PERF_EV_CAP_SIBLING		BIT(2)
+#define PERF_EV_CAP_READ_SCOPE		BIT(3)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5e1877c4cb4c..c55294f34575 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4463,16 +4463,24 @@ struct perf_read_data {
 	int ret;
 };
 
+static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int scope, int cpu);
+
 static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
+	int local_cpu = smp_processor_id();
 	u16 local_pkg, event_pkg;
 
 	if ((unsigned)event_cpu >= nr_cpu_ids)
 		return event_cpu;
 
-	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
-		int local_cpu = smp_processor_id();
+	if (event->group_caps & PERF_EV_CAP_READ_SCOPE) {
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(event->pmu->scope, event_cpu);
+
+		if (cpumask && cpumask_test_cpu(local_cpu, cpumask))
+			return local_cpu;
+	}
 
+	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
 		event_pkg = topology_physical_package_id(event_cpu);
 		local_pkg = topology_physical_package_id(local_cpu);
 
@@ -11804,7 +11812,7 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 				if (cpu >= nr_cpu_ids)
 					ret = -ENODEV;
 				else
-					event->cpu = cpu;
+					event->event_caps |= PERF_EV_CAP_READ_SCOPE;
 			} else {
 				ret = -ENODEV;
 			}
-- 
2.38.1


