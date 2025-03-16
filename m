Return-Path: <linux-kernel+bounces-562944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA1A63501
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BB3188F8FF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1D19D08F;
	Sun, 16 Mar 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rNetjpWV"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEF18C01D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742121060; cv=fail; b=jdh7Wqr7ADC1elucrgTwt94k6M3hJ7f5AXH5x4AZ60sqVDRvce5MM/16FK/nATaLSEorT4f2vDOEzvDRtvwK1m5//UJswJ71T8oyBi4HWDsm5BkqhYtu4QbEeuRWjmB2YnfD+apl/k4N8D3g6kcjyjGlJyikSP5knZt/Eyl4y4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742121060; c=relaxed/simple;
	bh=hAnmFazvNe+2DnMDnb/4TdczwV8unYTaSP1FOXIalQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkcpJPfTcxgiDS3XLLQf27oaIGwY4vAYPwyFiucdEdDAMSauC3KUU0fPFAHQNn8ORGZQnZlzf31j7gUJOkRo+qDf389XbBNJlMl4xNVkn9MT87TbInHMTKt8iCDyeMYyt5PW+vI0v1OM+sB4N5aDwgARi62B9NXWgXoIXkzX8cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rNetjpWV; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW8En3uT6AUZ6bZXARhNF8xfsqGu6xWp45To627zNRiNbDE91a2AbRfNuv0ttLimX0EPCft6XLyZtNKtUDBtGphccs1G5l719uEG9C/sUZbQ4QhtpFZL2OyOPs70BmdEtt9aHSAmDfis0eivnt0jdPQX43s1YgaNW9UH40xyr+69klXdbuUbdtCzNnlvZn3m99dT6E8OTn3sGEHkkD03YrGnevmv39bcoCuydOvofKY4jpazFr920c7bDLlJePnBuTM9OKe1ydokhAmV2A6Wyw4putbZiVU/zqEplv8cx2N7KJEq22qLCJFtgIwCRgBmUQwJ/oWukX187H3JQ3p+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=825r1eewD7znbgg+SajXrYUwPqfcJYPYMVsC07dwyRk=;
 b=EuoE6Hu9a5l1p3G77YhV1t6EhUBQ2YUnzXRseRxZCqCu+bbUQALFCCD4vAcpjdsL5WRJlZBDB51Bz8T0OqMlAxornSFfN14qi/v10nee770AFC8MpU9FXpi8O/IVMeX8O9qnTwB7ZU+CR6kMoZYXhF+KK8tijzAIQknwgD43QUjO0h/GKAKrYEihZp7UJUJmnXquRpzYKSRxBSxjF2ush2NX1XIqEK/sNTNUk1IzVwJatOzS0l2U++tm4vIeCHMjKX5nOiCZkRitq+GdQcq53JV8A9sczUMlLBdgKL90ONzciZnnPDN4w0cwZbtm/zvC1mHSzX14VusrAVSDi7HFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=825r1eewD7znbgg+SajXrYUwPqfcJYPYMVsC07dwyRk=;
 b=rNetjpWVsATXi95kJyD1wOKstmKdUNAJqLzSjPxrgzxdHTerjBJXjfIlK22S1OvZZAwKPgwE4zIKitNU1R8WqIiWwFuVjBKPOmbjOpCMxa7TxeRKRPd2BnMt8Ioxe3pG3u/WQQPTzVSiejwUoFAF7f7Z8foU/XxPRJ8fmV1DDHE=
Received: from BLAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:36e::29)
 by SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sun, 16 Mar
 2025 10:30:49 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::c8) by BLAPR05CA0017.outlook.office365.com
 (2603:10b6:208:36e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.27 via Frontend Transport; Sun,
 16 Mar 2025 10:30:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:30:48 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:30:43 -0500
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
Subject: [RFC PATCH 13/08] sched/fair: Invalidate stats once the load balancing instance is done
Date: Sun, 16 Mar 2025 10:29:14 +0000
Message-ID: <20250316102916.10614-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a4f76a-1f2c-4bac-f8b9-08dd64759e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vrM6Oc5b7+Eku6jcICRMqvBC6jyIyB0oW2Ij/6YPAOt4fXPQ/rcJDD7klKzt?=
 =?us-ascii?Q?e4bPgva+Qa1y7c6rmgcv4IyzdrWYhpXo7xu14rMgoVwH37pIt3fjetp92Prr?=
 =?us-ascii?Q?1nQUAho/IlGlA6Bj2/6GVy9pSrqJPEPw+9qs6+txMa2v0dFvvm5FP8TEvtxo?=
 =?us-ascii?Q?8HZU51faw9lGOEZMy5BCPvmJTzZJDdqTI4D+47ygEAbp7qzSn5WSlsE23h+d?=
 =?us-ascii?Q?gKVRlU26r6nJIMe8Fh4dLlkkvundLLJEGaL+f25gxtIYwkxYn6xTrPLV96nR?=
 =?us-ascii?Q?Z8NQ2aKWeDNkYW7S5DA7jfz1ZTISvucArlRy6SISRrGuVaaM+8kD6/IPn1qI?=
 =?us-ascii?Q?pqm0jxcm+un9rUJ+LUc8CJDoWex3YADc2+51mOwZL5asxj0UQGjsa0kASWis?=
 =?us-ascii?Q?kulz0JmwHxwLJr7ZTU9X4q/YP0oF50etP2NXIJhTteky2o34yspXNVtPFgJT?=
 =?us-ascii?Q?EYUS298+8PcMEocFxL+TBLs7caFu+QCUbH3+0aGM5CbaznFcZV4+VolCz6fb?=
 =?us-ascii?Q?SJIY2zY0sX6j40oEopHM+fKof58b+YF3KzhhYHg4ztjcC9o+t3BheecezeND?=
 =?us-ascii?Q?+2d8i0bo/Q2yLtjnn721gCGbDioy74HCP8xexBwbDjH/7hjkhdz9TiXNSofm?=
 =?us-ascii?Q?+ermb7oV8xl98oOsNCt3yWbKmkt9582dUEO+tahsX/IrpUixIyRetJ8X8E8j?=
 =?us-ascii?Q?kZUdLuOrEix5N1agFqN6X8a7rQBIq//rbBXflAqruI8+JA/44w0nI1+9em1/?=
 =?us-ascii?Q?VdERAAL3Jml//hqXLe88Y8gopOg/Jwz3s15CBq1KHCzWaDUle12mAt0eVTt2?=
 =?us-ascii?Q?qOQ9anycX0Vx5Ynfl+3pyMFGWmDcoKe6+MMJg8d28iyNW3tBad8IE8tD2DUQ?=
 =?us-ascii?Q?UkkR3o8yzgA3MIEeumHcjXHj3G2pkdxwBTVmP1xmhmOJo5kFrsBlileReXNx?=
 =?us-ascii?Q?etwkUyuhUtbRMKPCeFAtyvRpeNFxlyrsQb3614qKC+uQopIbNVfmzEydK1kY?=
 =?us-ascii?Q?MEy1dX1Qcpvbl1Y1UV0CVBiap15rgLwKLKST8EamoA+vf0NdJJht6f6uK3xu?=
 =?us-ascii?Q?8u7T+itPMpWVr4exyVS/ocwj/SuzfKIRVvWlRX4XN9D1TmAlnSOry0A4RD+q?=
 =?us-ascii?Q?JP2+oI7CsnC46wKuskb4/jXrMsy1xntPqe5yCNH2Nh8sSZY+h3OPBZii8Zo6?=
 =?us-ascii?Q?uq6cwQzGIlWHI8iKF8XGI9k1AEFpLFGnKY/k5uJwTEt3IHOr5rZMjlWZ7e6P?=
 =?us-ascii?Q?ODeuw9imw3mC6SsG9b0RP5bX3EREb/JiAsfhqpbAyvC4bDW4rH1Rtjm/ZfRF?=
 =?us-ascii?Q?Db+7onPIiM7kd78Gse/W+qC4pVRHpaiNDKhRQ5NudfTnLGcjmvE0BRqLGpNZ?=
 =?us-ascii?Q?Fifs9Ct3qxMSawrkM0I6MoaOVMelHgA6nybQ53Ik9QzjkyzzLoIih+ExR030?=
 =?us-ascii?Q?nZ75w0QWWiGykFfzSQSecYzBlWfcDbetAsOlRx2djJe9Vphrx7dscDmjhDrF?=
 =?us-ascii?Q?Hz2xteNRIB8GgL0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:30:48.4101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a4f76a-1f2c-4bac-f8b9-08dd64759e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904

The CPU doing the load balancing propagates the stats bottom-up, reusing
them as it traverses up the hierarchy. Once done, or if a decision is
taken to migrate the tasks that affect the stats, the old version needs
to be invalidated for a newer CPU with a recent view to recompute and
cache it.

Invalidate the old version once load balancing instance is done. Rudely
take over the stats if another CPU sees that cached stats are older than
50us.

This allows idle and newidle balance to propagate at the very least its
local stats up the hierarchy.

  ==================================================================
  Test          : hackbench
  Units         : Normalized time in seconds
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  Case:           tip[pct imp](CV)      versioning[pct imp](CV)
   1-groups     1.00 [ -0.00](10.12)     1.00 [  0.44](13.86)
   2-groups     1.00 [ -0.00]( 6.92)     1.04 [ -4.32]( 3.00)
   4-groups     1.00 [ -0.00]( 3.14)     1.00 [ -0.21]( 2.16)
   8-groups     1.00 [ -0.00]( 1.35)     1.01 [ -1.25]( 1.32)
  16-groups     1.00 [ -0.00]( 1.32)     1.01 [ -0.50]( 2.00)

  ==================================================================
  Test          : tbench
  Units         : Normalized throughput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:    tip[pct imp](CV)      versioning[pct imp](CV)
      1     1.00 [  0.00]( 0.43)     0.98 [ -1.65]( 0.15)
      2     1.00 [  0.00]( 0.58)     1.01 [  1.27]( 0.49)
      4     1.00 [  0.00]( 0.54)     1.00 [  0.47]( 0.40)
      8     1.00 [  0.00]( 0.49)     1.00 [ -0.44]( 1.18)
     16     1.00 [  0.00]( 1.06)     1.00 [ -0.07]( 1.14)
     32     1.00 [  0.00]( 1.27)     1.00 [  0.02]( 0.11)
     64     1.00 [  0.00]( 1.54)     0.99 [ -1.12]( 1.09)
    128     1.00 [  0.00]( 0.38)     0.98 [ -2.43]( 1.00)
    256     1.00 [  0.00]( 1.85)     0.99 [ -0.50]( 0.94)
    512     1.00 [  0.00]( 0.31)     0.99 [ -1.03]( 0.35)
   1024     1.00 [  0.00]( 0.19)     0.99 [ -0.56]( 0.42)

  ==================================================================
  Test          : stream-10
  Units         : Normalized Bandwidth, MB/s
  Interpretation: Higher is better
  Statistic     : HMean
  ==================================================================
  Test:       tip[pct imp](CV)      versioning[pct imp](CV)
   Copy     1.00 [  0.00](11.31)     1.08 [  7.51]( 4.74)
  Scale     1.00 [  0.00]( 6.62)     1.00 [ -0.31]( 7.45)
    Add     1.00 [  0.00]( 7.06)     1.02 [  2.50]( 7.34)
  Triad     1.00 [  0.00]( 8.91)     1.08 [  7.78]( 2.88)

  ==================================================================
  Test          : stream-100
  Units         : Normalized Bandwidth, MB/s
  Interpretation: Higher is better
  Statistic     : HMean
  ==================================================================
  Test:       tip[pct imp](CV)     versioning[pct imp](CV)
   Copy     1.00 [  0.00]( 2.01)     1.02 [  1.82]( 1.26)
  Scale     1.00 [  0.00]( 1.49)     1.00 [  0.26]( 0.80)
    Add     1.00 [  0.00]( 2.67)     1.01 [  0.98]( 1.29)
  Triad     1.00 [  0.00]( 2.19)     1.02 [  2.06]( 1.01)

  ==================================================================
  Test          : netperf
  Units         : Normalized Througput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:         tip[pct imp](CV)      versioning[pct imp](CV)
   1-clients     1.00 [  0.00]( 1.43)     0.99 [ -0.72]( 0.81)
   2-clients     1.00 [  0.00]( 1.02)     1.00 [ -0.09]( 1.11)
   4-clients     1.00 [  0.00]( 0.83)     1.00 [  0.31]( 0.29)
   8-clients     1.00 [  0.00]( 0.73)     1.00 [ -0.25]( 0.61)
  16-clients     1.00 [  0.00]( 0.97)     1.00 [ -0.26]( 0.89)
  32-clients     1.00 [  0.00]( 0.88)     0.99 [ -0.61]( 0.82)
  64-clients     1.00 [  0.00]( 1.49)     0.99 [ -1.11]( 1.77)
  128-clients    1.00 [  0.00]( 1.05)     1.00 [ -0.03]( 1.13)
  256-clients    1.00 [  0.00]( 3.85)     1.00 [ -0.24]( 2.63)
  512-clients    1.00 [  0.00](59.63)     0.99 [ -0.74](59.01)

  ==================================================================
  Test          : schbench
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:     tip[pct imp](CV)     versioning[pct imp](CV)
    1         1.00 [ -0.00]( 6.67)     0.93 [  6.67](15.25)
    2         1.00 [ -0.00](10.18)     0.83 [ 17.39]( 7.15)
    4         1.00 [ -0.00]( 4.49)     1.04 [ -4.26]( 6.12)
    8         1.00 [ -0.00]( 6.68)     1.06 [ -5.66](12.98)
   16         1.00 [ -0.00]( 1.87)     1.00 [ -0.00]( 3.38)
   32         1.00 [ -0.00]( 4.01)     0.98 [  2.20]( 4.79)
   64         1.00 [ -0.00]( 3.21)     1.02 [ -1.68]( 0.84)
  128         1.00 [ -0.00](44.13)     1.16 [-15.98](14.99)
  256         1.00 [ -0.00](14.46)     0.90 [  9.99](17.45)
  512         1.00 [ -0.00]( 1.95)     0.98 [  1.54]( 1.13)

  ==================================================================
  Test          : new-schbench-requests-per-second
  Units         : Normalized Requests per second
  Interpretation: Higher is better
  Statistic     : Median
  ==================================================================
  #workers:    tip[pct imp](CV)      versioning[pct imp](CV)
    1        1.00 [  0.00]( 0.46)     1.00 [  0.00]( 0.26)
    2        1.00 [  0.00]( 0.15)     1.00 [ -0.29]( 0.15)
    4        1.00 [  0.00]( 0.15)     1.00 [ -0.29]( 0.30)
    8        1.00 [  0.00]( 0.15)     1.00 [ -0.29]( 0.26)
   16        1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
   32        1.00 [  0.00]( 3.40)     1.06 [  5.93]( 1.22)
   64        1.00 [  0.00]( 7.09)     1.00 [  0.00]( 0.20)
  128        1.00 [  0.00]( 0.00)     0.98 [ -1.52]( 0.34)
  256        1.00 [  0.00]( 1.12)     0.98 [ -2.41]( 1.19)
  512        1.00 [  0.00]( 0.22)     1.00 [  0.00]( 0.43)

  ==================================================================
  Test          : new-schbench-wakeup-latency
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:    tip[pct imp](CV)      versioning[pct imp](CV)
    1        1.00 [ -0.00](19.72)     1.00 [ -0.00]( 8.37)
    2        1.00 [ -0.00](15.96)     1.09 [ -9.09](11.08)
    4        1.00 [ -0.00]( 3.87)     1.15 [-15.38](17.44)
    8        1.00 [ -0.00]( 8.15)     0.92 [  8.33]( 8.85)
   16        1.00 [ -0.00]( 3.87)     1.23 [-23.08]( 5.59)
   32        1.00 [ -0.00](12.99)     0.73 [ 26.67](16.75)
   64        1.00 [ -0.00]( 6.20)     1.25 [-25.00]( 2.63)
  128        1.00 [ -0.00]( 0.96)     1.62 [-62.37]( 1.30)
  256        1.00 [ -0.00]( 2.76)     0.82 [ 17.89](10.56)
  512        1.00 [ -0.00]( 0.20)     1.00 [ -0.00]( 0.34)

  ==================================================================
  Test          : new-schbench-request-latency
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:    tip[pct imp](CV)      versioning[pct imp](CV)
    1        1.00 [ -0.00]( 1.07)     1.02 [ -2.34]( 0.13)
    2        1.00 [ -0.00]( 0.14)     1.04 [ -3.97]( 0.13)
    4        1.00 [ -0.00]( 1.39)     1.03 [ -3.15]( 0.13)
    8        1.00 [ -0.00]( 0.36)     1.03 [ -3.43]( 0.66)
   16        1.00 [ -0.00]( 1.18)     0.99 [  0.79]( 1.22)
   32        1.00 [ -0.00]( 8.42)     0.82 [ 18.29]( 9.02)
   64        1.00 [ -0.00]( 4.85)     1.00 [ -0.44]( 1.61)
  128        1.00 [ -0.00]( 0.28)     1.06 [ -5.64]( 1.10)
  256        1.00 [ -0.00](10.52)     0.81 [ 19.18](12.55)
  512        1.00 [ -0.00]( 0.69)     1.00 [  0.33]( 1.27)

  ==================================================================
  Test          : Various longer running benchmarks
  Units         : %diff in throughput reported
  Interpretation: Higher is better
  Statistic     : Median
  ==================================================================
  Benchmarks:                 %diff

  ycsb-cassandra             -0.76%
  ycsb-mongodb                0.49%

  deathstarbench-1x          -2.37%
  deathstarbench-2x           0.12%
  deathstarbench-3x           2.30%
  deathstarbench-6x           1.88%

  hammerdb+mysql 16VU         3.85%
  hammerdb+mysql 64VU         0.27%

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 92 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2a34d73d824b..31501b933d45 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10341,17 +10341,6 @@ static inline void cache_sd_stats(struct lb_env *env, struct sg_lb_stats *sd_sta
 
 static inline int can_retrieve_stats(struct sched_domain *sd, enum cpu_idle_type idle)
 {
-	/*
-	 * Only under perioric load balancing can we ensure that no concurrent
-	 * CPUs modifies the stats being propagated upwards since
-	 * should_we_balance() can allow multiple concurrent newidle balance
-	 * to progress and an idle -> busy transition for idle balance will
-	 * require the stats to be recomputed since idleness metrics will
-	 * change with migration.
-	 */
-	if (idle)
-		return 0;
-
 	/*
 	 * If individual groups are separate NUMA domains, migrations can cause
 	 * preferred task statistics to change and will require recomputing of
@@ -10422,8 +10411,6 @@ static inline void aggregate_sd_stats(struct lb_env *env,
 	sd_stats->sum_h_nr_running += sg_stats->sum_h_nr_running;
 	sd_stats->sum_nr_running += sg_stats->sum_nr_running;
 	sd_stats->idle_cpus += sg_stats->idle_cpus;
-	sd_stats->group_capacity += sg_stats->group_capacity;
-	sd_stats->group_weight += sg_stats->group_weight;
 	sd_stats->overloaded |= sg_stats->overloaded;
 	sd_stats->overutilized |= sg_stats->overutilized;
 
@@ -10431,6 +10418,52 @@ static inline void aggregate_sd_stats(struct lb_env *env,
 	sd_stats->nr_numa_running += sg_stats->nr_numa_running;
 	sd_stats->nr_preferred_running += sg_stats->nr_preferred_running;
 #endif
+
+	if (env->idle &&
+	    sg_stats->group_misfit_task_load > sd_stats->group_misfit_task_load)
+		sd_stats->group_misfit_task_load = sg_stats->group_misfit_task_load;
+}
+
+static inline void __invalidate_stats(struct sched_domain *sd)
+{
+	struct sched_domain_shared *sd_share = sd->shared;
+	struct sg_lb_stats_prop *lb_prop;
+	long version;
+
+	if (!sd_share)
+		return;
+
+	lb_prop = (struct sg_lb_stats_prop *)sd_share->private;
+	if (!lb_prop)
+		return;
+
+	/*
+	 * The acquire ordering pairs against the writer updating the
+	 * "update_cpu" before setting a valid version.
+	 */
+	version = atomic_long_read_acquire(&lb_prop->version);
+	if (version <= 0) /* Stats are invalidated / being updated. */
+		return;
+
+	guard(irqsave)();
+
+	/*
+	 * Stats were not updated by this CPU. Leave it to the
+	 * update_cpu to clean it up.
+	 */
+	if (lb_prop->update_cpu != smp_processor_id())
+		return;
+
+	/* Invalidate the stats. */
+	atomic_long_cmpxchg_release(&lb_prop->version, version, 0);
+}
+
+static inline void invalidate_below(struct sched_domain *sd)
+{
+	struct sched_domain *child;
+
+	for (child = sd->child; child; child = child->child)
+		__invalidate_stats(child);
 }
 
 /**
@@ -10495,8 +10528,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->nr_numa_running += rq->nr_numa_running;
 		sgs->nr_preferred_running += rq->nr_preferred_running;
 #endif
-		if (local_group)
-			continue;
 
 		if (sd_flags & SD_ASYM_CPUCAPACITY) {
 			/* Check for a misfit task on the cpu */
@@ -10511,10 +10542,13 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		}
 	}
 
+group_classify:
 	sgs->group_capacity = group->sgc->capacity;
-
 	sgs->group_weight = group->group_weight;
 
+	if (local_group || !env->idle)
+		sgs->group_misfit_task_load = 0;
+
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->idle && sgs->sum_h_nr_running &&
 	    sched_group_asym(env, sgs, group))
@@ -10524,7 +10558,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	if (!local_group && smt_balance(env, sgs, group))
 		sgs->group_smt_balance = 1;
 
-group_classify:
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
@@ -11167,9 +11200,10 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		}
 
 		/* Now, start updating sd_lb_stats */
+		sds->total_capacity += sgs->group_capacity;
+
 		if (!should_prop) {
 			sds->total_load += sgs->group_load;
-			sds->total_capacity += sgs->group_capacity;
 			sg_overloaded |= sgs->overloaded;
 			sg_overutilized |= sgs->overutilized;
 			sum_util += sgs->group_util;
@@ -11180,7 +11214,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (should_prop) {
 		sds->total_load = sd_stats.group_load;
-		sds->total_capacity = sd_stats.group_capacity;
 		sg_overloaded = sd_stats.overloaded;
 		sg_overutilized = sd_stats.overutilized;
 		sum_util = sd_stats.group_util;
@@ -11947,6 +11980,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 
 		if (cur_ld_moved) {
 			attach_tasks(&env);
+			/*
+			 * If tasks have moved to an idle CPU, the idleness
+			 * metrics have changed. Invalidate stats for the
+			 * next instance to compute them afresh.
+			 */
+			if (env.idle)
+				__invalidate_stats(env.sd);
 			ld_moved += cur_ld_moved;
 		}
 
@@ -12308,12 +12348,12 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 	int continue_balancing = 1;
 	int cpu = rq->cpu;
 	int busy = idle != CPU_IDLE && !sched_idle_cpu(cpu);
+	int need_serialize, need_decay = 0, invalidate = 1;
 	unsigned long interval, prev_sd_next_balance = 0;
 	struct sched_domain *sd;
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
 	u64 max_cost = 0;
 
 	rcu_read_lock();
@@ -12333,6 +12373,11 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 		 * actively.
 		 */
 		if (!continue_balancing) {
+			if (invalidate)  {
+				invalidate_below(sd);
+				invalidate = 0;
+			}
+
 			if (need_decay)
 				continue;
 			break;
@@ -12369,6 +12414,9 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
 			next_balance = sd->last_balance + interval;
 			update_next_balance = 1;
 		}
+
+		if (!sd->parent)
+			invalidate_below(sd);
 	}
 	if (need_decay) {
 		/*
@@ -12987,8 +13035,10 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || !continue_balancing)
+		if (pulled_task || !continue_balancing || !sd->parent) {
+			invalidate_below(sd);
 			break;
+		}
 	}
 	rcu_read_unlock();
 
-- 
2.43.0


