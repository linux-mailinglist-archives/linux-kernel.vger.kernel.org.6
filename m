Return-Path: <linux-kernel+bounces-358537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B73998087
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CC5A28232A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13131E3785;
	Thu, 10 Oct 2024 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zTW1mSaJ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467571E3773
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548979; cv=fail; b=QZKBtp+DEKLO9xmR3uPuwjPna+/YmhJ36/gjiVTPhMiFH4aHSA4ZCXlj6l7lPcyDggbSwCSjGCRLDyiJ9GQTj3Jd23PZoeEMH9Wd3jfWCj+IBC2CGi2fTyNYWts46RLvdg7uaefB8TAxRymoMDo5tGfPEyMI/A0qsr5ove3DahM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548979; c=relaxed/simple;
	bh=hulwKX8jWsZiNEtFHe9VYYzyLe+Mg3QGnR9P/Tw3xOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLvLU7YiWIC953EOYr2tpSB5dXkuWjhGTtAPdKb0GboyDqhXhJCbUnwBXi2PUJNKervAdKMU5+o2k+WhrEh969tkWquq4AHnQuGJqMEzAFoiwXX1TlcTBX9p87sYB1CPMysonp8nH83Y5QBAwAolfxtRlqdwBWnlJPhOk0fJsuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zTW1mSaJ; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZIp7/tAY1OdlWU8CXQ7EglJYGfBGgb8C3yoxGtLwnshDaCOFXkGL3cNXM9CNJizrbcUwOfm3XQ0/pvMpIZiPo7VGworJ+8iVyA16NpJm57N4g/jX92EP3abaGw3zxCLmc+ViDpcSm8xpqm+F17HRTuvwxqCj0Kw5ARvdFE0wDQBT+L0ENJ9XJwh4zO7bodrSZGXEUKydWDtZW4XZh10GbvirB71NB97LpDf8ITESmkEr4eshR+LF9yjoE8oKwHuwMfjAvCbmHcsJirgQ6sSC+K2G0NM7BEvQlDFOlHV9BeIMoTuD72lDuwdCd6sflmXtk+bB0wCESxnbUgl4K5GvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+cMX++V34JW6/5jOm09lyKyVzUKWmln/w5kZFVId3M=;
 b=tv2jHmKNg4I/H9FpcjlT8EC0yFDWwuYEqXsml4cW9ZhN2xjFKsZNqsQk6JwiOZEnz5Hz71dL8KZd+ftEquzq0R9L0eVHC8SSeHZ3AkjflKxS41//eKFJORMrLGvgI33qQERpz9VGYlXyE50CufmA9m/IKU8dJ2ZkudMI7c4VI1FMs3WroLp69nvFsG96hHYk2amH4w2qTgUywPIyc/BZcYzv31tEEB+Lof8sJCh1yuwdRI9C53qAZ8C8/Wafe04BxDzKZn7lCMqynlQOwDb/ZEE5yf0AFhcSVURIxZkZb5PjYv3mKLBRkB7SAa9HLVeimXlaqYuyAzt19Leqz952nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+cMX++V34JW6/5jOm09lyKyVzUKWmln/w5kZFVId3M=;
 b=zTW1mSaJGDSTFDgwTNQHgZBdMgp5qP5+961p/m/1JKUT+BKuY1htKrZwd391+xFCwxZaYK/ApAiTYLWGH0V2F7etKgTfE27qg8qgBKFBEs9mtrMqIyMIoJP9WS0nIaYuPX7RLZ9xbqdWhxGvAbgJBhK7V6U2GcBbKpvIZEQVMZM=
Received: from BN0PR02CA0031.namprd02.prod.outlook.com (2603:10b6:408:e5::6)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Thu, 10 Oct
 2024 08:29:34 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::41) by BN0PR02CA0031.outlook.office365.com
 (2603:10b6:408:e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Thu, 10 Oct 2024 08:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 08:29:34 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 03:29:27 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Ziljstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Johannes Weiner <hannes@cmpxchg.org>, "Suren
 Baghdasaryan" <surenb@google.com>, <linux-kernel@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner
	<tglx@linutronix.de>, Klaus Kudielka <klaus.kudielka@gmail.com>, "Chris
 Bainbridge" <chris.bainbridge@gmail.com>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Youssef Esmat <youssefesmat@google.com>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>, Bert Karwatzki <spasswolf@web.de>,
	<regressions@lists.linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 1/3] sched/core: Dequeue PSI signals for blocked tasks that are delayed
Date: Thu, 10 Oct 2024 08:28:36 +0000
Message-ID: <20241010082838.2474-2-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010082838.2474-1-kprateek.nayak@amd.com>
References: <20241010082838.2474-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: d8251522-c341-4e41-cd44-08dce905ab89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A71nk6MY8CD4fTAoFvjUP+TrurqXBY0rW/Tp1TB4CRJ+9CxibIR16tyoKOsX?=
 =?us-ascii?Q?RPXpFsYMNmF3x97FFU8lRuH2d7CdN6+73V40Iew5ob1cXqANFttx3dJ40h4w?=
 =?us-ascii?Q?YybUmUfcXdRERBoNatrmFx+08R6GoKSDkbNaPDpBEC12qJlGMSXq4AgVG5K4?=
 =?us-ascii?Q?xNf+QcN4rj7qfWXL5D2glhDEp7kIh2PqAlq7J2maayv2/P6N42BZa8XiELTq?=
 =?us-ascii?Q?p/4nOQjoaK5VGYq0wNWKGPY6Ef/cZj9fIPuWXJxVcKpK2v8V2KNaKxDlHl74?=
 =?us-ascii?Q?YrQcHxoofHJICvYmvnd4y7W+M/G58P+g6w8pAJHKM54jon/QoKTmcpR3jBfX?=
 =?us-ascii?Q?t8P90XmYlFAEyJVZ+J3848qKQR/x4DzxHCzYMnhPpecsPm79NZyT/+ly4EIH?=
 =?us-ascii?Q?hgi+CjkNggQCQZIVyhdfk4qz3fhvW4rNdxQGb+OPbJoZ068EQSexehNcrSVj?=
 =?us-ascii?Q?hLkVu9XYiIqVxf6gqsOrwMVWyF53GZwuPUUfmvNvWBjBKzXjjycluBRB/bcz?=
 =?us-ascii?Q?qqInIn7e8YB9L7H2B0Smai289zzeJ6XZuc8olwUnvjLIInXIR0LLclN9+vWl?=
 =?us-ascii?Q?JtvdqbPrFalWqafzOJIdYFJFQSYNtMsn4KbPEuQ5TV39fpG2RO1fdJPePMqM?=
 =?us-ascii?Q?RCMkcQpfELSe41VNoGoFqcVYlXwEuyX7lPagyeDnmcBvJhFx/3QDA5D1JLvj?=
 =?us-ascii?Q?ztdZv8bj6XJsn4ZayAudTgHJCif2XiAsWwNN5Kty8OuUxnJ64A953QsbgXq5?=
 =?us-ascii?Q?5yAUY3uuu5I9zREUiVM8iJgO2RelJXTHKJvEFzY9I3GkTnksvR4rCPp8Tb0l?=
 =?us-ascii?Q?B6z1JWYQ6GegyIzfdJ/3FM2ZRzVyiXmfXZ5VDfYSaMZ9Ilh13pt5eCuISvfL?=
 =?us-ascii?Q?Qu3tDSvE60XIGviXV9cDAVmoC9mUUffa1DkDlfgrVPCioZn1fHu53SNe7ZxK?=
 =?us-ascii?Q?1ZHHBqJN9txT6YvFHRaCitRGfn1dlB3nBp32Yl+oKL4GtHEUOwPB2CvUcok3?=
 =?us-ascii?Q?8vaP31mErNaoKqHSXMI0h51Gp76kAq4F6KtL4AposFSrqU+C8tL1En1N69Vd?=
 =?us-ascii?Q?ysg4ggIWxAlsi38ZowuF5pXl8TebqQLWru8Y/Yd2448bUu1aDEC8WJdLYK8C?=
 =?us-ascii?Q?c5+FmSDittEYBmCh+B7snRMTETmpyIHZORRyFI8k92LidyKZRTPbBUv6kHuP?=
 =?us-ascii?Q?SHIHeZxd49PGMIg2NCgE1i/IceG82hxHT5vEfFVsloHPRwFI44Gdw1qS6cXO?=
 =?us-ascii?Q?QPgR10wGLhpAAz5svpVIYx4amYhGhyqUV1v3Z+DYgmxZl0ux7K0ic8YLlzC0?=
 =?us-ascii?Q?NZvIzcg+WGLbFAvX0CQa5mWBl3uZz2tQNNSWJx2KNM+QSIchuRC/KxroCSSu?=
 =?us-ascii?Q?6vmNDdkhAeodLIN2x8E1HSWdaiuT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:29:34.1185
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8251522-c341-4e41-cd44-08dce905ab89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

From: Peter Zijlstra <peterz@infradead.org>

psi_dequeue() in for blocked task expects psi_sched_switch() to clear
the TSK_.*RUNNING PSI flags and set the TSK_IOWAIT flags however
psi_sched_switch() uses "!task_on_rq_queued(prev)" to detect if the task
is blocked or still runnable which is no longer true with DELAY_DEQUEUE
since a blocking task can be left queued on the runqueue.

This can lead to PSI splats similar to:

    psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=0 set=4

when the task is requeued since the TSK_RUNNING flag was not cleared
when the task was blocked.

Explicitly communicate that the task was blocked to psi_sched_switch()
even if it was delayed and is still on the runqueue.

  [ prateek: Broke off the relevant part from [1], commit message ]

Link: https://lore.kernel.org/lkml/20241004123506.GR18071@noisy.programming.kicks-ass.net/ [1]
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Tested-by: Johannes Weiner <hannes@cmpxchg.org>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..88cbfc671fb6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6537,6 +6537,7 @@ static void __sched notrace __schedule(int sched_mode)
 	 * as a preemption by schedule_debug() and RCU.
 	 */
 	bool preempt = sched_mode > SM_NONE;
+	bool block = false;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6622,6 +6623,7 @@ static void __sched notrace __schedule(int sched_mode)
 			 * After this, schedule() must not care about p->state any more.
 			 */
 			block_task(rq, prev, flags);
+			block = true;
 		}
 		switch_count = &prev->nvcsw;
 	}
@@ -6667,7 +6669,7 @@ static void __sched notrace __schedule(int sched_mode)
 
 		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+		psi_sched_switch(prev, next, block);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
 
-- 
2.34.1


