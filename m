Return-Path: <linux-kernel+bounces-568689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F125A69957
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0717526B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA22213E76;
	Wed, 19 Mar 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivQI55qx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BF1E991B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412672; cv=fail; b=qYYJ2UBDltaAOmJu7+OWUD0J+HaEs6nQU5CewcNVvmeBrRIKGfk93ubhXiFndFkiUk/nTm62SRsC58PqquYmR2MGoZf8wTGQ7fHPMQ7gaWIZJO+qlu0LuJuZGMkgRQpMnn+Gbpbtvw8bIyjQ2FavukYueER6gIqzE/n5Vl6J9nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412672; c=relaxed/simple;
	bh=jnbKMN4DRvfZ2QFNO3GiJNiiLfc4G/jLAoUZW6IUFhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpN4iI0E5OeiHOtANiMIqOkPtHCxD84jbk6smRtTsVyd05EFDExuYo043FHoJ2gZGNLd9NEO+x2TX2yzCrj7PGc00RZqglIvjUijyaxLkbFnG7K7CrThflDV+fgiKknBWQO6A5ts8wKZ9eZCvQlhFilR02013sSF9f9N+1uvv3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivQI55qx; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy/KIsda+vfniXbu6LQvrk24IV57bDIbvWvEp/ef+oY80NKu6OstYWnnWeEGFAuRMbIXbFPUnofq9hteCMn5RegDl8N4S72P8it3WDslksZK+daPSikOfEe4LIBsHtJTCmDGyAJcnwN0gGwOxMCEF6bO+X2WfSpTzCxwAXHv4uw5kYx1TAiorn2OCzXIEyyCY1MNnHD2QYy+o2JSHNhreIHsWYF94IRRk/Y78pqnkHjeKbUVud6ClhYx9KaYjnr/biTrQ8wcClfuMNF7QgiV4xVXsUFNktapjBHkcteVsI5aBhYU/+X4w6O5vrqpmp2zBAYdgbUY3y/jqilnneQPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvikH11XOj5BBJEFuGMi6vlqefuiianXeQD7VPW3FBo=;
 b=bv0yPm3hsbBcyAm91+GdAUxPX7TQ2v83+dwSCEvs8y2HJDLb68WKhVMkTNZ4oNmM0BZFUjeYYzB2KtHcOBeCLoyxoDYPVOb3rA11+1SACZmEwQNL8Cuce7MhyhPccat9lbZ19zvOdnpL3BFoECW32m0Vq0Kabhcf8F81zg/XwoNHkGVI70bAGjGJ81n9QQAHqo70ohazuJuWhFlX5ioSkAFEjSwnAi/tmt6MVaQSfZ2D0iolz6ZzvJqMI1La6Jf7BaUoJk550TFwlzvhB3ZQg8Lsn/+F6YyzNxzHXf41yc0B3W2p6FhV3Hb1zEJmDSx8RJxC+k30lmJlreeilCAffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvikH11XOj5BBJEFuGMi6vlqefuiianXeQD7VPW3FBo=;
 b=ivQI55qxYvmVH19SyICFBIugIq73rDw4XMUOEbgzcf7lfqO7zQFQGcx0GUYkgW1Rfc70Pw6NEMvUVeWWekycKUv5y+DPsksezAFXHXAKLBEYG//PknHcHGKkyT7gPpqbGH/PmJZquazPMTTNOw1KavmWmcyFEYoblka3Uw6a9jA=
Received: from SA1P222CA0099.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::13)
 by BN5PR12MB9537.namprd12.prod.outlook.com (2603:10b6:408:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 19 Mar
 2025 19:31:02 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::52) by SA1P222CA0099.outlook.office365.com
 (2603:10b6:806:35e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.26 via Frontend Transport; Wed,
 19 Mar 2025 19:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:31:02 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:30:52 -0500
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
Subject: [RFC PATCH V1 00/13] mm: slowtier page promotion based on PTE A bit
Date: Wed, 19 Mar 2025 19:30:15 +0000
Message-ID: <20250319193028.29514-1-raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BN5PR12MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c64d886-12fb-402d-a810-08dd671c95b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SwHzqUGwjf8nsxBKNh7EIaJFog8x36h5FMrleDOpw1QD/qQB+L6A4MXDl0a/?=
 =?us-ascii?Q?u4wIBPOXVugY0C3o9jbtyIToXWmU/jrlCf/fbL6RBIMXckaO59kU+oxdL4tZ?=
 =?us-ascii?Q?Ms0n1CogZpH27N0P8+5/GS4AoF7GSy0GNIoJ8p189h7O/XCMNtZUGPXZf6oy?=
 =?us-ascii?Q?bmP17JfcdDcybTv1aXoehRXZZk6U/bZ1/GhOhETsizSUIIMYwP22PTkr4T7C?=
 =?us-ascii?Q?TwZBeX31Bv9KS0GjTJ6T8KQte8rDuDRQbGtjbuGerWXO/nXa8W+AyHZpCj/s?=
 =?us-ascii?Q?NuuipAVr2tuWfHuVa08dlCzQhndez7xfm5i7cTD+vRJh/tOfFNhJT8nMuxi6?=
 =?us-ascii?Q?95mEoX7oPyw0slW8dr13H91Ydd7vkFT8O8KJPn9f2EsR0O1xE8rBGuzgIMvY?=
 =?us-ascii?Q?ELRsonNcCSMIJLMBKf9KicDP7jYgmUWyRy5Lbg6323dtgdjlMchea4TlVyTH?=
 =?us-ascii?Q?hWmaGJKSJdkqQLKphZD9BIvT2CR50zQrqyvwag91fLOWBtuoSx7XlMhMt4/n?=
 =?us-ascii?Q?UObduouhOoIfptqmX/M1we8yDFf7rdtsIwUp1hC/W1YaL4Ll2zaUfoIFmc1p?=
 =?us-ascii?Q?kvsa/LBlVqIsQrzC0r60gArUmKF9jUm9cczxH3H+0nsC2bH+s+UE/Atu5ggC?=
 =?us-ascii?Q?eG4kywO3B5kVPAlTr3eqgltBJWirabhut2pw+r95G8IMJpjtOa9PMoEBVh4L?=
 =?us-ascii?Q?RuMWurpbnrI2o7rzNCSaza0iS2HmH0dAw1MYfgeZ2SmsmqFfrj1Pdx8km7YH?=
 =?us-ascii?Q?KtksSQKc1o9Me84Hl5sObLJAimI3ihEnsuRlyhjzgL2a2G2pq9jgZRLfHSDR?=
 =?us-ascii?Q?8+4r23wiRAvuAsY7hvM1lDfd4qrOYYLE/lVW7Y8GHsfMqydIRgx42Zsastjz?=
 =?us-ascii?Q?tLn86PiJ7I3xrAxtr1GVXLxRU+gMyuoPuC1cOS+bfpf/78bd/g4+Sg8VAbsq?=
 =?us-ascii?Q?Z5nKVjTCprq4dsNcKrthx/YJLo2Le29jYNQUzSGRHRwfiiyDTtOQcN6uny/s?=
 =?us-ascii?Q?qgDbCYXw/1h5K9nYMi3EX4FnzU93iPXzwnhVKQncNyUmCgMfJ8cQAE++7FTd?=
 =?us-ascii?Q?wRt5kE0MxZunvpvchygUyjAxdfaQCg8XQhSwG1Yk3xlh7JoxFkrTlL8mtT42?=
 =?us-ascii?Q?3vdWv7hN3NHUC8T9S5bPDcSY1FLn2BdFu2fwusRPNY6XZwlOOCF3+u3UcIMD?=
 =?us-ascii?Q?OQ3+Ly3ZtCO91Pl4Cro0OnA6HSg+dCKCJd5KdZNPrMA8dnS58DoBRw3u//Li?=
 =?us-ascii?Q?Cv+WxBFY/ZNov78K0WB8XYDbBGes8OPT1AIvEvpl6GUxOn1gQ0bwgwz+cyog?=
 =?us-ascii?Q?QZM6XGJ46/tEKoE/UyJhaS8ZA0bbJ5ekCz7W3xJIAgw4jpvRjL2rZlF6RBn5?=
 =?us-ascii?Q?5jHQIGjQ18nFrmssCZkEbZC1p23qzv3LIhVatjMuPB98KK1esfQZyJ3q05JM?=
 =?us-ascii?Q?usmlOWUrO825tPA8IbtA+dSQNIweM+T7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:31:02.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c64d886-12fb-402d-a810-08dd671c95b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9537

Introduction:
=============
In the current hot page promotion, all the activities including the
process address space scanning, NUMA hint fault handling and page
migration is performed in the process context. i.e., scanning overhead is
borne by applications.

This is RFC V1 patch series to do (slow tier) CXL page promotion.
The approach in this patchset assists/addresses the issue by adding PTE
Accessed bit scanning.

Scanning is done by a global kernel thread which routinely scans all
the processes' address spaces and checks for accesses by reading the
PTE A bit. 

A separate migration thread migrates/promotes the pages to the toptier
node based on a simple heuristic that uses toptier scan/access information
of the mm.

Additionally based on the feedback for RFC V0 [4], a prctl knob with
a scalar value is provided to control per task scanning.

Initial results show promising number on a microbenchmark. Soon
will get numbers with real benchmarks and findings (tunings). 

Experiment:
============
Abench microbenchmark,
- Allocates 8GB/16GB/32GB/64GB of memory on CXL node
- 64 threads created, and each thread randomly accesses pages in 4K
  granularity.
- 512 iterations with a delay of 1 us between two successive iterations.

SUT: 512 CPU, 2 node 256GB, AMD EPYC.

3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>

Calculates how much time is taken to complete the task, lower is better.
Expectation is CXL node memory is expected to be migrated as fast as
possible.

Base case: 6.14-rc6    w/ numab mode = 2 (hot page promotion is enabled).
patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
we expect daemon to do page promotion.

Result:
========
         base NUMAB2                    patched NUMAB1
         time in sec  (%stdev)   time in sec  (%stdev)     %gain
 8GB     134.33       ( 0.19 )        120.52  ( 0.21 )     10.28
16GB     292.24       ( 0.60 )        275.97  ( 0.18 )      5.56
32GB     585.06       ( 0.24 )        546.49  ( 0.35 )      6.59
64GB    1278.98       ( 0.27 )       1205.20  ( 2.29 )      5.76

Base case: 6.14-rc6    w/ numab mode = 1 (numa balancing is enabled).
patched case: 6.14-rc6 w/ numab mode = 1 (numa balancing is enabled).
         base NUMAB1                    patched NUMAB1
         time in sec  (%stdev)   time in sec  (%stdev)     %gain
 8GB     186.71       ( 0.99 )        120.52  ( 0.21 )     35.45 
16GB     376.09       ( 0.46 )        275.97  ( 0.18 )     26.62 
32GB     744.37       ( 0.71 )        546.49  ( 0.35 )     26.58 
64GB    1534.49       ( 0.09 )       1205.20  ( 2.29 )     21.45


Major Changes since V0:
======================
- A separate migration thread is used for migration, thus alleviating need for
  multi-threaded scanning (atleast as per tracing).

- A simple heuristic for target node calculation is added.

- prctl (David R) interface with scalar value is added to control per task scanning.

- Steve's comment on tracing incorporated.

- Davidlohr's reported bugfix.

- Initial scan delay similar to NUMAB1 mode added.

- Got rid of migration lock during mm_walk.

PS: Occassionally I do see if scanning is too fast compared to migration,
scanning can stall waiting for lock. Should be fixed in next version by
using memslot for migration..

Disclaimer, Takeaways and discussion points and future TODOs 
==============================================================
1) Source code, patch seggregation still to be improved, current patchset only
provides a skeleton.

2) Unification of source of hotness is not easy (as mentioned perhaps by Jonathan)
but perhaps all the consumers/producers can work coopertaively.

Scanning:
3) Major positive: Current patchset is able to cover all the process address
space scanning effectively with simple algorithms to tune scan_size and scan_period.

4) Effective tracking of folio's or address space using / or ideas used in DAMON
is yet to be explored fully.

5) Use timestamp information-based migration (Similar to numab mode=2).
instead of migrating immediately when PTE A bit set.
(cons:
 - It will not be accurate since it is done outside of process
context.
 - Performance benefit may be lost.)

Migration:

6) Currently fast scanner can bombard migration list, need to maintain migration list in a more
organized way (for e.g. using memslot, so that it is also helpful in maintaining recency, frequency
information (similar to kpromoted posted by Bharata)

7) NUMAB2 throttling is very effective, we would need a common interface to control migration
and also exploit batch migration.

Thanks to Bharata, Joannes, Gregory, SJ, Chris, David Rientjes, Jonathan, John Hubbard,
Davidlohr, Ying, Willy, Hyeonggon Yoo and many of you for your valuable comments and support.

Links:
[1] https://lore.kernel.org/lkml/20241127082201.1276-1-gourry@gourry.net/
[2] kstaled: https://lore.kernel.org/lkml/1317170947-17074-3-git-send-email-walken@google.com/#r
[3] https://lore.kernel.org/lkml/Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net/
[4] RFC V0: https://lore.kernel.org/all/20241201153818.2633616-1-raghavendra.kt@amd.com/
[5] Recap: https://lore.kernel.org/linux-mm/20241226012833.rmmbkws4wdhzdht6@ed.ac.uk/T/
[6] LSFMM: https://lore.kernel.org/linux-mm/20250123105721.424117-1-raghavendra.kt@amd.com/#r
[7] LSFMM: https://lore.kernel.org/linux-mm/20250131130901.00000dd1@huawei.com/

I might have CCed more people or less people than needed
unintentionally.

Patch organization:
patch 1-4 initial skeleton for scanning and migration
patch 5: migration
patch 6-8: scanning optimizations
patch 9: target_node heuristic
patch 10-12: sysfs, vmstat and tracing
patch 13: A basic prctl implementation.

Raghavendra K T (13):
  mm: Add kmmscand kernel daemon
  mm: Maintain mm_struct list in the system
  mm: Scan the mm and create a migration list
  mm: Create a separate kernel thread for migration
  mm/migration: Migrate accessed folios to toptier node
  mm: Add throttling of mm scanning using scan_period
  mm: Add throttling of mm scanning using scan_size
  mm: Add initial scan delay
  mm: Add heuristic to calculate target node
  sysfs: Add sysfs support to tune scanning
  vmstat: Add vmstat counters
  trace/kmmscand: Add tracing of scanning and migration
  prctl: Introduce new prctl to control scanning

 Documentation/filesystems/proc.rst |    2 +
 fs/exec.c                          |    4 +
 fs/proc/task_mmu.c                 |    4 +
 include/linux/kmmscand.h           |   31 +
 include/linux/migrate.h            |    2 +
 include/linux/mm.h                 |   11 +
 include/linux/mm_types.h           |    7 +
 include/linux/vm_event_item.h      |   10 +
 include/trace/events/kmem.h        |   90 ++
 include/uapi/linux/prctl.h         |    7 +
 kernel/fork.c                      |    8 +
 kernel/sys.c                       |   25 +
 mm/Kconfig                         |    8 +
 mm/Makefile                        |    1 +
 mm/kmmscand.c                      | 1515 ++++++++++++++++++++++++++++
 mm/migrate.c                       |    2 +-
 mm/vmstat.c                        |   10 +
 17 files changed, 1736 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/kmmscand.h
 create mode 100644 mm/kmmscand.c


base-commit: b7f94fcf55469ad3ef8a74c35b488dbfa314d1bb
-- 
2.34.1


