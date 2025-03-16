Return-Path: <linux-kernel+bounces-562943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E9A63500
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051D53AE298
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47BB189916;
	Sun, 16 Mar 2025 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c3vzwGve"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12618C01D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121037; cv=fail; b=N1weR3nDAaAmsOEY2oLMtM9Z4lFenWm4OpJOKfc4rm1+3nMaVRPJ6JwbUELlcVCMCU3ZFK7lyJk3ySYLkSFRtl5dZfP2w+R1SmpZX+dYE3tyM/4A58cIIPxZPMEoy7axPd2nx1VXzoMEcG/3CCoL/KQeaZGi/H3nI1x85I7RwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121037; c=relaxed/simple;
	bh=fHuJgymFQKFvuZonm6Uq/FmpkuZr+4NmZ5i3p2Qw1KQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4Gufo8iYEJECv8dxJY5UJ4/drr07F4K2J/X3t46jZfiQ0r51uX2qEbxI43sgw0QFHxbjy0HsAWi/ybkdZewossJKOQKBc5xE9p6YB4kzdo2ZkXUYUQLg9YvxSV+TgfsYTc0fkU5zKXydlQurtyzbMaRFbAC9Ogj8KpJGahOMn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c3vzwGve; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQA5ebPqGemQWJLTn2MzCEWJh9Z3BMSFH94YrfE6ytDZOzVkqPAefRtNDZXSDHUoB4/Osq15KJ2cH6+T2eFtOVVrd5bZnx9SsXbxgji/QigJZdvt9/tJ7bznVs0Uw6x66E6RYk0Os8VssMXlOiz4ZR7ACq8f4LPAgAoxsD75N3u3ibEYI23DPTFYUljhvN2277qTEXuB4OADIDpLEZ4qYK3d5s2Dxkc0Gjp7vvYpwiiVcESnyEqnOmodoa73LpdOYy73opT4zVUb9k+YKix0oohJMcCDitTAveOzEym9bZjoKR0d2x4p8JumWgQr/GC8wQEIVy6f3Rysx4Mm1cIImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y1CQnQ6qMNxP0LUHHphXWekDRYraw4OXG44WKe5k5Q=;
 b=HGlecz+nTJkK6XLOV08BNgj5O7aaSR97HyGly4AtbNe8nXhBHpGnP0hYtYLEjBgmivwpgyAdKn9wBtmQHWJUMXegaW995FdDgRmee1Ir+6x3HDOyiDrhygEfl0r7OBi//5WevIPjekAWfQLkiVIn3/DVP6yJOZGBsvwKmIjIHOcS3S2FfZwvQC0HH60p4dOmaKXuXnHfoq2/z0KzXuL1j5e+34vSjSgfFmubEkMN4aSPcH8kDTsSnooRL1RTq+KDn1bOsGQGeo1fdEKIlozG37GnLKzuLED/GoGYemekG/Vyx+Zf2PdmJjJRfpiVpsV5tUQpKsbRpOfv01St6M+hEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y1CQnQ6qMNxP0LUHHphXWekDRYraw4OXG44WKe5k5Q=;
 b=c3vzwGveP0h0VtbHPZVxstIYWQo2umvIifz3rivlvCHVfp41ebwA+jLOzCLta0ZY3Ogxs2DHpgOg2YTwR8NdX2JqLYBEWzV7VY1mBR5fBR5QMrykyf8f3i/erfvvzlU/n8B9OVY9kW6h4mgFbLZgqqoyOLGLdr+sNM9hCvMpML0=
Received: from LV3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::31)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 10:30:30 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::50) by LV3P220CA0008.outlook.office365.com
 (2603:10b6:408:234::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 10:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:30:30 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:30:25 -0500
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
Subject: [RFC PATCH 12/08] sched/fair: Record the cpu that updated the stats last
Date: Sun, 16 Mar 2025 10:29:13 +0000
Message-ID: <20250316102916.10614-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be81098-cc18-4792-292d-08dd6475936e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aj7u/S6xDSZ/OyBYGGGLo2cOrk4hAndloKzIpRdmKldFQG2awPPto7W3oXKv?=
 =?us-ascii?Q?VGgjGTSscDKpSXE3XpmxPHxy4Ir52C8mmGCLQEU5vidita4MI2BFy30lbaHV?=
 =?us-ascii?Q?bCRkDpKeRRwgrlGyQIghyXFJzikX6rSO581q+wNPfYyMwxfoENGmtqFp0Jlm?=
 =?us-ascii?Q?5lrXwEsp0Z5phw1OGof5MHSM9aOz7igsqoUW871cQVnt/bhojpsZ14Z+JJY/?=
 =?us-ascii?Q?q9Z9VEKp8Blo2WBjzpNhWJD4h631pk8cFtTLTOf0IUjYY3mocbXkPF8hQT1d?=
 =?us-ascii?Q?r/t+lS5P3/4Vqb1D0hrMUPvNfRufE2R5gkLzHECD0oug8rk6KKseGCdKnRil?=
 =?us-ascii?Q?720IxvQtTAKa7Rfq6ho5vHTLU3SgtjAw31b9sNjQV49TAGtX1fvsJx8Y+RH4?=
 =?us-ascii?Q?DvWBlyoQsxmlB++dKx6EbrxmJp1rgXIJkZXBkXHIqERBPqtxVmgLoNURW/Aq?=
 =?us-ascii?Q?5AUG4pqRlgQOxk66imqOlpbuMj0uRC2OW7WoMz6l6wHy8HR3MjpK/9LISL5/?=
 =?us-ascii?Q?agfOJcIKsMwHQMpt3Yp1n0ImPDV9ImtKQmYBLiWAwcyB5rNTTjEndNK0j70y?=
 =?us-ascii?Q?NyJ1rvIorLmGynpx7udur3RVPSrbIuhOsZlikJZ0NnN7PpRC3Xevy1DX0hkx?=
 =?us-ascii?Q?7q76SNuRwVfciIPoUm+aiYMH9T8iHmxgkcDWCAsE5xaAd5nLfOrokzpOzOQG?=
 =?us-ascii?Q?rj5hPrLK6SEaUGXzdANPLbdeAXhYf2e0rREc4nDVUMUFBf06SvoNaT/wKJsy?=
 =?us-ascii?Q?d1Zg/yzxSEKpvtB6s4EkPb0rIPQwNUVs1fhPyzwznb028pyURXxfez4izwZH?=
 =?us-ascii?Q?wIUqAnXdQ8kx2bQKt5zxrQCPRlhElwXHdkaOjqJp/UPWGG7rnPkINJYDdOGK?=
 =?us-ascii?Q?gvJydkCu/jjtNEHG3h7zA9HKOhIHHNQ60SWodwNuoJouNP8ThIAVRCx7iyG+?=
 =?us-ascii?Q?g608oVKt1FYN7yUhgl+GmuMysnYHpDW7OYfT8FWB9AHXEHzb8qGhB4OTY/JB?=
 =?us-ascii?Q?19oaPOC1qhWTjv1ZaZgsDqzQpOCokorIHuxtPyThXNF5ytwYAEmH+iC6E1RY?=
 =?us-ascii?Q?fPdeyRkrFCQgqwx8n6wHMigY/O+PzpEv287U7Py3IkPw7EjoBGkWOdjUrVvI?=
 =?us-ascii?Q?FF877AvakD9X0lOX4Bf2fpYUrI+X+YZkyRPr4zOsFUYkXGQpRd8pqdnUSqv/?=
 =?us-ascii?Q?/0cvhxDhqRwNZMW1dwyzd+7wurYTJo53Knx1/tu+XhySbZtSpdiEGk/94l1q?=
 =?us-ascii?Q?hroEzsvXAiFPKyoh4ckcIt39rABrV7f3NJ/8ZoIpANyJwoZqVRV5ih4SRmGm?=
 =?us-ascii?Q?UXYk++Hnu/REyhhSr9kgZhR2q1zQ97dhJe0NoLHDzv7Zs2KPlJE4qMLgiwwe?=
 =?us-ascii?Q?gvL/Q65QGu2r7TUQ0Lj+IHL7t/ihZqFYuOKpDsSyzdJh6am02CW4uR0uvQ2E?=
 =?us-ascii?Q?XQ6DcDsHAz+9/qkezWTvHlQ+ASRNdIiWdxtq1/3PZsMx3NMk+2c7FM3MPZxV?=
 =?us-ascii?Q?FmGpZ+MPVkFokZg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:30:30.3431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be81098-cc18-4792-292d-08dd6475936e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075

Record which CPU updated the stats last. This will be used to invalidate
the stats in the following commits.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 5 +++--
 kernel/sched/sched.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6c486e194a9d..2a34d73d824b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10279,9 +10279,9 @@ static inline void cache_sd_stats(struct lb_env *env, struct sg_lb_stats *sd_sta
 {
 	struct sched_domain_shared *sd_share = env->sd->shared;
 	struct sg_lb_stats_prop *lb_prop;
-	int cpu, retry_limit = 3;
 	u64 time, lock;
 	long version;
+	int cpu;
 
 	if (!sd_share)
 		return;
@@ -10319,7 +10319,7 @@ static inline void cache_sd_stats(struct lb_env *env, struct sg_lb_stats *sd_sta
 		 * Version is up for grabs! Try again. If the CPU grabs
 		 * the lock next time around lock = version = 0 and this
 		 * is skipped. If it cannot grab the version, lock != 0
-		 * and we return from here thus ensuring on a single
+		 * and we return from here thus ensuring only a single
 		 * retry.
 		 */
 		if (!lock) {
@@ -10330,6 +10330,7 @@ static inline void cache_sd_stats(struct lb_env *env, struct sg_lb_stats *sd_sta
 	}
 
 	lb_prop->sg_stats = *sd_stats;
+	lb_prop->update_cpu = cpu;
 
 	/*
 	 * Pairs against readers checking the version
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 64f7e013fd59..adf4fa2ed031 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2197,6 +2197,7 @@ struct sg_lb_stats_prop {
 	 */
 	atomic_long_t		version;
 	struct sg_lb_stats	sg_stats;	/* Cached sched_group stats */
+	int			update_cpu;	/* CPU that updated the stats */
 };
 
 static inline struct cpumask *sched_group_span(struct sched_group *sg)
-- 
2.43.0


