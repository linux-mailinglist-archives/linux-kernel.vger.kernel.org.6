Return-Path: <linux-kernel+bounces-225108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD28912BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9611C27043
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FC178383;
	Fri, 21 Jun 2024 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JLXbGa/g"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429801607A4;
	Fri, 21 Jun 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988735; cv=fail; b=GPs0JCKTvZ3AejcXTBZvgojgehh+BUjD1aVjk648LmOTeRswqkPEAwQDokLPH1ZzWgrrOZLdCwbunpSN/lcRQH0rA5dq+mNw6VTbTgefdf039h+JzgfpGV/VEqoAk379bpx6WKTz0+abXdcErLTmMAg9nkkKiczxDTIs9LJMYug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988735; c=relaxed/simple;
	bh=5NuKPYbs2j63zupAlB0rltSKeBNiqMC5glplGup8++M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TYT/8047iZjjMkRF2fXpkgNJHsBQv4rGW3GbltOjcQoNV80Be5DlXTJUGhMbwEfpbbXXcOOdSwfU6HPdIEfYLQDkjm5ciYzFRDCjIJBX+FajBkdWXljFEENxCoB/lBix3EBpBWr79YlKL/xvcG0pb9sw0FWBl21K2vaPy/d3Fks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JLXbGa/g; arc=fail smtp.client-ip=40.107.14.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkJnZoANFMoKWlfsF3Lmzkf4je7ynQxnc2m73VREv3xtH64hSFfIyRhKa97ERCX21a2QRgc64usKnU3WmqYy4kFcjpW/Kyrd1na/HHKiMQtbtyL2oOmcddBhfymcg5wA4wIMFoiSSt6nqQC1b/aSi54/tZO6Spex5KIhCatAqDhORukrW1yniuT1XQIJ+WWh01X9CtOpF1Z//XAotPmkr4gPdl28hQaSND0hrx5MypAwBiKZyVQOP8NKEEfnfGrp3RO6RJO/zBdX6yO8Lh/VmojXWhFQKWpbRaqyd72lxBAh7/7U5+gzA8Hh0PdyWC2Z8jLHF6FOUG5B47vUEMuiLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bThOgRuCWf62ZHD7+25a3A3/8zuJ5Sb+BcPiqkr8kd8=;
 b=C63usiugOOq8wrZtWsJ35qVKSbuMc3cUkBun+pEbOz0Ia5y9S8SlFzHeF4O1LH323GQcYHGcAP92X6/EEqdWH1iZG7y76394fdFzQAwYK/fiLQMjdxUSjmxt18kCqw0QJpnGwWIXBwNn5j/E7PPPjS2/zNBxsfh8pLuUeITQrsJD3MM1atQE/e+nfKvXItQJtIahjvB3zGwQvMsSTvMKRmTIB5ON5vZGRx+Pi7fK0hdNCxPS1oQK/kyEqsCWcHERqiIlS/wJVlgDaZjirTyVyq4wHsB55OO8LPIoMNwrgmpxEHpRR5bwZDNyHkfZHhVa0/1YH1+237zF130sjKmG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bThOgRuCWf62ZHD7+25a3A3/8zuJ5Sb+BcPiqkr8kd8=;
 b=JLXbGa/gkQgxMGoQGnO/yjCX6LBO5Xof0c3Oe3Iu4h7Llb48h5qe3EyraGqW7U17FGkf3dM0rBiVJu9L+x/RgGrAYkGyyvzmRb6Owcdf+rHZq14AFqB0baTVNgt/e6RFBn2bUkVD0pxj4/3BqeowSiZcwYi+8hwuTnAhzbMagrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 16:52:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 16:52:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 3/6] arm64: dts: layerscape: add '#power-control-cells' for rcpm
Date: Fri, 21 Jun 2024 12:51:46 -0400
Message-Id: <20240621165149.2275794-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621165149.2275794-1-Frank.Li@nxp.com>
References: <20240621165149.2275794-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa89f21-3a36-4df3-31f4-08dc92127ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sKGYGXXp/Yvag03BsMjAApCR1yCyLfh7dPbMMH/Nmp/1xR0A5QakoAH2405D?=
 =?us-ascii?Q?luSca/PDnLl6++Djvq45oFSvq+uI5CoYM4sV0zv8qqY8qoAEoTKYbKR1MTql?=
 =?us-ascii?Q?5KyBM2017AElGwdM0lyuNBTOGKz+xn12Tn8iLSLCEK6SM8JAeM94HEN02fPg?=
 =?us-ascii?Q?7kHXG2xRYOUvTdcpBXPnaotyABgRAB0YC6FKT9YU48LgGQY5+FaYOIZSo4is?=
 =?us-ascii?Q?S554sQypK/QQkS5m2zEjirfxmQks4ZFa6yPJ9KwHhj3VWUWjRyXYOHsjd38t?=
 =?us-ascii?Q?A7z2+jh3lpGpIaHDEaWnxiv3JBwUa3bnWFGxO6ECLeDRWgU8ZhvSasCVAIhM?=
 =?us-ascii?Q?y5/J2Y60PAlOFfkRzuP5BjFy+tmlW1jFUKJONROWkPgAzBXTNbou/vzlVmnZ?=
 =?us-ascii?Q?pkFQCiV+YVIgBFndnMDjd3YcdGxRDn5LBV8C0ytVv007ow6hTIj8gf3cCed9?=
 =?us-ascii?Q?R5LndFJeO35ka5bl4NmhseTewBIVNXqQP2WR8mixAtgrrKfi/FCDqAEwXM/0?=
 =?us-ascii?Q?AvrHM3FZlKSg2VAJ9FmwDO+7XSLV921F0AcUS15dTG0rqoaWd8wwdN6uy0SB?=
 =?us-ascii?Q?zW+gNyvr/3KYmwihF/+yYKu9BMuhIjBMN2S99UZiFCjGELZ6tEvQl5WiEbAd?=
 =?us-ascii?Q?YV84ZFGpQ42tHMo6DYSOZ316y1hqBPfoL+q48ex2Nq21W0fkZd0hoZfopKqz?=
 =?us-ascii?Q?AL/MztwAU2S4yp6NHSxAy/7tEh0m13oKOS30RbmYC+ubbEJwqCT8C03MvPnA?=
 =?us-ascii?Q?IHDxPx1Q7jVbl4VK1Ht05cU9I6SLbp0fMQk+FKsFJYgxXCic4KYmmr0D6w7i?=
 =?us-ascii?Q?QgIpB5GlQaJS8QdJdRwILbAi6BVRG3DXSBvlRnOaF/AuxTJjAdAmvZbHAvcH?=
 =?us-ascii?Q?Ln22k1aX09Lo0V54oNqMfwd7gWyOM9fxLsMkeQ1V8uU0TrLgK2CvdKzblXUg?=
 =?us-ascii?Q?f5TzLG4TcJ0Q3AqRXHvPoUSxJmhhpblZE9n0HB51n8FpHfx6qCxQ+C/LntJF?=
 =?us-ascii?Q?fU3g4vAjkSKkKLqvDWKGwN4Ja2oiUXTiaIMXO/R3wginwPpoahZtxfN4l9BX?=
 =?us-ascii?Q?GKKMzKgJ3xBLSdxm12r+MHBulZWaPB4BFRpqH16n2LqVq1PJqDA+R42pABQq?=
 =?us-ascii?Q?3D9B9XwJuFg2nzB5MSJKMpkqCQvtS4seidkvFT5d9Bqvhh8rUmmeJ7ukKzHt?=
 =?us-ascii?Q?iWBfoCy9fjfGMhKz0whlyR87+GVE9NpRfraM47nTtE89vSN5nrujZzIJcGpb?=
 =?us-ascii?Q?/gz7xmNvR1iBZ0NqG+0gOTSJ9bSIrefH/q6LtQfwegm9ilgtp9nhXKW91ab9?=
 =?us-ascii?Q?C3AZXrtbFuoHfqtA08MlCszt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJJd5QhSbfu+XBlDxhxa4Xrr4ljm7/EyRSxw4Y0To56sh+VbD4dvZzlKh2jW?=
 =?us-ascii?Q?c5taixzwcCgA7Wd1NtBSVSeLPGwL9a/0MTqBRHfbYRoMx1QrtQriDSnj6w21?=
 =?us-ascii?Q?vHn2ZdIA1nfNhIt+iygm0BP34Im+wXlc429AgCkXMseR09vC9tSh8mxI3dYg?=
 =?us-ascii?Q?UJKy3aBcw/GBkcBt0c1jayFqw1ahbwC4u9MDxPfVrxGDjvr2VMpXTPYI8+SM?=
 =?us-ascii?Q?D42Muff1Wql2nedHWPDHgsU+no9i6maDaqfyvFXtEBUv2E93WJkMvlNksiIG?=
 =?us-ascii?Q?UcWjZeBXzF94DPAJ5WDxahXAO8CE9uEmi8wZMIVP0SAhs4T2YTU5gFwskVSt?=
 =?us-ascii?Q?iMgEx9+HcB/B8U1rNXEiqTIRR5J4CyVhtOCr2fDSXhJA3CMEV9kTEco3Zifu?=
 =?us-ascii?Q?7xVjIDHA8DPAxGT5I2faXP1inDY5tg3VgVWbImVkliNysUkky5z77iKmLYJs?=
 =?us-ascii?Q?DYL0ZBdnkXYDbQEGO5wPldagM0X1gHtOaG33ceqKqgWMG4fTo2u8/B64+R5z?=
 =?us-ascii?Q?Q3CYPgGV8UaDxs0s4k8ErriqBu/RH4tYE6sv9BqYCbJ/4SaJsOfAJB+G1HM1?=
 =?us-ascii?Q?QOkqeLkWPH6YOPEjq8dGOPS8jGMdB0yRmLxrJNc+ftwJNcOU/YuhE98FrPNJ?=
 =?us-ascii?Q?gcGExFVlVR6nzNYOlgW7COntGVR+wl3oJuFEM1rd/6YnqOu4KVYlfnSJ/CzN?=
 =?us-ascii?Q?uRI4EdJQNtgmd2MLFTZehOXYniIHAtJ52nXindmTnwnlY6l2/Ong4sVS27uJ?=
 =?us-ascii?Q?hBhASNx2v+6wGoU+oaCeyKB5d9rV1tOUfZYM5R5kXmjTlOssolJD5nZj2/Jg?=
 =?us-ascii?Q?6HVvqrEFkpmEtJ4qkMYyh2PBCoc4DLMN8jwHwTTI5WieMRG10hf85acZdPHe?=
 =?us-ascii?Q?GjmqDDW0O5h25FbACt6lsW4X5eULG0jJwZB8oG+4CryADn0dbSVsnrgRHVUw?=
 =?us-ascii?Q?1eXfsppegtzrnLx9UfYatrPWAKEMVEXugtlNUbSubyEctmzXTIRMq1tDAYXN?=
 =?us-ascii?Q?O2uDzPgtK7CkQ/GSIHn6DohoFfclbp9CVysF/lXFPjMhk5GhCiTxONZvEPFf?=
 =?us-ascii?Q?G/pWPPdx502qswSfCdgadPcSMGB0VhHmCg3LjDxW552vdI638TxEDcdG5Rq4?=
 =?us-ascii?Q?icP+oipVWrEyQYs6Fxoy1NlJtvEcp/sn/MFeZLCK5irn5GeAhi8Br2V0zceR?=
 =?us-ascii?Q?x9fEAjB6/8XKCMOKo7EGk4LmpupfM2N6zdyf4j5O+SZUFwC4D6dBbAYpj66p?=
 =?us-ascii?Q?d9F6UzUqIhfwlpZIQhE0nxjHZNeuU+lh8aSMPU6YDgzWTnM98jxZqxjfk1jP?=
 =?us-ascii?Q?vb5103aP528XsKAqcfwu7YLfUIMjYNp8J4QEZWikVVS+ByDex9bT1cQ5GV0o?=
 =?us-ascii?Q?KlV4hWVpkBplcnLlDMUUfz/omeSBLeCQ83W9rkkTi5D6GJsiNWiMl/7v0fpc?=
 =?us-ascii?Q?/e9WphYFceu1cyMx+zjviBKgAvejXF4OlQxkS0h+KY+r7YWaK3ELNj4CSrUs?=
 =?us-ascii?Q?RTc1hyueJFPIgCSV/P0BjLXArcxp7dRZ1lVnAsPiu+0GrMwUR2VkZy9Ep/My?=
 =?us-ascii?Q?fio1jAZnwNuegllodu+APNz9o1S3jELQXuxJZzrR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa89f21-3a36-4df3-31f4-08dc92127ed1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 16:52:11.6151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrRArelc7X2SD2zkAFDMloZjWUgXGc1VHDsa3jm6iTQj33O1L6YBm1i0f/pwmReuicewTFWJ7kYzUFFWfQjKlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Add '#power-control-cells' for rcpm: power-control node to fix below
warning.

power-controller@1ee2140: '#power-domain-cells' is a required property
        from schema $id: http://devicetree.org/schemas/power/power-domain.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 1331858add942..1b6ab9550cce9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -560,6 +560,7 @@ pcie1: pcie@3400000 {
 		rcpm: power-controller@1ee2140 {
 			compatible = "fsl,ls1012a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
+			#power-domain-cells = <0>;
 			#fsl,rcpm-wakeup-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 09897fe8a1a2f..c43d73e2d090e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -1322,6 +1322,7 @@ pwm7: pwm@2870000 {
 		rcpm: power-controller@1e34040 {
 			compatible = "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
+			#power-domain-cells = <0>;
 			#fsl,rcpm-wakeup-cells = <7>;
 			little-endian;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index b61e03e4cce15..caf765593547b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -986,6 +986,7 @@ qdma: dma-controller@8380000 {
 		rcpm: power-controller@1ee2140 {
 			compatible = "fsl,ls1043a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1ee2140 0x0 0x4>;
+			#power-domain-cells = <0>;
 			#fsl,rcpm-wakeup-cells = <1>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index d8680ebef137e..81b80b6b27d31 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -1036,6 +1036,7 @@ dpmac10: ethernet@a {
 		rcpm: power-controller@1e34040 {
 			compatible = "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
+			#power-domain-cells = <0>;
 			#fsl,rcpm-wakeup-cells = <6>;
 			little-endian;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 5695b43fba587..dac33a3eab841 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1221,6 +1221,7 @@ ccn@4000000 {
 		rcpm: power-controller@1e34040 {
 			compatible = "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x18>;
+			#power-domain-cells = <0>;
 			#fsl,rcpm-wakeup-cells = <6>;
 			little-endian;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 26c7ca31e22e7..12b6ec4926456 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1081,6 +1081,7 @@ watchdog@23a0000 {
 		rcpm: power-controller@1e34040 {
 			compatible = "fsl,lx2160a-rcpm", "fsl,qoriq-rcpm-2.1+";
 			reg = <0x0 0x1e34040 0x0 0x1c>;
+			#power-domain-cells = <0>;
 			#fsl,rcpm-wakeup-cells = <7>;
 			little-endian;
 		};
-- 
2.34.1


