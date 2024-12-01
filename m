Return-Path: <linux-kernel+bounces-426644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E39DF641
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FF7B21575
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E451632FB;
	Sun,  1 Dec 2024 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gyeFDHme"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0343AAD5A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733067535; cv=fail; b=toe2DgxxKbWb7ndXCzEbo7yu/l0XXQqJieO/sY5JwDq0Gj949qSu6RTNPO3U7BX01kltFYR8KqLZ5QkrrC95WmilivsEBPUAU+SQ/Q9HwAqCAPz9qRgm4spJapML38pZEr61MfMENIjxFgDNafI+myumZoPnzyqURFPMS233QPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733067535; c=relaxed/simple;
	bh=1/0djCyR3PfO2bSehNk76WTkJ8VO5ek1WoptUrb7Oos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ocqfJ/mxW0c97S7GuueMtFF44yMUQRgiJMD5nT0o5yMd+px6WA2WLWjvoQIyJ03f15jZeFE2rEZByJtpfDKTMP2WiSfhZLAZkXGNLXLlDWVEclpv+ItWj+E+SH/JzANtHYEb5qbjvERdLILC/qVNID0T87JC9NVCFqX6dJQzGTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gyeFDHme; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEWvJwZsGsBhiwwVI9ZhDQsUEjpJkGRrvhyoTFCPJPmPWxQ6KWYTf2NlYYpQDLmDvlyzEAENN4tA+dh2TNoZUSEmDRrXZ0yX3gOaMXR6cqNKPMzY30/kbZVE1rtBmNnLA/lUzgFbP/RSCYqS+tdIVGkJuBTKRmC6YOz4vyFV+KY5bbbEWJyu1R6xFns4U021QMJBzG3tLGaVTnUtWyZ3kY7isL7GF/+LoR1a1VF3xJ/RNfDRq2YUetHukR1TQOqE+XAGmjwtuPD+XVvXZ9P46lvN87mtesw0slQykj95Su4aCUR2aI7Pp+UhSOZOryNpG0N+aY4v9X0/qX0dtAZ8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrlaCF6co9hTpSNzhQd7lCiy9Mhu/rrychRRb4Abqj0=;
 b=kCRW1oULQxiibQvAcAV9dhEiVEdrvQM55yX26m8UIQ0lT7a2+AcHzw/ayrc4bKXkwd66XJKURpPONwJ4J/G54hbAGlMMclse98NkY807iVXHjfKPjVcTo5qXRYn0/vTLFoEkgZJiISUqa/7fpjrqvWrhbMXBTi4hM0q7WqatEbObqIQZy9bpApeK48lyS2m2VJ7pEFoqch77cL5F0lJXTSzCkiCM3isx59q/Xv2aFnbu2pagFLFiWpje2DgNInj0Ikt9HuUo03J1FWh3p22gnEAqASDeszma8qztSLCOC0HhS+eOdZfbiRyl0VmSsDDc8VR6Sb2wLsdbc7XoZyBRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrlaCF6co9hTpSNzhQd7lCiy9Mhu/rrychRRb4Abqj0=;
 b=gyeFDHmekUsksGVo7C87vXTYGAB0SpsuDhPN0wzn4MYyhFA84IjTV5BEh080sCBvQ0Etjt6e2Z9LOupSmQUAAm7Y3JQtXHXdRrHZa8r6YlvIx2OHJEmgT0jaYrba/YJriJ4I7H5YW6mQB/IsFVTTmY1mB/C7MITUdH/8kF9/zu4=
Received: from MW4PR03CA0307.namprd03.prod.outlook.com (2603:10b6:303:dd::12)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sun, 1 Dec
 2024 15:38:48 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::93) by MW4PR03CA0307.outlook.office365.com
 (2603:10b6:303:dd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Sun,
 1 Dec 2024 15:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Sun, 1 Dec 2024 15:38:47 +0000
Received: from tunga.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 1 Dec
 2024 09:38:40 -0600
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <gourry@gourry.net>,
	<nehagholkar@meta.com>, <abhishekd@meta.com>, <david@redhat.com>,
	<ying.huang@intel.com>, <nphamcs@gmail.com>, <akpm@linux-foundation.org>,
	<hannes@cmpxchg.org>, <feng.tang@intel.com>, <kbusch@meta.com>,
	<bharata@amd.com>, <Hasan.Maruf@amd.com>, <sj@kernel.org>
CC: <willy@infradead.org>, <kirill.shutemov@linux.intel.com>,
	<mgorman@techsingularity.net>, <vbabka@suse.cz>, <hughd@google.com>,
	<rientjes@google.com>, <shy828301@gmail.com>, <Liam.Howlett@Oracle.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Raghavendra K T
	<raghavendra.kt@amd.com>
Subject: [RFC PATCH V0 0/10] mm: slowtier page promotion based on PTE A bit
Date: Sun, 1 Dec 2024 15:38:08 +0000
Message-ID: <20241201153818.2633616-1-raghavendra.kt@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 85117a61-2dc8-4a21-6466-08dd121e3f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xZlTTaq9Oj/7QG3BYJvZvaAzFkFtAU2iwpbvBJ/zsj7GzaI0JqJ+wCt0voRJ?=
 =?us-ascii?Q?iYwNyX4uXqX22XlFwb8NcsNxVEKwiNBKFYYBE71INoZL8HpHrC+EKqFPWR25?=
 =?us-ascii?Q?vBo/sQydN/BII4mqriwiR0S0iukAWHfLZUy4jh/iDG66PoSsoOdL2RmvpOzw?=
 =?us-ascii?Q?X79mFRSOH1sdi6hDyDL6l0CzMaEOByNyIB0wvc9f8G4Vr0cvYcA8xhlBjKFq?=
 =?us-ascii?Q?6NNZr+JQyw+xTu494EwbP6HwK7KM0G510/CKUypsd8bsgbulCgfMGtwNxhhr?=
 =?us-ascii?Q?V17BuVa3MY3oOr3cp3f9ahMzL9o5T1JoFSoq+vYI2eTNEzji09MKP2OrD3wp?=
 =?us-ascii?Q?FvX6FzvV+z0FCZcx75xDN26ZEQUpINLru1nXP8yfoi3zStPmpWSDeX/xu6F2?=
 =?us-ascii?Q?rRkB+U6BgYc9D/c+m5zlXrp+aX17OSLp0Kr9DSmzYvKPkJv0w8DbgKVIudBq?=
 =?us-ascii?Q?RMOSbT07jLSBMalOHuTKuusf+v50Q2aqL99yfo6W5aDCP5AoPTuXCqEkV6nH?=
 =?us-ascii?Q?1stYQL1et4rhgcG4tur9m4w8yrkDzhHi+6cnKBVDqqcKhKe1puV5S6/w+nDR?=
 =?us-ascii?Q?ZK9hjxnCxfwYERZETOrjuuSsnYmHDZy6/ETY2kwZDCCgYB42Fn8e9cSlgEqq?=
 =?us-ascii?Q?uaJpY1HMnPqeZXFZX3gY4MZW4RAUUD2AQQdOfSA86xOFlgBhQ0xKAjdNFac5?=
 =?us-ascii?Q?ZgVFbUkeSn9OPq175YcN20xe5iy4pbG+dQXZDmHcv+B1nm0fr/WZU3fBpE7z?=
 =?us-ascii?Q?t0xqsd0ysT2En1UuoOov0i7b9SdB/CajkdhmS8qvCj0J5XUJtWHp824buq1G?=
 =?us-ascii?Q?IdOz8OSuPGXg4YhBtalBXtfX5nEV/vY0wWHrjI0ynHn4pM1eb3MNc/qw/kEQ?=
 =?us-ascii?Q?ryPu5+zYGPwGgyIs5RGM5QgirsGLfodeqn3u3LTmcIn8ZoyMNdpUoyhY9Vms?=
 =?us-ascii?Q?/YQDSqplDItazJjfRGPCAuQW2D11nbxfRRkYroNbqgJ5Y+pCcAS4OGEJH5wV?=
 =?us-ascii?Q?CrQ5t7PSn16hxrr+qKdiqX4+HNrg716dN1fd621n6M6xKOd0Vg79bFom+rD8?=
 =?us-ascii?Q?YGopMKx6pfgGYzwrj9Xm5OUaWuq2MCahZcyT2iAZTS2Xo8QcoNBsUlulEZ46?=
 =?us-ascii?Q?redezOStIRlvBrDYO1CgxiN6NIg1Jr5q1TvAPz1GbVUq6+PDCCWltAAs9prb?=
 =?us-ascii?Q?eJWSIl5h8vTM1f84pXVjkd2ZuZaIeBnISXRfIgG+75Oe8yOCcWry3QKB1fjw?=
 =?us-ascii?Q?1Y88r259cjN03nmjUEjRViRNWfA1bc9K66vwT+LmZSJyDG0yvCbagsfkyJE8?=
 =?us-ascii?Q?ktYPflxmxqbMzUHmAuY9NgiCefkW7Ua+xrtBL4SqRAJxzcx/IQ4CAnbRWjuV?=
 =?us-ascii?Q?2ezhR+rn1EzgCLM9htG197nKnFP5YQV9M6vCVwFNr1HkYuWoBKiJp5wgfS0I?=
 =?us-ascii?Q?AtvHkZxf2BgFTzRMYixNTLc84EFMQ6Jk9QxyWkpYTSTCURTThygp9VC2iI4/?=
 =?us-ascii?Q?/KAhOmDKRg0QAks=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2024 15:38:47.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85117a61-2dc8-4a21-6466-08dd121e3f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

Introduction:
=============
This patchset is an outcome of an ongoing collaboration between AMD and Meta.
Meta wanted to explore an alternative page promotion technique as they
observe high latency spikes in their workloads that access CXL memory.

In the current hot page promotion, all the activities including the
process address space scanning, NUMA hint fault handling and page
migration is performed in the process context. i.e., scanning overhead is
borne by applications.

This is an early RFC patch series to do (slow tier) CXL page promotion.
The approach in this patchset assists/addresses the issue by adding PTE
Accessed bit scanning.

Scanning is done by a global kernel thread which routinely scans all
the processes' address spaces and checks for accesses by reading the
PTE A bit. It then migrates/promotes the pages to the toptier node
(node 0 in the current approach).

Thus, the approach pushes overhead of scanning, NUMA hint faults and
migrations off from process context.

Initial results show promising number on a microbenchmark.

Experiment:
============
Abench microbenchmark,
- Allocates 8GB/32GB of memory on CXL node
- 64 threads created, and each thread randomly accesses pages in 4K
  granularity.
- 512 iterations with a delay of 1 us between two successive iterations.

SUT: 512 CPU, 2 node 256GB, AMD EPYC.

3 runs, command:  abench -m 2 -d 1 -i 512 -s <size>

Calculates how much time is taken to complete the task, lower is better.
Expectation is CXL node memory is expected to be migrated as fast as
possible.

Base case: 6.11-rc6    w/ numab mode = 2 (hot page promotion is enabled).
patched case: 6.11-rc6 w/ numab mode = 0 (numa balancing is disabled).
we expect daemon to do page promotion.

Result [*]:
========
         base                    patched
         time in sec  (%stdev)   time in sec  (%stdev)     %gain
 8GB     133.66       ( 0.38 )        113.77  ( 1.83 )     14.88
32GB     584.77       ( 0.19 )        542.79  ( 0.11 )      7.17

[*] Please note current patchset applies on 6.13-rc, but these results
are old because latest kernel has issues in populating CXL node memory.
Emailing findings/fix on that soon.

Overhead:
The below time is calculated using patch 10. Actual overhead for patched
case may be even lesser.

               (scan + migration)  time in sec
Total memory   base kernel    patched kernel       %gain
8GB             65.743          13.93              78.8114324
32GB           153.95          132.12              14.17992855

Breakup for 8GB         base    patched
numa_task_work_oh       0.883   0
numa_hf_migration_oh   64.86    0
kmmscand_scan_oh        0       2.74
kmmscand_migration_oh   0      11.19

Breakup for 32GB        base    patched
numa_task_work_oh       4.79     0
numa_hf_migration_oh   149.16    0
kmmscand_scan_oh         0      23.4
kmmscand_migration_oh    0     108.72

Limitations:
===========
PTE A bit scanning approach lacks information about exact destination
node to migrate to.

Notes/Observations on design/Implementations/Alternatives/TODOs...
================================
1. Fine-tuning scan throttling

2. Use migrate_balanced_pgdat() to balance toptier node before migration
 OR Use migrate_misplaced_folio_prepare() directly.
 But it may need some optimizations (for e.g., invoke occasionaly so
that overhead is not there for every migration).

3. Explore if a separate PAGE_EXT flag is needed instead of reusing
PAGE_IDLE flag (cons: complicates PTE A bit handling in the system),
But practically does not look good idea.

4. Use timestamp information-based migration (Similar to numab mode=2).
instead of migrating immediately when PTE A bit set.
(cons:
 - It will not be accurate since it is done outside of process
context.
 - Performance benefit may be lost.)

5. Explore if we need to use PFN information + hash list instead of
simple migration list. Here scanning is directly done with PFN belonging
to CXL node.

6. Holding PTE lock before migration.

7. Solve: how to find target toptier node for migration.

8. Using DAMON APIs OR Reusing part of DAMON which already tracks range of
physical addresses accessed.

9. Gregory has nicely mentioned some details/ideas on different approaches in
[1] : development notes, in the context of promoting unmapped page cache folios.

10. SJ had pointed about concerns about kernel-thread based approaches as in
kstaled [2]. So current patchset has tried to address the issue with simple
algorithms to reduce CPU overhead. Migration throttling, Running the daemon
in NICE priority, Parallelizing migration with scanning could help further.

11. Toptier pages scanned can be used to assist current NUMAB by providing information
on hot VMAs.

Credits
=======
Thanks to Bharata, Joannes, Gregory, SJ, Chris for their valuable comments and
support.

Kernel thread skeleton and some part of the code is hugely inspired by khugepaged
implementation and some part of IBS patches from Bharata [3].

Looking forward for your comment on whether the current approach in this
*early* RFC looks promising, or are there any alternative ideas etc.

Links:
[1] https://lore.kernel.org/lkml/20241127082201.1276-1-gourry@gourry.net/
[2] kstaled: https://lore.kernel.org/lkml/1317170947-17074-3-git-send-email-walken@google.com/#r
[3] https://lore.kernel.org/lkml/Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net/

I might have CCed more people or less people than needed
unintentionally.

Raghavendra K T (10):
  mm: Add kmmscand kernel daemon
  mm: Maintain mm_struct list in the system
  mm: Scan the mm and create a migration list
  mm/migration: Migrate accessed folios to toptier node
  mm: Add throttling of mm scanning using scan_period
  mm: Add throttling of mm scanning using scan_size
  sysfs: Add sysfs support to tune scanning
  vmstat: Add vmstat counters
  trace/kmmscand: Add tracing of scanning and migration
  kmmscand: Add scanning

 fs/exec.c                     |    4 +
 include/linux/kmmscand.h      |   30 +
 include/linux/mm.h            |   14 +
 include/linux/mm_types.h      |    4 +
 include/linux/vm_event_item.h |   14 +
 include/trace/events/kmem.h   |   99 +++
 kernel/fork.c                 |    4 +
 kernel/sched/fair.c           |   13 +-
 mm/Kconfig                    |    7 +
 mm/Makefile                   |    1 +
 mm/huge_memory.c              |    1 +
 mm/kmmscand.c                 | 1144 +++++++++++++++++++++++++++++++++
 mm/memory.c                   |   12 +-
 mm/vmstat.c                   |   14 +
 14 files changed, 1352 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/kmmscand.h
 create mode 100644 mm/kmmscand.c


base-commit: bcc8eda6d34934d80b96adb8dc4ff5dfc632a53a
-- 
2.39.3


