Return-Path: <linux-kernel+bounces-438533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55699EA25E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C90162617
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1119F461;
	Mon,  9 Dec 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vte3w95H"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A419F43A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785407; cv=fail; b=imcYWrsymrPiLiKFbZd528tLSwOvIi7aKuf6h17AeRL5Dg28Vt1mR+9CyW2t0EYvJodtZa1aeIb+06a1pSRY+MQIIwV9uy57eOSc2GbvMMZpz9Zzjm+7AyZrUvCJtSNybnWq9gC8ZKTUP/DQdRT7h3PgY79PMyZrQRXTNDQwg74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785407; c=relaxed/simple;
	bh=ZuKa5YDNWn2360Wn9nFrk+tXl1o3/Ym7wI2upfWSPkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkeaCCZOMQXi/nuiEBQq2N1iGwG64Jpa/tiD6HkplT8oCt5oCi8V0Y7iHtXsY32A51lmuoDe4hHWz78SJ+jMJC0w4W5zP6/REqVFdt4zKBRJxPtkDmj6xB6ZU7qOdOQYinkR63W/InPpRtNpWG3NwKvokHX7PG0oHgPT6THUg+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vte3w95H; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SunbW9Vp2jAzj86OFpeZRk/jPCquB8tw1byvcLW3egyzrmgeP7MmWbxk1xcKIhsdTW4s0wkI0UZ7a+E5xeDXHN5K1ZHMqMhyW1UGuXkLXmICjYH3p2Jbd4uQVT84cdlITIsKju3KYefY+8gW3HY2ppyw8EiFuGWH0Hz+BjYBUWR7bgKZVaXcwkvPGT8BXVWYtY3IhI1K09CAAqyMAeIbAYkC1HRhCXfJY0GzhqTORp027ZIGMkc871KEzrqW/fr0osc7sR02376+aGBwrKQHb4OFizhsljatL5U17LK3MBnACg2doyKqilOjnmzf8VRL7XuWmdRqBuq4+d4w9qE+ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJIr6ejB8mf2jvnh3WAVfJEuYe3eHGQh+E2GomDts1Q=;
 b=xJ0sjoyhZaVAyuFNbMjJQ3FRPK3cdfrih/FUFh46Nlbba3e0E9wvFlkCxlFuBiaZJWrPGLsAk+wVQYsOrJyvtogDkt8ECrhWL9KScsKYgcgCLj7XymyFwNnIF4W+u+wPqu1gM6mPmFE3ovZ2jAxZKF9sbhsAzu+GYNupz5ql1ggQ6g8r9FNAgvPVyfZvP3WsZjvUk3nuORL8cAl3uVu0EBlolqYYBjyHVwOeHbWmB6u4LeF+rBPYxXbNgvxzdxM7INdKxhU6+81iBo9K5xvL+M33Xck/WatMNtuzRdhN8Lszr4SST40wjP7M590ZX/lP5MTpzsYtFQro8fkXNB/uQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJIr6ejB8mf2jvnh3WAVfJEuYe3eHGQh+E2GomDts1Q=;
 b=Vte3w95HJ9vuRDJk4f87SmPqKA0lgmc1IbUo9IaF/57Kr409v62PJNSqz+vOGALuuH4zEwFrITa/FeRJ1mFw/3RYipWLG/ctuHKV4F6qbAYSTP8JXU0AWvrgeOWqZmZpoCgxrp+2ZRSUc55BKwETP+pYmfeY+NIK/n3agxbhbCH2dgGVHRVS+P89S8vNjBkiEDwCLQ855xM/OEKZGs5XfkHVZUDBdNA7k9rhHJSmyTAnIgy9r/jWYy1sudOoSYMURacQ3iAwUI0CWAgHUTEz9ud1djWvctb6itUCc/5XcHYvZCVL4AOr9/9ZWaUv8SxIrijG+FLI7+GLOgBerXIYcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Mon, 9 Dec
 2024 23:03:19 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 23:03:18 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: Move built-in idle CPU selection policy to a separate file
Date: Mon,  9 Dec 2024 23:56:30 +0100
Message-ID: <20241209230242.775225-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209230242.775225-1-arighi@nvidia.com>
References: <20241209230242.775225-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: b479d7c7-71bc-4226-65f8-08dd18a5aba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IZrbGmWW+g5FVz0+D5OgmJKj6yarxV/mSZ99xYDQlAkVWwZlGYO8rKubcdd?=
 =?us-ascii?Q?UiEME8iFDHAA+XoNzZVWoZ/J3hpAgH64x9U/bAJMI7O8BFE9BMo9x9tCeut7?=
 =?us-ascii?Q?vpnAq3dHNVppxgY1wBSJugFFbDBiDk4U0W6lzwdbs9U9KuW9Fa3CoGwEo/Y6?=
 =?us-ascii?Q?kw040A96Qn2sNtg+/ihohjdvBoUP/lPCLn1/yBabpbr1+b38vRWfTfj1eDQ1?=
 =?us-ascii?Q?/UvBrASjJ4kCi93lWqFZjIeuFsht4qKItJ2R7/LfxnpkB03iz5ACCnGiHCFo?=
 =?us-ascii?Q?cO4CcWMrIlGScunc37o5wBhCxdzRipm2xteI43Y2Hp7dSI34sVV+G7zhtH1I?=
 =?us-ascii?Q?vbrdH22pMRbT6M9eQl29JIf42RzI3RtHFvznR8HPw8/ZkzwzKg5kyUz4rDkm?=
 =?us-ascii?Q?hNycf5MOwYjbi1FjFJBgQzh7jJkr6KzzrUmu0ixn0W0oZfdcYuVF+sCutvjf?=
 =?us-ascii?Q?QRFBamw0gttlUR10El6L9Je8kkpnSn927KpRJEFtA5W1OaIWMSlKTt7Ewgyh?=
 =?us-ascii?Q?7PX4+6uB/eLPe/2J5Y5v7OFwUvhO7IX//u49dknP9UyiZcvICSAM6BkObrCc?=
 =?us-ascii?Q?rWo7erMQX2aMZyZR5qftxIyFNp+A9Ph/uuzOxSHa02xDukcGcHNzgzC7Kb6F?=
 =?us-ascii?Q?jws5unUUoC+DSipLGcZyBWThSFTCsVvIlA2lDYQmd6HvLnCKwD9J9+4TB48x?=
 =?us-ascii?Q?Db3SDCKv+eBozM/WXhUZLmiosxcO7c1kJdsrcNUS6PcGTZtpUXyc3AFpvaSL?=
 =?us-ascii?Q?2W4bS2Ym0sMeT2aj60HJR9npKzxnsTsiq1g+1K2c3TwQNV6DmwRxj00dOzYa?=
 =?us-ascii?Q?uoYvvp7USM+vRC/4N8N0meYdDpR+Z3cnRZ1bkIRQpEftj5wu6LgmIkuf1Vop?=
 =?us-ascii?Q?rAUUKOytf74elh3RZhPNYBdidmlFEOk1F/SAWfWKyWF3bN5ilL13WWWjucfV?=
 =?us-ascii?Q?kbca4WpwnV6Fq31x3hmy0abXEqiLKA74VYxpimY12DCfgNd9Eq6Zigx8/SQ2?=
 =?us-ascii?Q?0lz6iwvFwLjcogC7jmc4iOAw+gffuV/+3AX4XIf40eS6QzUxOLISZ6kvgrzk?=
 =?us-ascii?Q?0o5XXu/eN2KbifF4mlASu8X9fZMZkcY7LQR2Do/szUDCjhrebAhnwwwv+6fi?=
 =?us-ascii?Q?LIgDOoHNHeaqNPmZU71dHXoYupj8urlbzJdCgE6FJBAjIkge1tElIsb7KAYn?=
 =?us-ascii?Q?LKAV8U+boXXkkE5xMepdvX6rpPLVnJoja4S4wrIVLHxKcsYqkTb3Pw41HLIF?=
 =?us-ascii?Q?pS3EgTZnjhSrw1BhyXUNzYUPLf7W701WHy+lNTFFlMUQUhnx/f+mdpMB4xhE?=
 =?us-ascii?Q?DAg/kvXmK+DG8AUk3i9CLbL77s5rv1VxEaOQ6fpfPAETPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gDZLTynCWwNsaFCSGYG+wpf568f49k0+yi79UOJHbH1Gn/Ok8+P3hYb5satp?=
 =?us-ascii?Q?8cegLs+4gGdrN6xL3PbT7887Exkc33rGVfdQ54Gx022x+2ywzPa2mAFKf3q1?=
 =?us-ascii?Q?L9gf0lekD5RYGs2Lf+HmK4jFB2XjmFNCaRkwmWUdghaipmemk+W4dTvLrv7R?=
 =?us-ascii?Q?w84eqfS7i2WmEHXk1eAYA2fnQZWDiBn/ahDQX84hkEKl9Jyzg8wFwpjmPfwD?=
 =?us-ascii?Q?R6AGVWyqVFIZLqhiA0P66KDNIFI23Z58xp6vF+0/h8ksTF6UKRXkFKK1tSQb?=
 =?us-ascii?Q?7L9Pg7oe0Zk52+43WdsHSQhHZ3MEuGLjE+7CeF/8EncPfQBWN+dgEJdBnKUs?=
 =?us-ascii?Q?Fg8ggQoHjsLQrsyddWE4zgl0XwS3NRfojAXexTYWxeCrXyguUayPB3kuVbxw?=
 =?us-ascii?Q?xpQakwnr/9kWU7yIQ83f3p091DWBNg3RVDow18AS5bkVGrL+jgnqLneybt6x?=
 =?us-ascii?Q?KI+aVp2zLHzRjDhI/oMBZBArCYbb7e/cJs0iFmhc4ZZ+ThE/4V42gQH37SmP?=
 =?us-ascii?Q?SpOB5G6Rh47/SNzFh8XPloCPkPrX7mhh5ddCvCModxQsoBtLyass7+lKaWjt?=
 =?us-ascii?Q?xSW2pf7nuLPbIooAnz4nAyg32At1dXMERrjLCM/aBOATa/dp7jKX/I6Apmgb?=
 =?us-ascii?Q?wArBlP2XCWNhwHvsF2wZmKTiHjFzMQmfzRncPY1OCqf9qzAB9AmIPmacWJxW?=
 =?us-ascii?Q?R12fILjvEBEw5FFG4XvuE0pCFfqoTQDVN/C/Cs31iC9Ldl+Uw5YMd4mDl2nk?=
 =?us-ascii?Q?hNcXROkFKDbSASvfYnLGwCqfksEQCTNPYfIQ11xUC0v7LR6ZKnIYZ74g4XNs?=
 =?us-ascii?Q?eIqTktUG6HjPNsCz5VUtIr8P3g42gtVyjgZFU2ReLk5dk6OcdYNXur/LnxTp?=
 =?us-ascii?Q?8kuCbHL5JZXm3qqyu7lYSFqrS8Sg2Qxff3ZbJi5ioAgbV8/SQEp1+60aD4Hp?=
 =?us-ascii?Q?ukQGyI4VgLsXikgvS3BiwMzX+KoJ9IPcBiuz3DAKlg5YNkmcYjtNPhSiWCNb?=
 =?us-ascii?Q?viRvZWUQarhz8n9ENjEk8TZ9u9ZAE1219ZETbzeo7eFPbDoECWKPWFGvuN3S?=
 =?us-ascii?Q?zAa/er8m0p/DkPgRfGz5oW+KROhdGUaTp3wo5qkGe33RTkeUZ6DZmuQ3Sa9x?=
 =?us-ascii?Q?0Or2p+lYeMwtNGpNsox+6+QoRRaICsgsQmnXsb+r/FPT/+e99yBHXF4wp68B?=
 =?us-ascii?Q?oK5X5KYKApuTF0dCZs0PSS5c/F8QfpOqsrTmYIwrRMyRQqHKyNE8Aj+RaKWm?=
 =?us-ascii?Q?44Q6uzeMSly0NW/iXz2jgSaUnI2tW7LkNrWwG5niQnzlQbQoBCy3INlhfwTR?=
 =?us-ascii?Q?qU80AU/zaTZ0AYlTSki9Zlg0k0iP5v50n8MJ7m3+IX8RPcN33RtuI3zRHeF+?=
 =?us-ascii?Q?HQvko99cy3iMQKYHZFpLPKwxE7fNXD26HEffG2p2z9XNcIFjPprMSCObh/6E?=
 =?us-ascii?Q?zgKTsKJJlm9A/dfKljJyvlmxqGElCcuzLIxw93Clp/SDOtbKoW1ZDoT4uvNB?=
 =?us-ascii?Q?64tkMGcJZnfD8E4mUoy4IKyzY8cGDOGqo9It8mKLCi1fa4fYxn9M/uoVJ5Y9?=
 =?us-ascii?Q?xqqo0O/dLJnhLlu68wHC6SeHRgT5zEfvPOsmCtHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b479d7c7-71bc-4226-65f8-08dd18a5aba1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:03:18.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJrBeRtS2Q/jXIjGAAg/fwbXpOUODWDCafM93LKarnFsVkpMGBMqcMJlBsMQ5rlsYdZuL/tlzFQpwue5U4HEOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

No functional change, Only rearrange the code to move the built-in CPU
idle selection logic to a separate file.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 MAINTAINERS             |   1 +
 kernel/sched/ext.c      | 876 +---------------------------------------
 kernel/sched/ext_idle.c | 845 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 865 insertions(+), 857 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..02960d1b9ee9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20909,6 +20909,7 @@ T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
 F:	include/linux/sched/ext.h
 F:	kernel/sched/ext.h
 F:	kernel/sched/ext.c
+F:	kernel/sched/ext_idle.c
 F:	tools/sched_ext/
 F:	tools/testing/selftests/sched_ext
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ea7cc481782c..e57403973a6b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+// SPDX-License-Identifier: GPL-2.0
 /*
  * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
  *
@@ -6,6 +6,8 @@
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
+#include <linux/btf_ids.h>
+
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 
 enum scx_consts {
@@ -890,16 +892,21 @@ static bool scx_warned_zero_slice;
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
-
-#ifdef CONFIG_SMP
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
-#endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
 
+#define scx_ops_error_kind(err, fmt, args...)					\
+	scx_ops_exit_kind((err), 0, fmt, ##args)
+
+#define scx_ops_exit(code, fmt, args...)					\
+	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
+
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
+
+#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
+
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info *scx_exit_info;
 
@@ -930,90 +937,10 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
 
 static struct delayed_work scx_watchdog_work;
 
-/* idle tracking */
-#ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
-struct idle_cpumask {
-	cpumask_var_t cpu;
-	cpumask_var_t smt;
-};
-
-/*
- * cpumasks to track idle CPUs within each NUMA node.
- *
- * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
- * from node 0 is used to track all idle CPUs system-wide.
- */
-static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
-
-static struct cpumask *get_idle_cpumask_node(int node)
-{
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
-		return idle_masks[0]->cpu;
-
-	if (node < 0 || node >= num_possible_nodes())
-		return NULL;
-	return idle_masks[node]->cpu;
-}
-
-static struct cpumask *get_idle_smtmask_node(int node)
-{
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
-		return idle_masks[0]->smt;
-
-	if (node < 0 || node >= num_possible_nodes())
-		return NULL;
-	return idle_masks[node]->smt;
-}
-
-static struct cpumask *get_curr_idle_cpumask(void)
-{
-	int node = cpu_to_node(smp_processor_id());
-
-	return get_idle_cpumask_node(node);
-}
-
-static struct cpumask *get_curr_idle_smtmask(void)
-{
-	int node = cpu_to_node(smp_processor_id());
-
-	if (sched_smt_active())
-		return get_idle_smtmask_node(node);
-	else
-		return get_idle_cpumask_node(node);
-}
-
-static void idle_masks_init(void)
-{
-	int node;
-
-	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
-	BUG_ON(!idle_masks);
-
-	for_each_node_state(node, N_POSSIBLE) {
-		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
-		BUG_ON(!idle_masks[node]);
-
-		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
-	}
-}
-#else	/* !CONFIG_SMP */
-static struct cpumask *get_curr_idle_cpumask(void)
-{
-	return cpu_none_mask;
-}
-
-static struct cpumask *get_curr_idle_smtmask(void)
+static bool scx_rq_bypassing(struct rq *rq)
 {
-	return cpu_none_mask;
+	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
 }
-#endif	/* CONFIG_SMP */
 
 /* for %SCX_KICK_WAIT */
 static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
@@ -1101,17 +1028,6 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
 					     const char *fmt, ...);
 
-#define scx_ops_error_kind(err, fmt, args...)					\
-	scx_ops_exit_kind((err), 0, fmt, ##args)
-
-#define scx_ops_exit(code, fmt, args...)					\
-	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
-
-#define scx_ops_error(fmt, args...)						\
-	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
-
-#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
-
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 {
 	if (time_after(at, now))
@@ -1555,11 +1471,6 @@ static bool scx_ops_tryset_enable_state(enum scx_ops_enable_state to,
 	return atomic_try_cmpxchg(&scx_ops_enable_state_var, &from_v, to);
 }
 
-static bool scx_rq_bypassing(struct rq *rq)
-{
-	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
-}
-
 /**
  * wait_ops_state - Busy-wait the specified ops state to end
  * @p: target task
@@ -1618,6 +1529,9 @@ static int ops_sanitize_err(const char *ops_name, s32 err)
 	return -EPROTO;
 }
 
+/* Built-in idle CPU tracking */
+#include "ext_idle.c"
+
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
@@ -3241,421 +3155,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 #endif	/* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SMP
-
-static bool test_and_clear_cpu_idle(int cpu)
-{
-	int node = cpu_to_node(cpu);
-	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
-
-#ifdef CONFIG_SCHED_SMT
-	/*
-	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
-	 * cluster is not wholly idle either way. This also prevents
-	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
-	 */
-	if (sched_smt_active()) {
-		const struct cpumask *smt = cpu_smt_mask(cpu);
-		struct cpumask *idle_smt = get_idle_smtmask_node(node);
-
-		/*
-		 * If offline, @cpu is not its own sibling and
-		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from the idle SMT mask. Ensure that
-		 * @cpu is eventually cleared.
-		 *
-		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
-		 * reduce memory writes, which may help alleviate cache
-		 * coherence pressure.
-		 */
-		if (cpumask_intersects(smt, idle_smt))
-			cpumask_andnot(idle_smt, idle_smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_smt))
-			__cpumask_clear_cpu(cpu, idle_smt);
-	}
-#endif
-	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
-}
-
-static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
-{
-	int cpu;
-
-retry:
-	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
-		if (cpu < nr_cpu_ids)
-			goto found;
-
-		if (flags & SCX_PICK_IDLE_CORE)
-			return -EBUSY;
-	}
-
-	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
-	if (cpu < nr_cpu_ids)
-		goto found;
-
-	return -EBUSY;
-
-found:
-	if (test_and_clear_cpu_idle(cpu))
-		return cpu;
-	else
-		goto retry;
-
-}
-
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
-{
-	const struct cpumask *node_mask;
-	s32 cpu;
-
-	/*
-	 * Only node 0 is used if per-node idle cpumasks are disabled.
-	 */
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
-		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
-
-	/*
-	 * Traverse all nodes in order of increasing distance, starting from
-	 * prev_cpu's node.
-	 */
-	rcu_read_lock();
-	for_each_numa_hop_mask(node_mask, cpu_to_node(prev_cpu)) {
-		/*
-		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
-		 * if none of the CPUs in the NUMA node can be used (according
-		 * to cpus_allowed).
-		 *
-		 * Therefore, check if the NUMA node is usable in advance to
-		 * save some CPU cycles.
-		 */
-		if (!cpumask_intersects(node_mask, cpus_allowed))
-			continue;
-
-		/*
-		 * It would be nice to have a "node" iterator, instead of the
-		 * cpumask, to get rid of the cpumask_first() to determine the
-		 * node.
-		 */
-		cpu = cpumask_first(node_mask);
-		if (cpu >= nr_cpu_ids)
-			continue;
-
-		cpu = scx_pick_idle_cpu_from_node(cpu_to_node(cpu), cpus_allowed, flags);
-		if (cpu >= 0)
-			goto out_unlock;
-	}
-	cpu = -EBUSY;
-
-out_unlock:
-	rcu_read_unlock();
-	return cpu;
-}
-
-/*
- * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
- * domain is not defined).
- */
-static unsigned int llc_weight(s32 cpu)
-{
-	struct sched_domain *sd;
-
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (!sd)
-		return 0;
-
-	return sd->span_weight;
-}
-
-/*
- * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
- * domain is not defined).
- */
-static struct cpumask *llc_span(s32 cpu)
-{
-	struct sched_domain *sd;
-
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (!sd)
-		return 0;
-
-	return sched_domain_span(sd);
-}
-
-/*
- * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
- * NUMA domain is not defined).
- */
-static unsigned int numa_weight(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return 0;
-	sg = sd->groups;
-	if (!sg)
-		return 0;
-
-	return sg->group_weight;
-}
-
-/*
- * Return true if the LLC domains do not perfectly overlap with the NUMA
- * domains, false otherwise.
- */
-static bool llc_numa_mismatch(void)
-{
-	int cpu;
-
-	/*
-	 * We need to scan all online CPUs to verify whether their scheduling
-	 * domains overlap.
-	 *
-	 * While it is rare to encounter architectures with asymmetric NUMA
-	 * topologies, CPU hotplugging or virtualized environments can result
-	 * in asymmetric configurations.
-	 *
-	 * For example:
-	 *
-	 *  NUMA 0:
-	 *    - LLC 0: cpu0..cpu7
-	 *    - LLC 1: cpu8..cpu15 [offline]
-	 *
-	 *  NUMA 1:
-	 *    - LLC 0: cpu16..cpu23
-	 *    - LLC 1: cpu24..cpu31
-	 *
-	 * In this case, if we only check the first online CPU (cpu0), we might
-	 * incorrectly assume that the LLC and NUMA domains are fully
-	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
-	 * domains).
-	 */
-	for_each_online_cpu(cpu)
-		if (llc_weight(cpu) != numa_weight(cpu))
-			return true;
-
-	return false;
-}
-
-/*
- * Initialize topology-aware scheduling.
- *
- * Detect if the system has multiple LLC or multiple NUMA domains and enable
- * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
- * selection policy.
- *
- * Assumption: the kernel's internal topology representation assumes that each
- * CPU belongs to a single LLC domain, and that each LLC domain is entirely
- * contained within a single NUMA node.
- */
-static void update_selcpu_topology(struct sched_ext_ops *ops)
-{
-	bool enable_llc = false;
-	unsigned int nr_cpus;
-	s32 cpu = cpumask_first(cpu_online_mask);
-
-	/*
-	 * Enable LLC domain optimization only when there are multiple LLC
-	 * domains among the online CPUs. If all online CPUs are part of a
-	 * single LLC domain, the idle CPU selection logic can choose any
-	 * online CPU without bias.
-	 *
-	 * Note that it is sufficient to check the LLC domain of the first
-	 * online CPU to determine whether a single LLC domain includes all
-	 * CPUs.
-	 */
-	rcu_read_lock();
-	nr_cpus = llc_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus())
-			enable_llc = true;
-		/*
-		 * No need to enable LLC optimization if the LLC domains are
-		 * perfectly overlapping with the NUMA domains when per-node
-		 * cpumasks are enabled.
-		 */
-		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
-		    !llc_numa_mismatch())
-			enable_llc = false;
-		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
-			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
-	}
-	rcu_read_unlock();
-
-	pr_debug("sched_ext: LLC idle selection %s\n",
-		 enable_llc ? "enabled" : "disabled");
-
-	if (enable_llc)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
-	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
-
-	/*
-	 * Check if we need to enable per-node cpumasks.
-	 */
-	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
-		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
-	else
-		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
-}
-
-/*
- * Built-in CPU idle selection policy:
- *
- * 1. Prioritize full-idle cores:
- *   - always prioritize CPUs from fully idle cores (both logical CPUs are
- *     idle) to avoid interference caused by SMT.
- *
- * 2. Reuse the same CPU:
- *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
- *     branch prediction optimizations.
- *
- * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
- *
- * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
- *
- * Step 3 is performed only if the system has multiple LLC domains that are not
- * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
- *
- * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
- * we never call ops.select_cpu() for them, see select_task_rq().
- */
-static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-			      u64 wake_flags, bool *found)
-{
-	const struct cpumask *llc_cpus = NULL;
-	int node = cpu_to_node(prev_cpu);
-	s32 cpu;
-
-	*found = false;
-
-	/*
-	 * This is necessary to protect llc_cpus.
-	 */
-	rcu_read_lock();
-
-	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
-	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus())
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
-
-	/*
-	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
-	 */
-	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
-
-		/*
-		 * If the waker's CPU is cache affine and prev_cpu is idle,
-		 * then avoid a migration.
-		 */
-		if (cpus_share_cache(cpu, prev_cpu) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
-		/*
-		 * If the waker's local DSQ is empty, and the system is under
-		 * utilized, try to wake up @p to the local DSQ of the waker.
-		 *
-		 * Checking only for an empty local DSQ is insufficient as it
-		 * could give the wakee an unfair advantage when the system is
-		 * oversaturated.
-		 *
-		 * Checking only for the presence of idle CPUs is also
-		 * insufficient as the local DSQ of the waker could have tasks
-		 * piled up on it even if there is an idle core elsewhere on
-		 * the system.
-		 */
-		if (!(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
-		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
-				goto cpu_found;
-		}
-	}
-
-	/*
-	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
-	 * partially idle @prev_cpu.
-	 */
-	if (sched_smt_active()) {
-		/*
-		 * Keep using @prev_cpu if it's part of a fully idle core.
-		 */
-		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
-		/*
-		 * Search for any fully idle core in the same LLC domain.
-		 */
-		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
-		/*
-		 * Search for any full idle core usable by the task.
-		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Use @prev_cpu if it's idle.
-	 */
-	if (test_and_clear_cpu_idle(prev_cpu)) {
-		cpu = prev_cpu;
-		goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU in the same LLC domain.
-	 */
-	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU usable by the task.
-	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
-	if (cpu >= 0)
-		goto cpu_found;
-
-	rcu_read_unlock();
-	return prev_cpu;
-
-cpu_found:
-	rcu_read_unlock();
-
-	*found = true;
-	return cpu;
-}
-
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
 {
 	/*
@@ -3722,66 +3221,6 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 (struct cpumask *)p->cpus_ptr);
 }
 
-static void reset_idle_masks(void)
-{
-	int node;
-
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
-		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
-		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
-		return;
-	}
-
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	for_each_node_state(node, N_POSSIBLE) {
-		const struct cpumask *node_mask = cpumask_of_node(node);
-		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
-		struct cpumask *idle_smt = get_idle_smtmask_node(node);
-
-		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
-		cpumask_copy(idle_smt, idle_cpu);
-	}
-}
-
-void __scx_update_idle(struct rq *rq, bool idle)
-{
-	int cpu = cpu_of(rq);
-	int node = cpu_to_node(cpu);
-	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
-
-	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
-		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
-		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
-			return;
-	}
-
-	assign_cpu(cpu, idle_cpu, idle);
-
-#ifdef CONFIG_SCHED_SMT
-	if (sched_smt_active()) {
-		const struct cpumask *smt = cpu_smt_mask(cpu);
-		struct cpumask *idle_smt = get_idle_smtmask_node(node);
-
-		if (idle) {
-			/*
-			 * idle_smt handling is racy but that's fine as it's
-			 * only for optimization and self-correcting.
-			 */
-			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_cpu))
-					return;
-			}
-			cpumask_or(idle_smt, idle_smt, smt);
-		} else {
-			cpumask_andnot(idle_smt, idle_smt, smt);
-		}
-	}
-#endif
-}
-
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	int cpu = cpu_of(rq);
@@ -3820,16 +3259,6 @@ static void rq_offline_scx(struct rq *rq)
 {
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 }
-
-#else	/* CONFIG_SMP */
-
-static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
-{
-	return -EBUSY;
-}
-static void reset_idle_masks(void) {}
-
 #endif	/* CONFIG_SMP */
 
 static bool check_rq_for_timeouts(struct rq *rq)
@@ -6390,59 +5819,6 @@ void __init init_sched_ext_class(void)
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 }
 
-
-/********************************************************************************
- * Helpers that can be called from the BPF scheduler.
- */
-#include <linux/btf_ids.h>
-
-__bpf_kfunc_start_defs();
-
-/**
- * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
- * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
- * @is_idle: out parameter indicating whether the returned CPU is idle
- *
- * Can only be called from ops.select_cpu() if the built-in CPU selection is
- * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
- *
- * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
- * currently idle and thus a good candidate for direct dispatching.
- */
-__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-				       u64 wake_flags, bool *is_idle)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		goto prev_cpu;
-	}
-
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
-		goto prev_cpu;
-
-#ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
-#endif
-
-prev_cpu:
-	*is_idle = false;
-	return prev_cpu;
-}
-
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
-BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
-
-static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_select_cpu,
-};
-
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
 	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
@@ -7514,211 +6890,6 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
-/**
- * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask of a target NUMA node.
- *
- * Returns an empty cpumask if idle tracking is not enabled, if @node is not
- * valid, or running on a UP kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return cpu_none_mask;
-	}
-	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
-		scx_ops_error("per-node idle tracking is disabled");
-		return cpu_none_mask;
-	}
-
-	return get_idle_cpumask_node(node) ? : cpu_none_mask;
-}
-/**
- * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask of the current NUMA node.
- *
- * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
- * kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return cpu_none_mask;
-	}
-
-	return get_curr_idle_cpumask();
-}
-
-/**
- * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask of a target NUMA node. Can be used to determine
- * if an entire physical core is free.
- *
- * Returns an empty cpumask if idle tracking is not enabled, if @node is not
- * valid, or running on a UP kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return cpu_none_mask;
-	}
-	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
-		scx_ops_error("per-node idle tracking is disabled");
-		return cpu_none_mask;
-	}
-
-	return get_idle_smtmask_node(node) ? : cpu_none_mask;
-}
-
-/**
- * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask of the current NUMA node. Can be used to determine
- * if an entire physical core is free.
- *
- * Returns an empty cumask if idle tracking is not enabled, or running on a UP
- * kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return cpu_none_mask;
-	}
-
-	return get_curr_idle_smtmask();
-}
-
-/**
- * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
- * either the percpu, or SMT idle-tracking cpumask.
- */
-__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
-{
-	/*
-	 * Empty function body because we aren't actually acquiring or releasing
-	 * a reference to a global idle cpumask, which is read-only in the
-	 * caller and is never released. The acquire / release semantics here
-	 * are just used to make the cpumask a trusted pointer in the caller.
-	 */
-}
-
-/**
- * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
- * @cpu: cpu to test and clear idle for
- *
- * Returns %true if @cpu was idle and its idle state was successfully cleared.
- * %false otherwise.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
- */
-__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return false;
-	}
-
-	if (ops_cpu_valid(cpu, NULL))
-		return test_and_clear_cpu_idle(cpu);
-	else
-		return false;
-}
-
-/**
- * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
- * @node: target NUMA node
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
- * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
- * was found.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
- * not set.
- */
-__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
-				      u64 flags)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return -EBUSY;
-	}
-	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
-		scx_ops_error("per-node idle tracking is disabled");
-		return -EBUSY;
-	}
-
-	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
-}
-
-/**
- * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
- * number on success. -%EBUSY if no matching cpu was found.
- *
- * Idle CPU tracking may race against CPU scheduling state transitions. For
- * example, this function may return -%EBUSY as CPUs are transitioning into the
- * idle state. If the caller then assumes that there will be dispatch events on
- * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
- * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
- * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
- * event in the near future.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
- */
-__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
-				      u64 flags)
-{
-	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
-		scx_ops_error("built-in idle tracking is disabled");
-		return -EBUSY;
-	}
-
-	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
-}
-
-/**
- * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
- * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
- * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
- * empty.
- *
- * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
- * set, this function can't tell which CPUs are idle and will always pick any
- * CPU.
- */
-__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
-				     u64 flags)
-{
-	s32 cpu;
-
-	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
-		if (cpu >= 0)
-			return cpu;
-	}
-
-	cpu = cpumask_any_distribute(cpus_allowed);
-	if (cpu < nr_cpu_ids)
-		return cpu;
-	else
-		return -EBUSY;
-}
-
 /**
  * scx_bpf_task_running - Is task currently running?
  * @p: task of interest
@@ -7797,15 +6968,6 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
-BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
-BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
new file mode 100644
index 000000000000..8a9fe8bd3e52
--- /dev/null
+++ b/kernel/sched/ext_idle.c
@@ -0,0 +1,845 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * Built-in idle CPU tracking policy.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
+ */
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+
+#ifdef CONFIG_SMP
+#ifdef CONFIG_CPUMASK_OFFSTACK
+#define CL_ALIGNED_IF_ONSTACK
+#else
+#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
+#endif
+
+struct idle_cpumask {
+	cpumask_var_t cpu;
+	cpumask_var_t smt;
+};
+
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
+
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->cpu;
+
+	if (node < 0 || node >= num_possible_nodes())
+		return NULL;
+	return idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return idle_masks[0]->smt;
+
+	if (node < 0 || node >= num_possible_nodes())
+		return NULL;
+	return idle_masks[node]->smt;
+}
+
+static struct cpumask *get_curr_idle_cpumask(void)
+{
+	int node = cpu_to_node(smp_processor_id());
+
+	return get_idle_cpumask_node(node);
+}
+
+static struct cpumask *get_curr_idle_smtmask(void)
+{
+	int node = cpu_to_node(smp_processor_id());
+
+	if (sched_smt_active())
+		return get_idle_smtmask_node(node);
+	else
+		return get_idle_cpumask_node(node);
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
+	BUG_ON(!idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
+		BUG_ON(!idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
+
+static bool test_and_clear_cpu_idle(int cpu)
+{
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
+	 * cluster is not wholly idle either way. This also prevents
+	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
+	 */
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		/*
+		 * If offline, @cpu is not its own sibling and
+		 * scx_pick_idle_cpu() can get caught in an infinite loop as
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
+		 */
+		if (cpumask_intersects(smt, idle_smt))
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_smt))
+			__cpumask_clear_cpu(cpu, idle_smt);
+	}
+#endif
+	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
+}
+
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
+{
+	int cpu;
+
+retry:
+	if (sched_smt_active()) {
+		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
+		if (cpu < nr_cpu_ids)
+			goto found;
+
+		if (flags & SCX_PICK_IDLE_CORE)
+			return -EBUSY;
+	}
+
+	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		goto found;
+
+	return -EBUSY;
+
+found:
+	if (test_and_clear_cpu_idle(cpu))
+		return cpu;
+	goto retry;
+
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	const struct cpumask *node_mask;
+	s32 cpu;
+
+	/*
+	 * Only node 0 is used if per-node idle cpumasks are disabled.
+	 */
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
+
+	/*
+	 * Traverse all nodes in order of increasing distance, starting from
+	 * prev_cpu's node.
+	 */
+	rcu_read_lock();
+	for_each_numa_hop_mask(node_mask, cpu_to_node(prev_cpu)) {
+		/*
+		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
+		 * if none of the CPUs in the NUMA node can be used (according
+		 * to cpus_allowed).
+		 *
+		 * Therefore, check if the NUMA node is usable in advance to
+		 * save some CPU cycles.
+		 */
+		if (!cpumask_intersects(node_mask, cpus_allowed))
+			continue;
+
+		/*
+		 * It would be nice to have a "node" iterator, instead of the
+		 * cpumask, to get rid of the cpumask_first() to determine the
+		 * node.
+		 */
+		cpu = cpumask_first(node_mask);
+		if (cpu >= nr_cpu_ids)
+			continue;
+
+		cpu = scx_pick_idle_cpu_from_node(cpu_to_node(cpu), cpus_allowed, flags);
+		if (cpu >= 0)
+			goto out_unlock;
+	}
+	cpu = -EBUSY;
+
+out_unlock:
+	rcu_read_unlock();
+	return cpu;
+}
+
+/*
+ * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
+ * domain is not defined).
+ */
+static unsigned int llc_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sd->span_weight;
+}
+
+/*
+ * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
+ * domain is not defined).
+ */
+static struct cpumask *llc_span(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sched_domain_span(sd);
+}
+
+/*
+ * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
+ * NUMA domain is not defined).
+ */
+static unsigned int numa_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+
+	sd = rcu_dereference(per_cpu(sd_numa, cpu));
+	if (!sd)
+		return 0;
+	sg = sd->groups;
+	if (!sg)
+		return 0;
+
+	return sg->group_weight;
+}
+
+/*
+ * Return true if the LLC domains do not perfectly overlap with the NUMA
+ * domains, false otherwise.
+ */
+static bool llc_numa_mismatch(void)
+{
+	int cpu;
+
+	/*
+	 * We need to scan all online CPUs to verify whether their scheduling
+	 * domains overlap.
+	 *
+	 * While it is rare to encounter architectures with asymmetric NUMA
+	 * topologies, CPU hotplugging or virtualized environments can result
+	 * in asymmetric configurations.
+	 *
+	 * For example:
+	 *
+	 *  NUMA 0:
+	 *    - LLC 0: cpu0..cpu7
+	 *    - LLC 1: cpu8..cpu15 [offline]
+	 *
+	 *  NUMA 1:
+	 *    - LLC 0: cpu16..cpu23
+	 *    - LLC 1: cpu24..cpu31
+	 *
+	 * In this case, if we only check the first online CPU (cpu0), we might
+	 * incorrectly assume that the LLC and NUMA domains are fully
+	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
+	 * domains).
+	 */
+	for_each_online_cpu(cpu)
+		if (llc_weight(cpu) != numa_weight(cpu))
+			return true;
+
+	return false;
+}
+
+/*
+ * Initialize topology-aware scheduling.
+ *
+ * Detect if the system has multiple LLC or multiple NUMA domains and enable
+ * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
+ * selection policy.
+ *
+ * Assumption: the kernel's internal topology representation assumes that each
+ * CPU belongs to a single LLC domain, and that each LLC domain is entirely
+ * contained within a single NUMA node.
+ */
+static void update_selcpu_topology(struct sched_ext_ops *ops)
+{
+	bool enable_llc = false;
+	unsigned int nr_cpus;
+	s32 cpu = cpumask_first(cpu_online_mask);
+
+	/*
+	 * Enable LLC domain optimization only when there are multiple LLC
+	 * domains among the online CPUs. If all online CPUs are part of a
+	 * single LLC domain, the idle CPU selection logic can choose any
+	 * online CPU without bias.
+	 *
+	 * Note that it is sufficient to check the LLC domain of the first
+	 * online CPU to determine whether a single LLC domain includes all
+	 * CPUs.
+	 */
+	rcu_read_lock();
+	nr_cpus = llc_weight(cpu);
+	if (nr_cpus > 0) {
+		if (nr_cpus < num_online_cpus())
+			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
+		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
+			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
+	}
+	rcu_read_unlock();
+
+	pr_debug("sched_ext: LLC idle selection %s\n",
+		 enable_llc ? "enabled" : "disabled");
+
+	if (enable_llc)
+		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
+	else
+		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
+}
+
+/*
+ * Built-in CPU idle selection policy:
+ *
+ * 1. Prioritize full-idle cores:
+ *   - always prioritize CPUs from fully idle cores (both logical CPUs are
+ *     idle) to avoid interference caused by SMT.
+ *
+ * 2. Reuse the same CPU:
+ *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
+ *     branch prediction optimizations.
+ *
+ * 3. Pick a CPU within the same LLC (Last-Level Cache):
+ *   - if the above conditions aren't met, pick a CPU that shares the same LLC
+ *     to maintain cache locality.
+ *
+ * 4. Pick a CPU within the same NUMA node, if enabled:
+ *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *
+ * Step 3 is performed only if the system has multiple LLC domains that are not
+ * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
+ *
+ * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
+ * we never call ops.select_cpu() for them, see select_task_rq().
+ */
+static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+			      u64 wake_flags, bool *found)
+{
+	const struct cpumask *llc_cpus = NULL;
+	int node = cpu_to_node(prev_cpu);
+	s32 cpu;
+
+	*found = false;
+
+	/*
+	 * This is necessary to protect llc_cpus.
+	 */
+	rcu_read_lock();
+
+	/*
+	 * Determine the scheduling domain only if the task is allowed to run
+	 * on all CPUs.
+	 *
+	 * This is done primarily for efficiency, as it avoids the overhead of
+	 * updating a cpumask every time we need to select an idle CPU (which
+	 * can be costly in large SMP systems), but it also aligns logically:
+	 * if a task's scheduling domain is restricted by user-space (through
+	 * CPU affinity), the task will simply use the flat scheduling domain
+	 * defined by user-space.
+	 */
+	if (p->nr_cpus_allowed >= num_possible_cpus())
+		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+			llc_cpus = llc_span(prev_cpu);
+
+	/*
+	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
+	 */
+	if (wake_flags & SCX_WAKE_SYNC) {
+		cpu = smp_processor_id();
+
+		/*
+		 * If the waker's CPU is cache affine and prev_cpu is idle,
+		 * then avoid a migration.
+		 */
+		if (cpus_share_cache(cpu, prev_cpu) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		/*
+		 * If the waker's local DSQ is empty, and the system is under
+		 * utilized, try to wake up @p to the local DSQ of the waker.
+		 *
+		 * Checking only for an empty local DSQ is insufficient as it
+		 * could give the wakee an unfair advantage when the system is
+		 * oversaturated.
+		 *
+		 * Checking only for the presence of idle CPUs is also
+		 * insufficient as the local DSQ of the waker could have tasks
+		 * piled up on it even if there is an idle core elsewhere on
+		 * the system.
+		 */
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+				goto cpu_found;
+		}
+	}
+
+	/*
+	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
+	 * partially idle @prev_cpu.
+	 */
+	if (sched_smt_active()) {
+		/*
+		 * Keep using @prev_cpu if it's part of a fully idle core.
+		 */
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		/*
+		 * Search for any fully idle core in the same LLC domain.
+		 */
+		if (llc_cpus) {
+			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
+		/*
+		 * Search for any full idle core usable by the task.
+		 */
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Use @prev_cpu if it's idle.
+	 */
+	if (test_and_clear_cpu_idle(prev_cpu)) {
+		cpu = prev_cpu;
+		goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU in the same LLC domain.
+	 */
+	if (llc_cpus) {
+		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU usable by the task.
+	 */
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
+	if (cpu >= 0)
+		goto cpu_found;
+
+	rcu_read_unlock();
+	return prev_cpu;
+
+cpu_found:
+	rcu_read_unlock();
+
+	*found = true;
+	return cpu;
+}
+
+static void reset_idle_masks(void)
+{
+	int node;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
+		return;
+	}
+
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smt, idle_cpu);
+	}
+}
+
+void __scx_update_idle(struct rq *rq, bool idle)
+{
+	int cpu = cpu_of(rq);
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
+	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
+		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
+			return;
+	}
+
+	assign_cpu(cpu, idle_cpu, idle);
+
+#ifdef CONFIG_SCHED_SMT
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		if (idle) {
+			/*
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
+			 */
+			for_each_cpu(cpu, smt) {
+				if (!cpumask_test_cpu(cpu, idle_cpu))
+					return;
+			}
+			cpumask_or(idle_smt, idle_smt, smt);
+		} else {
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		}
+	}
+#endif	/* CONFIG_SCHED_SMT */
+}
+#else	/* !CONFIG_SMP */
+static struct cpumask *get_curr_idle_cpumask(void)
+{
+	return cpu_none_mask;
+}
+
+static struct cpumask *get_curr_idle_smtmask(void)
+{
+	return cpu_none_mask;
+}
+
+static bool test_and_clear_cpu_idle(int cpu) { return false; }
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	return -EBUSY;
+}
+
+static void reset_idle_masks(void) {}
+#endif	/* CONFIG_SMP */
+
+/********************************************************************************
+ * Helpers that can be called from the BPF scheduler.
+ */
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+				       u64 wake_flags, bool *is_idle)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		goto prev_cpu;
+	}
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
+		goto prev_cpu;
+
+#ifdef CONFIG_SMP
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+#endif
+
+prev_cpu:
+	*is_idle = false;
+	return prev_cpu;
+}
+
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_cpumask_node(node) ? : cpu_none_mask;
+}
+/**
+ * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of the current NUMA node.
+ *
+ * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
+ * kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_curr_idle_cpumask();
+}
+
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of a target NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_idle_smtmask_node(node) ? : cpu_none_mask;
+}
+
+/**
+ * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cumask if idle tracking is not enabled, or running on a UP
+ * kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return cpu_none_mask;
+	}
+
+	return get_curr_idle_smtmask();
+}
+
+/**
+ * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
+ * either the percpu, or SMT idle-tracking cpumask.
+ */
+__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
+{
+	/*
+	 * Empty function body because we aren't actually acquiring or releasing
+	 * a reference to a global idle cpumask, which is read-only in the
+	 * caller and is never released. The acquire / release semantics here
+	 * are just used to make the cpumask a trusted pointer in the caller.
+	 */
+}
+
+/**
+ * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
+ * @cpu: cpu to test and clear idle for
+ *
+ * Returns %true if @cpu was idle and its idle state was successfully cleared.
+ * %false otherwise.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return false;
+	}
+
+	if (ops_cpu_valid(cpu, NULL))
+		return test_and_clear_cpu_idle(cpu);
+	else
+		return false;
+}
+
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @node: target NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
+ * was found.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
+ * not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
+		scx_ops_error("per-node idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+}
+
+/**
+ * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
+ * number on success. -%EBUSY if no matching cpu was found.
+ *
+ * Idle CPU tracking may race against CPU scheduling state transitions. For
+ * example, this function may return -%EBUSY as CPUs are transitioning into the
+ * idle state. If the caller then assumes that there will be dispatch events on
+ * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
+ * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
+ * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
+ * event in the near future.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!static_branch_likely(&scx_builtin_idle_enabled)) {
+		scx_ops_error("built-in idle tracking is disabled");
+		return -EBUSY;
+	}
+
+	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
+}
+
+/**
+ * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
+ * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
+ * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
+ * empty.
+ *
+ * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
+ * set, this function can't tell which CPUs are idle and will always pick any
+ * CPU.
+ */
+__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
+				     u64 flags)
+{
+	s32 cpu;
+
+	if (static_branch_likely(&scx_builtin_idle_enabled)) {
+		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	cpu = cpumask_any_distribute(cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		return cpu;
+	else
+		return -EBUSY;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_select_cpu,
+};
-- 
2.47.1


