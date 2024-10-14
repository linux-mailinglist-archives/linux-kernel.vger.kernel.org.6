Return-Path: <linux-kernel+bounces-363613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD5F99C4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ABF1F2140A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3CA14D6EB;
	Mon, 14 Oct 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nmhuhY9/"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F41BC58
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896745; cv=fail; b=aNjllPl891pTFm+TDWPadRbZ9ieu/DtQ80vQP13FlA43JDqw+NLyhpFD7+Mq0Honi814VziW8pR4zryyBV7AZC+RPpwPOfdoQvXZmGxix3tKvGZfUxW19e90kVHYGATpVwE3ZNZpimUQ0gv3uuYT4qR9Hr8ctOS1SvonVCrydRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896745; c=relaxed/simple;
	bh=HqANVoLm9lJ1cGqDX0awhkfs2uqW6m3IAcdYjHuOKe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+CRR1dQKf7SRKJQCm3Yy2YtBPsO5hrFQIHp5xFes8bDAo6/2eC5hCUQiftXPdUU4LeUgEgpndZ5KMCiQQcGeLk+tbr9KiKgOg7jKvzjywk2Xdl9OvhKEHs0LOaTUlTpuOORAmM+uXxZcg/yBy62UZefzoZcMLgAcOk4GsrWV0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nmhuhY9/; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7ahGJlP2XqgGJly5Gi8KDtaDTGm35029jcx7fh5FJL01B9P8FdmeU1aJ4vr3AHstp6rsWfae+v6Aq7ze8moz33y1VG6aqp8R8zdbbKh6zQkOHirzQa8Hxy70ikwfNvY/pr/7l0yV42HxTM4H3fXBfODXWK3A9FBT+wBXnrsfZ1s8o2rhQomxMk7+OSpQI6LD5UdasGyJPsCFahg/cYZLpqj4yK0YFxhNagc+r291NHQc1GtPF2FCG3W8YiOthuwc/D676bgbwYIG/Ww+hVmgMCCTKA60gDgqudH/9u0/tsnIG3o3AY2WEvvkEJT6VxYyeBK0ScLyxUWvx0WhSojaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNQIcqaZGL+cQAHDNKvBCTIxFOTjoNSywCxNT443MpU=;
 b=GpMLnp5zLa0y/JFMp4YemtRu/h51s0HKEQkMKstrCZM/+B2JTzO0PC2k+NuWf6wudUEpo4Hd+R4SWYkqbTOMaxHSeIMYMCb3m6VAginc+OC6G13T8ApbtpIQ8vRQsR8biZyHfcpDNW14sC6/5bL4CJ4nl4h+GNo6JDQRkNntcGNfhl8CdUHH1Z75LA7L7ZhNYd1jm4F1F5cNinLeI9YwLA9GLfm2wO5OvBOKZnVeLpoelB/c704/diKJyTrHdNKV84zZh3YvEYH3b9HwbfDY23US6LiXrfHERYI4BlwwAGyrrYxvIzDnFsHUEy7zCvP0x7rWthqMWSlEtf/I0TgYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNQIcqaZGL+cQAHDNKvBCTIxFOTjoNSywCxNT443MpU=;
 b=nmhuhY9/AD7IYrWu0f4DVYlOTJnjqhg8Fqq7kVuoChE6II36jvB8aTyT71nzu8u+nTwaJcN9lAQNuSltx7uJcijWoGHyWMwkBzlo7GwJDdQSwJ21LYSMUzUM2s/+aGh1eYndsNkNzYX3wKZqZ/+RSI1a4XHXw4to8drZW+dkpFI=
Received: from PH8PR05CA0017.namprd05.prod.outlook.com (2603:10b6:510:2cc::29)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Mon, 14 Oct
 2024 09:05:39 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::5f) by PH8PR05CA0017.outlook.office365.com
 (2603:10b6:510:2cc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Mon, 14 Oct 2024 09:05:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:05:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:05:14 -0500
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
Subject: [PATCH v3 3/5] softirq: Mask reads of softirq_ctrl.cnt with SOFTIRQ_MASK for PREEMPT_RT
Date: Mon, 14 Oct 2024 09:03:37 +0000
Message-ID: <20241014090339.2478-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4adb82-72e1-4244-c042-08dcec2f5f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/kx9X70zizwcHW1oJaBjts78FaHr+KxwXRWuEFS0uOwJIjJgXugMWVvHWc/9?=
 =?us-ascii?Q?gB3JhXvA9bm1D8SEfTJniUZz871pvVw0A8N24FJ2XE9d1UqSG/8HoPvunDxp?=
 =?us-ascii?Q?cRMNpKO164Qr328MP81wARvpy7raJGcg68HNlu6e18cgrNWXCiGQS5Z7p7UI?=
 =?us-ascii?Q?eYq+frSEdHuVgBl1k1d8EZWqPU73h93a26KR5Ii+RMTxC999oh7SHw+vPTyU?=
 =?us-ascii?Q?L2HJ0nwKhgmb5kjNw4MtFDAbQNwFEu+f9SnB9tIx3zrclF3e0Ki/uVW8DsGq?=
 =?us-ascii?Q?ma/QEcDm3AoU2IETTA5jItmQyTDbi+6zPFroV9JUS3jqPPLKXWDzdgRInfeJ?=
 =?us-ascii?Q?vgVTF+hDsMfeeyCVw5nn23iktl20ABReut8K28dRlGZSR8vas5i6aSdFYQWZ?=
 =?us-ascii?Q?Gu2mx9u5/m5szdDlcWqWdqlhhwDnEd/uvg1Hhqkd/8antCPMW5iEuq5KgrlY?=
 =?us-ascii?Q?GWLjM39Kdflc0NX8FM2M+47EvRl4fRtKyYrjmfivGv+/8xRsPjZ2OKet//5Z?=
 =?us-ascii?Q?xbzcExgXeZQYRjD4osEstDCN9zqo3uwQqyKzzTv/sv5mUW890PGuL27LR2yy?=
 =?us-ascii?Q?7+juzqChL0n8nkQdb95k7iktr1C6ZrEdUSE1qMbRa6qfbmDnHWBAuakCHF9t?=
 =?us-ascii?Q?PMM7/PZuWq1d2ZwqlO5W7nAZj8apKSkMWSp4p4RQFOXLXJ9F/2CMHJabOXF5?=
 =?us-ascii?Q?STix2bH/ggCCP9NNp70UcVGuBQ/PAtRcqA8X61NJAAtVURrH3uwoVY0G8QuY?=
 =?us-ascii?Q?EMVG03zEjM1U8VS4Muq061/cBrmBnkhx9PMDes90tAGoGKyfJbU+bRnAk7Ky?=
 =?us-ascii?Q?CGuyz+MdhrkryIli24H3ZBo8rn4zXGZLGLsGmiqrZcptv8xvd4HtJkbTUtvB?=
 =?us-ascii?Q?YgP6rozOreQQ3wjwxJ8bdHIvzYw9DTNwBeaxcw00dR95/AGje1bA3R905fIf?=
 =?us-ascii?Q?4zkz99ZfcxKNYqtglaDN5N9PneNeTUwiHSdZeHov+AECGQkOc34tBRhxNHLE?=
 =?us-ascii?Q?hAXN8bfIpjTnm4bBLTc9jGsPMnidD80fKrl9diOTaeyoZFSfHSNGJ3dLynOq?=
 =?us-ascii?Q?Azmkh1YZWl36u6ACJR+RFzhaB7MCkGJ1sk+R6lRW0jzjPk1Vl2rRAKobj+J9?=
 =?us-ascii?Q?Cv5IM22XG+NVVewigswpigONjHXFdPzVjqvwftg+w61odSqssStgeWIPvSjd?=
 =?us-ascii?Q?Fi9hDGTTxpWYe0p9NIMQtcCq9j4jeGldF2HOsa8zTbCASIPwBTJv31SiD1EX?=
 =?us-ascii?Q?2oKpGGJW73O9thUP9Rtxu0s58MciEuYY9s0MXCCNyapTPt9/f8DjpYlNmvrD?=
 =?us-ascii?Q?94+Nld3OkBVLmrb5C6JA2iUZiVJpFtbtPEBbFqSx2/1JyQTC61UicHu0eOBZ?=
 =?us-ascii?Q?Q3xlBv4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:05:38.8948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4adb82-72e1-4244-c042-08dcec2f5f8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

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
v2..v3:

o No changes.
---
 kernel/softirq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d89be0affe46..fc8c3a7dbe35 100644
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


