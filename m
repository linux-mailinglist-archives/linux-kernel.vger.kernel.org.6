Return-Path: <linux-kernel+bounces-402161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2383E9C248A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A452897D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C285D194C76;
	Fri,  8 Nov 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="en1cQ8Q3"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D51A9B4C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088818; cv=fail; b=Ch30THRwRgEfNF/uv1f9OBFF443dy8DiA8u2X0MfWFnllUK/j4NxFT8o+9htrTN9AlJAEFS/tqPPKiY7mxoTKRTJjrIVijwQlhL6PUqZeHlqSGBfve9g0KNHUoRHXaDtKZT/jEdcbEcVa8EVa76yVz2ICddjvA2xwZMkB2Rqc18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088818; c=relaxed/simple;
	bh=J8JP9ouiBfVNVvIXO5UU/LxVi7uh+5NlnG4G8M6YMv0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZwtXIpZhK3pmxQOU/X1iUize4l6l375o3Z+LhlQQeX44vRSGgKHzensKXJh6m3x3EieCDK7RKo+bh9pw7bZBzSJNJRzM7DFK6aLOHf0GVltGiNCTlRCkWeCpZvkN+JKWxue1Ovlwi5jP1rMyMS9Vrxf9pk5JivzvXF07wAd0KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=en1cQ8Q3; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1v4XZBhYKrXGV1UDXisk8MD/t+y0dQZTGJsHOSb1/405XxGDeYPUCXI5a/w0jEDMd6S1PIKZptYvw20bBwvykho5/nmpKfy7UtHUSHFQru62lGug61ynuMsG7IjPuoZL1c4SIW2Tt6rCeG8H5e49gdgmywzYZPUafOnB/zDDRZEmfr8vjfgxeJUBF0HRJ3t6zhPmnvmNs9FW+CliMzA2Oad4t+RTQ0EaANoo+wUugc5Cvh7/u51yKO1AP2OhTK68wub2kmbgzEKMl6Yup1jhgR2l3PGXE0Qj3jlwuKNdFMDYH3pF81sjoYPWuWZNxWr10co/G1bYFqi2GUy8R99aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcTkBx7KEAP9y/+yTqOvUDAo0UdE2+fxOPDEAz1ZtfY=;
 b=ZuCvKrxXBvdamHic/u6hMDFjWrgobLGRYKjRZ5IpdIFS5kt59Ct7Wvwv8zK0J0VnsYAWXcUU1qz5UUwWdAgHWG9wMRXMKxiOQVKF1oCgLJ5dVP30C/PTSSdwU3Icxc2nNGSKQDXg254dA7/OMhI3g4emO5MyOE0hp+7/G1vEjnFnEdJI7ENAq88NvHfGjcCpSEYHL38tNemNKuwvwadimOkYd45rNr1m7sTbin4ORI0ZC5B+O6/u9hW5K8DZjdGEEaNTfZgy4saGfroo+JXmf4bk/iwgYTYfFR44r2G1A14GFDV2s5Dw3vcviPve/k7rBS4rrW0dE5O8alg/nBIV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcTkBx7KEAP9y/+yTqOvUDAo0UdE2+fxOPDEAz1ZtfY=;
 b=en1cQ8Q3xARLuApGv9Wp8t4m9TBeS6F7uWGz9b16YievggK843IMa4Ek9Yo+x4A8FiUrajWfdJZdmhhpngB10Omk/lGe8wC97cVq5fWDSxDfdan38hMKfGeIQOG7yJopWCSfrY8PXG6ZG2lyu+VxyDwsibC0XoSCPnIu7u/Csd8=
Received: from DB7PR05CA0041.eurprd05.prod.outlook.com (2603:10a6:10:2e::18)
 by AM7PR02MB5941.eurprd02.prod.outlook.com (2603:10a6:20b:10f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 18:00:12 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::30) by DB7PR05CA0041.outlook.office365.com
 (2603:10a6:10:2e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 18:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 18:00:12 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 19:00:08 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Richard Weinberger <richard@nod.at>, Zhihao Cheng
	<chengzhihao1@huawei.com>, Sascha Hauer <s.hauer@pengutronix.de>
CC: <kernel@axis.com>, Richard Weinberger <richard@nod.at>, Sascha Hauer
	<s.hauer@pengutronix.de>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ubifs: Fix use-after-free in ubifs_tnc_end_commit
Date: Wed, 9 Oct 2024 16:46:59 +0200
Message-ID: <e7b5151bb1186e2342ed677cce0ef77592923084.1731088341.git.waqar.hameed@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AM7PR02MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: de9c7141-bde0-4c4f-0e05-08dd001f311e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PxhMKhjR8Lxdm8indgts4ruxvXcV0YmkGUvoge9Vx6clMoiSCvanCEFGhghV?=
 =?us-ascii?Q?nDJMFIQa+Ua4MPNo8vsPXVAbqUMJ6Wg/bMw7BzmnED1a48MFqDrmF7Zjedwq?=
 =?us-ascii?Q?ADwlX9ZRD7wL+8IxRywZ1vohaAZ8QBNaHnL9VieQjX098y8/lAN6vrvtttM8?=
 =?us-ascii?Q?9IUAVsr4eFqCIj6MpX9SijPf5IohKPD9nFe7mtRNoxwV0wWFVBep96HifSxO?=
 =?us-ascii?Q?zz3Eq1/eyzSka4ajUS3rQKKtYsfG7qL4pCW/Tf43946FzAHxpumca9Z4U0C4?=
 =?us-ascii?Q?CPuHCfWhzmittimM4dE1F+HlxMHdIobtvAsCTITo5H9+8prLMEY1ewU3Ujuj?=
 =?us-ascii?Q?MeehfXv9rU3HeLw0u3x62K+Hhcq1sEUF8JLyUdGq6uC8QSCywD6rbpHdiDbx?=
 =?us-ascii?Q?CbDh9TfmcqiO61E2UVVK/uv6KyjILoL5YXRqNa08/RZVbvEPP+LdTK2MOdKU?=
 =?us-ascii?Q?ZFzUk6dZQBOVGkh0HdUlkWNu9vdpdZ6KI7xXdQKinTw/LTRtZqy21mWdLlbK?=
 =?us-ascii?Q?A/6TNNAEnBVX5adx270STsHWVtrsaiXIQSmKlBPD+AhJwA3smwwD0PBK1OO4?=
 =?us-ascii?Q?5seHUjbvzXQO40LjRA2lAN13hGd3MCynnUoPx8L1DO6beI+mXAga/FMJ8glE?=
 =?us-ascii?Q?GNhbB7RATlFv6aAhgEvZH4s3M/+gogfr2zpzqcyY9b8fBCjIN0jLRMu8076X?=
 =?us-ascii?Q?qAMp8seolYl2zsY45Pg5h+BVbDDVLJH+xE6efTZeAbV62W5JxzKJmXfkL2m+?=
 =?us-ascii?Q?Rj/QZi5Awqgm6KU+dKKOkaqi8Aq9sCPiuH9NRnmhQYh+qBhuWKiH3EK3ZMTW?=
 =?us-ascii?Q?6QaiQ+Zqr57LY/rWsAs6XMdfoIykSLESqj3Dpe+6rTqx8185ddu2z7iqw0Dn?=
 =?us-ascii?Q?ey0x3NRoS7NdSAEE7zGzhhVkq0MXPVwTn2kAw1MjD2s8Aox1I3TpnScrEfR8?=
 =?us-ascii?Q?9w+gyoC+nm2oA6CDE/ZPs1vQ2FqWscoqdfB514ISh18/s0px2a9/qaMXImu8?=
 =?us-ascii?Q?q6AKxc5uV9XNgEqpaLex5v8nFrlHBcryLM7obFDGzGEP8pB7ZA9bWB/HAhki?=
 =?us-ascii?Q?96tvarCKKEWclopKG7QY+QgEULTVGWU++pb3ESQ39HLFfAtfSmpyVLqRM3Xt?=
 =?us-ascii?Q?2baZSAuxvn7rJkgPH0R3uVOng/PW/CSnwWFD2Mu88X0/JzVa9X8CvvVRajge?=
 =?us-ascii?Q?ycbx17v4EejTagQvTbcDU+CtXTtknoBkhqX1fn6Rv8ue0HShMVB08BVohsoG?=
 =?us-ascii?Q?uGsvmI0ZdX2480dZMQ4KCqxQ3uOVnR+J8E/Kw/1G72KrDHThk4XUiYzDFnbP?=
 =?us-ascii?Q?ESDSYMO5skoe5XakzHnTBX8+y8Gx5qEZ/h2qufOD5WiZ+WshD6Ffoz/EFJAb?=
 =?us-ascii?Q?eV8eTqySFCcGOvWf1v927vvzcpDKIX9iJ1sy9D6CH9b0J9Y/3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 18:00:12.3736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de9c7141-bde0-4c4f-0e05-08dd001f311e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5941

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
returns NULL, the current `znode` _is_ the root node.

Fixes: 16a26b20d2af ("ubifs: authentication: Add hashes to index nodes")
Tested-by: Waqar Hameed <waqar.hameed@axis.com>
Co-developed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:
* Implement the actual fix from discussions in RFC patch.
* Link to first RFC version: https://lore.kernel.org/lkml/1225b9b5bbf5278e5ae512177712915f1bc0aebf.1728570925.git.waqar.hameed@axis.com/

 fs/ubifs/tnc_commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index a55e04822d16..a464eb557585 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -657,6 +657,7 @@ static int get_znodes_to_commit(struct ubifs_info *c)
 		znode->alt = 0;
 		cnext = find_next_dirty(znode);
 		if (!cnext) {
+			znode->cparent = NULL;
 			znode->cnext = c->cnext;
 			break;
 		}
-- 
2.39.5


