Return-Path: <linux-kernel+bounces-412411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD599D08C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE41F21A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CB813D24E;
	Mon, 18 Nov 2024 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJMBKilM"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63C13D61B;
	Mon, 18 Nov 2024 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907193; cv=fail; b=C6FWlByLvGhkGvopWoTbT8fRJK7WQsz3k3UIWHpsl63kkkW6FB7jM9cOShQvqHzDy7SflvWgfK79vLx/3axnEbu61Pma662fgPF1PdMMPthqw1yRCm1fiJHwVg57GKcKoXZKOOT5iXIR3IfgiMjdVoBfOfauRaA/Uz+/wSCMp/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907193; c=relaxed/simple;
	bh=lNgXrEProp0J4KwmXbrngH6oQbvF0YUxPjv9HUOFOxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BYZ5BJlxFSL0h6HdxNz5saedAE6vVVJW66VlIsHDXq9OH0NUjg2ecceVnNzdgl5vktyiFvZFk4zJ4VQ/v5NdH4KcvxyzNUT18FmJb4O7zdczeSfNXbu5RKBJoD8PRuJDmuJf2JnWgHvkm1/9e2SAA9tDEgZqzMLJZagOIpbTaz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJMBKilM; arc=fail smtp.client-ip=40.107.103.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eH+drat+wFYYypWf0Z9i2dFX7/Gl/0SXD4dDcNk5kM5EnHCQ3igtPPX8DIG+p652IMNGRlWU8vzTphT88MTn+l3eTeThUTBGFDKrS3+eh/qceSrukEyp+psmRQ0eK6vMTeIbLOCA6SzkixNtU8mHOcZbyTx1xMi6vKoxzcvUptF9tfCMAMU3uw9f6QrZPLO1/xQeoPGDxM3WlEIQw3aCALJ3lUl35FzL7KR2AUOHbCbqoes5e5nB0WjaDfhLilu2ARC2O6nsyGyFhZACenX4ppyrLGoJsxrXNvjSy9Ctzn71FTRBQH19r8JiMtUn5yBLy6AvYOeCaOytdaheD2IKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0paocb2QbWiJ+dTP9t4zb8rLwhjN9RhLT5y5XJGZSkQ=;
 b=iHHd9Um+MquaTqdM1+ahBUGYTtJ+/LTrHODAGXzEfDYilEYFo//ducN/zaX8BhZaPTQDiF3FuCMSO4ioS/YRt3MQU/LG+aLpxHh9oBhDY1/SYeF/RsptbUvwovly1PQK/3rMjd1BRIrbKABsQsGcMfP3ATYDC/Yib1hQb3oLQAkXah7SXesQBU9p3W7WeI3qWpYaLrYyALPtFp1UaSHZvSMG5VLysr2pzpFZPf8nXppJYdb0FtGW8N2wplzla9Cni/Cr57nO0uzsUOXAVYxf0bYm18Kr0eFlh1sPpy0mg8o2I42E24D9ATKr9kul2817PZkhqc7SbkNuVhQhr+L5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0paocb2QbWiJ+dTP9t4zb8rLwhjN9RhLT5y5XJGZSkQ=;
 b=DJMBKilMr7sUBkylRTiwRnL6bpaLG4eCEbJMWjOHF3MKNp2RoWlt6jUOVIvwu2lPf4F6FXPKxJueNiL/F/MT7zdlMlqOovaawdss7+lx8yCdWRUH1RqQoJt/o87TptgqlwxKNYehQEoHOUyZesA4DrCx8x+FnVBDGBu4Ddjeova8/IMWjXuuV9lGSdblROdbvnYH4GG8qHG0yYIfvCKJ4Br/f+0tt8JmuYEyR8O7YvD6VvqSPvp9WxN1/CWnNbeGf84kV5YoENX6idYuLCR6aNkzGR5IDIfdfMwm6Xq47BVdCHUrqNgiyI5pCNEfDt2/sxojM3W7DkV/5gVJlIHgNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com (2603:10a6:208:195::24)
 by AM9PR04MB7508.eurprd04.prod.outlook.com (2603:10a6:20b:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 05:19:47 +0000
Received: from AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5]) by AM0PR04MB7058.eurprd04.prod.outlook.com
 ([fe80::d7ed:56bd:30e4:4ed5%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:19:47 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: francesco.dolcini@toradex.com,
	joao.goncalves@toradex.com,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	peng.fan@nxp.com,
	hiago.franco@toradex.com,
	frieder.schrempf@kontron.de,
	alexander.stein@ew.tq-group.com,
	mwalle@kernel.org,
	m.othacehe@gmail.com,
	Max.Merchel@ew.tq-group.com,
	tharvey@gateworks.com,
	quic_bjorande@quicinc.com,
	geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org,
	konradybcio@kernel.org,
	neil.armstrong@linaro.org,
	arnd@arndb.de,
	nfraprado@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: [PATCH v2 3/4] arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
Date: Mon, 18 Nov 2024 13:15:40 +0800
Message-Id: <20241118051541.2621360-4-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
References: <20241118051541.2621360-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM0PR04MB7058.eurprd04.prod.outlook.com
 (2603:10a6:208:195::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7058:EE_|AM9PR04MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ea0fbf-651d-4fda-4869-08dd07909eb4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?3x7bVFVVcjAIGpb7O9o0lO/1x6aj06zo3AMZ/pLhZ1jLxxkE/SxWCADWibJ5?=
 =?us-ascii?Q?R/RH4XtlJmrHWKWraCSzkseIb/cDsArr9KtkJNAoqI7O0Kudpk/YKrH1O+fr?=
 =?us-ascii?Q?dc7Ljk0QbRlyRHp/wEqSGCQ8YpznqLeSCZhW+fFk8heQrjNI2lKAMpBeT+ao?=
 =?us-ascii?Q?2LX/ZUIfm883bN3quI4Quga9+AoZnNxEpxpdWsmyeU3lUOVtxGXfLnyxLdGM?=
 =?us-ascii?Q?tla8/NSqBhRPTNMKDkJxf5ikt4BAfhDgoIh1WutcZKiNt7BayCmsDC5Ssx6A?=
 =?us-ascii?Q?yblt0z41O9Lb+Mq/ccDOqO+Qdma2mpCDaPSUA4jvRaLlTmIbfu/E1gsilJx2?=
 =?us-ascii?Q?6Kc4KqR37pR9XVbCd6AgwUZhvcrWoAKGx9AmFogHyKYt+GprvrsKIpG8/nFW?=
 =?us-ascii?Q?Z0NDBtMD04cixuzelzSsjM0y2enMxozz2NZBXdOVnpDHXC2B5d64QfRTd/ey?=
 =?us-ascii?Q?jQkxwTib7eajtl7/LjEf9xHsMgc5/tS6HOsr4++G04TveoA6llMrXTr9YIG5?=
 =?us-ascii?Q?+HDg5w6UfzLSQBHKyUEKS1vNN8UUVy04mNg3gQhDwKA6TDHmv3f6PBGjQPNF?=
 =?us-ascii?Q?ByTyJyXJDPyhRJcRnPHZyJmgGMysqzFamVP0CIJAMofy7GFPJUi2OlzafcIy?=
 =?us-ascii?Q?HLHP9iOJOjKA1yZ6n9b6dV8U4WbWj65rQdfk7VioUZHwY24MyHiM3DjrEULH?=
 =?us-ascii?Q?fGoorFNpSZ7Qf8idM2cfWb1dY9D28rY2mAlS9kWBB1nXDeK8QyZIOhvBx8is?=
 =?us-ascii?Q?vYQRZnI7WJWpHsSh5fOx7ns87lnFqMXDiTbFVk387xmfym+my+tC8ZrAlFwp?=
 =?us-ascii?Q?iDHZa4zJJ845pJtEPC5FVZGg+BAK4TAr2v6JyLjfdUd5S4NUH1Y7HcA8xCAv?=
 =?us-ascii?Q?f65jGM1aNsZJnd2Vxv7/TgIK13I3LlReIXbSxvVJFMG6oalZwm2so+M85dhx?=
 =?us-ascii?Q?Z/wiyyiFo70y2DNSCZ0smmfg7b2vH1uXL+O8rLQy/KPS75h3dCqR8xscB8Wd?=
 =?us-ascii?Q?A09tU6nfI/rrz4q4/9WAryZSOP3QbsyttgB223hO2EQxLTOII/kbepNX3sWr?=
 =?us-ascii?Q?8HBHf98aJJDKr1u7/iRSqU0lR/kcDPRyEqplkVrBxtYq9tZpbWK4TraCwbkA?=
 =?us-ascii?Q?B7OX2TWfHocLPNUzu4TetN+MAinwMcu9segCqX2cHA2tPXCTEOeiadlKrbp3?=
 =?us-ascii?Q?t9fpeeBWgRlSiWtxsm7hVGkdXm0+sFZftFDIV1w7l9DwiGBQJQDQ7PYK+0jk?=
 =?us-ascii?Q?WecKsuew5H8myo/9a+qQr8KLYg+431OV+dpjV9AkQW9+0rx21OmtSO9qWWGs?=
 =?us-ascii?Q?0s05nMEKmJBQ+SbLThEODSqtc8SsmE0V0lPI9lwjItijb5musm/U3kgLNTOL?=
 =?us-ascii?Q?5GwELVI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7058.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?ZyRTIy5KJ5nuJMGrJgirIZozhf4YncIDpZWycgyLb2lnIT0Wk3Bh0dq343o6?=
 =?us-ascii?Q?S+vayHrpihmf1D7DHxk2QBtCm/pybP01T/M/xb5LyRD8ZImO7UfKO+vneKGz?=
 =?us-ascii?Q?bGt53LFlIDYH8ygoFCOuKLOLfSQxdvx9oqY7+pCsqCFIv5QH6FY6EJ88J3Y1?=
 =?us-ascii?Q?YL4I79nL4SCiYgnL+4Z/FrNjckboqvx1QS/MMmsto22bcJNm6jxjpVU4qB/O?=
 =?us-ascii?Q?PyYiRS4MdnQL9SqQU2o6G/AQ2X6qT/OtF12w/OR5FLexjmXknw3/jC/G1O5J?=
 =?us-ascii?Q?8/EFmEuEqF3fx9auiPqv0z1vUvfxTc+iSopXLihqvUDHTALygPCnpTCKpWEP?=
 =?us-ascii?Q?YQAbcSAVxSCzkrPNBVvRMxudpfM8JrR2i34zRiOZ6ST5Gy2dJnxSnOH8FOIG?=
 =?us-ascii?Q?S0Z1koBuNqCHWil5nvEVbQFoxS4HFeltVQEZY7ZiFq7Itqt9ETRakh1JnrNN?=
 =?us-ascii?Q?zcCMQudNzHXbBgIMuPcfikWCuAG8c011B+OjxBYG4GF2jt+uzHMpn4uChCSw?=
 =?us-ascii?Q?5KIMB6xYHv1tPRifZkdtI3QNsac++Fx3cIzPN0i9qVntreOeV3IZxwvQBpwY?=
 =?us-ascii?Q?nEywm/aKR7DuoU2gg0K4xl9DY4ds5zPcpjCkQxQxWM2OCOWhW8yEfolbgjsM?=
 =?us-ascii?Q?00B7ni/vgNIiWh8C3HKkyke+76hl8wDRh79rFoNEe5LyVu2DnVaHpxNfdRMD?=
 =?us-ascii?Q?sByyLhP1LvRw9DkWdVmG9IzOM6Y/76kIjt7kqReS71c3nQ3XnYI/UhGwSdKj?=
 =?us-ascii?Q?Kq2tLuegC4LnI2klAuSTzWblcIVavh1/+KmwBjAVxsnIBlcorL69EBy5AWUv?=
 =?us-ascii?Q?APeHYCBIsvwOk1AVOO7oSPMhNVzbrMnBSQgLeoTPhRhLV735UPs8tLCUEtEp?=
 =?us-ascii?Q?28iveM6/nD8r2HDX6XhJbjvogBL6SSqLlWgaU1Mv3oOXKUJ8XQSOykwS2/bb?=
 =?us-ascii?Q?+OfeLFoaBfN447GgxI/n5mX8eD6JYCmK71IbXHQtfFphRdQhfl2tJ02FBSJn?=
 =?us-ascii?Q?LyhAecgRQZUgiPqGj/880kGeNgHOTvRNOf/uvautjbj82HfheOTC9WjZypiX?=
 =?us-ascii?Q?P88rBpFQjYm1g6/HVt0y1Qo4z3C8AG+q9o8hDkYozLm/i8SS3HjenRZsCPXV?=
 =?us-ascii?Q?yebiolDOreE7ZTgT+Rq8jwdPWKMshN8ga4qRROn+WrsA1vsI8VZQhNQI9ab2?=
 =?us-ascii?Q?l8x4ZpoIORwoLMCDJ5QxrZW6sHduQYwxJ7meuZtGdzNHNDMg7Cxih6UvPN9e?=
 =?us-ascii?Q?6MHlNt5vAje7Obmtxhmi5/0hd5mK7QLmDkqagT1f9/Vey+XMc7VrN/NMrHTG?=
 =?us-ascii?Q?DHW8DNriigXflyzYZYavzX55o4dtnyqNzyqE7aYi36hIAZSHG/X3fb93jWJ9?=
 =?us-ascii?Q?Qu5/b/yIZ4PaMGU1I76PDtAoQN5nyAT36FRZokOIq5+W8KFkp977AcVZkjEE?=
 =?us-ascii?Q?5A8RUQkbDaBckh1WNCivshP2WTjYfC1cdWZln0ZoiwztM6n6lBSZ7pJYasUa?=
 =?us-ascii?Q?44z5C7ADW3JJzDpJd8rNM9VX4az5LdPQq3KUmg17i08zKOADoRMrLfZZuWuq?=
 =?us-ascii?Q?tn29D/Z9B/Cie7aBKNvjK6NGJ0RUPed7QgLkbjMu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ea0fbf-651d-4fda-4869-08dd07909eb4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7058.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:19:47.8766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l30+8jreH4J/Gvb4rKgRdj0gWwHahIVMkLj5zUFn0vviE2jddWPv2IQM7WXFQT50THyQS8JvZ5CXvGUwAADx4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7508

Add i.MX91 11x11 EVK board support.
- Enable ADC1.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable Watchdog3.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 812 ++++++++++++++++++
 2 files changed, 813 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 42e6482a31cb..9174c9e215d5 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -256,6 +256,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-iris-v2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
 imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
new file mode 100644
index 000000000000..309bca672ac2
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -0,0 +1,812 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx91.dtsi"
+
+/ {
+	model = "NXP i.MX91 11X11 EVK board";
+	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		rtc0 = &bbnsm_rtc;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
+		enable-active-high;
+	};
+
+	reg_vdd_12v: regulator-vdd-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_vdd_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_vrpi_3v3: regulator-vrpi-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VRPI_3V3";
+		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		vin-supply = <&buck4>;
+	};
+
+	reg_vrpi_5v: regulator-vrpi-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VRPI_5V";
+		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+
+	reg_usdhc3_vmmc: regulator-usdhc3 {
+		compatible = "regulator-fixed";
+		regulator-name = "WLAN_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		/*
+		 * IW612 wifi chip needs more delay than other wifi chips to complete
+		 * the host interface initialization after power up, otherwise the
+		 * internal state of IW612 may be unstable, resulting in the failure of
+		 * the SDIO3.0 switch voltage.
+		 */
+		startup-delay-us = <20000>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			eee-broken-1000t;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy2>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			eee-broken-1000t;
+		};
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+			compatible = "nxp,pcf2131";
+			reg = <0x53>;
+			interrupt-parent = <&pcal6524>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+			status = "okay";
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-sdio;
+	no-mmc;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
+			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
+			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
+			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
+			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
+			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
+			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
+			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
+			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
+			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
+			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
+			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
+			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
+			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
+			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
+			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
+			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
+			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
+			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
+			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX91_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
+			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
+			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
+		>;
+	};
+
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
+			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
+			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
+			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
+			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
+			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
+			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
+			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
+			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
+			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
+			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
+			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
+			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
+			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
+			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
+			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
+			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
+			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
+			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
+			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
+			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
+			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
+			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
+		>;
+	};
+
+	pinctrl_lcdif_gpio: lcdifgpiogrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
+			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
+			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
+			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
+			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
+			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
+			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
+			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
+			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
+			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
+			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
+			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
+			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
+			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
+			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
+		>;
+	};
+
+	pinctrl_usdhc3_wlan: usdhc3wlangrp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
+			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
+			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
+			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
+		>;
+	};
+
+	pinctrl_sai1_sleep: sai1sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
+			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
+			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
+			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
+			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
+			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
+			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
+			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
+		>;
+	};
+
+	pinctrl_sai3_sleep: sai3sleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
+			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
+			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
+			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
+			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
+		>;
+	};
+
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
+			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
+			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
+		>;
+	};
+
+	pinctrl_pdm_sleep: pdmsleepgrp {
+		fsl,pins = <
+			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
+			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
+			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
+		>;
+	};
+
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
+			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
+		>;
+	};
+
+	pinctrl_spdif_sleep: spdifsleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
+			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
+		>;
+	};
+};
-- 
2.34.1


