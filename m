Return-Path: <linux-kernel+bounces-244290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B06E092A23D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271AB1F26103
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046F137747;
	Mon,  8 Jul 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="LouQ1DA5"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38680046
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440273; cv=fail; b=Gu6KO7+7/Y//9KSddCGW0jdP69/xa2XqQ6dArcAWV39yMW96RTSzLrSz9DuykoKGfC/LXXw6uCftNTDjp8A5L8g34+FY9nmHuVUuUahlcg1XJ0Dd7hyuRNnHIe6F6MEiwe5V2Qy5sR+6wAKD0CdPGBFB7caLTyO2ii8YdXL4TVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440273; c=relaxed/simple;
	bh=Y/JmGk9II9FehfIKeEvHGS1n5hRpwb6uUnasSuUU+rw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=byO4/Dap/Ej6PSx1zemmcsUQxuic+Wp8bbIYKDApqPF1abVEbBG8ANhy5YrErZJc6f9f8w5YM1WgdtSpzN+M/Q12iNYXRSQ0nb6hI0Vas5M2dNmIQYo3JkNbYzNdeCAP1rcOpjUJkv9wFMdhHYPJV3dF/23uEqWkznpV7axY4QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=LouQ1DA5; arc=fail smtp.client-ip=40.107.255.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+AvR3BkOxCWSOtRNBhsz3cXmJGMpV0BW+9dJOme/5DKP4ZUQQtvcThtsEhCxZSU/bAq6Ui5abM4HiNfMQ/vvcvAPfG1fkHANS4afwYSLIfjBVtJF1RT7aiQcw7cPEnFK0FpXzTU3qBV3TjEPnKBv3t76QgVfLPmfoKwT/hrKDskP0DPPZBQBkG3ZBxpYz3yaTwJVYjJkp8kmuGSm1LuZgPbtHVydYW7tSoutftL3BHCprrpryrDKDBP1PoclehHOdFF0nbNsV2ijfDpsxJ3K3VWvXnbp9v6DsHImCYt1G/QkON6CHVES39xvh7S6gSENtAa8mNuKRa5qkVk2FMOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYIGXcSa0SjG3Y2pLis/l7KVZCGB7POrkhR8Rwldd24=;
 b=I/JCVNnm5oWZoMpGnsZzwCOUXrUjDGzF2uUfLdW5astUBmlgMLprXlZHFoVYQTONpbu6QrXJSceS1Q80sw26YbyhaF9VhldBQYt/Eu0jeY39S7qFQ+bZFpVNqzcf0R6AoTZP5cmDi/P2O/qhJwGW8LLSq2bauGfHEacSzb5JkgksEQWCoum6tQWmd5v9ogDUG1biwd8+ymLWXNe2YxdBZcw7mev95Ov7aB5Ew6c2KJrwBVfSBn80bA029qRKwR09s9/0vmhEz8I+u1Ei659ePYIYaQvyK1ByflAIUgsiXof87KGIjIOGJ+Qx0veTrYX4AzpL8/7UeLxq37/UX+ALBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYIGXcSa0SjG3Y2pLis/l7KVZCGB7POrkhR8Rwldd24=;
 b=LouQ1DA5d0UMXwtNnl8y/MxbKWZk7CHNtmqETFbOC/OBmIVRrPWPPFSDzfnBLilchoe/aYdmbGsYgd1MPj39eH0dgxFCeTkvDYpJ+ERMbYbe/P5a1o+by+lHBjied30L2QV0m3sRMAJ5ZFpjQT8mQ//IMFe4BaUUYdT48akusiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by TY0PR02MB5947.apcprd02.prod.outlook.com (2603:1096:400:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:04:27 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:04:26 +0000
From: Sheng Yong <shengyong@oppo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v2] f2fs: fix start segno of large section
Date: Mon,  8 Jul 2024 20:04:07 +0800
Message-Id: <20240708120407.2807639-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:404:a::32) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|TY0PR02MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: f4151172-422c-4419-ff10-08dc9f461cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1qUJWFt8SESCWr+5Elo7MEo2dP6IF9CwzoK3BOObxkwOfy/tPVGJI5TaTmqT?=
 =?us-ascii?Q?8c4yqdlMLXP39y4Oy4Ip3ZJhp4DQBwnY32/W8zDlDMqBG3T1T13b6JeedU2H?=
 =?us-ascii?Q?zGgzifjMiCdf077neXB1Hlnd7AVw7jPhZG09T/1vrje9fAtmu3SuQ/2ZXcPb?=
 =?us-ascii?Q?55ATOz48VxmJAaHZvrUKLsHqvaRontxg0bYnqrqx2DjFT69RroeVtR00CMC4?=
 =?us-ascii?Q?tzlkQlj4e9vSc2Lc49frMWs7IsZck/SpzIA7CeTD7cqbBUJcAifdyx6iCI8R?=
 =?us-ascii?Q?+8VHY/mW423VEXqUsVBHqQiEva6Ln7A0BfRXirXkEKp/eixneU65SqBDVIZ9?=
 =?us-ascii?Q?VhJ21DvxI/19TglEnwGgwsnIHeAMRld3GTP6D4dOcnJo4yxerBBTe9mB2vXy?=
 =?us-ascii?Q?Km+G+Qub0AOnmtpkwKsAvw5nHOi2pbD4Pv4VfEX8owXsd60bqdNWv5o8umjJ?=
 =?us-ascii?Q?+qabXfm8vqBEdJEvEQMhr2on7x1Ye1fRZRmqI3RZw5LrYjNDM5tzsMCWBH0z?=
 =?us-ascii?Q?JrvSpxdOFV7U1n0hGLefYUbYg4hZcF4chJSCqAgjlQECnIjfpTTcxqtkgvKo?=
 =?us-ascii?Q?sYUf+pLc9p9QGaWUAhSUXr4M27tH+7/GL6lIbdcgzHacsUV/m3R6RdZrU7m+?=
 =?us-ascii?Q?5EZB947crMpu6BDNmQVzBgfvkDKOB2h5wpWdyROeGUbwvO7egsjvSjSFTKjk?=
 =?us-ascii?Q?PIOjJHUboGvqvbSff89XJ4pN6wPuZ48qQ0ILfnn30NUXDgTRhAan5qPGMtO+?=
 =?us-ascii?Q?41qZuJV5zvXVpEvPkVj0yyfvi5mMwoWbazWa3NJJ55w7E6NNgl643H/XSKRr?=
 =?us-ascii?Q?5raK/aajsl+lgsPqIp/WqT0jpvF5ebo0BYifplSC0FnLmALE/0mFvuLrXCoM?=
 =?us-ascii?Q?RKRMW96rIswV2rL/9Cke8IXh5ZNl9SLXPh3jSTQFyeLYl5lqArioHRKYxVag?=
 =?us-ascii?Q?zqe5W6OjP9O9SfLroZ0MAtoyA3DcpmfQOOXd5lDe3xn2XEUADtcR5fKGbXSy?=
 =?us-ascii?Q?nUmCvhEsSLIVquw52h7PHgk/ynTjM+2utFDrS6BrTGrg97isMk9+JEj2mb3g?=
 =?us-ascii?Q?AGj1IAkEs5+yUEK3xycWF1wJdRjfXxKoWoImt59KoHdE0w1jB+qnJpynnTrF?=
 =?us-ascii?Q?yvDdRcPeRa+bozxvUDr8Qth6wBD9Ux7jmzUjLYnTxYRO5qa2Ll+xZ2p91ncz?=
 =?us-ascii?Q?O2saLy1Q9frcjZjt9D1doHddS55pPIY9+dY0HpTTE0BI50osj1Iqvq+ZWgSL?=
 =?us-ascii?Q?uB+xFgxgcMPtddMu5Lr65FTg2tTdjfxwT4uzio5Yraa2X9HQs2QM5nc2G1Wj?=
 =?us-ascii?Q?woSV+WP5wZjjOb/7IYxT6TuD/5NO0DAlrzsyTXOFOibz71w+14WSdKgR9wOU?=
 =?us-ascii?Q?LCxAwwpflsDgLa7BNwOwcmNi1ICA4PcM2Uwd95KdnNHV7csIOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYyuaPkDTFs+V8riRDrlZ2Jw0ypMWdozz7K9kBhWuoZAWBTYS1+HHVkhdDfJ?=
 =?us-ascii?Q?KXz4GtCErZy1JHSW62OXfU1dmpJIWc96oCyhuWFmjP0PPEGDd7BzZqspGu5T?=
 =?us-ascii?Q?aife2Gt5XWbEi8XYdzGNaIYSo0UX+cACgTeYKw5EleiSmbKzMnDqWix5n1P4?=
 =?us-ascii?Q?Jaf16YGFfZK4CpQkh1OfpUq1YC3Dr/u0awtbgro7UD1GHDmyz3PLwUa/Sfqh?=
 =?us-ascii?Q?UXhoA53cllsx7thQrEZ4r2pQYw8iTTtYn08APHcR+OyudJpVEMwnXNqqToB5?=
 =?us-ascii?Q?SQdwyzzdybtm9wqgFRDO/6ZcrkCGH6jP+yKGiDJlsQT19UE4GFOt6UJOgTGd?=
 =?us-ascii?Q?Pb70YHg5y8diZT2QBqMsQZs3dZwS2mqaGErbXw/JYbLonIbxEn1LCQSzAKDQ?=
 =?us-ascii?Q?fVrwPUXYEyZEMy0gGj++WzGdr0LE0AN0mSmgA0ZbjRKJk7dWUwMGrex+QFOd?=
 =?us-ascii?Q?LeNlPrBRWR+Z2evsBbupfBhjiHPZGATNORBS5/ljENz8Ul/KdcLUwDZbQ5Rt?=
 =?us-ascii?Q?h6beIJ2qbv5+8aJ5lYPibtmJi9Hdr1lONTGCoHqQXX4UP7q41Om14EU1yfIW?=
 =?us-ascii?Q?2SwzPGFBSOSPguaSmBPaXsfykfchSIiNaTtKMgBK5KIPKeHppY6q4S9rSanD?=
 =?us-ascii?Q?bb+F3c/Hc90UDgbvsgtLQTz8d+LqV8cOkVQ1rjx/Zce2GNskV1+qPb8J6g1Z?=
 =?us-ascii?Q?tfDTCJ/hZaWR/quYHlVizIljbKa0AiNp5J2SDzO/gTMitcIUPt1HqzYs/zkL?=
 =?us-ascii?Q?NgPO99h9wI44I09zGNi4c+DNX24663KVQITHbFPHo3FMNiT2+9SRafNCaB/D?=
 =?us-ascii?Q?U57kuD4cv62SZ21dVMCHYyrfp4jdycQ9K3UVNoiE1IBsHD/Xzhw0yGZnUwbH?=
 =?us-ascii?Q?Pyax/rOA1Gx1n7axNkYtGzP012zUOIgk7oRI5H3DfdnAJe4ZccxlokGEPLj5?=
 =?us-ascii?Q?KVxDDCteS8dEsjGvbocU5isOvI/nR1Pqy+p5u0DIlZILvUKUkzGVKuUyTnam?=
 =?us-ascii?Q?tCorACKfWYtviBEGvaXugzs4hMOugVM9UlrMwrBSMWCW3TguiZOpus8UeB9h?=
 =?us-ascii?Q?vb27zK/3wBXrblqBTFMHOI/xyapk3v4SKMgaXp030U1lBkR0ju+RVMwkZ5t0?=
 =?us-ascii?Q?JmqKiX8hE5gD3aDADvyeTIR2KCbNq4R6wILeCOgXz/EJq9w0Im9bnt6u7Fhf?=
 =?us-ascii?Q?gQXKx+nbJLk7LbxRLE+qM/v9nocofsj0O8p0MD/LCy2GnRgd8L3C+zBUQm6B?=
 =?us-ascii?Q?qbAiOa0Z9xmFNioKeRgcJsItlpD94pYSUqLL+8Eleb5sWygly1sZ0YyejAt0?=
 =?us-ascii?Q?9EkYB+ZTRPxh/Y3VF508w/ycDzPAThmvA8EkDle/uMNBCpir5X7fP+MPmUh9?=
 =?us-ascii?Q?dx+qBgmW77KkJloWKRUfWiI3vo+UcXxQe/i/wZX4M7cQn0+vnbK48A9jR2YC?=
 =?us-ascii?Q?iVPuCk2E0ozGyZIaa6uC7GAMANl+h22wfsy+GVoARhEGfbn+YK8RIljsEmtG?=
 =?us-ascii?Q?UPXh9Tz9z3LnOniawtlCn04UBM6rPYjNaQ7wZwaUA0gvtrfRXncIImXWtX+m?=
 =?us-ascii?Q?J6RgchToXDMlX6IHD/e96oZuaXFV3O37Cd9Zpthq?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4151172-422c-4419-ff10-08dc9f461cf5
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:04:26.4062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5CluB/So/y3SvzP0fd39FbC748S4oKOYF40TdNz0TeDNCqVBSuED7jGaM/1mI3+wa7kcLJe/A5t3F9e7BdrcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5947

get_ckpt_valid_blocks() checks valid ckpt blocks in current section.
It counts all vblocks from the first to the last segment in the
large section. However, START_SEGNO() is used to get the first segno
in an SIT block. This patch fixes that to get the correct start segno.

Fixes: 61461fc921b7 ("f2fs: fix to avoid touching checkpointed data in get_victim()")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
v2: use GET_SEC_FROM_SEG and GET_SEG_FROM_SEC to get start segno of section
---
 fs/f2fs/segment.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e1c0f418aa11..bfc01a521cb9 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -347,7 +347,8 @@ static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
 				unsigned int segno, bool use_section)
 {
 	if (use_section && __is_large_section(sbi)) {
-		unsigned int start_segno = START_SEGNO(segno);
+		unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+		unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 		unsigned int blocks = 0;
 		int i;
 
-- 
2.40.1


