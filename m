Return-Path: <linux-kernel+bounces-305996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B019637C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73AE1F2210F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8CE262A8;
	Thu, 29 Aug 2024 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MwyJw+s6"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32A1AACB;
	Thu, 29 Aug 2024 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895213; cv=fail; b=jYM2KBCIJzxqHkYZiQzo3GssVEp2XLN/rDCV9cChagw42sgqblPUZcyMngsPtQL0e1eTOWb9jGA7kgxUKylcyQgJoeYLOn/2BMEuyCHY9LN735dnPL0QksSc7uB6294klgdAmjREotPC9tr5kfI7WwWhtuLNeQMzy+ArFdeNJg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895213; c=relaxed/simple;
	bh=VZ+iOmdfBcqcujZ124Qz94+O2k9Y5SHf99tkI8I9FFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rk2oh6T3A74n8HCAb94R7ntwMtpYcosGfMhqnO44pIyGH5Kys3Tke3+VVu2SWyb4MYTIOJL/XUkwDqsj5ADpxivlav131GOxQkQJK4TcYcw7lDtZogzbIqOMJh+8PwY42LDHK0tAv8qv2YLV1LpnskPsHlMyYkKd44ScDAoC0oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MwyJw+s6; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SAWismRvbUo5boZ3B8kG0YsoHKQJNQJIi90AVgyODr/rrq5gE7IxX6ru7lb9eIEaHpqT8ujs+9RuPs+lmr1srZEQMpA0rrA6iALWzNSnOiepNjM7/5Wh3+qOxJuGJyc+cG14+S8Pqs8dg3WR1EZ9+BjXGFKd+OnWLMk7Nk/BauCsNGQXh+sQo7UV9Qc/lH3Ec7bb1YfvqzBdJsl8Zaygu99kjgHJVn8wamzDrE/IuH4mNEMX3fJj2Vg8BmHjGEma8bOW1Zw7c1j8k2ZtEpKo1eOrquh9p5FGwE5LY3Hfw9Pd3CYuww2gQlGtS0wr2AWP8SGq9pz26Xyg6dNiTF2/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF75XK99hB0SfI5FUktinmC28xcgTIjQT1/uwRrBegE=;
 b=oRx8XDCU0JCarrBYJQsGRxAlsesbi9iRuT19NVlqzWNLtJHeKuP+K7Z/1XGcJsFkn6IMQVl059wFXoOZT87WpQzWufVCWkQrCGTPpiNCskAcgq6TSbHo6r5YiBWcRu3d1ExmwzD9fBwXCxgwgak58UOi6eBdOonwZ6yxohPB3nQgPFoy8B6DM3rdSvOZcnMuw5K3S10gYTIyV2gMHb9bGAGew3bKibuyQtkemMXig8dDOAL/sLOze3VuLFesJgFEZGNWbRS9BBoJ+BzO0+srwTtN2VGWhv3ZXCWOxVYLyhRL1STOkeYV/PfMJ6+wAQapl8IgmL36iMirZ6rHswH5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF75XK99hB0SfI5FUktinmC28xcgTIjQT1/uwRrBegE=;
 b=MwyJw+s6y/tJQYeJIhphJoMlqsGJguFLOsjzUXYNtOjh1QbYQho4iq0lXSzQNCgFn2JCORcyqv17qutLE/yzLQUiYGvK5+/t0b1ddsr0xWy0eIlAN9oWgacuO9rbku7cTUDaeJ5nyOLjSiu+KXZ2sCfHzOKksP5yqTzyv56U4wHdxBFeFd59LhMd8kyz6of7OjJ020KhkN6hpVn9Kszf5BvhOjYkelfNEwLB/unSOtWZiWYWbaIWtdHlJVUt/rs2POLKYqMAtqpwS4isoTHLjJ+RwNIvhKdj0//OUihimsuOySlUOcPyvCKcNu8roYuv0GwGgzjx7w2P9mUmjgISRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10924.eurprd04.prod.outlook.com (2603:10a6:150:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 01:33:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:33:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [Patch v3 1/4] dt-bindings: clock: add i.MX95 NETCMIX block control
Date: Thu, 29 Aug 2024 09:18:46 +0800
Message-Id: <20240829011849.364987-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829011849.364987-1-wei.fang@nxp.com>
References: <20240829011849.364987-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10924:EE_
X-MS-Office365-Filtering-Correlation-Id: 670cb703-4e1a-4064-b230-08dcc7ca9574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9CvRM+CXVGDAByvqu+3JJuDpfN44Q68bQX0mvKH3c6SOPHOOjDOQzMm5QdlV?=
 =?us-ascii?Q?sUkKIPGMHh2cpP9rXW1lrbz3PqYIETefc0ASCA94hLoznbW8hauYEqXu7Xkz?=
 =?us-ascii?Q?M+kjDcKcLZiuEmL34Mx4vzQ/+yIGyCZ6EQU1fQInyiXmiWlfhmEMKACueMOa?=
 =?us-ascii?Q?t8ovCOOUEftfq+SgvlbA52OScAGu/Yb9kFsZ07WOKbRDDtP5imSSRoKZ+hPo?=
 =?us-ascii?Q?Y455n6G+6w3uXho2JnH53ivAKIBarr1Eb++54LwTy8ouk8qS3QJJEkZYyRS6?=
 =?us-ascii?Q?XTQKtkacFWp8mVjEaeaAwDWwmPLHjrDVX1RXbo8Xp2ly9unW7uM239nS11TN?=
 =?us-ascii?Q?HmiCntb5O2IhzrXoGqA7RvaPyzWNJYmPtMSAXNU7ncJdPRgGkjVXI74RhsGN?=
 =?us-ascii?Q?XhTnvErRIYpuOiVVNOthNzxC2AXkUK8UDw4jyIbpNmCASewdMA2Nd9bgrjng?=
 =?us-ascii?Q?PcMnzPFHEPjSBRFYqkp0727dwZJnQ77QakDYvstH7QSVIr6glJ2ufipaecAb?=
 =?us-ascii?Q?/HZXjUw5eHE8OAWOZo4upeC9NRTTuA2eTiM3YAYSwlhhE2m+vw9wz1XtGvYQ?=
 =?us-ascii?Q?6wUeccZYm3mtwAc9RlFg165FzJE6H80E+G4b5x7c4IRBRYukjS1Ad4Tmgf63?=
 =?us-ascii?Q?kPsqA6FUGKGHVrLUr1KXkv0y2heqhuyUK2zbClbkNnWMEv+koCYlGe0WFuhR?=
 =?us-ascii?Q?Sgi32OfeqPlQm7FtdE//iO7ngwjhxjm3eKUw5qFu/+Q8BZBCFVLD/m1JmePx?=
 =?us-ascii?Q?OLIDxL3THrlJeaaVHugbfM5sc0YkwNecBXbz3vPHYqiqZLIhC42BVq562COL?=
 =?us-ascii?Q?IlhTNF28M0Z7j3PwpsrnccgrefIbO74zgkI3vDRRTytW17b9oqpqxYwiZxMZ?=
 =?us-ascii?Q?XKwQL7/rDntCFToe0J0RSM9J631b3wRmwgviDrdeLIgbbERxnxZy3WPcZ3Xl?=
 =?us-ascii?Q?IMdG/newDsi6ch9Tni4OSW3hkdJSqWBUckakS7hyp0aKSFEp1BEtL93UFitf?=
 =?us-ascii?Q?8K68HapvLDnVKgMco3tFKCd3K0JXJMwALLfEKs5/YdWA9RNwmMokm8ErxihN?=
 =?us-ascii?Q?4OpvLfWFan/oUNsHQXQEybhpmrVXTAmBStw9KbWjIB6JrWFb+2GHw2DZdyf5?=
 =?us-ascii?Q?AyHZpX1EWw7fE/XT1fu+mlADowvBf85OriZ7TU2E94Irg1UUBl8JZUtSiRSz?=
 =?us-ascii?Q?QT+/Uq7cLmkLx/q4TP2hnzfmLkS6TeSUtAFztNxOHq2JWlLy8rEvqdhwsMuL?=
 =?us-ascii?Q?l9+EWHD38anqdHOnL+BVymAvEHvol08AJ7U7bRHcONQLpzStBqDdbWoEMw0l?=
 =?us-ascii?Q?sPCkSuCvvmEgGa6+DuRURxtBZCGXRwt08xg9MMf8ABKH4PrFfkWUdFvqXu9k?=
 =?us-ascii?Q?R8yd3Bygn4UVsCE65mXMir3t3hL5fnsGOSIiqabgTJoKa3lnlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A4BQC7tX4qFPIW+ziI2gDKe+Ff+9vv6g4xn57cFdQJlGZGNaXOfEeJ45QyJD?=
 =?us-ascii?Q?Ij9OaDrENpHOUDmiF5Gx1KhkEm+BptSuGqDK7n+YMinb4VCG5p/HN1skFjSf?=
 =?us-ascii?Q?+2V95MBycqfq4I2s72td9tzAA1I8hzvmQA0XTHW8cL5jJoD70zDH1G1XOCHb?=
 =?us-ascii?Q?wxSXSifzwsd0zqTlhkW3x+mq1+jycq37vwALI5zLjQ+s/TCUjs5+j8wbepWv?=
 =?us-ascii?Q?7Qi4b3y4OBH52VXFBjspwDZw9YNpBGB7Pa9oCie6twEXq4cwrqn/wed+TZR0?=
 =?us-ascii?Q?LyswS/4+cRfwdqDayYxN0tLkgWwuvRSyX/ZI5Z3iZIH09WAEFzwnMIMXohOv?=
 =?us-ascii?Q?WB8yr8Ur8IsUZ6XgKinBUb3qJSfYwcCV4TsriR/fVAE4RSDMfD4/7YGbQKB8?=
 =?us-ascii?Q?ylRd4Vgr+mGtGln+IO+cAajlMolwZMfONDll1OzspzZGXSCpsaokcZ9WObby?=
 =?us-ascii?Q?1614UyBt86Eiq7gGqsAL12oyanAYqz8ljBv/pYigZOImQ3OtLHWVgS9KoirH?=
 =?us-ascii?Q?xjrkigFmT1fHGoYHk0EneGUPq8vMQGl+Rq3PN7KiHBTjwJcD2zf+aNxpjtFO?=
 =?us-ascii?Q?2oYUAL8Tvgy5pCxUQth96SLIfKnP6n8V73TuFxonwNNq7QOPPbLFEdljvuYV?=
 =?us-ascii?Q?9c7NGWtHUUwLJToJMhxIFrCmqgMq3s3GkTBAe+D4XCBQ4gXyIIq75FuuvJcF?=
 =?us-ascii?Q?DH8hLWx5ol7tjI1yHXV3m6qzsW+XoktSnZTQGFcE5sy6F58KaePZjEfdxvQ8?=
 =?us-ascii?Q?uxriVdN/NYVZKb1xXIm8zMouj5ApBCgmKr2/RTxxlW0720kx3n7FRzBo1OeF?=
 =?us-ascii?Q?LkjjzhIbIbrwnz+dcN+gA2tKsdPUsD44IgGJGh+f4Gaq7xUZXJodklIKmqPF?=
 =?us-ascii?Q?C6SCgb8shgWGr0N7m9J3yHkvXbZppYQn10vBi44D0KQxEmIr/xOi2FnaYDwX?=
 =?us-ascii?Q?uePyrkBFVwvkqfISV6Bz2EJArXcXUqd4aGDKUwGBJDhnGCCUV7bR5Tx7tpgs?=
 =?us-ascii?Q?6bkPcR5pAr+irBx8ce2y8AreDjd2OHhQUcWxPTxZy818pkRVs9UBlEMme4du?=
 =?us-ascii?Q?CjFyCrVohEFV2Csk1mw7TTlIoq6mZrdrWKwNlAGwzkrmmYmdPEZy8FydiNez?=
 =?us-ascii?Q?GkZJM1GvEUwNz5mExZg91tXJ/xNsi2nCU0U3r9XZJC25bFlzSv77f4GBmi4S?=
 =?us-ascii?Q?nBqwaupdYP2ZMroxlPli4zT63SQ4UJT4oazZRUpj7+vojdLaGfHsEgRJSTmK?=
 =?us-ascii?Q?TN5X+Beq6436ZcMekKBv57gMoODNs5quftJSR5bl8uMxJxGxQxXCraQFik1Z?=
 =?us-ascii?Q?aIJOU+uL/LqGqoDzwa5Gbvtc/0yK/5BY+3wFdmyteFzTk/QWlxoIKbsEZ/m8?=
 =?us-ascii?Q?SpjRzgRN0Va2cqKX2sPoGapE+yp2L4t1LNelJLx8/0jgHho0huCRhY85e8+8?=
 =?us-ascii?Q?dycVo4hqOwNxFT0RhCLTHkZ+4dFELKfYOSceAyDDCLX+x9cogVjOwaBViTBn?=
 =?us-ascii?Q?ZRt5XlgaQstiwSCFkqHdvip+KoFIwdMLmh0g11AueOULtA8HhgNNUo2MQXKO?=
 =?us-ascii?Q?6AX37IzXtbklEIxHzc3ebmMFsGAqxR6C8OnKV8RR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670cb703-4e1a-4064-b230-08dcc7ca9574
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:33:28.7781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ91lKucyHlimw1R4gimxNNMc2hWSPCEkPZ0k8rzjF4xsdBj+CfXBby2w0oM5sKhYGUlvyOiNx1HeLCyNvVE6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10924

Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
V3 changes:
Move "nxp,imx95-netcmix-blk-ctrl" above "nxp,imx95-vpu-csr"
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 2dffc02dcd8b..5dc360b2ea4b 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -16,6 +16,7 @@ properties:
           - nxp,imx95-lvds-csr
           - nxp,imx95-display-csr
           - nxp,imx95-camera-csr
+          - nxp,imx95-netcmix-blk-ctrl
           - nxp,imx95-vpu-csr
       - const: syscon
 
-- 
2.34.1


