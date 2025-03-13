Return-Path: <linux-kernel+bounces-559116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD8A5EFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307B116CB40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED25264FB0;
	Thu, 13 Mar 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nR2LqVIq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2D264FAF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858728; cv=fail; b=GBBykzzl0fQg0QuMyPAE182Nx55FOaMLTo11kuawAe2oNhk3/nJArpt4ZcZUZ59wvgKlRtJMQGcH779EEHC7JyPcJ+F6FZcCXgYclR13YJZjJrLfifZgRKm8uNAOq1l6J75s5L+oRVDIFNFVjdzB1q5GezOXv7Qrm398lqfCrcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858728; c=relaxed/simple;
	bh=beoNR2DjWWdAZMCEaieA0dVGdwpnNn5+3YntxgTzqUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S++IDHh8Uo3/9ZivWhlQCZpTkwM5mwaqKIKphg+Uet8Du0Z2W9FtDcQh1iQ6uL5Q8uCtJpFxYyo3P5pCwJqc+awnWuYkoXfCsotURd1yMA6sTIqD603cXBq2WCgaKdTDHYOsKRnwHssgbAxo47jG67kspiVAuO5paFPNanQFokM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nR2LqVIq; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLeF0l4Va2herFYteQoRIxe0wBYkUrnu4r9Cz192zXJJgrGc9Vaa/PKBGgJgeUJYOim4bP3uBr3qky+AC/+8z0e+YSbwmKxsu5y1WYubCO7yjsEfX0OX8aBb/0gZPyvrIGp6oAlHEm+ZgwkO/zG9qVRauk28jAxb6LZgmhfLpQB9+7607g05FNo/6t61mumhbtiTtvHVjv0d8qovjkSHhLnMI40reCDus/L/9fc5VSbcFZSuzoPl2P098s49rK7v6rJo5IadmEyTDAg8aRFVVRSDXJOuXCUjFPcYVvFls1dJZSEWy0mnJSEAwV2SBVm1V+IiY5X11VXccY0bo77ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IR1T1f8MV2sZYH0x+6dfeth/EPpxARwjEU5Ut2W1Wbc=;
 b=dc1YB3+ih9bPP5MC+jUgNf9qfQYY7GJwON5Jy29U4bVRrnX7N5i/ABGqoX5hGU85Edl4jD+T6Kfk2j+K8aTPA8s4tfS/pOR4F+SyaZ4SxrLGtTYHvvSNx4KNll1t6Hur0mELsuyyJGOgTszhThCiyAB54Eg+GnhwHbgPjh98JKRNuUIJgufrCbKFQpU2cRnCzgASNPsQvEYGe6Up8hPqITCjiASRhvomAnm2TpeWfZlivQ/SNQXAkxDObNxFEbj81jkRYGkO1EnKxPjZcvgdBW+Gb627gArwTca/uIDYkDlFJ2Q/CGqby4Gx2964E3DxX59WO7EF94CxI3sRtlyAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR1T1f8MV2sZYH0x+6dfeth/EPpxARwjEU5Ut2W1Wbc=;
 b=nR2LqVIqyGiCUs7GVkgK+3Ymdii2H/3nuysKmPl8UhtbyhABx8crYujIJAu6Vhc3iu3qT1eCNApbykEUaPPfqI/rpSE9etXV34wDnO/WCruFgbnVOPdLPZEkBQtjQG2jrfRCyobgAXfNouLy5UrZAXzV4m7JIghz0xqIpAuT/Lw=
Received: from CY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:930:11::16)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:38:43 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:11:cafe::94) by CY5PR13CA0031.outlook.office365.com
 (2603:10b6:930:11::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Thu,
 13 Mar 2025 09:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:38:42 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:38:37 -0500
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
Subject: [RFC PATCH 2/8] sched/topology: Introduce sg->shared
Date: Thu, 13 Mar 2025 09:37:40 +0000
Message-ID: <20250313093746.6760-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: aee2aa5b-b773-4e13-1af9-08dd6212d81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IF+lWFupTc5ALRop3Zg5h0IpHdI7q6sTXs32FgTuJofMW2aS+plbK19qAMgQ?=
 =?us-ascii?Q?LQyKHnD3F+AI6M10K9etmJeChT6coWVRJB4tBwRNEjM1DAnKIJfMzn2qEBJj?=
 =?us-ascii?Q?jQcf3GUaQyAWCgiy4QSK/7pL1aTL9N+vA1BS+Auka2irVDcOaB7e2j3DkxGE?=
 =?us-ascii?Q?fiq3tgwefcdJcU+suH1rBwRpv2SLhI0Hh3YP6vK14Wn9EsoPrETcB8liKJHq?=
 =?us-ascii?Q?XRd7ijtobgd9J0N77Sqdf+kkWFeRw0F+KfciiUo28W+HU0Q44UK1i67Y9ZWY?=
 =?us-ascii?Q?9GOvdCBlGg2qAMFouAvhgzVhNUU7+JJ472k5phlNqJuWD4li9wovOiOZc+MX?=
 =?us-ascii?Q?znkAfrTHJfTwuJywFxFRGXaY5/cGynT0mDkM0t2YP3Ctq1jS14w3L+XufBnE?=
 =?us-ascii?Q?M7mVUrkIFfvhbPnXw7A2ipWFRS+h/3riIch8kAR1BlYTpwt4ZWq1I0e08f0O?=
 =?us-ascii?Q?WQZTdzPRGpnTHXAkoMxUfV6fSdXsxp9maG2M6YyxHli8myQbOzJlNKwk7ra0?=
 =?us-ascii?Q?AhiYgzONxs8x6FtNaHPgt5YDzN8ySocFqO1TGb6GOabxcucS2FC3d2c7Xh+O?=
 =?us-ascii?Q?xIjRzJbGXFh5rHxfbOd7VVHyBrtlWZv91yaikCqtp1xyOp1vMwakd0lZe87F?=
 =?us-ascii?Q?mTjdLQnJ89g5WIyy1FwCYi5kjCNnb+aElwmmNKxUd7WmbsY1xmMMuY0/kAFD?=
 =?us-ascii?Q?9odSNefPHs15KmG9mQL9DaWrjWQtvu3hNR7zHIJAQvcu/muJttxxQCMP/eYy?=
 =?us-ascii?Q?2LH6COL4qNCnY63UUNpZPlLWmMZgx6YwNImjGYDIKXKSpxWz4+A0ri7iy9RT?=
 =?us-ascii?Q?GIfEgI35XXTi0mzxtP99pilOXvMUdEvjB8kf50bNGAELLN7fz1Yz0ap61p6M?=
 =?us-ascii?Q?/wlykOCiLtBV7J+XIKI1hb9vkNEPAwlXAviyL/ZKJ3+3rTKqu7XW1pyGGpm2?=
 =?us-ascii?Q?Lil0fyYkcFSvh+lTj+3LG94eleDUmRTNMF1osJ6nzPTNeH4pYhXJRexB7dEg?=
 =?us-ascii?Q?gcbyasYGTmb2Tm+h5REDnu5Ew3ttcMLRNrNzKwcux5uispOlrj9zkWoqSIjv?=
 =?us-ascii?Q?cCw1vhLQVC4RGtxE+9OneySwRrsseyCVbhs1SP05BbrJL7/JEaPc/Eamzc2U?=
 =?us-ascii?Q?5Gv/oXyZ7B3eC2HXnQQtv2gd3LhqeJ9N/6+a1cJ4uIYo1HdRTZBjL2M1BIcD?=
 =?us-ascii?Q?9JIDDpMnwPEk0Zuwf1ISOB5zrLBHpvQIdJADj/8e952Y80Gjo/WZaP3mtc1G?=
 =?us-ascii?Q?EGibjvu11cLbvYT08z6ANVy8ANth1rkH4k5/9ZoAXtnP/n5VWSE03gNG7TwK?=
 =?us-ascii?Q?Xj1KBX3LeKmNJS89bvyH2+KFRo5fhKCd2bAs8k8E6oIDSMH0I22zh7UjI4X4?=
 =?us-ascii?Q?eCWy3VT8jSi7acHiOqWfSc2G7BdM8/kn0eGu0ZX84W6wnSoIwYfEUwD4YQ2i?=
 =?us-ascii?Q?y7D0UOzD9OKDjeDwUXPMdJjYDXISBtCLuSSMdfGzoYomV2lEq+nQDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:38:42.9751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee2aa5b-b773-4e13-1af9-08dd6212d81a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

sched_group(s) of a particular sched_domain are created using the
sched_domain struct of the child domain. Attach the sched_domain_shared
struct from the corresponding child domain to the sched_group.

This shared struct will be used to propagate the sched group stats up
the sched domain hierarchy to optimize load balancing in subsequent
commits.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/sched.h    |  3 +++
 kernel/sched/topology.c | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 023b844159c9..38aa4cba5d1f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2089,6 +2089,9 @@ struct sched_group {
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
 	int			flags;
 
+	/* sd->shared of the domain from which this group was created */
+	struct sched_domain_shared *shared;
+
 	/*
 	 * The CPUs this group covers.
 	 *
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 815474823b3f..508ee8aa492b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -612,6 +612,23 @@ static struct root_domain *alloc_rootdomain(void)
 	return rd;
 }
 
+static void link_sg_shared(struct sched_group *sg, struct sched_domain_shared *sds)
+{
+	if (!sds)
+		return;
+
+	sg->shared = sds;
+	atomic_inc(&sds->ref);
+}
+
+static void free_sg_shared(struct sched_group *sg)
+{
+	if (sg->shared && atomic_dec_and_test(&sg->shared->ref))
+		kfree(sg->shared);
+
+	sg->shared = NULL;
+}
+
 static void free_sched_groups(struct sched_group *sg, int free_sgc)
 {
 	struct sched_group *tmp, *first;
@@ -626,6 +643,8 @@ static void free_sched_groups(struct sched_group *sg, int free_sgc)
 		if (free_sgc && atomic_dec_and_test(&sg->sgc->ref))
 			kfree(sg->sgc);
 
+		free_sg_shared(sg);
+
 		if (atomic_dec_and_test(&sg->ref))
 			kfree(sg);
 		sg = tmp;
@@ -746,6 +765,9 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			if (parent->parent) {
 				parent->parent->child = tmp;
 				parent->parent->groups->flags = tmp->flags;
+
+				free_sg_shared(parent->parent->groups);
+				link_sg_shared(parent->parent->groups, tmp->shared);
 			}
 
 			/*
@@ -773,6 +795,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			 * the child is being destroyed.
 			 */
 			do {
+				free_sg_shared(sg);
 				sg->flags = 0;
 			} while (sg != sd->groups);
 
@@ -972,10 +995,12 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 	if (!sg)
 		return NULL;
 
+	sg->shared = NULL;
 	sg_span = sched_group_span(sg);
 	if (sd->child) {
 		cpumask_copy(sg_span, sched_domain_span(sd->child));
 		sg->flags = sd->child->flags;
+		link_sg_shared(sg, sd->child->shared);
 	} else {
 		cpumask_copy(sg_span, sched_domain_span(sd));
 	}
@@ -1225,9 +1250,11 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 	if (already_visited)
 		return sg;
 
+	sg->shared = NULL;
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
 		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		link_sg_shared(sg, child->shared);
 		sg->flags = child->flags;
 	} else {
 		cpumask_set_cpu(cpu, sched_group_span(sg));
-- 
2.43.0


