Return-Path: <linux-kernel+bounces-363610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43BD99C4A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71131C221D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF4156F3F;
	Mon, 14 Oct 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nhsSA86D"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608F15359A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896679; cv=fail; b=ciM3/bwJgy71LWEqGAWcPsDENgraSKYEDmOv/FdDS5ZPLiI/o4DrrYg+wWn7oJuC7+RCaCngvedYBRTmbgn0Z1qemXR7NQEhiGorZUi96k8XQLNRm7KZbUnE1Jn0xqd/Ow1Zp0n7KVSpSfVHuP69kJFJ7utlgxErvGjmHgVBFno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896679; c=relaxed/simple;
	bh=SgWvRHqKNQR4/LVi8FqzjkDWI1RoB2seXSJZm8Le2FM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D978YX2xFZHG7YNar94dBQfYpyGLpQQ/mRvkFUddBUEdz8UwOcYl1Mwm8dfQoA/o/HVJF4TjWW1bTCxBn6y6Mhd+YB8vubTRLGJ7xQiCQc/9QyhKmofdZNPwFu6MVhKmuKaAhu77mYASr8DghIn2pnVi+Gt3awuB4ptkelZ243s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nhsSA86D; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf2OA6Ek6+LLW5amOnK/0bZBsKfRE6RvY8Sr7kDMTTtROXj+WBZfCMHPFqCkOiALe4AmEKrGEIdZWJzMeanZSs4BWlrb0Xx/p2nMy1CYee9m1+uuXckmSWB0YprM0z6jgpAVEAhZZHhqm5HudwOSEIuClYxTPeHhQ1T5GDocMXuNTFAnPywxs6pzaWJGV65gCMExGLGYr6ZDKW5OLuZUhJgPNiODsNXOmGFtnm78wLCGvqkOc1xrpEIdQORBr2WX7Ab4l+iVrpuCCPnfE+TMp3PBhee3uV8yL55hbXanTzM8BShF/I6Mm+/8I/hjDLr01zB4D3pbOkzD4ogpgoMkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWxGa+4WYEQl1q2pIojW3nX+ChwXIg18j8iOrMFPano=;
 b=S7Yp2KWW+jj0vkODrqjubNS29OZMbvsxWmP7AYoYvpkEIH0Shpsi5OPxscfd8iYHt9BYcq7DyWq2ZXhOK6EdVwUI/xbgZxtliSBM+54mxmf6ioN4oJNdxGri2r2UtjV3ETunp1pE23li8KVcj/xjibOrYz2hlW4foZGsFI8oTxle1DyZCYNZx/I/Bj6+72o8jI7eOeZmKJurASwmtUCMWZQkLkvxnBp5/jWOdbvcBfvjx02cEMeI07JPpFD/l1kW1dEi3JIMZMOvGwp+8P+B1cIyZ1ITHuwVbPgQU/pqyDvqBY8e0YFLkcHURIu9j1i3ALSqCe5RBuAbB9hoVc6zZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWxGa+4WYEQl1q2pIojW3nX+ChwXIg18j8iOrMFPano=;
 b=nhsSA86Dr6kyAM2MgJ5Q2ocHeVfrhl4bneDOoH1FhHENLfjmKQ8dHStwUssA3ht3r5W7bS7/VasNC4PbROtM5x4iWJdjC4EhTvyXsUZi3gO5G6uVjRC6mzz8uz4Q0qf8/uTbsKKcmIKTjf0vujpK1orAoTcANQTC7FJDFissqhA=
Received: from CYZPR12CA0018.namprd12.prod.outlook.com (2603:10b6:930:8b::10)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 09:04:33 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::72) by CYZPR12CA0018.outlook.office365.com
 (2603:10b6:930:8b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 09:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:04:32 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:04:22 -0500
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
Subject: [PATCH v3 1/5] softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
Date: Mon, 14 Oct 2024 09:03:35 +0000
Message-ID: <20241014090339.2478-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014090339.2478-1-kprateek.nayak@amd.com>
References: <20241014090339.2478-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b615006-2254-4c9d-ef65-08dcec2f380a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+fWhIccpeEdJilFcIy8mULhphwyndSJ/ESUq5XicIwuAxd2JwdqSeMqICiO?=
 =?us-ascii?Q?Ij4fN0S0Nsypst0BJyIPYmDM9ZZojMjRss2GkT1o95W5GQPmwptEGIL34RpK?=
 =?us-ascii?Q?VJqsjZFBG4MPTQvD/mrupd9UQZuUVuiWhwKVrPAtX7uqhZuX711ItUuWdf3s?=
 =?us-ascii?Q?hr1cZfe43O5Qnfgal3hUdTEqJphFno+6IYpM2tKvl9zDGLekFzJgBKxRNXKA?=
 =?us-ascii?Q?mKSMzWBfcD7dLZxkI8/WZGaDLGt8UOVHWN7XsjuzVw2oYcRTdn4gl8POeWQs?=
 =?us-ascii?Q?qNLL/2Cv9kdBkPCaB47L0V+99ObArN4s6rax4L9m6/nLvBYRkFV77Hv69QM9?=
 =?us-ascii?Q?jyt5AoU2au9w0+IA7loP+X93bfnn2pjbh/VbfEcdVWnWi2TFfxlZ8KguhHA1?=
 =?us-ascii?Q?vFZqKQt7TuEf5ZKv8K4zq3kdZBNiDsAowz0JPhWA1LY1CwSOOW6w7uAZNzdj?=
 =?us-ascii?Q?EenB462OHDD0X20R0GrzB2Q4WxVws2t0O+H5wmWJYvoBcmW7/3L/5Du1LmcK?=
 =?us-ascii?Q?KuteXdZKs8uezRTZDGCrJuQUlG4wYSrXwol4SyAK1vXtU3z9kmGLjjmlxudm?=
 =?us-ascii?Q?raHe/5LpzZbSq4KcJwyK+AJwe7S50Th8gTFy4u66mJECYee5a5OGdWnJ8Hxf?=
 =?us-ascii?Q?+JZ5eG9yQ/FnyFb8iPPoe9of2ddc0iimVHcU0/TtKu5K+m+Z4oEnidCransy?=
 =?us-ascii?Q?tUk94EQj/+xqIMB2DfpzLtuqTWgqdUseDONffPGUxRP+3G34/iWLwfRV1p76?=
 =?us-ascii?Q?t6nzqV4PEUKD/wKaWx1Vglp2DZ20v/U/cWCink/mG19zzwuRhRU7Y0n8WXOn?=
 =?us-ascii?Q?1Ms6p84LDow9ChmD3VakuE7MBSXSFzjNL7CYSTz6QmXiWlnrPDiydg5uKdLN?=
 =?us-ascii?Q?4jUMj+U05AluIRyXtgU/51uv9stEBba6P+ah3EnJ+wLXVUiOQ1ibENaztC8x?=
 =?us-ascii?Q?ArYdZpjZ0MLIXA59e2PAFVjbXndGkCBg5d8KbwIm5N9qZeQlfbUyQn3yOy7l?=
 =?us-ascii?Q?RhZt93FeVXux9Qlz9Cf/C4813VNWo0WMQQaL2O4RKWAzIJVJMOYDEagYB7A1?=
 =?us-ascii?Q?prfTGQ+B0l0CsEX0RHPn9xBHQOem6pxbjKJe4Ou6oPZPImK2bI3Rikt6f8ki?=
 =?us-ascii?Q?ppH37rb6b/RS1nTnUUsnES244vvkXyoGNttk82ZEDqTmZUtsz3JU9QzYGShz?=
 =?us-ascii?Q?1FpRZTX6sH4H+ArcHpKVtBUhfQo/JJMyqGD+QlD2imP7qi93hJ4sSqUJad8K?=
 =?us-ascii?Q?trXwg6olJ1CamzWwhXGpfikQfv3seF43o6gPI0tUQm7IAqV68Y7wahea7h2g?=
 =?us-ascii?Q?pCBGzwDcnPcbHJrqq2fJo0HaETnm4tinWns+Ua/tvf4CAEXRYpEcNyT7e1g2?=
 =?us-ascii?Q?C+OK6RIpzyszsTpzqIeRoRRqWtdz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:04:32.5907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b615006-2254-4c9d-ef65-08dcec2f380a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
Since do_softirq_post_smp_call_flush() is called with preempt disabled,
raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
longer preempt disabled sections.

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") IPIs to an idle CPU in
TIF_POLLING_NRFLAG mode can be optimized out by instead setting
TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
flush_smp_call_function_queue() in the idle-exit path to run the
SMP-call-function.

To trigger an idle load balancing, the scheduler queues
nohz_csd_function() responsible for triggering an idle load balancing on
a target nohz idle CPU and sends an IPI. Only now, this IPI is optimized
out and the SMP-call-function is executed from
flush_smp_call_function_queue() in do_idle() which can raise a
SCHED_SOFTIRQ to trigger the balancing.

So far, this went undetected since, the need_resched() check in
nohz_csd_function() would make it bail out of idle load balancing early
as the idle thread does not clear TIF_POLLING_NRFLAG before calling
flush_smp_call_function_queue(). The need_resched() check was added with
the intent to catch a new task wakeup, however, it has recently
discovered to be unnecessary and will be removed soon. As such,
nohz_csd_function() will raise a SCHED_SOFTIRQ from
flush_smp_call_function_queue() to trigger an idle load balance on an
idle target.

nohz_csd_function() bails out early if "idle_cpu()" check for the
target CPU returns false and should not delay a newly woken up task from
running. Account for this and prevent a WARN_ON_ONCE() when
SCHED_SOFTIRQ is raised from flush_smp_call_function_queue().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v2..v3:

o Added more details on SCHED_SOFTIRQ and how the idle load balancer
  will bail out if there is a new task that has woken up on the idle CPU
  and should not add more latency for task to run on CPU.
---
 kernel/softirq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b756d6b3fd09..d89be0affe46 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -280,17 +280,24 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 }
 
+#define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
+
 /*
  * flush_smp_call_function_queue() can raise a soft interrupt in a function
- * call. On RT kernels this is undesired and the only known functionality
- * in the block layer which does this is disabled on RT. If soft interrupts
- * get raised which haven't been raised before the flush, warn so it can be
+ * call. On RT kernels this is undesired and the only known functionalities
+ * are in the block layer which is disabled on RT, and in the scheduler for
+ * idle load balancing. If soft interrupts get raised which haven't been
+ * raised before the flush, warn if it is not a SCHED_SOFTIRQ so it can be
  * investigated.
  */
 void do_softirq_post_smp_call_flush(unsigned int was_pending)
 {
-	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+	unsigned int is_pending = local_softirq_pending();
+
+	if (unlikely(was_pending != is_pending)) {
+		WARN_ON_ONCE(was_pending != (is_pending & ~SCHED_SOFTIRQ_MASK));
 		invoke_softirq();
+	}
 }
 
 #else /* CONFIG_PREEMPT_RT */
-- 
2.34.1


