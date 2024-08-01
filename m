Return-Path: <linux-kernel+bounces-271569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9F394502C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA6E288205
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1A31B32DA;
	Thu,  1 Aug 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aziJYbaj"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537961DA58;
	Thu,  1 Aug 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528588; cv=fail; b=AkHfBgubL/tzjYPyF3wi73ecbpKpLb+62ZNdq/YAaKFZrHnnQQCtFYKWms+qsXylY8E8rTCxr/RwCCZM4giB8E7LCH/bJkQLo2RTw07IZCBi3UfM/U3A1M1InhZh46KPao+Z6Y0Y7+DIBjZmbiZUe/wC9iUOJyTyHboDRIiqatE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528588; c=relaxed/simple;
	bh=CVR99jyTK6sdeMvxfSvJye9UvZiY+PahjNyz6zQNE8I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bep5JFI03RSHlKmvCWg316V62GgCbW08lvyBmQsJM6tKqN8k5xMhA8BDeoafyt+eDPvdIUfBjtNYv51WC/Kk2QKEX7WDB19gVXMIGctiHt0XKfNJu/yBmjUVi3ZtiEntZ9IdTUWv7VemNanzteOnREgVt4a81Fs2/c7KWjxwtoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aziJYbaj; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx4H7v8ySwWmWgcF2gykV0zVpYj/vbQtxeM2xRYSsqxv/eDobH18oULIicDMRev3GCVIWMv+7uZ5mOwCxg1UIW3ynqQxIbBze5ZhHJ118X9I83U86bqY+2tiWaUWuwFsLEyFd/L9ixjdOaBYTrYmLDm3R9zrBvokZU26s2mdJ/w5+QOed13gTS5F21iYNf97zCMnSG0d0ta+1xKG/cUgaoV1vOtd5zpb2EuWKEglFr/hFywpu/q7pedXRpimBrhPmcanOYUddXVDjvfEimSjPrHKA5/3L0faelMLnrg11w0V7wFjgJXfCAWmlYIxNvzxq6lgKEx88IIzvW2i1J2Efg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDXvsGs66OAUtbgolodcjwdsjM19+VseTX6MKZjWQ4g=;
 b=Y0lWke+bcJ49rS+VVTLTuQbK7PSofgwdkn3gr37hbW5N7x6qnp4LT1a+4s11nQ/4AtTBkOoLF6At3rZ+kEQ+KVZH8l4s6xYwRMb8WzYuRTvt4PwodLfGDURMYQz5to6QmtW5bwB/SAETRIjKVTE9z1goVDEdPARU+iwysxsp3eafF33fRACkpV900mXD1hUkS+W/fBi4xw6uUv9wnjNHpVNiqr3VZNiuKwAkdlP5MzcULbioP4WUOnG6KLkszi9ZBYY0iN1hmwicSt5JVx5GU7ctKUBqo7+tCnbc2QiI0IPMat616R2Dx2sN6izoUkS+ygtsuZ9eSfPf7QuXi2+8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDXvsGs66OAUtbgolodcjwdsjM19+VseTX6MKZjWQ4g=;
 b=aziJYbajvN2rxXxxNT/W2Mxo9hFbT3z/LAuZbjpgxBXi0Ym+L7DBLLORdToMB5frJL9XYu8hnUugI5dQkPfjsTtMupAGhndhk0Wmc4jL+ObzP1JKLD80K8y2SU2u6eH8v0ZqNvSyP0/GxMdt3zGapBrrAmug/98H3MDCsU6mieoCcyOMwlGgAAa4w0f39qjSWkAcwDcxpTH/1t8lTLVOhLSq3/ok5geAf9I8iM36HDhaxM+yH3MrZTe3o251tB4wj5nM/nbfNHLfCF0ZT2u0sO2SD4VvvD+6gLf/qQTMYcl+rDhTceRnh5ImdOAxfWcLxkFGm45f9awP4ioDvbsTdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 1 Aug
 2024 16:09:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:09:43 +0000
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
Subject: [PATCH 1/1] arm64: dts: imx93: add lpi2c1 and child node
Date: Thu,  1 Aug 2024 12:09:14 -0400
Message-Id: <20240801160915.2505610-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: dce0520e-34cd-4561-0138-08dcb2445b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jhE5QIhXwL3jZQx68i+8UHMfnRnvDFgH3ugwIyCqVodGjGnWEasUrPozhX31?=
 =?us-ascii?Q?SZ/vL4CE2f/VeK1bN9hLf2w2QZiURk7wJmqdYKsKVds5BL0WTZl9UFPQjje6?=
 =?us-ascii?Q?p4LhmdBAYWCMnHiMX8aUD+CkfIwLQNb5Wahhaoy1luT/TG2ohPseDv0O45FZ?=
 =?us-ascii?Q?kqGCtZt2w667mNgh+Uc8T5nf2pChGRqzQ5FseRV8aM5+C4CM7yh3LoneAzOq?=
 =?us-ascii?Q?CWRqEQugR5ZZKjboqkZ4Lduzx3bkSNRQ+kKOHOdTA81VbGX4WZWZs4h9se9q?=
 =?us-ascii?Q?RcwKVII5TvLgNtmehYTUzW9z94C3i/+l4E5XBN0HXdjZ+mheBmq3QVbD0aeR?=
 =?us-ascii?Q?9re9wTFOBZ0LIJw0ur40D+/607uLI06m4D25Jw6a5KftZGXK/4+3A0kH46nQ?=
 =?us-ascii?Q?YxFADzn91COfk0R4RFQMmSgF76R+VC2HiU/NDT2APYg0tU7pE9cQeNJBd7Ip?=
 =?us-ascii?Q?1yAjE4fDG6/hoUvQdvf+YTsc1qZWL8h4EbcPJmVFoavBINH49p7lPzF0YoeZ?=
 =?us-ascii?Q?6tVqDscrdK98wsDE97Ka5W/Ilmcw6eGSaHQuESwDa0THcRyhGOMmRd9GT09m?=
 =?us-ascii?Q?X7XbRe9JKcy9X6vaXg/AUZiyDDMYK9FeDht+YocinqZwfY7Ebj3OytfNZUl+?=
 =?us-ascii?Q?pN1zb6yr8AsTWc26smvSwzRf4yr5yfwYh+OoKuGPemt3gXJxE5akIi1v61QQ?=
 =?us-ascii?Q?BdwbJHftu20z0lKuJWQeZzY+vuPunn9c5uqRGae4eHz2AQM0c3uP//sWQj4X?=
 =?us-ascii?Q?2g+I9RBudm2Y4JMYRFjNXhs8zJyqlmG6+ghdF3R+eDwpZiUlxgMS9XvQ0uFk?=
 =?us-ascii?Q?CjN4iQ88U0GsZ2xyL6P1fMIXFqzKLBPq/QL2Nb/+mn0nDpSoD0GW1OFkv2In?=
 =?us-ascii?Q?4eHxAE6QCbj1UaDtF9kAcbbXN/nAV3vwURWHqMtaXmbsHzd9itwXuTOWwuAA?=
 =?us-ascii?Q?/wxZLwnDjPhJefIXxs+nzk1s0AprXMQYkrr2At9lmvoMgFJRYXLjbypFqvgI?=
 =?us-ascii?Q?qEdS3CYKs9g2QiOWuxtel1WBACOKaoLgrkLZPKGrsa2620WGJ3cbTZ5XcKvl?=
 =?us-ascii?Q?Mx7ozf6rIxRLmzNOjCl75N5NTcCDusZbmgDmEI5Ey2ACovyVCQo2PobGX9xp?=
 =?us-ascii?Q?g+SLZJYuBMU8CBTIalNoCkpdDBfSDwfOh9cLV6pCe3p7GCx7qxsVmIkeALpK?=
 =?us-ascii?Q?d45XqyebRSBUnbzvKAAaFqcWOxoi7FSYJ7bLvXJ+7wqwZ6rnndrG9wE765It?=
 =?us-ascii?Q?Mnjw812I7EudRCfXF+0xwNbdluzRYlADFjQQvpe7KkFJwrbJ4X55pZ3bWeKh?=
 =?us-ascii?Q?yVHE+90V+lvdPSIiMXEcbktfZnuTv2bZMqp4aU2DkSEREQhkw8cp7jxelkKc?=
 =?us-ascii?Q?0213ctcHWSP3vRvcnZY765e5NnsmO0iZPTafAuUyAqWK/OEoA0JErjBhy8UO?=
 =?us-ascii?Q?SbNNpMsN/m0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fry+YLV/xlyzk+t+wy4i3lvES7GyR4aWKXbYdAfSx3eLv8cbtRA4+gOYBOYM?=
 =?us-ascii?Q?Bd5VuJvqq6YD8BNjjHMRN6FuG2Ak4hIU0keSjDwFQ1Ua3xp19dqeEEeEJDiV?=
 =?us-ascii?Q?9QS/7ynzoLwhxmwVanTTYFQrUNSCYGp0NV5EtXAyNo+QkFnL9Ey1c1JhZOw2?=
 =?us-ascii?Q?9UBsLcG29s+yoXGuDp4d3ahJqj00PLOdR/cvhf4rLlqHm9LX4+foeNN/KYqg?=
 =?us-ascii?Q?F/5G1yNdCirROO0teoGrvc62NwMc9WyoikGT8zS5VwVZrgVzz5gt/1T3Fb+0?=
 =?us-ascii?Q?MtpV9qTaxP4tsjs7kXtsjrnVok3Va1zofBRE6AATDai/grJb38EykLc7gEd/?=
 =?us-ascii?Q?GC6VVD7OsGi3egLRsjY5yDQlhUWV1EC5zZU56HEt2CwmxG2p33oFAwfR+5qu?=
 =?us-ascii?Q?8nHDGw6wHWmfnhdVjT5mcGtJ8WKwrduzx/bdnyk/Rp1aRC375KANK7Dgt4qJ?=
 =?us-ascii?Q?nzRFAtsu26NydjSFxQ6y+fhIxcYb70wYF45UoWGgSlQAq7eX+kCGBFb8vsjL?=
 =?us-ascii?Q?BMXB3n2Imd2XFSomFHYLyhPC431OwwSMoAg65yqmTdZ5HEZVI8OaT5m7PTFc?=
 =?us-ascii?Q?KHrTUPZtr4Vlo1ApAb8o6wSCBJ9FfFrUXmNINC2N/Jdpx4jSUnZ2xcPYI4SU?=
 =?us-ascii?Q?kgUZLWUgad89G9dymRU1GJusFfemA/YpEK0Z5zs3hA1arDCneN3O/+fh11+S?=
 =?us-ascii?Q?7gWVeoPAjgUcaqnuEEzfpceSEj7cyeGWr5XNtF1aeEMzNUyKT5Xaw9pTJade?=
 =?us-ascii?Q?AFG4InAHb7g2XUMSt2IUbMDCXYnyl4a0aLVlKZorxeRMbWnnkB54DODIOkfY?=
 =?us-ascii?Q?mmwUVTxWcXVWuddec1waM1tF38bPkr3A4NSW6m5GX5LbbIqmWfal93BGGFOI?=
 =?us-ascii?Q?9w/H08BGxxAjyghrlhi9T+C3h/h6HOWWVC+jBMMKRgu+dDDvh8Kw/sIkZaw1?=
 =?us-ascii?Q?wlochWDK/SRrZY0m97jIJZpfKCIWVjimkYdBIfIFxyOqFshje9qo906SkLe5?=
 =?us-ascii?Q?kqtRrmzEjHoQFHik5hh+c5W50ZKPowXYiwi+wQT6huaxEqEuJe4gSnGqccd8?=
 =?us-ascii?Q?SFDELmN8ypvWKndipYx8VQUPdSMh7cev9BcKIpFgHgsFkFKcjR87uIdiPTnC?=
 =?us-ascii?Q?3oGRek5w5p83h0S44kqpuEMx0Ci8ZiVWYnAl0ZLf+EBBPDWGoBarmt5yADDg?=
 =?us-ascii?Q?vb23dlCRX7BoMX+TODZZEUk8kVqMzhI7fqWHQ/RMPOhSLijHtdPZQbIGbJnC?=
 =?us-ascii?Q?jgCVV9xHWRm8i62RoCDNsoQItiZUWh1L1y+dNij+y3iBBlnHsr6jK7Rda48G?=
 =?us-ascii?Q?b1DejbfCzvpadqa9kY0DIJEinWMYrA/hZ7kXKxjUrMBArIDZQWXjTk1s4m2O?=
 =?us-ascii?Q?UkJAT7x11/27i39yFIlXGmnQvXErrxUt6lodXJIqkTgscoHNeebF61FnO5yW?=
 =?us-ascii?Q?8GUp/k8gznD3T5vtHg6n1j8k7OGjaZYsiPa7hH4iJ87FTLA0dfc0ym9AJ6CG?=
 =?us-ascii?Q?K4cDoS/DmmIp4bJ+DS4FUf8iB5gGBFrFWRf3UyPn94qTPGd4ovXN1sHBivg9?=
 =?us-ascii?Q?SUVCzyjrO3eu9V3K7MY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce0520e-34cd-4561-0138-08dcb2445b10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:09:43.6888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBhQAgrXnuHwFqFd3mwuztPBuRXe9CMJPXXiEBLR72S6KgxC6KuTr248jFcHAIaA5kbDzPQSJXwN2e7n7W3ZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960

From: Clark Wang <xiaoning.wang@nxp.com>

Add lpi2c1 and child node for imx93-11x11-evk board.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index a15987f49e8d6..dd387b820831a 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -145,6 +145,20 @@ ethphy2: ethernet-phy@2 {
 	};
 };
 
+&lpi2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c1>;
+	status = "okay";
+
+	lsm6dsm@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
 &lpi2c2 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -508,6 +522,13 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
 		>;
 	};
 
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX93_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c2: lpi2c2grp {
 		fsl,pins = <
 			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-- 
2.34.1


