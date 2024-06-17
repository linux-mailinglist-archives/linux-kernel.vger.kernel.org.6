Return-Path: <linux-kernel+bounces-218169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C08290BA0B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206722852CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DE198A2E;
	Mon, 17 Jun 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nsv95fWJ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300E16191B;
	Mon, 17 Jun 2024 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650052; cv=fail; b=XQSbiSBkfQFbSXWtuzjMXJ/patUk7VL+stfw45Ncr3dajquGerouUYYu4Ooq+cWsqeSJJgF7/GIiP83KbDLcGQvmV1CMYSOOaFajAEE2UHCKFkj7dqoSBdf62cAsxPk3gVtd9dyNehfR4T0R0mwNsiF6EXevD95+OAtC2sxb7oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650052; c=relaxed/simple;
	bh=rM63J+JlmrozyBkWKCHcvcVNm9/xlsdIW85b26Nmw8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=W1fiOzxNBXk+XEH+0hp9IE8121r1vr8fvIvfF58ctB+idBUHFn9AzxQuI7HFcLLBr+p293F4dtcFv1jFEKfY/Oej/mMpLAiZHw7lizi42JSpgX7Hg3cINQD9K1RpIjQ/x+CZLpX7UmBJqdsSX7+ZS9wVrojlHhcuZrfakpqpfVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nsv95fWJ; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAJpUDMLB/Pe4SaF6thAO6cgXWtgAj96briTfkeaSqEB5h7Ab7enNFAj5W/Uyrq3Okl0s/xAzXJv5Zhx8VQzDLuLI3BAEsXBaiv50kj9PRvTOd8ZPAD1WoOOrGiaPykIt5icJKvFMfBsnVx5+3LpLGyz2/Gx4S2U0By29vo++xfZAwUplHikhBbc8Mnrglbnt/FNpEM8523ynKB+SU3qlab1eRVhz1Z9AJcV/VdDHC8LVlckYa4gsYfmZQFjIXeWDHL6bjwo8xrzOU9+L/tTl+wdXdc6fah0FXDVN31LHehE9BKfcCXeiWT2gyX42uXJE8reer0YNVWFIMcux+OeFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vFgAWhByQzD5qeTs2V1t943n3oYMOv/Qc2rrEC1Y2E=;
 b=RI1htTqNkCn1fcp8hMo01+4KC2FEJ4n0u7kkgudhJPJyuOgHsCAE4JBccwIZFqxSEs8m9HBaXKUz+ohgrG1Vy77bAVT+2lTdV5vk47sUVzTkYzPDccIMFL/ESi3mArkZSNoVan2/tZJs40FcXiJTz4yc7bp+Znr6YR8ohgNtWiv3VvNFtthK63W8Fj+IPpt+XTxQdlMbLEjRM2aJ3xohdpOyboERkt7MMxLNH+J0cCqwxsjc3Cp4ELFa59vmhQI8lgWZqzqaO9lBmzQWI9J0Bb39bgzRaqPHdEDwiFbQD/b99xDBsc1rGGXArLzLSiuQrNAk+Agupp2qDfb8WNQ7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vFgAWhByQzD5qeTs2V1t943n3oYMOv/Qc2rrEC1Y2E=;
 b=Nsv95fWJFF9SOe23TzH6idWwOkjTO/bhM8+NGAGhPDonWJjJoQSGSDfMWC3MQP7loYm3fcN4XmK8ZZSlKonoIHz40K1hNNkQZAXI7ggvJs1RgFDaqKSX3GGSgWBUu6hAb21gocx7dmINFy0oT7PKy5EERlQ1NOaWZG7ffvd/HjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 18:47:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 18:47:25 +0000
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
Subject: [PATCH v2 1/1] arm64: dts: imx8dxl-evk: add imx8dxl_cm4, lsio mu5, related memory region
Date: Mon, 17 Jun 2024 14:47:07 -0400
Message-Id: <20240617184707.1058995-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: d5843859-b603-4746-0de7-08dc8efdee5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TSuGbW37k0VirQ/CWvbSq4Fm/XgSpwgXWQBXcMjkxzZ1UZyWPRtxf88ZEBQr?=
 =?us-ascii?Q?Bt0kDBUfm88PYDnBpw1KJFjTeiQ4XTfIJYvFJKBqhWNkbpQi4Wm/myCbHNxz?=
 =?us-ascii?Q?C2FtinniFjHV3PP55NkoJBbSah3H1taByYVBGadMP0SStbiR4om6Q+E6YjTS?=
 =?us-ascii?Q?9McbaeFGYxeRPEHY1Rqj0b8v0PelICUDKXYNIR6TZduk7JTRjK2EJ3z6/xst?=
 =?us-ascii?Q?phYnqniyVVu50CoaDr2tnzVmH+spA2231nMoHw8jC0F6c2Zii5pNhpXLUrvz?=
 =?us-ascii?Q?fP4Bna/dfQwpa/XrdAemtJuT7jxv18t/a1JTWUXgaOA9I2LYl+X9dI8SO/e3?=
 =?us-ascii?Q?40SI/w4bk+hcszUhofcIbRJvdykhsYDuePneW3/q865O0bR5H28JV/sUEiSx?=
 =?us-ascii?Q?TDyCqCSpZ0noUWDNxhljJibOuLj4AleSBBUNqr09ehD3K5cjjdqD+3ilfF9V?=
 =?us-ascii?Q?opoiBOxTgUVoe3f/VN8J5cwdWJmjolb6WiB4ExxlF9rl0aopII0YX9bLX6/U?=
 =?us-ascii?Q?t/trSA+3r1Rtr28xsEbfN1NztNegp7cxp5AFc7hNyGyV4mqi2CAUZ1Ua4+3k?=
 =?us-ascii?Q?36gQaAYWSYirHzAeTS4PrKsHesn0rTqb+1tVOlTJhExSdJ6ZozG+iAGRkgyN?=
 =?us-ascii?Q?HacTJ0c0Z82sDImtr2uVe5ruJSlaQVwVY5fX/vtk8rlYdvvxPDjP1PGMXwH/?=
 =?us-ascii?Q?1QOcnXcmK+PtqXkctyahXjbrtocm46elErpFf1gkPDu6XpIz7UZ6wEHKXDSF?=
 =?us-ascii?Q?bbuu813KLU6mlq9RWc+A6vxtauUgW6huO3l7rSjRaJhyE5Vm/FJS6P4f/cmF?=
 =?us-ascii?Q?0qA/QJ+i71+UkOwbhTuyagGuDtWSZwhH/MbmtKNavUWM3l6/VWDuyp02rv62?=
 =?us-ascii?Q?O8soeUeindvm4HdFosxMNiJK6F6McR8ePn3cVCxq4YZxYViFGyVuV7lgpr0n?=
 =?us-ascii?Q?hPiaytdJbQ8Akcb5gDIlk+bfc57IetAaFCWNv1CZKHR8w5650qvpKd3dSEGk?=
 =?us-ascii?Q?lUHDCMu7gt57xs8twBpniVGZDyx6fx5ex4JMpS5O1KvwD6nDu5wLgT7Io53K?=
 =?us-ascii?Q?Xb43RrTkqgQzZGzpHIyzdqYICzy+EE7oRAJQ7ATnQdTBPVgiAfElMR1uq5K5?=
 =?us-ascii?Q?v5Ci3Ieq4UrIA8PplzscmUmktK0QTMznPv4Q+c/Y8J0BtMoWgVbPw2WGfH4+?=
 =?us-ascii?Q?GFbYQnABkYO1M08smL5neEjOeRz68D9QKDVNHaKAD2t4p8+NvSdNfiMptGmc?=
 =?us-ascii?Q?AD6QFnrV0sS57kZ8HmjzUVkxfvUyqVlPbxPVrAs3jHiyqIfPQge3BX6ihwSm?=
 =?us-ascii?Q?bDddw1aRCBPHpOx3MjOa7jtzRpPxGnFQ2dEjPJ53MB4JHtQj0rgYtvmY2chj?=
 =?us-ascii?Q?/4hASlM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y79IdXPXlfEscPUCMs9XLtvXVWUDOeeZw7LhH10yenzLj8oYf7thfG0UUEmW?=
 =?us-ascii?Q?hMDeesG0/lUqOsFJBuhv6vOaH3b3CW/n9zpOz7cAzB4XMpOJ9CLYyUOdQFJV?=
 =?us-ascii?Q?IhOLkHZ0N9UVsbWBd5gO97XlmLn07DWmTXBcyEZJKfFkqisEHsVbsgLHj2P8?=
 =?us-ascii?Q?HwoIo06maxtpJRtAnWIzGX37R15R7GevuN5AgTCGjQTgEXkAPREOdaOwYQkZ?=
 =?us-ascii?Q?PILxhJWh3fCfFyRQzNWx6u0ErAEfuf9/r2QwTyZByyqVwM1weYqa2kH9iTZM?=
 =?us-ascii?Q?mEroyTcA38bbJlp2WgMasCbKqdz5BftkQYhhnJyVeusqHLksG74Ef66ILxto?=
 =?us-ascii?Q?RRzx1Hd51/vZ2ErnOAzTsxMaxB0tLmpXqIFjwRpHVNExQlXfONLJ2CXK/9y4?=
 =?us-ascii?Q?PlHMKJ6omypaUAsGhZTSX5J8s2RQxUUgbxByOtdcZ7pki1smeaWbQzG3POhQ?=
 =?us-ascii?Q?ipZfBMzhNqf8M7x7sxzi9gzx6+RGfgMogQNkW52oOQctaYzCENtpjYTDJZ9F?=
 =?us-ascii?Q?r3zNk+2rPUlvy2+8+yDGQgiC/Wv7yg3i59cpZiru7Hqo+Kd4rDLz4jm/yKvi?=
 =?us-ascii?Q?HOBn6PI9p3MJAT5wWZhDurMyNRA91Ctb9R/1SP7+mVQx+AIV2yN4i5kISUWi?=
 =?us-ascii?Q?z8c6rXtH6FV+xbpUWv7qP9wSdwuazaUXY/y3nckzvmwEYSjHGuPrizwUa1FT?=
 =?us-ascii?Q?Ghy6jx4ufdj2HiRj8bJZUAdwfMRe+kbM1HbpqkIrHYl9NVz1Y7JoO8kg/dtI?=
 =?us-ascii?Q?jEk0ciqoN2WmHMMVF1dC5wAK3AAWaCYVFwpeOzk8hi/g9VhukB4AVpx5ayoc?=
 =?us-ascii?Q?02eTZ5wJdwAOvgbpUT8VMHpaXvRY6HevRleW+VZVH5WS75gKjQl0yeNwc+nE?=
 =?us-ascii?Q?s1gUWVUtdrv+zsEbhMOwg+gFXK1TiDPIzyg0YrosSVpUEeacAqQHPdwLCvSO?=
 =?us-ascii?Q?G9Q/4rnEv0NWb1eZ6XY2YuCZWi3tG+XFz+DUXSKf/mfjRRDjCIfDJFr2cpEL?=
 =?us-ascii?Q?nzhQ6Emb4CEKe8yBNfvMU/Jc0MlJtGQpUwLLKg1B4xoDSdZP/SMza5miyrc3?=
 =?us-ascii?Q?iGor2SlXXWEye2JgpuMeyqKpwLbqPzeSn8uDUjyrfwUhL72JG5X2cXt6W/lY?=
 =?us-ascii?Q?YuWHslMlw3pYj8LpuBFxc3FvxX1+L5gyrxmAkZsLqP5x+cmed/4lu9ow0rLD?=
 =?us-ascii?Q?CJLz02ukrM8FpwGxdwR0n+WrG9LyeZctIf7Mr3Vb5naDGcBSAJP0Ec6vBsmp?=
 =?us-ascii?Q?yQE0v8QLHIBwsvAlT7UC8kDiYur5Dp/WZuwq5rIzOC31vt8jlbkyXEXIcHQI?=
 =?us-ascii?Q?WlUyasMhs1fL3MzW1GgJIbPZalKRxQb8YytSXrCqZ/Gd0VBpFEVR8+tN3UU3?=
 =?us-ascii?Q?Wq6LF0VpALLq5WwkRdeXTiukb9Fj+esaQC2wzqyrwsO1rRSW791fd9Ru4NWJ?=
 =?us-ascii?Q?0Ql+a4EBLk04oOKQ0YmX+VWhIMErpLa8XXiF58GbI2kZeWdcDDEj/m4gI4f5?=
 =?us-ascii?Q?iR0dq21gJOv4+1h5/5DpR1haGY3Oaurx+n63MUPAUydwL262pJLvFFUQVx2P?=
 =?us-ascii?Q?Tq54nfccBJPX74zacgACiasJc3Xxq+XyOCURqdnB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5843859-b603-4746-0de7-08dc8efdee5b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 18:47:25.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hph3ok9PV3P6OpDgb7acDSB63x/T8Y9PzGZbn11hZOZMkGb/UFgAJWxG1kubYTfFItLGcVS5p1vmcUwh59wgvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389

Add imx8dxl_cm4, lsio mu5 and related memory region.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- change to memory-vdevbuffer@90400000
- Add Peng Fan's review tag
---
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index 4ac96a0586294..1a74ac3ee4ee9 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -24,6 +24,19 @@ chosen {
 		stdout-path = &lpuart0;
 	};
 
+	imx8dxl-cm4 {
+		compatible = "fsl,imx8qxp-cm4";
+		clocks = <&clk_dummy>;
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&lsio_mu5 0 1 &lsio_mu5 1 1 &lsio_mu5 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+		power-domains = <&pd IMX_SC_R_M4_0_PID0>, <&pd IMX_SC_R_M4_0_MU_1A>;
+		fsl,resource-id = <IMX_SC_R_M4_0_PID0>;
+		fsl,entry-address = <0x34fe0000>;
+	};
+
+
 	memory@80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0 0x40000000>;
@@ -51,6 +64,37 @@ linux,cma {
 			alloc-ranges = <0 0x98000000 0 0x14000000>;
 			linux,cma-default;
 		};
+
+		vdev0vring0: memory0@90000000 {
+			reg = <0 0x90000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: memory@90008000 {
+			reg = <0 0x90008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: memory@90010000 {
+			reg = <0 0x90010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: memory@90018000 {
+			reg = <0 0x90018000 0 0x8000>;
+			no-map;
+		};
+
+		rsc_table: memory-rsc-table@900ff000 {
+			reg = <0 0x900ff000 0 0x1000>;
+			no-map;
+		};
+
+		vdevbuffer: memory-vdevbuffer@90400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90400000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	m2_uart1_sel: regulator-m2uart1sel {
@@ -505,6 +549,10 @@ &lpuart1 {
 	status = "okay";
 };
 
+&lsio_mu5 {
+	status = "okay";
+};
+
 &flexcan2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan2>;
-- 
2.34.1


