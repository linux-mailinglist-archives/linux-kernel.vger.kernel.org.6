Return-Path: <linux-kernel+bounces-562353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86168A6248A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B21C19C1A40
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0518C930;
	Sat, 15 Mar 2025 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VaWCgXAE"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7718B47D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005347; cv=fail; b=IT7qxHY+vzZdDWghTfn5yCK4+/TCBpUCVFQOKOhMlyp1gZBQVbIAm/hOB6Bu52Y8ulQYaSCCkTP3tXQc/tsS9mDiUQObMjjiJ/ogQ+uAgSGVzQanOYS+juhRKir22syVCoEd/lK4Qc9aVkxjKesp+WLlhW0gJAOf8QSmOF6eWCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005347; c=relaxed/simple;
	bh=sjkCxBv4wChqwOoOnlkWTii8WgtsuYXysunW3WasNeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnZFONc+xTXuF9VBdXsiC1FSngW0+JVUCTiKnRO1MWr6tHvvU8UyMMmIiFoJueB0Ab7oxqJ9pKN7r4k2t1Kw+on7+mHzXBostfiA5BTK0PsV+2HHtbWNznxtWje8CkFlBOiQ8gEWNdw/T4zkpJy2R0KzQZfV+pzQi+VrW8Px+iE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VaWCgXAE; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+HuAz327C1uuNUojXT6jPO/H9a0U3rJjXg5GweYmeOcOGjySae0PkJn8V7Y7CVF0VsG84OduWMEP0QuSRjfXx0B/yLlinpJ0/TDzun6ZwzA1moWtDsAs7jsc82P1y37hRDU/afpcMMdpjLQMHNOsuLGwGxN1HPcZHknyqt4grbfqvEjDDFyjJExD/uop686QDlgJqp8G8JRES2Tz+R0MTPSjrbxhqtMIWYRyKRg5m0cQjSJ+A4xxxWPyAnbgB9L32MBSPr+mehNbQPJthiqzrykr/6c61nNWeMznsfsPb1+3k9On8Vj1X7mHCbzK2UxQJjg/SKYempznpAofBqDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKcmYMSlI8pZdX+fgHpqivlINFtySA7Mx2ptqdOHI64=;
 b=bHhjgjeiq91+ddz84/j0ITCaaBgxcsscrKZVcrQyvdin7QSR4WV+wd5xRapc+bK+9ySWgDq1sxn0cTOQjgWA0f94de4A+kt98S3+Az9zlQbhyq9Q3bS5TbbIP8MkK1IxqSyAmI+h8UQwmyzGtCWgttdv01XN0pLe6vifIRzRUm//TIwPKo6+p33xjYM7d4yu3JQVACtbu7ZOw+NKN8spWbXK+Wpp00y10nzhqSzQO+oMPm6JBwo67iTsmLu63+TeB+tBNR7662nh9ywXs+JBQQbY/lAJolFqMZNzuoik8WFNwQToZPrt1f+GNiFNT940epUgUMCqIlnM6eTJZKcH+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKcmYMSlI8pZdX+fgHpqivlINFtySA7Mx2ptqdOHI64=;
 b=VaWCgXAE5sMUEG2hGLDkgU2DSFQ9zGzy/ltGxT3LeDhq2tJOj8XCXImzS3b86rAL/VYej4j8ykiNOoRcWOLsByrB4VN2sw25d5KuLnlyroJ0GcSoTRJn4fYI1bdTCxL+jvECJ7vqyZfdyfsFF3NnXFx8shEG2rM8OzYGuQNqnTzquPTdrXweGRTXiHMK6BqiQ4/TYEKskB0GvSVx6X/ZsfYM3xIwV5/LqX671XNOEDCagsOp5hkTQFYDStT/jeOKt7/601/uGih/haOeGi+uSTyAy9AmyrotI0zYW6NhsAdqNW0IKut6tgUi75he4eEXLlN+3PeOfwXcecih0UZ7ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:16 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:16 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Date: Fri, 14 Mar 2025 22:21:50 -0400
Message-ID: <20250315022158.2354454-4-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0199.namprd13.prod.outlook.com
 (2603:10b6:208:2be::24) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5be301-2db9-455e-42f0-08dd63683423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6zjkldZDamMX1fO2feQjQNVtjZAt1WF9tTyFo6V6IV7vvG474wtHMZHgz6z?=
 =?us-ascii?Q?Jg1RWtEjyZvvSAzj1FD3l0cxCTCdJyhV1tOQp+qbJLZp54ASm39PrGCRXLhQ?=
 =?us-ascii?Q?BS2E2us5ZZp8drlnmqi69FhKXlV7BP1MY/KxQYidcsCUHdci+nINfjNO7M2d?=
 =?us-ascii?Q?WG8pR3n3oqb047JUZapBmBpSv3E4wmyixTTkqxoVSZd/HgAk3jQfyJqRnZWv?=
 =?us-ascii?Q?eteAKQmIh8tndEWuckfDJtHWMctImUpKjDS+cZMJlPzKCWeoCUT5X8E/+9L8?=
 =?us-ascii?Q?6ZvzNnAhnYxS+s3anyhemPBfdhHnAiBpe9vJN2EHZIDx2GvjdVEt9lSz3jUu?=
 =?us-ascii?Q?jBDABnbdY+suKRAuJw1VSPuLYQA37r/9lIVcmgFT5rQMU03XQGzhYj/Jf5+y?=
 =?us-ascii?Q?zUKeiztzc9kB74Gaa1eQdnQEnDhcGBB9Sd97mSKaPkZYB7ezAT06aXdu+Vgt?=
 =?us-ascii?Q?PcAy9g88itQ3YSscjDjnPD95QBBpyRUYOyj0us8IsFDwD/nkfCki/qcPSAL4?=
 =?us-ascii?Q?8qGCUgH7dKbfD982Qj/If9ef6vqntC9koXJ7dUf+DPUXUqBGmETbQIvVjXxD?=
 =?us-ascii?Q?+ug6kWj9tVJqBqjWU+qKKAVlOzQ23YSiF5eB+oyKYXiDaFzYr3G36UkpzXav?=
 =?us-ascii?Q?TXYhmxrYkZBxT1pSQMmTR7qvPegHw3pZqzphMvEk9mwDSOsMSTVB6eqyN20l?=
 =?us-ascii?Q?F+6AxP6OZiAj/FsDK5hGiE0J9EwU/FP9/5BR94JV69eyuUW9YWeeh+sItaiH?=
 =?us-ascii?Q?bkDVN09RQqwyqQn3FrJzEn/vieK7uQRgCnM1c6kQeUAmmTEsTcftG3WHlfdZ?=
 =?us-ascii?Q?TIFoHmsyAoRV0pgkU4iMto21VEeAiPR7NN6nUG7MmJJ6w0yqfKkeDF5a0Xzt?=
 =?us-ascii?Q?mxZcKts/iKH5coOZNJd91+nDCS5Dwls7fNJXpWBjuc1c0H5QpEimdnSW3gJE?=
 =?us-ascii?Q?CkJAmFf5zU5OR+VF7KCEVCU3mSnWb0C2/q5b5R7ynPYJ/yN4AqhQjQz+ctPP?=
 =?us-ascii?Q?3KFdK5kVC/5HHzqnvloc/V17FRwe1xUdU2uCGm7j8fjOXSc1v1asgD77AGKA?=
 =?us-ascii?Q?1HqGATX3FxrsSTF5aYad9hyz5PzTetDF+VC8ZDw819Hdcd57r0zdYT2tY7xm?=
 =?us-ascii?Q?Re0iTQYU9ktp1bdf0aLsFwA3lUAG/S5bbN0VZWYnF2S4ZkHwEC+s96Fc1/3/?=
 =?us-ascii?Q?jqypf3t6VphOXHW0CBfJAdfcyjjTxxVGcvJic0gfmjC82qCOepM/qoguGI8G?=
 =?us-ascii?Q?xLGCzUNv/sQ1hth8EjJQBr5zH7/yUGWdagoWJQfn+pjT5l9qxBAPMH2+Um5z?=
 =?us-ascii?Q?YFuj4YbJA+nKcBLhXugHlY3D1uXJZPzJfNRJ7P8GLLyT1iLcCjR+YuTSIoky?=
 =?us-ascii?Q?cIGxiGTx1TxvFyX2T2UjAG0hCpmGotgc5j8nCyStIF6XMAP3qun/VikKLSBu?=
 =?us-ascii?Q?lNNr7Ei5N+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NMVvoISsSTfkplMgmcpvTmjU3MXd108RWLb58CQPVE+OvnunfPoj0dMhOEKl?=
 =?us-ascii?Q?EsUqiY6lkU8XMGXM8n5fm9NX0HufZ/KFE4vUGeR2cBw7rCBZycPECTC9K+j8?=
 =?us-ascii?Q?vy2z7ZvInWrbk3+GEb+FdZ2viOiNWTlWWJc3EbxMgdoZOspEefHeaB563UDa?=
 =?us-ascii?Q?z5y2Ja8Xh38AJmHQhlpF/aVjeiG+J2LcC5yG6KrfCzGavNxQMo32llvdlx1/?=
 =?us-ascii?Q?xNRShkAfBvoNS+LmaUaoCV98h0ogGGLDs0JEdu92Iig6/k6jZWDscwpFA7P8?=
 =?us-ascii?Q?Yn5qkb58EqO7XwahaqSJXjpzJtDJPC4ot3QXv7u8WgtrjhHxFsnQWAfG/jv1?=
 =?us-ascii?Q?q7LgpXLjJkuUDgVUxthw1xU+6oDwSc/msM8D3NGqNnrve5Qz1srl2VjPZg2g?=
 =?us-ascii?Q?WHNFqri5i3etoFTuMxQtC6M/C9iRU47qRrd4aJWyfRvt4jfr7UjpQQYqHUA4?=
 =?us-ascii?Q?CxkciDI7Vx427FX8gFuxKMCTVRLGyP9wUGmAYFMZUdsXj3BhbzlHB2hapXRR?=
 =?us-ascii?Q?Gbd/LeQJxWQ2CCsLWaaJEDgKc6D8Rf8YLGrUjUV1L6fnLPY6J/aSygCItvD5?=
 =?us-ascii?Q?N151XjvgDkbwl6mEVVy+hgkonV9W39BWphj9kpbA+mW0nim4zN3AVy9GvOgP?=
 =?us-ascii?Q?iqO8pd0nDjWkbAaxy1uNBf4q3F1zJTg4oohQPupchmGrcsWLtsnz6N0iakTZ?=
 =?us-ascii?Q?Fvdlvlo0J+3Rvhk/LkbUm5NxiF2452sUd21krrkp/HXHDHPKvxHmAx5ZUMdm?=
 =?us-ascii?Q?cDyOFfhWbAW297hJiEoDjWQBmITibnOAVHEpJ04YqmIO6ob3/C6DMY6+c0mt?=
 =?us-ascii?Q?8gadbPsKe/SZTo5hFuYSDI3jG5L2eiDzLIDjsw6xY4TzLd/hHQLccehV/MSN?=
 =?us-ascii?Q?LNhfy17BrTiuBJB9W1AhcrB8mg7TRs9rg6NumVmZxj1hnRJFYN0VA33AYE9Y?=
 =?us-ascii?Q?6tgMs0J6+ZnBhV9KD/PPIEBsigerjHc63dYmYtTztg7R8KZsxSgfgBEaydBI?=
 =?us-ascii?Q?1/o5sSP/Dto5odCU5a4FxKBoTpSAOiBCmsJlNFKI0Awt55SPQoQbmOGeCSh2?=
 =?us-ascii?Q?RH6G5cZIlg63sIuLD46gDXdEQy1+02jZhm9Mb6h3Nk/ADMgP1YZ8TJRfGwew?=
 =?us-ascii?Q?9qtBC8y8pOJLqr7puJ4T3fixcYt4eeMs8dhBXWw0u6yvd9fKD97zdfU47jJE?=
 =?us-ascii?Q?tzH9GEUf5XSkstq5Uu02TkFO90yIxkho6tTZmGX8/g8AAtAD0rfjTFVE2lCd?=
 =?us-ascii?Q?jF3NWoi9EDMrWdi9wtmxveRAWYgXHkgwnIOm0ssLdtQrrA7V4k2gm5CS6XRM?=
 =?us-ascii?Q?SeSUb2KXT4mhOQYhndVcvAxxRirSLG3eNy0mhTLyrfT6gXx2W50OLOomA1Az?=
 =?us-ascii?Q?nLioyVLGVnqoSXBAUsZ4A4bdWa2f8In2+HAihQE5+AXjn7FW/j6/5/vBKNnt?=
 =?us-ascii?Q?30CrJA4rbf9+ev8sNFt149WLDFnCgZsWJVOc9X1ERoLcjufddrb93Q2PbJU/?=
 =?us-ascii?Q?nTE/WYxF7Oz3rAaxICmx22FZ2prpjeXuTqTzjRSemHe1goxiaM1CHzXbeMT9?=
 =?us-ascii?Q?dkLg6/085nI1c7xv4z2fRCYUsokCOTQboSZzaR4z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5be301-2db9-455e-42f0-08dd63683423
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:16.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuWQuFd1hKkNmc9UAAKShSbwSozHy9Yvle518RP7qYolBGJJ2ArhC3V5vw3ZpeG6jil3lPtMnHsGEI19nykTUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also provided later to verify:

./runner -t rt_stall
===== START =====
TEST: rt_stall
DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
OUTPUT:
TAP version 13
1..1
ok 1 PASS: CFS task got more than 4.00% of runtime

Cc: Luigi De Matteis <ldematteis123@gmail.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/core.c     |  3 ++
 kernel/sched/deadline.c |  2 +-
 kernel/sched/ext.c      | 62 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h    |  2 ++
 4 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d19e4b7a0020..09bff60c22d8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8617,6 +8617,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef592751417f..bcb66d9692ae 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1571,7 +1571,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	 * The fair server (sole dl_server) does not account for real-time
 	 * workload because it is running fair work.
 	 */
-	if (dl_se == &rq->fair_server)
+	if (dl_se == &rq->fair_server || dl_se == &rq->ext_server)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 636b08977d19..553d3e6087fe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1677,6 +1677,9 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	if (dl_server_active(&rq->ext_server))
+		dl_server_update(&rq->ext_server, delta_exec);
 }
 
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -2147,6 +2150,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
 
+	if (rq->scx.nr_running == 1) {
+		/* Account for idle runtime */
+		if (!rq->nr_running)
+			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
+
+		/* Start dl_server if this is the first task being enqueued */
+		dl_server_start(&rq->ext_server);
+	}
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &= ~SCX_RQ_IN_WAKEUP;
@@ -2238,6 +2250,11 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	sub_nr_running(rq, 1);
 
 	dispatch_dequeue(rq, p);
+
+	/* Stop the server if this was the last task */
+	if (rq->scx.nr_running == 0)
+		dl_server_stop(&rq->ext_server);
+
 	return true;
 }
 
@@ -4207,6 +4224,15 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 static void switched_from_scx(struct rq *rq, struct task_struct *p)
 {
 	scx_ops_disable_task(p);
+
+	/*
+	 * After class switch, if the DL server is still active, restart it so
+	 * that DL timers will be queued, in case SCX switched to higher class.
+	 */
+	if (dl_server_active(&rq->ext_server)) {
+		dl_server_stop(&rq->ext_server);
+		dl_server_start(&rq->ext_server);
+	}
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
@@ -7440,8 +7466,8 @@ __bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
  * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
  * schedutil cpufreq governor chooses the target frequency.
  *
- * The actual performance level chosen, CPU grouping, and the overhead and
- * latency of the operations are dependent on the hardware and cpufreq driver in
+ * The actual performance level chosen, CPU grouping, and the overhead and latency
+ * of the operations are dependent on the hardware and cpufreq driver in
  * use. Consult hardware and cpufreq documentation for more information. The
  * current performance level can be monitored using scx_bpf_cpuperf_cur().
  */
@@ -7793,6 +7819,38 @@ BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_now)
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
+/*
+ * Check if ext scheduler has tasks ready to run.
+ */
+static bool ext_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->scx.nr_running;
+}
+
+/*
+ * Select the next task to run from the ext scheduling class.
+ */
+static struct task_struct *ext_server_pick_task(struct sched_dl_entity *dl_se,
+						void *flags)
+{
+	struct rq_flags *rf = flags;
+
+	balance_scx(dl_se->rq, dl_se->rq->curr, rf);
+	return pick_task_scx(dl_se->rq, rf);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_has_tasks, ext_server_pick_task);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_any,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3d1201b8f3d..8421eb56c50b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -395,6 +395,7 @@ extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p,
 		    struct sched_dl_entity *rq_dl_server);
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1141,6 +1142,7 @@ struct rq {
 #endif
 
 	struct sched_dl_entity	fair_server;
+	struct sched_dl_entity	ext_server;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
-- 
2.43.0


