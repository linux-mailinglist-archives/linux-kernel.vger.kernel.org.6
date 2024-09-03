Return-Path: <linux-kernel+bounces-312490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA6969765
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A12282A12
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209DC21C162;
	Tue,  3 Sep 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WewX4qOd"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EA21C163
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352851; cv=fail; b=rKmNW4h5F24xXOw/85YQCwXQrkoWm8GF+feZahjW650qTEXVtt+kud3h5RXxsz+5Oga3TRBwx+EVJG6SA/Fvf4ZsH8Qen38/JC/wXXptuBINs9NbLFusx/je+MKEUe/q3qSDSzCLo/2rrIkc2RQHbla0AVdlXUnqme0a/+KxAE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352851; c=relaxed/simple;
	bh=DeVPlMyqJ11Ncbh5qQOPdsxprmaTkpPrGyy5RDAnmxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4R16SiU+3RYFSwqfrNCY9l3GSHoieVfBSB72SG6iDGoMZcueQ3aeChotsVNJAkfaMYzZo6WMu9Ytia1XuoHJL/gfxjvaWiqw36Zt+ogvsQFrcBNZT2E1iihpe6c4tWawubtz4r/QxquNeBJ612qP88RkBb6tNaybri+TeUS/d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WewX4qOd; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaTbhq5i3xtJqMgf9C8/qdTb/vC4Hn528HaMDgTFW7TtuZU1xgmNY1I7W+Fza0BelkjBlzwZvn+8qVva8O8OIQhM4otxNNrqgId7kwMhJWb6zZpsReGD7ZBgXi/Jpcs3RlmdFno62TrohBkYx6vPf4CNjSLtMQbDV7aKc3v1DmPyHcUNHOGpLHEUe1AC87rXP4YiPp5GYZjtC9FvrHQJLyiF1TBjrOY6cg8wRrUqActltdkYQ+ZGCCak32yllymXnKL1leakZmTCh4c7y8B/3sEg1OPTesGVx4HsAs1SkcopaUQGdqnz4EmKY+5bnwgzbCClc4/tEVFycVJokxD/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=789fi2cjANDVURtNHSKg2uT0fvFJ1Bmx9d+l7fPmobM=;
 b=MlqQtEQ7j7MHPoDnvLD7kVdEPGWJ3QVHqAleoSmrrruMGhFSZ0gYU148AzBqz+CmQJzbKKSJ6y9clbOJ3YJd+V55ehAHL2iDb0YzESTh6e3boCkqDzVS9tfYrq7qkU2S4+Ylbb+Gm6anWJYLFJJAcHGav+ZQQBcVAdRnI+F+TWSghtcxwdGkvYsiehUxDbvBYSQrh7SfMOx5MKI76z9yFbQYo5WFRAAlzRM/05A3m1LnojYPkpbwhcz6oUgP/VNMFFy++iDVLodKAXT4fOELe9Ui/i2Xc1rfFRbLbp1Z2EYiYhZDHJnd7lhZaK+fs30i9rJ+Cogjoh35M6znEO6UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=789fi2cjANDVURtNHSKg2uT0fvFJ1Bmx9d+l7fPmobM=;
 b=WewX4qOdRSnb5QLSz05o1J7F/Qwjh/4M5lGrN6UjIHuDAnwvhp1odZLw1/j2WD3J2MH1FB1QchIc5bj88AKY1MLVBzf0Hv+2rCsBpyEBSw7lwaL88UvakD6SQJ+bPLbcu/f1LRqA7yFoOBM+vpzGwFP9aK9iy3OZmWiBMrczEfnaf14KOqWet9cqC7o6JdfnFCVNTg8vc1kz8qAtzZNglVySV0t/brb9bSD0GliMmle+0e1vbTzx1UniIuHQq7OR8RHe+aXinzQ5aFyV4f638gGPYoyEGA/5r1FIwHAWeDopMfcP9NTMNe0ZG80slrPGNgdn9qT9wVodWGYgNd3TXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR0601MB5536.apcprd06.prod.outlook.com (2603:1096:820:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:40:46 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:40:46 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 01/13] f2fs: add inline tail mount option
Date: Tue,  3 Sep 2024 02:54:45 -0600
Message-Id: <c25172e16dead5d956b0ad43201ca17a7553344e.1725334811.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725334811.git.bo.wu@vivo.com>
References: <cover.1725334811.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR0601MB5536:EE_
X-MS-Office365-Filtering-Correlation-Id: c70d39a8-6e71-46b9-e93a-08dccbf41ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bWBE0kUhf+9e/UevVquHW6mKy+EGI1G72ekas64zTtjE5XJIMmkTuR2hXhlx?=
 =?us-ascii?Q?Ks/UNCiXeEo0/EKJILJiSmwCvIHA9lVj3/Xo30neIzxmJRxIXUp77qD3ZdSn?=
 =?us-ascii?Q?71ehzj3+lLSOC/cfpZCngs3qQVDX+U9E1Q59e5+bsvBlblzDaI1JwIJ32rIy?=
 =?us-ascii?Q?C1lahKaJIyB6tApjPA2JpUdbvqqvGwdnbVWVKgqPJ5b1miL2wjRtgUg+0VLC?=
 =?us-ascii?Q?v3QVlnTpfU58sNwb9g9Oy4KDc6U7rWXnE0n/VCJuFAwqxP0k0oT+wTcCg7tp?=
 =?us-ascii?Q?qbSNCOy8x8Jrp6lBdeWQUwF/RjUdypvYEFzWWDzeXat+QRUheE3D4DHqsaRz?=
 =?us-ascii?Q?bl4aRudEo7jwzonF/TQbTdxGm1rJmbwLv1rrbyW2c0+wjE7aL4ULSvqyVS5Z?=
 =?us-ascii?Q?Typ7GZ2YIRkdKNzJn41sD+YE95NkwF7P9YOnYJnlQhtUz0h5pkCpL/MLDVVd?=
 =?us-ascii?Q?WJsipA2U6WaNA8G43MNb/uv1+GI1qPgLSepdFCSm2LWyAsoUrHcA3Jea3cr7?=
 =?us-ascii?Q?KeNrz4I5rcg1eHvAVyDzx9+oznaY3n/t5OLPOYdipsk5Xl7F++Lpu6mqwrsV?=
 =?us-ascii?Q?CSLaEtTqQdDkExyUwa9g5+Vb85X4ljHKX/WkrZUYoTvQ5a22HYiyXnYzLWtO?=
 =?us-ascii?Q?XDiTHv7HEmHxINKiEjoyeNJs11+s7ySAFkpeUFG5cYfhL+v0wKUcjlekuNuy?=
 =?us-ascii?Q?qcSnxFU1wT0gmMJVXjEmUJZOxVoTt6jKFZUN02op+6o1t792MiYrTPhZXIvU?=
 =?us-ascii?Q?bmmlmqe+6DcKWn9nf434Qrm9W1Sh8SG6Lp5J2Dqnvo2ifxqYjN/m9PMDrkIh?=
 =?us-ascii?Q?glyKQe8azWA1lGvI+oSmA0YaHm8xpkQAM9k/h2SVIqImZnn3By6s8njf8vtv?=
 =?us-ascii?Q?Mse86G4hywAhoDJsv/AEmmsw0HN+vw+ZYfjZy6ZSJ4C9LErVsDpvIAFX57iP?=
 =?us-ascii?Q?GMAR4rfMOc96wrg5K9T01ZpChmOQ1sA+8Xo18erGbIop4yNCfvjAupff0s5o?=
 =?us-ascii?Q?E99RgVecUV07ZkanD2lzqh5n8IOpRyrTY47//hCStjwjRfzWuf87hhIJYo8W?=
 =?us-ascii?Q?nFwXo5+IxZtfJyCRyNZcW4iZ4DwQVcP0nD3R84L2Oqqiml4+0WJlUXwc1Xe1?=
 =?us-ascii?Q?4sfCUyPTmh1f8xxWdfcGxTaRJA9XO1VOuwADeo0qKC1CcrYFGUfv1qPyJ+Ed?=
 =?us-ascii?Q?OxuqNq1I9Q6xI/WsSHdMyZpD2kSD/5ooNKYoydC1rTWlvH3Lp6UgDXF5uRmQ?=
 =?us-ascii?Q?whts4xCpu1r2UBdeL0Oj2ZAvdldSU/Hz2te5RI+U/Yndom4rUdzvDGWS7HDZ?=
 =?us-ascii?Q?47+6QANWDDbqPXpGuJjdtArzzPyZsTkuct7WHHzbabsAMJ8xlie/NLhzKhQl?=
 =?us-ascii?Q?v/JN7RaqB974xKyv0nJDE1qE6bzSoGJPaQ9mlO6mCPm3I+Vz3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIOmbTNxLUIKDjxfM0jiJ63skSLME2TCKre5tDlCaB3LcycUcCFk+WU4I+/O?=
 =?us-ascii?Q?1WM2eFXsVk6kQEa/fsQwWcQMGl1ElPWTBcXaG906pe9P6Hu1wnaJg/qY5U63?=
 =?us-ascii?Q?TWHRoZhVDCV6tF4KspecYVHJ/cXmGAY4iM1o/xIBI3t0b7pXrfZfByACxLEQ?=
 =?us-ascii?Q?wsqKXCW9FIFDCxmFx4qROMgxtn4MBbdVdZxiObiyV51T18LytwGPYv0EpDjR?=
 =?us-ascii?Q?mwQ0k6UxmovU24DppFOfizYYTTXQFvKK7j1E6bV1CMWrhIC/g64Q9VkOclaU?=
 =?us-ascii?Q?L1S+sTq2XqEGZF3Ez+BLvyZoNRh0ZgrL9Tz2I1pkb+/UFh37qvntmxjr6rDW?=
 =?us-ascii?Q?6aQ6DCyUJvzJycXftAqBOfSo82WCJlx/UGv2+t9dDDBKUGMIrxFrqMw8kk1x?=
 =?us-ascii?Q?RgYy1ZtLTkKby2BkqX1Uj0enzUsCZg1svO4ySHssbxI3Y1Fx67GxObdPSUyw?=
 =?us-ascii?Q?ywy5ObywXI2CXjK/L0youBlw94KF5SQP00HgE2EHfv0YlowhYByZXb18tQhh?=
 =?us-ascii?Q?xyiM3esPsNIFsaB6Vt8gjFwkm5wQL5X50PgP3DDYNcuQFESvI91OEOWpIu7E?=
 =?us-ascii?Q?XeAerRcKy8mDvyxImvLe6g+I7TpPjaEJC6l6s+nEP0uqDzoANf9xRbAWx4Jt?=
 =?us-ascii?Q?sT9jSMJE1A+LjSEQGv4DUIDHCm2q3BJJcMSc+RarNiMJ5kDB1W7x/n+XwhQJ?=
 =?us-ascii?Q?y9tthUf4kgH/D1r+iUPZonn/dwC3Px2ClqCQs0ngzi3b/yTGZHRpT1k7l1iC?=
 =?us-ascii?Q?UPLJNnQikyLWNtlWhenRIBXU+L48cSW++MWZZQDL76sDwZZlPIqXAOtwTQSL?=
 =?us-ascii?Q?GUDhyeWWZcUkfPEmKHFjepxF3Q/IsDlJL4J/Hyn5YziwvklTHXwh2tIOAYNB?=
 =?us-ascii?Q?1i+1T7FqN1EBe5XBsEAcEG7/eTzbgsyEhEQSYvIGLEGAjtodpP1gsFu9EUFT?=
 =?us-ascii?Q?jHZkk/ZbBaNvG3zVmVhNAoVd9R+/N1OG/X9yXyCCoC7aIJ0Fk8HVdnjhOuiA?=
 =?us-ascii?Q?ToKW1ZyG+8J9fO671x88ZtqoZpv715+yODJ4efmXtxDt9G/npfuZ7djyJooq?=
 =?us-ascii?Q?tv6cxAwM5otgczcBUVZCWdMGXjnwYcf7xsIShuF+ovFW+sEuODZLWzOiMgJt?=
 =?us-ascii?Q?RWldROlfEjZhC6qQwMPCsKOz53HKIT6qfBBgscNbNGWrlb3dtSmC07o7idhd?=
 =?us-ascii?Q?JobZ/j3CTJ/7au8M3K+oIFRHqYwJ3bDIus1fzCRtvEgFzLC76Bc8lAOlADKz?=
 =?us-ascii?Q?fyn3UPV/1siHg1vfXNP5dmxDCQUAfk2h87WZES2rJpYlfF4N7atEYR7c7zQt?=
 =?us-ascii?Q?cdXNTSy5G5C5ubtwouUoOK9BTPEvJiFjcvMygh85oZzlEMXW3hOLP2lacj+O?=
 =?us-ascii?Q?HuFjG9azaipDs8Eg2jA+fOE5BbkEp5XzfrWuqRD11nSOAhf8UZMUxYHeNiXI?=
 =?us-ascii?Q?4M3g+gBho3K0IDLdxsrWWwZ5g7XhQ0q7Rn0KuI6B9LZFiHqth3oXd3hlFieL?=
 =?us-ascii?Q?2oZrXrw+zUs3EurVFNGFFt3sSTQfHZw/pNm47w3pCBC36o7gu/I4w3g3Xlpe?=
 =?us-ascii?Q?xGHq697Fx9brJDXIalMDNdwaa04v+57B6YEZysn1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70d39a8-6e71-46b9-e93a-08dccbf41ad6
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:40:46.4027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Mo7xzBAP/KjcWAvfiTqwf3KmS88Nts0d6UC9SeThksik2TMPTPcvQPq+E4AsV+/xqV3ebU7/ttoTv+uexghCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5536

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


