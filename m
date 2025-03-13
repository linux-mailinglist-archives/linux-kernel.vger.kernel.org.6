Return-Path: <linux-kernel+bounces-559114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A344A5EFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478B13AB9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0022641DF;
	Thu, 13 Mar 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PieYz8Ry"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC9261398
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858712; cv=fail; b=lXpMkP+H3esSDMk7mvuEvRwiS1mHjzj1uYJKiO3DJwSdsROInXtu1dKBGKKF8LbbjxhIK6+ghtCTjTPakoPzCJ+EH9vF3JTif/ZI2HfRJYWOVzR1xF+CE+Xp8s5kbJ5qbftlXrN04tRYJNgcwosrlsLPUJA7Svc+X0MOKiQJyNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858712; c=relaxed/simple;
	bh=hMracf4IVfkIta8/vH3i+2iTox5gMxK6J6BsYLu1hPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h35bUicDM5YPLi6+YGsfJ/lmxPY1Nzj4hLMQjawHjCrwWFR5cR32KICHAVQBH9tD2ra5rRozS7hLgA05XIzskHlb4ywgocXR43Y57onExeGogDSDCzp/Tbw2fzCDk0RJ4J3k4D/LPJ417NvA/+kXfYo3kk6EiiM+HCY8cqXFEvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PieYz8Ry; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1syEnKUfF6RIdYrGdc4TckxN/IxgTi9zP0ZUkPDtKGEisuPolb1rIZLFINssKWoy/rOfmo+rwPXBK5dwhlVPcPLZ/tkBSIAV4e6UpXaykZtWLViW+3wWAC7PzzzdnVZoUJ9Cbgn070nsmMjvOvtkdrYrfYqJRi0MsfODTSoPXMVbexbTTRLaMZ8Yfn7RBRPKePeGThOStWIajyjOIrhn6c1uR1TyCpneMn3RJ/hCqTMDdPx5j1aEvcCFzwoOnGpfVP3qw6SsRGkN7TQqB9Hidmx3b60G2W8WFTru6OMaiojHSM+g2uTl6ObJIhOMsP7X8I/4sS3bTTKCOI8giBOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPbogZ8WRr8yFGfyNLdX3Jm1z7KxNTmPs3zOkHDfaXA=;
 b=kS2FSJ8dQ2+xMuBrrt1mblE/MEUuBPXfU/Jfkzj4jHR/Rxsbq8GXD7Uta1kSWLFwmwueJYwgG2Kl4y1MyB/xK+NMa8Oi0KBmlpov4Jk1BLm1G4jZX8pTDgNdYSwV/pTAo3JtDgBJfVT0rYAXPyNLZurcuybzyWCm+Wpzkc45KK6TLSD6nvUENfmIrjuht87twPmUwNXpEtkk+4/2in/Tyw1GyzWtTM+DwNIOR6ipVdZf3LZEx4Psn6l0WvrYsD6jZuoL75oTYxiHoCeV/VwOXiw3IuLVvxK/dB1Xxgok1weQbBKiXMiblaV9c7LXEYmH/Q8lvoSV0VsA3EOOIlIr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPbogZ8WRr8yFGfyNLdX3Jm1z7KxNTmPs3zOkHDfaXA=;
 b=PieYz8RyMliYcU6qcOCDvv20wp745rGaI3KsZEJ1ryzyeLZdF0ie5eVfXoBnC1hhIN7kcx1VO75nNu82BGn1vZ/xC4gC9+VYnqMM3WjxnFJb4f6ifuf9dQzj0EIInmncfbmYKXaIM5d2bk5xd/+NWWuDzaRhhzyNW+Dah0UVldk=
Received: from CY5PR15CA0236.namprd15.prod.outlook.com (2603:10b6:930:66::8)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 13 Mar
 2025 09:38:25 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::24) by CY5PR15CA0236.outlook.office365.com
 (2603:10b6:930:66::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Thu,
 13 Mar 2025 09:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:38:25 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:38:20 -0500
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
Subject: [RFC PATCH 1/8] sched/topology: Assign sd_share for all non NUMA sched domains
Date: Thu, 13 Mar 2025 09:37:39 +0000
Message-ID: <20250313093746.6760-2-kprateek.nayak@amd.com>
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
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 481d6b76-08f8-4747-b896-08dd6212cdab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahfu0gDLAu29zi8PscIcvi1BeNiiEqHxfxG1BAlpZTZ+kYMe3Oh1BzivMV4Y?=
 =?us-ascii?Q?70cgs6ScvzgUejCvKOR8PRtHvBtv1JR0nd7rOwYUmkPKYLBuqAAm30j7vRyQ?=
 =?us-ascii?Q?ajfBrlXS6JXvm6n1sSm7tI3OZu1BefoIqbLwE5RMQRlnFoZNgmL1zxalo7Gb?=
 =?us-ascii?Q?58veaj8tiGyOBUJon2gFRLX4XAKMLZHNn9qvfOtx7T9OUV/plQ9If78Qa+14?=
 =?us-ascii?Q?GmsKkz+qDWAbpAQ9JsNastYWCcoQ9Of0aWFNLcKrPDJ1GKNyy/42kjM5b0pq?=
 =?us-ascii?Q?gi1AE2GIj2xwLk7t9Ui+FVuEGVwMF1kZDsZDrW8mlycnIINqDaFDaU63E8JB?=
 =?us-ascii?Q?6STLezTA3kMoTkvEOgXmq6Jq7clfjeIQ1rFRIM1kqubktSp2Vo5i7kNavikb?=
 =?us-ascii?Q?wjrRgXidhrTCkTZTsJlhnWfWDpqOUkw5HJlp5W7iGPdXktPiBDF/mICtTcOv?=
 =?us-ascii?Q?b8kVEENe/C1kJRf6WKetbjyJBP5Iv2+XhkP2X5ltYU5cLVFcWRGlgCsjBFAd?=
 =?us-ascii?Q?edpQeqfWQwfhBwIQGv7tqKOfA1ZeG2HB+LB1uFLNBD1D4iXowIYCxOSNWkZv?=
 =?us-ascii?Q?Zym+CGfekHzKIuM4Kv7jfQLJ1V3+IOwieq6Tgx7xeeKEZLdiVbQeIuhR2tK5?=
 =?us-ascii?Q?o8IHkxaIradN3dq/KpPmnwNJopJDMywzxvIEDMO7rg34+IpvjvYbQkY2kaDB?=
 =?us-ascii?Q?brRkfqfF8StBYC7Jq08uKrl82JY2rH4jBqYBFmvhsGG3vhRzVWmq+RKkIF1u?=
 =?us-ascii?Q?GOJdPRKfiju2L9eKRlzaLa98ZGa8hYRfJHRjScautL9gaLPV0Q2DZ7uNSGrE?=
 =?us-ascii?Q?pfXN5f8k5BUAQwVQ6d15aqq0rpSgFQZw+NBLZEHs2wn9GPDjqvwxjBilbn0z?=
 =?us-ascii?Q?6NJwXjoZFvrzkIPuLBuai9DK6ABKc9MaZbRpfQIEpjyMiSy7yPg+TBpoqEc2?=
 =?us-ascii?Q?wba34zl75OpkQnAoIgZhU3+/ZvS0CJqVNm0WrAzr2Ca/w3cSgZSCS56Y+7oq?=
 =?us-ascii?Q?mpgnuWfLy0AIxkROPwstQbNSEWwraujJRgLPq51kxNMOit8TS5CCsvRbgO8j?=
 =?us-ascii?Q?FNniNh5N7z/5YlpF1Ru65BE+jcBTjp9Hzc5kFNUx7r13EEhWYL2ysuuKCwzi?=
 =?us-ascii?Q?IXJYHy5cY8CNgC1/FkK/PkGeCOKBlyFke/Pz7ANNPmo+h7OVy5wR725zX8sq?=
 =?us-ascii?Q?ckb7GexiE6pXX5UE++eTp/B/Q+BrVWtni44hdcLrA4htjPotoYdEe/RxZ9hq?=
 =?us-ascii?Q?Wr7qwlxM08tZG9K64TGT8NNhveIjW2qO8Z64bOj8U8ttZ7AaNshEQIQQrSUg?=
 =?us-ascii?Q?bSGS3fTCgU+Q6xa8DEdMxNYFoEBemhPfBHVbZD0V1nJzEX2ctLPYrr6MK+g0?=
 =?us-ascii?Q?t8Z2owJj3Udr4WE0vTklilMTFRS462ONRvb7uiFO1I3zG+H30HLxBHo+WQry?=
 =?us-ascii?Q?Du1k18Q45qB0zwlmgw1CCh+Tw9JnmHdXQceoOOC00OU6im8vheWr0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:38:25.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 481d6b76-08f8-4747-b896-08dd6212cdab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

From: Chen Yu <yu.c.chen@intel.com>

Currently, only the domain with SD_SHARE_PKG_RESOURCES flag
would share 1 sd_share for every CPU in this domain. Remove this
restriction and extend it for other sched domains under NUMA
domain.

This shared field will be used by a later patch which optimizes
newidle balancing.

Suggested-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..815474823b3f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1680,10 +1680,10 @@ sd_init(struct sched_domain_topology_level *tl,
 	}
 
 	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
+	 * For all levels except for NUMA; connect a sched_domain_shared
 	 * instance.
 	 */
-	if (sd->flags & SD_SHARE_LLC) {
+	if (!(sd->flags & SD_NUMA)) {
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-- 
2.43.0


