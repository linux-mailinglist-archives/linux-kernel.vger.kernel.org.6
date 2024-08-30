Return-Path: <linux-kernel+bounces-308149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10E9657DB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CEC1C2227E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48B21531CD;
	Fri, 30 Aug 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J/WC3hGz"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1E1531C3;
	Fri, 30 Aug 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000910; cv=fail; b=Z01/ioHRPniBSJV/tw8KRHMGT8H1q/6s3UAroLG4oHTkZ8q+x1TbaRV1T4x+rdJJfE+fJE2dKXho2bRdT+NM8Oy61llhlSOLMQIspHMYr4YX8+YQrixzWOs1IH/aFLPNNdEqv7YfYcJsF2x6qA8drENKzV8TosyGRAq/qyVaIbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000910; c=relaxed/simple;
	bh=vFzu9ShYrCD+1TuuaiGLuueCu4h8alTaCiUJpVvvLTc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XYP00XaVDPiVqVBnOXterlRWApGpBD7K/5tngvaudfy1IqwTpB1TTmM/+6yZUfMzp6jP3yQ4mw3ppa8aqBHL70ICWP+cntmQb6ySF1KZvaWBVTWqFqtDccHfpeiEyyzTMke0OU+kFdEXRns+m/2gj67Tob0sXFrVzIM8WauUd1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J/WC3hGz; arc=fail smtp.client-ip=40.107.117.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzt3dxRmbEimfxzBGR8I7NXtCAg/vbS2wcm36BwK9RVsMVUbgCW13vQ/gF+1jmj7ylRC/t5P8ZO73tzYdi813DWSz1yCiJ8QfJD295XuZR0PdPy97+f7dDMaP0iHj8+oMbjjXn7dLKwMnl5ZMxMmO2fEwRpKm5aXEwKcuUjUVPjtNg96D62vm8YZIAwnlj9lyqQk5GeFAa9beC3/30eLXG7SXzizTbn08szTcVadEKsqdP9dIvbiUuhyPJ40JSGEGhHt7ZBeQ97+/dPQmIpyPL0tOtmZ0VOj3RW22qoLlDZSv/ycz2zEEGFC+kFw11D+0aUKLm24WvktfuOzkfqzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM8tizbN/UaP8LSJ21mzMNQCMSef7H7RNTj3cs2x6wk=;
 b=TrEd8oLjqCuEWZcA1lWIvKxc8kDGm+2WOzUOI+6eWvrMyBF4UeSvWsN6jx3h4fWIurP0rIYw8NW70sLi54c3eWYj/cBRHM0i5BDSCKkI+zIBOXsYmsBWB05/sGa96sewvLuqrmm8i4+SZRBD8BWx+b+Ue0hDrtHcvUK3KO9yMcSrdpsjcqa0PU6/gu2lIu+mZPXT7eC5Wqyx+/Qxj0zkTQj5lIofNS0yADgpvsv1F3Tt9lE4nhaquxMHEezlHlva/9Lekadt295GLi93LLm8X3AL6RjD7/4ZVRoLgxXxnde4u6/ANNi+qoD4Py3rHAZ0Sb7NaI8ZPeid4UHTX1cB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM8tizbN/UaP8LSJ21mzMNQCMSef7H7RNTj3cs2x6wk=;
 b=J/WC3hGzOpCqhbA6OoxdVjMicGpXQwi2OwZiuGiooIZUS0AGn3mDKU+xClLU7uXeoJYHI04PAiYqHqr2pN14n+UGcQPJou/wW5/oQGHdD0trzsntje7muDiHQ4BzZ+8owgnwvsJmFLzjFdr4HuNc1kDUNQUFn/slalV6MJFZdovccUGVkqQIjIodlacl+s4nn8ig5EBC9rfBpLWyUZXGSqmD3F2KrqW1F0vxkIZ5M6IkC2kGDsBFTlaGNXZHciGZuT0EFqsMir0no8XskpBGwgmJjRNFBy0FO2SqL2ssl2THUSjOS7+Udn+jVr8H0gkVom0Uv5xPC1Dx3HHsYc30qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB6397.apcprd06.prod.outlook.com (2603:1096:101:143::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 06:55:03 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 06:55:03 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] hwmon: (sht15) Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 14:54:43 +0800
Message-Id: <20240830065443.31760-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f041055-6431-4bac-5ca5-08dcc8c0ac53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?en7Qw2HJqc+XJEg2Xc4F+kGzsvn1cRJ3JO97iv864bxGhqnYtGSeUhdGQbgi?=
 =?us-ascii?Q?UP2ZjvcQK9ARU+yWIBcgbnfQD+SxGzmjjBsAkWNS6YY+LaFuQgp3ETeaeCrX?=
 =?us-ascii?Q?FxLhTsN/q9k1h1ejNshziEsR9OJQ67B9rtyN7F+vEwFRfSWjs/sslHK0PERX?=
 =?us-ascii?Q?Ezn9isEpl3uU7mV7n7uFGQ7T8gkzqxTBrMJb6+N8HvqH+0/i2hdl+dloprnc?=
 =?us-ascii?Q?RD814K6Jzgi08gTe+KV8d5Gi0aX0inkx6BG+8V/6u1zuLl3Y/uUmAa63Erlw?=
 =?us-ascii?Q?6TtROM8qTemk7nA86sBjdtCvlwvwXSwHF1+i9YmfWg4TTNDW5jvSWy1a6Vkn?=
 =?us-ascii?Q?KpGaqsN/MRE+y/wgMdKaJksp4WY4RjuZy0xpLDYSPFgAsdQt73/pKJP+cfsu?=
 =?us-ascii?Q?5+OFfhNslysn/DG0huyr2rafVhZJHD1ERabwL3hW2ZG4CkbO7+FDUDh/0QQ8?=
 =?us-ascii?Q?tzI8r2uG5QrGbcYlCVBJEHA9ZJZP7R3j4K9AKEqVnx2eOSI36c+9Y9978WIw?=
 =?us-ascii?Q?qwt1jP/oP/TOh9+0T4Rn+vpIs7tC7HVBl5BustFob4hqJdKDmo/a0P4oPrkk?=
 =?us-ascii?Q?wLwQp/B8BSVpKDQ95K1pwSAe8V7cfXiEGJCy8BvQWTrwhv+I+6zMxIa5JEo1?=
 =?us-ascii?Q?XONeusf4bdqxLVMZGGr551+CWaJJRZznN0XHnNl9I8cH8vIrSKfEqy5r7WVv?=
 =?us-ascii?Q?+sIwVCobm1T6Vd3POrbuJRU3l2ckm2SeAenEHeGb+gg5lHFjiwQaLnz5EXrN?=
 =?us-ascii?Q?7LTqH83muz8AKA5mWc1Kgfx13AQKz42LvN5rCoGbmO2z6094LmP3i9goHsOa?=
 =?us-ascii?Q?Lkpq+sk/RqQXSAAZ3T+GmteQ8YOAPhSBnaFYwG0+jKB+6McvJO6/PH1yNFLe?=
 =?us-ascii?Q?jK9xId1IYcgaagQVcSNqVLonbGzFLDb6/mnv0XYABC2lUB2koWzJDrUAmbz2?=
 =?us-ascii?Q?XlNRNjHp9I64ZWB9jFQ/UwF3tSIzpdchjsze771u4L3B1CE9XID9EHz/nKqf?=
 =?us-ascii?Q?SUf7uvm/75goqSOen8PyBt0ivFkfRhrYhKZuVOH1zqJ4KA0S1EifeF7ENWPq?=
 =?us-ascii?Q?F+2kU5rolTXQBxSyP0KnZYH8VZYd9aiDjcO0NxwWgVTDPoeMgnzQJqIobbwK?=
 =?us-ascii?Q?Qwhemo38niWwV1igeTIVgfEu7m3jMTUpymJbt8EsQS+TP2X90VI+6uUAnMyt?=
 =?us-ascii?Q?pvlWq1E6N4+FPXCNAB/OjUwpPpE1+fWgbQjq88DhfMbbanSCBxklZA1ZbNQv?=
 =?us-ascii?Q?8VBGoGbzJaldCbpzNLqgieHTEP7LCAUb6L9ulo4zmmU11W1hxB8oHeG8LS1n?=
 =?us-ascii?Q?Le8LnNOqyJHqwiL3smYhc8Mruqc8WT7tINu6Tq05duWpasLRGEvEZD8oCFbh?=
 =?us-ascii?Q?O27KFrldueqEAel42KopbIEkruTm9Q3WYEmW4cZJQio0vvsVaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkMc+paYmIIx4rMJfoxz6vRviQb0/3zvAtLtnbLbdc4sOiLYN3aDemsX1KRC?=
 =?us-ascii?Q?jpQ1G3NJ/2mQohUPEpRyH0HTGEz0nMt9lLIEdebMV+ZaRb5s4bMHkuRo79IM?=
 =?us-ascii?Q?GbJ/7VBhdL1rBrcGT38i9WkgpSH63a7mtNsQQEqgg02ws30KF0RImRdEqNE0?=
 =?us-ascii?Q?DnN0ZzgG7u6qBJ82NmoBZBoci5Ov2F/N15xWTzMHFLOXkOaOa1e72oTY1BEr?=
 =?us-ascii?Q?oVa3NDH802Ti3UASqhNujCPsAPNyEClReOCyY6QmZ1bKlRDNmphifFMmJf7w?=
 =?us-ascii?Q?crj0vG8NDPFzTET96wL9lNWLaDW+G0DMeDDtZF5ht+FXppPFXwCL2SCxn4n9?=
 =?us-ascii?Q?xT2s7T6W+HI6Q0u0UXpMZmKqMSXEzhZOOYFT4yJ2cxynEKM7ycCXzuX0uKKL?=
 =?us-ascii?Q?LiQ0c5GxEncHFDBfRWXZSQ2AKbtl9rSWtR0YsCXLJIV2cQzx20DRRdmi+ztz?=
 =?us-ascii?Q?CZEwUNH6TXMnyeoY1V/0QNNVcariw86LAHWsIkOWPuG4Q94MG7H5DNUKni1M?=
 =?us-ascii?Q?4OniwAbRPGWjUEr5gnjS3f14seKuz+ZexRXI8wWUKR3VYkTC3eSQ6n86AnqT?=
 =?us-ascii?Q?72JZzjCwjISlG6QwvDpUed6WdIhA71fjbwePD9hEF5D/jmRP2zUKY3Dg5f2K?=
 =?us-ascii?Q?BCy7FsU1+4skX15fxhod68pGGenFIo+CNWStJ9N6Cmq9b2w7t+JU9Fisot1I?=
 =?us-ascii?Q?YGvxoWiwIpGNM5ZyWqn1iZ0yRTI0t0i+/+lkHnPM2izkK48Yfuszj1LCXA0l?=
 =?us-ascii?Q?CohqYpKb26x/57HvkM818vDP1PAV8hyo0Eyu1tJ+DZCVVKw2HydRpA4COJ/e?=
 =?us-ascii?Q?Gq2CkBfcV6TRuyJ4Id8SV4lgAXwmbgzYGC2Po+nRscjqRQ7k64j9zZL0UIK2?=
 =?us-ascii?Q?UF1213DQ2MCOEAsPogdYa6pPq+WfSD0y9j442bcv/iJAO/j7TmBg5Q8POnrm?=
 =?us-ascii?Q?4l4mbaEbllqxoCvSSuEKiJNQPzTVFMNv246srekfGcE66qAU1RtGHjA41RGk?=
 =?us-ascii?Q?O1SIdySFzIWIUk620cABY2hGXSFQDRkEy2SqcUlFmWN21dsYK7SShh4IsJkV?=
 =?us-ascii?Q?7GqlS1zm7HkWE/yPLPV8XJyAE7b8Opi7oKW4+Z/We3gQ29HJrn2swI+2JSJB?=
 =?us-ascii?Q?dWAsLffSuSag+3ppRnyqtZBZpwC6jtPc8VxegY6UPrwsFaWfqkxs2/XAbYFk?=
 =?us-ascii?Q?GoFwa0z0odTD3Qk1BDs39y9pAXen3gOCWOLfEs1rZPWTCD1+B3ZmKw/ionMl?=
 =?us-ascii?Q?F9TiQJt8l2lE9xY755qd7ONZ1whJVQNe5jS9dX7UnE/Hdwz9Lc7MVsFOeZD3?=
 =?us-ascii?Q?nnDcgoxArZ4VmRF3FNUgdazTjQoc2saArgF5vh23LL+7WJO0jdNG73U4ZFcl?=
 =?us-ascii?Q?IJUNrmqgKLmymPlMdjFf5/SIFC4LyeD9pHCBGBusho6Kg4n2dk+lfwTJilwm?=
 =?us-ascii?Q?xEYg9+kBliRBTnvXL9X33+yiQG+NzYuV/nB61u+qWv1scj6l5PqsBVyFqwLG?=
 =?us-ascii?Q?4aA9fZHNKviLxaAPPmsM3WbApE2jSCroIynJrRh+vcw+qChCAHQ4BrYUyxd8?=
 =?us-ascii?Q?uB7VtodeJgflI3A2WN7oK1Mk+uS9G4jEX5Rp8dbN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f041055-6431-4bac-5ca5-08dcc8c0ac53
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 06:55:03.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWFFqDcqI/vEqCYBvydKS3P2za+kebo2ychAv/chBLCWVIf+y8gmnNeWtTnUv64snInGR5BVQMNGk357w539fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6397

Use dev_err_probe() to simplify the error path and unify a message
template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/hwmon/sht15.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 494f9655f44f..cc3a46a9c68e 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -942,11 +942,9 @@ static int sht15_probe(struct platform_device *pdev)
 			data->supply_uv = voltage;
 
 		ret = regulator_enable(data->reg);
-		if (ret != 0) {
-			dev_err(&pdev->dev,
-				"failed to enable regulator: %d\n", ret);
-			return ret;
-		}
+		if (ret != 0)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to enable regulator\n");
 
 		/*
 		 * Setup a notifier block to update this if another device
-- 
2.17.1


