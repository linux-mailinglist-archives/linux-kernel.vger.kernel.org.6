Return-Path: <linux-kernel+bounces-236969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A995091E932
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E0F282D66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B617164A;
	Mon,  1 Jul 2024 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cyw2gGuU"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F201B17085A;
	Mon,  1 Jul 2024 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864474; cv=fail; b=VKamjwz02rOHuiUmjo7hMPdpIqCbNzJmmH/+Cp++03DgBCBHwz8vTqszIXsVfSE3LaKSqQxYAiq7qa9QrsP0FgefVRcTJCU3CtTuo/it1/BekRlhmjcCrC1VLBSpzV2DAMuolokHpSThE31w6KTfBF/IfTYody/dNlwsuFz+g2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864474; c=relaxed/simple;
	bh=6KJScZ4PmOIUujdlun7s/IznUdvgYJKAmuksmgazJWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CsiGpYcuiIAK5fBfLvO6X8YKbTVID6a4sNkpwFQI1K7PESmPTjgcH1mDwZ5/KG9sJTgI/5nT/r8YkS4l94b9s9I2xO3oEcU19X7JqLnmsiYKOIlKP2MhT3dASXS8CtFoNaVaq9HKHns5fABfG9+jHpR+j7m8XfMSKQMqtfmvYHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cyw2gGuU; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4GQ+0f/IgTbVAYdUQgfHUbpsosROzU6rl/S+nv30bsXhy+2PDaKeNZrDHjB8NvbPmJO66zzrBh+kcWbT6ngMSJUCfBoVX4JNaLxFcfmZYUu2eK2ns0Jz+mDWvzXcAROph081wyWyl6+9bH2+1Ptwln6c80pm/CvTupb6w0ZEv2T7y8mk5b+f6KpoWiXgOGP6WB5J0SqKZKWHjSTEYxDaaVytfpOf9W//jeQgzlweUU30jVZU7sC5GdaJYW+5JIwYtbsDDzs1sGvciuq+maVhlyMe/h5VuqxGGq4AKbhuFAT5kohET90jNTpYqYijhJfKBCWDJyf6m7lMcadoydaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2YokhQlYiIhjQL9uGRHbTUV9PZu6SbyXZznuQOO4H8=;
 b=HLPQTKtDxqU0t7P60qQMqC4aGL5qP3hV04j1b19AQeacJMMK93+S0e8hc6N/Q+7YL4jVLF4kzZDRpaOhQyVyp7CWB8k2iuNM77iBF/9PMWo2U+aKkRDKsa+iX+Tg6onsIvoiVWBL0ZY84g109l5wy8EMb5e/StAyskXszx/GH00viI3+PtScoapS9ZKglW4goyKDH1IaVbLkV3X2JY3fDJz5DRYiSme30wTYDMwlUxAjrOfunyaXY5+jpxd6m6brYHXh8S2tmr6QMHhUZGBXcpZBDI9hJlMy3U/RBXriV8oT5/0WKETkpeVQD+R1ztGdi3yEccMcAcpqsMi/4bCtzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2YokhQlYiIhjQL9uGRHbTUV9PZu6SbyXZznuQOO4H8=;
 b=Cyw2gGuUurzAYSL3FTbbuENI240SoqSg0lMDTVXvDHDxLxkpfnArg7Xww3IRks+173rb/FGueEALZvvqyiZFXBhExh9TKEx/FrYgVff0Bn+EM7K3YAHPUqrMolD+/zaPkTlIFKOIs41WVwp5WLYlPv+O3o/me5m7H+gu/hV/pgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 20:07:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 20:07:51 +0000
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
Subject: [PATCH v2 3/7] arm64: dts: imx95-19x19-evk: Add audio related nodes
Date: Mon,  1 Jul 2024 16:07:24 -0400
Message-Id: <20240701200728.1887467-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701200728.1887467-1-Frank.Li@nxp.com>
References: <20240701200728.1887467-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe66816-dc50-4bcc-13fb-08dc9a097cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NtXPFACrKhZ9rvYrD3tEld2Vj4rQUv1eH+G7/KRc+6PYNNGJCwhMT/X7Qs8G?=
 =?us-ascii?Q?th9hNXVlCnkxGrSZmKS+sNp+E1cnubFXSGB8hL3KQUtwGqFo261AW15mgo1c?=
 =?us-ascii?Q?r+ImEE//6FpNQ2aKqD84zD+UG140o9cFe6V94OyO3dE2at9CNbr0nn/Kpiys?=
 =?us-ascii?Q?qIsEo6z65omymK9M6GB7cAItkwi4WZmJrxxgwO5LpSx9s7hWUPTe1t5XMGdb?=
 =?us-ascii?Q?XV29WbiQEiYfVe1xtvvy+HQxkHFIhi7XGinrLpWqZqcTmLEJeNHbLQBL37bQ?=
 =?us-ascii?Q?07jYGvtnS3ZjRYdwl6PRpTHWHDKqPZxWPrc3C6ZP2Zc/dKu1bigY7k9rXVUc?=
 =?us-ascii?Q?zp6gZyBsoKFWSHAPyWVyCSvtBXa/654F/Sb2knvqTRYwhQ330aB3vKL/3pGL?=
 =?us-ascii?Q?OnD9A40fIAbtgLbWATcHc2MTXja2BwHaISHS4UX4pjcP7Sl+ujoeS/njjzB7?=
 =?us-ascii?Q?KUIbUJjJZLz5IaWjrdnxbBTK+1XBVj0d1GMdbzwVD/zPMXYK2whUPHh7Pi+g?=
 =?us-ascii?Q?X/wmmLPUTt4Lj2f2rZq0HY6/boc/NrKCRe8+o2dRImbomjFb0fYgvN6TVmFz?=
 =?us-ascii?Q?kln6Nrj3mvfTsWrc10MUGrJ4LUd64D3bXqPk0EeLkjzJ9s4hcDGKqr/2jZ2N?=
 =?us-ascii?Q?65+vukb114RVLwQCn/zQesSxjkF1KQDWSHejAPtQKTAy7uSC/56LIACCrqbD?=
 =?us-ascii?Q?wJeOpWKBJCys8LmT7cWjfllgbHhgMqL5QMOWOnP0dM26remPfQteUCx26AOC?=
 =?us-ascii?Q?biwDnOIdZUTaboESmweilMaxcXqxUPs84Pfy+dBwQ1M/xjzwfb9CcmGno+YS?=
 =?us-ascii?Q?jK2D0B0oKecV0CPfWs2mVr7B+GcFBLDVcIl54eepdOkF5qOyYAm67ieUAwOe?=
 =?us-ascii?Q?wU+Bj3M9aoWxAbhp/dr+Z4z5PbOsJcXAqIJxXQxvzXM1qSgtlAW+rNa4c2Ur?=
 =?us-ascii?Q?ecMBTqvmTS6KxsSNiLMSpRxDHWn/PcnCZbNE2ClaMPIf0VwDFHcz8hRo/gLV?=
 =?us-ascii?Q?H6r71boYnlMgKN1wU45CsjKx1LEWZhlthMoiN+kEAdpX0ObhbI+lSRkl8mhX?=
 =?us-ascii?Q?GZ1kE5uc8l/Y3d+62PnwN6G6HFW8X2v9jn0yzMaR/j7+5ToPIoRAmFl/vxg5?=
 =?us-ascii?Q?aykYY+FICOKbrko97F73GzjsJ08JU3Kwl8IM/YB5xiYIv7zhxTYTD8ZDqWkO?=
 =?us-ascii?Q?tLymRBDKdfdLKTHY6QfuXc6haq1QsQqk0rCHEgwYr/HKRR3P5rZhHOGL4PEZ?=
 =?us-ascii?Q?rRsvSYckCdib9trswRGSx4iste46wHjaB5anEjPonvt1TLhe6t+xKaWAb3vw?=
 =?us-ascii?Q?IB5Xg3+uSjOU0uCX8LSWt48NRWHmt1uGZAmxCFZkPFcnvNTMAXraqX1p6109?=
 =?us-ascii?Q?xEfO4qd6FSNfnsugMnPSW333siXeXr6tShq1CSvjCMXlgR0v8UZFpZRCU2gS?=
 =?us-ascii?Q?T3AV+dvTLp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6VdQZ3A8HqDr9JdhvSAvNFfZ6PzSZyKaXhe2nAFYyTo24Tjfl9fhBTJ15q4B?=
 =?us-ascii?Q?EQ+4t/1n5KPikCCpTu1snLRIk8upFWZF6LlE3zNVTSB+5uhRqtFqvyAiQ2Rc?=
 =?us-ascii?Q?NICFDcGEBgX0L7ZcP2hHgRbK6Vv7QoYWvh87Wzei2xL8REHzArFgaqnz3QUE?=
 =?us-ascii?Q?nEVDgk6fLUylSsn3lRHGZYmb9iiuNAfUmaG3EacH6Ad/4BLVTbKWR8ox0ANJ?=
 =?us-ascii?Q?qmFi4A9jEL6Mwlmc61JkVUK6tazBei0rXQqSvUimz16X/BEY94rSEvnSGzQK?=
 =?us-ascii?Q?jHi8HEBRFDUUiAnek60ZuoDN8KgnINTUWrBhaLYj0PiM5NH7DtUeXxxq9Ted?=
 =?us-ascii?Q?W3Tq3EOIg2gdm36N5YyeDkbttnOMrpfqv0Eq6uSQ+b/yv3gCnKFmCSGJLa/Z?=
 =?us-ascii?Q?/vCOTKfjHDRFiYd0c5ASoIkdLT3AgPIutvta8ggccVLWOohVXCOo+JvjQgE7?=
 =?us-ascii?Q?tU6QS5NQEhsFBrEI/+cBsYBQlkDg0HyfO5PDlAMaK33huSB8zem4xRyxBGg/?=
 =?us-ascii?Q?0802oHNsE0j+J80OzXb7HnwOTXWnwg8x0mXstfQdlyBR8ceKlhNmgv9MZ9BY?=
 =?us-ascii?Q?75K4ZmJxHN1m+i+7RxWujzpqjPyGs1GcSlNYO/KfCH04AHov0N2ILxu6SmM2?=
 =?us-ascii?Q?eOHoSF7awgUVYkKq7hxI7oLRb0/EyXPNIAqgUs+6BkM34St+JrEAT27YJCTQ?=
 =?us-ascii?Q?XaBRdIoNc5vg5DpPXI22ZZQelkmq4QVpr+hJ42kJotZIyK6Z9XbHds9SsNlv?=
 =?us-ascii?Q?Bh71TSgx9EXZ5XOGdbU3VNfM1Sso9sDTiqWeR2Xe2Ah1ftH2SrX8SZywF42Y?=
 =?us-ascii?Q?BL3iZwg7eXty393Qbg9Q48hiMeor7Aqozd8AGB1bvqohZZ90mIWdroWGmIdh?=
 =?us-ascii?Q?lONWK3if3pUhfyF0pB6YtnNu0M7+48syiCEvGAvkHsjPweiPjKWFuDZWS3Gm?=
 =?us-ascii?Q?8AqE9cLW6R15ItOG52q3R7Gay6D4D6Bg0Kki6nfaaXbYcW3bMrJwYXRTgIbL?=
 =?us-ascii?Q?32OWANfrLtuwCjF7TLvDWiYrFJ6C7B+YwNQ/aLBtxTPa/9OgETKg+h5YVTpN?=
 =?us-ascii?Q?gd5RA44BdcepIRaiqYBbmKIVw37JAjm5riVyy7aIxfxBNtv7kcejhycXq8Px?=
 =?us-ascii?Q?igk9VRY+c8si0kmgzRgV2rvXfaweAeSIGtNmxKbRbej7zV30vmi3DNjeiBUS?=
 =?us-ascii?Q?bH2fVC3M38Q9RMJnMgb5KT1+bEI2llD+O9iF0jI2y02d/hQCoRLz3DYZ5PVf?=
 =?us-ascii?Q?utpDUwgiNwEwXVckYNHyjyIfSdBiCAR0gMLT53oSDiNhSqZ4xA8QAPKlB4P8?=
 =?us-ascii?Q?RoTspST/cnlFe1vTWNfWW0Wfep35HeEAYhFwfQfDTVhhIbybID3T8OBRsEDI?=
 =?us-ascii?Q?qI43ZMHIsWsX6ZYY3arO0xh+Th1ogoElAdksw4Na3auShF+ynoxV2dQMIkp8?=
 =?us-ascii?Q?pEmJVOC4B8IavXABYw+BuA9n9Jdzxtt75Ow4jWuCadptvqBBSNQJxMLiItDX?=
 =?us-ascii?Q?/sP5mIY2T6uspD2hp6YiZcP/tDv1qo7+FgAUyILizjbK275pneVF4eNtWbd8?=
 =?us-ascii?Q?oZNJPYTWEB72D90gAFRxqAeITYlt+GkURyUx6bPh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe66816-dc50-4bcc-13fb-08dc9a097cb1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 20:07:51.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcHbiKur/ARZ3Z4WtSO7+dtYJUmLn0szJ0PTf0jwm47Ca2PCUiMHbtIy6cPkLR1aeokmRLrwX1Twl6o58fZQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638

Add sai1, sai2. Add i2c4 and wm8962 and other dependent nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- none
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 238 ++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index d14a54ab4fd47..660e623f4f964 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -17,6 +17,11 @@ aliases {
 		serial0 = &lpuart1;
 	};
 
+	bt_sco_codec: audio-codec-bt-sco {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = &lpuart1;
 	};
@@ -40,6 +45,34 @@ linux_cma: linux,cma {
 		};
 	};
 
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SW";
+	};
+
+	reg_audio_pwr: regulator-audio-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c4_gpio_expander_21 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_audio_slot: regulator-audio-slot {
+		compatible = "regulator-fixed";
+		regulator-name = "audio-wm8962";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&i2c4_gpio_expander_21 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		status = "disabled";
+	};
+
 	reg_m2_pwr: regulator-m2-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "M.2-power";
@@ -79,6 +112,97 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 		off-on-delay-us = <12000>;
 	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "micfil-audio";
+
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
+
+	sound-wm8962 {
+		compatible = "fsl,imx-audio-wm8962";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hp>;
+		model = "wm8962-audio";
+		audio-cpu = <&sai3>;
+		audio-codec = <&wm8962>;
+		hp-det-gpio = <&gpio2 11 GPIO_ACTIVE_HIGH>;
+		audio-routing = "Headphone Jack", "HPOUTL",
+				"Headphone Jack", "HPOUTR",
+				"Ext Spk", "SPKOUTL",
+				"Ext Spk", "SPKOUTR",
+				"AMIC", "MICBIAS",
+				"IN3R", "AMIC",
+				"IN1R", "AMIC";
+	};
+};
+
+&lpi2c4 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	status = "okay";
+
+	wm8962: audio-codec@1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		DCVDD-supply = <&reg_audio_pwr>;
+		DBVDD-supply = <&reg_audio_pwr>;
+		AVDD-supply = <&reg_audio_pwr>;
+		CPVDD-supply = <&reg_audio_pwr>;
+		MICVDD-supply = <&reg_audio_pwr>;
+		PLLVDD-supply = <&reg_audio_pwr>;
+		SPKVDD1-supply = <&reg_audio_pwr>;
+		SPKVDD2-supply = <&reg_audio_pwr>;
+		gpio-cfg = < 0x0000 /* 0:Default */
+			     0x0000 /* 1:Default */
+			     0x0000 /* 2:FN_DMICCLK */
+			     0x0000 /* 3:Default */
+			     0x0000 /* 4:FN_DMICCDAT */
+			     0x0000 /* 5:Default */
+			   >;
+	};
+
+	i2c4_gpio_expander_21: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c4_pcal6408>;
+		vcc-supply = <&reg_3p3v>;
+	};
 };
 
 &lpi2c7 {
@@ -108,6 +232,23 @@ &lpuart1 {
 	status = "okay";
 };
 
+&micfil {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_PDM>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <49152000>;
+	status = "okay";
+};
+
 &mu7 {
 	status = "okay";
 };
@@ -128,6 +269,42 @@ &pcie1 {
 	status = "okay";
 };
 
+&sai1 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI1>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&sai3 {
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -159,12 +336,31 @@ &wdog3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_hp: hpgrp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11		0x31e
+		>;
+	};
+
+	pinctrl_i2c4_pcal6408: i2c4pcal6498grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18			0x31e
+		>;
+	};
+
 	pinctrl_i2c7_pcal6524: i2c7pcal6524grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO36__GPIO5_IO_BIT16			0x31e
 		>;
 	};
 
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO30__LPI2C4_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c7: lpi2c7grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
@@ -184,6 +380,48 @@ IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e
+			IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_PDM_BIT_STREAM_BIT0	0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX95_PAD_SAI1_RXD0__AONMIX_TOP_SAI1_RX_DATA_BIT0    0x31e
+			IMX95_PAD_SAI1_TXC__AONMIX_TOP_SAI1_TX_BCLK      0x31e
+			IMX95_PAD_SAI1_TXFS__AONMIX_TOP_SAI1_TX_SYNC     0x31e
+			IMX95_PAD_SAI1_TXD0__AONMIX_TOP_SAI1_TX_DATA_BIT0    0x31e
+		>;
+	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_SAI2_RX_BCLK			0x31e
+			IMX95_PAD_ENET2_MDC__NETCMIX_TOP_SAI2_RX_SYNC			0x31e
+			IMX95_PAD_ENET2_TD3__NETCMIX_TOP_SAI2_RX_DATA_BIT0		0x31e
+			IMX95_PAD_ENET2_TD2__NETCMIX_TOP_SAI2_RX_DATA_BIT1		0x31e
+			IMX95_PAD_ENET2_TXC__NETCMIX_TOP_SAI2_TX_BCLK			0x31e
+			IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_SAI2_TX_SYNC		0x31e
+			IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_SAI2_TX_DATA_BIT0		0x31e
+			IMX95_PAD_ENET2_RXC__NETCMIX_TOP_SAI2_TX_DATA_BIT1		0x31e
+			IMX95_PAD_ENET2_RD0__NETCMIX_TOP_SAI2_TX_DATA_BIT2		0x31e
+			IMX95_PAD_ENET2_RD1__NETCMIX_TOP_SAI2_TX_DATA_BIT3		0x31e
+			IMX95_PAD_ENET2_RD2__NETCMIX_TOP_SAI2_MCLK			0x31e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO17__SAI3_MCLK				0x31e
+			IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK			0x31e
+			IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC			0x31e
+			IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0			0x31e
+			IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0			0x31e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX      0x31e
-- 
2.34.1


