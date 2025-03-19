Return-Path: <linux-kernel+bounces-568015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C731AA68D02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854688833D2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF1257426;
	Wed, 19 Mar 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="FPvouaNZ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF5256C98;
	Wed, 19 Mar 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387484; cv=fail; b=AU4cy5srfABvqinLgdwcrnvoGq2T5DaABUk1nIgj5sj/6rpgJ7anC2KtnCKcEn0va0roovfjIq74z9BBgVXBNz5ilP6YijWP+iHzEaLZ7yDbCSZ6ntUCXHoOoSKUq+KjDmbiHYoEU2r3lF6oM4PLgxqL4OLaVxEACCPGlENvDz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387484; c=relaxed/simple;
	bh=xkGk3s/1cj8+GgOktE8ZAVfPJfnRduhTIp5rChtgFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAFQzkju4XhWY8h1Tu4W0YQoZ4Ru4StOPrrksRR2vRLiwffHDUesReLJUI1VbYN4L5k34VINKEkxwo8Gvn4eSeKH1UvuZ4xYrx3olWIcxdSLB/QTIpCYgEDMtkR0J/e+FLt+mHIvBqd5Hodi0TB/hFJYU2OAk3u0zcSMSKbFCIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=FPvouaNZ; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvtAMxZIf2prtMkWil0jzvNSrJviAyi2IZDiz3ZbMIYrpUC5vvczHL3YlYiZjwjiizcbAJeEz/OIVRLLmEN2obCbBJj3D9zRdMoOPAQAik/O9eWhiEaQ6Hv8UibRSfKhf9GwUABdvJ96431oOSyrqUHzdeZrnQAwItX5QzEdLS8k+0ZtZtdo0j46LzWcSjkQ1swap9RksHzJB+kEzc1jWCjznK5i+JEqCqFTyRQ4/0IRqwfaYH1AUB01XRJihFsZ/FqKCLXUa7JCuZ6T8++M+5S2osdU05gXbYZIIQo13h3PL3Fn6SWt8JMtCZ2NPZp9Bs5KCchbi2zoWxg7aeGIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aVVTOPy3yWZfDCknm/42Whe04cgR2oPyz1O0vSaB4o=;
 b=LEf5PfOLSws0mMr8lUr1x3OyzPeNkbcbxgHQomiSA/wwHS6/jpRsEkhofMUyCGJuGVRgXm3C9HiaKy5cW3YyH58aJp0hGhu15TjsHpy/cm80ft1ngGvupq4gBFRaQPfeR82L7V1L4wK1aThhWiMSKht4spKrrtKMMfXHnUoPDMosbb/G08L0wTlKmz34G0q7/o18YzGpcKlIa8dLx/NOT/HdbMM2NiIHNS4Ia1fxyV7l/M7svHqrpe7dZyzXy8mbpEo9mzXBbBRWPPc/kmXepPcbE5uEq36NO5q25aiVIhfURPPpQbyNwKlhIEatMdU/pqXJjQQkR9Cn4/ZvrosBjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aVVTOPy3yWZfDCknm/42Whe04cgR2oPyz1O0vSaB4o=;
 b=FPvouaNZcqPFJn+Z/v8ctOerUna9icDKEHIBj8GYN4zsES1/j7HwEznJ5SJL7Q7prwEv5q6x+IQZHzhQtiyEUWUgo67kSF2sgnrJHWyo0Pb/rJZmS/6ktC7VuMr2RjyAM5f5c/n04tFOLey3UoSTY7DgX6jpdNd19RdzYMTWJNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:13 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 4/8] mfd: ocelot: lift chip reset logic to ocelot-core.c
Date: Wed, 19 Mar 2025 13:30:54 +0100
Message-ID: <20250319123058.452202-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0059.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::26) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e2be62-3a07-4e47-0df3-08dd66e1ef4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rvrTt4D+tib5Wx8MHvWiLeB8Xz9tdXKFTbl6K7UHeViH1hMyt1J45RobEV9D?=
 =?us-ascii?Q?Je3aTE3uY6qqfRpY70EhRfxOswJzK9c7OZOXzAyFZ3YYe75k4kmz4pZNP5LZ?=
 =?us-ascii?Q?jjQSGwItnuhRBl69FUpelRnGFuPW+2fXIP/8gdVgmY1xDvqK2A6Zih+Aak21?=
 =?us-ascii?Q?ozTch6QAkOnzHsqrBty/hOtHodoPVvGMivn8ZSgghJMkgdJYPW8nsEnqK/z6?=
 =?us-ascii?Q?AsmlFJDVlu4PZj95D3XOJra9E1fMmF4RQJL+KWGxjzaOJi1O57ANMkGUapph?=
 =?us-ascii?Q?vSPl3H+lEz1t0gdWJjLHJkuvvTVWfYxRF/gLUJIxhf6HRqVFMnZPtWCsmxWP?=
 =?us-ascii?Q?19ua7LkXfLg2ZAoiQitvypdKFrceJ3Wos3k/VYZpCYWY/DCuIZoB2mOuosic?=
 =?us-ascii?Q?EnVui1V0q5KjiAqb3eYodP/cV6CI6SpahIi72DbH4fSR3eT90PLpDUVw7NTC?=
 =?us-ascii?Q?grLkij4+5kZAn549bX8nXXIJNjvf7662WiGPLGa+UjLqWKTWymHWkVBbZWh0?=
 =?us-ascii?Q?61VXKWFrvnrlI2wMugjfFHhYQvDn55f5VXh7KNGo9lRf2M+cjj/5iF7715W0?=
 =?us-ascii?Q?NHCuEFvbFjG+gIR56+v57nGmJ20TE8thF6j3zW7URGX8recxUYCirVjK2ygK?=
 =?us-ascii?Q?2UGhhmgYmPPG9nadBAeZlbxXD3A9RgEBxOozWs34TfrGxEN0wlvnoaM7TTH2?=
 =?us-ascii?Q?YF4wtc94R8icRebJlsXNmYlsbVkaD5Mxfcaqzhged7sdBfg681M5vBlJE/Aa?=
 =?us-ascii?Q?W0eCW1j0hHAxFKV31qG2DMCpGuXeRPZPHgaUMeKwl6qVWWXgy63I+p2UNEAp?=
 =?us-ascii?Q?jVL5+VqFtOJpab8wFISm0cWPnWmiVQ1Znqv+DIKbysIAPy7okSBYhJq/uvU8?=
 =?us-ascii?Q?0a8fEat8Jth78tvsikiPSnOThkRCPU/YyQchqgPmfRt9egVBJA2JTmrVjdYs?=
 =?us-ascii?Q?ghHb8fMJ2Llt0yko/qRZW3V7eLh8MGiKXgKCAIiB8VIh8YB3qNvw0TbIbxHT?=
 =?us-ascii?Q?wKD7rVCsdkuGx15nXJe6PYj0dzbqRIfnzeqf7MFDldqla3w/JVS4ouXZ9xRx?=
 =?us-ascii?Q?YvspQwf85Jz10LL95H2CuQB0WxYiQXtW7HKWwAYx5ppuvldgLKoaPl1URC8b?=
 =?us-ascii?Q?HJT1AYidCQQXweilUe+F/ZYGQhKHoz2rpXGoBUbzeEymLC6JJEPMi5yM64un?=
 =?us-ascii?Q?IcM2V7UP33bqFzWEZZl8UrEfuszLQdSnd2fHGKzBFNgaNK6mNiFM41C+74lS?=
 =?us-ascii?Q?hEZZtI5CRsUPMAr9LP3UO/yCMALWRstyKHwdcOtP2K2SMetGPuOKdLNkfbtg?=
 =?us-ascii?Q?yGCOgD7oE06xJ3WKaZP0nf1TOIWOMMRhdrsXAiKiYM/wsWgCKiM/bfVK3C/5?=
 =?us-ascii?Q?gAKnDx22La0MeprkYBMFEslCaFQ0mEkwKxdGoMw40SuuQFK5us1YqaiTfLSA?=
 =?us-ascii?Q?PPyTlhymeV7FzOrQEnUOJo4DcMZfsXen?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAEj6rks8/QXaeJryrrnmd+RKKN8pLeT/JipxtB+AEG3npc1XdaCXfJkrgb6?=
 =?us-ascii?Q?SZlku3tAIdfetibRJVpy1MVnQL/wzQ6lSRpPZFPYBreNsYE8bDsWJlxFMQc3?=
 =?us-ascii?Q?DmoVywXi+Qy9nhJ86Cof/9GvUokZ9UBs0pWzVTUFJeQnjkRUVMvEbWQ7tMKQ?=
 =?us-ascii?Q?ba/sJN1XPJL6bujCp7veRO1k9nIwAOPzPOR+O/YJOf8sbVKOiCsJmD4AOKhp?=
 =?us-ascii?Q?3hJaBODCWKmvNovi00+Zdt1BedXxE9UbVODhBwdj2dxJhSdi3GVOeAicEky7?=
 =?us-ascii?Q?57lgBn/umisczwXjuevkAQSfjXZFCjbZ8WA77JivAP8LYs3qxn6cY89Ys3zM?=
 =?us-ascii?Q?4xpJxGUCjNO5Fmlk1HN+Hogpz2rx+v1DrYT1bii/CzS7pzc9Nk3Mb1Z0SeUP?=
 =?us-ascii?Q?f5QWrHXYiAuc9CI2vVDo5izwTiidvsY9pNRATvuqHqjRro8jssVRArSPOBpF?=
 =?us-ascii?Q?MwpiQVP2xBD1ckTEYkBOZvULkI2Z7qLPUccp2aehZlyltYlPUIzLmvKVVeZC?=
 =?us-ascii?Q?f2XJKJkqR3ypGmE2NedK16IyEpOzAZri+K7cClzkPTa+SbumGpdFXGd59VEF?=
 =?us-ascii?Q?YSpsMWDV7/Q4PVhtVDeeZ/xPHKpb0CXHkMhd2YWUJPn/joEOv4pZyfNaVxT3?=
 =?us-ascii?Q?N6X+pvVE5a/S4CtgT3+76pyJ5jYgFUN6zahV6OYeEJcGEiLd9QFAluPmFBTv?=
 =?us-ascii?Q?LQXNyXk4eT8fO2LWRUGpLbHKIVQaHSebUpp6JAgvbPR+9tKOoh0QG3J/yvjf?=
 =?us-ascii?Q?yhT+B85G/1jq9l7ziaoX+ClwPoGm+Z9MQrkVT6qz4cJz022vXLxkTsLfvzUK?=
 =?us-ascii?Q?2vNJURGxxAFq0oXAVTAr5+CbZXdKe/v/5UsH0siDRe4CNLNKcHfKy0bwuaPf?=
 =?us-ascii?Q?IP8yxmr0mmkDXi2WwYS0fqAx/9MYdHFr+PDKAmfUImpTOQAXh1C8tIojrz94?=
 =?us-ascii?Q?4IrKMnFNsPORrsIhF9SzagvFWWQTUP7EjTeH7NYh0xmMaKeK0J2TcisVHmqv?=
 =?us-ascii?Q?2YlKPA1HSeGzVR1MeA6VuyIs6DaE8mOQqW1tOEqind6AmesbdjvRpON1bll2?=
 =?us-ascii?Q?4VZwuhB9gEc92Dy9h7tH/MnBCAQO8A+s7/wvKEiefOlz7kq/cC3kb9LzLC1c?=
 =?us-ascii?Q?LEv0hHnH7p9NPJBe6+CPSwhU5qsbAaqil5etg6+Y6uzMwpx+x5QUw6UWblFy?=
 =?us-ascii?Q?VguO4FFRp8l1yO4lkj9R8H7nc5/M7GXN2FlWCY7yj1+Ddf8KLlNe1wrddP8m?=
 =?us-ascii?Q?euF+CEIE2imDPBbAykJDnAekc2itkSIIy9Wzk8jA9+76D9yOVoR9ak/R2zhN?=
 =?us-ascii?Q?en2eRukrVjftvnvlYufu2lE0DjC/SPOR4UIl0X5Up7faf08WwLhh8wQFhkxl?=
 =?us-ascii?Q?ZtSjB0JoOF5Q9hXDzq3VVpWKeW9NvvJNqM0nIWxakHWSSR7fy6uyd/BvO3i/?=
 =?us-ascii?Q?mX1Trwn/dv1G+uo15upDFSPzHThsIp/KN0/DhQSH5LhGP4rjZmlkSzzGoZCl?=
 =?us-ascii?Q?w+8yPLIysdtpmFxWmn62j9beEv6Ee41uGr91tHpBHfs0qDuBUTX2VjLqOYxl?=
 =?us-ascii?Q?sSLaJSyn8SmJf29eGjxA7dmMFYtiiQSWKth0O+AjkCOwgvxgnAvc7NChtPd6?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e2be62-3a07-4e47-0df3-08dd66e1ef4b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:12.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec+7K34hLU8zfLd8hOXX9KL99bK1ciqniXK4RomsPcsc9ajY2e9HBhbPGxSKeUNweaQbPmUfaWa8fHjvQ/hBCKShKG6//NjsukT1GdWxZj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

As further preparation for implementing support for mdio management,
lift the initialization of the ->gcb_regmap, the initial (and
optional) bus initialization callback, and the call of
ocelot_chip_reset() to ocelot_core_init().

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/ocelot-core.c | 28 +++++++++++++++++++++++++++-
 drivers/mfd/ocelot-spi.c  | 33 +--------------------------------
 2 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
index 9caab83138e59..c0ab5492c83f9 100644
--- a/drivers/mfd/ocelot-core.c
+++ b/drivers/mfd/ocelot-core.c
@@ -28,6 +28,9 @@
 
 #include "ocelot.h"
 
+#define VSC7512_CHIP_REGS_RES_START	0x71070000
+#define VSC7512_CHIP_REGS_RES_SIZE	0x14
+
 #define REG_GCB_SOFT_RST		0x0008
 
 #define BIT_SOFT_CHIP_RST		BIT(0)
@@ -123,6 +126,11 @@ int ocelot_chip_reset(struct device *dev)
 }
 EXPORT_SYMBOL_NS(ocelot_chip_reset, "MFD_OCELOT");
 
+static const struct resource vsc7512_gcb_resource =
+	DEFINE_RES_REG_NAMED(VSC7512_CHIP_REGS_RES_START,
+			     VSC7512_CHIP_REGS_RES_SIZE,
+			     "devcpu_gcb_chip_regs");
+
 static const struct resource vsc7512_miim0_resources[] = {
 	DEFINE_RES_REG_NAMED(VSC7512_MIIM0_RES_START, VSC7512_MIIM_RES_SIZE, "gcb_miim0"),
 	DEFINE_RES_REG_NAMED(VSC7512_PHY_RES_START, VSC7512_PHY_RES_SIZE, "gcb_phy"),
@@ -227,7 +235,25 @@ static void ocelot_core_try_add_regmaps(struct device *dev,
 
 int ocelot_core_init(struct device *dev)
 {
-	int i, ndevs;
+	struct ocelot_ddata *ddata = dev_get_drvdata(dev);
+	struct regmap *r;
+	int i, ndevs, err;
+
+	r = ddata->init_regmap(dev, &vsc7512_gcb_resource);
+	if (IS_ERR(r))
+		return PTR_ERR(r);
+
+	ddata->gcb_regmap = r;
+
+	if (ddata->init_bus) {
+		err = ddata->init_bus(dev);
+		if (err)
+			return dev_err_probe(dev, err, "Error initializing bus\n");
+	}
+
+	err = ocelot_chip_reset(dev);
+	if (err)
+		return dev_err_probe(dev, err, "Error resetting device\n");
 
 	ndevs = ARRAY_SIZE(vsc7512_devs);
 
diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
index 37828dd3ee95e..1844b8451e8e7 100644
--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -38,9 +38,6 @@
 #define VSC7512_DEVCPU_ORG_RES_START	0x71000000
 #define VSC7512_DEVCPU_ORG_RES_SIZE	0x38
 
-#define VSC7512_CHIP_REGS_RES_START	0x71070000
-#define VSC7512_CHIP_REGS_RES_SIZE	0x14
-
 #define OCELOT_SPI_BYTE_ORDER_LE 0x00000000
 #define OCELOT_SPI_BYTE_ORDER_BE 0x81818181
 
@@ -55,11 +52,6 @@ static const struct resource vsc7512_dev_cpuorg_resource =
 			     VSC7512_DEVCPU_ORG_RES_SIZE,
 			     "devcpu_org");
 
-static const struct resource vsc7512_gcb_resource =
-	DEFINE_RES_REG_NAMED(VSC7512_CHIP_REGS_RES_START,
-			     VSC7512_CHIP_REGS_RES_SIZE,
-			     "devcpu_gcb_chip_regs");
-
 static int ocelot_spi_initialize(struct device *dev)
 {
 	struct ocelot_ddata *ddata = dev_get_drvdata(dev);
@@ -246,30 +238,7 @@ static int ocelot_spi_probe(struct spi_device *spi)
 
 	ddata->cpuorg_regmap = r;
 
-	r = ocelot_spi_init_regmap(dev, &vsc7512_gcb_resource);
-	if (IS_ERR(r))
-		return PTR_ERR(r);
-
-	ddata->gcb_regmap = r;
-
-	/*
-	 * The chip must be set up for SPI before it gets initialized and reset.
-	 * This must be done before calling init, and after a chip reset is
-	 * performed.
-	 */
-	err = ocelot_spi_initialize(dev);
-	if (err)
-		return dev_err_probe(dev, err, "Error initializing SPI bus\n");
-
-	err = ocelot_chip_reset(dev);
-	if (err)
-		return dev_err_probe(dev, err, "Error resetting device\n");
-
-	err = ocelot_core_init(dev);
-	if (err)
-		return dev_err_probe(dev, err, "Error initializing Ocelot core\n");
-
-	return 0;
+	return ocelot_core_init(dev);
 }
 
 static const struct spi_device_id ocelot_spi_ids[] = {
-- 
2.49.0


