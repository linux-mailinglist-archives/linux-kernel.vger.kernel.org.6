Return-Path: <linux-kernel+bounces-358539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E778499808B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A3D1C27446
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD81BD508;
	Thu, 10 Oct 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rtzkaLnX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DD1C2DC8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549018; cv=fail; b=tuQDnd4ntSTQ4VmxDyXu2KBQJQOmiRqOX+zeyOtgWqBcMIIwr2YWyM7K8VR6Q5xUcnTfRVqF5qne8bsELGDFsgZR2gNvYrU4l0aQumEiDdjur7EB7cjNXU6F03gUsvG+WN/UHPnT3mFPOp3r8pbTI/EaO/wRsAoVApSmASCED8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549018; c=relaxed/simple;
	bh=nbJP8WRnCjnBhKbuGtdSj/ZNwLdbZaPTvZT65ZzOOZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sv76N5v8z++KdFNgcsFuBkmh/mzwemHO8HSu0nRzZgucZc48pAn5U8DD3CskW5H+1fDKhlhU53/pJHup3kbdfpwFaUjs6slb5repHIzryILwfXvTBUlCxwjaG1ysJA9HxZl4NnO6M3scYKFUShCTlbUR8ciw7cnQVV1KQkgGEIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rtzkaLnX; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrekyXAXoKLM1PSOuuwrEmKZLJGRiYLMtOB5ZgLIOKeoKKHmRE/VvteBewBmPLoaKiFllYwuCznc/pd8b4LgaYqckoh25iSvIc76TV9NZI43+eIvMLIT+Nte06i8qeUIb4Brk+5Zk0SMqti3nJLQbZVTy+zhLySv9/WIzEbudsphX3eoVjxOKIf3oqZBI4O8Ssq4g1WMW1Gqaek1+yCeZaAkuFNqQLkhnbWItV3YP9qHi+eXeOnTt6MHT1UTKnR7cqt5vn9m7oRl1n92q5BQGUi2hD1x4dJPDpxFhsHFqT+mvnROiZXs3fhgcHXho0kC6Cun+UR8HgtEMCYyPxshcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll/5a6F3CswLgcNZn8xXuTF5Uvq6c1j7yM9pajEzP0o=;
 b=LqLr2s7v0VlkcyQ6At8Ysj+8qySAF2nl6WXeTuu4C/eoAua9Ou9YL5ltyNUVBeCu5PVBqAByZWuuVolSJM+ryMjBzuxjq7MbMV4nSly3uXSU64ibqswgTNDnwRHyMwHyS1cjx8X+REEkTlzfDRiMxSS/FSRPcEVNXCmdA75w7qew5reJGhZ7rWbMc3SS4kr1SqZMvVxFCcxgXkzxprrSesjdM/Mv1hcBhpSRivFIYgXK+sD8wJ3ansk0/nR5SiqmmQ94gKsDm7dgBywniSmeRlP2Qjuwh3Rwr3+hA2+Ewck1NTj01TKVIy8XT28o//1HUh5nPwGtLCJhK2w5Y7ndJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll/5a6F3CswLgcNZn8xXuTF5Uvq6c1j7yM9pajEzP0o=;
 b=rtzkaLnXszwWNdxwsxuNVxDj4dPEZAKA/7TvEPBeqvpoV5wBdcoOarnJqCFzezK6FG+lqj60j6YLHCo3m6imR/8zFWINieNFQu5RTc8scviEC5N+H44ByFCOb/Kps7a4MirLvx1tZGu5A0LLXlDjfxpAC9y7E2CQQeqm/KHrZY0=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 08:30:12 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::4a) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 08:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 08:30:11 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 03:30:05 -0500
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
Subject: [PATCH 3/3] sched/core: Indicate a sched_delayed task was migrated before wakeup
Date: Thu, 10 Oct 2024 08:28:38 +0000
Message-ID: <20241010082838.2474-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e426f38-079d-45be-2a4a-08dce905c1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xXpb+KcPp4/Kr/fYldIf8WTNXc+5YlyUKEB8ldcvay0NZCHLy5tFK25NJIMZ?=
 =?us-ascii?Q?x3wgcESNkFnkSuf/pIXy6AsrNVp7x27euApKAt2O4oaere3GXlDy1jju5UFp?=
 =?us-ascii?Q?XEyM2DpzO8KtX75mR4r07EMDn2yybSVWz6XaX0sEkH3ETmIhMMTlVsoWhVsY?=
 =?us-ascii?Q?/Te4Mt9uTfuSxWal0tdiXdQb2vUsqp7nxKGqSI3YBIcyUQNX/Ci0UzqtLGL3?=
 =?us-ascii?Q?V67s5ls53b1YjdjogepRCLGUJBiVJ0SOKyuVcoXgGSS0MymoDNfRsWr7RAMd?=
 =?us-ascii?Q?jX6I2T6jWYBy0RN/WCN1jC+B/s19r36bgibqTHAtMcI4BzsbRlsHDFnVOIEL?=
 =?us-ascii?Q?+Q+kXzh0Uu4xOGHq3jz1wdxIcRXobiciLvtjbm5QfyyhEQILPRYoVjuNnngD?=
 =?us-ascii?Q?7y+DYl7/he66SKQXFLQSYtQnIYFX+AENuvKeVcbUXc/ZtmEg5Deqx/59TTrq?=
 =?us-ascii?Q?8iqJIy1mK/hQ9QR7Bxfr+u4O3ODMy3Z0lmernzaJ9HL1LUhtbv8eKXNNTjXs?=
 =?us-ascii?Q?6xVwmhHA/A9oSx4zQ6Ey62Nb0nYfa4FvbaScuYnL7TgWPf3j2Vurw+SOOJpN?=
 =?us-ascii?Q?vt5B24wI2SkQagf2dNsrq2D3bMeOE2sXe0Ovfb1WkdV4QCVVdP4QEzm1UJYm?=
 =?us-ascii?Q?mlve1ecpHghRbkyN5nOzI04H3vxLGyFRheVnQUk8bcpcrWuCL9GcvXwfHt3Z?=
 =?us-ascii?Q?hhoi6vfdKJzZpyEkf2lnwyFSilRuHGBMT3avZAaeHfoVPBo9LpryiH/6/are?=
 =?us-ascii?Q?bSJPfZuuvnkVjB/HyjYIRoepXpkAG0pL/9Vq/+1zi7sM8AHmALVCxNQXe+wX?=
 =?us-ascii?Q?X66cKxgkMRb/XVXjleaILC4JnY0xb1OHg3skWfpLpf2CegrPTHGqzkuxr8wM?=
 =?us-ascii?Q?9GU9dLQUf8ANJsFtejzh7DxTdCbVhiwJvOu7BQXC3hSVntbvUSp+Ysc+PLub?=
 =?us-ascii?Q?a4xOSXKN+pnsJUNBi7y5Ntd6p/IG2R5MK/OCiVvqBVCQ1waw4YxWxi+wQdBp?=
 =?us-ascii?Q?2lzSSRgaVjvMGu99tljwPINfM0sJ5C5x6HpFXe87RqSuCkHayspwkDQSbyUm?=
 =?us-ascii?Q?iH8TeT3ETaiyw3STribdJliui5UJj7qe1jcCrez2ZgUUgbyNtv8+P2I4u9PP?=
 =?us-ascii?Q?KRUCVzlYG1NXsynl55Pc9qPQpWMj4TtlhJuCT94+lnaJ0tCh/tyP7zj76bOw?=
 =?us-ascii?Q?BZpTXNTO8vxn34VKMD3pJJs2pFUbnlO4dub7XlxpdtKI7kn6UP7MsISsqpMt?=
 =?us-ascii?Q?pjS4nc0CwJbc+wzsPEYHk38gTbyxM3CcWOpLSapL8g7UJzGUV1QDydxK+zC5?=
 =?us-ascii?Q?9bNL3upmTwaEpMV2hpqaFZRz5I0BBKpljTD1lbRwbWiSeCawpkUtxGBVISWZ?=
 =?us-ascii?Q?zqZqnRthShskbnrHYaG3XZMHdjQg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:30:11.6312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e426f38-079d-45be-2a4a-08dce905c1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087

Since sched_delayed tasks remain on "rq->cfs_tasks" list even after
blocking, they can be migrated from one runqueue to another in a delayed
state by the load balancer. When they are eventually requeued or woken
up on the same CPU via the try_to_wake_up() path, the eventual
activation is clueless about the migration. This trips the PSI
accounting since, in terms of enqueue flags, PSI only considers the
following as a wakeup for PSI accounting:

    (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)

This can lead inconsistent PSI task state splat similar to:

    psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=. set=4 # Without partial fixup from this patch
    psi: inconsistent task state! task=... cpu=... psi_flags=0 clear=4 set=1 # With partial fixup from this patch

Tracking the PSI changes along with task's state revealed the following
series of events:

    psi_task_switch: psi_flags=4 clear=4 set=1 # sched_delayed is set to 1
    psi_dequeue:     psi_flags=1 clear=1 set=0 # dequeued for migration
    psi_enqueue:     psi_flags=0 clear=0 set=4 # enqueued after migration
    psi_enqueue:     psi_flags=4 clear=1 set=4 # wakeup after migration
    psi: inconsistent task state! task=... cpu=... psi_flags=4 clear=1 set=4

Moving psi_enqueue() to after "p->sched_class->enqueue_task()" and
skipping enqueue until the delayed task is actually woken up (referred
to partial fixup previously) changes the above scenario to the
following:

    psi_task_switch: psi_flags=4 clear=4 set=1 # sched_delayed is set to 1
    psi_dequeue:     psi_flags=1 clear=1 set=0 # dequeued for migration
    psi_enqueue:     psi_flags=0 clear=0 set=0 # enqueued after migration, sched delayed
    psi_enqueue:     psi_flags=0 clear=1 set=4 # wakeup of delayed task
    psi: inconsistent task state! task=... cpu=... psi_flags=0 clear=1 set=4

psi_enqueue() tries to clear the TSK_IOWAIT since it believes the task
has not migrated due to the lack of ENQUEUE_MIGRATED flag in case of a
requeue or a full wakeup on "p->wake_cpu", but in-fact TSK_IOWAIT was
cleared during dequeue for migration and was never set again.

Define "DELAYED_MIGRATED" and set it in "p->migration_flags" when a
delayed task is migrated. This flag is consumed when the delayed entity
is finally woken up, and psi_enqueue() is notified of the migration.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Link: https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
Tested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c  | 19 ++++++++++++++++++-
 kernel/sched/sched.h |  1 +
 kernel/sched/stats.h | 10 ++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 52be38021ebb..1a353fa69a54 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2009,12 +2009,19 @@ unsigned long get_wchan(struct task_struct *p)
 
 void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	bool wakee_not_migrated = (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED);
+
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
 	if (!(flags & ENQUEUE_RESTORE)) {
 		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
+
+		/* Notify PSI that the task was migrated in a delayed state before wakeup. */
+		if ((p->migration_flags & DELAYED_MIGRATED) && !task_on_rq_migrating(p)) {
+			wakee_not_migrated = false;
+			p->migration_flags &= ~DELAYED_MIGRATED;
+		}
 	}
 
 	p->sched_class->enqueue_task(rq, p, flags);
@@ -2023,6 +2030,8 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	 * ->sched_delayed.
 	 */
 	uclamp_rq_inc(rq, p);
+	if (!(flags & ENQUEUE_RESTORE))
+		psi_enqueue(p, wakee_not_migrated);
 
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
@@ -2042,6 +2051,14 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & DEQUEUE_SAVE)) {
 		sched_info_dequeue(rq, p);
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
+
+		/*
+		 * Indicate that a sched_delayed task was migrated.
+		 * enqueue_task() needs this for correct accounting
+		 * when the delayed task eventually wakes up.
+		 */
+		if (p->se.sched_delayed && task_on_rq_migrating(p))
+			p->migration_flags |= DELAYED_MIGRATED;
 	}
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..2dc2c4cb4f5f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1326,6 +1326,7 @@ static inline int cpu_of(struct rq *rq)
 }
 
 #define MDF_PUSH		0x01
+#define DELAYED_MIGRATED	0x02 /* Task was migrated when in DELAYED_DEQUEUE state */
 
 static inline bool is_migration_disabled(struct task_struct *p)
 {
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 237780aa3c53..06a2c6d3ec1e 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -129,6 +129,13 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	/*
+	 * Delayed task is not ready to run yet!
+	 * Wait for a requeue before accounting.
+	 */
+	if (p->se.sched_delayed)
+		return;
+
 	if (p->in_memstall)
 		set |= TSK_MEMSTALL_RUNNING;
 
@@ -148,6 +155,9 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	/* Delayed task can only be dequeued for migration. */
+	WARN_ON_ONCE(p->se.sched_delayed && sleep);
+
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
 	 * avoid walking all ancestors twice, psi_task_switch() handles
-- 
2.34.1


