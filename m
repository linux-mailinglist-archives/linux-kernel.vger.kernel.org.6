Return-Path: <linux-kernel+bounces-373633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE4A9A599A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416371F21F2A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0011714B7;
	Mon, 21 Oct 2024 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="FrU6AZsX"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2052.outbound.protection.outlook.com [40.107.215.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49228F7
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729486099; cv=fail; b=uRRP2boak9kw5CjHCcmuE4qY5Wp3NXRAB7bqFv0tHoKW2IK3YJSFz8/98W3UWqvW3LBHWlMuEkHDBaXKIdWaZdsYZVBGoCsHkveyxUJnRqrD9R/gl49SFIszt7WoQ+Rld+gaNo+ikktzx+sYs8T/Zh+DJhhvi9lTinYZiwkzq3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729486099; c=relaxed/simple;
	bh=OHR/8i3VwRABCHvpnsE9JlxC7Jn1fKPwVBDbsD6lcK4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=StPJIu8STp8AbbqE5HtWVnI2Pz+3gM9uwJNb08KI7PPu0WJHla0QMoC/b0hfdJca6tPT/yNCnu/IRxLr/6GvNcJSnmKd68ovaZP6a3fLPkm8V8zbfpebNpuTc+szRjR7hCbG1ZBpdbZEYqh/Y82Ofcer6iaMiEX/aeHHihmVUFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=FrU6AZsX; arc=fail smtp.client-ip=40.107.215.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEKjRW66zejnKKBmWpd1QspXQuYV1cNJ+UrnOm3OqHWVzBFx/zzMiOd/zfUEEIzEKRDWRhncBkwSGj/9HKgb3oEVeVw7EdZNGDd9YuGsx4ydWoA7UTbttomx1Pg720iLU6WU31nlu6oJqYH4+Zw1uowb2zBZtKTf+ONUsvJNKD/BRglCd4Vaaf4GCsRfgu5kYPRlEcZqvyibrDVSwjjlOMSkKoro8h6zkOrvFpssVEzXdercplrOpSpYRhT+4zri5n8jHSbTeQOQ9H+dAn2e2JWNV6xD6U2NAECCk1wdBiEMI2rUbDMYbMQ6oymsClQE7qdbbQZ/dLcakInyroIwGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hjXT0S7+TaQJqbLt4A3vHalCeIZErJ53sRPbk4yV2c=;
 b=BiiqNlJjwnRYxaetBXoOHPkM7320QpEzbvPpVT1hl9cYHmv1kQebwuyFEFu7mh0DmTu9uOQzFzGiy0VQ3ngW8P+PVVQuHvAWkwDSfkPeifUdUj7YOYBHs6by3q35AeOqGpW1zp1CY15+WdsK6AHy17EfDfc+6NNWA+XQofL0KpFgtoEkk66g1WhajCovFTE7TrMWErzBxTd8/yizTNBHw9JDnm+SXdmFxEFO1wk2Xs+lnnyjdR7oXDsJUxnYhME6W56UkOJpra3V1P2GQeMngy8hwC8U+aZa87fCiCkUtC8tphRpmoPr1S2/XCeLHLk8IvQtcgvA3SSg5sDI+jQEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hjXT0S7+TaQJqbLt4A3vHalCeIZErJ53sRPbk4yV2c=;
 b=FrU6AZsXzpof5gwsWYWXZgeSIMNqbV7mlsqQATQFOOc15qj4TlMpD/keYRXxKmGSHQIDHG2zh+oLxifwVLiBS/m0pjUXEp0Y02HcxigfZKQp7TaLeKQmOyAZyfx0ttSzN4BUv2Cn69LapNIFHqBBqExCOxIwxMH6iDwzL46tmUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by SEZPR02MB7421.apcprd02.prod.outlook.com (2603:1096:101:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 04:48:14 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 04:48:14 +0000
From: Yongpeng Yang <yangyongpeng1@oppo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH] f2fs: check curseg->inited before write_sum_page in change_curseg
Date: Mon, 21 Oct 2024 12:48:01 +0800
Message-Id: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|SEZPR02MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b87d65-8777-48ad-8dd3-08dcf18b9287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Njl3m8jaRqL86+M8d+wd8j9f2Rp+YReKg+fhb9jDf0Mo8Ba5RegKTAsnfNF1?=
 =?us-ascii?Q?cb0WryRqCLJvHEvOBzr2/IsaTDYLMoG+eUVoAoxZOCHba8u6dYE9fT66HW30?=
 =?us-ascii?Q?bJliWNxRKNDb2tC9/DF1EUtp1v6MRue+3ABilVEIw3clcp1ScuPDBZdDenx5?=
 =?us-ascii?Q?B4hny/AmNlk23QpOWTiVht68TJGMz98PDWRbK9HHFFO9s9IEc82bgfbpZYKI?=
 =?us-ascii?Q?MPf5AAVFzRoKp0mY5RvdR97XuAkotPqwws9/B89CU29Zhrg730Hwvsm1uMla?=
 =?us-ascii?Q?8kA69mjSCsuulbYgJ+oOXbIBroTKh0/grV02Dym98aPNczn5rjzDJl7y7wBu?=
 =?us-ascii?Q?+4ZIkPV4LJuFQfTHivG2rFRF7mFI8rJwAGZ5akLIwK0vGpGye6Oyp0dSegF6?=
 =?us-ascii?Q?Dj4FstvRTKV+lNh6J5+TKYVnmb2d4nNkRCMn2vqKW1W+6t9ppomywTsXioyP?=
 =?us-ascii?Q?y4oXpmuONkoMjsktVOplgpdTAGO2B8L/R0O71MKby14WC5o9HXjDWYVXpA2I?=
 =?us-ascii?Q?+6EWtKAuv8k98fLuTMvIpfwDS3UG8K4EF9L36zqlVkzX63PF3NT1PQ+36eJu?=
 =?us-ascii?Q?pYmouIRX/Zjt8nrwRp0/+uWzsUEs/pwxbtPGOrpgpiEzYlL2xdiG12B58EYU?=
 =?us-ascii?Q?/6GE97NkLUkUkDWxkDrS2QgpD+ZoUJXz03SFxlQT5ITSVc9JFRoQ0PIsXD4z?=
 =?us-ascii?Q?n3cfF4785+sxWx8t19zdm8q5g0Naz3nsTX1DYVf0P0KnZvfYccB+lRUiSyjB?=
 =?us-ascii?Q?yYk039K3CnpxzVQUMSUkITLTLynIVxpuxhUfSixfQQ6HqMgkt7/VG9ryPbiT?=
 =?us-ascii?Q?L2mo29fPpcBq7HWeqUiGFlU3Co2nQQ6055jxTUDCiIrUoeVWekxHWmmyN6Od?=
 =?us-ascii?Q?Kb5x/lgx92KJWI4WnCe5bAIzzSkPIGD4dQQt0eTtIzg14/tirFfaSxP+bUbV?=
 =?us-ascii?Q?iEm5OBYrq+ZblkeNGzPd8C+EfBqSOsbwmgPdx38KaQwX6b0D9xzST0FM0r8f?=
 =?us-ascii?Q?PwF7zsLK+CVSowc2YvK51zaCHxk2VCvND2ZpZ1Jm1nmCj77eeRevNujtwhvy?=
 =?us-ascii?Q?oJ3LFeeJIbdM+NKBVOSG9U3QPKctKNCLghbTnOcDL8U3hNng2raQ4Nlx//Vb?=
 =?us-ascii?Q?BryuvOhEZDgKs4lf2VMe8Khw+hdr7GS+djWeHM6VGryL8JByWnYf5A0jBYpS?=
 =?us-ascii?Q?8oPxsnBr85UsElllTj6ZIC5zjn4K95ak/pbFXXHVh/ngC6B0B7Zw8xpEenQr?=
 =?us-ascii?Q?K+QvMWxND8CsM2DBXdYskpEdSVRF8zueIqcEc4ux2w+QL1khFVUi+aDhfDaP?=
 =?us-ascii?Q?IXgZ7opAmK8FO600LCKWzECMoOOIDXaQacBANGjRN7rX9N8SgFwNEfL6spxS?=
 =?us-ascii?Q?Y57eQz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BL7UgaWjp1VAoebcfxcLCyqR71YCYrR1hwqI7sWZOlJmAngpY1ZQp9cHSlOk?=
 =?us-ascii?Q?eOeNJtpSnPb43q1ystEjU7UKQ9tFVQnp8z8ruhtREJ77yGY83368WKFwz4DS?=
 =?us-ascii?Q?j8kvKEQjDCg7hAe3O4zqocWnP9j8T37VZtTswQhj1TJhcaHhy0thxvciknbe?=
 =?us-ascii?Q?VAWfg6u9E2UD0rWsjU9papmq+sMwFAuOOuZkWLi1U98Mw8hWPNk/meOokGsY?=
 =?us-ascii?Q?ddu2r/VPdJpDEJxwHEyy5Exej3KiGVeNsLWw5WJ5g1/iQeoMRKSLk0jiLFbb?=
 =?us-ascii?Q?TFncHLl6yNTaiUFC2RHsOeSihsQxfayc5wmCVpJyMyHiIBkXnXKjmHf97/gt?=
 =?us-ascii?Q?cjcqboBUnvmX9pmBMVU6H0RYq3Y2sMftG4bBZBzhNDsL8jhhIgw76SIO1EPe?=
 =?us-ascii?Q?bK0C+axBuDsuib3w6yfUz+2BX029qF/T4SjfNEjnlykmjhkHibVspcEx7ciq?=
 =?us-ascii?Q?sEj04ZEQaCRmmf3ncg29rGGPZHhRUKh4muQcFETyAQdtSn6hSqOhD9Ido66V?=
 =?us-ascii?Q?+c1B9Y1zQhZRUb3wPvN1QmYNjaQ5nViposlL52Oj/J4lnP5UI5ss1fBCp6fo?=
 =?us-ascii?Q?oK6xOeLIMMShDSsuLzpij8laVyV4F+cyV3qpLhj0MglchTtd7xbm93yGOnnl?=
 =?us-ascii?Q?Uuz/ox284drmtheY323vO6/DvX6Bx7+Dd69JXD96XIv6MY5LSCUmSNXv626X?=
 =?us-ascii?Q?Bc1Qsk7bLPU00KBEH7gAVMM/XIB6OuyRHK/VuGozCvpJKU+PSXCFhsI2FoP6?=
 =?us-ascii?Q?QWLv4hOGvGFI3owT6VOaVrKoHWYJgXzgY2UEkN+CVG5FT3CkUg5jn2z/FH11?=
 =?us-ascii?Q?MpTWW332sKLTxqkYlvc8+nCpQuLt1di7YXj5f0KqeDHI905J1XNH08tyDqb5?=
 =?us-ascii?Q?xlQTLVflQVR0JGeNjHQeJl05G7mVLsbPjb9VaHYM0Gz/ofVXnQc7irmkzVHT?=
 =?us-ascii?Q?wg7HYmemvwet2gmP9Ur+XYVa9hkg2+gB21ucAxEvDYo1AvZGXJH0N1k2CFzF?=
 =?us-ascii?Q?0GsOteI3CNQjdk/0MxDJjieqzy9ncEXb4UgtP/dfXXQXIHuLLRcSu4wZJ+kt?=
 =?us-ascii?Q?aJ+i3uDAYerrCxLE/mMYwTggmxQNJ41O/eObV0UAq8cMd7bGRTZ21WiRihU1?=
 =?us-ascii?Q?mFtIn+PDfHa7duEilTPQ4W2w0MiklxJwbh2hrm+baBMplFPbAWY3gk51pMkW?=
 =?us-ascii?Q?zQmAY0i+XWD7yYA35T5YEyCJj3Ne89HBdxIGobb5Rnynclp7/0MBGheTEzy3?=
 =?us-ascii?Q?3yPBNiOi2Z5Lo6sZjrrQ3y2BKtl2Wagf6saCBRt7PahekCPgo+eSivFsiOz5?=
 =?us-ascii?Q?FQY+DGkB4XG42FE4PUiQdD22nW6KoFuZ5FaoHGSVjvRu+UCnSlgCojV7y87N?=
 =?us-ascii?Q?Azf5YxH9ArSKozZcENkNQXoKI6Arl1X+MlFe9t58a7l2978LPH2WIMkGUdzv?=
 =?us-ascii?Q?CUEXsDXiiXwR7XpbrYDDcgQk0PZ/Wqkt0NtQUjFIbT7lsZMie/3BKiKbJNfA?=
 =?us-ascii?Q?moorHk2oLDuTTPuYqVmnvdXg2JXNCTeCA0uhPw3rXBHDB8X6xLJNVPyBlRmK?=
 =?us-ascii?Q?stlnypCQ+Ys/0p+cSqr1lhD6eBctJ2lFIbFxmtCFvdawSKpFR3yvv2CIgn0w?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b87d65-8777-48ad-8dd3-08dcf18b9287
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 04:48:14.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QbSUKXCg3jY7PdIX2glmy+p3xjyOrdBLE67cXWfPIjr7ijYg5iDAuIa3V6HKmqVRbFpYQlDmmv+/TSROH09UGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7421

In the __f2fs_init_atgc_curseg->get_atssr_segment calling,
curseg->segno is NULL_SEGNO, indicating that there is no summary
block that needs to be written.

Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
---
 fs/f2fs/segment.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1766254279d2..35f0b5065554 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2926,7 +2926,8 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
 	struct f2fs_summary_block *sum_node;
 	struct page *sum_page;
 
-	write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, curseg->segno));
+	if (curseg->inited)
+		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, curseg->segno));
 
 	__set_test_and_inuse(sbi, new_segno);
 
-- 
2.40.1


