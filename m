Return-Path: <linux-kernel+bounces-298488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCE095C807
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FC2B25D92
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA46143C6C;
	Fri, 23 Aug 2024 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CjAeMmwY"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527913C827
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401587; cv=fail; b=N63kIj1WThGK+H3gxtqJRFcs6DkVYc3fS6LPP2Ycc5ZW5vpjO5CDCE9tphssJWaq8KybiUuqbcQqeil4JEUkhnR09HcqHPWtiF6+IGLkgxSziMsriAER3pFqOmNFzTG7/22VsFq7TRd9rfjMIp5guZNkyf/GNBEXgjw59ptOC6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401587; c=relaxed/simple;
	bh=5duORFDFT70bm9znwrYFynOe7vq32a7nVOkuIC2cBQo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MkrTrTbPBSjjJ8bipSC5Vfj0Lf0SdDMuH2qBU/dxvJIg+kuWSzgDScgDKem7FVoThqrI3726s3y06osZJu27I2wltPjSmVv7XQ1ybiktH53erOOPOlLVW7jUvj9YRAtzlTAs/1AysWnWCNw6VgMN6PpyoHhRc8HzFvucSMDC4zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CjAeMmwY; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAK4+WyKnzaddSuEcYXukvcEvdIOcXJ/z0yoefoNI0fx24giJyvOfcEKJquK+f+qdv+eVmwTGG4SygBNYxRFY6FaADva0Ru6FABzGWF8yoHtb/WUojATWJz83YnD+QFvkkhG1oc6DUPYSfcKZm2WSpCXEMpVLcPfrbz+RXNNXVTKN4f0vEUm5ulGk18A0TuT86OWiVsZMPrFu54wU0MZ1rHyneaBP6TczLvCk1Qok5c/0UKVDODjCQs9RyWxdbFT3P6KFUPUOUIgTh6lW1nidsvcUUi2/XTAdS+B4SkDvhaUOf2DSJh7k9vEwQGInJTxDm6CrHTP/laeQY9e/WdKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY3vWtOHCSD9B4tWbGYH55yrwdV/9Lq5vEdNt96cMME=;
 b=SsUpqeWKauIRUxLNVSJFNtjWlsmHr6nz/e2Ldx8qMZV8wbKspYWsu2IhwhJpHSEYzZjdHcf7Ulbvut4IVzGwLvbwPZOEqtSsx4s4oO+eMJxmL/OS4PNiUFB//RRr6CAVlRcqRs7mukM5AdAjBjM9crT95lAEM95A7hQ0CGIRM2qoUvEAcG/Ad7BfFyOdoCezvJr+jOrmhgx2rBVmQ1jzqzH7PqSY7eglCuwY8ZKIdaiDmsFFiDPM4feeuo3VUJyPivSlRBdpTC7BBGc02akhOZNOJUmabLozWC5vQoQw6QG6tnZwxD/PNXPxBkrkF22b2HkIf5+Z4qs561WyelhOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY3vWtOHCSD9B4tWbGYH55yrwdV/9Lq5vEdNt96cMME=;
 b=CjAeMmwYKjYO8K6v3HXWeMBUJH4w7DN1eJ8Ji55QtFy9SqCq/sM1T/9r8v9k7gbqeRtEwFej6oR8SlpWRNWWxiMXBrg+TyuLSHxjUub+kfkEJ0Zhr8vRsXN3n+I1Dg34/D4kJNsaLS9c0s+y75uSqlp8BEcJaVOctEQ7s0lOyQVy4Wi4eN5jKWNNpFTg1wbZghWOMVfQd6r0ZIyrbbt78wdWxx3ryE4QbCEptD/xYbBF9Kcfx7ROxY+7BHh73Dkw1u08g/o2qaLBOC9TDFUWMJbTuadG7ZjXIGWTVPSKhtYK9gyweZHHMQD0SzioffK+m99jvk7TCOJWee0DRAUIqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by TYUPR06MB6149.apcprd06.prod.outlook.com (2603:1096:400:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 08:26:23 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 08:26:22 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: vigneshr@ti.com,
	miquel.raynal@bootlin.com,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] mtd:concat:Switch to use kmemdup_array()
Date: Fri, 23 Aug 2024 16:25:35 +0800
Message-Id: <20240823082535.3419187-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:404:15::18) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|TYUPR06MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba64441-9788-4e5d-7f29-08dcc34d4514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wt17Ey9xVpAMzSB1z4NVYN2S0k9NJZK9iWylJm7cQS7PdYD2rrrIsM0wZqyu?=
 =?us-ascii?Q?s0BpWCEEUeHG+Itpzl4rCHlLWB9k+kPMB9UXf2mnezXTiwboJGC7EB4ZyTbs?=
 =?us-ascii?Q?da2CUbFO/T/TV67jcmObQYA54MNOf2u+aJyxiMsSu+/hfdloB9vNoev1O3Dw?=
 =?us-ascii?Q?bqO6EwzHHmCT/voNSPPQdvBEcVXeOvnVoLfpV2nr43kZjPB9M/HzKk6e/eGX?=
 =?us-ascii?Q?0zKsK7oVL+CBdngD5aEisGatYdNLiky+z/DObJNtBpQxfuBA6xVH38PK984B?=
 =?us-ascii?Q?02/lymA2xmKZ+BRZ/3/z/mUqOt91f+TWDK5m8OidHgKUaWad3q096efH5smn?=
 =?us-ascii?Q?lmOu9lT10y5MKr3AB6FESsKYxZf4uOiJn2e8b1D9pw3ao4AyeRvIEDrV+YZn?=
 =?us-ascii?Q?WxIDbeBciYBDBSKpaq9JMm6PgH280/xSdJRzcXoCltYDRJSYuVLNg/mBb9OY?=
 =?us-ascii?Q?rwhKwXOSTa18H/h8rFMLyBTh4D31y0WtvIia29gvcNGMStfJ2O0RP+uWrlp7?=
 =?us-ascii?Q?QLRYB+B/OjzYDE/Y5OydRzHuyUWbPVkZsHsiN3Ffc/0lFhnIZe+1ZJjVcTes?=
 =?us-ascii?Q?AXQG/8DTBJHipngoM3tuWrBdZIXjCi+M4KeTGzhpn8dO+C06Y7BA8/1FjDov?=
 =?us-ascii?Q?Z9YvGvmU1K/kXC8Of13qY1y408st32Hz/0lV/gAVKcnZtV1HwrGJpMgLw+Z5?=
 =?us-ascii?Q?uE5BkgRtwY8eNW/wKLc9em65rl7RlFxcASkgkJwmxWRlw8piUZlVbuxlWg/M?=
 =?us-ascii?Q?fGCGNNRCxChRxTZtVDPz5SufVVcS2S3x4EfBaE+rdQnK9ib+z5aTqklCny7O?=
 =?us-ascii?Q?jLBjVgJCn6NdIArgdpQj6Uf2FPtgmN8HXklLA6efZDI7KVpMLQNLpe4mTfh+?=
 =?us-ascii?Q?0LeYjAeeTObg/RzOGq44YDX/AuSWMK1LLm7kx6GVJom+VGgPkHOJTgbwXCH8?=
 =?us-ascii?Q?rjbyS6dfteREKXBRNxXrhyGOzOSRpeXQfzE+TPXKpBGz3vDZ6Q9fdXmZTN3Q?=
 =?us-ascii?Q?IV1oMBmIAlKvqEdBKuc584GJ8JfGGktupGg8CuJd8Xx4G8+N+LbYL0ZvpWKl?=
 =?us-ascii?Q?v6/4w4/2o6Ylm92LxrybYLw8ewlLewZmkVapudJz8gZ3W9Crfr9pIyEARz7z?=
 =?us-ascii?Q?ozzLmTwVy5ntRoeDPzNSe6QKlDmKRZ+QjX8Ngg6UvVfX2oA9GC6/kYCHsF9l?=
 =?us-ascii?Q?0iP6Q/B8k93Cp4yqZwyzfnmMiueBV3b9vyknsEc2pTeuwCLeYu1abkfHJw6B?=
 =?us-ascii?Q?Tv1UYiXXxMLTxgIQ5m6NLMwHwNt3Vcc8Z+tKAJDwy/5xBTLnoqAnsCCeVvQi?=
 =?us-ascii?Q?NAu2qupuYYZyXpkhO7OWEe4TUqf/j9drDL6ZqPWKxHKjXWHLtD6lZMKLNOdQ?=
 =?us-ascii?Q?iqKPyq1ge9hUYdwz3uMAKBmsgxOcZRjsWA83RKIbTWdjHMyNzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eKKTa9a84Grk2rIa7yZPhwvsUv86oJePgI0qlpaN+V0pBPXGQRpm+QYyg6gx?=
 =?us-ascii?Q?bQb1xy9iibvsqncHhQai3RraPU73U5xhJNnenc9zHDFIFcxgrvEOvk2BF/3d?=
 =?us-ascii?Q?3KY0una+6qZEwd8fkKlc1nGlMJ7wzyq/X0j69mePWr9Pw8aW7Ja7HQjyG4aZ?=
 =?us-ascii?Q?bGoZI1rFVsBfGycR0lAUn2YDeglrUpQENC+eAU0inWJ7PwGt+zuRNwA3wLkq?=
 =?us-ascii?Q?i0Nw/3KzOEsp4o79bq+C5FsPI6f3WR/0gLD+tFvM19Gcq5lo/pUZNOVDKRDV?=
 =?us-ascii?Q?chXDeNhsAI7mFphEiRXx2UGh4NXvB2/p6mceQAj+tAkV7vwMrkCpMqPPYRe2?=
 =?us-ascii?Q?Js7ih55jmhQH12haFyXPH7FNXb3vxxIIfPTWQk0uEwxdrP/gBd1R+WYO/USz?=
 =?us-ascii?Q?L75siuDzvPTcTd2FV0TzFR34BFXl2zmqp2Til1z2fEF6NSEypEMDKn8gK7mL?=
 =?us-ascii?Q?aKDF52455Wyo9llM62HxL31IjFPgML+uNqZ8cq0wAlyuG+dRb4lrx3Lo/HDt?=
 =?us-ascii?Q?f8baaU6yMAMbJk0fQA5CAVv5xPAg2oKXMl5qbp3nBxKup2wWxxUxGFlTnrzy?=
 =?us-ascii?Q?wh/PFlr7nYUkCHQwo/7TEkyRtk3KWuaIEqpRft0kYxwLDH1ECPEcCR20F6RT?=
 =?us-ascii?Q?0VJ6zdlXX7PL1KCV/z0bwg6hOHY/1B7wUe0JQRUCoYjAwfQYECjq7VaHPZwW?=
 =?us-ascii?Q?nsUhChGhRLbYRNGkA1ZWT1ePeHuKtPy4LkvtLAWFcmLraqoM/j3V/A8wd7XY?=
 =?us-ascii?Q?ziE2z9/G32C/pk8bRLU5uN80w73hoXrmKVXgYylIVEKvyOwXgHSeesO7gGYt?=
 =?us-ascii?Q?R7taJaSaUtMy5tBcnw3LvqeDMwr0qKwv3fzRVdQYO8v2hNsHvXM/C+9Y4S3W?=
 =?us-ascii?Q?US6xHLxUpUNI2Zj3F+u7fbY/yCXO6ZhMRi9z/9EIlR+IAZ5oy9wTgQ99BMeZ?=
 =?us-ascii?Q?VhlZYoAkWAYMglFrWzbly4xYjwpe1pDNklEQvGH26hFox/W1mQxTrAmkj5n8?=
 =?us-ascii?Q?CDirUK1Lc3lgN0aX6BzJ/R+PJ5l8iO7Fv3oS2cHMC1y/2n05JtboZ2L6CygC?=
 =?us-ascii?Q?uLgQ7TPeeQgtM1RF2GnbmOd+HWup3EMlSRHp5D/0SLtCuKhttbkGZs+ydjMC?=
 =?us-ascii?Q?3Qs71q1lce6Ob4XOd0IbJNJTouHIjx7HRrxWrTOzQuqMgAtcbnV9BpNNiEFV?=
 =?us-ascii?Q?RaSBSgAgeJuFxY6uP6P1V8z6HKBHKgQvwOfp5heLChtiP60y21gFPZmqLVIE?=
 =?us-ascii?Q?JClWQ3RL+vCSnI8NwSQ2WWisLedL3AQHETbvvED+f5CVhM9B2u9KSuEb2H12?=
 =?us-ascii?Q?T2Vv8/6fve21LOEMFUZUioUQ6E0GzCfd7xjP90aslcrOM4UoXHGsXei/F6J0?=
 =?us-ascii?Q?K08VJeh+bbDj+d49jiFQq9/xnGw3kUxE/sgc6wF+RsfOg0OPdIktpkxKfz4r?=
 =?us-ascii?Q?szkPSjYz/oSYY3N/xo/U+CJwEfTnJOWUVbriLqpL19T47vLdyXxWdmmVfUnX?=
 =?us-ascii?Q?fGZZa+XNORV1NcBCENY9z7mcmC8WfcRF/HMKXOjXGV85gYfHmvvmv/AO9VXQ?=
 =?us-ascii?Q?RSdWQecWKx3mGuJqUQAnIn3uVCPghmIHLNRituPV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba64441-9788-4e5d-7f29-08dcc34d4514
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 08:26:22.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjrAZducrrHsliJsG2czl9+ruyH1+3SXOBAD4uwm6+kIwZAuZmm16UPGhDTEH04Xww+tDwfQ64r6RS2qiaMWrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6149

When we are allocating an array,
using kmemdup_array() is more appropriate 
and makes auditing the code easier.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/mtd/mtdconcat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 193428de6a4b..f56f44aa8625 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -204,7 +204,7 @@ concat_writev(struct mtd_info *mtd, const struct kvec *vecs,
 	}
 
 	/* make a copy of vecs */
-	vecs_copy = kmemdup(vecs, sizeof(struct kvec) * count, GFP_KERNEL);
+	vecs_copy = kmemdup_array(vecs, count, sizeof(struct kvec), GFP_KERNEL);
 	if (!vecs_copy)
 		return -ENOMEM;
 
-- 
2.34.1


