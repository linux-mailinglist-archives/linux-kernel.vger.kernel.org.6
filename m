Return-Path: <linux-kernel+bounces-326038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB249761A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C28F1F23077
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670D18BB8F;
	Thu, 12 Sep 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="BH0LacuB"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2072.outbound.protection.outlook.com [40.107.117.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D61898E6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123234; cv=fail; b=ErtpM32mcorxYn37JlfYcpiO+Gfizp4swV/1C+K3vNpyv6muSejS4Zniz571M67vv1axEVgG9zzUFzCXU0vx1AsY1MXuq+0BS5LxmKfR1Q//e8LQqv5IwqjTmqQWpEarMEXQ+U4CzL1xpKUFYY1aK2sefTERhHcejwDHMFJfA40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123234; c=relaxed/simple;
	bh=UWNFunFKT5uix9SMyfUS7se63mPvUau310RfsI3A5Rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jm/2mff+5cHCl3nu81B70/i8ucA7eHfIiuNVr/D3jTbyZVaABl/1lVEmw7fPHXh7zw5Fm3t1Pkjb+TagDAfPWPaF1hmGciI8LxXxPnaMXwqF2NtMwhoTck5MVgSQwNATJpUVcfV86zfHklwHaIuI++6X4rehTKquwiYURAAqG8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=BH0LacuB; arc=fail smtp.client-ip=40.107.117.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYVBXfovI4mfQXGsaQc3AKn7JqtQXwocLykEPX1X1oJrmUgfGj1aFWYR16es7oaq7Qe92tjUypcJ1dn757oB9ExZBDFOwQ60wYvQPBLggasRijCPifyU8QJAnduLsjiWCScA56fMYXDnL2eK6MeWeFPD45vzoVXwFv9QdYTMl+l5sUAuoDXmGm/u7GY57w+g3eFiWsy9S5gyuWsnGBk5V99MrlVu8BO6LRSoJyZ9zdFS3mtWtcYOkCQoDFVke/h810NFTUs19qumjwz74oGC6cvwbgKRv/vIKcjBhXXedUA6teNfyJm5FMaxCgmoULlrOBXwPXX98JhEtr9gFW4olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhFrel5hVc+QCQ3Zf1JE5M1aC4spplciKDjRVfXbf+A=;
 b=oU24125hCPHeOKa1e8lDIl8nauyhWf+JpXcX5W/oB1MoBO9OsdlN8nfbHG3/rbJHgLKwiKWMOIKWCA8NO2KLXLt98ClMEbOlv+MUG6k8Q0CSkw/m7hKko6GCit106BE4iUAZ8V1T8zR+La+kpw1QWxd8gXymF8AIzYNqV26xZ973TH3la5ZUrs5O7nAyYVndo2MJ7+aG1nsC6GZZng6acxRu+4tqkDe0GjWpccUSgJyyrfrNMTy1AVBQaHxYSEbmp6dTS2jRjeVYgzSNsgk2pYbODAvufW3qOar9yNbNA9STI1P7IsVtSdv7GFwwoBVetrQ5oYPAnMTiQIVSA6wseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhFrel5hVc+QCQ3Zf1JE5M1aC4spplciKDjRVfXbf+A=;
 b=BH0LacuBDzYK4KBANJICGu3UH7ZHYh5lWS2YlaRW+5dp1+RTBig53KQhhlLN14hjQ0Fm7UbwJml8Np+YcFbFtjOZiF3N93tYBH3Q4X5L+RZqzZmF06kdLuDCj1+deb3tyxz8lGrv/Y66hnjT4ZOKCYgoiZj6OOXTkdMv1VkCBzs=
Received: from SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17) by
 SI2PR02MB5858.apcprd02.prod.outlook.com (2603:1096:4:1ed::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.18; Thu, 12 Sep 2024 06:40:28 +0000
Received: from HK2PEPF00006FAE.apcprd02.prod.outlook.com
 (2603:1096:4:b6:cafe::36) by SGAP274CA0005.outlook.office365.com
 (2603:1096:4:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 06:40:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FAE.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 06:40:27 +0000
Received: from cndgdcavdu0c-218-29.172.16.40.114 (172.16.40.118) by
 mailappw30.adc.com (172.16.56.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 14:40:27 +0800
From: <liuderong@oppo.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	liuderong <liuderong@oppo.com>
Subject: [PATCH v2 2/2] f2fs: introduce get_section_mtime
Date: Thu, 12 Sep 2024 14:40:14 +0800
Message-ID: <1726123214-208356-3-git-send-email-liuderong@oppo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1726123214-208356-1-git-send-email-liuderong@oppo.com>
References: <1726123214-208356-1-git-send-email-liuderong@oppo.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAE:EE_|SI2PR02MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: af84986f-21fe-4ac3-0124-08dcd2f5ca1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SsHvoWnEbNRw5NDtsSPQfIUh79fBBDCqi76HRMZJCSmGV1RrsDqRgwxv7uFY?=
 =?us-ascii?Q?35IBQOjxTv358pVSwNuuLLkYfE7gz9/w9jlyzWLZsXpBNPzwBv82E+G9PDmr?=
 =?us-ascii?Q?FGQpOVjwXk6jyFx1DcAsPqWzJmWX7z/7FuyEUn8c2LhMtzZ2wgUyTYAu/arE?=
 =?us-ascii?Q?m11DnsrP4tBUaROAOPOyejbJPlOU8eIxXEwQ86yhx3kztXHF6uhgcQ5t7jeq?=
 =?us-ascii?Q?JnNYeCkY+ERMidEZraCkOQWHEZf0ej5ieJZlbDV/iL1CoGFE7HF1oTGUboZc?=
 =?us-ascii?Q?O1lyz9oqSNsTvjhl9lMqL+aXalcz6xVc2AyhYubXz6KvpDOU0ob/mvCbhGc5?=
 =?us-ascii?Q?shQaVXCIKt0FCVvpQSLLhpX+3LEASXs0bRvUGpp5pMuM+jqRhxjCISQoyL4w?=
 =?us-ascii?Q?O9GNEByjsxeeiHJ8apr9Sh1SBSXg2DVHD7o+eKFW1GLUG4ndJ4lfiPmtnXGG?=
 =?us-ascii?Q?A8uA1R0PcV1qPcbBGq1eKgZcKc9JrIX357PL3lFwUyLQtqf9lfdnsOLKlX0V?=
 =?us-ascii?Q?XS+uYLi7u8kEO2wcKiMcg/cgKkRdKkvtt1Xj5/S7btU4DPlnjy41O2NnvU37?=
 =?us-ascii?Q?oD/eiu7zsfOvu+cGs3wdA4+2chj4i3xtFRGx2PNRIrZ+VWYSewcN0v/3JGy+?=
 =?us-ascii?Q?sqI5V+6aLPtbcpHzOhPKqFSHldttMa28wKqhwAlf1TjGxjOoxvOYrALjrkQ0?=
 =?us-ascii?Q?P9+nzxHIPA/FKREI5ppPlNhBECYvBuzzCC5PCi8Z+5x1PtcNMF8S+4BVndm+?=
 =?us-ascii?Q?rfxSMzNDJ0r1ihBPgKF5Kx16LQVW/3atlHekEYw+xNNJHuuSkoaNOw0Rf0En?=
 =?us-ascii?Q?M9Vh5bflR6ODsalWXCRW3W19CqzxbtTjVAZhX1YgkKCMecGLw9gyNBye3lxn?=
 =?us-ascii?Q?JFgvQEcUeMF8mx/9b+fcNPkpLbgoAB+Xdqs3qy8c45w3KmH84f7bF0lZsGTq?=
 =?us-ascii?Q?IB24R8rVA3oekdDj1bUCbqmidqNhV6iMVwDQKqZygP2b/cUVOrK10FMA6KRi?=
 =?us-ascii?Q?xZlYuVPrwZIshZ8BKYBSaUulgM+xMmhF0M8WajAbVImSnHLNB9d4QFOCCaQg?=
 =?us-ascii?Q?j6cqKnfmmCcu+Ha41bVwI9i7DZEGHBOqYF5QvOrLzX3D3Vv+gIL5msf3KFVE?=
 =?us-ascii?Q?C+M7dwtqxiL3uFByz+hLWGmD8++8fqqCCd8Xxo2paov08LpegQoQmt89hrxn?=
 =?us-ascii?Q?2g/60JkWBae7fKnNI4VUcVP21GMOvryXxQDkCPBJBN5gTm6IKq83tZ3zIsJp?=
 =?us-ascii?Q?xqw0/BzX9MMeysPtH5BcGvo8YP3UvWa1WK69s1NLZQ76t/RTno3T/9+JuY0k?=
 =?us-ascii?Q?Ts/Ami7/PIaMaogFpLTLnQw19JRJzvSdyPqIq85gfRvdLQB8zRXMHR7S+dUl?=
 =?us-ascii?Q?70zUxIBuHA8NDaBd1hNnPEMvvUsxeO/Vcc3jTRan1qxo5lJnd7I6Acb7LfcK?=
 =?us-ascii?Q?mxLCcm/erjMs71MVHFUJX/9ivicXDQkw?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 06:40:27.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af84986f-21fe-4ac3-0124-08dcd2f5ca1a
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FAE.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5858

From: liuderong <liuderong@oppo.com>

When segs_per_sec is larger than 1, section may contain free segments,
mtime should be the mean value of each valid segments,
so introduce get_section_mtime to exclude free segments in a section.

Signed-off-by: liuderong <liuderong@oppo.com>
---
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/gc.c      | 15 ++-------------
 fs/f2fs/segment.c | 41 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4dcdcdd..d6adf0f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3762,6 +3762,8 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
 			unsigned int segno);
+unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
+			unsigned int segno);
 
 #define DEF_FRAGMENT_SIZE	4
 #define MIN_FRAGMENT_SIZE	1
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6299639..03c6117 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -332,20 +332,14 @@ static unsigned int check_bg_victims(struct f2fs_sb_info *sbi)
 static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
-	unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned long long mtime = 0;
 	unsigned int vblocks;
 	unsigned char age = 0;
 	unsigned char u;
-	unsigned int i;
 	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
 
-	for (i = 0; i < usable_segs_per_sec; i++)
-		mtime += get_seg_entry(sbi, start + i)->mtime;
+	mtime = get_section_mtime(sbi, segno);
 	vblocks = get_valid_blocks(sbi, segno, true);
-
-	mtime = div_u64(mtime, usable_segs_per_sec);
 	vblocks = div_u64(vblocks, usable_segs_per_sec);
 
 	u = BLKS_TO_SEGS(sbi, vblocks * 100);
@@ -485,10 +479,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
 				struct victim_sel_policy *p, unsigned int segno)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
-	unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned long long mtime = 0;
-	unsigned int i;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 		if (p->gc_mode == GC_AT &&
@@ -496,9 +487,7 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
 			return;
 	}
 
-	for (i = 0; i < SEGS_PER_SEC(sbi); i++)
-		mtime += get_seg_entry(sbi, start + i)->mtime;
-	mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
+	mtime = get_section_mtime(sbi, segno);
 
 	/* Handle if the system time has changed by the user */
 	if (mtime < sit_i->min_mtime)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6627394..e62e722 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5389,6 +5389,41 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi)
 	return SEGS_PER_SEC(sbi);
 }
 
+unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
+	unsigned int segno)
+{
+	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
+	unsigned int secno = 0, start = 0;
+	struct free_segmap_info *free_i = FREE_I(sbi);
+	unsigned int valid_seg_count = 0;
+	unsigned long long mtime = 0;
+	unsigned int i = 0;
+
+	if (segno == NULL_SEGNO)
+		return 0;
+
+	secno = GET_SEC_FROM_SEG(sbi, segno);
+	start = GET_SEG_FROM_SEC(sbi, secno);
+
+	if (!__is_large_section(sbi))
+		return get_seg_entry(sbi, start + i)->mtime;
+
+	for (i = 0; i < usable_segs_per_sec; i++) {
+		/* for large section, only check the mtime of valid segments */
+		spin_lock(&free_i->segmap_lock);
+		if (test_bit(start + i, free_i->free_segmap)) {
+			mtime += get_seg_entry(sbi, start + i)->mtime;
+			valid_seg_count++;
+		}
+		spin_unlock(&free_i->segmap_lock);
+	}
+
+	if (valid_seg_count == 0)
+		return 0;
+
+	return div_u64(mtime, valid_seg_count);
+}
+
 /*
  * Update min, max modified time for cost-benefit GC algorithm
  */
@@ -5402,13 +5437,9 @@ static void init_min_max_mtime(struct f2fs_sb_info *sbi)
 	sit_i->min_mtime = ULLONG_MAX;
 
 	for (segno = 0; segno < MAIN_SEGS(sbi); segno += SEGS_PER_SEC(sbi)) {
-		unsigned int i;
 		unsigned long long mtime = 0;
 
-		for (i = 0; i < SEGS_PER_SEC(sbi); i++)
-			mtime += get_seg_entry(sbi, segno + i)->mtime;
-
-		mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
+		mtime = get_section_mtime(sbi, segno);
 
 		if (sit_i->min_mtime > mtime)
 			sit_i->min_mtime = mtime;
-- 
2.7.4


