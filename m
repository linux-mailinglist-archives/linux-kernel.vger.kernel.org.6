Return-Path: <linux-kernel+bounces-313552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6096A6F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FD31F24D89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2689E192B63;
	Tue,  3 Sep 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hWQVxEyl"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C8192582;
	Tue,  3 Sep 2024 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389714; cv=fail; b=BmEP1t5pehQfj5JtCyBLVB2/chaopSQG1K2p1DcdzRQtMbElIQqIqJ12vaDuA4eDVxEBovAgUW4bihTACW7DVDYmfuIyGmIyqzcslhQVfQt5uCTRGOCjUyhPAIf50xyP2769cbMhFFTCoU7sQAGE0jQcZd5pGw8TpzcuXKynT0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389714; c=relaxed/simple;
	bh=d1ATj0cUU3wP1yQEBOtWBzKfUAOmIrug2BVvXpsWjag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dRWJ6FTGmqPy5qAXnBUE5QL4ldunxUJfye+30ileAcHuB/TFd085TfGxYbuNuwZpnp+dceiUvii4DK6wt250b01p7BSi/fY3qGyBNo/70VXf+5bpc6C4q2A5rh8BRDNC7MhQxaITRO/ssCiUFy3uU2VlTyFmHC3SRqVFrwVk9fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hWQVxEyl; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSYSFwjt/5+DuSbc5nySVII6LD9zhqZMhCtx9e8Q7/ueScLabZTgscQTUfvEXXAr20OlvpugnoODnvbqX9W1FyZ6Y1WZzVUwyDCi/+51YrE5VAs0hF/pfbGJvTejtT67HG+t/avBgP3U+rIygERi/785Y6iW/mP+vXbQx1aXwvdje1KBHtiJyoQMmd1QfbyWLZmtIIA8FKRUAJjX96Ba68KSfq3fGX8ZN3M6/0y6xly9lD4APTZEyPMHK2tQeP0fBjLqYL1cntfpjD2OK/2ulwYqAbwrlwIz+Bo0iAOvQF/NEiqFGOAGaJlLqOI41J6lbCzjttYcIXslk5L9qxCw0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4KjuW0orwaEqigEsPJGxF5Ps1L7yKVq+FNskttQOp4=;
 b=crSbohXnZn5TFoHqJkYNHMB3brnXfQ59r9sSltNtjc/WE9d8Miu8l7mTihwroJh7WNILgqE63C+P+l7dTxz/btct9NUO0OgEliJAP05/MpXo/7pZ/UPed96YGneP8/YOAJww9oW6zWZPitll8GFxEFDL2O7qrdP666CoVb3jpI4Kcpgo9oYMQ+iLKdjbobNmkvHLa+ox8Fgx6XzbcZiIceFtuEFTArKDi1narWa662U3DFthdHbHrO/Xzn091N9Sj/PwAEUCnq67NpMBNbG/CBPHMqeYev6N9txHTb/Xf1q78VNKYG9qLhg0jJzmNbHC1kM0bGHiT6otHerLw6q0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4KjuW0orwaEqigEsPJGxF5Ps1L7yKVq+FNskttQOp4=;
 b=hWQVxEylbeu7MVEF/0a4F8R6s4AK+obYtpIpeE9DU07QU12JwRnx5DodSkpIcTtpvIMN0NgIWzrpdCQXspKatkOdXarTqUVcZja+ZTWCSswRtbzOz1/JqJC5FD+xMCaD1QKVlnf2ayt5aNupTVqUXvvO7PmrSZEn4wfqKSk0BtspmGaurncv/hzQ/1bncgQSkmNB6jvG4gNn0Ko9E9eSSQ3L+oOPGIUGeoiOO0UE2tUWg5RtCiTf2wjKTeryy2rXiiDxXQwMNfDwoUBwgpTmQ7jaZvE/hPlIPbRmSMfB8cGWoXxO0FKBQsDYwzH3JnuMQBVLGx/HEhQr4va0Tnq2TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 18:55:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 18:55:08 +0000
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
Subject: [PATCH v3 2/3] arm64: dts: imx93-11x11-evk: add flexcan support
Date: Tue,  3 Sep 2024 14:54:48 -0400
Message-Id: <20240903185450.1486505-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903185450.1486505-1-Frank.Li@nxp.com>
References: <20240903185450.1486505-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:806:120::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 743bbb24-5a90-4678-a503-08dccc49ee87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q5kimX4UhdH0Q57u9comTAi7CzzS3VQPSjEX/AfQTX41gLDbHKUfYnonj0NB?=
 =?us-ascii?Q?cU52BdrYCnkpAf2wOMa5RyLqb7FpulmSGxZU1Y9mqXRqSNnEDkuXrDhH37A9?=
 =?us-ascii?Q?ERKTBAE/afeBgBlw103N3vDG8vW4XrlrYL1Bq6+aooMn00PgXdFS7LpxiOuY?=
 =?us-ascii?Q?n/AOHCSoBUyMtotGK620MKByhbwdcVjY0V+xXwfUW+SRiYAKAoy3UgDu9EwH?=
 =?us-ascii?Q?OHXbxc2J1K//bIqcv6cN7nHMVj1uxdOC2Imkc5BqM5xmMQ8zebGUAtcsbO0T?=
 =?us-ascii?Q?roGN9vouj2Qh6aw5svRho0zzxxUtU155p+XOSNbpTJ67hdwItOZ94v0qGxwp?=
 =?us-ascii?Q?IWTDU1q/92lW1sx7uniZ2e9yzpqpM6auoJfMuYb3VDRr9NuGQ1zYkNK2vlqb?=
 =?us-ascii?Q?aLVobtqxdAER4chnbBoAJtTuJhZWZrH4zY2UDKq0kwobQy0hfq3XhWwZ2Mfq?=
 =?us-ascii?Q?LZrB6FR8k8VxgvYHcTmM7Qrv6V0p8BjmpY2qechn2s2HIN/ZdPvL25QZuV6g?=
 =?us-ascii?Q?PULTrzarc7jX8vtIi8OEZ+lJLQ7r3vSdRp1zYZx/OLmAPFo4TmzeE2q9wu++?=
 =?us-ascii?Q?cZd0YFbPPfJ7smzdusyujTkwBGF1E9xDAxQTkUTfadb+Df5qbyt4jAZ52c7t?=
 =?us-ascii?Q?+SdRG5u7P1874xuHsg3jji6uWzTYFfEOzR3dyqz9C0ZfZD0om8iassU+bNFn?=
 =?us-ascii?Q?R+suUhuHdIgcS4+4tzLo1U0iFiw2i6qnPTF7hKA326tnxY/Bzuql5FXgX5Jx?=
 =?us-ascii?Q?IC1Y/AhiJiTRyMM53OKKzU5vn8Zz4aR15VT+31qdOe5d+l8mymhPrwRNdFEz?=
 =?us-ascii?Q?PoAL+CpFWyA9xKsacxeC4bS8KY1DTDcv7wbxtHeyAIiWzXZANLxUkESNnVXQ?=
 =?us-ascii?Q?nQpHa2WFtSblmTxAfuC3NEq6sAZDUNTXhqlHN7esVn3pOXIk/uS1czagU06c?=
 =?us-ascii?Q?hMTE0DhwyC4SjjHTDLE6wSnEwT6zS66RTCi1NOgQgLb35CTHiCWjdBGWuybX?=
 =?us-ascii?Q?oLamqDyP8jhZ8jHXVtbid7ySGvGW+IJzvBMh1kF4Pm1PFb4d72DDhxHZgHAx?=
 =?us-ascii?Q?Qg/RDMqeUQCciMSmJVZiXpYd0sIqNHm77n5MOJVrqj+oGOFSz9s7Wd4V65zz?=
 =?us-ascii?Q?ZgV0hTQUIYf74WBEflvJVMcO3XDgN4oAJWwIAtCn6rgKsJ5aT2N7vzMWeKFr?=
 =?us-ascii?Q?6f7/WhZrKANs9aH5TloCIHKJdMU/C0KvPb44qo/M/MBxlKAnvIVAbB7aXl5+?=
 =?us-ascii?Q?YRdU3RHpFNZsF9brUmqPvlFE9cgR9ZetyojyoicLNI4TMQwG/VevSYzbsQE7?=
 =?us-ascii?Q?eQfl5ZlGEpnOgCLLtnqlU+jqNJEk1n3Czd/38qOwcA7Dp6gJYkXSkqrBYzQK?=
 =?us-ascii?Q?GJMNiiFBnPSQ5grNXCnmtsX0JwPvTh07GUGL4y4Fmq8dgWYz+mUNDvBn6uHj?=
 =?us-ascii?Q?IFJ59qQ1ewo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bxgMy2Dy69rb201glyJdB6vMaJpqwoHleiAMJcO005us1E8KKxyKfv43nT3e?=
 =?us-ascii?Q?oQ4t4k3CxUwnmy221H4v4TtTjJeQENMASZ2eDFLCo//Nfg900y+oozqLtFZZ?=
 =?us-ascii?Q?Ia96uU/iA60gE7BMy1ZUG+Nr6SVR8zzDMWwaXvCjgyh1vArLdFP6tjRinkfY?=
 =?us-ascii?Q?msMgSP+HzHvMfFGgl1miHcmW00m3QfYKHWZHzQNIxWBqk1+ynT7xAukt7Uoi?=
 =?us-ascii?Q?+PeXOIsnH9sSIznSgFnZwUDQnM8fMQJCSmvc8JZ2GzXBqMyM/KX6dwbbXnYl?=
 =?us-ascii?Q?O9yKJ/063C+RSNnuSdXk63vF7B+9o0yhQtSGBl8B8Y68GOQuhTONbJgxX5T0?=
 =?us-ascii?Q?D73gOVfqk/NHomvBfWJgVTIf1IQVikgAbzQ1ovUMg6YSQUbydCHfEipp9jGK?=
 =?us-ascii?Q?opIkg2BK/eF88lMa7/Q+sjjh4grggeMSy6UV3h/VuD5Xdf9M9ML3b3qeqLmQ?=
 =?us-ascii?Q?IMtDxGbk4dnuvXqqiU7FmZIt7HVXmcMGPeTFmKDgr9T62WtzXNfYeK4nOTf/?=
 =?us-ascii?Q?hsDjOIVFGvqxYU6KPxk2ss7TiupwwsxctiZkVpX66+nQzYc0ZzfV2HV3XBD2?=
 =?us-ascii?Q?Xel9leQm8OOGwz1Pw1ZcM4DvRkYVUD+axpiVeSyvDg1er8rgF4k/ZcLgXwva?=
 =?us-ascii?Q?7y3IK4E+nTvDZJ6OnUPVh2xedG7WWTLogp4e7PTbtmiYGo7Cq4cWTdlfhqMB?=
 =?us-ascii?Q?xJAohkiT58QpkU0iNnjko8h7cIcqx1RUsrMBFut81BgRHgw5J5v9fmHOYMYx?=
 =?us-ascii?Q?MaCw280oPHH5Jqvf08bqh3BcQ9yZCH7FlRjPW6UDUHwzDGtXbjaK5VvqNVNm?=
 =?us-ascii?Q?ojM0UIyy+SxgXawXvddph87/y7b058WXd0IlRBbyuHD72gCVpHn/i5hGb6Oq?=
 =?us-ascii?Q?HX5duYi2GnBw7euTp3oqA75G+NNovIyxaslpswsuzrmYPvACeOS9jFDn3+1U?=
 =?us-ascii?Q?Xmrw7WvZnApdqWTj/DWpBvzSulFn5lYDj5zmQ1ONsROh89Ro88rpXRvgLT1q?=
 =?us-ascii?Q?Q5pAIQIV4RxtSkuPfBk/gvUgceRe68jwBdDrfhCSYImnY6FwUnMH+e/lQpVC?=
 =?us-ascii?Q?knhekI34/zgc/1Ki+tGM6pAdaPx50uJnKdtBSMYaTH4NTGR2EhlZJvZs2wzS?=
 =?us-ascii?Q?qG4AtlFsc3EIoY/GGpasrtbvShEwHEk4iay3IKHHU4V2ioCaERzM5tEGGMuZ?=
 =?us-ascii?Q?DfeBhZrydkp1YAAhpovFjjTAs7Aeugqp4Ze4OKnX1+RlEqcDlkVkyleWtEzD?=
 =?us-ascii?Q?CSY9g3i6eLiCTZOs7AkjNNVZTIo2AxQyoquU0KH825TggGAu1KFGB4fHnZ/9?=
 =?us-ascii?Q?c+iwkTBOxLRgUjIKZJqSrw1drmwCBxJ9GfHwaIo4qElzIdSzG6qF98WiWwWx?=
 =?us-ascii?Q?UjW12EylKS9OQbqjS+6DlZb7VmCzUKhHK6cF5fwscE2rWqdE60heid9M+FmU?=
 =?us-ascii?Q?BpgpUUdpjtBK5FIFvFBFhr0fjXXsT8khnVDkj2NIkWfOnFRAlUuB9zq5ITAk?=
 =?us-ascii?Q?NfEmF6064BqWHp91/AZMnYQc1MqR9Pp+zCCOEUjwzXnZKBKie3HFb5gtlqzP?=
 =?us-ascii?Q?y0Pp/C9abFoDpFNOrL1CWfgSc2G0VBHZ6wS1uA+c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743bbb24-5a90-4678-a503-08dccc49ee87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 18:55:08.7344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1Ibio6BAwx7KkpCJbDPCsoBs9ux2qQxvEm506nc2hxWs3dC1f28qeUdLF4duAYlZVafa3K+2RJwuKNYdqPJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300

From: Haibo Chen <haibo.chen@nxp.com>

Add flexcan support.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- update label to adp5585
change from v1 to v2
- none
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 94a400ccd1a2c..76177b723ef3c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -78,6 +78,14 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_can2_standby: regulator-can2-standby {
+		compatible = "regulator-fixed";
+		regulator-name = "can2-stby";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&adp5585 6 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -216,6 +224,13 @@ ethphy2: ethernet-phy@2 {
 	};
 };
 
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	xceiver-supply = <&reg_can2_standby>;
+	status = "okay";
+};
+
 &lpi2c1 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -622,6 +637,13 @@ MX93_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
 		>;
 	};
 
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX93_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-- 
2.34.1


