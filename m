Return-Path: <linux-kernel+bounces-246840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D292C7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8CD283CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485EB8494;
	Wed, 10 Jul 2024 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZpNbPM5Z"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2051.outbound.protection.outlook.com [40.107.215.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADD847B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574358; cv=fail; b=IoimxRe6aliZQ9DLbsuTwYHRKdOH5Cmmy4Oglh1l46ZKvRoHLwwwCXsMcYp0hB3QB77n1VHiJTvguxlnaoyKBWnLpzw5mtASuLRgnRjE+xk7vSqslv3OshYDDSBwd93no7Ml9aJoPiJd+7k2A2DfJnaNUXBuchnpI/KEIHwYW5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574358; c=relaxed/simple;
	bh=9v0DjfTnj6MGkgB+Pbq5y/cW1pvlJt35lOwRHUWfIS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVncVmh6tmaDpmL1P+GEDSQs1RJedJMKwVB0Lv7+5z7pBVpE+M8ly9LR03HXoE2C304r3aK5oxudgd5ZGrSfrDkPtQFw9BiyfC6e6Oce1vDhQuLPJhT1hkId1fxWAq2VMIA+3MUxqrut58f2ggqhHV73v+Mld5UHLWF6H06xg6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZpNbPM5Z; arc=fail smtp.client-ip=40.107.215.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5pAS2cfSqg64UpKOz6sOetChKQJb+wY/Lgn1OP+mpA4yVRL2vF0eZ4OE+rIJ771h9QjZ2HL5OlcaxgB8tD11nxwoX3XIi6+RIxKilNHjXIXDnQXs+5gxcCGAbiLQlzLjZrigZsdF6sy5SemOil4jWcQ8H2gZzw5RBKyHWISdU0KlaUO7Cr/zTIgslKTjvJRMSjrWP+5iQZY9rVrt6qjeVVj12iCROi6hp0mBG1saVRzeklL8RUt3H52CZY9n6b6OARN3OfGRfGKCTfu8M83zL81T/GnYBExMoueYSI2H6kUXJUaVXIy87JyjA3v/erQPcPN6rHAkjACJ5dA8sutHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBaH0PkeaImO+eKS/ucYKs543kc0eWiiKQ/EnznIztI=;
 b=bLKp3VaA9KqZyeX21bJACTqbeLTtMxX5nGJ+iNoN5FAV6lwekIpSqPKevdnNZNmV6vRCZ8F2Z4ukCBox4XTFtbmfS9eiZXtejFeFxYlpGz3H9o7pA1UNFvrAjhEocOJhCVcmKUd0V2aQsp3YEg79CaFGtdrmNuuisj+/IOn+ZakbRsRqi9NKxpmrHI9sLzJmilPkI3nCIWpeadzM7niX+UhVVeyHPXf8gNiQtj0yA9sU/ER2YPgjbTLgQdFBqRT6sy5n7pcbAiw8ZqC7JGUgjEzubJw6Hg+ebaWP0yk627cmSrNhnJoa7n2rrQcgLlMlgIXKOo+S4J3ogRzvt/Y9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBaH0PkeaImO+eKS/ucYKs543kc0eWiiKQ/EnznIztI=;
 b=ZpNbPM5Zsh94Jv8G0C04EZcN1gIdTZJMq3yhbvIWQWs1jZGnhFTAZ4TPePFWsU72BvQM55QmWYlzOiB/k43RRp5mSIPMPViHrGeU6l0f/Ba1DHIYx9QHNarEvZ7xG/vh+39IsGgfWrsLG03cuXyOkJhpNZqd6HgTV1gYHkXLF4RVJ0fD9ZGRzt968amjzDiKiN6AI3RqyJsCxovSV8viU0vRT32jlFzCg32DW2R7euylL4rsxRcbiREdw8xJTiYkHjfLvg6msVwPmapflG48y0S1umh7gBvh3yXpmEAbdwEuaxn8z2udG9vxk5LhwDtcRtbBgsuAHn0oSWO3OD/2Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6889.apcprd06.prod.outlook.com (2603:1096:990:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 01:19:12 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 01:19:12 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [RFC PATCH 1/5] f2fs: add inline tail mount option
Date: Tue,  9 Jul 2024 19:33:03 -0600
Message-Id: <4c6bd9379897e65dba427ba1f63acf09fd05fa72.1720515215.git.bo.wu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1e1cee0-4013-4f10-3071-08dca07e4e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?em9VO5cvhSErvlypZ5E+4BgN4KDQv9G/ilIT0MWcNmxXOrkm8/43K54lK5VP?=
 =?us-ascii?Q?kO7zykQUGkSVELiiRonUiN2kXBnqO1clBxD7A0w1/0ekgvHQJ0/P+zU2FYDM?=
 =?us-ascii?Q?qOB+oaE9DKfHgy7tZHvRYpcEDrGwe+Npa03fbH4PbgYa6Gq19x/5tfJfn7Ni?=
 =?us-ascii?Q?qARzA8h9I8GlycoPfDJScMa6Q2SYkwvQv3mIhcbHSXfZwECmXuk6gAdRdheg?=
 =?us-ascii?Q?c9Ap2PuBqwgzl+mqA+4r086G6CZST3AKze5LiWBTNp1yg74Z/kLNnizgbvc3?=
 =?us-ascii?Q?+luzNY+Dhayu+H4CbzQxSDgAxm5Pak3w/EmOzXUWmiI7HR4z2ZsPst1n1bzP?=
 =?us-ascii?Q?AcGyF+qYysTzvmTk5QpGn5WWpKHXen+zQr6548x6JBErcp5QzUQtDyL25xMO?=
 =?us-ascii?Q?qYwGkGd+Gm26S+oagVej0iPBosEtf2X1LYYVzweKbKGIGrrLz7PLy3+42Npc?=
 =?us-ascii?Q?nll4URBwByBbo+zpydzvypBX1IBJ1yuLEz8PipkXmTlt7HREkMqknUmZjNH+?=
 =?us-ascii?Q?aUbPZR1udA6M6DifFb+BU8EHIfCl4iWFgyx8oNdzWn8L4Lh0IbpCI8YSLEGJ?=
 =?us-ascii?Q?tUnwJwEWUlhcJa3Wym6VamXZ61v/ArXxGRmNwwJMpDzDdLL6n/SPh1RwOeMR?=
 =?us-ascii?Q?xsm/kgzdBwXdSxN2PaYe+65SoVCZKorXccdmJVuOIR2kRW6lxCbR8FPJhRRO?=
 =?us-ascii?Q?YFuiT4ie7o5Fr/E5NcsZoR8l+gtLhOoMpkbyU5ecwhgdRqf3B/PwoybGL4Uq?=
 =?us-ascii?Q?sm2xlTRLAs0Wxm5TWs6OkmWmaXmLwBsHpIgdE3KC2edWA1e+0z1j4kX5U+DY?=
 =?us-ascii?Q?o2MAx84+h/yQ3mAgvzF3hm2zNJszhqjyF5bqIyno9knc3Bmp+Yq04uLf5WWm?=
 =?us-ascii?Q?5cnhNRXPSAxDxpsxL4LfyQSijWM1tX9fX2mhDf4abLRCM3r/NVbCzSN+q2yH?=
 =?us-ascii?Q?FO9v/ZpLzzI6MTH+Qd0uYxgwjiN5WRu5RWErr4u+qijGuJ2N68rd4jkJJhje?=
 =?us-ascii?Q?Bjm4Yec3E/WYD13jKHojjN8HmvXuFt4vyfqtE0tzXxhqtA3LPPhLE//OptwW?=
 =?us-ascii?Q?8dbogWQww/GV2PFT3fsrpQA1HNIbNzwjF7RzCObnX+EiIczUE/L7jx7b2CWc?=
 =?us-ascii?Q?U6I8DbELqVtk02g4E17ZMO1ITqiI7TsrLcF0YjZnyk+YXpEezTxDNR+8UaxJ?=
 =?us-ascii?Q?5ETX/5ew0QIWnbp+D5c9hgpn2lWG6uTc6XPZ0p9KkNuyoJ4skuk707qQSqlp?=
 =?us-ascii?Q?rqp3araxmURZU/jv7XHtKSg989HZ+KjcCaf1eWxqqZZKVj1UESCnLVSyxztN?=
 =?us-ascii?Q?6rRAcMON1InO51LhEgCWQAM1SUQ1PJvC0/07wPwm0CYbeCfuSpQ+YXElMvdM?=
 =?us-ascii?Q?8CyuMvahtwzCOXFOgfbE91Nmo2y6y4EGeBwNPO2UEeniewj9xA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MLbJPfk1entlWS+P+VVltq1W4ruELawFJE+iH6O6UoZw0QJRtwHTuan6rdmP?=
 =?us-ascii?Q?V4pPdtctTpQYxtbRx0lLuqsk6MRgP1DXa+q7SftbmmzvhldSR30mZGiV6WNQ?=
 =?us-ascii?Q?UVN8oCBjRYaJhs/qD7vzQ4D5D5mILJ1//cN1bBd1UR7uHuUiA1ZEpjG57ucq?=
 =?us-ascii?Q?KSkRGZ6BjcbVmZ1XuEuyzdNKoyrMlNwI5u6bCVWcBRluT9W91p9I7x4PA8iD?=
 =?us-ascii?Q?G8ZkoS8O0TVUuVMGI/Yt9NFqID7729Fjm+TGcqAmnr30YP45z4zh6B3S2Blq?=
 =?us-ascii?Q?hNNZg9KmuUSRrP+gBYF0mrmHG71khoz+IsG6Zmv0R2XAt0puidlcARypj9qE?=
 =?us-ascii?Q?UaCJ2PWUYAMkhG5VWs7aZyLcODH2YvOsF9anbtif/M7XQAEXzDAx6rVd+mNo?=
 =?us-ascii?Q?NHyBgTxIWqyOaZvDbXGZvPmtbN5HKtIZABsTp1rmuAv0k5iPGlZIkcle01sm?=
 =?us-ascii?Q?nSUwS6RBkbPnmm3a6rncsEqBVc9aKbA7jXBvvsT4419uqTQ3vPExsM7kA1+i?=
 =?us-ascii?Q?Bh5uXqum6XSIaz2/p/a9qhsV8d43Rmoomv1U5PdoUi1XJbLzGwM8AbiqbsBo?=
 =?us-ascii?Q?mW5D197fIYXI3u73nkep5emEKH41QYm4fv1gnGFS7t0bJrBvdXxneQLn1SPr?=
 =?us-ascii?Q?ShDNwOdTmpDfqPMk/j7TZuHdmXkLGSDud8qhod45LyotnxstXENusHBOqTx5?=
 =?us-ascii?Q?E1mSgbMdh/4RGPMk4PNCGAy2Q8UwS2QkRveadh8HiO7YCxusnvBAvmgPBRsH?=
 =?us-ascii?Q?w62QAM4Sddp7ZKIZRqNKWS61PoWZiuYEX+yOQ0Kt69PXpkdrNPyBm48FlrBr?=
 =?us-ascii?Q?Bnlgzp1Wn2lnqzS/8rnt3x4D899t7u5y9OXJy0D1L1eJvV0XTI0Xp0oCLDI1?=
 =?us-ascii?Q?uk1p81BE+pwCrMkR2lzNSXVN4etEr0CCGCWDyCRyeFxk7sN/ofqfjBT1rgRn?=
 =?us-ascii?Q?Cvjvi82cqxNO9SEUqceoKnyd7uXnMJ/cg2sw8K14D7nnmsIgBsLh/8tBHG8P?=
 =?us-ascii?Q?wCKIisOkVCRimBEXvUt2/c2jufGiOVQhipRJ0/JYELYwqOm+agyedA/6dWIR?=
 =?us-ascii?Q?0bEjvCjj7jn65vaqfz2pCX5r5spah2PERmXcvIfZqvsg0MADjg/k6BOiJAWL?=
 =?us-ascii?Q?o9yVWVSrqtXXwA+f6eGo3vOXzTeZ7KqAtIbLz61yowuPRD5bGBA/qH0bTtsA?=
 =?us-ascii?Q?Jm4ad5jyKDT0XhUMysPb6aHYSWcX/OvZbnDtOT9z0yMjn7fcaIOUHZyCPE1p?=
 =?us-ascii?Q?8h4kopdYvpJByB0+Ktn5QCaJBhyk7MfxN5sPNK393Fo5JCyZp4cCoUFVRg8O?=
 =?us-ascii?Q?cl2RilPu9YW7N4drcAeYH/uvW8+nHz8ASd+qAm3yvYOdzrwfFPAEnBEDa1NJ?=
 =?us-ascii?Q?+ifG13HQFA/extbRbGXG+tQUr9EudaehSngJawxPtagoWencqN1YnNndKvAe?=
 =?us-ascii?Q?6bpuH9OlN/TcKFFvMG8t4IcRSc+h3l9oLaj1H+FiRacoCGJHYtRBdRCyprjE?=
 =?us-ascii?Q?4qoQGempGzlahrxW1h1LTA06iA+CZdEG6+5lRqoPlnM7nykwr11Dju0i33Vc?=
 =?us-ascii?Q?k4xry41SjeXyzRhYW+nXIJRo/5NSupwXNaHwyxpj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e1cee0-4013-4f10-3071-08dca07e4e8b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 01:19:12.5301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9qmzMormzweZMZaF5QkoerklvdnzohkiJmovV7GXu8M89osfWansaEhx3+db6xENe+EFHWTA3MOibG8rDiBCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6889

Same as inline data, use mount option to control inline tail enable or
disable. And enable inline tail as default.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1974b6aff397..a1d8d8e0a49a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -116,6 +116,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 #define	F2FS_MOUNT_GC_MERGE		0x02000000
 #define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
 #define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
+#define F2FS_MOUNT_INLINE_TAIL		0x10000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f1b3647a998..5cd0466cb37f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -136,6 +136,7 @@ enum {
 	Opt_inline_data,
 	Opt_inline_dentry,
 	Opt_noinline_dentry,
+	Opt_inline_tail,
 	Opt_flush_merge,
 	Opt_noflush_merge,
 	Opt_barrier,
@@ -144,6 +145,7 @@ enum {
 	Opt_extent_cache,
 	Opt_noextent_cache,
 	Opt_noinline_data,
+	Opt_noinline_tail,
 	Opt_data_flush,
 	Opt_reserve_root,
 	Opt_resgid,
@@ -214,6 +216,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_noinline_dentry, "noinline_dentry"},
+	{Opt_inline_tail, "inline_tail"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_noflush_merge, "noflush_merge"},
 	{Opt_barrier, "barrier"},
@@ -222,6 +225,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_extent_cache, "extent_cache"},
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
+	{Opt_noinline_tail, "noinline_tail"},
 	{Opt_data_flush, "data_flush"},
 	{Opt_reserve_root, "reserve_root=%u"},
 	{Opt_resgid, "resgid=%u"},
@@ -815,6 +819,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_noinline_dentry:
 			clear_opt(sbi, INLINE_DENTRY);
 			break;
+		case Opt_inline_tail:
+			set_opt(sbi, INLINE_TAIL);
+			break;
 		case Opt_flush_merge:
 			set_opt(sbi, FLUSH_MERGE);
 			break;
@@ -839,6 +846,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_noinline_data:
 			clear_opt(sbi, INLINE_DATA);
 			break;
+		case Opt_noinline_tail:
+			clear_opt(sbi, INLINE_DATA);
+			break;
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
@@ -1999,6 +2009,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",inline_data");
 	else
 		seq_puts(seq, ",noinline_data");
+	if (test_opt(sbi, INLINE_TAIL))
+		seq_puts(seq, ",inline_tail");
+	else
+		seq_puts(seq, ",noinline_tail");
 	if (test_opt(sbi, INLINE_DENTRY))
 		seq_puts(seq, ",inline_dentry");
 	else
@@ -2148,6 +2162,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
+	set_opt(sbi, INLINE_TAIL);
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-- 
2.35.3


