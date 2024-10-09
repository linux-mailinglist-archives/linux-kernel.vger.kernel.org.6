Return-Path: <linux-kernel+bounces-403391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E939C34FF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5D3281729
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66801155CBD;
	Sun, 10 Nov 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="FNdZFdBp"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DD2B9A9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731277008; cv=fail; b=EKCVR/AZKQKWFQ6/1q+5PSAHtlsCSEH1Ko5V8i5A7sE4Q8Gtrd9/+JMZ2ecu12iiEI0i+W/Gl0jkKlRz+/toDygee0zYaX5ErUYO7vKfogT0Nj3eyo8yjmr65+benBDJcaoth+tJCrgYJ0qwRSDDww4xCeZAv5wwherqv8gW56c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731277008; c=relaxed/simple;
	bh=XJxXS3zsjS/A8Fzgqad5x/yrqUnHXykvQslqXqP+jJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rCivek+fxpefnCkJuIbANwTdrkaLsYetxJvAdMnSvhycF2/BH4Mf4GzLQb39zfw9owc5A3FMjEJ4eiS1nhtXhyteyarELw0av5tFUlNn3w43lCIfc+xb19T6UCvVKyPFRr46LbZmaRYWKxt3zsG/je7L7Loc2mqJ0i1DPpvuwR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=FNdZFdBp; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ4R8EcK6+KYY9UMt5ozS+w4DvfmfYWcCrAcmWW8id75J/tPeCOpSxGkfaAGx2NSRsv0lPo0BieYZiwVZirgnx//TT/uots2Wp41KB7/kBcD0RegG4EtmBBE5gkZW1r5ZpYZG1eB2GCHKaGfcqfovOUeq9hG3avd0GW5ErYMvEdM9ScH7KoHc6Mqs8ZQKafrh4l49R34MDbtujKJFkC5yQSmBRaVcb5acaKuEGvUcMoiPjITsb0nzqQLoDSVtG/PvP4AEexjvOZZ7Bp8jLyB4ui+uvbQf02RqmkN1D2SVfkHJ8kI0lUoxxVSeByBNIbFhADnoK3IvYaDgL/GgBpHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvbBQdK7n2TWZhqjXRM5s6UWxbO0wHWjjfBZoJthgyg=;
 b=SHC2vg3hKzwS6GoMc1A9rkyuDq2neznNfF0mTjgxxxjd0rxk1AC75hh+aei/4lrZM+8Ml38dSniqYdNZL/d6zEFzq15RYo4VKvdIlbkt9C6mqexU8tWmIsgcCNkXLidDnvVDWLDHpHJK8rRIxSDW6OzaY1W90CNC2tT0qV9fdeYUaLdmapobKrBmkcSkdPC71sKsHEiiiLtF/1/Tj/7F5CkFuY+/jo+91PgL3XnRsh2QGLREKDW5W2hqzv6uEu6nMynZ0X0KivI9K4wKw9ylFo8qJRmmEgkyoQ6paVmVKE9NndneViyKrZdCtbl1/UPdJOo9rVL/9sp46KjIkpAVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvbBQdK7n2TWZhqjXRM5s6UWxbO0wHWjjfBZoJthgyg=;
 b=FNdZFdBpw+lc+o8pUj9FRX1FNPZGbqdOFtOUv2/HnLo55/jYPkAX58PTrC4YAsF2H2uZJtYOThytAO7KjMyiUMwJ/cbkA4vlOeRSi0Xn0aSuVsfJ46cDcUTXfFF1cXLs9JNakRlhQq5BLY72KjZuLXEWt5sYk+uU/nNP78zVfh0=
Received: from DU6P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::27)
 by AS2PR02MB9929.eurprd02.prod.outlook.com (2603:10a6:20b:60a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Sun, 10 Nov
 2024 22:16:42 +0000
Received: from DB3PEPF0000885B.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::62) by DU6P191CA0027.outlook.office365.com
 (2603:10a6:10:53f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Sun, 10 Nov 2024 22:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885B.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Sun, 10 Nov 2024 22:16:42 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Nov
 2024 23:16:40 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Richard Weinberger <richard@nod.at>, Zhihao Cheng
	<chengzhihao1@huawei.com>, Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, Sascha Hauer <s.hauer@pengutronix.de>, "Richard
 Weinberger" <richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] ubifs: authentication: Fix use-after-free in
 ubifs_tnc_end_commit
Date: Wed, 9 Oct 2024 16:46:59 +0200
Message-ID: <3712a732100057abc054833c6ec3ccc579eb647e.1731276611.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885B:EE_|AS2PR02MB9929:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b08305-23ff-4690-4a9a-08dd01d55b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UeOQ5rB0b91PNnfHrWORzUQkYY7RqMA0z3JZrEUpu/l9dSALTTYmju1aLOx0?=
 =?us-ascii?Q?tlJw8AeZxMlEVKWwq9+ogZnw/ZpIpiUw+rzWjvFf8j++Ucf9uiva+3LQaK3Y?=
 =?us-ascii?Q?pfbsmeXLTUqsMetPY6LXrgItZPeo3aY2L/4W+xhHFR77cw6TgvGsqXomt5MN?=
 =?us-ascii?Q?zAS2JYOtZ6H/H/86wZTVb/7NgR88MgRqybeoPxsRf+FiGrSlt+ij7Aj0teaC?=
 =?us-ascii?Q?ef2XQ4cCGDGD+SbAv6zXY0U98vexRsR44jO/Jjp8lizZm3f+30MK+DPOerZC?=
 =?us-ascii?Q?Mcle6h0v/ZSTfyegpDzqGgriCIaONzrV+LFD+oJP+IvREyu7u3WrJf3YXxNV?=
 =?us-ascii?Q?spHoSYi8ff+hvspwthVPKemjgCpoo04easidDdKToaNpyYyG1Py3onaFAPaq?=
 =?us-ascii?Q?whqn6xOzM1ahm5AmxnnSE9Nfyhgh2tRnGd2105y6Fq+qIWT6CwFtxQW0l9OY?=
 =?us-ascii?Q?bD8LGGkwAzL9W6dKvnH7DglQAKpNApbzrtsbzxG3a1R5+BxUUvoA7KtE/Bg3?=
 =?us-ascii?Q?fm1UES/Sw1acdECq50TTjVFB2SUfs0nTzAHHEvJ785QhnveqKzumTwnR3DZv?=
 =?us-ascii?Q?BZ21o2rsA3qv9bNf1D+VeJQ8LuOhPqWWKKKESZDlEl+F1mTGIQRLZ79wwtju?=
 =?us-ascii?Q?HnGXtrtZphZ+EK5LhTK4rmdwJSoY3DYpoxtMh75zqAquuXyae2c2wAhuE733?=
 =?us-ascii?Q?DJTaz5rsH3Tar3gJtpwP+VERTohfXnO9HtMMeUAuF9u1vrI034EFEuNw/n4A?=
 =?us-ascii?Q?v28GWMHmYwCnTGbPKPOCOJrTDpB7NarzuupXEavMOUL4Fu87oI+fD4LXwDfS?=
 =?us-ascii?Q?cOssK5mK4Nk+36QNETm9z3EWwhhya863ToZV19hunOrMgv2DacyuZbfSdUs8?=
 =?us-ascii?Q?nTNjJO/aXlZmt+s3QJGgQSVxuQv7s0b2c3u4Zp+4R9qxYuTsivMuQQKsd/Yg?=
 =?us-ascii?Q?udmB7i6NTetcAhUE0Q9hlpkMsetQ5AHV8eXvgiV7bYh4qwn75JrxxtZOHKF5?=
 =?us-ascii?Q?9DYF7vmTGpOrjABNZQKFwFd2BaUsrcbH4LCplCJtMuY9Wf3OenGB7TsPhCwz?=
 =?us-ascii?Q?db9uiOGp5OrIjfKIOJoXsB6x/DxPgyLxYSBhDTKYTjIi0cSYR4sIEtLwt/pq?=
 =?us-ascii?Q?WWZopRtm7nHzZte48jzBYpmoUzf3wQWX4XEOFHVewkvNkS4LxOdxm3m+J1Me?=
 =?us-ascii?Q?I8MBbAYCBiEN3FeXwVM1CxPcddv7+fgJRxBe8A+rSkP0Ni0jPify47vQnM+1?=
 =?us-ascii?Q?Sp5uxesmSC0li3t0qTtq/QkIbJX8t1JBlI5k60m/9sF+p+7oza0iXt19oH4m?=
 =?us-ascii?Q?d09YXRkFp8TGce2OvibaKBk2e3QcS4lL5Lcyiwa9+GahuutUJAzE/hoBemra?=
 =?us-ascii?Q?UJ03uaNMv8XZqTBlGJ7CxRyddC9bO/6erLX6LoGIRhagvIvjwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 22:16:42.3637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b08305-23ff-4690-4a9a-08dd01d55b15
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9929

After an insertion in TNC, the tree might split and cause a node to
change its `znode->parent`. A further deletion of other nodes in the
tree (which also could free the nodes), the aforementioned node's
`znode->cparent` could still point to a freed node. This
`znode->cparent` may not be updated when getting nodes to commit in
`ubifs_tnc_start_commit()`. This could then trigger a use-after-free
when accessing the `znode->cparent` in `write_index()` in
`ubifs_tnc_end_commit()`.

This can be triggered by running

  rm -f /etc/test-file.bin
  dd if=/dev/urandom of=/etc/test-file.bin bs=1M count=60 conv=fsync

in a loop, and with `CONFIG_UBIFS_FS_AUTHENTICATION`. KASAN then
reports:

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

The offending `memcpy()` in `ubifs_copy_hash()` has a use-after-free
when a node becomes root in TNC but still has a `cparent` to an already
freed node. More specifically, consider the following TNC:

         zroot
         /
        /
      zp1
      /
     /
    zn

Inserting a new node `zn_new` with a key smaller then `zn` will trigger
a split in `tnc_insert()` if `zp1` is full:

         zroot
         /   \
        /     \
      zp1     zp2
      /         \
     /           \
  zn_new          zn

`zn->parent` has now been moved to `zp2`, *but* `zn->cparent` still
points to `zp1`.

Now, consider a removal of all the nodes _except_ `zn`. Just when
`tnc_delete()` is about to delete `zroot` and `zp2`:

         zroot
             \
              \
              zp2
                \
                 \
                 zn

`zroot` and `zp2` get freed and the tree collapses:

           zn

`zn` now becomes the new `zroot`.

`get_znodes_to_commit()` will now only find `zn`, the new `zroot`, and
`write_index()` will check its `znode->cparent` that wrongly points to
the already freed `zp1`. `ubifs_copy_hash()` thus gets wrongly called
with `znode->cparent->zbranch[znode->iip].hash` that triggers the
use-after-free!

Fix this by explicitly setting `znode->cparent` to `NULL` in
`get_znodes_to_commit()` for the root node. The search for the dirty
nodes is bottom-up in the tree. Thus, when `find_next_dirty(znode)`
returns NULL, the current `znode` _is_ the root node. Add an assert for
this.

Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
Tested-by: Waqar Hameed <waqar.hameed@axis.com>
Co-developed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v3:
* Add "ubifs: authentication: ..." prefix to commit message subject
* Rephrase the commit message with a short description of the problem at
  the beginning.
* Add `ubifs_assert(c, !znode->parent)` when `find_next_dirty()` returns
  `NULL`.
* Link to v2: https://lore.kernel.org/lkml/e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com/

Changes in v2:
* Implement the actual fix from discussions in RFC patch.
* Link to first RFC version: https://lore.kernel.org/lkml/1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com/

 fs/ubifs/tnc_commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..7c43e0ccf6d4 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -657,6 +657,8 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 		znode->alt = 0;
 		cnext = find_next_dirty(znode);
 		if (!cnext) {
+			ubifs_assert(c, !znode->parent);
+			znode->cparent = NULL;
 			znode->cnext = c->cnext;
 			break;
 		}
-- 
2.39.5


