Return-Path: <linux-kernel+bounces-231463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C191990A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF71C21D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195E1946B4;
	Wed, 26 Jun 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D42PpA+R"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714819415D;
	Wed, 26 Jun 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433574; cv=fail; b=uv7LV47QRQEWFDryTVUj431xQ5ll0C6ghRpZxbu2r66eFKqCK7v9sP2LD6U0kNRsO7cYglbIFGfI4iVHhTtDvSZ9xv5WPL15K1YnM4P5gAnqpcxUg6tc7Jf94czqE6BHeAIInhvwrp/5WEw7IVnhae341MOTLogaojK+3IwE3ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433574; c=relaxed/simple;
	bh=y2atmYsxFxgXKNw+U0IRtfcDtE2JL9KsfE3MBOGNMMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zj2CcLWHtV/+zcH+ZNwVfP+lJ1u+zTlZjvu3+K788HHUxdngC/2stulABzye4untYOxmSq3+3Rf5IWD9vEnppFwiGnF942h8TrYphw9e7i0N1VMcw5T/ULjmhvv5hGEDEv8YWeoI/HcDy0n9r7ZGyG8B4K0Lub8ZwKpuDx8LyZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=D42PpA+R; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9Rjsq39/NzjDwHc0yJmW6yWPiGWdKnJ5Mpn0Oa3686K8LM0ck5dC9OefGii31jxofgDGzkG4K54b5t4/x0ekmcUKmsd155MZfb+AwYNjhyXLMpWFKX9HArbABTXG5A10S0YQsDUi29IsU/mpRk79x10HCN8gToYDJywMel5KRjoNzscjE2xt23aN/Cb/DrQhj7NfH9jXU35Bhs1AdUnQW58V1SJfnzPhSDblpoJJ7G7YfWWHN2d5oyk30OPMWrJPnffZMxjr4kaRpe8mPCjDrAZqgwrn6YfwfcAMUZKGv/+aJChrKrtUUf/Yj8f5Pws4YZnp0jBnQORgSxgPpg/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duHvwaFbivZbtM6X5ojpmVrvOAHjYA++MdJQGAmB0JM=;
 b=nouBbDCI/JrOA80axwJ3JEoGct2d1e0tyCZ7POtKABHiXRg2fXxdJjLfBv69gvty4YpT1U4+FkRW4yg+BzNp03p/nOYGed6O8+4F/C4bQ8iq7wZ7t6INli2ZvB6N+cQQn6tCvR39RMYfzBJfyRNOm2PlLkpGUgc8o860VU57f6KwKwVwO6xeBbOCFWZAUxdgRaA/d6Axy929DhGlWPAXvXGgyDd/PMYr9t1yHNzo019G8FuCv7PzEC8YMegJrgliopbyv3pjg7NRv2g5JJSjv0afqNE0ZXI4PK2WgUOn7ylZzaWffyh3g5DnIukfsv1aI9dy2esdzTuojhznJDlSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duHvwaFbivZbtM6X5ojpmVrvOAHjYA++MdJQGAmB0JM=;
 b=D42PpA+R8m3BRNegfDhEpDqb/OFQpiZBOjnVZXsPa/Tj+sBH8i2dRiZkjfdZ48fPEjWoKOnjo+IRXeipF28XlAOxfltzN7p5CFGkoZUVWo/2hjHiLLz2wzgrJ3HOIybv0G76voL3apZErqAqAbH3ZLsnyzW9aGazWbOuPTlwRHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Wed, 26 Jun
 2024 20:26:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:26:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 07/13] arm64: dts: layerscaple: add #dma-cells for qdma
Date: Wed, 26 Jun 2024 16:25:27 -0400
Message-Id: <20240626202533.2182846-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3588642c-d865-48f7-9358-08dc961e3765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?en4/LeX6WB9oNN26WiQYoiReAjKjJtJ2vFaWGPg8/bCxDGsnp12TAaMKGgh9?=
 =?us-ascii?Q?/r0H2QZxaoqzjN8ZOFTgzAtO5epBTjT4hwpDIc6Y47L7zFPoKSaoZDo5gU6D?=
 =?us-ascii?Q?2xZN6N7unNixVpE8YoGgqHxgfcjXnR9bml0Azq8TrRwGpXCGK4d/37wMloKC?=
 =?us-ascii?Q?l71LmuCMIKERoqURVxL4uGp1pVaGCbrC4HGeo76DDIxGR/jWYr1mF6jifgNG?=
 =?us-ascii?Q?0gD0iY34vnM6axXwuZAUBns480jhkQ8eE9K+Nsnvz7PaPffOGChIzSLhTWVj?=
 =?us-ascii?Q?QRPVEOxaxvVyZ6OwqgAnab3I9KujC3RMs2v8lb0IHhOeWeQphgDAekrPcl8f?=
 =?us-ascii?Q?5bF9DnG98LFVwJzBHebPFGuZhkM3dUUugaRbL/xS6mkdR+93AbY5sGX6jKzp?=
 =?us-ascii?Q?rWxTFfPu5y0co71R6N/zZVUzlcIT07edyu2g4Gx64UCreLC65zjM1/xccVY7?=
 =?us-ascii?Q?r/Fdt0K5AVY8VfT7dc1yM4EWGSKm5UNC+wQelS++rp8IHY82r2HoFuMwbUhN?=
 =?us-ascii?Q?uUDuYR4Tf6NofAi980y1lMIxLqgC6JolYuWJ0PEM66mzHC9zC+eggydkSJ+A?=
 =?us-ascii?Q?4vB+/zHn4fqT90q43n/z4UC/pIpHS9GDxrcH0WuYtXj6lHBjmRosAWMFSVB1?=
 =?us-ascii?Q?8hvqbuGtn7t2s2XLkGWv32k4+oKpK0TLvGtmbeT7sZagzm19kaKqNl4Sn1pB?=
 =?us-ascii?Q?XfjNU2XN730Rxga5kt0VGpFb8akyUFBmEUbSp+mypd8aank7hxlumhj+0K7L?=
 =?us-ascii?Q?pnF3UdMQpsrIAre06O4I3YxR+bFfxet9lPmckUcIsvr86q9loMr9DV7Fa3oU?=
 =?us-ascii?Q?OJPnMmPh+Wh2FU+0s54CU0HCcJ812GMgX0Diw+gBHE1g4HJWqWweIR1NCiaz?=
 =?us-ascii?Q?jCCFJI23pm65v8bYKfn4jgpgU98ltgv5j8IkbWBOuWlO7WI9RfHHtMQs4Wo/?=
 =?us-ascii?Q?2qd/2WJzFrLR/80dp7hhcEvbT9s9F/0qpmiZl9SxNuI8wous8IL5GiRooloU?=
 =?us-ascii?Q?+4QXSFgVIpXkaOnOk7h/YKUz8jXTX5y4NgRWSsjVq9Jje0BRuYjEawDQKsLI?=
 =?us-ascii?Q?g23Zs2kkc/H6NaGA8ScpTrfWlw15t5xB6C0fZBFXpXmhUkRa4g8mAcSBfFgk?=
 =?us-ascii?Q?8+eEN1TVGRV3SCOa0Ac6fA6WjNlbKD0HdcifPxnWedN/s1fRb9onCQu/vg34?=
 =?us-ascii?Q?pBntgRiGXGCxsaDW2Kn6LkJz5Vj8tQMSJp8OBldGNrEgghQjtd/JBg7klrDh?=
 =?us-ascii?Q?VBhTVhRCVf+N3oPckEuuUZDZn/p1oYcnOgq5eXE1U/HH2k1KmDvGffgKPpzt?=
 =?us-ascii?Q?GarFwm6dIQN7GFP2OLVPQ5d1xvxkGvsAuIWqN3xuEOD76RiqqIHXBUNEwvNG?=
 =?us-ascii?Q?y8ULu4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ecnek6HEjm9yhhVV7ZDbF2VZMNF70tBHggwaaQZepPLVq5DUMbILy8ITvFTo?=
 =?us-ascii?Q?UAGzse9518G2AykMsvNCDryKDqeHHMwvwPydmcZdsKkXooW6JxY5XGPHDo21?=
 =?us-ascii?Q?KTtEhmQv6+/jRyxDL5oQVwc9QxoFuAtk1ylPYVAdvW+hze19iI/POvnrkJZ6?=
 =?us-ascii?Q?6luGbIWfN3S5DyDAW0FhM8Mcoim3Ri93icFfJXOUZZ8NkQKddbb7Q6jO0rXf?=
 =?us-ascii?Q?JS3ZuRqWmP9I6goL+TXLzkxm8THtSwtX9p5boGVx6thKE+92ELEY5cLGk2jZ?=
 =?us-ascii?Q?9kqd4PdLG1Yfwjd9RsaCkqacCII+Ny6DsbM8ghPXZRNjNoYTcrJ2tDqPlwjP?=
 =?us-ascii?Q?lRuaSI3IzoCGzwwszauWMVQYrRDonl/XHnnDYxKCLyOeu/CLtg1EBhpcGjRa?=
 =?us-ascii?Q?rHLC1p3MaqX4aHbcBGp+4JCwaaLqdNdYj4ywqgKjTrAILLt6J8A5aCMzBD6u?=
 =?us-ascii?Q?4nOHQz4pEgiiWbDueREXqzudJQqNCKsDY2wnYiOxMBjSF9fT/l7MERJcze/3?=
 =?us-ascii?Q?TluXPQwsXQx0euUJSDpNFnarAsT4aYEaTF+NjVQbrhN1dFsGvSHNUTRr8Z4k?=
 =?us-ascii?Q?MPsn4GCWtOx0BMgwXM8am6JQj1RdK+29SJfan3z5eebGFuPuCQ8wsxxAeX0p?=
 =?us-ascii?Q?uH/CZ+bK+4QNYs50xMtNZhvjfeO7vRdiHKExMaW9DQStTEwFeK1uYs/D9cNY?=
 =?us-ascii?Q?ItUzLi5yqjgZmWP9POO0gXpSPhiKSY4ZLzfZa1x2Yb/Sg200Y5OzzJxmuGT/?=
 =?us-ascii?Q?uoZ+aonIOlPBMMcPMjhJtUqw47ujOCHdWf9aIdgf/m0qD1QaX4f2uryykN2e?=
 =?us-ascii?Q?CsOLIi0lbqUQKj2SwCyYHLUoXYhmpsdwy6Z9W5TFxditmTcumSR9JSGbH43B?=
 =?us-ascii?Q?5v0Nas2CGADMZhfPjv13yJUUcGGw612PgOEIgfaTwnI43JFlGpnb8tTe6fjl?=
 =?us-ascii?Q?AHbCkQWZvz9awnhYsan/r5stZOv5DdekpZaj0Wz+7U3LkotdEV4TyWmmbgy5?=
 =?us-ascii?Q?zLV2p7ipaynmcM/zFH1P7TUwqk25HskoDk/RQ/2/1zzmen+tekps5WlXiiWb?=
 =?us-ascii?Q?kkn/TcIykjpkZPNVHFSu3CrVsZAxEfXthMPwAp+zvKaLwgLFYhkZz166v8j6?=
 =?us-ascii?Q?1J4J718h4QLUp0wJY9+k6yY7kSbuvOCtmlhKH4ZYjgBKDirwzFwNJ+YsL7lm?=
 =?us-ascii?Q?imIUjI2wtlYsIh9j+zpqC7NOMJe8cpicejIlcJP4fC4l5cMCi6e5OPZ2/l2m?=
 =?us-ascii?Q?jLFOSPlv5n2QXShdwd1lQ+X8j7WqP1Pmh2but93c+CD/jIaG9WK6cQIYl1e0?=
 =?us-ascii?Q?MOpZqk0MXBjOdyTbToMNY6zp3IKP4nRFBRy5+wKPZLzZEcJrLlVnOTSGUSPz?=
 =?us-ascii?Q?RWHKuS6lC7ExcOmnuDlRJxvc2NkIHxMG3v4mq2QR0/cEDrddxkdXVq6G0RVy?=
 =?us-ascii?Q?QlKfPH8pRreenRiOT15/4r7cnxGff8ZyRMgpun4Gcf0SAuv/bf3mq15WpLIT?=
 =?us-ascii?Q?tHZfe/2ODFY7QpnCf4/Y6+LSPtUI2v945aED7H/K0MlcOJDekah//dhPirXN?=
 =?us-ascii?Q?bfckFMCEoA2BQOpemG8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3588642c-d865-48f7-9358-08dc961e3765
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:26:10.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYQ8y6dWHqapPzrwHjGO2wt/hr82OWP4CtodkfZfDkcEVytN6T2PQx/RA52I00Hrqt8KFjGELHQ/vVVVCmqFwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838

Add #dma-cells for qdma to fix below warning.
	dma-controller@8380000: '#dma-cells' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 4188faa59368e..de92af774771d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -828,6 +828,7 @@ qdma: dma-controller@8380000 {
 				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "qdma-error", "qdma-queue0",
 				"qdma-queue1", "qdma-queue2", "qdma-queue3";
+			#dma-cells = <1>;
 			dma-channels = <8>;
 			block-number = <1>;
 			block-offset = <0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index caf765593547b..acf3eab61b626 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -974,6 +974,7 @@ qdma: dma-controller@8380000 {
 				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "qdma-error", "qdma-queue0",
 				"qdma-queue1", "qdma-queue2", "qdma-queue3";
+			#dma-cells = <1>;
 			dma-channels = <8>;
 			block-number = <1>;
 			block-offset = <0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 524b44f424272..801c5b77d608f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -925,6 +925,7 @@ qdma: dma-controller@8380000 {
 				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "qdma-error", "qdma-queue0",
 				"qdma-queue1", "qdma-queue2", "qdma-queue3";
+			#dma-cells = <1>;
 			dma-channels = <8>;
 			block-number = <1>;
 			block-offset = <0x10000>;
-- 
2.34.1


