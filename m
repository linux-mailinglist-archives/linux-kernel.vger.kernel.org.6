Return-Path: <linux-kernel+bounces-303598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D34960FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C482B281E22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E4873466;
	Tue, 27 Aug 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMx0k2es"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4921B4C4E;
	Tue, 27 Aug 2024 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771020; cv=fail; b=OVyA6egKfxdPapBecOKQsQdAJ41tpqATjjT4EwHx6wCu57ZOZd98iEiY8R86Qdq1jPc/StpcKOtZ7cV5RTEshB8dOD+7q5ukYItbtW/2SKr0M4VphzJXRG2YDXTaQ+5cKPfDSzBcMjMr5YuePPotgD1qaiB8w/Az0OfCGASsALk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771020; c=relaxed/simple;
	bh=Cl43J/459jxmnouqKv70Ik1dpH2BLruuWXpkAszf/BY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RSjC+dCDiD2ZvkyZuYa5OZbkliZ1aSCRyPzCexK95jbWY29xuvb/Wy6Qeb2fJmoRB3yW497IiKqcOA3FCOW/0rziXjGJcBn6N9oQ8JQNqoyZybRcuJyO6ZmOy9QrUGbF9ZfbG4vonOVZowMTHdh0OZa/oE2GxuTmLpaLVBLY3pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YMx0k2es; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og/jBbAwJmFHUDrlKNYxN7gstCBxxf52+Pp9CMh/wr8W8YgkXYIf6JXWgrZ31azIy01EfBxosfP+TWaYh9kWDKCI77T2qq0bLKtzsQt+qlJrVqN+wOLHc8hdgcINwovVWSrBeOCf2DshWRpysq2UScISojL7UTXI7IB5pTJvSbFvtvwiFRjq9Q11R9F4xR3Nbr+yQw7fQk7fKvDpdRSljU0wUWalJ5iuA5y4Hzpu1f+386/FAgaX+MP99+BIpjRQEKRD7DcP6jbEsalP2xwv/kJe0cH4kyKmKHdUt5v5lO+LIfA1a9nJe1BbHhQ8Af3A9fe7h+Q7NexJUm/wLAmaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSu6PhzT5j411EBFgupi9cRFD/8Cftq+P5H4khBdN8k=;
 b=g9WNp+Pg8Nua5WxXL01Lh6rKVpKPh07CpWa5JxiL1vxdUOb17jebGJP9E1xJo072ouPboXcNcyQoUnZPOZdQQsLb1VFhUXseUCd48ZzZ5a1XV+CxV3N/BMvXyt5/cU/xfo0rmCR+cXHxPWquH5o/qSUnoG2j8ukLoKQ8P0FFOAVc1n+IWl7JEGAz3GjHOS0wRMOEeiY+02mUN0JnjzrtXFUPVqp10sZprD6RiJOzftmdJ1e7IAvIfIXsnnsaHKu65CX0tjggwDgOB9PoKcAz9XD4s0IOJZKtWGE225aslzwc22sQg5m3+bn1+wj2cmwUrW9uYCra4/X/LgVnXC5KDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSu6PhzT5j411EBFgupi9cRFD/8Cftq+P5H4khBdN8k=;
 b=YMx0k2esoE5YlJfNV/4y7YgEQIYp8DmA3EcJ0BtnBGfBO8Df4YYpViU7roHE7pUfCCXlr2ooXepjVzDAtLuDqeUojK04L/qUFoAmpUtFX6nS9Vg+E0ta7C3D7EJ7yaPIjfOHIZV/LLtSmft1PhJOm6CDK5MfkR5my+EyxJp4i7dfetDkCcsF1IZAxQZro2oEEvgic3pqwUY9vZ7v2sAEj4/nawloV8QLKFqpE6MJLVhr26YzsNsSCJlEB9kX63zvegHse9FvLSpITZcGJMD3POjy7bd/Tym9ZGwoCiW3ZkkTslBxmsms6ZESo6s2uFYkECxkO5UrFEDcpd3BVb/6Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7031.eurprd04.prod.outlook.com (2603:10a6:20b:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 15:03:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:03:34 +0000
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
Subject: [PATCH v2 1/3] arm64: dts: imx93-11x11-evk: add io-expander adi,adp5585-00
Date: Tue, 27 Aug 2024 11:03:15 -0400
Message-Id: <20240827150318.1001050-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea960d3-e2b3-4da9-f36a-08dcc6a96bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MEXzaLAXZ6C6BNat1dXQC3mOQ7020ytB+sVJn2bOR9a84w2raRMiJNiWhpCF?=
 =?us-ascii?Q?j/b+isxDlTHpKNooXuOMsWXeQvI055XJZKTE+qTk9ecXdBA3iOH8xS+ZbtH0?=
 =?us-ascii?Q?QpZhPEEbt4fWuAUjri0zikCw7fzVeu0tZlVpv6W27GuJ3hoLpSKSvV+FVVsY?=
 =?us-ascii?Q?CKTttzVK2lTPkq8Ubcgaixa9LR6bToHNSGhnJmNKUMrRBU7hg8IlCl+S2FKL?=
 =?us-ascii?Q?eA+nQM9ID4nPM0+89BgyDbPLbEh8TSVmnVJez43gi6Z34aRCs8JD6FV9AXKd?=
 =?us-ascii?Q?zqyNoT4Uva59PZUK8P9CKp9BwAydfriMhwysxXTUxFaQHw0J9jKSZ8iVq01w?=
 =?us-ascii?Q?he7yZZ0Jb1W+OB4a0O488TlfCXcuBjnsumkZX16TCSQ5+ohjNd7ojhojTV0P?=
 =?us-ascii?Q?jbkbhchLCKPS+eqd4OljTIxwB0Ev2hqn5HUI6So/MLAA+1+8mkE2wdwcZ+qG?=
 =?us-ascii?Q?5UlaAe7ufkDsXTcUCdlXlKW+UtzIFvBR1eY678D/NsbVlDl5nB4l2FT+3hcc?=
 =?us-ascii?Q?Rac/Q6RKB7NUJYJJTTaxc5nbo9IIq62CTX3yCx8prUkckOd1BGPDsn4jsosH?=
 =?us-ascii?Q?LuZL1S87Q51e/5opFwoSBmC8uOqSaRISVLvWIsHCcIX1wYoXrzqV6+kT0kiA?=
 =?us-ascii?Q?D0yDQKfOM2KzbjrW/mK+PcXmEwKeYFBm7TLGA5Hd0o+rwTuGkWZza6f7EDFr?=
 =?us-ascii?Q?nvsAMaNBFNTUmhWwc5amMoAmKH7g1VB1kY5MBaPIUkKLruD3fKG28Try8sqQ?=
 =?us-ascii?Q?bLM/HBzMEgbChJzkmy1JW/Y4itO5X0GRjyi3087F8ACC1LU5hdkCYm3F61kI?=
 =?us-ascii?Q?fsAB9U069maauyHMUyoFrgPMJK6ttNc9ZIyLQDGHyarvwXLmwTV+ZCC7maF/?=
 =?us-ascii?Q?S0bd/8LI2z2D/Y3C+zhkR/7+4Xu5s3487DD1Na+trjVG9+2z/Lnds1hkOg1a?=
 =?us-ascii?Q?UDcCIUCCiaiHLb03WcgWYXq7ZpHbtIt9GyVngXwrJ5ni4pQYXtz3g4Dxl/73?=
 =?us-ascii?Q?b+E10+q99uHbD7LsA8fWDYZz836HHvmw6sIQOW3VMLT1GIsnDokHGIMI6yO5?=
 =?us-ascii?Q?FZ+1UohfFaOPlG3f7n+MKtEz1Z5oX+GVTFZzgdwEUjCOacatvHtdDIsjjqb9?=
 =?us-ascii?Q?hEqTMcD5onRzlWmUPEdRypJ1GaWXt7IdLivOJ35QAM6k+lqrO8SrhCZlyBp3?=
 =?us-ascii?Q?NyAtrnYEEjmAHXDsyLdcHBgTbPmB+jc3qAX4lbchg7cuXVeIUZ9nBDTI83fm?=
 =?us-ascii?Q?1FQGiwO1o3oJ4HTrdTkaZia9Ovr15gGsNMzGLnXSdpiMWGUNBjfUUoWXUI4u?=
 =?us-ascii?Q?3gPVctLrcBLdpXDSe2TkMLIJruyJ0moLy8u2kpvCFWhAT/8ioVBW24ZHoxQi?=
 =?us-ascii?Q?FAxCDTcaC2LnRD/jfR5kz1go8rh9Z9PZ5Jyk0SPjrZ6Ex+y9TPsk13Raar2J?=
 =?us-ascii?Q?9V/BSfW95yg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnT6t+3+LM1rnehT8X4foC2t9qxopJlyZLiqbYFezs3hpAdkKBNt4mf2co8S?=
 =?us-ascii?Q?m3+/upGExt5TMvUH1bOrT18SwK2DyK78SJkEvI3MoADSARdes4B6qlrTbKA1?=
 =?us-ascii?Q?ba1ypyMAH1AeUAISTCsr+MsPYhUOVZ994cIGl7dZei15jw2HLYzuRkaTIWzE?=
 =?us-ascii?Q?mWit7WdQ/1FxUrIxgDm2iKjfkrIzA9+eVIz4CBDl9ce3NNKEePO7K973lEoo?=
 =?us-ascii?Q?eGtGsHj3Jkuw6a1rLOWhDxVib8W+QlHtPjvg2Mo4MQAxyGlfreY3JHA4hisM?=
 =?us-ascii?Q?FCve99l1GgAQg2pNIRgk3vjW6lTOUwS1YzGYuWvOHLIcQ/uTu8LimO02NUAQ?=
 =?us-ascii?Q?MDc+IsEcP2kBUPZZ3fojmaY5x4wKZla4XSGJvjiv1ZGLk/oy/9xjPKt3YJoa?=
 =?us-ascii?Q?CeHigLfLBuoTSQWnVIMFkI1rte0YpYzrUFnPx0SUUNuFyfJhI2mbhBsvlMx6?=
 =?us-ascii?Q?PEAI/METoBn4weYezJIRIdn4rW55I+K3Ywq2T+yN+cmsqoL6fAkTekBa//uj?=
 =?us-ascii?Q?OOGK4IhoxXwbMKAV1d1RQ+3MTi1Q2BYxR+JkdOtRJ5hDKagOuZhuC+EFqTEf?=
 =?us-ascii?Q?qnvqD1/ZGl/OQ8+Uy8TXkr17P3AojfoV1QUATyIT1yXegzNaafiBCE2CIpMS?=
 =?us-ascii?Q?Mw57b5BLvvnIb9lWLTvoTNIaUxFLFnHr9mF51P5HabYWYfE8gp5VkKrIWl1s?=
 =?us-ascii?Q?bDyCD8RmWxxJVAusweaJLxlzmUCRWChG1f6LoxjUNIqNghrzN+3vgRxC84qA?=
 =?us-ascii?Q?BWKFBSlsZ2M4Pw2PxUUBBX39XhlSJWDqLWYTxHP6rCLPJ4XQcocg+Mu/S6Rf?=
 =?us-ascii?Q?etjl5Y1dsDS0eAvSSh2xYAVTlGmUSOLdfs/0wrDnUhm19oRUF9S5LNi359C2?=
 =?us-ascii?Q?z56IKAloZJoR43QadcV95xueWFhME5cDNeY87wkzOdxul/0MsDN/98a5o+1j?=
 =?us-ascii?Q?JvWNETTMiBtPDM5B9xTwxFEUNfK+R+6K803d29XRS47kD9B1EY13m5N19glE?=
 =?us-ascii?Q?kfwZjjlFDtqYd+p1PrSbI4WkbSnMap3Py2KJU7oVWml8C2fwW3LlFpUXwZKE?=
 =?us-ascii?Q?PLZelzictbpk/3oz/XmMZXPE8swNmy7i/84yR8XtaraiSz1rT8NZQ8WdrFrV?=
 =?us-ascii?Q?/f8tdv9xFhVzP8Qh/CuOJKsyZAuyog3xscJXppSGuUKCHcbK/MTiRRUw/Xdr?=
 =?us-ascii?Q?IhVMLxUH3ST/kwDUn/xnPOBm9W7rW7+V8O1uLCObCKMKI2/zPmZWci9sNoZa?=
 =?us-ascii?Q?VxSYQkDgbyL1Bknkw1IIT/mPjrOvT1PXpq4QiTuOj85TjeZpAPiK8Wgj27XG?=
 =?us-ascii?Q?7OCKAt+YE1xRaodBTFwzLbxl6oUfH4aegbVDT1Xc7YgOxzMeFRSzwfWp/Os3?=
 =?us-ascii?Q?nSr3wRDv+fllSPUNcXZCoctRL/w2hW1zkqHDpevWgk4CkTz2EykaHtH5uNzT?=
 =?us-ascii?Q?jeXQvEbmShxoUe1yr/vKJQH1cDU/hDnVIrP/8lATn8zbpPQzgQQyH2yIikT4?=
 =?us-ascii?Q?7YpSW/ct5P71jE5hNwczGsgJnxV1aqZo644h51LuAfVxxghBBCf8xsZtDFpb?=
 =?us-ascii?Q?yqHL/BpJPtFUzxnMueQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea960d3-e2b3-4da9-f36a-08dcc6a96bdb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:03:34.4191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlRVmxeb5IDHe9x6ot+Dh5IjvN8wLU5F9ZHmeCfNYDC2ZE7NwHSYIcevK3bh/0o/58anydZk2HSnh6xXXgrXgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7031

Add io-expander adi,adp5585 under lpi2c2 and lpi2c3.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- none
---
 .../boot/dts/freescale/imx93-11x11-evk.dts     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 60eb64761392e..7629b6b44aa43 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -302,6 +302,16 @@ ldo5: LDO5 {
 			};
 		};
 	};
+
+	adp5585gpio: io-expander@34 {
+		compatible = "adi,adp5585-00", "adi,adp5585";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-reserved-ranges = <5 1>;
+		#pwm-cells = <3>;
+	};
+
 };
 
 &lpi2c3 {
@@ -310,6 +320,14 @@ &lpi2c3 {
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


