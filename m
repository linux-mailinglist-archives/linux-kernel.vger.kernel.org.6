Return-Path: <linux-kernel+bounces-306061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CF59638B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA522B2238B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5C0482EF;
	Thu, 29 Aug 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="bWd6bRJ0"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022074.outbound.protection.outlook.com [40.93.195.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9045BEC
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901123; cv=fail; b=Af3Bjou5RFEObyqCz5pUlYNjccQitv1ikqPoCClxfchgL9Uj2buIl82nvpaBsvftWfh8Sv4Lv7RZJ4dLCLE/GSb+N9RsSdIWdViFffrXR6LF3vXiroVceWNJnIUZCpw6QiFX4YZzPHjSYOU7oWdRDme25JMefpbHo3lGJNuldzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901123; c=relaxed/simple;
	bh=fa7CSTiHdu0+9SEL+t5GJER+4cJ/+rL3CJ2MHcXnxsE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BX4gD5z6m90U67Bva0UA1L+7tq7GVukZ0Mq/oRVfay/MFzim3ue+lWjDaMu4LIZ9GzFBmGK2jCyLfEctxc/G1r+l6PJgdx3uJ6tyxOJ+ORABW00fMWokaAxxli6q16jkYUc9BNl5zKtmlL6wYcKIArwzIzneVQyaZTTorzPCAL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=bWd6bRJ0; arc=fail smtp.client-ip=40.93.195.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DS0xZ8oN8rPq6qG9UavdbDa9JGBcdaC2kxbzHGWLqtokLaEv2cZCmcQm8bc7cICkKRdH5QPe1A6X2CzW6a2lZfbm7REBvknkF3SY7qt+sbPgsXZAOlzO/C6gUrkDhtgdSU4tYGAMtQdfpq8ZbSvn14HJufqOHTickXkZMkFYXNbZA1HmlsKdUADUZOpbQoZb7vdLL0kzf0HGCbWzgBciV8fG8htsCznhcKcY7rwXvTbf9h3K97BLzriYzr3ySENCBCZ8E2tPz5A+/53Nf8NDhiZDiD6JAI3YF6gJWWMvU/Ehkw90lrPaoa3lLkjd8Hz6B9SPN3DgJBoDSMy2b+MooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1nBwp6QxoyeajuTc26uPftaFSIFY3Nv+YBlkeA4OZE=;
 b=YQo9EqEqIXs+F2FA94qQlixvKO8nVVeLAKGHeUzlaYDVFpZDHSG5vMyHJN4nJOi70aoH4fvYr7iyA2Dr1v7Xo9A2QnybWxKJ7RTYdOCY35d6lnddGju8ybIzJy3NL3fIXss1c60AilUyWk4xNmKcg+AfvB2HYlJ+N49HULvdQlxxhZqCdHTVGgX15k32kApIYHpVKXi50di52bPqjcRA1lzCsHf3cA+f8qAVfrbLgfNZfeVjK2gsDLvEkWnfl6GBPMsuhyPFj3PDGRo5f79E9E06r2PqqulAsEGd5If9iG4Hw1P0lxtpxlXBH1GwN4d5+eY6BftvEmDomdnuSnXspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1nBwp6QxoyeajuTc26uPftaFSIFY3Nv+YBlkeA4OZE=;
 b=bWd6bRJ0QPHFpZSqzCPFmexbr0sOVsh21nyA7bA6FAawyQxyJ77zHpSwGluekmSGHr/P10ceQ8xt/qdogQucJ+j3h17W7h4F4VZndafNAbp0ZGemrt0OsM6jR8fB47QTSGwz1t/L+J1+44NXfXLymWpqvInTYT8q/uzhkXdEkCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 IA0PR01MB8279.prod.exchangelabs.com (2603:10b6:208:485::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Thu, 29 Aug 2024 03:11:56 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%5]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 03:11:56 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com
Cc: patches@amperecomputing.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	vineeth@bitbyteword.org,
	bristot@kernel.org,
	linux-kernel@vger.kernel.org,
	hongyan.xia2@arm.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v3] sched/deadline: fix the hang in dl_task_of
Date: Thu, 29 Aug 2024 11:11:11 +0800
Message-Id: <20240829031111.12142-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|IA0PR01MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 363a3adf-f8da-4884-65f5-08dcc7d856b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JI7b2aMc5+s5i5F5eJTMg1Jp31OaJMmJE041Mfct3AcHgQX8jOeqKR1I4cKQ?=
 =?us-ascii?Q?1UGo/uFGDfW52S2pJxjMuxBH7ynhv51Goc0XvbWLI5GyI9map7Q3IpA1Ypx+?=
 =?us-ascii?Q?kehVaTGczFrdud5KZd+HRThZnXMjp6KFz6a5KaB/RBd71jORqmZO034cuo7+?=
 =?us-ascii?Q?i1HOq+V9XsULqAMbnW94o1/mjHjGcZh3n/C5H2AI46ljKpkGprlw0zzEFibI?=
 =?us-ascii?Q?NS6StST3ZhOGD56wpJ6JdRIlcb0sF90BupWuWWXRgQYzT9Y/4uQbTimnE3jy?=
 =?us-ascii?Q?/xheBBGC8L5+PJQPWxDoa/O8LS0DbuqcD5skGzCiv/8uQaDxlmrZ3fGFZxE0?=
 =?us-ascii?Q?h6xsm7W+tFmNoaAqaFGqXB53/0y5MAh8ucqWSArr2As5qHoq25KvMEOiFXj1?=
 =?us-ascii?Q?Zvo3zwnVZDCKik0kWXpl9cTXMqhlistoZy81zRsoBChhfN0zHzeIHbPTGrHU?=
 =?us-ascii?Q?eoJKCTxdWEzxZIpfHc+pldi1zM5L2nCyXiC7mg9xeFU3wC2CSeolhMrQGYSF?=
 =?us-ascii?Q?5QH49pRubJPOBptiyfuFIl/l1zbzTxyjqhY0y46fLfX0gSZ3+8U3u/AW6fOk?=
 =?us-ascii?Q?P+JthcvkJ/iMZTV5iaYAYyBa32YBeF5pvxPPjRxZnaT3dUW7+rqOK/falUdB?=
 =?us-ascii?Q?PeIwmo3jtSA9npuwdbqqGZanyIaHDMynP0TVjx7+yybPX+Fjtr5H54IWFbKC?=
 =?us-ascii?Q?7Dd1f6AqoFoqel29WiYo84BSHRqPCdDIkB9ghToR2IGOonjtwfTdsPO5HWCF?=
 =?us-ascii?Q?UyT3BIAvWX0cCZlUXA0/gjBLg+YRmS1QuplkTngae8BkIUhKOTVEUqvgjAtR?=
 =?us-ascii?Q?EzonY2bGgFKpnM/IZcWQfVfrGZhIc+Eh28r4/5ih8rKGZVVbWbRIZ+pNrgsb?=
 =?us-ascii?Q?iXSZga60YiLIoHXK2fx2F3WoRnof1hTpbnUkMItyoJHo5kFGuLZbdZc1EP0d?=
 =?us-ascii?Q?8lKQF0ZiGTFBFIR1xdLNwSwigTwL+eY/hNBaf5YZeXNoRDFxiBis4KMCILHx?=
 =?us-ascii?Q?niiny8AizM/LKWMMUbJIAvwY3KdOusLSc/Rv4Gb3AkFwjpHhWg5E8tzlOIkV?=
 =?us-ascii?Q?i0Qx/rJbFl6rWvDDA44DdQMhsjSFFGY8bFSJR2Sps0DDehHyFOplFA+LHgjc?=
 =?us-ascii?Q?WUpyOW/c0E7lSajiya0m6CqOQ5SBk8uwKGVsJIKInce4xxZHVG6c20K9yIts?=
 =?us-ascii?Q?X2m+nuOX0ga3cRHKBAewoFMq0th3t6IL84k+DJUF5nq3Jctzjfmlh25bYjCm?=
 =?us-ascii?Q?DMKwZLmLLNv2pIGnbnDm4naKw08hwfPIjfT0fuUM1FIOkYjt6aaFboEWmQ+3?=
 =?us-ascii?Q?d3/mq6IFs7ICEKIZPKq0E6kfc7GWKrRw2OJNMMaCOSWzZ2PUjh7Q4b2GFO3m?=
 =?us-ascii?Q?WpSs/YA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C+nGLojshfUqIS6IT8BNdFEbUTy3zgsAcvmuhaxw/3B4EgA7vkljXv9hhLtj?=
 =?us-ascii?Q?EG+Ir1XjClkyeYf2xD8rzdxBxx7ZRzCad/EZvAxHngBuWDd/M2Aq6I20fP0V?=
 =?us-ascii?Q?X2J1XYRQs96PsEMX1wm2MD3C1PyYNPve46onXIw9KyBCBObr5u+MBy9GqDsU?=
 =?us-ascii?Q?jnTcz4PBCXJpc3CUKv2fERSSMT+wRGS6UPFBzvUJ5D3jYVvhhl/XsmW06793?=
 =?us-ascii?Q?EaPRM/y0m1rAv4/clJ3eHfpPOKlkxXMAcMYC8k8PBJUrip13RqNp6FOd49XM?=
 =?us-ascii?Q?tpSEQeEkrdyLVU/6Tk4bMK5ilQKcdER5sDhGCf6IVB/9krVLmDOs6dIAbEWg?=
 =?us-ascii?Q?pifQOzbcM5bBKOzcjbXul6Pg/ghsZBU8V1O51+FwBJhBg7BNlYHzb+u7PXy6?=
 =?us-ascii?Q?Xi/NJftP2+od4UOz+m1WDuRM7dKFuvHpsQWDqlDwfpO82MtTfCdz+QjF/Dsg?=
 =?us-ascii?Q?chK3hsR7rxsBMWj2adtGVDLzpIOQ2yys7muc5wFYbx7T4lsL1I4hj41sHJ3K?=
 =?us-ascii?Q?Sw9WLj6XUv/WM3M8xjpxGCubBdNPUdrdQ78AYknSYUyTEasHQwl87GEXeAKp?=
 =?us-ascii?Q?rHunAbqccVyOtqHf4CGh3z8A5Cp+RGeapc715ytG1/SQunmCUdBuL5ONfxvF?=
 =?us-ascii?Q?Hb3URB5oU19pWOVyZK7j/IACfC2w+l16NRyiLJt1tK7VwariuyTzhwaUmtGG?=
 =?us-ascii?Q?C68loR+BnL5UgdqMaQcRpCcb+YC0hV4Upr9wsDdf4dOQalWVSBAL3pcET75U?=
 =?us-ascii?Q?JmUo7rZNE7hYNSraTS8LVtcGlnn1bCbxqn8rLRgSHeg0/s1n2/eV+f9pSAE1?=
 =?us-ascii?Q?fE1g4nIPfwAY9t14G9iOjs/z/KEudJaBd6jnCSyljoZMYzwHwFbrqPDc9tqK?=
 =?us-ascii?Q?vrCbU2VZPu1F9VvS3PkvAQWNENvu0KGw0pVT4uDG0abbzlL2VfTe6H2sSIgW?=
 =?us-ascii?Q?b1k3K4fqklPazqZX4ZfDOYy38+TEHvLPPFefIpQuh4z20eFr+akIMGiQ5iGl?=
 =?us-ascii?Q?oKUxDcmAwPQ5ylgPSw+NjAWatjz3I/4Ogc132Fqd4RYjk0U2Mat72hh/RYxD?=
 =?us-ascii?Q?/AK6+Rp3im1LWF69er8gXKfdhZModTnt6mf0NvATbfWO17tN0ZDcsQ3tUkv0?=
 =?us-ascii?Q?a36JORyy91m3rHZr9FapsBlnspF0bgGjKTtnORiKJWPhjaZIQ30GXoVmLQg9?=
 =?us-ascii?Q?/G0IAA9tvhH4a34G0thg2Y0LDLruH9UFkfgMkQi4CHGQH54Nhosdke9/btDk?=
 =?us-ascii?Q?8FioJncr8MYKkahRTPMsCxq9umYdXYkVzge4aqWV5X7GQ6o5pz9pQCS28ouu?=
 =?us-ascii?Q?fiVuov1/ISys3RKzVufQOnI3uKty5PG2JRYfPU8Poivt/iIZd3tytecp+/ue?=
 =?us-ascii?Q?yzocHzbOUJoel3Ps82LwQM5Kvg3oq3eJBxnBr1q4Qm8E5eBDoREMdO+gqaEH?=
 =?us-ascii?Q?saDDyJPCwVc7tkUEpZ+cdlLWhzMEHhTLFfc/ifv0sqQtLdep6zpv3ExBV4Xu?=
 =?us-ascii?Q?DkcUVoDCDyde35ZahMbrtgvs/zZe6poGwII7L+wy58TMhcNVtU/BwJRm06Ag?=
 =?us-ascii?Q?6ywcyW9xLRJXpVxyK9e19bjErKYLNcxOVitSNHP3j952LJxby/cd1vPE7lUh?=
 =?us-ascii?Q?+8oZZZ5nvB1t+aQ8I37duQY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363a3adf-f8da-4884-65f5-08dcc7d856b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:11:56.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0df+OLgfJTLfLpE6tTeuAbDRzdpvKoh/mElAc9B9UNbvdPF6hHtZgRgMcBoLn5f+04aaxUfh7rEaMkQzaPhbyiLVr1EhV+YwStQw1aY9SswebgK/tf9/IR187o2Gllk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8279

When we enable the schedstats, we will meet an OS hang like this:
  --------------------------------------------------------
	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
	[  134.132013] ------------[ cut here ]------------
	[  134.133441]  x27: 0000000000000001
	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
	[  134.162027] ------------[ cut here ]------------
	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
	[  134.192036] ------------[ cut here ]------------
	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
	[  134.229915] Call trace:
	[  134.232353]  dl_task_of.part.0+0x0/0x10
	[  134.236182]  dl_server_start+0x54/0x158
	[  134.240013]  enqueue_task_fair+0x138/0x420
	[  134.244100]  enqueue_task+0x44/0xb0
	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
	[  134.251584]  kernel_clone+0xe8/0x3e8
	[  134.252022] ------------[ cut here ]------------
	[  134.255156]  __do_sys_clone+0x70/0xa8
	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
	[  134.263412]  __arm64_sys_clone+0x28/0x40
	[  134.272360]  invoke_syscall+0x50/0x120
	[  134.276101]  el0_svc_common+0x44/0xf8
	[  134.279753]  do_el0_svc+0x28/0x40
	[  134.283058]  el0_svc+0x40/0x150
	[  134.286195]  el0t_64_sync_handler+0x100/0x130
	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
	[  134.300283] ---[ end trace 0000000000000000 ]---
	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
	[  134.311147] SMP: stopping secondary CPUs
	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
	[  135.371884] Kernel Offset: disabled
	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
	[  135.380749] Memory Limit: none
	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
  --------------------------------------------------------

In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
is enabled, in the following:
   dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
	__schedstats_from_dl_se() -->dl_task_of()

we will meet the BUG_ON.

Since the fair task has already had its own schedstats, there is no need
to track anything for the associated dl_server.

So add check in:
            update_stats_wait_start_dl()
	    update_stats_wait_end_dl()
	    update_stats_enqueue_dl()
	    update_stats_dequeue_dl()

return early for a dl_server dl_se.

Tested this patch with memcached in Altra.

Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v2 --> v3:
   Return early in:
            update_stats_wait_start_dl()
	    update_stats_wait_end_dl()
	    update_stats_enqueue_dl()
	    update_stats_dequeue_dl()
   
   The v2 link:
    https://lore.kernel.org/lkml/770da6f7-89f6-49b7-b8db-a7318abbd828@arm.com/T/

v1 --> v2:
   Skip the update_stats_enqueue_dl() for a dl_server dl_se
   in enqueue_dl_entity().

   Btw, the update_stats_{wait_start,wait_end}_dl has already had
   the dl_server() check.

   The v1 link: https://lore.kernel.org/lkml/20240826021115.9284-1-shijie@os.amperecomputing.com/T/

---
 kernel/sched/deadline.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f2df67f710b..b1ccc1b6e7b9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1910,6 +1910,9 @@ update_stats_wait_start_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 	if (!schedstat_enabled())
 		return;
 
+	if (dl_server(dl_se))
+		return;
+
 	stats = __schedstats_from_dl_se(dl_se);
 	__update_stats_wait_start(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
@@ -1922,6 +1925,9 @@ update_stats_wait_end_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se)
 	if (!schedstat_enabled())
 		return;
 
+	if (dl_server(dl_se))
+		return;
+
 	stats = __schedstats_from_dl_se(dl_se);
 	__update_stats_wait_end(rq_of_dl_rq(dl_rq), dl_task_of(dl_se), stats);
 }
@@ -1945,6 +1951,9 @@ update_stats_enqueue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 	if (!schedstat_enabled())
 		return;
 
+	if (dl_server(dl_se))
+		return;
+
 	if (flags & ENQUEUE_WAKEUP)
 		update_stats_enqueue_sleeper_dl(dl_rq, dl_se);
 }
@@ -1958,6 +1967,9 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
 	if (!schedstat_enabled())
 		return;
 
+	if (dl_server(dl_se))
+		return;
+
 	if ((flags & DEQUEUE_SLEEP)) {
 		unsigned int state;
 
-- 
2.40.1


