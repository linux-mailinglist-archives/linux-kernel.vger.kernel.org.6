Return-Path: <linux-kernel+bounces-275001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C94947F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413DC1F2240B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86715C12C;
	Mon,  5 Aug 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eLDfOwX5"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4F812;
	Mon,  5 Aug 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875440; cv=fail; b=nl/HL21jlgVjrolyh1WjQBEBn64c0sxZ8eCqS3zFRMYRF8uwNxO5A4WMyxAShmSPUpP+/rZeh/XgHSVtaNhWVHpDGwXfo7gbdjOsQFbXxJoYixDB1mZ7gC+5Xe9TmKfYAGWduKTazyPG9nqD006xhFvMdRDcJ2h5m4DTtsZ0K9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875440; c=relaxed/simple;
	bh=JbbN0AOVBPayR9UNYTgzGWS3a/6mBC7YSWP6ZArediM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l++gkMczZZ0Zq8nmFoSDUM7rfEN2HlCQdN6Wq/ykVd9mjYlUcACaURx3/xsQrsJQ/f3tqeesRke3/9g3ffJRL/XJFlOjM8so6Z0xpponwmHst/JK4Y0DP/uhf0nBXr5YH6Eh0pjGzasWXaE2EX3ZlB30tJXNQywqX3aIT+IoRM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eLDfOwX5; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwKomtl3PignfZzHpnZ/TtQeJXx0zf99rc9w6gAzyE/TgAUQzZJaYjYmy2zzvzgwShofkri4sXipHV9HfPoKhc2T5PgapuxYeadPBVWSiLKeYmWvu1PetcXvCgPa+V4T3gAA4+ipR47d0Y9bFIPOwx/JCv+HnFhTSfem27v4jl0N4zoQnyL6VYXxU1RGoVCaJdjVqGuXY6tfZdN8NGA4WzXyg2mXak4qEq25/fhc1wXwPcXH/29Lr0QK0l2l/tK7YVQzxYqrvpkQWYpzrPlqFCPhXTAwlIc41AnYq8QwwGTfoY7DwP5z+MVU55kCvQiekagVKgYwnpA02TRGHMISTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuhxX8fTbC/qJH+ZG5gW0xuqggkrBDmG1DQg/ks4C5g=;
 b=UaTCQzKIKDT2TDAgWh1xN7i2M7hb7m1vXEGtEzlkdrwLGtZFzjGHzLEcb9B0LART2oO90OxSXrMasOOiDZyapp6oF9ES1C8ta6KetaCTP97bH/3C1vybOKtx+BDXTlSvnkVFhAK3pZvIfNsXe2NhX5j/+tkJGKkWYRLaSmw2cP3ggjmVJxFH+Rf82dArTF1oKeb6F9EQ4YNTkWIg3Kz7Vw9hmaPUjV1jL2hB6kv53g+h5EchdyiB0LIL2SYGaWl3GdElHBRWjYOyHEps0moNpq0MpYfGvfJ7LjS2BZts3/SEN8+o7jaxn3OYV73LXFO3q2oRfDU7woY9PySk12WyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuhxX8fTbC/qJH+ZG5gW0xuqggkrBDmG1DQg/ks4C5g=;
 b=eLDfOwX5GoboVawEUwKXxYLgfMRktgRqD1KjNnFM9JrE22wAWVYQiiYxJfoZGA9qD/Wk6uSsDV5b1TnuzrT0fmYaB4qpc+PRdKb6OyoG2ez/EQ8LGAFqO9cR565M+Tcxq+gv9JB2ZGACjvjOBq4ZJmMiAVoD/v3ievCTK6SifQBz6mLWhwaPNmeTK8cBwPX/pN2Xvi8bOOlAjwBnWwzZYfbsfaZLeHUB45V59GxyC/eAgnCMjWYiokbHXF9jFf25rHyNojXPwk9/bxpmrFLy7UaGjNRL9ghxI5q0CLeo8xAzFiSQEh/Y8aG1Uy5FBU0PnMK0o8nZkarrLHWfzcQWZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10122.eurprd04.prod.outlook.com (2603:10a6:102:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 16:30:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 16:30:36 +0000
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
Subject: [PATCH v2 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Date: Mon,  5 Aug 2024 12:30:18 -0400
Message-Id: <20240805163019.2932223-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10122:EE_
X-MS-Office365-Filtering-Correlation-Id: 569eb257-657d-4e03-f6a5-08dcb56bef30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6LVUPgFHx/92mDNaiv+SGeBW1aTowPjNhvyyMPZ/Dv4MfFMqJvC9SuAj2Dtr?=
 =?us-ascii?Q?VoR/52P9A3iv1I/pGthqcWE3LE/QPrrsl8zB5Ixh66SwaHKIX7uqQ0bSA4sC?=
 =?us-ascii?Q?oxAvnexPZuFXLHRgx63bmHP+zZmEaVKRMMVvT4oCsb/y6Kgd1EGcDLzLRH49?=
 =?us-ascii?Q?tj3Z+/gpcXe/CSA2keBpH/oaJpt1S1w07kROlApdQMDxPYrWRE7lbGkrBabd?=
 =?us-ascii?Q?6MENYb6eFgwOHr3q45o/+wEKF+oIetayX4YzYNZErw49+wWab8DRm6oDkAyO?=
 =?us-ascii?Q?uVy+UG051Icoc/WjE15DDtn3N7wBl3q7H5Ee+VkwLCYsL9YjwlJ38T76MT1X?=
 =?us-ascii?Q?0D1y5Cwok1R0miDTACDwFX2C23qz/WCPSU8WNErfXiaULqqsfm3Ty2BB+/eB?=
 =?us-ascii?Q?LVxUdx7OzjDBhJO0cJuy0dubJwYNHuxXqwwe4jbKtDbrWsbq29Smuxr6e7ZK?=
 =?us-ascii?Q?htXXBJyTnCWQaDVRF6XDD8g8L4pUMwEmcxRH3TK0Xl8jo7f+w1KPDvlQEakY?=
 =?us-ascii?Q?ji56Xr9Dqk/IgaudzCkCm06KiPCi2LsO8Npi4lUjTH8mze+s+63g2+KBZAAy?=
 =?us-ascii?Q?YuTrWRL8nV/ELxxse9AnIYm+IoTPYpIt/xZOHG0h1vwvSgclU+zj67P3Bs42?=
 =?us-ascii?Q?wUVQGabo2AYX9L4shLX617aIAUz0KzIFAzuPj+GWozX5cWfrVRelC84UTCyP?=
 =?us-ascii?Q?fbSU5R3Awnr3eFReuddx/h1PmBYpCG0Hv8wfb993xP5+YIgOFzP4X5FjcqkA?=
 =?us-ascii?Q?XuQ6U4ojJw6tki7mYnJlOs/kOU82XrbeIAqoAIr1tkBAxnn2ftMZK26u1nBp?=
 =?us-ascii?Q?0+jlJ26OdgTupzYXDUMV01CXEG9kdUMKxQ6GfakUgKYp04XzxI3Cs/Jw1lrN?=
 =?us-ascii?Q?qAoCpOxodmk6J+DEcOMUVLDECmazWKAyDNzxM0+DD0vNhUikfCTQQVMbZH0r?=
 =?us-ascii?Q?x2duc+Vyn2zLZh0AO16bmN20yq+Y5LdHkNrcmOxPuzXU8brSPzzZGEQq7KyF?=
 =?us-ascii?Q?TfOZl4BSkPKYHprCqS0/EZQtf+8nLiyUJm5C64H9dYZ8z9R2RLsuT83noCqR?=
 =?us-ascii?Q?tGEI4WoVOpO8HjrcBp7KznyZuSLLebyT8zQGjVgDyH2802qN3zDb810fnBBU?=
 =?us-ascii?Q?6gAoeU/J7+RMANwnRKv0wHLuheIAJ5Hu1FvukpyzOD+M3/Y/ITcrE21DEOJl?=
 =?us-ascii?Q?vGbDOLfMkTj3Nqub1/3EC2oynIbj4CekaXmmNeAUMbH27uD7RjR57Yd3ZACQ?=
 =?us-ascii?Q?Ae8gvl40Kdpo9woZErsREk5ZHEhMCkCE+Q3r5wWcW0n1KQ/2KpvCUEEnC4Kz?=
 =?us-ascii?Q?xIccyMs5TL7+SoD/hBC/6OalQtiiom/o5ygWoRRXx7WivzmZxRN5Ko7hEG/B?=
 =?us-ascii?Q?JMvbiI/VI+uoSzUA+A/o7RBX90lwrRserql4ZK05VF32YCZLAeHecU129uO8?=
 =?us-ascii?Q?Zryk22N2LRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1llF+laaNCwk0sqWGkvY2FaKfysQCkiwcxIjxCuMXdzEIuSLHP1Sux2nIYPw?=
 =?us-ascii?Q?cf8zf50NxRXDOj9oZEindctbHJ+SOtpAlON7UTf+gkltq4pkjjIRVi3hYko/?=
 =?us-ascii?Q?yi2dTJdX20cuVbsu1gdMV4nZnY6T+4SvczZSg5dlV+dKj153bq1/5QdejHst?=
 =?us-ascii?Q?xkLzMjiaNwg7dcKVgGJFVKFDLRHq7YSzLAbiMG75cftMpDLMEvZiQA6NGR0u?=
 =?us-ascii?Q?mpkGvjNNQCICb1d6OHyYKLN2agleeAHoQgaoyUm23t5mbYHLI+aTZcpukJmE?=
 =?us-ascii?Q?ZttDUQJS607mNp4LenkSWeLXycNutwVr8pahfGg/dRqfvdFlLPgPT+A+FD04?=
 =?us-ascii?Q?iwDXte1o6WV8vtqW9Y4cyAyOljOJVOhPqtbXrdfbMQI57KoTg0yiMRKjqt8b?=
 =?us-ascii?Q?g1qkwyGR+Dw07hD85RxhtxrXPSjmAfYgJFUSvF+Lhz1GGzPMkXnmdLpSqN3N?=
 =?us-ascii?Q?oFj5/eNrr4DDLDWzJjgYZjkSURvLWB/Ow5SYs4/Mvc1vBgODXnPixM8Ryp7C?=
 =?us-ascii?Q?Ujuq+ldI0GsTDWlXHL9t6RmmWiNkiQ1OXXbLh9G8NZ0gmvws64DYVkFkCgQ0?=
 =?us-ascii?Q?ajcbv+TaRWwCfWKr153XXjR4X8ZSshNo1nqZFZEKZsvi8LroAo67bohvFrQ7?=
 =?us-ascii?Q?WaErAQ8hdkXgbmL4uPgpct1C8ZHBKUaAtRm46E9oLDNasxZyrzI/JHqITKD+?=
 =?us-ascii?Q?0U6kLWYcPrtU4Garycm6rsTe4IwKFqlgLB2s+cLncOK+tJGXIbGJSDUJAMYH?=
 =?us-ascii?Q?SMdAGKGDtsIvd86PjzWHLRkaVEAkYFx0Y9AgUYy3xXWi098uKy5so2Me0GPs?=
 =?us-ascii?Q?at0GDhV20q3bX8DwsN0chAZElfdKHGKqPtSEKX05duNZG5HZ6OKW7mI9vHNX?=
 =?us-ascii?Q?6MyBKFHdoNrMDtARWjGmR4oA30JHp1kQHbSpfQ9GpENPLJWZVxNjLDGXPLg8?=
 =?us-ascii?Q?MnIMWLmbFaXv2ZGFEgFZlHNpkYjc/IJ4eMiJrfGsghySKPAASVubd6ajtWVN?=
 =?us-ascii?Q?BLOuQONq6b8JmxOcv9p3Sx6KpMq1jU+P6gxKviPjb68/Sf37dF2NjkkhSyZa?=
 =?us-ascii?Q?xEF/O/NR4CO8YsXOVxvjoILNRX7ScZcXMSUUVyiwBdKSN+UTPuRAX0ykAha4?=
 =?us-ascii?Q?0KXcLDAlpdimmpG/8rZk4x0EtzX+ORIo0ahbO4n25qA44q/sFtrjx8PkRS0N?=
 =?us-ascii?Q?/PVbaD1zZjOF4Enhc8TzT8W3eTbdgv2r4LQaCmMetKUxaQEPEAmpDDBRlJtv?=
 =?us-ascii?Q?lL19RitnN4HRjNi1AhUBpSB4+/fkvTVcfYI3dO7OkitN+HJEAEiN6lBugNSG?=
 =?us-ascii?Q?+KQlcqH+h5TY4Xk4X/9USiJviG3rB2EZqTKjgthNUE9KeGuAYmMTqIG2p1X0?=
 =?us-ascii?Q?67NGF6bmqzkdBID3pxr9Q8XZ+0FYWReynqQRcjHDVh5KbfdK8rgHl/HUJMvu?=
 =?us-ascii?Q?MNN7lS2gOLyDaZci0cZrcqqMN9CMYNlZeoXWCSCs8kLdQCuI37MUG7OH43Rt?=
 =?us-ascii?Q?3ck0TmDNWtvk+IOafR0dXUCOOs0E64z5OpbJetsocg9dBy9YM/fB/8J5AXaB?=
 =?us-ascii?Q?tgrLILL0Y1iR+yAcHYoYjE6pPpvG+NKybptZ5tX+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569eb257-657d-4e03-f6a5-08dcb56bef30
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 16:30:36.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnLJcVUlIij8bC3jPFrlSjfkeK7vSj5vDzVu+amxzpXSPHnchNQ7GIpaF+0LAMizFIy73RZcpOkOJKJsJSnCWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10122

From: Clark Wang <xiaoning.wang@nxp.com>

The i.MX93 11x11 EVK has a ST LSM6DSO connected to I2C, which a is 6-axis
IMU (inertial measurement unit = accelerometer & gyroscope). So add the
missing parts to the DTS file.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- update commit message.
- use common node name.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 2597c5b2eacb4..23c96a418682d 100644
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
+	inertial-meter@6a {
+		compatible = "st,lsm6dso";
+		reg = <0x6a>;
+	};
+};
+
 &lpi2c2 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "sleep";
@@ -504,6 +518,13 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
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


