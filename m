Return-Path: <linux-kernel+bounces-316041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF996CA49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5CD1F288D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1CF187FF5;
	Wed,  4 Sep 2024 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JfK6y1Om"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFA17D8A6;
	Wed,  4 Sep 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725488613; cv=fail; b=U/HCNMBbq8BEvn3nXnWGxsClJVvakCxvpF7wL0jbOp3xNRtGqjU4ny45xLbFTxEUReQ6OtH1j6shzIW5HnmPOX3suBhh4ZCSw49t2PyB5oxsw+4UGp4eFOcVL+y9wNDm0DIeEC6VmtiYFuoMmW5ghnAuS47Wc0asOFx4dI2zNFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725488613; c=relaxed/simple;
	bh=1IAMJCR6jXLLWJnLZok8Tj52SyyRIWONm7jq4MVn6/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fb1uM/ZuIPPzDTh57AtSAYyTLh7P5g6xdz7cC5WwlgseNeASgG5xxZNd+2R8LM460pr+8P98m51zPRHYc27UW0K4nVA8wHKmQWdGkl6IEgO23K5qrK1cqwqKfHM5DFIWoB4Kx/kW9NS2Sn38dQPuuBhlpw+Hk2qrkAZkQ4+UtvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JfK6y1Om; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EvDEXwE3xIY4aANkmYHV1bdHYkLrto/QOAmSTs7pl1Wa80sBxsyBzsMuTty5vGRTcyq04nGLAohhxyTXmiKdMd3BtlvCLiuYv4/ZtPcHdrz6pjMbjQbFWsrFb8SPMH02af/miyT4ZCjz+ndnSs5+J8SenPCvzlioJ8KJJW7SIxZPLeo1eb1zGUbg1t6nyodfLM+M8ZWnEbERYxhaHzBkbAkA+q/G1KhXjH1Wutg2ZIUyJKWL7VLMRN9nB3I9J+M6YfnGvp0Fvx2/f3LfSRc+xOxLhmlsRF0O8A3BbEQylytkiVp9UllEUJx5HS6XawJ1XkMIFUeRgPryV7W9qpx56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XEpJbwv8IVi3muVtJcdNpW/gd1b3D5DKubVFd+j0o4=;
 b=YL4iv0esqHEkPOVp4tYBS5aqptmu6b/PmeVU/wSYC2nwEhHsClcGO6oF0NMFUSccH9V67r/Ll0QEAssmtb/0hN5VwVNb5ZXUdJRAS3oc+lEpp1C2jZOBlmaTlIxuHwQtwukJTCtYu/vG1CjfpzBRE3us2qHsCO5tpzYYnZYMvc1rb9ICGrWiH9xunM2wxkA0X8azMJQz9HcrXNhhWDiT/rEnWCpn9kjPFkP63zLcCQZHt8vK93qpc7B0pMZM2src+7Z/LS2HoaXQdFcmuh+uvgrZkrLXa1uHuNKQHBvcfBOfNhD3UbY60G9G1LTD2fba15qjAi0ltQH9lBcD0jSxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XEpJbwv8IVi3muVtJcdNpW/gd1b3D5DKubVFd+j0o4=;
 b=JfK6y1OmHVeDtIP4cVIqQuzxEXW8vPZyPN5xw/ph012BPjYsIZXl6IqKVhlisxc0FvoJcPsd01ZZQ8m4tWduIKoUdQjqwnbbfj2BMA3kpyGQBkV1KbjeK757VG1dTgaXknIsOC4B5i3Y/oSOHXDT3B9ejrqCtwsyZkEGjRlZ4vQ=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 22:23:25 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::c1) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 22:23:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 17:23:23 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [PATCH v7 12/24] x86/resctrl: Introduce mbm_cntr_map to track counters at domain
Date: Wed, 4 Sep 2024 17:21:27 -0500
Message-ID: <7a24bb182897acab3daaac1cadaabca3bcc73dc5.1725488488.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725488488.git.babu.moger@amd.com>
References: <cover.1725488488.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e785aca-a875-4e76-63c3-08dccd30316d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r6kTZ4rcZwcT8YeDMwSGpdNISws8FMsBSGg7nAc1BxyrcJudpIehVPN8fX7p?=
 =?us-ascii?Q?B2vxiBR4Du3QKwa9BMU9IhO5T0WAheYud+n4muSWugX6HblSi5wLEbIXr3PH?=
 =?us-ascii?Q?qh2hCwd3xtntzBxMMz307WrlLJhhHUaGyHy/r/OMvtU4meBH5VBf/7S+gMlx?=
 =?us-ascii?Q?jTkdP0YxC4/ILhGKu8Qv+W5raYKQiPlXYfTtAZf9syFIW6+yChNOKI2IoTrh?=
 =?us-ascii?Q?pcp4chfAq9sci2fCjxn6YTKZTP1JT2vG10sZnh4wi/HZsgpvUdFjTLa5iHxf?=
 =?us-ascii?Q?32/dKBJLN8BoFbROXUnGc5o09l4SbTKFNTaYLTYl27/YTFhwPUiwZeSkiUS9?=
 =?us-ascii?Q?HcWxr53fFY5W3CXp7xGa5Eyg3bjENGI0YgWuuYtyG2/cJimK0OuQ5/JrxOBk?=
 =?us-ascii?Q?3P5Zwlr0T+xZZmsxoTh/SJ+X5HCfj9BOCSnM6mrq0fhBvJtitWIfrH/1alI0?=
 =?us-ascii?Q?/CSaQvyWyak0k8z71brNyRsQ0OY4GfWzS1HfSdTeI0mnd2SEE8QZS3l0+/2b?=
 =?us-ascii?Q?nuoAxBmrkoujIW701uFnNJ3Jkpu9ERQSAIL5rynIvFs4smuZmhKDG6jmR7qw?=
 =?us-ascii?Q?rfKGNnZmfLaU5+m3sk6pHOc5Rdm/XqhsYzNkg7bZ5YWWpA+F+Ap8mqcHMv2t?=
 =?us-ascii?Q?v+pP5RmWMO1nULNPlzsHf3iJeN0Q9d94dS+QIX2huhaYHWG/mFDXnLOCxChq?=
 =?us-ascii?Q?GKHQCTJzYQ60mQuptYULQc0bPNL9vzUg08gROkpKQlULMyEqRyiLzsIZziWA?=
 =?us-ascii?Q?tvCZ0Nb9gDi21HFIrv6WGFnmf1L/2QLAtMnPF2ZF7wwU4+UjUwBeLwiGMY+B?=
 =?us-ascii?Q?7d5kMepORAEpaqul4PAcTpmu+/xXm1oxMqWK/mXDYVmI/Ls+FgiNxrbf74bt?=
 =?us-ascii?Q?76UhI9W7iCg9vbiNTskEwOburDFNnvziRgDeKBZ8KuDrd2Bzh7ag5Z0Wl3Oq?=
 =?us-ascii?Q?RrXOFveOAeA/cD/Dqg1KcNErtXNiRqVcDsplf3HqkYPk2J0LCNnBkfU+bZh4?=
 =?us-ascii?Q?d/rvKhPgUM+vJCMALEsO3iBhrH4l8/QQqaxO2k3qp9x6a3PgDz9Hh2kY/tIY?=
 =?us-ascii?Q?Txlq7TNej6slXKAjPLW2Ox+4Y3TOAoCP6H6rnAZBaHfHvw2e8qLxenONLuFK?=
 =?us-ascii?Q?6M+6/oPC8iFrmxVw6lgB3Xz7MXOBcd4N6bHexOB/VlhKK9ilWN4hLDKDWNg1?=
 =?us-ascii?Q?J1nXRATdvfQXd4l0QWWGKrungALH6v/lFrGpXIyB+FL5/m5Ih9eB+n9BvIrU?=
 =?us-ascii?Q?ASi72VXRu1dEcUE4HmJqJRl6CrG7CHwgqNnVLNBa7QZfhqxTAPYez/Bi22o9?=
 =?us-ascii?Q?YXlDkS3ONRWACeLhzw9weQa4fPwTqEQ/y0RPM6MU3/mYC/QrmzsWsd06SqKF?=
 =?us-ascii?Q?U2DY1h6x+qOxKrQJAbTR/0o2Gyn8oZnIAZA5YVRpRFajsuQp+dIP2nxuKuRN?=
 =?us-ascii?Q?/OGurPcxJt2CdJdDpLmdFehmSrhWB9w6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 22:23:24.9738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e785aca-a875-4e76-63c3-08dccd30316d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

The MBM counters are allocated globally and assigned to RMID, event pair
in a resctrl group. It is tracked by mbm_cntr_free_map. Then it is
assigned to the domain based on the user input. It needs to be tracked
at domain level also.

Add the mbm_cntr_map bitmap in struct rdt_mon_domain to keep track of
assignment at domain level. The global counter at mbm_cntr_free_map can
be released when assignment at all the domains are cleared.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Added check mbm_cntr_assignable for allocating bitmap mbm_cntr_map

v6: New patch to add domain level assignment.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cc101fbe8683..a014d5f4c0b3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4092,6 +4092,7 @@ static void __init rdtgroup_setup_default(void)
 
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	bitmap_free(d->mbm_cntr_map);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -4165,6 +4166,15 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			return -ENOMEM;
 		}
 	}
+	if (is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		d->mbm_cntr_map = bitmap_zalloc(r->mon.num_mbm_cntrs, GFP_KERNEL);
+		if (!d->mbm_cntr_map) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			kfree(d->mbm_local);
+			return -ENOMEM;
+		}
+	}
 
 	return 0;
 }
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 757708cf5d3c..882a6ec55f27 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -105,6 +105,7 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @mbm_cntr_map:	bitmap to track domain counter assignment
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -116,6 +117,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	unsigned long			*mbm_cntr_map;
 };
 
 /**
-- 
2.34.1


