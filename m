Return-Path: <linux-kernel+bounces-559122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E39ACA5EFBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C031A7A73C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC8264608;
	Thu, 13 Mar 2025 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RnJHilNI"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED3264614
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858800; cv=fail; b=qXfCRYAodbNeDSWq2Q2W4rUKaZ+L1fSrXWF7fHMowUUTbrbItBYsAg5gxXSx1UQV9aG0nqo7VF+l6Ea6Qkk4Z1WxfCvNItzIGgfPeMuUpOmM2OTceFoSJOKrXivwouB8kOV0HD/VJqCfdMt07EYXjGg6ZizAUyH9SXtxerJFOP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858800; c=relaxed/simple;
	bh=8gHAAiJFTWF/5uCh9rllspDrOyQBv7+kaznkGXzY05Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsESg6ukmvRIrE3JD08VHWpUbOhw9z2oH3k6yJJ9P8XQyDnX5CpckDBrOam8i99T67vVH025P1FxtYBcAw/ZT+WDl8gy4ZYhyrINsUF0Spk8SNKueZY+Zyzi+9X9QCBI8H73coapykgpee11sXFF39dI0NLSsFBUtEE8GsGXXCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RnJHilNI; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4Y+vQoosjtC6suZRuFjS4fhW62GqgP4JqVsmGPWNDWFcJlAYrz1um6XiH1LqThAt2GKTvqmxmSXSbHXYIcJ8fT0vKBLKeHqk+WpC89pi3bcPtHcUpmKwPxkc5EuxZpqjVQwGh9xtiQqixI1FwIv+p35CV6Ck6aeuBnYplonjzDQhSc4a4xPJ8e7+MDFO8ROWhRSz4reDg3X1oRy+e+m/riQbJy0mxrz9+j+Z1u6q86+evZ48LKIFS2m+flbivm93KI374yBla072WBUZXnFgWQ5BzmZ2B+lz6cXJdUJCSmEXa0TmXc9OD1mFrSFH3foo595bn9KAl/TcZSkUzKm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUwVN6AlJq94CP3sCMcW4UPJp8D5mXUeUVcpBeK2w1Q=;
 b=Z2a0xqBz000jy+v9wSa1IHHMevqPCNOlRmEMDG8rJIOHSeEDHRqkEKZhODJdmudkB9JONnYWe0+H8H/pUyQ+g1t8AWGGe3hrCgpRfUVXU5STEpF7+NpY8fp+iaZwCC62sECXlL0Ur1tgLKvmVqRVpTdXlplj8B8En8c/aBDiolg/A240qd+evOxtidAJKwxJMXdK4dRywrM7WKL5s6ZBb+OFV7CgieJbor5NrGtGR6Hdga71DJ90wqbKJtSxYg4LHNK+jCfWjyWqX8oXzm3UgaOQRNW69ZtRcWMFneODp09azE/VCAt3aIBOE93naGOcq92gwAq3nR1SakJO4QizVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUwVN6AlJq94CP3sCMcW4UPJp8D5mXUeUVcpBeK2w1Q=;
 b=RnJHilNI32sLWNsqjV4lSezKiEodY0BDYVbB6b/SdPSCQwwgU7QeVEAW4gfmCBie2tt/KwLNUOWS9VXWQE5g8yi44qgwzqfiYPKTKSR+43a67B2kyQYJDvlySDR71PC4oeba7bl1nsxr4aVnXOwtMHOQiBPOHEBEzA/f6O3Efq8=
Received: from CY5PR15CA0248.namprd15.prod.outlook.com (2603:10b6:930:66::15)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:39:54 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::96) by CY5PR15CA0248.outlook.office365.com
 (2603:10b6:930:66::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Thu,
 13 Mar 2025 09:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:39:53 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:39:48 -0500
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
Subject: [RFC PATCH 6/8] sched/fair: Increase probability of lb stats being reused
Date: Thu, 13 Mar 2025 09:37:44 +0000
Message-ID: <20250313093746.6760-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e777bd-c9eb-490d-c0e8-08dd62130240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZJHZlrJEk1KadugUU3vpskdvzZYq1WGUUeoX8NbK6PXblbpbgtQr+MAFc1y?=
 =?us-ascii?Q?Z8w/YdWCAZ4UMB2hr2GCAaMNRZfvV++iT/PiG+JTRFcQNYgnp5qggEI3iP1a?=
 =?us-ascii?Q?v6knMZnQZnYHN4IScurRKrnOzcGZvcPHgTt5ZmLlHrCz5zqbIOry+wDDwTZ2?=
 =?us-ascii?Q?TZwxAbvIUIJSB6DTRkqUjDHRiJHbwruRa+9/jZiBtA97xbVqtvQzPwUxGbOL?=
 =?us-ascii?Q?hKttlIwtKwKmBQqjqZMWEWqCclYEs062Wu4A1XJO3ikw3ziUMWG85DB5cSJD?=
 =?us-ascii?Q?IO6qjTw4wT/+cqFCtga8Gy4dOmiym2oXf+HbcfRYn3E8/hG0g74WWnJ+VyGk?=
 =?us-ascii?Q?TYb9qIYH+ZjFL7f8xn9QtRU12s/h9HT4rsWAah3p5mJw0cpTE0jsPEIaRBkj?=
 =?us-ascii?Q?tB6gC+jHoGPrQQ00LQij3UvJTVknCvdgS7q/yK2R0KdD+2PoVP9mjvspuDJl?=
 =?us-ascii?Q?zU7/2O5V8RNOek4fRLI1r5+KZOVn0obDJoVV7uTy20yzL6iyacziMDyt3s/j?=
 =?us-ascii?Q?lDs+VL3Umew3NZo7Zxe0uQfn+caazW2vAcaI9NsMTHswRMrJyPpyQP8t3CSR?=
 =?us-ascii?Q?QaapMuUepK/ukvaDXyEfNDr+1a4tCfeedtGlblYvcoLx41/CdSyYPwxqtOXD?=
 =?us-ascii?Q?0UcInOvtgOcke8NP+8VYWbeKTYYGj6yjeOkDMuP/I/Zj0RnDwi26nmuPSxdP?=
 =?us-ascii?Q?aDvBCKASiWW9ESIThfRCQnY2I/40hFEwY5Z2VTRJ4Mg7xn1AsGYdBvcQI5Pw?=
 =?us-ascii?Q?Iq0EJDgxvpz92+lJoy5mWzDEoCKYCkuh6f90tKDmiiRjOdiw3U9Ua3fJF24a?=
 =?us-ascii?Q?kxxCiQBfne5piR0pfDuCPnFoWVmkoSUlDs3sILAHk32J2Rl3f8o+mQ1H2SpM?=
 =?us-ascii?Q?CvfbCC6mA6TiYBMN7EOhp8AdNVmfXUm061l914stAwOlZjcbquo1BprIRbMD?=
 =?us-ascii?Q?ICUZqhfuOG/9Pd50l1R2yRm4fgJgn5C4ldAmU0qIjsopUjAUbaMzxcovdd1O?=
 =?us-ascii?Q?77LEKGUo0H5QwHYypfCjkKb0aktrpVQiTWH5ib9vf9l03fiZlk1YCZX8hhxV?=
 =?us-ascii?Q?p62qFfPg0+IyCVFNfDWUfdo4FGxcixRJM8+kzsZK6J8mZszIX1ehAY5xuBzx?=
 =?us-ascii?Q?A2tREjae4VMEgjN+vEOGYBjVhxE8aWk09N2LUdufRkoqMxuvyvtF23fGtrya?=
 =?us-ascii?Q?ps3SI5pChbuNHoz/bMR70tnJXMTR8qYLgiW/kraWe1DwtFeTt7x4D0MyXPi4?=
 =?us-ascii?Q?Ql1wYMFjxU7xTC7j63IrZQjHDGLcZGPbrmEk2oTLs2fGpGy3DmbUK13Y/Fqq?=
 =?us-ascii?Q?bNceI0QEwhnhOOy1FvcG5K2AK6lspnGujshURzdYDLvCJZaoXaM2KYYUcsO1?=
 =?us-ascii?Q?APDTLHzhXaLDNuy6KjUbE8mSWRn37lyx5IB2hVrK5aSxAs/wXkULBLgfQ4no?=
 =?us-ascii?Q?DWex/PpOCJtI0Bt9DkZfLo7KpRp9RNhRoH+cgNPwS3NpyjwUNb6MpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:39:53.6770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e777bd-c9eb-490d-c0e8-08dd62130240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

The load balancer will start caching the sg_lb_stats during load
balancing and propagate it up the sched domain hierarchy in the
subsequent commits.

Increase the probability of load balancing intervals across domains to
be aligned to improve the reuse efficiency of the propagated stats.
Go one step further and proactively explore balancing at a higher domain
if the next update time for a higher domain in before the next update
time for its children.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b1ed14e4b5e..60517a732c10 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11956,15 +11956,6 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
 
 	/* scale ms to jiffies */
 	interval = msecs_to_jiffies(interval);
-
-	/*
-	 * Reduce likelihood of busy balancing at higher domains racing with
-	 * balancing at lower domains by preventing their balancing periods
-	 * from being multiples of each other.
-	 */
-	if (cpu_busy)
-		interval -= 1;
-
 	interval = clamp(interval, 1UL, max_load_balance_interval);
 
 	return interval;
@@ -12126,7 +12117,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 	int continue_balancing = 1;
 	int cpu = rq->cpu;
 	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
-	unsigned long interval;
+	unsigned long interval, prev_sd_next_balance = 0;
 	struct sched_domain *sd;
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
@@ -12136,6 +12127,8 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
+		unsigned long next_interval;
+
 		/*
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
@@ -12162,7 +12155,9 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 				goto out;
 		}
 
-		if (time_after_eq(jiffies, sd->last_balance + interval)) {
+		next_interval = sd->last_balance + interval;
+		if (time_after_eq(jiffies, next_interval) ||
+		    (prev_sd_next_balance && time_after(prev_sd_next_balance, next_interval))) {
 			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
 				/*
 				 * The LBF_DST_PINNED logic could have changed
@@ -12174,6 +12169,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			}
 			sd->last_balance = jiffies;
 			interval = get_sd_balance_interval(sd, busy);
+			prev_sd_next_balance = sd->last_balance + interval;
 		}
 		if (need_serialize)
 			atomic_set_release(&sched_balance_running, 0);
-- 
2.43.0


