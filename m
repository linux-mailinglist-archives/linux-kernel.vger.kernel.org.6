Return-Path: <linux-kernel+bounces-302709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013D960234
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102E11F226E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7BC10A3E;
	Tue, 27 Aug 2024 06:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HmIPoU60"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13391552E4;
	Tue, 27 Aug 2024 06:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741273; cv=fail; b=ngutGcUEOp0aU0RWArUqcCq+qtZY+bxiN8Obris3qC43JQJMOkv0CaJqOOrQ6XFDbJx1V1jGpHL4TqtUbo006YMp6R/6seW4EW+i2pRLvvXACzgEuEinK2L+2n+77ZkwYUcSxUGb01TiJAQHrkYhX2kyA1TNwcjiJbqRcGG/Tuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741273; c=relaxed/simple;
	bh=l76tGLebT4V+hxetRy1r4xuEMSZM+vtG3hUCm9d2G1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MS57MOXW/loTAhKeTHZrtdj89iOZSYOyed+fAxqy2ge//oRTOUlxLg4mHE19nZe2vnvq9WmTVkL6bYQTkdJ1rTB0wG3Cfvuzrkjb8F4EAP8w6qPV9g8TJXyeoiJVE1FNd6ogggQWL0IAfKUULP12Oz4o/cOwZNNXHLEc9NckiZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HmIPoU60; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6lL+6AbNGZPSgTjk2JSbI+du+qgOTYLBJiMTPbC/YeWUfyovy4n/S/vgC3pmjKPkpRjpPvygG1hZ5i4baBpjJj9lDO+qeDoBHLT5gsGqdQUuySeKuFZILhHsRu4Yaoz5V+thNNP5V8IP9SVbRBgsmqekvfTifpVLeuv+HeMBosP2di/jIyNA7KXsarSmwpsRk21Pm+Zbtmu9OLAE2mRxPluilON2gPrT55dvTYQJbBEW9/pHNWuxOkKM7LETLUMFaKlHwnHIxFag2NniFV3ENbzPHvjFw+I1OlGqSCkIGD/HM5fhZ4K18x5Ef4wapRXYkIyftpEVsFENcQDpRyyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW08k3ioO76vabMjipcCDIyBYrDNnSwhxWFN7k7jy8A=;
 b=vWhz7A9XwKBQ4VComiPWGfjycbD55nXLLjVCWWUcShXQVksROhsIEu+YoPN2/ebJrRD66RElLQ3mJf6+vcT89MH4d8ox4/pJg70eSiXHdFyy7THtOsJpC+deCSHjdQObpkXwBZlt22oOS+hEvRvxbucFObRslQ9l7hx7jc8ICOpxOhl2mqqbvZaNDr7sms+A3421TS/W7DEqAdOlxK6lUMYkDmOhQR8ODHmo5WrGr7j0Ihf1wndTR/UhL2DPXMP+J9NgnecPWThI4dXFca2dZe5I06G2PA3DSwaABDE9hOdMElS+kKi8O0tjWEya1/6DzFGbHB0eZ3hogXq3ZHHZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW08k3ioO76vabMjipcCDIyBYrDNnSwhxWFN7k7jy8A=;
 b=HmIPoU60pRNIfeCrMZnUzpsjVFzSmaqbGiQSV1Nw/dnPSeVesibCkxEEOfZeNEAqyj0wF/xOVxnqhYhfEIwXY57DaWPGiWmy+oFPu14Dm518KVnZcw/VuqFPhOKf8xprAoTth6m3+Ux8qywx6wk+hUBlXgOODDIAchBt6qwGuHxD8h5bIyfaiGir/wa6JNu4JQmIzl9VmwKRNXPao+5Q7E2rbVhqOQXz8dteG9gNJIHZDzUeuCdF92U6CqGzXIyZTcLehyKYdG8azE3e9EwY+oZpeMsHSSipRbFRlCMBIo0LZKT4c3KnW95bVY899xlKzc+cdNd/2UOMzJoSKcym1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:47:49 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:47:49 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com
Subject: [PATCH 2/2] arm64: defconfig: Enable ADP5585 GPIO and PWM drivers
Date: Tue, 27 Aug 2024 14:47:17 +0800
Message-Id: <20240827064717.2383292-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827064717.2383292-1-victor.liu@nxp.com>
References: <20240827064717.2383292-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f71635-fd8b-458e-7cd7-08dcc6642a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOO35zNFjbx6Abjc5J32vrwPN1ohUcZQt1g/M6FwWlGgFarECVvD55A4gbFD?=
 =?us-ascii?Q?dG1ArsFWq05U91tDfovCDbANb9sZtNP2l1+cTn9f0Q5uP5uS1AVJW6XE8xAk?=
 =?us-ascii?Q?5vqQ2WRQQ4+wlG4FFn4C0hRGUeozK8kcGsDQ+Ck9mU15EoutDy6K9lDQI/Le?=
 =?us-ascii?Q?QswXeky3saqJo6NjCEshTYsn2dK0R1ALxhOrbkjw3qJEI34Coq+dunmA3aqb?=
 =?us-ascii?Q?tFmrmCrb+dJ3siqWUnzxc0V5C/tMueZXWoOz3gBDHZedjfzwj2WtyMcNJ03v?=
 =?us-ascii?Q?OR1Gye86f1eu7hwPktCikqdkYXITduUHol3vm8b68j5lUUgnVX3z3+imArnQ?=
 =?us-ascii?Q?L6BU3Q3Am2pFxFFB8gfEhDZR10Qx9W1TdRkBPCb5p7q8zbNT01ckVa/TQVnJ?=
 =?us-ascii?Q?FI61hpQSgmI9wWa9FtgNVAazhBzJqBxMyWud2rvB99KJIrjCxV2RMhPfBGWQ?=
 =?us-ascii?Q?n505XS9j3fqt7QGdyYJLmjeZZZ0CFJ/141Evc5YopVzp51YSOmZjCaheQ7Y0?=
 =?us-ascii?Q?ZVGYdyDFa36y0FT5ktRGlKFzpNRpUJef0n2/Lpx2SY/dS7QIjzJ8ZfAmINvY?=
 =?us-ascii?Q?kwbnqDFc6ldiN14aWszv486hb6sl8prks5WQyj+g1fsw/CzZApuJAxMkL1WU?=
 =?us-ascii?Q?o1I1N82hMc58I3CyLiXfg+MYHE277P8lYtQVuDVFZc7XoOuIgCionDa77oy+?=
 =?us-ascii?Q?TY4xWIhTgOgbG9bdTq3Y4Rfa6EXHSfHaVKaaikFH6YLAQW/UbABsCp1HTl/J?=
 =?us-ascii?Q?gqra4KkGk+oT/QcFfyClaV6wZQInTF8ShXICIyqIpqHFCyIlwLty2H1bizr3?=
 =?us-ascii?Q?YuG9irPkUhg+xOL6KQl1NidcqtY37sbiEWn951/6qf2Gm7z15J3YA9MK7XTm?=
 =?us-ascii?Q?rWqn1BadsruNpFHC81t57nH9CQzzJHODLjYMM3Ec7j9tUd+fjrT+Sn9UMPD+?=
 =?us-ascii?Q?hY3Ci+qoOya8BOGQ2YMgVoXArJpGUi1V9zD2HvPUcJOWXk5+XTFAVNpmiX6S?=
 =?us-ascii?Q?7maVU/Vjeqe/6Cz6fo9vSxyjL75Jl+rKMrfSHkB6fKQW1EKJgrBon/0K2WNH?=
 =?us-ascii?Q?5BegOPqtmlYdErJRFb8V3Xgh64pLQbOcBF9cg6wva5XScvaKW6wlLbdWbW2c?=
 =?us-ascii?Q?UcEMqQim6cbt7untv7VPYRp+V9BIRpaSg9Nf9xQon91RbR8VnZJI8UA1ewge?=
 =?us-ascii?Q?ntsDBBrYJskaeeunMwO64r+9F90wAucCcoUDcyY/Y1NehtUbg+Ajg7nmhjoL?=
 =?us-ascii?Q?gAE4uh5mG6wzONyskDSxO65zmna41oik8xBZpngLe6bWaouOswJMaoCqOv0i?=
 =?us-ascii?Q?C7kso1bmkA/NpjIXoovoCc/KPfhnairn9uNcvZ/ILjxAn5e8bioQKz1SAqmU?=
 =?us-ascii?Q?ejLG6/YwY5hJ5XjpLgMwq1ivvJ1hdIEE07C/o3sHZPZLyHhX/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LjjIxu+9pWDq7nUOemmvfmssdqdrXg9nHCS5DisTNTsXywPk8gb/zjmL/5li?=
 =?us-ascii?Q?yOqpqViCQ0i6KgxmkSxfGiRwwWMv0tr3mPh/VpXQlY9DKdE+TiYy6/g2jp7E?=
 =?us-ascii?Q?ZPBLzspa9BjLgDTtbNAtVRdm+QFV5czya0qPQxklSbpwKVWiMbW7pMVHShTN?=
 =?us-ascii?Q?VYZaPN0OnmQcgXRCt8W3Rqz01Vf0WCVFhjQ4AKBIF38/jhMrOCdyK6zweYBu?=
 =?us-ascii?Q?LuU/5crBQ2OKdb1UdobqUTOQuHgMHK/X5DkbaESGzVeE4VZ2sFnhoFCpjier?=
 =?us-ascii?Q?bP8Y3j+2uW5a2JPNCzCzdzXooo5Yt+Owqu8k44YyW8PRspz7HiXD2CV9oWhq?=
 =?us-ascii?Q?pfiZS3ibInql1qe+BEILLOtYCrvdQJJYzasatxrz+xC6XTDKaGR5Iu0pGrNf?=
 =?us-ascii?Q?aLEgpysxcobOnS9TQ9mEY9EdavrcFzLYWQ5V9ckq+G0lQSJJmA17G6Y0OLSI?=
 =?us-ascii?Q?BRaENhg/klSLCC/y7WFp4MXvyCxUHdFOczr6bFhvhD6SdUgqbMygWNFmeSIW?=
 =?us-ascii?Q?ha9Nhzqu0Pyt4/YGcrdzWGNKy7Ql5nhmimQZ9FgdUjhaEMOMyxV2lTJmBZrQ?=
 =?us-ascii?Q?TiffrFcVsd1ooSgalRkMeJOFb+ysJgzPE3Ituy3EuurM18BiT2zRYP9oSBdt?=
 =?us-ascii?Q?45Fg1ziTL8hPs98GqH7ifEvqj6DLkYTn78C+9r3N8UozIfWtvtVj8fu4lrnR?=
 =?us-ascii?Q?+/bXgRpNrY4G+zOCuB2te6YvNqmG+eJ6PePI953Vh07wopQLic0X/7605sUF?=
 =?us-ascii?Q?ruvmWuxaOGsrHVGpMphl0gwOPf52zBjxkr+GmtpDXtMydo41Am90msYMARAX?=
 =?us-ascii?Q?urnr4+whq4znC96f9D1h/lUw3vxBXkwHTU/U5Z7XOlRKQoIPuLmZhldGtqcT?=
 =?us-ascii?Q?KHYnssSgsl8KxcT93xCgxGi/i0nebd/7siDvP75MlQjduUBDLkYnZmgSNCEV?=
 =?us-ascii?Q?7m4aKgQkGZuWsR2SN0cZRnwKy79O7WHUtYMIxP4Ai3zlOXtpMlnQvISj+bSG?=
 =?us-ascii?Q?zjwwNAt6cP+QUGZx23XO6Lhlr65Z1HHoosg2paOuk1j2Pt6ji5To4V0CZ0w7?=
 =?us-ascii?Q?9/4AH+N7kLjdbw15CjAfaAcE0kexUJrjAZn2mz2BclJV0Ffxl7bEmHotma5R?=
 =?us-ascii?Q?HcAdmahcC9JPhiyFFjMJQGHdDgPNHB4/SUm5mU+kCi3aSYUEY3refn4O7oba?=
 =?us-ascii?Q?ux6f9t+HwLcltnu3pZTK/uZ5N90Fk0vg1eEPqTZBEwVP4JA2eAqIqYnOo9vc?=
 =?us-ascii?Q?OTdtWDBtB80YcNhHzwEU7actzI+HyU/WiAsOdvsFAliA+SY0HytbtEQuBKIQ?=
 =?us-ascii?Q?zo/s3gKshHgOeCEixDxRgW1fomFs7uoh/01mdkze07NvBGBp4VCRL+3j5+9f?=
 =?us-ascii?Q?87l37R7r+DOG0Vek8u5lJREULC69f41//grmf+ZQB3RKnIppRfc17iU7Ot5Q?=
 =?us-ascii?Q?BO+mjR1GkMjRuVsTS7yaYJ9jjxhYXs0Y+pFopX/Eu9N/tqMW2KH/pY/CjeAt?=
 =?us-ascii?Q?j4y3ZBkwoEkCjEoQDCu4fE98lVSvGY9TF2PtQHJPCfy0ikj12tzkov90En3r?=
 =?us-ascii?Q?BbHGo+AGF/hUBZzDDk7uCOU9o8/+k8sgkS5qTCUt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f71635-fd8b-458e-7cd7-08dcc6642a3b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:47:49.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lewu0+R1EP6sBBukwj+yNmQM+jyqoa951ma0VRYMg5vkxoYcn7ODpIhWV/H6bBqWl028pJQuUO4MTSvaS+xaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559

ADP5585 is found on i.MX93 11x11 EVK base board as a GPIO expander
and a PWM controller.  Build ADP5585 GPIO and PWM drivers as modules.
While at it, build ADP5585 MFD driver as a module because the GPIO
and PWM drivers depend on it.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
This patch is based on next-20240826.

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 81ca46e3ab4b..4904bfa73f85 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -657,6 +657,7 @@ CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
+CONFIG_GPIO_ADP5585=m
 CONFIG_GPIO_BD9571MWV=m
 CONFIG_GPIO_MAX77620=y
 CONFIG_GPIO_SL28CPLD=m
@@ -738,6 +739,7 @@ CONFIG_UNIPHIER_WATCHDOG=y
 CONFIG_PM8916_WATCHDOG=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM7038_WDT=m
+CONFIG_MFD_ADP5585=m
 CONFIG_MFD_ALTERA_SYSMGR=y
 CONFIG_MFD_BD9571MWV=y
 CONFIG_MFD_AXP20X_I2C=y
@@ -1489,6 +1491,7 @@ CONFIG_IIO_ST_MAGN_3AXIS=m
 CONFIG_IIO_CROS_EC_BARO=m
 CONFIG_MPL3115=m
 CONFIG_PWM=y
+CONFIG_PWM_ADP5585=m
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_BRCMSTB=m
 CONFIG_PWM_CROS_EC=m
-- 
2.34.1


