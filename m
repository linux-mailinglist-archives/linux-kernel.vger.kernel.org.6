Return-Path: <linux-kernel+bounces-363608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4299C4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6732E1F21211
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094AD156256;
	Mon, 14 Oct 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ocC8tDUI"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCBC14A0AA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896656; cv=fail; b=jEUx6mLiwye2yCYXLuYsQVGzUTd66khzN6qlssjy3xaRNVPJq8jooTSEIFa1rmW635wU4XFS+r5j4HuBtNvvOTXlpCHXYs38wo/sl2aHwAnmx9ALV88pvmjQWktoVAD3NcHtbv4If5KyVUeUa8besBGji93tDR5Jek3Po/BdtOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896656; c=relaxed/simple;
	bh=nx+D2Z2CdNE24FPLVY0oYwfLzIwVEUBgGr8RvPnt4vQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JRQOVbk6JgOX9YQFTTLFu9uqP1hBiJj2Tj0E/Kd3BoGVS5cUgNlmYsYs43Mw2Q3X0/J2bQ6GbmOsh6FSRTaNxIswHDSYuo9k3J9V7Y3bBe8VZRx/5fe8/CSeiF0nPrRbtiT60qudIe9DO/5UEx/tQJuiPE2hKZO5oWxF1DGrMFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ocC8tDUI; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QN+a4F5TQ5fIVFMpsF0v2YqkeMBRcPM0KN84OIt0pnQkahYg2hUG9S3awN/tmkJFUV+HlxpGvGd3vUt8UlAcGvsMU4ZfkiJFk+lrKXPoOtDumRHFEsEr5RmtbF/auAeYBWcJuldLTrl7MyQCcPiZLiNdOGPUTTetKj0f9BTrcXaVu7gDJWCtIpZVoxzHZ6110qRXJQHbvan52ObIQswcHEaxblmcxqncX81ybe/rxvyi1dOFu/3HY9uJOvhcRKN6vVwYgflGNQ/ew9Vq9bT5Ve5uFJU1UFW1ADALIpt8WBBALbucsJfDbbwIP47mvp+ySm3KsZp+8GhuF6cxtbUBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2A/6LhQdO5sXRBZIl5TMO84RZujyHcMFPU0kwQ0TuQ=;
 b=B73kjIt2V9Fc+A+PHridmH75BUdMAf7pTHqbNMFKR2Zq7Xm70HoBur1LhCK7IsyeIt8LHdOeE/NcnL/C2jgBaoZ5xoG74t+4zd0oNfHIOlErFN00/8MQOuEku8nO/AGolGA6DkyKOEBbSfM2cop5UL0EexqfAhzA4kBgO3XbxyfXGoE95wDsWTDn8BWev0i4H9IvfEFXMB/rtMlX15CSgKca3OgEGQtZCzfWjvInThlml3332CCreszBGeuf2p334i8b+406qoEyo+Af4zgJ/zn5UtndmsbMDiLf26OpQUUV59gIyqwjBfPK2vhvZAvyWwH/fh8V5OrZzWiYVy56uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2A/6LhQdO5sXRBZIl5TMO84RZujyHcMFPU0kwQ0TuQ=;
 b=ocC8tDUIMdK+FUUWJRKw7jKPYNG0Guzd6vsPeRngAlBRI6QoV3mQO+CUx9ba960E3td0ryaxS1RsgtvYXqy+5Iiw9DVmV6G5AIRsMyZjUl0fJ8VvL2mBWYr0J7ECnpqNwZPEj+Obl3kS1ijnIMJgaoQQbKIUoYK4HaIWwl+3n7Y=
Received: from CY5P221CA0149.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::9) by
 DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.18; Mon, 14 Oct 2024 09:04:09 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::69) by CY5P221CA0149.outlook.office365.com
 (2603:10b6:930:6a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 09:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:04:08 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:03:58 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, Leonardo Bras <leobras@redhat.com>,
	Thorsten Blum <thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>, Caleb Sander Mateos
	<csander@purestorage.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v3 0/5] Idle Load Balance fixes and softirq enhancements
Date: Mon, 14 Oct 2024 09:03:34 +0000
Message-ID: <20241014090339.2478-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DM4PR12MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: b6861efa-5876-458e-7b16-08dcec2f29f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LqXcXWfbtEhjOEf50jcTBlmYxlNitaFurY+2V5WB7wTDWU6FOaGghU4XMOwP?=
 =?us-ascii?Q?8FNqcFoznb/md7O8noa5w8eIkkDSAX5A4+Lgqu437qC9JsdOsKIk61msY/3n?=
 =?us-ascii?Q?XzJBJ+vQjvKTHxITqpgQJJAcvAPlTBSpTGL6KZEmMWfiXW1NIRvr0TDHn4to?=
 =?us-ascii?Q?xHeaGpb5DjqWUc1AvL8KWVSw/kIz2qQHb4DKZUSkPh77FxCv6jTd/d5KxcV4?=
 =?us-ascii?Q?IgAIg3rPQxAR/9fXek9CFU5gFlzdog3t9Pcf1a/F5x1AyGmgTa8oF7VDAu2o?=
 =?us-ascii?Q?vHNnFwad8ymKCw+7vLJ+UcGx0rs0us0CvBLfhhfRF7lHIqW+75HVyQSYnYMK?=
 =?us-ascii?Q?A/8IoUIB5z8Kc5z3TUZOtltEqbE4TnqZX9BfoF7b9VW4ZK5N3Kx+xjtrWhe7?=
 =?us-ascii?Q?LKWPS8SprOQST7vd1Rwad2Lr3SRxkoECaL3pt+2dXD/7qXiMBqXqvpYpkPbZ?=
 =?us-ascii?Q?eWcQBi95pMOhUwkrXKvoXh5wjYEKhQPl1SmAxaB1E+oXr0B1tRkYrEyJ/a8B?=
 =?us-ascii?Q?lq3TIN64SUSY8d6Ur9eMjc+3mJuYiNDhtAI//J2QkZDNPb3p10i9tCQJoc2Z?=
 =?us-ascii?Q?Dg/ay7YnY8HRgV8VBNgoWR7NqqSxlyuLhthb7vX6Usgs6+96LswnQ+xo0YR5?=
 =?us-ascii?Q?NDRQDqUGQ3UJW9Bqs87iOQT7yTAMalw8iSB8ASEaU5knj3BNPCrJ0UI9eTa5?=
 =?us-ascii?Q?7rpCWmP75+lgJqFU+88NGc5vH2En66YXGoxQ45tC6aHGRsiSiYqKVqslbmg8?=
 =?us-ascii?Q?N0uFJrzkFFujal5YjHU3OW8N+VXJPNyzkOs9lYWhoXyXF6Cd//PpVA4C4PGo?=
 =?us-ascii?Q?dWbwj/04aPanc4ULg7BNGSS4z/mjQt+FsATa73hKrca36gOCtfOrcMEHdhHd?=
 =?us-ascii?Q?UA3X73uSNl5PH4PmzilumpcCNEDp6x7N/mFeAknrNF0wgPlk+qRXVfc7JNGu?=
 =?us-ascii?Q?LiY6vsbJzwCak8zCJAan1TnkVmipP8Y3IdgY9r7FuWv1I5raA+Cw1L29N5Gx?=
 =?us-ascii?Q?bWy2dv4ndtZ+m0skWyG4e4+ABbHm00asGyPzOjZ/4ezFU7MlDZvjtxbvUluK?=
 =?us-ascii?Q?fWbnKe0LPF8r/y93kcxQQsxbYet8BkAtzifpleurA8GciES4/dun54a91byj?=
 =?us-ascii?Q?Tiy5CToLE1ocp2Lj884Q5o511tijNHzXmLJ62FmCxWzA0VXnwm92qJ7dGTm1?=
 =?us-ascii?Q?iB2k4ZOOcL0wYjAW7Klh8WEVpxB6c3fwYZKFBJN0ISFhMkKxNdE8cLLszrbf?=
 =?us-ascii?Q?iqtv7F4HCcCMPSQGQ1h9OLlS6/DXlBR80pp3auG7cptUnGKDTCEYZQRe1gxn?=
 =?us-ascii?Q?tLm6kUWhiyJGACLAzV3e5d3yPXO6KyK08b4s478qyWHMBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:04:08.9686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6861efa-5876-458e-7b16-08dcec2f29f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327

Hello everyone,

This is the third version with minor changes from the last, and some
more benchmarking data down below. Any and all feedback is highly
appreciated.

This series is based on:

    git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit 7266f0a6d3bb ("fs/bcachefs: Fix __wait_on_freeing_inode()
definition of waitqueue entry")

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()"), an idle CPU in TIF_POLLING_NRFLAG can
be pulled out of idle by setting TIF_NEED_RESCHED instead of sending an
actual IPI. This affects at least three scenarios that have been
described below:

1. A need_resched() check within a call function does not necessarily
   indicate a task wakeup since a CPU intending to send an IPI to an
   idle target in TIF_POLLING_NRFLAG mode can simply queue the
   SMP-call-function and set the TIF_NEED_RESCHED flag to pull the
   polling target out of idle. The SMP-call-function will be executed by
   flush_smp_call_function_queue() on the idle-exit path. On x86, where
   mwait_idle_with_hints() sets TIF_POLLING_NRFLAG for long idling,
   this leads to idle load balancer bailing out early since
   need_resched() check in nohz_csd_func() returns true in most
   instances.

2. A TIF_POLLING_NRFLAG idling CPU woken up to process an IPI will end
   up calling schedule() even in cases where the call function does not
   wake up a new task on the idle CPU, thus delaying the idle re-entry.

3. Julia Lawall reported a case where a softirq raised from a
   SMP-call-function on an idle CPU will wake up ksoftirqd since
   flush_smp_call_function_queue() executes in the idle thread's
   context. This can throw off the idle load balancer by making the idle
   CPU appear busy since ksoftirqd just woke on the said CPU [1].

Solution to (2.) was sent independently in [2] since it was not
dependent on the changes enclosed in this series which reworks some
PREEMPT_RT specific bits.

(1.) Was solved by dropping the need_resched() check in nohz_csd_func()
(please refer Patch 2/5 for the full version of the explanation) which
led to a splat on PREEMPT_RT kernels [3].

Since flush_smp_call_function_queue() and the following
do_softirq_post_smp_call_flush() runs with interrupts disabled, it is
not ideal for the IRQ handlers to raise a SOFTIRQ, prolonging the IRQs
disabled section especially on PREEMPT_RT kernels. For the time being,
the WARN_ON_ONCE() in do_softirq_post_smp_call_flush() has been adjusted
to allow raising a SCHED_SOFTIRQ from flush_smp_call_function_queue()
however its merit can be debated on this RFC.

With the above solution, problem discussed in (3.) is even more
prominent with idle load balancing waking up ksoftirqd to unnecessarily
(please refer Patch 5/5 for a detailed explanation). v1 attempted to
solve this by introducing a per-cpu variable to keep track on an
impending call to do_softirq(). Peter suggested reusing the
softirq_ctrl::cnt that PREEMPT_RT uses to prevent wakeup of ksoftirqd
and unifying should_wakeup_ksoftirqd() [4]. Patch 3 and 4 prepares for
this unification and Patch 5 adds and uses a new interface for
flush_smp_call_function_queue() to convey that a call do do_softirq() is
pending and there is no need to wakeup ksoftirqd.

Chenyu had reported a regression when running a modified version of
ipistorm that performs a fixed set of IPIs between two CPUs on his
setup with the whole v1 applied. I've benchmarked this series on both an
AMD and an Intel system to catch any significant regression early.
Following are the numbers from a dual socket Intel Ice Lake Xeon server
(2 x 32C/64T) and 3rd Generation AMD EPYC system (2 x 64C/128T) running
ipistorm between CPU8 and CPU16 (unless stated otherwise with *):

base: tip/sched/core at commit 7266f0a6d3bb ("fs/bcachefs: Fix
      __wait_on_freeing_inode() definition of waitqueue entry")

   ==================================================================
   Test          : ipistorm (modified)
   Units         : % improvement over base kernel in IPI throughput
   Interpretation: Higher is better
   ======================= Intel Ice Lake Xeon ======================
   kernel:					[pct imp]
   performance gov, boost off, idle=poll	  -3.86%
   performance gov, boost off, idle=poll *	  -3.32%
   ==================== 3rd Generation AMD EPYC =====================
   kernel:					[pct imp]
   performance gov, boost on, !PREEMPT_RT	   1.07%
   performance gov, boost on,  PREEMPT_RT	  19.51%
   ==================================================================

* cross node setup used CPU 16 on Node 0 and CPU 17 on Node 1 on the
  dual socket Intel Ice Lake Xeon system.

Improvements on PREEMPT_RT can perhaps be attributed to cacheline
aligning the per-cpu softirq_ctrl variable.

Julia Lawall reported reduction in the number of load balancing attempts
on v6.11 based tip:sched/core at NUMA level. The issue was root-caused
to commit 3dcac251b066 ("sched/core: Introduce SM_IDLE and an idle
re-entry fast-path in __schedule()") which would skip the
newidle_balance() if schedule_idle() was called without any task wakeups
on the idle CPUs to favor a faster idle re-entry. To rule out any
surprises from this series in particular, I tested the bt.B.x benchmark
where she originally observed this behavior on. Following are the
numbers from a dual socket Intel Ice Lake Xeon server (2 x 32C/32T smt
off):

   ==================================================================
   Test          : bt.B.x (OMP variant)
   Units         : % improvement over base kernel in Mop/s throughput
   Interpretation: Higher is better
   ======================= Intel Ice Lake Xeon ======================
   kernel:						[pct imp]
   performance gov, boost off, idle=poll, smt off	  1.09%
   ==================================================================

I did not see any discernable difference with this one over the base
kernel.

[1] https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/
[2] https://lore.kernel.org/lkml/20240809092240.6921-1-kprateek.nayak@amd.com/
[3] https://lore.kernel.org/lkml/225e6d74-ed43-51dd-d1aa-c75c86dd58eb@amd.com/
[4] https://lore.kernel.org/lkml/20240710150557.GB27299@noisy.programming.kicks-ass.net/
---
v2..v3:

o Removed ifdefs around local_lock_t. (Peter)

o Reworded Patch 1 to add more details on raising SCHED_SOFTIRQ from
  flush_smp_call_function_queue() and why it should be okay on
  PREEMPT_RT.

o Updated the trace data in Patch 5.

o More benchmarking.

v2: https://lore.kernel.org/lkml/20240904111223.1035-1-kprateek.nayak@amd.com/

v1..v2:

o Broke the PREEMPT_RT unification and idle load balance fixes into
  separate series (this) and post the SM_IDLE fast-path enhancements
  separately.

o Worked around the splat on PREEMPT_RT kernel caused by raising
  SCHED_SOFTIRQ from nohz_csd_func() in context of
  flush_smp_call_function_queue() which is undesirable on PREEMPT_RT
  kernels. (Please refer to commit 1a90bfd22020 ("smp: Make softirq
  handling RT safe in flush_smp_call_function_queue()")

o Reuse softirq_ctrl::cnt from PREEMPT_RT to prevent unnecessary
  wakeups of ksoftirqd. (Peter)
  This unifies should_wakeup_ksoftirqd() and adds an interface to
  indicate an impending call to do_softirq (set_do_softirq_pending())
  and clear it just before fulfilling the promise
  (clr_do_softirq_pending()).

o More benchmarking.

v1: https://lore.kernel.org/lkml/20240710090210.41856-1-kprateek.nayak@amd.com/
--
K Prateek Nayak (5):
  softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT
    kernel
  sched/core: Remove the unnecessary need_resched() check in
    nohz_csd_func()
  softirq: Mask reads of softirq_ctrl.cnt with SOFTIRQ_MASK for
    PREEMPT_RT
  softirq: Unify should_wakeup_ksoftirqd()
  softirq: Avoid unnecessary wakeup of ksoftirqd when a call to
    do_sofirq() is pending

 kernel/sched/core.c |  2 +-
 kernel/sched/smp.h  |  9 +++++
 kernel/smp.c        |  2 +
 kernel/softirq.c    | 93 +++++++++++++++++++++++++++------------------
 4 files changed, 67 insertions(+), 39 deletions(-)

-- 
2.34.1


