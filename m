Return-Path: <linux-kernel+bounces-291761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCAC95667A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C781F227BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC7415E5BD;
	Mon, 19 Aug 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFMTQKZd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DF15E5B5
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058729; cv=none; b=FBjncXTcsGPm3tRaNCkEvECLVwVto0RDS/KLDO1YQs16MVUz/7eKnexOeNvTCdLjZ1TWp3r8rJg9vAGGv3+pcyYf5uRE3+tuhBBc3baX7+Uxx+XbVLb8m3GWjVaLGnmu22YTYhwIBmP8kFTr4fd2pHXVHYXEnsOWCd2s6qzz+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058729; c=relaxed/simple;
	bh=D1bSyYfHNPk7edhBSRp+tNk9imiD3d76nZBkbDrWfOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvR+ihQFv1mT4YAvV5ECD0TV37UAWxfZbgIH0/QuVF5APvwMIy8ONRGwZuUfZ3/LOshQ28XDybQ1ajVECji45oBLK7FRA/QX1VQuRu5Q3WIZpcocPWIZ30PmztYVPftZgWgbM7NBSYFNvQ5F+yEswgosuF5Mwq0yqYpDyESBsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFMTQKZd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724058728; x=1755594728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1bSyYfHNPk7edhBSRp+tNk9imiD3d76nZBkbDrWfOY=;
  b=NFMTQKZd5KpA8aU9w8aOy6A5TX5gjWt+Sq7/HxWoxrkUBbWxjSiInMQV
   3OPdTByPtwuGGbq4UuVTus5eX2NXs7mtMVjqcOWfDQ+7yXmUB/YC95gUQ
   mQxo3femQ3lwzSQhH4ZULX0pOubVI7rvRQYHRbXFITzYAu+oN6rK/dEuu
   +N28JB/GPz+Zby7s2x9IqrCnFNdam4Eh19iclpo/4MzWBveBHfcaeM/mk
   JjUe+EYyy6/8hA8jIpr6XqSoxIRSUQP/rPObMUqLF/CSQUb3u4V51MS+s
   VyBYytaMA6F7e0mJ4dtVUFQgy/qUXERxOKHVj6IiD4TfYp651gu9LV3hu
   w==;
X-CSE-ConnectionGUID: 12aNCb99RgSi7ETNFlDMvw==
X-CSE-MsgGUID: uTJrsEkKTLCbMvqn94Z27A==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33446111"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33446111"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 02:12:07 -0700
X-CSE-ConnectionGUID: oZF2dkRsSYKRrhhflQPBMQ==
X-CSE-MsgGUID: ZqrrxDkPRwuiKvPh04Ce8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="61086730"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa008.jf.intel.com with ESMTP; 19 Aug 2024 02:12:04 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Yongwei Ma <yongwei.ma@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 4/4] perf/x86/intel: Add PMU support for ArrowLake-H
Date: Mon, 19 Aug 2024 14:55:43 +0000
Message-Id: <20240819145543.1833126-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
References: <20240819145543.1833126-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ArrowLake-H contains 3 different uarchs, LionCove, Skymont and Crestmont.
It is different with previous hybrid processors which only contains two
kinds of uarchs.

This patch adds PMU support for ArrowLake-H processor, adds ARL-H
specific events which supports the 3 kinds of uarchs, such as
td_retiring_arl_h, and extends some existed format attributes like
offcore_rsp to make them be available to support ARL-H as well. Althrough
these format attributes like offcore_rsp have been extended to support
ARL-H, they can still support the regular hybrid platforms with 2 kinds
of uarchs since the helper hybrid_format_is_visible() would filter PMU
types and only show the format attribute for available PMUs.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
 arch/x86/events/intel/core.c | 105 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  21 +++++++
 arch/x86/events/perf_event.h |   4 ++
 3 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 62ef039f461f..894cf911719b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4589,6 +4589,28 @@ static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
 	return HYBRID_INTEL_CORE;
 }
 
+static struct event_constraint *
+arl_h_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_tiny)
+		return cmt_get_event_constraints(cpuc, idx, event);
+
+	return mtl_get_event_constraints(cpuc, idx, event);
+}
+
+static int arl_h_hw_config(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_tiny)
+		return intel_pmu_hw_config(event);
+
+	return adl_hw_config(event);
+}
+
 /*
  * Broadwell:
  *
@@ -5952,6 +5974,37 @@ static struct attribute *lnl_hybrid_events_attrs[] = {
 	NULL
 };
 
+/* The event string must be in PMU IDX order. */
+EVENT_ATTR_STR_HYBRID(topdown-retiring,
+		      td_retiring_arl_h,
+		      "event=0xc2,umask=0x02;event=0x00,umask=0x80;event=0xc2,umask=0x0",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(topdown-bad-spec,
+		      td_bad_spec_arl_h,
+		      "event=0x73,umask=0x0;event=0x00,umask=0x81;event=0x73,umask=0x0",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,
+		      td_fe_bound_arl_h,
+		      "event=0x9c,umask=0x01;event=0x00,umask=0x82;event=0x71,umask=0x0",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,
+		      td_be_bound_arl_h,
+		      "event=0xa4,umask=0x02;event=0x00,umask=0x83;event=0x74,umask=0x0",
+		      hybrid_big_small_tiny);
+
+static struct attribute *arl_h_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_adl),
+	EVENT_PTR(td_retiring_arl_h),
+	EVENT_PTR(td_bad_spec_arl_h),
+	EVENT_PTR(td_fe_bound_arl_h),
+	EVENT_PTR(td_be_bound_arl_h),
+	EVENT_PTR(td_heavy_ops_adl),
+	EVENT_PTR(td_br_mis_adl),
+	EVENT_PTR(td_fetch_lat_adl),
+	EVENT_PTR(td_mem_bound_adl),
+	NULL,
+};
+
 /* Must be in IDX order */
 EVENT_ATTR_STR_HYBRID(mem-loads,     mem_ld_adl,     "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", hybrid_big_small);
 EVENT_ATTR_STR_HYBRID(mem-stores,    mem_st_adl,     "event=0xd0,umask=0x6;event=0xcd,umask=0x2",                 hybrid_big_small);
@@ -5970,6 +6023,21 @@ static struct attribute *mtl_hybrid_mem_attrs[] = {
 	NULL
 };
 
+EVENT_ATTR_STR_HYBRID(mem-loads,
+		      mem_ld_arl_h,
+		      "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3;event=0xd0,umask=0x5,ldlat=3",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(mem-stores,
+		      mem_st_arl_h,
+		      "event=0xd0,umask=0x6;event=0xcd,umask=0x2;event=0xd0,umask=0x6",
+		      hybrid_big_small_tiny);
+
+static struct attribute *arl_h_hybrid_mem_attrs[] = {
+	EVENT_PTR(mem_ld_arl_h),
+	EVENT_PTR(mem_st_arl_h),
+	NULL,
+};
+
 EVENT_ATTR_STR_HYBRID(tx-start,          tx_start_adl,          "event=0xc9,umask=0x1",          hybrid_big);
 EVENT_ATTR_STR_HYBRID(tx-commit,         tx_commit_adl,         "event=0xc9,umask=0x2",          hybrid_big);
 EVENT_ATTR_STR_HYBRID(tx-abort,          tx_abort_adl,          "event=0xc9,umask=0x4",          hybrid_big);
@@ -5993,8 +6061,8 @@ static struct attribute *adl_hybrid_tsx_attrs[] = {
 
 FORMAT_ATTR_HYBRID(in_tx,       hybrid_big);
 FORMAT_ATTR_HYBRID(in_tx_cp,    hybrid_big);
-FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small);
-FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small);
+FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small_tiny);
+FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small_tiny);
 FORMAT_ATTR_HYBRID(frontend,    hybrid_big);
 
 #define ADL_HYBRID_RTM_FORMAT_ATTR	\
@@ -6017,7 +6085,7 @@ static struct attribute *adl_hybrid_extra_attr[] = {
 	NULL
 };
 
-FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small);
+FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small_tiny);
 
 static struct attribute *mtl_hybrid_extra_attr_rtm[] = {
 	ADL_HYBRID_RTM_FORMAT_ATTR,
@@ -7098,6 +7166,37 @@ __init int intel_pmu_init(void)
 		name = "lunarlake_hybrid";
 		break;
 
+	case INTEL_ARROWLAKE_H:
+		intel_pmu_init_hybrid(hybrid_big_small_tiny);
+
+		x86_pmu.pebs_latency_data = arl_h_latency_data;
+		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
+		x86_pmu.hw_config = arl_h_hw_config;
+
+		td_attr = arl_h_hybrid_events_attrs;
+		mem_attr = arl_h_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
+
+		/* Initialize Atom2 core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_TINY_IDX];
+		intel_pmu_init_grt(&pmu->pmu);
+		pmu->extra_regs = intel_cmt_extra_regs;
+
+		intel_pmu_pebs_data_source_arl_h();
+		pr_cont("ArrowLake-H Hybrid events, ");
+		name = "arrowlake_h_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fa5ea65de0d0..8afc4ad3cd16 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -177,6 +177,17 @@ void __init intel_pmu_pebs_data_source_mtl(void)
 	__intel_pmu_pebs_data_source_cmt(data_source);
 }
 
+void __init intel_pmu_pebs_data_source_arl_h(void)
+{
+	u64 *data_source;
+
+	intel_pmu_pebs_data_source_lnl();
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_TINY_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	__intel_pmu_pebs_data_source_cmt(data_source);
+}
+
 void __init intel_pmu_pebs_data_source_cmt(void)
 {
 	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
@@ -388,6 +399,16 @@ u64 lnl_latency_data(struct perf_event *event, u64 status)
 	return lnc_latency_data(event, status);
 }
 
+u64 arl_h_latency_data(struct perf_event *event, u64 status)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_tiny)
+		return cmt_latency_data(event, status);
+
+	return lnl_latency_data(event, status);
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6b8e098daf2f..4ca91830697b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1592,6 +1592,8 @@ u64 cmt_latency_data(struct perf_event *event, u64 status);
 
 u64 lnl_latency_data(struct perf_event *event, u64 status);
 
+u64 arl_h_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
@@ -1711,6 +1713,8 @@ void intel_pmu_pebs_data_source_grt(void);
 
 void intel_pmu_pebs_data_source_mtl(void);
 
+void intel_pmu_pebs_data_source_arl_h(void);
+
 void intel_pmu_pebs_data_source_cmt(void);
 
 void intel_pmu_pebs_data_source_lnl(void);
-- 
2.40.1


