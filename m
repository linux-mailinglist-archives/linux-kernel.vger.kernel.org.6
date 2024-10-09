Return-Path: <linux-kernel+bounces-359341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3031998A63
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F91D1F2A51D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7CA42A8C;
	Thu, 10 Oct 2024 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FEpg/DDd"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA41CBE83
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571044; cv=fail; b=XAhiXyjQtSDnT6okkQbmVvLjVvIR163CpaVKk5Rl+feVi1hPYClaf048nKaLCEs1DBEd4/qESQ0cz9Oml7ZNUHlMeSpgv3P3Q/q1jwlQSaBN/ccoRTxLE147y8vHTsBQy7oOUy9T9BRWr+qYcGLyCg6NuxbV4w0clhnr3sl9dSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571044; c=relaxed/simple;
	bh=TRsycoyyjEwerWQwChe+8WNhA9QBgdpZIKEe3vuDw8o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2uy0FPiQtcvc8Zji8KP9nuyog4hhzqiSuPmxfDP955qcGlKgkakS6EjhakFgj72SSd65sBLcfQ4rm0ZWjo6pNCoXvC3picw9aGf99pRuT9/wPVndnh39764gq15s9J2V+MQIeGJtZ8dWHvUFV9SQif63rvSbS5NuK8KuJIl410=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FEpg/DDd; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inl+LC515Bj16BFJhI1PFGK36yOAwpMXHsLevPGBUVO1E6jLEGHR+EbbBoS+6xNSDUH7nxDphvrGQzPQ+bGGE73SnVrkBUos4e1FKUX3dx6ZZRCWzUi9vU5DP+utn+kyOfQ/3yrVpEmsI79YGrZ0lXzzi6RXuH7P7FQEYudq6m9aVWK8ogsFL9Fevf0W5BjHMFVOH34gUnccrilNxeU/zwciNCoa3Nl/PEbPBQrHNxRz5lLqegGrErIgwFGlf2JgZGbEIq5tbGrQ4kMY/jdJvTGE1AK/myYUHxMjGujMOUU6IuucEVT6sLbd62pdgLoHwCDvDcgFe0KdwhigRvLH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tborzWGfPDp9YO6wd8Qo/xRfje5Zar7veGCegh2UkuQ=;
 b=aKY2q+Bjogos+citL/Oz8n98ZORR/+6+pUi5/Fly/LgroXpnL/Gx29/VxgyZ7pdyxNouHz5yG56Ka33dcRMNXbRfR40S/zlxZrumNGpBFh8XmsxfvGM237C6KzhcA2Dp2gvsTPpB7bbBOtgsUwZ59HZUBwKVir10neD145edpM1jUndHYNa9m0IjFioyGl2MFeiCHEBH8ULjTazezq6tsYeSyIgx0e60sGQh51Zl31d3728Tvfa4ORPqlZiXgivkHCNStp5PhEPJNYDKL8Deix2pVvlXYvRfxovpZqhyCeCyxDKTtEdheeILeTw2NW7ZNRcs2NeRa7yuHzPnv5wtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tborzWGfPDp9YO6wd8Qo/xRfje5Zar7veGCegh2UkuQ=;
 b=FEpg/DDdhK0KwQeFTsTeOuXjYzrO/Q3O9klvGXlEEhHINFjhzvgcc2EoWT7OdAj+odi3nnn9vrQvdkYdShBkXwXJBNbaiUiEuMPYmleNuklGGZ0g+hw00hMZDgWg3HL5AvRFdpSFR4N7CcyRcO3eF0gkfn8U9bMrEC/hqKibt1c=
Received: from AM9P193CA0001.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::6)
 by DU0PR02MB8093.eurprd02.prod.outlook.com (2603:10a6:10:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 14:37:14 +0000
Received: from AM3PEPF00009B9E.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::ff) by AM9P193CA0001.outlook.office365.com
 (2603:10a6:20b:21e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 14:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9E.mail.protection.outlook.com (10.167.16.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 14:37:14 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 16:37:13 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Richard Weinberger <richard@nod.at>, Zhihao Cheng
	<chengzhihao1@huawei.com>, Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Richard
 Weinberger" <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] ubifs: Fix use-after-free in ubifs_tnc_end_commit
Date: Wed, 9 Oct 2024 16:46:59 +0200
Message-ID: <1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9E:EE_|DU0PR02MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: f02a3c20-ae99-40f0-33f3-08dce93908b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Kb7G/1Z3B+v4uqFU7zPjFY3KOPZ2ETDTtw8zni10OKG7fAHDP0dxneH8bFg?=
 =?us-ascii?Q?lrbFKbRekDk5+Mo8ciR9rT3YpmguLGa04mINuyj8LIymp177pzmXg0iJZWi9?=
 =?us-ascii?Q?AvGeypeATyJ5dLucBFVv1bEu+ArEe2f+Zn0R9TJzdahgvHQ3NJuJlP58ck2K?=
 =?us-ascii?Q?C9dRhKw5F8osU1D853EIxfbZtiVJJ2wAutMUwN4SyUsH/ITSGP3OTf8V30vx?=
 =?us-ascii?Q?SWkNNZKtlG+rlULw7CAQwOb3TRbac7ZmEanWkrZODf+Pvy47xYvQyOZ4QrlY?=
 =?us-ascii?Q?7xqoARjP3IU8PE/YIQ3GFVF8aG22+7L8lyQUicFZlMP15mjzLdgb+4LQpwlC?=
 =?us-ascii?Q?oYgwN3Zt+JCwI6DuP4/fd4A5YhTB1aDTjzk4jW1+ifrEMBw9F1SPAqq8MpHV?=
 =?us-ascii?Q?zx1ZOVRe5CCyAlzaT02TnTrU3kJKhk3o5xdtT8vXHpQBUHHZuUfHjIosre0M?=
 =?us-ascii?Q?Nh5Qhtean04d0o5KZ+4lizKiXAE/3Hjs3aS477qhmzvzDLbHXnoYwxZTj9BY?=
 =?us-ascii?Q?ABaN5TzW7CwwcwjYoSXZcaOyMYOOv5soz+/IaFhz3zIExqRJyxr1gutgNdNy?=
 =?us-ascii?Q?bNxqxv4FzLQQkweyb1yc45UszRbZUhmnoM7s5M3Ez0/XgEc1/gw8mucFptUU?=
 =?us-ascii?Q?MK36QfljWjN8ysH4fEAn6em3bQ5+xKOOitEx35I5ddKR35MjSALtQpUvfDi1?=
 =?us-ascii?Q?0SNDia2JHNb/j9un4l/pSDDKocVwWh9MZkXqShuTpebqy1A9joKWhpqwqpSn?=
 =?us-ascii?Q?qPeTSWw7Z0B57BthjiIA5cmR7VJ7cuR6Dr2T8xyWjywK4tmC+d0zEyrB/LX6?=
 =?us-ascii?Q?tJ3ZQQjsrbB5yaaSvyx5rXMyfnTNakaNGqPPtrdnihof5dGUTJQH1swqYsii?=
 =?us-ascii?Q?NaxgrAbmyv5KyuYCs7ngc2h6CWfrhbBFwFSQaOxxU1HuT1S8S7CzC/hrPVkk?=
 =?us-ascii?Q?ygD7bvhRko4BzPLpVEac6lLbE04EvVCYWvysQYnSP2MEMXs94VEnrRbGcozO?=
 =?us-ascii?Q?Go7fwd4PjVQ+O5+/ogHXem0jhGgO70OujrqIOJKu2d4EBQtdA0b/cVET+l6V?=
 =?us-ascii?Q?0Pk+paGUn5K+0lW/QeS3aMZk8ZrueDhF8JPHI87gTBZLriC2tvXHEazFKGhz?=
 =?us-ascii?Q?H7c8hz7jbR2X6mSkmwl6MblCGgt8PufPNEBDghPQlE+RhL2627N5C0U2Zp03?=
 =?us-ascii?Q?BQEGJkiHMEmM51LzM+Uol/6g0+MTffxkhdreThlDCbTNoLkChOWHJoPdmmv0?=
 =?us-ascii?Q?uGLaBHPBtUrxs0HI4MirLfwig0W/SkyVc1IHPuscAFXP5G1S9Y2GclyPXZBS?=
 =?us-ascii?Q?q40kyMUwyIz5WxtFR8+WWiF1OyNX3RVJX1b1dlsXNfO1e23KAYRK5ExOjJpb?=
 =?us-ascii?Q?iyKpDvdlccAWQ2jxj0PpR3zJQR3U?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:37:14.7930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f02a3c20-ae99-40f0-33f3-08dce93908b7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8093

Running

  rm -f /etc/test-file.bin
  dd if=/dev/urandom of=/etc/test-file.bin bs=1M count=60 conv=fsync

in a loop, with `CONFIG_UBIFS_FS_AUTHENTICATION`, KASAN reports:

  BUG: KASAN: use-after-free in ubifs_tnc_end_commit+0xa5c/0x1950
  Write of size 32 at addr ffffff800a3af86c by task ubifs_bgt0_20/153

  Call trace:
   dump_backtrace+0x0/0x340
   show_stack+0x18/0x24
   dump_stack_lvl+0x9c/0xbc
   print_address_description.constprop.0+0x74/0x2b0
   kasan_report+0x1d8/0x1f0
   kasan_check_range+0xf8/0x1a0
   memcpy+0x84/0xf4
   ubifs_tnc_end_commit+0xa5c/0x1950
   do_commit+0x4e0/0x1340
   ubifs_bg_thread+0x234/0x2e0
   kthread+0x36c/0x410
   ret_from_fork+0x10/0x20

  Allocated by task 401:
   kasan_save_stack+0x38/0x70
   __kasan_kmalloc+0x8c/0xd0
   __kmalloc+0x34c/0x5bc
   tnc_insert+0x140/0x16a4
   ubifs_tnc_add+0x370/0x52c
   ubifs_jnl_write_data+0x5d8/0x870
   do_writepage+0x36c/0x510
   ubifs_writepage+0x190/0x4dc
   __writepage+0x58/0x154
   write_cache_pages+0x394/0x830
   do_writepages+0x1f0/0x5b0
   filemap_fdatawrite_wbc+0x170/0x25c
   file_write_and_wait_range+0x140/0x190
   ubifs_fsync+0xe8/0x290
   vfs_fsync_range+0xc0/0x1e4
   do_fsync+0x40/0x90
   __arm64_sys_fsync+0x34/0x50
   invoke_syscall.constprop.0+0xa8/0x260
   do_el0_svc+0xc8/0x1f0
   el0_svc+0x34/0x70
   el0t_64_sync_handler+0x108/0x114
   el0t_64_sync+0x1a4/0x1a8

  Freed by task 403:
   kasan_save_stack+0x38/0x70
   kasan_set_track+0x28/0x40
   kasan_set_free_info+0x28/0x4c
   __kasan_slab_free+0xd4/0x13c
   kfree+0xc4/0x3a0
   tnc_delete+0x3f4/0xe40
   ubifs_tnc_remove_range+0x368/0x73c
   ubifs_tnc_remove_ino+0x29c/0x2e0
   ubifs_jnl_delete_inode+0x150/0x260
   ubifs_evict_inode+0x1d4/0x2e4
   evict+0x1c8/0x450
   iput+0x2a0/0x3c4
   do_unlinkat+0x2cc/0x490
   __arm64_sys_unlinkat+0x90/0x100
   invoke_syscall.constprop.0+0xa8/0x260
   do_el0_svc+0xc8/0x1f0
   el0_svc+0x34/0x70
   el0t_64_sync_handler+0x108/0x114
   el0t_64_sync+0x1a4/0x1a8

The offending `memcpy` is in `ubifs_copy_hash()`. Fix this by checking
if the `znode` is obsolete before accessing the hash (just like we do
for `znode->parent`).

Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
I'm not entirely sure if this is the _correct_ way to fix this. However,
testing shows that the problem indeed disappears.

My understanding is that the `znode` could concurrently be deleted (with
a reference in an unprotected code section without `tnc_mutex`). The
assumption is that in this case it would be sufficient to check
`ubifs_zn_obsolete(znode)`, like as in the if-statement for
`znode->parent` just below.

I'll be happy to get any helpful feedback!

 fs/ubifs/tnc_commit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..0b358254272b 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -891,8 +891,10 @@ static int write_index(struct ubifs_info *c)
 		mutex_lock(&c->tnc_mutex);
 
 		if (znode->cparent)
-			ubifs_copy_hash(c, hash,
-					znode->cparent->zbranch[znode->ciip].hash);
+			if (!ubifs_zn_obsolete(znode))
+				ubifs_copy_hash(c, hash,
+					znode->cparent->zbranch[znode->ciip]
+					.hash);
 
 		if (znode->parent) {
 			if (!ubifs_zn_obsolete(znode))
-- 
2.39.2


