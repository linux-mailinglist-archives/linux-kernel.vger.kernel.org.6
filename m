Return-Path: <linux-kernel+bounces-314847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EB696B9EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6747C1C2255F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43991D0140;
	Wed,  4 Sep 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3db1/cWs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFC1CFEC8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448383; cv=fail; b=avV25mBJA+Ug3cwgNVvO0hOOpyaa6qLfN3O4wdGgzRRYHlcCGKyK7BNY/t8rNyuX0I6SXif4aT8BfERy71vAFNNco/lzh7BTbJ0uvI6MBBFc+HSz3Wm3ivZsj6Q63MBsldPF8HhwriVJ5YTgVkzZNfQzQxGA+B04oDAYg9o2zV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448383; c=relaxed/simple;
	bh=rVGsUx8s02nDbIZNtPRE4XHFPsCfPEeKVvWWB3qADgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSUI7XdadxmizmwBAvlWbp3de2HSDgJdhN2iu1+eZh9Z/aLO1Qc3RKTVJcgBVED0Mf4mSblSf72SC85qS036+kp1YJUm3S/W704ZOHb6RjWm/tzV5WtSuVjFVvB/Mpn/a0hHy/p825ljJqxqPJPfdR9zAgKNo4rdQzQM+bh+80A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3db1/cWs; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLI7/jNzW3qMVmNZo6vzfwYr4xK+n+OmtVo8hFxYQ1d+/Jm2YiZ7OOk+D4ebbHpyGOgtxZnZdvVyoqqKwAhu9cht/YZsss5UkY8hWfPe4wl2aWcefGvzR927y708UotfaWlTYnAzU+J2Bl5/YM0KW9QU7nbwxJzdtO2TkdcKnE5IlfderM33Fb7QsylU5rR/Vn5zMYD28XHG0e4v0rA997Q1DiNUVHb63sph4qz5LrnS5eILgOq45fD9X9bZ8YXOSxP7JeFOL91Rvw+1C/RlQRbPUNGO7F03iLFTf7fFvZSVy0eW0OhB5rIexODGwpi8AtGuT05RRqfPUG6RT1v0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og6bx3/hRMUT9PmDWlX4Qub0P9mTUyNqQmkCH0pWk/0=;
 b=pXZJa2HMQtkckx5/7Y5FYYkQZrdaRnSBpzUfhEmrsiN8MagW+YeaK4EXh0udMQUG+2uuJAZ8CQhQF3nHXJMcFx7ovFnuxnpSUPxbdvQ6v3XcTc/+4x77YfK+ebZxkJ7mbj2FZcihB2fAAm9i0+GDU1ak/26P+dyWVvlfZorr4ELqqBrkKMPeXyhxgU7nDWu25xHfi3hqWG/UUSA+OvtDSucoQj1fiV1jRnB8bPcJuM5Y0Yv4oOwwKA4pgbsXjnhvBCR62+guxEzFzYHUbiJnhfTkBpKSne4J1irUGjZUHTROM4gKiDvRKGjAkG600I5ZycuhILzkYgdkblvYi7SqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og6bx3/hRMUT9PmDWlX4Qub0P9mTUyNqQmkCH0pWk/0=;
 b=3db1/cWsbTHwZYLKmdYgs969sT6nCiAqu1GVA9k7Aq+PWYv6zi2K4hYk1h8PyI7yt7t1KLVWblXC1FdQr9yQLJqFIH6K7tbLiUEWRRmcn4PuP4q2N3DHP5G3LcOETvXiv8s0HUorV/zns5bF65iE6YF4aU4pJCHmoQbvCNfuQB4=
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:12:57 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:10e:cafe::b0) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 11:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:12:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:12:50 -0500
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
Subject: [RFC PATCH v2 1/5] softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
Date: Wed, 4 Sep 2024 11:12:19 +0000
Message-ID: <20240904111223.1035-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea5ac22-23be-4526-7e31-08dcccd287b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LGJRYPhExva8TZDqWMaXJGo9U7aDOC1k38wXfAsNabuEP8cnqiBddE38KAev?=
 =?us-ascii?Q?zZkA47SwH+2nsTse+VY3+e1yQXBHVqqOlRpAfyzTXL8obf3ozoG2a8ei/Y2h?=
 =?us-ascii?Q?j2HyCM84y1dcZ+fEma64n8f3X56B9Lz5rq51pK3vY1kfI2rkLTws3U+k7ICX?=
 =?us-ascii?Q?08u3828sqUXYYjZM9TeJxo6jrpu+TRl3mhyXFn6qmCQdVup2jS20en5EGEQ2?=
 =?us-ascii?Q?0+Je9Fe7wwTUEgp30oAPor/J8mRIwEPJoFzU6IIlj3DvKqeMNZv1hW3xEv3c?=
 =?us-ascii?Q?ivL2rkyNGyZC8sMrK0nrH8htborqUB0lVrZMX9UqJ6/KzM4we1Q4bEmsbBl9?=
 =?us-ascii?Q?GfTYAybiMRKvm+srbIvJIBVYSIHr3cf7acLkuNQ6O6KW0G28H8pQnYgFZB3W?=
 =?us-ascii?Q?kUQcIRpslRUvqmIfsBignJgOPE7UjBS3aMZwby1CYMNyAk9Xo/cqBX/gzdze?=
 =?us-ascii?Q?aylm8dIU7t24gXZBryTKKmqyfueWIORVyIiXa/JGOhJYYGDbzf0328CjpsXY?=
 =?us-ascii?Q?1GZR4cUz/QZl9di9Gt7R758Y238cJ+5Gf56svSJRt9rOp/jMjGU43dN8qEEW?=
 =?us-ascii?Q?JAA+9pRTG+EGz1wJyYjtB4ghlyFZMrnVVABzFtElhq8nvWbjQ7eyCyAR4Tgh?=
 =?us-ascii?Q?AU005vu1BdsULIQOCxXRBkOgT9u1uwwbveQHh0pBBitOj2/+N6HedCAIykBv?=
 =?us-ascii?Q?N+jHhDORcV2FZsLrD1Ux2fEn4d2NwXIHkhcLIwmfG9PIn6PPs/DosK3TIekp?=
 =?us-ascii?Q?kx5iRpxfsj84ZafTT4SWFFr0QZuut+nLtshV5IccXK55KMI4YXJuwV+KKgs+?=
 =?us-ascii?Q?57P8zqp1H2630H+WtYIE8Jm6pwB+A1Az8wOBfKZLJPeWsfaqF0R8bmyquwwm?=
 =?us-ascii?Q?VJJ3+CrWBmwmBju7cwz9ZZ3t0qzaMHHKgFUfF+INskPMto9skiXfKaDWH9cX?=
 =?us-ascii?Q?3a/lzl9y7htZxvBMuslTsWj3rMPO1ZTdj3wFL45uBeJ7INa9Mj11DGj8GNsb?=
 =?us-ascii?Q?ja3wv211lPEESl4vGkREzICfcngHdryRWFAE8R6RJLbNkUddJ8EbiaFJZmLx?=
 =?us-ascii?Q?+7Yhefo2bMdkfhexzxcEv9SPuOwkmKwa415BGWKIzQMIQZGOvhmXZf+wLr5I?=
 =?us-ascii?Q?nh9kJDvL/UHQIfonbg62oRGNzX0EF97847yPzZLS4MrdS58VoKSWmLfYmRCJ?=
 =?us-ascii?Q?4IM1gMd0DOAlF7e/QpzRhCldGhtb7MOfr74vqULFiC7jNb1doFcbEnDjUqpJ?=
 =?us-ascii?Q?gWFCZgRr9CNTfJnG80O18KJ5/bF2i8t6fhkwdCE6MXPBXgyaaFUlEtbaex35?=
 =?us-ascii?Q?6z/Wn6HbYecWMX+bEkNiK6cBEhWF946d6teiT2goP9L8xEg1/+YgGpFHFnSL?=
 =?us-ascii?Q?mygR7kjNDUpC49AkaQT6E59D5JajDWWTZmnEV7J+NLHSOA/KvtmgdF+IpssR?=
 =?us-ascii?Q?YaFzdreyMSV56CdgTIep4EV6GVbTCq6NSsBche1uilN0ZJu15de73Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:12:57.0832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea5ac22-23be-4526-7e31-08dcccd287b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
Since do_softirq_post_smp_call_flush() is called with interrupts
disabled, raising a SOFTIRQ during flush_smp_call_function_queue() can
lead to longer interrupts disabled sections.

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") IPIs to an idle CPU in
TIF_POLLING_NRFLAG mode can be optimized out by instead setting
TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
flush_smp_call_function_queue() in the idle-exit path to run the
SMP-call-function.

To trigger an idle load balancing, the scheduler queues
nohz_csd_function() responsible for triggering an idle load balancing on
a target nohz idle CPU and sends an IPI. Only now, this IPI can be
optimized out and the SMP-call-function is executed from
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
idle target. Account for this and prevent a WARN_ON_ONCE() when
SCHED_SOFTIRQ is raised from flush_smp_call_function_queue().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

- New patch. Approach discussed in
  https://lore.kernel.org/lkml/225e6d74-ed43-51dd-d1aa-c75c86dd58eb@amd.com/
---
 kernel/softirq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d082e7840f88..8c4524ce65fa 100644
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


