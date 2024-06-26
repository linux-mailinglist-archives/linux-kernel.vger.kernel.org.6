Return-Path: <linux-kernel+bounces-231471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1E91991B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4771C224C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB87193093;
	Wed, 26 Jun 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rvk/mLDr"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3719306D;
	Wed, 26 Jun 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433706; cv=fail; b=d2V7Uz7SvsGvEZiO4UWRa4UmQCMoaDkf2O29GYiGHEw93l8mCwfJIAcVE5ou5aoP0Qww72MTzWuLf/b37vk/T+Ws/vIGv5QDdyu6AaNwBApTMQEsgPHV37aNofY3T0ptFcTy5rGTKpYIh7HcG7ImtedkKb4OfF7S2w3k+9eAc4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433706; c=relaxed/simple;
	bh=7vw1fDQuLMjpVY5u/eA7wRoq/i5GIlJ8PWBDbwfN+zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2csjWVJDrhPVQDBkx+/fPR5YqPQWA1QXX2noI5SVc0BnADDlHfU2Vdned/V7oDNq1LpD0q0gSzmEd290DHoTydc73l0oh3MY1RckM6/VEgMIT9XJKi5xBZyh5UGPx33VGqlx97dKhQosJmQtlowfEhOziyGlZDt7mFxmMhlcho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rvk/mLDr; arc=fail smtp.client-ip=40.107.241.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmuuzQ1FgsdSZbn0Tx3kX/NivfcLxWn4vmIv2+jYh2+a4opF3W/HhmkP/lHSxHscYQZ0NUex6Eb2gzMCoYd6J8h/UChGeyPiaRenbs/GJp6J6LFmt1eB2vGpkYQCe3epY6NqC5RXRVudeP3TNnOXcMf4sbJTKnBgT34sx+DtoKV0c6Tt4IhGIX58RotQVfonoB1tsnfDjqxCgpdncov4RCWO+oiTwZTbr74ybdxqntZENCFh2rEwjp+Ey0iEviWFh7Zm9sgFqAEZZRC7JoRjls6xo5ndeuz4v5EcgITImxWraLpLZB7+VIQUPsBM3k1xW1Ps2rVj5lFRUIV+o9fMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vKVg0WGFlrUhau0rluxQqabf91OBRZdHdSX6r0MQO8=;
 b=Q42VVWnfApO5XNvtffyBSX0RTGWqIMsbwjDZAkNKc3cb7xK6VijWUwhIGu3U+ddrA+xwWnj1coGdnGumh0lUWsf1a9qZFifIpQ0w5vRyMsDfCRu9WQa1KJ7JuFrwYJsn/OB/9vej4InKf2w4GkNYaUlDzzwWLSmPZZiJdQj5oiwpYrg5jwz5sE3Xsehb9mPq4/WW+sVnb/7ykznRmqEJ2VsPU2fWUd3YofPnAUkjjmMTJS8mH2CrlF4cx+cyeAJrXUdZHfguoFLOHVmvbSvUpVqnSsFuVFglqGj+uXdZUIASS4+ClC3uL8N1nddHjitOB0lsnRXGBA5rMQNbQrdcrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vKVg0WGFlrUhau0rluxQqabf91OBRZdHdSX6r0MQO8=;
 b=rvk/mLDrAP5kIDwZFHiTW5oOC4wFtc0BaaojTxIXzeEfaCPyqJry3uNaj6J9j2NP1APOf1F1oFRgc8ELJ7rY9zSxL1YPsCgXxnMMuODM/Pr6J62yqRD0AS7G6zvP39MuLblXfg4ogtkg2jdjWvf9XmYT9AiW7SxQSW9+vJXGCDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:28:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:28:21 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	shawnguo@kernel.org
Subject: [PATCH v2 00/13] arm64: dts: layerscaple: clean up some simple CHECK_WARNING
Date: Wed, 26 Jun 2024 16:28:09 -0400
Message-Id: <20240626202809.2187404-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626202533.2182846-2-Frank.Li@nxp.com>
References: <20240626202533.2182846-2-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8d41ee-6d1d-4665-e7b8-08dc961e8595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4NFTSnTeVOKq7+ZFL09UttgLIk/YU9gXamAp0rEeEGcdse6GDqeTCeMCKYOK?=
 =?us-ascii?Q?rNvBtnMRcT1+9rObzGzo/UFa21Mme4qYuDTn6fiosF9eOqQ5mcDJHkREtgH4?=
 =?us-ascii?Q?DbcgTULY8+xyBinPicJQSyE+gL+mBOp6zvE5RZFQ6UZEQtnlK8faqNlJc9CP?=
 =?us-ascii?Q?RmvXMRoVhOeI/XUzhR1nQRQDv9ruVSGXB2BS+D0nXWa7Ta5vKsQ9X6pOIKfv?=
 =?us-ascii?Q?uI331pAGkvVUCJBkeUeLg0yJYVlv4Dp1cs9g6hicCyxsmbTda5lfx/XE0OBM?=
 =?us-ascii?Q?e6YXCkDhetO07nvL8Apj8aH1x2JMp1tvTYLqZeknE8zdMEgrkNjKq2Xd2zGV?=
 =?us-ascii?Q?YKIM9DnXo96epJwj/BL0LoKSHUsw9FAf6Lqv4ARmSopk1j6lRUgGu2q6jEBv?=
 =?us-ascii?Q?wsk4o3jQ25nkCktB6jBcWc4kvHEB0d6vB6g0uGEZgWpCGTiOdxW2DY55NWms?=
 =?us-ascii?Q?FpexywGxNbjNswOZgkdRhxzcEHRJzwbDaSTQw3Xf3h/Ym9RVl1OO4S7wb4Hr?=
 =?us-ascii?Q?wqEuQveHQENkxuo367/RLMOp64hF4gN2ZiA6+EcvZhy0o1rT6vvHqJg9ug65?=
 =?us-ascii?Q?Peb/A3+nuBG44BXbH25coR1+DvSzqKhysBrrdG5Mu6PQSmK3qsNh6/2oe4eO?=
 =?us-ascii?Q?gdQofkaG/NLy2jCxsS4D6WDbLTSrEtqIUm1x3Xl/eGpFTMNnZt0f4nXOql/z?=
 =?us-ascii?Q?PF1Tuj8a40+j0evqEQykAxxWBXi5kFnvHkIrUlbl70n5p194ivjqueUW5b3I?=
 =?us-ascii?Q?tV8elI970QqnvsFo/1y1yKXey9lvTyO8P2dz1z1pQiu3DoAn8v4ZiB/t/3xu?=
 =?us-ascii?Q?tyyyr32Fu+hVdFzm0ouDlUB4DM6CjKOOBxDvggcaLZEuDQgUCs0xL0m6AFmq?=
 =?us-ascii?Q?LHYWzPXZneoRWKUujEW6Lp2uO0Wh2+FriKOWkiaZ1lrTr+ridFlGNJnNlnX2?=
 =?us-ascii?Q?PuO7UCFEG7sETqkAldBXq5Ma/M27VczBDDBRDKrXcVmjHkT2yjZvaYJbnOey?=
 =?us-ascii?Q?Zkc4YOokMwPwkTo6WTPueyV0vGwKW3iwXj8m+0VzLyStq9ENdYB/qPaL7DRk?=
 =?us-ascii?Q?Nu2Y7VzXGHpPt3bJWPavXgWyYaK0faX5h0PgQfxToUVjQVqtfMGtcmpy7QZ7?=
 =?us-ascii?Q?UYOpBP4lr5vDGekJLC8e2BdXWzgpWDDlAXLWgYGtMnaOzOsk5LdxF00qxydv?=
 =?us-ascii?Q?9oBH/b8eVadexllYe1h1XMiOUnA4r3BT1zTAIsr1geEYHDnTPvLHxauxXyiz?=
 =?us-ascii?Q?rhzDw1kiXHt/hu2js4MuqWzXkn7tJ9hVzCzO5mjZie1zQeKg/2aWOiL6KS4x?=
 =?us-ascii?Q?tYH3EOLvIT8yMrVhPLjj6QJCJ4b4F1SOFD64BJZnUyRsUe8eTlTaejECpy1o?=
 =?us-ascii?Q?+f9CVbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hIjDdOEiIreI1vfiwRjhiLVIQ3UTqTR2iewwtso8jeWjkSNFeQnuxqBIATXe?=
 =?us-ascii?Q?NGWL2AL+EkBJmccd7P0Ln6IGvj3xH84l0Upl5dDYE0n3DfzrxURq3W79jM3G?=
 =?us-ascii?Q?7X9UBrhp1YofJsXXgDF3zM543aOfw57OuGMy9x00xzIUWZV0QvtKISprlxmF?=
 =?us-ascii?Q?KXgOek+hZiHpBvAYgPxQu3oJ8PFEtnQjJoS32Io0Y+m4NosrVbaPJblHVvk4?=
 =?us-ascii?Q?cvSmgZ+rWfUxNITTjr3EkygXg7WV7veOwt/ah7oI3JfXlRd34Vejft6JqB8L?=
 =?us-ascii?Q?38ygHLL75j0RMMLS+GuprdBqeljNTq6JwhUkdOKySsa/0hNdGdjTxAGGnCRf?=
 =?us-ascii?Q?rPZBnAn63P0WSBzeYAHfrelFcfINnpa3dmdt1dzbyqHyDyboRFtrfKZVgOxD?=
 =?us-ascii?Q?LUzc2ujyTGyMkRa5OXZKdkP7DzovWszT9Ca00iT2UBi9eBk+LOLrEuxrUH6H?=
 =?us-ascii?Q?ia64OqXpquoExEgLuLqkXK5wnaDJ54YVNRdWlrJAA+mkbhvwJa+NeGHgfvBv?=
 =?us-ascii?Q?1CEcu0bgexxao2ioVaH6T79IE1CF6X5rrXCEu5lQ/Y9hgpc40JgDHVQTYdD4?=
 =?us-ascii?Q?d5LbuLqdCmcWDWt/vJc8vd/AksHli4Bg6z3M2q8DWmTwRAo1lsz+AwXLL1rQ?=
 =?us-ascii?Q?dKq9UBuEPzsOO97oDiuMsH9UYLY2xF2JROcTr7dG6UkW0pVknOjoo//otoL+?=
 =?us-ascii?Q?6VTW7ZgAJ9z5n7soQhR0jiBQda8g94x+Y/2RvARqR5Kdrz3cuHZRRavBv1A+?=
 =?us-ascii?Q?/GH3s+zcR6vJTzi8XEO5sb9Vr6vMfUCiEJzz6Cl5LpzH5Uxl4kh7Trti4/j1?=
 =?us-ascii?Q?C/rV5Ks6N+9QzVKp0AAMmdbmXqDWaof3Xeft7X1MTIX/m14HZUTggm8/CYNO?=
 =?us-ascii?Q?bDrhn6hwTwypGDlkaRrbJQROz9P7iGjdQHhkXwEakpwNlc0ecGVNdO7mirLS?=
 =?us-ascii?Q?5nrFINKnoRg/KDej9tnF8DDM2HdLry6IfMCvgjYigiCgaGLH/rOsjLC34Wuf?=
 =?us-ascii?Q?ym0Z0kCZRxiYCVbn0t9f3dbBVvAs3wp3pjEtrybVbLH9dKPRgSnxJ8xIE3wy?=
 =?us-ascii?Q?wHx35aDCv+fwKoYjn12VbqCv5AbdovYIKij40W6yX0Qu/cyyLAbhtCuudw7v?=
 =?us-ascii?Q?qPHp5wojOe/4La80n3xaml2brAl7vRtbGLMxl4OjfZnZoxDtZG7T9mNpZ1TQ?=
 =?us-ascii?Q?Q7SjymO9Lb+CbdZzL1+G8n27EVAQmPd9dx32t3hbJZ0lxfUtc03/3F5k9zgo?=
 =?us-ascii?Q?XWheEB4d2XB1IhkWDo78o0N1m98rDTyzSoWk7yu5VV+VL3XTSCdcodOM0hTd?=
 =?us-ascii?Q?TU36U0Ls/H0po9U7Ph9h+0c1cu5wngsTfVQYN88acOi69WvH/h82clqnWC3e?=
 =?us-ascii?Q?bepnIjVn/5pGXuSPY0U5LmrMBBq1iL3gg0DztVEQSHujEzPdH7KVnWI1+KTr?=
 =?us-ascii?Q?dUJUZ4IRuaI4Qd98yd5CbHcNOnsVmcrYlUln89psrhcJSiYe8mz+Pz81gHuj?=
 =?us-ascii?Q?4bLx3Ajqks5n3IWkEM1PRHM61oIRsBR03oXR5PswZBbnGgmNGLA0t32if9VM?=
 =?us-ascii?Q?QZoSEmARviZpKIjhOMc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8d41ee-6d1d-4665-e7b8-08dc961e8595
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:28:21.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwoSAqAKJhFXbUTG4YiRGQk6GSgfwXwoSRF6WVVZILdoGGiO+p3g8D9FhIWPjpF+Z9WSi7uqvxzaWV0kY291wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Change from v1 to v2
- Combine some similar warning to one patch for difference ls chipes.
- Remove arm64: dts: layerscape: add '#power-control-cells' for rcpm
rcpm actually not power-controller, it is wakeup controller, need
better method to fix warning
- Add aux-bus fix
- Add pcie irq order fix
- Add rename to rtc fix
- Add thermal-node name fix
- Add q(b)man-portals node name fix

Frank Li (13):
  arm64: dts: layerscape: rename node 'timer' as 'rtc'
  arm64: dts: layerscape: add platform special compatible string for
    gpio
  arm64: dts: fsl-lx2160a: fix #address-cells for pinctrl-single
  arm64: dts: fsl-ls1012a: remove property 'snps,host-vbus-glitches'
  arm64: dts: layerscape: replace node name 'nor' with 'flash'
  arm64: dts: layerscape: remove compatible string 'fsl,fman-xmdio' for
    fman3
  arm64: dts: layerscaple: add #dma-cells for qdma
  arm64: dts: layerscape: rename node name "wdt" to "watchdog"
  arm64: dts: layerscape: change pcie interrupt order
  arm64: dts: layerscape: rename aux_bus to aux-bus
  arm64: dts: fsl-ls1043a: remove unused clk-name at watchdog node
  arm64: dts: fsl-ls1046a: rename thermal node name
  arm64: dts: layerscape: rename b(q)man-portals to b(q)man-portals-bus

 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 13 +++---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  5 ++-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-
 .../boot/dts/freescale/fsl-ls1043a-rdb.dts    |  2 +-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 10 ++---
 .../boot/dts/freescale/fsl-ls1046a-qds.dts    |  2 +-
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 45 ++++++++++---------
 .../boot/dts/freescale/fsl-ls1088a-qds.dts    |  2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++----
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi   |  2 +-
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi   |  2 +-
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 18 ++++----
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 14 +++---
 .../dts/freescale/qoriq-fman3-0-10g-0.dtsi    |  2 +-
 .../dts/freescale/qoriq-fman3-0-10g-1.dtsi    |  2 +-
 .../dts/freescale/qoriq-fman3-0-1g-0.dtsi     |  2 +-
 .../dts/freescale/qoriq-fman3-0-1g-1.dtsi     |  2 +-
 .../dts/freescale/qoriq-fman3-0-1g-2.dtsi     |  2 +-
 .../dts/freescale/qoriq-fman3-0-1g-3.dtsi     |  2 +-
 .../dts/freescale/qoriq-fman3-0-1g-4.dtsi     |  2 +-
 .../dts/freescale/qoriq-fman3-0-1g-5.dtsi     |  2 +-
 .../boot/dts/freescale/qoriq-fman3-0.dtsi     |  4 +-
 22 files changed, 78 insertions(+), 77 deletions(-)

-- 
2.34.1


