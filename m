Return-Path: <linux-kernel+bounces-572041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C85FDA6C5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E219E7A8C10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10F235355;
	Fri, 21 Mar 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neXjgRA9"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F523497B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595317; cv=fail; b=iHJuwRG72l7Sl9p+h0Jo4ZDOv8QP+TGfNoQc7Ncyp4zjyp5jsdToZDJIM3fyBMOdMU1OBbudjVnMo9v/WyBtKXYbGsJs5m7TL5L7UbrVb0wBU3IbeWReSi9eXubrmY8mtjQKgMN4pyqxheP0OgtynkLTXG8xnlaxvVrFLuwfEg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595317; c=relaxed/simple;
	bh=fqUsR43lvDcwCwVIwE3cbjGxbwOsvPb9fqiiQTM+u4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O18oTe8Alyj/JiwuIparV1XHypDQGQlnHxemnBN4WsPz1qMnWH868YEol2VzQBB1yiIO0SfXdwJp/fJ+nsgP9JtlHVLmPeJnA9sF67PCp/c6gm/fvvoVEspNE/HBjx44iI4ypxJv3OLMJ7wXw4gcOnjTfLKaunBZl6hjbk4ZSko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neXjgRA9; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1yS6KWHJi/9R3LrzIozHFUTiaelz44/uDUWzWQUsujLRstWkbrEC4M4ZoKAas1/X8fyJJDWu333coa59/dQUocqwU7ch9tnXknwovzODFtydJVhaP+kOp/eMBcKAf/S6Pp18dSf76SdUShdpvkHcHOWVJB6QFkhH/FUio6o4EApFQ57uxKnyrwVS6xF3zrXFt7VJZlqbNqJBXJBxdt+DyFx61aPP2ANrnQKxV8zjBzP9kmiC8iFVRwZhqTh4xsR2vOdRmzDrolGh+8pNMP6VcDXdzn5+4JjWD3yM5Ghi0uYMEKzstI7CkZNZZI6Bj4V1dimLYR0riB8sl8voT4Hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vDJuHzd02CaDKx7N2BPzQ1YM+Wt73UuvJZ6iOQgjzw=;
 b=wdrfKs29CFlEd8NZmIRMbj3ghVHUnsVonc17OykPk5Huwc32uqQQXRHDvK4ZFUbcWQMiTq6O6Sp59ZD5PeDzeRAqqFqL5rGXQ2ME9XPluEr+BBwouIDgz0Zrbx/W8wJjaw123Tq6VHus1E/jriZmtRBqA0TtZekk3s/cu0pM2kGt0liGfL7AsGuCGdYncKhJ5xrVLvg2QJJDlIG+T7z+R064dZFOA0LtJHqm8OQ0cBuNz7Fng9DB4itV5N4fxe93xGlPdXZ+TQ6ryS/lJKpVI9OgfiPEziFHdrAA4BX56EFux4bJgwjLy943uCQ/dMLDkypWKAsx2hOhiGTcXyX4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vDJuHzd02CaDKx7N2BPzQ1YM+Wt73UuvJZ6iOQgjzw=;
 b=neXjgRA9ryC0W9E6UwvAb6rmqOdmDLJTGA2JKVwVq6yvmwkGUh8rOE7C9CqLZawBjqYDVeIUcNmsvWCwY6Rj5nDBpAvlfdyls9jluiU2rjfk0esoVMZW/O4axAtTnTN7gVWk/KtaOF+RlCzmVQTkEnRBj699SJrWKcRqnNjWl3LhG9UO1HoBof5iJfCxXQto6ZSp9UUw+Uqt1dh3UsmL7Okw0TaDjY0lBQM/MirA24nLB97n8PRVmXrvgY7B7cmY1ZvzKjzX/1Be3jt/gwINDM6UZELkePYux+WZ7g507ogHAge8P5qTPMcIu5YVIYRadGrYX/cVZUKtqAnaMXyETg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:13 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:13 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
Date: Fri, 21 Mar 2025 23:10:48 +0100
Message-ID: <20250321221454.298202-3-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1097c0-a687-4f4f-2c51-08dd68c5da49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QTs3WP+Pm4xIqMOlH25wSS2xrUuOV9V2wLl3zP5IiFMhMFZN60oO5JZrIcbD?=
 =?us-ascii?Q?bhaFF0pk61E0E2XqzIlYHYnNW143AZFj07P/DGtVlpMszNICmPLy4D2izu93?=
 =?us-ascii?Q?aaOs4ljAtfxXmq2puqrnvWtngjgBQkoNi35ZbnL0W5yvLcqxDJUlFL5+ekKU?=
 =?us-ascii?Q?yqtAMiue3krCgPchbs3YAFcUZjnV0TFRQauNJBy/6jwpTovdoB/106bcTh/x?=
 =?us-ascii?Q?BwGWnPXHYp6cwc251RIW2/v39xD8+wRzhZlLOUgOxW84PlI+md/RZM3XU7pp?=
 =?us-ascii?Q?hDLuQEts4ZVpzRk51HWhsnz5+HSed13juczr/a7zLNh38+A43DdXxBiVDfFK?=
 =?us-ascii?Q?GA4LGGf4J+UCLUKvO4z3ZqGgmjdVkUWLU9i28doyxYoGh2ajRbZUw5r+E+u1?=
 =?us-ascii?Q?gfCa41oz/2Jc0xyRkwBxHjZq7MgisfXvLp9K0vBk0msSOcE1MfTEXKFQWSyO?=
 =?us-ascii?Q?QEI802jDqSGpnveMza3waK5j7Y4k/XKrv/uMQKpeJbBTIbxsjCshIYuXPgE/?=
 =?us-ascii?Q?wFtrF+95VZ2glHWJ6YKG/GTneD98UOwI011fP/tJEf1rYYWX4fn0Lp/tGGih?=
 =?us-ascii?Q?Xckcto50yDbChkmfd9dKL7vTODmGj6SZr47elLQ2mE/ywU7LO4zO1FMQWpQQ?=
 =?us-ascii?Q?XBrzOixo525TrHKtw0mKZMj3pt9GGp8zUY5SwY7EBls2kknhN1luV9JeSRNx?=
 =?us-ascii?Q?EGZumUFmiEfoAraAAMLTmD9KyxKJ4dOL68s+8OQuKvPJJr2keuoKjcP0n5Y2?=
 =?us-ascii?Q?F0L65sOYyZ3LsfGjsBJASdHW7fEu+rHW2rUYval1G/u0LPJ+5SOB/WycxMHc?=
 =?us-ascii?Q?jxNX3FjKzB2ZcH132sQr6c7KLro2hxa2TQAzoEG7yLvZUosdWWsoKb6GOPOZ?=
 =?us-ascii?Q?NHU8i+gVqYCntFfHLF/Nx/Xi0xJkBOSMPV9QmKrIq5mbB3WM0WRmdAWSQ8gR?=
 =?us-ascii?Q?6J/QtEqzshKrCBF58KAxLTc2ekA07ZM0SvfRGhtVfpFS5vL2P5u7aj96kS60?=
 =?us-ascii?Q?87BNn7cO5yMSoZuQ1oghSRM0Mj+zzzufOPD+mtXa8fHHtDHkrL+SrAE3Tnb+?=
 =?us-ascii?Q?v9WXW6N8x2b+3W3VCmoZvVSpqm2iBrabqquJ6Eusz5ezvL9hKomE2pWahLDP?=
 =?us-ascii?Q?00qsU33kougAsxB1n8laxUtaqq9//3g5Z/aJn1n+7OqrEbVlELv6UWAsbnqw?=
 =?us-ascii?Q?QCfHJ4X5Tk1o0c+dX5WPXungOP75FMjMXLHLwFFDVmn1ES6mB9CX8Z2XHncs?=
 =?us-ascii?Q?aTilikHf5fKeETP15YtQoz+FKxs8A/0e0rdKUVIDSvaBr0KXYeRXXpI4PEjT?=
 =?us-ascii?Q?LzU52wP23XmPFmc8Zxs1iJh/BlGNXfgcePeYjbvywT78lxNDTKxQMSVc4apd?=
 =?us-ascii?Q?HvmiOAcb5zatSZI48ynlGZl2SSXf+vArmRHBkYTclcpfSv+fPBEs+cpN9u5/?=
 =?us-ascii?Q?uuSnbkrKQZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLQNalsR9ASgq7t00XE7kdYbNhXH5qwKYTEtnACiiDmj2OZKDqHOZoWJjfT4?=
 =?us-ascii?Q?O/BLIhy26oitUgv34lK1bRf3x3rWxiYKBtSSxz5Q6dzA1TIX/TDAxvihZcDn?=
 =?us-ascii?Q?F7ZDDsHNCfN82+qluBte4QnM1b7b8tg111zyHh0AmqZa/yFLeQuDuvjFzL2p?=
 =?us-ascii?Q?wIckXUt53yWMRKzAklwStJccBcjXOiHFMkbO/hD8aNQG09rZBPC8DAtrXeWd?=
 =?us-ascii?Q?iQFf25MAPsejgwjptfGHX1bEfOYL00WxYI84SUuNARDioajVPSo8n4GhQim6?=
 =?us-ascii?Q?vSqfARxE7wFrHT5DopzCv/k6veagbYfZPvEAXaB2o1dnG8ah4Sh3ie11d0a7?=
 =?us-ascii?Q?8hO2DS3LNSiy+map0F/5Bb23Vze2CmWy8bS1PoK1Un7T0EZP9zTb3Td+FC8J?=
 =?us-ascii?Q?oJHvsOTR+fafsqHx0bgHTLWrgiTSFsf0RUIkCHQx/uXe9hSLQg4A94dKXwEw?=
 =?us-ascii?Q?M3+zkzZh9hpTLXg5cGvjXok3KuMwhu3q5MBmColDmzxH+oYEgfrnUm73D9Yh?=
 =?us-ascii?Q?lbcgEsjV42TQpfxA5+WG4Fe84i61fONwOx5OqWWH3SD33UYral1gSOMevqe8?=
 =?us-ascii?Q?5YrmzwDybjjL2Wlbh3Ee3nljhmltFwv13KypCglUW717/iixGqHdx3u97SFH?=
 =?us-ascii?Q?oMbU3ViItkeiUJ4mRjf0zFhocV702Nd0/Z46tqhHUw1hg6B/VVsMt4RLEuCB?=
 =?us-ascii?Q?i6lNd1NWXMbcwXg2e3qCqhV+5SuG3FPzUObKMSdD/BjS2Uaq+dmxV0FfeAUs?=
 =?us-ascii?Q?t2HSJhJZJZ7az0kOuFTN6uyN1PzlVHh9LsVzYJzJOSC5Sr/uSm8JVyFKF2HV?=
 =?us-ascii?Q?2tjdvOGhdRAXoz0Ny0PzpPOlUkl6FrKpm6yIuvgHpPCE9oZjjE8fM2TrM2mi?=
 =?us-ascii?Q?TsdJViDfXEtWQtZad2V068tPupWW3/0fhZoF5pTyhx27fvSEFQKsAzANkn6q?=
 =?us-ascii?Q?fLikTisfsME3R9Nz5q+PJdx5SKwIaildOgwVQpgDmsd1FPYHlihns5Y5az+k?=
 =?us-ascii?Q?i5adpK1ST4Br1X2/2+HCWR3B3Go0NYmEGXOIaJ4+U21VuQoat7poLsBJm4e0?=
 =?us-ascii?Q?pwWi05qVW9ZShj73dcf3/pjh/NClUdu+imT1dreiwm1iZsgs236W8bZ7pwQF?=
 =?us-ascii?Q?oLOap8Yx0wMWE7U84A5S0Mc07yaG8jUS3r2ArO1kzNwfkWkGMD745G5gfs7s?=
 =?us-ascii?Q?bbsUgTlgY1T0+JG16M5a6ywwPXS+B/88G9dF9RxX3GpoJDPyqqP9hEvc+2Y3?=
 =?us-ascii?Q?nwgwKkybyZQKyiYzwIHhHiZ9MlhslzfF1F9CNl3w6QagKU50kef29wFuR4GD?=
 =?us-ascii?Q?Xj6W6mjfym1e/rVGWAzgFR6v2DhEG4F6u7INArGzbQMGsrCqK9a2HFX11jDQ?=
 =?us-ascii?Q?8SQDxoctE8m9w0ftHH0KY7vHP+m9Jdg1qshb5FfLzjnJBgtgOxKZPt+DifKr?=
 =?us-ascii?Q?oB2Tsb6iZl1O9Sso0/Xjfpmn1KXC2+ZPEr01ynb1yyHkAOuibw6fTS65wRBG?=
 =?us-ascii?Q?Alfarrn3GnTgi053B1WIUgBQG0hHJiU2jgZBG9rLu2v4DmNcUej3fYBqsFnc?=
 =?us-ascii?Q?6ojyto/j0MivigMpJnLz79xKrseoYgIXIof6np0p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1097c0-a687-4f4f-2c51-08dd68c5da49
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:13.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFyBC6X1IWK15Mk/dVE/x6r0G25mX1O8cLDP6sFLGS1OG/RzoeZsnwGmee9lWqIT27cRLGgM8KLKaiae0Nl/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Modify scx_select_cpu_dfl() to take the allowed cpumask as an explicit
argument, instead of implicitly using @p->cpus_ptr.

This prepares for future changes where arbitrary cpumasks may be passed
to the built-in idle CPU selection policy.

This is a pure refactoring with no functional changes.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      |  2 +-
 kernel/sched/ext_idle.c | 19 ++++++++++---------
 kernel/sched/ext_idle.h |  3 ++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06561d6717c9a..f42352e8d889e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3395,7 +3395,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	} else {
 		s32 cpu;
 
-		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
 		if (cpu >= 0) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->scx.ddsp_dsq_id = SCX_DSQ_LOCAL;
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 9c36f7719fcf9..2dcd758681170 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -438,7 +438,8 @@ static inline bool task_affinity_all(const struct task_struct *p)
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
  */
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags)
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags)
 {
 	const struct cpumask *llc_cpus = NULL, *numa_cpus = NULL;
 	int node = scx_cpu_node_if_enabled(prev_cpu);
@@ -457,9 +458,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_numa_idle_cpumask);
 		const struct cpumask *cpus = numa_span(prev_cpu);
 
-		if (task_affinity_all(p))
+		if (cpus_allowed == p->cpus_ptr && task_affinity_all(p))
 			numa_cpus = cpus;
-		else if (cpus && cpumask_and(local_cpus, p->cpus_ptr, cpus))
+		else if (cpus && cpumask_and(local_cpus, cpus_allowed, cpus))
 			numa_cpus = local_cpus;
 	}
 
@@ -467,9 +468,9 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		struct cpumask *local_cpus = this_cpu_cpumask_var_ptr(local_llc_idle_cpumask);
 		const struct cpumask *cpus = llc_span(prev_cpu);
 
-		if (task_affinity_all(p))
+		if (cpus_allowed == p->cpus_ptr && task_affinity_all(p))
 			llc_cpus = cpus;
-		else if (cpus && cpumask_and(local_cpus, p->cpus_ptr, cpus))
+		else if (cpus && cpumask_and(local_cpus, cpus_allowed, cpus))
 			llc_cpus = local_cpus;
 	}
 
@@ -508,7 +509,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+			if (cpumask_test_cpu(cpu, cpus_allowed))
 				goto out_unlock;
 		}
 	}
@@ -553,7 +554,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 		 * begin in prev_cpu's node and proceed to other nodes in
 		 * order of increasing distance.
 		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags | SCX_PICK_IDLE_CORE);
+		cpu = scx_pick_idle_cpu(cpus_allowed, node, flags | SCX_PICK_IDLE_CORE);
 		if (cpu >= 0)
 			goto out_unlock;
 
@@ -601,7 +602,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64
 	 * in prev_cpu's node and proceed to other nodes in order of
 	 * increasing distance.
 	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, node, flags);
+	cpu = scx_pick_idle_cpu(cpus_allowed, node, flags);
 	if (cpu >= 0)
 		goto out_unlock;
 
@@ -857,7 +858,7 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 		goto prev_cpu;
 
 #ifdef CONFIG_SMP
-	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, 0);
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
 	if (cpu >= 0) {
 		*is_idle = true;
 		return cpu;
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 511cc2221f7a8..37be78a7502b3 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -27,7 +27,8 @@ static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node
 }
 #endif /* CONFIG_SMP */
 
-s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, u64 flags);
+s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+		       const struct cpumask *cpus_allowed, u64 flags);
 void scx_idle_enable(struct sched_ext_ops *ops);
 void scx_idle_disable(void);
 int scx_idle_init(void);
-- 
2.48.1


