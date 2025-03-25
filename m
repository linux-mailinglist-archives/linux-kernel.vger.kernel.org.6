Return-Path: <linux-kernel+bounces-575007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E30A6EC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A471893182
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820681D514A;
	Tue, 25 Mar 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CIc0ZVML"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E715FA7B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895144; cv=fail; b=eATPKMlGmUZnX+61UaXXVYoA3ZE38Hw1aeRc6asKneCsa4vDk8Lnw0zoVD90OHoufWrXv1gsaR9FQRoSGoiVqJCrcR7LwuLJjcxmfnwikNo16n6RumBT5XOKi/nfC/M8ry5XEwQKQOKN8CgBR/nLCSkPJRw3SuwKeqVnRIBvZaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895144; c=relaxed/simple;
	bh=T9Mryj0+FsiSBsTyPXje8N0WoP+15uMTzjCRKdhHudI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Lam+y4+fZsLH7h9ICPaBeRPGisyDyc/xCZIw2+a47C8vkoJDxMgG5n0iQOo+tIMyFRR1ay+Blhgre89/JzLmBuNEMpsjQlbe7vlub/1r19T4jXG2LgY6wNPJt78uA3BJcovTyqMpagZu0tl1DEAKIjr0QlFvbI7wXHwy2bGREpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CIc0ZVML; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNIrf1E7XVgul1BfihSlbg4mWUyMox7Ol/nsv/ZR2XacDaxhr2mmdCHMEMgB0gbjtTuOdniZG/jVgANIgLgSJMSrIaYd6Ui5ndZQVBwNpLjNRMCFjfikbUNii5FbFFw1Kpvqp5jx2DLFVKGD6G8B8a8jS70ragKVfTr1XwAj58e61Xcwd3IlL/a9MlzRAhA6JBXeEj98yf85fHZbxb8IphYvEg84w7FRYKpy8XFa6nWXbEJ4w+F2oQh3h4MrQON0H1qA+A4lD9Z4KhEHLB/fi+DIdS1gS10ZtS1VDTbaYeqLnBecC5M/L8y1NYh7Ad+fUosv8uNq95HqDkmS5w+lCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zPTJMTLYudUrmyuEAxlCVL1h/A6E4WRt5EkMKRmMF4=;
 b=i5X76iAuULlOF6aVX3LV/lRD6R4GlE1ftElWsbD5+7GmU0fIDKdONwEZT4oeFiOaY7uSJ+wivvb8YJ1bWDhz5QprcFfB82R8Evr3hYGbyEI8RmvudITH701pNaogEIE7zyFm4ZhFKfXrVfj/xNzEMy8OpDN1jD9vMaJDa8a6s0bVS8/6x4sqe0qs9IcwGk9AGEbZrhclScbayPu7vVqgHdlkfT1dz+2o+22tS5VJlq0fks/W+CIXfh9NecYt7MmFINhNBB+1KQxqvWgFhEHlqQwQYoULwjpEdUgQX4bfIEhzGYhUGyIWmcnExZO2d8f9Wu8KThTNhliG2lI6xdVcKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zPTJMTLYudUrmyuEAxlCVL1h/A6E4WRt5EkMKRmMF4=;
 b=CIc0ZVMLJOUl4ZnDjFUab/1jowvqjCYKQrHqVTeGkUuyKkog/3xMFBPHvmqivdPg4SJBPWpN/2kvr2fmsDxKJXXtrh12aCWvyMynG87JoL9RZb76Pe9YJDdkUq3TXUQ3ed9XcmuMqm4uiiWy5XgIxp4iso8mtslbMJpKv/s2HYwYom51uoSCxqKvexLPR8f91Si7vJ8/tPpCdEi7JY/9voXAy3mHM0/TxG+6ZB0wrY8BTnah7a9sZPwMCweGODHCrplE3GfIyOKholea4QKI5yMb3I1d8fta2GP+SmRI4yduCGlrfST1wjjzKOAGBIczVt8NRv3sdi1BlwcmIjKBfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:32:19 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:32:19 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: initialize built-in idle state before ops.init()
Date: Tue, 25 Mar 2025 10:32:12 +0100
Message-ID: <20250325093212.47188-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::12) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: e945b78c-6f6e-4b92-c89f-08dd6b7ff05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T8VLigmWfIe5khQKGS6yrds+G8Ah/cV5x/BOxRZGZXwdKRAajX+ZrFwZuXoh?=
 =?us-ascii?Q?L0XV0Yq+fpyJwi+LbzZarElG1XIp82yroD8GniX1wI7OgyA1EYHHTr/R6T7v?=
 =?us-ascii?Q?637VHzfSd7i6mk8P0wR7yUQZNE5CzH4j/yrmkvg9DSIBzq3D5XYkYttyEnkr?=
 =?us-ascii?Q?APGEbSWs2EtxA+Stg3UczU2NIv9td7DVrgiat/U7WCvb3/F08wLD1MFn5aau?=
 =?us-ascii?Q?Qfr90hBYVROxZKQQXFjZOMGXTd/hxioP02Rhf7Ak6xg8NtZrciWluBvp7d0Z?=
 =?us-ascii?Q?YEaf7ESq2dYLcBg/g+ujgr+Hulghbg5s1JHtUsPOnl7ozAf4FnXMgzPGkKSs?=
 =?us-ascii?Q?zHp6TuP+/3tenTdmbkTKjktxt2Exte9YK2Jixiarp0XIga/DzHsbPDocj77g?=
 =?us-ascii?Q?C17sD2IX1VLjtDnzw2rxTvO76jZrqx3hIiJE8cEBL2wIw0fHx1N1wv5EPzMW?=
 =?us-ascii?Q?TEzxeNGASLmGnpKNU2A3jjGkD/vHyc/ibqjMv8QOqOqT/IEIX6qsOyY6w3pq?=
 =?us-ascii?Q?VmuzZC7IZR9xxioQjd7HcWQnp/aJUwhwWc8sQX7XDQPKgr4vMePMckBIIfJQ?=
 =?us-ascii?Q?o8cbodb0DjrAKm3xwaiO8GgaqA5IMD5YDPKgd+KGWLOH7yU51f2O7JwzSqUM?=
 =?us-ascii?Q?x8AnM1UmQ5wJMtzrfLn3paUQpd0lDOZoA+SZNx0UVtgvAmCiOrC9okbNCXCV?=
 =?us-ascii?Q?bEmmvlLEydshu35bzk8tiKXXcBlsEsbwZLniMM3T4ztF5ms3XDEwWu3XK0nx?=
 =?us-ascii?Q?Pio3uz2HSHcmzt6w/ObfGq+ndtNwHmgSv5j2Fn/NjiuqSUZkQGes/5PXmnjI?=
 =?us-ascii?Q?juxmW1VPtBY7szialHzM5g0nhfycqr3jg2nbERzq4om/NkxXaeTe0UrVAgX7?=
 =?us-ascii?Q?sPDdgJs1w9sW+6vrAm8/3rTUK6cIIqFCuVLLZDaTlTINeVVR0hleGrhzuBfD?=
 =?us-ascii?Q?R6G9Bwql8k24w4Mn40jvflX1ODn+kBbYeRce13/G2Ln0ZfJVuVVj5wQv3vUf?=
 =?us-ascii?Q?97f/THsWbSzBKIVoda9dnxepnNUYUUQRe7Y/bHCyf6rmAXzcJEXscvU0Wd2R?=
 =?us-ascii?Q?Y8AsLIKzWA2TPwJvK12Kpdi3rYiQx7kerMAE7MRdFa+fUUP+rSTiu/yGsqbt?=
 =?us-ascii?Q?8tY54sVBsHxBS1ncG5KFaz/kBEROlVjjRnyD0LWH38FhymApNhhxIFD6PQ7g?=
 =?us-ascii?Q?SzeHXSudLHODrE7WWQ2kZFamJco+GZwvrr1eROSsRDg1nB/0EwZjaLJfKATZ?=
 =?us-ascii?Q?hHvgjB4/oMfK1jWBT7i5ATPwJw8pGt5pIAqtDhA+VRbNO69a85+aH2YD4W/3?=
 =?us-ascii?Q?AVwrmUO36D32a3F/pngaLBfo1sBpZIaofVHjAesFsQN3wCBpm7pGixQB2L89?=
 =?us-ascii?Q?ql5cCd3VfHCjkgY2OdXI5UA01AyN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YC7tRVGfojuA/M65dYqzln7l4z9chVva9A4yz8m492rNe8VC0eHtRKt246rH?=
 =?us-ascii?Q?yhGxdBlahjGy75IPqTWG5puLoGhNqR9aEwnRhKBI2X/73FavQ+qhLKTkzLm4?=
 =?us-ascii?Q?OoF8xc02rID5xTN3/aI6EipwdLPvAo4Zok2MMlluoSZue533cCNNqgkbdhLt?=
 =?us-ascii?Q?AoENw06Uv0bEGrm+0q+jetexeSDtQa58JSm711MwuLg5zPBvfsP+ygLlw9+c?=
 =?us-ascii?Q?bi8I3tbA97G8R4wWCwF2MDdIlkrk2rfV4oZZWeTmzyaE9K/GkPRyb7LzUX07?=
 =?us-ascii?Q?T2GUkjujjs8Mn0GrHlIxgBTBYBYV23STZw9GESbnLPKJNOkLEdAHNaXB8SE3?=
 =?us-ascii?Q?pe4Cs6eVHfFSmnk/P7kCTm8f10HU+VgRKSTC5uiVhwwSwZtM4c372zSUIfYJ?=
 =?us-ascii?Q?9xJosCesO6K9umuYmr+Zl4ZH33RbAclf3tw+U03ozhu/Pz2VD9F4OFS0k45+?=
 =?us-ascii?Q?+KQglolSIKlS8HH5Dj4At8QE5xF0kgVc0RAT2XKS4gRPEi0GbP1DJI1A5jU8?=
 =?us-ascii?Q?34k6Ao877u9OhKEW4U4lF1zuui3U7+XXTrHFLwgky7gIRdhEq80Qf1EzD8zN?=
 =?us-ascii?Q?JAFwoztiFQY6DsH2LNZ+X1pTK5SecvKlQSeD2Ej3WSlEWpoBIk9EkhGtpI42?=
 =?us-ascii?Q?gthVMIqhjJEigHhGm+EIzqZqmsh/h1JZ6o+Pavh94stiN2oj2uA968fssAHm?=
 =?us-ascii?Q?bUNg7PCBFnNM+2V3Y7sP3lEI54ePzHmkaX3UDkMLp4kgGNwpHYI1nvfewnvs?=
 =?us-ascii?Q?zoDBiLPs674+L0hGQVHbUyxsl/FtN+7xAfSAXF2yR0PhFF/4X1b9p8e1NeBb?=
 =?us-ascii?Q?Ey70p1lMx0egzWOj1mKXOykWuwW8bh+knamS64s9SQQDPD6GZP62ihP0/yzo?=
 =?us-ascii?Q?bCjYjud4NIhb/uUrc+z0nF+EY4pPIApVKUnI6cI6qiV2i/N71/OABBOnDYQG?=
 =?us-ascii?Q?8SuJnQl51VYLgRM+/6Qb4aLQBkRtNSl2FC86IwIqtQphxs5cwnnyNGecJFE8?=
 =?us-ascii?Q?QqIs+jjeTZ4Fwr1wTh1HEkOx8WFbJrn/SmGlntY8TRNBEbP7ZhhkCmBV7g05?=
 =?us-ascii?Q?ZfCC9qqa4AJ0kdHXqADqpW3ENX8UQWuV8LwaIl8Zwb2Ef5K5j5NMnaq2vD3r?=
 =?us-ascii?Q?jQqOBM3Jn08eBM3/kfTRuv99elNOpQTE0O/Q7mvZXLoS4rtpJmZcElWxTdLX?=
 =?us-ascii?Q?if6BZs3Jtxc9jXfDFQp+AVjMjOq3Ua3o2XGXosCKtuyw61Th3QlwlobW/OJx?=
 =?us-ascii?Q?aPXgOzyVUbPcwcZm5waFphrBBXvuhVqDsCu3mR5LXpRE+wgFHlFClD8Ve0yd?=
 =?us-ascii?Q?ydUxierw9x+MfR5wlD2Aawt4wTf5v/QW+XA3EeVPAE6z1QXyYHIM000meJDX?=
 =?us-ascii?Q?FVLOYkpyRvCL+1VqDLZ+5Nyeu/BSxNWFREF3phjlNn0PDZjZL8bl3px86sIp?=
 =?us-ascii?Q?ePDpdxcfHisr3+8etufLlMTbS+Sx/1YfuSqusbsWuNEbAdAD8b5206cygSPn?=
 =?us-ascii?Q?uxXDo+yijc0huydyAW5V8MBY9D9EV4g///YzsMLMERz9OVWf4HW6XD3mzeuI?=
 =?us-ascii?Q?0+FY7T44g949bZSAglCMRAcYvHxIgdHo8Xyvcadm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e945b78c-6f6e-4b92-c89f-08dd6b7ff05d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:32:19.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7maBFnbbk3FmkTGraJStzGK/fdGqzkhHMCCFCR0HIHPnLHzA7GzwA+smeyorHFC7ai9icNa1YVORM8Vo/bYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083

A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
before the scheduler is fully initialized, either directly or through a
BPF timer for example.

However, this would result in an error, since the idle state has not
been properly initialized yet.

This can be easily verified by modifying scx_simple to call
scx_bpf_get_idle_cpumask() in ops.init():

$ sudo scx_simple

DEBUG DUMP
===========================================================================

scx_simple[121] triggered exit kind 1024:
  runtime error (built-in idle tracking is disabled)
...

Fix this by properly initializing the idle state before ops.init() is
called. With this change applied:

$ sudo scx_simple
local=2 global=0
local=19 global=11
local=23 global=11
...

Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c      | 4 ++--
 kernel/sched/ext_idle.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

ChangeLog v1 -> v2:
 - fix potential deadlock with cpu_hotplug_lock

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d82e9d3cbc0dc..3d20228052217 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5361,6 +5361,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	cpus_read_lock();
 
+	scx_idle_enable(ops);
+
 	if (scx_ops.init) {
 		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
 		if (ret) {
@@ -5427,8 +5429,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	scx_idle_enable(ops);
-
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 746fd36050045..811f8bff2ff02 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -794,14 +794,14 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
 void scx_idle_enable(struct sched_ext_ops *ops)
 {
 	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE))
-		static_branch_enable(&scx_builtin_idle_enabled);
+		static_branch_enable_cpuslocked(&scx_builtin_idle_enabled);
 	else
-		static_branch_disable(&scx_builtin_idle_enabled);
+		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 
 	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
-		static_branch_enable(&scx_builtin_idle_per_node);
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
 	else
-		static_branch_disable(&scx_builtin_idle_per_node);
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
 
 #ifdef CONFIG_SMP
 	reset_idle_masks(ops);
-- 
2.49.0


