Return-Path: <linux-kernel+bounces-559125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17800A5EFC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D0717D9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22B1FC3;
	Thu, 13 Mar 2025 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5omgTrrB"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C15263C8A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858837; cv=fail; b=XYSLHE1CZ28QKTDQbyvZBrIk8vKwmtuJE/2ncrzPekr0xN7oH2R7IEnj2MnrSLaywT0kIR3evyKN2In6AHtXeZ/Wr2u3fqEbEpwZsT7RPktV8k+Sqyxb1zqeylFvyBVHfJr7N9LG0IpAAEWU42Y2H+Lf6rTTPX6Tl5NEolRPLV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858837; c=relaxed/simple;
	bh=ywuBgz505gv67Lr/Rj+8b6AlhISifiJ+qhKfoBYa4VM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/XPXZi/HoL+5Lq4Q2BLZbrDeEySFeq8aqTJQH2Ijc/ZXHr35ltPidnfBAohe92gVA/AosUO+MYhDxV1hrYqhdYc19KaNf69jVWVlZDCNFSj+fuzqtXdFHyjRfy+iwdSN+OByU1N1i10D1xHx8vx0fEQFwM2JqU2895/v7SsICs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5omgTrrB; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8hrvMqrRDl4ZAVcKVZITSfgXOu8DaGdG+Fz/GoPDZyZ8vBek1V0u0uXF4J3FNnPkwUED7UomZJ2VoAQWpWbb9gbO/vmorW7sof2sCzJlDySTIup1L/ikYZYQH5ClZT8zk5jPxRaJzJKUzp9C8YNVSjUZUYLipfTOT+MMChxMs4DpAvX2A8OfE7wRGjGigy2ODHshJAqp0vMSf5biW3h/uR6DTxp9SiHJcOWXaikI3OmKAGi9TEnw22K8RMt2oOKFNSWyOkhBgUsByUoep43kxOPsqDtfazAiaOVJ2mL++66Rhz2misnI591jATH9EyMqsOvHDSJIk3ZT4xe1Iwj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twTnnaVI2hCo6fVQINPkV6z5gtBgDtebuMwOQd8tPLA=;
 b=i62lSYy1mzCgPhiLjq3LBwwe6eq6JuYfSYtI8U2PcHIrUzhG1+5r07ZIE/Ix48H8SybBl7kqFt3irM/w0t+vkEMoSQSFMvmiGPjmsom/9mtvNdVEkQ3UONcP3XOoObLFc+QaQJQtGsa/w2ouc2QXcGproK8SjkxbCESbdaYT+djGqRC5/bZsbc8rVrUDOKastcOVYfZqR99Da6ZX3vjknjPCPTlHkUpxzr9InAjNvNzUp0aXOssO7P8Neu6NqWndeMnrTRZUQ8L/KpZYU6YBX+J3AKohutxDYj0rVs/AR7a7fV5Mss+ZZRoRs8b0l2Aqp7d3npHS83audC4Wzoh6MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twTnnaVI2hCo6fVQINPkV6z5gtBgDtebuMwOQd8tPLA=;
 b=5omgTrrB5XfwV/YNq2w0vhE+41FTnqX/cwzLiK/KK3VOm7sQj6OPM8t8biaG4vh3vNhYQtyB47ukx97Xf/PcWxN4Z0AaOhIAHI0rxHWGR84mdZDNLA+5v+MH48OkDZtc0zv6n9rsayfuSpwftZZaJqmaw4sfThxyA84JE0RGvK0=
Received: from PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::3c)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:40:30 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132F7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.24 via Frontend Transport; Thu,
 13 Mar 2025 09:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:40:29 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:40:23 -0500
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
Subject: [RFC PATCH 8/8] sched/fair: Update stats for sched_domain using the sched_group stats
Date: Thu, 13 Mar 2025 09:37:46 +0000
Message-ID: <20250313093746.6760-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 103b308e-a23a-4442-ce4d-08dd621317a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FU6Rv/zvcxU+ivk5e9Jd3cNjBPBnHkqYJhZWF+CqCnwdWQb8Mx48I9s8GLYM?=
 =?us-ascii?Q?dPcctaxnBjeCNNWgg9DUMxFMkPeNvp5Wau6zsvrQqeePvBEXYlL1HNvjEVbU?=
 =?us-ascii?Q?ZIzWDLED7K0HQGxJPtCOEJ7KjHKmxZfLY8YlB9K3uI7H33JcUcBL3nr0ViOn?=
 =?us-ascii?Q?Wx2WNMXkXXwc4nImEaCvB+t4NDM8V28jh6+L2iMTDsQJbITjhY+CwA1teOkb?=
 =?us-ascii?Q?Ucxu1ZgJp5QGNBCN4T+Fmk1Ly7Hh6zbjburY6ZPVwyWLRBP1HDyhMr2jQgQX?=
 =?us-ascii?Q?riFJOxTHrUnOu3rGCx+5/5xrDDX2wI42BAeFIwIvtZrjq3vGFz4Uya4cHaQx?=
 =?us-ascii?Q?p9r/vpNKc8uo5R+Dj8mbWmEes6tRdQB9B9I0Cc5iEVvp5X5YmjWAd9hVOb+D?=
 =?us-ascii?Q?VNYqBkUmNa96Ix8156NBM48M7PH5yJGvX0SfxWNn/bRmlXqVsLHEROd5XKqD?=
 =?us-ascii?Q?nnSQySsOhwcQrcJVY9VAt6BRWUfWNudJBf/ej4V2Nbp2pZavFVYz358RF7pp?=
 =?us-ascii?Q?2+bD81m5o9FK6/7ZMku0sDmTt7kjVJEMbjuJMvnwSXMXlB3G+fgcpFHbFr8J?=
 =?us-ascii?Q?g8sUa6Wt4b+/z9HFJJ6nKINwfmfXspGOcSV1BiZ/GPtAQfSQ9Pg00q1ekB4o?=
 =?us-ascii?Q?cznf5Lvjx5HkAK0YACSvHwoIIAJ8YfN155B6XtEz28zliKs9gK3q1969Eevl?=
 =?us-ascii?Q?xPGSiYMREKOVm+kpwPV8d/XY6ypR7Q3xIxwZvr9dwlWQm4fAZcNINihq5MHw?=
 =?us-ascii?Q?xj4nOtQmPjomsZolsIFVUh+GDb7SSr/e4VE8Ip33cIirAMdeC4nUFhYc6sGq?=
 =?us-ascii?Q?dWd4EhyKmLevGZhjf5mt5iBF78TIMJN2EOCYQupWUBIowNXPWWeVe0NasdCY?=
 =?us-ascii?Q?aS7DmSShMQ2wg4YLCKCuh2Kbh08JE6VNCpdrm+l7MKb6YcKSZYhY9UJ257ST?=
 =?us-ascii?Q?VrnsNaw20JKhxeP8YUbvRLmob6tzNuOaucnUsaKPmR1zkMbh74RM0jXVqeTU?=
 =?us-ascii?Q?/0dttq6ESzzR5UqS9nUZa0M1Xricm41hGeWfcF+g5o6DNfl3Qqk/0lH+bJIB?=
 =?us-ascii?Q?MYXAa9g1KQjyII6xybZRPCG0Wj2ze5b8czWDFFxoEhhQZER2lnOOp5q+PLNG?=
 =?us-ascii?Q?1ywpiNivWocj9TQNdZjbgvvqCjoXd4iQcnISU6eJP/hcK4kSQLD6IHI+/sqM?=
 =?us-ascii?Q?Y/uFjKpqHGTv8vtUfIrMHKPHB5Zc1HJI7SAplM/e9RYIMYYSFPhe5DNK1GPV?=
 =?us-ascii?Q?QWeqYDkzZSmCwXXaTkZ0wpxn2Reoz6ZTlNiShp7GJqQx0ZlOTEWg2G29CJrh?=
 =?us-ascii?Q?HuQTH9ZJdU+dZKFGcuil95NgQ0XpM6+hK+Qh+JYyq2O786ts32PE74b6WkoY?=
 =?us-ascii?Q?ziB5ZI8zMq8OBrtB9VSlHZOhL2Jvmf8mamFuC7By+VjtR8+0Pvv8hHErbDP8?=
 =?us-ascii?Q?yP1+QuljetTDJlSM2AK/xDetAtKY2l6I/RtsT65CRZASwh6uFFYAcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:40:29.5362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103b308e-a23a-4442-ce4d-08dd621317a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669

Aggregate the individual sched_group stats to compute the stat for the
entire sched_domain. Cache this in sd->shared which the sg->shared also
points to for the corresponding sched_group of sd for its parent. This
ensures that the stats are readily available for the higher domains if
the load balancing continues.

With the new infrastructure in place, following are the benchmark
numbers:

  ==================================================================
  Test          : hackbench
  Units         : Normalized time in seconds
  Interpretation: Lower is better
  Statistic     : AMean
  ==================================================================
  Case:           tip[pct imp](CV)      stats_prop[pct imp](CV)
   1-groups     1.00 [ -0.00](10.12)     1.09 [ -9.11](11.93)
   2-groups     1.00 [ -0.00]( 6.92)     1.00 [ -0.22]( 4.57)
   4-groups     1.00 [ -0.00]( 3.14)     0.99 [  0.83]( 1.77)
   8-groups     1.00 [ -0.00]( 1.35)     1.00 [ -0.31]( 2.24)
  16-groups     1.00 [ -0.00]( 1.32)     0.99 [  0.84]( 0.67)

  ==================================================================
  Test          : tbench
  Units         : Normalized throughput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
  Clients:    tip[pct imp](CV)      stats_prop[pct imp](CV)
      1     1.00 [  0.00]( 0.43)     0.99 [ -0.87]( 1.34)
      2     1.00 [  0.00]( 0.58)     1.02 [  2.14]( 0.29)
      4     1.00 [  0.00]( 0.54)     1.01 [  1.24]( 0.82)
      8     1.00 [  0.00]( 0.49)     1.01 [  0.62]( 0.97)
     16     1.00 [  0.00]( 1.06)     1.01 [  0.94]( 0.70)
     32     1.00 [  0.00]( 1.27)     0.99 [ -1.24]( 1.38)
     64     1.00 [  0.00]( 1.54)     1.00 [ -0.43]( 0.36)
    128     1.00 [  0.00]( 0.38)     1.00 [ -0.01]( 1.22)
    256     1.00 [  0.00]( 1.85)     1.02 [  1.58]( 0.90)
    512     1.00 [  0.00]( 0.31)     1.01 [  0.76]( 1.19)
   1024     1.00 [  0.00]( 0.19)     1.00 [  0.44]( 0.35)

  ==================================================================
  Test          : stream-10
  Units         : Normalized Bandwidth, MB/s
  Interpretation: Higher is better
  Statistic     : HMean
  ==================================================================
  Test:       tip[pct imp](CV)      stats_prop[pct imp](CV)
   Copy     1.00 [  0.00](11.31)     1.02 [  1.69]( 6.44)
  Scale     1.00 [  0.00]( 6.62)     1.01 [  0.80]( 5.37)
    Add     1.00 [  0.00]( 7.06)     1.02 [  1.54]( 6.72)
  Triad     1.00 [  0.00]( 8.91)     1.01 [  1.36]( 6.73)

  ==================================================================
  Test          : stream-100
  Units         : Normalized Bandwidth, MB/s
  Interpretation: Higher is better
  Statistic     : HMean
  ==================================================================
  Test:       tip[pct imp](CV)      stats_prop[pct imp](CV)
   Copy     1.00 [  0.00]( 2.01)     0.98 [ -1.55]( 2.15)
  Scale     1.00 [  0.00]( 1.49)     1.00 [  0.23]( 0.58)
    Add     1.00 [  0.00]( 2.67)     1.01 [  0.65]( 1.95)
  Triad     1.00 [  0.00]( 2.19)     1.01 [  0.61]( 1.37)

  ==================================================================
  Test          : netperf
  Units         : Normalized Througput
  Interpretation: Higher is better
  Statistic     : AMean
  ==================================================================
     Clients:       tip[pct imp](CV)      stats_prop[pct imp](CV)
    1-clients     1.00 [  0.00]( 1.43)     1.00 [  0.17]( 0.32)
    2-clients     1.00 [  0.00]( 1.02)     1.01 [  1.00]( 0.44)
    4-clients     1.00 [  0.00]( 0.83)     1.01 [  0.62]( 0.36)
    8-clients     1.00 [  0.00]( 0.73)     1.00 [ -0.11]( 0.65)
   16-clients     1.00 [  0.00]( 0.97)     1.00 [  0.49]( 0.77)
   32-clients     1.00 [  0.00]( 0.88)     1.00 [  0.30]( 0.94)
   64-clients     1.00 [  0.00]( 1.49)     1.00 [  0.36]( 1.57)
  128-clients     1.00 [  0.00]( 1.05)     1.00 [  0.14]( 1.46)
  256-clients     1.00 [  0.00]( 3.85)     1.00 [ -0.04]( 4.85)
  512-clients     1.00 [  0.00](59.63)     1.00 [ -0.02](62.28)

  ==================================================================
  Test          : schbench
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:     tip[pct imp](CV)      stats_prop[pct imp](CV)
    1         1.00 [ -0.00]( 6.67)     0.76 [ 24.44](35.80)
    2         1.00 [ -0.00](10.18)     0.87 [ 13.04](10.38)
    4         1.00 [ -0.00]( 4.49)     1.04 [ -4.26]( 3.14)
    8         1.00 [ -0.00]( 6.68)     0.98 [  1.89]( 8.07)
   16         1.00 [ -0.00]( 1.87)     1.03 [ -3.28]( 5.21)
   32         1.00 [ -0.00]( 4.01)     0.98 [  2.20]( 1.31)
   64         1.00 [ -0.00]( 3.21)     1.00 [ -0.00]( 3.23)
  128         1.00 [ -0.00](44.13)     1.06 [ -6.43](113.66)
  256         1.00 [ -0.00](14.46)     1.04 [ -3.52]( 8.43)
  512         1.00 [ -0.00]( 1.95)     1.02 [ -1.80]( 1.14)

  ==================================================================
  Test          : new-schbench-requests-per-second
  Units         : Normalized Requests per second
  Interpretation: Higher is better
  Statistic     : Median
  ==================================================================
  #workers:      tip[pct imp](CV)      stats_prop[pct imp](CV)
    1          1.00 [  0.00]( 0.46)     1.00 [  0.00]( 0.55)
    2          1.00 [  0.00]( 0.15)     0.99 [ -0.88]( 0.26)
    4          1.00 [  0.00]( 0.15)     0.99 [ -0.59]( 0.15)
    8          1.00 [  0.00]( 0.15)     0.99 [ -0.88]( 0.26)
   16          1.00 [  0.00]( 0.00)     1.00 [ -0.29]( 0.15)
   32          1.00 [  0.00]( 3.40)     1.07 [  6.59]( 0.16)
   64          1.00 [  0.00]( 7.09)     1.00 [ -0.38]( 0.96)
  128          1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.20)
  256          1.00 [  0.00]( 1.12)     1.00 [ -0.30]( 1.50)
  512          1.00 [  0.00]( 0.22)     1.05 [  4.86]( 0.71)

  ==================================================================
  Test          : new-schbench-wakeup-latency
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:     tip[pct imp](CV)      stats_prop[pct imp](CV)
    1         1.00 [ -0.00](19.72)     0.85 [ 15.38](16.75)
    2         1.00 [ -0.00](15.96)     1.00 [ -0.00]( 0.00)
    4         1.00 [ -0.00]( 3.87)     1.00 [ -0.00]( 4.08)
    8         1.00 [ -0.00]( 8.15)     1.00 [ -0.00](11.71)
   16         1.00 [ -0.00]( 3.87)     0.92 [  7.69]( 4.19)
   32         1.00 [ -0.00](12.99)     0.73 [ 26.67]( 0.00)
   64         1.00 [ -0.00]( 6.20)     1.12 [-12.50]( 9.94)
  128         1.00 [ -0.00]( 0.96)     0.98 [  1.55]( 0.95)
  256         1.00 [ -0.00]( 2.76)     0.99 [  1.45]( 1.38)
  512         1.00 [ -0.00]( 0.20)     1.20 [-20.42]( 0.00)

  ==================================================================
  Test          : new-schbench-request-latency
  Units         : Normalized 99th percentile latency in us
  Interpretation: Lower is better
  Statistic     : Median
  ==================================================================
  #workers:     tip[pct imp](CV)      stats_prop[pct imp](CV)
    1         1.00 [ -0.00]( 1.07)     1.02 [ -2.08]( 0.13)
    2         1.00 [ -0.00]( 0.14)     1.04 [ -3.97]( 0.13)
    4         1.00 [ -0.00]( 1.39)     1.03 [ -3.15]( 0.13)
    8         1.00 [ -0.00]( 0.36)     1.03 [ -3.16]( 0.00)
   16         1.00 [ -0.00]( 1.18)     1.02 [ -1.59]( 0.75)
   32         1.00 [ -0.00]( 8.42)     0.81 [ 19.08]( 0.25)
   64         1.00 [ -0.00]( 4.85)     1.01 [ -1.10]( 2.58)
  128         1.00 [ -0.00]( 0.28)     1.00 [ -0.21]( 0.38)
  256         1.00 [ -0.00](10.52)     0.95 [  4.74]( 6.94)
  512         1.00 [ -0.00]( 0.69)     1.09 [ -8.99]( 0.27)

  ==================================================================
  Test          : Various longer running benchmarks
  Units         : %diff in throughput reported
  Interpretation: Higher is better
  Statistic     : Median
  ==================================================================
  Benchmarks:                 %diff

  ycsb-cassandra             -0.54%
  ycsb-mongodb                0.09%

  deathstarbench-1x          -0.30%
  deathstarbench-2x           2.38%
  deathstarbench-3x           0.58%
  deathstarbench-6x           0.62%

  hammerdb+mysql 16VU         0.76%
  hammerdb+mysql 64VU         0.74%

* The tail latencies reported by schbench increases possibly due to the
  sync in load balancing across multiple domains however it remains to
  be investigated.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 99 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b402f294f0b..212bee3e9f35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10275,6 +10275,38 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	return check_cpu_capacity(rq, sd);
 }
 
+static inline void cache_sd_stats(struct sched_domain *sd, struct sg_lb_stats *sd_stats)
+{
+	struct sched_domain_shared *sd_share = sd->shared;
+	unsigned long current_jiffy = jiffies;
+	struct sg_lb_stats_prop *lb_prop;
+
+	if (!sd_share)
+		return;
+
+	lb_prop = (struct sg_lb_stats_prop *)sd_share->private;
+	if (!lb_prop)
+		return;
+
+	/* Concurrent load balancing instance already updated the stats */
+	if (READ_ONCE(lb_prop->last_update) == current_jiffy)
+		return;
+
+	scoped_guard(raw_spinlock_irqsave_try, &lb_prop->stats_lock) {
+		if (READ_ONCE(lb_prop->last_update) == current_jiffy)
+			break;
+
+		lb_prop->sg_stats = *sd_stats;
+
+		/*
+		 *  Pairs against readers checking the last_update
+		 *  before reading the cached stats.
+		 */
+		smp_wmb();
+		WRITE_ONCE(lb_prop->last_update, current_jiffy);
+	}
+}
+
 static inline int can_retrieve_stats(struct sched_domain *sd, enum cpu_idle_type idle)
 {
 	/*
@@ -10344,6 +10376,35 @@ static inline int retrieve_cached_stats(struct sched_group *group, struct sg_lb_
 	return time_before_eq(jiffies, current_jiffy);
 }
 
+/**
+ * aggregate_sd_prop_stats - Compute sched domains's stats from group stats.
+ * @env: The load balancing environment.
+ * @sgs_prop: variable to hold the statistics to propagate for the sd
+ * @sgs: Group stat that was computed or retrieved
+ */
+static inline void aggregate_sd_stats(struct lb_env *env,
+				      struct sg_lb_stats *sd_stats,
+				      struct sg_lb_stats *sg_stats)
+{
+	sd_stats->group_load += sg_stats->group_load;
+	sd_stats->group_util += sg_stats->group_util;
+	sd_stats->group_runnable += sg_stats->group_runnable;
+	sd_stats->sum_h_nr_running += sg_stats->sum_h_nr_running;
+	sd_stats->sum_nr_running += sg_stats->sum_nr_running;
+	sd_stats->idle_cpus += sg_stats->idle_cpus;
+	sd_stats->group_capacity += sg_stats->group_capacity;
+	sd_stats->group_weight += sg_stats->group_weight;
+	sd_stats->overloaded |= sg_stats->overloaded;
+	sd_stats->overutilized |= sg_stats->overutilized;
+
+#ifdef CONFIG_NUMA_BALANCING
+	if (env->sd->flags & SD_NUMA) {
+		sd_stats->nr_numa_running += sg_stats->nr_numa_running;
+		sd_stats->nr_preferred_running += sg_stats->nr_preferred_running;
+	}
+#endif
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -11041,9 +11102,18 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 {
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
-	struct sg_lb_stats tmp_sgs;
-	unsigned long sum_util = 0;
 	bool sg_overloaded = 0, sg_overutilized = 0;
+	struct sg_lb_stats tmp_sgs, sd_stats;
+	unsigned long sum_util = 0;
+	bool should_prop = false;
+
+	/*
+	 * If a parent domain exists and the cached stats can be retrieved when
+	 * load balancing there, aggregate the statistics at current domain
+	 * to be retrieved when load balancing at parent.
+	 */
+	if (env->sd->parent && can_retrieve_stats(env->sd->parent, env->idle))
+		should_prop = true;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -11061,21 +11131,36 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs);
 
+		if (should_prop)
+			aggregate_sd_stats(env, &sd_stats, sgs);
+
 		if (!local_group && update_sd_pick_busiest(env, sds, sg, sgs)) {
 			sds->busiest = sg;
 			sds->busiest_stat = *sgs;
 		}
 
 		/* Now, start updating sd_lb_stats */
-		sds->total_load += sgs->group_load;
-		sds->total_capacity += sgs->group_capacity;
-		sg_overloaded |= sgs->overloaded;
-		sg_overutilized |= sgs->overutlizied;
+		if (!should_prop) {
+			sds->total_load += sgs->group_load;
+			sds->total_capacity += sgs->group_capacity;
+			sg_overloaded |= sgs->overloaded;
+			sg_overutilized |= sgs->overutilized;
+			sum_util += sgs->group_util;
+		}
 
-		sum_util += sgs->group_util;
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
+	if (should_prop) {
+		sds->total_load = sd_stats.group_load;
+		sds->total_capacity = sd_stats.group_capacity;
+		sg_overloaded = sd_stats.overloaded;
+		sg_overutilized = sd_stats.overutilized;
+		sum_util = sd_stats.group_util;
+
+		cache_sd_stats(env->sd, &sd_stats);
+	}
+
 	/*
 	 * Indicate that the child domain of the busiest group prefers tasks
 	 * go to a child's sibling domains first. NB the flags of a sched group
-- 
2.43.0


