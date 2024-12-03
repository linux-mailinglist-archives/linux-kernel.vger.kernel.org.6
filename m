Return-Path: <linux-kernel+bounces-428783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFCF9E1365
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2E1644B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905F17E016;
	Tue,  3 Dec 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZNUiqIjE"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2045.outbound.protection.outlook.com [40.107.215.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D228173
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207748; cv=fail; b=PDFbPbd2clWGPKeASUexGQIJLc4JMfSNoxIdDGJgdTacz8SEcWWJXYcS9QndY/ai5aJ7O+DcLtVsQtW8Yuamr9+aaIQ8IXkDuU3aXDfHTExeX4lkY4jfT8nNRImy+YXF17yR5upyCmZJndP98IjCKy+l6yOtqG1T9eN8Q21BgaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207748; c=relaxed/simple;
	bh=A8p87v3Z2vh4SrUQh089EE7HgLzIekELDSlNWWf3Bkk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t8Z+B0/Hizj7amIPZzuYuV3ZaTXe1fF0uJH1ZFL1Di2Umj2hPC6J7gO+PL6Fo8h0XV5B0+sOa43PbazGWwgM9Txbcj2bgDxdwx1F3EBNCzn1Kx5BlZEi/l+/rv2MjnFfk/YHzbngFmlUaByQ8qXZzJeKBkkafmQJ72IkYNvmmN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZNUiqIjE; arc=fail smtp.client-ip=40.107.215.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXUAFY4os88a9VFeIb1WRBSCNDq98qt/Ei/hH5jVIP2T5OPMup6wp/8pKM7LftcMqSj/VA1vZURs38qy0UVP8z9HExkVaL2RL9FDG4vqsmzamXfZ9BradeYPP+nFJRaNJBf0RSx3IvtuFVJ7srUHoPpIiLcah9wOVGIesuKHIW0twSbvBWxp96rwH20Nrw8zY0vfVBW2cHki6oaXfKAJFTBvj9vrVIKV1DMmCVJMzsaKd/1P6yJAgZs1reLXk6kuaH9qHnyNWTi9RN1ckvWm5TEvzP32JpAnRasmj+EaBap7XB4CNDhWaU4aMH9wZfalQ71tivGRXxJpt3DsFrYvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9Ni5AHT7Qj1XSGX6KHCBR9pGyvC7E8sQuUmptqfnyQ=;
 b=smZOe5sEE/RzchbIHjsAXU+YNDGwqmw+jKS/imcPD2zsDJyz4bN4wTDBNJDVF2wLyxL6jPnc8MOf4BiVUSe0wh0xqY4KSp0QRLxlkhpULMsNPoQRe5i8+Seqd/ctXAUu3mYvYQvweCHD+33VbSil3tfCc/9L+1E9aRAsHO5hvlde0at3J6MZawrQVYP2COrDVXY/swjm7bkhJ/9BynwcO/51LkScl5gm7lGAUZkh42awbGeJyPsEBBZBPfV9bOV+oMei1KijKFHpE1aqJTiRm7Ss4VJ1IOz/McpBDfrfvAT7RLG6Fj0xjd7go8e+St2zAUyjH3bGLvHtSojUWOn/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9Ni5AHT7Qj1XSGX6KHCBR9pGyvC7E8sQuUmptqfnyQ=;
 b=ZNUiqIjER0yMbZ896mUBLBW88cJU7Jo8KGBYE3FPntYqERQc8/FEMtp8FjnlLhdsBzuTFQTrBp4Wm7enKLyiYY4trE/hmpWhdEWbCbHiYoAm4rNPfgI4jojU4W6iH6+NQY0LzwN4DPUt92YFaKK31mOKZPpdDPbiLJCF93WMxON6u4uuvQy148jjdY6J1dIyFqFyM4IbP7yFYFkXNV+mc/eSQp3nQhdieG8/PD249klvd893EcFDR29TB2oigiRMAiCJdwesXXSrbV1qptALudtesEbNodMaVlVlAGTxL+BS4O6A2CMBJR4kU72Zu6GucQvdgeK/G7+DBXsruqFrXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by JH0PR06MB7055.apcprd06.prod.outlook.com (2603:1096:990:6e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.9; Tue, 3 Dec
 2024 06:35:39 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8230.000; Tue, 3 Dec 2024
 06:35:37 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] f2fs: fix missing discard for active segments
Date: Mon,  2 Dec 2024 23:51:08 -0700
Message-Id: <20241203065108.2763436-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|JH0PR06MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 02420db3-c2ec-464d-5de7-08dd1364b2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQPBU/04mHb1Shs3H6xlWln/F/v3Al2iPFbpBo92K8yB1WZtBEW2wM6ZEeON?=
 =?us-ascii?Q?ndi/dkKbF6CCtTB6RO0pKr60fgTd/2kwqxBT2DlZilnro8rNTK6v7atCYCoD?=
 =?us-ascii?Q?chzZj0YNa/IRtGzctUE63wRdbhz3v9ZlMZiAKma9ZhnfpgBKHxmePc3iJY2s?=
 =?us-ascii?Q?WWIF+MMtcCdw3LiDw1CWjlrcFkWz4XwQA+Si7qT8XUxrsKGg0qRImLyphDmS?=
 =?us-ascii?Q?opMol9Z9j7OBEQYtTZfisUxtnhaZbNxT8cjJnmJ6KB2YbJwKDnhw5eYxoY1v?=
 =?us-ascii?Q?8phMT0JhjbjGCUZ8glg8vfgD4youN6bkdsBlTBQBAQyBm+KjH9OvrbASVvq1?=
 =?us-ascii?Q?IwBqCZcOiHfT/1U2DoFEAKSORdtOvjo5roLIlwh1kDB3z711botN4PSdlFI4?=
 =?us-ascii?Q?rpdYtgCLcuJy30tvI0+0Zoxflv9P7g1CnmkoX3xfKWqI4tOJwDb/IMPl3/rq?=
 =?us-ascii?Q?27ybx0UnnPjRM2TjWkqT98uVA22Ytg4eSHxE5Y4sTyb/F9vs9kZE+aRD4MLP?=
 =?us-ascii?Q?Ev0fDfABWmt4OEhWl7l9yAAferSK5CndCMrxLPdjza/1eumG6smWbEvamlLG?=
 =?us-ascii?Q?e0vgxDzf9EJjLh3BDqjT3CoDzBfLvYyfD4FdJ24JgMjvgj2eHbjrl+c4oQcJ?=
 =?us-ascii?Q?GmoquA9Xv/YRuUXYFj3Im5NWTDliyWVuash7JJYqxrZzjEr4EsyOuCf3xCni?=
 =?us-ascii?Q?QYPIR/uiv9Dvf1yTzIhi04n6voyYSbRETeFUxnG74++U8d+GpbW0kxdAUyg+?=
 =?us-ascii?Q?yoq6xNGffvev7nidSIgqXXwUsrb/IKKcHeemjECxuUCeZ/3KSTXqby1q87KE?=
 =?us-ascii?Q?SFl2BdG8/tkbDV5FPMlfuwyHECSVXYiTDfKd+5YGKvfVS1uC3hwWcNgZsrU/?=
 =?us-ascii?Q?KRDij0hA5eHVqy2ITilYnSIaTL62XilWz+3/jVHg8idDN00PUQ+VWdKRWDvY?=
 =?us-ascii?Q?EIrVQZBnsR/DreeQZmPt1M+qT+j1iPxLcdLVdpS6EL0ndAXyszBlJSOR+XdV?=
 =?us-ascii?Q?TsBgClhX7ujT0I9VwNjyPjCw1PrezHjIcS3WIcIohmr6kXkZPvJXbPShPpy0?=
 =?us-ascii?Q?PS6HKJY/FjFxsiu8iwEVq2vKuvWNPlrHgl2FG21LA0BANya5UamZaP8ZFL6Q?=
 =?us-ascii?Q?ocAxqbPvOI06koNLz2QH38Nv3FreiISsJa0W7tWstbgo8gPm9e397KhjgMhX?=
 =?us-ascii?Q?kJsc6lUhqOLuyrY6gYEvHRlWxBVaXkcU4zNq6QOmGxYX8vLpowgwWxvHNE5H?=
 =?us-ascii?Q?o4zJDltdfF2ef/EbjCY20W5VOWqFULluMkZIDK1gtZggyze+kX7XaDlWfjLI?=
 =?us-ascii?Q?t3LItiUYqocmb/R/rJLqGD3gNv24SNy9fgCkIQVsVEo12ulZ0Pm9ek2fakwm?=
 =?us-ascii?Q?0Nf7gge1n1F9owH9JpbP+M0YzYDe4cObFWb/tAeuGeFzD1nVRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VAem7W1f+5Ku9xiBEQV8gMRnnLw16SOHyNghKz8BZaRF01BLjQ3pow9bkRpL?=
 =?us-ascii?Q?hwih8gp8CnZIoEWcU17Ew/aIE1MxxU2+lbJ6Z/JoGrF2cNxThyiB/0pxG/v8?=
 =?us-ascii?Q?g49cRkQ8vxUWqO8SUlGFqJYf0PItrOxY3sIHqsWQmpN0CtLebd8yE3Ic1T8/?=
 =?us-ascii?Q?/WqO5cvw0NxRJK6c2Y3N1Mgli1BVLMGnk6p3PNueeODCRh/ihEAtym/beJC8?=
 =?us-ascii?Q?SG2Zmcp4Tw9LFVAfpdt1ommmwBTSr66w7hbKVJSM96+kpzn5HlSEaouDeWnx?=
 =?us-ascii?Q?JQvNqmRkLwHAnmuCvJa+Ywi3/1/gDAvI+AjWAf7g5wQ0C9wOdWh+gHRtyGg1?=
 =?us-ascii?Q?noxdts6lGu31J9+SFYLllqJU/T+rjzQpJNt3hkc6iAET/HNgiATIsFvpBn6t?=
 =?us-ascii?Q?J8VAcPx0MNvKJw/UL6L8+XapmZYlv5qJg4lxPA34pOmZsLiL6duRrSdye2ss?=
 =?us-ascii?Q?2HM+oU4hyOguMvZ0/5neLqAvsQEf7SJVM8sib0I1FPwwovf1x4Uik46tA8uR?=
 =?us-ascii?Q?Sa/qmQ5mnFO2St7cdVi3wkHRO06c8jSJRMcy1Ebx5IlIKU750EDxzbFEzadZ?=
 =?us-ascii?Q?tcG/jzwgV5zFXVUWDzp9y9JdW0IJCamYTsGcglfJ+y3EKn1cNZWQnxrTSfOS?=
 =?us-ascii?Q?wzTP4rjHGhLDPT44pbCnxbTHzHGB8Pk+bUO9gCCfNm8iQcrDAMmC1OnjlzLb?=
 =?us-ascii?Q?0lIVF44JJZsc2KOqjYZMTgzRx5+EmsiS8Y9ciqth4oIWo3Mx9uWoMr4vxVmK?=
 =?us-ascii?Q?CFYxZ3MuYHcg91eWChsNARkJee3JyCicoSptAbiBbZLfIkVGVcHg4Y+96BPn?=
 =?us-ascii?Q?yN65/a6QAUqxE5cHIhbCBl+7Sc8cQyIutdNj00rS1WpxTuzuZH4yVEJt7vlX?=
 =?us-ascii?Q?jmfxhiI29IzIBEa2lHRhQ8yJh8YJBnSUTiIs4sjP3RpKy0fGYvrY7Vb9wXoq?=
 =?us-ascii?Q?Gd/pSka2D5ReM5lAn85TV98GkG6q/djcJ6BwfU3plu9dC/U3TUlhcuEKHG8K?=
 =?us-ascii?Q?RW/f+KfaKJyji32zaxKeTncx43FV1LX4V/wxTfjLolVo68Vr8+VGKs0FAoP9?=
 =?us-ascii?Q?CAgU59dmm87ZHOBWadJwHsX8wn0M7NmVLQBw0hILHdVEWOFKCMUjKKPezBaa?=
 =?us-ascii?Q?hbH+XJ5cmegSCczLnLxOB8yB8khmR9WEdWkN349e1sowk3tT2Es57kn4Dg75?=
 =?us-ascii?Q?kWaZ5IDlGJjtk5vQOnqOaete7dxgQS93eU1gbfaj5ZZKgI3lCrQ0S6gvQCKI?=
 =?us-ascii?Q?KcTkDfVYCDu3jisGUvsvfRgvJgPLzpNtL2CIvhCwieyLujPnUM3whig9YqBy?=
 =?us-ascii?Q?Ax9Nfqi0SHeu9N0N0IiY61PJsAviGh/msYS7cqkDD0qq99huRwzRE6gCcsX4?=
 =?us-ascii?Q?ZAKZIEt64HRtQQtKdseqe6jzHxglgF+qbUKk9G0R92f/V6tVaqJ26A6xvM3f?=
 =?us-ascii?Q?l0iTMknbBIQOEuykRBe8fEN3fQ9I+gPVTPEnvuIvGA3DFDwuywXcdedxfsni?=
 =?us-ascii?Q?QrHtbsG/paB97rosThv5DKFP48cNcmsWgpSL0VrzYqVBS1xSBzY1S/lnMV1h?=
 =?us-ascii?Q?i8xEwVlrowL5iHhakUtKGzPTIfahocUpXiVHfGH6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02420db3-c2ec-464d-5de7-08dd1364b2a0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 06:35:37.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W63zNyrLftVd0zMtG/vKiCaBd9jO6ogb2zb+OD/5mQpuTK2f2O0IqcDVjixkaGTQUiIciVNzXSv6q+xfhzQ+4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7055

locate_dirty_segment() does not set any current active segment as a
prefree segment. Thus, the issue described below may occur:

Step 1: During a checkpoint, add_discard_addrs() does not handle the
current active 'segment X' with 0 valid blocks (and non-zero discard
blocks). As a result, no struct discard_cmd is created for 'segment X'
and the value of sbi->discard_blks cannot be reduced to 0 after the
checkpoint.

Step 2: f2fs is umounted without setting CP_TRIMMED_FLAG, as
sbi->discard_blks is non-zero.

Since add_discard_addrs() can handle active segments with non-zero valid
blocks, it is reasonable to fix this issue by also handling active
segments with 0 valid blocks in add_discard_addrs().

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eade36c5ef13..4fb1dc4aab97 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2090,7 +2090,9 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 		return false;
 
 	if (!force) {
-		if (!f2fs_realtime_discard_enable(sbi) || !se->valid_blocks ||
+		if (!f2fs_realtime_discard_enable(sbi) ||
+			(!se->valid_blocks &&
+				!IS_CURSEG(sbi, cpc->trim_start)) ||
 			SM_I(sbi)->dcc_info->nr_discards >=
 				SM_I(sbi)->dcc_info->max_discards)
 			return false;
-- 
2.34.1


