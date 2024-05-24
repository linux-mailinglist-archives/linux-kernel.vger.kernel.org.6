Return-Path: <linux-kernel+bounces-188672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CE8CE535
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115D01C2168B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C6126F3D;
	Fri, 24 May 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f0r/yVlo"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53686158;
	Fri, 24 May 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553467; cv=fail; b=MEv3ugevxxDb1Qw0TN0jPOsLfTUk2mOSPZ+LpHdUot8VAV37Ukq6EV0zdy92Aj6pSg1g7LDP08wO/f6Hem0M6iUkyJHcgCN4mAv4EtsZmh+Infb68X1uZYh+MKvhK5vcfDogIQr1vMqp63X5GTdf3tGQxFoqWDzY6/XRq6dr1lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553467; c=relaxed/simple;
	bh=9+XoKmrEIiaUPjtkrrfL8cLI2NpBkcrezGjqjSSi91I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IS2VWBTiIItKh1i2d05wMdiA0nEf1JjNzTbLI2jNZxPDhUzJ/DVi0q2ql6unVydLVK7ZDY3OiLPHgl03NM81LQHIyQjUCb+bJM83tZzz6SoPsw96h3YIoVXJI9JgZEjgljBTcNcIcw9T75WbmV/Nyo8GT7u859nB0uQbBZOLk2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f0r/yVlo; arc=fail smtp.client-ip=40.107.95.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbuvqjl3duP0vx+4mANpwVpxbSFd+G+VnGeO62jdDb4YGFc+shP93tYJzgxGMO4OvpdPDonb2kaT/8+AdSJC1J2xRoGHgllGRgV1CRLZ+JYv2dGscKCS1ruR1bfkrvxbMkvTQtQvVlij85qNXjexoRMn7E0Z4gtbin2oq5IbAtCh+VKJjSdxGjo5Wffm8uPyf3Os+4eVuu2z15eazdDvWbeNzo2Wj0aqslnQOD2kG2qRFbPhH7QTr6aBZl3o8iccefDRxvTDgBVTTszLQfiq7l64NYqdVfpLApkYiHIAnAbyF8CsCEm6YO79KihcQmzvP2fPeVpMBs2SZzTzcRnftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isqEQEkls0bOXQlZ73sPhSeF3c1cT+dJon0uMe66RqI=;
 b=TpMIZL9U/q/g5Pljr6eTJ+oe+4Y2nDYsi2OdpdDzJhSZ/pHnmXrgHk/8zxfHZwFUHb2fJJnyPDHKKxNWpReqU2ErZxrPmq/nIwhRw4MVk4sDFoxDFwVqcN3oQBe1O0KtPphkcGICP8ejQalURXC/j4xEQ57Jl5hRCXmmyKOP1PsL1LoRG6S+RhrlewCeA6thHrrdoKcNLG5ptar1673Tqa1kIqh5rXrQSAf4qRVwg+vQpwJG5//ZUfYYfz7Y8y7LI9JLhqzdWVxV7wUE1MPH2KQVJtOKNxgW1PFQ1GRC19s2BZvuBi1ZXNMGRMoQOsny5l+CG6DMH/18nCR4z1m/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isqEQEkls0bOXQlZ73sPhSeF3c1cT+dJon0uMe66RqI=;
 b=f0r/yVloA9KXUGiAaYt6PN+vi5BkkM7F9IWGpzWugMgqyy8OKzfLWza3qHdFAYL3Iy9hgQAwHkcDpqhCSHj1xrAYICNWiuChg+cA0do1wAoXQFggOP10DKZzsB92BIRi/mjBM+DkzI7tYbu9MDum3RfPCDeZHlTP0UN5v9xOgaw=
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 12:24:22 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::65) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Fri, 24 May 2024 12:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Fri, 24 May 2024 12:24:22 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 24 May
 2024 07:24:20 -0500
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
Subject: [PATCH v4 04/19] x86/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Fri, 24 May 2024 07:23:23 -0500
Message-ID: <0a73504f355a8b0b0b3d32f6c0e0b8909c552340.1716552602.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716552602.git.babu.moger@amd.com>
References: <cover.1716552602.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: a416490c-3fe5-4e60-86f3-08dc7bec7145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m/IuVEESmhFHjWVbQ8rhN+rEonHOvxIVp/SEHyQadem18BHMPKcnNgUoSqoc?=
 =?us-ascii?Q?cywu65WkHrp7UM5xkzVGq7+QvU/4a7F5EeOncMHMzyf90c953dICfuqhLXeS?=
 =?us-ascii?Q?T7vrlfCvf9EGbKt1f4kOn5mT2iJNGqxHX8S6fcEmALfTBTsIZsCRgrOvtHRv?=
 =?us-ascii?Q?mYQ9P5vKUVvnLEbYH2OTtPMr4aUssfCjsYbJF+ljplZJcbEo6Lz2wdGo3+Xx?=
 =?us-ascii?Q?T817zwKpte/F63Ym24njhcgrp+SxCZhyY9tHExfP1jwcXCho245Ql4U1MPSE?=
 =?us-ascii?Q?Dln6WKqsNxAHAnLCYfY3d4or007fjTDlxpsHZMr1HKtsTLunoK9Pw824vtMk?=
 =?us-ascii?Q?sUnS2YAlc0g3HrVB5hQ9iVjIMV50HjmL8tDXIpv62esQyKET/ejE8oggU0sD?=
 =?us-ascii?Q?s7VecA1w7pYpo724RAJ5A7+A210sHJ7Mynl42cvqyuXAT/BDzxBdI0JswN5X?=
 =?us-ascii?Q?czvZ6I6+iM0q9rb24dCPKBfY5Q/ErOcWO/BSVjUu0jVvTRU6p3PFUNCkF2Hw?=
 =?us-ascii?Q?/OSm7V7kFu7pcLcT3+qg/fkLtoSROp03T2GNBLgL0tCv2gptrkIY6kV2sxVQ?=
 =?us-ascii?Q?0DxmccQxj+tgyi3JmpdhPgwPlRz64NFzzSwMGGo0JkNighEv/JCRDmXMvzS7?=
 =?us-ascii?Q?Ska8PdNa6LyPvUlighOPQwuskV3Us7hHAWfRiP436/8qp0hatN53Umxy9fFE?=
 =?us-ascii?Q?p2Lye5a8RbmiN/31p4jeAhYYkrifBS39cAVB6ewtF6nekav+D93eG+hVfMqW?=
 =?us-ascii?Q?gQ3aC2BktQDdS//0H2XL2iO05yOuAxhBxR0kP4Y2Ag3enHpqbW1BgkVP8env?=
 =?us-ascii?Q?AFEkzmpDHkziKkjVPWt0hVaiCm/HbYkZt2OXduaqZXp/6y72Y/n3UOl9MpVA?=
 =?us-ascii?Q?zZqzkAwiL0Y4VnmFjSszrvYk3nk0UOrl+Ov9v/xnG+SHSN9HV4QrILFz5oex?=
 =?us-ascii?Q?GtVgg4xmG1MUep+BPCKNJIIeuBQkYwIWEW3Ckpg7MIXm/vLivDN0IhxWClf1?=
 =?us-ascii?Q?OLvzclyKqny3xh77mZ4abvodRImK3Qb3Z6ZTqKe5VifTLu5E5PC/Yk0ZalnP?=
 =?us-ascii?Q?Li9PiwNlzlxCFIJt5HuF1YLc0imB5lOxZeO3/fwFSfCX2JY+AIWMQIGWQqH2?=
 =?us-ascii?Q?D968sbjruIM8U85kZG8Bd7uVw7isjnfRGjcCHWWyiHC5OswvxWaFxYk81Wkg?=
 =?us-ascii?Q?ySE7geRY2UdbGF9jeDgzZvy606mKcD7GdHPD9jRYBDpL39mMS22DOwR3ueZ4?=
 =?us-ascii?Q?8Zxfw/FSbOESckRHKLnJTQ/A/dmcO57hZV5LnI2P29t9Y/VrNRdUXVLdBMhM?=
 =?us-ascii?Q?0UZI7tD5N18VG4SmoZRTCL9g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 12:24:22.0929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a416490c-3fe5-4e60-86f3-08dc7bec7145
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
    need to separate this as arch code.

v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 14 ++++++++++++++
 include/linux/resctrl.h               |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index b35d04fc761b..1602b58ba23d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1066,6 +1066,20 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_local_event.configurable = true;
 			mbm_config_rftype_init("mbm_local_bytes_config");
 		}
+
+		if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+			r->abmc_capable = true;
+			/*
+			 * Query CPUID_Fn80000020_EBX_x05 for number of
+			 * ABMC counters
+			 */
+			cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+			r->mon.num_cntrs = (ebx & 0xFFFF) + 1;
+			if (r->mon.num_cntrs > 64) {
+				WARN(1, "Cannot support more than 64 ABMC counters\n");
+				r->mon.num_cntrs = 64;
+			}
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index bf99eb9c6ce4..24087e6efbb6 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -153,10 +153,12 @@ struct resctrl_schema;
 /**
  * struct resctrl_mon - Monitoring related data
  * @num_rmid:		Number of RMIDs available
+ * @num_cntrs:		Maximum number of abmc counters
  * @evt_list:		List of monitoring events
  */
 struct resctrl_mon {
 	int			num_rmid;
+	int			num_cntrs;
 	struct list_head	evt_list;
 };
 
@@ -177,6 +179,7 @@ struct resctrl_mon {
  * @parse_ctrlval:	Per resource function pointer to parse control values
  * @fflags:		flags to choose base and info files
  * @cdp_capable:	Is the CDP feature available on this resource
+ * @abmc_capable:	Is system capable of supporting monitor assignment?
  */
 struct rdt_resource {
 	int			rid;
@@ -196,6 +199,7 @@ struct rdt_resource {
 						 struct rdt_domain *d);
 	unsigned long		fflags;
 	bool			cdp_capable;
+	bool			abmc_capable;
 };
 
 /**
-- 
2.34.1


