Return-Path: <linux-kernel+bounces-314853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8883796BA01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DAB28554E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC81D222B;
	Wed,  4 Sep 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q9QnUCKl"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807CA1D0496
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448443; cv=fail; b=WrAzS3Vevkroonneo/fYzGE0DYUsBAuc/V8CtMp/dA+n3cKJTdJ9RodaX5956u6Xlm1Ia9ABLZqJruNR/at1BLMCvrf969tH+vONBHTnZeo3ZGpjxlp6LzxgH9hOnHnmmLNXe0hAjxHgcwWnao7RlJYdyQXuiP4SUsodPJ5AVyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448443; c=relaxed/simple;
	bh=rW9oMdchcSXhTxjIhP42sq/2bvWvY5nOLqf4/4xokzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5jRHe10PjSkBdmTBLIRtEIG05ITEFfEMQ1Cg0IXZ/HsDGcKlJdwcE+V8A7G5S8GzRBHFaOVSNxaiRK8dtDIKEUBbjTGvNys3kUB2Rwjen5Obd6Y2JWwBlw+C6j2WVji8e+tVeMZpoyezqG64BqSj4tLoXg76HRqPjdycUy58/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q9QnUCKl; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuroHaK9Ev0LeFn92PSDbsvDKqp7moa8rcTfMJwG7P8WrGZIV2MNzXex10/6QaAjfIlZoH74cArVLkOlCUYzVKylblgjyGDDYgRfhAwc7zA7mCjeqhGDQ7bfXZDeU3aTdXrCJ8PrsvBtVpNy8CUwuroICd5gba5AQ4pGV4sAGhmaKAmM290ggETX8UZhBAq2g1Ckci64zBAOBjS4EpPKqaeeWrjj4KkuleFLZ3+Wn2tOx+55LDSzQll5cdURHOHscb24qvn52sqeIJyZMiIot3U2zcs7tS/6xs6G3f78muEWCWKTJNbFIivDBjDM7pGDMmjiktd0mkfHbMdPKKiqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J+HF716Z83F8jQvwpIqkoxs5ThrrkXqT7/zvYwyuL4=;
 b=dGsobRgl1MMQQtJyi7+dkllsVbz1NyXIjE26EzFCjBoDJSJgrGl7UtPfRVOMlfJaFhKXmlZkW3EQkz8VrUDNKaC2kqbZkb+Ce8cA5dYzNc8X9vOo/nnfJK8HKkg/+hQBW98T/jS90vOJpbCqFVyMre0cuXTSFpRkZhmaUv9oaeqMF/+xzsXlsKl++T6TaCDa5wB77F45ifIAdBpvzUKBji7alxHuq975yg+9T3UtXWjhfede/FAS7+h4Pkdoyu5emLn4pfRT0F22dEEg1JxWdpoRxjFM6D333DnPlXBGPsTZGLPBIrQe1Y2JiEBb6hlrMSzESIqoVt7jaAxp6BoJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J+HF716Z83F8jQvwpIqkoxs5ThrrkXqT7/zvYwyuL4=;
 b=Q9QnUCKlns2TImqUhqmIl0YjfgZagRrmjaV/+2L8Ez16tH/v+2Y7FXDEr9iwA503LnHTcNjhI0BQaaLs2FcGC/b/0mcIv/BI7Gru4EXZu0pMn3/muKjkvtB/IDAesdD09gH1SJIfWTaB2OLggO1Tk6SJtLAIjp2x3raV/eLllQg=
Received: from MN0PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:530::27)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:13:56 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::94) by MN0PR02CA0013.outlook.office365.com
 (2603:10b6:208:530::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 11:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:13:55 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:13:48 -0500
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
Subject: [RFC PATCH v2 4/5] softirq: Unify should_wakeup_ksoftirqd()
Date: Wed, 4 Sep 2024 11:12:22 +0000
Message-ID: <20240904111223.1035-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: af520b3b-d241-41a3-1925-08dcccd2aa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DihNESGGPHwr1IcaO+OyYiWkjpUYnIXmtGAvJVIMQV+FWBvamx3NyePDxCNf?=
 =?us-ascii?Q?m538jvs11LyWZtSs33U6wqxyV1ISgfMkLjjQAcu6vxJU4fEhN2T+6BMi1+Gv?=
 =?us-ascii?Q?e5tT5pbU9VeJXoQhyuEw7iYndjaKKfva5yPrwaylyqg304pdWPXcEzjFIeQo?=
 =?us-ascii?Q?I9AzV6iUJlvGm6SMNuXMUGgAijveDNV0Nh+nJfsTRu/ltoDU8ykP1hxN8FP4?=
 =?us-ascii?Q?jlEUoANNdxG0DG/AAu1EoqpNAxkuLcjZpXObzAUlQWWjaT5ZvPwTh8MQu3Qp?=
 =?us-ascii?Q?wjjaNbMNWireGESL+F2f8SUTcOSct037XodsxdBe0z6lZOthlNvuFhepuRuc?=
 =?us-ascii?Q?Wu8DyRVgaXTVMh+RU3SqX7f6q71nOsiRk8eYxn/p/dgL0Dz9NXVk39aQOMlB?=
 =?us-ascii?Q?9ZY8TtINjyWWgkayGju3EgWFhRYH9OoZtPoj1+t+9LEa9vkePyjd4Q0ftJ+D?=
 =?us-ascii?Q?/Pi9CCklkp9nMESq+jfKb2ENs8Kdk44YLjxuP0cEHHvEfJpWw4qqVPotO6lz?=
 =?us-ascii?Q?VjZkWZh3222iH0NckveEmb6HdYpF00BXSCVdMeoKdCrigVNUh76o8AzO+K6R?=
 =?us-ascii?Q?jH5yiUoUmUYpUHP8f/lXCg3rc7WAadSYGjDkKFWYtQJ6/lWcVxAZGcPHTvBF?=
 =?us-ascii?Q?Klh5IHBx59F4Ulljh492PPJHYkN/y7P/7KqVG5524DTPnh0OCzkxcEIWYn60?=
 =?us-ascii?Q?C+C1Mms5c/Ge8jbdDlteBd34LBQfAWSVtl1pwyMMONiqWrEWtKozO4DpRdUz?=
 =?us-ascii?Q?sMOPrZpvfRcVwc/JYel3deLrp5Bf+aI1Noc3WlkeM1I+01u5Li+dLNQvBMHF?=
 =?us-ascii?Q?flBnhHn5DH2r1X5qbHYPL4cdg3rWeS7M4Hm7eLVofPry0M2RSvmo0oYW6hJm?=
 =?us-ascii?Q?x+eYdtUTvmlXtvO4V5UoJjXv/YBlIh1+sr9eus2TvfoHlYLT7v41+Wi4IIhB?=
 =?us-ascii?Q?iqsc2Jz3u6MhF9eZqLDDw2lJUZs9OGLhYAt2xox4MpSqvh/0JKlTV/G7j1kX?=
 =?us-ascii?Q?+06YqHgJaBuiqXiP4Ht1wVAAvcbAOS5WdRDZ9/w0hOmiRtqauJXb17YzKud1?=
 =?us-ascii?Q?ZHJRKzqE2gAI55JgNQ5xTfW2H3otXqlTcFIUVkGyQ3fqYupMDJ7oDmBIyCS1?=
 =?us-ascii?Q?sb5Tynu3DSyq7wgqohej4vgxbdCigI/eUF3ysMfn4Ym+ycJszKbiBDb7M5HL?=
 =?us-ascii?Q?1aIsRLQZ4eNndM//cTZrBvCdtnC5+yPSqqOL1Erc7O8fSwuXLv/v7QkW5vhB?=
 =?us-ascii?Q?gXw5gFGPZ+e3mCJhXtzaNPAFQ2I03khY/mkkhrp0Qt3CsvS+vJwxzb456c2Z?=
 =?us-ascii?Q?zkdlL27myrjFVeRIUlol3YcezFxrc4+uDPDiZ0tIRwwG17pnRackW1F2eSmC?=
 =?us-ascii?Q?w+iHMw9+yDM7hsx8jY2vmkEaccZCeDRYnjgAUGWxlEBYsAE60XGBr/+asprY?=
 =?us-ascii?Q?cXD+bTrGCFkvXd5bFSETAts9302B+9QtDp9xaXGBhu3NyznB9raqlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:13:55.5951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af520b3b-d241-41a3-1925-08dcccd2aa93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

Define softirq_ctrl::cnt for !PREEMPT_RT kernels too and unify
should_wakeup_ksoftirqd() to return based on softirq_ctrl::cnt.
Since these counts can change quite frequently when running interrupt
heavy benchmark, declare per-cpu softirq_ctrl as cacheline aligned.

No functional changes intended since !PREEMPT_RT kernels do not
increment the softirq_ctrl::cnt (yet) and should always return true
mimicking the current behavior.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

- New patch. Broken off from approach discussed in
  https://lore.kernel.org/lkml/880f13fd-753d-2c5a-488a-d75c99e8dfa3@amd.com/

- Cacheline align softirq_ctrl since benchmark stressing the IPI path
  showed sensitivity to softirq_ctrl being aligned vs unaligned. This
  was also observed on v1 and has been elaborated in
  https://lore.kernel.org/lkml/20240710090210.41856-4-kprateek.nayak@amd.com/
---
 kernel/softirq.c | 55 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index e70a51d737ee..d8902fbcdebf 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,23 +88,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
-/*
- * SOFTIRQ_OFFSET usage:
- *
- * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
- * to a per CPU counter and to task::softirqs_disabled_cnt.
- *
- * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
- *   processing.
- *
- * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
- *   on local_bh_disable or local_bh_enable.
- *
- * This lets us distinguish between whether we are currently processing
- * softirq and whether we just have bh disabled.
- */
-#ifdef CONFIG_PREEMPT_RT
-
 /*
  * RT accounts for BH disabled sections in task::softirqs_disabled_cnt and
  * also in per CPU softirq_ctrl::cnt. This is necessary to allow tasks in a
@@ -118,14 +101,40 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
  * the task which is in a softirq disabled section is preempted or blocks.
  */
 struct softirq_ctrl {
+#ifdef CONFIG_PREEMPT_RT
 	local_lock_t	lock;
+#endif
 	int		cnt;
 };
 
-static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
+static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
+#ifdef CONFIG_PREEMPT_RT
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
+#endif
 };
 
+static inline bool should_wake_ksoftirqd(void)
+{
+	return !this_cpu_read(softirq_ctrl.cnt);
+}
+
+/*
+ * SOFTIRQ_OFFSET usage:
+ *
+ * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
+ * to a per CPU counter and to task::softirqs_disabled_cnt.
+ *
+ * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
+ *   processing.
+ *
+ * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
+ *   on local_bh_disable or local_bh_enable.
+ *
+ * This lets us distinguish between whether we are currently processing
+ * softirq and whether we just have bh disabled.
+ */
+#ifdef CONFIG_PREEMPT_RT
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -270,11 +279,6 @@ static inline void ksoftirqd_run_end(void)
 static inline void softirq_handle_begin(void) { }
 static inline void softirq_handle_end(void) { }
 
-static inline bool should_wake_ksoftirqd(void)
-{
-	return !this_cpu_read(softirq_ctrl.cnt);
-}
-
 static inline void invoke_softirq(void)
 {
 	if (should_wake_ksoftirqd())
@@ -419,11 +423,6 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
-static inline bool should_wake_ksoftirqd(void)
-{
-	return true;
-}
-
 static inline void invoke_softirq(void)
 {
 	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
-- 
2.34.1


