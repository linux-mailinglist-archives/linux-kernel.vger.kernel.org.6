Return-Path: <linux-kernel+bounces-441968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B49ED647
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDF8188B4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B7243B90;
	Wed, 11 Dec 2024 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bC3U23W0"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A623693F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943491; cv=fail; b=ibWe6TWH8C2KbTGpnhGV6+IaIj+y8kByYcRtM4MlU2bdeR3G6dk0DezwLtpqdYmYlSyYKVXHXdmNyOoLAKs1MrNX4Rs/2fymp9/1upTPjWHzHruCGAN0R5kZPmmr8awdCnynuV8wAuYz67qW5B+LvxApVAgQd9uvN+h5w0RJmGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943491; c=relaxed/simple;
	bh=orVU3DpIUNHREqyvCb7Lx9japWgoQxgoSZMfx8sJvHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXtyYdHfp+F1WChIMp+T3SG2KHfpCGg//OL9LYmreLnErrQtFUaZ5adcETwM46AR4TvjYA9ZXb+kXaX5KQ3b+gykPR8dLBwXy2Pd6gVUboTf8J/qO0vd0hzHE2kdWR8D1Y+1SxFumN+54b2dW5hudc6F21caUKmCALWmmMgeEWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bC3U23W0; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9j6KSi+srA+xXuZIKHmjlmhklSNWwKvIpUKNQGrya9DuLowyuf1FWYkyegCZ0nyFqD59kxq9Hr8P8aXBpWnN0Y9WQDacN/Uce0IGKjQoqkOddGxh9MXKgJ/i9fp2SoziRNnUNpuvO8Bk6JOor249dd1C3YMUlw0qkYLHy97drOgP7eLMmmyJteYujuxyAWFruRqs3PaRhrf0xwV5YbjovZaDAU51L0lq5KIyhey3zPeEM/UCrDOUvfg0X0hse7Bpg78LhyM8bYPCZuWhz4CBVqwu0HoRTsP6K2rFzD8GPWJz0RTAmG5Gr6o+RXB+qw6DyqZQDYCEZQ09WWfTIw6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czR4LFJ0nw50Wlh0iMcFwavhn1+iCqr2DFUhIwIVjBM=;
 b=eTr17aSl1KYeBclj4YJiHr9O5oefLW60XXavz8+3ozodxUnNjCWySdF7HoMzahB8QN9PX2+jhlF733A4V8oNY8vUa/mrfXtfl8l6UmbtmSSn+u1+Fuxlh0Wb1x7gi4z1OMwtGq5X82tsMFTJf8wIfSMD/sUaqWfIYmeEsOcJX9Av76yYuaf7M60wRmzUd6xRwCyLRcEFXrSU38jNMXBEcCrFsuUP+U2JVgt7g2li1ai2Z92FEcpTXSjHiQqHNPEA6lHbdysH8nqU25pMVDiefhp+JSN58Tq7/fKDKutYnU+ypbnh+Y6Mj9tuEk0s1FLs7gT7tP/6voQV81m1B/PSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czR4LFJ0nw50Wlh0iMcFwavhn1+iCqr2DFUhIwIVjBM=;
 b=bC3U23W02cje9QEVuqHdSqvDoBSKYLpu01ZLT33rbxnhOYQItOWrqzpaGNhcAL//f7kZt6HCQzZKPNk8LOTviI1IU19P4Zd6CJW/BUGH3DxfZKgJiH4b1SZ0eQ5hPRgbbNsMuyS7gtrQkGWQwGUcw7QAvF1ZC7mV6ZeIkEvGMGk=
Received: from PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::26)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 18:58:05 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::55) by PH7P221CA0075.outlook.office365.com
 (2603:10b6:510:328::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Wed,
 11 Dec 2024 18:58:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:58:04 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:57:57 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 6/8] sched/fair: Do not compute NUMA Balancing stats unnecessarily during lb
Date: Wed, 11 Dec 2024 18:55:49 +0000
Message-ID: <20241211185552.4553-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185552.4553-1-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e166dad-20ee-4bc9-058b-08dd1a15be2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWCHPaQ9aIo0SrRYs+MCxmMB1o2dXeHQk0+4MlF9kCVZhvSr/BqhDp8madsb?=
 =?us-ascii?Q?jMVt71oi+3yICdOYdWP2WiebHMyn7rkBkZPvMOP+sTfZl6JFExAANsBj5O5a?=
 =?us-ascii?Q?o9nwiI8I8pq3gI1wLtdzuIWrKyPG55GLGs1OUOxsDl+ZaZdeUC3pHxFE5ajU?=
 =?us-ascii?Q?5pchSRXkVb2TlnM0Uy1RsUcWGrwucrG80N/Ngdko8sWJgPVN9oxNpqidebga?=
 =?us-ascii?Q?KE8kEoE8BOckIzzyUYzZeq0cIfiL+aE7lscectur9qA6ElzDfHbXjVKO5Ohj?=
 =?us-ascii?Q?7aRgQoVHMpeZGxq/9tk5AW2uTfxqljbA1uVWdans3EEfdrhwAXatm4pri/Hw?=
 =?us-ascii?Q?AXBAyTdpv4T01F9xbCbdS5M7K1atJAAET7cJPVePhgNVXkMKvEhNAmO15jsS?=
 =?us-ascii?Q?Vs3Q/P3kI5yScsQDK8n0kw9VMegOGEC8mmHxrkLv6zuN4gOhzaTNzElbJ9WX?=
 =?us-ascii?Q?2u9Fgj+IdSMTvQTDBFW/+SlkkyPI6DiOxb34z/gHb1KoSFkYPKw1RTakclTy?=
 =?us-ascii?Q?nd4LnxxSukwEefscCxnvT1BK5DRlipSyIwbN7DULGAWEYcEMMVAxreEarH5z?=
 =?us-ascii?Q?nSJH1H1JD5cVaqipsp6eXL/p+uQeFBQf5fii4GzvPvM9Du/o8sTPCcHngoF/?=
 =?us-ascii?Q?0JlZ5+NQGhz8rNvPSJVt32xsF+614DAYYn4XeQ+iobEl22Ca+YnpdQ+h6exZ?=
 =?us-ascii?Q?N6o5L9L0jL+Q9dHO9Nqz7wXVe6qbLfor94PoTavp/BeAw1dNhK6DdbmT+8KI?=
 =?us-ascii?Q?MHksdWQrCPEmg2mFHawESnhjwcWW9WjRvdGKZMRWKVehCKBnE+WW/G02kYeU?=
 =?us-ascii?Q?ZZNZmu0wdf3RN0ZstrvRhz4ax1mMAK6mNtYo6CJeebgB7UDPYkNhfSNUIqq5?=
 =?us-ascii?Q?NdPCe9JrSJHinoHz0KX21TQBy0IAVrmhIe5yj7QOZ8PxI53WhVCmvy8hlqDu?=
 =?us-ascii?Q?liOUqmKCOpd039X01KQQWxUyvPQTokadUtj3Rt/4q/CrYAw1YB8BWd+UkBm1?=
 =?us-ascii?Q?Ftm6Utv44i7FljcaV5ZV56XSpbRt14/b2KYLE1iiEkQt9ykHGOA/SFJPg+Yh?=
 =?us-ascii?Q?6W2h7h2PUKPohDBVQyF6Yz3xFAhWUqmFTNYo42W4thkZ+ys2aAq6mm/L9S9V?=
 =?us-ascii?Q?hbLM84xmoescAU9z1JFqQ5xrm4HChwgUBSws3/iLKFZWy+cSUdwP0MwVSb3m?=
 =?us-ascii?Q?Ju4cSEeaqhRK6VFWF7wrlujBq6527Dd+OanxUknaufT1Yxb4pk/kvthWndKD?=
 =?us-ascii?Q?wsBNpxlnuZipQjzbH8d1dirgZu80BJ5hhhr/p3iJpaevZW6yDbB5ZbB+5G2x?=
 =?us-ascii?Q?QLLpLTUmfGdMaG56iJ0UXaX/RJlsTe26r8TD4RDOS2gUqL+7bSGxSVibJBu9?=
 =?us-ascii?Q?FdDhj7saIjQoV97lVH+FzIdkntl+hZNyPqMfbk8BMzdDW02OrJ3sqBROvizy?=
 =?us-ascii?Q?lL4Rdz9+Eetmq4yvItMdQzfa+wST4K1L?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:58:04.1885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e166dad-20ee-4bc9-058b-08dd1a15be2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

Aggregate nr_numa_running and nr_preferred_running when load balancing
at NUMA domains only. While at it, also move the aggregation below the
idle_cpu() check since an idle CPU cannot have any preferred tasks.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c4ebfc82917..ec2a79c8d0e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10340,7 +10340,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      bool *sg_overloaded,
 				      bool *sg_overutilized)
 {
-	int i, nr_running, local_group;
+	int i, nr_running, local_group, sd_flags = env->sd->flags;
 
 	memset(sgs, 0, sizeof(*sgs));
 
@@ -10364,10 +10364,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
-#ifdef CONFIG_NUMA_BALANCING
-		sgs->nr_numa_running += rq->nr_numa_running;
-		sgs->nr_preferred_running += rq->nr_preferred_running;
-#endif
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
@@ -10377,10 +10373,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 		}
 
+#ifdef CONFIG_NUMA_BALANCING
+		/* Only fbq_classify_group() uses this to classify NUMA groups */
+		if (sd_flags & SD_NUMA) {
+			sgs->nr_numa_running += rq->nr_numa_running;
+			sgs->nr_preferred_running += rq->nr_preferred_running;
+		}
+#endif
 		if (local_group)
 			continue;
 
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
+		if (sd_flags & SD_ASYM_CPUCAPACITY) {
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;
-- 
2.34.1


