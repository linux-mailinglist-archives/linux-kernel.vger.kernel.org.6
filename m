Return-Path: <linux-kernel+bounces-536771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6FA48432
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485831722F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201AD1A5B99;
	Thu, 27 Feb 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hlcy2vI8"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5C1CAA96;
	Thu, 27 Feb 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671864; cv=fail; b=orGJHJWa5kB/zw4b7rp16Jr+f8eLdnV/q1UtxP6/xlqLamFLTjnAR1o8Z83yds70jCdtJWDVuKry37qrkja41bPVpW8c93MjLTziKLTvFcrJG7r4I18hpOZTCezVHCBtC5xwqgcJbdZXqqZakMujKls14h8qJGOYSNt59CCZEu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671864; c=relaxed/simple;
	bh=nf5EvbXIIKb2WBg1S+PcdS23Q33RmegfyqqHuafkZJg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JjEQLg/K8/HKMNWIo0wAqCqAdp0OWX92SulsGYA64wYFu+KVqUHEcE6lNV5QcSyXPmXkP4Li91smwsbUMmvVAK3Czx7DJIbNWn3hb8k3THlbObDUjSxVo9rnuLjfwYPhzmFqy2CkZ55CfMURDtu6Y+RQ14fSFO/UmhM2QdMIC3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hlcy2vI8; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw1+JGvFClUqZvUYrOG43JbXI3VKlZPgsB/haMENoZcmro2QeWwzWNlxh2zWQmJE4n0e3/P2qVSW99yTb1Myr7esbRnAuYm72OfuvQf/4qu8YCyyvMbUcLscObid+QQM/udlY6/P72VIGShzc2fJadvVrzrGlvlQ8wYjUcmFqRZr1WjBu/seKzBrjzWLSWYmGVKMLNOJ69/Aen76pDS1WpRSSupxri3BMChDojQjuNEIvfhkriKp/22mAq6MQLTQFG82bK/SJ/JfYUlaTD7z0K3ajlfX5EDzEJxOtEyIKpi32OL1JEiF9To7rP65PeFNHzH87beMgcx73YUe5NIt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCfop5265wZatf1rmpgCXSayRR7/vLtY9ryXjPu+EkU=;
 b=XreUIkknjNAnXH26T6eAXL8Exn2U5CX6KEz+sXG7x0wxcvG4vr/kB6aanH6nHZ3gXn3wkVDQ+lGTROi3iIMMi2ehd1MMpasG3RYgiw5KuqjscXkUSDPzKsOLytL3ZjL7INlnRkAV3IPSbn/JXUcfZThX+jTwLKbDyrwM3/THq1lvQwo/XvEUY8h4Rqr6cSdrDPCbo0u3CUCU+vs1K9U9BNphRMonbh3KvfrawzJeu3bita/f54yX4X7QqC0TJ/Nc71V7Nfixv1J4E/9WGTN3nlX9JLuyMt3cjZD2juKOSdAfo7jNvajmzXCFv8B5FZhcQ18l2MtlsIdMiKOEBVHPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCfop5265wZatf1rmpgCXSayRR7/vLtY9ryXjPu+EkU=;
 b=Hlcy2vI8IFKiyekoa2V+uR7bREw/zWDuXw1ldFNDWaQudUtyMdBVwY9R4l0/uLvv64hYgPk/OmKj+4LvRNsvn34ObJFHyY6NgJjq6kw9UqcrmvZFsPB/9gIXvuKHusUnOfNLEZu7x90clzu7Icg5h/fluYNZrX5//C94+dkBZr27RSg99Bh8uz89lm3GFKzT6PUnGNSDMP0MYc8R5Ndumq+DLoxB18d/Yf+45e87l5ZVRN7xuOM++jLOU6N8eX/P3usQlYEamNB20QcNN26jYCBtKgfYk+DY7qvjSOVMy94HvNcHdha/bYpyPo1k5HKZ4mfHotQH7uQqJF0VcR+5rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:57:38 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 15:57:38 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Documentation: add task lifecycle summary
Date: Thu, 27 Feb 2025 16:57:33 +0100
Message-ID: <20250227155733.292672-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::36) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bb9d70-9b88-42b7-f4e6-08dd57477544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uur9Rvem8W4s2tvVVxcODefVA/mfVvrZtyXKsgbfL0vgVv+GuFzVMugEl5mW?=
 =?us-ascii?Q?Vu/hWDcwiDWPRfG/HtzOV0U5Jb4xcfSgsbTRdQSYfG2N5MHQ0sVDy4EsA4JY?=
 =?us-ascii?Q?av/sBovTY2qYgpjroLQE0VMnkX9OOAdJ3oJghxUKKIpqsuGw8jHGxUBKXOFx?=
 =?us-ascii?Q?EKXi4juauHD8nCC/d5zcdfWUltUsRIJJQ3tPL08SmeIG+Zct7D0AvWI8THny?=
 =?us-ascii?Q?TtrHtnN8hvx0rs7IrLJLBqUSKCbWiUK41GYjNfFZxhlLZyBUPAW8Xb97Kgac?=
 =?us-ascii?Q?xUD2RksoYdppWDx2+Ieoe7jK+9ZXJyEcvrymkqYZDkGllQ2NA3Yunn1xhHyG?=
 =?us-ascii?Q?0nad2vJ1Wl5Ck+HbpTZOtfrS7IhySReaW9+yaUwlHs41HkJdSRE4VX7aosAU?=
 =?us-ascii?Q?DOfueXgfbX/ar2sRz9JpDiPQd+LvexDAvlgxBihsfue768iX79EbOWLrfjSO?=
 =?us-ascii?Q?ikb2tMrD4jTxGeDSLtWjzsWgnYD3Nc6Ml03zvFTBPIEsPZSJ2lZP26iBI+xe?=
 =?us-ascii?Q?WlLyqvgtey1LwfVPwaB4uWIiRbnoE3jaElb3Qx1ePn7MbnDRLbCGQogv9nEA?=
 =?us-ascii?Q?ta7u0+8dOjU39SHVbxyh5N7FsBkChRHAjQqJwhKt/tHGbCZ3Q3iYffuSZLpl?=
 =?us-ascii?Q?spzVFF4Lxpg0PNqYH3Qay0dC6YaZFLCpd5y8lNC6Z+xFbmEw3Wvh3/zhWcTB?=
 =?us-ascii?Q?aDDd2ERp/1EBoavRyy4PPSTIbt8S9nzU/FeQGFBdl+pSwwoKEKxv6xEN19gX?=
 =?us-ascii?Q?AKLFuLAcdHAEpVN0hR8BAcTinZ1u6jxVdjy8resDg0hN7p0MRXU3LAq608FB?=
 =?us-ascii?Q?q8MPOwN2STBeJ7fzk6k1ambtGmcm0a9UdZv2A7rrvF+XsR0At21Unpy1IkZh?=
 =?us-ascii?Q?nKe2wDjpTOolD9QEtFSAx0GdVhecPbG6a/KqvcsFwIBQSo59xdYh1fXJTT3W?=
 =?us-ascii?Q?wOh2o78Tfx/0eq6o/2KaMbeTkCy4s0mE2EBwJgTP9//YgqsPBGYjk7TKBaiu?=
 =?us-ascii?Q?h9b1X0053LxI/p+pmp2wJ0cIIIK2E3yMELLBpo3R0jGMnN77KyYpixdwHGHw?=
 =?us-ascii?Q?NTmE9B8Fywuv9h53D3waVx9u21R+385K6vM4bP7V/HFopzc8tQtUk9SzK175?=
 =?us-ascii?Q?M4dSdmfpiceDkAmrtdtkXB5qk1oByiy3UKYnUBdmQRmqSdIk7SeeYzj+SJMn?=
 =?us-ascii?Q?UHeN2HVbsiFrphASEwI3obDdqwTQQ2tcb5m13AzlaVdfsCy95qDkY3wqI/QO?=
 =?us-ascii?Q?IyAkC0RNJltHZVgMw4BYwunqv66N/j1qiVQpARCHv9N0QDxOsJYmfetcZ658?=
 =?us-ascii?Q?sUpDeDkUvHcqSEaVNuX8TAeoqQzy74JtyAclpl6vBUoue08mHiXJRIP4xGzZ?=
 =?us-ascii?Q?Kqcreiu5RxLJ0TLleQOSBsQIoXut?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2T19IeglfZM+q/KguDqV3sxgxAk0zny9ZvusFZf62HDZJ1+7fgjVJiL0Of4?=
 =?us-ascii?Q?B/NBRkH4en8UAt3bJTjdEg0b92y6ztIxLeJlsu4pC9SwzlCmI9psK927Jcvj?=
 =?us-ascii?Q?UiOsl7cBVKhnZpKLIYlJqWmSx2ZjX3i+Bvlo6XLnEKQy812oZmOf/+z3eogK?=
 =?us-ascii?Q?Aw/gC8oWJmuMUSscnmszDw/G0ce2dFE21AEBMrICptD2b1x/iQ3LhnFvWkbL?=
 =?us-ascii?Q?qXBDh231cOsmpvhppKd9UNt3KRZEVPp8zfZoU4QB76Cq1IBAOhZQa87dbpgs?=
 =?us-ascii?Q?H1FtkYEHDZQ6qFDKL/miHVZ/F4ryGzXRsiKZsufNEEMa6t9YfTf/aZKw7BX0?=
 =?us-ascii?Q?DwEta2Paf5qiNsGQOQa0K5bna0ceEwc1m72x8/mbdWC3y0x1yWks+CmcamtV?=
 =?us-ascii?Q?qcvCMWM5rNogVasCxoLjeZ2VrPDBh8w8JfEKh2QCT2rKba+gnYULUqt5FFLm?=
 =?us-ascii?Q?bXz8aBCjzJFSo/GDbDlvtvOIetY13chiccUmzrZ/vWNw4/iikQdHJCH5XTn3?=
 =?us-ascii?Q?9l+bec8CG243Y7GC7YJgNeunqgvJzoddp9o8vg9MnypZNY4a0kKETZ2AKxj+?=
 =?us-ascii?Q?nyjv2Nx9Hl9A3C+EGWsLWFvVwXWTV4ue/mEEqc2zywOYM6i8XNJkoKOQHFTu?=
 =?us-ascii?Q?xn0kONdgN5WnORB6U9cSfP/VVRiSzLnbEag/nMx0mztgie3byPSj9BF0GpYR?=
 =?us-ascii?Q?96m+222Uc9/fKLqJ00IJH3cK+B1Skv+B03UIGLl/0GnFCofD2uB+PxXkORrQ?=
 =?us-ascii?Q?gQrTDtamGVJujATNuWoGxCcuWz2nptxGGy82uXKCz+nJcqes0H8fIQtp4nc0?=
 =?us-ascii?Q?JBuhHAi0gYHZqxJomrRVJkH4MTzgvTnZTQHTJT7LzEiV1etPDyruE1ni8A6s?=
 =?us-ascii?Q?1o7PEuIKVp+oIcsPQLZvsRUX8gLXspVU+3JheCALzPsjAGXCsINsgAsMb7Du?=
 =?us-ascii?Q?IB4holSnhLbw+jrEE7rQa2O7pORl2GRwRWnmGxbVVjxzXaKzaX194FY1teoN?=
 =?us-ascii?Q?35CHoo1yWXod23J/Qu60JGnastz75+jS0Gqhwq2lGVGakhpFsNivJLiANbG1?=
 =?us-ascii?Q?KdHrmNYrrE+XLpQ3zkaSpsGwlvmmBjU/zjJ3eFa9khv8v77KoT+DKxnmWPEk?=
 =?us-ascii?Q?gFRsa8LS/LTqYJJrPL9cQRSkP9BGXTK7cJT/GEkQh4/3oXvnRTytzir7pJM0?=
 =?us-ascii?Q?p3EHlb3vW2aHVvvDWVOqV1oZj4CSdJen9bFDzRkm0bKFSvgbPZqQvKydl06h?=
 =?us-ascii?Q?PVSp/lXDa+bTQrf5i4KT6WMqB8Bu69tnPRPcPXozA1Y+EUcHe9tp/WxcOEbJ?=
 =?us-ascii?Q?ARN670MrAqsZfqD3hMT8BLODqzc+yOSjGVASgh25qPg4QaOy0uxpTdfjU2Vl?=
 =?us-ascii?Q?JLN/bBxf+6gvaaJ6dOXAyLJ9zKLseVo/aL6Agri2XhgVO8wHxUlUvC5W0DKT?=
 =?us-ascii?Q?LAELuDvUdN5a1Vini//syMsaLpl54xkJIUMcC4hDt7Jb/2ZYShyCXYnBtwPX?=
 =?us-ascii?Q?iX5ipWeXu07RHPslj8jcglOPfs0C7XjQXKC+SodgqFICLMqlcFprhXzgSpXg?=
 =?us-ascii?Q?h2uR5+nlT77z0L+wiRXHwioZ3QprPEt795L4/8NX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bb9d70-9b88-42b7-f4e6-08dd57477544
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:57:37.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN3DeABIYSt0jkRXx3qT3zK3WT+ktSFT6J2al4KKMcnCoJEeisCAOZNsG5aBTTavvO3pVNLmu0nN1ugD+ttRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074

Understanding the lifecycle of a task in sched_ext can be not trivial,
therefore add a section to the main documentation that summarizes the
entire workflow of a task using pseudo-code.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index c4672d7df2f73..0993e41353db7 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -294,6 +294,42 @@ dispatching, and must be dispatched to with ``scx_bpf_dsq_insert()``. See
 the function documentation and usage in ``tools/sched_ext/scx_simple.bpf.c``
 for more information.
 
+Task Lifecycle
+--------------
+
+The following pseudo-code summarizes the entire lifecycle of a task managed
+by a sched_ext scheduler:
+
+.. code-block:: c
+
+    ops.init_task();            /* A new task is created */
+    ops.enable();               /* Enable BPF scheduling for the task */
+
+    while (task in SCHED_EXT) {
+        if (task can migrate)
+            ops.select_cpu();   /* Called on wakeup (optimization) */
+
+        ops.runnable();         /* Task becomes ready to run */
+
+        while (task is runnable) {
+            if (task is not in a DSQ) {
+                ops.enqueue();  /* Task can be added to a DSQ */
+
+                /* A CPU becomes available */
+
+                ops.dispatch(); /* Task is moved to a local DSQ */
+            }
+            ops.running();      /* Task starts running on its assigned CPU */
+            ops.tick();         /* Called every 1/HZ seconds */
+            ops.stopping();     /* Task stops running (time slice expires or wait) */
+        }
+
+        ops.quiescent();        /* Task releases its assigned CPU (wait) */
+    }
+
+    ops.disable();              /* Disable BPF scheduling for the task */
+    ops.exit_task();            /* Task is destroyed */
+
 Where to Look
 =============
 
-- 
2.48.1


