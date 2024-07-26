Return-Path: <linux-kernel+bounces-262780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059D93CCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7361CB21EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2E1B28A;
	Fri, 26 Jul 2024 02:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VVeMSN3q"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010047.outbound.protection.outlook.com [52.101.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985E22616
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721959899; cv=fail; b=HyFc6Mem8ugqR5ULZ5SN9W9lW06N42MUkz0ocPSp1wCCLBU08IlD7FSa3Oprf0fPWR9Dk/eWeA8p5drLNtyHX4HNPxaUeXBBZEmf9UWQUfUt3dHD5WrxEvj5Xtsja1O12IRATU9yZ7O/4XTEFXvlowUvBVikrrf3xWDZtKW6x4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721959899; c=relaxed/simple;
	bh=7rXX1NBjxqr+k7HH4GCUSZZrJOP+28D311rqI1gGxng=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TFNZLvolGEN9+T2B2qxLaktUTZR5wXOlED5Z1eb3BlYqU+1RVIc93Tt5mY+y2vYmGdDPfZITpKnN7JY5iMAS0QE6Ws/GlJhBs/t815vyELfV/uAG4fIWdqCTzUR255U/h7wkNfpw/dwGcwI1vqsvwGk+bacpSZQYZcUBjXdGQBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VVeMSN3q; arc=fail smtp.client-ip=52.101.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zp1Ps7JfIcA7i52aclqVTa081nJ2/MbhaKPyJ9yAT0PPP+7kf/4masKi3KuwaxfLXZ8kPcirexzO90P1bn42SgiSqUnHJjfwq3J0eW7EKeg5GnE+yTCsDBJycVOsP6tIUxohK6XUOEh5vBk9oLWD2xRhf3a3bdpesZym6Pm20abRl316cH8Ihw6rJTTtYA0VDmZDOiQ2betJJZCRcYs3gk4JcUtc4BygJzO3xoLNb0Wzzg5CCSDfaPgZdSvySi6Ew4iiNLCwUYbzLyxzxEYdqgaVJ+2ew2Lr9uKKQ/2REgGtKYyMd61tQvzroBCyWgdI7DGz2tnPY/UPxQNP3Tpl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amUZv2U9O4J9WoofmBCjsmX58GmjBgH/Dj/fTkJjupE=;
 b=mYndtpPPRp3KMX8n/cZV/BrWiL+/T8DtweLGhluG5vA8y8jujMSbzxCFZF9LZH0B087Mpf1vrc3FWFwllTBbWihhnlj1lx1A81psEhl0faKnBNFXhLBQH4aGfS3XL/ENxu9K7Ak69YE27e9JDBOEydCyLfgKQBx5wWI4xckKRVlUQEZke5IZvF9EAW+2LCObbo0QI51S4sCTXcbNXjHy7PFBwGOQTSOaqV4GegZbkEUxUOR4a9cZnDlKmMTs9aiGAQQpTyqzaVAneaIzEMiBQZ8HLrk1HlbTGopxQv1vlbMAv2R7gkrgIs90uOM0Csx2ALxZwZE1nRB9K0YAEvTmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amUZv2U9O4J9WoofmBCjsmX58GmjBgH/Dj/fTkJjupE=;
 b=VVeMSN3qAZbZwMKvtXM4ZCMkXhQy4v27C1ylqnq3/klAa0ftHkEd1QLWeUH6pbQ+lcrMzTWvZksuAeSJnysZQ7eM2ErtID8Cn5FXFyo/BwElgZnu2Fg0+cIfKt1fE1I1cFTTPET5PmiOJJmj7qcjObf43YuGd1Gm8SjTB32XEjI9zPbYYTAsFhkgwaytAcHQKZI+6RdZwenByzUAF9vtdAF/3TR2HUVJ25fvhiAV4H3eoSn52wNLF4iAq3CFMlg9ieJF1/bqx0GKlKo2Pl0Gx462bj5QxwSOdWkFwwWdTw4S388fcybxtDPoSM0Nnj2tSvvylwN3iuJg7bmfZr5i0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SI6PR06MB7168.apcprd06.prod.outlook.com (2603:1096:4:250::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 26 Jul
 2024 02:11:26 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 02:11:26 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2] dump.f2fs: add checkpoint version to dump_nat
Date: Thu, 25 Jul 2024 20:25:50 -0600
Message-Id: <20240726022550.3117469-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SI6PR06MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e05d38-6f07-42ce-155e-08dcad1840e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hRGO7NOZSAbW+tjhpyV105L9RW5Jh4eJJ95ECkWl+JcDDrI/FYT8uNIa+QzQ?=
 =?us-ascii?Q?mUax+R9P9GYC37idjBERge7UYKsj+gl+QlBZ915lhBiSdTVPHOu07sUlkX3F?=
 =?us-ascii?Q?tSpt2VmziLPQIPKlPPC8EYTTFFfypJOkR967RqK6ye3H8RQUwOEFtK1qtO88?=
 =?us-ascii?Q?oZSl54FaeDpKYmgaGqir9YD7pDN+i4ZEF8UbU1ST/H0BEll3+NFCeXo1DfNW?=
 =?us-ascii?Q?LFG3A1Q2UG+ulvfgbfyrAuwrGkPGy9Qqorbll2ksSM7WnEAK2IS34FOY7pox?=
 =?us-ascii?Q?LA/CdMISMyf/xPW9HwdA9civqng1d5PVuDzNDRWkBjdqkkTr9EY+so4u9Yr5?=
 =?us-ascii?Q?fOggrCi/w2JPtoSPDBfvHWy9Gv9C19OUH9UzI1BafSi1qYmBvPY6dIUu0qDI?=
 =?us-ascii?Q?mwM9oW5dg1SMEWDmEq7/T/5K9jbLmfG/f/tjd8ruaTdKTDaEq9EdvwhpXCb1?=
 =?us-ascii?Q?iN5qp05HjH9z+xyrRePyS4E0PBseng1QLhr+QKNZtSzkEVq9e1UR8C3Vj8MW?=
 =?us-ascii?Q?U+HseNVqxHVW/oj5q3/oUjrhnmT8PPrRTO2jmDnN5VaIny6ggdaozN2DU3tR?=
 =?us-ascii?Q?O6JkHgM1UUaxIhbdExX5nevDeFwmKvmsKl5zVwjgyvfBN/TX6rZHrY3WrD2c?=
 =?us-ascii?Q?I8hTgf1uSoW595UnaCgtBROrixZ8wkEPfax8pgibOOOhI6BXMs2akS8mv/aH?=
 =?us-ascii?Q?S9lrkXpTbZliljOvmKv9eQCiz9N+/gqoP7xpoFDptAStzpSO3kkWB4yZ2Nob?=
 =?us-ascii?Q?S33h/7uUxXNYea9XIMPCnWldRkzxbNNWsjJb2bt+tZ7crrCpWXPShTss1D+2?=
 =?us-ascii?Q?nhL3nx+PlytoSyWklTyGcAFyow7zI4D2yLg/KGcNsjOve3aFxaRnbTMqfUQo?=
 =?us-ascii?Q?zUYlF5bFQA/UGEbEq5sPH5Zh4chgG69V+//4jGRe4Qm3V1ti8GsiNzNoiX11?=
 =?us-ascii?Q?xwtGtTJZf7SeB4PFj79wjEn7vW6MgeWdML6RQCNf3ysfPgGBGVdPHgt6guau?=
 =?us-ascii?Q?DnJONUXS0hGYZvhS+FlAlytSkbqRXIJ6Y31wCVHNCgGwI+ixdA1Q+PdKfvip?=
 =?us-ascii?Q?rSrirnBtw1K/YrQLXAlz5B9uCAjNWiEKz70XLTATBemjDkNrzVueFnf0EQLk?=
 =?us-ascii?Q?+A189RbrkOcI+qi/jzN+K+y66iL1QG9FwyRrVZzsGGvQdaru+GW1r+jcn23S?=
 =?us-ascii?Q?DN4xrpI2mgjB9nH6IOSCpSydfKoV5MD4zcjqZQcSCgc7ausmAR74XStnFZiV?=
 =?us-ascii?Q?ntSEtHCBjoi5croQRUMXeM2FK22kr5f9OAPbT4/rqmb7352yaZnC4mL6iVJw?=
 =?us-ascii?Q?1xO/3eRLZ1NquEBmiUI8o0lQTMXmNSVEfQVDkmOBVK8IRT3CEx6vPtMOTmQb?=
 =?us-ascii?Q?QbnnS/2Yxj0u/tQC8zZA6BZ/WMUXnRGjr9uDX+Ub+FgyMQwyeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mZ+rCXcY7mXgWqYhEOfDGZlCrX/sq/dIdWWZhS6Lm+FPDG5vKBxfvFDDLnxa?=
 =?us-ascii?Q?IdH4VnjK+5RR0odXz80LPoR7f0rpVmjz2hnxdIkR42rhucy4//+yAkdVqc0I?=
 =?us-ascii?Q?svbYxxQFik9fODVSolFbVDL2gCX47+2STMdiWtTiyqZ79ZQjOdxHWNTZrjh/?=
 =?us-ascii?Q?fcofOrouXqQVM3xvIC+NAxT+KVKc0FHFTj6AOkaEPDMzAvTVA6sa7wYk3mrI?=
 =?us-ascii?Q?Dot+DiFS6K0TSxt9XaHPtEt7O8u6gytHq93Zy1jfZ7oXPGT/p2hGeEDIeUtL?=
 =?us-ascii?Q?TAMOhwRArOX7tGIe8njQJprzDNx4lVsN8DfZk+yKxDMKdUsMlpUGt79htaPF?=
 =?us-ascii?Q?9EY6rIIgQ3UaV3921owqFPmYC981r7D05BYe7iu66dbXEZG3TcUnO9YWcr58?=
 =?us-ascii?Q?FGbdTclOup0nBQ/TKVsqr0u4zUge+Fe5retsSTmiblp/k9ehGJiCqCoSgRk6?=
 =?us-ascii?Q?Gp2KLkxhPQByircTOkQtORURb+DpFLEfXQmhXICIa8fM621SvPckwWbmrWhJ?=
 =?us-ascii?Q?fW2HK4pb0HpmgH2sPJ/XYIPU2f+9dfDdnZMFNF3gLf4a5XGHBqjQCEN6s7TR?=
 =?us-ascii?Q?AzU+UQY7rumzWoAKIz8QSUT64yDyAW15Fj/qChYvL9djGnfHDnMshSh8b26U?=
 =?us-ascii?Q?OYiD9Y9URZkiNTPRyQ9SbWK1urQ307wRXfCpEtCndcfP8p3saWLhiiSBu3ol?=
 =?us-ascii?Q?tljNb27jf8U1II/q7MK135y9x7YBPJzEDLQekVbvEebJE0WDoCK2fZle4uNB?=
 =?us-ascii?Q?kBC8b5k4LfxZl0le3k6SWRL/HbGqBdvAeuLJgbMJ+pnSBxXyj5qQxivO1XFq?=
 =?us-ascii?Q?Rb6UJEylaoObaUvurajk18TzykLaNImGFCRxIcJX/ec1+6FGn0L4W6q6LA6e?=
 =?us-ascii?Q?7xYydVmOSM9HaOXzTjFSE2SfgMRDbmyOc/55Tqf4VpqgxpS9XJ64HLQCYs/q?=
 =?us-ascii?Q?nSWL1/Fo0aYr9NVD75bG+uDaSsOzUvB96RhiwAXddyeTngNkD6mLF/3tSgLC?=
 =?us-ascii?Q?bOHZvThWA6SxNzKjkhbiais9nEWRHb0i90+EIpPRaI2fbtG79zBtHRs7r/VR?=
 =?us-ascii?Q?zJXqXp8URvOspvl7naqTGggz+q6XKVGy0NYCFAP1ENP/A9tNmy63JaRm0Jc8?=
 =?us-ascii?Q?OGipVcoMwrqWJi+J2w2UvJir2gAEw0iytrdkiRPp+GMKp+GxxHWPimGMhaOm?=
 =?us-ascii?Q?KvVRBWu3fCTZSj1rr/5o7W2o3ZtzwlZoNhXaOJcauLgtmJWR78Gu5lSFef/S?=
 =?us-ascii?Q?c5sRpOTsscCrjlso5EWOZ9u5obCgTx21qmuYyrWUfpg0Yfk5oe0KZ08bPmUI?=
 =?us-ascii?Q?f2nwJ1Shzo6WuBgi66Iqg+jvIdjM04NquLZP8sm/ocZN0EYkZFt2UunpT0k5?=
 =?us-ascii?Q?Ik4pTIQ5CRj5RyKcORfB7xWHAmOaSUTf0EdTqiAweEBTVt0q89IVhA8YbmCO?=
 =?us-ascii?Q?G9J1LYADgCdwFjTZJ8r2eNwprz3nxZIoEMQE4fq9+k5To4iXrwEYBmkR2M59?=
 =?us-ascii?Q?BEIVB1oFxS3TH9p00oUa1P96n7iVNGZkp734cgPYO4mufMCQUCeE0/nFzQWL?=
 =?us-ascii?Q?dIF9xKmOnszySujS+JKTH1kq8Y2A1jZXo13FKKON?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e05d38-6f07-42ce-155e-08dcad1840e1
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 02:11:26.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCtHyPOYKhRe78Wnc8v6h1IWUAPO/nDQ8rIYaC5woZdyH1k/tyGr/nGAUC7Htmvb+FMilbnXG4StPypTPmCVBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7168

The cp_ver of node footer is useful when analyzing data corruption
issues.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fsck/dump.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 8d5613e..e628c6e 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -21,7 +21,7 @@
 #endif
 #include <locale.h>
 
-#define BUF_SZ	80
+#define BUF_SZ	128
 
 /* current extent info */
 struct extent_info dump_extent;
@@ -38,6 +38,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
 {
 	struct f2fs_nat_block *nat_block;
 	struct f2fs_node *node_block;
+	struct node_footer *footer;
 	nid_t nid;
 	pgoff_t block_addr;
 	char buf[BUF_SZ];
@@ -47,6 +48,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
 	ASSERT(nat_block);
 	node_block = (struct f2fs_node *)calloc(F2FS_BLKSIZE, 1);
 	ASSERT(node_block);
+	footer = F2FS_NODE_FOOTER(node_block);
 
 	fd = open("dump_nat", O_CREAT|O_WRONLY|O_TRUNC, 0666);
 	ASSERT(fd >= 0);
@@ -54,6 +56,7 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
 	for (nid = start_nat; nid < end_nat; nid++) {
 		struct f2fs_nat_entry raw_nat;
 		struct node_info ni;
+		int len;
 		if(nid == 0 || nid == F2FS_NODE_INO(sbi) ||
 					nid == F2FS_META_INO(sbi))
 			continue;
@@ -66,15 +69,15 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
 			ret = dev_read_block(node_block, ni.blk_addr);
 			ASSERT(ret >= 0);
 			if (ni.blk_addr != 0x0) {
-				memset(buf, 0, BUF_SZ);
-				snprintf(buf, BUF_SZ,
+				len = snprintf(buf, BUF_SZ,
 					"nid:%5u\tino:%5u\toffset:%5u"
-					"\tblkaddr:%10u\tpack:%d\n",
+					"\tblkaddr:%10u\tpack:%d"
+					"\tcp_ver:0x%" PRIx64 "\n",
 					ni.nid, ni.ino,
-					le32_to_cpu(F2FS_NODE_FOOTER(node_block)->flag) >>
-						OFFSET_BIT_SHIFT,
-					ni.blk_addr, pack);
-				ret = write(fd, buf, strlen(buf));
+					le32_to_cpu(footer->flag) >> OFFSET_BIT_SHIFT,
+					ni.blk_addr, pack,
+					le64_to_cpu(footer->cp_ver));
+				ret = write(fd, buf, len);
 				ASSERT(ret >= 0);
 			}
 		} else {
@@ -87,15 +90,15 @@ void nat_dump(struct f2fs_sb_info *sbi, nid_t start_nat, nid_t end_nat)
 
 			ret = dev_read_block(node_block, ni.blk_addr);
 			ASSERT(ret >= 0);
-			memset(buf, 0, BUF_SZ);
-			snprintf(buf, BUF_SZ,
+			len = snprintf(buf, BUF_SZ,
 				"nid:%5u\tino:%5u\toffset:%5u"
-				"\tblkaddr:%10u\tpack:%d\n",
+				"\tblkaddr:%10u\tpack:%d"
+				"\tcp_ver:0x%" PRIx64 "\n",
 				ni.nid, ni.ino,
-				le32_to_cpu(F2FS_NODE_FOOTER(node_block)->flag) >>
-					OFFSET_BIT_SHIFT,
-				ni.blk_addr, pack);
-			ret = write(fd, buf, strlen(buf));
+				le32_to_cpu(footer->flag) >> OFFSET_BIT_SHIFT,
+				ni.blk_addr, pack,
+				le64_to_cpu(footer->cp_ver));
+			ret = write(fd, buf, len);
 			ASSERT(ret >= 0);
 		}
 	}
-- 
2.25.1


