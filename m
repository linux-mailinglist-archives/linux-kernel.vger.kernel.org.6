Return-Path: <linux-kernel+bounces-246841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13E92C7DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C21F239A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF684A0F;
	Wed, 10 Jul 2024 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KbxRgJxv"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2068.outbound.protection.outlook.com [40.107.117.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4789475
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574363; cv=fail; b=WsXQyfgBq7X051P1hkVKip+7hzIofhtB6n8JOpUIyYUecSOCfgpRO4TomAQoBL7tU6HxrNEPRZEWt6RL18uHUx1EqsbF4KBbOXADRK2TbNgB2lSPte3YSDsB/DPqvuqqS70SUHL90KGbOfJr1Mem1LBMl3WlHx3RtoXV41GoniA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574363; c=relaxed/simple;
	bh=9NVZ/oQQkltLrH4pWMll1h4FLrGU8qpvcHTndx2pP/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fQGre5oQ6K3Q1VTdbadikZwuHEtNlKazzxIDCYAHy3BwNTlZdZ63GW0mlBHdb/m9IZjpH4vrktyPmhqldIud8Qk7Hju/OvZ1JLuQxSqORCUWCE0F4u1Vd2AxXTP/+O79iK6coMyMmtK0tlEkSFVaerFXQcJgnGldC9ddRKN+kEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KbxRgJxv; arc=fail smtp.client-ip=40.107.117.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs92WSpC7V30ml0IohReshDJ/DnAm+7OnSELJA1SfsVDOiquw+q4TlpApsq9I7hiv8+lia2bIXsya0ndpOHirlBnmm/pLV8XaQLK0L2zq7ONfTD1HAzXhD6eJUUffBJfQTpR5XqwMbgBtqnkMeXDIFCCadOGrsMID69Ynq7EaHPJV3Lp4VetNANFAsUKBOe46k/AIY3V4h930Lj56seTbtSAD3czeuDwlDtsyUoiwspTgKHpllvNRFhGXHgtbyTuXas0n/cDn75J3mRhHS9MEoeJML+hOCjizZT7h+j3felfAuhnihhSY2eV9I3qFAtGykOp+PO7MQvQrnPUxbseGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AKRQcvo5J4iDqXd1yESKVO4LUEpAwanjBrOyPziXNM=;
 b=Pqbni5IwPDV5iLsFDeoMDS5FiN2Y40vFVuOip/2JYkH5w0Y2bUFrYxi8ZWYLwZyWESrTMcDwGwWp4/hntdwtcyFj9RnfPl38v/Fpg+AFW9VNjMddM54mLjfkp7QuDHWpFN07/kuTteX353wLLGto5bNwHh894xlaQVRN8r1FIfwo4puK22DFnOKLcAFNF/P8DhsBAavErW8na8nsQwbqU1ELESBYY0h8c6YPjq37JanQhSJSsBPfYruSOAaw4wRzi4W+CipKfCuESw/YTErlglol0gG3beFbp6ZHJafTf1T5yajstxFd6q3TluJOVG8DNnuUagWYrrL1cZ4cZ73ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AKRQcvo5J4iDqXd1yESKVO4LUEpAwanjBrOyPziXNM=;
 b=KbxRgJxvqGCc5Q+tX2yg7L8NETo7ou7AQxGsKUoxtlodDJY2Xzdgik0UtHd95vw+Y5foX4cEdcU6RzXt7WSvfV0oXUxqfwtHbVBova3g6X7FkfBqpTQziq/sdBCA3pgtTKcaL9MG1+Kd5MRy9Nb5jEfwPYXnB35viXA+5KAc7ewZigApwyTpmkKVIMXBebK2RVX/HZMg7P5JZHrKA87MPoqPeg/3UZpAh6pVgls4Ms3wqeVhRslWNuBUhobOahdiLF8zQHefBJOjN0jHTya4f3nKduBXvfsObLzQ6SjECgJ8og3pjfFhZY6iauzkEXEjTUqUhmwr0yX218ElPSKn9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6889.apcprd06.prod.outlook.com (2603:1096:990:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 01:19:18 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:19:18 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [RFC PATCH 2/5] f2fs: add inline tail disk layout definition
Date: Tue,  9 Jul 2024 19:33:04 -0600
Message-Id: <24fd8ff68cec7e8bfa1f6d3a676425044e21acb2.1720515215.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720515215.git.bo.wu@vivo.com>
References: <cover.1720515215.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: bc23e70a-bd73-42d9-4fd9-08dca07e5206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nDxQlQzz9OkFOc7YUcvFyDJrWPoI8iNnrWry4IHvAtEyfHGW0FtzFBPDVyuJ?=
 =?us-ascii?Q?EFxLK4/KzRTvtH648Z/1c6DvbKZq6E6SIwa5/wO1vtGv57UcG9tK8Fq8hNI2?=
 =?us-ascii?Q?376fb6I2ZXqVtjqpdAyBwNOX73KBF3L25gqTpz1v2Eyp4swh/A6dA5XnUP1K?=
 =?us-ascii?Q?a1j0raNV5vyhWbD04ZDmwxhP9Tq990dK5e+gFggmAI3LFnxwZLbdJ616rDHD?=
 =?us-ascii?Q?mR0ndrGxc0sKZByMwqF1wAgpp8ga0BnpFm+LwJprSaq5HntcoNW62hhfSL+h?=
 =?us-ascii?Q?Iczfg0CXipUmQASISHdnidUp1Db3J/uxw3hhF7zy2rKxfmWTPvK1LoDBUHJJ?=
 =?us-ascii?Q?ps2zEC3bgr3rxAxKwAC27W9olBdcuh50iovcPBf4crwLCDbIO+sKyXlAT1q+?=
 =?us-ascii?Q?IlmCrcxsxNq5k9b8HqGUM53Aha5ItjwaMZfckoC7qUcVpRqomAywxBkG00YB?=
 =?us-ascii?Q?UwQCqJV79YpuoLWQ1H+cwmuDHa3cTGOZWj0RDl1IgsV0q57q0QwqEIyPVQj2?=
 =?us-ascii?Q?SR3anWZ/QFiJZLDqxi39QjD9sYEMZRV0OpBewq49zafskUnTACSQQU1onlEN?=
 =?us-ascii?Q?xRG+pLIahs9jVebO9zrLy4DzmIZve/8tqe0o0hz5JqENjgNZJJW9T2ZGLyYU?=
 =?us-ascii?Q?xDCQtiv6cb3PrfrsRf4dN7qj4sBuGZCb81KTXWE81hrJHKfB2Ajb02dFe8jC?=
 =?us-ascii?Q?p3RMa6Z70y7mSm9VgqDf7d+jm30BNMLTfxoXyTPSFo71svqO9rz+Y3bY3xYe?=
 =?us-ascii?Q?o9EP0Q01LIDEyOVwWbcnLAGvcMmYFdJ6mn4dqybEzHX876o+uq0iHtEtJuv4?=
 =?us-ascii?Q?U2QMwU/YWTXQh8C0daRuXIztlXTfWeo3osRUHmYwkEZtOUVbgrTcS6HrpTAY?=
 =?us-ascii?Q?byNVALicF7ktT7z58alEahovEo34l/iJnmWJStgchIHbYDGajuZe/dOneViT?=
 =?us-ascii?Q?Ij3aGgS239Rx0WKw6Syp2WKCtFD7PbhJsEYBeCBJqBEix+IC9Zh8jssyqhCH?=
 =?us-ascii?Q?n+0FHwuh+ofWTD2bqHOnowIEuVa835+T88SXPhoA8Eo9rfqvsjpBvHgv12/2?=
 =?us-ascii?Q?7V0nolVZjeiTuhomiW1QJMKgJmTHu6mqtqSpXVSzNp5mgcGZArwXPvcDweow?=
 =?us-ascii?Q?pPrnQlbfYy0QqiSV3y20e5DTFLRRrpl2uL72IkmRgP91vVWOkdrJc47dt8wF?=
 =?us-ascii?Q?Wc/hlUHGgpkc9f6de4A94JjGga9V6qSHRj/7ri+OrhfgStwx67ygm/X0QpqP?=
 =?us-ascii?Q?5gFMkoSKVxqq+O3WCPQCcp72eAIxcWWA1KFrNvqEes+zmCXixyQkl6pkbQJ5?=
 =?us-ascii?Q?AiYsAxJ3h9MsNZqYtrJOH+CRCnIsptipgTQRSx5ZI8PIYFim2IZRrfwpNsrz?=
 =?us-ascii?Q?DguUEL7B6MJV+XbY2ck25rDBrgFgeDPyzUbMZvWuZXofHkdS8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Na3ncw6t6svnO5tRoSioyCCy6wK4P5bRnQCxjeqmgVC0bcXqlxEhh+M5+uoC?=
 =?us-ascii?Q?3I++mAC5VylI8eZQaUUTiQWymSXbZPuY27mxSbzk8cBZ4ue6wFDFOIOFwumQ?=
 =?us-ascii?Q?3fkizzuGhtFB9Ok1htkuaRQN8vdf0s0gifHmEP0McxvSn8YM54MYppOVbUbJ?=
 =?us-ascii?Q?c7qWKMrU5IRiJQuCOOfBirJ6bV20Kx7OJgDPf7NXISiwYXuC60CPfwwcPZue?=
 =?us-ascii?Q?CMlAkELUoR3wP3S2r9puGSNhNTgsz80SCMBK6UP09YeZtjqAa9LxuNuFcbdV?=
 =?us-ascii?Q?LXbVBLF+ALWLVr/KiEB1pupkvg7RPpqlGwgxIXfwPvVGZwFPDu9n/2QdkJ6P?=
 =?us-ascii?Q?wHxOtwIIqHXx+dmw77n/Nef/z8lCF17BrODn6haw6otIYyzFSzn3tlKMSqBj?=
 =?us-ascii?Q?TIoKKhY7BZwgpm2lmHNGIyKZbAn70k50Kh8ozAou/AjOWixFU8fEMbEvinLn?=
 =?us-ascii?Q?GB0CROv44bQjBtb5UDId+O0AkaYkXcrvTt2UA28BqWNHlm8ClY89Zu2WEJA9?=
 =?us-ascii?Q?PVDNtHuO3KPax5FYvVQSDRsTUyo40GLX3BvMixtWkOFE755QwLEFASnJ9duI?=
 =?us-ascii?Q?ECaHe6bzQzhWuep+dZLeh/59Qk09fyLjbomv95S30ynFqZsaDylWlcXh3S2c?=
 =?us-ascii?Q?rS/5ON3gRv00aa1Kla/X6fVgD1yECVZfe4MdrvjhR9fGwdfOVdm2NPmHZydT?=
 =?us-ascii?Q?6xgbWQocOgLPEh8X+UysDKTtB/Q9tkmGMiOSOJ1y+eYC1IMq4VI8/tibL53V?=
 =?us-ascii?Q?9Dlb+LhI06fPPS5XmDDtQxcvucaKuTggKIbtN0XMs6kgSBfqF+V0qteexjhr?=
 =?us-ascii?Q?HTs+ZzrZshP5ByCYLUVkQC6qS3xQi4c4wHk6cbhq02cbmZozLUdXw8Z9lOAb?=
 =?us-ascii?Q?5iZqeHc7LjNkqiUyldFpR+BlIPgii35UhsDM6GJr2cOsMc1F0uvVJm/WhzwF?=
 =?us-ascii?Q?LbctrzcaLVbF6apGwg32KCqG1012948AkSgHa/RNvX/p/4NF24lahuGrb26k?=
 =?us-ascii?Q?/csmNdjfIo4YQ2Hm2q8OgTwc/gkP7dMUb+h493TT97Aba5qG600n3oX6lZwv?=
 =?us-ascii?Q?QxGifjJD4mY/E4TjKl1o1RfZrpmQTgaauYa1m4i421AR9k5CxGxa0hp9Fdl+?=
 =?us-ascii?Q?ENJMs7GUMrXNKF1Qaod6G1vQJEuRuMGn9raUe5t3lRQu4L4YVcdqaOLR8oxV?=
 =?us-ascii?Q?h90XLlzA4Y9ySIfuqf6/pSHi7qUnpUrUr8OZn1eO8jvvUWneFitrwaAxBXwi?=
 =?us-ascii?Q?+fVHbc+aWORhBumRbYVz0g0+3way+f2I8t/LczaGS/rnbtUQaRMx2EVrUjF2?=
 =?us-ascii?Q?CCcDkR/WY2zdC2C8L/wyV6bzF7Jx5H+UgsDgQHwxFr/NqrbbfRQUjPBoXmBh?=
 =?us-ascii?Q?qG+KyVeA0JiWP9TniGhcwTX8/9XR+xTUZJb7ce5dJPqXVYXZ91HfMPwezgWj?=
 =?us-ascii?Q?rB/3yGb40kKGwzTFlNJGH0IFiZonR8O9tzfTiQEPruriYcv/stqymi3Cibq4?=
 =?us-ascii?Q?BM+YEVnXveDx44W4rjl+M6iRmZ3W2av6pyQmF2QcOmwy/pgn+MIaot0Z61xV?=
 =?us-ascii?Q?gHqcC64ShfY5pmrWJgu7UiQZwxHuoSOLQnJ3ycxr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc23e70a-bd73-42d9-4fd9-08dca07e5206
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:19:18.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z34lMab2MmVUfY5h+EjoCQmKGw8nXLiEDiTeYaPJAeBJz4YtOG/X8Iqnto9VIIhXp6tJ/MsJzzgJr8RN1T/SoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6889

When inline tail is enabled, use a compact block address array. And the
rest space is used to save file tail data. The layout of an inode block
as following:

| inode block     | 4096 |     inline tail enable    |
| --------------- | ---- | --------------------------|
| inode info      | 360  |                           |
| --------------- | ---- | --------------------------|
|                 |      | extra info         | 0~36 |
|                 |      | **compact_addr[16] | 64   |
| addr table[923] | 3692 | reserved           | 4    |
|                 |      | **tail data        |      |
|                 |      | inline_xattr       | 200  |
| --------------- | ---- | --------------------------|
| nid table[5]    | 20   |
| node footer     | 24   |

So if we define compact address array size is 16, then we can have
3392~3428 bytes to store tail data.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h  | 27 ++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  6 ++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a1d8d8e0a49a..4595b6fa3714 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -476,12 +476,17 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
+#define COMPACT_ADDRS_PER_INODE		16
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
+static inline int get_reserved_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
 				(CUR_ADDRS_PER_INODE(inode) -		\
 				get_inline_xattr_addrs(inode) -	\
-				DEF_INLINE_RESERVED_SIZE))
+				get_reserved_addrs(inode)))
+
+#define MAX_INLINE_TAIL(inode)	(MAX_INLINE_DATA(inode) + \
+		(PAGE_SIZE * COMPACT_ADDRS_PER_INODE))
 
 /* for inline dir */
 #define NR_INLINE_DENTRY(inode)	(MAX_INLINE_DATA(inode) * BITS_PER_BYTE / \
@@ -804,6 +809,7 @@ enum {
 	FI_COW_FILE,		/* indicate COW file */
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
+	FI_INLINE_TAIL,		/* used for inline tail */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -2997,6 +3003,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
+#define F2FS_INLINE_TAIL		0x80000000 /* Has inline tail */
 
 #define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
 
@@ -3264,6 +3271,11 @@ static inline int f2fs_has_inline_data(struct inode *inode)
 	return is_inode_flag_set(inode, FI_INLINE_DATA);
 }
 
+static inline int f2fs_has_inline_tail(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_INLINE_TAIL);
+}
+
 static inline int f2fs_exist_data(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_DATA_EXIST);
@@ -3300,6 +3312,9 @@ static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	__le32 *addr = get_dnode_addr(inode, page);
 
+	if (f2fs_has_inline_tail(inode))
+		addr += COMPACT_ADDRS_PER_INODE;
+
 	return (void *)(addr + DEF_INLINE_RESERVED_SIZE);
 }
 
@@ -3429,6 +3444,16 @@ static inline int get_extra_isize(struct inode *inode)
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
 }
 
+static inline int get_reserved_addrs(struct inode *inode)
+{
+	int size = DEF_INLINE_RESERVED_SIZE;
+
+	if (f2fs_has_inline_tail(inode))
+		size += COMPACT_ADDRS_PER_INODE;
+
+	return size;
+}
+
 static inline int get_inline_xattr_addrs(struct inode *inode)
 {
 	return F2FS_I(inode)->i_inline_xattr_size;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 005dde72aff3..4bb098af4742 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -426,6 +426,8 @@ static int do_read_inode(struct inode *inode)
 	fi->i_dir_level = ri->i_dir_level;
 
 	get_inline_info(inode, ri);
+	if (fi->i_flags & F2FS_INLINE_TAIL)
+		set_bit(FI_INLINE_TAIL, fi->flags);
 
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
@@ -674,6 +676,10 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
 	}
 	set_raw_inline(inode, ri);
+	if (is_inode_flag_set(inode, FI_INLINE_TAIL))
+		F2FS_I(inode)->i_flags |= F2FS_INLINE_TAIL;
+	else
+		F2FS_I(inode)->i_flags &= ~F2FS_INLINE_TAIL;
 
 	ri->i_atime = cpu_to_le64(inode_get_atime_sec(inode));
 	ri->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
-- 
2.35.3


