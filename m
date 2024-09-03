Return-Path: <linux-kernel+bounces-313551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F0096A6F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3235F1F24DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F918E030;
	Tue,  3 Sep 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dx7Q6NOb"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE201917E9;
	Tue,  3 Sep 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389712; cv=fail; b=j+U2eVV84a9ejCVfdMZoJxtrhqGqFm/1p0GxRdqcj3o8twahKZk16ZQukNLC6eAjo8KiKGmozLdO3KMcThHkbdIH92P9o/zziNUg+SEpVqi8HqZkMrPyzrMoULxLaVbuRXLEd9wWveRT+5LtSB7l6FjqeAekX/y0i+765D0tf20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389712; c=relaxed/simple;
	bh=x2ytIHY6zptjGnYhwrEpOS5jEKb8m+aNqRTXqdbvSZM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=b1gzbNimZQYSqvTe1MF7dhjj3RBCUzyvMoPD8wMCqc1wQ8Qco3CZZsLsUyv1isU8x2qLeteVoirQQvvLBBDdkZ6z9ZxDrtQTuLgY47jm+NiSGSaNL+J3kCp3fefwilvyS3lwtcWvsbhqRDyvYzhGI4CpneqzxbNkiE38i1SsuEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dx7Q6NOb; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJNlIQu+TNuodxkFHxBL800Q5Yr9aKdNL1ZgV1oGv8oUQvXQBcvfbiZ6PzPbWS5oPkDZxFpZ0HkVhV/C1o3uM87oZ8n7G07H75WkNsll+5zEzxIj4AFGjcF6AKOR42tGb07rmYnIeR3K9Q3W75PneZxSXbTTLZ2Rjepqqdeys82rni8+WCM6Fmk1Q2fRpHFptmjo6yeG8J7knNsxaaeZ5Uzus7iP3aEw2iDWzgJ4szn9b9Jm9e3ZCk+hgZ5NuajLPRBJHfaXrJT1HldXdcnR9Wv2OFU6/JPu3q8ab5EdEchtIFJsQNZKVDq70RWcmtivACQ5yEj8SIZILX/GzgFrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbN99Kw28KLTgdJRwDKp5nE31cM5hJn3iX+CubO2vpI=;
 b=Srcg2jH82y77yIUqO8gyfeXiAP10LFZftsOfcVdNVGovlkrkgxop3H2MjrgIhJBmD9WJFgfZRvfYZE2FBmGlaTvwrEsdhJXnBholHXmEcE8p5fZCUh2Pye5kwVCwSlUkw/vXc7OSYizhV6TFxggQUQMWTCRldNSP5H2AB+XeAt7JIL8qlxm8/3RJbCDe1/e4CZ2NxTRLHr5LM2WOe3dPuvN4NFCU4N5qZ1gCzv04ZNu12qbGi+d4/jftpkatD8dPTP2QeTcOi9GtIXxT14KFZA/XMYP8pOq9btQDlm++gnb5Y41iUlY+NHayR3HAPCg47WNzZSyiGNZpcgZthd274g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbN99Kw28KLTgdJRwDKp5nE31cM5hJn3iX+CubO2vpI=;
 b=Dx7Q6NObWWL+19XxMuke84j0anCuuIQeDcwb24B67AV7+T37rMsliYZ/5Lna6rFgoWHBKh7E36RPJli7eZd5mqC0AY/Sx40Bya6lQo3tY/kwQtHcAUxH+n/F7ooCrFsq0mFdWq/Hb2+9D958B4AOZ9QJjfqbrlLvEKW6IjG6GFk21ZFZrPTp2DSoRRdpxcX7SbaVsOz+Smp/1IcQTwtMCwg3nfTjdcmuB/Jtfeah9eXJXliCG8+0jREc9VEiPT9cO9PXRId/TSt+QFwjXGURPeMBDL5ThYV328SNzSpP7j1iv1doifqzLSPGn5P664xQqcLVeEm5Lmx7ndi+fQwuxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 18:55:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 18:55:06 +0000
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
Subject: [PATCH v3 1/3] arm64: dts: imx93-11x11-evk: add io-expander adi,adp5585-01
Date: Tue,  3 Sep 2024 14:54:47 -0400
Message-Id: <20240903185450.1486505-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c89851ab-efc1-466c-8aae-08dccc49ed0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nD5CvirncQt+dIYJNIckqC+Up/EIw2dBZCafjsmYE9w6+zoGl0X2Ms4BXbCH?=
 =?us-ascii?Q?jcnXJS8/8eRJUFk80SUvuUSFi35vU3I+srdlYseP3MSwta9zfqFxoFdatT+P?=
 =?us-ascii?Q?diHkJI7Ifq6Ga0hfqlfb2KqHhct2Fpgz+zJ8vxVnn4/G4Sc2N1X9UR59oxVG?=
 =?us-ascii?Q?5SWAwQYzz09oL5+7s43V4RsVmlxobzxe/lmtdo6Da6piFZJo7WUAFIb+qB7D?=
 =?us-ascii?Q?GwRp1lswvRSk1gT8yHfSyHE5STS5Q/eARZJ6NgyLJQt3oJ9eY0lLeW0AdEHf?=
 =?us-ascii?Q?hCzS1ISqsF6mo2IJwMd8Ye/b2QsOvcDT0pssxm5LkfTaLbDUlOTjyRU9u1Jf?=
 =?us-ascii?Q?sXEgGUMUkLRLh78gcmH5LJup62yQAdv4mEnskRtnbf+7ApGkUoaXXxOdxDcI?=
 =?us-ascii?Q?BxMnAJXDyH8Dr2ZCLsvbwBbocl91pfS5Dm7pjhiZk0Ohlrz11zj2P9i+s0qw?=
 =?us-ascii?Q?csiSkOCwjRX10CHGiqQM92y1aY68mZAdwRcFuROYQM9gZSJq8owGWRHnae4V?=
 =?us-ascii?Q?b1HLqaJIUAy2U8TGU4ePHjZAcWrqHe+wa8YomOiLHxN/5YihJ6qExOYQ7gP+?=
 =?us-ascii?Q?JNnIvyPximIjScVlaixpeKFW4RG5Tx088PDUv3pOTJOs1/1JHK4vBDKv4PgS?=
 =?us-ascii?Q?xRxF8J8bAashJ5b2GcOv5sv0twzNUbcT0PTdB31vHUYiaQXNX60rvbdlpAV6?=
 =?us-ascii?Q?nlib2npGi21hEcUHlgkfyg1z9m0Itxgh8d1jMEj9h230ni+LrRUHSPwxzrIQ?=
 =?us-ascii?Q?v+NeqCNZ0uABQ8l5syFpeMSDLkoCdO5DqB9suHgBUT0exaAwedLBU1abSiLH?=
 =?us-ascii?Q?tLzdT8E6+Ziqp6IrBZciO+RtZliNN80Rpbadjw7dlE4wDN0iagqHUn2GV+VC?=
 =?us-ascii?Q?sPiH9iziA9HYo6QtdPXMoATkf+P8LC2Jl6UIyz4jUjWTtd5yaRVxpLRk5ygc?=
 =?us-ascii?Q?UKsQxs76DaHiORfuR/ZMdbDQ5EDr2BC00ezLLFRed0AF46UmIa2/O3bVEDmN?=
 =?us-ascii?Q?c2wvYLe62zKBr5H2ERJbN7DVwpXVu2Ueg0dPOm2h/1ccMf6bvsiPnmOZkBvQ?=
 =?us-ascii?Q?qEVIwyE9D71MDcJSbCrCxI4+Ik/28/BqXrQKsVUrGlaqtRppOMlSiln+YweT?=
 =?us-ascii?Q?VohkRUpi65J4Vm8H2HUwVKCdP7koaFaUJFDmEcBNSj90iIUMrCSOevUC2WTt?=
 =?us-ascii?Q?06uHhUT0JZi4P57YIq+t2AAN7hkPpVCaJzFIDFFkP7Pam+q+RHRmu6Ld5U6c?=
 =?us-ascii?Q?j2lc117ft1/dhbIqGM55tIug33bFTBfbf3Yg6T3KUjPwRC8wsqVNBjonYh80?=
 =?us-ascii?Q?shCAhHigpUI2E4/umBu3Y3CTwxR/aQkHrxx6Exd6GLsee4sWSgSpNyQJzLRv?=
 =?us-ascii?Q?VzI2RW2clAIVdz8tUTKkf1h/HXFu5TEhJZzykF3eIzw4P7I56V/TTKoNgvac?=
 =?us-ascii?Q?zvNLasCfdwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDCnVMe7AMIS3A9JgAIsHc7sHpnlLkhIEUI4CGwCooLCzLD5OS5nja8Jfzhi?=
 =?us-ascii?Q?AqF8s4O7a7Q+KJuwBfhFsf5gqmqCiR7jqWL/28Y7HB1cb7hEABRjg+53iyn4?=
 =?us-ascii?Q?yydaCxTsbSXRx+1SsY7ZpoCFPps3vENA9MRyHSAlpuiet1SibXv7bQRLFmcC?=
 =?us-ascii?Q?4V9NEUyS3aVYGdqB2xCBmOpUwTZQEoxj1PqVgnzOlDMB4B1p3G+Rb2kKrVXF?=
 =?us-ascii?Q?59eQwx25E4SZqRiBcAFuEXCACm27bu2Gwp+PBVKcuGkySqMBgdoioZUL1O5H?=
 =?us-ascii?Q?236fGCn4XtxAK+uh2N9elxGPolJ8l8S6noG2TUYqM51g7AxBnxQ685Yax5Gb?=
 =?us-ascii?Q?S+y9jsEDBJf3pRvJlPOZ5aGmXaThKBhNf0ZWvU9L+2T1xzKRzuDhh2Tggaq5?=
 =?us-ascii?Q?MmpWAgwmWpxEVcUmXOJ3vLMqD+vrobrxX0q17ftBNwL8DBKX6XIVSsqwxHkX?=
 =?us-ascii?Q?KlxJ42OCRGFS3lykTsduGNIBmqF3pYOUB7A92KX57AXJJKaI+7QRKvtVyZJG?=
 =?us-ascii?Q?8Ct+EJMWZYTpBesQI7oFuPzPo6kqCS6Q6TvzBuG0tb3mbrUMwIMysik8GhPM?=
 =?us-ascii?Q?eV1FN50ospre/Lz1Ff1U7wnunnmSt9I2f1MKMOYaNwkNRKoSyhUlseQdVfNV?=
 =?us-ascii?Q?05PwCHWHvjSNtbFXiRdHr/BjktMeD2uueBWyaF6Ll3YYFoNCtpdRwWM4WlNT?=
 =?us-ascii?Q?0TQKeoGTyA2Gw9EDpThAVPTyeRm+OFYcmF2hCnFYqzdSv0BKsDL8lAjgyuI7?=
 =?us-ascii?Q?JKdMctANT4eOv63gOzr4wsKuOwNvfdwYHgrDnP+wrlT/1Ztv7S2KYWtXgrlO?=
 =?us-ascii?Q?gi9kaH7cKnfdQ+sk6VHDUFZABgtATlFJNTuYTimBY1IQr+JVBZugfJruqT2S?=
 =?us-ascii?Q?JSPPJ6/KBvL00LmgRCa8AU6OTwUlzwBa80YTWkJgVMn/7JMQHdjOtBnJ/cX3?=
 =?us-ascii?Q?UJJBIl+ed5e0XmTEjEh1JWG9Rt43puE21tBQYMnqFHuTwqE5D+MGqQYF94kw?=
 =?us-ascii?Q?EWhDSKa4K53PfRRHWqMfFJusPntBC5e+6nng7w7uNYnuiQnIeMeINikHZ1sm?=
 =?us-ascii?Q?tsV2tEv+yB4QIni1zRbpQxOMPxLpr8Y43DbbZ9nq9+kTHHQuJt0lfdD6t1Re?=
 =?us-ascii?Q?GB2/fkKj61dJBt9skAAGq0H/iaonZsJKr5oC9AYx/QLw5ZLnYebxkgyuAG2T?=
 =?us-ascii?Q?klt2adADF2d+C7fF0gFwsFXL0MheLnvt1FRDvpxBN83SNJQ796uv9KmsmFDW?=
 =?us-ascii?Q?p2I8fwPS5cn0tTPsNvmqg5jTTblZtBPm/jJdYjYiXIOgVimZmSfqKACtR00C?=
 =?us-ascii?Q?02gwbDSL+Fv4PaBrHRpLt25nHIU7TsGRRhliWlsG9o+H2Gx3vASV3zlFcjfJ?=
 =?us-ascii?Q?YHHj4Dp83EwAk70NycDRIh0Cp5+9f15xWpy3EUYkDZ9n53lHEOmrtalav0Zw?=
 =?us-ascii?Q?9ux1tUApdI1bTkoP9wKTqncV1Feh70cpeh9anv3XS/4gXJ4GnD5a2AtyCDvO?=
 =?us-ascii?Q?qnJnmJDsJ8aB+pXXoMlUjVPZxsmWQa/qkJegyezNCekxDvWWIhrJcWV6Vjf9?=
 =?us-ascii?Q?NKx9cQKa7b/npbAnLYQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89851ab-efc1-466c-8aae-08dccc49ed0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 18:55:06.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0M/GKu5lIuhvA3aOQ9vZOR2p/aXUcV4RlBaS7hPjaqX+TAnHWwUfCbXeGhF9lUoFvnu3M1AIhRc1gpbGdlwOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300

Add io-expander adi,adp5585 under lpi2c3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- rebase to guoshawn/imx/dt64 because conflict under lpi2c2
- adp5585 uner lpi2c2 already in imx/dt64 tree.
Change from v1 to v2
- none
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 8d036b3962e9d..94a400ccd1a2c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -340,6 +340,14 @@ &lpi2c3 {
 	pinctrl-0 = <&pinctrl_lpi2c3>;
 	status = "okay";
 
+	adp5585_isp: io-expander@34 {
+		compatible = "adi,adp5585-01", "adi,adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		#pwm-cells = <3>;
+	};
+
 	ptn5110: tcpc@50 {
 		compatible = "nxp,ptn5110", "tcpci";
 		reg = <0x50>;
-- 
2.34.1


