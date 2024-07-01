Return-Path: <linux-kernel+bounces-236971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012191E936
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97F5B21E09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBD172760;
	Mon,  1 Jul 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HdwpRhj3"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F7171E43;
	Mon,  1 Jul 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864481; cv=fail; b=YzATvJZ6f9AnNTkhzKen7jg3TitEKD6YIyvmDaH7u9CsIPsNoj1zhJrLOKyCAezl5CGtndxvyOMWgeskWV0MMJBmnzr1YKvCamC0UbdU7DFo9svVYfQBJ2nBk2y0PCE3IYQc1tCrg5F83WIAu8dFYynCQT1tiFVcy8VYqt1Q1gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864481; c=relaxed/simple;
	bh=JJ/WNPcrqSTW8U6yuQq18GqR6VmNPBg2IUxSAwnTDaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+QfKm5Hg0P8/YEy5Bc13yAYhQLatT/Rpi93JIxGxPaARhy+ngmx5VcoMKAfVWdyR7U1waZJkK6IXrsKbos72BhHVVTK+nWfGmljod+mK0rqVrxJZCo3aCXA+TL2gP3On7YAl9nRJgJrHmqKMRYk2cCuU1sVMfVopxBoAv+BjKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HdwpRhj3; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3D/1m9pb6NVIt4bBRsYPZhSqH6EJFk/tZemchLElZJtSMtyjQUXUCophuv9PN9G7CkNpaQLC5LWrqdFgya9/XcAmproiik4YlJMwcBHqmYfd8GxsfvhZj33luA03CELVW6eQFf6vEZt53tCexHYXpqaGls61zCCSbtQbJx+3qeQWY+fP6UmfPXKgMXT/T/FxY/NNbXHuKwUlGLLpyVE4j8Mh4VzZqk4Rjm2wRn6C1icSZmBmGY+y+U3nxLbKgnlhiEnB611KpAY9FqYgEZly65Aw2G+QJBvRpy48mjqjv+2oAdm0dC4spyzt0TO2A3J2hG2d3KZPxDY55pw89s1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0G0O42r9WNnOX8BfOK+IEyPRAImGui135uP9MDeU2U=;
 b=UONBOKcMxs0MO600SmtiDJj40oOFQWmbVtyAyyAMz22SlzRN9jvARiQDjzO1fpyj5BtMG8uy6/3mlF6Mh/tk3n++0rA3sqQooIvw7PvhsR5Ue2dQpWPaPgBYD70fbxsK3YM3C0xWneklrF/4iHqcr2DaeJYu/cDt6/8/m3j4ed6rLXpXoVqmLGtWD79/0/0xRVJUCLyDKpT3krusF5p7F9H7jLArFexmS9I+sauyNmoiqMkWcVAO6VMCoo+HcLDtxloIwrGAWAtWElW60PXDzZT/ebHqdAKblgmwWzLGC9sGsvJ8yr6oVlJ4Qp/Gsj3LPesFZ+iDBySlAZ6m87qRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0G0O42r9WNnOX8BfOK+IEyPRAImGui135uP9MDeU2U=;
 b=HdwpRhj3nI783EL/buley6OtOGcWytXcy3hhhcyriQopzg3UNOJfYECG7viuSwYOHJ0/Vy+LP7YfUNoCMrMaX0G1G3hArAaudl3h5ePVyhohzTHBG/mUaV9TEc+S84Rr7hjuTzexonY0v2Ks4nLXs7bwnpobT1ttVv7tShyZLu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:07:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:07:58 +0000
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
Subject: [PATCH v2 5/7] arm64: dts: imx95-19x19-evk: add flexspi and child node
Date: Mon,  1 Jul 2024 16:07:26 -0400
Message-Id: <20240701200728.1887467-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701200728.1887467-1-Frank.Li@nxp.com>
References: <20240701200728.1887467-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: a791560a-9d07-437c-a304-08dc9a09808e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMlOyJSkIPdvj/ytmMzrdH5hsjXcJnHmDm3ZXRC/IRZTBax0DjKrlr2200TX?=
 =?us-ascii?Q?VOYuBHwtqU9RtWM3oIvhvdl0ABeDPSdO8trAicknI3zxzY+FiME7JUhRJ698?=
 =?us-ascii?Q?/3lD6B0BM199hNeDAKeennFCcP+PrJgvKzUzecfqsx9MvdoVjxMQJ/AVTzo6?=
 =?us-ascii?Q?/ITD9zVJr7ZVZLndnrnc4YYxR1Q/mtlMl2aAupUQRXK4W070OqZy5iT6VeV7?=
 =?us-ascii?Q?+6Y3ag9cT+PMzmS1lQjZCpOlNGtcY2bpWbAUWL0EUtFDyQXdHV2mCHT5346O?=
 =?us-ascii?Q?ASzL5VMq4aZggHDWqVarsenEI059pLDkqDJXRinNQ9KxgQzFwtoD6+rRf36u?=
 =?us-ascii?Q?/NremQQUF6aknwskM7Z52tZeBBFLs00aZwaaJed+4O5SDhS2HEBgPLceUi8U?=
 =?us-ascii?Q?cnX3PGLUMo+7nno72q02uAGA6APCWAXx1/qn3VTsj19HKKmXxh5a2+tLi+UV?=
 =?us-ascii?Q?PCJRwqG4uNzzs8vw5oYI3tRWBEi8XRWlmfVm996QU3D8COoLf6DSMFnDzXba?=
 =?us-ascii?Q?VAnbv2TOBYoWcOSNJWpeRnxmtuekVk8QO/BndW2WiFCm2PBw3+sG/x9/S6li?=
 =?us-ascii?Q?A6jP1sG+X4hTAaCFLqiCxiR9ZSnEBSChgikxx4CMdcDDRTZnzT7tfq6dtk2p?=
 =?us-ascii?Q?TQKQ7bg9XU+EFaKUN+hVf4RwJnP9CenPuhZH9AteOJNVMJg8KzhwKPCP27rx?=
 =?us-ascii?Q?ZcKRV3YkhCBw86XpYO9MQF3EM+M/N6xvEvHDNmlkpi00uxGv3euiG9Zhx0RF?=
 =?us-ascii?Q?06aAFhFkfO8Oi4wCwwGHiDXpQ4gxxn4zK1bIt/MduMM82ZFRI3LxO4mVkDCU?=
 =?us-ascii?Q?zY3gUHQerHH3Qb/FwHeF6vU8JKVUYzmygd4L0uCKhcpDH0jmXqrXBF02s787?=
 =?us-ascii?Q?ZMqaOJchP7L3IWAgyg5suXlOBuJEOlgvGFriIWUEGIlnLvwqojbL32gkmDiw?=
 =?us-ascii?Q?NcJtyzl0ltMZsS+p5Y4W3GE3VqbWbr9Lz5LN5q3Nld7jO73jEoco6l+ehCHd?=
 =?us-ascii?Q?CbXBJQW9ndjklqSdCeXKFS5u87YxYdJDsu28GQVMVBInx8jR4jUj+Kn9+5GA?=
 =?us-ascii?Q?T4qikrMTTP191Kaa+lxDuyFCIW75dE6bkA616t/1/Q/8lQoDX5Z1wlmaufZL?=
 =?us-ascii?Q?PXNBqHYLKILkbjzq1wQ5xgp4U83SbPpM+8v6EoqcTTTmsSAUgKMJv8XvJz3g?=
 =?us-ascii?Q?6lZ3JuRIt6J7GqkGFxs/LQx7Z/UielrzOLqXNNDLqmhA5h0oqofeqIQZkr/d?=
 =?us-ascii?Q?IwGOfi4ZzOVi4KefK6lkqpQ92r/qmQ2bmL5tWMI/+TAtec7REDAWluzedRcj?=
 =?us-ascii?Q?8vxceflTnO2g4XLJQEni16FL3L2MSdOffETNT4+geyqUAjM24x/Z1Ed+nDe3?=
 =?us-ascii?Q?m/d4C8JbB3Ub9MVIjz4VTollOxXRWGfFEw6zJbapDhpgXgItyn76WqTBDMqz?=
 =?us-ascii?Q?cR9mswFkKsk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZcQOr/R7Tg9pr2/0zzFySVnFKP9cehgoQyPSfJEdL0nTuw0JEGMXJbx2lrq1?=
 =?us-ascii?Q?WoeyKNf7Ba22oudksUISg06CVke0TvBvfAl77FsvH5wt7gbXb0FsdM/APLUQ?=
 =?us-ascii?Q?N1nH4Ih5PGpUqvzY/RXrckvSBqJmly4um71OUeYBJlYC8bPc9wGuuhkHypU2?=
 =?us-ascii?Q?DgbKy0kDYvZi5rdu/Ps43kVV8N2wyWhsmy7siFxBvOYyL++s2HQvs69/P5yi?=
 =?us-ascii?Q?EWzTeQ3bSANP6OpedK3K9Sv1xrk18VNZdyEaijcOprvM/7fS5wBbA+9yf6Aw?=
 =?us-ascii?Q?lXRsWa8pWtoNnP9t+SZxLsBDqO3udeQjt4NIzVlD8kMGX/aIfCv8RBn51RLH?=
 =?us-ascii?Q?nC87RQ2egSAUlZ9g9T8f9QZwyO397HhbfYOZYg50uKEFqyHyiUeafRSM3tXe?=
 =?us-ascii?Q?FcRtp/MMtnqqbLRrorb9S7o3RIrwfCY27PVKzSEorxXbmvUnN2NbTtCkXQoU?=
 =?us-ascii?Q?d/1ZHf8KO15X7dFmvSHTcfNYSfqYe37u5u5XSVciyFJjdDW86g4ruU/Dg+af?=
 =?us-ascii?Q?q3+wwX8t3oNxzwPM9zPdskRAyG+NCTEMIQul5HxlhV9+/+jKiYHYze+na3Rp?=
 =?us-ascii?Q?d/fB7bARaqIg9bwvxoa6RrO/1qW1htJVKCwfnLdm7lNMqlcl/JI54cIi4T9E?=
 =?us-ascii?Q?dxftx1YJmKhgGWqR7F5enxS1+rCjz6AHze/XA5OSkNkg2S7xPz0RWwB82H/i?=
 =?us-ascii?Q?x7v4rmJYhpE6G2u1SLpwSZ264AgvHOmmptrTmWOw0RNUYQWrJdA+snK80eqN?=
 =?us-ascii?Q?LHiJWLRQTrntRpkMeu5RiSWxS65Rmdyi2BzsyAJH6zEJd0tpWuEeJYgPrz4N?=
 =?us-ascii?Q?VPJ3plxuG0GQ0MrE4G04knZVB8bmoDXXb6Fa5f400KMtS4MwQql26o6+MVPh?=
 =?us-ascii?Q?fCSddXzR87DgDGGnbTsKLxFCTFbGuU5C06XfuyRIlA9sLU7JSrBcFStTkTDD?=
 =?us-ascii?Q?97JaTZBTp9ob7BLHqpHO0i2Zvj2qLwidxlUZ2IVrFRd5SJIClDsIr/Tyh5el?=
 =?us-ascii?Q?xrisca+L/MO71hfSf0aF5AFf4xH5wMJt9hg8uGrzxZAUXSDWeKEV4Kuk25He?=
 =?us-ascii?Q?ck/UW51RlfsW4qI7fuMNf6gW9eoQCshlV3nFwmEOoCWDYvgCXlP7qjaM39rA?=
 =?us-ascii?Q?m1aS7oskoxXpC52s1YG/Oof5I0FV3Yv/t+jnsJWAd+MHFx6o/OkMfh3d4tTL?=
 =?us-ascii?Q?jw/BP6HUZUxBfGIU4QJMH0nu2AwIFLmeFJH43e1SFEq5rBA/1Guhp/PyC8ZO?=
 =?us-ascii?Q?UxJ8OwJVoaJbwa/DmOPqslYtpVrxoYtWytYEVHoCjpHS0XF9EgQknxGJ6xqx?=
 =?us-ascii?Q?+gAbEAOVOMunPIhTkQqmRjiJurKrUmEZtshsmhlzAJeRRaFO3azz3jmCF/ml?=
 =?us-ascii?Q?gF9xvDYcHOSpHMXJ9A1C0KUfCF/Rrjy5kAQY+NFpkVhyfu/KUus1PW45qgsC?=
 =?us-ascii?Q?uGMU4kruiX7wTf/epbo+Ox/v62joRJM7X7utS8akU1lCjByiIdX9gt6j3v1f?=
 =?us-ascii?Q?Q0ixlL0GVvYbvDLx5PKrmRvp2TQixw2JNAKoQfUfxdQK6q0NobKXbaSbAg9/?=
 =?us-ascii?Q?KG99cXQx+h2M1XPkYIoYuRXz4NGeN+4qe7W/liqi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a791560a-9d07-437c-a304-08dc9a09808e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:07:58.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvFb5dOefwS4USxDR9RKJYIjd9GJi4OmoJrEaezrwEv1emUb8UPClqpkgXe506ejhmxpGq+IBp7uV1VbPF4NmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add flexspi and child flash node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- move gpio pinctrl inder flash@0
- add reset-gpios
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 660e623f4f964..2b820a961c173 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -163,6 +163,25 @@ sound-wm8962 {
 	};
 };
 
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_flexspi1_reset>;
+		reset-gpios = <&gpio5 11 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &lpi2c4 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -336,6 +355,28 @@ &wdog3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = <
+			IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B			0x3fe
+			IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK			0x3fe
+			IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS			0x3fe
+			IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0		0x3fe
+			IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1		0x3fe
+			IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2		0x3fe
+			IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3		0x3fe
+			IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4		0x3fe
+			IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5		0x3fe
+			IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6		0x3fe
+			IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7		0x3fe
+		>;
+	};
+
+	pinctrl_flexspi1_reset: flexspi1-reset-grp {
+		fsl,pins = <
+			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x3fe
+		>;
+	};
+
 	pinctrl_hp: hpgrp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11		0x31e
-- 
2.34.1


