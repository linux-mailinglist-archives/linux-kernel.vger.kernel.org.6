Return-Path: <linux-kernel+bounces-324173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 294CF9748E3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AACCE1F21672
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE95413AA27;
	Wed, 11 Sep 2024 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cIc+vm4/"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575AA130A54
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026236; cv=fail; b=eDH9ialYGlkmTxJirBji9IaYsrFcKYlwNXjeshtDjbX4+GS9rkm3DUJIVDPdcZ+UMAqLnxkL0+BNUhuvOVNFMkR/2LXCv9aYB5Yho/eFuA5G4JJQ51ayGdN87scuHmAiFv4JB1SN1nmb3xxrN7HfsQmuxTC09IwT72AdrJ/ww5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026236; c=relaxed/simple;
	bh=sPwhHRrQKPW7G8PdPrtZ2iMW8M+G5Q+xTJppa6iDR0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXoUthC9+KYwiU51fyXVbI6NbyrvzelN2HF6fZJEVvtk2rZvGKJhRdNyAHgNt+rruIFA6SOvJKN3lVsrdUuMKivBEw3IbkiZQ/cUyz0O819aN/RWWVDMGJhWfk8Oe8T5nT7+QGNDipbV12/so0IvJip1Ne4QMMtgf8OYwOrMIsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cIc+vm4/; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPN9g04UWuRoJDuuT8RXZLIMrtASbw6gp79MMXjewalSBGyWQQPjwsJIiCVlflzEsoBA48PMkcXMGHF57Lsm7Ua6ldRUD4JPuFnMX9gdU6EUVwMxYnO+GCrMRyD5jIQxId+hNfu99lRrVDkC4swruQbKiF12UxROSr50jJzAvfreshC9ibHqqCD3Fe6fVXf18K+bXNA/lD3Tn7IfGWk/2wavAwWGdgIpeQokvVGmWnqKFoIprqljvxS16bbrzctHxDuq4VkE0W2xpfhPEC61KWTSCKXYEI84RxYfXRpj5nqm+VuUNulkZcWFr9JHS6EKmKg82Hh0LIMLAPyQOsyETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YkUHWkSyaZim2/FraKiN+n8vb8EDsmqhJ3U8NImOxA=;
 b=MF333iz5aWPf78NA2cA9FN2niA+KmewWORZ9obpIUt7yCK4PLcx/pxlKyZAcL+qTHJwy+DutCWHd6hwOmbQiNqN9N141/99PRFUiv+0tAua/DIx44hY4Jq5prIDctN4CE5qJCHiGrYzGRnVLKrepBE+ZoiU7UC4wF5XLhYFRYa7+QUfY+VyX/vhpMtVp7NdJ3bxWucyI2lKpdTyg45OpcJdbobjnmigZwT+z48EXj0gRedAULsOZ0Vej7CP0A5eBUm+ilRWg/9Plp7RZf+ql/9y1sTqdpzXBQNSBpq0mcjZAL/Yjpwc3XYTv2QqDQwSqbaeMkArtjOxoaj02xx2pOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YkUHWkSyaZim2/FraKiN+n8vb8EDsmqhJ3U8NImOxA=;
 b=cIc+vm4/P/nlxJLGWkcMkebqw9uyZQBvNxueCMy9EEs/M6LEARXSbei7T/Sqn8sHlU499dTH8FotecWKVYRUJD8l3uwQG+XY9ymsG8VsWSn75Z5gU/andlAsK63A9rJzI8uwrJEk+UGS8cUql3VvF/STYLOLo9voY8TTxHOk82XFWnYVnDVK3M8wv+imI/CI8Ihm9X5tBEVPaHtz57ojIoLvvmIyBP8lnRwDZaZa12r5DPwhU7fN/ytARPMyIxjoVCSRfeLkh57dknzhR5yBxV0W7DOssur7kqtWEMQAFD4LciDzae7m9DLiKi409n5S3ebRWUyIpzreQyDStXdIMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:45 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:45 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 11/13] f2fs: fix inline tail data lost
Date: Tue, 10 Sep 2024 21:57:24 -0600
Message-Id: <64857ac35515abdb00cfad877094131b471a8776.1726024117.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1726024116.git.bo.wu@vivo.com>
References: <cover.1726024116.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b06946-a1cd-4812-a468-08dcd213f03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYhdtRgMgvXuU1+GCgFjaneo4y515buEbARLMsPJDQ8gKzW4MEtYBk8H2gKb?=
 =?us-ascii?Q?S/7M0DCLmhZUedGLl8Kdnhc+VNVXP8LkHCI0CxTb2skeKsBlvlizHKp5knrA?=
 =?us-ascii?Q?6HxR6aY2BO+FlJXFybQ89Zi/OxQGS2IGg1JuyDC8hNUaplUSwRrsbvnb4D4j?=
 =?us-ascii?Q?Vk/3MGK+Tu1mNrDTmkHYG8F7wtKem19iEPC8syU+o0BivQ2t1L9Tsyrk0MLZ?=
 =?us-ascii?Q?MTycPc0qwlFWe3WEcrlI3bie8263vNCQG11/QTEM2GQAJQZztsiMB07DP6lv?=
 =?us-ascii?Q?1gkmL9F2dxzlOwPM3AbNeZtTANf19r7W8MKonjKDC+bF0Cs4TqwqMGNWZNVZ?=
 =?us-ascii?Q?2JrTXA0V/+n9DT4VFIkKE3aeUaWL2QU1hEHVSA5DMDSJNvPINUmIwyPIp23o?=
 =?us-ascii?Q?0cmVK5YQjuMSaHC52mcJnKHEWz9dQMdwaoLoaQ/0yT5JdQnxiu3O/lqbPTYx?=
 =?us-ascii?Q?kZiCSWUp4/v8unVP7wTh6jfoyZ7+dMhdYdt+iFhBwjRUXRWlNKdQYq5G4IlX?=
 =?us-ascii?Q?pwTFEmN7vYz9yHtpvfJ/2gSOu/7a3bF2xduTsc0GQfzdqHfEmzp3qGbMAhbO?=
 =?us-ascii?Q?O2apEArIQ9oOwrs02poe4YIuqzjTTZBTHRGxUXGGTX0qxaS6xdkiw/jBhVZI?=
 =?us-ascii?Q?CGLbLXrJ5v6MCAax1+Jr+DwnND42oxzRCi2WNwUhV8TAiuBnybrFcVyrT/dT?=
 =?us-ascii?Q?alXWFR+80getRgXp3EkIszr0+2N3OeT2mTz1C6ewq/P0nruV82eRsHTd4+0E?=
 =?us-ascii?Q?hE/naQs6vr8A9CPc63r2lCSxUQ6qHbINmqENQqJSrpCueMOkfnbZx9IFIreI?=
 =?us-ascii?Q?gRqNhMyF+rkXA/A5uPi7ZklaJkjm8D90yLEukT1pcOiTDtB7eEp9gm7iJJsL?=
 =?us-ascii?Q?EN6/JHskIik1x5LZ7meYvP+Ca/PImI5k2F3YxkwRVkqxXaB2a960Z0uRIiBg?=
 =?us-ascii?Q?kk6WcI+su+DM6hZgtvpYuVxKUS3dR49PIP3E7RNXPw7iGos9+1PYBsw1607k?=
 =?us-ascii?Q?yyciY+mgv2bIWeC/8tN5yHPYTGfr1eBvHiiGjGszTmukB6/SiABbUU8q2yf4?=
 =?us-ascii?Q?saHZWYeCmJPUb1lsJGoXzRLU83Rldob+sddQlJ2aL1NxopywDvzvg0C71UX1?=
 =?us-ascii?Q?xkY6rdB7yeNi93u5XZKPgDpKOStPBnLbnwhqGvpMN0IewdJcopHibY7o7Tse?=
 =?us-ascii?Q?uGy/SZ6xSsnVOcJgPrpeNMlEhXmSnUNHT+b0TeQP/HuOUznfX4Kvf2Mz6fmm?=
 =?us-ascii?Q?lKmJYbs+vDouKJztpKBQ8bcmaxJIPNKrr917jn1dLJwdRjv32MkxVIcGIKiM?=
 =?us-ascii?Q?JLQANswtZEI6h5xu/Y2ymlJ+6wPJgBa7R8cwwEOlYWNlWq/yUI1tpQhk46do?=
 =?us-ascii?Q?elUWYyVNHauAbUnbINNWN0OE+CU0s9BgTAVzrsYQUynur8jk5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mst4N0yhhAmnixpWmf0QCKKBiwki1aXWcX6nCohRvoFiTLDBhr+0OkKVNlVR?=
 =?us-ascii?Q?9SrApU98iuL/QSDZZbUfAlE8F9a0a3iKVEi0HWpkzr71jriHY7UDoO3X0s3n?=
 =?us-ascii?Q?oz3a8WFUOdG/MiMzP8+h3Nlrn0eNm541DODcek0pGyel8wnXYxA0+ssSuh2D?=
 =?us-ascii?Q?HQfKpXMPW+iaU3S1YcmNLGCSZW2ttQze+bpj/2/B40ETxDEhHcHmeJzqQHaa?=
 =?us-ascii?Q?4yRe+T/URts7510IIyfb/DW2El6j3qeXUWQOWQiKqfu8YWUXbWyhiDbbFSur?=
 =?us-ascii?Q?qXXsKolwPyL/yK6BFaBEBpAVbLmwkUJIzeezTPO1ubnngFCcNv2L0HWuMDG9?=
 =?us-ascii?Q?oBexbQ66s+Xjgk5u+bXv2CqBiurfk2kf1O6juOL6jh+EhuIrFr/JkJRSWEXJ?=
 =?us-ascii?Q?5IeBfsJT8jc60VszxyNTF5XB0zuV8FtcSLMRzOcv+YoA7t3z3XZ+m4Hu1esf?=
 =?us-ascii?Q?74gfKLjgr8pmMbuGiz3lKj8mPN/s9jEL0V/EXDVZZJ35vQH0M+HkQCUhtRkh?=
 =?us-ascii?Q?I9tTQ5NF3CcnidGwhTP4VTHtBaLwst0U+/1x1VN7dv/QQ+VtJ4fWAg0dha3W?=
 =?us-ascii?Q?XsFPOS6fFg17VVYuSkIbidhYHgtMEk1igX2GtktWletT8sbO5FOlHgwwQ/HH?=
 =?us-ascii?Q?ub9Rq7O484brUHI32AGLbMdYJ+Oke/11GtZxfC8KFt1lddYnbN7RsZ+tvYjS?=
 =?us-ascii?Q?j/NxfrmyehBrbZvwKVP9MrpsxRGb5PwOZfHGNZ0ZyAO7Z6ymwKdgo/YU3hJK?=
 =?us-ascii?Q?2nR1Ik8P626lrpYA6Hf/nPha47s7vKmEz9SSk/igEP0kxjhFf5bqMCVuFc2e?=
 =?us-ascii?Q?yWPAmLD9lSq5AidCzgZleMY0RUZbSdt+DgrX2B26wMVSjRRfdO2L1VJ2xLuI?=
 =?us-ascii?Q?xxdty0xO/3Z+aOG/U4uRtBKBP2EHh0tSAZ8xCkrQVXtAJiq7OlPtB7DssFHb?=
 =?us-ascii?Q?O6laQWm6Cgxx4SsJu6lsWX1cVALS4VyFMJBUFwrwrbjQTsKTFjCU/044Gun7?=
 =?us-ascii?Q?fYNUK88sc63ymg1QhE+YhjROLYx/hlSbMTG8EKuKwzuxJqWdycHrbWJpc+pg?=
 =?us-ascii?Q?+JRClc+d7dyaj7Y3P5WrbT7eaxdrDZGcGS2dY4qR8lQyafjDUBNVLpLqBG09?=
 =?us-ascii?Q?iIJnzN7OQkmCGRJHA2WU3RBCypy8hRzYLnYKGbX5/fgkfX9hSjSa7MRIQq8B?=
 =?us-ascii?Q?SvRDBpuz75+NMJAtsChDJmfbFV8n0mcBt0ln0/SRDjw8AUqJvTxZVDbPP1ek?=
 =?us-ascii?Q?Pz2EyhSFekFhiRJQF+EHUlOH8vXHDrA8SiN3DInvdEpbQg76WJbWShoEpb6b?=
 =?us-ascii?Q?2Fs71m63dlggRPfizvwmOKBU+c8iclk5v1hr37tdYcR+MESr/3A8FtsnEi4Z?=
 =?us-ascii?Q?aneZ4SSTeloy0HX8w27Dt4FbOFo1sawgTQDrrJUVesUFsC3nq1GYm5SxPNhu?=
 =?us-ascii?Q?5z6Wtvz4sx3s4SepQjC1b8n+amnc18vgdANdJtv/QM6gLLKjaNJKviU4X3Vk?=
 =?us-ascii?Q?KSEm82xyHYaFvaqyDETDYZoaNfndPNcYaYIWuQ3HWHpUWcy4YvN0+zNzd1pd?=
 =?us-ascii?Q?IclSweyIcwWufb1KgmwleRYoJ4iX+6QRbkxC1ygK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b06946-a1cd-4812-a468-08dcd213f03e
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:45.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVKthDJ6ImnDk8fWmU09NIOh845/6tlBmPFIk41/LkWooa38CNiDi05ZDlLpuVbC6kLDwAOwPm3+gBKEDMpqeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

Before adding a new page to the tail, the old inlined tail page must be
converted first; otherwise, the data on that page could be lost.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/data.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d7b6074763f..f52834c1cacd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3418,7 +3418,9 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			block_t *blk_addr, bool *node_changed)
 {
 	struct inode *inode = page->mapping->host;
+	loff_t i_size = i_size_read(inode);
 	pgoff_t index = page->index;
+	pgoff_t end_index = i_size >> PAGE_SHIFT;
 	struct dnode_of_data dn;
 	struct page *ipage;
 	bool locked = false;
@@ -3438,12 +3440,12 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			flag = F2FS_GET_BLOCK_DEFAULT;
 		f2fs_map_lock(sbi, flag);
 		locked = true;
-	} else if (f2fs_has_inline_tail(inode)) {
+	} else if (f2fs_has_inline_tail(inode) && index >= end_index) {
 		if (!support_tail_inline(inode, pos + len)) {
 			f2fs_map_lock(sbi, flag);
 			locked = true;
 		}
-	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+	} else if ((pos & PAGE_MASK) >= i_size) {
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	}
@@ -3471,14 +3473,28 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			goto out;
 	}
 
-	if (f2fs_has_inline_tail(inode)) {
+	if (f2fs_has_inline_tail(inode) && index >= end_index) {
+		if (index > end_index && f2fs_exist_data(inode)) {
+			struct page *tail_page = f2fs_grab_cache_page(
+					inode->i_mapping, end_index, false);
+			if (!page) {
+				err = -ENOMEM;
+				goto out;
+			}
+			err = f2fs_convert_inline_page(&dn, tail_page);
+			f2fs_put_page(tail_page, 1);
+			if (err || dn.data_blkaddr != NULL_ADDR)
+				goto out;
+		}
 		if (support_tail_inline(inode, pos + len)) {
 			f2fs_do_read_inline_data(page_folio(page), ipage);
 			if (inode->i_nlink)
 				set_page_private_inline(ipage);
 			goto out;
-		} else if (f2fs_exist_data(inode))
-			f2fs_do_read_inline_data(page_folio(page), ipage);
+		}
+		err = f2fs_convert_inline_page(&dn, page);
+		if (err || dn.data_blkaddr != NULL_ADDR)
+			goto out;
 	}
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
-- 
2.35.3


