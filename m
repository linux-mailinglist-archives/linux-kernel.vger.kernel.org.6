Return-Path: <linux-kernel+bounces-324164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B2E9748D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588C6B216B9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CB3EA76;
	Wed, 11 Sep 2024 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EkEv6qs9"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0941C72
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026220; cv=fail; b=hMiQNz2JQWsyNZqfHUxbCHyq5YM1X5wuYIvqxqs+QsY4d7sJjeELFhHFZCEjbCpx3/pvS3hy8qsWcc83/7WgWLEAuqruPCEG+UeqI/JesZWUNHqtQ1MwpZjdIgj4stRMTO0GmaEvCF7UrNiMobxODdtZIylVKYdStP/MLj440yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026220; c=relaxed/simple;
	bh=DeVPlMyqJ11Ncbh5qQOPdsxprmaTkpPrGyy5RDAnmxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E5/M6MY5tSqk+kFVpjCe44dCSG6BLLHKaM7jaI4lMKd+zmSuD8omtWlsT2K5Jskzuf380k41hteucLuI8vzDqBXucehfL5u9zaGHY/inQNLWGfHTg2sos5SrucWvnbFRHI1RmlfYSlROv9ji2QulLErNlqsQIz/GrLpfvXfgvLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EkEv6qs9; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqCkmRPRC/4t3pPqgH4h69dzS/aGuLgjBwOMUQ4IzFeIgWYon+rZ3Xqf1VCdBcJTXnrMBh7Y5WYSGQHwCvNswFSHIKjTzevHgiiwmpjvfqzNOqKUBt3LhBv7z4Bv+i2KvIR7eaSqxsdjGAH/fZO3c/hvHT2wrRxvgLVi+TQjgBc2yR91pGlv1Tw5X6oCqk8Bw8D7QaEFyR4HJcyz38yCBDe6G7GVsW7221KBhfiZupxSV2xthBxVT1SRN3lJrjFGJCrx89nYA/PEQfm8cJg2JOyBK487L/bW5QNIgs8wBbdzjcPuO36EWJiDOz6E5JNeZaojv2cD3jQV2w9nE1SpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=789fi2cjANDVURtNHSKg2uT0fvFJ1Bmx9d+l7fPmobM=;
 b=HBtTx4OzOPno7uORxOwt1TGTHjkYKTTg12vjyxn5G96QJGDZs7gk1BIIQoBVkfru932zu5GFZ6h5dHmpEPEnULJSqzTSJRj55jc11+FNDPDO23HHJ7R1fL3FytpV4wjalMayRyLEEPK+KBLpLqkZnn5durciD85TglnMzHIvNQQOTjojIn5snDDT7UK6/BGgyOFNIw3QdjBoe0WILFVv29G52KR6foYzf6zLrNMdSsLRzZ0avim8Ax0oJNsOrHp6c7o6psdeVrowhiK4hit46lpYc6d8RLMGQPaWGQmWpHdjbYhbVZiB/IGpnF29gaPLLhe3cz8PW8lsCMg0fvV2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=789fi2cjANDVURtNHSKg2uT0fvFJ1Bmx9d+l7fPmobM=;
 b=EkEv6qs99HlrVZelK9ypaCt/s5th7QGz9NuZfgCXi8QMJGsNkAxuI1JG6I4wx7UtJsObIbwPVQa599lXRis3nssolEGSxObEr9u+f/dM0sBgBxkZpHdIsrA6gVabSe7j2GRpHu1uI1vRfoiSplrWhh+ThKBQQv3IBf3PrDjbOkhBiror0je16lxyrnuQg3yEXP4k5Q0tBdLSCDYxnR90cSmOnJPBwLRyWGkdgfuq2sBqrgbq1AcN6OsbjFG537OmGJ6n9J5AkCFlvbzxKBMKNyufxHKqF6e1nKvFIXmEtxFykyOZ9iYXAP+z6qSJo/cwwNby6MWLm5uNCV2XuWTY5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:31 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:31 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 01/13] f2fs: add inline tail mount option
Date: Tue, 10 Sep 2024 21:57:14 -0600
Message-Id: <c25172e16dead5d956b0ad43201ca17a7553344e.1726024116.git.bo.wu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c6710871-fc03-413f-02ac-08dcd213e75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DkEWqez+q8xUJs+KbGF7e3ctqPjEnVkmadRsVAUBzQx0fDKTpUPF/dPbjcgA?=
 =?us-ascii?Q?oZCVKTiMWkVDOiVP4gfigR+99iL1n10/XoWhcvFoQ+iPCsUmxWA7SirG1j5v?=
 =?us-ascii?Q?zsYAauxMuos1zNkxm056jy2y//GOjT2LV84v9SrkZb906J5KzRwWPtJ5SoaW?=
 =?us-ascii?Q?p+IE57bm6ZVqwwlM1HK6roAZ0WRH/bhQPdD3fNFgOHleHvH3dMIVKouFYjnS?=
 =?us-ascii?Q?ZSiFHc3sIshg6rujBjhtiFPTuFNFWC1xGVHhkYCmloCMck7fIDLed8Sa/FKU?=
 =?us-ascii?Q?PxzKmikvaXB4izxaH4FLXVY/iB0oYuXdMmt+yIPGnUIUwzcVvx/Xio857ZgA?=
 =?us-ascii?Q?0qQ756GizM3kmPprX63rc72Zm/7ipyZZ0FmQP7V1V5lFdkjMe68xe6ps8TgQ?=
 =?us-ascii?Q?63RkHY9HX85zUZ5/Eu5DzfNy5YYzkFlsKrwr5jGMjN4h/JsWYvYfH5kJNMFI?=
 =?us-ascii?Q?VQGKw3iAzlKP5ETN8U6sSo1IHGUmb0VtXOWOQ6Gzuh9StjGDV0z3H8V4UXUa?=
 =?us-ascii?Q?p4QNbcre3jocfimEv2pCLN+dlkApIXJ0LXbGgIYbgVbqjNuTaXdzUwkLKhUi?=
 =?us-ascii?Q?GtlQ4JzMuKtv/jHdP4akCOa4ffAd6rLsBzpQRsIvPha8dbYyfe3DgKvDPdWi?=
 =?us-ascii?Q?xYeIXfYoT/pngzawIoVVhSSpDZp+GVCfLGmYIuV2VYWconq15TY8Fp6UIlLr?=
 =?us-ascii?Q?7f3AOUNQzOWBXCa9UjDYG+86QJLRCky4DpKGHjUpwPNgJBza3ewqfX9uSeHs?=
 =?us-ascii?Q?obtDgihlyLEnyywx0Y02PhMp8LLawVPFz0I6Z99FXEJZezTSKCxLaTOL513M?=
 =?us-ascii?Q?DNynY/jp0mkbvO4L1ublz9Oz+9No7WJ31ae41alnMHYGSjpFaTPTJ9hedz5F?=
 =?us-ascii?Q?BleAJR7KsBIddMWXOGeB0ShLrcv2eBLOXNyRHASPdqB3ReKAYz3Mzh8ZBDim?=
 =?us-ascii?Q?lwaeBWvT2/IntLH8tK0SlVdzIWLLvQfUP2rJC2e01T+TvZPbZ2+JxIiSOitF?=
 =?us-ascii?Q?4fYPMA2QlTyZsd7KdSYzpn4U26QZyNrfjtKp4t+SX8fwDpoytI9H8TZqsyTx?=
 =?us-ascii?Q?yUU3orIqdo9nZS+yjxMfNVkLXbCYr+PmMpx7Hi0RBNn+qgo5joFL0QtYOa1Q?=
 =?us-ascii?Q?SaHdO1ImyBVRT/rBKZtmeoyy8vVwB6XAULU3PbbiW2OzLPCahZLVOyzJlpaW?=
 =?us-ascii?Q?o1k7jG8HK25jdWyK5OrxnJqxC9a+Se9GRcRqomIn0FGx6yO2wPvpBBGxsbUA?=
 =?us-ascii?Q?NxAV5gK8LNbNUSGlesOdvWii7ydczdc3DZEOayabdTAkJ91d7Tz6ZHpIGsFS?=
 =?us-ascii?Q?gPlMPWva/9PRg5g7twlMIa1RtcqMnPeyVkp8N9uJVUqvkLl5LpLOLubdJ1J8?=
 =?us-ascii?Q?cnzWUEyx2lG74/vHwnVE8392p1aQfWPEGc2AA7TVp/dPOsyjfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GOlSSmpk9ZGl6RnpTwF5ohzmg3uTwU0CluAOyZ0L1OWde74qvGjCn5ghetXW?=
 =?us-ascii?Q?SsqoJREhYoxAgox06QWKBouho0xsRKetAPKou/bJvU62O20V39Icrlt5wJs2?=
 =?us-ascii?Q?iE/FdRH4TmbDspUKrwC8iHovoUHfUxnVVwLvWiY/WxsrvYnfCGM5ZP3EgTIW?=
 =?us-ascii?Q?siKds2pCfK21Ot9/N3vDMq7N5ZDk8vnER+lRpTRaKVJjPPKf1FVJ/4/NAyoQ?=
 =?us-ascii?Q?4hGJjEzjohlczM6MG+rz8aJtAHBtZC4umEmZDOzFVVJorYICV0Mca7eML15L?=
 =?us-ascii?Q?FxN/WvdslVFBwmNqHedIXvb4g/Uh1QDWfTwUOKNv7Uj+9kvdP+ac9I6KbUT4?=
 =?us-ascii?Q?hCJhpj6hPOOyrCOwmsthcFAz5PpujsnOhj4mSs/Xz0L9v4x1+QAQ1exVbIbJ?=
 =?us-ascii?Q?wAPtWOCgLKdPCwW+avIEGAZWOc/kMeFLxhb0MVw3d3Zgxsq23Upsi7GNady5?=
 =?us-ascii?Q?jVUgCrVPAAXb2+s2915DJ49cqsOSvzIP/8VWl/wD8oyQR32sb23+su9rOvXj?=
 =?us-ascii?Q?rVC0t4tTZ4Q4p4ta/HgXB9spbvHadvu/SNvaYq0+w/2yqB1vwMyfmQMPw8Dy?=
 =?us-ascii?Q?T4KZISkhWJnJOHoDhmlIJEXw6Gk18QV6bKAjJLLGuGHvBdGmad6EeWFTwqHY?=
 =?us-ascii?Q?vikJsiE13ksjgX5Ueqh5o6tCePxT6GGTohUXncjh2QMHCeY20DTjn8GNjzPh?=
 =?us-ascii?Q?1pIOLM6LSQEPkoQCMnP9AIRVYB4RDHeiSx30jHtccAl8WVjfiekDEKyL+SXo?=
 =?us-ascii?Q?dV/KxXHsCaAUlyXKBOcgAYo9WdSoA9Df9Ik7wERzSrK/+UMUAvottMU4T9b8?=
 =?us-ascii?Q?1bgiGULggir1dz8kyOKNueP0+Gt2yXG/4SdF8ecsMsFC58VRHmJYZMrGKx3p?=
 =?us-ascii?Q?iDHVDhQqbKhlxxbKv2qJbrN/LcGLPz84yLIct/qXzAqeO5UoXka3MDuND4wN?=
 =?us-ascii?Q?qNfK3HyDC/XLLwjjeUDbUNai4dulcw1zflqxFhWLOFY+sNf7vTk7YE2BLmrR?=
 =?us-ascii?Q?qqc/XKXUsB9WmlTdTfZgwyZoCWtYM1W3CLizsklq6rmJMRnhqsu7LXfIxbcg?=
 =?us-ascii?Q?kCemlfAPTuHW4rbOIZuuwIAhy/NhLErM/WyPGzz9iGET5YuWD2Wgpp8ii4u1?=
 =?us-ascii?Q?Miqz7oJUMFCE+0BJlIAXW3wygXbhLY6AJElvhUl5ZWWFJAd2aNG8TYebf0cu?=
 =?us-ascii?Q?Q51DnFGuO0gRZiQ21sNiRFsT70YpJFWrcip7d5NyMhbbUjRf84BmUuX3YSrn?=
 =?us-ascii?Q?7O4EXB/cpf6wCNQwuOEH+o9GJ5UrIpPmWQsZbuSf5rsOPQHald5m/4KSMD4K?=
 =?us-ascii?Q?mwnm3zA1s9F1IWlKaQykTMUBiLUZ29CHhYTuYJFhEq2RoiJbeKdy9/cd8aQI?=
 =?us-ascii?Q?gz+Gtn4AnMxmINVQv/Qepy0UYhUCg52DymHusQbjA2K2iF0n9EV0JLiPgT31?=
 =?us-ascii?Q?Zf1ttyLg6gXoHPxqc5xT8iuJJgzDo4UGm7qPBbt0iDGaCp6qrVWyHHLcKZpi?=
 =?us-ascii?Q?OF8DZPgOFQpUuTDzZsF9yImcOEKSFSY36NVQBKeHTOSjHhD8p5adhOymDwNZ?=
 =?us-ascii?Q?FNu1np7az2v6QceZDmc6NK7O2pcSfEpDT8gvr+A/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6710871-fc03-413f-02ac-08dcd213e75e
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:30.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTJ1h6h1tSEy3fJF7DUtqKrhvv4ik7GuX2xwTka982vS3HCxGIsnavxmhHErs74zObAkmR9CiGiQfvjGhKkDRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

Same as inline data, use mount option to control inline tail enable or
disable. And enable inline tail as default.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac19c61f0c3e..3956740ca7e2 100644
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
index 3959fd137cc9..d4ec32ba6cad 100644
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
@@ -212,6 +214,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_noinline_dentry, "noinline_dentry"},
+	{Opt_inline_tail, "inline_tail"},
 	{Opt_flush_merge, "flush_merge"},
 	{Opt_noflush_merge, "noflush_merge"},
 	{Opt_barrier, "barrier"},
@@ -220,6 +223,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_extent_cache, "extent_cache"},
 	{Opt_noextent_cache, "noextent_cache"},
 	{Opt_noinline_data, "noinline_data"},
+	{Opt_noinline_tail, "noinline_tail"},
 	{Opt_data_flush, "data_flush"},
 	{Opt_reserve_root, "reserve_root=%u"},
 	{Opt_resgid, "resgid=%u"},
@@ -811,6 +815,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_noinline_dentry:
 			clear_opt(sbi, INLINE_DENTRY);
 			break;
+		case Opt_inline_tail:
+			set_opt(sbi, INLINE_TAIL);
+			break;
 		case Opt_flush_merge:
 			set_opt(sbi, FLUSH_MERGE);
 			break;
@@ -835,6 +842,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_noinline_data:
 			clear_opt(sbi, INLINE_DATA);
 			break;
+		case Opt_noinline_tail:
+			clear_opt(sbi, INLINE_DATA);
+			break;
 		case Opt_data_flush:
 			set_opt(sbi, DATA_FLUSH);
 			break;
@@ -1989,6 +1999,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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
@@ -2138,6 +2152,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
+	set_opt(sbi, INLINE_TAIL);
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-- 
2.35.3


