Return-Path: <linux-kernel+bounces-403746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918C9C3A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BE4280F39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC3C16A95B;
	Mon, 11 Nov 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Ngv5jW1c"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013047.outbound.protection.outlook.com [40.107.44.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73193158520
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315108; cv=fail; b=hd1g6ZwFEk8O3C8EH0IjWyRepZ2AhUS56mYIgRFdmNt9YAv0+4wzmaLiLy8Ea51sPKucxQfAGuR4q5J3Bw5ZdDpFVKCJjkH52lXIvoa1zEJArVW/GV4l9/DetjWRrUgzlN/QB87/RkuR59mdy1+ArMCbVqE5y6CLta4vKvDpr+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315108; c=relaxed/simple;
	bh=WKK34iSSqCc+V3rFAXBXtLvB+/AknI9UZjj11LhL3a0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TcLIkWQN/j/xFOfwBPX8BegYCwCooQLFZcZgrf+Rwbc2cTwBQSL2Vt2D6tjELaje9VztLBpcQZ6ygRv8tWDzjvBBDxeL8QPZrgFqjqUyulWrCZ4xho1DHukZ0sMNOfCXYt+CxHinmq4CBJzhYujRRa7YZefxIzD9miZENKpMcXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Ngv5jW1c; arc=fail smtp.client-ip=40.107.44.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTF9hxE6qT7MWPwjN8AChQSEB3KbmCQVoR5O0IkzrKX439UaawXn+/BjNiOXFW1q4cBOFawlEwlONDwbRgwPIV/FCc9f/TMm+RIoeJ3Fn5ZH43iHVMD8s3ICo5+g+IH9ffJntaqfK1l8/kk5O4Y7VOo7lW7TzwfHxMaiw5iiPpLAQ57VLqAuy5D4KlfQ+rO6lNQEq61A7m1RnDw4HRYhO2COKcSc6rRWb45kRDhAvLItaw2bPrHTL9lzihyo9jQQqYg04OOgh5vZ4n33BIfHIXRuBV8Kx5Mo7CFayClZqfVEtfYM/JGe2Y4OYDia19QQ3/9iWVHcFVDOuyKGyyk2MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9ceKEwiR2MpS6zNV3Xg5/5F9h1yAOqNksCS3ez9i7g=;
 b=XNHyc1SptX6u1dzXdpP3a2bZ4587rlB28BmFx3OS41HbHj9y6Y2UwOP1SMTXZh1xFgMqpA2Bi0V8NNHmT9NTGAxjNVszk3wgACn4ER7ya8ly9S2nznIYgr/eNmkkqt9JRgDFiyoqswPPwoHR+UuaEOS+Vrkgj6BxwkJ4qdmvN6MjA+zwLWn9HGPq0XhRmB0zeeCw7B0CVLOx2ETIDs6NSPEo77/M0qBawHSrojQYhGOwBFLlNoxqLNoxLzEw2/EKMOOneDd0WshmT/Dvy2aMAcSxHexKkTPxcLNTn4zz9JcD9erGC0MLfBW55L9e6vdywj0jNzUOv9ghq24Qi2H7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9ceKEwiR2MpS6zNV3Xg5/5F9h1yAOqNksCS3ez9i7g=;
 b=Ngv5jW1c+z2DL6VbGAOEo28+gMiqvQ1B8UBk/FqPSZbP9tK9asaAfnidGkHpJY4zOsmkY0UUqNjKF4EWxH3Grf2c7erkdB63G6uqLDGaRRuejCv038cNGwRq+ER3Bhf2kvfg36aAsPtdZDVnRW6wS+SHd8UFdnpbDCSC2YJXT0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by TYZPR02MB7393.apcprd02.prod.outlook.com (2603:1096:405:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 08:51:43 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:51:43 +0000
From: Sheng Yong <shengyong@oppo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Song Feng <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH 1/2] f2fs: fix changing cursegs if recovery fails on zoned device
Date: Mon, 11 Nov 2024 16:50:57 +0800
Message-Id: <20241111085058.4136077-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|TYZPR02MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: f63778bb-bf85-4438-afba-08dd022e10a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ZRfVmHa+bhtYrrDVLxY+YusGuWh8wA4qKiXEoiN1XMgfz2vdafNPJAz+r+d?=
 =?us-ascii?Q?BN7IjGRy3BCUia3gD4yFNLpFpS4jW97hJEqaUc80fqMe8Gn6Ew6MBWQ5cAvY?=
 =?us-ascii?Q?avHaT0K0/MfPt5nfmTx20+/ocKS308adBtvpV5ZzbwslJd3tT/sTrT7onTgP?=
 =?us-ascii?Q?FRwejdDmw1lu7cy0eLCFuHKfxFmC9r3lgOj6OOnnOb7K/2vYL/q84ErZ27xy?=
 =?us-ascii?Q?bTOU8/V4WKbde7jGP6tBmGDXhSSPuX8RGbpx6GlDO/aJ22TBL1MkHdjcXgZn?=
 =?us-ascii?Q?imiwis2iyC4LfJavTx/GSrMvydmGeyFIPrgtNy0iWOYSgz75jWByKB2zosMA?=
 =?us-ascii?Q?AIzU/lhrk+5WB40wmwfpZgKD4GkGpg9d2NcGr4yCOo4JlauSyU6Sa+gSE9TX?=
 =?us-ascii?Q?n6NnJbgMNtIvimIo8dWLVhyQzZAwmFXf2d8WE4V7eb9Wy9+ZygJcmxmRFaEU?=
 =?us-ascii?Q?UGJ0ddTC3qTf0ERVZAWIkYVw32BsxoX9TSOB7wlhev4piM5bg9z66T2imGEh?=
 =?us-ascii?Q?JzRBI8JKucDz3+xKbrJnJtpFiULxqhpMiBtCbsxr8NDn8gUD33Iifsqg4IVq?=
 =?us-ascii?Q?h6yQvdqK8ulCZjfCiC79MzJLPGfbVvcah5VoVBt/Sy2LInSxulyM8nMfd5Wb?=
 =?us-ascii?Q?zPIrDKT4rFqHfypNdsk8ejWffk3ahCyvbOcFMFWfC2FNGs4D7GgC4h3NK+GS?=
 =?us-ascii?Q?SsnvoDH1/O9D73y9yH6eqVBuzXY+DIypg08uRkzAqyfPU0Kn/OKZwA8vupN2?=
 =?us-ascii?Q?CLmfz7sqPU8pCnfOEaz5mwaV2+xGMyEVxLGWlSalLgnxFVv7BmV0UPW5NcEO?=
 =?us-ascii?Q?ofXmovFdDYFAoaPDBZLmuxcY1MnNbr1zWW45X3VWRFCA1iV0EcGoUNO8BFQ/?=
 =?us-ascii?Q?BAQ81zCDAwuCrQADkZ+eew6OiXDd1iuriFi+MAI69RYeqOdImaZqYpKRK4Ys?=
 =?us-ascii?Q?DbF7Rfg/7KtTwuoDLPuQMVpTcVr1VrCBmE9tRdXtl1G/nZgAVgCC8/h2gI3u?=
 =?us-ascii?Q?BJPK3Dday1RTxYOGMXYDMC9tjsDZ4tR5l2930a0C8V5a7xn0SAiNnW/9Wj7/?=
 =?us-ascii?Q?3aGiU2fVtd44yp3Jl+biuym00sebK/uAYVM/oC2K+UFOP9qrQXwu09YyO5jf?=
 =?us-ascii?Q?+Qe9w5slaOlgMre2OUq6HqeUjUqcSrAD6D8koG3ZX16lxj1NRWBtcLM6cNI6?=
 =?us-ascii?Q?0g+1J6j4DLNeqPZNvngem/EF7U4C4KZwFCLMWzUm9ct50aRzTRQf/X8XWU72?=
 =?us-ascii?Q?dItcO5sagibNVfW7CIXsvqxE8O9OER7M8CGYtq+U0wvZvVMEzRGmSby1Gidj?=
 =?us-ascii?Q?zftGXyL5M8LX4ZnO1GIGJOmzh08v/5LLtW3KRN/HYDyt13gx3dqBmF+b/wGM?=
 =?us-ascii?Q?IukhWa4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9cym6LAFnVwboota+J/00CkG5e0gEJ/FOE6g3RXCdZXAlTLoyPphBV85XLZt?=
 =?us-ascii?Q?CwsCYm7ZOwCwvho+fS6uh7+8f+OVcnxY8xtEKQjNEHeyHTH3HnZ8amgtKvA0?=
 =?us-ascii?Q?BtI4XnWoeqJsznB7nVVViCmfSvxWpSbw/Ustrz/1ZK15x6bramNcSYxDa/yr?=
 =?us-ascii?Q?7hKafrAYrXu4aJ5a6D3cKx9wOwDkLvXGvdYTUqvJLXL0lfcduQ6VMwZPFS44?=
 =?us-ascii?Q?PkvVCklzcf4dZWoNJFMo/LSI5cNOvl3K1s/QzhKETcJN25wIo/H8puzY+IkR?=
 =?us-ascii?Q?FboxWPpYuX0yXviY4OBKLpEeY4xah9AE+io8ruKJnrOvMo0pY50x1vC4JRhu?=
 =?us-ascii?Q?hRnJDt+MMHXdIpaaKDHzLfJSWCSy6e130tFvgKgYXJLmfk4f+zVgnFRYCDjH?=
 =?us-ascii?Q?UBuFRTgCu4na9gRrF3e73G3Ls5LCAiWHz/CLMayvIgNQvDTQzP2mcKRegYHo?=
 =?us-ascii?Q?WBAaanDpA71ukuIvf9ruItr5ECdcn0/SJdA/7ZtXCPeASZnCA9KfdgHmjyEA?=
 =?us-ascii?Q?4FktArS3uRF9YHXDWAItGJ9lYQjdBfp+ldGPkbaQcxNq/pcS6m5JTC+utsW1?=
 =?us-ascii?Q?ddiC5CZwC4LkKND/8BaiU5TZoEBF/YDng7FdQByc+ok4ZxoIPAIBzpoVHvxj?=
 =?us-ascii?Q?uTbpr1u/YCj/mCvtF1vbP/Wdd/Bff7s9FdjCDCfD0UbKNKUmQW9WPPjzPko6?=
 =?us-ascii?Q?ndOU43eloZ1KNC2GZit3pc/gbVRSKX0odjTKhP++SY94aalJ4YJnSCDyFPTy?=
 =?us-ascii?Q?Y30r5bo7z4EhNWC9o+o6htwC/3VmGTfQzPMfesak902fgJxvxh6k/EBVgpRE?=
 =?us-ascii?Q?zkQvbuVrSSVaCusRs938AgGnpXPJFbU53Ez13GCC4gHtUMMttFqBrd0w8hW5?=
 =?us-ascii?Q?GeyIvDRZ9XpeurIfwcArC5bv2Q9aqMfCwBCjLwFyBdFU6q4VIiHCuR9zmZjs?=
 =?us-ascii?Q?HyuxPtXMNnRBEnMpKgDzGVodHb0QfOqiJH98r8USk/PcXmcQ3y5Lne7EnZF2?=
 =?us-ascii?Q?DH2rBcBzCYUKOPpYUVRR1goQ8a21n5DuFbPJBCAaTKABllYOWTYyoXyMSmbk?=
 =?us-ascii?Q?/t6hdtNIvJB2lHr59Xtoy4MS6HtAQSQfsLP3WCkvvuUAEyWwnzhsT4td69X9?=
 =?us-ascii?Q?SEb6K3DLAuLlYf+fWWkSeUphPmlAR5Vcfo3yqNPokhG0GVZK9bjgf+jj0sh5?=
 =?us-ascii?Q?gMZk85jTqpGSTJJHPskBJ4VGz9Uel7nSpqS+bl2DjxeNvj9vBT6aUQsDr5q2?=
 =?us-ascii?Q?/oLQcXUOH9u4nc0WGvy38Y1euVRglxDNPr0vnlUuwGw0PfRns+7vMCMB6RdV?=
 =?us-ascii?Q?hZEIyibW4kVrmTl0nIn0wQqMbKbMj0fphchp/6bPLtrWOAGJH04LHKoFo66K?=
 =?us-ascii?Q?AjdL3G/+HYmDvIqZk41jDpJY1pnSGtWFGC5ldOvzYPNQdRPM7z0csQVLzqMc?=
 =?us-ascii?Q?5eF/SD48mURkY3A0OxmqyzN6mfdc7E6OV1ZjUVMtodHhjOEroB4jdWeotHKp?=
 =?us-ascii?Q?ExgzTXfv5/LKbhUJ4XUEIuFc6rf26/n0H7RyKPVXVnCCoDT+zjw+0ueq6bet?=
 =?us-ascii?Q?IjGPIdpkHUD4Oc/Mw2A+UsS4X8c7MFueRxv2feEl?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63778bb-bf85-4438-afba-08dd022e10a6
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:51:42.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqlRmc5mG3SAQBS3V6Vil1U0W0CBaQD/tD65+omZncb+WcGVb0aMFgFTziDe52k9487G3XM1tM+lr83tp85tCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7393

Fsync data recovery attempts to check and fix write pointer consistency
of cursegs and all other zones. If the write pointers of cursegs are
unaligned, cursegs are changed to new sections.

If recovery fails, zone write pointers are still checked and fixed,
but the latest checkpoint cannot be written back. Additionally, retry-
mount skips recovery and rolls back to reuse the old cursegs whose
zones are already finished. This can lead to unaligned write later.

This patch addresses the issue by leaving writer pointers untouched if
recovery fails. When retry-mount is performed, cursegs and other zones
are checked and fixed after skipping recovery.

Signed-off-by: Song Feng <songfeng@oppo.com>
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/recovery.c |  2 +-
 fs/f2fs/super.c    | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e4d81b8705d1..324f948247ae 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -899,7 +899,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sbi->sb)) {
+	if (!err && f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sbi->sb)) {
 		int err2 = f2fs_fix_curseg_write_pointer(sbi);
 
 		if (!err2)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696bd48..42224c71ae20 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4738,13 +4738,18 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 reset_checkpoint:
 	/*
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
-	 * check zoned block devices' write pointer consistency.
+	 * write pointer consistency of cursegs and other zones are already
+	 * checked and fixed during recovery. However, if recovery fails,
+	 * write pointers are left untouched, and retry-mount should check
+	 * them here.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sb)) {
+	if (skip_recovery && f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sb)) {
 		int err2;
 
 		f2fs_notice(sbi, "Checking entire write pointers");
-		err2 = f2fs_check_write_pointer(sbi);
+		err2 = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err2)
+			err2 = f2fs_check_write_pointer(sbi);
 		if (err2)
 			err = err2;
 	}
-- 
2.40.1


