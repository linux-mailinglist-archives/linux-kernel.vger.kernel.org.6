Return-Path: <linux-kernel+bounces-330932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2D97A63A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBF41F22718
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6E155CA5;
	Mon, 16 Sep 2024 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KasvjDXl"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34F15B15D;
	Mon, 16 Sep 2024 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505367; cv=fail; b=a+hIF/Tll6RuuCq16Jd4h20s2rB0pmCX0ikQUxms7w1TYfOUiavDxzri7Tb2+gEt6TsyaeONpLdpzWXRON4Vxf90boSM9bxgsq9ntH5F67lNFKHvZhtihNRembb8nSatIkTMcEVLkjMC49sApPKCAQQUvfpxwRQmeOIYN9Ybb6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505367; c=relaxed/simple;
	bh=+6Np/n6ZF0VaY4Z3psw7PMQURsMjqw5PO+vg8hhp2qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG8thDGnvp+LBYZkaKziEL2Q9Wxc1PjBIAxKaLNGID5eY9SRpRQ2QYH+A5XlB1rPlpbOR6jWXwYHtejM+CfIODISyrQ1LcJDNQsaCgHfTqe0CNeLPBFhveJKy+JEK4HAvqv89kYry77rwC0WwGN1c3Y0sZKH5IoeQw66OlblQuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KasvjDXl; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0vitkF/vwcJpqJrWhQhCWw0il0QhYbUh85Bg9Q6HFjIOMl7FrtK5rSBh1ZMmXbrdVF0YV4Y6hjYwtAzavu4eXuMZScHF/V83yqHkdl2Os+dXhwqOzAelZ0ronKtKg6ngCR7LIaHYhuS5PNj1v+H49WGwwGlMb+HAB1pkdJCIV494hWLSCnBnwkAZFPNUaCKnCXhKybzJmeYANM881mAfh3E3P/1iujdeIqjg2ObmA+scke4kkshmJYzJEReiyTb5B0xS6KUwxA1FHWRVEV1NTf+sTfwQYO7sGen8JzBQrX/a5tUDfu0iqHEnupTU0L70m4A2JAbMY2CrtD/whEdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrTCKjuaFH3//6fOqm9+1VCh2EmXVN41pRNoM8SFfxY=;
 b=GuyPhuyYeB+yjQ5JxROt5nU5LfwMypgIQBo0aRT9r0yznHyfTKQSZOCrLp9+4GCqIue7Q5jNIxcLg1pMxqMOam/EPHitBrDWaHI27/tXs+OY097wk7u9oWJOLlAG+CdEdrlYNhPX7cRdMqEm0Ua9PmvK7ny5JVH8owEcQ8PSvkMiyg7fUS+z+rGOHMW5LD8RmgMGkYkErRvfTJEGz1ClGNbNdXQ+LseQ6mwcd263QJ4BHpy2x2VBvPirtvTAaDB3lnMp1/XcXo+a6P0MrQzrImwdiFwyjTirkLoTCMYZj4xheduUkCyHfHHCUaURG93A4VTJDD9aiT2pkStwew3Seg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrTCKjuaFH3//6fOqm9+1VCh2EmXVN41pRNoM8SFfxY=;
 b=KasvjDXlxP0MqNSaRk2gmy21y+rprA9nxtv1uQ9uBMZciXUJbl/rRwJWw//95MiJ41w+u8NH8SAK7Uce+tlgClA4lMmKM/AVAE6baUcITWBNSiNbxgPguBkqApkjyfqP3CIZ/yUH31FTVZUs1aEMh0nuGXAUy2VGNX+ZXFWtDhg=
Received: from SJ0PR13CA0136.namprd13.prod.outlook.com (2603:10b6:a03:2c6::21)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 16:49:19 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::95) by SJ0PR13CA0136.outlook.office365.com
 (2603:10b6:a03:2c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Mon, 16 Sep 2024 16:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:49:18 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:49:09 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<bristot@redhat.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/5] perf sched stats: Add record and rawdump support
Date: Mon, 16 Sep 2024 16:47:19 +0000
Message-ID: <20240916164722.1838-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 6863df1f-7d64-4534-80ec-08dcd66f81b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?az6fWuaofZMEzjT3ECXBYVgmWD3Y0uRw8PDQpyUR0omiaM4NvxT2imn7OCHj?=
 =?us-ascii?Q?Wxxx5Ykfev9oduU5iRu3nBhmKctv4tYPFlQ+xZ+JlO/QN+18xeNEiUGnovFv?=
 =?us-ascii?Q?n0lqXGvn+UTBMBW359zym8PCeclSkenMubyzUxlFR2Txh8MDogwDa0TnNH5C?=
 =?us-ascii?Q?WsevL5x+zI86gs9YjO4ewpVyPfnP0LP1Og/7lnh+C9k4xLalpb6d5PpmLBLq?=
 =?us-ascii?Q?jnCacu8KZZuW88ZeiPfLGeJLEyeJHpqKxtYH6dDL07DDjhrfZ0993ESkdNe7?=
 =?us-ascii?Q?A155kR3bnQXE+P6hTX4V40TuHfOm7ck9WnWOio81P5QrGoEtBHo/Q0IcVgi6?=
 =?us-ascii?Q?JLzCuc+lHuWUEjI2d0oxizjT2niDDngsjJO+DlbTkCARWW+YpaRebJ7DGfxq?=
 =?us-ascii?Q?VFhviPkJc9lyb58klC5bR8+5wgZCn+4JF6TbmAsFIe/vTp383ryP1bE9KHlB?=
 =?us-ascii?Q?AbRfZ4Wtpdy1OARCEMio5VzIxYcO4Ur1mpjGtubP2aFpMtFt5lG0SvrFDh3e?=
 =?us-ascii?Q?m6sHHNVFBX8Zutg808A5rm4P9zH/0w4K3MapJr+dGyNJYwUTyfDeVYiu82On?=
 =?us-ascii?Q?5NcrqfyHgOxl85A3CpkyYDAPXlU04eu8ZKt+18LcNkNgWFYpptibEe5qpv9d?=
 =?us-ascii?Q?wxlhEm1o6L/5oshxtt12Ei8dpVYNLfkheEyNUX59kYVCkeL+CjhlaER/JTP1?=
 =?us-ascii?Q?qvOy36rkfZmMKwRDCFHal8MtIBCOCU83zZtJCItuGRcqgCVR/zEzzjJg7XZU?=
 =?us-ascii?Q?IYcpfjaKw/g5FxwSi6E4lbfTnrhkkwzj5TZogGN7GfGI1/wGKF4bj7/n5Inw?=
 =?us-ascii?Q?SQK94CSSmm/dwYg21M+X8Gjlw+rzUPKZv3wZWyMi7fgEP577DoRd0yvmvMJY?=
 =?us-ascii?Q?UEiXKlJr4UwEKgSsBhEzLC/YJxer/AQ2e/yauBcrO4J7pcaB49Q1HDlEbJhb?=
 =?us-ascii?Q?s0zrDVbVVJLWEONGU/QanzJURqC7uYExwGL4zLRi9Jqc10WTa+eHBF33XT3K?=
 =?us-ascii?Q?cF+1dnEoSHVXqKJYtgtw0ZD6O1m79Ss8sSFVvq+o+n4q8FNJNLYgJJ0bl6eX?=
 =?us-ascii?Q?jDEpr/dvQIg6eb3uT5hCRPgxG7iXG/Rkv6uaQWndzf9loinSQ0l6dWdLYW5K?=
 =?us-ascii?Q?dteONCX2UM7i8kHKX5LMO9Co9HCgvmjNMhE21xUHKuBuKbpC2D8ZggA4/Mc5?=
 =?us-ascii?Q?bHQpPt+1kA+PZfwbgt0Xk3xZSIME6EBg66JUshMJDjvNWwUahs8VtDfYMyJW?=
 =?us-ascii?Q?wygWoDA3Ts4yUvoI/J2/y8kGxhmjy6Hyb9WJLl6vF/gVNWB03+7v3pPtAGqv?=
 =?us-ascii?Q?W+7hEOjfIzdrmAYYEo8JVz1DrriqbMN2eS5rHrcMr9FEpVwZ6k8fH2y/CUjm?=
 =?us-ascii?Q?iF9kEOtRWWhaFIll5poGVkEPPY/wn40vl6YtvyGeEktL+tWUbEmEExH2Yt7A?=
 =?us-ascii?Q?AhI0WArTDQEYk3CgCryxWNCURPIlDxKh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:49:18.4165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6863df1f-7d64-4534-80ec-08dcd66f81b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

Define new, perf tool only, sample types and their layouts. Add logic
to parse /proc/schedstat, convert it to perf sample format and save
samples to perf.data file with `perf sched stats record` command. Also
add logic to read perf.data file, interpret schedstat samples and
print rawdump of samples with `perf script -D`.

Note that, /proc/schedstat file output is standardized with version
number. The patch supports v15 but older or newer version can be added
easily.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/lib/perf/Documentation/libperf.txt      |   2 +
 tools/lib/perf/Makefile                       |   2 +-
 tools/lib/perf/include/perf/event.h           |  42 +++
 .../lib/perf/include/perf/schedstat-cpu-v15.h |  13 +
 .../perf/include/perf/schedstat-domain-v15.h  |  40 +++
 tools/perf/builtin-inject.c                   |   2 +
 tools/perf/builtin-sched.c                    | 222 +++++++++++++++-
 tools/perf/util/event.c                       |  98 +++++++
 tools/perf/util/event.h                       |   2 +
 tools/perf/util/session.c                     |  20 ++
 tools/perf/util/synthetic-events.c            | 249 ++++++++++++++++++
 tools/perf/util/synthetic-events.h            |   3 +
 tools/perf/util/tool.c                        |  20 ++
 tools/perf/util/tool.h                        |   4 +-
 14 files changed, 716 insertions(+), 3 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/schedstat-cpu-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-domain-v15.h

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index fcfb9499ef9c..39c78682ad2e 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -211,6 +211,8 @@ SYNOPSIS
   struct perf_record_time_conv;
   struct perf_record_header_feature;
   struct perf_record_compressed;
+  struct perf_record_schedstat_cpu;
+  struct perf_record_schedstat_domain;
 --
 
 DESCRIPTION
diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 3a9b2140aa04..ebbfea891a6a 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -187,7 +187,7 @@ install_lib: libs
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
 
-HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
+HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h schedstat-cpu-v15.h schedstat-domain-v15.h
 INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
 
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 37bb7771d914..35be296d68d5 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -457,6 +457,44 @@ struct perf_record_compressed {
 	char			 data[];
 };
 
+struct perf_record_schedstat_cpu_v15 {
+#define CPU_FIELD(_type, _name, _ver)		_type _name;
+#include "schedstat-cpu-v15.h"
+#undef CPU_FIELD
+};
+
+struct perf_record_schedstat_cpu {
+	struct perf_event_header header;
+	__u16			 version;
+	__u64			 timestamp;
+	__u32			 cpu;
+	union {
+		struct perf_record_schedstat_cpu_v15 v15;
+	};
+};
+
+struct perf_record_schedstat_domain_v15 {
+#define DOMAIN_FIELD(_type, _name, _ver)	_type _name;
+#include "schedstat-domain-v15.h"
+#undef DOMAIN_FIELD
+};
+
+#define DOMAIN_NAME_LEN		16
+
+struct perf_record_schedstat_domain {
+	struct perf_event_header header;
+	__u16			 version;
+	__u64			 timestamp;
+	__u32			 cpu;
+	__u16			 domain;
+	char			 name[DOMAIN_NAME_LEN];
+	union {
+		struct perf_record_schedstat_domain_v15 v15;
+	};
+	__u16			 nr_cpus;
+	__u8			 cpu_mask[];
+};
+
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
@@ -478,6 +516,8 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_HEADER_FEATURE		= 80,
 	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_FINISHED_INIT		= 82,
+	PERF_RECORD_SCHEDSTAT_CPU		= 83,
+	PERF_RECORD_SCHEDSTAT_DOMAIN		= 84,
 	PERF_RECORD_HEADER_MAX
 };
 
@@ -518,6 +558,8 @@ union perf_event {
 	struct perf_record_time_conv		time_conv;
 	struct perf_record_header_feature	feat;
 	struct perf_record_compressed		pack;
+	struct perf_record_schedstat_cpu	schedstat_cpu;
+	struct perf_record_schedstat_domain	schedstat_domain;
 };
 
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/lib/perf/include/perf/schedstat-cpu-v15.h b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
new file mode 100644
index 000000000000..8e4355ee3705
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-cpu-v15.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CPU_FIELD
+CPU_FIELD(__u32, yld_count, v15)
+CPU_FIELD(__u32, array_exp, v15)
+CPU_FIELD(__u32, sched_count, v15)
+CPU_FIELD(__u32, sched_goidle, v15)
+CPU_FIELD(__u32, ttwu_count, v15)
+CPU_FIELD(__u32, ttwu_local, v15)
+CPU_FIELD(__u64, rq_cpu_time, v15)
+CPU_FIELD(__u64, run_delay, v15)
+CPU_FIELD(__u64, pcount, v15)
+#endif
diff --git a/tools/lib/perf/include/perf/schedstat-domain-v15.h b/tools/lib/perf/include/perf/schedstat-domain-v15.h
new file mode 100644
index 000000000000..422e713d617a
--- /dev/null
+++ b/tools/lib/perf/include/perf/schedstat-domain-v15.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef DOMAIN_FIELD
+DOMAIN_FIELD(__u32, idle_lb_count, v15)
+DOMAIN_FIELD(__u32, idle_lb_balanced, v15)
+DOMAIN_FIELD(__u32, idle_lb_failed, v15)
+DOMAIN_FIELD(__u32, idle_lb_imbalance, v15)
+DOMAIN_FIELD(__u32, idle_lb_gained, v15)
+DOMAIN_FIELD(__u32, idle_lb_hot_gained, v15)
+DOMAIN_FIELD(__u32, idle_lb_nobusyq, v15)
+DOMAIN_FIELD(__u32, idle_lb_nobusyg, v15)
+DOMAIN_FIELD(__u32, busy_lb_count, v15)
+DOMAIN_FIELD(__u32, busy_lb_balanced, v15)
+DOMAIN_FIELD(__u32, busy_lb_failed, v15)
+DOMAIN_FIELD(__u32, busy_lb_imbalance, v15)
+DOMAIN_FIELD(__u32, busy_lb_gained, v15)
+DOMAIN_FIELD(__u32, busy_lb_hot_gained, v15)
+DOMAIN_FIELD(__u32, busy_lb_nobusyq, v15)
+DOMAIN_FIELD(__u32, busy_lb_nobusyg, v15)
+DOMAIN_FIELD(__u32, newidle_lb_count, v15)
+DOMAIN_FIELD(__u32, newidle_lb_balanced, v15)
+DOMAIN_FIELD(__u32, newidle_lb_failed, v15)
+DOMAIN_FIELD(__u32, newidle_lb_imbalance, v15)
+DOMAIN_FIELD(__u32, newidle_lb_gained, v15)
+DOMAIN_FIELD(__u32, newidle_lb_hot_gained, v15)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyq, v15)
+DOMAIN_FIELD(__u32, newidle_lb_nobusyg, v15)
+DOMAIN_FIELD(__u32, alb_count, v15)
+DOMAIN_FIELD(__u32, alb_failed, v15)
+DOMAIN_FIELD(__u32, alb_pushed, v15)
+DOMAIN_FIELD(__u32, sbe_count, v15)
+DOMAIN_FIELD(__u32, sbe_balanced, v15)
+DOMAIN_FIELD(__u32, sbe_pushed, v15)
+DOMAIN_FIELD(__u32, sbf_count, v15)
+DOMAIN_FIELD(__u32, sbf_balanced, v15)
+DOMAIN_FIELD(__u32, sbf_pushed, v15)
+DOMAIN_FIELD(__u32, ttwu_wake_remote, v15)
+DOMAIN_FIELD(__u32, ttwu_move_affine, v15)
+DOMAIN_FIELD(__u32, ttwu_move_balance, v15)
+#endif /* DOMAIN_FIELD */
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d6989195a061..b6eca6e92390 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2530,6 +2530,8 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.finished_init	= perf_event__repipe_op2_synth;
 	inject.tool.compressed		= perf_event__repipe_op4_synth;
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
+	inject.tool.schedstat_cpu	= perf_event__repipe_op2_synth;
+	inject.tool.schedstat_domain	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 5981cc51abc8..6ea0db05aa41 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -27,6 +27,8 @@
 #include "util/debug.h"
 #include "util/event.h"
 #include "util/util.h"
+#include "util/synthetic-events.h"
+#include "util/target.h"
 
 #include <linux/kernel.h>
 #include <linux/log2.h>
@@ -54,6 +56,7 @@
 #define MAX_PRIO		140
 
 static const char *cpu_list;
+static struct perf_cpu_map *user_requested_cpus;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 
 struct sched_atom;
@@ -237,6 +240,9 @@ struct perf_sched {
 	volatile bool   thread_funcs_exit;
 	const char	*prio_str;
 	DECLARE_BITMAP(prio_bitmap, MAX_PRIO);
+
+	struct perf_session *session;
+	struct perf_data *data;
 };
 
 /* per thread run time data */
@@ -3660,6 +3666,195 @@ static void setup_sorting(struct perf_sched *sched, const struct option *options
 	sort_dimension__add("pid", &sched->cmp_pid);
 }
 
+static int process_synthesized_schedstat_event(const struct perf_tool *tool,
+					       union perf_event *event,
+					       struct perf_sample *sample __maybe_unused,
+					       struct machine *machine __maybe_unused)
+{
+	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
+
+	if (perf_data__write(sched->data, event, event->header.size) <= 0) {
+		pr_err("failed to write perf data, error: %m\n");
+		return -1;
+	}
+
+	sched->session->header.data_size += event->header.size;
+	return 0;
+}
+
+static void sighandler(int sig __maybe_unused)
+{
+}
+
+static int enable_sched_schedstats(int *reset)
+{
+	FILE *fp;
+	char ch;
+
+	fp = fopen("/proc/sys/kernel/sched_schedstats", "w+");
+	if (!fp) {
+		pr_err("Failed to open /proc/sys/kernel/sched_schedstats\n");
+		return -1;
+	}
+
+	ch = getc(fp);
+	if (ch == '0') {
+		*reset = 1;
+		rewind(fp);
+		putc('1', fp);
+		fclose(fp);
+	}
+	return 0;
+}
+
+static int disable_sched_schedstat(void)
+{
+	FILE *fp;
+
+	fp = fopen("/proc/sys/kernel/sched_schedstats", "w");
+	if (!fp) {
+		pr_err("Failed to open /proc/sys/kernel/sched_schedstats\n");
+		return -1;
+	}
+
+	putc('0', fp);
+	fclose(fp);
+	return 0;
+}
+
+/* perf.data or any other output file name used by stats subcommand (only). */
+const char *output_name;
+
+static int perf_sched__schedstat_record(struct perf_sched *sched,
+					int argc, const char **argv)
+{
+	struct perf_session *session;
+	struct evlist *evlist;
+	struct target *target;
+	int reset = 0;
+	int err = 0;
+	int fd;
+	struct perf_data data = {
+		.path  = output_name,
+		.mode  = PERF_DATA_MODE_WRITE,
+	};
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	session = perf_session__new(&data, &sched->tool);
+	if (IS_ERR(session)) {
+		pr_err("Perf session creation failed.\n");
+		return PTR_ERR(session);
+	}
+
+	session->evlist = evlist;
+
+	sched->session = session;
+	sched->data = &data;
+
+	fd = perf_data__fd(&data);
+
+	/*
+	 * Capture all important metadata about the system. Although they are
+	 * not used by `perf sched stats` tool directly, they provide useful
+	 * information about profiled environment.
+	 */
+	perf_header__set_feat(&session->header, HEADER_HOSTNAME);
+	perf_header__set_feat(&session->header, HEADER_OSRELEASE);
+	perf_header__set_feat(&session->header, HEADER_VERSION);
+	perf_header__set_feat(&session->header, HEADER_ARCH);
+	perf_header__set_feat(&session->header, HEADER_NRCPUS);
+	perf_header__set_feat(&session->header, HEADER_CPUDESC);
+	perf_header__set_feat(&session->header, HEADER_CPUID);
+	perf_header__set_feat(&session->header, HEADER_TOTAL_MEM);
+	perf_header__set_feat(&session->header, HEADER_CMDLINE);
+	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_NUMA_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_CACHE);
+	perf_header__set_feat(&session->header, HEADER_MEM_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_CPU_PMU_CAPS);
+	perf_header__set_feat(&session->header, HEADER_HYBRID_TOPOLOGY);
+	perf_header__set_feat(&session->header, HEADER_PMU_CAPS);
+
+	err = perf_session__write_header(session, evlist, fd, false);
+	if (err < 0)
+		goto out;
+
+	/*
+	 * `perf sched stats` does not support workload profiling (-p pid)
+	 * since /proc/schedstat file contains cpu specific data only. Hence, a
+	 * profile target is either set of cpus or systemwide, never a process.
+	 * Note that, although `-- <workload>` is supported, profile data are
+	 * still cpu/systemwide.
+	 */
+	target = zalloc(sizeof(struct target));
+	if (cpu_list)
+		target->cpu_list = cpu_list;
+	else
+		target->system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, target, argv, false, NULL);
+		if (err)
+			goto out_target;
+	}
+
+	if (cpu_list) {
+		user_requested_cpus = perf_cpu_map__new(cpu_list);
+		if (!user_requested_cpus)
+			goto out_target;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_schedstat_event,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out_target;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out_target;
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	if (reset) {
+		err = disable_sched_schedstat();
+		if (err < 0)
+			goto out_target;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_schedstat_event,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out_target;
+
+	err = perf_session__write_header(session, evlist, fd, true);
+
+out_target:
+	free(target);
+out:
+	if (!err)
+		fprintf(stderr, "[ perf sched stats: Wrote samples to %s ]\n", data.path);
+	else
+		fprintf(stderr, "[ perf sched stats: Failed !! ]\n");
+
+	close(fd);
+	perf_session__delete(session);
+
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -3835,6 +4030,12 @@ int cmd_sched(int argc, const char **argv)
 		   "analyze events only for given task priority(ies)"),
 	OPT_PARENT(sched_options)
 	};
+	const struct option stats_options[] = {
+	OPT_STRING('o', "output", &output_name, "file",
+		   "`stats record` with output filename"),
+	OPT_STRING('C', "cpu", &cpu_list, "cpu", "list of cpus to profile"),
+	OPT_END()
+	};
 
 	const char * const latency_usage[] = {
 		"perf sched latency [<options>]",
@@ -3852,9 +4053,13 @@ int cmd_sched(int argc, const char **argv)
 		"perf sched timehist [<options>]",
 		NULL
 	};
+	const char * stats_usage[] = {
+		"perf sched stats {record} [<options>]",
+		NULL
+	};
 	const char *const sched_subcommands[] = { "record", "latency", "map",
 						  "replay", "script",
-						  "timehist", NULL };
+						  "timehist", "stats", NULL };
 	const char *sched_usage[] = {
 		NULL,
 		NULL
@@ -3950,6 +4155,21 @@ int cmd_sched(int argc, const char **argv)
 			return ret;
 
 		return perf_sched__timehist(&sched);
+	} else if (!strcmp(argv[0], "stats")) {
+		const char *const stats_subcommands[] = {"record", NULL};
+
+		argc = parse_options_subcommand(argc, argv, stats_options,
+						stats_subcommands,
+						stats_usage,
+						PARSE_OPT_STOP_AT_NON_OPTION);
+
+		if (argv[0] && !strcmp(argv[0], "record")) {
+			if (argc)
+				argc = parse_options(argc, argv, stats_options,
+						     stats_usage, 0);
+			return perf_sched__schedstat_record(&sched, argc, argv);
+		}
+		usage_with_options(stats_usage, stats_options);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index aac96d5d1917..c9bc8237e3fa 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -77,6 +77,8 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
+	[PERF_RECORD_SCHEDSTAT_CPU]		= "SCHEDSTAT_CPU",
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]		= "SCHEDSTAT_DOMAIN",
 };
 
 const char *perf_event__name(unsigned int id)
@@ -550,6 +552,102 @@ size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *ma
 	return ret;
 }
 
+size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp)
+{
+	struct perf_record_schedstat_cpu *cs = &event->schedstat_cpu;
+	__u16 version = cs->version;
+	size_t size = 0;
+
+	size = fprintf(fp, "\ncpu%u ", cs->cpu);
+
+#define CPU_FIELD(_type, _name, _ver)						\
+	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name);	\
+
+	if (version == 15) {
+#include <perf/schedstat-cpu-v15.h>
+		return size;
+	}
+#undef CPU_FIELD
+
+	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
+		       event->schedstat_cpu.version);
+}
+
+size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp)
+{
+	struct perf_record_schedstat_domain *ds = &event->schedstat_domain;
+	__u16 version = ds->version;
+	size_t cpu_mask_len_2;
+	size_t cpu_mask_len;
+	size_t size = 0;
+	char *cpu_mask;
+	int idx;
+	int i, j;
+	bool low;
+
+	if (ds->name[0])
+		size = fprintf(fp, "\ndomain%u:%s ", ds->domain, ds->name);
+	else
+		size = fprintf(fp, "\ndomain%u ", ds->domain);
+
+	cpu_mask_len = ((ds->nr_cpus + 3) >> 2);
+	cpu_mask_len_2 = cpu_mask_len + ((cpu_mask_len - 1) / 8);
+
+	cpu_mask = zalloc(cpu_mask_len_2 + 1);
+	if (!cpu_mask)
+		return fprintf(fp, "Cannot allocate memory for cpumask\n");
+
+	idx = ((ds->nr_cpus + 7) >> 3) - 1;
+
+	i = cpu_mask_len_2 - 1;
+
+	low = true;
+	j = 1;
+	while (i >= 0) {
+		__u8 m;
+
+		if (low)
+			m = ds->cpu_mask[idx] & 0xf;
+		else
+			m = (ds->cpu_mask[idx] & 0xf0) >> 4;
+
+		if (m >= 0 && m <= 9)
+			m += '0';
+		else if (m >= 0xa && m <= 0xf)
+			m = m + 'a' - 10;
+		else if (m >= 0xA && m <= 0xF)
+			m = m + 'A' - 10;
+
+		cpu_mask[i] = m;
+
+		if (j == 8 && i != 0) {
+			cpu_mask[i - 1] = ',';
+			j = 0;
+			i--;
+		}
+
+		if (!low)
+			idx--;
+		low = !low;
+		i--;
+		j++;
+	}
+	size += fprintf(fp, "%s ", cpu_mask);
+	free(cpu_mask);
+
+#define DOMAIN_FIELD(_type, _name, _ver)					\
+	size += fprintf(fp, "%" PRIu64 " ", (unsigned long)ds->_ver._name);	\
+
+	if (version == 15) {
+#include <perf/schedstat-domain-v15.h>
+		return size;
+	}
+#undef DOMAIN_FIELD
+
+	return fprintf(fp, "Unsupported /proc/schedstat version %d.\n",
+		       event->schedstat_domain.version);
+}
+
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp)
 {
 	size_t ret = fprintf(fp, "PERF_RECORD_%s",
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index f8742e6230a5..96e7cd1d282d 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -360,6 +360,8 @@ size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
+size_t perf_event__fprintf_schedstat_cpu(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_schedstat_domain(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
 
 int kallsyms__get_function_start(const char *kallsyms_filename,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbaf07bf6c5f..a929a63e1827 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -691,6 +691,20 @@ static void perf_event__time_conv_swap(union perf_event *event,
 	}
 }
 
+static void
+perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
+			       bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
+static void
+perf_event__schedstat_domain_swap(union perf_event *event __maybe_unused,
+				  bool sample_id_all __maybe_unused)
+{
+	/* FIXME */
+}
+
 typedef void (*perf_event__swap_op)(union perf_event *event,
 				    bool sample_id_all);
 
@@ -729,6 +743,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
@@ -1444,6 +1460,10 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return err;
 	case PERF_RECORD_FINISHED_INIT:
 		return tool->finished_init(session, event);
+	case PERF_RECORD_SCHEDSTAT_CPU:
+		return tool->schedstat_cpu(session, event);
+	case PERF_RECORD_SCHEDSTAT_DOMAIN:
+		return tool->schedstat_domain(session, event);
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index a58444c4aed1..9d8450b6eda9 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2507,3 +2507,252 @@ int parse_synth_opt(char *synth)
 
 	return ret;
 }
+
+static union perf_event *__synthesize_schedstat_cpu(struct io *io, __u16 version,
+						    int *cpu, __u64 timestamp)
+{
+	struct perf_record_schedstat_cpu *cs;
+	union perf_event *event;
+	size_t size;
+	char ch;
+
+	size = sizeof(struct perf_record_schedstat_cpu);
+	size = PERF_ALIGN(size, sizeof(u64));
+	event = zalloc(size);
+
+	if (!event)
+		return NULL;
+
+	cs = &event->schedstat_cpu;
+	cs->header.type = PERF_RECORD_SCHEDSTAT_CPU;
+	cs->version = version;
+	cs->timestamp = timestamp;
+	cs->header.size = size;
+
+	if (io__get_char(io) != 'p' || io__get_char(io) != 'u')
+		goto out_cpu;
+
+	if (io__get_dec(io, (__u64 *)&cs->cpu) != ' ')
+		goto out_cpu;
+
+#define CPU_FIELD(_type, _name, _ver)					\
+	do {								\
+		__u64 _tmp;						\
+		ch = io__get_dec(io, &_tmp);				\
+		if (ch != ' ' && ch != '\n')				\
+			goto out_cpu;					\
+		cs->_ver._name = _tmp;					\
+	} while (0);
+
+	if (version == 15) {
+#include <perf/schedstat-cpu-v15.h>
+	}
+#undef CPU_FIELD
+
+	*cpu = cs->cpu;
+	return event;
+
+out_cpu:
+	free(event);
+	return NULL;
+}
+
+static size_t schedstat_sanitize_cpumask(char *cpu_mask, size_t cpu_mask_len)
+{
+	char *dst = cpu_mask;
+	char *src = cpu_mask;
+	int i = 0;
+
+	for ( ; src < cpu_mask + cpu_mask_len; dst++, src++) {
+		while (*src == ',')
+			src++;
+
+		*dst = *src;
+	}
+
+	for ( ; dst < src; dst++, i++)
+		*dst = '\0';
+
+	return cpu_mask_len - i;
+}
+
+static union perf_event *__synthesize_schedstat_domain(struct io *io, __u16 version,
+						       int cpu, __u64 timestamp)
+{
+	struct perf_env env = { .total_mem = 0, };
+	int nr_cpus_avail = perf_env__nr_cpus_avail(&env);
+	struct perf_record_schedstat_domain *ds;
+	union perf_event *event;
+	size_t d_name_len = 0;
+	char *d_name = NULL;
+	size_t cpu_mask_len = 0;
+	char *cpu_mask = NULL;
+	__u64 d_num;
+	size_t size;
+	int i = 0;
+	bool low;
+	char ch;
+	int idx;
+
+	if (io__get_char(io) != 'o' || io__get_char(io) != 'm' || io__get_char(io) != 'a' ||
+	    io__get_char(io) != 'i' || io__get_char(io) != 'n')
+		return NULL;
+
+	ch = io__get_dec(io, &d_num);
+	if (ch == ':') {
+		if (io__getdelim(io, &d_name, &d_name_len, ' ') < 0 || !d_name_len)
+			return NULL;
+		d_name[d_name_len - 1] = '\0';
+		d_name_len--;
+	} else if (ch != ' ') {
+		return NULL;
+	}
+
+	if (io__getdelim(io, &cpu_mask, &cpu_mask_len, ' ') < 0 || !cpu_mask_len)
+		goto out;
+
+	cpu_mask[cpu_mask_len - 1] = '\0';
+	cpu_mask_len--;
+	cpu_mask_len = schedstat_sanitize_cpumask(cpu_mask, cpu_mask_len);
+
+	size = sizeof(struct perf_record_schedstat_domain) + ((nr_cpus_avail + 7) >> 3);
+	size = PERF_ALIGN(size, sizeof(u64));
+	event = zalloc(size);
+
+	if (!event)
+		goto out_cpu_mask;
+
+	ds = &event->schedstat_domain;
+	ds->header.type = PERF_RECORD_SCHEDSTAT_DOMAIN;
+	ds->header.size = size;
+	ds->version = version;
+	ds->timestamp = timestamp;
+	if (d_name)
+		strncpy(ds->name, d_name, DOMAIN_NAME_LEN - 1);
+	ds->domain = d_num;
+	ds->nr_cpus = nr_cpus_avail;
+
+	idx = ((nr_cpus_avail + 7) >> 3) - 1;
+	low = true;
+	for (i = cpu_mask_len - 1; i >= 0 && idx >= 0; i--) {
+		char mask = cpu_mask[i];
+
+		if (mask >= '0' && mask <= '9')
+			mask -= '0';
+		else if (mask >= 'a' && mask <= 'f')
+			mask = mask - 'a' + 10;
+		else if (mask >= 'A' && mask <= 'F')
+			mask = mask - 'A' + 10;
+
+		if (low) {
+			ds->cpu_mask[idx] = mask;
+		} else {
+			ds->cpu_mask[idx] |= (mask << 4);
+			idx--;
+		}
+		low = !low;
+	}
+
+	free(d_name);
+	free(cpu_mask);
+
+#define DOMAIN_FIELD(_type, _name, _ver)				\
+	do {								\
+		__u64 _tmp;						\
+		ch = io__get_dec(io, &_tmp);				\
+		if (ch != ' ' && ch != '\n')				\
+			goto out_domain;				\
+		ds->_ver._name = _tmp;					\
+	} while (0);
+
+	if (version == 15) {
+#include <perf/schedstat-domain-v15.h>
+	}
+#undef DOMAIN_FIELD
+
+	ds->cpu = cpu;
+	return event;
+
+out_domain:
+	free(event);
+out_cpu_mask:
+	free(cpu_mask);
+out:
+	free(d_name);
+	return NULL;
+}
+
+int perf_event__synthesize_schedstat(const struct perf_tool *tool,
+				     perf_event__handler_t process,
+				     struct perf_cpu_map *user_requested_cpus)
+{
+	union perf_event *event = NULL;
+	size_t line_len = 0;
+	char *line = NULL;
+	char bf[BUFSIZ];
+	__u64 timestamp;
+	__u16 version;
+	struct io io;
+	int ret = -1;
+	int cpu = -1;
+	char ch;
+
+	io.fd = open("/proc/schedstat", O_RDONLY, 0);
+	if (io.fd < 0) {
+		pr_err("Failed to open /proc/schedstat\n");
+		return -1;
+	}
+	io__init(&io, io.fd, bf, sizeof(bf));
+
+	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
+		goto out;
+
+	if (!strcmp(line, "version 15\n")) {
+		version = 15;
+	} else {
+		pr_err("Unsupported /proc/schedstat version: %s", line + 8);
+		goto out_free_line;
+	}
+
+	if (io__getline(&io, &line, &line_len) < 0 || !line_len)
+		goto out_free_line;
+	timestamp = atol(line + 10);
+
+	/*
+	 * FIXME: Can be optimized a bit by not synthesizing domain samples
+	 * for filtered out cpus.
+	 */
+	for (ch = io__get_char(&io); !io.eof; ch = io__get_char(&io)) {
+		struct perf_cpu this_cpu;
+
+		if (ch == 'c') {
+			event = __synthesize_schedstat_cpu(&io, version,
+							   &cpu, timestamp);
+		} else if (ch == 'd') {
+			event = __synthesize_schedstat_domain(&io, version,
+							      cpu, timestamp);
+		}
+		if (!event)
+			goto out_free_line;
+
+		this_cpu.cpu = cpu;
+
+		if (user_requested_cpus && !perf_cpu_map__has(user_requested_cpus, this_cpu))
+			continue;
+
+		if (process(tool, event, NULL, NULL) < 0) {
+			free(event);
+			goto out_free_line;
+		}
+
+		free(event);
+	}
+
+	ret = 0;
+
+out_free_line:
+	free(line);
+out:
+	close(io.fd);
+	return ret;
+}
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index b9c936b5cfeb..eab914c238df 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -141,4 +141,7 @@ int perf_event__synthesize_for_pipe(const struct perf_tool *tool,
 				    struct perf_data *data,
 				    perf_event__handler_t process);
 
+int perf_event__synthesize_schedstat(const struct perf_tool *tool,
+				     perf_event__handler_t process,
+				     struct perf_cpu_map *user_requested_cpu);
 #endif // __PERF_SYNTHETIC_EVENTS_H
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 3b7f390f26eb..9f81d720735f 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -230,6 +230,24 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
 	return 0;
 }
 
+static int process_schedstat_cpu_stub(struct perf_session *perf_session __maybe_unused,
+				      union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_schedstat_cpu(event, stdout);
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
+static int process_schedstat_domain_stub(struct perf_session *perf_session __maybe_unused,
+					 union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_schedstat_domain(event, stdout);
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
 void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 {
 	tool->ordered_events = ordered_events;
@@ -286,6 +304,8 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->compressed = perf_session__process_compressed_event_stub;
 #endif
 	tool->finished_init = process_event_op2_stub;
+	tool->schedstat_cpu = process_schedstat_cpu_stub;
+	tool->schedstat_domain = process_schedstat_domain_stub;
 }
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index db1c7642b0d1..d289a5396b01 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -77,7 +77,9 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature,
-			finished_init;
+			finished_init,
+			schedstat_cpu,
+			schedstat_domain;
 	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
-- 
2.46.0


