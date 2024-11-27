Return-Path: <linux-kernel+bounces-423046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF269DA1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBDF284D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF337145A18;
	Wed, 27 Nov 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WvuEkTNc"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020105.outbound.protection.outlook.com [52.101.51.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD713D89D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687007; cv=fail; b=GMRIBQj/sUMe6NuGlPSU23d03Gf1zeMjRPqAfoFkCkbf2GKHlXpwZi+rgZMkww8dh9eJ3gYOY9AzCy6ybBKT4QInPg7S7oXhgPalCl7ahcG8MoIx1Y+2jNUPP9OiB0FXhMVrlT4ctPQYiR9OI98b2e38/IralPeczWi3nxXNwYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687007; c=relaxed/simple;
	bh=8Qg44jglT1PKWfWMAjOAICNJrc7KIVIUO0ScUUts8Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VUCPiWs7EFH260dO1LpdugriZHClArTBqJasGDl1ccXDJP3LzAihJTFz0+4M3nBYYknPeVvJ3IlcJSXF8nNIafc1ZEsEweZ3VXdZT5qPFKqwSMkycB45kfQCW01a1NNLE4+AED/fFVonsAEneLTWUZ7vefVMRQCjJjoy3joINks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WvuEkTNc; arc=fail smtp.client-ip=52.101.51.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoubcNcbJ+aGEgS6U6HeEtrbdcUW+kxzttNCHI0QbbebWcfqZMThX/XqX/SUnW7pywcogUvmPXwRSuz4JWuVfKH4eEvhw8AMsoNMlW9w0ZBO5dQ79VY3kxKMzlC2l/i4L+FFrOSSYrvr3pG8yA6T6iF3Bph3uD7DZtgdCPH/6jZQvPAJyO00SL8vUOaaYAL0EalSLPstW09Mt8Eu+CciijPcIKJbs0bdkIjxv8/3dhGhRmdWUa+2MWLAgFmxf8VrTSODaLuRAQkbQ8/uUKqn+okwjLroK/J84kEfosAMHZgnSNNZQ+C9y/Dw3WCVnLahwwCeJHN4LYS3FjvhP42TEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj/5V+KCxFaB+bX2qGxLv6ZfgJqgN4t6ZtBGPwG3SL8=;
 b=m19JQ3S+9/07YBLQYbzBDPUI96SY3mSBKcio7aKeKir+EHvF53ZXHYiPVBitCsSnU848CZ/0NdZ+2/LGT/0qC6x4Kjy/0AEsUMabRRalW5YH2rzDi2SObP1+gisXGBruMPKM4duGJZkHcHWLXG+QsVb8fZmV6iSqaRKJxG5DhroPnQiPBKXMpW6/0ZDxS/WBfB7CiGZ0XzFhsGTRjn2JGIx40ptqrspk4TF412KSNh5BAljbJ6msus0YGHxWE3a0MRS6twinMsgIo62irvJBMeNBjdehHLPW9U5QP/8HP/fc10UYNz3thkslp5kr1sHiLzzDl60DWRVOQ0sx1fBb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj/5V+KCxFaB+bX2qGxLv6ZfgJqgN4t6ZtBGPwG3SL8=;
 b=WvuEkTNcRtj6CpQgjjd0xbejILzhuTBB+q08LFJutgP1199WxSs0CBhIqGQUkP8gN3gQ0dQuMcFWQ5YcdO08Y/Vka/ejalybVsYE7r8zUqWR+5ole0CtZy3Pu2ThCHyZSKlroH3xth6Pf5uPWbTgp8cy3jHPcTJ6ddYxRq/9Ou0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6436.prod.exchangelabs.com (2603:10b6:303:64::21) by
 DS1PR01MB9086.prod.exchangelabs.com (2603:10b6:8:221::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Wed, 27 Nov 2024 05:56:39 +0000
Received: from MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970]) by MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 05:56:39 +0000
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
Subject: [PATCH v2 0/3] sched/fair: Fix NEXT_BUDDY panic and warning
Date: Wed, 27 Nov 2024 05:56:07 +0000
Message-Id: <20241127055610.7076-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To MW4PR01MB6436.prod.exchangelabs.com
 (2603:10b6:303:64::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6436:EE_|DS1PR01MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: ba22d5c4-abad-48dc-ef77-08dd0ea8425b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oc/6bjqHVgWYRfkvu7LRsEb+kAuw7od19pq8F3vsYRkHTTsrvUBkrjezTNGr?=
 =?us-ascii?Q?srlvQ5hPAT5K/dfPn04NygSo7DfgwHVU01jssIUD8yn4Fqm6OlIgYfwtG7Bb?=
 =?us-ascii?Q?i5wYoH3Jb02qQfl95UWz4nngbzS34gzW9JI2Vhw8ecvNMfnZ0ijiHoHHuczR?=
 =?us-ascii?Q?9eliUjHk3sc/miB9I3aaYohLk0tNwj3K49NaSnrGH6waom+1J4XnB6EZ9JZo?=
 =?us-ascii?Q?LQGsK5O4AJAs2GiQHCD8Cn83r/RRUmnMzEBWwZ8pfbBJcXAY5PmafB0uXSt8?=
 =?us-ascii?Q?VdjCUjWAHeia2zNgo6ar5VhkGV2txIJxRpirAeqcVPKs/cudpMNBzj1nlcU6?=
 =?us-ascii?Q?E5Sx4nPR1D+AvGnrVHDyblXLeD2qolaOHHMiclw1ODbhxQ3LYlS+dT9L53EL?=
 =?us-ascii?Q?2n4QjT+Ao1VFCIJUsKC25gKVefOlTi4Ep/U2Fa+Sav971s8ufosZUpenhauj?=
 =?us-ascii?Q?cRKJVwdvPK35WAQ7YnU4cfCuCKmjqWDh8jOl58ssQit5IAOOBRfKEmq+mtzm?=
 =?us-ascii?Q?1V1VZis3cKOAU8LPG5v4iqSS8L0us+kwRNFbmj4zHLK2/CvWh/1XMLnyBHzc?=
 =?us-ascii?Q?3XB7RrWnQ8ajltHCHnijnZfSBCXQFJCla7wwRmT3jZdO5ycsYvRHXw6B8QJD?=
 =?us-ascii?Q?u8Bpuu7GivzlojCuy8pOoguulxi+Yzq6rEdT72RpPADYFdXiyFtXVTUSd61n?=
 =?us-ascii?Q?BtEWt/w6EJTujvJfrHJop32lOgBl1MObR2xNOnA2JKyxAmbBjr9pBwYCEw6v?=
 =?us-ascii?Q?ZA7hGkiTyAE18l2o0EtuAFT9emK/Bd7+V5aB8FRHwap+/DKTBYeYqINTWqeS?=
 =?us-ascii?Q?pkCohhoLD6rERppVwJrRTZT+E5D+fa51LiCY94fRZ1+jMzr2esU4GAr4XfRt?=
 =?us-ascii?Q?mFQSkEFj7s0rERe9blcHApe1cDCxxmIPth5Ql07VL9DoUmQ3XsGvAZu/ApM/?=
 =?us-ascii?Q?r9avwPKdOr4mLXF9rN/6ix6vvbrvpWx408EaFSQzGoy5Be3dJwBKRH4jyvWv?=
 =?us-ascii?Q?JhqCuCQKzoWs4ZeS+XTPxX8zHMsng7QSV7MtCz7DJ0zex5Ya+nz3rMjokv7+?=
 =?us-ascii?Q?nWInGp1Wp/HyEJ7Ff7jdkE61V/vboeQlF3HbT18HF8ZstMMYRHgbQNO2N0SP?=
 =?us-ascii?Q?iuFXZeCE08ySHYBnwJvR8SFpKmov7XYC1iyJnbp5Uz+xsDFHHKmKzTBXQynQ?=
 =?us-ascii?Q?9vbRlXzxuJaRfrB2815w9Nh+46ORMkCBzmvylXgp9WJEtwjh1jfafxzNlJda?=
 =?us-ascii?Q?eUjCJKSGmrKQaMY8exgk6Me9hWUrAFGLGdNUmTmajA1i5hifF0vXCpGBwYZU?=
 =?us-ascii?Q?4fY3YUt8RxLSxB0+jGnmKY2vY7JBC+51cXDH8Yl2ZQ2fddtafIGo4pP37ZMV?=
 =?us-ascii?Q?8ZqocL+dSsaZk6kSsmaD3P37lTfcuEZHakcKFr3VCnhXFHXPjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6436.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGu7/2UeaIAvzTvNAaZW+RIQbDDMjuFLxjEwGl3lcsZ3K99Tvjsw6VisN7ou?=
 =?us-ascii?Q?lvgMOCzbhTrqJzaW3Obu+1mIdbbh1sFhKs4dl3jQ7kJXjDiCmw8Xc8OM43n3?=
 =?us-ascii?Q?yMBLbfTYFb3C+xx3edpFOxbYyG8aKcCMTDLH35phRsqTQTZF1IBUOEE8fM3/?=
 =?us-ascii?Q?p0WPDDRUr5+BXIWJaI7hSG1+kxy9wttHQBQ3SiscC1Vr9mcF35U1Sz4isvds?=
 =?us-ascii?Q?nnWTXVt0quDCjz+TDXPtMq8g3y2fBHETa4dZmFMSB4Pz0XEU8xZKcqXD6o6h?=
 =?us-ascii?Q?T7+4IUX+E3psl7D6BO3ma3M8GlihluO4LLFjJgvkILERhp9B1ki0/IUoiDck?=
 =?us-ascii?Q?kS+7EoPGrvpEPXOpbRf+7SabQzavxg8Ef+NxKKZbpNCs4068z+EcN6HRxAcO?=
 =?us-ascii?Q?QftE/5OLtaPiI4rug9e1kESy3rdCrdqh6SPjOYm/LRbSIvmqKjQBE8+VHXf0?=
 =?us-ascii?Q?XSljkhtuF6czWkyj+sK8VSoZUU21n+rrN5Imz9kIg5Vxm9jZjwKdPpY02++p?=
 =?us-ascii?Q?TajxkxADyWe3QqtyK5o+e9tfIO+di8dlmy0QT1eHU5mZQ8/cp3fbotynKj/7?=
 =?us-ascii?Q?4MHUIzUA7eCc5RAAXe0XvEgJ2I2KjCJQG/DCltGEe+usEnfSSPW4M4pPV4MM?=
 =?us-ascii?Q?rtMOuGtJTLLcoQ2sblxZbNihOec4LtGGQyqEV9ItNKE2kCSHdg5xqV0+ryXH?=
 =?us-ascii?Q?1qyt+XPCCgJGSH1dr16RkpVASl3AKfobdgqD9PpVvc+0H94Kfz5zDdRxd0Xr?=
 =?us-ascii?Q?qVbW5v1XG1x1Br7TA1q4eQkE9/MnnoJSXsO0YyL3cy1ZCTt88nTkpnJKdYuX?=
 =?us-ascii?Q?RzVmG4DSdNjhXCaWSsbWbdDV6NqHCT09MlVtdLk8FVe9u90GAM4RBd8oxzt4?=
 =?us-ascii?Q?RBfBxxa8QyHW+18nwNlmuc0PM/9LhB3QyAfVh8j2nxuStL0QkC82bpGlg6qV?=
 =?us-ascii?Q?mvkQQEpHn1TDNucL2gVJS6amnEQyACimMwXZFNZh0m9XZNRz5zbK8QC3ogtr?=
 =?us-ascii?Q?FAE8DPMJ6NbdlR9WS7YDudYy/1GoYmfWgtAOajQPdrO9+rC69NhC4sTdtcaZ?=
 =?us-ascii?Q?UWj2flJ2l1h7jmdsuYJQFcLgiGZwAmFA+SRc8wKh9QhsiCRfJJsupeoTxyfB?=
 =?us-ascii?Q?SNWzMpdRkRzAtpmF2ZdNryT6M7ylLZisvy4DfXOGzM+e+0MD8oPq9ruLUwOY?=
 =?us-ascii?Q?urpeqpxa/civyQ7ObGu1vrm5RYkxBadONZ6YF0oZO3L5So/ko/6VNxfZYQBW?=
 =?us-ascii?Q?HpZTK9pZkyTdbL0dtBcuBltkJFu0A09MNAshnOBfgBpJvaQoO4Epv3AADtZo?=
 =?us-ascii?Q?nyx+S8bGvaRM+3zksCAWlanZyjXfXM8kKT3NuuCKFevvqAoqrEFlAmjFn4lu?=
 =?us-ascii?Q?7VBsnwMyh2jflIVFldFE87IYRhpXjvhKSqggm90t+eo5PtV6gfK05TMJGhSi?=
 =?us-ascii?Q?5raluSztgymBdj03ONqYhpA1fOTe+cU32WkckRagZY+edst18tqo1ixL1/q1?=
 =?us-ascii?Q?51l+x7BxHTFu9+4dfMC0ukPiXmCGla/ziVcBmiiwjkkbPEIg81JN9kvDl7G6?=
 =?us-ascii?Q?WkY4om0pW553gvmyst/qiy2uwcKHzN+ZFUFjSLZA0m0qNkMTcKSr7yP5uhMW?=
 =?us-ascii?Q?BfiYZJGGeE3zir3s6v2ctaE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba22d5c4-abad-48dc-ef77-08dd0ea8425b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6436.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:56:39.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0v4sGx8UsGYo0rr5uYsKdgc0puMIrlxPLDMtvnYUxAZA0BOfGBNkrKCFY9zS9aUH+Y/27BqaVQab3z3NkncT0MQYikr3dc19EJD8CcYvBBx4STIgdkJVnync/3qxjqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9086

When running Specjbb workload with NEXT_BUDDY enabled, kernel warning,
rcu stall and panic may be triggered.

The kernel panic is triggered in pick_next_entity() if pick_eevdf()
returns NULL.

In patch 1 ("Fix warning if NEXT_BUDDY enabled"), if sched_delayed is set
we do not set next buddy. After the patch, kernel warning, rcu stall and
panic disappear. However to avoid panic, we still check return value of
pick_eevdf().

The 'last' and 'skip' buddy are obsoleted by EEVDF. Update the comments in
pick_next_entity().

Detail log bellow:
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

[  211.151849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  211.159759] rcu:     (detected by 141, t=15003 jiffies, g=5629, q=26516 ncpus=384)
[  211.169780] rcu: All QSes seen, last rcu_preempt kthread activity 15002 (4294943634-4294928632), jiffies_till_next_fqs=2, root ->qsmask 0x0
[  211.185062] rcu: rcu_preempt kthread timer wakeup didn't happen for 15004 jiffies! g5629 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0
[  211.199043] rcu:     Possible timer handling issue on cpu=352 timer-softirq=1091
[  211.208943] rcu: rcu_preempt kthread starved for 15012 jiffies! g5629 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=352
[  211.222141] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[  211.234037] rcu: RCU grace-period kthread stack dump:
[  211.241854] task:rcu_preempt     state:R  running task     stack:0     pid:17    tgid:17    ppid:2      flags:0x00000008
[  211.255487] Call trace:
[  211.260698]  __switch_to+0xf0/0x150 (T)
[  211.267299]  __schedule+0x238/0x628
[  211.273553]  schedule+0x3c/0xe0
[  211.279459]  schedule_timeout+0x88/0x108
[  211.286147]  rcu_gp_fqs_loop+0x158/0x4d0
[  211.292835]  rcu_gp_kthread+0x164/0x198
[  211.299436]  kthread+0xfc/0x110
[  211.305342]  ret_from_fork+0x10/0x20
[  211.311684] rcu: Stack dump where RCU GP kthread last ran:
[  211.319940] Sending NMI from CPU 141 to CPUs 352:
[  211.327411] NMI backtrace for cpu 352
[  211.333835] CPU: 352 UID: 0 PID: 0 Comm: swapper/352 Tainted: G        W   E      6.12.0.adam+ #1
[  211.345466] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  211.353021] Hardware name: IEI NF5280R7/Mitchell MB, BIOS 4.4.3.1 10/16/2024
[  211.362834] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  211.372557] pc : cpuidle_enter_state+0xcc/0x4f0
[  211.379851] lr : cpuidle_enter_state+0xc0/0x4f0
[  211.387147] sp : ffff8000878c3d70
[  211.393226] x29: ffff8000878c3d70 x28: 0000000000000000 x27: 0000000000000000
[  211.403125] x26: 0000000000000000 x25: 0000000000000000 x24: 0000003133e26b84
[  211.413023] x23: 0000000000000000 x22: ffff800082092d98 x21: 00000031341844e8
[  211.422922] x20: 0000000000000000 x19: ffff20011d459800 x18: 0000000000000000
[  211.432820] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  211.442719] x14: 0000000000000000 x13: ffff800081dcf030 x12: 0000000000000001
[  211.452619] x11: 0000003131433c14 x10: 071c71c71c71c71c x9 : ffff8000810b5900
[  211.462517] x8 : 00000000003bf790 x7 : ffff207e031d57e4 x6 : 0000002023a22338
[  211.472416] x5 : 1fffffffffffffff x4 : 0000000000000015 x3 : 000000000030e5a8
[  211.482314] x2 : ffffa07d818ed000 x1 : ffff207e031d6d00 x0 : 0000000000000000
[  211.492213] Call trace:
[  211.497426]  cpuidle_enter_state+0xcc/0x4f0 (P)
[  211.504719]  cpuidle_enter_state+0xc0/0x4f0 (L)
[  211.512013]  cpuidle_enter+0x40/0x60
[  211.518351]  cpuidle_idle_call+0x130/0x1c8
[  211.525212]  do_idle+0xec/0xf8
[  211.531033]  cpu_startup_entry+0x40/0x50
[  211.537719]  secondary_start_kernel+0xe0/0x120
[  211.544926]  __secondary_switched+0xc0/0xc8

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

v2:
  Follow Christian Loehle's suggestion, revise commit message.
  Add patch to check return value of pick_eevdf() in pick_next_entity().

v1:
   https://lore.kernel.org/all/20241125021222.356881-1-adamli@os.amperecomputing.com/

Adam Li (3):
  sched/fair: Fix warning if NEXT_BUDDY enabled
  sched/fair: Fix panic if pick_eevdf() returns NULL
  sched/fair: Update comments regarding last and skip buddy

 kernel/sched/fair.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.25.1


