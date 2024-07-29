Return-Path: <linux-kernel+bounces-264956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C393EA93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15A9281487
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71236757F2;
	Mon, 29 Jul 2024 01:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQF80yXZ"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F2257B;
	Mon, 29 Jul 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217281; cv=fail; b=Am5QyK4srdHCd/CONBbUUbbfNUD5jOZZD4Q9ngqYct8JhVgCxwAd/psjkWNP5HYZZZzREHJiO0NsVLaVSiQ1nkf09ftN7YJkn9d0ZsGi+Fx7Iw/3U98R2TCsCEf06cAa4X3k6ezG3HjLYa2aWCzP5BjLbx5EuZ2Tjf6YlctQMi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217281; c=relaxed/simple;
	bh=WpdYgk1/SiEVC1xEao7qDa+ttQ8mL2p9aMXBX3NV3fk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j4QQgPGjkISgKVWjjm8AdPHEbmNzwFIRzMFwIt9fDe7CLmyGTOFkot90BjsMun2J6t74lBe7dHI79YS1y+r0oos8kgEdMjzmigOmV7dJ1QCPF6ciYKa8h+S5bDZAdlaZqy1WRj8E94aZqYLlWtb3LDEL9zXaDj5UwJrE9lssJBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XQF80yXZ; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A60XFOsWlxcW+y2vcfoIahwIFnyt0mCykqwnrVCzJjaj/RbyPIDyTGbOU4+kQc1C5GRprNv5alOin4PYCJkorVEM2mIwoOS4MMs3pGa3HvqT2nDYNNaSIMcjekkczdP6fO+r41HWvYp74PbdRtg/EzJXLQ4n4I89t/2QprSQYIwW1IAwbBwUdJpSD5J7GwgGt1Mc6ATBc4MIbnwavIc8Hj8lIg8aLeERcd3XYBMrByrwVJG9SJ+zAqKYaC0hHHYMiKhL3vzJAYbKzBFpfbj6I4rDRrkptaWoYe/USuzLLvMxx21XiaMKPM1LDRDZe58M4n6+tcNKudFU99IQnSdNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eULak/smtbcsdq6YV9bIQO1mZ2MAlWkoNwuWfKATXFY=;
 b=orlFX+AYcVikxKnGZ40yu5CLTazMXOzkQUGdcwBmst5pkgSsiOTZTNsFT4djjc12bR6GiS2+ZXxrZcXT5WxRe3mPZ6Q6zQWCmANYTD2wWT22CfuiAcETm4KzNSCMnNmO8+Xn679SYt7nrROQ4DkZa1knzTavs4cwknc4HHbhRxwvaP7opvXhjqr0Sb/6/IkJ81OQuqOTJMizv3xuxUyc892jHP+8GqU9/mMQyeaAXIWC3W5copY7XYkz/FyBsAbQCSlsQI8YeKnqXEMG4HbP7Klu6hfj2c+76U6hESZpqDzV91e3gZ9gO/OPzevWkKAhp2HejKod8B7FoptWYNfpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eULak/smtbcsdq6YV9bIQO1mZ2MAlWkoNwuWfKATXFY=;
 b=XQF80yXZkxqQekORr9y3u/SKRLV5R2Kv4lmcDoniy8IrJ9f6ft6/SXF3z4dAwJ3S1Z2TVSWrig3hLCNdR385bKTefDfMEd0ZmK7siu25gvKiBOCQcIlJB/W0fZYIe98J51wYrYThuqlvD2QABUUobxXFpbkjxl/zkwNLPWmDz2cIH4XG85h3RDfkHTDI6gyQCmjp2EBxvbv4RzkbHWudERAM9LY7ur7scr3zI7jMIBQkfrR6BXuTdRAfmYohbAvkR1UOffhQvdk0acJaxxm1ulxOlPOFk0/1fpVmuE2q7LN4AtnPdJKC1bH/pdvc/r1ang3Q1+qF+7hOvduL4i9p9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 01:41:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 01:41:16 +0000
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
Subject: [PATCH v2 RESEND 0/4] add NETCMIX block control support on i.MX95
Date: Mon, 29 Jul 2024 09:27:52 +0800
Message-Id: <20240729012756.3686758-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf3e029-7225-480b-dbbb-08dcaf6f8960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?un87ujILtEaEXi4g42AhhPUVLSntXqg+Fibs4JJH4eaJQpBQBrF4P8R44+cA?=
 =?us-ascii?Q?gEY/IhJZCoGXIqbxPx5bUgzm50dPd9R0WgGrw3ggFS2VKVuyBJcur8/PTkLG?=
 =?us-ascii?Q?sz3oZAlEZeeBNffpI5tX65xyJJQ1ujLJQsaTXAnZ+SVsr025aGL94gNwF3Gn?=
 =?us-ascii?Q?mEhFsI6h7IdYsRZGflP64ti22/xhiIvNVK6M2n4tDVMhioW6HRJkmJFLJjDW?=
 =?us-ascii?Q?zakJWVBmMxPcZeggXsYMeaRl5wYRDZgIKjNJPa8CKKGB6Teo+MZt+BhPF85v?=
 =?us-ascii?Q?L09iNQv6iulf2i/SatBpadjxj+upPWitwmVqJJ3b5s4W/JagkueGnOuipr0c?=
 =?us-ascii?Q?kJdMbKnXuoqmUrxsR2rV3iszI86FBpS4xszpaXypVo+vQpN4d4/ESAgkQPzK?=
 =?us-ascii?Q?dfnH9yx7MRcG26bxSADu/a1c5n4BDIX7pCPIEYjTJDFQNF/450lfltFbSFCz?=
 =?us-ascii?Q?QOVhqiRXcH0xJ+S9PF2dZ2kC1cXZkUxwhL6oZNLM9Sepj4ecFHhUluyXPyTV?=
 =?us-ascii?Q?QlxqKN6LBhtiizuDCGkNM554i7pgGpHzLFaSRx2l2F65xjufQY/wA9ZFV840?=
 =?us-ascii?Q?ZDW5jGYEVhcHH+GSxzAHRdNyAYgVjveFLX/xKPBj7eoiAQxlIfj/dt4Qu9D/?=
 =?us-ascii?Q?AOxFnRjJJVFqNae7zWHCkmSJaqURveS6gtFa87PDDPFnjnyBUVFj3MpaHoxN?=
 =?us-ascii?Q?k3mQ/uDzJgJzeslQKDUizp+LloWlf4tNYn3MQN3HxCXninnguH9uyisoZg01?=
 =?us-ascii?Q?qjlWXdP7Yh7a8G3hU73tWpx3nMXjGkArPSc/R+0jvcle2Ej/MI+ze12P+PL1?=
 =?us-ascii?Q?vvXotrwM1DciTFWsG5JMYDcydf0rH50mhIqUAWo4bY8jmrFiCnTh9a+RIC1s?=
 =?us-ascii?Q?0LPHTeNFM4ypMG2ScIOoHXvI+/qO2qXpyxy7ctfb5X5zevNB7M6EcFBMsp50?=
 =?us-ascii?Q?bH0oVZSfau922extEGZ0vbLiBoK54ZUVxY0fjhwhstcrl8/em67uhJHDr2Av?=
 =?us-ascii?Q?PZARAq9+dWs6X7DQbHGbL4KqbVQG0edlBUlLcxlJowZIKDeK9LIMKTjxuF3b?=
 =?us-ascii?Q?0m95jukIj7LrrWGNfUP6kMU2K+p6BGXWQ8VQheYYtgBqOkb2DLymToRnNK5a?=
 =?us-ascii?Q?Z2xGPliDeGChUMevBjyABAs1H5ds9He+BsMJBxwYz5xdQN3tpdbgXSb7W5FI?=
 =?us-ascii?Q?REGy42PALJp6T2p5KWC/EZdIruDghAAypAOy/x6/WyqGo3KtQTFLUkgDBrlM?=
 =?us-ascii?Q?xVPULU97WlDZQl3PhTasqBIrddyYOWpvF+vK3TyTwkbCnvMvPJAA8y/wZGgi?=
 =?us-ascii?Q?91EMarQkud1O4QYiykTpxLccI/JStPs6AyXqCL6qkm14K+UpByuRev1YOOCS?=
 =?us-ascii?Q?BvLoUw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7IM1XnIpN2266lbOMhMjGSGhNjCcvS4iSNWd44Mrxrr9ATcspHuyY/ox5iD?=
 =?us-ascii?Q?9iQtgWlFh0bQapCC/Ofx2Bz2cE8NOtPoWNhSVZuUcr1Nu6PizMW4M/PXpSSm?=
 =?us-ascii?Q?mjXNBGWjEQBn2iIT0kXg+wdrgjx+65mxf56jXTpZIMA4k8XSxmgx3cNlDVlS?=
 =?us-ascii?Q?1vFoRq3JvKTN1TnORSUQrXqqLPTc2j6d4PBU64OW1X4kJgOdtHQRjd4Fi4OT?=
 =?us-ascii?Q?3O6hUQEu08E3jApZg14QE+WzPBZ6crwrAPKQWtfPLvNNEhI9xBicguP3prDx?=
 =?us-ascii?Q?2iBwiMZDmVZalS8sUXyPl/RJBiVZ/fc93T8+fVojT831gjJPX+rht8hMAWio?=
 =?us-ascii?Q?NHB/Bo93yCPUZ0NJaRVH4nTMqtTPWbVWQMcvIdIfXXg5Qmofuun6AaU+jg6D?=
 =?us-ascii?Q?4il42MNUGLhLGE/3gM+4S657uJdeBQEFSZ7GN3jY7Cpw8dT/xlYKnYoMMYV8?=
 =?us-ascii?Q?9Vcp3rgBfP/fjx1J46xADU1LlHImDXuzIthIL6ONecOIwiDHxj+BsWvY2bhA?=
 =?us-ascii?Q?XZkyQ2AemFXBvRVfrtKpzIpOdkYP8rtKDxUPlxvucVLUg4EZaPPxa0X8k4Ec?=
 =?us-ascii?Q?vAfGBSaFJIxsKO2a7ZVXlspwo0GTPVQOJonZV85LMC7iczhkjok0JCvtqZ15?=
 =?us-ascii?Q?UHh8V+/bTtiiW9LT/ipTOvtSyWq9Wb9WrKfsau8a5s945cn3+evzQWbtIw8/?=
 =?us-ascii?Q?347G4fgKA6sF+d2v1FE8yq3/fiXj/olhzigzYoe9KS3046JUYhOZcWmxTeBZ?=
 =?us-ascii?Q?BgmYBle5ep8tkBlWFIQuE1cqfyN7en82pr25ey7Ar63ROT0Kwei79ZgFS5ue?=
 =?us-ascii?Q?CMLLlXUhnUG8HnIN8bnim5SYbEkx8xTr+IPPpqCd6Ko529/0QZXngaDSLrLm?=
 =?us-ascii?Q?6WUemq44Rgn1D9eobUQzGwNvHwmBqPuHHc2XuBkoNGALWzakd8C8uhB8asAe?=
 =?us-ascii?Q?KVc8xTMFpsRflI0A1ZlcoxAEJNbi0fZOjsy6uuSUL97fvQ1iusjTBlAUn8O/?=
 =?us-ascii?Q?qXa8mjKNiwnL7XjSSgksTL3MUBfuL0ItOtUI4KWVgRsTBaNt7l1LE+lx8hql?=
 =?us-ascii?Q?myIcsTzdfiTTmmKt+iHwGL2J4pC2gtc74H0ZC3aGOQzOk4M7N8wkvS3LvH5m?=
 =?us-ascii?Q?lKa5jA0gMtChCTN79W76p27QVYkUKLTP6Ag7flPq2AC3epb4BrKJlqC1gFJI?=
 =?us-ascii?Q?DXBCv+TasPmdotvoqFCmtiGwokfTmgyoVwJQe2GF3z/xa3IpWFfqafEs8JId?=
 =?us-ascii?Q?m/lyTKpziMuYQdJ+ILgnIVGfIeEngH4wPP8wrdTOCd+nbBkJuqCTudaYDYcF?=
 =?us-ascii?Q?CrW6ysTLBScqKj68arTG2R1louIZrT0pX4sXLPIcwBEw6ey8KUKRzIf2O8x9?=
 =?us-ascii?Q?92/bz0KxgEfgKtcYqjsIhpUkBCb0VY3AzXcRIPU3L8tZ8UO9MV8V54WYQ/s0?=
 =?us-ascii?Q?3PAywRPsFY4EHYTS+TnsqTjeOcqCwPmtSCrarxyT0HCoAYRFbNyxdV1G/jKs?=
 =?us-ascii?Q?k573d1/NIKwm8eqwRSo3tCWsmbuPGYv+/+lPpUwvtKETFDsOiA1P7uDiq5bZ?=
 =?us-ascii?Q?d4g5wG03Cpe5ZfgwSbWUGg2AHaa+uIypBnA+NFXV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf3e029-7225-480b-dbbb-08dcaf6f8960
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:41:16.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEKrlwpLw0kev56CdMcMQl46fR6JEjFzN9tsNsUuqRv2LbaqzsnNX05ZGedhflve26PUhKvUvL2Pgz4iooj43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, such as MQS, SAI and NETC. So add the
NETCMIX block control support on i.MX95 platform.

---
V2:
1. Patch 2 is new patch.
2. Add rmii reference clock mux for ENETC0 and ENETC1 in patch 3.
Link to V1: https://lore.kernel.org/all/20240709073603.1967609-3-wei.fang@nxp.com/
Link to V2: https://lore.kernel.org/all/20240710084345.2016687-1-wei.fang@nxp.com/
---

Wei Fang (4):
  dt-bindings: clock: add i.MX95 NETCMIX block control
  dt-bindings: clock: add RMII clock selection
  clk: imx95: enable the clock of NETCMIX block control
  arm64: dts: imx95: Add NETCMIX block control support

 .../bindings/clock/nxp,imx95-blk-ctl.yaml     |  1 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 12 ++++++++
 drivers/clk/imx/clk-imx95-blk-ctl.c           | 30 +++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h   |  3 ++
 4 files changed, 46 insertions(+)

-- 
2.34.1


