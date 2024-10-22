Return-Path: <linux-kernel+bounces-377053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912D39AB94E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376171F242D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671991CCEEC;
	Tue, 22 Oct 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g275A3C8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78713B58A;
	Tue, 22 Oct 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634690; cv=fail; b=CiOARPT6QHGzxHD82qTUgs21q3R3fiHjchDNHOIfh/lqBKqDOxOQPbLttwQY2nEouhGofMjwVKrBZWZE6M1ZK+6vYJ8Ar1gYsuD2gM5K/wZQq+Zsh2YeEXSTpB3S0VhQRq5vNuYfCmnjJ4ai8DKY/RuAUZ+A551/pVCwey2GU0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634690; c=relaxed/simple;
	bh=BXHa9QjbF0wK8Ih5p3k8njbnhgVMzqJeRZYo3+wTM+o=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dk4XN9g1qMDAaS6KylEaL7DtoI+Q8+v+6s8/P04BpEGMKA3A2UybX2MGV0j78ILZPXmIAxwNqvH3W2YwBzySyRlM6lIKk4jFch8WjKBKWE9GMoc3+jJ4vtX8BAKoLwd6bHB6N92IvP6trRJIU55FGrK/dGNfC7OOF2h8pmMYClE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g275A3C8; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2d9F1aSB0g2Xtmf4m3jtEVP4gBd0rAA4nXK3wVnvJ3GDxTGyewilI/ucHcrvuy33w8VYFEWH0TxNd3WD63nZ6ir+UAyo6+HDCUQu49a2Gjs2M+BVFLRjeKNVs/ewd+z1O7dsqjBTg8Baro2TGo1X4q/PGKQeaYPymNRfoTm3XHfCG2XtPRGR+99Jr+xyehZFzIayrIN3hGetYBJJbsZxF4GFz9FIeaksRhNyWusVTE+YnGvD4hf3Hj47lgp1Oc3bG1UBF2g1Kvymu5tWJUfV2nPX1zGubJc9SvvA+qXsVv1b0v5aJqaw/pGgCpAlWeDoBXpuCO0U/dHowhxH/Qm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABctcxlMV50g61aNXIM52WsZemEX5Rwn4U9xD8pCoJI=;
 b=unDeIr1FThjTZKfwUObuYhKuX2Swa7hesNWkEQBpa135kKYRXydv7HGLubqWX8lzgrtOB+gnutK7t8+p36Ypa135SAL+fTIsh/wkynBOEzJzMsKjoV5o++UalQVG56EZUxEBkfBfs/dqw/qvuugyEBqbiJY18Xga6/0kP+g9kw+HHHOYI632BbXOwa281VqiSrgPx5wOi6LdqO13TGd1cJyqCURjQiLquia0DBV4e9IIxKbfhkPNXRSYbGyjcZaAZVsc2YVc9YXTbqa+FASVompepTLPF+LQeBILvY9MXVjBx/q5hpYIrbLBr8UCwBxnUKFmi2XiQiJD3aUhleL6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABctcxlMV50g61aNXIM52WsZemEX5Rwn4U9xD8pCoJI=;
 b=g275A3C8OoM2javAiO3Yu+rNuMzs9vMdCoQ5DedP8T+JNqaRjx7C1lRMs4uxTF20sL3YyVJVSb1F3gYcfA8Z630VWQUMoFGAfTKhsnVxlc7jXMs2fzs0X3kTaNJlgpAswAoiVRndgESjAzX1ELBHwdvzdMqmqhM2bn83ttIfQw2PMDgvQIUgWWjlR6a/WdLOfduyKLbTPCjf/EVsb7wOHxHN0GKEeuviAcjLFGY36DHJPUeGrM+qezGe/FLJ7yKrrF655gc4kzBA+mdA3Xnvsnepi72tccx1mfOmVJsy6gx9MjWAb5apkP5QEUrfHHmHIBSUn55xbON7aMEu+ISq0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8996.eurprd04.prod.outlook.com (2603:10a6:20b:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Tue, 22 Oct
 2024 22:04:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 22:04:45 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexander.stein@ew.tq-group.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux@ew.tq-group.com (open list:TQ SYSTEMS BOARD & DRIVER SUPPORT),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: imx8: move samsung,burst-clock-frequency to imx8mn and imx8mm mba8mx board file
Date: Tue, 22 Oct 2024 18:04:29 -0400
Message-Id: <20241022220429.1281129-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8996:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d54560-08df-4d8c-39ff-08dcf2e589fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qe/ixCIK/qF3eQx0R3bY2HQqUgRlBMG2pqA3YcDoZlrDB4SbRh9aYzMViCeQ?=
 =?us-ascii?Q?dZbP8YbX/AkBAJ3jcAxlWQnMxyoXI5gcJUxAOx3XvHkeseHDFyLJVUjgRN6U?=
 =?us-ascii?Q?rzsYBlGLVQRFPnQE6QzxGpyXkbqQRmDAGxhGsal0TyPcMvvV4cPoRPYtRO3s?=
 =?us-ascii?Q?XmxX+/bXRYexxtMt4v7FCHtjUnB3EMDXHfuXx1XwFdiyG64NEJzXULS0mQnY?=
 =?us-ascii?Q?Xukzbt96ojaZx7LxtUiF/C9Slra1048KVQh4aO0b20swiLrKAeBvJ0Erhgaj?=
 =?us-ascii?Q?BljRwbWJupmxNdzeUMQ3tKensOqDekNReU7hLTiVZUdTYPk4J094y+NopshS?=
 =?us-ascii?Q?Be4ZK+0W15FvU8WypcfHWVpY+kseR67lT7WMVZ91UtoPK4cro1KVKLY9zzA2?=
 =?us-ascii?Q?yMvb+cxHIrmKWDa/zFTuiQglVWo5p/dkua5cKBdov7ty1xZTQedvOiE8/PR7?=
 =?us-ascii?Q?Z4kFkDm9/qKZncevz5LHTJT/qCk9UGMdCZrp96CPq5ry7CvT37sN74wXzLGy?=
 =?us-ascii?Q?Egh2b6J4ICpujma1l/egpqraZTdijlDl2Xgob2CBQ5yS2u2M8xhLJezMILq2?=
 =?us-ascii?Q?YjXfQYs61gxwz26Htz8v27RCggzOFiRT8TlmRZmj0CGRCHlzaIENrcWVk3qg?=
 =?us-ascii?Q?NIZ6tmnl+WWWYNlHJpCZw1FJ8ADn3PRkzTYsp9QiHghPFyMnSgIspAcK5Zj8?=
 =?us-ascii?Q?iElsw/Ey5hBMceSaF+YRrOelcPdBfYKsMxOf65eCwt5dThA6zAJwrjtt3/DQ?=
 =?us-ascii?Q?0CSbfupyCGWhw3Lzh2ERvvgTf5TZBmUxX6ZXTLM69ahk1LIg2K9nrdhmKyQc?=
 =?us-ascii?Q?mPJYw9x70gEk8HTd8WWilHAO5wtwyqpDI3IO5uqTmxFKu5ySrA7rt9GLS8/x?=
 =?us-ascii?Q?zhbHuA/pj9MbpbtuQ1rBfUWSzjpP6/jyOG8h3x46VDVPh74gQYy4loxfDfWF?=
 =?us-ascii?Q?bdV0InryFcLgXKLQpyGC6JXLIpDbZerWNml4QaMeWNKrBmye9Fc8TD0fbXQO?=
 =?us-ascii?Q?mOtfOX5KBu2TKFItQQ2V8/za5l5BNqQfK4QV1k4zTP5zo0jmf6vD7vbCZu+E?=
 =?us-ascii?Q?AYPsrOW3PdDXOGrnO2jiVLl7u5r+beFypfRTkscmuiDUMcsXCkZgMn9+HqlR?=
 =?us-ascii?Q?w11Sp1jUAMXvMXfjQCbkFqQl/KO4CnB3UtrobSVCy0qWv3rNwjfrJZDtBKC8?=
 =?us-ascii?Q?Q1GT3h63Yhb22PvAXhMnrXzyV5DyPgYzi46NjRlL1UbRY2OniJ/tA3f9cVyb?=
 =?us-ascii?Q?519xjHynpFKGqtFvLwOZlkaWfKud8txwfizciKlq0p1DhcJu6y/4/5c5CbgA?=
 =?us-ascii?Q?6hNIybaKCGnlav+VGJ6qre/au/IcheSSikqwqhVz1EvYOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bgEZTEneBCPLO+zYo2Qw01HlQZcJNX/DxyVx+2NKKQBkg6PcrA8fEvL3h7ra?=
 =?us-ascii?Q?Ib/yLlTNfYCvmzAcRaVVd2lB4wFAPfRC7wT+p03lacsP5rYyEjeZq+Pm6+A0?=
 =?us-ascii?Q?I9wDGgpmGrLjI3XZ/jrr4Gheih8kxTRjthuTr1+HFPVJ4ZWu2xW7xsPDXtOX?=
 =?us-ascii?Q?pLMtH+6w2xm9syCP0qZvLYFzNXsCk0zut2wSOytbtBLa65skVgJkPyVku+V+?=
 =?us-ascii?Q?KaGLMcS8mZb3ODie6bH4B5wfdAKsOWKprNP2YW0YSycw5PW011aXnUQvNnxk?=
 =?us-ascii?Q?PsFabGeWWRIL3OBYMs3R6uJWI7c/F2mG5wwhuSvUXbsvONaSB51xWWJCo09/?=
 =?us-ascii?Q?hgtzAfxJQzcy1AnwXwqEazgEms0FN41ac2PUFBNLgFw+e4c7j8k7uTZtNWTl?=
 =?us-ascii?Q?hE3DBK76g3FaihJTY/mBA5T9IXRcIDQaKpNJP/0WU1RshkEpodjv7ZiKlF8K?=
 =?us-ascii?Q?OyW8VhRlRlQKFPU9JzYnczY7r0HbiRy0tj5H7fbsRwEC+YMNtSTTK6VLmJEQ?=
 =?us-ascii?Q?ev3m6f+XmMQI6ZXaSdrtA8OqsdAMV0GTQXVA5Jh6tWegI+kDsIy7+YLOQyJB?=
 =?us-ascii?Q?W4+wjH7LEPQNaMgpbRNkMBxKJEBjf9cZt3OelcRX3YWjQw0xWVdL9D8usuOk?=
 =?us-ascii?Q?4Gsoqsuvt/N1E9DK4ZzWum24FzAgvBlHXnIlIr0jUDkst/Gc/Rd8Ao0azt3i?=
 =?us-ascii?Q?Fp29dMHrkaBrKT9B+w6YL4KOyw/XfgWz2OIL9CvyIMqsHXfq6JsQXHN7oqnx?=
 =?us-ascii?Q?6FI/72aJ1zq3/ixfuDm9tMi25CT5RWyBvsV1gt5Fa+ugPdFhICts3w4Wjlp4?=
 =?us-ascii?Q?Hja7323y9/gTnETz+rcwADHr3hxphDQpYTm9Sx+mOA74t1UalsvbBObS/JqN?=
 =?us-ascii?Q?2DfgnGW4PCt/IX1Dsr3BNt2xsWvtm3v/UYINKFJuQBN+dbehB9rMp8HV27SI?=
 =?us-ascii?Q?wJyPn/VffdpqfaH7YQoj21WG1JwcX1aKQ06VIbMdIB2P1nIXVezepOgtmxix?=
 =?us-ascii?Q?9A21e6oqKfCmZ6vihQeh13QX+H7sOwu9n9/SBJI3sre1ZhLZ+MF+HsSTaNlD?=
 =?us-ascii?Q?27R/8kZgzFl9npBgJPraX2bpoks6JnvmL5o2TIQj5wixY7a2MgnM+rKUfiEx?=
 =?us-ascii?Q?+VcZzkyVbz8ws72oMA5li0dSplaE542+g9aLW/blVbqKR1OlhtyBPqY77NJf?=
 =?us-ascii?Q?sjjPC8IL1UZAJNecoLcAz9vIwPcPxgrfqSz7lKhrCAhrFjGn6Kh6ssSa8/PY?=
 =?us-ascii?Q?VRA9im16nX+jEAJv+43TEXc6K21XdVGGVdgLRdsJ+a7jFjpc0rA7WUNeE/qZ?=
 =?us-ascii?Q?Hm5h1qS2b96yKcvfZ7nRZ1xGRCjHE1Sd00FUo7UgT5dBzCaK1HFnUF8on3nw?=
 =?us-ascii?Q?6JO6THuEpcbI1AIp0i1kmyqtSrJICtz5eqmSx5sqb+RGNhN9eWtZclPZ9vtu?=
 =?us-ascii?Q?pOer2VJKkRbDC3zQ7lOCiCZD1aKvmjyHEFqTHnD9fklxopYrrQBpuFhquxzr?=
 =?us-ascii?Q?M/6n7ddc1ZTvKXFEyqZpovN0i0+ouO/OKRJjoqo1O8YfQCbKqtFP05gyKXPz?=
 =?us-ascii?Q?rC7d154Y0q9fnSbepoiO/bUu3V4OOlZbJC3ONlNz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d54560-08df-4d8c-39ff-08dcf2e589fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 22:04:45.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxUkj4h8Nd5GHJ0pxWWZCozg3FDbUjX6QWbJfbczE0lfWcm67zUgZ0maxWLi1zF0sf64LFew1K0mTiV3ZU/1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8996

Move 'samsung,burst-clock-frequency' and 'samsung,esc-clock-frequency'
properties to i.MX8MN and i.MX8MM mba8mx board file. These properties are
not applicable to i.MX8MQ MIPI DSI, which uses the compatible string
'fsl,imx8mq-nwl-dsi'. The properties are only valid for i.MX8MM and i.MX8MN
devices with the compatible string 'fsl,imx8mm-mipi-dsim', as described in
samsung,mipi-dsim.yaml.

Fix warning:
/arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb: dsi@30a00000:
    Unevaluated properties are not allowed ('ports', 'samsung,burst-clock-frequency', 'samsung,esc-clock-frequency' were unexpected)
        from schema $id: http://devicetree.org/schemas/display/bridge/nwl-dsi.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts | 5 +++++
 arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts | 5 +++++
 arch/arm64/boot/dts/freescale/mba8mx.dtsi                 | 5 -----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
index 01b632b220dc7..b941c8c4f7bb4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts
@@ -75,6 +75,11 @@ expander2: gpio@27 {
 	};
 };
 
+&mipi_dsi {
+	samsung,burst-clock-frequency = <891000000>;
+	samsung,esc-clock-frequency = <20000000>;
+};
+
 &pcie_phy {
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
 	fsl,clkreq-unsupported;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
index 433d8bba44255..dc94d73f7106c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dts
@@ -64,6 +64,11 @@ expander2: gpio@27 {
 	};
 };
 
+&mipi_dsi {
+	samsung,burst-clock-frequency = <891000000>;
+	samsung,esc-clock-frequency = <20000000>;
+};
+
 &sai3 {
 	assigned-clocks = <&clk IMX8MN_CLK_SAI3>;
 	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index 3d26b6981c06f..58e3865c28895 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -317,11 +317,6 @@ lvds_bridge_out: endpoint {
 	};
 };
 
-&mipi_dsi {
-	samsung,burst-clock-frequency = <891000000>;
-	samsung,esc-clock-frequency = <20000000>;
-};
-
 &mipi_dsi_out {
 	data-lanes = <1 2 3 4>;
 	remote-endpoint = <&lvds_bridge_in>;
-- 
2.34.1


