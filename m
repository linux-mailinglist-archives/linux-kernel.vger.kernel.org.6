Return-Path: <linux-kernel+bounces-510755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306ABA32185
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48E9C7A38FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CF8207666;
	Wed, 12 Feb 2025 08:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xf0apMFi"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889E207E1B;
	Wed, 12 Feb 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350322; cv=fail; b=OE5v7OW71envFN9IUeOa6r6Xt7HrlZBa4iJ+tL5JbCVK9oKAE/7pUpprcO7ItfDBuNtsz4UpZBWjfgd0ds4VY5ElMpQjGQwsyfuhKYYoeDWxm9wUxew4kjhUuzPxYiAyRP5vuaRP0fok3ECf5pIVo2SPAePhs6fQAvzEaYm7Fhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350322; c=relaxed/simple;
	bh=RJw36SdxM1yIOmznJ6+pXyb11F/iM8Lc/x687SL7Q44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kd2KtGVioUNv9djMjxT42Wfgho+zs5DyNkcUfJ09tRY8VPXhlf6ToxgGYca5RM+kZ8/rX33qg5KDceyep/B69o7hk2QUxiq1J2bFlbki7rHDM6eZRwTjmSa3bv1X1wQV/GEfm99VTvUszjCQ+ezljO2SOx7wrLHzPHuP/JmJ53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xf0apMFi; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1AVNNqk/QL/BDALcIgYazJYqg3w9tQr/vVC2vFXur9zjdiQm9kcNWFFM8m6NcU9SgW7JZRVMf9iWE4+5tSlpdJhhNckc+qMbgQe9o9dMQLQBdMyOGADsQO0BYxU7XTCjfnn9aJIoDIo9U1p+oslWwPwJL3K8pXh8sMrXHmkc/zEA+isr4R4dTLyL/0KsFJPVljh+oY8+lhB+N4/mn3jZzxV6iXIKpdCbEvzB5vMJrHlUHSAOucckrruvxuZ0veSHvkEEuTkoqJWqXPu24ytcEaQKFiqtQI84acfVNvjfUg1UylD357Er1/w1H9sn/HW7MS28TlTiXQEyIiUMKSDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DAqwf5QbXt9AgcB/MWt4CKwRQKmLUR9cd0+Huhu0BU=;
 b=vSqfj64MWEBQ/MF4W2+ug9ue2LMYKoOIeWUXAz1ORHKMtoizfn9VoiloMQImbQBQRhDxHYaf6de7tJW5LTPz7QN4HhnHMxHCA0OxMHJ02dC37zVg/M00gj7MCpVEb76eeyglQHhoAFNzgVCuYKlKnedbAR2/hHSOz5SafBS33fMF+Bu+Z2rvzFkaPohJ5RPJVGmTRKSM1dlIr3LIKhSpZ8f8Kt4tXx7PPom7Qws2i+xQZVM18O21m86NbeDEKVXMh/KAV95hmlAsze7Z5sFenITw9j3ku4bcxlsQmz+PQVKbR3diLRygxHrS9IWobgd4uuuCukqVgYIrzWofp9aoBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DAqwf5QbXt9AgcB/MWt4CKwRQKmLUR9cd0+Huhu0BU=;
 b=Xf0apMFi9AzpWarXp5yJZ1etx3w7rVFRlZv77IILQ4GnxDfl0hYTcaQB98Wo2GEsVpB9nyC1q7zB7dEKt0Uteu22tqpuID2pmU/C64D4weQiX+wKPAZW/YN523oVszOcpcMDrFwyhHvI/JimHvT3h7SNCGdrafbgBF3Q+OfzfBqoadCmgT4x33VcO/qB+oR5Dq0bQfgq6xXCUdELDaRDf0cTacyIPwQqNxeQe1UYektkWTqoUSKQsNBa8MF4LWFOddPWf3cNABMLrQ6TaP8dsXpyXM3Fhe/jZEHo760QkHZf+EzxKns/kP8+FZRy+KSkiglJ/Rnvnw8Zfpc7bjlf4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Wed, 12 Feb
 2025 08:51:57 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 08:51:57 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	robh@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 6/6] arm64: dts: Add dsp rproc related mem regions
Date: Wed, 12 Feb 2025 10:52:22 +0200
Message-ID: <20250212085222.107102-7-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212085222.107102-1-daniel.baluta@nxp.com>
References: <20250212085222.107102-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0003.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::9) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS4PR04MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 536c397a-09e7-4ae8-5ce4-08dd4b4281ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fR2axu0AtGjfi4k2puXhxjIWxx53meqXWC6jK/Dq2NtuYSONFo4gySvdESfL?=
 =?us-ascii?Q?pvdP9SQXcN4mpLXpY4rHzsqjML/6HGDChtVxSIOuIbWiACg1q0OXNQVh4W2h?=
 =?us-ascii?Q?iwiqeUVQm52X6CM9HtcDg2APXZzHFS0a/TxzITLcu/K8yt++sLyDvvgpBxsk?=
 =?us-ascii?Q?rozEEWF/xiol923mFnUcYgOb5FXo9c/Gxc3yg5Q022Lged09fJYsHQqe59AV?=
 =?us-ascii?Q?OYpf+Cf+AVie2JKHpmY1FZ+aVkYDRl3m7jAEHqs3DoU3zaU+yBfXs+KjUGJq?=
 =?us-ascii?Q?VOj8aoF5n/k7/Dc1w5/px1vKoK+W1hfhA/58HDyYpwVLRpEtutmZ63EKYrL1?=
 =?us-ascii?Q?Ww5Qr+VaP11RUc3UFnyMp4rN27EX/A5EWGCF1Ls++enDFxmo3184GY0ZuP+I?=
 =?us-ascii?Q?OBTmnPZss5cv/OWYO7Ei5iAl9RKTbx+Pn//Zuv0KlgJ+clo7h+UnjP1Ku3Bp?=
 =?us-ascii?Q?AJn056WisUfs+JFtBFHBS+eQ2lnvnP7BJWQB/gHETDugfw/afHEPyRmTCJzR?=
 =?us-ascii?Q?v5BqLo9pFMqw7HrG7HuMzwEK4NGRL9ghgaqNvr1DnkgLrGJcsk5QZK9zSFEq?=
 =?us-ascii?Q?qieLcxzKqiieAVqxzcUTpOLOnb1mpEuBvhlxUFaBaiHK971PeaGPF8GE4ufq?=
 =?us-ascii?Q?5st9NlkN92Dslw6WF+znOv9wLuh8fn4v0ZW+9GE1lonVujsveE9aProB4TCs?=
 =?us-ascii?Q?4qrfaWW5zX/fDOeGrQP7raV00BdrLYxn0m7cGurtqdWNXyigBMD+eyfNRs+r?=
 =?us-ascii?Q?FKsDfMo5maCNoRyZFC/ac3jvUhhuXxyzv1L+H/vP7l0+MKkxKuXISqElPu2e?=
 =?us-ascii?Q?4Kakn0teEHajuls2GEFTtJLEplx3hkq3S7HgU5MzlcmdizuXkKt9VSzQMEMq?=
 =?us-ascii?Q?CrMNoZNWaorVithHtLetMcoijwHq2sZdHUOEd7u7cfAJsp38gtLiIQUzCh0f?=
 =?us-ascii?Q?kxISKRY/UDO7NREWLYoZQvM4Hl0EJflniDZSNJL47DKASRMYIRySH3P5bseR?=
 =?us-ascii?Q?9DDVQ35u5L7Nx5HOFx7Ug4Cm0eqOlUfRmYdN5U7oqiGJQmsElYvjGXxTSDbq?=
 =?us-ascii?Q?0waQOLDHwhrkDRqvrLx41kYMNpYWpK1n+dIj9T/t94Rsd78BLPylr9DLhlPt?=
 =?us-ascii?Q?LdY/ziWiUCON5C51ugLaL02bQHj5pvPkwf+1G3Wm88IT54VADzkBcLjWiGLg?=
 =?us-ascii?Q?EbP2dtrJN0WVi/plCDRi2MU48M6KP+rAX9v8Z8JHKuJBj6t600QERjjfTkQM?=
 =?us-ascii?Q?/HD0HY7V9wvt0WrvXlDUbDQkm56/ypTjDwNtx7uBSHJPHYN6tXk6SM/5L1IM?=
 =?us-ascii?Q?ZGFgdmq4vJBD7FrR6Y6LnxrdmVPw+915lSj5ktnZmVStHMJI/aYO2ZY+bQC1?=
 =?us-ascii?Q?NpRSCDpMEdLiNIQFCxQlwobmS+Z1LcMZOIZCv5lBjU/0qNcmIawC9DRudrZO?=
 =?us-ascii?Q?bVwH4ln+J+Y8bT3y4ItkNzRRzKIzZt+t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jCAhk28239NqgJfQ3JpMKKfvsJU8MBeAxyWXP/ZmrH44E+VL5jim1pcYquhp?=
 =?us-ascii?Q?8Pyn6VQUbw14aETSZmxDYnKFaQReld4kHg3XndagJguVWhYgzFVjyYHfKix1?=
 =?us-ascii?Q?rqZxqyI+TydKAvPVwRYW3FmWuvhecwuyAA/vVwzK+yHghxQ+5FppMoYS+TV6?=
 =?us-ascii?Q?vu3opSyOwJz+C8/GWRu87Ieifui3FwGr+F13u9ujGI/bqNWeHY43Ya27HMh7?=
 =?us-ascii?Q?tk/r/zclNUcX0PfQATIF3FkE3YuIa3BenKV56KGGnV4s+3hevr94qRceNmLJ?=
 =?us-ascii?Q?2rWxCfPXvTli5j397mwSAqqkOJ6fyb81RmoPbCazi6/vzm8RHgLuhsfXfPrG?=
 =?us-ascii?Q?AXP/RNESMLwQOjKJoeGa297kM3jcP9hcWQhQoZhm0vcscMYC/+ChY3j73muW?=
 =?us-ascii?Q?3lhd6gjcfA5GppXHlAdIfO8VsXRaz4KvTGo+G9rkzPcdvbCgHAlyCvZ2/s+J?=
 =?us-ascii?Q?xXVuYsack3iBv1j8GLqgwEMHcE0hhcPNGJJc4sHw6pKUXqzs06vQW7dneTT+?=
 =?us-ascii?Q?yBUpkiyOo15B1FPQ2RORYHjl/YUHiI+fVijgeepSPVoY2FFZb3wweNTPoAXG?=
 =?us-ascii?Q?VI/cxAatWj+uAydSlA2X1PMN4RCPO3EJW5Y5xQGmcp1pHOalm5JwohrRS7DB?=
 =?us-ascii?Q?hHKtN8EkVqsT11a8v9XN5RpdOTaTBo4kUVibTO5CuTHGlbOKga/tcTq8RMUt?=
 =?us-ascii?Q?WQ9jQOewnJQTYoOFH43myZDojB0eqrQxtDOv04rB0YnITftY6qbL2fVmiL1A?=
 =?us-ascii?Q?fuC/1/+bAYzQ5fRbAmhCCry3ZXX/RHE7LBFbY6Ip/BUGEUBE9+U3Ooy5aBkF?=
 =?us-ascii?Q?OVbA3L0QPOnd16IAYsL4j/XBiXMZkAmGcNabIDVZNT8a3AB/glhRvQwjeseL?=
 =?us-ascii?Q?x7Ex8WeYM3baKk3NAaVIDUOmbHdRODqqKLOd76SPAw/GBsnwEhbqLv8FT7Qy?=
 =?us-ascii?Q?EAm/tYIOjAI/7lpUSLgMXCqHmx0zZ9iSKaS/ROTds76ba3vBKhoWbnqNkY1i?=
 =?us-ascii?Q?+sfz8dGfgXmqiaremlz19xCZmh/QfPtCwbuujBlb4vk9z6Em+A24bY46iNij?=
 =?us-ascii?Q?K6680wLkVtKKog5ZhrgwIQzJImcIipbJDinpyIwrMcdy6ecb6nOj7MC6oNAa?=
 =?us-ascii?Q?Xz8fpUVyWpXwOFP6AqI2Y0grM3mXOEYAd0nIgYrPb+p/8DuoY5gKMzW2l/Ny?=
 =?us-ascii?Q?f2ct99bTidBPm2X2g+YVxFbshCgzaBpYDW+CYxjN0XpmSWT+ztA3u/0zzt3O?=
 =?us-ascii?Q?tIl8pF3CjncvwSP49/njXXcczSWAkQLQTfVqt/Trf5cm0rx8LAwQ5qRiRwBA?=
 =?us-ascii?Q?TPyVwG8gyMFqD/a4eJ6rLHibVqhT00sgEZak3M6z8e2xbtjqgXYcFUEBbmfS?=
 =?us-ascii?Q?DPIcHCeR7Gj2ukdQm57NrufLm4IP2TzJv/t7xo1y0pj38LSnC5ZNtnsNsTVh?=
 =?us-ascii?Q?HDNKARvulOSFWJMwBJPsjR8wQSN+MkHIuFm4ljwjusWaXMOliSFF09xke2O+?=
 =?us-ascii?Q?IZtVEZkPO84Gyl3g/0W+bcR3bZJ6oO1NYs5/h5jIJNcxR064htwElODlWQ5L?=
 =?us-ascii?Q?/bGbD/xF2wJmV8J4V3X8R0HONP/2Rd00huNi3AaY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536c397a-09e7-4ae8-5ce4-08dd4b4281ab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 08:51:57.5276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apac2ncweBAQ62WftNwrc+uyclfOMEsGe52k/0p+JQhUIo2QWjL9dP4n0Mbd6C9Dln1CDuqqyA7QN4+PqO7uiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9576

With imx8mp-evk board we are now configuring 'dsp' node for rproc usage,
so add rproc specific memory regions.

Also, enable dsp node because it is ready to be used.

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 68e12a752edd..468bbb84ceaf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -291,6 +291,16 @@ &aud2htx {
 	status = "okay";
 };
 
+&dsp_reserved {
+	status = "okay";
+};
+
+&dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
-- 
2.43.0


