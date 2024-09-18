Return-Path: <linux-kernel+bounces-332507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC297BA90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9393E1F2793F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FCE18952F;
	Wed, 18 Sep 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="buHHb1PE"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2072188CC8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654002; cv=fail; b=iimNBPE1AHiEN64mmLdlASgNSe7X8n7IzDdOpsT4YID5ayY/2EFyZMgXpISCjgEYFKgqa3fjJuBHWW/pnYdQkJCWz3HgIk5S9NywGrb7z5tFMqQChVE8kVI+GptboIjYn4NzkrUDbXCXZ9+gPulY6MP0Ezw1g0syW3zhC/6f0lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654002; c=relaxed/simple;
	bh=qEgahzjHZGsfCNARlNA70pHSoNxcUWEgRjZ+QUiEF0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESLsLw6jJ6Bw5v/Dqa12Hvx3L+XrIrX0mXEL+qnCfb83/MA55c2EsB43aNFsdKnffREXtRKAMtj9dbSr8h/hlDILTVNPFGIPcVbJ9a1pWBTcxUbKR3PlRFeifWIqVorPFMwt/B5NH9JAZcB2znjZiDhzsVzgAsZO2dO6wLmGtW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=buHHb1PE; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Y8BhshT9hq3+thbQKz7GwpoyYCOlAQgMRTOgU4OLNBCl562w7fKePXPIwJ2swrbOA5DXKwS/5W3kdomJ4GUjYTaEqRAXJd/kv/9W1qNMSgcf0uFHdp0FB7wDsbGHqeRaXmmyz6+48hgvBu+epesYxhCrQTqMve5LDuQPnXj2AsmZER5zcPOfGiAPn1RLuIzXPgzlkNRmdfySV1+whpODOBXsuF5ofdpfWUngIgprTHA0vs7pyhgdIbUwBhaatQ56hiHS65A154C7NfiIGzt8G/BGADdKN758s95fQ43QUAF+p0TtNW2XSqKejplFgFj5Y64O38Co/2JRRiFuLKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvjIKAs63k4GEfsyoW2G7eL76dNHG88P32YxnjAylLU=;
 b=f7Q1Igl7TDgc0bzWug4Lc01ZUYYvLJdJNkhplsIM0gFxyMXVkkkPqJar55oTerOsWBWFsoqjxIHVhNxHVMwepMeKQjIN4qq9Kjj7YKC0tsjJZmatmp4y5eGT1JwB3PPB2sIWLsW6dIpPXPy3LSqBvn8bI4XP/vNG81MrEbEiWHTsex/IL/p+NrASOWssI2XY4VA+vv2kmRP7fIkkkrrSqDmrgmGmFQkUrd0B5iGVeVJBLbeIlwNQPK1wtL9zLtQpLAIMuzUGX1RN9Jv0KspH6onjY6Df5i1Puw03GyR5rYWUQGBKeaYfEBSOqrDrlSKU9ECW5faRw/lPEUL8h6dmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvjIKAs63k4GEfsyoW2G7eL76dNHG88P32YxnjAylLU=;
 b=buHHb1PEN3Sdkl7bfjWkf1j/QWMWSjBAHzvhFdz3AsjD+gu6HbpXza+2WhPtM4QofZ73+ce9muVfiCR17+yuKO8cYbzGTk6KEskmBytFYl4mjsmI5Ucft2zt1pgmeyWF5x0AGJV6+/q9WwkW7irD+xN7tFH0wd9b+J7v2Xozidg=
Received: from PUZP153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::23)
 by JH0PR02MB6544.apcprd02.prod.outlook.com (2603:1096:990:17::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 10:06:36 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:301:c2:cafe::53) by PUZP153CA0008.outlook.office365.com
 (2603:1096:301:c2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7 via Frontend
 Transport; Wed, 18 Sep 2024 10:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 10:06:34 +0000
Received: from cndgdcavdu0c-218-29.172.16.40.114 (172.16.40.118) by
 mailappw30.adc.com (172.16.56.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Sep 2024 18:06:32 +0800
From: <liuderong@oppo.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	liuderong <liuderong@oppo.com>
Subject: [PATCH v3 1/2] f2fs: remove unused parameters
Date: Wed, 18 Sep 2024 18:06:19 +0800
Message-ID: <1726653980-590956-2-git-send-email-liuderong@oppo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
References: <1726653980-590956-1-git-send-email-liuderong@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|JH0PR02MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: a53f9e70-c2bd-4e09-5145-08dcd7c993fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kOFA+OAv0zdS9ta93GJM2pQMSWBdziWxSr+aefpJ5jSvOcVUrbMY5cUy2Po?=
 =?us-ascii?Q?EAJ8a5Z/fTNUWJQwn3X5R51P16GTOXcA/Wip3VJmpg47P74cI4kn5hmgxUVI?=
 =?us-ascii?Q?/C6rtqhmCrDqNEX9C+WFW0XB4lseNbjJTqPg7S6O/bs+ji61KuB5jEWWyBc/?=
 =?us-ascii?Q?MHBuAuCFZBiqFi617n0DKshoeKFaWdGQl3+QVrb8z43wng5BCFKnjzhvTV4s?=
 =?us-ascii?Q?nE5JGJXNxpnCsXtdy419lRiQeI3iX5gQttqYa0KNwV+koEfV2A51DPvLvu/v?=
 =?us-ascii?Q?ZywX/knk/zAHX9KGdR7jSRp3lqVbX4XIPin7WIUoaujhMW7i6Fx0TG0/TB7X?=
 =?us-ascii?Q?tJLkd60ba83/TLlazHWP2IMieEgez10Ek3EphIEcyL5Jx/LI8sUYR8Ift8G5?=
 =?us-ascii?Q?mPPfLMo/7RQchGlztd1WkNmRxBorkgTNeAqB/AOr9WBBb/oIs1iLtql8pvZ8?=
 =?us-ascii?Q?M1D7LFjZa/o8EgWVxICJdK08Hn1w31L+5jIddQZ1SLX7tKO3BLCfO313gmVq?=
 =?us-ascii?Q?ZkszD54u9Seudw41gTNqG20dl01klHyOkxpMy8SaYQm5is7fllJzgV7iU5KA?=
 =?us-ascii?Q?DR86u//ydh23/d54UA0q7TtuxF9kBglJ1F5Y4eSBarcdeJxTDGuuHn1TaA7l?=
 =?us-ascii?Q?1HfeEN/5plGfP3ZsfTNBoPbI+4CE16qv63Zc1qSJeBMI/c7NkOuLmU9JEWEc?=
 =?us-ascii?Q?olyI346QKkY/k55rUmFqavxi+FZAYDlYhuUFAQQP5cRQIaPBLdUHDHDzweKr?=
 =?us-ascii?Q?+iNHgEwleqs+QBmmkPhVGuPFqhbWZrKNilzc9+rof/Mvhp/TST20hueM/Pg2?=
 =?us-ascii?Q?XyskjeAzwSWOYMtYnWiYadwN2dbWaJqymycvQPHj5z0SFahUOFeZJ1W8qxOG?=
 =?us-ascii?Q?OODMkY+94CFfLl1kL/WiYTDTIehAzKlwBaibrWheBUfpesCIDrb647LJuD/E?=
 =?us-ascii?Q?sdQGZvJfCEEQh8+l8Yl2DpGKdHricpNi4or7ZKYV0cYZz5iSH2yfPYySnU+k?=
 =?us-ascii?Q?r7SOp4d2UqbdecIwmgDlm30u8YvmrXjXvnPLGvV8WiUuM2vAyrBpEabqCuZp?=
 =?us-ascii?Q?4YEig4VSAXXUxWeoomci0DXF/QqzBulCawaubt4l0QY10wegAeZNtnX5R6UT?=
 =?us-ascii?Q?LouES75//aBnu8Ot8v/5RcOfsTkwrl/BFxxN92uZ7AcjWleSxh+YE/jh4o9k?=
 =?us-ascii?Q?XkgkBx8U57D+dkbvMyVcG6AouozmKSN43LuoMZiCfgQ4EOLM+SNcr7Cfxhds?=
 =?us-ascii?Q?zyz/uGL8ttK8lbB3p+WKjow/HB/8iwHIMuepUi3tW+1zMMpR1XGEQhwnLJ75?=
 =?us-ascii?Q?obsPqaM1l3ks0SotQglbCzDdnbxJuD0WO2oJ0SIebymqHxtCILTidcEC5PoI?=
 =?us-ascii?Q?3MBmH7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 10:06:34.3830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53f9e70-c2bd-4e09-5145-08dcd7c993fd
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB6544

From: liuderong <liuderong@oppo.com>

Remove unused parameter segno from f2fs_usable_segs_in_sec.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: liuderong <liuderong@oppo.com>
---
 fs/f2fs/f2fs.h    | 3 +--
 fs/f2fs/gc.c      | 6 +++---
 fs/f2fs/segment.c | 3 +--
 fs/f2fs/segment.h | 4 ++--
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac19c61..4dcdcdd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3759,8 +3759,7 @@ void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint);
 enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 			enum page_type type, enum temp_type temp);
-unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
-			unsigned int segno);
+unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 			unsigned int segno);
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 724bbcb..6299639 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -339,7 +339,7 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned char age = 0;
 	unsigned char u;
 	unsigned int i;
-	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi, segno);
+	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
 
 	for (i = 0; i < usable_segs_per_sec; i++)
 		mtime += get_seg_entry(sbi, start + i)->mtime;
@@ -1707,7 +1707,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	 */
 	if (f2fs_sb_has_blkzoned(sbi))
 		end_segno -= SEGS_PER_SEC(sbi) -
-					f2fs_usable_segs_in_sec(sbi, segno);
+					f2fs_usable_segs_in_sec(sbi);
 
 	sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
 
@@ -1881,7 +1881,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 
 	total_freed += seg_freed;
 
-	if (seg_freed == f2fs_usable_segs_in_sec(sbi, segno)) {
+	if (seg_freed == f2fs_usable_segs_in_sec(sbi)) {
 		sec_freed++;
 		total_sec_freed++;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198..6627394 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5381,8 +5381,7 @@ unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 	return BLKS_PER_SEG(sbi);
 }
 
-unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
-					unsigned int segno)
+unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi)
 {
 	if (f2fs_sb_has_blkzoned(sbi))
 		return CAP_SEGS_PER_SEC(sbi);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bfc01a5..9e61ded 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -430,7 +430,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
-	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi, segno);
+	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi);
 
 	spin_lock(&free_i->segmap_lock);
 	clear_bit(segno, free_i->free_segmap);
@@ -464,7 +464,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
-	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi, segno);
+	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi);
 
 	spin_lock(&free_i->segmap_lock);
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
-- 
2.7.4


