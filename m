Return-Path: <linux-kernel+bounces-240267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A94926AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F64528145C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AE194AC5;
	Wed,  3 Jul 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MOvVHy5l"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DB8194AC4;
	Wed,  3 Jul 2024 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043473; cv=fail; b=P7Vonf0WfbnvYlPAIR575XJNJkfxRSs32WjvascrEkfdl1VGeRYA5tMcdeLBK+lY6Wz/ZysEDqenIexrBQn9kvG5SSTArEVX8U142chOs+4zkeIcAMHTmUo9/j93uSM88K8a+E6uInBuwE0JXlBWu67172pzg+lJezS9zI+8aYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043473; c=relaxed/simple;
	bh=CU6SO0kAXbQnO9dniZsPY1sqLqVPLOCkBJgApCvboOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTA4Q4hGllsRyF8KWVmHgIuhLTGVFH/g0tqETIvUzRVmEbnoNdP305orII4XmGdlzfm4/3I+JnDQeD+7D9+dsWfAtufYTG7aZ8AiTGausln9/L3qBLFM/SeB7iBuw6b8+bAuuxtZSrWt2ZA00oHRc/ldN0c+bIP17HDlLrZYSI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MOvVHy5l; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzGLjwf1l7N3+8Sbc4SgDNozVdWX7kRsz5CzFKeZOXEyoB77/3Uwkd9LDIQ/9uMyH/yaAvx2AbexqvKW2rUYbzssrH1KfxOcYrTaSZFOZZ8BfIM2WrfkoBwsOq0CXHKHyQM+seXNUb2TnFkseh6JLa3SJkDdsNLM8Abm+J68e81OrII8QqW6p9lc7sKW1D/eX9G0RWbdRT5R215xAGu5y7RNRahCKtKoXVRF18ZLIYSYHhOjSh2zH/78KY4pbYRAJWDB5GY3/8ylsxArWJ3mpFqS+XRR5/Ze46diSfLlL+RWwXLV6hPMRtCI0iQ9apk7AWAnDjOulzCpQJRsTfbfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SmqqyToPrcIZfWLknPF8X29VVoSLT/I9ubg2MjOVII=;
 b=mVBIUd+4atPqY1bjo0PaKyH+SoMRM+DeXXuH9vbeIBmb8pDhWHMy8aJN14w5RsHBUWugNqbX8DSvQ1lMTqNkcqkYp2HQNsLhlrQ4kuvyOrXmxeE/Idmy0BpG5ofbfbpHGeQxFQ9/Yoaf4EFRigXvslkn0zIjSM/Q9v1QFPe++hT50H3ilXLZ3NS18AVn32iTCiw9zRdCflW5Ra+HXcMRPKp8J3FKMedrdsOcPlfoMVT1fs2ggzyOLXwhQUmQ4IqaBhxYRW0emoQ2lKF5KTzVmjsSiR6s51YmYAwI4y95wpJwvb4Z7t35sNSq3LqIdhpm2r7c6hgNTYxHslgoUk5Ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SmqqyToPrcIZfWLknPF8X29VVoSLT/I9ubg2MjOVII=;
 b=MOvVHy5lSDfN0Osuin6Sah49QJzaOVo1ttfNn9xX2HtLj/vCpGvhp61nL4qTopiw7t+7t+ngrstUqdkKySjLuhPeOa6PLDgYSfmNl1srSMabaPR/RDkZz8xGFORvrTyX8W5hiNo46E7GzF5PtqvEwdAFVEz3MevBwOl0Dxl4WAg=
Received: from DM6PR02CA0140.namprd02.prod.outlook.com (2603:10b6:5:332::7) by
 SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 21:51:07 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::c1) by DM6PR02CA0140.outlook.office365.com
 (2603:10b6:5:332::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27 via Frontend
 Transport; Wed, 3 Jul 2024 21:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 21:51:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 16:51:05 -0500
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
Subject: [PATCH v5 18/20] x86/resctrl: Enable AMD ABMC feature by default when supported
Date: Wed, 3 Jul 2024 16:48:29 -0500
Message-ID: <9f03d5661a4f054124cc7ae1903207714c5188ee.1720043311.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720043311.git.babu.moger@amd.com>
References: <cover.1720043311.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: 86930aea-d815-4db9-d287-08dc9baa3e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibnFNYBFKav35d9rkY+UFBjaSFVVLiJmWgs5JB0xALPaJ+OaIRBbrdr5r0Kj?=
 =?us-ascii?Q?QPvnWPrYyJopfsriaI8Jo+t6RTMNA6nlGhQpso5m6uprHhPpPeDzKaf38sdo?=
 =?us-ascii?Q?yuVGjUYyAQWIwMAwyiZWgtlAHFqLql8Ry4mNewpOxmLUn8oRJm76SdXT0wXv?=
 =?us-ascii?Q?RHAmIaNa+5diH8pDllO7I2DEWALOJuDUZEGoxmNFWRZtFJrHcmC9i3I0lm5P?=
 =?us-ascii?Q?cuVBcK1SYkY2XMJZOe8p/nIMi/CVjssy3A/t/5SLyQLdvzu0y1XruRwFUSLq?=
 =?us-ascii?Q?FNCl58u/dp1Ckhpb4F+YO0DYVAxAH7wQ2Ak00zhudodox7ssrwP7K3LKhglU?=
 =?us-ascii?Q?JMONP6UsNMtHrSZ0ooH/A0jp8K17nllscK81+LiImSeFq2uFr9fPS9cm5PfP?=
 =?us-ascii?Q?Hluqq1WGZyxsYpDNRJs6O/utDs+ZPSFMRCuoS5FAW+qm6oGM5CdoRQETjq/I?=
 =?us-ascii?Q?FPb6MyV4zWv3lusXqiO+mUe3+F9J+jDOqRYsrkLPAZRkEnS5B6UQ9Sm+Lc1s?=
 =?us-ascii?Q?ZLYHOenUFkTK/121wzNCaTnifmx1PhX8YZfJ7lh6BWDdI5IMI+O//0ZEybWY?=
 =?us-ascii?Q?JIftDrLrtm1WaArGLzje9MYgqLjbUj8yBDhix+uz0vpgaEXlla87CgCt7ydU?=
 =?us-ascii?Q?izPcrbt4jmQG7IdM9gTNWLiDzhuScNrc4L5FE6Q9d+Fonva26dqfpC9pkWFk?=
 =?us-ascii?Q?YM+YvxMTDvZ/yayGUlRNq7qjVx+GWVyLsI4sQtLHXt+X9Xyx6fBBSk0HkAax?=
 =?us-ascii?Q?SDk617CoP9ebFRYT9p1s8vHOmM413eS9KGk9y0TljqmFSD3WdRzpC20zZZjI?=
 =?us-ascii?Q?5nv+ITdYhjDFPY5gj3OKHNG5lvHJRg7RPU6Oaa/lekRbhQcGy1hzWFLipfcR?=
 =?us-ascii?Q?ghenYYaXwpHEiyGhOV5AVnZbDshuoDwy8TE+WkFDJeqOagu+O1vVlIEKzyUC?=
 =?us-ascii?Q?392gCm1YeT65dIMBvSf85bUtqd8E34AVELicdgSf84UScLANtheR5bp/CsJ9?=
 =?us-ascii?Q?CVAa/NB7Av7by8eJmxLeplw88Q1oGZ5nvzS6kdcDArmZcbVwHDL8hmPQ3GlV?=
 =?us-ascii?Q?Xc2tFod8f+a2hy2XG9nkeBFgZXnoAJB79tfA6Y9l2ebx41PtontTRLXZH1ms?=
 =?us-ascii?Q?3r/yeOel3KhlN/CeLsHePZKqIdR+Wd/JRMWqq8pJCE6scaWfOvnmbWhaAEbh?=
 =?us-ascii?Q?zqX109BafIY7PB0gEoPjthlTzZjE/rErcXzATqMQQljm9AMuB6Cs5HXQ7+Cy?=
 =?us-ascii?Q?3OAeV2FyPkK3jD4zREH8GS/DrdTV3w8K/bBH65MW0xhxR5/1YZ7RZitCyclX?=
 =?us-ascii?Q?1IMJMYJ8R2ZAyf2P1Rb7iiQRS42xqmuXlwp3BECAlmokqtXmJ4E/CQZm+fLc?=
 =?us-ascii?Q?aMuA9DAk6J4n+QlIJdis4JRRy3FWWcN8ajtvzAUxCgZWRr6JWC9qY9SzJuCG?=
 =?us-ascii?Q?Sbv7GXpGCa9u57A5cCY112v5uJJzh52f?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 21:51:06.9855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86930aea-d815-4db9-d287-08dc9baa3e40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642

Enable ABMC by default when supported during the boot up.

Users will not see any difference in the behavior when resctrl is
mounted. With automatic assignment everything will work as running
in the legacy monitor mode.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v5: New patch to enable ABMC by default.
---
 arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6265ef8b610f..b69b2650bde3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		resctrl_arch_configure_abmc();
 		return;
 	}
 
@@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	arch_mon_domain_online(r, d);
 
 	resctrl_arch_mbm_evt_config(hw_dom);
+	resctrl_arch_configure_abmc();
 
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index beb005775fe4..0f858cff8ab1 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -707,6 +707,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init resctrl_file_fflags_init(const char *config,
 				     unsigned long fflags);
 void resctrl_arch_mbm_evt_config(struct rdt_hw_mon_domain *hw_dom);
+void resctrl_arch_configure_abmc(void);
 unsigned int mon_event_config_index_get(u32 evtid);
 int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, u32 evtid, u32 rmid,
 			     u32 cntr_id, u32 closid, bool enable);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 531233779f8d..d978668c8865 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2733,6 +2733,23 @@ void resctrl_arch_abmc_disable(void)
 	}
 }
 
+void resctrl_arch_configure_abmc(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	bool enable = true;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (r->mon.abmc_capable) {
+		if (!hw_res->abmc_enabled)
+			hw_res->abmc_enabled = true;
+		resctrl_abmc_set_one_amd(&enable);
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
 /*
  * We don't allow rdtgroup directories to be created anywhere
  * except the root directory. Thus when looking for the rdtgroup
-- 
2.34.1


