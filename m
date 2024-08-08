Return-Path: <linux-kernel+bounces-279853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6194C292
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12268281C9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290E6190468;
	Thu,  8 Aug 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HF8Fh4QO"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1ABD502;
	Thu,  8 Aug 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134140; cv=fail; b=d3NE6pAWiT5rFeC/XlyxSCirGKvIh6feyJZISrhFheqHUoZxSj/WIB28wAnubOYBLLCFQFSXOl9CpkGXmbsjfb8L3Rrvt0LOyyM6cX9l62sGoBKlBK6vWNfbFVwd3eJxNFlBToPVwNTUVghxDOU7bd9jm4QXFl0SkcxU1Ns8NaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134140; c=relaxed/simple;
	bh=oQjKh0D/BobRMldJAEA4y09m+di2eakwH7TGoTVED7w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c13V2FUqABf4kuCKocxmvKbDNWkvY0sjhvzj7aF08gwIZHcC+xZarGTrIXTMXoCaipRjfLZqDJsULQZGFDhplI8bS/i61ABRDw4xxncYWe3dmkBPtxcMYY2yc53uQKzgsmnQw0VR8oPfPPzKF8PM9OR8gh72biFjJTu1K91p5+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HF8Fh4QO; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCnP1PX6C5SZmV8M4qMEVZZ6FMiwECtl+nszC71n7EU3sNhJ64EwRoroNyMGUPWNdKI/pTmh4Keg80j5t/qpZBA7I9wGF2f3fcmtM4AhVYhUCMthcQ/QSXYPwH2tZG3JwGJu1pe+hQEcjlglI20MtEIYB9vJ/lh6kPgwXTPfnSjafTpF9vxyOvKmdWiA9ebxuPJFixhUL0bJYIyvEXEZ9LpIVSaUTxO6NU+f+/xjqx5OFVr504DxaZw2tcEHZMNHgeEGxiTGo2oDkb31T28zUl4mJ8u8VrFRp3tHk93UnTp5L5c+ovhKN6ID7ooxuUWnJBdfaY4ZjortwNiaXRydsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNSLMga+Vm0erbTAqizYFkJ8m6X4lGvRGVK3W75O84M=;
 b=lZzBJzbAxLJCcnmkicTjXphZF3DgW9kJCTT7x2LmvAU3DbUD7D2MeBbLMYn01+duOCSyck//i6U6Q5YxYB/RTvxaJK7m8F/kJwkmEvPaklBHEfOgKNWnoOQ6SJDeADAnRt/I9sKklLc5CikT3sDaF5zGQTMHNf/+fgTWVX9xgieE1kRPymfPAyB1mpSdJbqlEzIoVnYfAQnmOmeDdtUXkqHJBCDNx5x80ZQDXTgZwpzP2Y4LEMKC9OF3UPHlz9Q68BCCN4HOCsEbojgmOxe2WQ6LV1OVEHwbXY6d+V5zC+ixIz2cywBRz2ckw1gmQpq2xsrZ7kMRphQI3yqhEXDJ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNSLMga+Vm0erbTAqizYFkJ8m6X4lGvRGVK3W75O84M=;
 b=HF8Fh4QO6TgfEYsHJ+5L4foXoFLxA5RqAfOUI58L5B1DH4cLCA040HGrt1vdW1uaogxHmUQZgdNoZJpYchgLBwLgrM1bs+Gc6rBhjSb2olPJheUWq1MsANJcAxj7CSL61pUMCI6RDjRAqLyN/A+egyVl55APsVkH6tue5aAelDv1i0j61X1WFZIfX01B50LDrX9X/UE1mBuHJ9FLpCSiYIKya0JAjHmwlgTqmyJoQHmtI58rATkDhOCbVKvIZCU+cndnTgshKJpTn8uWijAJG+7ksXSVEaT2rH5+SPwz9lBJMWvn/Nbi2b6/7FRAjjBmNOUEFtmCPuy3GJGHtTf5kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9012.eurprd04.prod.outlook.com (2603:10a6:20b:42e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11; Thu, 8 Aug
 2024 16:22:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:22:14 +0000
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
Subject: [PATCH v3 1/1] arm64: dts: imx93: add lpi2c1 and st lsm6dso node
Date: Thu,  8 Aug 2024 12:21:57 -0400
Message-Id: <20240808162157.3323811-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:a03:100::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: 779442bb-57f9-4488-4eae-08dcb7c643ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RBXILE/Ypa/DQWSELJ1YkaRqvQSiJKN07ENzLxAOGq4EOBQ93e0sFWZNNjev?=
 =?us-ascii?Q?qEF3s496Zwgt68PheuWahpISaiNjgT30v/pUfPVHUlYJElcgl5nxmezzEQrY?=
 =?us-ascii?Q?4L/U8HS7MmxK+N0uZpjBUclEbAaHttaqNf1+nmBVxybRPlw64fCAJ/UsPCzH?=
 =?us-ascii?Q?31EyFPFc0yV08FPU9AmE/UkZebO3Pd6gPUzmdys0MtNY8Q1w0fmFDrOBjY5A?=
 =?us-ascii?Q?aCp9vBmwNxlHCxU6C0nHiFY3UoHm0zr8ydeUqhvG1eIaiEKha33m+ZZ72kq6?=
 =?us-ascii?Q?gbUbmLE43dDdJ6cFj8Ox4gLiXMbMc3qOIGBXIQIPpxj+CSnNUlfSgWLzbyte?=
 =?us-ascii?Q?lvQE8Lr6unAE7sTYFyZECQ/zORw5Gr9k0A2SHjPwJKqxK8bkwbqU1wix8WVS?=
 =?us-ascii?Q?1M6n1MZ2Wkpa0nBiigDbDc/x0Br+xY2/CbXXNi6hU9Ymtf/Lyvo5fldG3f3G?=
 =?us-ascii?Q?9XcU9eAIAoOxwAbbelUJTiNtVE8Tf9vxBY3GkCOB4MTlODxg/rv3++l63TZd?=
 =?us-ascii?Q?jYn5mdR4hRLUIC3A/8TIiWsYibsXoFnjyLflJUrMN9WeLW7WZFweQbEc3Wfe?=
 =?us-ascii?Q?xTlTIFxfes8sYQQBOS3ZiYX4chg5FEdX5B4fOq8qIvOV7wcvVCjt3mCzJ7bH?=
 =?us-ascii?Q?R9ThjA9vt7acRBw9zgEAGavWOcmmVKK1r9HyMR/HYEPVcBfE6jNo1XTzimwk?=
 =?us-ascii?Q?UqGiAoJVnU1Z48++n/2C9fv3MjN8b/dife2PfE90iWzkA2sc5vGOrjRQVMli?=
 =?us-ascii?Q?8zlqZ/cwmXCMk16EA4Do6jaqFBKN9f2+WLeCmjmvFCg0Euh1hcgDNs+8xtgp?=
 =?us-ascii?Q?iqxO1VpO0KvnqK+yiJnukRGzn/qWDEzMnem4e80Hl7wJ2h4DZ1Sh1e0EIeUU?=
 =?us-ascii?Q?iPAqZAv6NKl5WRwQ/dJ62cGCddQgBX+WLBq2I5LouJER6CcSdTFnTIP6pdCW?=
 =?us-ascii?Q?JQ3JEGVF3oSHIv+TKxJ51kdX1yl/bxLcT4zxLXx4A4B7MTaFEZ/Jodab4mj2?=
 =?us-ascii?Q?urz94BTBsKAB/LpN/LfnYeP6ypmm79Q+iDklwNz9CUazDQnImjyUi7Lm6BzB?=
 =?us-ascii?Q?EXVlC9Pi6flY1toJept7N12WMKRt8bFqR2uw68aevNwg/nMDbESP9MfLxZnM?=
 =?us-ascii?Q?Ap6u2oI85M9pgYUuote7l5kbBQvr996ANOkPrWdewF/AYU+ISusJIbJthpuM?=
 =?us-ascii?Q?64mVQiMjW6U08YM3A68TYW6Dm3+2iJhV28JyooWb3GzHvaQKjBpZVXh8ThNl?=
 =?us-ascii?Q?gf9kYCeQifhc/BauB+p/eYJxbNKaFUoa1weqihlFxdjF79kmR+xeOBo6qGY1?=
 =?us-ascii?Q?IOEpHIgniNrqT3hD/knidJf3gkJA4Yj1YKhpwwzTlj68DZuFk7WwZ8bOxht9?=
 =?us-ascii?Q?nihTSHW2wtmnJJeOVyKPQfQejSYkFG3zI2qRC/ccqQNTQClFObM8HPQkuk3z?=
 =?us-ascii?Q?zbrRBf0LQ30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iQJLl1hvADMY9TftbuGStHtgJzqk3S7Gdqt27DHjk9wE5HxE5yUwgGi8TOc3?=
 =?us-ascii?Q?ZLnJX0MCEMwqT5LxMmbzwu+JeTCoYA9TstayZPKQCv6jdLAvwSjbskvE+GzS?=
 =?us-ascii?Q?qNUBNBZckp+O/oeLfo1l0mNnyGKQaxffpG6LqBWxilZ1TlRvq3lk/juGB3hl?=
 =?us-ascii?Q?ThwWrkeWrHpeNgQ3Afc7mfhsVJKAKegRcszCDqLovkfznvI+ZLwXIlTKsCdm?=
 =?us-ascii?Q?YALiqt+Y1uE8o71JrWUH+pOWUyTlohFmOnJSCAGgRJS7XmvrN/a2tSyBkZ7F?=
 =?us-ascii?Q?0kZc7bx5EdzXcpSTQf/urin5hWFibZkGk+BbkrFkTY4nnwxvdyfOuSTdjVW9?=
 =?us-ascii?Q?oxoKC5uNWvdloeG7zKFv2IDKYwGM5mm72pBv3T9H+eJfELC1cvArT5Bhp9Rm?=
 =?us-ascii?Q?BJ9XbnlgyFmsk7KZGSWmiftqILcqFWb8QQ8mjtnQdFecqDaPfq96MyecpFdL?=
 =?us-ascii?Q?ngIZoyy1yQC4lBLGTkVqVED1L9BIlOu+spfhKawTr2WJ4bNozjBAt4ZLtFFD?=
 =?us-ascii?Q?+3o+MbPDYupr+hF7qZoU3KRQM56avM1j7GmsPRoH7TgTdKBw4bpbGYb6EcD+?=
 =?us-ascii?Q?8aMNAu3kuVsdTGUaSYE+YEoJqEihPGtilzhfqzyoHttOj3MkCETj2bZBZ0K+?=
 =?us-ascii?Q?57yDX8o1+ZLbW8ZncIO7HKejlhvcLzMQozArtztxsUntmtTtBgLhCdKd0u0/?=
 =?us-ascii?Q?Tp7x28fAzO0FmMKYbKc9AGFxKX0w3QQjIf02MDPH0ya+2s1KBljVh1f9rICo?=
 =?us-ascii?Q?7Y/itLHrTG/pDVbgz4/vt/iMECK8Lal//YVvxc6wNer/zfs4VnVzCMJSlrui?=
 =?us-ascii?Q?qGv6OTsUyhkWXruUarDBOQBdzUOtNU80RiWXN7fq6o9bQ/M+u3mcxV6gHua1?=
 =?us-ascii?Q?COBrLgp4mLCbyHgwvJLAYhCYuouLkK9MS7eyEzIpY14YZVG3DiaNPoEeQ9kw?=
 =?us-ascii?Q?pFoaLk7YtIoyFDwotATpTN7zK5lYGeSM+3Q6CWc6oQaXlCIbHomb0cjtGM8A?=
 =?us-ascii?Q?wDZI4soMATodHvWh1B8G7954Qp2w/kvtpcx4FmhHDzlTtnUU9nnT8PCh+Mb2?=
 =?us-ascii?Q?3kH6aFdFrivAzCTfrT3GCw8SRdlOiUa5+KBWzpDUhzl5WxhhVTyqYuvk58EX?=
 =?us-ascii?Q?G6uYtMo/FNH+x3sbokxxYnbEvpDD06Aob39A7Nk4fE0V3hZP5W7I5RrosTPx?=
 =?us-ascii?Q?/YnBU1ncWJ4uy5RoN3J9JfMTh/q5vd/4WYuXykWJur+NA4CQ2kPqmsYfSoqr?=
 =?us-ascii?Q?cRirbceKArZCjHri6WHVwhGyVSNge5VqeHvFu/d0n1Jf4VRVO9eXQ4CgirYc?=
 =?us-ascii?Q?9RNyIbzOrW0kl1gbO0nWKfw5mmpYMtPZpLLKyMA7xoVEkpu0sdsC9V5unG/q?=
 =?us-ascii?Q?IkNv4VsqQ9OQhKxbSWJ5uEFaByJLunN1sQiQBI7oDPb63VjWW+Ef0cYIOCHR?=
 =?us-ascii?Q?MjiJ7PUXC/HZW9BvPA4f9cs0RPV1Nf5N/HNgd+kXPNDI26td+8r6iWsoNu0h?=
 =?us-ascii?Q?tNJVeFTYhFpnw3I3ccPRGEVoIQTQj7Eai3uyAhUGrHmSLk7AJvn7YPEbTvpj?=
 =?us-ascii?Q?L+gpuxiIAnB5fvIAXgM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779442bb-57f9-4488-4eae-08dcb7c643ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:22:14.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSeodiNQMavhQAhJtABtW7Hyk5JUTzZRVeSIKFyiB/S0dRH/YUadWvf/yYlWkM1k8eAVjbintOHVPwWngy1Oew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9012

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
Change from v2 to v3
- remove reduntant address-cell and size-cell
Change from v1 to v2
- update commit message.
- use common node name.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 2597c5b2eacb4..e845ad896abeb 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -145,6 +145,18 @@ ethphy2: ethernet-phy@2 {
 	};
 };
 
+&lpi2c1 {
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
@@ -504,6 +516,13 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B		0x31e
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


