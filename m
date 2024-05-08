Return-Path: <linux-kernel+bounces-172994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B28BF9D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862BDB22B0D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D879949;
	Wed,  8 May 2024 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="klIX2UEx"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124A3FE3F;
	Wed,  8 May 2024 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161960; cv=fail; b=t6kJaNNOekAFtcHTfgZWw9uUZIKDcsiktPUc8sPz0J6rhQ23GXnEGtI0GSaeFxLFqk6k+UcbJFf96FhgY9hcUjAsPJaIoJhUMelpn1XH7J/9L90NsDD+SNkWm9eYBUZSnql/H53dW6hl/tZ0PAz0ZQpRrFTXQaxJl2kjqD9tx5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161960; c=relaxed/simple;
	bh=nMGiGDB9JXkC53TjLf4CCd4D9DO8PP+U5JIZrEckc+U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a/SBQA2gH9owgNAzQuC8bdRIzi2wJyRGMG76rY0cM2TkdnGTrwTa6x9uy/QUXraPtcPA0OuHyTQDZL+DuOCigDtwT/9yuQ157YL/XsMB/psOClm8A15J4unwjZquz+gletxxi+eJSxzMY/rIKr1xtpHI29LyqHYglEi96K4pnys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=klIX2UEx; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCzL+6ZENlM0CVncr+MDW334LZ/lgWzArNCF30e6HbTWXceSHkCP0DP+96Rz7o4YtwgmKi2w7hCND89ahtU0C5rXhhsAGjZPPiqApFKsQvXaOjzEZwlvoWqSYpSvBRcjowZiKLfIzQoWxi7l2QM/VXcRKNEnoiQlOnssH/GaOmXrbjbiPPQd1pyDKPOu8I/P+jg3Q1P9s3ZNtMuEs/kizodw3DXVK1iAtbbOkVhyXxj+U93ZS5iG/3r6BOZIY6fBWZmNWuZ8/msBexWfSft/FMyv25MjucGP05chInVdpMpTjo3W3MZoWk4QA86zXqNdXP6iMSSqik+efShuCKWpgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs98spefrIN/RuSSeBRfeMHEkXHi3HLZNCBM8h1TC74=;
 b=hTnSDmUmne/0o1Cp+zM6ap4BT1d5FH2zfmToEnmFhDMch2IhWn3mg9XZifiuqRoN/tqwARv2hXgcP7tFnQJFiq6mRKKZqg4Sz38G+cNOPsbLDWyJJC40xYlS15Cli9ffXgQqn06JJAdkwCTK2DAIIXbUznYn6VM6GSkqPzjug1Wx+mGBXCIRV3q7ZVTjQNVx9TuZ6E0YcfxsMwItvl5GPkKJW2CTkmsA7AslPTxwx+iVykwlcMfPlyZmFFu3FEyUHOzNHg5q6VgqLl4S3CebIZJxBPmcZsyixHy6WK5cGq3yGnqKzVBlGTQZ46SttIyeuRLSqeON718RgZ9KLA897Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs98spefrIN/RuSSeBRfeMHEkXHi3HLZNCBM8h1TC74=;
 b=klIX2UExd6HTIJQCR3IZPnj79NpSxhOkC/oMazt08Lvnz3PLyybg9NhbNEZ+C3HB6lZprnzvVXSPST9AEhYQsTkXuh3B32UM4N4eQuaNiZIBSVrBvHsURwHgQ1hrvyKI/ukwNpnAIASAY/SkXNe/CcWeRR2msiOWmwdHEGZXmbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 09:52:33 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::d1ce:ea15:6648:6f90%3]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 09:52:33 +0000
From: Liu Ying <victor.liu@nxp.com>
To: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH] arm64: dts: imx8mp-evk: Add MX8-DLVDS-LCD1 display module support
Date: Wed,  8 May 2024 18:00:13 +0800
Message-Id: <20240508100013.2693440-1-victor.liu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB8PR04MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e8f17d-0c0e-4a82-dea2-08dc6f449556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|366007|376005|7416005|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O+qHScgnBoW5omal+aP4IJ8RSt0fmFZf/xUWqPcWG3n1WSAAKLacCdoMPGC+?=
 =?us-ascii?Q?ZNI2neIhqd1wHcAH1lAFTWPc1YUl5sOqYodyUlTc6BYHxc7ktvjDU6gYY4I7?=
 =?us-ascii?Q?co+vN/l8WsFf6X7uqWqiVJkokVQl2mMCfIXHQXNIx0IHgCiLkvX7d5FzRGZw?=
 =?us-ascii?Q?3p50bF9CCFk1jkzrFfDJhalQdIBsytAWRymE9pUzH4kwI/xgwXRsW9yeqGj7?=
 =?us-ascii?Q?CeoUSLWrzNdaEiqw7dQlVcYepTe4zHWeTrYESoQhyAOI2hGVQJ1eMEYnYHbe?=
 =?us-ascii?Q?8Pg4SD3bBt2XrmVfAEM7jeGpIdJPMUJY2wl+Ex1RWt2IgzeCc5Uz7Bcr3TqD?=
 =?us-ascii?Q?96khY8v6UL/6bAk8TU4oi+4TyIl1jfHPusy5bgjKQaECQbH4fYo6lLQdmzxy?=
 =?us-ascii?Q?R0lszdG9ALEJCpLo5nBceUNf+l3PtTcBRQuaZVqYfBgSj8qazPSEZ9t8LyDt?=
 =?us-ascii?Q?HVulnSOF+moHBbZWu3i8DpS2ehXIDsuL734cuBxrMtEQXvTxFYGyPNYQp2QM?=
 =?us-ascii?Q?ZTE1B0sJvX1TyEc3gl6KKG84zD2sz+Uwcm9Nuumdpon+Kk9xIAiji/HG2OOj?=
 =?us-ascii?Q?IatvctLTFga5a+hI1OSSTVzGVzJdybkmd7F/O3tF8C6Ii9OdpXdN3lHfBcMP?=
 =?us-ascii?Q?2nqZ7Jf+OeoyVclMWJ5Gm6rbqnQqFT/J/3u29g0ubTS0X+B2rWmrDj+93UMY?=
 =?us-ascii?Q?oXZTIe2U1667LsWmB9ORZK2tfygy6YWHYuG/oaOsgWphzg7jQ35e9LyuHWS1?=
 =?us-ascii?Q?wmdnFA+K/244/2hknrXOX25bAX4M6JRbjWxX8hDu87rX8qa92M7q5X8iW8MU?=
 =?us-ascii?Q?GzT21WfA64O79T1DE1kIPsE7dXcGuSEgDjM6YoEv4V1VaoBUf/DE2jCYbp4P?=
 =?us-ascii?Q?woOYwhZqQHr3kcxpyxGp70LhPfWLAhTqgHHj1+M/Lp67GXjunhq+zeXwHdLP?=
 =?us-ascii?Q?oSrlpID+RLhZU9NZ4SGmV4YP3F9itmzPq4U2keT1IOVTv48ihM0QNKxTP1KW?=
 =?us-ascii?Q?R1P0paS+YkZYYegcBcvk/stm3mebcdtopWnu375K/+OcZ5LE09yyghkkLUaO?=
 =?us-ascii?Q?EtZlUFY+IyTnsBoqziXz54S6T0Afg6PyoPq1E9uMpvjvWY8puccU8srk3bCJ?=
 =?us-ascii?Q?s45+JRasYr0owOE+ZPFcx8VtEeaY7XsD+7wpfsg1bgPJMvzatkeGfWqALNsF?=
 =?us-ascii?Q?tiFxiuS3fnUK0AIpYLlaeUZizMnlUtHu70NrorcdqfFu9FDrWxe5wp2dPbTt?=
 =?us-ascii?Q?jYyPM/iA/noaWNW2vWWPJR6RB6f1LNLB+IsOr3hEfgwouauGuR658WURY3ZH?=
 =?us-ascii?Q?/RUkLyx2RBaPQD7ozJK26DRYoh6rB8TOnLxsXYO00MozeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxdI6yqLyZHjyuze89wf1C85roUstk/X9Bm2NpkmT2P4oWhSyOGFcqV5daEh?=
 =?us-ascii?Q?dnAhKIAmc+BatwOlxL349z0JjFNpYp0Ez92D6ef6/aRj3Lj/S28OZgySGaV5?=
 =?us-ascii?Q?Pq/lX3aQQJAkOVQgNK9pMCIkWxVQ99GMBmAkGTpNj3loiZ2BU5Sq79qsuIWs?=
 =?us-ascii?Q?+OfzwGO/4yK+fSt5dLaEYqJe4Qei/JF7nTrRMdsxrJPKZoHvSpSwgwvll9nm?=
 =?us-ascii?Q?IOQJ1+MidxON3UR/jAFDV1oZOBM8K8pO6sERuJqDEZ8ScSEStmE/mt6kdV1o?=
 =?us-ascii?Q?wQqMACj+4L1WMauG/bz6ByF/kwARByy/zCqVMZ46xCluMTQII52+UXM5v/X7?=
 =?us-ascii?Q?UvxeoO9ztpgeIvl0UwbuctghP2mJq8wOzrIqMpdfTv04hI/tS9faAKCCeUN7?=
 =?us-ascii?Q?yJu8UWQlbGIc6thDWD4bTa/KT08BIPwN+iO8RNjMTyeuR5NJgBns6G3Yn+Fk?=
 =?us-ascii?Q?YxXlv49UsF+nZSJss0H9ASKvfwTBNXWymTPzJyMyLriqnBsYzCdy5xDN4y4q?=
 =?us-ascii?Q?5ef6DQLYrRZ+YrQtwtDFlZFgHgFX+NmBMnjWqVbIywkhF37QffOC5ps70ae3?=
 =?us-ascii?Q?azcm4nCgkxFid4A7QHDS+bCh5dD6ANP7qjIfjbxxheKoyh3j37Yi0+hpRr1J?=
 =?us-ascii?Q?lCujkipauiZ0H6a5JTrjhhyPofFuPOTsOuiuApCCxvQ7/mw+vFD04uDLskFf?=
 =?us-ascii?Q?qbPTbMvb7ozgzF1YMQRKGAU/5k2ifTr+GQMBbPPzGBoBiKRQkSs/qXe3TBHJ?=
 =?us-ascii?Q?q2AbW3c0GSjk+pVqMvFKjfXVRc97ekjwob3yfIq+Ei8LeJK+fMhNgzlbiIE3?=
 =?us-ascii?Q?oxoxL/XPVTj4HTNEbAeJL8k5NRnC3RhBRhFnrR4+8Eva3VhKO7vEPC9DeNPB?=
 =?us-ascii?Q?+tzPOsbpEpj4Qmqe4ZnFJkfbMzNURIyYqXWc3o/hGOAM9IVy81e4NtoGzn5b?=
 =?us-ascii?Q?D6kj2UHhAjqxBa8F6Y7aSNYjftRMkjN5sNYXkhdI4hSOZHK32lg67/qEr7AQ?=
 =?us-ascii?Q?T8dIC+VAg86GOrR8eAI25g3mbyriTsIT7dkpm7Zdvy0G4D6iujYiCEvIaVLv?=
 =?us-ascii?Q?xH75Urj5gkjf2giwNEVUBOAGRkSen8l1smvqf45cEg8KKJx8/5l2E1UBbQEL?=
 =?us-ascii?Q?NiOhnClMAWuSbJ6mhXBfB+WcwG195UTUXvmtCOhNdXLFDv4if0DWRgYGgp9O?=
 =?us-ascii?Q?UBTdpJqtFIZshx5K+yq4B7ViJKU8NGww4hnw0si/mHBKoRk2RKrSzbzMh1vD?=
 =?us-ascii?Q?xlc21JB2vH8NnojBfTHdiGGeAB/oivhTpGN+dOOYP/IKeSW2HAuduQHGUTGW?=
 =?us-ascii?Q?SvVPjsZuTYacDDCLkFwFMV3qjBVax9qhLM9lZBWC6FM7PlmuqqoEXZFguG5p?=
 =?us-ascii?Q?c1kdKLKi7eGSdEyFQzIdpdjfBnkI92h28OEwNm+pF8kVBMqKHRMcsrrxyKLn?=
 =?us-ascii?Q?sqfhYQsHA4HPC/TpC6Z0/4tDw7HCCJQUFgoPZIUckjBpYlyasYe76XM771J7?=
 =?us-ascii?Q?rV5Q/dyYwtdnuY0toCR1fSKGLUtfqCfU8U8Rn0SuUpNS+NXHeu6i1wsuJJh7?=
 =?us-ascii?Q?tR5cOpxbU+/7Bg9TVO2PbyBbofNcXkQvPM7JwdAS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e8f17d-0c0e-4a82-dea2-08dc6f449556
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 09:52:33.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJcqxaETnbicKiefaMDjHatDI8wbdUVdw3ArBYGOIPtYKig2W0ML43pS850RFFy8ViFNhcLtf89fTaB1b+pRvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196

MX8-DLVDS-LCD1 display module integrates a KOE TX26D202VM0BWA LCD panel
and a touch IC.  Add an overlay to support the LCD panel on i.MX8MP EVK.
Specify 148.5MHz clock frequency in panel-timing node to accommodate
3.5-fold 519.75MHz media_ldb clock which is derived from 1.0395GHz
video_pll1 clock.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  3 +
 .../freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso  | 77 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 19 +++++
 3 files changed, 99 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 045250d0a040..005f6c514f44 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -185,6 +185,9 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-dev.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-mallow.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-verdin-wifi-yavia.dtb
 
+imx8mp-evk-mx8-dlvds-lcd1-dtbs += imx8mp-evk.dtb imx8mp-evk-mx8-dlvds-lcd1.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk-mx8-dlvds-lcd1.dtb
+
 imx8mp-tqma8mpql-mba8mpxl-lvds-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds.dtbo
 imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01-dtbs += imx8mp-tqma8mpql-mba8mpxl.dtb imx8mp-tqma8mpql-mba8mpxl-lvds-g133han01.dtbo
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-tqma8mpql-mba8mpxl-lvds.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso b/arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso
new file mode 100644
index 000000000000..1b71890d43d5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk-mx8-dlvds-lcd1.dtso
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	panel-lvds {
+		compatible = "koe,tx26d202vm0bwa";
+		backlight = <&backlight_lvds>;
+		power-supply = <&reg_vext_3v3>;
+
+		panel-timing {
+			clock-frequency = <148500000>;
+			hactive = <1920>;
+			vactive = <1200>;
+			hfront-porch = <130>;
+			hback-porch = <70>;
+			hsync-len = <30>;
+			vfront-porch = <5>;
+			vback-porch = <5>;
+			vsync-len = <5>;
+			de-active = <1>;
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+
+				panel_in_odd: endpoint {
+					remote-endpoint = <&ldb_lvds_ch0>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+
+				panel_in_even: endpoint {
+					remote-endpoint = <&ldb_lvds_ch1>;
+				};
+			};
+		};
+	};
+};
+
+&backlight_lvds {
+	status = "okay";
+};
+
+&lcdif2 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	status = "okay";
+
+	ports {
+		port@1 {
+			ldb_lvds_ch0: endpoint {
+				remote-endpoint = <&panel_in_odd>;
+			};
+		};
+
+		port@2 {
+			ldb_lvds_ch1: endpoint {
+				remote-endpoint = <&panel_in_even>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 9beba8d6a0df..1cb71f566b0f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -16,6 +16,16 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	backlight_lvds: backlight-lvds {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 100000 0>;
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <100>;
+		power-supply = <&reg_per_12v>;
+		status = "disabled";
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -96,6 +106,15 @@ reg_pcie0: regulator-pcie {
 		enable-active-high;
 	};
 
+	reg_per_12v: regulator-per-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "PER_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&pca6416 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1


