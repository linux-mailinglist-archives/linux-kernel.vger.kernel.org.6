Return-Path: <linux-kernel+bounces-423048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE69DA1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B909B2495D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E7145B3E;
	Wed, 27 Nov 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OyApzCQM"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022121.outbound.protection.outlook.com [40.93.200.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3428EB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687022; cv=fail; b=WjNfrsnRdHY8aZkSLoVmF8mHj1qDCNibGFFQSZzn2QZu7Trp/SZ2tTh/8+vuUtVGGVYa+qUcgfaYQDmN90YuhTPdhViLKNy7PZV4EpAyLRUQxTNvNYFLk8OaDCX/eeA2mOWYhauXL7lXWB918fFtCuCKHzY+IoA08L61QpE0orc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687022; c=relaxed/simple;
	bh=ZKIf07NR6PGWeiy7t6YjQrRZrDY17pmcQ/Qx7q65mqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AL5/zL9THtZOLg5mRD4cjirjvJF5OshfW+OJp0BtFtOo1pox0CDpFIW3BIAW+jaVgWjyV62VuZIsZay/P1QAWjHbn3Pci7Hf3yYkXi4AhcwP8ycvcsKpikaY+BR4HpERXbda5J6En5DzbnjjXmrKNtFtAJoiOe/94bfuMwfu81o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OyApzCQM; arc=fail smtp.client-ip=40.93.200.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wklBqFYo0lO92/UqxRhG/9cgIsVlq7jcAY3aPr87/rGrOtez7P6F0bxMawdnP7iFBL72ze4NJsohGKYprLoC/7ASdWeS0W8gCztM8067IAXz5CNHr3sDgvwjYsHzUNF84UwT7NaxKERJWQWoVE/UEnqQsXQ+ah5Y8lerxk2pmeM2coAOD8Wn5FYq1vxg6f3WXLWaQUdfcu6RivATaEM13W2Dv5AAEZsOLeqieZ+TrUr2vlfn2JOny4a0Mhw4lyXGHWNyiJsJnNfS59AB1P6DcBLx+x/+CPqrYMvrYhOgSc8/3Eb3jMib9xpN0DOu8uh5K4zA4CnProsflOfK4ECsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeBb9xk0ij3o8CMYHHIEl5SYq1AH0btol0z5jVqa9hk=;
 b=vViBiqR0e8w2yOR80Rs1xNlFydWn9HlmQOCpGCPwZ4qzEiWp/Bb1AkUfBhAdkT6lAQPuYQq+VJ6pcqBXu6+VoRMcjNJvFShTNBksMTXGCVMlWLO/uWQ9a4hpTA+mbFDJMeXC5N42ffRJgLDvmfgfR1HkEJJURjXPpw8iV11VQ6yNF2BSyVnk7dhjnDjEI5IX7GSUPoulZrQtSjuK1MYFnDXuFv4MLqCyUpkpxWG9dZoVeRGWN5vwi7AsW5m73tGLOw6PEfVxUwQ17AofEzpcJbpwgAYKmwUVuIFASIpWorUbmW5tE2Llb477wixx5RIenCk2cz9mQzQl5LtFlVGk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeBb9xk0ij3o8CMYHHIEl5SYq1AH0btol0z5jVqa9hk=;
 b=OyApzCQMoXOh03luVF5hQ437SeIa4xmGQrV9hYPORRHTD43PmtOyTLgmxzkxlwFhfMe3WAaKpGUij7DDJPChN/RC9t+UZIwBhZ2WrtxL89rDFywSoUIHZLVkgT6tD65SUDYA8FpiOKayjmSVXWqH38xQLY/2ZUqNygVJO+x2OPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6436.prod.exchangelabs.com (2603:10b6:303:64::21) by
 DS1PR01MB9086.prod.exchangelabs.com (2603:10b6:8:221::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Wed, 27 Nov 2024 05:56:57 +0000
Received: from MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970]) by MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 05:56:57 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	cl@linux.com,
	christian.loehle@arm.com,
	vineethr@linux.ibm.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH v2 2/3] sched/fair: Fix panic if pick_eevdf() returns NULL
Date: Wed, 27 Nov 2024 05:56:09 +0000
Message-Id: <20241127055610.7076-3-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127055610.7076-1-adamli@os.amperecomputing.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To MW4PR01MB6436.prod.exchangelabs.com (2603:10b6:303:64::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6436:EE_|DS1PR01MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd51121-3bfa-47d8-dc5a-08dd0ea84d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpTNU0jFYhDVY12LCouHk0NbJFRZWgPdbjXeH8pjixIhok0bvzsxHnq/MfYh?=
 =?us-ascii?Q?HtqIs/czpzoiek/Gf5Xj4TxWs5XoEWKZPqGd1/XdnRj70timt1bh8FZ76urp?=
 =?us-ascii?Q?Taq5y68saYDPq2zK9dhfk9ulhHvy2Bo9v3GZmOfu7S3Vs5HhxER8etrkJAwz?=
 =?us-ascii?Q?fvfrnUtaa/wr5nhT6D8o4q1PzixoPJATh7zHunPROFY9fUiZwqxHGtdyzw4S?=
 =?us-ascii?Q?kMOiKJfrE0FL5kNmMJ5SEobMArMvztLFW36t12zVxHgvbd5zX8xm4Hnn9MEB?=
 =?us-ascii?Q?A08l69vXyRT6CCy7EAGvuMpd9BIgrwrbiwETYrQufoXd/G1u7Egpsw01GGmH?=
 =?us-ascii?Q?VgV6BHYccRrfG68zW+dFMpVxuVC9CtNcCyflvV4RPa4ZMGjWJELD3VMxf1I5?=
 =?us-ascii?Q?YAvGZQ0FP4AdO/ln5yPMOw8yIm9X0Ik9sjsN/OiCe46ODNDj5ai+nxcwXHZB?=
 =?us-ascii?Q?u6mc5wtyMS9/ZEI1WCt3XZGQ07HQn2Du5k5DqexxZG/DqHPg8Xb5ckolSMhu?=
 =?us-ascii?Q?UPlJCq6Rs/mdDmD+0Bq8k4Q+qLJLEUTe/1H6rvXhTopZUpc0+9sj317dM1Jo?=
 =?us-ascii?Q?v/Pc1eUSYkVtmnl27lCswhjV4L6f6L2eCZILC1TJKVPIARyjuupy7gW02Ou9?=
 =?us-ascii?Q?UFIFXLCS2/molZKO7LNBpXmXFVdfxZYCCwgkdAtX5dNaw120cmP1Dq6S9MML?=
 =?us-ascii?Q?gRaGzWoch+4IsfmEFE7k3BHn18C/XpzsRxopxIbRzy/vxl5RMrJ5IwEKVnBX?=
 =?us-ascii?Q?TYjdGRpaVTXtbhI8fw9ydY6liOm2Y6q1wJvq48bRDH9VMnX2JGmqGQlFOMg4?=
 =?us-ascii?Q?iTPk1sH4+/rAKudGzomNjQzHQHzZn5x/sWUQAkT3McnagLM6oVsA5jA174D5?=
 =?us-ascii?Q?YJ6+WelV0H7Le+H7/IEfQOopoBZaCIx0pa49v4hKMXCs1+js2fDOMJGoPWSA?=
 =?us-ascii?Q?aEoAu8p9KIc8xpr9Bm/a2yUpVD6vUU450C3WbINEANSW2tfetsU4o4gK3DTz?=
 =?us-ascii?Q?LvLhNnDduhAgX7T7Hv5TR81MzMDCAG04zJRvlggMJif0lgnsD3kQNz1NjbuE?=
 =?us-ascii?Q?ifCdJxcFZRs4b4Mi/yQuMYhuLUpES0aaY6DSpPAicASSl/zc+eB9/0bLRchg?=
 =?us-ascii?Q?e86VT3V01NItvM9AkH+2OMEzHhqthSQ5t4vJad+UQfVopjdREMfIlSga06N9?=
 =?us-ascii?Q?TVFhYITpbUol9ecv0Al9XSq6LWSLiZpDI2aNYSsABsmsm6ghJiXuIKrTAceM?=
 =?us-ascii?Q?xpsJNErItIDuNdRs0Q74tZHpP8KkLyeMKIaVj9owrTwhIP/Hb/4rWVtsK32T?=
 =?us-ascii?Q?SBv3vILyk8wXe0EGLNiGKms3n/Ap5jmWJaNy6WcNf0NhVx9QfRE77kqgcgIO?=
 =?us-ascii?Q?I4ztoi1vBItjJFEtPfU0lS7iNzzCoh/ZyC1iT0FRYEe/xVt2lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6436.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGQh3gHVhN9HqJ16bGN+L7OnLk/L8UFeCD/WIX+t4jWibk2Jx8mt6+eNBvIl?=
 =?us-ascii?Q?5goT/AuMmPP86MdR0OIUs23hpKXWyRlrKbKZEGxZM6v8l/13BZNRiAva9z0t?=
 =?us-ascii?Q?DwNnnvOai06xTXqJZQ/iMGZOk1UZ/9ZFXqttttrsSEV5h48PGhdLbt+btvie?=
 =?us-ascii?Q?Cea0uLh9uFSfrZMdq4FtMJNI/q0LrFz9s07idfDPazL5fwstukRRb25scqJG?=
 =?us-ascii?Q?T8bBBhHz+zevS34+8XZnVIe/SRzUHxaN1fIY2CEc6peGY5JgVe4G20WFe17Z?=
 =?us-ascii?Q?zcbCD2lAJ5LUMNBYrxs/ORK/BOe/EXJoZVQLeH07JT+aiAq4FKRF7MxzJ+aH?=
 =?us-ascii?Q?YXV+QqMAA7n0kI1MaZRsCINKtHEbruC3iPrIVLXusM8AH9Ub2YNfreKSF/aq?=
 =?us-ascii?Q?k2AkkDpDxMvY+nGeYvixFfVBZ/vd8QARLNUB13XbM45Kk8T565PJLLSBRjTS?=
 =?us-ascii?Q?gexPzs/RlqUNC3YTYuEgFeoMSJsqXweryaQeRFQMdUZsUADOJWyuunKurlgi?=
 =?us-ascii?Q?V8dLv5DI5sYgMLpiN3wCxp5hRg2Muus15Jf44h54ZTZr1+Kjn3LoCMCMtYuF?=
 =?us-ascii?Q?U7iqr1YYaS6NhrZpSZViigSVNaeYbhwMbj5qHUmmH6EpU/BBJs2J/mH6sbhl?=
 =?us-ascii?Q?7ITGT0zervYUoUwJ9MDtUiKoOQl8nRO6DwTN9lOCHOMa2hoa09afV5kr7gel?=
 =?us-ascii?Q?WkZsVHWUGI+n0xX80tDw6iKnWu4DVVLwKcLj09I7vUxlz4CfVb/Ko7cCLP+A?=
 =?us-ascii?Q?HL0GwfRyRfNnzffaIO2t8y+OB71CAisIFyut2r2pE44mNCuHA+9Jgw2F3J4G?=
 =?us-ascii?Q?3qctMa3UNsi2oiZoTOGtqJtY+4jK68foZevQPYD39Vtf23dUijDW8IO3sAZc?=
 =?us-ascii?Q?vLNv8jtw8Ivah8jzLTAIh37nhEyibKRIStklrqDiLpsYN9Z0N8EjsaMftjbb?=
 =?us-ascii?Q?y/ZEh3FTBwEAKuuxHRWiU17+TnCM368hwLTRsXJUVuBYWnX5XxnxhnerZNr4?=
 =?us-ascii?Q?L9Plt70uLMHYKuEqkhKQIwjZKWkAaW+erHodDU9Bp6i0CDcMpxGOxFTJZNtY?=
 =?us-ascii?Q?nAP/JV2WttOsz68sUdkOyp3RjCz3jCpXY1DoXPc3zSdHSAQpJM1XWA490bem?=
 =?us-ascii?Q?nTzwJPTwjF/pwz3IqatWPU5R6JFcWZWmXBmZqyQjsTemNsTuWrGuNN/hYM73?=
 =?us-ascii?Q?MpyIBb4C0stoYG7j2+xC0VwzZPA8OufWYPm5o+rC4e4euWZ7gYHDMvNCC5MQ?=
 =?us-ascii?Q?23u6QMRQSX71XZkPAx4hpdZBH+iM3aEZ/TiUbaU4UZWGFZ9fXSlFH1PNufwV?=
 =?us-ascii?Q?fBwlKVHpYlzhCuROU/3rE02+6UrkKqAcFs8PuE3BEHKIrWp+qQONPXS4/7az?=
 =?us-ascii?Q?ic3u5XR1St4P0Evpob41fHvizZs566jxYCvjH2lsEGhoYQ7MMVZzeJhpxcYr?=
 =?us-ascii?Q?ug78CTJcFpyqzvR2GqeV9qYXlt1Nj1Q7FO7qrEBKnV9/BWoV+o/hp2RSyjyD?=
 =?us-ascii?Q?GeSMlYwJMgzIPjadU4cC9Cqk4qqQcxfg6jRkUnUuC0Rt1ptkGCfOZya2VZJI?=
 =?us-ascii?Q?w/hLOxt7V/qng2FRmtw5crmietLju1zHc80HGd1Y7jH4ABNmMJMRaAsKyhUF?=
 =?us-ascii?Q?ysFstKEwYKFTtQd27Ntxbu8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd51121-3bfa-47d8-dc5a-08dd0ea84d80
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6436.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:56:57.7284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6GV2mMXi1TBQYQtTLcJgYLbpYGxwvBD3GKVeZV3GJcqtKkZvNLH1ViTa0NWcVxlZXZB0ucdW5kIAXfvXk4LnVxawKOaDfLzNZJEL/qeacgly0+g0TZtIFXK3j0gyoKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9086

pick_eevdf() may return NULL, which triggers NULL pointer
dereference at pick_next_entity():
	struct sched_entity *se = pick_eevdf(cfs_rq);
	if (se->sched_delayed)

    [  297.371198] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000051
    [  297.406112] CPU: 116 UID: 0 PID: 10328 Comm: Grizzly-worker( Tainted: G        W   E      6.12.0.adam+ #1
    [  297.597362] Call trace:
    [  297.599795]  pick_task_fair+0x50/0x150 (P)
    [  297.603879]  pick_task_fair+0x50/0x150 (L)
    [  297.607963]  pick_next_task_fair+0x30/0x3c0
    [  297.612134]  __pick_next_task+0x4c/0x220
    [  297.616045]  pick_next_task+0x44/0x980
    [  297.619782]  __schedule+0x3d0/0x628
    [  297.623259]  do_task_dead+0x50/0x60
    [  297.626736]  do_exit+0x28c/0x410
    [  297.629955]  do_group_exit+0x3c/0xa0
    [  297.633518]  get_signal+0x8c4/0x8d0
    [  297.636996]  do_signal+0x9c/0x270
    [  297.640299]  do_notify_resume+0xe0/0x198
    [  297.644212]  el0_svc+0xf4/0x170
    [  297.647342]  el0t_64_sync_handler+0x10c/0x138
    [  297.651687]  el0t_64_sync+0x1ac/0x1b0
    [  297.655339] Code: d503201f 1400002a aa1403e0 97ffda0b (39414401)
    [  297.661439] ---[ end trace 0000000000000000 ]---
    [  297.726593] Kernel panic - not syncing: Oops: Fatal exception

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd1188b7f3df..d5a3b5589e4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5623,7 +5623,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	}
 
 	struct sched_entity *se = pick_eevdf(cfs_rq);
-	if (se->sched_delayed) {
+	if (se && se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
 		 * Must not reference @se again, see __block_task().
-- 
2.25.1


