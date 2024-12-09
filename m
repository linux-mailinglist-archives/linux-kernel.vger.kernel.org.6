Return-Path: <linux-kernel+bounces-436710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B54E9E89D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD4C18843D4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC96155A59;
	Mon,  9 Dec 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b7Dm2vt+"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A93156F57;
	Mon,  9 Dec 2024 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733715636; cv=fail; b=KHjY9Y8S2XXJlb7iZeEPCno037ZOG///hDCJT2Fj2PgidSG7t3atskKs186NxxS0zMUoIJnQLEK+k4JlOR/nZkmeW9J0OtBhQURa1J3slXygPSsCzJaY1+Nfz/weZU46uaTOcw5lF3U88JhMIfqXklBaGg7TyIs6mnYawo3ALLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733715636; c=relaxed/simple;
	bh=U0Labt2hpSZ9ix58MCn4iX42H2gN7cYTxeLXiZ3bRws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7rsachk4jeIb3aFrgyx5lBqjDt+hhJuRTg6ZLRYZB4b8wVPx9aNYYB1VOzNTU9agtaMbAOi8Kz4J8oqtTxyopXPO6OJUbMtgx/bnnIQ7KvOTT5mCNs6d1WMIwz5mxL0FUDQO54oXOe34TlLnAKbOgAVJTUA/E94lB4up1pHPoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b7Dm2vt+; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj2nbhDa35G/apgAkK5R0Bz/gfMTL7dMbEQHY/PUKujcwf1nhOhZ8ZSKRTGm/LH5sEBKwg2KTjAxNEro7BDPUmP/wHdZ8rTNu3cA5QGcvRG3ytXF7PLX/Gm7QUrcnn9kacAbNDrMh38KuigGyT3HnjrR9GPt9X7Ij0kB7KNkY0w6zQVjocqkIyeSpVn77c4JcUAb57UpIb2XS34u86p9qSNX1gMJ5UNnkCC/VMcAkxoAJUssY87pyxeyXhNIJVq4GcRZeLXbHgwrE+KRu08nwYpCg00SJrk1izbgLpatLXs7M0jK/Ask1EeYWfYVmDLjyrt+0Yqnhf5CGxqfZAx3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8SxKVYfDrFBJyTZ85YZAZAae/p0orTIA2PQMfV5eYg=;
 b=iFADCnfXRDna2Dh3uKlNhJLrY7iJwT65kWcln51rMUPFtOswSOn+qxnMBqStlGWbJC7dXeHULp3pbxeYeoSdYu55Ys228a2frJVjI9IDnOSIN7Kloa9X86kN+n7/HPwJWfpKnCe9AwpR3/e3I4hixHfMNMlG88oKj0DKAzk9Po25n3pFhNRLKQ+XTiCAAMEiFAoyXJbHmah/2UV6ZflbyohNTcCMKP2+4+mdeGDsdUJ82DkbEtFdl4mBEgqBhVXJJS/iYwZScl2M3drRSSO2kotzEjr7FPstXxCnAgryyxG7CdIEDrMKlGTb5UDnqQefZVcERqpomkMfls2uwPpDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8SxKVYfDrFBJyTZ85YZAZAae/p0orTIA2PQMfV5eYg=;
 b=b7Dm2vt+1E1S9fQ5YbZXwuW1f2TgaFy1B+uFzf8wwrgz59L9AuWB3E78g4Bt9gWmF/b1vB+OaGtjBq6E4zfP3nCI4nGSLOqP7rZCDpfiHe9VzhQgFc7KFpmqPWKHIoEQCzdaoybVXgj8alt4/USGGKe7QvVTzyGD3IPyDGO9cHJEZIy0cwGmHndnjTCZcWUzKVddHxrkq748PeByhzq85CqRtouCLuw159oYWWfGMKqMPMZXy1JSxb8O3eYnBbuNbAy5fzmjbfjt+BrzEgcZEhn0g6bHIv+lVtcUpxObagJyvcwnnjfYIduSEEnSrv38EseGUN+2zZFhAOGQKgEzug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI0PR04MB10212.eurprd04.prod.outlook.com (2603:10a6:800:243::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 03:40:30 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%6]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 03:40:30 +0000
From: Liu Ying <victor.liu@nxp.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
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
	frank.li@nxp.com,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com
Subject: [PATCH v6 07/19] dt-bindings: interrupt-controller: Add i.MX8qxp Display Controller interrupt controller
Date: Mon,  9 Dec 2024 11:39:11 +0800
Message-Id: <20241209033923.3009629-8-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209033923.3009629-1-victor.liu@nxp.com>
References: <20241209033923.3009629-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|VI0PR04MB10212:EE_
X-MS-Office365-Filtering-Correlation-Id: ba81a19c-95a7-4b09-9a66-08dd18033a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYy5dZO0NZ19vmzDQv4GfeFfLYmOEBmMaOqSUx5MqrrFUxxMKmuOYSPss7sY?=
 =?us-ascii?Q?KyCDjwVtPopoAvBE87gLRi1qYp9VtThztv0nY6UTMzuVR+YEiwyLLb7I3kKJ?=
 =?us-ascii?Q?dFmNFGVxTL8AiprRnwn0bRM1epz+h4vzyzadmjASg5LbC5fSazV/sRQ7xowH?=
 =?us-ascii?Q?VESPE/gRi7HEypQIyzmycEvqVjmcLsf5XGGCXLNafAXzSQiW1bsoqSdpFxYn?=
 =?us-ascii?Q?RLsjoQ9hRc/aqW+fimo9En66mHXc4ztojYeblB8zmeIBQ0ZhoY/yPP4flY8H?=
 =?us-ascii?Q?75FIR2xL3ewOcnA/6tdxSMzWW648g85jq9duN4d250IGfJalrrBwBVicieop?=
 =?us-ascii?Q?/Ahd7E7pm2WKdOOoh6UH8m3M3V3DDfsUfyGTOBTFkUmJPfF7T4S0c7DDGhS1?=
 =?us-ascii?Q?CEJ6hXeLsjVGjt2odBBqpMTh01XZ5YRqYBLcdStL4t2wGy6HYa87MURYlZWt?=
 =?us-ascii?Q?9tZcTEIzGzGuqr2RBq5GPAIRjVgDiK1nkXyYFrLwFUFn9R+h/SNzURGTTmYk?=
 =?us-ascii?Q?jL24E+9RTfA1AJH9WXc15xWIDiXz8sDtYSi2d3ih7AUjgFisQiKtV/yPt6+F?=
 =?us-ascii?Q?XhK89De6s4uRheftufLgsfJyOjtyzBvYvi7pYTGExXqETaf8MV8GjJpsgMFm?=
 =?us-ascii?Q?jbS10kkGSE7tiaS1HmrwZPy9ejYMqFsbuskd8SE9lOuA+KOv9YWnsuIhZh/6?=
 =?us-ascii?Q?vUDbs4ZJFKM0bIH4pYHt4sejC9UMvZi6TpOtn/xYeSL1UJW2D73BeYr0kr89?=
 =?us-ascii?Q?dV5OB0maHpHe0/D74+OlLLpwvO5Q9blXGmi/9Y6zDJHkCGiJcA+Fktr3b3X7?=
 =?us-ascii?Q?JEMzgqbgJeZp5HFZaCzV+mAfLnSk9ZBGpxf1ljQsNscZvudr+2qOisa6QN2p?=
 =?us-ascii?Q?SxC1RBduUMIwtM2Bu4GooRCSnjEifPqNShculykHCb4Ak5xDYbFrLq/YVlM9?=
 =?us-ascii?Q?MibETVzpr9O+cEBLyyHu5ZgVtEAf0B4RyRr9xXSL0exf2jcr3fOzz0C337dW?=
 =?us-ascii?Q?w3T9HGLwRu8Wh2pRE/hKcqO5KRTyRq8KNbuu0+GUDhr0FWGtFX3EqzcG4jvS?=
 =?us-ascii?Q?RMSuu+1l6jcnjTXN9LUbMVliFGR3hzEgPCBCW7z8WGESlJNcEDX8tpbZWM+J?=
 =?us-ascii?Q?Rg0zWjJlNS1sfjkyhUN/55nRvgFfa7m1CbOOv4lT8rP6ktXWdHX1TkZ/4Jtl?=
 =?us-ascii?Q?HdaXGq7DGe2b6Qcbzp0xdqwsdegZ9h60WH6bgQK73PiR5nq15Vakn7TJKdwY?=
 =?us-ascii?Q?4dp5ShDT8VlzoJhmB0XmEhptBrNkt9XVFBJKJtuaYNAaOZFEhYpUTo5iPnDx?=
 =?us-ascii?Q?zW0ImyQ1BHSo8vD3KWGtATMBNxe8IKnpRGfuSbJTsHkzyNCRRqrO8bV3e5dF?=
 =?us-ascii?Q?Mh87OlQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HFZ43kYr1cHlz3BJcgmN/uuyTLmmjS5LSuihzs2mly9igC9ul1jx0HwaR46c?=
 =?us-ascii?Q?vHCOaWWAhvN6ljtFdPm946SwMbxze0PeVoE00yF7vftw+KUW4svLx/FvjtNp?=
 =?us-ascii?Q?cgMeqG3z7FPloJ7wZVVgtgO7OPU3F1EqMl+Ugry1pMTl5o6mT4vviS66GKTF?=
 =?us-ascii?Q?5iubl3ant6SF2VKZagAaNODv6YSjkXrGDinT/7VthE+Txw8UJT24NZQayLf0?=
 =?us-ascii?Q?qe1RVRaxCUvJsKOyBQ0S8rumCXYwFnU/SzAEKYAaEPBRbtGv56KCAInfDuLr?=
 =?us-ascii?Q?Etq0bB9DPS9cdZKY4nLJdxPxL2rG37hzIN+ATKKCD0lrrabzvtCcr4uaukO3?=
 =?us-ascii?Q?aTpyUn03amHRxT+uk20btEZpxqXx4/ewtgDLZQq79bgHXCKphejRsC5UtwsG?=
 =?us-ascii?Q?+Um0uy2hr0AQ2VFQxno0XexnPPJFFjHMBeCQHNWcl/NtyMCj8httOlF34R2T?=
 =?us-ascii?Q?x94/omKnsVI06d7vFBzjn5Bhmv/yoAmt/+uD1es2lbY/a089lKFWnhnPhcqd?=
 =?us-ascii?Q?UYSAEPnxY5K/G1RFTpdhX8+V6EhU9pNztzyY4YfyMMqTrhMGj6nufggTkFit?=
 =?us-ascii?Q?o6y8Z8Zsqfq7RrZvBm4tZNd6+THycLBI9MmE8ARYofWQF7Wv5lQYbso+5pJ0?=
 =?us-ascii?Q?FrsbShH92hW5Vcmcf3LTLu1hCbauKz4Fa4DWmsNLbwjVDU7HAD5VpDTrngq3?=
 =?us-ascii?Q?cHhrflc3rMbIYQavAsMI5Hix8THwcMVFVibi8DUv5vJyqn0SERnunXldndJ6?=
 =?us-ascii?Q?MPgPH44jkxK8ht+7mbrQb0OqAxhurlUJ69tL0NGUP8VjEMBjmAu853y3ddJM?=
 =?us-ascii?Q?xt29gNUkT7rxyywrgTXDtPRCMYdo/PYrm2cC1AQp1Jy2rc9iq3NpuNqI2mMt?=
 =?us-ascii?Q?ofV+/5MaY100chflSGZH0gny/jOKWMak7J9TAVNxkfE0OJQ9vcZHE4f1ih0r?=
 =?us-ascii?Q?ZdWUH7bUIoKLzTZOo2fDZ4fUkb3JPZvur3x5wzpYzN/PetGegjKCSVbPKPYV?=
 =?us-ascii?Q?bgTOgtJ8tQxQO7JwugZyxfU6Y1WlcOn1wGgOKMRlyd15BiPtnJ5BkRhs1dhO?=
 =?us-ascii?Q?VEIvARmTNvkv2nOgvYMEkD8wK/WSVuEk1Ctracg4v3hiYwkn1OrSzSfoVv9P?=
 =?us-ascii?Q?IIs7z060G6Iw3+IMSPQv4spotJcf/OgCwXLVoMus0dwKaqOXUURmyr+iLcCU?=
 =?us-ascii?Q?vg2SJiSP0+C2+LP26NBpOonO8n07BSl6+Ect5Xn0Qi3WC+zuDm3A9JURm9x4?=
 =?us-ascii?Q?AILzE73EVBdZEoxufG6pvOW6AoQE+PjNKCZhKP2y5ZbL47aeP8zZanKsDEUj?=
 =?us-ascii?Q?VAOHlV0I4N+aUGgoNpR3QclZU02Msp7Qetb8C0OOFCCC26yH+PuP1KuOwGy9?=
 =?us-ascii?Q?YU1hQSgNppFBwq6tyKholk0Qbh8AE1UvRAUX9fBAgYNbzVBknm4NXLURpEaU?=
 =?us-ascii?Q?BL2bdENyhqPramyhBc0cVh4NHyKkDRKlt3mCMiEMXgq9Uz3+lS976p+WE2H6?=
 =?us-ascii?Q?+2tW6Zjr06bUmdpy6DOO9xD79oKeAksGmgm2/GFvswaMzuAtot5+pTRRPg2M?=
 =?us-ascii?Q?stPMED1495vj4xNfyUmQWq6AsAvCqE2MxDnOsr+I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba81a19c-95a7-4b09-9a66-08dd18033a62
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:40:30.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/ogYGfiXpY1lSyyri54HIpD+nEh5N6Bv5k5PiU/eXHC1WlsPeB13wPHnvrI2W7XdFCAhcptfg63GpXTKTrWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10212

i.MX8qxp Display Controller has a built-in interrupt controller to support
Enable/Status/Preset/Clear interrupt bit.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6:
* No change.

v5:
* No change.

v4:
* No change.

v3:
* Collect Rob's R-b tag.

v2:
* Drop unneeded "|". (Krzysztof)

 .../fsl,imx8qxp-dc-intc.yaml                  | 318 ++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
new file mode 100644
index 000000000000..6985ee644a25
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
@@ -0,0 +1,318 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/fsl,imx8qxp-dc-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Display Controller interrupt controller
+
+description: |
+  The Display Controller has a built-in interrupt controller with the following
+  features for all relevant HW events:
+
+  * Enable bit (mask)
+  * Status bit (set by an HW event)
+  * Preset bit (can be used by SW to set status)
+  * Clear bit (used by SW to reset the status)
+
+  Each interrupt can be connected as IRQ (maskable) and/or NMI (non-maskable).
+  Alternatively the un-masked trigger signals for all HW events are provided,
+  allowing it to use a global interrupt controller instead.
+
+  Each interrupt can be protected against SW running in user mode. In that case,
+  only privileged AHB access can control the interrupt status.
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-dc-intc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    items:
+      - description: store9 shadow load interrupt(blit engine)
+      - description: store9 frame complete interrupt(blit engine)
+      - description: store9 sequence complete interrupt(blit engine)
+      - description:
+          extdst0 shadow load interrupt
+          (display controller, content stream 0)
+      - description:
+          extdst0 frame complete interrupt
+          (display controller, content stream 0)
+      - description:
+          extdst0 sequence complete interrupt
+          (display controller, content stream 0)
+      - description:
+          extdst4 shadow load interrupt
+          (display controller, safety stream 0)
+      - description:
+          extdst4 frame complete interrupt
+          (display controller, safety stream 0)
+      - description:
+          extdst4 sequence complete interrupt
+          (display controller, safety stream 0)
+      - description:
+          extdst1 shadow load interrupt
+          (display controller, content stream 1)
+      - description:
+          extdst1 frame complete interrupt
+          (display controller, content stream 1)
+      - description:
+          extdst1 sequence complete interrupt
+          (display controller, content stream 1)
+      - description:
+          extdst5 shadow load interrupt
+          (display controller, safety stream 1)
+      - description:
+          extdst5 frame complete interrupt
+          (display controller, safety stream 1)
+      - description:
+          extdst5 sequence complete interrupt
+          (display controller, safety stream 1)
+      - description:
+          disengcfg0 shadow load interrupt
+          (display controller, display stream 0)
+      - description:
+          disengcfg0 frame complete interrupt
+          (display controller, display stream 0)
+      - description:
+          disengcfg0 sequence complete interrupt
+          (display controller, display stream 0)
+      - description:
+          framegen0 programmable interrupt0
+          (display controller, display stream 0)
+      - description:
+          framegen0 programmable interrupt1
+          (display controller, display stream 0)
+      - description:
+          framegen0 programmable interrupt2
+          (display controller, display stream 0)
+      - description:
+          framegen0 programmable interrupt3
+          (display controller, display stream 0)
+      - description:
+          signature0 shadow load interrupt
+          (display controller, display stream 0)
+      - description:
+          signature0 measurement valid interrupt
+          (display controller, display stream 0)
+      - description:
+          signature0 error condition interrupt
+          (display controller, display stream 0)
+      - description:
+          disengcfg1 shadow load interrupt
+          (display controller, display stream 1)
+      - description:
+          disengcfg1 frame complete interrupt
+          (display controller, display stream 1)
+      - description:
+          disengcfg1 sequence complete interrupt
+          (display controller, display stream 1)
+      - description:
+          framegen1 programmable interrupt0
+          (display controller, display stream 1)
+      - description:
+          framegen1 programmable interrupt1
+          (display controller, display stream 1)
+      - description:
+          framegen1 programmable interrupt2
+          (display controller, display stream 1)
+      - description:
+          framegen1 programmable interrupt3
+          (display controller, display stream 1)
+      - description:
+          signature1 shadow load interrupt
+          (display controller, display stream 1)
+      - description:
+          signature1 measurement valid interrupt
+          (display controller, display stream 1)
+      - description:
+          signature1 error condition interrupt
+          (display controller, display stream 1)
+      - description: reserved
+      - description:
+          command sequencer error condition interrupt(command sequencer)
+      - description:
+          common control software interrupt0(common control)
+      - description:
+          common control software interrupt1(common control)
+      - description:
+          common control software interrupt2(common control)
+      - description:
+          common control software interrupt3(common control)
+      - description:
+          framegen0 synchronization status activated interrupt
+          (display controller, safety stream 0)
+      - description:
+          framegen0 synchronization status deactivated interrupt
+          (display controller, safety stream 0)
+      - description:
+          framegen0 synchronization status activated interrupt
+          (display controller, content stream 0)
+      - description:
+          framegen0 synchronization status deactivated interrupt
+          (display controller, content stream 0)
+      - description:
+          framegen1 synchronization status activated interrupt
+          (display controller, safety stream 1)
+      - description:
+          framegen1 synchronization status deactivated interrupt
+          (display controller, safety stream 1)
+      - description:
+          framegen1 synchronization status activated interrupt
+          (display controller, content stream 1)
+      - description:
+          framegen1 synchronization status deactivated interrupt
+          (display controller, content stream 1)
+    minItems: 49
+
+  interrupt-names:
+    items:
+      - const: store9_shdload
+      - const: store9_framecomplete
+      - const: store9_seqcomplete
+      - const: extdst0_shdload
+      - const: extdst0_framecomplete
+      - const: extdst0_seqcomplete
+      - const: extdst4_shdload
+      - const: extdst4_framecomplete
+      - const: extdst4_seqcomplete
+      - const: extdst1_shdload
+      - const: extdst1_framecomplete
+      - const: extdst1_seqcomplete
+      - const: extdst5_shdload
+      - const: extdst5_framecomplete
+      - const: extdst5_seqcomplete
+      - const: disengcfg_shdload0
+      - const: disengcfg_framecomplete0
+      - const: disengcfg_seqcomplete0
+      - const: framegen0_int0
+      - const: framegen0_int1
+      - const: framegen0_int2
+      - const: framegen0_int3
+      - const: sig0_shdload
+      - const: sig0_valid
+      - const: sig0_error
+      - const: disengcfg_shdload1
+      - const: disengcfg_framecomplete1
+      - const: disengcfg_seqcomplete1
+      - const: framegen1_int0
+      - const: framegen1_int1
+      - const: framegen1_int2
+      - const: framegen1_int3
+      - const: sig1_shdload
+      - const: sig1_valid
+      - const: sig1_error
+      - const: reserved
+      - const: cmdseq_error
+      - const: comctrl_sw0
+      - const: comctrl_sw1
+      - const: comctrl_sw2
+      - const: comctrl_sw3
+      - const: framegen0_primsync_on
+      - const: framegen0_primsync_off
+      - const: framegen0_secsync_on
+      - const: framegen0_secsync_off
+      - const: framegen1_primsync_on
+      - const: framegen1_primsync_off
+      - const: framegen1_secsync_on
+      - const: framegen1_secsync_off
+    minItems: 49
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+
+    interrupt-controller@56180040 {
+        compatible = "fsl,imx8qxp-dc-intc";
+        reg = <0x56180040 0x60>;
+        clocks = <&dc0_lpcg IMX_LPCG_CLK_5>;
+        interrupt-controller;
+        interrupt-parent = <&dc0_irqsteer>;
+        #interrupt-cells = <1>;
+        interrupts = <448>, <449>, <450>,  <64>,
+                      <65>,  <66>,  <67>,  <68>,
+                      <69>,  <70>, <193>, <194>,
+                     <195>, <196>, <197>,  <72>,
+                      <73>,  <74>,  <75>,  <76>,
+                      <77>,  <78>,  <79>,  <80>,
+                      <81>, <199>, <200>, <201>,
+                     <202>, <203>, <204>, <205>,
+                     <206>, <207>, <208>,   <5>,
+                       <0>,   <1>,   <2>,   <3>,
+                       <4>,  <82>,  <83>,  <84>,
+                      <85>, <209>, <210>, <211>,
+                     <212>;
+        interrupt-names = "store9_shdload",
+                          "store9_framecomplete",
+                          "store9_seqcomplete",
+                          "extdst0_shdload",
+                          "extdst0_framecomplete",
+                          "extdst0_seqcomplete",
+                          "extdst4_shdload",
+                          "extdst4_framecomplete",
+                          "extdst4_seqcomplete",
+                          "extdst1_shdload",
+                          "extdst1_framecomplete",
+                          "extdst1_seqcomplete",
+                          "extdst5_shdload",
+                          "extdst5_framecomplete",
+                          "extdst5_seqcomplete",
+                          "disengcfg_shdload0",
+                          "disengcfg_framecomplete0",
+                          "disengcfg_seqcomplete0",
+                          "framegen0_int0",
+                          "framegen0_int1",
+                          "framegen0_int2",
+                          "framegen0_int3",
+                          "sig0_shdload",
+                          "sig0_valid",
+                          "sig0_error",
+                          "disengcfg_shdload1",
+                          "disengcfg_framecomplete1",
+                          "disengcfg_seqcomplete1",
+                          "framegen1_int0",
+                          "framegen1_int1",
+                          "framegen1_int2",
+                          "framegen1_int3",
+                          "sig1_shdload",
+                          "sig1_valid",
+                          "sig1_error",
+                          "reserved",
+                          "cmdseq_error",
+                          "comctrl_sw0",
+                          "comctrl_sw1",
+                          "comctrl_sw2",
+                          "comctrl_sw3",
+                          "framegen0_primsync_on",
+                          "framegen0_primsync_off",
+                          "framegen0_secsync_on",
+                          "framegen0_secsync_off",
+                          "framegen1_primsync_on",
+                          "framegen1_primsync_off",
+                          "framegen1_secsync_on",
+                          "framegen1_secsync_off";
+    };
-- 
2.34.1


