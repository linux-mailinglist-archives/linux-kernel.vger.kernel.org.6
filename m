Return-Path: <linux-kernel+bounces-296548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DA395ABF0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF3F1F21CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D817210FF;
	Thu, 22 Aug 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YIdu5FSV"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A29D175AE;
	Thu, 22 Aug 2024 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297590; cv=fail; b=eFxszRMy60ApBb1D2BY6/BiGukgFLp2C2ZvfGfOdCj9LOn7HSteScq4goVuV37cadEyVkelhh608jXc0EIc97Gh5hghyW9HyPpAydz1LC3HckRMPPQpOcCY84uXKLtqsX3MY6AhH9AUptYki8tkhk3RV0vShMOoHfDHRXUKJx1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297590; c=relaxed/simple;
	bh=WqDw7iw0fe75q9MNzz8Or8h96SIfGLeTQeF7DbbaccU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rGdWpOOAVG3VsZbZRxiSiAe6VouNUkMVOmlD4jzc2OfsSZdL3ytl8XuNzCcXyFnqvsR0rF3ocp6m77GEOh5JU9imGteaJCzqHVbFO9bSno2YgR77Bwtiux27VDARVXH4BBd7zrzNg6lmHd3LeQiGp7HIMzz3WRO2lUopxFXpkbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YIdu5FSV; arc=fail smtp.client-ip=40.107.247.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB06D7elgNfLKvXWwQ7qwDUY8Jw8RJ2UpM3fCdJVnJlsqnAMrE2OsY5kzm0LSEvcqbxs23G97/EjAMxdylBRrX/NBV/98IhtRWB6Tgx+Jjn6Ws6MDPjtUCw7ZRKgoyKq5qsaSEenkoQzyBsGDtudyiaxHNb5xcd2w+HxHAHnlJrXDa7JyA9fxKHa4J6nvFKC4NcpWFykF7VmMkQBNinJS695s6hevti9WJnWrV5VONRmHkBe46IU+4IPiDdaZE/e3V0uP3oJbcaAYhvDieMKGPQ3ffdmAsQ6jzw8ZDoxhI+3EIYdId1XYzmOef55n8qidFvA7b1SAkyuElmRL3z6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLrsex/04KcRid4rZNj2j8AEdvoQpWyzejXAOECX67c=;
 b=zNsW/qbuTXEZDL7b7rZXO7XiZadseAVCDmM1Ez9os3XI5NaQpCW1JAwqFcbtIlKdAv5KEgaY7EggtPJdvzVnvUzhCH98oQ3IpqTcOc3XVyGzPB5j8Z3JJEk4Btd+Uznzdjc91fe5PDuL1GA+YDzY8TQO/NfN4B1YLnSBqzERJSCQqWJy3rSKHkqe3SBctVkLu3m+dKKzyc9ifj5zvYljhNSa//roA/8C+ONT94yVDNf7lMfY9KDC5I4j1KQrQQPHAuXRuLLzsYiO5FaR0XR80KTlYqEl37PzPKgSFaK6VR0Qk+yyfibZFz9Avus8eqPF1v3gOx/lts060PJBd0xKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLrsex/04KcRid4rZNj2j8AEdvoQpWyzejXAOECX67c=;
 b=YIdu5FSVDDa4JI3NoAmHZkM5t4003nGPuBpAIkZ6eHz6GkfLj0dal5/s5xezZbflT+wDkCtlGw8GNsTHqejKgEFWD1pzugKPd1TJog0DLB8yiAH4XQIlcL3OeguXTLp4ed9OSaqEmQLksW3ykMAXubaea9stBlxnLYtiQYWguJ0pWRCXQA9Ztu3DHNkJZN7OZtZ6x0vD1gsqoxB//zb07Z6Sbq+Ss1pPyKkGvwlQOOk9zBK22L2HR/GqzCZHnIqcVm3BCDwOAHU3PVMqHTbsGIQDbVr42pkruc8E4pRDPE2Vy+unzfhKKi3n3ChO5A1AolCaOquURTQEX8XsA2IA7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 03:33:05 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%2]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 03:33:05 +0000
From: Liu Ying <victor.liu@nxp.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Subject: [PATCH] arm64: dts: imx8mp-evk: Add native HDMI output
Date: Thu, 22 Aug 2024 11:33:18 +0800
Message-Id: <20240822033318.753724-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DU0PR04MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec15952-83d1-4a0d-1e3b-08dcc25b2233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f+tpAzLJWJ6RmZkHUi1xudTruXgzVLEHA2bem6Rd5QSQrZZe7M7zfOi63Gws?=
 =?us-ascii?Q?XFXLDkuu0YoEd1EurPw395T3pOe0fvGUtkSGPAaN3FocIeG4ZyxkGwoDnyUc?=
 =?us-ascii?Q?xFURFgtcOIL+gmNWNhKcoqAtKAY/oRmEir4DO6t9q1U9z0vpuPsrlVxEckwe?=
 =?us-ascii?Q?y6LdX6swdbg77NSX4XHPOkBsyqq5KOhHyGzY/JR0GtAmq3By/fG2y6Ln/ahk?=
 =?us-ascii?Q?PCf49+bVZN3TyRv9ObN48JkeD2TszPMdz6NB+QbYwKzdshawlLL5esRrx7rT?=
 =?us-ascii?Q?vK2ROG1YW/9xTTJa3lACdUQADR+lzL/HVTvktYytcJW6h28/TVzvxCBYNBHZ?=
 =?us-ascii?Q?JE79Z5Xcea1loUeHrSfUPeW983vWuI9N3p1eOqVmbS8F6aV+/6EqaXsmeACo?=
 =?us-ascii?Q?BQEME0KI6PR9m561L+04LBr9fi7JwmGeRsHa4n0+1NEvMOX9kw60J6OjVnSG?=
 =?us-ascii?Q?t3nL8BMEmSCdF4cXYjk8L7L2YRnQ+zRG4TOmOzQ7MozBF+p8Z4i1fpVTRuVS?=
 =?us-ascii?Q?Kl+T7DyfNm1tL6A9Mld9QhJdw9Nq6rPavtPqBB5gqkIASZiLEi8amc1hlKao?=
 =?us-ascii?Q?OfLNKTeyaTml0YAiVgol8/FxdW+oz0i/endRkrXXFK9AICrIY4yPVxY5urxj?=
 =?us-ascii?Q?ej6AtHlHLF+P63tNrbUt9KmmXMr+OUTFMAhbJcKYD8A14JeL3VoadEBuIv0l?=
 =?us-ascii?Q?SwYHCesyo/rQIiOLNxGbiN1CpNFi7TZZ6OLlthQT7KhhiFCthGLMcISMY0zy?=
 =?us-ascii?Q?Lw+UjlbYICY8UzK5MhKclFlZkMqRKqVQ1gzGF5zADMNwGXbjZMkCwADrhEU5?=
 =?us-ascii?Q?GKxIAoKkBxVfZvk3/uxSqFqHeoIfw25HDGddjNRnTgu5Rep35jmWQRlP80Mi?=
 =?us-ascii?Q?ER8EOH8sMKLjitYRBtOBje7003f5d42hJHgobNzlszSjAGqqF45ZaqZofk+L?=
 =?us-ascii?Q?6UVwuvRXj0qzQnuMgCPHJlkLvJsef/OfK7Z/zfQZ0YfPbu1ZWB9Y7byVyES2?=
 =?us-ascii?Q?MAOIrztVD1EqnTKSEbhmJdXm7QuKwZgbwxEn0gKAWvo/kOHvIPIRFjvqBC92?=
 =?us-ascii?Q?QhjTrQB8DQLThgmqMqepVnd2olwhY13Oi01Qrg8s+L28lyrzfATV7Bl6tJzJ?=
 =?us-ascii?Q?VkLXNoKxfEiGw2ss8Ve9G5CygzDIXXIKvkThGRM+QAj12tbDSX5VNkWD90D2?=
 =?us-ascii?Q?RfcdbRqV09FvRUbDLLh1K6OnP+NyNKpzKhjKkJyXzqCoj7kiwlrtfEPOgmjS?=
 =?us-ascii?Q?BJuqrLuenCWgkxMrT/OB1LQNmeBF5uNl1DumEX0PjpYwgD8VVK4c4ilZR/3Z?=
 =?us-ascii?Q?b8Px+FFND2cVdp3WffYS44aXzBAaWTay8teWlAGn0qcZ0kNg5GmDCPuzPP2a?=
 =?us-ascii?Q?/az47xGqs1U9IUUgTebrVTE3i6+oivWv1Ytwf362Ko8DDwStnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6CpZ4LjNVLkH0LxUp8hmljdX6tG4JxBDpr04RsXReOf73regPMzL68f7RqI1?=
 =?us-ascii?Q?DvUokA/s3kFkelRmmTd4NFaYrltikRUhvF4we7R7WoDvOhB119EBZYCdN8cU?=
 =?us-ascii?Q?sp6KughewU9nOe2XZ3SRFj+VAuWy5ApZvnaZoto9rdJejARr7CM7bzuSBg8Y?=
 =?us-ascii?Q?Holn756tZ0JNJtPUPfAVuqzU07f+YOZdU/X6e6RWtKpvk9p7naQixGpy3HL6?=
 =?us-ascii?Q?DXRoihQSNwy9VXnpLs79ZZxUcujXvVXL1llYpPWbXNWTmia23Yffdq3cAscf?=
 =?us-ascii?Q?iwiD2WilPUlJBx/it1fIKKtyt6WSefEkO+l7u/wOf9I7LBtciZuh06piO4Gf?=
 =?us-ascii?Q?B5snEe/j2PvTmFAWVZQw1ZoENB4gJSAssJeyAHsmVmZhni7PY06BHUusmjnk?=
 =?us-ascii?Q?LvVX1zNkRNzbt3hEt0PKhDWlwBaS2EpSrAoZ/1+k1tqXZEuvJKCAtZuGf0hW?=
 =?us-ascii?Q?ZZ6XD572RnR2uvCekZtGVZ4VPYVQsaSt2Ys3YHDbQs/nNFZBiv9fkgBDFm6k?=
 =?us-ascii?Q?WgnuqMS3z6S0aZOOqRr0dYXaoyM3myWOyKqJC5YoqCR5fd6xw1UdFPc5aw2O?=
 =?us-ascii?Q?pJ4a9m33q3RgosVebZAKtiayp5wrSRn4nyUKgyruoU5EzdIaOaGOeM1FS2Ks?=
 =?us-ascii?Q?2VeIqBlFqiUVD+it7KBzDLVg8hb3d3ppENjRw2NXuIauIsT6HmRJh0/jYgOJ?=
 =?us-ascii?Q?g7zJb9Yn7X+5BzujFIBsIlzzOZzYPMC2FRl3XMBdP6D8pqb77x3XRDgBMkNO?=
 =?us-ascii?Q?02TB3zwqQKNTisXormY3cFYLm4CZNPnRPtJzf27JI2egKTF9y6LEcLKQ0vBb?=
 =?us-ascii?Q?gFhshFz/8DKn2nOyJdM4c7RAjUUIaPZi5Ir5jVWKkABmEkjPOET0KoMYBXF8?=
 =?us-ascii?Q?AR0mWCgvLXDLb6Ae3Jd14ECwqLlZ/twEsPAi/6jVsxyLErnM8LfjgkKR2BCD?=
 =?us-ascii?Q?gSAeYURHCxHhiNc6ZLA24hh9LYNOSg2uxqa0Dovne6+x1snOgN4keFj1fGOq?=
 =?us-ascii?Q?+mg8JwHsbis5KQ6L+dK3ClilSRmhK99G0bpvZI7mn2Tryg0YkeiJy/mgg6Fo?=
 =?us-ascii?Q?crfcZtpWJMkUtGbncuYaCUHCc/Xfe084xrHucGxWEVu8aGaCBvn/KH4yr01k?=
 =?us-ascii?Q?kcKY9veXHNV7ArHaHEf0scpkS+YxU3LTdX1LJNT/cT6VZdoLQ8GgGLOzVaaO?=
 =?us-ascii?Q?L/gsg60GwSl2kuUYGItsXscrYU13/FpePBzY0t5CvNNJiDg0F67R7mWn9ZSt?=
 =?us-ascii?Q?j0fax80ic1MEyMiuK5NPY64UJ0tyG1FCnOS17dzUazU3RtL7SjXfwrMYtAVA?=
 =?us-ascii?Q?Uc4LS60kmf4ghPiSmgwDIF9XAjjpV/RG8vXYsSsaT7RQUKTs3GQDOC2ldZmH?=
 =?us-ascii?Q?6zLDbykoZLSp4PWRsVzjCrUBUxZDlAEP48df8S2f7/jTGN8tlKJHgTLl7DM/?=
 =?us-ascii?Q?D3QSCQmLoG8evMfUxKb2rJzvCrwb25nDlGLK44+wy+MjLB5hoeXxbIcuC+Sr?=
 =?us-ascii?Q?7/JxS8w1a6TwfN5zapAHqYCdlOFXstj4LRsZbnSZDGUSxCAkp0g5PC1faNKs?=
 =?us-ascii?Q?OdbvxFT3x811BOj+wFILy0Ts9R3XQdEi6FcKAaQS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec15952-83d1-4a0d-1e3b-08dcc25b2233
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 03:33:05.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEmihjOe0McY7FiI8WOW8kfM/pW0qbR35pqS1edXEh2htBs51WvH0w4wDddmNXqthhnWvrxxs4hqSJhgNF0ktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693

J17 on i.MX8mp EVK base board is a HDMI type A connector.
It connects with i.MX8mp HDMI PHY.  Add support for it.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 938347704136..f118fe8ab5ac 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -56,6 +56,18 @@ memory@40000000 {
 		      <0x1 0x00000000 0 0xc0000000>;
 	};
 
+	native-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "HDMI OUT";
+		type = "a";
+
+		port {
+			hdmi_out: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
 	pcie0_refclk: pcie0-refclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -408,6 +420,28 @@ &flexcan2 {
 	status = "disabled";/* can2 pin conflict with pdm */
 };
 
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+	status = "okay";
+
+	ports {
+		port@1 {
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_out>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -604,6 +638,10 @@ &lcdif1 {
 	status = "okay";
 };
 
+&lcdif3 {
+	status = "okay";
+};
+
 &micfil {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
@@ -858,6 +896,14 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
 		>;
 	};
 
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
+		>;
+	};
+
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
-- 
2.34.1


