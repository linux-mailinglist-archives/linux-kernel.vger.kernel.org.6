Return-Path: <linux-kernel+bounces-349431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D232698F5EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605F71F21F12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381811ABED4;
	Thu,  3 Oct 2024 18:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GVv7DvMq"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B461AB6DC;
	Thu,  3 Oct 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979373; cv=fail; b=rzD4bTyKTfLqPzdDiUe3lHNiPn3bXYFOmglXVUwMrgdYHTQHbC3WsWH/pD6JjSduiOMRdfAc5p2UHXIqbTZCRa0L3A8WgjUvkbdrkKMu/UEGOAwS/OJqSXHrsvrGBliPlBIak8Nse8oR/GCyosXlNZe6PBRUgODzVL19zu6HTA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979373; c=relaxed/simple;
	bh=8vs9Ss0lSTPRcSKBr5jXw4/pZTNDmWYKApbMUDGNEY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rRb4uxqUALAy+cO+SE48oI1ffSMlVoQwZgIdk/dv7G+vA8DBX2i0wuRYVLzoW7+YvRTqUOAio6krjhzOmzkkA4HHh1pRpmAnkuFZpDesMPtg/Zg/tGD/pEC3yPA65AQWOnjRwGswA6F9IebyqR8wbOhi49h0MJXcmrR3Gxab2m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GVv7DvMq; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj97jzRiESDJ8DLZXONcZg3N0YbrWsZXki3EPiDSLC4n+2V8gfD1yOORfJiv2k3dfot7kX2k1dj80fCayTEkrG2f8hVnsP8/ez0mGqBhIBI0c9o1drwZJTMixoH7m2DVqV9EQMfG5OlLxBhkTJHTsCgJ+8H3Rgx9SCasjMAK9M0F9vRW8pk/sIjSmSh7V49WucmCsT6kfTeBNvz7TTyxp5+8CSCqrwTK1YGmSuG1cS+4RWakY07tz0xCu/ilax/f8NcqR5l9y+z/lmCVHA3s/qPHl6/FpHoezHK1o8DOrwVJALFfBM+soQPYc9aJONkqK63Cols2gt9t7e961qmjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6AijFCh1A/p9OE1RQ3JA5DYmgi8UbUn07cXAg/Og04=;
 b=wXZDwfMZSotwz6ohyM2omeTmtLG2B6lLdH7ikOp9Pz9uaLvGp9qPvSmPMHSj3yYjaZPh5xKYweR0hOlSkIrEZrV0Np3qmqn6C0kmkUFbH708Cseqh3/1sOgJgvecou3iS9MyJbUpo2wNW54KfGFBHqwIRF1yHysGuuu9uVgbotEcSgrwV9aYu4nSL3m2OaBX0qesCWz7Nue/z/USt7gVuzdCUZS3VYM5ztEhF8CTrt1r90w+uVtaU2BjIyx+bS6+10qaLDQxaxHljbSZJRGTIxtiJm96XlwQqBQgzSj/WUm7nKJ987NFIWxxINOl6LhA7uY7gIMkjHLRboH5FA3DCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6AijFCh1A/p9OE1RQ3JA5DYmgi8UbUn07cXAg/Og04=;
 b=GVv7DvMqgJ0THszaaw18AkV6HV7yZzUVYnZ60TgfBAjLJ+nJAtP3Wu3WKP/O/YcZljZNTcx/8WP1ymHXUwQ1CFnqq0UNYgCVIBRmlXcFA37Dt0v679THj/onnUNRbfi4iZ8Qi0RupTNNeLRxMJwc8ODi4d+BnjW+uyV2yP/Dm9o8FTDpU6Z58n/Wuwq34MkKqmcPOTyw6HNLsOd6IVMmoZQ1U8+35SVK0lHksRBwSkAZaZ3uzPkhTK3FQptWLTpToSqXrqYQhhv9M8WlwFnxAXptrKjIoWYbbIhuK3YqyjEjTzrSty1wEmva5Y5rYIHOovjhOzPqZf1o4wtxhiP27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 3 Oct
 2024 18:16:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:16:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 4/4] arm64: dts: imx8qm-mek: Add PCIe and sata
Date: Thu,  3 Oct 2024 14:15:40 -0400
Message-Id: <20241003181542.620461-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003181542.620461-1-Frank.Li@nxp.com>
References: <20241003181542.620461-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 561cc572-c8e6-4cf6-38e1-08dce3d774eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0hPZjMcRIQsMJ3b7Fng7A9teUONvS4VdegxhTEXz2IVDhN5/dFY3tG3d1zYG?=
 =?us-ascii?Q?k/GjV7T2nNPIQfMwfFTBlW4eS38t5koYw/UChXnoa1AZjdzfWMFkihE/J8xp?=
 =?us-ascii?Q?X42CywPayqAgCY9jMVYYTh28FQT9GWcQBQX2iA04ifIh4RWp81FsCIOGMcQJ?=
 =?us-ascii?Q?n9zcWwu6pzqK6vKWUc4DHHYpS/KDq9AYbRgEsz4lrZVu5YQ+oTM+DhlbH8/P?=
 =?us-ascii?Q?GvmxB4JAfBfBxvBt2XQFKnEh/PmXkPnJNS+TTKt0oSG6o0gfsOxefRAEGM5+?=
 =?us-ascii?Q?RsTY4NQFPrFCODa/ewN3ksBmSZGzpKG63xHByFmq/HFoXpzXEcmgBz9jzz+R?=
 =?us-ascii?Q?4/PrNIm7o8bK0WIgeSJzEu02neEPKtwrimjwdnIRkJ9pPicRj6ZAviSY1Srp?=
 =?us-ascii?Q?vG+Kuwx8+WRAtJoJSD8UboqUQ+ZEMSxvp3ivbtyI44RFz4srk3JGF9MZmOAI?=
 =?us-ascii?Q?Dteht6cr2EtNyYl48p3Y9Qa9cOXAI3gDqMkokkd6hrSRwofqswewGGSWELMf?=
 =?us-ascii?Q?ntzacSOFpw6QSdfVI75cpkazyfo62aRzFum4LtVwoOtpHFD/UjfOk9jhJjVI?=
 =?us-ascii?Q?6xqH3wVbXck5DET95hWs3D+QgLGvgHz3iEKvO+cuyCB3yuXjwG9uUV7Z2Z4J?=
 =?us-ascii?Q?P4hmuHi+j8BBTvvAHi4feNK7PW/tvxmlUQtbN3n2hpX/QS+8Ca4H8dAp0UCx?=
 =?us-ascii?Q?RIb/y+K5hmLFvwVYnkNIclgNBaCnbNw01IdiKGCLuXwuSg4AFIpZsxc/aUnm?=
 =?us-ascii?Q?mcfAUbptsLPzSllk/CCJjRm+9hEwlKsWiIHqNZf5lFCdh0sj55lCTNtNguhZ?=
 =?us-ascii?Q?H0Ccbi5rT6nWZi1r81LH6O2JzmbqIlRKgodoxeW1etnJ0BJURhbiE8HmOB8s?=
 =?us-ascii?Q?+SHSa0ULUrDl3EcZk9sqi8AdQha+/oN0bwnE3pXiFf4TEyQlRgGOM5SHMQzY?=
 =?us-ascii?Q?MjmuroMqIcEYk9yagWih/NqS0PeTxQbD7pTB//d+gsuWOWv2vesqrgaffwMa?=
 =?us-ascii?Q?QoxC8t6DhjuJaR1GWw5XKk7R7yXaxzMPzsw4UWN5EWMb1pc73rJhyITENsVi?=
 =?us-ascii?Q?Hq3kBQE6lL7XoMfksUoru/INuC5v4XxZJh2IXETEOOwsCaUEQH+K5oiwKhy6?=
 =?us-ascii?Q?3VS4REqg47tpD+PwoIEmXfRJoTsqznZvwEq2KIESxNhVjWxT6LaSANKwkjuO?=
 =?us-ascii?Q?kl8DUr1mOezhrJyW+wddHBDkfyKdc/11R96WzCdr+GAdN0uUbiVX0X78Cjdb?=
 =?us-ascii?Q?UEJMqKPaIoAEWiFtBdeICrV3VAeBe1hvhqQ+fwpV0yhP9uoobY4W4+fSko2h?=
 =?us-ascii?Q?TuaUsK21pBmBm6WDO0yusjBfeLYT/b2xho9U4/nfjFhue4osKrz5foXGrE6i?=
 =?us-ascii?Q?/bA1DT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ONoVsllmiC6aNd+aj2QAIqNkZUko6zREO4FiDV3JvDS/Ou33g8u+ad6zTG7?=
 =?us-ascii?Q?Vj9v5VVm3xRCCYC8WLRL/pdjeTr48KtH4HTLpB3kWbU+BjBma0sGOYc7SAHL?=
 =?us-ascii?Q?iSLp+wUkDvpB3/ebTLz8n1LJoh6H+vNYUjICUJ+i1s7gspIKgnfN0YZDT9P3?=
 =?us-ascii?Q?G7bOCUX3TVsLi8CoTzGvAakYMFHyAE8xk8DcH2mN8fsTmoD+mM4nZNOdeGLU?=
 =?us-ascii?Q?FEq+C8bhZ9e1O+ZZSSBcrq3t3Y/PGxR1FZCkWJYK0P6ZC3mWEguaCInjfIUj?=
 =?us-ascii?Q?vn9p2cMQgN4ocCToLmjEXo5uTq4viB6OvQjvjl7Mw0/SJzIWMKKTWsIubWed?=
 =?us-ascii?Q?NDsCom/fi9ZI8ij8uUm96aUZQsuLoc8wUwL3WufL/+zQoqseI4TJbw5bt3SG?=
 =?us-ascii?Q?B7gckn1bWEpprIImQ9KJ4BjOzf9QEfQE77aW43DiY8+IfR3L4IsJCvsW1sM/?=
 =?us-ascii?Q?vETc9BpvN4eCOhv0Qn6NPk52j0AEh77U59RgDhTJrICJhRKBroUrF4J9Mv8P?=
 =?us-ascii?Q?dkL7onURvZEpnCyUS5JNunxeTHCqZrKr6Fi6vHoi5vIiPlJOwNy7232eG9JD?=
 =?us-ascii?Q?eQYecbjwFu1OhhcwmMGXqmz47QZbRAOl/3MsA9xXB77MxgDnLKKEfbBc1qJY?=
 =?us-ascii?Q?ZvrG/bLs6Fb8hL0Z67kDSxt4aQwCCyr3jwq2PXi1fWENcnA+nJlspoKtqoxA?=
 =?us-ascii?Q?c8KdhaN0iQ93m7fP1DmRZyfX+H9OEiAlKckeDmWEhMLypaTCkzvPk7AuUaBS?=
 =?us-ascii?Q?ulD+1wvtv55i24o5TGjPlZPOY/YNynS8Cu3U605DSBfv/F9qm5ukldmjXklr?=
 =?us-ascii?Q?9jkA6QIboY3d66+dvXoZGS1E9TVuU5mMRXTb4yWZ9KVj+fMmVZNsA6Cj7UEJ?=
 =?us-ascii?Q?oHTE9or0nIaMZbMiK0YkJx7oPHLcGhakxoM+ZBS/pTJMpt/kLPmZ6z/aZ1NV?=
 =?us-ascii?Q?5v8Sfb4APdqgLQJFdMlRa9BlqSEpHUms414fm7ikrQVKkVcUsx49M9K1KFJJ?=
 =?us-ascii?Q?72bFfCHgoQgYWybXSW+Y64OHt9d35rhZPC+nqGYjaTlpyzJAKul8fvd4mkRF?=
 =?us-ascii?Q?U///vwlKV4XcIZz8t5q87DJyA9Tc+lfpiyZtnSUW1+pHfeLWDXQnWjT7eVs/?=
 =?us-ascii?Q?CzJnZhMjmkTe/Q/CaUqdjCn/7VcAdB+fHEQNg2wAMqcHJ0y/FypjpGWFSETI?=
 =?us-ascii?Q?y3UrxVg0y7cu14evgNY2vxfbQsc8qY5GuFURfUnKo74HTe0g08CjEbv4tq2p?=
 =?us-ascii?Q?28E3DxfdeeifclOkYpaSMfDtCPqJbApPlGW//0LD19AkMhOI6Fq4hLKOJOQg?=
 =?us-ascii?Q?+R/J2wlqvd8t89u9mC1xi6Oc5NTGZpO00sLCVE+jeKS1lRJU4/Koef337Ck2?=
 =?us-ascii?Q?htoTd3iZ0wnZtO3qEP4C2UyKOBqr23x/uA6U6QTxTrlqoC9bYHxbMD/ojPNV?=
 =?us-ascii?Q?FxfTwtLvKPBc5p8UaSIsXDytLo7VBhyli9/MRoJ+AmUVa6LKZOeyQLvYGCqf?=
 =?us-ascii?Q?/oJGW79xM5mz/dgopmKZsRVJvoS8Di7zYwh6eyKmLpABX7jgtudUkmBmbxYG?=
 =?us-ascii?Q?UUBqv88tOLAigIuzBNpxEjO1lut50XosDG2K/58s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561cc572-c8e6-4cf6-38e1-08dce3d774eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:16:09.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fP9AJJKxL1bdSvANBP7js19sRipgZOHhkIb57DFGeMpdSkG3lgvpOHgtSUUeRz94xrZERlRq6ogVJe0FVF8PYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

Add PCIe[a,b] and sata support for i.MX8QM-MEK board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- add space before {
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 62 ++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 62203eed6a6cb..e983633a4bb31 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -181,6 +181,17 @@ reg_can2_stby: regulator-can2-stby {
 		vin-supply = <&reg_can2_en>;
 	};
 
+	reg_pciea: regulator-pcie {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&pinctrl_pciea_reg>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "mpcie_3v3";
+		gpio = <&lsio_gpio1 13 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -296,6 +307,12 @@ &cm41_intmux {
 	status = "okay";
 };
 
+&hsio_phy {
+	fsl,hsio-cfg = "pciea-pcieb-sata";
+	fsl,refclk-pad-mode = "input";
+	status = "okay";
+};
+
 &i2c0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -541,6 +558,25 @@ &fec2 {
 	status = "okay";
 };
 
+&pciea {
+	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pciea>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pciea>;
+	status = "okay";
+};
+
+&pcieb {
+	phys = <&hsio_phy 1 PHY_TYPE_PCIE 1>;
+	phy-names = "pcie-phy";
+	pinctrl-0 = <&pinctrl_pcieb>;
+	pinctrl-names = "default";
+	reset-gpio = <&lsio_gpio5 0 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
 &qm_pwm_lvds0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm_lvds0>;
@@ -640,6 +676,10 @@ &sai7 {
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -829,6 +869,28 @@ IMX8QM_LVDS1_I2C1_SDA_LVDS1_I2C1_SDA	0xc600004c
 		>;
 	};
 
+	pinctrl_pciea: pcieagrp {
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO28		0x04000021
+			IMX8QM_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO29		0x06000021
+			IMX8QM_SCU_GPIO0_07_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20
+		>;
+	};
+
+	pinctrl_pciea_reg: pcieareggrp {
+		fsl,pins = <
+			IMX8QM_LVDS1_I2C0_SDA_LSIO_GPIO1_IO13			0x06000021
+		>;
+	};
+
+	pinctrl_pcieb: pciebgrp {
+		fsl,pins = <
+			IMX8QM_PCIE_CTRL1_CLKREQ_B_HSIO_PCIE1_CLKREQ_B		0x06000021
+			IMX8QM_PCIE_CTRL1_WAKE_B_LSIO_GPIO4_IO31		0x04000021
+			IMX8QM_PCIE_CTRL1_PERST_B_LSIO_GPIO5_IO00		0x06000021
+		>;
+	};
+
 	pinctrl_pwm_lvds0: pwmlvds0grp {
 		fsl,pins = <
 			IMX8QM_LVDS0_GPIO00_LVDS0_PWM0_OUT		0x00000020
-- 
2.34.1


