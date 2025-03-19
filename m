Return-Path: <linux-kernel+bounces-568705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B42A6997A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BF548329B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0296A2147EB;
	Wed, 19 Mar 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EmXCUdck"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0D2135D8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412789; cv=fail; b=sPibLcUXUPxL61vIojoP5iPgyZy90aGVt0NEh/Y0P11gTIzBCqHRDmRj/+a20F3XVMQyy9pShh+bZOtwzfgV9HOnU+FFKPdQULzn6WwEXAGsq0lNA7Ke/Wi5IjJkBWLC5z3DEAXmdcFfl5+hZwFsBPB6VQEgP4EgXYGofic5I1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412789; c=relaxed/simple;
	bh=48hgjTBd08olsfQeQ9o0gpLsz9RucJiCP+WrMnIXhto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2dfu1cPiwjlF5fiTJcke/193BplzWUhwdXCaspWIsOi4B7v8R6FTon0M756GOVzErJ2AVoaADREEspwfWXcxUMEKzofb2aPe4G/2ZCELveRBsOX7+CTmaMKpdi2ikZ6Cxn+7iBYLB3Y5C7PHImpUfMguZA+LDjLqakh8vtIFQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EmXCUdck; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbThxnNT3sDyTD+HFT8KeE/eohImjEKvRngChsKKkTiOtbkfhnCsOUhyfoHG5flfIeMJ9GJ3kev9wIp2MV6li87aQ5WdPwiH0APTpVN/bqjvJkIWF/NPhVZPEQiAD8aG6YJhNL+lAtd+DMnCMPFiv6E8oWpMOAhDSy4t27U4viaovusMxhQQl8pw/pnx6RHO5svpnvaMpS4PyCAtbBJHPflllzol/aFDi8rp9ZUX4ocZYFRV1Pkr9YKmKf3Gp8wIYuJnPjxijP9njQjpyprmS+HViIjhC8YOaBFVm6XTgM/CGpargSihJgE/t11rxRDWmeU7LQoBfM1UA52Mw8PkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYUB9Y5oL/vnLd9PbKivHKRUxW1ZVjk0QHYKJpkjL8Y=;
 b=d+Z5ZmzGtq2Zq6ArdCC2/XgRAbBUugeKcm4QVHW0muQxgrVac4WzVvzUtRGkTzglIVsGE2RTinA9Ft4acsyrT2U913MpBMM84r31RcAwUdT5MR8B5c3/z/KuIdUP1S995RQl/ezcFxxLr0hpsNm4D1ZPjWEbrz8Yxi/+x3NcLbc1Qf1iyLk0uMtnJGxxgfN6zZltc8Pnm+9t85fB9ctXDeCKQC1LfTc/HfS87YFPrSLMIKxF3ESIloze/eG3cyN+ePWscAcKpEF6e+Z1Y9gNljiSfXrwub/uFVtIG/sQ0gSv82yIVf40m38dm41ePpbmxyIpUofedKPezq1VW/etYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYUB9Y5oL/vnLd9PbKivHKRUxW1ZVjk0QHYKJpkjL8Y=;
 b=EmXCUdckkV9nMB7LnWlYx3I9uMajNBcX/RNm0oTUmK9BnLf5uKbp/MEyk8vd9vjpGvB82yNLWFDmJSQVhOM90DuocRFGE7kPrAd69iDlH4/a1AUL/EGgg09NMvmBEP5ssxUOf4VgzMASJgdj+mGVe39yRDaVP0nonGqdAOy7VoQ=
Received: from SA0PR11CA0169.namprd11.prod.outlook.com (2603:10b6:806:1bb::24)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:33:02 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::1e) by SA0PR11CA0169.outlook.office365.com
 (2603:10b6:806:1bb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:33:01 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:32:51 -0500
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
Subject: [RFC PATCH V1 12/13] trace/kmmscand: Add tracing of scanning and migration
Date: Wed, 19 Mar 2025 19:30:27 +0000
Message-ID: <20250319193028.29514-13-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 868d5814-7e1f-409a-7c98-08dd671cdc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzZ3jZA9+096bwOrh/i5UbiNtTMFuIT766qHEUdYOmOvR4TiAetx8Mlu3EKd?=
 =?us-ascii?Q?UhdDMc0RVMbHvtNrv08eGYJQF+24uL/n3D1hdgahLYysmOYw7IoCv95z4hbt?=
 =?us-ascii?Q?7KvmpwQr+4pBZrOHs8qtVa2pLjXX6hzWzaNZK1t3drwEXFHKdc3SV0UoXSej?=
 =?us-ascii?Q?kgC90qBVm+npYY3tqGK4ANsMkcX5TuffSPGqyhjezZiXN78YZdCREpya+0uZ?=
 =?us-ascii?Q?+OfWmuv9BBdy3JLRviNZMXnVBfikXvsjUCV2srPGA0TUNsQ6u/HUFTGbMZGz?=
 =?us-ascii?Q?30lek8Oprc4ktjb++9Oao6IJMTlLvuzNE1qTIDb1Jk92jNE7imGv4vEAAbOa?=
 =?us-ascii?Q?s5zU+0jaDbkA0vbwq/UJgKcZcnx7X59G+L+fdoViDJZgPOFrFpaY3lYXF9BG?=
 =?us-ascii?Q?LUKZRv65xxrv6X62ijXKoHyWai5TQwpEGhSRrZy5T+vIHlbnIwi5LaHBlTuH?=
 =?us-ascii?Q?VRS/8KrYrCjHkXdwM487lnpcXeZhHPsJ4lYybw5O/KbX6nTK8U5fQl0sGbF1?=
 =?us-ascii?Q?lu9qKupdlwaEgfAqAdZTWibhzykoriPJEpNvxAT1h/vBB/Y0xqFLUiqtUBIB?=
 =?us-ascii?Q?awE+8QwR3s4hd+uH4W3G/+mUYgmZOU/zc/5hkaT5aSGSeXOitNsETPdm/8KD?=
 =?us-ascii?Q?eMs2SSGbjiffR1nmiqZ3ii9hU8SKdwf+mu4mpIQMk+Xgjycgd6G1KY1MCCTs?=
 =?us-ascii?Q?Ft3OKqy7od50zlw6pVzk3W3VUBgpaITpLs3o04RmLqSPFyOQ69xrTP0us6AW?=
 =?us-ascii?Q?WJr4eA8bnCoy0TkreVPL82SLRXW0niyTlBWTp4+/9vdYXHGhep3R7fKKYsrd?=
 =?us-ascii?Q?0DYf6HIghTIBHoXuooEDQHLH5O9Po5GaeaS1zXr2MznQEEXKJboP2pDoI539?=
 =?us-ascii?Q?HIRK27uwzxybBP6wfGnSyRyxx3vUQsb6g83r8s3ctUwJxBAME7J3BjXUISIm?=
 =?us-ascii?Q?ZrJINnIFQV2q4hBCHG0D8uL6JWo9H8SI3QrMvudne70xX12dGFcmvtpU6IeJ?=
 =?us-ascii?Q?TaYixhoIRjQ6nT0ew1yO2d5D8W0mSX1AqljvpSZWTUssPcW5HazaNbYPtLWo?=
 =?us-ascii?Q?t4F4swUMtJCcoliFtdONyae3TcJE4SutHclnJDUGyki7JY+3+Krm7v2f2sXM?=
 =?us-ascii?Q?6bg6RWNnXErgneRcCjipBOpU5jmyEQo2axjybSrb//M0ZZRmvuYmm2NeEqKv?=
 =?us-ascii?Q?OWmriHj81LODuV/GrYb5UFYZz3UKvRuU4WRKb9HJfq285t2lwR5gAEXyV2ES?=
 =?us-ascii?Q?BnGEmD0G3fCfjy6vDgY7KTqGHmfYFD4Yof80SGPX3wOMx+kDVtLRoBbk5XeM?=
 =?us-ascii?Q?ncVqH1noXshHKJ2v1DxabaT8Zjd1NYD336V3ToFTsP9uZa4JGpAEy/U0E15N?=
 =?us-ascii?Q?0NK9easAccvRAs+QB8QjKCrxsyOoRfoloEyvbo3uKR5fNvBA6m+t44o46KrU?=
 =?us-ascii?Q?EdycAqcoXEUzBbqLadsWw343ar8f8fcSyiZ75ixBCOo5sP/bOPhH2lPvR+cN?=
 =?us-ascii?Q?OQedkDWCFTTHUnQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:33:01.0827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 868d5814-7e1f-409a-7c98-08dd671cdc6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925

Add tracing support to track
 - start and end of scanning.
 - migration.

CC: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: linux-trace-kernel@vger.kernel.org

Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
---
 Changes done based Steves feedback:
 1) Using EVENT class for similar traces
 2) Dropping task_comm
 3) remove unnecessary module name in print

 include/trace/events/kmem.h | 90 +++++++++++++++++++++++++++++++++++++
 mm/kmmscand.c               |  8 ++++
 2 files changed, 98 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index b37eb0a7060f..cef527ef9d79 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -9,6 +9,96 @@
 #include <linux/tracepoint.h>
 #include <trace/events/mmflags.h>
 
+DECLARE_EVENT_CLASS(kmem_mm_class,
+
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+		__field(	struct mm_struct *, mm		)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+	),
+
+	TP_printk("mm = %p", __entry->mm)
+);
+
+DEFINE_EVENT(kmem_mm_class, kmem_mm_enter,
+	TP_PROTO(struct mm_struct *mm),
+	TP_ARGS(mm)
+);
+
+DEFINE_EVENT(kmem_mm_class, kmem_mm_exit,
+	TP_PROTO(struct mm_struct *mm),
+	TP_ARGS(mm)
+);
+
+DEFINE_EVENT(kmem_mm_class, kmem_scan_mm_start,
+	TP_PROTO(struct mm_struct *mm),
+	TP_ARGS(mm)
+);
+
+TRACE_EVENT(kmem_scan_mm_end,
+
+	TP_PROTO( struct mm_struct *mm,
+		 unsigned long start,
+		 unsigned long total,
+		 unsigned long scan_period,
+		 unsigned long scan_size,
+		 int target_node),
+
+	TP_ARGS(mm, start, total, scan_period, scan_size, target_node),
+
+	TP_STRUCT__entry(
+		__field(	struct mm_struct *, mm		)
+		__field(	unsigned long,   start		)
+		__field(	unsigned long,   total		)
+		__field(	unsigned long,   scan_period	)
+		__field(	unsigned long,   scan_size	)
+		__field(	int,		 target_node	)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->start = start;
+		__entry->total = total;
+		__entry->scan_period  = scan_period;
+		__entry->scan_size    = scan_size;
+		__entry->target_node  = target_node;
+	),
+
+	TP_printk("mm=%p, start = %ld, total = %ld, scan_period = %ld, scan_size = %ld node = %d",
+		__entry->mm, __entry->start, __entry->total, __entry->scan_period,
+		__entry->scan_size, __entry->target_node)
+);
+
+TRACE_EVENT(kmem_scan_mm_migrate,
+
+	TP_PROTO(struct mm_struct *mm,
+		 int rc,
+		 int target_node),
+
+	TP_ARGS(mm, rc, target_node),
+
+	TP_STRUCT__entry(
+		__field(	struct mm_struct *, mm		)
+		__field(	int,   rc			)
+		__field(	int,   target_node		)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->rc = rc;
+		__entry->target_node = target_node;
+	),
+
+	TP_printk("mm = %p rc = %d node = %d",
+		__entry->mm, __entry->rc, __entry->target_node)
+);
+
 TRACE_EVENT(kmem_cache_alloc,
 
 	TP_PROTO(unsigned long call_site,
diff --git a/mm/kmmscand.c b/mm/kmmscand.c
index c88b30e0fc7d..38d7825c0d62 100644
--- a/mm/kmmscand.c
+++ b/mm/kmmscand.c
@@ -945,6 +945,7 @@ static void kmmscand_migrate_folio(void)
 				}
 
 				ret = kmmscand_promote_folio(info, dest);
+				trace_kmem_scan_mm_migrate(info->mm, ret, dest);
 			}
 
 			/* TBD: encode migrated count here, currently assume folio_nr_pages */
@@ -1115,6 +1116,9 @@ static unsigned long kmmscand_scan_mm_slot(void)
 	mm_target_node = READ_ONCE(mm->target_node);
 	if (mm_target_node != mm_slot_target_node)
 		WRITE_ONCE(mm->target_node, mm_slot_target_node);
+
+	trace_kmem_scan_mm_start(mm);
+
 	now = jiffies;
 
 	if (mm_slot_next_scan && time_before(now, mm_slot_next_scan))
@@ -1172,6 +1176,8 @@ static unsigned long kmmscand_scan_mm_slot(void)
 		kmmscand_update_mmslot_info(mm_slot, total, target_node);
 	}
 
+	trace_kmem_scan_mm_end(mm, address, total, mm_slot_scan_period,
+			mm_slot_scan_size, target_node);
 
 outerloop:
 	/* exit_mmap will destroy ptes after this */
@@ -1323,6 +1329,7 @@ void __kmmscand_enter(struct mm_struct *mm)
 	spin_unlock(&kmmscand_mm_lock);
 
 	mmgrab(mm);
+	trace_kmem_mm_enter(mm);
 	if (wakeup)
 		wake_up_interruptible(&kmmscand_wait);
 }
@@ -1333,6 +1340,7 @@ void __kmmscand_exit(struct mm_struct *mm)
 	struct mm_slot *slot;
 	int free = 0, serialize = 1;
 
+	trace_kmem_mm_exit(mm);
 	spin_lock(&kmmscand_mm_lock);
 	slot = mm_slot_lookup(kmmscand_slots_hash, mm);
 	mm_slot = mm_slot_entry(slot, struct kmmscand_mm_slot, slot);
-- 
2.34.1


