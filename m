Return-Path: <linux-kernel+bounces-231467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9935F919912
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D59E2848A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795CF194AD4;
	Wed, 26 Jun 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yw27exrc"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A53194A67;
	Wed, 26 Jun 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433585; cv=fail; b=P9HaDvAc06ic5MBDs2/ZoyrCJen6ODa5BDRuT/t4QfXokSfwTeHDkrG0YAH4oQ3rWjDZSlNsqAuGP1PjiSJq0ic/0A+fXFU+q/Og1e+WFvClmQDuvFxesCSHN4e5axhuIrTdrmnGeCIHcTnuxKMiT4dGlTzzqylQftmIkjrm0d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433585; c=relaxed/simple;
	bh=mANdJ+oDlzVJby+0y5yYibHfqVNSbsz8+1vyjVsc0AI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oa1Fk9OHUp4aqp62viLZQmPZ2c5H0VIAoTWa+4pIAPi+6SL8KMHnT/9t5uPNkBOLJjvhApcQLrwOz5by7CfaashJu8RRHJcjkHe+mgn8nqDeSaTMrdYRTr4yDkbrtrdE8TYnmeWvww389aKROHkOKgtuQIsJSYBQw1s94MgAJLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yw27exrc; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eplMTfZxK5gq8/Zt2ASHoCIz7mwbasdkrBFHOvYw2jLs3COZJmBdDWfBWSF3b7cHnwCHOe49wcE0cDyFg6/PJ58I+mR/TaL6cQJk8msAvJuA/8+k/GerjkSQ3KFiz54IE4dYpY6sZXz8UpMKWPHlxqjoo+db+Nipu1qRYx0CNHDYKimBOD2BZq6hJPNt+tqusI5RnJ90mCB7ebfMBPLO5p4wR+g+mFg08eYaCe/RyW7HGMjNMaL/fX52/v4p2NphibGnhyUGxQEwjQMt4AnCJM74Q4+MUu91wc8Ju0lLVBmMWLwUi09DJ5t7vSrGaYsXtliXKOHvJo+OVlcMUft7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lSTONLDCKW+Nre5WsKxTNuQSv0898T08xbyntmfqV4=;
 b=hVpyMqKnmnVFAb/vZdDwty8GXmWgQqARZMDCTJJk4HqHtdDmK65vFsL1xSOGRifJzije9z8ykXrPNG5iM0DPUUdmKGAKu6gVtNj5lmLtx8Svr+HTXMNWt1LAiRgnp1VIvGUcqEx9iEhOeE4lZSB3C2AgtNJ/JqjD6V63r7PQTr2ZqTzzbe0iSBudtJcQmtNuXgV6bTq6R0yimv7QXil0FCRl4mfrUlERTe4geP8qrEBskcEklFS8XY5HfxGfdrbmVZpsDHtczSLYSRCo+ju/ufSqOxXOIBZgyQbozq9u7UpVrLtT8dhKumGprUpYUxoLZwuE0h3blpTYatY8CA2eEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lSTONLDCKW+Nre5WsKxTNuQSv0898T08xbyntmfqV4=;
 b=Yw27exrcy5XuwnlO2hsS75lJBnU6BjXqXVvOZyzOg9DMvU3MlhG2qb57pkDNxCVLdqLonn5Qki2mCABAbl2phO51wvHL9jjpLyiq7niETYeWmmDHXHFmEwXIrf1yXOPoRf95nu0/vdXJx8nCrF7Bu37zSVhuXrzXzZg7ru21Fec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 11/13] arm64: dts: fsl-ls1043a: remove unused clk-name at watchdog node
Date: Wed, 26 Jun 2024 16:25:31 -0400
Message-Id: <20240626202533.2182846-12-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bf3fea90-26b9-41c2-e5bb-08dc961e3df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T4GSsIlftyoL7/7jS6pwjgx898Mtr/PVLHRYITeeKIQDnWFyL7oy0oZ+mgGy?=
 =?us-ascii?Q?D1f66LppNi8gFn0E2fc72CRLaj0v7wtGNMz+F3TmYbY0KVzjehYMJm71lbEj?=
 =?us-ascii?Q?F9KtAGAjQL3QC3dyLApmMLcgdHm4PcmkuCLMWUTWPcq4pKJR8OyHhjWPWdDj?=
 =?us-ascii?Q?MniKpnq9QXDRZpOyDR8TedzvGAxl/V7h+FIFewd/18e8xtbONSgms0dV0Qvc?=
 =?us-ascii?Q?0nekNpCy8dgwBRGMmmDc69Dvv6a5lo1MGCTWD0qStn7L/b6RPQyF4MtvCBA4?=
 =?us-ascii?Q?iM87ew/FNSSCX3B1N+z1qHLxdZXDYQDbcF0NOBm+IhMjfS1c3oHAs7u4/vNA?=
 =?us-ascii?Q?Yqm+bTEwCbpESVwxRsCv5fD8e0oTm5jyHLsKlSvyr0+CCNqXxVLTDPnGTQJi?=
 =?us-ascii?Q?CmTRR04+Ef9i2Xj/D1hGJgzuynCRD+0w05mQmsN1GnfwBY/gb6NLiS4otJZc?=
 =?us-ascii?Q?Q+0qXISiy2TQejHBtZU7oZtn0veRCxN5eL5r3txrZoRvmkUL4abOrqXp37pW?=
 =?us-ascii?Q?ePvP4vOquB8TkTvEXkkh7dFPSGkpWEcvvvK/fHHv9TxvcdcJymnofRG0Vgv1?=
 =?us-ascii?Q?JQV6lo6bW9esT1VG1PjMgLArb8q0OM/4My84XATGDJ9HaXME6Yi52OSpn2td?=
 =?us-ascii?Q?/BHq+HTvtM1f1irznnL+UHW2eD9/J7rUCXnKvPuVDeziA7iH/19YdSIQdAnF?=
 =?us-ascii?Q?EVIQwtQ5bl4dUPNd4oe2vr1JILSowZf32yGHPrOCC56CS32rpiPAmLjMR6si?=
 =?us-ascii?Q?prZAL8Kk5mQsSNbM7kUN+Cib3cDNJ1Ks0EuEZ8lT2aO3ETHsWVGZ+7gzma/l?=
 =?us-ascii?Q?dIcFThysCpRJA6jOV5LeZB4yN/+pgOp084o1PGOBN0lH54wkN/QN1DSVAoC6?=
 =?us-ascii?Q?aDEjtGwlef+AmrIMisXJ08IXyDBlpr9VhbWZDdrYjn2o25aTXsgMFq9LT3zO?=
 =?us-ascii?Q?FgM6uoEQSavUaf0rXNwEtQoyWSJsPHE9SwH3ZM1Twt981L3xCC2HiRlwN/q8?=
 =?us-ascii?Q?cQcs+Tw3rrhClnFkj1JjBol02zSus30oDNCO5olPrjLZ67a0sjK4grG8Wcv6?=
 =?us-ascii?Q?SeEwb7bhokRRN27KMNFPnVoF9L17uigTeljtJn357ygdXC6gkMkPpV4/T3ek?=
 =?us-ascii?Q?j9s4PPypVzps2pGelYKkOnGIhaUMmtUzA6jX4vFqSqoKyJb/2XOErLfx1SlO?=
 =?us-ascii?Q?u3qf59++JuwGG0aPKMeRJApnODa6js8aR3J4bx9E060LvE1U7kEd8Y8V4hTc?=
 =?us-ascii?Q?YncVZiAeW4D7RYAmLl2l+Az0eDz9krItClNw1baeq1O4+3gYlR41GHBv9mJ2?=
 =?us-ascii?Q?w3YzA/VjjaPfVwm64S/eZ2wM2qeZmTIZG69OK7OeCmpfLd5q+Gt+o0Z9mFIt?=
 =?us-ascii?Q?+m+x//o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gfqbJbhZdMWbOkSpiymp3CPTDQl0s0GwdtR/LkAgYoI/WPzTLm5itJ8XtURl?=
 =?us-ascii?Q?c4MOURPDXJiGr2YB/siMvlWb1E++czB5+Sjo2N97c2kFomHRovKA3UMSOIdE?=
 =?us-ascii?Q?8rgYvuv6UE4WEzBxzmJJq2JdUYnA0u7A9tSeBEeTZw+9fWW+fgtx9C2geAzn?=
 =?us-ascii?Q?FMuqbJYWBP4oyN5gKU8xwvFb00VI+IIgQfQ4U0mEpeu5irEgcMsWAGIg98re?=
 =?us-ascii?Q?w5YhioM42qEAtmb+zsQR0e2P1rHqkJvJR0+RqLvTjCMw1HQuUcXvgDqPXwJy?=
 =?us-ascii?Q?ZhtBK2tcTvL7vXJlmcKELDovpY2l4hPtCRMaQjzpJgiJRqFfzWKOjp2dhICb?=
 =?us-ascii?Q?4BHxuH+wAiWiPIa1V9sEdxjV2RyoDh3MkOXkonQGJd/nPrM0vR/lBu1HJDVO?=
 =?us-ascii?Q?Zv/1vZ6kk93BITS+sB48Oi0XciBmZrcvhsPmIZAgIIfpuqqKh56Wu+j7g/lW?=
 =?us-ascii?Q?YkFu6Vz1tcpl6f61xZWpyvu/tN4vEV01vfXOuLPOhqD0mshSfYhA/toKK2Q9?=
 =?us-ascii?Q?LkvT2O1Ii3rIQ1fMKRPvcpQixDJrk7/qi5MPwjWMoVmTRs43YARRp/AB9zJf?=
 =?us-ascii?Q?db2LASojZg++eh0JcXXPYuPryL9VkJZm7uXnUxawWzrgkcH82cMsTfLH5GI+?=
 =?us-ascii?Q?Zql5+014stp5lVO6holyPoqYJpIPGIMdp/R8ufErk6I+4guGTNJJXn/6b1Wu?=
 =?us-ascii?Q?rbgOBBQy8ZqNtZOpg7BnBmmjAvWPCppl0jea8u87WorjIxpmCJ+jPLmCC/fh?=
 =?us-ascii?Q?Up224mIhe0GXP1ag8uWLYujJGbtr1zUoqz2FUUfw+zep/izGerKOk9Py1SxY?=
 =?us-ascii?Q?TRnS6uW7vyZT5KXMpMDaFFwlWXl0wSvV9MVdqvdbb48bwzG/iI9MujHNGxro?=
 =?us-ascii?Q?t4aLSyx/xbxo5QCU8s3AJSSHF2de99wDplxtAbFJG4YfCh5ZygDHUZzV9JAo?=
 =?us-ascii?Q?2PdpNoAP1N16USF07wTwfvemaEw+Uz/d3EVRXnZCfXIoNZpDZh6XCFNo2Df/?=
 =?us-ascii?Q?pprnudmETV5elF5hUdkKYIgai87IlCZw/Uke0+DkUqf8i4Vwr8MRA1mQC+Ht?=
 =?us-ascii?Q?Hc7qjm6lQlKZEbQS0E/Gxw3E2bJZnT1s6xWsHAFaD4wD11DG1bRmMdUugX1s?=
 =?us-ascii?Q?qtkYeUVGd3LFpCdjxkYKBw7cRyu1/1J58lTD7EcQMzy0fxBy+PE+ii0mVvHY?=
 =?us-ascii?Q?68K4ibIDAc5t41tD0WZCkH0zs0DQ4HHUWuf4eIqpxJ5r8sODApDQEtyq1vsE?=
 =?us-ascii?Q?k9noKsqyTHj/xqMVwnv/O0UZ2I2jSOk4WDVUYlat1GIEz6Uf6pc2GQSnqDaG?=
 =?us-ascii?Q?7ixI3o3TV+vjYxM9hadglnPPLgZZ8uduJ4WejJHmBMQLD1f5fR4yPFQqLTpx?=
 =?us-ascii?Q?B+sKLQ7Cm9cLaaH1s9owKRnIdqQaCsxzhJkB/frjCZ1WQKJetAiv1hBnvKCi?=
 =?us-ascii?Q?z7aoLJB2gjSkvOBhazbotXlwiGTcmrqF1oDzuh21b44D1ZccT77cOFpiIWEH?=
 =?us-ascii?Q?bh/eoarkufFT587dv3bclMBqoM6YFUVt0+Gyj1s81Pu56MRBZuByEFy9tEnZ?=
 =?us-ascii?Q?vGKp9coP7D+G+LSPU1o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3fea90-26b9-41c2-e5bb-08dc961e3df8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:21.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LundQt4msiX5GEp61Zeu0Iym6hrqsmNVYPTMzuvnxT/rHPRYoAqhjKDirHBupf/B3E+ObYlti6yQ051ZfS8h0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

clk-name is undocument property and never used in watchdog driver. Remove
it and fix below CHECK_DTB warning.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: watchdog@2ad0000: Unevaluated properties are not allowed ('big-endian', 'clock-names' were unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 364eeeab089bb..bfb5841456d76 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -783,7 +783,6 @@ wdog0: watchdog@2ad0000 {
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(1)>;
-			clock-names = "wdog";
 			big-endian;
 		};
 
-- 
2.34.1


