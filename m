Return-Path: <linux-kernel+bounces-280646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556A94CD42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582021C2129B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E419149A;
	Fri,  9 Aug 2024 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y8WCs/J4"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE618FDBC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195377; cv=fail; b=gTt3eOwkvz6JyVMbFFpUw7fTuc3ipENnTwxya1i/QABxBKqSYnsXFJR6meRl4fi+K1UNiTETFEMM4VlFrSDRaDMvl3mj5wqVp/e60Ao0XqKiZCVXaKANl/iih6fOjW5z0dmuG2Al+TMqStZ80yxGPJHmSFDGt+EQwOHsvQhjMCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195377; c=relaxed/simple;
	bh=soxI3YW6IdyPz8YiQ6Ect4hKuvqVBmqrwvNu+SbwSHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iuVPweFA1DKad9Og2isD9rVHnNtfAtX9P9eTB/AHhseevdrmuIOr6UPrmeXVEUh0Z4VtbmEyoABkSbAL2YnXwWauY41dNdZqXtEwbNAZn8EXQbWUZaTbynmrZvO4qZl9MQe/QaT8zMMQDnjGosOHsJcKRqWmkd1udc1a+KJjmpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y8WCs/J4; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyEn43QOWoY9qVRr6ofNKzXhATB1Ly02pP+3uRooy9P183Lu6IlX5+43HDdZ189YSYLAhqwE/kpHriZHMpqBN4P3Takwbcr+AtgmyDrcc3mLzbCrVql1CO7HmNfvSMgZlB/KgCUCgHStMH4CSupOp3AEb2HQl6HUHS22ymv33p6TG/j6ROa44QhVfwlxws3pZIfp4hS8OOzY0TKM8DsLXAK6p+/hNJCmsHta4YHuDA1NIQcnBbGYrlI72dlI1ZhWnTLwoDNS1Eax1VD2muEbtGUR8WmyOgpNHPhF1GwV/pIrQwplIfw/3JgbtHMqLsHOm4BO5iyDx9q4wcXzh4S9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWbHP8HgD5n9EA7pvmFg6RoeAzlyljJ/VT4+S8zUcsM=;
 b=f0CvUu0Pl+zU9BYWnKq0IVWgduncl5mktH9NIvNXPHiHbVqp8HZFlMoyVZHIiRX1C90W7IJ17eAbzWstIdRRGiF0ixR+7xtQRGVdj5w6Oa9cgEk253OaTcKhQQ0EZA+VuASpBP4lRglyywcFsKCJFVhGTVlCSf4WP16Vp0qBvhYg5IULddm8REsS430iQNwi4Wxcjbj0j7NY+rer1/MGJUWurnxsZlVx33YZed6SRp6VkpTPwFwaty26d3wy10pgnaH5cgUx2G02qmzIA4CV45D9DZ8sT17LFU+yzsPiCTp9cqvDVzXCUgMXpthADku6d7+ZMZ2Zs/m+gR1IyYd/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWbHP8HgD5n9EA7pvmFg6RoeAzlyljJ/VT4+S8zUcsM=;
 b=Y8WCs/J4XvQvSyvN4DB77jr8bLW+vkyaHvWuOkuNCVTZfpuH6yxAeVyXRsrSCKLirfQfS3UAvGHXf3LEVsYcZiElSaH/jD945BhgGrjIO8m8JhFnnR0f/vfz7utlNLxgvSDPYtm1cpTo2sCidkBSEKJefe1Dl0sH5npB0EtpV4U=
Received: from SA0PR11CA0172.namprd11.prod.outlook.com (2603:10b6:806:1bb::27)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 09:22:52 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::f6) by SA0PR11CA0172.outlook.office365.com
 (2603:10b6:806:1bb::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 9 Aug 2024 09:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 09:22:52 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 04:22:47 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v2] sched/core: Introduce SM_IDLE and an idle re-entry fast-path in __schedule()
Date: Fri, 9 Aug 2024 09:22:40 +0000
Message-ID: <20240809092240.6921-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 6322b669-3f49-4817-749a-08dcb854d815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jwPFQ/t6AnonPm3+itdz/na+MjdFeXZ9287IXCrR1xDawRLCw7w+omGWhUuZ?=
 =?us-ascii?Q?WnfEBnb72GCUK0twEuxcn/SZJedAvLsuBUYhU1edKxIztkLxkd2K9VOj0xGP?=
 =?us-ascii?Q?im5U0bOdoah7AOe77wa+ok2hB/2AkyVGanYjpoBliwkw9H47AxBUEE5PaM/a?=
 =?us-ascii?Q?jyewWPAU76jXDrlSHHOHbnSAYMWzF9AQr4yQmemrS03T0JLhWcbxSlZhWBu4?=
 =?us-ascii?Q?V1Rd2TYiXQeYGDrFqBgYsx6SZW/E+dkamVK2NTXo3752bbaOkuzLNQ96um+1?=
 =?us-ascii?Q?khzO0vmquh1ZIq9+2MzBbrb1ArOM8EvFtePhnrXgXsFHf+OyC2XD9l5KSn4V?=
 =?us-ascii?Q?xfTGaV5/7sFEW3qAI7kjybbXh+3ivsZunZD0mbx1Yt7V1aXwPkuNJFV0L8lw?=
 =?us-ascii?Q?VZjQ1cptLZTb0JxhzDSZxrUnPjI9a50YyYnjAcxaR/Y1qzKVTWaofJ7QAexq?=
 =?us-ascii?Q?ox/MAWpW0P7ZwJzBp4BDjEtWsk2JS3wlSObgpgW2Vq847KWH6isqmbuYsn4x?=
 =?us-ascii?Q?5KDK3Rs6bM1yqvKMUhR+9ypHRGGDR/TO5PJ6ainAHfEX3HwjMLjtIB+W8RWZ?=
 =?us-ascii?Q?NlLG/OMy4tqzxZp6rXB3hsfFgDxg3C3FlA9ct+f+OliAooWpvLUUYXptj2WY?=
 =?us-ascii?Q?05Zb1+JF16w4W86AqOXzHkiYi+LA4xSspqZSpLcf2N58Xi1HxZ9UxLm2MKWv?=
 =?us-ascii?Q?WSKf29si1NsB9xUFIE7PGSeJS4/OzZ50NpzncInF+4qiudZLHYN8dWxOfsv4?=
 =?us-ascii?Q?qPmwsK22ZuoWeHKJ9EXqWUudtwpjn2hmy+0k+dNK0Ub8EomYP9sfj2BOmNJe?=
 =?us-ascii?Q?9soJYSolIPFdYQnoAPWaR1kxBmJo/RTS8uSFqI81LQdVymWuC25svNN94AX9?=
 =?us-ascii?Q?r5hESbiiWGi8aU+eDkx2NVnocSEy735/Lm7k8xXTwYYj2X5a/lCKPemEmiiq?=
 =?us-ascii?Q?TIhf3wvUcCOZPXwaKxQS+bjm8hDSpGflw7xE7E4IPgdNWdT1nQ4+WSKZue5I?=
 =?us-ascii?Q?0KJelH42An492gbq0ygwkKBOCpXg7/flijyGYN2DQJMJA4zPSKWp5NXRZ01R?=
 =?us-ascii?Q?qWmd+O5zPq6+SthIy2Si/ck6MzkxqLt3gDcfrRGaXo+GWrCeskcQ55jcufG5?=
 =?us-ascii?Q?HKm5ftK1XYLdiC92cVI+Aj9QoL0of7JJBdMeN/ybVyDMmc/1BRju4yuGKJdF?=
 =?us-ascii?Q?fc6jcWTqcJ+JE6waKNFEZAdXmQgOWb96yuDMAsKXl0CZsfFJu8PcfHlHtmyK?=
 =?us-ascii?Q?iN8Gl+O96igr8Lb3lMcKfNwLxUDukWp973GXpGDOP6qBxmU2wEN6VggtzAS2?=
 =?us-ascii?Q?eJ5MB/RtEalfQCTX5N/b8OjK8GMZVA6SVPho1IjZsuorjZIdlv+HuhXjDQ8P?=
 =?us-ascii?Q?+80L1NQkKY2vsRLVGavzG4WfZC24oD9cWl+1qo6qR/WzMtb5xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:22:52.0878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6322b669-3f49-4817-749a-08dcb854d815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255

From: Peter Zijlstra <peterz@infradead.org>

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
IPI without actually sending an interrupt. Even in cases where the IPI
handler does not queue a task on the idle CPU, do_idle() will call
__schedule() since need_resched() returns true in these cases.

Introduce and use SM_IDLE to identify call to __schedule() from
schedule_idle() and shorten the idle re-entry time by skipping
pick_next_task() when nr_running is 0 and the previous task is the idle
task.

With the SM_IDLE fast-path, the time taken to complete a fixed set of
IPIs using ipistorm improves noticeably. Following are the numbers
from a dual socket Intel Ice Lake Xeon server (2 x 32C/64T) and
3rd Generation AMD EPYC system (2 x 64C/128T) (boost on, C2 disabled)
running ipistorm between CPU8 and CPU16:

cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1

   ==================================================================
   Test          : ipistorm (modified)
   Units         : Normalized runtime
   Interpretation: Lower is better
   Statistic     : AMean
   ======================= Intel Ice Lake Xeon ======================
   kernel:				time [pct imp]
   tip:sched/core			1.00 [baseline]
   tip:sched/core + SM_IDLE		0.80 [20.51%]
   ==================== 3rd Generation AMD EPYC =====================
   kernel:				time [pct imp]
   tip:sched/core			1.00 [baseline]
   tip:sched/core + SM_IDLE		0.90 [10.17%]
   ==================================================================


[ kprateek: Commit message, SM_RTLOCK_WAIT fix ]

Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

- Fixed SM_RTLOCK_WAIT being considered as preemption for task state
  change on PREEMPT_RT kernels. Since (sched_mode & SM_MASK_PREEMPT) was
  used in a couple of places, I decided to reuse the preempt variable.
  (Vincent, Peter)

- Seperated this patch from the newidle_balance() fixes series since
  there are PREEMPT_RT bits that requires deeper review whereas this is
  an independent enhancement on its own.

- Updated the numbers based on latest tip:sched/core. In my testing the
  v6.11-rc1 based tip gives better IPI throughput out of the box which
  is why the improvements are respectable and not as massive as what was
  reported on v6.10 based tip in v1.

This series is based on tip:sched/core at commit cea5a3472ac4
("sched/fair: Cleanup fair_server")

v1: https://lore.kernel.org/all/20240710090210.41856-1-kprateek.nayak@amd.com/
---
 kernel/sched/core.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29fde993d3f8..6d55a30bb017 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6380,19 +6380,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Constants for the sched_mode argument of __schedule().
  *
  * The mode argument allows RT enabled kernels to differentiate a
- * preemption from blocking on an 'sleeping' spin/rwlock. Note that
- * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
- * optimize the AND operation out and just check for zero.
+ * preemption from blocking on an 'sleeping' spin/rwlock.
  */
-#define SM_NONE			0x0
-#define SM_PREEMPT		0x1
-#define SM_RTLOCK_WAIT		0x2
-
-#ifndef CONFIG_PREEMPT_RT
-# define SM_MASK_PREEMPT	(~0U)
-#else
-# define SM_MASK_PREEMPT	SM_PREEMPT
-#endif
+#define SM_IDLE			(-1)
+#define SM_NONE			0
+#define SM_PREEMPT		1
+#define SM_RTLOCK_WAIT		2
 
 /*
  * __schedule() is the main scheduler function.
@@ -6433,9 +6426,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(unsigned int sched_mode)
+static void __sched notrace __schedule(int sched_mode)
 {
 	struct task_struct *prev, *next;
+	/*
+	 * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
+	 * as a preemption by schedule_debug() and RCU.
+	 */
+	bool preempt = sched_mode > SM_NONE;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6446,13 +6444,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev, !!sched_mode);
+	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
-	rcu_note_context_switch(!!sched_mode);
+	rcu_note_context_switch(preempt);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6481,12 +6479,20 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
 	switch_count = &prev->nivcsw;
 
+	/* Task state changes only considers SM_PREEMPT as preemption */
+	preempt = sched_mode == SM_PREEMPT;
+
 	/*
 	 * We must load prev->state once (task_struct::state is volatile), such
 	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
-	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
+	if (sched_mode == SM_IDLE) {
+		if (!rq->nr_running) {
+			next = prev;
+			goto picked;
+		}
+	} else if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -6520,6 +6526,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6561,7 +6568,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
-		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
+		trace_sched_switch(preempt, prev, next, prev_state);
 
 		/* Also unlocks the rq: */
 		rq = context_switch(rq, prev, next, &rf);
@@ -6637,7 +6644,7 @@ static void sched_update_worker(struct task_struct *tsk)
 	}
 }
 
-static __always_inline void __schedule_loop(unsigned int sched_mode)
+static __always_inline void __schedule_loop(int sched_mode)
 {
 	do {
 		preempt_disable();
@@ -6682,7 +6689,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(SM_NONE);
+		__schedule(SM_IDLE);
 	} while (need_resched());
 }
 

base-commit: cea5a3472ac43f18590e1bd6b842f808347a810c
-- 
2.34.1


