Return-Path: <linux-kernel+bounces-302195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C917795FB01
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D30B23477
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3306319B3C3;
	Mon, 26 Aug 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KzPWzkiV"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99F19AA58;
	Mon, 26 Aug 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705638; cv=fail; b=loSyxpQBpaa5c+plMD6TSQGDyUYvXX3M0JbNP+jF7M4eUWKLDekMs9xDt0YPUpuCChCRzYEZIcHHmC/iMxxvJ3pfRszMB3JK38XkjoQ0HrB9gzQrTD+GnE+vNUEjP2JMpPXwxKAefRKLC79QJ1nTjRsKFUVSjnu59g/Kqx1rYqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705638; c=relaxed/simple;
	bh=p+Ny7PXe+TS0z+hCy2KcXselkhBeEa3nanAFYxI7dMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTzbTQObbifbDM/m4zuNmcfJGhhcs/5/IPQhL2/7OQAVoaXCWvjD2tf1Qx9cfUP+8gVMZjBuMVDg2zQW3c+XxfKJeT+0SK2UYTuxehyvZnsLgk1MNNbU7bNeod6zadxYCYIgIx7bZy5ujV/aXA3+lD2tbZ1Ji0ztYidPgXSc9Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KzPWzkiV; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAtrDlilQ3d7a9j43yF31V0l7dj+jlFYihpnW204qoEcAkKQ4iWIRlDZ3kHgba33x2wMcGOxFF/1l2gFjp1TTvXs1t8LH+VaaVA4G9YVj7O+385G4+4jAeo4PFZL23rFBVYWmvo9nwVNxYH7He0rJ6d1tGVBZD+czrML4r3vtNSsM3NeJjE6v+oTzoayCRrWGBLJhxJeIc+iGZyzkEmhKLvqStH4xLbLfdSSNAWMvkidk9yCgYo00OElehrNY924s5aXsDrQV0tBZGXJjBo9zIqfV23CPerzB45YEi6eMLPSzLevJOSUctL0tn2eVxxuP3VJ/cDxqhbgoOlDrsI15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gfg3HtiIhEyQLWPDiT+gsMAH1h6KCPxZWtjQ0TTkqMs=;
 b=rn+zO5gaR6BITb5ilHxTuOOp2ppQJtUqMbmmJaDOn9txZ2687/RV178g3qi1PJCDNfjj5bbrSyHzVDp9ojk3/s/jKgOwQk3ofZWscnnUP3MXFxoQibVBsoslT39vxdll+TyDDzyHRXNeU+XE1Wzm2ezv5oGPeXwYrQd5211TPXCnQ6jruM0ikFzLQRKhK2RcDYeak79OtOKbafTbM6+Axm9le9MbUn4yvXsMmlNuLLTpm3G57yL7DFyKpEwc1ccJTaBazBq0SNbP6QwbG1GwN6aKavmrhPk31uHwjrltdXONDdHy6HJ+jqKs5tz5ic2ye6vxMfjkeahz/m00nsk+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gfg3HtiIhEyQLWPDiT+gsMAH1h6KCPxZWtjQ0TTkqMs=;
 b=KzPWzkiVXrW3bj48MKbb0qjfrV0kFAVp0t0P5W2iwFh0XSIW1qdhBggVorpbIM9cWwrVQngWyaepwpRvJBtGd9EWfYQPKlQREcJST19ekiRTMKZGEUIrXKkUKOshzywoDSFvm66YqXGdep4h9UYO8xqVvnsWa5PBXaKEgX2XJSnkkTSINoqfCku++CkRtEb6fBntkcGyrxYd+4jmUG2nXKV4lJPXhm/y3js3qRq3qrQT1FUNVpd+asxkFcJjFTztUQZprbe7hB+U4SUmDtoLNX7xkKuvEoaE4hh5Hy3esBVdEZnsafIkflZ0Zj03o5ZK5Vq+ZxBQt13TtKgUWcgkiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10681.eurprd04.prod.outlook.com (2603:10a6:150:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 20:53:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 20:53:53 +0000
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
Subject: [PATCH 3/3] arm64: dts: imx93-11x11-evk: Enable sound-wm8962 sound card
Date: Mon, 26 Aug 2024 16:53:34 -0400
Message-Id: <20240826205334.975272-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826205334.975272-1-Frank.Li@nxp.com>
References: <20240826205334.975272-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 698fb52c-2ed1-4169-35b8-08dcc6113184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+6fQu9IlYRmjMXiX9HWP0ivPsLZgm12ZvAhkKvc2T9IAYB/I6hqOuhCZmQQo?=
 =?us-ascii?Q?g+vNyCNmIyoYzEY0GIR54Q1s4atKQe50FBqoek3526wsWL31aRZKrGrVVxn2?=
 =?us-ascii?Q?sUNu4MgpKS87K8zqyEOuXpzBy8liKUOA3cs1msMWSN6E9HYHYeKISVEkffnU?=
 =?us-ascii?Q?D6Xw4caREVjrkCizeTvo8FuLCL07lmg7g9g6+gvrz/x26/uP2ZAx0ztlGjkh?=
 =?us-ascii?Q?7ewuA8ivkgjif6VX3G91FUcP8IiBHJCgPjbzaHmXgSaQvSWN+5wgiIL4lw9S?=
 =?us-ascii?Q?4KivZ3mlR5HJM92ynDC/XUnY6hG6zJYFblHXzKdNkruplIu58rGhoCRt92co?=
 =?us-ascii?Q?4hAyiuSk+Y9TQyYaCXhbJVIiB4J1MBYZ3N+fEth+mp3qvsq8vMCXCsPV4Ji+?=
 =?us-ascii?Q?kNYtAQ9Tfd5CzEGA2FHIxwU6mkMJVF7edtRecGOxGIOmpY69ARWUTNME+QHw?=
 =?us-ascii?Q?y1KRyAYCgcdEGOzTkzQqQ0SSfbhfgMluuNRMdcWltWsFIE0u8o5gXGEjznSX?=
 =?us-ascii?Q?H3w4wbJ+LpWTEqhBs5U3hvlsmTu7BU4VzbUvFFup9eEh/2SyJ8F432J4kC/E?=
 =?us-ascii?Q?hD9umHj8kRJDr4n3ZXAmZGZ5vFGYXBRh8VyANBpTtjazlcCGsS1K7K1am13U?=
 =?us-ascii?Q?spUuHcUlHQ5hf3EGOOKBUmtOzZbcuoIainRV5DQA5L14HW8w6a7yI9X/IWcg?=
 =?us-ascii?Q?IfS5tg9fdCfggRuUhlu/QsRa0ZNeaLuts3oGY/9/FwLMTIf1eXH4x9zJer42?=
 =?us-ascii?Q?RVYzaqpdUtOt0Xv93eiGsPLNymXKnXWqk/e3t6EnIOs5ORQmGUYre1h/gyEZ?=
 =?us-ascii?Q?z5w/Iwpz8wpmapyEM3ChUqTkEItC+BsPUCAc9ChXnjw8mWeh6H4tpOMYnBhn?=
 =?us-ascii?Q?2DMHDX7ZSH5rDC/pbd2da/RGcbUT3W24GLo9Iq6Ia+UzK9qnyd5G6b+z7Yyt?=
 =?us-ascii?Q?Ls15ZZpcSVR1ytW/VoJP2b/jkehqJzyrO6aiu1NxdUOyOBZrpEBxv4u3xs5d?=
 =?us-ascii?Q?kG+jj09Bgi5wOpIPnr/HYR7swGXu7AM3VtjfO8CIxXUUE96VipurGa6yW2hv?=
 =?us-ascii?Q?QGNrEm1ava4G+fZyfM/XLqA2hRChEb5mgAQFXVFX++Z/Y1yy5lXM7DveXGrb?=
 =?us-ascii?Q?6UzouGAB6zLakuA0uNj51n91MGfpxgRO0v/AQW5pevpcgzx7eWm9NrH9V6si?=
 =?us-ascii?Q?LCnpUc/FZoF7lTThK5D00MVn8qbLg2CVeA6a7M+XFz+3kqTvlLfOl5RTpRiK?=
 =?us-ascii?Q?RfT4xqdQuDev0b/6ooqHAhPg7SelLdOSXHJJ/vg/Vx2IzQFN8ni3ndFKLf9H?=
 =?us-ascii?Q?/52uV/MpXbr+htSTLWhqR5zL38LLbAjVFGISOwuFMs0Wz460VrXHt4DZC/Ho?=
 =?us-ascii?Q?O2m0k9IYWPG2JKgiaU8u0+GNhnnRNFBh02XxsQ7sCifWGRnApVd1GGNAtaQ9?=
 =?us-ascii?Q?DwpZCkhWUaI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aakm+8s3Ptbx1pf1Kdoz2Kdm/xsT7lU3NcEngc50q58MI8MU1o/1meO3vZRe?=
 =?us-ascii?Q?A1Rncx64/dfnEntvkeolyQMzwN0yFgicPH3akLBXRmz+Je+XFLjrM7R6P++P?=
 =?us-ascii?Q?o+eqwxh7OivmWBoedNn0C7ggE5v9v1RomRQxRxFsJItnEsqlj2KoZDTCGZV6?=
 =?us-ascii?Q?mVjXRBScNU7rZGLAghABhJyLnkVlbUFyenb2LtYsVSn7TBL15T2X0vJzblnK?=
 =?us-ascii?Q?FJ5MgnPT4/bL9niUdn49yWwSAj6DcMquqMzsY4tETXC+nTd52kJfZOV+0bU3?=
 =?us-ascii?Q?C7RFTIEm6TkagQe2dPKaXTddgBHPrfnfmNZLEA83FqcHNyuqk71NthGceW1t?=
 =?us-ascii?Q?/pFlQmKZFCAjhMFk2vUZ400Qda4+sJOvcClVPDUSKbG6Jz4X6ntP7sc0nq0R?=
 =?us-ascii?Q?VCHaoT6LxekIyC9zZ6nRcr46K8n+79aVqJ6+qyt/3jE6+uFOVYtEA8YY4j8V?=
 =?us-ascii?Q?gCGWIf80zG0E6NWB83bukLMODGcS9gcTbxuIXiHrWwTS3VCtSP3+t0uTIza1?=
 =?us-ascii?Q?rq8c20S9x6fP3lC8MXg76MnHUoLD2gP0IFqMuvRhC9PNeVqilE2o1tT03Ex7?=
 =?us-ascii?Q?i7MKJTY41uHylUl1wq1zhLjROVnDDQB3aVJPWB4kZPzh8CHYf7UDOPe7XG5P?=
 =?us-ascii?Q?cwjVil6ePzmTzG8sPuo/+Uu4JYheRXXreo2LUwbXWwp1pkABy/wmFKaW+x4V?=
 =?us-ascii?Q?pLLWnHCvyAnsmwHeIG3jbjbuAC7RTp4LiX4TXGbrVom0aQYvWyNTO/4NjhQ0?=
 =?us-ascii?Q?ke+ajKPUNcWoeHQwZLMLocde/P+34CpcAknFvys0dkBhvuN+HejxB6HCwpR1?=
 =?us-ascii?Q?CepyIng7LJlxg9A6D/2eAi4ogYSWr9BDR65uCZZ5WShbd8bMbRv5MFX7ljNa?=
 =?us-ascii?Q?3crAJbP/OSKgwFMuPdLTBIa77kRiJQ3+rfsmvkr4r8rlLMgVEoD9wjFh5ogs?=
 =?us-ascii?Q?0Ma5/ouWoEHxiOGKNN/4GvLySnCjI18gzbKXJ/eScTwpUiXJMkNTEtGJVQ6A?=
 =?us-ascii?Q?IZKdjEz7+5FloNd++n9WeYNHY5tEUL3VdRyUrIgH+D52D1QRVfY6fmgUUPiq?=
 =?us-ascii?Q?H0h8GDZnT8JJV1Wwabq4LgdupC3ay7vvdg+qjkHVDdNc3wRVsAYTDxe2LmP0?=
 =?us-ascii?Q?0Tne9vFkngoYbcJ42Dh3V05KcsF2JHn4zB11ODx5RdJJFNmAvy+iBSnMAZ2r?=
 =?us-ascii?Q?JSpISRtsf4XjDjw+bv2MYPSNiWxE+ykj/kmtFtrB338F9CXeqA26mjpDpguv?=
 =?us-ascii?Q?mbkBxvEXAigW59qEmX1w2uOMg99DKNE2SCkO6jlq04AT60jaEMnrLTMR1AGv?=
 =?us-ascii?Q?3tlOiTyCkEHg8XclEbuRINcktRuHpKkSayptM52U8zOyYosr/eaSCp25fP01?=
 =?us-ascii?Q?MNlSmo5hVx3sd8TcEDthy8cWhD9/jLMGzNjUhzr/ufHmhbuTWGA/DNUDThpm?=
 =?us-ascii?Q?YcfU/bq50RZ0rXCrFsM6kGj5yFhTpMa1NQa4cjnY2gT7eg3+zqVvEHC/6R+8?=
 =?us-ascii?Q?6OLvBpY91xDXfmcPSzPnsnh/X6o/x7ah3n3SdpPbJZNqqlCcqCXT2jr4Sj2s?=
 =?us-ascii?Q?Cy/7jH1Op9ZTE+n041ZYcb5nTMVvXlemfYtolkKT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698fb52c-2ed1-4169-35b8-08dcc6113184
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 20:53:53.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tlytp3WFN5IZMNfXkpdKcSQBUauzGZPrB5CHz8yLMmR/l/s9t2RlVKXwOIMaeRKAB4FabYawN5h/SoIBgQQtKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10681

From: Chancel Liu <chancel.liu@nxp.com>

Add wm8962 sound card which connects to sai3.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index f20d281531734..65ed861d67d7c 100644
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
+	pinctrl_sai3_sleep: sai3grpsleep {
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


