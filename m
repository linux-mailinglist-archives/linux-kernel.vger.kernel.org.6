Return-Path: <linux-kernel+bounces-247309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919C92CDD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4DC288083
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFB18EA86;
	Wed, 10 Jul 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zeraSVSy"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E247CF34
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602207; cv=fail; b=uT3DXtdctiBac9Sw9Qdp1FEPU1SmjTpS0XghO1gQmGlO8pyjjDte9hSo/RQSnZipy1jmCqdMz+3ASy8AARjpzfHbNKdgraZMjohjdubwou37FuAJj9ZxW48sBiHE3XfM7nWWdlT5vZca5Z1qv6TYeKdgK1eaA9mImNwJTBaUNrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602207; c=relaxed/simple;
	bh=UC4FDmo69ycTukrS0/gZy43E75L/Y/qTWjtFzEFZWx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erdrgtTCJK8Wygouq1SUBx4NBOVh27hGG6g6AxJKuh2xYaolMIEzikowGGuLqNcfuwtFoZtPmtRVxIelI2f1oCBen1dgK6jJ1ELyn9EH3qHmtdjUuNTmbffyWf3DnXlHsbWIHkTxc/26fvVLHrCoQl8AfYo8sMUj4eoc2pPyj6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zeraSVSy; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR201yodsIdNV2X/qqNoeLwtPfK9VV5F6cB+zYC0DgezgDkQk484k5dd7+pi5AW+MkpSo8JgeA6sae9QXDmmjfx9OXCy7xaxWidbmYytqpIM8Nzug1+BubDdeXBJc4h1EnKMDruczc9rMMvt0ZLh3JZ37fbh4N3mL2+7aEoM1mLPyUao1Lu1DE0bro17a1+7ZA8gU8+ksNMtSuYw66lKZeyQufBpYbJZoJIXNbqUeorS5/vQQdGlv+9yp0oB7wKRwD5zkYLo7DJVA/EO61sWsG7nRVYGkB1Wu/8pUQxzBNNiwzJG5RcjctzaF7zqDEmFCJWWCUGV6y0BMEarFUkAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptLK9mZRaMilTR7o9l/Ccg1evNOzH1IZS91OMUWI5ls=;
 b=MR99LXTGIzege5uM8uo+WMVXqeSngAotOA/bjv0Hk8qoXHItGdgsvxixWd/hyI9R9q9hXhrLve+tBcD0DvAFhlZac1pi1jBT1cZN/LgsySto5LyrF/s16+r0cJGrlSEniQvcNwdBIN4v6NOwPEs8Ufh0Rvby/yk87qRUJTekA+xvfTIJlBWi56U39I5U+9VQobs2lDMHl3oBy1A8liZcTZe1XC4qkv3+cz1G8JW43ClwclokugiwU6AlOJEECiCNMVxxMUSjY9xPGL0cdL7Aa/Ukulr49eYI3NTlGACg4VKsQkRJkwt3ia2Ycu8KYKX/nU1paOx1psQ9QwBaw9iwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptLK9mZRaMilTR7o9l/Ccg1evNOzH1IZS91OMUWI5ls=;
 b=zeraSVSyKaDUUMDUwhVGFqIN2B0q0MCX6A0POrT9Vo9D+I1oKVxgrxZo6Lxe9wjT1/fZfl/r2BW5KkjygjibKWi6IiPPsGqGNZhhAmhJcqKIhfv2LHDBsEjfEhhxpmMglEA57iooRyMNGuQ9ffOYk5XkRJIVH7aDGINJCDkogrg=
Received: from CYXPR03CA0050.namprd03.prod.outlook.com (2603:10b6:930:d1::15)
 by MW4PR12MB6850.namprd12.prod.outlook.com (2603:10b6:303:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 09:03:23 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::76) by CYXPR03CA0050.outlook.office365.com
 (2603:10b6:930:d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 09:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 09:03:22 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 04:03:15 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>, Leonardo Bras <leobras@redhat.com>,
	"Guo Ren" <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, Tejun Heo
	<tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, Zqiang
	<qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH 3/3] softirq: Avoid waking up ksoftirqd from flush_smp_call_function_queue()
Date: Wed, 10 Jul 2024 09:02:10 +0000
Message-ID: <20240710090210.41856-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710090210.41856-1-kprateek.nayak@amd.com>
References: <20240710090210.41856-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW4PR12MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cbc8f5-21dc-4153-5571-08dca0bf26cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cjk92EXwbgfUxx0Lr5qb5Y0aJieVyDDnS7m82amyAQxma7ff1phTH7w0zVS5?=
 =?us-ascii?Q?oOi0+MU+y8E+5VsdGgjFKwgBsp/BRrPmneJ4IRuHzZwXmwaR8EfK8EPU5mzw?=
 =?us-ascii?Q?IoJomsRCnMrbhSLkfS0gKnnORZKRcckwOixfmZY9o5DbBap8oHveQhmgWiCL?=
 =?us-ascii?Q?5qpcPGPG7T3oCfkjqBWpalp0QaR28Q/YBina5BN2+liShadWSu0B9HDfaUnA?=
 =?us-ascii?Q?USMrhhxOzpW16SY/11xcdPnf2IX/jnLw8gox3y991Zyi/Fw7Q0psAkLIry6N?=
 =?us-ascii?Q?63CEjwG4ekGeY2xCktPfo8JV9I/C19q9QD4znt+q0m9gcbv9jepwdGf6Zlmc?=
 =?us-ascii?Q?JGo+rohdKHFVYQFIxpx9scfsRV7G5gtvCklYV6Me4YeXBhP5rSgaqaQncG5F?=
 =?us-ascii?Q?6y4uHbijaD6daviwQ+c+hHMCI2Sd3+nGC5IEe41J5gNgCEeNaF+LvfoErpew?=
 =?us-ascii?Q?10L6/rjg8UvSr1WlT3Gw1GEbLOsz70bhW7+cj3nrqFeyN9B+mZ85OWO0VvOT?=
 =?us-ascii?Q?5vsT8PXKvbNo8eB1So+49d60QonbuZ2PQwhxxZ2yyq6cgW2nXOYLqszTPjRP?=
 =?us-ascii?Q?SAivIIXIySH3GtTHi74N3E+WQnZGWOAw/gYu/M/0RQkK35vMt9OB99+v5H6l?=
 =?us-ascii?Q?aD9ZZxywciM7G1wweX1cxHmGQ/ZKkexC3z2bU0E+aN8ueHAJyJKpyXzyapPj?=
 =?us-ascii?Q?0UcmHlwX5rZRvlfBxb6potboADh9toOaBJsG9gEJO/CIdqr95E3/lDyCpCbV?=
 =?us-ascii?Q?OZfeMzDyuz/gpZK1jaNhe+ONdlvyTyv2Zdu/ig1pTFwLTt2JCSavLY3bD4g5?=
 =?us-ascii?Q?krwBQiQ9fZfc5+5BKzkWydHDALIBTCudxOOkKfpOAuZJlZfriV2X2uxweI8e?=
 =?us-ascii?Q?TyawROrbOyR94povYxXtGGZJ1RhlR4rjmVxA0DOfkqoNHbnkTZyClT9mwetx?=
 =?us-ascii?Q?3by2P0a4PSlnhHTQWXJ0QD8PJ1IYeZk+7HXwjlJDeydoxzK+8ZvlJ+VO7UEn?=
 =?us-ascii?Q?fCa+iXVhFfQ4GjTh+ia+rlOre4ybo4zbzY+HSnBQcuntVRxiIK5MGve5T+a0?=
 =?us-ascii?Q?n3ANU06kZ+FeGDaeNUHF+2ZNtWcHTpNohAPGcZVxm4oWoB88hVmw9/4uFtz6?=
 =?us-ascii?Q?OpFe7q+JadMZ7hULLHQ21ZnLz8wQCBYwYTadZ6+UCHZoz5PbIBLuDLP3sOiX?=
 =?us-ascii?Q?paE+gaPfavuVlSBBJScLpIFlMT+qT99XkEdo3tu+q/Bj1jJ64xUPTRiHsF61?=
 =?us-ascii?Q?q4abY1zcPTbkY2YNsTWQZjGxyd7oGmrkeomK/V7ACSwBNGa5ON/cOA8oFZth?=
 =?us-ascii?Q?V3AiJdUIAwmV77mn7MQu3gJS2PUHWSwlAUVqavUCer8rIxRHjDORfDC0IEwV?=
 =?us-ascii?Q?Y7JgsByU41LL1u22Kx3g9AVBR1gT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:03:22.7703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cbc8f5-21dc-4153-5571-08dca0bf26cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850

Since commit b2a02fc43a1f4 ("smp: Optimize
send_call_function_single_ipi()"), sending an actual interrupt to an
idle CPU in TIF_POLLING_NRFLAG mode can be avoided by queuing the SMP
call function on the call function queue of the CPU and setting the
TIF_NEED_RESCHED bit in idle task's thread info. The call function is
handled in the idle exit path when do_idle() calls
flush_smp_call_function_queue().

However, since flush_smp_call_function_queue() is executed in idle
thread's context, in_interrupt() check within a call function will
return false. raise_softirq() uses this check to decide whether to wake
ksoftirqd, since, a softirq raised from an interrupt context will be
handled at irq exit. In all other cases, raise_softirq() wakes up
ksoftirqd to handle the softirq on !PREEMPT_RT kernel.

Since flush_smp_call_function_queue() calls
do_softirq_post_smp_call_flush(), waking up ksoftirqd is not necessary
since the softirqs raised by the call functions will be handled soon
after the call function queue is flushed. Mark
__flush_smp_call_function_queue() within flush_smp_call_function_queue()
with "will_do_softirq_post_flush" and use "do_softirq_pending()" to
notify raise_softirq() an impending call to do_softirq() and avoid
waking up ksoftirqd.

Adding a trace_printk() in nohz_csd_func() at the spot of raising
SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
current behavior:

	  <idle>-0       [000] dN.1. nohz_csd_func: Raise SCHED_SOFTIRQ for idle balance
	  <idle>-0       [000] dN.4. sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
	  <idle>-0       [000] .Ns1. softirq_entry: vec=7 [action=SCHED]
	  <idle>-0       [000] d..2. sched_switch: prev_comm=swapper/0 ==> next_comm=ksoftirqd/0
     ksoftirqd/0-16      [000] d..2. sched_switch: prev_comm=ksoftirqd/0 ==> next_comm=swapper/0

ksoftirqd is woken up before the idle thread calls
do_softirq_post_smp_call_flush() which can make the runqueue appear
busy and prevent the idle load balancer from pulling task from an
overloaded runqueue towards itself[1]. Following are the observations
with the changes when enabling the same set of events:

	  <idle>-0       [000] dN.1.   106.134226: nohz_csd_func: Raise SCHED_SOFTIRQ for idle balance
	  <idle>-0       [000] .Ns1.   106.134227: softirq_entry: vec=7 [action=SCHED]
	  ...

No unnecessary ksoftirqd wakeups are seen from idle task's context to
service the softirq. When doing performance testing, it was noticed that
per-CPU "will_do_softirq_post_flush" variable needs to be defined as
cacheline aligned to minimize performance overheads of the writes in
flush_smp_call_function_queue(). Following is the IPI throughput
measured using a modified version of ipistorm that performs a fixed set
of IPIs between two CPUs on a dual socket 3rd Generation EPYC system
(2 x 64C/128T) (boost on, C2 disabled) by running ipistorm between CPU8
and CPU16:

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

   ==================================================================
   Test          : ipistorm (modified)
   Units         : Normalized runtime
   Interpretation: Lower is better
   Statistic     : AMean
   ==================================================================
   kernel:					time [pct imp]
   tip:sched/core				1.00 [baseline]
   tip:sched/core + SM_IDLE			0.25 [75.11%]
   tip:sched/core + SM_IDLE + unaligned var	0.47 [53.74%] *
   tip:sched/core + SM_IDLE + aligned var	0.25 [75.04%]

* The version where "will_do_softirq_post_flush" was not cacheline
  aligned takes twice as long as the cacheline aligned version to
  perform a fixed set of IPIs.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/smp.h |  2 ++
 kernel/smp.c       | 32 ++++++++++++++++++++++++++++++++
 kernel/softirq.c   | 10 +++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 21ac44428bb0..3731e79fe19b 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -9,7 +9,9 @@ extern void sched_ttwu_pending(void *arg);
 extern bool call_function_single_prep_ipi(int cpu);
 
 #ifdef CONFIG_SMP
+extern bool do_softirq_pending(void);
 extern void flush_smp_call_function_queue(void);
 #else
+static inline bool do_softirq_pending(void) { return false; }
 static inline void flush_smp_call_function_queue(void) { }
 #endif
diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..2eab5e1d5cef 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -559,6 +559,36 @@ static void __flush_smp_call_function_queue(bool warn_cpu_offline)
 	}
 }
 
+/* Indicate an impending call to do_softirq_post_smp_call_flush() */
+static DEFINE_PER_CPU_ALIGNED(bool, will_do_softirq_post_flush);
+
+static __always_inline void __set_will_do_softirq_post_flush(void)
+{
+	this_cpu_write(will_do_softirq_post_flush, true);
+}
+
+static __always_inline void __clr_will_do_softirq_post_flush(void)
+{
+	this_cpu_write(will_do_softirq_post_flush, false);
+}
+
+/**
+ * do_softirq_pending - Check if do_softirq_post_smp_call_flush() will
+ *			be called after the invocation of
+ *			__flush_smp_call_function_queue()
+ *
+ * When flush_smp_call_function_queue() executes in the context of idle,
+ * migration thread, a softirq raised from the smp-call-function ends up
+ * waking ksoftirqd despite an impending softirq processing via
+ * do_softirq_post_smp_call_flush().
+ *
+ * Indicate an impending do_softirq() to should_wake_ksoftirqd() despite
+ * not being in an interrupt context.
+ */
+__always_inline bool do_softirq_pending(void)
+{
+	return this_cpu_read(will_do_softirq_post_flush);
+}
 
 /**
  * flush_smp_call_function_queue - Flush pending smp-call-function callbacks
@@ -583,7 +613,9 @@ void flush_smp_call_function_queue(void)
 	local_irq_save(flags);
 	/* Get the already pending soft interrupts for RT enabled kernels */
 	was_pending = local_softirq_pending();
+	__set_will_do_softirq_post_flush();
 	__flush_smp_call_function_queue(true);
+	__clr_will_do_softirq_post_flush();
 	if (local_softirq_pending())
 		do_softirq_post_smp_call_flush(was_pending);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 02582017759a..b39eeed03042 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -34,6 +34,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/irq.h>
 
+#include "sched/smp.h"
+
 /*
    - No shared variables, all the data are CPU local.
    - If a softirq needs serialization, let it serialize itself
@@ -413,7 +415,13 @@ static inline void ksoftirqd_run_end(void)
 
 static inline bool should_wake_ksoftirqd(void)
 {
-	return true;
+	/*
+	 * Avoid waking up ksoftirqd when a softirq is raised from a
+	 * call-function executed by flush_smp_call_function_queue()
+	 * in idle, migration thread's context since it'll soon call
+	 * do_softirq_post_smp_call_flush().
+	 */
+	return !do_softirq_pending();
 }
 
 static inline void invoke_softirq(void)
-- 
2.34.1


