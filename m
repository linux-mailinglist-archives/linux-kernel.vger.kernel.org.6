Return-Path: <linux-kernel+bounces-324167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091D9748DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D491287C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5157333;
	Wed, 11 Sep 2024 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l5EZKd3S"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010025.outbound.protection.outlook.com [52.101.128.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5265103F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026226; cv=fail; b=iEGfgIlHFbfkU9697mZp0BNdKxudvWojGCePmwNU2mcWSvaxAZ7IUG+B1jNDVU/6mvveKlmYnGQ6ICNZ35f49U+/14PSIWV204BxqddWsfPEQ4s9VuTqZP/fPvkCWLo88x+oLfjH1vYYrIIZNc/FZoiDNMT8U/4nk3qLVWzoegY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026226; c=relaxed/simple;
	bh=oTvnXGPqFYJXJb5D0FNjKJpM8OsIgxPtdmVwomCHj4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnOu4mbpabyM0c+pCyINpvJDFn2pBqoZPXAuIsekZ+P/JIWQGDMtAJi9eqCqWbAqR7gffzVw42CV1ZsarQ96JFfmQsnj/Eq5kvG5SNjyn5fur6VmCIk0Ul85gu+BCZ9lyCjY4qB5ddwVCi1WEToXjKAjwQgBvDus2WpHP+K3Xfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l5EZKd3S; arc=fail smtp.client-ip=52.101.128.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKFd2xQb0uFC4XCebKag1HWrtH/MS1M0YKtCcu5ZTLxkY4bOqhG+4m6N8sYn+L2Oc9qNgBIy06vooeBewIB+T+IDeO7lAoo/BvG0Yckd6X/t5oQ3kX/d0wvkLNH+XHq2i9pFsj1i8MD4eR8VwGTAb6d98734bLDeeW/kdY6TlfxpX8d0OMy8ZA0hsgprYaqiqs2f2nZLDxLnvAxEuUAuRzux3ZIhHhEvPAS+vkcPXn3a97IJuA9G71hO+t7pAmA94RDCuspGtcSe9Ee6nKzBte+TgZXJARRsg807ME+HbkAEY02aGzAscd/GT9cpYe0ELvy+PXYgICaTFLM349iDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbAYiYW42KdJTqSuWfOstLknlNwHmM+iHowcLx3rDog=;
 b=bW/13Oves28hopFYbIt0mlCOX5snALHYzkxLGUY25BjSRjQ5AzHbHiLHfWHsJLFnLt7+cdn1YBAMdnbHSexS1AJ7LgTM/aQKb3gN6na5OWZcsJvLXB3tSj486rhTbgP5CuJltI1E64r7gYjl3cRkBp1Ca1AY0fmb9+33aOwBSY4dUjYwJWLpSusnnXYpFtcAp3IA+6Kx/HldrNbXzYU/fLg/VmBPEMkNpdjbV9mBc9Lwu7s7PKAsu6J5FF7O8JgBtHE7gyjoFb9ai3z+5L4oGG3/8veGfWCc5HB8sqYSq0gQ4z1ce/jYKNocYi2S/dQlKgW8umrnD6eXKsQYD95rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbAYiYW42KdJTqSuWfOstLknlNwHmM+iHowcLx3rDog=;
 b=l5EZKd3Sy2mFzy9nomCTuO+qjzHqSJzpEDFZcfj3IreFYnYnNFICaDEOU/D+d31Bmsp/efLo0Iu6s4NsaKB4MjZMjCYMCd8iX8qdDz9GeEmspmT/VWjjDy/K17p4yLZVUDgzlTy2NtfSEDKrbb40rx4H3LB61W78dENtQBoHkNOmVJoZqbTYxhSmlnSz2Hoz/07i9SuxA2qNVWzx0MdRfQZ48z9JnF3Kn8/Autm2QJtG9u7dh1cIEZVPgXraOrbircqmgdaITSIMnmURXRDBT0yIGRFtk11N8auxR5cY/qTV7Luzv+tH21Si68re152GuQMDdCrFdcviAvTgO0twGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEYPR06MB6279.apcprd06.prod.outlook.com (2603:1096:101:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:38 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:38 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 06/13] f2fs: fix address info has been truncated
Date: Tue, 10 Sep 2024 21:57:19 -0600
Message-Id: <99802996a3f4a0c2d89c79ec17be94e9c62ff8b6.1726024116.git.bo.wu@vivo.com>
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
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEYPR06MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 8877363b-55bb-46f6-4eda-08dcd213ebd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hcWEKG+sf+SSOdmiaWDM4zadxCoQj//++JBjoB2BLwf56hbbq5OAlRhBp4KD?=
 =?us-ascii?Q?pfgIITFrOTHJMJqTV7JsxioR9r0OMGGlBwSoBvxQxiOW9wAWReWz3NQsnv84?=
 =?us-ascii?Q?T3xf+Dx0f4y3SwHSRHIY2gRmm5KxA5satyJgsTkl4yVp2LhXLMryF9uuRaLg?=
 =?us-ascii?Q?ZPmPRl2oH1jIICNO1/Tl6HzTxWVxw6meiTZJ6n30OXWICvZo61Orfh/AV6Do?=
 =?us-ascii?Q?nMHzI7Yuk4FaJu0EDe8m9JZrozGbYnN5yjXXPxWvBq/MwzAZKIhLbUfWK+Qi?=
 =?us-ascii?Q?+NdmMDynKhpwZkqJ2ZWHqq1dzV0eOEnmqZNXe1/YsS0bIiVhvCJc1L0OekW6?=
 =?us-ascii?Q?Pna86dbzG8r1+MsSv08z7M3H9Un6p8GJzqQD17Z/0lONg8DtQQa7rBRDH1BD?=
 =?us-ascii?Q?KMy9+PQc7eKJrSxGPLpevt+eAfFT8OKqz+hOrPFNKntfdkz+Zv7FjBwv7Mci?=
 =?us-ascii?Q?N0nCmZVAm7BK1BhqU/GfZjHkq8NXKUGB2Bm35GoZBRwWS3DWnPYD0UsQBwwx?=
 =?us-ascii?Q?zDFvKH416YJ+K2c4UL7jRl57pJqm/rHQbsEL9ZO1BYZk/Aud/DQPpuPV3bEZ?=
 =?us-ascii?Q?IJy3GAF9xFpB/PI7boqgjBL2vmhedvhGov83uqi3EHyfFEoNkm+uAYSgat0r?=
 =?us-ascii?Q?5LrM1oWnOR5IBFx0PnBIJnecPZEYHx/WxiNGFbjk1Q55LV8tI8ftlWxWwjKk?=
 =?us-ascii?Q?HeYxw05RI5M8VNLH7wO9aC8xOcAzsLXbTqpUOXCjq7m86wdY7vKJxMP8zQxG?=
 =?us-ascii?Q?Gd4YPHr1iAn9VMuFagt3gAvtIYJ4QrQ0A+A4zEwYApQFKT9aiNfHCbgUUPb/?=
 =?us-ascii?Q?MeJZG1bf519uiBzjw+7JfMbBbPPJzwdCs20i/NiP3gQZMLJWd+GlGexAutiR?=
 =?us-ascii?Q?BebIkqBYAQzINiYPC75ZH7JmdnCIRkd9R89AJkZFV5vgdPxHFxiFve4bDr8d?=
 =?us-ascii?Q?M/guklq88gwlRkyDPV27MLA4o+FqDeAbIO0/aGlIzy8Rt8aI24NPwjTtR6PR?=
 =?us-ascii?Q?Usdf3yuzi2qVNfhPJMb/yo8oBlGF3lvDiRZswdxCWenKcQusJ+lF0veJ+QDE?=
 =?us-ascii?Q?Yl+izka19Ub55pSRUMW5yU6eSveNMIKJBdxoRS6SmMlCTFnTwt1kjVl5JrEX?=
 =?us-ascii?Q?Pt1EzlbZjTPaybnq6XB/HWAKfyITxeWhc3ht+TBnEl8XlWivCjo4c8L5+2YI?=
 =?us-ascii?Q?yiukyEyVRjJfV7IgxcCPeBbYorejxxyOYSEIIFoqhvfQfRtOc22zl6Bxkpsf?=
 =?us-ascii?Q?64AyMs5Ev9UIkA0TbR+Cd+mgTHIR9FGW3W9c3oLnLx/a9yduevhCS+Zq7kD9?=
 =?us-ascii?Q?xUO6RIl6tgP9MUJIC3gr7cz61H0DQNne78PBjW8AfR0JLXD3+mnGcHgYF9+N?=
 =?us-ascii?Q?fBF67LcB/aXlWWfxjOPfyAORpr0TQbSOWkU4zT2GbSlXRQhiUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?szMCZhptJGqDzQWHTnXmAOXTWGhTWWfP0SfJD7ZIi+jPYc/qHsGu+gPtrCyK?=
 =?us-ascii?Q?LDJwViIIK/e4pXA0VljTxLCMrD757LKQQlGoZr0me8iL/Ov67CD+XT6U2Bfa?=
 =?us-ascii?Q?BUDZUGktJTqWK6X5Av2DeZCLejtCS7H9A7Ra5I2roRIeFspqzlGEHnz59T7G?=
 =?us-ascii?Q?G0FO8793e235lAEmoNMTqldHsmUA9KMH6Ha+v4se/oPdDTHCX2gP6ZU8Qqqk?=
 =?us-ascii?Q?hp92fPnK1Iz5xJDhA6ertgcZ/RQ+PD1m5Gpulp7zMxhWMp8+GB7WuUvha4KU?=
 =?us-ascii?Q?DpG/IxoNTL2bPLyeoTSZ9/jnjJMQrICnxM3IU/Go0c3FNyZ6Sr/AJ3f4t4sb?=
 =?us-ascii?Q?dAaopNQZcjvggALyicYyAnqg10BdR8QQWUFOd4RfGxLx23Lh5XRcOe9jgcuT?=
 =?us-ascii?Q?o53xANi3/pCnwEKN2BdibAIcO9qOUrx0aAK42yJBQIRg4teajS+UhEeb5gWv?=
 =?us-ascii?Q?8TfUe51ECgjHBwnpIoLc79L7UWSRweGrWkrZznJW/3EMfA0XgpCKQeC1Frqy?=
 =?us-ascii?Q?2H/wHvZpk69jAQJ02/TB9kKtGIgInFgygQmS/L2Mzq5f9dPpFoPG8WrxkFP7?=
 =?us-ascii?Q?QMsnizPr5iBuA9E1erutlRcU+Z/98LAoZPKr/vpC+ZEAxnjnFfCy6qnrti+X?=
 =?us-ascii?Q?7k2y2G1AYvwJsNIxBx+5GyN7Sp3N3TrKY7pFs0Hbp4DSYi2pUtCXK4slw4zn?=
 =?us-ascii?Q?5omLEf3Gtlv1SfJe5ql5ewtUixgJkSAktCX9SX8B5UxkRh8atpzc97CihtBz?=
 =?us-ascii?Q?WEoTPoqFDrt/EqN58GZ3EQLPV3oRiy7lm6RN26HanQuW7M/WV34zaENZOnGG?=
 =?us-ascii?Q?d9gXE6wlXLC9gEWJi9gzBZOttlQTTUgNqjvdSplqKhZoZT5gQlnLEiS41saI?=
 =?us-ascii?Q?tHAqU22tLLtrl4c9oFK4krWv2r28PJs+wxvkWSvd3p0roAwghKJFhtJ7cCcH?=
 =?us-ascii?Q?clsUk+r4OA84KzMhptPdBhiNY5rnubXww8yJYns7E56hV4bnp+W+JICJEuCZ?=
 =?us-ascii?Q?CBV0K0QApXfZtfKbK5Kb+W4WWM9Um4jA4VC1hXePKuQ5EtQfcE0D0A0V4+Lp?=
 =?us-ascii?Q?cM6i3jHtV7MbW2cQdMCUSV8p3soeIOH83w4Dr9GBH3S23gH8nUbvW1fqPw+Q?=
 =?us-ascii?Q?jGgEALT1JPOFBhJx4UcOSXKuF3OwI4qEpOQeW+OkGo5/suw9Tui00k9kpWTF?=
 =?us-ascii?Q?nQpV3ZEbqzWTUG4C4nt9pqQ87utlK3EJ4mrbldKMbgyf0sQCa3ckHD8glQs3?=
 =?us-ascii?Q?Y7N+SQkavm3gowyMMbFeM1GbLvzG3U5SI1VwXgLroZhLl9Jg7aMZizFyE6iV?=
 =?us-ascii?Q?XR9/5d8DFwJuiIQN2jrB5rx7O2dITet5gAqJx6laPYzd4E46YzYtpWeYptBb?=
 =?us-ascii?Q?aHo/+7H6d07BSFHa7/jejmG9K004f+zoekS83L35RSwS8QRzS6xxau8Q3+zp?=
 =?us-ascii?Q?UYoc+Is1F7HxC3K63x6GS0EswxotWSkYDnk6uDmll6cVGxpjN6xyv7ORs6Vw?=
 =?us-ascii?Q?JHHMhbrYtKHMEWGrHJK0ggUTo5n4tN19EWBFpcoTxe7ItrpFDEoSDJveUXh7?=
 =?us-ascii?Q?OQpHbCgf6TIUS+hafrr3A6EDolRXF8g6hbArLL8B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8877363b-55bb-46f6-4eda-08dcd213ebd5
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:38.4854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKc+COEImFD3s8NOJ3YRALLS5NvAKl49DZYargA3O1j2XslPXSdr8FhdVN3bhXImpgsqi+JHD/yVKA8mRYCBYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6279

If there is no data inline, the address table should not be truncate,
in case there may be reserved address info.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 30b18053e784..a542956d618a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -224,7 +224,8 @@ int f2fs_clear_inline_tail(struct inode *inode, bool force)
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
-	f2fs_truncate_inline_inode(inode, ipage, 0);
+	if (f2fs_exist_data(inode))
+		f2fs_truncate_inline_inode(inode, ipage, 0);
 	clear_page_private_inline(ipage);
 
 	if (force || end_index >= COMPACT_ADDRS_PER_INODE)
-- 
2.35.3


