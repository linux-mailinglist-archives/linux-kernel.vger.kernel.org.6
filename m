Return-Path: <linux-kernel+bounces-373586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5417E9A5917
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADECB22327
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD31CF285;
	Mon, 21 Oct 2024 03:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jRX3swmV"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC231CDFA6;
	Mon, 21 Oct 2024 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479910; cv=fail; b=G8vE+kJi6+fgEXblbp8GtzPU/R+ae6y5tsu5jxpMVXikzYGfkAPylNVT9pvLEK4fKjEJN2C9bd74XluQ82LVQdjvbGMFN/5xF4EOpdGwyz7izf11mpUFn7jSWSWu5WwwyjWBGyF49aXMkeHIQd+2z4PJUxOJEXpAuOVzbm2ukjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479910; c=relaxed/simple;
	bh=cdAEEWws+JkeUZcal+b6iYyygIMEbd7DKHynd6Cxf2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pr9MRNTABXLNA7zY0niJUNLd9V1JZVCgodjAOY4HC/g3fWxs2hZApObgLAd0jw0Fd/sTCKGJVJA0hDpqM2NCeBMEUU/d+SoMSFlYFMr10x303FVWbTORJawx476N50Tjd8B3yrxUwyS3hv0D+lrywPeG1+UhkMpEfexpzftD0P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jRX3swmV; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQmrBUv3GDYvKB9oOyhIfBmYiQF6gKQXIQh75Xg8/Ig2WdzXd4kdOs8Qw0+eTt+Cg8vVYxE/m9k5gvritevjDXmyVSvtZrz1K8s9quHiPPeaXN81T5zd/fxxf13IswVfmhIQuGU/1Rwr0zWPTWVLeygUzAXX96+jV7MOspSTVoczenOpAlQIlLU+AX4tpZXeB280vXDo+UEdi38t1XDfg2EiJ0zOtLLMijaDJqMeoP6Uw++MquBGUwpejQKDzvgjpf2mOBuLqxXVTR27DHd/FOCvAJDc6eYysZ2Hb0h2kOVTIw2jJNTXJ2IqTHUMBGQiB7JPNF0qgjLo6KAffsOchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWfkGWCM4omQW1LZZCyIMtAhRUatw2CUbJlzGudBkk8=;
 b=FHYqSfs7YXCjt4UwdL4Ye4Ob/80Z9PCPkZWSGhl8Fds5wKbxbgqD5OTjOdjDY/CBQ42XL3W7zU2Yi1Ftd9rUdhjN1K3bNwGAX/W7syRuGv/BXor5P84z6vLkV4ga6ZCLzSolYT/Eslj5RTXvJntPZ+19vY4NDxTYIEhtOohAL6ceQVa8Yv39d7ZBIyIvFtSPqmhLhnJd2ZN5hZQyAm8udkjKDjYh3qGd8ZUJLZPPBdqs2OahgT49AfyRWzNtc5USqfwhnJ5YVsGdYLtMTbXxbkiY/JqoeXplSjHtO7yVp4wynkDUmDJVvJxJKEBb+ATF+3oxQ9+Uvq/n0OBVn5lijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWfkGWCM4omQW1LZZCyIMtAhRUatw2CUbJlzGudBkk8=;
 b=jRX3swmVumxIdeP7Ord/9ue6wlvXDc36dGjArEVIpZmoB5wRwU5Q+r8h2zdUjOpWZIOOkxNlGikZg0u4VAqGuhh4TrdbfQv/OH1mdr5szKaDDXjRoFxr2P5svMJQ6QhOoFHymLJbL/F1cO9HByBYbtwzxFZJt0wp92xU1ElPv30UUrT9zSlAcPAU5ikSbMlsbFhfZtZuvVJ6TC9pJREQZbLfJUH45C0gLLqQBxj/HxQ40qAA0R/i1SFffh0DCumSaasinwFRRyVEBU3WeQvT1jDf2K/ahWoqN4A/vbnlZNKtKAspGDFkEWi2vKURnOoZYFoOhbZiLhJx5H7rr/Zmaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by AM8PR04MB7811.eurprd04.prod.outlook.com (2603:10a6:20b:236::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 03:05:04 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Mon, 21 Oct 2024
 03:05:04 +0000
From: carlos.song@nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com,
	haibo.chen@nxp.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7s: change i2c compatible string for applying errata ERR007805
Date: Mon, 21 Oct 2024 11:11:48 +0800
Message-Id: <20241021031148.2682015-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To AM0PR0402MB3937.eurprd04.prod.outlook.com
 (2603:10a6:208:5::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3937:EE_|AM8PR04MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 6474e240-738a-48e3-f0bf-08dcf17d28fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fx4IOlSj7xVEt1RW2/d3AqeeL6MMsRPmvneMRmuBIi1/mxCDhU1YC0g7WHop?=
 =?us-ascii?Q?7WQ85JegvzOTIpEl5UuRotQZ5pPbO5e4iAZgMAl29Tgl8uscqacsMRBM1bJt?=
 =?us-ascii?Q?GAdrBvpHyoB6rtNN4U8B8m7jJSCBX4x90xWy+PCpj9VfKcJTBd0fbbN28dE2?=
 =?us-ascii?Q?1QwrDYAsFYhz2Db4/hhr1tZX270G1IBIGoovLRaohdX/LKg1DHakdP0CP9VY?=
 =?us-ascii?Q?tE8arFVf13iO8cVSkEdlzY+HNDyusB+9LGxLT9PvP3PV52D8afkgj96IdgHa?=
 =?us-ascii?Q?SJQK737gVIJJLKguHk2+QWGT9PrG0S6/NIGOYz4LpJslb0fQdPfG9GsfCGaK?=
 =?us-ascii?Q?2z1c0GJpADWJvzuo3iO8P3j3uc+r7XfQy42bVQB4pbq9URZ1qmD44TOjTJsK?=
 =?us-ascii?Q?O9W6gfmrg8Hew80w0SpRX/Qtzbl2Srqk7ivGbrTaBgGwaZA+7YmkK4zFo0Ik?=
 =?us-ascii?Q?lt9sz/ByalTmh7N3/34XK696lerekOcKiNWfvgOjEdL9vrjfHbAaAkzuRBle?=
 =?us-ascii?Q?3MYCkcoDd1IEnZUnA8k9vNgKBFL16uDg8j3Rv4GCp/63QXQeMPmVAcQuJGS5?=
 =?us-ascii?Q?KN4QWXvUESgA3E0b086Swo/jbSqM/DR/apfibiCQrwu6E+3oemBwWEeDYjLC?=
 =?us-ascii?Q?sbloxoglWuA1oOZNVXJQvT5wgF5Jq+om1tz3gpmkjCjJgIE7xwMFW4SvkEBt?=
 =?us-ascii?Q?VflLglnzcNXbHBKdL5t4FOgsizqAlMHHz/gTLVgxzkPkTlTXOU6AnMeWKQm8?=
 =?us-ascii?Q?Qea4XVwe0fxEoA36YQui/U7FgV39bBLfRPFHtZbs50XetNIiaSI6Ap+/eAX7?=
 =?us-ascii?Q?X/VwpqsHLhzKXeXNcz3/gIHPVKtk1AW2Vulf+ORN/48MIaM8DZabYpKr+ZBb?=
 =?us-ascii?Q?OnsYDrQ9T/9EV5N/yBee9jSVT7ykT0RdD75Eu9gr5K5mx09mv8+YXubm8jMM?=
 =?us-ascii?Q?0z2RJkkcx2zmldrESsK8Sp26P+t4ILwbqOHvdCWQgILUp3GUzE9VEq4QV+zE?=
 =?us-ascii?Q?zDLN/zSNcS4iV9Idg6itlm0E/iMebtN/xsCPmdAetvG2+VFl/5RBP7ffxFan?=
 =?us-ascii?Q?y72y8GbCgE9m3ECaxrkQRKxoiuK/szXv2Hg2Rgo+y3Wp3ce/cm2HiASMfJBW?=
 =?us-ascii?Q?p5sjShwP17QWHS3NyWeUt0LLIcKii6cQxUOkQvYslKnCljcn6yVxfjcLARV1?=
 =?us-ascii?Q?EYMVfyE2e66v1WivRigKDRI8iSj+Fb70bGBLkg0grdT/y8trXhjEmpBLXygg?=
 =?us-ascii?Q?phh9kou+lqkPp6VpIbUkPIushmscAfNhTTeKV8LkiXY0S/Zd4gIsxLPjyB0R?=
 =?us-ascii?Q?ScmNF3zeUQ38/d8VNoNvR5gklzUzdAP4951Zl98oJAVr8aOkB2DpKU6tLVN/?=
 =?us-ascii?Q?+XTjPRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqS8/irslL2A66oTkc5PTjsQ9GMTnHl/wcMtnFD9TlVV88ZlpoGXHjFvmP5y?=
 =?us-ascii?Q?Cgi+VBLk3rGecXuTudBISVuGiNtJNc8qzs8SuJKI2W9J9+4eCb9hCzJlFnvu?=
 =?us-ascii?Q?LW2FSCXLlS0JZCdgqF+fdzI24tVPOVIRogfDVYGFfAYqE1CoEOCrFEhozc2G?=
 =?us-ascii?Q?GiCOuUq1lLKh6ksDW9RsBwq1bUKoQDsRyI5aLLexC1Ebu9EvHIzxpozSNp8g?=
 =?us-ascii?Q?MaIC7Z+s2dSILP1Ede06geRXnGh/glyUHcUx3p1TIue81tKhD+DzepYpZuZk?=
 =?us-ascii?Q?GPcJC8DCBA0JADcb8mRZ79lZcqjHFT/vKJpbsClpptqqoafbsPeN90DJvDda?=
 =?us-ascii?Q?rGd13MD9Brn8lIxlyBmvD0+3QB//1KonG3snHZvuqJvkss7HE4wnP6lhYKM6?=
 =?us-ascii?Q?R3gCSRyJGzqfnXMEQrIwOLQKE5fUwgzLcnLy9ngawyxYHdkOUVx2S4sSxkEx?=
 =?us-ascii?Q?6DmKW/IDIAU02L223MdyKtUw9yiVWmxXoPHJfCPaH+RRevuZwpK7GsfnJrXo?=
 =?us-ascii?Q?fpQvm7KBQaPXJX1dOnT5uFdsK7fhKXRQpnvq51zb9Hb+G/ul5O8DSAOdkrG0?=
 =?us-ascii?Q?o1uiXLjTtw3Mu3qFAJGrHD+SMy9Y08z68DfCGBkpA3fiMDmg+rwH3KoTcjBj?=
 =?us-ascii?Q?7u6V99h4B2oocDXN6UzYkZQog3pBfN60ZgfVnQV9L3HP064+/KZcaCXRV6uD?=
 =?us-ascii?Q?0j4hO1DrYDO9OE5/ZKLMc2OYqofqHmeQa9nm+P1qzOJvi5hDbyxLP3uIvGhZ?=
 =?us-ascii?Q?0ufGuyBL38XYF8zN6Gga60ObwCLIpG/WlNKEtdkc2mmCTOIutDbu83TIzuHW?=
 =?us-ascii?Q?Bkyf9cxMxGgErGPG5TVlUsrgxSEGJ84dJlVWYrBI9jAD3zRIhOe8DJ5RkZ0I?=
 =?us-ascii?Q?4TqSeDjIphhiubxZtWQTeQg5gZdbCKlq8jLCwoEQ2386WQYDnHiIuP/na38X?=
 =?us-ascii?Q?cN/7pBna4u335z6CKcsNgQ0EukFnaTF0dpBL3Zir9sZqXBmFby9rWEZnn28h?=
 =?us-ascii?Q?uG/kQsedUomzQ1jx4fZlMAHG5lrxLW22iqA8LE5HJ3HqaAG+4qx7w+wHohDP?=
 =?us-ascii?Q?f0gq5kYZL6Vwn8aTtSiU0MZYKTo39z4lxO5vfpkwcLLSeVcMI74kMa4+PQiR?=
 =?us-ascii?Q?msFybQJZdsbmLTCXHQXALAPVDWJVcbtOLz3IloojmlkbzuJO5drNzGIE8SFX?=
 =?us-ascii?Q?zIPkaLgCSCIM7K3oUUn4Jdf/5rwAva+6HmI34Qpd2XVZfOUd40nKxTF+kRVC?=
 =?us-ascii?Q?AyuNyS6p/7QPWWmfjAPFqSQPA2yPw1abjsiFb+7irrXcXWr1TgCh7jzDoIkA?=
 =?us-ascii?Q?HbWFUQFr7G3Yrgyyalbxds0jUYooP6kFoqTpqiLAUVzMl1OrWsRGSAA5oL9b?=
 =?us-ascii?Q?UUVp0Q8Gv294dj+yKNF9tD+lTHmcJ88zJx99676lKTuhrjz9oe4wsagrT4XH?=
 =?us-ascii?Q?N4xSKpBktuihzBBDIfaJTaszuBrUwVP4wzLB3P3q+461CM1OGlIMKCxGBt04?=
 =?us-ascii?Q?TN/mPduTui6FCe0dfHwpLou1gq3wXP2lcUIKDiA+gN3Mr9/0Zjqpcl1f0K1N?=
 =?us-ascii?Q?Bczd5pD+LKNnyVFvc2T9g1xyMP9tGLuEpeM8VZlv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6474e240-738a-48e3-f0bf-08dcf17d28fa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 03:05:04.3041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O6Dl4D+2MHCsMRbYYqvFnoHui61R/EoBCo3k9A0vVnaowvsC4c+84SumRmOxc+mPrTw6gZVeohXvUBOVcnMQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7811

From: Carlos Song <carlos.song@nxp.com>

Compatible string "fsl,imx7d-i2c" is not exited at i2c-imx driver
compatible string table, at the result, "fsl,imx21-i2c" will be
matched, but it will cause errata ERR007805 not be applied in fact.

Replace "fsl,imx7d-i2c" by "fsl,imx7s-i2c" compatible string in dts
file for appling the errata ERR007805.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
index 22dd72499ef2..6a1d8350192f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
@@ -1087,7 +1087,7 @@ flexcan2: can@30a10000 {
 			i2c1: i2c@30a20000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
+				compatible = "fsl,imx7s-i2c", "fsl,imx21-i2c";
 				reg = <0x30a20000 0x10000>;
 				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_I2C1_ROOT_CLK>;
@@ -1097,7 +1097,7 @@ i2c1: i2c@30a20000 {
 			i2c2: i2c@30a30000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
+				compatible = "fsl,imx7s-i2c", "fsl,imx21-i2c";
 				reg = <0x30a30000 0x10000>;
 				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_I2C2_ROOT_CLK>;
@@ -1107,7 +1107,7 @@ i2c2: i2c@30a30000 {
 			i2c3: i2c@30a40000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
+				compatible = "fsl,imx7s-i2c", "fsl,imx21-i2c";
 				reg = <0x30a40000 0x10000>;
 				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_I2C3_ROOT_CLK>;
@@ -1117,7 +1117,7 @@ i2c3: i2c@30a40000 {
 			i2c4: i2c@30a50000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx7d-i2c", "fsl,imx21-i2c";
+				compatible = "fsl,imx7s-i2c", "fsl,imx21-i2c";
 				reg = <0x30a50000 0x10000>;
 				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_I2C4_ROOT_CLK>;
-- 
2.34.1


