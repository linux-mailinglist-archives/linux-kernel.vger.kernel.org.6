Return-Path: <linux-kernel+bounces-562946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C4A63503
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A1E16EEC7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310BA933;
	Sun, 16 Mar 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UnljLX8s"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E3E44C63
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121090; cv=fail; b=EQuo6ZzHUREP9HLXHlT2ijbLJeUwIhgYRgPt4tHRw0g8th62A8oMDePu9ukcp9FnCOiQKaaz0RDEKOpZDY4rTjDgn9yXVDSjZHPMJMYkE0qDEgFKFT9QSeuYoiPgHRiZ3Z0l+wD4zVhZUXQnjMHfoVnXVrQU1k/m+7Wt96ZjN88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121090; c=relaxed/simple;
	bh=c8tFBihpZPYwDlU0uDSiHUTpRcnPAu3dlitSQ4pLCLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcTZrW2XZEo5JQjabTfGZcBJcw9sW0kAGrivx4R7BP12zbkepacYbHOLiP9T6xjAdNDdqBKd6Gq+FIdlrzFluwF2buQY2ZqXY2GakKjg6s7EgE7gjOcWQ3YqvZASGgjBYJhdksH/JaKuUkU+/tKZ6+/74QC7u2xVlUhkJzxhWEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UnljLX8s; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+IwkiaCNg0F31VG1mqdScjAxaMu8VKHsnzmTTMqn1BC4bUMIJr4kGURAEWXWFOUtx0tOC69gyhtu6M7VB9+A2w+mXLLNMiSnFPo/6ux7ZFv4hkR5khi/2KYXJ2JTKewGx+PQIQk9CbQci3gmuOP1eS5vnmIeIo8cnTXlcDF4csJ9JrmiAyF3ORSFYCr1jUAsMaoFZTCMH++EwX1CruFjW43kQXXvGov9eSTtACzNBcNayRtKRHKvSFneUqbTHSBdG4WtXZcqGR7766aosduHuUbRysFL19Mn9oVKrIU/6oT0IHbjsonDH7vY8xNulSwLw5x5xO/HS4re13EMMkhSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BILs3xOKiqaYjA6DD429UlwOfdiL47kGZLs5V0XjnZ4=;
 b=R0NvunVxhx+FckDzLlJ9bJiPLUz2nKAdk4E3wVCjEEzgh2haVIzjsPI6kEPd3wWi+Mg1HnflTWIwQKC7PYAcjNxUkzA/kVKWMfjFq7zU8cCtQneMQCgpq5Eg3r3XqvDSAh58eDVXVYzm7JBIrRj+AC9lZJb6IxScKU/BER4REVME7DnIhAQ1z+GBGctjzf9vFpZx7Q85nbzk7OHr7/17UtlQcTzW8jCUXvZ92gZcshCp7+tvNm5stxO3q3k1I14fL4uAMXIpSve0WRI2VyXvhkaXzHlmGw7inv+LTyjVxMIbfhChnY7lRKnTN0ZpGLERUDKNl2TGuO6hdBLI4jmZUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BILs3xOKiqaYjA6DD429UlwOfdiL47kGZLs5V0XjnZ4=;
 b=UnljLX8sHhHdX/Xvcal7YW4GfKmPi82RfwLEPM66F7AyW8YEdlU2ITBovz/+NYPpbM5omnda+QZbcn28bnc716HOoemexrUFXZon7i4SE9QOssGqjgViBYmsiztS0ZwQtwYYXdFxUNK8iQMJmwNUjJByF6JSCTFN3lGjSK93CtM=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sun, 16 Mar
 2025 10:31:25 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::e) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.29 via Frontend Transport; Sun,
 16 Mar 2025 10:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:31:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:31:18 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Chen Yu <yu.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, David Vernet
	<void@manifault.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [RFC PATCH 15/08] [DEBUG] tools/lib/perf: Extend schedstats v17 headers to include the new debug fields
Date: Sun, 16 Mar 2025 10:29:16 +0000
Message-ID: <20250316102916.10614-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313093746.6760-1-kprateek.nayak@amd.com>
References: <20250313093746.6760-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: e0600b0c-1018-48d6-296e-08dd6475b3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MROUl7FsYt1wLPxKGt/Zj4BYjU9e2fSbl4njsO82RHPsai+49xtE82FAcdYa?=
 =?us-ascii?Q?zsyeDV0rycaNz+4O6yGKWpJ1FC0GNnkXWhVqvFGIuY7erboQ7gd/0MpQ9hpq?=
 =?us-ascii?Q?cS2AgYRja0IIdc9t1Rz8oma0m7MTb1BeCqfes6aUJst3Nh1WD1oz4bqvEv5i?=
 =?us-ascii?Q?z5+j+JFhOPOr2IVXInCg38rVkCxdA0jIUmCVbRzKxk+lesbagUQtM/ApG0Tn?=
 =?us-ascii?Q?nGNqHqZTP0idl0u/eoBmhV+0LvF5tZ2Bnpsj80YKjUu5JvY+Q3SN2sFZUb82?=
 =?us-ascii?Q?QrVboBbX06Y5KfZ83j7bfgDW3opSNJEKzh/oxxX+1IHqyxxV7iJbBRQyuRAY?=
 =?us-ascii?Q?J0iaK8tag2D1jAnjO1hClrb++9GEEz2JNNQQmP/Ab3w3G8GTYLus+J2ah5yU?=
 =?us-ascii?Q?w7RtL0sPymjA9PwNcP4WxAoj3Xny5vxYlIab6iN3I1IkRisCB6rRnfkzjNiP?=
 =?us-ascii?Q?cR9rulIEft9FL65bidd6YjYxV4Prxu7zNbwIZe2ZvCKzFTvJMsQ3kDyplJot?=
 =?us-ascii?Q?uFUElGmt5G7Jc1hT1EWfuNyjc5Z3/GLDrEEzdcI/Ts+mR4MJ2NwO0fbvyVBB?=
 =?us-ascii?Q?7k7sj2/HXCKuagT5uRfNLh8kqRFB3ljv6XsCBg5tHwhIFucZ+UR2O7QG1B3v?=
 =?us-ascii?Q?HLt8r7jUICX+4DG2YGyijqTPdP0Wogni115COgrjQfQQtIQF6qiMRvU+cv40?=
 =?us-ascii?Q?g67CjMbdu0gCEv6cLbLNn0Cz1WVOtb5nzdjKiuSCfEhRBd5+CimDyL6ApXVk?=
 =?us-ascii?Q?ApeqpsbJ06qAGM3Z1glQ3fre2cgUa2C3SFMzaDXX8trt/EUXs9LFsPU8f6y6?=
 =?us-ascii?Q?nnjLeoqgGdBYlHNHUgqZRw+yQ38OnJuS2rpsMGnGCdilTNfwxaUxIlHzzsEc?=
 =?us-ascii?Q?pI5WP07Mn9pKSFti5prRs6EolS54wJkwT8tZAVPYdVb6+ZJxSt6GhU5gNNV8?=
 =?us-ascii?Q?l8O2T7I7Xyhwu3L3u/uMF5utnTH1N4krM0saudxal8rZtgKGfcEtrgxQD0UI?=
 =?us-ascii?Q?0O4o5yl+XnQ0IRcbxvExxcTesjqUJsVl8HdUbZ4/PpI7Gy4a2Exh64KnG4DP?=
 =?us-ascii?Q?9Szc5GaqyQFT0BAlvaUymf1TDvfkZVQFE+1r7bNeYPy+xDodQ1xJRKbU0lfR?=
 =?us-ascii?Q?cML7v3hEHfSUtACfGvsjBFvT8gAMWXAf/6F7sTI1hbzut5OTIfjY8Gpmkz4d?=
 =?us-ascii?Q?crMP6G4uw9uSS943wm0fKlx4qttji67tioiqHnTh3xx9i/CkUkhL0O9Xl3Ez?=
 =?us-ascii?Q?YRkohnw01+0ifx9Xs5or4TbGM1xzMhql9zUC2VnB1mR/hXJWclLvrak6mqMf?=
 =?us-ascii?Q?X6V2lKEI0eeulUvHdMT4TOkyPvpxg+nrQ1V5bmCSNcFahFNiCna1B9r656zL?=
 =?us-ascii?Q?dbrgMmqnggYRYXmKVvdZY4zodMuYZqgirkUPAmhUrmgOpDfhRQTh4Afw1XjO?=
 =?us-ascii?Q?J5Ii6Io0FA2dkQgBSEQ/DmB1yMEPDsJtI6mfAugeWIKfRWUD33MmgcOjchRJ?=
 =?us-ascii?Q?/6lKimcWPa0TqSk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:31:24.4062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0600b0c-1018-48d6-296e-08dd6475b3a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

The previous commit hacked up schedstats v17 to add more fields.
Extend the header file for perf sched stats for analysis. These changes
depend on perf sched stats tools being developed in [1].

Link: https://lore.kernel.org/lkml/20250311120230.61774-1-swapnil.sapkal@amd.com/ [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 tools/lib/perf/include/perf/schedstat-v17.h | 30 +++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/lib/perf/include/perf/schedstat-v17.h b/tools/lib/perf/include/perf/schedstat-v17.h
index 00009bd5f006..888dfa982a55 100644
--- a/tools/lib/perf/include/perf/schedstat-v17.h
+++ b/tools/lib/perf/include/perf/schedstat-v17.h
@@ -47,6 +47,16 @@ DOMAIN_FIELD(__u32, busy_lb_nobusyq,
 	     "load_balance() failed to find busier queue on cpu busy", "%11u", true, v17);
 DOMAIN_FIELD(__u32, busy_lb_nobusyg,
 	     "load_balance() failed to find busier group on cpu busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_min_time,
+	     "load_balance() min time to balance on busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_max_time,
+	     "load_balance() max time to balance on busy", "%11u", true, v17);
+DOMAIN_FIELD(unsigned long, busy_lb_total_time,
+	     "load_balance() total time to balance on busy", "%11lu", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_stats_reused,
+	     "load_balance() stats reused on busy", "%11u", true, v17);
+DOMAIN_FIELD(__u32, busy_lb_stats_recompute,
+	     "load_balance() stats recomputed on busy", "%11u", true, v17);
 #ifdef DERIVED_CNT_FIELD
 DERIVED_CNT_FIELD("load_balance() success count on cpu busy", "%11u",
 		  busy_lb_count, busy_lb_balanced, busy_lb_failed, v17);
@@ -80,6 +90,16 @@ DOMAIN_FIELD(__u32, idle_lb_nobusyq,
 	     "load_balance() failed to find busier queue on cpu idle", "%11u", true, v17);
 DOMAIN_FIELD(__u32, idle_lb_nobusyg,
 	     "load_balance() failed to find busier group on cpu idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_min_time,
+	     "load_balance() min time to balance on idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_max_time,
+	     "load_balance() max time to balance on idle", "%11u", true, v17);
+DOMAIN_FIELD(unsigned long, idle_lb_total_time,
+	     "load_balance() total time to balance on idle", "%11lu", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_stats_reused,
+	     "load_balance() stats reused on idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, idle_lb_stats_recompute,
+	     "load_balance() stats recomputed on idle", "%11u", true, v17);
 #ifdef DERIVED_CNT_FIELD
 DERIVED_CNT_FIELD("load_balance() success count on cpu idle", "%11u",
 		  idle_lb_count, idle_lb_balanced, idle_lb_failed, v17);
@@ -113,6 +133,16 @@ DOMAIN_FIELD(__u32, newidle_lb_nobusyq,
 	     "load_balance() failed to find busier queue on cpu newly idle", "%11u", true, v17);
 DOMAIN_FIELD(__u32, newidle_lb_nobusyg,
 	     "load_balance() failed to find busier group on cpu newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_min_time,
+	     "load_balance() min time to balance on newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_max_time,
+	     "load_balance() max time to balance on newly idle", "%11u", true, v17);
+DOMAIN_FIELD(unsigned long, newidle_lb_total_time,
+	     "load_balance() total time to balance on newly idle", "%11lu", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_stats_reused,
+	     "load_balance() stats reused on newly idle", "%11u", true, v17);
+DOMAIN_FIELD(__u32, newidle_lb_stats_recompute,
+	     "load_balance() stats recomputed on newly idle", "%11u", true, v17);
 #ifdef DERIVED_CNT_FIELD
 DERIVED_CNT_FIELD("load_balance() success count on cpu newly idle", "%11u",
 		  newidle_lb_count, newidle_lb_balanced, newidle_lb_failed, v17);
-- 
2.43.0


