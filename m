Return-Path: <linux-kernel+bounces-568012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A7A68CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C249173ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C43253B60;
	Wed, 19 Mar 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="GvhIoht+"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FC2561DB;
	Wed, 19 Mar 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387478; cv=fail; b=QbMwnYXBdtza/wLcunA+jrMCPGhY2yyhoZWPzkWMrGz8BklE6tM/PHpndH3whGDYHXkbfiPJymUOGytwW+tiiGqGeuoKhRvIaUGp6TvME98VkVVXmGvJcGekG8tlU8YClDmH41gbd7TzRT/6cHrgoYw9KbVnNWr2hA2HIgE2SMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387478; c=relaxed/simple;
	bh=5PvLihW+j69y767Ve57WrHRsA+jz3tq83Y33zGfLows=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fsM/0rGErRIzGrA9PPKsaNZEXaWJ2Xi0aGmR75MV3cV0Qg7HZlsTYmhp3NUfCape1sSI70gicqWqRJ8AP87otorD1g41MENrspfqeOQcCxvoHkwT/9OqFq3DH3gGL1EN4bP3crrnkzr9c9R0Pb5i3qsr1g4xwbkpFGxRGCGiscs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=GvhIoht+; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yma5IcZH+EBqKnmMOFE9KVt75HhUXXvC+xh+4YcxAPyByHGvBB3+8B+V4xml1lIda83a3WlCHIYIJLext/MLp6HKNgr/w+eFKYVmsjYf0DiFHay40iP708ke3gAWEtf/Kcph2yb/6xUSbhIopRePm9KLVT7phoB/gDw2V7xXSmh5Xg49HeGXtDI3WiEuPNMvCB7KJl+OvzhLTWsAQPesMSq0IYtGYSHgrbzV3WmD+X7vGRzT0jB6tWq1SuxBeuxl7HL9+4M9PALXU6KwhDv7REfuSlYllB0X01VEKqsOCRbrUVN54gi8l6Brit4k4xQHNpF+N17NHz+ZPgT5eRuomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4d/F5NFPZncF+9CR39Dp52JGeQmMuLGWGHtWYe/hZs=;
 b=GvT0Uj5m+rv4c7db4KsRcjPLOeoKBjoN0KaRCNHr5HlKqMjSiV9Vb7TnyEAuW7usXPrISFSNGP5FmqEeDlfMp7gh/GgocGbBSCKgpXVm5swnqMLwyyKlKjR2JDR77obkCG4wwdc9KYQGU3lcSsZt0MxEpG8it7ib562WTjZO7BNscz7IPINYo+Fm0FdrKN6IMYsASA/tWolua988q8KY/FhukJygcUeVfBqRB1M0jNvvqhk+rnnyXJuHQqCLGkq+pbg/LxOiq10MtUQPYYvP2Nf+IyLJzurlueSKqLYn4qNT0fdVVZePeCeJNjGY8CEfTliGuRfWi87c1DnpQ9IMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4d/F5NFPZncF+9CR39Dp52JGeQmMuLGWGHtWYe/hZs=;
 b=GvhIoht+bagSeupGxDVRWxBVvbwfyGkx1VQYYH6JOH5nhqG5Dg59QBPcZbX2mbKCRZS9JSWkgFbqf8Cz8HNrOYhpyIgBo0yRexkY+iGFxxqAXd2zFLz+WvLaHzJSYaR+pnnTUp6ureQaew2fbu57sBaluZO4UeKsDHq/JG2Ofdk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:07 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:07 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/8] mfd: ocelot: refactor bus-specific regmap initialization
Date: Wed, 19 Mar 2025 13:30:51 +0100
Message-ID: <20250319123058.452202-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e5dc02-7abc-42a6-89a6-08dd66e1ebe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0yeCbSgW/fa17J6SallSOawBvshQjMH4HJ4xgjflXNUJcu+be1WqfSgZ0/X?=
 =?us-ascii?Q?EsBmmbbsUUT2jXfOCcmTMn7++svTCiTq8/OTMA3bamUCejwqTKAcLbdShhEI?=
 =?us-ascii?Q?gaeRWZbFa8mmz8OFwm1qdgb1QxO8mqTk3ubwdmNnmCuVHirAHBosl8HGKVTv?=
 =?us-ascii?Q?6fnAmvJnXhi7K2BAaXweFdEvX9cMBPGcmb9dTJ3WR50HzRur8hXuGlWfcHG5?=
 =?us-ascii?Q?exNWrYssdWpNQaulYy0Y/oy60OrXMRO89JDNpG5UZeEy1Cgzl4oTON/DkqVL?=
 =?us-ascii?Q?lZC0ZAzKNGTjlLwRIFNNG2zT0N8X+BeWStyCxX6pz0wol6+WzJyyScWzZiup?=
 =?us-ascii?Q?AbFQ4pYzmTBMeXuQr+zac6sFh5eZfrDleSzasKGkFc0aEFY+QbrirudgSwLB?=
 =?us-ascii?Q?/lJS3i00fnBrZ6TQaKhK42fTzjFwPnICoXokAJMmNifud3mFT2v7aTN6b1Sv?=
 =?us-ascii?Q?y37xXwnFWNSkIluGKYL1N0AXU5ZSlkBcCgZ3+LXYLQVA7MCSJ4pqGthVVRea?=
 =?us-ascii?Q?slvU9CLIWV7QIxPEH6W4/Dhv/jn+Wx7tqHHDQ38ecXQ0HZ0X9XGpjuCEobUL?=
 =?us-ascii?Q?cgpcyR0yGSEvxQp5MiK8sMXTd39FxQ8XrB+bIdTDSVpKXsjxTHnjV4l+5tns?=
 =?us-ascii?Q?3AZT+fOl0OibdJL8gSEXNEujgw1GXIouDpbWvuMmnOAx0r0iNUmFH6XMzMjI?=
 =?us-ascii?Q?81amWfuKCHfsIU0AbR0Nx4JijW75IL4xyvnfUSL+arboO/6VRC4J1aO9yIxV?=
 =?us-ascii?Q?6SGG6d8F8o6hrLsHF72bEg1RCNUHFpSJ2UIcSdDGkWcnb82n1izUlakRL0PZ?=
 =?us-ascii?Q?qpN5NULTsAu4BYnpTNxne51xKcPPKrR7HG2TRc2ywoP183LyGWoba2q1zEG4?=
 =?us-ascii?Q?6tJOs20SXSwwNW2tnlQdEpzAbE5KH7z4KBhfojAQF+h1XSmZoRzegq7AxWFg?=
 =?us-ascii?Q?X2Y5Z/51WoOk6QVFb95HhARcew2RmbMX3q/awA5SCTbmyTvdgbsP/X3B55/g?=
 =?us-ascii?Q?rTRD1NZKN2u4osLa26G6YvSi4kTlQCovRPteEy7L2tLUUpebB2qXzh8kZ7mX?=
 =?us-ascii?Q?cE4lmo/GzY1MeUsdN2yddzNcgccYyXolnt5le3DhmHtG7dN24whAOSfe5CfK?=
 =?us-ascii?Q?WfvAYHsQXZlczzUW327NxsKKZzP0bM5LADplJyybang8d0h+B7eVjuSm+L9a?=
 =?us-ascii?Q?fBhxJKYA59Mupmu5m1k1xdJ66zq0Zg7uOiex5/0/oRkAFStC2zRoQkW8Mpst?=
 =?us-ascii?Q?heL0LR0ijMq69wEdV0aDKieReq1Eiob1QBDf1kLSEnQ+5vkXDyxPJF6W4SBv?=
 =?us-ascii?Q?LP3c/HELsHmeY9nyTZZR3IWx6/iXqoITx6psGvt8oRhskbjNbIBYdAhvNsJN?=
 =?us-ascii?Q?vNMykdxS55gRY4Ev4OGJ6w6qt9Dvs+HYjaGSK9O6nNIqUp7UF7QJJgKX9ruM?=
 =?us-ascii?Q?K0MZgcQkXqAbFxdmgtLkEQGZputAV1Rv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M41/9gUkMnb2p7i8vTOy6Cft3ebsTRq5Odk89lVpMJwEcHnV4xXRdDcgDfJj?=
 =?us-ascii?Q?vPBTiTZ00js7Cf/t9Q5fmUD2fxI65jwEbgwiku5Of32ZhR8qpDUSeDSsptSW?=
 =?us-ascii?Q?q24h2Bx9Sn4XtX3SLjuyS3/GuhDx4bmEY823evJMr/ZKM29pUc80CdSWCSXk?=
 =?us-ascii?Q?Q8UMLN/xtVJCryLuLkrgc1+8s3WGmrfMCmWxs7e9b/igFQSgMtgNvM/U1CWV?=
 =?us-ascii?Q?V18VthbxJksyG1/oQ/4HIDCctyTJFREoyC7s6OT5dMbiwDYZk+sIWoWX48wv?=
 =?us-ascii?Q?HpW007TBAuzngBZIzFz8L3pu+dmeSAZ06a38PNvewTlTXWdmDVtvyE5vPW5N?=
 =?us-ascii?Q?YUbV50AJDPalYintD6KwaC14GvwEcVkLzrPyZtap8t8i3fElb3gKmn2CiHUy?=
 =?us-ascii?Q?5cxiDejJPm1QkxGDAL3+ILsL+mw3HWIoj++H8Xbc50OLs9KIqcm1L9tymOx9?=
 =?us-ascii?Q?bPP+QUdI43v4Zh2Hx6Eqe2t21yYeLBYVJSYquU5+R6ZShnsvV+W+3J6VZ0XD?=
 =?us-ascii?Q?oOgBwgDlyjUrcN0OUqJgDJWLBJVHMhx4Ivzjrz1WYoMI03pf2vd42XfWJB4+?=
 =?us-ascii?Q?3bXh/ghQw5iLY+OCA0hQFGSnvXdFlam/kZLv/XPztDoqpEknH5o6sIeBBeVd?=
 =?us-ascii?Q?uIjFdsVMIQZij09o5l8jQnsPc4eiRHr8awH4FizMDpOk0kspbHEh4Th33OLS?=
 =?us-ascii?Q?PC0aDGkx/gVoGP+i6MK6fiDxgPzwRMt0sYf8ArcFqsIcakD1/BWok9hLlkIb?=
 =?us-ascii?Q?wxvHfMfJMU6LNVtg2rtbOLJRal/lrrl17b7pW39VsR3kQQonCITPO9tEIzGT?=
 =?us-ascii?Q?qRQ3MMC2vtF7IcKaDSTTLPT6hisVztuUf1XuheB2WQO3fS79GjUaAKASm/k3?=
 =?us-ascii?Q?zvWq2Ds/EJ1OCa28IiEVTlfRsZt4CWsLVTSDY/PdfImuLg2PkialI85IrMMV?=
 =?us-ascii?Q?Y3OcMSi+wZowb7+lQwivsoKdUya4Evys5iIh7JcJKGVuXYseSj72ydcbWq7p?=
 =?us-ascii?Q?TgyUfIK5Yc+Gv8smcJfFtwHo+mHV55lJl5aNe+ZLihIBa4dHI0oClxuDLmqu?=
 =?us-ascii?Q?vgYDeGd72kGCf9Ry0QmlUtJVafhmdjDdiP0i4wakOnOzrscYeYtL/NPRdCce?=
 =?us-ascii?Q?64RaHODV2f0T2GZ0Kipkl9tqgq7enDKBxxkWZB2NehYssne+Z3f+yR2Q5riw?=
 =?us-ascii?Q?jTHgL661LgF2vy0tkB2kdyyQoXXxYBxYHavSCYUbK2007KyL16JLAyXDP5BN?=
 =?us-ascii?Q?JdJ4nkffe8vSc24ReeSsgs6lqCSXxf3joFQnYmtQR4oj+2NOngIBn08C2+4Q?=
 =?us-ascii?Q?Xj2exsPJiGnBWZ0esH3h7uXjfSPMiz49QcG+ppAr/JXj3TCknnxu0OasHwuK?=
 =?us-ascii?Q?MlcW1h9+C0mNvC8s3U17kpKqQ+69nXAq49yvREtNTsr5fplz8f2RoZWTVXM2?=
 =?us-ascii?Q?V/EAeMUCYW0C15iPNF6iOrYACr7woHmnR/4TPbMEZHSm5RxCnBxxussrXxkC?=
 =?us-ascii?Q?pa+lWj3QJ2+jLGE9gtxDeupMKOi+h7hGZKgGyyeaj6QDajtT1+JRs5JxhllR?=
 =?us-ascii?Q?DRZ+7LTprqe9IRfEwWYyJAkzlx3JQmzn383jXNHkMSq39Rig7RiLPYTZo1hx?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e5dc02-7abc-42a6-89a6-08dd66e1ebe7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:06.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoVlWZsT/p5V0ofCvVG334eH/X1q4qriiBKMUEnAgzTUYF3UMwcEX2n95/0LzGkpgqtfxu3JDzzAl4BJxOTjIDXdijRxX7KZ3LWDTeJSLAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

Make ocelot-core truly bus-agnostic by letting the bus-specific part
set an ->init_regmap callback in struct ocelot_ddata, instead of
relying on the bus being spi.

With this, the only symbol in the MFD_OCELOT_SPI namespace vanishes,
and hence ocelot-core should no longer import that.

This is preparation for adding support for mdio-based management of
the Ocelot chip.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/ocelot-core.c | 5 +++--
 drivers/mfd/ocelot-spi.c  | 4 ++--
 drivers/mfd/ocelot.h      | 6 ++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
index 41aff27088548..78b5fe15efdd2 100644
--- a/drivers/mfd/ocelot-core.c
+++ b/drivers/mfd/ocelot-core.c
@@ -200,10 +200,12 @@ static const struct mfd_cell vsc7512_devs[] = {
 static void ocelot_core_try_add_regmap(struct device *dev,
 				       const struct resource *res)
 {
+	struct ocelot_ddata *ddata = dev_get_drvdata(dev);
+
 	if (dev_get_regmap(dev, res->name))
 		return;
 
-	ocelot_spi_init_regmap(dev, res);
+	ddata->init_regmap(dev, res);
 }
 
 static void ocelot_core_try_add_regmaps(struct device *dev,
@@ -231,4 +233,3 @@ EXPORT_SYMBOL_NS(ocelot_core_init, "MFD_OCELOT");
 MODULE_DESCRIPTION("Externally Controlled Ocelot Chip Driver");
 MODULE_AUTHOR("Colin Foster <colin.foster@in-advantage.com>");
 MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS("MFD_OCELOT_SPI");
diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
index 1fed9878c3231..a320a613d00e1 100644
--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -181,7 +181,7 @@ static const struct regmap_bus ocelot_spi_regmap_bus = {
 	.read = ocelot_spi_regmap_bus_read,
 };
 
-struct regmap *ocelot_spi_init_regmap(struct device *dev, const struct resource *res)
+static struct regmap *ocelot_spi_init_regmap(struct device *dev, const struct resource *res)
 {
 	struct regmap_config regmap_config;
 
@@ -193,7 +193,6 @@ struct regmap *ocelot_spi_init_regmap(struct device *dev, const struct resource
 
 	return devm_regmap_init(dev, &ocelot_spi_regmap_bus, dev, &regmap_config);
 }
-EXPORT_SYMBOL_NS(ocelot_spi_init_regmap, "MFD_OCELOT_SPI");
 
 static int ocelot_spi_probe(struct spi_device *spi)
 {
@@ -207,6 +206,7 @@ static int ocelot_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, ddata);
+	ddata->init_regmap = ocelot_spi_init_regmap;
 
 	if (spi->max_speed_hz <= 500000) {
 		ddata->spi_padding_bytes = 0;
diff --git a/drivers/mfd/ocelot.h b/drivers/mfd/ocelot.h
index b8bc2f1486e24..4305e7a55cb1a 100644
--- a/drivers/mfd/ocelot.h
+++ b/drivers/mfd/ocelot.h
@@ -12,6 +12,7 @@ struct resource;
 
 /**
  * struct ocelot_ddata - Private data for an external Ocelot chip
+ * @init_regmap:	Bus-specific callback for initializing regmap.
  * @gcb_regmap:		General Configuration Block regmap. Used for
  *			operations like chip reset.
  * @cpuorg_regmap:	CPU Device Origin Block regmap. Used for operations
@@ -24,6 +25,7 @@ struct resource;
  *			data of a SPI read operation.
  */
 struct ocelot_ddata {
+	struct regmap * (*init_regmap)(struct device *dev, const struct resource *res);
 	struct regmap *gcb_regmap;
 	struct regmap *cpuorg_regmap;
 	int spi_padding_bytes;
@@ -33,10 +35,6 @@ struct ocelot_ddata {
 int ocelot_chip_reset(struct device *dev);
 int ocelot_core_init(struct device *dev);
 
-/* SPI-specific routines that won't be necessary for other interfaces */
-struct regmap *ocelot_spi_init_regmap(struct device *dev,
-				      const struct resource *res);
-
 #define OCELOT_SPI_BYTE_ORDER_LE 0x00000000
 #define OCELOT_SPI_BYTE_ORDER_BE 0x81818181
 
-- 
2.49.0


