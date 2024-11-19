Return-Path: <linux-kernel+bounces-413722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4859D1DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823FCB20D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948B136357;
	Tue, 19 Nov 2024 01:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9rd5WlX"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420394C79;
	Tue, 19 Nov 2024 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981515; cv=fail; b=ZVoot4cIDymiNuLcEipOXHJVVTSPzl42RZR1P5UPaiJ34rFzVntFfHtR463VsDJ62B/KddodqvG38c59LSHlwQ8SXo7dzT1s9NeUt8dwTRAzeapOPA4cfI4iE6rTOkTtmR/zHclubNuCmW4S2lgaK/Sfv9BqYf5UPPMmUh75gSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981515; c=relaxed/simple;
	bh=ZSzgXKKFE0sXM/11EEwCsrDV4IhqQ0Ujn4y4SAMDCTw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SJxI7EcwTsLDDImGCea4lRQ4T+Ka0B3WPpln1oqq4F7tCf2WtAvTdSZeTFC1qfE4Q43STAjSZh0/lQInO9yMxf0VYLN32Aqgyh/97s9wvoiT4OiVgpiIyRcj4qfEYFT12cSz3heqlRZIRjzmPnYgyxw6M07WIHULsFLy94YA69s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D9rd5WlX; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7SMauxpOb5lqkkssyq5eaJ56wlRwDdH1wJc6sprnf7lO2N6JK3jl+AT2z22VG+kz3HxG84epdChsBmJFSC15OD/NJeLzM4dp2Cea/GLI6tOIuMVLWHUIWJb1nhupf+ycG7gLTyRJPbJ+HIWI4Jn6gnBIxe+L3VBphVCoaei/y3lQ8lZRDZJ82HyUdh4+HqHrZcMoYOZ6FiK+5w1+H+49jHwxpyHyy598ovbliJydXH42Ls0ENYbWgzxKzeNeR07KjQE8Gm4HuPfjgHgvxXOgGBLAqmLjz10Bi4Ir2bJF02wKx8efvqhyZAyBD+/8TcAT1FhxdUIHL89vIg8ziH6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2AQCimjFSIBMYVgvZrGbKjWGf42s2GJp36HcqvAaG0=;
 b=Zw/ea2dtMlHHaEsD3qar21F6pmV8Z4xbyKjb0dVe3BKBolyScUSrNC45cHrljARfGswbARSmliEe3bP/1roxjlcaSLyNN9dk0JgpTCqGzMcqZgODtxpK8kg3FH0pukR0/8+zywNdUsZAzAxCEJtoOL4tIx/03Q6D/ulcKVxjUlx1aAFwrPP1EDC2vwPYEJSee1c3zs7fKnch2Ytj3VPGe0F20AjrQLyomjjVaYbrd33OQArknh6KoCOe+cCKc6hYb0VDj3QMzlBVfg/cguHQj4lESvv/cG9FF8igsuR38P8yrAzNvDHLDm/+wTH/oEOWiOT3jcNz2AWxD4Qse9uZ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2AQCimjFSIBMYVgvZrGbKjWGf42s2GJp36HcqvAaG0=;
 b=D9rd5WlXW9uPBohIC9XGK8dBIYT/DsucUgmUOSchqgPOuoyeqFnaiqltvRrmopoVMu6yJpoLZcyM4mt1wJSlKs835irfhKK12Kix/CnbdI3pfB/8NOL6Cr4G3DTRxXT+l6FuSUbZRhqHCafCYePmPXecP/IvNaE4WZbL694PkKdTnnrnW4c37rjnX1gmmaqzZWK3FyQ6bFP8Qg8tUs5AiA8CzE1CGJhy3HkUsRx0X4RthSBAs5Y/lE9eqb5MH3QnqyOvF9GVQ2miS1Kl5PzmpqBdlzwvRcEJPDwmPPAF+ISzsDvpFehzDzb5qJJXgrIqZVJaKruym/ASZCgQI+Dp3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 01:58:30 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8158.013; Tue, 19 Nov 2024
 01:58:30 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	shengjiu.wang@gmail.com
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/3] clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
Date: Tue, 19 Nov 2024 09:58:02 +0800
Message-Id: <20241119015805.3840606-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dfdd2d-fab1-42d0-f17f-08dd083daa42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X4DfWNCVixtujT82IpeBv9pGzGvmEC9RwoQxf0FSysfD0hb7boa2DEhSsLkn?=
 =?us-ascii?Q?DcbiHmhNy0iZPGMBaUmjFW8SQ9OTa8It5JIiTOGlOHih6+jz+S0Pys2quL3a?=
 =?us-ascii?Q?vM8mjC7F5sL8F+zm8Vfr+Pwb3tMIZ+6vIcu23+9hvLrxiMaRp3fX9gm6neI+?=
 =?us-ascii?Q?ANCw5n0BziV2GzINIYlgy1DqrsPw2J/2tx37T5WWn5+Yf2ZUs5ht8xTtwwxV?=
 =?us-ascii?Q?utpsG2czRIhRPTeZ9AJqAwPMaCMrDCwSC6+uYB0z5uKzWaPZXTZOfTOxTVEg?=
 =?us-ascii?Q?Cg8YMPpAnMb91QM8HwQtRgLetuuCOJ7SuhYyt5ZwTixBhge53fRDUPKgy+Fm?=
 =?us-ascii?Q?lo3v+pkkF0wigokMXABKEJFnsAbdSQ0MtkcfHEac39vAqbuR22dD1143rab0?=
 =?us-ascii?Q?8OAL/SjjlQDEuw+BL7vCv7d0ndq0l2GR84md2vgI+jDJjnXMG3kpiOpjXvuN?=
 =?us-ascii?Q?EHijCEIZOt8tTIEHHkjyg+61kgcmtd2LO4Bh1t761oI+b0XQzeX97EXfKIeM?=
 =?us-ascii?Q?tBiSZdyJsgALjkSxHv4TOrXt4UAbWnYyfCB6PgnYMtOrHZFfdt+s6hBEOXFm?=
 =?us-ascii?Q?vEw9UojKPrAZg7i9vfEBi6/lPEMOsVr/Uvgm/oK7Fi0zeop+D3OFiIS5PPcr?=
 =?us-ascii?Q?WnJXJYkZohFrM7dAdfWbXcsATifGNVQX4F7l4LZbttmu8m4FBklC3v7d3KPx?=
 =?us-ascii?Q?T/PjJ3GmGmZR4eKwB+KELESxnq7ImPJ18LP5wOIouCP9MkPv3dgmvHPnRJLb?=
 =?us-ascii?Q?k0j3G4WCcMRQyQQkj6Cfes2X4yXPr2diP5Mw8wWPU3F+UxLSvdvhZvLpr0S4?=
 =?us-ascii?Q?I0yrv7vk1VHbC55j8YlVEnUWc1HgNiAMdnAXr9ERApYt+NHkgrBwIl23P07g?=
 =?us-ascii?Q?Ixbw5lwmPZIrK9rCm4TGdMtBdDsJelJKQD87bHortvZceT1VOfxREh4t4GOc?=
 =?us-ascii?Q?0kZPDZ3AhotNEAllVj2oFCSncznDD4uAYId0uUcZqHkl13xxjXoTRfnEv8xm?=
 =?us-ascii?Q?/4S8+B4QokGAeq/hRCMWCz7mwZd/paB4C0BW9tZUEuUkcUMLEGExrms/weLM?=
 =?us-ascii?Q?bDVsAYUYtBBJjJtnteMGfD5Od5MMsGi8fpmVuUVF3cWFMViTOuhVeu+mw00T?=
 =?us-ascii?Q?Wy8emsHfQCYeShmYvXEvZsShMtvhDyEry58t7koZ4VfpWtx7/KNbqhKs0Jn2?=
 =?us-ascii?Q?fcm4LDTxQ76oP6Tcdg53QnqLLnvYS+W5/trC1LCrDB9ynLGwU65NsRXDywtN?=
 =?us-ascii?Q?C+vAoKANzVH5h8MppbkQft6wj5F7wAUx3qxxtxkxjq0cUB9XjSqSgQGY46DC?=
 =?us-ascii?Q?+zFbc33vGk3hMSRqiGsovd+BC6MQVXgWVQmBxjNGHdOqTl5C0zmSYc53A6Hs?=
 =?us-ascii?Q?SMqh9B3XrC9vy2iyh9CWwUkWJxP7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c5AogS4uY8e8UYOYE9oO3Rl693aNS6jHKlHMpDmx+clzMXxI1bq9QN1PvlW/?=
 =?us-ascii?Q?ksy2MDw97C85M9rSJLeg6jeK4BQqbzjeceANAzRjfmaUkD8/gLHrb+4UNVsV?=
 =?us-ascii?Q?nqnHo/x3p6dH9XODxpNATNfGGi7qGXjikB62Qy6KZMc33xNa00vCziuAirp9?=
 =?us-ascii?Q?Zo8z4S+qC6XIeAz1c4WMVowBtO+C+ZaJziTopYye9XQxWyNG9OTCzvCe044Y?=
 =?us-ascii?Q?f+lUhPJOsedueURYIcbv8myoSRtBeokNCcfsb/EkWOvV1bEKbPaNcdNnhWFu?=
 =?us-ascii?Q?g4H8bJIOv3PScgyK8JXinmDqx4igo8jh6PKPcUWoS1XyiAA3AUBfizjWmZCH?=
 =?us-ascii?Q?ZSLvDij/KTpHmsUJAsNTr6fNYY6VWwb54/d6MkSiumxAwK18J7h0ePs/9GAQ?=
 =?us-ascii?Q?Vtb1qIwyT4QpykNZxAmkofKF+1T8Q6lI/zbq0lAvhhIz7DPQUFsZRAztVbhM?=
 =?us-ascii?Q?KmWi3iFNuNfpMa9v9808zI16hsVOLJOQBcdkZU6zV5yderPvIRbteomS+TUp?=
 =?us-ascii?Q?fhOXD+so6biXjsLqj994up9ZIUdyoHHIfQ/873Jr1+5vbXiOdmfkoUt4CTch?=
 =?us-ascii?Q?DtBJyKDkUOs8wJ4VxwkUybf9WtkpQusETA7MIpO6adq/tu37BtpH5d8fCiiO?=
 =?us-ascii?Q?7bHZgKrOEzWFy23yXAxEvhJQJqm2D1Gw54DaVfAZqY8Q1ol+sPVJi1i4LcBa?=
 =?us-ascii?Q?jZ5MrosuF6DgrW9sgl5k/x4Mg9weg0UJo8gCJ4a0Edb7M4eCofsXthi8Rd6Q?=
 =?us-ascii?Q?0LW2BKKGcAp4lQubZ0bDDn0kbMUTsF+p7x1FHxyUh7T4IjH9WL9W5oAI72TZ?=
 =?us-ascii?Q?DN+LjX4yYyGt2BCzGnyu+LpqvZwoNDp8F6ZjYvaBEcgX+2OASpb2qATt3xpt?=
 =?us-ascii?Q?g8NFqCIlwdlsSuD910MqT7ZJld5/ZIZE99J2yX9VmQFavh1FOtKPOy8tOX4p?=
 =?us-ascii?Q?xZOnuJvjpVbQX/aMSHKVxExAhwxlWIgzSX166YjNKzn3uC3WXtd7TPG4M2z3?=
 =?us-ascii?Q?iFUnZmj1YLmB2BrRlHovKnBAvkVwjVcEwNDztvSAdCIhXlSEguoOgnpzr6RM?=
 =?us-ascii?Q?VGxJ6SrECMwR96FhAeAU2JLrXNVgz9j/zFFKSM0SUeyqfZGz3pBio/v4QYLP?=
 =?us-ascii?Q?5Ib0afGP2iPh3/XYKG4jVBJb/4IfijYvcOiYyWC9Lcd6OdKon9KbMvSmAm1h?=
 =?us-ascii?Q?QJ8C4+yQzCK+vB1jZ8u6vdoRJ+/y50k6GPzS0YhGU809Eu8sAqOHJHnGedMU?=
 =?us-ascii?Q?LMOAcX8TTRKPN8daIToUo7kfDiumXcisqSGyRki8CYzu/dOC41/M7vpBF0tV?=
 =?us-ascii?Q?XrnYlUoT0zfWINk3AJaxhN7jux8KkZR8ZjMLbewhZb2gwPSYMmILLOEcgzfJ?=
 =?us-ascii?Q?8OegByf62zIzFq1yQkuk1UnyQsmdpRfBlmEF065mjpKolg0bk6G8pMCH8IpF?=
 =?us-ascii?Q?ot0bV3qCfB2yWuvT7nSEXNuQRCNhJ7MNH0PVdDYhLUQjAU9ZNpHyI8/rcyUU?=
 =?us-ascii?Q?PG08Gox85D8P/JpBsSWXplyKzbtev5qCh7CiQZLZilhP9+P3DuxbeEXeguh2?=
 =?us-ascii?Q?/Tj8XVddIJ6eAuoxV5wKBfiSmXk6TYz28jarrEae?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dfdd2d-fab1-42d0-f17f-08dd083daa42
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 01:58:30.2391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lUJM8vWdp/Ut0iLHF2V8huobpZKke/HRjcwxzCf9ekfo3Hz9NMBtY1YokOEWrO5Fky09aVHdnj2qM/xNXh9PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

The IMX93_CLK_SPDIF_GATE also controls the gate of IPG clock
and root clock, need to define them separately.
Otherwise driver disable IMX93_CLK_SPDIF_GATE will cause
IPG clock is also disabled, then register accessing fail.

changes in v3:
- add fixes tag for all 3 commits

Changes in v2:
- address comments from Frank Li
- refine commit message and add fixes tag

Shengjiu Wang (3):
  dt-bindings: clock: imx93: Add SPDIF IPG clk
  clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
  arm64: dts: imx93: Use IMX93_CLK_SPDIF_IPG as SPDIF IPG clock

 arch/arm64/boot/dts/freescale/imx93.dtsi | 2 +-
 drivers/clk/imx/clk-imx93.c              | 6 ++++--
 include/dt-bindings/clock/imx93-clock.h  | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.34.1


