Return-Path: <linux-kernel+bounces-374767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99089A6F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493FF1F26D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B81EE029;
	Mon, 21 Oct 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RU6wVfKM"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA341EABDA;
	Mon, 21 Oct 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528510; cv=fail; b=pm6Ig6LpnbSqLojDH5ougb0vGyqr/LWeykLEHsDShFQq5hmAvyY3JmZpWWG/TAXMsHqFrSKm3vQCGMYmHK63QpowbgLmTQu94YbkXJbs3EVnaAhTQxFVMKqmYj8uVyuNepJwI0V4giHpyFdKqaIgOD+XwsOY43s3HeY/MzVg1pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528510; c=relaxed/simple;
	bh=kMIs5iIxmHDEofuS2zjFjAL8bxubocN0yKdl5Up2SYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSyDCUN9HD4emg8hKS+AuDctZwIJCHS/LPg96LrGkdnWaBkBWy+OLrjBcBdEkeP516Pn/Ma7YNa48onBumxgCmleuIxNgmjyf14q0zW4GBeT23bm99Hmj7Yv87dvVa0A3sgInsYMl3ZbtgHTzDl8XEQTqEGm/w7LwA6uoqVyBME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RU6wVfKM; arc=fail smtp.client-ip=40.107.247.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJu3DhU1i4fsSHoxaIOIYlViPaQlgvusTYS7UfELsSHTKUyZpU1KiTmCat7oswZAqkBY4p3CnY2OJiURMIjROLnKfbxiVH3BLsCXbqa0FmdcRB3zCLJnwvhDDmxirMgE9XSWGXDUVbngAc9rNA1MqXzH26Rpf6rqR9h8qAbAtapu69YgcOjlE+ZCmvQAA9l/o1A6Nf6em1UyKa1UG5toYOB1sazZxrBKyiz8LEvdzjJbeg55OoGwRMk/Nq7BTtHGpSl87cXEaQWNdTjdPdHZ/mvSAJm1MISeNGy/YZHLeMhlNPyTFklQdat8CRuu9Td4LqpH798ZGXoGJDmz9bkYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvVyaS/hglk50HvYOo6cHTrdRbg73VVPm57yOW4gXCI=;
 b=X6aMRYdyDSXwj96eNC2n3qYuxVPkaWLw+9pb3DXaMo3W5iYsaLjMX1jKzLUDf+B9LHXDMDg48AoNNQEcAsxQcDpE1qzT3YcdhRpnGbH/y85oogVkpf5P6rFvt8C0vuLz2LpzDYb7KZHU+oTYBk5oeN/JOiJMAfh7n1H4bI+5DG4valHom+uacOoKkPifwZujbuc0KK72MpnveDsQMZRcPPJtwhKZ37ia7l+3+3eQ3p7IcZvXxcv2YrRiQfl4XkLnsWZa4cJG0r9PQtqN+w6w8ka0FH2Js4Y+ymm5Ii/yHGAaxLPrywt9zz67vBv+ov9ZUhKwn1VUI4uEs+5uoQdGIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvVyaS/hglk50HvYOo6cHTrdRbg73VVPm57yOW4gXCI=;
 b=RU6wVfKMi1ANYMgZTcZE+rFh6fkkp0vWewLwsaYZjSB4l1ClFRZxhx0l0Ys4p4J7rXle8Qjh8oW9Iwpxu3mUY3cqXivDKIY0Tt2JTDqnxIjqOYnOzI8kkZIpp+V1HmXey2rT8u6PkZbzZNiulvy3UKRa7w11Jr8I05nOV5kihA/7F4mTE4mxW59CFEUvAXFlS4i61Fl3UtLKY7AQ+5USPhPbNK9/f8MX4JdYVUbb/DBe0IezcuyJ3LOrQyX86ZKXCWe8Np63P3rUTOI7YDD2jKqu45l0lpR2qxRADeOkrEvcr8/PQtLUAU6lCQT7fHsu3PInXJ+HHRvhIxV3jK3hnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:35:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:35:05 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 4/6] arm64: dts: imx8qxp-mek: add flexcan1 and flexcan2
Date: Mon, 21 Oct 2024 12:34:35 -0400
Message-Id: <20241021163437.1007507-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021163437.1007507-1-Frank.Li@nxp.com>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: d6811ac2-26a5-4989-0516-08dcf1ee5180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vOjNLOT9XLJbnF1LmWO+vaE+YYHBpIaYacVNpE6Hiy8yuQ5DI2BwFIg8Uwk0?=
 =?us-ascii?Q?6/hGysltA4XZQjZYCdKGVBgxbza1TTqHOXBMYztxuUYCRqbLHjNX1OHLjyKL?=
 =?us-ascii?Q?LbE9H8WW5zoqQlG2AgzK4Ep6fZB/jrxsgByUa9eQwdejzx1UTcRFANDXV6XD?=
 =?us-ascii?Q?zN/9fARq6jxpfz/0UbUB88NLPNS7kZ+bsV/GqOqO+tLPmyFhJWahuf3gXG/W?=
 =?us-ascii?Q?xHFKrMKUDYBEweIcSS3YskrO5x0ztOVp3PfESTaqKuLKP9pB5WKwxNKJG70y?=
 =?us-ascii?Q?s3rtZGf5xMuomtiHEgleY7E05hNgbLuXl4mehc6JlzPUu+O5l4oHQ4OrnsJS?=
 =?us-ascii?Q?NjzbX3mmSkuICSkpxKp7nY4+dBFaCc5e7nWEd/F7Uv6LsfNsepEWcjXWxQyw?=
 =?us-ascii?Q?HPpy+0gFe7Ps38z4FRDJCGcKPlKBfVGulmEOOqAsUe8GjGbCUNMXQJLUvaRW?=
 =?us-ascii?Q?8kDMvz3PFCMbWbUHjgh616+DQiCF9GDmUBFBTd+rsNDNDBDwNti8tMooxxWE?=
 =?us-ascii?Q?Agt8TweWJaj27BdlOZU++FwWZFRoiwpWS0G/bW9hGENjKrKar4sUIvcrVeC6?=
 =?us-ascii?Q?89aYDoCFn51YbRVVaVAVj/yVUi6pWD+fVGCw/b27mYv3ntvqXNzbcx37+Aa4?=
 =?us-ascii?Q?Zg4N/8uBfM69jl7zAh0IwLZVsEqvuXd1MdWJZl8EdxveXuOtdXaIVvJQz9dU?=
 =?us-ascii?Q?rgXxsijiY9sx70ur+P/uquEKi92FnzaDzKn2UacfmONxQHaBaJglZQ4511bS?=
 =?us-ascii?Q?qrVOOBiaMVa0y14NS/ftc1b0+hzF5LnDtvZ411ZcOoi13NvgA3ZHkSKHLSuM?=
 =?us-ascii?Q?zITO1H9enDM/xafnnJXuObZJynDIM6KI4EUaWWH5wJ9xNpUvbMw7sqhzfZG0?=
 =?us-ascii?Q?AQTYnZaf+rWKEmye48E5WLqHnT2wSbn9+sLpuvdSQWX7nKpAI8RR73hJY8pv?=
 =?us-ascii?Q?zhsbUog1pu5LbAavLqLLHvM+9PXPIKygP2PQcc9Z3RvrneWHynSYBx7c9iJW?=
 =?us-ascii?Q?QYNvwyJqcei5pPj75N6tL9IfsAgBkw02bdalD8q1sjLrBGLgIZfhZd0gkNDI?=
 =?us-ascii?Q?w4kliFAtQKh+omsj1Bgcovb69D5Z+J31Hyi9DSBll+6ZwXhNX+pNXxj1LY/3?=
 =?us-ascii?Q?Htn3DBxDG24kOWqhyEiPuKKowrxefCyFm6Y5dhjwTmBk8gKVeMWIKgGg1WXP?=
 =?us-ascii?Q?u4cIdiE0J8tqy1H70vm8mC/MH7etiQ/VKI1GdSioyneUzCYnB00RHBs2jR6k?=
 =?us-ascii?Q?c0ZSYitNhi0pXoF5ml0lnvnE3vgWYnaW8PGPrUkTNWBVuSzp6S/1Ll/tjOL8?=
 =?us-ascii?Q?75AnLpmo4fKsTr3IbIzNGixKUjaTtzaOY6KyHJUYY//cRhDUxUlc9bKDPgqW?=
 =?us-ascii?Q?GlHrRSc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rdxZit3GLDYOJsQDzYA9rfj2BshvWZjBd2ZyGTK5N2C5cBx0VjgPMExld4EQ?=
 =?us-ascii?Q?OufFqCt7++9KouStJIBXqVpaawGqmvUB2PTNDvqbGgJIW1pNpBhFGm6Dco8m?=
 =?us-ascii?Q?kPgCSzn7Es06wDFuPeZ1xdrt++5Dg6rGQlNj14JUM99f+3JEQs2nTbChHh2A?=
 =?us-ascii?Q?CEIP6VGj4gVyzQpIhK1pD9qe+QW1owr4hlkyYOnNYGOPTEn0DCGgowkBKghw?=
 =?us-ascii?Q?sIdRf+cBFmYfsT8/UouL0HRKrT6r5WPeuiWIXwWSV0vWAWRNzaNvq9++LhN/?=
 =?us-ascii?Q?MattPAVm2snWI4nR6CyjUhfTT2ndhBeks+hZy7oWAAuOPFhY/2/Gl1K+MW1r?=
 =?us-ascii?Q?yjQJb8EzFqOWCPQg25vxu6M/qaFtmyRHyd0CrtcPIzoezT8GuAY61d8cXHdy?=
 =?us-ascii?Q?CAaFcYeq4Fn65pZlpGziuEpRgwfQ3rpApEiFzvbVVpiNGEO8k6HUru8aM/jm?=
 =?us-ascii?Q?2whTL9ZBumHtWXv7ECC6jEpN1who+oXIasUgI26RSPaOSdx5pkJJVYqUtIB/?=
 =?us-ascii?Q?tAVnASdMCRwfAgnl8E37bBN0THuCaaH/anIZcpGt7K4d6En+W92YwtadKZEA?=
 =?us-ascii?Q?Kfb/x7WEFQFK8ommkMCTo8KCa+xdXxbSIc8pvNP2bvGn28tWlEYtMp9fhC5r?=
 =?us-ascii?Q?nyRhagaQETkokEil6V+aAudP5IjxP5rm3JLKSDEH9kY/h9ePMWty8V2yvN4N?=
 =?us-ascii?Q?BLkRD/HuQjzwMQBEuZ2XhpizQpGz04lH93Zqk1yZk/W2z4NQyYi5ZRQJhJbd?=
 =?us-ascii?Q?Pk9qRfd+oldBz0GZZrwwSxyzxKbFJdqRnwPdmnoqcXI9pbMFMg0L+33FZ3D3?=
 =?us-ascii?Q?4rfmxt/Es+Ykzhk7wzZR6WK0/HPuD7zTaGsBqpgmomICdr+Ps5mQeLSIFkUQ?=
 =?us-ascii?Q?7Ge8umSDR/OT391s7+Q3Wt7oTJwe6QOBWiINueyiAelnCuZXAcx2Y1pUb71b?=
 =?us-ascii?Q?kNy6hEN8g+G6dOoahgvLlUEdc4BcSrGOQDlrIRTQQHld12wt9u7+5viCxpsn?=
 =?us-ascii?Q?6CCJGFXMQJC7embeKwoNYkAVLEoBafY9CZt6U2pl9jIkeXUKlDOfHHS2B3PX?=
 =?us-ascii?Q?OjbjBDheTfL3RIN8qsMVpjF7kS6DDhTxW6YbaMnCR0X0Zb3X3FTO2qSZtz3z?=
 =?us-ascii?Q?zx682mzPTwHRyt8MM8d6Vq5RMz3qZm1hI6p36Ste06yr0DvfP9qYQP9YxeVC?=
 =?us-ascii?Q?uJkDiiBQbQR0kzM4d6/q7xCdmXUv219CRzxDexglQwXm+nZ0NMGD3rHC3/VL?=
 =?us-ascii?Q?3o8D2Mib0ULEOsPjYhDIgzqq+ulDRQMMiQIbYjx0Wo9SUN5sW7++Bh+eqXgA?=
 =?us-ascii?Q?7t3a9G6ThFmwrUIEFJIKZY94mtpaEzkxF7h/VEy3+pZqsWSrqNsHIV00vpOL?=
 =?us-ascii?Q?w+sc3chwmzVvR8B+2P/Tz3n3hL70PxHk73PFbL+VLWd8cYd3dVIWvcQ1PtMH?=
 =?us-ascii?Q?LYYiwokYh17HZMg2ZnLMTfnrZxiJRIeDegjh89L71fdXqZsPup6h4eibrF2M?=
 =?us-ascii?Q?8qV5J2dNk0YjPwKy+4Js/+SIjef5+0Lalf8NJd7/uMt8ohCsZGY4IyvSXXU6?=
 =?us-ascii?Q?EPRxTPV3uwRoOX304CJ/8luvSLY3sX52F5LQw1cW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6811ac2-26a5-4989-0516-08dcf1ee5180
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:35:05.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXaHvuU4HwDdDigLKhso3j8/s3Qo8r4VDApyzzBxRUb6OLT+oUefJWxIj0buU8bVA1UmnHs9Y80fW/IPhGXNCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

Add flexcan1 and flexcan2.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- none
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 0d14b0def19d4..e9342bf158489 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -57,6 +57,25 @@ reg_audio: regulator-audio {
 		regulator-name = "cs42888_supply";
 	};
 
+	reg_can_en: regulator-can-en {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can-en";
+		gpio = <&pca6416 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_can_stby: regulator-can-stby {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "can-stby";
+		gpio = <&pca6416 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&reg_can_en>;
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -337,6 +356,20 @@ &cm40_intmux {
 	status = "okay";
 };
 
+&flexcan1 {
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_can_stby>;
+	status = "okay";
+};
+
+&flexcan2 {
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	pinctrl-names = "default";
+	xceiver-supply = <&reg_can_stby>;
+	status = "okay";
+};
+
 &jpegdec {
 	status = "okay";
 };
@@ -567,6 +600,20 @@ IMX8QXP_ENET0_RGMII_RXD3_CONN_ENET0_RGMII_RXD3		0x06000020
 		>;
 	};
 
+	pinctrl_flexcan1: flexcan0grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN0_TX_ADMA_FLEXCAN0_TX			0x21
+			IMX8QXP_FLEXCAN0_RX_ADMA_FLEXCAN0_RX			0x21
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan1grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN1_TX_ADMA_FLEXCAN1_TX			0x21
+			IMX8QXP_FLEXCAN1_RX_ADMA_FLEXCAN1_RX			0x21
+		>;
+	};
+
 	pinctrl_ioexp_rst: ioexprstgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SDO_LSIO_GPIO1_IO01			0x06000021
-- 
2.34.1


