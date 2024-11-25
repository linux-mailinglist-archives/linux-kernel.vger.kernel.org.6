Return-Path: <linux-kernel+bounces-420399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7D9D79FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C119DB21BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23988D268;
	Mon, 25 Nov 2024 02:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Vwy3l3M4"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2133.outbound.protection.outlook.com [40.107.102.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6882DDBE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500819; cv=fail; b=OHZ7y8jtJbvNUTNWsLnoOvvflYzAmsGZ4R43nnWJZMbRvgmHGsQiCF3mlOZ0mEIwcNNKQ3mvcFgOX+C/OSN8FcZhooG9tTZYe9wM34jDmjEGpRFI2l50V0eBDOT4BpLuvn7mH/6UbcOAYA4JnIR/OHA7QT0HTeHCzTqZrSMCsWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500819; c=relaxed/simple;
	bh=4IkzZZQRPFTtCka+KyRI8Rbn1SEjRdByqSFcD/p/Huw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Noq2AxzDhVajSCMpvnN/uNnD9NGxJcNNxady1Z4KQaP+KsNJxE26qyatuSJyirnWURd37KSNk6Ib8ulaFFT6v3uGv0eH5HQYC7Ftso2Tmzrl5rcKmoTL+Jb9DYhQTpjgVay9NkA8gVU6iIKDNB0ycmrauH6m6F8Ma8Po5DDPEts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Vwy3l3M4; arc=fail smtp.client-ip=40.107.102.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyZuzCtFSfDPPLdlbBwZdj//eG6hi3Kb1yWjCUIXrntNbdiJZfRKCi5z1O1sq1hvE/SaXguci/1/CRIMyrTuJTa9XK8OKdOkQPGn+i+Rh9/kJsAUr0syG6oux0EdAqRfzDozNIQw1ak6lKh7EUltd3H/CRFaglK8zBBZUIWYW15iFuw17D90IPADTCCW1tkTRsXdNu3V3oRqcGouPpIDcE+pxe6ypOwfIHASZmRgA/Xf5G2E4APCp5bsfcxhzhwbyUTn395RMasH+2Zh5pExZKEX/jgrFUC8vFequG4bcOJfNd/NIKe9sz1s8CBP/SzDp0s5hccirwZICjOirKAo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+ET+gqDAvHNmgaheucYXCBqddo4yWvKz2l2IgTm90s=;
 b=x6bof8S7r44p5NZGE5bRvy/8e0BHGeZN3J8/8n1IT9evjrpGHix3mpb9F2PLLJpwVTP9SZGqh7nnPlA0an08L3aUT6QTHGS5MawGPkro3PJ+Z2eVurvI2CACMRcF79TsE/mWLrqXQEJhlbR6wnm8inhqeGC79+w028jZWXji4GXIJNAfeZvKbHZ6aJPgfc3WhWhL72WoNFUYup1e4qK2kkugePYDUrEAMUQLB5d1A0DbhWMlYILOs8ogKcfsRmVdko9Zub8hXh+iWnK5BlWiid8PkV7VRlHprFsbx6wBkBV91I1bPRZLy7RiqHV1j9WsSieMr/ijh/CXDUx/Yh8Yow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+ET+gqDAvHNmgaheucYXCBqddo4yWvKz2l2IgTm90s=;
 b=Vwy3l3M40DTVDp+iDivTn1dIO38/u2n6h1q3RV6K0sdZyK2XP+ZhitpL40cJ3kzfx8S79wYsvneNWKEEz7GqzvD8dIQwEAWGEENSbO00dhKYGgEmJ9BViBl4yA4+swjVy+Q6yH73/6W1zy8SEYlXXkULAXl1mb50Td0MAEofhxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 CH5PR01MB9077.prod.exchangelabs.com (2603:10b6:610:215::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.11; Mon, 25 Nov 2024 02:13:32 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8207.010; Mon, 25 Nov 2024
 02:13:31 +0000
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
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH 1/2] sched/fair: Fix panic if NEXT_BUDDY enabled
Date: Mon, 25 Nov 2024 02:12:20 +0000
Message-Id: <20241125021222.356881-2-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125021222.356881-1-adamli@os.amperecomputing.com>
References: <20241125021222.356881-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::16) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|CH5PR01MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 2434878d-6853-480d-5d1b-08dd0cf6c1fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2tsVe2cDpbD32XpH7XTlfIIMZnAVOScbu30qWj30NPYoGYcI6dEv73HgGGEu?=
 =?us-ascii?Q?jG39n9qKE9HRt7//cu8LY0KhvdFORGnh4hz26mrBVP9ESSRjjI1zvyaoUfc3?=
 =?us-ascii?Q?7E3rTBS//tJ3UyyzYR5YHH9i0hH+9wjvUx6eIub3wpqDpN393tPGtu+CbxPd?=
 =?us-ascii?Q?vcf8YcbChMJKgq/ll+IrdmvwkA6EqwijR4g638Ja7PJ/fF9SjY/tNTjNUbCL?=
 =?us-ascii?Q?6FLa5PvcTB094Vix+OOHf9YeH+ZmsdsidZWvntMvPY6tQ+lxQUZ5ocnj2oEW?=
 =?us-ascii?Q?SKMf6amlxuHwPcUpu56hEuntxPKcPmwsI9+JRppJKZpSSPDiXVxj8AA5Ry0z?=
 =?us-ascii?Q?t6NiDX+7csPo82oSkAbA+nu7DalvWArXj8sY9B4aLzZi6bCFxDt/O3Kz1O5p?=
 =?us-ascii?Q?POTRrw3gCp4OggAztIlGa77j2x+hJ82jpkbWyiRWbJLHui6kX5JrgUV6XSVu?=
 =?us-ascii?Q?pY57ktgUrsYcPnLisTl7tc+LGbPi5feZ8cb+UNPfNPgimxM7MTIc6NDOJ4kk?=
 =?us-ascii?Q?vCzyx3lkdEsPZ+SLwKG7REde49p40mqNVhkvB2OOafkvHN53UIIo1xMBfTHL?=
 =?us-ascii?Q?qdjF7fVEpwOGS0xhtQaoO+Be6LxNwemzX905I/Z/pY1HIlarwf5vbbipBjUS?=
 =?us-ascii?Q?rUqArMP2yc++kKUyMRObVMMyL1ZOZHWxfWbJHdb6b3a9mVfz6Dc7DBnny0Mn?=
 =?us-ascii?Q?6uSxe4yi08gG9FNJ3Rt5SzLBm6+r6yvSpL0/AsSjM5Na8cMl+z+V2q1PGTUb?=
 =?us-ascii?Q?yOVSc6LyWkLx/ake6PDFyD2l2IzobWfKaf6UhXvvV7qb4jXwsVoPcGkQKQr+?=
 =?us-ascii?Q?Ph/pduw/R9U+b/Lj5aTI+FFlWz+KvB7hUDlMYCUKEFcpaYLJbWIzEFtW/d8g?=
 =?us-ascii?Q?LBMgfJUMf+5eiqC3V+lScnP1bgPvDpIoPF6x+lzmJIe2M4X1b/9W/2OzK3zB?=
 =?us-ascii?Q?t/dY6ZdqL2vWA+Vf2G0crsasxDFZI4wfJCquDK0ICkF48MDxUps8eu+cv0vG?=
 =?us-ascii?Q?wdTFlrxlm8YcDJ5B1h7UgsbRAYvdOdo6OcVDoY32yMOFdfD4MJcZiBu2JYwx?=
 =?us-ascii?Q?YfxtbVw6w5TavLFqKxBdQ986W7eQJGZp+52Drr/wJHMISF2tgtP8voWDyrA+?=
 =?us-ascii?Q?kVmbZen5GYE2mtXsE+DPOppVJJnmYYs+lmDA7Pbc3h/Cdpg0JFWe/KKYMCs+?=
 =?us-ascii?Q?9R9YcgaKoFLDUM0e3ueDh1NUQtMSQ2h2ZqZFqiow40bx179+0DFYvkj4Ri/o?=
 =?us-ascii?Q?XCnFuhMGyfDrddVknBMiFCK/EurhSCJ9bVFGW6U7TVCkYVqFHxAn93v6aAmV?=
 =?us-ascii?Q?I7NPL5zTQEN2fBVBmRlH9LRaJ14Hr3Ost8aOwF9YdNENpW4jXY1OXIpQAQWU?=
 =?us-ascii?Q?BxKdRQdr4qpkHVNme6gUwA7fDQgxwKiIEywuZyJ5AdpMXgceeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CtCBaQh9O43lhDJCyj09ueaC0aKtMPzMnV2LNiR5fX7EzRg7b7vU18UJSG+C?=
 =?us-ascii?Q?mhXn7WECYAL6RL+xUU0niAJk3FtG8yTOGJBZTmi8lII4M0KRE+74SMezXhhX?=
 =?us-ascii?Q?9m/qnSADCxyGwloagLYWzgqx6uJp1D+MsPWaJOo5In+cCFOPVzY8IjSdjpB2?=
 =?us-ascii?Q?/bOZdhdzp7eyVqt+SmyaXpOOlzYonY4E3EToDaCjrwU7AfEHq1lTwwey5zuo?=
 =?us-ascii?Q?eapx9nK+mmSMphVRIb6+X8twpaVR/KUVt3qwtEbEVzuvAQOJ4u4/vG4CnXtn?=
 =?us-ascii?Q?VfsqvtH7omJheplUZbjdWCCggyQrbOM/rrLMCCvJhcY2/PzDW2NhbJ4sSYzj?=
 =?us-ascii?Q?j1qnDN6aaYJ2VKMJvIICenciC+zJCc4nDElOXVzphgjzsZarPwtiKKXGQDtD?=
 =?us-ascii?Q?t2cUe/wlr0iSixAjJIeNA/ws3HXwpntiM6ag4xeMLGb58ukGdkwVSypJEQzu?=
 =?us-ascii?Q?w/mQmiwsRyfQHhaAV5HQIpfEXrYpPNCKh/WgbsBQFTxR5fTEVkXORqYdvqPS?=
 =?us-ascii?Q?8Yux4ytZQsEsg3pcCR8s6W+78OdO5kUaL8oAddeWExaga6rxqpj8V+1pvf92?=
 =?us-ascii?Q?Ti+m2nfeh4cHS35mQLVKFYi4eFMHpJ/ImAVMMcj2lG4lIkxFsuvV0dTSz5o8?=
 =?us-ascii?Q?Mlt8ERa9V5NjDpvux+iqOgVtudSRXIkHRgfq+rbdA7/iSNkBWiYzO0x26skc?=
 =?us-ascii?Q?EkB5WkiCzAVdzdQqCJ9bJBTvO9hGsr7dHDi5WKumLVk+SjjLewdbIPMJyXpa?=
 =?us-ascii?Q?31cvoD5i7y3c1of2yZ2dtA4LmK2qokp5a/NY74IZLd8yowCC1QYs2ujgyxOz?=
 =?us-ascii?Q?z4qnBCvZNmazqLpjdWafITyNwEMOzIanBsqIvj0oj55vj1MnaifwhHme5iOo?=
 =?us-ascii?Q?G77DS8R3T8XUYmhww9t9QKvTxYDzZs8pFrZfk+jAi7OC2MLeKqWZi9kjcblt?=
 =?us-ascii?Q?MgMrH0MXxxCdBMVjUbEQEe+Uc4+IhwiYnU6W84E4aNHylUSPPhxLbq+4LkWd?=
 =?us-ascii?Q?7+AjF1Mc+FJVPt4qDTNWAlP7c8gFgXjhfJ+0DHIWsfZGQCCXmQfy9xkkbyoo?=
 =?us-ascii?Q?caEW+6gnW8mTRYd4Qzph9p1BOwyJGcxepnKmHbZYiI/NStXydZdFU328Q4MC?=
 =?us-ascii?Q?veti9/sp3KynNVk4lLtIXzBXyehYTHRsvI1jwHFCYMBtkkYRcpGZ2gMgCkZa?=
 =?us-ascii?Q?2RUhoi+IheZw3OUPQTQ9IDubgh7CiyfSx9gxekojyg+A88MiXTWYbU48a74u?=
 =?us-ascii?Q?WZACB+9ugoxoze/+RTb1csgu43iTQue2BAFkNzwUqJCs75BVMf8V/HLhsmyg?=
 =?us-ascii?Q?psV1fFCgdTCj089lXABUrAiSDt4G9NNibRuqPkAFiKOWDvyPzGW2yarIL0f5?=
 =?us-ascii?Q?uNJ+3pa9vuRDK14IHmwnRT5dtQp5OgnRSMPVMX6mVSmH9bAiHIhp/9KnqmO3?=
 =?us-ascii?Q?iY3VX4zEsSfw6kVTxlv+BOy8ItR9JPaT6o+4SlL1N3+Bhn4oB3HFRsnICy8X?=
 =?us-ascii?Q?S8vA9tm7BWZDpX+UaWuaGnYtpOILypfeHs0hUdI8qj5k75ybw4Sawv4Wchjq?=
 =?us-ascii?Q?iPLV7QvBCmAk2WucUAbz04RNEJXDFJ+K/13Zv39me/eYvaVv0fp2z2a6EAxe?=
 =?us-ascii?Q?hHqSfau8mDsBDy8AFxXzf7s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2434878d-6853-480d-5d1b-08dd0cf6c1fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 02:13:31.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lX8WuTCHDv8nzn1/KnGySJSCQtwUy94FyqUBuuyNPUsc1syaNwBj5XwbPB2J/UCkXu4vQbWT4HtSNRx3+Pni+zf+mxnMxXISYkdJw/Awie4O9ed9Hknd5Bdph6yeP2F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9077

Enabling NEXT_BUDDY may trigger warning and kernel panic:

[  124.977300] cfs_rq->next->sched_delayed
[  124.977310] WARNING: CPU: 51 PID: 2150 at kernel/sched/fair.c:5621 pick_task_fair+0x130/0x150
<snip>
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

Do not set next buddy if sched_delayed is set.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..cd1188b7f3df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
 			return;
 		if (se_is_idle(se))
 			return;
+		if (se->sched_delayed)
+			return;
 		cfs_rq_of(se)->next = se;
 	}
 }
-- 
2.25.1


