Return-Path: <linux-kernel+bounces-358538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D661499808A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D52283381
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6CB1E47B0;
	Thu, 10 Oct 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="im5Buc1A"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0411E47CE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548998; cv=fail; b=qrO0ufH9WbFRQk83V93aTdpRUvEmHlSzJA1K+n+/dkt5wXgG1DyytotddRa76wWHoOaXIxuxekOupbZnvi4tp28RL2UbR9CPQkKNz/3wA79QAMI4C85MXor2H6mBH4xSEwGxE3UMO1wRHAtQznYytp6fAD+qCCzRlq1kML8Gjy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548998; c=relaxed/simple;
	bh=XF30CN7cWmudARMquoHOZyuFyy9SaKpDMg+DZXNSi8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA1aHc03KiZ5ZIsAqaO4yrGLBBpTvtPr9UHDXbCwz3ndGbFkllPBZDKaK4tLedIRt/DjWnvDJSzo0UmcRNx3JS0YqoQfNmcIBc/y+03Xh41nRvmKgArRxiRg29vvh6C74uxvDCD6ZntU48FDm6qDvOOroBnq1CKpAlgH65nAyi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=im5Buc1A; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVATg5wYZkKQe4uul2O500HMrdG5swMWP9NVPT8E7JbeWPaz5e9cBju/pOFLonhWG5ZbBX6INkOCrdTpgVrhNIJ7HFc0rpn7rxf7yjFiHIAArV3LdAEDe3xSjslQ/gw7kc8U5dLwOCrSOHCPaj4NLq/qaERk/pVGPlhh7NyKLiUd3kHi6bnBUSNkNNZTY+7cAnStY5L+EQZP0wWcPmcV/mVV0gD7swCNbjt36U/gvSqYoRxCgI0KJUfUJD0GtD4QeMcOMoR/gb7s6hLT9n1s8oIZZsYII0YAmJehVicEORqZ/I0jvxE8EEu2ayspIBn+nGA0rq8afbtFCI4QPPQI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRw5K7kejgEm399NaHPqxG2ygmBBVcZmRM0t0JoPNTo=;
 b=kF7aS1EYv/5spiDimlnLvD8cI8ePJD/DuDUWhH77BjMqJKALF3vcsu1ITEzoPOgypM/wvp2WSIqe/8KkN5wXqkZqJ9vQyH3q8iI1Eqznm32wpnWtO5KuLapoTlU/YG5tKq5cYpPD6yT7wvzrxrwqM0vBvrQa5Bt0pPg2GjlFRh3B9y5GsuC79oo1BkbbtdgGeTymL009YrFvMhv1MyKMRH3NYSi7uPKgntscpvYAZKwdU7ZOx6hELfW1IRWhQtc+ooRCrPk7d4nfvYJAmknJjcvk44YGG3gqeedXdtbPF6WDiyxTiv1BbwM63EF7jJNhyETcuLJQPhot15IJxlvTsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRw5K7kejgEm399NaHPqxG2ygmBBVcZmRM0t0JoPNTo=;
 b=im5Buc1AZ6vhY1Y7WWwrDPPZvJp5mEZvB4AtpypVWDYOh9V7ImKBuKRbHJp2qQKwX+B/6J/M/sLU8oZgd8NWl2r1c6qDPyZI8KDUVSPU9tF3chW2h/Um4znXSx73wqdBYuIE79C2Fay/+yTJkIcjj/U1FnH5VSz/nbOMEC3nNrY=
Received: from BN0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:408:e5::34)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 08:29:53 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::d2) by BN0PR02CA0059.outlook.office365.com
 (2603:10b6:408:e5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 08:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 08:29:52 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 03:29:46 -0500
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
Subject: [PATCH 2/3] sched/core: Add ENQUEUE_WAKEUP flag alongside ENQUEUE_DELAYED
Date: Thu, 10 Oct 2024 08:28:37 +0000
Message-ID: <20241010082838.2474-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 438a52ea-b58c-4027-2037-08dce905b6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?74q0omOs68bwPu/H9qCOOw3ryaPCV2iI1XdHw3GCC04rUjL3RZaJwXYCjSQ0?=
 =?us-ascii?Q?SiwA51ETfJbS1+ljdq0GMkqlXPQLeF6NyK1n4q+iVMfN3/bxRAVuUliy03Mb?=
 =?us-ascii?Q?SDDvcow1PTKX+e29cs1boKgfXbpfMkDOxA0GF7S/pVwAfmtc7xBNXLG9L51J?=
 =?us-ascii?Q?QAnM55ZoaYqmF7A/TzHrUro4ylfkHxXHci2wTi3hrjCnesTdmZFvoIhk/26g?=
 =?us-ascii?Q?/WHMhy4nKFuAMBiFsgu/q0ko6u3Ec+uBBSbTK4Kx5C4QXw6dYvlDL2nJzYLb?=
 =?us-ascii?Q?NlL7GUVYUwdjn3kkY+0XGBBe1Q4uvn+yFXyMFqgNjJjFmdUXkUQzwkGAuqMf?=
 =?us-ascii?Q?bnRUt4geLzGIcvPqpeyTwFjszxsbuzEpU5qbUo8/mRu1bjKojEkmqCZUqwVJ?=
 =?us-ascii?Q?WtvDs4tUi7mxL4o2dob65j55Axgdr4dNRGET9qIbnXHcL+AWlIUO3ufAgK+p?=
 =?us-ascii?Q?2R18bG4VVjQ2c8oMp6ynxwskwApOtn5p2or5S4KiGjKONt+ulEQqdZW0GoLb?=
 =?us-ascii?Q?GrsVHiBh7ccZgaHwECth7BKg4kHo8qeOhsAYxD6yF8IVtLe3yuWESlG35SYg?=
 =?us-ascii?Q?Vz879onlwWAEU7CU3CNnoBa+F9YKANmdfnJLfPgDhU3kpxmSOA+y9pM+h34u?=
 =?us-ascii?Q?zRLZ0IcIV15j83RnaUsyk+4gB498HkivQ0tm1Hb+7RqpTGjKXkwjQnm/Rlb6?=
 =?us-ascii?Q?CtpSYHM3MNXmpeRg98aT0+uHEvBXLWVujKX5Ds7//4PK4W7SAqEJs0tKrYkV?=
 =?us-ascii?Q?VGLwYq9KbP1ZDAZEgh860fuDQNG+0UiuCm1kDoCvPTnvc9XtxFLdcLfOztuM?=
 =?us-ascii?Q?O120Igk9LqASXj19CW93iSGFJTRMbGCpnfPvX0mfkhAJ+50lEcXCb3ecr1G7?=
 =?us-ascii?Q?6Xmm4bWzBiZWCvh1MkwT2+YW21zfL8kynFkShSCXcG5DsQXZ3ZdMknuEoeqJ?=
 =?us-ascii?Q?di+SQBPcblupZ8nQmKrL7+AV86c830FyWwDAjkrCoHB51tV3Tx66RGr6vuxc?=
 =?us-ascii?Q?aAH8cpd0yC8G+3XOp14Whlbr2Y5Kl9PST7OWH7tZ8a83KP4zZakP5X2RDXxr?=
 =?us-ascii?Q?cWOxIcHwTnNl25zvexmzSf3qZTjQ5/s6eWl6SniBiZn/bDrB/6yKJ9Mvmpcs?=
 =?us-ascii?Q?9EJIwrzZNGwoIgoWBYqdGa7APcQdQdKAF4W2bcAPibg2upWXdEr967GgqNmS?=
 =?us-ascii?Q?6gz8XxZW+rJSOP5GrhfECwiyTqJdukcmZGdCeJEoHn54EJgdDn5kKM02CRy+?=
 =?us-ascii?Q?uS+qjwYEwi+k3qvfTKVtfzqBETbm2p4PyPIUb0pQw1Hg+aeZwGMUryVqqVfH?=
 =?us-ascii?Q?BEvwGTl2A0GQ7hLEGzfaZNPplT4XftARc+KYCv8tt7364erAJPnkcufFPX7Y?=
 =?us-ascii?Q?MMM0KZVkbK1JWBef9jEfSlnLWY82?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:29:52.7591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438a52ea-b58c-4027-2037-08dce905b6a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

With the fixup in dequeuing of PSI signals for delayed tasks, a new
inconsistent PSI task state splat was discovered during boot similar to:

    psi: inconsistent task state! task=... cpu=... psi_flags=5 clear=4 set=1

Tracking the PSI changes along with task's state revealed the following
series of events:

    psi_task_switch: psi_flags=4 clear=4 set=1 # sched_delayed is set to 1
    psi_enqueue:     psi_flags=1 clear=0 set=4 # requeue of delayed entity via ENQUEUE_DELAYED
    psi_task_switch: psi_flags=5 clear=4 set=1 # task is blocked again but 1 is already set
    psi: inconsistent task state! task=... cpu=... psi_flags=5 clear=4 set=1

The TSK_IOWAIT flag was never cleared onrequeue since psi_enqueue() only
clears it on a "wakeup" which, in term of enqueue flags, is defined as:

    (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)

Add ENQUEUE_WAKEUP alongside ENQUEUE_DELAYED for requeue through
ttwu_runnable(). psi_enqueue() is the only observer of this flag in the
requeue path and it pairs with the DEQUEUE_SLEEP in block_task().

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Closes: https://lore.kernel.org/lkml/20240830123458.3557-1-spasswolf@web.de/
Closes: https://lore.kernel.org/all/cd67fbcd-d659-4822-bb90-7e8fbb40a856@molgen.mpg.de/
Link: https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
Tested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88cbfc671fb6..52be38021ebb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3733,7 +3733,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 	if (task_on_rq_queued(p)) {
 		update_rq_clock(rq);
 		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_WAKEUP | ENQUEUE_DELAYED);
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
-- 
2.34.1


