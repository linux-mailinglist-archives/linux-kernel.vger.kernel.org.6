Return-Path: <linux-kernel+bounces-314854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E3996BA05
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18E8C284408
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B71D2794;
	Wed,  4 Sep 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hBJKvC/8"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9981D0157
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448461; cv=fail; b=D6iY1iOdKKlFVxlV0rLHvZPakYldV9PofnPpC+/5HvE+r0UEw24iWo8SGMm8b+WdDgKYlTOcEivoRIg1cgIad2B1q1eOafC4lGUtQmfEC+EY4gbR2+Vwm4beNfwdWX0UcgX+CX3APcXENWtAxQp9au5rTHcMCOS1Iqtc5jOeI/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448461; c=relaxed/simple;
	bh=pzBRFFHEjepOXwG4EVJto0g2rPfDHIydrys+veZVQlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+69A/Oa6E7aigkWtICIbCbJXLad9PhWVkq6HOVy0ifKkn7q/CxTTYK5ugrIFE950qHrMZ++luR2tRk02qusfBrJQ6mu2QA9NpX9N9PzGyJt7SDxnUSp5eW20Y4spLSgNHytDt6wVpHywQR/SkFLPDUFzR1vkPBYFxc5KykFy+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hBJKvC/8; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+e8vI6LZFCJUZQ1n7kgnOHuuHpYE9wryVmvmkyWf+00ZiAMoUHLyG9B+89nSNPeIsvUdWzps7rVT0k92iFtfqjHkw3Ug18fpUQR4F9qIMFc8PLu9wFBjkIc7mcGFkEZDClMyG4R4UTre6RLm4Wcl77a03XoSDF7WxFmFn6sfQoCt29XR9SL66twajSoX7BNYpZj9ubDA+DrQlV9FUw05R5WmrCporV2JQQWhQYI1nlh4SUyhNVLvxPyxmLiMhJbGDFvrT0blP8pvTSAKTdNDIgCUzCct/O4SBq5w4CFxt4CxDwz1ruZHYueCOkkgSawsOcImOqOUIVGdxldmTDphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xdqsHmEWngXSxT6Q7Ba/j1YEgS5AIFFZA4Q+Ynb03o=;
 b=oZKDmrLrerInDgO04tWShTKhHeLjqVhxwgaRFtFQeF7WX5kRQYV3Mgj7v/D1cGk+e+6OF8kf+tCEMcx5lshzQ7XGRFpEQ5KwXWeINsieW1ph85eWgsuOaq24IENAG/yBaegt6QvwBJOdEppCilv2PYL0pyQHdmuaCV1hLvUaGNJEQ7svjubeZHThujeoYbqzLv1NmZBUiCu34MT7G8vtc33W6vPBq+ut3HAZyW2ctCDd6tIl//+irt5I3Y8TAkWfAOdDpvSN5tm9dfZ+84GAHzeSHWf29QeDPIFzuFkPJU+Zn0b1gGlJvvV1rgoKAJ6JrrNxt2XPy+b40roEqP4ExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xdqsHmEWngXSxT6Q7Ba/j1YEgS5AIFFZA4Q+Ynb03o=;
 b=hBJKvC/8wjFsZjz33APL2oiw1IFAKd0yY++o1vSiqVJWLnGnTjfIab03vFksw43KeSccAEmyiiuox94I4d1DCQwbhHt89w5vv/amHm64zeNXxAsvP0m7yyGQ+rPQ9iy/Xw25dnR8PVU8/kfYe0UYVkeS+ICCGA0mRF8BMvthgFQ=
Received: from BN9PR03CA0690.namprd03.prod.outlook.com (2603:10b6:408:10e::35)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:14:15 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::bc) by BN9PR03CA0690.outlook.office365.com
 (2603:10b6:408:10e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 11:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:14:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:14:08 -0500
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
Subject: [RFC PATCH v2 5/5] softirq: Avoid unnecessary wakeup of ksoftirqd when a call to do_sofirq() is pending
Date: Wed, 4 Sep 2024 11:12:23 +0000
Message-ID: <20240904111223.1035-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904111223.1035-1-kprateek.nayak@amd.com>
References: <20240904111223.1035-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f29ac7-b595-480a-8880-08dcccd2b629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3Fync/rQlQd+8V0ijN9P4jgejDSMfE9OxjsvbXPUEKDaaihiUmk0Ye76srD?=
 =?us-ascii?Q?dSlcdCXHgBu2VAJxOC2xZ3UdnrLZIEtcwm4LXhj/5vWTQTPDuf0RK5Qe4yrm?=
 =?us-ascii?Q?ZMWEh/ZhiEu6Gf+zFhOAAShwEuiXNvQMGd2Ptx0oHJ+JdFD1Lf9emvVVF21J?=
 =?us-ascii?Q?Stkbk7u7/xUEgat8iXRceQsKY5w02Bi7XKwzRY139BNp2qA0SfHkQB126DmZ?=
 =?us-ascii?Q?G3ISAu/NrFEBJZeZ46z2Q45qlaA8uq6Spbj0W+gFNM9j+lYkY3n9SK+GI0//?=
 =?us-ascii?Q?YUjabzt88HYnJlscdffu9TJoH3lN087LJBySvEL0c094bF/XFPRxeRgRAXZT?=
 =?us-ascii?Q?uIpSy1v6L90T+/mmty3DchN1ULcvvD8VfY3XT5EVbtq4uuoZeeYV+bKPqP+U?=
 =?us-ascii?Q?/Jxz3mYzBUg6aol35RdUbB6cJOIky1ozUcw+mHlBvBWIwANKborvdkfq80HU?=
 =?us-ascii?Q?iM2c3Qa5MF/81Qr0JrA4UyYP3/AOkMszbcGt430nvxr5rSf0v5tFJpTHKrdO?=
 =?us-ascii?Q?i+ngcRuxe5t1V7Q8VHIKVHzHJyjM69njb7JBHfQiAuEbINqpa06m2BbhuP/u?=
 =?us-ascii?Q?nA3KO4uP81idWob3DZrbvmeEDPoragbbFMszjVb5jYrn2xOniZHF69dmWyqO?=
 =?us-ascii?Q?Of2q3zltAxQ0pXMmQst8IiubwZVD02lUZAYlnEs/3otaj1ZuzIyZVW0VuAEX?=
 =?us-ascii?Q?5En8CmR/nemoPregwV6b72TwYazzCJujeXo2wKFRaZHVWy2BLt6oXSRA3aR3?=
 =?us-ascii?Q?x2tL9LV434PxEO7tDvGLBzBbdN/1eRcXnvzkDypkJ91EazzihgQzh1xFyFy5?=
 =?us-ascii?Q?tJquBPhICs+fkGwc/yxHY8fjW+UD6P4fdGfaeYAOmBHWBB8r/FMm5ZOvdnFf?=
 =?us-ascii?Q?pr3Io+znPKeUY1xBLYwSpkk7g/2RodTaTwaEPd/iUIJ8Lk8dXtoHWa9HPj1x?=
 =?us-ascii?Q?QlGyfh7IIYAh4X6MhBsa/9fF8iYviT8G2D+OHAyxxNaw+Y9W9w3IriQLw6Hf?=
 =?us-ascii?Q?AX5hKS1r0yWG1p4dqJExz9h3ecQ0ssoyGYZgocpbbeFM+wObc3lQjhCetvJt?=
 =?us-ascii?Q?q2+1/cTglb/Zg8U9oQcbMh30iGyNm7DA3tisy5se83zAl516CEAbRyonwN6H?=
 =?us-ascii?Q?d/vFagqxqPy3yAMJSwgKlY48eCOiHW2CdRtHFJfON3bQZN0rqstu+bP2jVtm?=
 =?us-ascii?Q?SsqU5uwllXInpD+l/ULVcI9TywE3YEZ0g48KpjS/dUTF6pPCAvMFpkm/1KZa?=
 =?us-ascii?Q?iPh9RtBLIGMT9Y4CPMJYBVaKuxl8vz/1nPNANpsEl7msolapJKh+mxiJiD+F?=
 =?us-ascii?Q?1j0+FvtYyokmbA1OXVf/iPHA5jNvccuh28un3C5k16KKZ+oLyZOrpcA1rEoL?=
 =?us-ascii?Q?D8f7R8pSOyUDr0y/MwLzkzo02PTgOF0iicNX1BHMmSgy0YmWtZmdqdzB4AD4?=
 =?us-ascii?Q?6F1TdX+EEsjXRUUJrOxYNV3eJqgFPEfuRNv8sFXMp80V0LYBwoIRvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:14:15.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f29ac7-b595-480a-8880-08dcccd2b629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

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

Adding a trace_printk() in nohz_csd_func() at the spot of raising
SCHED_SOFTIRQ and enabling trace events for sched_switch, sched_wakeup,
and softirq_entry (for SCHED_SOFTIRQ vector alone) helps observing the
current behavior:

       <idle>-0   [000] dN.1.:  nohz_csd_func: Raising SCHED_SOFTIRQ from nohz_csd_func
       <idle>-0   [000] dN.4.:  sched_wakeup: comm=ksoftirqd/0 pid=16 prio=120 target_cpu=000
       <idle>-0   [000] .Ns1.:  softirq_entry: vec=7 [action=SCHED]
       <idle>-0   [000] .Ns1.:  softirq_exit: vec=7  [action=SCHED]
       <idle>-0   [000] d..2.:  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=16 next_prio=120
  ksoftirqd/0-16  [000] d..2.:  sched_switch: prev_comm=ksoftirqd/0 prev_pid=16 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120
       ...

ksoftirqd is woken up before the idle thread calls
do_softirq_post_smp_call_flush() which can make the runqueue appear
busy and prevent the idle load balancer from pulling task from an
overloaded runqueue towards itself[1].

Since flush_smp_call_function_queue() calls
do_softirq_post_smp_call_flush(), waking up ksoftirqd is not necessary
since the softirqs raised by the call functions will be handled soon
after the call function queue is flushed.

Introduce two new APIs:

- set_do_softirq_pending(): Increments per-cpu softirq_ctrl::cnt by 1 to
  indicate a pending call to do_softirq().

- clr_do_softirq_pending(): Decrements per-cpu softirq_ctrl::cnt by 1
  just before calling do_softirq().

Call set_do_softirq_pending() before __flush_smp_call_function_queue()
within flush_smp_call_function_queue() to indicate a pending call to
do_softirq() and clr_do_softirq_pending() before calling
do_softirq_post_smp_call_flush() to mark the promise being fulfilled.
Since this impending call is tracked by softirq_ctrl::cnt,
should_wakeup_ksoftirqd() will return false and prevent a pointless
wakeup of ksoftirqd.

Following are the observations with the changes when enabling the same
set of events:

       <idle>-0  [000] d.h1.:  nohz_csd_func: Raising SCHED_SOFTIRQ for nohz_idle_balance
       <idle>-0  [000] ..s1.:  softirq_entry: vec=7 [action=SCHED]
       <idle>-0  [000] ..s1.:  softirq_exit:  vec=7 [action=SCHED]
       ...

No unnecessary ksoftirqd wakeups are seen from idle task's context to
service the softirq.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/ [1]
Suggested-by: Peter Zijlstra <peterz@infradead.org> # Reuse softirq_ctrl.cnt from PREEMPT_RT
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

- Re-used PREEMPT_RT softirq_ctrl::cnt to prevent unnecessary wakeup of
  ksoftirqd. (Peter)

- Broken off from approach discussed in
  https://lore.kernel.org/lkml/880f13fd-753d-2c5a-488a-d75c99e8dfa3@amd.com/
---
 kernel/sched/smp.h |  9 +++++++++
 kernel/smp.c       |  2 ++
 kernel/softirq.c   | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/kernel/sched/smp.h b/kernel/sched/smp.h
index 21ac44428bb0..83f70626ff1e 100644
--- a/kernel/sched/smp.h
+++ b/kernel/sched/smp.h
@@ -9,7 +9,16 @@ extern void sched_ttwu_pending(void *arg);
 extern bool call_function_single_prep_ipi(int cpu);
 
 #ifdef CONFIG_SMP
+/*
+ * Used to indicate a pending call to do_softirq() from
+ * flush_smp_call_function_queue()
+ */
+extern void set_do_softirq_pending(void);
+extern void clr_do_softirq_pending(void);
+
 extern void flush_smp_call_function_queue(void);
 #else
+static inline void set_do_softirq_pending(void) { }
+static inline void clr_do_softirq_pending(void) { }
 static inline void flush_smp_call_function_queue(void) { }
 #endif
diff --git a/kernel/smp.c b/kernel/smp.c
index aaffecdad319..65a47b33a57e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -584,7 +584,9 @@ void flush_smp_call_function_queue(void)
 	local_irq_save(flags);
 	/* Get the already pending soft interrupts for RT enabled kernels */
 	was_pending = local_softirq_pending();
+	set_do_softirq_pending();
 	__flush_smp_call_function_queue(true);
+	clr_do_softirq_pending();
 	if (local_softirq_pending())
 		do_softirq_post_smp_call_flush(was_pending);
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d8902fbcdebf..935a2d8091b5 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -99,6 +99,10 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
  *
  * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
  * the task which is in a softirq disabled section is preempted or blocks.
+ *
+ * The bottom bits of softirq_ctrl::cnt is used to indicate an impending call
+ * to do_softirq() to prevent pointless wakeups of ksoftirqd since the CPU
+ * promises to handle softirqs soon.
  */
 struct softirq_ctrl {
 #ifdef CONFIG_PREEMPT_RT
@@ -113,6 +117,16 @@ static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
 #endif
 };
 
+inline void set_do_softirq_pending(void)
+{
+	__this_cpu_inc(softirq_ctrl.cnt);
+}
+
+inline void clr_do_softirq_pending(void)
+{
+	__this_cpu_dec(softirq_ctrl.cnt);
+}
+
 static inline bool should_wake_ksoftirqd(void)
 {
 	return !this_cpu_read(softirq_ctrl.cnt);
-- 
2.34.1


