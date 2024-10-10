Return-Path: <linux-kernel+bounces-358536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F983998084
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148801F27C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FECA1E231A;
	Thu, 10 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dkflphEW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849A1C68AE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548962; cv=fail; b=N/zqxTahqTjYlUGt/4hPU65dryEWGOHMp3oVZKhfnWtMbscI4yUAof9IprxVEgo9TUap+AjvOU/mCLT6Zb+MDWLyYGK4O4cR83bro68aA/DPeFL+DQRdgLWaWtpatCpIAoPdaLfjzyhp3Ofg/43CE8Ky7ylU5EH82zQzts0YlSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548962; c=relaxed/simple;
	bh=jEAEs5vk5V9UDRMUySx2zhIeAGbks41VzLTTGSPfK7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxNQaHrfYHmyqCjuY2nrv5mtiRVF+qEZuBVE1Ff0PSOjpSJZSUnxKUewX/gEsADy2M5MX/20SOm2A65Zb2crJkSqO0UKnHbmsKMKXUP1uX0potrkOzUn3qzan/IFv6yoeyszzuYaWgKbMglRjeIyIQ0Sckx5jA2M3zwHOiWtYyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dkflphEW; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm+jYbCkKtROog4Xu+A1NM8q6cP0Qm17iTkvscYcn3s0yhI1B8z+iiZtBXwDUl6fOuEjb/qILPzj5b/MwIyqCG2KltpYRKC3okpDOKBT7aB/5M8rF7b6cPrmAcap8YcyJzIHPMm6UsKwNyAXxEqQ45bQrLzHvyaLAIAT+NNnJtTlhr12N6Iovv/TLDZmU//vCucZWbeTkD1dRxv5fAeaITNYxxTpoYk3gwoNTzZBLFPvTvFJ5ytRXeObdF7fUM0vqnZr5fGtB7E9wEWDuHYSzDGOoIpJcpQY4xaS3GL9aTE2snp4LcGZtHSfnRVNlqSNf9zDBZ0mxDIHApeMpGXscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5UrynU+V8V5w0JzMuuOJ3jjg8Jvl7/yaLglePxwQ+I=;
 b=Zu54HoydCnwjCCJUXm5dsGoBAPPwncaFNv8P1j7itKfxjOQVhGAg+1+ZANzqCMvEtms4Is0HLNfWp49AumSzIrjZD4TtNgEpB0YRHVHuYx1HeoDNdr1hG58yrjY4i8yUlI2izqRB3St6IKSUX/fhRAlgY29WO1pZsEeZwfG3HX2sqw7JxqpYH8nc+g/tQnLUAflYejuKQn321sQ+CBQRblQmpWoRx3WNn6X+gSV+gmwoWLyPP36VrSeYrtBmh/03f74v4iXHQfOEkx7A6yfp5n16758mqWqXhk8q0eF72+BT6PXUJ3XFTd1zC1N0ulhuKrg/MKr39OSv+kpoMelupw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5UrynU+V8V5w0JzMuuOJ3jjg8Jvl7/yaLglePxwQ+I=;
 b=dkflphEWWJg3ChHeq5lY3+KOGFz5bVRoluXgyZAU2iRdvaBBlhuR+mW34ZL9kGCdlIyCiud0OA7wXIdvVVOpqbA3pOGXv/m37T625XJAVQ3izUZ1piZ837hydVbPC6C/tUyIg3wNpWPGXNolV7mWmnwd/srCWkUFgeTnpee1Ts0=
Received: from MN2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:c0::18)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 08:29:16 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::40) by MN2PR05CA0005.outlook.office365.com
 (2603:10b6:208:c0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.7 via Frontend
 Transport; Thu, 10 Oct 2024 08:29:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 08:29:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 03:29:09 -0500
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
Subject: [PATCH 0/3] sched/core: Fix PSI inconsistent task state splats with DELAY_DEQUEUE
Date: Thu, 10 Oct 2024 08:28:35 +0000
Message-ID: <20241010082838.2474-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 901c0810-0699-4819-197d-08dce905a063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x1z5TdsCrSYOmbcDAMckgNa/z8sC+6ovLtSy4UD0AjFKl6CFcy6kLVUA0FZj?=
 =?us-ascii?Q?S29Kgbd/RdF/8Nio/vH3HGPAu9eje+/U0uGMv+sWiRhK5quoS7nETWVWw4BR?=
 =?us-ascii?Q?bc2w0WSL7x4gGanbBeGy5q7Tb4wOumuqvWm77bUG/vGejNKxWeBOqJ9C90ne?=
 =?us-ascii?Q?8Mqkp7UQLfBc7qJ5f4fKWr0zsjqSz88/Ly+im40rVlGZQdb6UmUSyNxqXtDd?=
 =?us-ascii?Q?rNe4+LukGC72XN7uC5uIn8SxOuUHya5JdU0LF0GfPeHvQcD2hYBRye6kyhEP?=
 =?us-ascii?Q?VklRLH/hAAHRofBQ1lDmaAZs5dCqU1bkPGk4JA9E658eX0TW1jp7tD5XRAuo?=
 =?us-ascii?Q?RD+fBkENaXf7Fuqb/DoMfTLHH8LCmmytgE7Heprn2qR4VhxtL+F9F+iUX/Me?=
 =?us-ascii?Q?vMVXJlI7HfAIJP/TdX5aKAimhNQwBknC8ADBkVBLNnMV1DFpHPALo3Gzhyzv?=
 =?us-ascii?Q?aKOnj/m0FGzPLe1uWWxvCi2wHrQ0rBrE59yVqWGLvjlmiAbi7kohXBU0j0Da?=
 =?us-ascii?Q?o7qRi2N8MZXb5ur5VwViThB/mQNtw+7XSr5BDayQthW0Cpi3mKkmZjnm5+Ry?=
 =?us-ascii?Q?IG+q6rtHAdXTD8NKynqY0qTslSzIYDG60wAqfqK7eeZUh7SwzZb6ZsDvN0js?=
 =?us-ascii?Q?eb61WKM8mDL2OEQNZwMzebnMdewAChRtRa7eds6CkkBOIJGAGQFxUbM61du/?=
 =?us-ascii?Q?PZHHBUh/zUH6EWU7pOL2UGTDLBnMJ/K7RgoiapudeHo5pq9zsvSOlri8eq/b?=
 =?us-ascii?Q?WKomi1Zv9etrWswctb75tiiXmMVcm2H10TPAQWz/tUOVTSH0BYz32DvEZIKW?=
 =?us-ascii?Q?Hd76L9aTk9yezVXr7v5iu9oxZw48M0gvP7+zECdgFfnFPR0kiNT2awnIgt4h?=
 =?us-ascii?Q?gUxtKiDabz8K0u9KxigZyojveasEp8xWvTIRyBFL/WJ3mVVPvPT6mesrlnnb?=
 =?us-ascii?Q?KQeEblopWGyQKbaYn3Sai6HRbu55N017sTh6z3su71SvL71F5wHI2rBektsN?=
 =?us-ascii?Q?jXGIeQS8WzKEfwjRTEMHTby4IEnd5K7oCeWvdjUvqfDyxVcgcWsbqHqTTzgq?=
 =?us-ascii?Q?UnI0Zn0hMxivywMUP05WjxEHCiqkUlioGe/tgOJlHFteRUg+cyyE58UUj/QQ?=
 =?us-ascii?Q?UzWRpyQCFLUwmiBDcaAnXO0cU03d+Sqgzn5Rz1S5og24Nm9Ofup8vYyXdpuq?=
 =?us-ascii?Q?evd96Oqk5gcESichClrkZsHvOfUqCrV9nba1zODFIAC6bHcXwdBYabQxsA35?=
 =?us-ascii?Q?0V5mL0cifDe7H9J6MPAUTAFsXMQItGIh+g993NOtt/rsV+zpwKwF4igB+lyM?=
 =?us-ascii?Q?YQ8tWVOtViYdw971hYF6AU9VqFxWvD08TNeXD9489fNMOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 08:29:15.4100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901c0810-0699-4819-197d-08dce905a063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126

After the introduction of DELAY_DEQUEUE, PSI consistently started
warning about inconsistent task state early into the boot. This could be
root-caused to three issues that the three patches respectively solve:

o PSI signals not being dequeued when the task is blocked, but also
  delayed since psi_sched_switch() considered "!task_on_rq_queued()" as
  the task being blocked but a delayed task will remain queued on the
  runqueue until it is picked again and goes through a full dequeue.

o enqueue_task() not using the ENQUEUE_WAKEUP alongside ENQUEUE_DELAYED
  in ttwu_runnable(). Since psi_enqueue() only considers (in terms of
  enqueue flags):

    (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED)

  ... as a wakeup, the lack of ENQUEUE_WAKEUP can misguide psi_enqueue()
  which only clears TSK_IOWAIT flag on wakeups.

o When a delayed task is migrated by the load balancer, the requeue or
  the wakeup context may be aware that the task has migrated between it
  blocking and it waking up. This is necessary to be communicated to PSI
  which forgoes clearing TSK_IOWAIT since it expects the psi_.*dequeue()
  to have cleared it during migration.

The series correctly communicates the blocked status of a delayed task
to psi_dequeue(), adds the ENQUEUE_WAKEUP flag during a requeue in
ttwu_runnable(), re-arranges the psi_enqueue() to be called after a
"p->sched_class->enqueue_task()", and notify psi_enqueue() of a
migration in delayed state using "p->migration_flags" to maintain the
task state consistently.

This series was previously posted as one large diff at
https://lore.kernel.org/lkml/f82def74-a64a-4a05-c8d4-4eeb3e03d0c0@amd.com/
and was tested by Johannes. The tags on the diff have been carried
to this series.

This series is based on:

    git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

at commit 7266f0a6d3bb ("fs/bcachefs: Fix
__wait_on_freeing_inode() definition of waitqueue entry")

Any and all feedback is greatly appreciated.

--
K Prateek Nayak (2):
  sched/core: Add ENQUEUE_WAKEUP flag alongside ENQUEUE_DELAYED
  sched/core: Indicate a sched_delayed task was migrated before wakeup

Peter Zijlstra (1):
  sched/core: Dequeue PSI signals for blocked tasks that are delayed

 kernel/sched/core.c  | 25 ++++++++++++++++++++++---
 kernel/sched/sched.h |  1 +
 kernel/sched/stats.h | 10 ++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

-- 
2.34.1


