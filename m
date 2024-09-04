Return-Path: <linux-kernel+bounces-314845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC596B9E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04C2B2752E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82531D0965;
	Wed,  4 Sep 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UVr3VzKq"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B371D589F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448366; cv=fail; b=PTFXQdbfXzsPTj7hoc4qz4CufGVnxF6DdDen05OYAhQf2sPWMPrVpmrZxUrowV8slnmvnvbGtiCq741dawL9rJG40DH5vbTMaAmJ7Pac7PQk6Vpz/dEbfRvnyCTTHtjGfGqGHIjjBAN3Mfy/r7Fvbtc0Q3EC4bkbtNk9HbKw/ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448366; c=relaxed/simple;
	bh=em4kgM1pFu4N4krLJheHQwlvBtkqMk+M8MTVaHseYuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qxvKPYkFolRYp557QftSlLLjbvnzYZQg2a596b5X8g1k3w7Y1LrumS+qx6l0Pb3pXsU3RQuMLeMGRjiQkQXtLnfmph3ogGB9pKVAZmEEiYGGHzWlXdU9UANk+S86drpcqGSw9u697h1W23j/qYH2A1w96D7Dn5vTXRPO1Iq1UPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UVr3VzKq; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCEkUEm75VeI++NV/84cRu9wCweXdBwbqZtjwOliTRWQUNCXi1HNgXqj+hAGpOfDUKdbR8W81HFiGWJPB3SwWWcHuRluFOikV6CRix6zugcp2ZlxrTYPOIBRB8msMPrdU5rO/ht/dqAvbH5OUJwLl/Uk9N3MWvPTJBP9pOQD42MJ4gCw7wl/3HDjeVj9ksx4AnsVUjNxKeiz/ELA1fKgIyxaWK1V/sBTqopqxpvcjpzmLstTeBdn1tDp5d+c7CScvnsjWPEGFxEI1ud8zsDQMOmHjkDHYyGv2y9T+u27wsCoIwBlnBD+D+g8/1x7pfJKiRtaT5Jq48wNaNVQKQ8vuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddQ5woWKr8adNyrdt/uzN7u4f6rD/AKUagiJDKa9q1s=;
 b=bHAMVLeVlilQBBmKobLMSZU94fggyvDw1J096PkMzWgF5olaozs44XG3imPqLLhD29prGYX4HnNVpKlib4pDx7HnoUMPn3fsRHXdtso2gigvHDEwTO9YEjkzabaBP6LXk4V03agNIk4ew36Y/rB+LV05V+Ivy2xdjE4187AyyM33/EtOdwrODtA3+wVwXH6EmUiWdsUOlkvWmhpP8wjp7LnmNHdco+CkAF9DpG5nat3XqGFyX3lW0YRjKo9ZcYZv16DrDISM05pNNp5YE+F/BgOeD+QkC8v1UmWD97nmPpXs5wAjMxSu6/12XlkbrMEW1S8eqTtvbh+SSkFUIE5FrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddQ5woWKr8adNyrdt/uzN7u4f6rD/AKUagiJDKa9q1s=;
 b=UVr3VzKqX3bKttu8tkXtnFiXjizF9Xy4TuJ87BdQZq5FCsuGfsk43ET/yV0iQeYfr+oI4UQ1LvxpS5T+5xRZsi02J7zhKVjKj5WZTucdD3p+K7qT8GuQ6Aei1rkvq2DvaV3HF1uIrKls8Kp2ua/vvALS0SVmebBJrR6zEIHPqc0=
Received: from BN8PR15CA0065.namprd15.prod.outlook.com (2603:10b6:408:80::42)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 4 Sep
 2024 11:12:38 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::63) by BN8PR15CA0065.outlook.office365.com
 (2603:10b6:408:80::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 11:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:12:37 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:12:31 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel
 Gorman" <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Thomas
 Gleixner" <tglx@linutronix.de>
CC: Leonardo Bras <leobras@redhat.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, Thorsten Blum
	<thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>, Tejun Heo
	<tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Caleb Sander Mateos
	<csander@purestorage.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Chen Yu" <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>,
	"Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Subject: [RFC PATCH v2 0/5] Idle Load Balance fixes and softirq enhancements
Date: Wed, 4 Sep 2024 11:12:18 +0000
Message-ID: <20240904111223.1035-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 587a64a2-ca6d-4406-917f-08dcccd27c35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FsI0KHrYMpR8lU5+mPxtI21qSLrto8Dy7AzVTf4I7S8cIC4Bj5rCA3uCkila?=
 =?us-ascii?Q?gZn70IhVXT+0HzvHrwmf4O4hsVL94X4Xe6Xg01X/VtLcTgLe+x/avBSz7z6d?=
 =?us-ascii?Q?kjqmdhi/2jibcG1tTcmPxdLmYrE/8I5GcHfJdlvD4yI4OXUo6XtkKZXT6HWh?=
 =?us-ascii?Q?Eszqb+YF9D59QBe+niebDJiK9t3h/gIDbxdgibU3TXVTHxkk/zTjd778QTZc?=
 =?us-ascii?Q?vtsewVbvK1v5M80eq1zGvhI28SYuMCyUvRVPLUsA8k5Vp6YfsMARXHxsfIw4?=
 =?us-ascii?Q?/a5U/2Yp7VqL9rh3Mb3mf9F2weyyQooS1hYxVptvR8Ik3gsYmq5gzX0HZyKK?=
 =?us-ascii?Q?4DfCkjIo8hWmdJ32FzRZG4AOD6e5pjuqwGES2Vb6HPN31kI3mvclZllJdJgq?=
 =?us-ascii?Q?8ejX4Q1sDIQl0XO1P2VS400OI3p+ZerFpa1IYgxqzP8TFf8f47JtLwhHUfFP?=
 =?us-ascii?Q?aeNTFFCU9fiJXgQxd7OD4+g/i3SYxzPYZ7LHYJQ9+cMoqYF46POKmzkTD7LG?=
 =?us-ascii?Q?/qtiyxXzKBNh6gRne6v5mGE9K91gnccKhZ1JlNyu6hZH3GvFuklW9OlsXiws?=
 =?us-ascii?Q?hkkBWnCldHKfE/ngJuiVZaZZKYgFLNUIjUqlvFvW3qUprjy22r1PBFdnq19T?=
 =?us-ascii?Q?sHTh0Wq73EiE67ZECmuQYmvMlCObuoQOmvY3D5KPivKb8HWUO9oWI46uT10r?=
 =?us-ascii?Q?qTiHI0e2/Yy4HxCWdZyC5/aySmzLNJChDQbUrSk+gZPnPTb7WncXtfmYmVWn?=
 =?us-ascii?Q?dS/Y9J0AMg+cFh1Re8Z/ANHHvwPQ7/TwEspXoilgKlr8aUYIQ8jTvPlM3ToJ?=
 =?us-ascii?Q?qTptb/j5JT1kCblDN+UnseVjPmrnzfEs0/Hmnn/OYpcZuwjecE65vpR3CRSb?=
 =?us-ascii?Q?u+c3mloqox/KedI5yqV8huFw07g9RkUll+MooHyzxHNgekmKi+/xF9ECT9TP?=
 =?us-ascii?Q?tlnK1RvDMld0m8KqdzwY06JosG2p2QqqCSmtkvNBbBOVfCkkIeDdUimXLv3L?=
 =?us-ascii?Q?dg2SOEcg6LbL7apLyvtkj8nri3z/PtLMnwbcqM87pGqVRqVg3oCarCRntr+8?=
 =?us-ascii?Q?4v3plHOzw38LtIi/VMfEOWcQVfEiD4JV7aY9j4120o1UByfP7cYjOvHMkBJ7?=
 =?us-ascii?Q?hNEMLDBRDlCovlVXeSe3plvKVY4BYdr8VHwHfBbjhITJfpOZUlPYbRP7erXK?=
 =?us-ascii?Q?8ccV6oDAODmFBfKXf9MHujWofTtmQjvDcv5Oye+u5WXL/psFk1w6URZuHSEW?=
 =?us-ascii?Q?+2bRHZTkkhm4Kg79VfWUjRyYjNTdZkf42E/Oy27W4JnMIds6MLYy3jVn+Zlp?=
 =?us-ascii?Q?Oe2LkoiyFWMqJV2AFAsgfx++ySRTWri9CLcMi8jkjd2JlBeQw61f5ZQYwWxy?=
 =?us-ascii?Q?RV4SETSUkX/N5O7JpMaHgnOb2b6tzHhbdlKiy76PyRagEp0PnSOht3KhOlpv?=
 =?us-ascii?Q?GBbBwwatuhee4Je4PQ+JIPlyDpEStmN4B95EJsfSLc4BMcURMyIIGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:12:37.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587a64a2-ca6d-4406-917f-08dcccd27c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

Hello folks,

Sorry for the delay in posting but this is the v2 of idle load balance
fixes, the previous version of which can be found at [1]. This was
broken out into a separate series since it tries to modify some
PREEMPT_RT bits that requires some clarifications on, hence the RFC. So
without further ado ...

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
   CPU appear busy since ksoftirqd just woke on the said CPU [2].

Solution to (2.) was sent independently in [3] since it was not
dependent on the changes enclosed in this series which reworks some
PREEMPT_RT specific bits.

(1.) Was solved by dropping the need_resched() check in nohz_csd_func()
(please refer Patch 2/5 for the full version of the explanation) which
led to a splat on PREEMPT_RT kernels [4].

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
and unifying should_wakeup_ksoftirqd() [5]. Patch 3 and 4 prepares for
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

base: tip/master at commit 5566819aeba0 ("Merge branch into tip/master:
      'x86/timers'") based on v6.11-rc6 + Patch from [1]

   ==================================================================
   Test          : ipistorm (modified)
   Units         : % improvement over base kernel
   Interpretation: Higher is better
   ======================= Intel Ice Lake Xeon ======================
   kernel:					[pct imp]
   performance gov, boost on			  -3%
   powersave gov, boost on			  -2%
   performance gov, boost off			  -3%
   performance gov, boost off, cross node *	  -3%
   ==================== 3rd Generation AMD EPYC =====================
   kernel:					[pct imp]
   performance gov, boost on, !PREEMPT_RT	  36%
   performance gov, boost on,  PREEMPT_RT	  54%
   ==================================================================

* cross node setup used CPU 16 on Node 0 and CPU 17 on Node 1 on the
  dual socket Intel Ice Lake Xeon system.

Improvements on PREEMPT_RT can perhaps be attributed to cacheline
aligning the per-cpu softirq_ctrl variable.

This series has been marked RFC since this is my first attempt at
dealing with PREEMPT_RT nuances. Any and all feedback is appreciated.

[1] https://lore.kernel.org/lkml/20240710090210.41856-1-kprateek.nayak@amd.com/
[2] https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/
[3] https://lore.kernel.org/lkml/20240809092240.6921-1-kprateek.nayak@amd.com/
[4] https://lore.kernel.org/lkml/225e6d74-ed43-51dd-d1aa-c75c86dd58eb@amd.com/
[5] https://lore.kernel.org/lkml/20240710150557.GB27299@noisy.programming.kicks-ass.net/
---
v1..v2:

- Broke the PREEMPT_RT unification and idle load balance fixes into
  separate series (this) and post the SM_IDLE fast-path enhancements
  separately.

- Worked around the splat on PREEMPT_RT kernel caused by raising
  SCHED_SOFTIRQ from nohz_csd_func() in context of
  flush_smp_call_function_queue() which is undesirable on PREEMPT_RT
  kernels. (Please refer to commit 1a90bfd22020 ("smp: Make softirq
  handling RT safe in flush_smp_call_function_queue()")

- Reuse softirq_ctrl::cnt from PREEMPT_RT to prevent unnecessary
  wakeups of ksoftirqd. (Peter)
  This unifies should_wakeup_ksoftirqd() and adds an interface to
  indicate an impending call to do_softirq (set_do_softirq_pending())
  and clear it just before fulfilling the promise
  (clr_do_softirq_pending()).

- More benchmarking.

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
 kernel/softirq.c    | 97 +++++++++++++++++++++++++++------------------
 4 files changed, 71 insertions(+), 39 deletions(-)

-- 
2.34.1


