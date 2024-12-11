Return-Path: <linux-kernel+bounces-441969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612069ED630
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589B61626BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE0236952;
	Wed, 11 Dec 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wD3E3avN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB523692C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943512; cv=fail; b=gqsgA/Jbo9N1oYsCsU5NrSrHSvD4M0wGqFYKUq1Jpj7nWqLMIxPngQfC0Tp2nGc3qbqRVtsmTsR1zn8HTms38IfK338UBXzgUBfUeyOEiOhiYDUVbI6/dYtdpQ7PnpXANtM/OthENuNMObqTlYcLi/kl77bnSxvM44cBVHDobsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943512; c=relaxed/simple;
	bh=Uw3bB+CuLgj4X7zY/PDQKWKN6sIEDhLWBytko2m18T4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6WZCi8+2Eho2LkFhIvzKIMv7UBZLFxk0TVRUXZUie5NCPUCovqX542FdFDbETVLNpWNjZ5MLasuYwq1Jr4MHdFggbPPlt0oWIpXKaxYgTRtie2lSFMxDiZuwmiSW06k7WvC1cD+fwhwe6042CW1iPZSSD4xpJDbHNMNlrwWPoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wD3E3avN; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8vZdQ07nk0QeK8spTeS66ShHg63g+z/aBj1Ow9fkZ+02GNnlktKg+k+qJcPR/ua3+sR4nm3FNrYMxe6q6EpR+XA67G6y0cQGR2JzWuk+FHPKrSSxHLKcDvL4UGuKYD8FsPueLUN4/rzjosQ3ZnubmGkUErcOeoa+F6dyvBjgBQ7KTclmP9zSSy+D1uJuT0EUwPKv+tgshTbjSmSseO4PEwpdacJJfyPHirlEgX+waNdi/4UwtKo05uq8MCFhi1w9G3SJdbjPQHUzSko0Rlk/hof6NPZls8M3ReHlnPE/lHotwwOlI27SXIdk3QgudjLm5G8wT0QPVe0pCkgUkT0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSLnuv+OaEpnFLdjjGptwzgvpg9YCKa0ZWNocp6fJ/A=;
 b=UfVYLWuIBxNPLRCjP91R6XK5tMFDf+c+SCjH8/T957pCd687NOZk7MuaJ83inJwEDbleQAjaj+ATuufBBJLbp7fuOEcQB1gczcuZauxIueflAGEnEgUOVY7ZGXIhIrBLxmQEY3LlUHNiwo5EYXWIX0xOp4hSM4Nj5qcB5gueegQXKsI/OsDXT3FYPF+9ZPph+H8OS44eIl4NtyXPMsObfYjKK5w1PAcMx2c44Mxvz91kXfV1SiM4xzec9ouaw6k/2ygU82tMZFkZVoEhuTynJnKnmXAr+6AJuxkeiJfuI9uThm/B9hggPCgLqt+XKDuZbPgHmeDdnN5yuFCeqvRteQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSLnuv+OaEpnFLdjjGptwzgvpg9YCKa0ZWNocp6fJ/A=;
 b=wD3E3avNE7SHKwZqqXbKdnVTiQr5oMA/rHRRwYgmk7oir8VRBYd/73jS4Hc7UJxYynChEuTBdNjFetVCf/eyIiEX+0tlvQe/T98oVqR9Hgo35Wke++YKAKMQbAjkmGDm9x4O96pNG/KEzMARdiSR1C5agQkGP0+Sjr2goZy3280=
Received: from DM6PR17CA0023.namprd17.prod.outlook.com (2603:10b6:5:1b3::36)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 18:58:26 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::5) by DM6PR17CA0023.outlook.office365.com
 (2603:10b6:5:1b3::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 18:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:58:24 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:58:16 -0600
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
Subject: [PATCH 7/8] sched/fair: Do not compute overloaded status unnecessarily during lb
Date: Wed, 11 Dec 2024 18:55:50 +0000
Message-ID: <20241211185552.4553-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: f95855c8-1285-4217-8065-08dd1a15ca21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vwnv1NialWr21Zk1qA3XIWaT43WGbt4OKBLjAIE9Hinkzl0Fu9vay3SPiFpt?=
 =?us-ascii?Q?PTuj0VTTAPEMmVp/c6WIm3AEJJr7e1mSJV05gIOylxXa/OwNxaTnSrVWq4Nk?=
 =?us-ascii?Q?zeLFAmIOcUv8RCyesehBMBfL41+W+4o5LHUU+pBlPpvxZTuxsfyaGv0Cf7Sc?=
 =?us-ascii?Q?+ig9RPEDzkk7ASfW8ysB8THhovp6421bu4/KHHIT4lpu+vjOady211tj9KM2?=
 =?us-ascii?Q?6Z8Q6oKFmjHYDzVKqd8Jj+Y7dC+A3YjWb63nQopjtUV7bz0Ar/0snhU6Vxb2?=
 =?us-ascii?Q?El+F8kEplNq3jyr/9LgDrnm37jEOzABm7lSWH/1vwbYhytjPYXvRik5MF1mV?=
 =?us-ascii?Q?rOiCSYPp9/NpaqGTIbv0acfZqR+6Cd45Cv78lYuicTgt76f190AmdWnKq9iE?=
 =?us-ascii?Q?vGKe4FXoYzL+XfuDpdeUD2L9DybUidj9y1ti1TdQ7iJPpvIMiiqdBcxgomgs?=
 =?us-ascii?Q?w5w7GWFnqoelSLbuR9GX3hYw8Oi2WXdjvnyhuygZrnsWqI4fcqpPJr/jrtTC?=
 =?us-ascii?Q?fkvUnNOKGJ15EdkYu/PnkpOA/7r4QYnKyyns37w2tybWVVMF/k6Ocyd0XYYX?=
 =?us-ascii?Q?M30nmO/7LQMzopDXpanFJWXzwOI06z4P38LqmfS1kmBI9Wz/lYdEd4vTAnNR?=
 =?us-ascii?Q?xPIRIYOSv0qVN9ViN/F/FcJPZEunYg+Wg+LYIhmiiyFQwJgb6MGru+7qRyxT?=
 =?us-ascii?Q?S0hLzUcdMLppEs8j1KS95IjVHMgq6Kg47o/1/yYCw68XVoY1kQGHAiJHyweU?=
 =?us-ascii?Q?RqevqFgRgR2vh/cyzwdzasTn33BIEGQv7+iOVvtWl90F1FmIVXPoNiyQAUzK?=
 =?us-ascii?Q?wcS7d2+Q6OWg4AeWjjZ3JTITLVLJDlDEW2FNA+SRmTbONqIva8WMhNSmvfqs?=
 =?us-ascii?Q?3j24jjHBt5SKk0AWHI2aEARisI558jj6NSjUgcoclmpYSldM7VUxzKas94Gr?=
 =?us-ascii?Q?eTtrGZ8xzpmdRm28lM7uJnClMKmTbm8wyrYBdaweceWExdD0uRZYMRT2FRMj?=
 =?us-ascii?Q?18gS9LIa5CWp9p2HjNAeXx4+oXDtC2nvFihMaCgkZHDaXmmvj0nnDXVeO53M?=
 =?us-ascii?Q?HzAbj5rcmYgSafk2ilTulUdn2CkP+ecFljV9c+dZ8UCK+4xVTcSlF7blKdld?=
 =?us-ascii?Q?qUqIF/QKiMlkk9iJ86w4me32h8d57BoOmE2IhZGikWWiVMDCOYrW9U4K6bDE?=
 =?us-ascii?Q?JPQibHXsLUO81D2T/nGURY5tuxWZqoyEdYg84zle+sY7vjqng1msqpit326N?=
 =?us-ascii?Q?Wh/1DQ27GDr4+aJbPzm+pFKqchieGHsEOT+TQ7qNtxCSuQP1caJebYb2NQvb?=
 =?us-ascii?Q?pAj+NuEY3H9oNFFh7g5kg7ILyVrL0glxG+B3z+pGebfDzlFolK0Cv0TwrNQH?=
 =?us-ascii?Q?0R+3ePRB4xpxOko1Dk/aRuolqnabn28goRvOg305eJodgy2aDRwk2GcnqN0b?=
 =?us-ascii?Q?lvx9xBQ7vNwFIT5IM8JhUakgv0n46X4y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:58:24.2588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95855c8-1285-4217-8065-08dd1a15ca21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046

Only set sg_overloaded when computing sg_lb_stats() at the highest sched
domain since rd->overloaded status is updated only when load balancing
at the highest domain. While at it, move setting of sg_overloaded below
idle_cpu() check since an idle CPU can never be overloaded.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ec2a79c8d0e7..3f36805ecdca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10358,9 +10358,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
 
-		if (nr_running > 1)
-			*sg_overloaded = 1;
-
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
@@ -10373,6 +10370,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 		}
 
+		/* Overload indicator is only updated at root domain */
+		if (!env->sd->parent && nr_running > 1)
+			*sg_overloaded = 1;
+
 #ifdef CONFIG_NUMA_BALANCING
 		/* Only fbq_classify_group() uses this to classify NUMA groups */
 		if (sd_flags & SD_NUMA) {
-- 
2.34.1


