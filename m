Return-Path: <linux-kernel+bounces-357621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9459997363
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C828659E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B611E1A10;
	Wed,  9 Oct 2024 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5rotEBds"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321841E2600;
	Wed,  9 Oct 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495716; cv=fail; b=TitBY8wAzP1BJH+nhodLfYwg6626aMg1GvzXc7AeVpP8FHl2tF9O4lig+fLH79gbj7VUXdi0N9YBH6KTpWCz2DZJXJ07gTk1zRDLqYj5sgkxbv3AyVHPbnZGeM7sYzUhuRylXUl/IdAg3xVMA2ESWNcOGsv5YlsCNXXP8CajOdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495716; c=relaxed/simple;
	bh=3v6e6FTzORMmiObSB3M440Kxb0phw9hOhS8Gm7oEa4Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJroBtM9fRoKGg4qPy0qC/BPbTGm4keFHCRcJ89y05Gdhqe7XCWthZgiC0a3YeVeLLk4CihOuJujf1w7wmOwf215incmd6bO8yXZMYE8v/vUn9sAyrNvkDJAbneBQnRXREePV+0XANBRYauyYw5VlK7WMKg+yg48lZ9af5gAB24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5rotEBds; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUXnw5PjkAbkGEp90TjXe9KT3wvEFAeLhGJdKuUcY2AfOB/0neFkLnmV7GPr8zD0wCumf2Efp/TqLf+eQC1qL3Lp2VrRRkPvFEaMZAXSJnhp2H2k1zQv4fTq4db/bq25DPi39jQn/aw6Vlm1aQPYCX2dwybjpvvx7u2ux8T3SHfAmq0F8VIT98HgGQE5nOZhaAKBV2N/f5ovXxDnOge4naVWQo2oPEIOuGDK/uR0b5GStKXVTwFwjTL3JCv9XGYlNSFJ38vdrUNz6Ei6sJY7OQd9nXxC7Gd8UDQrrDKUthIc0A8YDwcegnx3H2W0dh0ilG53QXVqKZWgysZWlhyjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FontY8M27P3KEF5HatrQLgY/cY8MrR0WU1Tg7SNrTrY=;
 b=EUOtcrYSbpcdObOp2kdypZW8D1kHT8O3emNkJoEugleQCTlz6Hs3mPpEsSGLrLnX4FBWVw9IqyKbh5ILRTo1HlCDGGeBC+Gwf0QgkPO5s4tLGxDf92ruHQiBhpmLNygQVyV8WOyzVI4dyMDHKiLx3flFGFvLTR9ma8QmRL/WYLjsLVahKRVPnbi/ZCC7Hq0/4XGhF5GHe/DuY7Y+F8i1JZs8OGf9GgS9QbNQy23iVuQVAWD8EeLPFAb8qJDIiS2/Gf/sZkHh8rk15/QD49rG0WgwZzj6SCcLVMa7TtgS5vhfdYGO5Qe26sh1Duh2OFxzqZj28EWl8drR011yw2ClbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FontY8M27P3KEF5HatrQLgY/cY8MrR0WU1Tg7SNrTrY=;
 b=5rotEBdsWTA2e/cVrxeXxuXsTRvFm5LEvhfQ3yVZuTo8rmwEgcl+tsQw2I16XEN4vlmTlYJ44Ugyo00EYbA4QLSzU4IX5RdTZZgp8dg8RO4R/vGzVSHTkHjrSVf74SWusygkYGadRGvhv+cSBvBB7mGLwmgRcSIdjE1EpjkMqYo=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Wed, 9 Oct 2024 17:41:48 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::37) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 17:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 17:41:48 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 12:41:46 -0500
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
Subject: [PATCH v8 13/25] x86/resctrl: Introduce mbm_cntr_map to track assignable counters at domain
Date: Wed, 9 Oct 2024 12:39:38 -0500
Message-ID: <2362cc9dc2e2e30c560423add198b621ad3d3307.1728495588.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1728495588.git.babu.moger@amd.com>
References: <cover.1728495588.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: b714a2f1-c71b-4627-952d-08dce889a6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+AgMjxvWIUSbvyoi7YIgK6HsDLPPPYmHUqujqazAuRGkQBQpKb96zi3MJMby?=
 =?us-ascii?Q?oGCY5TZSl72cRrKUij9r+fsf1iVRu7WUW16yyCfiIWsrKgiVNMjO2qBXTGzd?=
 =?us-ascii?Q?90O685eaxxmBOKUWj7gtQdOXWc8cOjA9t0MPcnIoQONdCBHlFHYZW4oNZY3J?=
 =?us-ascii?Q?NN33H4QrgaoOapKvof6+Sl27vQ+1bJVHGNjv85zIahMGUJIekNs1+VZqxPUo?=
 =?us-ascii?Q?tcN/IuXsKhc0UDpRJqZgefuLkOoISgIloBkJg/eM8uCNCiPH8216u1Bt5wO0?=
 =?us-ascii?Q?cX9kO2likU0RMNfaQR4pI9RHEWFkelLoy3U17ID/tE1utOTaW3GzNg9pj2nI?=
 =?us-ascii?Q?G10kq+wuXSTS8gC9etiJVOry1onSH2QFHMYzLo4NKJkAIbSaDH5JmuEZbJXu?=
 =?us-ascii?Q?5PS6jq1cANiDXrvcqE15fl8WP3GBvK7VfBLPh0dvFhnTjcQzOZ1s26Q6QUs1?=
 =?us-ascii?Q?3RON7qbbczsFJ5RLPkAjrEUquVoEQsqXnszCz1trvGMeQ3enLdysJZpyuulu?=
 =?us-ascii?Q?Ccb+3UKMmBJayw6HGEo6Yl5wYYr/hPCpXs+XMTDxxVQqf4nvY6gV+TiBAv5Z?=
 =?us-ascii?Q?VWynv7k9lhE0V8DU+4wRsyTSFtgbyHWK7BhfQ+9XOoqzx3rjdKZC87wo7ESG?=
 =?us-ascii?Q?4EIy9jgzyjndpRQc1GMqFrIOxKvKkk4tXg5JpownXDyd90cyhfdg/rHzV9/B?=
 =?us-ascii?Q?yzt+od+kolT60tmuxQVvIScWdY836hXFQc9ElnqxTIoh60zV22diKjaPIae+?=
 =?us-ascii?Q?eLW26WLmkL2nhjkSIMiDXWRrg24hN78tX7YFCbqRYB2fR4LlaamVhGCVoPbT?=
 =?us-ascii?Q?5D36i/rAiV2+owQ8RgAB6vZyStd0Pgxy8Eub67ZYf++idKVsI7zK3xpPEtNZ?=
 =?us-ascii?Q?bYoGulnhQUc54+krzBI6GMHGkTuUnixkenTjajgg8NKPXgt2viOkSvMyw5sa?=
 =?us-ascii?Q?mAhAv3at1mn6h68e1Ie74Gm9Ri0EQiXiTHbgaoLL1pDPXARsJMrALgjioedM?=
 =?us-ascii?Q?9jDAxxc8hm7GFHPwNV2Ep1U2b+Kw5pwwsx0Qt3GWgBp0MpG3HwFVVgXvojj5?=
 =?us-ascii?Q?PsLQDWyo5+rXFnJryFSUfEoEOgDOycjszgChtVL5DtV+FBPsUCQKXtzNOHBx?=
 =?us-ascii?Q?fXxkHQwZVuE1D+mByl0W5IqReO8pUN2rL2RmgfiL3f7glDAM5cxR4jfO/sG4?=
 =?us-ascii?Q?BLbyA5ikle9YQTWpsUmKWPiXzrQiiW2AajKneCuUWpP70/bHJcwqeBpzWCuj?=
 =?us-ascii?Q?iRlC0YwQ+aYOTqG42I+NN+OKWIIvVBgpps9NFEjbf0hPXliX6aJH8Br/oaVT?=
 =?us-ascii?Q?oJNRFurJc/gGxydzYR3EPvtwVLRH3ESbtffwoOhbQ2Y6j5Iv+BMoMrCiOPXL?=
 =?us-ascii?Q?XC8/tQwgwi/Q0ibOdHRvgaN6O4nT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 17:41:48.2787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b714a2f1-c71b-4627-952d-08dce889a6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814

The MBM counters are allocated globally and assigned to an RMID, event pair
in a resctrl group. It is tracked by mbm_cntr_free_map. Counters are
assigned to the domain based on the user input. It needs to be tracked
at domain level also.

Add the mbm_cntr_map bitmap in struct rdt_mon_domain to keep track of
assignment at domain level. The global counter at mbm_cntr_free_map can
be released when assignment at all the domains are cleared.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Minor commit message changes.

v7: Added check mbm_cntr_assignable for allocating bitmap mbm_cntr_map

v6: New patch to add domain level assignment.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 include/linux/resctrl.h                |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ba90e520150f..610eae64b13a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4093,6 +4093,7 @@ static void __init rdtgroup_setup_default(void)
 
 static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
+	bitmap_free(d->mbm_cntr_map);
 	bitmap_free(d->rmid_busy_llc);
 	kfree(d->mbm_total);
 	kfree(d->mbm_local);
@@ -4166,6 +4167,15 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
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
index 54eacc8a9d49..329fe23474ff 100644
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


