Return-Path: <linux-kernel+bounces-562940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85DA634FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A6C3AE139
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0319D065;
	Sun, 16 Mar 2025 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cSIEHSBY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF336FC5
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742120986; cv=fail; b=nJZeRVCdF+GThwtf7wYKo4mCLcjcwVvmyLe1wxVq/lzPRLl+S1p889jFAdTw25AV6J+lKVOMl29Fsfptf6tYnvkf5w01BkaKtj4iGyKUNw7K7jLv7KAFL4cUA1H05+K+lIaB0UfTiys/jwCgDPMq5bRk42BuCRW+OCDtt/lDvcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742120986; c=relaxed/simple;
	bh=JHt50S3KdnlMXQILOGUcsXjle274twePPh98NeLNq/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tocKFrc6QW00y3USZJsvDypPtGixMPLUjq/eCBBLGdLDPk9fW17mP/QNjfhi5EVBBNqUyLr3PD3LUsLBb3HerZh4IMz9uiBH7wWM/nhgO74gTaW34oAQIxmuEJ2kaOfbA1PyhofNbOjcy5lbysSf7d5krEYjMTEMQ8al34mia4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cSIEHSBY; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwCbzFBXgOvR3Pc023lakGQbQiqH/WBMhAjJDmEBPYbHeQ1lArwAhPf5cyO3fLXtyiiSTGc0iGHCf0EKKVQQ/TRFrdEqxt8c1mhW8EPAwNBGutMn2ANiV+IKsNlDkGF05u5UgcnFFdjVPlIEhI/0ghxgi1auBUIDq14s0mJRWBKTUmlsekAXHxbjK2LWnIJyq1QGwTHU4teBK7xeOSjgoU1pxxMKEHK0K5a8kC4joum2ZYq5z1ScITBRBBmXgtBwKbbqRiHbUx6GZpllEK7woLpsfSHCoxvj40fJNANLnzhJtwb92DRVaAoFz6fMEfxWdlynQkcjFRljy0LTCZdNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32HvpIpP7Y4D4IY6e4b7DZjk2/0bd/GFtUJjed/vx6E=;
 b=Rom8/O76kYwJbNNHH4q/2FeC9LjQwX94X9F+rMZiIyeN5OQylxPAKmxaitYDiGwHZokmZf07wzw+iciiARoffSQbCuxIOrryQ0nFpV5NuWjysNcjvDZ9Qd8z1dbUJaYuRNjCX99mXwZjuYQ6gyMuPVXBsbN2Z9Gck+OvZG+GQLXeNg43Vnw8dqqaDShqDzrR88QfiMmBDzlgnfjMB2qhEot9vHAI/2USWCLMUlyt8o3QN1YBiJxzELWu8eDkDsNbQSdv0PCJb6ANN66BbcpKpgwmTi03kqMQrWlxYdKTuYCRT7DaJ1DD7tFPpsNPZoDfoKiOeMq5y/6CLYU35SQQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32HvpIpP7Y4D4IY6e4b7DZjk2/0bd/GFtUJjed/vx6E=;
 b=cSIEHSBYAg/nQHirX+D+QxlXirxgTLRqXm1raUV7diRGEU15dgcHDyKYc0qqZ/oTBXqoAE/vU45e+KPlM7GurXmDE7b5tJHv5daK+vAwINLvovUGhPGNsLuK4VgD1opbIl8PY8Q6E6pGpXx8EhwNg6Ubz4PpYUZ03BJCAOIfNqU=
Received: from BN0PR08CA0006.namprd08.prod.outlook.com (2603:10b6:408:142::26)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 10:29:38 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::b5) by BN0PR08CA0006.outlook.office365.com
 (2603:10b6:408:142::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 10:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 10:29:37 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Mar
 2025 05:29:31 -0500
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
Subject: [RFC PATCH 09/08] [ANNOTATE] sched/fair: Stats versioning and invalidation
Date: Sun, 16 Mar 2025 10:29:10 +0000
Message-ID: <20250316102916.10614-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9efc15-9dd2-48d4-1147-08dd647573d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Bir+HzUTtTDswUys27Kg7PHVa7U/BbgJnCVL9rJpupoacnotrKabIa0mUn0?=
 =?us-ascii?Q?vLsr9QbLWaLb+q7mWOHSRnvIFtux+yqw7JfebTWbcSaDvGPnPg713psN8Qha?=
 =?us-ascii?Q?9EuNRCRoKSPrJj+MJPZ1Qs2j/D1KR/XNeO5pK6uuCLTpwryJ7w6e7/IzxVlI?=
 =?us-ascii?Q?llvV3m5KQU5n6yHRn47rCJIMbWSCWg7RlddI5uS4dtYgvHLJeDGP5xXUmyPD?=
 =?us-ascii?Q?39JNuB49PwjwwIQZySPoDdCFywpRTQv1FnoJ8yKnayDf8eu7cDxk7PbfGY4Y?=
 =?us-ascii?Q?vwp+CnNyp8RpSXI+vJbcBZrD77BWKYK6atOl7nyFMeeXbLgwykfK0mgWSIPB?=
 =?us-ascii?Q?7m50/UBXTUBcJuDwadBnxWhpwpJX8FyV/MLaOc7KnfPBppW9lc9+38xDjF3q?=
 =?us-ascii?Q?zGSnYD+d0efsxPg/cklmCAoQThWNUksX3q9AtdY//9puALpf39ixglbirOLw?=
 =?us-ascii?Q?GwQhZmStSt8lUmkm21pnj3PYCtyob4nV8B9qKxemnWCI+tRcP3Cm+Tj9quN9?=
 =?us-ascii?Q?pPpDSRR7jr5ULbtNS6vpJFc/9tW+jpOJ+QRtHUbWVv6dXLiTM19kGJsLe9EJ?=
 =?us-ascii?Q?oICCHDUbrkOXCRxtbOu4yOq61vmfSq7n53P8NyRSBtW3HszraPy/gAbYufHE?=
 =?us-ascii?Q?BdN/eFTe9OSPf++TIYioH50G6QZL78YXMlLY1JOSSoYdVDGJzul6tCWtimtL?=
 =?us-ascii?Q?brG8vm4kA0faTPllfnbTZWs7F0E14nQCLukdWp0gK5fUwZwP0dPTovzNBwy3?=
 =?us-ascii?Q?gQY8ApdSOaL7FJVWYLti4Wm7OE3b9/bw/+8zBOeUyCNV0HHHOj7Abxl9r+Dh?=
 =?us-ascii?Q?4tz75XGITHqQ5SiPt1lK1/N/4sUuS4+wCPBbD/IFkCRUpUAGKBJP+M1XLcfL?=
 =?us-ascii?Q?v8dkUEszKXYSrgMmHlWwXUt5GQ79H6yhyEad26m11JgDFSDw8bsTnlNDXNjm?=
 =?us-ascii?Q?R/6sUem/wZ+JHXV+1VYpRIa+pkMsW0Q5CV4t/nh3BGRnvCFnHtD/Xy+aeAIw?=
 =?us-ascii?Q?HolzvKRcN7LimdjwnQ/v6e2Q1cqmPVLLSF8sFKPgIlGATPSswdDb0FionJKB?=
 =?us-ascii?Q?klqcbx/mWsHurbbC6tzXBQgb3fw3+Y79mDRD1WKabUh0eS3k484Hv+M1nrCh?=
 =?us-ascii?Q?JBNTik+awDiNnmdvhI/PnSTzBEtnWXDdq3+KcbMCFS1Xx1SXwzZoZcnD2UQu?=
 =?us-ascii?Q?aGSreWB0tAzPzEXQW3/CJyU2uBWdjyegZxMyC2qZ7xOQEwKnOUA5CleO4d65?=
 =?us-ascii?Q?olzwnW/EyEX81+yhweaKhSfVENVy41t3wEIxEdx7UdQSYqlN5g/2CRcuA2Nr?=
 =?us-ascii?Q?qeSA00V2vVRwK17vq9pELEIe80WGGV2ZprQwBNMtU/ra086ceu636zg/4ZSN?=
 =?us-ascii?Q?QKIUngaLXzCch0bHvnFFDd1Hsf5y/fcmY42FPJgvBcQ8vTxnOgz88LI9k2ax?=
 =?us-ascii?Q?iB2L2An6I3A9A+EI3zOc+XuchunWnSXRB+v0ECNPRCBUPj1rW7dgTIov5sdp?=
 =?us-ascii?Q?WSj3a57gqiUrrEE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 10:29:37.3198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9efc15-9dd2-48d4-1147-08dd647573d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893

I would have loved to spin another version of this but me being slightly
short on time before OSPM decided to add these bits on top of the RFC.
Sorry for the inconvenience.

Stats versioning
================

Earlier experiments looked at aggressive stats caching and reuse. Load
balancing instances computed and cached the stats for non-local groups
hoping that they would be reused.

With stats versioning, the load balancing CPU only caches the stats for
the local hierarchy. Instead of the jiffy based "last_update" freshness,
this moves to versioning based on sched_clock_cpu() value.

Stats cached are invalidated if the CPU doing load balance is done
allowing fresher stats to be propagated. Stats computed by a concurrent
load balancing instance can now be reused allowing idle and newidle
balance to reuse stats effectively.

Stats versioning nuances are explained in Patch 11/08. Since idle and
newidle balance can reuse stats, changes have been made in aggregation
to consider reduced capacity, but also forego computing total capacity.

Benchmark results are as follows:

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

Following are the schedstats diff for sched-messaging 4-group and
16-groups:

o 4-groups:

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANGE    PCT_CHANGE1 PCT_CHANGE2
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                              :           0,          0  |     0.00% |
  Legacy counter can be ignored                                    :           0,          0  |     0.00% |
  schedule() called                                                :      174683,     176871  |     1.25% |
  schedule() left the processor idle                               :       86742,      88113  |     1.58% |  (    49.66%,     49.82% )
  try_to_wake_up() was called                                      :       87675,      88622  |     1.08% |
  try_to_wake_up() was called to wake up the local cpu             :          28,         26  |    -7.14% |  (     0.03%,      0.03% )
  total runtime by tasks on this processor (in jiffies)            :  2124248214, 2118780927  |    -0.26% |
  total waittime by tasks on this processor (in jiffies)           :    24160304,   16912073  |   -30.00% |  (     1.14%,      0.80% )
  total timeslices run on this cpu                                 :       87936,      88753  |     0.93% |
  ----------------------------------------------------------------------------------------------------

  ---------------------------------------- <Category newidle> ----------------------------------------
  SMT:

  load_balance() total time to balance on newly idle               :      449650,     465044  |     3.42% |
  load_balance() stats reused on newly idle                        :           0,          0  |     0.00% |
  load_balance() stats recomputed on newly idle                    :        2493,       2679  |     7.46% |

  MC:

  load_balance() total time to balance on newly idle               :      660742,     610346  |    -7.63% |
  load_balance() stats reused on newly idle                        :           0,       1898  |     0.00% |
  load_balance() stats recomputed on newly idle                    :        3985,       3527  |   -11.49% |

  PKG:

  load_balance() total time to balance on newly idle               :      725938,     530707  |   -26.89% |
  load_balance() stats reused on newly idle                        :           0,        401  |     0.00% |
  load_balance() stats recomputed on newly idle                    :         722,        474  |   -34.35% |

  NUMA:

  load_balance() total time to balance on newly idle               :      406862,     410386  |     0.87% |
  load_balance() stats reused on newly idle                        :           0,         36  |     0.00% |
  load_balance() stats recomputed on newly idle                    :          48,         39  |   -18.75% |

o 16-groups:

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANGE    PCT_CHANGE1 PCT_CHANGE2
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                              :           0,          0  |     0.00% |
  Legacy counter can be ignored                                    :           0,          0  |     0.00% |
  schedule() called                                                :      566558,     554784  |    -2.08% |
  schedule() left the processor idle                               :      222161,     212164  |    -4.50% |  (    39.21%,     38.24% )
  try_to_wake_up() was called                                      :      325303,     322690  |    -0.80% |
  try_to_wake_up() was called to wake up the local cpu             :         990,       1017  |     2.73% |  (     0.30%,      0.32% )
  total runtime by tasks on this processor (in jiffies)            :  8807593610, 9142526964  |     3.80% |
  total waittime by tasks on this processor (in jiffies)           :  4093286876, 4314147489  |     5.40% |  (    46.47%,     47.19% )
  total timeslices run on this cpu                                 :      344281,     342495  |    -0.52% |
  ----------------------------------------------------------------------------------------------------

  ---------------------------------------- <Category newidle> ----------------------------------------
  SMT:

  load_balance() total time to balance on newly idle               :     9841719,   11615891  |    18.03% |
  load_balance() stats reused on newly idle                        :           0,          0  |     0.00% |
  load_balance() stats recomputed on newly idle                    :       28103,      27084  |    -3.63% |

  MC:

  load_balance() total time to balance on newly idle               :    20079305,   18103792  |    -9.84% |
  load_balance() stats reused on newly idle                        :           0,      37820  |     0.00% |
  load_balance() stats recomputed on newly idle                    :       63885,      33518  |   -47.53% |

  PKG:

  load_balance() total time to balance on newly idle               :    17972213,   16430220  |    -8.58% |
  load_balance() stats reused on newly idle                        :           0,       8461  |     0.00% |
  load_balance() stats recomputed on newly idle                    :       11513,       6318  |   -45.12% |

  NUMA:

  load_balance() total time to balance on newly idle               :    11050651,    9890509  |   -10.50% |
  load_balance() stats reused on newly idle                        :           0,        496  |     0.00% |
  load_balance() stats recomputed on newly idle                    :         827,        524  |   -36.64% |

---

Note: perf sched stats cannot properly aggregate "min" and "max" fields
yet.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
-- 
2.43.0


