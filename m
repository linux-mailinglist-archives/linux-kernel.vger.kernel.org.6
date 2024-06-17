Return-Path: <linux-kernel+bounces-218388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388F90BDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A551F24247
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E6D19AA5F;
	Mon, 17 Jun 2024 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PNJKapMu"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2063.outbound.protection.outlook.com [40.107.8.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA8199EB0;
	Mon, 17 Jun 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663494; cv=fail; b=qtCfYIDDT1g9l8KldVgGE3VZbutblpw4vbImf9OzJNdRIpLGo5uytBEqa6SEAP8mNhc8dWKpH/c9dffLtkNwfIqzjk64QRHkqATe+mZ+hYXVBtStiiUs3IDxj8jLTQW/lG2LP2zaey3EqhxNeP/+nfTvTDCxM4sj/JHIQhfFnlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663494; c=relaxed/simple;
	bh=aWDpo3yVmNeiLhMXiP+wURDxPwhWKdoeRk7hHuCD7cE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M8yU0z2otnKoLlpJvR1BkwLlZThzFj7sWvzCx9hKtpI0temUihWeJwvK5sIs/PoLzWrom1K2Pv27CzoqwHDvaK9VT4uApLD8D95MAe59IeMxSDZRY69tLBa+qcDIdwdLuXNwVsELuPPC4UbW65PsubBEMaJ1DhxA2X3TQx2D+WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PNJKapMu; arc=fail smtp.client-ip=40.107.8.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnFls3Qq8yoYnyIbhoX0jnlQqoQ80MmlEMUvSDQbm1bIdIVEzkl8kiAibkmXoibNryp0UMgNP1nDnRbThbUk1AASikbUyso2Hrg14qtnuATp5d10fpU/Em0hGxP5v2E34q1r87CHhkdjjfh3zW8dn+gXiZiXqdYgl9sM7RP77bxZN1G2hWZvkKuoDnzq27xj7p7kBUW/touKmDqVspp8fwpNWNsxZhV2bT85zydMqPG1P9ko+REow8GgpOs4wtyr7kIfkgIodozbHa37Oi5BGZphq8CJekbGQMx8N7M3YQBUKOqpW9appRMR3n4+oxoAStI5huVaI/YYc1Kevcu5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAs3SASkx3OsIDq9HO38EGEqAkQ3Iy8fKd4VxoMDeUg=;
 b=YsPJT62o5umNQuz5uO2m/KXF6aGQV0uCMX0iSn6uz9JfY9u07nGD5w7hQWgZ9Zg/kfCZPLXv+h2Yh4zj/HMyoR4jIouuz3kkM9GTsi5EWB0lEimT9LxKb/XaUMCus79Omg0jrVjvvPyMmfaVfGxg24BueM5/Gpp+zrGHNF10vfr6QIAyaoy/mpup5GBePtE2kYqhBO9hLIuv8HJMc1YHSzbV77+zFuQJyiIBFBpLcx+wHSiBGA48qZeIj26TuwIpjAnjalfuhifLhP1vDfbHlHkXgNmDeY9wwxVtAuMx3mXsU3MXfdgJ0C22hA97SvKi5/tdlvY1qNjbgx4I8kJ8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAs3SASkx3OsIDq9HO38EGEqAkQ3Iy8fKd4VxoMDeUg=;
 b=PNJKapMuyKtPXd258xtLlAgvaavfWDJMmQvVB9qbFQRkcr/dJ8LMFlcevaRP1vpBGFgFtH3ju4rFFeUkt+mYr0vlqgN/n+wLv+juhJTsBR+LT5TP4l7OQzHQLg1PJVJzCLMweDWy/qG2Bvwyc68GOLIyWce1XK2ju4KHS/cOt+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 22:31:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 22:31:32 +0000
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
Subject: [PATCH 4/4] arm64: dts: imx95-19x19-evk: add PCIe[0,1] support
Date: Mon, 17 Jun 2024 18:31:00 -0400
Message-Id: <20240617223100.1539796-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617223100.1539796-1-Frank.Li@nxp.com>
References: <20240617223100.1539796-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 78324751-02eb-43de-634a-08dc8f1d3d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|52116011|366013|376011|38350700011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQ2YkOJpEzhbg6UWVcuqsZn5jF21FPWZ0ZsLgF3Jp94S91UKKyOYzatIY5vR?=
 =?us-ascii?Q?zGIx4OSyHGey/0vCseAIl8JUdK3LHc6H5Rd9VhkjKd8WDEsi6f330DrO0Ong?=
 =?us-ascii?Q?/TbWoesLfyeCgSQQOYGU8OA9MmYkP2psYbNeO5FCUeJqXVALlzqv7LCG7qDl?=
 =?us-ascii?Q?WpfDro52xEQotLNIuVWqEALn8yMMv2rPOWE6YrBz8XIyZqePBWVRvcXnjIh3?=
 =?us-ascii?Q?V3GfE0jPw2af1XmZBBPY7RoEZ6hbWbUeiZ97IaLX4o/+ZLdYwPQDVUjlKRUW?=
 =?us-ascii?Q?m+3shtO6Xz7EPf7ikZXPx4NKDIbSL1cyt/32knaFk6j3q1u59rUGc1Q2rirj?=
 =?us-ascii?Q?XOn/Pf63TRUwGgo4/jMjvBdeROXLNfhsb84N3GexIzca1O97NXoqakO0VOiQ?=
 =?us-ascii?Q?klDYKwDM6V9zBXXX1h+Es18/QIWTtRRJQdhkc6amQoGpkjtHZj3BYcBubajq?=
 =?us-ascii?Q?xFTrBVYkBq1iwDWv8rEnwmzkmwF/JKMY0ohjS9h7AqOrNvgrN2FBSKxj7ZNU?=
 =?us-ascii?Q?ATX/B5c50wlHuS7N/ocE0TlqdljCi/XiMoMVp5kCCNz34N+lISL55zCh8+yw?=
 =?us-ascii?Q?2nCMBh4XBg/MDbcpSZ7jKy4xD8VXsmS+WWF6/u/xEupKQv2rBkyy+U97M/TD?=
 =?us-ascii?Q?Ce2uvixe/Xyv9v4UedBHgMlmY/RFizibCBA1Su/24jfGjvO8pgmnF7wQfCiK?=
 =?us-ascii?Q?y/qPK6teEd4F7bSDi+P+Q+7ACgXd7IRoaWJqHy2c2+0ba0L7e+jH4yv78s21?=
 =?us-ascii?Q?2NakIAkKb0IvZHxQ1PNtgzmsxDzocq/BOiEV0gataajSfOSJH3yuo5T/wg14?=
 =?us-ascii?Q?me8EjzDt/hsZy0nKN9TIVbFd7QsKxzo3L1GGA3Yc/rXZOogc2NkqtFzreKYU?=
 =?us-ascii?Q?Jo/Np0ySIwpuEa52jrWQIbBNiNwCUNbknR4MlAkambpOzHlBkxoipw2sgl/o?=
 =?us-ascii?Q?WAcLgKa7A25Y79Js5aiZe5Jwmhoot+bsa1t6JoiZjx5MKMm/qGFbXTaYgXZA?=
 =?us-ascii?Q?zAafJFNN7dRvPba4jkrwgeLHwpJFONwXGk7aV6HOBUeFmRvhQlJQ0C0LPXLQ?=
 =?us-ascii?Q?JP5LoH0hcah2qJ7KAbyh17uL0MQ+u6VtgTaNkIZLFjZ95TK4Tp6Fo4gn2/2n?=
 =?us-ascii?Q?33WY6lu3KMPyzpa+ZzMr07bq8NKDLgPR44jkV3I5fr/I6UQXPt0c9xEUx2Qv?=
 =?us-ascii?Q?lfq5B49liCYFQE2pF2Xy6HkAWL/90+AncpZpzvNhJI5x9IQE+V927dLe7YY4?=
 =?us-ascii?Q?3Tq5BzeoqZ31Ags1+vDkElW9KdBmnpl3WN015xIeLZ8aY0tdqkh9gvr3blcR?=
 =?us-ascii?Q?5lwxCsZylZz6Pz2yv5lM9PzyDs7z8ws2IAuoYSK71yIyxLPupwN5a9IVyAT+?=
 =?us-ascii?Q?ZRprEML9otPjazLNuvK4paNmBBuO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(52116011)(366013)(376011)(38350700011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G33nHlHVQ+cU4IR+LPN4gi9zm/opddBYlsuF+Gea5g0KpTaxugTToGdf3fJB?=
 =?us-ascii?Q?+PhDkBwkUjg/eEogxKhNCsaak9R1xPm0FdKZTQaGOfTKOXtTKXoiWQRtK2/4?=
 =?us-ascii?Q?IcHC9jbPMuga4qrgcwSVtMceqPkSpVaLqks+OR4y77mBKkHEVwOBR+dIWIWM?=
 =?us-ascii?Q?Kj6kTeIr1qp+Ql3VYe5C8VreVE5rN/2q1XS2uj7uBpVYQ03whwZn1M4bCkcb?=
 =?us-ascii?Q?qev72lGuhcvIDE2eXrKIN8v07hN3J8lCwvKrORf/j+KqN7KNnzidCgFI5OQj?=
 =?us-ascii?Q?8ZCAEGqGOD8QLB/nTmHN8sdVrDGcAEVIQ6wkTjVjaXgn1NFvBepxXap/9NQ0?=
 =?us-ascii?Q?P0BEw09hsZgn5eYxr3jAB/cj3jg1yoMgMp/uUwKJ/L+CIO6NdGsBqGc2ftJw?=
 =?us-ascii?Q?NTm/k1jgX+w6h9QqNPF708w1lpjyY7G1wze9j5QU4uyu+rWqg+9PyxGuNRqk?=
 =?us-ascii?Q?BE5+NJ1nfMbG8P9OwHoFy3RzbApTSrwcDHhdWHsMNI31wGXg4SCDn9ac2Rfv?=
 =?us-ascii?Q?BuXBfa7P22ab2ICfQK09afESKxotLphohsFGP8FLSy+F2NCE4TiFrEdMEG/6?=
 =?us-ascii?Q?JNhHDF/S+g+CvCj4JA7QiAdn8Jz85VxRPhthgOYIRsRATSh4AXjSQzGz7yB5?=
 =?us-ascii?Q?Zl8zIM6KYJ58m29fcaiEBsxVuHl/2XC2eds0BJPmYMMNn2cYiGd2tGiCQE6m?=
 =?us-ascii?Q?+irQD0suWC9vNTgrD+wyOpgWCWwhAtca8MgQl52x1NHTn7P25qrGz8rjvmEp?=
 =?us-ascii?Q?ng8AoObKI8/dpoSZ1bqGEEtfOdUDYbp9rIgtXDjqNulNjGS4uQ9WnBZzoSHn?=
 =?us-ascii?Q?3ZjTZL2ZniPyPR7oY3u8fdGZGCI5FbZrwF7w8XFyDsdsnnJSf5UPUT9A077l?=
 =?us-ascii?Q?KVllIcOvxsgFQTGd6wxt0hHeL3jFGMsqIR+Hlz3AbUT50TbmL4Xg54HlUvXs?=
 =?us-ascii?Q?hukFgXFubKRO0TnnyJ0vhEZKYduZMBafxYoX0hsPcksALK/v7n5gKmP28Od+?=
 =?us-ascii?Q?pgXJI4nMnOVf0khWAGJvSwfK7Ag6Z1zHbhN4IWSG22a0epi5RTUKwUgKWu8A?=
 =?us-ascii?Q?izaBoLdQ8g6hLSoMcnkknyuYdXBI0RezMqHXSyxEsWuvd4DWh9sE3kMx8g4n?=
 =?us-ascii?Q?gWCH+oBBmeUWcHer2YlKRN8lpwVbo//lHHDQm9/bBbH2fBkTeJvxp5EIlUIV?=
 =?us-ascii?Q?BHeQw6mIHAdKEjYGC8qJjXzQYApGds5hYqWZbzCV+jaPHMvXoNhO5ayn7cxP?=
 =?us-ascii?Q?oLNlg9uiUtUBJLGume9ApMr6zVq7N8zyVeXdB8FAspChyj3rVwT4nLcfYkie?=
 =?us-ascii?Q?rijRjWoob5y1mpeGp6CEW1kZ8ObVtuYYJP1SSgIt3yqze/zfVwvj1tZkjGdq?=
 =?us-ascii?Q?ado89TbJjwNhORS2VoWweBwO0nxZcYfmyRsljO9rTfAyOICVZAp/EGRiHAlo?=
 =?us-ascii?Q?o8XjLBDE8WiMtuDszfXhWV0Qp980qgcdXUsHtBkxRiV+EMLcCkdyPFDBIf0d?=
 =?us-ascii?Q?A3zeCDI2mMuLKTqdkLEp8L8LXLC9rd3eiNwFffE0LkcgrgGCENrIodmrifM0?=
 =?us-ascii?Q?HM6+PQGw7bv38kDf13U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78324751-02eb-43de-634a-08dc8f1d3d01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:31:32.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeZB3P7lqVMPpzEhoLJ6wHi9xSDdyKJHkjbQivR/vC3QudOcgqNoh+VN4mtwed/uths7VMXTx205r/92CWvFmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

Add PCIe[0,1] and all dependent nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 636907c852e78..e6f748181aeec 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -40,6 +40,36 @@ linux_cma: linux,cma {
 		};
 	};
 
+	reg_m2_pwr: regulator-m2-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "M.2-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c7_pcal6524 20 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_WLAN_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_m2_pwr>;
+		gpio = <&i2c7_pcal6524 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_slot_pwr: regulator-slot-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIe slot-power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c7_pcal6524 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -85,6 +115,22 @@ &mu7 {
 	status = "okay";
 };
 
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_pcie0>;
+	status = "okay";
+};
+
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_slot_pwr>;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -129,6 +175,18 @@ IMX95_PAD_GPIO_IO09__LPI2C7_SCL			0x40000b9e
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B		0x4000031e
+		>;
+	};
+
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
-- 
2.34.1


