Return-Path: <linux-kernel+bounces-260811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AF93AECF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE85D283A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AAB15253B;
	Wed, 24 Jul 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OX2vouLm"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D6153BF8;
	Wed, 24 Jul 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812878; cv=fail; b=HPPH0PReGFCU8X5vUBfcOsyTL/guzFa3QtEdTHSEYmGQ3ZgF84z40ZZaD1hRNSvx6cJaqP2BpJN7RCFLDMLoZyc4WWkT/0C7IgVq/3udVC2shGTC+E/3gXGtnnc5r1W8e1K9EUkBkFM1/PXpQodpGJ0mWKCU9KYtwR3de9Y1FNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812878; c=relaxed/simple;
	bh=wDzgQrrtGpk5+6LGMPyznvxJiVKsokY4j7JPdYxpaoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tQobMcj/Hyl104WSPGvfdMgoakDPpboj34G96VS59kjA5FJ7Igz+0/LnOHoeNlNXgcP9/+LgrIehTKDMXImBr+X2qCZamXIeO8Xy62KBqgmgMIziJ1Lu1KpWwJOeVYpBRSBCgR/h6Uit/Isz5WbNxH1HlsQ4YkoPvWKFT0TO62w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OX2vouLm; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2qEKDNNDL3lt9a/O9WXW5PB92BhujQBLIx1G1zRoJuweIDroBxFEIdEXdMmC1pEGnu+xgn0hJ/x3M8WqiyBb9AoEMtaqgHScaHcTc2C4y8wUdqzrhuOnd6h4++BpxpIgU2+TzI5ZH6EvK0h62xS4oTn4RTcGmARvHC+u3MtmCE0ksMnddjrSWX7m1NIwRkCorJAPiWB5HQ3V+2o2Ju7tO22vshA0VVlu2WKCNr93CnAQSbJe/+MlGuhUTrGGEBLTVtwApEskik5orhEzxk6Uk6Qu222pVwI4eA6m2q44nE5PyqdEwWrjXWKTcDPyR6YiC40mjsK0akarr+H6nNBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoIk490rb6d3ctxZmL2CTX23KKQGKq01L7B8sQF628A=;
 b=YW7Z9Bxc2u9jfqHh0tbcclxkPEv8n2TxwcsRQSdpO019eQZbhJnD9zHniM3GPwyX44ph4X/AfL9o4h6lnwbX1rzCEJfR1pz0xjVOjg2EAfM8ydXpo0NnHhO5VcCz5k9Nkit73R26TnPz5YF8LQumppb+sdYCBimxgJXQLq3EdD/ynjPYYRlphtR6ZMRiYLkVii9Edxror1cdKjP32MSPYRZ8q/O8+dcLF7jFtiSHra/hzhneBsspwZbBXXpB8RSJYDDTLhSLr2onP1beZe1AiQkxVnydV96cpNqGy4QI+OnL2X1YCfw8nu11R9YnfFqFaNLDxdUc35C0Q/7Nn69Hfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoIk490rb6d3ctxZmL2CTX23KKQGKq01L7B8sQF628A=;
 b=OX2vouLmmBxbqj2XdeHn8AY88XSuPF9o3SWWgmOc66RPkQP0dXB0RAkt5bMaP5S/9VnSW1uN04SGntQwgY7m6LZADanNGRcpYV919OaZdbS7edXiYdbBR1UAX+l1Mbp2xuPRxzZGM8i75sJ1Zc4sv6UHfCOG2gv3fmCC4zgUKj0rkZd+5Q4QGC+8jstKPtfJz+Hy01Rv6W3lnV+cmWFdi5uzb7ohp2hvY2c2gHXx/ryO/X+InpPTOSrnMNBiDZCB0Tz/1kV1Rk73Wl9Uee0xWeaKmJ/mhalzrQIhgxgWviS7C4CzgNg2I1KIjMlZI6hKWM1686HIxEJZXA2xCR/rhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8040.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 09:21:15 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 09:21:15 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	tglx@linutronix.de,
	vkoul@kernel.org,
	kishon@kernel.org,
	aisheng.dong@nxp.com,
	agx@sigxcpu.org,
	francesco@dolcini.it,
	frank.li@nxp.com
Subject: [PATCH v3 02/19] dt-bindings: display: imx: Add i.MX8qxp Display Controller blit engine
Date: Wed, 24 Jul 2024 17:29:33 +0800
Message-Id: <20240724092950.752536-3-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240724092950.752536-1-victor.liu@nxp.com>
References: <20240724092950.752536-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: df7f2d28-ca8b-4c5c-5af6-08dcabc1f76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sdD5mu0iAU7iSBTYtn9T451KCUa5oawKupLhMFc+l6g39CfScdtJSoyrjQSI?=
 =?us-ascii?Q?UgIN1+QEqiwXInXSjOR+jS5gxkvGDB6TyHhBUvhzSCq82mZRtkNg67ZOIBo0?=
 =?us-ascii?Q?j5Ca50BAekTSpxU3nXG1I++HgFNl6V6HS+OmZDhgP75YllY9hXfdSqBPauwA?=
 =?us-ascii?Q?nEs25ftDd9scUPIvUgBpkDvp3EnjApvpOZahHHkZ4CJe5epogcqEsEd56NLc?=
 =?us-ascii?Q?IQJEu6mW3Jl1UD2KIwVYX1QY1WsbVi10UP77YHXfReGalqLE6leS76v0R8wF?=
 =?us-ascii?Q?AiYY165IuAOXrw+49uPOrNuSRLExsIBDF8hXN/Cl3EDZ8u1tOqAnrnQqK1aV?=
 =?us-ascii?Q?MX8vftOw/BM74j6Dih3HVKfgEBeC2RuoSHaHjUWNgRSC0/z1sOzqUYb0vBIK?=
 =?us-ascii?Q?lB95CsYoFT2ATmPEyAZQLfgLhwXo8LerXPZbV2IdMKLuWziux6OSgBo/y5wa?=
 =?us-ascii?Q?zv3eApqN1/O01FXjOA6AAYoTMLVolgUMLCvpPcWK50tKE8XHkkxtjyBfFxU6?=
 =?us-ascii?Q?yKrthhVx+lFUc5A7E0OoaxDRtwds10kb0U+FsKb1lhcX+OXZX1ivVtkq1QB9?=
 =?us-ascii?Q?XtSPGSG1l3YADzrMoSMhWAshbtFRJwfjdjm0dAIwwx32s5pbZkg6WBzviZqO?=
 =?us-ascii?Q?aBmG50WgfNn1/eqDDVAxoGuR0TrpsGQSPnyw05xlzRm/z+3tFNuMPg0E5WAW?=
 =?us-ascii?Q?jHbvsixf+t9uYx1QrRIUrn73GhjBsdNZAOP6pvtI/4O6DSkIQI/vgkxEdeo8?=
 =?us-ascii?Q?1vHCUC4XJIgxCq60/8Q1febE3gNWVNib0iJEqLaASVpHi8bnZvKhQjzvHzrJ?=
 =?us-ascii?Q?YRRK7FZp3fRq6pBi+ZYoc+PToaboFdI9e4EtTx9b4J5jyyH9We1j/SibN0Pn?=
 =?us-ascii?Q?Z/m0MXDUzG7oD1pREV8CAatoDK3IxVzFYEjl+8DMYb8aUfXv58BreJIo/xr8?=
 =?us-ascii?Q?InhEeQ9HK+PZpBZKHpSN5ciRudG+7SI+lMffLdYiudMcdN5y3wKfZ/KHNj73?=
 =?us-ascii?Q?sFmZPmZehRQ/q7ng3YPkXkMZbeFPV2EpU0HOJmvbLr0C8p8orzoQcY6COE5t?=
 =?us-ascii?Q?OXkjbLos4NC4k1YvdB9tJgekEnjUP65BlAYOoigLgA4/E1IHVUOw6w09luJM?=
 =?us-ascii?Q?0awPlHa8NxfT6oCGRKKGlf/RVVxe4vefDjhO3V7cs9YA0EvcV277REKfTYN5?=
 =?us-ascii?Q?eIUARX9JnOZnS7WU0Yf2Lj6gCBpkAO2UA4YfSr44KTvFRmd9ZBzkN9kAuBdZ?=
 =?us-ascii?Q?xMc58sFhukn293kuq15K2IrGnyrIFVqt6amjDvO0+0Q+hXBvDPRSQO+H3nn4?=
 =?us-ascii?Q?VuwK5IDqJCRWqm3KP7b3jqIPs556klzAl4FWUJxUg3cmbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?11NOZXzP7YCs7iT41tBEKwOotZSmuHuIencj2kLWNKxmWHnqc7YOa5k37/RZ?=
 =?us-ascii?Q?l3wrr8QwNSrXO1XJe7fNo/N5ExSBrxoYYMEZgQvxQF0TsJN/pDUwIi0DURSC?=
 =?us-ascii?Q?FQAe62IycfmhFix1DidRRo8UzlemTWStHrWpJAdycqdQ7H18wRvt+oIjMHhP?=
 =?us-ascii?Q?DJlA6t/g54Xkl+rw+6zllDjJ5TecitY9rPkxUQFqPxIP2yJz3+h8Vu/keuu6?=
 =?us-ascii?Q?lit0NSTDybykSOu7NdAzL3O/8L67aKsvLYbMQb1h46Jc34Wo0gByRacn5aFb?=
 =?us-ascii?Q?oplkhGjNHpYIiWKsMdmR1SoiUpUloHx6M5tnbYjgMCBhEuEAZtd7+KhMn4rc?=
 =?us-ascii?Q?SxKXpi3WHWBY66TrNOhmcl27qKtvOUcKxTA7IUigxTCKm60GyaEUK7GysfFu?=
 =?us-ascii?Q?ovs90ori6FwricPwuDhLRxBOjiK0mWciuBaxBCBZoefcNozwXuUku4CX+vK7?=
 =?us-ascii?Q?YmR48QCEvAkfZ80dKkqAD2wuX1HZS5YvD8U/l1HsU+gkIJeBcO2Zy+G1bJrl?=
 =?us-ascii?Q?eDYMNZko3+iGIjqrXisXqJB061NjAS9eqePMGRRI3FdNeoOxhdOosfcuT8IF?=
 =?us-ascii?Q?NZQnteAHtewmp9Ez5n/gt3vQRTuJGCy3sCV1NnFTKpzh8UTAaXG+tAywmULj?=
 =?us-ascii?Q?icY6ImQExRMwR0dK4sJltmuWn9VM0apk4Bqgwbg/l7b8fSxHdP+OX8yhm6me?=
 =?us-ascii?Q?GdLR0o3tbwg714hC7LTfpCaOMmQdSy9kCHl4EHhi0DwjPor1Q7rH1kZMBjE1?=
 =?us-ascii?Q?fsE7RV+vY/qLxVVI9pXt+ZSEJbMBSnLCDNbDNNjXXOs2MPWku6YWgMGPDKo2?=
 =?us-ascii?Q?iicqfdqYdisfdnM0/LaICMWf/6ppCnLrueDyGJtUSMdjJMAUf5REHI9V1G18?=
 =?us-ascii?Q?pWKeKJ6cocYsGNcTG948KFbXcJ7loyNfX+qkm3HY29lKG8kA5zzwJY4MkTQP?=
 =?us-ascii?Q?edO3StWNrMo/iHIDXXKYaaXCaj4X6OpNQthoozkDbYQXi+KY55OQDY4pDQxc?=
 =?us-ascii?Q?79lqUl+qCxMsmxwF2Eg0/Rh2uGTmSSMN74xyWddf1KWSPSOSpZYkq4pocYk5?=
 =?us-ascii?Q?x1DPB6sAZ2uP1I3AKJWd3U7SxQvufrd0WcCnJpzRQl1mpEwCwjqJBrOijbHY?=
 =?us-ascii?Q?6Tl4kLXMkOwINaAy+bY+S1stXf21uvV6kCBTcXdKyQM/ICYlylYCFBhHu27/?=
 =?us-ascii?Q?z4xaD8PTzxG3XTCw/0772lLxNeMOb9V9aTtILpJwHXQ5wmUx8NpjM7qJqtrs?=
 =?us-ascii?Q?rPia2YXcLgds7GCG51LoTWZ8zhRPYSj3eDhkJGKOXcrse44yp4ZcuknEcUP5?=
 =?us-ascii?Q?qXaONJ29+gCtGIuxFq8KAojuwo0kPsPlB9ncSSAURvU1T3vFqYOEdbreK6Y4?=
 =?us-ascii?Q?6FQw5EE9efE0x5mVpwQh3Pz47MYqPnGvbrYkCgKJdC3Pmrty40tXN8eqkqkU?=
 =?us-ascii?Q?DK/XtFiIrg4YFqoXof5uMGYr0ZHJPOy6Fmz4nm2HOdbKixDcbldNrztMBiWu?=
 =?us-ascii?Q?tafM3nyFVHkP+CItD2JORY7nxfYwubeCIaa4Tvehvv55NjpSLL56VtDYWFEc?=
 =?us-ascii?Q?xlbtiCTVwjdNRA+rr3Z2wm31tuU/aA6ZINU3W3tO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7f2d28-ca8b-4c5c-5af6-08dcabc1f76f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 09:21:15.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qi67xRJwyccQf2ED5AVoBxnTvUWQW3ACJC6hGNpt+ZScvd9zpOuriwYCXkI8Bmj4Q0K3FyrgaESOkR+cC0vqGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8040

i.MX8qxp Display Controller contains a blit engine for raster graphics.
It may read up to 3 source images from memory and computes one destination
image from it, which is written back to memory.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v3:
* New patch. (Rob)

 .../imx/fsl,imx8qxp-dc-blit-engine.yaml       | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml
new file mode 100644
index 000000000000..45db6da39e20
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx8qxp-dc-blit-engine.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Display Controller Blit Engine
+
+description: |
+  A blit operation (block based image transfer) reads up to 3 source images
+  from memory and computes one destination image from it, which is written
+  back to memory. The following basic operations are supported:
+
+  * Buffer Fill
+    Fills a buffer with constant color
+
+  * Buffer Copy
+    Copies one source to a destination buffer.
+
+  * Image Blend
+    Combines two source images by a blending equation and writes result to
+    destination (which can be one of the sources).
+
+  * Image Rop2/3
+    Combines up to three source images by a logical equation (raster operation)
+    and writes result to destination (which can be one of the sources).
+
+  * Image Flip
+    Mirrors the source image in horizontal and/or vertical direction.
+
+  * Format Convert
+    Convert between the supported color and buffer formats.
+
+  * Color Transform
+    Modify colors by linear or non-linear transformations.
+
+  * Image Scale
+    Changes size of the source image.
+
+  * Image Rotate
+    Rotates the source image by any angle.
+
+  * Image Filter
+    Performs an FIR filter operation on the source image.
+
+  * Image Warp
+    Performs a re-sampling of the source image with any pattern. The sample
+    point positions are read from a compressed coordinate buffer.
+
+  * Buffer Pack
+    Writes an image with color components stored in up to three different
+    buffers (planar formats) into a single buffer (packed format).
+
+  * Chroma Resample
+    Converts between different YUV formats that differ in chroma sampling rate
+    (4:4:4, 4:2:2, 4:2:0).
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-dc-blit-engine
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: pec
+      - const: cfg
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+patternProperties:
+  "^blitblend@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-blitblend
+
+  "^clut@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-clut
+
+  "^fetchdecode@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchdecode
+
+  "^fetcheco@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetcheco
+
+  "^fetchwarp@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-fetchwarp
+
+  "^filter@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-filter
+
+  "^hscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-hscaler
+
+  "^matrix@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-matrix
+
+  "^rop@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-rop
+
+  "^store@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-store
+
+  "^vscaler@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: fsl,imx8qxp-dc-vscaler
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    blit-engine@56180820 {
+        compatible = "fsl,imx8qxp-dc-blit-engine";
+        reg = <0x56180820 0x13c>, <0x56181000 0x3400>;
+        reg-names = "pec", "cfg";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        fetchdecode@56180820 {
+            compatible = "fsl,imx8qxp-dc-fetchdecode";
+            reg = <0x56180820 0x10>, <0x56181000 0x404>;
+            reg-names = "pec", "cfg";
+        };
+
+        store@56180940 {
+            compatible = "fsl,imx8qxp-dc-store";
+            reg = <0x56180940 0x1c>, <0x56184000 0x5c>;
+            reg-names = "pec", "cfg";
+            interrupt-parent = <&dc0_intc>;
+            interrupts = <0>, <1>, <2>;
+            interrupt-names = "shdload", "framecomplete", "seqcomplete";
+        };
+    };
-- 
2.34.1


