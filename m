Return-Path: <linux-kernel+bounces-522303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62013A3C877
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8321897CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3B22E3E7;
	Wed, 19 Feb 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k+IUwJl8"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140722CBCB;
	Wed, 19 Feb 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992898; cv=fail; b=mrAQnlayOBA6zn1vpaMK8eLJRDWflelu806CzYeCty5ZekhZBlDwx5wcgtyMBuP5sOxum4/TfZJCWAsKwwlo8QRVHBROU4eRRuvlQSB6PH/cWssgxiLkZcPNsXFNjRVFIZbh/LmyV0oeTn+I1vP/D/aSTtH6OkOTYGQaTEbelPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992898; c=relaxed/simple;
	bh=X6hP1+DG9uLxmHZoai/UHv898OtKt2BJkKNlQDLkXvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tPtOnixf6l2XwS/Y1C2ecBcaSd6Voh5QYszRF69nOv+4u4vNY0h008XfbsVHwUpr3tr1VuGlL0xcU9YhejR1vumN4ZF/tdnScr9R6Fhjl++/LJfjJeWXHXBR04Eowzp4LrsWHF5Q3JrFVSaHoHSR2awvk+rlvYwiPIadohTpao8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k+IUwJl8; arc=fail smtp.client-ip=52.101.66.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/Vw9lNaFAhEuHGOOa1ng2wSPEPttpcYRcu1c7CkUUDZgAWxWvDN7YUJLFRY099FXtirbA1kZfKvZd4lt7Me4Y3l07FTs8uPHgGv3IOKkyvxDdEqH7nHr+Uvb/ka9VTabkL2UgzRtvmWl6c+q2TYypHOATuWSzR1mHF69t1Iaw7nvrJ9vPu10dOLLV4dNeduwv6gonI1tUAdsbUu8t8mtP2CS2ajHvF7ra4TqjbCk1ozzj6Q9OBzvQPdYDnjaaUxMzEBSdxA0xoL9fbqagkI7/neZFELh2zLp5bFj4BhJCSJhyhquzxuEJmyqbP6ctmsLSC/2oMPsjGjP+JUgqJvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Cu5nEdPvlc6G/SzErEt/KAUQdfAzp+FuaJuQwhF4QE=;
 b=r4VyYB6bWtooU5dFHE5MooN7pU5pXpTkbheEAyAqY7qKoBlLyAuMq6e+/UJgU4w33Ux0T2SS1XwIQPxUxadEkDoahKHg5cnq/9ooMWZZUgy5G87nWY4+hFnOypnQcRXMJlbxRT2M5kxNaK8ErCzk6En6Uz0L5VkOSKGKybvQ8oJM6pDkLCAHwk8ErpZGz5VCTlJ7cWH69zLKJn3GOpjPzS7HCRx1aZ8id/M+IhkZatry1v8zpI/vXvh4H4tELP/JVVLYd+7R9/ICXiI+9CYQ1cZKv+tKAU5Zh9qk32ixYxD7kqxXZw07azT/4rrczE/a6gsQx+/Q1YYwoVIAGWM2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Cu5nEdPvlc6G/SzErEt/KAUQdfAzp+FuaJuQwhF4QE=;
 b=k+IUwJl8Im7lQ5+Z5zP/QvTZCVRqv557/h+Ma8FQEveuh5Ml7ul9KYhKSveiOmtQkIvhEgc/3mZHRmOqOwv8Q1607osZOVSb7GxrFdF8fKzslV+xPvJ2i2z4WjWVWklKnWWLf5cyiW04fkpI4PzU//jRvlUGyoBhri3NqtPn9YQkC2huD7xNrpM07b3tfcwhrTQZKX8OxXrJAMWw3kHvcHrcg/MsHEWod59WzwFwUvFdBrGJWHBnopVTkhVUy4XRAHIMyJf+9CwP2EI7EQyknr6yNCrfeJ91lx1HaYOwQ1L7KPUoUCwFfyexOZV9Ryv63VJzofh0ctrx8aFegwMtYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:26 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:26 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 4/8] reset: imx8mp-audiomix: Add prefix for internal macro
Date: Wed, 19 Feb 2025 21:20:58 +0200
Message-Id: <20250219192102.423850-5-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfe70d1-caa6-45a4-2e93-08dd511a9ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n6e1+0e85Qt4lCZH4C4VVWLkTIdBUwGJBnwo64B7P2BlRY1pyZyM9xIHZqNe?=
 =?us-ascii?Q?Phl505VuO/6sCFErM0S9wf6/uXq8you5ChTmHPkbU+smHpUn9trCAiFLcoDD?=
 =?us-ascii?Q?oedk8Q7FmaWChhYPzoqFhzLsuXPsAhn8tTWggtBh2WtoO23vb/7sP04wtR/i?=
 =?us-ascii?Q?A8POBlaNnsU5uI0MFivssYg0+s6jXKqXaJ7vxgpvggljToY7EemjGhYitHZO?=
 =?us-ascii?Q?Cyab6ctVPSNzzXachD8RFhdX/htc6aoMpOP4o7Ps/LcQkv8X+hOAMRipBpdC?=
 =?us-ascii?Q?dswVXUe4E1GfpRmX3AtR0ohjFlgf8L2vL3hOmuJRfdA1QBq29Gu/nXr9dF0U?=
 =?us-ascii?Q?kN1hE31hNdyGUV47GCuD6EBCDP9Ev9inpRZcX4AFauXuxzYKqtZabMHyVVvZ?=
 =?us-ascii?Q?Q9Wj5D6DDktdASHTYKbqYc5aArkXezXes0bBQ3RLI35aNMZZ9wcaJMqRqhNd?=
 =?us-ascii?Q?hIBWFAR3VfRjQppyRQOSYCX2a5up8j6aRDt1Jnytrw+dJYh9TsRzi3TAIIKV?=
 =?us-ascii?Q?Flb1z5aG2LD3RjXdgIvpR7by42Jo7Zyq7S/7U0O3iEEkv0Lu/emQ+F4K2i77?=
 =?us-ascii?Q?QCeiPKSyYT031m1uk0HCb6+JgfSIDATVz5t0s2d6C4FDeUu3tdraT8VwRmRd?=
 =?us-ascii?Q?U3v/72G42ly1acNsmTbpy35RLobtVtfxCnM0kiHYRHysFWr/pI11otiyHH1d?=
 =?us-ascii?Q?eh6pa9azzg3Xg+rGJhrC7R3p6PFULu861Q3z0kQUp0HfVMlgIDvieVJaPZN6?=
 =?us-ascii?Q?5VX0sOO+5lzzhzYteBY3vDCFVM5HC/PWcsR/03H9XnT74eEgt31nhjtzwqCy?=
 =?us-ascii?Q?QxDaRODcdccyWIwjb7BdTYXtkKK928AubA671Xt7FDUYPOuIhxWGip3MWELE?=
 =?us-ascii?Q?qCg4gbUVoCwub7K8dEsJYp/ypOVgfHSUbjFWKuQca8CqrDe8IRJQ9GlSzc+D?=
 =?us-ascii?Q?LFCPyn1onwYFutV4e57jel75Lel3uvCHmYJIgn++1erIT7px92yYlae76OcV?=
 =?us-ascii?Q?p9Nkre5SggQG51xRxwis9Nuted02e6ZDlTtQwrkyxS93AzXqPjMslAG4HSn2?=
 =?us-ascii?Q?rfpKLUnpNaNsDMW1WC8Ana7a8E0ny96XBZBewD8hTDCsLsmbdRFrEvenT37m?=
 =?us-ascii?Q?rWW+OkO/6mkTBQb1mv8sYOhic1CuI8qq5EjxYnM5OIWQiuJ26RNxhVwVhgXZ?=
 =?us-ascii?Q?MtJuCQsxnzedfx+M3XqK3WnEAYnFj3/WPU941vf1FmKeUjlB3R3zFrygj/95?=
 =?us-ascii?Q?7eak6T8ciuDyY5iJqUnm5oiesoSbVSb/JJykrI1a7BbWXSGCOrBQU3YjrohA?=
 =?us-ascii?Q?jx1GJwziayk5tx828rvz51Wdb8UTyeJ+F+ml0ym2PaDZ5e+YRqifFBvTkRev?=
 =?us-ascii?Q?FF419yi+5DUtGN1DRDOdA+bi5ajj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yLlMf0tsqIBV7dv6hkxaX+cc3K3GnPeHD+f5WWZNIdLKOmMNw75dfAl3spn6?=
 =?us-ascii?Q?p005nTMn58Ro5iqkEXn/QUlJFQPyD75arjEAmDGUosBQSgpSHea32woYNfhO?=
 =?us-ascii?Q?bSrtci5yxzv+0CPy9vEfoZcAPui9Pxz6ClR7IH/l1RXSQsiCfRq4RfJtyv5f?=
 =?us-ascii?Q?2XnwLsmFXR5gPkX9LYFCIMa+w73aj+GJhqj0fZYhQzrN2BmVXHfPB2KYy+W8?=
 =?us-ascii?Q?yqSg6bTHbKQI5ZLmYaOXbEJyypSWMA8SFb+AleEcqDKxjDdgheOiTj2ZmTge?=
 =?us-ascii?Q?KCiCnhdMc91CdTIqGvjdd6vmF/K7Sx3qhPlMnlgtTe7KVz1FcqUeQ0n1lk0H?=
 =?us-ascii?Q?mbmVD4Q9u9k3+oobX9mnXAbmdHyRczkNWYUhnUy84YGJCsxmzdDV2O1YTEWD?=
 =?us-ascii?Q?mGXPAkpsFVVah9ew/JHEONf8oCeeO35XqhSe+2JodGsKE/AKeoI34h1FGx8T?=
 =?us-ascii?Q?fsDd/qMhWVZDHtihHgbWkrQaAEmPECX5N4ZzGkiRZSciOWxjO3i50covp9T2?=
 =?us-ascii?Q?00ZWa2qXW/RZZPDumQ4Gmcm3YBxj1IiGHG/dQ/2Gax0ffYi6nIXY+7UWG8la?=
 =?us-ascii?Q?7hshnsh8lPiBA2qb93rUUgiO0z2YNeuzC3LCfvgFUcOYNKvL5pfMRJZzI8Ua?=
 =?us-ascii?Q?4UOv8p2ZY+HzuykercU4mNBFkeDS6ELerVpsVAkYNnD5BDPr/SZ1u3nrj6wG?=
 =?us-ascii?Q?wOnIQ7dqO84ZyQzvpokCa1FmLYJrZleRWZK3O2ZQWdFJyTEDDPRFq83S1QSK?=
 =?us-ascii?Q?kl8VBZqkZiaeM2H7ElbAvH2nsYtA5tAjTJoDnHFizHOju3T2vOgHt8hJGSW6?=
 =?us-ascii?Q?wUM62XblISO+9lvkZeXt+Fnf2aFZagyePoc/ZiQ/0y1rWy3W1s6O28510jAu?=
 =?us-ascii?Q?nyh83M+XQGd0u/KG34YLtGnHeCXavaos2zXOpwrKVELozQFYSoyti2WZJY0f?=
 =?us-ascii?Q?StlAv2YHQmK9orxHHvWO1BDXnU3fqg59LQitsu0axicPhhxMSdEkW0j78eI0?=
 =?us-ascii?Q?iOGvtWisydcknDyfg3ia6BrT/TehqSRuv3Ei+FF4pLbZlkC102AQhhUwFKut?=
 =?us-ascii?Q?+3bTdxiCSHGBD5eFJZiOD9zhV0eddRa2oi2eHgVkFuktEY0QervnmlEskXex?=
 =?us-ascii?Q?6GY11hdewg5FTnz02fnNbvD11TfOKykDf5dQepvhsicAbj4KXoNXFKHjyvDk?=
 =?us-ascii?Q?zwIzxSktesunLI2ulujc+3qBmvWalFbwv+X7QfZ0qU9XWPHHVTowRlHW1TFq?=
 =?us-ascii?Q?in7GUeJH/oocvlObIeLPSy/xa8Eq3C2yD7COz44XCReuSRsQGlZXN7KMW7fy?=
 =?us-ascii?Q?yGBPFg6YU9Z1MJVOhI8nVbS3id0l3dJ+GZcuJ/qjgDRCE8xJL4w5z9HTnODl?=
 =?us-ascii?Q?M8QESUTtKRVQQBZk39ushelzEEU4LbTq4VR+AMQqzV6CssPpeERvNoSEFKpx?=
 =?us-ascii?Q?1AVnYM034nKUyK+GLOzkRUsYoK2GDRJalmNMRry17JH5HN53/Z1oApmSOege?=
 =?us-ascii?Q?ORxVz8f3qokOJOvNGgovBl6U34wq/nGDEi94dZNwgzlm5oC0NqGnCIMgB2U0?=
 =?us-ascii?Q?BlJfZwM19NOB8yx6/eA+MFui5xakYV9SnHy54CXVpoj9e0ykUbDfZstGVxj6?=
 =?us-ascii?Q?MayvUWg21QZFg62KiAdTot7un2ByjMGYrARGqp484gp+QcZHuxq9R916eHat?=
 =?us-ascii?Q?YNMhxA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfe70d1-caa6-45a4-2e93-08dd511a9ae8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:26.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGvC6748OUHTQGasDjh6K8BnOGIEYMxPJHR8i52Py3jodb6D+JAj+ie3yPYiSb5wQtsl26dkgJXEjtzXaBAmwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

This adds IMX8MP_AUDIOMIX_ prefix to internal macros in order to show
that specific macros are related to audiomix.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 6e3f3069f727..1fe21980a66c 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -11,8 +11,8 @@
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
 
-#define EARC			0x200
-#define EARC_RESET_MASK		0x3
+#define IMX8MP_AUDIOMIX_EARC_OFFSET		0x200
+#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		0x3
 
 struct imx8mp_audiomix_reset {
 	struct reset_controller_dev rcdev;
@@ -35,8 +35,8 @@ static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
 
 	mask = BIT(id);
 	spin_lock_irqsave(&priv->lock, flags);
-	reg = readl(reg_addr + EARC);
-	writel(reg & ~mask, reg_addr + EARC);
+	reg = readl(reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
+	writel(reg & ~mask, reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -52,8 +52,8 @@ static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
 
 	mask = BIT(id);
 	spin_lock_irqsave(&priv->lock, flags);
-	reg = readl(reg_addr + EARC);
-	writel(reg | mask, reg_addr + EARC);
+	reg = readl(reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
+	writel(reg | mask, reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -78,7 +78,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 	spin_lock_init(&priv->lock);
 
 	priv->rcdev.owner     = THIS_MODULE;
-	priv->rcdev.nr_resets = fls(EARC_RESET_MASK);
+	priv->rcdev.nr_resets = fls(IMX8MP_AUDIOMIX_EARC_RESET_MASK);
 	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
 	priv->rcdev.of_node   = dev->parent->of_node;
 	priv->rcdev.dev	      = dev;
-- 
2.25.1


