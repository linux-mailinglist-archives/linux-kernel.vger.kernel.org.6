Return-Path: <linux-kernel+bounces-562941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769ECA634FE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A07188F87F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AC819DF40;
	Sun, 16 Mar 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3eO3Dcmv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2C19D071
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742120999; cv=fail; b=l8RY5Op15J8LJ19kl4nQF+523qlKnM1tYweqmrGi2eOH4wuwSeKx3r2gwzLzXQJxwllBCtf7h8ftHrcPSdapMAn/krWLUTt2Vcwawc9Y021bl6xXZ9ha3h0APx9v2W7bzfrhzxHgLUNusRU0pzpP8NqoRPERG9WeLmSTWNnvP6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742120999; c=relaxed/simple;
	bh=+b86qjF0Bm+ClJbxnvxpXfXvSVbJaKd/Q3xk+sZxwao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjxibiX5gvV2QFilqWjxY/S48lWB4vr3lejGJOWelPG0phcGck0hFjtC8DkK4+eZl6OlLULTFKRFBsqGJmdt6b7Dt3PltqUkibruWD7sYVPt980/DArGC/b4z1nKXGwBe+151dJlgHI11VMFdyfHvYV+OVeM0l72wUPyadIoKJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3eO3Dcmv; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxi5fd8FmAExXdUry2HqSdiSMmScpR/9OtS+m/xait0XcRt2AJLuNow0CdVHehwABH+/bzHUO8NrJpzrJEq7ERtYIbGmeji4eeeeFYCK9naeItqJ7ZE+R9rpoUd6qvCoQq6IdVYUyIuG/o/s4aebVLvKGKAe6fAXwhvDMXgzpfvicXoqGynQMHAnK4UoMzI60bJ4nJNZom0rmUIUxYHXtpK5YUESbE+iVyHKTbrJDmvlnXI65qIDxkuZSAL03vVKDFBUVD4u/+Sl+VF8oecADk6BmqXDsCNBx8ZcG65ENqB3wnbjQGbDMv5z+QxgmxUIrsfkTFjdGO3Tw5hM57bxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNTY6AKIOQdkAkihFXXqrPaTa0A/RIvLWqcc9RPyn34=;
 b=un8A94wvhy0LKsk77tNA1WMR/jcx0bU+SLY7VDrlcdBvpDDQz0mpyZAwREZd6J2hCG464sCt2MneGG9Nc9eTLDcQro7+VwfvTTN+D98b0aY7NloBkqHKEeaWFwAoj4pook46qH/BZrBCkNZb8BCjVZqW6YDMia12ej/N4y7rHImU2VKJ7c3Cn49PRB9sjfZJPpoOw1gSms4pfQgZ4Zyyv+N5SEnoBXr84A0cjIWDDRjopK9Yq4FS8byXkzjceteeuDA3dtSk1Fud68wElBc9dfK/ZXdqoErwfN73SiIfJpinJ5hxHxnktyIlwxiXMoIVO3eQN4TmghOvXbL+8ei2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNTY6AKIOQdkAkihFXXqrPaTa0A/RIvLWqcc9RPyn34=;
 b=3eO3DcmvHh9LPlG8E1RSIUsjFiRPaUcIyachglYlRWBIvZy+Viwt1MaVzHrweNEeO6FvDLZB7Vs+Sw/cuQTZ6ZWniz/ftvfDXazU7c4r3LQm2u8jlGjEIhZCzYCDYfuMDY38F9+qIc3Whl3G4IdS7gHmIz0nDcLwitx+iWUdqw0=
Received: from BLAPR03CA0100.namprd03.prod.outlook.com (2603:10b6:208:32a::15)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 10:29:55 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::9e) by BLAPR03CA0100.outlook.office365.com
 (2603:10b6:208:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.29 via Frontend Transport; Sun,
 16 Mar 2025 10:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:29:55 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:29:50 -0500
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
Subject: [RFC PATCH 10/08] sched/fair: Compute nr_{numa,preferred}_running for non-NUMA domains
Date: Sun, 16 Mar 2025 10:29:11 +0000
Message-ID: <20250316102916.10614-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: c294e2e2-1834-4be2-965d-08dd64757e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlEqe3gtsJ34PeVAQfjsfViDSPpV6XmkksmPoOuyTPGmo9pooVq0ki2K+z1D?=
 =?us-ascii?Q?tWyUusj7dfm6lpGbfALfjMAeua9R+UHWzxZvFm+9jaUn1z/SsoCawHuZyAd+?=
 =?us-ascii?Q?+5O7OIGdtd6rnYgtKvCLnxMvLv9XiyeuL8eX2t4RUVjyEHBulzODANImPQGE?=
 =?us-ascii?Q?HLx5dgbmkxTUg7peLr6iJA/0jXBJOTF+czaBNee7sasAiwfuKdigYPeUAFwX?=
 =?us-ascii?Q?X+04eTGc7luVfutvHdhfxe+n0KrSbBvUbRNy59SVItjlSPZfiYEAge5ooldl?=
 =?us-ascii?Q?UbTvbrYgJr/nPI5nx8pynXN8Nwx7upekUXaNuyH4PpyNDSfbj36hEtNw9jMM?=
 =?us-ascii?Q?QRqbRgl4teXWMB0mD2IRhC+YUb3J/rEQvm8eEDvu2z4mohLwljUaxlZwt8Jx?=
 =?us-ascii?Q?VHq6Ct6836XYhgRWvGhDwLJOSqtNhQH/vGh+FaxaBzJB/hmIUbfonROPOqZL?=
 =?us-ascii?Q?pcksjItOlmhrHzZXiaI5n1J/bnV//R6Q43c3fibDQkk7fG/DGM3Srw4xTnUQ?=
 =?us-ascii?Q?mMZjvSdCkTq+wdNI82/WSTEIzd7l3jlgAlqqhIonVAd0PxAZByDJVom88hR9?=
 =?us-ascii?Q?SBbHUSgHTtqxRE3G5rPPIDfRP5SgZ9E5uchqz+5bT1cD99Z/pt7epbV4lPr2?=
 =?us-ascii?Q?PifB+u3m68MzCWK1BtLFrSq9mkbUvzabqrppyy0Ix/1Q/JgsUV9YIq+/TzAU?=
 =?us-ascii?Q?xgOuKGQf19mWpN2zlMdyM9wMe6c8izhlVhOteceR5NJPf7BN8MufX638hgdz?=
 =?us-ascii?Q?j6WFbPPXSS6vf8RxgJ9g59XDawW85LxReKKrZiXNhcwOw1o5YCw2F5OEqkoA?=
 =?us-ascii?Q?AwbK8jj8p5LOKBMFuFq9dSR0AUy8vNfZ11G4Trkt0vj+sL2Afkz30owC/h16?=
 =?us-ascii?Q?knFOAUMQAkHjkSRhkjPZs3XW9MB/8kRsU4WukI+FfeYlFCtcHGODjwzRq48t?=
 =?us-ascii?Q?3VIH1hHQPa90ohwnEmuqrW2NhNAlOATWA7213EKFDMywa32ddTao/cS2KWT7?=
 =?us-ascii?Q?wbv0l3TNxfHDaquhw56zBHEieHNeIZnJON77LM/utcvnHTPENv+DGXBGt/8q?=
 =?us-ascii?Q?GfwDeWwrHs5Ap9nLY19/mvSn0JkebwTgXGRIyleEzgyx8XGtMbRVzMINgE/B?=
 =?us-ascii?Q?IE5UkxiixOGDSUfGDhj/fVC2jH7YxQJ67M23wTFUY+DzX9D/XNg9F/AqEEDa?=
 =?us-ascii?Q?b3gqAONHChwuo+qpixFb1B7fiLI6Jc1BdGiSTXzQxjSAolKxN/hfSLIkk/zC?=
 =?us-ascii?Q?ngtimKwJxnTM4GIJa7Q7qQsv66jALGp1bzEnNOQNawcENKLg5v8zO31mJgcu?=
 =?us-ascii?Q?qX5X4ftWcLMMqfOUZL15KXT0zCvuVMBR0OGcR487F4Devd/ldkI5dM9N2+74?=
 =?us-ascii?Q?a/IZphIKPNQUSF9sr7zvlsEpBdP3RKVgnkChiG/uv0Zj7h2CW2NnryMXK6XR?=
 =?us-ascii?Q?KM6Ki/6JM5nA61wzk+OjqIMbs+sZXTb33Xn5UbKWymIOaCLYQjIx2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:29:55.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c294e2e2-1834-4be2-965d-08dd64757e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852

Migrations within a NUMA domain will not change
nr_{numa,preferred}_running stats. Compute it for non-NUMA groups for it
to be propagated and reused for the first NUMA domain when it exists.

While at it, also clear sd_stats before aggregation.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 212bee3e9f35..d09f900a3107 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10398,10 +10398,8 @@ static inline void aggregate_sd_stats(struct lb_env *env,
 	sd_stats->overutilized |= sg_stats->overutilized;
 
 #ifdef CONFIG_NUMA_BALANCING
-	if (env->sd->flags & SD_NUMA) {
-		sd_stats->nr_numa_running += sg_stats->nr_numa_running;
-		sd_stats->nr_preferred_running += sg_stats->nr_preferred_running;
-	}
+	sd_stats->nr_numa_running += sg_stats->nr_numa_running;
+	sd_stats->nr_preferred_running += sg_stats->nr_preferred_running;
 #endif
 }
 
@@ -10464,11 +10462,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			sgs->overloaded = 1;
 
 #ifdef CONFIG_NUMA_BALANCING
-		/* Only fbq_classify_group() uses this to classify NUMA groups */
-		if (sd_flags & SD_NUMA) {
-			sgs->nr_numa_running += rq->nr_numa_running;
-			sgs->nr_preferred_running += rq->nr_preferred_running;
-		}
+		sgs->nr_numa_running += rq->nr_numa_running;
+		sgs->nr_preferred_running += rq->nr_preferred_running;
 #endif
 		if (local_group)
 			continue;
@@ -11112,8 +11107,10 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	 * load balancing there, aggregate the statistics at current domain
 	 * to be retrieved when load balancing at parent.
 	 */
-	if (env->sd->parent && can_retrieve_stats(env->sd->parent, env->idle))
+	if (env->sd->parent && can_retrieve_stats(env->sd->parent, env->idle)) {
+		memset(&sd_stats, 0, sizeof(sd_stats));
 		should_prop = true;
+	}
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
-- 
2.43.0


