Return-Path: <linux-kernel+bounces-420398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C428D9D79FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0748B218F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537CDDBE;
	Mon, 25 Nov 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JYvl51x6"
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023073.outbound.protection.outlook.com [52.101.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BDD4A2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732500804; cv=fail; b=D3mdpI394INS+Z+7ZejkzWuMjahOHeUQvzZGCUlfKYKaNi0t7gkuCukd8axQyBh0ox0dxk/WJNilHqQnwYIP/Pp2BYKZ6BX0zsBw/pIKTR22pybOXwaQ4V4T4K5cftxYPExdTymXw14mA7VrHs556Tk2jr6WUySVv4pw1BxwlgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732500804; c=relaxed/simple;
	bh=4fBJTsOjneSk5bpWYyB4y/Ch8b/1QRVNJL5IFkDJ/d0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Cv+6VHOiFUKmlaoGtgTGzVOalTMno9SFQppUZtA6gUTTuHowYrA0/Yam4J5f3VBL+lFUyhx+R81+1wnbuWwK+iNB+eI7bjww/frxVOkw5FolIcxTnPCKMNYwI58MlHAhvuhtP15KtYvxqFswNHlfW7LZN4m6bqXy6MySLcrR/og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JYvl51x6; arc=fail smtp.client-ip=52.101.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLD82DW/EBFY89ETu0xh6GOnBTKkj/gkMBO+GI1CJwfnXOxsiPTnWYHnv7U7N/hdXKBmTUKFr/JvaHykpyYvkSufneYhuGLbpwb/U0trn4mpXVI9U0V224PlnnZY5zUtichdK45xBr02yT1orARR4sKwdq64YlNji/7fx8KbyjIrbAaDTiQg87+EhKRhk4kYh1ps4XSSf6+IqxaYNPvwhyF5pbjeCYjooDi6pNVTsgYIHMQnuR6s6uFCGT2+lDfsU8c4GQaq/IKvPl7LzGc4qvWTwfGInD2eA2VEcoxmYnPZafiBgUjv9slhc1qBMdI4OLXDy8wGKBcPLiaIOsYUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBiVZl4Rox6GfSJct5lP9RcV35SmkudlRqkzrXXMHcs=;
 b=qtUeBbSX4GAI1pPqnbWyXJIrpE9GO2CHrlYEBF4x1OX5mzxPddmRGVJHPZeC34usvLIrmDYFE0iTe+WJuV0mcd+4rlMdiSidW+Ghj4JMHcOQD1fg8ufSM0xHtQD6u3rEFlfnAEf9u/5gVebiwLoSQEu32+TBG4OfYtTkEP/YMO2OJNLNuJk+iF+6jKNSgHr/UuIemN0AG+c4zQFBR33ub1nyD3PlYsLjYdWZbaF6TtpR5y3R8qW8Ji11n4IApQNzlHeYFHG/HG63+bCOp8phzUR1GJrPEs/Sv/OevE27HUsoz8LATVoTIhz5vLhKHkTfBl1QtCUPlAq0PA2AFYRvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBiVZl4Rox6GfSJct5lP9RcV35SmkudlRqkzrXXMHcs=;
 b=JYvl51x6UTUa0GFKind7DsNdUSgSVrTgvAFXQ3k8aNSv8gEsLsYVXUWGieP1pF1Ew/HslSpdGSMbZyLIp5EUOwgVspfm09fHxea1mkOpMZQt/gNwUOlW5qufDjnEWKx5ZFbTIg5r4ZjVVUtP10s6B6t/bpvHO5cqUvS6J+qUOp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6445.prod.exchangelabs.com (2603:10b6:a03:2a1::14) by
 CH0PR01MB6921.prod.exchangelabs.com (2603:10b6:610:102::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.9; Mon, 25 Nov 2024 02:13:16 +0000
Received: from SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119]) by SJ0PR01MB6445.prod.exchangelabs.com
 ([fe80::223:9849:bfff:b119%5]) with mapi id 15.20.8207.010; Mon, 25 Nov 2024
 02:13:15 +0000
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
Subject: [PATCH 0/2] sched/fair: Fix NEXT_BUDDY panic and clean up comments
Date: Mon, 25 Nov 2024 02:12:19 +0000
Message-Id: <20241125021222.356881-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::18) To SJ0PR01MB6445.prod.exchangelabs.com
 (2603:10b6:a03:2a1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6445:EE_|CH0PR01MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: c12aafca-7958-4fcf-02de-08dd0cf6b871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEfA0ght+lCrqnxA2rAjoOOHBRFaQw9N2/Rn13x9mHGA+kLjmqDwLSi1iaxp?=
 =?us-ascii?Q?GYaOEa3JUItLn4apqRgFOdfgs1VTpncfc/7gzGG12SVwqu0Qq46kXTTMun73?=
 =?us-ascii?Q?gkP9Hb0WF/hkMfPBIsUKtU8Sf60cpA2oo+Ee97HxN5OCS5vB9XKptPOVPXYv?=
 =?us-ascii?Q?hvzO6+g9xoKtuBCrnJjtV+WuZcaGmglff6xxWCzAfOmZfY4rEqNyI9QqwYK5?=
 =?us-ascii?Q?5rlZfSfGHE3sogzYZb4LL0FzTKGoU/gzGcOsCdYqdEXrEcFzsHcRGy3gYhyK?=
 =?us-ascii?Q?xb23JGirVXjKpBDe51huG+SKFVQpkNlLO8YOVKv+zfjMzvwQd3Nm0p7T8po6?=
 =?us-ascii?Q?NGZlBHBzFtdq8rymUNC2NzZvWXfuVuHMGjhgKqwbTWSuu0Ke8ymw2v5B6aeZ?=
 =?us-ascii?Q?z9p/I0DuTqCPmyYWGISr9POYHl/vMHMHWKNQ3f0n8qlwF0zIF8kd2FAWmCHK?=
 =?us-ascii?Q?ZIyM9CcpoLBeak1YkKVnnUXu/h8W4lg4PHWCC7ze9mVVZcNqHKmOdFRkXahx?=
 =?us-ascii?Q?UMsbozZ3rSzYDoRexZu7Jw7UcmKY9QERxgtTzWDmfnLx/9N9cDKd2k6US91l?=
 =?us-ascii?Q?8zKwAwPpl6Q3pQtACpF10/7ipxismbKOYmwVWQJUhPb69yPL5cfOVAjb+qUa?=
 =?us-ascii?Q?t6Ef67mLBK4/mrreiBQicRW0gMk+0XCMfCI5dq0zcADmdRLy4JbcqLEaFf+T?=
 =?us-ascii?Q?A4HoBAbv8AdyaCEJDkLcE5r4SsQQQQ31ihlouHus737BnVlAmUr5NHzxRhOD?=
 =?us-ascii?Q?DXhGMj0ZYViW96XI58/KroD5MNOv9MXfoGr1ND2DBYV1w7Vo+uZbPh/hx7LV?=
 =?us-ascii?Q?ryka9DgTyYBYeqSRTt0dVhrxDk/N24AgtIl3ByCz5oJQTG/XDk8FB/Red4D5?=
 =?us-ascii?Q?8Ju7MK+z0zK1dO8BZ/Vzp37zJOY58t/7qlaelt6yE9bv2/r/UMOnaer8tnsu?=
 =?us-ascii?Q?9U9orqFqwI/Khg2zxWao3QHsM8AtcRv21naJgz7DulzLmqV9xwQIGlXrbBgU?=
 =?us-ascii?Q?CKBrHRnLqMzUD//vmbT4cowQ1YuLCNqKz3YqYQ6q3c9yF77+hGGBBz9QNa0k?=
 =?us-ascii?Q?Jx84m11osFeAAjp2zK7S/6mEqZo43mw0GZ88iR6nluafoLN0G6CDqX8K4k3K?=
 =?us-ascii?Q?TOLXa6Y2CZxYP5t4q7MlUxwU0unoW3s6Idl8iQLphopoxHzT67vjWdi2dpaE?=
 =?us-ascii?Q?EBbpsTQuV9ICMQLlLvLRaghTm25X4wchsXFvqzU+GBp5zAwpgeyNM4Ix9YTZ?=
 =?us-ascii?Q?OmQDVNWBuLZGeQdtLrHhHx00BMQFvnNaERbVjmbi+Cjhh5UpDEWjy32C7+1F?=
 =?us-ascii?Q?mofdKfvAid9lUK2KzwzsBSlX1ZJ2CKGh0buQ5W9/SoD+fsqQ3drSv4waULB0?=
 =?us-ascii?Q?bVCFXNnmh0DFcujngfRRzQaW5gyhxq7DMAwF6XKmdf4SQkn+CQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsEhNR85Y/bWdZXGWCbaDHxhf6sNLr8nQNc/TcsEk2qFFfpF9bZ+cbrAmvvf?=
 =?us-ascii?Q?7It+jFllMBE99QdHfDBL2MfGkxVHGrrsKcfHKZGoWIVQSzmLujJS3jHrY911?=
 =?us-ascii?Q?ahCJ8Yxw1UWgKtsdKmvlVoUwypj8xhBob650py9IWjb46avMeBFZkeTcdtut?=
 =?us-ascii?Q?Pxxq0x1sNtPX7suE727J0fWRPbnwr8pHqNngXSXcjyny5Q051hshgRvyHzSI?=
 =?us-ascii?Q?IEaUjijQNCcdHXw1FcEslODt+VpdwixMwrTftolaXIyXuv5tF0CQqoiaYXTd?=
 =?us-ascii?Q?XYHEUxcdoFA2ChICgY18+E6NL3jKCvGsodERIEkbOJ0bptWjzed5qUB2B5AO?=
 =?us-ascii?Q?vMCNaPZKh4hkM4UOMscbSJzG/0EW4TLxpVVrFwX29KW+ec/Ci1+s4kDVu0uI?=
 =?us-ascii?Q?UJF7uhIw8UlTfzVPC6cnHjg99LETGIo/2ncT2klP17GUIIZlk/a8Ds7+KhPz?=
 =?us-ascii?Q?3FYEZG3iwKtSdE7uWtINwdBrGW5PJkNYSKBLR/wOZEeTeQheqjrxkzSzGLje?=
 =?us-ascii?Q?3szyaluKNq/65ENQqKGRmzwqdFnTDDFLDIt/DVRqpkARsPolKiGvoazMfU0q?=
 =?us-ascii?Q?nZD0vdSsU9+kyxM8tAp5iSNciutYj3kfMtTqJTOwDpGfSFxwobG7KA4ZqbNc?=
 =?us-ascii?Q?38mcc+MjFgrhAPtK26xLK+khs6/9fb6iqAy18nQx+CMuzOzPFtZPD0bO0vPA?=
 =?us-ascii?Q?mR0Y0Wp4L/n0VPHwyZj0SaMYSaoTdMnR3QjZsfiMe/4rx17w+a/lf+B3pv+r?=
 =?us-ascii?Q?zbbsWUwfzGtRLm3r+7AadylyZ7kR4SkAUZb0Ui7n1hU7pRgkB8ZizKuiLtHZ?=
 =?us-ascii?Q?bjX3xCwsPhs3jDhBOq4WBaVJa/dsD1nCv9izvKZEbW+PTjm7i8U4WMhlFeDH?=
 =?us-ascii?Q?UzZwkQ7xlijqe22CONU5TDcygrSAjVsmHyRsuUiHnDlzwVx4WP3ALYhTvB0t?=
 =?us-ascii?Q?sOMN4cyRY5RqH77n30UTl20+hk2Q2hKwX+SL0+jHci3jI1HtAZudv93RlqwG?=
 =?us-ascii?Q?gHEvl4LKXPCw7/pEILH/795pB4YlydkE7OESqajvNpFSinFXBBoHtmNOjVEZ?=
 =?us-ascii?Q?kaWSiCc77dLW5o85t7cxXL8HDDA9eqMbfmExzKWLPOoC84INwVi3lfQWtgiW?=
 =?us-ascii?Q?UwfaZ1gz+TXk6TAvTdRyumnv1Y18eANLcu4YLOImuYRM+D10A1pombvvKr9H?=
 =?us-ascii?Q?L3ULF+JtCF1qVV3OS5WpU8pqd97q4Ame4gtF9oC5oK9cmw8U2rds4sFaOecQ?=
 =?us-ascii?Q?nN8kd7xDFK5/eHm+a9s8UOssHia3rRvCKoOEcuMfZCAGMEVbDqaMurLcpJIp?=
 =?us-ascii?Q?/9xtfaEk7+i2dM1pOGjUrNqcW8aTVeBIeYPhlNwtfeQdEOVvZLuT1yKQJGJT?=
 =?us-ascii?Q?ZbCRf5xuI3qQjMxlv9Xe9aqqJ2L236DT5DtBCTEe7zke4y70ZjyMykFaJMew?=
 =?us-ascii?Q?+J32Ee5zl/2q4vnWcGcV5SweH+y5VwBQDNk30v9eMFCfPJ3e95LfRnJyt6N8?=
 =?us-ascii?Q?PXkEKw5b6+8JWvU6lraHIgTm0dzbu/YzcKtW5xDjFkWwSxyHCva5sxzjNGgo?=
 =?us-ascii?Q?f8sHXb2MARdwk7nsUcow+VVhsoggm1CMOvVjA4HpOm/6c//qxXCF1QjEP63V?=
 =?us-ascii?Q?1ZQiIUArkXw3NzMVKAfgW4c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12aafca-7958-4fcf-02de-08dd0cf6b871
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 02:13:15.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /afT5Wip5zdVGSA1tSeKEZsK/rqmcYZEzqFrxy1Eja2pdWhIc6SWf5Q0LIlw9tPdfAkB6MQnnsqo7GtYYJRCdbrKnUmD3deH7vJO5NlMnQ6KuOoIyJ9pVFkyaJod/Gsj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6921

When running Specjbb workload with NEXT_BUDDY enabled, kernel warning and
panic may be triggered. We should not set next buddy if sched_delayed is set.

The 'last' and 'skip' buddy are obsoleted by EEVDF. Update the comments in
pick_next_entity().

[  124.972623] ------------[ cut here ]------------
[  124.977300] cfs_rq->next->sched_delayed
[  124.977310] WARNING: CPU: 51 PID: 2150 at kernel/sched/fair.c:5621 pick_task_fair+0x130/0x150
[  125.049547] CPU: 51 UID: 0 PID: 2150 Comm: kworker/51:1 Tainted: G            E      6.12.0.adam+ #1
[  125.058678] Tainted: [E]=UNSIGNED_MODULE
[  125.062591] Hardware name: IEI NF5280R7/Mitchell MB, BIOS 4.4.3.1 10/16/2024
[  125.069629] Workqueue:  0x0 (mm_percpu_wq)
[  125.073721] pstate: 634000c9 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  125.080671] pc : pick_task_fair+0x130/0x150
[  125.084841] lr : pick_task_fair+0x130/0x150
[  125.089013] sp : ffff8000ab41bc10
[  125.092315] x29: ffff8000ab41bc10 x28: 0000000000000000 x27: 0000000000000000
[  125.099440] x26: ffff000123bd8788 x25: 0000000000000402 x24: 0000000000000001
[  125.106565] x23: ffff000123bd8000 x22: ffff007dfef5cd00 x21: ffff007dfef5cd80
[  125.113689] x20: ffff007dfef5cd80 x19: ffff2001ab20a780 x18: 0000000000000006
[  125.120815] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000ab41b5e0
[  125.127938] x14: 0000000000000000 x13: 646579616c65645f x12: 64656863733e2d74
[  125.135062] x11: fffffffffc000000 x10: ffff207dfac9b420 x9 : ffff80008014ed60
[  125.142185] x8 : 00000000ffdfffff x7 : ffff207dfac80000 x6 : 000000000000122c
[  125.149309] x5 : ffff007dfef49408 x4 : 40000000ffe0122c x3 : ffff807d7d673000
[  125.156433] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000123bd8000
[  125.163561] Call trace:
[  125.165996]  pick_task_fair+0x130/0x150 (P)
[  125.170167]  pick_task_fair+0x130/0x150 (L)
[  125.174338]  pick_next_task_fair+0x48/0x3c0
[  125.178512]  __pick_next_task+0x4c/0x220
[  125.182426]  pick_next_task+0x44/0x980
[  125.186163]  __schedule+0x3d0/0x628
[  125.189645]  schedule+0x3c/0xe0
[  125.192776]  worker_thread+0x1a4/0x368
[  125.196516]  kthread+0xfc/0x110
[  125.199647]  ret_from_fork+0x10/0x20
[  125.203213] ---[ end trace 0000000000000000 ]---
[  125.207818] ------------[ cut here ]------------


[  297.371198] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000051
[  297.406112] CPU: 116 UID: 0 PID: 10328 Comm: Grizzly-worker( Tainted: G        W   E      6.12.0.adam+ #1
[  297.414884] Mem abort info:
[  297.424437] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  297.427219]   ESR = 0x0000000096000005
[  297.431997] Hardware name: IEI NF5280R7/Mitchell MB, BIOS 4.4.3.1 10/16/2024
[  297.435734]   EC = 0x25: DABT (current EL), IL = 32 bits
[  297.442770] pstate: a34000c9 (NzCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  297.448069]   SET = 0, FnV = 0
[  297.455018] pc : pick_task_fair+0x50/0x150
[  297.458060]   EA = 0, S1PTW = 0
[  297.462144] lr : pick_task_fair+0x50/0x150
[  297.465274]   FSC = 0x05: level 1 translation fault
[  297.469358] sp : ffff800101d93ae0
[  297.474223] Data abort info:
[  297.477526] x29: ffff800101d93ae0
[  297.480395]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  297.480395]  x28: 0000000000000009
[  297.483703]  x27: 0000000000000000
[  297.489177]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  297.492567]
[  297.495956]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  297.500996] x26: ffff006da4381b08
[  297.502477] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000198b3b000
[  297.507777]  x25: 0000000000000080
[  297.511080] [0000000000000051] pgd=08000001c0636403
[  297.517509]  x24: 0000000000000001
[  297.520899] , p4d=08000001c0636403
[  297.525765]
[  297.529155] , pud=0000000000000000
[  297.532545] x23: ffff006da4381380
[  297.534025]
[  297.537415]  x22: ffff007dff7fed00 x21: ffff007dff7fed80
[  297.547496] x20: ffff000167f60c00 x19: 0000000000000000 x18: 0000000000000006
[  297.554621] x17: ffff8000820b3be8 x16: 0000000087c17f9e x15: ffff800083d53690
[  297.561745] x14: 0000000000000004 x13: ffff800081df4ac8 x12: 0000000000000000
[  297.568868] x11: ffff200111a3f0b0 x10: ffff200111a3efc8 x9 : ffff800080109e48
[  297.575992] x8 : 00000000000000b8 x7 : 0000000000000074 x6 : 0000000000000002
[  297.583115] x5 : 0000000000000002 x4 : 0000000000000002 x3 : 0000000000000000
[  297.590239] x2 : fffffffffffffff0 x1 : 0000000000000000 x0 : 0000000000000000
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

Adam Li (2):
  sched/fair: Fix panic if NEXT_BUDDY enabled
  sched/fair: Update comments regarding last and skip buddy

 kernel/sched/fair.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

-- 
2.25.1


