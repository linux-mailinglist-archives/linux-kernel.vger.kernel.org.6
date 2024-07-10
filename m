Return-Path: <linux-kernel+bounces-247306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232192CDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8CC2847F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96E18EA8A;
	Wed, 10 Jul 2024 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="chaZkLgO"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3535418EA6A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602151; cv=fail; b=G+3r7rizBGNTwjL/oTgO7rrIsBFW++dZIAN3LoGM+3vkUIhUlJn6VLO5A2sVwjNUTQp5odiYPP/3+FJu74+cvVpJ7T8rB6faJ+NmK2HGxDGz9WSnHCSm29qHnMf8CHnPncxk92349twLhn0O1+M0pci9vo9vFx4jx5KQdWF3j7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602151; c=relaxed/simple;
	bh=wd8E+25F21RUaeIW5Gfhm53xXcecYy3o9nwAz9cO6I8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WvyzoD2PzUxmL6d8hWFLePRlPDQMu5BzPrwkwmDJep4XwAga/EeGAK6DqKIfUyu4+Ik+h5vIxJrdtewPLVAXCKqwQHMpt09lMylD7t5sWlgACDDcYWHDIGMmEEsTAjakm8aELYGSNeR7rlQ6DDrSUhQ9QuhKL5WEB+iCJHTz4WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=chaZkLgO; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUfBVpHbLAV7rLP0QNrrRoTzLfqwrhISk5zFj5DVd/Q5BVXQGa1T0Z9ipGqvPXJM5uwU3h3n+hi5JrpO+g23bxyWZ21c5aATlzJDFfe4J0axK/+dIOkUb18+m5jGAOguyeJ8NPCmL5I/udNAJXOq/JWsw2b+xH1+ujPqbYvDJ+JL+dq55D6p87Arz9FXqOeECNM0VYgzXxrXX+RbJb26vkFsJC8Tf5QTHai61vt7CJKm8rKkfaU+m69x46UeH2hdj0bG20Cv0CvOZsHV68Cg5/lwhovYy8jCp8GfsyBjed5itxGZRwQJyEACOyeBFnaXejOqhuLyNSnATLarPBmlEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wW4iB07vHkursJO+Fp/IYuED0te8s5Pn2VDjBy2fKAk=;
 b=bItyuEcV2DZaa0AM/hkp+sJfmFqlO3hgCxTKfWN3b5rHjrOpgW9Bhy2nprsaKZtp3Yrgt7cxi7ZXH8rgERxSt1lvCTHFUj1iHtiDqFIzMoXjb0nbCj7ljiL64un/2ivOT82cwbUbMOL4pPFZyTTw/BfVEYgWiG4nkJnYHB8+AxY9qmGjXnrQXHzakkDRE4wtOaLXfu1todi0rdHXDKuRGSpyrr5FYDOZO0mbHkycaxProyQ9MKKUVYMhntgIoP/Rax1/iaTXH2XgpGVSawF24nr9vKyeWc0eXMM8xIo1P9lrBtKrPQI85e6M6T1rtaGrSvz0eGWTbbJqycCOf4/+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW4iB07vHkursJO+Fp/IYuED0te8s5Pn2VDjBy2fKAk=;
 b=chaZkLgO/z3ZTb95iRqEPBXD+V0IKD9+DnH09n9juGJFPUBy0MZoJUGSouUvmbCmQMoFmH+ylV8s1rcdFFka7APUywyP3rzbOGRau8Kzit08PMG8Xalajvr9uT1KIrW+7laQYVhxnaSW6ATqmVAgc8sbXrnuQayptfnBTbDeVWk=
Received: from SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::29)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 09:02:26 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::da) by SA1P222CA0145.outlook.office365.com
 (2603:10b6:806:3c2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 09:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 09:02:25 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 04:02:17 -0500
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
Subject: [PATCH 0/3] sched/core: Fixes and enhancements around spurious need_resched() and idle load balancing
Date: Wed, 10 Jul 2024 09:02:07 +0000
Message-ID: <20240710090210.41856-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ee084d-ba48-4913-9674-08dca0bf04b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?19k5tMH3bXHan+LKb5/UwxdUTArC/wj6c0EuRl/b9jnBtTnModDnYFZoKKVA?=
 =?us-ascii?Q?XD5uYYxUsdCkJY6OJnSIWuzUSvzaVQFaj3gysL+oUvmY9a0NtEOhdZqDxNQe?=
 =?us-ascii?Q?L7SbGjrlSLRg1a/QTkO9LyojDqtzk54tlWfYpIxWy8oRw/omcH/VfHCjwxO3?=
 =?us-ascii?Q?BzQ5a0Qyr+o43G6VqIRzoCGPp4WAjYxypJD457LZyoqk4lJSxcviJf5QyId7?=
 =?us-ascii?Q?4nEViBAJy/NuijXt1j+B+DwmbUFfxXk+aTAtR7JL7u416tcGEgM1C13flKyH?=
 =?us-ascii?Q?0Ky8VVls+quFa8hJUWUD9HYjjUY5kfIylGQm6ptl8bWf0UxLqKkduH7hWv+A?=
 =?us-ascii?Q?KhWvQ1A/WOuBtJgaEt+IMhju4mKFfiOkCNW/3LK7rEHz0WZfD7NXNp9z7a9X?=
 =?us-ascii?Q?rERy8Fw1nw0kSdt4TS75E8qPHxHmHHTQ+UYFjpwd3xJtAM5kp2Ri4PrEE2Sf?=
 =?us-ascii?Q?KTEqGqSyG5REjkinjt/zIKZK3CVam3MJtwbWWDpbHbPeQ2V0e3wOSS11e6hc?=
 =?us-ascii?Q?Lm4fYcd23hEfaT4wEATNgjqUtY6zJt5IVWIIC+3nJRVYl+F1HR0CAeAqf9YY?=
 =?us-ascii?Q?fwmEIDl2/KWrw4KSP6SqhRgi98gZJEdJID4KnvTunkrcnNrwmdWEoIfVW1AS?=
 =?us-ascii?Q?KIAgkNE1OvIezHCJHA2WYmgC1nF3a7zRz3eEouDKBdIw2Rlq6hVwFUgEq5Y0?=
 =?us-ascii?Q?hLLmMV1TtGdd7pFfCXB68fKxhMKQdE7QbQbzEhuI26HyckNRuAZjO87TCNBU?=
 =?us-ascii?Q?1P2DH1fuSSEuky72LbN8bXwuzAWmpbom3HrpbduD6hV43v0yYVlOoF9CYxNw?=
 =?us-ascii?Q?vjjpkEW+ksi+uaCKav85QyPFuLrDh4SPAX5Rx5gikajW5Lsz19lIrlPsvhQw?=
 =?us-ascii?Q?7fbXAoq9NBPPpfDW5wNVEOumET2UrmELuabsMS4o04W0bjNAe/2sX5JTaC06?=
 =?us-ascii?Q?ZnLt0zh3g5+gJH2YW+wvxiK66Q8biPYN3u0VB7/DYiu8oQ1NRdP2wlC50HC9?=
 =?us-ascii?Q?tdZV9dK4SvY3MgQih3dr6vNzybIfN3hbEVR5APH09B1efbhvcrbqHmLD6mYN?=
 =?us-ascii?Q?wF3cz4DrOOnJ7qIRQu+yubQ+No4LvfJcmqTkawHLWWMr5ex3Q0iZU2ZJS0sE?=
 =?us-ascii?Q?fA4lYvKWfO2CXgZ8KFH5lkKvB2+lTh4QcwAjdCoQlX5L4L3ck9T3ZvlpDJV2?=
 =?us-ascii?Q?k7GCk4+Oual+RXWYKaZBy/hsEaoK2zwDR2e684tNSR7jpGT4ejhsE/O7uiWs?=
 =?us-ascii?Q?enb6qpVSyLeL4x5PbVCNPP06cdc/hFvmy3gD1v831yZYJo72+PsUQTgb1eEy?=
 =?us-ascii?Q?DKcODJDT+Heiri0o9XJKrIi/eCYev8O8aT9nSw+vIHdSnCgtS/dW8cuA/8JA?=
 =?us-ascii?Q?DLwiJDjbE9oxPjV0GRqkqZLzSlm+0nEBcBJ7KGu3/XsIBgT5+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:02:25.6049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ee084d-ba48-4913-9674-08dca0bf04b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()"), an idle CPU in TIF_POLLING_NRFLAG can
be pulled out of idle by setting TIF_NEED_RESCHED instead of sending an
actual IPI. This affects at least three scenarios that have been
described below:

 o A need_resched() check within a call function does not necessarily
   indicate a task wakeup since a CPU intending to send an IPI to an
   idle target in TIF_POLLING_NRFLAG mode can simply queue the
   SMP-call-function and set the TIF_NEED_RESCHED flag to pull the
   polling target out of idle. The SMP-call-function will be executed by
   flush_smp_call_function_queue() on the idle-exit path. On x86, where
   mwait_idle_with_hints() sets TIF_POLLING_NRFLAG for long idling,
   this leads to idle load balancer bailing out early since
   need_resched() check in nohz_csd_func() returns true in most
   instances.

o A TIF_POLLING_NRFLAG idling CPU woken up to process an IPI will end
  up calling schedule() even in cases where the call function does not
  wake up a new task on the idle CPU, thus delaying the idle re-entry.

o Julia Lawall reported a case where a softirq raised from a
  SMP-call-function on an idle CPU will wake up ksoftirqd since
  flush_smp_call_function_queue() executes in the idle thread's context.
  This can throw off the idle load balancer by making the idle CPU
  appear busy since ksoftirqd just woke on the said CPU [1].

The three patches address each of the above issue individually, the
first one by removing the need_resched() check in nohz_csd_func() with
a proper justification, the second by introducing a fast-path in
__schedule() to speed up idle re-entry in case TIF_NEED_RESCHED was set
simply to process an IPI that did not perform a wakeup, and the third by
notifying raise_softirq() that the softirq was raised from a
SMP-call-function executed by the idle or migration thread in
flush_smp_call_function_queue(), and waking ksoftirqd is unnecessary
since a call to do_softirq_post_smp_call_flush() will follow soon.

Previous attempts to solve these problems involved introducing a new
TIF_NOTIFY_IPI flag to notify a TIF_POLLING_NRFLAG CPU of a pending IPI
and skip calling __schedule() in such cases but it involved using atomic
ops which could have performance implications [2]. Instead, Peter
suggested the approach outlined in the first two patches of the series.
The third one is an RFC to that (hopefully) solves the problem Julia was
chasing down related to idle load balancing.

[1] https://lore.kernel.org/lkml/fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr/
[2] https://lore.kernel.org/lkml/20240615014256.GQ8774@noisy.programming.kicks-ass.net/

This patch is based on tip:sched/core at commit c793a62823d1
("sched/core: Drop spinlocks on contention iff kernel is preemptible")

--
K Prateek Nayak (2):
  sched/core: Remove the unnecessary need_resched() check in
    nohz_csd_func()
  softirq: Avoid waking up ksoftirqd from
    flush_smp_call_function_queue()

Peter Zijlstra (1):
  sched/core: Introduce SM_IDLE and an idle re-entry fast-path in
    __schedule()

 kernel/sched/core.c | 40 ++++++++++++++++++++--------------------
 kernel/sched/smp.h  |  2 ++
 kernel/smp.c        | 32 ++++++++++++++++++++++++++++++++
 kernel/softirq.c    | 10 +++++++++-
 4 files changed, 63 insertions(+), 21 deletions(-)


base-commit: c793a62823d1ce8f70d9cfc7803e3ea436277cda
-- 
2.34.1


