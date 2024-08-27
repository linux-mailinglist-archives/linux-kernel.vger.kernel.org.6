Return-Path: <linux-kernel+bounces-303600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6366960FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE9A280D64
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F481CC882;
	Tue, 27 Aug 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PqLbVV0R"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875E1C57BF;
	Tue, 27 Aug 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771028; cv=fail; b=HmpSfD2GoVdArPL01fWY/vTIJHRCBiiDP3Nw9l+eRo0PJ71W8CGVmQ9OlGhsoOX4swIqbaa7QIcrxipsyxen3zaFQwxcBJnrBPuznkEAU7BS6WH7IY3G6DjgBBgMEea40MhgRBr21E1qLsrFYAb0WGOJzkPw6DlWbtwOYwMqvcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771028; c=relaxed/simple;
	bh=dR5npUataXwlZi9jVr2vfcTfgo8b68rXXvIm1HbgjFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qz5lwrTUFVyA/BsZIMjoLio+oEvcdEJs152SUYEVgABV5NUNgMawFMBdDctmMxRyC86vc0aWVODoaQYHmhpMzGiecZb+KngNjH2j+IlXsMYFCUgAY8a4/J7I2o5ieWS6RGVdHac9FhYH+xMz4zHhP4Q55RN2txpjzyHP8XQvFIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PqLbVV0R; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtOIcv1zJQoyc5GrBXyzBAEzFRahd/j5FA43otcRhbLw5tO0MWV2QCax77lI9bNR1TmEfQSmJj9d2YLMt8/SkjzA0ByWO20oXITl3/AKEswd4EyVxyj1dNnXvkMeUyUzj1XFTBkrCW3IWN8nJpzqdYq8bZGZNfUS+4R5F80AuGkvRYH9fO6bHj71EGqyhf+xGml398LfLKJYMOcmdbeja0v0NwLRn2Ina66ytCbRrSXlWNyCCXcjaeP9F+6IqMpyNiWFjLzxMDmBP90mCsEBVDaV3OSIHovTH0phLrev/YRAs6B00XVFKiAfcYHois26t987a1+2wtwuyz1DGt78Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2+VeRURX5Uo1LkpJVfrqFjRTofj8M2iHOLQhvrXpyg=;
 b=mIn+fB5m4EAn1jI/QDJ+eNoaAAAzsBPMpKqZIMDTxmT+lvTmmvWRgTICjWlQwgZy9iDH5iciJvn73BG55N7SsLqQioGtE59+NwJLSHS8yoJdOpDjOgYK35ykfLFh11KEqpPK3lvzZwJEJaqdtnJZCVwZ+otsioWS4Vkt8ZH7bEIRP87GDMaNYOCIth8/jwwFJs1nQcpFu6jzJ65SuWe1hlwde64pTzpsX3aH6Tzs9YPfQ1UX8VGXUTSk4/SYfLINlbM/ZcN3URyqZd2DWq8VlA29bCDNzgIj5vD9Drq9KFCKtQzRsfuhnBQ+MHM6IQd8EwtkASsltVbX49HmVhwjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2+VeRURX5Uo1LkpJVfrqFjRTofj8M2iHOLQhvrXpyg=;
 b=PqLbVV0RsK/7h2qE8k8YQGxauhaVGLSnZMT2XYhr2X+TmVlO5MJnfUqO9GkFm9wfyMGca8Ar+CYtiR2FqdL/JK4xRmESlnpvgMfdQl8k/TYnAAGq2zFdNQet+gZEZjQS61qLC3Uqez+IGoyt/bVemC/FtzMLo96NynPE2bnH6PAi66/m0hCmFoG88R6bRfNUFJO03FV6muaU6QQAPuZwi+94NvCsHJYRnlOczbH58WqNPtXFp6qiv0KYC4hM5j21eywqxYon6HyjkQ3QUh6R5RAe3bPfV8/2sgef42xcXsWBSMCtRFO7zMRlrII0qMiiZR4sM0LFxKByssjzuRV4Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:03:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:03:41 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx93-11x11-evk: Enable sound-wm8962 sound card
Date: Tue, 27 Aug 2024 11:03:17 -0400
Message-Id: <20240827150318.1001050-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827150318.1001050-1-Frank.Li@nxp.com>
References: <20240827150318.1001050-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e58a4b-3e60-4a19-aed4-08dcc6a97002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8jn/M5J5ixmWbdeg2Obj3kB1IZh3XpZp2wqKIcEAWIC6e3KP593LcYhdsU5W?=
 =?us-ascii?Q?RHuMq5bxCOspFB9GDh+W5CQJFWcZjSiYZY6BreP5u3HJ8uzYqzGqTsMqPYEE?=
 =?us-ascii?Q?LUiEOrhKn6KRDubKtnKYv0AgKGOTAjIMoc97UgbH9KV/S59mdnsLlAnAJBQX?=
 =?us-ascii?Q?NKdDBc9sqvh+L8CISp8DVKZvqFi/HvSAiTC5HWbP89NiiBbY00Agmx3gh7N+?=
 =?us-ascii?Q?1NkkM2bqJBgU+nqMq0sN4sU29X/DngrnKTPi3yT5cDvUi3P8jf6ePzjNc64R?=
 =?us-ascii?Q?NqlKCkJ6Dmfsty7O9osPveMfoVO5IvzT4aljnrdAKlCMqx6vs2MYqhBAHbLW?=
 =?us-ascii?Q?Sg+L0lwGUShLN+SMT+eB61lb1vWbkDmazuQ97VdmID7Bqb9rX0pq4feaJwzf?=
 =?us-ascii?Q?FtVnk4GIbaY3zFRi3ugc1ZOuBcNg/UBboCQbTjjmluMaLWVdjAmvtP0rxLTB?=
 =?us-ascii?Q?npmAWO8ZoEbCxR/dmW/tOVVmpOYWkfZ2+Cw41Vn13VQ2xRa84EjWix5VImfg?=
 =?us-ascii?Q?5hBuTJesKkIp+ZwaRHDuHPi/+YO8OYOMgtNn2iI935RKeCCUk0TDBcu5TtdG?=
 =?us-ascii?Q?cVdpHTbLA1+ZNFzsro56Ech27NcY3xBX+BiTBpaUARFCoyWjC+4BX8spIhj0?=
 =?us-ascii?Q?WNjLi2+HVQJCUKEr9dbSa72xo/RexWzOh51qOZYHklrQJTKumF1/rCyhUqpk?=
 =?us-ascii?Q?kZHCC5rpvUBSaOlak0OYTZ8znyf+rhxcIOSZPJi8FlvGAF2xVoiIWLHICaQL?=
 =?us-ascii?Q?F1QdnWB4kQCz3eLJmPgYpsKqS+wftZw9n4c2lEG+rSjvDoTU7QFshyELLt9L?=
 =?us-ascii?Q?TZwTCmlzpoyZNxeemFOgQDNwzE0Oio/IjnzymzytF795xbLhEwPohFz7Obp6?=
 =?us-ascii?Q?F7SLS3z8g9fe5nNkmdmGZsK9aqrv0pMsQONgZBx1kDUDAd0mqkImB1dv2WAl?=
 =?us-ascii?Q?erOEL7I0DFamdKSREBtu+whfYLnzRvXGIPzd4TtLZcqw+/OrfwYKMHVQPhx/?=
 =?us-ascii?Q?eHeI5Dpm1xNNeK+0y9g9aQaWBeVGXx9XSaeOIaWt/dD/L7vZrdhXfhBVBK0d?=
 =?us-ascii?Q?b5SeLna839DBsErd44tbemmfcs2YLihLRwun/yU5NQJ2smZIC3J/6AVaUWHZ?=
 =?us-ascii?Q?GzHl9Y9yHGJMGy3XX3JfNGLxqzM3FyRNlbD+h6R+SAqIMIRQovQWQoRViF3t?=
 =?us-ascii?Q?GiN6lrG6Qs3vZzfKnQuLcxmZJJD1jAfWKcsPOp0KCAVVACQU7NzA5Z0S71h+?=
 =?us-ascii?Q?lPgNOJfBKujlSODzXDXj+fgF6QX1XW3vRlIV18/iyysQv3v2xJeVg4xvqgbM?=
 =?us-ascii?Q?bhdr3Z/mNEfT2OZH84xt2q8pFEI57/VdUPtZmfnOB5EsQaJRSST+7LTC5OAM?=
 =?us-ascii?Q?FK0q/hMRXkRuTI4RLT+E3ZumzjOyG3c/UEWJUBCrxFaOmIv7oHLs3mWn7mtP?=
 =?us-ascii?Q?jUDDAmZ2os4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xz0JreTbMS3Iye9jtGwLLRHv4uRMALL4PMlKjmDqOdID62QBl2A9vmqY6P/x?=
 =?us-ascii?Q?PBNVEEV/EqEkNq9pDp9jA4RAVzeMRIeK6CFIp+ZdlWbf7svOBTeED5DKF0vM?=
 =?us-ascii?Q?a6IMTHN2Ayo9VGCtBYRE+iOaQEglOatqLdMPhC2yqR03fHFzAGpQrnMVW5Ac?=
 =?us-ascii?Q?+vXVfiyZMauzjsCvfJNsJVR1/SORnDme0PbIaXsINcocrc6IRvLwH7nAEV1T?=
 =?us-ascii?Q?hCPnbvFAtISzwVOqfUrNgqdBcln6uj8nfRBBH987BpQ2ddxZR5o+8xlnF0sm?=
 =?us-ascii?Q?PSC8V5KPfA/b+r50imkJgkXJyI/C7BqfsmlEt9JZUAcuQe8/2xTuKzJdwgN/?=
 =?us-ascii?Q?EnA391PFUY0B/Gx5Qavl3VIVbDfVA7YkttwMeNA/nqgqyoXXCMsYlp5mpS7n?=
 =?us-ascii?Q?RMTzgn1eh+ASEyCmuMVQf33EuNfTt/pd0w6pL6iFuXqfHPPb2ir2+41KoRHB?=
 =?us-ascii?Q?VmVgT50cb9QlHD9eN7y6gnTtVpvWM3kgkBBGwbuKvJdLGngbXDdWoGy6CL/D?=
 =?us-ascii?Q?g8b3DgByuS94UTKLyxdWuWmn+cyk2O1jCrF4NBPh2t2hTmSlYbu0ymew9ZlX?=
 =?us-ascii?Q?SB4O8AIXMZMA/EN92lxNXGC8SwNRHdW/LlYn6baBFbECtADFodVWhRTGjRIe?=
 =?us-ascii?Q?aNIs4wy3LyNuYQvGtD1Na8hcp3Nvd8K4MHLTkmj7ZehtPAxExvVmqV3YPnz/?=
 =?us-ascii?Q?Wi1+o/ikOG9NY3qOI/5MI8VuyvZPlNWQ30oW6I5zPaqCDaD0CRW1xqhI4ANq?=
 =?us-ascii?Q?BGdH5IcFr1epG/haV2nRtt/MTa+63722VpkPTr8sAUP24T1eIRN8nY6kS+Lr?=
 =?us-ascii?Q?iDFnUxSx9HesUdgDJwWyQPXVsy8nMPg2pAMZUZ1ZUJh/SIXstLbH9P5ZdWv7?=
 =?us-ascii?Q?LLtjBBWcPPL76uQMWUZYzJ3NTMJ7TpSjJuBfV6JI0fQ1UmxzRfip4MBSadPW?=
 =?us-ascii?Q?xdobr4dlgKW6SzHVSg5+EgEZGkkBng1wXhcRE9WFbL6trGW4H/QIS9qrTSHm?=
 =?us-ascii?Q?jV202qwhssALk2YP+ll0U/M4BiTicdcZdmEh32+dgCQnrDn9xdcdYSK/yTfv?=
 =?us-ascii?Q?di/XqBb+kS7HcrVYB48FIoAdFnbA9U4yOU+cOl7wrlagnAvkRnWg4OevlLmI?=
 =?us-ascii?Q?boirUbJ8ieX4lCLOckDH76Ullmc5EZ6CC7kZjYaX74lSwGUWle99ZjH9w0tW?=
 =?us-ascii?Q?x5LzxIzpdjEjFyq+Nr0iOoHWqv/uGyVkZHBmArC/JXmLGnxy7qeeUet88+VU?=
 =?us-ascii?Q?b/z8eNRv9rV+2qDcza5U+E2TMVASTCxykjU32/o3R7EbTaBv8VFy+dRPQOMJ?=
 =?us-ascii?Q?sy4lI/pyL23jMRXRLuYK69fGY3N00TRDxQKChhobe8p7gKL17LHlMOYhB8vs?=
 =?us-ascii?Q?TOEigRiCYxolMDP3nCq+OQxM0pTwMNxLcJeAavokk4w+iURKL6tnVwIstGRo?=
 =?us-ascii?Q?Y7PiFyIt+Du5qZykYcCNpqNgpXWRsrFEM7hu8T3DUDig0DmuMhtXC49tWLAy?=
 =?us-ascii?Q?+SVhqNPw67gBpUwj4XlwYH7+AfTDaTr1HrMjnunOREYCsd4d5rp2BB/VMY72?=
 =?us-ascii?Q?IBxO8avhhv1R6X9e+sY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e58a4b-3e60-4a19-aed4-08dcc6a97002
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:03:41.2736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6f0zlcLEVsq4myLU6/UU3B3bd3i5susi3E6W6KyMl0tAXdL4nUM69z7+U+L7b6atfhJFrWJ8bfgpoIvdjs52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

From: Chancel Liu <chancel.liu@nxp.com>

Add wm8962 sound card which connects to sai3.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- change sai3grpsleep to sai3sleepgrp to fix CHECK_DTB warnings
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index f20d281531734..2fddde128350e 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -69,6 +69,15 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&adp5585gpio 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_can2_standby: regulator-can2-standby {
 		compatible = "regulator-fixed";
 		regulator-name = "can2-stby";
@@ -127,6 +136,22 @@ cpu {
 		};
 	};
 
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		model = "wm8962-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8962>;
+		hp-det-gpio = <&pcal6524 4 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"Ext Spk", "SPKOUTL",
+			"Ext Spk", "SPKOUTR",
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC",
+			"IN1R", "AMIC";
+	};
+
 	sound-xcvr {
 		compatible = "fsl,imx-audio-card";
 		model = "imx-audio-xcvr";
@@ -217,6 +242,28 @@ &lpi2c1 {
 	pinctrl-0 = <&pinctrl_lpi2c1>;
 	status = "okay";
 
+	wm8962: codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clk IMX93_CLK_SAI3_GATE>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0000 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x0000 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+	};
+
 	inertial-meter@6a {
 		compatible = "st,lsm6dso";
 		reg = <0x6a>;
@@ -458,6 +505,17 @@ &sai1 {
 	status = "okay";
 };
 
+&sai3 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai3>;
+	pinctrl-1 = <&pinctrl_sai3_sleep>;
+	assigned-clocks = <&clk IMX93_CLK_SAI3>;
+	assigned-clock-parents = <&clk IMX93_CLK_AUDIO_PLL>;
+	assigned-clock-rates = <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -758,6 +816,26 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
 		>;
 	};
 
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO26__SAI3_TX_SYNC                0x31e
+			MX93_PAD_GPIO_IO16__SAI3_TX_BCLK                0x31e
+			MX93_PAD_GPIO_IO17__SAI3_MCLK           0x31e
+			MX93_PAD_GPIO_IO19__SAI3_TX_DATA00              0x31e
+			MX93_PAD_GPIO_IO20__SAI3_RX_DATA00              0x31e
+		>;
+	};
+
+	pinctrl_sai3_sleep: sai3sleepgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO26__GPIO2_IO26			0x51e
+			MX93_PAD_GPIO_IO16__GPIO2_IO16			0x51e
+			MX93_PAD_GPIO_IO17__GPIO2_IO17			0x51e
+			MX93_PAD_GPIO_IO19__GPIO2_IO19			0x51e
+			MX93_PAD_GPIO_IO20__GPIO2_IO20			0x51e
+		>;
+	};
+
 	pinctrl_spdif: spdifgrp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO22__SPDIF_IN		0x31e
-- 
2.34.1


