Return-Path: <linux-kernel+bounces-568700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3EA69973
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D4F167DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F252147F7;
	Wed, 19 Mar 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HjF3FpjC"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC392144A4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412742; cv=fail; b=K917jnjLop0Q+dbQEA/iVQyA2zqH77GkYMq0cactAiiHpk9/Gkbi+arHgkVEuz0+X166SyzKefe7fQ7Micy8/3aM6KlI+awwAR8MRU3S3sKw3+X0lrhv9BfiAKLoe85tiLYvDcR5mupDAmYeXaveD/dPOLe5lE5zWy/Z+HfPA9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412742; c=relaxed/simple;
	bh=2dBo6tFePsR70JNi4xjbwtoN7lJPyl8dJNHJ9qFCbPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbZAMYWY6zYIf+/6E4ve6PIkHfI2rmz/zrqSB6w967jrUmKeTmw/R2iuEL/aF6GFmJ49lb45zUMEAxUJAZdxUVOcdIrkWsMaPYaw/6H34A4U61/8eEN85bByDcxi81fanjm3rErYQkEsMo0tJ8qAmvjHgz4J5udWX0+2q6VnKHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HjF3FpjC; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaeMGZIzpn/7NaOLFXmIqLlnj30KRtggkgoqEGWkbp7KD6g8h8hqfMUTn1rdbgmkOTr56/O2HJ5gqIOhZdwM3g5nElHPIHBKvoB+pES9zRpyro0864q3ORf4fQ+Aymf8sAV365D11B8P+whJR57nGQhWOSYTJDeo04SsQrKyDlK2oFI1E6wPwdBYvebwb5BG/L6MwL79yt2JlQEwOBPvdTlpLnQm1vRiX+VxRW/EAq9SEHXVkLIAQKktofk95BHczXTT0ZC7RkzMFTy8BNIFPfAdGiHY0muaDqzozGpKbHlZOZMwf1Ucg9MLbn0DlezuQZ8zXOGxM8DV7kN3PH8djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8Xj39u2uR4MqPXlurtQNALFnpUi3B6OTCfu53Izm5A=;
 b=VhPuzF8/nMphf4cUbXtwTEdhhkYcZrWifpoXINhkMmW2I32nNZMK+P1h0lvPI4Ba2QGuJv5Q+eO0soT2/kfiNLi0y5tbXgSuNUmo85RTdAdty67QEBoG/WqcR8+E9hz42ZMC28gPPAi+wQGTxCGjPVjUmtxAwkD8ezGXTOB3t4ZE3cyal0Bl5ZzjNB2ijl3zGuJ4OaT0GasO+KQqx+e8EXi/r9v1sXAJDwc5IOi6ndUasBda/SITr+kz4NskDyGgZEjuhPPIa5MLWHWJcWK5ZsbNQOcJRw7wNLohbSUTMw8SHgoh0hP8eZeo5bF83kMNWdNGpfCNDJ/OSvSdbBjHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8Xj39u2uR4MqPXlurtQNALFnpUi3B6OTCfu53Izm5A=;
 b=HjF3FpjCdG2sJ45ngskjt6Apo3L+DGDIei8LJ2LHRqQXtiPNsFBVvJv3vma38Wiv8EvOI0pbP1GuxxnfwOkMDhRGQMvrBlxb1rD8ukRTTzC1LRp46xJuATaeioq/02JcItv8b+McwhguuP442Jv5YJn8QBq0cmeJuRuzelLXoCY=
Received: from SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::17)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:32:12 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::9f) by SA1P222CA0080.outlook.office365.com
 (2603:10b6:806:35e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 19 Mar 2025 19:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:32:11 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:32:02 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Hasan.Maruf@amd.com>,
	<Michael.Day@amd.com>, <akpm@linux-foundation.org>, <bharata@amd.com>,
	<dave.hansen@intel.com>, <david@redhat.com>, <dongjoo.linux.dev@gmail.com>,
	<feng.tang@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<honggyu.kim@sk.com>, <hughd@google.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <kbusch@meta.com>,
	<kmanaouil.dev@gmail.com>, <leesuyeon0506@gmail.com>, <leillc@google.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <mingo@redhat.com>,
	<nadav.amit@gmail.com>, <nphamcs@gmail.com>, <peterz@infradead.org>,
	<riel@surriel.com>, <rientjes@google.com>, <rppt@kernel.org>,
	<santosh.shukla@amd.com>, <shivankg@amd.com>, <shy828301@gmail.com>,
	<sj@kernel.org>, <vbabka@suse.cz>, <weixugc@google.com>,
	<willy@infradead.org>, <ying.huang@linux.alibaba.com>, <ziy@nvidia.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: [RFC PATCH V1 07/13] mm: Add throttling of mm scanning using scan_size
Date: Wed, 19 Mar 2025 19:30:22 +0000
Message-ID: <20250319193028.29514-8-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319193028.29514-1-raghavendra.kt@amd.com>
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 32265f0b-0c30-4522-e16b-08dd671cbf18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Em3rmXGsOsYvfggcI43NOGCql+BeQdIqHmAARBsb3q/umZaXNEy0RE5QY7Jz?=
 =?us-ascii?Q?isqVLi487UNMc+lTORKpjGQRuZfM1+lyfEPkgMQmI73N31nc3+gsb9X/k9dc?=
 =?us-ascii?Q?tLYN5/eqy11WaQtHBOuHBo6YzbUs6nqtXf7bh2ICiTmfONwAvzrXFol9oc4q?=
 =?us-ascii?Q?tEitkKAx1O9vZptgNuI2qW502hyt9yY7A8NwKAN8Q5fYPqjfXRxPzI44zU+s?=
 =?us-ascii?Q?7YAXhuk3E9RMSEpZzMwPXiZzfCyXcXQmr/apMS0HYrK0uLoM7TeZ5hGGmFBa?=
 =?us-ascii?Q?72grW7GNtJ1up5gxCzuTTRAjp4jMC7hT/ZeIDuoHnR8DbpIu6VFs5HuY+oSJ?=
 =?us-ascii?Q?1SmZIz32S0cfQt1TJgXPt/l8p/Hm4FzLh/PZEGaNH95+mOfZqHHXbh1QZcku?=
 =?us-ascii?Q?enm5zu7EKPY0RiLJUNMISt08dw/JY6GUVapW2aj9VEDZZnvWLdWpZO2Ek22m?=
 =?us-ascii?Q?XbK0hgvvtOzOxYTL8S05qrGEaKOPFbELn1OE2ZAc/831P94O8ngNRzmuYXPD?=
 =?us-ascii?Q?Kg4h2+9cPwFXGce7SaIbum8CYKEc9p4oJv90KqLxdbrrB+hNdmPXqMCB2dPD?=
 =?us-ascii?Q?JezkjAJn5y/Q393QMFNzOk9TGO9lqnpJi9fg5XXdb9cryXkoaxbMnrIVGTuo?=
 =?us-ascii?Q?49wibWqSXLw2Pj5b2Kwg8D0MIiYXCh+9prJXqgdziEv2PXSbRSJMmpR+mdfW?=
 =?us-ascii?Q?uXF2vkA2gomM4HbeSVWwzZ69e07cS8Q03G6lhOptV0Rt84NluS4lFcMu4Fb+?=
 =?us-ascii?Q?cwQiqBXkHcLMu5FBelhainN7fPvdbLzasDFKgMRD77Bt58PWHBDCv07ZpYHL?=
 =?us-ascii?Q?ULUOwLIEOQiYP8xpgFb/BwVsYQAx9Y6eLBtNPX9sn1+EI+PkB1IH4cnVAZBJ?=
 =?us-ascii?Q?/80ut0QuHGJOTGuIiZgGiUh+9KfzfT0e8fCkRFiewMKORQ8rtCNOTWLbaeSV?=
 =?us-ascii?Q?XVoTJ7+56SUQP0y1QOn5U5/z468ZB+SKKsBQOE6dp6lmWl5fJqgttrVrXhmC?=
 =?us-ascii?Q?bTD6O4ElfaGbQfjVq/RvbKp+9xzwdo/qTIGCAUx9FcQOHC8pDnI7pb9Lzfl+?=
 =?us-ascii?Q?eBkK6Fg7iRcPVzn9iFXTZNX3SZES0xXFG8Tc9RAQdcTfodP1/SRbc3cPQaTY?=
 =?us-ascii?Q?C2wrDj0DkBefy+553CkxN48Nax2+TmaB1k1Ghf4qjpdw4lBX4reuqiae3wqI?=
 =?us-ascii?Q?oqVHOJ+wS2wDXUe3TdNixqku443wrvt7bMUdqx94U7aMBghCXIoDXDrm2MKL?=
 =?us-ascii?Q?Mx7v+dyCA2hlktSQ/HxQFGYLqhefXZkT5/YYWoLRZ99o9wTeHpbX+RYvnFkQ?=
 =?us-ascii?Q?8KMBmarpWw0CQg+B93crsnfNbNsOguOnSVBiKguBGibjI3ezrqiy4v734OKA?=
 =?us-ascii?Q?HZ02jhUH6aOy3XXMTxd0XPkAvtJ0VysVtuPoVKDxeumnLM2uWMR2c4ASUy2w?=
 =?us-ascii?Q?snxChhq1zdJoQPX58wytkRHTOORvxwlBECJ/m4y6/a0XXl5bgZwfRCD6lKnQ?=
 =?us-ascii?Q?nrw8SoHVl71quE0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:32:11.8677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32265f0b-0c30-4522-e16b-08dd671cbf18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

Before this patch, scanning is done on entire virtual address space
of all the tasks. Now the scan size is shrunk or expanded based on the
useful pages found in the last scan.

This helps to quickly get out of unnecessary scanning thus burning
lesser CPU.

Drawback: If a useful chunk is at the other end of the VMA space, it
will delay scanning and migration.

Shrink/expand algorithm for scan_size:
X : Number of useful pages in the last scan.
Y : Number of useful pages found in current scan.
Initial scan_size is 1GB
 case 1: (X = 0, Y = 0)
  Decrease scan_size by 2
 case 2: (X = 0, Y > 0)
  Aggressively change to MAX (4GB)
 case 3: (X > 0, Y = 0 )
   No change
 case 4: (X > 0, Y > 0)
   Increase scan_size by 2

Scan size is clamped between MIN (256MB) and MAX (4GB)).
TBD:  Tuning this based on real workload

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 mm/kmmscand.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index cd2215f2e00e..a19b1f31271d 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -28,10 +28,15 @@
 
 static struct task_struct *kmmscand_thread __read_mostly;
 static DEFINE_MUTEX(kmmscand_mutex);
+
 /*
  * Total VMA size to cover during scan.
+ * Min: 256MB default: 1GB max: 4GB
  */
+#define KMMSCAND_SCAN_SIZE_MIN	(256 * 1024 * 1024UL)
+#define KMMSCAND_SCAN_SIZE_MAX	(4 * 1024 * 1024 * 1024UL)
 #define KMMSCAND_SCAN_SIZE	(1 * 1024 * 1024 * 1024UL)
+
 static unsigned long kmmscand_scan_size __read_mostly = KMMSCAND_SCAN_SIZE;
 
 /*
@@ -90,6 +95,8 @@ struct kmmscand_mm_slot {
 	unsigned long next_scan;
 	/* Tracks how many useful pages obtained for migration in the last scan */
 	unsigned long scan_delta;
+	/* Determines how much VMA address space to be covered in the scanning */
+	unsigned long scan_size;
 	long address;
 	bool is_scanned;
 };
@@ -621,6 +628,8 @@ static void kmmscand_migrate_folio(void)
  */
 #define KMMSCAND_IGNORE_SCAN_THR	256
 
+#define SCAN_SIZE_CHANGE_SHIFT	1
+
 /* Maintains stability of scan_period by decaying last time accessed pages */
 #define SCAN_DECAY_SHIFT	4
 /*
@@ -636,14 +645,26 @@ static void kmmscand_migrate_folio(void)
  *		Increase scan_period by (2 << SCAN_PERIOD_CHANGE_SCALE).
  *	case 4: (X > 0, Y > 0)
  *		Decrease scan_period by SCAN_PERIOD_TUNE_PERCENT.
+ * Tuning scan_size:
+ * Initial scan_size is 4GB
+ *	case 1: (X = 0, Y = 0)
+ *		Decrease scan_size by (1 << SCAN_SIZE_CHANGE_SHIFT).
+ *	case 2: (X = 0, Y > 0)
+ *		scan_size = KMMSCAND_SCAN_SIZE_MAX
+ *  case 3: (X > 0, Y = 0 )
+ *		No change
+ *  case 4: (X > 0, Y > 0)
+ *		Increase scan_size by (1 << SCAN_SIZE_CHANGE_SHIFT).
  */
 static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
 				unsigned long total)
 {
 	unsigned int scan_period;
 	unsigned long now;
+	unsigned long scan_size;
 	unsigned long old_scan_delta;
 
+	scan_size = mm_slot->scan_size;
 	scan_period = mm_slot->scan_period;
 	old_scan_delta = mm_slot->scan_delta;
 
@@ -664,20 +685,25 @@ static inline void kmmscand_update_mmslot_info(struct kmmscand_mm_slot *mm_slot,
 	if (!old_scan_delta && !total) {
 		scan_period = (100 + SCAN_PERIOD_TUNE_PERCENT) * scan_period;
 		scan_period /= 100;
+		scan_size = scan_size >> SCAN_SIZE_CHANGE_SHIFT;
 	} else if (old_scan_delta && total) {
 		scan_period = (100 - SCAN_PERIOD_TUNE_PERCENT) * scan_period;
 		scan_period /= 100;
+		scan_size = scan_size << SCAN_SIZE_CHANGE_SHIFT;
 	} else if (old_scan_delta && !total) {
 		scan_period = scan_period << SCAN_PERIOD_CHANGE_SCALE;
 	} else {
 		scan_period = scan_period >> SCAN_PERIOD_CHANGE_SCALE;
+		scan_size = KMMSCAND_SCAN_SIZE_MAX;
 	}
 
 	scan_period = clamp(scan_period, KMMSCAND_SCAN_PERIOD_MIN, KMMSCAND_SCAN_PERIOD_MAX);
+	scan_size = clamp(scan_size, KMMSCAND_SCAN_SIZE_MIN, KMMSCAND_SCAN_SIZE_MAX);
 
 	now = jiffies;
 	mm_slot->next_scan = now + msecs_to_jiffies(scan_period);
 	mm_slot->scan_period = scan_period;
+	mm_slot->scan_size = scan_size;
 	mm_slot->scan_delta = total;
 }
 
@@ -689,6 +715,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	unsigned int mm_slot_scan_period;
 	unsigned long now;
 	unsigned long mm_slot_next_scan;
+	unsigned long mm_slot_scan_size;
 	unsigned long vma_scanned_size = 0;
 	unsigned long address;
 	unsigned long total = 0;
@@ -717,6 +744,7 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	mm_slot->is_scanned = true;
 	mm_slot_next_scan = mm_slot->next_scan;
 	mm_slot_scan_period = mm_slot->scan_period;
+	mm_slot_scan_size = mm_slot->scan_size;
 	spin_unlock(&kmmscand_mm_lock);
 
 	if (unlikely(!mmap_read_trylock(mm)))
@@ -864,6 +892,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 
 	kmmscand_slot->address = 0;
 	kmmscand_slot->scan_period = kmmscand_mm_scan_period_ms;
+	kmmscand_slot->scan_size = kmmscand_scan_size;
 	kmmscand_slot->next_scan = 0;
 	kmmscand_slot->scan_delta = 0;
 
-- 
2.34.1


