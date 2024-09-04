Return-Path: <linux-kernel+bounces-314850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A452396B9FA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236FD1F24BC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21A11D2209;
	Wed,  4 Sep 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="re1BR7yP"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE091D220C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448422; cv=fail; b=nic6uct14Y24l9sMBXKNnIAzc4gFEPLLlj/zpZXdAbbjrqh4NXNVZSUeLVquNt8Iz/maUZzNljxURa6RGgtlZJqUdK+CaqqX4BC9fWyla1vohe4biud35suaUC+k44dmWDK0vrwXpfCJLwJb/UwMiV5dr6g+FNFS+3FtBcLzTbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448422; c=relaxed/simple;
	bh=Rj7af4CvntSpFhcvI4V3z1vRluJ6KKfFPP5AZTJcbEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJC4TccXgPxNsUIF4lrR7M4t5S+G1cErE4//PKE766pL7HSnIC+c8ORauXErQkInn1ps48mXEatqwBzs+41eLPLnYg8kY8lD4NnIOzviUOl2nax7CfQ9ycIjdVhE3qTMLuF+0l0aM/mvx5SsBhGbnaU7qq93B1KuvmInDRHMnUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=re1BR7yP; arc=fail smtp.client-ip=40.107.101.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDhnbegtq6DoXinLoPkeVmykDs2/MW8GI4hTgVcBex3Wt4fPp5/I9GmpvPRo6HV2OgSOERDZ/xhqtqwFAXUoDxJT0FAY9O63bBDTcqQn5UlsaRkwNCByaSLQmIO8YQlyHNAErAqYIopffjTsrYii2wf116bBwS4CnH1xfUNZGd1xy/8cDbBCbji/mWQm7I1XPghR3UNz/D/+8SSfEYUprIa1v6hzHXyRRWuUNN//tJPdAJ8moFVKShbP4cC5axfTIGGRAOSsW7gVOW0gJ1GL46+6Jv4G+8giuzz7nzD+qYWRVNBTcOZrIM3p9JXbI5U8jgVt6WNxmhtujYF2nx0LcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsu1CNohtsONQu023fr6uJNrd3VjzuspGSbo5gy2qak=;
 b=aNUjXcn2jndzylKM8yH8mNOp9lq53ZidNBWM7uUhAXuSkSA8j0n572HnfG2R/JaMNdZo3rq+Q879EQcKgsGTYhwZDcxCMJEiY/TOYur8MIbBzpiUcT9jC/nzjsKwlcKHecBXWRXUHVxW/i1Z3ScXHej41Cx5huS0K+T9YY29pt7OwMu8PjrtQMzASrNbsXN9pkUeTa1QZFZddzb35b+NsVaVQbV/4D1Pcuk2CwO1wK2gx8CMznWajiZpdwnGV+AN6P2G/c1F07AYcrsSJPoW2KfTS5F2Hf2dQnwd9vP6hKBmwqMCip+TRXM74sIvHRykvJw8z/D66CvRaTchr3JTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsu1CNohtsONQu023fr6uJNrd3VjzuspGSbo5gy2qak=;
 b=re1BR7yPpEkd6NMFHBMzZuCZkG0ARpyLjIoLtudRHkJcc+C92Eto0qXnbpRpKVJ4Wclp1edfzsdMFDiocqj9iwC4Ft4o8WQeVu6+yrunm7AvHCs3ntNzGnUZuyQWT0KPagseZci4aPgxRmwgi5pfIP+x9+qcGHL83MFEjyL1rAA=
Received: from MN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:530::30)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:13:36 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::e2) by MN0PR02CA0027.outlook.office365.com
 (2603:10b6:208:530::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 11:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Wed, 4 Sep 2024 11:13:35 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 06:13:29 -0500
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
Subject: [RFC PATCH v2 3/5] softirq: Mask reads of softirq_ctrl.cnt with SOFTIRQ_MASK for PREEMPT_RT
Date: Wed, 4 Sep 2024 11:12:21 +0000
Message-ID: <20240904111223.1035-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a8c265-feb4-4eb7-d231-08dcccd29edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7r8g6Ok80i4ChTee7BqZLfinIavihPDb9lzY75btlgWYg9gT33pql83HiMjT?=
 =?us-ascii?Q?/kbR2jkLwSg3nD6zgR71Cd4uSA0ozpyzPYRH8vdYnxu3cHpXmK8iuCfatDAD?=
 =?us-ascii?Q?wLRAzLAyCgTQ/+Zk/qFsgh+DtfwMJN5Jpe4fGDTGpVNlRYOQJ4e796RCE/Sh?=
 =?us-ascii?Q?wJQ+eCCmSi7uo+mPpFfUV2BWt09mbn33v6xC1BcXXjFc45RtEWEWmkNxaXIX?=
 =?us-ascii?Q?M3nu34zLICdjSLQ1aH0X3mKNL6MMrSYaOStMBy1ndKNpM5Sw2a63bTYFgRTY?=
 =?us-ascii?Q?AaUSQ0TgCzyZlINsFiZtbMXyTvQzk/5wZZXnJl+z+UEFkMOQxx90kqHiwwxU?=
 =?us-ascii?Q?ddRu1mPNh/cbU8OpT+9SmKFhxkjhRlJuMVaR7N976JaIhGSz3KZ2DTMjAH29?=
 =?us-ascii?Q?yxLvyigM0Cd2nDz/QNyNbJrkxdkyrN4euL38XpMDtvg7V7+x4u2/QuuXk+cV?=
 =?us-ascii?Q?9cN4/mOALj+Iq7WYsArmEWMVzyUgGl0S/63g7dSCONOHPlf6AJQqhIXSsvA0?=
 =?us-ascii?Q?q97nNkECUJ2NiyrmXx+QWZrcUkWGQwNGmm9Wsaw+ur9Pir+xP5aGslyKhWxu?=
 =?us-ascii?Q?NYJSwCwIxg3LDoyNBjYAr/LWm7iny5BJd/Ii9t95H5gGJ6pdvIU3IqMeIVd7?=
 =?us-ascii?Q?i9wIkgSqk1STBs98vcMTHLQ7nk5nBUJkwaPnS7vluPC5+0LckdMgS1OAuUZi?=
 =?us-ascii?Q?6Hj5BQyFHsP//Q1p/UJDq7NScp3nhqwRzT6MFBy+ZWbSWNPI+xdZ6Q+cToG5?=
 =?us-ascii?Q?dQ72B12NGboP8gy/lnWXa7bNtpWD1uBbI5/7pCtHhEDntMrvWRnnhjwo5L38?=
 =?us-ascii?Q?Z15tMEBn7IzC9gyx5hoNEWj4xkw0HIla9Jd0YfJ6Nhtmv6IdVmbYXC2gous+?=
 =?us-ascii?Q?OEF9LaZ/R2IRWONGJGs+OIobaulCv9pSobYIzw1YmRAHljSKoq0QOrZdTwP0?=
 =?us-ascii?Q?YISTX/aehgGT4nors2Gcru3GPi05p3ovUvjaDMn1PRg3HUGWd+plXMJgbfcy?=
 =?us-ascii?Q?Cs2MU0u0Um0yCYJry09oqBxQv+pirztZXsU0z7epKlzqJB/pQKaH1Bpm+8Yd?=
 =?us-ascii?Q?aZqnYytvJgdipUKnSCpxaf69n3IiDv8WHVAodNP5enELahfYX7TPe5PltfDh?=
 =?us-ascii?Q?+BKuyH66W0/mYJCGiKUjhs1lIMqrWBm8Kf1VQhNi5U5/L0mxr7r9kDKVBjP1?=
 =?us-ascii?Q?OsC3qiAME2bOKIiwoNQOgs8GAuAlFcXn4JQyYa8fNuCLO99/jcsE+PWVVoAx?=
 =?us-ascii?Q?7INL19bNqjYiuRj8v8jQhgq/c8tM9l6cJIqxpQspLsCbgeEEJlP8lfoqhqYj?=
 =?us-ascii?Q?SvMGcqZlvZYlfBHebkVK0t8LoPDSQMqygfAa+SFSv+qfQWkxJsV49hrDBUHQ?=
 =?us-ascii?Q?NNWRewNmW6+SfQnpBlLSaEihvUL5dmCbpWiqrBlj6Min+eNvF/vgwYeEnock?=
 =?us-ascii?Q?/3OFonL31hw1mjpGCS29JhLgbeonruuJNeahD2j0264w3rX8kZ/LLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:13:35.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a8c265-feb4-4eb7-d231-08dcccd29edb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059

On PREEMPT_RT kernels, softirq_ctrl.cnt tracks the softirq count and set
the task::softirqs_disabled_cnt accordingly. This count is always
'changed by SOFTIRQ_OFFSET when entering and leaving softirq processing'
or 'SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET) on local_bh_disable or
local_bh_enable", as stated in the comment about softirq_ctrl
declaration.

Soon, the softirq_ctrl.cnt will also be used by !PREEMPT_RT kernels to
track an impending call to do_softirq() in order to prevent pointless
wakeup of ksoftirqd which will use the lower bits of softirq_ctrl.cnt.

Mask all the current reads of softirq_ctrl.cnt on PREEMPT_RT kernels
with SOFTIRQ_MASK to track only multiples of SOFTIRQ_OFFSET based
changes.

No functional change intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v1..v2:

- New patch. Broken off from approach discussed in
  https://lore.kernel.org/lkml/880f13fd-753d-2c5a-488a-d75c99e8dfa3@amd.com/
---
 kernel/softirq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8c4524ce65fa..e70a51d737ee 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -138,7 +138,7 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
  */
 bool local_bh_blocked(void)
 {
-	return __this_cpu_read(softirq_ctrl.cnt) != 0;
+	return (__this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK) != 0;
 }
 
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
@@ -155,7 +155,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 			/* Required to meet the RCU bottomhalf requirements. */
 			rcu_read_lock();
 		} else {
-			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
+			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt) &
+					    SOFTIRQ_MASK);
 		}
 	}
 
@@ -163,7 +164,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 * Track the per CPU softirq disabled state. On RT this is per CPU
 	 * state to allow preemption of bottom half disabled sections.
 	 */
-	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
+	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt) & SOFTIRQ_MASK;
 	/*
 	 * Reflect the result in the task state to prevent recursion on the
 	 * local lock and to make softirq_count() & al work.
@@ -184,7 +185,7 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
 	int newcnt;
 
 	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
-			    this_cpu_read(softirq_ctrl.cnt));
+			    (this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK));
 
 	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
 		raw_local_irq_save(flags);
@@ -192,7 +193,7 @@ static void __local_bh_enable(unsigned int cnt, bool unlock)
 		raw_local_irq_restore(flags);
 	}
 
-	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt) & SOFTIRQ_MASK;
 	current->softirq_disable_cnt = newcnt;
 
 	if (!newcnt && unlock) {
@@ -212,7 +213,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	lockdep_assert_irqs_enabled();
 
 	local_irq_save(flags);
-	curcnt = __this_cpu_read(softirq_ctrl.cnt);
+	curcnt = __this_cpu_read(softirq_ctrl.cnt) & SOFTIRQ_MASK;
 
 	/*
 	 * If this is not reenabling soft interrupts, no point in trying to
-- 
2.34.1


