Return-Path: <linux-kernel+bounces-216656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FB90A2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0632A1F22E86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809917CA1D;
	Mon, 17 Jun 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZOmlxAcD"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C310A24;
	Mon, 17 Jun 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593374; cv=fail; b=Leo5WmgJUvRnSvIZ6ZvVlc8wC9j3TAea9saS7hF48UfHgDrZTR/Q8n9JTxuEYpth45uCfFZBxwqOiyV8RHEMU7pSj0s36IypXWYqskp49fOXv9DqJbT0egKXsPYFvhu0O0vhDPCHZfdrRlcCVZOFOGIeuhdX/0SyMNPTVdHVuDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593374; c=relaxed/simple;
	bh=jVoefRP+KTTfFHYmL8sa91MJicL29Ex2n9MkjVsJaq8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QcrmhXKO0uBtFSoTw6tKBXDKShJR46b4gmO3usQHZOgxO9oNK2hgX8fm4KBoxBklfapSFXLjCiOQEQ4CAwhT4pCO4nTBL/y55PsXL2D/466cCJhlOlvYimd+U4HYZ2O0hnwWkusO+OdJE6CfbuAC5lBI3guVFKJZmCXp22yIAyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZOmlxAcD; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFknKcPzCQxxe4U2ifx6AsBudHjI6DJymp0/pJ6qzxX9GX/TymRBKP5opygHatqsxQRa71FGakTfZchGyCe+T8/kx2Is+oZG5MX6RNI6Npv/wmAcm7DFW5JHe8o1g0hrKiL+PQDTa1R9EKhrHCZwHN3xbO6geiPnvaGylflI47l80gSGY2vf19zGptKN5zwtCbPpcc7az8B+NFIwzr7Dn7Qih2OlG3dAvEKOc2blmIIzcop6i46zM0O+aKNzEjWp/ONmcvZO/d0/ZpR//f8n1GVINYWteW711el1CLKKYWvf+MEw9pudwkfXO/2uRzXIzb7WQfZVxHSvoE1mM/uUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUhpDWTa6QkZFYrV+ZmGSDaG5QEvegGv1cx38QBGTTY=;
 b=EHFLTX1amzemN4e3/uACFwRgPAUQW1HppLY46kcJZFqqTlrXidWq2L2mdueasB7FmdJTQWfMvumwpIR4kMahHUSa8xtlrup15Wa+iTrFylVHIqN9+dg3OMuxQ7oqBUxHwC5QqDvFlrcBCqwuNXlQieFo6YyhqalWMsXJhQSqNF4XeSzbSPFy7ZP8dJSsTvvjDEwhEP3oZagUUJdBuIiBPZEuoUciBhz/T7xz/DSpRSrRPIXf5BXHfvZky39jJRpEXfAPCNpZxnO95+C6UB/ds1P3Biq9BNRkCxVONvZw81d/cliQ0wi9y8sPsg3Hqj92w+uYPHhXmlO896FTySaG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUhpDWTa6QkZFYrV+ZmGSDaG5QEvegGv1cx38QBGTTY=;
 b=ZOmlxAcDtRkw5hB4ahLomBv0gX1VvIk7WeJXecaNkGnTvKXSy7cVHyDOoOAQglV6TYLK2HEyYOF5e1IFbz5EBG1xoXuz/hoQPSi0VrJjReavmTh5LNQcivKCBV+EtLtZxGrY6hH2p+PCoZ66TtBxRcOafMJ8msvkr/PWqpVHFDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 03:02:46 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 03:02:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V3 1/2] dt-bindings: arm: fsl: add i.MX93 9x9 QSB board
Date: Mon, 17 Jun 2024 11:11:44 +0800
Message-Id: <20240617031145.20057-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1e4a38-668c-41e0-4d4f-08dc8e79f6df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WoNQ+TpdLBNaMX0ivQlW439vuSYnQ1Wdn6zemW+/OeDxHmaPDb1uFtxPtFvH?=
 =?us-ascii?Q?N7GEP7nMERttUWVJYPVPMDbeww187vwdQkFzaLE6QpxD38BVGEWuyXboDJAf?=
 =?us-ascii?Q?XLHYrXdtNs4B8ha0vc7hnj9z/sAsOaHB/Za8PiVmon22Jql71aWPX+7XkQ4i?=
 =?us-ascii?Q?F4g9wpG/id/bVOJFb/XVSE6kd6d4KblokUa0hpTgN6u6wXz/Xfkmnu2XKR+h?=
 =?us-ascii?Q?ikwFyCPuvaxYrqHklZX4cFr1pvEK9YkubKE+nINr26UA2JbVLylyI7wN7mGY?=
 =?us-ascii?Q?pN3mNVvDB+5qfA+SKo/E2kv8n0xL35f1OmbRy9zM3lSdYx5+v/n9z+Z8+vpE?=
 =?us-ascii?Q?I69QgxLwMHq6jgHkix9ostuWKujSAmU5W8KEGY0IJ+al6Qlw9KsQ1nHgTmEE?=
 =?us-ascii?Q?TF4hYcrriQUUenp0JwbUCAIeHNhasBJt8GFepuAJutLsZwAwCo+Ynn4h721o?=
 =?us-ascii?Q?yYOyZvonwoQxjkmdbtnihojqWEJXYCxAPYsh1FwpzENmYWy2WSwcT8j1SC60?=
 =?us-ascii?Q?dsfigMqTI8eGSIt70bOSi4VaLHsEk4T8vC0q4gpYxHfnzf9a09n0bw03gQEl?=
 =?us-ascii?Q?IjwZ7uztaSM2JI78gDf7oJNMagttoiaAILkL3JtDWfR5QzoHlzoGStinXMzQ?=
 =?us-ascii?Q?gGWIrEQHQpWOub6Qv1Qr7Pud3rAHvcNIzAPw0970lD4cKK7Ug4wXAQYvkOjf?=
 =?us-ascii?Q?qao/j4dFxYpLdhNWXBypHdE7+tf+/rl15YZvEfD0YBL5oiXKaa2zsNClwPGZ?=
 =?us-ascii?Q?GE1waWzie9wWc8Xc2TizqtgmFXbuqHzuHJBvB3nkSNmvYxUaH7musP3mCKgS?=
 =?us-ascii?Q?pkn+bwk6yegy9BbuymlCblN6bD59YJvfK2UiTqCFni1YhZ6ndiYhj8bdCbTG?=
 =?us-ascii?Q?RywPLtAy1GP2lxY+fhyf4Apa6gXIpeGPjZOZBG3/2fWwv/9OQyIzQkdIMMqg?=
 =?us-ascii?Q?h5x1sVHW879UpSy5T7d2/byH6sVOQFFiWPE7zQUvu9XTwdKfghRwL0u1nXs1?=
 =?us-ascii?Q?nUrsGkL3LehY9YFXn/a7uvn1Uh9PC1E9BnvlB2Ayqv3n7so9Hjk9VSehuwhX?=
 =?us-ascii?Q?BhFs6lOLJcMNRzDv2tQgIXBZ2dcdK6d7yzP+Fn3K5/ck5rlOL7SUMtqjeBY3?=
 =?us-ascii?Q?TSd3/O7Nuc7D/L2ky+EbsKxE7yn8QP4ceNsX8DUFhEvyh2lyO4OTo0ptOwEK?=
 =?us-ascii?Q?LRPiVo14GshE/ASGgi0y7FrCuWHslnBhEK2mkmcYnBzRvu7uJHjRWv1R5Jl+?=
 =?us-ascii?Q?x6RLo4nbpPa/2r7h7hB90UIRwmmg0W82CYnFJoypOGxxIchOJiT/yPrRE2/m?=
 =?us-ascii?Q?zfjw6qKgQHN/4CCd5l2UnokgJKsY8mdUZ+my077I79qgEy0dc9hmesbJYvmR?=
 =?us-ascii?Q?MPhMAY0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RpLyf8zYJaPRlR6g5mC8vY+ZQW742v3x1S6qrWjbBXzFwVIsFKe9cGSEVyot?=
 =?us-ascii?Q?eUiX2I7dInDnwux7T7uv+yxxvIeMfn8Na8mlI+qZGivfFwvUukwTtDSmJmif?=
 =?us-ascii?Q?9ihOKmxwihrpoqmWAK/e0FMr8r5viPTMqA9r6bBlYJ42RZ9oHtF3G/nYeDEa?=
 =?us-ascii?Q?4lVIhzI3yQJGJIR4W1KOEzXLecFHHXv+YHKGp+QikZpbL3LgcKr41EdaBqWF?=
 =?us-ascii?Q?y/Pn+N7RJV+B5wBxVxl7/tdil2ZDm25YOoPE5hiI3BBSQT+h81yUXQVC2B+W?=
 =?us-ascii?Q?c7je8pt3hpaoeeAIdz/EbQjaesjE1rrc4CULE45owB5w09QgDQdM1gn+D30C?=
 =?us-ascii?Q?z4FlnmTd2FY2voDguQKZaZfgv+GB+0i010aTbo3QYsbkx8mDtFJ0vbq9y4Da?=
 =?us-ascii?Q?FdPstfCa3FMi0OMdn7p8MYsGw5GOdcMt7rRwvyp0xJNWVSKTyWNh0xzl39B1?=
 =?us-ascii?Q?BlhObU1YXsdf8Dbh3ka2+60A27DvjockteGErOMuEKil/mAp0s8yJL2MraQn?=
 =?us-ascii?Q?7HMuR4tdQBjtAmlHGu6hN0oxLpLuz5pIPwaBWfTHlDRWkPlSGRp6bQgzoPBt?=
 =?us-ascii?Q?tZ7AhRa4lRnMwfyTFF/F3ejQmes3rwpvC1K4cvzqxAA82PXfnT8R7UxvrCQr?=
 =?us-ascii?Q?HHis46928fv+Qi9jEoju1VFXsjqa6uKggzigv1QvGRGqws0wMzdFoemJgJGf?=
 =?us-ascii?Q?uwWYpuWqN7ltdhGUyTc3Nqx4814lRXdQSqTpyXd+q97QWAf1HS/cpkF1RzBa?=
 =?us-ascii?Q?DFMddfEDX2DAW/6YRPAO03gO24BvUNaZC0NBqx9ps1R1Odx1stV1Wo0NgO66?=
 =?us-ascii?Q?hfcTJC1k7m01InYrPBmwFoIfLcECPmDmDHAAXjwi+WLi++iG9qF27pExaq7E?=
 =?us-ascii?Q?VIMoYo1s/asCmhXM4YT44Hkf/zBeFmI6ONKy7CNLwGiYr8TfNb6mG6R6aA+i?=
 =?us-ascii?Q?Hj7jn3PCV4UwJuPrkPNCHe2rXyvIHQPXc4mHiAR8+JtmeKB+/8OIW64YOeK6?=
 =?us-ascii?Q?fbSMFKMpcBPLnxN93dlF4Yqa7em5AvDxeLkCZjlEZ+0y0A9NJJpLJHIQylR7?=
 =?us-ascii?Q?sOUFA3l2kn78Ggif9PksuRsrisN163gUulX246XW2asdOsxUoPaRMelO1DJI?=
 =?us-ascii?Q?7xTouOVHmxjWMlzRUGWuS83SbzXmMYEQ0dlnJPoWjc96FwYkIPvm9qs6lL3h?=
 =?us-ascii?Q?Ac/DoRz+8Fo50P+H8ZUvdEhorfTSAcVb4bg0JVB70ngp4E5GFY8Eg+akgVZK?=
 =?us-ascii?Q?mFbvEAcyIAFLzrnxKJI56FZZncWsbT2uNRKvz27dqMjYnov8oAHK76ATRbxg?=
 =?us-ascii?Q?NBQZEn7CKYae5fm18KOgVBKnhT2Mwyg5e0HzS3mdq3FH30qjetD/O+YJnfgr?=
 =?us-ascii?Q?lV5UrkJm6Ra2SKTBUCjpHs+fOQFREYU1ZNsYlqNxz/pxH/+FiY39m2KiSeoP?=
 =?us-ascii?Q?r9QW6IXy4z8eDWZdVrkBfeei2sHtFtaf33+CmvPuvJEkwu/sE+ofleFRcr/Z?=
 =?us-ascii?Q?4L4bt90cRmjI83M5NpKgIXh9dQrsM02Ik98lTvfBpTd+cHNqHFwPsh5F+vlq?=
 =?us-ascii?Q?avhDD0SU/1AB8ney4F+VAVzQzWL+45jsgqDqLbri?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1e4a38-668c-41e0-4d4f-08dc8e79f6df
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 03:02:46.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwMHB4UqeXo4YjpH1SeL94SGZWwf1si9rkZ9WTaMNFmnHzIFWzTb//LvjK+tfP0F+PkDmCt0p4t462JEJfI4hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438

From: Peng Fan <peng.fan@nxp.com>

Add compatible string for i.MX93 9x9 Quick Start Board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3: None
V2: Add A-b

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 5c9014087c17..1de64cb451e0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1272,6 +1272,7 @@ properties:
       - description: i.MX93 based Boards
         items:
           - enum:
+              - fsl,imx93-9x9-qsb         # i.MX93 9x9 QSB Board
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
-- 
2.37.1


