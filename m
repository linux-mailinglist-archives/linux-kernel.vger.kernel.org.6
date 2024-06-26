Return-Path: <linux-kernel+bounces-231465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385A791990E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB521F22B79
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F13194A4B;
	Wed, 26 Jun 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="POfwHWEl"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602EB1946D0;
	Wed, 26 Jun 2024 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433580; cv=fail; b=D5qwnVWrNfytgeBaNlgh6ydvbYpsoebNVHzEDaae6OWs5cl9C0h28spuAR2KtzRbZQzKGkhjvg06G9ZZ6LzSLw0quFmOLhqj6RAGGnx+lbce/KzzSBYHK6ji6ZprJlr7R88j/Wv44A/oDCEdgQRmWUmvFlltSeoTUmHpvEHHZwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433580; c=relaxed/simple;
	bh=FCGZ5wNdIUwZfgD3mdJBoIxXlfQU+yFPbJhARMYZUMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jzjfTatKGWmPpAUBi/qNoDa6hoNXbPnwzLD4sBorJrBAHelMqRPYSVtXrVUxUGIWoBtzyKmqxYYQ2akR4HX4kONzMB+kxdF1+XEt7I3dAfnnmsApOUaqAsPGk+ZQwG26VilH6Pxv8JCVK11Olw6bR2WHMkCczPhAeJcYwrh3g3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=POfwHWEl; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6oQZL3vB6UcPNmmLv34PIbeXF+XqGjHIHlF9IqABN1bsvhlq+7jyrC8NE7/1Y02f0XEAaIbmwjEkt/89edMQG1rHX3cJ9h0+PQ1F39yYzbjzKZW0L23oxK82AJ4qH4mGnHGLYG+k6roNW0f7voDiikw+R70KZHkguD4OnlDfMYqIQXKqXgfIM4Emfjz4Fw0pYecInh1rJGIvOsryKD/fbY83ku3o3eN/RIZ2GC8xw58robZtSF63eD7UeKU+OzzFdBLMFp4ecC8Z+QrWqllV79+vH2ryQCM2KI6Htxk8PcBKgcdXh+pir+prodo2WIvBExND0MnRIcxxOjdH+1eFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RqyWbSjDhc4gilclt6KJoxnTEcQTn2LSF99PJCuCRo=;
 b=GI6Z6YGTxR89bmmaA11rjJU3Z/NuOiSwO8V5YTG/yCoWT3yzncYCe/MJ3+Gr0FVYe0dJrD7Vu1gYbBW+3kb/ShLJsgaM4HdfzzB01A3L2NdN97VjpcSQqvtXG3e0ivhSZ18OhVByPdkb1C6A5OItotXYRf2Upghaahz7g1b9yC62R9NFO8Ncd6U/I5yigFSwqEqNL6YJ5MH2vRNLfg16u+PLk/1LNW7HKGJ4IqI0l/TsHcA+KK5uTvSVpdr/OeGEEHe33qmVPZ2yEhq5y+CXyoz1kwHsNaJCkfwZwSxh+cRhJCdja91jvT0zSLZMbYgEPzJ9fJYct31s3MUWcmPuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RqyWbSjDhc4gilclt6KJoxnTEcQTn2LSF99PJCuCRo=;
 b=POfwHWEluD9ZOQxRTD3psVfRl/U7oKuKUkyx5FW/b4fRKt9KEd5RtVAHgmIArY+UpHpSSedgygdzfd26YdcfuDu/PoA3UkKhDHh05dLxReQajf1tRPNd1FfBuhe+KRiZDXxMN+oLZmqNuhmVj86JNSJ9Wnix/YZsyaxrSD0zyCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 09/13] arm64: dts: layerscape: change pcie interrupt order
Date: Wed, 26 Jun 2024 16:25:29 -0400
Message-Id: <20240626202533.2182846-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-1-Frank.Li@nxp.com>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:a03:331::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: d38a0dfc-ff36-439e-a08c-08dc961e3ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kB5dFsypZONXvvDw4AJLzWuxA+beFHVwvTamasYCn6kE4fYxy3UHJZlAQPL?=
 =?us-ascii?Q?Na+T4IxrEx1ilcdlPUIrzw3YVvJjt+hei14DaD7EhZ6HO/PcPYa3kzr30JXP?=
 =?us-ascii?Q?0olAohi/gYoF8LhKsi6ZVc00QRrLZmFmeU6RUHNCvKvV1anSS1rmcPUmeYqf?=
 =?us-ascii?Q?EeFYjyAKZ/uPeF6QOffcx8JSUrQos++Vh3v4eVrKli+dO4LrZvZtPHbsOpzO?=
 =?us-ascii?Q?z4pl4SWprahWLienzxsqYW+huODCWspPBrP4KA+r3f/zVrNmMrdN1/SvwBeo?=
 =?us-ascii?Q?6WSOv7xrwRpV+Zt0bbTBm2DA5b63nej7+Pag8vTQJ0xAf94oFZV+siOKHaca?=
 =?us-ascii?Q?k6jSQuf4kubNywyQGk/6XB4IF9+C3UKHR3313HZ0L7oBmGkD6O96c9yuxcjj?=
 =?us-ascii?Q?r/UyKApMkmchd2bBGrZgotr7YinYjFnRGnPITvb1I8x+49xWSUkLleX80aZt?=
 =?us-ascii?Q?ltMeUAWt762H/DU7U/Ge4aoRAAU11L2HA1epVd5OpOVyfKx2AR1djkMh6Mlz?=
 =?us-ascii?Q?3RVRkmWpSPZB22ILdxXYCgv9v9O4EGLBCYag0FCgsWtL6l84zzoahWcQgQH8?=
 =?us-ascii?Q?6PkyfOnjJjD2dK3lj9DhBOOnwmVvO6QNnZrVkMrN9F98asQpldhIUKpRfjM9?=
 =?us-ascii?Q?8wGrcARH2MK4nvRQL+qC9TTB3aOzdIULy+vNLkSp3weYvoegqN8NdgUnthC6?=
 =?us-ascii?Q?/aMlMSteOLuMYzB0+MBah2ZefwoLvVmvDJGrr5WiSnt9LpCLOXJbFq1+/T6Y?=
 =?us-ascii?Q?mYitCubbhBxz+3lXrCXFx7hUisEI8C7v4r4PA6OAlebwxfpSf7ypjzfIUJXG?=
 =?us-ascii?Q?FHatA9xs/wxDKozU+ZRbVPqLS+OvJvGfi//n7wmhlp2oeT5d7sPw8A3Dhe9T?=
 =?us-ascii?Q?xjx/gP4aHAYTeEvWzoqrvQtx3qtLNOu7JBuKka0AN12O2Mo2NeljmvKQxe2Z?=
 =?us-ascii?Q?wmtZwxQgwG8ZvrOdg2mIn4BSwXY8ApQMxMweBtc2Vm+zwaPVLRcDDhPzzgV2?=
 =?us-ascii?Q?swqBDJ64IwEI9fxiwOAzAjlH987D09lAODK7vgxyZIwoc1bdqxPUZSne48vO?=
 =?us-ascii?Q?VULkh7WVJV9pPq+IzG6c9cFf1TOILkNDtLX4ZbuxkAkEDcsdR6HEWTHNOvu+?=
 =?us-ascii?Q?AClL0GmBD9mRCW2MLn9gAiPO2VSeYJMWcI/J35wdcy2QRQkJznugG4/mC04M?=
 =?us-ascii?Q?vqr7N6faKtROLLcPDLD1vrfeVuPu3JwWfEaCvuTuyXw6WiYdMowrHj+MkiR8?=
 =?us-ascii?Q?clcwqfpw+DFjtGypSVjQq+QrOwAMish2pirYt5s+KkpLd092XuTdzmSPJyKS?=
 =?us-ascii?Q?vxqQvxGhvLUT1vMFFdxpTnKn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3E4W0nYhR6eHF3DfL6g4otJP//9Mk5WnUsyW3hvpUNKmLqY7F/94hX8SYPl8?=
 =?us-ascii?Q?xY1hlR2L//sxoO7Z2bfR8zNKIhnR4lSkmIe4UHiukSuYI36Cc2QxKPHowgiC?=
 =?us-ascii?Q?KfHGUatkCNoH4Lc91DqxuCF+xEaGArQHEySHL0DtTVBoOd0mC+1WarVhxMp8?=
 =?us-ascii?Q?eoiXWDqQp6Rz8APrE/b5+rU45MZitwjVBGmZ6bJ9OmU068IugqI2GEtLOFi/?=
 =?us-ascii?Q?7/qJLity5kihuDzW9cdLA3hTk/c1XL+UnU4FFRmg0qivikhUJs2Dq1ypn1LW?=
 =?us-ascii?Q?FiDV1874ZQkz7P2BBI88WsI0Fpj3EpmEb7UsqXjpUxvmFxOKn657CjdbWq84?=
 =?us-ascii?Q?599y8NbbHZvAJvfzxLnBpFGPRV7a3Bo+Cql8FPzPmoUSc7aeYnSDYRhHbw9G?=
 =?us-ascii?Q?EIJjIy+YiGT9nfZU/SuFHdRvigh9gptZHkFwx5uBUji0Jc1vVgm3AY4Gxycz?=
 =?us-ascii?Q?yKKf1EnE5n/61EfffylVIzvqJw8G2Osd+Uza6/fUxW9Y2MS5lzCgTAYe2tNh?=
 =?us-ascii?Q?d7D1H4iyzh2upAAYu0CS+mzoWmyKRPGk5/yy8XNqMm9kdQMGc7+FP/cs8zKX?=
 =?us-ascii?Q?Hl+Y7SVSs1plI0Y9wiH71XQrfEO9LOi3ZnxhTgLy1XC2fNzk4+9jUHwTh45g?=
 =?us-ascii?Q?2fY62rxup1tHM6QJgJciq1xCKwUgRHaY5W4Yn4ZT/efdyMRCXpiSN83J02JS?=
 =?us-ascii?Q?vottkPaxbLoHPyU3jn5ABkw2bcPfrKGsIyUOF95t9XSN+dXZH/riLhwn+vo+?=
 =?us-ascii?Q?1k2vILrku05sdNparooFcEQUNwaXuLROVWJBxuegp7sKoiAedp6Lt3shP6jC?=
 =?us-ascii?Q?vhEslSBBf+ZCVgxhDMjSNWevYjRbsSRN+QOtIvBhwEmW0uxUORoljhiS1ORe?=
 =?us-ascii?Q?k7F9+8ty0fDjNUOeMqnqPruiIIFbR20giMjsvVkdUWkQXMCz5KBus/fR0g4f?=
 =?us-ascii?Q?L3G7Kfh8EbdvJND9wBewvoDh3aCMlipR4QWtBGbmNZ0zgQ8Dp+NKcA6DP1Se?=
 =?us-ascii?Q?HmrjuVnQsSljdMqEmvZhEdnT4KLou8tp+JQXaBMHOMLRRYXyizyDOIiFzJFx?=
 =?us-ascii?Q?KDRsgxwVjykdgcwXYeBtxGXr2iVIiACfYrcIzUYkH5XmGiQ+TX6rEBgHQLDY?=
 =?us-ascii?Q?cPbH7CMrnRI01Nalu1OGUfTvCe2EYjsRmZkyPVsa5nzZpeBUwKIYhsW8zLJK?=
 =?us-ascii?Q?k5d4Zt8rvVPGORKTwzXNiX0rLsDdwOUOpCQA8rv7WIlyfpQ1Vhqdz+1z21p9?=
 =?us-ascii?Q?XxrJ6mOvCLexvCdnSroxp05tHE6PSGH/IduK8vIW/t+OUaygDoe82w/8pNtE?=
 =?us-ascii?Q?d3wD5BtMpNftfHGL4n3GJ3xqLOfxOn5XV6PIl2ipIoy6NFGUuKhXP4hIpA3k?=
 =?us-ascii?Q?hsSA6Br9Bcl7UulgwETo5CR23C/3qNgEdtv6TUK1vF+d8tWjRZpCRcbUYtBV?=
 =?us-ascii?Q?FNYGwhkglqX+jDwHFdSwATSKVU9Tvff1BX4yRGPjYbBKZbFHzduAS1Wq0LL7?=
 =?us-ascii?Q?vc1m2QFta8pCNa2FPV3wkDG1SHZZ/WwJktYNhSYyomxNKMkyOSpGRc5dKcvv?=
 =?us-ascii?Q?9yASXc1KGyCCLdZrZjE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38a0dfc-ff36-439e-a08c-08dc961e3ab2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:15.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xip1Skiv/qTsvGwuf3LOlSVMI70D13sB/DVO2DnpeOx4dRWl0x7zBgZ7B47UUYc9t6Wb17fAee+hvh8Jzo+RNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Change pcie interrupt order to fix below warning.

arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: pcie@3400000: interrupt-names:0: 'pme' was expected
        from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: pcie@3400000: interrupt-names:1: 'aer' was expected
        from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 64e14154d5969..daded853457bc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -535,9 +535,9 @@ pcie1: pcie@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
-			interrupt-names = "aer", "pme";
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 801c5b77d608f..8ce73a076e77a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -801,9 +801,9 @@ pcie1: pcie@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
 			      <0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
-			interrupt-names = "aer", "pme";
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -840,9 +840,9 @@ pcie2: pcie@3500000 {
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
 			      <0x48 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
-			interrupt-names = "aer", "pme";
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
@@ -879,9 +879,9 @@ pcie3: pcie@3600000 {
 			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
 			      <0x50 0x00000000 0x0 0x00002000>; /* configuration space */
 			reg-names = "regs", "config";
-			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
-			interrupt-names = "aer", "pme";
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "pme", "aer";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-- 
2.34.1


