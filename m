Return-Path: <linux-kernel+bounces-415816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99B59D3CEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED031F236B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786B1BD009;
	Wed, 20 Nov 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PxtP17H+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64391BBBE0;
	Wed, 20 Nov 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111091; cv=fail; b=f4znswb2lzuNIim/WAtQQRCxJAz0B61KWaHyJAcFSXi/qdzC68BeZJUzZMezG7NWHdbDASweXl5CZFuYF4MzxduJ8v1XDV3JwZVsjRr/x68QoXzyQ4UQQOFKdrCajXqy1M/83CluoG5p8r8vovRMmacYsnD3uK/WCAhishjm5P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111091; c=relaxed/simple;
	bh=g4Ia2Kpwpg9fO2OGqDK/TuiJJYs5AjW2bQms6C71U5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YcPKHaXlexHK9B20cNHrhu+hGN9cWq+sgNs0h/Btk3kXcwhisTDb/7gGT7A7emkTLUNVLBMhyexlWSHzKCwcvE9d38VWFtBb2RHjNoCw/CJwiH0/b9w2szQqz/mVuI69Vv9yEaKYwL6Kfdchy5OMJigNVYA4SUZLPZBjmpjye4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PxtP17H+; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axUrhsft84zqPnvUQ1ZtT7/aZiu9y1U8bDAJbo4jhuOjDr2Ts8GoULUXARWO+dfCwqe6PlUAWR5YsBg17FE+/v8Kok91dL+kmhmzdGlvUFzIoez8eJg3AUbXi8ezxfmsn56ba7+wGdV7QXwpw0qQxbyQVf9hhZKLk2J8QXadtsQvt1gO9L4yxMXH/jwNpL4SjHmS8SgfjdZbI4NRqMM/0ZVwP0/XJHEO0FupPuzjtmr20jWdHBGlyrlZy/N1khXl3w6hWpR6S+V09K8Ren+SeQTwSi2wdm6TPutDuJR7KUSFZoh80/l4u2USSF2LVkLgO4TMliafvFPO2ZBknlTlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAfx2zUwP+KPZ1xFwqtCpnRigR0wSLhqKDsmM3fdWh4=;
 b=SJpAlJjoI+H5jsdFpnyCNXmFMrKk9f35S9R1eRIdCapwrnASdZ9v+VWoqbx3YOdwa4o8USfyjXn7RQ3Q6sHL7Y0PkwKznZEuxuHPhhnicA1JZiyFhBDtd5OtoCxEQMjlUonQAgdEyOsbXzfQ1+P9HZxacd/hYopOdzdjM/VLjMDEQ8cLwPccU4Y8gG0FTP0zgaBkJBn0MJqPEx6kT4uxqh+HlQokqnazsbDW7yj2z9aO9Ilkyi7Go4Hi6Y4BoeAMjr95vBwGwD80yczINNg0cDW+KMUYHUwU/5GHwZYberaP46aRP6ybG2Kd6HWK2TSQC1fSQWKm8/snoeS2O6eUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAfx2zUwP+KPZ1xFwqtCpnRigR0wSLhqKDsmM3fdWh4=;
 b=PxtP17H+Len88Tq/vejk1p4bw6pb/nYbCr3mVhAkTqw9ruFTOza/QRo88uEOODOTX8bzreouUB4+Su9QW+Homwk6MDiTtI/7+29kANk/xkTgDWpudccS9taAETXE4zawJjaWFW7oLCK31hdaM/XWm5XDeSZfB2nCpPr018GvmJWA9Ecej83u41gih/pgn17jSGauGsjksh9dQC3y9moDVJp+ZQqYZo1EMFYUeELjxfO9zjSIXbc8b3ICh4ObVirbxz7tYPbfNvmyvHYQuwfEilEsyRr0EOrHyD9klNbZ9Q0QbXZGUPK4xi2BCzrSoyE8Gcd1SAOqh6FUh4qMbLCDZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 13:58:04 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 13:58:04 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
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
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 5/5] arm64: dts: Add dsp rproc related mem regions
Date: Wed, 20 Nov 2024 15:58:58 +0200
Message-ID: <20241120135859.3133984-6-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120135859.3133984-1-daniel.baluta@nxp.com>
References: <20241120135859.3133984-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::7) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 649b82c6-2379-4e95-f866-08dd096b5aac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?en7d3HimUlNfa2uY5BLco/XyIr+Yh/NtajY/u0i0R+a2hplU6bPHTHDzLoTL?=
 =?us-ascii?Q?c3r0XostWxratjWnCj4dhghu9iQKPG3/k1AqtZ/SKTKT2Sj9c0cKVPi4SFuM?=
 =?us-ascii?Q?/vXXIAHELnjM7kSWrbgdBIlwECTbQgTec265xtlMek+yXUKcRcKGMehe1rgU?=
 =?us-ascii?Q?QCH2Hf4jPngj+hP+4wE9X2l2nE8DXmZgDFMHbvwMvsDPwsKsuAOueHzFNp6y?=
 =?us-ascii?Q?PtF1ttCxCn62TcoOCSwIkv5wpKH+BofuMrgrM0gZc10jpUsQUSjDY+1ESyiu?=
 =?us-ascii?Q?zZb0UQ+Sc2gbKCTC4hWmvUesfUvWExuXC4exk2P29XO6sAHDsCUWTBnmFZXs?=
 =?us-ascii?Q?t4XBZfJhpjkXG85hDQaZpbcQWPIRWT2lpEhtopgQ2rjzoEe5TD6rs82DnqxE?=
 =?us-ascii?Q?a0irRSEPQYINoPQ9qIIyhmXvAhgzbO80q/TVrvLI6cjWrL/CmtR/YJhjRHdJ?=
 =?us-ascii?Q?dK85lhcI8WPfLyIWO8HKjemKSJEUGd3DzyuuIS/Vm21lT2aHn1SvTvoWjg95?=
 =?us-ascii?Q?Ledmx+jKamfasB33c8+btChm/OHXZZaR4hdeePfn45Ycm4IHQLg0/x4QC9O6?=
 =?us-ascii?Q?DYqJJtgVSNaYAu9eqyuhPK8I+UDz0mFSftUYlpPKk3ytFhHbRXYA5MezEEnO?=
 =?us-ascii?Q?iJNt5gXe0Du3u9w6l8MpEPEpCxb93q7HRXCQmw4wOmVpSr4OHcv11DDGAK6m?=
 =?us-ascii?Q?ODTIFI7d6GL6ws/K/GKbihWPHasN/IAuhVWTO4uIHacicwxAleSNzvEoMxr+?=
 =?us-ascii?Q?ev9PVmkdW+5apRXLw03mpIdy0IlJf12TjyTkauk1zYwUYAyPiVlJorLoV5/P?=
 =?us-ascii?Q?uZ+RU4dhQAjBuaFRZOy9XDEA77Vz+myG3jUe1vJ7pbVdhRWObVSStLoKTX6j?=
 =?us-ascii?Q?WigwOqYwwhW1xVKJv6wZPBzpU5jAzJDhbXwFB3lmLCu8Y+6/FTBWYeuf0Dx2?=
 =?us-ascii?Q?Z9vU0maRMTJqKYWiFFSiioImvon4qVQ7pbR6rOraY2fDMBhvlubJDKPqJdXk?=
 =?us-ascii?Q?NdpIT/ttiS9FvBPYmvhTiVwHFLizWccBL7kVpNXe0aEUFy+Zw5xhiBE2QvXS?=
 =?us-ascii?Q?FyEfqpxazdhOwkerDrRcd0MKsMGQ/vOQupCf5FLOAqs8IPyliuzubdazyLsl?=
 =?us-ascii?Q?VvTN9vDEDQK2yaHXU8wSChnEWm+g9azvD58Q6uZOcwfCaCOxEANyhIukuzjh?=
 =?us-ascii?Q?4P1UZqKeiFoCpndNqOZb77/RBHXQsU3Bi7IvJmdrK6txZ1qYKdhSbwCp/ulO?=
 =?us-ascii?Q?aF8Qcu2lY96UAmAsBl3M0RDP6T7exo+Yo3a3ED9LnHhh2zT+MH+rBTykPJCN?=
 =?us-ascii?Q?IA4uPzQmasWoJVOFaOqvgr6aVGd4RdxDk7FqeKmOfIMesn3wdkBME6UQlSxe?=
 =?us-ascii?Q?XQ8v7UA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRBgZrwDysJ9L+pw2BfkoaRZVoTw7PZkugWqCjME5/+Qv6EL4XdU1MMcA0U3?=
 =?us-ascii?Q?WhylRwFg73Zlbaq58snXjDPuX/RFW36mJiC8PJxKpvy78zA5joagiiiCj5AA?=
 =?us-ascii?Q?5rrmgOv5Nr4uRQV2VW77aRlGceT+eqX/xbpkIpWKKSU4pBE3FypKOwCut2jm?=
 =?us-ascii?Q?qVuSRNXSA94YHNFrm2sxqUJacgNdhiOTg+Am4x8UtrT/QcBfm74aHe1knRUa?=
 =?us-ascii?Q?3Dn50SiaDCDj4vZ0xLqPq1hi2r7KDXUA/BxFaSfWqm2JUx1DoJzVFYc67cT0?=
 =?us-ascii?Q?jdT3ae5pNhjfAlflfOgCpbVtS5Bmg3L+NRnqLDItUS+Ci4n54iWZ9liHJdeA?=
 =?us-ascii?Q?cQ6mqLLLvPXATse/zvdQ9WZATLNGyNjVlG7f+zRqEfg0yxen1tFCiXZRfp5H?=
 =?us-ascii?Q?QbnyYztq+lonvJN4ULjuWE76kdVoVL2PgAmkuRhGH1h3Jm9Xf5keMEe/7tvz?=
 =?us-ascii?Q?M8aHvVZZp93DlqmLzRp1TlKO8Nn4K7z21kPk0PmRetYlVHgvwvfqp8fvMeQn?=
 =?us-ascii?Q?aqmoR9rm/mO4yWAQdknzm2eFdU/7zQ2Sj0mmcGDXv7kAugm6MEv+ei7xZdEN?=
 =?us-ascii?Q?TtGl1I513Ijt5hvMhuYEWBuhGGrxP+2e+cVQYSn8/MR9FO+6B61Zx9Z/odBS?=
 =?us-ascii?Q?scO3gNKrhO0cPmbRVxe3Eib38R5kYd80HdGQbbznVXOkaExGnymwyRJg1sdM?=
 =?us-ascii?Q?WrJpjcyfE5uqDh3kw/Lo7dsBrLo2Xd6Zf0E6WQof9iYrfex1JnUeYcTiRAdB?=
 =?us-ascii?Q?1t93QkFHWr+CdVS8sfoSiIs4svQnf5eHn7zrrLLKGrCFKjZDy+JisZTvtuhd?=
 =?us-ascii?Q?3ChW2CGqF1nUgX5BSkHvyEcmEzJupbktzEqeDmjsqlbbTDKml9UOphK5dMx8?=
 =?us-ascii?Q?uYKBVwxEez1FwNCS1EXc/dJUDL+Rlvhl/wwx/medMPWEFxM79ZryhlrXKzPJ?=
 =?us-ascii?Q?vcCBawEzAHqAVFz1iiN2u1yhz2U7t91nIXWV/PwNKc4CLfWFiwwL9ajKU+PZ?=
 =?us-ascii?Q?2FxOFs4izo3wmipT/IsvyWSJJuiOM+5geVHRRte+TULvo2L5JfnqGziPz30R?=
 =?us-ascii?Q?wTSM2Wpq+r9js5n0unwa5O9LvT/rKxMDvlVgD8G2YEaHr9KpNEOTW8qTeqrY?=
 =?us-ascii?Q?XhFyG99iw8HbWOq4+F/rGZCBGqVAqdxuW2HexOJMCdhtiel6jwoT/Ld39A0s?=
 =?us-ascii?Q?SUiq8qZsRR28xeXwJeF2p40/U0ZMXusWQJN5/UiYS7QW/SH7zTKDdvZyBMGa?=
 =?us-ascii?Q?CnUyjGTvEidRYVLJBaj7Ad9xVqpyVVarhX8nUpvMg9x7h1d+cBYgMMlaX+BD?=
 =?us-ascii?Q?yiW/C2VAyzpXHfwCp9/hwXOTwscA45JuCC8omtADedIstgzdMinE+ZGG/stb?=
 =?us-ascii?Q?0cP0GcnqsDQuPwUOELwVK/hOBVA+PzeFQjmOU4G6WhnuTwTSM4vmeR+1GLKb?=
 =?us-ascii?Q?766hwzDvoQo/3i/6H/prY5WTfo61uai0B9sIZ73fJL1PiIZ48SsE4lfykpwR?=
 =?us-ascii?Q?lss0dFbaZYyjY+nA0kDcV1Bff7XI6TLIWBr5euXfi1NIvIkZfgQziIjK1h5T?=
 =?us-ascii?Q?dD8L28nNah6YNxMr1jvf2PvZg46I9UgYQAoQvyYX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649b82c6-2379-4e95-f866-08dd096b5aac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 13:58:04.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M435VQAydxVl5wzy4/tTaIqgLO8OHPP1AW3e1Qe2wr5pb5g7KyrHKB7FgyUC+6iXLFBg1oVAPiQxSVp0ZkR9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

With imx8mp-evk board we are now configuring 'dsp' node for rproc usage,
so add rproc specific memory regions.

Also, enable dsp node because it is ready to be used.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi    | 1 -
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index d26930f1a9e9..adb01a484d78 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -291,6 +291,12 @@ &aud2htx {
 	status = "okay";
 };
 
+&dsp {
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index fa4ff75af12d..e6f3ac02689c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -282,7 +282,6 @@ reserved-memory {
 		dsp_reserved: dsp@92400000 {
 			reg = <0 0x92400000 0 0x1000000>;
 			no-map;
-			status = "disabled";
 		};
 	};
 
-- 
2.43.0


