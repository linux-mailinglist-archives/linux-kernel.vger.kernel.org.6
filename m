Return-Path: <linux-kernel+bounces-374765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A59A6F99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C9B1F26763
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386E1E8823;
	Mon, 21 Oct 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bqm+4YjK"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0ED1CCEC3;
	Mon, 21 Oct 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528503; cv=fail; b=Vfasq9sukbkcJs9eAaXWQgMn0PYPGErvmEEZTe8LzBK1q97vFCRNlVibkyWOMGn6aECjOVsWoExfbwjYWAPgWxrRwSNKW5lLKQIa5cnfaQ6816pCqZwUH1f9ugl9Kmtw2KMczdV2CgfNAtOYoUXX/oqkmKQRcyKu3VauxzYxRsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528503; c=relaxed/simple;
	bh=9AKSfmJooQthlkKTgVBRfaHpxJdhu4leJFUObUf454c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qqAiQ+2eg7ex+2P8spEgaLEopxtIBDs550cdqa/SEV+0TbHFo3Qfd5g9tO/hp8w/NWtyy7PVUb1N1rghsZvqw7rdFj/YoQgsH7ZfUcyHYRSohRmAjU0GafbTcH0RU3ztk2plIQ8yreEj4y2pGHDeVROsEKgno8RUwfzTCmujIAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bqm+4YjK; arc=fail smtp.client-ip=40.107.241.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3Ki6zMeHiTEH7zRlLPEM4pT01hoJmj0FQgPtUWxvo9C3P1VCnZox+rxIVP5PCwazzS8vhgcTxJxjkevZVvswSYmRGP28UAUH0mokNvSjcWDrarp04Epj+dGDRyMkt7NKiIpGtxJ3Z2WiuXVUrrC94Lt2K/bFj59P9oaMCFMeHDf+iwwHt/daKhfLFPjVZkkuxdpEmqYlQioz75iTPNoBJq6MqvWIgpztv0+RoHcLl/i2kk/ueSx1X7VUFbQQ3jbQQHm6JoF5V9wECSaB6z3KRZBCaEM/Ad+cK2VuAJyOdEVF6SSvHFFistZi2GKf1+hh6s16Ku0FhyVD29BZOVEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Jobsi1Q87wfcxwAn+zkEzDMXKEdqa79fU781bkEItk=;
 b=sUUYIDxOlwFExKlZWhcGPCEaX0vJ7sgcpP5zHGf6uE79PP4uQvV6pcsh5E1PyAIgRiDQd24Q2wIYxxIO0KczDssawNSRUcheq4nJgHM4EsTdVk+ujY4r/5YgQtc2pFRMV5Uq53V7UsTba3USVkXlRdwxlSitDALN6XeBEjXLHjMwslxksLDyG3xTLhQOn7+OvoitgkB7j8gjFhOF68pV66pG1CtL6r1QtshcCoeLiGUbTy/cfHHFqWyPhNGBbG3RR8HH/I7BtNourJuwbTWwd1Xvd+SF1mpDm/eEZZ80zriotA5bugZtd5tNDCb54UWGSZjtvfzqQ9cK0NYTXROmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Jobsi1Q87wfcxwAn+zkEzDMXKEdqa79fU781bkEItk=;
 b=Bqm+4YjKMw1duwBOVfje45/KxRqWzM4IPDDG7sa12mrhpy9ye5m5hMiDnjLptGl7fBbCMWSxiq4j46VIL0qD4bQ/uuayEPT/H43AIVeG1yiLsZGNkMpYz/9K8ZTtskJaPIlISQsDQHxh9sJLyAjEvQZebMWDcNvPaAZY3LmmbVD4LX/wX8rzxCFHx4MdmPPVZ5Sj5HUK6OPgI5YAnCYItwsxN0YNHuGWNRGHArbVNa8N6bF5/YjC7uYJU1L/VEkXgGFxOQnJzGmWnM+/da7jL1FoCp7Gb3FCakb0jb25Ro6JBha86D8zVrp/Frx0UNbqlRDTa89jCR7Bhn+LVI0y0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:34:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:34:57 +0000
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
Subject: [PATCH v2 2/6] arm64: dts: imx8qxp-mek: add esai, cs42888 and related node
Date: Mon, 21 Oct 2024 12:34:33 -0400
Message-Id: <20241021163437.1007507-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: be816fdf-549a-4d4c-b03f-08dcf1ee4ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OA6Dj7E+pV7QzqYVLgckpD241pMy5q7RpDcCBxac+OCccvSjYxwoNanCRzfu?=
 =?us-ascii?Q?2+99ylioXMbhZYAEojkpOCN9ZdnArfAHk8l5DrogtsdDzC8ysPL+3RgY+IO3?=
 =?us-ascii?Q?h3G5do042CNaT6blgfUfNiXQ3LyjPA3f1OJ00psAkSm+XzR8mMLr8+wlY8Gf?=
 =?us-ascii?Q?AYUUN11CiR4R902+wGyT8W5GxSoC0BH14jpM0cr2Dj2W4cvOmvRhzmQ5kd4l?=
 =?us-ascii?Q?pQmmvPCI8LAIEvRPdYrraypg8jVh4XbsaPT0CmshCiQWz8+gtMvDiXe68KlO?=
 =?us-ascii?Q?VkcXfFq8czL5JL5M4Szf3et3ORYyqE4uollL8/1NctnhPy+C+gkr8vjggCf+?=
 =?us-ascii?Q?7Q3BKIfVDoVtYZSVG0g7Irj1uqh8kTyDfL6LuZkYlFc1AHBdRENTn8/THmrl?=
 =?us-ascii?Q?v86BLm4mla2HLsb4D6CtdnStjmzNNTqhm486ikEu7SA2xXHvAtvgmqLRoc3C?=
 =?us-ascii?Q?VY34AD0KeqjnimDEn1GtHrBs+7O6Ao5fV+u9ZNacyCY3yaDpxxiQW5ks2wSD?=
 =?us-ascii?Q?7mpgCabeKs7imYUW2lA2MSFi5ahGmDWXkrp0/sRMT3bi9f45yJgMsQDTaK1F?=
 =?us-ascii?Q?kjhi50I/U5wSudA2pzmrcIuOFfCej2AkyZpVmoFxPlzCP2JmzdZutQZp7aUz?=
 =?us-ascii?Q?vkapoAHXdKJmQko2AJg3yUx36R/l82PW9I8x13Pharfa46+YNdKCKKXADC5d?=
 =?us-ascii?Q?0r1fV4Vmsd0z2G7iY48KQpja+UcUK1yXkKFJ3r8clFdq/T7Uals9yLVKUUC6?=
 =?us-ascii?Q?ywuWKi0xUseVvjOVDVBBbSzKdobMIKmEzxUf9erEyeWWOkKQAcgUOYF5CVCp?=
 =?us-ascii?Q?cqWS4M8HcJzkY9NfAtXoWkpQ36UEu0OADj9PDHq8XherGJSgneLn1NwBTZ8a?=
 =?us-ascii?Q?egN3DZfLfwEFrvR5SOPpFDZyXDY2VeYJqnyZmnZO9rp97k3Fx7dtFdQHzqz4?=
 =?us-ascii?Q?CZvTEOyzPjvzQ7ItwirDAXcKB8tSNx/WosKOj8jdrIJnqHEaVweMlUO75Eo/?=
 =?us-ascii?Q?cHaJkqs6RW3J5KR0k+LdUBS2ZoUEe/i0tvuuFYf5Ijzp1AbymtBM1I+5orcw?=
 =?us-ascii?Q?LpB/0LB0m1QFujZVla+Q28dXSn7k1ld/s7UHrYe8UXh7MkravGCLuaIu+5QV?=
 =?us-ascii?Q?r08XAkk+3Xtn78GQ5vl/avsMMuNM04CDFUXjT3HvQbl3o6E15TKN0K8G79rd?=
 =?us-ascii?Q?zBjFuHHxpL5Vo9YwP7rFtvICVI49O5xN9yU+fV96jhkNbVnWNpUXeqQOxNyU?=
 =?us-ascii?Q?rReX/4iFbBSFrjV48MIa2xeIGxQdtu0RV7q7xSHBeSjlkC3NLIiHC873+yFD?=
 =?us-ascii?Q?FHkzmJZziLM8UgClezkb6ExWOebAJVByzxHDjpsT9sCw2rolPmF4vT7hHLVi?=
 =?us-ascii?Q?7axW0zQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5EAbMSqAQUMlKmsHk+E+WewYUfTK2aEezlYqyuG1BT97Rzsq1r43IAvEBcRS?=
 =?us-ascii?Q?jEYyrXZHmgfTkEx8OqPv9y6YGee2hkF/5IUnqy9DLAx3AK1oC87Zp73io/p/?=
 =?us-ascii?Q?kLL0GEwnaOSEeeKsqfnhm5hcxsnVCgUkauhJ5XQPUJEpq6MGQTg11qcGlXny?=
 =?us-ascii?Q?LqiUxSTe5aO1fykiXc6UmjQ2i2bg4miAc6SN7UBFNdRkJT5CgrFnEpcgb8t0?=
 =?us-ascii?Q?glMD+CTA1lnhlN6V9jG98Nc/4Vl9jU/fJJv3OOHAC85cVYKYWJ3b1YJeYxPk?=
 =?us-ascii?Q?1xstyO7+mC6nRAuPB9Q8iwWj2wkdDcQoOpHggdoGitAQ321hP5C5Cej1+1e1?=
 =?us-ascii?Q?8YeEtylycgPVZolBp/SBRxT6i0ujA46IhGLLSjlZ3lnWSnWNP1Xotkr6Bsdo?=
 =?us-ascii?Q?0kLQtXLr83s+eqQR9u745JWsRg1GYxbOMitGkoclhitYs7iEIp/JCAatDpF1?=
 =?us-ascii?Q?D7zJqkfP1PP2eEmQKGt2PtgXMWCdpI0wZNB9lzg9FRjDCgoajzxBzB8ZoPdG?=
 =?us-ascii?Q?7H7nkv273afI2V0yN6dYaK/SboFbayy5LkGdVlPGrlAvFQI1ud2x7FUYhRVx?=
 =?us-ascii?Q?BBitn/TOZjUMe5K3WOu6TSvcTIYuWbeHUxo7ooikD00HBdRsOCmY14xWDJOs?=
 =?us-ascii?Q?zMNbo+gokbg8tFiJ7Z7j5djjwx1cKhh16wMErzuL7u4Eoh5dsyG6ga2mCNKu?=
 =?us-ascii?Q?2OEeJG5zIRJnA1mj0+3W0Sd74/2xCRRDc6I+3wxWFUMJP8CPUf71m/VcNvI5?=
 =?us-ascii?Q?58YU5V0mchVDi7SveocjZQOwEjhK1Ir7TWrMo2tkbimyROUMrXWbSv0vkS9s?=
 =?us-ascii?Q?oK5ZFmkyuKrTW6olbzLFSGcXCL4exuL/H3Qx2jZLv8TGYjhKwFyICsor9GE7?=
 =?us-ascii?Q?y0hcQvPAKXPcVBitQ1kyZeEYBGMjwc7ljNcVfJByysDjTSZTZdS4YaN2p9Vb?=
 =?us-ascii?Q?IhUEvNw+8vaj/4+SXIZ035rH/ceRjaOjthnC++/ViGnDzouhv4DrFCIrqdzI?=
 =?us-ascii?Q?3K4+/UL4T1/OGcPONISGD0m3WK5yLGnZ1Ss4LTxAKN+n0Xwp+xnTPYfNokZ7?=
 =?us-ascii?Q?8vbnJl+bfo7z66CNPf6U+M6R19PVhrhqvPzKgbPuW0N0LyhSgGGvw/RzIAob?=
 =?us-ascii?Q?xzcu8CxdZG02Vr0UauB+II41uqUQWJboIB5q6t76NqhtB8KM7baaCOydxoG2?=
 =?us-ascii?Q?6uYjz7RwNrqTu3i7zrLaw1nJMdb+0grONE+5rUKPWVX6qy+O18SOhPJe4If+?=
 =?us-ascii?Q?AFleLDCtLAd+HtO8XiconNd8h3rqVR0iaRid/YR9qj16tXRz7pd24Tp7r9P8?=
 =?us-ascii?Q?p6WdUUl1/NHXEOHPE+ZR+c3zczGjFEOhvZ7lVAxKmFZIVCJ3VbC5KHoaI5fv?=
 =?us-ascii?Q?SX2pACDcyysLi0VGa0696sTfmgckpvxXAzJs+HqQcPMsx3nFfbkyLqNMYCTj?=
 =?us-ascii?Q?Rc7q16vm3i9jgDPmgS+Nn/zAWnt1l/e+Ti4BnIAcl8GPGo9GfRsG51EtJNiu?=
 =?us-ascii?Q?iOuFb5dtA2u1UcskNxMrznN/XYdBT4MjIRj4hr2stXt/WFxjQ0KEmu2SXZ6A?=
 =?us-ascii?Q?LFMFTL25GiTjWG88F6Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be816fdf-549a-4d4c-b03f-08dcf1ee4ca6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:34:57.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErUeLrxrhwEOKAFjJ8YY0tRRH9MctI3XgaA9MfT+GNq5ScD/imF2CRWoUdX9T1gSigB3iXX3AW4n5IsqysFN1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

Add audio codec cs42888 and related node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- remove extra space
- remove unnecessary status = "okay"
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index d8d9e2883caf7..da8ceffdc7212 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -50,6 +50,13 @@ usb3_data_ss: endpoint {
 		};
 	};
 
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "cs42888_supply";
+	};
+
 	sound-bt-sco {
 		compatible = "simple-audio-card";
 		simple-audio-card,bitclock-inversion;
@@ -69,6 +76,27 @@ btcpu: simple-audio-card,cpu {
 		};
 	};
 
+	sound-cs42888 {
+		compatible = "fsl,imx-audio-cs42888";
+		audio-asrc = <&asrc0>;
+		audio-codec = <&cs42888>;
+		audio-cpu = <&esai0>;
+		audio-routing =
+			"Line Out Jack", "AOUT1L",
+			"Line Out Jack", "AOUT1R",
+			"Line Out Jack", "AOUT2L",
+			"Line Out Jack", "AOUT2R",
+			"Line Out Jack", "AOUT3L",
+			"Line Out Jack", "AOUT3R",
+			"Line Out Jack", "AOUT4L",
+			"Line Out Jack", "AOUT4R",
+			"AIN1L", "Line In Jack",
+			"AIN1R", "Line In Jack",
+			"AIN2L", "Line In Jack",
+			"AIN2R", "Line In Jack";
+		model = "imx-cs42888";
+	};
+
 	sound-wm8960 {
 		compatible = "fsl,imx-audio-wm8960";
 		model = "wm8960-audio";
@@ -86,6 +114,15 @@ sound-wm8960 {
 	};
 };
 
+&amix {
+	status = "okay";
+};
+
+&asrc0 {
+	fsl,asrc-rate = <48000>;
+	status = "okay";
+};
+
 &dsp {
 	memory-region = <&dsp_reserved>;
 	status = "okay";
@@ -95,6 +132,19 @@ &dsp_reserved {
 	status = "okay";
 };
 
+&esai0 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_ESAI0_MCLK_SEL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&esai0_lpcg 0>;
+	assigned-clock-parents = <&aud_pll_div0_lpcg 0>;
+	assigned-clock-rates = <0>, <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-0 = <&pinctrl_esai0>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -264,6 +314,23 @@ pca6416: gpio@20 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	cs42888: audio-codec@48 {
+		compatible = "cirrus,cs42888";
+		reg = <0x48>;
+		clocks = <&mclkout0_lpcg 0>;
+		clock-names = "mclk";
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				<&mclkout0_lpcg 0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+		reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;
+		VA-supply = <&reg_audio>;
+		VD-supply = <&reg_audio>;
+		VLC-supply = <&reg_audio>;
+		VLS-supply = <&reg_audio>;
+	};
 };
 
 &cm40_intmux {
@@ -458,6 +525,21 @@ IMX8QXP_ADC_IN0_LSIO_GPIO1_IO10				0xc600004c
 		>;
 	};
 
+	pinctrl_esai0: esai0grp {
+		fsl,pins = <
+			IMX8QXP_ESAI0_FSR_ADMA_ESAI0_FSR           0xc6000040
+			IMX8QXP_ESAI0_FST_ADMA_ESAI0_FST           0xc6000040
+			IMX8QXP_ESAI0_SCKR_ADMA_ESAI0_SCKR         0xc6000040
+			IMX8QXP_ESAI0_SCKT_ADMA_ESAI0_SCKT         0xc6000040
+			IMX8QXP_ESAI0_TX0_ADMA_ESAI0_TX0           0xc6000040
+			IMX8QXP_ESAI0_TX1_ADMA_ESAI0_TX1           0xc6000040
+			IMX8QXP_ESAI0_TX2_RX3_ADMA_ESAI0_TX2_RX3   0xc6000040
+			IMX8QXP_ESAI0_TX3_RX2_ADMA_ESAI0_TX3_RX2   0xc6000040
+			IMX8QXP_ESAI0_TX4_RX1_ADMA_ESAI0_TX4_RX1   0xc6000040
+			IMX8QXP_ESAI0_TX5_RX0_ADMA_ESAI0_TX5_RX0   0xc6000040
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
-- 
2.34.1


