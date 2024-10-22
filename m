Return-Path: <linux-kernel+bounces-375618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECEB9A983D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3104B1C2238C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC77612C552;
	Tue, 22 Oct 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eiGNQg1O"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57213AA4C;
	Tue, 22 Oct 2024 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574376; cv=fail; b=IVOStRrDv0wvmVP9LEgWk9tNKNjGAo94C+EuW9z7izepjS5LxbNJs3KDXIgNtrM8L1n7Fe5tldBAIDdBAK/KPNTY2ZRhJ09GFqiUVxYkkfPV+Tb7LaRonhv+wE1GpYK8FGyJAIwVJ4gAkqzoghC6dvSTiJ1ST8WyG3ArN9pAZGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574376; c=relaxed/simple;
	bh=pHeRz8l+69uRa213DsXwJ+2eugbFh8OguVFT2YNaeeg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btJiRvFszoUYGc/zNs4i41I5RmAbmnG6NCYhqVj6P6TUjpdjguII4HxO+bMAoU0SYesMUnMFSnc53XuKZ4P/IOmat2cVVnVuIFZHf62N8nBQmyNulvjSGycZq/WhgZCkwGPAPSV5AQwwKZMJZIVbKrWvQzUdVJjM/J5Y7GQgCdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eiGNQg1O; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHThKZPN963TvAw6qxvlrQBv8i9u5ph/YztxLpPz2d7pdaedvgb9xkT8Fz1Y/tCydLlmyobj/ulGrBlvu1g3pDSJsXt8EHt8qUXg0hzoNt5noarSiPa2tPpV4Vx8aBHuDLZNn/Sj3UmNPRsHcq88/R638uxVtDhduwsjhZO9Y8RgBzBgaAfvfcTT6+OBHBrVgIPaaXCnpgA0ZfTvBjPiAENr7fgG1g91Ntmd4ntZwx34GiBih9hIUn0BYwiulCXkmVkMiS7GGVhU6TQM0CXkjMWLqW6Tpmsro1C3fzIpXvT2/22wKhUm4adV9o7wyUZIrbSbmoo80ROjn233WJntgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipCLY1pO2CfqUcxxKLSMtVz20lU07W7JJkSZX/zosDI=;
 b=cYHC2ulvNbb5t+hU1schyWeQMwz6RM+MWgdxud4ALjgHxNL+qet8h55RM56Wqeuytp0qTb57ooH9iRJXVG3KIRQ5XHv7NEKj4CVDz65gtUG2gDaKxt8y4EzAH74/VpJlnTvlzOk8ze1ueX2tcau3HGo+gNnf0RAg3n5E9gsXa5d+pIUm6YqhBOwgRmd/ImLfHl5Q5+dqDHqdftUcFWZJIidrGfFJ37ZKAW+76py38KKl81VRA9nPuegT17HlsLncfInOP0r4a5tzuKo/9OVomauaPWq2oFB31wXwm6B/O/Q7xOdeabKguBDWsRCe06wKXEZyZDWnD2w4LNY1xkZxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipCLY1pO2CfqUcxxKLSMtVz20lU07W7JJkSZX/zosDI=;
 b=eiGNQg1OHzvyCXPfcnUdC0tv2TfQlmj8luv+4JTdDPDIxpaTHekpp+B2t5Y3jkKxTlUn1Bb5/YxGjHPRIQ2Pl8xRjhm6l6TPGxbu4bNpTnfQeGG1XVNUrPaQQ7CJ0nUNuepCZi4Qka5reUPxI+SUp/AC+8GgGl2yVBK1n3oBMWRLARP4qjRSGs8EjlY+3Uf3hS4KuT6+vMD0wKU89KIe6M5WXTGGNmuJej7R+1JUhjPeR6biVX13IuZ3P13vXeM6eGxyrsoe0pKqlD2ppYK2Rx1tMpIOzv94ucjMxqd166D7Jh75LmnW1LciqPwBqYdpO3afhs/KfWZKigEIpQiomg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 22 Oct
 2024 05:19:32 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 05:19:32 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 2/3] arm64: dts: imx8ulp-evk: Add bt-sco sound card support
Date: Tue, 22 Oct 2024 13:29:18 +0800
Message-Id: <20241022052919.1946074-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
References: <20241022052919.1946074-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To VI1PR04MB7055.eurprd04.prod.outlook.com
 (2603:10a6:800:123::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 4695e63b-2ee1-453b-5691-08dcf2591c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36vw4RX3XKPsUEBiiP2BY9MdtimYnu5M/f7e+7Oz5xE36KO6n7VfS6Ogmybt?=
 =?us-ascii?Q?eWFTMBn6uN/GIEUwWDvqWdbWmcJqYp/qVH8ei+XG/pNobbJ5tVKsLO28+3O0?=
 =?us-ascii?Q?E5igiTBZQAIENjXZuZ/c1IMMw+L/lJ7oLikxYvZUYsu5sl3qrsqOaqHgpYQ2?=
 =?us-ascii?Q?U2juUgsdzjGgsa457WtnekXuodv1UEzX1uLjqD8eM8drWPuZKMvov+91Y0O0?=
 =?us-ascii?Q?7gjN0mNuIgfT+VnByOH5+6Und+5/uE4HuevH3TMI7EsnBC4wI8OoiaM2E45V?=
 =?us-ascii?Q?AsWMzz63AO36Do7uQY4HeT2L2yX/IKM3M9WNtuD54DCJs8dKpKWcUIAXWLLW?=
 =?us-ascii?Q?Zu2ZGhbX6z5U1JUCqYMDhzutfEbmRUiI1a5Dgth5RgswUODG9G5p+/jR/qCY?=
 =?us-ascii?Q?ia3VYZYE4kDrCaIOmy9Lz3U1QPcxHt0aQOF9qLUIqXCsjcl8MiRatdHBfsh5?=
 =?us-ascii?Q?WS5gedW5DaJUpLhzFQ3PMb1gFt/FjXlo4bs41H8dBbWt5qO6CruPGEd4fdsh?=
 =?us-ascii?Q?iXm+s4FGQS6PTa7va5pcPEuSIKSWhevVQ1Thv0tesMscMbh3VpEWQWu/YCm6?=
 =?us-ascii?Q?iaL9dPg+0G4XNzuWJwUFomPSSa3MomYC5QMavASxVDUgBnkFtulcFqNFddAw?=
 =?us-ascii?Q?NPjiHrd1zcusquwwqikhzHxet4rBwiONzbzEy0xX4Jk3uZn6J6aI4qfOpvK9?=
 =?us-ascii?Q?rLp7xn9ng7CQ/lQMYKVTOAWrjav1IfsM6aoNDna2nPXX35bYYb/6dFjSBnF4?=
 =?us-ascii?Q?cFlCw+5TX0Nj3PWRAyzq3Cqq7gsTQajETAUBwyq+27ftVc8sVRYcu/5UJxwR?=
 =?us-ascii?Q?/rHaCiIZsdjQfYm9Mp2tmfgX38JMWblYVkIK0I8V78zHZiYGX1qUVdTT/SRR?=
 =?us-ascii?Q?SD8e32Mi9C//HgCo+UfbEboq03iexlphpn55NEzb747ULpzJkNVmgGhhEKoe?=
 =?us-ascii?Q?t6ypKJKvgNfxDGdEO9xOyqrrNt3KixWD4TyylPrAULYpY0V0E1MoaSDupVp6?=
 =?us-ascii?Q?tGfUTcas0G7zxHKAFWDuBpvDph3heK/tfzdbQPOTfmIRBI1NvhS6QWFvfqzj?=
 =?us-ascii?Q?E4rvLYMYSychqohydFBesVUy6xTJR+tp4cef3Lzb1qb+naW7FsECO2AiQ5/T?=
 =?us-ascii?Q?U5mz1r7S8z7mkRmijij8W2Tl80PU9l3hhg1Zrpu27Go5JgbXsMmIqu2UDdA1?=
 =?us-ascii?Q?l+7YfBaoAlhj0dFlUoxrO6bYBA4bsxlYUJAXr8+0U0cLo4GQwj6BidHjNKDv?=
 =?us-ascii?Q?E+VmZ0R70kOUR3BwngfUC/xpjkgsnzb3dk62bDKja+qcUGK4EBPZoo4LOsCs?=
 =?us-ascii?Q?1YV4Ppj7h3Q256OYBHMWHvrCd30JTVcoAsG7ZII/r/8U1pDElmrvbNOq2CXz?=
 =?us-ascii?Q?ahHXTc5HIuOJ0lamobGhPiZ7A1aQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p7KDOhtWFC6V8ibwFbKCKqBXXhWAnjByvZLQyPpPcEUH/683e1/BLFqGLg+u?=
 =?us-ascii?Q?DvGO0klzg0fugQoAXkh1L9QijrBmlf03Ot1XJuRe5cNLIJFafZNNnoIbdgwl?=
 =?us-ascii?Q?2TcSaKauM4XewleJ2Xrj3NtEQiVyrd5Gv3fQO2g+I8LM+XGDE+wuK1h+eASn?=
 =?us-ascii?Q?hN2Ovy0pUpC8MUWBjB9Qo8NdLw/CYYiU+T67qTbj0g6u0j+QwDuZEmABJw2d?=
 =?us-ascii?Q?3gKuTC1z8esxrqZqvloXMCcnDO7lmwGasfcc3WioO5AYPDaqnJUYsGevrTAV?=
 =?us-ascii?Q?QtD94CyS2Jvh+MYVMuplbinEKUDEi3L1K4CuIt8R07R5In+T+cJfrjQBK2vR?=
 =?us-ascii?Q?tFGmdrGkwUp1EKoC0Vio3Bc02QfxFCD+wd+q3KNOEDyxaDMhogY7oXckky+E?=
 =?us-ascii?Q?qg3ReaWQ3sdIQjccTidHnvVTvls5rp9wiOziLiVfsshjYIRyPsQTC01c9R/F?=
 =?us-ascii?Q?t476w2siTl4asMXSAawLgLTfl/WVYyi7+izDO9xb9F0HWqEf76vR1ltPZmiz?=
 =?us-ascii?Q?gjxZWBJcac1/IPrqOnbx2CIAuogcvS8ipNmGrfPixwyKJKMxja71AHEiegC0?=
 =?us-ascii?Q?PavviXUIpKyGd7D0aOA+Y4P44HV3vY9kOtsZ85WRUYM+/ubyWy5qo2feglDn?=
 =?us-ascii?Q?hL9vk3Bz4ee16mguDer/gzqFZ9FKDSt+U02KaNij06l3NmgS4rCecakVaK4F?=
 =?us-ascii?Q?BF1Cg8xlxOpxQnDlLwwY1MMau+ZTw/J+gdfnxq6C2IrqnJm34M3zjsjIaBYJ?=
 =?us-ascii?Q?Ua1LyYJZHO0ZtSPY2EL17ThUi5eH1cVE8llQE5TE3Ezf/loyVQscmHDYQ220?=
 =?us-ascii?Q?QDIu1LwEepQvzzgl9DK22HkgxaXaDwjZSVrU7PXDwchTDtlpBasWRAQC1aKY?=
 =?us-ascii?Q?NCZ0S3mNs+v/t/FGYUtn7CodfoP3H25BPPipTsAOlZhUM5WDMoMP0r4qSOAS?=
 =?us-ascii?Q?ck2envCnnpuIWtiE+4Zspeqb6iWmf2RMoI2QjIMaqjTkFDv03JpwuW0aqDIP?=
 =?us-ascii?Q?EPkVV2ZAjctRlknB73ya37aAwpRqnABzESZTLH+Z1d5g3FNy6huvDklZ7iRK?=
 =?us-ascii?Q?hgJQVpiSeqAxKg+eLMkcSL/EPWrVEgrMiCrYMCrhLqUpnKnM0fgii5S6tSLi?=
 =?us-ascii?Q?z8WrOFkXzH4R+nWsO5UopK3q/J4g1VnBismzEbR/5GL0tU3hwLhg3mqRm/UE?=
 =?us-ascii?Q?MadxKp2dqRxgnNWaJN3ViPU0D5aDK2+4wGBcCP4GvhTjwF2etRWec8wZbUse?=
 =?us-ascii?Q?KX9bq1Euf1yfo/FHdNxC0ZuKalIQDwdc9wi52WjnEOl34lx7Q1M3jsl6BC/A?=
 =?us-ascii?Q?xKz1wh5sNVV+7i84VFUaXAIvA6kxyFrNs/349dM9e+Wf57L3piD/5PwttPoT?=
 =?us-ascii?Q?A+KyAsQaGgsv8gWyaYTiVC69oBQlLPtn7vG5SRsUdeWlDqWU5hNBxXZL8pZf?=
 =?us-ascii?Q?oohhaiZFe6+7DR6Qj4/qQ8txm7kIGMQcxkw0o9rUBVdxdKY4yzfWiRMsVQjI?=
 =?us-ascii?Q?2bV7QmuJFrfUVFgWZU5s3XFkylLiz4TuzT81Ctp4kY+78CGWhxixZ1X1taKq?=
 =?us-ascii?Q?3o9eDQdBICU2SGrg67w0PkDsoa+BqkjBlewTJcNw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4695e63b-2ee1-453b-5691-08dcf2591c0a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:19:31.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCosfTfNcYt+Lr7q5kvG4ryMA3ALxgRZKQ6qj98B4rIGrybQdKiewhk9lC/X3383abfPPXBmJJHrlqnOjHDHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

Add bt-sco sound card, which is used by BT HFP case.
It supports wb profile as default

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e937e5f8fa8b..7d6d332fa779 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -11,6 +11,11 @@ / {
 	model = "NXP i.MX8ULP EVK";
 	compatible = "fsl,imx8ulp-evk", "fsl,imx8ulp";
 
+	bt_sco_codec: bt-sco-codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = &lpuart5;
 	};
@@ -83,6 +88,25 @@ clock_ext_ts: clock-ext-ts {
 		clock-output-names = "ext_ts_clk";
 		#clock-cells = <0>;
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
+			sound-dai = <&sai5>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
 };
 
 &cm33 {
@@ -153,6 +177,16 @@ ptn5150_2: typec@3d {
 	};
 };
 
+&sai5 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai5>;
+	pinctrl-1 = <&pinctrl_sai5>;
+	assigned-clocks = <&cgc1 IMX8ULP_CLK_SAI5_SEL>;
+	assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SPLL3_PFD1_DIV1>;
+	fsl,dataline = <1 0x08 0x01>;
+	status = "okay";
+};
+
 &usbotg1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb1>;
@@ -282,6 +316,15 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF26__I2S5_TX_BCLK	0x43
+			MX8ULP_PAD_PTF27__I2S5_TX_FS	0x43
+			MX8ULP_PAD_PTF28__I2S5_TXD0	0x43
+			MX8ULP_PAD_PTF24__I2S5_RXD3	0x43
+		>;
+	};
+
 	pinctrl_typec1: typec1grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTF3__PTF3           0x3
-- 
2.34.1


