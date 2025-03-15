Return-Path: <linux-kernel+bounces-562351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04845A62488
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA3519C1871
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B714F5E0;
	Sat, 15 Mar 2025 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kXz1etgv"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384C189BB5
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005340; cv=fail; b=EUManVo+InwH72KQZgkwcK2Ew9w+ksJM0WWbk477LWgWk4kyRMmq0wS3R87rV5udYg+98B8w8GP/JV5Js1ps4pclu0+SvRwIp073vB651Sw2NNa4/QYgJyOUvqg9vKWp90ra7GpZyZT2fA4qSC9Cf+zuOeObTdg/GkrZ8K3XNMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005340; c=relaxed/simple;
	bh=LlD5VG93NU+Sl0cBJywwpYceaWCY2v77xYEnEmxWGx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sfpxix9ZdouVrv25jUT9D9bVoNzpQz+AmJ5M0syAPkahc76nuv7tAtLbDCtzAsyFHstkTOf6N27VYcJdjOXseqysyjiZF4DSeJLFFBu2EojU3Yfh4MzNmxSX7f5nOAANViEgouI+aw7erg2Lkus39VddXmAuJRfs0Y1LXB5y7RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kXz1etgv; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0J75pxQU0llTps5sokSVi3D3mkr+Qnac0Qr9aZ6OkyS1jVHnRpK7fXqh6TuoqrFrG7+i4wI1CrJVJDqTlOiAvyV41zahXCffmh3ejLOI2Ppr0AZW91qL/thm2a2Qq5QbujPjUvRzbo/A5jX3PfV4yUI2pl9R9XCXKOTGKcsEoWpu/wArs7C1D5bc/EwnQDMgMfZTyozEK5aVLYGQNtmUtPcF74AByFjLtQr3k3XCQiO+pAi/RaHj/ZJncki9FMOYcBrvS3ZzHqbpK+dVDKnuJVdprKbViy2LlQlDuP2bh0vanUVVve/d6KOhMAgllh/bHqjCC7+r1ab4G5hAKqtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez/YohAYm/+srCtNcwNMlKqx/VLfPoYZd4wpiqD5Kho=;
 b=zJrg1IXCqbn/2gMB7rau2NucnaImFRSOCHBqqH09TFmyifDvaNNJvPc2hqgEKEqfLFqOQyNH0Loxd3VQj3eUwgXZLmgnS1h1X72DEl07YYeEJDHfibAiRqH8iWhX0LF88OvyffsNX0OHo+QpbGCxV6XvzOoX9wDvRIfRIzOet1dYO89qfd8pCktmo5nWytBE4d8M/K7oHaB7lGLKGqo7DH8qPoXIMIJJgHI/1pxmbg7VMhySfdCMRfwjvdZa3NYkIQ9cacc7ssnMN2oNx5kzbUUOTUqjAbI7VYtdL/T8bEQhYjZK20oXF/pZZmJ6DgMM9SB1M0nWnBOIG7QTZTYNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ez/YohAYm/+srCtNcwNMlKqx/VLfPoYZd4wpiqD5Kho=;
 b=kXz1etgvdQlJukogNwHvU0AcfdqP/oCA1/c+Blj33Ajk/MR4Mrr4UpX4dM1loJtCKSL/jMKr83SDnVqERM4ZIMENwwKHDuWtr9exTLuOGJegA7r1ov/lN2k6Ch6g0Rk6hlKLjlp3Chzykj/iszVNILUGr3LqJ5Fw/4kGlSYUZU2U7mQOZW80jTXFADMX2Bc7hfIN0FX0S2drQkEdteY3NOu7uIxzFhchm8YXBXkEKq0L/HOiRnP+Uv8IZC099iyHx6MBfpZ5CZD4ziiY0ipqjRutBDzmQYURzPXf/uwL7HfT1BOaMFjhHh7sPtlgG2r9zbMrq0Ac3xKWsb+lOVRbBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:11 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:11 +0000
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
Subject: [PATCH RFC 1/8] sched: Add support to pick functions to take rf
Date: Fri, 14 Mar 2025 22:21:48 -0400
Message-ID: <20250315022158.2354454-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 5389d765-d992-473b-9e7d-08dd63683127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQ5ePGVFVKMmf6XmUgzmnxqUCiBzmUhzZ9MnQ4x8fwsNDMY4c/2AWYoMLGln?=
 =?us-ascii?Q?MivQ5ieRb7zi7DmkyFeWmmM1k8r8c8XqDBvsyzV5pR1YnsXCUMpjxghiIAbs?=
 =?us-ascii?Q?3NCUnpqWS2hwqiq89q0HezEEwv25B2SnJCz1cXY3YXBx8kKoC/ljIZ/26Ms1?=
 =?us-ascii?Q?la8w96Halcq5QBtl7SHqwz8Yz+I/mmXloR+t77/gU0pJ8/bM23H4TOQPxc6x?=
 =?us-ascii?Q?EbkRNhSEaTEYWgYRvZlqtX0x7JJOFrDjTFg87z/oJ42Xm7a8xhJaoq43FGab?=
 =?us-ascii?Q?CprmkrFfkHwlya8YTbsfp55XYaisEvd51jMfdtUfiZ78fIG4Psv03KSL0NjO?=
 =?us-ascii?Q?/hoYmnK+3qTTNmZcs3NsNY/8OT8LEfChKI/Y/s6g+1I88rQ4O3Mi9Ex/sB72?=
 =?us-ascii?Q?5YKfYrRR/1+f/aMCREnqWWpUEZiwyHzOy28qm0jyaiceWDH9tWTHE4z5BIgz?=
 =?us-ascii?Q?1KmHFulWqShIOXQlQ4ACArknKXB5Dx910qlN0kBRyB4ZuKULw2e4+yARKmap?=
 =?us-ascii?Q?OSLRb4iH3xG4PP5+8+SQK1+UdxQCvhm3KJPJ+Ex1UHFrklTJuGScX5H3sVjm?=
 =?us-ascii?Q?L2tlQFLb+Oih6+NrqyhZ2To3obIehqAb978cSB3+yYJnGtfaSGcxs0TO/zXG?=
 =?us-ascii?Q?j9U428vlRRw/aH1E63Bg/Qs4FQ/DPqzBlrXzvcjIjenz4vacHvj1yw2Gf88c?=
 =?us-ascii?Q?nuVTpdIbHUOWI0rmL2ft0FOmQayw/EII9qxg3nd7C150dLsqOMJYD4p7BnLW?=
 =?us-ascii?Q?asfpssXvkcLUOMdDqI93/bmf5uXm7kCL1Gxjf+hxHWOdU3i/x1yZCGvBVLiX?=
 =?us-ascii?Q?1RPw69c8QOa7D7BU5QeMtLHXKSAOZOOamoyC3a2X7/abrgDQq7u1aGk2U28c?=
 =?us-ascii?Q?EPHpqklnVY6PhSek7wJNpWWTw81ScLZUIbzigmWEKolbOYaRpdoaMstsrjjY?=
 =?us-ascii?Q?icShk14abnYxZ48s5oBv6THcsB4/SR5fJppymGNQkb3Zfgd8WOMI6W4RfG3q?=
 =?us-ascii?Q?NFqBstsxzX5HwF6W2ebhqhqoYk18IhegVaGMTkZA7pd+RV3Aw+4gLLjfvcOk?=
 =?us-ascii?Q?7D1v9gBUsSEy084KTD/iK4rrblzfDeo1CdZz+vN6JBwi5IGYcHPYV2Duo0Pt?=
 =?us-ascii?Q?AOytRzG3W1ZI/ZK9OOOgbnAZvXMv8aX6uwFNbQ2StQ4Osw14AS56ptunB3pW?=
 =?us-ascii?Q?6HDFc48aCGsu0JinrkPM3PrKf8ZqdBbnvwhnAZQWADwFrk7hw0+tOvLtc5fJ?=
 =?us-ascii?Q?zO6+ACdQniZq5lo6o5yfeE5HhzwAy895fkArxrAISRfecPdcy/3Z6SSy4Z53?=
 =?us-ascii?Q?+7g6bzmf15/6i0kf72I0WBRwyhFnRD6J7ls6MY5Fh6bGGM+DJpGJCojPJZsV?=
 =?us-ascii?Q?8kq1xLZHbV/Wr5G8mQjj1c8J/EKyJ4GKOSs8ux5Yi1TxoioW37XT2KIO7dhQ?=
 =?us-ascii?Q?u0GCF8qxWM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GibfGWB2NOvAJR2K8+n5yK4GwlwHqRilwDE7zgcqSx+BD2WWvdz0RotJp1n/?=
 =?us-ascii?Q?rU6OBy/49NCEkpTwB/LnXCCP2KFelEmoxz24kQFDN8PMHTvet8wSxnyd8bSm?=
 =?us-ascii?Q?QQw5Mfw0HqvcQ0PebPL+STxkes4KS6qaiPHXCOa/unUyZDUjrXSBcY8r4BJV?=
 =?us-ascii?Q?kEzQ7TdP2iGg/SBUUbsMXxmbC8d5A5+HSZ/u4WAeV56NfCwhEnfPRvdT/Q3X?=
 =?us-ascii?Q?iw5P8JEDLdZ2myfEzOeXpM4jQmCfOtOKxt+ySnqqSxbtZUO65uDUC+J/o34+?=
 =?us-ascii?Q?MQ0flXchw2IeX3cL0uADx3a/LIpqL5FT2ecb7+OIBIwvf9y5xLdQMjjYXbUc?=
 =?us-ascii?Q?cRIRDOxu5ULYuQBoUELzu98MbrbipAmqw+WKjFQRmT6vUw2+xNCgF9aEV0qQ?=
 =?us-ascii?Q?IG99RxPaDjhGo41Kpct0oNerVLuZ49PY5KrHPGY1bsJGzu7p23ccH/2+ajk+?=
 =?us-ascii?Q?inuhZb8VxP5QytQYoVKXFzm1ur9EF2y3Pf1xuAFM2ntAexAzevEq/VcZM7/P?=
 =?us-ascii?Q?QYtM6bx7RLhHKtjjb0UuzLtbipkXiFzSr9YLjRcE5YIBY27K9IOqCD1qXlIm?=
 =?us-ascii?Q?Zg6t9e4l2luYXuo6kJ8el86dKq8azNEBoIxJ2G5l/AWaO3YA6N4M0RMgmiVw?=
 =?us-ascii?Q?V8BUXcodOtVGR+xdPlky6ZkXvWdH6gYjvcFxgAkjfLbCfFnBD0bF4Qg+4z0/?=
 =?us-ascii?Q?FhxtVGnTV5AuN6job4ufOWFWVbG8lq3nstBhr2l44vhXRah8Ud8itlfaYxzq?=
 =?us-ascii?Q?F0Y1UXgK+LOFo4KY+UB5pYFGME+Gk68vPgpTjr35PgjtWFLfyX09Ffx4LHhx?=
 =?us-ascii?Q?26/0/L78IGEzPjd/4oPjLHuesv7AJhlcQhwDWCiZTl0KCSavEz6IKhUZI9wH?=
 =?us-ascii?Q?XX2lx8d5LhYNWKfFqDzjotEy+J/WAAcK2UNRljVK1HPKMLBoFChELc7WLS2x?=
 =?us-ascii?Q?GPbhwqT5fQvd4QiB0OazQWpfhMfajbG7+XQkHC0n5NmbETUW7mZYWHlb88iz?=
 =?us-ascii?Q?SyXeLfk+pvHXmTj+D+dNQiTyn11MB/dgfj90dYdE/JmyPwskSQ61hWq1M7uf?=
 =?us-ascii?Q?4lhWnF1ajhnQ1SM24jou6rUugliW0nHgI4Jnss/jVYXteB9Qya993R+0HDFu?=
 =?us-ascii?Q?bWP5oPdGf6QC8sKFM5KajSUblcPmwkTthCSH13KbWbD2j8aWnHqkxCVi1YGt?=
 =?us-ascii?Q?I6aSXRT9rdaQj0raj1awvXZhCUHYZPhQi2XzVcqTzCwdSedHNusW+vUqIpx/?=
 =?us-ascii?Q?6/IpLVSpIY8Kkfw2rqGZKl0hy/SnOJAhYVvktoYTZ08Ny0ZD4yrwavB/DYof?=
 =?us-ascii?Q?KuRVp/c6D4M9kdpBvg18L/3hznRcWBP9hHw8Pb1y3BT/gmalEu2hy/sIcQ0X?=
 =?us-ascii?Q?xzTdKYQ7AM0sgzM26by0ldGEwvi7SXVS0RQ+5vyKoBIGr29c4PqzK17S9++V?=
 =?us-ascii?Q?yQdSRelbtKrL75Gke2bRZHWalKMi32bwi5rNLinfBapSJuc3CkoNbhJ9oYlP?=
 =?us-ascii?Q?euBFa1nue/ECgv8q6aIuYNoztHLJuZdrOrtc1iOefocUbGrI0xNkDmtCrmc+?=
 =?us-ascii?Q?JTYPg7hmA5ipP2L7yL1Di7aG7TL6jqWZuFgXzPT6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5389d765-d992-473b-9e7d-08dd63683127
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:11.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaE9fkNEamDrin67COYSjIrLkOxc2ziPZRjUrXAMzHdJPjraXt1MULzur6ozxHkRGukxXtjC+R6yOzAD+GftAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

Some pick functions like the internal pick_next_task_fair() already take
rf but some others dont. We need this for scx's server pick function.
Prepare for this by having pick functions accept it.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/core.c      | 16 ++++++++--------
 kernel/sched/deadline.c  |  8 ++++----
 kernel/sched/ext.c       |  2 +-
 kernel/sched/fair.c      | 13 ++++++++-----
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     |  7 ++++---
 kernel/sched/stop_task.c |  2 +-
 9 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..08b1a611bbd5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -609,7 +609,7 @@ struct sched_rt_entity {
 } __randomize_layout;
 
 typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, void *);
 
 struct sched_dl_entity {
 	struct rb_node			rb_node;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd914ac69..d19e4b7a0020 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6035,7 +6035,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p = pick_task_idle(rq);
+			p = pick_task_idle(rq, rf);
 			put_prev_set_next_task(rq, prev, p);
 		}
 
@@ -6047,11 +6047,11 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
-			p = class->pick_next_task(rq, prev);
+			p = class->pick_next_task(rq, prev, rf);
 			if (p)
 				return p;
 		} else {
-			p = class->pick_task(rq);
+			p = class->pick_task(rq, rf);
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -6081,7 +6081,7 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
 	return a->core_cookie == b->core_cookie;
 }
 
-static inline struct task_struct *pick_task(struct rq *rq)
+static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -6089,7 +6089,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	rq->dl_server = NULL;
 
 	for_each_active_class(class) {
-		p = class->pick_task(rq);
+		p = class->pick_task(rq, rf);
 		if (p)
 			return p;
 	}
@@ -6189,7 +6189,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		next = pick_task(rq);
+		next = pick_task(rq, rf);
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			rq->core_dl_server = NULL;
@@ -6220,7 +6220,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		rq_i->core_pick = p = pick_task(rq_i);
+		rq_i->core_pick = p = pick_task(rq_i, rf);
 		rq_i->core_dl_server = rq_i->dl_server;
 
 		if (!max || prio_less(max, p, fi_before))
@@ -6242,7 +6242,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
+				p = idle_sched_class.pick_task(rq_i, rf);
 		}
 
 		rq_i->core_pick = p;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..3f7fb7251805 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2421,7 +2421,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2435,7 +2435,7 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick_task(dl_se);
+		p = dl_se->server_pick_task(dl_se, rf);
 		if (!p) {
 			if (dl_server_active(dl_se)) {
 				dl_se->dl_yielded = 1;
@@ -2451,9 +2451,9 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	return p;
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
-	return __pick_task_dl(rq);
+	return __pick_task_dl(rq, rf);
 }
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5a81d9a1e31f..636b08977d19 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3113,7 +3113,7 @@ static struct task_struct *first_local_task(struct rq *rq)
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_task_scx(struct rq *rq)
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..734c22fb0e2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8816,7 +8816,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8854,7 +8854,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	int new_tasks;
 
 again:
-	p = pick_task_fair(rq);
+	p = pick_task_fair(rq, rf);
 	if (!p)
 		goto idle;
 	se = &p->se;
@@ -8933,7 +8933,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
+static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev,
+												 struct rq_flags *rf)
 {
 	return pick_next_task_fair(rq, prev, NULL);
 }
@@ -8943,9 +8944,11 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_queued;
 }
 
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se, void *flags)
 {
-	return pick_task_fair(dl_se->rq);
+	struct rq_flags *rf = flags;
+
+	return pick_task_fair(dl_se->rq, rf);
 }
 
 void fair_server_init(struct rq *rq)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 2c85c86b455f..01e9612deefe 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -463,7 +463,7 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
 	scx_update_idle(rq, true, false);
 	return rq->idle;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..f946a4b091e8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1735,7 +1735,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..ef6fbc49449f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2422,7 +2422,7 @@ struct sched_class {
 	void (*wakeup_preempt)(struct rq *rq, struct task_struct *p, int flags);
 
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2432,7 +2432,8 @@ struct sched_class {
 	 *       set_next_task_first(next);
 	 *   }
 	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
+										  struct rq_flags *rf);
 
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
@@ -2595,7 +2596,7 @@ static inline bool sched_fair_runnable(struct rq *rq)
 }
 
 extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 058dd42e3d9b..1c70123cb6a4 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -33,7 +33,7 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
-- 
2.43.0


