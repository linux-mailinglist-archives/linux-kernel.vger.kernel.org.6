Return-Path: <linux-kernel+bounces-559112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A46A5EFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE56189DCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EB62641DE;
	Thu, 13 Mar 2025 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WAYXvJ4Z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0817263C77
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858693; cv=fail; b=ll26Ltbku+48V0tU5/sBk2Sz2c53nqLg5q5cWybXExi9dbO2WJjC8L7oL+TIHDTSyPek9pzEp6lG79a74fuRTxNRw+V6xdg9JG+LJwfI2j6a6e+/WKZmmGIcnjctlmF+lh/1Qx3EUbrw1/2KbdXH8vWC21tPmciYWOXJEAISlzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858693; c=relaxed/simple;
	bh=KXj07KfhHFAhrz7HGUYivsqzTf2CWYrdy6mQKPD81Uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EKpfPemPk7qULvnG6x49Y4V2pEA24I9AfWVvRMW1ljxkOHx+7S8+BSyF3UOI9iWRsFDA4spSfoBaNnWgKZnfKhGMilyCLWv1Nacb/CuqFuZvskYiTouPes2djtC2YMMB2pPEQP6EYrnpC+N7zY1elaU4tkFxwDKV4+tDpZyd53Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WAYXvJ4Z; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDzNLaKtZkFb646I/AT/Ft/Og1t0p3OvBfm2uTYdoHLjcxtq0E4Cg9P0YgDiQQF1FNNuWO9WZDL2glKsbA1izfILUCS43oK+EmTROneOgCBrwgMxDMTv5m14WL1hqU7b+SNhXrqQAPt8o2M/DkrGuZsEZSkqCs/MULRvQQLFsJ59WlFlq13Arve8d2yOBBceUPoeZaa7kzZ1snb9Os0bFAi9FTQEbTo4+5rNbCOn8BP+kasaZOKDTumikxLreYh3IdrFgBJAdSeVZKEJLBmzjzMVn5/gY0OQTD2AAFu0uxUWUtO3OWZr4vvIQa1imTPhXAEZ9ljOlFqx2Ewh6FYQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whYoiQnHKmlJ38c/YikFFEwTRUlu39oBRxZt+NWDEkU=;
 b=B8xJXd3jV2AFO/EDLMquZ3RW5+VAEgagCj3dZGibdqMVn0yn1L5a2K86DNLlEYMELYHn6xSw29rB/AdafUq4DBlCjfufCs0V4b7xFsRjso/Ysfiok0MtzyOTaBIPSh7dhyRDvCBwI8Q3ZqNy4dpAc/6FLGI7hgh7p8qv1lkdVWt7TzhBsmlzzHsMvRIDu2J+rXTOq7nWPcNuOgE8UiQbOlJNpFiHNQrpxCl6j+jCjIQ+NNWIUVeKUhgRha0fumi+2I0putz+HLJfZ2+txPlj/sNgFKjnml9qOZGaOEOu7mJ7aA/hEaejlauzFU9imJoDdrNqpXy/B8TXqifTrDom/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whYoiQnHKmlJ38c/YikFFEwTRUlu39oBRxZt+NWDEkU=;
 b=WAYXvJ4Z1jENVqd4ueaedP0iqPcc9CBTNI04BMLf0f7U+NL5TkNKmygpTnwYMs2kusmroc0LX2zCejejFToGQzx4KbpTQWhPuoh6RUnpgIZ7k0i+Ai2ifHUpMS0zEN5UWDWqruCsalzSoKFHXO7TMtjcUavcgWIcHu8iEQJgVO8=
Received: from CY5PR15CA0071.namprd15.prod.outlook.com (2603:10b6:930:18::16)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:38:08 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::c7) by CY5PR15CA0071.outlook.office365.com
 (2603:10b6:930:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Thu,
 13 Mar 2025 09:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 09:38:07 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 04:38:01 -0500
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
Subject: [RFC PATCH 0/8] sched/fair: Propagate load balancing stats up the sched domain hierarchy
Date: Thu, 13 Mar 2025 09:37:38 +0000
Message-ID: <20250313093746.6760-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f14cbc-bc26-426e-0117-08dd6212c32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GmKbfEJASwaOa/T/Tusnp5xM7vmkkzZzogRS7XHNLgKbeO7GpqXvyHDBiTfz?=
 =?us-ascii?Q?KhRShhivQwwhhWBoRVs8yYcld7s6QSi8z8bAAYMH0vQVDuH6+gMCeuge9/as?=
 =?us-ascii?Q?rwOESwCgcTTFZM5xhTLjG3sZ26OoO3XTTqnhKkTxe0znDuldDM8Y+a0qqvnf?=
 =?us-ascii?Q?gYBdPI/rescAsIDYZvX5VAYH5YF+9xWpC0d1iU3wFW+4CarUoPQlGHrL7emh?=
 =?us-ascii?Q?R558oKcsjHRihwljz8uby5uQ4tez8eR4I5xrK/c/ylS6pMGHmc5YG7rT46BP?=
 =?us-ascii?Q?kp7VTRfAkvIboRkMdpQvdC1II8oboy0hbJVjaL801UZZyCr13Ceo3IA4E+B6?=
 =?us-ascii?Q?HrQTz+r8ioy1cTuFMguYD1CYnFbsvHY/99iO4cUdRdFniQEZWzwfc2KgoCo2?=
 =?us-ascii?Q?sT9VGVKM/IKb9+5qPrn+H7zA5Zns5M7yQqr+kUFcWuIrzDXsA5VN2x/4CRUw?=
 =?us-ascii?Q?rhjWkwx7S9veA115+1CzM7cRf/AgYq253Q694jMb5IwTMZQ0CjAvJ+i/geT8?=
 =?us-ascii?Q?PvrCaCKtbm2KJIdXT78JnJX7TeFn5cUKOqWo2r6skCT++SnSX0uoTQlhblee?=
 =?us-ascii?Q?r716PA0MKd3aJT4pMHASl7R8Qg/HXUCOKXXRCMvKsfNDcRNB9tKGY9PzbaVO?=
 =?us-ascii?Q?azU4w+xJmiCwbZW+/+dUgRbk++CDi3wnX+5kqdd15u1vQgHLd7dk0mhPXcIV?=
 =?us-ascii?Q?GB2mTjblKMqT0+TpZm4Zv9K05PLNPwh5Ol19IoSt+LgtP3vfs9hrpP5d3U3m?=
 =?us-ascii?Q?qNRVOjgrubY1CJxxO601gsRhmIolBL8U30URLNFfeeCjTPcuF7+F01Ck0M2P?=
 =?us-ascii?Q?dLB+F/EbdNaB0NHzGt97lMkLWlXMqLfTJW8xgcRxd38BuD1ObG9UQfnv9KQj?=
 =?us-ascii?Q?bPFw2q73stC0S6CqY/8h6wLFuWLCRrNtWZtHFT/0zCfEL9Bab+FK6LKP1iEV?=
 =?us-ascii?Q?6RbuqbHDSS2zmokCEv5J9QQeXTVqZ8bme0r4RNQ4FswbFdoF3vAx739NBcq7?=
 =?us-ascii?Q?oC0zYiczyt0eVe/Ahcx0QVDqU/ielkmA5O3hdlf/5QjQHco4hEiECoIyWJni?=
 =?us-ascii?Q?2ZecwthMq4JDDpDW8oXUIdQhMqIWLeVx4j0YhBBU4uH4wNR5srVTkxjH4Lm+?=
 =?us-ascii?Q?RNOQQeZuNNFcTzfdW9bWdxVx6b3bLIcIRywMcUYRG8yU/YEAeY9QTc7/4Pdh?=
 =?us-ascii?Q?BWo8/8YfvVRVg39LHey0gHDGlTPmxAAKs9wAbfLFShxCMHxaaPbcUzjyGJwa?=
 =?us-ascii?Q?CnvsNYcScTDs2eb0HCHB6PkFv8wZCApGYWd2S2FrMQ+7yYMXi7UMGoberhsc?=
 =?us-ascii?Q?2Wh6LcwnQKtHkAHDPktu3phC9rbj9SGmTnuW6Khhls+kAzao2ZsTraPFnoIn?=
 =?us-ascii?Q?4eAI7RnGBvI5tRutZRi3Q+dDn9NM4AcbP+WForzEiEwKoZgbcBklNfPweSTK?=
 =?us-ascii?Q?8qsp98v7lcVpqDC0uZ8fjlaCBvTwrQijsj6Ostga/PK/+1zc8nk+uW/fleZn?=
 =?us-ascii?Q?rNg3jHEigF4A+CI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:38:07.8290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f14cbc-bc26-426e-0117-08dd6212c32c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

tl;dr

This prototype is currently limited in the sense that it can only reuse
statistics for busy load balancing. Reusing stats for newidle load
balancing specifically ran into issues elaborated below.

Despite these shortcomings, the data around load balancing cost suggests
the possibility of a huge savings if the stats can be reused
efficiently as much as possible.

This RFC is intended to start a discussion on the reuse strategy and
find solutions to the issues we've encountered along the way.

Most benchmarks are neutral to this change except few cases of tail
latencies in schbench shooting up that remains to be investigated. To
see the benchmarks results, please jump to "Benchmark results" section.

This series in based on tip:sched/core at commit fd881d0a085f ("rseq:
Fix segfault on registration when rseq_cs is non-zero") with upstream
commit 3d252160b818 ("fs/pipe: Read pipe->{head,tail} atomically outside
pipe->mutex") cherry picked on top to fix an issue that would cause
sched-messaging to hang.

With those details out of the way, lets jump into it ...


Motivation
==========

With larger core counts, load balancing at domains with large number of
CPUs can take up significant amount of time. This was first noted and
tackled by Chenyu using ILB_UTIL [1] which bailed out of the load
balancing after scanning a subset of groups of the sched domain based on
the total utilization of CPUs in the sched domain.

Matt Fleming too reported that he had observed newidle balance popping
up regularly when profiling a production server [2] which is not
uncommon since users of large server tend to run with idle headroom to
maintain SLA requirements and handle unexpected bursts.

We've had reports of load balancing jitters being a hinderance for
certain classes of workloads which is why the idea to add a new sched
domain demarcating NPS quadrants when running in NPS1 mode was not too
well received [3]

David had proposed SHARED_RUNQ [4] to improve on the shortcomings of
newidle balance for Meta's production workloads.

There have been multiple proposals to optimize newidle balance in the
past specifically for issues seen on larger core count systems.


Proposal
========

Each sched group, except for those of the lowest domain, derive
themselves for a sched domain struct of a higher domain. Since each
of these sub-NUMA sched domain contains a sd->shared reference, it can
be used to communicate data between the sched_group and the sched_domain
it is derived from.

This series introduces a sg->shared that references the sd->shared of
the sched domain the group is derived from. The shared struct now embeds
in it a "sg_lb_stats" object that can be used to aggregate the
statistics from load balancing at lower domain to update the stats of a
higher domain.

When update_sg_lb_stats() is called, the "sg_lb_stats" object in
sg->shared is checked for validity and is returned as the group stats if
it is still valid.

update_sd_lb_stats() aggregates the stats from all the sched groups
traversed and updates the stats in sd->shared for it to be reused when
load balancing at a higher domain.


                                update_sd_lb_stats(PKG)
                                           |
                                           v
                                 update_sg_lb_stats()
                                           |
                                           v
                                      sg->shared
                                           ^
                                           |
    update_sd_lb_stats(MC) -> updates sd->shared
             |
             v
    update_sg_lb_stats()
             |
             v
          sg->shared


Caveats of aggressive reuse
===========================

The initial version allowed stats to be propagated for all types of load
balancing however, with a wakeup intensive workload, newidle balance ran
into multiple problems.

Allowing stats to be updated frequently can lead to long delays for
readers trying to see a consistent stats object. Initial design used
seqcount_t to allow concurrent update to shared stats but it ran into
rcu stalls on the read side.

The next experiment used "jiffies" as a measure for stats freshness
which led to a mixed bag of results:

  Benchmark                                		 %diff

  schbench (new) 256-worker (wakeup latency)		12.81%
  schbench (new) 256-worker (request latency)		18.42%
  DeathStarBench 2x (throughput)			 8.10%
  DeathStarBench 3x (throughput)			 6.27%
  DeathStarBench 6x (throughput)			 2.25%

  sched-messaging 4-group (throughput)		       -47.27%
  sched-messaging 8-groups (throughput)		       -48.99%
  sched-messaging 16-group (throughput)		       -20.52%
  tbench 256-clients (throughput)		       -10.15%
  schbench (old) 128-workers (tail latency)	      -390.11%
  schbench (old) 256-workers (tail latency)	      -102.43%
  schbench (new) 128-workers (wakeup latency)	      -114.97%
  schbench (new) 512-workers (wakeup latency)	       -20.89%
  schbench (new) 256-worker (request latency)	       -32.44%
  HammerDB + MySQL8 16VU (throughput)	               -13.14%
  HammerDB + MySQL8 64VU (throughput)	                -4.46%

  ( Benchmark cases not listed above were found to be perf neutral. )

hackbench 4-groups was chosen for analysis since it is short running and
produces stable results across multiple iterations. Using "perf sched
stats" [5] to profile the workload revealed the following information:

  ----------------------------------------------------------------------------------------------------
  CPU <ALL CPUS SUMMARY>
  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANGE    PCT_CHANGE1 PCT_CHANGE2
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                              :           0,          0  |     0.00% |
  Legacy counter can be ignored                                    :           0,          0  |     0.00% |
  schedule() called                                                :      117639,     125511  |     6.69% |
  schedule() left the processor idle                               :       58581,      58104  |    -0.81% |  (    49.80%,     46.29% )
  try_to_wake_up() was called                                      :       58973,      65141  |    10.46% |
  try_to_wake_up() was called to wake up the local cpu             :          30,        191  |   536.67% |  (     0.05%,      0.29% )
  total runtime by tasks on this processor (in jiffies)            :  2338057783, 2190178756  |    -6.32% |
  total waittime by tasks on this processor (in jiffies)           :    27373872,  284078866  |   937.77% |  (     1.17%,     12.97% )
  total timeslices run on this cpu                                 :       59052,      67395  |    14.13% |
  ----------------------------------------------------------------------------------------------------

  Summary:

  o The wait time shoots up by 9x
  o The number of local CPU wakeups go up 5x

Analyzing the lb statistics revealed the following for newidle balance
(please jump to summary for the insights from the data):

  SMT
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :        1576,      11323  |   618.46% |  $        0.77,        0.15 $
  load_balance() found balanced on cpu newly idle                  :        1552,      11146  |   618.17% |  $        0.78,        0.15 $
  load_balance() move task failed on cpu newly idle                :           4,         48  |  1100.00% |  $      303.75,       34.27 $
  pull_task() count on cpu newly idle                              :          19,        128  |   573.68% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,          0  |     0.00% |  $        0.00,        0.00 $
  load_balance() failed to find busier group on cpu newly idle     :        1342,      10519  |   683.83% |  $        0.91,        0.16 $
  *load_balance() success count on cpu newly idle                  :          20,        129  |   545.00% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.95,       0.99  |     4.45% |

  MC
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :         717,       8824  |  1130.68% |  $        1.69,        0.19 $
  load_balance() found balanced on cpu newly idle                  :         503,       5608  |  1014.91% |  $        2.42,        0.29 $
  load_balance() move task failed on cpu newly idle                :         203,       3200  |  1476.35% |  $        5.99,        0.51 $
  pull_task() count on cpu newly idle                              :          10,         15  |    50.00% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,       1724  |     0.00% |  $        0.00,        0.95 $
  load_balance() failed to find busier group on cpu newly idle     :         475,       3756  |   690.74% |  $        2.56,        0.44 $
  *load_balance() success count on cpu newly idle                  :          11,         16  |    45.45% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.91,       0.94  |     3.12% |

  PKG
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :         112,       4199  |  3649.11% |  $       10.85,        0.39 $
  load_balance() found balanced on cpu newly idle                  :          39,       1989  |  5000.00% |  $       31.15,        0.83 $
  load_balance() move task failed on cpu newly idle                :          66,       2198  |  3230.30% |  $       18.41,        0.75 $
  pull_task() count on cpu newly idle                              :           6,         12  |   100.00% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,       1059  |     0.00% |  $        0.00,        1.55 $
  load_balance() failed to find busier group on cpu newly idle     :          17,        816  |  4700.00% |  $       71.47,        2.02 $
  *load_balance() success count on cpu newly idle                  :           7,         12  |    71.43% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.86,       1.00  |    16.67% |

  NUMA
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :          46,        844  |  1734.78% |  $       26.41,        1.95 $
  load_balance() found balanced on cpu newly idle                  :          36,        836  |  2222.22% |  $       33.75,        1.97 $
  load_balance() move task failed on cpu newly idle                :           9,          7  |   -22.22% |  $      135.00,      235.00 $
  pull_task() count on cpu newly idle                              :           1,          0  |  -100.00% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,          0  |     0.00% |  $        0.00,        0.00 $
  load_balance() failed to find busier group on cpu newly idle     :          10,        781  |  7710.00% |  $      121.50,        2.11 $
  *load_balance() success count on cpu newly idle                  :           1,          1  |     0.00% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        1.00,       0.00  |  -100.00% |
  
  ---
  Summary:

  o The number of newidle balancing attempts have shot up drastically
  o "avg task pulled per successful lb attempt" stats are similar
  o "load_balance() failed to find busier queue on cpu newly idle"
    shoots up with stats reuse.

This led to two conclusions:

o Something is tripping the newidle balance guards (cost, rd->overloaded
  check).
o Stats going stale quickly can lead to failure to find a busy src_rq to
  pull the task from.


Cost of load balancing
======================

sg_overloaded flag was verified to be correct using the sched debug
data - this could also mean that the imbalance was failed to be balanced
however at this point, even the cost of newidle balance was analyzed to
spot any benefits of stats reuse:

o Bailout count: Number of instance where load balancing bailed out vs
  was attempted at a particular domain.

  - tip:sched/core

            Bailout           lb_count[CPU_NEWLY_IDLE]
    Early     57035                    N/A
    SMT           0                   1576
    MC          629                    717
    PKG         566                    112
    NUMA         37                     46

  - stats_prop

            Bailout           lb_count[CPU_NEWLY_IDLE]
    Early     46568 (-18%)             N/A
    SMT           1                  11323 (618%)
    MC         1745                   8824 (1131%)
    PKG        4481                   4199 (3949%)
    NUMA       3230                    844 (1735%)

tip:sched/core bails out early compared to with the stats_prop variant.
This suggests that rd->overloaded is set and the cost for a newidle
balance is cheap.

o Cost of newidle balance: These are the load balancing time in ns when
  sched_balance_rq() returned > 0 with "continue_balancing" set to true
  ensuring at least one loop in sched_balance_rq()

  - tip:sched/core

    Case   Min Cost   Max Cost   Avg Cost
    SMT       646ns    16187ns      878ns
    MC       1150ns    15732ns     1685ns
    PKG      7087ns    44092ns    10837ns
    NUMA    13765ns    33651ns    20153ns

  - stats_prop

    Case   Min Cost   Max Cost   Avg Cost
    SMT       753ns    14963ns      848ns (-3%)
    MC        454ns    15130ns      511ns (-70%)
    PKG       832ns    20551ns     1528ns (-86%)
    NUMA      477ns    18258ns      678ns (-97%)

The data suggests there is a significant cost savings possible if the
stats can be reused efficiently.


Stats invalidation
==================

Another experiment was tried with stats invalidation where the cached
statistics were invalidated once a decision to migrate the task was
taken.

With stats invalidation the situation improved but the regressions were
still very red:

  Benchmark                                              %diff

  netperf 128-clients (throughput)                       8.62%
  DeathStarBench 2x (throughput)                         2.91%
  DeathStarBench 3x (throughput)                         6.59%
  DeathStarBench 6x (throughput)                         2.87%

  sched-messaging 4-group (throughput)                 -41.60%
  sched-messaging 8-groups (throughput)                -45.88%
  sched-messaging 16-group (throughput)                -12.48%
  tbench 256-clients (throughput)                       -8.93%
  schbench (old) 128-workers (tail latency)           -673.33%
  schbench (old) 256-workers (tail latency)            -92.72%
  schbench (new) 128-workers (wakeup latency)          -67.91%
  schbench (new) 512-workers (wakeup latency)          -20.89%
  schbench (new) 256-worker (request latency)           -6.30%
  HammerDB + MySQL8 16VU (throughput)                  -12.02%
  HammerDB + MySQL8 64VU (throughput)                   -3.52%

For sched-messaging 4-group case, the wait time reduced compared to the
original approach but it was still 7x the baseline on tip:

  ----------------------------------------------------------------------------------------------------
  DESC                                                                    COUNT1      COUNT2   PCT_CHANGE    PCT_CHANGE1 PCT_CHANGE2
  ----------------------------------------------------------------------------------------------------
  sched_yield() count                                              :           0,          0  |     0.00% |
  Legacy counter can be ignored                                    :           0,          0  |     0.00% |
  schedule() called                                                :      117639,     118350  |     0.60% |
  schedule() left the processor idle                               :       58581,      55392  |    -5.44% |  (    49.80%,     46.80% )
  try_to_wake_up() was called                                      :       58973,      61005  |     3.45% |
  try_to_wake_up() was called to wake up the local cpu             :          30,        199  |   563.33% |  (     0.05%,      0.33% )
  total runtime by tasks on this processor (in jiffies)            :  2338057783, 2395802991  |     2.47% |
  total waittime by tasks on this processor (in jiffies)           :    27373872,  232983564  |   751.12% |  (     1.17%,      9.72% )
  total timeslices run on this cpu                                 :       59052,      62949  |     6.60% |
  ----------------------------------------------------------------------------------------------------

  Summary:

  o Wait tim reduced to 7x from 9x
  o Local CPU wakeups still remain at 5x.

Even with stats invalidation, the load balancing stats look similar with
high number of attempts and an increase in "load_balance() failed to
find busier queue on cpu newly idle" with stats reuse.

  SMT
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :        1576,       3300  |   109.39% |  $        0.77,        0.46 $
  load_balance() found balanced on cpu newly idle                  :        1552,       3226  |   107.86% |  $        0.78,        0.47 $
  load_balance() move task failed on cpu newly idle                :           4,         22  |   450.00% |  $      303.75,       69.32 $
  pull_task() count on cpu newly idle                              :          19,         50  |   163.16% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,          0  |     0.00% |  $        0.00,        0.00 $
  load_balance() failed to find busier group on cpu newly idle     :        1342,       3015  |   124.66% |  $        0.91,        0.51 $
  *load_balance() success count on cpu newly idle                  :          20,         52  |   160.00% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.95,       0.96  |     1.21% |

  MC
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :         717,       2567  |   258.02% |  $        1.69,        0.59 $
  load_balance() found balanced on cpu newly idle                  :         503,       1398  |   177.93% |  $        2.42,        1.09 $
  load_balance() move task failed on cpu newly idle                :         203,       1144  |   463.55% |  $        5.99,        1.33 $
  pull_task() count on cpu newly idle                              :          10,         24  |   140.00% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,        604  |     0.00% |  $        0.00,        2.52 $
  load_balance() failed to find busier group on cpu newly idle     :         475,        746  |    57.05% |  $        2.56,        2.04 $
  *load_balance() success count on cpu newly idle                  :          11,         25  |   127.27% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.91,       0.96  |     5.60% |

  PKG
  ---------------------------------------- <Category newidle> ----------------------------------------
  load_balance() count on cpu newly idle                           :         112,        790  |   605.36% |  $       10.85,        1.93 $
  load_balance() found balanced on cpu newly idle                  :          39,        326  |   735.90% |  $       31.15,        4.68 $
  load_balance() move task failed on cpu newly idle                :          66,        442  |   569.70% |  $       18.41,        3.45 $
  pull_task() count on cpu newly idle                              :           6,         21  |   250.00% |
  pull_task() when target task was cache-hot on cpu newly idle     :           0,          0  |     0.00% |
  load_balance() failed to find busier queue on cpu newly idle     :           0,        169  |     0.00% |  $        0.00,        9.02 $
  load_balance() failed to find busier group on cpu newly idle     :          17,         80  |   370.59% |  $       71.47,       19.06 $
  *load_balance() success count on cpu newly idle                  :           7,         22  |   214.29% |
  *avg task pulled per successful lb attempt (cpu newly idle)      :        0.86,       0.95  |    11.36% |

  Summary:

  o Still a very high count of load balancing attempts
  o "avg task pulled per successful lb attempt" is similar still
  o "load_balance() failed to find busier queue on cpu newly idle" is a
    large value once stats are reused.


Ripple effect
=============

The idle_cpu() function searching for idle CPU on SMP looks as follows:

  int idle_cpu(int cpu)
  {
          struct rq *rq = cpu_rq(cpu);
  
          if (rq->curr != rq->idle) /* (1) */
                  return 0;
  
          if (rq->nr_running)
                  return 0;
  
          if (rq->ttwu_pending)
                  return 0;
  
          return 1;
  }

The very first condition (1) rules out an CPU that is not running the
idle task. Since newidle balance happens at select_next_task_fair(),
rq->curr points to the previous task that was blocked which leads to
idle_cpu() checks returning false for CPUs currently in newidle balance.

Modifying this leads to change in baseline numbers which again needs to
be investigated separately.


Limiting stats reuse
====================

With the number of problems building, the stats propagation strategy was
then limited to periodic busy load balancing where the conditions in
should_we_balance() ensure that only a single CPU is performing the
periodic balance in a given domain and since idleness stats remain same
in case of busy balancing since all CPUs are busy and running tasks
cannot be migrated.

The newidle balance case will be worked on and revisited post OSPM since
it requires more evaluation.


Benchmark results
=================

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
---


Outlook
=======

Since the cost savings are evident, stats propagation can be viable to
reduce the load balancing cost and the load balancing jitter on large
core count machines.

This topic will be discussed at OSPM'25. If folks have ideas around
stats propagation or newidle balance, please feel free to reach out to
us or reply on the thread. Any and all feedback is appreciated.


Future work
===========

Since the current prototype is limited to periodic load balancing,
experiments are under progress to improve the scope to newidle balance
and the idle load balance.

Tail latencies of load balancing after synchronizing the intervals are
also being investigated and will be reported on the next version.

Some bits like the "stats_lock" can be optimized further and replaced
with an atomic variable similar to the SD_SERIALIZE handling in
sched_balance_domains().


Acknowledgements
================

Thanks to Chenyu, David for having paved the way before me. Thanks to
Swapnil, Ravi for working on perf sched stats which has proved to be an
invaluable tool for analysis and debug.


References
==========

[1] https://lore.kernel.org/lkml/cover.1690273854.git.yu.c.chen@intel.com/
[2] https://lore.kernel.org/lkml/20240716141645.637620-1-mfleming@cloudflare.com/
[3] https://lore.kernel.org/lkml/3402dcc4-d52f-d99f-e6ce-b435478a5a59@amd.com/
[4] https://lore.kernel.org/lkml/20231212003141.216236-1-void@manifault.com/
[5] https://lore.kernel.org/lkml/20250311120230.61774-1-swapnil.sapkal@amd.com/

---
Chen Yu (1):
  sched/topology: Assign sd_share for all non NUMA sched domains

K Prateek Nayak (7):
  sched/topology: Introduce sg->shared
  sched/fair: Move "struct sg_lb_stats" and its dependencies to sched.h
  sched/fair: Move sg_{overloaded,overutilized} calculation to
    sg_lb_stats
  sched/topology: Define sg_lb_stats_prop and embed it inside
    sched_domain_shared
  sched/fair: Increase probability of lb stats being reused
  sched/fair: Retrieve cached group stats from sg_lb_stats_prop
  sched/fair: Update stats for sched_domain using the sched_group stats

 include/linux/sched/topology.h |   9 +-
 kernel/sched/fair.c            | 277 ++++++++++++++++++++++-----------
 kernel/sched/sched.h           |  82 ++++++++++
 kernel/sched/topology.c        |  55 ++++++-
 4 files changed, 324 insertions(+), 99 deletions(-)

-- 
2.43.0


